Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90FBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8548112A8FA;
	Thu, 30 Jun 2022 19:14:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959AC12A913
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlgKsBIi0a5PWgLeaw4z7lXXxpEtitM4lFemj7Iz4ItNryGIuXkYNVoNpGqVQ9wCNYFPpVt0O3FRh89MGelFh0f/EW1CtYXMQecr33Ewe4Lz+Et41FUZp77l5gzvqTjAGUlE35Es6b8LWMBLoYhLoMG73iJ1GqzLHEQvNDnBdAfGL5c7SmtyUlt25b0HI1GwUhKE3uWSFAsJExkcuj0OnUUMgmWXCCA/NF4rblykSUy3SJgzthPqBpxpIrG7jvwRe0of+hPVqoN1ygNC64dx/pCiBmiZGMSiK5vC4S6PW/B2V+jj9y2gTXCWuDv/JPY2KfEBEAHWasz4J9LU8N9UxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPw9vtrmYl99zZM/9ZMABQSxC9iZMUkDRFVgAYBjOgc=;
 b=iz7bhemXY1KdL2JYahJG/+aMpaJrx1C7TTGhWVj0v1Umr20GGXdMkrDSzqgpTXCFFoYnLu45zyNsXooKTZgJtmROoAvTCZ0sSlMQv4n9AtYFp7d4A0ZuCm3vDyzF/k/oPbLrbGkeq+dGDMEeCVdcXBdEk6ykzdQAsWTi7rOKiNdq2EdwjtLUFRKkdeXLTAFJ1jVPm7Ise0hMyTfdzxrYYR/Yo2ue1ga3J7Ln5eqQMCCQDGFdNt/Akx4ZiQmzjPNRMo48SWDwjJ2Wd5tuhRtKv5zdxPwbvVjHe7Qfh0uyO7CUW8VLoOxQNbwOShx+Fg5PGUSrfLJ3rkW3KFDYVNU86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPw9vtrmYl99zZM/9ZMABQSxC9iZMUkDRFVgAYBjOgc=;
 b=1ZlGIXTpZiKSqAvNC+SizsGEbbf7Dl7neXJ7RZ94Yp4kuLaWgPv9BRFvi39EFJRm4/Slp6PDOR9HeEiiDkfBL028iQN/HEG8UwWPiNA/sD166/oCZjIqwXRLZVeHeb3l1f0fa6EhyoLUwH4mF36EHGIpp79R5ehFPvXdQeY+SIw=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 19:14:30 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::3e) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 30 Jun 2022 19:14:30 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:28 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 40/40] drm/amd/display: 3.2.192
Date: Thu, 30 Jun 2022 15:13:22 -0400
Message-ID: <20220630191322.909650-41-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12020745-7551-4322-8d89-08da5accc20a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5748:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6Qc2nTVWnfAHjYto8VIvCkOZZOtT4iGNpt2O6zyw9Tsgxefo0BkEQrZHFzodhsgBRps96GDnLZ9qqEKWiMMG18kVyBhppLYMQgQAavy+FArYfEKx+X4ZOidKy0156F8OKAWODwboBwZDM65E/nLhP/w2QlMPBunCB9Tnb3i38XfpHA8VojtPUOtigC0b3XD3+XwrmeRos1bW0NA6lLJt+p/SVYV0/ecTh6QdYOQacU417XHY03vaIPPghGI+iERfO3pF4c0m+ZDCpNgkHHlin63+7DyNdYsdCr2YVUV35AM2he1FGamfBzIWSFcrA6HhV8Do8hWzndLJqw5bpad8AlfpbKZIPXXaP0qQCki3MlSblYVZCdBLAgYMgdRI/sMDFRcp2jX2m57mcSlSsnYfYHR3Gk21v6RdrnwZlQbmdXECjd3xqZdVPlJ7uIuUhWoXWV1GQ2x4cFHya5gQAlEz+uczGYNQ5votcWQMwEWRxliRacOiEDNP4kez2p/OJrz84MTPRbk/RBb13ssQe91Kk46AbBgpN24rMjWngfT2lIeLuCwmGwYmznE39D+DiqSC0CHtAKg5abccuWm/Vi+6nr1J++ZPAvk3mlXk0KA89NLbYauXuL+VWyV9p/RuCMHECqdFBzb6Ocut/8gzpumsbTFUjZs/DMq8DlkR9tFqrM5MjxrgVoisyRp3p7sYr+9VVJN5sdreVX8I4RcKsFtkMR8AI5guE3ISPkluO+DvzLtJuqcE+L6zi7EXHVOk1CfwCIDK6oIybdqE1u/qe5ph6x1D+Ivlz+97Hnsm6/vzjCd975Um5w+/mWEpOnIe3fiXnTBXlP103lzllPYR0qaultgo8Muna3QRCkoYqDPKM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(40470700004)(36840700001)(7696005)(2616005)(5660300002)(40460700003)(26005)(6666004)(40480700001)(8936002)(478600001)(36860700001)(2906002)(16526019)(70586007)(81166007)(356005)(82740400003)(86362001)(54906003)(4744005)(41300700001)(186003)(426003)(83380400001)(36756003)(316002)(1076003)(4326008)(8676002)(70206006)(82310400005)(6916009)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:30.0865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12020745-7551-4322-8d89-08da5accc20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Program ACP-related registers
- Fixes for DMUB, DPIA, PSR, and others
- Improvements in the pipe split
- Add SubVP code
- Add basic setup for FAMS support
- Improve BB capabilities

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a9c59669dd1d..02bbc90a2c80 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.191"
+#define DC_VER "3.2.192"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


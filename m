Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29295C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E729723B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E729723B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5CC89BF8;
	Fri, 18 Dec 2020 22:30:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1B089CB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bREk8ghviU4yBsaL34M/3ztkC7FqjMxHx5IYa0MSx6y4kL7Js+j7omo6eTWnP6zIp6EfN1EopwkgIr4QfC0iyWHmxLqf1mXEUo96lWBmHGr34EtvC2id8FRt8EAUZsII0b2ep/rbxc+Bcdd6va/PV5pvAm4VwspfExfau7lqmhksv+2vTUx6f7/dlQxIGqrq+6SMAXZ+bZwZ10ags4r42RKdhhqr23haH6QkDqYhlpZnRqYWecnV+jrfQ22u3Z1wl69CeTLyYVsqIZuolOdz8pkrRAoCjy+ibrnqCTKY1WaLl//SxRrPDQonjTw5BpyHGs9WSNhFw024THbje5d7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBtVrmD7ncM+QMDzirHRwBgln59jbDpWnXtBLdI6vkc=;
 b=cU7FgnCFXc9hdqbsHkArdCndcxjqJJunBHnmli6erXXrMZRNgYCYZHzknocSVHikGVVkVavd3g2VuugSWO1Xbtt0WJ/1ZHDxZ5/TQIdEZtzfYxGqC2XpwosYGt3rCxh7XBWHfU90ftuy2Bv1CgevA5opo8tYZ+SiOnr+pIThM4jG+BonvJOPjBE7UhA5ub4Vj2028K9QcCWK8apZCBkaBgfDzQGXfxRR0m5GOAxZ/QxRsyD7HoZJN66OHw3KkhMZWlf/1qEff1a+71LElzi4f7yQF1HlxHDQDA2eHdeyrsqvTL+pK3EsufDaMJbLOnZy1my+Z0Lvx0OvaqBNQ+462Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBtVrmD7ncM+QMDzirHRwBgln59jbDpWnXtBLdI6vkc=;
 b=DS+5YUT27eGPcLNjHzhyj4aIiGJKXoxOivtL0w/JGRWHI8jEiegyfzhVNALu2DPNWJrSdMsqDGsP1vgEsLknfVc7YOKQFh8w9kYG7NfXIUPheu+SID//1Lz5SzV1+QfO0X0CkEzKccnHo24M3J2WqjTyJOYvvB7Ynf5W6t7DTj4=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:30:12 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::2f) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.22 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:06 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:06 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:05 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: [FW Promotion] Release 0.0.47
Date: Fri, 18 Dec 2020 17:29:02 -0500
Message-ID: <20201218222904.393785-13-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 950f9abe-5144-4609-070c-08d8a3a47b2f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4119A5582DF05E040946A221F5C30@CH2PR12MB4119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXWtGnURaqEv0a9JKvg1YGsudIyMQ5j+n9XMfG4tOTKFESpKVVySSgep41KwIYi5XIPjrBGM9PP4xLGPVbd60a54Ded2+BHb5umJXGZrV5WR/raalQQbXfgoDyHq+xH7DDBUjKUOB9He7D/Rd7+7F5K8ucnG8/TrnlXeKzj3E50b06KYnw8T6vnF60dJ6pji/CXe3lfBn3v7nEoJLI+kYkg+8g4wmmRV4cSrSa2YLA5gbxi5a0RoGsLlLb85k2A7YUu/cZLED+mZCZdCUEiTeaYroTURq+n0NQa5BER0l1HmXAA4zPAtDtP31SBXALtHLjNQKGGxvn/qGXvQT1v72Bgyc1lp2X3bonYhmCqe/U9xhm3O/fGMypAPmigPBzv8vPrdgK5LODFNg+aL04YLTOIORiVKgIql+Ngscwa86dVSeuFsWKYeZCDKuRnMPnzKOxtr4cw5rvGz5I/Pq81QOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(336012)(2906002)(8676002)(36756003)(4326008)(5660300002)(81166007)(426003)(1076003)(26005)(83380400001)(316002)(7696005)(70206006)(8936002)(54906003)(186003)(478600001)(82740400003)(82310400003)(6666004)(86362001)(6916009)(70586007)(2616005)(356005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:10.9129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f9abe-5144-4609-070c-08d8a3a47b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

- restore lvtma_pwrseq_delay2 from vbios integrated info table
- restore MVID/NVID after power up.
- Enable timer wake up mask when enable timer interrupt.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f512bda96917..249a076d6f69 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xa18e25995
+#define DMUB_FW_VERSION_GIT_HASH 0xf51b86a
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 46
+#define DMUB_FW_VERSION_REVISION 47
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

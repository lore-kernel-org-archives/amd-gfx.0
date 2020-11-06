Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A3C4741F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B24206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GpI1LYE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B24206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C186EB5C;
	Fri,  6 Nov 2020 23:19:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A546EB58
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Ss3znflTgMzo/VTgxmzGHrgN0fMILWiB/Yc9zJUUdpzGF/89sdt3pNLmP4/dpxrb2/vyKSfoXbu52L1xPSqjZTCzULBMhgVZZArwt0J4tP7L9T2OJ/Pm+N4+7lUp9DB934JsIT2fLgA2+ojvO2+602m4WEGIMaYKNwVRV39c/lw1bCm2sdJavWS9Ur3UZgHzwevyBhQ7cAl9msOH3n2Omb/QlNKqJqFXH+HpwO1IitBcJZk1m0gI82DuMsopNwc2N4/V6uRy6Rtp51WvB8TaOslwVeNRSW1Y9X0ObEDcqYQcw8T9WKZsxCZiwbS6+lhj31VdvI7ohIx/1r8MoMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z80N79J4LLjC1E8tkuoBtFSTWdmtL2sZtth/9/bpnaU=;
 b=ihm0URDOzlwfXveE5V6uUlZE9BfdoHpLN2epFYQGb76Nryx5zf7w+epSTq+huDbwRVTGY9P/E3wIarSa1wV7lM/WZ/ZLIR3u5DSmEXbK5yccPiDX7RssJVAxf/VKVO4PJpOi10fm4+UW+dAEgz30cBouT7unAlmdoqCKrRUNyItJ3U8+Qc2zPe0WfIdM2qoAuKX8r56i7ZvDetg0O2RB4Ky7Esajwecq47ZfGJHRB8vB+MIlRsHdB1iare3+E07ifyDXYUYUoWViaG43PuRNrl1qARLLLaemNI28ifGWB0/vXMuO0byk8GYAb4ZtLWOUho9bArf1XH6GEh2c0Dofqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z80N79J4LLjC1E8tkuoBtFSTWdmtL2sZtth/9/bpnaU=;
 b=GpI1LYE4LQtKlVjlbkMwpzFbuFwg/biTT6IjFJt81lp1eBXb4+6hLR+YYcUWz5bX+vdeO+eGZHmvnh0IIuJWjmbUW104kykO9a2fuL+0Vjw4RfkxBnrqxYmX6PFO8G+W87euAgFaZfS1pWL3Pr6HKgR0GB1P1gQfG1N5Z8cA1eQ=
Received: from BN8PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:60::20)
 by BN8PR12MB3347.namprd12.prod.outlook.com (2603:10b6:408:43::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:34 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::1e) by BN8PR12CA0007.outlook.office365.com
 (2603:10b6:408:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:33 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:32 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: 3.2.111
Date: Fri, 6 Nov 2020 18:17:08 -0500
Message-ID: <20201106231710.1290392-13-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a05172d-0cf2-40cd-3e42-08d882aa6c07
X-MS-TrafficTypeDiagnostic: BN8PR12MB3347:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3347BAAB6072DF5FD1E52CE2F5ED0@BN8PR12MB3347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fygy2vmXZ/450vVI4aidFoBOX7+4q7fRHeez9LM4GQyjz4qD+6iqI5BIW35PW5I5d6VmhBqtQlmebOpsL9LWwyuaNcC557zDxzfLSuke46DjbsRG2ssXVo0qNV/EP/kthBwF+b+2p4iQyVCDKM9d+63zUwjSI8RmBo97ebRiLt7aRrbYNk/zckKNucx5VzRiLGMRTRcvm/YplR/Nle9QRp4PqT/V8ETnshO2+VOjbkIIz5F0WHYqFrA1yjHSRVBqXgSXzANodjufs+bJJiUXX02zK04HE0sNRjCqz0ne9WPZJAGnfCz63jLWeQ1pDiuCKeKX01YHp25AA2cuQ+1tWATNwM6K66vhifmKqh/wPrakn0rsRSDuRokW32O6J9JShlt3sSPyuCrd9kc/8lCNag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(186003)(5660300002)(4744005)(6916009)(7696005)(478600001)(86362001)(70206006)(4326008)(6666004)(82310400003)(83380400001)(316002)(26005)(70586007)(54906003)(2906002)(8936002)(8676002)(47076004)(356005)(36756003)(1076003)(81166007)(426003)(2616005)(82740400003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:34.0950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a05172d-0cf2-40cd-3e42-08d882aa6c07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3347
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c368de08969b..67e9602c069d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.110"
+#define DC_VER "3.2.111"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61905C25B4E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 16:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B1010E127;
	Fri, 20 Jan 2023 16:29:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3B110E118
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 16:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpaeSzLLOnowKCwy1mLnYljU5zWmi/IsuIL5RhjP3qc98kwickfkJSfaWq2IfiG1HzYeVO+gefQJPZCrXMzTOlJZHHf1y3lhl48LB6FiJWWQc81mNNCt4FidIhmvarEnyaap9mKrb9aOC2dl0qFenykT3zKC4ofxUF44L7N4JGlXOtn7I9KFKmvBzzSIWOEVrwbkEDDRDNsXxP2VUY3ZFLuF3siWy3AcIrgxinevOQvX5Q1F4y7bIzBSahK/oN5HXpXAH9xxKGuVpay2JegbGLcsldeRbVxx2+2mTEOsyV9fnHb3+ylqkdZCA8A7qlBXls65Msuh7fQKtCrdhJ2Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epJhXLhwbDUgiKGQK0y4/VZc3CzOc6grCpvZ/WK+H2g=;
 b=ncb+vy36A0QIHqwj4haueYkTrSjEmFmSMMTWYQcBG9dmlJ0MCkVUizGR5Eh99OWs+QG3FxSqQim7aXgxvf2a59UiGJwT+xk/wd1zH8a07vIfJtXA/+4d26AF+FaWb1pxthJC1fb/89k4BH3zl4oSSE0dFZ8ALQ5dEicKU7opTbQ6P+wWCI0Zq0kqkEYd4AjtTsFXHxgp1i/NmTJhaX6r4SdiT8G6eo7VW4VeSpHRRHdy+rs6llsjxVh4/gNak0Gt2tzhtyd/05pBIbNGSVE/L16QduWArGj4ELXiC91WXNOYphhtL9soR0yUZR8RqWGMopNaeL9Y1c8KXrGQ9XRGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epJhXLhwbDUgiKGQK0y4/VZc3CzOc6grCpvZ/WK+H2g=;
 b=0nn29H5gugwRrKINduYEVdkDDck9AI83oRVCJDMeZEsK67Q33ZhElBZ8ch6v6kry0Jd8zmqZik6OjVf6iGN43UaiVbX/srnZFyTTMKaivQTQkljcpg3Z+GJxTIZaR8aupSjjNpBYRdwkSmPpP8un3y18E8SnJafVbgoPa4I5yhc=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 16:29:42 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::15) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 16:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 20 Jan 2023 16:29:41 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 10:29:38 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip psp suspend for IMU enabled ASICs mode2
 reset
Date: Sat, 21 Jan 2023 00:28:57 +0800
Message-ID: <20230120162858.1580755-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: a209253c-0c2f-4022-c0cf-08dafb03884a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/cV6D8OEoka5gRLQmojpzD28g8Rk1631XwiFKJwvDyg2KItBgym6/eLsnWBaXDgNVOPkhHaCQCy1ZgiItYtZ3jY7sTF1ip6hAc0OX/5oKyLXMysrv7CHEdIqbUbILxvEXy77o5AjFvGrf32JovxiQtwBt4Q2iFCoys1mfoshgcLuT6ZFChi+C74/8LehBDKti2HQxi/Vu2tI6978j9Desvi794j5XkIRVX49LHcAumvcDyU98v4U2Cd8747pkI37H7h5mhskXRjk1NXhWNxeTTLybmOZbJotMPaA6V4qQN3bv1W0pG2jaNon5lhG1N+gH5g9ditXzl4K06zOfQaxuLv6GjebFhGUBZgqzbHRbGxNVhcNb0lPOm1Fa/CPbyzS6VHbEiuy7ORw4qiMXNFMkk17bShdxRSBilg+5bk+6Nmt6XtMhhwzWJvYQs1/w4xEWtvI0SSCf/os1DFvNqUX6LyUAgtPVu2aorascLDfilYgBNfe3ikJZ5XUaaJx1ERY7ax/r1c0o1yn5BrjchazEfNrSHU/37XedtArVIjypVqTFH/bH7bd9fYUgCjzeYUVgaVd0pAhbJTIj3Bhsi/j5AjqT25QeW9EJgzvpsItRadV9PBE1wCLQCv8jF6jJ9LDtq4THuRWIbJWY3CtAZCcMw8R4YxdJO/YvleyVJcjoWRmlcBDHVDSxEU/yFPN6HxpcKgXFn4TFSU5tCu/cTgNFKDVwJPrRdhKZbQuZLHd1I66pTQii9ivLFKwIROmbwaOuYhM1Gw50S/pjs/TlxMnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(356005)(478600001)(86362001)(82740400003)(316002)(15650500001)(8936002)(70586007)(2906002)(36860700001)(44832011)(5660300002)(81166007)(70206006)(7696005)(47076005)(6666004)(54906003)(426003)(36756003)(6916009)(8676002)(82310400005)(40480700001)(4326008)(1076003)(41300700001)(16526019)(40460700003)(336012)(83380400001)(186003)(26005)(2616005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:29:41.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a209253c-0c2f-4022-c0cf-08dafb03884a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim
 Huang <tim.huang@amd.com>, li.ma@amd.com, Alexander.Deucher@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The psp suspend & resume should be skipped to avoid destroy
the TMR and reload FWs again for IMU enabled APU ASICs.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index efd4f8226120..0f9a5b12c3a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3036,6 +3036,18 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
+		/* Once swPSP provides the IMU, RLC FW binaries to TOS during cold-boot.
+		 * These are in TMR, hence are expected to be reused by PSP-TOS to reload
+		 * from this location and RLC Autoload automatically also gets loaded
+		 * from here based on PMFW -> PSP message during re-init sequence.
+		 * Therefore, the psp suspend & resume should be skipped to avoid destroy
+		 * the TMR and reload FWs again for IMU enabled APU ASICs.
+		 */
+		if (amdgpu_in_reset(adev) &&
+		    (adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs &&
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.25.1


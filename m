Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D42FC25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 26 May 2024 12:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13AC10E0E1;
	Sun, 26 May 2024 12:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgfLGFUb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE87910E0E1
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 May 2024 12:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9Vzxci7ZBBWOqTvHKtTUybLZxPoQxPjdLjoFnqrKkuSa80DVBTFiXU9QpOUihjxb8R9efktqClhkdy1Nn1GRrDFw5kxB7FmB4Biild/M+xRd5LkPFQ5opRynUTBu9YHmyU0Wtb07EdQ45Gmq83Dl0jBKthQSYIHUoH88A3XSz6vPTeRcEG4WEOOjwY+zz3peJil+oA5G1ZGzmPatGRr1bvKXmwWk8WUa4ez3Z63H1RUj5uiTj+WIfdqzrdoRcUO2DTC+sElx60rVTDlpZAMOMReF4k0A2MpSPSEAvcHYHJ8RR7U5M1r3OAm4fF8pjhPRxc18QbAdY8fUqVFND8bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE7W1u4t/lgc4riJPAdke8AKw6FsvMnc1/luNPkGB5Q=;
 b=TR7JmKCwcqsk/5r4sENtjs2IAY5ZWui+VzvuUCVrMaRvhuFM23GhsBLEPLzlawOJ2q0Yd+YEv09XMDvc58CyAiD5+VRmNtYts1rDp0mEcXioLJBlFAgpDvpzlNWL460QNfrJNO3dJJhYpws7/QaoXX34OILWuj7Qceoxp+wdqpOU8Qmx7Vdbw+ZhTd6oKSSJCGCLEVT01b34E2lPeVKO8zUqcHDXVg/7lX8qrcSuSVdLdTQbl2dTIGdNUGShg8XamTBAy3Twue6K8qi2fP2gKroN8/WK8WcerSxsOgp3K76jx6J+73b8GZURoP0toESwRBoU8UvESyyrOzyw0Kdf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE7W1u4t/lgc4riJPAdke8AKw6FsvMnc1/luNPkGB5Q=;
 b=YgfLGFUb99OJbfujc66tpyeiENGDFjEJV2BHu+dUc7JDpeNIXH5Irpa4c0sTuyBOu+PD3dFNV3MVs8WHrRxuaRVIAn/GyN845wNzhvDROPGTkwLAkG4yj1E3pR/YltS4rD7+aa7Q/PXiOHdWOylVeEDYYkUvDzNCkco9VWDq3IM=
Received: from SN6PR16CA0063.namprd16.prod.outlook.com (2603:10b6:805:ca::40)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sun, 26 May
 2024 12:59:23 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::a8) by SN6PR16CA0063.outlook.office365.com
 (2603:10b6:805:ca::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Sun, 26 May 2024 12:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Sun, 26 May 2024 12:59:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 26 May
 2024 07:59:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, lectrode
 <electrodexsnet@gmail.com>, <stable@vger.kernel.org>,
 <regressions@lists.linux.dev>
Subject: [PATCH] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms
Date: Sun, 26 May 2024 07:59:08 -0500
Message-ID: <20240526125908.2742-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: b0aa079b-3369-4ac0-bbd5-08dc7d83aa59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kOutNQRpBxeRjQrXpnpU+xqYI15B+8SLtvsjQ3tixR93+SvlnnwodhxouLq+?=
 =?us-ascii?Q?bwEZitW1/KM6BgO6mlSQkjxeWLWJtGGTUMqT9A11/4mHjMxlWbHnT9FTqJeB?=
 =?us-ascii?Q?WrS/rm1ROuth1ErXl8w7PbvP7Jv6X1GksrKR5c3E9Q2hEcZnrt0q7RzROL4H?=
 =?us-ascii?Q?/14vMZXiq15OdEEJdbh8B1i1ZC+psJpDuAMjTYUrv3ARrtFe3jirc3aUAauo?=
 =?us-ascii?Q?qRFK6hC7vwkMbUVEAvIdo1WvpAYI42F1gEuBG7bOsTzmopHfoI/9MIdGQi1g?=
 =?us-ascii?Q?niT7AP1edLLUMQ50Gu57YdQovpmOEzwgXf5WbvYE0ww9FrEaIpREcbjynJWq?=
 =?us-ascii?Q?8cR0wesgPNV18lFlivJtt9kUd/0Byyk089Cyv6aCE2D1qu6vK78EFGay3YGQ?=
 =?us-ascii?Q?My9MBAp2+Dr9ospQ50rlBkQnkdRqVElmfxk/M7g1qCCkJ/JZoGABM1sL6ahv?=
 =?us-ascii?Q?Hck5z4/oF+p5meS88XngaCaL7GDjYiiIovLi0SfYVMGekdlgk9ivjnMt6pt0?=
 =?us-ascii?Q?vGBbCOEjy9cTfuGv8kB88B2ABdlgew4zhfYBZAT02dw6ImdEqxV+oyJezvIq?=
 =?us-ascii?Q?+iR0wqaRNzaJjMq6V8ARY/spHk09D6JRfjSIWJLetEUgsDN3elXd/F03eca6?=
 =?us-ascii?Q?bDuoanpe57kGBHTgUujo2IYzCTvqHAIB842Fr9UlJ3Ed9N21Alotu6qqYoRu?=
 =?us-ascii?Q?CbbjuXYy/jtpfGlTkfciHZoVBwxEuASoqHn1UHUOPVlx+T+hWjN8/kvoziT2?=
 =?us-ascii?Q?ev3JUWMlzsyIclCMScI5J0p3DUUiay9wAGZZbpvKuDNbjWq7BQSvqRIJlTev?=
 =?us-ascii?Q?QISE8xEEkqZWKBHvn6HV5IK7t9hfRceTauya2aQ6tuee5OsGrvx+QY9bYnYu?=
 =?us-ascii?Q?JBc6vxUHrgwCaPqTR3l0ZBl0eqyJYImzrnjkEXTNQDKHBwkX9uI/52w/4HYO?=
 =?us-ascii?Q?X1KRaIHX3L44ziEqMp3HSN+iNSCgVkQFzbbnCjwYuzps08QJc+eSxOyq9cLk?=
 =?us-ascii?Q?ColuFWm+j9urwU/r3GNYtLL10LZJIQ0oNb5GH5Hh7gbLgN1nUH4zVjRiAwLX?=
 =?us-ascii?Q?LTy8dF9dNEX9rwQVisk/NhSgcntqxXzoUfpZ4LNQlW456v1sOtV6gaPnhUHO?=
 =?us-ascii?Q?EcWoEkNlC6dTh0PngC2WuOCxsSfD/WGAeEedflCsjcpHorosKmCvLjVsXtFi?=
 =?us-ascii?Q?W8/aQSmZi8zmNjwZR6RqWnb8IpaQ4YQzvO2FvdCK3+F3MA/gRR+3IgqV/UAh?=
 =?us-ascii?Q?YlPC41XjIY0pyTnL4yR5kJlClavSdz2+hHReO0sAiJsD2QUkfGoQPLA3cXqA?=
 =?us-ascii?Q?9bxpMbIdi/HyJaI34kCm3yPW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2024 12:59:23.1338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aa079b-3369-4ac0-bbd5-08dc7d83aa59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for
some SMU 13.0.4/13.0.11 users") attempted to fix shutdown issues
that were reported since commit 31729e8c21ec ("drm/amd/pm: fixes a
random hang in S4 for SMU v13.0.4/11") but caused issues for some
people.

Adjust the workaround flow to properly only apply in the S4 case:
-> For shutdown go through SMU_MSG_PrepareMp1ForUnload
-> For S4 go through SMU_MSG_GfxDeviceDriverReset and
   SMU_MSG_PrepareMp1ForUnload

Reported-and-tested-by: lectrode <electrodexsnet@gmail.com>
Closes: https://github.com/void-linux/void-packages/issues/50417
Cc: stable@vger.kernel.org
Fixes: cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: regressions@lists.linux.dev
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 4abfcd32747d..c7ab0d7027d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,15 +226,17 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && adev->in_s4) {
-		/* Adds a GFX reset as workaround just before sending the
-		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
-		 * an invalid state.
-		 */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-						      SMU_RESET_MODE_2, NULL);
-		if (ret)
-			return ret;
+	if (!en && !adev->in_s0ix) {
+		if (adev->in_s4) {
+			/* Adds a GFX reset as workaround just before sending the
+			 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+			 * an invalid state.
+			 */
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+							SMU_RESET_MODE_2, NULL);
+			if (ret)
+				return ret;
+		}
 
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 	}
-- 
2.43.0


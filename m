Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80896C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 15:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DC610E1D0;
	Thu, 16 May 2024 15:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xm/L5T4q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF66B10E16A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 15:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkNM/jBN19FsxOndvKuepEEB4Xrq1MKNb7EYfn/UQEoTJIeX/xP/+TtzqwQ9YdcAJB7IVGf7juFzndRc9V2mF0XILNcyD/4RknHy10ski/mFfMOHVsVLPmikkXDg/YtGT5/JAoyA8xZPlCU6lfyyMxx5Klr80/Kuh25BxIE0/hLA+T8fnEX7hY1c03HncUDCyhvpA5ya4XXsBu23Zf8CGB35qWso+8+sMonYB8TldxOArevfUQsorit/QhRNaVeNzD/H7crb79oGoRzEt7JKzDh/Mz3YNIe5NuTHsKHBq6LAO1PBi6TfiZQEN6QCAWvxylLDwLFUB7gvufR2ubMUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy4gNiDOYL9eqLkY7t2nsRTe75maGfV5Yc5yhNrdPxQ=;
 b=OcQTcwpTZgpu+MI5xjZM3B0EqS7ldkD40yIbKgmTjD8m95Hs1neUazFLtc24KfJUxeFAODVb4v2cZroeUjnztNsp2jV9Z+Sg/kGo2pTKaYe16eGBz8NS9AjTexDEbxhtwhQzCDNGy0XC1DSRVy7XRcaI78SAUzFn8mrBToJwO7eRyhW6iXbxdJxXxPEmZO8rDRa2X8V7yIYWJ0ViNKGzOol6bWdWZWETrOZvBhzeqhW0YZoufS8FQQEiZ9dze3Qx+4juuYb+meYg54WpcHEPLwJIZ4AaVOJS24PSMbRfqhC17JhZcMf88iBWoatb5zU303fszUGq5QCvAt9ugaUpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy4gNiDOYL9eqLkY7t2nsRTe75maGfV5Yc5yhNrdPxQ=;
 b=xm/L5T4q7bgfi7VOrfwOGeOMne2dMQZi5pNACTPP9O7gaOJ/QsehTDTcE3jlMTKxYfPPA9gMZSX3gzm+MIsxhBjX5V2awVPP14Qg77rla2eF5H6b5864hYmiv6sPtjUEPjK4u0V7WdXGTgroYaGWlVz+NJAHpxkBjgm3VbHzwF8=
Received: from PH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::8) by
 DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.27; Thu, 16 May 2024 15:59:49 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::fa) by PH0P220CA0008.outlook.office365.com
 (2603:10b6:510:d3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 15:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 15:59:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 10:59:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Jack Gui <Jack.Gui@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: support mode1 reset on smu v14.0.3
Date: Thu, 16 May 2024 11:59:24 -0400
Message-ID: <20240516155924.2281554-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: e2438701-a4f0-4886-b9b4-08dc75c13710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EmCQ1lMHegHvzEWwfe/V6ElOnEsc1MhBYMOa6qC4XyQJJaDCPoG1whmUTyBC?=
 =?us-ascii?Q?d5XkyCyFr1cDSi1lExyVYkkvgzz6vfpFsumqrgNUMflnqeS1FnYWI+Pec40/?=
 =?us-ascii?Q?DR3oYDSCLc5R07oMHswSNXJkWndDUTGSDRRK9zwBcuo2nv9JW4K8lhbhDgkz?=
 =?us-ascii?Q?yD5a8O3+uZXccLi/yisZDSvwHIXeKozQweNcmifbIWr3rnRJiJNsC0qdDzsJ?=
 =?us-ascii?Q?W69yjqyigzrvVZmwC76vUo2xV0AcNtdnFViWNKzv2Pc6AVHCCUcuUZrnrhZy?=
 =?us-ascii?Q?GvKrL3npsz7NTF0YVXPuZ78FmI/g5f/4YgSxmGU1VmODc2cNcmBAMNzP9iI2?=
 =?us-ascii?Q?fl9+E6F/wFwTP+ZiriMWCmibt7X3900462syLulUj1rO7d3GgCRk8UL/FbLD?=
 =?us-ascii?Q?rgPRYcAByOO1Q0BuPSCOu3b9OamYjk3wRunZ/+G18id8PW/43gtR5aMhpJsy?=
 =?us-ascii?Q?uHHF+j/kG/aW13//bDKsCyJOIDzit795Af+aqqNZxi4FtHmPbt6PYDLewNWI?=
 =?us-ascii?Q?520PZXFC5ULxAzh/d4ccguPjhl+rbSX2Tx2QZ8VlsgFpZPpglvymOV3TnZaa?=
 =?us-ascii?Q?M9PB+93ETlHvm6JaoZ4nu2SKINVzyY6wpgitMms8Dk1t7T+kWsTo6hPr9i/X?=
 =?us-ascii?Q?10jwFQCnT/P0R4s/j88ayWvxHOJfvvGnN8wTm/z1pI21Q9UWb6nFvlGljtQr?=
 =?us-ascii?Q?I19461WZbr9cdqOB6pJ+x4cf8zUKgDB8RExNDiskkwtdVYK49hLbPm6JCLev?=
 =?us-ascii?Q?+vwQZf13YFj82qTle0RiIY1kVgsLl1RixOqoUivgfM7LrKZpNJ1fhva3BT8o?=
 =?us-ascii?Q?2VEqVIH9sRrOoa0n3CbKBsTMmTTWTsv8EikLuwlpq0nqYEmQWvoUacH4G2oi?=
 =?us-ascii?Q?W3gQzIR9VXJ4s6vZRHBxecfiw/2QwYH+h2EbVci6NhJr/V2OMD8QBogDXsJ1?=
 =?us-ascii?Q?niqlHKWgd8hHe6ZeybYXB3vR9l9iH+Hy98lCI1bQQrzsX9z8TG2ioJ2MPw7f?=
 =?us-ascii?Q?GcZrEQFwgzoeg/D4YSvZHn4NsgBGxedAOmsVjcDgu4sHGjK/mTnuDzg2TIu1?=
 =?us-ascii?Q?e4+YVCd6ZupUTFQYDrHhnmflVTQVzSjVbP4WsvGFlVj5e+LsZv+7OlnEcF0n?=
 =?us-ascii?Q?pGgjPZMdIg1zSwt93cpNxnzqKUv7r6GZOsklommpcyVlMGeh46nwtkRH0KcK?=
 =?us-ascii?Q?xCcgqK/Att70xCkVdWnpOtjolPL10iB8G0krqN5KsPZ/+PpwHu1u4YleZfuK?=
 =?us-ascii?Q?lDBJXkA89zXH4IPePEXlgEnuZbyzMYf3/GnCaiQFXL9/qgj4Bg1I6QArLbIY?=
 =?us-ascii?Q?kUZldKbk1rcGboxhdlWVghrd11Uy5PIiuXymXpn6zH3bSd2jMdw7T0/MZb3t?=
 =?us-ascii?Q?BcDplVg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 15:59:49.1654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2438701-a4f0-4886-b9b4-08dc75c13710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

From: Kenneth Feng <kenneth.feng@amd.com>

Align with new port same as smu 13.x.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 1fbceb85d3197..d6b2c600d6648 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -65,6 +65,7 @@
 	FEATURE_MASK(FEATURE_DPM_FCLK_BIT))
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
+#define DEBUGSMC_MSG_Mode1Reset        2
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1749,12 +1750,12 @@ static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
 	if (!ret) {
 		if (amdgpu_emu_mode == 1)
 			msleep(50000);
 		else
-			msleep(500);
+			msleep(1000);
 	}
 
 	return ret;
@@ -1787,6 +1788,10 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
+
+	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
+	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
+	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
 }
 
 static int smu_v14_0_2_smu_send_bad_mem_page_num(struct smu_context *smu,
-- 
2.45.0


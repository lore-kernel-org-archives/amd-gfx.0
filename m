Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD63D14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD9D10E689;
	Thu,  8 Jan 2026 04:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="byW8hQUp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC61B10E68A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAJ627Fjiqu9cQhIv98y0vDXHK3xkZusHQeS+Jy3NA8Knde2nDQkSf4KLWPxEt7E21SDuqP8LVSFTt6J9H8IyY846dz7jgi8PVDkK8oxcJaXmApM3DEn5IPQ2vC93XXTAp57PLZBYWstGSpKMgLgc35mcxAkc56SHyUT935qkulbk+gK9nD1K3rpR1oLApNiVginr3sessvHQlM7QTbMuzV6SPeP+CRsIT7mkpHeq8NKtyfyhjQdZIyFAeqCf9KpDMRt4FWGgU2PY2vQ20OsoaeUn9peHi0SuBjLnW3MFnY2jjAiHzrPW3F0rnpl1Zv+n3Zi3pVEUmEqkqgc3NoW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azjNXTBNMO0FK6ww6PpqjE8a2+P+/X0t7Eb64LdI4BA=;
 b=HT4DObWzzodx1/esxe2y7iY3UZyEtmkrwepp+ygHiLj0EBN1Vkf/yPWpM3OqhzTdfQwWudqpVuNYyhkmi+GDlVerXrTfuMhUU2shNfTMe19cNXoO5YXvaD5xRFfImwg92fPPU/euQzCktSOgwiAWxdreB9Lp72OorxiZkc5bE4FPNonFwTlqbDQ/C+G3CraDS/MVhKhV6ea3+AIALVqJmZnrp8X1uGbI84PY+mZrfZhp1L7NReGla3eZDx4riOgY9yCi5JrWyT0I1gpIZ4+ZY4B3Zmpfr8lfpB+ndvSToUnvlWFBj2RfOotpZMNIf/Em545h/CRhV6y9V382bWRXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azjNXTBNMO0FK6ww6PpqjE8a2+P+/X0t7Eb64LdI4BA=;
 b=byW8hQUpzhNAOy7VJ+MOv8a8ZNSlJf50Jpb30TizwcZmx4isYutoh7wpqbNzUd6r+Urm5A2EIGdcjjp/5L0XMlF4G1GYXkJBJP+iD4RnB8Rs7ECEJLqL2a/AyxKUjr06qCWC6DRvH5PwHBO3c3cYJGDe4/gpupyYOjy+3AgfMqs=
Received: from CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 04:50:00 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::61) by CH0PR08CA0003.outlook.office365.com
 (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:50:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:57 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 20/24] drm/amd/pm: Drop unused ppt callback from SMUv14
Date: Thu, 8 Jan 2026 10:17:36 +0530
Message-ID: <20260108044839.4084279-21-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d2ad28-81e8-423b-a3c4-08de4e716136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tig/vxy1Ep4b72i3n8nizfcgWyIjCbk7KghCEYRhy38VoycYrCkzATKz64t4?=
 =?us-ascii?Q?Hrlteap/pXpdGBCsZuLFEZrhH9KyMXaytdH42BXzT0SoYWNudGblt2o5ryJl?=
 =?us-ascii?Q?58u22+36xcOV5g6isFQRCgUOnw4OT9KLMzKdVirHfaT3Wyw9NUn9Y/YpP/Um?=
 =?us-ascii?Q?vcPnibEaMJ2T9hwgTJMjhYCS6HbRG1Msc7qLrKlnYiiljgX2jAbnLK+1z6lk?=
 =?us-ascii?Q?mHgrGY0Z9Wnoj3GVicuFMg7zjoLA0gTO0J6nUhKSjoRoGXbhuLgwHZQvr4B8?=
 =?us-ascii?Q?1RXJRi2ENeoF22WPirsGFXRjhrt02h2fFXrjUZmokHiHgxUqt4sbaaiIsRtg?=
 =?us-ascii?Q?cRLQyNCGPB7qwlmnxTSiCdatVr/YyQKCVLiHazXJv7yt3XMQw6PWuy37fGfB?=
 =?us-ascii?Q?WP5z6XMWOeztRQX7drSNA7x+5oJjIUq3kqsYnrOXcPNSfzO9y2b9Pfn8bxby?=
 =?us-ascii?Q?x1BNqhGwdihtPuYqXmDlTQzEAZ8ZSrEkpgj5U5QApqhj555aYAP6gy/xP0Eu?=
 =?us-ascii?Q?pGoZLByf82lAS22U6Ak8/vqnphqzaJfmYKSigwKLKIVmgevvvLfYKZTRIkXt?=
 =?us-ascii?Q?5CFtjjrs4unbwkKkxFZA39z5XoNSyKoL0CHSvEEOrhfEAJfFJPPq7neXP2BH?=
 =?us-ascii?Q?t7XvK2hgxYDLdo3Y2nBDDRNcWCzMBT+ObtC7vsRE5Vu8G/svG/YrCpMpsruH?=
 =?us-ascii?Q?wP1LCbgdBLK7UVXnutihH/qXxpnWnCzCHx87GGXJwGDw48yFDX73LhqS3BEn?=
 =?us-ascii?Q?0TQD54YyiHE8hFzV9r6Xp3Eb927Pxsa+rByxwJ0PxY9agxE9mE4lw8Y47MBj?=
 =?us-ascii?Q?F2B5mnxbXDm8wO0RoUtzRwUTtJW2m832A1QNSpGV+N07CNxbzMerjjjEDWlh?=
 =?us-ascii?Q?xuhUXZ3J+bJXT4AiJgqQBsyIXvn3HLVXVdB/sGxtbaaOIUbYClisb+gQnppQ?=
 =?us-ascii?Q?LOqKuYWetXVKYgDPvG39EIJyY5F9g9z31pd5NT8N/TTmlhJawBkYTNgxHtzJ?=
 =?us-ascii?Q?i/KwzNuuOPyh+lWeNUFdkfQ0ZCXSrj8wZnMjwam9BxBppUTaB6GyD3zoHzHA?=
 =?us-ascii?Q?rFpkGIkcaf9hCKOcj8ZipQ862Rpxd2fymHx9SxW5MiJh4tSEPu1lX8Ne7SD1?=
 =?us-ascii?Q?dNx9bdRCwo2PAdKlUmJF7tKoWRrRzBOt2PO+84OJ6xv2sVnXlf00sHCOeHcN?=
 =?us-ascii?Q?AZ7aoQj8o2z8eyBTnrHl8j+or/KYtpJskmFwlg1BZpKMIuTr4w8rq982prpt?=
 =?us-ascii?Q?c+vo/ShYrNVxQftGEUFyoy33uN0AsxBXnX7IKWNK+Okc94fB8mMDAXkc2Oou?=
 =?us-ascii?Q?r8hAVcm8mXJVPxTu97Af+Ne3Hdzt9y3GuBipqLYUM9SDk2+ADhtD5FwYffQ0?=
 =?us-ascii?Q?TtCs3iomm2xzuG2lUBP899mWUoWL18EPg375HV8e7fVS0KI0RkSI4dEBWkdx?=
 =?us-ascii?Q?vhK1UqtknKwIt+f2hSdpeW/4S0dANjKRMC0OxSH6pkHQeeFyp5WCqDdUeJjf?=
 =?us-ascii?Q?/VV+UHDZb/jZfL3b12g5as8rSNZrDDlb1hMjeZyp/XnuhbYlBb1sIGpGljqv?=
 =?us-ascii?Q?a9sWTbGGejzIEFf69FA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:50:00.1589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2ad28-81e8-423b-a3c4-08de4e716136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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

SMU message related ppt callbacks are not used. Drop from SMUv14.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 0a509fec2180..a4e376e8328c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1701,8 +1701,6 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.fini_smc_tables = smu_v14_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
 	.system_features_control = smu_v14_0_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v14_0_set_default_dpm_tables,
-- 
2.49.0


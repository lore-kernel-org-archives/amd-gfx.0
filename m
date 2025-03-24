Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED62C3600C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 20:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607FE10E365;
	Mon, 24 Mar 2025 20:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qrKKfxGC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3DB410E0CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 20:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIadphgOs2MAlzzBGLek80dYOS3maLwI1bMLpIm+veaGMWZVuj4mrMR8DtnZYg7eGxRg27sLJPnw5cBFx9QPyreuOlUhLVAdv8iDBu5zrL0y8+KfsryttCaEWE9S5Mt6tl8y6x0pe7AkwT4l4XqFoHUuqs93FuejU/6aEEFUK4BPf1Og1No2QmF4feq/BV2wx2OpIZ3Dqg8Vj93q3phqxpgsp193Df3PKWAlN5tnjqnLe/fU66nlU9MjCn7sN5W4BRonWTwKYxp5COS//2u4ZsLKL27Dk8sQrRYb2shpitnA0aCVF0htpTsjnXJ89C6Xz7+xZPAClZQUiluJ50cbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSnxLogWxnT1+LP4FhGxmEykNcnVnxyhgMbbbM0bs/M=;
 b=LTDgSJV1/GnA58tksWJ5gRhd+97SbmXS4SIKA+kJfb0AxqqKxChk3oFUzKsI+bRgmBj9ippAvG3/meqjFcJfTpQFOEBC+cuAb5l2pLI8Zc/8NjmqvlUHmjnriJ6sR+U+BGbmcdyhGe6Pptim8dLAJ5UHh4/WRPZdf2ssG0LVCU/ohYux7CgyhaDlo+j/kc8GFNrrmikY5EjXiXOMKVrq8o44iI/axEwnwnUBUW5C03nBOb85I9FEK8QU/W/8Xii2ZNiFeTjQXdRJWr0h67RHFc5oFk6KpBmbBiYUQL31TjO3yI39npUkbUPQOtEfZJaRgcOkRSX3ttazsRYPV6KJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSnxLogWxnT1+LP4FhGxmEykNcnVnxyhgMbbbM0bs/M=;
 b=qrKKfxGCaZ2JSIbGZ8eKPBbz6eQ1czcng2uy1vJToGvrceUgyHrsQQgeJ5wNXcVgd+9dn2e/WWZM6LNSR2AJ1lC2oMIXmIKdjLfSMvxSOefFlB2XxaNBEKWpTjujZNogQuNrBIVsCtB2bIGZ1oS/KSSo4urJhnR7BOxtWpuZPJ4=
Received: from SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 20:34:18 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::c1) by SJ0PR13CA0169.outlook.office365.com
 (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 20:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 20:34:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 15:34:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <marek.olsak@amd.com>,
 <prike.liang@amd.com>, <sunil.khatri@amd.com>,
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bump version for user queue IP support query
Date: Mon, 24 Mar 2025 16:33:28 -0400
Message-ID: <20250324203328.4174703-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324203328.4174703-1-alexander.deucher@amd.com>
References: <20250324203328.4174703-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: bd593a4b-daf0-4976-123d-08dd6b134040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VX2Hu7Rjqgvr36FTs+/C9Ed9XtNLmoorE2KENBIpuY5RgDLJmAUItKnjU52X?=
 =?us-ascii?Q?Phw5kyR5JHhADolfXeXSpCm1Y6aDSeoGnOMiIH9mM5HPNwG1d/RHRzws4NmN?=
 =?us-ascii?Q?KEDyMldIUDFc+jmTCWG8wuOXXRU3IR6zzx3vlO2pvlOBUfwy/mhVUcinlHlo?=
 =?us-ascii?Q?R4VZPHjk6EedPKnnbG+XjBV5pNiKScwoTKFvhy/vhdZBRCAb71oVCKL39QoK?=
 =?us-ascii?Q?1n2I9+mIa5+W52zJdXwHZo8mktSeTikabv6ujgEXeNXeLDUPjCcpsdvc4eTz?=
 =?us-ascii?Q?ETOWzJJPFDuxIHVP0EeJKISNYsYf/oDcS/jbfEFQ7AwLFqF1l+kT1TtkEot/?=
 =?us-ascii?Q?AzznFKJAVH/0nPxPHW5IoE0fVFprZCdFlNTJsf+j8T9wXxTsJCrjktijsbE/?=
 =?us-ascii?Q?DM3I91Chjc5tGgaTZVbqidkOMJcmBJn95KMujiVM2gU3Mlwh5MtgpYsXZYLU?=
 =?us-ascii?Q?BAHy6dafHsZBIqpybUlV9XwwTr15h3D/DBO1mJqFiH2Dbwtk9sKGvdwMsCH8?=
 =?us-ascii?Q?ZB18coIHM2Y8u1EtpKtKy8gwihvzCHES9YCqIEDR9HD1Agof4qUA6QNcuq5F?=
 =?us-ascii?Q?1JEqjehNQRByLp+ax6iq3JNpdH+Ypo3t5+QNR2mVrvaOcwa8L8OHpXloFaJg?=
 =?us-ascii?Q?z7Cby0yvKD1TYg2yKY/+vp2MAcMDM1rC61dODMSi/ZYlnyu4+gq0H9B33IQc?=
 =?us-ascii?Q?cyzxLXJdbdLdB+PlFs/ClqvNKbRktnVCsp4bgDjaZq2XOz66ndwPwzz9Hc57?=
 =?us-ascii?Q?VCoZ/0w5HSEpMekcSQ/IFu9a3ENnazgT4gXNGrjI9EtsKQm3S/82kzWcCzcC?=
 =?us-ascii?Q?ZHbdapkmv0eXocG0qPKgjnVHG37QEC3gUXOVPR5ahMwUgZRUTjCp28SVGN0R?=
 =?us-ascii?Q?N/qPNIPy8QQrPdQlebhG1C0RoUQdZU4cnnultVtfxq1iu1p7gk9/YuzQD22a?=
 =?us-ascii?Q?xp/gphy9TQsckOyqNzPjq6XYOX/2FVMccY3DvYNaw03p7F4rm6H2sLeZMOgz?=
 =?us-ascii?Q?q4NKNWEee7MN90OnyzNG/xF0NNoPW6MKdKmvQxB7F/WcliVrM+QILluYq2K9?=
 =?us-ascii?Q?d9n2lbT+HkvpI6gMLg7/Wb8xJoZdLxpB6ZMWWIGcmJ1JQ+JGSNBUzX43mSSF?=
 =?us-ascii?Q?jIp048EQlV9YJZxDOmHJZa8JLVY46//csLhit+RX1u1W+ZS6ouC1McL7XUw/?=
 =?us-ascii?Q?e6mIdPRajNgNnA1L6r82QuxqxbTHOfvnqq21wYHVNypbCyXB8Z+cfMVW0MFQ?=
 =?us-ascii?Q?QmNkeL1iLWinFxBE46r6IdsD3IPfwVXRI6BU333teCvLqRe1h74omGYC2LtS?=
 =?us-ascii?Q?fDHcL95WMxWuHOfVbMOuUXBGvGU55PMkA321Sq7U/tqjkLmPkaa8qwb667VQ?=
 =?us-ascii?Q?K6qj4dBdpqYWMMb4sAIgwyqYQFTYv+DD13xAyLgtkxMMPwl660+WsRCK52ZJ?=
 =?us-ascii?Q?faji4LJk2mBS29JBmY/Mr7cs/vbJZZ6iXpyhdnhMS7fAejLr3EhpsVAaSoWo?=
 =?us-ascii?Q?o64GM2RO6n296C8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 20:34:18.1563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd593a4b-daf0-4976-123d-08dd6b134040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

Add the user queue IP support query to the drm_amdgpu_info_device
query.

Cc: marek.olsak@amd.com
Cc: prike.liang@amd.com
Cc: sunil.khatri@amd.com
Cc: yogesh.mohanmarimuthu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b96d8c45312e6..4df11afe91252 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -125,9 +125,10 @@
  * - 3.61.0 - Contains fix for RV/PCO compute queues
  * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
+ * - 3.64.0 - Userq IP support query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	63
+#define KMS_DRIVER_MINOR	64
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.49.0


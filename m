Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BFC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 07:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4688C10E211;
	Mon, 24 Mar 2025 07:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VsMg/YIe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6217A10E20E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLvRK+U58wZUh4ULd19twkNyaaqKUxDnes4OSaFvPx66NdNiTczS5rsZ5elg3u0CUwsCZdLvPDdAMMedNm7vyH1DZtXFm1S7HnjBru1ebiW9Wdkum3Z8rXiUXBdOirjzdCZmd6Y/RQJoA15ejOb74td93jOi/uk1xwtqdNsQc1WFz0uPbJ7Ll7k1FIMUTNODwKoY+SU5CpvT2uBp0/f0HjxSSev0F3eDZdcTB1I+AZlIbExfWs74lf0SjvR8qmX8CoVdJWBcCZxE2YUH1AHQQubRmD49NVtELUJAXPTxOshc+6N9pUSrVQWzmue/A+/BwB1GxOBgAdoh91mYgr7kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXek4feZ5WfyiyoDoKdNXJDUhx+JulKsLgqeJP/YXmE=;
 b=jyXuHwfkBsqaWUTA0RV5gucRFb7QzgIZ/3YhKRTFVE/YQKbVNiYRfo+flDz74dWYpAA2t8xHP74AvsJoFpSGZxmoNnkOWR2u+nIzYhSCEeg79D7PZF7Ytv88QhuJExKqSb3vsu7UPy1VbKpA1gDqz+tUATkVC7/vpxk/MYG7JIxp+dzg6N1Zjnya1SOOVMFC7ycPw+Zhf4Dudtl8OCdK2JNCI6TSnC4xAKT8Gqj3GYrYi/Paw5vh0ERp2VgzBP9349gx2IcyGMV7FcXMGij6SIkQf2cjA5kXv1QRn++6PxQJyZwZYCORoHaMPlOwjrpheecoqizHKBH+tHlgn6u+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXek4feZ5WfyiyoDoKdNXJDUhx+JulKsLgqeJP/YXmE=;
 b=VsMg/YIetlxnfKKIiJWV48t9C4k1Of1ZY6IMKmngWpckqUSqIVweAue9pH3hAEtyq+4oMZkMpfMFhL18gHMuGS5XzyDkjWEc04MWTf1e4j+2lmAVinHl0l9zDjuCinbJG88jGDnyMja03Vo/zBhxlmXqXcDEQcum/+LYQB8KZZY=
Received: from PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::8)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:58:52 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::f8) by PH5P222CA0012.outlook.office365.com
 (2603:10b6:510:34b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 07:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 07:58:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 02:58:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
Date: Mon, 24 Mar 2025 13:28:33 +0530
Message-ID: <20250324075833.382787-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b07bd74-9a69-48df-0ae7-08dd6aa9b739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OsP5fAH+qRVG7RxNF/DjuOSxQm9rKEc9jFnDknoVEitJzyzQs24blZ2NmwVy?=
 =?us-ascii?Q?TjQ1hiyYWDykb648z3kz6VYdJxOsgU7+EAtpPHNV3ddz9446c41yo2HU1sM0?=
 =?us-ascii?Q?tw9iA7nH+uGtpyFk/c632w2G/xapRE2762+Tkofb2MO5LME+GFfcL2CVBF03?=
 =?us-ascii?Q?1YmoEKDR2tk5heFw/ITLLR+mOO8X58MnR10LUhQjFs50o6erBzwNGV1JhbLT?=
 =?us-ascii?Q?b+Q3NlFoT4GAWqLd22VitQIlISy+Uca8kc7A2INGckDNO5xnEOnNrhDhOKQR?=
 =?us-ascii?Q?r4XMGpuB3M/AnVVCwmXFqYgzwAlQlVYtPbIp/3IcL/dMXPEbooqY6dUJY+gT?=
 =?us-ascii?Q?yPbcRUItIcHxBmKwcJBkjpyZ6wJiWoaZF8ucQepeBzXQV6M9PaX5GXlSJrHf?=
 =?us-ascii?Q?3SI/IoRc9gqnDRF65HIHpoxv4WRctfdr3pxuHoCHdGYNxkY73nNCIHDq3aIx?=
 =?us-ascii?Q?dDDBprlpqdANwJCcq2mSUdKQ8fRl2oCWVBc0m/EkAqrvw0VvY94M0999Qek/?=
 =?us-ascii?Q?EaHJUjELUn7tl5kR+ySgQQkGWRIxO9X7f17z7T0koTV0Wp86BfiYD5l7XGxx?=
 =?us-ascii?Q?GKFoUNahhapvvwXv0Dl4A/Mlo4HrhEbDcLp6qYzaN1RF6KmkYiCyozL92Rbu?=
 =?us-ascii?Q?A/tJDGQ9K9BEv7ojnxNua/NazcKzB/MQDTPjDUoV07Wbb1o1nfckkpNpy5kj?=
 =?us-ascii?Q?NPLF8v9yh6QZ2K3aKtwdYTJ4CPDmBg4XNl+po2M9zQ801R5T+X4MwwtpyVAr?=
 =?us-ascii?Q?pwxY6cnDj7CCPQIFz/2/nG0b1R8nVEXMK4fSZlrLlNYSzQQMcl8ncC/L0SOl?=
 =?us-ascii?Q?nMDuuCkN42jJUvwTuTmNK/HY4P2iBVFDwLV6oxCljqg32Ft/xlfmcbiw63kp?=
 =?us-ascii?Q?j0o5CeW4wT6NEPY30cROWjRQLlo70we4fz5hVrJTaAHXZXpx52Ci9tO8gzsR?=
 =?us-ascii?Q?cvO4+gIq4EH7HHo6cUTNnHAKyjdXbTGldla09O6KvfjyVX8WxIZd1TfXTAoL?=
 =?us-ascii?Q?aMc8TvLdNTy1qCYmE7sJ2wGMhrl9LaTF9y+PijMqiL4uVXje250F/8ryLAbb?=
 =?us-ascii?Q?Xrag/HPxdTjiC8ZYWhs8TlzNdCr+Ob3uIdi6DWpGA8XV4psroLqF3bfc8NZo?=
 =?us-ascii?Q?+8L8DIiyl9eNpFY/0PA7QdUyGcmKTq3zbIwRldbNX5Yl6wtiwK4wvF//pOeK?=
 =?us-ascii?Q?R+nXVj5nMDWhLctPwJV981OBHW7qT+3j78cnXzZBkMnMtiAXV07jmQX4/npK?=
 =?us-ascii?Q?4mj6crgPhWfR7aKhA7XCWSwWZ7xNC6cVxUsHQdmuNJMe+SoS4BurFrtJvCH6?=
 =?us-ascii?Q?GoPJvZ5IViMuVCqWUi9UJPFNXqzC3TcovzDg2qomsDTwMY6RiOjviza+j0p+?=
 =?us-ascii?Q?qxthJVEEBNHUQiSX10m7lp/tY6dZSi7NbKgZ5TLk+p2m6syttCvYjWFlv+ru?=
 =?us-ascii?Q?W7zWk4gT2I7mSPu66iR+/o2TAO4VQHB53PhgK2YhS9t8IXkJTs641byUWxQi?=
 =?us-ascii?Q?5l0GkMC1OG0N6Zg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:58:51.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b07bd74-9a69-48df-0ae7-08dd6aa9b739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

Compute partition DPX is possible in NPS2 mode. Update the compatible
modes for DPX.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 3c07517be09a..ae071985f26e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -473,7 +473,8 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
 		num_xcp = 2;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
+		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			    BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
 		num_xcp = 3;
-- 
2.25.1


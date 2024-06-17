Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55763C2BA1A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA2510E4C6;
	Mon, 17 Jun 2024 19:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pdf6L9bY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BEC10E4C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 19:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhUoP9EhPOXY+tknEq7T9n7BSdrepleW4THibu0AYN+kFD/Vh68A5mnVKLaF/x1gsRenneAp9wvhcDSy79pH9k1g2USoWskt0rcFJILV44rARF3nXN4KuazNurF6oz5e+MhsZ/XDZo+t5xe4hBfW0+ODr8iocN7ij41s1+E4j5g3vHLAnzi3RCBbL64DdR5CE8Ijiae9yDElJLWb13l7cVBffu/aRNZyTqOp6iBGHPj7nPUJqqi8VLm+RFDHD7C/QyOFkmEJkSMkoC8+6j710x7cX+/lCqEOBCst0Kzto9bn+KDShWFrg+SMHTwhp4FADe7wn4gePn5LHzHQP99cKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D0QZZFx/ZV6eiTBmtVPDLbdJuCV8YZK8UjLiNbfsCE=;
 b=SgDi7J2dKYj86AK9bNbvhjQh+yy6w89sf2KnHvlZ9ilOn0eplCbeR65iBJfFtNf+MBJbf1COE4m+ev8+FoVA2sueA5vJdH56rFstX/hoSpYsQ6CLhByszeMeYFU0i+SjVI8wZJYzc+PX0f9bb84JdnUwqhTpyADz9F9mCThp9JWuDbzdiZIVIefyzvWmEdfJBDFmh1XFGk28L86WIQmX95e/R/7Y3mERnw53STaUaIVrOVqbDcB9oLMDli5VFUnldJWkQwB0EUANB2GnJAcPqyg+FqG/8M/cyp+iTItyiVUmrHMDLCGXxQUhGDHekDMGoa/0r/KW7H8yu3V7Q3o5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D0QZZFx/ZV6eiTBmtVPDLbdJuCV8YZK8UjLiNbfsCE=;
 b=Pdf6L9bYb4tXqfYrMx1gt27blwu1TgLi+Dv4EXcpB0rxlOiVbUdjqwEFpVKoBEuTa/txHKcO+ae/VGN2TXoU3qLLLEtv0rbhIhwZq2MbU0FGUH3kthTP9+iPWZpRdMDgUl8Uy7EB4jG4WI2pUzMQ5E+6zYbpc7u1YkznBsnVsHI=
Received: from SA0PR11CA0138.namprd11.prod.outlook.com (2603:10b6:806:131::23)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Mon, 17 Jun
 2024 19:14:36 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::41) by SA0PR11CA0138.outlook.office365.com
 (2603:10b6:806:131::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 19:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 19:14:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 14:14:33 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 14:14:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <likun.gao@amd.com>, 
 <aurabindo.pillai@amd.com>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: init TA fw for psp v14
Date: Mon, 17 Jun 2024 15:14:28 -0400
Message-ID: <20240617191428.3039656-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dee493-ed5e-4ae2-944f-08dc8f01b945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n5pDV+KecDK+fzTKJ3QPqY5siILo+vFJTJiDxju0vl6Z/r7hWMmC5d7AfHTR?=
 =?us-ascii?Q?uSVQrAGU3uUwjtprPzOu2TBihsHdZvkU5iD9JqMvzgi/wbP5Xlk4X4yuzLJc?=
 =?us-ascii?Q?tuuukUirQ8NoCPWInhlkqCPnbh3rKL0BX5SVQ9/ty4zjNKZWGVSRVuk26bkD?=
 =?us-ascii?Q?cy+2BVQI+IiYzC4bjn/fMKIu/d20AE51Nzxt8q7aVmyZTXL2GzYwNz4bHNlC?=
 =?us-ascii?Q?L2L698ZKBQgP6GZgEPk193505R51+bvTalUGkRWRl61ozYjelJZNKQQf0WuT?=
 =?us-ascii?Q?bzcpHffqaRhx+xGOijUGZwELiijitZaz2GHlovhJZAKDrbLXBXpcMbmGx7xA?=
 =?us-ascii?Q?DWUd/JccJyz2N6N4WVS1kV03KRpu93NAdhPEOgmMRCrkRrLMk4aLyvD/ZkdW?=
 =?us-ascii?Q?vH9doPF5KlOjMUlJUOWhtlY50qJDSkaAjueotYf1+fGGvG7+0kDPgb2TSWtD?=
 =?us-ascii?Q?S4jFydbPS2fllTIPu+tiyWpDxZNfB+yRBooSBJEdrVVYXH9v3pwY433Do+yU?=
 =?us-ascii?Q?mJY8JtwKu91+H7itXBPnO9PA1TH83Fll/GAgBe6xvjmWzDn8K81wxjebIHcf?=
 =?us-ascii?Q?1Tfu7B75zAk3RFZIoMiKwAJ2YVs1Lilw/jkEhd20E5o1XnKST0SXBm+qhsoV?=
 =?us-ascii?Q?D1RJvdN/+XZL/se305MwF7j0RikGb49bz5YE/jfYPWTtabm7e5a5nZR6U56m?=
 =?us-ascii?Q?JfRv8XoZUqQQPcm8Pl5saIfmNlQsWLs1o+PbxdXSVpQ/ZEFMKEw5ycWQqPfT?=
 =?us-ascii?Q?xSWIkH7nj8B8xF121VXGHJFP4i72I+fz9eqRDtHOgKOEm3EnW5mPbEP0d6yq?=
 =?us-ascii?Q?AsTkYSt651pHWrGfDHXZfwGGEf2GbKPIFeD8NYIdGrVhktm6PdT2wtJ12uSH?=
 =?us-ascii?Q?ROuJ/uVfrd46YW8XeGsZW9A95sD3hmmxAKqMnYwNP8OgCZYrAdhwZphZwcnt?=
 =?us-ascii?Q?BnLJjvQ+ZC/+H0BxaBBxH3vzVovy1C0au4CuZBLnZWD8Jy311NUGY0aPS5+Z?=
 =?us-ascii?Q?2Px7iH73AJLO0ouY39FAyXfzbZSAmTDaQjH85+PSDw7rcXw0lwVoFhRpaPbz?=
 =?us-ascii?Q?9mYRPV0rOXI51OssUlR+0fll3CRFQTIKMUAfb88dHyC2Ddkg6mtZs0ItnAN8?=
 =?us-ascii?Q?+YMPtXx25s+klZCnaXwBsDFkeaiYrP6iihAkEuMeNkgoOFAW0/0wjddvK4zB?=
 =?us-ascii?Q?OCrBPfj9ZcPY+dLdpv2IolnrarNCMvl0iqwVBdDepUTk1zmSRsJS3CbsOTEz?=
 =?us-ascii?Q?lz5sST2Ga+H6ZCQEZB4BiQer/Y0pn0gMHu/chTUhmZVNJZERlpIDnv+3oQ6/?=
 =?us-ascii?Q?iEIzJ3VYN5/Tdde9f3xtMwQ4BWfBwcm6BKfqukUZ5Bhtner0uUv+0nJw8pJq?=
 =?us-ascii?Q?+10LdjhT2oy9+2Bm2NPRjUjVL/FEaBs6RJPETZUD6D9y7H973A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:14:34.4914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dee493-ed5e-4ae2-944f-08dc8f01b945
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

From: Likun Gao <Likun.Gao@amd.com>

Add support to init TA firmware for psp v14.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index cc0248efa6b6..4d33c95a5116 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -32,7 +32,9 @@
 #include "mp/mp_14_0_2_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -64,6 +66,9 @@ static int psp_v14_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
 		break;
-- 
2.45.2


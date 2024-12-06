Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4157E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 06:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFFA10E056;
	Fri,  6 Dec 2024 06:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVfgAn6B";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C0910E056
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 06:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axw7hYafyNjZKTeVuKBC4d/IFE1FN+jnOd0j/3oHWQ/8Hh9NaYtQm4cuvFV3gcIt6XB9w/+zSE4HfUMj1i9oGIERYfrYeDmwMobV/FCufqzEKiY8EpXt3Doa/zAerpM85cQV5zqx7hcUJH/OmK3dHLiekCc9OrQl3iRaNnyZKkzIZnNPOIAYCEOmjiaHs507NYB7qf0oUSZyH7XTyrSUvYLNqrQxiVv6rPv7eEfKx62k0PrH42WaQfUGSjb6SdfBCOiDU+lzqmR//UEjrtzTwo7fMe5/PzWpbZKlZGgF2HGNtB/bZ0EO/+k28ux9i/nl7KQKn5GOPKpy1FX6UPHYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdKJokFHzeUU3+rOariDpCGAiZbRnjmcKOrAOo5Fk5M=;
 b=rusq9mfLOGLsOsKlAt7HrpVxai2JBujHnWDK8v6FmLOhkJq3d6AclKYt0IFLC2ZRSlrRyQTjl8wFsnyBR04KNYPA1TdDDYDOBacroNkr1uoPRjkqKiCOVj27vLMFME6YrF694doe7Hqf52gzscp/iLvVKDES+dv6oWhMjgb3GnXbF9yYf5vsJ1JyIeeTljFLPGPL+Ih0ZMEEJbFy+WpvBQV59khN11xi6sHLjh6vnRaWtyWfSX9YFbqwEcT/SrSFJqE3s1vbka81+ZOeEsxuOnykf2Q6kTcxWJn1Kbb8qjhpEjjvZPy9vh1OwjVv94IXbSWW/lNGIXcFiyx6fsuhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdKJokFHzeUU3+rOariDpCGAiZbRnjmcKOrAOo5Fk5M=;
 b=zVfgAn6BoFkDexP6ephsYCL4z5CE/XdAxn+DXEcdiIXLtSWcCS8sdzMJqJCmtBjkAXqcC9at0IBfKba7+T6PQOw361jW2uuJyGbtmM1Uvu72v+v00+G2qtRWOUa0N5CUTaSPBXvxVSse28YjXSPRg58hyvYO/a0SoeH1Y4lERkg=
Received: from PH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:510:5::23)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:46:52 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com (2603:10b6:510:5::4)
 by PH0PR07CA0018.outlook.office365.com (2603:10b6:510:5::23) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10
 via Frontend Transport; Fri, 6 Dec 2024 06:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 06:46:51 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 00:46:50 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: yfeng1 <yfeng1@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Date: Fri, 6 Dec 2024 01:46:39 -0500
Message-ID: <20241206064639.2729-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b99735-b510-4c6a-9dee-08dd15c1c3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XRfzcVDvFFXpphkW+YGJLt9TZhrBKkQ85qISnSbJrDT3JSvU2XNqcTvyL3xh?=
 =?us-ascii?Q?zpAIeNMjgqeCSB1pVGPoeTnFSaow+ynz9kVjMuRM5Qn7uyMqLQBykWSuad9M?=
 =?us-ascii?Q?/rSVwOanExJfgrdZhyHINBlucS8Clr3aXOVw4CqIR1c5LfnsLlJNdwxdf1xr?=
 =?us-ascii?Q?g2pWJhyA9lReyXnZOyW93cxleT7sMkNZbPIJGB0nvn9gXrXqAg7l5rzc6oIp?=
 =?us-ascii?Q?uNKXTRQLpEB/7EfNx/fDIQyWQKW7lkD4QBwg6JXjGjjVswLAJljfC3fwWBo6?=
 =?us-ascii?Q?tnHTi8GdXMFL+KbKbYMcdlxjIS8F+2eLE8xIJiMVP7jpTBAhwqWSyniVV/Eo?=
 =?us-ascii?Q?J9eLH54MP2CRDZs/N2ZLT04h+eANSrFZybW3LVOYnrNEhRgw9g/b/j0/lTti?=
 =?us-ascii?Q?QeLYjX2lpwfmECMn6zB6uRORoYTDIZ7rbsiNZTc4z8e9A3Hqbykgdm7PFpFk?=
 =?us-ascii?Q?cCUGweIgb99xMdY4IWkhNANEHLpqhKQyt04TH8x/xwEUHEIW3DgzgfK7Bx2Z?=
 =?us-ascii?Q?b+Fu2FnSWNctOoaQoGDytfopAwjS3KC4VWnUeLrE5Q23BtYt7hI/pvOC3wPy?=
 =?us-ascii?Q?Mzd7ZZdY17/sr++z5e1Vw7VKVV3ThUoAwcxHABY6CVbQQvnEGMBTOm5v2XFa?=
 =?us-ascii?Q?15BkBq/53OjNSbvYGk9VyRpcaFnUDlXKHg0CfcxtM3GKjXBV0K4lw5v3bBFd?=
 =?us-ascii?Q?I09CMwqKiiPkwzsvXiEYZ2K/ajYl7EGX4I0IJDrWx9tOkILE8M4gZAqR92lo?=
 =?us-ascii?Q?M1JqTxtka5FK3psnKpMpIjpQ6na/ksi8LjKMI2ZXa8O3ZpsmWEIW7zbrqyak?=
 =?us-ascii?Q?IqbFB5ClSsz9yslCAWwywi/ADtIh/aTVn0shDom4zqTvx8k2cvGDNoQK94JZ?=
 =?us-ascii?Q?BfJ0L70CVHg9u+hdVV9uNoL70krmvnKoahWgeUVTAdl5V1vZ26FyWRevpQdB?=
 =?us-ascii?Q?sTRmiqJHJjOfF15OBGaxKAZ+04XAAbBtrn1dIL/IUNgMCcazd/Kq1rkyHfzP?=
 =?us-ascii?Q?C0+AxPZOZijxkl8NdX6IfelhrBrkVPDuNNYg7ebmoZw2EOSLwpAfGR4zBKg4?=
 =?us-ascii?Q?MIbWsv3G5ZYkf2tRi8lI8PEbGdaiP51XG4AQEij6VCmMyg/tt/trUmtHj+2S?=
 =?us-ascii?Q?RQnKxoKcdEhuSYlHVwNYSA9hs3aTBUNzqsxfhOj0eSe4ke3msz0DNbejZFRn?=
 =?us-ascii?Q?OsHt2ibI3trL2aHLou3HgVXCnL9w0NKQsl1bCV7yNTn9fZFeI2KaNPy4HYiQ?=
 =?us-ascii?Q?qGP/ZE6uAxtkCwPCDIZVEyCuR3EY8KfU9BJgAdtfHYKJLZmjgZHmAxN9m4C4?=
 =?us-ascii?Q?jpxekqzfoIYc4O+Qw5B/zC33BDG3l20koSZouNX054OzcvZSQKsTXOz3699k?=
 =?us-ascii?Q?AKEzcqZyRlYWyFpwDWC7U/qhtW6syTaLrGr7or/edPwMIjzXobyQf8oiewXJ?=
 =?us-ascii?Q?rDd7kHhjYwtLd5Wm9A6fkiIcImR1jNP0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:46:51.5698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b99735-b510-4c6a-9dee-08dd15c1c3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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

From: yfeng1 <yfeng1@amd.com>

Users might switch to ROCM build does not include MEC SJT FW and driver
needs to consider this case.

Signed-of-yfeng1 <yfeng1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index cc038f300a56..5e6c1aab2e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -579,10 +579,15 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_sjt_mec.bin", chip_name);
+		if (err)
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_mec.bin", chip_name);
+	}
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
-- 
2.34.1


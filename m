Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02FBC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 03:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A1210E08E;
	Mon, 12 Aug 2024 03:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+YN0xw9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FA910E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 03:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYKnMzZP1bJP57DgH4rQdTJdysjR7Q7EPqUS+JJmCjaEBSqUWr7BhP5aShYtrsM1wm0FpEXWkBYnuFlWIYQN+ITvt/9eC+ZU8OZ2iRW4SR877xcRSvUEwMkFsP1kvuouBdXAl2ZxRvCMQO73Ap1evrHaUmwooWbOEaVqUydM1mlNCgGXfPKH8tGcyrm0zuK13pTyNn0j0NVUimFKUXdHLPoIJxbfUgmxoxpTgSGHWOS8IwAVI/ofTMUhD6jX8UQOg0Ri8kOE4AntsrKtOAObCfWvTR8XICYgdo6NhyyrZ1o8hTvpZs/0wJys5N0I6E8HNC5CSqq8qM50bfAYGq6XRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSLrXtCEtXlnQiRFnsEPQisTSSo40eHGfAqwYVLYbxQ=;
 b=LKVrg1A9NE+Jxv12WAla93HQs2QZFg93M24FZsDD7Ljbj7w27jV93eFS8unIaHCFtNos7DUtPOdfOl82Sse+ZnlWtKW2t0ESrktbSooyJ9fR5NAjFteHxALkKVzhVGx7qxjYZYBv4Y5XRLgn0G+u8CI6WZRWBSlZ3o1BSXeYTvCAyiBss9PWCWOeJoshP7sAIgHOgtYN0M35RgkabFhX3N4N1lRYsH1hYzpPjW24eIkZKBrQRLnQ1+yGhOOALvFmmoHIervfsXZFohnMiHVfk1Rc5PAiYV5FuAwlD1fqV3s3vOh8Vni85TcwO1fsGgkQpHNitseNr1Q0ZfmhT4CFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSLrXtCEtXlnQiRFnsEPQisTSSo40eHGfAqwYVLYbxQ=;
 b=m+YN0xw9jEMSeFFLTp/LX5oD0tPIujmpq7ZQ/OTBPCqscodolOiUmB/z8AvykMoplUQV84Zj2jnET2V64t9ZABCmav/uIi75thZ+UMpyBpTF5zW7t8Soz9MGFWQn+nTh38XeYCkWhQYlh5V6ccRdy/YFtBJrH8l8niyK+5zYPOg=
Received: from SA0PR11CA0031.namprd11.prod.outlook.com (2603:10b6:806:d0::6)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 03:23:05 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::53) by SA0PR11CA0031.outlook.office365.com
 (2603:10b6:806:d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Mon, 12 Aug 2024 03:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 03:23:05 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 22:22:43 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
Date: Mon, 12 Aug 2024 11:22:21 +0800
Message-ID: <20240812032221.29060-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f79464b-edbd-4cdb-9ea1-08dcba7e1487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYiT2h9Ou9QY0rvvt/FMvgb6VJjIbzU0TnuxlzoJXY+5fRO7W+B2b5iuZgEe?=
 =?us-ascii?Q?En9nJmG/FmrazYPGWftjsAQ+mywwDlwHDc0f/ohYp6hQdk7HAXjEYw3LHmVU?=
 =?us-ascii?Q?+f8cFL/O6jjIKuy3LbR4M1VsbKlJJa2bCchkKbDwKTrWMVcLZ7ULiAaktaMj?=
 =?us-ascii?Q?mkrxXsdeGhdMUlAdi/Q6ue1mNiR9krD0J0YYtTcxIblGEZeir6Zw1szadfy7?=
 =?us-ascii?Q?+P9l2xmtR6t7d87xY1II6phthstGcJ7ZrJvYout/ihMuw2cFQM7AJyRaoRT5?=
 =?us-ascii?Q?w9UzoloLmCHgGBZ4hjIWrk1C1c30wQNKylAdNU7nYAyXUOjUfp8CKuQh7PkG?=
 =?us-ascii?Q?31UTXZpWE6o7glp8R8Ji6bTemijtm+lays5E8cxTGevi4fbjYnP70lAl9lY+?=
 =?us-ascii?Q?xOA3DJ0jshVcCaXuM9BX78STnxOgY4FbLv0u/aMXkNDYDJQ5KO6m/wMFDt1D?=
 =?us-ascii?Q?5jAUp+Jn41dTtFftTYcpF2GMXScBMKpclwmJB8zsferPOlCs9TzP39Tkg+Jx?=
 =?us-ascii?Q?RrZFZ8xfL8MG1lQR/8qcDDp6ija2+/oJv6tctbtSaGYu5emNg15lKpiwU+7o?=
 =?us-ascii?Q?PAuvIkFxJTE9uAB/GqJTPpLsPXFPNywlFmeIA3n5A+1gxanrdssPvqxo2elb?=
 =?us-ascii?Q?8gcCcsz+DEeLeQqdC1GsrjGs+tq9ME3IGQ5CQcMK8VDWh5QWI3pJoBVKWMYG?=
 =?us-ascii?Q?jD5YCmDGT5UwVE+TtZpNJTv+LsmbW63jAZNPsv2UDjGcl+v49rC4ww3xA8X9?=
 =?us-ascii?Q?5e5StjI8CWvFTRfkR1/kvXbyEmPMhX+bNmqNiiZ7pJQtC+5hK0PzhKPZ1bGz?=
 =?us-ascii?Q?MvhspwXZLj8Mc1M/2dOaNYYLlGvMElweKRiiXjyY9Sm+i9nzceFKvmdilygf?=
 =?us-ascii?Q?LxX6MI0x/Th/x3384zH9FarOEAgUMc6WfSF9LLABVreg5KhYytu0D/e4lbbI?=
 =?us-ascii?Q?mDFEk9gKe+9paDurq3stcjaalwDOcvZxmSrJMYZxBK1WO26KEMaij/ykcdtR?=
 =?us-ascii?Q?i63jYg8f3yWndRAIlIf1iQahkY2GOM1yxrd/evf13Symw0WQkKE/RSaa0jZv?=
 =?us-ascii?Q?8n+Nyt3V5QYYt1rerDu9epxGMNZsZJbc4TZtSNfuWWvZXZHxWSVtfJbXG1TS?=
 =?us-ascii?Q?Ds9IEfagYgl0n6WiKTWoxgk4UBN0dUTL8a2zWfYluIs91Yol20HNh3R8KdJn?=
 =?us-ascii?Q?5OsnkQ8Dn+X5uyAUj8L+NmT15EJCoVo1CXoi5lFIfeIKzHcpTvkIj4/x5bJh?=
 =?us-ascii?Q?uwAcdxAfhH1IWT24l33iHLyG0xNiCeGdx5LKZGk2j6j73CePTw180YkkBSx4?=
 =?us-ascii?Q?mr4FHU+ljkjhKVepx09FBP7J4XUOkJfGfuw2p6GTOxLqYqRi5NBK8Jegp5vW?=
 =?us-ascii?Q?Ly0QKXn8T8zbLRX5wUBnERii9UL/mKZRPbQDactfYAOKZPOJwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 03:23:05.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f79464b-edbd-4cdb-9ea1-08dcba7e1487
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

TA should not be loaded from guest side.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 85ec9e35690a..749d8143b1e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -132,9 +132,11 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		    (adev->emu_flags & AMDGPU_EMU_dGPU_SIDEWINDER))
 			break;
 		/* It's not necessary to load ras ta on Guest side */
-		err = psp_init_ta_microcode(psp, ucode_prefix);
-		if (err)
-			return err;
+		if (!amdgpu_sriov_vf(adev)) {
+			err = psp_init_ta_microcode(psp, ucode_prefix);
+			if (err)
+				return err;
+		}
 		break;
 	default:
 		BUG();
-- 
2.17.1


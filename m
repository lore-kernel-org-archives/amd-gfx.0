Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE7C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B3910E32B;
	Mon,  3 Jun 2024 08:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KIQoIoAv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE4410E32B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BowvOevVJJeb9qc7okwXiYeE+XNMhtI9L0uc+5yGJcyv9NnrfOqBqyTTuZt6R2EH9Jl3SDG1dqrzs8My+8GS818OR4uJ0dDNa4E+n0qBSksOfbooeHewTNFN1qtrrvSD2OOopmq5zSq8y124WIsmKYeJvderSksLyz5F6h7ovQKFAL7Het2n6uxNrtCMwUB3RAWF7QX37sCWNcgh/FkqgaT/eeYxMAIhl8lQG+gcy8EEGihxdhF4h9lPWOmHClwNF+ygX3Lvgr5s7hFkfB4N04DsUoFQggYXBlfjO7ZYQHqq205D1eJsMiDIBAR/jLu/01ILS0Pc6WcIvH7EH8soCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d72N3rFaK3inzjCSlnPK4sa6iFi5ESxPVczYxehwXnI=;
 b=mdrmaDeYR4JXMc9QU8jFFjOh7a6ESwLmnz8AkeZ9X7NbDQSzt5cgp/P+BBGPJg4GUluFrdU+0ODFWVe2H084gQLNPGJFBD+J0LjzUuWyezqkeiA8nLRLwaq6wCtkK0YDjRKAQLjBd+KjuarcShKHGfwjzD25G12g7f262BDwx6Yn6dFDmWOSHmZT93yDqRJq6gLJgnfdF7fc3WJkCR9A1Eb9mJa5kRYOccCZsSsaoYMd2WLWzF8O+v/T1l9laNQoexVq+bzK2QBs/t6P6sSm2BYyXTpBKQNS38Hd+p2CR4fFj+Bxf4mfFZ+ORAEqv78QZcJeefY7+UMCNcknb2UrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d72N3rFaK3inzjCSlnPK4sa6iFi5ESxPVczYxehwXnI=;
 b=KIQoIoAvTDB8YKPDagu6njJ+tpqacXgCpJE6JfAu2s4HT9dIjJOxjnbvkSeB3Q6LI0So65sVtfStWSCOQ10x8liCEIVhTcyn9u/1/tqtum4pLrbkCfLAgnUVrLo1rXcrrPw43/HYTTAAzD5gv/jDpfkpTPK5pRZ2YJ1o81JOgbU=
Received: from BL0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:91::38)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 08:48:28 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::ed) by BL0PR05CA0028.outlook.office365.com
 (2603:10b6:208:91::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 08:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:48:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:48:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:48:20 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: remove dead code in amdgpu_vpe_configure_dpm
Date: Mon, 3 Jun 2024 16:48:19 +0800
Message-ID: <20240603084819.2570076-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a98e9ed-8729-463a-042c-08dc83a9f009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DH6uOWyATNRl8D5XH9qo0POBZ5Kqr7BpZPIDDwuyYCwEOgn+MvRS3nWzz4u0?=
 =?us-ascii?Q?BuRLp5/r+npfa/uYG4jvwBPtu4D9epBH0goWi0ZxtaTrKURKXOMM25595Ghd?=
 =?us-ascii?Q?fLyRHiEBu956dBOMMFgIcyhJJ4VutKzdAZDIM28tk1pF5hiFLRlDKUyiU5Lh?=
 =?us-ascii?Q?OemCe+GiG8Vm72yPHpRYH8/3UTKwHuDSAw+RnfyJoesqBv4N/FEXDiTHZPnl?=
 =?us-ascii?Q?GodKF3W3nlQmkXFg0uYtIFau3J5ja2Kbt8X9ksLiW+2M9nXntmILQBfff8Ob?=
 =?us-ascii?Q?dX1e39K9Pn3dDmJmnTWSppKnFpLolbIi+s4/6Pmcb9DRMzLUTd0qr2pGMKHr?=
 =?us-ascii?Q?WD+73SJNKeNAAUoNV/TwVTNt0JAUAuO5B0FEyOuR352SyZ206THcNVEPvmCY?=
 =?us-ascii?Q?OOTR5MCCz0AANjZqydU+tA1r2zG5Qhaaa+IKdr46txmdtcgBzpt9qh1qDx11?=
 =?us-ascii?Q?EZDLL6LIa3d/fjdCFlT/TpJr9bIpa4s5StY+nl63a9ZDwBqL50fc3jk1bg1/?=
 =?us-ascii?Q?4v/QIYI5JQAQ2vUvU2eBe3wLxiFJozJPQgUMDQQRblDDvrSueeday8C7VHzm?=
 =?us-ascii?Q?xWIsAdcXSmcUKP5AKbpUrMyeHSepjaSRDVi2l14lDEHaEhrSmvoMLal/nDKh?=
 =?us-ascii?Q?g0RvNQqGZ3qSDhGgJZkPak+Mw9fRpqQ8gab860rm0cmN4rCI/1SmVcFaSsLG?=
 =?us-ascii?Q?zakhkwlW38DvdIqjlZL4CnfoEYYPiB7NMINks4jG1inpPAp21cxW2jTqojxy?=
 =?us-ascii?Q?3u+RnwIqRW3cj0wns4z8wYn34tT5FbSXqrdZsGwaVIo/x5WXmBFV7QYaxcfc?=
 =?us-ascii?Q?f92ubB+PVbBmEsjI+VJBbrKAkkdllqz2/Z4wjyYf7Bw2icwrmU4RqQ2fCJpI?=
 =?us-ascii?Q?UHilRf9ybEE0ZQvaH36e6dIz+Fn7S7GLFSGjwQEClAHshWT/c56Sa6mLIERN?=
 =?us-ascii?Q?3k/NXarpmyzl0IT9SPyOYEyJFJD6AVStiEdWtCbGzBPazFSTyYz+g1Yvpjcq?=
 =?us-ascii?Q?2JN5MqffT5v7P0vIkUpPoQ8NEQ8UhEqBK9R9DQXZfqw9E6mFG9uYVqZvOjVC?=
 =?us-ascii?Q?RgY1uutFtKUb73e9iszYUSgXD70LEjIOEQmP4MjyUTOO5DvWt4yZlBDA2wUy?=
 =?us-ascii?Q?7P5Hk0qV/9C2kG+tUfhoaOYmpjl0ChHFSnQY8xeKh6KjYbw5Dyat22bKL4V5?=
 =?us-ascii?Q?uJvrnCZDNdvjHkRSRJ/koqaG7cFicWUrFH8B2oaWFJkIutAYGhXSM/815lJA?=
 =?us-ascii?Q?DbEAyAQzpodhJykCoVMz8u2jmWoUO+l+Gq3EPsC99nv615xcZ6dkwljrHy0J?=
 =?us-ascii?Q?ypa/oQtJ6SoSIVNyeTYkQUutccA8Omfxcp+rRKuK0bEm1N1GZSjaQCzi9Xuv?=
 =?us-ascii?Q?s2U4d1c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:48:27.9133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98e9ed-8729-463a-042c-08dc83a9f009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

When switching on idx, the value of idx must be between 0 and 3.
The switch governing value idx cannot reach the default case.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 49881073ff58..fb1902ba0c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -183,8 +183,6 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
 			case 3:
 				pratio_vmax_freq = min_freq;
 				break;
-			default:
-				break;
 			}
 		}
 
-- 
2.25.1


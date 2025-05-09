Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8919C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 11:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9FD10EA24;
	Fri,  9 May 2025 11:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IA04XhtD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C0C10EA24
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 11:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAZ/+HKsVcAIOGhfjQJuBGfoV02KWQLe0MJD5SZc0SCFpV/2ORWLwAu7CbHnrK5pRW2/8eMPLYC/sm1a0Yig3lHoketa5ylKuULhh6bHxxz0StGGT394KZsgqfefXkA+usCiHPM1rilnKCgDVy74Cl0jdEc5UvaHF8GAbEwA2JSJt4VDBaFqh9ktZD2butL5dkL3edhQRAQOeZd5sxfwj1qBlFfKI80ZXUGJeW5V0ySALG5mTKjPX7sZ7Ywqfv3eGnyjccHfjvMCcG1wV48cxIt6dUyXS/J5T8b5REb76VQRWBQ/4+6CedmTkK95od8mf9IOGUr6tvVtr8e5MiO7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ5Udc+/TyqRvV6rC/EH3jT0GQmcFl+EwdXigsrni6k=;
 b=p/SdLqVJnSG87nlnqPCP4MMfpq4PmLawH5h2SwfJ14xyRvoZPgI1i6E8AJBWUQEqHurGBiOiOAfCNYlLZ3WZ24Mrjx1+n/MqRE4Z7mudiQy+tHYAi3vqh3eneuGfDmtVmTrtKP+KM00cCkft2TVJ7ryVOaHoWs9eEfP7oH1T3PXw/51bWEW5krkVBgJQMQGdDk8mEiqEnvW6DfMjuVSlkIk+FshcC+BY5BzqcjzG9fbXCw6rTliKAE4+/EI4lLBDXbMTeLKk7Nvv56+6I5LGggce5Ax433poW3YjLQ2j3c0RlwvjW5tkNvOwucjo2feH0god179C1GlT2qOtHTLg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ5Udc+/TyqRvV6rC/EH3jT0GQmcFl+EwdXigsrni6k=;
 b=IA04XhtD48U5pghrcQeAJupIwyf3KR7aL0C+ZGJH1apES41WC4AXgic8r6nZLQl6nT+pzrx5XcuK/VbNlXPNkPPRH549oX+2JSJzL9/vJFuceS2SHRqe2TcIkvb0QCEiGBA+ciI76tcl4Ro25Mp0cIMmV6PZy8Ab0ETa/Lyq7AM=
Received: from CH2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:610:50::38)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:37:45 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::f2) by CH2PR16CA0028.outlook.office365.com
 (2603:10b6:610:50::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 11:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 11:37:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 06:37:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Amber.Lin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Allow NPS2-CPX combination for VFs
Date: Fri, 9 May 2025 17:07:25 +0530
Message-ID: <20250509113725.312103-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509113725.312103-1-lijo.lazar@amd.com>
References: <20250509113725.312103-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9cd066-fa80-45f1-3139-08dd8eedea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lmR+1u2nSJK26ehytTFdemO67Awr8DyNl1JoUs0mZ1QLA5e+TG/4P4iZu0r5?=
 =?us-ascii?Q?utvoMiEmwYtMMXJX9yK0630lP/meVHB+AtlzfFvAvhqm9lkjxCcymlkS99xP?=
 =?us-ascii?Q?S3V99ikrRFbfeQAeXbRHBzr1tSyJCJOYUjuId34HGb+lV2dSI/qZ25T5uqxZ?=
 =?us-ascii?Q?NnmnoLooar/FyyL7dzz2q9bnd5/G6x/SQIdfrIprKKYuFrtv+bPiGr01MVm7?=
 =?us-ascii?Q?8KQywZqoJTWGkvaNyXCqpigTnpti7uxsHEicElx8Ex/gsMF+pOj23beSNbXs?=
 =?us-ascii?Q?PFmD5sB8nQFDWeFgihcvLilMUYK3tT/0Sfb7cVP5q9gcB7Tjfyyb8t7yj1Ut?=
 =?us-ascii?Q?7DClp6rIocg8qNyQHxDSFsJ+qtUyhjnh8jo3EUAvLpOOK5OQKAnP7FpwItmt?=
 =?us-ascii?Q?wmI3Q9DT+i1zOrc4Jwd5XDlcAb/ODo2L5TaGk+cMmaolYsUHl95ow7q7ut4Y?=
 =?us-ascii?Q?cFIZqitYmQ39x2+pDoBJtXGRwdxxD4YR6cVZUNCdiDl68g3cFnijrUHLceLo?=
 =?us-ascii?Q?yar5u3tg0R54JVAlwRbIRQzVOWjCzqzVPCS+VfIr3Rqj6RTax5EnxnAjVZo0?=
 =?us-ascii?Q?0X0cxuFfJDuCu1L/3nC9cCJQf78zGglBaXGFrPcA3Ir1jMMUMS4YdQzHthOW?=
 =?us-ascii?Q?GQywyrAdcJj8DIEKC4a6VjGhCbWJRnyjtfUv9sLVDhgR3m5lQWynP6nz1fx2?=
 =?us-ascii?Q?XqqkdBLfJMcXHVcGRyE0Bti7Y7JSz+vWjtxY4F6jvRikBVxP3kyO8FMfHsxF?=
 =?us-ascii?Q?afMl7MXJHfSQnLfSXNw/RDEofpjNa2uoaVWCW4p/B0feRrl2py0zcZwf36fQ?=
 =?us-ascii?Q?mfPlfdtsS36Fq9Q1cz9ca5+ik0KphU8XHpvVSCZyApEwT2u8oJGouoqTxxji?=
 =?us-ascii?Q?Wj6jfJ4QVa79B4l4kDQFLAU3rcz65RFVzbL/i9v66rSQeFhcVUZJP7XF+4a9?=
 =?us-ascii?Q?pZhPe1paeInNamBC8jfvsfH+OcqQ++C4ZlaVfvzP3SIbqyVjtDe1yjvPHraM?=
 =?us-ascii?Q?7KxWxKXg5gklblfRltFcwgUAf3DPRkQqZVScOejEo3tICIJNN7ntxSNz3ccx?=
 =?us-ascii?Q?99vzJs6kzNvbYzctYcmvITL4JAhKYk80ZoIITcFuMEBbdunqiAlkG0qDlrXh?=
 =?us-ascii?Q?LqfV26WhQYGeVMEBRhBsw6UA2ctMgtHw1EZMB84kqMOWRnYFoxybwUOei70K?=
 =?us-ascii?Q?/1woNXEaRqGf4jRosSlJfcLdr7+joIwg2y2JglQZyOQ1rk8gvW0rHSZaSD8k?=
 =?us-ascii?Q?s6EWmb6F9IsBkmdpWns+UDHhRI4JDxxB/p823HZYHXNGIgcwBWf/CEgFLnnR?=
 =?us-ascii?Q?epqhdMSmzcwfo64EpFANxlmfr2aaLe0PHfDcxdrKIP8bf214PuaU2VdpuCpL?=
 =?us-ascii?Q?ApKzxRB4sx420RB/XBi8Wkz9KYxytachXVidscmVBpS1+NqMqbyvmErAlA4A?=
 =?us-ascii?Q?9jGuz0opG2+Y88vFI8emqeo9EaO9ZcvQgAKNK8vj5KRPspagikcnlQXjqx9J?=
 =?us-ascii?Q?KRCO6FZVQg+W0S/K+Hw5TutxPdiRDnFBqsKs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:37:44.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9cd066-fa80-45f1-3139-08dd8eedea90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

CPX partition mode is compatible with NPS2 on aquavanjaram VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d4bd24e3c390..1c083304ae77 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -481,6 +481,8 @@ static int __aqua_vanjaram_get_px_mode_info(struct amdgpu_xcp_mgr *xcp_mgr,
 		*num_xcp = NUM_XCC(adev->gfx.xcc_mask);
 		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
 			     BIT(AMDGPU_NPS4_PARTITION_MODE);
+		if (amdgpu_sriov_vf(adev))
+			*nps_modes |= BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.1


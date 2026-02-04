Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76933E8B364
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1207410E349;
	Wed,  4 Feb 2026 03:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mV78bYLx";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961C910E349
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+cpMMUwz/YirqhX9NTQVZXYkrab0Mwpw3r6+Jmy5tk+Deu7HZQi20d4ok4Rs1TubZmiP4r2GVWGDmAjnADy4Ly1jVfLQC2pbWoenlYplQGCzcR2a69UPLJxQHnPyyglQL9IXp7fk9NtzK9BKUn507USDG6o9Fa1kjD0TMkhJqir45uWUogwDmSfJPYZUJP7TynFWs09q5LmhjgjGwXwX54PK0mzN16tERL8koiyyYGw10sTdBpt1QhH3FioDBJ62ja9nqI8S2666wG9XqOO+HMuVPQKRWhCNbl7et94zhh61vP0nciEiD78p2EU9pMUoeTsVep4vLE3vcmMIw8WtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ1a+Q+9M6guI5fI3Bv9lqrxq2CgGRHJhKj/O/KW60Q=;
 b=qRlMWWROFgG4T57P4cM9lRfIVf7jMxlSU85t5F26tRkMtaTLJQXt9vC2lACFuecJl33nYstt17pR/9M1pr9m7RstmeaxlDDfZWM1YiFE3rPBJ3LXeXXuL1s3bfiviZx+xcSzWjZS4kcouZwEDY2WyRT4E8LNlkPWYsQ8gRjI0zRmaCrRu/pgF7Glv6tfh870UJ5ojY7EzInM15tLwmIt/KD9stC4jW53nkIn2RZgQ9F4NAzc9PozvTSPSMtJFslGZP2ZZ3455oclAhqAWsvICYmrgkk4OlMbya8Pz8VJAet6HvT9JYY/vkpPxnH99c3ZITEo5RZ1h/aID9s84NUdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ1a+Q+9M6guI5fI3Bv9lqrxq2CgGRHJhKj/O/KW60Q=;
 b=mV78bYLxXjQAbKeDbn0XvDLe0yBxO8p1+6Hoc8MaCgiD++ODe1xFn7/0VRv8DspN3O46lDn0uD3npqzEz0FR6mRmjRGKM3LPcOR65mMVJiCbMmlJTDStSYdVQt1Xnfarkv0QV5/XIEH+cjfFYP0V9jEmSz6JyIzE/9UneOZQbRs=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:06:48 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::a8) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:47 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:46 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 02/13] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Wed, 4 Feb 2026 03:06:09 +0000
Message-ID: <20260204030621.33369-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1271e882-5dbb-4da7-49b3-08de639a6f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TqrGRf5eXxd5L8xdjQYCtejTAhdd8h2zmLC6FNxJCu8uKictlQ0WlFRO9+VG?=
 =?us-ascii?Q?U2DiTcC8gQPgQ4VtvxvWU7PP2+U7ab1sIW00RjCE8jsfJmIlfYy9kwijTJSa?=
 =?us-ascii?Q?qntC5JBNM1+en9wD2QnhgRi4vQGLYQdALVgV+BkXyNaxty+bagLSPwBr0BI8?=
 =?us-ascii?Q?ZulFMfxbEup6Axs2eRBr8CHKL9GRDS5d1thRtRjMWOPF5jAg8OW4wV4jgSrR?=
 =?us-ascii?Q?ndN4A5P/Bk05FVtefTxb1EZT+kL0WTcaqQceRQTXCrNdW+NrHpIAbAmIBdpR?=
 =?us-ascii?Q?kfkDiH5oNyXALdYw3mz8HK1dACbEWGrJFPCGfv0/VV/O9ogUqG6heVa2Fscm?=
 =?us-ascii?Q?ra2aEF4rWfpG+XHgnDmC72gR7sOryMhg6T21/fF0CncLC3Y6YbpdeGBAKHtx?=
 =?us-ascii?Q?JHrKfb5/iRO0HOC8LLQwDqAmhomS558D7S1RERbhQYuOs9IJ79nTV0m43iTd?=
 =?us-ascii?Q?ZjoAFAnb/su2nEKuBORYvIFkU53keHOE+sqeoGN7bsMA+2ZzI8xYEIqHyuJG?=
 =?us-ascii?Q?efesolnzRk8LIivjT/s8WcOI1ofKjUIo/AdTAtPAho0fmYEKGidmh7Siavab?=
 =?us-ascii?Q?Ly/GALrJpC5INDTIn5LnajRuD1tiayt9Rgproxo4OD32SwAruVHCCKrGNxex?=
 =?us-ascii?Q?FrEE8M6JriXjyy/sox73Lq+x9ccvyDSYivhj/apC+obHqkDMofPIZFNXC+S2?=
 =?us-ascii?Q?/UT9pnL6UqjT/7qFjxN55tIhGbUZcD4CtEWTarDjHytzM0Dp4Yv+eOpCh0bW?=
 =?us-ascii?Q?XIlHM3+w7vxVucNGJch3eqSS/Pfp7R9m0YEjyQAcWtLxwOq3w/YR8A6a0auq?=
 =?us-ascii?Q?eK/wPwd0CCjb6fIVVtlWGLehyTie5bDSdB2fstESIvHE9dgB4GWFXV2TbkEZ?=
 =?us-ascii?Q?K37NvPOIHHG6VyIriSuq76VmN4e10t4yajWG+EVxA1Cp1k9f6E4V+JoJSJ/2?=
 =?us-ascii?Q?T/3YMxWNrWtfKE0Jg200xvCz5sWmPxyEmG5NbxtCJc4Su3Wkti6LPbmWBceb?=
 =?us-ascii?Q?dUMCWfJe3f3JBZkaxOFDvuqckVmyrJPYrKOR8OK7cK+fu7hoJnMq4IhVJctJ?=
 =?us-ascii?Q?tEMHSUqJY2VcwgKggHrQh8H+G47iSZPrJpHa2+/x/jKlBovjq/X7zJY381uw?=
 =?us-ascii?Q?0hyl/y57fMq2uj/3qG+6lbrf6dWNv6kFeI8Jq/RLkzPutOIx+TB+kjbrqY5x?=
 =?us-ascii?Q?bCaawl5qT9rjJB8TKOvFz0Ij3uECbWsA8jvj1QP2oDmXXlty27bhOJHdPOH8?=
 =?us-ascii?Q?cT7zi4WlC76x932kSA58O4UbRLoobNX7APLVYOMnH3RnKV0QA/Xoqtznx8oa?=
 =?us-ascii?Q?ZizGxQsuB1HwDHr+djLqeIh7NCCgLoLhemAnU744xS/vKCRzsIuDCBdw+q4l?=
 =?us-ascii?Q?NhXjX4KmKA2bFCJpfwy3FkD50XCQOQ58WkrF4UEaz/1OHC4z1G/MMhaCceJM?=
 =?us-ascii?Q?Fcbi6ZBq4qxfH2VVRNhIDX0yMCff6loludO+LJ8EL9ofgaOJPtEXVXbspmXY?=
 =?us-ascii?Q?Jzz1J7BiGC+zCY/1OwTruXACpC08BkTUWr1KyxG4e/rN+uqDRJsLg4Eo8r7I?=
 =?us-ascii?Q?f9MMBnCTmVV4OPwqNZ1RLJq0NYRK5gtA8CZj5hyiDnublQ74CDocDYBElkl+?=
 =?us-ascii?Q?CSoua4cHb91UCkFBDkNR9Kjk1SdAL7g92OxHYxKI2qHATZHHARJPaV7dibxA?=
 =?us-ascii?Q?sfRJAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G4NBkeblU5UFXQyEsCTVnI1Tmvx0ey05KnKfz6rMyiF3PINCzZr3kFSS13G+hQodA1O6meDZskhdOB88JNIYet2cVFd6x32Y9eNzghT3fX7JkwY+XNvvqHkUKP9N8cfU8N2HNKzmgFkAxn9rmgZABVdzuCxvaHiNHtEs3a2Vf57cF2BOyCi6qVhoSxUFC77hEqCRLzYzvRLcv/ykOAo/3MWAOxKGQdRW+AMb6s45Y387wsmpfJ59tFb/tlF8qfVEdeVKUPSu2mEYMMt5z8MoLcZIJlohEcHrWi6GbpmJLGk5HoZ3kh0d/i7kNt8GjtDQch8+aU7m53RykpgAjqJgG6xIvlPXZvT4UmW/CCeyDVdO2uxyRfznDHZ5AF0ZShbaEoeOivN6KXYdk3smE2zy4ZDHya3utY5noIXMuD+4SDhAhvGNjBMBd6GNAlA7CNZe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:47.9913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1271e882-5dbb-4da7-49b3-08de639a6f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0


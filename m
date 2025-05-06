Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4309C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 20:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F2510E0F2;
	Tue,  6 May 2025 20:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wSQdzvli";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FEB10E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 20:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6+ABf2osEYHc16Kl8pXlc89e6iONYYBaEmYxGCNMhJvpXUZQKI8PR3+gpmNVYVGja9NpYt10WkaVVq7RXVT+cOa5/iR71ZJvkEr3m35cEDKTNH5vSFvwStYyJYK1vJFyRTa4+NTPbeewBejofl99hyfZlo9TKwdRb+SqXfOMoAMKqJ20IbfZ8B6yRCn2pbMUdYaCqcMpukmsUpcWu2bdknzcrdTrMI73s2vgLXtaczmWjtCOa+ri+7ff8UXZll+UAq7uin+VHkgQSpoxEtrnNtrD6MBbWEhmCnxZH4aRph0uEnR42y+yxqKSxcaBiuTiyVYYkFmiFtfpllOyO1K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xxQ5rj5mTqUYgYXzs43FBGMvFrTJTVUQOZCFO17RR0=;
 b=EEnVIw9W2rgf/n7UP/5WLTbfQecqEJsPXr6BwWdWwvxhI9j2HdiI9JOK5rsvjV9sX/9cVp2kXL2uoGnoNGpYQmNEBzr2Djgz7iH1eca8V48vJh0Jn7sByo+j456skQOg/JiYFpxxENhnjcBwLU14CwpI2qw7aBDbY3UuFCEptr3DgBg9SwMscpppOfIkLC82M5PnRm3eagScf3svXrGo7ooLQ9MfeVUmqKo3fEr5y1Aq2aPwzDZNI+KfPV6cSq1wmrI3bQHSiHRaLizgAGBpZLmEWozyAtZSBkYf58ysb7rja3HTN/GaFotaBUtqQAraGBsNIYEK9uWRaGwszeoCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xxQ5rj5mTqUYgYXzs43FBGMvFrTJTVUQOZCFO17RR0=;
 b=wSQdzvlikxMBcSd5/a8O9AP2f/jy2mGGU4F4MyO12i7tdkuDYdpZWwMm50HjOp3Csn3xd9Rrurd2lidcFoRCHmFtMG7hnfUDmk2jhPAWIoi59aBewW2ZckONU8Zi7dm5qcalyz9MmwnzbIXTjWepxPikEalyDE2r5n6QdZg8fQs=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 20:50:05 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::58) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 20:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:50:04 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 15:50:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Add workaround for VCN timeouts
Date: Tue, 6 May 2025 15:49:45 -0500
Message-ID: <20250506204948.12048-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: c27399b5-25de-4909-d5af-08dd8cdf9441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wM6Wp9AAqrPLV1t5gfSaFkIiqIh6Fu1/gBZYdlAY+x/UAl54+TtxUTG8xmoT?=
 =?us-ascii?Q?GcNGTZxA2a0PHfOl7mWMCmMpJ+XgS2SpXnX56J8i5PPhptH360rpW4OgyjOa?=
 =?us-ascii?Q?HXtUVeEoEh1ODO0tyoX5ZIdTT4o/0gey9dvvI/PzHa+YS7huzi2y46iMuNPt?=
 =?us-ascii?Q?BBmBmXPuPhyuyBBZsOfCRcUhuIEu02iDRyfp84LyqUEl+g66JW175NpdAR4n?=
 =?us-ascii?Q?VpCIINHioEe4NfTI6OkUUoeNx82BNDJowj9U0bJsOog1Rb8lDlpFY4xSAcL0?=
 =?us-ascii?Q?DSR4UJ9YUOycgRtSGAE7WdbJ7bCNj4Ild5TGRUoLj3/pKN++Vppt52Mbp3OC?=
 =?us-ascii?Q?PHabdGpJaF/4gmLG8K6pmZWxeCoP63JaIZloo1hq7qwL7Y3ijT1/Dt/c7unn?=
 =?us-ascii?Q?UGBAdvJTTObjgltL7aHRSP+ANTy8z+cq7SbdcpWDO6GNuA677rFqOC4jgrml?=
 =?us-ascii?Q?HPUcUFnh/39YqLgRTCcR00jEquzMIJlW05bgRQ2hNRtWB/itJE9xMiDUmDiP?=
 =?us-ascii?Q?TeCWYYjYbcit1toqVRsd1lJkEhc0PdY3w1woFLNpKUkJD+WYO4mTrNk+zFOb?=
 =?us-ascii?Q?Ce35lOUYYi2SvbUa1pnuYMgcaKym8AxVAAZRY6eptxWDLb0YOUyQgbFYOfz8?=
 =?us-ascii?Q?of0tB9kaV0AzhM5W43uVyQlaq+CuP1ef5J/LC9pHnP3knwREudVNsrbtJYWf?=
 =?us-ascii?Q?/pu+UDwQHY36arPcjzYhdEpLpTzbqEA45/z6OW0++A47VODX80Chv3BmXLLm?=
 =?us-ascii?Q?5VZeM0YOTWA4ehdp1u4GSk4FViiLY9d+6O1QqdmgRVdT07kBossRYWxUBsfH?=
 =?us-ascii?Q?3br+/dxJP5t9ggHQVSZw1c/gf+ZeezvIUu+wOJ+RlWPwYTUPgKT7v3uy+6GN?=
 =?us-ascii?Q?MFtWKh0ROtnc5m7n73VrI7oUZyXRqa+MUNCG/xz6N8GRk9En6tS5mYIc8bPE?=
 =?us-ascii?Q?gdMqi2axMyUzgeDr4r/bZLiFiv1CPMqNIT8Ed7XB9OA9RW4UthHyQ2euneJZ?=
 =?us-ascii?Q?rbG1FnWGHMtlWZfOfYC4Ldhc61bxAHhQBE68wHY+s4b6ShW542N45EcsWyyP?=
 =?us-ascii?Q?aIQqaTy09l2VIxCy1KnwIba9SwwxxFMMcAB8BaPS+0brg1eKOwKNLWdjfmgg?=
 =?us-ascii?Q?io1+PeKa0/Pjl7ZtXlFQMqiIeqWIimB91hdgOR0OLI0C9djap4ifsyGTHvj/?=
 =?us-ascii?Q?6THJhX00d4Co0AgVp+o8NjF8RfgD7zbzX+xada++ITiud1UUfKcJkCQJ2Kmt?=
 =?us-ascii?Q?ORdSkSf0JwFjHXf2K6Ppsj79iqBmOjCvMchQg8F5Rf6Yi8C00uzVMk+ld2X8?=
 =?us-ascii?Q?o8i/AFLK7zYAmIZLBl3AUjdyS/0CW4+MLITxq2VoNNCmNGV7KHPazD0IoBZW?=
 =?us-ascii?Q?Cs3VhapxIYYuAuWihmi8cdXiLgBk5VcUZ/GK2dClJmeutWxeDp9balkTXEN+?=
 =?us-ascii?Q?3EZYO2KCt+1+YxbY29op2kR4XOsYuyzeSgNJTtqZ76nS7dAupc4jtmq4Ezwa?=
 =?us-ascii?Q?0m1crMuS635KmRWyFfnlsTPAbrf3VFgedNNr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:50:04.8672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27399b5-25de-4909-d5af-08dd8cdf9441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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

There is an issue reported on platforms with VCN 4.0.5 that some jobs
are timing out.  This leads to a full GPU reset.  That full GPU reset
exposed a number of problems in DCN that have since been fixed, but
still the GPU reset means a black screen for ~500ms while the GPU resets.

However the issue with VCN in this case doesn't require a full GPU reset
to recover, just resetting VCN is enough.

For a workaround while the VCN issue is still being root caused lessen
the impact of VCN timeouts use the per-ring reset functionality to reset
just VCN.

v2:
 Also add support for per ring reset on other newer vcn4 and vcn5.
Mario Limonciello (3):
  drm/amd: Add per-ring reset for vcn v4.0.5 use
  drm/amd: Add per-ring reset for vcn v4.0.0 use
  drm/amd: Add per-ring reset for vcn v5.0.0 use

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 17 ++++++++++++++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.49.0


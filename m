Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B216CC3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7F510E3EE;
	Mon,  5 May 2025 13:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jowg1Ge";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE5E10E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ+VoLSsC8JW6hcpt1C3ervt3m6K9tNdZQ79x/kT5rl4OqnJIxQAAxaHMUIvCJl5GU4k+9ZyK7xuEC0kYYcpT8sBUhLi1hz4NJM6z3t7BqVFIpK8DJFRZq6Z73nnfLoqbsC9pvSHfEjIifKWI6bVv3H/QoKng28vMuJLfRtGhnx7vz+Rr0LPcQOLvI/hgPTruZwPqIxgcBSRJkD8txxyOPO+eUZuyU7AUUhg5KMkisPlDJYnlx69hIZ+Vh+tjqgM3kNqHWVU/jsltVGFbO5KSWO2X418BpH43ilcwPzCATvtiE2dAezF33sKoalB4IJYLxRFStfZpbR227lBL0hGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WGGb3HraY+6x7sfM5l97oBSbA6J1PI882mm0b7P3T0=;
 b=jPh9EDLJp93WIMS+1amjpVTk7YuYKPd7R//b29JdVy7SuRT+ytv6FDMAU1DKLNaPPEauM2b+2QWNDAIyYYSegLFf0DQgmcNYDcDS2CaqpsF6gVSQC7iGPkFUlE8QDtCcbv0R6uuHM6ZfjfEFvIyld7ve1aGh/A2HppvGTHwKfdBZjjLMxf/GO52l74U7skIZjctG0LVNYUUsRstlC1e0AWIONLsAwd+wzEtaWvGbKkBF3ZruZ9xfEoh4rqI04VlTZpC3EiGQKLt7lvDeNwYb39uG9F4JV1TpO5QG/wQgswUkQ4U0Ry3ltblgJivi4HY84vdk8HCUw4jGGNqNo5ZsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WGGb3HraY+6x7sfM5l97oBSbA6J1PI882mm0b7P3T0=;
 b=2jowg1GeyX9rcX8UkDau8ZjvxZ2DcTyO7887/uFSDYqhaKeTk3krAPghceUkjkNuiAFOBOOcSsMmj4Fu+xaROHvP83OuJXDt+ReUoUlIsRegoKOv7xpvr1/aV+XZ52WhSP+ZhHW8CjlJ7mVnVINtomMqYT2TFD46XYpRX7VOByU=
Received: from CH2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:610:4f::25)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.32; Mon, 5 May
 2025 13:05:15 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::af) by CH2PR18CA0015.outlook.office365.com
 (2603:10b6:610:4f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 13:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 2/7] drm/amdgpu/hdp4: use memcfg register to post the write
 for HDP flush
Date: Mon, 5 May 2025 09:04:54 -0400
Message-ID: <20250505130459.1985637-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbe77ee-9d7d-4698-0df0-08dd8bd57aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qc6S3VBfMLC9Gh2lxZl83gnIuHLBoRxMftCHUzLmwGe6B19yDZ9ZwClQdoER?=
 =?us-ascii?Q?/OqoEZf0uQUnV8nNGDeoO4J7SzqoRebZN4jxJy0xD7xz7ijbiB9OoR/ovNqH?=
 =?us-ascii?Q?eCFF2HEGtlpOktRYWN+28zPTFD5xxKspN9rEZpjmMbylVXDy9LmokJ0BnxMC?=
 =?us-ascii?Q?Bj5lQHWuxyMz28Z8WhTqOYs8CK24mXZa9d1KmF96HGNPlED5u1vcP3Ml1SzZ?=
 =?us-ascii?Q?cQszLoasbS1Et85zBKp3Kd+HUCcFJHlB3wNAv/Vb4YHarm6gTXOtXV816IJs?=
 =?us-ascii?Q?z7jxY4YB/Qv9l9snDMAcMN0Jiltck5yBuiMaLemSbWxsO6O77znf9yL1OdIm?=
 =?us-ascii?Q?8795XOzHV11Kf4uuPnz8MD3fCY8AqZK8OeTwh876dXeghBC1SqbYePbxUSEl?=
 =?us-ascii?Q?PImtRRPalcaepa3cTP/4JnlKOE3I3t9PkXgkYh6tqllPYugLhEitJ5yDH7/R?=
 =?us-ascii?Q?rYt/nNwxQd44hWnUF5rVSn3CMRAKx6kvNPMUOD6CcPFCKVfGhkM7UeRw2MW0?=
 =?us-ascii?Q?jU8TtbtTocGMSUvfOpyssqrpwwCcZacNe9QY8fKadnMzlNPllPbs1GZo+5X8?=
 =?us-ascii?Q?s+NyQB3ofocPRRSQZ+hU7nmq0Lg7dI4y75MwZ2Ko/4gci982AqFTbo2TF995?=
 =?us-ascii?Q?PxVOTiVkTJn0sNhMNk+0ihiyM12jfIgdQcDaL0IYCBTJAp4HnV0CBOtsmmZ0?=
 =?us-ascii?Q?TYoFwGlqVX8ogHvKXyWdTx3A47zOdhLAEHKhEQNGHvt1rgXmBWiMgB9shGf+?=
 =?us-ascii?Q?Bco04s9L/hxopEXIve2UCrSgACRWgMmcXQjPV3g6l4kqeqHSwi7Ivs5TjYZK?=
 =?us-ascii?Q?UYcBZcKjPp9IEJDKNPNO0IVhH+x9pODozFRwCytkixaY5lJxdarAfE8MvSTr?=
 =?us-ascii?Q?PJMzazO+af1zKRN44BcAjINNe2Bnh9656xIcuE2zmd/ETw6IePAnMkRt8xcY?=
 =?us-ascii?Q?3OqO9YUtgZNB/GT12+r+/fEuWXUobUmBapttXVUEFPm/E3iHLmzP419/qkY/?=
 =?us-ascii?Q?ebdkl1QzGNWjyBcRchsnvMoGQnTkp5ASnQG6b4WdVVlHv66Ate3r+Nek3M+N?=
 =?us-ascii?Q?16Y05plu42s0stYzaNdEdWzB0pfeb1spxTSZ2+AdTv7h8PWklDniypRU3ljC?=
 =?us-ascii?Q?SwHqBYBTRiXjUQXWrPed7PG1ehG+GzQjBUnK1jNCOzF98VDBfJCc5R3l+CDy?=
 =?us-ascii?Q?fLdVR6F7mRc25w32hKI8OCX1ExobrGOneuoHdgXh4b+PiWuTrrrVA+Mh66Bv?=
 =?us-ascii?Q?9rL52epJyD9vNPahy04XdbLwG3+paDp4K/88CJc2iTNloh538R1xHxqiw/H4?=
 =?us-ascii?Q?JM1LQqGcvZQu4WwVfVmUSBUpcuODlw1uxNqf6aJKnvnTz6P+aIXFZTiYUedT?=
 =?us-ascii?Q?25ah8z39Nh/3LMvfe6GOAsUZn7fXh8SqtFJzUT2eBUIJrWCVA6ikyjIVC9aA?=
 =?us-ascii?Q?yvdrt0xxAGeWaw2KxrxLpAwx0pKE4Ky58qJDfu7/ifxDwFCIOuQB/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:15.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbe77ee-9d7d-4698-0df0-08dd8bd57aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: c9b8dcabb52a ("drm/amdgpu/hdp4.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index f1dc13b3ab38e..cbbeadeb53f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -41,7 +41,12 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0


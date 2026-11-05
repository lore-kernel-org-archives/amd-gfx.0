Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A0606A32E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cAswc5Pe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0571B10FFD4;
	Thu,  5 Nov 2026 03:06:55 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17ACC10FD4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOEx3dRVEUV2fxEW5M1SgdzqKfxUECEzw7FKu5J9ideNDHgeDRMBWdA9cArA9DDle/GT+tLXGGym/eSJRQNDOy/t/HTAGK14/CU9vl1qFwqWWS5GfZUG8hSq/mfj+Xz+RqlcMtFFl8v7Vhun9X0gP0feDWQ7ogBx8v+xmuDQdzTtderCYFlNTxWJcc+KkE4iin8/CzSZP6NnWwLJUL28xLQctBfjgDA8r5q+EljFixBVqHNQxN8YHi1Uf2CLolVthNMjuo+TikcnGzaebtxAA+o09vX0hVH2reF3aC3GrZMpPuaRZJUha5XjlzAKFMCiiX2NFjPThXJOPvBKO14oWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LTZ9zlaWczXqZi5f+sqIPXRYd45f/9XM3Ah3gIgEzY=;
 b=V8lGtKA+9ARmG9tLW1Ax/ZH5oFpyfKLeegeHk5QiHZcYuMkU0YCdOiZDN13Q+sO5a8Tpf5H2ODJID90ikhNeLDV8+/IxKKFn3hmH9eNxWF3U4/etxixZfpfPo4jZzp9wCRQHed6crzhhStg7Q14sW2hvlnANmTI0Pn0klXRU5flUZHiHmDrCe+o4oOjNuNqMmTRAXbONVcBKLmWfS5WCcPPuZVvQECuc3JCYm4gfvkPKF/vcU5Fjx1j7iZ64/KkvJWUswqpUansniZ+3ljTXfGqBF3o4yH97MMrwvcTqMhg5C5doHPfUn/39kVx0gA8/0fObViA9q1HFnZgVLckZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTZ9zlaWczXqZi5f+sqIPXRYd45f/9XM3Ah3gIgEzY=;
 b=cAswc5PeNfLJKsE201z9QN13FIb/F0hEdfdQd2lnTarcdNcfstEiPVE/KCraUq6U5/kUts6S9201ZDexDK0RMu5oLw2rvMJfD+to2lHp9TYpAG1ZpHeNL53I94mcgidi0uGapnDLUv1xdodjnblxbyupcFb6uIuzhZYGMfkHA4Q=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:06:26 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::a8) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:23 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:20 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 04/13] drm/amdgpu/gfx: add callbacks to save and restore a
 gfx HQD
Date: Thu, 5 Nov 2026 11:05:46 +0800
Message-ID: <20261105030612.726542-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 762d1a38-1f05-411a-af87-08df3ae9c7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: yDVxd5ez2m/ODThSxFiUeM66Zz9DDf3zthsobikXRdQ8vhzCJF6D1CLGLSNTUcQf2/9ycB+lJwNtFJY5Bh0s8/k3IAFt0a/varkbhlfKpCV5XPUNhQ8oR4B+uy9bCz+yhX8BWFYAzXabe8x3vzMMNZp0fl4udQo0TPVYzBpmt9CrZbOZKq6OKESbaRR12e5yhByOKJ7B34gJFsR+Lu6Ylwav/CKuTRMxu0xzBzC+iaZS3SgVTNphC/N/1TfZqoOcl/d4tKFOL0J6R060mgMgzdbgu8gfsKq4jxNAUTSIpEr9U7E+RW9cZ6KSP9nLfqkI6lZ8C82tVpfOdDxxSzBZue8td46M79wgGHzH0oe+iEHgIoOPHJ0hEjMNotTXmsC6IpiQ3Q/WTGBoHEc8Coi3YFcEzoUIeI49mwRV+E++fSuvs40v/66izjy+cn+hgoxA1Avin2sObK7PP0DUtNockN2CpGf8hEOffZ6vIIt8KCHbP+grDh5SziJiCD53NMeXPngD+bC+0Bqo4UQ3uMIoAZU59Hvw8+ghWbqzxw3Tu8IZq3HBNrjT5AeYldzRWoaK+HRMus5hUKbLJP/0R7MD3B4UhAvil3Cg0ScAoDVafEmGkM4eJ3YOw9uI4YBA5C9UIKtMG0DbQGJKfcDmFI7a0SpgTtONmxG6VfNDbMFDioqZgESf+czSBO+QZh6BwKdwAa9z2buQwal2PuA4CtL/XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5CeQJU6mRjrKW1Nb+wXOLcRfFz78xw9rH6ImELGEHCVjP+CANLoU7/OKEIAOTyHIkCDw8ecGd8JH9Yffu6A56fyb0sAnwNPvPYQNVJ73esvJRjQexp9vuh0VUbUMNxyhP+lebr9SrgEAleEqt2Y5at1oJ9HSRZdlnJw7Hjv2qin608fRDUYzfYsGIQUbQIxwITX07YiMNOnxrG7Yvu0TJyb3+YbeGq9ClwVOCGUiMSQlrJWM/gtj39mONQHQBQqufgIo/al5i7JQy+Onr+yLWg1URyFlSxnSCzxNKyZYvrW69g1xIfjj65RFKYvEf76JnxBlT6KVhyRM4h8AGEOryNdNTlbPu/4o4Cqh1/l/g0+Kj2WlssQTW+5ex5PphyGguJPvrDvXvFFB3CWSqBeaX0KUms98Vp3QrSMypVurPHnQDMIrH7S30hrXZY15R5Gb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:26.6172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d1a38-1f05-411a-af87-08df3ae9c7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A gfx engine reset clears the HQD registers of the gfx queues, including
the only copy of the ring position of the queues MES didn't preempt.
MES doesn't save them in the MQD either when the engine hangs.

Add struct amdgpu_gfx_saved_hqd for that state, and gfx callbacks for
the gfx IP, which knows its registers and the layout of its MQD:
- save_hqd() saves the state of the gfx HQD of a doorbell;
- restore_hqd() writes it into the MQD after the reset, for MES to load
  it into the HQD when it maps the queue again.

v4: Rename to save_hqd()/restore_hqd() and struct amdgpu_gfx_saved_hqd
    (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..1c23e97fd04d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -345,6 +345,17 @@ struct amdgpu_gfx_shadow_info {
 	u32 eop_alignment;
 };
 
+/* State of a gfx HQD that a gfx engine reset clears. */
+struct amdgpu_gfx_saved_hqd {
+	u32	doorbell_index;
+	u64	mqd_addr;	/* the MQD loaded in the HQD */
+	bool	on_hqd;
+	u64	wptr;
+	u32	offset;
+	u32	csmd_rptr;
+	bool	connected;	/* the queue the pipe executes */
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -376,6 +387,17 @@ struct amdgpu_gfx_funcs {
 	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
 	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
 				  u32 *me, u32 *pipe, u32 *queue);
+	/* save the state of the gfx HQD of a doorbell, if it has one */
+	bool (*save_hqd)(struct amdgpu_device *adev, u32 doorbell_index,
+			 struct amdgpu_gfx_saved_hqd *hqd);
+	/*
+	 * write the HQD state saved by save_hqd() into a gfx MQD, for MES to
+	 * load it into the HQD when it maps the queue again;
+	 * true if the work up to hqd->wptr was dropped
+	 */
+	bool (*restore_hqd)(struct amdgpu_device *adev, void *mqd,
+			    u32 ring_size,
+			    const struct amdgpu_gfx_saved_hqd *hqd);
 };
 
 struct sq_work {
-- 
2.50.1


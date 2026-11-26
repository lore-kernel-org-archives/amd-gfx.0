Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CC606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CD9OXH5d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9E71121FE;
	Thu, 26 Nov 2026 09:34:44 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209EB1121E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNvT1g1UOIoOTQbkCrtmJRidX0nWXXQy+dvz6Y9Xz59y3trrmrCuptEp7V4xexabbhNYNZ4oeF8rLS3LI4kw9Zygsjgp3Wbnr9F58o/7D9Mp9ap3CgncpdrFAERCFul26kBYJEd/Tnf567Skjp7BgQQzGgjzFPSN3ceidvor8aj6gjid2VMR74goLCBkey99Z50l3pLwTC98oHoHYcwMCPPUQa05ZiHdAl1IUv6j7VKdEmMPOfy7ZKJqBvxyxww/NML092/XzziGIKHlWB3WfIUJyWJvP1SVlPTD6x6UFegZ1MReQkWyeVDJ6JN02ZgjCT9levJV7e621evVUR/zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oux+Qpm3hiP36vPXAjwQe5PvIP6w5HulgVgV1GfxPm0=;
 b=kWSalMfh/bOwB0qFCHDQN8RD2MfDdi7j0Z6x78IhXNK9GuVevOmS6HQcb9zqvIu/WyvAuy0ZY2dNo+mlbNbcNbe/GE6CX7RcGpJB1E5aWWTs8OTaiISbr1Isy2dAQMMZX7lK1FXohwGIsy0rEC0Fc4v5XRO99Q7+ha9kOnnkeNPqYVEL6LkfVLGQaq9mjN6zJe7lL9K1/OJhDHLA5+uK8jRBFUGtCKzET9jc2ORCIxhByPy+UiHbb/qwPJt7JhXRyk30cMHT3Xv5VYsM0+UDsVTuwUHrnUAIWPY5BvNb1sChwCA1502VGNdBvufZYwmX2nvtuTULuGtDrigCLNZooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oux+Qpm3hiP36vPXAjwQe5PvIP6w5HulgVgV1GfxPm0=;
 b=CD9OXH5dt3uKv6geWClVsBPpWhLr8IwyUIBsA7d50UWg1v3WTdZ59Ta4zvjecUu6BMZrQrmXexeA08EQlx9bc00060L8e7MTzpA4nyezLZDYtv2res/b06MTpljpvMaGGF0lXtmvO6+tXFqIpjYu03qFWOcnw9FZlLWjVmWgOvo=
Received: from CH5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:1f4::16)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:33 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8d) by CH5PR04CA0015.outlook.office365.com
 (2603:10b6:610:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 26 Nov 2026 09:34:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:33 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:30 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 04/15] drm/amdgpu/gfx: add callbacks to save and restore a
 gfx HQD
Date: Thu, 26 Nov 2026 17:33:40 +0800
Message-ID: <20261126093417.192538-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1e9966-f95f-4846-369d-08df4ba07aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|261102123227099003|10067099003|56012099006|11063799006|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: qffpUGsS0wv7CGI6tbJWcmmne0v7IX0I4lNEeq38krJcoOJrCnGZsWcwQ/uYxH+QoEcRi/YvuL0c0uX9c7+uvbyw35+PG0eI2+thtJLaFB/aFCtJNf2qq+F6B96yDB6d/eYYPOF+5liZU34HZR1phzsi69DgXiK/NEMhL3S4ngwLIdePWGP9A6J1thSq7BJlR0ftoCMohH0HtZqQhU7EgaT5vsRO0PwwvlFhcSGtqc9dGrnhizkYFAEgIQM7aq3ki6+dzLHWkNFtDKA4KsmmDtd5VrMjd6dM/u2kvep9rEdQe7VSgf6Ty/dSzUrrelfNmInAU64MHwlQPzN98uSMPPZ0v4cfDlerheRm6qOnjHtl48/2RTiBYIc4DY7bLCcm5AiSAJvPTkdqXBVQzT5iPVkH95sMI+oXi5+ySN0Fo9p6ToMorUg1df43yRLGKiPe2jfRn3JS3tx3TrDLiF6agr/xVdCCfrq4Cg94KiRsT7d/H4jmK1PySTxWfus8MVW2ie7+zkiFq8D27+IDB0f/ov1Whr4dpd4SIkY9yD6hJBiSPlrMS+8yklom8hvkj/Fozb6QSTvmbD/EasUGablEn7n/A4TbsIH7d1cPtDatNOafjryoZcSbqjtGygzn70docbOiabvF0BOdt//M0ZdKTNcltbVCIc/ywzvwS+na2Lj24K/cPHUXhoWjgpefzSjjhGrJpPYeNj+ssTJuPrs6xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(261102123227099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7eL3qDO+IZ40h2xltX7U+3Wg+MDcvd/IvheL7JV750HwIKOUoK78etnt+oT2lY7+D6JcCR/YMPMV+06veoIEZw/iRZxM0j6v/zLPjXseMoRiHuXpogVDgxf9QuDJvN6UcoXJbY+A0hbuSNnf5OV/bqzchIgoyu5yfVrlzMUQRi1uO4KKVPh47t2Os/nASOhZgKaVigfhQaMzfRv2GuS2Qh2gikDTNf2sLK6hAYq3xUv+ffeNvGObRmavc4u5RF1mlgkOsIb7v1rL99Rov6afxLzL6e9Onjmk3StnOoCp9vNqUyaJdLYYKt9KLfXWGjKB6pmjpiH9Z1vakxLApikz4hgcpAttsm+r6a86CxuDhnR4tUtqgfuG9yJJZI31v6usPn7SxwaUnig3GOwWu/ejjFaZnIl71R1g+ERqTk+Mrsx5pvAa5dxnQ3F0+eS7vp5Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:33.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1e9966-f95f-4846-369d-08df4ba07aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 99739b00c35f..ec77f24db0e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -340,6 +340,17 @@ struct amdgpu_gfx_shadow_info {
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
@@ -374,6 +385,17 @@ struct amdgpu_gfx_funcs {
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


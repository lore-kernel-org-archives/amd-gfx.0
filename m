Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09631C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B11510E714;
	Mon, 27 Mar 2023 19:36:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A6810E71A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geu5MFJpZ9ziTyX/Kj1njFV1uMG7rptstHQ0nUBk1++TvzIorwYUOJLpiq06OeYcstG1Qd9bhL/SRixG0+w7nUw1jRZBoF21yTutcN8ZXkmdTlC5pY4zIrnAE2dpogn0awjZuvPLL0EX4FsJbrCPC57fXE7iCB5y/etLBekq7How/xfwIRnfjKJwmENH8K/EOFFAjA7MGgYYXfUG7tOWcNiy5YqCrJaYNG0yxSfTw0nNPg+Kr1nowZhfjgN8gUNQHdPXZqssHmCT/e5GcUoc6RfLdvbhLXika0DbDlFqVG4HLSjWs4J7vJSX+9LGAge1JCu2KznE3JRSqwTOALUf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rvrPgCa/3WP2OHg/8/h7juz+lfNB9SQP2cAq7l27gI=;
 b=mxChrkQV4tNvmPe45q0lEIQE2unocCbkyf4NKgTjS/WkZ3NYxsxQYPVqldE+oLwxh5W+z8bbZtqYADrJkkicHqki7CLOc65MikE03GanKueob+Fuf2WduINQySE+vJvDRzXKrnKy15TFhGQTEKlX/itYGCctlIxpUE/YHDrIFyk4Zr2vfbhafiKfluRR4Dney2SYbLAD0KsNz8Us8QQP8RvK1dyb1AF009K3RMZU6mMe9INsmwXYoFu8pPnbJs/5kgYuaM8pB5PlgBVdvO3FL+Xv6hfRG+vm8Zj4jrWbJtk/0+3I7ocoqLuOTnmKnTnYhpg02LCvjzdPYcDL00lbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rvrPgCa/3WP2OHg/8/h7juz+lfNB9SQP2cAq7l27gI=;
 b=3l8HgBPkzl7Ev1I3SMVs9JMKMR6aK7uTXrkHIo9jiI/t6viRNc6psCb7ro4HwfOPEOeDwAt+vo6bazGonolM6ZVBSJYL5UGAj8eH+eL2A9nJM0EAnO/+k0EyGkZAit7ijL/b2Hr7VH6/S5VpiOmSP4JEwsC0xMzGaKPDyBUWgkM=
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:21 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::94) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/28] drm/amdgpu: add some basic elements for multiple XCD
 case
Date: Mon, 27 Mar 2023 15:35:36 -0400
Message-ID: <20230327193602.7901-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2e1999-893c-4607-bbe5-08db2efa8acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGPBYSHSsEwKETV60hSO6sEofO6+8hbZeiwfBoCMW+zvsZxBEDJOZZ+lA3nJC80l9F8i0Laq1Vxguc1BFZYlAaPCVVXNY6wCNEe6CDi8WNJlCdTd/9uYgeC29mDUJdcMiyGEbWrRk/eIlcvtGaKem92lj0joNoU+IDJhZmm0bvfYiAKWqG60z+fvmB0O/bNiq0rf8IzXW3Z7RnOeSEjz2xQQA+FN1gb+BxYbzFPB9d9pYKUGsmSk8Y516P8IJweSqgi26CDzGiRlwAz56DkOtJcLsp9GuoVVWzRT0yDthVnFSJAeYOTvwNtye616ULWEsS3LYQTra/qezpiEWSvBSKKFru/fi/FEfTqTQI+EWWtvO84jIJ8ewWczWSYi1wlc9EnR37JlRxPMAN00k8c6Cg7LZV82jgMIUP0H+kiXWd62Q3xf+AfNIPbradunzkL14l1MLNkIuHgH/yXisIDTzigfzhWJfyM4zA7xxuLyzui10lXG5yCTEsJSQbvqNaJhCuCjYMjoBoO/RzniS0AuZgJG4GPWf0iYAa1w1ObEIr33BU/wSVqnmAeOpCaryXJVzPh1XDMf0eCDARhk5MMPCEL0Ev/Enbqb/3vY+KX7a0zM1mZa0AbphS2ZASAGnE4tMM8OJgJVyMm3HSRh1A1t0xd3m+YPflECoGiiZy6B+qwe3y6q0APB8zeqKGaxrnOstLS5XQMXCV34517/6XGmZqKPnK8UkwGH44euu3UtDhk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(47076005)(426003)(86362001)(26005)(2616005)(186003)(40460700003)(16526019)(336012)(40480700001)(356005)(36860700001)(81166007)(82740400003)(8936002)(4326008)(6916009)(8676002)(70586007)(70206006)(5660300002)(36756003)(41300700001)(82310400005)(1076003)(316002)(6666004)(478600001)(7696005)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:20.8028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2e1999-893c-4607-bbe5-08db2efa8acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add some basic definitions and structure member. Inscrease MAX_WB slots
to 1024 to support the increasing number of rings for multiple partitions.

v2: unify naming style

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bbac4239ceb3..7c3288a1aa70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -490,7 +490,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 /*
  * Writeback
  */
-#define AMDGPU_MAX_WB 256	/* Reserve at most 256 WB slots for amdgpu-owned rings. */
+#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
 
 struct amdgpu_wb {
 	struct amdgpu_bo	*wb_obj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..bfabea76d166 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -42,6 +42,8 @@
 #define AMDGPU_GFX_CG_DISABLED_MODE		0x00000004L
 #define AMDGPU_GFX_LBPW_DISABLED_MODE		0x00000008L
 
+#define AMDGPU_MAX_GC_INSTANCES		8
+
 #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
 
@@ -53,6 +55,15 @@ enum amdgpu_gfx_pipe_priority {
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
+enum amdgpu_gfx_partition {
+	AMDGPU_SPX_PARTITION_MODE = 0,
+	AMDGPU_DPX_PARTITION_MODE = 1,
+	AMDGPU_TPX_PARTITION_MODE = 2,
+	AMDGPU_QPX_PARTITION_MODE = 3,
+	AMDGPU_CPX_PARTITION_MODE = 4,
+	AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE,
+};
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -323,7 +334,7 @@ struct amdgpu_gfx {
 	bool				cp_fw_write_wait;
 	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
 	unsigned			num_gfx_rings;
-	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
+	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
 	unsigned			num_compute_rings;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
@@ -364,6 +375,10 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	enum amdgpu_gfx_partition	partition_mode;
+	uint32_t			num_xcd;
+	uint32_t			num_xcc_per_xcp;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index fd269d6ddbf2..72a7afb852d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -248,6 +248,7 @@ struct amdgpu_ring {
 	uint64_t		ptr_mask;
 	uint32_t		buf_mask;
 	u32			idx;
+	u32			xcc_id;
 	u32			me;
 	u32			pipe;
 	u32			queue;
-- 
2.39.2


Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC17C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002EA2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Eo8f71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002EA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE2AD6E32D;
	Mon,  1 Jun 2020 18:21:57 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565A06E32D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:57 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w3so9993692qkb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XiTvMSIox4RwoRXKUGRiUcxoUnMkq0sM7iAPbpumARI=;
 b=Q7Eo8f71nidPinUFcHH0KYz6w/Y94+Hfb2T19i0sqAJ/szBeDsUeYdEIPSCjLVZqtT
 GUQbn/CeFT1PV1kVmYTTZMXJhbsQiEOYFE3/0rv+rJufcpeHIszlPmr5JrVFxVwwWNTs
 ulcIb0esgUDVlQJ8sMH3IJEPUOv0o1vcBEXsIQmF+CSXK9RPNXZS21ZdMyIlh21+BlgK
 /fhXdgPMZo6qE6jQqj6e5C5CVsQVYivf9bBJe8iIP6MaLZxoQB1buqVtWV4q/FyPs8+h
 u2mZ9FQxU8THJ+yKh5UVQWnDGokr9CamrzCu6jzzGE3YoV/FqHp2OLGTv1yp/VAhtLzt
 bZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XiTvMSIox4RwoRXKUGRiUcxoUnMkq0sM7iAPbpumARI=;
 b=ni8Ew9yiOhTxtx2wpRoXU5IXJsfeJuAz1gokcHPTQ9n+rJ6GyzeAzjIyRK4qyW73gg
 dKwDquinq2mPz6S3r9a117CBGGRcoQhCa6Um+bLDhLi/GA9Edio4csWFFm6+QsrqN4lW
 A9thINhd26+f5bi28Lw6JGaBJLyOJIY4r9aRmyZnvqPQSV3HIBUOFZ3akNBFH+dHyvf8
 Pi3dAxNd4XKCNO+R4V+LEmiKmgYM/F8q/UbTzz4uU1QXUNuoPZxnrfFpEV6a5whzqqA9
 iYngLHx9C+T59gWGZZNmmfm+zHXgRBDJALyHpChbJICaLjLRCz1n0SrGHnk1XyjvpwaN
 mv2w==
X-Gm-Message-State: AOAM530tNSZuvTNqdz1rMRfx9VQOUKSodDKZlO7LMeZL6gGssJrNUfNV
 au/BRYTqL89xI0WHhZae1ymZmZuY
X-Google-Smtp-Source: ABdhPJxAkxrQ1OpGWef2aLZzCyJZNO52yRIPEEMCNcn+sikWWNqXXo283USDi1cbV9I0A+3pNSbPSQ==
X-Received: by 2002:ae9:e904:: with SMTP id x4mr21280668qkf.398.1591035716004; 
 Mon, 01 Jun 2020 11:21:56 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 129/207] drm/amdgpu/mes: update mes fw api
Date: Mon,  1 Jun 2020 14:19:36 -0400
Message-Id: <20200601182054.1267858-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Update mes_api_def.h to match the latest mes fw.

v2: clean up coding style based on kernel standards:
  - fix indentation and alignment
  - break long lines
  - put the opening brace last on the line
  - remove unnecessary blank line and space
  - replace uint(32|64) with standard uint(32|64)_t

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_api_def.h | 644 ++++++++++++-----------
 1 file changed, 341 insertions(+), 303 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
index da040845de00..3f4fca5fd1da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
@@ -26,95 +26,88 @@
 
 #pragma pack(push, 4)
 
-typedef uint32_t uint32;
-typedef uint64_t uint64;
-
 #define MES_API_VERSION 1
 
-//Driver submits one API(cmd) as a single Frame and this command size is same for all API
-//to ease the debugging and parsing of ring buffer.
-enum {API_FRAME_SIZE_IN_DWORDS = 64};
+/* Driver submits one API(cmd) as a single Frame and this command size is same
+ * for all API to ease the debugging and parsing of ring buffer.
+ */
+enum { API_FRAME_SIZE_IN_DWORDS = 64 };
 
-//To avoid command in scheduler context to be overwritten whenenver mutilple interrupts come in, 
-//this creates another queue
-enum {API_NUMBER_OF_COMMAND_MAX   = 32};
+/* To avoid command in scheduler context to be overwritten whenenver mutilple
+ * interrupts come in, this creates another queue.
+ */
+enum { API_NUMBER_OF_COMMAND_MAX = 32 };
 
-enum MES_API_TYPE
-{
-    MES_API_TYPE_SCHEDULER = 1,
-    MES_API_TYPE_MAX
+enum MES_API_TYPE {
+	MES_API_TYPE_SCHEDULER = 1,
+	MES_API_TYPE_MAX
 };
 
-enum MES_SCH_API_OPCODE
-{
-    MES_SCH_API_SET_HW_RSRC                  = 0,
-    MES_SCH_API_SET_SCHEDULING_CONFIG        = 1, //agreegated db, quantums, etc
-    MES_SCH_API_ADD_QUEUE                    = 2,
-    MES_SCH_API_REMOVE_QUEUE                 = 3,
-    MES_SCH_API_PERFORM_YIELD                = 4,
-    MES_SCH_API_SET_GANG_PRIORITY_LEVEL      = 5, //For windows GANG = Context
-    MES_SCH_API_SUSPEND                      = 6,
-    MES_SCH_API_RESUME                       = 7,
-    MES_SCH_API_RESET                        = 8,
-    MES_SCH_API_SET_LOG_BUFFER               = 9,
-    MES_SCH_API_CHANGE_GANG_PRORITY          = 10,
-    MES_SCH_API_QUERY_SCHEDULER_STATUS       = 11,
-    MES_SCH_API_PROGRAM_GDS                  = 12,
-    MES_SCH_API_MAX                          = 0xFF
+enum MES_SCH_API_OPCODE {
+	MES_SCH_API_SET_HW_RSRC			= 0,
+	MES_SCH_API_SET_SCHEDULING_CONFIG	= 1, /* agreegated db, quantums, etc */
+	MES_SCH_API_ADD_QUEUE			= 2,
+	MES_SCH_API_REMOVE_QUEUE		= 3,
+	MES_SCH_API_PERFORM_YIELD		= 4,
+	MES_SCH_API_SET_GANG_PRIORITY_LEVEL	= 5,
+	MES_SCH_API_SUSPEND			= 6,
+	MES_SCH_API_RESUME			= 7,
+	MES_SCH_API_RESET			= 8,
+	MES_SCH_API_SET_LOG_BUFFER		= 9,
+	MES_SCH_API_CHANGE_GANG_PRORITY		= 10,
+	MES_SCH_API_QUERY_SCHEDULER_STATUS	= 11,
+	MES_SCH_API_PROGRAM_GDS			= 12,
+	MES_SCH_API_SET_DEBUG_VMID		= 13,
+	MES_SCH_API_MISC			= 14,
+	MES_SCH_API_MAX				= 0xFF
 };
 
-union MES_API_HEADER
-{
-    struct
-    {
-        uint32 type	: 4; // 0 - Invalid; 1 - Scheduling; 2 - TBD
-        uint32 opcode   : 8;
-        uint32 dwsize   : 8; //including header
-        uint32 reserved : 12;
-    };
-
-    uint32 u32All;
+union MES_API_HEADER {
+	struct {
+		uint32_t type		: 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
+		uint32_t opcode		: 8;
+		uint32_t dwsize		: 8; /* including header */
+		uint32_t reserved	: 12;
+	};
+
+	uint32_t	u32All;
 };
 
-enum MES_AMD_PRIORITY_LEVEL
-{
-    AMD_PRIORITY_LEVEL_LOW       = 0,
-    AMD_PRIORITY_LEVEL_NORMAL    = 1,
-    AMD_PRIORITY_LEVEL_MEDIUM    = 2,
-    AMD_PRIORITY_LEVEL_HIGH      = 3,
-    AMD_PRIORITY_LEVEL_REALTIME  = 4,
-    AMD_PRIORITY_NUM_LEVELS
+enum MES_AMD_PRIORITY_LEVEL {
+	AMD_PRIORITY_LEVEL_LOW		= 0,
+	AMD_PRIORITY_LEVEL_NORMAL	= 1,
+	AMD_PRIORITY_LEVEL_MEDIUM	= 2,
+	AMD_PRIORITY_LEVEL_HIGH		= 3,
+	AMD_PRIORITY_LEVEL_REALTIME	= 4,
+	AMD_PRIORITY_NUM_LEVELS
 };
 
-enum MES_QUEUE_TYPE
-{
-    MES_QUEUE_TYPE_GFX,
-    MES_QUEUE_TYPE_COMPUTE,
-    MES_QUEUE_TYPE_SDMA,
-    MES_QUEUE_TYPE_MAX,
+enum MES_QUEUE_TYPE {
+	MES_QUEUE_TYPE_GFX,
+	MES_QUEUE_TYPE_COMPUTE,
+	MES_QUEUE_TYPE_SDMA,
+	MES_QUEUE_TYPE_MAX,
 };
 
-struct MES_API_STATUS
-{
-    uint64 api_completion_fence_addr;
-    uint64 api_completion_fence_value;
+struct MES_API_STATUS {
+	uint64_t	api_completion_fence_addr;
+	uint64_t	api_completion_fence_value;
 };
 
 enum { MAX_COMPUTE_PIPES = 8 };
-enum { MAX_GFX_PIPES	 = 2 };
-enum { MAX_SDMA_PIPES    = 2 };
+enum { MAX_GFX_PIPES = 2 };
+enum { MAX_SDMA_PIPES = 2 };
 
-enum { MAX_COMPUTE_HQD_PER_PIPE     = 8 };
-enum { MAX_GFX_HQD_PER_PIPE         = 8 };
-enum { MAX_SDMA_HQD_PER_PIPE        = 10 };
+enum { MAX_COMPUTE_HQD_PER_PIPE = 8 };
+enum { MAX_GFX_HQD_PER_PIPE = 8 };
+enum { MAX_SDMA_HQD_PER_PIPE = 10 };
 
 enum { MAX_QUEUES_IN_A_GANG = 8 };
 
-enum VM_HUB_TYPE
-{
-    VM_HUB_TYPE_GC = 0,
-    VM_HUB_TYPE_MM = 1,
-    VM_HUB_TYPE_MAX,
+enum VM_HUB_TYPE {
+	VM_HUB_TYPE_GC = 0,
+	VM_HUB_TYPE_MM = 1,
+	VM_HUB_TYPE_MAX,
 };
 
 enum { VMID_INVALID = 0xffff };
@@ -122,283 +115,328 @@ enum { VMID_INVALID = 0xffff };
 enum { MAX_VMID_GCHUB = 16 };
 enum { MAX_VMID_MMHUB = 16 };
 
-enum MES_LOG_OPERATION
-{
-    MES_LOG_OPERATION_CONTEXT_STATE_CHANGE = 0
+enum MES_LOG_OPERATION {
+	MES_LOG_OPERATION_CONTEXT_STATE_CHANGE = 0
 };
 
-enum MES_LOG_CONTEXT_STATE
-{
-    MES_LOG_CONTEXT_STATE_IDLE = 0,
-    MES_LOG_CONTEXT_STATE_RUNNING = 1,
-    MES_LOG_CONTEXT_STATE_READY = 2,
-    MES_LOG_CONTEXT_STATE_READY_STANDBY = 3,
+enum MES_LOG_CONTEXT_STATE {
+	MES_LOG_CONTEXT_STATE_IDLE		= 0,
+	MES_LOG_CONTEXT_STATE_RUNNING		= 1,
+	MES_LOG_CONTEXT_STATE_READY		= 2,
+	MES_LOG_CONTEXT_STATE_READY_STANDBY	= 3,
 };
 
-struct MES_LOG_CONTEXT_STATE_CHANGE
-{
-    void*                   h_context;
-    enum MES_LOG_CONTEXT_STATE   new_context_state;
+struct MES_LOG_CONTEXT_STATE_CHANGE {
+	void				*h_context;
+	enum MES_LOG_CONTEXT_STATE	new_context_state;
 };
 
-struct MES_LOG_ENTRY_HEADER
-{
-    uint32 first_free_entry_index;
-    uint32 wraparound_count;
-    uint64 number_of_entries;
-    uint64 reserved[2];
+struct MES_LOG_ENTRY_HEADER {
+	uint32_t	first_free_entry_index;
+	uint32_t	wraparound_count;
+	uint64_t	number_of_entries;
+	uint64_t	reserved[2];
 };
 
-struct MES_LOG_ENTRY_DATA
-{
-    uint64 gpu_time_stamp;
-    uint32 operation_type; //operation_type is of MES_LOG_OPERATION type
-    uint32 reserved_operation_type_bits;
-    union
-    {
-        struct MES_LOG_CONTEXT_STATE_CHANGE  context_state_change;
-        uint64                        reserved_operation_data[2];
-    };
+struct MES_LOG_ENTRY_DATA {
+	uint64_t	gpu_time_stamp;
+	uint32_t	operation_type; /* operation_type is of MES_LOG_OPERATION type */
+	uint32_t	reserved_operation_type_bits;
+	union {
+		struct MES_LOG_CONTEXT_STATE_CHANGE	context_state_change;
+		uint64_t				reserved_operation_data[2];
+	};
 };
 
-struct MES_LOG_BUFFER
-{
-    struct MES_LOG_ENTRY_HEADER header;
-    struct MES_LOG_ENTRY_DATA   entries[1];
+struct MES_LOG_BUFFER {
+	struct MES_LOG_ENTRY_HEADER	header;
+	struct MES_LOG_ENTRY_DATA	entries[1];
 };
 
-union MESAPI_SET_HW_RESOURCES
-{
-    struct
-    {
-        union MES_API_HEADER                header;
-        uint32                              vmid_mask_mmhub;
-        uint32                              vmid_mask_gfxhub;
-        uint32                              gds_size;
-        uint32                              paging_vmid;
-        uint32                              compute_hqd_mask[MAX_COMPUTE_PIPES];
-        uint32                              gfx_hqd_mask[MAX_GFX_PIPES];
-        uint32                              sdma_hqd_mask[MAX_SDMA_PIPES];
-        uint32                              agreegated_doorbells[AMD_PRIORITY_NUM_LEVELS];
-        uint64                              g_sch_ctx_gpu_mc_ptr;
-        struct MES_API_STATUS               api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI_SET_HW_RESOURCES {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		vmid_mask_mmhub;
+		uint32_t		vmid_mask_gfxhub;
+		uint32_t		gds_size;
+		uint32_t		paging_vmid;
+		uint32_t		compute_hqd_mask[MAX_COMPUTE_PIPES];
+		uint32_t		gfx_hqd_mask[MAX_GFX_PIPES];
+		uint32_t		sdma_hqd_mask[MAX_SDMA_PIPES];
+		uint32_t		agreegated_doorbells[AMD_PRIORITY_NUM_LEVELS];
+		uint64_t		g_sch_ctx_gpu_mc_ptr;
+		uint64_t		query_status_fence_gpu_mc_ptr;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+				uint32_t disable_reset	: 1;
+				uint32_t reserved	: 31;
+			};
+			uint32_t	uint32_t_all;
+		};
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__ADD_QUEUE
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        uint32                      process_id;
-        uint64                      page_table_base_addr;
-        uint64                      process_va_start;
-        uint64                      process_va_end;
-        uint64                      process_quantum;
-        uint64                      process_context_addr;
-        uint64                      gang_quantum;
-        uint64                      gang_context_addr;
-        uint32                      inprocess_gang_priority;
-        enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
-        uint32                      doorbell_offset;
-        uint64                      mqd_addr;
-        uint64                      wptr_addr;
-        enum MES_QUEUE_TYPE         queue_type;
-        uint32                      gds_base;
-        uint32                      gds_size;
-        uint32                      gws_base;
-        uint32                      gws_size;
-        uint32                      oa_mask;
-
-        struct
-        {
-            uint32 paging      : 1;
-            uint32 program_gds : 1;
-            uint32 reserved    : 30;
-        };
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__ADD_QUEUE {
+	struct {
+		union MES_API_HEADER		header;
+		uint32_t			process_id;
+		uint64_t			page_table_base_addr;
+		uint64_t			process_va_start;
+		uint64_t			process_va_end;
+		uint64_t			process_quantum;
+		uint64_t			process_context_addr;
+		uint64_t			gang_quantum;
+		uint64_t			gang_context_addr;
+		uint32_t			inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL	gang_global_priority_level;
+		uint32_t			doorbell_offset;
+		uint64_t			mqd_addr;
+		uint64_t			wptr_addr;
+		enum MES_QUEUE_TYPE		queue_type;
+		uint32_t			gds_base;
+		uint32_t			gds_size;
+		uint32_t			gws_base;
+		uint32_t			gws_size;
+		uint32_t			oa_mask;
+
+		struct {
+			uint32_t paging			: 1;
+			uint32_t debug_vmid		: 4;
+			uint32_t program_gds		: 1;
+			uint32_t is_gang_suspended	: 1;
+			uint32_t is_tmz_queue		: 1;
+			uint32_t reserved		: 24;
+		};
+		struct MES_API_STATUS		api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__REMOVE_QUEUE
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        uint32                      doorbell_offset;
-        uint64                      gang_context_addr;
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-};
+union MESAPI__REMOVE_QUEUE {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		doorbell_offset;
+		uint64_t		gang_context_addr;
 
-union MESAPI__SET_SCHEDULING_CONFIG
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        // Grace period when preempting another priority band for this priority band.
-        // The value for idle priority band is ignored, as it never preempts other bands.
-        uint64                      grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+		struct {
+			uint32_t unmap_legacy_gfx_queue	: 1;
+			uint32_t reserved		: 31;
+		};
+		struct MES_API_STATUS	api_status;
+	};
 
-        // Default quantum for scheduling across processes within a priority band.
-        uint64                      process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
 
-        // Default grace period for processes that preempt each other within a priority band.
-        uint64                      process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+union MESAPI__SET_SCHEDULING_CONFIG {
+	struct {
+		union MES_API_HEADER	header;
+		/* Grace period when preempting another priority band for this
+		 * priority band. The value for idle priority band is ignored,
+		 * as it never preempts other bands.
+		 */
+		uint64_t		grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+		/* Default quantum for scheduling across processes within
+		 * a priority band.
+		 */
+		uint64_t		process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+		/* Default grace period for processes that preempt each other
+		 * within a priority band.
+		 */
+		uint64_t		process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+		/* For normal level this field specifies the target GPU
+		 * percentage in situations when it's starved by the high level.
+		 * Valid values are between 0 and 50, with the default being 10.
+		 */
+		uint32_t		normal_yield_percent;
+		struct MES_API_STATUS	api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
 
-        // For normal level this field specifies the target GPU percentage in situations when it's starved by the high level.
-        // Valid values are between 0 and 50, with the default being 10.
-        uint32                      normal_yield_percent;
+union MESAPI__PERFORM_YIELD {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		dummy;
+		struct MES_API_STATUS	api_status;
+	};
 
-        struct MES_API_STATUS       api_status;
-    };
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
 
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__CHANGE_GANG_PRIORITY_LEVEL {
+	struct {
+		union MES_API_HEADER		header;
+		uint32_t			inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL	gang_global_priority_level;
+		uint64_t			gang_quantum;
+		uint64_t			gang_context_addr;
+		struct MES_API_STATUS		api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__PERFORM_YIELD
-{
-    struct
-    {
-        union MES_API_HEADER    header;
-        uint32                  dummy;
-        struct MES_API_STATUS   api_status;
-    };
+union MESAPI__SUSPEND {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - suspend all gangs; true - specific gang */
+		struct {
+			uint32_t suspend_all_gangs	: 1;
+			uint32_t reserved		: 31;
+		};
+		/* gang_context_addr is valid only if suspend_all = false */
+		uint64_t		gang_context_addr;
 
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-};
+		uint64_t		suspend_fence_addr;
+		uint32_t		suspend_fence_value;
+
+		struct MES_API_STATUS	api_status;
+	};
 
-union MESAPI__CHANGE_GANG_PRIORITY_LEVEL
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        uint32                      inprocess_gang_priority;
-        enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
-        uint64                      gang_quantum;
-        uint64                      gang_context_addr;
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__SUSPEND
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        //false - suspend all gangs; true - specific gang
-        struct
-        {
-            uint32                  suspend_all_gangs : 1;
-            uint32                  reserved : 31;
-        };
-        //gang_context_addr is valid only if suspend_all = false
-        uint64                      gang_context_addr;
-
-        uint64                      suspend_fence_addr;
-        uint32                      suspend_fence_value;
-
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__RESUME {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - resume all gangs; true - specified gang */
+		struct {
+			uint32_t resume_all_gangs	: 1;
+			uint32_t reserved		: 31;
+		};
+		/* valid only if resume_all_gangs = false */
+		uint64_t		gang_context_addr;
+
+		struct MES_API_STATUS	api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__RESUME
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        //false - resume all gangs; true - specified gang
-        struct
-        {
-            uint32                  resume_all_gangs : 1;
-            uint32                  reserved : 31;
-        };
-        //valid only if resume_all_gangs = false
-        uint64                      gang_context_addr;
-
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__RESET {
+	struct {
+		union MES_API_HEADER	header;
+
+		struct {
+			uint32_t reset_queue	: 1;
+			uint32_t reserved	: 31;
+		};
+
+		uint64_t		gang_context_addr;
+		uint32_t		doorbell_offset; /* valid only if reset_queue = true */
+		struct MES_API_STATUS	api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__RESET
-{
-    struct
-    {
-        union MES_API_HEADER        header;
+union MESAPI__SET_LOGGING_BUFFER {
+	struct {
+		union MES_API_HEADER	header;
+		/* There are separate log buffers for each queue type */
+		enum MES_QUEUE_TYPE	log_type;
+		/* Log buffer GPU Address */
+		uint64_t		logging_buffer_addr;
+		/* number of entries in the log buffer */
+		uint32_t		number_of_entries;
+		/* Entry index at which CPU interrupt needs to be signalled */
+		uint32_t		interrupt_entry;
+
+		struct MES_API_STATUS	api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
 
-        struct
-        {
-            uint32                  reset_queue : 1;
-            uint32                  reserved : 31;
-        };
+union MESAPI__QUERY_MES_STATUS {
+	struct {
+		union MES_API_HEADER	header;
+		bool			mes_healthy; /* 0 - not healthy, 1 - healthy */
+		struct MES_API_STATUS	api_status;
+	};
 
-        uint64                      gang_context_addr;
-        uint32                      doorbell_offset; //valid only if reset_queue = true
-        struct MES_API_STATUS       api_status;
-    };
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
 
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__PROGRAM_GDS {
+	struct {
+		union MES_API_HEADER	header;
+		uint64_t		process_context_addr;
+		uint32_t		gds_base;
+		uint32_t		gds_size;
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+		struct MES_API_STATUS	api_status;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__SET_LOGGING_BUFFER
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        //There are separate log buffers for each queue type
-        enum MES_QUEUE_TYPE         log_type;
-        //Log buffer GPU Address
-        uint64                      logging_buffer_addr;
-        //number of entries in the log buffer
-        uint32                      number_of_entries;
-        //Entry index at which CPU interrupt needs to be signalled
-        uint32                      interrupt_entry;
-
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+union MESAPI__SET_DEBUG_VMID {
+	struct {
+		union MES_API_HEADER	header;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+				uint32_t use_gds	: 1;
+				uint32_t reserved	: 31;
+			} flags;
+			uint32_t	u32All;
+		};
+		uint32_t		reserved;
+		uint32_t		debug_vmid;
+		uint64_t		process_context_addr;
+		uint64_t		page_table_base_addr;
+		uint64_t		process_va_start;
+		uint64_t		process_va_end;
+		uint32_t		gds_base;
+		uint32_t		gds_size;
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
-union MESAPI__QUERY_MES_STATUS
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        bool                        mes_healthy; //0 - not healthy, 1 - healthy
-        struct MES_API_STATUS       api_status;
-    };
+enum MESAPI_MISC_OPCODE {
+	MESAPI_MISC__MODIFY_REG,
+	MESAPI_MISC__MAX,
+};
 
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+enum MODIFY_REG_SUBCODE {
+	MODIFY_REG__OVERWRITE,
+	MODIFY_REG__RMW_OR,
+	MODIFY_REG__RMW_AND,
+	MODIFY_REG__MAX,
 };
 
-union MESAPI__PROGRAM_GDS
-{
-    struct
-    {
-        union MES_API_HEADER        header;
-        uint64                      process_context_addr;
-        uint32                      gds_base;
-        uint32                      gds_size;
-        uint32                      gws_base;
-        uint32                      gws_size;
-        uint32                      oa_mask;
-        struct MES_API_STATUS       api_status;
-    };
-
-    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+enum { MISC_DATA_MAX_SIZE_IN_DWORDS = 20 };
+
+union MESAPI__MISC {
+	struct {
+		union MES_API_HEADER	header;
+		enum MESAPI_MISC_OPCODE	opcode;
+		struct MES_API_STATUS	api_status;
+
+		union {
+			struct {
+				enum MODIFY_REG_SUBCODE	subcode;
+				uint32_t		reg_offset;
+				uint32_t		reg_value;
+			} modify_reg;
+			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
+		};
+	};
+
+	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
 #pragma pack(pop)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

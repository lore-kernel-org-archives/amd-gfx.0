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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F065C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EDD207D0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr/wcaa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EDD207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133456E2C0;
	Mon,  1 Jun 2020 18:04:25 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83AE6E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:23 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v79so9909821qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8twXqm6ORdryCXO7pYD6yYakev2KokdsEFhG6UEKQrc=;
 b=cr/wcaa8M1MXt9fEq0hWd1N8wroL2Fkw+SXmXkvZ3WS3Z/bl988QfULkWGgla9Ne30
 gtfb16ZIv52osE0Sw1ELnuv3IlmdnHld5qf1goqWI4t7dzErAX1CSVyOIb6onLwWn/Fp
 Fcbo+REAKj5nereUdQfG3JvL6Wl/jQmNEDw+Oh+Tg/43sH+MheFsnTXns+3pos73jNmc
 iS0IrqVd/QoAV4XLatT4aS8ncRIWoYgep40Ln7xj1kTsUo3cAI8qTmtsaY0ncbQFjdeO
 zZyZ7zWhv0R6hAK59Vm0Z3V4YZf6UPzBnID/C97qlHfql6bcAnMpkGHLgogr6Jxm0kom
 thkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8twXqm6ORdryCXO7pYD6yYakev2KokdsEFhG6UEKQrc=;
 b=KMboddCqiqCjnL3jWw+LRz3DJGM2U2uCGbJQIlLO04EyGaWQYl1okgu3Y5DRsogRGJ
 4PMZBnvm57AlDItWclS2/29cPm9xv7Lca345uAPwQkjourrpcnEbiyU6Ktkh248qhViO
 eA35sKtz/hEOmZZPuHbvnguBKo9Qf3URwCM9VZl9O8WCcaBZ+so87uK89PAEdvjT8SWA
 G08jS/mAZ/OUzqEjgfmRsy2Dg9Z5RfBctpQZOQcIVa/s5vA4oC/eTjqgRbZATVe/csiw
 p4FckuCG7DnbNGZ5M+fN5JudusrQZCO3U3EyQdjG1o8XM8WYe5UY/jI3C1+B6/f10N4v
 aMnA==
X-Gm-Message-State: AOAM532s4f4O1UfZGuKLl8opElihToTW9s4kAfhQqTC9lUExQU+ZjICY
 OdWxHZzWJPxgDh+PATwQlil6S2L1
X-Google-Smtp-Source: ABdhPJx535hpI6NWE7hkBS7L58tscIGfmNGTE5cIRoXeEvdCq3ctPuPInRCg8HXEcM71hPFBkgI66w==
X-Received: by 2002:a05:620a:2287:: with SMTP id
 o7mr20493550qkh.238.1591034662521; 
 Mon, 01 Jun 2020 11:04:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 067/207] drm/amdgpu/mes10.1: add the mes fw api
Date: Mon,  1 Jun 2020 14:00:19 -0400
Message-Id: <20200601180239.1267430-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add the definitions of mes commands.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_api_def.h | 405 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |   1 +
 2 files changed, 406 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_api_def.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
new file mode 100644
index 000000000000..da040845de00
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
@@ -0,0 +1,405 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __MES_API_DEF_H__
+#define __MES_API_DEF_H__
+
+#pragma pack(push, 4)
+
+typedef uint32_t uint32;
+typedef uint64_t uint64;
+
+#define MES_API_VERSION 1
+
+//Driver submits one API(cmd) as a single Frame and this command size is same for all API
+//to ease the debugging and parsing of ring buffer.
+enum {API_FRAME_SIZE_IN_DWORDS = 64};
+
+//To avoid command in scheduler context to be overwritten whenenver mutilple interrupts come in, 
+//this creates another queue
+enum {API_NUMBER_OF_COMMAND_MAX   = 32};
+
+enum MES_API_TYPE
+{
+    MES_API_TYPE_SCHEDULER = 1,
+    MES_API_TYPE_MAX
+};
+
+enum MES_SCH_API_OPCODE
+{
+    MES_SCH_API_SET_HW_RSRC                  = 0,
+    MES_SCH_API_SET_SCHEDULING_CONFIG        = 1, //agreegated db, quantums, etc
+    MES_SCH_API_ADD_QUEUE                    = 2,
+    MES_SCH_API_REMOVE_QUEUE                 = 3,
+    MES_SCH_API_PERFORM_YIELD                = 4,
+    MES_SCH_API_SET_GANG_PRIORITY_LEVEL      = 5, //For windows GANG = Context
+    MES_SCH_API_SUSPEND                      = 6,
+    MES_SCH_API_RESUME                       = 7,
+    MES_SCH_API_RESET                        = 8,
+    MES_SCH_API_SET_LOG_BUFFER               = 9,
+    MES_SCH_API_CHANGE_GANG_PRORITY          = 10,
+    MES_SCH_API_QUERY_SCHEDULER_STATUS       = 11,
+    MES_SCH_API_PROGRAM_GDS                  = 12,
+    MES_SCH_API_MAX                          = 0xFF
+};
+
+union MES_API_HEADER
+{
+    struct
+    {
+        uint32 type	: 4; // 0 - Invalid; 1 - Scheduling; 2 - TBD
+        uint32 opcode   : 8;
+        uint32 dwsize   : 8; //including header
+        uint32 reserved : 12;
+    };
+
+    uint32 u32All;
+};
+
+enum MES_AMD_PRIORITY_LEVEL
+{
+    AMD_PRIORITY_LEVEL_LOW       = 0,
+    AMD_PRIORITY_LEVEL_NORMAL    = 1,
+    AMD_PRIORITY_LEVEL_MEDIUM    = 2,
+    AMD_PRIORITY_LEVEL_HIGH      = 3,
+    AMD_PRIORITY_LEVEL_REALTIME  = 4,
+    AMD_PRIORITY_NUM_LEVELS
+};
+
+enum MES_QUEUE_TYPE
+{
+    MES_QUEUE_TYPE_GFX,
+    MES_QUEUE_TYPE_COMPUTE,
+    MES_QUEUE_TYPE_SDMA,
+    MES_QUEUE_TYPE_MAX,
+};
+
+struct MES_API_STATUS
+{
+    uint64 api_completion_fence_addr;
+    uint64 api_completion_fence_value;
+};
+
+enum { MAX_COMPUTE_PIPES = 8 };
+enum { MAX_GFX_PIPES	 = 2 };
+enum { MAX_SDMA_PIPES    = 2 };
+
+enum { MAX_COMPUTE_HQD_PER_PIPE     = 8 };
+enum { MAX_GFX_HQD_PER_PIPE         = 8 };
+enum { MAX_SDMA_HQD_PER_PIPE        = 10 };
+
+enum { MAX_QUEUES_IN_A_GANG = 8 };
+
+enum VM_HUB_TYPE
+{
+    VM_HUB_TYPE_GC = 0,
+    VM_HUB_TYPE_MM = 1,
+    VM_HUB_TYPE_MAX,
+};
+
+enum { VMID_INVALID = 0xffff };
+
+enum { MAX_VMID_GCHUB = 16 };
+enum { MAX_VMID_MMHUB = 16 };
+
+enum MES_LOG_OPERATION
+{
+    MES_LOG_OPERATION_CONTEXT_STATE_CHANGE = 0
+};
+
+enum MES_LOG_CONTEXT_STATE
+{
+    MES_LOG_CONTEXT_STATE_IDLE = 0,
+    MES_LOG_CONTEXT_STATE_RUNNING = 1,
+    MES_LOG_CONTEXT_STATE_READY = 2,
+    MES_LOG_CONTEXT_STATE_READY_STANDBY = 3,
+};
+
+struct MES_LOG_CONTEXT_STATE_CHANGE
+{
+    void*                   h_context;
+    enum MES_LOG_CONTEXT_STATE   new_context_state;
+};
+
+struct MES_LOG_ENTRY_HEADER
+{
+    uint32 first_free_entry_index;
+    uint32 wraparound_count;
+    uint64 number_of_entries;
+    uint64 reserved[2];
+};
+
+struct MES_LOG_ENTRY_DATA
+{
+    uint64 gpu_time_stamp;
+    uint32 operation_type; //operation_type is of MES_LOG_OPERATION type
+    uint32 reserved_operation_type_bits;
+    union
+    {
+        struct MES_LOG_CONTEXT_STATE_CHANGE  context_state_change;
+        uint64                        reserved_operation_data[2];
+    };
+};
+
+struct MES_LOG_BUFFER
+{
+    struct MES_LOG_ENTRY_HEADER header;
+    struct MES_LOG_ENTRY_DATA   entries[1];
+};
+
+union MESAPI_SET_HW_RESOURCES
+{
+    struct
+    {
+        union MES_API_HEADER                header;
+        uint32                              vmid_mask_mmhub;
+        uint32                              vmid_mask_gfxhub;
+        uint32                              gds_size;
+        uint32                              paging_vmid;
+        uint32                              compute_hqd_mask[MAX_COMPUTE_PIPES];
+        uint32                              gfx_hqd_mask[MAX_GFX_PIPES];
+        uint32                              sdma_hqd_mask[MAX_SDMA_PIPES];
+        uint32                              agreegated_doorbells[AMD_PRIORITY_NUM_LEVELS];
+        uint64                              g_sch_ctx_gpu_mc_ptr;
+        struct MES_API_STATUS               api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__ADD_QUEUE
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        uint32                      process_id;
+        uint64                      page_table_base_addr;
+        uint64                      process_va_start;
+        uint64                      process_va_end;
+        uint64                      process_quantum;
+        uint64                      process_context_addr;
+        uint64                      gang_quantum;
+        uint64                      gang_context_addr;
+        uint32                      inprocess_gang_priority;
+        enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+        uint32                      doorbell_offset;
+        uint64                      mqd_addr;
+        uint64                      wptr_addr;
+        enum MES_QUEUE_TYPE         queue_type;
+        uint32                      gds_base;
+        uint32                      gds_size;
+        uint32                      gws_base;
+        uint32                      gws_size;
+        uint32                      oa_mask;
+
+        struct
+        {
+            uint32 paging      : 1;
+            uint32 program_gds : 1;
+            uint32 reserved    : 30;
+        };
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__REMOVE_QUEUE
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        uint32                      doorbell_offset;
+        uint64                      gang_context_addr;
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_SCHEDULING_CONFIG
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        // Grace period when preempting another priority band for this priority band.
+        // The value for idle priority band is ignored, as it never preempts other bands.
+        uint64                      grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+
+        // Default quantum for scheduling across processes within a priority band.
+        uint64                      process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+
+        // Default grace period for processes that preempt each other within a priority band.
+        uint64                      process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+
+        // For normal level this field specifies the target GPU percentage in situations when it's starved by the high level.
+        // Valid values are between 0 and 50, with the default being 10.
+        uint32                      normal_yield_percent;
+
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__PERFORM_YIELD
+{
+    struct
+    {
+        union MES_API_HEADER    header;
+        uint32                  dummy;
+        struct MES_API_STATUS   api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__CHANGE_GANG_PRIORITY_LEVEL
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        uint32                      inprocess_gang_priority;
+        enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+        uint64                      gang_quantum;
+        uint64                      gang_context_addr;
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SUSPEND
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        //false - suspend all gangs; true - specific gang
+        struct
+        {
+            uint32                  suspend_all_gangs : 1;
+            uint32                  reserved : 31;
+        };
+        //gang_context_addr is valid only if suspend_all = false
+        uint64                      gang_context_addr;
+
+        uint64                      suspend_fence_addr;
+        uint32                      suspend_fence_value;
+
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESUME
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        //false - resume all gangs; true - specified gang
+        struct
+        {
+            uint32                  resume_all_gangs : 1;
+            uint32                  reserved : 31;
+        };
+        //valid only if resume_all_gangs = false
+        uint64                      gang_context_addr;
+
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESET
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+
+        struct
+        {
+            uint32                  reset_queue : 1;
+            uint32                  reserved : 31;
+        };
+
+        uint64                      gang_context_addr;
+        uint32                      doorbell_offset; //valid only if reset_queue = true
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_LOGGING_BUFFER
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        //There are separate log buffers for each queue type
+        enum MES_QUEUE_TYPE         log_type;
+        //Log buffer GPU Address
+        uint64                      logging_buffer_addr;
+        //number of entries in the log buffer
+        uint32                      number_of_entries;
+        //Entry index at which CPU interrupt needs to be signalled
+        uint32                      interrupt_entry;
+
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__QUERY_MES_STATUS
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        bool                        mes_healthy; //0 - not healthy, 1 - healthy
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__PROGRAM_GDS
+{
+    struct
+    {
+        union MES_API_HEADER        header;
+        uint64                      process_context_addr;
+        uint32                      gds_base;
+        uint32                      gds_size;
+        uint32                      gws_base;
+        uint32                      gws_size;
+        uint32                      oa_mask;
+        struct MES_API_STATUS       api_status;
+    };
+
+    uint32 max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+#pragma pack(pop)
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 36a92bf2c4ca..da89b6a6507c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -29,6 +29,7 @@
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
 #include "v10_structs.h"
+#include "mes_api_def.h"
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

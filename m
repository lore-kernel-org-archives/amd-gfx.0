Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50900C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B133110E4ED;
	Fri, 21 Jan 2022 20:34:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C04810E4ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDBG3yoIIG8+hs/jGIEhRqK0jft6wZfY+iEbPY/11V+zZjhI42fUFrLCWWM24AXKlxSnfJ0FsFdhDGROo1lGFBiCRqWQTamKavYLhIc368M3/fA6xvIiqtFLO2B7cCIwuW4v59lRiaxgHuzY88IZaUiuPYN3N9iVUegZv0VxLHdM8nyH+9T4N26TVDb83B15LX+5/K2+ePwEbVsMkMN/1GKy/dYM7KDNn9jNnAvuwOs6OVsOiMgmIr4MeWDD99Dcu1OCPQVNHtRa1rC38pr+rhWQ4J6qdgEMXoBiUQOCw4M8xqpZaj/HjIrYyToSOJyp5biSD7AUWWzK/Tqm6VNnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5fn6toxhv6MkL1R62uHryrKhHAYUItJv9xK6OlHk3E=;
 b=W6qUN2y+I2G2/FYGv+XGRKUIlPJfSEE+281hJB8oadOdoy4ZflJG6/1SLv6kpNSo0WRwuehAk397F87vv22Lo8IoZn3UxhSxznOpVYozNcQamXuCiES0Jy0INna8kKSjP78xNqpuIYOAIOBNFghOAwTLlMc6kiWeaz3WNVoJBwDSQLcOTu2xgvZQ30aj0c/w56H1zV9N0fGsz5GH18kw2yf4JHM2GaNE6qJ8b5TXZRR95WJW+VJNzEj+/Zpz7+j8yhOURH3LbdgOmG9+ttCnvCfdObdrK06DghNm6t2htgNoxATiiD6FsaR7a396sCFV3qFtMAaQ/xIzgaX/RTtoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5fn6toxhv6MkL1R62uHryrKhHAYUItJv9xK6OlHk3E=;
 b=Sge0LdAhSQhVBkl45wbZSZ0QA07NreSyaocWMJE/JgkLV40J/8yFELwfBvuKoEiYt5BAc3XkURJgzL22YtfCiwaHsCWNWIY4bV1heOtuFqWkbMQ+KxK0XkemHPHnyg2Forx1I9yT8wnRlrDCmEICy7g0CwNncF0eRtvMMmXaIJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 20:34:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 20:34:25 +0000
Message-ID: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
Date: Fri, 21 Jan 2022 21:34:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d6c5a6-aa0d-41a4-d399-08d9dd1d6a0c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55558BBE7933056E9A4A9C77F25B9@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiCy62F7ObMqKsVZ00hdCyg+Z9G+ECOxsbXOAt7qS0Qhh5u8KDSuHJrhn4BcAm3KnaZM1BvIxiUUOeY9hRor4XUebq3e8V7ILUHjGsOkxJ7S2v5qQTxaO/tHonphNtIYhcYdPWy5TNbjzzQKk6lHVNvVuxbDDYV+ZK/6bfOZfRC76RxwwR8BgfD3151XrJ12+H4/i61/H2eeMlNABpMahF2L5uEYjwXzOicohgyo0QaAy9SYlMyWQ9xJgH4lxYNcWEp8YmGxNVm/IsaDDXHknlacgOkDVpjZWl7+AVM6QP1D0n5aUc9lEIFGpZUsu1aEGrP1zmE8wFploVosrLnZpR0vzgs8yx15V/Z5/0BbY2YUkXgYkj28WuZFNVovFEIqTSEBQPm8/jrZKPssC4O5/jNt/GF/SqVEc/FUBW37ltn5Af17JrMoE3xu4vzMxIK2Q/OvY8yFEl7mY5oGU0WUSRC5u/kndBW9t4H7jzUf9ae4HHEw/A7kBfrs4agimnfRNrUuirmBwkkK7SfwEGXqsUPNWX7jQ7PX71DXV90oG3/lNDu6463CIiYAVmCTW9TpoLaTWey4HmPYEEN/qxFVi9LX2mJDU4XpL2o7ApZ1B6fNP8nLkm1Ezp06RxFRq34/hAbELxVivWqzwtAYKODn+sVd7qrakt6v0yjDBdoLM0yfjrBd0/7kbt77uSBoe5vR8n/xM+/AFGoNRpBI0jn0/+Ci3SsKgRI7J3KUEcto0kY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(186003)(54906003)(31686004)(316002)(5660300002)(508600001)(26005)(6512007)(6666004)(66556008)(66476007)(66946007)(83380400001)(36756003)(8676002)(38100700002)(31696002)(2906002)(86362001)(53546011)(6486002)(6916009)(6506007)(2616005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTcwczVtNm5jT0FSNDBHN21oUnBrc0kxZXBDOXhiUzJ5dDVMakxhOEN0MXFG?=
 =?utf-8?B?TWYyOHU2R3hzTUE2a0xZajVYMXlEM1VINzRBVWRDb01BbVNFaTFGdTgyYzk0?=
 =?utf-8?B?cDRQdFRQK09SNEREcXBNQUtXUzVpeXpXZmdsTENhTUg5VHk4ODVIYVVjTDlF?=
 =?utf-8?B?WUJ0RFpSaFBUT3B5K2EvV0YrQkVBNzJvVVI1OGZYQ0R0U0plUXZYMHZrczRH?=
 =?utf-8?B?OVJINnpQMWxFVCtqL2RGckM4YmJxTkNXRXJiclNmTnhBbTEwZDNSSy9pS25q?=
 =?utf-8?B?MFF4bmUraDZjbnhFai96UkxvN2kzSmFld1hFeEt0MmF2aU1tSk42dVF4NkRV?=
 =?utf-8?B?Q3BjZ0J1bjNrWXFyK0FyVDlvYjBPTWRZTlNnRUdpTitvbDArUERyQVo1SVBR?=
 =?utf-8?B?UDFoR29wZVYvS1NPdEJIRzA2bGpzTlB5MG02R0FwY0M0a3V5OEdtSXkwQ1pK?=
 =?utf-8?B?enFzNTNVVHB5S3JQWUt4V0xlbi9RdHpIaDBYdUx1TW9naVQ5Z09LNWE5QUtK?=
 =?utf-8?B?d3A1MGtLcWMrS2dwQ0FkQkx1N2hYZ1IyMk5EbUs2eTJ2ck12K1B1V3BrN1ZS?=
 =?utf-8?B?U1UxbUI1L25LaG5TbXlGUTZaandwUm9YWjkxOEhXZE8xeWd4d3d4U3AvenNo?=
 =?utf-8?B?TlRIbkJPeGUrRWU1bGVTUVpiV09rRnZrVkt0T1FySFBKTnc4ekFiSG9aYmVR?=
 =?utf-8?B?ako5b3BqVzROZ0dZODhxblBKQWJnQWgrNnc5dlhOb1VIQ21Da2svWGs4N1pD?=
 =?utf-8?B?S05NQ1cvVDdvTGQvSkRhQlgvaDlOU2VldG5nWnZzQW5nVm1IR1NteXdNeEdZ?=
 =?utf-8?B?RlZ0Wkl4OUtUVjM1bkFnRTQyRGgrMHVGZU5VYkdxMmc5U1RvYk9PS2psd3lj?=
 =?utf-8?B?dGRYQ09MaDdhV2RiemZQcWVuRjEwZ0MyS082NEpkSWNBbmt1cmoxT1NvbGlm?=
 =?utf-8?B?ZVE5N0dRUEZCUkQ1NHllK0hVS0paZE9qMzZNbDdHbnZMc0RrM2V0QTl1aTB6?=
 =?utf-8?B?ajhWM3had1ZVYldzUjFmc3NrZGFyMkZlREs1ZlloOE4xTmdobkhXVXVjWW1O?=
 =?utf-8?B?WkNzblY1MldiOXlXOERCbXJSeElmZVo4ZHlhaDNmNFRNVGh2dVNtWEtpMEtR?=
 =?utf-8?B?OSsyZWxubkJ6WkxCcndybjB5YjBCOHo4cEY4OWhPZzh5bVBoOTd3MXJ5RG5h?=
 =?utf-8?B?NUNBaXZTU3RYVXZBVjlKZERURXFPMmJwZnJldGkwS2dvWm53azdQdG4waEZ4?=
 =?utf-8?B?T0NiOGZ1RUFKMGVkOEdDazl6VER0b1NBZURuWDZGWkNxOGM1M1RKTHBKTlNX?=
 =?utf-8?B?SWhWSFl5Um9jK1MrUGNNaHR4VEtEQlRxa09WUXFUUmxlWTJmeWdzU2xnMVNV?=
 =?utf-8?B?UTIzQml4eTBGWjVQVFJ2c1lObGhsUmR3b2w5TjBWSHVYdjM3czVLVlBtVXhm?=
 =?utf-8?B?SFpncGlzWXlpV1FESmx3RE1obTUxVzFiVmpUYWdtbXJ4NHVSWXVQYWhidyt0?=
 =?utf-8?B?NjZCeUljVEx0Q2hpTGNvaTZSbG5oV2dzVmE0VlBRZ256TUJtUFZSVmdxeEZN?=
 =?utf-8?B?OGhmRi83NkJ3eVNiczVwNFg1YitQVjFOcGd2cnhBbU5PN2pBekFOeGxLNm1u?=
 =?utf-8?B?aTdBanZvU0R2VVc1VCtRWEwyQkNPV2lNMTI5VEgxTG1LbEZ0SGUwSFgzbjF5?=
 =?utf-8?B?c0xBMlo1V25mMzBNTGdtQlVWdXpwOGlNVXFpQy8rVVc5WGQ2eTN5Rm9GRjZn?=
 =?utf-8?B?bEdYSktERWdSTTJOTHM5N1o4L0k1TjBjNlg1U0FtQTRibkJpQnBlVDd5MVVC?=
 =?utf-8?B?dEd4WnZUNFpuY0pOMEhZS0tmU0xoZGFCMTJsbWhWSExoRFpvbUxtL1ZkY0l5?=
 =?utf-8?B?cVJJTjFSSWp3djBWd29rU3dkTERORjdsSUY0OEtMVmwyMU5yQnBaM0RKQnJ1?=
 =?utf-8?B?Ti8yYUszZ29mc1hZRmRvWHlFaWgrYmVJakZxK3FTVjJQN0ZLVUhlZDJHZmE1?=
 =?utf-8?B?WTZsUmJBazhCK0MveTBLMG5Oa2ZjSCs5cnp5V2JwVklKcUcreTBJczhWZHpI?=
 =?utf-8?B?R0RDRXdJbXJhNnQ1QUVHdmtYV0R0ZWpMNFBMdk51aklkYTE2R24vRlk3UTRl?=
 =?utf-8?B?NHhEeURuZGhGZzNxRWVXUFphbEVSa3pGOHNwUkM3bHJFTnFPdXMwWS81SFJD?=
 =?utf-8?Q?guwbx2MwlWsq56O31OhR6cQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d6c5a6-aa0d-41a4-d399-08d9dd1d6a0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:34:25.6556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQPO2voJVqR3VsN5LM2CqLVc4vod8li9VMSB0TJXUqMs73cGCs1/vsl/4NIeD8axnmt/gYtlYHSb/PHQfFj1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 2001
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Date: Fri, 21 Jan 2022 14:19:10 +0530
Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump function for
  gfx_v10_0

Implementation of register trace dump function on the AMD GPU resets

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
  3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..c97b53b54333 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
  		      __entry->seqno)
  );

+TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
+	    TP_PROTO(char *reg_dumps),
+	    TP_ARGS(reg_dumps),
+	    TP_STRUCT__entry(__string(dumps, reg_dumps)),
+	    TP_fast_assign(__assign_str(dumps, reg_dumps);),
+	    TP_printk("amdgpu register dump {%s}", __get_str(dumps))
+);
+
  #undef AMDGPU_JOB_GET_TIMELINE_NAME
  #endif

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 16dbe593cba2..05974ed5416d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -46,7 +46,7 @@
  #include "v10_structs.h"
  #include "gfx_v10_0.h"
  #include "nbio_v2_3.h"
-
+#include "amdgpu_trace.h"
  /*
   * Navi10 has two graphic rings to share each graphic pipe.
   * 1. Primary ring
@@ -188,6 +188,12 @@
  #define RLCG_ERROR_REPORT_ENABLED(adev) \
  	(amdgpu_sriov_reg_indirect_mmhub(adev) || 
amdgpu_sriov_reg_indirect_gc(adev))

+#define N_REGS (17)
+#define DUMP_REG(addr) do {					\
+		(dump)[i][0] = (addr);				\
+		(dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);	\
+	} while (0)
+
  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -7488,7 +7494,6 @@ static int gfx_v10_0_hw_init(void *handle)
  {
  	int r;
  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
  	if (!amdgpu_emu_mode)
  		gfx_v10_0_init_golden_registers(adev);

@@ -7602,6 +7607,49 @@ static int gfx_v10_0_hw_fini(void *handle)
  	return 0;
  }

+static int gfx_v10_0_reset_reg_dumps(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i = 0;
+	uint32_t (*dump)[2], n_regs = 0;
+	char *reg_dumps;
+
+	dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	reg_dumps = kmalloc(1024, GFP_KERNEL);
+
+	if (dump == NULL || reg_dumps == NULL)
+		return -ENOMEM;
+
+	DUMP_REG(mmGRBM_STATUS2);
+	DUMP_REG(mmGRBM_STATUS_SE0);
+	DUMP_REG(mmGRBM_STATUS_SE1);
+	DUMP_REG(mmGRBM_STATUS_SE2);
+	DUMP_REG(mmGRBM_STATUS_SE3);
+	DUMP_REG(mmSDMA0_STATUS_REG);
+	DUMP_REG(mmSDMA1_STATUS_REG);
+	DUMP_REG(mmCP_STAT);
+	DUMP_REG(mmCP_STALLED_STAT1);
+	DUMP_REG(mmCP_STALLED_STAT1);
+	DUMP_REG(mmCP_STALLED_STAT3);
+	DUMP_REG(mmCP_CPC_STATUS);
+	DUMP_REG(mmCP_CPC_BUSY_STAT);
+	DUMP_REG(mmCP_CPC_STALLED_STAT1);
+	DUMP_REG(mmCP_CPF_STATUS);
+	DUMP_REG(mmCP_CPF_BUSY_STAT);
+	DUMP_REG(mmCP_CPF_STALLED_STAT1);
+
+	n_regs = i;
+
+	for (i = 0; i < n_regs; i++)
+		sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", dump[i][0], 
dump[i][1]);
+
+	trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
+	kfree(dump);
+	kfree(reg_dumps);
+
+	return 0;
+}
+
  static int gfx_v10_0_suspend(void *handle)
  {
  	return gfx_v10_0_hw_fini(handle);
@@ -9367,6 +9415,7 @@ static const struct amd_ip_funcs 
gfx_v10_0_ip_funcs = {
  	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
  	.set_powergating_state = gfx_v10_0_set_powergating_state,
  	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
+	.reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
  };

  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
b/drivers/gpu/drm/amd/include/amd_shared.h
index 257f280d3d53..76d3a55278df 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -296,6 +296,7 @@ struct amd_ip_funcs {
  				     enum amd_powergating_state state);
  	void (*get_clockgating_state)(void *handle, u32 *flags);
  	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
+	int (*reset_reg_dumps)(void *handle);
  };


-- 
2.32.0


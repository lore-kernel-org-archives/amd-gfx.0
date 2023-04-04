Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C31C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC36D10E70B;
	Tue,  4 Apr 2023 16:30:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F89510E70A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfOIVGc03pcOW2cZx/LC+66c555B42QRVgAN04RFrZyYuVJ2mOROKa5muGQDmXkuTROWb//A8D0PfZneNUfKOL8SjsyYSAIs5gcFZVUSFj1Lz7bep3SeVI1733qKFugjNa5uMJjszG2W3lkxOaWAqWddPDyiWUiBaCAM39mRGJ8BrR5KUMdDXNm+4SAGUwiQsjtbtrouG3IkstElaUOX80MndEd3f/69pisY2XTvRD29G+6H0p9dFXfVu+oJ7z3NMWN1vzOfwMt5+n91WPVjwpNVmy1pNasPbs0rbhSYNkWRfsWwlYkYgkwSXWd3RXKV0575Mq+Xg+RnU5foutgcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpmLjNOgoB94h7m7uqGHNjB604/DnSs4yohGNGQuGhw=;
 b=Sn20B8fnnYVGjpDdikEqMkDJQS0J6/kS847J09k//wB6F+A3Zzq5rFQ2quQZ4VtPsOKKZoENAFkr9Ec1sqF4pEO2WrywCmZLSnQaG2DbIXyfTT80os5OCY7DpSuQbjHzLWUs+q65b2FZ51KHj0dXRGcLyfyBKvsoHModLjZ9S8fJ2JTLzYMmZjM1Ue1ervAgR2zUPl32A7Hiys5PKGArFM7zVOxSB1WUE57O5YRevdS7fyc0q7Fp8864lRDhMFh9lP90s0sS9dYLlOshw9a7btrq6vba88RGn7bRng0/iO/IzPA41n9JBZs3/K9a01jN0sZKB7C6l42Gh6pxP5/qNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpmLjNOgoB94h7m7uqGHNjB604/DnSs4yohGNGQuGhw=;
 b=IQGgivaJkUe9/tzH9txgs15SFXbv9mhW+E7sCbRrX9CTkYtjpma9Nlg8e4M+Vxmtl4YaEYSRd0YWyy1ETC5OlEcg0719NkI3XLF6wYFYDvqFHnrZRe2eZUeIhdKum71HKWkrAP4NlavS6CpbPs/qWlzDXZ5uoSmpcj/1CuiEPl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:30:25 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:30:25 +0000
Message-ID: <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
Date: Tue, 4 Apr 2023 12:30:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
In-Reply-To: <20230329160445.1300-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fee920-52cd-4697-1f25-08db3529e4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPU6kv0uTX1oF2KJreHK2ojkDDtLaVf5cTQGIyIIC91KGDgSugWfd4tRkMW9p55PnXejo28RgheA+paY8cKJOIILRiEs41r5sakI1J0MIOfV8UalaqcEegAO4QnqxYdDYdnrYueRnWY40ia7TDRazY2zYAKMhDOpoy+iZ2dOCxJF/mtPbOAtEMCHRkx0Z9AuNWu5Dr7uV8RE6yEm9CEII0ZIYCTeXEOJuK/Hq0EwojVu+fj1I4lIYwFsVO62TWjWA/rRjn6+njXRkayD+yuhtbACSErZcihTlo3+AYuEANphM9XSKkcs+YKsCt8j0im9pzIPVyDgUTki52OQcM3hQvdVevfegg8ZDGV7rNAS2/i+EGQqN1GqR3zGh7NSNG3ySxnQcxW4x4+BNQ9RsgMU94pV3d0Z1FjBNryo2HyZeIpEcM1aepMVs27VFBThwiJUtWLzV3dNRpGWC7ZOkFucivXmhpPaHbJGkS+4rPSBf2YEmZfnAPhn6678L+DccJdkL+Z2It9vIco/jIW2kSuQQ/A9GrzXRRenKh9YXHo9pKtJl0bZiLLyw+xSg1VNp8z8q3yB/t3hICGqX+537woY3RkW8J2uPzWFN0p1D9mdzscT3PJqEfc2njJB5+yClqnq0ot8XrHl/0MLEw36NfOOvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(478600001)(4326008)(8676002)(66946007)(66556008)(41300700001)(66476007)(316002)(8936002)(44832011)(54906003)(5660300002)(38100700002)(53546011)(186003)(55236004)(83380400001)(2616005)(6486002)(6666004)(6506007)(26005)(6512007)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25Kc09OQlM5UEpvZmtQL0Zpd0c3SDFpK2dwTm84dXNTR2JDNVUwYndEcjdG?=
 =?utf-8?B?cmpWYXFDQ1FJSktaWlFVSFNDL21nbDk1RzliMTVuanNUVkYxTUJOWDBXdkEw?=
 =?utf-8?B?ZTVQb2ZXWWY0dzdnc3BETFVRQXZKcXB1angxU3h2dUZYaVgrdTlqVXIzcGx3?=
 =?utf-8?B?KytuMko4eTFxcFZTdEczdFBpMWRMMHdDa1lBZlpSTlRYUDB0TVhQUXUrYjl1?=
 =?utf-8?B?ODAyeXBVUzIrN3kzWGpyaWh5R3h3akJDWVVXdi9sb0VQdWVBbTRYc0RSaFoy?=
 =?utf-8?B?RlNaMkl3Q1hUb0JSei83UVRuYVp3U055Rm5Db1ZJN2orYXJHWTY1ZDk4RGtl?=
 =?utf-8?B?YXZhVTdKdERUYk5xNmRmLy81QS9TemI5UHBMVDB3OGdodXovNEpyb0cyRFVE?=
 =?utf-8?B?YTV2a3hvT1Z4YU1YWkl2NkFUWHdwbDUydjVaMWtqV1B2YVFtOWtOL29Fd1Vw?=
 =?utf-8?B?b0lsWlI0SHhzcDl6V3MrREh1SlJBbTkwaXhOeTA0MUFYNVkrRUpoa3dLMllS?=
 =?utf-8?B?c1B2Q09kRUZzLytUQTVwTno3blVsQ0hITS9WQmtpakdtakhIZExZQ0FtRE01?=
 =?utf-8?B?eU83bVRzR3NCU1BtOThBcHluZTYwWEZEbjUvdVBSZXh6SjZOcjNNbERsNDVq?=
 =?utf-8?B?OHQ0S0tKSVdHVmdxMnNld0tzRjI2a2Vud0Z2eE1NV3JLUWpZbUplRUluTmVp?=
 =?utf-8?B?Uml4L1k3VEgzY1FTMGYwN3c1RXFlM2Jib2VtWDN6K2NJZS9wMWhTUkQ4ZWdY?=
 =?utf-8?B?NzJTNHhoRUpXV2R1aEY1dVlzT1lOZGsvNW5SMWxsZnUxbVVlblQ0UXNPeDVY?=
 =?utf-8?B?c1lSL1FwUy9xZGoxZVliVFFHYmtkUXZUL3Nzd3Nwd3hYZ3F5S1pGWldndUh2?=
 =?utf-8?B?b29wYk9pQjEzUEVhRDhyOHdEQ3BzYklkWElDVjR3OEVJZWFKMW03cnJsejEw?=
 =?utf-8?B?b3M1Z3U0b3FXeCtZTi9rM0hWNjRqNVR4bGhmR25INi9DdWtSdjQyS0hBaXBk?=
 =?utf-8?B?R2lqVm1xQ2h1a0M0S1NhV0VqREd3WlArZjB0cTNtZWFiVmRrbGkwNGhqNnd6?=
 =?utf-8?B?aWJNZXZwcGh2TTArNmQ3OXUzL3lBSVJJUFVFMFdId3AyU1pER0JHdFd4dEdw?=
 =?utf-8?B?QTRHWnVZdVk4bzZVY0IxUWVMZ2o1aUNjVTFjYUVKNzNKSlpzRW1YOEZmRlhV?=
 =?utf-8?B?ajFsTTVmUlhuazRWckh2OTlhVk5IdTVRbDg4b3dHT3ZCRmladEhLQ1FrNkRS?=
 =?utf-8?B?bnRCb3dSV1NwYlZRMWttc1FvMGVLNXhxZjJ3QU1Ic1lLOC9yUElTYWUyMkJt?=
 =?utf-8?B?MVRTUnVqcGJBdTdDNER0T3dNOHYxVy9QT2JvOHhtSjJDRnBhZTBzK2VDNUFX?=
 =?utf-8?B?L1NZSVlaVlBBNStYamVsQ1VBWTVMczFNRmFyY01wU05mdjBCMzRtUVdqb2w1?=
 =?utf-8?B?VHl4Z2VwbjJzOUt2MGptVEJBVnpvREo0TXhMbS9IT0dIYUMvN3JaOXEzOHh2?=
 =?utf-8?B?YnByemUrN1NHRGlzYkprdVhFaDZWNGlScmwrWmpxcHh0ODBYM3MrZngvQzNX?=
 =?utf-8?B?V0hTTVVDdURHU0ZaWHVPUlVCbEt5R2p0VmtGNmJqUUNPbTlETjZTYjV1MVRZ?=
 =?utf-8?B?OERQQUZqcUxLdERETmhUZmVkaXNQVTI5M0dXa1NtbGtLMW5SNWR6VzRjMysv?=
 =?utf-8?B?S1JNMlkyeG8rQy9vRWwrcldFalA2YXZpUHloSEtKTERGYXBSeEh5VXZSUmpQ?=
 =?utf-8?B?SWFraTlYem50RlI0WE5ENXAvaDY1aFFpSkJTZzdqeGtOSDlFWkJTZ2wrbzdk?=
 =?utf-8?B?dXdKNnhQMkQrRkhLckVpWWN4WHRXM29lTU1vck4rUy83dkRlc1pkNnpvd2FX?=
 =?utf-8?B?R0lTWkNJWGxDWmNTRC9qNTM3MnJtUHY1LzBsNHZMUmVGS0U0WFp3RUkxMkFX?=
 =?utf-8?B?SlBPYWRTT2dOTEQ1L1Flb1hCUGt6Rzl6bER5N3BoL1hGWS9nRnhmK29oUS91?=
 =?utf-8?B?RzY5WXV3Q0FZS01wOUtqcUVkdytQMG0vOE1nZFNheWNVaFczOUU2MTh0dkVk?=
 =?utf-8?B?Ym9oZ1JKZmova2d4WFc1ZUhIUXp4SUxCKzBCRytraG4rUStqc016ZmE3Zk9C?=
 =?utf-8?Q?D4LCyrW1XKlfvkDUnzyx1NbUI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fee920-52cd-4697-1f25-08db3529e4c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:30:25.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/JDNYSazur81Ai7DQtSJslwvBJt7569dP4XhE29848OeUBMie+3sSkx5mshP9PO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 12:04, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> This patch adds new functions to map/unmap a usermode queue into
> the FW, using the MES ring. As soon as this mapping is done, the
> queue would  be considered ready to accept the workload.
> 
> V1: Addressed review comments from Alex on the RFC patch series
>     - Map/Unmap should be IP specific.
> V2:
>     Addressed review comments from Christian:
>     - Fix the wptr_mc_addr calculation (moved into another patch)
>     Addressed review comments from Alex:
>     - Do not add fptrs for map/unmap
> 
> V3: Integration with doorbell manager
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---

Just add all your Cc right here, and let git-send-email figure it out.
Between the Cc tags and the SMTP CC list, Felix is the only one missing.

Regards,
Luben

>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> index 39e90ea32fcb..1627641a4a4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -23,12 +23,73 @@
>  #include "amdgpu.h"
>  #include "amdgpu_userqueue.h"
>  #include "v11_structs.h"
> +#include "amdgpu_mes.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>  
> +static int
> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct mes_add_queue_input queue_input;
> +    int r;
> +
> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +    queue_input.process_va_start = 0;
> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +    queue_input.process_quantum = 100000; /* 10ms */
> +    queue_input.gang_quantum = 10000; /* 1ms */
> +    queue_input.paging = false;
> +
> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +
> +    queue_input.process_id = queue->vm->pasid;
> +    queue_input.queue_type = queue->queue_type;
> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +    amdgpu_mes_unlock(&adev->mes);
> +    if (r) {
> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +        return r;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
> +    return 0;
> +}
> +
> +static void
> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct mes_remove_queue_input queue_input;
> +    int r;
> +
> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +    amdgpu_mes_unlock(&adev->mes);
> +    if (r)
> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +}
> +
>  static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>                                                   struct amdgpu_usermode_queue *queue)
>  {
> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>  
>      amdgpu_userq_set_ctx_space(uq_mgr, queue);
>      amdgpu_bo_unreserve(mqd->obj);
> +
> +    /* Map the queue in HW using MES ring */
> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
> +        goto free_ctx;
> +    }
> +
>      DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>      return 0;
>  
> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>  {
>      struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>  
> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>      amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>      amdgpu_bo_free_kernel(&mqd->obj,
>  			   &mqd->gpu_addr,


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F10FC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 18:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE95410E09B;
	Wed, 22 Jun 2022 18:51:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6188910E09B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 18:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6bvMT/R1jlKyMkpJrNmy5vjSC1XMIkP+wFK+i4hyOsSabR5njxllpCiK4vuaZw80H0UXo7oH/gu1YRTdMTjcPFpFfFgUVT7I1kOxNjV1kHa59XawpFhDh8HZJkbLFd5GbfNZwCwXPC57LYqfO/eODdqlvLOEUIBI470XFy2tKaQOaxKfyM3r6bp+zDk0VuJFqOJAO6KCF1nrIgj1OXE9REl1IOZL/WfrKqygSZa3+a6Ey0jw0I5oZwmxXFpsXN2qWu9ORT+gdn/EMQZaZFN9b55OT6AmnU0/1gHEMgLHXT0GQVdAKORwOe+b/yWFXPAqZotxO+85ZKkbsfT0YknlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3iKEn5f1MryHN5nzmGxhDTDH8OfPBEpUhT1HSHkgog=;
 b=iu2544PaTXeZz+a5NIyCm3L0Ph8RSy02aqCNLMugWr7JPZChmo/4olAGg0Q6ELDsn2hL0AIrtn+H/wW5AtliRxHdBNNd/UcUNkCDn8vFWUtC6IRLIzRlOIsJFAZuQwaeU9lD/1Z/iOt2kjIB/EULibhpMgPZ2K9D8bRYEC6OXABOg5d5R40J7Hh7BQy+b7Vh0pXg46WY/MLkF2ymhSwUjwVAWNPgBWRndFvtkIxNSVDn+nad0VFtPt5kUmmq0gkuEpxlMi/Djk3NzGZG81OnWXXi0TWGMhKrGahOdCM5YEhgUd08Og3Hvpb74tGxbXZYCau66vaBK2XJtAFeWhd+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3iKEn5f1MryHN5nzmGxhDTDH8OfPBEpUhT1HSHkgog=;
 b=ZfxVvMNet2rBsB9j3/643VIdOa3FYpWqZvTS9HfL/4nmZOouIiMqFps4a6xUCZ37f6A12UbanpPyrZg8Xfpry7Sj9j/i3l+GXWb1C6tn4GiBacze1E4f6X++cyZInLOpg8FYKntvHS2E/E/hwW93KlOPpzrQtz5dhP71oErC86Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN6PR12MB1826.namprd12.prod.outlook.com (2603:10b6:404:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 18:50:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 18:50:58 +0000
Message-ID: <7e0ec683-0004-2c40-bdd6-2a3f2c6e0852@amd.com>
Date: Wed, 22 Jun 2022 14:50:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220622153656.174491-2-Graham.Sider@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220622153656.174491-2-Graham.Sider@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:610:51::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c75de0c-ea55-43dc-bd66-08da54802532
X-MS-TrafficTypeDiagnostic: BN6PR12MB1826:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18264EFABF4406D79C4BFA46E6B29@BN6PR12MB1826.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5d9LGtRw+PtbeOM3a6OdDpGMFUAuBMYMjNoE8Svo3YN0nyboxNvTRr40ogL6YXJ+gq63NerQn+tSuNhbKDRSmt7lPUHgMDgSe05GLYVk9x5txszegXbZxFm5eISn3Sig3k03kO3D6+sel39McA7FnVwKzaWzeQF5SSG+1bNn+Yn10dr6PHy5eVpwUGZuFg/NJ6pY0J00BfGJuIumyH41ajPGA5xobyu/50W8r43IubkLmBSA8oD3CXqqVUUHw0KiKnOjEo0Vwt5Ec4LB1LBleuHsNT7H4l95+GBBFBbjjVcO4bBxlH4/iUueQDsbjMNc3CybJxRGeDpuX3zcscWY0jNkKk0+1SD7mHQoo+hoylucKojvFFzLJK2ywCCmJFkCETW91viDHvT4XP5vT6hS0s0HAWvv2enO6QyqleaDQO7HJ+YRsnnfRKNBKsGZixDe14ES+PAdZqnLZPvs/8aJbsRPEZsCYbnGUL6KaroUY+W2mcskNEt89AExrIIPlD0VLXDQlaXkeVz4w8jvque+WC7nRBHXpsJuU5Fai9nWHbI0/yM7YFMsj+oE8d0319rIbOtUuITcHjNDftdoZACLu6lw1/hjjG85l5VemxPTfkGtvQDFPXzWXFbzZZzRF1jNnb0HofDdJBt5hsFgrIlrKVGmX6HAoTbZX6U+SxeUJK3g+jDnOomEqki4Blc5AbNQhB3Ip2rA4WHewaY9riKeDu3SdYIj1qy/zpNmOgM59gviE/gdkq3046cNv3sUrpaOaA8v/KiuznqnSGD5YVQJ0fEs+wEstkaSOk+1LnR8Ltg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6506007)(2906002)(53546011)(31696002)(38100700002)(6486002)(8936002)(478600001)(30864003)(5660300002)(83380400001)(54906003)(41300700001)(26005)(6512007)(186003)(2616005)(31686004)(66556008)(66476007)(4326008)(66946007)(8676002)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21jZVZBRjU2UHBwMC9qNlBkN29DbFJOai9RYlcvbm5QUEpLZWFVYWEzYmx4?=
 =?utf-8?B?akRtNUtBamdQVXp3MzVFeTNGR0xQRzZteWdWNXhOc0x6WHdsa2tlaEtSMEth?=
 =?utf-8?B?cHJEaDl6c2tFZWI2V0dHUmpzbVFuMzEvMDdRYU5VbTZCQk5RWm84aEJ0cVlh?=
 =?utf-8?B?SzJvbkg2L04zVTVnQVV0ZjJHTUh4bkEzK0VqSkErK3pBTXd6cis3R0NNc3l6?=
 =?utf-8?B?c3d6cy9rQ1p0U3c2cnZPK3VqanNyY3RJdnRIdHg1YlVSZ3ZVMUdXZmUvY3pW?=
 =?utf-8?B?Zm1SQlVjZlloUUNSQndkNXpqUUlkWEdiRXo3VDdsZFJvV1JHWC9vRmNOYktz?=
 =?utf-8?B?VkxlQlRtM2taZ3pBZ0pXTW5pUEFPL3hNT1RrVFdGNVVkM1doOU9zRzBLd2Zq?=
 =?utf-8?B?RUpXcVVVQXZ2b0toUCtHOXlhWUFCeHpvUEE2THF0ZmJ5OUhPcWI1YklMejBr?=
 =?utf-8?B?ZkZERVRFQjVEdFFTbGZHcHh1MGJXdjBTcWxZWEJxM3lTdHpJN0JpRjNOemtp?=
 =?utf-8?B?OUpvUjBvVk9EMmFEYkRMek5Db0VnS3pYWUszTjhrd25TMFIxOEpPOElIVEV2?=
 =?utf-8?B?QmpLV1pJaW5VQ3p3OVQ1Qk5odGZQRFhPYVpmN2V4YnVtOTlidnhmK2h0MkJq?=
 =?utf-8?B?MkE4TWg5WmV1SnpPdXNGQ2FOM09EbVlHQVJ1aVVaUVFybGhaak0rK2dCUTF0?=
 =?utf-8?B?eXFYbDBNS05nV0hhbVNzTFVkU1FlcXBFSDRWTzk1dVF4U1REaVBMNWNzOUt4?=
 =?utf-8?B?aFJkdzI2MHFWbEI5WDlPVWs3NSs0ZlNvOGM0L3NuMTdtWitQQ0txNmc4R1Ji?=
 =?utf-8?B?bkRrdXg3SnRKamdzdTdMK1FnSGQ0VzRZZFovK3NzcDQwUE1rT0Z5d2w1Z0xL?=
 =?utf-8?B?djVWOUhKYlVRdWwzOUxXTFVuMFovaDRYZDNSTWtxTU95VnJtSGlUVC8wSTBs?=
 =?utf-8?B?MmZNdk16K2J0MzljTVc0aFpBRC8rZkZLdWMxR0k5cUgvbjhCU2l5L2VDQ3d1?=
 =?utf-8?B?aFJoRHFGMU51eXVneWhTZU54Zm5KVHZzNHo1YkhXWVppbWF6azNnendNOHhT?=
 =?utf-8?B?N0NZSnFKbTVtWG80RVJoUnRCak56SGZwcW9TaEN1TVhkbmpUUFJGM3REdURX?=
 =?utf-8?B?cm1iWThXMy92T0tKS0oyNldnVFZiSzJZelh4YWt4dFBucUs2bnJleFRLeGYw?=
 =?utf-8?B?YnFVQXhNcGltRXMyUXFQRGFvVkJ2Q3lUVy9KdmY4emVUNk1BeTZRWDQ5bnlD?=
 =?utf-8?B?N2ZyZ3djSzdOcEJocTBjd1JnVUNVQkVvNHRBK3p5RnFjcXpVSXpkM1FmMEZB?=
 =?utf-8?B?QWdGanFlNTBxRmpoOGFXbXllbEdScGlpSmpSajZmWmxENFBsSU9WaWNwTEhD?=
 =?utf-8?B?OTRBK3VHeVRnNmhORWFYL1h0RzhHZ2pwc1ljdHlEZHhvTVZkamk5cW9iang2?=
 =?utf-8?B?YlJBLzZvejlpak5rc2JnejVCSk43aWhUaU9GUEVGMGFRMVlvL0V3VDRMYzgz?=
 =?utf-8?B?QjR2WUw2MmUvYkNwWHFKZWZ2cllMYkVUckhSYXVIczlxUXFzSHcwTzM5MXoy?=
 =?utf-8?B?dTdvZnptMTF6c2NwV0tEYWFoTjNYb3MvNjg3MWduR2FDSTNNbENYMWkxU2Nl?=
 =?utf-8?B?ZXk3N2VwR0VVYk1Oa3BTaDZLY2hXcFpKdXhqQmVVZ001aFFncUIrQndtQ3lZ?=
 =?utf-8?B?eWxZSG0walByc0RMZXN0eTREUy9uM1VoQXREWm1UVFFQc1A5K00wNlpSTE9Z?=
 =?utf-8?B?STVOSWRXSmZrYVV6U3dmMkZOREJzVy9VLzZRWUZuNTk0VUk5NUdLNFVpMXl3?=
 =?utf-8?B?OVFuZFBNSmFneVNkb1RoaS8vMWw0Nmg2eEwxdW5xdktMUUxqcFFEZ0hjUllU?=
 =?utf-8?B?YUZwSW5NV3pjYjY4Tkt4Qm1WcEl6RXZYbXoyMmFwZHR5N1NTU1RNWnNNUm1P?=
 =?utf-8?B?aThQSE1DajRyd2hTTklzZ1FEQ1Fudi9iaDYrMGF5R2lTQURNeHVDSVhZc0RW?=
 =?utf-8?B?T0VmbXpjR0ZSOTl5M2xPWDc5UTlOWTh0MjhPclRRcERxTVFKdjlDR09MWWhE?=
 =?utf-8?B?aHp4dEEyNXB4K04reUdaY3RwRGF3b2N6ZWJER3REY3pmaGJQTkFHNCt6dkpE?=
 =?utf-8?B?SnQ2UEhCMFZxUlFlZFBMMVlCZTRxVk04Q21UYkd2ZldZNFNQS2hEMEhXUVN0?=
 =?utf-8?B?b0s3em41Q3l6SzhselVWQ2pJOExOemZpV0g4Q3ZCK2hSdHY4UFBQb3A1bkhh?=
 =?utf-8?B?WXpNMDdHK0RzUDl0Vy8weXp0Q2FrYnFnZGxreWFvNjlsTVhkUXJiY3FoKzAz?=
 =?utf-8?B?a3NCd2hUREtWQTd3UWZDcHc5UStya3dvMldNY0lkMUtrdUtzYnlpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c75de0c-ea55-43dc-bd66-08da54802532
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 18:50:58.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMYITIkoklGQKrFShruF6JtFOFEVCYAbaUbPJbn55TXFMlIkFJ5+QK7R/cHqzrgq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1826
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2022-06-22 11:36, Graham Sider
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20220622153656.174491-2-Graham.Si=
der@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">Starting with GFX11, MES requi=
res wptr BOs to be GTT allocated/mapped to
GART for usermode queues in order to support oversubscription. In the
case that work is submitted to an unmapped queue, MES must have a GART
wptr address to determine whether the queue should be mapped.

This change is accompanied with changes in MES and is applicable for
MES_API_VERSION &gt;=3D 2.

v3:
- Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
- Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
- Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
- Cleanup/fix create_queue wptr_bo error handling
v4:
- Add MES version shift/mask defines to amdgpu_mes.h
- Change version check from MES_VERSION to MES_API_VERSION
- Add check in kfd_ioctl_create_queue before wptr bo pin/GART map to
ensure bo is a single page.

Signed-off-by: Graham Sider <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:Graham.Sider@amd.com">&lt;Graham.Sider@amd.com&gt;</a>
Acked-by: Alex Deucher <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:al=
exander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Reviewed-by: Philip Yang <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++++---
 8 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 648c031942e9..b25b41f50213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -286,6 +286,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd=
_mem *mem,
 					     void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
=20
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct am=
dgpu_bo *bo);
+
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index afd6e6923189..615ac2895d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2148,6 +2148,54 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 	return ret;
 }
=20
+/**
+ * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment referen=
ce count
+ * @adev: Device to which allocated BO belongs
+ * @bo: Buffer object to be mapped
+ *
+ * Before return, bo reference count is incremented. To release the refere=
nce and unpin/
+ * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
+ */
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct am=
dgpu_bo *bo)
+{
+	int ret;
+
+	ret =3D amdgpu_bo_reserve(bo, true);
+	if (ret) {
+		pr_err(&quot;Failed to reserve bo. ret %d\n&quot;, ret);
+		goto err_reserve_bo_failed;
+	}
+
+	ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		pr_err(&quot;Failed to pin bo. ret %d\n&quot;, ret);
+		goto err_pin_bo_failed;
+	}
+
+	ret =3D amdgpu_ttm_alloc_gart(&amp;bo-&gt;tbo);
+	if (ret) {
+		pr_err(&quot;Failed to bind bo to GART. ret %d\n&quot;, ret);
+		goto err_map_bo_gart_failed;
+	}
+
+	amdgpu_amdkfd_remove_eviction_fence(
+		bo, bo-&gt;kfd_bo-&gt;process_info-&gt;eviction_fence);
+
+	amdgpu_bo_unreserve(bo);
+
+	bo =3D amdgpu_bo_ref(bo);
+
+	return 0;
+
+err_map_bo_gart_failed:
+	amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+	amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+	return ret;
+}
+
 /** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel C=
PU access
  *
  * @mem: Buffer object to be mapped for CPU access
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index be4b51a5b5c7..137a2cc2e807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -32,6 +32,13 @@
 #define AMDGPU_MES_MAX_GFX_PIPES            2
 #define AMDGPU_MES_MAX_SDMA_PIPES           2
=20
+#define AMDGPU_MES_API_VERSION_SHIFT	12
+#define AMDGPU_MES_FEAT_VERSION_SHIFT	24
+
+#define AMDGPU_MES_VERSION_MASK		0x00000fff
+#define AMDGPU_MES_API_VERSION_MASK	0x00fff000
+#define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
+
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       =3D 0,
 	AMDGPU_MES_PRIORITY_LEVEL_NORMAL    =3D 1,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 625e837f0119..a0246b4bae6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -299,6 +299,7 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process =3D 0;
+	struct amdgpu_bo *wptr_bo =3D NULL;
=20
 	memset(&amp;q_properties, 0, sizeof(struct queue_properties));
=20
@@ -326,12 +327,49 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
 		goto err_bind_process;
 	}
=20
+	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determ=
ine work
+	 * on unmapped queues for usermode queue oversubscription (no aggregated =
doorbell)
+	 */
+	if (dev-&gt;shared_resources.enable_mes &amp;&amp;
+			((dev-&gt;adev-&gt;mes.sched_version &amp; AMDGPU_MES_API_VERSION_MASK)
+			&gt;&gt; AMDGPU_MES_API_VERSION_SHIFT) &gt;=3D 2) {
+		struct amdgpu_bo_va_mapping *wptr_mapping;
+		struct amdgpu_vm *wptr_vm;
+
+		wptr_vm =3D drm_priv_to_vm(pdd-&gt;drm_priv);
+		err =3D amdgpu_bo_reserve(wptr_vm-&gt;root.bo, false);
+		if (err)
+			goto err_wptr_map_gart;
+
+		wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(
+				wptr_vm, args-&gt;write_pointer_address &gt;&gt; PAGE_SHIFT);
+		amdgpu_bo_unreserve(wptr_vm-&gt;root.bo);
+		if (!wptr_mapping) {
+			pr_err(&quot;Failed to lookup wptr bo\n&quot;);
+			err =3D -EINVAL;
+			goto err_wptr_map_gart;
+		}
+
+		wptr_bo =3D wptr_mapping-&gt;bo_va-&gt;base.bo;
+		if (wptr_bo-&gt;tbo.base.size &gt; PAGE_SIZE) {
+			pr_err(&quot;Requested GART mapping for wptr bo larger than one page\n&=
quot;);
+			err =3D -EINVAL;
+			goto err_wptr_map_gart;
+		}
+
+		err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev-&gt;adev, wptr_bo);
+		if (err) {
+			pr_err(&quot;Failed to map wptr bo to GART\n&quot;);
+			goto err_wptr_map_gart;
+		}
+	}
+
 	pr_debug(&quot;Creating queue for PASID 0x%x on gpu 0x%x\n&quot;,
 			p-&gt;pasid,
 			dev-&gt;id);
=20
-	err =3D pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &=
amp;queue_id, NULL, NULL, NULL,
-			&amp;doorbell_offset_in_process);
+	err =3D pqm_create_queue(&amp;p-&gt;pqm, dev, filep, &amp;q_properties, &=
amp;queue_id, wptr_bo,
+			NULL, NULL, NULL, &amp;doorbell_offset_in_process);
 	if (err !=3D 0)
 		goto err_create_queue;
=20
@@ -363,6 +401,9 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
 	return 0;
=20
 err_create_queue:
+	if (wptr_bo)
+		amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, wptr_bo);
+err_wptr_map_gart:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&amp;p-&gt;mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 213246a5b4e4..299927a4959b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -177,6 +177,7 @@ static int add_queue_mes(struct device_queue_manager *d=
qm, struct queue *q,
 	struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
 	int r, queue_type;
+	uint64_t wptr_addr_off;
=20
 	if (dqm-&gt;is_hws_hang)
 		return -EIO;
@@ -196,7 +197,13 @@ static int add_queue_mes(struct device_queue_manager *=
dqm, struct queue *q,
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
 	queue_input.doorbell_offset =3D q-&gt;properties.doorbell_off;
 	queue_input.mqd_addr =3D q-&gt;gart_mqd_addr;
-	queue_input.wptr_addr =3D (uint64_t)q-&gt;properties.write_ptr;
+
+	if (q-&gt;wptr_bo) {
+		wptr_addr_off =3D (uint64_t)q-&gt;properties.write_ptr - (uint64_t)q-&gt=
;wptr_bo-&gt;kfd_bo-&gt;va;
+		queue_input.wptr_addr =3D ((uint64_t)q-&gt;wptr_bo-&gt;tbo.resource-&gt;=
start &lt;&lt; PAGE_SHIFT) + wptr_addr_off;
+	} else
+		queue_input.wptr_addr =3D (uint64_t)q-&gt;properties.write_ptr;
+
 	queue_input.paging =3D false;
 	queue_input.tba_addr =3D qpd-&gt;tba_addr;
 	queue_input.tma_addr =3D qpd-&gt;tma_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4e0387f591be..b8e14c2cc295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, voi=
d *mqd,
 	m-&gt;sdmax_rlcx_rb_base_hi =3D upper_32_bits(q-&gt;queue_address &gt;&gt=
; 8);
 	m-&gt;sdmax_rlcx_rb_rptr_addr_lo =3D lower_32_bits((uint64_t)q-&gt;read_p=
tr);
 	m-&gt;sdmax_rlcx_rb_rptr_addr_hi =3D upper_32_bits((uint64_t)q-&gt;read_p=
tr);
+	m-&gt;sdmax_rlcx_rb_wptr_poll_addr_lo =3D lower_32_bits((uint64_t)q-&gt;w=
rite_ptr);
+	m-&gt;sdmax_rlcx_rb_wptr_poll_addr_hi =3D upper_32_bits((uint64_t)q-&gt;w=
rite_ptr);
 	m-&gt;sdmax_rlcx_doorbell_offset =3D
 		q-&gt;doorbell_off &lt;<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;diff--gita/drivers/gpu/drm/amd=
/amdkfd/kfd_priv.hb/drivers/gpu/drm/amd/amdkfd/kfd_priv.hindex91e5fa56f0a2.=
.59ba50ce54d3100644---a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h+++b/drivers/g=
pu/drm/amd/amdkfd/kfd_priv.h@@-570,6+570,8@@structqueue{void*gang_ctx_bo;ui=
nt64_tgang_ctx_gpu_addr;void*gang_ctx_cpu_ptr;++structamdgpu_bo*wptr_bo;};e=
numKFD_MQD_TYPE{@@-1205,6+1207,7@@intpqm_create_queue(structprocess_queue_m=
anager*pqm,structfile*f,structqueue_properties*properties,unsignedint*qid,+=
structamdgpu_bo*wptr_bo,conststructkfd_criu_queue_priv_data*q_data,constvoi=
d*restore_mqd,constvoid*restore_ctl_stack,diff--gita/drivers/gpu/drm/amd/am=
dkfd/kfd_process_queue_manager.cb/drivers/gpu/drm/amd/amdkfd/kfd_process_qu=
eue_manager.cindex99f2a6412201..8db58348de98100644---a/drivers/gpu/drm/amd/=
amdkfd/kfd_process_queue_manager.c+++b/drivers/gpu/drm/amd/amdkfd/kfd_proce=
ss_queue_manager.c@@-180,7+180,8@@voidpqm_uninit(structprocess_queue_manage=
r*pqm)staticintinit_user_queue(structprocess_queue_manager*pqm,structkfd_de=
v*dev,structqueue**q,structqueue_properties*q_properties,-structfile*f,unsi=
gnedintqid)+structfile*f,structamdgpu_bo*wptr_bo,+unsignedintqid){intretval=
;@@-210,6+211,7@@staticintinit_user_queue(structprocess_queue_manager*pqm,g=
otocleanup;}memset((*q)-">&lt; SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 91e5fa56f0a2..59ba50ce54d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -570,6 +570,8 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+
+	struct amdgpu_bo *wptr_bo;
 };
=20
 enum KFD_MQD_TYPE {
@@ -1205,6 +1207,7 @@ int pqm_create_queue(struct process_queue_manager *pq=
m,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 99f2a6412201..8db58348de98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -180,7 +180,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_dev *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, unsigned int qid)
+				struct file *f, struct amdgpu_bo *wptr_bo,
+				unsigned int qid)
 {
 	int retval;
=20
@@ -210,6 +211,7 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
 			goto cleanup;
 		}
 		memset((*q)-&gt;</a>gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+		(*q)-&gt;wptr_bo =3D wptr_bo;
 	}
=20
 	pr_debug(&quot;PQM After init queue&quot;);
@@ -226,6 +228,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -288,7 +291,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, *qid);
+		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, wptr_bo, *qi=
d);
 		if (retval !=3D 0)
 			goto err_create_queue;
 		pqn-&gt;q =3D q;
@@ -309,7 +312,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
=20
-		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, *qid);
+		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, wptr_bo, *qi=
d);
 		if (retval !=3D 0)
 			goto err_create_queue;
 		pqn-&gt;q =3D q;
@@ -435,10 +438,15 @@ int pqm_destroy_queue(struct process_queue_manager *p=
qm, unsigned int qid)
 			pdd-&gt;qpd.num_gws =3D 0;
 		}
=20
-		if (dev-&gt;shared_resources.enable_mes)
+		if (dev-&gt;shared_resources.enable_mes) {
 			amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
 						   pqn-&gt;q-&gt;gang_ctx_bo);
-		kfd_procfs_del_queue(pqn-&gt;q);
+			if (pqn-&gt;q-&gt;wptr_bo)
+				amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, pqn-&gt;q-&gt;wptr_bo);
+
+			kfd_procfs_del_queue(pqn-&gt;q);</pre>
    </blockquote>
    <pre class=3D"moz-quote-pre" wrap=3D"">Seems rebase issue, kfd_procfs_d=
el_queue(pqn-&gt;q) should be outside if (dev-&gt;shared_resources.enable_m=
es) {


</pre>
    <blockquote type=3D"cite" cite=3D"mid:20220622153656.174491-2-Graham.Si=
der@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
+
+		}
 		uninit_queue(pqn-&gt;q);
 	}
=20
@@ -844,7 +852,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
=20
 	print_queue_properties(&amp;qp);
=20
-	ret =3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp=
;queue_id, q_data, mqd, ctl_stack,
+	ret =3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp=
;queue_id, NULL, q_data, mqd, ctl_stack,</pre>
    </blockquote>
    <p>CRIU restore user queues should create struct queue wptr_bo GART
      mapping based on MES API version.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20220622153656.174491-2-Graham.Si=
der@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
 				NULL);
 	if (ret) {
 		pr_err(&quot;Failed to create new queue err:%d\n&quot;, ret);
</pre>
    </blockquote>
  </body>
</html>

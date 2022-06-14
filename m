Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E41AC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0313C112AAB;
	Tue, 14 Jun 2022 18:22:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B5B112AA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 18:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFKOLHw4Vs+L23wELE+QS5NdCktGTAtrLzeGRfneoa2qkdfFI2TzXdK2WRz5WmZQDYBJngVsDYYqDDehfXGGo4PiUExWMiHfDaASKQgT1F87bDwd/gpS6fjWltHrN+qmwyNfCQPpGATjt8iV7TVQz5RJms2v35t5j/SbxxSmeIbDPF9u9c0Su76VMhojE6XFtxOsmdAqBqRzL0AFyWLvZwvNTPWEgiE0Qa9qyQIcqNRp+VOIT8a7aX4ejxHdFPnT1wdlNsBy/tO+Iwwwc4O152q5D/0rlhnEEr6mWvYLdrGiXzJq1hN9kp/xjivyR2Da4DeYcAJ8FLqIehJUamMU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj7kNXl6iMvLuG/6nOLfgFPCwHJt8IFkFuql9XGjMMM=;
 b=CDnbO6rrDCX8tJzDBfWQYCDSurcEyK2bw2Px9H3ZhpPraRVAKUlmK4PbNne+sYQ3wZN3qFrXqrRmvJskYmhl06EEFc9qheK0Mr904eyAFh7LK3FHgW9DgKV96D8PBMzZmnVfIklAgh3yJEnJHo1X1keu2X+zRqjj0oinWqcj7srFkPD1JpneCFLOYbWMi7EliI7iSmGzQo4OCVHm6KYuu4YZ5eX2/oserMFZ0jY8AvFxzaJYuTil97SLU/l3dIjjlzNI7AuqaGB8regyq0nkmELPnAPFOaBH1DAk2C8sIYbWSoUzoJw/Y8RuEWDeCtAhLN5hv/RbE5BfdmUhXMOzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj7kNXl6iMvLuG/6nOLfgFPCwHJt8IFkFuql9XGjMMM=;
 b=xD5mBcZ7DjIZdCklqgv5SHng7m3QU7sHtRV+wEqkvOhIxHKLFmrpcYyUFSsXCRTs6kJWgrPrOH1cMPF0APuSnUzGwcGPotoF3zh/Pi0CdTbjriHl5PYGys9ZlmFnDihwaMK5APwwGXV1CgnD7ZEiyxibFaVJp6W4EzQ1FyCn3iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 18:22:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 18:22:25 +0000
Message-ID: <11d1242d-3ebd-8093-d23f-099d4acc8708@amd.com>
Date: Tue, 14 Jun 2022 14:22:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220613152001.3045911-2-Graham.Sider@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac02723f-01c0-4fcc-ff8c-08da4e32d4ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB497396CC6A7821B05593CF9DE6AA9@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ht567AmFcEGv2C7BjircNn9zIjnaYOupEHqfAz2aiGVTKrwPfcFW/QcFdn5IpowzC1xcJNIKWNFbPqboYUHvQxAl6a5eBoNZiHiSs72fWhj/g4McUQosQVwxkfSsKeEp9+aMrbAYc/JKW6FtEy914C37sytYRrqCEd4sL7ypKTF8WY6j0YcEIfilFgU0Q7r945pD1QjpIx8KJgiHzP1/kiJvsvpVirbP99j2tC1k/6/E7ZjZQ4EKMEn/u8swJgcVZAU1fZ76vtpWoThgho/dVe0bpY97mMDgsODJs4XhSqtAsyy+VN/FBWJC7FLvxF0nnosyvUbN8D2asYGiMVzqWUwd2mLRK0ba1EWXoohLAnQtC8VHLnfj036pxRG5FyPhiNXugBhY825gFM3H/rrzVyObrMdV7wsfnnDAnwDGaM+J3GQ5k8y/108IbBDezMUG1rkdAhJPdKLBaQHIb/XZUt+omi8vbORoHY5dMi+TeEAOJyfD9wEFCmI4SL4Bo0F+ShD6+vW0GUIMdhYfTkLkLMcmipYlBWP6jivDbupsH16vcL7kjBtCv+rSUS3R/4VJhSCmb54oxJjk6yqZeQcUBaepcEeYo3ek3h1HyULNOCeq63ZpHvNaLIsH0hiqQvbBaaI6wu4lp4zWiKF7aU77jzH+0Po/N8Q+Yzyd/y9hU2t54TdPbd1G1w/RpGwCR+FJ3w/CoZti+FzB8wYQ2W83F7aFKdP3ak6xfH/bPJtuLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(66946007)(6486002)(2906002)(4326008)(8676002)(66476007)(66556008)(31686004)(31696002)(36756003)(6506007)(6512007)(26005)(53546011)(316002)(38100700002)(186003)(83380400001)(2616005)(5660300002)(30864003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC8yK0RNTEpRNDNvR2Qzb09wamNkQnFVUEcxNnBxVlVBbmxPYi9taHZwUVFX?=
 =?utf-8?B?YlNVMHFDbTFRYWhxOTllVkd2MExjSk1zam5pRVJ5eDJMbnpycVVEKzJJeG1p?=
 =?utf-8?B?eFZxMWRmR1oraTE3ZkxJWGtvTVdOZnlXdldpMXhRWnZ1L2k3QUJDelZhWlJq?=
 =?utf-8?B?VlBEQWtvMzNSRWtHNjVBSEZOZHZRSXF2SDJ3TytWZWQza1JRWmJZdS9GWXoy?=
 =?utf-8?B?RmdEMUd1OStLS25RQ2RHck1ZZW1YVlNSc01vbEpBR1R2M2VGRE9seE96dVRF?=
 =?utf-8?B?dUxScTlzd1QxTGpESzU4eVRTUXhlTVdzWjRFMUxVOGVHZFpIVUUyMk5UZlN6?=
 =?utf-8?B?SFFyZmJxejM4dStuYlVlUENsa1R3dVpYVWdwT0p0MGhYcEZhRXVkUytnSkkz?=
 =?utf-8?B?SWNHaXZCZTlOR0xrU09ERDRrVW8vb1NHc082NzFKNU11dlR3REVxdk1tbi9s?=
 =?utf-8?B?N2FJVmM1bzMxU3BJVHNtVFgzL3RhUG5Bbkk3TXp0ODJEOEt6WkN2ZGdWZ2ts?=
 =?utf-8?B?emUvOVc0Y0FMT040NlhKNzhXV0VwVHIvUksrdEVTUHdvWVAxb1JwRW1jRnZx?=
 =?utf-8?B?elFIWU9tN1RxbHdMekpreTJCNVZLZmRuY1JubFFJdFFhZTIraHpCNmxHL29l?=
 =?utf-8?B?dkE1S2c4d1p6ci9kQllUa2VoZURudjkrR012R2VMc0VmSEMveGgwOWU3VDVL?=
 =?utf-8?B?VVp5S1pWMUttYzZRTGsxNmFaMmJHWldRTDJ3WDVxZGFCMGxlbWxkTlgxNHlX?=
 =?utf-8?B?YXJkaXNER09MZFJsK2xMQkdFSGt6dWxsbjNtQ2ROSmZaNEdzUy9Uemx2dTZz?=
 =?utf-8?B?S3piSXBha0xSMWgzSEhwb29mVjJad2N6Qlk2YUlsRkRzczRuTnpXZVdlanlH?=
 =?utf-8?B?dHdKaEc0WnFNYU1qenJ2cURFSlZ1Zm1HSVRiYkdXRHQrUzc3bnRIREdBSzRu?=
 =?utf-8?B?ODl5NTlYVEp0N2hyYnNFRVpTWTFVa1ZpVVBOelVUbC93ZnIrUG02dmNWaURD?=
 =?utf-8?B?dldzN3lUNkF2SHpYU2N1T0g1UTJ4TkF4anRjeTgvbnVlc281aXl1b1Q2YzZL?=
 =?utf-8?B?ZW5tL3RSVUFBSmg3aytwR3YvekV0ZWVUVUxBR1V0T1VpQXUzNm5qRWFsZlkv?=
 =?utf-8?B?NVVBWjBOUnA1NEJBS1BTWVBIZXg5cGozNXJvc1V2Y2w2U0ZMSmRKR3ZFblU4?=
 =?utf-8?B?YUtoNW83d2RYeWhqdXNhOU5PNm9RemNZb2hPR2NBR2h1SERzVFBVN1ZDNW55?=
 =?utf-8?B?eUYxQUZUSUlhbGttQWVuVUtPVlVFaDAxaU5mSURXTWFIanJGTjNISTI0Y1g1?=
 =?utf-8?B?a3Q1RjZURWk3WjZYeVgxWk5NVUxsNUoxdEtNR1R0OTV1c3UzbmluVG9GaXNI?=
 =?utf-8?B?Yk5USlo4TmcxK3pVK0ZCd0NicGc4NzhTRUh1dTd4NUUxZzNrcEN0Q2Mra0RL?=
 =?utf-8?B?ODBpc1hUeHdOSnNsU1ZFMW5STnA2Yi9Xd0RBUDBnZ1cycnhuY05HYnFKOXA0?=
 =?utf-8?B?WituT1B1bTh3L0ZFNlZxaW9OazJ5SkhDZG8zWW1nUG0wZXJDTzlZeUV1ckQ4?=
 =?utf-8?B?cmcvNng1ekkrREFLWnd0bWFNYlZUeVFERWZCakFwL3RCaWxEdk9TN3hjWkN6?=
 =?utf-8?B?c21QalJ4MU9LOFB1azdZbm9mYUpjR0lWSGw2NHhHdTFZYkRlUmgzT0hOWUdM?=
 =?utf-8?B?OXNoQklzSUY5RjFMN1pOYUlic282T21CTzJzRitQVXFoYkNDdWNJOC9kL0ZC?=
 =?utf-8?B?K2g2QXk5T3NuR3ZrVzB0NTNVYldxdlZ3WEVPQzM0MmN3eGtKKzVFMXBHUnFX?=
 =?utf-8?B?SUwxRFlCMkdScTQrN25HQWNjODg4OGo0cTZJUHN3RGRkN20zQWo0ajh2SFpp?=
 =?utf-8?B?Zmd0ajFabCtpdktvU2hVNXh1dmtBNGY0YTNna05xUjBJeU04NktvYXl3akwv?=
 =?utf-8?B?aUtyeXZzMjI3ck9sMFh4S2Q4ZHh5MXE5Y3JZYnBWb2Fqbm1XeHc3WDZrYUJO?=
 =?utf-8?B?N25lcW55RlVrVlpqdTM1RjIzVENUUnpWNkVsK1dxS0E2UXk5NDd0RDFzTmNn?=
 =?utf-8?B?VWxXaE5PVmE3UDJHUTFyR2FJbUxnbENUOGdYbVZaUkRZOHpucmNhTUk1aitt?=
 =?utf-8?B?QkcrUU5aazBEcTIwejU0WTZMeTFqZkFIUjZoQmFFcUZ2OUFhUGJLbXZUTTVm?=
 =?utf-8?B?R2NOZUpSS21SNWYxdlgxTitZTGxRcmZDT0R3RW1yTjVaWW5iejJ0a1crSHlo?=
 =?utf-8?B?ekVRVXBNRTRWT1lrbGRPT3pjbjlMK0Q1T2Z6Q2FOV1NHd05pODcvbTBNZU9v?=
 =?utf-8?B?cENXVGZ0bHk2aUoxbVIzZExXeER2d2hJK2pXc2xqSTV3OUlmODZuZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac02723f-01c0-4fcc-ff8c-08da4e32d4ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 18:22:25.2814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUmojs+WiH5dKq7zjsq/2lOclgVBaENwZ56ig9e7f+raVcZ7FnMLs0iiFcAXh3Qq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2022-06-13 11:20, Graham Sider
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20220613152001.3045911-2-Graham.S=
ider@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">Starting with GFX11, MES requi=
res wptr BOs to be GTT allocated/mapped to
GART for usermode queues in order to support oversubscription. In the
case that work is submitted to an unmapped queue, MES must have a GART
wptr address to determine whether the queue should be mapped.

This change is accompanied with changes in MES and is applicable for
MES_VERSION &gt;=3D 3.

v2:
- Update MES_VERSION check from 2 to 3.
v3:
- Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
- Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
- Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
- Cleanup/fix create_queue wptr_bo error handling
</pre>
    </blockquote>
    <p>Two nit-pick below, with those fixed, this patch is</p>
    <p>Reviewed-by: Philip Yang<a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20220613152001.3045911-2-Graham.S=
ider@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
Signed-off-by: Graham Sider <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:Graham.Sider@amd.com">&lt;Graham.Sider@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 49 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 37 +++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 17 +++++--
 7 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 429b16ba10bf..dba26d1e3be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amd=
gpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *ad=
ev,
 		struct kgd_mem *mem);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct am=
dgpu_bo *bo);
=20
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index efab923056f4..888d08128a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
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
+	list_del_init(&amp;bo-&gt;kfd_bo-&gt;validate_list.head);</pre>
    </blockquote>
    pinned bo should keep in validate_list as PDB/PTB may move and
    update, please remove list_del_init here.<br>
    <blockquote type=3D"cite" cite=3D"mid:20220613152001.3045911-2-Graham.S=
ider@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
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
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		struct kgd_mem *mem, void **kptr, uint64_t *size)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index e9766e165c38..1789ed8b79f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
 	struct kfd_process_device *pdd;
 	struct queue_properties q_properties;
 	uint32_t doorbell_offset_in_process =3D 0;
+	struct amdgpu_bo *wptr_bo =3D NULL;
=20
 	memset(&amp;q_properties, 0, sizeof(struct queue_properties));
=20
@@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
 		goto err_bind_process;
 	}
=20
+	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determ=
ine work
+	 * on unmapped queues for usermode queue oversubscription (no aggregated =
doorbell)
+	 */
+	if (dev-&gt;shared_resources.enable_mes &amp;&amp; (dev-&gt;adev-&gt;mes.=
sched_version &amp; 0xff) &gt;=3D 3) {</pre>
    </blockquote>
    <p>Should we check ip version for GFX11 only? Because GFX10 set
      enable_mes, and may set adev-&gt;mes.sched_version later as well.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20220613152001.3045911-2-Graham.S=
ider@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
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
@@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
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
index b39d89c52887..d8de2fbdfc7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -208,6 +208,7 @@ static int add_queue_mes(struct device_queue_manager *d=
qm, struct queue *q,
 	struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
 	int r, queue_type;
+	uint64_t wptr_addr_off;
=20
 	if (dqm-&gt;is_hws_hang)
 		return -EIO;
@@ -227,7 +228,13 @@ static int add_queue_mes(struct device_queue_manager *=
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
index f1654b4da856..35e74bdd81da 100644
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
/amdkfd/kfd_priv.hb/drivers/gpu/drm/amd/amdkfd/kfd_priv.hindexa5d3963537d7.=
.dcddee0d6f06100644---a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h+++b/drivers/g=
pu/drm/amd/amdkfd/kfd_priv.h@@-639,6+639,8@@structqueue{void*gang_ctx_bo;ui=
nt64_tgang_ctx_gpu_addr;void*gang_ctx_cpu_ptr;++structamdgpu_bo*wptr_bo;};e=
numKFD_MQD_TYPE{@@-1404,6+1406,7@@intpqm_create_queue(structprocess_queue_m=
anager*pqm,structfile*f,structqueue_properties*properties,unsignedint*qid,+=
structamdgpu_bo*wptr_bo,conststructkfd_criu_queue_priv_data*q_data,constvoi=
d*restore_mqd,constvoid*restore_ctl_stack,diff--gita/drivers/gpu/drm/amd/am=
dkfd/kfd_process_queue_manager.cb/drivers/gpu/drm/amd/amdkfd/kfd_process_qu=
eue_manager.cindexf99e09dc43ea..3a17c1ebc527100644---a/drivers/gpu/drm/amd/=
amdkfd/kfd_process_queue_manager.c+++b/drivers/gpu/drm/amd/amdkfd/kfd_proce=
ss_queue_manager.c@@-190,7+190,8@@voidpqm_uninit(structprocess_queue_manage=
r*pqm)staticintinit_user_queue(structprocess_queue_manager*pqm,structkfd_de=
v*dev,structqueue**q,structqueue_properties*q_properties,-structfile*f,unsi=
gnedintqid)+structfile*f,structamdgpu_bo*wptr_bo,+unsignedintqid){intretval=
;@@-221,6+222,7@@staticintinit_user_queue(structprocess_queue_manager*pqm,g=
otocleanup;}memset((*q)-">&lt; SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index a5d3963537d7..dcddee0d6f06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -639,6 +639,8 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+
+	struct amdgpu_bo *wptr_bo;
 };
=20
 enum KFD_MQD_TYPE {
@@ -1404,6 +1406,7 @@ int pqm_create_queue(struct process_queue_manager *pq=
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
index f99e09dc43ea..3a17c1ebc527 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 static int init_user_queue(struct process_queue_manager *pqm,
 				struct kfd_dev *dev, struct queue **q,
 				struct queue_properties *q_properties,
-				struct file *f, unsigned int qid)
+				struct file *f, struct amdgpu_bo *wptr_bo,
+				unsigned int qid)
 {
 	int retval;
=20
@@ -221,6 +222,7 @@ static int init_user_queue(struct process_queue_manager=
 *pqm,
 			goto cleanup;
 		}
 		memset((*q)-&gt;</a>gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+		(*q)-&gt;wptr_bo =3D wptr_bo;
 	}
=20
 	pr_debug(&quot;PQM After init queue&quot;);
@@ -237,6 +239,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct file *f,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
+			    struct amdgpu_bo *wptr_bo,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
 			    const void *restore_ctl_stack,
@@ -299,7 +302,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		 * allocate_sdma_queue() in create_queue() has the
 		 * corresponding check logic.
 		 */
-		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, *qid);
+		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, wptr_bo, *qi=
d);
 		if (retval !=3D 0)
 			goto err_create_queue;
 		pqn-&gt;q =3D q;
@@ -320,7 +323,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		}
=20
-		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, *qid);
+		retval =3D init_user_queue(pqm, dev, &amp;q, properties, f, wptr_bo, *qi=
d);
 		if (retval !=3D 0)
 			goto err_create_queue;
 		pqn-&gt;q =3D q;
@@ -457,9 +460,13 @@ int pqm_destroy_queue(struct process_queue_manager *pq=
m, unsigned int qid)
 			pdd-&gt;qpd.num_gws =3D 0;
 		}
=20
-		if (dev-&gt;shared_resources.enable_mes)
+		if (dev-&gt;shared_resources.enable_mes) {
 			amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
 						   pqn-&gt;q-&gt;gang_ctx_bo);
+			if (pqn-&gt;q-&gt;wptr_bo)
+				amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev, pqn-&gt;q-&gt;wptr_bo);
+
+		}
 		uninit_queue(pqn-&gt;q);
 	}
=20
@@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
=20
 	print_queue_properties(&amp;qp);
=20
-	ret =3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp=
;queue_id, q_data, mqd, ctl_stack,
+	ret =3D pqm_create_queue(&amp;p-&gt;pqm, pdd-&gt;dev, NULL, &amp;qp, &amp=
;queue_id, NULL, q_data, mqd, ctl_stack,
 				NULL);
 	if (ret) {
 		pr_err(&quot;Failed to create new queue err:%d\n&quot;, ret);
</pre>
    </blockquote>
  </body>
</html>

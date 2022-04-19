Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D87EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207BB10EB0D;
	Tue, 19 Apr 2022 14:55:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58F610EB3A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8/BIF0GnLn0XjMNPVIax/sCMl29FVnGW3sIA7GRwZd8SUhevjxI7YGcgumNtVe2/K41nQKdt78mv00DYh+Sdjp1bkpuB88+X88ZCSmAKYDhX/NTvEkNxEBNsyvc6RSsOJTmkHfVu7H5dfzdnE0CjEJJXupnq/Y7RZx2KdIL1ODE5X5EBZkW282vLCUhg0lefAstbY26JF92dgUfAk2dRwucTLT+1nccxrB3+IL6409QT8ISTMXkJ/0eXEPmVLv9G6jOwHeraSBTqEEuewwcnxjyc3zBEEyhyrhLHiNCcN2zig2gTM+kKJNEP5kwYFfVIGFCVUitX0ZfwMwzuh11Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rDA3xK2KX/774V3yCBoBaV2lK2wOyShk7wSApIhXl8=;
 b=EpLojUgomfrgGlHn6Eg+xllCW12I3QavSiqnGNM1oNFwLt2oT4GBrpnax1t/scPb+74PRauGy3a+no77W120Dc22SbYNx84SgWe6xg6tSWjOkdAo8f2s5QYL3m5wLJpQIwicZnlPeDowcLTYgfI4He0lBUeKANUhAT7Zlkk3adoZgsSSluVrJdkD6WdZRf30hFLy7gaToIC9SsACfjcbate1jNG6F60RRITDAHjixEUs9qkMwlWrx3UoQjPpaufCdRic6UxtD9Xtx7ho6WYaKhe9PEDzLNYHYP+2/Xi0XLTi+NsUZBq/XvCRQkQ+/JmHuvlPyiz7XanHb6ctU+Fl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rDA3xK2KX/774V3yCBoBaV2lK2wOyShk7wSApIhXl8=;
 b=zQG50eWphecl/mF6yF18Men6S+J+njaX1M4iYyGLLnGtarvUGkzca5lPbnYgbZ3Hl/5LkSJQvLrFVo2QO8VntGLwctq5G8aQ829PY9kU6q0WBDUkWu58/LUZzgUWGLntvCWQAn2QCi23m4h79J4jA48fLf0M2EAHDThSGnqtTjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:55:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 14:55:47 +0000
Message-ID: <a488a14f-1b92-357a-419f-54b02e8e369c@amd.com>
Date: Tue, 19 Apr 2022 16:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: remove pointless ttm_eu usage from vkms
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220419141915.122157-1-christian.koenig@amd.com>
 <CADnq5_Oy2LZ_dbYVYsi+UrQNpCGx+LPWeUcT2_D=-rWgeptuXQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Oy2LZ_dbYVYsi+UrQNpCGx+LPWeUcT2_D=-rWgeptuXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0210.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cba705-473c-4c1f-db57-08da2214b00d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5115C1335237231B88B3873583F29@BN9PR12MB5115.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJcd8/lpKoIa6A4wdkHmdYVkYZPLW7gETxuH5qA6uSFiXQyrhhLcTBeriMU73+VfPVPoBRWAg129VGCKulJzuSqW1/qdL8NSdjdi7afp/YBIncHORwwjXmiaxLzfjM1ppQqkOGx20CB+ILdaNeZHfpdu2DI4EueiHWNYPYifysqJYvNohdeVC+Ki+QUd2NLobXzF5Fn22kUohj4lDfq9g8+r1usOoXeXCOemIwDgpQZGylDvfLc7QvQHmsy8lTwqbz8wUBkEf9xlsx/KKpxsvgC5xmSid8TE7kTYdkHMwc4Y1tLOjaVpMNgVMNT/bda4vSW8PC789uGf0950nF0LXgMlR76LqPNB+d91qupdPF/3G/YCxWVahdEhUeYXQl58sWKH37KFL7rMIrWoP83AZie2rGSMPM/1ZLLgO53ABM+pnvUgx8dADnAM3KL1UmtJxLZyJ27NvQn95F6mnRse8BtPhwwph4Ws11dRtVRBa/5N50HF0iudJtT+OitehZBo/vfwjDYCF34MbIcTsZ88eR81IperAL8iFaYVMc6Jp3W0tHYlHnL0scsu1fVR6gU3CieFdEKEpVdFjKyZWzibIdpta6JP9iDANhcvAqMbPtWlGGlIZrZs37VOHxE1avgczTM/rs6Y9XDXRu2+kzzsoySMZG+JPGUVRH7xkbVFEJMpGtz7KMJn5cWU19hOUypSf795ChC3U9VhcxT+wTxacyHHT38NI+9aYm5tsd2uzjBp1Wr/4kMCKEISFpAsIvVn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(186003)(6512007)(66946007)(36756003)(83380400001)(54906003)(8936002)(5660300002)(2616005)(53546011)(2906002)(38100700002)(66574015)(110136005)(66556008)(316002)(66476007)(508600001)(31686004)(4326008)(8676002)(31696002)(6486002)(86362001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JBQzUza2RybFJ3a1drT25KNW1uOHhDZGUvUElKb1IxUjVyWnpiMzBiRE10?=
 =?utf-8?B?ZFI5WksrOWtFMTFaU2hPODMrbmZTZjEyQmxJRzdiYnhPRWJrY0VwREcrazVu?=
 =?utf-8?B?VmpQNjhGS0N1K3BETE1IL3QyTFVKZFk3ZlBZQU1kQzRSb0w1SzhIMnRsMk53?=
 =?utf-8?B?a2lBYm9YK3pQd3JUdkVTeWsvZUxYdEp4aVVTb2xuMDUyU2NQUm5QVndVdURo?=
 =?utf-8?B?czlhU0lxR2pTK1dReWM3ZUdnZzRJVHY3emJpTmNZbVlDUE5tUGlMZFJ2WG5M?=
 =?utf-8?B?VlloTGpSbjFDQ1hQbTVmTWxQY1h1bVlWNVhoUm1aUHoydkliT1NIaGFacGVw?=
 =?utf-8?B?dk5yOU9JaG9mMVVqcXArQTBQZVgrbk1pN1grUGRHSzJoRkhaNGxMQUpxTWh2?=
 =?utf-8?B?Z0xVWUk4ZFVqb3RqRkxZcnVlNnE1a0VRN251N2NOaHcrbng3T2ZFc3VzNzll?=
 =?utf-8?B?Rm9XT0lJcXkyWEdROWpjd0ZycnA0VkN3bmxuaGlBWUVaTmQxNVI5WXkvb0pI?=
 =?utf-8?B?aFZJejZIK1ZsVjFrL3BJRFVOQkJQQzk5NmN0M0k1eFlob0owMkFzMDNIdjNh?=
 =?utf-8?B?YzVBcUR2ejRCVFpkZE1SNi9ZMStxOEMxdllycU1RdmFxM2VJYUxNUnNhSms3?=
 =?utf-8?B?L3paN0h5dXl2UGdWMjlBM1ZSNzNCY1ZwQ3h5b1FHaE5jWFlqY2xLVFQ3UVFp?=
 =?utf-8?B?Q2JnMWFBdXlDNzY5WkpEVzhacU56WExEUXJ3RUNjTFphSTlnQm9zRjlpdTVo?=
 =?utf-8?B?VGpPeDY3S3NrK1pYSkQzdmJIWG5reGlqZC9jMkkvL25lUnpPZjVuRXdHeG1J?=
 =?utf-8?B?RGVSbDlqN1dQTmR5a3B3V1orVGZWY3ZrZmI1bHhsRTQ3ZkRlZ3JxU2xTSnNC?=
 =?utf-8?B?MkJOMmR3OVZ2eUxFcDB0SFp2WkxRRnRwcytUWEJHQ2ROM2hEb3g0Mk5KbXBR?=
 =?utf-8?B?YkFGblQzbkJuc2svMis0QjgyWlV5ZVJJOHNmMTM0SUVoTTN6L2FtNExITVVa?=
 =?utf-8?B?STFTdHFLdzZoOERQWjhLTU1SdXV0YW45UWN1ZWhSTDAwV2ljSlRCdEsyTEVJ?=
 =?utf-8?B?OGdpbDBkWXFqcU4wb0g4Q0xsSVg3M2ZSV0l3WmhiT29xd0JCa3NvMi9qVWJi?=
 =?utf-8?B?cDJ3b2tmcUlRN0w3Y09NN3pvaC9YTEZWNExvNEk4SkE0eDRrSkJaMWR1L0Yv?=
 =?utf-8?B?R080N0xDeklEUXRKUG9GOERFbEljUDBUS0FwVjZ1Z2w1Z2VXa2poN0RlZTBY?=
 =?utf-8?B?ZlgzWlVJSTBoZGlzdXVCRHVJUXdqdnVhZTA0c3RpeEJadHVmZEp3bmNxYnla?=
 =?utf-8?B?STBHSHRyZ2FHSVAwZm80a1Y3SlVBQjAySWVGVU1BSzVBb3BKMzBwNUFtcGQv?=
 =?utf-8?B?MkI2d1BydkNNT0VGdGpNV1A0Q1pKZm5LbXNFUDZ3TzFaV3pPNC9lREhZY2VE?=
 =?utf-8?B?MStTQXMvekowY0V5bGlhZ3VuRlEwTXZJWTZsNFJGbVIxZDJsVFJySG9ueEdz?=
 =?utf-8?B?UEJEMlhQVEZKRjRiTUhRNkxsRm9UckRodjFROGw2L3JyT21IQXczSDVBV25Y?=
 =?utf-8?B?SmlPSldEWWtIZXF1NzR4Q3hyaENqSVhaUXlPWXRMUi84YWRGbU1yVG8yS1dP?=
 =?utf-8?B?d01EMU5SODkwdW1uaGdGY1pSZW1rZ1VHOUZ6dTRCTzl0UGpLY2RzZlhqN0Jx?=
 =?utf-8?B?VVJnbE4vM094cmxpR0VwVFREQ1pSajZ4TkdKbFBaUktGUEZlaS9KRUlVeThu?=
 =?utf-8?B?ejcveTdoS1BCd0FtQk43R3lzUjRVNTI5WHE4WVpFQmdIdy83c1RGZWtEcmRp?=
 =?utf-8?B?OEwyQzRrMStTbno2TWF2Q0xJeERPY3Z5SFVMdUdnakVLWEdZU3A5cVJId3FL?=
 =?utf-8?B?cDJoNjBkY3RGaEd5Vnh4V2RXUzdva3hDemlGa3kzdzhOWVZHMm1lWE54QXQw?=
 =?utf-8?B?aWQwYlR3VVpVSFJ0cllKK1FGVHlhYmQ2bkJtbmRJRXVUWHZXcDRZYmdKaDRN?=
 =?utf-8?B?SE9PRXhRdllFeDBmZm1KMzJrKzJpUmp0bTh5RjZac0I0d1c5Z0FkYkxKdnZU?=
 =?utf-8?B?UXA4MTRGa0hYdEdxMGtGRmR1T3FvU09ndTUrSzRPVCtJMjJhZEpKYTFkTlhQ?=
 =?utf-8?B?UllLSlk5am5VVzdrTThyV2w2VEtCZHM1akN3OHM3VmtJd1VUZHM2NjJHbU9X?=
 =?utf-8?B?c295SWZjR3pzMExSdzZiMUVHdUxRWndmVkJIMFVJeUw0bEVWTzUvaUdsRjdy?=
 =?utf-8?B?QWdzVjN3dVdtQ0p5Uys3cXgyY3RBdEpFQ0JPaWVsM1JQdE12cVhSeXpPTFVi?=
 =?utf-8?B?ZlpsL092Uk1meU1MR0ZWVG1TNWJrWHdKUFV1Ti9GbjVDeWdXL1Zuc0p5Y1l4?=
 =?utf-8?Q?9TxTTtDNQMjkcmSBIXxfI2s7Qtkl03v1Wwf5odzXWpkwE?=
X-MS-Exchange-AntiSpam-MessageData-1: EMZsqeMsnO1aFg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cba705-473c-4c1f-db57-08da2214b00d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 14:55:47.6766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjtoN0zEI5c6BYs6KEQF31Fa3a6i1WWX5MPc4wrLFrhb5ccZUkPEm1goBKIGvIdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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
Cc: Ryan Taylor <Ryan.Taylor@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.04.22 um 16:49 schrieb Alex Deucher:
> On Tue, Apr 19, 2022 at 10:19 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> We just need to reserve the BO here, no need for using ttm_eu.
> Can you include a more detailed description as to why it's not
> necessary?

Well the logic in ttm_eu is for reserving multiple buffers.

> Most of this code was copied from radeon originally.  Does
> radeon need a similar cleanup?

Most likely yes.

Christian.

>
> Alex
>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 32 +++++++++++++-----------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> index 5224d9a39737..576849e95296 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> @@ -302,9 +302,6 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
>>          struct drm_gem_object *obj;
>>          struct amdgpu_device *adev;
>>          struct amdgpu_bo *rbo;
>> -       struct list_head list;
>> -       struct ttm_validate_buffer tv;
>> -       struct ww_acquire_ctx ticket;
>>          uint32_t domain;
>>          int r;
>>
>> @@ -316,18 +313,19 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
>>          obj = new_state->fb->obj[0];
>>          rbo = gem_to_amdgpu_bo(obj);
>>          adev = amdgpu_ttm_adev(rbo->tbo.bdev);
>> -       INIT_LIST_HEAD(&list);
>>
>> -       tv.bo = &rbo->tbo;
>> -       tv.num_shared = 1;
>> -       list_add(&tv.head, &list);
>> -
>> -       r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
>> +       r = amdgpu_bo_reserve(rbo, true);
>>          if (r) {
>>                  dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
>>                  return r;
>>          }
>>
>> +       r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
>> +       if (r) {
>> +               dev_err(adev->dev, "allocating fence slot failed (%d)\n", r);
>> +               goto error_unlock;
>> +       }
>> +
>>          if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>                  domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>          else
>> @@ -337,25 +335,29 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
>>          if (unlikely(r != 0)) {
>>                  if (r != -ERESTARTSYS)
>>                          DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>> -               ttm_eu_backoff_reservation(&ticket, &list);
>> -               return r;
>> +               goto error_unlock;
>>          }
>>
>>          r = amdgpu_ttm_alloc_gart(&rbo->tbo);
>>          if (unlikely(r != 0)) {
>> -               amdgpu_bo_unpin(rbo);
>> -               ttm_eu_backoff_reservation(&ticket, &list);
>>                  DRM_ERROR("%p bind failed\n", rbo);
>> -               return r;
>> +               goto error_unpin;
>>          }
>>
>> -       ttm_eu_backoff_reservation(&ticket, &list);
>> +       amdgpu_bo_unreserve(rbo);
>>
>>          afb->address = amdgpu_bo_gpu_offset(rbo);
>>
>>          amdgpu_bo_ref(rbo);
>>
>>          return 0;
>> +
>> +error_unpin:
>> +       amdgpu_bo_unpin(rbo);
>> +
>> +error_unlock:
>> +       amdgpu_bo_unreserve(rbo);
>> +       return r;
>>   }
>>
>>   static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
>> --
>> 2.25.1
>>


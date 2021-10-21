Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F86C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 06:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E04760FC0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 06:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E04760FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849126E408;
	Thu, 21 Oct 2021 06:58:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7DA6E408
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 06:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyzJjEXlCMIunGyfIkji33VCoABpQyP7ZHQT+GU/LwEBV6GQCCQzYO7vI8Bu/QsWjC06zOHYJct9HndReFuqNaJCD/20/qBCQB1I7t01KwkCCIF0RR1jEj89OAx5MXIFiUfm4eaerPAOOaWCm3vBkaP7qnMGBHSK49/GjYUz1PTR7MzfH5+SVMxyHXqY+tVbte/EbuD+edFeB1ZI5IN/3Hq9Lqmx1xCL3ZDAox3gahDVgMGuheyVqSkjA5M876vDmerW2+flhEeYK8c2XEM/gpX37GkUeJDMDF90xFCcUuIcn+3jwE+alqFQ6F/Y+JWgD5/cq5s+hxckXTaRrAH36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlYJoy+tQRnElTbkzluf5TBEyzT0f0pPsfKAJKWMYqI=;
 b=en4bYLb2F1y4SzZjqkFZCFanY9uXmDCH4VJyjje9oOiHSNj6xpSzkMAhWk/BLRJhoRh9eoBiDnHlxLhNP1Rb1UDkcc+pW9K6pkf0EZYhAjO2WOxFaTlNDPYsznFB3VEgBp6LvXyg0g6L6XwlcD2wxMTzsTl//sJ+KbBZ+79g3SePLE3LPiaXPmhGHr55srSyHgDKv70CoKqvItZ+Q9Q4YVWUxtxVNW/iutB+Cfw5e4Fx35kK6pAoQGg88EHgzNpyHOwaKxEoDVmHN+4wfcdU1ZzFmoQqfWcLpyYTwydp7tgxYFHAmlbWXvzusYgrBt884kr+9CuZV5Aj3BUDDHx98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlYJoy+tQRnElTbkzluf5TBEyzT0f0pPsfKAJKWMYqI=;
 b=teI+7w6urxkIEivaJxNQkUv/ldoDcBNmT7tHri5VLq3Ke+RNveA0rbo6BfCsgvMk5HLmejvQny+T+n7ozv4Tuj8Y4HMqjCP7oPHTzWG2TOsaBRZKh3U25/8VOts6RdV9pBriwGsBydmNSxBNlc0HmiITinfXggJxUPCmzaoWX4A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1488.namprd12.prod.outlook.com
 (2603:10b6:301:f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 06:58:18 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.019; Thu, 21 Oct
 2021 06:58:17 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
To: zhang <botton_zhang@163.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
 <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
 <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
 <4141c2c0-fa61-d5ad-7302-4718d68d33c7@163.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d76531d3-b89c-0030-3d39-023dced5f815@amd.com>
Date: Thu, 21 Oct 2021 08:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4141c2c0-fa61-d5ad-7302-4718d68d33c7@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0308.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::28) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:46a4:dec3:9292:691a]
 (2a02:908:1252:fb60:46a4:dec3:9292:691a) by
 AS9PR06CA0308.eurprd06.prod.outlook.com (2603:10a6:20b:45b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 06:58:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c46957-069c-49ef-ffbe-08d9946028fb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14885AF3C84CA0443A1A174083BF9@MWHPR12MB1488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrYcTgwgd8zNFEQbcDTWbufjPIKr/Qga5Hecqxl/Hfp3HI8u/S6Zpu7T+Gb25LLsECrzlbl7PY9YCjJpNuaAklwfgE+yqhjN2N4cHxnRkamIsSDKZBxIEz/JoQjhkKa27ycFNyutxIh1+SoQsGndYydEKNhCIaEjjas0f8Dv7bgFwWZaXMVgOiHJ1mBB4yTJ171ExL5GkH93LiV4bD4tU+QSAHQQpjauZlwoLixsK7Gthj4wwB2cVyRKo8IJ17lAqD567T+83T8g9eoElMEpJpR48pZA1j0ZNYAylT9U62YcyXneKX9sQ2kzc+CieskbLBrMCNC5bXWnR1KCQ/EUcZfztmKyVI4iMYQU4oBTJddJJg0ODAi2ULrTcBLmWqkonCwusjUpZfcvYul6N89aOPC4/2FmC9cUkQo7xBzjUfAgtsuaP8uEdishLYSJEsTGFjajFb+I2oS+cgfbOjBGxn4GmViQ6lFd7qJZN/M6eINrbfeyPfEhaMfPVFZ3ChSlYPPaSYxB/LxFgkaedmlSppbUahfhAujzUdcM2kZSw+DyqLjKzrgplXLDA9bdyzRffylMJfo+hkWVA6yFrTXkBgbQBVM/CvX/hb9SIp6QZ4cKr5F4uC7SHPJipAOg4QvpHkd+cuPmm5OuMFF1ONyx4OglJsc++qKjnP/nVEIuJbR3YqvYzXhddx+hGjw4DtAstNLNGa5JCzmmajOd/LzBBqLfb+BrXb4dgGeCEU/oHbD4x6vp3bdGwfJvlCkzqT3C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6666004)(508600001)(66476007)(5660300002)(8676002)(8936002)(316002)(53546011)(6486002)(86362001)(38100700002)(31686004)(110136005)(2616005)(2906002)(66946007)(4326008)(31696002)(66556008)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpZVDFZd0tWZGFkWTZTWldvZDN3L0VUVXFPMmZ6ZVdDSmlqbVZDWHhsY3hG?=
 =?utf-8?B?OGkrak13NHdib1BsSkc0MnprN0pGRmZaVGhzNHhpT2MwZElacUNId0NyY0Ny?=
 =?utf-8?B?bFNIdkZWdnZPQ0g0N0FEa05JSTRnckQreko4bXR6V0xsZjN0Q29VVnF2NEJI?=
 =?utf-8?B?QU1hWU8waU5Eamx5cEFPeUQrRWpDQVBhVUI1bDVFRGhhVnU5QTY1aFVjTUkv?=
 =?utf-8?B?Zld2eEdFVEpxdWdtVXJ5ZU5hQXgxM0dWV3dKUFN1aklUSGhyREhlSklISGFy?=
 =?utf-8?B?NG1FcFArTGV6M3hERVkxZEFGNmVGazZwREQxNWhXYTlmRk40RUk3NkI2bUVl?=
 =?utf-8?B?aDY1bUNqZGovNkkva2FBYmhOR29ZRENRYk9oOU9GRUppNzN3NVo1Y0FpbnpZ?=
 =?utf-8?B?Mm14YWtQR0QvR3NJNENDVDFTMmZLSU5aaCtSWEU4SjQyOEF2WXV3YkJwV3Zn?=
 =?utf-8?B?ZzJGRE9uazBwa0o2bm1TOFBFWkMxNjRZRlNmRTliWThiTXhoWE1oNVIreU1X?=
 =?utf-8?B?TjVQM1FWR2NaNDVpaCs4T3pSOUR4V0xjZkJPSE1SSERLQStYSzlsRWpVSUto?=
 =?utf-8?B?SERnZWRKeXZnU2FVQWZSeHpNVmFtU1JEN2haUFBJOE0xVkpyTGtkMktCaEdm?=
 =?utf-8?B?UFFSQnlaa3JkVnkxbDRKOVByMVB2enNxMkI0WHJEa0VrdFNVblNlMEFPMFM4?=
 =?utf-8?B?Vnd4QVE4Ym1pVlJBbUdVZXpKYmcwSzVRSzRDcGdkeG9JbnRNNUw2VkxJVjJ5?=
 =?utf-8?B?YjlPVmF4VnB3SWJ0ak95d2JidnlYOEVkQ0xvSTlST0hsUnlJRzRORE9JTGRW?=
 =?utf-8?B?eDlEL1NiSVpFd1ZvalU5dW5CRHRVSzdacUdoaXpOWlI2K1g0VHY2UlM1clI3?=
 =?utf-8?B?OW4zWWpNakJ0ZTZjcjVyc0RrZ3MvaStHZjVQZTJsMkdXVDJNM1RFZFBPNlNm?=
 =?utf-8?B?QmdDUzJ1Ni81aEtuY1ZXQVhxR0lTd3JHQ3E4Z0pvaFd2YkJUUjcyWUxpSTM3?=
 =?utf-8?B?RE5CdkZjSE5MVGlrVUNxd3pVYnE3WGdodnBncTh6RXI3NDRxa1llN2RRZlNt?=
 =?utf-8?B?VkN6MkFvWVlmdmdTaTRvSHZVbFdUa0M3dk9sYTlGVVI2QmtRZWhQRFhUcjQ4?=
 =?utf-8?B?ZXhRcVV2dUpKZFpUYkVzdnRvUGVJQ05FMFZDdDhZMnRvcEJGWTlZdEw0WldM?=
 =?utf-8?B?dGIxRmFCaDJQNnAzckFKYnBPT1NLV2FxSkRRazlsNGtOWjhRbFJaOE14c2hh?=
 =?utf-8?B?Q0p0YlZQMGFsWFNsTW5hS2JjK3RpL0pwK3VQV05vRC85KzdTYUVydGF5UG9v?=
 =?utf-8?B?aGdmY0RpeXpwTVA4RWtxWVFHMmlrV0lMTXNHQXh0K29WcW9ISHhFSUNmLzIy?=
 =?utf-8?B?UUd6cUsrV1EvbURZSUJzMnM0cjZjdjJzNDBSMmxOSnA2MHdFOVhkRThGSUwv?=
 =?utf-8?B?Ny93RVFHa0tVMEdCNUZhYko1WDY4S0ZoWG9qMWxkWi9zSVUrRGs5dS9WNUN0?=
 =?utf-8?B?aEtnaXFGR2x1V01MTjE5M0hoaVFqSVltVGNYVlBYekpmYXo4V09YRlZSMFJ6?=
 =?utf-8?B?OHZmS2l0YWp4bzRRVnFCM3MzQVprTmFzN1NtaEtFQ2wxR1ZYa1N3SzV5ZVFs?=
 =?utf-8?B?ZVV5Si95UkxiUGcwZDN1L3FNOGo5bU5uV2NoWXJEaEFnencyR0pUWi85ME45?=
 =?utf-8?B?eEszekVRRG05ajNJQncvS3YrVm1weVBDajM0V0VnMnBSWG5TS0RiT1ArVFl5?=
 =?utf-8?B?eDJ5WUc5RkYybXMvbzQ5TmQzaDViaCtxdHBzN2EyMHVKQ2w0alJqT1BrTWRM?=
 =?utf-8?B?UnMyaWh3MHNyYkU5R2hRdkJrQnBuL3BNemtVMnhkNDRnNk5DYUR3WlMrOVVi?=
 =?utf-8?Q?Cu9b4BoaylxFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c46957-069c-49ef-ffbe-08d9946028fb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 06:58:17.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1488
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.10.21 um 04:07 schrieb zhang:
>
> On 2021/10/20 19:51, Christian König wrote:
>> Am 20.10.21 um 13:50 schrieb Christian König:
>>>
>>>
>>> Am 13.10.21 um 17:09 schrieb Nirmoy Das:
>>>> GTT BO cleanup code is with in the test for loop and
>>>> we would skip cleaning up GTT BO on success.
>>>>
>>>> Reported-by: zhang <botton_zhang@163.com>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 
>>>> ++++++++++++------------
>>>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> index 909d830b513e..5fe7ff680c29 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>       struct amdgpu_bo *vram_obj = NULL;
>>>>       struct amdgpu_bo **gtt_obj = NULL;
>>>>       struct amdgpu_bo_param bp;
>>>> +    struct dma_fence *fence = NULL;
>>>>       uint64_t gart_addr, vram_addr;
>>>>       unsigned n, size;
>>>>       int i, r;
>>>> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>           void *gtt_map, *vram_map;
>>>>           void **gart_start, **gart_end;
>>>>           void **vram_start, **vram_end;
>>>> -        struct dma_fence *fence = NULL;
>>>>             bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>           r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
>>>> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>             DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT 
>>>> offset 0x%llx\n",
>>>>                gart_addr - adev->gmc.gart_start);
>>>> -        continue;
>>>> +    }
>>>>   +    --i;
>>>>   out_lclean_unpin:
>>>> -        amdgpu_bo_unpin(gtt_obj[i]);
>>>> +    amdgpu_bo_unpin(gtt_obj[i]);
>>>>   out_lclean_unres:
>>>> -        amdgpu_bo_unreserve(gtt_obj[i]);
>>>> +    amdgpu_bo_unreserve(gtt_obj[i]);
>>>>   out_lclean_unref:
>>>> -        amdgpu_bo_unref(&gtt_obj[i]);
>>>> +    amdgpu_bo_unref(&gtt_obj[i]);
>>>>   out_lclean:
>>>> -        for (--i; i >= 0; --i) {
>>>> -            amdgpu_bo_unpin(gtt_obj[i]);
>>>> -            amdgpu_bo_unreserve(gtt_obj[i]);
>>>> -            amdgpu_bo_unref(&gtt_obj[i]);
>>>> -        }
>>>> -        if (fence)
>>>> -            dma_fence_put(fence);
>>>> -        break;
>>>> +    for (--i; i >= 0; --i) {
>>>
>>> The usual idiom for cleanups like that is "while (i--)..." because 
>>> that also works with an unsigned i.
>>>
>>> Apart from that looks good to me.
>>
>> But I'm not sure that we would want to keep the in kernel tests 
>> around anyway.
>>
>> We now have my amdgpu_stress tool to test memory bandwidth and mesa 
>> has an option for that for a long time as well.
>>
>> Christian.
>>
>   I found a  testsuit about "bo eviction Test"  for amdgpu . in 
> libdrm  tests.
>
> But I couldn't found  amdgpu_stress tool to test memory bandwid anywhere

That was merged just yesterday. See upstream libdrm.

Christian.

>
>>>
>>> Christian.
>>>
>>>> +        amdgpu_bo_unpin(gtt_obj[i]);
>>>> +        amdgpu_bo_unreserve(gtt_obj[i]);
>>>> +        amdgpu_bo_unref(&gtt_obj[i]);
>>>>       }
>>>> +    if (fence)
>>>> +        dma_fence_put(fence);
>>>>         amdgpu_bo_unpin(vram_obj);
>>>>   out_unres:
>>>
>


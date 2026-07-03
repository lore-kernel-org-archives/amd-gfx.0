Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1D3C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 12:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C681810E5E0;
	Fri,  3 Jul 2026 12:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTmu2cve";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE1510E5D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 12:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MetdPF0ICE2iizFRr94D+hnFL/dljXTRJ/oYqH3hZ3T5+AdJHggrVK0iYwWxJUmRUU1ppxIkrGlqcZUNS6yKdXzZa4sxZ1FtGFeUFde+TYVyrvohNkL5EesctdNBnHOjc300eDQsfJf3uS7LFoNFHCIQUeIZkl1ItnsjQLoTGVtjiuqDdK9FsBwR76Ht/M75JVo7LFp/Qi4iShTwGpqp5k6zN1d16bbTkqj601EXLXVQTbEvgnf1l5wFyTOT9C8RM4DLaOFeVNwmQowq3D7MPP17Ybb3rbYWVclJDeHwqI0eFBB/b9ezCZwwjFaRmLxMOoEmG7j+VAeNtInSHlAISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPw57LEZvAmyv+PFY4r7zaVOeDDvOD3jmooBVgjDA6A=;
 b=vCdj9BZP3exd8xTx6rPcUpHQSXWqQbmTawlk4Uz+Eb9qXu+NVL/ky+JI1AZSSxFRJLNxvFcDMQsJaWQ9DKbEnYAB+q/P7wltRkegXzYf2rP1IDQXRd9oQjJfph1uO6u/RC7R9QJWooHwqHItYKfN52RTuGaNQ6mT/hvrseIoqJ4PBoPP7pXy/B3OsQgJ0UmtBtQjU+gUV7ySQpxY7GYJf4PxJVDanataLQnW2jYgeikRZYGaMUFJI9r8nPxwVtN/Vd67wMK0KexVhV7v84Vxi2qZKn2oF8avcsz/9TPsx10hDhXD8bucQQulRFbuYVr/rVJR3xoUnH/HlwWTqtX+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPw57LEZvAmyv+PFY4r7zaVOeDDvOD3jmooBVgjDA6A=;
 b=yTmu2cve8yxY0l8pelwgUe643ARxSSkPow6EL4gmT62Nn0kOOoXOVFTL7G9x5/FDi8pr3C4m7Upu7J0D2j8nZlfNAebTdwQR0eFfRVsZHbJv5hhGOjA89i2EKTCSJ1S1t3S3KOF/kgFcRDCpuRhdEVgsx7BBymT8T0Vo0qT+1eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 12:40:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:40:49 +0000
Message-ID: <dd39eb43-d9f4-481b-824a-58fed6298bdd@amd.com>
Date: Fri, 3 Jul 2026 14:40:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/4] drm/amdgpu: Add driver managed buffer copy
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
 <20260623141257.66086-5-tvrtko.ursulin@igalia.com>
 <67d1e917-9c35-4161-893c-51d3490a4e04@amd.com>
 <3c4fdab0-0273-4d01-ace7-1a252be7ad9e@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3c4fdab0-0273-4d01-ace7-1a252be7ad9e@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: f36da849-725a-4f70-3960-08ded9004f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RT4zJ5IA+3nAPZt861OMOfenV2fS5PC2K44DrG1LaIPjeHe0EEo52LyxtXJLEe8VJRvndDGYaCIbzvobSS1XnbUqTyKpjB4dwyJEj7Ir2X8NAh4FoJExGV+Q+TLWvqQNIB1yNiev92Wp/cgUps3Tqh+3SAhHwdKCf0C2BIWqx7VWJ+4ZmVoiYlcQnnI1eRSafM2laGtAsdpRAF/rXtXyfJnELOKGAGsl0UTSjCdwJ3QqRNHHFxFlPh2e7iYzinz5O1wG9fes5gnZwuDBxMF3P4zb7Tk0QbUcOT8P6+JmNyNtUZB+XOwgFMuqCuvORE1r88LYxWFWXI6dIBa6/nimBjylpDDDxx8Vv8bnkpGZEhw0LDZsfGEDuwvKomoOVdZ2nUIV5AwhTtvibEFNMyMSOFhLfrf9mKVZG3g+GKzbyTybqpC7+IZYoXuxaILsd7iA9VOxbiE3QwHAfLf9mEvLBmsZ1HiRFEoVQ8mT+HuXCuoFfPtK2mD+yv7iYNtIY1yejvCsw/oGp4mw4JvrLEgNgbjikq+DyzsugBexiofC3MRouzWmBtYcwr/fGgroOQEb0ghYz2t5Ft+XYPKLY9wPU/cUj/QTgJEnKrcZQCzwACnnnwZCma2UzLJeaE2N+jNo666+S3nsjuxPD3Zmed0olvpnlJbF/4RGVTiVNozO82Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVCUk5iSVloY1RzYVJaUTEyUVpiU0YzYWtlMDk3Zk1wZDVVUEU4Y3BtOStx?=
 =?utf-8?B?MG5xVzR0RjBKNkVtV0N4SE5aMmZpVk85blVZSzBmUHV6eDJSZVVTcGN1VVVG?=
 =?utf-8?B?WkVNWmxDN1RNWE9OeGpzbmYzamdXWHAzbTkwY3B6RVI4ZjVaY2VCU2ZQUHhy?=
 =?utf-8?B?bkZiblF5UzBPd3ZEeHNwZDNTSGlPQ0hlQzFtdnhCSmRiUHV1VHRUNjdrUElp?=
 =?utf-8?B?SytTTy9SY3R6cS8vZXphdGw3Rkp5QU1QdTBBc3NFRWc4c3VWaWdkZnkwdlgx?=
 =?utf-8?B?VmoxSVpCM0VUMUM1amVGVy8zUkQ0VHIrSVhkU0pXOGFEelFVNUtRUTJRNnZl?=
 =?utf-8?B?K0FKWFBFNCtmSTJETEFpcllnUS9xdUJzeWtDbTlJWVB6R1drWEFxZDZLOXk4?=
 =?utf-8?B?bDlVT2NMYWJYMVBDQ1hVK214Z0gxZVJLSlFUUlk1czdvQVgrSTRrSlA3ZFhN?=
 =?utf-8?B?eXVNMzhjVzFEU2V3QS9wbTVtMVIydDN3SUJZL1p0L2hkb25NT3VSMG1WeitE?=
 =?utf-8?B?Q3dUUklYbE55a0hwQnJXM24rY0Y0ajlMejVuY3NGUTRmUWwvWTVtNkQzZU1h?=
 =?utf-8?B?RTVEZlNlQnYvTEhwbU9jVVNTaHpOMDQ4UTFQWm1HaXVmWkoyQm9qblR1QXdZ?=
 =?utf-8?B?M29IdHRPdHg4djN2WGpacEVock1WQTBGZWpzaXZWcjEzOFJTS1Q5d2o2bGZj?=
 =?utf-8?B?dkNORTBkSW1vNXZlSDdrSTBReTY5eWVNV2NsU3RycXVHOUkvSmN1TUhEQksz?=
 =?utf-8?B?RlpmRkp0d0t2RGRCV0hnaWt2NGkvUkZzWGkwSnJSZzlibHh5dzNub0xFUnVF?=
 =?utf-8?B?N2FnOGEyS0w4QXdaS0c2UzRZWXJ2WnplZjJtamdjSEFqUDZYSlFuM3dSVnVr?=
 =?utf-8?B?RE50U05vUlZEaldOU3pITGRxck45cGdWclhySHFIRFRGSjFTaUlIVVVWaWRW?=
 =?utf-8?B?bURvd252d0ZodHdNQzl6aTlpTnVPblNqWGVPaHh6ZWo3SUQvTDZrODNEajQx?=
 =?utf-8?B?bWNPRWNpbm1KYnJCU1c4Uzg5UG41MlpDVmZmRTZBZ3VlNVZQTXJRNllwdzd3?=
 =?utf-8?B?Vi9xOWp0blBQVFZ1a0tjWDBzTXpRcDZhUkZNeVBwd2ZNNnhLNjVjaXAzSkZj?=
 =?utf-8?B?NzA5YS8vNlozTnY2bmJSVUM1MXJ1SzNzZnFUVXQ2OEVIV25EY1JadjlzTEN1?=
 =?utf-8?B?TWFZV2luUVNpbjI3NFFTTVpKRmxkeWN6U2Ezc05YNEtNcWdMcEphZHNLZ25S?=
 =?utf-8?B?Y3R3cWFSQ05JcDR6a1B4SjMreis2SWRuTW1mVGVCK0hQd3ZqdEg4TTBBTHNP?=
 =?utf-8?B?RHR2MjR4Y1dIQjJKaDlzSlVjek13dlhJZjFYcW9iWTVKa1VKMDdMdjh5UVB6?=
 =?utf-8?B?OUhXTnQ4aVRISWpGYjVhOGJmN0dnTjdpMW1paGhzelRRVWhRUVZTNW5ZeHhW?=
 =?utf-8?B?Zk9HTTRhMEtSOVQ4MFRWclVTTmRYcHlKaUpzeXRMdDBPb05IUWxaMGlPS1NI?=
 =?utf-8?B?d1JaNWZUbVNYOEl5MitBTWNkK3FLK0lMQjBEdkFsVzlZT1pjZzQ0bW1SNmZZ?=
 =?utf-8?B?Y1lLY1JPT1F0NG5ZMDJVdEt1Ynd6a0UwVWhaekdsbzY3dEVJQkZ1WnFhQjEw?=
 =?utf-8?B?azdFWGM1a0k3NVRDKzVxWHExT1hCa1RsKzVUbHlhQ09EWXFDTCtiVXZmVDAz?=
 =?utf-8?B?RW9aNVJuWVNabHV0b245cWFsZXFFTWtZVWFELys4QXMzQ2ZpQ0hFMzluUzQ1?=
 =?utf-8?B?U21hYWVWRStrVEJIU1dyOXZtZWNSSGwwenM2WEdOV1pwS2x1QnB3cDhGeTQw?=
 =?utf-8?B?YmJYUCtRdkQ5d2xjYkpjT0FHVnFYci9TbmljYjZCQ1ZDQ3dOWS9hdzZ6YU9M?=
 =?utf-8?B?L2FxQksvblJBT3dTK2FmSUJzSXhtbkRhMHkwZEdKRHB1bGpaZnNzMU1JaTg5?=
 =?utf-8?B?L3BYS0JDVldmOWpSQUdNVjlCTk9uSkhha0xIY1pvNnQxeHNIZ2pXem5xdmsr?=
 =?utf-8?B?d2sranpGS0lCMjFlNm9iNUo0aUJmUWhRL0k0WTVEamllYWxIVW1HU04vL3dD?=
 =?utf-8?B?UVVQN256bUpZaFJwdHBJTHpleWtxcXR2YjJJZHlIeFdRSHVjU0dNSGJORG1m?=
 =?utf-8?B?bmQwU2xYbzlvZ2laeElPcVFicThPTnZPaGl5MlBIS0p0NndIcW9hTGZnb05W?=
 =?utf-8?B?enZjaVJXWVAzRVBmOFR5bC9SK0dwamM0cm1abkcwY3JVTUYwTjNZM2hOTU1z?=
 =?utf-8?B?di9KU3VOb0tGR2NwRitCRzZOa3VleTVNa1RFNGhyUkZ2U0t4ak0xQmk5bjly?=
 =?utf-8?Q?DDDLppnzI/aqeZ2Dj3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36da849-725a-4f70-3960-08ded9004f4b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:40:48.9746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziVMtNWTVXXwnATUnsL2o2gqLHrIQiJD6iLLHhqtiU+V5b/2LDcntdLNfU1uzTBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

On 7/3/26 12:37, Tvrtko Ursulin wrote:
...
>>>   +/**
>>> + * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
>>> + *
>>> + * @dev: drm device pointer
>>> + * @data: drm_amdgpu_gem_copy_buffer
>>> + * @filp: drm file pointer
>>> + *
>>> + * Returns:
>>> + * 0 for success, -errno for errors.
>>> + */
>>> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
>>> +                 struct drm_file *filp)
>>> +{
>>> +    struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
>>> +    union drm_amdgpu_gem_copy_buffer *args = data;
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>> +    struct drm_gem_object *src_gobj, *dst_gobj;
>>> +    struct amdgpu_bo *src_bo, *dst_bo;
>>> +    struct dma_fence *fence = NULL;
>>> +    struct sync_file *sync_file;
>>> +    struct drm_exec exec;
>>> +    unsigned int e;
>>> +    int r;
>>> +
>>> +    src_gobj = drm_gem_object_lookup(filp, args->in.src_handle);
>>> +    if (!src_gobj)
>>> +        return -ENOENT;
>>> +
>>> +    dst_gobj = drm_gem_object_lookup(filp, args->in.dst_handle);
>>> +    if (!dst_gobj) {
>>> +        r = -ENOENT;
>>> +        goto err_dst;
>>> +    }
>>> +
>>> +    src_bo = gem_to_amdgpu_bo(src_gobj);
>>> +    dst_bo = gem_to_amdgpu_bo(dst_gobj);
>>> +
>>> +    if (amdgpu_bo_size(src_bo) < amdgpu_bo_size(dst_bo)) {
>>> +        r = -E2BIG;
>>> +        goto err_sizes;
>>> +    }
>>
>> No sub range copy? I would expect something like a ~8MiB transfer buffer to copy a 1GiB buffer in chunks of 2MiB.
> 
> To preemptively make it generic or you already have an use case in mind? But sure, I can add that no problem.

If I'm not completely mistaken that will be needed for CRIU of large buffers at some point. Especially for system without a large BAR.

Additional to that we need this for KFD/DRM render node unification as well and IIRC the existing KFD IOCTL can do sub range copies.

>>> +
>>> +    r = get_unused_fd_flags(O_CLOEXEC);
>>> +    if (r < 0)
>>> +        goto err_put_fence;
>>> +
>>> +    sync_file = sync_file_create(fence);
>>
>> Oh, please no sync_file!
>>
>> Use a drm_syncobj, e.g. drm_syncobj_find() + dma_fence_chain_alloc() before the copy and then drm_syncobj_add_point() when it is done.
> 
> Why not, is sync_file so out of fashion? Syncobj feels heavy weight for what this is and it would require the CRIU side to create and destroy the syncobj.

The sync_file framework is only used by Android. It has quite a number of shortcommings and is pretty much dead everywhere else.

For basically all modern IOCTLs we only use drm_syncobj timeline semaphores.

Regards,
Christian.

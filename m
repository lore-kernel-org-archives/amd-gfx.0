Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3081C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDF26112F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEDF26112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD846E5C6;
	Fri, 22 Oct 2021 15:10:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BD06E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 15:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ManzvDAgbkQi2gK9gbx/0LyFF3R9U2nQ5TBN0PccwGoeT22RfWFM8LUf8wxwA3fs3w05N0B8rvYKG8TeuyTL313u4RoIUM7EbPVmmPB8ypxFFi0c90Mx8VAnzBaNxHgQbp995Q+wmPoakGGI9NKGcNTyT9vbPbMbg279OhQLdbzwTG1SlFzwB2PVprhOgcJMIoXJ2N0ktOlA9xO3vCIcnjiA17obNp9fON/rjdsQiQ3fQj1IaOmSAI6CmRWuq1Xyc0/4zE14cYfxZbpOy6u9NLZG3xVtxhAuhhlAFBVI4DTKLka4tQJAMx1dbU5SwcOzlbFGrSNP2HV12+hfaHPB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl21KjJZjD1Htp7iWWIeabBO1r6PWnZnIGaCIsXZ/Y4=;
 b=O19rlhuiGK9vuZmHb48VLTHixFtti5BNUeMUhoOQoknSCDD2mjOEbowBJoP1/vfn3WP6xgnPKuz36ZHPWeLlG7W2VayTAf6N+sQb+/yte+uurM1rI3ilSJwdfaISoTkI95z2MWlT3m0aIMZnmScm4df5Sqn+5QLdJZy7Keg7wFjOlyYG2YC6sYmwQQHrH7KHUp1u8VLiEpiS0rLJDQr7xHCoQ2O6Tz19auw4Xq/cHXS7ZkUUPOVDYtHhn1n8rQnacZvERAlDzqznJCQvywhrKt9iRiQz243B7cKm7Pz0MJBJ7AhLiUXwFOJi6vbbNbojYewLOKNeoyCnWZuNXMTxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl21KjJZjD1Htp7iWWIeabBO1r6PWnZnIGaCIsXZ/Y4=;
 b=FvEGq5nK5C/GMoqD6A0LKu1OgU23w55owNUpipy3DuIxGtzTffK92qq+ZfMoPLJhX1evY1bc3D7oF4M4l3q5AEjN12e3j1MxKm9L9Fxc2ghn8uaHd8F5RiS/qElVvAblsRx3oEwtnBV55llbX6n2jRpyCWRKZolIhAZczJL70Aw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 15:09:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4628.018; Fri, 22 Oct
 2021 15:09:58 +0000
Subject: Re: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <DM6PR12MB4250B78B1C9E96581C88310EFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6c167e41-dc20-95dc-6f71-839255cc2b25@amd.com>
 <DM6PR12MB425073BB737DFB0376CCD145FBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3250280e-a0b0-f22e-130d-7c9b6a5299cb@amd.com>
Date: Fri, 22 Oct 2021 11:09:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB425073BB737DFB0376CCD145FBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:ebef:cc8e:1b2e:f505]
 (2607:fea8:3edf:49b0:ebef:cc8e:1b2e:f505) by
 YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Fri, 22 Oct 2021 15:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ae73f18-c689-4769-0568-08d9956e0330
X-MS-TrafficTypeDiagnostic: DM5PR12MB1276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12760ABE05B3436F802944D7EA809@DM5PR12MB1276.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRxtg6lgUS5whRlvocjONk/+Q6DS+0EaQ7wrjdXca2VG/tS3qhOF9rcyG1WgHistc6nLRgwTEK+Ngk1rMm4t4ovoyE8EeFot2Ya9K/RM/O6cDPeaAlmJVZUza+M53TxXfOvFqJFXGLm5xnwM+gMf2kBdyqa9V5b9zXHC6xj4+Z52/X8WsjRhWa+sS17d9GZhHltHKMMrgpqIQAje6H/85VehKsIhG228XQGVpndi4rGO0u9RpQpggK2LXgJfG0Wfz4SL1SCNWC6GrJmIsfAblDpc+tk6Q6EWUFpkZeGCecb3W7QoehEoxsUB9/YlbqbtG1zfl2ifo7hgG7uHrVDUMnCwR41APhc2j/2KETiIFKesiPLMm7G2kLqdEB+lyLnGo/eZMrGaQu3U6D/yJaNtNY7QMoy6MwjjI2J4MA2+QQXNzcoMGGFcnK2t34CkVMgZrA2aGBRDZrDp8oSjBY5SokQ0mcpQo5Amn9IdB/JAUUcNxxTn2LI7tKfgLm2RrpGqTHa/uVIjitQw7ArhrrKJI24ak+4YHEvvtpe85LuYKE+g6URjDbDuRhGrhrbglCISeYn9W+KjwlhgPyJJXVhfUkqx0GDE1nI52i0CxmTgxus7XQtULU8BJ7ZwmhkaDD1Om5OFh9ZZyBOlOILUoatXBHryEBf805c84qzXskYzkMO206fGWfmnDjO4FuoGD5WOFZpKIWYJ5dTn75AzvSGhem0epMEJ4iIcNhteN5zNSDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(508600001)(2906002)(66476007)(36756003)(31686004)(8936002)(8676002)(66556008)(53546011)(44832011)(110136005)(66946007)(2616005)(6486002)(83380400001)(4001150100001)(38100700002)(31696002)(316002)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BUY3lEUGlqVGQ1LzZjNGJyZ0VtOSs0aWxpaUd3NVFtQmw0THFDY1dlRmo2?=
 =?utf-8?B?S1ZCa2dhWXhab0NMOCtMckNTbkw3OWpHY3I3c0pnT1ppdEwvVFJRbVBHOGJS?=
 =?utf-8?B?aVpSTkNEb0FLcW4vMFYwR0VsRUdreUJjT2t5YXhvOFA2Rm9pcllXL2NCUjFT?=
 =?utf-8?B?ZkRMcXpmVEtzWTFKU2hQb0kwRlVQN3lsZ2I3dDVXSVE3TGIycGNJV3U3UVQ1?=
 =?utf-8?B?RjdjcDBCZkVqMXp3U25icklUK0U2WGdZTEcxMXpxOXp0RmtnYWcyVDFSM1RB?=
 =?utf-8?B?bVcxQmlXdEhlR3MwUG42cE14V1UrT0xtdTFBZEtPL2oxTnA5dnJidmVXUDdm?=
 =?utf-8?B?WXRzemc0OEtRVDIxcXRXU2xjdS9YUmVzcmFjUHIvbTdGOUJYakJFNG9Fbm1z?=
 =?utf-8?B?THN1VGREOGo0YWVadmo5VlNDRjRzbktuL1VQSm9VZGpMRGpVTmZlK2RrN21w?=
 =?utf-8?B?cXNFUFlhOERRUWdsWGxxNHBJQ3piaDRlS3hSWSswK2pvM1pDTndwOTZnelNK?=
 =?utf-8?B?bUIweDdKSkpkeE1PRkE4NE5yZDRnc0hmTjdSRWhnMDl0TGs0ZllwSmtaOVk2?=
 =?utf-8?B?TVBmbkFwYkFXeDVlSlBoSE1DUWNGNUZHL1RUbkVuZUhzSGlhU2tod1FBbG1W?=
 =?utf-8?B?bTBQVjJWL3hGVkRPbVI5WkkyYjlnTjZRQUY5L25vR0QwUENwK3dJVkp1cFN5?=
 =?utf-8?B?L3NBYWVPaktoa01MREpaYWxRNUNzSFZuK0lpYWJUK3lVRnNkb1ExazYzeVdU?=
 =?utf-8?B?R1JMb2cyRk1nOW1YQ1kxaENHNStHcHF0YWZVYjhzSUYzd2gvbHhUaVdNazNS?=
 =?utf-8?B?UFc1WXRNWml6L0t2cFJpUk5BZmVWQWZkUGJXVk9oOERCcVF4d3hHVmZLcVNL?=
 =?utf-8?B?UGRCTERhaWJzUkNxdGMxdVliakVBSmloOVNRekVzdXpZTDQ0cUswcDE2TlFh?=
 =?utf-8?B?RHZqTE9RS2l5bkZjR3ZSRURraWxpRVFKdUpUaDZUQmdpaWY4am13K2w2amJP?=
 =?utf-8?B?WGRIeDJkL3ZiNEdOS2pKRnY5VEUrRzdzazZpZnpTV3dlNUhIUDRlZTdwZ3Zo?=
 =?utf-8?B?Z2VkdVhnMkkyaTk3dG13QkNSZy9xZE9LUWRWTHpBWFZBU0RVeVZXZitCbmxE?=
 =?utf-8?B?RmZHa3hHSHliY3B0cFErU09YdVFrVWZ2VUgwdWJ6QmJXbFJIUTJWeUs1WE91?=
 =?utf-8?B?OXowRytURnl2a25IM3BjZHJ0cGJ1YzA5VmFlTUNxbEpMVmZmajc2eEpuc1FK?=
 =?utf-8?B?U1J3aFJPNjBWTldYZ3M3ejFBbTB6c0VYaENSdnpiSTNncStuT2FyMTZCeGhF?=
 =?utf-8?B?dm1OM2g3WWc2NENwSEdVdG5HQ3dWditHQjZ1Z2ZQbzdEOUNRZFBkUU1CUE9j?=
 =?utf-8?B?K0FLb1ZqRFJmeXB1Q3RoNTFOVzJ6aUtFSlZYdUVPLy84dUtpb3E5ZjRTaGZh?=
 =?utf-8?B?VlRFVEw0aFZOL2g3QlpWN3JjbzJIZWh1ZnFGMlNRTjl3bXpEUjdabEJIajFy?=
 =?utf-8?B?RS82cHBwcDZKY3pOaG9GWTUyWU9iVHVIb0dyS3VUQStUQnZvTGYrQ29UZkRS?=
 =?utf-8?B?QUUwY3RmdXJtVzZTMFhFWi84MGJqL2I2L25Od01pQnRsMUp0ZDZPeVg4TTlV?=
 =?utf-8?B?dHIzQkExWE9wU0Ric0puN2p0eTJQcmkwVDdtRXhyMW1lQklWTW5QeVRRbDk1?=
 =?utf-8?B?MzZmRHN2SFBkdloya0Y5R2ZWSGxZWEsyc0NVajRVeXc0ejFjTXF1VEZEK0xI?=
 =?utf-8?B?TjMwYUwzZFJ0Y1VNYmh1RytGRk51ektPY2RyVDUwbmtJNi9ueWJpOGFnekp6?=
 =?utf-8?B?R2FJSWhDQ0k3THNudTNMdVhhREdKd2VMRzhDdDl1dWdNM2JoSS9MM0ZzWXE4?=
 =?utf-8?Q?eq9dndSQzvUXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae73f18-c689-4769-0568-08d9956e0330
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 15:09:58.5274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agrodzov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
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


On 2021-10-21 7:33 p.m., Yu, Lang wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Thursday, October 21, 2021 11:18 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
>> amdgpu_device_fini_sw()
>>
>> On 2021-10-21 3:19 a.m., Yu, Lang wrote:
>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Yu, Lang <Lang.Yu@amd.com>
>>>> Sent: Thursday, October 21, 2021 3:18 PM
>>>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
>>>> <Lang.Yu@amd.com>
>>>> Subject: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
>>>> amdgpu_device_fini_sw()
>>>>
>>>> amdgpu_fence_driver_sw_fini() should be executed before
>>>> amdgpu_device_ip_fini(), otherwise fence driver resource won't be
>>>> properly freed as adev->rings have been tore down.
>>
>> Cam you clarify more where exactly the memleak happens ?
>>
>> Andrey
> See amdgpu_fence_driver_sw_fini(), ring->fence_drv.fences will only be freed
> when adev->rings[i] is not NULL.
>
> void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
> {
> 	unsigned int i, j;
>
> 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> 		struct amdgpu_ring *ring = adev->rings[i];
>
> 		if (!ring || !ring->fence_drv.initialized)
> 			continue;
>
> 		if (!ring->no_scheduler)
> 			drm_sched_fini(&ring->sched);
>
> 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
> 			dma_fence_put(ring->fence_drv.fences[j]);
> 		kfree(ring->fence_drv.fences);
> 		ring->fence_drv.fences = NULL;
> 		ring->fence_drv.initialized = false;
> 	}
> }
>
> If amdgpu_device_ip_fini() is executed before amdgpu_fence_driver_sw_fini(),
> amdgpu_device_ip_fini() will call gfx_vX_0_sw_fini()
> then call amdgpu_ring_fini() and set adev->rings[i] to NULL.
> Nothing will be freed in amdgpu_fence_driver_sw_fini().
> ring->fence_drv.fences  memory leak happened!
>
> void amdgpu_ring_fini(struct amdgpu_ring *ring)
> {
> 	......
> 	ring->adev->rings[ring->idx] = NULL;
> }
>
> Regards,
> Lang


Got it, Looks good to me.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

>
>>
>>>> Fixes: 72c8c97b1522 ("drm/amdgpu: Split amdgpu_device_fini into early
>>>> and late")
>>>>
>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>> ---
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 41ce86244144..5654c4790773 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3843,8 +3843,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device
>>>> *adev)
>>>>
>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)  {
>>>> -	amdgpu_device_ip_fini(adev);
>>>> 	amdgpu_fence_driver_sw_fini(adev);
>>>> +	amdgpu_device_ip_fini(adev);
>>>> 	release_firmware(adev->firmware.gpu_info_fw);
>>>> 	adev->firmware.gpu_info_fw = NULL;
>>>> 	adev->accel_working = false;
>>>> --
>>>> 2.25.1

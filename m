Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC9606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mPzKXyhr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B2C112972;
	Fri, 20 Nov 2026 12:01:12 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3E011297B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 12:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9iq1nN6KuSHUl1+A1dIpsykYORmaYcRy0b1OOXuE09oFRFjHeqMbx9ndwSERZKmnVWk3y8OuuaDIAb+jzXCUV1QXe0S2ccecsYRlCnL7tL1tq7fbRUMPmNCmitCbedT1c4s1rC611wKXUyGjAPblSbfqCXZBFBymCN1yT+ww1/BUB6JZi9b4IcZl2WDLV8efNrVuMj+YV0Yn9HMfMUoa8V1qGbnjGlfU4l5coEqjK0froAcwKAQ+oIjc0rXA8OmOeLeWiv+6e40oiNUJniMdLA0ARfzyHjHWsPB6V5GCs6/+0DUg7SnMgdTeAhGNSvldkzsgkVDbGPuwv9VlxACRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7I7GbjaIdjCRZo2EmSyf8AVemfVFj3ZL4oxMw7OBuo=;
 b=hP5OwK5gyvBz4gS4iwvz8tvu4K2I+HP7zr6p4xAFmCWMnSudW59xMFDFyYtGIsOd0juZqfrxwE7vfHQQfdSw69TtJJ+ZCmveIXobSrqimCeK+ZDA3BxjmlIEtZN1MWhOnzFsaK5dMDQc1lQQ3S3Q4NOOvcwoaZitqj8d0LkeB5DiEGbaXKDGMm/EYNzM+4D+yTy4eRB/JXWqvGJOZDmaDZaZfjFfEzz9CLrmhRBw7lPpAWJtVQTurRJP+CsMooM75Jza/ZkNXIoSx4pWfzA+VtC2hcg4AzCQ6MXP2uOB353WImejS8rrh/IURYi7UsbyBIHvtjL5jhD8IQI1buODjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7I7GbjaIdjCRZo2EmSyf8AVemfVFj3ZL4oxMw7OBuo=;
 b=mPzKXyhr7CNhYzRu4AKCJuaSOPflYAHrBWOaPWxBjq+75D4lBvN9iiBVA3YrWjlaQYC8LrCdA95lWy2blVPM/j66s8DFdQJB7cSQjL2rozyNQJrbeZuw5fRDgHvBF8wcGsIqfqbWMxJfR6CPFVBdkSCwM/r19oh1IkeWsLKx2xI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB980390.namprd12.prod.outlook.com (2603:10b6:408:3ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:01:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:01:01 +0000
Message-ID: <011ecfb0-b130-4f9a-a67c-3391d651d207@amd.com>
Date: Fri, 20 Nov 2026 13:00:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
 <20261119095652.3510341-2-Jesse.Zhang@amd.com>
 <6cd1af3d-4647-4cdf-a351-b65effdfab48@amd.com>
 <CADnq5_OmSYu9GN=hcXYD4VLztb0BnBG1nGyLANz9v_gX-3GbiA@mail.gmail.com>
 <DM4PR12MB515233FDF2622F0116CB7ABDE3792@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB515233FDF2622F0116CB7ABDE3792@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB980390:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f1083f-7c00-4997-51f5-08df46fdf20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261026121527099003|261021135927099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: SBtIyD6lUdB5+Qxj77dXzrw39RsjeETQBPN9AgOjpIA6SuvP02vI2ZxdV+46Z7NAjRNRkMYsXu4R0AhzE7kqx2iT5YUKVcejWyUF+YeCIlFTb+eVDTch3XeRpF3aqVa5wMVV9Uoh6nJ4HYehyU6Zucpje6jE6ScXZip3/zVisM6qlWPerBBwE4giTwLob+OyuPhBd71nw1sR3hVTwHaD6aYiuh6PXOmum1/Qg23AJKCWxjF8LHpZnnqhwX17LUG4VHkv7tnUlGud0tP+EU6iPJJ0skXI+L6wSPTGqjdEeYqvG9xuQwEwuX/BJij/u60suVnwNRWDmeW9mJ0yqb3y1kzeJH3R1I0IqikiennZyuQ6Qmbn87spwe4mr//xcN4lM3MjGfaiw7hTcizK1XoqcWzIgeQA9N5/oqmSchC44XhAJznX2H4jUER6u38SpUSOUH+rjqJABpe/xHk/rm5UKPiJr82llNZuXWDdXA9FGw9Eu3Zlma8MGMpjfJTppYB6QoJJSgrCzVsZJZ1Xu9tFNsxzM5UNlSNUWK9AQznNVmhdi5aebzc9M9NcLxaaHecEpUUtlb+GO+3YG1xogGjfj78r7i4smRHbC+ais/pVL+rjyVPYLdap+WHECn9J5j8CAh0LtmCInQiCrYoiV70KAPijoNighCiwj2VUUdDbSxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021135927099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJpeFRyTGZxM3dueFEreWR1c3dHaGFSeG13ZlFvT1h0N0NkbTkweWdIVDI4?=
 =?utf-8?B?WVpTcHZubmhWZW1Daldzc0NHaloxdk5SU0RNcFNaSDM3cHdORUs3aXg5bjlX?=
 =?utf-8?B?RXFLNENIeGtkVmtneGsrWG9Zci9lS3RWL0N6VzVTYW9qZ1o0ZVZpQ0FXS2Va?=
 =?utf-8?B?Ly9Ta3Q4ZUpjSlRRcGNOV1UvN05uRVZISTc0ZHBsRDQyaE1kWGVnUi9CNXFD?=
 =?utf-8?B?bEhCUXFKREF3UzZQM3c4d3NmZ21oTmJSZXRaL1pzZDFsWDdsbTdhZ0lkTWlv?=
 =?utf-8?B?c1A4bGMrbnBIZjZpaEpUaklkeTZuOFNTSFQwWUFtR21FbHkyRXVMbFQ4RTEy?=
 =?utf-8?B?ckdzZ0IxaVRWOTNjZE1QNVl1Sk1LdnpDTWZaMGdHbjMrK1Q5T2Y0K3lRSnVl?=
 =?utf-8?B?a3FBSUQ5S3NSUk16ZnV1dmxaK1k4Q1lkcEo5REV6Sy92amhOdUJXL01HbUhw?=
 =?utf-8?B?cVh6cC9PWlk4bjd3SUZWVFlqR0NsNm9RZ3RIbCtLemZxaUVwMXJBcFcwMFVk?=
 =?utf-8?B?OWFGbFZjUUtIZ1BMN3ZKNlVMMi9jZ0IzbDV4OVNSMFpySm5aNEZ5RDFNNHFx?=
 =?utf-8?B?dEFpMW5POTh0RVEvckVDSHNGbzkvZUdHZFZYOGMxVm0zYi8rRzJNQzlNZk1J?=
 =?utf-8?B?bW5zakdnVFExM0JTYzFrVnBkMUNnWVBXR0NicDZRVldDT0t5WVFMUmdvUUVF?=
 =?utf-8?B?SzQrZVpSQkFQUm85cVJwNFNWbkdXQ2VaSHNvQkVJSGdqNzZ3RmltTEFqTGVx?=
 =?utf-8?B?L2trZWIwWWwzenY1YkRRZHFIU3U2N3NmbUVscjliMUo1OXNwM3N3VnlsSUlP?=
 =?utf-8?B?WWNjaUUwbUk5T2l5SGVuNHlvUCtBRUlRMWIvQ1hFRFFldExadWU0V0tSMStY?=
 =?utf-8?B?WHNGOXlPZ0tVMUpvZ3UwMGw4QkYxd0xuQUlhTXhmTzV5QW0rSnRtUlRuVTdq?=
 =?utf-8?B?Z3ZEeW4xYWdZMW9oMk9aRUtIWStpNWxVRkg1OU5jWEt0UnRnQ1I3OCtTRDIw?=
 =?utf-8?B?ZlpZMUVCS044OWgxS3UxVGs3U2NVZjhKTUxPTWFzN3BocVhSNUEyeGRDU3Bj?=
 =?utf-8?B?blFrOUpzWVRsSUJhN2xJbHhEMDA2dmF3bWY2TWxHazgxOXpFcDJTRldJRDNk?=
 =?utf-8?B?cDBlNG4rV0N0c3lVL3QzVmJsaVBBaTQrNGEwOHpFc0lYbWFKYTQwdXo3OFNm?=
 =?utf-8?B?OGFxTlVDNThSQ3l0R1lWMEViN2ZLd3hMS2NuT2VuVTRjTy9vaUJON1NVWXVq?=
 =?utf-8?B?SVdTVEZ3WlhtSWpFOWowL2w0MTFVQXFTdkhKZTZXbyt2MU9ycmRCWnRuRUY4?=
 =?utf-8?B?aEhJWUw5WktnQ2lpRWhWbnhqaUZpV3ZyTm4xc293U1hyUW5pNVhKREpJUUFh?=
 =?utf-8?B?YkpnVTRyY1Z2K0UrQm5wQ2JOSmZFYjJEVjJ0TkE2bTBHTHZ5VTVyektTOE0z?=
 =?utf-8?B?QnpuemN1bG4wV1RuRWdMSDIxd3N3VHh4U0FKV0JRYUFiNXFocGpSaDR6M2Vz?=
 =?utf-8?B?YzJVYytmb2FqTVRxbStoZnNyRGllRFpsei8ram0xQ1JaY3B6UXVjY3c3OUpD?=
 =?utf-8?B?Y25Qa0RPYmZqS1RNbmNuUXlYemNTWktaYy8zOHU4QUFwNy81TCs5RGp1S2po?=
 =?utf-8?B?RGJBL3N4ZUxjSFlmMllLSytpODBWeGtzdmxxd08zZXNoajdaYVBSelcwYjBS?=
 =?utf-8?B?T0k1d1UySS8vajJYZHBRa01WV0RvYWkzZjFUV3JQS0I1bzhuZlM0NHVFdzFW?=
 =?utf-8?B?cnlybU50TjAzY0F3VGVsN3oyckliK1lHRS8yNytEWkZuRHFncmFiR1piTDJX?=
 =?utf-8?B?ZjAySkcwNjVhSWxMVjF0aGRTZ1Qwb20wbk8xUUFlZHJYK2xUUlk2WTFTdWJl?=
 =?utf-8?B?My9zdG56ZWxOb2IvUm9MeEZRTkFaSzlxcHM2T0xFWmRBSjlWOHJEQ2VqYS9z?=
 =?utf-8?B?R0V1SWlYR1NONTBmWS9yNU5RRnVXd3Ruenc0S1RSa2ZJOGtPekZDKzRmaVdG?=
 =?utf-8?B?RitKcDRPYmUvblU4cVhQNHptOWpDVWxRcXI5blU0b3RZQy9DNUQ4cEtPSHNG?=
 =?utf-8?B?M3NscGN1bGN6cFNuejlxdHFzbE1wRGVuVElhclcxSktFejJPcE5zRXZVb0xG?=
 =?utf-8?B?bkNkMnk2M2xQaHdybzFYTlBIMWhiL0ZUMmE3UlBrN29iNVBwV0lMWWVNaWVC?=
 =?utf-8?B?eFNWeDdyM20zZnhZOHBsbmtQRUdiL0NNVFFyZEpKQjV2YWE4TGdWVnhENW1m?=
 =?utf-8?B?WFBydU5CSVRCUDlpaTBKbzFqcmtvd21KME9zVENoNUQvS3ZYSENLYkVhclFn?=
 =?utf-8?Q?Ipk6EpuBM6Q2ruk3vF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f1083f-7c00-4997-51f5-08df46fdf20d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:01:01.5005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzbpfk5X0sCu2H1f6/XDRwZkeT1/gDSnmWp9jat0euXK9vHUaXNr9i60p0X0A7sF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB980390
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 00:43, Zhang, Jesse(Jie) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, November 19, 2026 11:54 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>
>> Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
>> amdgpu_vm_init()
>>
>> On Thu, Nov 19, 2026 at 9:56 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>>
>>>
>>>
>>> On 11/19/26 10:56, Jesse Zhang wrote:
>>>> The error path of amdgpu_vm_init() frees the root PD, which clears
>>>> vm->root.bo, and then unreserves vm->root.bo. On navi48, with an
>>>> allocation after reserving the root PD failing through failslab
>>>> while opening the render node:
>>>>
>>>>   Oops: general protection fault, probably for non-canonical address
>> 0xdffffc000000005e: 0000 [#1] SMP KASAN NOPTI
>>>>   KASAN: null-ptr-deref in range [0x00000000000002f0-
>> 0x00000000000002f7]
>>>>   RIP: 0010:amdgpu_vm_init+0xa9f/0x1480 [amdgpu]
>>>>    amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]
>>>>    drm_file_alloc+0x58f/0xac0 [drm]
>>>>    drm_open_helper+0x1b3/0x4b0 [drm]
>>>>
>>>> Unreserve it through root_bo, which still holds a reference. With
>>>> this and the entity fix 4842 opens with allocations failing in turn
>>>> don't oops anymore.
>>>>
>>>> Fixes: 8473bfdcb5b1 ("drm/amdgpu: fix error handling in
>>>> amdgpu_vm_init")
>>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>>
>>> That is already fixed with:
>>>
>>> commit 26401a4999f1596a515b2e704e7066ac09306488
>>> Author: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Date:   Wed Oct 7 14:46:57 2026 +0200
>>>
>>>     drm/exec: don't immediately add prelocked obj to array of locked
>>> objs
>>>
>>
>> If this is missing from ASDN, feel free to cherry-pick.
> 
> Hi Christian, Alex,
> 
> Thanks. As far as I can see, 26401a4999f1 ("drm/exec: don't immediately
> add prelocked obj to array of locked objs") only changes drm_exec and
> doesn't touch the amdgpu_vm_init() error path.

Sorry that was my fault I replied to the wrong mail.

The patch 26401a4999f1 ("drm/exec: don't immediately add prelocked obj to array of locked objs") fixes the issue patch #1 in this series tries to address and not patch #2.

So yeah patch #2 is perfectly correct, but we should just cherry pick the drm/exec fix into amd-staging-drm-next, going to take a look at that today.

Thanks,
Christian.

> 
> The same fix as this patch landed in amd-staging-drm-next yesterday:
> 
>   768e106833a9 ("drm/amdgpu: fix NULL deref in error path")
> 
> from Pierre-Eric, so please drop this patch. I'll cherry-pick
> 768e106833a9 to amd-unified-interface,
> 
> Thanks
> Jesse
>>
>> Alex
>>
>>>
>>> Regards,
>>> Christian
>>>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 8cc5964f29c0..272eac0ef317 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2718,8 +2718,9 @@ int amdgpu_vm_init(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>>>       return 0;
>>>>
>>>>  error_free_root:
>>>> +     /* This clears vm->root.bo, root_bo keeps the BO alive */
>>>>       amdgpu_vm_pt_free_root(adev, vm);
>>>> -     amdgpu_bo_unreserve(vm->root.bo);
>>>> +     amdgpu_bo_unreserve(root_bo);
>>>>       amdgpu_bo_unref(&root_bo);
>>>>
>>>>  error_free_delayed:
>>>


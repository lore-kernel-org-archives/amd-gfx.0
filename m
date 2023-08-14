Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2456C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 14:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916BE10E1FE;
	Mon, 14 Aug 2023 14:14:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A2610E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 14:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjoD0EQ+PbO4KzFVt+DzaUPgbJv2OSEEHACZpDCN9Yo7sXgvE66ZfvK6oRlMH33rG0mARByOT84L5p9m+r22GzNPXpUY26QaIVuXDsH/vVUVGqn/gN8s3eo/c0DemRInQhvvMXigLR1FRB0wT0teVnKhkbvul/8MhHGBHPT/KHRCSgyUeRiigEUI0Myqp4+m4o0pZAD7AOIWK+jWGJza6j5kZCGrMqW8z06ia3lis/J8Ro+oaeNiQpJ3OKWpyqDzhDT/Ooz40+8yhXhU2W97sErgjlXyj2TuRNuwNK9xdKMdYFcpoEcqSjniYxy/jeW/WsWUFtqR9Sx9vkh93rGfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDQnn4zkndGSYdVJeXTB3tarB/IvgDna6HPA/J/cP50=;
 b=coV/HnoyFOxGy6UkCuqAVcwZGeYR4wZkhTBMB5eQpr5fdXv5lzcZS97wWuP/DzIIG9XA5s7TfVIhPs7vEm2z1/TS0mbVMWZ2Zo7V0+LGy5I+zLd0AcK4M5urZ0Un5iSnK4BWpQkp0+qZusFAQa9StnDtXFBCsjRBA1WMZr+K8A5zl4k7d7myjJ+CzP2xlq7CyiCExYqU+1jT41fLi3f5vzfR2P5QXmhrN8hiLNFkSzUvf0284hKCScYKF0EPd+mhq352xzmw2eHe6eQFuwD7v0r6UX0tzgKRwZsX1FA2WJRte43kCg+MX62rGsx3a5aWIJg6K7iy3E++ybGIerVbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDQnn4zkndGSYdVJeXTB3tarB/IvgDna6HPA/J/cP50=;
 b=n2yHlkl33KuggLq3d1Eeh4JkD6nuFHIu29Xem5UXLu12CQw/AowqZPWYtRUT0vTGzp40642NEBPAJJL8qL+wKCYrzXcMz0Tl+rlZcXiVmiCaWFkB33Sz0GI94RCnT4u+UV2cJ53zOxxSr5OBG91ZfTgaX7CmHXFrwVsqGUvI6to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:14:28 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 14:14:28 +0000
Message-ID: <51e7568a-9b77-566c-90e4-c416346e50eb@amd.com>
Date: Mon, 14 Aug 2023 19:44:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
 <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <1f81e70b-2469-6042-8d97-d150e67dc9c7@amd.com>
 <4733316f-a964-8c13-ea56-67e2f5582ab2@amd.com>
 <835d132d-47a9-42ae-e484-9ac51b7f828d@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <835d132d-47a9-42ae-e484-9ac51b7f828d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f3c3a8-4a43-444f-724c-08db9cd0c51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLiQcqNTKPYoLc0WJ8qcjqCFEhVo/FiaXuJQscKnlVNGrH/muMILUgq4w91RnDhGlCQ/J78egp+DUkwJNTJiR5dh6Uf0YPgVcYqIa45Zc6PW5+07LZ7HdgZynK6OawXEcKb7TAP7FP5mRoEhUf7rnpMJbalRAgyHP0kcd5hcpED33Gw3oZhHiVVMg0rH9g0mEYatSA+jcdlUelUU0j79/IKLhlHjK76uVAI3HrpNJLAplkxFE2INYdYzZ16knilZgGGHT/UWa4bJpqlX2PcOe3047hrJu3hbnGqEXNEaP76V8amDk9PnyEtfHiT2PiFbuQ1l96gwuf31APgCGf6F9RpO1ew9xwFxnXQnfehPFl0TPNk39uLVvnF9XKG7zSH5tdPKsNXg6qvImpcyQqlcHO7F4qjvq9x4R/RdfVY9YVolj9eLCxOrrCOyrKmSAZz1IvgbkopF7LraDGZSo4rFQ+aciogI/u4lb3kqr/r9LQjbYnIV+XTS/Z9YUX0WeYvua8965Vrhk/KzJrkudynNxD1/hBtwZXNcO1bR2VToseAXtBobwsTzaD3Hh/bwga15wdML0S+0pwyabeUtrKGB6M77CNxbEVsL7Hp3HU28uRM7nyRrtxbYhCVi2KWFhiUaeRTQlwCygIoQ6DXxTphj9RdydcoHDqHHroxSX5I7N9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(186006)(1800799006)(451199021)(478600001)(966005)(6666004)(8936002)(8676002)(4326008)(66556008)(66476007)(54906003)(110136005)(316002)(41300700001)(38100700002)(66946007)(83380400001)(66574015)(6512007)(6486002)(6506007)(53546011)(26005)(2616005)(86362001)(2906002)(31696002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdpSFh5aDI2RFJHbU1Td0tZMmdBczhpclk3a2ViY0s4MmF3Rk14RDlEbFNj?=
 =?utf-8?B?UDhvSzV2dDdiS1JkTlpvTnc2NU5OM0pYM3hLWGJtN1lPTlFlMG9lM25XNllp?=
 =?utf-8?B?c0ZrQWZuWnJlTFlramhRd2ZKOWdXdGlvNVJJSHhPdUVLNkdHWWNNckpYQnU3?=
 =?utf-8?B?R3dKK0hBQjFEM3JGbFBUbEw5T0RaaldZRHBSN05RZ2xlc0hMWUwzb21GSUk0?=
 =?utf-8?B?RndpczZWdnFVMC96a05XbXNuQmEyc0ViREFESUpNbFlpVGF0dDJyQW5rb05u?=
 =?utf-8?B?Y095a0dYZFljVmR5Ky9VcHE3SDdGRGFwb3Z6TmZYcXVGZTVicVJ3WEhCN1ZX?=
 =?utf-8?B?THVKa0tTR3BTYVJLZWhhY0R0NlJpZFhFNm5uT1czNnlDdVJXVkZaWExrZWIy?=
 =?utf-8?B?VTNlOCtkd2xGTE9JS2xLQkd0bEpCaGZ2amxqZUd0OEZDcjlzQlIrZ2ZRa2Zn?=
 =?utf-8?B?VnhlS0tRTDhraThjY2xGOHErNWY1UVg3YVc2M1dNR3FTbkxJK09WcjZ2eTBu?=
 =?utf-8?B?TGp5bzZpa0tPNys5V29teFpzL0dUT1dzVnAzUHhvK0hRUGJjRWVKVklJcSs1?=
 =?utf-8?B?L0lhVW5pSG5pNzlGZ3JqVkJEeFV1TEk3aDVpZUdyeWIyekRhcitDbFFjRjR4?=
 =?utf-8?B?THlCNVk5ZWtGbUJZRDc4Sk8zbDBXditrakY5SUxkTmlWWFJTNFdubnJJZGR6?=
 =?utf-8?B?T2oxcnlQQkcwOVJvMElHa29KaEZzSEcrTVpnYXczbklvQTNvUkdZVTd6dlZz?=
 =?utf-8?B?SDhmVldJRDRvTHVUb1dMaEhJQWM2Skdua3dObHFpSlhSL1NuU1lOT0MrRTdn?=
 =?utf-8?B?eW1paUFPMitpQWlBaFJ2bGNqT01qbXNwZExYVXBmWFVWWkdydjFmeTZPVlZ5?=
 =?utf-8?B?MUJTMDZWZXB0ZGtBQkp4a0lMNjFwVFUzMSs5V3ZCZU40RkNGdTRsZVBjMUV1?=
 =?utf-8?B?NFR0cjd6OHFnbTc0c3RaaGZsYkd0UE02bUxKNjU1emF1U0VDSm1xS2lubTFa?=
 =?utf-8?B?b1JZZEFuVFV3REdNUzUxcmJXdVI0SGpsMXE4Nm4zU3orZVpibU9wS0dRMnFK?=
 =?utf-8?B?Mk96Vnc1WHNJL1ZycXZXRW5pbTFtTW5pOEJwMHd0Nms4MU4wY1NtV3lrekdE?=
 =?utf-8?B?STNudUduZ0JORWswUks5cUtkNUxmTFJMcnBUNDdDTWI0UmIyZmMrNWl1U0s0?=
 =?utf-8?B?dHMzeVFPa056QTB4cnVSN0ZyVWUxekh4d0ZYTFZPeUo1V2ZpQ3haRExBdlVa?=
 =?utf-8?B?UnluVmJiZ3ZyaDA0SExtU3QwTzRVbTJUS2g1Z2tPYUl5OVlNQUR6YXdKZXA2?=
 =?utf-8?B?T1cyc3RkZkJ0OGtDRXB4RGFkb3F6U1pmKzdLRVhIdjRPU09RUThsSUpsTjBG?=
 =?utf-8?B?MU13alVTY1hTcGRNNHhvODFFNk1CZUNTb2ZpcUNxcHNLWlcyc0pxUjNTd0dK?=
 =?utf-8?B?YVRrRWQyZHVqTThvcHN3SSthSGZHYTB1N0ozbE5RTWtpajJNcTVUVXBrK2Z4?=
 =?utf-8?B?T0ZpVy9LY1g5WU5jNmg3Y2xYMDZFd3pEMUxmL0xoUXlYU2Vha3p6aVVVSFlh?=
 =?utf-8?B?bXlYRnJDa0owZUY2aWdWaWJFdnJyU1JWQ2ZKMWRVU1Uwdmg3V2Mwclo5NmhX?=
 =?utf-8?B?NnVlZytJU1pPOGlGc1dnellvMmtQUm5YSzZpZmUxT1dIMkEvT1pLTm5KSmNa?=
 =?utf-8?B?cVc4aURKcDJjTFVmakZabTVOSWRhaUE2K2Fpbk1KbGplWUhjNE5BUCtGTHdr?=
 =?utf-8?B?NUtRQnRYNXFoMUJrcy9IK3kxc3lCY2xWZ1luSGprZzdENXhNZW12blhaZ2Fx?=
 =?utf-8?B?VDdFeVpmclF0aUk1RWtrMHpOR25hclRSYjdkb3dxMFFuUGhwbVIrU0ZIblN6?=
 =?utf-8?B?Rk9od3VORWZRb0FZcWtLYVNIUEtvM2t6S0IvdEhvMDhQQzhVSmJ2Zlk2QWE1?=
 =?utf-8?B?K1NOSDhvVll4aXVZdVdqMnZyd0tVT2ZqU0ZURmZuOGl3by8zSHMrVXl0alNz?=
 =?utf-8?B?ZGRUWnhjNDFzRHF0QkV3UHk3MzZta09vQ1BQeCs0NzhqOStFcmNwL05hTHV2?=
 =?utf-8?B?aTQrUGlKOVpsSXVuQm9ZOGk0SXFvamI5VHZnS25HOGlmTDdqTElodXRDR2lG?=
 =?utf-8?Q?i8BuvOq0/+kUdHTi7MI05Cry/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3c3a8-4a43-444f-724c-08db9cd0c51b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:14:28.1272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prm/uyEQSv89lL6Z9x08tQbKQ9KdYc/G1Qt2s1llTgq+EqUpRLYye8SekqsYXXAl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/14/2023 7:28 PM, James Zhu wrote:
> 
> On 2023-08-12 13:00, Lazar, Lijo wrote:
>>
>>
>> On 8/12/2023 6:14 PM, James Zhu wrote:
>>>
>>> On 2023-08-11 21:39, Lazar, Lijo wrote:
>>>>
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>> A dynamic partition switch could happen later.  The switch could 
>>>> still be successful in terms of hardware,
>>> [JZ] Only ignore render node assignment, and remove visibility in 
>>> user space, xcp continues to be generated as usual. so switch should 
>>> work as usual
>>
>> Switch is not useful for the user unless the apps can make use of the 
>> render nodes. A 'success' from hardware perspective doesn't turn out 
>> to be a 'success' for users eventually to make use of the extra 
>> partition.
> [JZ] Yes, After switch, app can use the render nodes (no more than 64 
> nodes in one system), Like 8P MI300X CPX mode,  with no external VGA 
> device,all 64 nodes can be used. with one  external VGA device, 63 nodes 
> can be used.

Understood. What I meant is we should be having the 'warn message' with 
partition switch (when user really wants to make use of partitions) 
rather than on driver load (as with this patch). Technically, some of 
those nodes are usable only after a partition switch.

>>
>>>> and hence gives a false feeling of success even if there are no 
>>>> render nodes available for any app to make use of the partition.
>>> [JZ] from driver prospective, the switch is real success, treat the 
>>> last one harvested in user space.. there is warning in kernel log, 
>>> and final solution for more than 64 nodes is on-going
>>
>> The render nodes are allocated during driver load and the message will 
>> go unnoticed. We could still allow the switch, but the message should 
>> be there during a partition switch like 'only x/y (x out of y nodes) 
>> are usable'. The worst case is - only 1 out of N meaning no benefit - 
>> and in that case user may switch back to normal mode to make use of 
>> full compute power.
>>
>>>>
>>>> Also, a kfd node is not expected to have a valid xcp pointer on 
>>>> devices without partition.
>>> [JZ] won't affect xcp pointer, only ddev.
>>>> This access could break then gpu->xcp->ddev.
>>> [JZ] added skip when ddev==NULL
>>
>> What I meant is xcp in kfd node could be NULL on SOCs like NV series. 
>> There should be a check for xcp before accessing ddev -
>> https://elixir.bootlin.com/linux/v6.5-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_device.c#L794 
>>
> [JZ] So it is potential bug before this patch. then we need review 
> current code to add all necessary xcp check.

We already have checks - 
https://elixir.bootlin.com/linux/v6.5-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_topology.c#L2027

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>> ------------------------------------------------------------------------ 
>>>>
>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>>>> James Zhu <James.Zhu@amd.com>
>>>> *Sent:* Saturday, August 12, 2023 2:36:27 AM
>>>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Lin, Amber <Amber.Lin@amd.com>; Zhu, James 
>>>> <James.Zhu@amd.com>; Kasiviswanathan, Harish 
>>>> <Harish.Kasiviswanathan@amd.com>; Koenig, Christian 
>>>> <Christian.Koenig@amd.com>
>>>> *Subject:* [PATCH v3] drm/amdgpu: skip xcp drm device allocation 
>>>> when out of drm resource
>>>> Return 0 when drm device alloc failed with -ENOSPC in
>>>> order to  allow amdgpu drive loading. But the xcp without
>>>> drm device node assigned won't be visiable in user space.
>>>> This helps amdgpu driver loading on system which has more
>>>> than 64 nodes, the current limitation.
>>>>
>>>> The proposal to add more drm nodes is discussed in public,
>>>> which will support up to 2^20 nodes totally.
>>>> kernel drm:
>>>> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/ 
>>>>
>>>> libdrm:
>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> Acked-by: Christian König <christian.koenig@amd.com>
>>>>
>>>> -v2: added warning message
>>>> -v3: use dev_warn
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>>>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> index 9c9cca129498..565a1fa436d4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct 
>>>> amdgpu_device *adev)
>>>>
>>>>          for (i = 1; i < MAX_XCP; i++) {
>>>>                  ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
>>>> -               if (ret)
>>>> +               if (ret == -ENOSPC) {
>>>> +                       dev_warn(adev->dev,
>>>> +                       "Skip xcp node #%d when out of drm node 
>>>> resource.", i);
>>>> +                       return 0;
>>>> +               } else if (ret) {
>>>>                          return ret;
>>>> +               }
>>>>
>>>>                  /* Redirect all IOCTLs to the primary device */
>>>>                  adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
>>>> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device 
>>>> *adev,
>>>>                  return 0;
>>>>
>>>>          for (i = 1; i < MAX_XCP; i++) {
>>>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>>>> +                       break;
>>>> +
>>>>                  ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, 
>>>> ent->driver_data);
>>>>                  if (ret)
>>>>                          return ret;
>>>> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device 
>>>> *adev)
>>>>                  return;
>>>>
>>>>          for (i = 1; i < MAX_XCP; i++) {
>>>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>>>> +                       break;
>>>> +
>>>>                  p_ddev = adev->xcp_mgr->xcp[i].ddev;
>>>>                  drm_dev_unplug(p_ddev);
>>>>                  p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> index 3b0749390388..310df98ba46a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node 
>>>> *gpu)
>>>>          int i;
>>>>          const char *asic_name = 
>>>> amdgpu_asic_name[gpu->adev->asic_type];
>>>>
>>>> +
>>>>          gpu_id = kfd_generate_gpu_id(gpu);
>>>> -       pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>>>> +       if (!gpu->xcp->ddev) {
>>>> +               dev_warn(gpu->adev->dev,
>>>> +               "Won't add GPU (ID: 0x%x) to topology since it has 
>>>> no drm node assigned.",
>>>> +               gpu_id);
>>>> +               return 0;
>>>> +       } else {
>>>> +               pr_debug("Adding new GPU (ID: 0x%x) to topology\n", 
>>>> gpu_id);
>>>> +       }
>>>>
>>>>          /* Check to see if this gpu device exists in the 
>>>> topology_device_list.
>>>>           * If so, assign the gpu to that device,
>>>> -- 
>>>> 2.34.1
>>>>

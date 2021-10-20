Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00198C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B102860F22
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B102860F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AAD6E24D;
	Wed, 20 Oct 2021 10:49:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610516E24D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO1U9kAqh8aQmuzn8iGg50r/S0aJFjVbKROavRs9v9CDy3bhWNQFuyQb01lfcTHOjX6FRC8/5lpsM0ccojCzRkCtVQ6Hn/+Jy5aQ+alo6sXxUo8zvnjkdjbUpOaYA0vLVlXBQS7954JP/yjg4CrONy40fJCioE0wVna+KU/ZJ+7WlVwc6WfJeKy+HuDBbA4Hb71kXedxwPkR+oioTq0+FG/aofRcVregfH8TyhrNwWtzdf1lKwlDwPvk3bZrz7SF4pwsVcyuDzB2xXwzBopdNFIJukUkikTJKbLVxbt4R6WYveWUgDwBwBCi3O7I2dxTEuD5nmTho6yUZGVdk84tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gegMfjmBjSvVAVEdYNXUkca0iLRz44NeHgAqeBQGWHM=;
 b=Z9K25nxpZ5uCOK1CfvV0DiAATjrguBByMRAxarO63n0DEr3wCQvHVo1TTNJ+raDS+4jTzWcoOgGkpQGXO0Wte2x5aSNontFI6zr181FOe6EjRyBZTK7hKbRSrrIXFDS/c2/0gnFkAmFc2Iezo8D3j51j0WR/tWd9pu6fBzkz3JEHQlRsHLINm3OAMeSGVRQct++VMVLttO9vVVj515DvR2fPT2hXEugQpmQfOhyyCUEge0IQL8SjoYOekQt42SlBIDOg4lcw+zbXEuTCFE+SBDEdvSPG74cC1kyaIZpKHOUGalhFHSQmnn91R8aC4a8zQ579yYZ5AEJCbJh+dHOPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gegMfjmBjSvVAVEdYNXUkca0iLRz44NeHgAqeBQGWHM=;
 b=uMCsrV9vOSxcuP9fKRBtEhpyzF4/oc3R1BQQufaWr6CVBzDxHah/WXFuHRYGt74GBDFxKrkozSF0yexYBiwwvq9ftPTnrYTWVqhwDoI29cruZqgL1VaW1PvfazrgVqrfTV9T/sylqyznAJB34yTSA162y1V6B8HhIJMVpCfOtv4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2555.namprd12.prod.outlook.com
 (2603:10b6:907:b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 10:49:21 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.018; Wed, 20 Oct
 2021 10:49:21 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Das, Nirmoy" <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
 <0cff2a61-0637-cf31-2a60-5326c6bd40f7@amd.com>
 <9737857e-99a2-682d-35ea-f8e5737cff40@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <42e31246-5b59-b806-9eac-b2a95a821fa2@amd.com>
Date: Wed, 20 Oct 2021 12:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9737857e-99a2-682d-35ea-f8e5737cff40@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::16) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6]
 (2a02:908:1252:fb60:6048:8836:7968:5df6) by
 AM6PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 10:49:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 877a77fb-7baa-466f-15a1-08d993b745e1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255554D4FC83315AEB96C24883BE9@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDrOCUuJdprOeIbthqSU7l6WdcIP/1lSOudOJzaQG71Dkn3ppd8lKo31DNfk7iHCpNMqlpLqUrCw68X6bvGMB8xVoNnEDNJuwfbE4ymjdSdPfF3dhgQHWZVAOm8MHoZEWxamJcX14aZJrkgUrvoAndlu42Ru55EtEFR2EG/jpHhNSk9wLVkfFDRAu+ZhalGSHPplcaT7gpsl8RRWS2pQ8q63Nh0haVYoFOwiisfrxhfGbinKUu/Eb6ql6c5qI/f52XPBuVxlUg/uFYTHgNx8sxvb/rVV+u5kCtoAMx29GerdAuruux2DtH6g6QS6ebIzxGkEz/IEJG4AfxFslPjIqge3bd5rxcwdPUlFlRQta7pZTdZpXE5uzQFIj5nVNJswpgifmTpPJZv/xJ8v+Yk69NrBY/0P+JIUnc7jB5WrC7HgajRDc6hvGcwIsZ/Si2sQkR2eFs/Ka+ERb6i67QyzBLCPEC9Nbo7gitg+vN5MZR2MD7jJmJOkz6ozEtMWGnKVoWm7JeyLSt6GbgRhnLLFZMX0stwNg63SopBieGDS0MPDmW5aTJX2MTUZTl0GW9nKBlwSiDVKzkCCZ0+ML01z4tskBbLGBFzKslJERxZNTpcmaxyeMrhK7N9Qr6zGFi6jwnDEX2IEqmtVeSbJhelWr0d3N+0j4PKo8PRZ5JnYPcIcIYT7252i67S38DtfxGcf3B+RWo6VBptkI0QBsTtaGXMAek1iuQ4AXQJ0LZrD6rlD11qNdNCewSsggf6zaRR9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66574015)(86362001)(186003)(8936002)(38100700002)(36756003)(2906002)(5660300002)(83380400001)(498600001)(2616005)(31696002)(66946007)(31686004)(66476007)(66556008)(53546011)(4326008)(6486002)(110136005)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dko4dkkrVVQ2eG8yN1VuaG5UUGp3YjRqWkJJbWtLS0IzK2xnR2drZTJKeGFw?=
 =?utf-8?B?aFFQTFRpcG1zUXFhbys3cXF3b3NWRXE3Z3h5b1Z1UXB3ZlMwbXE3b0E5aG1i?=
 =?utf-8?B?VjBQTldUaTFJMnFMSnFDOHpVSitiS3l1S0YvOUJVSzl3NVAzeS82T3hacElm?=
 =?utf-8?B?cEVCaStLelBtc2hxUTg5VGNiK2MrTnR2aFlNcDMxMVd3YnByN2V0SUZEQUYw?=
 =?utf-8?B?RjFQQnJwQi9Zd0YwdGQ5Y0xmWjFIMDB3MkVnV20wRmw3d0FrTERZTlFwT1F3?=
 =?utf-8?B?bS9yN1IxVW5XY1lGWlhndHRjbUMxb0lBZytWKzcrZzRZRFBaNExIZmlJQlh6?=
 =?utf-8?B?cDI5NEFrR1VwNzRiUHFIcFNMaUt5YUhpVDdNemI5VlFKckNvMlBRdUJnZ1RI?=
 =?utf-8?B?dy9PY0hxNjFod2c5R0R5dTByV2VvS3dGUzZDeWlqTXNDR09KUTBRMFFMOFo3?=
 =?utf-8?B?OUNaL3czTGNIeW1EUkYrbk5QSkF4K2hZbmJBZzRhV2s0a1pXcXZrMlZoYXFz?=
 =?utf-8?B?S1VEckxiVTZadmJneUJFMTdkcUtrNWhyR00vVjJ3SlBoSURKOVlYbCttVThP?=
 =?utf-8?B?T0JlQk13WGJwcGZReHNlTFdpUGFRL0hEYlJqWGNtK3ltMlBHMzdlbnd6RjE2?=
 =?utf-8?B?bDJsWWlWd1p0N2RFOFlEekM3Wml1NjhNVnZMbFc3TmlLTnJDZWJwb1U2T0VX?=
 =?utf-8?B?T2srYlkxRTJ3YTk2bjBJY3lpZnkzeWFSd3FGcjZXZGR0dHdKRG1QYkdBQVR2?=
 =?utf-8?B?S3dNMWxDcVpsa0lvYjJRdlNSRWo5TUpLd0xZSk1Hb2RPQ1JSN2J4RXZiMUkx?=
 =?utf-8?B?aEV3Sno3akd2ck1SQlZnZzZFaE4vUm1qTExFSHBncUd6NTNWVDc2WExjQTZU?=
 =?utf-8?B?dUJDdnZZWjlCU25leWVGMFNBd1FXbC9vS3BWdy9CMlpEWm9iZ0ZVcmJCSThs?=
 =?utf-8?B?Vng2aHVsOEhRL1BDbDRkdlBVWW85bksrOHQ4ZFYzdUpjV3IrWlYvM2wyalF1?=
 =?utf-8?B?bi83T2pVQ3NZKzVmQlU3R1ZpNWpJVmI3RXovWVlqbXdWNVUzOGp5NCtheSt5?=
 =?utf-8?B?dkxyUE1ab1owYjRsaDdmeFlZcFNyR2p5L1J0MzlPYzBYR0JyUG00a0M2VWYw?=
 =?utf-8?B?SEladzBNdG1MNndkRFUyMnZBeWVtS0hZYXRoaDJsRGFpaUlKUWFHVXNDREh5?=
 =?utf-8?B?WGtyOVpwb2VpWGJrVElmN2pQVDFuMzdYZk5aMlBaaXNsekR3RnI4R2JncUx1?=
 =?utf-8?B?dmRCSnNZTExveE1HNVlRODZWQnNaQlE2TzMrRFVyT3VGYTB1NEt2WWdBL1Y1?=
 =?utf-8?B?UEgvb082VlNDOER6UkhCLzlxSFUzenp4ZDNmT1B0NG9kOVJrT0JhQnM1ZjdB?=
 =?utf-8?B?V2toWGlDNmU0aG5ESmJWbjlHdTBTVzRqN1NiMmxHend1b0c4SUp6TE0yVG1m?=
 =?utf-8?B?aDJzeThsYXZrYkdTYVB4VU5UV2c3SE5lNjMzWDQxU3RmU0dsOTNsQSsyVnV2?=
 =?utf-8?B?dndtRHhiZ0pLYm1MckVzV3RKOWVhY2tFVjlCb2dsYnJMVTIza2RYdTJIS1Rv?=
 =?utf-8?B?aGlETmwzME9tVHlIWVRKNjlONERtS0J5SmVjUXBOQlBFa2VrQjFvbGpPSHZD?=
 =?utf-8?B?Ukl4aTVIZHR2R0pPMS8zbXpTbnFvOEN4RDg0R0VxNURSbk85dnZVQlZDWW94?=
 =?utf-8?B?Y1dKWVNURmkxTXZLdUlXaWFVZ3hKYjdkZEw0N2xLM3U4Mkd1Z09tMkdWelkv?=
 =?utf-8?B?S3kxRHpsNXZCR0ZSaHVOTlFlcmE5eFN4a3E5VURKU1ZEejVyVDlRQ1JmSGRh?=
 =?utf-8?B?cGpxcERpUG16Y0F2MWliUE44dktXYS9SMzZVSFVyOFVicjk0M3dZQ1d0Kzkw?=
 =?utf-8?Q?V1UdVBwIcePYR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877a77fb-7baa-466f-15a1-08d993b745e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:49:21.2442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1hec/13HUEDCyB4v2ZWpOuQhrz8EOyeyo9+KveL5lDLelInzMleGogNQNwr6x5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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

Am 20.10.21 um 11:19 schrieb Lazar, Lijo:
>
>
> On 10/20/2021 2:18 PM, Das, Nirmoy wrote:
>>
>> On 10/20/2021 8:49 AM, Christian König wrote:
>>> Am 19.10.21 um 20:14 schrieb Nirmoy Das:
>>>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>>>> any ttm_resource_manager pointer. Also there is no need
>>>> to force other module to call a ttm function just to
>>>> eventually call gtt_mgr functions.
>>>
>>> That's a rather bad idea I think.
>>>
>>> The GTT and VRAM manager work on their respective objects and not on 
>>> the adev directly.
>>
>>
>> What is bothering me is : it is obvious that  the 
>> amdgpu_gtt_mgr_usage() for example should only calculate
>>
>> usages for TTM_PL_TT type resource manager, why to pass that 
>> explicitly. I am trying to leverage the fact that
>>
>> we only have one gtt/vram manager for a adev and the functions that I 
>> changed  work on whole gtt/vram manager
>>
>> as a unit.
>>
>
> Don't know about the functional aspects. From a sofware perspective, 
> amdgpu_gtt_mgr_*() operating on struct amdgpu_gtt_mgr *mgr seems more 
> logical.

What we could do is to pass in amdgpu_gtt_mgr instead of 
ttm_resource_manager and then use &adev->mman.gtt_mgr.

Regards,
Christian.

>
>
> Thanks,
> Lijo
>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 
>>>> ++++++++++++---------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
>>>>   4 files changed, 24 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 41ce86244144..5807df52031c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct 
>>>> amdgpu_device *adev,
>>>>         amdgpu_virt_init_data_exchange(adev);
>>>>       /* we need recover gart prior to run SMC/CP/SDMA resume */
>>>> - amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, 
>>>> TTM_PL_TT));
>>>> +    amdgpu_gtt_mgr_recover(adev);
>>>>         r = amdgpu_device_fw_loading(adev);
>>>>       if (r)
>>>> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>>> *device_list_handle,
>>>>                       amdgpu_inc_vram_lost(tmp_adev);
>>>>                   }
>>>>   -                r = 
>>>> amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, 
>>>> TTM_PL_TT));
>>>> +                r = amdgpu_gtt_mgr_recover(tmp_adev);
>>>>                   if (r)
>>>>                       goto out;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>> index c18f16b3be9c..5e41f8ef743a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>> @@ -77,10 +77,8 @@ static ssize_t 
>>>> amdgpu_mem_info_gtt_used_show(struct device *dev,
>>>>   {
>>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>>> -    struct ttm_resource_manager *man;
>>>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>> -    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
>>>> +    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
>>>>   }
>>>>     static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>>>> @@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct 
>>>> ttm_resource_manager *man,
>>>>   /**
>>>>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>>>>    *
>>>> - * @man: TTM memory type manager
>>>> + * @adev: amdgpu_device pointer
>>>>    *
>>>>    * Return how many bytes are used in the GTT domain
>>>>    */
>>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
>>>>   {
>>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>> -    s64 result = man->size - atomic64_read(&mgr->available);
>>>> +    struct ttm_resource_manager *man;
>>>> +    struct amdgpu_gtt_mgr *mgr;
>>>> +    s64 result;
>>>> +
>>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>> +    mgr = to_gtt_mgr(man);
>>>> +    result = man->size - atomic64_read(&mgr->available);
>>>>         return (result > 0 ? result : 0) * PAGE_SIZE;
>>>>   }
>>>> @@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct 
>>>> ttm_resource_manager *man)
>>>>   /**
>>>>    * amdgpu_gtt_mgr_recover - re-init gart
>>>>    *
>>>> - * @man: TTM memory type manager
>>>> + * @adev: amdgpu_device pointer
>>>>    *
>>>>    * Re-init the gart for each known BO in the GTT.
>>>>    */
>>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
>>>>   {
>>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>> -    struct amdgpu_device *adev;
>>>> +    struct ttm_resource_manager *man;
>>>> +    struct amdgpu_gtt_mgr *mgr;
>>>>       struct amdgpu_gtt_node *node;
>>>>       struct drm_mm_node *mm_node;
>>>>       int r = 0;
>>>>   -    adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>> +    mgr = to_gtt_mgr(man);
>>>>       spin_lock(&mgr->lock);
>>>>       drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>>           node = container_of(mm_node, typeof(*node), 
>>>> base.mm_nodes[0]);
>>>> @@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>>> ttm_resource_manager *man,
>>>>                    struct drm_printer *printer)
>>>>   {
>>>>       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>>>> mman.gtt_mgr);
>>>>         spin_lock(&mgr->lock);
>>>>       drm_mm_print(&mgr->mm, printer);
>>>> @@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>>> ttm_resource_manager *man,
>>>>         drm_printf(printer, "man size:%llu pages, gtt 
>>>> available:%lld pages, usage:%lluMB\n",
>>>>              man->size, (u64)atomic64_read(&mgr->available),
>>>> -           amdgpu_gtt_mgr_usage(man) >> 20);
>>>> +           amdgpu_gtt_mgr_usage(adev) >> 20);
>>>>   }
>>>>     static const struct ttm_resource_manager_func 
>>>> amdgpu_gtt_mgr_func = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index d2955ea4a62b..b9b38f70e416 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>> void *data, struct drm_file *filp)
>>>>           ui64 = 
>>>> amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, 
>>>> TTM_PL_VRAM));
>>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT 
>>>> : 0;
>>>>       case AMDGPU_INFO_GTT_USAGE:
>>>> -        ui64 = 
>>>> amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>>>> +        ui64 = amdgpu_gtt_mgr_usage(adev);
>>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT 
>>>> : 0;
>>>>       case AMDGPU_INFO_GDS_CONFIG: {
>>>>           struct drm_amdgpu_info_gds gds_info;
>>>> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>> void *data, struct drm_file *filp)
>>>>           mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>>>>               atomic64_read(&adev->gart_pin_size);
>>>>           mem.gtt.heap_usage =
>>>> -            amdgpu_gtt_mgr_usage(gtt_man);
>>>> +            amdgpu_gtt_mgr_usage(adev);
>>>>           mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>>>>             return copy_to_user(out, &mem,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 91a087f9dc7c..6e337cacef51 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>>> *adev);
>>>>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
>>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
>>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
>>>>     uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager 
>>>> *man);
>>>


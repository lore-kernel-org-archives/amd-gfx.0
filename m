Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6349C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20FD613B2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20FD613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E65E6E0D1;
	Tue, 22 Jun 2021 10:30:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CF66E086
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 10:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2vBqNdLYYgl5cxNGYbJPiWL7SDMrHk0zcupkhYFJBD1KspEUwbVCqDF64qVBCnbPcPPr1687CLUjRMYV+6IITiz65E1gFKIKqMsIjJJN6Cs1KAwLejWFv6sOooaBbL5G7ZDVcWhlkQbnWoTACqgvy8/KgZ5s1GXT5tK6ZvYc8ac3JQPyyxYEscQl6eWMgU8kl+1/JqEPsmEfxb1X8wP87nykpS94WfeaHzWpN29zc7dFxkXiO8EbM/wi4RMYPTH7c0DZZPIW4KAzSEGmZlmVgkOMQdGYWE36RsFeE2hM0cE1KQVSA5tiRcNE4t3bseae52Ed51Jybxa/Wm0xQ1mPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHt4/VEBxbhD6xKmIMISk9MAOW3hCPK1BzfYiR3N8no=;
 b=gTtcSENZPL5seCH+UgJKfAB31F7iy0dma6A2m6CT++BJkKQeCehuB5+U1n8JBFU0xlZyFE4RiwOSuS5U6skCSdJZ+YfyokyWoet6E/AKGIFY9PyDd7pPucg01/qCIl9/8AmmnBtQsvnk4wI7HQgIS6yX3jksBxhpk2xRroVDo2ynCRNOW2m2vihzsjg2SZK3UKQWtm7Q3geqzR1EZ69zVCkz3xTUzFxz4YdO1SnRaoAFmilCD4xPLv1KIpGgeVX+5Pyk+Uge63Xy2Z5udKPwVF0Nl7WBMnQS2wasIjfC8yGfKLZdg4fnhgTb5b/RLXc0UPip22eA19veIwGY6Wvzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHt4/VEBxbhD6xKmIMISk9MAOW3hCPK1BzfYiR3N8no=;
 b=fqPvfX6Y0eUH/2Qum9UFBxE4BKxvU/wem43RKBDc7W52Lc9eNj+wZKT1ezPLL2s1uKYdS75tvIkGhY39XFgcbUR8WJ01VWZ60DGJ7ADWMXWXnmc++h4z+ecC5rb+Xoem3cXtjKdrKwYJu2/Z+wmzMwkBP4FvzjxfLZtZE+Tqj4Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 10:30:10 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:30:10 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210622065711.4589-1-nirmoy.das@amd.com>
 <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
 <5ad4ce29-2a7c-efc2-1541-4e204064f045@amd.com>
 <9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com>
Date: Tue, 22 Jun 2021 12:30:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
X-ClientProxiedBy: PR0P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::34) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
 (2003:c5:8f26:2100:2c2d:c190:70a6:56ff) by
 PR0P264CA0166.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 10:30:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4d409d-aebc-4312-2314-08d93568b60d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5517EFC4C8CDA5A71AAD07EF8B099@DM6PR12MB5517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3YQGwqnzK8tAeeh+rzdpW85QhC18WWfVL8QdN0Ya/QIdBwy45X0YTxIMgAldlDrgsBaXZPyYNXfnO4s6rI/OhbFU3L4509msuin8Ji8BzYU/+utVW9VNxaCoR9BuAnh9HQiqzrvEQS2NDQWwJZT5Hg5U+BKMrBXRefKX/71ZeEztLBzue/AmaAMX5Q1tdoTkOzIjUvmwyyQ5GCU3LCr1pXzpAzVKWawMCaFNX9mAA5/uiOXYFAo7KsGQrxU7/pVDWNt5fWMOmMC9eHz4ajtP3Vhw5ftaov/iNwfPPOlrc+PHCSMZuhBLHrszWZdFBz5dGPTZQyCRIiuDBI9e2wZNOxZXFGJqcdZzLJnNlK9b5EkDJoVIzTxoO+2llSY1QeBaVlvD9x5f3xNmtEYgqMa1cWNVUvSoOyadS5xY5Fa4esxRhOuhbtRL64gpiVlV/fCLq3iaMJU6qQiGYt0swl5B6sXcWM+fApGZHInC+eSScNGUgZPAIP2f7mWhd2tcCHyNyfE9fD6k6rJYOyRYdPwzY8sbTZ7jRTsYcMDsNt4lD/gx6k1zHjYOOhlqji/bVR0FXkxMwXiVWS0x6/4arbh2GvXNaTobJ5dgMh7a+nyRTx/QqKSrWrkN5YZW7uJ5evdVz8l+bBJ6c8WzaLBOG2fdrijNj7nVTikcMttmyVApav7OFgxQBMKydL7kVYudKztd51WOI0/ll3rGf3xgDJEDHcORv477tl2IgKMBZ7eijU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39850400004)(966005)(8676002)(478600001)(36756003)(30864003)(8936002)(45080400002)(166002)(53546011)(38100700002)(316002)(86362001)(31696002)(52116002)(6486002)(31686004)(33964004)(110136005)(5660300002)(66556008)(66574015)(6666004)(16526019)(4326008)(66476007)(2616005)(66946007)(186003)(2906002)(83380400001)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zml6UFZvb0UvaWt3TmEyNW1pSXB1RG9YTFhtYnNOT2hWeDVqZVZxcm9rK3lr?=
 =?utf-8?B?Yno1ZTFzU3MvR01OdDYzMC9TbW5GWTRidXd5WFRxVUFPRVpRc0hZRFYzM1FW?=
 =?utf-8?B?dmt0VDhjcHpqZFlqb09vRVhjVlY2NTMzbmpta3pGSks0OXVLOTFPM3ZDN2tZ?=
 =?utf-8?B?emFoNWRvUURvTllWb29HWlJYZXp4OFZyRUE2RjlqdytIK1FscTI5RUVTRTlq?=
 =?utf-8?B?d1gvMFFCVXpyS0xXaW9OOU1GWGt5S01hZGFxUkxSY05vMDZlSjkrZVVLZDVU?=
 =?utf-8?B?eEZTNlpFNFQwL2krNUtZaDFZaEdYYmFSUnZwblZkQmVFVGJLaC9ZNi9OWTVX?=
 =?utf-8?B?dE1RSzZ1SmNKcjEvN1FYcEFxSjVKdHlBbVlJT0FBcmxEUmlhcnZnWElGL0Rw?=
 =?utf-8?B?TEdDZitGd1NOVm9YTW5uUkFydXJnU0phNStuVU85MzdrZENTZjdrTmpUL2Q2?=
 =?utf-8?B?Q01IVEtacis3TFE3VDlWNHI1SUh3bzhJLzFmT2ZCZmRKc0srQnNDNmJ4M0dT?=
 =?utf-8?B?dWdpR2xYaTI4bXc0bnhqMUluM09UOVNlVGF4S3NBeFZSRmlxL0k4NVlJSzFX?=
 =?utf-8?B?QnRRR29QQnliR2NsTSs3aGJFUDdkM0djamJTSW5oazU3U090NkFoVWwwS1RS?=
 =?utf-8?B?U1NqNFJZWTRSTkYzV3FYcDBaVHJSVUF6TEwxRXpPOGE4S0RWNUI5T2FEM1RJ?=
 =?utf-8?B?MVV0dlhEQ2hWTG1QSmpvNEpVTy9WdGFtbjhHenVPMmxGb1pxTEo3eU1zdUpn?=
 =?utf-8?B?blBYR3JKQnFyN1czaUZIVlRBdEUwSVB4eVpMY01ud2VIY0FLNi9Fank1SUZw?=
 =?utf-8?B?SEY3UmxVQWp3bUtxWEl4MDlVazBiNGI4WkJZeUVMTi9LdXNZZzhBNHVBZ3BR?=
 =?utf-8?B?NXlsMHpub2tVKzdLRXptRndVK0VudkMxUGVXQ2V0SjdiSFZ4MXI5UHl6R2FZ?=
 =?utf-8?B?VGNVd283U0J5cllSVCtKU3ZhMDRvNDVFTXovOU9WT2V1VjgzdmY3ZFNIQkxC?=
 =?utf-8?B?RTVLaml2ZVRGUE9KeDhJSUtUNUNpeU1qQWc5bnBmOE90NFNGcFZOZWMwSEd1?=
 =?utf-8?B?MXltZFUzckJ4QU1yaE85MFRFNHgvUzZUNkdyUEE0aURDRVp2RFVPeVNGSWpn?=
 =?utf-8?B?cExlRG9GYTcyN3ByTEIybm1BV0ZLWExGSnhVUDZscmJYMUViTTR4Sm9uQ1ZP?=
 =?utf-8?B?ZW1haTVUU3RRc2oxQXN3Q3czcksxbzBnSFhaOHh0TW9mak8zRXE1SEdnRldl?=
 =?utf-8?B?RVFJYUxYRE15eWlZeGFpeXZjS3FyVWVMQXJXelR6bjh6MVliZ0FBWTRLOWF4?=
 =?utf-8?B?RTNqdjV5Q3JrZzd5bzJHTzZIMHY1VHUrakFtSTI5bUtJeDVBNFVNL2pHa3dD?=
 =?utf-8?B?VTRVN1FodXRxaHpaVlJYaSswdVNXZGI5LzUxMkVTQUVkMVhrMnVVdUQyeElE?=
 =?utf-8?B?bkNnQXIvZ3pPamtNSWlYcm11V1QzaElWUUtYQzIvZmx0ZVJNYWxQb1ZsVlhY?=
 =?utf-8?B?L0s0ajVybnNQaWcxM1FQbXpiNHovT0UxRkZBNk9leDNWcXRCOUsrTFpob1ll?=
 =?utf-8?B?ek02ajUwcjEwbHkyeDJoUXc3Z2YrR2xjclJPRVkydnZ2cjgzd2U0cE02UWN4?=
 =?utf-8?B?YkNUVGYrVkl1LzBLaTRWZThRZjJTSVlnU0pUeG4xbHlUODJIaUJFVFhPUm95?=
 =?utf-8?B?dzA3SGZ4Z3pWOC9hY0lPMnVzQ3JkNzg5YmNVY2QwYmFjN1FPanZkN0xMRVp0?=
 =?utf-8?B?azdyamFzaE52OHN3M3BteENkcEp0b1ZzR3Y2WWtDUUtZR1BDYmxLM3JXbFpx?=
 =?utf-8?B?MlNOWE16bTdvOGNubExWdVhXbWpsaGJrL3k1THFZaTBPZ3BmanlIbHhSdDVh?=
 =?utf-8?Q?1L9EFpQ3Fjgj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d409d-aebc-4312-2314-08d93568b60d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:30:10.0156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OMCjwjahY8JyCvnqbt3s5hZ/bQ9d8dk8smToMWBncNlSyHT/rMIZUd/CE3FYIE63K+rNOPBdrlocbJYu7GWWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
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
Cc: Felix.Kuehling@amd.com
Content-Type: multipart/mixed; boundary="===============2088908773=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2088908773==
Content-Type: multipart/alternative;
 boundary="------------95D2AAD133F1E6974FB11736"
Content-Language: en-US

--------------95D2AAD133F1E6974FB11736
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/22/2021 10:36 AM, Christian König wrote:
> Am 22.06.21 um 09:39 schrieb Das, Nirmoy:
>>
>> On 6/22/2021 9:03 AM, Christian König wrote:
>>>
>>>
>>> Am 22.06.21 um 08:57 schrieb Nirmoy Das:
>>>> Cleanup code related to vm pasid by adding helper functions.
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105 
>>>> ++++++++++++-------------
>>>>   1 file changed, 50 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 63975bda8e76..6e476b173cbb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
>>>>       struct dma_fence_cb cb;
>>>>   };
>>>>
>>>> +static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
>>>> +                 struct amdgpu_vm *vm,
>>>> +                 unsigned int pasid,
>>>> +                 unsigned int *vm_pasid)
>>>> +{
>>>> +    unsigned long flags;
>>>> +    int r;
>>>> +
>>>> +    if (!pasid)
>>>> +        return 0;
>>>> +
>>>> +    spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> +    r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
>>>> +              GFP_ATOMIC);
>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> +    if (r < 0)
>>>> +        return r;
>>>> +    if (vm_pasid)
>>>> +        *vm_pasid = pasid;
>>>> +
>>>
>>> Ok the more I read from this patch the less it makes sense.
>>>
>>> We don't allocate the passid here, we just set it up in the idr.
>>>
>>> What we could do is to replace the idr with an xarray, that would 
>>> certainly make more sense than this here.
>>
>>
>> xarray looks great, with that we don't need pasid_lock either.
>
> You still need the lock to protect against VM destruction while 
> looking things up, but you could switch to RCU for this instead.


xarray has xa_{lock|unloack}_irqsave() and adev->vm_manager.pasid_xa 
will exist till devices's lifetime. So I am thinking something like:

amdgpu_vm_pasid_insert()

{

...

xa_lock_irqsave(adev->vm_manager.pasids, flags)
r = xa_store(&adev->vm_manager.pasids, pasid, vm, GFP_ATOMIC);
xa_unlock_irqsave(adev->vm_manager.pasids, flags)

}

amdgpu_vm_pasid_remove()

{

....

xa_lock_irqsave(adev->vm_manager.pasids, flags)
xa_erase(&adev->vm_manager.pasids, pasid);
xa_unlock_irqsave(adev->vm_manager.pasids, flags)

}


xa_{lock|unloack}_irqsave() can be use while looking up vm ptr for a pasid.


Shouldn't this be enough ?


Regards,

Nirmoy

>
> Christian.
>
>>
>>
>> Thanks
>>
>> Nirmoy
>>
>>
>>>
>>> Christian.
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
>>>> +                   unsigned int pasid,
>>>> +                   unsigned int *vm_pasid)
>>>> +{
>>>> +    unsigned long flags;
>>>> +
>>>> +    if (!pasid)
>>>> +        return;
>>>> +
>>>> +    spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> +    idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> +
>>>> +    if (vm_pasid)
>>>> +        *vm_pasid = 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * vm eviction_lock can be taken in MMU notifiers. Make sure no 
>>>> reclaim-FS
>>>>    * happens while holding this lock anywhere to prevent deadlocks 
>>>> when
>>>> @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm, u32 pasid)
>>>>
>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>
>>>> -    if (pasid) {
>>>> -        unsigned long flags;
>>>> -
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>> pasid + 1,
>>>> -                  GFP_ATOMIC);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -        if (r < 0)
>>>> -            goto error_free_root;
>>>> -
>>>> -        vm->pasid = pasid;
>>>> -    }
>>>> +    if (amdgpu_vm_pasid_alloc(adev, vm, pasid, &vm->pasid))
>>>> +        goto error_free_root;
>>>>
>>>>       INIT_KFIFO(vm->faults);
>>>>
>>>> @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct 
>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>       r = amdgpu_vm_check_clean_reserved(adev, vm);
>>>>       if (r)
>>>>           goto unreserve_bo;
>>>> +    r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
>>>> +    if (r ==  -ENOSPC)
>>>> +        goto unreserve_bo;
>>>>
>>>> -    if (pasid) {
>>>> -        unsigned long flags;
>>>> -
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>> pasid + 1,
>>>> -                  GFP_ATOMIC);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -
>>>> -        if (r == -ENOSPC)
>>>> -            goto unreserve_bo;
>>>> -        r = 0;
>>>> -    }
>>>> +    r = 0;
>>>>
>>>>       /* Check if PD needs to be reinitialized and do it before
>>>>        * changing any other state, in case it fails.
>>>> @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct 
>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>       vm->is_compute_context = true;
>>>>
>>>>       if (vm->pasid) {
>>>> -        unsigned long flags;
>>>> -
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -
>>>>           /* Free the original amdgpu allocated pasid
>>>>            * Will be replaced with kfd allocated pasid
>>>>            */
>>>>           amdgpu_pasid_free(vm->pasid);
>>>> -        vm->pasid = 0;
>>>> +        amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>       }
>>>>
>>>>       /* Free the shadow bo for compute VM */
>>>> amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>>>> -
>>>>       if (pasid)
>>>>           vm->pasid = pasid;
>>>>
>>>>       goto unreserve_bo;
>>>>
>>>>   free_idr:
>>>> -    if (pasid) {
>>>> -        unsigned long flags;
>>>> +    amdgpu_vm_pasid_remove(adev, pasid, NULL);
>>>>
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -    }
>>>>   unreserve_bo:
>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>       return r;
>>>> @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct 
>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>    */
>>>>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm)
>>>>   {
>>>> -    if (vm->pasid) {
>>>> -        unsigned long flags;
>>>> -
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -    }
>>>> -    vm->pasid = 0;
>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>       vm->is_compute_context = false;
>>>>   }
>>>>
>>>> @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm)
>>>>
>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>       amdgpu_bo_reserve(root, true);
>>>> -    if (vm->pasid) {
>>>> -        unsigned long flags;
>>>> -
>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>> -        vm->pasid = 0;
>>>> -    }
>>>> -
>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>       dma_fence_put(vm->last_unlocked);
>>>>
>>>> -- 
>>>> 2.32.0
>>>>
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;reserved=0 
>>
>

--------------95D2AAD133F1E6974FB11736
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/22/2021 10:36 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com">Am
      22.06.21 um 09:39 schrieb Das, Nirmoy:
      <br>
      <blockquote type="cite">
        <br>
        On 6/22/2021 9:03 AM, Christian König wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          Am 22.06.21 um 08:57 schrieb Nirmoy Das:
          <br>
          <blockquote type="cite">Cleanup code related to vm pasid by
            adding helper functions.
            <br>
            <br>
            Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105
            ++++++++++++-------------
            <br>
            &nbsp; 1 file changed, 50 insertions(+), 55 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index 63975bda8e76..6e476b173cbb 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb cb;
            <br>
            &nbsp; };
            <br>
            <br>
            +static int amdgpu_vm_pasid_alloc(struct amdgpu_device
            *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *vm_pasid)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            +&nbsp;&nbsp;&nbsp; int r;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!pasid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp; r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr, vm,
            pasid, pasid + 1,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);
            <br>
            +
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp; if (vm_pasid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vm_pasid = pasid;
            <br>
            +
            <br>
          </blockquote>
          <br>
          Ok the more I read from this patch the less it makes sense.
          <br>
          <br>
          We don't allocate the passid here, we just set it up in the
          idr.
          <br>
          <br>
          What we could do is to replace the idr with an xarray, that
          would certainly make more sense than this here.
          <br>
        </blockquote>
        <br>
        <br>
        xarray looks great, with that we don't need pasid_lock either.
        <br>
      </blockquote>
      <br>
      You still need the lock to protect against VM destruction while
      looking things up, but you could switch to RCU for this instead.
      <br>
    </blockquote>
    <p><br>
    </p>
    <font face="Helvetica, Arial, sans-serif">xarray has <span style="color: rgb(0, 0, 0); font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">xa_{lock|unloack}_irqsave()
        and </span><span style="color: rgb(0, 0, 0); font-size: 16px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; text-align: start; text-indent: 0px; text-transform:
        none; white-space: normal; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(252, 252,
        252); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">adev-&gt;vm_manager.pasid_xa will
        exist till devices's lifetime. So I am thinking something like:<br>
      </span><br>
    </font>
    <p><font face="Helvetica, Arial, sans-serif">amdgpu_vm_pasid_insert()
        <br>
      </font></p>
    <p><font face="Helvetica, Arial, sans-serif">{</font></p>
    <p><font face="Helvetica, Arial, sans-serif">...<br>
      </font></p>
    <font face="Helvetica, Arial, sans-serif"><span style="color: rgb(0,
        0, 0); font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"> <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">xa_lock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">adev-&gt;vm_manager.pasids, flags)</span></span><br>
      <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; text-align:
        start; text-indent: 0px; text-transform: none; white-space:
        normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">r =
          xa_store(&amp;adev-&gt;vm_manager.pasids, pasid, vm,
          GFP_ATOMIC);</span></span><br>
      <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; text-align:
        start; text-indent: 0px; text-transform: none; white-space:
        normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"> <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"></span></span></span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">xa_unlock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
              flags)</span></span></span></span></font>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"></span>}</font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">amdgpu_vm_pasid_remove()</span></span></span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">{</span></span></span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">....<br>
            </span></span></span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">xa_lock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
              flags)</span></span><br>
          <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">xa_erase(&amp;adev-&gt;vm_manager.pasids,
              pasid);</span></span><br>
          <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"> <span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"></span></span></span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">xa_unlock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
                  flags)</span></span></span></span>
        </span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">}</span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><br>
        <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
          normal; font-variant-ligatures: normal; font-variant-caps:
          normal; font-weight: 400; letter-spacing: normal; text-align:
          start; text-indent: 0px; text-transform: none; white-space:
          normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"> <span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">xa_{lock|unloack}_irqsave()
            can be use while looking up vm ptr for a pasid.</span></span></font></p>
    <p><font face="Helvetica, Arial, sans-serif"><span style="color:
          rgb(0, 0, 0); font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(252, 252, 252);
          text-decoration-thickness: initial; text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"><span style="color: rgb(0, 0, 0);
            font-size: 16px; font-style: normal; font-variant-ligatures:
            normal; font-variant-caps: normal; font-weight: 400;
            letter-spacing: normal; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; word-spacing:
            0px; -webkit-text-stroke-width: 0px; background-color:
            rgb(252, 252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><br>
          </span> </span></font></p>
    <font face="Helvetica, Arial, sans-serif">
    </font>
    <p><font face="Helvetica, Arial, sans-serif">Shouldn't this be
        enough ?</font></p>
    <p><font face="Helvetica, Arial, sans-serif"><br>
      </font></p>
    <p><font face="Helvetica, Arial, sans-serif">Regards,</font></p>
    <p><font face="Helvetica, Arial, sans-serif">Nirmoy</font><br>
    </p>
    <blockquote type="cite" cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com">
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <br>
        Thanks
        <br>
        <br>
        Nirmoy
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +}
            <br>
            +
            <br>
            +static void amdgpu_vm_pasid_remove(struct amdgpu_device
            *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *vm_pasid)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!pasid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            +&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr, pasid);
            <br>
            +
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (vm_pasid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vm_pasid = 0;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; /*
            <br>
            &nbsp;&nbsp; * vm eviction_lock can be taken in MMU notifiers. Make
            sure no reclaim-FS
            <br>
            &nbsp;&nbsp; * happens while holding this lock anywhere to prevent
            deadlocks when
            <br>
            @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct
            amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp; if (pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            -
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr,
            vm, pasid, pasid + 1,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = pasid;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; if (amdgpu_vm_pasid_alloc(adev, vm, pasid,
            &amp;vm-&gt;pasid))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);
            <br>
            <br>
            @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_check_clean_reserved(adev, vm);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
            <br>
            +&nbsp;&nbsp;&nbsp; if (r ==&nbsp; -ENOSPC)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp; if (pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            -
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr,
            vm, pasid, pasid + 1,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -ENOSPC)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; r = 0;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if PD needs to be reinitialized and do it
            before
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * changing any other state, in case it fails.
            <br>
            @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_compute_context = true;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            -
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
            vm-&gt;pasid);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Free the original amdgpu allocated pasid
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Will be replaced with kfd allocated pasid
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pasid_free(vm-&gt;pasid);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
            &amp;vm-&gt;pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Free the shadow bo for compute VM */
            <br>
amdgpu_bo_unref(&amp;to_amdgpu_bo_vm(vm-&gt;root.bo)-&gt;shadow);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pasid)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = pasid;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo;
            <br>
            <br>
            &nbsp; free_idr:
            <br>
            -&nbsp;&nbsp;&nbsp; if (pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, pasid, NULL);
            <br>
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
            pasid);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; unreserve_bo:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp; */
            <br>
            &nbsp; void amdgpu_vm_release_compute(struct amdgpu_device *adev,
            struct amdgpu_vm *vm)
            <br>
            &nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            -
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
            vm-&gt;pasid);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            -&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0;
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
            &amp;vm-&gt;pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_compute_context = false;
            <br>
            &nbsp; }
            <br>
            <br>
            @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct
            amdgpu_device *adev, struct amdgpu_vm *vm)
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
            <br>
            -&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;
            <br>
            -
            <br>
            - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
            vm-&gt;pasid);
            <br>
            -
            spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
            flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            -
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
            &amp;vm-&gt;pasid);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_wait(vm-&gt;last_unlocked, false);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_unlocked);
            <br>
            <br>
            --&nbsp;<br>
            2.32.0
            <br>
            <br>
          </blockquote>
          <br>
        </blockquote>
        _______________________________________________
        <br>
        amd-gfx mailing list
        <br>
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <br>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;amp;reserved=0</a>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------95D2AAD133F1E6974FB11736--

--===============2088908773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2088908773==--

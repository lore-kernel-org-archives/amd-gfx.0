Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B856AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 09:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DCB10E1FA;
	Mon,  8 Jan 2024 09:24:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE9210E1FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 09:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQs2+YyTzVwqLANPWrszh+HLlc9kjuIf8xqn7wNIKil4pulUPqjh6mIiGzvUnCvdXCuGj3C38oxil7i/RuW/B2Eds5b6xzDmoJ+KhSqmZ5sQewRTwIWimM1HOAOLZxs7GTKpU7OCK8SIwCVRBXiA8582Zy+yLIC0UOPraiVn6xSuKv6l/pjunxClMFdCKtPzS73Pogyn8cW+lEoMxqRg0Zy959nypzzPTo4UqnSl8as9BhF3BheEMS4U/YGpcaRAjKDdYYUd8XCJOyYLXyBCozJOCiHZnYILmA7Eky5kBYFiS4tPs+abMZV2EW69VZmkApLNTK95DVAQEZ22kHuh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCX7pvOxapPLYGYGKjD/IK3SpYGOfuhg3jhapVpAcuI=;
 b=UJ6geQuCSNf5O7lEU8MscO+O1/sUwuirY0LqgcosigmqhRacJfkne3eKTbn5fjFpXmX7cFrRzvDC+nNH2ghnwoOao6ahuYo9B8LHEP0EKRLtjvzhYm1OWGtQgFg7wHZFTxx0X5WjTszbL03bt8QV0hxTAzSCKRv7caEwEIBK7i/hHND0D9APCN5B4oDVkBYl9epmtKdxbxRXChM5g4dw3QNUesk7W7L0NulwRdrnGp/MdI2fiKX4AUdm0AfkVeIOLC/zQ7598oTX/FD91d4rGEPHjXzCV8rUQCBMOhlX4C4GOeWuTWK954Xvz6FuZEYCbP49hMeJY5hhFTzKH3dqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCX7pvOxapPLYGYGKjD/IK3SpYGOfuhg3jhapVpAcuI=;
 b=e/lUPguKVpi4CGkH4aoI6hSqpWLgXjoFnjppmZQHchxrFXalmSDzcmUh334oVS9afQlsvPIbd8PvSeEmnJS/Ay/ylh6S1NS6aPDYoKCJdagt7ZB1EbjWuUez+RtJd51FFF8D6s6wY3g0JgrFnwKWr9hLCSP3wAu/ksYb/mDm+6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Mon, 8 Jan 2024 09:24:44 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 09:24:44 +0000
Message-ID: <3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com>
Date: Mon, 8 Jan 2024 17:24:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
 <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0159.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca9dbaf-903d-4cee-686f-08dc102ba633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWasmebv2gZGMX6AfwcD9U0V0mqESvMckQDWNzKh7Zw2xHFu/7E/7RQ1TYiK2yujXMl5QniMtHfwNmYAihZFAOBXZXMz4O0/9U37vFp4Ob/gg1RnB6oqDckONllMqKcAN4MMWyFybEkcnvgbF4zm5pr2ZRMz99WAHF8hRAtdVQ4h+LzwKh8gdUN9/ajQ/2OAx4eti0TbMphoFQwvcOczdJGqab/SDsqO/lfIrbZ3iZy0MZjgNnU0jc4k8OoKvdLoGXzrPZn8C30yOjpxejp/P1bLCLF6cOJ6FTjYY4ZGbf2g52Z2kBjUY79E+pqZsJfN/OT3GsyR9pFdIz7LyZJLyt0aHxdG6weg/njuIUYQts9AQCSUpgyBqtP0m79WdnBrAFteUvyxsmoOevCglxb2dNDpQ4b9tbkgiBio2Rt+3Zo2v9rHeWEWdqOuxSdaqv18upTN34tJjLwWfdYPjX9X6DNKpbqNg49GxTTTacOobfcWLMBis19TbnAg4B1UkKt1tvwAfvCS5ANdr66GNZfbBXok5KoIlf41RsDs5nT80X9qMwCFe6TZhWxG1dNsOpTlRYo44dgF+xhGeDDaD2OTc6VQc4uTfCuYu9mjTl1eTk6B8igLS97bmqe1SrQFXPgv3nAejQciliAfWHpvu1CeEqlO9IDaOfsZQB+4zoI2NMJfwuflIOlJ+0Q0ToamNZM5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(6486002)(53546011)(26005)(2616005)(478600001)(6506007)(6512007)(6666004)(83380400001)(66574015)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(4326008)(316002)(110136005)(8936002)(8676002)(38100700002)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxKZGlGU1BiaE50ZUE5TWcwR0FKM0RJOU50Z0MyeUczanhTY2RCWnlGTjhm?=
 =?utf-8?B?ZkZuc1lRYyt3K0V0dmFVaENZYndsbEsxSVc5Ym8rdGRxTnBndjR5L1RhckJO?=
 =?utf-8?B?QjNBYzYrcm82ZWgzaW92S1gxaEpFZURIbTdDWWhpK0hvZjVWRmtWdzN4Uy95?=
 =?utf-8?B?SEFKV0xSTXFURDQ3ZVdJVXhGNllva1hlV3RDYlZSM255Zk1BdWdzYjhEVFIx?=
 =?utf-8?B?cmNvbkNzN2NERmNuUnlNSjVadlNmYmd6VmZrTkZEREs4MmFOUGVVMEFDbmZV?=
 =?utf-8?B?bjQ1SVUzRnFtdzZCeEJyYnk2MVNld21La01QOExBWjV1eTk3d2toaWJJa2U2?=
 =?utf-8?B?R05hRVdTcHRUbWFYZ0NSM2ZrWm9Bc0lJQlQxSWZWcHVBeWJFZ0U0QXEyS1VO?=
 =?utf-8?B?U0N2SzBQZ214RWd4S1ZhUk5jZGVvNnJPNzVhRWxBR3UwSTkyejdjTmNlcnF3?=
 =?utf-8?B?ZGNOM1MvdEt2TUNzU0RCVEdoelBNTDVLakJXd05MTmxtSVlscG92YmNGbFRm?=
 =?utf-8?B?OW9PUU41ZTBSc3pmeEhzVzRVTzdtU2Rjamh5WlFZTkwrbVJUT1Vndms1ckth?=
 =?utf-8?B?djJlQmxYcjRhRmdLeUFobVdhOEhQVnJ0blhrK3QxTVdXZXJpNDlUMTVMVzBV?=
 =?utf-8?B?aG5FNjJReTNJMEgxVFA1NDJDTXRhU09VU1lxZjB1b3B5Zm9WVXlTK3IyNGIv?=
 =?utf-8?B?dzl6RUJhZm9FRFhEd2tPS2YyQmVsbm5QSHBXamhMYlZyeGRpYjF1ejN4UkVt?=
 =?utf-8?B?UnF2aWZxQ2FnUUVvRE44dWg1YjBvcG5SS1dvUUYyai9WQkxxVEsrSitoUlE4?=
 =?utf-8?B?cDZ5ckpmeExETWprVkFwakluVE4yVDRJeGtEdkVJL0JubThPL0RMeUpIcE5p?=
 =?utf-8?B?eXE3TDlteVRxR3BIMUxXS3BaM2pqSUxTQnBjbXJwenlGM3FldDRVaW1rclZS?=
 =?utf-8?B?WVdaMFJBZWEvUkFCSmdzcHgvSDd0ZHlab0FmWk9YaEl6bFB0ZFlOY2lobm04?=
 =?utf-8?B?aW1tRHVISWNFUTFaeHkrMVZpajFZTVREblR2eE9pcVE3SGZsd29lb3VOcmF1?=
 =?utf-8?B?QklZempwcmVuNHZETHVTTnpvcXIyR1VOQ21IZjhNVVowTGt0d2ZQYkdjbmln?=
 =?utf-8?B?N1RlRjRYbUIxdStiSUxnNjFBTVF6SE9NU0JzanZTWWxXS2NuWnJqZzVNMkR4?=
 =?utf-8?B?MXB5M2tSeXdoUGppNWFURXh4ZGFRMEdxWmZ3MHl6TEVodWllNjFSdGRpVWR1?=
 =?utf-8?B?aTlkRWx5eVZCNnZtc21VMHVTTUdIcTZHQ204MGd4WUFMZnBnaVJaVXU4aWRt?=
 =?utf-8?B?QXN4WXJ4N0F2RHhDTlNWc2ZzNHYveTJzRjRuc3ZQMVpHU1JhMEpvbFhDTTg0?=
 =?utf-8?B?d0hDUUZhNWtkOS9Gem5TTUZFTTY5Y2ZTT21SdzV2WTZPRjNTRjBQNzV2Z3Fp?=
 =?utf-8?B?d1lNZ1dOUHNTc2FsN2lQaDM4QXpMQUh6V3pXV0FQSG85RWRPYk9oQzRxYUJN?=
 =?utf-8?B?QWlQeVRCR001a2gxTFl5ZC9HN0JGRVFoeTlib2ZEbFNPKzlrTm93a3haSEZl?=
 =?utf-8?B?VmVGMTRtV0NGYUdVM0tGZEJQVklYbFZVWWlRMlBEVFMzR1hSdEVVbjFjZ0d4?=
 =?utf-8?B?SHBlWVhmV05JMWFzbi9ocFoxdDhVNGlhT0lOeklKeEtCYlBqcFMxc0tQR01h?=
 =?utf-8?B?M05LZjEyN2tyWTEzeXZheFQvdThOQmUwSjNmVTJSS29KN2JaZjV2blIxcE5z?=
 =?utf-8?B?TnpCOTBZb3cxS2hCK2xzMXF6MnV4QnQ3aWtEQll6SStaWk0zZ1BHVDNoOWs1?=
 =?utf-8?B?RDFQVjdmSDhTWUlWRFV4ai9XQmsyc29rSkc1MkNsUXRHb002dFpLTElWSDc5?=
 =?utf-8?B?cGJmdENObXB4TzZIeElubEdVK3RHelBYd1dkTVhDSWhHdCtSbXVKTFNNU05i?=
 =?utf-8?B?T3c0WjRGMkppNjF0MEZIaEFGZmljRHNoOGo2MjZqMGhaek80VXM4UVJVK2do?=
 =?utf-8?B?UjYwT3Z5aytsR2NkbzRtTDUyZ3ZnQlc3blN1QUJKUmpyMmtCZFRJdWF6TzBa?=
 =?utf-8?B?Q0E0d0JiN3N0MnlLaWhMeThyYzdiMStkSnVhR2pOMFJBTTB4MGk0andRdjBS?=
 =?utf-8?Q?D2vKY8dsiUlHOo7emVQUegDVe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca9dbaf-903d-4cee-686f-08dc102ba633
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 09:24:44.0371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izffn0MYNlQXaCEPrXksEIQ7QeD5voNNOf+mrhd4wHNiwMrrl7NF3JsON+y2RYmu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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
Cc: Alexander.Deucher@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 1/5/2024 9:39 PM, Christian König wrote:
> Am 21.12.23 um 02:58 schrieb Ma, Jun:
>> Hi Christian,
>>
>>
>> On 12/20/2023 10:10 PM, Christian König wrote:
>>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>>> Print a warnning message if the system can't access
>>>> the resize bar register when using large bar.
>>> Well pretty clear NAK, we have embedded use cases where this would
>>> trigger an incorrect warning.
>>>
>>> What should that be good for in the first place?
>>>
>> Some customer platforms do not enable mmconfig for various reasons, such as
>> bios bug, and therefore cannot access the GPU extend configuration
>> space through mmio.
>>
>> Therefore, when the system enters the d3cold state and resumes,
>> the amdgpu driver fails to resume because the extend configuration
>> space registers of GPU can't be restored. At this point, Usually we
>> only see some failure dmesg log printed by amdgpu driver, it is
>> difficult to find the root cause.
>>
>> So I thought it would be helpful to print some warning messages at
>> the beginning to identify problems quickly.
> 
> Interesting bug, but we can't do this here. We have a couple of devices 
> where the REBAR cap isn't enabled for some reason (or not correctly 
> enabled).
> 
> In this case this would print a warning even when there isn't anything 
> wrong.
> 
> What we could potentially do is to check for the MSI extension, that 
> should always be there if I'm not completely mistaken.
> 
Do you mean MSI-X? There are no extended capability registers related with
MSI or MSI-x.

How about reading the 0x100 register in the extended config space since the
extended capabilities always start from the offset 0x100 according the pcie
spec.

> But how does this hardware platform even works without the extended mmio 
> space? I mean we can't even enable/disable MSI in that configuration if 
> I'm not completely mistaken.

I think the MSI related configuration registers are in the legacy
configuration space. So the system don't need to use mmio to access these
registers.

Regards,
Ma Jun

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Ma Jun
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 4b694696930e..e7aedb4bd66e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>>    		__clear_bit(wb, adev->wb.used);
>>>>    }
>>>>    
>>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>>> +{
>>>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>>     *
>>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>>    
>>>>    	/* skip if the bios has already enabled large BAR */
>>>>    	if (adev->gmc.real_vram_size &&
>>>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>>> +		amdgpu_find_rb_register(adev);
>>>>    		return 0;
>>>> +	}
>>>>    
>>>>    	/* Check if the root BUS has 64bit memory resources */
>>>>    	root = adev->pdev->bus;
> 

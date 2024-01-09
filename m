Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BACEC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 09:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50C510E6F8;
	Tue,  9 Jan 2024 09:44:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF23610E407
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 09:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayQXvMOQcAgOssUzKexamAJeO3SVLNEPD2WJlWAImBMGDA6a9WQd5eRpzlexoQCXqywN9eGb4HfW5PvhVLmKtzgKjMY50xrV5Q4sZDAptjl25tlj1UMsFnkKb6M6WeroswG6IAksxVm04AndZN8Okc+KSs8A6//F4v3zO7R4azV6Q25/UZJ0vUUR3mMIn/vsXqd59ZewmVtjz5qvY3ShtTJSCa9rUhlYUFknwWexn7xuigFp/EP2mo7YOp0ng1QZnTi69sQA8lBhQxfZ6MLbTxm9tq7SCQc4Yh8qFpg95P/sEyUq+PrPYcnEQ9qp3J+0VFjscJPs4Z4eaOX02eriBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs0ktBjbRNfx6hPJ97/T53XUb0xZ9OMhAcDl8jdKmk0=;
 b=QNhSwnIQh3Sv7VtLFFf96RDesUqf3iJRiG7i76eDQ6uRiJFPVX3CI+vZ8+5X5ipNeJin8ei9J1CUGAgh595bdWcDM5rbkEm5DlCTRRrN7ib5bFLNYhUelINvftU7SIxB56gYDdWRuBytvGGzvrA0AnN4e76F8gCvC7sFrXdK7Rsx9nvwr+6MUom1x3J4vxTewFngdGfowF98ATuBVxq+YqCMiZEbWnQfFjWQqABLKOXYv2dl49d/2CYDalGDrWva8R/BRN7jkfMAo5HNo9gF2Wc37zuRHKoRhJUNLfeNlQ6IuSiFyW1aPDwyOTMogWp91lmNvrQvoRyxxpYCo04fSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs0ktBjbRNfx6hPJ97/T53XUb0xZ9OMhAcDl8jdKmk0=;
 b=2VVdE35uwyqwGQB7t3TLfFgh1NMKhX3V0Sl5l1pfgLKV8EUP/CvNaMJRtOsvAo23CX7ogqkWxKQpr4thPSthOFgM7wKUBOHIK6SgGPdvMgojV5Kq9YWtkR1yjfRAiv9s9orhDV5Myj2hdYoxQpQO45Jz+mYUTuy5LKqUAkELQ7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 09:44:20 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 09:44:20 +0000
Message-ID: <988a72ad-9541-4061-bef6-4c2ed8092f69@amd.com>
Date: Tue, 9 Jan 2024 17:44:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
 <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
 <3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com>
 <8f5910f7-f19f-409d-871e-97ff3bad5a43@gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <8f5910f7-f19f-409d-871e-97ff3bad5a43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 366ba6c8-bc65-48e2-ea21-08dc10f78d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEoepqV0U8650c2SoQQ+PQBw7yU6nyn5FjixmG5nDkMCHl8QbndwwzOykH6Lg8XYnfpqewK+parqJTFyzxKzP7myK8s+JBbph1WdbiQvQRmWwbCZ/wUNc98jIVj+tr9O+jn+Q//poT7Ca2Y+gwCPokFdklyh/UG26KaC9bJfW4Y/K9b+T3zXFHr1lLtz1AnBMUOP8Oj+uUVrH7AaUYVCA/v7/QZc+rcfxNywnzyfn/0rK18WRgNtV+52rb0B3/mI4U/HRyiVM9lCDh5sFDqqimq7jfOQFsDpQf/xxOkxAqFc2bNuBZ43f88KXySfDAdXWqmYp0K44rDRYH685Tfsm0qB+T78+aIrNyvPJZowuiw61thdMY7hMdX3p0p5s9a7tQCJQK7v/Nl5W+QBKmYgssLsfetVwSUTq6LEeOjNiQysbqWPsTQCMrD2WewuY/TkqeDsmEF3WMPN4jcqlkXVvPcICzrS4G+JUNs7co8jk3kpoh5p+0G/DT7RcgHjMEV+gqbuMt/IX0Hu2B7vaX9L6huW2gkl0gX/Itei0BWw8AxY85xbP5KNdv6JwK9kBBS2oJRFpWm286OBp9ZTWF8z4n6TC+7qxClunkZBa+1AxF475+saLJjcyZZsVy0PVuUikWC2Nl7BDJ8es8+JbL+6TDmljAATSB/bLvnhoG+PJ144Z47HpePYyIFaRD6mqpbI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(2616005)(6666004)(6512007)(53546011)(6486002)(478600001)(6506007)(83380400001)(316002)(66574015)(2906002)(5660300002)(41300700001)(66476007)(66556008)(8676002)(110136005)(4326008)(8936002)(66946007)(38100700002)(36756003)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW0vVUxRVWEra2FZcWFYbGd5U1NWZG5YaXFTT1hXTUVBa05EOThveFhvMVpT?=
 =?utf-8?B?TFVaNlVSczZvN3J6TlRWRmVDNXhuNlRXMitKWFRZL0FRSVN0SFZOTTc3VE1v?=
 =?utf-8?B?T01pMmFVdTd6U0lpL1VNcnA5eWR4TjVQdVpHOFAzenZQNkVycGdud3hvNmYr?=
 =?utf-8?B?Y1ZJRkFuNzNLQkZaaUZGOHptSHljbFVlMlZrdDZpTkhoQTJRWGVZNkNDeVBQ?=
 =?utf-8?B?c1cyQStvMW90dGltYWZxd0FOWlFET2pORTZXQXF0ZWt3SnNUWDV1YlFiNXFh?=
 =?utf-8?B?Tk5rMiswdG9ROVJPMU9sSUFMRUcvUXVqRHBTT3RyZ1dQcE1YQ2JmMHV5WEhC?=
 =?utf-8?B?NkVjZlpGTXpKR3BUZlJpa1IxSjRsTEFlcEFvWmZUQmtZRTFxTlI2VU9sZmZE?=
 =?utf-8?B?YUcxRTVjdWZrZVpKQVRSS3diT0hrbzBhTEpBbXVuNkpTcEhjVnpUYjZaZDRi?=
 =?utf-8?B?SzZ2STBySnlBTUE3dnE1R3ZBVEQwYkF1QlA1R0NEY0VZcHB2NERiMWlxZWp3?=
 =?utf-8?B?SDNGcnh1OEJYSTA0b1pXUzA2KzUydFYzOEdMN1JkNlUyMXEzc291ZTlRcngw?=
 =?utf-8?B?cllYenV5MkhnY3NlaXNHU092RjhuK2liaVQ3TDJiRHFKeVMzR2NESlJGTTVo?=
 =?utf-8?B?Wko0dFdWK3hDTEhlQVFPcXI1TGd4bVYzd0Y5TEErTUo3VEw1Z2gzY3NHbGdx?=
 =?utf-8?B?alBXZUIzMkhWV1E0eG5JaXUwUG01eTlCTis2OXVES0JmQjI5U1YydHBBcjhh?=
 =?utf-8?B?TzQ3V2h0SGJkUS9hWWo5ajNCQU5ZNHlQMDZMb2NNRmJVc1FKRU1QaXlxNXN2?=
 =?utf-8?B?WHd2MUZuUFdscFNsZW0wTHAxKzBsVm9UNDJuUDZ1TE95dGtkaCtzMXZHZFVS?=
 =?utf-8?B?SjNibHArbjYvKzRZMm5neHNjZGNDcnRIR1c3SnpFKzM5bkhTWHlGRU1xUEtt?=
 =?utf-8?B?UmdKbUE3QUN2ZHg0bVd6aEdYRVZIeVFORm42ZGxPT21pMWQvQVQyakJ4eDlE?=
 =?utf-8?B?THVwQUU0dkNNQll4Z3NGR1hMdTMwNStnaWVLa2NINVlGKzhQTWEzQ084ZHd3?=
 =?utf-8?B?enlkNnArSXNRUS85OXNNS3dPeHc4RnVMZGlZYlU1UFJCMWtpMVFFVnZkZlNh?=
 =?utf-8?B?ZzhKZ09NVWw4NGdmWjNRWkRad3RNcW9JM0ZUNW4wVC9sKzdrSXdDdkhLQWpN?=
 =?utf-8?B?anF2ZmZzTzZTMHgxOFhnS3QzamlQVGVaN1JJQ3h0Yy9uL1M5Vzkrd201Y29T?=
 =?utf-8?B?M24yZzFkYzVkU2RLR2pqOENHeGpqY0I2WW5IMHB3WE8rWTdwTXdGUzJXckN5?=
 =?utf-8?B?QlBDRlZSSjNqVXM1bG56aTVtVUx6Sk1kTFZKMU1NYkorWXhrZGZrdFBGRDhv?=
 =?utf-8?B?VGJySTIrRDN1aUsyYUUzWWYrTXk0anJXMkpqTWphYS9KZG85bnFyTkY2dGQz?=
 =?utf-8?B?YW5ZUnJWRUFONEdkc3o1Y3VidHdYR1FQenBlcGYzUlhNWDdpWFlaSWhtZWwr?=
 =?utf-8?B?cCs1YytBZmtNekx6bWFucFV6TTdiM2Q2bFptdXR6YUpkV0lPbmJNSnpWK0cw?=
 =?utf-8?B?RFhBYzlVM2NNVTdoWjVQUUltbGFwYk9KeUIwRk9xSnl0dzlCbDFKeVpIYWJu?=
 =?utf-8?B?TExTNHRGT3hNNCtScy8wbVB0ZTJYNC8wRmlXMGdYNWdGMTRuU3I5Um9iK0pF?=
 =?utf-8?B?UDhtWFV0WGNVeGhvMnRsSUU3U0VxVzBnU2R0STVESG9xN1Iza25aQjJYd1Vz?=
 =?utf-8?B?RWZ3YnhjMU56dmxncFhNWTRrRXV1VFc1a1JFMGZ6M2RoMnEwQUJNUkh4bC9q?=
 =?utf-8?B?M2xPTmtTQmcvdkFSbTZ2Y2ZBZDRIQ2tSekc5QXNqNjZUSXdMVmFHR0VKNnVn?=
 =?utf-8?B?UWVHa01ybWd5b1N2NnNjaU5WemFGSUdYdGRwN2xrRzEvVmlBT25qdlRBTUZM?=
 =?utf-8?B?NFczSFNEby9mQWluamtyS1RUME9Zd1JpMFRXQ1EvMWNCdVJLQ1VsK29wcEV0?=
 =?utf-8?B?YUNnWXRNQkdiWW4wRkRjQnVtZlUwMnVNOHhZdFhQYS85ZW5ZSTVHMDVza0ls?=
 =?utf-8?B?K295eWVZc0QyM3FLUVNZV25YWFkxanRmdFBreHhFczNkM3Fiemluc2N5RlJV?=
 =?utf-8?Q?AfpsfaJ7HjQOQc962uo92+zDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366ba6c8-bc65-48e2-ea21-08dc10f78d74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 09:44:19.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7wMe2yKTi8/G7haMpsM1az0VGvIUesxgm/WBMqfVsIcsqDYZ5bTs0UliiX2Hgm/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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



On 1/9/2024 12:24 AM, Christian König wrote:
> Am 08.01.24 um 10:24 schrieb Ma, Jun:
>> Hi Christian,
>>
>> On 1/5/2024 9:39 PM, Christian König wrote:
>>> Am 21.12.23 um 02:58 schrieb Ma, Jun:
>>>> Hi Christian,
>>>>
>>>>
>>>> On 12/20/2023 10:10 PM, Christian König wrote:
>>>>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>>>>> Print a warnning message if the system can't access
>>>>>> the resize bar register when using large bar.
>>>>> Well pretty clear NAK, we have embedded use cases where this would
>>>>> trigger an incorrect warning.
>>>>>
>>>>> What should that be good for in the first place?
>>>>>
>>>> Some customer platforms do not enable mmconfig for various reasons, such as
>>>> bios bug, and therefore cannot access the GPU extend configuration
>>>> space through mmio.
>>>>
>>>> Therefore, when the system enters the d3cold state and resumes,
>>>> the amdgpu driver fails to resume because the extend configuration
>>>> space registers of GPU can't be restored. At this point, Usually we
>>>> only see some failure dmesg log printed by amdgpu driver, it is
>>>> difficult to find the root cause.
>>>>
>>>> So I thought it would be helpful to print some warning messages at
>>>> the beginning to identify problems quickly.
>>> Interesting bug, but we can't do this here. We have a couple of devices 
>>> where the REBAR cap isn't enabled for some reason (or not correctly 
>>> enabled).
>>>
>>> In this case this would print a warning even when there isn't anything 
>>> wrong.
>>>
>>> What we could potentially do is to check for the MSI extension, that 
>>> should always be there if I'm not completely mistaken.
>>>
>> Do you mean MSI-X? There are no extended capability registers related with
>> MSI or MSI-x.
>>
>> How about reading the 0x100 register in the extended config space since the
>> extended capabilities always start from the offset 0x100 according the pcie
>> spec.
> 
> Yeah, that should work as well. At least some extension should be there in the extended config space.
> 
Ok, I'll submit a new patch.

Regards,
Ma Jun
>>> But how does this hardware platform even works without the extended mmio 
>>> space? I mean we can't even enable/disable MSI in that configuration if 
>>> I'm not completely mistaken.
>> I think the MSI related configuration registers are in the legacy
>> configuration space. So the system don't need to use mmio to access these
>> registers.
> 
> Ah, yes that could explain it.
> 
> Thanks,
> Christian.
> 
>> Regards,
>> Ma Jun
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>> Ma Jun
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 4b694696930e..e7aedb4bd66e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>>>>    		__clear_bit(wb, adev->wb.used);
>>>>>>    }
>>>>>>    
>>>>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>>>>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>>>>>> +}
>>>>>> +
>>>>>>    /**
>>>>>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>>>>     *
>>>>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>>>>    
>>>>>>    	/* skip if the bios has already enabled large BAR */
>>>>>>    	if (adev->gmc.real_vram_size &&
>>>>>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>>>>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>>>>> +		amdgpu_find_rb_register(adev);
>>>>>>    		return 0;
>>>>>> +	}
>>>>>>    
>>>>>>    	/* Check if the root BUS has 64bit memory resources */
>>>>>>    	root = adev->pdev->bus;
> 

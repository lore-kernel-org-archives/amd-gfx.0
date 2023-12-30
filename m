Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A47C46CD4
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Dec 2023 02:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B8810E01F;
	Sat, 30 Dec 2023 02:23:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCD510E01F
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Dec 2023 02:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjfnvCYMNiUO/g1aUMZAMRBl8x8PDx/iNt1fzKbpZzqyRrWuWanOF84Iy4UnXXyytTTN48TjalEAZWAfi6RptHK41uYUkl5hsciAiQCqBRTn7WE5t8DDooz3Nxp9Nvy1XBhm7VMDoNNcW1Konhm72wDKj7HMIgDoyYTgJdtnkmq3reHdA1utTzuNXMs28Wiw/rZ+xN0CvhZ400z4ISAuIHIDY0kPOyqD6eZJsKOjQCeMZwry7YBfllndWhZMPBMhm5IlTdT02zJMSHH8zXuDpKCN44Yg9iDyB2+Hg1iZs+XYSm2elhcs91XnONlVISD+lMxb6SyknwIp5u/3rHMFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivbCphMyRqFgsFXk1vBLQT3czturleGsxj5A//eHaqs=;
 b=Kz6C8BJjh1X9cftGAa6T6fEIrwiLTektLMUg3ReAe/bPuWAhh6yQ1k81Vcg51hf1VSZJMvD0G6baGwBxrei8HpbE9QpG/uWyiTdEXLsd3CvmKdAD2dRayR0mvGNMQANvEyGGXWmKN3R0HGDHLJOqgaS37SCuA0gLkq2lt5hvKjRBoyvgefuCQJFEWa9WiUe98MpvfGruCqmbL2A/ke+JmdpK5MyrfISyPv/Mm0GLbiiW/HR+l/DWMUoyFziF1SaQxruIGAOIES/m4S9JPiJVXYetjD+XvZ4+qeUAHP4mau5JgYKHHXDMYmWhxB4rWwfxA5ztls8yzsgj2zzUatgbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivbCphMyRqFgsFXk1vBLQT3czturleGsxj5A//eHaqs=;
 b=tiF4aRnhU6i9hJYTMUpMmZIhD7VO1EpjwV/wEbpXrbUOp0GAKWs3eSepQURZ1KsRUy0xrXHkVneORSGfzxIpdI7/MR02eUPeliNF/rA52+dA0NYgmqM7w7tTB/rPHmaEe5ZLP9y2lPa3CeSDcyofm2Rc7+JQpgcJNtULSQVDD+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sat, 30 Dec
 2023 02:22:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7135.019; Sat, 30 Dec 2023
 02:22:52 +0000
Message-ID: <06c138e6-fc30-45b3-8e54-de72ea0f17d1@amd.com>
Date: Fri, 29 Dec 2023 20:22:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: d206c518-4569-41c4-f1c3-08dc08de39ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RNq4INyA20g4//Iv8NVA9dW/0/bUG+BT0U7HkXFNwQCcK0PktVCpf0fbPTNkldVWHFUR0qU48dpv6SzkB8IUI918inQCToljo8dVcsGpQacrdimx6pKfebi+YUY/Cq847i6j5/8WmzjtdoIwGgIFAEju2I6H13arkO7PtKg0PhDXuUqURhbb5m+6GZEo7uMkg+NX9ZakuthjeHZgfnhyOIFonf1l0J+Qe9eCucOI5L6bssBIsbWrsZWTojJUVvQgH4gnZL6wZxpNphrN5HzbV2Tchf+et6A3HNAtpQmfKb63KNDeKTnveDiYFw31G11h0HCa8OCt2YWIT+lyYpzcJhd3n0WNKXjJres9Ov1jRvcMZhyKscrRm5GjptyOgB2EitgLgXlvKyWfGhmhq3j+GcVuNQyMWEVjp8sa0+fdFTjhg7+OtbW+/cB4KHhDxga+DWH4EUbMSxjM9zWmZo8GSIVnb4VL7waNwKNTaJDem+cIhFa/GiTyfhOG8zJWpSwxbZcsEOdAPy48+ASsLl5Pqm3JYXdPoBdN82w8u2AESZJ6XAvl+m5N/gIQ/ZK2ADYJbewo8uFirPQ5QxO2Tz6JV/y3GlTE0t6qBN7t0ZpAESXK48aNuhXFxEazqA6mfPwWKjnb4Felk8Fvv3JYpnvWHXBPmlDS8zlRBuOVtv/KNX9Xz8z2YKPS3VTHV7Ea2i0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(8936002)(83380400001)(316002)(66476007)(110136005)(66946007)(66556008)(41300700001)(31686004)(86362001)(36756003)(31696002)(5660300002)(2906002)(44832011)(26005)(8676002)(66574015)(53546011)(6512007)(966005)(6506007)(478600001)(6486002)(2616005)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJBZ1UrZW01UzlTTkorV3h0UWxaRU81S3lSaEpRNWNCeVJnVW1BYk1MTGIv?=
 =?utf-8?B?VS9QSGttTlNzTWxTcjFvdmlQZk9kUG5mdU1vc1pwMk8rSlZXaVYyN2NqcExh?=
 =?utf-8?B?VFhqV0liUlN4b2xRS0pldGRBSVVGd3RvMGhYdnZpT0VFTWgzZGdLVHk5aGtz?=
 =?utf-8?B?RmVkM2NiVWphWWlicU1EZ3EyNmtKQWVUMkNaWk9zd1hSaXdPN1RNeFNvREIx?=
 =?utf-8?B?TlQ5bVZRK1gvM1YxNUM4S0ZTWXZUTWROMkV4NWs1ZmpGRUJyNHROcjNxQ00w?=
 =?utf-8?B?czQ2Mm9TL2J3a1dxTksvN1dJRFlkR1djajBOaTlzUG1TclQzNVcwZUtzTCty?=
 =?utf-8?B?QUc3cWFUUXNXc3NWNHcwTkZyWW10TnlOYVViL1hDTFh3KzhpVGErQ29kekVU?=
 =?utf-8?B?KzY0a3RhaCtVUmk1Z0R2L1pKMUszZ0UyTU15UXRnMjI2VjNzSWJRWDhuNWYx?=
 =?utf-8?B?TkRzLzJZWXRZN2FhL29PRFAzNENKeGNUR3kwamsybUNBdEpPajhBN3I0U3JY?=
 =?utf-8?B?RS93V2ZkdXFDV3p1bmdZTEVWTlkvMkZyVUQwQlNlWlZxMmNuaE16a2M5SWhl?=
 =?utf-8?B?ZmxrVEJHQnBmalF4cldEd011bDA1dnU5TVU5dHEyVGROV0s2eUtQZi9wTEJP?=
 =?utf-8?B?K0pzdXQvZEt2TjllNldobnU2c29nRlUyRUtudmNYSHlJL3Zybmp4NjRiaEJY?=
 =?utf-8?B?UzhpQ3ZEY1MwVW0wL3ZDWk01Tm5nR0VJN240S1lpcnVTSTdyZ2dKLzZJRVd3?=
 =?utf-8?B?TUdWQXFoMmdXRDljOHl5MmRDZG53WXkvZW4zdk1yaHYrdWZQb2U0TVNFbndo?=
 =?utf-8?B?ZHEwRlhac1E0VE1ZamVXS1Bmc2JVUEJSZkt3QzBnNTd0NGFNNVhJZW52UThs?=
 =?utf-8?B?WXdtVW1JRGVDZWFiR0pNNksra0NicjNWTHBWSmplSEV1YmxQREEvRGFIV3M2?=
 =?utf-8?B?amF4NDlxVjJPTlNIY3hvTm5WMzZ5NFZZWVdiMndadEk3L3ozZzVhdUdJS01L?=
 =?utf-8?B?Q0U5a056NlVHQ1cveHlXbkNFSUtzcVNqVnhPWXd3dFRHMnM3Tmk0MDJCb2Mv?=
 =?utf-8?B?RXVDNEduMExsN1Q2enNmeWVyOFpEZUZUTmNpVVgydUhab0JVdVZwZ3psMHh5?=
 =?utf-8?B?ZmpIY3BxYWFoQXI2SW1PNis3VGlhOGZpTmswRWx5NnRJVGVFQUlZVEtvcnVJ?=
 =?utf-8?B?Ymk4djZwSXlRMy8yUk9yRGEwYmw1Q2M4MExpengyMk1KSkgwK1puUTFYWjl3?=
 =?utf-8?B?YjBVTjNHdHhaVytFYktSLzNjbVdOdXZTbktIWG1jOGJCN0pqMGpnUExzQXNq?=
 =?utf-8?B?enFQTTI5U0pXQ01JQ0JPNExiVW9xNFNJU1c1RDhDSlFFM3krMGw2RWF6elhw?=
 =?utf-8?B?RlNIaXNNQnlLT0hZWnhxVllBOG1OdmxPVjMvYjZXaVNaYTV6WlhQeEpEck5V?=
 =?utf-8?B?aXplZHgzQ29iVE9LRUpWbEp2K3pIUDVqaHlKMk9hVWJBcFhYcHdrcERmNmhO?=
 =?utf-8?B?eis1M29zVmdQK0lkanVud2hqVXJ4K2V2OWtLMVB4ZnN4T2ZES3BYNHJ6Ymgr?=
 =?utf-8?B?NWwvZkdpbjhHRUlDdVRtNTh0dUpyWVYyd0x4cWNabnJCT2R4cmN2NXEyTzNa?=
 =?utf-8?B?MnZka3YzbDlWQ1RmelJSdWNja2pjelNnMGZZNXMzTXJKRDRiYXNndFM5S1Z1?=
 =?utf-8?B?NnlKbXlyMmRZV2pOejY2U3ZFNVViMEtoVGpoL3FUVDA3VjdlcmtjZjdFdFQ2?=
 =?utf-8?B?RmtROTFwVHVONXlPQ05kaDlhQW5kcG1UVzYvS2U1Ny9Ca25qcERBcnVzWHVy?=
 =?utf-8?B?TUQ0Z1M2Z21UVm40MTlOeVg2UHg0eXRTdlkvYi85QmxqZWdyZnVJWmVTVjdC?=
 =?utf-8?B?emovOExkMTlwQitlZ1p0a0drNnNVUXJQVWdFdzl2aUpaTmhzcWo0ajNOQlBE?=
 =?utf-8?B?NW52WXNBTk5TbFhqamdMRWxGTHZQblNkcnNxanRxVDUrZG1iR0QzNGFNVDBh?=
 =?utf-8?B?UDgrSTFueHUyeTJxYlhNK1lPNURsZUJydmJ0RysrSFdLWWRyTTBDaHVPNVFD?=
 =?utf-8?B?cm5pbHQ4elJQM2hCd1FXOXpWZ1lLc3NyUUcvdUlETDFoYnJBRHM5Mzd1a2Rk?=
 =?utf-8?Q?Bi9fCEgNmCKOkIcL1/gqr3Pc0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d206c518-4569-41c4-f1c3-08dc08de39ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 02:22:52.6847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHxDlPCXgCOYEALd52FJFLx8X0HLlOOqrNQOzsYnLm/kJbMWPEhokF9KyULRuzfx38l/vDmJfxElRl72ryuCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/20/2023 19:58, Ma, Jun wrote:
> Hi Christian,
> 
> 
> On 12/20/2023 10:10 PM, Christian König wrote:
>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>> Print a warnning message if the system can't access
>>> the resize bar register when using large bar.
>>
>> Well pretty clear NAK, we have embedded use cases where this would
>> trigger an incorrect warning.
>>
>> What should that be good for in the first place?
>>
> Some customer platforms do not enable mmconfig for various reasons, such as
> bios bug, and therefore cannot access the GPU extend configuration
> space through mmio.
> 
> Therefore, when the system enters the d3cold state and resumes,
> the amdgpu driver fails to resume because the extend configuration
> space registers of GPU can't be restored. At this point, Usually we
> only see some failure dmesg log printed by amdgpu driver, it is
> difficult to find the root cause.
> 
> So I thought it would be helpful to print some warning messages at
> the beginning to identify problems quickly.

This doesn't yet have review comments with the holidays but I think this 
is a scalable solution to that specific issue:

https://lore.kernel.org/linux-pci/20231215220343.22523-1-mario.limonciello@amd.com/

Can you try on one of these affected systems and see that it helps?

> 
> Regards,
> Ma Jun
> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 4b694696930e..e7aedb4bd66e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>    		__clear_bit(wb, adev->wb.used);
>>>    }
>>>    
>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>> +{
>>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>     *
>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>    
>>>    	/* skip if the bios has already enabled large BAR */
>>>    	if (adev->gmc.real_vram_size &&
>>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>> +		amdgpu_find_rb_register(adev);
>>>    		return 0;
>>> +	}
>>>    
>>>    	/* Check if the root BUS has 64bit memory resources */
>>>    	root = adev->pdev->bus;
>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE32C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 09:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4385610E1B4;
	Mon,  8 Jan 2024 09:25:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0E210E1B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 09:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9W+DPDPJSIJ3icIol0DH6tapKOpnGXGkvOOccZZ+0JFxOg8FuaikMLTeutRiXNoqcJpce4ijYx96rD7WvlYV78Y4P3rbQnBmwXGTUy5T5fyx2pPQjttjJrkMMiO91XSRIde5TwPw/kGm5p6RD4epH5O+Qq6kY7XJotKbnLDRnMtH//VMsv8dQV0GgKlahIvp5vpqKFhoF+JieaYgJiJeJFoBxmxmiKYi1NLmigGxrTPiFvmIx7zHYMNwk0qfuywTLvVFCEsXRm8PNx++vTBjXZw/HSba0r4MvNYEkOXfMZd4DtFA/bYZi1aPrTvr5y/aOeWEZJyZghvvtU5yfzl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osuwplpN0HyMSmjwHODiMXwFaqodLbvkFeQY9bizcqI=;
 b=DeWNybcGmNSAT+B1iaa7Ko482O/EuOnO5p9nt59kMSkkALVWbZlPtAAL9fjRhjIw20tQWVcGq2HKaFGkpzDSUz0D3/Omd8DSbHSP9GeN7yi3zGuGFC7j1jkt10U0rEvVV6M11iJOTKE63ZYYkSnMo0+mvmK02q4nSn9vg0LoSJSQbw9KXFup8qK0OD5Ocy6gJrdpd4pOenRUacH57z/0lGvIKVNtFWj+eSXzrF28zxIktl98jbAAKqpV984W3IulJxkGtPpJ8eu057CrPsYm57FxtU/7qT29l0Dktd4AKapE+a9QeVNN8xl5Z6aDbeqKuN7SQONC8rvBkElP2QNZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osuwplpN0HyMSmjwHODiMXwFaqodLbvkFeQY9bizcqI=;
 b=GB9037oe51sZ2U+5nDsTcJsIHfxP4T2OF/ob8EPaOhrG4yo0dEu9Uezzf/ghTem8UynzwcguSjFeIBF0As62RvwLMFfd4EzPxbM5x+X54hpaM3huMY9l2H8vC0i7mHU2l6Osx2D2vGIJXX93IHGt9GS4xyZc5VccyAOH8YaVHgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Mon, 8 Jan 2024 09:25:52 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 09:25:52 +0000
Message-ID: <c7dba737-abcc-4bf1-98d7-95335ab00994@amd.com>
Date: Mon, 8 Jan 2024 17:25:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
 <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
 <CADnq5_NuFsnRtkPPBgWR4DZVr_z_Wg68v4B7A64S7iGOnCjsqQ@mail.gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_NuFsnRtkPPBgWR4DZVr_z_Wg68v4B7A64S7iGOnCjsqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0159.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: c9141ce5-ed48-47d5-00c3-08dc102bcf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4udgvzLTd7xZD4mEe0+gfFUkO1PtokoSvq2JuGEcXylHotJY+e+7REp2gzGPDwkRAFnRMHV73Fqnbd26/PWRiauHfrWyvm6COApLJkTMOmFTdlV/T2dRD/aqG8X2lazcR9jB0B+xbKfqtdaqxdAYxR1M3u5a8t1pa5NrAn0p9PejiElX2qaf8UWlIrcd6ZIF4ikzLiAwJW7Oe5MYhh2PK87shyHggsgYynrxiSCiCRtRTL238GQozbhUa0UgzWOWLBqkpsZPH7I/YU8AFyG+WukiSUSK3uQuOkJcUdxwPoW3Du43wASIAKnc3apTIX4qf58yRzeEt0SQUYzkH1G61okHkHxtz9aKIBwKRhr0fUjg3O4SlHlm56YGj0YqLDeBYD4TyDEh3S4O4bG+yQVI+xbd1ABD5oKezn+CcHNdiW7Hx1XOkmWtrzaa0iqdcm6NX4ITDAPDfcJlL1dnY4NvoGWzT2fh52UE+3LsaVkLdu8yqa3TEIxMR2KdIBU5v8HWTbEssf76WBGCZkCZwsOTZP888UgcQRNc/ZpmHCVXiYLclow3uaNVe3DAgPHEDGthU3nj3q1t0wFGInRkH0xYsP55QouGDiLbFX269WDr6a94Lcu325yF262+FfGPPSq1S4bUQtIzF6TqzqfDCayvDsOXLXqfmrid3iy63twoHipJoi3enfyG+TmMkdEp1nr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(966005)(6486002)(53546011)(26005)(2616005)(478600001)(6506007)(6512007)(83380400001)(66574015)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(4326008)(316002)(110136005)(8936002)(8676002)(38100700002)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5GM1I1ZnFHNVFRQWN3NGx4RHBmU3ZiTTZGZ3drOTNBa1RCbm9oMG0zQ0Q4?=
 =?utf-8?B?ZkM4QlhIelo0SkZVTlFSN0xlK2hRV21KRXhmZlVVMWNsQzVuTjNjN21ZbzU1?=
 =?utf-8?B?TG81T0lvRW1LRXVsOGhtZ3FxQ0Z4bFhlVjAxYklSazduclZQdlpZdEtqQ2JG?=
 =?utf-8?B?bmxudVdoWU5sR1N2ViszeC90L3ZQc0ZLMmp3aFRzZGdJck5yYUYwUEFERG42?=
 =?utf-8?B?eGJQRmtZZTA4MFZhbDdWd1lHTnBBVVpib1lhY2pLUW1WdlVlOTU4UGdQV3VQ?=
 =?utf-8?B?a2lseDdZcjJZNWtKMDgvQTY4V1pMa0J6VEM0eHZvTmk2VEJWL3EwN1VVVlNv?=
 =?utf-8?B?YW9lVjJ3SHlYN2JGajF3SzVEbUdnbWpWTXoxeXRiZHpscmNXcy9TRlFJTXp0?=
 =?utf-8?B?SGlrNnRvRFlFSTNFeEwvNElKWEpJcDl1aTVTQlFQbExPQVRkN0NmR3pGaEpD?=
 =?utf-8?B?SllXeDcvT3RyY1hIWFpBUXYxbmVFZDgra0thSVh3NFA4N1hudkt2eWsvVDFH?=
 =?utf-8?B?SWhMdDloSXhwWW5GZ0IzNml3dmJOYXhCcldNQ3lvVzJnTGozTlZiT1NCelBN?=
 =?utf-8?B?cFhWMEN2UmFaQWhSalB0Uk9qZTFZSzk5TXhRdlVqS01SKzdMMzhiNEZGMWpS?=
 =?utf-8?B?WGI5Kzh6ZE10TUR3V2k2WWVXcUdYeWRsRHhxeFdDNURCOUJxR2IxUmFrd3Na?=
 =?utf-8?B?cGtXbnhrdlpnUHZhK2IvbjVKRUppWS8rNkJHVytxS1E3bEtDMmp6MDVjME5y?=
 =?utf-8?B?cExLcWRnV09Cd0lpamx3RGVsME1ralhBZDJnRXphUEJ3QzFTQVNNdE96UzRp?=
 =?utf-8?B?dzR3TTRWWkttRW5rTG0waTFiN3BMTzc4OWpNOXNTb0ZhRVBhTEtUOWUzNDl4?=
 =?utf-8?B?ZDN2Y2s2OEJjb2g5M215b2FXZVNxNktxbUppdmhpNGZQRUtRRDFmWnpEV2dT?=
 =?utf-8?B?eEVFZlZkeXFmMjV3UHJLZkV5UGkrRm9RS2VrdUN5NXNhOVAycVRydVhjU3Vs?=
 =?utf-8?B?NmlpZUxoQXBuUURjd0Z3VWl6ZEVycUlQekk3ZS96OTlyamp0dE1ueG5rM1Jl?=
 =?utf-8?B?YmpTajJDMzRyVmxCN2lGVzA4aGUxZW1uT1Zkd09BZjg3cTdjT3pNaVl3Y05S?=
 =?utf-8?B?VnRCcjU0bzFYVmN6WW1Xb251SzZLQ2s4TnlwWGo1Vi80bXYvakJLdXltaGNT?=
 =?utf-8?B?czJpMTBWWUdBdWRNVXo5TzhLaW5heXBHQXdKMm5JR0VsVkJhMXhMZUZiRW5u?=
 =?utf-8?B?a1RRUExFNHg0VTlUd2p0dmE2TGdzanZNZUx4emdLY1pEOXhpZytTV29sUnNR?=
 =?utf-8?B?MUM4RWdudTVMbHNkemdzS1hYS3hPcUI3ZEtCTFhaUmh4OXc2SmVtSVVVTGFh?=
 =?utf-8?B?K1VRbkg1M1pzcDRwZTVKWXVXMUJESStzOVhvMmNDWThmeTdnYjRIZ0VhNXBs?=
 =?utf-8?B?TmdiT2FBVHhWd1dWT0t3Z3VWWWlKUG1LaktNMzVRZ2xVYTZGTUhmSi90bzFs?=
 =?utf-8?B?Y255eUsrMlJySFJQYnp3TWRsYmJvc2JiQUFueTJlV1JqT3NZTHROdGt1T0ln?=
 =?utf-8?B?dll0T0t3MFFoL01pczZ3V1Q1b1RlTDBrQ3NHNGs0U1RWNE1PV2w3Y0ZkaUdw?=
 =?utf-8?B?YmpjOXZNenVoZVlnS0orS0tjdUhmT1JSVU1zbmdDamUzWkp5bTVJNWYzUlRs?=
 =?utf-8?B?L0YxNk5OMHFQV3BnVW5ZbUQ3YUdzd3p0dUcyUFc4emQydEhQemlOZXdLdVpz?=
 =?utf-8?B?QTRCdFMxM0JMOGJUYkJWbWw0V3YydE1ZS28yMzRZZU05c1l2UnRHZGVRT2Mw?=
 =?utf-8?B?aE1nOHpKUDBNWmhYTVU3NjdDM28xY2JTOHd0ajBBelFXTVhXQ1MvdTZhK2V4?=
 =?utf-8?B?Ryt5Z2tWMllpWnVyNnB3RlZLV0ZuV0tPaC8vUDF4UnROU1J6Q0FhaXBXdlJG?=
 =?utf-8?B?TXc4elJ3SlRhcGp0UW4vZUFLRjJQeTFkN0ZKeDNtdGoyVmcvbjc4eU5FRUVi?=
 =?utf-8?B?dDlObE9FQ1hISGRLQnNkOXdDQVVYZXJlL3kzV3pBZnJRbmZCUmpQU3RUVnNh?=
 =?utf-8?B?dmV1SHMrTVRNYzVpb1o3dUxEWFl2TG1WSTBkVzdDQnJaYy92RDZETDhwWllp?=
 =?utf-8?Q?jfmrVoV21sqQjO8Y+ARGQaVD+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9141ce5-ed48-47d5-00c3-08dc102bcf2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 09:25:52.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0753HL9Us5/rUsa796czeZJIogQXlidd0bkCERgX9ZQsoLvXxjgu9916LYrAKFu
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 1/6/2024 12:11 AM, Alex Deucher wrote:
> On Fri, Jan 5, 2024 at 9:16 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Am 21.12.23 um 02:58 schrieb Ma, Jun:
>>> Hi Christian,
>>>
>>>
>>> On 12/20/2023 10:10 PM, Christian König wrote:
>>>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>>>> Print a warnning message if the system can't access
>>>>> the resize bar register when using large bar.
>>>> Well pretty clear NAK, we have embedded use cases where this would
>>>> trigger an incorrect warning.
>>>>
>>>> What should that be good for in the first place?
>>>>
>>> Some customer platforms do not enable mmconfig for various reasons, such as
>>> bios bug, and therefore cannot access the GPU extend configuration
>>> space through mmio.
>>>
>>> Therefore, when the system enters the d3cold state and resumes,
>>> the amdgpu driver fails to resume because the extend configuration
>>> space registers of GPU can't be restored. At this point, Usually we
>>> only see some failure dmesg log printed by amdgpu driver, it is
>>> difficult to find the root cause.
>>>
>>> So I thought it would be helpful to print some warning messages at
>>> the beginning to identify problems quickly.
>>
>> Interesting bug, but we can't do this here. We have a couple of devices
>> where the REBAR cap isn't enabled for some reason (or not correctly
>> enabled).
>>
>> In this case this would print a warning even when there isn't anything
>> wrong.
>>
>> What we could potentially do is to check for the MSI extension, that
>> should always be there if I'm not completely mistaken.
>>
>> But how does this hardware platform even works without the extended mmio
>> space? I mean we can't even enable/disable MSI in that configuration if
>> I'm not completely mistaken.
> 
> That system is probably similar to what Mario mentioned:
> https://lore.kernel.org/linux-pci/20231215220343.22523-1-mario.limonciello@amd.com/
> 
Yes, It's the same problem.

Regards,
Ma Jun


> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Ma Jun
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 4b694696930e..e7aedb4bd66e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>>>             __clear_bit(wb, adev->wb.used);
>>>>>    }
>>>>>
>>>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>>>> +{
>>>>> +   if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>>>> +           DRM_WARN("System can't access the resize bar register,please check!!\n");
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>>>     *
>>>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>>>
>>>>>     /* skip if the bios has already enabled large BAR */
>>>>>     if (adev->gmc.real_vram_size &&
>>>>> -       (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>>>> +       (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>>>> +           amdgpu_find_rb_register(adev);
>>>>>             return 0;
>>>>> +   }
>>>>>
>>>>>     /* Check if the root BUS has 64bit memory resources */
>>>>>     root = adev->pdev->bus;
>>

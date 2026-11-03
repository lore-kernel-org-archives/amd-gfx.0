Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568E606A331
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lGsY8sQC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4BEF10E122;
	Tue,  3 Nov 2026 17:10:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CE810E122
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 17:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMRis0ALAQLV6P0IehoO4FXwQS2dz76XEGfsDp2a+VPPQx8A3tFy7MCqEDdtZkB1XM9WJEr1GsNRohyq19myF+EhVrT6gTBJevAx+BKTthcWkt5Zv9Mg5mKPxF8j+bt6LFMMc0aJPjW6xtQLB/Zuts+voSIPJDMPsl7EFa8s+1tC5BRU4Z9nittRqXG8Zg6WJqkVr/ImLFIN72o/vg7K/vK5yfXb6K4HEEJaphEDwvQ1CmXxpo+V8hg7ah2vmW5D7eDq6eo9a2pxXQ3wXsA9D2Ib32+qkQ5hPbqNBm88BX9bRB2ZfejtWZVnZk7o+fFo+VkOFSieRTpuZNxSJ1aDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzYyp3jnjzo5m+EG7ZqHM8xxuzdqVo+8JL36JG0vxGg=;
 b=NKSksZjAJHlf+E90ZdfDhH04t8xcfJK7zbbl4PEYUEGywHn1mS1LUh0XMuChF+a92OWELQC2YMy7ulxdkh3uvFslSAA0hF/Le15P+7YYMK/qvXipn2tL7WjqI/fK7mkaYijlMwVT79wlu5JP9LfQqNap7N8cG7rcBCT4guIE9qs8Llb4KCBS1XEA2PMJHfgDamFdhq8Eid/DLSwiotpEqDFQYivTW5tU6oqhfTxl9GRJiOsUyNXJJWZRZRjtD0tKdQe0mvYpNwxo2FS1+1FbJxpYP2Mqxm20MmoJQVsqdjmoJ2+xIbHNsMjquDyz2PTu2rE4iqvpMy4qg2yl6UFmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzYyp3jnjzo5m+EG7ZqHM8xxuzdqVo+8JL36JG0vxGg=;
 b=lGsY8sQCsR+klbTpfJa08AMN6tdGcV8szOu4Nk0Qehf7oWLqEt8Wmf49klNmDIbTUhqlbJNGnQyDxHOwV48WbfNwXl+7wKWR/m5VYiWmHCQ46EOWgjauNMeNVlT5eNnLolDo23vNHRFlkCkqWdsGEMPzdtweB4rxRBJbolT+U20=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:09:56 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 17:09:55 +0000
Message-ID: <fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com>
Date: Tue, 3 Nov 2026 11:09:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: Philip Yang <yangp@amd.com>, "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Faizal, Sahil" <Sahil.Faizal@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
 <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
 <PH9PR12MB13592198ABB2BF96C9F290F41D9F6F2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <ee715a81-5643-4da7-a0b9-7205e34758b5@amd.com>
 <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:806:27::18) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 43291b9e-81b5-4bfe-dd7b-08df39cd47ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261022075727099003|5023799004|11063799006|56012099006|4143699003|261022105027099003|261028144727099003|261009223027099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261026140227099003|10067099003|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: bNW4hv0b62cJ24foNi3J4iqh+aWlTwjmtx8bRq5GfDluiOeEvMfthP4bjNqUeRZfZ84lD+aPwe8Zxbw133rgJUsZecCvWf1Qbu3ZG7SThAiU4N0ctQsMQ+2C4nyYWl8jSK/QmTE8zNLt/X/wSjuFzrc9jV7j/842mMOxf2PYNdYW3RaNRzBfs7I/qxtQRePHNni9sK2oHxGJ0uNNrc5UH9xVU+aoYNcZxE73EdyjA5b/0ttVyXRStjx5xL1foz3IKWa/0hfOQ/9mYZwmmsV1+ilgYvlJTHutu8CfV5SlJtMWazDuYIIrXQ0XUPNPIjRlKf9kSpIhBUGTGrkhaHnYEu7VQQnb9zs9f6IFbsY4vPmHRGVhfVctSscZGkxITtSGnfbtnhLP5JCIALCSAxhnnTXk1/qK4CAWrjj+bzETaajY+T9tpOO+eucNy/2MRjibRXOYyySryA0aSr8+wHFS8FB4W4aWqqLXm+0d21APQ504xex0ckjZyacaZeAAMi0mdsE0QL5MyjZ1SKoHwnJ5/NEmom3Dmx05hOLgUX7x8pdITFjyyLEywwuNEUSmljYIdJASQVujN1FP4WEVx3ffshf8NgT2zFA4DL0qJcjiAIlKnnRoFeFUi8BOqBsV8AHJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261022075727099003)(5023799004)(11063799006)(56012099006)(4143699003)(261022105027099003)(261028144727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlod05ibVM4eFZ0dDNkU1pJbERuajc1K1UrQlJTdUxBVy8rYUk1aUZhbEdF?=
 =?utf-8?B?TDVLUEhwK2hjMFpoWlhBY1kvaXJ0ZEl4eTVhQ0tmTFFzNWJLUjNVZGV0cnpk?=
 =?utf-8?B?bzlEYm1DQkRrMU8yVkVRQmMzWDdxOWQwaW5QZ3hpUStnbDVSWm1QMkF0Sjdk?=
 =?utf-8?B?UHJTTEZ6bS85RG9KWWgrUEVkRTVpSVFTUTFBNjFMczFRSDNWS3c3YytMYklN?=
 =?utf-8?B?QUlVS3hYRkZEekZ6MHhDRmdyQ0F6b2hPTHV2TmJhYm5qUmZ3RHlhRDlIc2Uz?=
 =?utf-8?B?SHM0aU5sWlFlcnFCTEpJKzFibytxUTBwWG9RVmpKUDNOL21jbmhheWRCb2hh?=
 =?utf-8?B?blJrTTZmY2JIVXZzSC9mKzh0VTlUampBeFRSR0d1YWQwZmtVWlNNb0NZcEV5?=
 =?utf-8?B?dklqYVl4dnNjS0FJNUxwcForelNCdkllZk1FZG9SR3BkSWdsbHhOeGp1Rlha?=
 =?utf-8?B?MkhNSVpHTE5keElDMXRKeXB6UDNIbURKMVF1ZnlpeU5HSkxCdFVvRWI1WERp?=
 =?utf-8?B?RjNVSjArb1BPUzhiVHdrakJLWlVIN0xrS3VVS04vTkVLcFZuaVhJSWRIVklB?=
 =?utf-8?B?dG9RQzVOVnZBM0FvMlk0UFN6REJ4RzUzd0pVVjJQR0dveEMrdjN6T1BldWhs?=
 =?utf-8?B?SVVFSWFvZEhQVEYzbVREL2ZPMFp2WGxINDVNbWpQNXcyWVg2L0hSeDMxcFJK?=
 =?utf-8?B?eXB1a3d1cEc1SHlDV01BZklwTEUxMS9rUlA4K3dGOWZhZ3NkQkk5WTN3ZVpZ?=
 =?utf-8?B?SGFSOHhHYnkraFliUUF4TE1lT2VJNysraGxsOTJucDV6a25YVEg2V1FNOXFz?=
 =?utf-8?B?Njg0cXlZTzlQNUNGOWhzYXRsbkpsei96c2hzbVQ2N2Jha3EwNFpGeTZKZGUw?=
 =?utf-8?B?aEtEaG00TFBjajNEWFRab2VNMStidzVDMkFUNEhzTGV1UEY5U0h5L1B1c0VL?=
 =?utf-8?B?cklnRy9EMmMrSjU5bHZiV1MzTEM0UWVlancrS2dCSWd2OENBb2g1RWgzdUR4?=
 =?utf-8?B?V3drM2JIaW9wWDlNbVZzaTBkUGxVM01Uazk5NXVKSk9oV28rREt3VU5EcmNo?=
 =?utf-8?B?OGV2TC90WGFaay9ZL0YxUUg5S2Fnb3VZekNvS1ZLNE5ralpjVEpicXdUVHVQ?=
 =?utf-8?B?V0RmKzlUbk5UL3dYYnhEWlF4QlNVd3JEWDdCUnYvY0lNME9LOFVWTzdZOEgw?=
 =?utf-8?B?S0dGUjcwalVHVUxvcEphZHFYTnZ5YThlTXUyQjFDZERuWFRFM08yMlNubytY?=
 =?utf-8?B?VEZTTnRNUk01bWM3cGVSKy9JUlpXbUZTbDVTbGRONS9jQWJBUXdBTzZtRnpx?=
 =?utf-8?B?cTRMREovWHFtc0h4Y2VQU0ErZ1IxakgzWDFVNFlRaVlHUWxTOHh4ZW8zUHhp?=
 =?utf-8?B?TEFLblgvRWxXZ2ZPY29RaFVJUGxPQ2VBZDg4QlNQa3VWZFFCWTkrTlViZW0v?=
 =?utf-8?B?cFYzcyszSmJKTGdKekYveHNtZ1RxRUhxM0VGZnBsOVVvRWZJTng3MThhaW80?=
 =?utf-8?B?K3ZNdXhoL0Yyempvb1YydDBDNzF1QlVXVWZodW44VFNDRkwvU0RORVNaTVFr?=
 =?utf-8?B?ckcySFJZL2FBUThJelEzdmphSzdqTXhvanhPNW5qZ2lsSnBESkp6ek9FRTBS?=
 =?utf-8?B?cmx3Sk9PaEZXMlUza2ZYSnYzKzBiYUxYbVJZLzNheHovYWFsRVBMZ0Y3QkJT?=
 =?utf-8?B?VmtzbmRuZ1BWOXdPeUxibnJjYVdOT0Yvcy9kVFJFYmx2U0hDZlRXbXI5KzFJ?=
 =?utf-8?B?b3lubjk3UGs5WVpGL3prYytHUHFzSWJYdFpoS3JFK0dUTS8xdjBJWnZmamZr?=
 =?utf-8?B?SUQyUmJQMnBCUldHQzFWV2xsRnN4WGNzWnZPektOUGdJeFpHdlQxRUhuWk5X?=
 =?utf-8?B?dElkZFRUYzduaThXcmVPRFpwSUNXNmdPb1R2SW5QeTBwa2pscUFFaVJJNklr?=
 =?utf-8?B?S01HSFAwYjZJTFVzOWxCT2pIU1NiaTNFY3FRcVZTdXVoaG1MTzd5ZjZXTXpC?=
 =?utf-8?B?WVhpYTJIK1lPcXhKd0NRYm1FeWVISUVIbDJ3UUwrejdlb3l4aVRaZEh0bStB?=
 =?utf-8?B?Z09QVkIwdWpMUittaytkQnhYWU5ULzd0L05CVjNrS2F3Y0dZZUU3MEJ2SXQ1?=
 =?utf-8?B?R2p5K1oyUjU4Q0t6endUaFoxa0JGdnlDajR3TXZZL255VlpqaWgrcUFDNUtk?=
 =?utf-8?B?cWpReTAxN0JSaVVQRmFkR2lxSHVNa3ZZWnpxdTdoL2RrMDE1bFpwZk9UdUY1?=
 =?utf-8?B?cUNyNitjc05taUVPOWg3OStXVmxUdnQ5aHFja0VRcGZuc0xTSFRFUU5CcFlP?=
 =?utf-8?Q?6EGjiGpfBOyUd8CfyY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43291b9e-81b5-4bfe-dd7b-08df39cd47ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:09:55.1532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sb5/XHt5s6fqbnTACzQlgJGFBvVzONMy/eTOhtwTrjNHrluPrjeE9leC3jU8jst
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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


On 11/3/2026 10:57 AM, Philip Yang wrote:
>
>
> On 2026-11-02 18:32, Mishra, Apurv wrote:
>> AMD General
>>
>> AMD General
>>
>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up on 
>> your comment...
>>
>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, then 
>> |put_page()| (/mm/memory.c:3861–3864/). The extra reference outlives 
>> |migrate_mutex|. By then P's data has already moved to S, and the PTE 
>> points to S, so nothing else is wrong.
>>
>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| reuses 
>> the |svm_bo| because P's pin keeps it alive. 
>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>> checking it, while |zone_device_page_init()| requires the page to be 
>> free. The fix adds that check where KFD hands out the page. When the 
>> pin is still there, the page stays in system memory with a valid PTE, 
>> and the next GPU fault migrates it normally.
>>
>> Mainline is the same. |do_swap_page()| now holds the page lock across 
>> `migrate_to_ram()`, but `zone_device_page_init()` resets the refcount 
>> before `lock_page()`. The race remains on mainline, because upstream 
>> KFD has no such check. My patch adds it. This has been tested and 
>> verified.
>>
>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates as 
>> the fix needs to merge soon.
> This is the corner case I tried to fix with the patch "drm/amdkfd: Fix 
> svm_bo and vram page refcount". That patch was rejected because we 
> cannot take a page that is not free and treat it as free and safe to 
> use. The approach here makes sense to me: if the page has not been 
> freed, we skip it. With that said, this patch is

If the page has not been freed HMM page collect will set 
(migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation from 
this patch is do_swap_page does not release vram page during cpu page 
fault recovery, then page collection by page table walk would see pte 
sill point to device memory, then not collect this page.

If this explanation is right it is not drive issue. Driver does data 
migration, not decide which page can be migrated. There is contradict in 
this explanation. I suspect the real cause is not revealed.

Regards

Xiaogang

>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>
>> Regards,
>> Apurv
>>
>> ------------------------------------------------------------------------
>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
>> Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish 
>> <Harish.Kasiviswanathan@amd.com>
>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>> still referenced
>>
>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>> > AMD General
>> >
>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>> <mailto:Xiaogang.Chen@amd.com>>,
>> >
>> > The migrations don't overlap. |migrate_mutex| serializes them, but 
>> it doesn't
>> > cover P's last reference:
>> >
>> >    *
>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has finished 
>> and before
>> >      the function returns.
>> >    *
>> >
>> >      |do_swap_page()| drops its own reference on P only after 
>> |migrate_to_ram()|
>> >      returns, at /mm/memory.c:4851–4853/.
>>
>> Before do_swap-page drops the last ref on P the cpu mapping of fault
>> address has not been changed. Then at following sys->vram the
>> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) page
>> because the address there still point to device private page(since you
>> got cpu page fault it is device private memory). Then (migrate->src[i] &
>> MIGRATE_PFN_MIGRATE) is false.
>>
>> If P got used at sys->vram, but P is still used by someone else
>> something wrong is in other places. Skipping migration does not solve 
>> it.
>>
>> Regards
>>
>> Xiaogang
>>
>>
>> > So, the GPU fault takes |migrate_mutex| legitimately, while P still 
>> has |
>> > do_swap_page()|'s reference. KFD gets P back without P ever being 
>> freed. VRAM
>> > destinations come from the |svm_bo| by offset (`cursor.start + j`), 
>> not from a
>> > pool of free pages. That |svm_bo| is still alive because P holds a 
>> reference on
>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it and 
>> the same
>> > offset gives P again. Nothing checks whether P's previous user is 
>> done with it.
>> >
>> > Regards,
>> > Apurv
>> >
>> >
>> > 
>> --------------------------------------------------------------------------------
>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>> > *Sent:* Monday, October 26, 2026 5:27 PM
>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-
>> > gfx@lists.freedesktop.org>
>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
>> Alejandro
>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>> > <Harish.Kasiviswanathan@amd.com>
>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>> still referenced
>> >
>> >
>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>> >
>> >      AMD General Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>> <mailto:Xiaogang.Chen@amd.com>>
>> >      <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>, 
>> thank you for the review. The two migrations
>> >      don't overlap on that address; they run back-to-back. What 
>> overlaps is the
>> >      lifetime of the VRAM page. This was reproduced with ASan and 
>> XNACK, which
>> >      make concurrent CPU and GPU faults on the same ranges 
>> frequently. As per the
>> >      logs (ROCM-31012 
>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>> >      amd-hub.atlassian.net/browse/ROCM-31012>):  *    A CPU fault 
>> enters /
>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>> >        svm_migrate_to_ram/() moves the data to system page S. The 
>> PTE now points
>> >      to    S, but /do_swap_page/() still holds P until 
>> /migrate_to_ram/()
>> >      returns.  *    About 66 µs later, a GPU retry fault migrates 
>> the range back
>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is correct 
>> here, because
>> >      the data really is    in system RAM.  *    KFD reuses the 
>> /svm_bo/, which P
>> >      keeps alive, and gets P again as the    destination. 
>> /zone_device_page_init/
>> >      (P) runs with ref=1 (traced) and    overwrites the refcount.  *
>> >
>> > How KFD reuses same P? From the description above CPU fault has not 
>> finished
>> > because  svm_migrate_to_ram has not returned, P has not been 
>> returned to KFD
>> > driver, so P still has reference count.
>> >
>> > Then GPU page fault happen on same range. For each migration on a 
>> prange there
>> > is prange->migrate_mutex to have migration on the prange happen 
>> exclusively.
>> > Then how can svm_migrate_to_vram enter migration if 
>> prange->migrate_mutex is
>> > still hold at svm_migrate_to_ram?
>> >
>> > My basic concern is a vram page can only be involved at one 
>> migration at a
>> > moment. If it is getting migrated in two migrations at same time 
>> with difference
>> > direction there is syn issue. Checking the page ref here to avoid 
>> migration is
>> > not fixing the root cause.
>> >
>> > Regards
>> >
>> > Xiaogang
>> >
>> >          The CPU fault's /put_page/(P) frees P mid-migration and 
>> clears its
>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 of 
>> 264 restored),
>> >      and    it's left pointing at S. S is freed, and the next 
>> /hmm_range_fault /
>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the panic 
>> registers
>> >      match this page and S exactly. With the fix, the /refcount 
>> /check skipped a
>> >      busy page 705 times on the repro host with no panic. Regards, 
>> Apurv
>> > 
>> -------------------------------------------------------------------------------- 
>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> *Sent:* 
>> Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro (Alex) 
>> <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>> <Harish.Kasiviswanathan@amd.com> 
>> <mailto:Harish.Kasiviswanathan@amd.com 
>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount 
>> and    leave those pages in system memory for this migration. When an 
>> svm_bo is    reused, a VRAM page can still be held by an in-flight 
>> CPU fault    (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM 
>> then re-initializes the page via zone_device_page_init(), resetting 
>> its refcount. The fault's    late put_page() frees the page 
>> mid-migration, so migrate_vma_finalize()    never restores that PTE. 
>> It is left pointing at a freed system page and    hmm_range_fault() 
>> hits BUG_ON in pfn_swap_entry_to_page() (swapops.h). If there is cpu 
>> fault the data is in vram page. If at same time driver is migrating 
>> data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should be 
>> false since the data is already at device side. Then if you got a  
>> MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after 
>> migrate_vma_setup, but cpu page fault also happened on same page 
>> there is a contradict. So, I do not see this scenario can happen or 
>> the real cause is revealed. Regards Xiaogang    Signed-off-by: Apurv 
>> Mishra <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>> <mailto:Apurv.Mishra@amd.com>> --- 
>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 +++++++++++++++----- 
>> 1 file changed, 15 insertions(+), 5 deletions(-)    diff --git 
>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/    
>> amdkfd/kfd_migrate.c index 8b96e1fe741a..1eb92ac6eb05 100644 --- 
>> a/drivers/ gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 @@ 
>> svm_migrate_copy_to_vram(struct kfd_node    *node, struct svm_range 
>> *prange, amdgpu_res_first(prange->ttm_res,    ttm_res_offset, npages 
>> << PAGE_SHIFT, &cursor); for (i = j = 0; (i < npages)    && (mpages < 
>> migrate->cpages); i++) { - struct page *spage; + struct page    
>> *spage = migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] 
>> &    MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << 
>> PAGE_SHIFT); migrate-     >dst[i] = svm_migrate_addr_to_pfn(adev, 
>> dst[i]); - svm_migrate_get_vram_page(prange, migrate->dst[i]); - 
>> migrate->dst[i] =    migrate_pfn(migrate->dst[i]); - mpages++; + /* + 
>> * A reused svm_bo page may    still be held by a CPU fault. + * 
>> Reinitializing it would free it under this migration, + * so leave 
>> this page in system memory. + */ + if 
>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + 
>> migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>> svm_migrate_get_vram_page(prange,    migrate->dst[i]); + 
>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } - 
>> spage = migrate_pfn_to_page(migrate->src[i]); if (spage    && 
>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 
>> 0,    PAGE_SIZE,      DMA_BIDIRECTIONAL);
>> >
>

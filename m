Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7D608361C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5WRo1dP2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A38D10ED41;
	Mon,  9 Nov 2026 09:59:03 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E82B10E85B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 09:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0o3bPzlI4y3q20e0pHYYZR60ytSYSnp53rYJDb/Ss0P6T1OheyInU1+769Y/DbwSqnYAX7duE4oZR8eteEaxWbmgBIrdgVOUThlFpp0P84CFgOdWH0CK7pG+KSersQhF8eMztxq4Vo3YH0Ad5thQmFlUNM2nUxuK+A3h1mPj8xa3EcSCQ4cEqyy6GZFPAZvZv+WLUzFqp+6fBCqP9UgUJH5loLDm2DMAJA2auuT+xYEzhrJZ/1R7g8UpTUUKmRrWw4/J8FD7qlFmL8vLP/00IJoy7GT5HqP4wqdwQm8Byd4KeuP5BUKRGFaZCmH7Sc0bS3pOOzUIa5TMgJ2JjjCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM0TIzjDTwR45zZVw1LJ2I0sX5Dfx10QSK1YtUTlQyU=;
 b=HCOIyZTtnyhxPiqIM2SA8U+IjhDhUm49ZhjZalkZg1fI7mE4+XNY8FbyRHZIq7hTu9UYCk6KPX3esVh6aPqUldguE3KEXsIqrioKGOgXZfj0nOAnkJg9j1rC/fLcNiCs22MJ9a2AAWaO2Rkpuw9ZniLuR7vaM9gPYI7q259pbEsLReb3arX2wgPVA/7a6oTfdorIaJpOval6c/0MvKbcGUXLV9fJUqoElYqxUV9iOdVmKEQKu3CyGCTDBRvT+J/KAoMRQZOyIyujR8W4RPK/jZB8cx6ajstRV++eof2eNkvW+Y4JL59wuSoWxB5d4jpCtsJS17cFDlPIE/eyWlVMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM0TIzjDTwR45zZVw1LJ2I0sX5Dfx10QSK1YtUTlQyU=;
 b=5WRo1dP2G7FY1lGDawemQ+hBpxVlZEsp8Bqnl3ULpbzu/4nhfWSF+fyq177pVZqpqSrKCj96ErNX9kFA+Zhr1EWvfuXOvPVXxYmXfvYkVhD5bIvWLEkvBKGXxDoEZ63GA1YXt+/2NECP71vF4p1cNbMLx7O6m6WfZ1xxOKOpPf0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB473303.namprd12.prod.outlook.com (2603:10b6:610:34c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 09:58:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:58:29 +0000
Message-ID: <5afedea6-0af4-44be-8e2b-94eefdae5908@amd.com>
Date: Mon, 9 Nov 2026 10:58:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: wait for tlb flush before freeing BO
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261106152031.4040973-2-benjamin.cheng@amd.com>
 <26bbdd2a-b26a-4e76-9eba-092a7e61660c@amd.com>
 <0fdcfb20-3c4e-41fc-9b40-55fe58f2d210@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0fdcfb20-3c4e-41fc-9b40-55fe58f2d210@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB473303:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8de11d-13ae-4113-7d1d-08df3e480183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|4143699003|5023799004|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: g87KEBeRxMfXbr/q2/DuqAsiPTbGD9Fz7IOD/vnYOXFinLUjpP7DAAwiJ79EF8CczEdo8TgYmGfBeLzYEpqbp8uOj7Bi5jLe93SVll1lPHmccwNPE7STzS/tX5swafsiIQridmJCHDpKidVIiqUnJutW5r0yBLpSMkEWqYzH4BnwQ9NENLX/gZRtwB6kHjcmql8GQJ91B6bEn1Xn9UMIdxLA9uxvynUbBYwdjbsPYbnUmfOqSgU1LSR87pvjHSf18a35dh3G7xdRkMMfJ8xJiYHyIABuZdBMvb557Msy197sY+NqQ8sbvtPWncWrni/qF3xj9/Ikncc16uLbwrrOaLjJEn4xehDjNLS42BpNrZZtdB8w2UFIRY5YFSA8wr6XZE4dTCqoQBFWjWsgbuWtph1I8mdSGwNImLSbr7TNDWj07mSu7TWLric9yhU9TCTVY8yZ0pRsyE5I2fcUNOBVqS4CGHnbjURcID1tonHu5AdR8zcqDenzcd4SrdVHE/VDDRypeQyBjD1lRzEoNngyRvzMqaYgX75Hvy/VYAZKBrzqk9VB5bVGC7oF1Ve5sQnJ9SSV5kuO+9cmy85eYzCxiT9DlNFeelb6dLWI86gvyCxWxe6f96ah7pFAsIrghm5ETCxV5QppzxXw3rreJ2AcmlGvK5r8nWTAKn+ot+Xunto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJnSXJMd2crMGJockdkSjErQlRzOG4yc0FFQU1wVldmVFJ6U1pKaEEwR0Ft?=
 =?utf-8?B?U1VUdURFSndPOHhjSDlPZXh6dFl5Uk9tNEkySHd5MWdUQ3JSLzdlOUs1Wmt2?=
 =?utf-8?B?aDlBSEl2MWJtTTlQVzV2amNaN2tjV3hZczZiS0VzakU5d25FRjJuNnpxTVVh?=
 =?utf-8?B?RHcwUzF3WDI1ZGZJWEZlcjQxZFVMSklPQnBUSHE3M1pqY3Y5bXBXTm5yMFhL?=
 =?utf-8?B?dUtvcTJ4bGY2Vnd3ZVhFUXBreVhxNTljVDhJN1EwSW05YU1Sc1RZZ2ZTajEy?=
 =?utf-8?B?UjA3WER3M21LS2d6WVRWZ09nMXRRNnkyN0grYXdDZ3JMNmNuWW84Z0J6d3hG?=
 =?utf-8?B?TkVRV0tDbXhkV0xVaklLVko4WUNIQk1MRkhuUVZRYzJmMTVXa2xIamdUR3d4?=
 =?utf-8?B?N3dFQkRxQ3NXaHBtdW1ZQkV1VHZ6YkNOeVl5WGFJbG9EMGlzcXJvTkpyRENj?=
 =?utf-8?B?R2RlZERVNW55ZCt5STY2alEwWU9wTlJuRis2dDBhODFYSVZ1TG82Wlh0c3Fl?=
 =?utf-8?B?ZXA1OVUxVEs3alYvZVVXUDhmdXZwQWVXRnZVRW0rT0RUb0hNVUtDUWVGYnla?=
 =?utf-8?B?dS9xS1FKU3pCKzRSWElxaVdzcStzSmFFY3ZBa3V6b2RwY2kxRVI0RlVadmVB?=
 =?utf-8?B?eGwrR2hPRWNLTk0yc1FEQnNVM1FycDhJeEZlT2lZU2lURmlqaDFvS1J0VXBK?=
 =?utf-8?B?czBqQSszQXdLeEhKb1RKOENnWThwYk5zL01QR05kQTZpTjV4SlA5bzdMT1pO?=
 =?utf-8?B?Y1VvT3ZQMmVXdkpQd2htREVGNGtPOWhMSnR4WmJMUXZ5OWpzN1laVHJWdlVZ?=
 =?utf-8?B?dkxWS2ZPVDc0ak5XZEJWZEUrSlltZzdlWkxmWEFVa1J2b3hmQlcwTWlrcGhh?=
 =?utf-8?B?RkxGTFd5QTlqMlhjNUxoaXpWSTFkc1M4RVNWRTEwUHJKNENxdVNOM01rdGxK?=
 =?utf-8?B?OGZTR3V3TXNqNlg3VFFQOXNzdjZQZmhPRnIxYVVKR1Y3aWszSURIU1BBWkdh?=
 =?utf-8?B?VVZFcUwyY1FHYXpCOVBLdXJmZ2pPZklrbk1Ec2dHYnMrdUwyRy92aVpsRWFt?=
 =?utf-8?B?U2pSckJOYWJOa0NaZERpaTYwOXA5UmhZN2Rsd0Rvd0hXbDc3WHQ1VHJRbllq?=
 =?utf-8?B?Zlp0U0dFdTFrb0xLc3VFdEpxVURmbXNZTFYyN0tnVzhnSWl0M3lDMzVzT1Nt?=
 =?utf-8?B?RDhNa3pKNlY0RXB5ak51VnpYaGZ4VGtnck1VUmpXNk1YL3FjRlU3YTN1L1Q4?=
 =?utf-8?B?VEtpUnY0a3JlNXZBdGVjZFVKdkJMS0hNWHRIb0EyVXBpSEZVcnV3R2dPNEVJ?=
 =?utf-8?B?dDhyUUt6Y253cUNMclpjYzJJVWRCOWVmSmc2emJUS21YMm5IYThnSXlGTjha?=
 =?utf-8?B?ejNGSnBYTTZMVjdtQXcwblUwV3JVUzBRTVVDSzdqWnpXUzBINndubmFwbjk3?=
 =?utf-8?B?OU9idEY1TVpHWmY2UHhNOWhiaGplVk1OcXRzNTlRUzdGaUZNaTN3WUF0ZWk1?=
 =?utf-8?B?K244UC91NTV2dy9MYXk5OFlOWUJLL2xQaXM4MEQ4MFBndFhUbDN0R2lnay9Q?=
 =?utf-8?B?NVdwVjFiMTkreTYycFpkN2x5Q2l1WjkycHJSRmxzWVV6b3hKc1E0bW9zMkk0?=
 =?utf-8?B?VlY5Tjl4aVEybFhFV3NDQVcxWSt2Y3lIU25BVjJRSE51Ylk0Vjh4czE1SlBj?=
 =?utf-8?B?TFh1QmFOWnA4SkhiemgrVktKZE0waVYvdC90MGRBZDZ4SEZxZGM0K1VtU0pT?=
 =?utf-8?B?bktuOWZrTURsNklaU0hyaHArbHpLLzFCd2JKai9UcTZNcU1Gd25JNFNTTkFF?=
 =?utf-8?B?RXVkb3lvWFVURWJyVTN2Sm5PVU9MM0trc1VFelBpSGg0OU0rV3pQSXpNR3Uz?=
 =?utf-8?B?SS9udUhaWE9JRi8xZU5ZMllpdDBBTUlJRjRRMTBKeDVxRDkwNHY1YmdHSSs1?=
 =?utf-8?B?UFl2QkJkbWk0TlJGMmZKWFU2aE5YVkVGVFZuTWhSNXA3ektieG8rM2pjbWJi?=
 =?utf-8?B?RnI3QlI1VzNxNXNqTFNwSnB5cW9RSmpQcFlKR1M5M2NlSFJ0U1RQSlFhak4v?=
 =?utf-8?B?MFFSVXcyYnNPcW42bTJkVEdDQXNBL01MUm05ZnpBZ1RkY09DZ3dGd3pZZXNn?=
 =?utf-8?B?L1NQRjZpSUh2NkhIKzVjY2MvMWtyaFNrcVFvYmQvbVlROVVsL2hZRWxnV0t0?=
 =?utf-8?B?SzY3TmVDUENWOHhLM3VJNnJNTXAxM3BIVXptSXZJNzRnUWR3bTluRjNzMlp5?=
 =?utf-8?B?S2dEd0RIME9TMm9KVG9tc1FFV0VBUWNibTYySFJyK2lleGNKZURZQkRtNDAy?=
 =?utf-8?Q?t1Ig1DwQZTkDNpYTPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8de11d-13ae-4113-7d1d-08df3e480183
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:58:29.6130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GWUmqYuSmRgTXOIqprU8znoYjn/fulQJj6iKVw1HmpKxKD5E3grTBo4xgDwToqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB473303
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



On 11/6/26 17:07, Benjamin Cheng wrote:
> 
> On 2026-11-06 11:04, Christian König wrote:
>>
>> On 11/6/26 16:20, Benjamin Cheng wrote:
>>> On gem object close, we previously only attached the fence of its own
>>> clear_freed() call to the BO's resv. If an unmap of this BO happened
>>> prior to the close call, clear_freed() would be invoked, leaving
>>> vm->freed empty, and no meaningful fence to be attached to the resv.
>>> Because of that the memory may be freed before the TLB flush is
>>> complete, and give a running userq potential access to a stale
>>> address translation.
>>>
>>> Fix this by attaching the last_tlb_inv fence to the BO's resv.
>>>
>>> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>> ---
>>> v2:
>>> - Rebase on "drm/amdgpu: fix TLB invalidation fence handling v4" to get
>>>   last_tlb_inv
>>> - Move the fence after the clear_freed call to make sure we wait for the
>>>   right invalidation.
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 6137ab4211be..36b0bd85616f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -371,11 +371,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>>  		dev_err(adev->dev, "failed to clear page "
>>>  			"tables on GEM object close (%ld)\n", r);
>>>  	if (r || !fence)
>>> -		goto out_unlock;
>>> +		goto out_tlb;
>>>  
>>>  	amdgpu_bo_fence(bo, fence, true);
>>>  	dma_fence_put(fence);
>>>  
>>> +out_tlb:
>>> +	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
>> You need to change the drm_exec_prepare_obj() call above from 1 to 2 since we are now attaching 2 fences.
> 
> 
> As I said in v1 of this patch, amdgpu_bo_fence calls resv itself.

Mhm, looks like my response was lost.

Absolutely don't use amdgpu_bo_fence(), reserving the fence slots there is a broken approach which is why the function is deprecated.

That needs to be done once after locking.

Regards,
Christian.

> 
> 
>> Apart from that looks good to me.
>>
>> Regards,
>> Christian.
>>
>>> +
>>>  out_unlock:
>>>  	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
>>>  		dev_err(adev->dev, "leaking bo va (%ld)\n", r);


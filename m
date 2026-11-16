Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0A606A32F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yx7fl29W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7940C10E3C4;
	Mon, 16 Nov 2026 19:42:52 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCF510E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgIkEPtiR806SgFdQu+97217vHkxCC6sIQZS/pNyGwKka7/J4H4Cd9ZYv6GiErfW0c+9ydtfXSe+vGbScdrkxJTksTgt5Nyhhsdm1N3/d/C6+2Vg+Y6r5Fo6/UbXPqs9TA8f4F7AZTye4A4o1L7Wo9W7JpTqztZetJIihFiU4QnecD2b+0x6LN0qo1pPuXummXBIy4RZYg6dEgB+zS+twEghkbp67lEqe7ISua40x20MIg6MGiMtckVsVjaNw0AvGoRs0QlfZSDgEXwbt2ANWiI3Fcnzx29bR0ZD2SKVyJavapKU+QFH2Xk3AfoPySeepg1/pVR4ub93D+8DhFIMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVHpy6dbEzeKRg1kFdQ5WpkS/4zPVwKLl1HpCJSQewE=;
 b=pj0jedQoJKCFM4HsBlOngDA19Lk3mecCj52iHNWpZzLDckqFt5zSLuj0J8fGDdTdeXh5JHDT2QWYHQKmf/Iqv7Ow+ywatQ+PcX+veCx81N5z2seHkuLRERPoKLHK2ok4PfM4s18TNnBV/8CaDyAzA0XqAGHey7+mm9ae6adS3OCDNGrkWIZ9hah0/CHb9jQwIOL4AAWfLyRum68i708U9Gb54McyaXDBoJ7WE3xu5ZEdw1LjRepbXBEeoAUoSRsBeRvyhMtUW+gbg9Po9HqXU4QND9wGrZ8C4QeHgravydse3IbPJwlRwUxsafFAVw6uQu8lV5gzsOJb9QOuTEwBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVHpy6dbEzeKRg1kFdQ5WpkS/4zPVwKLl1HpCJSQewE=;
 b=yx7fl29WRirQWxNPLIFg+zW5DW4c+QJv2y2LMP3BgGbv3qSdrH5VmvwcQe2y+EY8yFNXHqjLTJwh8kUy1B/fSBkz1KGzJ7pt9tx1N1WiBsZEU94l6z3B8+4ta8iT3XOle+LxiOhAzX6vw+s5zXJhYtLV3uDVA2TRWS2MgamOulQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:42:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 19:42:42 +0000
Message-ID: <e32c1312-8823-4c01-8b31-c4385614141a@amd.com>
Date: Mon, 16 Nov 2026 20:42:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Perez, Randy" <Randy.Perez@amd.com>, "Chiu, Michael"
 <Michael.Chiu@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
 <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
 <385b0781-f3f1-4819-a027-d6e3f5532783@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <385b0781-f3f1-4819-a027-d6e3f5532783@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f52321a-7f88-4311-7c42-08df4419c782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: QZxq8r3nPzJOaqwhxj4P6SE7fCMLV+Oa7atc+cGpJCpyJBG2PpkRmDSfeU3VdLzYBBQfrh2Vl2i8r/NMOXF30/MR/+x7YfZBgO0633Ob4sG4cZsLu1yRHmaSefaoHMX9pdlbiFAgUYbTjlkwPEW/nipUdCh46Ngru+7Yz0t5XaF4J2ayPnza3eSt04CnGynomlFlKQ5AJxwW4sp57rwdpAN17E0s9do97CchQG4SCNaO8f12jJ3dg6uaGWahOqSA9DNCUIRCVAe99aFyZvPX4FGTxU95pmtdHIAZEDTrgoRpFXzpUe3CdoJ8AeqtIBj8BS2i1JaFeUY6jUbhPJOmNgWh80wRJvxiFv8bYvY/SQ8lX0oM70ReQ8LBcEc05A1gfV7PfPic9IcM7eP8imnbe3uRYKBX3f86yHPoj7d1DfTjkbiWzLwBdmlqwhTtuahleY4THV9zUQCwftWmk4m/3HABw/Lqjwbb5Jlw6oy4VFoHlSTpOK6/DwOhQ4VWMqj4/KRMTexb1LVfVvCqZEQQ77q1iY8aKD3DBW/vSb4kSDA4TKfE5AelptrclS+n8w3ky/+gqRo3UtShe6RyEGtDLG0c0sKN5tVMK2bFlr1I47xcV+nTgDs6gSepnuMgaFhOOI0SAkfhd2CadRM+ai5ouotQUctcn0ZKEiRjAM0Lnxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJOUG5qSVhKZXJxSG1aQmVCdEJQVVNHeFViaW9UVTNoMVFjRTBuSnFEdWRU?=
 =?utf-8?B?bUM0cWw1THlkYXNXVjhMK3JBcDIxdzNvOTBobUpSWEE2Qk1TeVVXNTB0bURt?=
 =?utf-8?B?V0lzNjVuYUVUeWlIdit0M3I3dmI1ZXp2MENZMm5COTh6OVdOZ3hPSnJNR3dp?=
 =?utf-8?B?aDhmKzhKVUJUaXhkK2dHUStXcjR3UEd2YlJVTmtiU1ord3VGemd5RXBiYjdQ?=
 =?utf-8?B?R2hFV3piUGlid3FGQjFVTWk2aVlvNHUwUjVlNlFnYUpqc3VCaWtHVXlITFk2?=
 =?utf-8?B?S2swK2tLYWlNUmRIbEMrWVduTzFaK1pPY25GNGlxWFpxeVU2VnFvVm1XNzFa?=
 =?utf-8?B?TXMyd0ZTWFZTRTFYdzE3VWlDajE4TnN1bzVGUkZpSXh4ZGt1YkI0eTFJYkJH?=
 =?utf-8?B?VWZmWHlmRTdCcThuSGVNNkZoUTNuSXJacXdDbzlES0w5V2xoa2R5NmJ5VWUw?=
 =?utf-8?B?RlYrRXpVT3I4MzlGb2p5cSt0UE5EaUF2STNSeDBiS0JVUDNYVHFRMmx2RVBs?=
 =?utf-8?B?OXJXUVU0OTBncXpqUFY1MjR0TzFFa0lIY0NXcGNmM3NuQUEwWEZFVzA2eE84?=
 =?utf-8?B?Y0hUYTl4MzhqcEsrUXhhOVJNQjZ5ZUpLa0d1UFpJelU0bXZpaGt1OHEzUFZL?=
 =?utf-8?B?bEJYNXJBVjV4YWtWNklSaDlwc0RRN0h0MHBvTkcrdlp2Z0J4aEhncFF0bVJl?=
 =?utf-8?B?TEZSWHlyamJmL1RLcVpDbjYxK2ZkUUM0aWhEMGUrT0JvdDljMHNZbWJkY2V1?=
 =?utf-8?B?MXpHWjZaSVB0QWNhQlpsRFhHVDV6c1dZb2N4aFFuQnlMV2loc2J6OW03R0tu?=
 =?utf-8?B?NE9uUlI5bkRkVmpJTEpLWTh4cXgvbjBFTnpQNWdzck1mT0tmSklIdGorbjd4?=
 =?utf-8?B?aDNRWDVhRmk0aHBsM0tLazNGZ3hHMnF6WFhSVGp6QXRzNlJXS2IwdXNwVmFu?=
 =?utf-8?B?QUx1RHlueUtBd1NibzRzQTdGSHN6TTYwZnlQWHZJK2dFSFdVbGFuSmRicUVG?=
 =?utf-8?B?WDYxRXkyejgzNEVLcCtrTnJKc1M0KzJVOVExVXo4REZmTFZlcXhFUTAwZFhz?=
 =?utf-8?B?RUpQRzROdVRhdmhQM2FxUHI0ZXBYbTJGaFZ6K09wZm9tdjV5SkhwT0tERUU3?=
 =?utf-8?B?MWlTR293ejhiUnQzMTM2MjF5NDRwaVdaSS9HQS9VYVJWWXlVVXFOc2VMRThQ?=
 =?utf-8?B?L2UrMWNEZTAvT05FY1JCbzRYdDFZS0xRcnlvbzhvb21yc3oxYmZjSU5iQ1Jk?=
 =?utf-8?B?TVpWU3MyR1J4SWhkUmtUU1Boa0JIbU56VW5JcWVkYXgzYmtvU1JVT0NQREc0?=
 =?utf-8?B?QlNMd1lMWGV0MWxxamFERzhPbm1vY2NHUGUyc3orSEZVR0YwQSs5MkZMMUJv?=
 =?utf-8?B?QWNlRVp5NGFxYTNQR25ZbFBJRGtmRmJLdG0zbHJzNXg0ZC9lYUhua3MxWW5P?=
 =?utf-8?B?anZRb2tFR1ZhTGQ1d2lyNElUWkJwcWRYUWcwN2tNVlZuOWUwL3k2UyszYWxy?=
 =?utf-8?B?K3hiWjNGcWVBd215SnZUSTI4Z2lqOEVUTVpVSVN0WTY3ek5ZeU91V0ZoNUUx?=
 =?utf-8?B?SlhUblBNMEdGWHZWekFIM0lQeUMzMUpNQWdPNEM5dlBJU2dFMzlNbEhMeFhD?=
 =?utf-8?B?RG1uZ0FveXJUUjhLMnVkUjJYT3Q3eXM5NU9ZcGpyZy9HeXpEdDZnaHJMN0dK?=
 =?utf-8?B?bUk4VGpIZFVZdlhiVDlzZVJqSnV3UUhRbm9PMzVTTXAxb3BZUW5GY2NGdjUw?=
 =?utf-8?B?MnBrS3dxalBoM1lWcVMxbjdydkp4TDY0MWJlUnZZRldRUnd4S0FxRS9PTzNP?=
 =?utf-8?B?RGYzbVFrWnI5Y2kxWFQycENFaCtESUdCeE9BRVFFUUVaTmZvR1JpRStaY0pM?=
 =?utf-8?B?d2c1N0sxZGxtcFFOY0ZPM1Bla3RvVmF0L3ZxK1JscXkvTFpSNUVFVnk1S0Jq?=
 =?utf-8?B?elJpZHRxUkltY0M0NkszRG9JaC9uWmJXbFpad0tjU2I0M2t1aHFBZTQyaTZj?=
 =?utf-8?B?Q0JSS2FRbkZZb3BSSFRRUjhhSVJXY0xzU0YzMVpvOWNXMVFsTlZwTzR3L1JD?=
 =?utf-8?B?T21CMGhGSFhzNDFxUmZCbmUrL1NNZjVyUHN3NGszVTcreUpZak1pVFlmVy9r?=
 =?utf-8?B?ZExIZGh3MFN1bkNaRFhRVm8wU0pPTTlCQTNSWmk2RC9OUm1LbUU4bFUzcS9x?=
 =?utf-8?B?WWxPbEJyR0ZSUUloWlhzMkt5T1F0aW4vRkJqKzZ6dmJrckM0QXpDNjlTNFNJ?=
 =?utf-8?B?K2tSUEJHd25nS2VxNEpka3dSY0FxNjUzUFVnM01NV0l4Rk9jTVZPRnpzanh2?=
 =?utf-8?Q?S3rTYfVGqgNwwUNGB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f52321a-7f88-4311-7c42-08df4419c782
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:42:42.4665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdTL9gQ1PXpm6ndjLf0paz3XOdzisgp44xQ9fbM4MkZ3XOZzVjOt132s6EVj9DNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 16:24, Mario Limonciello wrote:
> On 11/16/26 09:04, Christian König wrote:
>> Hi Tharshan,
>>
>> the idea looks good in general, but could be simplified a bit by waiting for the VM to be idle.
>>
>> Question is why don't we already have that? Or do we already have that somewhere else? I'm pretty sure that waiting for all submissions before S3 should already been implemented somewhere.
>>
>> Adding Mario to answer that question, he has been working on suspend/resume quite a lot recently.
> 
> I thought we had something like this, but looking through the code base it seems not (or I missed it).
> 
> I think it's the wrong kind of patch though.  I believe we should use some of the existing flush functions and do it at the same time that we evict resources.  Something like this (attached).

Please drop the timeout, keep in mind that we should always wait forever for dma_fences.

Apart from that looks reasonable to me,
Christian.

> 
> Can you see if this also helps?
> 
>>
>> Adding Vitaly to double check if we have already a test case for that.
>>
>> Thanks,
>> Christian.
>>
>> On 11/13/26 17:44, Thothiralingam, Logatharshan wrote:
>>> AMD General
>>>
>>>
>>> Hi,
>>>
>>>  
>>> Please help me review the attached patch.
>>>
>>>  
>>> A gfx hang that occurs 2 out of 400 times when performing S3 cycles. The issue is seen with the kernel version 6.18.8 and on AMD hardware; Picasso gfx9 APU.
>>>
>>>  
>>> When going to S3 suspend, the driver checks whether GPU has completed its tasks, but it doesn’t wait for jobs that are submitted to the scheduler. As a result, queued up jobs slip into the ring and are lost when WPTR is set to 0. On wake up, we hit a timeout followed by a hang.
>>>
>>>   
>>> The fix is to wait for all scheduled task to finish before going to S3. I tested the patch and the issue is not seen again.
>>>
>>>  
>>>  
>>> Thanks,
>>>
>>> Tharshan
>>>
>>


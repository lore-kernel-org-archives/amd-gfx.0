Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FC6C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADC610EE7D;
	Thu, 30 Mar 2023 14:12:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBEB10EE59
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8RA6yLhhUpcPKUUpua0gA4A8RmlxQiKs9zbA8/Kc+t8NPVgq4rSHQwpg/cmhT6VazPkhf+7YZRNuJJQUtJndsutgY7iI68SZhLEWd3pI3QB8fXZYG9pV8LYPkSB1K+SGJSwiMbybcJF5UiVWCvlMg/ygIIcnuqVm6fHx07xzGSFxf0DufdzkYgp3UCpgeLbB5hEPEMFVPB8YI4Modyu6qi3tlU2aBH2e78c1HED/WypQargZIi2fLfZ47CHqWD9uZqr7y6FtEA5M1XsQJSWVq7V4xT4D/Tau9JqFrquX7WkF+BtYZbGXy5WXZdEUbGlzKtqbOmnDR0ds+/mkenDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvFwlGmO5GPjandavUBr6IDrbxJBg5ZfUaWurgr3IWM=;
 b=f1ZArMdNFrLfx5J8q3lvThuQvyqaLaz4jywez8OOmDUA/9talSUwpVcJViKOe4/IQbAchNYOIdyjvPcDEQ8EV1DuX40+14JwrKIzRbvdN4WKeHaeRFp7NBDJQGmrLnxGLYC2YvmjeVFlwQLNe19WMSG3I3s6PSUsCxx/e11ChpVVwJqJNl1w0IXDVveEAstECDas4xdAQwmONDxTrhWfDawk1uzHmygHrI6bJ6xC3js5g9K5I0XRWYYFbWPD8d6+Lv8CbORcMOXcV3Dk2Wwl6uIIbDLWVSs60ibzR5dZpFAA67DdYw3kXRnGDRY2UJ7SjKCsIeZygN7yROxXA0wVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvFwlGmO5GPjandavUBr6IDrbxJBg5ZfUaWurgr3IWM=;
 b=OSMXDw3jmsKcZxVHiBIFfH4RX6sfsH5p7eEOvSeJe8n9mbvJvMtEars21ILb3OeAyh5Xi3yG1WwkY4nOcsNVSmh8CCLKbVos2pvzRHQMOWWbrnjXkvlVqMyHhBDwUacBMFLMaIAnQXU0hqlsEGa4r8kr8Vg3Zw9cx+P05yzcCkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 14:12:24 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:12:24 +0000
Message-ID: <a9a398e4-847c-fc99-370c-e641fc49ed80@amd.com>
Date: Thu, 30 Mar 2023 10:12:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
 <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
 <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
 <274d9875-33dd-d9f4-ffd9-8a0b317af4d3@amd.com>
 <38c93185-7c06-4868-facc-2d107e60e8ea@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
In-Reply-To: <38c93185-7c06-4868-facc-2d107e60e8ea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8545a646-cc7f-4c3e-86eb-08db3128c90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3z2Lir4YyCrpsRG/jAoRebeiXuaeTS6TNGvmNQcE439blIwFRBBgrmCIJXKFvxtbjIkjt5iJd/yKqMEIUWfS9Il/H27zUjgGiBdy20NMuDArw9Cy/+KRRegAxukseiZldFW4lo6lQnXWyA2tY/spgQr9x0jbndUUFLUtXnSDOI+pCvTly5ktY89hPnDJQ7noK7lJzf+UtphEf0yKRNrqhKu2XJPd5z/jS2vPs5HX4tqmf5xiE2IyujyHmGKUpxfd+Rv4KbizYjC44eX5aZ++DjMxoWjXz2lxf2VS0g9mMYkwZAtUdxkF5Xl0QFi3GAUzbYe/AoIcjmHxXvjQ1eLzgDH7B1zEfAZnstTeH+Yy7MtKdZwImgUzu2navARf51mQjVVShJMBQgSwvbf6SUL5MSigGlyGtiYlzwMFx0o80DCuVeHPpB8mH1NBkgzSPkjib2NydThrYOL+2he1wgqGF1Dp/yewJAbVdlJHHLhxDHGe+UhPVXJcaissvonRzv8GYYsnJFl18tmn+r2iCFsm6lzaqD0xPcDXfGuup6swHOLpOecXGZP42otsaygUxnGqQCvPLsxiPP90huF8Ob3hil9j7nRd4QOvZNuhAkTIDvrDuddfVUCyoyhfaALLU46HPSqe0QbAdBFG0g9imDEChy2SJ1t9D+yEh1WQ13f3qY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(6486002)(966005)(478600001)(66574015)(83380400001)(6506007)(6512007)(53546011)(26005)(36756003)(186003)(2616005)(38100700002)(86362001)(31696002)(6666004)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(44832011)(8936002)(31686004)(5660300002)(41300700001)(54906003)(316002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9HUW9SRlBxVThWeWFGclV1NXNmTVM0N2E3UkhlalNIM2Yza2dicExZdkR2?=
 =?utf-8?B?OWM0cWpSOXZoSDkydUd4TG5mUGZSUWxUZVFsVG8xL3hXbWFUWnRLb3BNR0xH?=
 =?utf-8?B?dVNpbjZ0OFUxVFJNVjNBeGU2eUlmT3ZpYXZPRUEwWnN1bGc1Nkc3YjdtVEFI?=
 =?utf-8?B?WjVKeGsweS9FZWVoQ25NakxoWVpXTk9GVTNJaG40KzdHSDkyMHhvUldJc04z?=
 =?utf-8?B?OHVBT2pQTDQ5U2lmeHhybmMvaFR4elNzNnVDYytUeElWYzlPT0U2eVlITVUy?=
 =?utf-8?B?a3B0SGtkWTlXejMyRTh0QXA2Zjh1ZVprUTZIVHl6VFJ0eEdCUHRUcFpzR0xY?=
 =?utf-8?B?dDZiRjdjUlNmTDFJam5YaE5BMVZKeG5GWlVadzVSb2xkVmNscjBHRGVmVU9t?=
 =?utf-8?B?YUF0bjRPWlNIdWNRdy9IYW9uQjdacEVsVkZuZldKcU1ydEVodUk0aE8wUHQz?=
 =?utf-8?B?ajJpbytUV1Q2NDlONGNYb0FlTHFVSjhlYi95R2o0ZnJRdGFreXp5VGUwbEVH?=
 =?utf-8?B?b3F6cm9ZbXQ2OXJRL3VrSE8rTkdDNFYwQWhyc3dPbXNhVWFEb2M5aEsvdk1y?=
 =?utf-8?B?dEVncGVWbVF1V1BkRDB6dkQ0Yi9FSm5zYVpDR3A3ZzFoNysxdU1wN1lzbzhl?=
 =?utf-8?B?b3o0NGlFV3kyaDBFS1EyVjYwNFo0elE0cHZ6ZXlqekErb3MrQytLSnhMWisx?=
 =?utf-8?B?NjR0aWNzS2QvYy91ZnFrcGp1R2dwMEZ1d2V0ejgvSGRDeDY4MGs4MGpPRmdK?=
 =?utf-8?B?OUM0WmRZa3FtZXMvWmdyTFZDSnhVWFh0aDRJZ3hQYjBWK05sbEFGakhRU3c3?=
 =?utf-8?B?TUJXb0RDMVVyZUZWdmw5Um9nWTI1cG9KbDNYNFhLK3lvRDBPcnBZTC9IWHpw?=
 =?utf-8?B?WDhLZDViSmluVHlXd2hUaXR0TGNnVlQ5Vi9vY2Q4SEdsV0ZIdjR3dGd1NVh1?=
 =?utf-8?B?WjMrYWRLdW8rYy9Td01IYU9vdHMrNmFXbkVLMjBQNkZTQUlqWnNjN1htV0pm?=
 =?utf-8?B?OXdObjlHY0RPUE5keEJFYlhjSmw2dFNnK3hmT1A0RFBLU1N2Y1lIQ284M2xV?=
 =?utf-8?B?RzUzcmNiUUxiUGFoNHA3Y0pkOFByRnJ5bU5Bbk0vUnAvang1QnMxc1lFeWEx?=
 =?utf-8?B?bXA2SFYzZ2JSK0lhUTVSZGF4UGxtWFdCK21XeEMzRStxb1JVTkEvTWVrK05q?=
 =?utf-8?B?VVdxWkh1ZUJMZHdrcFNxU2s2aW1KZlBxaWZsOUd6MGUxT3IxNldPYmVtQzhu?=
 =?utf-8?B?U0dWa0JuWGZyeE9FL2F4dzZ4UkkvbHdtdWViYnA1Z01GNTFwUlRlVVNYSUJB?=
 =?utf-8?B?eEZOWURYaTE0Z25udGt5emJrczUxekprMDU0MlRkTFJMQXZHY1AzUkdsUDZV?=
 =?utf-8?B?WW9xQ1FtSmNqUXNocHdCak5SK1cxS0ltL2pYTTlrTG5idXAyVCtTRmRYajRU?=
 =?utf-8?B?OW5KTmNESzhzZ0dySFZNY1Y1Zk5kNE5Gd0NscVFRakF1dGFkL21hNHUxR1hi?=
 =?utf-8?B?a2o4Yk81RWcyWHNLLzk0TEZsMHNIS1pVMVg3VWVDa1BiOWorMnJIVmU1cUor?=
 =?utf-8?B?c25Vb3AwZ2dMRnprYVR2a2k2dXBoN1BBbERiUWdzTE51WllGd010MDEzbWJI?=
 =?utf-8?B?cmtrZHR2cFRMQ0taRXFkNGpmeTFqZzI4Rzg3V1hsYTlhb3F3a3JhL01RSWJ1?=
 =?utf-8?B?UWFQTnNjRVA2c3hubVRsVEd0cEFrSUhZNjcwK1B6UEVFODByUk5rdTEzNTBm?=
 =?utf-8?B?S2dGd0VvRkg1Rk9VSXlubnFJMXp2bU9Qb1dMWW84UUpSaVExL3ZVTm5IN1Jh?=
 =?utf-8?B?QWQwLzFqUENYZGlQMXM2SWIzdzZwd2pWaU9HdTZkaUZYVE9HRWZYaGZBYXRm?=
 =?utf-8?B?dktGc1VYKy9ZMGhmMlJ5anBpUnNDRjB1UU5OK0xwMCtXV2EvNW5KMElhRi9I?=
 =?utf-8?B?V080cVVGbWQvaEVqVW5oSjh1MEF0bEFDTDhzWEFqRFJFbys2em5qT0JIY0Zo?=
 =?utf-8?B?NDc0MHY1c3d1RFQ3L2k3bW5nV051Sk9DcXYzYlFnMWIySEVEdzIzbUQ5Rmpp?=
 =?utf-8?B?alFMSThUWEt2VktMM3lURVZHZ3ZtSE5Ec1JDY3hFWDkrSUpPcTBEeWwzNjdH?=
 =?utf-8?Q?Mdz5f259Ota++Ad8I0L+ShgqA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545a646-cc7f-4c3e-86eb-08db3128c90c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:12:24.6098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgIhcJatlCUbg0L2VJclcR7wlmmn3eq16gEMLN4I0TEXD5lWtVvNKBEv+dqfrTT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 09:48, Shashank Sharma wrote:
> 
> On 30/03/2023 15:45, Luben Tuikov wrote:
>> On 2023-03-30 09:43, Shashank Sharma wrote:
>>> On 30/03/2023 15:33, Luben Tuikov wrote:
>>>> On 2023-03-30 07:14, Christian König wrote:
>>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>
>>>>>> This patch adds changes:
>>>>>> - to accommodate the new GEM domain DOORBELL
>>>>>> - to accommodate the new TTM PL DOORBELL
>>>>>>
>>>>>> in order to manage doorbell pages as GEM object.
>>>>>>
>>>>>> V2: Addressed reviwe comments from Christian
>>>>>>        - drop the doorbell changes for pinning/unpinning
>>>>>>        - drop the doorbell changes for dma-buf map
>>>>>>        - drop the doorbell changes for sgt
>>>>>>        - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>>>        - add caching type for doorbell
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> Generally there are no empty lines in the tag list. Perhaps remove it?
>>> I would prefer to keep it, to highlight the CC parts.
>> I've never seen a commit with them separated. Perhaps follow Linux custom?
> 
> IIRC This is not against Linux patch formatting/message body guidelines.

The tag list forms a block, a paragraph, which is easy to scan and separate out
of the description of the patch, which in itself can have many paragraphs separated
by white lines: subject line, paragraph 1, paragraph 2, ..., paragraph of tags.
Furthermore these tags are added/appended by automated scripts/tools which wouldn't
add an empty line.

Check out the following resources:
https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format

"git log -- drivers/gpu/drm/." is also a very helpful reference to see some good patch formatting.

Please remove the empty line between the Cc and Sob lines, so it forms a tag paragraph.

Regards,
Luben


> 
> - Shashank
> 
>> Regards,
>> Luben
>>
>>> - Shashank
>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>>>>>     4 files changed, 28 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index 4e684c2afc70..0ec080e240ad 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>>>>>     		c++;
>>>>>>     	}
>>>>>>     
>>>>>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>>>> +		places[c].fpfn = 0;
>>>>>> +		places[c].lpfn = 0;
>>>>>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>>>> +		places[c].flags = 0;
>>>>>> +		c++;
>>>>>> +	}
>>>>>> +
>>>>>>     	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>>>     		places[c].fpfn = 0;
>>>>>>     		places[c].lpfn = 0;
>>>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>>>     		goto fail;
>>>>>>     	}
>>>>>>     
>>>>>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>>>>>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>>>     	return true;
>>>>>>     
>>>>>>     fail:
>>>>>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>>     	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>>>     		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>>     	}
>>>>>> +
>>>>> Unrelated newline, probably just a leftover.
>>>>>
>>>>> Apart from that the patch is Reviewed-by: Christian König
>>>>> <christian.koenig@amd.com>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>     }
>>>>>>     
>>>>>>     static const char *amdgpu_vram_names[] = {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>> index 5c4f93ee0c57..3c988cc406e4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>>>>>     		cur->node = block;
>>>>>>     		break;
>>>>>>     	case TTM_PL_TT:
>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>     		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>>>>>     		while (start >= node->size << PAGE_SHIFT)
>>>>>>     			start -= node++->size << PAGE_SHIFT;
>>>>>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>>>>>     		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>>>>>     		break;
>>>>>>     	case TTM_PL_TT:
>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>     		node = cur->node;
>>>>>>     
>>>>>>     		cur->node = ++node;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 55e0284b2bdd..6f61491ef3dd 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>>>>>     	case AMDGPU_PL_GDS:
>>>>>>     	case AMDGPU_PL_GWS:
>>>>>>     	case AMDGPU_PL_OA:
>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>     		placement->num_placement = 0;
>>>>>>     		placement->num_busy_placement = 0;
>>>>>>     		return;
>>>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>>>     	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>     	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>>     	    old_mem->mem_type == AMDGPU_PL_OA ||
>>>>>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>     	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>     	    new_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>>>>>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>>>>>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>>     		/* Nothing to save here */
>>>>>>     		ttm_bo_move_null(bo, new_mem);
>>>>>>     		goto out;
>>>>>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>>>>>     		mem->bus.offset += adev->gmc.aper_base;
>>>>>>     		mem->bus.is_iomem = true;
>>>>>>     		break;
>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>>>>>> +		mem->bus.offset += adev->doorbell.base;
>>>>>> +		mem->bus.is_iomem = true;
>>>>>> +		mem->bus.caching = ttm_uncached;
>>>>>> +		break;
>>>>>>     	default:
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>>>>>     
>>>>>>     	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>>>>>     			 &cursor);
>>>>>> +
>>>>>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>>>>>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>>>>>> +
>>>>>>     	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>>>>>     }
>>>>>>     
>>>>>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>>>>>     		flags |= AMDGPU_PTE_VALID;
>>>>>>     
>>>>>>     	if (mem && (mem->mem_type == TTM_PL_TT ||
>>>>>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>     		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>>     		flags |= AMDGPU_PTE_SYSTEM;
>>>>>>     
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> index e2cd5894afc9..761cd6b2b942 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> @@ -33,6 +33,7 @@
>>>>>>     #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>>>>>     #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>>>>>     #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>>>>>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>>>>>     
>>>>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>>>>     #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2


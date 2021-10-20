Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B430E611CC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B430E611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514776E3DB;
	Wed, 20 Oct 2021 22:09:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDBA6E3DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 22:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dpa64hAZHbiDlBKfNgFu/B1QcXFCVrCFQfjpJOwcit/5HzIIKxYEGA4EiMR0hWwyKLJAMDk1Xu+er1/kn4XTXEh4DtwjmKFjsU1GtqzYA82YQ/XYFXFXfj+6rdmezqrikyv4s5zQNSpLCbX2Bg+HFUUajoLN21XixIzYwXz/2RF5Vz5GLsYHNXGDysvRRu7b9H4qTWwGjkD7n9cR5vaEhq18JDMQXueAF5WrQAUp3hDvPRK5rX/IubPGucnFeCK+3rOORftWmuP0ocTcgIPChdlzQGUmWIRCwKhxht+V2rRbj+Fz3tK4qR3U37p/Xz8LhAPSeQxKldjh06iPM4hF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rALEfvZZO2Km7uJoI+HQbejl2Q4ej+3YGKg8DUmJWrw=;
 b=GsKG/QDOJesgSrzQ7lM4gqKWyMCQlkviusuBhuFdd18lBqF6nDjCFCsbYy1Mv24yt9annS5wacBUgAlT3Z7z4KBkg9k9vpW+8Gv/znTLlze6qT+AKfjLj/JqFWmRpa7Yxoto0dOQl6ebXUZgWC+HJqtuklz/wSRRSKjNU8TGwK4EA/It98J7hFsO11n0WYceuTEAjivyasxlEh4Amtt0t8zideRzaO4rVzDMlU8VOlAcjcehIOIFAyYwBcf27SDAdx/huFEfAxu0uWro5KhLq/zE9jYz3fLohh3d95d7uTumum6gse7EsjtUcciBOzCgwIcfwZPSvFNfHoU+jGgz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rALEfvZZO2Km7uJoI+HQbejl2Q4ej+3YGKg8DUmJWrw=;
 b=TBNSZnRykjPANybYx9Sb3XH7ZsO91KMTacVDOpTqYRkU0uNKnJSTGlpdW0bG2tFpmLyGIqs0QliV0q3y4CrvmntI7mHw2j/1Tl9mI4BS12erWR22PDGX/m7k/r1N6le5eeTxM9v+sZkny0GjtzydXAKZFSbkByMhDzwFxS9JOa4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3691.namprd12.prod.outlook.com (2603:10b6:5:1c5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 22:09:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 22:09:24 +0000
Message-ID: <f00f4627-4945-4a69-7330-566ed740e454@amd.com>
Date: Wed, 20 Oct 2021 18:09:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Russell, Kent" <Kent.Russell@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <50882392-beb7-b7bc-01c9-04945ffdec00@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <50882392-beb7-b7bc-01c9-04945ffdec00@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 22:09:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8244023-dd69-4044-1e95-08d994164675
X-MS-TrafficTypeDiagnostic: DM6PR12MB3691:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3691D4F295940DF37CEBAE4099BE9@DM6PR12MB3691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+5QVWjtDLiOw9tm3njrarHt7grr0MLe6Bicu4ImWeTF4pyUiBHNA+D0jAnImbpjV0TPsDnnpivna9TSsOOztII8ACQI44dhO5wSr+vQUAk8mqT+dsdnGzcEWzL/SfwIyCz/tgFH8ML81wAI/GV5gEnD7+3sk8TVWs/2iqaboUH/l1L6RsJVSqq0tMfHKMfKA8PYdMG+IhulpQmjghAuLsayoO5IDqqwtAsayrMKDbmfEsAp/t+M14+8fA1muigyYitguChSte+H6weNAmakcaMzPbsI0uJ8bug6pPZvx5mgJWRD2UJBEQhePmpsitHwvaE2wOSWC4+ZRo4DAPsbLHzhuDa8J96O8HBhOlexiN31oabLVygelF6nYogxzsLiomRXBY/UtMeViYB6aY3XSMMwqdCFApyXBrGyelhY7L9jfvE6/WTKewLFP8wwLycdSaJvSy2rTqP8oKkLZvoWQJU5CuxbrnLYSFxWM8eQoy4hC1qDwfdqoeayP0zvaPx0rdKdoD1ydYtJq4va2I0ek0QHRlUfdZ18iSf4To6irCNDZKgbdjlm3PjjhZJiJqDmHk61gyNoYD1x9QviPphXrL5bCcTBSaTt2VhPXf4VUji+znyFshm4tRHkjo78RiMyLfmRjKv5+UIpSBK8nxslNkqzn/OCQYET1Af3s8PwO0h4H2K8g+X5Z00UBCnpLs5ze8HhRqRjsG35xuyhJ1nSC8M+viBOVFOGykUz0bkyLJMYOsT2I8PPy6yrZfPZU0bK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(2906002)(38100700002)(5660300002)(83380400001)(66476007)(110136005)(316002)(16576012)(66556008)(66946007)(508600001)(4326008)(86362001)(956004)(8676002)(8936002)(53546011)(26005)(6636002)(36756003)(31686004)(6486002)(31696002)(2616005)(44832011)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkdDcnd2Q1NzRFZKYWpLa0FHNnBPaWJhRHJWZytKVCt5amJaWDVSRFFUTmJS?=
 =?utf-8?B?NEw0Y0JYbEV3VTY4dTBobkVRalJiZCsxbHczbGFtd3BocEpGdjFoaXc4VWRP?=
 =?utf-8?B?Qml5SjlLY3FZc1hGVUlaT1p1UE9QQXZKQXpmUTRyblpGUGVETXJsR3lFaXZT?=
 =?utf-8?B?VGpVbmhROWJxYkcwVU1uNVZQY3lqd01ZOGdEb1l4MmVmajNCZE1YZE9VNmFi?=
 =?utf-8?B?bHVmZy8rYWgvaTM1YUNIM2oxOEFIL1FhVnZHZGFkRlEyakF3RVNvL0ZMb2Q4?=
 =?utf-8?B?aVlTSTM0d1IyWUhoKzFtVFB5V1ZPSU9kcENyYWlnblk1K3NZOUV3NG1jTklR?=
 =?utf-8?B?SlpjRGN6a3BTL3FmKytRb3BHc3R1OG5SQnpjTnVTekJVcXM0eWhuVVk1YTRG?=
 =?utf-8?B?ODg0MXlBQUsvNGJYU01BYTkzS2xNZzVsYTBTN2tmakw1eVhHLzVSV0ZFU3R1?=
 =?utf-8?B?MC9hN0NmS0VMcE8xb0F0bFJ4NWd5S2xqS3VPRU9lZ3BYTkVxWCthSzNSOHNN?=
 =?utf-8?B?SG1xdU9IdzNhQTdBcHpLRlpPMy9lQkd6c01mU3oxQ3RocElVTG1Ya25BalNG?=
 =?utf-8?B?SUdUZUc1ekFTZEViTm1ZWGRKMit0NnNkRnhMMHZpM1FMTmhnVUQ5VzZxakIz?=
 =?utf-8?B?dGJBV1dWc0o5SWlnVWdlSnUxM2J5Ti93SWZMOWZFWERvNFpVNVVySWhTNXh6?=
 =?utf-8?B?eUlIUXF0ZFAzNHgzUjNPa3ZtajU1NjZyVkJYc2tFUDV0TTRmbFFldzhzc3BV?=
 =?utf-8?B?a2oyVWppN2xQc0JvaFV0WFBzMmo2UHV1dGMrUyszQStqYkhvT2NibjZZNlVi?=
 =?utf-8?B?N3JaU3ljaGhpM0VtMkk0d2xVT1AzWnJOUldHK1VTb29FWm1IR1lyaW1TRnFx?=
 =?utf-8?B?cm16aXI5Z0R4ZG85ZXFSZnI3cm85bVhhUzM1V0ozenBBUjRLRkpLdTRHNFBZ?=
 =?utf-8?B?TlIrZStiZkRXQ0JUVlo0M2hYZm9TMWUyRllseGpXOW1LY2NGTUtEbVRkTktW?=
 =?utf-8?B?ck9meWZPL3plYjdpK04yZzk0WEhhNGdpQTRkUDNYL05XczNDM2xTTWdxWTFk?=
 =?utf-8?B?UHptUjdQNXJ1eCtFYXVNaGRwWE9hcm1tMmNxeXp5TzJCSm9QQ0JweEQ3WHpp?=
 =?utf-8?B?WkpObWJRYi9Pbnd0UWZDMmdFbUtRZmczYUNwalJNNUlveEwwcnNxK3djMlpT?=
 =?utf-8?B?NUZIRVNMeXpwRFg5SjJmYVJVcXlmbVcwVm5GcDBuek5Qd1BQd2RQU0tRRlg5?=
 =?utf-8?B?U0FacmlrNHZzYzBkVXlSWGNDSDdya1BYL29IMWk3UDVaSVhmWVhocS9pNHB5?=
 =?utf-8?B?RFpXdk02eXE1U2l5SGNzQkFtYldSa3N3UzZDRklUYnp6RGdvTk43TC9vTjRE?=
 =?utf-8?B?RlZRZXh5TSsyL1pkZ3B5aWE4elVxbGlkSThXYXpmOFphaEt3cGFQMUtzeU9s?=
 =?utf-8?B?MVlTVDdWSTdvSVBQRWVmM2hIdEtwOUxhMlNncnU4dTlOTUc0TXBWZXM3UzVP?=
 =?utf-8?B?VjN1WGQvTzNDckpSVndnUjl0MitjbnNpQm1TTXNzRmE5b1VUWFN4UWs1QlUw?=
 =?utf-8?B?c1pBbjFTbVJGRXZOK05lM0haei9jSnpZSEkxT0trd3QwRm9XeWZEeGd3bXhO?=
 =?utf-8?B?M0FyUGxoUzFzbkRFYUM5K2hSdlFZZ0F1QktWL3ltMHY5TXRHZXFLZStpSG9F?=
 =?utf-8?B?dEMxcXI4bW15TnZrRU04N3h1KzRtMHZLaVJmZG9MOUFkTGZkY1NBdXRmSzZW?=
 =?utf-8?Q?qOUu2TwnJyFWta5/x7lQxXY0ADM78pEHRPehjfF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8244023-dd69-4044-1e95-08d994164675
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 22:09:24.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLZtaQo8tMDJv8fns2Ca3Km9hctaB405ALWxiuH0mSSruTEwXS6rqY6mOcTlnDBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3691
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

On 2021-10-20 17:50, Felix Kuehling wrote:
> On 2021-10-20 12:35 p.m., Kent Russell wrote:
>> Currently dmesg doesn't warn when the number of bad pages approaches the
>> threshold for page retirement. WARN when the number of bad pages
>> is at 90% or greater for easier checks and planning, instead of waiting
>> until the GPU is full of bad pages
>>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index f4c05ff4b26c..1ede0f0d6f55 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>>   	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
>>   
>>   	if (hdr->header == RAS_TABLE_HDR_VAL) {
>> +		int threshold = 0;
> ras->bad_page_cnt_threshold is uint32_t. I'd recommend using the same 
> type. Also add an empty line after the declaration to avoid a checkpatch 
> warning.
>
>
>>   		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
>>   				 control->ras_num_recs);
>>   		res = __verify_ras_table_checksum(control);
>>   		if (res)
>>   			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>   				  res);
>> +
>> +		/* threshold = 0 means that page retirement is disabled, while
>> +		 * threshold = -1 means default behaviour
>> +		 */
>> +		if (amdgpu_bad_page_threshold == -1)
>> +			threshold = ras->bad_page_cnt_threshold;
>> +		else if (amdgpu_bad_page_threshold > 0)
>> +			threshold = amdgpu_bad_page_threshold;
>> +
>> +		/* Since multiplcation is transitive, a = 9b/10 is the same
>> +		 * as 10a = 9b. Use this for our 90% limit to avoid rounding
>> +		 */
>> +		if (threshold > 0 && ((control->ras_num_recs * 10) >= (threshold * 9)))
> Not sure how big these values can get, but you may need to cast to 
> (uint64_t) before the multiplications to avoid overflows. Alternatively 
> you could use (control->ras_num_recs / 9 >= threshold / 10). It'll 
> round, but never overflow.

I sincerely hope that by the time those values overflow multiplication by 10, AI has taken over the planet. :-)
Avoiding rounding is preferable, since we deal with integers, and for small pages... could we get 0s after division? (if the page limit is 1 :-) )
(I think squashing numbers less than 10 to 0 is a bad idea, so as not to get false positives here on small numbers.)

Even for a 32-bit word size: can we be within 3 bits of 2^32? A value of 2^29? That's a lot of pages! Actually the number of pages of VRAM is *a lot smaller* than the number of pages we fit in a typical EEPROM we put with our parts. I think we're safe.

>
>
>> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
> Nitpick: I'd add space after the two colons for readability. The 
> threshold should use %u if you make it uint32_t. This can never be negative.

Aha, so that's exactly what I like "word:%q word:%q word:%q", so when I read it in the log, my eyes scan over it, on the spaces in between the word blocks. I prefer no spaces after the colon, so as to make scanning blocks (one has to squint to see it).

Regards,
Luben


>
> Regards,
>    Felix
>
>
>> +					control->ras_num_recs,
>> +					threshold);
>>   	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>   		   amdgpu_bad_page_threshold != 0) {
>>   		res = __verify_ras_table_checksum(control);


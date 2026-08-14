Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB556C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 20:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4850B10E850;
	Fri, 14 Aug 2026 20:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHe+hHT3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4974110F6EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 20:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP+4bJXCASd5daodzheYUIkxzuQF7llARE/1jIvG4I3g6V3QtAQkrf7XyfyjH8xyDxU5eaPzeOK2SepAk5fuRU0ToWcWtULvhGLqLuihby1NwabNa6FXIsR1PhamEmoSrKXbJIjxSusbobkYSKhAh7DZCmZ9KVD1A4hhX3EFeChaZsA1f+aFdfUnMoRBl8bJJGmrsEw0AZ/k873iw7ci6QvQGP7F6P6pVQgG7bGt4ZjZDHGvtySdoKg92RxPQYJ8GR0vu9+UIXXJ+mf4iDXqKzXTqOYemkiOHYSHDnJPZvG5te0EcR5Ou/U9uNqxyeyp2JvqfdgG5w9r0JuMbBZOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GfgEEQD9zp3Om7Tw+KMkBlAivwQVjLHN+Z++jcAs0c=;
 b=COtQdq9poaJjjbbxGCubzntbf7XwsYdwVmvqtmDWmPY648j0K3twHwk2x2lcdd/8KJmfUczlTRZ+Ly/N4wwcblBEfNr457bMjvvR4hyINScamRCmkGJ2JtjswT8cxtqRQ7/tt2ktEMccszHPhz9ZPg5CxpWuqA3gXPCZSC70fNuoCVVgpJysr0SrInIqYKb7c8p9DBlTb27GoD+1wfwfi8lHObvgdbFHq/VoBtR/ggErCxsgfvAxTAp516qm5VJfKID7Om8zKhs0Hflq17L6tTISb9Bx7Sh3gYfcs6tlqzf5drKNgc8NVpLQ23KlGtbubMnUF5a8VUjIpybDC4wIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GfgEEQD9zp3Om7Tw+KMkBlAivwQVjLHN+Z++jcAs0c=;
 b=LHe+hHT38kfiMswgv9R4yvUC8XNzGAKOlT5bNy2SRWn6cKxZOMgdPDq0ViIcQcEyv3Q5fdHp0ar/qUUL+6IiT/mx9xcajqPBXRO58ednmN6ZE05Ps+VBYhaOUPkS9Ls5mwU+1086iROR3VrhEeKX3XYRapH0ycbYE5rXXlYtEno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 20:41:38 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 20:41:38 +0000
Message-ID: <9bcea5ba-a5b7-4724-b6b6-3ec2df14c8b9@amd.com>
Date: Fri, 14 Aug 2026 16:41:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/amd/display: use a separate helper to
 translate degamma curves
To: Melissa Wen <mwen@igalia.com>, Alex Hung <alex.hung@amd.com>,
 airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 Xaver Hugl <xaver.hugl@kde.org>, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260623160112.1636801-1-mwen@igalia.com>
 <20260623160112.1636801-4-mwen@igalia.com>
 <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
 <690771f2-d540-4e8f-a450-6a1f00b8df9a@igalia.com>
 <68c132d8-bcae-4e61-ace3-2b9242aeb8c7@amd.com>
 <12426722-4220-40c3-bce3-69068569e6b1@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <12426722-4220-40c3-bce3-69068569e6b1@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::16) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5ffc71-7605-43c2-bdc7-08defa446ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: l35Xg33kY/hwqVvOyrh5V/4tlZrV3bESXGAg4JICdUadsPLb5K+kqwTxFASfvo2GrrZ7e9b220mYXs6fgfZX9CU9TJl7ENZmkQU1ZOQ9BLS/TJ/zsQA/+/Cu2FgypoX9nKQs4EvXjH6NLq0nAyFeWX5UGTP2b7cOTiS3LcK/bC+AlYFsP6SDFdwXewv6AKJAFHxkBZdX9wXDrDFpEyzqTaR+9e3TPEFcHHlvRldyYlU4OvzEqfH41V9zs/je83Db93aqwlyGOlJVV/Iej2SNWKD7NfoBWAQrJNMAh4mzJhbedpvYQIn49ZzbijFPeFW3kFo3JX3msAU2yvGiemCIqsfa07pBwPQuTRSmthtOfyClsCs3WMJL1M1dIkRS7E5/I+vOCJA+nDgwinPM94Vhh1cqtMXF10j0Eg5rKexXS/4v8AtlRAA7xlYulvayMHFUuHO37siEbeCZWekijAOHW1GDZMxyK5r4sybWwzLfKKXfGNDvVK7B542b+sn/r3wiPshiXLdd4mAtHC0G0vjLsiv0eTqBsssdWDRXjik4ESBcWh8bM6kgUJ8jr0ApNDUTZNeMTiN9aZMzYOFIYiQql3hsS7Mw5O5V+A7RmMHvU0eFT/f5YzxOnB9GeUwpfqdFQvK5npFlG6FZ/rq82v6DfBrgBK28ZoOfJ4CBTW7a5ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZRc1QyWUVCMEVoN1V6ZUFsMkpSSmNxTnptbGhrMVBOVzVKNXFwYWxuRUcr?=
 =?utf-8?B?b3c0MDV5bjUrSmpycDBaVHMxc2Ura3M0S3dTQWNoMWJmMnBJalNkTmtJcFRX?=
 =?utf-8?B?aHJ1UVp6dlFtdmpLRktRREhtQ0ZoQ28zR1dCb2pCZDdaRXlGRUFhdEFxVWRK?=
 =?utf-8?B?TTRVcHh2TWJudmM3MTNpOFJBemlVU3JqVnREdGVkcDZkVEtyb3N6bXNZeG5G?=
 =?utf-8?B?eURCMEpnTElTYXlkUmFqQWpxbDdaclh4S0NvR1BrVUpwVFBUekFxVUg5VHlw?=
 =?utf-8?B?U1lnS2hGQzNYZnNqL2NwRFVOelRLb1drQ0o2eEJIa2UvZGtZU3JmZDI2VjQy?=
 =?utf-8?B?YWc4cGhaa2Y2cThGZkNJdGdGTmZZeTlvRXpTZE5ncG1TeFljVmZpeTZuRFY1?=
 =?utf-8?B?UTd0VU1GNlJxWk9kcWIrU1B6Z3lzK0QyMmpnekp3TGM5a0F3cVJLZFd3K1Ny?=
 =?utf-8?B?NFhyRE5lYURmYmJnTXFnSFJWUWJrcVZSUHNjOVhjSVNMRzVKM0wrcU1CQXBa?=
 =?utf-8?B?Z0NkU2Z1NFh1SFI0bk9FK05hUHc0bVBwVUNHMUNLR1l0MGpFTGNZTm14eFJP?=
 =?utf-8?B?aHZTZm5pb3J5UDJ1aFZIaDYvaEl5NXpVcVdjeDdMb0IwUnpTZ05DMWRXVGRh?=
 =?utf-8?B?dk9ydHhJTEtMTXJ4YXcwZ3NsODFFVlJJb3I1UllQUG1ZTFA2dklxeGRpTERk?=
 =?utf-8?B?UVRmMFJiTnB5V0xpVU1lZFZUWXovZFNCRlEvbzJFc2RvamNwcTk4QXZ3a1Vq?=
 =?utf-8?B?WXppamMxcHhqQUhGODY1L3R6OFBHVHk1VmlXRWdkNWVhMjkvQU8wMkFOUmVP?=
 =?utf-8?B?MWxZSVF0Q2ttTWN1c0lHVmRuWGs1ZE9KK3dQMzBqeFVOanZaR05IVjFuYnIr?=
 =?utf-8?B?YXJrd3hMc25PMUJrajAxRDArUkFUMjVMYkQyN1hBelJXRi9kY3ZKNDY1Q2Y5?=
 =?utf-8?B?dFBpL3U2OWpZL0FoODRTei9ITGhxcG5nL0E1bFYwbGpuRUJpTzdsa09KMk1J?=
 =?utf-8?B?N1RuNjZXRlpRVThTQUh2dHhjcnQ5ODU5MHRiUlEyajJiVWcwcUd4NjhoRnd2?=
 =?utf-8?B?RnN4YjNHVGFsbXdDcHRTRWpwU1Z5czgvYW50RGxDcUJ5M2cxYjV0cy82V3VQ?=
 =?utf-8?B?VDFQM2pHLzZzU25lY21JZUwrM0U2RHlVQzBrdmhTKzY0ckd0Qmx1ZVJsbEJl?=
 =?utf-8?B?QWRxTk1tTk56V2s2bC9WcjB4cDJsSEp6OFovYlliM0NpR1dFeVNRYnA4QUxn?=
 =?utf-8?B?cEZsYjNJS0RjZ3VCUTVybU5NNGNweURZRDI5d3crN0V3Lzc1OURoMm1ZRndD?=
 =?utf-8?B?NlZJbS9NSUhDNkFpSkVLaUc3ZTJ4ekJWbW00d2t3YUgraGFSQkVXb3dyVkE2?=
 =?utf-8?B?L3RwbFRNdjd3SjBsNkRSTCtJSnhqTk85cGdyRHYramQxTys2QWlWeE12cmta?=
 =?utf-8?B?UTBSdzVZTzRoK3dSUjF3RDNmeUFmRXFjbXdIMUpKS2t1Tldhd3NZc1pxdktP?=
 =?utf-8?B?YU5kcWNMNDlteEFVSW0wNkVscVc2RzZhWklUYzlzNDZIVklFcnFER05DQ3BI?=
 =?utf-8?B?Tk1sOWtwR0ZSa0daWjBubnVmc0t1T3VDM0laNVNVZC9RSG5yWmxTd2tGY09S?=
 =?utf-8?B?S2tTUW56ajJhcFkvQzIzQmxWOW94VHlaLzBUWklUOTJqaEJTNmRqdVZxOTBN?=
 =?utf-8?B?QkpNeUk1TEJiZHR4dk5zTE9YSENIWFYwK0dNNGJUZEZMY1VYT2phUjdnVWMx?=
 =?utf-8?B?WGViNFJuV2c4a1p3Tk8xdjkwZ0l1bVZxTTRZbkJZUXpKSDR5UG5GZ0VzZkll?=
 =?utf-8?B?ZWVTdmZXQzA1eFliNDZ0bTJEYVZyb0F1dFJvcXZZdld3bXJqTGtESjZSQmpG?=
 =?utf-8?B?K0tIZmxUM094cmwydGpLUjIyWE96TUJVR2E5VzcvT1NzeE1XNkVtVm9vV0VV?=
 =?utf-8?B?b0tYYXZjenBxYVkwLzFqN01UdzYweVZmanlva3EzcWN0ZlI5amp3dTkzU2pN?=
 =?utf-8?B?cFFwaFlhMmZXZ0dZQXZxYk01S2JRNEJYMmJqL1JNdkdyd2NFb2djVE5aazJ5?=
 =?utf-8?B?cXFtWk1aZ1pBelhDOVhPbGxhUW4xeU81Y2xvOXdSOGcrNExSMUQ4Y3B3U3VX?=
 =?utf-8?B?NmErNnFZQW5ySkhkQk5OWHRwNDhib09BbUxjc2w3blh1RFllY0w5d0U4UFVI?=
 =?utf-8?B?UUsxMjBuK3gva3RIVU52UUtkVlZ1T0pHYUloUDR4SWNldm5ndmRtd0lZajNC?=
 =?utf-8?B?TnVPeE9hWjlkTHhWM2sraERNNnMrKzRsYWo3RWhNL3NyTFQ5L0w0T1FobEMz?=
 =?utf-8?B?RzUwUE9MbUNhbDhnQXdTOS94WFNVc3lxMUp5NVBXcnVTcmNCQkJBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5ffc71-7605-43c2-bdc7-08defa446ff2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:41:38.0775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/u+CB5navBZGsQGEC90qP6VQl3HM4R441YuP8dZdPODQ5w6hOJIkDtmNn+8JXnOykolI5/hy07EoB9cEBVMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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



On 2026-08-04 05:10, Melissa Wen wrote:
> 
> 
> On 01/08/2026 03:41, Alex Hung wrote:
>> I tested above on
>>  - DCN35 - issue fiexed
>>  - DCN401 - no issue and no regression.
>>
>> Does it pass DCN321 that you mentioned abouve?
> 
> Yes, with this change the kms_colorop passes on DCN321 and so far I don't see any visual regression on games.
> 
> I also checked that DCN2+ uses different CM helpers for degamma and gamma as well - but with 12 segments, which is the original distribution of _translate_curve_to_degamma_hw_format.
> Just to say that the proposed approach isn't new.
> 
>>
>> DCN301 doesn't use cm3_helper_translate_curve_to_degamma_hw_format() so it wasn't affected.
> 
> Oh my, I wasn't expecting that! Banding was affecting both DCN301 and DCN321.
> It was my fault, I overlooked DCN301, I'll extend the fix when we agree in the proper fix after Harry's review.
> 

The fix looks right to me. Values in non-linear space are essentially optimally distributed
already, so for a "degamma" operation we would want something close to a uniform distribution
of LUT entries. It makes no sense to use a distribution that's weighted toward dark values.
That is something we would want to do for linear to non-linear conversion, like the shaper,
which already uses a different function and presumably a non-uniform segment distribution.

So, in short, I agree this change is correct.

Once you put that in a patch feel free to add my
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Thanks for the feedback,
> 
> Melissa
> 
>>
>> The changes look good to me, but let's ask @Wentland, Harry for review too. 
> 


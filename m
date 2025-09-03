Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1924CCA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 11:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0E810E7A7;
	Wed,  3 Sep 2025 11:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zj4RqKnA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBB410E7A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 11:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3cNcR9lhWf7/Oa39ahoKpLKbV0NOyFtYszL1QGj3ScPhr1oqBABQod24CSw/FQt7Iidmb7xG0/XC7pp1De3OTpX5c4riBxoMrDE+c0QhhkDj7zR6fUrVXN/rDh/MmPPKAg/285MSeAQNYOrG7MKNSuXlm/pXVHbpHChcHWZKVjZSX0t6jg/xujfGWQWpnPjeinvXOYKe6R0NPB8ly6dW1kwFKfVs7SqA0IBTa+hxXaShm6Ke6xNJyZGgSKTE9lQnvccBJna9/12NKViX/U73Ahjkwk0Goamwbvu8POl0FsytyBHYd2YzGp9+GJiHmKks+TBgEdt/D8GR6WGYKFXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMK9jBYSxwT8R4+D3L//g2yC2nvyJMjjG1oHZ08DzHA=;
 b=zSVhFECowpkRw7H4UHSEp/w02XiWjWGop99bF3SA656BxzXCwn5t8yEQrErJ7uG/dN3lbqyvsV/d7p4EmXl8NUmmJ6PvsqFUYGLpzhKyh1TBrea6PrWzTptnZoFBQqkTR3bfnuduBNROTkpQXcuX+iigHOHzpsjEFAv4erlOeKiRHk1ePLDmgRfk7qoQUpyQFZHxlKszhI6N9rxJOEuh7IfcLHypYqRnfiOVeUJTwWpZc4JcmSshr5dz4UZ9BgAoTH5ICU8avzMpkt/HYDd8hwVYcPpUiqNI/ny3FIALRh+H42ee4/L8r6JpdoAlZxZKrOLuFIEbiG/BjKNsDqW32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMK9jBYSxwT8R4+D3L//g2yC2nvyJMjjG1oHZ08DzHA=;
 b=zj4RqKnAmQiEecvwX/ApBmeJiWO0J4ZgpP3DyqPlglDDR/veO8nNmNld1hepWl+l9KEQR02sIWHeCwrk+GvMyoSdWuKOQW42VZUGNygE5ZEqSd4EjiBs3jSnlImLsycIfWLEtnBgAyXqjKArPEHSpx3R0lU3UcCRaOYyI2bi9YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 11:44:46 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 11:44:46 +0000
Content-Type: multipart/alternative;
 boundary="------------Bw0CJCvrZ0PqofgrTcG4TK0n"
Message-ID: <10bcd2e4-864f-46ef-9cb1-520a4cf8b54d@amd.com>
Date: Wed, 3 Sep 2025 17:14:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
 <20250902145213.486199-9-srinivasan.shanmugam@amd.com>
 <fc8e033f-ad1b-4ea9-88ff-55b200f68ebf@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <fc8e033f-ad1b-4ea9-88ff-55b200f68ebf@amd.com>
X-ClientProxiedBy: PN3PEPF0000017D.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::48) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: d39aa94a-0261-481e-b4d4-08ddeadf4799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2EySVh6Rk5icitSamlsV2FVTDhucXNqQnJnOStsb0lKc1ErME9Sd0E4YURz?=
 =?utf-8?B?eVpNT1JBRTRIVkJLOGo3WVBWU2l0YTVPcVRUQWl6ckVmYVVNeXU4YXFCSExw?=
 =?utf-8?B?SjZvd3dFTU5SNmlmV0VIR1Q5SHFSdnNtWlFLU25kTnFic0lwcEt0aGlHVG1T?=
 =?utf-8?B?WCs2NGhYeUdlMnJKTGpxZWgzdWxaQUVtNXBwOFhIMXZRaGdIQjUzSGY3OGNz?=
 =?utf-8?B?dlRzM25YZkVHWDhGSURCNHNWNm8rWExTTUNMSlZkR0swOW5zeW9qVVNVU2Zv?=
 =?utf-8?B?b3phOFRsNlJCbFJrY3RzK3FRenNoNVVVWlZNeUszK3hJQXI3d2VTR2hMdkVI?=
 =?utf-8?B?R09tbHppQmJsMUN5dTM4bFN4dlBRZmVpYlNzNE5FbnByN2d6bEdaZkRZNS9I?=
 =?utf-8?B?NXUwTkFYUnFRRE9EUjd1RlByQWtSVnZSQUFkYTRsMkVEMHhObzJGZStZYkxt?=
 =?utf-8?B?SlFoK1kxYlN1cC9QVHBaQ2k5R1IwazJ0dUtNeStmZVk2MGo1YzI0QVlJK08y?=
 =?utf-8?B?OURJcGlnSkdUOExGZU5Vbm42RTV0T2hjMzUvN2NpMGtpMVNMSkhoeVlVOU5C?=
 =?utf-8?B?UVZ3VFEvMmhzL0s5ckhIMTl4Z1NOR2xqdGZtMGdlMXBZZm5LK3RlTi9QOHhl?=
 =?utf-8?B?QllqOXB2eXg0ZUlrVi9WMWJxQmEzUDJGbG9FbC9ybHQ4WmkzenZKNm9zeGhH?=
 =?utf-8?B?LzhaRDRFOEJQdTlrWFBuNUx5cDlHdmo4VEV1ZlBGVmhHcXlwZWVNbytZcEZ2?=
 =?utf-8?B?b3l6VmMwMWdBUmRIdW1CTUhOMDAwUWhVcHVnMFFVTDVvY2NTYWZSa3RqY01z?=
 =?utf-8?B?Slhwc3JFYWFrNFRta2Z6dnhoYUxaeW9FQi9HQzNsTTY3dURUYW5GYkpsdG9i?=
 =?utf-8?B?NFJPRUc5cWNVVHZuNUNOOXZEdkhvWlJxZEFMNXJvM0hSWnBpTVBkd2QreW9S?=
 =?utf-8?B?dHVGVkRZdUpvOGY0K3RWd09lUFJSanlIRmp6VGRZZWVtSHFOTm5WMlN5OW94?=
 =?utf-8?B?eGJZMHVndStURnYvWkliblBibXIyVTBaa1lyMWZUSHFlV3NkeU5WZkRLaEh2?=
 =?utf-8?B?U2ZXVHY3cHBlY2Y2NmUyQ2UwVURGYzdDclM5Z0ZMY21LaHZPQmllSGhkb2Rk?=
 =?utf-8?B?aDcxRGs0VjFZZ1hjUXRnaGhCZzNMTHVrMm43RkI0L2ZzNGJrZWFSVWdwUG14?=
 =?utf-8?B?dEpKS2VxS2ZHMHpTYmZHZGlkbDhDandRbk5TeE5CQ3VCM1FGVGliTE0rTFZv?=
 =?utf-8?B?c1dpRmE2OUVxSnhXcWJRMHQrWXJ5TTZ5czA5MmdJby9iTWt3QWVMRC9LUU5O?=
 =?utf-8?B?ZHlqVlVnTWFZa0twTVk2dmdXNlJaSXpxTC9ab0Vvc2MxR251ZHQ5YVQwY3Qv?=
 =?utf-8?B?MURXUjduRFBTR0VrNGE3UGlCVmhzWTdxYk9EU1pWekNqMk01eStBeGVLWHl1?=
 =?utf-8?B?ZG1FK2JLWmxHVlUzM25CMW96aHdMTkxBYUZ5cVdBb0xYai9SdjExbVVTbDFr?=
 =?utf-8?B?VGlEaG5EV1V3THNTRlBiM2lDNTRmUHRPbzVsRGFUM24rMW84MmFGNExTS1lv?=
 =?utf-8?B?Q2xYbGhINE43UU45a1BDMlRJK2RTVXI2MmNPUDJkMk5RNG9UdHJ1bjRvcml2?=
 =?utf-8?B?eEVNNzhBckEzcVdwUmtqVHpYSTdabk5tdW1pWVU2ZE1hQzNrTmNlejhWRlB3?=
 =?utf-8?B?Ulg5NmJlWkFzUjI1MmNaRDlGTk5tRGRDVitUVGhOR2V3NVVzRHhTdVgvb0h1?=
 =?utf-8?B?enZsSytFT1RRTU43MVRSUGxoUHBLT0xtUEc3TXZoN3RtMmErTExVVXQ2UkNH?=
 =?utf-8?B?ZVNlM0tiWmRvTm9TbWxKMm1SL2l2QXRGQXVya1QrYjFGS2hmTkJyQ003N0NF?=
 =?utf-8?B?SkdYYXl5aFJEeFoycHc2QXhZbWVDMlFDcGZudk5MOCtOUDhEdHRxYkxtSVhq?=
 =?utf-8?Q?PkUkwO1uxP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXp4bS9PN0xCU1d6dkNFaUh0YXQ0WW9vOFA2Qno4UkxTME44ajN5Nk1GbTNr?=
 =?utf-8?B?cWV3NktkQXloL2xyc0s0ZUgzVkM2czBRaHUzVHQxUk52ZTZvZ0puSGZMQTgv?=
 =?utf-8?B?WGptQlkzYkFKd05SVjlZU01VZUx4SFpieCtuR0xKbkZnTk5EdFNkQkM1UkRY?=
 =?utf-8?B?akp5MHNyR3JBcjA2ZzdYL2RnYWZVSG1KRllUNlNkTnBjVUVUUG1xcVBYYkJh?=
 =?utf-8?B?MXpvODY4WTFESVlERkg5b0toL3pVN3dzQTBrWkI1ZTl2WFpkNkkvVlNsVXJ1?=
 =?utf-8?B?SEU2cG5YcGt6OWNEL0JKL1VibGZtTCtyWVFGSjdMdjQ4MlNYZERSTFNjQjg5?=
 =?utf-8?B?R2RORy9ITllBV0ljVGdVV0VXWTd6YVpsUXhKdUhVT1BieGhtU05GbXZZTGRv?=
 =?utf-8?B?cVl5VGJFS1R3N1p2dXBwVFR3MGg4NGZxUXcrMDg2NHl1a2ZubzFMY3BuUFhl?=
 =?utf-8?B?WWZYeGRnUmkrVTVSZHJteHFESStLdnl2WEQzbS9aOXhhMWVRcXFrYlM2dHU1?=
 =?utf-8?B?SG5DdFozV3dZaFdYeWExdW1KUzJ5aUxHVkVXMENhQmJRV293ZytzNnBuS1Rk?=
 =?utf-8?B?ZXB2Q0IwWDVueVQxeFhxKzM3YnZrcE9lMXVBc1lmUWhUQzU2K3AxRUFTOUlw?=
 =?utf-8?B?NjcrVHh1bndwL1gxUDdpOGtXN3VXM1J4YUZWUVlNQW1qTlZJeEptcmk5VUZh?=
 =?utf-8?B?dmZOQjlJdGQxQVpVRWlXQUxRTGN6NloxOTlGWDgzeGRGNDhteXJ5cHZSbHJj?=
 =?utf-8?B?TjhEeVlKMjk2ajBhVlRtM2Q2UWhTVEpwN2lVNXpORUpndkRrNFJjWDZZNTEw?=
 =?utf-8?B?ZnNibUNuUXdBTDVzUjBCYkNKL2FGSmVRWWtDK2psTTdiK29pcmZuS0pEZ1ls?=
 =?utf-8?B?ZmhVb1M2bEMydkVyTDBaWWQyUStHQWEvYTdrR2xhbHhRcENsSGpvZUljdGli?=
 =?utf-8?B?M2dTRENqQy9GY01BV3JEOGU1aEVLT3BzZ3kwZldUMDNnUE8wSGY5YWtPMG55?=
 =?utf-8?B?WG94T1poWG1ZNyt2bmtlc3cvUW9xSUdhSlRCSnhia2cwVEZPQVRLS3VJODY5?=
 =?utf-8?B?bUxUQ0hFVHZTRzlVVW1idHVFU0YzTWFQQmZHYlBQamp6ZUtESHJESkpVZ2Rx?=
 =?utf-8?B?SEw4ZGwyWlRSMlVwN3JEM1JXMTFqUHNuMW41TUVBUCt2RFRqQUNjZGdEVGRx?=
 =?utf-8?B?WjYzR3lmVlF5TS9YNjBJTFhBTEhhMmc3OXNPdUswOFpvTXg0cHFkNVpObHdN?=
 =?utf-8?B?YWV0Y1dtR2xYZnhicFZCTVQrc2E0L0F2YkpZZGpGVytUb1ZhZURId3hpc3JM?=
 =?utf-8?B?SHFzd2J1Y3l4QWxBUWcvUDlYZjJydnczcVBydm1YZ2NUVjM0VFJvQUtxU1lt?=
 =?utf-8?B?YW1DS0dpSTNibjhCZXNnYUpGdjRhei9FZG10WXZlaXhOeGovUlRaaXhreUxR?=
 =?utf-8?B?N0N6NG5VRTYrb05SdXgwQ0tGNWdRYjhzNEdEZ3Y1dFRVZGNWWUtRNTN4Z2lM?=
 =?utf-8?B?OEVsRjV3MklaWEdzY08rQjU4QmZnZHU5VlB0Q01ITk9mVlMrUVVQSWRDL2gz?=
 =?utf-8?B?NjFyakVaSk5ESmJkWUptRjJITDhYTExPeXdveDM0T1NrTjBMZURMbWRJN1JB?=
 =?utf-8?B?eC9oemVDQlZ4MkR1c2JpUHliZmw3NERMVi9EazNnY0JBWSswb1ZMc3NpbUxj?=
 =?utf-8?B?aGIybjJIQzhNR1l1SWNrSDhDM1k0a2s3MVg4dERQSFRlSkt3M0Nxd3NTR0ky?=
 =?utf-8?B?UTMxNnlwL2RnclMyblV1QThSYXQ0QnJiOUhRRkRsOUM4UEd0Ui9zRkhIQndT?=
 =?utf-8?B?Tm1QazlsNUUvb3FwWnFReFVmUWNJV2NONFBpcGpGMDlVcHBQdFROV1h0WmVJ?=
 =?utf-8?B?QXZlVDZlSFFhL29xTWtOclEzSEJBSFdrdjNaUlVvcWRFSW1Kc1NFanJIcGNs?=
 =?utf-8?B?cUQ3NmZjM2hXZGpZR2ZXelZnSm1nVElrQmlYZncxSUxFb1JYYmRqUWhSclA5?=
 =?utf-8?B?bEh0RWJkTkp2alYxU0JpM1Y0TG0zZjFHMDR0TGcrRG1ZZ1dtb0VkbmVxN2Vw?=
 =?utf-8?B?TzZTNktlZyswcXFVSEZESWNuY3hGelFSaFpRdUQwNVFJR2dERTNiZGVnaWF5?=
 =?utf-8?Q?Ajy4DJWHJQH64WXhheau5BtqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39aa94a-0261-481e-b4d4-08ddeadf4799
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 11:44:45.9978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkwepIXWESoF/jtuaQjpcCiNiXaqaJ4HkDpKW/UkGn/QdT+CxJzcjrTi1X1zVbI8nRj3pH62SNmGjqjo6cTShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

--------------Bw0CJCvrZ0PqofgrTcG4TK0n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/3/2025 1:07 PM, Christian König wrote:
> On 02.09.25 16:52, Srinivasan Shanmugam wrote:
>> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
>> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
>> amdgpu_gem_create_ioctl().
>>
>> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
>> return -EINVAL; when provided, size and alignment must equal
>> AMDGPU_GPU_PAGE_SIZE.
>>
>> If the singleton BO is not available, return -ENODEV.
>>
>> v2:
>> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>>    The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
>>    written once during init and not changed while IOCTLs run. There’s no
>>    concurrent writer in this execution path, so a normal read is safe.
>>    (Alex)
>>
>> v3:
>> - Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
>>    MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
>>    new BO — we just check size/alignment, grab the one pre-made BO,
>>    return a handle) handle it and return the singleton handle.
>>
>> v4:
>>   - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
>>     check from IOCTL; inline the MMIO_REMAP fast-path and keep
>>     size/alignment validation there. (Christian)
>>
>> v5:
>>   - Reword comments (no “===”), explain why the singleton is returned.
>>   - Pass &args->in to amdgpu_gem_get_mmio_remap_handle() (drop local
>>     ‘size’) (Christian)
>>
>> Cc: Christian König<christian.koenig@amd.com>
>> Suggested-by: Alex Deucher<alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 58 ++++++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index d3c369742124..7676eafbedbf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -424,6 +424,47 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>>   	.vm_ops = &amdgpu_gem_vm_ops,
>>   };
>>   
>> +/**
>> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
>> + * @file_priv: DRM file of the caller
>> + * @adev: amdgpu device
>> + * @in: GEM create input parameters from userspace (size/alignment fields may be unset (0))
>> + * @handle: returned GEM handle for userspace (output)
>> + *
>> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
>> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
>> + * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
>> + *
>> + * Although @in can specify size or alignment, this BO is fixed and unique;
>> + * those fields are only validated, not used for allocation.
>> + *
>> + * drm_gem_handle_create() acquires the handle reference, which will be dropped
>> + * by GEM_CLOSE in userspace.
>> + *
>> + * Returns 0 on success,
>> + *         -EOPNOTSUPP if the singleton BO is not available on this system,
>> + *         or a negative errno from drm_gem_handle_create() / validation.
>> + */
>> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
>> +					    struct amdgpu_device *adev,
>> +					    const struct drm_amdgpu_gem_create_in *in,
>> +					    u32 *handle)
>> +{
>> +	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
>> +
>> +	if (!bo)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* MMIO_REMAP is a fixed 4K page; enforce only if userspace specified them. */
>> +	if (in->bo_size != AMDGPU_GPU_PAGE_SIZE)
>> +		return -EINVAL;
>> +	if (in->alignment != AMDGPU_GPU_PAGE_SIZE)
>> +		return -EINVAL;
> You misunderstood me on teams :(
>
> Only the size must be exactly AMDGPU_GPU_PAGE_SIZE. The alignment can also be smaller than that, just not larger.
>
> In other words the check here is probably best written as "if (in->alignment <= AMDGPU_GPU_PAGE_SIZE)".

Hi Christian,

Thanks a lot for all your quick reviews and feedback's onto this series.

Just to double check "if (in->alignment <= AMDGPU_GPU_PAGE_SIZE)". 
"<="is rejecting for buffer alignment "#define BUFFER_ALIGN (4*1024)" in 
IGT, so is that is that this check should be lesser than 4K

if (in->alignment < AMDGPU_GPU_PAGE_SIZE)atleast for this MMIO_REMAP BO case?

Best regards,
Srini

--------------Bw0CJCvrZ0PqofgrTcG4TK0n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/3/2025 1:07 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fc8e033f-ad1b-4ea9-88ff-55b200f68ebf@amd.com">
      <pre wrap="" class="moz-quote-pre">On 02.09.25 16:52, Srinivasan Shanmugam wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
amdgpu_gem_create_ioctl().

Validate the fixed 4K constraint: if PAGE_SIZE &gt; AMDGPU_GPU_PAGE_SIZE
return -EINVAL; when provided, size and alignment must equal
AMDGPU_GPU_PAGE_SIZE.

If the singleton BO is not available, return -ENODEV.

v2:
- Drop READ_ONCE() on adev-&gt;mmio_remap.bo (use a plain pointer load).
  The pointer is set `bo = adev-&gt;mmio_remap.bo;` ie., The pointer is
  written once during init and not changed while IOCTLs run. There’s no
  concurrent writer in this execution path, so a normal read is safe.
  (Alex)

v3:
- Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
  MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
  new BO — we just check size/alignment, grab the one pre-made BO,
  return a handle) handle it and return the singleton handle.

v4:
 - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
   check from IOCTL; inline the MMIO_REMAP fast-path and keep
   size/alignment validation there. (Christian)

v5:
 - Reword comments (no “===”), explain why the singleton is returned.
 - Pass &amp;args-&gt;in to amdgpu_gem_get_mmio_remap_handle() (drop local
   ‘size’) (Christian)

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Suggested-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 58 ++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d3c369742124..7676eafbedbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,47 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amp;amdgpu_gem_vm_ops,
 };
 
+/**
+ * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
+ * @file_priv: DRM file of the caller
+ * @adev: amdgpu device
+ * @in: GEM create input parameters from userspace (size/alignment fields may be unset (0))
+ * @handle: returned GEM handle for userspace (output)
+ *
+ * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
+ * (adev-&gt;rmmio_remap.bo). The BO is expected to be allocated during TTM init
+ * when the hardware exposes a remap base and PAGE_SIZE &lt;= 4K.
+ *
+ * Although @in can specify size or alignment, this BO is fixed and unique;
+ * those fields are only validated, not used for allocation.
+ *
+ * drm_gem_handle_create() acquires the handle reference, which will be dropped
+ * by GEM_CLOSE in userspace.
+ *
+ * Returns 0 on success,
+ *         -EOPNOTSUPP if the singleton BO is not available on this system,
+ *         or a negative errno from drm_gem_handle_create() / validation.
+ */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    const struct drm_amdgpu_gem_create_in *in,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = adev-&gt;rmmio_remap.bo;
+
+	if (!bo)
+		return -EOPNOTSUPP;
+
+	/* MMIO_REMAP is a fixed 4K page; enforce only if userspace specified them. */
+	if (in-&gt;bo_size != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	if (in-&gt;alignment != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You misunderstood me on teams :(

Only the size must be exactly AMDGPU_GPU_PAGE_SIZE. The alignment can also be smaller than that, just not larger.

In other words the check here is probably best written as &quot;if (in-&gt;alignment &lt;= AMDGPU_GPU_PAGE_SIZE)&quot;.</pre>
    </blockquote>
    <p>Hi Christian,</p>
    <p>Thanks a lot for all your quick reviews and feedback's onto this
      series.<br>
    </p>
    <p>Just to double check <span style="white-space: pre-wrap">&quot;if (in-&gt;alignment &lt;= AMDGPU_GPU_PAGE_SIZE)&quot;. &quot;</span><span style="white-space: pre-wrap"> &lt;=&quot;</span><span style="white-space: pre-wrap"> is rejecting for buffer alignment &quot;#define BUFFER_ALIGN (4*1024)&quot; in IGT, so is that is that this check should be lesser than 4K </span></p>
    <pre wrap="" class="moz-quote-pre">if (in-&gt;alignment &lt; AMDGPU_GPU_PAGE_SIZE) <span style="white-space: pre-wrap">atleast for this MMIO_REMAP BO case?</span></pre>
    <p>Best regards,<br>
      Srini<span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------Bw0CJCvrZ0PqofgrTcG4TK0n--

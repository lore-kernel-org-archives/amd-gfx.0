Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8029C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 15:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F8810E03B;
	Fri, 16 May 2025 15:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GpixZgJw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395E310E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 15:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8HUkwiXHSEFixqJGVme0+Rki4/wAbvRy3marUkxA2b7sXsNYvlDkCnYFRrKpAX6Hu1wWlFBdqEDjyVfSBcAXi8i8lVORi7PUUIKm51gKKdBnW9zzR+Tt6/z1iAJPe432IQb+2W/cWLsbn0VrQG+LZnxmQONcR1oTknxgWX2izFyIVdj68ysXjoSCwZ+bMdByHmn5zMhaHy0WaWfL3l6COmGvXLW6mq8E7xsZTH6OUSaJiaCIWgqjXPEJmYQWUB7c1bmIMnbM9KmVzH4XRro1z069xah+vzKdp995/38aL9o4AUcT3STPdlDTZ5ddQrqNjZvvn5bMpnxVgyiKwuwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hggBRRvNxNZd8vl5GU1urp4FYQgkLwM3fI9o/Y1pOXE=;
 b=imcHBREAYU2pi0wJStAQikqjIFD87g616b2O/XdWbfs/Mv952u8w8HaX5IpkqMaZXS6zVVfeUxC37NDZp2BRJdZfmslAPPdMJP7pLE+/0r2YF5Qi/EbmsIbHs/tFk9fHs6f4j93rmPeb+SOxp4gIdw7whDoalHEo7GnLsbhWlymKL/GoAUxH+K8h+YwlpEwTkYT9SoSDu2uSdHHfgakKApfj/dI0qe9rMhloAd7QCJFIfBIuFSbNXYBHgh6AU2Kd76yIsbsMuIOeuxiB/A6h+1HHigcwlaZkiwigvtvxo0lT1MhBmQUMuPXLDbfVeZP9XheAZQCrtQAc7mJf6HKZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hggBRRvNxNZd8vl5GU1urp4FYQgkLwM3fI9o/Y1pOXE=;
 b=GpixZgJwEEWORetRqZ3T7mPZYUta2p7d8b4V4hlzBlsmMRAi0PyJEvva8AZeEz4LSV1yMQZD2ZJIsAXaRlGejviSkXDVjoHmn17YGbBqHQyKl/kNEOvYYGZ3r4KNoJijebIxaWt8kQ7XVBTZbtEDbxf7NBE1pRUIqIUqvwqrha4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 15:19:25 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:19:25 +0000
Message-ID: <976682ad-77d2-48eb-b76b-278fd549f367@amd.com>
Date: Fri, 16 May 2025 10:19:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-4-Philip.Yang@amd.com>
 <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
 <18f1dafd-4f0b-9dac-2994-3e826f17e335@amd.com>
 <8966fa75-4c46-45c0-b9c6-543f8d10f340@amd.com>
 <162ba0d2-6b5d-5199-f560-b3eb4fc6fd29@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <162ba0d2-6b5d-5199-f560-b3eb4fc6fd29@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d9b912-2f52-4fce-7a09-08dd948d0b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUNOdDI2Sk1UNGM1QTk2a1BoUVd2QmdzZWptdEs0dUVZNzRUMW9JMEhtWUZN?=
 =?utf-8?B?YWtvS3RVTGptWEtYTVBXOW9hMVdacVF2cHFDOWdFUENTNXpaajBBZ1o3ODc5?=
 =?utf-8?B?SlArSjhDWjFVTno2bmN3YUNyTFI1RncrVnFtUXRmRStGSFZCQmEwOTZ1Ritl?=
 =?utf-8?B?dFdnalF4cy8rY3lSL1JzMUI1SnBOMXUwOGxLYjMvN2IybFY4N2JuOVR6Rmdv?=
 =?utf-8?B?elpYQndTVU9lR2hJSWp3MndZbHAyQ2VzQmJpdkpXWDAwcEwycEp6WTNjTzhT?=
 =?utf-8?B?bjhicU44bG9OTXpxdmJ1OXg2YndSYUpDWWhmdzhwTWJsQkRaMDFpUXkxdmtM?=
 =?utf-8?B?WXg2eTYxd2xycGtnaitPYlJUZHhXR0hCYlVzeVJoSXJHUk1yQmZ0UExuZnZ0?=
 =?utf-8?B?c2IxaW9oUmI3d00xa2xUV1dVZ2FwMGxqcEVCckt6T0p1Z1JkUHV6SVRWYVRr?=
 =?utf-8?B?dFBPZ21rdVZOZlltdVpCL3FMakV4a1J4ZzEzTHpNZnRodERpTVA3QlFDVEJM?=
 =?utf-8?B?UnlHeU1RZUIzbktJN2dqRTJpUllhWnRYdjdDTG00RG1tMEZvLzY3Rmc2bFor?=
 =?utf-8?B?S2c3aE5ZVGRacFRXK0JSek1vS0lzV1hseXd1Qm5JMURsWU56R3VXWXRVRHlo?=
 =?utf-8?B?a3ZRc0U3UDdUbWhQSzN6RG8yVlFYSGVZbWdFTTBZQkxQQUErZWhieXlqS24r?=
 =?utf-8?B?Ui8wQjVqTHptRGZWSmxTMkxidWxpVnVqTnd5THc2ME4yZHIya1JIa1I5SzhM?=
 =?utf-8?B?dFBtRVh4bWNHV2RuR09OOUJXM0hRZDRKU1dwdEFNbGk3RGlCUmM3c25pMkZr?=
 =?utf-8?B?eHl3b1lscm5FVVM5V0V0UVdTd294Tjc2Y3U4ZXI0YldrbHZrenRRWk5DMklN?=
 =?utf-8?B?WnlUaEU3MEgrTXpPenBTYlRzTlFXZC9GbFB3bGV2emltRGdMWitxQkFXSFhI?=
 =?utf-8?B?SjRMTlZWZFUvVnFvOVhFYmhtRzNrYTNtd2lzRzZXS0JIUDRybkFnQU5zY3JT?=
 =?utf-8?B?MXBQdVlQL2Z5NE81bUUxbU13eEphZDNpeFJ5YjgrVXQzdENGOXRIQkJwU2x6?=
 =?utf-8?B?ZGg5S2dpZ1NiY3NDbVprem9yQkI4NEF6WUlqUVJXdWxvVnZtMGVRd1hkczJG?=
 =?utf-8?B?NzliczNhNlc1OGp3enJaZjFiTjZHMGFXWlFicnRqYXBiWWxLQXVTUFM0L3hq?=
 =?utf-8?B?SWhyRzQyRlgyN1pMa2ZYOXlVSU1CUm5WSkhvNmlwbmFVc0g1cFJhNW1GMGF0?=
 =?utf-8?B?cXY4Y1FKUnNkMy9JYnRkRVNGYTFvMUZvR1NCZE0zKzFEdTQ1YXNuOEVCUzBB?=
 =?utf-8?B?bnhGT1Bra0J6OWZLcWZHN1dWeWoyaFdtRkMzaGhBa1NneWdDNWZVVHEvY0hW?=
 =?utf-8?B?aElnRjlvWWJFWG5XN2JXeGtDcUpDY3JxMnZFQVlMUTlIVDVob3luMkF5VHVu?=
 =?utf-8?B?WmkvZUg3RXVkVlNRWHVrUjc5SndDTTFNYndEMjUrSVYvQTQya2hjUGFWYlBT?=
 =?utf-8?B?U3g4VUY1MEdHd3FCSlF3Y3AwQTVOS3M5VTBzcXd4V3lzNTVuSm55cENMb1lK?=
 =?utf-8?B?UTRVbU9kTTU1WElhMExUK0c5TjEzc0hPWnMxSExMVGFZR2VvT21tcS8vcTZ2?=
 =?utf-8?B?Z0N1eXJnQ1lVajFFR0J0ZjNwenAvbksrbHhOYWozRS9DSkZvQjRkdnZJellw?=
 =?utf-8?B?SGRPYnhjaFZHemtVWGhjSk5VV01xV29MR3JHWjVrcTQvUEl1akJ5RVlvUUEw?=
 =?utf-8?B?dUVxQVJoMjNRMUNNdlRJUm80NkpGaHN4NHF3c3lzVU9Rb1N1VTh2U2Q4alJ4?=
 =?utf-8?B?NUh6TzBYS0VUTllEMENXVDVkWldFUXluRkxpTFZGNGtGcFhreUtaODhBY0lH?=
 =?utf-8?B?Q3V3Z1pCZGZNeEJ0QTdFYWxoUk1yNVZBQWdVcmFhdElRQ3o3RWhDWnBPdCs5?=
 =?utf-8?Q?tDWpdlysg40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXQ2RGExcUlpdlI2c1lxcVlobGFsUjdab2Q2RFdxWVh5aTBZZ1VINVExWU5l?=
 =?utf-8?B?eVNsVzcvblpRUEh3aG9BSndnK05SY2xCS2JZUnFiVUxTWnNGb1NwaS9FUFg0?=
 =?utf-8?B?VHNHNUVHR1FZZW1USWRQczNpV3R5aCtKeTgvOUhUR1M3ZmJPV2ozTENSQ3BZ?=
 =?utf-8?B?bFE4TVNybGlXZEpJbEYxVmpkdy9nQTh4LzdDeGF5MDYvVzlDejFYWmlrUlQ4?=
 =?utf-8?B?Zms5cTVQUjM1UzlyamI4TlREVCtTRndPd01hZHBwSDFMcG9hU2dhTnNXL3Fm?=
 =?utf-8?B?KytZd1ppeWgva2hUazlqNUdrbVNOWXFMOC91WG1UQ0xFVjlpWFFyejVPMGZu?=
 =?utf-8?B?VWRldmwxdnFrTWNRczRMQnJ2S0o3cFNlUGNjc1JjdzNkZ1NDaEtGelNncjh2?=
 =?utf-8?B?RTVJMU5Ub2RzQUNJd3NwZ1c1d0ZZNlYxZEkySWZqTlpsM1Rvb3NXUEJpbUlN?=
 =?utf-8?B?YXAzc21BVWdCVnBMSlJOUHJ3bmhPTGlZU0k1UnJZRmZCaVZ6cTVZTHR2cURD?=
 =?utf-8?B?Z3RocmtWYmtGc1BXTjM0dmxUbmhCamhvL3NXY1F4TEVZbmNOUzFqMk1hOXFR?=
 =?utf-8?B?eGlmSitFc2tBWjVrZmVJOS9tK0l0cDk3UllLeFd6dFRIdTIweEd1ZjlaV0wr?=
 =?utf-8?B?QmVDYlJyL2ltQ201azdvK2MvaUMwSmZsc0c4anpHZ25GSVBwQVo4Z0hsblkz?=
 =?utf-8?B?a0NxUTZ1WGtvYmFLRXdNbnZObkxJWEZYS0M1b01NMjdiMGYxQU9aa2poYUVy?=
 =?utf-8?B?VnlyOEJZNDhrWjI1OXNWakZsamgrUEZ4ZzVRUld4YXAvNGhHYk5IYlZIUlZr?=
 =?utf-8?B?Y3VCNWpLUlhZL2lzT1B6MjZOT2Nhd1dCeW1FZlNIaVJ3dUhRSEY1aGZWK2tL?=
 =?utf-8?B?dUkzNnVpbTlHa294cU81cTVmaUZQdFFHUlpKazBFUVpUOHd2NTJIRGZwUWw1?=
 =?utf-8?B?L2dDWEdvVVRXVW5XcjM0a2VvaC9oZGZVVzA2TldqYUhjeTZUNVNEdVN3cHFZ?=
 =?utf-8?B?bHhyeUQwa0lHOUJXTzBlUmZ6Y1hnZnRFMjB6T3lnc3oxM2c2b3dTWDl1b211?=
 =?utf-8?B?OU1ZQm1aTC9Dd0ZTNGk3SUxnWmdObU5ZdGkxMFlwYUx1c3VnMlArTVB0dXU2?=
 =?utf-8?B?MmkrWU4zUkd6a2w1eGh0SFpYMlVZbkFXOUxDdnhjaHdZTkVHQlBUbmFoMXlM?=
 =?utf-8?B?aTgwVTI4aUxxbStQRkhlSlAzOHFDRkFPZlhQK0IrTHVRa3BzRHo3ZG53aWpj?=
 =?utf-8?B?ZUxLdEd5dHlST0YzMzBKZ2c4dlFQUDZmL2wvb1FkMEZNNnR6UXI1dTBmUk9U?=
 =?utf-8?B?Mk1MU0FEUEpHMDFOTW1xNkt2aWc4Qmw3djlIRVpML2hvSWF5OE5GUGo0YXdn?=
 =?utf-8?B?RDNFMEVqWldmNDErUTBUbFl5M2FjNDRjaXExaUg2dWZ1UHBvNG1wZnYxdkhP?=
 =?utf-8?B?STRBRWZxWDJMZER3OHZrTVNmc20wZzh3eFlLS09FVFNWVUlaalhWWVcvYVow?=
 =?utf-8?B?VkQxYmUweWdvSGVzeHJHNVdnUTh1YXJSWVJHS0pLaVBUNzJNQWF0Ty9KU3dH?=
 =?utf-8?B?eXZ3ZDVVRUJ4Qzdad21QdFlZTmp2S1RzcXpzeEIvQUNDNGQ0TXNYSlhBWVR5?=
 =?utf-8?B?UnNJWE9OWDJ2Nlk3dzFzRmJRaW5zZXZoNUduZ2NhVDNBSzRvU0RFZHRvK0hX?=
 =?utf-8?B?WDNYV3c3ZkpscjhTT05EZ0NwR1N4SmtDcTFpRWU0R0FWczd6RWpBTkRpbVZQ?=
 =?utf-8?B?S2g2MkE2Mmw1N0NNQ0VHYVVLMmN5YW82YlJXV29PbzZSclZLbC9TRFFZTUgw?=
 =?utf-8?B?Nkd2ODNXbnQyUnIwNGF1VVA0cVhoR0NQZ25rc3VDQTlZM0FNQjlaeXlEMlhv?=
 =?utf-8?B?Tlp2b2QvTUZsTW9WMFN0RTZTOEZrYmx6SFIwaWlFUDNqN1JtdHVsT3UyM3hJ?=
 =?utf-8?B?dVpCTkhKbytTVHQyUXZWMStFU29VNDduUjdOdndGVWxWd1VFRmRFK1FkNXN2?=
 =?utf-8?B?VUxrd0puM1IyS3JIaHlxNktQd3U5cFFsV1pON2s2T3ROcEJoVlc0WmRCL240?=
 =?utf-8?B?cWxlc051KzU5UFYzT1h2Q1J2V1BNcUhORWdmUG5xQTRrQk1GTjhIZHZlV0da?=
 =?utf-8?Q?9GWA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d9b912-2f52-4fce-7a09-08dd948d0b23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:19:25.6952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75fYuCuul8wCZ3dNUljawo+l/k0UumJNOplDCRNOcubPyd53Ln3SyjUWVp6xbxh0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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


On 5/16/2025 8:07 AM, Philip Yang wrote:
>
> On 2025-05-15 17:31, Chen, Xiaogang wrote:
>>
>> On 5/15/2025 3:45 PM, Philip Yang wrote:
>>>
>>> On 2025-05-15 10:29, Chen, Xiaogang wrote:
>>>>
>>>> Does this patch fix a bug or just make code look more reasonable? 
>>>> kfd_process_destroy_pdds releases pdd related buffers, not related 
>>>> to operations on vm. So vm tear down dose not affect this function.
>>>>
>>> This change doesn't fix anything currently, as fput(pdd->drm_file) 
>>> to free vm is right between free vm mapping qpd->cwsr_mem, 
>>> qpd->ib_mem and free kernel bo qpd->proc_doorbells, 
>>> pdd->proc_ctx_bo, to make it clear for future change.
>>
>> Then the current place to do fput(pdd->drm_file) make more sense: 
>> unmap vm mapping of qpd->cwsr_mem, qpd->ib_mem is the last place 
>> where kfd process release procedure needs vm alive. After that the 
>> kfd process release does not need vm alive. It then releases 
>> remaining buffers. So release drm_file as soon as we do not need hold 
>> it.
>
> The issue was  vm_fini shows error message "still active bo inside vm" 
> (1/1000) chance, took a while to trace down the leaking vm mapping, 
> the issue is seq64 memory mapping leaking and fixed by the first 
> patch. KFD pdd cleanup path, free vm is in the middle of free pdd 
> memory, this is one of the suspicious vm_fini race. We may add new pdd 
> memory mapping to vm in future, to prevent the potential vm_fini race, 
> this patch move free vm to after all pdd memory is freed and add comment.

I see the reason of [PATCH 1/3]. This patch is delay kfd's pdd drm_file 
release a bit. kfd should release drm_file as soon as it does not need 
vm. The issue you saw is there is buffer mapping still alive when driver 
decides to tear down vm.  Is the mapping from from kfd process? if not, 
change timing somehow at kfd process release is not right place.

Regards

Xiaogang

>
> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>
>>> Philip
>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>> On 5/14/2025 12:10 PM, Philip Yang wrote:
>>>>> Release pdd->drm_file may free the vm if this is the last reference,
>>>>> move it to the last step after memory is unmapped.
>>>>>
>>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
>>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index e868cc8da46f..b009c852180d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct 
>>>>> kfd_process *p)
>>>>>           kfd_process_device_destroy_cwsr_dgpu(pdd);
>>>>>           kfd_process_device_destroy_ib_mem(pdd);
>>>>>   -        if (pdd->drm_file)
>>>>> -            fput(pdd->drm_file);
>>>>> -
>>>>>           if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>>>>>               free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>>>>                   get_order(KFD_CWSR_TBA_TMA_SIZE));
>>>>> @@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct 
>>>>> kfd_process *p)
>>>>>               pdd->runtime_inuse = false;
>>>>>           }
>>>>>   +        /*
>>>>> +         * This may release the vm if application already close 
>>>>> the drm node,
>>>>> +         * do it as last step after memory unmapped.
>>>>> +         */
>>>>> +        if (pdd->drm_file)
>>>>> +            fput(pdd->drm_file);
>>>>> +
>>>>>           kfree(pdd);
>>>>>           p->pdds[i] = NULL;
>>>>>       }

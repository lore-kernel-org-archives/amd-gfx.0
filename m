Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E4ECF8843
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E771F10EA32;
	Fri,  4 Oct 2024 15:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKQ3JI+r";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E076B10EA32
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2KKzZRZ3b18ESvohT3wbqIJTGuGn0ikRJEGD4xC8EBuKdvgJjSBqS/e+F0JK+BnEUu5JeL7fGRSoUK3FMFyqdSilyCC2SDmVsu9imATwFjPeVUSdt5X6B6Hnq226wfSKSPJi6iGVGHtge5jZF+BH343Tf9wdrKjxJQeclo9J5JqEDt/KI/oPf11YgMnjgjUBBDZEduwxCHeOWt7REY5S6DfCeEODn4/9g1j1urxu25CwOQzS97cF7x3Ns6e0d7jqK8Mu+P7EAtrcaz7hoEtb3kHpFy01rQBwmqJskzdf6VuKLfCAhbj5dcHuBRjBkf55MqduHBEgDUxCC78t/jdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVGPRWrYFkPfGCNYa5HfVD2UrKUUmR4hhZXdlZrRrAU=;
 b=AwhquC8o448bjiKWcBD2E0IruyCiq1Ta9sMSFWWSxv1nJb/a2rY1iOWe4agMobZWseq+KzGkNEChq9qLJ6t8O8ovqpKnQCqnG50H4RiIU8zrKCWlkOhuWPVPFExtPc4GOVazfzDpTojRaD42v/NP1LrorLzE/SmvxgIwM7wX/sZcmF29QybRNRsWMtmFYfD4Z/EAxzT/FNf33P5tZOJjiv+r0HwJD2Z+ZhINaB6aoRUIKWnZjVuswBAakHvzZIkfaiqj+Ol7eYJ0hFic/LrGPr48AdGFmbC2+0qURRYmQGrUK0/tnIvip5w4ntaqbOFYlH4YGrd+2nltYwQmgvEY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVGPRWrYFkPfGCNYa5HfVD2UrKUUmR4hhZXdlZrRrAU=;
 b=AKQ3JI+rgEoAcEWO1Y4Fq/QuJICo51zRzNXEpRGtkeFIU4squxNskqCTyCd913mnBL4po+Pzw5EbDS6ubLfaDrNMkkWL3RcylpEYPLxswTL7OzSh9u5nzFTe5h0wCocWp/7kYWXv9jWzLM8yM2Pd0i2CfMnNuAd5gUMqOhtlFlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.19; Fri, 4 Oct 2024 15:00:10 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8026.014; Fri, 4 Oct 2024
 15:00:10 +0000
Message-ID: <ee143892-949a-41fa-9bc3-312fc76cac1b@amd.com>
Date: Fri, 4 Oct 2024 10:00:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process
 has been removed
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>
References: <20241003205526.35748-1-xiaogang.chen@amd.com>
 <63ed9ee7-a4a1-4912-9ef7-743879941ced@amd.com>
 <0e3ffe8d-da8d-4932-99f8-8241d17573f6@amd.com>
 <BL1PR12MB5898A00B1AAFFE27CEBB6FC685722@BL1PR12MB5898.namprd12.prod.outlook.com>
 <BL1PR12MB5898C4E23831524B7A8F132285722@BL1PR12MB5898.namprd12.prod.outlook.com>
 <643e7a9a-4c6b-44ed-9c70-8f44aca552f9@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <643e7a9a-4c6b-44ed-9c70-8f44aca552f9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:806:24::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee8d83a-bf0a-411e-477c-08dce4853e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEltN3FrUkJTRGd4aGphYUJIQ2FMelNTTzJ4b0V6M3c1cUxJaFgxeW1XMnhl?=
 =?utf-8?B?MGt4VnQrSG9BRHVpdG1RTjdBMnhBRUNsZWh3bzFJYXdCQ0prU3JXZUhTNUhY?=
 =?utf-8?B?TWliSUQyS1hzbXAvK0FERnYrdHkvUmNMUnRaL2pBQjF2UGRpVWNFQVAwdVI1?=
 =?utf-8?B?cHBSZC9SS2d0cUtxbUYvdnNVM3dOdXVXdmJDZ29Cbld1c0NxUm52OXdHVG9a?=
 =?utf-8?B?WEhTbTFmV3h5YU5FeC9QTlMvSVoxei9GU3pKeXFpUmhsdE84MGRocTI1WGdj?=
 =?utf-8?B?M01aNHlueUhadlRFWmJ3OERuMEgzV0N6S3Z5MW4za2VJQ0l1M1RyTzVsbzBl?=
 =?utf-8?B?dXE3emhIMURvWm5TS3A0UmhYYnZveHBsY0R0UW51TGd4ekkxdC94YWIvY05B?=
 =?utf-8?B?bWwvUVk3Ymh0eU5jVWVoKzMrNUdzRTVPd3lIdVJVVXRaVk8rS2VQSVh1RXZl?=
 =?utf-8?B?aGlHSkFPck9uWWlVRCt3NWR1YVp2d09Ba2lXelVveGVTSUJnRXArRjZmTnBO?=
 =?utf-8?B?SFRKU3pybmVqQ2E3T21LaTFlcHF3VGhidFBHb2Y1RlNTQlVuYnZuSkdmeDFM?=
 =?utf-8?B?NDNvN2kxT25za2ZYUlVwejF5UG53K25qVnVNV1pEcmVXTVRSbjgwZnNRaCtk?=
 =?utf-8?B?QlFJVUJpN2R3ajdOSmxwRGNMUDR5TWVnNzg0ZDRYZFhiR2tVK0VjS0FqU2VO?=
 =?utf-8?B?K01mMkViYkRnZjg4ckIrakhWM3VlTWxtNlQ4N0F0TmMrdEg4bC9zY3FGWXpP?=
 =?utf-8?B?N0tpSjJaQ1BxLzcvUlRxd29JSUZFbldhemRLRnF0QkUycGp6V2NOZ2FIaVJX?=
 =?utf-8?B?VDJia0hhQjlwdC8xT09Xa3d1dVpDSUlaVk16MzE3UitzWEZFUFZQaEk2YVVQ?=
 =?utf-8?B?YUkwVGpYTFkrQ2FvbjFYN280akxtOTB3RE5CbFhka2FkQ2h6S3lsajVxN3hs?=
 =?utf-8?B?Z2FvMURYa2M2clFobjZDR3ZtNTJweit0cWVzTGZaa21SaE5zYjZnMVpLWmRW?=
 =?utf-8?B?UloyTzJDSmxkRkFneHAwS2JvV1BWcE9nZWZ4YWZqWFJyU2NITkFrWlMyL2NI?=
 =?utf-8?B?VUVNYUFoc0tkMWE0R3pOblBJaDVIdGpNUzAzN1YxblloSmMyMjUrc0trMnFs?=
 =?utf-8?B?cDRWT3FKVGZLaW95RHNIdlh3MlkxZC9lT2FmRG05OGJRWXpTRkpaM3V3ZXlN?=
 =?utf-8?B?ZmNjZ3k0elhsZ1c2QU8zR1B6MVRPZmhhTWUwWmxvVUcrT0djazgrVkhSUmUz?=
 =?utf-8?B?N1hqQTBBWGN6S2k5cWNSU05CZ2RldzRobUZVa0N5b1BDTUJieUZmaWRCemIy?=
 =?utf-8?B?N1E0UG1wN0hhS1lpR1BFUkhWTWZFVlBHTzNDcUJ6SnBPaHNXY2o0bXQ0RWpG?=
 =?utf-8?B?QTlUcTRRSWlVbnJKZEJNZGt5dGRzazJ3Qm5oeG15ZTI5eEZOU01WdElIRzIz?=
 =?utf-8?B?bFhjZzdNQkRZZ252elZ2UlBYREpHVDNtUnNlL2liaHdRL1RZQm1zU0poRHJL?=
 =?utf-8?B?RmFPMlNLUHp2ZkhPd3ZTVzc0ZVFEZ2k0TU0wRHZkdnZ3OG5iRWlKK3MyZUJX?=
 =?utf-8?B?VWxrT0xkQXpyZDlBR2JOQkd3d3duZ0VKWGc0VzZpZGlKTTY3WWo1aUdCNUZ3?=
 =?utf-8?B?bkdKb1A1TUV2UmRNeEo1NmExRTNNWGZWVEEwRTQ1Q083a1NoWjZuYWlUc1Zi?=
 =?utf-8?B?NXc1R05OZyt5QTZLNWVRdS9kMFhLeUd1QzNnNTFtbnhuM2UySGxxZDZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpyVVUwV3pISGR4Tlh5NkQvMmNHZDM2R093R0tyNkFZcHpHNGFZSE4rYk9G?=
 =?utf-8?B?Uk9LUkZrQTl4SE1xNGtMb3NvcllMNHV1WVdHbW1MYUt0dmVHTFIxMWlFaHRW?=
 =?utf-8?B?UFVRYXlmUjBDSnp1dExGaDBzSjhLc3p4c09HRDlGNjE1dmk3U1Flc3Z0SVgy?=
 =?utf-8?B?dFlhS3NQMnRIK2toRHJ5ZzRuNW5tNDh5MVFxbTNpRkpPUXF2U3BHUkJUaE1q?=
 =?utf-8?B?ejI1Y0hmNEdYOTlLQUFkRDN4VzVSM1ZCRFAzdHRjeHJPQ2xubUV0eU45Y3Jl?=
 =?utf-8?B?ZCtNRVZKSzBMWVBUYzdwcVpXWFpkaFpFMU16Z29WaU8vWUhoSTFWVVpObWtM?=
 =?utf-8?B?UzF5WThYVTlIUjdaUVB5L29jY1A5OHl6RWk1VUhid1YrR2VJTExzQUxjREZM?=
 =?utf-8?B?ZjhUdVBOVXJjSHUweTdXL1ZaNVlQNnVUNHVtRmtiL0lZcHRFUXBKRktLQ01E?=
 =?utf-8?B?T3ZpQ2ZJa3NZN1I4bmFKQnQzaVFDdnQyVkVKNmtVYzlHOXNiN0d1aFdoVXUy?=
 =?utf-8?B?Y3pPVER6ZUxwZkdOMUhpajEvWDAzTTUzYnVCOTBZczQ3Tnc3aDl3Uzh1Sno0?=
 =?utf-8?B?TktQNStadkhkTzRGSjlLMGk3VkJENEtIMzByay9ndXdDcXZwVG1EL2k4OXRv?=
 =?utf-8?B?UHl5UUlKNmIyaFhFaXFMRnJKTGtzenVzV0xxQUpaOWE2ZlZsM1VOQmVkdVRj?=
 =?utf-8?B?cW1yZk9KMWkvVmxQQWs2ZkZlVW9wVFRwSE1FZGRJVUJNV0I1ZXcvZzYyWVpN?=
 =?utf-8?B?ZmxaREQ2L3U5S2RzOXAyOVgxQU5mSmFHU3oxNkF0SWptaVIzNytHbzJ0MHQw?=
 =?utf-8?B?Snd5WHNUMHJWRmdwM01Ld2cyYmJNK3d4Y3A3MkRKR1ZHRXZISCtjcDBLY24x?=
 =?utf-8?B?U2h5c0NyMTRqZ3U5UzV0NVNJVW1HN296RUN2dVJTM1E4blpCQnhCU1k1MDVB?=
 =?utf-8?B?SC9tbWVFbjFhSE9SdlY4QkFKT3AxU0xBYUhoMHg5ak1FM3NNeXdvV2lWbHBw?=
 =?utf-8?B?aHJVc2RIY3V1bW5DbEo3bEZpQTNOVjdCS0NVVStKQ0c4SXlVSnpzYXk1TmZB?=
 =?utf-8?B?S2dWY3l6d2pQZisva3RJTW1vOEF6dXhGZ1kxdy9uWUY0QnRoRkdYa2wxZmJo?=
 =?utf-8?B?STNUcTZVR3ArM2t3MERjSFBmTm03RTRvWjg0WDZwMkdqRDhBdCswUzhnRktE?=
 =?utf-8?B?cWZVM3AyTmlDMzlsVFEwL0YvczgzcStqNGFRc0dKMFVvVWNKNFFWTXg3bzU3?=
 =?utf-8?B?SHdYMytzNWhBbG1hbG1PandJS3JJZStPVUpqVkpnRFEyVmdmUG5vMzcrK1RB?=
 =?utf-8?B?Wk10UVpmRnB4Mi9BTXNOeXpIb2RVNU42SnNlTHY3MFN5Tmo4M1hvNzF5OEFD?=
 =?utf-8?B?OFdQU2xrN0ZXalFLSzMxU2xwdmFEVGhYZXpBUGFVQXpvMnd4VWRoMTJGaUds?=
 =?utf-8?B?QTBnYnJ0YnpwOHRqTHBDUlF6cUZvZEo4bTR1QTZ3VlZzOUhFVW5jT0VSRkVR?=
 =?utf-8?B?YlN6d2MramRWcjd3UE96L296VUpZWk56TG84cW4rUmxiUXkvcHJ6cW1hMnAz?=
 =?utf-8?B?OHJKclpzVFQ2bDY2NWlleEJ1cU1saGgyTll2VFZGOThZZCs3T2tKTk5FdXZH?=
 =?utf-8?B?QlBPSUo4SnVaL3VaZGtETDJzL0U2YW5mSElZRjFEdTl6ZlUwN3NjV2lPdjJq?=
 =?utf-8?B?c3ZEdGdGLzFta3NVdkRHSVBEY1gzQXhQbDNBcTd1QlF2QXo4QWlKQjBsVC9y?=
 =?utf-8?B?TUpzeTk2SnVUZjBGejljL0U3aFo1UEdhdUpVLzFwN1BlNUZ3UWFVUkx2YzBK?=
 =?utf-8?B?Y2o3UHNxUERkb05NNmFYclh5b25TcjZDTEJLV2xoRHdEUWdsU2gxdTRIU1p6?=
 =?utf-8?B?Q3RxR2poTE1aS1A4R2I4U056Rk0xd2M3c0NoODhVdThXOVRkVXArRVBHM01W?=
 =?utf-8?B?VG9RS0N0M2o1enYwM1BVZkpNSEJuR25iOXVNVm0yQ3JwQk9CYzhXS3ArREZk?=
 =?utf-8?B?UVFUU1pzOUxpeFh2NEZlUWt1SE5QQk5Zdkk1UklnVWdQWXFCWHdxZ0dXUGVu?=
 =?utf-8?B?a2JhY21DMVNBMlZ6QjJQQTEzc1lRRTdmWHJFRlRmNHFLYktBMzlvamZUVC9T?=
 =?utf-8?Q?UlLA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee8d83a-bf0a-411e-477c-08dce4853e2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:00:10.6421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct/drIcF4u8UMzZ+76hjNlrXbJErAZZQnYDHdrbhbtYopucGy51lrAokbXVM5x/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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


On 10/4/2024 9:46 AM, Felix Kuehling wrote:
>
> On 2024-10-04 10:39, Russell, Kent wrote:
>> [Public]
>>
>> My mistake.
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell,
>>> Kent
>>> Sent: Friday, October 4, 2024 9:53 AM
>>> To: Chen, Xiaogang <Xiaogang.Chen@amd.com>; Kuehling, Felix
>>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Yang, Philip <Philip.Yang@amd.com>
>>> Subject: RE: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process has
>>> been removed
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen,
>>>> Xiaogang
>>>> Sent: Thursday, October 3, 2024 6:11 PM
>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Yang, Philip <Philip.Yang@amd.com>
>>>> Subject: Re: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process has
>>>> been removed
>>>>
>>>>
>>>> On 10/3/2024 4:11 PM, Felix Kuehling wrote:
>>>>> On 2024-10-03 16:55, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> When kfd process has been terminated not restore userptr buffer after
>>>>>> mmu notifier invalidates a range.
>>>>>>
>>>>>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>>>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> index ce5ca304dba9..1df0926b63b3 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> @@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct
>>>>>> mmu_interval_notifier *mni,
>>>>>>            /* First eviction, stop the queues */
>>>>>>            r = kgd2kfd_quiesce_mm(mni->mm,
>>>>>>                           KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>>>>>> -        if (r)
>>>>>> +
>>>>>> +        if (r && r != -ESRCH)
>>>>>>                pr_err("Failed to quiesce KFD\n");
>>>>>> -        queue_delayed_work(system_freezable_wq,
>>>>>> -            &process_info->restore_userptr_work,
>>>>>> -            msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>>>> +
>>>>>> +        if (!r || r != -ESRCH) {
>>>>> This condition is always true.
>>>>>
>>>> so sure why this condition is always true?  kgd2kfd_quiesce_mm can
>>>> return -ESRCH when it cannot find kfd process correspondent to mni->mm,
>>>> then above checking will be false, then will not queue restore work item
>>>> into system_freezable_wq.
>>> If you expand the 2 conditions, it becomes "if (r !=0 || r != -3)", which will always be
>>> true for any value of r.
>>>
>> I got this wrong. So it's either r==0 or r==-3 (I need some caffeine). The function returns things back up from evict_queues, mqd_destroy, and can eventually return EIO or ETIME in the hqd_destroy function, so r can indeed be different values than 0/-3. Sorry for my confusion here.
> It's (r == 0 || r != -3). So yeah, I was wrong, it's not always true. But it's still confusing because (r == 0) is redundant. I guess you could just write
>
> 	if (r != -ESRCH) {
> 		...
> 	}
>
> I don't know if that matches your intention.

Yes, the condition check confused people though not wrong. My thought 
was: when there is no error, or the error is not -3, do userptr restore. 
So only when error is -3, not do userptr restore.

I will send new one to simply it.


Thanks

Xiaogang

>
> Regards,
>    Felix
>
>>   Kent
>>
>>>   Kent
>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>
>>>>>> + queue_delayed_work(system_freezable_wq,
>>>>>> +                &process_info->restore_userptr_work,
>>>>>> + msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>>>> +        }
>>>>>>        }
>>>>>>        mutex_unlock(&process_info->notifier_lock);

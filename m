Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8655D4334F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 11:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F4610E308;
	Thu,  7 Nov 2024 11:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRC3L3/m";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F27C10E308
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 11:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byr5I1J2F0IeHaL9l8YSluav0ubEbpUyFZU4GwpoZ6ahS1ctVu5AIqFurDo+VzrYPYB6CRuQaOt6CdVN0Uyf+PS8+xbbERWwQxM6xIGM+1kxqTTzJlRb98L/aczmLcerqYfhIbA1s9JiHVLxUz2xECgQrLimSaGb73VMljzHuIew1nzAiJnyuD+8SU9JcLjph654WmQueobWVnbrh6+TkJvjwCVwfKIQ6j+7whtnn2wG0KftFSqlTDsdBmbaK2gzDa9SPUhfgB0ISfaoxKZj2kFfKhX7CnMoK1ylo+hISvoz4R9wj/GR0oaQfbyIwvf3k8jCXC9pKnLazAYhZnqEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np1ewc/AWp+CCWlVvuOtmvFtNaqOxvojYqIr9llbR20=;
 b=CW0Rvr95J7zt6ZSnH8hcn8BgpOHNGNBjAqy+O2H5hhgFgaiiO5/9gOQ/9N3QYQco/7wK0y0RIgDO8YHTlIg1TPtTenqPkl8T58RXBhOE/frYi8WaR+puFgLcIfwxd+LQHWbTEtq+FME5nUIB+Bul7S+nv+MyVKvG8n8gCueCycIvHk6jvrgEOmm4rF2tJQ/5MLOOJsVHXdZ7dctVmMp1fJoooqfCETzhXTYHCXv2a3W/cIi6VgUhvZ1F3hNrVYQMHOJnUxHqN6A2TBzzAB3PNm9ABrWyPFtE6KBl8yannpuffI3T2vHnW1bKqgg3AcXK9HIWxkVB4mcFL0zYJTna8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np1ewc/AWp+CCWlVvuOtmvFtNaqOxvojYqIr9llbR20=;
 b=NRC3L3/mcHh1OPKYX07zpw8PXnv0z1sq9bsDPNi78Vrm5gVef29H7u1iSqGglml/wpsPYT7JJMEKnhfb/3zNMMym6FpU8nDxPuyNi9POx0oCcN/DNefCwX8SjLCrg4Ejvlfk0RhQO6Kl80dWVNJp6/XoFys1trQVrzD6uRGhy9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:57:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:57:37 +0000
Message-ID: <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
Date: Thu, 7 Nov 2024 12:57:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, monk.liu@amd.com, philip.yang@amd.com,
 felix.kuehling@amd.com
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 48823908-83a4-4bbe-903b-08dcff235f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzEyd1pBd2xpR2dkdTRuNTlEUldTSGhYZmJjUlMrYndxaXBMbFZxT3hSV2Jq?=
 =?utf-8?B?ZVArazlmK3lNbkljRHgxcStVOUlIZ3VGQnBRTThST3VmZFdYVkFYZDRpdUty?=
 =?utf-8?B?SHh3R0lXL0FkVDlVZno0M1Yydit1Wm5vam9reWxrMDFWYXlXcU9mZjhqSFND?=
 =?utf-8?B?d3JjMVd6eENYazU4dVRETzdqY24yQmxuMktSeko1VktMOVFlZFdBMnl3VFls?=
 =?utf-8?B?cm5MTVMzM2NkaG8wamZDZUhjOTF3Z0ZoUFhSZEh2OU1yZGVjZDExZWdET2V6?=
 =?utf-8?B?Zi9Gb2pRaFdKU0hvRmZVS1JPS01LU0FVckczS0VtcENNSnlqcnlRV3VRQ2Fx?=
 =?utf-8?B?TkRLZVNkZk01dXM1dFpGLzk4WmtNc0hKTVU0VWltdWdDN0o5VERoY2lZWVRN?=
 =?utf-8?B?dmUxQlNNVHBrd0ZadEpHTzFVTVNRbWI2cVhGc3FqR0c4bytNUVF3dHdzQ3Rv?=
 =?utf-8?B?eWVZaG1uU0k0Y2szNmMxdGdUcmdWdHdzemdoWXBWVmpjNGZ5a2lYaG9ITTAx?=
 =?utf-8?B?aTNpUCtpeE9PM29FVDBqUlQ0Q1owajk5MEE1ZUlxdjFkTEN6REhSK0JwNmpE?=
 =?utf-8?B?YWRKUkxCM2NFc2hjVVpYZXdKSUlPNDg1TmFoOW5kcndqTWZrUTRBNHBiZjdr?=
 =?utf-8?B?Qm1vNkNybUg3bGhJOVFDRU8wYlZjVWZIQTBiZjRrNklzUUZnaE13ZHNVRjA4?=
 =?utf-8?B?Y3QvTXE5cGQzYkpMVzcrc29COGsxWXhSTG5vcFdocTVvN1dYV0ZNaE1VdUxo?=
 =?utf-8?B?amphd1ZNQ1p0T01MUzNINmljdEJhUUJjQmVTWVNDKzV5Z3RwMDVrMk5McUdQ?=
 =?utf-8?B?MG54cnBleU4wVkJTQVB3ZG5pT0owT0VuUjUxTW9qY016YThZWlNnU2hOczAz?=
 =?utf-8?B?ZUtMbmNKNnlmZUFLNzVocGpMQWgzdWpIVUY1OEZiUG1JNG9ORmFsR0N4TTVl?=
 =?utf-8?B?aDNnaHk0K3NEejUzdHQvMis4RUxaZnplSFp3QmxSd2lZVGR4UWZISkJUUDVB?=
 =?utf-8?B?QjBjLzdxV0ZRNTVPaTFkNEJFdTVxNUNiQWdjZDNxUHBJNTZDOUhSTTBYYUsw?=
 =?utf-8?B?UXVUbERDYlRFVitrRG9PdVFXaFhnYVNubEpyV3lYWGJ4L1o4RjZTcTV2Uzdy?=
 =?utf-8?B?a2tZd2Naa1BkUmgrWHJrQ3BjcGs3clpKU21mS25MRm02QVhLOGprQ2g1L2tV?=
 =?utf-8?B?UDNBc1dYaTNjdDgyMDVVRnhOMHBzbUkvOWpWejJNdGVCOGxqL28rd243Z3Az?=
 =?utf-8?B?amltNXViNVFoT3JFYXR1NDcvbUQ3YTFGZDlpM2xFS2ZNV3hqK3JUWk81dFRX?=
 =?utf-8?B?RzFRcFF3QkFWRUtHYnJzZjVTS3dSaGRZQlBjMkpkTzhLMVg0QmJwdUErUTN2?=
 =?utf-8?B?dXNmZTNpSFZaZzJ6YytBNjFXZ2gzR0FmUkJtaTVyMVRLZ2VZV202ZGI1d2V0?=
 =?utf-8?B?YnVhOHVac3hNRVp2RXROQjBDbnFIdWhPMHo0ZkNsRjd4eS8zRW00eXViMlhz?=
 =?utf-8?B?MEFHVkhlUy9WUWtPYnp3NUY0Y3VnNTZTQWoybERDUldYNFEyWWJGMTZ0NnIr?=
 =?utf-8?B?d2dvMzU4VzVlbHV0RGhXSUlTYjNGZWh3Z2lVZ3N2aFFCZ2lEN0FwY1BrL1BJ?=
 =?utf-8?B?ZWxKcnQ5NkFIdTM1dEp3MGc2akhLbU5KR1NLUUFIS1RZcmRNQUY3dGU2VGp5?=
 =?utf-8?B?THJYWkRydjZRNlVLVkRWMGJwYUZ1T3U0RVltbm1wQTJVeitXMFV3RjNQL0s1?=
 =?utf-8?Q?CRG8JIa45ZaeLkCVZlOqjjcy5IegjA3ag4LbKKK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVvTndmRUpYenFXTEovaGxMRVQ4RG1WaE9pTG16ZDhsbUkyY3dRMDlUMTJh?=
 =?utf-8?B?Vk1tMk9nZmVMSU1TNVdvMVVCWnJRMTEyMlFXTS9Rb0JLbkVZQnQ1YjJHZllB?=
 =?utf-8?B?ajNmNVdwMklVZDlhY1dYOGpIZmp3SGYxWEdYRTBwRnFIMmJWa1JlWHRvTEFH?=
 =?utf-8?B?YVNKdFlZRThOQ3RxYmYxMjhZeXA0Uk13OCttbUlYVkwzTjFBZ1Yrd0J2cTJG?=
 =?utf-8?B?OEtBWkZJMXpOcmJweXl3OUh0eHd3RytaU3ZTQ3l0UjBIMFNiRnpwMUZKZDlN?=
 =?utf-8?B?ZkQzUWVpSlc2YzBtbTFoYmx4SHB2U3JkRXFZZmRnUS9YanI2TjNRVEhSSUtD?=
 =?utf-8?B?czlGMzJrcm1aemN1YXJWMis5OSs0MkYwaGdCQTlwWElqQ3lScjVySGswalYy?=
 =?utf-8?B?STNNQTBmeFlXb1FCODlCRVhvVlo1anpHbHhHa01KZVpOMkVUNU1IZFNROEhE?=
 =?utf-8?B?MXNBZk9KUzVpN0RpWENFZ2dveTRaM0VNY0ZQcmN1bVJMclZsd245NWFIY0o2?=
 =?utf-8?B?eVVIakFEckNXNnQzR3RIeDlPa2tBdENlY0x6ZTlUSkh6R3RQbS9kUFMyU1dI?=
 =?utf-8?B?aHg1cFVRMkxEQ0JLZDZqUkhsTmh6RU11U2UveUliZWFFTTFRNmYyZll5SllW?=
 =?utf-8?B?a0xCWXRZbUlyQTlua0JsS0Q5OVN4b2NiZ0Fsc2lhd01JL3VHUTF6bWs1MkFk?=
 =?utf-8?B?aEhEYzVzRkllSVBzeHFRa2UyMERqRXRidUJ2c0VOR3RRakFkVnIzUFlWN3BV?=
 =?utf-8?B?UEVhbzZZZEp1MERXSkgyanZMcEdyV3U5bFM1MVJIbzFQR0o1aXhmRThRRnk5?=
 =?utf-8?B?cXIxQ05ub0doT3BZMzdNOFRRMWVab1Q1MjlMRUFTMW1teUVQMmxKRVpFN1Zl?=
 =?utf-8?B?Y1ZkbjBCVExlT1VzakNaNUhLZHN6TktVUGZZTUxnSDhzemJtc0d0UGEyTXo4?=
 =?utf-8?B?R0hKNnQ1TlBnQ2ZQWitickZtQkpqUmo1b1cwTU1HdUxRdnpVRklpbFhWVTc1?=
 =?utf-8?B?OTA5YmNDOVEzV2FqZzM3ZjR4Q3RDVXhHcjdWWmpodzRaSDQrQ3g0cTFtYXU5?=
 =?utf-8?B?aGNWcDg5YnRnbkhUb0dQcmFQY2gvUWZldllrN1YyWjVnZXhkMGtETEpLNUJC?=
 =?utf-8?B?MkxVTkFBZ0RGSThlMWFTcng5UG1JNnVLdFlzOW5QVmJZa3JsK0dUVnpSYWhF?=
 =?utf-8?B?QWswMG1vY1BtTzR1MjM4VUtwd0dpM2RQWmRpMDRkeEhpQnM3NFU3ZTM4MzhY?=
 =?utf-8?B?QTZDYlJpTGFDaXdiTXFYeU10TzVVRlladjBHRHNNemJlMjNlS21VdHl4Tk1W?=
 =?utf-8?B?V2xNQ2l6ZXQzdkhGRkNPZit5UkVsTTZ6R3FmRElBTFVOV29QTVZpQ21lb0Vx?=
 =?utf-8?B?eWdSekkrRWRwYVBMQmE4NktvMkxyYmNlTUQrdHp5cmxWNXJ1eWRNNHYzZENI?=
 =?utf-8?B?WnZYQ3hRa1JxWjBWdS83RU1UN2JlSGk5d2c0NXhnWjBPMUZYS0ViMFVXNmJZ?=
 =?utf-8?B?MkdWUVAvWXpDaFJkZUpYa2V5VE4xRmhWa1pkTEJGUmZaRzRQbW1UZTdML3p2?=
 =?utf-8?B?cmhxa05sMnVEM2lPaHQ0bjRsU0xibEltankzVElnOFVsTm43Zi81NXFXRDJq?=
 =?utf-8?B?Y2JtY1FhSnN1Z0Vwb2FQL29yWVRxUjZPMGliVkNmZDcwaGNTdHdaVTdNRCtM?=
 =?utf-8?B?QURsN3lGSVlDcFFQQUFUT29xSFg4YlFpeVdNSHFHc2o1T05ad056NHJydTJX?=
 =?utf-8?B?emYxVlFBaEpnWVpFV0lKNjh1YytscEtOMEdBNzBRUmkyUTkzZW1VbmN5Ukxt?=
 =?utf-8?B?dFFGbHVqNXJwU1F2K2JJTUpWQ2FEdlJYTDEzWGZWOEJMeGxZL3ZWSkdNajRO?=
 =?utf-8?B?Y2RVT3djOVhicHF3Nm4zOXkySU1zSEs2cDRlcXVZbW1jNHdaV3BXTUJEUldN?=
 =?utf-8?B?OHBZTDd1V2V4TXJGbDVFOERzenFZdWFGUDdMT0trWS9YY3JWSldKV1BmL2to?=
 =?utf-8?B?OG1WdzI2bTcwTzZIWGVpcXRjRGFYVXowb1pod05ZWldCcWZzK202dFJYVUw5?=
 =?utf-8?B?M1AzK3JOaThCZHlNanFNQzU0RUk0SWpidVk2SHBpRFV0RXRZdUJDdUVCMUpQ?=
 =?utf-8?Q?GMDwL+R+eK5BsyMkOMWJmIUHO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48823908-83a4-4bbe-903b-08dcff235f53
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:57:37.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFh671Y9gSEssJf0FJPZhqGJJP5peDnL2tFJvgbcjWkxCXNdiI7EaVcx3eKNNxCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>> From: Monk Liu <Monk.Liu@amd.com>
>>>
>>> As cache GTT buffer is snooped, this way the coherence between CPU write
>>> and GPU fetch is guaranteed, but original code uses WC + unsnooped for
>>> HIQ PQ(ring buffer) which introduces coherency issues:
>>> MEC fetches a stall data from PQ and leads to MEC hang.
>> Can you elaborate on this?  I can see CPU reads being slower because
>> the memory is uncached, but the ring buffer is mostly writes anyway.
>> IIRC, the driver uses USWC for most if not all of the other ring
>> buffers managed by the kernel.  Why aren't those a problem?
> We have this on other rings -
>          mb();
>          amdgpu_ring_set_wptr(ring);
>
> I think the solution should be to use barrier before write pointer
> updates rather than relying on PCIe snooping.

Yeah, completely agree as well. The barrier also takes care of 
preventing the compiler from re-ordering writes.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Alex
>>
>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>          if (amdgpu_amdkfd_alloc_gtt_mem(
>>>                          kfd->adev, size, &kfd->gtt_mem,
>>>                          &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>> -                       false, true)) {
>>> +                       false, false)) {
>>>                  dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>                  goto alloc_gtt_mem_failure;
>>>          }
>>> --
>>> 2.34.1
>>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2797E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D4310F17C;
	Fri, 10 Jan 2025 19:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNvknMi3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8124810F17C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGIzm1yn2Gz+5+EDMDYwWH1vHkqmGhY4XHPgzXu74nZXVutzoZL3QPJ0whlwafhm8Src42nAmdoOl2EBFmTOroj+o5sBtt051PULMXa+uxlSuLetYsf51Aosj8co1e5hzT/UkElk05EOmyxZRgTOUnXVmcgMlnwCUaNg3XN8FLXjQCiEf+n1hK7LaYonK4y53zCij8qJen+RqVhMa6UjiO/t+4Q4a7Kk0Pmn9+/PHrIxreQWGrOX1B7hRSgtv3asp4/f7RRRazwzMxExHzLiGVX9zYqS00FtJn/5gbWpkSEvuU9ReLRkoDynuFF5j7QDfQBoTZkO/YqNCr0px+ijHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpXhS2h2pf1WeIz/Ov8T8A/KsWCoFRQRiLMipnu70MY=;
 b=wJfwnVzCwgIVn6ZmF9nqaESqkw2zEtLjJkQQCd8K1cd61tjv28c9YUwzchJddzh7648QsKXf4YvEfjAvvcI+lFw3tjnmeC5qtOsTA4FN9cB8B6KP/0caJKXtvyHV8NU6g40rusaUBjmBEKY4wsgmkqi9olJ3D7Nl6pz4ACYk3CXWSNUprwLp5eTIvyHdAnXRJCTHd7vJ4yatyNMU4LUuN7EdY1Swqf4mQAHZPAgMePqDuzj4TWzeqo61/7KJPZEPXyO3xHN9MvAVFKMQeXZ10Inev0goTHmgJhb9eGjLuKnZu1jrCUwWRc9Kb8NihWE47HnhlLSHTNuuq1x87XbJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpXhS2h2pf1WeIz/Ov8T8A/KsWCoFRQRiLMipnu70MY=;
 b=NNvknMi3srJPu7wKcGcXqkte9urimaQ0RM+k1Ioh/MRC5lh6y4oBo2DYse8q2I7qXK8NyH5ybvVExpxcGb4AfruKLqlRsOT2O1I84fhfQuNwEMU6QtKmLWg6vjrzAjuiSZl9sMVYbxM7uKDxkdasPxPrBKmHpVjdOBjKRokaQtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 19:06:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 19:06:05 +0000
Message-ID: <4c0b084e-faeb-442d-9bd4-fa43e1e5d3b3@amd.com>
Date: Fri, 10 Jan 2025 13:06:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 0/6] Fix several bugs in error handling during device probe
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cover.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b303b1e-cc20-4ebb-1ad1-08dd31a9d4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmpjMGxHbzNTbzArSlp2QnlhUjJkb05Ia0ZTVkludkM2WlBYbnkyYnJYVzlY?=
 =?utf-8?B?M2RNQ1lVb1h5WWRYSSsvVmMxTmFXYXllczJELzhmcVdvZ3JrdTJEd2Ivb2hh?=
 =?utf-8?B?SGh5V1lrc2xhREFkVTVIWkppWFJXRWtremQvU0w5M2ZReXV3QitDdkpvRHdV?=
 =?utf-8?B?RWM3U0ZWSklKTzJvNThuU3hETTBqMzNKK29waTNjL2FqVFNSR25EemVaUi9t?=
 =?utf-8?B?ZGNZamsvUWdMVTZTUTNDVmxKRUY0RFU0eEJ1a2N3MVRhRUJBRERXNFRteU5s?=
 =?utf-8?B?amFTcGhySjNDa3I3ZTlTUGxoK2ZmQlpXVHJ4VHFqa3l1dVkzeEZJNDlHaFVD?=
 =?utf-8?B?YzdYTURnVEYrUnRTNjhJbmxoa3FieGpyTlFHUEZ0SGNHRWlOdDJ6ODBMckpH?=
 =?utf-8?B?OG4wT2NoWGdUUUF1WkdsMDV1Y3F2bGUvUWs3ZTkvQkhjcEh6NEtPSnVlSHdM?=
 =?utf-8?B?WSt5YkRuY1I4RE1TL0VqcTBHU3ZvYk5jVnJHSWtEcFY5V1BJL0xYck1mdGc0?=
 =?utf-8?B?UHdPOHp6bVlBZFV5clordVBQa0QvVVphSUxXUjc1dEh1cGMyNUtSL0prNDNX?=
 =?utf-8?B?cmF6NkhyZWFmYlV3Nk9yNnFsZnNWMHY3OFpJN0xJL1hkbnRTQlN2YzZWa2VS?=
 =?utf-8?B?Q2c5RkhZc01qVDlsamoxYWxyMzMxN3NlZlRXQTAzRU5BT005eDkwZFFHc3l0?=
 =?utf-8?B?VVpkRXhxMkV6NncwN0hXQTViUEpHc3NBTEhqSFZLcDhNWW94dVFlQ29zMGY0?=
 =?utf-8?B?ZDZCdkpuYmczVHI0ZnEwdElSV1UzUmR3dlgvdG5XZWZJYktUTlFJTDd5cnFh?=
 =?utf-8?B?TUJaL1RJZmo0WVplWFhGZDNEMDZReENEek1KLzVFSkQ3cmRRSDFEQlk4UDNi?=
 =?utf-8?B?MHNBVHVyTDhrWEZpT0M5Sjhia3h0cUFMZm1jKzZHbTZxRWVBV3c1VWcxZE5o?=
 =?utf-8?B?VFFpc2N6TW9CS2E1SkYxc05tZlFVZFpEM3VNRnljbTNqWWpnTmNQcEpaeGtG?=
 =?utf-8?B?d2VKQXVyTjgrZzdvQjh5TktxYkNzTnV4RmVnVGJUZjVUSnM4V1RpeXJ0Z2o4?=
 =?utf-8?B?c3h0WDhLTUVUMXRJL3lteU11cnZuZlNOQ0lIUm9JbndDQWNzMGJhaUR6UzJo?=
 =?utf-8?B?YjR0dnJsdU1ZaHA5RHUwNXIzYllmRkdLMTV4M1pMQW02U1NSWUw1Zkd2blgw?=
 =?utf-8?B?WHVFZzFPakZHYWRmNFIxdGZUSjJaMXVRSkpEWDNSVWZoSE44bkhzL2d5dlYz?=
 =?utf-8?B?UlQvaDZnbmM0cXJVNTVOZEZhWHZQbisvMkZvS3VFQ2Z1YXZuZVFrTFNHZ2w3?=
 =?utf-8?B?cVhGellxTWlmeGFLU1hwakpvblljZXpEeVBMRFJsSWV6U2lUK1FIQXNLWFJC?=
 =?utf-8?B?a3J5SmlUT3lYTk93REFrZ2NOUHM3WDVBWE1uRUYyNEhSQlhSYTUrOFZQdHVF?=
 =?utf-8?B?YmFwOElCKzJaa3RGQTN2ZlJZbmJtclNzaXQrRVJDVXFCU2pQNERzYTdzMGJW?=
 =?utf-8?B?d0RxTlJZTEsvdXkyWFJBcXN2TnB1M2RSYXp0ZkYzWU1MMEFoSDd6QURGMHhC?=
 =?utf-8?B?QklHSjVNTTBONUhoay9mMm5YaXNUcWhkdXBieW45TGt6WTVRblRuNytjZDlD?=
 =?utf-8?B?Tlhkb0JjYlh3YUJOZ1lpSmYrRGE3ZkFhMVdYYk9EenhScHVpMkpRakVGaS9r?=
 =?utf-8?B?eUtiQVBJTzExNk92U0pOcnFkRFBmVjdGRW8zTWc2czNHc1NNaXZsWFJ0M1BM?=
 =?utf-8?B?VlhvODRIR2hHbWFuYy9oNnFiOTZidE5KNWltZ0tKV21BbkJiNDcvMDE0N0hx?=
 =?utf-8?B?VlFpV3E4RWlrM0RYbVdyYWMycVVXRmNBcU84eC9uOEJtTWxIR3BoZDFleEFz?=
 =?utf-8?Q?U3UXF25mftts7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1k3K0VkbjlJZzdJSnZqRjNIbDRKTStIdDl5QUVNTUhmS2p4S29sbmVPMTIw?=
 =?utf-8?B?QTJDclVvTldGbXJjbk9iai9lUnZMK0xJbmJtZGE5Tk90MVFrNE05T3NraFJT?=
 =?utf-8?B?RnRhcWZ6aGs0VXJ4S2VjZWdLUzMveTR6R0ZvVC94dzJtWnAwSUU4ODlJTFZa?=
 =?utf-8?B?NE9pUFE1eEhFdW9yYVlEdysxemhUYjFHMTNsNS9BTTN5NGZyUHBrMDFqcVE0?=
 =?utf-8?B?ekxVOW96eHVycm5rdDZFekszV3A4TTdlT0dncUpIVml6MEUxUWlyM0hSTEVC?=
 =?utf-8?B?bjUwL0kxcmYrdlRXYStEZTI4RHBNRiswTXQrUUt1R2hncHlPemZiejE3RHdJ?=
 =?utf-8?B?cjQvMXV5K3ZNOW1SdFZZbWl6RXhVai94MXB2cUhIMXNVZEYydjkwZ0FCd3NY?=
 =?utf-8?B?RGZuZmdGNHdNN3lYVTZDVVJpVE1rTlRMRFFpNXdwNld0by9qMGZtZDduMHhu?=
 =?utf-8?B?RjdWaU9tM1JzOGZRMVp4ekI1KzRCK3pYU1pHL0hTVWRCODJNTUxML0ppNVFw?=
 =?utf-8?B?Kzhuam15WUFWcDRiK0pUelRQYmsvaE1uNXVSaUVEM2pVZjhzV1kzN2xvdktR?=
 =?utf-8?B?V0ZXVGovQmdsWVJkTktCQ3F4MXg3Tmoya3pPYzdTekVnSUZjWm02WFUwYjdG?=
 =?utf-8?B?dHp0NGFyeUVLdnFmdGxwY3VoUENQdmMyQXRHZEZHN3RSY3Bwb1g2c1pSbkIr?=
 =?utf-8?B?dnJBK3BoTE9JUVg2ZHJmSEJXbFZ6MVJzT21ONC9Sc201QWg3Zm82UmhFUW5n?=
 =?utf-8?B?Z3NyOGlDekZaajdLbG45TWhISDBFUlJnVkJuVVVKN0VOR0xTRUxqeXhNZDV5?=
 =?utf-8?B?RktxVm41QklheTgvWkVOTFZrdWJaRS9pWkFMSzF0RlpnTFhjZFRqTkNBTTlJ?=
 =?utf-8?B?YXFlVXQ3NE1XbFI2RThUbTV0QnMzOTdIdExmNnZ2aUhqeWJNOFQ2dzlNcWxV?=
 =?utf-8?B?THVmRitiZkI1YjVxd2lFUzZiZDB5K1UyYmpLQmhMNkxQSVRaeWg2Zzc1Z1BO?=
 =?utf-8?B?NytOWitNdGQwak5heHJiV0dwT1BSQXAvN1oyMG9VbS8rVmJORTVYSnpxWWt5?=
 =?utf-8?B?VUNhSDI2R0JodjVxbWNGVWJpaTRPMjlVSHZjZ3g4N1ZZQ1ZJZUFBMFVZMWt3?=
 =?utf-8?B?OUpvRDVVVzJ0SEU5bVJiZ3FmT1hGK0U1dU5WWVR6ZENVa1BHa0lJVkZzSUJo?=
 =?utf-8?B?T3huVFNjRXpnVm1PbGxTbDFxanFLZDRCaFpZRVBwbWtmMmRIQVNibzd2QW1s?=
 =?utf-8?B?dTZuZHl3amhaaTBvYTA5TGNuUFpTSWEzTUFybnBKVURlcEw3MXVlUHlUc3FT?=
 =?utf-8?B?MGl0TDFxaGR0RnZyVUVCMXZrWUExa05ZVHM4bjA0UnhwOWlHU1Q0NExVMmhj?=
 =?utf-8?B?U1hDcmVxM3h2MFp4VHNxMXU5WjliRVV0b08vUlVzVzJsN29vdXNYN2dsWXVL?=
 =?utf-8?B?UWFNWkVXQWdtZ0VZV01lajQvMHhqSW9GcGRwbmVVKys2NzRGaDlTN0tkbHVi?=
 =?utf-8?B?Sm5McStGY2ZrdUdIL0NjR2FvZlBzb2FGS1dUbHovMmJkcXpIbCt5UWJjT1JS?=
 =?utf-8?B?YTRsT0ZZK2NzY0FzaUliRmkrM3BXbzFZNkpQakdJb2ZScDZhMXlmZUIyVFBt?=
 =?utf-8?B?aS9oUktuUFlnNmZIdExGY3V3NkRYSWVUOHcvQ1dZUHVUMGRjUmJUWThvNFoz?=
 =?utf-8?B?TUQyWC9OYzl0akFjSXF1Q093VW5CYmlHOXl1Z2luVlVRRTJ2WmhvdXg4OUdB?=
 =?utf-8?B?U2RBcTJ6RWtYNEVlYnJpRE5ud0dzWGROL3M0WUd0Nkt5cmM2L2MxdjJpVXRW?=
 =?utf-8?B?WXkvSWYyYmpJaGdOSFUwdHRuWDFxaUxmYUFROU1NaDZLd2JTQUw0b2s4SHZR?=
 =?utf-8?B?ZHNQMERZcmRZVUo4U3RDSU9qR1J5a1dzbEFzT2hPNGwvMk9rWWlTSWNKMGZC?=
 =?utf-8?B?VGVmSGxKMVA4SWlYMk5NaWtRQkczZjVKbStia3RoZS9SaVZUWHYwZzloSlhj?=
 =?utf-8?B?dzFocFVrYlpzUjUvc05NSWppdVUreUtrSm52QUF4RFJLRXFIM2FQb1d6dWdL?=
 =?utf-8?B?UWswanVvaWVBTXdjZXR0WHptd1JrZWV3eEdUdEs3dGNBMnFBL2FDRGp2TUZj?=
 =?utf-8?Q?rseDzvt5luRYWOYfDI5z9NlZs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b303b1e-cc20-4ebb-1ad1-08dd31a9d4f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:06:04.9787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDCF6srLt9rbZ+uYjMRHOUTYEbO6w3rwsXbB9XzykGyDFhu1UbP52ZFHH98x2eDuZMqfhCmTGAw2RgDg/HWc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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

Just a minor nit on this cover letter; you have it listed as [v4 0/6] 
but there are only 5 patches in the series in this version so the cover 
letter title should be updated too.

On 1/9/2025 20:08, Jiang Liu wrote:
> This patchset tries to fix several memory leakages/invalid memory
> accesses on error handling path during GPU driver loading/unloading.
> They applies to:
> https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
> 
> v4:
> 1) drop patch 1 in v3
> 2) split out amdxcp related change into a dedicated patch
> 3) use `guard(mutex)` instead of mutex_lock/unlock().
> 4) move patch 6 in v3 to next patch set
> 
> v3:
> 1) drop first patch of v2
> 2) rework the 0003/0004 patches of v2 according to review comments
> 3) add patch 0004 to fix possible resource leakage in amdgpu_pci_probe()
> 
> v2:
> 1) rebased to https://gitlab.freedesktop.org/agd5f/linux.git branch
>     amd-staging-drm-next.
> 2) removed the first patch, which is unnecessary.
> 3) add amdgpu_xcp_drm_dev_free() in patch 0003 to enhance amdxcp
>     driver to better support device remove and error handling.
> 4) reworked patch 0005 to fix it in amdgpu instead of drm core.
> 
> Jiang Liu (5):
>    drm/amdgpu: clear adev->in_suspend flag when fails to suspend
>    drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
>    drm/amdgpu: fix use after free bug related to
>      amdgpu_driver_release_kms()
>    drm/amdgpu: enhance error handling in function amdgpu_pci_probe()
>    drm/amdgpu: fix invalid memory access in amdgpu_fence_driver_sw_fini()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 18 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     | 14 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 70 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  4 +-
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 65 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>   7 files changed, 142 insertions(+), 34 deletions(-)
> 


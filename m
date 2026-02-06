Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84773EE209B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194F810E163;
	Fri,  6 Feb 2026 13:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOkyn9ap";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB28110E163
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chA22m3shsUyVwtT1s5m8vQO0gpp3pVkGUwcSAaxqNnMe9C/UDDD+MBt47PiPq/vpqaqgX771Nj4VAMZYZgsutZSsvq0EwJnXFfBESNpgDcYlmIyx/31bkgy86fw0pdDXiaBmXc4EwrNbD7ulrGuqKnpsVJFsTV9ujnw9Jf3OlgsDQGHOkVZV7Smx4+4hG3KWnNEfkDkKyTnnqCum6O3W6vK5IPcATWk32h8o2gb+1zMMchPMGsJEmezt6S+uZ6Ky/VCV9s3LjK7FKQn5hQn9y4BSLakhRT0SAH2IX2ZzsJIzb6ddaE8qBtB0lHJJ6r5T2ydRYiya0tK7/DySHDAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhA3MhyEUtdepICh7sb3kiDp4rRLZcEo39zVnJgo7YM=;
 b=P2KopNl/NoMHZ9uOHO/YX+v6sHnwUKLVHxzl804W78nvjY/laXc5dl5l37qaB77Tv2vd7GSz50zsX90A+MhoPO4+7jpKODxTCS8HJmeptLBXWiYwtE7uho3dwU64YhoHGVml23LYFm8dqVNeLzzj85+TsC1EFu8bqPR+oE6vbHtD4R1PCO/eIXus45oyF4u64AoBquX+X1Y7IO+fFU4vVC9Wlk/7VvnLjmM3kWRjl4oVUrINVgKQQazV3PJQwp0JjSE33wX7LhzeFb8vjP44jNX+u8IziUv/HY6W07Ky1OnmZHY6OSAYayPBdFMUfJD5tVY6p+doJjjAnmzSf7U2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhA3MhyEUtdepICh7sb3kiDp4rRLZcEo39zVnJgo7YM=;
 b=ZOkyn9apUuU4FQgTvCYhfplL6jD1Whv4vvCr9+vwKIv4y8oMIlugUAadKLohTWzkFER/WodM9Hk1+VrXHyYRBp1WxP79ro1SZp4nBdaLLrJyNP+bDRBpvVSzv3nTsbrLvXCQwJXN20mqUNPTrJy47TI2l33s8DX6Ep6Zchm430E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 13:05:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:05:07 +0000
Message-ID: <be6ad418-6fda-4e7b-9a97-96b224d59555@amd.com>
Date: Fri, 6 Feb 2026 18:35:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] drm/amdgpu: Add support for update_table for
 SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
 <20260206112449.45381-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206112449.45381-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc3e8e9-4ced-49a7-59c6-08de658059dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHMxaXpIZ2NpaU0yVzlzQ0UyMEtMM2U3OG9xa0sxcnFTbjZqZnBySVVxWHJ0?=
 =?utf-8?B?Rml0V3ZQZUhRSXRCd2hCU2Mvdk9YcjZheXZpZjZpWkxscXFsajRuUDdYNmdF?=
 =?utf-8?B?Q1d1aG5UcmpxNVYzOEVtWG0zWEJqT3dHbUlQVnRDTkhxUVZLejdpZWVvdHhu?=
 =?utf-8?B?MnBQSG5adU04TmJwZDVjNXVaSkoxdUR0K3IzaEI4Z2VRWXNZZTFqSXhETFBt?=
 =?utf-8?B?RGNNL09YR2JJSTJGazJYZmwzQklVREcycDhkck1QYmUrWHQ5bkI1VExPVDI0?=
 =?utf-8?B?MFMwanBEdXc4bU0xVElzVUhXemJXbEl5b1UzcTN1ZWpIVE85TzRYSDBxRTNM?=
 =?utf-8?B?a1RnVkJNSnNVeVFpZXRrd01VTU5NYkMxN21BZngzdnBrdk8reWFmVTlzRzV4?=
 =?utf-8?B?OHVIUEJqZkFwSS90cnBIc05kOEpoVk05TTMxeUQ4V3A4UW41QTYvVjQydUVU?=
 =?utf-8?B?QkNZUnhWKzZyOGViM2pKN3JVeGdQeUpHQ1Q1NnB4UHFISVlkaGo4dm1McVZl?=
 =?utf-8?B?STBMNkxtRnJuRXlTemNuc1ZJUU9BaW1USE1NUkVsQllBcW5nTjdydHkrUVkv?=
 =?utf-8?B?V2R4aXowbXc4bWUvTVRpQVdLcXRiRlAvQWQ1R0xDS0lxQndBVjZ1UWZSQmJ5?=
 =?utf-8?B?Um9UNTc1SXFTWWZBTzNtZjh1OTVqWVAzYmJZYXJOU3lUeTBMc2ZTSkhTajlt?=
 =?utf-8?B?WXNGQUFPTTFMT2lWc21FWUpGTUVKdkgwWGFRNTN5L0Z1L2ZJVmFlcElOWHJ3?=
 =?utf-8?B?N1U2dTMvYm5yTWozUjZyY0gxYW90TG1oMHhrdGtMY1R4UDB3akZ5SXJka0t2?=
 =?utf-8?B?ZGZaTFdOaGxyakhOTExJWW1IaTY0TWYvMStYWTNLNDltcDBRSytKL1IzUWVC?=
 =?utf-8?B?eUhaWHhJZXNia0x5V1hXUWhlRG1FM3JtdUQ4MmFsM3VDSkJkOThSNVJyUHVx?=
 =?utf-8?B?bmtxNGtSR3pSZDB5ZjlrOEpPZVMvR1QraHVLREQrTjdHM1dwTHRQQ2dodUFD?=
 =?utf-8?B?NnZyRHBPN1RNdjZYMWtQU2hqR0U2WERUQzEzYmFTVGZOdS9LbVljMWtCWE5V?=
 =?utf-8?B?TmVCSjZDZFZLQXZTeWZVWFdrblgwazBlRFZWSkZNSUlEbzdZVldkY2cwS0JV?=
 =?utf-8?B?U0xFcmMwdTc1UTdhM3ZIU2pKWlEvSGcrajUySU1XMGVBQXFkU3lRRlpBcHNB?=
 =?utf-8?B?T0JYVHpWeXFXdndMdTJYeWhzREVnUHNqUWo0QkY5SDRkNXB6bmcvZm84RUll?=
 =?utf-8?B?V0tsZlR3Z0xCamZ2blNBKzlqVnFMSWZ1djZvdUllZ05qc0ZCK1NwUWpsQStT?=
 =?utf-8?B?dUZiQTd0Rk82OXhOa3Q1MzlBVzhBcVpuTWhPTU5rTmRVSHl4ajJSbE5DY1RR?=
 =?utf-8?B?bDlnaGlzbTYwSk5GdmwvZ3RPcVBJZWVIQUkvMEFXWTh5NStzOERWNFNjekQr?=
 =?utf-8?B?ek0zUkE3M1NhQjFxM1BlZWt0OGJPczRMTitrOEJZb0xqM3JjSjl1czI0dWh1?=
 =?utf-8?B?VmVXSDJPaktFaVFBeTN1L2w4RDk5MkJIMkROMUtxM3g2VVdobUcyV3lZSG1Q?=
 =?utf-8?B?Y0k5S1ZGQ1E2WlNIUTdnelduRktQUXg5MnZ3WUpETTJNTHBuZ1F6K21neFdu?=
 =?utf-8?B?TEU0VnZPeXpwbmRkUVpBbzZpTXlLTVZZZEJBRlNFYklsL0lDaUUxM0pLeTR0?=
 =?utf-8?B?Zk9haWpIWGJGY2dpQ3FWYTE2WUVqdWI0SFZwYS9CQ01hdXdVTTFXMnNhUFh6?=
 =?utf-8?B?SDhwakV6TzZsaitSU2dwb2FrSUxFZU5NQVgzR3dNRDhEMCtyVkVsbFBpaUFV?=
 =?utf-8?B?R29yZCt5WXQwcDhGWVRlbU1JRWp5cHZtalJEYkxFU2lTN29wZjVMdFIvaXFK?=
 =?utf-8?B?OVNFKzlCZ1dPbDkzaDZib2VDZUxObWdrWXhIZWxwS25NMTJ0SllGQkkyNkNj?=
 =?utf-8?B?N2ZmVGE2eXBzNURoR0FQbm01b3lUTWtEMUdrRmh1ejNwb0dudFJ2SmhiMjYv?=
 =?utf-8?B?ampIb2xQbzFkNmZpMFBaL2hZOG5OYkt5bU8raHhHYUpUUGsrbVZJTnZDWCt1?=
 =?utf-8?B?aVhYL1RldlB5WHN6WS9qUDJuK29JYjMzMytNaWtQYkVrQTQzNDNabkVtYXhU?=
 =?utf-8?Q?nESA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlEczVzTU5yMlltR09aUHdVS0lHMHROelowMHRDUitrNmt2MmlFbW1CeTFQ?=
 =?utf-8?B?SmY2QmVvWS94OFBsNmtGa3ZRdWFFVTZnZGtrTUZ1amFRMjVJQTI5TTRXUUx1?=
 =?utf-8?B?M0IzKzY4dk8rRER1emJ2SkJTcjNBQ1pvOElsbEd1Vi9VbjJXMEVVZ0dFbU1U?=
 =?utf-8?B?ZzNqaFZVZlloWGcvUG9IZTVNcTRNanl4WlgvbmdYbi9HR3ZXbGFGT0NqL3pL?=
 =?utf-8?B?RDN0a0lYNzRhRllXMXhxdm9PV3UxSTQwUlJlRFFpVWhMQ2RGanFPVFZ6bWhL?=
 =?utf-8?B?SURrV2c0Ti9tNjFYcFdBcmduSjZ0NU9XYVJ1dk15NWVCZHRGUVdJc20vUnda?=
 =?utf-8?B?VWlsTStEODVvbDV4VDVjaXZ6cG5uU2tkRkpmMnVpSkJZbXdwUklZeE5pTldz?=
 =?utf-8?B?SHk0QjVjYm1wdWI2T2tFZHpRcW9EN28zWlBMaTVJeWdrVUNuVmxiODFkb08x?=
 =?utf-8?B?UmRmNjVyOHF1N1lvdzJxSHpWK2xOZlpnaStTRm03Tk1tZEZaZ1EyYUxSRXk1?=
 =?utf-8?B?NnVsdmFvOWlURS94V1k4czZteDdsSENxWGZZSklValZlOXcvaFpuRGFJUGE5?=
 =?utf-8?B?Rmh5eVhxY1hCUkFuY205VTVpWXhRRld3TzNLL0FNYWdacDlmSWJraU90MjhO?=
 =?utf-8?B?cnpGWnk0elFrZHFWVFdwVmxyZy9CWmVYVUYrblluUUxmMGZWcDduSHQ0S01z?=
 =?utf-8?B?UXczUCsvcm1tUE52aGJrYjFlcjRpaE9qK2kyQ0xwL21RVVhMUHc5UXpMbHJw?=
 =?utf-8?B?ZjhmcmhlZ0s5VjlEYVhTdUcyV2I1S3pJNHhKZjZtZlZQTkx4SUF0c29Takcz?=
 =?utf-8?B?T1Vxa1Q4emIzZkVQcTJlNURPRnF1UkVUb1A3Zldsckp4ZE9jOWpVNXlrSUlH?=
 =?utf-8?B?amc2MGgxamlFUXhrOCtnSkFtVFZuMzEwOTR4MVhVbGNxTkNHYkVEZUFhY0ZO?=
 =?utf-8?B?YU5oVnZaQ1d1UVYxNUJEOEtTTnZPb1ZxYXZDaEc5MkVpckRFd2hzVXJyQUV4?=
 =?utf-8?B?em9IYlVWeUR6N3doYmhmRjdXbjdTK3V6ekI2TFNYYkhBZ3FZQ0swRW5yS1dV?=
 =?utf-8?B?RkpxZnJVbzNlSG9ISzMwRUIwRHFEbThDMmxqeXBBQ2R0RFdvK3ExQkNwQ0Yx?=
 =?utf-8?B?TFk5UzFXQzM1Z1NpZUNBZ2NxcllhVWpHa3V3RnYvYWY3a2QxRUpTa2NQM0Jq?=
 =?utf-8?B?OFQ5Yld2czdnQ25leTRuZXJiMXV3dnBTVitxQ3VZNDlpSEl0OGVIOGxoZEZt?=
 =?utf-8?B?YW1wR2tmNy9iOW01L1BxZmo1UFBJTGxTYUVKREl4Z3ZWQWFlbEsxdlhrTFBY?=
 =?utf-8?B?S2tqdUhZT1FxUGdKQ01kMEFaNmpCR0sydWJYQi81d3ZoRUJ5VGJSdEdsVEhJ?=
 =?utf-8?B?Wi83SFdsSC9haHB0S2FHVnJjbncrMG5McHpzSGxUblorTGZkQStFQSsrbWRv?=
 =?utf-8?B?V0ZpdFk0NW5CSVhKUU5wWlRmTHB1enFPTW9JYnJSMG1Ed1F4STFva1ZJYzhB?=
 =?utf-8?B?SW5iSzFzVWRlYmdJZzlpTE90WWZJTU5zNVZlcUFKdWxVblFxZzZTTFNEZ0VD?=
 =?utf-8?B?V2ttcTJBQ053U25mUTI2OGVId3I5Tmx2QUNmU1ZEN3BCQ0UzT21iK2tUWUhp?=
 =?utf-8?B?Zk1xNEpGSFM0MnNLTENqcFlrZ0xNQUZtOVUzRkptUXliQXhyZ0MxZDNxcWpz?=
 =?utf-8?B?OFh1WHUzWnRIcXZCQVZ1d1NxdU4ybGVKVHBqelZjUTI3cjJyeit0SVlKeTFw?=
 =?utf-8?B?TlRZQzR0RjJCT2NKQW5rUHRMK1FPcEN2aExmRTlnbW1TZ21FQm0rZ0hlZ2Qw?=
 =?utf-8?B?bmpLenNseWYwVGdPWUtxU1lJcHRObU1BRVh0MjRYQlNxVjhXbXJ5eHpHNUkv?=
 =?utf-8?B?K2lJcnMzUVVTY1ArSWxyeXBSUEMrdDZleVFjMWVPMzNyVVFWaGxqSThjRFBp?=
 =?utf-8?B?YllVcHRQdlREbmpPUVRLc0xFbXNaZ3Bla2R0dlEvQlR5eXJ4Yld3T29DSlpV?=
 =?utf-8?B?SVdzTnVrSmw3dENoT1N4K0NWaWRpUHZ1cVoraU5TaHo5Z1BOaXhSTG9NdFNm?=
 =?utf-8?B?RXBidldWWjBuVHMzNjFJYUR1RTY0SGRTY2dvZmdJQVNhL3BJVGtUNFlnMEhN?=
 =?utf-8?B?RHRUNGUyaFNNOEZadFBWdS9LSEpsTjhITmN5NXl4Z0hSRzMvSFArSGxsdXp0?=
 =?utf-8?B?bGg0c2RobnJkQzhmc1RyVlJOYkZ2djB1Q0pKVUIwcnlQY0lHWHFRQU0xOVVO?=
 =?utf-8?B?OExnWTA1eEltNC81cStpbHpaSlo0SkxlRlhqRmV5OG1XRmdtT2pMNUtKdEp1?=
 =?utf-8?B?L3paak5YTVY5SjBPRjZYd2ltSERvVnBBS3hLbWZuNUdycjhROVN3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc3e8e9-4ced-49a7-59c6-08de658059dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:05:07.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWuewCeFKnbIxFlN2097sofup9wOM61RQ06wQ9qAd3ow4WRhJONAI+h6TTdkxKcg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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



On 06-Feb-26 4:54 PM, Pratik Vishwakarma wrote:
> Add update_table for SMU 15_0_0
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 64 +++++++++++++++++++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 14e8d8c7a80a..af87c31ca9a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument, void *table_data,
> +			 bool drv2smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..22d0a543a0e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,6 +1726,70 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	struct smu_table *memory_pool = &smu_table->memory_pool;
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret = 0;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
> +		return ret;

This looks incorrect. Memory pool is meant for a different purpose. It 
shouldn't be used/checked for table copies.

Thanks,
Lijo

> +
> +	address = smu_table->tables[table_index].mc_address;
> +
> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
> +		.timeout = 0,
> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
>   int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;


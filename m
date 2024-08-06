Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97941C52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E4610E3F4;
	Tue,  6 Aug 2024 20:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vw0PGNzI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88EC10E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPOU50LK3FdDNDBreAZ3pAkzHBxfAomvUHa4L8q9a8DRwcd+diKe/xucca4cNC9Uv1i3BM9h3ER50sfQw9HyiX+v0F9bEAeMxb2KGhu+2TSBdc1zNBEYu9hNjF+0/cyDAmvB9Hk7buAyJHD8cf8CEPz/nxOf0sZ2FzPfrm6x3vdWZrJs4libaxT1g0Ru+Z4m28g/VPj1/INfzg7gJ20tgaFJypY9TPtSkiPOlOBV79psa9PskDBiqVhNdemDEF93AXfEiaglohhVVOjwPkvKn6ycFqmfdzGLVFCr39oM7TVwha89UcHetY9UhAGmick80+K0rIKEZPSIFJmevbFuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg2eCW5xGqQOtFK8Xm/BSa5CneuGt2zXHTUzHilLGNI=;
 b=OrecNVAEcOWeoCWiZm1Gos0HXHeC9KhyQmvKoaFPwsMrXN5uDTAeRb6qxhw4c96siWeUvoHWuh4FRQ0z/KKAEA0JhHT6+EXc54swkmoE84urCAeHIIDUsPJsUkR1SMbjp21E7swrNE4qYFLIJ+SCOxZ6bCF+hkqo6ZTJDX50BZbK+xd4SfQpXxq4BhvlCOUSoqAo2mmRaA75xViYB2VeVoTZ8/CADTT9OdHSgtgwSY9X167YssqA14kkfSZSsu9JY2EIlEiSaXlxL07BRQHodQybg5MfjXYFadwJns0x+xL64ySXiECR/3w+iujVIJqdN6lQVxSUtqzx9sqJ/By75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg2eCW5xGqQOtFK8Xm/BSa5CneuGt2zXHTUzHilLGNI=;
 b=vw0PGNzIZVpxoydIntDaxMwmFa0TfjdxVEHpNScx31LXMZk8SqJ19A7Rkyjy2DKWCAuzhlyzeXWrWtZz+GR8uiWDKd7ZM0xXR3q0D5453IkLIxU6i9coWD02Vs+zwcvFseUoJ+Yr/XWisbvIobHeh0EFJ0VXlnOfbHQr8CRbzNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 20:15:01 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 20:15:01 +0000
Message-ID: <4b888915-614f-408e-8286-8911f8a42743@amd.com>
Date: Tue, 6 Aug 2024 16:14:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: command submission parser for JPEG
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com
References: <20240806160012.234633-1-David.Wu3@amd.com>
 <CADnq5_NvEEYqXw9HL+6SyauxwGK_KbJg-3CSgjyOatkdV1ehgg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_NvEEYqXw9HL+6SyauxwGK_KbJg-3CSgjyOatkdV1ehgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 847012a4-778b-4e17-281e-08dcb6547362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzREVCtGRmtoZnRPYlhVWU10c0pLWkNEV0U5MU9kSFplQVBZdU1RUWpLYXRr?=
 =?utf-8?B?cjFoRWFieWlGc0pmUWtsUTBVbXJvL3QzTUNwMGtjTGpuN0tScFZMdzYxVjRj?=
 =?utf-8?B?TDlXc2dxazMxTTZhU2cya2l5RitHL0RZMHVTS0dmQ0Jkbjg5SVI0LzVVZVJa?=
 =?utf-8?B?WUMyY1JjMEZBRlF0cE12MXZ1Yis3eGRUNit1bURzZThSa3NtbHVBOVZiam0v?=
 =?utf-8?B?elExdWxkWWRYbmQ0SlR3VzlNQTZsUHIzalJwWGEyQkdQSjV3enI1dHdKM1Ft?=
 =?utf-8?B?UUp3dGNqK3VyWEdsTkhtc25VY0tVZ080THc1K3Ezb2VVOWZZemJTU3pXYnNS?=
 =?utf-8?B?djBKdnpKZGdVamtZaWpza3I2eENzL0Y2aGx3bXJ1TWZQNzNZMnBRb2kvSWhT?=
 =?utf-8?B?U0QvTThUMHQybFFOQ0R2N1FaVmF3MW81WkpVZkZnZnZUeUNZTXMrSURsNXdP?=
 =?utf-8?B?dFk1SDV0QXlkSTRyOFliVzJNWW1pMTUzWDhzbzNkWlA2WDI0NDhrVXhmTzRn?=
 =?utf-8?B?cXoxalNaeTFVL2NaSi9CeVNxUmxRYnd4SzVnZkVNdlhlR2xIejRXZFFtYkc3?=
 =?utf-8?B?ZzZXd28xWDdUOUpTdUU3by93UUxyYTM1Z3hHZ0VSRk1lZTN2UGIwL2pKeHlq?=
 =?utf-8?B?enNaMWpuRWxBM2d1bHNtSFg4d2pwSWsxbU5aeGplRzFkQllHU2p1ODl0RWFp?=
 =?utf-8?B?bGNBTXVBYVh5dVhQSkFLS1daZHZFbERmRVFBbFI3bkRuc2lBRXZoWFZTeTI3?=
 =?utf-8?B?U2g1Nit3UGJYa0VUQ01aVlpkNUgyQW9YZVl2K1Ewd3pTdU9lYjdRWW4xVURS?=
 =?utf-8?B?dVJURDlkRVVDRzFISlJmd2g1ZVBjMkgvRW9iemtOQmpPU0FUaW9TbjVlSGJC?=
 =?utf-8?B?Z2VaRW54ODhGdXFpcVRDYnZUaVN1L0JUZm1SdGpTaVJmb2FxWDZkb2xVRFhk?=
 =?utf-8?B?dHdqM1lwRXNiOW5tU2V2L0h6N0VEUmsxd0dCSmFXbVQyQ0lFY2FaK1h6VVpG?=
 =?utf-8?B?MXVwM0lQMHpXc0RQZ0tJSGJHd25iU2tVa0RWMVFmb2poaS9PVThQZHplVVN0?=
 =?utf-8?B?UHcvckh4aGI1SFdSYmtJY1N4VnNZemt3UDExRXI1d1FMR0FjRU54TFN1Qksz?=
 =?utf-8?B?cm42ZkNPcmdvR0FTTnVSYm1aUDNzdW5idUs5TTJSVlpVYllQZTI4czd2V1ll?=
 =?utf-8?B?eUgzWkVLOHBrS2Uvckp2aHJjZmYzb0lXcUtPNitpaStRMzlwOVFEUzNtcENE?=
 =?utf-8?B?dEh1eGtnQTRlcWFrbXBNek5KS3d6YVNjaWsrQSs0SHdJT2ZVUjJkeE9xQytM?=
 =?utf-8?B?NDlvQzkxUyszRkpFUU51Q3N6SUl0KzQrVFlyeTN4bXA1MkNPcUl6WURYY0Er?=
 =?utf-8?B?WGxwbjJjcE9FVVZyTzVTUDhObzNmRGV5N2p2YjVQSytBRFpTcnBJeUg1c2lE?=
 =?utf-8?B?K3BObnBkYUMrNEk2ZUFsQ1BJcTN0M1ZFR1EwY0ZuWE9CZHg5S3F4ektIenFq?=
 =?utf-8?B?d0VqdDhUUFhPREIzS2I0SGNlb0FmU1VZL0FidVB2SU5pZnJuVW1HbFltMzIv?=
 =?utf-8?B?ckF1cXFYK085WERJQTZmSjYweGZ4ZncrZWxySldqMkJFUHBuR0tJWHJ2b0Vk?=
 =?utf-8?B?SlYzYzdkcDQzSkptMWZWaTZaSVR6NFRidklBblcvWEtWWWJBTFBXNU5VL3Rr?=
 =?utf-8?B?VEZjOGt5VHRTbjdidTFuakhERHdIY2x1T2g5VjJqakYyOWd3UVVQSHVUamho?=
 =?utf-8?B?dm1IakFJK2Z4enZQZFd6cmJYTlRoUGVXV29abHRJV0NxL3p2aDRYc05vTy9r?=
 =?utf-8?B?bS9BdjR3YndXRTF5Vk1BUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUF2N2hEcUJaL1lsL05jV3F6Zk5oM2dPdHMvVHMyVGlUVVpLLytHNTdjNWpF?=
 =?utf-8?B?ZkJxMjNsUlhmNmVpczJWN2hmOVdDdTllbUMzQkQrT2FjRTlsWHNadDVPb3BT?=
 =?utf-8?B?QVhBOHo1bXlJNnhPMkhOTGZ1ZGppaytLOUZocVkwOG9LKzhHTExyQUhpOXNS?=
 =?utf-8?B?TWJQaHZ3bWpPVUpyRWpwakJIOFpxLzFQNmtUODZwK3hqMnRFNHZjV3U3U0tX?=
 =?utf-8?B?eTE2VVJpSmhiQUVsOGR5aUI5eWpBUkRDMGdCUWdYbW9XZFNEeHBYbXp4T0J5?=
 =?utf-8?B?KytSQkFwTzJNbDB6VHJmSHg0Q1kyRENkam5vS2tYTE5CR2NLUzlBcW5hNVk4?=
 =?utf-8?B?akxTNkczZS83cTBxdGNSMm5Jem9qQVdhK3JFSlVBTXk3YUtCWUtEVzhheVpk?=
 =?utf-8?B?SG9PcHBBcHo5cFZScVBUWitadFdBaFNNU3NNUkU1cHlyNW1ERUV2ZE5yM3pD?=
 =?utf-8?B?T2xzTjRwYnVUTGp2SzE5WSt2SGtvbmhuWklJTXNzTWwzOU1wdytDcVhWaEtU?=
 =?utf-8?B?MTJlNlV2RTNiUjhpbCtMcnlZMC82REV5VElQUlZrSlZ5MHd3cmc1R3dJQ2dj?=
 =?utf-8?B?SEx5c2hxbWFQbFNURFRKcHZqQUs3bDQwTE9lWUplV3REVGFwMU9WZDJNRWs4?=
 =?utf-8?B?VGE3aUNOeWE5OUlmaGtFZW04Z0ZtQmxSL1lQYW9ONFUwUVAxNkZsKzg5aCsx?=
 =?utf-8?B?Y0FqV2dlL3Jvak9iVHZYLy9kTGlkV1ptb0hnVkoxTFNla2NFMEtEaG1mVjRK?=
 =?utf-8?B?TDVNSEpxZmZSalNUUHVkK2g4S0YzdEphZWl3RE0rR0VrdHRUM2d2eFg0cGQv?=
 =?utf-8?B?VldCbHRocEdSSk1YeVMzWU03ek9UMnpueGV4dmdQbStWSjJyMEkxQVN1Ui9S?=
 =?utf-8?B?RXpqODR5SGJvcTYxOWFiRjcxaEV0WjhjTkxjVi9kOUFrMkMrMlVBWXBHM0gz?=
 =?utf-8?B?SkNhOFVraHI5SGxJZXFQQ1FhT3MzNld2SVNiMzJFQnJkY2ZRK0EwM2h3b085?=
 =?utf-8?B?UHJTMUFpbXNxSXFrZ2ZuQWowVDZUeWNUYmNWc1h5bzZkSVovV0p6Yy9NaFBM?=
 =?utf-8?B?dTNzN1BEeFhLK3RaQ1JwT2FIVU01dDNVcG52UW8xT00rU2xYVmYrMDl1VEhQ?=
 =?utf-8?B?OUhDMmRTMGI3cllSK0Flb3VZY05Ha2pwMWxhbHM2bEN5eU5jYnFMUEl5UmdE?=
 =?utf-8?B?NGZreHdwZ2p0TlpteGFWaXMvTS9FVTFBdm5CTmQ0KytoTjBsbG1jc01XMnZ2?=
 =?utf-8?B?TGFyVTZwV2tpcEMyZnBkaEpnalhMRDlRT3dqTVk3Zk5uZm4wekhkdExaRDkw?=
 =?utf-8?B?SW5hS3RFNERlSUZCQ1BVYWdzdDViRk9MYlhPMWhOUHdNQ3ZOQU43ajNZZmlV?=
 =?utf-8?B?L3pZdTVMY1l3Um9sZGdIbmozOXlRdTRhTjExVTdKRkJuTmdvdy9wZlpFYVha?=
 =?utf-8?B?TE1xNE9yTndvTy9HKzRTSEVyQWdxemN0RCtuK0Rac2MrOHp0SVVYNldMMGtU?=
 =?utf-8?B?NU1tUStNZXR2eTlZL01nT2JiQ0NkUm9aTFJVcDg2S3ovZUgxelpuQkpxUkdR?=
 =?utf-8?B?a0pYdm1CWmxGYUN0eG1JbWJBaFF6YnZld1E1cTFvLzJuWlFHa3BKNFJRQzV0?=
 =?utf-8?B?VmZtQWZtYllrS1pGeWxWV2xHM29mUnJKcUZGNFhMOFppck5TUmM4Uk5qWE42?=
 =?utf-8?B?UFhxWVJBUnJRMnRmbUM3Z1FHQTJidTlIWWxjcVNEeTNBYmlOMGNFT2s3K0p2?=
 =?utf-8?B?Zm9YRUxDbWw5VmNQNFRBeUV2bXAyVmFxb0RpWitKTFVlOXdZTzdWQ0RYS1Vq?=
 =?utf-8?B?Zi9UcWwrdW96SXpsVCtmWXJzQlNFYTh4UzZwY2k5S3JuSkVjWHJFSTFtbzBQ?=
 =?utf-8?B?K3VvM0RONVcyMVpxTlA4Zmk3bngxNFUzVTQyeUhRS0NsSEx1SEsvRzZiaUpn?=
 =?utf-8?B?ejZCT2VoYmJNYkF6S0VrM0RCbzRFbGIvbjhVcFVMT05KQk54cDNDTFAyMlkv?=
 =?utf-8?B?ZkpNYURScURKTTVDeFJZTC9jc1g0MDc4Mm4wcitGdy9ZMHJEdGhVV2F1WGJE?=
 =?utf-8?B?aGZIZ04vUFA1MmhtaHd3cmlaYUdZaGlpd2l5MlR6M09wWDNBN1VRNHRlYi9x?=
 =?utf-8?Q?YVlu2U7PVHrEHf/xkHj672psg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847012a4-778b-4e17-281e-08dcb6547362
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 20:15:01.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs+jPybIeWjo3+tDdZNY8MyL6STYxLOnHRGiXjCgoAHupq3cyxAuXpUU6UgUo8M0q4gG4sl0KQwh6twWWPQnXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
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

sounds good - will fix them - thanks!

David

On 2024-08-06 16:09, Alex Deucher wrote:
> On Tue, Aug 6, 2024 at 12:00 PM David (Ming Qiang) Wu <David.Wu3@amd.com> wrote:
>> Add JPEG IB command parser to ensure registers
>> in the command are within the JPEG IP block.
>>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 +++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 ++-
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  1 +
>>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
>>   5 files changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 1e167d925b64..78b3c067fea7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1061,6 +1061,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>>                          r = amdgpu_ring_parse_cs(ring, p, job, ib);
>>                          if (r)
>>                                  return r;
>> +
>> +                       if (ib->sa_bo)
>> +                               ib->gpu_addr =  amdgpu_sa_bo_gpu_addr(ib->sa_bo);
>>                  } else {
>>                          ib->ptr = (uint32_t *)kptr;
>>                          r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index ad524ddc9760..6ccf61d7c13d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -782,7 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>>
>>          amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>>                  0, 0, PACKETJ_TYPE0));
>> -       amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>> +
>> +       if (ring->funcs->parse_cs)
>> +               amdgpu_ring_write(ring, 0);
>> +       else
>> +               amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>>
>>          amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
>>                  0, 0, PACKETJ_TYPE0));
>> @@ -1084,6 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>>          .get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
>>          .get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
>>          .set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
>> +       .parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
>>          .emit_frame_size =
>>                  SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>                  SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
>> @@ -1248,3 +1253,54 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
>>   {
>>          adev->jpeg.ras = &jpeg_v4_0_3_ras;
>>   }
>> +
>> +/**
>> + * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
>> + *
>> + * @parser: Command submission parser context
>> + * @job: the job to parse
>> + * @ib: the IB to parse
>> + *
>> + * Parse the command stream, return -EINVAL for invalid packet
> Needs a comma at the end of this line.
>
> Alex
>
>> + * 0 otherwise
>> + */
>> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
>> +                            struct amdgpu_job *job,
>> +                            struct amdgpu_ib *ib)
>> +{
>> +       uint32_t i, reg, res, cond, type;
>> +
>> +       for (i = 0; i < ib->length_dw ; i += 2) {
>> +               reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
>> +               res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
>> +               cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
>> +               type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
>> +
>> +               if(res) /* only support 0 at the moment */
>> +                       return -EINVAL;
>> +
>> +               switch (type) {
>> +               case PACKETJ_TYPE0:
>> +                       if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
>> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
>> +                               return -EINVAL;
>> +                       }
>> +                       break;
>> +               case PACKETJ_TYPE3:
>> +                       if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
>> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
>> +                               return -EINVAL;
>> +                       }
>> +                       break;
>> +               case PACKETJ_TYPE6:
>> +                       if (ib->ptr[i] == CP_PACKETJ_NOP)
>> +                               continue;
>> +                       return -EINVAL;
>> +               default:
>> +                       DRM_ERROR("Unknown packet type %d !\n", type);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
>> index 747a3e5f6856..71c54b294e15 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
>> @@ -46,6 +46,9 @@
>>
>>   #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR                               0x18000
>>
>> +#define JPEG_REG_RANGE_START                                           0x4000
>> +#define JPEG_REG_RANGE_END                                             0x41c2
>> +
>>   extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
>>
>>   void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>> @@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
>>   void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>>   void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>>                                          uint32_t val, uint32_t mask);
>> -
>> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
>> +                                 struct amdgpu_job *job,
>> +                                 struct amdgpu_ib *ib);
>>   #endif /* __JPEG_V4_0_3_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index d694a276498a..f4daff90c770 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
>>          .get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
>>          .get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
>>          .set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
>> +       .parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
>>          .emit_frame_size =
>>                  SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>                  SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
>> index 2357ff39323f..e74e1983da53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
>> @@ -76,6 +76,12 @@
>>                           ((cond & 0xF) << 24) |                         \
>>                           ((type & 0xF) << 28))
>>
>> +#define CP_PACKETJ_NOP         0x60000000
>> +#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
>> +#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
>> +#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
>> +#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
>> +
>>   /* Packet 3 types */
>>   #define        PACKET3_NOP                                     0x10
>>   #define        PACKET3_SET_BASE                                0x11
>> --
>> 2.34.1
>>

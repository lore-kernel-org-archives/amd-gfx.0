Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40DCD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 12:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F0810E417;
	Mon, 15 Jun 2026 12:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2u1qpvZ3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B7110E3E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 12:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTuBv+sdEJi3VV95fS+vM8v2ocZtYvVwB5EB1jRWx69Txs3ZrucDICizKhXHWD/9W4a4dMTJry9Wtg2pkMugkprvZlLtfvx9EDKvIsBaT0J9ldpyDl5255WMuIiTeXGd/jp+1xIvH2ROX/8W+XYtJNuBHd33CKQAhnIY7dQiYmcA/xN55eEKw25KsZaGrT05w/CPxmltUKjR9/fISiD8M/TbVk5fLJggBYa3+8nP+f7fzILGkHzOoe/3MgjC59f/y3E1Ixs6nlHHZaEevjhVNn+n8pPd2C4r5HKMGf0OQsb6yMVzTPJqPfVR+e+gByPWU+503DwXxORiQ356lhT7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPMuN4Pvpy60v9xAhFUjPoKt6NMH3bIehSxPSVF4T3E=;
 b=MG+WlngLpM2eAKbqDLvkd6RK3U/DZavCXuZq+dRpbIVcnJKzVRr/Ter7B1ddeeZf8dddXsMCuw20dKRw2z1XkfXCCgN5huh2GvoAtpwTjFFSORd3o9fPFGtz85EJYYHGz45qgUKWOMOFzOEltwCKsBg9ajnNEoeBeTBscrsV36LOTWy2t3o/uDwNH8CK3NoAHJRoSAIMqBZ8txH229m+n4ZoH/3Cbqy/Vx3H24u57+2Tw7V4+7dtB7P6JibSLRQNbBBLPHMvS5k6GoZbVmKceM9KyIux9/M8kQWFl1RatHTgMTWoYh/VCqIqVbl/nwxzQBBQgIVzt09Ef1A0XjGaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPMuN4Pvpy60v9xAhFUjPoKt6NMH3bIehSxPSVF4T3E=;
 b=2u1qpvZ33r4V+MpWk4sRfxJTy1umN6vSuyVC2fr2v5Ij+xY8jIVZAqhJIODapVrOWmX7PtPql0ZPVVudMIUL3H2UwfJMEFw+VKXMin+zNutRKjjqVXzi2+J0V1aQOO/rU9t1kRN8+BMbKKJsI/Htjly8j8+31pJHJ/LHiAHAtUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 15 Jun
 2026 12:39:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 12:39:30 +0000
Message-ID: <bf77a811-bce8-4257-b3bf-207c3a01a44e@amd.com>
Date: Mon, 15 Jun 2026 14:39:24 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Linux_7=2E1-rc7_regression_=E2=80=94_ROCm_GPU_memor?=
 =?UTF-8?Q?y_ops_hang_on_Strix_Halo_=28gfx1151=29?=
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Jonathan L." <jonaphin@gmail.com>
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com
References: <CAPs_=oyWXJuQ4VS7LNQgM=jGKPMDoj1OnagU9YNQY+7aEeabHw@mail.gmail.com>
 <4898269.vXUDI8C0e8@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4898269.vXUDI8C0e8@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddb1199-0cd6-4297-3583-08decadb24dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|18002099003|22082099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: umkizYNZpGJ1hdM/C4SafMoIkZFoFLt6EelGOMk2c+BNC6Pe5K/KqLj1fRQS9jI5c4ilc7b6gnVwS6NYQX8M8oJzJBu+CDiquZEhsJK5ny1VqEYpAVbXJvF0KZ74E1EkK7k/HTqibCRP+3NANyyc4BE/OxCKrpO8QTIicB0jbb7X0HTjc5hvnObFXniN7fK4IqB1T/nq2rXzKZFmxsjTRlHteKEgyhTFACkDxMcbaHi9gUnwQ1zJgDgl0SxgMaCBY+kYkJVup7Gk44fYwgyRaR4BHs4YiMd8zSegcUhbiwOsp1is1YnXrli0PiwENF95ofsrUGV0ZJv/acB8dC66YlUCRfnXzImhhi1QVUrF/BY4fsFwqhgMjV3Y3ylPBqyRiMSHj9T8L+Thp164JbwG/v9oP1zsIChTvq629oLCZqDDD+ekPdb1bUwUJAGVW65+OzkfnlrCyztOwJJfer7qvUs+ZHhxzmf1jwyDC5tLsWYdplbv6Un8T/SLeNNceQTTBDoSByPvYYM7BFyyIJaWWgIbOmtLjkiBqA0L8VCXqPkJab8862oeEuPKHnKKLOQm1tgT6nbidQtMxuuBp91pHiHzRp39v2L/Ar5i3mKte8a7/RtxW0hVSoZO8CwH1cAk2QPay866Jd5p9ctNEEpRTnKe28WGwy6mIUoLk9bp+SPuGAr0VjWIaPAfIgOVGrN6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNTdFpHYmRXVXZmdHZVamkzZ0xNYUF1RHVEZUJUNFkwS3ZNN0RGQnhZQ1Zs?=
 =?utf-8?B?RWllamZwTEo4UE5oRUdvMFlHS1Yxc2RTQjl0Z01Ra1k1Q2U5UGJaMFBFZkVC?=
 =?utf-8?B?MUw4NDJFNWJvdG0wVWdoV1g0bmY0WjQ2V2gwS2hHYnRkbnhQVnBpcnUydUZp?=
 =?utf-8?B?ZjhpL2ZzTVpDc3gyd1FKNGsxMktqUmsvVXR3d0JXcll1aUZaSTZVcGl2OFM4?=
 =?utf-8?B?QlB0ZmNqQ1hsaFFhQU4yT0RFNjRaWk5OYldXa1ZaV3AwUGpJZEZZZ1MxSzlV?=
 =?utf-8?B?dGdzMng4SU1hY0ttendyNVhtNjAzNEZDNGZva09OeC9FOHR2Z0R3NWdJVktY?=
 =?utf-8?B?ZVIyY1R1SW9UaVo2V3ZkUi9qbGFabHRtZ0pLd2dmQlBGM3IwWjVOL3BtelZu?=
 =?utf-8?B?QmhBd3pmSTZqT0M4ME13RTdmSU1MOE5NRVlCSEcvbHBZdVJxVTlzZ3ZZN25L?=
 =?utf-8?B?eHMrWWhyeGMzM3NzaXpiVW9ncG5KbVh5WW0yT0lZMkxuYisvV0lIUTV0aTkv?=
 =?utf-8?B?RmpqZHVjakZ5SHQ5aWxXZEl6TE1ZNFIvTGVjaW5DL1MwZms2YlY1SDFaS2Jn?=
 =?utf-8?B?c0hRZEFuK3dnNSt2cHp6TG1GQnJtbkJZbHFhTWpkdXRCK3FPUkpJZndZdGtG?=
 =?utf-8?B?NUtXeXNvVGpqeDl6aERYZlZGRDdzSm1pQUN4Znd3MytpeVBHdWFLeG1FUDBF?=
 =?utf-8?B?cU1BRjJHZzI1M3p1K1NHOGx4MmNTdjByV2VEL04wOGsrdFpmRE83dW1QNVgx?=
 =?utf-8?B?cEtRQnIwa0lPakNSVlMvZXNZaVZoQTdhVGd3TWRieDVqbktscFJCL2pGd2U3?=
 =?utf-8?B?SmdWOXBzbTVEN1Z6RVE2dW9qWjAwWUFmMnhzZVlkNUNjSzgyZm9uMzA3VFE1?=
 =?utf-8?B?cE5vK3drVGZrdkdMK1lwRldHQnJwWXRmZWk5WjZrRVl5TzdlTXh2QmowK3NQ?=
 =?utf-8?B?eS8vUVFYVFhqTlZVTmE2UmdYbXY0NEVJcitBb2JXZGNGWlpHeTNQTnRKcGJH?=
 =?utf-8?B?dnIwd0QxUW96S1FENmFveFFOTTYvMC82QklIVTNwMEtRMVhOY3gvbXVwVzdZ?=
 =?utf-8?B?MDJ6dm11aUxPZis5NUNYQzI5MjV5MHVSdnJZamJ6YUovbnRnV2NpMFZmOWZI?=
 =?utf-8?B?dUREZVhNZXpnajA3YnVQVFl3b1p4a3A4TE5KSXlodStqSUR6SzNLQngvUi81?=
 =?utf-8?B?UENCMDh5M2x5eVFUMjhuTmxrcUsxMU9TaFFDUTJBUWh6b2NHWDc2TU5CSm9W?=
 =?utf-8?B?OGJ5VE9BV29xcEo5TkVCTm90RVMvUFZUS0tZM2ZrMlk5Y1pOWVViVDNDOXJo?=
 =?utf-8?B?d0tQSSttYkVrQm9oRjlQSThzZ3FVQ3B3a2tSb3U5QWVPbnJXc1N4RGVVeC9T?=
 =?utf-8?B?NjFQcmZkb05TV2F4TEYyKzBNc3NwUWlWVjBzWTFqMFY3TDI3Y0dpU25MbjI3?=
 =?utf-8?B?bmFjTCtUakFsOENrSXNTRXlBd1RkazhtSThIRFJveHdZZzQ4NmlldnljTDI2?=
 =?utf-8?B?RDFkYTFYSVRrcnpITlRWdFR0MFlvblNNNFY3cmFiTlROT21Pa3ZRcmR5dlN3?=
 =?utf-8?B?RGJMRnJDWnhMUnlJVnBiZHZhVUtYNSt4MVY0RkN2L2ZDeDZGQkN4OW5KbURJ?=
 =?utf-8?B?SDVmd29LQ3BXbEpKQUVOdkd3ajVYWmJ0aHZSMUNMWGJsdklINWREN2didURm?=
 =?utf-8?B?OFUrOEl0b3g2ZHdDbkxXNk1PNUt0czlxcjZhVGZ5cXRMWlc1SEQ1WWYwWG1P?=
 =?utf-8?B?MmhnYXROM3VTWU5DVUlrK2p0TU1EZy9hd2Z0SFpwYVJwdHZtc1A5OCt5a2xV?=
 =?utf-8?B?emdHT0NrT200UEdVK1JPL09LbFlsRGFIVUd1eXg2UkFCQUJXS1NWaG9HZzIy?=
 =?utf-8?B?UE4rbDlMZ2s1YmpkUHllcDFubXZPMUc0SzJSSkE5RzZzRWN3dDM3RUZscEVm?=
 =?utf-8?B?UGlLNExDLzdzZzlvNTdnYzFuWEVPSkxnMmRGd2hOUkpuMnk2akMvY3YwcUI1?=
 =?utf-8?B?REdkWm8wcUlYME1uOU1YUnRjd3o4c29JaVZvbko2UGhpQ29lM3NDSVJUb3pD?=
 =?utf-8?B?KzQzK0J3bmhORFJPcWN4bXhVZEc5bHljdzMxZE1PQUFMeU5wWFdwYWwxdDd1?=
 =?utf-8?B?bkc0OCtyamNxdkY2WjB4V3dkdHhXUU9DY3pTQlJZeFZiSTlMS0dkQjg2bmVi?=
 =?utf-8?B?MFFXQ1ZYdWJsbXphN2ZGeTNKcmdPUkxBNStZOUViZ2c3dTYxbFJxMlZKdlNR?=
 =?utf-8?B?cmVYQTBkVkZhMllxWmt4SzVjR1lsYUNwSG55RXo1ZVp0WVB5UVVaenF6UVl3?=
 =?utf-8?Q?iWJD6u3ebZDQXd4ZuI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddb1199-0cd6-4297-3583-08decadb24dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:39:30.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QJrDPbyE8yEetZl+OHJfrYgU+UR68H6+JJYFk0LDeIgZpYx1ykOfFmqkz+u0O6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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



On 6/15/26 14:01, Timur Kristóf wrote:
> On Friday, June 12, 2026 3:12:29 PM Central European Summer Time Jonathan L. 
> wrote:
>> Hi team,
>>
>> I am reporting a regression in the AMDGPU driver affecting the Strix Halo
>> APU (Radeon 8060S, gfx1151). While everything works correctly on kernel
>> 7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU memory operations to hang
>> indefinitely. This occurs during tasks like torch.empty() or model weight
>> transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).
>>
>> I have bisected the changes in drivers/gpu/drm/amd/ between rc5 and rc7 and
>> identified the following potential causes:
> 
> Hi Jonathan,
> 
> Can you please bisect which of those four patches causes your issue?
> 
> Thanks,
> Timur
> 
>>
>> 1.  amdgpu_hmm.c (Christian König):
>>
>>   - 1c824497d: Changing the invalidate callback to wait on the VM root BO
>> reservation lock may be introducing a deadlock.

No, that was done before anyway. Just with a different BO.

>>   - 962d684b5: Moving the notifier_seq read outside the retry loop could
>> cause infinite retries with a stale sequence number.

That was indeed an issue but should be fixed on amd-staging-drm-next. Can you re-test with that branch?

Thanks,
Christian.


>>   - 58bafc666: Changes to userptr submission waiting.
>>
>> 2.  gfxhub_v12_0.c (Timur Kristóf):
>>
>>   - 40bab7c60: The change to CRASH_ON_*_FAULT bits might be causing the GPU
>> to retry failed memory accesses indefinitely rather than surfacing a fault.
> 
> Your Strix Halo chip has a GFX11.5 core which uses gfxhub_v11_5.c
> Changes to gfxhub_v12_0.c will not affect your chip.
> 
> Note that retry faults are not enabled on Strix Halo by default, and don't 
> behave the way you described.
> 
>>
>> 3.  gmc_v12_0.c (Harish Kasiviswanathan):
>>
>>   - ae4e30f24 and e3fa02872: If the new per-version PTE address masks for
>> gfx1151 are incorrect, it could result in corrupted page table entries.
>>
>> 4.  amdgpu_gart.c (Donet Tom):
>>
>>   - ec4c462e2: The updated PTE iteration grouping may be producing
>> incorrect page tables when combined with the new PTE mask.
>>
>> Downgrading to 7.1.0-rc5 resolves the issue. Please let me know if you
>> require any specific debug output or further testing.
>>
>> Best regards,
>> Jonathan
> 
> 
> 


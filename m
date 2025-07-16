Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD0C83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 08:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BE710E266;
	Wed, 16 Jul 2025 08:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YzouUAIv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C5010E266
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 08:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boxLQm2z2yMN3M8jsC0Ykix6sQGHvxunhNprezH0LM8+NQ2OxZBQlhix7Lfa0xxqT/bMWgnnb0VMn5xcyYmm8sk70y6zmMO5kcUoncgoPydiurly+tqMK7J1WADwc9NU6MY6DLI2hMQRRvgPnpYgMzgejW9fopuN8BSPMXR1hytkGQy8XxxshQKo2HqeaTJblSP5GsMH1FAuQa93uHuc7HwcywUMPbDkMM5qkvKGUjUZFupyQDxG2uLQUsNb+q/DPVo0KyHLfaM++F4U9n4pDBEEx/8rj85oyE5ggQeEvmJPmWjNNBRyyQq/eVYARZqrqwNK35qynxPALPXejUj/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZOHhj28e0+SVcL8BY1eV+bBu6hG98TO7lsb7HEeT7w=;
 b=ak/47iEtIYq3Jy58cdgKt2Ban7Ir7YK/5NNrDMCNx8uNyoLZpsIRf95aYGb8uPgaQVOpKqgQ5QS5xXOacaqOMaE7yHzlmrFaVk9HjhKiZuaLZTu8ucCSrnpLSBxBWz15UN1+JRJuzNbQbGFPdDh5wCPvnUTCjmdU4DNRETTKE2KaToYOaOSghOIvceB2jM9L1f3je1skWn8g/GqezZ319TCyUh54AFSUYg92IR35D6p3zhHzEk0J0nznY+XKSTp20emkWRWVkL4tsN8tC5618Aik1FX9Stc8SyRXvW6R8LW3huKbgqgdrttd1vbA4cundNyTTKQxqDBPxaqP94N87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZOHhj28e0+SVcL8BY1eV+bBu6hG98TO7lsb7HEeT7w=;
 b=YzouUAIvLWk1Jfp3uOfD9VM5iiN83zlfjNjNYPIe5noBWK8B5bccDc1bnSY3k1PFeavRimlj24wE1ojUmPP+Chikc2yEQ9YtAF5TxXDu5Ig6y7uQ4KE5b/3urSjhH0J1wJGNdOYU//XSlJr8ydamJWCNXtM8NR4hZXkjJiIsa2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 16 Jul
 2025 08:44:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 08:44:39 +0000
Message-ID: <602ee387-a906-4fec-90a3-2e6f48ab3028@amd.com>
Date: Wed, 16 Jul 2025 10:44:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on
 kcq reset
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-11-alexander.deucher@amd.com>
 <CADnq5_P1syhswwZ8KOJkGeL=as4jDESOaxD2=jWn=zb-Dx9TxQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P1syhswwZ8KOJkGeL=as4jDESOaxD2=jWn=zb-Dx9TxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:208:19b::38) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 88596a0c-d030-45c5-ef74-08ddc4450068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE5SemNNU2pMZlRBZmVzYkhsYjJzcVJpWDVoWlpzMEJKWnR2Yk9BM1BMRGJ1?=
 =?utf-8?B?SlArMEJwWUtQdS8xWWtYZ21EcUY1VTBQYnBDMzR4djJlcXUwbFBPcXh1aGta?=
 =?utf-8?B?NUxnOWhQZW1vMHdwdWxINXB2VjlUUk9WTnBlRkxRT0RVbDVMT24ybEhwRVhT?=
 =?utf-8?B?UE15ODlHc3IxTzAzaGU0VW1oZFhNd0hDMC9JSzRxZ1NFajM0S2djRHh4NE9N?=
 =?utf-8?B?c0srcThQNnBXeTB3dVp4Q09QWlE4b1c3L1RCZFJHcTZsVUZiRGxkRlRTaDEv?=
 =?utf-8?B?czJtWUNTMmZXQzQzc3NEVXVEVWVyZWpFaDlXM05kRjEzelFGaEx2ZnZqdk5L?=
 =?utf-8?B?UFpKUEs2b29RZDU1RGI0VnhBV1dsZkE0MjMxbmJtUTBySWdLYS9pOHl1WHJP?=
 =?utf-8?B?UXZPTjBZNnpFWE5QckN5S2l2WFFoaU5NcVRJNlRzb2YzWmFrbk9TOGFXaThZ?=
 =?utf-8?B?bFJsMmdTMlFmNU1WNm1uZDZ0V2ZGRnNBV2lPRFZEYlZscTBiT2lUTnZiQjF2?=
 =?utf-8?B?cFM3YjcvUGhrVjdqQmZKOW9iR3VRbXM5cXhXY2tRUTJ1WFVRMXJhNVd3ak81?=
 =?utf-8?B?YjRTZ3BGUXQvSWZndVBxNC9GS0M0eDFaWCtzYldQWm9FZUp5VXFzSGhRSmZ6?=
 =?utf-8?B?YTBwVWU1V2FUKzlzM3pPWm9jNFlBTVoxb29JUFV6MGVUNURKWU1EK2FxZ2RL?=
 =?utf-8?B?Q04zbG5hYUJYTCtXYUJ0VlhYTkgyc3Nyd2l2ZVhqM2VNQ21vR0ZwTTN1bmtM?=
 =?utf-8?B?b1kxQXV6Tk9XVkNuQldNaXpOOTlyNTljOERXOU12SjBab0hzU2szOW5RdVkw?=
 =?utf-8?B?L1RMTVg4Rjd2VHBuSFVkMTh4ckJuY0k2cjJFY1J3dzhrUnpGa1BVUitjbXRD?=
 =?utf-8?B?OHJJNWdEVS9vNUNNK0g5Nno0bnZzQ3VvZnErZTNzcHFBVit2aGhpVmFJTjN2?=
 =?utf-8?B?RER2YkliTzNzTjQ2eFBuakFDb2pic1A0SmlYY3NmQjJRWXhFeEI5YkxlYmpM?=
 =?utf-8?B?elgvZStraU9BSXZpZHFpQlM0RUkyYzZOTVFkbjJmY0pTczZ1UjEzWXY2TmRl?=
 =?utf-8?B?WHRyWVNOSWFMNTFKNFVVMXlNNFZUN1V4VGFlU3VGTWxtUmpubDlydEdabkhy?=
 =?utf-8?B?TXZGSytNUWpwV2t1RVN4blJnL3FNVjZIQnRkYlBPZlFqQkNoSXpWb1NmSnFx?=
 =?utf-8?B?NnRtWmdMSWdrcWpjSEF6QTRTNkdiaEY4bDFOSmQybjJLR2ZLcWM3bVl4bDJV?=
 =?utf-8?B?dk4vdWpGMC8xYS9qNXIrT3VVODM5V09RUjBMK2N5Q3EvUEt1dXRFMS9BaHk2?=
 =?utf-8?B?SjVOVGtSRk9jRGpkaktvaFFNRUhzbVJhSjRMbGFhVjdrcHVEdEpEaXJOWVN5?=
 =?utf-8?B?VWhTenp4cDh2MkJsTnhBd01BUDZ4cXBEQldNZHRQYkt1ZksycXlkdkppbzZ1?=
 =?utf-8?B?dDR1a0cvLzFaTE9ETWRNQTIrVzExSWo0bklOZTVUS3Z1TlJLbDVCcEtqWDV2?=
 =?utf-8?B?MFpkTFBGT1g0enVQRHRmSEUreGxkaG9tQmV3K0dXOUtHTnlKNnI5YjRmcXBJ?=
 =?utf-8?B?UmxKVFB0b3VzNmtESFdTcmRhTFUyaS9JbTM3UGh6b3NZVVpkaWtpTlplNnpk?=
 =?utf-8?B?N1pnR2hSajY4UmhKNmsrN050Rk81dE9nNTdSTjdXYnZuaXl6RFd2NHhFZWk5?=
 =?utf-8?B?Tk41eHNNdFAxUWtRWURpWk1ES2FWa2g4NGxWcld4L0p2YUI4djlOd1RKOExt?=
 =?utf-8?B?UlArQXJWWXExczVGZmtpS2R4MUxTNVRKZHdic2MvK2h0UTBRK0luT1NPRjYx?=
 =?utf-8?B?R2VLYjZDd280ODFkVXVZbnk3dzBONHNyTURYdk5LM0NFbmROUzFhUGsxQStz?=
 =?utf-8?B?bEVNcUdnZHJ5Q0s5YnBSWE1yR1BYUTFXeXdKZFFpdk5tRXA4RWR3VGpQeS9Q?=
 =?utf-8?Q?UjxodaByi5Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVEMmcwSU9KNm8vckk3REliNFE0S2RHQnVlSGRjRFg4Y1REQjZIVnVSdHpk?=
 =?utf-8?B?aWlrRjgxdmVjK2FHRHlaMUFjZGlrL056cVF1amlIWFZjREVhcWpveUUxbGo0?=
 =?utf-8?B?SUN3VCtSTkRmaDBPcGdWZW9tVUx4bjdlak1Fd0lQTXMxTVlla3k2ejV1WHJw?=
 =?utf-8?B?Z0YxQlAxaHVCQk1VOXhBUU41ZjlzVlEwQ2pTTkJmcjRsOEkycjljbnZiRmhY?=
 =?utf-8?B?cFlkaXp5WG9iaVEreitzcW1iQndsbGxMOTJlM2lHaDI4VTYrT3hnZlViS0VJ?=
 =?utf-8?B?RUpHdnlEdUV4RjY4SWsreVZkN0d2SjVoWlFTMytzQlRwVlNwKzFnOHJhcTh3?=
 =?utf-8?B?Vk5OYzM4aW1haXlucUlNcUFucmpSTUpGK281a1FOSjF6c1EvcUJiT24xSnpT?=
 =?utf-8?B?N2Nqc21WZFRzTEhFNUgwVVlUYTVFRGFiVzk1dEZjZG5VbHFvenRjaTdWa2JQ?=
 =?utf-8?B?VmNpMjVRZm9JK29TUEQ3ZE9oVG5ETE5QTkd2MHNGVlg3NTJmQ1NuaE5OQVlU?=
 =?utf-8?B?VUx2ZXJFMEtrVnRIM1gya3A4V3NZQmwwM0x4L3JRUmtVUStwQjY4dEVhZEhp?=
 =?utf-8?B?NzV5Y0dvN0lucERQaHJoSUtBemRRei90VVhpTkNtN21UOGU4L2x0ckhHejRj?=
 =?utf-8?B?NnhBNiszcE1Id09SRnJ4UkJ2UGpVVTZ3N1NEVUFnTHBNbGRSaVBWeklrSmRL?=
 =?utf-8?B?b0JMQkpkdVFDek4xNXFEb0czU3NIS3pSTmNKSWFyOXVEeFFpZ0wxQjVycXk1?=
 =?utf-8?B?enR5c2VHeW43L3NhM2RvcmR2ZjBmbDJsbldSVzlqK3QyTXRJY1A1Vkk0UDVl?=
 =?utf-8?B?OE5YQkIwNHh3Y1NWVkw1cGJOV0ZCdFlvOEJXMitaZ3duVkp1VWREbnhxcVFT?=
 =?utf-8?B?clVkcWp4YVh3a3I0amdFajBIVGVjbllnSFdBUDkvYllLWGNMQjlrU1F1YlFG?=
 =?utf-8?B?MitaZ3dwQUlIQ1QybGlRM2Zpb2NzWTFudkZIYS9aRWZzY3VMd1NNZnRxdHFt?=
 =?utf-8?B?SWJQbmo5TFVpSnNxNkhiM1ZXWGlFUHR2Y1RSVjZjcW56QVBSY3lleVR3Rm1V?=
 =?utf-8?B?UnhvMHI3VlNxTlJCZmUwU1FkNkh3YTArQWVOSGFDSDcyUmNYcXhMaExpVXJO?=
 =?utf-8?B?QUZIRWliTGxaSGhKeWVZQlpJWHZNeno4aWJ3ckxzSFJsQlE3amJUUkp6TlJS?=
 =?utf-8?B?NjlTeWs2eStiZ0tSM1hndzg2bDhoQXd0YTdLSFZhS3R4TkpoMS9yOGhxdEx1?=
 =?utf-8?B?b1l1MmhoaWo0azdIN2tQMmN5S2d0cXNqMVBlM0JiT3RrSXFqVWRIUmhYbFVv?=
 =?utf-8?B?bmI1TCtzaTQydkQzMVRLNEx5RlJmU2NsWWQ2bmNoUzFEWnZSanJZUk14MnpQ?=
 =?utf-8?B?TlcrQm0yc3lkc3BBM3JZN1dMbldrVkI5a1hra1p0OGdWSENrbWtybHQ1b0ZM?=
 =?utf-8?B?cFIvREVKeVV0dGo0Y0c1RGNaNWN2ZlZZREgxVWhBN2xzWHQxVC9pYUE4dzho?=
 =?utf-8?B?QnZweGw0c1hXT2N0VUJRZGxRak5pb0JDaFpxQmJwNjd4ZmhaL1N5UG4zSHdH?=
 =?utf-8?B?dktVcmVQS21lRzZXSnY2aDcrNGhyKzhVcVN4K1VJK3dJcERQWnJXVTg2ejBx?=
 =?utf-8?B?dUdvVzZ5dThOaTRwUE9xK0I4STBYWlV4YjVGc1RkSmU5RUJaUUpxMW1VMkJq?=
 =?utf-8?B?UmtCRnVQcFFLdXpXTWZPenVEcnJVTGNRYS8rQXpmcWhCdFp2SzM4aEl4cFph?=
 =?utf-8?B?emlhVWl3V1FFcE4yNHREZE5ZenE3SVJkOFJFSnRjeVRJV2lKWmdpZVl5ODJ0?=
 =?utf-8?B?Mmp5L3ZyaWNpQmFNMmtoc2lBTjg0OURWQmV6U3JwbFNMSGpLZDYvNHpWQkFk?=
 =?utf-8?B?YnY1SmJibVQwdDQ5TlpLamRhNnBvcnFLb0pGd0IxUGJpdk9HNnhRSkRNYWFq?=
 =?utf-8?B?NWNYM0lPZkROKzNUZGVQRVB1dGhCQUF1dXYzRzNQWjkwVXFyNjVDYnpMZWQ5?=
 =?utf-8?B?SGRnNlQ0WW54anUzWWcySnFZNEFpRUI3NlcxT2FjUHE5blF5eHlGclE3bG02?=
 =?utf-8?B?L2FDcTl3V3VCMi9zT1VTUWo5RFgvZXBpZGZzalh1MFpINkJaK3gzcC9JNEtn?=
 =?utf-8?Q?HNADI9Oz8jh0kciTANUQ0Tk4x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88596a0c-d030-45c5-ef74-08ddc4450068
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 08:44:39.7475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAzZLxc00SrxvdSnEOdUK5ApS02O3C7iewDmUWuAPc6Pau9oIwQAdwXeSCtpPKWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

Patches #9-#22 Reviewed-by: Christian König <christian.koenig@amd.com>

On 15.07.25 18:12, Alex Deucher wrote:
> Ping?
> 
> Alex
> 
> On Fri, Jul 11, 2025 at 6:48 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Re-emit the unprocessed state after resetting the queue.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index e2ff4b373a319..d80f1fb261d1e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -3569,7 +3569,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>>                 return -EINVAL;
>>
>> -       drm_sched_wqueue_stop(&ring->sched);
>> +       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>>
>>         spin_lock_irqsave(&kiq->ring_lock, flags);
>>
>> @@ -3626,12 +3626,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>                 return r;
>>         }
>>
>> -       r = amdgpu_ring_test_ring(ring);
>> -       if (r)
>> -               return r;
>> -       amdgpu_fence_driver_force_completion(ring);
>> -       drm_sched_wqueue_start(&ring->sched);
>> -       return 0;
>> +       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>>  }
>>
>>  enum amdgpu_gfx_cp_ras_mem_id {
>> --
>> 2.50.0
>>


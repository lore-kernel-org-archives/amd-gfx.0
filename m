Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A93D31761
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 16:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D7810E079;
	Tue,  5 Nov 2024 16:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vRXFkTWB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6535710E079
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 16:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgmYCXzyV0mja1xGVjo/dWjcYRpr8z73h5+bFKKZe7EAalv1BpKdjQW3xirnPijphKIBKa4zzoCYuF5V+mxZ5+/2nn89k0eZGkko+wcL/P1YyO7irHYZ+oamg9yS3jb+9xz+FkQTomBX8M7qXBZUWhtIuOcpMELzrc0OUSUIHSggVEZGmhIO5KCvrMV0cUMa92Ui/lfWN2NOCcOyIMHqh4N4RoZVNsdo4QQCZI8d1GZyVZritBP9B6N6bY+SyKqcyaouSlZN0+N91uCXZS9ylhdXp2v9gVPCBcBVnlfLHjKR9F9K0C1i9GvTki+iVjVDh8ynkidvrleJNXifXDp+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM4f5bcRAVhJYoMw/UVmot5qbzLPRO3Ga5ym7SydJZw=;
 b=jWwCk5Vtze+984R6xjNZ9nuoH6p5JvIPlynIp+I7ChVSfGKZq+IZfVur+QugTtmgkhar6QUyAAb6LLMAjwkEPbpoEpzvC0EhiA2NCRNTz5/G0jpyS7qHvdJH9W3GQI+4ohnSsaKoRL54/qqGpmYf8oQgNzJp9fIJLtqq9f/ha9H6kGEUGBR6VpDrp8Eqk4/FwMG2+A2CEe8Ka8nXB2G94aFr0goCh6mbhljs2+Jcv1cM9kxxyLyMbvmdzCHTDPF9+s6snm3m+IKbeprIOv2tECGkCUyJnee0ZIMQ45ZPTRN29KH7W2VSFErs1/QTP5lvGzXObXJZ9/tTB+EoBn5FVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM4f5bcRAVhJYoMw/UVmot5qbzLPRO3Ga5ym7SydJZw=;
 b=vRXFkTWB02DZZMBaMK+pp0w10ach2AWsEwoqgLjqoQ3uy5yf6eFqcxMFmxXWGUrUicwGxnd1uoAFcbHvrCeFEr/X2alcj+ECfW8si0vSMJxORLcxYiW7dMN5ox1JZ9SVeKcJvyU2KRlrPb2ch6sWlc/csMw1OiRn4cIBMK626Bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 16:34:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 16:34:56 +0000
Message-ID: <3e8ece68-d9e7-4037-bc99-d3f9b78128b5@amd.com>
Date: Tue, 5 Nov 2024 11:34:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com
References: <20241105023332.172404-1-Prike.Liang@amd.com>
 <04d4ab32-45a1-4b88-86ee-fb0f35a0ca40@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <04d4ab32-45a1-4b88-86ee-fb0f35a0ca40@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e8a0fe-42fa-46ef-7709-08dcfdb7c858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3dnTW1LZTIrSkhINUdSVDlZSHhmQ2pzYkIvNGQyOCsvT3lySENXanQ1aFlU?=
 =?utf-8?B?N0tBcmpnZ1ptTWZhWHJIZCtvVXpxRGRnL1VoL3E0bm5DOUpFcm9EcStjUmEx?=
 =?utf-8?B?WWxzZzdXTkRTaTlwcmRrZTBzZG9iWGpIY2dISzIxakJIdmdlVDNvTVBvS0FK?=
 =?utf-8?B?Q0daMjlXdlk3Mitjc1R1cmtxdzYrUyt5VEJ5U3NFYnp6b0ZZbkVkSXZxR2kx?=
 =?utf-8?B?OTVNdWVtYU52QmRPWkl4RlNyMXBuRWErRGpvSGlhU3FiOFppVlZhdHdLZXVH?=
 =?utf-8?B?YmRpZXI0cGN1dEhkQnVtY3hDRU1ydFc2QmUxNUpwejNacDVLc2NkSnhIeGdh?=
 =?utf-8?B?N2tKMGNsRFBuVHhOSm40R3luMzFWWmhWa1ViSkYzUWZLVzFJeURPNlBudG1t?=
 =?utf-8?B?ZDRoeFdBemladjJWMmdQSlBoYlEraDVod1lJMU5tUjZPdzY2OEhndUR5bTdn?=
 =?utf-8?B?cDRqKytYMW9OYmpwYVY0L3J6dS9abVAraVh4eEdLQlVQZWlteVdHUEM4ckpr?=
 =?utf-8?B?OXl3K2JQZDdUUjFLVUE3aEY4Q3BKUmM1K3FPY2YxMFpvQWJuamxDLy9qZGlL?=
 =?utf-8?B?NXVIMXNFNW81cU52TkdHUUE1YlBzNUVvSWJqZkIvQTJCc1BaM0JlbDRQR2pS?=
 =?utf-8?B?TXhQcWZhUGUya0k2Um5YemQwWWkvTVZtUW41bWNBR3k1U003NURINHhsY0Na?=
 =?utf-8?B?aEZlYi9SWWt5NUFxaTlTRDcwWjhMcm5MVGFNMG5CY0g5NU9ySWNhMUQ1cmlm?=
 =?utf-8?B?WndlVnA3aktGUndzZjJ1SnVUbExPSjFZMWVIakhjU3oweGxrQTYva09KaGxj?=
 =?utf-8?B?L2paWjF6NDZQbHFDdjhWdFpVb1E2dkJKNndvMnl4cWpHWDVxWGJzTjdPR3Ru?=
 =?utf-8?B?L2lHdzcxMkRrVHg3L3k5WlQ0VVg0V08zNEZuRm1ncFBFVXM2RnlYSnBXZ093?=
 =?utf-8?B?dFdXZ2l3cEEwMkpRWjYrZVBxS283SXdkS1h0aEt3NU95bHo2dWh1MkhPYU4r?=
 =?utf-8?B?dlBlWnp3MUV6NGcvUldiTXR1dUFUck5ZNzFsU2dnelp6QjQyTjRqMjgvcVBU?=
 =?utf-8?B?WHAxV0JEZWtvd2MrNmpiWjBwZ2QwOWw5K1oybUEzeWlVYThCWTNTczkzUTZv?=
 =?utf-8?B?bFpNU1EwR2tmMnIrVlBpeSt1ZGFpV0ZvbXV5cGNtbUk4MkhkS0ZlZlJOMkh0?=
 =?utf-8?B?M3JtcWpvbGZWazhwUlNUOGVDbytJVm1aVW1KUDA3aTFWZW5JYUNUV0xka0hi?=
 =?utf-8?B?bTd5R2FWL05Ha3FRZFcwdnJuWmFlQzVNYXNjS2d2NzVWNTFwZkNKSlJSemE4?=
 =?utf-8?B?UUtOUjIvOTJDSXZvU0YrQ3o4VnhjUDRtOStvbGZoek9TRmdJOGczYk9NK1Uw?=
 =?utf-8?B?Z09hN0xmN0FMaTlOL1RsK05nVVV1S0tPSjc5bU45T29LMllMTlFhdUdoa1Er?=
 =?utf-8?B?MDcwMjJCYTZaK1d3Sm8yS2NmWVJ1WlhJRXA3Y09uTWpJN0V4bXlIUlBnVHlq?=
 =?utf-8?B?T1ZYMFVycWJNajVWbmNlM25OVkdzYzJDbWYvUzIza1ViVXdOK1IzNVBLemNp?=
 =?utf-8?B?K2hHbFVzQkpGQnlCb3hNWERTVG5BS1ZGRXQzZXBaY1R6NFJQWHBvL1dwT2Js?=
 =?utf-8?B?QmUwQWxyTWpTbjN6SExOZnpEczYweTFmSzlDc0pkN2dhT3VobHpiWGZJcjd1?=
 =?utf-8?B?M3dud2wyRUJEV3BUZXE5a21CN1NMaGFjcFkyS2NwNmxzN3k4b2g4L2VYSWFX?=
 =?utf-8?Q?X5hNuGhP6scb7daO+Yl1IUg7+b99SCECJGJM6Us?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFQSEFSUndtVG4zbGxQcEdkUXNYYnprWTJtWmhkREd3YlpLR3Z6OXp6aUtH?=
 =?utf-8?B?aDN6MCttV1VsZnBCVmdXcTVwdHVuRFpXc2NtS0NwV2l6QXlaK2trclgwUGdQ?=
 =?utf-8?B?Y0VEK2VDUmxiQVlEUWU3SW1tY3NQNDFQc3hlMlljNEFRUGlNbjVtam5aRWYr?=
 =?utf-8?B?OVZMVHowS2tvZ2g4T25sN2NhSUFsKyt1aGtZam9nSVRYMjkyZitjTy9ZRHNh?=
 =?utf-8?B?K2krOXJtV1MrZTNFbjhvMUxYK1EwSHdaeFBFKy9McTNOZnN5WnN2YVd0RE0x?=
 =?utf-8?B?bm5mZE96UmdwTVJBQW5ELzUyT0pFWTdYM0E4TFlua3JBWUFEeSt3TlhycnFW?=
 =?utf-8?B?V0FpdWVjRlFUVDFPTEpWbmFqck54QnZuNklncm9ZWmVoN0t5M0NwWldLMGdS?=
 =?utf-8?B?bE16SEh6b0lBTWkvSDV1R2M2bDJWU1hnYnRTd1NBck1yOHdRbXU2TUVjWGlQ?=
 =?utf-8?B?NUF6bXUyWHppdEhzUlpuSnFDSnhYZUFDcTM0NURlY3FDMXl6TnhhREU3bXBu?=
 =?utf-8?B?Mm0wN01PMHhUaTh1ZDA3MEFuZExDajlaUTVQNnFWZHFoOEx4ditFRU11QVRz?=
 =?utf-8?B?RkNlelNHTm4wQTdMTEtsYzloSkpFdDZVNk1PK1h5azQrajlpMC9rZlo0dnEz?=
 =?utf-8?B?N05nREI5Szd5a0d6WEVxY0NGYTJLRklhb2FlRU5sU21sdmI1WTV6S3U4Y1hp?=
 =?utf-8?B?L2xyak1TL3laVFdOY3YrWjZtSGVlclZNZnJvdTd2K3RCT1IxQkZaWGFHMkRU?=
 =?utf-8?B?UWRIakxWNUkwaXNyYUtBZmUxV2o3bm5XTmY1VDhZMWtVRUE3QWQrYTE0Qkw2?=
 =?utf-8?B?OWpLdWMyOWRWdENmbE5Qb1lCNmdORGNWcjZsNFMrNlYrQlRRUzFtSFNMWXRF?=
 =?utf-8?B?RVRBalhOM0NRSnd1endpZk1PTzMxbEEyNWorcjRNYlRZNVFSaW1vNzljSm9V?=
 =?utf-8?B?d2NCSExHbVRSci9QaWlFbG1IcHFaWFZYMmtza1NhN09TWkdjUW9uMzVEdHhE?=
 =?utf-8?B?V0wxcFQ4c1o0UjlGYXVodFh5R0NrMHo5M1VtWHMwMXpaZGFEOFpNU0M5R3BO?=
 =?utf-8?B?VFVjNnlGSHRId0RWbnRjYXRPVGdVSTBiMkhLV3JrandOd2tqbVlpdmc0d2Z0?=
 =?utf-8?B?akk0QnlFait3SWZhbEVDbEhUVnZXbEtFZDdCSDBVczNoeWQ2WUYzU3lLOXpL?=
 =?utf-8?B?b3VWZEphb1Y5WFVnbmFPZEdSMTRkaWhiazdJb0REOGlIUjlBQ2dZcjhTUy85?=
 =?utf-8?B?a0k5bEJ1Y1pTM25CN1BYVzJCOTBHM01HZDVUWkVrVHA4RFZNNHEzSktJU3Uw?=
 =?utf-8?B?LzFGdmJscEpIcjFpYVlLVk1OT1c4cXVEMnZiNmsvdkZaQnZxY2pRd3BwOHhP?=
 =?utf-8?B?UDFxS1lBYVREK05kNmR4QldtWW5LZjZRRlEzQlByTHFIS3hQOHU5MjRwb1k5?=
 =?utf-8?B?bFlFTXZWWXFXVnhZRi9MNmZrUG1rWTVaOG1uWHFyYUNLc1g3TFJFTWZwdXF1?=
 =?utf-8?B?cWYwUVNpWEI0NzFQa1hFY2hXbUlNQ0VHZk5wSHJPRGF3anA1TWN3Y1lxc2Rl?=
 =?utf-8?B?YTYrQzVsUTIvU2V1Z3F4K2JzZDRlSVRraWNVRFIwNmJlamhkTVpPQ1lWZDNI?=
 =?utf-8?B?bFlFbVZkcWQya1BkMGZqb01NZGFTUE9KTlZaUEJiR3VmanJUTFZKTWZzdVJa?=
 =?utf-8?B?cmZjTlJFeEQ5YUJUaGhXQlVVNTNTTC9pSE41eDRRcjNsV3ZqdEs2TzllcU5L?=
 =?utf-8?B?MjFMQkNndmVHVk1YRy9UYmZqenhmOEpvUHBPamd6SnU1VFdpYldELzRkM3lY?=
 =?utf-8?B?OE8xRTRucXFleWE4MzFzcGx4emdZeHp1MWU4MzV1V002U3h1ZkI3TmszRkVo?=
 =?utf-8?B?MER2emdkejUwd2EwNTA4ZFplNVI0eTdLTDh6K3J2dW9BZFlCTExRQ1pueEZw?=
 =?utf-8?B?a2FOT25EaUJKSmxSaWI1em9mYm8yVDFBeS82ejZTYTN0NmF0YndlRW94QmlB?=
 =?utf-8?B?THRKZ1lJdkRTaTNZL3Avdkl4UUlhRmo1dVovcm50cHovVVQxNXVhMkpMR21s?=
 =?utf-8?B?YWNKNWxKVVZZWTBmNTQvMGFrRVJBbzBPZjlmTEEza2FySVVzYllzUyt2MFg1?=
 =?utf-8?Q?1V+v/Ff1UY2PsWC84+owDATd0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e8a0fe-42fa-46ef-7709-08dcfdb7c858
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:34:56.4821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLcPkFVcqhhF0hnLEQdQIk4SJtjpLXbSxH55mZ8KWv9r8RVtwwrgW0zl+rgU7CFkKgaOICqSulvLTjMnE+8Kcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

On 2024-11-05 06:04, Christian König wrote:
> Am 05.11.24 um 03:33 schrieb Prike Liang:
>> The SVM DMA device unmap direction should be same as
>> the DMA map process.
>
> At least of hand that looks like it's only papering over a major problem.
>
> Why are DMA ranges for SVM mapped with a direction in the first place? 
> That is usually not something we should do.

These are DMA mappings of system memory pages. I guess we're creating 
DMA mappings only for the access required for the migration, which is 
not bidirectional. I see we do something similar for userptr mappings 
depending on whether the GPU mapping is read-only or read-write. Is that 
wrong for userptrs as well?

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 6 +++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index eacfeb32f35d..9d83bb9dd004 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>>                mpages, cpages, migrate.npages);
>>   -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, 
>> DMA_TO_DEVICE);
>>     out_free:
>>       kvfree(buf);
>> @@ -750,7 +750,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       svm_migrate_copy_done(adev, mfence);
>>       migrate_vma_finalize(&migrate);
>>   -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, 
>> DMA_FROM_DEVICE);
>>     out_free:
>>       kvfree(buf);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 3e2911895c74..c21485fe6cbb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -233,9 +233,9 @@ svm_range_dma_map(struct svm_range *prange, 
>> unsigned long *bitmap,
>>   }
>>     void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t 
>> *dma_addr,
>> -             unsigned long offset, unsigned long npages)
>> +             unsigned long offset, unsigned long npages,
>> +                enum dma_data_direction dir)
>>   {
>> -    enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>       int i;
>>         if (!dma_addr)
>> @@ -272,7 +272,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
>>           }
>>           dev = &pdd->dev->adev->pdev->dev;
>>   -        svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
>> +        svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages, 
>> DMA_BIDIRECTIONAL);
>>       }
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index bddd24f04669..5370d68bc5b2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct 
>> svm_range_list *svms,
>>                    enum svm_work_list_ops op);
>>   void schedule_deferred_list_work(struct svm_range_list *svms);
>>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>> -             unsigned long offset, unsigned long npages);
>> +             unsigned long offset, unsigned long npages,
>> +             enum dma_data_direction dir);
>>   void svm_range_dma_unmap(struct svm_range *prange);
>>   int svm_range_get_info(struct kfd_process *p, uint32_t 
>> *num_svm_ranges,
>>                  uint64_t *svm_priv_data_size);
>

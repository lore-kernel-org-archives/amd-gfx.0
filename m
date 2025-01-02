Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA358E7718B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 13:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851FE10E330;
	Thu,  2 Jan 2025 13:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Us9pilEe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521D210E330
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 13:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh5RdNF/Ztqsmmjt+eVbE0YlG8vZO/EAj+czQKM7ajOx6KWWlAcUYuP4TYvK9kaJ4cauGA2gtmgCYospyMdXV47sX8VuvwPJyuofq7EmWza9nP5Ldt/VtXEMrZ5h1me7xe3PSN3/9/QlP2qeoRMVa8o+CR24gRL1PgJVRbm3E3lJFVCgm9SeV+52kLF+xadVNplgerOMOPUsux5Ma25d59uzU/BUY2WlhGItGHEa5Pi2WOj/2jvGR7qsZcuv4b3YPo1jrVHBp2xMAj1dojPVxLeRbwhiGCtt0r0NPFxnYyQd32pfhjIIakBBUQrg09xVNVDw5SBjgibsHLLzwWj6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWcJDk8In8EkzNd31H772WNx5hCwsSzlABncHdntYvM=;
 b=LU96U5pB2Pp+sewn++An85pN67XRrNs9kpxYhkCJfvfNKXhqCQWijTxQVoqFxgdI7n8DK2Q0PNSy20Lh9gWBboICy3agtdEkqq6ATgLl8OqH0cNGwVfJEY1NLSyvSYVaL9/9udzil/sBI6fxq/eKCha9NRwXNyN834ovmALMG0Z0Y8OY5cMZfMddmYdATxX2SBi0qj3TERCMIYWC9TBOyyBcyC90aJVCB5XHwKix914nSsVuQ+uoFeXP2mm4P7SZVYjhgPQEb0KAalIRhxLLddPYG4Q831X6NwNnzgw1PhqV9WghFc2dbF/iPryoBqWWX7enEKyFSsUvIik3gz6zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWcJDk8In8EkzNd31H772WNx5hCwsSzlABncHdntYvM=;
 b=Us9pilEeC7OxVgkQDAAUIWbiHsAC1KxcpCBYJyPNPsiNTIEyeSMUu54NnQ52tQaxjBnmQv4AQ8nqVLvK4Zo5QJB5CYI+DCuMMlFnsI3ZGV22gLjD5qsnaym67A78kzdL2QIaKzWPKMSKM+cg4Iww3a2SgKWU5GScB3spvp39Snk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 13:45:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 13:45:48 +0000
Message-ID: <0757a5c8-5aaf-4874-9c7b-1ee20aec41e4@amd.com>
Date: Thu, 2 Jan 2025 14:45:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: Use memset32 for IB padding
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
 <20241227111938.22974-2-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241227111938.22974-2-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 548b8604-69d6-4c1a-ddf9-08dd2b33c364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUNZMjJPWTVLY1VWVXBLOFNuZ0xqVXNzV0VUU3JhS1pEc3g0OTJkNTZubndl?=
 =?utf-8?B?ZVFpeUlWdmRTT3VCMGZQcFJtZGZFY0dUNnRlQXgrbEFYQkpzYUs2K0VYU3Nn?=
 =?utf-8?B?aENQTVdrL0VMenlDbnE2aG96WEFkRXEyNVBkRzMvRkFnSzV0V1FsN0hyNUFi?=
 =?utf-8?B?RTFVWnRBRWhGdDJKUGVvTVRwdGxSeGk3eEVXaVhFZHAxMk45QVROZGgyN3JS?=
 =?utf-8?B?bVN0Z3JGWTRMZHlneVkwdG1ieDNNUk5tMXVxblMwcCtWYytMQ05XM0t3Um5x?=
 =?utf-8?B?c3lIUVNuMmFxS24vUUZyallpcUdoSHhTbXVkblNlU2c0MVNXU1ViUU5ScTY5?=
 =?utf-8?B?U2gza2ZlbEpIb042OFJvc2xtbWNzV1FLTjhwbExqQmVqS1hDNlhadE1sSDRD?=
 =?utf-8?B?ZVJ4aThXdU4yeU5OSmc1TkliMy9Sc1BNakY3RjVOU2UzM2NDRFZ0clAzRUpo?=
 =?utf-8?B?eDM3VnRCY0JRc081cmNCL0lvN3lIM2IzZ2M1TzBRTUlPamkzaW9ETlRHNU8z?=
 =?utf-8?B?L1ZkVUswRG96eW9sSHkwb2dxbVgxakk1TTFRL0FZMWpOS3A2eTRxS2VIUVph?=
 =?utf-8?B?MkxST3Ezby9zU2ozYXNTMlYva0RMM1dlUzd6eUN0UmVJaWNHVVJ3UzhpY1lO?=
 =?utf-8?B?VkJrWmpaS3JTblR1QjBZVXF0bXRlNjNEZUEvd1BvcVh1MzNSaVdOK1l4dEl6?=
 =?utf-8?B?ejRwVnNZS0dtMzMvTW5la3oyYmpOQm0wOTBiRzVoZGZYSVBQRWdNYTB5UDJM?=
 =?utf-8?B?SDRiN3VWS1pybmZndVhtMmlKK3ZGdHNINmtrdVRsRzlKdmtydjB6eWtqdnFv?=
 =?utf-8?B?U0tuOUxKd3E0Y29SR1RHZ2gyOVRCZ0VVdStvTmFoNHU4RlgvNXJZRm9EbDJs?=
 =?utf-8?B?MW1qVzJhRURrQWFaMklHVXh5Z2Y1aHk1N01vWVduN2duYTdxUFFrNGtzVE1y?=
 =?utf-8?B?cDArZmJuUGNYTmtDU25jZ1N2bVlTRDBMWFdkM3dkTE9PdThPSFJiRFd0VEJ4?=
 =?utf-8?B?UFptRkdKY3dKVEFYZWpCT0VFZ1pCZ3RQYnJqOCtvZlJaTS9YS1doaTNHTlRr?=
 =?utf-8?B?a2dDU0tHMmh1eTc4K0hRZC94QUFyRUtTT3grcDk4WGNXRENKRkt2a2VPbnVX?=
 =?utf-8?B?M0p0VVVvdWZyNzR1cUQvWXo4UzVhek5sM1YycnVlUjI1MUh4WW5LeEJXNzdy?=
 =?utf-8?B?OEczVjdCTDZWWnB6SXhMTlFZSkdjUnpoV0RhMFlOUktIdCt6WGlxNXdEK0lK?=
 =?utf-8?B?dU9CMWpMeHRaQkMvNUo3cWNFajh6OHBFM0ZvUEIzVDFYaDJpTnZGMHNlUW1v?=
 =?utf-8?B?MXlkejZ2UXNZRDZwbUhxeUpVYUovVlBvMHJWSENpQmpOUFdQQUVqRnZ3SVc2?=
 =?utf-8?B?VXlhR0JzdmZwNlpYdkxVMnlPZFV3dkdzWmNDcG90OWRZejR0d3V0eFdBYmRp?=
 =?utf-8?B?QWNacTFrcFJBUDFwZTBhb3lxNHFVUGQ1R2JaQXRKZ3VOZkdkSmo2b0FDYlBW?=
 =?utf-8?B?NGw4NlFyNllsNWRQbFhTQ0lyODhia0UvTFdPMTlYRktadjNYWHAyRXNZV3Zt?=
 =?utf-8?B?b0dyMXJyd2t4aHBnTkw3OCtCejNkb1JTUDBtRkNhU1FKMndzV2p2NitzVlVs?=
 =?utf-8?B?SGxQWXptcFdHblhyRVRXa1B5ZTBqZGhYckg2K2doaW5TS2VPTUZEZ2hySWMx?=
 =?utf-8?B?MjJvcTY5dElPdnp6WTBseldUODMzcVRUaUQxUDBDRGpyZ3p6TzlmcE5DSnp6?=
 =?utf-8?B?NS9TNDhQT0cvbEJiaU1BM1lIZG5CTEtyalZ0ZWlaUldlb3RUcXhxaFhHaWlE?=
 =?utf-8?B?dkhQU0tvTW1LVWpLcFJPWi9ROC8ra3p3SUdCb3M4WlZ2V252VE01T1pxUldF?=
 =?utf-8?Q?hCV+cHqp7V7e1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJoQ2h6RU5iblR2RXdqQmxQVTA5QWdqdnQwNTBBTm45Y2lMZnFCSlI4c0la?=
 =?utf-8?B?M05Wa1JxZEpNQ1NVTEFFNXpGNExFckY1clJFSm9GYVdmZlBzcjQ2ZnRzVHBT?=
 =?utf-8?B?RHFSZzZYZ1ByRzhMeFMzNUFNNHNrZjIvZ25XOUhWYTMzaTZWRHpIT1dXc2Fp?=
 =?utf-8?B?QnM2WkpEVWsxeHpHM21FTVhxSjRWWFV0Qks1M2oxeG9wdkRZbmJMSU51Z1Vs?=
 =?utf-8?B?VXcwTWFZUHgxQkNoVjhlbUZrUUZGRjlLL1pINnlrVU1VZlVsRGM0L3VGYkVQ?=
 =?utf-8?B?djZqYnhTMDF6cGk2Z2ZDbjZCd3d4ejJWWjlhNjIwTEpUVDQ1d2M1aEZaL2pq?=
 =?utf-8?B?NzFPZGJUZFZtVWdmSmpqYVU4Vms4akxUYXBmV1owZHI4Y0xuQjUyTS8zNDFB?=
 =?utf-8?B?ZkFxakV2VktWeDlNa2YzSEZ3WUdGbytmc0pIQzYyblkyQVcxeVlqZ1hObGJR?=
 =?utf-8?B?NkhCMlZkd1Z3eTRGVEUrWmYxNTg2TlNBZ3lwTWhabyswaEEybEQxSlp4eUR6?=
 =?utf-8?B?bkRGclJMZStCNURqYTUwVXlEOUxvNnZMVHJHRFZZNy91WEZaMVNLVTM3ZlMr?=
 =?utf-8?B?UTMyOHM0K1dKRWZCWENmaEw5NzdlcVhqMmdraWtGd2tHMWlqcHZtbEJpcHRo?=
 =?utf-8?B?MUlMUi9UaFowTXcvTEU2dHBSN2JOTjdPS3JNdXRNNjdNT3ZvQVFNT2ttam11?=
 =?utf-8?B?dERJVkVuNUR3OWtjdmk5dlR4TTd5NlFKajJYWlJFSkZEelhENmJKMDJKd1F0?=
 =?utf-8?B?LzBIaEQ3YVkrMWtSOTBISU9BQ0RSeHh6cFBrTVhaTW4xSG11eFlwQXR6d0tw?=
 =?utf-8?B?WjNuekJVL3JUeWw4K3ppM3NEMlQwRzV5NU5wU2tqdWR3UU9YbU5wNm1UY1Ri?=
 =?utf-8?B?ZWJmRXh0dDM5aWhIYVBpM1hhbkVMQkYwRklqZ1R1V09MeFFMSDNvSDlMRUw3?=
 =?utf-8?B?R1JORjBLUm56VGU3Vzl0V3doSXZycE1relNpMGNpUU9pY3hlTEFYT3VQNm50?=
 =?utf-8?B?OVhSU0NmQjBpU2x4MzdaWko2bW1lZlR0T0lyUTFmaU1lTkdzUTRYOHp4ZUNx?=
 =?utf-8?B?N29ZZEVReWVQd1JzU1g5c0g1TE9VaGlqb2U1bzd4MS9hbnRJUy9iMXFmNnRl?=
 =?utf-8?B?dG5hQys4L0lNb0tVLzRHakowbHdiMXh6a3FaRWZvYk92OGtvRGNta3MvY2Uv?=
 =?utf-8?B?Y2lkMWtReGdoMkZ2Y3ZxUWl1Z0cwelc1VWdvNzVhelY0R0dzYXZMek1rbldY?=
 =?utf-8?B?cStVSDdpTDFCT1V2djVwdEY2dkRFVzltUkFKZElIZTJIamx6N29Jb0ptbFRL?=
 =?utf-8?B?em8vY0h5NTllak4vbXg0UGVXZzBwSHJTODlRa285RUdpZkJJcEo3SjM5b0s4?=
 =?utf-8?B?WnQwazM1WW9OdlJHbW9sQmxqcVhWazNGa0kySVp5TWlhdEVWSVZBS1dYYzFC?=
 =?utf-8?B?dUliQXkyV2UyOU4ycUttMGdqcVNVeTFUN1labkdKc3NQT1Zja0l6TDlsOUZp?=
 =?utf-8?B?cWU4Q2JDRnR5TUpLTkJtMGxoK1ZFQk5UME10cnRiQ20rQ0xHL0IwNWlvbGdp?=
 =?utf-8?B?WlRXV2RqVG9NeWdnTWNnUWZWSHF2TDJReWlWMXcvcnFwenl3WWkyNklrR3Jm?=
 =?utf-8?B?SE9yL3MvRmNudEtVaG9vT1JtYXpWd2JFSEVHaWVMVWpSUzdTU1I0OWZDNXY2?=
 =?utf-8?B?emhTclJXd3ByY21yM3lyOUowOFlZR1ZRQlZ3RENCZTVNd3ZoRERxZGQyMXZW?=
 =?utf-8?B?UW95aFMrcWF0Q3NSdkU2THUxcWFkOC93RUJqRk9yWndWRTU4K2tDOFJnMXgw?=
 =?utf-8?B?RDlBSEhTRi9BWDRlOWx4Sks2U01lYUpRMkhlL3pMVnlhV016aWQrS1dLajYx?=
 =?utf-8?B?K2ZlbnFFelVjM0FoWXhVLzR5eWgxME51THFFTkJxTnkzeUtleld5M2JTRlh5?=
 =?utf-8?B?c3pvSmkrdjN3Qm93SU5objlCYjRxMXJZdUlWUFRWSXlxSjI0ZGwwekJKeVUv?=
 =?utf-8?B?bUVnZUZraGNMTS96V3lOaWxWMDlJVEpYY0FrcERyb09ick0xTXBhRWVBb2NY?=
 =?utf-8?B?RmJvcmhubllPYk1WanF5cDQvczduRkY4UDhVRDQzVTdsazcvQzZqcWZLY0Y4?=
 =?utf-8?Q?1InN4jkgSwMNwsQsfgscktfOM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548b8604-69d6-4c1a-ddf9-08dd2b33c364
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 13:45:48.0684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idATY7/sI8wEEala9v6gv6ZzwJggG18a6sK5MOeHnqmIitxvaCsr61qtTwHEwSfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
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



Am 27.12.24 um 12:19 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Use memset32 instead of open coding it, just because it is
> that bit nicer.

In general looks mostly good, my only concern is that we already had to 
switch to memset_io() on some platforms for clearing buffers.

Now an IB should in theory always be in system memory, but it would be 
nice to handle that cleanly.

Regards,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a6e28fe3f8d6..a27e32f48f99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -136,8 +136,16 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>    */
>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>   {
> -	while (ib->length_dw & ring->funcs->align_mask)
> -		ib->ptr[ib->length_dw++] = ring->funcs->nop;
> +	u32 align_mask = ring->funcs->align_mask;
> +	u32 count = ib->length_dw & align_mask;
> +
> +	if (count) {
> +		count = align_mask + 1 - count;
> +
> +		memset32(&ib->ptr[ib->length_dw], ring->funcs->nop, count);
> +
> +		ib->length_dw += count;
> +	}
>   }
>   
>   /**


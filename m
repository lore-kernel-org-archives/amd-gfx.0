Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EB8C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 14:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42C010E627;
	Wed, 31 Jul 2024 14:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J1Xe5NPC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9659210E627
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 14:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQGeExT868xUJtGpjtXkXL0AeL/LX59N4c9ynaSlqbhEXHCFKVfo5XI23LBg+KwesogdVf1YkZD+PxGPubXJw2HiPNS65SFuAZSV9oLnYQcreSs5o5YIGOahnLftLy3Q/GJmgDPppx20wzU9YbBQ3kws1S9QmK6SiJCEogDToib8ToSQ7qnnQQBfdLTp8/0v1g70+9uEsQQWcYZyiN2VGHZRtoSAO9u8rR4f6T1pBtrrEUhZFv/dUcyc5RYzuYA29bSDbpeo3XEoeJqyLZH+BeyiNXQueX3oBe+P6hOQSW6BWD/u7dnpkWCvpODO9njNXq73YEylrvQMgkj3nOQb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS+qPVnxmYot7Jn7aImqQoMBfmZQVeo2xsB85NiU5k4=;
 b=IoZzTUUixdYQ4mQUNTc51xYOKvJpbblgTtTFt8OWqLkdXNu83JWDWSQ8C8TPq5ukIcZfLGCgo4m/UVeks6xRYHcAoUfAa5RrYuKLYIZ3ZIpjpGQc9q6Z2Mum9cYjhcKyYoWNlo5L+5T9I/AHeV0jB58V+nh0uPHClJ8n2Cx7aM/rVmf0Ik7wa4YQQXmj11CobPda1hGCP6xU6y8RRE8mfQ58OS24sd0JVEts6KfNBJ8XFLVH/5YRxjP0yY1fZGi3Rr81bbjPHcE2hKnSp46bny3BEpbG+lWgdHzNY6JlmlB11YULyrkRNaF4e/ngxJwRYLc1NKCgt0Rkc3TgEGmppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS+qPVnxmYot7Jn7aImqQoMBfmZQVeo2xsB85NiU5k4=;
 b=J1Xe5NPCDzEs+1/ohvjpPwjYPgCHHr4ovb3lFXC3d+8Fms+tFwV65qJf1Pa12Mlj8oGpaFscYUrC7fp75LksY8l5bGy0QToFRhhtp0ZwmFUYfAZoDSH+KgaPFVm7t2ViTJ7d0NfVSIXf5ujH819Lf5e+aQSW2hWhgptQVTwGLLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Wed, 31 Jul
 2024 14:04:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 14:04:43 +0000
Message-ID: <ad1f5436-ef67-456b-922f-10286c9b4ffd@amd.com>
Date: Wed, 31 Jul 2024 16:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up the count calculation for nop
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240731093536.28844-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240731093536.28844-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d022e7-d6c1-44ff-66cc-08dcb169b9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWtJL3EySUhmSlozVGZaSTB3K0hVeVQwUmpzS1BRV3Q1d09uUThDYTJBVXJm?=
 =?utf-8?B?MldNSUxnY2xLZVVkbTNVQW41eGRCV3FBWDVZUit2WHZNK0NJeXZQdVVoc1VN?=
 =?utf-8?B?MmU4YzhUT1pwcGZRc2J5dDMwd01LYjBJSnVNWGtQT1ZQcTE2UmlDdGw2c3Mr?=
 =?utf-8?B?ZUpFMmsxUFZEc0lhY1F0ODdwaU13ZVdGbW9zWnMzRmpyMGUvZGR4M3Iyc3d2?=
 =?utf-8?B?K3UwVUMvdE5melA4Z0hSQTdscmpLYTJxN1UveEhQOUdwWWx3MFU0YjE3Zkcy?=
 =?utf-8?B?dkNEdjlzcDZwbHBhRUZ5cTVzQUN0dk14eW50RGZyWHdZM0FwSThxS3FjOWdx?=
 =?utf-8?B?SW9OdFNjSm9KMlpzQzcrTVBPVGYvdU9MYkJBNnJxbzZiYlQrNk5KWVJZUXlk?=
 =?utf-8?B?emJZOXB1b1NwRUN6cW5rcjNSU0s2Zm1LMm5WalA0QmhRdDdtRlRBRFhHbElL?=
 =?utf-8?B?d2p1dUJTbDhJcUtGeWlGR3FOb0EzL1pqOEhNQUNEczZXckRJdFFjWFBSajMz?=
 =?utf-8?B?QnFaTExFUG5CZGIrQXcrOVArZ3B5RS9McjVqS1ROaXpTSWZ4Q3RCRFNkeHVH?=
 =?utf-8?B?ckZwKzdNNkR4V2dUTjJhWmZuWWtteDZoWDdKSWFFUGxialBmZHUwWEdpeWwv?=
 =?utf-8?B?NjQ3UHNCUitNSlBGK25nUXI0ZzFDQzl3YVBvSGNkb1p4UGNKVWdPd0g2dDNK?=
 =?utf-8?B?R2UxdzRiNGliOUlEOUFhQk95UFV0Szd2dVBtb1ZEbkU3dGxTUXl5S2k2ZFZT?=
 =?utf-8?B?eU13QlFUN05Ldy9JdTBIblJMSFNFL0p3QWVBTEdkRW1OWmEwRWdPeEJGazZj?=
 =?utf-8?B?SEZtQXgrOG9vbHdNMjhDRE0vV3ZKUm9BdlNrZnI1aVllYmw0N1E1a2JPQWNk?=
 =?utf-8?B?ckM5MWREbGJLWk9jS0JodGdiQ3YwOHJqK2xKVUJ1cTFoZGlPemZLV0JKMDdT?=
 =?utf-8?B?SXRoRndXbmdERWtrSTZmWUR3c2xxUHR3M05TeUszUUV3K2hqeFlFUGloSFBH?=
 =?utf-8?B?RHozdWN5QmhDNFNMV0lob1Y0ZldQTXBNOUdmYTQrUUdDZFlHd2kvNUxwUXEr?=
 =?utf-8?B?bUlFVmVIZ1FMcnB6Q1V3Ym5VcEhUTGwzR0FFenRaaU5FVVh4dWwyemhtYkNp?=
 =?utf-8?B?K1lmSThZUERETjhKa2hjVDFaV0xKaGIrVkdvdGdrc29IdGF2eDBiUDZOWndr?=
 =?utf-8?B?WHo0VnkxanBFMGZuTXh6dkhaaWNRWjhPUHVDalVXdkh5cXFGVjFrZEttdGpI?=
 =?utf-8?B?bzJKZkF4TVlGN1V4UHIvRTVFMGw2dVJUcjNoOUtGdE1GdFZkaVhqN1RDNTA4?=
 =?utf-8?B?c0gyWTZOM0ExMWE3YjFLMWhVeWdod0Fud1AzcENIZWtuT3pyQ1dQUzJoVjhZ?=
 =?utf-8?B?WEtvL3VleVFST3J2MGluaFNEZHBxYTdwSFlrTVB0RmxNYU5ybVB0VHRFM1Yr?=
 =?utf-8?B?KzEzamhaN2xWSEk0NTVCY2FjdmNPaXVpVGZnUUxrc1p2cENUa1pKVEs1NFFr?=
 =?utf-8?B?SmI3MVpUb25OQVRoUitNWGpIdFpaRnQyTXVyWVJOdW1kSkp2dnpDakh0bVZw?=
 =?utf-8?B?SlErdWdwZStpdmFlNGxDSzdUc0hDRitPSjRhOThxSUVidWlwSDQ3VzdDTFYr?=
 =?utf-8?B?c1BTWVZLb0NaQlNpa0s3cHY1aFdadzRQeDREcjNWOVY4TCsrZ0Jaa2s3eS8z?=
 =?utf-8?B?dzRaQUtCeENsTUc3OEszOWZ6MXlORTQ0RVB6K2xLV3czVS91eit0R1NDYlpC?=
 =?utf-8?B?TXM4U3dUV1VVbVRVajM3UXlSVjQ3MER1VE1xNHZZeFZsV1BVNGVkUFdvYVBy?=
 =?utf-8?B?bkllQnBDaXErYUgyMW9mdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1qdStvbWNkNXducEdwZTZvUWNHRSsrWkpyQ1Y5dU80bm4vREFrRGNvREkr?=
 =?utf-8?B?bU54eTJlUFRMTHRweWpTNStzRklwa0FNQTZ0aVI3K0VwNWNEVVY5OGJZck5p?=
 =?utf-8?B?eStqWHNRSFRZRmF2bVVOQ3lkVXVNK3hkZkhTLy8xd2xmN3dqaTFZWk1GOVk2?=
 =?utf-8?B?WElkd3RGeDROODJ4MVVuN2l2VTdhNFhBNlM4TVRRa2hoUmlJanhVMjkvWXFs?=
 =?utf-8?B?d0NmeDQ1QnN5Mno2WU1Ldlc5eXdPNkcxdnR4RTlJaFpqU3FqL1BTUlFXQUdW?=
 =?utf-8?B?VWlqUlN1Vlp4M0cyQXJXMGVXWFMyR0ZzUHI5N1RzOWZKSHdDZU1YQ2hQVjNY?=
 =?utf-8?B?VVJYSlhrV1I5OElFbGVEbWk0MStqSDlqSzJOTTh6YmdKUUNSUjhjaGx2UEg2?=
 =?utf-8?B?RS80ZmVSaUV5YWZqbHVIMkFlTDFhY1JkQkVsSmlRb2JFOUF1QXdaaHFqVGYv?=
 =?utf-8?B?RFdQMlArTTJaZUtVYThNeVpWODhkVFpYWGNkRmVHMVhXWGJoc1dPSHI0MkZQ?=
 =?utf-8?B?QTg4MTcyVDR3c1RyS2NPSGp6dnZ0RE94L2RhWlBZY0NhKy9HYVpDVjlTT1VF?=
 =?utf-8?B?YlRmbVJZMTNxVXdMbVYzUVAzMGxSMXlVUWkxRnFNY2xRRHY3MVgxL3dvQWpO?=
 =?utf-8?B?cEFpNWY3QnhTcmUrMk9SZmFlSjhud0ZERytYSy9oNTBaa1VuMW84aEZNUkFI?=
 =?utf-8?B?Rm9BK05mNGQ4WnJ5NkFxcU9nb1NYbnNDN0dPbHdzOTZrc05RMGc1TE94NGI3?=
 =?utf-8?B?UkJYY2JUZWhmZEdrdnQ5UzFvbGVhSGIrZFlHVWxNSUxwR1ZyOVJSUlovMysv?=
 =?utf-8?B?bUVRc2dvTGdnNS9qNys4aVBNbzVNZS9nL2VqMVJNTWZubTZoTGl1eVQzN2NW?=
 =?utf-8?B?akVwdXpObU9PSmpXUGVPNEt2U0F4c05IQ05PTmVFWHd5N3lkMjVmUWYwNnRS?=
 =?utf-8?B?SXVOLzdIekJteEpHWVN5akp1WDlqaGJBYjYvUDhIVGZUYVYwNWF6WGhsMTFk?=
 =?utf-8?B?d1hkOFkxRWlVY1YxQ3N5WndHandYRldEbmM3ZVFJdytwWG0zSTNpQVBLNDJS?=
 =?utf-8?B?TEpZUDV0d0hVYURQYWd6eHRRaUM3ZWwzTG1FVFBkZHQxTHBNVVNNM0s4QmFS?=
 =?utf-8?B?RjN6YmNWeWtkNlEzUEZ0ZXFmNUhGSTF3Tlprdnk3bVRLUVI2YldYTFlJV09E?=
 =?utf-8?B?SnBHQkRML3ZBWG42bGVLcDhnMUlqaFQyWmV1MkhDc1hqeUZ2RHFwSHVIQk9m?=
 =?utf-8?B?b215Ym9mNTlocWdhcDlnZ05vaG50eW5zeC9qU0NzUmlFdDlkbFZpaml5V2J3?=
 =?utf-8?B?aklZcmEyeFNkWmVaRUlSTDJZbVR5NTJYRnErVXI2eDF2dE5vVy9Rd0tmY3lp?=
 =?utf-8?B?TytKSmRTVjB4MnlaalZrTFh1THlaOGpnUDY4eWsvNkYvY3ZHWWVDOWVTYzdv?=
 =?utf-8?B?ZFRweUR0cjJIV1RMVkhiZEVMUlJPY3BhVDF1WFp2R3pmVmZQaGlsNGw2S0p4?=
 =?utf-8?B?UHcrMU95TGFsYmplZU8wTXV3clBEQThKT3FXNmhQWFdBa29RL3hLMjZZNnBH?=
 =?utf-8?B?Rmt1b0pPdlZzOXBNaWJrY3ZNZmliR2N5d2piajJQNS80TFRoaXNEOXNhVjdJ?=
 =?utf-8?B?dElTekRnaXR1Q2JJMTJNVy9lZlAyeDNxdGM1VHkzVmVYRktmbjV3MUlvQ1FE?=
 =?utf-8?B?eWlBSFFSS2s5QWV3YkRvQVd2MVduWTRYRFNidlBQQlMyUjRRRHhYeld2Nm11?=
 =?utf-8?B?ZHJoQXFWOFc5ejErbTYyZHZDYUpINHZlL2xaUnVCOVVZay9uNmxuRDlYQUZG?=
 =?utf-8?B?Y1Yxdks3Nk9PdVRqZ1hFSXpPNTVsN3ByUkxEOFBpOGMyeEo5Z1hmc2hSRjFP?=
 =?utf-8?B?bjVPNHQ4ck1hcGNGM21Mc1B5Zi9sMEE0M2pqdmcyT3dSNmNyV0dEQk11aE5y?=
 =?utf-8?B?YnlzZjhWT0N5YVRrWUlwY2RkTzVTZWVDdGIrSS9GWXQwQndweTcyN3ZmNncr?=
 =?utf-8?B?MFJUZkpIQnNZTFFKU3BsbERNQk5GQ2s3SVA1MkJtSXRyZW5TdFN6Z2R6VHZU?=
 =?utf-8?B?a2s5ZytBdW0rN0NnLzJNcGNGNXRMMEpTTVdsb2VmTjRlMk13dXlmOVFJeDI4?=
 =?utf-8?Q?/b9GTj7rtag9db4jlAGoKrh51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d022e7-d6c1-44ff-66cc-08dcb169b9fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:04:43.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyIFMmLpUn95tHGVnXkbRC9vS2HXyYaoLU8PcXEo3iyTTVAvtfGadgdqfOEZebpH
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

Am 31.07.24 um 11:35 schrieb Sunil Khatri:
> clean up the calculation for nops count before
> commit in the ring.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 0d72d2cbb64b..2c8218332c65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -142,9 +142,8 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   	uint32_t count;
>   
>   	/* We pad to match fetch size */
> -	count = ring->funcs->align_mask + 1 -
> -		(ring->wptr & ring->funcs->align_mask);
> -	count %= ring->funcs->align_mask + 1;
> +	count = ring->funcs->align_mask -
> +		((ring->wptr + ring->funcs->align_mask) & ring->funcs->align_mask);

I just realized that the old handling was potentially better since it 
only required a constant addition instead of two with the align_mask.

E.g. "ring->funcs->align_mask + 1 -" looks a bit odd but might be less 
instructions.

Maybe just review and commit the version from Tvrtko which just replaces 
the % with an & operation.

Regards,
Christian.

>   
>   	if (count != 0)
>   		ring->funcs->insert_nop(ring, count);


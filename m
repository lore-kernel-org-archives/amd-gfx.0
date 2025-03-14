Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8CDC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 11:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405F110E987;
	Fri, 14 Mar 2025 11:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ummN/6U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1242810E981
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 11:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5qxHzAb1nNfW0A0/I3cJr9ZVYL5CiBwOJbQJ5HwlOWZ4sps5VhQtLq+f7gHwhS77U5ZSbWmJJD5EWjdBblTpifaMuOClElfw0GAVTVM/dBKzkjVEK+q8jeeut0llYpVCWWSnRralMF3CgFa2qcYYDshBFDvXz+Wqn61TF10Pz+LBK24pXvOWln8PYZ/BwHVx5Lnz6tfr44nYGztDJEKpffwLH04lP0ZWXuM0PKkXI4LrpwOxsxXUDkXJotXFn6ApNqafkLwnASqfkktWX95DXFAlmfy+RCrnT0LlMojICiTPBFWVEr9rhnij1brtnvGCH1oU1iI5ozhQfULUL3hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9gSC9h7zpSZUsScY1bi29KRxB8CD6iMtb1gYJNZPw0=;
 b=rpqPENBjTPQVEzliYnWF1VjDLV2jDhgEmFuZM5Ymaj1wVrVzADgS4G8+07zHFttgLanoKsnh4IyrUO3qx2tDwoZyIH13vY13dZv3YQY9Jo7AFgkIj6pPU7BnSmyrfRy2I7q9dWplsEOXcp/CFEHi9ge2sIBr363t9JIslB3NWd1S3fOUwBmyYyIZneaUvuion1FgyBgDN2I4C8Kc4oaXTGo5HrBVSt/je/OBDoQ5QPkZGHr2hawftKBW3sHMsmE3ktB+VDXygJncSmoC2oKbubCCS9WMu8mKmULwXdSye0nyzOwmPhVR3yDvmYVamjv/a8gH7WVoUNvChZLqpLOSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9gSC9h7zpSZUsScY1bi29KRxB8CD6iMtb1gYJNZPw0=;
 b=2ummN/6UL8jJgwBOQ6bNDVViVz/Nkipn8n+5EUXyXSTdI+6aeWn35+AM6Vw7CJ+BEu3bxEh9c+4saOmeYNFEgqdhtQ1D3sRPU36ACK7SYpAMUqAXzdYaXq0yyC84UqTBUlgA14BUOmckVBCtzUYeHHhiJTCBaFSPIYP6Y3zbl7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 11:43:19 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 11:43:19 +0000
Message-ID: <04a4c7cc-1961-48cb-bad6-b073a04bbb68@amd.com>
Date: Fri, 14 Mar 2025 17:13:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250313144136.1117072-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: aa454b4e-8cfb-4620-4e85-08dd62ed6a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmJ1czFVaTZEZjQvVkkvcnh4bm9xQll6MnhGaGVCZ0pzTWZMMURqczRXRmdx?=
 =?utf-8?B?N0lXendPZjdjUUtndFEzZ3NSaFdPdHFwc3BDbVVpN1UxZGpuMmFMT2NvZ0hZ?=
 =?utf-8?B?dW1qV2JiL0ZpY1F5d0FMNlRaYXNHQkdqQzFNZkxLQWZCa1Y0UE1zU1NpaEto?=
 =?utf-8?B?SkNNU1c1ZitHV2llV3gwRXIzNjdJQnpEYVNwR3IwQTlxczNOYngzQzM2VGpX?=
 =?utf-8?B?V0s3ZGJPcmFVVzZ3SGhtMzdKKzN2UVU0QVp0WlNWeXVScTBRVDJBaDNlTUV6?=
 =?utf-8?B?RjJQVnl5b0UzT2RDR2pZV09rVklkbXRHWStieWFBOVVCRnArbWYvcmtIOHRO?=
 =?utf-8?B?QnBOd3U5UlJtZ0tGTEdSRTBhYWtJVDVFRzhYdlZNaFp3S3pvZW9xazFsVXY4?=
 =?utf-8?B?TVRPbk5BVHFqbzBocUhsVDZLblNxS3VWeGtrY0hxeDB4SXlDU3JkUjYzQkkr?=
 =?utf-8?B?ZGh6d0ZLZTRNT1BDWlArVktCWGpwMFZlMmFaMWlSM3dwUWxhVklZMERPelJB?=
 =?utf-8?B?U01rMjM5MXRWS1dOQ1YyZzBkb0dVMXVXTG9CanEzMTlFbVZQTElnM1Z3cVp0?=
 =?utf-8?B?SFBIM3ZOREx6WFBDdFFzRG5DK1VLak5vY3haUmNVMTcvTXI4YXo2eTFualFw?=
 =?utf-8?B?TU94aElMSGVSdDd6Ty9NK3hkR1RuZjBwUXlZS0VTQ0hCR3dZK0p2QXFoVVZC?=
 =?utf-8?B?MXp4UHl1WW0rcEErL1RnR0JqeGtuTU9pK1psWTd6a1FhejFjbnBiWXhUdlpF?=
 =?utf-8?B?eTZtWWFsbnBSRFJGRm9KcGFlc3Vpdkp3U1l6Y0dEYnZBc0t1ZzhmTkFTaVZ4?=
 =?utf-8?B?VzkwVmFsUzBOZHlEV1pDWjk0elpWQnZ3Z0VJSjhxeUFtK2x3MUZzdEVnVytO?=
 =?utf-8?B?cHZ4TjZRZ284V2ZDS3J0Zkx3VWc2azQ4NVpjVFdhak1uaUFaVFFIUmh4K3hx?=
 =?utf-8?B?b05nbUFGV1dTR0doeVYvRXhFZzdRcjA0UWdlUkNEYnZXYkdmMzh4Q3BzWUZx?=
 =?utf-8?B?TXVaNnBEQjNPcnFYYUVXdTIvTlRPT1c5L1Blak1BNm16ZmF6NGxWck1KVDdt?=
 =?utf-8?B?MGxUOGRPcCtrRGZKVWJ6MVhFSkdSMXlOZ015OVZPMzJCdzk3c2pDSkMrWE1P?=
 =?utf-8?B?VFNhNXJvK29nTWp0MjA4Zjl6VENoNkpHQXFlQXFLTXdjbjBKYXJXaU5IUzdU?=
 =?utf-8?B?RnMrSk9oV2MyQlhhbzZUeFFuZXFoYVozc0duNTNnTkw3YzdDRmtOeG9HV0d3?=
 =?utf-8?B?clMrR0FvRktOdDFEc3VxcHhXWFBRNnhxWFp2dm1lNzRyL01VOWl3MWhRSUVx?=
 =?utf-8?B?Y0MrSy9aQjFwRkxXZ1p6bjRlRnJaaGVjR0lOSWhvaTlaZWRVZ1FhVVVkOXlx?=
 =?utf-8?B?N1I4dHNCem13aXNvM3YzQXFxZ0lyeUpOS0hkZWVBOEw1UDJyaEkzVmsxMXVR?=
 =?utf-8?B?K2Fwc3JmTDdPRFZHTXhlTmdqTWpTc3FYT3QrTzFVdlc5SHJzQkFWVkZGSlpO?=
 =?utf-8?B?TGIzNWxidEZjMGVmSHdQZnpoU0pqdlpERHdtOUVSOUtqUXFnWmhnNU5vbHQr?=
 =?utf-8?B?eFdBODh6b0M3YVNkZGZ0V1pHaSt3cVZrYzd2alEvWlNIeU5mOVRubmdVY1NX?=
 =?utf-8?B?Y3JtaDhVS0pXS0JRY25Qam9mUFNUWFZaVlh3cHgzaHZqWkVnMWVxZDRLTXgz?=
 =?utf-8?B?djVoYUN2eVphSDFWcDhxNnBGbXVwSCtPUHdNUmZsRElWRnNmeHVvQURxeUor?=
 =?utf-8?B?bDZrZkNZYUdPQmMra1JHZ2Fsa2U5b3lCMjF2cHdFNHJYUXA4dUdKSkdzN0ky?=
 =?utf-8?B?RW54T2Z6cnQ3MzlMZkNnM3M4RWYrY3M2UzR3eUZQUjV3dy9Ia2pja3AwWDRi?=
 =?utf-8?Q?YOSMwdi3K7AcF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnd1OVY2SDk4M0Y4c3JSOGVMMnU5OGhmMm1DUzU1UmV2THJ6K3c3MEVCN1Fs?=
 =?utf-8?B?dmFBVURuK0QwbEtwcitlZjJ0T244OWtRM2lUenBxd2lxK3FmM1JDbjRVSzRa?=
 =?utf-8?B?aUh0NktYRHpiY2Z3ZGoyNGN1U2pxSlZ1K0N0SiszUHVFRi9BTDNrQVl6ZjZl?=
 =?utf-8?B?bzJETEdseUp5cUtUTDVuL1Q3RWY5YTFPSzhsbjFYZ1BMSlR3S2QrdEttdmxP?=
 =?utf-8?B?amhXbi9lSnRrUmxsdVFoZjhaWTBncksrWFJXOGNobVdJa3Q3THFHU25idkNz?=
 =?utf-8?B?UXVRM1llb3hjTkI0QzFNYmV4K0s2RVRYV3JJZzhnTUozdWRqc0xDQXlOcFoz?=
 =?utf-8?B?dFF3UnFzTnQ0OVZBN3Y0QkQvL0NUWmQxUFhjcXg1OVFmVk15QWpCejhydmZm?=
 =?utf-8?B?Tjh3OFNxdzBVWWJHeWliUjVhdzJCRk41WHZRUUFOQ3VEK2FSdWN4RWFRZTZT?=
 =?utf-8?B?MDEzK1htK0JVK2ZhK0J5ZFFFcUFuWlFLWDFFZkNiaURrUUNnczNDaDlmYXJR?=
 =?utf-8?B?bi9QOHNlc1dWN2xhU0piWWZqTVQyUjBkaVVaUjQveEx5Uy9Na1lRN2ZSYlZa?=
 =?utf-8?B?djkzbDZKdU92OFYxR3E1Q1FBUEQ5ek9pVEZCQWErYVhFYmNWNXFENEpJTjRm?=
 =?utf-8?B?RDFIN3laTkRCQTRZY3hyZHJ1Qnk2ME01REhhbVhzOTFYWGc5VHdhbmZyT0hE?=
 =?utf-8?B?eWd3UFVheTdLaTZyQ3RzTTlxNzNBY0dySnMvOXFuUGJaUWVTcXhxbkhLQTRo?=
 =?utf-8?B?dnRqeU1FR09tS0V4TWtCUVRrSE9XU1RMVk9zQ2xvSFlsNUNYNnpXOEtJU3Fz?=
 =?utf-8?B?YmNJVE5lQWJaZFFMTjJBYWxmbEFabkNUU09jdVN1NWFiREhyVUJTNncvNito?=
 =?utf-8?B?T0dsbCtPZTBIbm9yd25xYTRLK253Y1ZIb0pGVC9FV3VPeFVUeXU3c3NpM3Jj?=
 =?utf-8?B?K3phTUJrM2ZIclhFdWhDMXVZRW90a2FBNnhjNzFVV2ZBU3dweTZaNTRGU2d5?=
 =?utf-8?B?dzVPbU5NRlRrS3lxMXM0ZWhqNkpWUlhRU2NVbEQrNmlvUE84amFjaG1SZmpx?=
 =?utf-8?B?R0RBUU1CM2VpWWNVd3ZKRmFVUzMvK2svb0JrQTBNbWtJUFE5RDlGc0Jka3g1?=
 =?utf-8?B?Y3RTZ0VkZjB1UGUyR2hURVQ1RmNYMzU5RllDNTNHNGxjMVpnQ3ZNWmNaZGtv?=
 =?utf-8?B?ZzRoK1hHM3pkaVZDZEZGbStjM3A5UEVSRDdhK01NdnQ1U0krU2d1QTZmLzNQ?=
 =?utf-8?B?WFlkRmp4RnF1QVBWcmo1YnZqWWxORFBIM0pFRGk2Ky9QcW9LZTJ3Z0hhaC8x?=
 =?utf-8?B?WnhnS0svT1cvZ3RSL201MjFuc2o2a0FGc0VaMW9WS2RGWnFlMFE1eE43ZFFv?=
 =?utf-8?B?VWxYUERUN29WWVBJUW9QencvUEQrRVoxWnc5TWtnQkZKQmpWMUZlRzNFVDJX?=
 =?utf-8?B?bUJBemVYK2hFaTJENGpRTW5UdG5LaWNvdmhKMnZacmxjT3Ewd2Q0eDBnZkEw?=
 =?utf-8?B?WVNWVy9xbmIwai9hT1Y2N2dtbEFQUUxiVmdvc0Z2L204aGwxZVpUMTllZ0FV?=
 =?utf-8?B?ZWpCWmhqbm1GRVduT0lwMWpvZVdqMTEvTzBCWVNZdFhZbDdoRlpoRVluK0lB?=
 =?utf-8?B?bVV3UUJMM2V4MzJTSy9EVURtalgxcGlKdG9OTXNnYnJLaTFGUGNCMkloYkFL?=
 =?utf-8?B?Z2pycWJKVndoL1R4THBoS211cTVVZ0hWV1lZTEI4V0dPKy9KS1k3NGdKQUo4?=
 =?utf-8?B?Nkgza1dFQlpFd0dUbXZlNlZCVTNNQzU3VVQ5RHdIT0d4c2VoWU9WMHZ1cDVi?=
 =?utf-8?B?azR0dS9LczVaYlZMRWtwb1NuNmxCSWRjbGVSQko5NDJlWndYSEJKZ1UrNTJa?=
 =?utf-8?B?M2h2VnVWNG5SaGlYa3JrbUtxUUR4YlluR241ZnFEZU8zdmE0R3NPTDVBYTY1?=
 =?utf-8?B?bW5qM0l0UGQvQS9uZkdmOXRNTytBM0w4OG5FQUV3MW9tcnNVeGtUYkE4MDRJ?=
 =?utf-8?B?ZHg3bUJnbHY3YzFjcTZpRlFPY3RHTXI4c0RDcWVsTEFnWGxZajBjNUhUNzB5?=
 =?utf-8?B?VG5PSVJQR21wT0JQNldnQ0pKbFZjSlBiNWVLL1BRRDdKamtxQjVaWm11UDZU?=
 =?utf-8?Q?euJ1ALankVSutgdDNPWEHyDgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa454b4e-8cfb-4620-4e85-08dd62ed6a78
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:43:19.2052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bqD448MSpucztiJF3Ui+bGGjW3wSKKzL5ZuVOXwacgh8Vk1NXije/p+cGbumhyhKI5yZYauxb8YAc5CG0vjWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/13/2025 8:11 PM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues.
>
> v2: use ring counts per Felix' suggestion
> v3: fix stream fault handler, enable EOP interrupts
> v4: fix MEC interrupt offset (Sunil)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 183 +++++++++++++++++--------
>   1 file changed, 125 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 34cf187e72d9f..a99507e4fdb27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1421,11 +1421,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		break;
>   	}
>   
> -	/* recalculate compute rings to use based on hardware configuration */
> -	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> -			     adev->gfx.mec.num_queue_per_pipe) / 2;
> -	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> -					  num_compute_rings);
> +	if (adev->gfx.num_compute_rings) {
> +		/* recalculate compute rings to use based on hardware configuration */
> +		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> +				     adev->gfx.mec.num_queue_per_pipe) / 2;
> +		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> +						  num_compute_rings);
> +	}
>   
>   	/* EOP Event */
>   	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> @@ -1471,37 +1473,41 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   	}
>   
> -	/* set up the gfx ring */
> -	for (i = 0; i < adev->gfx.me.num_me; i++) {
> -		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> -				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> -					continue;
> -
> -				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
> -							    i, k, j);
> -				if (r)
> -					return r;
> -				ring_id++;
> +	if (adev->gfx.num_gfx_rings) {
> +		/* set up the gfx ring */
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> +					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> +						continue;
> +
> +					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
> +								    i, k, j);
> +					if (r)
> +						return r;
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
>   
> -	ring_id = 0;
> -	/* set up the compute queues - allocate horizontally across pipes */
> -	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> -		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
> -								0, i, k, j))
> -					continue;
> +	if (adev->gfx.num_compute_rings) {
> +		ring_id = 0;
> +		/* set up the compute queues - allocate horizontally across pipes */
> +		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> +			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> +					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
> +									     0, i, k, j))
> +						continue;
>   
> -				r = gfx_v12_0_compute_ring_init(adev, ring_id,
> -								i, k, j);
> -				if (r)
> -					return r;
> +					r = gfx_v12_0_compute_ring_init(adev, ring_id,
> +									i, k, j);
> +					if (r)
> +						return r;
>   
> -				ring_id++;
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
> @@ -3495,12 +3501,18 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_async_gfx_ring) {
> -		r = gfx_v12_0_cp_gfx_resume(adev);
> -		if (r)
> -			return r;
> +	if (adev->gfx.num_gfx_rings) {
> +		if (!amdgpu_async_gfx_ring) {
> +			r = gfx_v12_0_cp_gfx_resume(adev);
> +			if (r)
> +				return r;
> +		} else {
> +			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
> +			if (r)
> +				return r;
> +		}
>   	} else {
> -		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
> +		r = gfx_v12_0_cp_gfx_start(adev);
>   		if (r)
>   			return r;
>   	}
> @@ -3711,6 +3723,46 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	return r;
>   }
>   
> +static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
> +					      bool enable)
> +{
> +	if (adev->gfx.disable_kq) {
> +		unsigned int irq_type;
> +		int m, p, r;
> +
> +		for (m = 0; m < adev->gfx.me.num_me; m++) {
> +			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
> +				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +
> +		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
> +			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +					+ (m * adev->gfx.mec.num_pipe_per_mec)
> +					+ p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -3721,6 +3773,7 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +	gfx_v12_0_set_userq_eop_interrupts(adev, false);
>   
>   	if (!adev->no_hw_access) {
>   		if (amdgpu_async_gfx_ring) {
> @@ -3809,11 +3862,19 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->gfx.disable_kq = true;
> +
>   	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
>   
> -	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> -					  AMDGPU_MAX_COMPUTE_RINGS);
> +	if (adev->gfx.disable_kq) {
> +		adev->gfx.num_gfx_rings = 0;
> +		adev->gfx.num_compute_rings = 0;
> +	} else {
> +		adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
> +		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +						  AMDGPU_MAX_COMPUTE_RINGS);
> +	}
>   
>   	gfx_v12_0_set_kiq_pm4_funcs(adev);
>   	gfx_v12_0_set_ring_funcs(adev);
> @@ -3844,6 +3905,10 @@ static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = gfx_v12_0_set_userq_eop_interrupts(adev, true);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -5043,27 +5108,29 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>   	pipe_id = (entry->ring_id & 0x03) >> 0;
>   	queue_id = (entry->ring_id & 0x70) >> 4;
>   
> -	switch (me_id) {
> -	case 0:
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -			ring = &adev->gfx.gfx_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> -		}
> -		break;
> -	case 1:
> -	case 2:
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			ring = &adev->gfx.compute_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> +	if (!adev->gfx.disable_kq) {
> +		switch (me_id) {
> +		case 0:
> +			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +				ring = &adev->gfx.gfx_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		case 1:
> +		case 2:
> +			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +				ring = &adev->gfx.compute_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		default:
> +			BUG();
> +			break;
>   		}
> -		break;
> -	default:
> -		BUG();
> -		break;
>   	}
>   }
>   

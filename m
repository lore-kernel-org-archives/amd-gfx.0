Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88709C0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A05910E43E;
	Tue, 11 Feb 2025 08:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="todvT8Lz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B88510E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWTNUleckwW0y5abTOrgZh8e+32HCSiHYRKqfYdJfQdUgqqKzS53/6Ix31Mrf8SE96uVCAgTRrG1jjfKuHZI+AI+HzEREpVEy5tnDLdVRL+LBgw6sCCRR3rgwHgKXdL6lVtT1Y9cukrBIATFSx36/U/brnnhO7lfRfcL7I9540AP7YAU4mwCT2heHaGafn3v4unDjctU1LWBpeKszpk11Pp3hY8SBb2mUnKZybm2efh1wYLX+GpBzdQCw5ey/BHrHui32ky5IPv+s9o/1oYejhyO0VTTJ+aom9UuwjqNGvmx4hUPZX8oYLK968dZX+k6G1NnFO6SJkWQKfKCzV2j+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj/jAjw6a68Bed0uLZfpHTpJBjWdE7vvINNV3VzUrr4=;
 b=Aao27NqiDfwhzrIKbSo73VQJ1S39+J5dadVgA3x7ZlIqM5L0IoXeMcMnbf97yWxWdo4xu4tzU9XRyV/PUjuxNPXU+gUqayJTHk4p9vIaY3HLPWOD8JoqNcjQ2ho18xIM0OlevkjMZOy2WaQ0IzOqW15Efqf9tV974moalF/o66xymDpV0kioz8deYGdbfkRYJhim3zRgrMlCZhOD08q3OTu+rfPEsQvWl1qHssSznTh78D2Yuo61qItvrQVfTpNjcNtCOJdwH4gUdP26cK2G8dnz3zHSAai6vx4XNQ4JHWy8g12PyzqkycfGubf1rIh3k8Bm95bb1mVflFT4vM8hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj/jAjw6a68Bed0uLZfpHTpJBjWdE7vvINNV3VzUrr4=;
 b=todvT8LzUvKK3AzxQ1BIyWOhFR9uMOvhobgBcHZs3BLZSydf4Hw/v0BMrUHV8BSy3XV6e+5PKpqPXxRbc6gPbZlCMz1UxSNPKJ4Uzn3foeosv/d4RBkUk+PMt1dpLryrxWMuz7Mzbmravhi0R8IAisJvJe8Zi4AGQ6VgFT88irQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:22:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:22:11 +0000
Message-ID: <123fdad2-acf3-4ffa-9108-5a3159f90fae@amd.com>
Date: Tue, 11 Feb 2025 13:52:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: add sdma page queue irq processing for
 sdma442
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, jesse.zhang@amd.com
References: <20250211063943.2273807-1-le.ma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250211063943.2273807-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac20a82-4804-40e8-308d-08dd4a752e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTl0WnJWM1NVdHNQcloySHFwMDRuTy9ZSjhnbm91UVNyY1NQUlNDbkJoRkQ5?=
 =?utf-8?B?ciswalMzUEVVL3lYa2FaYVRqbTBGMUhwRW5MY2xOaTF3TEZOc3RmOGtZSlBm?=
 =?utf-8?B?WXFTMmk1TmR6d2V1SlF6cEQ1TzhSVWE5RXg5Y1VFM3poRkcydjNEVjV2ZklF?=
 =?utf-8?B?ZU43MktjU3lWQVpINGhlRFcxRU1kb1p3U2F3K2pxMmlFWGI4dkhPaWhMeWl6?=
 =?utf-8?B?dldPZmFhbk05YklZUUtwbjFDVkhGOXZQMmFrWlY5ZEJMMmVFalBOOHdyMGto?=
 =?utf-8?B?ZlNhdVRvQURBMVVTemZGSmNKTGJpZ01UZUR5UUdrMittL25YcTEwVFFKSkll?=
 =?utf-8?B?U2tqZFRDZFQzZWp2ZlBzdnhod1p5aDZjdTJ1Q1N1RzgzUVlJbjNRMlRJdjdP?=
 =?utf-8?B?ajJwMDNVZG9SZWU1VWJRRjVBTHFoV2ZkMjFrMmJBdGIzNzlYRXZ3YmloUnVs?=
 =?utf-8?B?Ujl3eTVKb1p6YUo4L2g3UjczRzBxUFNnSm5RbnVyUW5ObW54YUFxZGNlL2Vh?=
 =?utf-8?B?YTcvRTd3bzdqaWd5Zjk0Z1NzTERpaUJoOHQ3SmdNS3Q0WU5leWJOZ05PQll1?=
 =?utf-8?B?ZHpMYk0ySmo3ZWhtdENnb1FxU3NQUzRWaGVHd0gzVDFyVG80OTlDalB2SHNH?=
 =?utf-8?B?WUhydXhFaFVrREFXeVltRm5Kcm5OVFZKeGlZWUxjQmRITG95bHRGUmZEZmtJ?=
 =?utf-8?B?LzNBVDB4cEVxaWFoa2h5emRmWTNyVU9MdUJzYml0THUxdWRFdTN6L3J6OUYz?=
 =?utf-8?B?WTlqNzFNanVia2FvTjVCWUM0ekhDTGFZdmVycUI1TDdOeEttRHVWNkwyZ3Ny?=
 =?utf-8?B?MW01Tm9oMERYa0hOcTRkcjdJbVA0bHdnUXNmZGhNa2VveDlyUTl2TThkTHdl?=
 =?utf-8?B?MkdhZzBDdUpzQk5DMzVrVXJxUUZUUlFtZkwxNGkwcXF6MnNqcUl1Nk91VUl3?=
 =?utf-8?B?TDVObGZyMEV1eWZrdjJQYzBvNGlsMEdHdEVsTWVScFlya0tSdlFjblVzSm1K?=
 =?utf-8?B?Zmg4eXVsRGJXb1JHMGx4MVE4MllHUUJmMnhuRVpHMHdTWm81WEtLZVI1cnhV?=
 =?utf-8?B?ODFsVTI3d3M3MlhadzZMRmRGRkdWNmFFS2RUQmNzeGVLbTU1dE5jU3NveW5t?=
 =?utf-8?B?ZTFkUk9uZytycWtuMzFrODRoR00weHh1blFkS3h5dEZlL1RVZmdySVlXM01m?=
 =?utf-8?B?UmF5OW5hYzRnM210cDljTVJLRVpQbUdwc2VhUlVrUlBoQ29OWlVSL3g3QThi?=
 =?utf-8?B?MGlZM3FuTWc0U0d4dFdnSHBrTW9JZzczT0NFK1NrSDJ2NmhkMnVUUUp2RGVZ?=
 =?utf-8?B?NFZISnVQaWp4SlFPSEpPU0VQc0pYendzVkhvdUFKTGdhU3BGamR3SzR6OHh4?=
 =?utf-8?B?TG0vRWtNeHZLcHFUOWo1VXNQSFFwVHdoMzRyYXVmN2pIVlhicGZCUEZHYity?=
 =?utf-8?B?MW9CcWVTR24zazdtcnR6eWxOTFVYbis4MXp4TTJVeFVpQjdzaVhrYUhKMTJP?=
 =?utf-8?B?TWhxVkZUNnZuazhzZ2MySjc2WG1aQmtZaXl3ejlJdnhUaGNabEczSmNQV0lv?=
 =?utf-8?B?ekthV1pKcHFZbDNING5HTFQ2REJWWm5mUUhhQk1nQ2RVY2lVZUZUVUdtRVdC?=
 =?utf-8?B?b2NVSytuTnhUdk9rNmZUMitpWlZLSVhaWXd1Rk1KMEdVbkU4SFpLZmY0QXF0?=
 =?utf-8?B?bzZFMGZBdUxnU2p0QXlMdVFXemVyQytnSURmb09GbERUeU5sSEdvTDFVSGtj?=
 =?utf-8?B?UjhyOGhyd2FXYmN1MGRBZkpSekVhR3kvYXN5RTNoL0psdVNlU1E0NVd1MEpG?=
 =?utf-8?B?NkFSd2trWDhtRmNSbTF5NjVDMGE4M01wcVNEQ2hLY2tVbEROQ0x5ZzVuemk5?=
 =?utf-8?Q?6hKJeb5QMVItL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzI2T2h6eVpxYTI0MWhKVjNLbUd4bXBjRzFjcDBIRkJzQTdtY3hOWmR1VzBB?=
 =?utf-8?B?dEJDMmVrT0FwRmRscCtBVWg4NlE2d0FYTXlUdmNqNzdlRUZkNnptWVNnWXJw?=
 =?utf-8?B?SkFSMjFoSEh2YUNOS3hrMFJ6bkxqVUdWTVl0eGNFYUlKUm5DQmVJYnBwY0xW?=
 =?utf-8?B?R285THBXam4zS0ZGRi9aSk5KT3NQR1Zzdnh4WEFjcVM2OFgvOWY2aEU3TjF6?=
 =?utf-8?B?ZCtwMzVURUcwc1c2ZzByUzdkSXJmUkY3YmFETkM0TTJLcExFQWN2TXNZREVy?=
 =?utf-8?B?ZjJoSlhyVERlT3J0WWFxRk5obE1TNTJVQWdvU29ySVFRdkxwbGhYcDRJYkIz?=
 =?utf-8?B?OVY0K1F6NlBaYlluUlFyVDl3VEJ5MXBKSDNoQ09xRUJYbjZudEZNNGN5NXdx?=
 =?utf-8?B?K3hhcVplV1AxbHhGR1NRUW5EazlSZXl5bXRtM0NQNWw3UW83Q3VBTzRmODJh?=
 =?utf-8?B?YXpjdTJsbzlUMlVZU1ZWbmZUNFI5SVZadFlNZWxxSEs1bjNyUTFndXdaRkFV?=
 =?utf-8?B?SjE1QVF5OGxYZDUyNllxUlRoT2V0b01sajVvQnFJVjQrUC9jNHFyeTIwYmo0?=
 =?utf-8?B?V3UyTTcvVTQ2TU9iZlZYYTN0T2N4N3Y2aTY3dW9md1hOYkw0QXd0UEFZVkY2?=
 =?utf-8?B?K1pqbEZ6R3JKUXc3aElpaUdGNk5GNHFIM3Vhd2QxZFkwZmlOUld5VVI1SmJj?=
 =?utf-8?B?V0JNU25qSUExcm9CdmRuSS9OdTdIYjFiMWIwUitoZlJ0WUdIVWViVTNlWDZ5?=
 =?utf-8?B?dTRvQmpUTUFxb3NubWJUOXdIVERna0E2TVlXdHRka2ZWR1pUZzBQanNib3A3?=
 =?utf-8?B?dTMvMnF2eGtPTWlpNFp3czdYampRYXM2L1dEYm9hS2UyYW0wUk1TdmxyK29K?=
 =?utf-8?B?aFlSbGYzSTg3SUhWdFNTeVVwQ0c3MFJaRTVIRVc2YitQejFTSDVkbm93TUVt?=
 =?utf-8?B?T0JNcGhnRFp2VklmNjlLWUhHUVkwb01pcWNlU0xYeDE1UHhNOWQzZHY1L3lE?=
 =?utf-8?B?Y0VHZEFBYnZ1QTVsNGRNRUVHc0RzZysxSWZFV0tBanBPVTJnRVJ5SytKR1RO?=
 =?utf-8?B?OEswZis2RXhmRVNFblQyMmFwdnR5NGZFUitiRkdYOThFT1lNU1lleWNCeGkz?=
 =?utf-8?B?ZlNnbE1KbmpyUVVYUnlXckdDQVhLV1NIRlh5bUxKenh4cUhUNVhiTGpQYTJQ?=
 =?utf-8?B?N2hLU3dIWnF6S1dDZGI3a3h3ZGN2TnhoZ3V0b0liSFhwL256SVFYMG9sSS9X?=
 =?utf-8?B?T29XaVUramNNSUJYaVIya09sbkVHaXV5MnZsV3RIaWs3eTREMUhSSlZyMVhq?=
 =?utf-8?B?Q25qMktwYkRNMFlSUkhWOWVUTVgyVklwYnVBVVMzOGNxaHlwNEoyK0hqTENV?=
 =?utf-8?B?T25Gdm9Za0psVlFtdC9Sd1prSk9RR0RQOEpqOU5wVWNNbUNaQXdQb05ZMWtw?=
 =?utf-8?B?V1U2MjRyVVZRSVphZXpoOG8wWEF0bE5ySER4OWtrQTdiZFN6UlF3WUZYQmZs?=
 =?utf-8?B?SmRRTUhXVzgvN1dWa1kzbGR2RWgydmRZbmFJdExjVWQ1bVFPNHRtbVhuYWNw?=
 =?utf-8?B?RElvTTk4Umh1QkNSME9ZT2x4QUxucGdPa0lIRjl3cGxxYU9oVTExaEg4U2lr?=
 =?utf-8?B?SGxsaDlSZGF1My9CQUhMYmw4Y1dtTEdyVHZLUk9qVVY4Z2FhZE5WUTNtY3lr?=
 =?utf-8?B?V2RuVllrUGVyc1RzWmpPenBIVnRUWXNCb1VndmN1M1NPdjRKNkI4ZVlQNXVu?=
 =?utf-8?B?ZjNpM0FFdFZYNmhLNzZSQ0V0YW5Gdk1SVUNDZDAzRTBHQUhhWU5HRXp6N0tv?=
 =?utf-8?B?SExFb2ZDV3o0dzBvSjc2VWxBMy9yeDAwYXgrTGorTlB1YSs4dGQwekc3Wmto?=
 =?utf-8?B?QUdpN1F4SU9Qc0NXVXRrdVVVUkVaemxieDNzdWl0dExtbkZPZnR0VFFnaVhB?=
 =?utf-8?B?WndLcm8zK3c3UUUzTmJlSVd6M1Exa1VkQ0lJelIzU0VpVVFIcEZvSWJ5dUVj?=
 =?utf-8?B?SGpmdS84eENtWHJ1UlhFNjRvWUIrclJieXFzK1g4MnhrdHZaSGNiQ2tFblU1?=
 =?utf-8?B?Vm94WFdwSUtCdHVGdkZmalhKQndCS1J1QVhxOXF0bjZLejNDMUx5cVhjY3Ns?=
 =?utf-8?Q?u1LtfAnbME1sH8QlAhQDjCTWX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac20a82-4804-40e8-308d-08dd4a752e88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:22:11.2439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHnYyfPS8PuWUTkxoYETGD7i39xbY+pbgBOfuexyFTJ26xCfrNxEDiA38F7648bx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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



On 2/11/2025 12:09 PM, Le Ma wrote:
> Add the trap irq processing for page queue of sdma442
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Maybe good to add a WARN_ON(!adev->sdma.has_page_queue)

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 5e0066cd6c51..14acc3b822ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1683,6 +1683,9 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
>  	case 0:
>  		amdgpu_fence_process(&adev->sdma.instance[i].ring);
>  		break;
> +	case 1:
> +		amdgpu_fence_process(&adev->sdma.instance[i].page);
> +		break;
>  	default:
>  		break;
>  	}


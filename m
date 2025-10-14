Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C53BCCD190
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 18:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4042210E66C;
	Tue, 14 Oct 2025 18:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KijI9R37";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70BA10E66C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 18:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjvshC5Yjy34UMhcCO0KlZ3Ccl0KpzQz2lvFKifOsGLWaGzpNNe/1dnk/971heqbAT7j8KmzsY+yeL8K4F4HI1jpj+XrbjR1p7gg3eliGAnzdvDPBFldgeCKi5CIwgtVcjOsO34ohioRAomLsYVus9TdNSPc/DFlGHa/3dw3noZwCtaQqaIwCHl/RelZ7MbFI725K7ZjNy5HrTVKSF8CuydsZqDBmcEc8QNgPsqB//2lyhO+oFFBxg9hiEEUMktFUBGboUAoRL7DW2XrpWWMTd06Phow/E7gZlckIU9VgEWwDutRzRqEi/HeuMv8zGg89AYVdc/ZITYAOZHhgvMToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz/qMiZ5+AcToYOpwhODPDHhGrt887/BKl8FLcl2TGs=;
 b=KIOSDWpvGUbfKz3UIQWiBi1QkdQv04ZFEeGmn2kjnIp27tAkPmFijGeNLnDWlYnVZeKGGZ6FixYEDF6cBoOtfIpCQjn7UVtkg6xGLeUZIFhxE5S2ejnKbEVun45JzvHhxfodF4oNxx4n+nU3uYhvQiJdyv53/LRNBIVcwk243jxgxeZ8qUtl2kPScyy1y9Ox5cujJYiV6R9wO+h8n2AS3LDCuiw5k/4it7yVGn2rLGYAS3XVjifMFRKy2QpEGsolrWKB/ALI6hvZn+g6zX6W/FWwFFu6ATjCHxpX7ptc2TdfoCA2GcpwSM0uh7Q8iyxy2P09hMTVvO4apY8gcdQ/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz/qMiZ5+AcToYOpwhODPDHhGrt887/BKl8FLcl2TGs=;
 b=KijI9R37O6uMpzXD/PRoaYE+wRVn8sF+NMWD396mRsa6KKT1Jk/Tcg+24smi1GJgixLem3LNMPvMItmg1EBq1tZTRmmbKiKbaCQhKE36rC4nmDc857pzazqtOxSCoRxU2+b1s+DxHdw7RlCJrl0OeaaI8dbyUIU76amX1LVukcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 18:20:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 18:20:19 +0000
Message-ID: <3904b1ba-7be1-429d-af90-47e2bdf14762@amd.com>
Date: Tue, 14 Oct 2025 14:20:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251009205508.175269-1-mario.limonciello@amd.com>
 <20251009205508.175269-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20251009205508.175269-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0576.namprd03.prod.outlook.com
 (2603:10b6:408:10d::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 326fa524-0a09-4134-dac4-08de0b4e54bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVFTcSt2VExoY0hlS291ejJXdWg0YWUvZW9SS29ZcUxKUlZjTXdFcVFib084?=
 =?utf-8?B?TGFBbjRvZklBS3lSZzVUUXM3WWQyeStSWGg3aEhVZzhSRDNCWnhLME5RemtG?=
 =?utf-8?B?eXltRmtweDFxYk9iWDl0VHFNVmhib3FhSTFQdmNsS3JnanNQN3hhb1k5S1dB?=
 =?utf-8?B?UGp2RW9kazNoTytFV1d5cVJkdTNZQS9Dc3o5enY4Mm42a21RQkFiMFd6Uk5F?=
 =?utf-8?B?ejNxSHNDeXBVeWF5V3lHMUwyaThPSGQxaDNDVnZlem9GWWpXS0hWcXl0VXNR?=
 =?utf-8?B?QXFaWlJ4bXIxakt6K0NxcjJlL0ZnWklpYXdkWEd5amhheGZoZWJMd08vKzEw?=
 =?utf-8?B?dFF3UDYrT1BQSzAwS3o2eUlnTlpBNitjT3JFWXdXVmh5UmVNdFVRV1NrOEcx?=
 =?utf-8?B?Y0hrN1Nac09kaWpQWXd5U2lYZTA5NHZmOEdNTUZyQmxUYVBBdG8za1dmUlpq?=
 =?utf-8?B?RHBRWmpyZjF0N1cxS01ZOHQ2MkRua1ZoS1BEdU5QWlRURThVOEF5QmFBcHFU?=
 =?utf-8?B?MGFBcTZNaTQxQXdQTTA3ZGdwelN3NXIrK2lLTnpGT21sbkV5U01PWVZsSEVE?=
 =?utf-8?B?Ty9VV2VIbXNwY1NvYUVWRGh1T0JJNWhqRzg4WjgxeUpiQ3FxOFNQVTI0dHdP?=
 =?utf-8?B?Nmx0Vm5oQUJPR2NHT3AvQ3pwVWRLbDdhQmU2VHRwcXhMTjkzZlRQeTlleXFi?=
 =?utf-8?B?NDNRTW5Bc3pKMWJ4M0ExbU9ya0hOREVWczI3SHNUYVBvU1ZnZ0tmR1l5U0Na?=
 =?utf-8?B?NjhWZzF6WWhyck1JQlNHT3hDTzlwTHZCcnZYZ3JyazFJY0RONm5xZnJTMnli?=
 =?utf-8?B?SVl1elFIQVlkenNYZVk0UklUM2E4SFZBSjl1Rjl3L0llZ1ZIQ0ZHejFlUFc3?=
 =?utf-8?B?V2l2REd2QjRFa0ZjeDZua0pJdUk3d0hPaW9PSEtTT2xkNWczaUE5VTZSVGty?=
 =?utf-8?B?YVlsTUR4em1CcTJ2NTRQZGxGT2duQ1Jja1JFbHBjOHpGQVhyT1MzT3ZoZy9V?=
 =?utf-8?B?L2tDdy96cEVVY003LzR5bDY3TmwxcWltL0ZkMFJCME1kbnlFeDREUFdJb24v?=
 =?utf-8?B?YXJtNU5lMkxaeFdOei9yZTI5b0dxOEt6UXp4SDdmcWNaTkF6eUxjeFhuYmdB?=
 =?utf-8?B?WEs4d3RLNXlNdlNBRnhhMTUxZGplQVBGY0lXM2VGRk1IaG41SU9QTzVzb1dP?=
 =?utf-8?B?RHNuRFh3dnVKdFo1a0YyMEsrN3FxTmJVa0JhdTF6SU9yUXFEUTF1Z3BWTzc3?=
 =?utf-8?B?aXU1QnMyZS9DWHNUN1NncWpLblM1TWRaaStDSHJHWVgybE5YSTRDNEVoUEdw?=
 =?utf-8?B?cVJQRkNvTFpXRkFVNHFxekl5U0dKOUVvdUhzczh5dkRUcnZWSllXQ2h3eFYx?=
 =?utf-8?B?WGZ6L3VoNmdjU3NtNFdpZldPWVFncE5wVGFhbWxNS0NsdE9LZUVveGh4NVg3?=
 =?utf-8?B?R0xFem1tWU5vdnBaWWtoSjgxZXdtU0ExNGtpUkN2dVdpQ0FkY2l6eU9UUTZl?=
 =?utf-8?B?MEluV1lxa2hnd0xDdmx3VXh0SUJXZnFkR3ArUzVXMGhOMHBiUVFxNFk4Qndr?=
 =?utf-8?B?RFdacndqOGt0eTMzWi93U1J6RTVnRlUwQ0dZOStsbmlnVlNkcUlJS2RuRVor?=
 =?utf-8?B?cHNDcGxwNlppbGZMd2c4ZFpEMm1uRFlYandNenF4VTIvdkxYYkd6MUNZdlg2?=
 =?utf-8?B?WWV6MHI5amlhdjUrYmo5UkdZSEJqU3krcC9PUGUycWZUOHpTazN1Z2oxV1lL?=
 =?utf-8?B?czd2a3N0bEQrSFhWUGdUemM3bThoNE5oODdkZmhHYlhLRUlPeHBOMFBrOHI2?=
 =?utf-8?B?VTMzQ0h6aGd1bEEwUFpoMklieVR4eEM1bEx6c0xuUUpKUUIyWkxtOFQwczVE?=
 =?utf-8?B?NDArL3oxUkZZL1BscE42aFNXZEovMEdNNW9vSkxsU3hLS1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xNamJzNUM5RHh1d3lMUDZKQ1hnTDVKV1ZZa3FST1NTSnU2cnhHZUdqVnpx?=
 =?utf-8?B?N3ZqNTRxV3IzTytUeDloTlkyMmlUZENaQTN3aVNIVDRWWTFTWDJvZnYrTTFh?=
 =?utf-8?B?bEp1dkZ5MmlzUXdic3RSU3BpYlp4Nnh6cGJHa1FtMjBiT1NtSVc0SkVlOXJJ?=
 =?utf-8?B?STZQSjR0RFdiRmdpYlhwejRGWGVNTWhaOXRNT0pzdzFWaHlRcnZPcDVCbTdB?=
 =?utf-8?B?OGhkRm8raVFaUjVvbVdFUDY0RE1BUnJVV1hRVUk5TEVkZ1NlSXhCcEhsNStl?=
 =?utf-8?B?clpqb1NXRHQ5YTAvVU1JT1dQTm43VXU4dlJDU2tiM3ZYUjQraVRjN2p1TEh5?=
 =?utf-8?B?UHBnRHJnMHpWQ3VpamFubm1rSnpUcTRnNjg1NXovcm0wY1pYc0ZobGxaOUFW?=
 =?utf-8?B?aGhaL3VjU1JFSWF4bUY5ZDlYSk5FWWFiSDFvL0xPSVdSVWRFYUJJamdIbW5D?=
 =?utf-8?B?R1ZxTjh6c0tscWhFcnk1cGtwaHZNVHdqVmFQdUFKVDk2ejhrYVpUYXhUTWFY?=
 =?utf-8?B?cFc2SmNIYk5qSWovY25jMUEveGdwekEzRGFxZk5WUUd5cEo5eXFYVUV1UFR6?=
 =?utf-8?B?am83WUZ3cGJnT2tERnVScDVMZ3VpYzVwQ2RmQ0xERmltOEVPL1c0am9nQUVp?=
 =?utf-8?B?WW9BTXVVbjNDVEdqQy9lK3FPaDlZdGNCSjAxeGNFZ2dZenZTeGdUelppTmkx?=
 =?utf-8?B?VldZN1Y5dVp6RkZBVGNjTTRLaWhwQ2pRQnRDc25acnBIYk8rTU1Oa3VUZmdw?=
 =?utf-8?B?ZTc3a2dDSk1yTGpGc0YrNlFqdlMyQTRnK0Nxakxaa0dISW56NUF3bEYzYkRj?=
 =?utf-8?B?bzZjUTAyRWpyZ3lXTXQzSitYSWJVRlZkb2I5SkNqRUlqbTdSUE1nakprbEZq?=
 =?utf-8?B?L3UvZnNCZzZ2R09nSXNqeDNNQ3JYS0hLU2ptYTJveldMSVBPQ25Pelg3SVVR?=
 =?utf-8?B?VFRRa3BSRzVXelpZVWdsUCtjL3BrWVhuVnFoOStOdXVSeFA1dEJBMXRFU3RV?=
 =?utf-8?B?b2ZnR2M2NnNETVN2ejJKS01FS3BRQlc1MU9CYTcrSlV0b2tzMmJxTjhMdUI4?=
 =?utf-8?B?Q1VqNE1rTVRwaUh0aGhqVXhIVWk1Mk9mM0VYT2psYWFSS2YzRTVxRE1SZjE0?=
 =?utf-8?B?OUl0R0ZWcklZMFpqQlQwNE0rcG13OC8zd2llQmJIdUJNOW9RRzYzaTdIUGRn?=
 =?utf-8?B?U1RtckJ5Q1dQNUtDK2sxYldRYjVyV3luNEhXYzZMNGdxL2VBRTFKalRWMk1n?=
 =?utf-8?B?ZnFXQjBONGxqZ3hnN2ZWaXhEK1o5L3FtMm55SVkwZ0RzOVFaS1U1Mm9KMmNr?=
 =?utf-8?B?UVpRYkI1aEVrN2d0c3dmcVQ0Y3FnYlRVcXV1dDJYMFFHcHU2MXdnWU5nL0c3?=
 =?utf-8?B?WStSUGpGUGpFZGFyRzZ3bkVtd0t2WDNPeHJRMEpFR1ZoNGdqM3hLMkQxVUJT?=
 =?utf-8?B?bXV1TWVIdHlCV2ZUM0VTOUd5WTJCWkhpQkczTG51NEpMWC9maUZPcWVOVUpz?=
 =?utf-8?B?MStOY2lCRHpmM3hneTJTb1V4UzRtYjVsRFVNZUsvbDRkdUdRQ0NBSnhIT2dp?=
 =?utf-8?B?bFBDbXdLWjVyQU16MVJnNTN3S1J0NG4raXpTbml0cjM2WXdLMlgzamRWQ1Zz?=
 =?utf-8?B?ZGtDSXVnUzBnMEFvQ0dTK2VFM21iS3hHQzJONDU3YUhndDBQbXNtdjB2NktY?=
 =?utf-8?B?Y2RpdXhnWHdzdW41WFZFZFVyUk8xVnJGMStLZjRrSTY1ajhIQi9IbVFSS3hI?=
 =?utf-8?B?STZSMjFIamt2Sm1aRDdXdTg4SHRqTStkMWRvaFk3RE9GYVU0N0w1LzRTOWU3?=
 =?utf-8?B?b0ZSTmtlZnZtVjN6OHRFeDhQdmdWOUpkV2VQNWpNa0c5QU9VdVFDdHMrSDdt?=
 =?utf-8?B?bWJlMCtUa3hUc3dWdXczdFBDdVdWb2JQRWFYNEx5cjJ6aUMxcjlVOS9NWmla?=
 =?utf-8?B?YnFmRXJFNlZUajZacENuZElhbVpPZHRRUlE3ZkJKMDdoQjZiejNheTdXWjFz?=
 =?utf-8?B?Z0NtVExXQUxXRG56bnkyRXVNVXNWaTNJMUY4OE4waFpYTUYvZHM3UklQK1Y3?=
 =?utf-8?B?MEltRm1DWTAzbXVLR3lGeFhDNlFUTDFSanJZWFdub2NydFAyVHI0bDk2eDc4?=
 =?utf-8?Q?chOAJOzeNUn0aPdKfC9p3UqOX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326fa524-0a09-4134-dac4-08de0b4e54bb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:20:19.2994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt/8ICu7iKfIZx97YqyRzuMgzPebhL9/LBGlouE/I5JTygVE+XY1pkdTr+oyTziUuDaL0UoUmgBZ91wdS13I0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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

On 2025-10-09 16:55, Mario Limonciello wrote:
> [Why]
> If userspace hasn't frozen user processes (like systemd does with
> user.slice) then an aborted hibernate could give control back to
> userspace before display hardware is resumed.  IoW an atomic commit could
> be done while the hardware is in D3, which could hang a system.
> 
> [How]
> Add a check whether the IP block hardware is ready to the atomic check
> handler and return a failure. Userspace shouldn't do an atomic commit if
> the atomic check fails.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6f5be090b744..5a189deac631 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12014,6 +12014,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  
>  	trace_amdgpu_dm_atomic_check_begin(state);
>  
> +	if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
> +		ret = -ENXIO;

ENXIO means no such device or address. Wouldn't that
potentially confuse userspace when they debug issues
where we return ENXIO? My understanding is that this is
a transient error, so maybe an -EBUSY might be better?

Harry

> +		goto fail;
> +	}
> +
>  	ret = drm_atomic_helper_check_modeset(dev, state);
>  	if (ret) {
>  		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");


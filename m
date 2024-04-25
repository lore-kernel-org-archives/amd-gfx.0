Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3924CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C25811A1CB;
	Thu, 25 Apr 2024 06:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1bdL3kJ2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDAE11A1CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRCcmq68tVKJYKwp1tfp1l+QUyQ2zDha54N2gXColAQ2bPF+LtXKZfqxbwlokEwzREsC2QeGsDa25KmEtxoGa8lwAn3xrkvfiSZJ2lxwLpoTT9yn1CzelaGZml0DyTEUr98PIyMy4zPg0FXNGRbxna8kq7/Vq+E53S09JM2b3I0UeGfMojrFQysE4uSKGrcfYVkr6W59Y1To50mmbN9UUNJsDB60pxaVfvvc7n6WEtvtRAmYontBy6aY4Ki9ICORc3+z5JQrm2m5pQhV+7dXCWUjxqa40c7RtOTlrb9TsGhvTcC7ejuLMSB4tOeR+NhkN6Mfme4op+sXKNF5nR3zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp3lgFtYNl5zTUdxGxOMc3WDYS+PReUd2EOku63egeg=;
 b=KIPaMMCevKPUTpw1ggIxOapF+N+7o7CZ/XOdxhdsmZt3EdVopINqslR5KHFkCILbmcmFfTMbSzhtNWBh/0mnmt1WZU4OS443jE1rUeRx7Hyr04gxXFYZyH2zrkk3n+Qz6bi/ZxnonbZuMo2USMz7XD/woYH2dl6fSZFDcEI9OC6/PFU7YGTRr6qvLs1a4/vyn4u/Drlazuc0Xflpz87NhgqSg3rIHzDyIkX4QeKfxjeLyXB43We9/cEjJcTUBHT94nCLJMkO6ZfunCgI1Jk6lIaYQR3uWSpG6ytizmV/7vkfbNWsQERTnGCjKoVe0aANzng0QigaKyXg49zSZfkn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp3lgFtYNl5zTUdxGxOMc3WDYS+PReUd2EOku63egeg=;
 b=1bdL3kJ21qgpwsbfeZ+eNT6N1yY4pVLNJAqv2edTblTeGG2/wPHJnSfACkO/HvTuJvy/brqX0mwWeS9TkjWl0T2E0i81uqWM1xMT0Ln0LopxED09HWKYwvbzWTSpmoBXEn+4Rj9jNiBSxWML3gb15YWghrpq9AYNAKrpZ3ghJWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:42:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:42:21 +0000
Message-ID: <ce17902b-a4c2-4722-9f79-cfebeabd67e6@amd.com>
Date: Thu, 25 Apr 2024 08:42:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix potential resource leak warning
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240425033325.1307714-1-tim.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425033325.1307714-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: d6642d72-81b3-4166-f22f-08dc64f2dbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clRUakFDdHBnNEt2M3NneHRFSGxqS0xJRWQ4SThSUHNFVzlNTWdxQndkMEtG?=
 =?utf-8?B?NWxKa3o3NUpmNmRhVnFVQVVRd3kyTjg5aWFJWGhmQWtCZDRyYlUwSWMzR3Ny?=
 =?utf-8?B?UzBGVmNxaEJtc3NIL01nRmVrV3E1c2hDVDQ3WWxxT2NaYnRjKzQrYXM3dWNJ?=
 =?utf-8?B?RllxeHpwMzlid0VoRzlOc0p3WWJxRXFmOUN0ZExsNTkramVuNWtoT3lrOFd6?=
 =?utf-8?B?a1Z4SDBSbjJNV0ZEbldlSDNUN0F3ZVZZZTNMb05YMldnVldLNFhJMXRDSlBC?=
 =?utf-8?B?Q2E2d0txelhHZU9sdVkrTGlkL09GMGZodHJqNGdmY1o0eHAzR05hQ2U2MXE4?=
 =?utf-8?B?OGxRUm14S0tzOXZ6eXB4NW02YUpzZkZTaVBLckRoRjFjKzIraWQyaVhXMkFM?=
 =?utf-8?B?ZWdIdWFzK2hZTU81NnFxK25HRFBCRmp0RS9BczZrSS93UHZDNk92SXByeFQr?=
 =?utf-8?B?M0k3aS9kWDV1Wk92emt4TlVHY05BbDl5cGtpcHRxQnNmM0VCVkV6VzBqNVFF?=
 =?utf-8?B?dDZZQ1FQL2M0bm9XV3dRWjZFUnk1VVhmRk8rV3grbzFqbnpqbEd3VG4rdzRI?=
 =?utf-8?B?TWJqUE91QWluOWtReExHTG83Q2k3TUJuSG1mb2dWMUpvNUtHekFqc1hPb1dO?=
 =?utf-8?B?c1dNZ2Fib25mMEFjZU5RMStPNVdUbXVtZksrcFlVb1ZGRU0vRG1vdkJ0SkNY?=
 =?utf-8?B?S1V1bU0vMVZCcVBGblZJelJjQWFKU1B5K3lxTlBLNXBUSFpXd3lkZmt1QjRp?=
 =?utf-8?B?SXJpRFdGSUhWM2xvRVlGcEhKLzBPK0NkamFoWDNtODdTRmRnRlIrdHo2MVFt?=
 =?utf-8?B?VS9OWUlCRWFjRURKUkR4SlRZRVIxMVkxMkl3Ykd4RFBTeGllcEtQUXo3NUVR?=
 =?utf-8?B?UUE3MWJFR01QekR5NkhJZGhPNzdvNzlNWWlOazg2ZDltSzk1OUh4bi9Bd3Uz?=
 =?utf-8?B?emhibFFWQTltOHB3UEJOclh6SWh2RXVka3orN0I4Mkg0T1NwcGlKR3B0aC9o?=
 =?utf-8?B?TkhJVG5XYWpqRU52TTZMME1KNFc1MEtmNnpoZVVHTlk2S0tPUm51S1orWnNw?=
 =?utf-8?B?RnA5R01SaXQzZVRWQktrSE5YY3hkaEFyUEs5OE42dEg0QUNId01GRUE0cG9M?=
 =?utf-8?B?bXVranhqN1h6dk51TkJWV3oyWWdhOCsxVURMSmdDUUN1MTZ4NDBFdVRrdHlt?=
 =?utf-8?B?dmRFeGtvSnFGWkZkNzdFTlJpUmNSOTBmYnBrOE9vMEZua21LSkRrcFh0MVVD?=
 =?utf-8?B?ZXlPY2ppUWREYTVtRHMrblhReUVsWXI3V0dGMkRoMXFMZjRac2VuTEdOTGsz?=
 =?utf-8?B?SlVWS1pFclRtY3UwRHNLY1I2RFlhMmNrQnFvWDk5U3JBbjhINXNPOEtkSmU4?=
 =?utf-8?B?K2MyNDloQVhHTTBSaE04dzZOdGRXQlhwa2N1Y2hOSHIwUjR2UHdQQm5GZUVZ?=
 =?utf-8?B?d1pZTnFMTGYxOFlZVzJJQ1cwRUlmajhReTVQSkFJUFQzczc4eUwvaXQ5d0x0?=
 =?utf-8?B?UTRJV3JDS3Z3QnVJM0ZveGI4WUFiVVcvcDZ1b3lOTWhmcXljT21uNWdsY3Fz?=
 =?utf-8?B?czlzVEFHeHEwQ05xRDlxZEw5aEYzVE4xUWQ2NDFRK3RnMmp2WTNpVjBtNXRx?=
 =?utf-8?B?b2RVUFdwNHd3NWNpSWdxMGQwME9BcnZNTk9CSzFaYmZmQWNpRGtnK21qN2FM?=
 =?utf-8?B?UGhJOHNmbmdNUCtLZThVMGYzYStLV1JpbUNPczJ3Qi80TUl3YWdrNkt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dxbDl1a0hoMzdNZ2trWTkzS3FhWEFNQ0s5VFlHRUU4eVp6VWczSU85a0o4?=
 =?utf-8?B?ZkJtV1VTUUJBczRPMTdvZmgzRmhXNWFPb25KeWlobk00M0c5SU1qMnJsWU1q?=
 =?utf-8?B?NG5LWkJYb04xdER4VnQ3M240d09tVWgzUG93M2d3dUhyUHFaMDJNK0t1VDcw?=
 =?utf-8?B?cVVBb24vd0tseEMxSk0rSnhWQ1dQTU5naWdkWEVwd0swMmUxUFlleEd2aThn?=
 =?utf-8?B?dmx0NWNWNkdjZlJ3NWc4a2VFTHd4U2VNZ1JveGVjNDZzM1ZpbE83eWNZNGUr?=
 =?utf-8?B?aktvelhJVnJjY2NJNkUwRmdYSU81V20yZE9mYTJYTGpON2hucHYvS0h3TXlq?=
 =?utf-8?B?MUpGMmMzdENIM0NjOFkrdzJJbkovN2hoeitQajhFUlc0eWVVNUFkQTMzbERJ?=
 =?utf-8?B?WW9YUFhzaS9ST1k4MlJ3UE1WSUhjZURMcktzVmtWeWExSjRwMVI0a256UDRZ?=
 =?utf-8?B?R1ZuLzdtbUJKWDNZbjczVjN5cFBaTXZ1UGxxNzhtV0ZGYS9melhJb25nb3VK?=
 =?utf-8?B?UCt0bVdXc2Y1RmJZVFBZNEpiZkJFTU1nbDFVUEFsaXRsTW5iZEY2SURMMEFj?=
 =?utf-8?B?Qmo2OU5WN29mK0lpa0tubFdQcmxjODM3c2VRVE9yN2hTd1kwRTUydTRzUGJl?=
 =?utf-8?B?VVFuTSsydVJDNE5yaFo1amkvNU1kN0xCNEFYRnZzZHpvaFFmbExVN0FORWZL?=
 =?utf-8?B?SG5HMFlIWXJkaEJwVGFyeFY4WXd6bkJuWmtYN0FoaFREQkxLZXorZ3RBcysr?=
 =?utf-8?B?RUZ5am41Z0ZvZWlLOVFkR2piRDB1YzZUcFlGWDJ5aDdXVFYvTVZqU1l2eVZi?=
 =?utf-8?B?a3NCMkZUdUhhaGVJSFFwc3k0REg3SlhaL2RNbDJRU21TTDB3QmhWMmVnMHBI?=
 =?utf-8?B?WHJpTXc5Smp1Qm01OXUxanlydUZScGRudlNvcEMzQkVhU2VpcXdQK3dGRnlZ?=
 =?utf-8?B?Y0wvdG5kcHJ0cTRyOWlmQ09ZZVZGRFBWazRuaFpMSjdubnNMZ252cUVtejRN?=
 =?utf-8?B?UStaVFlXcnBPTlRPQUFsWGk4dGpPczFoUU44bUUyMjFKM2Zjd1J2N3VzK21s?=
 =?utf-8?B?Rk81RTdjdEdxcnc2NlNiblJmK29ZeVVjdXFlOUczMXpaRFM1aTZDZURndmJa?=
 =?utf-8?B?OWZQR2J3TGZwSE9DMitDa0RRdkdVZmJJWnpoTmhhVEd2UGFROEIzbDRZYlU4?=
 =?utf-8?B?NTNjb2NyNTVMK3NpUmFiSTA1ZjhrRldUMkJGTGZHbUVVTWlHUTM4Wkc3eWJy?=
 =?utf-8?B?cVRvbHFjeVpFZmt1T3FvNFpwc0xmMzNNR3R1R3RkQmxVeUhoWmNydGRaWVB6?=
 =?utf-8?B?eHlINXQzVUlSTVIxWUJEMmxlUnl4ckFJZnhyVVM4QktiNFNJa3dVbzZZQ3hi?=
 =?utf-8?B?Z0ZSaXdNSC9CaVhBcnhrcHhsSjlwT2JwamxvN2hxQm9IbUxjMTlYMzN5WVl5?=
 =?utf-8?B?WWZIZ3NSWXZXZWtkSDZMMFpPMGt5dVdybDRJclA3QWdvOTgyb2hYT2xCK3RN?=
 =?utf-8?B?UUN3Z3FoYWJieElsVEN4RWVPUWFNOTNyMFE1N2RoRnRKa0RoVmRvenNGOUxa?=
 =?utf-8?B?K3dRc0RsYmh2aDNOa040eVpTeTdlNFowRDZvdWw0a3RDMmw2dXVjQ2g4Rmd4?=
 =?utf-8?B?U3RvVjhqL0hFVHlaVDg3RnR0K1ZjU0kwT3UzZExNUUNIL2FoYVFZN3p2YUFa?=
 =?utf-8?B?UEZlRXluQ0VBOHo3YURzUGdlRWhMa21GZndnVEcveEdDSEFtbytlNlUwei9W?=
 =?utf-8?B?S0NsRkJlcCsySzE5a0xGd2QzcGcrS1NFRURyK1BLSkFKdk41bjV2OEgxdXpp?=
 =?utf-8?B?OUg1WmMyOHZNcVVQZEI4M0VYWllDdGhQZCt2TjE2dEk5WXpJOGlpVUxjRW5O?=
 =?utf-8?B?OWwvSXNtUnkvNHJRVTVFUHlCZitRRC9QSkcyQTNmRFd4SGhZTml0WWhJWnFD?=
 =?utf-8?B?MmhvK0VOdjI2UzJkSDArMnh4YWZWaWRIWWlxZEpRL2hHZVU4bUdsQ3FoQ0pE?=
 =?utf-8?B?NFhrWDFvd1k2QWtITlVsT2dkaTkyYzZubm41VE04bklNRjdvY29zaVZING5s?=
 =?utf-8?B?UWlQZ1BBQXN3TGpmY2xZdDhaRU83cURON3lSbGE4dktLMktqbzRvZXBuM29o?=
 =?utf-8?Q?S0smbx2WynWQlcDnJ+SznsAGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6642d72-81b3-4166-f22f-08dc64f2dbc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:42:21.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4FzUEIfDskb17M2Fjl+Ky9LhOi3DtaofsZLG8OtAsx7okoI+1ZmDc8Z2mDIgjiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

Am 25.04.24 um 05:33 schrieb Tim Huang:
> From: Tim Huang <Tim.Huang@amd.com>
>
> Clear resource leak warning that when the prepare fails,
> the allocated amdgpu job object will never be released.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 66e8a016126b..9b748d7058b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -102,6 +102,11 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
>   	if (!r)
>   		r = amdgpu_sync_push_to_job(&sync, p->job);
>   	amdgpu_sync_free(&sync);
> +
> +	if (r) {
> +		p->num_dw_left = 0;
> +		amdgpu_job_free(p->job);
> +	}
>   	return r;
>   }
>   


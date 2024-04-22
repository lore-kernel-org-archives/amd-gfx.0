Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 06:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79671127D2;
	Mon, 22 Apr 2024 06:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WMfBVD1z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DD71127D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 06:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z89anPPtHLEPyg25Ta3w3MDJfAjRohNWOTfY7CSVe2/O43fjBpG8v7mciDgCrBcrg62X2OicEgTr03v/5BCoJXfSW6CaK2D966VFTz7eL904Dov0kO4xUsWrBSBh3dFt5YBtozp/v0GE0GKHeH0SaNaeP85oa1oeOzzZLhom5ma9XbATvKrj7ps8LTNYhwcFV06fr6vh7nDUejqtjCrUOy6iE4nrGXL4RGpItmsNa/9rPKqzRs6WKKt7TLxNzn2sG3hlmsOzvwf9JjPuuFq5fGa46dOWu00CZxPWfMrNfMvp/rAHfDuXXpKW7W3OPuopYeEtMaTGE/TPUtEyFGWnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U3N9inQdG00f2ucu/ImnubSnqJ7nn4jHV4rD13oXao=;
 b=Sre+N/liVv+U7iabcipFUjf+1lP13uzEv01HtWnMi5G8e988EBBpn93B4SzlVaXE9Lx0Kr15vxcMStoEraEp016WzkjuX37nOLP1eCMTd4WmpdBi1/pnqdU60RUCIAKGsLMLKzeQNADeNO8ELtZjlJb6lezn6EmoE/2lJXfVX2/WKo9j5nwE83OAhcT4rp3u6nEI7em2Gwpz5hw9av0YpXyZ10pYe7rsvSKy6e6sgpvZ27078isYGKyAMen3gLzZZpYzybPHnfCvpZsb1cXqpMdefHg1W7dTs9/SF4hE0otl6OgxnH9P6OG23GmReW3LRYZ1UIuea2rSZECaOiFeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U3N9inQdG00f2ucu/ImnubSnqJ7nn4jHV4rD13oXao=;
 b=WMfBVD1zDtVRgBwHLMAryjGwNBTjD0/TrOXY7esPoW6IgUXkkFeMSxLrJvCPMhAXDSC+Vas5bfrdfNK1O6/qPhnQtwcwE5SAnkpvWurNx9CqJRj01jY41g/1p7xTJVNuxHwmzN9Z0MJ03ES9T1d8buSnWMK9Dzdhd2wz7jHMVL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 06:24:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 06:24:06 +0000
Message-ID: <e7ccd692-1194-4c6d-bfc8-64b6abe056d7@amd.com>
Date: Mon, 22 Apr 2024 11:53:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: init microcode chip name from ip versions
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240422055343.1894762-1-le.ma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240422055343.1894762-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c15c88-b1d1-4336-848b-08dc6294cf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpPU3QyZGhYVlpFTEJDdzRlRmMxcmx0T0dxQUZiR295cXpFb3pxNXNJWW1Q?=
 =?utf-8?B?ZEE3RmpKalRqVXZxYkRnbUJERVZvV3lQeU5VNGYvaWZ0VExGOFNxVytEUllG?=
 =?utf-8?B?OFdVcTFUemI5UGgrcFBnNDFlOXNYdjVMd1dPTmsyM2FWZnI2SEl6citpNDVU?=
 =?utf-8?B?UFBTQVFUaWphT0VEUmNNVTRycnFSVEhtNS94ZHpjMFc0YUJKMDNYSHpPKzJz?=
 =?utf-8?B?WnV2MzBwSlpHeG9VeVRGNVF0VDMzeXNDNWNmdlNoVFQrWE94Mnp1b1NmWUNo?=
 =?utf-8?B?R3NrRS9zN3U1QVlSNE1xTnFZT3dvM1RPZTd6NHVyQ3plSGJFR2dyMjVMc1Np?=
 =?utf-8?B?MEJvTGFRdm4yYTJFK0E5bzlrVys1K1FUZFUvRzRJMmRIblo0T3I5VWVITnpJ?=
 =?utf-8?B?M1JON0k2L3hiNzV0QmlxamwxNm5GZWtjbEJKWVoyaXRhekw4dmFqSFpXdWZL?=
 =?utf-8?B?clNKMXFWT3ZiVm5ocHY5R05Bc2NrQzdmRlVQUllsTXZVcml2ZGZacElDcmhm?=
 =?utf-8?B?anE3MWlBRUN6Y2hsdTNsZSsxQk51ejlaOG5jNGtzZnJtR1VjZTRicFhiWSs2?=
 =?utf-8?B?Z3AyYzJZWXF6MVc4ZlRBZ01XZ3JrOUk3aGhMMFFTSUtPTXBCbkpQcXY4dERp?=
 =?utf-8?B?eDE5czl6cGpkcGgvOGk5aVhhOEQrN05UODVrbDhLS1pQd3ROR1R1QlBDaE04?=
 =?utf-8?B?RjFQMEptbkYzY0ZZanN3cEZoaDFjQ2xWS01BaktIaEFrL241ZXVJSFNPTUFZ?=
 =?utf-8?B?bnp3ZVRzNEFkb2ZNREZMc042cGo5Q2ZBeURLa3NBWFJ4Sm1yK25UNzRteXo5?=
 =?utf-8?B?UHpRbDdwOFJVNDNUVGZsYVFQcTFEVWUzVUJzUURnWjlPUUt2TW1hWjVQYitV?=
 =?utf-8?B?SzJIaSt6K3BTNEN5bTFlNkpkZWZzKzFFejRRajZTYWFNRmc2NERTamZVVGRY?=
 =?utf-8?B?enJnY3IrUjBEZ2dzVUlKRytQVXZSYmdPTFJ4NjQyVW9BUC9FSkNUNlZ3NE9j?=
 =?utf-8?B?YzdUSnFSbjJMSTkzc3FsbkVJTVViVVVOM3FMcDRnMnpmTFJZcFIxbGVUUy8z?=
 =?utf-8?B?Mk1PNEdDb2FnZnhBWHNUOHhwd0Rqelp6Q3ljb2laTkRuK1c2YzA2ZmtCejBQ?=
 =?utf-8?B?dkVaRW5jNDNXeDV2OFhnZm1yeGZlSFNyZVQ3NnRKM3U5ZTBIbUJuNXFoZVlQ?=
 =?utf-8?B?QmFPN3haL2lSNEIvTVkyK1VFeWNOUGNod2tWL3N3R1EvMkV2L1hXcGtGb0gy?=
 =?utf-8?B?aWhGTHcweE85Mk9mT0t1U1hUNmFCRjJvV2pGZkpyYnFBZXRFakVGUWtWWGVS?=
 =?utf-8?B?WFg3bDJYN1o0OFhUV3lZMi9XVGh1aWVnSVc0Z0FJejFaMWFVQW8vc2VWbldL?=
 =?utf-8?B?YXJxSnVRYlVISzlTVVY1elo4MDI3Q0p5VG9yK0w4Z0U1dm5xTXJLV2JxZjBa?=
 =?utf-8?B?TktieDVjaVM2Zkx5cExhQjhyZDFFN0hUNUtMcDgrWFB1RG5zK21RUnNtekoy?=
 =?utf-8?B?bVlHN1Vsc21IV0tvWXFCVDB2ZUFqNmlycjdwMURmYUhCVTgvWUM0NGZGaDYz?=
 =?utf-8?B?dmtCRTRiWUtqM3JaNzhQWVM1V0RzQlRjZnd2T0lWMkhzWGEvKzltcGZMbjdP?=
 =?utf-8?B?MUlSVlBkZnowcHo1WENxR3FVbzFVZWZPUGltNEd1K0VwS21GUy9ybEdyV2da?=
 =?utf-8?B?YnllNWRPemlwWjUzaUlmcnhYUUk3ZytmQ0RDTExWRmZOb05PQUp3OTRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRlbGZvOWZYTG56QW10cHRQcmhLWG50RkxZNktlRms5ejVVNFd1NnZzdEJC?=
 =?utf-8?B?M2pqM256TVZOeHlTdjdMc1JjMlV4dGlOWFdjL3kvVGtJMGhwYUM3ZnRIZmNO?=
 =?utf-8?B?UWU5Qm42b3A5VjBJVWl6SmdMa3lnNEJVaWhIWkxGa1liWlpsRERIQ21ydjlm?=
 =?utf-8?B?VHdKeWZXdE16czhYRzJTRit2NGFvbHN6eWtScEVFUnVWajVqNGhYZzlZVFNh?=
 =?utf-8?B?N200YVdUbnRzbkhwYnNHeEdkWXZBZHhhYUNJWm0zamwzK3BRTlJkUnkwY25h?=
 =?utf-8?B?V2lmM2RkeUVLQ0xWSEdINmVDaCtyWE1ES3NqajM2azV4cWlQZ2I5Mm1ZdEJF?=
 =?utf-8?B?WVR3RXBBcVJNL2FvbWprWGkxeVFaT3JsSXRkOG8wd1ptdGhxUVdDQVk4dzhC?=
 =?utf-8?B?ZVVhOWxheVN4cEV6U3VRd2hpVU1GNVBUa1dZMHNrbFcyeUIwTUIrc0VSOXNs?=
 =?utf-8?B?REtXaUxBOWVDaVdncWQ2dm5aQ1Zlak15T0w2aHFwYnRkQ2hQSEpHWitBNzVI?=
 =?utf-8?B?TTgrMC9rMnBad3ppZ2l2cnpLTTFqOXQzZVRTb1g0djlCV1Buanl2K3QzR3U4?=
 =?utf-8?B?Wjh0NFBLQVJsR2I1cDVBWXgvbWdkSVIvTzhZZEF2RmNUWHJRMFhNckNXVEtu?=
 =?utf-8?B?dWwvNnJFRW5iMmsvZnU4enRyY0FxSUtCdnFKaVJpYmdYeFFsRWFlY25BcTJP?=
 =?utf-8?B?V2ludGlackdSUGZ1c2JPMkxqZWVzK1UyS3VBeS9aSGFFcUdPejRUeHVPUGhG?=
 =?utf-8?B?SU5ueTVyRW5oblUxcEd4Qndic3FiNnlwRkpRcGtFQ3QwRUt0RFlSRjNEQ1lh?=
 =?utf-8?B?VmJKSlVMV0lFZ05WSG9pblp3aFJhbUtjd0tmZzc0dUQ4UGhubGdBV3V6ZVUv?=
 =?utf-8?B?UkFtT0dGWGJVUWc5ZHFzMVVqRDN6aUs5aUJ3TjFsekFnZGV5UzlXWXNRbWZT?=
 =?utf-8?B?ZEtxWTYzdEJQR01nYWUzaXJ6THIzbjBwQUxNekhiaXpBZ3VpV3czNk14RTgy?=
 =?utf-8?B?MTFsQXVkY0RZYTNEUk9McjZuaFI0aVJ2c2pBZ2tvYWlOMkRLWjM4ZGQ2UVN4?=
 =?utf-8?B?NUJtQlpoUVlMRFhBTm5hVmtNK2ZrTEtLK0tnTVRiNUFQY2d0MTZtR2k3ODVQ?=
 =?utf-8?B?K0tzZkMvMFMydmdER0FubSt3ZHFhLzhxbng1emM2OUkzMFlKSklIWStDQXA5?=
 =?utf-8?B?QTVQZTFuL2FnNXcyOEp3S1B2eStRMXQ0NGxnTzRzNnIzQkVpVG1ZKzNGeGpw?=
 =?utf-8?B?K1dhYU1WUjF0ZE5QK1ZUNG1LZjRTZ3ZpaFhscmFVdVZOcjJCaU0raXM3T09V?=
 =?utf-8?B?cjcyVlhId24yNUNaQlRBRWtoSzNFMVZJM00wWTZYb2t5c0Y0VmcxUTRGVHJN?=
 =?utf-8?B?VkZ3ck5HeU1yajFEZ3JNYlFESHZLTnAyQ1E2bGx5K2tqVVRkbjFoVHMvRm5G?=
 =?utf-8?B?bUpWOWNxanI2WVdyYmx6a1BzQUdXWG1RNldWZWtmNmw0UVQ3ZzRZM1Y4cENx?=
 =?utf-8?B?emxKUEcwajJHcDV3djg5OENOcXBmT1NDcFJDcVJwUjJyb0xwdmN5d211Z1Qr?=
 =?utf-8?B?K0Q1UE1wbU1rWUc4SGxiY3ZNaTRBekJ3RHlHQmFzWFd1c0xFTE1wTllBaGd6?=
 =?utf-8?B?b2oxakE1dXE3ZkhYZGJlOHlvbmZCUmNWRW1RWENWRlRIdFk0dElXT3RLTms0?=
 =?utf-8?B?VG92K1J6dzRtVFpucjA1NVQ1cm9DYkZ6VCtqbG9WajJiWmFCNnl4aUpVeHJo?=
 =?utf-8?B?L21ncDNENnh0OTZNM2RwTnphbFRRVjBETXE3QWgyT09ob1l0OCtOMlhzQkFW?=
 =?utf-8?B?RDVXV05MUDVZdi8wTUE3N0U4NU04bHRxSi9TdmdFWFEvUUYxOHZoY1JtaVF4?=
 =?utf-8?B?cG5ZZjVIeHZieTVxRXlUSTUwWXdWWlVjTklodS9ldDV6TExndmp6TVJFM2Rs?=
 =?utf-8?B?Y2FpOGZzclJZbmx2UW0xL2I1dFdiYSsxS2JlQm1ObTRZUzR6TlBUdzRUZHJY?=
 =?utf-8?B?Mm5QWTlzRWE4cnhld2FHZmM1anNXNzkyRFF6MzR2QTBSSjdIaXFyRWhPYmha?=
 =?utf-8?B?Z1JocXZ0NlYxRUlFT1Z5dythM3RBd1hOakxCeEVOTGRlNVB4SFVaSU1RY2Vz?=
 =?utf-8?Q?cAYktSRBhBQ5mLlw94KUlDi5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c15c88-b1d1-4336-848b-08dc6294cf8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 06:24:06.0545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsUUEcwGTC5grd9fy5rKo2YLQOeyKqoTnjIJ2BMkCarDZ2xXNcIcNB3bF+sNiQug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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



On 4/22/2024 11:23 AM, Le Ma wrote:
> To adapt to different gc versions in gfx_v9_4_3.c file.
> 
> Change-Id: Ib4465aade0dcbbcc43318c6dc865f813c5411097
> Signed-off-by: Le Ma <le.ma@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 835004187a58..ec4d3fa87e4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -431,16 +431,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  
>  static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
>  {
> -	const char *chip_name;
> +	char ucode_prefix[30];
>  	int r;
>  
> -	chip_name = "gc_9_4_3";
> +	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
>  
> -	r = gfx_v9_4_3_init_rlc_microcode(adev, chip_name);
> +	r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
>  	if (r)
>  		return r;
>  
> -	r = gfx_v9_4_3_init_cp_compute_microcode(adev, chip_name);
> +	r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
>  	if (r)
>  		return r;
>  

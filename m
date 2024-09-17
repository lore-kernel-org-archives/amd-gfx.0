Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA8C35FEB
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9673C10E425;
	Tue, 17 Sep 2024 07:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3daSNYp8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6492510E425
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 07:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkIEiIZ5xKIoe+ccrzgI8vOo/p0j4ysfGAuz0ERLB/RTpkTxdszTVqQ/YNF3/iQ0v3hZK6fZyCyJvTgGnhKf/G6mtE4jrf3tcG9OfL+t3oiKd3saORDGXIXwxREt2nWHd7VbKMH0sqNHjTvA9kPhHZfgVdLgYRUvD1jWAU3mI1CRVsWC3zwCX30T53nRbf757DVh6thgc2U2bPljpQnxdMBXJLvoWrlWkwVEf+VzYOz4tNMjl+vWXrscxQkorpYNM9PGAwEFuAPZznnsW4H2Eo/5SKTTK6ZUoZNB4tAnpr7hepOZZQhs6/0VuH45N7+53lpezLln077hd7Zef+iJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6TI05hfGa0Za6nGa76En0+h6M2EhvN3wgeSz8ayST4=;
 b=NfjBpdPyi5O17snMJshS9waMPqNZg4jdHCGeKz0FCtIx5hCqBrv1Jp8Sd86vjqNfivqxZBv4NolrAFOWGvh0ZIfpBddtXGKhA8+B+7RzzgMKLNs9xfvTK1mBO5CGcYZA0odxTmQON4fH9zfXGpBJcULhy2AR+D/abK9sddHJFBdnJMsvu2HigsWFsOw19HASOnQQ4dL7krJmFkKHCtlnX26cu7/zCf9Sxw+UKXLVdF8cTMLUvCARVI3nxAHq7+wJ0E0oc71//YLOinGPGta92+Asq8rqumSWvjwcR2UutU/vULV0cEAYqKmmx1RBkxC/tWjHbjckpfq3yJTiKeAGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6TI05hfGa0Za6nGa76En0+h6M2EhvN3wgeSz8ayST4=;
 b=3daSNYp8aAxKSKnLqmdd5yx/oew28j2DsQyWwzehje9bmoFKF8ltZM9qSF2996Chxg/DhhX+HAWIhWYFU31hQbhgaTFbM9OmaqCkwonmSPUTNJxybTDaTOAc+4ERMVU4aPeWXD0Dvin852GyBbkiO1QWOZKYeebG7TGyzjQsSdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Tue, 17 Sep 2024 07:32:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 07:32:01 +0000
Message-ID: <64f0c15d-1033-40c3-aaf6-b969eeca425e@amd.com>
Date: Tue, 17 Sep 2024 13:01:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/bios: split vbios fetching between APU and dGPU
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240916200201.1874797-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240916200201.1874797-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea48c8-5b88-433f-b9bf-08dcd6ead1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1hOVWtrSHpkM01lcThuUlgrY2YvTVViVGJMeFFxWUZkOW9nYkdYZVdpRFg0?=
 =?utf-8?B?bTlzT0NOVGhYNXp5RjcwTWtuYXRreUxFNFBDRnNiajhQWDYvV09Gc2RsNmxh?=
 =?utf-8?B?YXJNNGM1RTI5dldVc1c0K3FlTFNuN295K2VmOFladjc0aHNoUi96VlhtOWFL?=
 =?utf-8?B?ZktBZ1JuM3JoalpRTU5yeEtNQnVmSTZqczNvZGY2MDhFTm5nbmpRRWtCSkRU?=
 =?utf-8?B?eVU0S09sVkxGYm5ZdjVkemUvWlcwdXdQczh1TmtUdDFDeDRjeU1FYU9pdk14?=
 =?utf-8?B?QVZOaUNPcWxoUmZoTlQxTng4cjg3WDFkNy9EVnNjeXRRcTZPclJrNzJZSngy?=
 =?utf-8?B?UjQ3d25hZDdkRkpNUHVyQlJ0M0RrLzJudk1SeGNkWWZJb1huL0t0cVpGTW9H?=
 =?utf-8?B?TFhHcElIZitsSkZwcmFXcTJoYktsbGdiVVRJTkh6L1p0Mzg3RDJFdTRndkpE?=
 =?utf-8?B?TlFGejUxRGdJeUR5MUlUOFBpT0t6WHlnc29DSzlpazNFK2hXZkNlbklXRFdO?=
 =?utf-8?B?MW5sUXhyREhRb3hLWFhMVVd6Q3ZCNmNRazRuREtadkR4M0JvOTlSbnRmaURH?=
 =?utf-8?B?bnY4Vi9aSkhXQ25xRUgwWUprUlQ3UVRxL2llMUpuNGNaazJWb0M1TEFGUU1D?=
 =?utf-8?B?ZkFpbi82SFBOTmhjd0FCYmRsdFVSZWRyYU5FbFVqVXhDeXpWbFBjYnVZanpG?=
 =?utf-8?B?SXRuOHJhY2Fuem50WEJFVHFvRnpIRlJ3YXBERmNZWEV3aVdNRVpCbDMweVd5?=
 =?utf-8?B?T1RlV1R4NHBzcXR1MXZWZTI1cXBMWmlJUU1YOUd5UzE3aW9hTFBYMkltV3hF?=
 =?utf-8?B?S0lmdUxYaUJpbERFQmkwdE5sYVUvOGVCNnpLWmN1SEZYVVVPaE5LdWlNMURT?=
 =?utf-8?B?R3gvZ0tJMUkweTVCNkIrSUhFYnlZWDJJWTVxS2JwYjhxVm96VW5NSXNYQnpG?=
 =?utf-8?B?WndPTDhkU2I1SnYzRVB4UmlFVGdBSC9pNE5WUmgyU0wzb2dtMDA3dGVNLy9Z?=
 =?utf-8?B?S3JvR2w1cGtqd3hKRmtRV2Q4N08yM1UxTGpZOHRpK1p4NTBMSXNiam92MmZx?=
 =?utf-8?B?cXkrYm9DRWpveHFQeHI3N09kVGhKb2NVbnBXVXExM0FUVFRkZkxrK2EvMVBB?=
 =?utf-8?B?T1JIVDcxY0NWVmgxU29VTE03V2dhSEFaWG5ReWJVdE14MWdlRUFROTR3ZTZu?=
 =?utf-8?B?dktjM1l0T1FnM0xrTmZVQ2tUWWx2b1lUTngxaHBLMC9kTmhnVWlXd29oZUVp?=
 =?utf-8?B?UXlwK2ZSeTc3LzBxdjlxQUFReWFtelUwS0JWR2wvL3FQQy85REQ2ZENuYXBJ?=
 =?utf-8?B?VWRQTlpFQmhzT2NjT01PZy9lRnNvT0RmTldxMnM4SnlSc0F5Z0VaeTl6L2s5?=
 =?utf-8?B?ZWx3VjB1am5RaDlyZW52MmQrU29tLy9haUhlaEVnWDEwM29NMGJtYVI4ZUxI?=
 =?utf-8?B?STdZTGU0aFNrQ2w0ZmhqemtHWEd1YjAzaHgxNGROWFVMQUVtNE5xb2dCSVhk?=
 =?utf-8?B?UmIvakJwSTlKR0VyanFsb1RkYU95TWk5N0hYRTEvSk9kOGhvalUza1ZCRXJq?=
 =?utf-8?B?SVhiQTQ3UU1VTUxadzBHejIzQ1VTK2xpaXZOMDN4Vy9JNXBMRmJMQmltWDVQ?=
 =?utf-8?B?djBXT0huODNmT2NVUDk4OVdBUnlUUUp2L3BOR2RVcllzK3NMZ1Q3UnlOaUVT?=
 =?utf-8?B?cXFmeVhQMDNnb2g0dDk4M1ord3pRSkdlMlZYZWtFbHNIN2YrbUQvNGxLNTFJ?=
 =?utf-8?B?NG9WZWpZM2I0TWhMT1luZjBZdnZPcitZMk9Jb1UrRU53djB3SDdpY2VyYTFC?=
 =?utf-8?B?UE5lbGxoU1hYNlZyQXJiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFGMVIvdUpLbUFDUUdEcE1wSUQraThTMGFGbm1YZlI5QU5ReDAvZ21Sdmhr?=
 =?utf-8?B?a1ZoaXpUbkpJYjBndjMwamgvMHhpYmlLcytUdTZpRndTUXlXUC9WVS9yUHM2?=
 =?utf-8?B?RWlTNzJoelBxTGdPWDRhbmVhb1h2QndJMU5iYmloWmhHa0Z4YXlJMXVlOUFp?=
 =?utf-8?B?VXIrdDBMbnZ5azlLY0JBZTZZc1VxcjU4R0ZkRnlGNFlrWVVTd0dZcVlGYkZr?=
 =?utf-8?B?ZTBqOE8vK0NqUVV2TmJWZlVZWkFvMmpudjkzQnJzSTFpKzFYZFNGUSt0VTli?=
 =?utf-8?B?NndjK1ljQ1QrMUJLS1dSZ1FzcUdLV3lWc3JMK2FUMVZDSHZCYlFwRUpGVEJS?=
 =?utf-8?B?cVpYcUJpSnRodlF1MzV6RjQ1Skc5aXpGaE02M0hxbEtUN1QwejFRMmZHYUNz?=
 =?utf-8?B?RnpSOGVJOXJJMkgxRlJ2UDZsRHVqSjY2dWVDMWZ2dVNOTnpXWmVpWUsxZXRD?=
 =?utf-8?B?NTBPMnM0Y3BtdjZTdE5XQlUvc1FRMEwvSW9WZWNURUI4a3dkZXFYTTNqT1Jh?=
 =?utf-8?B?dzZMT0YyV1lxVDhDNXhscFpTVHpIckxUQ3U5NXp5amI0enhBYVRZUS9XMzk4?=
 =?utf-8?B?T2JDWDZNTTBwQjhMZkFEYkhDcHAvL0g4YnNwRk9rT0l1UGdlSkxsK0FJbzNh?=
 =?utf-8?B?azBQT3ErUHdNWHI4ZUNRaHkyaFpsV3ZNUVVsZ2g1WlRhSXVhOFhtOUlQdnRi?=
 =?utf-8?B?OHJXNjRhbko3UGpvaFd2aklFcVBGUjdlTnl5d2w5dWhEL3hKTjF2aUVlUjJI?=
 =?utf-8?B?SG5Hdy9CWW8zd0NUTGNKU3FuN1VFcHZLQ1lTWnkzOHFSY1E5Nk5seW9tRUVK?=
 =?utf-8?B?d3Vzcmk2bjNGQ3J2djNYL3VSZ1NpdldCWXI2RkZNTWUwenhYc1NhcTVZYVRP?=
 =?utf-8?B?SSszenVHWEJwTFJvU1lLeEE5eUZCTVQvS0puaTIvUXJUbzcwckkya3JSWDlB?=
 =?utf-8?B?VFVSTURYa2d6ci9Dd05kb0xHeHJMTXhKNjU5M1VwcDAxYlMwZEZkcUFwUEo0?=
 =?utf-8?B?b20xVTVwMzM3SGJKZEY2VURYU1lQN0MyWUhwVkMycEQ0MXgrM1BRTkVnNUxQ?=
 =?utf-8?B?MkVyMk1WRVd3U240ZE9HeVRlWDYxSmMrS0pqZUVSMVhjakNuZW1WRmRBWnRs?=
 =?utf-8?B?eTRQVEZIWDcvaEg1dnhDcGM4VnVNam9WMFR0bVg0NVQ5SmF2TmZDVXh6MEpz?=
 =?utf-8?B?MUhiVTAzTDFQV1UzYkFqeXprS1RUcGZvT2s1YmlZRXlzZW0zelU3VUs4aHVI?=
 =?utf-8?B?RHNLaXVLZ29kVk1ZVHcwK0VaNXBFSjAyRzZ6L1FTYWhKL290aTJnOTFBSDVF?=
 =?utf-8?B?YmkxbTY4VVhucmdOTmp0bjB5cHhTTVQxaTVQcW04MjhHYzFVeUNFUVhRSW04?=
 =?utf-8?B?N0t3T2U4Y1ZuRDBsMmltS1l6RCtyOFhiQW9WdzZCbkVFRllBWTJ6b2tvZXNC?=
 =?utf-8?B?ZGZoQjZ4Tmo2ZlkzNFRSbEtkVkwwY29lT3BGTzIxRGZEc25oZVE5SVhGRW1k?=
 =?utf-8?B?TVZLelFHczUycm9zdjVxUWtRc1J3SE1FQ2FPOUE3SWhjSmJRSk80MkY5aHRV?=
 =?utf-8?B?UFptUnFWUVpwTU10R29ZN3lZM2RTWEdadHdSaXU5QUNOZ3Vvd1dkMURzYm5J?=
 =?utf-8?B?QitKd09xSU9UZUJMSm1xS296YmlKcDIvTEdtWWlZMDlzeG9TQ0hWdVhKdHdY?=
 =?utf-8?B?ZnZYRFBEV055UGZId05rWHZmd05jRFVPR3pLK2xKbW9UeVVOREl3VHFWeEVP?=
 =?utf-8?B?TWpvbGUwK2tqQkpIREVXbUxUWjg1RTI3VzZNT29ESytFZGVTbFpQSk9NUHJJ?=
 =?utf-8?B?bXlKS3lmT2g5SG91emRjbHJDWE92WENWc3YwMEgzR1pRYW9Zd3cvRGVFSXRt?=
 =?utf-8?B?OFRzN2ZCYXliTjIrZUF4SmRENTcrdmZDOExrN1pFeXFSQjBpdzExOStBam9E?=
 =?utf-8?B?RGxycm5sNHFOT0tjRUFsbUM3c0NYcW5HdDI1MGtlNE93ZWVBZ1FQaFFFZGJF?=
 =?utf-8?B?bVU4ZEcwTlJqeE03c3U4RUNlZVlJTEFZZVM2ZzhFL0NFVlBFTFZnai9JWndU?=
 =?utf-8?B?b2V1dlk2UDYwVEhGNHRZWVNhNWNIQ3NtOTFaMkxSRW11Q2ZnUnFuT2JBbnV1?=
 =?utf-8?Q?dGZCDhroqK45xC5IYyl+k2V1o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea48c8-5b88-433f-b9bf-08dcd6ead1b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 07:32:01.3225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDQI42zdq8ksR7qUgoxzoWY1L9s9F9iseUAOZ5dw1WDij0uCrY2uGFBpQO0EGpAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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



On 9/17/2024 1:32 AM, Alex Deucher wrote:
> We need some different logic for dGPUs and the APU path
> can be simplified because there are some methods which
> are never used on APUs.  This also fixes a regression
> on some older APUs causing the the driver to fetch
> the unpatched ROM image rather than the patched image.
> 
> Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 47 +++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 42e64bce661e..e8f62d718167 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -414,7 +414,36 @@ static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>  }
>  #endif
>  

Now that they are separated couple of additional changes -

> -bool amdgpu_get_bios(struct amdgpu_device *adev)
> +static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_acpi_vfct_bios(adev)) {
> +		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
> +		goto success;
> +	}
> +
> +	if (igp_read_bios_from_vram(adev)) {
> +		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
> +		goto success;
> +	}
> +

This may no longer be needed for dGPU path.

> +	if (amdgpu_read_bios(adev)) {
> +		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
> +		goto success;
> +	}
> +
> +	if (amdgpu_read_platform_bios(adev)) {
> +		dev_info(adev->dev, "Fetched VBIOS from platform\n");
> +		goto success;
> +	}
> +
> +	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> +	return false;
> +
> +success:
> +	return true;
> +}
> +
> +static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_atrm_get_bios(adev)) {

Better remove this check from this -
	/* ATRM is for the discrete card only */
        if (adev->flags & AMD_IS_APU)
                return false;

Thanks,
Lijo

>  		dev_info(adev->dev, "Fetched VBIOS from ATRM\n");
> @@ -455,10 +484,24 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>  	return false;
>  
>  success:
> -	adev->is_atom_fw = adev->asic_type >= CHIP_VEGA10;
>  	return true;
>  }
>  
> +bool amdgpu_get_bios(struct amdgpu_device *adev)
> +{
> +	bool found;
> +
> +	if (adev->flags & AMD_IS_APU)
> +		found = amdgpu_get_bios_apu(adev);
> +	else
> +		found = amdgpu_get_bios_dgpu(adev);
> +
> +	if (found)
> +		adev->is_atom_fw = adev->asic_type >= CHIP_VEGA10;
> +
> +	return found;
> +}
> +
>  /* helper function for soc15 and onwards to read bios from rom */
>  bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
>  				     u8 *bios, u32 length_bytes)

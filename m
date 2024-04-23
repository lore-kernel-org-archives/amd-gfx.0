Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F04C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 22:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D863810EAE5;
	Tue, 23 Apr 2024 22:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DLB7cKk1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE9F10EAE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 22:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB9hrYq+fSwxbUG+ZR13MHYfTO1gUazWnbh05PpD3Flh8UkniEy6T9ZfeN9fboVKo0zNbjXHx9aZzGEDAkYIlLMhNDTHo4Sg/QJw+L5WTYaPlq+XLXY/RltgPPqgMoFjnP+77bQ+HD+sSTZYYfyCnxBG8YfdOPN5RkZDPI6Riy61Z9HL0fi+SY7Jby7+DGNlwON0x6vM4XU2tQEai2ssaFWd9XcGXzayLapu3HKWO0sFkxIaRKie1yroWNNCmGATtTsf1df2Ciz16GF0GkMQnwy7GkZg7OlnnbX8nr5hks1+sOTG9yQNpPqgsvcLp68m6QbZHcmL5Ef0jSeWf7yL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLmkR5vNDJoFM0bZjspXV0v3TA7pBVROLNzr7SuaL6o=;
 b=FQYVusA4UbSNOANzL1PCDaigJdbh9Vckh7qz0g8Ab4xPoYIHCsgeY36UfZ4AMtDViWq/EyBtRdJPvIlsH5G47chEIxuH5nkErsPO7+/jxAjmcPhHxsE3/kogiCGKaN/f32Rim6Kmtv3rHJwVeNBC1YWhAj7q9cnxi/HXYpJ4t9BcL31052gWsg7DRvu6s8ORqHcW1ok8CNPcWAARYbihKmJKEb+dnOUcncZpj204Liew61uVy7N0FySk98ltMFWxQiTg30+N/aNKkYWkkOd8fr6zQ70NUp/BHyCAf91Sx3f7+WJW66YADbpjddRi7LLmA2TfMNMlPzKMuE3etn6I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLmkR5vNDJoFM0bZjspXV0v3TA7pBVROLNzr7SuaL6o=;
 b=DLB7cKk1JvE+gO6Jd6Fh20g5TfCXVXtbbBrHjYO9nuOTG3Xks1VSUgwHFPsjAcVPrigM2vnCa+MjHXbAfbIwCBJvDRT3OaNrChQCee+QHq/WvXuRs1uruuLN/ffL6zNa3QQCsCxrqYITMaibEM+b7MQ116Z9E1aYREz6wwfuTTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 22:15:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 22:15:15 +0000
Message-ID: <21046a73-459f-4dc0-90b3-adef3ef6319b@amd.com>
Date: Tue, 23 Apr 2024 18:15:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] drm/amdkfd: Evict BO itself for contiguous
 allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-5-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240423152900.533-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: d609d699-d15f-4487-860e-08dc63e2da59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzlIbTh3RlRFQlYvOUc2RFBZMnd0bE1jSXJ1NWcxam5QRHBYRndRYWI2Ujhq?=
 =?utf-8?B?V2hVMHh3ZW5TZWV5QVdQMlVvK2thL2d2WHFXa0pIc3BURSs4dEFKcThnSHR6?=
 =?utf-8?B?VmJUbUdtT0hMaEJVTHVjYzBZNFpzRDlNUmd1SllrbVhWc25rUkVMTXZLZlpB?=
 =?utf-8?B?eUNVTGVSeGVNbUZYVFpNOXM1SHBRWlUxZWptdXcrMjBjbmxQMWFOdHJWcDZI?=
 =?utf-8?B?WUtMMU1MbnpCRHJxQ0hjcW9sbzdSYUVpT2J4bGtjSW9VT2xYb2tiUWdYbHh0?=
 =?utf-8?B?d3Qrb0Npc1FDWnczN2FCeG5VT0xzak9nQjJsbGFTUE9GbVhpK1lTVnJjejVl?=
 =?utf-8?B?Mzk4N0ZRVTZ1Wmh0RU9zNm5oUkJ2c2JPcE90b0U3bFpBUFhwNWNBRGh3VUZW?=
 =?utf-8?B?RWVBaS82VDF0c0dKckpJc2pXTXJhaG85N054VEh3SFFROWk5RDVYbVVra0FX?=
 =?utf-8?B?cXJCQ3EwVHZzSG1FVFlkN0VpdUcxa2poR3RJMTlqRzhkTUtxR0J3Rnh6T1hM?=
 =?utf-8?B?Nzc1MGl5MWM0Uklzek5Hc1J0Q0Z2MUMxVFZreDloc3BtU3ROQVdDcFlWV3po?=
 =?utf-8?B?ZnNqYUNPMHpDeGk4a285YTRBaTZuZ21GdEZ5TkQ2Q2NjekJCZlpzRFpqT29h?=
 =?utf-8?B?N1l6a0NBYmpSVDhWUFBiQ1BWREc5NWw5UEFxQUlUaGdyTUFpb3BNOUJKTWw4?=
 =?utf-8?B?Nnl4OXgxRUhDNVN4WXNsdUlDa2swak5OS0hXTU95dEVnM3VWUEI0aVRBWXNa?=
 =?utf-8?B?M1BJUTdFRUFJbXlmMnBKYkwxaDRHREVWZzZvN1hiREJObDUxUUJONGVHU05U?=
 =?utf-8?B?RGZCT0FobEJUaFNlSCtJSVFUSnhYME4yNE9ld2U0SUJyb3pPMzVFZXZPMHNn?=
 =?utf-8?B?cjlURTJYRGVtcGtCWVR1Q2ZpQWdpZmtUbmdBSzVBV3ZiVXREODNOR2JXbkQ0?=
 =?utf-8?B?U3pWbDV4YVdUUVBsK1ZXQktHcnVSYTE1SzRoZjZzS1o5YVJZVktoWlZNcjhx?=
 =?utf-8?B?Yms4Kzg3blM5bUpHTEhkM2JPUDQ1MzYvVUlsZEJlMk9CTlVuUzFRa0xXNjVR?=
 =?utf-8?B?M2dYL1dYeWJRcFhNVDVyTy9XT2hSbmF6OGc0WXliM2k1dHBrUTE1MFo1L0dG?=
 =?utf-8?B?RnJLazRlczhFTXVOMWdFYlNHT3VXODBZYThhenRhbXZJb0t0S05tUnhDRHRV?=
 =?utf-8?B?YW5ndWh3ZXgwdlZUN0ZuellacnNPdjkwVG00YjM5ZHNSQ29qN0V1VVNHYkVV?=
 =?utf-8?B?ZnNjaFFFd2FUSHFrOGovalBaSnVRMHo0RnlFNEo1YzVTSjlZbkUzUFdQMWdP?=
 =?utf-8?B?RUZxajZkUWZra2VFMkpmQVdWMkhqeWtHTXdtMFRPK1VVZDFobWdXUUo1Ritu?=
 =?utf-8?B?bTlwc0VQNHF6dTRURU4xUVA2ZFpXOW9iMmF2TzRZRHd4dVdJVlhaeS9jVEtN?=
 =?utf-8?B?VHdXTnMra0lPVnJSOTNxdjdRdFMxNGQvaVN2S2pwanFSck1yMXdkdkhhajJ4?=
 =?utf-8?B?RVpnNE4yOWd4SmZyamdnRm5hR3lEZXk5cGtsMm1ZUUwwelFiRGowclEvbjRa?=
 =?utf-8?B?dWhTU3ZPSS9GaXdUbmgveXF4QlRKUXBFbkQ4Wkt1aG43Rkw3OEFpR2ZuVnZT?=
 =?utf-8?B?NlRUYlpkVXpIelZVK01HcDFzTmZqN0sxaTYvc1ZzcGF5ajY2RE1zQkFRM21u?=
 =?utf-8?B?a0pnN1FrWnkrcjVCK3ArT0ZHRlJEQnlBZ01uYnNVTVhpYzk2cURtKzVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lRalU3eW1VMWJZdjY5LzJCRkl6QmVyai9CVG5GdEpNSlhvdEJJMnE4V0Fi?=
 =?utf-8?B?bGlIQXFIU3NXTTFIcS9EUWh3YUdlS3Nma2llVCtFZ3ZlVDUrYWhMbFErdnVi?=
 =?utf-8?B?THVwMmI4NEUrMTlGZ0VrY1RlMEhBQnNOQVQwaDg0V1lFZUtGY1ZpOGpSTDB5?=
 =?utf-8?B?WUNtTUo2UUdINUlOQTJjbFBEZzF2WlJMQVp1ODJoOWNhT2M5NHlGbVVIcnpo?=
 =?utf-8?B?MzRmRTZvS0lUVkYzRWRwQUkyeGNIK2FBdWxKT0M3dWVCMkV0Wk10aUZzY0Y0?=
 =?utf-8?B?b0FyTkJPcW9TcXdMaC9GMy9ZdjRGMG5BcFZBdXVnMTE0MkhEbDQ3b1ZYOVlw?=
 =?utf-8?B?UWllSURxeGNTT1hkUWNBZmJ4TC9uK0tNMU9xbGVZNDVyZitQM3JvR1Y3WWtQ?=
 =?utf-8?B?dXIwa1Q3YXI2cThrRS9yeTl2UWVoSFFneFlRZW1BbHdiZFZRUmE1OTkrd1dR?=
 =?utf-8?B?dHZVTEFOOGVYQWIvSHRqYzVOSkxPUlpFSWNKdEh1T0p0N3lRTWtXOWliRTd6?=
 =?utf-8?B?OHRaL1EwSzFrUEJobCsrcEF4ODBnbmZ0NG8vN0hUeTBjV084ZVp5KzByaTdF?=
 =?utf-8?B?cVorbW1sVVZqd0tiSnQ2bjhxZ3F4NHR4YnkvWXk3czM0T3Vsb05BbkU1ZTRV?=
 =?utf-8?B?WDF0UlFqa1lYTFpzMDF6L0tkaTJYK1NoZ25mMjBBRnloS2ZrR0pkVmxhZzVV?=
 =?utf-8?B?RnZlbFlza041dnlZWjFwMWZENWQ3aVpuRVJ4NGh1ZGJJTzR4RGRMK1NyRDZK?=
 =?utf-8?B?TnAvNlFYUW9MbUV1WjVvWXN6dXpPMGZQRnE5NG5RS0R5ZDRpOVA5MUpmVU9V?=
 =?utf-8?B?UzdSQUgwRldsT2c1UXJWWXVxOFpOYW1acSs4eWZPLzk1eUV3dE1mK2dmczhO?=
 =?utf-8?B?NlQxa0ZncCtOOTI1RnY3K0lCZUorelJCcTk1bG16c1BVVHZzaUlOTGdtbE1J?=
 =?utf-8?B?Y3Y0RG55bklvU0NVdXk5WmRFZG1ZemxvVlUyZnhLdHN1dlJBMzdBSUdpUmNM?=
 =?utf-8?B?VStKMTVJZnEra043MXdpVDNtRUFpV2o4bHpQUG8yMzlHZy9uVTBVMnBXYTY3?=
 =?utf-8?B?UkVyVE8zWnNXZjEwOFpYK2VaUUhpRURWeERJODFTU0cwVUIyRjlnNU00ME5r?=
 =?utf-8?B?ZkJMZ2V3cmZLZnc0NDR5WTRuWFd3ckFFbzcwVXpMd0pWT0dtbU9qUVVCYndY?=
 =?utf-8?B?UmdvSUtGTnVBb0ZPMnM3OStLazZBbjEySjZIUzRBZ3JLMFJWdmc1Rk12V2pr?=
 =?utf-8?B?WkVEVU0rNk94NVZxaUl1TTU1aVdLSzVsS2d2bDA3OFZGZW1tbTJJTjg4UjZC?=
 =?utf-8?B?aW45Y1hLNWxLUG85WW9memZiMjZKckltWE1pSGlyMVRkSEtrN3JxQzlRZTFm?=
 =?utf-8?B?ODNPc3lLS2l6VFZxRW9mNGNCQTdreWRlVlYzcjFYT0srR2xwVFNoUWtYb2Vh?=
 =?utf-8?B?MTJ0SXVvQlhKcHY0Z1JOemYzTllRRFNpbjlweWI1K2E3aGZ3cHpaVjdoNDRp?=
 =?utf-8?B?a3Y1OTFEenJiQ1l6K3FxbUJVVlB5UVBtM0dFaWtFalVBZWNwcEE4M3hKV3lT?=
 =?utf-8?B?M0k3ckxjcVlpZ3RIbXQrUmJkeE4vUlhZeHdpa2srOWh2emszaDFqYzFxMkFV?=
 =?utf-8?B?aVd4bDlnZFJ1K2k4THFIS3hIR2tiTnBqeHIvVllmRGNmUkNQYU52ZlJnTDZX?=
 =?utf-8?B?Q2NRVGpzdXdvTHlmVUt6VWhZemJqdjIxTW9FcW1UUHdZOUFuRVRZL0QrUXVx?=
 =?utf-8?B?SEt6Ym9rUm5nYTAxMWlPWGo1UDFPM2hXV3NIVlpOY0hjaDkzUG94QmpHdUhY?=
 =?utf-8?B?bS9lR2lsTjB2VWlDQjE1alB5WitXYkNFU1gwRXVsTWRzekNEUi9WNVIwYkNx?=
 =?utf-8?B?b043S1V4disyOWxkOVNXalZ5VGpDUldVWkljOG9ack9mMnBjZkxjYmlsNnJW?=
 =?utf-8?B?ZUNHaU1MK1NvSlpDMWVEYlc5a3ZOOHdlVmt3UGY4MlN2aGNOYTgzTWNxYzRO?=
 =?utf-8?B?UnRVdXVoZEVTdm9USmJqNThPQjVxUyt0aDJKd1JrT1Zrek1KODZKWlJjYnoy?=
 =?utf-8?B?cU1obThBTlBrU2F1Zkg2Z2RqaXQ5L1hRMDQ3dDBYeVB2eGpvNmljR21SOW00?=
 =?utf-8?Q?i1uqMz8qNXBtcZOhmFaqs5DP+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d609d699-d15f-4487-860e-08dc63e2da59
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:15:15.8264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YV9Ky+V/ouRnCVUlpe7HeNkYmxofegDTmkLUvQa9sBeSd6HYQJlg7pi+DH+WDv9VVUwC+TkAGskU7xlKN7camA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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

On 2024-04-23 11:28, Philip Yang wrote:
> If the BO pages pinned for RDMA is not contiguous on VRAM, evict it to
> system memory first to free the VRAM space, then allocate contiguous
> VRAM space, and then move it from system memory back to VRAM.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ef9154043757..5d118e5580ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1470,13 +1470,27 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
>   	if (unlikely(ret))
>   		return ret;
>   
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
> +		/*
> +		 * If bo is not contiguous on VRAM, move to system memory first to ensure
> +		 * we can get contiguous VRAM space after evicting other BOs.
> +		 */
> +		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
> +			ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);

amdgpu_amdkfd_bo_validate is meant for use in kernel threads. It always 
runs uninterruptible. I believe pin_bo runs in the context of ioctls 
from user mode. So it should be interruptible.

Regards,
   Felix


> +			if (unlikely(ret)) {
> +				pr_debug("validate bo 0x%p to GTT failed %d\n", &bo->tbo, ret);
> +				goto out;
> +			}
> +		}
> +	}
> +
>   	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
>   	if (ret)
>   		pr_err("Error in Pinning BO to domain: %d\n", domain);
>   
>   	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +out:
>   	amdgpu_bo_unreserve(bo);
> -
>   	return ret;
>   }
>   

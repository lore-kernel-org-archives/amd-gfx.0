Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01591C77B78
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 11:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8753F10E191;
	Fri, 14 Apr 2023 11:27:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE6B10E191
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 11:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn30zpx761kD5in7PxgS+4Te6Xsw5w72YNrAETDa97lfzGwrJ0I3gCtkEQCRfZ82hBxL8IYkUCnhDEUoqx3aBucZA6lHWPm9OL87yXmki/VwMS2UKs30qzGC7u4Sn+vzI2Y9CnOvM8VzUYheZwjiHndISoJRk71EYi1nD6zzeTnLqInI1rqvEvNac7oAJRTHg8bf0QYlFxjKURKG6GAhkw205Fhv/OB6fyXMxhYWrZxfnuzR7dAhElv8SGlK1H6emCkHRrlLg8jI5pmirNWDxAt5rE+acJbmZ8ZF+TvUdZtcdl62xJVAxUDvH4n9sE0Obz4zs3I5BxyHs6GY8i7PVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoZPC8xGXVt69iMNTZIRQg3kSx+1Mez41yYh9HcdKo0=;
 b=JYpr6KoZ7sqzQv+VVSlL0IVehlsanzrLD2FX/jqVNDcH9wOhH580USBMyZcb/Dw9n6VUj8O3DOLF7jHuExtzB6ysR6+HY2OwrdJGGAwSlqB9HTY+8Y86oC4EcZ2amoblt4fMMFxYi4bK5fAXddyGEDtWOan7nzFfZOvSrIbb8uHao1rOPAfO+ZX79VV6q6Fiy7BASkGecHOPIhxBxyPVAWrGmOlkJ8n1NMRki0D+rWyYV3w4lhBMc3TgveW0n1IcJbt+sY2i4BQgi0ZiRYWhxhqHNFLo6qis2yJDI4FY6A6RBj0BqjPFhWSCMC5jXGdk91qu8r+qXB7f/5VmVLeSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoZPC8xGXVt69iMNTZIRQg3kSx+1Mez41yYh9HcdKo0=;
 b=CBUIRyR9RaDuf33m4HOOJoowACst9qBY0yNOLW+YRhFJ20JEUzonkK9aF5ILsdH+B9yQXcXI1swI+o84UD0Nspmwj3s2Hg2CT1NKy1oZngN8nMeL7TOol3DAeA5IvpLQ6wPnSTzIdrNBVsSR9a74o7jM82HouNdXpua/nXxulyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 11:27:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 11:27:45 +0000
Message-ID: <f002be81-135d-c3c0-8559-9e8478d3e0b4@amd.com>
Date: Fri, 14 Apr 2023 13:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/3] drm/amdgpu: Add a max ibs per submission limit.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
 <20230413142253.414333-2-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230413142253.414333-2-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 4271ec1e-9d03-4d40-3fc0-08db3cdb4479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vi+mGm0Fo39tTLprvniJoTDnXU6ahYvHIcWNckwOtRpKaR4KQVrYsyPX/ggStr5WoaUpFfcKChSWSGChynNk4ArZYs+fV3l9AG7BEV/z3JoYHaUrvnKLK3q1zAKlv4Dsb3pp3LL5nK8eUhY6IRkUaACEUKGEGa7VnHqstY4Svy7rb0jRPwnxP97JPrsBexf65ufCr/6TysgbMRUEF/dr6uZCmKnlOb69WKPDhICRNzKb6gxYCl24bEDVXr1pYgqJ1OiRS2XmJM2FuOaf6ehlby6m4/5Otp5OaKSwofRUbIfbwEfVW/r15cTQ1rQhP2tWkycfiLsqGh9DW2Fr8v+HbRBUmX4wmObCK50aS/gezYXc9MHO676LYE8bPMKo8z1LxkWDAfXISdTW9PIo86TB68CAPLimuAGa4MfcfGFf/XIFivPJUj8a291gKldr4VvYGqimwbXfvLUxtSdKsIDD+XujhEw0NhUFBqem+1P5reLaG+TzAH2GAg3lQbcNN3v+9jD9Q19r55ZzScCvWokbunZzm9Gvvf8IcWet/Lhjmv7hu2EGQDFtFmAmHN3zY5hr/WyqOcBaC1xa2SNcYjezMUIDTcD3jQVgBGBP6Uc0njA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(31686004)(4326008)(6506007)(186003)(6512007)(316002)(8676002)(8936002)(2906002)(31696002)(36756003)(86362001)(5660300002)(478600001)(66574015)(83380400001)(41300700001)(2616005)(38100700002)(66946007)(66476007)(66556008)(6486002)(966005)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0tJeXF2YXQ4WW8yU282ZDhJaFArWFRCc3NmcWJQMGlsalh5c3pZSUR0NVRL?=
 =?utf-8?B?VmVvanpJMG5kRkE5bDRUc2piK016cEN1Zll3UlVTUVJkZ2JLU3ZETEQ0Y0xH?=
 =?utf-8?B?dmxjb3JZbFlYYldndjd5elp2dnh5YnNTci9xejBTRVFuNzJBVk1uNXZjcXJu?=
 =?utf-8?B?UjZONU96SXQ2MnZYU0o2OVM1R3dxdW0zb0FtQTM4K1pVWmlUanZqQkFGamtD?=
 =?utf-8?B?VTJzTU9tajlaNE5CZVRMWDR2emRwY0psSkdHWGVaOHM4elcvQU4vNWRVcmQr?=
 =?utf-8?B?Q1BibE1jYVNjNXB6a29nTmRJVDVlZ2FJZmxlM2gxenU0U2lEbDk2MkkrTDJm?=
 =?utf-8?B?NG9DMmdtSDZYclRGM3lTbzZlSWNOSG8vUU81ZFkrTTcrM1ZSWjI3SzBWNlBM?=
 =?utf-8?B?UGRBOGx4OEFZdHlmRURTWVoxU1RJK1diUnNucTJDMzVJeGJRMVhtRFcwZkJj?=
 =?utf-8?B?MUpnellhRVVoeDJlL1lOZVBaNSt0bWkyQ0h0RXluSVMvVzJuMGlHbHoyWjN4?=
 =?utf-8?B?OGkwWEJRN1NWRldiMzZoYkh5QzhSU3dHdERIVlJpbU9RbFBwWnZERnpuS1RE?=
 =?utf-8?B?b3dHNEtYVjFSQ2FNRVJTWUc4Y3p2SFpaQUJsL0JGVy9tMGFkM0E4T0kwTmI4?=
 =?utf-8?B?NnFDbW5yQ2xpYURNMzBIK3FxOXFoc1g5MHFKK2VvWC9GSkY1OHR6VVhZSnph?=
 =?utf-8?B?eFJlZDdmZDM2NmkxSlZ4S0JuOUFrRSthaFFWR0FpbmNGSEFFaGROUkNOY1hP?=
 =?utf-8?B?b0dadE1sbXZ1cVQyRnkrTC8rY1NIOFdza245ZEMvM0xXaGMxQUtmUzlsZnRl?=
 =?utf-8?B?ZTBwb3lZOS9QQ0Z4b2NBMDdVaWNqUDRxOU9DTGJnY1dZbEkzMDFibEM5NXZ5?=
 =?utf-8?B?dGJYL1hlblVNdjZEdHhvakFtQ1Q5T0lTVzU2UWJSUDVIeUQrVmpBUnBoNEd6?=
 =?utf-8?B?MzlEVTIrbElDYUh2SGRtdDVGZ1BCNWp4NXlKMjMvSHZRRDVBL09JSGNRVlhP?=
 =?utf-8?B?dmNsMzZycDJuRmU2NGhIdjNTa256MFJoQVIzYWJnYkp4R3IyNnY4cHRFR253?=
 =?utf-8?B?TlZuVGJ6cS9WbXJVaFhxQ2JVTitFZnpTZUNFY21KclU0cFJhODBXNFpIRUdN?=
 =?utf-8?B?UWZsazZUZ0RtYThvYkhFZEVLbmpBajg5bEVxaDEzQ0RRYzMvT3dCZDFhWnBl?=
 =?utf-8?B?OFZ6MkNtN01xanFjeEhyYU51ZVd3RC9hY1pXaG1EZVhrUGVtT1EyY294c2NV?=
 =?utf-8?B?TzNTY1Z2VU9sa0NObkJzcklvSmNyUklVZFdwRndKdmhDU2QyZ0JmZERnMzAx?=
 =?utf-8?B?MlJWU3F4T3Q0TGVXZXM0NEdTeFR3OGdLODJLQXJGSVE5YmpOY0EvRW5kdHda?=
 =?utf-8?B?Y2JYM1A5RWcrTlBXV3hWUzR2T3gzNlpDYXd2SC91RFE1dm9QYW8rcURWYUVt?=
 =?utf-8?B?akhsckxtald6R3NmWlZZWG1hMm14UEJmWFhZdDZsWnU3YmpvVUIvREF5ZEZE?=
 =?utf-8?B?NGNOYklXS08wWlRuT2JHT0FEenV4Snc4bTZRSzcyakZDcFdVa2NiU0hBWC96?=
 =?utf-8?B?MXdqL0ZiWDdzZ01rMjdjODRyR2k3V2ppTzdoZ1VWR21FczYxQkNLQnZRT1FS?=
 =?utf-8?B?b2hTTzFRT29PTVVxNVlDNDZTa0xQcWdvVWhOenNqWHlwY1h4K3hRQkVVdUVa?=
 =?utf-8?B?WXJGKzhqVHArREphR2RkcFFqZElsNDNGdUk1M3lCbk41VjFmZHg1Um5yTGlq?=
 =?utf-8?B?ejIwVWoxRS8zS2xEWGcwUWtmK0V3S01BaHNCcER2aWNQemt4czRHV3kyZCs5?=
 =?utf-8?B?VlhRSzNOTVE2OUt5Vm1sdE05T0xZaGxWcE1KaEU1b21jNDZEVFAxUHVHZmpv?=
 =?utf-8?B?K3R4NjlLTWJmeGNMMVkvN0I4anlEMDFpUjRhcGQ1T1hrSW4xbnpSM3pFSEFV?=
 =?utf-8?B?YksycHdYYWhnb3J3eG03a1EwSjlVcWcrM25JUjd0SEVjbVNFbGpiQnpUVFVs?=
 =?utf-8?B?TExlOGZDaVhTUXZtRkNuOENVTmFpdEZYdmFnRUZ3VDRqSDd0YXZJTXpuN3Zn?=
 =?utf-8?B?d1VUMFI3N2hNSTVjYTdDSWZmcHhaSU8vRU04SXZFMnRLY04yNUpnaUlvSWMx?=
 =?utf-8?B?VFh6UHhuWTBTSGZaWEphSjA1U3RudW00VWhqNVhXSllIblhDeHdURzVrc1pJ?=
 =?utf-8?Q?9cxz39aFj0UdNNXRcJ3JrrXVbLzvLNzb34vDPAlcbQbd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4271ec1e-9d03-4d40-3fc0-08db3cdb4479
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 11:27:45.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmxGkFzzNGSLkLVKAof1SHdnSL5ohwGQABuS/UbNodXJWxl/Uvzwz8XE4bD6rCEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.23 um 16:22 schrieb Bas Nieuwenhuizen:
> And ensure each ring supports that many submissions. This makes
> sure that we don't get surprises after the submission has been
> scheduled where the ring allocation actually gets rejected.
>
> My calculations on the existing limits:
> COMPUTE v10: 128
> COMPUTE v11: 128
> COMPUTE v6: 157
> COMPUTE v7: 133
> COMPUTE v8: 130
> COMPUTE v9: 125
> GFX v10: 208
> GFX v11: 213
> GFX v6: 154 (doubling this in the previous patch)
> GFX v7: 226
> GFX v8: 213
> GFX v9: 208
> GFX v9 (SW): 208
> SDMA CIK: 87
> SDMA SI: 97
> SDMA v2.4: 74
> SDMA v3.0: 74
> SDMA v4.0: 72
> SDMA v5.0: 51
> SDMA v6.0: 52
> UVD ENC v6.0: 98
> UVD ENC v7.0: 92
> UVD v3.1: 124
> UVD v4.2: 124
> UVD v5.0: 83
> UVD v6.0  (VM): 55
> UVD v7.0: 51
> VCE v2.0: 126
> VCE v3.0 (VM): 98
> VCE v4.0: 93
> VCN DEC v1.0: 49
> VCN DEC v2.0: 51
> VCN DEC v3.0: 51
> VCN ENC v1.0: 58
> VCN ENC v2.0: 93
> VCN ENC v3.0: 93
> VCN ENC v4.0: 93
> VCN JPEG v1.0: 17
> VCN JPEG v2.0: 16
> VCN JPEG v2.5: 17
> VCN JPEG v3.0: 17
> VCN JPEG v4.0: 17
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   3 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 7af3041ccd0e..8362738974c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   	if (r < 0)
>   		return r;
>   
> +	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
> +		return -EINVAL;
> +
>   	++(num_ibs[r]);
>   	p->gang_leader_idx = r;
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..f676c236b657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -49,6 +49,26 @@
>    * them until the pointers are equal again.
>    */
>   
> +/**
> + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
> + *
> + * @type: ring type for which to return the limit.
> + */
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> +{
> +	switch (type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		/* Need to keep at least 192 on GFX7+ for old radv. */
> +		return 192;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		return 125;
> +	case AMDGPU_RING_TYPE_VCN_JPEG:
> +		return 16;
> +	default:
> +		return 49;
> +	}
> +}
> +
>   /**
>    * amdgpu_ring_alloc - allocate space on the ring buffer
>    *
> @@ -182,6 +202,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	int sched_hw_submission = amdgpu_sched_hw_submission;
>   	u32 *num_sched;
>   	u32 hw_ip;
> +	unsigned int max_ibs_dw;
>   
>   	/* Set the hw submission limit higher for KIQ because
>   	 * it's used for a number of gfx/compute tasks by both
> @@ -290,6 +311,14 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   		return r;
>   	}
>   
> +	max_ibs_dw = ring->funcs->emit_frame_size +
> +		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
> +	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> +
> +	if (WARN_ON(max_ibs_dw > max_dw)) {
> +		max_dw = max_ibs_dw;
> +	}
> +
>   	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
>   
>   	ring->buf_mask = (ring->ring_size / 4) - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..e6e672727529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -317,6 +317,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
>   #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>   
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>   void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
>   void amdgpu_ring_ib_end(struct amdgpu_ring *ring);


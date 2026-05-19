Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2DDCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C5A10E391;
	Tue, 19 May 2026 08:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndmH5hKs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D61B10E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/2uNSIWAtD61mL0b4CJT1wrl8fwB/vddmUJ9f9cPn0+VeO7nKl4RfA0cPtq9ky1Ncd2rbkCy0hAZHYtg1Gqoa+oDzIkFWFq3wrYqrvxc9iK9+7tcIciOJxoUEQ6eHHo0U4oLVZ1M4MK4vp/bI1X+5jyyIoPo52yHrBgWgYT2V8uZ8gyWCQcmN6iYOKLJzMMs0Qb/k6ZNl+X6BDAQI4mzv0N4z4E9Z972LtaMTGn3GLqgoJhUpyLSv4hSa/Mc5vH8vjHbtVkL+/l5BTznmcYQUM0d1YO1TF0zslrnbqOPvj3lxBGyavRVVpj81yd9JbCA9RSzqQkHwQEykl90TRD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPXPT7WJk6/FgMrJyRMHkNflkrScQY7kNohpxaNtZVk=;
 b=Rl3SmaLIsmivFQmZKwrRDf+3eLxHw+HHMaLX3UrkiBxpYUJmi7RHTh8ypv0Ajj3ENXDPg7v6DmScxLMubWI5rf5sdJAbDjqfiij+j+Xrei86qdLE/tjs0IPqlLchbwRJK5CQsswfGu9qDP9F0p9l3DATns3ffbrEiHbZ9ASCXaN0CePy2FroOJvjDCLyl/FJs8AWrLP+PZ7tbeXB/3+S4nadvGUJoJCr4rbv4hetMq3Td+kdjNe+MQLYLEm0P3ZIbH+zkypR5qc0cJi2K3/Wn9vJBuBdWAiIXQ6fIj5lqUbPwvqhSFOLYHFylqv+C2NWDOqEMvmHmPxblCaXd4VbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPXPT7WJk6/FgMrJyRMHkNflkrScQY7kNohpxaNtZVk=;
 b=ndmH5hKsuzlCPxAw5N6/e20JnKDjxrC923d/cBVAna18V2aV1L15pxcK8HW/vut34eGA8MV8RIdzXVwpoYw1/BRTeNaLdnnRscMq5V0P/otxjL6Aifm/m39UGkgRrsdulpFoXzBwisk+ktBXdgxyxj4hYG86XxE13T0r7RWuTjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 08:52:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:52:43 +0000
Message-ID: <46ea9877-7515-43c9-80f5-ada56f608351@amd.com>
Date: Tue, 19 May 2026 10:52:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Respect placement requirements in
 amdgpu_gtt_mgr functions
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519082204.60811-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: ed79ef0e-5973-49b1-1f68-08deb583fd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: 9RUV4hV2ySlI0O0pkJEPMLmuP7ALw6h2YpA93k6VbAX1OFcuUSRcV6JK6sIu/CP9D7i7A2GDPffGgqwJp2eVUGa30qTNvDFrA9114bf31iDT9ubPAUaC1buiSzpZPe2sdfv/muzQ/syLBhfLQYpGx4NMiobTxV0l091z2XAN3VhiKUU5JfvxxwQKXTuu9xh3TNSXgEA8X+gDHResoj/iLKtNqCyPAyiQjou9RjTi5VBp3dts9s7YLNDQTgrVA+QbMoRFcoZzJggF2dqV4ND6wkfoJXFo4SWPVV/cv6BEhI2wFhCVtFYpwBoWSo1Q+0bHLStf4MpfiXRrIXKav0i24PjwxC/vR1Kq/wWwVr/YL3AUhmL2gCT8QNaz6tcstM5EvneYHGzHsI8/YFx2HHQk7MD0W0P9RRvR/iq5WNitqZktZt86RdQY/e+dF82ZSUeHpJ0ukqvBDzDClK9WPS0XXJOb/trYY8XCUzcZi8aYnU9Vle+NaZC3ILfSdaVtzPoWjEOmWQYb7GI/a1WGdlClx8DS1apBzq6VVkhK33jjSWWosAkTo7PZYjmy9Y+5ePDXJcXOantNFfPVCFkTzK6Z/3n1LNcOznehs0rlvi95AwCGLnPRNP0lWAfrwtjiI7mqN5XbxAU4jcIywlQkiMsTjlWkaT7c48iE/uaF4u6NJyVHN67h8uMxwd1OqH0Mag6+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJxdkRRN1dMSnZGK01lVmpSVE1uNkx5My9VeS9jOWRoTnZRTk1nQmducXla?=
 =?utf-8?B?K0NMT3BaYnlFY2NmSWZvZzBYd0hGMVp1dGduVlN1RU15cENXM0xwRjVuMlpj?=
 =?utf-8?B?N2tRZENveEZGTnBlcTdlb3ZGOFV3ZmJJWEk4QnladWNLYlNTenM4SEpmM1hv?=
 =?utf-8?B?ZUhLalFCWHQwalQ5MUM0Y0VqT1dySFF1enlpa0pSU1JZRGtjKzMvcEhiV2Mr?=
 =?utf-8?B?UGpjMHBYUTVCb2E0aGNzeit0V2dTV1R0WmxVaWd0Zjc2MmRaenlzQXdTcllj?=
 =?utf-8?B?cHNFUzJiZytBM0lYZXpOaFhWVUNmNENoenU1MFI4RlBtU1R5OGszN1BGSUJY?=
 =?utf-8?B?RWh2UzBqOVVFQW1vYlpTWXpwYWdzeldMTnF5Sm5Wd3dpQmRQQTgxTVdzdkRR?=
 =?utf-8?B?RlcxTmhzNlRqNzFKdzR4ZUgzWlllYjN6MUNYcE1mTmxxQ2xFajI0dDhoOHBW?=
 =?utf-8?B?R2kzQWVBTU1CMEVOMGhDZkJSWXpYenVka3lOUzllL3FJUlNjUWE4cTYwY3hx?=
 =?utf-8?B?VGh5WVFOcllEY3k2cnh0c0FhcGsxSTQ5NGZPOEtoU1hsSURlNHZjTTRqNit3?=
 =?utf-8?B?T0RBWE9jSVhIQzgwMnlkSk8wdXBuZDVYN2lFNW9ocStBNmRwT01oTlNMNlQr?=
 =?utf-8?B?eEZRUlRZbSt0am1JeGU3TW92eitmazJqNEtITU56K0Vta1dMSXEzMmllM2lF?=
 =?utf-8?B?Q1RCMGl5alIzL01SRUxZQkM3QzlnNlNvaDRSM3o1eXdZa24yL0tKMENIVkpr?=
 =?utf-8?B?NWllNjBUeXM3b1RBVFpaWXVSS0VYaW5jZ3grdnhxVTRnKzV3TjdCd2ZqSS9z?=
 =?utf-8?B?L1FnTm04U2lybVNRbXdwb1U4T3JzUm1UV3hQMWN1N3BVUkZKQ1NsbFNSOHlZ?=
 =?utf-8?B?MW9uTE02SjJvSENBVFMwMzl6V0FiV2FnZ2ZiN2VwSGY3eWpZT0VtVDkrMkZ1?=
 =?utf-8?B?eUpadWRHZTZqVGcwSXpZVWovaUlCdm9BbGxmdHM0ZVhEYnlqWTgwZFBXY05y?=
 =?utf-8?B?YVVEc0ZEYW4vNEJ3NTJjWTJRVlhxSkRUTDFSRmt2QzRPZ1VLeDZ0YSthUG9W?=
 =?utf-8?B?Vm9ZYzROWCtiYzM5blVPZnhYWFdkMzB1OGFwSDI5NmVCN3FPSStkbGN2Z2Zm?=
 =?utf-8?B?cUovbmNYRk4zWENCUU41bFRXaTFvSjJwakdTaC84ek02dFlVa0s0NW5UVUIx?=
 =?utf-8?B?bE1zZis3eWthN2xFYjIwOXE2Z3pzMklEOUZRZ2NVd0VrcGJva3FhaURSSXBX?=
 =?utf-8?B?T3JCa203YlZ0L04xcld6a3kzN3dZRXQyV2grd2FlcCsvUGtJQXYwMEI5a3Iw?=
 =?utf-8?B?OFdHQmEzeHVhZE1ndmtST2UrOWRKUHFUby95MndBSEJIQS9BZ0xOblVrNS9q?=
 =?utf-8?B?SEJndmUrdExTOGRiQng0K2RhSCtoWUM3L3ZQbWtMK3FPSFRLVW56ekZON1dS?=
 =?utf-8?B?bUlkdkZhWXk5bklkSVh1NjV0c2Jpa2M0VUl1UkkxR2VUVEFxYXVkUW5WS2d3?=
 =?utf-8?B?b216WHVocit0Y1VmSjRsRXpzYm41NHdFSGZLbWJYQlB5Q3ZmS1huZnNsTVdl?=
 =?utf-8?B?Vk8wZDcrV1ZFbCtKS2tscGlRY05WbnUxdHBLeGxBL0JOSUNGZUhpTndjVDRq?=
 =?utf-8?B?MVZRWjB4L2Y2Z0RNRmFjRVF6RWkxYVMwR1dPaFBKVExCV1h4NHBkaHJXQ2hl?=
 =?utf-8?B?RXdJMWFHQVltWHhyUEpOTkJvU2JzVUo0cldyUWh3SGkwK09lOHdkTzdVbzFM?=
 =?utf-8?B?dnppOElEMUNpNEt1dkdVcllVcHpyQldBVXRTZ1dwODNGelgyQVcwZkR0cm9G?=
 =?utf-8?B?b0lSUFdIY1lrR2J6aWFERWp2bXpPOENYdEFPVVVtRzhreG51QXdZanBURGpy?=
 =?utf-8?B?L094SUVLUU8zZnZRdVJJcnNSY2NrTm1VbzlHMVVadmRnell0Q2VPc2lZWkUz?=
 =?utf-8?B?Qk1kUjRzVURSZ25sYWVXWGlRQmFCOGlRNEhxenUvK0gwaXAyaDJIUFc0WFR0?=
 =?utf-8?B?RTVwWjNIb3gzcHV4OGRZQ0F4UktsQ0JrTXlBR01EOHU2YVZBQlFVMDZXajdF?=
 =?utf-8?B?SFQzV1pBaWRoQkFjOFNSblN5ZGlacVdjWEN4Rno0YSs2WjVOSCsyOHo2TGJK?=
 =?utf-8?B?N0gwRWVZNjZpbityN2RyczRGYWgzZDBmY1VESTJnR3d6Z2FFYUhDS2Q3Z3Y2?=
 =?utf-8?B?VVM2ajNzOWpnVVBSTnZ2OVVqK1JWbitDUUNUNFFCWHV6N3FOckE0NkMvRm54?=
 =?utf-8?B?MkliZ1BHbzM2dVpxWHFQN1N5VVBTcXl0L0RTRWtLclFoL29mMzMrdElaeERH?=
 =?utf-8?Q?i+zBJQLHmkCjNhcDJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79ef0e-5973-49b1-1f68-08deb583fd4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:52:42.9940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKmtwxTZTpPRTBZ8iL1yURHC257WJp0WvOpiBMvcdx/qaUwtFec08pYNhcnmpP6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

On 5/19/26 10:22, Timur Kristóf wrote:
> When testing intersection and compatibility, respect
> the actual placement requirements. This is a pre-requisite
> for ensuring that UVD CS BOs do not cross 256M segments.
> 
> Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible functions")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 +++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 02f85802f579..19b6770a877d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -272,7 +272,20 @@ static bool amdgpu_gtt_mgr_intersects(struct ttm_resource_manager *man,
>  				      const struct ttm_place *place,
>  				      size_t size)
>  {
> -	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
> +	const u32 num_pages = PFN_UP(size);
> +
> +	if (!place->lpfn)
> +		return true;
> +
> +	if (!amdgpu_gtt_mgr_has_gart_addr(res))
> +		return false;
> +
> +	if (place->fpfn >= (node->start + num_pages) ||
> +	    (place->lpfn && place->lpfn <= node->start))
> +		return false;
> +
> +	return true;
>  }
>  
>  /**
> @@ -290,7 +303,20 @@ static bool amdgpu_gtt_mgr_compatible(struct ttm_resource_manager *man,
>  				      const struct ttm_place *place,
>  				      size_t size)
>  {
> -	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
> +	const struct drm_mm_node *const node = &to_ttm_range_mgr_node(res)->mm_nodes[0];
> +	const u32 num_pages = PFN_UP(size);
> +
> +	if (!place->lpfn)
> +		return true;
> +
> +	if (!amdgpu_gtt_mgr_has_gart_addr(res))
> +		return false;
> +
> +	if (node->start < place->fpfn ||
> +	    (place->lpfn && (node->start + num_pages) > place->lpfn))
> +		return false;
> +
> +	return true;
>  }
>  
>  /**


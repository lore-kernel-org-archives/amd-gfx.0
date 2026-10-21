Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB9606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=N5BrQjre
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D663710FDED;
	Wed, 21 Oct 2026 12:53:56 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D6F10FDED
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 12:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcASI1IfCxqOfOw/IgV+82qPidTKStIAVnsNflVpb61129Sv3Ljlt8why0c/X5CcvAZ+nXosSNX4X6NJFy87uVRHQixvuotYp/xwlfbjbZfIGcqzDK0j8VEh3EMgz7PiSP0kBH7VoPRNRVxnytrlcPlA6sn66BYfq7n8SHWtLWEJP3Ksahbd2epaaKb4wEl1sVS+jVeqcyPXUWAcywcnaIYjWti8Bp08WvSdoqMqxTESp3hcL5uN/+SN3sliGd7KU/0h4Z0XWpcddReeJYOUNQO7uCDQuTX4LefTQD/uPCwzSsHnLQVrSuX2s1AhKQq/XeRFU/FEzxC+iQVjz+ceVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAOM91UrJU4+JCjRtR0PDY3uIBiDXDd6G0j3BTnvBeA=;
 b=VE/Pbf07bDcumBfULuLrrXRaiM7r0ykAIT5ZvSmjkGN8Zcicg2QQesmzhyBTT6wixifmlsxXJAYBpkMMrqNrtMTRi32cxylwyQHiTEOl/2KfOHYhVNUer3UdLLVcUAfYhoyoX6/htoFSvJyIQ9CksGWlAPaRciAyZJg/j8hWPwu5OhbnnmkxvGg4YfJjVqZAJDsyJLyLeHNo0HtWIbaLafxbF6MudkpWiqQjYI2vnBcUWCy922StA4tIa1e4xzkmCtpoLOt198umVMA79oFvnEjjpCxQFTsmm1Nook+3Hs7Dk7A5GfTk8zX7/p0U0U/ZQmq49gqPrB1vcM5Ov70SGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAOM91UrJU4+JCjRtR0PDY3uIBiDXDd6G0j3BTnvBeA=;
 b=N5BrQjre17SRQ5GKHwGXXmanCZ5+LoExNPpRl5+MGnOt5oPmVSF+g8PG40PyByIWE7G6bHylQ6ewvw/5rwJY0FgUj325YvKOX/mHxAoVBksHEBrQ8fMOvHFd61TW882DTHi5Opji1ltXbxIsa2lJmrL8OBNOtRhW2jvAty/6fqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB080844.namprd12.prod.outlook.com (2603:10b6:303:2f7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:53:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:53:46 +0000
Message-ID: <6d050c49-4091-4cdf-b92e-9b3cdc0a87b9@amd.com>
Date: Wed, 21 Oct 2026 14:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] drm/amdgpu: keep the CS user fence BO in GTT
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
 <20261021051033.3287259-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021051033.3287259-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB080844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd442bf-97f2-4328-a72f-08df2f725825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TZ26WFds+glZMHZi+BBRSGhfWw8UOrOOkp7jE4KthlxS3U6wUlesnJX4tUPmQPImAJXfmlNGnXnNC0WrXji78hOqH3WsDhxidyqKA+PhRuSEBY0J5xYzqx5X0pdKaRZo0dodCsALceoItqv3LHVpBMVGatJr/OKqapE85FKEtVeeSomKaDdxNCzFhu7xY1WkQEZjo7KmzgcY/UjZKe8sFh7Ssin3IVDOsvyoSqg3188qohwlQJdn5sw9lWeFYmg/EfA7xn+1hGK1WlJDlIU4smpy3IPeK+PJddKLANjtzFRur4u7mbWopL9Q/CXmLjLEOtRXJpPuF3ntXj67ySvxADcqEPc8gcV6FQhL3gDXZu1s8ZvzL2MSbMN429ORMauHJdoPBxNkm/NzFfj14YoYivqUSuIDpVEuoFLjfd/s4BM3OwFTxqdy/jKBaq0KWvaMCAanTXYqz06BO9ONykI7K7tMw8FDtWLNJg7qZifbwlJvy0hrFiHOxI44ZWycoGQzGyRi1PGIbXo/JiWbS0r5oej3kUgZxKWo1gz3W0JkY9R3JQMRw+FSxA4UbfXK7dLM5WTiwnCQsXdRqnDvK71zWkW4WSpzfy1hglkhPchskzAGHaQtv+nl/uye2VHGs10azpCyPea1RC135UdVe3t4ouZMO75LWfvxVYeEosm1OJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhXZXFaMFY4TE11WDFuVW81SXgyWVZBdTZhSFBWSFpGYTRuWCs4YjNSS0tM?=
 =?utf-8?B?M0NhdkZBYU04azA2MUc3ZGUzWXNpcGdRSGtLTVlQNmFMSjRNQnEvUnNCWnMy?=
 =?utf-8?B?OTdJeVlETFVoOUM2MG5BaTgyVlR0NW1nVDJOSjFJSXFwN1Vjd2piNkxjVElT?=
 =?utf-8?B?N1lNcFhnUnE1WFA1Y252U0hrZHNQTFBYbU5JcUZoaUYwa0tPVmNaQmlYOXJa?=
 =?utf-8?B?Z2tyRlNMUjZuU0gxV2tqSGhrZWdaRXpCR1Fxb1krdm5Ca3NCa3FZbE83YmZO?=
 =?utf-8?B?UHJPSER5RVdiT2lmdUhCMzJmTXVqZWZIMkJhVlRlSXNBV1hJZVR0OGVRMUJh?=
 =?utf-8?B?QzBpdzJrbThDRDZjSUdjV3BhQkFyUGhoeE90eWNZdmQ4SmhVVG5OTXpKVGZK?=
 =?utf-8?B?ZlpDNFpZa1RQbzJ2MFQrR01rTVZKQWp0R1hncXFJcmc0aENDOEhDMHdpNzBy?=
 =?utf-8?B?V2pOcDljZWx5L0xVd3NubHI3cFFzdkJSS3FZUXBxZVJwZ1N6dWVwQXhRcUxW?=
 =?utf-8?B?TmVZWnhzYlZkdXFOd0hGeDlvaUd2bDB0ZkFGcW44NmdmNUpQbVhzc0cxZWRE?=
 =?utf-8?B?eUVMbUh5eGp1aEhkQUhZa254TzEwZEZnWkhYR3NOaGxDeWh0VDNpVzlwMCs3?=
 =?utf-8?B?RndkR2xGTXFyR3hkank5RldPVXIvU0NCcGF0OEoyYWp2NU1ZK2RiaUFwNUds?=
 =?utf-8?B?SnAwUk15WWJtNHlqRnVxTk5STDNmb1lyWWxsZE5rSkN5UjA5ais1YTJRNW44?=
 =?utf-8?B?Q3BDNjgwZ0xNM1RwQ0tVc1kwMlRMcnZUT3hYOHcydUZGbUdDZHc3MEpYVkhn?=
 =?utf-8?B?ZWpvRjFrdkNuZzhodllvaW04WkZMeFk4amZRa05jU0h3WjhYM0RkaXFuZTlW?=
 =?utf-8?B?dzk5dkJHYm9hT2RIV3pRWG1RcDQxUWREalZhUHU0aW5MVHhFY00yY3JDRXBm?=
 =?utf-8?B?eGpLcTNOK3RsREJ1REVMZmFqUlRnVmpBN0JoaW1yVk1uSHJnZGxYbjJ4cngw?=
 =?utf-8?B?WjVLakpvd0FIMkRRdXFtYzQrbGpwbkZnUWRQbnpJSVVMelFDb2FNT3o4eUNP?=
 =?utf-8?B?RFo5c3J0Y01CdStMYnkyT1YvTzdKT01rQUs0QmZFY2g2azRjVFhPM1FuWFFj?=
 =?utf-8?B?YzNPRjMrNlZGdXhESDhEUHFKTkRYZWdOa2Y2SkxleG51VVpyVzR1K2VsT3hh?=
 =?utf-8?B?ZlJNRHBSM0xCUlE4SzdVZ1QxclByZzNYcmVzZGdVajRKbndoZmNZZTdaZiti?=
 =?utf-8?B?TDU4NHV0cjE3R3JFcklBRFc5U2l2blBYZm1rdWw5T1ZnTjJuWUxEWk1zUmVo?=
 =?utf-8?B?dUdQcUhRdFIrQ3p1SVB0LzdDamwrd2JaL3JCaE9rTVVtcWRod2pkM2xvcXpH?=
 =?utf-8?B?WFhZT1dRWTVRU042aDE2V3lPeTVhQ05GaVJXTStYOThLUFh4cDN2QjVDUUlp?=
 =?utf-8?B?RFNHeHZodjc2Y2hOUmlJUHFHTVNzU0pSdjJjRmNCbll2UWdGMW9CUnJ4ekpn?=
 =?utf-8?B?T3o1U3Y4K3EwdTlaSExmQWVZRFlndFgrZ2I2WU56VU51NWVJQWJzN0Fsa0hu?=
 =?utf-8?B?YUxCeGNVNmtBNThzRjJqMWQyOEtiMnVkZHM2MlpEL2JMODlyaVpkc3Fjc1pi?=
 =?utf-8?B?d2F2Vk5kaE5GVko3cE9maHIyR1dOcldORnNOenlkK2ZWYi9lRjYrQklzNVhs?=
 =?utf-8?B?M1hCalI2aG45TTJIaVBnM3piK1Nlb05LTkRleFl5MVdCaDZrQjVYZmxEV0Fy?=
 =?utf-8?B?OTVqT2FFZTB4NU5OenRyTjZub29DM213K0VOcFVhbmhGVlNqTjB3NU5qM1hV?=
 =?utf-8?B?dmdheXVwUUhrMHB3NFgzbHJ3M1k5U052RDlwbjlmOVhSYlZ4cnh2dWlaRHhm?=
 =?utf-8?B?dWQ2ZnFhanIwdHJlbm5WKzNVbmN0K290aWlkNExQL3Q3N05JcmR1NHVFNmZO?=
 =?utf-8?B?SVp5aEV4YVVuRnhuZEJzdzVWT3JUaEJxcEpDTldXNG0rbDVENHdLME12RERI?=
 =?utf-8?B?WnQrU0NHUU1QK21Qb2MrYnF5RkhzSU83OGRmVStUNmJnMFVOWlRvRGNrb3VR?=
 =?utf-8?B?MWY1bEwzQ1liajhuUU80eGlCWllaOHdNcEd1bWRRTWEvSXo1UlB6YWJ5REpu?=
 =?utf-8?B?aDBFTFNpeXZKZHM5aVUrRHg2SldZUUZ6cFhRdWRFM09WOTQ5ODlQV2Nsaktv?=
 =?utf-8?B?LzJrbm5XYkpLN0RmbGZ2SlRuWFhnRTQzalc3S3FFUkNSeVZ5WExDcG9oOE80?=
 =?utf-8?B?MmNNYU9WS3Zsa2lPM1hVeGczeWZlYUNMeFFmZG13ZEc1TWxKRUsrY21vdmkz?=
 =?utf-8?Q?HQB83LBqU0YfulLDxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd442bf-97f2-4328-a72f-08df2f725825
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:53:46.3516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiXUeselZKsZ3cZW5q5gv0CEqYJmECA5i4vTrs69xEAwZCBCWnT5s9MHgANTh8Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB080844
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 07:09, Jesse Zhang wrote:
> The CS ioctl hands the GPU the GART address of the user fence BO, but
> since the BO keeps its own preferred and allowed domains, it no longer
> makes sure the BO is in GTT. A user fence in a VRAM BO, which only needs
> to be a page in size, gets its address from amdgpu_bo_gpu_offset(), which
> warns about non-contiguous VRAM. On navi31, a CS with a user fence in a
> 4K VRAM BO, or in one created with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID:
> 
>   WARNING: amdgpu_object.c:1531 at amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu], CPU#11: cs_gem_checks/18393
>   RIP: 0010:amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_cs_parser_bos.isra.0+0x4eb/0x850 [amdgpu]
>    amdgpu_cs_ioctl+0x97e/0x2510 [amdgpu]
>    drm_ioctl_kernel+0xac/0x110 [drm]
>    drm_ioctl+0x2c6/0x5b0 [drm]
>    __x64_sys_ioctl+0xa0/0xf0
>    do_syscall_64+0xa3/0x4d0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> and BOs which can't be in GTT at all, like GWS or OA ones of a page in
> size, pass the checks as well.
> 
> Only take BOs which can be in GTT as user fence and validate them only
> there, like before, along with the other BOs of the CS. Validate the
> user fence BO explicitly as well, a per VM BO shares the reservation of
> the root PD and so isn't one of the locked objects of the CS.
> 
> Fixes: 1ea863fd736e ("drm/amdgpu: keep the prefered/allowed domains in the BO")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index abd8a756779e..62758866378e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -153,6 +153,9 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
>  	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))

Oh! While at it that check here is incorrect as well.

That should probably call amdgpu_ttm_tt_is_userptr() instead.

>  		return -EINVAL;
>  
> +	if (!(p->uf_bo->allowed_domains & AMDGPU_GEM_DOMAIN_GTT))

I would harden this check here, e.g. test for:

(p->uf_bo->preferred_domains != AMDGPU_GEM_DOMAIN_GTT) &&
(p->uf_bo->allowed_domains != AMDGPU_GEM_DOMAIN_GTT)

This way you can also remove all the other checks because the buffer can only be in GTT and nowhere else.

Background is that I'm pretty sure some of the other checks are not sufficient to have the buffer not pinned elsewhere.

Regards,
Christian.

> +		return -EINVAL;
> +
>  	*offset = data->offset;
>  	return 0;
>  }
> @@ -823,6 +826,14 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>  	uint32_t domain;
>  	int r;
>  
> +	/* The GPU writes the user fence through the GART */
> +	if (bo == p->uf_bo) {
> +		if (bo->tbo.pin_count)
> +			return bo->tbo.resource->mem_type == TTM_PL_TT ? 0 : -EINVAL;
> +		domain = AMDGPU_GEM_DOMAIN_GTT;
> +		goto retry;
> +	}
> +
>  	if (bo->tbo.pin_count)
>  		return 0;
>  
> @@ -858,7 +869,8 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>  	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>  		p->bytes_moved_vis += ctx.bytes_moved;
>  
> -	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
> +	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains &&
> +	    bo != p->uf_bo) {
>  		domain = bo->allowed_domains;
>  		goto retry;
>  	}
> @@ -992,6 +1004,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	}
>  
>  	if (p->uf_bo) {
> +		r = amdgpu_cs_bo_validate(p, p->uf_bo);
> +		if (unlikely(r))
> +			goto out_free_user_pages;
> +
>  		r = amdgpu_ttm_alloc_gart(&p->uf_bo->tbo);
>  		if (unlikely(r))
>  			goto out_free_user_pages;


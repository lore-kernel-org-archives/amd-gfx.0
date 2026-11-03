Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C0606A972
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qX0WDavr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F60E10E3F5;
	Tue,  3 Nov 2026 08:44:39 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E75D10E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftry1mSee/MeRJesXqs2PELDJAYLfps3njdi1y02v8S07k2rPu4SZmrfjlwc7Q+1lrMQqM7aW5p7sN0utK3vbGbjB0FlwESy1RFGhR0oVPsAT0Z+5/77tmmkOuG8JCMri1SXhIKPjMcc4yE9yhUMYu86cgNu4IQ05t6xPsNSlg1DBg+WN9M8eQuIXMFr24mDW+CIhN/S/gUL7MVkbkT38FwTjCmuGArPA2kzXUqte3LQGi/V7OJ9SItqxDTbDVab2yIWomXxOhYbMAruAutnYlnFmJ8ji4vynu/A9ErGpypBlkTFw7Af2GD1NPtsYfF48l6WjvrdDkESerVD/2f2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOiUCeHbnZGXXTbG+HdOmhAct9WhIxInh1mT8ZUXWOE=;
 b=S+pQMdov2nNne2IUbKOIFWHQrYLfHdbwaLkQT1V4O4T5OD5+mYdAYvbmznpgnltfoaKykNU2A3kDrCcWmdHs49Yr2R2A31gK3VBVh1hAq/IAzOUGLz+xmR6UYN4nsG0ObxXZPuTWhqF3rHCOAO1nJPAVxCbS9kYyEY3LzdGHUNIqzCFoGS8NbuQ32pwX2xTzXVw5zkf4IZIqt18+pTe5k5LGhvMlUis3Jf9cGahQ93ui3ejzWnfJy1SHZGVJvKati8UsTbawiJsF69bUEh+MBMc9VczdWUn6Lg/wjL5YnpAN46fhIW4s5Hi0ZHZScgY1c2jnLIFnq3jm5v2fXXcNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOiUCeHbnZGXXTbG+HdOmhAct9WhIxInh1mT8ZUXWOE=;
 b=qX0WDavrmYo1Hnood7ohxAx+VJ790w1PZTa5VZGU+nL0+crIEoFBYt4G8IKw/HPyQytjb4/dj2Z6+W610+JqUlnXX5qGDQTVE35dH6zW+HSl5v/wtwAh1SQ4onlk2NFJWwXiLTUY03kA9qXBtlL5dODRfPa0JZgebrEfZD3eli0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:44:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:44:30 +0000
Message-ID: <bbc96e01-029b-4555-b539-99030f90c43e@amd.com>
Date: Tue, 3 Nov 2026 09:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: don't walk the CS chunks when allocating
 them failed
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261103083132.3056003-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 456ca18f-da85-4dfc-3466-08df3986ad14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261021123027099003|260925021311599003|260925021911599003|260925022911599003|11063799006|56012099006|261021135927099003|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: vYSIpWsqgUedrzUzHBQaUkOQA3w4+OAvxO5QKM13Fc36Y4eMdZFgmfYcr40893z/ldz3eT/md7TUYV/R9Luo8YdbRVesRjK7QxWKOZBwBb9CwiQKS2zfYNkDYDFs8WjuzmS5nmG6+O1eYXPSg4l46MKOH55P5+YGHAwhc7zz9EOBqT0wkuWtZitv0nfwUzBRqZ4kCDOFbmfFeaA8fgw5E64vhuUCWxSKcryPyAoDjPEmx0zr5nKKvLN6Kii+Z2LE2tTEcOYmB8ZNQRodZhg5IZ79S7Z1KpYwWxATDqIIHCCxvMb4sEu7WHk+CdVwZLaYsfedlNVoRp/P3k9mZC1jiNhMh0WMPga0ljhk191OzoAggBwNvKxcl3CkQXx3K/46aew93uBqUT1FvKAj9M06jmijTkJwXlth8GpOUPSNtSCAOeqUUvN4E3uh50BCyYfgKwXbFnRs3DBGC2Rxlj3OT5JgcX7xXI6lVvdhaH0dM/J9MC8L84XcuRKg9VZLDVH0AG5sHiJPtiIhPZybnZZaEBen36OSvddFJy+p556nuMyZSjdaAjUSp1lTTdaeo94iqAHk3lo49BOBiB0jDYHvjhdZuBeOPiX18GYDrC7nR7sIPTrRo0YjyLVgzaqVF9ak3/2X7lacNSJiBJZrWXQDLezrtVVWyoyMx3QaTkwaJtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHR0am8vc0kzY3l1aHRySXBhN1IvMW5UK1ZGaUJxTkpKeE1WZ0hlQktRNFIz?=
 =?utf-8?B?dUtpOTJqUU5qTldBcFpxOG5VTW1uY3p5UXkzOUFGekpldzdMZ0tTQk5sY2FX?=
 =?utf-8?B?UzVwaFpoWUI3K0lNVUlGSWZSdi9rWGI2dmVJczljdlAyVld0K3BhWmVXRmZa?=
 =?utf-8?B?OWp1S1ZqWWNJVkY0MW94MHRCaGRldGFNU2JmYVN5MjczUGdER3BESTJ1aSt3?=
 =?utf-8?B?RkxGVTFLSk1tYWRnaXJvUUdpaEwzelN0V0t2Tm9mYVlsMDQxWllUN2hrWkN2?=
 =?utf-8?B?dzZQUk1MS1Zkczl6Q0xYSkF3MDJYcmlWMVhIdWRXazJFWVpMZzB0NUgxS3cw?=
 =?utf-8?B?ZzhBdU1SVVhEdnhydHZLZDV2a3RyZnF6U2crakpzOG1NRVRvd2I5RVo0a1Vm?=
 =?utf-8?B?emo4SHZlc0I3dXhPblJxTU13ZnNRejkxblAxNzlCNkNnbkRBb0xtS1VkWFM4?=
 =?utf-8?B?UnpBdEEvMTFhbVMvYW1vTlVCRUhPam4vbDFKVVI4b0trY2RIcTBrS3Azd1px?=
 =?utf-8?B?cUtueE9oR3Z3b20vTS9rT3lTT3Q4TnFTekhGb3gybVpnemhsNjhEbzhGL2h3?=
 =?utf-8?B?S25JNkFEQ3NyMU1LNXVWS204MnBaSU4yUXZEWTNPUWc2WWJsbE9rVCtIeHAy?=
 =?utf-8?B?blBaazdWSnpOSS8wYld4dXZCbVhWcDZqTVhldFlGSWViREM2RlU2Z0gzNUhv?=
 =?utf-8?B?bnlQaTMrN0V1RkV0QmpWVFNVcStzdzVxaVlyQ09rSzExblpHZ2cxMEhOcFhY?=
 =?utf-8?B?NDZLcTVUTVdVYVBhK3pNangycTFiQTdua0FrOUdOaFBRVGFWdFVxMkU3RzlY?=
 =?utf-8?B?ZzRGK214NU5vbmxlQjNBVk9IcDhrSGZRZmcrQlFHaXMydVBWR3JJVzlqODNV?=
 =?utf-8?B?eG52SmJpVFRrQS8yMVQySFpCVFhreDhBb0o3RDNrK0hPcDV6am9sUUt5bnpj?=
 =?utf-8?B?a3l1TEVQc0M1amc2d05DN0hJZ2FYK2N2RVhGWkk3cHo5VFpNM2UvSkJnSDd2?=
 =?utf-8?B?MjN0eXJmNkQ1QlpNUGJMM1ppWGYyY0VYanh1OSs3cjZlWm5xSUZiOUc2THhN?=
 =?utf-8?B?Q1JWbWEwU1FmWndqOTJrRUhtL05Id21DL2F5WXZvMG5OWjVnOEh0ZmFZeVNZ?=
 =?utf-8?B?dGd6WGdidkphR3BySUxiZHJRTTUwVTJyaFNkVUp6cFlDbFJEOFV1N2tJR3lI?=
 =?utf-8?B?Y1pMdWE1aDB4RG9mUlJYamFTMFdxN2ZzUUhtTERhV2UzK2pvQTJLaWRITE4v?=
 =?utf-8?B?dms0TkRpdnp5a3lESVR4MnFSSm9jSitaalJnOCtBZ3FTM2IyNnFLcE5GMWJu?=
 =?utf-8?B?ZFJkS0UzUXptZVZDNjg1Z0xydTZONW5jMENKQWhJOUF0VDBTWGUwVzZQRTNP?=
 =?utf-8?B?TkgyUVV4MkpuWmw3RVFOcEtETlpPcElQZG5TSlpWN3dNS0U3NFM3QVlFUmRs?=
 =?utf-8?B?Vjducjd4YVU0OE5VeTdZdzJoZGdzbk1ubTVsSXJCcHI4VXY0Q1dKSEdheHEr?=
 =?utf-8?B?b1hJc3V2dXBRQjlQY1dhancwdW5udHlwcGxDSzBHRFRYS1M4bEpuSE9GbzNk?=
 =?utf-8?B?Vm1YMmoxbWhRTy84cXQzdExLWXp1WEVDMmdKZXVlVUNITmFIWmtFb1lkYWVS?=
 =?utf-8?B?T1NlS1lmQWsxZUFiRk9XYUFFakJGYWRvRGd1emloUTI2QzhHOEJwV2tWNkdh?=
 =?utf-8?B?NGtLRTBPaER4aHFVejBJeXQ4cG4rMVoza29KZXFHME4vTCtxOG5ycTRHUnlx?=
 =?utf-8?B?cjVkejFxcDNVMDl5SXlLeWQ3NVdaVHpTR3p2a0lvcFNkOHM0ZHpCbkx0QlhN?=
 =?utf-8?B?UGJzRVozbHdxM0M0OHJqTU4ySkdiajBnQ1FQR2V4ODdYZDJ5NCtKaDNaa3NP?=
 =?utf-8?B?TCtxTVMzS1lDVHcrUUxsMy9IaU1adE5DNWhqQjFUSVA0dzJqZzNjcEN3K0Fn?=
 =?utf-8?B?ejNxd3BMbk92R3g3b2Y5OEZTWTdaUkhmVlVZSCtzRG9SSzlIWWFmcGJDRTRv?=
 =?utf-8?B?bXRNOU83VDhENVd3RERuS29aWG9GZU13WFdoODNzOXhKWWRrbDVmNG8wOE9Y?=
 =?utf-8?B?M29WYnZiYjZYTUtoK202M3hiNm9QTXFpd0ExZFd5bW1jQXZJcXNOZUwzMG1o?=
 =?utf-8?B?RGtiazlBSk4yQk02ZjF3aStWQzYrOVJxOUx2WmZCVUxsbVNmN0tsaTBDT3Ni?=
 =?utf-8?B?K3pWaGljcDlkNzF6dEJ0ZjRKWjUyNlZmajJWbGJTWlcyaEp2L2piMFJWY0ds?=
 =?utf-8?B?eU5CUGRFSko0SUVPdER0RHhHZWdMcWw3Vi9CU25neTZEU0l2Y2hWYSsyODNh?=
 =?utf-8?Q?0sgnjfDIT2drN4gubp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ca18f-da85-4dfc-3466-08df3986ad14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:44:30.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnudpXOtOJqKzces2p5ltoBOEJbKIIMoVztmcmL1j7I7IUQ+uhs9C8qJoYejHV1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/26 09:31, Jesse Zhang wrote:
> amdgpu_cs_pass1() sets p->nchunks before allocating p->chunks, and the
> allocation failure path skips resetting it. amdgpu_cs_parser_fini() then
> frees the kdata of nchunks chunks from a NULL array. On navi48 with the
> chunk array allocation failed through failslab:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:amdgpu_cs_parser_fini+0x35d/0x710 [amdgpu]
>    amdgpu_cs_ioctl+0xcae/0x7a20 [amdgpu]
>    drm_ioctl_kernel+0x180/0x320 [drm]
> 
> Set nchunks once the array exists.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 2d0cfe723cdf..b4555d8d108d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -203,12 +203,13 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>  	if (IS_ERR(chunk_array))
>  		return PTR_ERR(chunk_array);
>  
> -	p->nchunks = cs->in.num_chunks;
> -	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, p->nchunks);
> +	/* parser_fini() walks nchunks chunks, set it once they exist */
> +	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, cs->in.num_chunks);
>  	if (!p->chunks) {
>  		ret = -ENOMEM;
>  		goto free_chunk;
>  	}
> +	p->nchunks = cs->in.num_chunks;
>  
>  	for (i = 0; i < p->nchunks; i++) {
>  		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;


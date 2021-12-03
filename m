Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FC6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37835733F7;
	Fri,  3 Dec 2021 07:18:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8FC733F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 07:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBF2lYJ/38aGAtaPMysQJXqDB12grCkn180P8QeyMgw7h4InlpkNB64SQEEZYDDU1uS1zszet9On8oN65WekEx7QseeQoNKwaIWqp4Ep1B2mSJYChlaTCzT16tSZ3YEUY0x/H9/DdUvRsnXMdOUEv9D+XIkHwmXY6+r1VCVZ72npko85Byf1bVfc/G8IuIYEjQ4IrPpg3O90fEAs8wgrXrUIEQLtls34xIRD8a01OQuv6jPntJuVb/20kk/CHBhyTfM99NxEI9L+bU+IAZ1jyJ94AvbPBYrgTM+neSCTlpIX07MvasqXn79KepwuCDym3LvHlwhQ8Y8PDppIwtL9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y/oMGw4cnof/nlNI+WBpLnQfmZZkIHwSP9qN9ZTSlQ=;
 b=nA3DFuWIovZBJpELkIEk3BO2EtsMzJCZJuSfYkH29YJzi+ijbQe1+lQkWlEURtEXwsngacyS4E2SvPuQ8FNw+nUj48JVWQrF5wBDRzAUmvr4irt+oEHnX4lkn2fJ4g/tCDQvoL/AxhfbITHnw2pVUXXUBPR2dB25EyjS1KyyBGZply8egpEOxKAW+C90e9CfkIs02hxd4HZ3VHodmXGnM48xQUEllmQAY+f8C2e0O8Pe6JGZwaT/scUTMpGHGZgralOln9ZyVIZX/qKlTszfgIzl9r2hLjU3LevTCVGWk0mkbh9cn2laOeadP8XF+m5pVD1U5NF49GZ5vQ5jQHLeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y/oMGw4cnof/nlNI+WBpLnQfmZZkIHwSP9qN9ZTSlQ=;
 b=FGM/IvYO3H46SG5z+/JqPd4MEexeI+Ip0QZbIUngAErdefQQW2uwd/jzYKn15clGEczY3GDDU1D68zja3hxSSXwBRYEsmPpGgTriSXJi4Vxf8F32c2glQAuh3gGS5QdArSAJti/Vc0FGdf7bjHbgKVKCybQgX6YJNpigOL0KBaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 07:18:46 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::54f6:ca03:e51b:3992]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::54f6:ca03:e51b:3992%9]) with mapi id 15.20.4734.023; Fri, 3 Dec 2021
 07:18:47 +0000
Subject: Re: [PATCH] drm/amdgpu: use sdma to optimize debugged non-visible
 device memory access
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202214304.1155207-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5a08c767-d7f9-31cc-5e64-a0722575cbd1@amd.com>
Date: Fri, 3 Dec 2021 08:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211202214304.1155207-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::23) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:6401:b609:60e7:9b8f]
 (2a02:908:1252:fb60:6401:b609:60e7:9b8f) by
 AS8PR04CA0138.eurprd04.prod.outlook.com (2603:10a6:20b:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 3 Dec 2021 07:18:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe30e1df-98c0-4f82-c642-08d9b62d256d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:
X-Microsoft-Antispam-PRVS: <DM5PR12MB141885E60987BBCABC9BB5BA836A9@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebdBRMTH2gv+mLTphktnxGJL1ZW3yFt+8P3x1TRfv6hDOV1RxFw/FubK16V8HpwIxXuJVDjO31onoFAdNI2JuRvobFhtG5hTeSFvgpKvQObvNC695wa1f0tieaf83Y3b8KesR2ZB7Bl7M26tDQxtjksgaVR7+JP70yQXzV4aH56Xl8WgQ/FFCYNCPAdorjpEKsrrLb+rXb3UWkMtRH/7KZsZyH+1/lA7/gEIJ9khUvq4Y2IjdkpxLowN25oqbb+3tWF886c3S/LhnWyAxBN874KW8yVU+AqCrcCuODRpcx15oBHj95dMqk/zWZ7M4jCWEfHMfkJes1o23f/X4fDRMIMimupLxeuJa6j330uTxYwYKNxyZO2a0A0j/D0bapBt/fXGe7Yq5N4V2ERMyTi3VwFNZ+JufH9lSi7hDqg/j1iQ0+LUcSMWs63VNWEIN5wUBxTkgt+7NFKAkCRc4Vvd4mtMisyhTcPptfFolQieqqjXv17fVxWsJ8iCpn00QaXmR34M6pYSDx7XikrDyojSFF/G9J+26+tkm6kS8yCWK2fjiMmgkVNfH15qZ3L1ZlR4zh+fszOcGYthWYgVNd7NYETvxN2GGjELDnYIojpSIGsikJTgxNYXIahzYhFsQJAttKQ+VIdZM+l1T+yU7vQC7bqZNMfXMvRMz9W8Lz4IUgezOyBJeF8MYqth0OWS8n2Z0qfXZostrXI7oO9ww18VW6K9j0BpZwnTPJ2n0GalICw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8936002)(38100700002)(66946007)(66476007)(4326008)(66556008)(31686004)(5660300002)(6486002)(86362001)(2906002)(2616005)(316002)(8676002)(186003)(31696002)(83380400001)(36756003)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjh2RXd2M3UycmozS1ZXa1ZyWGFSYWczeVovdS92K2hwTlhJZW1hWEh2K3NY?=
 =?utf-8?B?MWxaVHhZdzZzNGpyYW5MR0oxSzJEOGx4ZGU2aysvU0tFdXRCTzZDaGNDaUo1?=
 =?utf-8?B?QlpJQ1UvUzMyUW9POXNmTzdINmszR0FuVDBGM0xmQWZ0cE1JTElUOWhhbXNK?=
 =?utf-8?B?NnFQMVBONkUycGJIZFVmaUVKUklCd3VVU0dvSFFzSjdOVVhMNFlGUVlPZDYx?=
 =?utf-8?B?Vy8yVU04OGFDMkVhdDlJVlJuOW1CWGVGMDdKUXZLUE9KZU4rMGRXNkNBTUJ5?=
 =?utf-8?B?NjdJd0hLTUFmeWVGamE2b0xnc2xVay94VXJiUlFiTHNPL0pOWGUxai9jU3FV?=
 =?utf-8?B?bUNMV0Iyc1J0aDYxME5MakpWaUxhWlUvMzRvcUhBRXV5MWU2ZUFXVmdoSUJm?=
 =?utf-8?B?ME94V09Xcm9rL2RacUd3YUFQcm9jaEtSQ2VsalRxSzJGQ3NXM2I2TTNsWG5n?=
 =?utf-8?B?WHFrNFIvZ1FCMEN3SUN0MXRrQWhwNzd6OCtpRExiTGo4dFVPWVVacE85TExJ?=
 =?utf-8?B?bUxUSmx0dDAzblB3aXZWZmNwcy96QnROOW9hbUNKMnZOV1hnQWw5c0lraXZS?=
 =?utf-8?B?MmRzanEwaURSU0U2RzZqSURYdlFKZGN0MlhRcGVJR01lcGF2aDlSU0RlSFVU?=
 =?utf-8?B?clovSWppbEZxL29QTzROeDBlM0NPeW90em9OS1V4bGozOFVRaEFMSFNHZmdv?=
 =?utf-8?B?bWpJYlY1bkE5WHpNQ3BUYUE5RlhQS1V2MWVmRDNLWmp4cm1MS0dSTUkwVW9l?=
 =?utf-8?B?aHFkV3k4b2RzRVI4Y2o3cjNhb3lrOFcxdEhlS05RdjZsRHRPeGVaVnNhWHVx?=
 =?utf-8?B?b0ZhampEUG8rRmRrelRpQXE5eXphOXpENWN3R1RxZk9udUo2OUJpcjQ4OWl0?=
 =?utf-8?B?bUg3WmZTRHFDS3VEc3VSdjF6MmIxdHVuc042Q0x6RVFoaVRCbnlLS2dQYkV3?=
 =?utf-8?B?MThRYXdESXVFSStqOFFSSEdMTmdvQzU1MVFVdTFnMmVDTGk1dm1uWUsxcE1B?=
 =?utf-8?B?c25rRzQ4S21OUjZldGdOamo0cENFMmk0TzFOdkxkS2Ruend2RTdTOFhBNERH?=
 =?utf-8?B?NTdnZ3VNMThZZnFhQkRMTDlNV2pENzVPSlJ5dlpPMms0c3pqcmZXa3poTHRo?=
 =?utf-8?B?N3d1VWluL3dYK0VycFpUZTVQRm50RVdqd1JIQUNKaTNUZGFHVFR2cEtsdDZT?=
 =?utf-8?B?Y3pla0lIUFRkRmY0RyswM1Z2OWhpeTRVR1lzeWpmT0VOQTlJck9XN0w5M0VH?=
 =?utf-8?B?cDFsSm91ZlFHdXIxZm5aaFdUT1RwV29KSTBLaVU4b0hBS29pUzk5N1d5dmxK?=
 =?utf-8?B?M1gvTnFjRHJ6T05XRWlqT0VNQkViMkEyM0tnNm01cjRyTTBkNmdHQzlJY0J2?=
 =?utf-8?B?bnFFdVJ3a0ZmWmRzZGtHc1p1UndudUQwZjZTaXMzTlN5aHZYbGdzV3ZOOVFa?=
 =?utf-8?B?bVM4SUtvOVlMVE1BMWw4ZDFYckExbndnTGZVTjYrTlRBV3VCaVUvUXlodDFm?=
 =?utf-8?B?em9ua1JRQ3lNTXRLZnhhL0grcGJtdmlPT3lNeFV0YVRjU0cyUzNNZXQ1dzYx?=
 =?utf-8?B?dkJ4TGtjaDh6RDZqQnp1V0phc1h1UkVPcS9JQVhFZERSWGc3czVZM29hME9G?=
 =?utf-8?B?WHJlVlVtbnFFb0h3NmVYaHVjNlVIVDByalpJbHZVWkFhaTVwSFB6b2Y4Q1N4?=
 =?utf-8?B?TDlPanhBL0lXV2JrbWp0aDU4ZlRHRkpUbVZmSDZJclJ0YWVvT3V3SysxZ2lz?=
 =?utf-8?B?RkRQbm9MNjkyUUJqTXRZSUVIcTZPckw5QXVma1JGVDNHbmVlN25VaFNpSndw?=
 =?utf-8?B?SVhCVmxIQ1FFNERlWEJDU2FzSnVicTljODdzbzF0NlZRWFVwUTBIRFZpTWkx?=
 =?utf-8?B?a3ExZksvVWN4Z2hhL3doVUh4S0phREMwazVwZU02eHhGUUJpMStpaGVqUTJt?=
 =?utf-8?B?Uk9hbGt2R3ZkV1Z4aFVwTGw0MnJkaTR6cWhPZy84UXM4am1MQjUrUklkRVlX?=
 =?utf-8?B?OHppMjlaZHI3YnE1eEVWU0NZbDRNdnMzNHlwaHFJKzVjRVRJNkE2RE0wellD?=
 =?utf-8?B?OStNK1J2RUc1R0NtTU5BN2ovZWV1RXV0WHZFQW9qZFBEWGFuVGRacW5qTnpB?=
 =?utf-8?B?OStTVDlxbm9EZUdDcmMwTDNocTNiekRVUjVaNFo3TStRbytiUXFMV2tsbGVk?=
 =?utf-8?Q?2PY2MyftCPgT4SPyHLubV3M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30e1df-98c0-4f82-c642-08d9b62d256d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 07:18:47.0099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaMr+rrqjYbd+Hf005+SSiiXkpIYEeseKL/nUYkdLAG8R830eo5VQOrUxhuJkPwk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well NAK.

We already discussed this and decided to not use any hardware 
acceleration for the debug access.

Apart from that you implementation is absolutely horrible and won't work 
in all cases.

Regards,
Christian.

Am 02.12.21 um 22:43 schrieb Jonathan Kim:
> To support better memory access performance on non-Large BAR devices, use
> SDMA copies instead of MM access.
>
> SDMA access is restricted to PAGE_SIZE'd access to account for the PTRACED
> process memory r/w operation use case.  Any other access size will use
> MMIO.
>
> Failure to do an SDMA copy will result in a fallback to MM access.
>
> Note: This is an attempt readdress patch request
> 'drm/amdgpu: extend ttm memory access to do sdma copies'
> with the addition of restrictions and fallbacks.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 97 +++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 23fc57506a20..1cb984252f58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1741,6 +1741,91 @@ static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
>   	}
>   }
>   
> +/**
> + * amdgpu_ttm_access_memory_page_sdma - Read/write page of memory that backs a buffer object.
> + *
> + * @bo:  The buffer object to read/write
> + * @offset:  Offset into buffer object
> + * @buf:  Secondary buffer to write/read from
> + * @write:  true if writing
> + *
> + * This is used to access a page of VRAM that backs a buffer object via SDMA
> + * access for debugging purposes.
> + */
> +static int amdgpu_ttm_access_memory_page_sdma(struct ttm_buffer_object *bo,
> +					unsigned long offset, void *buf,
> +					int write)
> +{
> +	struct amdgpu_bo *dst_bo, *abo = ttm_to_amdgpu_bo(bo);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct ttm_operation_ctx ctx = {.interruptible = true};
> +	struct amdgpu_copy_mem src, dst;
> +	struct drm_gem_object *gobj;
> +	struct dma_fence *fence;
> +	struct page *dst_page;
> +	struct ttm_tt *dst_ttm;
> +	int ret;
> +
> +	/* Create an SG BO to dma map the target buffer for direct copy. */
> +	ret = amdgpu_gem_object_create(adev, PAGE_SIZE, PAGE_SIZE, AMDGPU_GEM_DOMAIN_CPU,
> +				0, ttm_bo_type_sg, NULL, &gobj);
> +	if (ret)
> +		return ret;
> +
> +	dst_bo = gem_to_amdgpu_bo(gobj);
> +	dst_ttm = dst_bo->tbo.ttm;
> +	dst_ttm->sg = kmalloc(sizeof(*dst_ttm->sg), GFP_KERNEL);
> +	if (unlikely(!dst_ttm->sg)) {
> +		ret = -ENOMEM;
> +		goto free_bo;
> +	}
> +
> +	dst_page = virt_to_page(buf);
> +	ret = sg_alloc_table_from_pages(dst_ttm->sg, &dst_page, 1, 0,
> +					1 << PAGE_SHIFT, GFP_KERNEL);
> +	if (unlikely(ret))
> +		goto free_sg;
> +
> +	ret = dma_map_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL, 0);
> +	if (unlikely(ret))
> +		goto release_sg;
> +
> +	drm_prime_sg_to_dma_addr_array(dst_ttm->sg, dst_ttm->dma_address, 1);
> +
> +	amdgpu_bo_placement_from_domain(dst_bo, AMDGPU_GEM_DOMAIN_GTT);
> +	ret = ttm_bo_validate(&dst_bo->tbo, &dst_bo->placement, &ctx);
> +	if (ret)
> +		goto unmap_sg;
> +
> +	src.mem = bo->resource;
> +	src.offset = offset;
> +	dst.bo = &dst_bo->tbo;
> +	dst.mem = dst.bo->resource;
> +	dst.offset = 0;
> +
> +	/* Do the direct copy and wait for fence response. */
> +	ret = amdgpu_ttm_copy_mem_to_mem(adev, write ? &dst : &src, write ? &src : &dst,
> +					1 << PAGE_SHIFT, amdgpu_bo_encrypted(abo),
> +					bo->base.resv, &fence);
> +	if (!ret && fence) {
> +		if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
> +			ret = -ETIMEDOUT;
> +
> +		dma_fence_put(fence);
> +	}
> +
> +unmap_sg:
> +	dma_unmap_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL, 0);
> +release_sg:
> +	sg_free_table(dst_ttm->sg);
> +free_sg:
> +	kfree(dst_ttm->sg);
> +	dst_ttm->sg = NULL;
> +free_bo:
> +	gobj->funcs->free(gobj);
> +	return ret;
> +}
> +
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1765,7 +1850,19 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	if (bo->resource->mem_type != TTM_PL_VRAM)
>   		return -EIO;
>   
> +	/*
> +	 * Attempt SDMA access over non-visible VRAM first.
> +	 * On failure, fall back to MMIO access.
> +	 *
> +	 * Restrict this to PAGE_SIZE access for PTRACED memory operations.
> +	 * Any other access size should use MM access.
> +	 */
>   	amdgpu_res_first(bo->resource, offset, len, &cursor);
> +	if (adev->gmc.visible_vram_size < cursor.start + len && len == PAGE_SIZE &&
> +			!amdgpu_in_reset(adev) &&
> +				!amdgpu_ttm_access_memory_page_sdma(bo, offset, buf, write))
> +		return len;
> +
>   	while (cursor.remaining) {
>   		size_t count, size = cursor.size;
>   		loff_t pos = cursor.start;


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB5606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5MnA7Aas
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2963410E0BE;
	Mon, 26 Oct 2026 10:47:45 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64F410E0BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajKgakgR6gugiu1hf3u6Shd+4JW343KyPMYGyNt3XgvQgpshu3NyOqgDIV7FkPHBnG+/qVg/EvXvsiTgr0fbSI9VH5VncnyymyG5JAxy/K4GICXVTfNe2oCX//pzGLtQ0ArEFPb2eBdPjZqAzWbpMEGBBefihf9jnltwZJZT9efmAwpTET27nXOwaIraicKkp5Hf5FdA434Qfvxfs2d+hGjL6Jo6Q+oygzNBd750C9vX0ZogdR6TDRI6Zy9C0njsL2mxBLjT6p39qb+7gs1TY/I55/0CvcEbYUI419SPJTl4uK8uqkOUIdIHiyluD1AD6ovhtcHtLvKC7odGDHhAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Mh1RX8vhmalZEbQCJ1BMXGu8hXKgk/WFTQWhaEHzvk=;
 b=vrahV32Fqdv084TG8gdwIck+0uSkBzpYfxlpXEfnzNLz5feP3Z0rdUIp+DlP8Lz09VCtlrD/OEt+bGHPYJGvFFR35THF/cnjYdn4CPDLsXrRRR/zy61LAqeyFoc1Iv0OTPal68puNRztEXe93+EZ+zDKpP+H8x6/vuXPPVkySaN1HWv8gxLRnCW5BW6IoU1OpXpwqYUaf+ysXO/eBlkL4rgsakQTkH1uIzTi9NV6fre4uQ2pooQoP2QRxPie1LoVcZXkU9QTJVt4pyVj+m+MGTUZcHeLrLGcWW42qq2kFkCOrHmryeLv9S4PYvgaq9rYb7BzIjTeq8fDXeqmusBPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Mh1RX8vhmalZEbQCJ1BMXGu8hXKgk/WFTQWhaEHzvk=;
 b=5MnA7Aasuy8kDpK07k5iEPRl2NzucbW75cc4f6RsKLOhEZRnwOJnODYtoZiZwPigeR30C7OQGRpM0Ja6F5sNsIh54NjLY+DGykWk5KElGgx5pwH4gp9kx/rZrzRc/pNGg+1Ma/LQAEMyF1nXKlp7Z1jOU6MHPkvp0UDMHDTOc90=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 10:47:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:47:35 +0000
Message-ID: <3232b9ae-312b-4227-9362-6f85716d3f2a@amd.com>
Date: Mon, 26 Oct 2026 11:47:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: sign extend the addresses
 GEM_OP(GET_MAPPING_INFO) returns
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, David.Francis@amd.com
References: <20261023101246.937830-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261023101246.937830-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f1b63b-ee9f-484f-0e24-08df334e8be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wzp3slpMxyIktOJNZfCGQVTd8d3WX9ebR18xgSq59kVQ+U2LgxrBsaibR48cCeru5gfeft50hGZswnfMPC+Phng0KtmOSdzxDfBtdi8Y5XepJWCW/vzxK72FTvo+YhHdp+SqjiPc+tBU24pmmWTTEB8P9D8aLxHpdf2AB6re51pPmmCmZvcZdBfd0j0sReiMW4pMo33S2NWsO7NvofeYVk+VbB6ilyOekie/vLgxPvj1kzQENXvBMN0iph6B48D555WGpRMNrU7N5MKFR+DWMOYCjbcToLTwbEgy3cqg0a8WTnvZNg/V1r9FlVmroQ0lF0hq/J7xnGuUFt5Xj6NfRTaxIy9ZAHgKSK/W2MTw1zDu7yALJBQb5ZCroDsDykHZOusPz8SgJl6r4g5PSXv9HFoBl1TS3IUl/K803kTJigYo5Rao/lLhngL2fvpePB0apujq0JIeqGYlT8kueygNAQJ94ZCKY7HMp7n5ISfRlhIoK3O5yTcQ0ON+3GiN4E14o07v3FXLjtsGxobanp0qgTGuEpluJ1loSkfDDSqqQFFRRgH34EDbOtKn2sxT+ySt3CUfxCcMos+rbOo52exfc7sdbol6VBklesrKbtdTrNqYzBQSAhD+BbC5a/ebXlXpvrmPx/4QEK1vcnGtmiht560Sfgy49ofE9UP5Y8ocHys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpLalhYak9RV3VyL0dnYUEvdG52WmEydkQ2Um9pSitvWmQ3Um05TkY3YnRH?=
 =?utf-8?B?ZjFzdCtrcnRYbFVwTXdGaXBBeW96YWhzQWcySWRPK1YzRmhXOHZoWitPUlZI?=
 =?utf-8?B?T0R3UUlmMDRHNnJBYjNJV1JqYUZZOEZQQW8zWTk4TXgxTXgyNHRoQlp5eTd5?=
 =?utf-8?B?eEFnYTlkbjJwTDZQRE5yRGtRNjByWTFqTmszaHRvQzdrZG9SdjJPNlNLZ25X?=
 =?utf-8?B?YnNLT29rY3RDd2FTTUc3OFpnSXUxWUlReUZOS3AvYkYycEhmZ3V6Zk1TL2pW?=
 =?utf-8?B?MmFoeFpmcVdTdHlaUGdUSU9JNTNiamVXemhvbTZGSTlvN0dXRnJsYythcXF0?=
 =?utf-8?B?K2ZrTUNqeXgxek5XOEtkU0tqMnB3bzY5K1JNWlFwbnE0dXcwWXJDYkp5N1E5?=
 =?utf-8?B?OE4xdUF3QWFUem5GZERMSS80SDdJeHJEU0xMaWdZVlp2cHRmRFU2VHdKU0sy?=
 =?utf-8?B?ejBnc0RxZEx5MnljWGNjWDJ1NlRKRHFSZzVhQ1VxTVIra1ZYLzBhbTdYMVVW?=
 =?utf-8?B?WnczZzRMSXAwZDhuNUhkTE54RWFiVERrRzYvaHQvSVJPNFhBK0lEZWlkelRy?=
 =?utf-8?B?NUhjY0YvaklRVkRBWStLckwxUkxxK2xaczFiZEhzZmRwK09lVXhCN3Vqd1JY?=
 =?utf-8?B?VXNvK2EycUllMEV2dEo5ZjN2L3Y3K3pkdWo0SDFvZkJOb0Q4NElQdEk3am9o?=
 =?utf-8?B?NUtyaTl0T2lHKzNkbXNmN0hHUExuYlpFUjVNeEZ0UURkbWY3TDc0dVRxVS9Z?=
 =?utf-8?B?UlVYUFcxbE1ZQjNZU3g1WDVqN1pQVkNkVk1xcGhKZVBLOTNBeGRUYmlxbWRt?=
 =?utf-8?B?aUd5ZlRoQVYxMm5FaW9XeThUSDFJYVJJM2RPZ2srMUI1Q3pGb1dERHFNWHJS?=
 =?utf-8?B?VHd2UU9hSldYT0xjMXRBWEExOXR4YXB4YnQ1RG41UERFRmF3eW1xbTFodTVN?=
 =?utf-8?B?eFY5ZTNSQ3gwaEpWVVZZVE9iYmRmc1BVUjAxeDBBMnFsY2RZK2hHeWw4NGtr?=
 =?utf-8?B?WklCN1RpWFhITGRqK2szVVJ5amduQjFiV09HejV0YVpBUFlhU0FObWU4T21k?=
 =?utf-8?B?VVpQQ3Z5Mmd6SzBrckNKRUJ0UVFIdW9HenVyUUx4Y0FOVStYbHUwM3VRd0JM?=
 =?utf-8?B?cTVtQjFiYzd4L2Z3S1Zsb3JjUzMzbW5KeGJNMjYzMTF6T2JHUDc3UW1mTjM3?=
 =?utf-8?B?WGFTQjliN3dTbFBtZ05oOTRuMS9JTVpSMlIwTzNOeXNqQjFPQklkRTVpZW10?=
 =?utf-8?B?K0J0T3p2ek83YmhpMm5UTyt0Q3NlVlR1MElPUDdHcG9POW5IeXhlMVZxT1lB?=
 =?utf-8?B?TDBKYU9WcmxOZCtxbzN2MGFDZFlIbms4b1RRcm5YbkhjRU16cWl0MEYvM3g5?=
 =?utf-8?B?Rk5KYWNoNS9sdmJReERoS2FmQVhQMkZmZjluZjFycVg4T0dFcEg4QW03TzY0?=
 =?utf-8?B?anpJRUZwc1V2QXJ0eVRuSFlBR0QvY3N0V1EzQVA2RkN1ZCtPNmhxWlJZeURa?=
 =?utf-8?B?SkxMUnpVSDNvMUVBT1paMEJQUFZwSy82T2x1RjFlNW01M25xdGZWTTkydU5k?=
 =?utf-8?B?WDdtUlYzTERjalVXcmFFZU53MGE3ZE5VOTNLWVBLb29ZcEZPcmx6K083Zmhj?=
 =?utf-8?B?d0hJMVdDbkJ0UlZqd28rK2pDZWxHMVk4S25jZGJJYmlReitPMDBJRTJ4OCti?=
 =?utf-8?B?K0YwbGNXRm41OGw3SHpQallDY0EydEYrN2RoTVJNd0lwVXhJdVBhY1Rtb1Vq?=
 =?utf-8?B?Y096b0JxK0xZSGwwbXh2YUFudE9Vc1ZudUJlaXZ2a1FjbndmN3F2Q1k4eGcr?=
 =?utf-8?B?MlFPc0lEYlMxaHhxWkpIa2l2V3RlNHh6aFNXRUNKZEdHK3RheHpkMUJTMmI5?=
 =?utf-8?B?S3pTbFk0RzYvUi9PaW1xZXBQUGhlZjF6U3F5NWFnckZkZzJsZUJaTURlTThq?=
 =?utf-8?B?Q01hbU9Way9ENnRUUzAyQUdpRHlDOGRCTDlFUmlxazNRazhROGVGVENqVytS?=
 =?utf-8?B?WGUxZkFvNnlBZG5lLzNOM3Myc0VGMmY3OXJIQ3FuVFpHUUxEcVJRcEM4eTNO?=
 =?utf-8?B?UjhXc0RuWlJnTWlUbzFJckNsaVU3NmdjMU53b3lFdW5PdDlsL2ZVTXh5SGsx?=
 =?utf-8?B?YkcvMkhVcnl4WmFBUnpTY3BhRWtPbDRMRHRtMStEVG5lS3pTUDJiOTBqanBz?=
 =?utf-8?B?T0xhWU4zcWRrT1JNV1JOOFdNT1FUaHIzR2JObDJUaVFUNEt5V1lnY2NjYTRu?=
 =?utf-8?B?OUt3bjRzeVRocUF0SU12STBwTEhaajU3YzIwdUxHRFZKUW9kRXRWaFJkaW5s?=
 =?utf-8?Q?EmxAJ9lJM4TwtTeMhl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1b63b-ee9f-484f-0e24-08df334e8be9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:47:35.8726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9JL23xoPWZIXT1+y9JrmWUaMplExwO+cjvd/gMxKBCv5crvuXIA35L25+GBDDAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

On 10/23/26 12:12, Jesse Zhang wrote:
> GEM_VA takes the GPU virtual addresses above the VA hole sign extended,
> like the rest of the UAPI, but GET_MAPPING_INFO reports them without the
> upper bits, so they land in the hole. Mappings in the upper half of the
> address space can't be recreated or removed with what it returns. On
> navi31:
> 
>   MAP at 0xffff800100000000                 -> 0
>   GET_MAPPING_INFO                          -> addr 0x800100000000
>   UNMAP at 0x800100000000                   -> -EINVAL
> 
> Sign extend the addresses before handing them out.
> 
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index fb60a99f43c1..c982d102614e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1082,6 +1082,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp)
>  {
> +	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct drm_amdgpu_gem_op *args = data;
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_vm_bo_base *base;
> @@ -1188,7 +1189,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
>  			if (num_mappings < args->num_entries) {
> -				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].addr =
> +					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
>  				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
>  				vm_entries[num_mappings].offset = mapping->offset;
>  				vm_entries[num_mappings].flags = mapping->flags;
> @@ -1198,7 +1200,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  
>  		amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
>  			if (num_mappings < args->num_entries) {
> -				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				vm_entries[num_mappings].addr =
> +					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
>  				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
>  				vm_entries[num_mappings].offset = mapping->offset;
>  				vm_entries[num_mappings].flags = mapping->flags;


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD3606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p7L0GwmK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E726C10EFC0;
	Mon, 16 Nov 2026 12:05:10 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D77E10EFC6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 12:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/F3bhQZwYD/wsRHbsBuXPheQJaeC54gmE2+0ILAbXv/n5z/3zhM+dB9Ip8Oo4bzFalzdC+KRRohA0XTxvmf4jjocB6Q1cIu7VJCwIaQtDaCjh//FCj+O6W7QoueIeHLautaockKjGrEaLWdDydqOi2EN3kurDLUqgf3wucTDJ4P83Lc3PYAA3e8/xMRg6BnCh5XZXRRpsoLPSTT8o4YhjYwIAFXfSMATE5QBuZEg8L7FMR9Xq2qv7Disps90xycRrDKOlAP+9SUhOlwmAyhlDz25v4LF+n409DjHAesk600YJ39PJA5rP9gyubUJ5WM8vEQOCMC462Xxf7ZfVSiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTiuoC8dSdPI1sW1Np4USkYi1sqEVXBICEHnWEsV1rQ=;
 b=SC6eP7yMzKsAHxuDAUoD2uLW2Www7WjAb45NK8FzERAYVJwreNcGwJqoSlsSDoIwPd8eApLF0AgAn6J9YWjqFNR0B6KkJA/tm8QuIJuyDD5T8ortx83jkRlil34t7ZsE+dB9O2VvIQgxOdPzz9i8fJ9ZaNnGAvIeqOqVpMfym8jMu7vCzbJ1EfWfbUdzGMRwZQL/8NmTDGnYxoF4PRJR1SB1Zfgfr1dkXZq2CSqM7E/E9RflyLIt4bHtUSDtVjB/Gy7Hds58etYdBWhGlddbZp/0aRgDCFpUdfcESYEL5DIuDIjNxhR+2gGnfUoCjKviDz0flMCrSpKzlIkh+51s6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTiuoC8dSdPI1sW1Np4USkYi1sqEVXBICEHnWEsV1rQ=;
 b=p7L0GwmKDLo9Hn7fc+mDVQGTmgp4MEHqeQ9TvInEv0MWFTZ5Now8RqnhJ8nLfA7CDYWabeW5Y7BZL/VpSSgVJiK3MTJSFS6ZRcipNZOsTrdogqUHnxdwN0D+sWMBJk3uX3Pw7YXGVKVODKHWgFlrsyTRLa6mKFgZ+dQF90ZUWqA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 12:04:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:04:58 +0000
Message-ID: <13f3cab1-cea0-4d55-a5e9-ab24a782a437@amd.com>
Date: Mon, 16 Nov 2026 13:04:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu: keep the A+A VF VRAM base at the SRAT
 address
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-7-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261113145702.323968-7-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: baff530c-9bb0-4c3b-4cfb-08df43d9d573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|260925021311599003|260925021911599003|260925022911599003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UF4UaIvY26pnj04hKhMZqVHpsLXGoA3CLoP5dlYJ012ht+GApyvgoZWBGYAShgdXVkeGXdsRSp3Z1PVky5XmbQ62Jxdd+FkfUXtGsHicz4XdVXicZ02DK1RG4c5wAfnbtW3yDF/Zj2/NIOApZCzh4aZ3IOSrprgD/Pqt2T1g1UpmgIZDnC7VtqEyNAArN3V3CvBnORL5qKJmTfi8QJP1X1PGrUFKI0+UB96aIWiupbhroZhp1KDA6QcByi4dpQDzyYQucZUELG/w7672tTOPLBxD0iQULVRm3CbAylEzt8fD9xsgNxw/ASRBZavQ4f/SV0KypUQEFJYoO/IJGlInpFF41X23aQQyUcby2m7tdZYswWEECx758EwUKjvYLI7pSVVerM+BzWdPrphq4dy8bq7QsC5pjZKv527c7c/Gx6XJt+/nJX/XGLGnkTFpbjw4kxylDVmwczfEaWE6fnFriyfJjUX6nRvGx9TcrKVNIuLRgh+YJr95pGIw3DLl3fqUEQi2C1bfNWWs/BqBGozbNImVczz5rFw/khqBNseEg6CJC3ZsZ9NkAzAOJ03lnZvBDf03M3ibHHoOs5d2ofQoSjpTcq7wBf+D3UuDsQjooq66YRlguXD9lXDxyCPQXTVs4BYO+9gl0G8SoVUthiFWW+gtAH+yr83athuyC+JNMeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNqWElna3k3dEdSbk0yU1h0TXp2VVBSVEZPei82djZESmtVemN5VEprK203?=
 =?utf-8?B?d2VYZzdwTGNycFliSVQ4ZldISjJhbis4Z3pHdjZ0NERaaHI1WmxMb2ppaGpa?=
 =?utf-8?B?Z1NNMVBUTWdHb201UEtqZWE0VGU1dnB1UGF2U252aStEdkt1VUhaVVpQUlVw?=
 =?utf-8?B?emVnRXlEUlg3eHJ5SGZJWHozdW5maFdnbmFMdmlEUnZudXhwUTA5dDIrQjF4?=
 =?utf-8?B?REdhb1Z4K3ZYaEJpZGNnRjBKSDJQZ1RqS0d0L3k4cjhKV05Dd3VXN3RoL3dE?=
 =?utf-8?B?dzNaeHNtQ0NGQ2txZUk0TXBweGNNajI2L3paUFEyc0lxcWZSanZuWTVvRmxk?=
 =?utf-8?B?QllNL21paGU4WHhjNmVjdEduUE5ucEladlJRckVLMDVudUVnaWFrWmt6ZnNR?=
 =?utf-8?B?UXN4Y3d6ekRUN25JNDJRVnBjbklYc1ZCLzNDcE1oT29sVStrOVZDdnl3RzhT?=
 =?utf-8?B?U3FBcDB1V2g3OXBqWUJvcGdySWF1N0pyOXdoUWdJNFMzQ1ltMmtGTU5vVVgr?=
 =?utf-8?B?ZHp2OEkyemh4Z1ZuaUtmOU5pOTlKRDJEeU9ZWEtzK0xQQlE0VDUyQktScDNy?=
 =?utf-8?B?WXBCNytCa0xXbUZKaTZmcWt4THhGM1g2MEo2L09XR1FEME56QzJ1V1VleHJz?=
 =?utf-8?B?OENWRG1sMEdraC9aeVgyNDYyQ0ViNEl4MGZaVHJqVXJWRkZNMHVTNHB4Q3JX?=
 =?utf-8?B?SXpEVWNKVFBEQ0Jxa0VJYVREbW9hRkVld3d1VmlHWUtDWE0wTk5YQ0dBTTJj?=
 =?utf-8?B?NGxpME5Wc251TVFqNUp4RjQ3LzRLWWhsdS9SM012WlBvdnRNbDRLdnJ2M1I4?=
 =?utf-8?B?ZGZHa1RQRVZDaVRBS3VVMEhnM3FNbGRIVitqc2QvSDRQNnNudWZ4bVJMTmxv?=
 =?utf-8?B?K2djekVOdTE4eUlWYVdFYlZORzQraitoOGZnNXlRd2RIS2ZkWklhTHVKdGNF?=
 =?utf-8?B?aVphb1ZMR1FwN2R2dXlYV0JRazNiZW5COEE3ZnFlcVcvaHRrNUZlaC9wb0FT?=
 =?utf-8?B?V0hUOFRSMjFNcGFMS1RVSjJoZkJ0WGpaY1kycGZlaUR4Ym0wYWNKUmZmcHN3?=
 =?utf-8?B?clpFOHpYK0JDZWxCTERkODJJOXFhT2RSQmpLUVdkTmt5bE9Vc1Fua2ZPV3Jj?=
 =?utf-8?B?TCtNaWRuVEtaNnJVVEZmWjZzbnFlRFVhSmFuQU5zOFBlbVpvYkkwS2VRMVZi?=
 =?utf-8?B?czVoSzhobWg3TjlmMXJwUUxwZ2QzdVZKeTRSWFlBUnpzeE9zb2F4ckNBdmlp?=
 =?utf-8?B?b2VFY1Nxa2lIL1pIdmhRYTBHa2QzemlSMTVsL042V3dUNDhqTGRaM3pMSEZY?=
 =?utf-8?B?NGFBdnpXcEtaRnNwSmc3bTEzcnlJMzd1TmRXWTdZbFFnVXF0N0d1bmsyQ1JO?=
 =?utf-8?B?YTJxdHR4NVBZTXVGSWxELzZ2N3U4ZmtXNUFTVCsyYTlmVmJYZTZYKzc5VGJP?=
 =?utf-8?B?WFhUYlY0alBualNiMnNzUVp3anVWeElrdUVJVUQ2NWwvRWJVNGJKNHNlUkRM?=
 =?utf-8?B?ZHNFdG9LZE02MkNYSG1tVWhMK0p1R3BCWDJITjhmd2V5U29NWFIwdGZoSzY5?=
 =?utf-8?B?V3M4L1JOK1hzRmwwaVZCUlVlZGdXYnd3bEJ4VG9GSzJTNjE4TG44NnZDQ2Zh?=
 =?utf-8?B?L1lheVZFS041aW1zRzRuRjhpbTM1azdabm1VSmRBK1VKTWx1UnIwZHlIbmY4?=
 =?utf-8?B?cFYwMkNsRTBOQ2JLa1dhc3JwZ2dzSy9Fa0ZIS0J3Nk84Zkk1eVRhcHdjc1Z3?=
 =?utf-8?B?clhCb3hINVUrWDhnRndxUTRTNUlJWFcvNGVscEtjM1hvNXFpSHBnaERDWGgv?=
 =?utf-8?B?cTVuamYwdEZSK29zcmpvNjNUQUpraGpIb0dSTFBFMTN5N25IbUEzN0lFZXFP?=
 =?utf-8?B?WmJzU2Jwei94OGdDSDV1bXc3K2MzOTRqcjNQZEl4TXYyMWtrT2YxbVFSNnNK?=
 =?utf-8?B?bzBkZkRoaGdVZ2MwTE5XODZQU0h2K21XOEsvdGdrdkVvbm40cEh5YzZXSW8z?=
 =?utf-8?B?dVFSTXprT1hxbk4zQU9SQW9vZ2dDUVhmN0Jnc0JlM3V6QW5NQnFONmpXU3pr?=
 =?utf-8?B?d2dCY21ldWZyeXlTVkVBREhKL05MWUtMbTl1bXFxNENjZWZnamRVaWp3Wk5V?=
 =?utf-8?B?YVV4d25OcnFSdTB5ajdBbmM1aEZXQTJ6MkpjRWFvd3NKWTl3Rmh3MnVnS1hs?=
 =?utf-8?B?aSsyWnIzNFFTb28vUnc4ck9EODh2RGpVdkRRc01JWHRqQS8vWkJFMXJaU21X?=
 =?utf-8?B?aGUyQ2dJWGt2VHRSOHNUaHRVbzNDSlZMaFhXSGRFa3JZL3Y3Y3dXajNBN2g4?=
 =?utf-8?Q?eSIr8hoFCEi0lUnnH+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baff530c-9bb0-4c3b-4cfb-08df43d9d573
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:04:58.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgg66u6Y97Dq02N4jKSePi7OUCISDQ1xr8+8BN8ytAGMVSyMImEqwCinlhtPiNvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

On 11/13/26 15:57, Zhigang Luo wrote:
> On the A+A VF the hypervisor reports each VF's VRAM address and length
> in the ACPI SRAT table. The XGMI LFB region and segment registers
> describe the physical GPU, not the VF, so the node id and segment read
> from those registers are not a valid VRAM starting address.
> 
> Read the SRAT entry in mmhub_v4_2_0_get_xgmi_info() and report the VF
> as one physical node at id 0 whose segment is the SRAT length. Save
> the SRAT address as the FB offset. get_mc_fb_offset() returns that
> address, and mc_init copies it, plus the node product, into aper_base
> and sets aper_size from the segment. Node id 0 makes the product zero,
> so the PTE base stays at the SRAT address.
> 
> v2:
> - Explain that the SRAT address is already the VF VRAM base and must
>   not be adjusted by the XGMI node segment.
> 
> v3:
> - Report the VF as XGMI node 0 of 1 instead of special-casing the
>   node offset and the PDB0 size.
> 
> v4:
> - Read SRAT in get_xgmi_info() and derive aper_base and aper_size from
>   the FB offset and the segment size.
> - Move the 8GB GART alignment into its own patch.
> 
> v5:
> - Revert the SRAT aperture commit with the other two reverts. Leave
>   mc_init on the restored connected_to_cpu path.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 25 +++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index d17055d4c50a..1772c9f5c940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -231,6 +231,10 @@ struct amdgpu_gmc {
>  	 */
>  	resource_size_t		aper_size;
>  	resource_size_t		aper_base;
> +	/* SPM VF framebuffer offset from SRAT. get_mc_fb_offset() returns
> +	 * this, and mc_init copies it into aper_base.
> +	 */
> +	u64			fb_offset;
>  	/* for some chips with <= 32MB we need to lie
>  	 * about vram size near mc fb location */
>  	u64			mc_vram_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 5f36aff17e79..47092ec6dff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -79,11 +79,13 @@ struct amdgpu_xgmi {
>  	/* from psp */
>  	u64 node_id;
>  	u64 hive_id;
> -	/* fixed per family */
> +	/* Segment size. Fixed per family on a hive. On an SPM VF this is
> +	 * the SRAT length of that one VF.
> +	 */
>  	u64 node_segment_size;
> -	/* physical node (0-3) */
> +	/* Physical node, 0-3. An SPM VF is node 0. */
>  	unsigned physical_node_id;
> -	/* number of nodes (0-4) */
> +	/* Number of nodes, 0-4. An SPM VF reports one node. */
>  	unsigned num_physical_nodes;
>  	/* gpu list in the same hive */
>  	struct list_head head;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fb..b19f5b601d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -53,6 +53,10 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the SRAT address saved as the FB offset. */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		return adev->gmc.fb_offset;
> +
>  	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
>  				  regGCMC_VM_FB_OFFSET) << 24);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 7e0b83b1015f..14ef841d7036 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -707,7 +707,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
>  			amdgpu_gmc_agp_location(adev, mc);
>  	}
>  	/* base offset of vram pages */
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_vram_is_spm(adev))
>  		adev->vm_manager.vram_base_offset = 0;
>  	else
>  		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 4495d52b4b07..8593453445e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -132,6 +132,27 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
>  	if (!adev->gmc.xgmi.connected_to_cpu)
>  		return 0;
>  
> +	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION describes
> +	 * the physical GPU, not the VF, so report a single node. The
> +	 * length is the segment size; the address is the FB offset.
> +	 * aper_base is filled from those later.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		u64 fb_offset;
> +		int r;
> +

> +		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
> +							&seg_size);
> +		if (r)
> +			return r;

That looks like this call here belongs into mmhub_v4_2_0_get_mc_fb_offset(), but you need a size for the xgmi.node_segment_size.

Either call this function twice or just make adev->gmc.xgmi.node_segment_size big enough so that VRAM will always fit into it.

What I'm still missing from those patches is modifying amdgpu_gmc_is_pdb0_enabled(). Where is that done?

Regards,
Christian.

> +
> +		adev->gmc.fb_offset = fb_offset;
> +		adev->gmc.xgmi.num_physical_nodes = 1;
> +		adev->gmc.xgmi.physical_node_id = 0;
> +		adev->gmc.xgmi.node_segment_size = seg_size;
> +		return 0;
> +	}
> +
>  	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  				     regMMMC_VM_XGMI_LFB_CNTL);
>  	seg_size = REG_GET_FIELD(
> @@ -177,6 +198,10 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the SRAT address saved as the FB offset. */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		return adev->gmc.fb_offset;
> +
>  	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  			         regMMMC_VM_FB_OFFSET) << 24;
>  }


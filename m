Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A30AC7EE26
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 09:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0115010E23C;
	Wed,  3 May 2023 09:33:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93BA310E23C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 09:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ9oO9gaoBeFt3BPD3k8vCGtdxOx3mz7f5/hxdkzC/Qo1IPwn1Hp8vKlp++S3pv8VUbdXBW0diM9azO2NjhpPzmbqhIYj0YHg/eE742bXf51ZWmiyz+pu49G83iDGDZFhSQltKcVn57eIWP99f0E1UUl1yO4NWwPFdlOzmgbFBNi62rlFHOTvM4Eyxmz77nvXES1zH+fDtwSUWS/S92YLwwuYxi+wc4asOpFxyUlHMkTvJ2k+sTXYusX3OyU2FGxHb5tcF4ZxxehT83uxRKQDmDuOG2UrLDmwKsxC9xT4Ao4ZflCWeHX5L0nmGH8a+Y+ILdMjXZVlUnpUQOewu3GKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT8tijKnzX96ISIoDC7wE4SUltc1rHj0kVJ9K3QFy74=;
 b=Rpe+CB1fVhEQ8BTyzkEMkMxe892Lwphq0V0KgKHaFP+rPQwGrf5j2EjIZl73CQDaYKShsBEidjYWAeI/3H5kESNySqz+rXTckxLguVhcepa2AWZkldFVd4pldTkRLBfqtOTCzb82mu0nKwMv4WmWnO3rGHZzzLjTrHYSfbqRKSaNlxO2x1OnSD2uZ5z0j+rcerhPaSfSEyyMVYX+Qv0O7yhmLLdXMD9zjOHPNKbSaF3L0XyXbeqb7V3JL2PreSmMEyyZMxLms+4WbZPIsIoeT+2fzLGSNU6GEHyFs3UQf87K0YEnpll7Kr2mV1xHUh59qgn1lTMffEp4FkxOaqh+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8tijKnzX96ISIoDC7wE4SUltc1rHj0kVJ9K3QFy74=;
 b=IIGB7XXNaDi6dtKNFww1+uHrnaaOyWqwmYHkeiyikBXJ1eXbfjJnmw/C3mDFm2igTSi9hJvZiXiKFT9kqxj8givllvkDzFhKURpAgbImgcYG5OrQkw2QM+Den/AmqoU+CAhpAT6En0WiOrjezD4z1Nn9um98WbsfuVo/dzCOdSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 09:33:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 09:33:28 +0000
Message-ID: <55c1427c-027c-0046-e75d-b5f75ab9906d@amd.com>
Date: Wed, 3 May 2023 11:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix errors & warnings in amdgpu _bios, 
 _cs, _dma_buf, _fence.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230503090025.1485900-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230503090025.1485900-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a37db7-fa51-4735-9462-08db4bb9734d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4f7VgfEx2xPHel+e/KfFjPtDTWIAOEi7mAXk+keGkgatq0DGhpX6DTaxL+fJFhX80wiFa3+O6GMbqcxmmm2MWUOiblTGDv8VHeloz4sl+JNSPDC93RVCTGF0OMWpRABRbydLIQGYSY8G9RxPqIaaypjRjRJOEzxfdety2o6ET8bJkANgqjiVHhAjrqL25ygrAiEXKilPDlsQFFyLRSv5zxDukjGrYsXBPDRmhbjwVgdm+j10h4qTAKvTZTQthZaM2nuGR2ZBibpBmfNQddIsUyKT8lKTz3w0By63ycELSxioS/qXuKc0g0dAyHTwgjbecA+siQpuVD4hAifd1ogy5ay4h0yIuz6kSWP/5qXSPWJ5WfAl7HQjFV6QrqGWBjzbOEOEP7WWEinS/0A5Y7YtyAsdQbKBSba+Gn/Z3Eqy7M8gdCWztiNxy9eHiGkSWQR8Uve5sI1rUa8z7ZCrH+TNlkwP0am8dPXJakeNMiAihiZ/cmg12kAQKrOVQzOdINr6hjg9IYvPbRaurrlS+6KGqDt3Y1SMB0XhEWco7MPVL5uIIGJrJzQQz+cdiHUeFNuFW2MQZBIH8NbqcYB/ysTuu3DqVOFN1K4TYyPr8Gm9Mk5afyGQwsyMhHzTWiS39H2+5VDokkBjuB080JA94/L0A+dhxj7VL7USyEQIAd6E2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(6486002)(36756003)(86362001)(6636002)(110136005)(316002)(66946007)(4326008)(66556008)(66476007)(41300700001)(478600001)(6666004)(5660300002)(8676002)(8936002)(2906002)(2616005)(31696002)(38100700002)(186003)(6506007)(6512007)(66574015)(83380400001)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHp4SWVnTk82YnVZb003b3JiZThMd2VuaGs2WHpuOTkxb0FaVmJhd2VHN3FQ?=
 =?utf-8?B?bEszeVNrNzhMVW9maHNzaWdTbFQveGN3a2tvZytCemxpd2JpSnB3ZnVtcGYr?=
 =?utf-8?B?QnRkc0hIMmtJQ2cxanZvSFZkcVJxa2JtUjZxSzBnSzJPcUljLzNtRFMyQ1lw?=
 =?utf-8?B?WDBqWFBQNzVEM2R0NXNvZWxDaFM1dG9UL1diSnY2SThyS2pnMzY4SDVFMVdK?=
 =?utf-8?B?STJXOXM4VGhLM1ZoV3JQMW8vdUZCN1M5eGdaZXAxKy9aL2RUY2FKbWJycmVD?=
 =?utf-8?B?cHI2UGtDT1lrV2lUQkVBeXdkV1IwR0VpUFFuWExhaHRrdjhoWXpoMklYR3FC?=
 =?utf-8?B?cEliaVRDL29BS3d5SXVCdnc4QkIxRVd4RDN5eWdhQ0JDSzJ4eE1WbUxNcm1F?=
 =?utf-8?B?ZzhVSElNNHBqMy9ROWZWVUZaK2ZqY3ovN05vVnZQZEdoejhRMEt6N0FESEdF?=
 =?utf-8?B?ZFI2a3pxZWk5TGxTYTVpQTBkeXd2RVJ2d05JNkQ2VVdVSVhnWlRSeFQ0Um9l?=
 =?utf-8?B?eVdzSHRlbDUzUjdEV05MMmpKMVNhVmFaVzRqU3RlQytxaTZRZWQwVjBnbmJy?=
 =?utf-8?B?cnc4L0VrMWE5Z0szREk0SlJGeUxVQzhuelRtcjJZQ0c2eHQyMU1taWdPeHNT?=
 =?utf-8?B?cXcwdTI3OTJubnJtaWJUK3d5M2w4eEZZNjNTdGxqVUxoNlpvZytOMEVwcXZn?=
 =?utf-8?B?RjFwNmd3N1lzaTBVZ244NXZPYlJiQUplTTBCZkVmS1dYYWVXVjhTSjFRZUx2?=
 =?utf-8?B?MXNJZ0JGZDhHL0QwYUZpQWxQUlQ5cUR5b2x3RlNrWlQ0ZUtZWDNPanN4QUVF?=
 =?utf-8?B?c25zOFBsVjRUWVR0cVJSOHVGTHNGdnpCcHhBVG9zSTVqb2FBaHA1eitta3Vj?=
 =?utf-8?B?Ukt1QVFoZ1E2VkJQRVFVK3c1eXRTWXU4azQ0OVkxOTZIRXM4T1hlRmFHa2tE?=
 =?utf-8?B?Umw0OXZQVmV5WTlUVHlvSUtZazE0clpRWk1DcHN2QktQQlA1U3F4TkFEUWlu?=
 =?utf-8?B?Z284K1Nyem1GT1pKSlF4RDR0YXRIc0dOdXhnR254d2I4Z0hraTdjUUtaVDlw?=
 =?utf-8?B?S3RxOTF6RFZCa212ajBDL2Z1LzBGUVNzeTh4QnMxY2dBZW9aZFYwU1pqTmJp?=
 =?utf-8?B?ck9zREFobzhuS0hpcDB0a3V0VG1OYzZ1RUpnMTMrWnBnQ3JhMVExaFU5MVM4?=
 =?utf-8?B?SGQvSC9UcGlINFhJK1FWNEdGdW9CNm9PY016dmVwMy9TNXdRUEY5bjBpWEty?=
 =?utf-8?B?Q3VSN29BNkh4N0lmVHE0bmMvTGFZc0M3UzVZUThQTTBPeUNFTllBdDNVT1NG?=
 =?utf-8?B?Wlh5UGF4UFk5SDREQVpMZ1FnZHd5c2pYUnMyMWdHODVQeDEyUldQbFNpcjRI?=
 =?utf-8?B?OUllNjEzUUpOS2NJNlpoazBkeXg1Y1FuQW1CNmJMT01YYmFaOW45d0ZHL2NF?=
 =?utf-8?B?bXhKOFZCRGlrOHFnZmhnZ0R6cGo5MVp4NHpwTWRqZlptTWZvV1BlQVRBSWpH?=
 =?utf-8?B?UjZDdTYvTGkrb3Z2elQ1a3lXcW1wZkU2Zm1qZ3lKWE5mdDFTTFFWYlVyZkFP?=
 =?utf-8?B?TUp5ZVlhRWpKdGxCWGFUTDc4cENOczlNSWs2enIwMmJQd3QrVWpMRDd2WnNB?=
 =?utf-8?B?VGRpajB6WGt3bnE0ZjkrQXVjbVd4anNGNzhJVVN1WFhzTjBqVkZkeW4yRVFD?=
 =?utf-8?B?STlzK3Z1czE4dlJFcjBrWXhpV200S3h5VUxwUUw1ZTdUdXBsY0hwQm1ITUFs?=
 =?utf-8?B?eXJ0czZZRnJrNUZ1RXJaMzFhdlNUdCtKaENURS9RWUE0OEFiNkxsMDE2c3ls?=
 =?utf-8?B?KzR5ek5Ca29nUkEwSER0d2JJNmhHZjdQaUpYZVBXeFhZUnV6RjFVVkQvajg1?=
 =?utf-8?B?MWN3REgwVk9Jb2IzcmhxOWxoSzYzRytJdlRUS0lhK3JtVkdyeXJKMW9xbC9O?=
 =?utf-8?B?c3JEWGVEc0xHK0NuVmo3cmdsMkQxNmgyWnN1T0YrYitOL3pwTW0wQk4rSCt1?=
 =?utf-8?B?c2FYQ3hDZ1kvdk5kUUE0N3k5ZDRKY050QnVaZFVyRHBsRmFLbFpKT0g0NUZ1?=
 =?utf-8?B?YTM2elFYQ3JwK2h0dm9KRDNrWkFTaEJlS3RoNVU0c2pEYUZMTnJpRTQwR0li?=
 =?utf-8?B?N1l0a0VpY1ZiaWtIamRVeTZQUUZYcTd5QjRQZmVtUk5USGk5V0NPcDV5OWF6?=
 =?utf-8?Q?3IjhT7RxqkHc8HCSIZ+dkAAFIorc/DVQUCAIbndUWMY6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a37db7-fa51-4735-9462-08db4bb9734d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 09:33:28.0514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W42VhQx6HxwnxeX8plEDlUlOXDVfTenLIJR18PiLkBsSBrp2+M3fkpQtZk6/uB3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.05.23 um 11:00 schrieb Srinivasan Shanmugam:
> The following checkpatch errors & warning is removed.
>
> ERROR: else should follow close brace '}'
> ERROR: trailing statements should be on next line
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Possible repeated word: 'Fences'
> WARNING: Missing a blank line after declarations
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: Comparisons should place the constant on the right side of the test
> WARNING: printk() should include KERN_<LEVEL> facility level
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2:
>   - Best to make the word "Fences" one line from that. E.g. "/* Fences mark an
> event...". (Christian)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c    | 16 +++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 14 ++++++++------
>   4 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 30c28a69e847..b582b83c4984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -104,9 +104,8 @@ static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
>   	adev->bios = NULL;
>   	vram_base = pci_resource_start(adev->pdev, 0);
>   	bios = ioremap_wc(vram_base, size);
> -	if (!bios) {
> +	if (!bios)
>   		return false;
> -	}
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
>   	if (!adev->bios) {
> @@ -133,9 +132,8 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
>   	adev->bios = NULL;
>   	/* XXX: some cards may return 0 for rom size? ddx has a workaround */
>   	bios = pci_map_rom(adev->pdev, &size);
> -	if (!bios) {
> +	if (!bios)
>   		return false;
> -	}
>   
>   	adev->bios = kzalloc(size, GFP_KERNEL);
>   	if (adev->bios == NULL) {
> @@ -168,9 +166,9 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
>   	header[AMD_VBIOS_SIGNATURE_END] = 0;
>   
>   	if ((!AMD_IS_VALID_VBIOS(header)) ||
> -	    0 != memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
> -			AMD_VBIOS_SIGNATURE,
> -			strlen(AMD_VBIOS_SIGNATURE)))
> +		memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
> +		       AMD_VBIOS_SIGNATURE,
> +		       strlen(AMD_VBIOS_SIGNATURE)) != 0)
>   		return false;
>   
>   	/* valid vbios, go on */
> @@ -264,7 +262,7 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
>   
>   	status = acpi_evaluate_object(atrm_handle, NULL, &atrm_arg, &buffer);
>   	if (ACPI_FAILURE(status)) {
> -		printk("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
> +		DRM_ERROR("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
>   		return -ENODEV;
>   	}
>   
> @@ -363,7 +361,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>   	struct acpi_table_header *hdr;
>   	acpi_size tbl_size;
>   	UEFI_ACPI_VFCT *vfct;
> -	unsigned offset;
> +	unsigned int offset;
>   
>   	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>   		return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index cb771c73cd07..c5521f9953a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -395,7 +395,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
>   {
>   	struct drm_amdgpu_cs_chunk_dep *deps = chunk->kdata;
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -466,7 +466,7 @@ static int amdgpu_cs_p2_syncobj_in(struct amdgpu_cs_parser *p,
>   				   struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -484,7 +484,7 @@ static int amdgpu_cs_p2_syncobj_timeline_wait(struct amdgpu_cs_parser *p,
>   					      struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i, r;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -504,7 +504,7 @@ static int amdgpu_cs_p2_syncobj_out(struct amdgpu_cs_parser *p,
>   				    struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -538,7 +538,7 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   						struct amdgpu_cs_chunk *chunk)
>   {
>   	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
> -	unsigned num_deps;
> +	unsigned int num_deps;
>   	int i;
>   
>   	num_deps = chunk->length_dw * 4 /
> @@ -756,6 +756,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
>   
>   		if (used_vis_vram < total_vis_vram) {
>   			u64 free_vis_vram = total_vis_vram - used_vis_vram;
> +
>   			adev->mm_stats.accum_us_vis = min(adev->mm_stats.accum_us_vis +
>   							  increment_us, us_upper_bound);
>   
> @@ -1074,9 +1075,8 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>   
>   		/* the IB should be reserved at this point */
>   		r = amdgpu_bo_kmap(aobj, (void **)&kptr);
> -		if (r) {
> +		if (r)
>   			return r;
> -		}
>   
>   		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
>   
> @@ -1390,7 +1390,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   /* Cleanup the parser structure */
>   static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>   {
> -	unsigned i;
> +	unsigned int i;
>   
>   	amdgpu_sync_free(&parser->sync);
>   	for (i = 0; i < parser->num_post_deps; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 271e30e34d93..e97b1eef2c9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -148,7 +148,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   	if (!bo->tbo.pin_count) {
>   		/* move buffer into GTT or VRAM */
>   		struct ttm_operation_ctx ctx = { false, false };
> -		unsigned domains = AMDGPU_GEM_DOMAIN_GTT;
> +		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
>   
>   		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>   		    attach->peer2peer) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index a7627cc0118d..5d96f630a3aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -42,7 +42,6 @@
>   #include "amdgpu_reset.h"
>   
>   /*
> - * Fences
>    * Fences mark an event in the GPUs pipeline and are used
>    * for GPU/CPU synchronization.  When the fence is written,
>    * it is expected that all buffers associated with that fence
> @@ -140,7 +139,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    * Returns 0 on success, -ENOMEM on failure.
>    */
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> -		      unsigned flags)
> +		      unsigned int flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
> @@ -174,11 +173,11 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   				       adev->fence_context + ring->idx, seq);
>   			/* Against remove in amdgpu_job_{free, free_cb} */
>   			dma_fence_get(fence);
> -		}
> -		else
> +		} else {
>   			dma_fence_init(fence, &amdgpu_fence_ops,
>   				       &ring->fence_drv.lock,
>   				       adev->fence_context + ring->idx, seq);
> +		}
>   	}
>   
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> @@ -396,7 +395,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
>    * Returns the number of emitted fences on the ring.  Used by the
>    * dynpm code to ring track activity.
>    */
> -unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
> +unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
>   {
>   	uint64_t emitted;
>   
> @@ -475,7 +474,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>    */
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
> -				   unsigned irq_type)
> +				   unsigned int irq_type)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint64_t index;
> @@ -653,6 +652,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> +
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> @@ -865,6 +865,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> +
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> @@ -938,6 +939,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   						  reset_work);
>   
>   	struct amdgpu_reset_context reset_context;
> +
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
>   	reset_context.method = AMD_RESET_METHOD_NONE;


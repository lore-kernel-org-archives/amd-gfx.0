Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90D1CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5257E10F24D;
	Wed, 30 Sep 2026 08:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eWLA0cLP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3416410F24D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+IO7NGg/O3FnkhPrRgNRa1pnJjF+MolECFTU/HU4pVoc+8Y/3LAoQHVMinKCemv1bboDfF6b3cymcS+clYEjKwaPsNcCj0XA5xJTuePqaj3Hs0/vjf8i4uzZpn05Mi4YYwa1wxIZAqnVmL5tqvpioCE958PEAjFUVaI1IdbJPMp1pxeJYerGi+Pl9SA1FybxH+avDc0EMVCWLz0h62vHI6XhUwYhyNaYYuQ8uOLrb5xYSbCwbsYdvigzafaWLELS8YetDT4ZNPIPFApM+74rDcHX5+r66G42xVo/+5+uq4rF7J5beVA0lifAdR29sK40IqKdGv8DcnhVzh1YoOnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvRVjLW/ZlzV0TWgLKQ3hNTAaEUHJ+kbP05PWkiABs8=;
 b=FodfCZQCpxoA90RBOwXYt2+YxhExwczvAIpA+f6YEDjJ3uiAkOkFqQkWi2CkM5YCCIP9Rklm4XSzpIbCeGH8PqjXyDx13js8cnlWbzYsI5k3bWpkDZhlflXvAV0WV0rhIJNRtEMsLZskqQ7Y6/uMwEstvbGrJzyMu06X7NrDp9lw4lJ+8mVyMNAULwjgkbMpLPD/TVWwN3VwS4W0XoMe0JI0tdVW7JrQQbCk8oN+UONzzbNxmz24ubJENpmv3WvzGSr2WaBkEETEPtdcRThCAW+eVzNVr+mG/IcRB92R9RsU6e6Bsmdx/oulY2zvJhymLRw5MV4Kb/LrLX660d4tRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvRVjLW/ZlzV0TWgLKQ3hNTAaEUHJ+kbP05PWkiABs8=;
 b=eWLA0cLPHhGlPJ+rr4DX45UijqDmR8J74xtijT/5hTJ6nEmCvqIRr97CSZ9BuNHToxW//ekjleBKnGNKaiuSVQG1tK3adaLZQoCPUqHit6/uLCJwY1RT3npRamPGtZm/fc7UsEsulO4DYF6uLL7MRbWzEXYijI9iD2ecRVYdKoo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:43:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 08:43:27 +0000
Message-ID: <ac39a9c2-64f4-4547-ad5a-fcba0cd1c039@amd.com>
Date: Wed, 30 Sep 2026 10:43:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/userq: only accept doorbell BOs as queue
 doorbell
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260930083148.151311-1-Jesse.Zhang@amd.com>
 <20260930083148.151311-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930083148.151311-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:208:234::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 04761c1a-d896-44ce-89a3-08df1ecee5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5FI4PNdbkLmvxw2DNY+G4Rz7Aev2+nnLR0VSk+qHL8D7RklZKIBejHIj+PQ6XR0Ra76t5pNH0wvMcqHzkdLizFGe5N4CB3cNs2cnyUa6FFB9V4K75Wj6i4DtpS8gGjQGqa0bB6H5e5NYWMAwjzloKZDlmRX7H9Or5c4egx8Ww5pvM47m0E2tpw4k/lrdqDl6QGzh5i+6fKTXyNrH1L9/wIOrT/jCs70xnOzhHy4JRGXLKrAFxnCGDMw778RNUj3CqZGLyGqD4407PR0m0gPSl2sBt+s9SlmHfcuRSR4wf+gMcF8X4exh00j3iEXeAWPBa5n1qRwPC9yG/BvfJK2u803b4MltOPXVkqOR1aCcL0yexdDXqh/3U8B72NxE9RsdwZsRghK0cASIib/t2liFLlM5j9PjXViXiVMWN4CfpDWl1YZPP7qf2Sx0M+A+PxgW3o1Ub9HPKIpMt4tZ7sP/Q7C7OznbdGBWTzmUpHXDHWZgLRKADERNCFKj9Ha+pUyBXdWB8ZK6EFVXoP4X0y35pvdVxIdllK73UGTflCxGEP6HpRWP4vKe0OOqjFjvj610ou7iFia4F7gPqlHtcBG6mmaslDJZXg7W81fl9GbMhNdQfDUdOIyzNLX1FoXrKL6DenfTqBtmQ8NkNuGHNv/BMTtEzysv/0bUq4hfmK5YcXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHcwcld1VFpRSDdzSVNjR0Q2REdCaE1KZDVyWVVWS05DZGJqZThRb0JmeDg4?=
 =?utf-8?B?NXRvdUM5RE9TWlFSSjNXbDI2UTVVMnB5TUxzU284bGhIMVFlWU9Semxzd0oy?=
 =?utf-8?B?TmU2MEpJc1ZCY09SR3RFTmNEeDZKYWZSeDI4NXRQR0ZEUDVlbFZtR0k1b2Yv?=
 =?utf-8?B?YWJ1UFlxTEszaS9DQnluUmxGNkNaNnhPcVptZTFGc1p4OUxNcWE3aEZ3NEdj?=
 =?utf-8?B?bVFyOWliRnRVYUNkRXE0c2JJNWRUalFGS0U3SEZaTjZWdkloakZzb01JbkhM?=
 =?utf-8?B?UEdMcldqYXVzQ0RMQjhSYnhtalVGOEFScmV3SlhOUmx0QkZHcjlFLzRUMVFP?=
 =?utf-8?B?QytnNERCVVRrVjZOanlraFc2WXZkWmdSVk5CTThzL2d4RXJDTzYvU1ZOaTk4?=
 =?utf-8?B?UmNzc2xpR1ZUUjV6OXZscTB1dkVYMU1LU1JQaE81eGlzcGRJQVJmWjBnSW94?=
 =?utf-8?B?eC9oL1NjQ3o2b2RBTEIyQlBtNVF2bUhVbkxMcmowWnZzWFUrREpzZm5lUE5v?=
 =?utf-8?B?bERLSVRUV0lwNFRtV3dnMU9VWWZjOFBjMlRhc2Z0M1FWSldZckQzZmlvNC9Q?=
 =?utf-8?B?ZzNVMHFXR2xmTnlUR1k2ekxLakN3eCtPUExXdTJ1MFg4c1I5MWhTNm1pQUh4?=
 =?utf-8?B?dytneldEbEY2czU2ZG1ROUlnK0xOSkhsLzNMT21Ua014eExlYlNhMGF5WDFy?=
 =?utf-8?B?Z095Q3lKUEM4K0FjWmp0VGJNZFJZKzRQcFI3Q2hGMDRpVEM5dTNWY0hpaHFW?=
 =?utf-8?B?cWNzY1RwU1JNcklNakdLQkUyN25YRnMrUmJIWGNyU2tRbzNWSE9jT3B4QzlJ?=
 =?utf-8?B?eEphME0rTVFyQ1ljVm9EUit1OE9lR3psTHAweXFOYk91MVE1bnBpd240TjIz?=
 =?utf-8?B?NjNvYStnc0s2ZzZwSVZkNFR0ZW05b0pRUmcxRm40cGFWMDQzTi9wWVhla3Nq?=
 =?utf-8?B?ZHFmNXo3dHIxb25EbWEyUExJK0h6UXFuaHJSM3hURjErWUxTOGhZSlMwck5y?=
 =?utf-8?B?MWpwcEVzN2xJeTRkUkpkNGNuakFwc3hlOTU4OFZJb3E1cGRLTjN6RXhYdGwr?=
 =?utf-8?B?aVkxeXJKNDNMMlhhN1NuNjVOaDhqdE5PbUFDZU85V2MrUE5zeVI0WUhneHRj?=
 =?utf-8?B?RGszY0RENmZMN1dKaFZhY3RsSTBCV3RHNmtRdTV4QXd2b05JMCtHNTA4aGZy?=
 =?utf-8?B?RThMdlBQRXJzaHFGMEJYUUxXcnBZRHBjV05jTEs4TXkraThWQXBOZVFLOXVl?=
 =?utf-8?B?dVFlWmR2WTdWdGhzRUN6MVMvMWMzcERFOThpblFWNVZMenBNVXNrQ0cxR3g5?=
 =?utf-8?B?b2tQZENURlpocGVuWWdoaVBOMW1Ga0Z5Qml4Q3lXWXVTc203N0p5aTFvcEdI?=
 =?utf-8?B?Tk85NGxjTGc0K1pXdUg4bjI1MmJxdnowNVVEQThKQWhrVEU1SjFtbitDbEJO?=
 =?utf-8?B?OUI5RVlHZDl1aWdjMTVzV0VIbnRZRjJZeFNURmZQMFhIZXIrVDZjbXY5cW1M?=
 =?utf-8?B?SE1EK1l3MzYvVGFvQ2hGb21remRmVXU2TjgwbHoxRDFvbm5qOHUzRGhpa0ZI?=
 =?utf-8?B?STdVN0F0WmhyYURDR25tY1hxRWUrSG9manJscHYyZzhkdXhLVzhUcHdxVXlo?=
 =?utf-8?B?andjUk1YdG93Nkgvb3llUEVjbWhwZjNXZ25kZWhnMUE5ZWZVRW45RVBDa0ZO?=
 =?utf-8?B?ZVFzR3ltWXhBdzZ6WEpUOFBMNi91SllrdEluY2MwT0JxUXR5WElxSUhFd2k0?=
 =?utf-8?B?ZDBqb3A3T3FXU0R3QzlObEMxdjNRWG9LVWRndzJCakNNNXVyV2FCYXRYaWtC?=
 =?utf-8?B?ZU1NTjBWWUhualJHSHd2MlhibXFoUjQvYklkcjlrMU13SGwzTUt1V0JXdXJu?=
 =?utf-8?B?alVUK1UyeHh2OGtCMkhqS1diZFBOb2JYMmN2eW95V3JrcXFEQkdxRThrM1lV?=
 =?utf-8?B?OFd1Yko4Z1hGbUlETGJLV0V6MkdlNUxzZ1gzMTR4N1pnd09GeHFRNXB5K1pW?=
 =?utf-8?B?OUNJbXdjV0lUTWpPTEZBZk9rL3pPTEtPSkF1dDFYSXBUK1l4QzQ2ZzVyQWVm?=
 =?utf-8?B?VDR6ei9MaGNjdlk1RXpPZGcxbkorTCtGTEsyS2FMSGZwTXBCVS9OMkJKMW5W?=
 =?utf-8?B?Vm0vNUJWdTF2VEhjTWVWQ3ZCS2NDQXlWUXZrdi9RMjV6MmhsUUlMOGk2Ymg1?=
 =?utf-8?B?eDJpS1liUUY1QzNKcy9FSm92OVNXZFNkR3hNbUlxM3laU0tJOGxvSEpzVi9r?=
 =?utf-8?B?dzBQMittY2x0ejM5YUowVm1YV0VuSUJudDZ5czJ4emlaZk1mUEkzMitQR1RM?=
 =?utf-8?Q?V8eR3S+LckPXedCjuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04761c1a-d896-44ce-89a3-08df1ecee5bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:43:27.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrc3X2sN74LI1vFtYFG2SJnkFn7uM5tBTcJiCChCk/rDWXJoMxts928D+INePje4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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



On 9/30/26 10:30, Jesse Zhang wrote:
> amdgpu_userq_get_doorbell_index() pins any BO passed as doorbell_handle
> into the doorbell domain. For a regular BO, TTM moves it with
> ttm_bo_move_null() and its contents are lost. Since an importer on the
> same device gets the exporter's GEM object, a client can do this to a
> buffer another client shared with it.
> 
> Reject BOs that were not created in the doorbell domain.
> 
> Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 89e03d3a930c..a5733a18dc52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -477,6 +477,16 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Pinning a regular BO into the doorbell domain would discard its
> +	 * contents, possibly those of a buffer shared by another client.
> +	 */
> +	if (!(gem_to_amdgpu_bo(gobj)->preferred_domains & AMDGPU_GEM_DOMAIN_DOORBELL)) {
> +		drm_file_err(uq_mgr->file, "Doorbell handle is not a doorbell BO\n");

Drop the error message, userspace could abuse that to internally spam the logs.

> +		drm_gem_object_put(gobj);
> +		return -EINVAL;
> +	}
> +
>  	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));

Maybe have a local abo variable so that you don't have the cast twice.

Apart from that looks good to me,
Christian.

>  	drm_gem_object_put(gobj);
>  


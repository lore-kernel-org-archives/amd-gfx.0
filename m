Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2803FC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C13010EBDC;
	Tue,  7 Jun 2022 17:02:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120EE10EBDC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBAFC6/HVZ308vwuQzX4lpM2lAoddUcEjRgZxTMo4N5mKZzxs7WuJn8slX8BKjH/CISSXEO3eAPhlCpWwTVP/vMz7t700F51yhr/vkXONw0t4s6EqOA0daabXXec0fyVYcwYni61BrKv3F+cZowk+piymOZHrwp7RLf5Ffjm6wKYYVjE+sT0gm+PPGfPjHv1q0WJWckyZve+VNwlGd9Y5GNlNrozUYnTj+9Zf9kb2C8w4VElZInRQcjLtrt8JcXOtSM0F/5rKCy+IlgJOMiFfCJ/PlyO0M2q7CgS6L0i2VCF4Iu06SoDEKNfSeM5sqJqpzOdbG6cVQPxGSdrjdx+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utIIphYzyUlYID98U1kuxHYpX2LxBOkCyMfWgMwJuBc=;
 b=D2syXGXS3UaLt2Df991NV9NcNg54YgnObo9ndSuHvRlD+hDMvBEQw5BP20kS9RmvIfGpWk+sYK8OsX9yhjM0S0bCd0bT40l/dKyVR6kUDCurXpSYJ+GPV6dB9kTXKEzBThC5AxE07u8AIa68ZY1tiuFOjq0/ZjDbXAuP61yr1+gtZqDJoO4818RuFuZ8v1Ff2PpFWGAM5aGtezrtoTVQnAYECNFir6szPK5TsnU1iFGdlbjMvrJNeousTFo/JiFrvVu5I1q8kR/q40IBcaH71SySl8CdkhexOXMyHb9dpOXInYKRKOz4CW/5T+8fZdHGN8qxlLSXLrd3pD/V0LyCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utIIphYzyUlYID98U1kuxHYpX2LxBOkCyMfWgMwJuBc=;
 b=34tnFWhvIxWCpLVIPKaK3mFFAq+Uemo6PcP+RYJ1F15h/BcZEfSSccRTkjWsmX9vSgkMMAY57SCwFTUOhVZTYRNpOJFpk3R58tJh7b8JZAgzHF/TE/Ick28Ig/X3nCeui0oQfRyUyV7EyO7No0gQ+rlcNqkkkxDTo+VJ//Lsna8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1886.namprd12.prod.outlook.com (2603:10b6:300:10f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:02:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 17:02:38 +0000
Message-ID: <bed3638b-5b84-e7a4-669e-0c930b66ad60@amd.com>
Date: Tue, 7 Jun 2022 13:02:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdkfd: use existing VM helper for PD and PT
 validation in SVM
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607095947.120493-1-Lang.Yu@amd.com>
 <20220607095947.120493-3-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220607095947.120493-3-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee0e35e-9907-441e-39fd-08da48a786df
X-MS-TrafficTypeDiagnostic: MWHPR12MB1886:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18868170753F57F1265DB56A92A59@MWHPR12MB1886.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kmun1ifeKwD5gICXXmginTXX74JvfC0UzGdnjf6STf9mEIfftn3fcovZ5QpHameNmQ8e5Bie6lUHZNifuy772Bvw15vGgVPudfQZwQX5mc6op3DkVJp/dD7tGXqYc6soeYQYDxZ/552AT8maa+yFjB1HkMjHZQ821+wSUSMBUK0GDFBtMWyy3NlCxa/hUKsLG5EnAz68Wk3mNJxZw0+XscWVnzk+m6k8KjNh8hiSdLVGyF2wp9SZThNYImWfH9fJKfzor4B1P4hNp7uZ3a4vsT+OOrVbmrgRgq3T3kVvqgqxMmwmcQTVM3B+B5ILyObAZjAOrRNDX8xaBgKy49WevRqT+PCkFQdmHDfP8fxKEpSABlc2471imrwyqeMUzDVba62bmHzbOcqwK2E4xTXUTJyN0pBAza/NoBmkXz0OpziVBXsuq0UwOIohnXqmAcQ983E+N1HP5XQPtVgfWKlURcmBXHyZMb7GCHsgJbK2f9hjbIUsGEd5WA9NKpj2K2aPuj3FGX9la5QldE4qHyITUyfKB5+AjQvacS7Jk+yoIYq/AQ5spqWm6hJ2k2Ej8njshvZ6QRA/aObWw6pOGW4eLuDIVkM9YSCIv03sEL1DK61LVWmGZ4uN9SVh7/PlbtngMxLhk1+K4RfCwqFP60p6wjlpFWYP5XhtHfWHCa2J5Prg9Gn5E32Z6E3Tpp7drxaIScEsB+55aaPe+E7NfHR6plKcBUAq1ZotmqeAW3OUXPHlCDDfG7i0Yv+QRLyBL8pK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6506007)(83380400001)(6486002)(36756003)(38100700002)(186003)(508600001)(44832011)(6512007)(26005)(5660300002)(31686004)(2616005)(66946007)(66556008)(54906003)(4326008)(8676002)(316002)(66476007)(2906002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklhUW5USFRVY3VSbG8zZU90cVJsUExYOHBuZmNKOVlKZVZ0aWhjZlhGNEtY?=
 =?utf-8?B?cFhpWjl4QmU3b2FiTlhTVWcxK2o3Tzk1aVV0Y0VPWEdNM2pnejAvODlTREVz?=
 =?utf-8?B?UWxKbzU0Nnc4U3o1NXJBbktqNXJJbjF1WDYyaFhYZjN2ZHBhazJDS0w1SG9E?=
 =?utf-8?B?Z0U1UFkvcDJZQ2c1QlBuVmhITjVjTnpoc0NJTXJ4VVFnWWJoazRQY08xeE1l?=
 =?utf-8?B?a0p4TEV6NVVSMVJmZTkwUEI1cjVlUUNmbU9jT2pGV2p3dFZIbk9zdnl0UU85?=
 =?utf-8?B?Z0xOWS9ZM0M4M1lGVlJkc1pPUVkrNVpReGF3dlhJdXFob0EvVWVjMmpkb0Zw?=
 =?utf-8?B?WlgxbnQzY0VObC9KaHcvaGtyMk13N1FrZ082WWNlY3BhRWg2QnRJaWFsRnds?=
 =?utf-8?B?SEt4Z29HaTA2V05PeXFHcVMvZVU2alByUHN5UTNSM05HZGZJL012a2dFM3Zj?=
 =?utf-8?B?THlpUDJ4TmZqREtzYnpONVFvcGYxM2dYNE9CNDRBeTd5TmRhemN2cnMzK00z?=
 =?utf-8?B?bnlPWFpkREdDSFg2cGNtU0RlT296RlFsbllxZUwyTHF3aWkrN1lhbVZmTVdX?=
 =?utf-8?B?dzJNMFl6ZkMzeTdXaHN0THV3YzlhQzJhRTNsMzJ5UTNudHQ4Z3pSTUJhZnF6?=
 =?utf-8?B?S0J1UDBEb2lYSmpoVXVqYjdiV2gzc0VFZGhOczJzUmRRVW0wYlplWlNSMkpI?=
 =?utf-8?B?cjFKSG9nU0VSVDhSS2dpQWxVTkd3aUlRNkh1a290cTZnejk3ZG9YbXM0ZC9Z?=
 =?utf-8?B?Y2FXYUZ5ZHlBV3RXVTRrUk10UG4zTFBHV042UG9lMk1abnhrWnVjSkxNS2po?=
 =?utf-8?B?aE5TN3Fyanh5dFhmN3gwZ0I4SkFTenFOaE0ya1p2a012L3JubEhEZGZyc3A0?=
 =?utf-8?B?aVpDTytRRlRwZnJaK2t0bW4wbmV5bGd0ZUxOUWRRV2h4a3E1d01UU1dOQThY?=
 =?utf-8?B?WTNoTnJ4b0tQeVVROWtSK0R2QTQvck5oekN1K1dvNW5pc2NSbGtYT1ZTWFVm?=
 =?utf-8?B?UUg0SjhsOE1IYTEveGovS2laQUh1dkJHMzRDMzcvcFl1YnQ1bWVncHJYMlNI?=
 =?utf-8?B?akhJMlNyakxIMWVXUklSY2thdnRiRWoyY3JzMXdwbkFRRzBtREUyeWo4a2VB?=
 =?utf-8?B?cnFKa2RQbEh1dWZHU3BGR0R4akxIdmhwZ1R4Z0VXYnNNU3hUTlZQcXJ2VVZh?=
 =?utf-8?B?L0hRckZrUkJNY3BjdkJYRVRSNzYzZkxmZnpnc3lDekZzci9sN3hmdEFEOTEx?=
 =?utf-8?B?K0FlYThJV3JPNmlJYTVXZ3NKcUxxMWZwNHR3YmhOTDh5QThwanF3SXl6VWMv?=
 =?utf-8?B?Q1VXTlZ2S3Mzdkc2UmRVTnl1K2xYbStiWG9WZkJOTU9LVk1lbWVCaHlSdjJX?=
 =?utf-8?B?cGhtcThKZ1BhSm1Qb0NSSFFuZkZtbWZDVFVZMkF5SUVIN0pWc2ZPNm9EV1Va?=
 =?utf-8?B?QmlRVkcrS09FbllScUVETTU0Vk1zbHZsTTNXSkFGZEQrZ2ZuLzJ3UEo1Y0xn?=
 =?utf-8?B?ZG5reXB1dTIzNzQwOUNFTExqb05zeXZqaE9lQVB2Z3EvTUtaREZWSU50R2l3?=
 =?utf-8?B?djZBT01BRGYxaEdhUi9aZndsdXZQOSt2VG13alZKRmNpZkMwMVQxVWZpL09z?=
 =?utf-8?B?UnVWNEIyUXF3c1J0anBDOHM0aU1NVHRlbDdyZ0g4dUlHY1dUeFdTZFRXWUFR?=
 =?utf-8?B?RWtBQmhvcmxZajVhbXRsMmZleVF3Z3gzMk0wV3hHckhHbXBBdmY5NFZzb3Ny?=
 =?utf-8?B?WldaU0dMbmdub1lSenJsR2xFOFdjTm94UHR0QXAvL2tSdDg1V1NyTG5mbVhh?=
 =?utf-8?B?cjFCRkpaYW9Oc2kwRi82c1NCYTlNbkNpa1p4UXFaUXVpQjhIdUo2S0x1SkQ5?=
 =?utf-8?B?dGlBYkJQMzJVeVlGNThlSWVrTXBjWnhWQ2dlQm82d2psSjV1OWFtOUw2Z0ta?=
 =?utf-8?B?Uk1TRmo2Q3NrTm4rYU05a1pqRVBZSWI1dUI3cVZrZVRrQkt6VEE5SW9aVEZR?=
 =?utf-8?B?bVA0NXRVcjVoM2NwaEJtV0ZGSEZSRHJSTmFudjVqMjB6dG9RazFSUityS0ZU?=
 =?utf-8?B?VUMzRlZwanlnSUtsRTRML0JSanhGNHlWbkFoREhoeEVsVE1ubjA3YVpCc3Fv?=
 =?utf-8?B?ZzJVR25XZ3NSaUVSSThFdklxRE5NOTFXMmVqTEZrM2NVUHlJYk52cm1NbU51?=
 =?utf-8?B?cDBNWjFYdSs4OGpUdkNZOEhndmhDbDJ6UDZsTlVMa1BVUDJFTDRCdFU3Z0N4?=
 =?utf-8?B?SU5hSEpybVByZTYwRHBNK1FaWFlOZWRMYkswQnZXNFNQQ1c4bnlWTlcyeTR1?=
 =?utf-8?B?OEwwY0d5WktWT2h0RHN2NDJNbnRtZEdZREl2L1lMZjBOSnh4aXltUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee0e35e-9907-441e-39fd-08da48a786df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:02:38.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PehaJpZ2JY5OvLw+SYfhB0GvohnKtdIwCfpP30tytHuqLilomEeFRKSiT0Arm/MpjqAHq9sCt5Xxvxc/0d6ZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1886
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-07 um 05:59 schrieb Lang Yu:
> This will remove some redundant codes.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

The redundancy is quite small, and 
amdgpu_amdkfd_gpuvm_validate_pt_pd_bos and amdgpu_amdkfd_bo_validate are 
quite a bit more complex and handle more different cases. Someone 
changing those functions in the future may not realize the effect that 
may have on the SVM code.

I'd prefer to keep the svm_range_bo_validate function in kfd_svm.c to 
make the code easier to understand and maintain. If anything, I'd move 
it closer to where its used, because it's only used in one place.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d6fc00d51c8c..03e07d1d1d1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -625,15 +625,6 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
>   	return kfd_process_device_from_gpuidx(p, gpu_idx);
>   }
>   
> -static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
> -{
> -	struct ttm_operation_ctx ctx = { false, false };
> -
> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -
> -	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -}
> -
>   static int
>   svm_range_check_attr(struct kfd_process *p,
>   		     uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
> @@ -1428,9 +1419,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
>   			goto unreserve_out;
>   		}
>   
> -		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
> -					      drm_priv_to_vm(pdd->drm_priv),
> -					      svm_range_bo_validate, NULL);
> +		r = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(drm_priv_to_vm(pdd->drm_priv));
>   		if (r) {
>   			pr_debug("failed %d validate pt bos\n", r);
>   			goto unreserve_out;

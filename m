Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077AC48BCF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7079660241
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7079660241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEE66E436;
	Thu, 10 Jun 2021 02:52:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BEC6E436
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 02:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYBYWaroTzytI3mbYpWbW/OkbNlyOrGj8rv3Ybx5o3kzzkg9loAOjldbU13I5Wa2uhei3HfAlCD02FiQ9nNBjddfyPieJHvYu4OoF0jZMRLordkGjkiL7jrXbE6QE636sXNh88ZT2U2Fb4mDZ8EpzHlv+lGmQ9KMLuF53MuZUbBcQE/5YGN7NwJQoVr3wnV6z4/S7pRJguXo15gmC7hbiamfqOjYRemzP40t7ki0ymC2waIx/8F+pqFlQSetZxgv3/2nHiNK3SrBwZZJZLD7cX0UkW7yvQj5CcWCmye1M9QCW8VysVo0+Z8oAz06tMMDRbNgXwejalSztX5joq3/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTxWm9N5uRB310JNRL14yb+40chQr9RSQzR6DPzCuSM=;
 b=Lk60xD12ENYJtd6JN+7289fo+4YeQ7QjRBmJmO5u7d4Zi1km0Ns0In8K00NMtF+6l3MoPiWiDYQym/fJ09i8b0Fwh2fHgAPh7WQZp+6pg/XFG81n+Rs0mce73fMgTbLk0gf3PnaNH6BSOtCbQv2+7nOZpqaaw0gA9i3tyUFKWKxVlJeZn3eIN/Q5AOIEHUR77yVN7ROmeOl/9LrPYje/uruSor6Qzn/0xlGaFiQTswEQKBY8h9Thb0GhhYWB01ebapbYusIumqwCSEs/ubJkViwrtasyJaFoacYgZZFaOm9pSczMl7VmgGj1LxeKPv5kNRJYu7Ifebw6Iy6HNgf5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTxWm9N5uRB310JNRL14yb+40chQr9RSQzR6DPzCuSM=;
 b=0gcIDNAGme5ZFYpctqy+s436r2m4CT6ejvazrGZW9hpvfpwFe9OYy0SRTgiFZMD0O0QjgIqQo1cUvNBl85sfNkRF6ev9bRHLGmNeQDtU3KXjExyHE+5g/FOziaZAgEIPdIHDOmLjsEbfr4HVDoclCnzGULARS4stzVt9G0Vzt4c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 10 Jun
 2021 02:52:34 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 02:52:34 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm macro for consistency (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 luben.tuikov@amd.com
References: <20210610024701.2984-1-guchun.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <00329156-a97d-70cc-f40b-eaa78c63290f@amd.com>
Date: Wed, 9 Jun 2021 22:52:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210610024701.2984-1-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 02:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bbecc85-34bd-4e28-0931-08d92bbacc90
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52255A4807C3E8D00BEB867B92359@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2H6l+qUWKFXg9zi4i3JVpt/THfE8z0JTE25iZ40+ug10AZuIuhwJHbG4c0NBrVeDZtGSndKn1IYGXLBKL+jTJZHl9G4e1UcWLMLj9oHOvIhr1mBTlyMk+fVeYw7QHo2ibiKas2WSpFUO+W/xM69l/klC5s5yJ3UMeq68zcl0OnlkvD70xDFhs9DWAFHc82SxVnLl8MyJRBTkqthVpRHfUo1djIL1hTKWz/L4nyUVYkWTWJxnu9OtaR8P4pqrHL5CgrwkNXMGJ7g5x6aTN8fDVCUVTa5q2wXF1KHlS4woReCiu/OxJyKf1ke/f1QDMXweNA2/sXgs9pdCGdq16UaaNDaXNZxiiRgUDbCP0rQ1ifR7htsztU1hZPZitmYhi+VUhok1IXCz3+HKveKRxZLfwT789GzOMqL36daI+5a3IqrxH/26C5mR2dN4v1ctarj/LHSYFGD9Z6zzc0gsVV8o6sm80bsCeGJJvKTirkaFW91JJkipneb5CES6zoNRjhqlch4GPIZXsU9VtVP1JrF9C9v57dn39mL1CibcqfIjX8VNPQF5a0dSY9P314FQ8zsLXBr0eS2QnmN6Fg7Z/mXg3h4NZUOpQ0Uqo2y0Misy23N7s0t5n/w7tx4Mp6G4SbmW/GIZuo1XhgRNDYszlVrZNah3HXUrb4RfeNiO1ZXt1P2yHbdxv3UtYtb1+QD6fsva
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(38100700002)(956004)(26005)(44832011)(86362001)(2616005)(66556008)(66946007)(16576012)(16526019)(186003)(31696002)(6486002)(8676002)(316002)(8936002)(31686004)(36756003)(478600001)(2906002)(6636002)(5660300002)(83380400001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhNWUlEQkllSlV1cWViQnhDS3BtRFI4c3JEMGdzdlpHRVFCSGliTFRhdjU0?=
 =?utf-8?B?Ym5weSs2NGFmek1xVWEvdlMwMGFsQ3BNc2lCV1d3YlM5WWI4SVVnQlRMU3FG?=
 =?utf-8?B?ZFA5cGVWOGpCelppQjFZclNXL2FzM2h2dUlIMEd1SmxCdHFnWDZvQkk0V01t?=
 =?utf-8?B?WnpZWjZFbmVBWmRpZjdYc3pRK1lIVDgwbncweU5sL1RpSzFkRi96UWVGd2Z1?=
 =?utf-8?B?NGpRZHlDekYxRWR6cC9HbWNqdUNVNXN5Z0wrOGlDUml2OTFIZkg0U1ZvUWE5?=
 =?utf-8?B?VEhnUEtSOEdxQ2hJRVVJWmloTGtXZTNTL0RLNWtkcDRYVUVteVhJbExYeE1W?=
 =?utf-8?B?L2ZLQXMzb3RxbDV2MkZNaFJoV2dUeUl3ejlVb1JURHYvTHFPYU9KUUJhNlZq?=
 =?utf-8?B?WVJkelBDcG9HaE5VQXArN1ZQKytjZm52em5JZ2ZyamFYNGwyc1pHQzlaQVNR?=
 =?utf-8?B?cDN4YUFqRkRHSFl5cDlxS3NmaWUvUWdQUTY0dGZoWURpVExXNnpnODB6UHkz?=
 =?utf-8?B?Njh0Q1FjZVo5MW92SC8vcFluQWR4TTFPRGxTNG00M0U2SlZGN1o2THFRMlpt?=
 =?utf-8?B?QWpLcFNMdlNRVUFFQU5zaEs4UWt2SGZERjRqSmo1N2NSek1uVmdXZ2pQakox?=
 =?utf-8?B?R2tYZkdtaFF0VkxLZ0xmRUZ3U3NzOEJGM1hmbzFLYytoTytCWHVlNm94R1FW?=
 =?utf-8?B?OEFsM0hPd1VsRVhGOWpSMG9zNm9wdk0vYUdESDErSSsxcTY2dlViVGhTMlZP?=
 =?utf-8?B?UzArMzBKckZyZTVwUWJVNlh5NWUwZTJOVjBqbTRZWEJvM0FmRmdVSDcxcVBW?=
 =?utf-8?B?SDdGN0xxUG1PYjBWQ3V2WHJBcndxUzNFeXFrbFlxT0MweW5iYjkrRWY1dnZk?=
 =?utf-8?B?RUR4UElsVys1SjdEYlQ2Qy94NlFPNHEvdjA2a05UZWRVaXI4cmpuMTRFd2I2?=
 =?utf-8?B?TlhBRENvTm5Od3JCYnBSa1ptcTNhNmVEVk02czFBVmEvSVBaUXV3OHEwNWRv?=
 =?utf-8?B?T0pUanhkZThVTmJYSEN0S0g3OGQyV1R6SnY1K1lnc01ZVXU1VmIzSmk2S0FG?=
 =?utf-8?B?bXJ4SldCZUltNmxnbFA3dXBsVFhKWWF6bW5JTWY5N0pOUG4vY2tNOGVrSCsv?=
 =?utf-8?B?Q3RHd3dhTTNOSW5ZdEs4OXE4LzhweFlqYzRnYWZiT0ZsOFhDdXRGMy9OWFB6?=
 =?utf-8?B?eTFQOFZMUTd1RGF2WTRHT0xaWnJsbU42MGgvWXQyVlpteVowNDZKeGFaOFhL?=
 =?utf-8?B?OEFCdnAreGlSdzJkd2VEbmxIY0szU2cvWDFJTUdKS1dPRnpscXlOTHNmRWJZ?=
 =?utf-8?B?WVpjY0ZVTC92Mm5Ib0xrZmdnR0JvaHprYWlVb1lGbk04M3krSE1jYXhEUXdV?=
 =?utf-8?B?cG9EazkyN1NucWhGYWlVZURmSFIwLzlaQm1IL2xoK2dMdGVSTkI4QjQzOWs1?=
 =?utf-8?B?aFVmdTRYQ1NkbmR6UitxeDZ4YUFrTnMwV2Z6blk0Z0dTVGxNTzVaVUtmOHgv?=
 =?utf-8?B?TUE4M2RCV0J4WkVnV1FOaStzUFZlN1lBS2JhdWo4SVBZVHUwYm14dkVxSitZ?=
 =?utf-8?B?czQ4dkp5VThXM0JrYzkxR0EwajhBTDk3OFhMQVFrbXNoRkVENnE4NkdOQXAv?=
 =?utf-8?B?SjhyK29zaFFmWHFLSklUS0NSVzJXcWZjcUlvSnYyOStTMnZwelZIUG8wcGZP?=
 =?utf-8?B?OEJiaEJXRU83dG9JeWZsSmN5UlpwV0ZYc3QwQ3RmN05FS2N6d2RQTmJna3Ur?=
 =?utf-8?B?MldUOVFmMktKeUxyWDRzZjcveXpUcGtTVmFxWnNEYmRiOWgxNk9xQVBhSW9l?=
 =?utf-8?B?YWVLMUl0ZUp3SDNONXQvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbecc85-34bd-4e28-0931-08d92bbacc90
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 02:52:34.6245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ZergR4Tf+ie1gY8BimHrNKSqa0jxIlo4qUREEbHU/erRM6edNFJFrmOd/zNQeLgqveu5W/J3KnAOTxq6WqoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-06-09 um 10:47 p.m. schrieb Guchun Chen:
> Use adev_to_drm() to get to the drm_device pointer.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 016815b7a773..fb6bcc386de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>  		}
>  	}
>  
> -	gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
> +	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>  	if (IS_ERR(gobj))
>  		return PTR_ERR(gobj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ec936cde2726..bfbcb9ff2453 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
>  	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
>  					      ras_counte_delay_work.work);
>  	struct amdgpu_device *adev = con->adev;
> -	struct drm_device *dev = &adev->ddev;
> +	struct drm_device *dev = adev_to_drm(adev->ddev);
>  	unsigned long ce_count, ue_count;
>  	int res;
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

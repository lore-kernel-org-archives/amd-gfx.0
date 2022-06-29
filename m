Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018AAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 08:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DB610F6B4;
	Wed, 29 Jun 2022 08:36:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB67D10F6A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 08:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMEkO/Ews5qMChsupgtvagJUWGER9+/EUAyI+35yPXWaIiJWcyc/1ctByjv/bHq+kIuQ616WQNcgaMR4m/F0lPgQgYU2dN121AJrX34dBWOG7wUqyfT10LFa8GRmnK4GS7XCZXQgEug9RatfYq0ZRsnCBMK5W80FBzSF1q/eAwT42Y1rGzHmgT5BV5mf6zXtIN2kpj9JJHonezJiiHBu+wR7zuyM/KIXkNwUJROjBVqaz74Y3D/9oamhtxK55o3kZg+cYmc1xLoLtwXzxv7wHT75SwktSDAmTqqp8xz+4yWSp5Dc89hMkncb5aRjaTTRzatR1BXTsUmBQAXERs2J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNmVUCwnjhHv6tC72BPxlu9SHFAjscfAt4LtY1n5GYs=;
 b=RgBM01F3bLPtruaANUlX7adFBiW5KxLzs7jHmJWh+iD7NEnmFjdyqDhJxuvlMUBVs0llhoqqpaEwNyLuRIX2UJ/WtO7DqB1pIYHX2ipdfe1pao5vLfr3uS4lk8rnO9xWqQlXGq6BYhsvkW5UjTECzTg6EbAVLGf8f9ZGfcNjCiYDlzMA7EeVoCdh/BYv9u6TbjLuBFi0/qXsZUm7qiQZ4RJeG+OSMYQtBJ8+21p1/Aq9BCablH0SrKU+dpYEGrWiOraRKaFxsHwt5nv/t4A0nTxS5zFPNKlNCr3QWp0XlRNjLeoQArgid+Qhs48OKL57CWqnekd6+XXLCIlW109uJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNmVUCwnjhHv6tC72BPxlu9SHFAjscfAt4LtY1n5GYs=;
 b=g6MElMmXdLndGe/YiDdOoNEHwxV3LWiIw+TUEvIgeLKNisTS9o0qMkWKgdvQzfuPRXkWtJu7rWq41HOLjTfgwthvAzVC5p+9vCM5aWqQPNaEb/Lf5DF5uD+Wd+uCj4sZRTxqAOzqwYJw1SQZRIuh238QHmCcBAnqSkAI/3ulPeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SN6PR12MB4733.namprd12.prod.outlook.com (2603:10b6:805:ea::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 08:36:01 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f%8]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 08:36:01 +0000
Date: Wed, 29 Jun 2022 16:35:51 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Jack Xiao <Jack.Xiao@amd.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/mes: add mes ring test
Message-ID: <YrwO53lyAaF27xR1@lang-desktop>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
 <20220629032034.2994328-6-Jack.Xiao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629032034.2994328-6-Jack.Xiao@amd.com>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8421da79-62f2-4db5-7817-08da59aa6581
X-MS-TrafficTypeDiagnostic: SN6PR12MB4733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD+LVxZX6U14MNOYdk0Nv0fjW8ApkW/Y+NlVBEF3s2AlbI3fcnn+JQJyEjJkwbaEHvaymBRrgOBiwaYj5BVcza2BFKgmngoIv2KfgpZ/ZxbfrMR4qeahHUyYVMeBzhZs2Qy59rezETuZ6VZ0zw8FGPP86OTLAU+i5iggk5tgBe4eUP2sUxeurPptdt3hF58Jkwdkexu4hSc5OqdIpz9OKV4i3cQf8BDtp8ibLy7yuJ4hUFcIP+q9B2/Z0/qVr+6JL0Iw6ab5ujp5g1GCSOH621spuwvZB+rRfJGVE0CifP/LObD9kadvS6DIRYUUajxzWGpS+Bkbi4NXcO9yOVqpSaKajWW/APydHf1P5N+hPBbUHSc2Z0mcM2w93C/Db6vL6w8G6RCtwuWa9qYqPGIQI2r6lwKaHXadsFchtM2MWfTXA+aVwQ+LG0xCk3oBMWxF2tuhajJZEQDswnBK4ilYozh80KkDng1mGm8P0E5u6PDgWNO5AmxhwI6kFVY9N4DdVNaYsPxSzZ99SleQw3RtdISYbA6o/Jc0RtheUNN+hpTQgt/Qn5IRDOyDExkVkH9MkwA1dl00x6iwcSEsyNXA/7RZ0deNQF5ribAU13CcnqJfdJZ46AtRP1PFwop4kCyxJ1C5miUdeH2uaKEHK9De5mf7sZtYO3CaDQHp6O7rnR2amboNMON96l/GXBzUHZSIMK5cs5BU5l7BzfkiXHGckunx/Zuxe1WVvtE0toMVbfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(83380400001)(33716001)(6862004)(9686003)(66946007)(5660300002)(8936002)(6666004)(478600001)(26005)(66556008)(2906002)(6506007)(86362001)(66476007)(8676002)(6512007)(41300700001)(38100700002)(316002)(6636002)(6486002)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICUdH220eNT3leOof5rMK7z+XhFrvBeWHW6u06XtXRHk8ULQ/LWu1l5evFPF?=
 =?us-ascii?Q?H9AsqUPdmLrRXywAUxdPnl0LKQRxvE6wejim2AIwNgyGlB/K+pY/80Sy0c/J?=
 =?us-ascii?Q?OZZhK2drmD5GZs3HnY7QOjUVqACrGVoJJCjcPts4XlMqaC/AOK1MmXgRr7fg?=
 =?us-ascii?Q?+8cCTFMsOySnYSrhRB7Aru0WPKKa0y+L4KwRdTgRVUER4dEIXn1icozyslOx?=
 =?us-ascii?Q?2HmpAxl+kqP6o1lYPsDJIugvXKKsSr/snmleiCY5hG1GgRVV54eYb/LzA/k7?=
 =?us-ascii?Q?IB1pTZ6wwXEa8RZX+FY6bZ/RNd48+NRmqcTMN98nYEJNBefAtK5dKi7EeBrE?=
 =?us-ascii?Q?tCpTIqS4w9GT4Zf5YM/eJQCRPq7cS9du5KTkzDaI6SxXMFlEyhpP6dILEV9p?=
 =?us-ascii?Q?h/j2txnP2v+rjqbBp7FKsr8OUfyK4fZxQUO29QHZbq01Ypk22uUgcJZ5uOLJ?=
 =?us-ascii?Q?2MRwq4duKQBR90JCdF6Le8NfdvVS+nb9ibbk92Vpg8kZdMEN/9lEu6qf8NPe?=
 =?us-ascii?Q?2S/4f8wEqCf0EegUynv2+ilIXt/qI4gTkTOp21QupfHlKzSegDfnQQ/kCfXC?=
 =?us-ascii?Q?fUazTtIT7idBonAJ0RSGhvzXVKHFtTDOfOkQlpIPyXX56xPfrSb/TbU1xpZe?=
 =?us-ascii?Q?PHHO/CNNNr/Q0c9rM26pPPHhiLCrn7Zm50Js/0DbLf+GxN58Lqbd5sCoHKEn?=
 =?us-ascii?Q?VhahGVpzDYuTUlDS92H0lYOptfzm+1LHYqoLqTaFbWCvXj9kM4/HQslsqQTx?=
 =?us-ascii?Q?HqJhiIrTJ18uzIOSgYJdyiUdAL5fRoswpSdRogjA2sxRl7afm3R7Wjvr7ggI?=
 =?us-ascii?Q?47hCnn/fR6zoSYnw4vvvMa/+hbs+DFpLP7BROa83w9axE3bRMIFpbWhFauk4?=
 =?us-ascii?Q?0twGFd9Rfna0lpS1NPMKf2yvFuRD+tMVIcwAeFjo5Q7De4b5P5HL+WAv7BMb?=
 =?us-ascii?Q?uFQzrJSAFZQQKPs8GUpqdY00EhqXjyXkdI3D6CEqz7efiOm+JET+Quff2Q4u?=
 =?us-ascii?Q?1VYpKUf2w9J+UQLCssf5m4oU99FiOhhdBWKMaooX93+rBVcRbs3Jg6mhjfCG?=
 =?us-ascii?Q?KEI18Fey/f20brLoF1+fTLDdC/yUL63enwZfFE8yv21kQ9sdoFNzalKrxtva?=
 =?us-ascii?Q?dbrFq0uSz5gzMMGIFilzVJKelWAp6ejsbKjH2ch+mnxDaiP0ZLg2Xqoi4NwT?=
 =?us-ascii?Q?vYgkUAkQ1ttgtuZrnREjwsO42KZZ3++k3j9vVEoqpJTImDhvMb7rjURy9ZWz?=
 =?us-ascii?Q?JF/+6E+askYde3s4h8+AV3FVj0i1W1vG/F/cMdyUXzcdVvnUE+HDOKQfJ96w?=
 =?us-ascii?Q?d61et2ooMCWRd//GpaR8QADKJSMBlDOv/ZxqOmqKj5PO9mDlSnYV2/MfMsj8?=
 =?us-ascii?Q?uP6rn5XXHa78yfzIE9dRBq/PX4Om/fY4PiXNoKihbHEj0+92YXUlofSbk/QT?=
 =?us-ascii?Q?TOHcGo2IJd96Y1o+i5EDd2Hi7yzkQgWyL5BViRjYbFrUmZmlOeLI/sv/aIAF?=
 =?us-ascii?Q?J0e09clEFe7fiCL0YZRlirgvxxDte+CQXPrpEn3TCnccWZqA3Al/Yf99nNXI?=
 =?us-ascii?Q?iggb61Ry/YUkEM5Ri0VN9DPDFEX+H7bJgCRoppg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8421da79-62f2-4db5-7817-08da59aa6581
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 08:36:01.1767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QonwfD6ueFpDmJQ55w1cXZpfyHRtuyav7a8KFBgFvWDhSOJ/vUd8QhhAola7xIW4oneAIB5S36be6Oqb37L5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4733
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

On 06/29/ , Jack Xiao wrote:
> Use read/write register to test mes ring.
> 
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 36 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  6 +++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index b6c2a5058b64..c18ea0bc00eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -926,6 +926,42 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
>  	return r;
>  }
>  
> +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev)
> +{
> +	uint32_t scratch;
> +	uint32_t tmp = 0;
> +	unsigned i;
> +	int r = 0;
> +
> +	r = amdgpu_gfx_scratch_get(adev, &scratch);

amdgpu_gfx_scratch_get/free() have been removed in latest amd-staging-drm-next.
See e9b8129d8ca5 (drm/amdgpu: nuke dynamic gfx scratch reg allocation).

Regards,
Lang

> +	if (r) {
> +		DRM_ERROR("amdgpu: mes failed to get scratch reg (%d).\n", r);
> +		return r;
> +	}
> +
> +	WREG32(scratch, 0xCAFEDEAD);
> +
> +	tmp = amdgpu_mes_rreg(adev, scratch);
> +	if (tmp != 0xCAFEDEAD) {
> +		DRM_ERROR("mes failed to read register\n");
> +		goto error;
> +	}
> +
> +	r = amdgpu_mes_wreg(adev, scratch, 0xDEADBEEF);
> +	if (r)
> +		goto error;
> +
> +	tmp = RREG32(scratch);
> +	if (tmp != 0xDEADBEEF) {
> +		DRM_ERROR("mes failed to write register\n");
> +		r = -EIO;
> +	}
> +
> +error:
> +	amdgpu_gfx_scratch_free(adev, scratch);
> +	return r;
> +}
> +
>  static void
>  amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
>  			       struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 93b2ba817916..81610e3f3059 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -341,6 +341,7 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
>  int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>  				  uint32_t reg0, uint32_t reg1,
>  				  uint32_t ref, uint32_t mask);
> +int amdgpu_mes_ring_test_ring(struct amdgpu_device *adev);
>  
>  int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>  			int queue_type, int idx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 2a6c7a680c62..c4d085429d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1194,6 +1194,12 @@ static int mes_v11_0_hw_init(void *handle)
>  		goto failure;
>  	}
>  
> +	r = amdgpu_mes_ring_test_ring(adev);
> +	if (r) {
> +		DRM_ERROR("MES ring test failed\n");
> +		goto failure;
> +	}
> +
>  	/*
>  	 * Disable KIQ ring usage from the driver once MES is enabled.
>  	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
> -- 
> 2.35.1
> 

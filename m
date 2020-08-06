Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F6C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 19:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99442086A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 19:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IkKNkk4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99442086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6F76E90C;
	Thu,  6 Aug 2020 19:46:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6046E90C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 19:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkuGVAurMUzDver/NVqUb4/Y5V+cUNiud1gY0W/lLwXcQuvOTHQUSez+hQEqDMajapMUFVNsr8+WEDCr05XNEVCZ+OC2cWPycmwC5K1pJUIf1YK3Gik5ey9kTeYYgMcmV11enXWFDxRKPNyzunqEi0Pf1Xz9OJlEzBAJ1+iZrGsLb/qFbH6UFl+Q76xzdhYbUFb3HxgTQjpS1eafBvOLqiRsmP6fPMNOLxTu6894jzPP+i3G/b86sov5PHYAVXhdWL79S3XEuaf2NhympBc9GguR/PBqL4POhyoi4ff+QZpfmRzXo4w8P3ypwr/fyI66cXelgBdrbm1iiqRMweYDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv51H9orGA0lAVpTYyFVbNai9R9lF6VLTWRgRQwXhiw=;
 b=B01uPjCUHcR7ac61fVMrIKxdh0I3QutCLmKztvMipvmyGzLEgK6367x9hqNXRY1idriBHpm0ke3cHsM9USmqELuDHYjt1pVfX8PKHOCTgAmh913nAXhnFeZAawza7K7Sd4+xaPVtzLLJyIwLJbpZR5THYJfbYVc44uTKDGNEPCbkvSX+jmjVOisp1daNj15X3z0qZpIDnwH6m+XjEuKeWxtS0EX6vKXupLNBmTIwxn4U08zhSvoE+NOVAZ4JyG5bZwY8XFkIDlQCfr2cz2B5oY1xTIiaRjmPMTCPUya4ZjUTGZMggG+z95mqHeTQx2hnV9gJvd6CQpUeklqs5cPWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv51H9orGA0lAVpTYyFVbNai9R9lF6VLTWRgRQwXhiw=;
 b=IkKNkk4rQi1gPJcnc4lXHmGszjeeegSfaX/Iffff0TiulbwTYkdVujAaoTaoXzhKxm7oVIOqAHPZqnxhGJ9pTMWBXNgC31H0aaGzqb2VkouuRTJVa5Ah84tjggs6MB9vTREWXkU/ZVGpxeD8mJaWxxbGCabJuAYJcCEUZKnH/Qc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Thu, 6 Aug
 2020 19:46:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 19:46:53 +0000
Subject: Re: [PATCH] drm/amdgpu: Skip some registers config for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200806074036.404227-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ca763f9c-27fe-b9df-d220-54c51b1a4edf@amd.com>
Date: Thu, 6 Aug 2020 15:46:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
In-Reply-To: <20200806074036.404227-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 19:46:52 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bd3a709-b2e7-4738-a718-08d83a4177ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892E837876AF654AC22465C99480@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fa7r98Ap6F373jxpXXeYz17Kig5u7Iw6/NnzAH6EflDQI+kvX9ULMZImnUVwDasfzOLPssGSO1xfzz49ZsFBq2b1p9UDp+8tWtKIOUDs29C4WdlQbj+jpzuTti3IdRNabRtnVJDyhxz43JFYGoOF04SW/JZSdLrLIvK9RYy/N+WKh1uKUg2E2VcxgBqZkaWttEyelCYZvzz5WN/QnuhuvRg52Jwk4jM9C603Jq79qliZ8i5gsMgr1WIZJLuf9++2VSl8GIocOazkTPc0U6pjowDe5JKmUCAUab3h/nrSjwXQH7TLvG04Wr2A1VmJvgo9AoYIF2mMWXPkD2VcrGrjadPvpbPsnKNfpGZAXS/nZ+KczIieboqFpCmv+809NA7N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(16526019)(186003)(4326008)(66556008)(66476007)(66946007)(44832011)(2616005)(956004)(2906002)(6486002)(5660300002)(8676002)(8936002)(86362001)(52116002)(6512007)(478600001)(54906003)(31686004)(83380400001)(316002)(36756003)(31696002)(26005)(53546011)(6506007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EdBrbBgQyyZrMe3u5eG/qSKkillYBtMftpZ77pXcmXUT8Ap+zaU/KmdVDRSCd6qAU5OPm6DnzyDXGydIJ+h9T0dCvkyr8XYfd1HrlWOuHFpVmZU4BOAbCAEGdvrvflLrB+DiM6vFNA08/uG9sDN7+mUXACAnCSqQlGbV1ICHoW4WZ/M9BCLqj89pZC1ocYzkvEyTqTkcZiv03WA/logpXTUyCiY2VVbVKwGq+3P5ixmGf3hdUJn80ypIl4BJnuUOxXR/XiSPOkthy3BbRWq0WbhTrSDQ1k1FsPRQFk08JOH3a72K69kxyOKUJq4kBJb0EhUcqZDev6IANGwKkN617vc2S4YsM3vkWluHqtDrMmVBXo6tKUrNH74JIW53WQwFePqOFOaFg50760lQXXGaADc9A+6s30TN8VAUsBPKSt+it1vffqaXugXr56E+DLANAqlVu9igsH5Lj4hB1ATFtRuu+VpDYm06T8wcGTbOlEKt4lit6hOUNKHlimb/rlB63ivuxwoPjLtRrwRlIe5RiNUEM3nCGJ+SmbeAPK7ZC4zBYH83nkkinQbxnjnDDkB7oy62et2n3i9uRAS2gTbj1BKTeudINGKRpts5bE3qAklZThqo+t98OehlXjcJs+I2/IUejlCznnPPF530BDHENw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd3a709-b2e7-4738-a718-08d83a4177ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 19:46:53.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLR3ynzS8x4i6KKsfmyOlPvJYP7SFGUglY35JIaX8JqvO/OMeaaxCnFlbU6hNFw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-06 3:40 a.m., Liu ChengZhe wrote:
> For VF, registers L2_CNTL, L2_CONTEXT1_IDENTITY_APERTURE
> L2_PROTECTION_FAULT_CNTL are not accesible, skip the

Spelling: "accessible".

I'd rather move the "For VF" to the end, after "accessible",
like this. I also believe it should be "to VF" as opposed
to "for VF". Both are correct, but mean different things.
Maybe like this:

Some registers are not accessible to virtual function
setup, so skip their initialization when in VF-SRIOV mode.

> configuration for them in SRIOV mode.
> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 1f6112b7fa49..6b96f45fde2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -330,10 +330,13 @@ int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
>  	gfxhub_v2_1_init_gart_aperture_regs(adev);
>  	gfxhub_v2_1_init_system_aperture_regs(adev);
>  	gfxhub_v2_1_init_tlb_regs(adev);
> -	gfxhub_v2_1_init_cache_regs(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		gfxhub_v2_1_init_cache_regs(adev);

Yes, that's the literal meaning of the commit description,
but it would be cleaner if gfxhub_v2_1_init_cache_regs(adev)
did that check instead. (Some might even argue it'd be more
object-oriented...)

So then, this code would look like a sequence of
statements, unchanged, and each method of initialization
would know/check whether it is applicable to "adev".
It also makes it more centralized, less code duplication
and less code clutter.

>  
>  	gfxhub_v2_1_enable_system_domain(adev);
> -	gfxhub_v2_1_disable_identity_aperture(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		gfxhub_v2_1_disable_identity_aperture(adev);
> +

Ditto.

>  	gfxhub_v2_1_setup_vmid_config(adev);
>  	gfxhub_v2_1_program_invalidation(adev);
>  
> @@ -372,7 +375,12 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
>  void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
>  					  bool value)
>  {
> +	/*These regs are not accessible for VF, PF will program in SRIOV */

Add a space after the asterisk and before the beginning of the sentence.
Format the comment in one of the two acceptable Linux Kernel Coding styles.
End the sentence with a full stop. It also helps to spell out "registers".
Like this perhaps:

	/* These registers are not accessible to VF-SRIOV.
	 * The PF will program them instead.
	 */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	u32 tmp;

The definition of this automatic variable should precede
all other code in this function. The compiler will optimize
it away anyway.

> +
>  	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index d83912901f73..9cfde9b81600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -321,10 +321,13 @@ int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
>  	mmhub_v2_0_init_gart_aperture_regs(adev);
>  	mmhub_v2_0_init_system_aperture_regs(adev);
>  	mmhub_v2_0_init_tlb_regs(adev);
> -	mmhub_v2_0_init_cache_regs(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		mmhub_v2_0_init_cache_regs(adev);

Move this check inside said function.

>  
>  	mmhub_v2_0_enable_system_domain(adev);
> -	mmhub_v2_0_disable_identity_aperture(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		mmhub_v2_0_disable_identity_aperture(adev);
> +

Ditto.

>  	mmhub_v2_0_setup_vmid_config(adev);
>  	mmhub_v2_0_program_invalidation(adev);
>  
> @@ -364,7 +367,12 @@ void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
>   */
>  void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
>  {
> +	/*These regs are not accessible for VF, PF will program in SRIOV */

You can duplicate this comment from the one above.

> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>  	u32 tmp;

Should be the first thing in the function body, as noted above.

Regards,
Luben

> +
>  	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
>  	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
>  			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

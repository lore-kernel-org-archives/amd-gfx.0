Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58035C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 17:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A954B2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qRZrYpWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A954B2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B316EE23;
	Wed, 21 Oct 2020 17:40:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80016EE23
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 17:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk694jrw4fbr+1pCd8SDbWVl5TTh7gm4fU1YRyRpF87AWJMXzcThuBPZR3eHO7F9/0D7QUMZ2chWsA1be6e3N/r3MupZThVY4X1Wn3lTKjMviDQE4SfDZ+kse0pED4KtBjJW0c8uCAuUou7CKqiH6xyGWY2Im99Or5TaS7sfflr4kIjLgpWhnbZX+UBU22Dhtxdy7KJGvreoczUeoe6nflNbOn+pqQ6tq7CG3h119nUWbArOlZ/3cDERx9E/5739gha55Q05PPjk3vQ126s+u0fqrm/3+4QSskoSC3K34zWuny02+Ul8yCuC65AfZKlar5kSzjGMR62GylMDWll8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqqO72gzxKOYqAxEtH8eXM5kA3ZwsvJ/UxImDEvyjz0=;
 b=nRpxoOGZvHbJ00p0WfE7boZb8fuaPCxy5hIVyYP7SJtTmiCu+UjZO/j/9hGeYMhnjIPabkLJzAQwcER/1LUo7LvykX3x4V0MmcvRMiux0qf66N6xB8dIb4G/lhVz0cQKt10lDZyzSWKGd1vyCVWoTMU8+KB9TrYKtQlmv/Yxz/WiakSspz6kpMBjO9l29ouX8PIWegd/98bx1rf8rHZkI/VH3QOwhg6ejh6LoNTkX4PfpTKb2/dBNScR7tu3b5/NbKDbPcWybfsaPJHWYjg/O6QkEoXhkMKd1aac5BxCVaNk8TLm7mxNiidVyjr9GlAnvt7L/ppsXM3EflAQekzu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqqO72gzxKOYqAxEtH8eXM5kA3ZwsvJ/UxImDEvyjz0=;
 b=qRZrYpWkXQh1sYzLJawcC2MeQdtaJUGmVLKpiU1ASeSB00mTYaabUDmIvTpUQT9wJeWkH9iqBPrXK8BBujLH5QL3jIxICZNTKgv3pQBpwV7qfzbA1XUgWdrtNjveZL39SRitSJz7EF7TubOpuQ3222oRL44+UbStgA4ZMsre5EQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 17:40:21 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 17:40:21 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201021075608.16785-1-tianci.yin@amd.com>
 <20201021075608.16785-2-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <4df69b9a-f253-d2c1-74b7-a9c69cacb7c3@amd.com>
Date: Wed, 21 Oct 2020 13:40:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201021075608.16785-2-tianci.yin@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 17:40:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ee44a3-2790-4cc2-d5fb-08d875e8621d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1259101291117530E9E098C4991C0@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBLPfDuaZjejVmtjt7iTOrbBzJ4IY3fAO7UjOhnI0AA2XQypfdBqY4LSeBjgt7Lq3kZHqWd0c/UL7/nIqo0SmQKwT/rw9omkmShSCbJiI2wCJoOxMj0yUJNdxT+fLLDm9K28TXKrrtPgGkWJ35DoLxMK1IN0lz39yC7wMIVP17jBZIDI+om7bl3+KiRAKwZp4KhOfhCGIwsoI1lf/h1P6IKV9wBtMBIo/+aC5nIkaWuHGS4oMX/7iwd/Ge59wuTJvFmfpoAsAzNRNCysAKz3o2zHBJ4i9YlyhdbD91JCQDe4y7lT8Q95DA3b4ANqmoprm4u7rMZ1Fqujb01WjulY1lGdF4uTKgJDSzm0I2NcdiyZT4oEUn6opGBDP5o6r1Fq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(478600001)(16526019)(8936002)(186003)(26005)(44832011)(36756003)(4326008)(8676002)(2616005)(956004)(66946007)(5660300002)(66556008)(86362001)(66476007)(52116002)(53546011)(6486002)(31696002)(2906002)(83380400001)(54906003)(4001150100001)(316002)(31686004)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2IwdSVWTB/sWTUffL6nn8MmVsysv6NZLyNB8zKkGVN77cbY1tFmOM31+GTfs1xitQ4WXe7LfQXEDjdCLUfXBGgLm55DWWuH80NrXDqNbcDQhUSZEoYkyGI4syaJBSpPIlGZEaOCqENERm8gMzHjQud5dEjPyzGP4qbm04qWwxfBA3IDhQXc/MIZ/BHKPgFxG+/fSZ/tbSJLhBus+oZp1o6D0amhMkdZQPWrGXKPzP8WIkvv6skFgLQgQ7j9BSN8BUrQbRxRh5RlXlP6jgX2LB4LzKfcULSWuWKfBuGf5tOTCtaOke6ZNdpeGrGuO32QZ1Q42BcKtRPT0cZaAX6qdwblSu+sgBNbBEmlC+xkmE+sWJ5JnNijJ7k1xTmrXOPwwHB/jYVfk6x2Ca3sWfMyis7vmTgRjTzlr/RREOLy+GiKs8nTXP+pk3EgWNlDpjKJUAWbIu3kjZ1RQI7XtAWW7XQvuH8ZnuVXB4x/T6ti4TCndA/FyzFQmnbW0UkcV4C6diTGUmBuz5ERvl41Jjjfafxyo/j33AbgdG4Y1JOMYx17Ib7MP9qHtiI7r/SBSYZ+Ax+636/44gGb8am0b+45/JJb6DGt1Ax496FxF4mvRYZncxJGoZ6nA0yFx5lMl555LQM30S7AHarL+EgnLq+v8Fw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee44a3-2790-4cc2-d5fb-08d875e8621d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 17:40:21.4288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZvPkOiycNWl42l7xrDICDHdv+FH/6J0c31Qlnkt5UNvHMiE/pCK88CBtT4Wh0ul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Flora Cui <flora.cui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 03:56, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> The blockchain SKU has no display support, so the DCN ip

"DCN IP" to stand for Intellectual Property.

> block should be disabled. Add DID/RID as display
> supporting dependence, it potentially disable DCN block.
> 
> Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 +++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f8f3e375c93e..04e906386b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1051,7 +1051,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>  				   u32 pcie_index, u32 pcie_data,
>  				   u32 reg_addr, u64 reg_data);
>  
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>  
>  int emu_soc_asic_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c567f20b9d1f..fa522cffdd64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2958,11 +2958,12 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer of pci_dev instance

"pointer to ... instance", or,
"pointer of ... type".

>   *
>   * Check if there is DC (new modesetting infrastructre) support for an asic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev)
>  {
>  	switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -2998,7 +2999,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  	case CHIP_VEGA20:
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	case CHIP_RAVEN:
> -	case CHIP_NAVI10:
>  	case CHIP_NAVI14:
>  	case CHIP_NAVI12:
>  	case CHIP_RENOIR:
> @@ -3011,6 +3011,20 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  #endif
>  		return amdgpu_dc != 0;
>  #endif
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	case CHIP_NAVI10:
> +		if (pdev->device == 0x731E &&
> +		    (pdev->revision == 0xC6 ||
> +		     pdev->revision == 0xC7)) {
> +			DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n",
> +				 amdgpu_asic_name[asic_type], pdev->vendor, pdev->device,
> +				 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
> +			return false;
> +		} else {
> +			return amdgpu_dc != 0;
> +		}
> +#endif
> +

Why not leave the placing of the original CHIP_NAVI10 label,
and add the if () under it, and drop the "else { ..."?

Regards,
Luben


>  	default:
>  		if (amdgpu_dc > 0)
>  			DRM_INFO("Display Core has been requested via kernel parameter "
> @@ -3031,7 +3045,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>  	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>  		return false;
>  
> -	return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +	return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 9e92d2a070ac..97014458d7de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>  	 */
>  	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>  	    amdgpu_bo_support_uswc(bo_flags) &&
> -	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
> +	    amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev)) {
>  		switch (adev->asic_type) {
>  		case CHIP_CARRIZO:
>  		case CHIP_STONEY:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 13723914fa9f..97fda825e0d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	bool supports_atomic = false;
>  
>  	if (!amdgpu_virtual_display &&
> -	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
>  		supports_atomic = true;
>  
>  	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F6C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E8F20773
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zg42SUNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8F20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C86D6E4D0;
	Tue, 29 Sep 2020 15:29:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B0E6E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7gYXJE4rUkrEzFO6V4lOLWMyjypaL1xwPxuygntk34HnDqNmwPRMQSKTjruogb/PuzMtiPWDySg0t0VpRbrn3uwbUbkdAEFqbS5zO0Votr+G8Y/ezAldelf5XVlwo9+hgdZpqu+U3cmJsMExLrKKP7hcbxqIZPS1Iskenx/rj7mXVp/QvZKKrp/ETsjRlJCm3RqiEXOIKTVEVcu8tbrnq22SZq5TPCRxf+tyRTLCBgrs+56YR8orwfhTZOm6orbBZMG1LdFljlF4hFD1RhGvv/WJ/QWsx10uRC6WIqy5OveOv5wJNJSvHoXp2OA6E0wzrrHQeMsFaUVTQ4RsfPQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOTdi72VFUND1CxE6eVD8ZkYicBl7TNQi/2dXMMeYNE=;
 b=QoPeWu8jEg2pN9jdg86O7PBgC9MvvCLd6cYnu+QLN7WBXc96pJpP4xCMcB3RljHX/AJl33EShNX+sicQN8zLT1GLVw2yU7IJxM8LGBQGKJz1/1Q8O6taWwAHxfbqAmO+6TfvLZX85qctBuMvSgJuUe3EGaVOKty2XLUL/pn1R1kt+jpjZjMSwKXxdpsku53XqQhhZEWKEFdjWXuSelXmxJvx1bspufcWsze/4UoI/O4pN9SyGsioXmvZg63FHqDratxFNXC/bPjoS8K6SZrNd/pX6xEhfu/3Xey22Gz/iwoNSN0ah2lU349r8xbqmpxyE4WBPCpBhwnvsKOynBfw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOTdi72VFUND1CxE6eVD8ZkYicBl7TNQi/2dXMMeYNE=;
 b=zg42SUNkG+BpT0PUO7O9ypubfwhfQkFagDBzJWCRPyRI7oOYuIy1nTucWOSO7Ymi5H3P7iI5pSX+YL3k8bo4dow7vr3btQs04lko3aZSoSrfF0dqtKWaWAdM0kce7bflJoiGBCEfR1UihCycZ3nGxj+F1eXuDxOSB2DGnzFufUs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 15:28:58 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:28:58 +0000
Subject: Re: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check v2
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200929150854.26710-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b0ba3861-de7a-423a-07d7-a80b79ae4eb1@amd.com>
Date: Tue, 29 Sep 2020 11:28:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200929150854.26710-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Tue, 29 Sep 2020 15:28:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8343df7e-6dd1-4642-a22d-08d8648c6240
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43656EA8CDD8F25681496BAE92320@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEQ6mJ/CZ6UNP0jPWpo3ttBIG9/oX3E03d66Nqf3idbI45GvQoEiwxoWMWvMNtxZIoJEy+YYnTB1MVQZrHDg8womRaJQ7X/OYY21XUPf5j/QtXW3gpfvi0Ug/kQn3FhTYcmhXTI5hKIYB29+MLFedVvBTle4TKskkfCX3xRCDxb4YRkCDfdLq5yKF7n8CLbL3T7S5zy4/3OxMby1gNZrWDmn+Xjz5BL0wKZnGGT+CrodO3sx/6ouvkXRqtD1yd5lZdngGvaaNLs49/Tf2O8v9o8byJZlcAACuI7tpdJM54pQzMpnp8G9xxt7OaWSxbiVqqGFFWNquwzr+KJGklooRsaWzmelbRvmCJ1huktsczhgO1U3SwFOdxfAwdeW7TuuTXhFekM2o9N+i2nJXCNiUvNaChsFgike/9BD/+oaXle9YwasBdYPgnUcVebCizdv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2616005)(8936002)(316002)(44832011)(478600001)(16576012)(86362001)(5660300002)(66556008)(66476007)(66946007)(2906002)(31696002)(83380400001)(8676002)(956004)(31686004)(186003)(26005)(6486002)(36756003)(16526019)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Q1+RsuI1NfLwoXwKIuogKzT52K2SsCApPedWYfrfp0qrB0W4wXkxkwHQ1+ssokKwCPO6yQCOVzVNOUHxGz3fnKmc+6tvVs+4ciLUJhqLS2JyAs9/KJNGf4GDVpaf2PejVsWe8dR70AwZS2SoHqKc9JPYjzQtdO/WIumkZMqgt7XKrvQmz+iDuiTue5DnMW2XpZAQMBSO55tUv969GGzxc27oTv2jZa5IADPJUYHKTrbzNLdf7L5Q14MpPcpVchNSka6s9ePqfNf5y3u3EA+tfUheJ6WDNq6dUg/FsnuzSflCN21pqxnVWEBeEtfRH6NwfRSyW+q/Vnmc5/IoEWsqBkfMs4d8JaN2mgStghUjlXyyMQaACFdG+ti3emKmZPO+gSUL3HYfN6rGurWeavAM3WTv0+0DoW2/jxGX5TkPg7pRqZ7J86QVqWtWjD9nCdxISOWEg0/lZPSXtTHHcsxgSHNP4v9FJwZ/+nl8Li5/XGjoVgiYqS91mKN2hvm0YPnnwjC15yxr5SHeA6VU/7Nm5ZtQGAHVFgJGaxI4Q3x9ldvT6c6RNm4ECc+n/3iASgiBG1PbaflHGZHBDFJsoRHQLrzDynRr17RVdn2+0Z2tbbDFxe15b5zMpz3B9fsPJMY18/UWMnELX9OnspN+TTHw5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8343df7e-6dd1-4642-a22d-08d8648c6240
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:28:58.3894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQIpd4WxzfLRw3QmBCCEsKFC/h3uEoJKm9FgN40v4ereMes9rzGkucIDHKTa0SKUUXPNPKVmKjAlqiTtcHFeKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

Am 2020-09-29 um 11:08 a.m. schrieb Kent Russell:
> The VG20 DIDs 66a0, 66a1 and 66a4 are used for various SKUs that may or may
> not have the FRU EEPROM on it. Parse the VBIOS to check for server SKU
> variants (D131 or D134) until a more general solution can be determined.
>
> v2: Remove string-based logic, correct the VBIOS string comment
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 34 +++++++++++++------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index e811fecc540f..01208519f9d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -34,18 +34,30 @@
>  
>  static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>  {
> -	/* TODO: Gaming SKUs don't have the FRU EEPROM.
> -	 * Use this hack to address hangs on modprobe on gaming SKUs
> -	 * until a proper solution can be implemented by only supporting
> -	 * the explicit chip IDs for VG20 Server cards
> -	 *
> -	 * TODO: Add list of supported Arcturus DIDs once confirmed
> +	/* TODO: See if we can figure this out dynamically instead of
> +	 * having to parse VBIOS versions.
>  	 */
> -	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
> -	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
> -	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
> -		return true;
> -	return false;
> +	struct atom_context *atom_ctx = adev->mode_info.atom_context;
> +
> +	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
> +	 * we can use just the "DXXX" portion. If there were more models, we
> +	 * could convert the 3 characters to a hex integer and use a switch
> +	 * for ease/speed/readability. For now, 2 string comparisons are
> +	 * reasonable and not too expensive
> +	 */
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA20:
> +		/* D161 and D163 are the VG20 server SKUs */
> +		if (strnstr(atom_ctx->vbios_version, "D161",
> +			    sizeof(atom_ctx->vbios_version)) ||
> +		    strnstr(atom_ctx->vbios_version, "D163",
> +			    sizeof(atom_ctx->vbios_version)))
> +			return true;
> +		else
> +			return false;
> +	default:
> +		return false;
> +	}
>  }
>  
>  static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

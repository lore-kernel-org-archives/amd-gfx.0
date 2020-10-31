Return-Path: <SRS0=2WS1=EG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BFC388F7
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2020 08:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF6720756
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2020 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jwa0gUbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF6720756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC746E188;
	Sat, 31 Oct 2020 08:48:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6956E6E188
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2020 08:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc6wLWjPjpZDkkkyZz25euWUUgY5AtDe+7xPnKRET3fUgezA8HPfsBAWKFb8r1Zh6+GP/z+QoO2Gh3wVzWSxbhaUHcHHUYlmTcHrdVk8JyNwCvn+XyVxbYMCRd3qFjJ8UymB3ttEj3+ipPO3WZ5c8CFhajl9ad80h58V1JYAiUh7oBo51t11G6MyGRTYNfIYObGj3ADf63QOmwcUrPPVxPHUxV6WBZ6jhgAMzQMns16FJuhVzx8h9Dxo+n9Wjz078r2I/Z2wRnZgRqkU4gT9kD3UQrGNGEdm4qUIfm7SyO7aa8ZpbvSp1sRIqsF9mdXPl1pBvKIA6bTh/4wWoULi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB8WIZPUVLBCb0BNsunipr9RN70Gk3J6F23CnNvVd44=;
 b=LBbFjKDRDHdnTfFQ2u+0mn8gw82CJ7MX0kaNtsLWg3UPWXgomTiyy2BEBqQdYWbyGJDeFLFh18GIwVj6yrOQ65Vz5DGsoqoxIASPX0fhUempI+VgsQgKiCLMkMaU5tDoe4SbyXafSGOe1wTx7wECbWBsXyKyMOwpIbbIM9KR9jSv7YTGgO0Ae3xMGP6i3JWY1LXzpTByCRglHtdmy+RWaMOOjm16GUDZGLfvXVm3TDRXJSzLsRXVz+/r2qk54zXgpPVQhWR4/MyR7EvBHICW3I7Q83kzFOjp7rq9Ns0+93sNPyOpYm59fUO/8YYeAOASfWVKs2bgp9d6Q9CTCzbTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB8WIZPUVLBCb0BNsunipr9RN70Gk3J6F23CnNvVd44=;
 b=Jwa0gUbeGsQDmAJNbhCCHsFJUbfgwv7Ndo4jQjxdveprrCk1JnDrdO+WcjIpAHf39KPLxOzXY4VRPdqPwTS6rNKwfOlX9pu3PIZ6M5037t3ZLx8TeHTxYd3qWo9cKVEA1B4IwWA2mBN6y2M7+6AxU9kHk5jp/fsz9AdldapYp+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 08:48:29 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.029; Sat, 31 Oct 2020
 08:48:29 +0000
Subject: Re: [PATCH] drm/amdgpu: replace ih ip block for vega20 and arcturus
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201031030619.16173-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <2a5e5d8c-7bf1-7c82-d338-7de6e92a47f1@amd.com>
Date: Sat, 31 Oct 2020 04:48:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201031030619.16173-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Sat, 31 Oct 2020 08:48:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a547716-8f14-490a-3b08-08d87d79bce1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43426AA99C67114340DD474D92120@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v4XYiUcPiFk72gB6jqksA8/aTDTjqxCIVSeHNYAuxYeojj3UnGq7IC//jusUFOW+ebgVynoe7IpFeC84AxM1zNYKb2unGEXLqU6ct+MbgBOGO1+AD4KcAHdA/Wm7h90QvGpmJrrH7vJCVFHWKuUPFYcwa3KHrIfSwB0x+rrt8IajXFxLBbxSOAcXfg9kfYw57pOCLpF0eqBsB95gBKOXa91VRP5gKitV9sNpfDytEoPBGIu9oRQiQZYYXHJqtgfWq8aItJkkmg99SqTPSfLhBPtEhBGTPP0UW3QBNc48kv3l1Vga1iVQ9yON+z8ybT0GkgxMb+cK6GowSQqInI9E94R2LBPApljqDHXE+Kyla1XeMv8TawJlbrgicxtd92Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(83380400001)(26005)(36916002)(5660300002)(66946007)(53546011)(66556008)(66476007)(956004)(2616005)(6486002)(52116002)(4001150100001)(86362001)(44832011)(186003)(31696002)(8936002)(8676002)(316002)(2906002)(36756003)(16576012)(6666004)(478600001)(31686004)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m6l7u4sXSAdFbxStXkc6tDMPbMyvhKSCIqXvj+P5uylp18xVq43/EAwHx/OSQd+sMmxYv3OLQJNyq6hclx43zd+pMYXhqOzuGC1eYgPW/RCQ2zsZpldLQvEfycUHnvBywWcWk7WLpVjpk9uVxcN2V6SmVRCuYNzefOUPwsRBLzdyN+IqroveovpdfuX5SuxXRyU8r8agm3Es8EGcyMdXNG3MPJQc7l0t+zPs2X+AyAbwMY4bgH+1v6yEoRlMtesfIcNWTlqpi4iOE9RsjfXuJT1Cp3y0ItM4E/ffNgnZ3eRkL0fKtB6tPY0pINK0hcf9uheWdnLE98LwGJZTlHMUzucNXKr4A0JVvPbfkbhCkj0IIkGT7WMbpYT44iaBRWvYjc44PWNYgJKmPoJq9v/MHE3Kv0g0v2VCYsmv4mtRZvgzKYWENFtc1iQbCDWNA63MdXTSWgKZQxAymDBA7E3euKSMqYZduyonr970XpXHvqVlu3rCGMZxZkw4rs+jq47Vv09+tzs8hxOM98GnM7GawbvjLy+Y71Ts2OwwHNsEcIFrklkNVJVn4nftyY/xqFG3ZfHNIDz6MjKrmybEFU7e24AV+awKF4iZxZCvPgGxDh3QM56qcTTgV6rlpuJpzov36BMCEoLnnvHtjj6j6Tk4fQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a547716-8f14-490a-3b08-08d87d79bce1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 08:48:28.9891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FElKZ8GYqWyBVe0s/yEh6401QeaPG/WlIAkerMaWLRUaf1zI9wJvaAr3aP62Bym4gOw5G0s8ot4JDP7KbNuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was previously applied and reverted and should have been reapplied 
after some fixes in navi10_ih.c. Either we forgot to reapply it on 
amd-staging-drm-next or it got lost in a rebase. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

On 2020-10-30 11:06 p.m., Alex Sierra wrote:
> [Why]
> Vega20 and Arcturus asics use oss 5.0 version.
>
> [How]
> Replace ih ip block by navi10 for vega20 and arcturus.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index f57c5f57efa8..fc5b11752931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -62,6 +62,7 @@
>   #include "nbio_v7_0.h"
>   #include "nbio_v7_4.h"
>   #include "vega10_ih.h"
> +#include "navi10_ih.h"
>   #include "sdma_v4_0.h"
>   #include "uvd_v7_0.h"
>   #include "vce_v4_0.h"
> @@ -734,9 +735,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>   				else
>   					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>   			}
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			if (adev->asic_type == CHIP_VEGA20)
> +				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>   		} else {
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			if (adev->asic_type == CHIP_VEGA20)
> +				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
> +			else
> +				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
>   				if (adev->asic_type == CHIP_VEGA20)
>   					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> @@ -787,9 +794,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>   		if (amdgpu_sriov_vf(adev)) {
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>   				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   		} else {
> -			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> +			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>   				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>   		}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

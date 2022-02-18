Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693D8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 18:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A0810E6DA;
	Fri, 18 Feb 2022 18:55:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D7010E6DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 18:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+5g2e0hkaZL8cFm5yhROJXC3NFAAxBZFFxIcJE+hkuSGDIZBVGIwIbBehDJy1lK981Vqgu8oG61IGOksDA6NHc0U9JNDqadv9mtSY4pPJvQMi9YPhzHHcsuR4XWunRlTtIhIVLMFz5FAsnfA8EV8CTJFUAPcIN2C5ccvjdqhU0UER1Wu1L6Bplw8nCoIkyTz3FmpSC/oeKG2nYDkyWm1cO4Lf2e+NfI10+FqemG/d1G70381ufAuW4P+k2k6kziWzhsKFMtdbuiylt8F7iRfzgivfmTJO2YSUtTv8hrP+nc90NuMS8Ojg2YDVmEKcV0mb20RQIXz5bCQkaQsk8rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNoA+E7jdjfIzfU5Cl5mJDHuOTiG0m2p4C3Hpn+xL/M=;
 b=Xnuv5BvvHDwhRsZVNf9N5eAvfxLX7odCe1wLV0Fz+8VxRsxpwAcRfc7rF9epCPxlHRiBexQMZL5gsCWziMDybQ61xfg3KdvtaNVz1Ztyp8ciF7dVeTn0X3UY0wz4xOJle5MdT8ZqILgeno7a2W5FUNwvD8tFQKiaVLnFEOei7VhZy7c1lRQ0539BhyP7HvNgQr+bKngonixF4eKEsk5KYOdfdepuYVccYqVbqUBTiLubisY2nFEdrY+wz+/KfNOCVxwbZvCe/6aqRwc8raqeGcwNK8YphZyxNFNeW9UoFK0Drl6Ti0bDPkCBuNHVop1E8aRBWtb7sIbb71gNazoB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNoA+E7jdjfIzfU5Cl5mJDHuOTiG0m2p4C3Hpn+xL/M=;
 b=k7syVJ1utZNQoPKGFyqP8NfES2vr3+GtgiCJeM1cQRXmUKoQB1TjBHB7WkVaMOXg3cuwqypwMjGZNxMN0R3YTU7FSmC7zslOQBOmUn1pW2C9Yv9m6aGPb1uSi6Z4cMF647iqmBbOL+Vftg79S0Pveo1VOCdNR+6Nurpr6I1zA4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 18:55:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 18:55:22 +0000
Message-ID: <2563b4e7-0c99-b5b2-ae3c-544a8d8216dc@amd.com>
Date: Fri, 18 Feb 2022 13:55:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Add use_xgmi_p2p module parameter
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220218165349.7489-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220218165349.7489-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37f89b0-5b91-4045-66b5-08d9f3103767
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36821221F1F38984164E261392379@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAO7Zr+NY31PQKFU32nzZU140nNQxTWq3nAAchA5Kj31c7Yo8OjXNCqk7t4ptt2gg0U7u3zRRPVn52C2hruMUWshbNKhIgeRNudS2tlpoJD08SdITHNj2RdnwPXqwMfUXGjF8rrj9qyxzRY6EFPdtclEmf6JkBWm2L9u/fTHhc9l+bb9rVHJLraXxOnZ5rSb+5D+IK6SxTo55As0KZ2IquATAhudJBQkXuh1nR4izMGr4HwjDURTYf4DBHf9Us58OPDXe0oABObntzYdo3DTkvQi/BTJJu/asbNUoTNFsa1mErihgocljrzmKbom8pfXh8QIq5k4+sM1jee9TReYbB5Kfw0HNifCxOMjA5LHe/YHICeYEUYSoGD/qcE0whJKs9rnwp7QEIV1sfkozFOCmMyiGRSLqRuGr2wf15aMJ4fu95lkbmy+S1RoSKCK68XuneErU6UDrmudaltvaIcJssQKA5WQtBPx3ayEdjJB6nz6EPqy7dPHO3ryOCa+VYiWSHliYiDPUGxV1OR16Gu2Wd8LKcREEsL/AlkBrDsfIX2goFjn+hC0UTcrqsV/adPJBgLKCOYPrLAKBu+EHYZuszwzfF/d+BKTIpTZM9EaeMBZCdcdues5DfIKcR2pLQV1RNsJFzRRTUy3Px+XpgpdA+Y+Zv4Xjxn7C2Sm3KQRfIVS/LzvGGLEWXt0jRCilNyFW2i82nxTnpbl2FmQJiSClDHxzt5INmzscLVppa2aVELkrWMnDIFkATmWT7w+Br23
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(66476007)(2616005)(31696002)(38100700002)(66556008)(5660300002)(316002)(8676002)(4326008)(8936002)(186003)(26005)(508600001)(44832011)(2906002)(83380400001)(36756003)(31686004)(6486002)(66946007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSszUTdPemhBd243VVo4U21uT0lmL3NrS3MyOWJBWjhLNDA3cVowVUVYdWJi?=
 =?utf-8?B?cGRLdmtIWm1UMkloNzl6eWpVblhCeVovVTUyVWJTOGR2eGRkczdGODdLZDlo?=
 =?utf-8?B?blFySEsyNlgvb0NrYlZ4NWhobS9UL2kzL1Ivak1GQ3NSU0lkakp4ZU85MTZF?=
 =?utf-8?B?a0pCOWEvTjRGSENVR29oeXYwSG1RZ2FRSGlCdnN2NElzdmYwNzFuaWdSUkZF?=
 =?utf-8?B?MkxOZW9BMEpHcHNRdVFVSkcxRUtENGpFTUVyQWduK0E5QXhUbW9zUjhBYWtR?=
 =?utf-8?B?YS9nVGtXcVN5bmx5UVN1cks5RjBBUHlndC8xMTdxOG9HTmthUW90RVhSeGxL?=
 =?utf-8?B?NCtLYWVtUWxJekZTRTVUUi9kK0lsUktTSUZYbnFQenF1dG5hVTBXLzA5L0RX?=
 =?utf-8?B?eGRQeWczVXlJTTNOakxISVFmSXBBaGZlN2I3dXJXQ3BVcUlKR1dqVVJGSy9p?=
 =?utf-8?B?T0Z0RmpSQSsybjMxZDdBbFJaekk2TUVtbkYxdmZyZ2tVeFg5bks2MnFVb1Zo?=
 =?utf-8?B?U0d3ZzR2NkxETnQxM0ZLdDdQL1MyZWFsRGlpQUhwZWVTV2thWnQvVXFHaEJI?=
 =?utf-8?B?QlA5NkFTN0RvN3p2NzFFQnlOeHBmVHRFMzdkUm1zNGNkM0pVNWx4dE1GdFBJ?=
 =?utf-8?B?Q0tSb0dLaG1zVG1XaEZaMGhiZk5JNFM4SlFHS1ZEKzV0RWgzTGdCbDNVeXNF?=
 =?utf-8?B?T3NmckJIaVQ1UGR4K2o4ZkJ5QVA4aWF4eDdVTEoyV1IvTytMYzBzK1JaSjUx?=
 =?utf-8?B?U2xtVndhemNtcmp4SXBPK3N3WEY3TXdhNW1uN2lNaTVXY2ZmanJqWVpFTDJy?=
 =?utf-8?B?UHlUUVVTd2FjcVFmbW1WLzJCZHFSazF2WnBjVHZ6dC9LaWs1eXJjSFZydGVF?=
 =?utf-8?B?WktBMTdDZHpjOWErTmdNNmRMQnVIczlNVUd2U2I1MDN0bW03cXpyUTFUaDd1?=
 =?utf-8?B?Vm1qYnY2MWZmaG5yQWpNb0Y4eVlmd3JxWndsd1crMlhSSXpULzUyY2MxcmZK?=
 =?utf-8?B?TStPNTVRV21xUDhDRTVmTUtzYllqVEJpeTdKRTFIOS9xampZbDZOSW1LQ3Zm?=
 =?utf-8?B?U1hNSGJRT2F5QnJxcmtIaTY4aWpvMEVxV2NGRVVGNDB2OW9WazJIZmNiRnQx?=
 =?utf-8?B?aS9NempNOEJhejBxNlhKRFVpY3BESGtGVG1XanN2eUpKS1Z2dFRKaDczVnJk?=
 =?utf-8?B?VmZnc2Z4Q2JQYzVvL2JwWkZ6OG96VWpRUHlaTTJrclFaTHZRdU9tdnNqSndj?=
 =?utf-8?B?QnF6WUpVS25Ib2d0Uko5YVVSZ0xLZkdZNFlKOEx2ckR4Ky9OekpHR0F1ZEFB?=
 =?utf-8?B?czNnVzRDQUd1d2srR2EybStiQ2JsK04rVGhyU1RBbEs1bmd6M1k1M3NFWUVs?=
 =?utf-8?B?b0xVK2g4a004bTgrblo5WmlSamxyYnQ5NG5zbVloaVJhdWtZRjRoeEgwVFZv?=
 =?utf-8?B?aGszWnJuQ3RvR1lJeUFrdHFTTDE5ZWZpc2NhTzI4Yys1eFhhNms5YXlGSG9l?=
 =?utf-8?B?cFBBNlY5SG4zWWR0SjhYR0RtSVlEc3ZtTHRickdWOFRtZ0dzUzdtaUJYS2k2?=
 =?utf-8?B?empOUGJhZjJlbENZQWJ2OU1CSmN5YjlWQUgyblpPYVA2TzhOenYzc29BK3JM?=
 =?utf-8?B?eWhEeHZYa25VellpYVQrRTVCdkVLT3d6UjJLVGFVNXRlSm00bEFQeHVYN2Iz?=
 =?utf-8?B?Z0ZzUkhOWFZTczBoVyswbXpyd0N2YmZVb2N1bkFmbThTbkQxQ2g4d0JMcTlD?=
 =?utf-8?B?eGZqNXVtZDIyUERrWGhlelhHT3diU2tIOFdCem9lRCtsemQzYmJyTWdTRGhx?=
 =?utf-8?B?WXpBdkFCMWJUdk8rU2hTcUZCVExVTTVEYnBWTXFqSUQvTWo3TnFQRWkrV2ll?=
 =?utf-8?B?elp6WnFBZy9LMTR3MGFudTA0dHkrRGNUeUFiMythSFdqWFhrdUVhaXR1MGlV?=
 =?utf-8?B?a3d4bnFWazhBT1ZENElNWGFPUFpycmhlV1ZrQkJTdG8xSU5BTmZORW9ZQlBy?=
 =?utf-8?B?cmYxN0F2VXphVFhaTlBqY0lpWmE3U2tDSThHdUZVRjVuRzFCaTd2VnNhQjV5?=
 =?utf-8?B?SWhsKzhGSEs2UFhIaWVlV1M1QUVlWTY0ZXNnWnplc0JERHNLZWxuOWxSNURG?=
 =?utf-8?B?T0xqcHRob0VST0pmVTZISlFIZHZNeXBHdjFNZldHN2psOU5XUUlNSDFHYlBR?=
 =?utf-8?Q?WRkFlLyhmJJ6QXUoq2XSspI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37f89b0-5b91-4045-66b5-08d9f3103767
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 18:55:22.5435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvXUCNnc/zTtQtjaydwahmEurJdaHtcyrjV4YRoMlbLxhg5hC2aPgNsb+cx2patbR21CVdWIyjzHGtNNCkA3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
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
Cc: luben.tuikov@amd.com, jonathan.kim@amd.com, Harish.Kasiviswanathan@amd.com,
 aurabindo.pillai@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-02-18 um 11:53 schrieb Alex Sierra:
> This parameter controls xGMI p2p communication, which is enabled by
> default. However, it can be disabled by setting it to 0. In case xGMI
> p2p is disabled in a dGPU, PCIe p2p interface will be used instead.
> This parameter is ignored in GPUs that do not support xGMI
> p2p configuration.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 ++--
>   3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f97848a0ed14..7e95d8bd2338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -217,6 +217,7 @@ extern int amdgpu_mes;
>   extern int amdgpu_noretry;
>   extern int amdgpu_force_asic_type;
>   extern int amdgpu_smartshift_bias;
> +extern int amdgpu_use_xgmi_p2p;
>   #ifdef CONFIG_HSA_AMD
>   extern int sched_policy;
>   extern bool debug_evictions;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2f8eafb6cf22..6156265f3178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -181,6 +181,7 @@ int amdgpu_tmz = -1; /* auto */
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
> +int amdgpu_use_xgmi_p2p = -1;
>   
>   static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>   
> @@ -677,6 +678,13 @@ MODULE_PARM_DESC(force_asic_type,
>   	"A non negative value used to specify the asic type for all supported GPUs");
>   module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
>   
> +/**
> + * DOC: use_xgmi_p2p (int)
> + * Enables/disables XGMI P2P interface (0 = disable, 1 = enable). The Default is -1 (enabled).
> + */
> +MODULE_PARM_DESC(use_xgmi_p2p,
> +	"Disable XGMI P2P interface (0 = disable; 1 = enable; -1 default, enabled)");
> +module_param_named(use_xgmi_p2p, amdgpu_use_xgmi_p2p, int, 0444);
>   
>   
>   #ifdef CONFIG_HSA_AMD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 207cd01435b5..bbe1bac61f15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2330,8 +2330,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   #else
>   	dma_resv_assert_held(amdkcl_ttm_resvp(&vm->root.bo->tbo));
>   #endif
> -
> -	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
> +	if (amdgpu_use_xgmi_p2p &&
> +	    amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
This does nothing to tell user mode that XGMI is not available. We need 
to update the topology information as well. For that, this check needs 
to be applied at a lower level. I think amdgpu_xgmi_same_hive would be 
the right place. If amdgpu_use_xgmi_p2p is set, amdgpu_xgmi_same_hive 
should return false.

Regards,
   Felix


>   		bo_va->is_xgmi = true;
>   		/* Power up XGMI if it can be potentially used */
>   		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MAX_VEGA20);

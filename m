Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D20C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 13:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421F4613B7
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 13:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421F4613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3F66E3FE;
	Tue,  6 Apr 2021 13:15:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A2B6E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 13:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKVlsDo3FI9P5unfLR0OsW3f+N66nfIwkbQ/e7Wnxee1bs1VI29jGdvC0XWCJ5QMKo7c14IvkM3I89FuyuIevzyUmWrorDWkzHz6ygMWjDV/nTmmEUTcC8idR/KD52GJktl5xJdhA/iWyoGQ8a7+TnO2LtgnydGQie6rPj8f+d6mZ4a5zk/fveXfYwM+/m2FXkRWb06C6kezKsWr+00h1+XF8FVgplPx46kUCOpuTOSdCavBK/SdvtE+ECZ51weGdbV+rVxfsnn2vpjy5MLYXaU817uSXjyzuZm+vgXAPbp3Nnh5xB2J8ZXI39Ivlb+3wxv3LPx4lhJGZoBEdRXkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1YdN10/d/saGZCwXQ5FaKs5ke4lVycRmajKnCjg+Vc=;
 b=R25puJykLLQhfInCr64916ja6dGL1SUWR239EIEbG/IQfla2QQZNtcYfA9MbQehnTFaz7RZbmLSwHsFDVncfl8BueQF49kWlApKSsPN+M+JM0Od86KHpIYLsIsvNDcNsyeL1UEsukZbpf5yvDCzfM78dn65DhngFwapgGaOfsN3OTeWIrAlA7IeqmCua8WiUUatQajseuFgTYgiHvkhVoSrtq0kPXroxYgGGkHTAANXAfnbC8rpqp0govRupPAbh8XJSQH4WjYEeg9/xl9SlLy2NfaoK/Z69cm5nKvzxfultGvGA/vsnRDd9A0hnLtLgyLgoJMuGcWqI5EjukIT9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1YdN10/d/saGZCwXQ5FaKs5ke4lVycRmajKnCjg+Vc=;
 b=HgZGZ363daPNkUzesBPhsxJECcuV7zyAyY5Grm9cHq7enZHVMdnhL2kHe4+4Z0G1EnvPAHhIF0tWyRzaw8JLXoPLjko+RJTs2RBhS4X+0UoLTj7lK0xNuNoPf1o+Ig36EpfRnQJBpTedbnBewizfbg+a+whal824lIORwQfKciE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 13:15:31 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 13:15:31 +0000
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
To: Jude Shih <shenshih@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210401032134.1083322-1-shenshih@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <0b3fe044-3a3b-54da-3a9b-002688d6d3fb@amd.com>
Date: Tue, 6 Apr 2021 09:15:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210401032134.1083322-1-shenshih@amd.com>
Content-Language: en-US
X-Originating-IP: [198.84.165.113]
X-ClientProxiedBy: QB1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::42) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (198.84.165.113) by
 QB1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Tue, 6 Apr 2021 13:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5861000-415d-4aff-9226-08d8f8fe0e11
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB534153B6B90E96D1BBF6998FEC769@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smgUuweWghPHBo1SOTvKSmPEQsENgT7uxTVo9tGKUcdbRzfOMqZ6U/djG0q+BTn5onpTN1gOCM7RAmiY49fy7FI2cN7IqNp6apMa/P9AOMxQFiNXc6L8iGaYSHFvEFpdUI9LC+lgoCgw/cgStba5h4rFvzXJFrZLnAAY0gB5tN/HNslhXtYs4Xm1oSSJtPep8EnsVTzv/MtkxgnUYmXaZo6vlp7ZnvQafA3LXPZClTadzOgA1oc1C1ad/W3SS/nos7/z+GN5vPxodyL9Pg3zC1BvjQCRSzOniJ+LSXTkNlJjS2Uz58rxPhmCwd3N3aFNLN6kOS3vm7dat3XpGWZ1i5BmWWxUqMPqNxm3CpNcD6JWpCxmjOOJuo1uU2qLQgyCWdVkNWHLOwMYUmB/P/cgnm/+1Y6cSRCEnpMK8o7pV0NamGMPI1GLbUn3Un1oVOlaWx8tKHbSNayIEL69yNUyMW/lrt/QuJZoMeGVCXcNY0xC20VRbe7RxrnFAsY3ZkyYpyqq+dQ+QkpccInWRaFA+umUhoCbeVU9l+oF9ic2yzX90awlDsPag9l6v8YB7eS3kOEsNokbGJxa38ccSqFrDx0ceQe6GD395UwZZZY0vqy/+Jdhpw+WtQWPuokHDUlQBCuRcKhjWCTsrQmjC/TLp7W0mLzg8uJZQou6iB6Ia5DwB3XEAec61IKzdPx0xEvB4KwRGeKDmmuEeSdcXJiUE7CDHUDmA1m3NrPwGcJi95A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(186003)(16526019)(2906002)(66556008)(38100700001)(66476007)(16576012)(316002)(83380400001)(86362001)(4326008)(6666004)(478600001)(6486002)(5660300002)(26005)(8676002)(31686004)(2616005)(53546011)(31696002)(956004)(66946007)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFJUMEZtemgvTTQwT3FRTDVMdlJhL3F1aFZkNVJmYnlpRlBBckpCcDYySHhq?=
 =?utf-8?B?NGVkTGFhOWdvRVJPek9tOUM3YVh5UDdiTVNpWm9YYnNOaGk2WmRLTTQ3dU0v?=
 =?utf-8?B?ZEhNd2pQMm1kU0xGbG8wdmYrMWFidFo5SU5hWDZSOFkwRVRqa2d4TEh0K2N5?=
 =?utf-8?B?V1RrREFHZFN3V0NnT3dCa0lzNGdhQTNrd2VtcjhwaGl3QytnZFVuTDVMVG56?=
 =?utf-8?B?WWluVmRPYzhaVlNZazlRaFVxVGNnaXUyclFNMlJ3Yis3amdaRStvaDJxMmhV?=
 =?utf-8?B?QlY2S3JzR3JjN1NkWkg4cGN0ZkNldEU2aCtJVytVV01FNGUvRVFmUzF6MVlN?=
 =?utf-8?B?OStHcU9pVlZFanU2K0xDRWd1TjdVbkpsMDdoRTNUTHQyV3BBN3pyOHYzSUFT?=
 =?utf-8?B?cFBJRHZCUm5xRjBLcTRDZDhwaWRRWXMyYjdoZU1USmlzTXV5ZGZRRzYwZXky?=
 =?utf-8?B?c2ZiWEZaMlJNUUUwUm9JRjRvOWpWZ2xra1ZwOTJwd215VlI2RjFSYzN1TEEz?=
 =?utf-8?B?UkQxYU5mL2VkWGw2ekZwckpmSU9ncmZNeWJEWUxxZmZOdTlaN2IybjlTd1ps?=
 =?utf-8?B?TEl1ck1zOVluSmNvbVFXNTkyMkxha0c2dkZ3RGtWUFVsZTBiQkppOXMzOVU0?=
 =?utf-8?B?ZGFGZnk2NVVkVnVuNUlOaVRsenJKZFdRMml0NUE4WFBtbU5OVHZRTDlOVVpl?=
 =?utf-8?B?SEFCdDVMZUJqRC9tVHl6cDhuSE02WUhoK010K1ZBZlNMdmlPWndXeTJIZjNz?=
 =?utf-8?B?ZXVmNVNDbWZkVXphY1BHblJxVDRGSVA0ZEZvSW90SjA5R1R1VEVvZmFPY3BR?=
 =?utf-8?B?K2VFZkRiWU5mcWZkSHAwYU4yVDFzNU0vMDhBK0M0NU1sZHAwaFM4RktDTzZv?=
 =?utf-8?B?OHVZVjgyWVh6RkFNVTBtSVFtQkNMSGQ5YmlIVlYyenV1OXJXV1JndWoydzdy?=
 =?utf-8?B?d3p3Y3FNbENPOHNtMXN2RVgwR3FCbWhWeU9scTQ3RlR5anNxR0tYVWV5cUxH?=
 =?utf-8?B?bWRJODlKWWNORnVMWk0vbHFsVmJqVzBRa1hnT2k4K3JURlIxYWF4ajkxL3BP?=
 =?utf-8?B?dHhWV0x2UTlrVmwraXR5VXQ4Wmg1aXpZN1NMSUN2elVrSEdZU0xkK1lWZ2hy?=
 =?utf-8?B?VlpEYkNnclE3Y25FSzU1aE1CV2dwOHVyMHlQRTNpVlBMelNMM0VqSW5uWTI2?=
 =?utf-8?B?b0lMNjFWTnpCMXN3WHFMSHNQWGpYRVRwdnhHSWovcU8wV1kra1ZrVGZvOUU3?=
 =?utf-8?B?TmdwWk4zbk1XNFcybXNta0srcFZLbFpEb3dtVjBoaDM2UzVPT0tyVUcxMFpT?=
 =?utf-8?B?Wk9mTGtUNCt0bTVHUVZxV2VCNE5QRklzUzZGQXFudUtBTnk5bzdsMmd3cUE0?=
 =?utf-8?B?bWppTUcxMXZ0YjBZMUtQV1c5Qk45SUtYOEUxVjh5aFA2V0xoVklxYlY2YmpR?=
 =?utf-8?B?OUF6L1NtTmpza3dpSmlWcUE3TGpOMmUyaC9HejBWR2EzWEVrS2R6bjhBY3lm?=
 =?utf-8?B?dVpvUjIxS3NnMHUrNldjRmhEUEdxUmlDSFFyT0pkbmRiZ2dKdjc1OVlLdXdI?=
 =?utf-8?B?dmFxamN1RlowNk5RVHJ3N0FTNlZ5bnBwdFp2NU5Xa2RPN3VncDdRR2JSOGRF?=
 =?utf-8?B?R3g2aHFaU1F2VzM3M3gwV1RabnBIMXVHVTBYZ0tHODI1N1BzdUZ1V1FwSGh1?=
 =?utf-8?B?enpvTlRLYng3NEY2SXRnQzRJdDFQeW9RTVh3L1pld3RqWkYwY25UUU9sRmpn?=
 =?utf-8?Q?vuTo7VM9ha93eGfReK7uebBFdvXRx0ARQ30tv4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5861000-415d-4aff-9226-08d8f8fe0e11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 13:15:31.6161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwOiYtsSzyvMLt4iIpgFmfDOwuac0MXvQ07w9a7o8jsocDjWtbtO+8DFk0Q0Ltr75gyWMzZog0A6CxmDlH8PeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-31 11:21 p.m., Jude Shih wrote:
> [Why & How]
> We use outbox interrupt that allows us to do the AUX via DMUB
> Therefore, we need to add some irq source related definition
> in the header files;
> Also, I added debug flag that allows us to turn it on/off
> for testing purpose.

Missing your signed-off-by here, please recommit with

git commit --amend --sign

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                   | 2 +-
>   drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
>   drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>   4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 963ecfd84347..479c8a28a3a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -923,6 +923,7 @@ struct amdgpu_device {
>   	struct amdgpu_irq_src		pageflip_irq;
>   	struct amdgpu_irq_src		hpd_irq;
>   	struct amdgpu_irq_src		dmub_trace_irq;
> +	struct amdgpu_irq_src		outbox_irq;
>   
>   	/* rings */
>   	u64				fence_context;
> @@ -1077,6 +1078,7 @@ struct amdgpu_device {
>   
>   	bool                            in_pci_err_recovery;
>   	struct pci_saved_state          *pci_state;
> +	struct completion dmub_aux_transfer_done;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6a06234dbcad..0b88e13f5a7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -159,7 +159,7 @@ int amdgpu_smu_pptable_id = -1;
>    * PSR (bit 3) disabled by default
>    */
>   uint amdgpu_dc_feature_mask = 2;
> -uint amdgpu_dc_debug_mask;
> +uint amdgpu_dc_debug_mask = 0x10;

If this is intended to be enabled by default then it shouldn't be a 
debug flag. Please either leave the default alone or fully switch over 
to DMCUB AUX support for ASIC that support it.

If you don't already have a check from driver to DMCUB firmware to 
ensure that the firmware itself supports it you'd need that as well - 
users can be running older firmware (like the firmware that originally 
released with DCN2.1/DCN3.0 support) and that wouldn't support this feature.

My recommendation:
- Add a command to check for DMUB AUX capability or add bits to the 
metadata to indicate that the firmware does support it
- Assume that the DMUB AUX implementation is solid and a complete 
replacement for existing AUX support on firmware that does support it
- Add a debug flag like DC_DISABLE_DMUB_AUX for optionally debugging 
issues if they arise

>   int amdgpu_async_gfx_ring = 1;
>   int amdgpu_mcbp;
>   int amdgpu_discovery = -1;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 43ed6291b2b8..097672cc78a1 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>   	DC_DISABLE_STUTTER = 0x2,
>   	DC_DISABLE_DSC = 0x4,
> -	DC_DISABLE_CLOCK_GATING = 0x8
> +	DC_DISABLE_CLOCK_GATING = 0x8,
> +	DC_ENABLE_DMUB_AUX = 0x10,
>   };
>   
>   enum amd_dpm_forced_level;
> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> index e2bffcae273a..754170a86ea4 100644
> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> @@ -1132,5 +1132,7 @@
>   
>   #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>   #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8

This technically isn't on DCN_1_0 but I guess we've been using this file 
for all the DCNs.

I do wish this was labeled DCN_2_1 instead to make it more explicit but 
I guess this is fine for now.

Regards,
Nicholas Kazlauskas

>   
>   #endif // __IRQSRCS_DCN_1_0_H__
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

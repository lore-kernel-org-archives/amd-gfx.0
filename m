Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A883CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 12:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF3210E191;
	Tue,  8 Nov 2022 12:53:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A7510E191
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 12:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn4qeob7qzoCHrmD1n8jecw/oE6r1jMwT2pKosGAuwuNHf7kOLNkh7EUHRCFXQqi/WQmaXHKlOGAIt0ZBnktTgp8/vWB6tqywxzi33LS2Y13JqK3c3hBxIjBm7cUb1nxS/IgjqCwdJU2wrmnGWL+6tUwMWYZQ7GS2V9GZi3go9a6i3dRyGFNNZRYrMUXS3pT9ZoHXTjKWNFpcomzXb3XJHMu6LzjnqmQW1ifzfBxJL9xZfvawQhx9J4TCNyLdozPydhh8ir5iSMaQZSmWoZskqCQMdUafFiDo79KEmvCuv2ETBAelbNYQlBspfT6P3ic6dZ+M5qxvcJ2v5toRhEL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frobtDkSodnG/6+3X6ffolWPjL4rNDOAhhsVNIep/c0=;
 b=iM6pmRVRs3Qwfu7SNnKPTKDC9ZkaTfloeyXHDFSBZSUzdlNaKkYJHrENPTh+BSwvfOGboF2MWKf6lE5NfNNYqwkyDgNz6L+ju1JqzGkejPftNm+xzt+QMn6XsYbphkPvQX6bF8Zf/I5mCoxq3BFj3h+AhpKufo0uIbqAUda1zN4Yb9T1mdOLL9WgsqMyRLG+lQlgmmO4vryY3srBN7MooMZZKgTgWoPeEeBqD7l9Oz2MyTHh7/+whLfZnmEwb1M/oK9ANBW6zSkBPzZip4e2GhcrDhSNYX1E5M280DfY/FJ4yv1tsVYIJBA/XeXUbqvaC73+8aSQjxq2+IuNLOLtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frobtDkSodnG/6+3X6ffolWPjL4rNDOAhhsVNIep/c0=;
 b=PJKCyoFn75DtArknJHugDpjaUrRcXDEKsBEV4OQKRxNm2CHVHys1z75pEMCDWHg3XeWLey40phC/OovyS1T/ECezxWuqCOY38+VBQdcRST47mNGSFdNAo2Ua9B13pA8vjPWWgxB7fXtDYjpLiPt+DtXjFhTe9/EyGIsQgN8pjpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 12:53:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 12:53:31 +0000
Message-ID: <444456c6-b66b-615a-f340-a5867073a496@amd.com>
Date: Tue, 8 Nov 2022 13:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221108103236.8777-1-Tong.Liu01@amd.com>
 <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB61343BF910630C9BA31F8916903F9@DM4PR12MB6134.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1cb7d7-7ee9-4b41-059e-08dac1883cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDzawpDH2gcdt2mqw0/wWzc4R2qkJp4poFNRXjOeRTcPWwS9eGaWSq7WoGYWN77pPdkROk8x1DOyGcjYbcXpH709Cn4mOtKynKalvC0shVseUffgogh9rIUqTyZ3mipfEjQa3EehkWp/4zcQ09GbRNu22+dKhrva8F3DSkL/3LISl/WRB+hCNK0r6FYrSwDwFXUTlUFmswJ26YB41NZS8NQKXD/zTw0wPVsOTGgpkcwgwLAP8R5tWtGSUg99/oro94LtnM+rhZDeSh6DcbjgCeGf+k/mr+E54mrdXy+AOMs1C6xOYed1MB8xwXuCBwj7fehRuZdOKM+n6RXO2lqZrLa32hI2d4QHqzkID+RJGlrZlSrH+wgzBjzXSXWuhejnkkIR/T2Ygoe06OkFp3ugn9eYujeUzf7GSDVSPvN4iLtENSzV0BpBRUuFOQFMIA1NpngS0wrF9zsrcd8RueWGDMQJ2+iXhcG+b9gYvbxnfIzHuL6u2A4B0PApcReWuhi9jYlb7Vs2VyVzFeXDYBhfX4XCQatizTpfvwc7KSwwglJrlrhsAJXtLVbQnQNehtNDnTJltOUCH/TTPtOHHYqWdkSprMnwEpa2IN3jqeJ3jvc/+qXPsbklG2sXokg1y8CnjFpjMxbqWK2rzbgvNjZ0CkUy6qwcDnMNshy3PbR8x6H9xQzluLONyDMo1FmFh7DteJ7gLBcIfaYxU2LOFbUJYcb6XgNpun2janxJGagiwNDRSTepcLJKrI9t4cIHh/XXLJCvY9YDXR0daZbLyH4+3hXsfk2KOJoIjvrBiLgQpLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(66556008)(8676002)(26005)(53546011)(41300700001)(38100700002)(5660300002)(8936002)(316002)(54906003)(66946007)(4326008)(110136005)(66476007)(2616005)(86362001)(6512007)(6506007)(31696002)(30864003)(6666004)(6486002)(186003)(31686004)(83380400001)(478600001)(36756003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNwSlpRQ21ya3gxZndGVFpHL0tJMW5CT1ZSaktkSlBsQkpidVV2R0VhRnov?=
 =?utf-8?B?WHIxcUhXQy94RWxGRmx6c0lMS3JOaWZxRFNna0s2WTBybVNaQXA0KzZKRFZT?=
 =?utf-8?B?dTBET3JYQzhzMkJiMkxnVnZoMWF1RWRNc2xWVk5OYmY3bXQ1c3hONmMwNlEy?=
 =?utf-8?B?WUtuZ1BPbm9nZ01yY0ticEhqeWR4Y2g0endlMzF4THA5Q2J5NDd6aWk1NCtL?=
 =?utf-8?B?eWtVK2JBNjUyU3h0MHZrTzBWVlJDdDVjNkdDOHBlS0tpM2ZHUGZGOGJ3QnJY?=
 =?utf-8?B?OWNsQTZhMnNzRDAxVkVOMlYxUjFzcFVKUEs3VlZTM1RlSHpCL2s4alFjcmRw?=
 =?utf-8?B?RWFTK2pLZ1ErQXBVUmNtRHRkRWswTTUzaCt0eXV4RkpzSXRKNUtRWHNNWFdF?=
 =?utf-8?B?TEt4UzE2bXpyTWV5c1Y4blY3SlZCRVhNRzVZbDJvdHdybTVCOWo2eVlRbjR2?=
 =?utf-8?B?WDBHcktoc1E0dXlUL0NMZ3I3Mk5TZTh2WVByOFhJbjVrZTNlNGdoZXNjbk9L?=
 =?utf-8?B?dmhHL3JaNjBpeDlsR0FSK2ZxaFU5NFlTck8zNFpsWTdkOW1DNUFJVm1KR0VR?=
 =?utf-8?B?TXB3T1pNNWYxKzhPOXlpQTl3MlJuUjR6UjE3NVNPc01tNEUvTTJ1cWhPa2Ji?=
 =?utf-8?B?M3NIckVrVjlDNVFVMDVOUWozSXM5cVBKOE5xbS9BT0FXbUJ1UkMyb0lpellD?=
 =?utf-8?B?ZG92WkJPWjd3aG9wL2ZKQXFSU3V4RGlSL2pidWozVEVMeU9tTGZmQzVDQ2lM?=
 =?utf-8?B?bFB2WnZDelJsdVh5M2xpc2FqY3Q0MmRYUVhaR1dROXVEUmg0a3RibUpaMnVP?=
 =?utf-8?B?UmM1RmFwVFVINCtaTHBNdWgvdllPQmlrRisxdFVKOVk3Y1VyM2dZRUlyNVJ4?=
 =?utf-8?B?cXFGckMzeXpTeVFzbGFYOWlKK2xNZDQyNXZGQXh0d1JYaW9ORXZ1TGU3bDVS?=
 =?utf-8?B?eW81VjlYVlUzclJoUUxpNWcwMW1jYklHdisyeXN3WmlITy9JRDFWbHV1cy9J?=
 =?utf-8?B?L043WUE4Q28za0VFNEdjVXRJY2EvSHI4REpvcURwRGp2UjBOSFQyMW8rQ3Vm?=
 =?utf-8?B?VVpaOHBxNXdwL3JZYVlBVGpXY1h6MnJFcHpxcXZHd0dyN1hSUkhjS2ZJK3ly?=
 =?utf-8?B?UlpUODhTelVoMFlvaDVyVFJwbUNnWmVnQU02eXdWTWdBMDR2bGI1cGM3Rkh6?=
 =?utf-8?B?U2h6UGptYTdjZnZhUzlxODJybTB6SEZtSUU4Y3p6MWxXd1JRdnVUYklsTkkx?=
 =?utf-8?B?eW5NMEQ4Z3QvUjBXN2cvNXNkV29PanJCZkV5NUJ3VS96MTFGdGpZSU5LejNR?=
 =?utf-8?B?a0ZvT2VUUVZsanBtKzJDMk9MRjlEdUF2NEJuLzVKcVN3Rm9qRGdTMldwTnBs?=
 =?utf-8?B?WVF6dXc4QzRWQ2ZBQjJNc2FFa1VFOVZQY1pxRlVKWUJxSmVBWDFyZjdxUUdt?=
 =?utf-8?B?dXl4N21FREwwSS9OOFJTYmh6Yjdiem5zQjQyMkxKUjVUeE5Ielp0NnlMdmVD?=
 =?utf-8?B?WWQ3aUM2U2U3U0JvbGNaRFF1NEFiaDdzaDBXbDhmL1JnZndINjcvN0pqUlRG?=
 =?utf-8?B?N3FGQ0hvWEIrOG95MUJiMEFUSUVBbDRKOHVZanBDWXhpTE40ZGQ2VXRySWpx?=
 =?utf-8?B?WnBmenF2N1cvVmpPYkZQMEpIS0YyeDh0L1VNYklYMUVJc2cyRmYxczVsd1Na?=
 =?utf-8?B?WkQvTzgyWmNvVDFienBFVVphaDAxQW5GT2xKbmEwbE0xTFZ4VHh6Uk94RTVX?=
 =?utf-8?B?WUhOU0pLSndON1NHTjBIdExhVkVzVGJhTG8zUUlCR2hDMVJkcGFWeGV2bis4?=
 =?utf-8?B?M2VJdVFyKzcxT2lxV3lEYk8wQWVtZjlNak5OcERRK0s5U3NZVzNyV2thQkV3?=
 =?utf-8?B?c1VzQzRRZDgrS25zYmpuT2IzUnhHeUNxekJ0T01Jdkl2cGhKSWthU3FwOThN?=
 =?utf-8?B?b2wrNmxyK0tGNFI3cSt5Qk1qb0w3a1B4K2NoeVJKSElJWTJJejZ4dTBnSUs0?=
 =?utf-8?B?V2VadVdEd0lZOHQwWFYzTjRtQUc0UDFQUjlWYWZBbmZVRkZ0WWFzS0pXVVpP?=
 =?utf-8?B?TVU3NEpyRlV6bDdkYU4xZFQrTzRlcnJBY1hzNXNtUEgxcFR2NjdkdzRjZ0dx?=
 =?utf-8?Q?WFPuWhGwerE7ZoTY7LpzOwlJW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1cb7d7-7ee9-4b41-059e-08dac1883cd6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 12:53:31.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uxPA7Tlk9ds5/NZve+XsdWCKE/5w6uNDEEeo/0BpAaekNFqDHusIw6y7EcskbQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Sohail,
 Rashid" <Rashid.Sohail@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Esther

well there are a couple of things which you need to address before 
getting this merged.

First of all the patch you send out uses dos line endings instead of the 
unix line endings. Not sure how you manage to do that, but please use 
"git send-email" instead to avoid that.

Then your patch contains a bunch of white spaces after code warning 
which checkpatch.pl complains about (after ignoring the dos line ending 
warnings). So this was clearly not properly checked with checkpatch.pl.

Then the kernel coding style usually says that with a multi line "if (" 
the next lines should start after the opening "(". In other words intend 
with tabs and the whitespaces. I'm not sure what editor you are using, 
but there are standard settings available for basically all large 
editors which does stuff like that automatically. Please try to use one 
of those.

Regarding the casing of the values it's a good argument that you only 
move the code around, but the general coding style is just extremely 
questionable. The defines should use the lowest necessary integer type. 
But it's correct that this should probably be part of another patch.

Regards,
Christian.

Am 08.11.22 um 11:40 schrieb Liu01, Tong (Esther):
> [AMD Official Use Only - General]
>
> Hi @Koenig, Christian,
>
> Refined as your comment. By the way:
> if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT))
>
> This part is the old code, I just move it out from the original function to shrink the function size as your comment before. And now I just removed the first uint32_t since if remove both will cause "warning: bitwise comparison always evaluates to false". And I tested the code after removing the first uint32_t, the code works well. Please review the new patch, thanks.
>
> Kind regards,
> Esther
>
> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: 2022年11月8日星期二 下午6:33
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR region firstly to make sure TMR can be allocated at 2MB
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>   drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
>   4 files changed, 192 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index b81b77a9efa6..032dc2678d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
> +		int *usage_bytes)
> +{
> +	uint32_t start_addr, fw_size, drv_size;
> +
> +	start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
> +	drv_size = le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
> +
> +	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +		start_addr,
> +		fw_size,
> +		drv_size);
> +
> +	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +		/* Use the default scratch size */
> +		*usage_bytes = 0;
> +	} else {
> +		*usage_bytes = drv_size << 10;
> +	}
> +	return 0;
> +}
> +
> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
> +		int *usage_bytes)
> +{
> +	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +
> +	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
> +
> +	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
> +	drv_size =
> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
> +
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +		fw_start_addr,
> +		fw_size,
> +		drv_start_addr,
> +		drv_size);
> +
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +	}
> +
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* driver request VRAM reservation for SR-IOV */
> +		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.drv_vram_usage_size = drv_size << 10;
> +	}
> +
> +	*usage_bytes = 0;
> +	return 0;
> +}
> +
>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						vram_usagebyfirmware);
> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
> -	uint32_t start_addr, size;
> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>   	uint16_t data_offset;
> +	uint8_t frev, crev;
>   	int usage_bytes = 0;
>   
> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
> -
> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
> -
> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -			/* Firmware request VRAM reservation for SR-IOV */
> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -			adev->mman.fw_vram_usage_size = size << 10;
> -			/* Use the default scratch size */
> -			usage_bytes = 0;
> -		} else {
> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> +		if (frev == 2 && crev == 1) {
> +			firmware_usage_v2_1 =
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +					firmware_usage_v2_1,
> +					&usage_bytes);
> +		} else if (frev >= 2 && crev >= 2) {
> +			firmware_usage_v2_2 =
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> +					firmware_usage_v2_2,
> +					&usage_bytes);
>   		}
>   	}
> +
>   	ctx->scratch_size_bytes = 0;
>   	if (usage_bytes == 0)
>   		usage_bytes = 20 * 1024;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 585460ab8dfd..4a73cb314086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>   		NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
> +/*
> + * Driver Reservation functions
> + */
> +/**
> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free drv reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
> +*adev) {
> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, NULL);
> +}
> +
>   /**
>    * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>    *
> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  &adev->mman.fw_vram_usage_va);
>   }
>   
> +/**
> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from
> +driver
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from drv.
> + */
> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.drv_vram_usage_size == 0 ||
> +	    adev->mman.drv_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.drv_vram_usage_start_offset,
> +					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
> +					  &adev->mman.drv_vram_usage_reserved_bo,
> +					  NULL);
> +}
> +
>   /*
>    * Memoy training reservation functions
>    */
> @@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/*
> +	 *The reserved vram for driver must be pinned to the specified
> +	 *place on the VRAM, so reserve it early.
> +	 */
> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * only NAVI10 and onwards ASIC support for IP discovery.
>   	 * If IP discovery enabled, a block of memory should be @@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9120ae80ef52..339838675b11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
>   
> +	/* driver VRAM reservation */
> +	u64		drv_vram_usage_start_offset;
> +	u64		drv_vram_usage_size;
> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index ff855cb21d3f..c0f56ae653f0 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1  };
>   
>   
> -/*
> -  ***************************************************************************
> -    Data Table vram_usagebyfirmware  structure
> -  ***************************************************************************
> +/*
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> +      driver can allocate driver reservation region under firmware reservation,
> +      used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> +    Host driver would overwrite the table with the following
> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
> +    } else {
> +      there is no VBIOS reservation region
> +      driver must allocate driver reservation region at top of FB.
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    }
> +  } else { //( NV1X and after)
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> +    }
> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
> +      driver can allocate driver reservation region under firmware reservation,
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    } else {
> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
> +      driver set used_by_driver_region0_in_kb = driver reservation size
> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
> +    }
> +  }
>   */
>   
>   struct vram_usagebyfirmware_v2_1
>   {
> -  struct  atom_common_table_header  table_header;
> -  uint32_t  start_address_in_kb;
> -  uint16_t  used_by_firmware_in_kb;
> -  uint16_t  used_by_driver_in_kb;
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  used_by_driver_in_kb;
>   };
>   
> +struct vram_usagebyfirmware_v2_2 {
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  fw_region_start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  reserved;
> +	uint32_t  driver_region0_start_address_in_kb;
> +	uint32_t  used_by_driver_region0_in_kb;
> +	uint32_t  reserved32[7];
> +};
>   
>   /*
>     ***************************************************************************
> --
> 2.25.1


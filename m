Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54184C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 09:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCCB10E420;
	Mon, 20 May 2024 09:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMnyySq9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C3210E5A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 09:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHF6S/yLE1vSz6dHIC0VndCLHVEHGimnOlqVHEQ1hgloKgeniU7dhhPG+Q4adE5V/v5FxTDBPpblmpebBFWlgtvV+9HE6XwugU9vO+awNrVcEKPt+ll0aJOrtzWUJw1cZAfaWQzJfTmwxLNaC8XVWCbfI0llkcHmCOH95XyvPITEyNTwq1PrubPMxTPZNEUWa2bI93CWVTobQnDu1Kn0x+n/YKpf0os1YoMOODmEjGMdmQIpUU0a5z6RveTb9DqsAWhNIumN9lRkJsFEMzZ72IZhjyHgAoQtResMCrBZM9SIpnXNoXdnSI/G5LeLGn1uma7+aXAzPvHGIAPgSWgbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhg3X/uxrDMuVAenuFRXdrfyvKLXQpQzyic5V9O/QwE=;
 b=EesNzYRgAtDDSlQitWS/oH/VWN0pct3gkwIqwgwr/nWLU9Z5+Y8/zielz19nFnhcv9Xc3XBcpCgy1uXJ7KGm5KC5Trvp7dWaqnSi2HYxIdYPYSQUJo0oWeY9K8WSAueihJ1mNT5J/3pRbqECZ+53aTurUFXijYDA4QcchW8ZFLfneljoVYHQNIvyEIbwglBR8nN0AM3Uu841FxnpOCKvLbGOtNl3osZd+lKQT7jLYdTMBC6AibHxRNMydVLEsFU/mi2iw5bMhmTLcRc+sS/iElSXeOYXNB6BogTltTX9Ctzv8npKJYxXfImu8Jpp+5FComNEqbr+KktHgOG08z2qOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhg3X/uxrDMuVAenuFRXdrfyvKLXQpQzyic5V9O/QwE=;
 b=CMnyySq9FZNVaFu9TiGEVDZ/sRW0XUFkTA1MxrC3riPB+z3UBHBsP1Xj7ntL9UkgnDFZ166C5EqqRcRq0OrzC1Y5nTppROIgYOUNwq6JJo4J38dLBmFsBuW5kQSjChU8u0bWwAcWV3EMircRDok9D5JmUZe6Fxhy7PDvNr0wapc=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 09:37:15 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 09:37:14 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>
CC: "Liu, Aaron" <Aaron.Liu@amd.com>, "Yao, Longlong" <Longlong.Yao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
Thread-Topic: [PATCH] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
Thread-Index: AQHaqpYeOQVfqXmlvki4s1XsCrHdDLGf2crg
Date: Mon, 20 May 2024 09:37:14 +0000
Message-ID: <DM4PR12MB5261F1F851D2DF6817A9D05F9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20240520091409.2435612-1-shane.xiao@amd.com>
In-Reply-To: <20240520091409.2435612-1-shane.xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2b586da5-cf39-48dc-9643-2d3d7951f3fc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-20T09:24:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|SA1PR12MB6872:EE_
x-ms-office365-filtering-correlation-id: dcf2e651-301e-498f-bc42-08dc78b06ec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?67lQlsYJ0iLJMFDxBpUObCoYzGIJnTJmZJwdG9vL5fmXy05S7UiY4/+HxnEE?=
 =?us-ascii?Q?B6E4uVw1IkybbKKsmm8b8X5MF7Ri8j2V7oOXQG8A/KGRAIg047sLru6Qh35d?=
 =?us-ascii?Q?NAG4pngsfCkvNwF+d4YPPVaf9yvOesxdZ7CDLrHHZOH8ZujaiuMXsnfqoXjd?=
 =?us-ascii?Q?9wzozj5FBIfWqq9K5DNUyVnWrwucd67j7Xn2ai/192XLJrkxnYEFpHojLvM3?=
 =?us-ascii?Q?SxzBRp/PFcj3Jrd3IKSZQ+dKzeParftr0IdStIFWdKjFcXXmrPxTQWB4ASKQ?=
 =?us-ascii?Q?hfdeZfGb0Ay+MLCRQgabF/tquK5jnCLuEeiorOwlXSxUHyZhEvg0th+7gO7A?=
 =?us-ascii?Q?MIr0jDWSmxz0aphLOWDe76bgnTd6DAi10uCnJxyJMyi1kb9ZWedP0icbpiMs?=
 =?us-ascii?Q?Dn5nzbDMJ2jWWUgsDNDwHh67n/IJPYbUkh6GiuUJZWA1XDhd4AJBzXU0v/qy?=
 =?us-ascii?Q?OqiR6hsPDlLxKqUVwjmmFqUXOvyPWl+Vr3BSZYDV460PKoUw4vtKHb8RqqGl?=
 =?us-ascii?Q?oxExsbDJ9E2+MEEtb4iTrq1TlZXZCM3BG19dFUMwBF+QtU61u+TAOSkxaeNU?=
 =?us-ascii?Q?QXAZiHeA8GpnCD52LJSxC6oA0PGa9XIsUkJNjoz615VStv43/zLH3K9GNfWH?=
 =?us-ascii?Q?KCZ4TWqz06vbQ13Vm+HJUFK7EPYt8H7IQrSr9icTIT+z5OoPgethLHlveLYe?=
 =?us-ascii?Q?3KuRJx2HwXzqcikC/x4zYZSn4o00EXN+Y2yZY6am8cc/FzYbQ108y1+PTeqt?=
 =?us-ascii?Q?lcRDTjCPIe6X4xPWbfITDXnby0Y6UBLXgpsKQ3dVZN5MbCeS96MJ/aZK0VRw?=
 =?us-ascii?Q?4bDZNfKb0ZEGdddpD10Eg82yatTfxsr+OqGf1hcZ4VDgGNxBX4AY9Sz/bQkp?=
 =?us-ascii?Q?ttaor7EMeeXDIbLlTatSHg/SYtNx7tBhPtPleuTzQmhx6N7F0FeW+/n1nyvt?=
 =?us-ascii?Q?Bfgo+bgiktEzFAhAkdJBaTaD24xS2+rWBIEH+MY6PE/uKPjQ8HlsD6/grLVs?=
 =?us-ascii?Q?GOAfOizJTLnGGauN9u6ktTquJfOF0pt6wCb/R3tM/zeQf+7jzTI+7eUD9qzg?=
 =?us-ascii?Q?wlLDGd81nqFrUI3rv9xqcljcoBai7FDxJu1q4UNvoZCkAMH+w3S6k6OD6NGf?=
 =?us-ascii?Q?e4nTe6wA45clANPGtW82Kw3Ec9xuIYqERVLTwcN4uocdtvxtH/GMq0ciZhFN?=
 =?us-ascii?Q?3aCAH9Qs3GewJUW6o6XWCWe6YaSOuyeP1bLQTGCrDn7drpp5ganlUC5u1V4T?=
 =?us-ascii?Q?zsZLVr8l4S8FK3Bit3sSM2uGpImG6kjvIQ9bahbalsjd75ZC+Le9J/zd9CF7?=
 =?us-ascii?Q?63ehmI8GFaZQXaPslO4d3Du1Cf/c1FiGVY3phK/HprvFVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgZOjF2aiN+edhO1Cghjfb+7LYY53Fa4mLlJo6ue+rogoznmnfinRtRwz9TO?=
 =?us-ascii?Q?1DUvgVJ4VjARqWpaEZ9jBk2hkCFLY8EHKJLr4vUlJAF6kl707LPvlD3mQbjS?=
 =?us-ascii?Q?iY5d3HehbcbkFeTZ3SLBcnHZ+/ZGPygAovussH4dDTgp0bqDLU1D1pf0i55I?=
 =?us-ascii?Q?6Vg/eC2tfPewukDN46BB6CwrXeAW2AOKFpPd7ms1V6fel33AroBE0LwjP0qp?=
 =?us-ascii?Q?cvTVo1vLRegSdsUCyzD0w5JQFyHbTZwlspnRdAPj1f2GR7wxAN374DMsEsM7?=
 =?us-ascii?Q?OlC5qO6oylXhpJ2xXEmMXAFgt/+6LMnmfqK9gPCSDd+0vel6mq0RSfrLrqSd?=
 =?us-ascii?Q?3kwvKNGN099OnaqagGoFzFl1hfCjYg4ZHykwz0H+pcJxneXhWSIBCt7gg0QZ?=
 =?us-ascii?Q?1wgjaF6wWedWvmiCJpwXtjYSGNUI2XoDy4NKt+germVPAqC50kbWCeIJMqK+?=
 =?us-ascii?Q?FIkEiCGklboDhYHmP4uPGQFX3LqbiGbdsnwTiTLMA8KR3gZITWqBZPHan0Rz?=
 =?us-ascii?Q?nd8zz7uHMhxlpUDVpC89zKR4a3CN2WsfcHHtbXDAtlfvcrOeOtX38u1qOJaA?=
 =?us-ascii?Q?kcjIt2EFREFrBlz1I0zCckyh3xAGKly53LV1X3kG5TDEEyNZBUBXo0LY7j/h?=
 =?us-ascii?Q?/zBCqJHjlDVD3ZfIiuoq00/vHBjjN4BNftg6H6pKOsbQIXDpsJCAgtdlC26R?=
 =?us-ascii?Q?vb7LP/OKcskttHmeFUxi/o8x6wA+AgW17mCvI+xDmU3eGYaNTxd3nrfKM6oL?=
 =?us-ascii?Q?4Ekpnlg1OOWDLoMBCr2ZdEnXFhd6Chn26kUU41QK6i2TQDoae1ri6vVfV1st?=
 =?us-ascii?Q?5Wtchv6l4NNxMkoQPy8dfVtFBarHU+6Nv0zN697VTy0C+sHmSI5zvsp7OWU3?=
 =?us-ascii?Q?2CSWFksRQA3wVKs00hWZz1EaWOW6k3W9t8VARjd/ykokiX17Fk1hQZWuuAs/?=
 =?us-ascii?Q?E6kD2ODLhEvL9E8bBE0Bla/9OGjy34W9WDo8lVaL21Nlp9RZu9pdsWIwM68y?=
 =?us-ascii?Q?c6GvFV7KANbs4a2kLWPAyFLatco/Y7wWbpTTYkiDNCqvf21YmoynbxjhkIpu?=
 =?us-ascii?Q?zmu1m5wRRk5SqbhXPapLK3XXhDaRAKsmuGYjOtqC3gNulwRtAnRg/dxPwPUr?=
 =?us-ascii?Q?Rs1VlNgXBWbMY55K5jaU5X4dzb4Kimh/9NwpXwXWpe5d35JKxSRcg6ue59Nn?=
 =?us-ascii?Q?j+DWIaY4cn4r9w9QR9FMdkII76I4thjrfaGXe1gblPpX0LRD3lE8z8Hn3iyn?=
 =?us-ascii?Q?ttVvZqhLAiPy7q+u4WPRTaaInrPi/ektJ27MaY7zo5F1h0oHSeJqYTOmaJs9?=
 =?us-ascii?Q?QMkCzQi9tDCr6uE2HZqKynlqcKO5vWgPx2gseP9satTXTPCkejBUIWw+ORKB?=
 =?us-ascii?Q?nkrD9PDLbPLxD6WWsWRSFte7C/qrfkQNsUZxJyiQWCY6/QRiBDZaexGju5yp?=
 =?us-ascii?Q?UR6n1HXyoHCcAL8d+EUgKDAV19W5nMzVPp2Mxii3kYgykRYRD3wVX7R3uJ+h?=
 =?us-ascii?Q?ea/uMFHADDPMSsLhz1d1Eg7u/cwc2LkVqF8Jep+YydrNxHCa1kfMO+L6KhUp?=
 =?us-ascii?Q?1iwSGAB8vCNEMIlZJ7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf2e651-301e-498f-bc42-08dc78b06ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 09:37:14.7087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSJMPsOMpAeClVTeA0WmkTI2A2pCFzBRDzJUESjBBOyvpa2isCuGn91g1kERtylMoovQRf5ZFBOxpRCHiItinw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alex,

I have changed the macro AMDGPU_PTE_MTYPE_GFX12 to clear mtype bit before s=
etting.
Add one parameter for this macro, and some related code needs to be changed=
.

I'm not sure whether that's the ideal way to do it, but if it is, I'll impl=
ement it for all other generations.
If this is not ideal way, could you please give me some other advice?

Best Regards,
Shane


> -----Original Message-----
> From: Xiao, Shane <shane.xiao@amd.com>
> Sent: Monday, May 20, 2024 5:14 PM
> To: amd-gfx@lists.freedesktop.org; alexdeucher@gmail.com; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>
> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Xiao, Shane <shane.xiao@amd.com>;
> Yao, Longlong <Longlong.Yao@amd.com>
> Subject: [PATCH] drm/amdgpu: Update the impelmentation of
> AMDGPU_PTE_MTYPE_GFX12
>
> This patch changes the implementation of AMDGPU_PTE_MTYPE_GFX12,
> clear the bits before setting the new one.
> This fixed the potential issue that GFX12 setting memory to NC.
>
> v2: Clear mtype field before setting the new one (Alex)
>
> Signed-off-by: longlyao <Longlong.Yao@amd.com>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
> drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 23 +++++++++++------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index bc71b44387b2..99b246e82ed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -116,8 +116,11 @@ struct amdgpu_mem_stats;
>  #define AMDGPU_PTE_PRT_FLAG(adev)    \
>       ((amdgpu_ip_version((adev), GC_HWIP, 0) >=3D IP_VERSION(12, 0, 0)) =
?
> AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
>
> -#define AMDGPU_PTE_MTYPE_GFX12(a)    ((uint64_t)(a) << 54)
> -#define AMDGPU_PTE_MTYPE_GFX12_MASK
>       AMDGPU_PTE_MTYPE_GFX12(3ULL)
> +#define AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype)  ((uint64_t)(mytype)
> << 54)
> +#define AMDGPU_PTE_MTYPE_GFX12_MASK
>       AMDGPU_PTE_MTYPE_GFX12_SHIFT(3ULL)
> +#define AMDGPU_PTE_MTYPE_GFX12(flags, mtype) \
> +     ((flags) & ((~AMDGPU_PTE_MTYPE_GFX12_MASK)) |   \
> +       AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
>
>  #define AMDGPU_PTE_IS_PTE            (1ULL << 63)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e2c6ec3cc4f3..f2d331d0181f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -461,17 +461,17 @@ static uint64_t gmc_v12_0_map_mtype(struct
> amdgpu_device *adev, uint32_t flags)  {
>       switch (flags) {
>       case AMDGPU_VM_MTYPE_DEFAULT:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>       case AMDGPU_VM_MTYPE_NC:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>       case AMDGPU_VM_MTYPE_WC:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_WC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_WC);
>       case AMDGPU_VM_MTYPE_CC:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_CC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_CC);
>       case AMDGPU_VM_MTYPE_UC:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_UC);
>       default:
> -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>       }
>  }
>
> @@ -509,8 +509,8 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>       *flags &=3D ~AMDGPU_PTE_EXECUTABLE;
>       *flags |=3D mapping->flags & AMDGPU_PTE_EXECUTABLE;
>
> -     *flags &=3D ~AMDGPU_PTE_MTYPE_GFX12_MASK;
> -     *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
> +     *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, (mapping->flags &
>       \
> +                      AMDGPU_PTE_MTYPE_GFX12_MASK) >>
> AMDGPU_PTE_MTYPE_GFX12_SHIFT);

This is not correct. I will correct this change in next version.

>
>       if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
>               *flags |=3D AMDGPU_PTE_PRT_GFX12;
> @@ -524,8 +524,7 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>
>       if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>                              AMDGPU_GEM_CREATE_UNCACHED))
> -             *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> -                      AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> +             *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>
>       bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>       coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT; @@ -
> 534,7 +533,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device
> *adev,
>
>       /* WA for HW bug */
>       if (is_system || ((bo_adev !=3D adev) && coherent))
> -             *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +             *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
>
>  }
>
> @@ -707,7 +706,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device
> *adev)
>               return r;
>
>       adev->gart.table_size =3D adev->gart.num_gpu_pages * 8;
> -     adev->gart.gart_pte_flags =3D
> AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
> +     adev->gart.gart_pte_flags =3D AMDGPU_PTE_MTYPE_GFX12(0ULL,
> MTYPE_UC) |
>                                   AMDGPU_PTE_EXECUTABLE |
>                                   AMDGPU_PTE_IS_PTE;
>
> --
> 2.25.1


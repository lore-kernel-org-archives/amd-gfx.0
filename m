Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF534C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 03:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7E110E25E;
	Mon,  6 Jul 2026 03:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnWLm5WI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54D810E72B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 03:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6yVo6YBItwMZ7Ok5IWSXN2KOw6UqFYdivpXXOeRtwBLD0lm1Wt2j/YMfG4U4tmmoIiYgbkn/diVwzuJOgSYtrTzc4RJJmAiZ+xl+FBfjwT3lAG9YroNDp+BxtacxYNp2NNwSN7/aH5sqcifG/Nx97juofQyHpQmq+t75DtUJrtGSiW7BpnbKcrIDPZPtMMHWbX1Gy6bpOKcRlnUr6DN+j6vSYVHXZK3boKtOLdAhYZDXXQeh8i57OpDeEP8cHtE7riw/nhK1yMpfFAF7h44Fp04A/wKbvJAqV9bBFrUQl0Yx+pWyQqjYO0Yq7yxr4PqzAsrugM6BgWlD2r4fjAaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzFj2kZYKdTqVHY1kCTBhgZHKlfwlOQsHuXyJmZR/t4=;
 b=Cd+mR7Ul8dfcW+NxP4AMDgbqhzKIUhox3UHF2QVHO26No8OspwuLJNlsRFh5AHGznUFbvTV83rO1h66L3kLI5G5eOa+MlWvAy/WMDkm0pj3n8WoocqQnBy8W+gqJPrbL3eo1MMd6/9eSHO0AlklQvCiNx2SqUOANd9JMdr9h2OmLZFYFEtKz2JylJ/IrdQ/aS/Dhv7XNTIpJ5QqcWqTdaTMXmZ3uvAFoAmEEZkfLAU/YAuq/2rbeZlPQOEriLlCb/jTEkecleYl/7FQALo4v9zw68xBYxHPXsHOznjMthPNi+X7N/ERA4iAVyZWmo5qKiI41RK4UrGIjTTDB+DmELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzFj2kZYKdTqVHY1kCTBhgZHKlfwlOQsHuXyJmZR/t4=;
 b=FnWLm5WItF0uKhFUVAgyvJzifMSI5kHpKPf8yM6zYYs1rd6CpS3WUlayHCbmUmLByGFjJjlm37dOTu7126XJwBnpsOJMOITCohq7um4WR4Ex3ZFxsghMWTHurOcgfOqQ2TGCibzxvyMk0ixb6WX/jLHbbV7s0+Vs/mOG5QacPAs=
Received: from DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) by
 DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 03:15:11 +0000
Received: from DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::e392:f2c2:6088:170]) by DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::e392:f2c2:6088:170%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 03:15:11 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Topic: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Index: AQHdCg46hoK7AJ1jVUyo29LGW7AeWbZb03gAgAP9mtA=
Date: Mon, 6 Jul 2026 03:15:11 +0000
Message-ID: <DS7PR12MB8324F0652B31C9CCB29F32CC9AF12@DS7PR12MB8324.namprd12.prod.outlook.com>
References: <20260702103201.299749-1-Stanley.Yang@amd.com>
 <BN9PR12MB52571AD6187A07E48068BBB0FCF42@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52571AD6187A07E48068BBB0FCF42@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T13:53:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8324:EE_|DS7PR12MB6069:EE_
x-ms-office365-filtering-correlation-id: bb195a1e-2802-4931-81f7-08dedb0cca75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
x-microsoft-antispam-message-info: DJv/yN3j/V6wtXIp+dGJ6Ay+DfnakYUWmn9z0rqOktdb+r7OR4Qf7GYXXhgzm05Br1BpUIeivkMiX49hpnZ13PI8/5mIUORJ+loaGTUwECwsq1u+ywl2vgH7xt4pCqsZtklnjLg0ykR2BNphAHny7ua4/t3ilrnBa22VNjIga4k0NJ6TMAOLjx92M93WMQTc9rO8y9evEhYM1aODb1ksTkM3L1dA9e61+PCvBzokiCc/CdBxOQVy3GJMSKK2A306OLQdR6dUgyqHcb1G9Mm4d7mZUXX2F7lfTYk07okh9WwMUrcPG5p+maEvjJiqdBN1JGPSKGfOoINTIxpjcdqgqY6IrGQ4Ww1vpNNDUNVYzD4ThcHCgJgo5kRqlidsiEPHcHU3oeIPNrtuOkIwPQ8GTBLatwLc6XIIcDBpfvlw40ILw4yAE3bLterRqt+1aItf9VihFm8Ox4Nq5ORqOfF/JSexDJb6uCr/gocd0kkwyrYmVe4shIRBolUeXqlIUF+cnOYpUyXI29QEllX9GE308toGOZLcJ5WVygT4x/rmh+B3c0BNzw6uyVshM+eM1AvETZf5lYCiSd/0F+kZhOIACjvKWlJpfpBMONsSJvorBrwmvFDDFyFc6fAADle0slo/G8P0P9NAcvDtgyLCjqXDzWcVyDC+/PJpYJJUohfGjuh+nwIBOkDNF0VyhsI0TdTTilwOIfpUavdxFkERyZvC4MBCC2TQc88B8rXeWmkpefI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xBxwr+6VKXntX7on92bnCl5X4GmaAXIYAcU5+543clBhWhw9nXmo1WF8bs/4?=
 =?us-ascii?Q?vMm4fkhrIm0oN0psCzOULxsHRbq6d6aNUH8TZFbZvNtqV6J4/7rEQAJ2J4X4?=
 =?us-ascii?Q?PQ26CCgQsLCLempZ9hcBzY2zMPN4xPnOxSYTjPKpo7zqdV+j9LNq6zJeYi55?=
 =?us-ascii?Q?1j4q9qiM2+hqLYcZ5xOxp21lZwqEQUNxA5W+DiGAdUx36CAtcm5ZQMdjtndR?=
 =?us-ascii?Q?Ti950elXT41jkRHADU9UUXVS+2swjGf0w3nhbP10csmGdtieyEWORGkEuVgO?=
 =?us-ascii?Q?RbHQHxKRLhjn0M3gRigrvNFTsr+rBsoOMFgLiT6Kjajxqp3eMHV53dM04Ogh?=
 =?us-ascii?Q?ZTlrwAcSgbNtHiokpQjbH8ZUD0sQec33kpZMPY8TqpdfQmmD6Yb5lwYWXe2/?=
 =?us-ascii?Q?YmEHewpehwDQ9ARy/zUptp+H3vpOEAajFqFdNrnFCzOiuI+42gkNCaMEGpS0?=
 =?us-ascii?Q?0qtEyZ1kb3j2fgQpHtX9S4CIBagDbw+CJPSMIrzopq4MuCHHyn2Ryt2fcJnJ?=
 =?us-ascii?Q?SP0+kq46jCnaWOSh4XBTD/QliypHsTFGneEnXX5i8bipdGEX3CpE/aboi4bC?=
 =?us-ascii?Q?8R5i3Y151rjqh24y1GxqUxPgXQlrSa+6jcpKeJD/YnAJS1+z9SdOHgStfEcz?=
 =?us-ascii?Q?H/bk0uQRfLvM+kk2YCH0XP9b9BcvyAgg1tfneZ2WP2CsRf45BvmjxWvDYzSQ?=
 =?us-ascii?Q?luJcdsruzqHsAMMzoDkM06Fhl9MRv+vQjhqVuehKv3HI0NHJ2WYmczsexDd6?=
 =?us-ascii?Q?OHJ/GwX4RdvjNJiJdu/vHVm6bzrZKmegNeNBAAzSbte+KfnSPo2hUSXH9jVv?=
 =?us-ascii?Q?VtG7WxbiBNyezoBvKCBHuz33G1lVmlJCA/yFl5qHWI22VtZXmKvqATzBi6AT?=
 =?us-ascii?Q?BSRDWv5tB+McJxC/O4cwhc9+kJTYI5o+riBhUUAEPwrxAL3NPlBzVrUXxn9a?=
 =?us-ascii?Q?A5KzrD1Y46qmvPSxk7CoLLEvLxYumAJ0ayy2rFmNaDHotKFN5qVGnyLD2i6D?=
 =?us-ascii?Q?yLR12O/qt04ey/97AE3WJJjyoku+bNtOdn/SB6SaXu7AMW5CcMhEzVJF/+Kf?=
 =?us-ascii?Q?T+Q9Whd1Uj3xb8zagmivVQfUEVzUkX75YbIqLWAXvrfhRbIO3+GZ3+Kt/gkV?=
 =?us-ascii?Q?whbUTfrH6TWKzx+qkcuoQ6f2zRP0iYUCcSLFp+SOEGS+L85agIVEvVsEjzYO?=
 =?us-ascii?Q?ZeS2EnL9F1IyfmYLezHwbRu9NCnQsRoq4DdQ2d+yIc1c9kgiWALWJ+eVbRSH?=
 =?us-ascii?Q?+p2BdPO7Ifx7BM3XAkzhfi6kh3DTsw/wRCkOCq2e/PIV4LSA4MfaG7aPvEjV?=
 =?us-ascii?Q?inJ61YxobDejfERehSSD8H+TIqKRkN0vzKd+jPbr6ocr5uJo/Sn4P30LXtdo?=
 =?us-ascii?Q?6v1lgqdJlQuTO684U89RJXRgatVMQO817ru2xatlS5YJY1I/akKWrb2LvHDq?=
 =?us-ascii?Q?gnesg+Kll1vyvp3MQf+X7umljTf4OLMhi9rrIeq2wHeK7ueXTrKAU0k3x+q7?=
 =?us-ascii?Q?AkfOjKm5sDW6/JKMuhJb3djjT357uCc/59ymfHh6vxIL2zTdsxm8fto2HIup?=
 =?us-ascii?Q?+JXzo1MVBNvlO7t/bt+wZnE/YdT+w5RuA4MjoWYODXabfXQBOoF+IYplYf0o?=
 =?us-ascii?Q?OMYBzcQ4kPG68NfFz1adG1RJQW6ZAvdbfP0sdTxeWcO2nIntDJbEskLQJ7Mq?=
 =?us-ascii?Q?+M85nw0vpVsca7NqXJYTjKflN4HOvWXuXlzxDI8hM/O60Df+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb195a1e-2802-4931-81f7-08dedb0cca75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 03:15:11.5822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TypRXQ+ViThIA/nhok+RIS5bSJS9aH3OgEsAQK77UqXZ3fzfJFtZrnWKRSWguY3lWudJW+ujFX0shZvpMJWv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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

AMD General

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, July 3, 2026 9:57 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for
> address-based UMC injection
>
> AMD General
>
> Thinking about it more, would it be better to add error-checking logic in=
 the
> debugfs parser?

[Stanley]: We should consider the introduction of ioctl interface in future=
, so the debugfs parser will not be called.

>
> When the address parameter is set, we should also check the sub_block
> parameter to ensure the injection method is applied correctly to the inte=
nded
> sub-blocks. Otherwise, we should reject the debugfs ctrl command.

[Stanley]: How to handle the injection address 0x0 if user wants to inject =
address 0x0, currently, driver cannot distinguish
whether the user injects address 0x0 or non-address-based injection.

>
> Any thoughts?
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, July 2, 2026 6:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for address-
> based UMC injection
>
> UMC error injection on MI300 series is dispatched by the RAS TA via the (=
sub-
> block, method) pair; only the "coherent" methods are address based, the
> single-shot/persistent/ac-parity ones ignore the address.
>
> The debugfs control path validated the injection address against the bad =
page
> list for every UMC injection. Restrict that check to address-based inject=
ions
> and warn when a non address-based one is given a non-zero address. Other
> ASICs keep injecting by address.
>
> Changed from V1:
>         move address based checking to uniras layer
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 +++-
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 58
> ++++++++++++++++++-
>  2 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index af48dd2ebd16..f280a312b0a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -606,8 +606,14 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct
> file *f,
>                 ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
>                 break;
>         case 2:
> -               /* umc ce/ue error injection for a bad page is not allowe=
d */
> -               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +               /*
> +                * UMC ce/ue error injection for a bad page is not allowe=
d. For
> +                * uniras (SMU v13+) devices the injection address is val=
idated by
> +                * the ras_mgr inject handler, so only run the legacy bad=
 page
> +                * check for the legacy RAS path.
> +                */
> +               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC &&
> +                   !amdgpu_uniras_enabled(adev))
>                         ret =3D amdgpu_ras_check_bad_page(adev, data.inje=
ct.address);
>                 if (ret =3D=3D -EINVAL) {
>                         dev_warn(adev->dev, "RAS WARN: input address 0x%l=
lx is
> invalid.", diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> index bfbfdffbfbe6..063c7b0a7b00 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -82,6 +82,57 @@ static uint64_t local_addr_to_xgmi_global_addr(struct
> ras_core_context *ras_core
>         return (addr + xgmi->physical_node_id * xgmi->node_segment_size);=
  }
>
> +/*
> + * UMC error injection is dispatched by the RAS TA using the
> +(sub-block, method)
> + * pair carried in struct ras_cmd_inject_error_req as subblock_id (enum
> + * error_sub_block_umc) and method (enum inject_method_umc). Only the
> "coherent"
> + * methods program an explicit injection address and are therefore
> +address-based;
> + * the single-shot, persistent and ac-parity methods ignore the address.
> + *
> + * Keep the values below in sync with the RAS TA.
> + */
> +enum umc_error_sub_block {
> +       UMC_ERROR_CRC                   =3D 0,
> +       UMC_ERROR_SRAM                  =3D 1,
> +       UMC_ERROR_ODECC                 =3D 2,
> +       UMC_ERROR_PARITY_DATA           =3D 3,
> +       UMC_ERROR_PARITY_CMD            =3D 4,
> +};
> +
> +enum umc_inject_method {
> +       UMC_METH_COHERENT               =3D 0,
> +       UMC_METH_SINGLE_SHOT            =3D 1,
> +       UMC_METH_PERSISTENT             =3D 2,
> +       UMC_METH_PERSISTENT_DISABLE     =3D 3,
> +       UMC_METH_COHERENT_NO_DETECTION  =3D 4,
> +       UMC_METH_COHERENT_WR            =3D 5,
> +       UMC_METH_SINGLE_SHOT_WR         =3D 6,
> +       UMC_METH_PERSISTENT_WR          =3D 7,
> +       UMC_METH_SINGLE_SHOT_CLEAN      =3D 8,
> +};
> +
> +/*
> + * Return true if a UMC error injection using @sub_block and @method is
> + * address-based, i.e. it programs an explicit injection address that
> +must be
> + * validated. The non address-based methods ignore the address.
> + */
> +static bool amdgpu_ras_umc_inject_is_address_based(u32 sub_block, u64
> +method) {
> +       switch (sub_block) {
> +       case UMC_ERROR_CRC:
> +               return method =3D=3D UMC_METH_COHERENT ||
> +                      method =3D=3D UMC_METH_COHERENT_NO_DETECTION ||
> +                      method =3D=3D UMC_METH_COHERENT_WR;
> +       case UMC_ERROR_ODECC:
> +               return method =3D=3D UMC_METH_COHERENT;
> +       case UMC_ERROR_PARITY_DATA:
> +               return method =3D=3D UMC_METH_COHERENT ||
> +                      method =3D=3D UMC_METH_COHERENT_WR;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
>                         struct ras_cmd_ctx *cmd, void *data)  { @@ -90,7 =
+141,8 @@
> static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
>                 (struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
>         int ret =3D RAS_CMD__ERROR_GENERIC;
>
> -       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC) {
> +       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC &&
> +               amdgpu_ras_umc_inject_is_address_based(req->subblock_id,
> +req->method)) {
>                 if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)=
) {
>                         RAS_DEV_WARN(ras_core->dev,
>                                 "RAS WARN: inject: 0x%llx has already bee=
n marked as
> bad!\n", @@ -111,6 +163,10 @@ static int amdgpu_ras_inject_error(struct
> ras_core_context *ras_core,
>                         req->block_id !=3D RAS_BLOCK_ID__GFX) {
>                         req->address =3D local_addr_to_xgmi_global_addr(r=
as_core, req-
> >address);
>                 }
> +       } else if (req->block_id =3D=3D RAS_BLOCK_ID__UMC && req->address=
) {
> +               RAS_DEV_WARN(adev,
> +                       "RAS WARN: non address based injection, ignore th=
e injection
> address 0x%llx\n",
> +                       req->address);
>         }
>
>         amdgpu_ras_trigger_error_prepare(ras_core, req);
> --
> 2.43.0
>


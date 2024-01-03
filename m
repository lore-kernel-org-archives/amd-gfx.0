Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E0C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 02:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9878B10E180;
	Wed,  3 Jan 2024 02:25:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428EF10E180
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 02:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu59E0L51vsGoiAtx3t69aW0XWbMEmCcrCIBb06Hi5U7IJFqs0IK8Rb9qceWHd3YR9mhfht5XPfEdv4bsmQl9wkxTpFSbk82UHuHhaMTKtFBZmbQLyCZIpnHSRqwPQ3DDKGgeCycPVoGA2whVy+57gJqUe7YeSfF4F3OIXHoSQMWhAIY3erG5hTJ1cEUuym7HIqaMBJEt3ZmvTcWUxzhnacOJll7sqizrjKE+KcWyCDNtRezybQfDaaUFST+SWXBu5cn5g3+A0pZQGHKjxmW79dleuo4QE8IFyFefTw0GvVKHTv8Ge10X/T2PxH7hDT/ewb24j+MR7/bp91fd9eM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OaC/ITGR6wmF4h0F7CHvSGfYOwZ0kDU1+fWtuTaHYQ=;
 b=DnJXWeD9qe+S8ptGKhHiNOKgU4XL4YkBGObX5xlUVVuub+D+VgtOVMfPyK25E0zG2gzsfrx7wcKcD7drCwOebBeogwKhNVipBivhOUJ13UaK7djiDWGzgm5oEI1LGWBUy/RIQPvojUGUcIkFP//K46UEeXlnaSt9JEF4AQRJmAAbWeBBiMK0Ee+YvGWMOg9/KSqD3K97DRIf2fuk7sMUEpTH+vgOJag0Zk1MYnyRTyoxJspB5nH7XgusuwNKMhJaOMSJBaq8TZpT585kfXQgOE6fIQTOuaD5eTzZBjwAdF+1qN9GU3N8UAMBGtVrCoQdO8mHsn+jqYIIVKVXe1CBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OaC/ITGR6wmF4h0F7CHvSGfYOwZ0kDU1+fWtuTaHYQ=;
 b=uHm5nuKT5vZj4TTddKNDDJYpdy4wjwVKM+1IQDjrPerrznKpwrzrRVkkx0lMAjyuQ2TWal95ueV7h4bc8Es3EnagXjJuuciQ0rIyjQzjoO9pLH6rQSmR1Z8ejfC949NZfCum8TqTKPWmREx/dFPPHbsGlRaW3FdHW06GJr2uF7E=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:25:51 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::490b:4637:2c0d:54e2]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::490b:4637:2c0d:54e2%3]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:25:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
 amdgpu_ras_check_supported
Thread-Topic: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
 amdgpu_ras_check_supported
Thread-Index: AQHaPYZb4XC3ONuelUWssBKCZxtIRbDHXUAw
Date: Wed, 3 Jan 2024 02:25:51 +0000
Message-ID: <SJ2PR12MB88078E565775F4171E8FFD71B060A@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20240102141621.29700-1-Hawking.Zhang@amd.com>
 <20240102141621.29700-3-Hawking.Zhang@amd.com>
In-Reply-To: <20240102141621.29700-3-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=002f4a6e-836b-475e-bd59-8a3a8bf72316;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T02:25:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|PH7PR12MB7235:EE_
x-ms-office365-filtering-correlation-id: 013665e3-3351-4e7d-199b-08dc0c034e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caQfAtUIvKYgIA0Eqo/RiZ1iFyEdmYkqrYlUpvzhDd0uj5cmenAnVY4tX4MBbEcHHrJm2LckGox2xPjdFgrHyka3Evn+wjXnPuwLvVLOl3L2XkGNZ3/lWwGT5yA8DKXHuK78QbWzwhi2S8PsY8dj+/jTDqwp5Lv0ycAB6sBefAzHohe6d9FkBW8zG0kNAwbeyGkoMfkJ50mOHoljUrOK6XPoh2CCywnfO/aGUMjkMd/wBo9lFmMGLrseanolbWiu7zgHJoWaJGvnnti8GYFrVjrThHxov1rfcG1Op11f3tnk7LN0KgEvcllY6c1eeJmqzSOKr6y3j6CHDiqsOOx6VQMmPY56zNNBhGBjBE0rZkR2aGe/e6E10Fg2HxurlPiOOoY1Zrk3rdboMnPsHTlkEdi+4LuR185TeflGGPS9mNLJg9+XiFXhTzQmyzGZdBmCjB5mVrnV0B5u5dhe8a+K2IzW91ZlRBs2qtvi6/TnPjuKvVmmbXGK86757QefQyDq01GV4d9H7AGal4S+Hre/thGR4VF3QaW6ZG63Dg4aoMBPsSIIZRY6/NyM3yTobRufJgbrlHdAuiC4i3H53eh1ECc3aBFggetefFK2w6fAdW42/USpDlil3JwpIL57Yvf6F9gLdsQL+IKzb9KhORB7Yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(921011)(55016003)(38100700002)(76116006)(33656002)(110136005)(86362001)(66946007)(38070700009)(83380400001)(53546011)(26005)(6636002)(64756008)(66556008)(54906003)(66446008)(2906002)(71200400001)(6506007)(478600001)(66476007)(122000001)(7696005)(5660300002)(316002)(8936002)(52536014)(41300700001)(8676002)(9686003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JepM28csE2ii9zG9Xb1MuU3qE+69Ua6+EHZgdFAMTs9QM6YHjb/jb1WSkMbn?=
 =?us-ascii?Q?7U0LUqfIRPHQQHfStE10DSPpqJDW5YYxd2ItkEnQBN4AtFWng8mU+oQu9k8+?=
 =?us-ascii?Q?Ka9yc9e6nvYLfTHY44C/e30WwlXkfk0Q+Lp5nqfphZuuTfvNfFZJDTqz3Sg9?=
 =?us-ascii?Q?etG5D3Z2LtRjrgOwr41+vwB7m/3id2BXMIK4eVNeFz9iGuaUb1Rt6o/9+xE0?=
 =?us-ascii?Q?E436Jhwg91Ecw8t46jegNHdNOlVyV2QhA4y+fYt/LHI8qTr6xobr+5lxc39T?=
 =?us-ascii?Q?nqGuLDD4twE4BcBrOIbwlZFmUDoaQL3V7QlKNrGGvT9FhezYql1vsQZ882i8?=
 =?us-ascii?Q?XCjoKOU+Qq/KRXdZBSFpAasuk2uANtDZY7GwM7yG0sDGeodopQvTzHpAkeTH?=
 =?us-ascii?Q?Jvnqi7qbMrrAgHy7SYisKU71TPiq5p3Pk3iLhYdOW4StwmEPWsUGYE6neURq?=
 =?us-ascii?Q?my8J4hLubyRJ7NUeW14veEedVIEsX4jSBBYsul+HzRnez4hYU7gfqswCsSTZ?=
 =?us-ascii?Q?6kDq04YAgBKpfIkcSumzl+RbStbbM7ohvqk4WFQ3gYV1bU3v43xMcquA1oW+?=
 =?us-ascii?Q?RUzVEFfhqcXHalGKlJIUMlk79h/MPQBXn3JU7rnLV9/EHg69XHHch/lo/prG?=
 =?us-ascii?Q?pdlFM67cr8RqEZ9IYlY2t/pRE8qXCs7bfilTr4xWIa52Pq3RfC2k4tFrwC3S?=
 =?us-ascii?Q?WDqRjixT4tPTENj3YJqUuZ62WDO5JW3flo5lsfUD0wtdrdZTY73WUkmo2NfH?=
 =?us-ascii?Q?iw5IWKBjBEzOlgBg1Sf3zJLIwYzaPMeiDWW9fHCMHaTRlZ8y2dN3h51GopsS?=
 =?us-ascii?Q?NOpLWS+0cE+VMT78yvQTRGwReUr9tRL2n5kJwvNWEK7mC3d6SYv/6WrAVpyL?=
 =?us-ascii?Q?OuBk1Ze5vqKQvM2i/Jto2QfL1WquBmWqJD+GOO+tT8WtYd3yI34JvxJ/cbnk?=
 =?us-ascii?Q?jbsC4l+CqwTJp9VIvImBcIJmBnzCc8CdvnCnH8/x7BJF45hYcVdiWvoO6Vbk?=
 =?us-ascii?Q?K617hdJMQ/UBbtTRnijXbvpMLrNpNYMKcyvqTG3Fube7Q4yTTmYgVmsZN9xO?=
 =?us-ascii?Q?NQ/lTZHcnVs8H9u7ylLxTF0cy4GUzZvfBEfw8kP1FUdJTeZTmjoHfvvZ7G+L?=
 =?us-ascii?Q?aMI1EASugfRPzWskJ1dkhlE7eZiAuMTOtGdzx22Pw93xs5mfkxRZBbQ2mm3M?=
 =?us-ascii?Q?Uh09LM5DHQs5DBzUySX5+qIZS97FQ5FdrK4MG6kX+qQwYKN0cgzHYPQgY2os?=
 =?us-ascii?Q?Cq08eH3vCZkRSx7FnJH+AavB33AEItA2sdSah6fCY9mJkHDqVjZPgl8RyFGh?=
 =?us-ascii?Q?zcg8C0Rrljdymfq/EspNh8H4rrod5WziS5ivsEWc8/n2BRQlWMuPwaBlmqvm?=
 =?us-ascii?Q?pkueo5QuaGPlNEqsoCwCxYl4JIs8X8OrIW0XVal/OHTdrKREtLecsjzdoIPB?=
 =?us-ascii?Q?qK0xFQfKtdoOaUcFaqPwLZ12NGxzKyZS0Jz+XHWtMik9Xs4JVgboS7ulCtcg?=
 =?us-ascii?Q?XVPfnjg+x/Bt5wXBAm/W1QL9QuJHSQm/STDh2l+QjoBt1IJvsPpfjZrEqjP+?=
 =?us-ascii?Q?wP2pbG5w9I9E72dRSQ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013665e3-3351-4e7d-199b-08dc0c034e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 02:25:51.3740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYbQ1uXR0NTPLpwxKJKitTCCue6oY3WWkOTD1KSriWlZXXSzsUgouMgTQfORAHeR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 10:16 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
> amdgpu_ras_check_supported
>
> Move ras capablity check to amdgpu_ras_check_supported.
> Driver will query ras capablity through psp interace, or vbios interface,=
 or specific
> ip callbacks.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 170 +++++++++++++-----------
>  1 file changed, 93 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a901b00d4949..2ee82baaf7d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -39,6 +39,7 @@
>  #include "nbio_v7_9.h"
>  #include "atom.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_psp.h"
>
>  #ifdef CONFIG_X86_MCE_AMD
>  #include <asm/mce.h>
> @@ -2680,6 +2681,87 @@ static void amdgpu_ras_get_quirks(struct
> amdgpu_device *adev)
>               adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);  }
>
> +/* Query ras capablity via atomfirmware interface */ static void
> +amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev) {
> +     /* mem_ecc cap */
> +     if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
> +             dev_info(adev->dev, "MEM ECC is active.\n");
> +             adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__UMC |
> +                                      1 << AMDGPU_RAS_BLOCK__DF);
> +     } else {
> +             dev_info(adev->dev, "MEM ECC is not presented.\n");
> +     }
> +
> +     /* sram_ecc cap */
> +     if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
> +             dev_info(adev->dev, "SRAM ECC is active.\n");
> +             if (!amdgpu_sriov_vf(adev))
> +                     adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> +                                               1 <<
> AMDGPU_RAS_BLOCK__DF);
> +             else
> +                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__GFX);
> +
> +             /*
> +              * VCN/JPEG RAS can be supported on both bare metal and
> +              * SRIOV environment
> +              */
> +             if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
2, 6,
> 0) ||
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0,
> 0) ||
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0,
> 3))
> +                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +                                              1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +             else
> +                     adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> +                                               1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +
> +             /*
> +              * XGMI RAS is not supported if xgmi num physical nodes
> +              * is zero
> +              */
> +             if (!adev->gmc.xgmi.num_physical_nodes)
> +                     adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
> +     } else {
> +             dev_info(adev->dev, "SRAM ECC is not presented.\n");
> +     }
> +}
> +
> +/* Query poison mode from umc/df IP callbacks */ static void
> +amdgpu_ras_query_poison_mode(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     bool df_poison, umc_poison;
> +
> +     /* poison setting is useless on SRIOV guest */
> +     if (amdgpu_sriov_vf(adev) || !con)
> +             return;
> +
> +     /* Init poison supported flag, the default value is false */
> +     if (adev->gmc.xgmi.connected_to_cpu ||
> +         adev->gmc.is_app_apu) {
> +             /* enabled by default when GPU is connected to CPU */
> +             con->poison_supported =3D true;
> +     } else if (adev->df.funcs &&
> +         adev->df.funcs->query_ras_poison_mode &&
> +         adev->umc.ras &&
> +         adev->umc.ras->query_ras_poison_mode) {
> +             df_poison =3D
> +                     adev->df.funcs->query_ras_poison_mode(adev);
> +             umc_poison =3D
> +                     adev->umc.ras->query_ras_poison_mode(adev);
> +
> +             /* Only poison is set in both DF and UMC, we can support it=
 */
> +             if (df_poison && umc_poison)
> +                     con->poison_supported =3D true;
> +             else if (df_poison !=3D umc_poison)
> +                     dev_warn(adev->dev,
> +                             "Poison setting is inconsistent in
> DF/UMC(%d:%d)!\n",
> +                             df_poison, umc_poison);
> +     }
> +}
> +
>  /*
>   * check hardware's ras ability which will be saved in hw_supported.
>   * if hardware does not support ras, we can skip some ras initializtion =
and @@ -
> 2696,49 +2778,13 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>       if (!amdgpu_ras_asic_supported(adev))
>               return;
>
> -     if (!adev->gmc.xgmi.connected_to_cpu && !adev-
> >gmc.is_app_apu) {
> -             if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
> -                     dev_info(adev->dev, "MEM ECC is active.\n");
> -                     adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -                                                1 <<
> AMDGPU_RAS_BLOCK__DF);
> -             } else {
> -                     dev_info(adev->dev, "MEM ECC is not presented.\n");
> -             }
> -
> -             if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
> -                     dev_info(adev->dev, "SRAM ECC is active.\n");
> -                     if (!amdgpu_sriov_vf(adev))
> -                             adev->ras_hw_enabled |=3D ~(1 <<
> AMDGPU_RAS_BLOCK__UMC |
> -                                                         1 <<
> AMDGPU_RAS_BLOCK__DF);
> -                     else
> -                             adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__PCIE_BIF |
> -                                                             1 <<
> AMDGPU_RAS_BLOCK__SDMA |
> -                                                             1 <<
> AMDGPU_RAS_BLOCK__GFX);
> -
> -                     /* VCN/JPEG RAS can be supported on both bare metal
> and
> -                      * SRIOV environment
> -                      */
> -                     if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(2, 6, 0) ||
> -                         amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(4, 0, 0) ||
> -                         amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
> -                                 IP_VERSION(4, 0, 3))
> -                             adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -                                                     1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> -                     else
> -                             adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
> -                                                     1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +     /* query ras capability from psp */
> +     if (amdgpu_psp_get_ras_capability(&adev->psp))
> +             goto init_ras_enabled_flag;
>
> -                     /*
> -                      * XGMI RAS is not supported if xgmi num physical n=
odes
> -                      * is zero
> -                      */
> -                     if (!adev->gmc.xgmi.num_physical_nodes)
> -                             adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
> -             } else {
> -                     dev_info(adev->dev, "SRAM ECC is not presented.\n")=
;
> -             }
> +     /* query ras capablity from bios */
> +     if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
> +             amdgpu_ras_query_ras_capablity_from_vbios(adev);
>       } else {
>               /* driver only manages a few IP blocks RAS feature
>                * when GPU is connected cpu through XGMI */ @@ -2747,8
> +2793,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device
> *adev)
>                                          1 <<
> AMDGPU_RAS_BLOCK__MMHUB);
>       }
>
> +     /* apply asic specific settings (vega20 only for now) */
>       amdgpu_ras_get_quirks(adev);
>
> +     /* query poison mode from umc/df ip callback */
> +     amdgpu_ras_query_poison_mode(adev);
> +
> +init_ras_enabled_flag:
>       /* hw_supported needs to be aligned with RAS block mask. */
>       adev->ras_hw_enabled &=3D AMDGPU_RAS_BLOCK_MASK;
>
> @@ -2781,39 +2832,6 @@ static void amdgpu_ras_counte_dw(struct
> work_struct *work)
>       pm_runtime_put_autosuspend(dev->dev);
>  }
>
> -static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev) -{
> -     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -     bool df_poison, umc_poison;
> -
> -     /* poison setting is useless on SRIOV guest */
> -     if (amdgpu_sriov_vf(adev) || !con)
> -             return;
> -
> -     /* Init poison supported flag, the default value is false */
> -     if (adev->gmc.xgmi.connected_to_cpu ||
> -         adev->gmc.is_app_apu) {
> -             /* enabled by default when GPU is connected to CPU */
> -             con->poison_supported =3D true;
> -     } else if (adev->df.funcs &&
> -         adev->df.funcs->query_ras_poison_mode &&
> -         adev->umc.ras &&
> -         adev->umc.ras->query_ras_poison_mode) {
> -             df_poison =3D
> -                     adev->df.funcs->query_ras_poison_mode(adev);
> -             umc_poison =3D
> -                     adev->umc.ras->query_ras_poison_mode(adev);
> -
> -             /* Only poison is set in both DF and UMC, we can support it=
 */
> -             if (df_poison && umc_poison)
> -                     con->poison_supported =3D true;
> -             else if (df_poison !=3D umc_poison)
> -                     dev_warn(adev->dev,
> -                             "Poison setting is inconsistent in
> DF/UMC(%d:%d)!\n",
> -                             df_poison, umc_poison);
> -     }
> -}
> -
>  static int amdgpu_get_ras_schema(struct amdgpu_device *adev)  {
>       return  amdgpu_ras_is_poison_mode_supported(adev) ?
> AMDGPU_RAS_ERROR__POISON : 0 | @@ -2918,8 +2936,6 @@ int
> amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> -     amdgpu_ras_query_poison_mode(adev);
> -
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> --
> 2.17.1


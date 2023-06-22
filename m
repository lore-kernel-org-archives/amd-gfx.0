Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D972EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 23:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F047F10E37D;
	Thu, 22 Jun 2023 23:00:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1050B10E37D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 23:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lps6cjpdx9Tp8u8FliGrQsC6GxkjnMVOiW7LUxJULSpjCv/taWc/YqThxodYh9+496krtroVo8S+8MQI3MYhfTBI4d/aiWCDeEB0dqFxW3q6em55AVi6JBLsURYFKSLBgyuvhHnAP/XrGntduF4MZM5dMSl6AVb3nMfLmAKbckac7eq+zS/FkYyybdeXseM/3GDSRkKwrrnRR6IPZimKlIZN2KUNqi3AwlgnRdA0CbEfh1pPoORBg4DjkDc2Y7UTt19ZYfzZR9ZY1pL0GxNl5psSAA657TtmGAeH5GqC4EeMGJmuVmrGJBAgiJcojWS0OCO0bctRaf+kjBS/1ywCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM9cP+UeKDliYVMmExpj0/GnkpRAN5vXvn0xNMIyMNE=;
 b=ByOHsX2MAgBWLbIAmaNC0LW7x5oUNzNmBPKqdRRt+eOwqdW0chBRixqIYgOpxLkuvQldNxk0zn2UXhAsBA/iTBs/71j/4k5W/+8qv3aw1Yi16LFv4iU7lDOl0DE/Cqx4QvzjP+Z9cFtdOyHnz8CZeLG+OugCzAViZ9KmDTI2DuPrbz0jBh6swbze5mPOffA2QdI2SCShmLw0AuhUYsWgsOlyH+VMLS0PYW8rfhqG2ttJscuPfDhTYkcAP9+eTvg7gDnbNkl64uBcKOdJyvpjt4tAaDlDD7OopshCNDPEz2mzxyC+wfxn9I+zXhhd7UEJY/VYXOYCvjE1OZ8V3JUDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM9cP+UeKDliYVMmExpj0/GnkpRAN5vXvn0xNMIyMNE=;
 b=oy1zswrVGeMaoX1RPi66S1gcnxKVrqtqD2HEtPwV3axGHrMCcbHDzRroZI3rOmv7NKFg0W2q308RFxypfmcv3UexPqHnuSVQjqmv4MCy80gn1wGDXufqYNnSROOzVSR54uqYMpfr9DpBG4OMTGUasaHgS9G/jSunDJ1S5rN9bEE=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 23:00:17 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:00:17 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Correctly setup TMR region size for
 GFX9.4.3
Thread-Topic: [PATCH 2/2] drm/amdgpu: Correctly setup TMR region size for
 GFX9.4.3
Thread-Index: AQHZpVCTXy6wYaiejUicWyZ/WPejy6+Xb9zg
Date: Thu, 22 Jun 2023 23:00:17 +0000
Message-ID: <BL3PR12MB6425509CB3192199E676D95DEE22A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230622212843.1595336-1-mukul.joshi@amd.com>
 <20230622212843.1595336-2-mukul.joshi@amd.com>
In-Reply-To: <20230622212843.1595336-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=55d77cdc-fde3-45a9-baad-6e7dbf740f10;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-22T22:59:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM6PR12MB4090:EE_
x-ms-office365-filtering-correlation-id: b18bd2b7-8cb0-40b2-1864-08db73747271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pqNwIk5A01wznFhe85Rjv/jsuja/tvTdRmo7h7eaFA/BQ+idChCTOKJn3U6BE5R9HhtJshpWKykIuICDai6fK6TTnHlEvXXMmNby65HeF88fB2p1VPW7+vFSCR2qpXEx2UxjxmahjuLQFE+8sbWkVNA8g3AfdCpFXSSxbSG/YgbMdMsItogkzd6CCNBps0+4QowM5SbvowFuNUeYEszCOs+/pm5R6sRvZaydvndv4w06ZfisQgOev7quo2Hzgw24NbPQfXB8avH/v0mv3YpDpIIodG/m7TFJCJLVweUJU0OZI7roqfLfZzVayLgPVc3mwVIoA8kla/9PVSJoPeKkLItk5+ctQqea5mBgJmxyiC25vqt0gg6w3q3d085WtqIkR1MrDahf8XZZ5awQ8H0KPw1CDbUkh80oMQUGYjitHo7OWYl1KNNVy90jLu8f9NeM+MH0AKj8yM7dEcB53Op/atg3cUXojH3zj+CrtHQBMzwup6HP98HEs1a8I6vcB66PpLFI8f0DZRVNSS02E6KKgNsTDzcw4L9wU22JonbkE7mUX7kw0k+jC3r6GCUDEEv89dWQBzyIVQK3Q2sqo9K9pJDMUDzEewHq4hzJqvT8mVnInXW43khS116filuleZua
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(38070700005)(122000001)(38100700002)(55016003)(86362001)(316002)(66446008)(64756008)(66556008)(66476007)(6916009)(8676002)(41300700001)(8936002)(66946007)(4326008)(76116006)(33656002)(53546011)(7696005)(5660300002)(6506007)(52536014)(71200400001)(478600001)(83380400001)(9686003)(26005)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?38yv091U/wCT5UfK1pgfZdYm2oWPCMKcHSActsWdiZfJFuVxZFc5lUmu61N6?=
 =?us-ascii?Q?6300LCnPLhh65Hh05YlNerYogw5D/C75HBTegQb3XPqF0Oan8i53b5ByE5io?=
 =?us-ascii?Q?m7pYnSUa5/uVBAaj7au4AodK3iAbzFrpeKCFplZNS7fNawbPByrsACiY8qKt?=
 =?us-ascii?Q?H9HuA5e3zUeF+a0tJkLxcmewE4WwKma5XsGf7MFKfPzc3/hOK+hbSP9n2ExP?=
 =?us-ascii?Q?Q200u3ZJrl7bM5A91xJAfnerv71kn6ZI171E1mvt3ZFP2XZXg29D1Up5kXF3?=
 =?us-ascii?Q?Nl6Qvy3DErNGRuu0wEHAIz1dy2MenCDTjBhpIzCahpgDokkd9ngCHYi5Em8v?=
 =?us-ascii?Q?RXwz9BVfVuUCGsDIbEnfCDxy/EKdZHTDH4XmgJl1yetCOET1m7kakFy6wqPH?=
 =?us-ascii?Q?N6u/xZBPu/Uf1Ix3MDyAypKBwnLMnXLP89QBbSgFqy1LoeFmH+zXti3yXkr+?=
 =?us-ascii?Q?uQ9yHUASdWKHGnu/W8SjK/sZoh0KVTsy4kk0bW/72LggVw3NpX1lfacXM9Wh?=
 =?us-ascii?Q?lSKpa6ndgCVRiSrRLNjBLIX+YvakUhhUwvuPUKn+g8R3zZLXCn6mDaj5CMU/?=
 =?us-ascii?Q?VuDtj9WRwDsFyL1nZYSE9jza15HP9eHPCEgrOUgfU9cf5D/z2P+ddRWsBrkH?=
 =?us-ascii?Q?57tsirWdXJbkZno8mHfr9/BpxM5RaZ1PtEbNksPu9Po1jX8IT/7jXmLcCRlA?=
 =?us-ascii?Q?Yp7mH0vnAiJaCWWwX15edjeiFyS7C2joDAX9K2UC12LovVGbt2upM5J7ErBA?=
 =?us-ascii?Q?1LfZ7JsiE2T7y9gbSPUxEjjAM+F8aBvxy1D4y+HveEH26NethnK1/VrCm3Q3?=
 =?us-ascii?Q?6Rku8GJIc/1rvyVwn1SeXfakts1iv5KAdjfbFKvW+qj5iySsZf+ruCCxsJis?=
 =?us-ascii?Q?R9R4HKnbZaSFGXyzWXfJLgBplE4ZbeKaAyn0bJePruZli/zmvYdgnI96Bw17?=
 =?us-ascii?Q?eX2/7gSv07p28cQ52Wh/LjLbRIdwOtsrF/PAY01iVQraZ8/m1YxnQ8IrMRgU?=
 =?us-ascii?Q?i4qrfA0nfX90w8wNQbAma2YtKON/BKUvTIGn4P2ISToPZnmQ5iKp6w9CNuZa?=
 =?us-ascii?Q?aeMWpX5aFtRMjtKMIqxuK84XUUUXSuWoAGsI82hEOYFru5oWXHvqIt5uqCeC?=
 =?us-ascii?Q?7o32q/OcC2psqfm3DaK6KlhScfpD0MiR8Svicfj29FrK2phtLKBG7B9VEGDU?=
 =?us-ascii?Q?DNqdQ5yJ6JLgH4L+dwBCmlAO8JBdTd3Xms33gfFSUuo2T8mD4ebMUeiH7oDt?=
 =?us-ascii?Q?mduQYZnWKp4T8KHqCl4hNCGazIUFusY6eHj+4E941DRZkOSTYLQ99Q0Ab8rp?=
 =?us-ascii?Q?h64CB2e5unFn4TiGSqP2trhlxxKuseQDzyL7FfKS5U6A6Hz+/VS0Dn6q9aTD?=
 =?us-ascii?Q?o0zL3W3/Q1ZTPFnjaznLeifyhgdzzTXP2vtiGAPnNDvtZ+XfL+fU/bKEUF/7?=
 =?us-ascii?Q?s42N0h3mwAxEsEOMofcKZRQMOGBndtPG+gnudl1lqitw8aMeYDxljfHvGdXn?=
 =?us-ascii?Q?uEPHe+HN7dr10ymBeILnP1GZP1ZWBebRIdE7hNQbHCc4TBddSc5es//cJexu?=
 =?us-ascii?Q?u9B1neaDI5VxRuK8wFk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18bd2b7-8cb0-40b2-1864-08db73747271
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 23:00:17.5865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5MnEIEBEY4IOsXWc0vEceO7y6pZqxGzxqQ758rPi/jhhO2+4PE5AJKK5B2IZlbZGvUsMfRZXyhdmuSx0xHKMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this patch. This is not the correct way to fix the TMR region=
 size.

Thanks,
Mukul

> -----Original Message-----
> From: Joshi, Mukul <Mukul.Joshi@amd.com>
> Sent: Thursday, June 22, 2023 5:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lin, Amber <Amber.Lin@amd.com>; Joshi, Mukul
> <Mukul.Joshi@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Correctly setup TMR region size for
> GFX9.4.3
>
> A faulty check was causing TMR region size to be setup incorrectly for
> GFX9.4.3. Remove the check and setup TMR region size as 280MB for
> GFX9.4.3.
>
> Fixes: b6780d70db5e ("drm/amdgpu: bypass bios dependent operations")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7c6dd3de1867..fa5721b3139c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1718,7 +1718,7 @@ static int amdgpu_ttm_reserve_tmr(struct
> amdgpu_device *adev)
>               reserve_size =3D
>
>       amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
>
> -     if (!adev->bios && adev->ip_versions[GC_HWIP][0] =3D=3D
> IP_VERSION(9, 4, 3))
> +     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
>               reserve_size =3D max(reserve_size, (uint32_t)280 << 20);
>       else if (!reserve_size)
>               reserve_size =3D DISCOVERY_TMR_OFFSET;
> --
> 2.35.1


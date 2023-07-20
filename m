Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E034C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F097310E172;
	Thu, 20 Jul 2023 19:05:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B3210E5FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjRo8pBKt/wW1ckNfWXcVcvlmN/60WxjAN5QmcK413NWzw/+pHwyopEDx3BuNaDPGSb5oj3yWQ5Ye2hVvH/TQu6wfG+dzYAT4jhzR6MlKGLxmBt7tEgyVRe4SQTWnew4VJ5o5k8ldu30g1/NYK/kz86RKAQaLEtX1r2Iq0RwGJlJicQR3/I9AX9eqGqvAbz8+RewrM22pDO9hoUOtt6v7iY0zKEHVQoUtAqMFqbaHRODZPPFIgU7OUhP2B/vzbUIvn7MF23o6fFsUZohFJlK9O30RkVZibeITNFwNRJ/mZMjuD//PuWfOnUwRmr3a6Du0RhDJmWCsVGfyDPDGE+bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz52TIRdaeW6GrgxnNnvTrKTEyXC+SJc5MRFfH8+FYo=;
 b=LbugNJXvgPF/4qycsS6UhBZk+q4cbDHG/YxJmC2sq30ySl1aYVZ5Ere5H6KOF/c1/Y/mI0sY+ydXi1WBu4v7IINd9kDH5Rzo6HnrEB9snD2DtQZZlqkGUAWBhjZCFhrTqO/7e3hGrXaY9aBPRTwvUg1uIo1UGaTIgVrZFpli1MU/SH+zT3gA1tPCVxl+4Tl9CZRXRP1odnw0crdxMiNtlEk4slDvBo7t6pO5ynO2khT1wPfGhTkVtDM+Ca3yjE6vfviZulNZD5rVwUdJKJB08tpvz7+5hgtY5dx6LnRo/oIfQQngjVap8CtnrOPic55NRqqwwKBGCrhZEZX3DVvFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz52TIRdaeW6GrgxnNnvTrKTEyXC+SJc5MRFfH8+FYo=;
 b=nDmirDPAUer9UAiBPTc33LveE9JRi4liT1eZeRS326OfGBHBuK3PSQwgPS3WVLA3il0X6Rvs+qIPQyhWwoRMrPX7yAD7K+AhIzBAkSAgjkbtgkJszjON6Byx0CnST0IVecZvKL3w5emX50ZjoyoNYrFL+534q5yX6fFIy484QLY=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:05:31 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::3746:aa4c:e79e:4f64]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::3746:aa4c:e79e:4f64%2]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 19:05:31 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Thread-Topic: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Thread-Index: AQHZuMeixR74t6K3h02PWs2PpFGiEK+/BtoAgAQBqpA=
Date: Thu, 20 Jul 2023 19:05:31 +0000
Message-ID: <MW5PR12MB5600033FACB4FF3732660A4FE63EA@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
 <20230717155841.758516-3-samir.dhume@amd.com>
 <DM5PR12MB2469A10305D5F07050A404F9F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469A10305D5F07050A404F9F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2baf290e-371a-4c59-a6a8-40b67901b014;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-18T05:50:58Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|DM4PR12MB5915:EE_
x-ms-office365-filtering-correlation-id: 381b3c7d-8451-4556-9448-08db895449e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y031JB4+zg8qZJtLmCap9BobYblIE933StPxD9Y+kMxEgKgT9l2vsEPRYV6mAAanTtSCdaYeEfa5XaEVsvyL6ukdxJDnpRLSQbRk1TBMbO+wt1NUx02GeiyqAkK1IV6rwrztx3AdU6c96JirM5gzJSYU6q1ziyyCPeVuFlTwmRYunGlNu6yVQ3taNscM9ngMhdT/V9X608YZL7VR2wuZhroNB1XBVauTi2Z2U7DadaKnruhyMyCpMia7kI5HygwOuDfvaNVwE1lOQy+J6uwjt4mB3aSTqYEce2MhPiB7gHITDEC+Jb/1PN+S+FaZhfYb3dl0XgU4GO7gaiXnlBCAl1ddGlgl85TicoKOyIfmlnlUafqhitpASGF7WhHBwNjDpV45K7uxJNufXnJxyJqCP56faWTGlcOBHPWwfN6Lix9YJS/BrC5vFDFwpx+4xOEKdmZAFqcgVEPukkHTnBTD38+ZDikRXD/OjijIU6MUW3xI79nDg3P56Y9D9Wi8IDyXstKCg4YEDjH8KrJsg6lg2nvi1GUDEsWk6oa2VJ4NABTtET4pMgiBt5KXkfLVyqhOBmn+U/+ZvGxVeHJA3UyE5GlYl9YvCNytuamtByMzAJU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(53546011)(478600001)(7696005)(9686003)(55016003)(6506007)(26005)(71200400001)(86362001)(186003)(110136005)(122000001)(66946007)(64756008)(66446008)(316002)(66556008)(66476007)(76116006)(8676002)(52536014)(38100700002)(38070700005)(5660300002)(2906002)(33656002)(41300700001)(83380400001)(8936002)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LielC4v0b6p0Q2ngM8Gsjut4j+Hg3Gng60FtAwOPweNFxBpMkiTUx1A9Ol7v?=
 =?us-ascii?Q?c9BU99a2oMauxF/JIDdf9MXxBXhKSJbVdduO8BSmRXzB3LVOpCsYDT/ltDk6?=
 =?us-ascii?Q?RxgqeAZMF6hzn5WzcP6UIVYk5zqk4y6BDe4tdvssyFCsFdOLL49etDrb2H0x?=
 =?us-ascii?Q?qjeAhKGNAEXM69knGAol/7QhN5npCGk8U+Cgm370UH6fXNxKZUAlvXEMQzf8?=
 =?us-ascii?Q?G7U8k1s6o69CSBxj0/h8MJqMC+wgxLPTbQgfRrpLii9bBhsxxOdWwGaHZ5Ho?=
 =?us-ascii?Q?119k/FI4l6g/0/zFr1AKOqME0shmefjAeLd/zA6C9El6cFZnoGVYytmlYi2A?=
 =?us-ascii?Q?3XsYz5pmpkOv8XNOF1AVmtsuYzOijpbfROf40daQs1j4HW6qCWJC9fr4iMJI?=
 =?us-ascii?Q?ByFw4V53OplERJ0ADoXUmRaIy380PLp9YBbjhIKa4BmewJaSb9tzysNLRafb?=
 =?us-ascii?Q?k2sHjgdW9TYqEK5i9EGd6wKyG4XytMVEJwAJrnlDRxrRMdcl8cikbJ3IWTq5?=
 =?us-ascii?Q?v+ipLkJZvJIqx8kzUF/XcAR+Q0HrPOT/ehDrpk47aXpU2pscxDva6jqHhJIq?=
 =?us-ascii?Q?h41Y9C1PLt1tFbrEVqTIsKz0zAoyPvLJdBTHf2GR6I/K3h3sctbbIW55yaWo?=
 =?us-ascii?Q?g5AVReH0lgyEUFsAa0kJbm3QS3ueOQn1qox8X3XqzT53mToDWB+xcmsVWLD9?=
 =?us-ascii?Q?+01ryNJvHYAyjCvSJl7GkcRnajfpdSz903edgDet4/ioizTC6Tg8QvmHPthh?=
 =?us-ascii?Q?5sm6jflDAThoHzQNDAjtIEeDMa1QWJKfIek8XV7vwvoplCF5gA+eln9fsmix?=
 =?us-ascii?Q?NcH51nLcLf8fGgg/yB2mJY+NJMMjvYbLxpqUfwwod2JifMd9con3f5Xkk7SH?=
 =?us-ascii?Q?tyWDo+2+lY5Hqlm3LHo6xtGIp2Dvzae4eHEYzgTsf4FG9NewckmzubsOvFxG?=
 =?us-ascii?Q?Ajbz7HpotjnpMmq/TMZRFwwjqqjzSmq6NRSYFWYtopufEqz1Rur0fjpjDjWS?=
 =?us-ascii?Q?08B2kPayythSSZaHQ2cjEYY6EkFew3gmjZoS533mPc5pFm+PrHRD+kLJrIkr?=
 =?us-ascii?Q?TOTH4pUqVntd8nyBELcvE/x5UChE8hRTSjtXbNBFkklaS+G6JdOL4IVO7hA6?=
 =?us-ascii?Q?CneV/y1jgx38cdbPubC7RBvxG/NeVN5M/5Kytb1794Bsu2MpD/iG1mxYu5rP?=
 =?us-ascii?Q?mSroid9pc67ec0Nm2/VVHUnV3UIO0ymZU1AxGS8LaIXdUwAxSdn3qG17jWOK?=
 =?us-ascii?Q?KMVsewO9GwM/59YqTsGa/lqDtA+O2SYXOGDOKln+oXH7x8QmaHOw68GnWZ31?=
 =?us-ascii?Q?DUqJBfyn5fe6yaJ9X2vCDSKXxrhYnJBIqVeSsLN0y2Kt5WIwqTlsrk3kOGbX?=
 =?us-ascii?Q?nP/t3T+Tq5gzfnBZBJ9cPVCDKQpkq+jiHkUk0CYfg/VRO6YEh8E7b5EP2HWt?=
 =?us-ascii?Q?MZwe21exVgZJMJnAgXiZH/yfaZtUb/yQPWkH6QZWFVQPxs5s9D7qJ0TPK6Xa?=
 =?us-ascii?Q?0P+xwrdUDHzL43jXFv8UxBl9BDW+Tlsm2vCF1dHbLH57LbUhZRvgCwQ8SGVE?=
 =?us-ascii?Q?Izg085v9Exm3gZKLcKE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381b3c7d-8451-4556-9448-08db895449e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 19:05:31.2930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlkehV3gJJLq7yiwreakE7tUhrvjHqSKWHePMqYbtOiiOwrqf5Hp3aYXI0093qRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

[Public]

Fair point. I'll follow up with another patch.

Thanks,
Samir


-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, July 18, 2023 1:54 AM
To: Dhume, Samir <Samir.Dhume@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Samir Dhume
> Sent: Monday, July 17, 2023 11:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Dhume, Samir <Samir.Dhume@amd.com>
> Subject: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
>
> initialization table handshake with mmsch
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 264
> +++++++++++++++++++++---
>  1 file changed, 240 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 411c1d802823..ac405dfcfaf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -31,6 +31,7 @@
>  #include "soc15d.h"
>  #include "soc15_hw_ip.h"
>  #include "vcn_v2_0.h"
> +#include "mmsch_v4_0_3.h"
>
>  #include "vcn/vcn_4_0_3_offset.h"
>  #include "vcn/vcn_4_0_3_sh_mask.h"
> @@ -44,6 +45,7 @@
>  #define VCN_VID_SOC_ADDRESS_2_0              0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0     0x48300
>
> +static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
> *adev); static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device
> *adev);  static int vcn_v4_0_3_set_powergating_state(void *handle, @@
> -130,6 +132,12 @@ static int vcn_v4_0_3_sw_init(void *handle)
>                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>       }
>
> +     if (amdgpu_sriov_vf(adev)) {
> +             r =3D amdgpu_virt_alloc_mm_table(adev);

amdgpu_virt_alloc_mm_table has an early check of amdgpu_sriov_vf(adev), so =
from coding style's perspective, I think you can drop this superfluous chec=
k here and directly call amdgpu_virt_alloc_mm_table.

> +             if (r)
> +                     return r;
> +     }
> +
>       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>               adev->vcn.pause_dpg_mode =3D vcn_v4_0_3_pause_dpg_mode;
>
> @@ -167,6 +175,9 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>               drm_dev_exit(idx);
>       }
>
> +     if (amdgpu_sriov_vf(adev))
> +             amdgpu_virt_free_mm_table(adev);

Same as above.

Regards,
Guchun

>       r =3D amdgpu_vcn_suspend(adev);
>       if (r)
>               return r;
> @@ -189,33 +200,50 @@ static int vcn_v4_0_3_hw_init(void *handle)
>       struct amdgpu_ring *ring;
>       int i, r, vcn_inst;
>
> -     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -             vcn_inst =3D GET_INST(VCN, i);
> -             ring =3D &adev->vcn.inst[i].ring_enc[0];
> +     if (amdgpu_sriov_vf(adev)) {
> +             r =3D vcn_v4_0_3_start_sriov(adev);
> +             if (r)
> +                     goto done;
>
> -             if (ring->use_doorbell) {
> -                     adev->nbio.funcs->vcn_doorbell_range(
> -                             adev, ring->use_doorbell,
> -                             (adev->doorbell_index.vcn.vcn_ring0_1 << 1)
> +
> -                                     9 * vcn_inst,
> -                             adev->vcn.inst[i].aid_id);
> -
> -                     WREG32_SOC15(
> -                             VCN, GET_INST(VCN, ring->me),
> -                             regVCN_RB1_DB_CTRL,
> -                             ring->doorbell_index
> -                                             <<
> VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -                                     VCN_RB1_DB_CTRL__EN_MASK);
> -
> -                     /* Read DB_CTRL to flush the write DB_CTRL
> command. */
> -                     RREG32_SOC15(
> -                             VCN, GET_INST(VCN, ring->me),
> -                             regVCN_RB1_DB_CTRL);
> +             for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +                     if (adev->vcn.harvest_config & (1 << i))
> +                             continue;
> +
> +                     ring =3D &adev->vcn.inst[i].ring_enc[0];
> +                     ring->wptr =3D 0;
> +                     ring->wptr_old =3D 0;
> +                     vcn_v4_0_3_unified_ring_set_wptr(ring);
> +                     ring->sched.ready =3D true;
>               }
> +     } else {
> +             for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +                     vcn_inst =3D GET_INST(VCN, i);
> +                     ring =3D &adev->vcn.inst[i].ring_enc[0];
> +
> +                     if (ring->use_doorbell) {
> +                             adev->nbio.funcs->vcn_doorbell_range(
> +                                     adev, ring->use_doorbell,
> +                                     (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                                             9 * vcn_inst,
> +                                     adev->vcn.inst[i].aid_id);
> +
> +                             WREG32_SOC15(
> +                                     VCN, GET_INST(VCN, ring->me),
> +                                     regVCN_RB1_DB_CTRL,
> +                                     ring->doorbell_index
> +                                                     <<
> VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +
>       VCN_RB1_DB_CTRL__EN_MASK);
> +
> +                             /* Read DB_CTRL to flush the write
> + DB_CTRL
> command. */
> +                             RREG32_SOC15(
> +                                     VCN, GET_INST(VCN, ring->me),
> +                                     regVCN_RB1_DB_CTRL);
> +                     }
>
> -             r =3D amdgpu_ring_test_helper(ring);
> -             if (r)
> -                     goto done;
> +                     r =3D amdgpu_ring_test_helper(ring);
> +                     if (r)
> +                             goto done;
> +             }
>       }
>
>  done:
> @@ -813,6 +841,194 @@ static int vcn_v4_0_3_start_dpg_mode(struct
> amdgpu_device *adev, int inst_idx, b
>       return 0;
>  }
>
> +static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev) {
> +     int i;
> +     struct amdgpu_ring *ring_enc;
> +     uint64_t cache_addr;
> +     uint64_t rb_enc_addr;
> +     uint64_t ctx_addr;
> +     uint32_t param, resp, expected;
> +     uint32_t offset, cache_size;
> +     uint32_t tmp, timeout;
> +
> +     struct amdgpu_mm_table *table =3D &adev->virt.mm_table;
> +     uint32_t *table_loc;
> +     uint32_t table_size;
> +     uint32_t size, size_dw;
> +     uint32_t init_status;
> +     uint32_t enabled_vcn;
> +
> +     struct mmsch_v4_0_cmd_direct_write
> +             direct_wt =3D { {0} };
> +     struct mmsch_v4_0_cmd_direct_read_modify_write
> +             direct_rd_mod_wt =3D { {0} };
> +     struct mmsch_v4_0_cmd_end end =3D { {0} };
> +     struct mmsch_v4_0_3_init_header header;
> +
> +     volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +     volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
> +
> +     direct_wt.cmd_header.command_type =3D
> +             MMSCH_COMMAND__DIRECT_REG_WRITE;
> +     direct_rd_mod_wt.cmd_header.command_type =3D
> +             MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
> +     end.cmd_header.command_type =3D MMSCH_COMMAND__END;
> +
> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
> +             memset(&header, 0, sizeof(struct
> mmsch_v4_0_3_init_header));
> +             header.version =3D MMSCH_VERSION;
> +             header.total_size =3D sizeof(struct
> mmsch_v4_0_3_init_header) >> 2;
> +
> +             table_loc =3D (uint32_t *)table->cpu_addr;
> +             table_loc +=3D header.total_size;
> +
> +             table_size =3D 0;
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(V
> CN, 0, regUVD_STATUS),
> +                     ~UVD_STATUS__UVD_BUSY,
> UVD_STATUS__UVD_BUSY);
> +
> +             cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size
> + 4);
> +
> +             if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +
>       regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +                             adev-
> >firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +
>       regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +                             adev-
> >firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
> +
> +                     offset =3D 0;
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                             regUVD_VCPU_CACHE_OFFSET0), 0);
> +             } else {
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +
>       regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +
> + lower_32_bits(adev->vcn.inst[i].gpu_addr));
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +
>       regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +                             upper_32_bits(adev->vcn.inst[i].gpu_addr));
> +                     offset =3D cache_size;
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                             regUVD_VCPU_CACHE_OFFSET0),
> +                             AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> +             }
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_CACHE_SIZE0),
> +                     cache_size);
> +
> +             cache_addr =3D adev->vcn.inst[i].gpu_addr + offset;
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> lower_32_bits(cache_addr));
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> upper_32_bits(cache_addr));
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_CACHE_OFFSET1), 0);
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_CACHE_SIZE1),
> AMDGPU_VCN_STACK_SIZE);
> +
> +             cache_addr =3D adev->vcn.inst[i].gpu_addr + offset +
> +                     AMDGPU_VCN_STACK_SIZE;
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> lower_32_bits(cache_addr));
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> upper_32_bits(cache_addr));
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_CACHE_OFFSET2), 0);
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_CACHE_SIZE2),
> AMDGPU_VCN_CONTEXT_SIZE);
> +
> +             fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +             rb_setup =3D &fw_shared->rb_setup;
> +
> +             ring_enc =3D &adev->vcn.inst[i].ring_enc[0];
> +             ring_enc->wptr =3D 0;
> +             rb_enc_addr =3D ring_enc->gpu_addr;
> +
> +             rb_setup->is_rb_enabled_flags |=3D RB_ENABLED;
> +             rb_setup->rb_addr_lo =3D lower_32_bits(rb_enc_addr);
> +             rb_setup->rb_addr_hi =3D upper_32_bits(rb_enc_addr);
> +             rb_setup->rb_size =3D ring_enc->ring_size / 4;
> +             fw_shared->present_flag_0 |=3D
> +cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> +
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
> +                     lower_32_bits(adev-
> >vcn.inst[i].fw_shared.gpu_addr));
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
> +                     upper_32_bits(adev-
> >vcn.inst[i].fw_shared.gpu_addr));
> +
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +                     regUVD_VCPU_NONCACHE_SIZE0),
> +                     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct
> amdgpu_vcn4_fw_shared)));
> +             MMSCH_V4_0_INSERT_END();
> +
> +             header.vcn0.init_status =3D 0;
> +             header.vcn0.table_offset =3D header.total_size;
> +             header.vcn0.table_size =3D table_size;
> +             header.total_size +=3D table_size;
> +
> +             /* Send init table to mmsch */
> +             size =3D sizeof(struct mmsch_v4_0_3_init_header);
> +             table_loc =3D (uint32_t *)table->cpu_addr;
> +             memcpy((void *)table_loc, &header, size);
> +
> +             ctx_addr =3D table->gpu_addr;
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_LO,
> lower_32_bits(ctx_addr));
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_HI,
> +upper_32_bits(ctx_addr));
> +
> +             tmp =3D RREG32_SOC15(VCN, i, regMMSCH_VF_VMID);
> +             tmp &=3D ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +             tmp |=3D (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_VMID, tmp);
> +
> +             size =3D header.total_size;
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_SIZE, size);
> +
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP, 0);
> +
> +             param =3D 0x00000001;
> +             WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_HOST,
> param);
> +             tmp =3D 0;
> +             timeout =3D 1000;
> +             resp =3D 0;
> +             expected =3D MMSCH_VF_MAILBOX_RESP__OK;
> +             while (resp !=3D expected) {
> +                     resp =3D RREG32_SOC15(VCN, i,
> regMMSCH_VF_MAILBOX_RESP);
> +                     if (resp !=3D 0)
> +                             break;
> +
> +                     udelay(10);
> +                     tmp =3D tmp + 10;
> +                     if (tmp >=3D timeout) {
> +                             DRM_ERROR("failed to init MMSCH. TIME-
> OUT after %d usec"\
> +                                     " waiting for
> regMMSCH_VF_MAILBOX_RESP "\
> +                                     "(expected=3D0x%08x,
> readback=3D0x%08x)\n",
> +                                     tmp, expected, resp);
> +                             return -EBUSY;
> +                     }
> +             }
> +
> +             enabled_vcn =3D amdgpu_vcn_is_disabled_vcn(adev,
> VCN_DECODE_RING, 0) ? 1 : 0;
> +             init_status =3D ((struct mmsch_v4_0_3_init_header
> *)(table_loc))->vcn0.init_status;
> +             if (resp !=3D expected && resp !=3D
> MMSCH_VF_MAILBOX_RESP__INCOMPLETE
> +                                     && init_status !=3D
> MMSCH_VF_ENGINE_STATUS__PASS) {
> +                     DRM_ERROR("MMSCH init status is incorrect!
> readback=3D0x%08x, header init "\
> +                             "status for VCN%x: 0x%x\n", resp,
> enabled_vcn, init_status);
> +             }
> +     }
> +
> +     return 0;
> +}
> +
>  /**
>   * vcn_v4_0_3_start - VCN start
>   *
> --
> 2.34.1



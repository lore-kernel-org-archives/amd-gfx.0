Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F2EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 05:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB3B10E2CA;
	Tue, 18 Jul 2023 05:53:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A8310E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 05:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjxpCnpqNI7vMHswIHYa1cgbHI72r6ynO/LE8WeFOD1lByYtrFnicsU89M6N7awjOsIi9YeYPCQUjxh6CQ05nXn2tafZEhyimq16iBlvcEEUk2ou3RQr8wOJ2wTTArFlMIejfSoXlKzSSzySziqixvuRvwLXr2zWsxJ2Hpm490se6z9oDkeIRLqivM4NW/nMTRFI1X7WtxpIM9M0voS6Phwq9TMmQ0fq8rlR94QsVNHpSNrjrlxmosNWhRTx0YCYBd9L+DpkA3xc50uuC1RtqRDb5MrQVkOu8mcIy5PaIUVbJkWiF7JO8zSkxJwU8cmno+Ew8UkD57cLuZ9kp/9SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYE5jn2/WEocrEjv9h6YgtTVELmT8lU7706BZ9rKtKQ=;
 b=i1omqQB3m7bu0fbtQIRQK7/XbxjzKOlX5l6MaKChx0tAcSISXLaHZ0VnS5iD3Lqo9+SOac9/dMblf7X8DFu9I1jOBYXDDPsCPT+mKH2Tn3jAVQgOTYTRS09QOxsSY+sBPc3U4GuMfabr81B66WUq7uRKlrntmlE7SVECv9JdgZBNRaJxJ6TyP1fEKIAJaO2r/8WqOqkUkAblZPnJ0KJi070dHmNxv/z+gWxIr4Jw9i93xdIOPi8yPwZ5/DbwOV/3Dlk3X9VCwxMHYy5AUT9TaMu+NIGzVZYEuddRaers180Z6wkbOkp4MJ+7l/pSGOqGR5jS7n+nAkbQK+lc8YWfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYE5jn2/WEocrEjv9h6YgtTVELmT8lU7706BZ9rKtKQ=;
 b=nWT72yUyhEESxZKhz2DKY3kYAS9pWzxW9+c+l9ZduG6LMm27Im/+rGHVNdHvtVQAy7nShyNpWzKbRS12pswNjQAFbakJS23Ado883ros603NJRhsVkr8bWMxzHUFNqyUekNr3hAQUBTekTHlWt/Hdlr9cc40/4U4JCsT+LJ1u1s=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Tue, 18 Jul 2023 05:53:42 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 05:53:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Thread-Topic: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Thread-Index: AQHZuMeoAX7Cys7RnEKPWUwQaz+Y1a+/BhEA
Date: Tue, 18 Jul 2023 05:53:42 +0000
Message-ID: <DM5PR12MB2469A10305D5F07050A404F9F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
 <20230717155841.758516-3-samir.dhume@amd.com>
In-Reply-To: <20230717155841.758516-3-samir.dhume@amd.com>
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
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB7194:EE_
x-ms-office365-filtering-correlation-id: 799271a1-2f74-4772-52b4-08db8753579d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0A9YL0XnPFQtHEY7TIovV1BUT8TDZuwex2bmvxBFyxB0U2+8g5i19QzvcAoxMRCShenShUlK9xu8vH0rPvPyxanZweZ0RF8ZG3rcDgcbdBZ4NkoiuTUuXImqQJnBDHelaAeVagR+fBVEI2h/rER3uo/Xd0fMSPTbneQcRdtXBFPHS4hLFa93CdLF+D6nFtMD0IgG5BfqmmBjDbYK5nGpPZu9esSzyI4Noj565duTydvM1QqzalwdmJYhu3hEVsE8OozoFEzQGhLl4G8s5O2fLiCiimpV6Mg+3YEMNykPUT7QH5mXM1Wq9smrp4t0Em++LysE1sLtIX36WGooS0DEdvDzbb/cH8w1Pqukp89/NXsMwKJs7SgBCUIgoxZejiIg7y0eLYifX4XEK7iaGOqIhyDw3Jhe3NlP8ecAQTfcI47T2kBYvY5pm+ZxSprvvcDSzHVJFAJFc00f4FN0xeuiX4GQCSyGq+TdsACJSFv2vc81NGs9ngeimDapM/ROTZoY79LCobIlW0IK8MB3CBCkkZrKB6UiuDb07uz1ddknbMsGeG7K3RnobwN6fGqS0EGTNEaLeDeVhkS9ouuJPZGH1ygsSxo7L+cL5RPspF3JsT8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(8936002)(8676002)(41300700001)(66446008)(66476007)(66556008)(64756008)(66946007)(7696005)(52536014)(316002)(76116006)(4326008)(5660300002)(110136005)(30864003)(55016003)(122000001)(71200400001)(33656002)(2906002)(478600001)(83380400001)(26005)(53546011)(9686003)(6506007)(38070700005)(38100700002)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sb2wgZbXuasuJieB3jkjZT1LZm9y11XkY+dDkvM7TCjERxSmpDl2RxBCTqMD?=
 =?us-ascii?Q?GQ17Cmk6YcyAefU5UsiV61R0J4+TSW70BUYnpVtcIPHi63rZwbXxr+KPz1ma?=
 =?us-ascii?Q?BGqjmEqnxA5plUzFttRAWOLS6Zi6x+Ycv3CXxqx4nFFdeNsxTMMCOIYt2LVi?=
 =?us-ascii?Q?7BQnDNzAPnBWD0D1qK790uO10PpSj9QkoYgextykqs4Y66b9CT7XGHn1Uvkc?=
 =?us-ascii?Q?ADJBzwO+RBMnX0YYluQltBgE2Ta/ZGRhjVl577OGY2wY+2d10164qHdJLIg1?=
 =?us-ascii?Q?ljuf3mp7dmiY3M6KoqhQ5ugcKfXs1MEwEk4NQV0Lo1FtdiFJ2WwGiA1F11B6?=
 =?us-ascii?Q?DvYJkBMr63WVC5eQvK92YqbnmVDGtkaC7odsCGLSvP+0q62Mv/yXWhE4NyfT?=
 =?us-ascii?Q?RudflE8rb+vw6E4fon3R6CaJ5NhsDILVqcLtzEe4U8FdyF4nTm73kpi0Q0YT?=
 =?us-ascii?Q?ZPUpmUwswE/lpGinP5tAep3567umOjOQPNuEn0GP/mDx5jNXZ692QmyrM3l4?=
 =?us-ascii?Q?l5U2wVJW418FH7v+HOBV75WsFJDL/Vd5dyY8koioU5K5I324WSg9CU/L1THT?=
 =?us-ascii?Q?NBaB+77fd536N5oy1+FB9KzKeik53PGdBesYet9XbbFPxrwckZI4hzdATdI7?=
 =?us-ascii?Q?E3MWne0hy5PeYUOuxW/w2mz22/J9vhdKN0lvx5NbfDrRdj/xr7QaNu9ZRPUq?=
 =?us-ascii?Q?HJ/MdqPS0z5cuxdnqTqMKQVhXpZyaX6mpGCVwDuslViNxpkLce+4quxr7OoK?=
 =?us-ascii?Q?yobkgR0IbkDE8df/qq/k4zoYdUh3o1Z4fgKVp8O1RkSxztfr157r1GpQacy7?=
 =?us-ascii?Q?QaFIQPAnaCxcqHPhKTXiCzkF/6YaA/Wv2XQCOHJri53ev6mmTN//j+YD2i19?=
 =?us-ascii?Q?CA+TJC+XPiCVcPOdb4WR9VGNPJJH4DtPN9LLUFn/Zo0H6wytrIe371DCmTJV?=
 =?us-ascii?Q?EVbYV+2VF7o9OTMQoJZdenDMcH/3ikMeniF01EiwZ0NZfuHBaeVrGert8wyV?=
 =?us-ascii?Q?6s6gESyn6p54qmG4sEoYNk9K6iWnzaBFIbOvA79hKsdhDKFuuU6JA7iovjpK?=
 =?us-ascii?Q?shlS80xR0J1Q1ou+NyaaC8mHvRTfoRu/ugrxUUE3Sgc9aWl8UNV6O+V1v/QT?=
 =?us-ascii?Q?7QYgGVM59Ez85uHgSy+68Aufm+7VatKYRPFpPxo+9ZjFXCwtSbHt2jbGiPkL?=
 =?us-ascii?Q?0Bh57tzhdESOZa9DwheoIMZcVOx4h48TL9ps/docCBugA2KkO5ZpTw2zbR+r?=
 =?us-ascii?Q?aKaLqNuvHqbavn8r3LOJ///mMsFtR7NqQ3oWd5V2MhkV+fZ+jcQo6ujz8x6K?=
 =?us-ascii?Q?EtJXnkyN1tkvXJU8xQetmUNNl+Ic7zS2YtAly4ZBVPmR9NLb3xv9Pi5QQPAg?=
 =?us-ascii?Q?6FWFd4sSIaQVsqACQAz6+xcYfrReXb0Okpsb0cBHp1X3ZSRpi/c1SFglDrVY?=
 =?us-ascii?Q?0ZinJ/16K/AChAn3U9YEqiO51liXsCk3Ml7Ui2Tab19wUOPybu1kveL06EsP?=
 =?us-ascii?Q?3cqK7W+OCE3Rxv8qSNJ9669jd/wx/vhzcJyrxoAXQczPu2WLYoHuzJZS18sJ?=
 =?us-ascii?Q?iwxZVZLB99Radj2vOOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799271a1-2f74-4772-52b4-08db8753579d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 05:53:42.4905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR+h5jYd8K20we0MDR1iSVNgre0XBWrw1TBK6ilnp7x0AhzxeCxq+lsP73KwCRAlRX/sPnNZ9DKmn4QcSFlZ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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
Cc: "Dhume, Samir" <Samir.Dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev=
);
> static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);  static
> int vcn_v4_0_3_set_powergating_state(void *handle, @@ -130,6 +132,12
> @@ static int vcn_v4_0_3_sw_init(void *handle)
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
>               adev->vcn.pause_dpg_mode =3D
> vcn_v4_0_3_pause_dpg_mode;
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
> +                             /* Read DB_CTRL to flush the write DB_CTRL
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
> +                             lower_32_bits(adev->vcn.inst[i].gpu_addr));
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


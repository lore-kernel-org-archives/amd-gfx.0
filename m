Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC8C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 08:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9012610E1AF;
	Wed, 17 May 2023 08:30:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9C810E1AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 08:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub6Lfz1dAJarMDnEVH1i/Sh3w7GlSoDwM97cqiE08oB92DrTYWPdj9gJ+Z/UWa1u/iFrCyyiQccMSQD0EgcIvdtPlBN8BobV5cWm1dTnUu7unWZRl8Tt1PzJ0SJlBk8dOzAgcn/rp66EUYzKRnblwrj9Xcj9ZjF3XOUsAcukqr3gLHWvZH7ZXG2vB8mUvJlN+qFLgKfwmfQ/uqkkFTwSAsXksk8+YL9pK3Tm3zzt27l/gWy2M2MhoUnSMxk8LQUTti26lg6mVsvIaQGvQ3IdNqhhrXqyITC0II/hlObDrBvKDj7tZMq8lG2q9Ugt0p/fPocGRAwTqidMeKAMpaX7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sL6h8sOmj5SIjOwAs7VQpaVr2640qRp7pxCvqt/1DE=;
 b=PIuXiMLduClcL4UKPk6aaxL+MyDVUfaMkFQgdNKL+knNdkqc/dkIfAeECEt+g3TUbs/4ve9rkTVIutE4lF5x46sU0ugo2Tv3ChcYDEnuihH3WPZgNDrnhwlrN44Db0cMACdlMCtFS96NVo4dvHFZhiaIUMIMHSS5+wiSssUuZ0uav8I+iIwM5xxYMPI8XdkHt302/mkYzoft5aCVpYs/hHbfMRORoNs5qJvqMWbEsIEjDsu7HYHGzn4fyzHPeQJYlQDkSHdtlX2Q8oav6W/Im+vHeTBPHY3whenq7alWdv8EFiHHGXHeAolfn6k7sH4wxlP74N17EbJuIg6TyKsulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sL6h8sOmj5SIjOwAs7VQpaVr2640qRp7pxCvqt/1DE=;
 b=EqydY1xXcJpu+un081B8hD06FdkF1MLKjG6LSbJGTr22tOWTI4FEmvvFFTV1GHjoi1bkNJTmhAoO03zO9aTFW+nkSDKLRz7PtrFhr6BW6z0felFuuayv5vCHJyYrWgNQp7pV5i8IiMLXyX+JncblnSNaheT8evEp8JjXnmar/Qo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 08:30:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 08:30:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx
 v11_0_3
Thread-Topic: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on
 gfx v11_0_3
Thread-Index: AQHZiGVOfPdJ+ODFhEiqSGxVzpT44q9d0HBggAAxH4CAACCXcA==
Date: Wed, 17 May 2023 08:30:42 +0000
Message-ID: <BN9PR12MB52573B84BFA65F20E4020CA2FC7E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230517021330.3096585-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257E58BA0FCBC45D870B6DBFC7E9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB4215EDBF0DD4E3807D353F0FFC7E9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215EDBF0DD4E3807D353F0FFC7E9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T08:30:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f329b16-5f4d-4113-95ad-9b22bd404254;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5149:EE_
x-ms-office365-filtering-correlation-id: cf2d9e3d-9182-45a8-44c0-08db56b100c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhnMMCS4eqvhmFtMVBDTkJjhyqYCcfBLDE4QZChyiZmokuWbiFHb94y6+2gEO93JIdS4FXmlOjGm9Y2FbQWF5NcVe5k4k+QWtmzPawO7g4CIeSImHc5cY7GsUHdxyQUvbMUSgA+uamEQTLjJUOWrgzVInwvX//em+hzm8QkYt+xcjGeYVx1KoIBP7hzlt/u1lO/6k17E4yJnVEi+Zl1zatY7DrQIKcJ+ZrcOXTVURDwyl2hn2p3LKbDfN8GR5jA6cY8nQos4J4XJJw+6t58W7jTGuagDTjZJgA3Xq7ya7udtPRl51K4Kk/SXInXzlUKmmq45UDDK9PuLIZCDaOrcM00G/nNVWcAW8hq+Zqiufkw9Qcpr7qqiZ7dwQx/EIpUVWHqC0vCBcZCwAtSkj3sre2V4rgPACGvTJ7KPN6T5ktDuoodZbp7lIrVXJEOOvuF42F67SJmM1wc+LZAKNTg9b9NZBhj213T1nlZ7PFcCL6cOJkT4MR3gUlVh+z7XcNoSmRKiERzVy1Jrkc2I8FTyoM5gAYwm+Ppqhh8yuhptwS+BtpL5vnv6A33Tk7IZXVXHR+28ZkFLG6doiEo9kqialKM1hAuYJdCTkjSQ4TrkVHa/Rsta6srcqX7tORa1fEs4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(64756008)(9686003)(53546011)(66946007)(76116006)(66556008)(66476007)(66446008)(54906003)(110136005)(4326008)(316002)(7696005)(478600001)(66899021)(41300700001)(71200400001)(5660300002)(26005)(186003)(8676002)(8936002)(55016003)(6506007)(52536014)(83380400001)(2906002)(38100700002)(38070700005)(33656002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIWhXSm/LwwCUJ6pzlhEASj1tGVUPuY0IydPAaUUS/mdbNvt6p2ampv1Jmmj?=
 =?us-ascii?Q?QESDctiXtZHrwp0ny2vGvQWOu1G56nu+ixkuK03r8BIrJCeQujLBA20W9oAf?=
 =?us-ascii?Q?UUQH66lL26xVP65LWtWkH8q8eDKhSHVxBpCqj+WLVKEMPk5FLuGlhD6XuGyi?=
 =?us-ascii?Q?jdE1peXul/tA6Ge8pVX45p07P/L93hFprukLOQzHPVYLMYQ9AFJ+Rord/mJS?=
 =?us-ascii?Q?BaCyQmCHSx/Sj4IcFSUPrESwcsRrBhAwbPYwvehRB0ckviFtYKEWBgx4Q+27?=
 =?us-ascii?Q?2h18TMQR7iDVFOd22hB+mEkSEsiv/XS16wLMh2khMsoB6m477AMuvO75P9pt?=
 =?us-ascii?Q?P86RXePcX/4TBFDF/pp32WhSD/S7E1VsyfDvCNRlSnSoWx7YFimcy9hsnRnf?=
 =?us-ascii?Q?ZfBmTiJWdvx7ePzFin+ZQK9vHfKe0IKIoxKuAT3uOSPb0bnrJ/w/Kg1cc2ks?=
 =?us-ascii?Q?nCGyi3cgkkPBkiMWUWAVybdkgPoOba0yeDVryEtRM8oqqPjpS9s8v/uwj9F4?=
 =?us-ascii?Q?GcVBmBHu+dNKDsV2XxI5dwSoPb5EGqGXJgMprcXOn19mjyE2wcscJjTVgF1E?=
 =?us-ascii?Q?82wwFWnmB9g2W4TT4ekBf75JbylXkFyhzIRadf+eHBrvQDraqQ1pu1HIhOP5?=
 =?us-ascii?Q?k98uqgJWnV6xp4Tt6ccxvwZMDPie7lkez/azJv0UA7oX6fEkOYGrFHoA4PHe?=
 =?us-ascii?Q?aFjYl2KlpzL+1xOOB2i798a9JZNQaAJUED6Zvd+e+kDDQZXzJAVxQte5xP5V?=
 =?us-ascii?Q?EN/YfSadmwNHFCKZ1+BBdopL6AYdVvKOx8FUAGHTR1NNe+rHLivojrNk6CU8?=
 =?us-ascii?Q?0JiCmpoPPeK1FVexIBQMXRHFVouuqbyHaExP0tqySDLkmjUnSvfdabsiUOqM?=
 =?us-ascii?Q?5/lDx7OFwHyLvHv5NFEHYTSpRNrKZ6XY0lDk1Olz7eQprGSyw65579Vv+xxY?=
 =?us-ascii?Q?be56VE+EefU1gn38SyL/L9mD9nF5ghqsPCZtRSpWh5rjUWxeU6+d5l3yvYdY?=
 =?us-ascii?Q?mOJAzHA1yIjkzK/EEytIhOzf9fyr3NR17O6x7l8eFfFpVT4zQFReMao3Co5R?=
 =?us-ascii?Q?HP5xdS3E5KQbtTY8wsprsLlNZvC7DHhFAX5lIIip5DmEkdiJKQvp3xEYtxt7?=
 =?us-ascii?Q?uyZK0sbWcE7v56WM44yFwcnqwj/HDcYJtDApXHzzGhhFryYhdBmLh2o5Sniv?=
 =?us-ascii?Q?1VFtXIi9vfMaOcX99DTpbgGNI8FI1pxf4NUKGScm0P+oHRB+Pyhhs0aTH9HM?=
 =?us-ascii?Q?rWZ0nqWPP2Mf2gN9PeZkyD6r8pcLHTnqZ0T623xHJ/UxnxK8Pt24WfoGp/Cr?=
 =?us-ascii?Q?PaM7rYvqnUxDaLBLoeg+/fXU6mRFNyt8dzQ8mKbdnNjuEZpkctviXB3v8bAE?=
 =?us-ascii?Q?htB6iH1Dl5plsBwe3s2lizarmgxXnNmRgrC7dlPdTSPZOLtqot5tnOwxdA0E?=
 =?us-ascii?Q?oIVQE2RE+yke/nRIMJzSy4zaPr5TTl2cHLb9ajC+qxtKH9kVP1khY8bcw98y?=
 =?us-ascii?Q?17nbXeZ9aB78nfCndARVvOiF2Yxo9eip5Mm8Q3Ob3mreWvGo4FIGW4bDnKw9?=
 =?us-ascii?Q?04uyBo6/4+GbsYZe3kU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2d9e3d-9182-45a8-44c0-08db56b100c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 08:30:42.4959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZN+aWp3I8w2nlSvtcGOjQlIL9pXPfGLPNEi8zPojgeG+k87GUJswS2SUZK3JpDaBGQu9UjCI/+6S7PIlhyYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks for the clarification, Thomas. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, May 17, 2023 14:31
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang,=
 Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on =
gfx v11_0_3

[AMD Official Use Only - General]

reset_context is a local variable in amdgpu_ras_do_recovery, if gpu_reset_f=
lag is not used, read regRLC_RLCS_FED_STATUS_0 register and check sdma fed =
error field may move into amdgpu_ras_do_recovery, which may corrupt the cod=
e structure of amdgpu_ras.c.

amdgpu_ras_do_recovery support various mode resets, but the order of these =
resets is fixed and the driver cannot specify a reset type.

gpu_reset_flag is like the input parameter of amdgpu_ras_do_recovery, which=
 allows the driver to specify a special reset type.

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, May 17, 2023 11:41 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang,=
 Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on =
gfx v11_0_3

[AMD Official Use Only - General]

Shall we just force the mode-2 reset if it is non-fatal error mode? Is the =
gpu_reset_flag really necessary in such case?

reset_context.method =3D AMD_RESET_METHOD_MODE2;

Ideally, driver decides either perform reset or other error handling approa=
ch (i.e. unmap queue for gfx) in IP specific handler, while keep the amdgpu=
_ras_do_recovery as the unified entry for various driver mode reset as ras =
error handling. Is it feasible?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, May 17, 2023 10:14
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx =
v11_0_3

perform mode2 reset for sdma fed error on gfx v11_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++++++-  drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h  |  5 +++++  drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c=
 | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 6bb438642cc0..f2da69adcd9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2053,9 +2053,15 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                /* Perform full reset in fatal error mode */
                if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
                        set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flag=
s);
-               else
+               else {
                        clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.fl=
ags);

+                       if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E2_RESET) {
+                               ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE2_RESET;
+                               reset_context.method =3D AMD_RESET_METHOD_M=
ODE2;
+                       }
+               }
+
                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
        }
        atomic_set(&ras->in_recovery, 0); diff --git a/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bc43f7db17cc..46bf1889a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -339,6 +339,8 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_STATUS_VALID    (1 << 1)
 #define AMDGPU_RAS_ERR_ADDRESS_VALID   (1 << 2)

+#define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+
 struct amdgpu_ras_err_status_reg_entry {
        uint32_t hwip;
        uint32_t ip_inst;
@@ -427,6 +429,9 @@ struct amdgpu_ras {

        /* Indicates smu whether need update bad channel info */
        bool update_channel_flag;
+
+       /* Record special requirements of gpu reset caller */
+       uint32_t  gpu_reset_flags;
 };

 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 068b9586a223..26d6286d86c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -84,8 +84,20 @@ static int gfx_v11_0_3_poison_consumption_handler(struct=
 amdgpu_device *adev,
        /* Workaround: when vmid and pasid are both zero, trigger gpu reset=
 in KGD. */
        if (entry && (entry->client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
            (entry->src_id =3D=3D GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) =
&&
-            !entry->vmid && !entry->pasid)
+            !entry->vmid && !entry->pasid) {
+               uint32_t rlc_status0 =3D 0;
+
+               rlc_status0 =3D RREG32_SOC15(GC, 0,=20
+ regRLC_RLCS_FED_STATUS_0);
+
+               if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0=
_FED_ERR) ||
+                   REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1=
_FED_ERR)) {
+                       struct amdgpu_ras *ras =3D=20
+ amdgpu_ras_get_context(adev);
+
+                       ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
+               }
+
                amdgpu_ras_reset_gpu(adev);
+       }

        return 0;
 }
--
2.34.1

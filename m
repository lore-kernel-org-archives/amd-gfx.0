Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF5C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Sep 2022 17:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B921D10E5AC;
	Sun, 18 Sep 2022 17:15:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F019210E5AC
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Sep 2022 17:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckUYft5kaBXwIKZQaQeoc6GRQLbAVFOjaBYtFSwcrWT/RxJBz4UKf2mTwjuzLlytWYDKlhQUELEdfW7oZkkWSXUL1/5D367dbl1FAi4RcIZZAoNSpWfcxg2QiXi9/ocmjzocjgPk8iR2c63+bXEYKX3npMCjye/1Xa4W/IUvG6/Vf9Hy62Nj3cz2S9vyBSqzZOvaMBh0ZBpAbPD5NZPABEk/n0sgG+sFG/oxDsbA7+EQDU1KtA16WgRxuTuJsna+k7kvMDdfExHcLRwRmDLBI1D+NWXqaZwwV3LXq7QxB4zqmyWXs7GtlYNBNOM2xVi27WTD6yL0lPn5yNhs0hL8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwb4GOnEWX5rrsgUgoeMyvLvGELDW127E+NzQVDUC98=;
 b=lyHttv0e72FjaRwV4dGYiKT8hWvLe83BoGwCsuj+b/H3d6QaNyz6WiE5djGMRvRctUMha5apERRS1nbR5kyl4kl2nqSpV27EIa62GAkJYyiH4SkPNMGswZ6TIcMDJ1067zLO3XjprSIXFXap8TrNxvj2TQTve1RsQ+fXmcvPcZoNpzl+zY29E/bRjNCMGEwLsu8qtrkF1cr5yUA8NalbyZFYt/cG/jYisF9EutCmQ0CkzmydgnBE5D9EUyUoF+BMwhwp+6YVgMUtTOWRMgM9o+QoT+95BlI7zkG0++qcuVM03a0o+CaoOB4r//G2XwuVF0KyVGqi+yMXV5+JXGCMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwb4GOnEWX5rrsgUgoeMyvLvGELDW127E+NzQVDUC98=;
 b=B7JVRzgYlxEHP/t7iNJuCj6wPGrkignoKWxrkj1+a8NUs6+xvhRCItj7gxYzHGZr/2cRbclMBV+9akNoq5yda9A7Duxo1bp7J+Cp9kSF+l6il/uXoOOi6hPxdD55IrWXxWpKd3EwlmyAbLhZ0UogMIgDuIMGJBQD5YnnqZuPCEo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Sun, 18 Sep
 2022 17:15:29 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::24cf:abf5:436a:e1f3]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::24cf:abf5:436a:e1f3%7]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 17:15:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2
Thread-Topic: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header
 v2_2
Thread-Index: AQHYySTkWpmcKyI9q06bCL9GM7gji63lcaqg
Date: Sun, 18 Sep 2022 17:15:29 +0000
Message-ID: <PH7PR12MB59973981CF9C648188B60578824A9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-4-Hawking.Zhang@amd.com>
In-Reply-To: <20220915170135.23060-4-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=644e31c1-3568-43de-8ee4-14a1043a6c97;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-18T17:13:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB5002:EE_
x-ms-office365-filtering-correlation-id: 83b5af96-9724-49d7-cd55-08da999962ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOvhEh0X68OIA/W1PyEeF2Lay1dAKmmq0WMEnmu5aT/U1RGoQ/qCwvUMieQ51lyHiUqwI5QKdK/WrlpToahZOD6el9hZZXdn2/5cgFap+LXd0Rb5GE1CndQyIilhg0lPkVrliVi3coi612+J0LaDcgyhap630DA40eTK5mV04kxvxpYwtvmI7Mqy8cRYMSFfW+Hs6/BFsgL9A9TiOEcqWQ9vSzy0XgQZwcVX9B2aa9ICckgeteBf+BlSwONyY49Zr78GheCqzX5Ed14mj+2D8hfM2Hfbn+lOnUsGvtfUe2OnU37IxchTYI5mZnU1mZF7cbEKilmYOwHHYCR1YBiE6oFLJwny94GXeWQ+zy4AafdY5/5P6b05/t7Ma0uBel7WhPf/5eNtrRMGNf9uRf43CVIXHKDqwJi6S5lggl+FyEG47nrpnHAbpQFzRbPGrQlesuY40IRxOjIn2ZywbRFcBtZpXqslNgIr6vfgHxNmfpdUOGC8KmFMkxDFVfrrdvwNcv8JMmIPicMs0VINuM60HLFXVvd+OfsjEr0QQNM+TtxYfhcJfjgU6mvG1hW/m+M82Qt0Mgm96Q2WsFyC3/aFxOHu/Wj87RvGjYLQsYglw3rZu+LmZuSBoUEVqny1JaU2gfQfArBD+XaQBEaYjBDVCvmzgSaJntl+mN80cugnTM3mW6m9ICtB0mOukQtAeHHwbfmqiYpZD/t1aKV6NKpK03VeI1RSjhaussBoDubkl73zBJ/Bzj8r1b5tlBIk1eRp+TnAM1dwwQWogOFyBOFpGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(38070700005)(52536014)(53546011)(6506007)(86362001)(7696005)(9686003)(41300700001)(8936002)(33656002)(26005)(5660300002)(83380400001)(2906002)(122000001)(55016003)(38100700002)(186003)(478600001)(110136005)(71200400001)(316002)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xdx6xy5n+A0+/Fc9D/YK2ID5qmXdFVzOjgmA3N1AScbeekb11tNmTXISYiAo?=
 =?us-ascii?Q?D69cdgC1nmiD9MmefSpIbmGHCh5/6gc5rWOxtELvYs9KLNuSUZ1j1KX931Fn?=
 =?us-ascii?Q?ptzcSocTDHljq+ZvkIW73IYsw++PGgvapwjLWaelL0SUXh58LovSE+v2rrVX?=
 =?us-ascii?Q?7ftvartRY5pyXGyRZNuqX5JbmXGQ04RQiuO564sds/31ndUQhrXQJEyz2jqn?=
 =?us-ascii?Q?oXStQR6OWd1qaJCyKQcv8tlZbHSPVAQGpGlDpljcYNElgCPaS5R6b6rOL8Dp?=
 =?us-ascii?Q?AJGGqiwPziBC8LF9tcs8SYOC/psEkgMtVQhSSoAkUQ2kmtKR8wdLX7ViOyGd?=
 =?us-ascii?Q?pGLLHwCujSnDddFTp7ZFoyc0S1iHYxqgJ4bKjnejGT/mDF2IDtt5MP/oZrEQ?=
 =?us-ascii?Q?JgfjWU+i0uv7S6EoRDmR6+ceWa8Dj+ujmKYvmI+Yi45ByYYK6NgUSXq+PlTl?=
 =?us-ascii?Q?PqJ3lV53/g6rugI97Qh7+my3FuZX+cEQ+dAydOtkkGAaz8Mdxi8pJENyrTNg?=
 =?us-ascii?Q?1cqjsa8L/SLJdfJ53ZRY3OYFNTb6Q3fdMOQX+D6f9YjSSU2hb0dQVoTH2daW?=
 =?us-ascii?Q?XIwejVydwCehyraAvLwSjcEDWIN9wBHUQlvRILQvJfSFSkF0dHBFkGKZkfkW?=
 =?us-ascii?Q?NCzOXC4kBPXT0rGQoXtVzogdIPVbuLp4b3r6gxbvOq4NTljmV7NolymiVE1t?=
 =?us-ascii?Q?1CGWgzEPw/jF0+Kvk2iUj/GKYL+773smCARhzED5+91EWaL3prZ4OHa08wcv?=
 =?us-ascii?Q?izvCNUO5cMKUsRbtTjRzSpKjs7ijs+s9AlEf1ImjlkkdJ4AEUlkbymTBGHQZ?=
 =?us-ascii?Q?8qpWXMeZKnxU0gcekO496FQSDZlXkNxk8aWa5FBZpFw9aCJ93n462hUIg1ux?=
 =?us-ascii?Q?OTHhmYUWN8pJxBQ/+iF38So845awS6twiBLTk4xZ0lH9J/mdxBQyIsi3oD0t?=
 =?us-ascii?Q?4cZVH9tYGS+TUexx2q6PnNdTJnn0yxsy2VMetkpmMTI6T2ntHll2tahwxBm8?=
 =?us-ascii?Q?Z79EMX1O3+FhUVlTDqjMqr+HlcfW28RmdWmkxemQk1+H0jUyOn6/T8/y9Y4x?=
 =?us-ascii?Q?Yvu8zl24RiJqSk4Z+Uu5dzcvL1MpyFZkKBrvSe127WUu55nh/dIhhgtq6wuY?=
 =?us-ascii?Q?EgRzcVKVbrZ7E8paU+iH/Nt1F9pYyHmTjH2usWga808+D0lehQRuo4jSrccw?=
 =?us-ascii?Q?Ev7h7t3af+b55FvYyq/us2DSltACdUMHwzvGu3Dv9y4NTqoAIaAFdDZFspox?=
 =?us-ascii?Q?GBgcP8FnB0T+DnNGC5efX6i+29uaifsWn03Eo2yYHl+eUeggteWTYyTvUqCh?=
 =?us-ascii?Q?S5SPzo2QMwPs310FpAy3PVdv6ClDr5pAJtT0LsB4mI/awIoMGn2Moe2RO9O3?=
 =?us-ascii?Q?A/z7NOkiW85Foq5kDyj0fyv01PqPxq7L73LHcFpL/895ZdHDmZp1c5UCzU61?=
 =?us-ascii?Q?nJ8GJ55wL9qWpHkE5izCJzCOdkRKZLZlAsZGNgNMTtfjC8EWIXX5IQDEmN2D?=
 =?us-ascii?Q?Fzoexj9I+efLbtRYmwOpbWT+8jZD+qG8xwfa/fTjLWhKdjPnCAarHmA9f20l?=
 =?us-ascii?Q?dYxziWtnCoBCyfsPpGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b5af96-9724-49d7-cd55-08da999962ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 17:15:29.4988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAWHChgveCO7JStbLQJVXkZ/811ZYjBQGzgipUNmFqdMyzMUhe8mwiufNkpQDgQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Friday, September 16, 2022 1:01 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2

To initialize rlc firmware in header v2_2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 04bdb885918d..a055818d87f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -376,3 +376,33 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct =
amdgpu_device *adev)
                }
        }
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_2(struct amdgpu_device
+*adev) {
+       const struct rlc_firmware_header_v2_2 *rlc_hdr;
+       struct amdgpu_firmware_info *info;
+
+       rlc_hdr =3D (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_=
fw->data;
+       adev->gfx.rlc.rlc_iram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_iram_ucode_size_bytes);
+       adev->gfx.rlc.rlc_iram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_iram_ucode_offset_bytes);
+       adev->gfx.rlc.rlc_dram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_dram_ucode_size_bytes);
+       adev->gfx.rlc.rlc_dram_ucode =3D (u8 *)rlc_hdr +
+le32_to_cpu(rlc_hdr->rlc_dram_ucode_offset_bytes);
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               if (adev->gfx.rlc.rlc_iram_ucode_size_bytes) {
+                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
IRAM];
+                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_IRAM;
+                       info->fw =3D adev->gfx.rlc_fw;
+                       adev->firmware.fw_size +=3D
+                               ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_iram_uc=
ode_size_bytes), PAGE_SIZE);
+               }
+
+               if (adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
+                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
DRAM];
+                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_DRAM;
+                       info->fw =3D adev->gfx.rlc_fw;
+                       adev->firmware.fw_size +=3D
+                               ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_uc=
ode_size_bytes), PAGE_SIZE);
+               }
+       }

[Kevin]:
according to code logic in above, the following code is not needed to conve=
rt again.
ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);

Best Regards,
Kevin
+}
--
2.17.1


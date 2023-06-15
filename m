Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8886DEB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 12:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD62D10E4E1;
	Thu, 15 Jun 2023 12:50:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370D810E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 12:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOpYOFfaLh2rjaU0SLg2UMJA3gN8Xzuo3Vv/0jCWE5HEHD+cTHuXsI4Nne7rlfINcs4pA8H8FRPZAy2Npp4ecTL9gltaLSRWafhnj1tlzBUmdSfErEMPIYd85HxztUMFrIIalRYbwomtGDi5fBMFiJLcrwS4/wsIW4zBkZ6JSM++lRod6rgxFBVVAhY2dv3UiDeYhIqKmQBqkqTFVpZql0l6PBuOLaakIaQrX7vYBJ7czdc00mP6hCkFr5Q8QPU3fANyK7gEmJuzUJL04g0Ga0lDsQ/6t+OyGyizhsoi0A/H2pCMGFqp5L90KOTTQVMUEVHqUZvd7JgExR6MUFdkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P37Y6wVfhZ7gjc3DUepxayxGu9ZoPni1JcqU+QV+Zns=;
 b=PncekRsXUWOWLFXkbqaSOznooXVusAkV1ZPtirVyNso360IyuV84q0eA+6uKG/lSHAldS2G1MFjWqvqO6dhJx2bAFDN2OQNCg0Yu8y97rl5GCY2BU7i0ZlacPbSosGiuLtkoOgI8wLI4Fd452KDGcHy6movll2tDPfnFZ/tMpDP+1R7yOgVl3/jZbjJ8MApTBRY+F01QFMcz6xn3mn051BTESQbpjaDiKNf/1gzEWQLdMjTZYI9idb9RcDXYJXeZJ7ynCA55HonRWq3lj74JhkhD0hnY+Ucq/rs01OjvOgJoKF0vr5q68R0ffhdoVz9djXqKL51TxY3P/Z2e9yw3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P37Y6wVfhZ7gjc3DUepxayxGu9ZoPni1JcqU+QV+Zns=;
 b=ZMtDzHhjfa24deWPak0GrNKkxrgU0IzABjHwwdfPKz5RzUWjqutvfB/83Vju+TWP9zlYBtG96g4y6y+7+b9qWHcY3A90rML9szNJ+3THdoN7Zj9C+lhgXKB6tHQQxTRzJQ9C8Az9BCWTlwhaJ75faWlBC3FK2Iu4LcKlEmOKLTM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 15 Jun
 2023 12:50:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 12:50:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Rename aqua_vanjaram_reg_init.c
Thread-Topic: [PATCH] drm/amdgpu: Rename aqua_vanjaram_reg_init.c
Thread-Index: AQHZn3Q70xaNVTCmx0OrAAjvuwtEra+L0K6A
Date: Thu, 15 Jun 2023 12:50:02 +0000
Message-ID: <BN9PR12MB5257D580FBE27D31567A4055FC5BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230615102855.1629085-1-lijo.lazar@amd.com>
In-Reply-To: <20230615102855.1629085-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dd6e8661-babf-4284-85d8-c9bb2023bee4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T12:49:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8878:EE_
x-ms-office365-filtering-correlation-id: dac532c1-4571-4f51-a643-08db6d9f0949
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH51imU8RqsUcdYOSofTF024QAwPIPR2WRAIRn1arP01F1mjgWYg+bAjBsfW1WapeF2YJay56b55OxeFJaNntBg4XIGY+qY+Sd7cVtK2eyhqkMsq9ilMgFo2/3hBAp8QHZVST/J/dkSjtxFeIrVvEBNCDL/vyXOy9VgG2HwxzGMkPqSdBXdZee5az/fw13EZ0ezCZnWueH6nhDgUGN/XNx2xPQaa6VoXDxbY2G37RT28Lkk7dd0Cs06Ul5tz3RNdK4PNlKqayZtLp/5HoWypTgZdC2JGmtDfv771V58KTTSZ5veSfS0ZU95T5ARjNj2OcIC5+/6R46G+tx+aTPm2yPFjXhVBNcs3pW52Ucc1IN+rZQn0OMugZ5UESYjuOKQ/K3R3E1XLdIllPM2UIAyGphH3s63JH4qecPGSilTAK5EeRwbGlAgotPWB+JHwHSWuvj1KVXiUYgOH5LBgJDnufVDk5vtqzUlw86bn3m5VbrqQbFvk68q23miD3YcivAjjok0hz/5atIiI2RchIPBZSWodAQcP0jGftk84dPRAmPa56wdxrQNVgWuELHqqqeaov8v92vmfhkQtIm5NmwKsbg68q4zYICjWuiATgivvSmBmpuvjthD5YzEw95RX+4Xm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(83380400001)(110136005)(41300700001)(33656002)(38100700002)(55016003)(8936002)(478600001)(66446008)(86362001)(316002)(66946007)(66556008)(52536014)(76116006)(8676002)(4326008)(122000001)(38070700005)(5660300002)(66476007)(54906003)(64756008)(7696005)(2906002)(71200400001)(186003)(26005)(53546011)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b/shLTO2COBZs7H/B4qYNjk1mAL+D8z22Kjee2BCLDeTwAm8KmgL/3FADMuT?=
 =?us-ascii?Q?bJrzlhSy8A54NaxM8sz6Q3gr80M/YLBLl6E98pfllAO45Ys1o4eK6Rs7CKCE?=
 =?us-ascii?Q?GEe3eq8iZeti9+Crh1DbOvp5qXKsRxhQSz00PgehdUZneobcWJO1v4q5lGI0?=
 =?us-ascii?Q?J3qhDmOOalDPB1FUv84hjXBmlGd7+T8w9rPaKYnDvCFv90pRi+WsKiY100Ff?=
 =?us-ascii?Q?l6cI9hiHvBEzu//xZqmCdDw7I4MxyigqqtGokTdW9EJzOhfUodx5BGwh6tH5?=
 =?us-ascii?Q?VRTZi+pgJomdWkJLvTTfxjmryWZAaQ32c4tfl7fW+DA1KrUtI6eTVHdfRVd1?=
 =?us-ascii?Q?0v9UQVJSp+H6J2J/1ot6LgP0+4x42WF+sFA5GAWymIT6QIQ4r5u+5moXgFZt?=
 =?us-ascii?Q?6HcSJ0IFCP/ZorOBey+1R+Jc2kX3l2xqjS43S/VXK5C+7ozOe6NA8f+YCV+S?=
 =?us-ascii?Q?TczxRLUm2IInHMwC12PcF8oO3AfFpfK3yjhm0MI9yONQPvJyAuWJ40kikATk?=
 =?us-ascii?Q?bIZU0hxERi7OvzTL0dlHksdfFlCODOi0bLPAAdUfHgJxnh6vwsMBnqBQjau9?=
 =?us-ascii?Q?XhfsEUIuVFnFwuCy53sFDnzUyYtg24pjIdNUSvVhBj5gUa5lh/Jxno7QEw6y?=
 =?us-ascii?Q?tNiRNFdmOOOwaY8I4MIyE+d8rZ8r2CODgC07qDt6oyWXJvHjlmpumw9phgaq?=
 =?us-ascii?Q?t4bkqHxtBphNK7kHa3Du+fTpK+1Xzb/T7ctVFiWK2XJ2dATgPQSFDsLEZWxZ?=
 =?us-ascii?Q?MJuqVN8IARBcXOXU4nyuJfXSYwnnBep1H1RoWprevRS1sQfjciwbFUkKn2V4?=
 =?us-ascii?Q?eOpME67YGMwqJwoFU0x4lvNeSC41f2dhsDtUjpKdXoOb6etsXquv6gSpHAIB?=
 =?us-ascii?Q?zrnx6wX2chJtEJFaMbXhHikBdslQXme/JqpXhuYjsh72mGCcFqLQEfvjGCie?=
 =?us-ascii?Q?UtT0NebaAkgqvOG4soewXN9/G0qt5r6XdE0rYtFwL9ANEqnBo4cbAtO+en/f?=
 =?us-ascii?Q?GCYhp3XWuOeYDY8yZkAFPyBl9CBEFkPEE0UnHxIb6nMFuPllOLJz/vcZXBmL?=
 =?us-ascii?Q?Kq//bGy9lBcFHCLh/fL/VbntbLFWoBNxcNvnk14Bk6lMAS+iJQUkVLsZbg+p?=
 =?us-ascii?Q?XJ3mr19JA8oVLp4EShTg1Hg11Y4ZoV7Wwk6wZlETQWMK1v3/iONsnUDfNZcN?=
 =?us-ascii?Q?a2F+gxzZM2vKTGO6eytj3HwtrA148LIbywG36nuf1OijktedEW8/yti9pQsR?=
 =?us-ascii?Q?ltyFQh+8+df7mqfhJSCruPJwzUD4fQsi8xZQBu5Qq4uIx9GpPF7fZeEWXE+f?=
 =?us-ascii?Q?cCtyjRCuS6S4N45ogYdiGbFaSnZT62zJ6bryRP1eXwpWAEjP4HP4nF2/UBoP?=
 =?us-ascii?Q?pEJWpluU7dIhi+jQFn8zs1Y7oWxXkut1CF7m5D2A5mu0ZSAEddyCon6M23wv?=
 =?us-ascii?Q?eDOl5uqsPmzMRHAxL0OuQozCsun9V7m7axNrjQP0VYRWtpxg5qRdzh3SA227?=
 =?us-ascii?Q?axHhDvv+h89usdIcxAPi+5qo8erRnVQExsSE59XhexFaxvsCKqFsBsd63Vf1?=
 =?us-ascii?Q?+SxhT94K26O4eIZfMyt4OQnFGtwKRF0XBeY/8sbg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac532c1-4571-4f51-a643-08db6d9f0949
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 12:50:02.5691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSt+9PNKUKaIi6IBpDCNFPWaMaOoJ4HVArziNbVnIAHQ8CnYZgX1j89G3SX8jMFsScxBWlNtCp1LsEuQVsc7hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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
 "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, June 15, 2023 18:29
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Rename aqua_vanjaram_reg_init.c

This contains SOC specific functions, rename to a more generic format <soc>=
.c =3D> aqua_vanjaram.c

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile                             | 2 +-
 .../amd/amdgpu/{aqua_vanjaram_reg_init.c =3D> aqua_vanjaram.c}    | 0
 2 files changed, 1 insertion(+), 1 deletion(-)  rename drivers/gpu/drm/amd=
/amdgpu/{aqua_vanjaram_reg_init.c =3D> aqua_vanjaram.c} (100%)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 8d16f280b695..60c800d22e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y +=3D \
        vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgp=
u_nv.o \
        nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o =
soc21.o \
        sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o =
hdp_v5_2.o lsdma_v6_0.o \
-       nbio_v7_9.o aqua_vanjaram_reg_init.o
+       nbio_v7_9.o aqua_vanjaram.o

 # add DF block
 amdgpu-y +=3D \
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/=
gpu/drm/amd/amdgpu/aqua_vanjaram.c
similarity index 100%
rename from drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
rename to drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
--
2.25.1


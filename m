Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1171BCD98F6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 07:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C7910E475;
	Wed, 11 Oct 2023 07:06:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABE210E475
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 07:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+F09dr5jnkMarBOQwJsAot8W17E7UX4XTHzA+v3PLsGpOhj0/ZusXpq6rU5I8iEPX3lNCpucOmitzOAPVY25XF7X0grIrYjTeZAJkKc4O7HAo+AMNwPw3uS/AqBQ5D8lQx7y63lbLg9J87q2s1VNee01X7224TBoTPPT7PiJa6GOfE9U1pbG7UkfYP4W90LFsGt+p/TqgrC8xxcNJ1D/bDKedETbAs7fVUFP5eGP53KVJjrY2k4RBFhnRdFaRihb757rp9hCY54oS599eXFCsN+34T5Mp3GEek8EBfROGjTt77zhEhCabHYKtytuGDm6doqemkUUGn6YgBk/eoWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VBckUeA2Dm2OosBUUhf7+m1Xq9C1I4qRJvmx6QtXWM=;
 b=MKkhGOJkvKHPMZ3v6QKFmRIXgrip83WD4llsYDXaescoaXl47f57yRMA+0SfQqV9g6UVFjiRU/Zw32fqQTKfMaygSvrb2XB8IdrqvpPZqStfXj2kNJnd1hYYSJtEU1GAZBr4ip4Syk3UDjslrPEGwPrptsYyjO6+Bku065JFQVSt8mMzB5f6/cqxP4sCsabApYTrHESCJGb2mToHFWQUQQj/Q6dPgfmZOweY2uWAEVlUmdXsLEi0Sgsz1Tvgo1I9EkNX0ofTs3wPj2/SD+AsbZYQSr5mmkhm8swq3QIZXSaKaj+S23o0wv0EIXzUH3M9pZ3sbNQ2CemEllYGpxhboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VBckUeA2Dm2OosBUUhf7+m1Xq9C1I4qRJvmx6QtXWM=;
 b=a4JecNlgwM19s9Z4QRsbzC1D7mbGNq7sBDquXzYNrlXEMjKJ8B6x0p7Huk2RUSSteKGeTytZ44c3nx5gYt1wSeFYeei+8W4j1B4iqCVKs+1u0DhWj1my4OXPkNilAgVUnnI3CkjSMmhK4LGv85fsgWSg8RVVTCLOgh8KmyPR4Io=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 11 Oct
 2023 07:06:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:06:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Read PSPv13 OS version from register
Thread-Topic: [PATCH] drm/amdgpu: Read PSPv13 OS version from register
Thread-Index: AQHZ/A9ahT2CqyNSVkmRf2rRHCzbRLBEKtFg
Date: Wed, 11 Oct 2023 07:06:54 +0000
Message-ID: <BN9PR12MB525775695E286ACA6879B75FFCCCA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231011065035.54324-1-lijo.lazar@amd.com>
In-Reply-To: <20231011065035.54324-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3285443f-9197-4a63-9d49-604851c90b9f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-11T07:06:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6675:EE_
x-ms-office365-filtering-correlation-id: 3a81c388-22c3-4921-a308-08dbca28a69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2sAlquKSBdsM+J/PuXaiPkcrpHoXOoSaOlhs6+nozkxF6rLQSBB7zbjmhH43XfsoBcBWbOICExl46Z4t28FWqyMVQxuYS7kHy2a9N/BCZZLmYJmCyLs7pmRwSKnXOjw1FE9KFjKkBVOBXRx+f+vYjepJDUFvvQPkCFPu5xbbFnArtg/oeH2WfpnyHPss6pYubcYpdYeCd+WIo6pbiuMuOQtjc4AdKke5VPQ7gyCvN06bNL0BORypybFoZvQbk3yi78QIfGIxGMcPr0mDmzkAlPSHuhPe/LCoTNRr+/U3PP/b7h5ZiKB0Y1LSo5EJShWdx7MgdTHMg/IDOkAei7TwSr3Wyt1KCT9BkRK68p8CqpswBdLz6Ny+5pmzMQh6ar3xrO/qRAVfpOXQAej/3mqa8j0dP0EHU4GzUb5elZeEFEa/pXJiFu9rYgorhMwJ+nIukt0OptmQEDBmw2Ztc50cPsNsX4oJ2P5FRDj3d0eufbSv69UuiGHPxESEKRJdInTrLli9xYMBQ5rXGWiTiBoIZrmZvyfDu2Vx5I+2QQN+FD1AcK3mW8/plPvMfS5qSUsIKERKL48bVaJq5QqgM5fKFOKowFkUnG92hw3uspl9bnKmWNAXUcDrTdt+XZTYHx96
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700005)(33656002)(38100700002)(86362001)(55016003)(71200400001)(7696005)(66946007)(6506007)(53546011)(2906002)(478600001)(9686003)(54906003)(66476007)(64756008)(66446008)(66556008)(76116006)(8676002)(110136005)(316002)(83380400001)(41300700001)(5660300002)(52536014)(8936002)(4326008)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0pKWQgXvNFjomJqOeVrwe+FYmLbJA8skcGfN6v8KIYC9VvDSgHP8yQrTeuo+?=
 =?us-ascii?Q?XNUNW6JLqUXxUAWHkn9OSiH9FQOYS8lLxnHu5uScoLeHr/LeP6cff+TVtfkz?=
 =?us-ascii?Q?xuBpj3Xq2eztnx09WLcFpSoZJzFmbr1n5Sgu7aDWrlaYQp6ksuUBs2WkNqcL?=
 =?us-ascii?Q?Rmg1YYnnK1GFMH2U3p3CFczSxu1mDbdNkaKeREekQlavc4SNsgSeMLx6X2aX?=
 =?us-ascii?Q?4tIrlTt8O1XCzmgSXMg2iYkUBYuPR1gPAviw3WDpf2ZtI3US4m9u20IYcHgi?=
 =?us-ascii?Q?7hO1ZFykfpp5fJ1Qj/paTzFBNIuQ6wHxEJ3zU1vg5T/S7gU2fWVjL9CGU85T?=
 =?us-ascii?Q?Q+XJNROn4j6lxbbdGdS/EGpBvq8379AqUdHA2pLY6ya08ZaFjOaj0dn3Nqqe?=
 =?us-ascii?Q?ZwrKSEsDYvklPM0ktsP9HQ1UE3P0IdvaTGIuauAS4igpt9Y7mZeUP2dhxXhd?=
 =?us-ascii?Q?kZr6HlzL4aSrl0N+M+Gl+HF5s06VusPyI0aXp0CDT+iGTV6w4RJKIcy1a8zi?=
 =?us-ascii?Q?xfEsBxey0o3KByJO5ZLuUlIw6kAZ6X5QwA2QwP4lEvIvd7tjmHzOYz/UFRmN?=
 =?us-ascii?Q?MN+wiXePg2CjSnspstP3asqR63dqKvYkDDOcsLUPypz4P03HU1PDDA1ODFbX?=
 =?us-ascii?Q?vgEYXUWNCYPCGCxqOQyaPCfdY5obDg9Jkvea9Fflyxav9FCrmKha0n42X0Ix?=
 =?us-ascii?Q?/nVsbR/P4LcOw8XFOHWWX3hgt9QmK9MEoArKaurEsZyA7UTvsctdOH9S07ot?=
 =?us-ascii?Q?J5hFeFtWty8+Hjn4zBj9hrBB9r3SwWtIwM4MRZ0krt21zmeNFpC9giIABoAc?=
 =?us-ascii?Q?7WN5y7qT1LfHs44dhSEPveEqoYR/FMPxi5FjdZ5SxWq7xJ+fiu63GdpdBEt5?=
 =?us-ascii?Q?P4NB32JGS7s3xdOZjTBADH8m+BRgn2eHZeQNvL2Axr9lqHfQdnorOB8mfsDl?=
 =?us-ascii?Q?LYi1nakGET1VCvDhLGBgVdthJuj7q8VFidyABIcjqY1QgBWT/U5yL6ILY29A?=
 =?us-ascii?Q?e7Azu9gOzI0fcnhSGsSrFPnOBWwEj5jAOBdUmAKZcMSvibQnui2M/XOckGZO?=
 =?us-ascii?Q?y+UIsPQIkOtdpLERk8rcawKZOhKNCVN8CGLLcsDJBfxJQ83lERJU/9X89SUB?=
 =?us-ascii?Q?t2iPqRKxcyAw5tdk3FPv3C4+VyY3QaMVoNd75GtdVzxAf6NC+Slcb8/IK/cj?=
 =?us-ascii?Q?xUbhAAL7Bs8fLPEw4HJ0XrbHXbDOLpFZwdOJhI5Puea/CDwMycWoFDlFdcE8?=
 =?us-ascii?Q?/8f5chpbeX/UWGWzkPotKU57zdL1zyo60UQIzCamfyigBea1qn1+dqejroGw?=
 =?us-ascii?Q?fEpafbTOk8oS+EAvkRgjdxjsxQvAWqVaMtBxuOzD+dEHpw+oViPmw+I/9zNX?=
 =?us-ascii?Q?pHCaz90CAQ6VvAURa/R2yZSgsxVfEYLC/6pQT1KX9HhFx7yivu3xPmDTcsBS?=
 =?us-ascii?Q?OdvaFrcn8O/kSPjUHG6DTZYTzyDGCYkjK8ag0pKnikZWiNP/WuKCNVN6NoeC?=
 =?us-ascii?Q?i/DK+AuhVQC7aqqWYR9EKsc1qUU6jCaCukhGHdF9Dq1eic9bwYva1EvbhUyq?=
 =?us-ascii?Q?NpKbSccO1/rl1O8zyJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a81c388-22c3-4921-a308-08dbca28a69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 07:06:54.6018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHC9KfzptVn3tW3emlTBuuf8JEMQOuxd5PAyw9u55ds6QR+10JLqXLqIPaT/GF3OANiShv+gKRiAha0H/EtkBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 11, 2023 14:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: Read PSPv13 OS version from register

PSP OS updates the version information in register. On APUs with PSPv13, PS=
P OS will already be loaded with SBIOS. Hence use the version register inst=
ead of using information in driver binary header.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index b7bc00d4c696..573046702861 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -263,6 +263,12 @@ static int psp_v13_0_bootloader_load_ras_drv(struct ps=
p_context *psp)
        return psp_v13_0_bootloader_load_component(psp, &psp->ras_drv, PSP_=
BL__LOAD_RASDRV);  }

+static inline void psp_v13_0_init_sos_version(struct psp_context *psp)
+{
+       struct amdgpu_device *adev =3D psp->adev;
+
+       psp->sos.fw_version =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_58);=
 }

 static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)  { @@ -2=
73,8 +279,10 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context=
 *psp)
        /* Check sOS sign of life register to confirm sys driver and sOS
         * are already been loaded.
         */
-       if (psp_v13_0_is_sos_alive(psp))
+       if (psp_v13_0_is_sos_alive(psp)) {
+               psp_v13_0_init_sos_version(psp);
                return 0;
+       }

        ret =3D psp_v13_0_wait_for_bootloader(psp);
        if (ret)
@@ -298,6 +306,9 @@ static int psp_v13_0_bootloader_load_sos(struct psp_con=
text *psp)
                           RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
                           0, true);

+       if (!ret)
+               psp_v13_0_init_sos_version(psp);
+
        return ret;
 }

--
2.25.1


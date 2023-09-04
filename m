Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7657C71153
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 15:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BB610E38C;
	Mon,  4 Sep 2023 15:54:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D89710E38C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 15:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2/W/QbHbEwD0bLriNsMmGkZHUNkkgm5OBx+jnRkmZMMqTVydfApRxXfgW9bUZokunBD5aQ+Pt0cxK1n4YrBDluNnSaEotx5SkTt6Ns5ChaECQplez42UD9NH5GSkTso22Sg4AiZarBpb6GMoGqXv2CobZxqboTL2xRYJIbmZcvL3ySJCMdIbBoslbqy4zpmQ77zakpGHNy5mrpsI44Rkgp9q+b7W3vlRH7RRbdDABnXE8L5tVDxD8skifAEYmNnjxvKFLCCgVQ2S9MKj5K3wDMdYbIHGb/0/Z2ePwxG2yoSRHMKEm+23kf2kn+0qABd97hMjQMekI0GeppXQ7nSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1TrcwctAsj8CdPiRcFBg+wt3rjg8uO6fyGF5RmWT+M=;
 b=OPMmewnn1GiPHjaU75pRs8kFp+N0cMvTj8Lyv0siVJQ8LxyaMLinq7O+Cbcz8e8/3o91y8d7fJazjo6RpCVgJ0ucYYi9HmzMGqzQWYrgqx7v0AlnmYNuBunEdz67zVfPydmiLRZDF2IdHX+kjll6PZTb/HojcUAmOJGukT9W5oyGxHLTc80cf2ChKw64wTzL6T4SSjsWOfmO5hNaxNc7lekOKg19lyYw89//cxPDYBlns1WuCELvDT1X6j4RxkNuo+/abBpTUlAFu9dl1X3UYy5Ee8QMkzzY/vVq9Y7HKH6LX2mn+E+wTfv0NZssJryU+Oo1Q8uBcVHTeUB+INSJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1TrcwctAsj8CdPiRcFBg+wt3rjg8uO6fyGF5RmWT+M=;
 b=L9PaUsbxKSU/ajwvHuB6y72JPKEtcDn6sdl4mJmJqDlgSuDR+nu5RrT1wnSk3RRP2ZjVeJfA/y3T3SfWIomfz5ueJTyjpSlmxrQJWZoavsXA17zbZMS++P5/UXHh6rxk5+lH1rPshlfurAwM19sEbMOA9wgCcVGtHKlOKfkV6Z0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.28; Mon, 4 Sep 2023 15:54:24 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:54:24 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restrict bootloader wait to SMUv13.0.6
Thread-Topic: [PATCH] drm/amdgpu: Restrict bootloader wait to SMUv13.0.6
Thread-Index: AQHZ3zAm2b9l9omTVkuwahvycGv1fLAK0OiQ
Date: Mon, 4 Sep 2023 15:54:24 +0000
Message-ID: <DS7PR12MB60711AF3E4969814B53B18598EE9A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230904130140.911853-1-lijo.lazar@amd.com>
In-Reply-To: <20230904130140.911853-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4a39ba2b-3a25-4ffb-967e-6a4290baff18;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-04T15:51:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB7425:EE_
x-ms-office365-filtering-correlation-id: f7fc7f2f-e2e6-4749-6b57-08dbad5f35f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZ5xP3nvEhH3syZWOhLNeyxDzOzM1AWAHXB2VpaZLiM1VRpt0f1AQ4vmAva/nWuT20lvKbf6tI0Rsf2yJpwAnO5Al6iGyFGTcGCqaK5HFVc0rQLIQd0BgjovXfDl0v0AZUnrjdbLAnjQw1nZ7tsPNiPIRZ7Xc31geMEDihNuwCtQJR19CWaPrYJbgWYQ+5oyKP1Dj4S42Z8lmJTqIT15F1eqep3pjgpYQ7Qq8+XwAmPJjhvYR4/7SBBHN23NQEvAm/JrSFzagT8F3GzRTG89/t9o85wstaYK9YjMWPXvbHVmZis0CuRC7SnhXAd7fjT9zDtN1ff56bikAusM3CYTr2YMCY1391JNVYfgy5H96aV2tN9QW3bVcRJ0KrjxP85xvyUr1GQdzf0Q4SCs0LpUicjzKCb3FPc6ERgwlSaaDrFqeZU1f8NCamiJ5Wstop0wyK6gsFcZ2PQhOOE3PmnuzqzahlNzEE7tiZf5+bMifvx58ODCeKxYCxLrIp81ev5M+v7BUA0IrfOootPVvHUCwk23ucGXe3v7QVm33Nsmfor86EOREAUGEYHNjE/ULyTeUwMY1a1tnVhsZ2dt4SD6LISODTbMGAdVWVuFh5qIsKqxixYY2vSV3pMyqOI2aY84
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(76116006)(2906002)(38100700002)(33656002)(86362001)(5660300002)(122000001)(38070700005)(52536014)(55016003)(4326008)(8676002)(8936002)(41300700001)(83380400001)(64756008)(7696005)(9686003)(53546011)(54906003)(316002)(110136005)(26005)(71200400001)(66556008)(478600001)(66476007)(66446008)(66946007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xahzBeVewyhiqz6BBPRaBS5Tu5ucLBlNpLFCAziLTV6LxEZxys+04Y0C0Tsg?=
 =?us-ascii?Q?LQB7ShyWOTX8VsjZ6T9ry5G4EbW716EbJV6aJgqv5S9Qkwrw8kYImg8j8K9X?=
 =?us-ascii?Q?btCiNIlLkurdRGLnI5a6+D87CLpeva1yeDyEQkiULq0OVa4B4S3Yl7jYwc/R?=
 =?us-ascii?Q?ElKjiiRTBRpeSdLaDglrNRaVerPepmIdAcXWprVqPV8M4f7RIbKKGcnPyk2h?=
 =?us-ascii?Q?Ni3z1C9+Cen0/E6gwdPeJbeiOe+eNLGvfatQWMIbhY6Up3v69p1zmZyOG2YQ?=
 =?us-ascii?Q?Ed/fOyyXFkkRdh8pkuXC2MJDzCM9DgLuxwgPIkWRNCj1qCAiDkclrIrxF7/t?=
 =?us-ascii?Q?1o+r85+1XkT0TJguIwA55EUlqRn2n1CaPDmFTIejM4Z/NMKGmCIVVry4yKCP?=
 =?us-ascii?Q?bkIqwrMaKaDc448KnjEH+oZcqh1zdVHRdv3tzS3aE+O5ncHk9rtZbHEza0Yr?=
 =?us-ascii?Q?/i8qW6cw66eYf54hWwgfLFSQftOgY8690oo4tVbnXGWEEqRwHddvBKsx0nJK?=
 =?us-ascii?Q?3/VbqRaBBT1IYJR+Nfy8MxfG6MbiPvYfOFgg2HO5yRIQ3vRwD9ZVBEEagrsL?=
 =?us-ascii?Q?2dhrDhprCzc6hjYW3SfCoH7bNCbJel2TjMdDHqj81FKm5evH6TQZEuTi5KQe?=
 =?us-ascii?Q?k88w2F00Lrbeeao4133Wmh5yZy7tWWnaPqRPrFMCwxO3tYlon92NNp1tW7rA?=
 =?us-ascii?Q?JI5/PR7O1AKRcoTz2jXS2dpYCbYQapmrt5GIbINE4Z6+rGWMgfPLhjmfhnXO?=
 =?us-ascii?Q?ZEbCfyY9yfpuiCobHys8WBp83WgQha8WHzqYmG4lNHOWukgjMI52YkKxHwpy?=
 =?us-ascii?Q?KROKjTTzppZtv1Ghzgh+bYveSlSt83m0BAZfLkqlfDqzf4f2WaI7vROuSN1e?=
 =?us-ascii?Q?daeOFLuLrQLp3C8ZHGCuSkUKl57Ga8VmhVBigv1LnaLxwY7N0t9iAKEYmM2M?=
 =?us-ascii?Q?Hzk4JEjmoqLEcwUM/8j34ci1FoGntLpf5ooDZRAQ/vezfIEzzJNg7iHtRnlv?=
 =?us-ascii?Q?vkOWXDy8uFeiP0aFWN566I9MgP6GBu+/TOOjnhtPxw/Ra+0KwcmKPkLWfXw3?=
 =?us-ascii?Q?iX7s+i/t1qRUnHmPWHmlxeq93gnu4Aj3BVGvBfuhz5qUZ2KhkimGCU0V4eEw?=
 =?us-ascii?Q?nbiuVggVXnZpYdPpzcltAoJHidKK/sc4NtRUPFTSx7jyBFJZI7Uh3Zy2pm/Q?=
 =?us-ascii?Q?6rxuTt3oZvZwAllDQ1XBj/4shsjRhE5MDQCr+MUHUpeID6amDypdOmE9TzXp?=
 =?us-ascii?Q?48y117eo0DMipeiJw6EwR9k2EdVGG2HUicRz4dwRL2y9JeF4QN+x7DKw2hmC?=
 =?us-ascii?Q?IbScZaLbJm2jY3laUuO4eye+aoGfczaIZVekT3ibJqsQbu6lt1LEY3FQIEoV?=
 =?us-ascii?Q?0dyjXb77nKI7CWRJkhKQc06mGuLYSZSauvgSXTRUopBlGDzhnPnGisCZ6+Y0?=
 =?us-ascii?Q?gkOJijp7vnfZcx0nvZLkLL76efh6TmA47s47y9KGd58b6f35Pkn49lw9mOkw?=
 =?us-ascii?Q?oGxSMIT7hEoMyKi1PEaYFfhzs6GLuOxkMmz0CeO3xvhp8bKkn1q4VpeBBNks?=
 =?us-ascii?Q?1s9vY6GhvnJR2JCs54Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fc7f2f-e2e6-4749-6b57-08dbad5f35f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 15:54:24.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD7nIzxrcap3W5EW6mZipOJD8Prd3Ikwcs3zxpTROtR08bn3cyxyTE5x7DWgYQxHctw9LuJ+LF5KvWqfvcty1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal asad.kamal@amd.com

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, September 4, 2023 6:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Restrict bootloader wait to SMUv13.0.6

Restrict the wait for boot loader steady state only to SMUv13.0.6. For olde=
r SOCs, ASIC init has a longer wait period and that takes care.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index d2a88bc630d2..469eed084976 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -160,9 +160,6 @@ static int psp_v13_0_wait_for_bootloader(struct psp_con=
text *psp)
        struct amdgpu_device *adev =3D psp->adev;
        int retry_loop, ret;

-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
-               psp_v13_0_wait_for_vmbx_ready(psp);
-
        /* Wait for bootloader to signify that it is ready having bit 31 of
         * C2PMSG_35 set to 1. All other bits are expected to be cleared.
         * If there is an error in processing command, bits[7:0] will be se=
t.
@@ -180,6 +177,19 @@ static int psp_v13_0_wait_for_bootloader(struct psp_co=
ntext *psp)
        return ret;
 }

+static int psp_v13_0_wait_for_bootloader_steady_state(struct
+psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6)) {
+               psp_v13_0_wait_for_vmbx_ready(psp);
+
+               return psp_v13_0_wait_for_bootloader(psp);
+       }
+
+       return 0;
+}
+
 static int psp_v13_0_bootloader_load_component(struct psp_context      *ps=
p,
                                               struct psp_bin_desc      *bi=
n_desc,
                                               enum psp_bootloader_cmd  bl_=
cmd) @@ -737,7 +747,7 @@ static int psp_v13_0_fatal_error_recovery_quirk(st=
ruct psp_context *psp)

 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
-       .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader,
+       .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_state=
,
        .bootloader_load_kdb =3D psp_v13_0_bootloader_load_kdb,
        .bootloader_load_spl =3D psp_v13_0_bootloader_load_spl,
        .bootloader_load_sysdrv =3D psp_v13_0_bootloader_load_sysdrv,
--
2.25.1


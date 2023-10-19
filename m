Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D1CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 03:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449DF10E095;
	Thu, 19 Oct 2023 03:05:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15A210E095
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 03:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtONebcfFbAr+yploUyurkL7wktBJYJ8KuhYP5gXJXFe4S3TpngQyUKS87xLmS3h7qhh3x2yZAacv0QNpWjJWK4XC0iDS8L5Dn+c+8idlEw2D8iZo2w2tyfPWy1LL4ZSx48YjKtsp2Jc3QvmgQMs9AdyiHAWZPsnWBltAppkXWzB5tp3yCfPd0a6Md8tJtuxW7IpISMpuuAyiVrRCFpGRYFhVkdVmDd6LzE9dqRmQOlnC2/z0pFnRTgSzl7VlHDtQgb8gJkTkBBexGkuGmOu7B73N86DFmK2XQnBs2NyIVt3P3VUgGf3yEDwPM/W7Fd02lRDAFC+kzvIzhYLrWxt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYLBYuasimsIIqeOP9KAwSaOLqbFb311spiRN3z/zdI=;
 b=KOaeUioJ0+P580oa5VatW80UwBE+Pdgwicv5IESEOuIe4TxgYaZUgCBECd1V0IfjnIH7bMebWmIJOsrk4ukwIMSo6oRih7+xwy+7KnJrObtscTnp6JJuo/4gZ+L/ShyxeWoSUUowJgT0OVmoHClJFPmLFjYyhysSGKxj+myzt9Q9cfcrQPBPjPAc6YPpedZ/eYmvCZsjgC/yb63kqEsUjToCZ2I3OWcQvo4tLWlZ/TuwcNu3UgedoCH5S+3APCLD2/F15WVe9Rw5T8hkkrqcbi9tmnP11aY0iOm98dcYJhvBeQw8EHnfaZQeDEEK5T7Ed25G8Ws10yuzAalWyNIrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYLBYuasimsIIqeOP9KAwSaOLqbFb311spiRN3z/zdI=;
 b=TUS9VKMdqoItbrsurPm1OCal9e8O1Xvsun03Pj4aDph11YLLhzaAxveUoXaO3sXINXNTNQ34cY7JWzp3L2eZiH78EPGEifMBCdc49IPAueVcFA3X74vz3wumATx6xKHGQ+KOrmaM1j81noJRS+lxm/cLdwjtZ5bJXMU/SC+njfE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 03:05:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 03:05:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Log UE corrected by replay as correctable
 error
Thread-Topic: [PATCH] drm/amdgpu: Log UE corrected by replay as correctable
 error
Thread-Index: AQHaAi23KCiObvGXgE+TWB8Fguo85bBQbc9Q
Date: Thu, 19 Oct 2023 03:05:36 +0000
Message-ID: <BN9PR12MB52570B449552A0684A084913FCD4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231019014318.4188092-1-candice.li@amd.com>
In-Reply-To: <20231019014318.4188092-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c496e4ae-185a-45d5-af76-49e2cded37f5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T03:05:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 51ae1191-2d25-48da-e16a-08dbd0504498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21VXsmwYlOEZ+DlDA920LYFFpnPP5FAwdFnFTy1bDXCH6oTzTJBrJZfTdk/M0JLJnwn6ksl4ouZU+Hemba2MUilBBUjBToF1bqa6Lvd4prgQc7RY1dum6xbPZH+dwjUxnBLdp6GC7rpetTxz/kLgOlzPqPyslbaSMm//h2cwo/Xr589Y/oKOTrwdkAeEhVboGqCSLWP4/Zgz1KOK6upYKcNJl71GnUnXZyZwcsGreBIHmFG4PwGBH7nY9FJ52VLw6IjySJUBDj8Y/KOJJ6rrk19kjS0Aj0EDCjwCtuVAOpsjkGBE94FDByeqtgccHmhw2+Urpkrpfs9bbiaIy90daNqtApCz2ufPLE4vNfrOV83SkqucIsJPAOpQtqzHGsOfnJX2lOgo6o1neEdaOPM3JZw3YKipD4mL1m0qVbubtaRVzeHXA/ESCh2yEA6Wy4BelhTxboIOOKhqcxrTJE+VHJhKA6p9chOcSCSLOsKa8BllR4b6uCaoJQmrk6Q9GbAJqzs4Rm0rjxD8Vi5UQltTFfKtN5NolGnl9Xs/wnTKOSXZS0LoxgMIj8vYRru0795GAPAoQ5EG7ftsfY1VEM/0ytSbZEZ22E/Iz0wMIbTE9PERqM0k4GSnmsQVP+N7l0kT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(110136005)(53546011)(55016003)(66446008)(38100700002)(122000001)(83380400001)(316002)(38070700005)(7696005)(6506007)(71200400001)(76116006)(64756008)(66556008)(33656002)(66476007)(54906003)(66946007)(478600001)(86362001)(41300700001)(9686003)(52536014)(4326008)(2906002)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVtk31ncNzvDZRz9bkULfAHnxocNPdroYnu4pDN3is4SeuJGCGy97dNco3f4?=
 =?us-ascii?Q?2v5kEN7e/CJ3MqrfWkkPrrxsti7dw9y9QqIcn/AFhQxcw4mj9RF1FA+kOgg1?=
 =?us-ascii?Q?3FphVZjGM8Q9I1SnM6gWFxRYu4ncfeP8RTUju154/CaMFJbwhilO4miZmDZP?=
 =?us-ascii?Q?34aW9EzvD/goZfKI3DnY/DCiar7PqvuaFJ7Ok/DS0sHRavMgvW+fOKwxbtaA?=
 =?us-ascii?Q?AQBVgFQzqw5tNAT3Qfq0STwAyOeieXgGr/neoVJ9IahLlD9tulpJ+vaZQKiZ?=
 =?us-ascii?Q?22st3ScYHs984usXLDQT8GXErrliHLXxOuEO78tBL98CDQTtvIAUa6M3rw7y?=
 =?us-ascii?Q?JwUFJKj+1CYgxfYf9j+HuhTsSKkLkd2jJrs+YxkiUDKcsA46lHY9hXHoc8ap?=
 =?us-ascii?Q?paP/cJ2fvnaigSTrjVOi1EBxBfoA0mnYuJcTE8drl/9UY7X+WAA5DyzjhAt6?=
 =?us-ascii?Q?XjGlZvN0ZzKzuxrFXUs+oKabjUkC5DJE9QrOQVA5GORVNiheDdb0AauGtaAQ?=
 =?us-ascii?Q?eJO+WEbE0ipc7jWdYx5q5uMehazZA+JCwhKQJ1IX/nY1aIW0a5MXpRjov584?=
 =?us-ascii?Q?lAteVIpFDFwgrP0Ejj614dg0ZDg8sATZTxEqkvxiSsLde0v1IPLnc+Y/XQZh?=
 =?us-ascii?Q?OgztAAnRqZ+MN5f0C6R0QLdzGc9DDukzqavYAauJPcmo1TNCsw7L96JoeQo4?=
 =?us-ascii?Q?mMHUGho1fkhnkZ8VbaRlcKlN49sJi/TnF3zN06MjG+E5akVVVvg81OrtKh4w?=
 =?us-ascii?Q?Sbz+L9xKCPcl0fxMZ1qbo0zTuJ+NFTivm+Ltg+m/RuFKr/Qv6BuYTrePl/YF?=
 =?us-ascii?Q?A3tM7q6bcfT3lGqk/95hBRvKgQf2e37TET6Yq56WhmCwNWOVL4lt8klKa1vU?=
 =?us-ascii?Q?3R7n0wRXWb+jcXaQ2eca1FLuAa6tAt6rwAfKKboRV4C5w7sf7eYcfKVXfHno?=
 =?us-ascii?Q?cGlZdE9hVPrcn/P4QHnPZHWm0tjiKoLgZlfUqXTx68/g6bTsg6VRWT8CVGxW?=
 =?us-ascii?Q?5DsiKzLxyXspqQkNCOgFmFn02VHB67/IxgVLO/8ZZudQEB7fmFZyuXemU5QA?=
 =?us-ascii?Q?vpczzvL2uU+lsDxjrZwBkxF/sKIqWPUjCzMiD0YYB5PmFWkKb6X3uXndDGe6?=
 =?us-ascii?Q?oQiRMzWMdUsjW5nKIa5ARlrn0wZpk0JwJQkS0iL32yfel/Tfb6yMqWFEMDN+?=
 =?us-ascii?Q?ksC0AlGhJkz51e9+9DUSr03s/zEpcBrz+2RIq3PvLWBT31g23W9y7eGb9zfw?=
 =?us-ascii?Q?BzMHGPAy2AbB/lS3hIRqSB8J1uABMGLq5GwFnxriIX8KESbAp4pY0xgC3KrI?=
 =?us-ascii?Q?Mr+mliei4EqJ2MNNz3CUvpg5LZj3o+13En2upYxuHeCEkw7HrUfd/BzIzySy?=
 =?us-ascii?Q?6TFuUwIsK1S3n27651N+rcSTK2/9s4G9KIkVpXeF2ZKEv67H2oNDOZq0CBnS?=
 =?us-ascii?Q?MwN4qxceuMXeWOg7tsFl/89dLwUXzww5lbjaZSQXrRPvmgfBXRijZLemJsTT?=
 =?us-ascii?Q?qzak96GRAThAZDAxzBkQIOdOdS+ulgIuFRaMew0rBJ1UEABlbfFWet8H0F52?=
 =?us-ascii?Q?+LHkduS1xnyjOKtA9I4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ae1191-2d25-48da-e16a-08dbd0504498
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 03:05:36.9825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZJ58Zo+LkojoKjK9P2muk8UX1FdQ6WkPS2mrfBGWhXQLelYIzRWelSPUVuAHDyi2a8ZCe7LUDTKDPBN3Ih3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, October 19, 2023 09:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Log UE corrected by replay as correctable erro=
r

Support replay mode where UE could be converted to CE.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index b664ee3ee92d8d..025e6aeb058d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -105,7 +105,9 @@ static void umc_v12_0_query_correctable_error_count(str=
uct amdgpu_device *adev,
                RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);

        if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC)=
 =3D=3D 1)
+           (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC=
) =3D=3D 1 ||
+           (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC=
) =3D=3D 1 &&
+           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =
=3D=3D
+0)))
                *error_count +=3D 1;
 }

@@ -125,7 +127,6 @@ static void umc_v12_0_query_uncorrectable_error_count(s=
truct amdgpu_device *adev

        if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val)=
 =3D=3D 1) &&
            (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Defe=
rred) =3D=3D 1 ||
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)=
 =3D=3D 1 ||
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =
=3D=3D 1 ||
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =
=3D=3D 1 ||
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =
=3D=3D 1)) @@ -293,7 +294,7 @@ static int umc_v12_0_query_error_address(str=
uct amdgpu_device *adev,
        /* calculate error address if ue error is detected */
        if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
            REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV=
) =3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)=
 =3D=3D 1) {
+           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =
=3D=3D
+1) {

                mc_umc_addrt0 =3D
                        SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDR=
T0);
--
2.25.1


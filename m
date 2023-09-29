Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DC8E732D0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 10:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C40C10E448;
	Fri, 29 Sep 2023 10:02:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD0C10E448
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 10:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4wDYfY6mEKZrEMdboOedzzLtuvff18VmgftfCbhoJDHPiqlw1TYKoWHELrOgGgUgFyUz3zUzjqH9Kz0lNYtHrEVxTCm/k4ld6VwisOxSAzCIrNG8dLBj6IRHKc7nLw8ePuF+4ExEUB+jEmEI+JoEh98rshENOnTejpaig1M6nY3ZmIe+VRWyVfNw6lKEET74PSUzDGWZ4MdHmyt/1wXeoJJYxIn6DxfFal8OZC61VikMp6JU9ZYcqoz9tm4dSTv6Zs1hsZpxilZ8WWijRfCq5ARHkPB7Jctl+UaLPCuIAaCdcNWFNgPFbdsuiWyuSmV9EU1jqfq0uu3htCXdi/u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T9YWKdcHqeqyQrjbQij+GamEEb9SuBEu2ZLwT938No=;
 b=ZYubxmy/FZblMBV4PJwgCxX7KCEQIKqrn0KRIbElQ1UeBRs/PhMGjwYNl2Rhp+LpxjGpKNmyNuLYXc275+/EK9gZOUjt9lYGpJdac/tA2+moQbGWWn6SFNg22d9+E6Lx7ny2gjUPtMr1Ki5ZuIG3txgIf4hmEKDvHxyk1FZCoPJiXHOgYm+xZDxqkPbksI8fmV4PM3q3CFDRyEfc6zUTS4wZpDG8X2MUPRC+JqVuDREApo42Kn5FCQ/ogoP83dtcxFn3nl4xD7Oh4E14EYfulmLgEb7jRnQg1X4VX/SNgD3m8/TbmNxuaiwG7nsIAvhhNiCE3sDLXAxLW7eZP4YbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T9YWKdcHqeqyQrjbQij+GamEEb9SuBEu2ZLwT938No=;
 b=U4Bb0GSXEkLyNuTFDfUc78RnMr8h1PBQeMOCnW62SwmEmGMGR+cltrJTdlv+oXCSLj9+JxGe8k91k7QqxnqdgBYU2ykNCTErc6W0o+vQXmUB8QlZvjeTgZmgqn0ZqFJqgkp3H2dvYw0a6fZfK2bmcGzKrYQLHKuU90W7Xmy7d+Y=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 10:02:12 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::deec:d168:a854:d27d]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::deec:d168:a854:d27d%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 10:02:12 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add throttle limit for SMU v13.0.6
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add throttle limit for SMU v13.0.6
Thread-Index: AQHZ667utDOTt0YmPE6BOGv8FHzSwLAxoFnQ
Date: Fri, 29 Sep 2023 10:02:12 +0000
Message-ID: <DS7PR12MB607168499D00FC3E0FBE883F8EC0A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230920104027.1295775-1-lijo.lazar@amd.com>
In-Reply-To: <20230920104027.1295775-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7b1f9789-d9ff-414f-af3d-2f5825f3e1e0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-29T10:01:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB6862:EE_
x-ms-office365-filtering-correlation-id: 80ed3b5c-966a-4ea2-9fd7-08dbc0d326fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1l2WDuLUXWkcPPqT7mEWYe/w9nBcQnXHa39Xw/XsoMZ765kOngeeWjMdRgRcz8yUtgneiQ5yOBRcE9j7hqb3llBbISJ3PN3iflhnXVdaUAs1W0eb4vYAGymAsHPD0oJHLJLjzY0S2hC8RfGdg4shLf/FvlgpnwSHDaZ9jGcCX99+KBoIQBxHJUgBk1uOMcSjBHn7B+wWIQSthEpImwDzHcki3EiAZXntM200S4/9OLOdcqvi/b/FR/8TKuSEUdHrOWLjTHEvYTZP5SO1Kw6e75Dv6igjozDAXMZX3bKzh3QK+EQFWbFbDhdwDbDsQJtM3anHasP28X+5x4tzeAkLa/uJFZ4GTVqc7ZooFOAR+qyDSlit/Bjeb0MRMEk4UQ2bxf+Nj2xyfrXK4ogNQF5fhVO3t0gh/ziIunEC8n1OWNE3z1cnpCDuAmIdHiEoA0IQDONxMipWIAYAbIvHyNEdnjb1DQNkYF5ULoUax0v7qqcinkatWIiQ8T+vdLHRdIslersgl+8rR4JVIiAEI1CQpfi4t2AdKAs4WT0Y4rXXV9m2IAxwzvcRk/NCtSRnC1dOPwTVF00Bdg4U8Vj6+BqMyO6RJERbjLlAv9d2nmL0i/owoj3lDL4nkVnJMHll89D/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(230922051799003)(1800799009)(451199024)(186009)(9686003)(55016003)(7696005)(6506007)(122000001)(53546011)(26005)(5660300002)(8936002)(4326008)(8676002)(52536014)(86362001)(33656002)(2906002)(66946007)(38100700002)(110136005)(54906003)(316002)(64756008)(66446008)(66476007)(76116006)(66556008)(71200400001)(508600001)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJy0A7fHH3F6AFiOkwoQS6gbRFKqfmJEFxPJS8CdzlsNdueUrAD2OPwUaWJK?=
 =?us-ascii?Q?H5eAzeKCMO6ysvNRJde9hW4UK195Jajiz+qiYS53tMc6cw/yw/hCQ2JCreuV?=
 =?us-ascii?Q?g3f65GTF7jUSX0BxBb7F8UYvrdimQZ67Xw2Be90GJ4E3MK59HqZZn44nhfHH?=
 =?us-ascii?Q?pqu0EyusDR7X7WQJLppBWRKqKQLLhGdCWG0dBYs1CvYSF2fMGS4D/ub7Yiug?=
 =?us-ascii?Q?/Ud2ShzL9Qb6xpEZwbacgUtaQKR/Rh56HpP7bff2gv3HyauTEFxvGexHvU4D?=
 =?us-ascii?Q?9quExvlnPs0KHJG87h91Q2pp5etEu0tFQM4zCG0YwtwdRzQ5GPgs8NMvvbfq?=
 =?us-ascii?Q?Ffslk2tBAEPkONEr+UYmLwGa3r1Yz03k0LydqP96oifMQro801JtywQhibQx?=
 =?us-ascii?Q?vC+1XB+jbYrXK91zIhy+cyIJba+qfXASy7cVIHYVdgjj9G/5d5c6D1Havq5f?=
 =?us-ascii?Q?enZtN3oR0FarcdIoG2obIsD/TQUJ5LKByfIpgaeWwZ+5PbCIHws8uPaRcbAT?=
 =?us-ascii?Q?hkYygKMzuiBGG3tGHCm+4MyIaVQcwFi5U7oBuFgS9I1gh0KiZy+tIZL9gR4u?=
 =?us-ascii?Q?SbZlbk6XmimGWqen3nAom89ZgyLBgo2BY5C0bNgegvqR/Ipyvy8rYVrFmZff?=
 =?us-ascii?Q?sfy8Owe8RoN8BQCV6Fvb/lyAA8NHZyTwnhGqM+Trr9jc5KPRCt5SPTVX4xE9?=
 =?us-ascii?Q?K+SEor0OenvYW33/BdPJewAy8o4bJlvl8GhxjufXMNKYmkxGH9bZtGBcwo7I?=
 =?us-ascii?Q?1GJ15hz8l1hKpsVj/alG7T8N7Nd05PyiM7r940YyYtMkKFeUa6LjPYiabLuA?=
 =?us-ascii?Q?l6zpeNH9STv2dkJuC6ZinR8W11knNwOehXsMU9EJEx9kWAkyDO0VNG3FsZei?=
 =?us-ascii?Q?aRQUELukZ+V2gRef9q0WBUSJlNxuYB2yj/HyufRKBbLsIO1+7/iPkUP/aLhK?=
 =?us-ascii?Q?Q5NW47n90REW2X7Zol3KokCmwg96K+OVwjMwqQ28dhKk/Ec4oZKULwcXqB1E?=
 =?us-ascii?Q?ogPoYhTh+Qg+wOS0no8kHBmdueMYD6/PRm1iglBHKhG2JbY2VZgUkd3+syJj?=
 =?us-ascii?Q?zYL9yrc2eJB6W7WTR5CWF1VCffSwjwzQvFxGOSXT7cm/LYdHhBjJsrNeskUG?=
 =?us-ascii?Q?ZvDoyqHzBs3Yf8vXnpI3CrUyx4j8BW+lf78t6ynpRTm2f7YXN1DynKyl6XhI?=
 =?us-ascii?Q?PUWueWY3RnESNiTkxzDXNLE3/4soVx0QApQLC4ya55IzqUQeuVuda2i4MN3O?=
 =?us-ascii?Q?ydb1FIX7/br35Kh18n+S4latYpNOL2Hvujvm6dCaPQEVetih2yqg5uG48xEO?=
 =?us-ascii?Q?2/24vWufzqh/lorhg/1GpCEPkWtHX6qJHMCp7tL/i858tDPdRF2UhZn4n0Ck?=
 =?us-ascii?Q?kh8fRQ44FlQQded/tHfC7K1qyNdFiRftBQVanhuRkUdY5op44yvxOBGgi6HL?=
 =?us-ascii?Q?1+dbyKmpxNtl2dwEdHtyR6IjGUD4+v43vC2FAIILI+yurqgQYfXAUOYKZrcW?=
 =?us-ascii?Q?hUuq61sHo3mw35jnw6d78kEfbzB3gcJLPF3tZFg6uuDZYYeXEXDw+Bh8DxR3?=
 =?us-ascii?Q?9A5KYL1vbNzYwrUfKz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ed3b5c-966a-4ea2-9fd7-08dbc0d326fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 10:02:12.7553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vht6f4N5OD6pbwmqRXZ4309bx/aZooXujbiEc5SU0gY+eOYdzwhKCM7f8aC2VEBwG+gjzEv7HXv+EKLoUjC3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, September 20, 2023 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add throttle limit for SMU v13.0.6

CTF limit represents the max operating temperature and thermal limit gives =
the limit at which throttling starts. Add support for both limits.
SOC and HBM may have different limit values.*_emergency_max gives  max oper=
ating temperature and *_crit_max value represents throttle limit.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..73db595bf6d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -165,6 +165,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGf=
xClk,                0),
        MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDr=
iverUnload,          0),
        MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,=
                     0),
+       MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottle=
rLimit,              0),
        MSG_MAP(ClearMcaOnRead,                      PPSMC_MSG_ClearMcaOnRe=
ad,                  0),
        MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMc=
aCount,              0),
        MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMc=
aCeCount,            0),
@@ -2110,7 +2111,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                                                     struct smu_temperature=
_range *range)  {
        struct amdgpu_device *adev =3D smu->adev;
-       u32 aid_temp, xcd_temp, mem_temp;
+       u32 aid_temp, xcd_temp, max_temp;
        uint32_t smu_version;
        u32 ccd_temp =3D 0;
        int ret;
@@ -2126,31 +2127,50 @@ static int smu_v13_0_6_get_thermal_temperature_rang=
e(struct smu_context *smu,
        if (smu_version < 0x554500)
                return 0;

+       /* Get SOC Max operating temperature */
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
                                              PPSMC_AID_THM_TYPE, &aid_temp=
);
        if (ret)
                goto failed;
-
        if (adev->flags & AMD_IS_APU) {
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTF=
Limit,
                                                      PPSMC_CCD_THM_TYPE, &=
ccd_temp);
                if (ret)
                        goto failed;
        }
-
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
                                              PPSMC_XCD_THM_TYPE, &xcd_temp=
);
        if (ret)
                goto failed;
-
-       range->hotspot_crit_max =3D max3(aid_temp, xcd_temp, ccd_temp) *
+       range->hotspot_emergency_max =3D max3(aid_temp, xcd_temp, ccd_temp)=
 *
                                       SMU_TEMPERATURE_UNITS_PER_CENTIGRADE=
S;
+
+       /* Get HBM Max operating temperature */
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-                                             PPSMC_HBM_THM_TYPE, &mem_temp=
);
+                                             PPSMC_HBM_THM_TYPE, &max_temp=
);
        if (ret)
                goto failed;
+       range->mem_emergency_max =3D
+               max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+       /* Get SOC thermal throttle limit */
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimi=
t,
+                                             PPSMC_THROTTLING_LIMIT_TYPE_S=
OCKET,
+                                             &max_temp);
+       if (ret)
+               goto failed;
+       range->hotspot_crit_max =3D
+               max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
+       /* Get HBM thermal throttle limit */
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimi=
t,
+                                             PPSMC_THROTTLING_LIMIT_TYPE_H=
BM,
+                                             &max_temp);
+       if (ret)
+               goto failed;
+
+       range->mem_crit_max =3D max_temp *
+SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;

-       range->mem_crit_max =3D mem_temp * SMU_TEMPERATURE_UNITS_PER_CENTIG=
RADES;
 failed:
        return ret;
 }
--
2.25.1


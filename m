Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E1FC54E49
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 03:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F88510EA1D;
	Wed,  6 Mar 2024 03:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCUS/GBB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30F410EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 03:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdiWbei9WJNKKCpyGsj4H/RwHW8C+r4qpWJpBxYH4A0hLgVqOapmE5pSnAZ7y4BtoSzKHJ62OCukXj6njx9UPUFjl/d2m76zA0STtIfa3THr4+NSqHc1//4XakvotMoPLil8UauDfv6xN7VE8T8otzQLnRI89iyPNtqsD7PX6TXnH31gaL9mGYo8u7WUSdHq785x+irnaZXXkusjP8P0jlZdiEf8RIp+D/Qd9gtbTwXweD0XZK+th8m5M3W2gIudGJa6lZFlyDgqd52314Ck8x5Igi6VoWxCu4ELKVNc77+lD7gW/IHOKkoc6ZTjHg0wJW0IQUH4sFUiOJwwnjlOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dIx2YicHyCSD6RUlKduXOuvmz/VEompd8oXqlI4gnU=;
 b=LrPLS+tOEmOIx6cYZr9Pkkcpm3AMWOjmhdHO4LpJPmkEHSgL4rx0VKhi429YB+buEIPmiqiOhjUFbt97oxipcXIsEtLxFDOulOq//FwseKqB3B8HXZXkyu3r2vKfFdT8PRHfWcEeQAaQTl+rXx3WLBqUGHWP7fA34ZDZcKRnCczYOV+JwJ/0GfxsoZsjOPN+fseSrtufR79YpNR45hJH7DqorD15ECwCizLF/g13zir0QEKu0JUnIk4kkXWpFxuWJNmjGZ4LvGOxB1sBAOFlBYf+BDm2b2zMkDEIr/n1qZnjpvjcP2tt2olODjSr5OJ5qZ3l9Ho/D1uXJQeduzQlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dIx2YicHyCSD6RUlKduXOuvmz/VEompd8oXqlI4gnU=;
 b=NCUS/GBBiXdaZfSc+fGjqZVkaY+eXtVGnbCA9lqFwiHm4yOoH6lACDFjsRwxW380yFeOZcBke+Bvo1jk4+k0EHgodLCILKw2V8Ljb+6ELVHMkcbsWoHKxWpu/LFYodqFF1bbMtld1Uz5i5IUtJtl/V9cI0vyhR4NOAPRyEQLq3U=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 03:25:53 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::2a98:ab5d:ad21:8b19%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 03:25:53 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support
Thread-Topic: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support
Thread-Index: AQHabxFMJE7KijbCHEuHR4ljPtdh6rEqCROAgAADgZA=
Date: Wed, 6 Mar 2024 03:25:53 +0000
Message-ID: <CY5PR12MB636912BC3327485F54B8A301C1212@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240305152446.1268829-1-alexander.deucher@amd.com>
 <PH7PR12MB59975AA2DFDF97410C91CB9682212@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59975AA2DFDF97410C91CB9682212@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4feeb0b9-3cea-4509-8014-c5be18aa0a65;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-06T03:07:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ0PR12MB8166:EE_
x-ms-office365-filtering-correlation-id: 44d5894f-ffcd-4379-aea5-08dc3d8d20e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1BbW84E5SeeUVu20WuyyqIEOICipJ+ftkSnFnNMm9PhYXUvS5rZmxwQmuVL/eKQvSyTUCHZXyqFcNkQyQUFrTUdXMWiFndeGuDLzVOd9MXzB1g7Z0GU8Yl8ChuqJ8PC3kLKh0LiYyTNyyu5+BYkfAVRPkcZGQo/APhXJeg1ObkMpt3G8fAOrIkigd9LjyBVyd7izROEGuKk0PI4Mje9gsu1Ryx7rbu6tCJTatcaRiYm1rY+3sXQ9UBi4lU76kaRvt5WyB8hG2k7saCejPARBJDub9XZJNAmZ8nynFluxMNBjJOVJYMkBx5u5xTwWxZcAjLWqLWeadEYVDHbBqlMdgs3lwhBWqSHJ/eDCXph1FGUBnel/obaqpJ0u0P7ziRe9qrHVmS4fKPuwhu+1jrouh6sECxsLOKZ/mEQkEXAxtzwwSowc8mj+QO8QpsvbmsysYcsrCbm7kfDs4OLNtkvWsgoIk+HTX3lf1DWwwt2s0OFZu5zssvzBGsZmLCzryQ3DrmatBfsM/iBfW0gL5Tq1l11NITFxp2MKHDQ1ywMNx8bM1SeuRxpOOLpl4QkudNA/W+5IvG39w1lf6ByAjSYDRo7R2fqVaIVaRtlnrb3qW2HsY8f9us9lhIRr5jeJQ/hdatrHkgfFaHIBwvtvNpbp5C9MjXJvlGnuyvN9+eE5OrDs+D4UYAfDIrQNT2LMG8djXTAuFRdlzg73a2Q+4g29g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K0ppJ3C4azcHXLfGhB2w7Nw0CHfjNK0CnuRdRPfbfCWfIZn88tehoTOe9kjZ?=
 =?us-ascii?Q?jB0AthwyR67gfa2gbiePDmHW2QLqeLxgLKL+glujwsmqaKHZVpkDTc8UBB4H?=
 =?us-ascii?Q?0WnzeFNXWtx4/dNWK16FuhU5uCg3WDVJJtrpJN/vQAsG5kl84VXyAWnxoBSZ?=
 =?us-ascii?Q?eAmBcUeywDXsq0AabI9cIOgNdwe42lTBDMtHPTaieb0bBGfeGMyyUSSmEv+K?=
 =?us-ascii?Q?fM67gxpQeumA/W5CZkZzS6U9LOEoaLAyYmrUJ/2pSfi9lM1J79F6r1l8ULF7?=
 =?us-ascii?Q?gEZzQ0ti+EI1ctGKpnbZWMQCmLcmTgUBrXuRuVhdZO1V7rYW9IkZpcr876eB?=
 =?us-ascii?Q?yNNhXCkFYd2tfyTiwWWOOl1ybAN87HS5qDJPk4bhcUXew0nhsxXbshK7QH0K?=
 =?us-ascii?Q?QyjqKhdSwIyUCjucVDFIPh21uUqa9h8dPc+w9ylfLqkJ7OlMxgl0KvukB4qo?=
 =?us-ascii?Q?4iwqAWfaDz3Cmfn5fv3z0ccCTdSkwmMcZzhWqea4/87bsuJtVaIbj9RdDwP/?=
 =?us-ascii?Q?QjSDdyPnViODdbAopw1y4Jo2sXJ6Z5KaNePux9d30UZNbi6tNwBwJWH3agI9?=
 =?us-ascii?Q?RhFsxsXSkkPsqA4pS52c5fcgrBASr70z6tZtjpQtAVyEN5WkZRo/5OfCWsns?=
 =?us-ascii?Q?zpDAbf51/XQnNVc/inqrtVY3iYswINvApFrHh4YQ21oy/rndpE8LVEL0CEUh?=
 =?us-ascii?Q?o1tmGu9m4M1WP6au+aLl/fNdB6dC0dOeT2OtuyKSWEZRFomb6cCSc8lNnO//?=
 =?us-ascii?Q?pmV1LNRLiRidP9MUm0lmWWJP457J3WOSjaUuUgB1UjGiCxfe5QP5XiB5Asyq?=
 =?us-ascii?Q?UFs8i7NdAHxK5vV5b+T0xrF5v9cVMyfpPTkUpngdyJU+8LOG3pO2/0psnF19?=
 =?us-ascii?Q?ImFHZ07TdhP5+QycS3m9WsvPM7gOP8SWh6EWWSoEJfptEIA6qhB9HJwgWyjW?=
 =?us-ascii?Q?aaPqFTaTgyOUPtF57Atmwvg8nGI8iIZHY9TpU73lTcScZgxbL8eBRkFJPl1g?=
 =?us-ascii?Q?jR0FNwg5grhYHCWBrJXinRdYR9Fy9zdZQ6TjkuORoXigmwWqZJqhCDocgzsN?=
 =?us-ascii?Q?rvQTusxHpsSaRZvt6+1QtCwHr8e/xLrwHALdJ4Jwpq8to3hpGNre4TpQ3Dkb?=
 =?us-ascii?Q?AwjGFQre4tm0X8SCCefHYZTUHV8nEWyNPW1kZXsZ2OlXlhSVX78+RbKItDkW?=
 =?us-ascii?Q?1LNwnY2KimchNf/kiUqFJsA+cnM6MNN7fOItKaoCP+0h/O3l16kw1R0FDTzz?=
 =?us-ascii?Q?CCX+pVdFGFh6xoPwSIZk2/XVnA+Sj9g4Z8q/GSYDtoaJEDWNqV+oq2VlpN5L?=
 =?us-ascii?Q?w7sQqfw2QmCAWpcKCBzKg9h2gHLUUTTzOdbuS2DpUE1XjCiBwvt078D/cUe0?=
 =?us-ascii?Q?kmApFIy+MysVnCmkJzYEFxJuvwpn4aoN7yMqFJMYzlgGAAsR0T8LMe/+myhE?=
 =?us-ascii?Q?U/xvTaaNXZK3j4Qm6q8X9utOPGOTjuQTu+ez2B9TZEWO1K9Kaw2b/BlC4MhI?=
 =?us-ascii?Q?s0eQTJxWcBnr1vsZEWZgkNJECLDImADZ9OfJpoR+L8+r+6eHcWBKd/NyrrYl?=
 =?us-ascii?Q?ESIE5IK4LETMNAvFQrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d5894f-ffcd-4379-aea5-08dc3d8d20e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:25:53.1256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XJdDA/Zlyxocs6ZEjokwA8iuwef6C5KdAMh/7eCh7Uz2ECG4yj8LiPEVyaZse9+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

[AMD Official Use Only - General]

I think it is intentional re-use of smu 14.0.0 interface and will be update=
d later.

Best Regards,
Yifan

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, March 6, 2024 11:09 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, March 5, 2024 11:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add smu 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index eedb9a4f7e2d6..246b211b1e85f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -712,6 +712,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
                smu_v13_0_7_set_ppt_funcs(smu);
                break;
        case IP_VERSION(14, 0, 0):
+       case IP_VERSION(14, 0, 1):
                smu_v14_0_0_set_ppt_funcs(smu);
                break;
        default:
@@ -1895,6 +1896,7 @@ static int smu_disable_dpms(struct smu_context *smu)
                case IP_VERSION(13, 0, 4):
                case IP_VERSION(13, 0, 11):
                case IP_VERSION(14, 0, 0):
+               case IP_VERSION(14, 0, 1):
                        return 0;
                default:
                        break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7ac9bc0df8fd7..a65c618c2f98e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -231,6 +231,10 @@ int smu_v14_0_check_fw_version(struct smu_context *smu=
)
        case IP_VERSION(14, 0, 0):
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_0;
                break;
+       case IP_VERSION(14, 0, 1):
+               smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_0;
+               break;
[kevin]:

There is a typo or share the same version with 14.0.0 ?

Best Regards,
Kevin
+
        default:
                dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
                        amdgpu_ip_version(adev, MP1_HWIP, 0)); @@ -734,6 +7=
38,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
        case IP_VERSION(14, 0, 0):
+       case IP_VERSION(14, 0, 1):
                if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                        return 0;
                if (enable)
--
2.44.0



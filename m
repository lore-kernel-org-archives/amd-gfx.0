Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17602C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 17:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8471310E7F4;
	Mon, 13 Dec 2021 17:40:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDCB10E7F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 17:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flDxYWYZv/6fzmoqxpMnbwhL5ZvA8Chrm32APQB+C0dWTnrafRnEh0kamAMWV/MmMMt8u9+tCLNBJ1+RkVQPVxPkQk1RY56UPAUPVOb0G5eV6pzrulwf66CGdXpud158gWN96aEBEjwTrEbokMdl2bdm0Ki5PxDtHMA1/yJy39P+Q0sYScpbw/YsQ5mVnKTWy865izEyoa/sx1mhFpm915dGY7t8Ej6iWQt5PcBivKb112EHQdvYd9+9rKFvfD7LvQHNphspHeZ0+gSo8/dstlakxdaZdGEAPjy4gOaGhALavU6oOf+YQ/SCV7L8xS9XfKLh8Y4Zt60kXs+hZrzCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KImdzULGo2SvKgVK8MEVeLxIKAj1+7mAtX+yx+8mDcQ=;
 b=GvJh6/MWaS57EBIbsNZC9mVy1vgqThx1f1tG7+dM+uPzXgp7wcoJvgxIB4a47GOdnj4Ozc01PVExCC+1b7hJ/1IM7vmItVSUUjRqAsr7gZEx2L7vxXLrZvKcZFADKD3L9f62gWP9xfS2VpUoS6bMgwMoMS3wwJa6ooLD4ECUKXoG1Bkpyf0pkpZxZYYScXjiKg8yxqbUrVMzYp7WEBQafMLcY3R8vrwebSeORYrjUDjJCU8MvCYnh7OztlII6TJY/n1SK957P9SBZGlCyQ70nlz5KdbSENGX2/6JQU7NP74/QU4R7i27JEh6YhS6uDKN7k5ppmc+LooYmWcRxdn5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KImdzULGo2SvKgVK8MEVeLxIKAj1+7mAtX+yx+8mDcQ=;
 b=OjjOY8MPN9iro0dYRq/6whOFi5rbsgrVsDdwCM7lH7HQgtgkTXKAFNSYTUaBCm2w1d7AqA1E6S4SpKsizhizdT6Gnl9yjmpsL+cxNQFYpvduex5ziBNi/H+elsLi4X7IzXcps9H+CkCWbskHyzH05savtk3kqRn9ftIQqllYEyA=
Received: from DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 17:40:22 +0000
Received: from DM6PR12MB4042.namprd12.prod.outlook.com
 ([fe80::a9b7:8edd:2e1f:6b8]) by DM6PR12MB4042.namprd12.prod.outlook.com
 ([fe80::a9b7:8edd:2e1f:6b8%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 17:40:22 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX7ddrw41w8YLDxEGx3e6QHSDJw6wwtLbg
Date: Mon, 13 Dec 2021 17:40:22 +0000
Message-ID: <DM6PR12MB4042C81DE457BFDB7007995D8C749@DM6PR12MB4042.namprd12.prod.outlook.com>
References: <20211210150533.1509-1-Marina.Nikolic@amd.com>
In-Reply-To: <20211210150533.1509-1-Marina.Nikolic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T17:38:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cea1ef9c-85b1-40a7-9ea9-84f7a79096ba;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-13T17:40:20Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e2d2aa65-c2e3-4cd4-b911-7cac4993c379
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93dd2e83-8865-459f-9a8f-08d9be5fa396
x-ms-traffictypediagnostic: DM6PR12MB4299:EE_
x-microsoft-antispam-prvs: <DM6PR12MB42998ED3CA7B2AB6C8D5C9AF8C749@DM6PR12MB4299.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bgTlSiCpgJaW+t4W7UcAD7p9h1IR8aegGDDoWHPCBtTVfB4FqkOddHrRYfd9XvDMcagzdgu+8H+NcKFTFYTY4c6S5BF7z9bA/xF7so/c7RvKqix4C+vncv2V6/n+90xvpQav/SuaJmkkWkoi4386AihmqVvHbi6d/nT6xZp4sWsIc2HYUcAvps10Y76xFfSd7t41mF/0LUG4zJljwJgZSURfgSmZOy6pQQXYc1gs6h/OT76WshSY5zYwWZFwjwNf8SL8Kfyj39DlLkgWCcoMGGe9xm+RHOByHXWBV82i1aFQBj2UCPiJ4ZUwFAAQsRb5cudVYbKslRiOi03h0tGMv/6a2YGwKsJImEmyLZOhiTVprYdCZP9OqXo99fqxNcqBTSyWPw91XWwbfGHjLdyYWpyVAOEP77EE28rL/ockK6MLFAhmeE7dFb2oXOaYaZLH/k69kEfTGqsOeCNctz9zY7w5lD2e5Zhe+GLV9lzNb9p0oNtQEkVbf/+HVDfaUEQ/O7im5OK+BHQhGyHuSJ890xV6A7HruAyKlvfRZEJTFpdZF5GP4OhY9uIOld4W9TPuIHcAJViWDfU2nmREk49nnJLrt/VZCwrEhT56+LiF/egNhOSZdmoK1myNaORHoyz+3HXK//G8dxn/sAP7xz14haLU4BqgGa7aSOteu8JEwq09cq/W9mo9uGoSMxttg8Jlv6883CAORJKeq0COrmlvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4042.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(7696005)(64756008)(6506007)(26005)(83380400001)(66476007)(8936002)(66556008)(4326008)(33656002)(316002)(53546011)(8676002)(2906002)(66446008)(86362001)(186003)(9686003)(66946007)(52536014)(5660300002)(110136005)(38100700002)(55016003)(76116006)(122000001)(71200400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mp9esP8MviK4PX9jcCq62u8fgm4fryqU2gp9DWzw1By3UVEehg13rYYNaQ3W?=
 =?us-ascii?Q?EjbySfhdyUIGRUfcoPIv5htErn4gEeKxFY0+xQM3oMivnY/Xy6Un7jZEsrDL?=
 =?us-ascii?Q?qvHJ9ty5JpE9a/nacR2bJ0k8O7XJ2Ab+tzB/CB3fvWMZGYBgUN5TCpXrv7Mu?=
 =?us-ascii?Q?dAjrDTXK8h6P8Hk5hP073inZ0kaQsKyZzU0HqdsuuhdrNGtNXX3EgAooDk/A?=
 =?us-ascii?Q?AoG63UKc8U67nywqzMk+ChQdCbVSe9MsNH5PZBCRwjFtnmVDOB+zxazJv724?=
 =?us-ascii?Q?kSnZjMgT1F9HHcvRKHomVvLS/pF4ScIuBImEiKEbEh/FopQu01iNSvGqo9rG?=
 =?us-ascii?Q?NW1UVmGxFJ3aDt/od+veTC87FerJTtCp3f9eRO7ctxNohcznwLK3Jy5mV+ZM?=
 =?us-ascii?Q?NCu5/LkWMJjCZskQfZ7e09tZGBTTczWbhMbtoZ7BmL92OtHTLo+Vn28rx8Nl?=
 =?us-ascii?Q?3Uz26MmROe7WW9NcyRSvJPXGMnb/cVhOmxgzFGXaev1gCytUHmimpopP92L6?=
 =?us-ascii?Q?F6TFkdMC/2Us9T3q1WUcQhUqHGSQz02YM+0T5q9fCaQ2MeKzS9YC9G+LPNSr?=
 =?us-ascii?Q?xH8w4RS3RV38DWW62KuOxHIm/GinyDV53Z121fiA5g11hVyBzGqOV4mnQR9q?=
 =?us-ascii?Q?2M3QMoEhZzr0GDJr5cAD4V2VFVq6POfNpNL3gIpzlvB9miO+lZEzs5Ei935z?=
 =?us-ascii?Q?R28JW/P9QDelTpab6+PPyB2vVmSKm+jzboXWrjF38t9GorCka3ckeD98nO2J?=
 =?us-ascii?Q?nqFddl2dyrE0WnKq614OH+c2rNh4mkYhi2hUqVdd/dI5U9VweK/65ZIjHXdA?=
 =?us-ascii?Q?njfBGJFzmQl6BfSMESDF/wBLYo/a2c0CtdlR78iprbUiVOxupx19C66cMqXV?=
 =?us-ascii?Q?XFnZ+owZr72m246XWDS45kabPHJV5jj1VXmZ84keedZxnRA+plDaP33x3mY/?=
 =?us-ascii?Q?GHa01CDZxaD0anJ77JVfMR0FsMExIo8omdJwdlPsVd5j3m/f2wZAsMvwlUQe?=
 =?us-ascii?Q?7AmDXgiyVrgZ9E3EA4AGy37FmOYgd3W2Se2vhhzzDgDEYgH2Me09ryFbYC+Z?=
 =?us-ascii?Q?ADK8hmhNjT+crFPGkJw3SYrsWEiq3Rso19QNTvtnOqCP75jUHO9Zn/dktEaT?=
 =?us-ascii?Q?hXp45WroCS+Os5gLcDuB5lnAAyrENcZfHzRCX3sRyZQYlDTYLePW4Pl5JkrH?=
 =?us-ascii?Q?CAR7x1X7LHJhayfYQjONAY/Pp7EEBeqPLxpkcEnbkPgklf70MHVZn/a1h6Dn?=
 =?us-ascii?Q?97ft/PupSNIVcbvgZZnYT8KXTHWgN8N3FRFRBIKX++8+V8wA3h7ONTa9Jn4j?=
 =?us-ascii?Q?jl8riJu9vtoqL3rFkUfuzaHUagpgHiekgcuZN2yAHj8JEbjlEmxK9eWhV2xP?=
 =?us-ascii?Q?x6foEpp1flHDR+YlNrG2cZCOPdRIlYTdMcCqRDfYj9W2PgcdOQWLxbsXdSJa?=
 =?us-ascii?Q?UQHII7cUOgP3b41jDcFBe4wi710udgeEPqO3P36G7I2tziU5mktJi15I6Sj3?=
 =?us-ascii?Q?OCbkqPJYHvh9r8s0njKDUoGVH8oWipxH7jRTXEp7OCV2QLaoi2GrDSRnlAiN?=
 =?us-ascii?Q?xmtSEoFTT/GYY9lky1bX6V6q6VVh1fw0UZKrtE3dm/F8cS5Y1rfpCAQI08LD?=
 =?us-ascii?Q?207alQZJKYUeE4e7sd9O6eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4042.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dd2e83-8865-459f-9a8f-08d9be5fa396
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 17:40:22.4425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA4/zV91snw/yXMtc/odBm2evlZYBGPJAjc+KxNHRCisZT7m1Sc/sZFI0A3d/CDEIJ6pgfaNEm6eR/pjhjhkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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
Cc: "Nikolic, Marina" <Marina.Nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Some comment inline.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Marina N=
ikolic
Sent: Friday, December 10, 2021 10:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Nikolic, Marina <Marina.Nikolic@amd.com>
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read prem=
ission in ONEVF mode

=3D=3D Description =3D=3D
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanizm to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

=3D=3D Changes =3D=3D
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH=20

[HK]: It is not clear how you distinguish between ONEVF and PASSTHROUGH. Co=
uld you please elaborate?=20

use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

=3D=3D Test =3D=3D
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <marina.nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 082539c70fd4..0ccc23ee76a8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF)=
,
 	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,				ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),

[HK]: Wouldn't this macro try to create two sysfs entries with same name. T=
he second time the function would fail.=20

 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		break;
 	case SRIOV_VF_MODE_BARE_METAL:
 	default:
-		mask =3D ATTR_FLAG_MASK_ALL;
+		mask =3D ATTR_FLAG_BASIC;
 		break;
 	}
=20
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h
index a920515e2274..1a30d9c48d13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
 			     amdgpu_get_##_name, NULL,			\
 			     _flags, ##__VA_ARGS__)
=20
+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...)=
 	\
+        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),		\
+        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted, ##__VA_ARGS__)
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
--=20
2.20.1

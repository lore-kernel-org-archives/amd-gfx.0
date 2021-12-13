Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AC9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 14:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B171510E799;
	Mon, 13 Dec 2021 14:54:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D99110E799
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 14:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtycnyKCUu94QyPFLSrACP+NkiWAzhHR4PNidNotIf/rFVYXptnQii7wRUJnC9jo5rsIZQ+QKQqJMQkDFg0MTpEwJvrT5jPPAlbC2vbY5+k3xuPcjr1zIOyNQTV38k++a8OYvBU++RfGkjmKb71NitpEboolBm6s3PvRM7NcCr69RpiKZ+wiUSe3ZzRmpYOtr+DhKtTt/mb5X9ow7FHH5PaIlainG6pw+6OA09E7Wq9G8UGCvCW7EJewwWzD57TvbLmYz7nopRhvBj2yaY71ZtnAdYmuLPNZx/LHp+drGfUW4dlFWTUk+aTapYe6NwbAdaZdybXHIHnN7t42ot3JBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgs2HWG7F2fG+AQRRCvv2TIZun1B4omwjzVd0uM4K0E=;
 b=PcDt4sSM1em4pnQ+kEqdsOA9NEOZ21lYh+FrHGYj5c/6DdJahTVuW2y19vHRzWi3xG6pg7+cU7QYXTjfthw5NUDo2IkZiJkzmkgyF/JUsd70ZvM9aFOKlSLyNiXt++bC6BSgxRpcVVKcPGPULfVcDCNRov5kICdMBAgXsGoKaQsfOVGwtv4f47EgKqbXT4Q8O4sJI59OcKCiRpVlxiwyoOanirrTp4c2Jort/DLQmV8/lQn25DIQpAFvVVotQvuOcjVDfwtWOtimO22rx6x+gV+jk8OoE0ccMHeuRMCEyoDv0ILc4cyDWitYNJj1Con8vVzw3F/6xyvJCmVV4xc0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgs2HWG7F2fG+AQRRCvv2TIZun1B4omwjzVd0uM4K0E=;
 b=Y0yN4eY32kLEz+Ii6M7YfbpDrV/0uT/0U2o730zAHK+rhMMcM4zwixoy0xTaIl/SF4zR8dy1Zysqc5ChNZwtuuPKX4B09cHvu7RLyICmx/RziuMDEQX9Yz+lcyKY5GW5V1ElGX+rQMlgbaFwoebdTaXzElxoGLQ2PGC9XzHpXaw=
Received: from DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21)
 by DM6PR12MB3339.namprd12.prod.outlook.com (2603:10b6:5:119::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 14:54:47 +0000
Received: from DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49]) by DM6PR12MB4300.namprd12.prod.outlook.com
 ([fe80::5da2:b748:bed:9e49%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 14:54:47 +0000
From: "Nikolic, Marina" <Marina.Nikolic@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kitchen, 
 Greg" <Greg.Kitchen@amd.com>
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Thread-Index: AQHX7ddpeUjnKdMMFEuQ7xU45j9h0awwhvcN
Date: Mon, 13 Dec 2021 14:54:47 +0000
Message-ID: <DM6PR12MB4300372553C5C84716E4DFEB8E749@DM6PR12MB4300.namprd12.prod.outlook.com>
References: <20211210150533.1509-1-Marina.Nikolic@amd.com>
In-Reply-To: <20211210150533.1509-1-Marina.Nikolic@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T14:54:46.084Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4ae51a9e-94fb-d769-a9f9-2e14a25839b8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8da5bae6-882f-4aad-1a85-08d9be4881bc
x-ms-traffictypediagnostic: DM6PR12MB3339:EE_
x-microsoft-antispam-prvs: <DM6PR12MB333918C4EED1BC710C9E22B68E749@DM6PR12MB3339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jVeONLfmjjkfl8E3k2iCHKwl8MKYFRBzrCwEbZDbbpZYTAHbSf+rSi1Of5ivxSkOrDzqnvVzYJ8p/hgACrTu/tHYRfhOVW5A8/RGQO2+8PABkJlsVyuVtRojVkcSpQgm7YzYEdQydcGw0jD9bWlG9RjvzMVzkaIcs7QWk6gZh6QI1EQoQ9sTObkGRymlp9lcd6iv3NLBBG76KjBaoT60wZh4gZg3t4QOdMy9QHAbxheVZ44nnrYYk3aTIswyTsqLOlIykcP/DhCHV1kfBxDfu2O94YyR93Yvd5nrjJ8ZbyVcAtALW46L7QY5FPtlg5zQ57qQLVskIgM1uS1ldeGSyiOweY0pimURH/RXyRdkmVXD4oubX1pivYLwiAGYPg46CxUbM3w9YPwWv4VcLOrCrGddCLKOKbMBI0FArmZOsCxCIPcna7ldmk8oSpODGSWP/KlVbwfSWdE4xZRCDUznWZ3Pkgkxh6bQHX5xIgUTPWVWE40EQAI3sQ/yIQOjb1xIW4rx3yWAFW4YiA0Xp4YoyO30vL44zdkG5dzhR/dKo05DJiOdHgigbgRT/EZsqOWtOA8Y9sIMql5mZfpW7Qg4SzAPyAJsss6/x44lLzNEoEliIKvYLRobw5rmVLjQ4cRCdQwzHyyFnoUyRz16Gj9wk4mDNic+vkH60Av0n69gTnAgPvSlbr5UfKuFbJbbgnBgfFAB+qlAeDbwUmqHHVVqSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(19627405001)(55016003)(33656002)(8676002)(38100700002)(8936002)(508600001)(9686003)(5660300002)(122000001)(38070700005)(83380400001)(26005)(7696005)(186003)(64756008)(91956017)(66946007)(66556008)(76116006)(66446008)(66476007)(2906002)(110136005)(86362001)(71200400001)(52536014)(6636002)(6506007)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gK6GXv+qt39flF9Xxef1A1tJbQng1ccJZ5Hhz6yYnN+dzW3sI+0riIrmZDiK?=
 =?us-ascii?Q?VoxV2XtUe5eGuMjiuIaUrx9aaYMfmz19V0zBHMaRhJp/hopOHdEFPpl89NyJ?=
 =?us-ascii?Q?WZV31ga/HmTDr8JON8dc+IG0PgVLHXpTXd9PHPVlstdjAi1YUuoe3I4g1XIj?=
 =?us-ascii?Q?xf6NimXNTWnHh9uLDJy6ds1QKgK65cakgsY/QNnLoV3KlnmwPi2geaTEx0ZU?=
 =?us-ascii?Q?uizWOqsURdWkN+pmnb5KTpX+E4B1Ito2hSoxizaiD4DKV6LK6HtSCOUhzYcb?=
 =?us-ascii?Q?zsqh7MLuXoohSLtcs9DWxZFMT4PYI3nD6eP5ycJw+IpUc+iEyRtS8SCVJLuK?=
 =?us-ascii?Q?auI7rYXjVyLRCAl7erXLQTkRiJUn2cGn8hnEF07+ZKo2c4seKvgf+jHltDiy?=
 =?us-ascii?Q?7vA/dg6CGboxg9EDN/Wii4nImrWwkeKpgzRSL0v8fkfkXVIKqznHex4YwxcX?=
 =?us-ascii?Q?vqJ6ReH/G8oWVVpq9jCrxvO58tI4hRphQeVQ0tmie5xc8lXZPfRb8z3Pi8jU?=
 =?us-ascii?Q?wcFIfJAxshTiTQDOybwBjt2PSsCykgUswKmT605b4emicuPciFb14EvZE8cB?=
 =?us-ascii?Q?HKuXOM580OBDxlIJjWGqmo9kFteiTLiSINQYEwnnUVCXkqu/PeE/dbOCBkIc?=
 =?us-ascii?Q?vXGTefbplBSm4QwjmnuWnTlcs45uEeD61hy9Y0ql5yD1v+WTCwnryTXCNWGJ?=
 =?us-ascii?Q?UBN0031fmJLF0Mk1O7atciW6qBzdWllUJNtq2g/GIbLxONiZ/19Rw8DRdR5O?=
 =?us-ascii?Q?DtnLCTVL88w1nFVHD13qpBAs5FVSNAsYEQr1hNs5exW23AXDZwI2eNtsQAFV?=
 =?us-ascii?Q?sqRYNU9ywfKwdnAvyBCck/k/NhJRkRk7TgeH1lR3svF+tTGmHa3qduAFcSpb?=
 =?us-ascii?Q?2t0GHAScvSOJ+wNVG92dRDKPqTlXY76bmjCVQUKLacbbkbsD3hDo5DoEfWfE?=
 =?us-ascii?Q?Cnay8gq7ovhCtfRs2TI7sMkXMP3uh4qKRyK2KewEC1WVKTBeR2lRgOgPL2Ml?=
 =?us-ascii?Q?/KnasUm4VhxlpjEE9txhz19xIDmpqQ7cY7DD85lPo2H3aXW12L8KW/tS4mV1?=
 =?us-ascii?Q?UY54cirK+1M3/XbOvPBevCdoEGG5aG8eEYWYK6fpivHrbZnbFh4Ovqiuq36T?=
 =?us-ascii?Q?gMMYmuGSbZV+4l5TwdI5c1JedkWzOW8gWQdl9cmdCc5pwZwD5Pq3JytVD1Th?=
 =?us-ascii?Q?Uzsd4Be9amzcB7ceZUoF3wWT6gNcBBF+Ly6Iob38U77OTFt4pkODTVJrzpCk?=
 =?us-ascii?Q?hucRkYbvrxLEp6YLys7kUijdNxhhJqvaSlm6qCSLvAmicJ3tvoZ6CKp7b9e3?=
 =?us-ascii?Q?ZiNRh0b/ddd0KVqXFBz5IV4FHFblwOvZP01RDeklxcZbNJ3gkf7FUO2ytCnP?=
 =?us-ascii?Q?IBc15gwJmV6qpX3TQ0L8JCD/4F2iB+toOd2lRAG5usU1F4SvtG8a9erup9dO?=
 =?us-ascii?Q?mR9ObA5JuDvPKpSGfZrsKFMahnAWDh5hR1zheLmFzy6pX/MV8GLMRbQi1yz3?=
 =?us-ascii?Q?MlWUxbv+5NY9v8astVincRDtB1Try6feENtrIJr9c6qNjIH1SQH7CZ+j4B6L?=
 =?us-ascii?Q?d9nP9PuFQiNoiMePH0/WYgdwSiOW0miyZenOJymbIi0oRbIuW6Ngt3oNe7FA?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4300372553C5C84716E4DFEB8E749DM6PR12MB4300namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da5bae6-882f-4aad-1a85-08d9be4881bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 14:54:47.2365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U71f1dST7uDF5i+AkU4DYjDLdOJhLJuG+tlmWA4cNePsLp12kXhleqMnHabsIr0HlZrMMajUZKRGwjPEJ2jLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3339
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

--_000_DM6PR12MB4300372553C5C84716E4DFEB8E749DM6PR12MB4300namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

+Greg
________________________________
From: Marina Nikolic <Marina.Nikolic@amd.com>
Sent: Friday, December 10, 2021 4:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Nikolic, Marina <Marina.Nikolic@amd.com>; Nikolic, Marina <Marina.Nikol=
ic@amd.com>
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
ONEVF and PASSTHROUGH use case on sysfs level
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
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_table,                                 AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,                             ATT=
R_FLAG_BASIC, ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,                            AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,                              AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
                 break;
         case SRIOV_VF_MODE_BARE_METAL:
         default:
-               mask =3D ATTR_FLAG_MASK_ALL;
+               mask =3D ATTR_FLAG_BASIC;
                 break;
         }

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h
index a920515e2274..1a30d9c48d13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
                              amdgpu_get_##_name, NULL,                   \
                              _flags, ##__VA_ARGS__)

+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...)=
      \
+        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),         =
     \
+        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted, ##__VA_ARGS__)
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
--
2.20.1


--_000_DM6PR12MB4300372553C5C84716E4DFEB8E749DM6PR12MB4300namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
+Greg</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Marina Nikolic &lt;Ma=
rina.Nikolic@amd.com&gt;<br>
<b>Sent:</b> Friday, December 10, 2021 4:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Nikolic, Marina &lt;Marina.Nikolic@amd.com&gt;; Nikolic, Marina =
&lt;Marina.Nikolic@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only re=
ad premission in ONEVF mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">=3D=3D Description =3D=3D<br>
Due to security reasons setting through sysfs<br>
should only be allowed in passthrough mode.<br>
Options that are not mapped as SMU messages<br>
do not have any mechanizm to distinguish between<br>
passthorugh, onevf and mutivf usecase.<br>
A unified approach is needed.<br>
<br>
=3D=3D Changes =3D=3D<br>
This patch introduces a new mechanizm to distinguish<br>
ONEVF and PASSTHROUGH use case on sysfs level<br>
and prohibit setting (writting to sysfs).<br>
It also applies the new mechanizm on pp_dpm_sclk sysfs file.<br>
<br>
=3D=3D Test =3D=3D<br>
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.<br>
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:<br>
&quot;calling process does not have sufficient permission to execute a comm=
and&quot;.<br>
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.<br>
<br>
Signed-off-by: Marina Nikolic &lt;marina.nikolic@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp; | 4 ++--<b=
r>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++<br>
&nbsp;2 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 082539c70fd4..0ccc23ee76a8 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_t=
able,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_O=
NEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_mclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_socclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_d=
pm_fclk,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
@@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SRIOV_VF_MODE_BARE_ME=
TAL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mask =3D ATTR_FLAG_MASK_ALL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mask =3D ATTR_FLAG_BASIC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h<br>
index a920515e2274..1a30d9c48d13 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h<br>
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_##_name, NULL,&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; _flags, ##__VA_ARGS__)<br>
&nbsp;<br>
+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...)=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(_name, _f=
lags_full, ##__VA_ARGS__),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(_name, _f=
lags_restricted, ##__VA_ARGS__)<br>
+<br>
&nbsp;int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4300372553C5C84716E4DFEB8E749DM6PR12MB4300namp_--

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3A606A329
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=El/plRPT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB1E10E18F;
	Wed,  4 Nov 2026 14:18:00 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5E710E090
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 14:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8F9QqbbmpqcZDmeo41CsVqppwifrIRg1DdbBz2tTvkDis5jWGnoJg7FUc1BlKF+gCq4BO2vi6hZ5tCi1TNif/i6fNSN4OVb2q1/J+PH51bEs8lyTJqU/1xEqRakuzNVhpEhh9na6eAyalCntUrE3KYp4uMSxYoX/6XKkkQFAuUyUUiL+KKad27oxdqN9HU6PFwuo0yL1La3jrFna05pqvvWxAKiGZyQ9XdgHphEWlTYPGHpF7FVQ/2IK2Hq9CHD7CZ5ecIfJoAy/jAO2PomIyLqvytWMzs8BnWe/dUFCciRAOvR/gnFBkZJtYGsWBgQ8ihEQjG+eYT+FNjFIeetFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emiRqFxF782VUPMpVBZRa6S1h+0pZtLXOuW/Nu5E32M=;
 b=i1KsOIwwh8Xfox7bEFguDiNyVFyolcKhHa96SbrvX5qD8Q+fQF3MI3MZf60gDa2+FJxratEl3qIkTEQPVTnM5jwl6GcpO8VElRJiYe1TOaYDv8toxTFWAiqtTCHjt5zn5W/HRmtNHtF/cjoQMeQp+6RON2UYNcjrwtoCOhdYddnSQTCuPu76mVxlL3r8I0iyOFlJCRzq5BFDEUKqL7aKc/kj/uQNkb0rY6O9bdfjKcURRa4RGryCYa1chaurWmDTxV7yKQtRcRgRvpEkHZsGrqKQOaiNQ9T4XCQsNDDOxpM6na1gWe5TQnReK9jhS+lFpWkGix00b4HbhhtIxCKPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emiRqFxF782VUPMpVBZRa6S1h+0pZtLXOuW/Nu5E32M=;
 b=El/plRPTCRLunxC4ULGs+4f827TptqwSxXJuwoONl+i87ogXf5l+4UFPLkCJUTFeXAIuUUzQ19aUfYnxUit+qXbe+hNd3C43ij9WhTVkYxn7xF8luVxjso8qrwgouxdpv4j58Y+rYOHDGGGppR+uj642CzRoLK83ROUF6Ug9DXY=
Received: from BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 14:15:46 +0000
Received: from BN5PR12MB9464.namprd12.prod.outlook.com
 ([fe80::75c8:22c3:b9fe:2f78]) by BN5PR12MB9464.namprd12.prod.outlook.com
 ([fe80::75c8:22c3:b9fe:2f78%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:15:46 +0000
From: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: initialize the dbgext work before it can
 be cancelled
Thread-Topic: [PATCH] drm/amdgpu/mes: initialize the dbgext work before it can
 be cancelled
Thread-Index: AQHda24OQsNxoLY29UWBUrFcSjio97cd9IBz
Date: Wed, 4 Nov 2026 14:15:46 +0000
Message-ID: <BN5PR12MB9464FC1930C6C238383442F3F4682@BN5PR12MB9464.namprd12.prod.outlook.com>
References: <20261103083344.3056713-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261103083344.3056713-1-Jesse.Zhang@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T14:15:46.106Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN5PR12MB9464:EE_|CY5PR12MB6372:EE_
x-ms-office365-filtering-correlation-id: 4075431c-8736-43d0-73ee-08df3a7e1ed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|8096899003|38070700021|56012099006|11063799006|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|260925021911599003|260925021311599003|260925022911599003;
x-microsoft-antispam-message-info: RFd3V6dq+1mOz5j3ODXJ/giObEBSLrDDdlC+XD5xNBWYD22t4p2fRrzZ7WVZTXEpZ+fLemZLWDLZy2S9Le9kWDYySSNsLayD7OSP75wfUAcaUNPBm1ab5XYZ/DPhz2+cmFkr7BJsAJCqFfQ+6YFSlor6S9lEA4GUgk46i3TmEk+VjqhNdcPp/4gGzL41JhWTfrspm4gzatGlyAJG/HkDoxotmp4OkkppRs+lea3WfeE3pRj78xctEGjMlgjhnCxRMFnU6rklcAEVnf8Hh1hsdOej8nrSMDcNCkg2Hm7f6jaPUkx1S+6RB4C1J8F15Gj6WCHO0QVKCRA7eL16IHs6DdgZsHGcG6u90nD4NFirlVJZXne8qpGcWEb/1dxOkasGOGEhm11p28Ug01VvMqN2qboAYAMOpWiHabilHHfykvFtLNwKwh7IU0VoeNJQyEiGm0KF6auJE6QQRXEyIPGw35ug6Q59Afb5T5NKWIDhWw/nS7aJpf7aKWFuxsSeOGMy4J+EaGWcDcA8pFKMTHVTzhknwymmMZ2pXflqxx7SL+HuoezMshiFYcRnJw+HdHXDeOqD/2dhKO3O8rmfF6diXyBVa72T9PpJSMOLUpWxc18Za92H0cUj5qc7q3lZHEmz9gp55+o6FXOlc79r39hr4FXOeJxs+OMfP1YuFVMe3qgQnHJStgPQql/irxSxd+Lv/yljFidyh7FWZ7hNIJQ8CPT8npGUwEzDAMkmg2RkRqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN5PR12MB9464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(8096899003)(38070700021)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k6PVanLQ2BBGkfDVlTe2jrxOsM9TI0+VMLEo1PfSlsgHWb0JCvOmkaha82?=
 =?iso-8859-1?Q?+h+MmxfIz/GoxatKOQBVo8F7RN4rr9hQsUL1hhYxTzZ2XGklgV9Vv/4Vzc?=
 =?iso-8859-1?Q?n5Ln+JK4azqy7Z9Xnn5KX/Hx8CiMJ8I1aoJGp9pyyqOCOTfYqawRADSx5g?=
 =?iso-8859-1?Q?tjKXdI4kEBI7HqDaGd1T53OWWHOwdBfJ97smjMvx0HO6A3Uhygi+3WG9Mh?=
 =?iso-8859-1?Q?psxqhUCLllCI+fNfBjCPNVAVUO5Zp/CWXQFx7jOdVbSFG5OghNvNtAKgvv?=
 =?iso-8859-1?Q?kD1V/Sf4RmER62eClhU0ICP3rkzdohWwVcIxzMx/hwF2qOHKJKFyKagMKd?=
 =?iso-8859-1?Q?DcG7JIBbEfRccajK7dCriHl6ydQtzs6042bcXSAY+nCIldj6UoS7NHggv5?=
 =?iso-8859-1?Q?BcpTpy6JET+o+zcOkITGF8f0UAT39ZWy3eYufcCY0I/zIZ6WfBj4snXVZq?=
 =?iso-8859-1?Q?5TBMBgJMp8ZsP6M/IE3wsq1qJAxvYPolawPNT6SoNk2h4SWF3L/QuP5pBv?=
 =?iso-8859-1?Q?JOMgiZh5ZJ843IfTzxyXatxQce5yA5twbGoGXh17AelOSiLGzpyfZCeYvO?=
 =?iso-8859-1?Q?q9jUocFCL0oeLzdLraCzMaZjgPWnkJBNTFlGn/h28VzE8xT5WTXr0MfPXH?=
 =?iso-8859-1?Q?0bFvSIFbzpX9qNfaC59EzAQYXn/CopWbWrExF7R/F8R8xqmz9jZML7ARiw?=
 =?iso-8859-1?Q?+EDhdv6WCHmon1ItuudoTHfvFIgGuvxQRvyHcwhXSOegfk3TiRp+letYzY?=
 =?iso-8859-1?Q?W4Gdl29aNOfxH6lpE942wjlADUHkYSMzrJSyjT8jMVBaNtTJGYXUdLnsHD?=
 =?iso-8859-1?Q?KN5okx5sYRUussvWBZyRDUb1JrcKxQKWT8n6QQngA1ueZQU/1suHIRyqtO?=
 =?iso-8859-1?Q?Nn4WvtuA7jK4G5G7R3sEkCMPwvMBUtUgudGqJpwATCtognq+fERrKJ2MAm?=
 =?iso-8859-1?Q?My4oZ2jbLw9SzHzLoHpDfjyv8THM3ZpgNU6Qp1tq+EWWtOTmCyka1gn67i?=
 =?iso-8859-1?Q?uQIigADvTb+BpyuTCK8yi3mG3k0Qq6NqTg/wti8gjZNOQx6gGvGDFISLQI?=
 =?iso-8859-1?Q?owqxdMlm/nQVBSyd5lhBx3Vq56XuTkmqJ+m4T/87AbaP9io0CnPgcYrS7P?=
 =?iso-8859-1?Q?Zs6gKI+bFeU3GrkyolYtXCDqc9MoLefPGhv9wEQYUSsTvgzRejWWc/O48+?=
 =?iso-8859-1?Q?w5jPOs170YdxHcu/S8LxQ5NbDn4kKUnKd15NwlCVdy+tszlr9w6k4R6+MU?=
 =?iso-8859-1?Q?0Ir2swhYDPrhVxlP4TSimjFKA4HBF+nZQIvnq0pDLwRRCaloSgdkUd7v3D?=
 =?iso-8859-1?Q?tkwmjAz/wX/oWfBB3YGYKJaw7iZlqCFUwYsZ5wopVJW6MgzLdRjgFWDoT3?=
 =?iso-8859-1?Q?Nr5qosYGBYuco8bmwu6KX7JE5Hez20dC5MXg/rul2th4PeXUqOLt5UeyuY?=
 =?iso-8859-1?Q?rXzTX+9aFdu0VooALmUjync6FoQQLnVa2QlKU95vJNSGHBw+sPoDDB7+EZ?=
 =?iso-8859-1?Q?BIepNfdht6vp5gIf+NxcZNNKGDAs4Cn0nkZeHMYZRWwj1BBjfJJcF+HU1O?=
 =?iso-8859-1?Q?nzu/eqm2pNU0Pe0XpZ6HINcwJfNfYI2FbLhO4Yw+de6IVfMivimnNf1NxF?=
 =?iso-8859-1?Q?+637/Coe7c45NfNRnKgwKyXLbNmia+LfzA/YkilTjllB/zXFemc4BS3jxG?=
 =?iso-8859-1?Q?wwgaSyWPFQ0FcdRyCI0mKv6kiY6akz0fu5OI1xPX3l0lqZcGc9tf0f30D6?=
 =?iso-8859-1?Q?wVS1+nlFjMHdetefdWbrKGOw5D6FTwluxDvRZVY5RF9LKu?=
Content-Type: multipart/alternative;
 boundary="_000_BN5PR12MB9464FC1930C6C238383442F3F4682BN5PR12MB9464namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4075431c-8736-43d0-73ee-08df3a7e1ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 14:15:46.7045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWpWRz6AEPEwfTMZC/+wXLPUjW+NGu0dOpNGrjgh/6JqiKbbw0kIfPDlyhTUTkhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_BN5PR12MB9464FC1930C6C238383442F3F4682BN5PR12MB9464namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Thanks for the fix.

Reviewed-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

________________________________
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Tuesday, November 03, 2026 3:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.com>; Liu, Shaoyun=
 <Shaoyun.Liu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: initialize the dbgext work before it can b=
e cancelled

The dbgext work is only initialized when the debug extension starts,
but stopping it cancels the work unconditionally, and every MES suspend
stops it. With the extension off, which is the default, each GPU reset,
suspend or disable through debugfs then cancels a work without a
function:

  WARNING: kernel/workqueue.c:4335 at __flush_work+0xa6d/0xd10, CPU#1: kwor=
ker/u64:4/406
  Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
   cancel_work_sync+0x8d/0xa0
   amdgpu_mes_dbgext_stop_locked+0x197/0x420 [amdgpu]
   amdgpu_mes_dbgext_stop+0x2d/0x40 [amdgpu]
   mes_v12_0_suspend+0x35/0x50 [amdgpu]
   amdgpu_device_pre_asic_reset+0x403/0x8d0 [amdgpu]

Initialize the work once in amdgpu_mes_init(). On navi48 three GPU
resets through amdgpu_gpu_recover and the mes-dbgext-wakes-gpu IGT no
longer warn, and resets with the extension enabled still work.

Fixes: 9dc106cb56d7 ("drm/amdgpu: add mes_dbgext core support")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 0409325017a2..2da4bb1994c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -109,6 +109,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
 }

 static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct =
*work);
+static void amdgpu_mes_dbgext_work_fn(struct work_struct *work);

 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
@@ -129,6 +130,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
         mutex_init(&adev->mes.dbgext_lock);
         mutex_init(&adev->mes.dbgext_drain_lock);
         spin_lock_init(&adev->mes.dbgext_notify_lock);
+       /* stopping the debug extension cancels it, even if it never starte=
d */
+       INIT_WORK(&adev->mes.dbgext_work, amdgpu_mes_dbgext_work_fn);

         for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++)
                 spin_lock_init(&adev->mes.ring_lock[i]);
@@ -1765,7 +1768,6 @@ static int amdgpu_mes_dbgext_start_locked(struct amdg=
pu_device *adev)
                         return r;
                 }
                 mes->dbgext_log_size =3D size;
-               INIT_WORK(&mes->dbgext_work, amdgpu_mes_dbgext_work_fn);
         } else {
                 /*
                  * Resume: the log buffer is kept allocated across a suspe=
nd/
--
2.50.1


--_000_BN5PR12MB9464FC1930C6C238383442F3F4682BN5PR12MB9464namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks for the fix.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Yongqiang Sun &lt;Yongqiang.Sun@amd.com&gt;</div>
<div><span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; fon=
t-size: 12pt; color: rgb(0, 0, 0);"></span><span style=3D"font-family: Cali=
bri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><=
br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 03, 2026 3:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Sun, Yongqiang &lt;Yongqiang.Sun@=
amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Zhang, Jesse(Jie) &l=
t;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: initialize the dbgext work before i=
t can be cancelled
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The dbgext work is only initialized when th=
e debug extension starts,<br>
but stopping it cancels the work unconditionally, and every MES suspend<br>
stops it. With the extension off, which is the default, each GPU reset,<br>
suspend or disable through debugfs then cancels a work without a<br>
function:<br>
<br>
&nbsp; WARNING: kernel/workqueue.c:4335 at __flush_work+0xa6d/0xd10, CPU#1:=
 kworker/u64:4/406<br>
&nbsp; Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]<br>
&nbsp;&nbsp; cancel_work_sync+0x8d/0xa0<br>
&nbsp;&nbsp; amdgpu_mes_dbgext_stop_locked+0x197/0x420 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_mes_dbgext_stop+0x2d/0x40 [amdgpu]<br>
&nbsp;&nbsp; mes_v12_0_suspend+0x35/0x50 [amdgpu]<br>
&nbsp;&nbsp; amdgpu_device_pre_asic_reset+0x403/0x8d0 [amdgpu]<br>
<br>
Initialize the work once in amdgpu_mes_init(). On navi48 three GPU<br>
resets through amdgpu_gpu_recover and the mes-dbgext-wakes-gpu IGT no<br>
longer warn, and resets with the extension enabled still work.<br>
<br>
Fixes: 9dc106cb56d7 (&quot;drm/amdgpu: add mes_dbgext core support&quot;)<b=
r>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 0409325017a2..2da4bb1994c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -109,6 +109,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,=
<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_st=
ruct *work);<br>
+static void amdgpu_mes_dbgext_work_fn(struct work_struct *work);<br>
&nbsp;<br>
&nbsp;int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
@@ -129,6 +130,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;m=
es.dbgext_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;m=
es.dbgext_drain_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&=
gt;mes.dbgext_notify_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stopping the debug extension cance=
ls it, even if it never started */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;adev-&gt;mes.dbgext_wo=
rk, amdgpu_mes_dbgext_work_fn);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_MES_PIPES * num_xcc; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&gt;mes.ring_lock[i]);<br>
@@ -1765,7 +1768,6 @@ static int amdgpu_mes_dbgext_start_locked(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes-&gt;dbgext_log_size =3D size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; INIT_WORK(&amp;mes-&gt;dbgext_work, amdgpu_mes_dbgext_work_fn);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Resume: the log buffer is kept allocated acro=
ss a suspend/<br>
--<br>
2.50.1<br>
<br>
</div>
</body>
</html>

--_000_BN5PR12MB9464FC1930C6C238383442F3F4682BN5PR12MB9464namp_--

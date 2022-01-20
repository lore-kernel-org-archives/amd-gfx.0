Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82332C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 08:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E45E10E8DE;
	Thu, 20 Jan 2022 08:46:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6005D10E8DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 08:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1crc3yuBNMJvb1TVZrqD4t4MLbq23iLx+A32BnxT1K1SpRBzM3094btqVsam4p9pmKgyJjzi1H76tTpLnzEPhvNuzgipKqLaWtaMeefmGOO2PfSDH1hVx7ZxvVD4c50Fz9CGa9P+Qy12yOj+58HF8kKYdvhzu8t+Q4QcilLQ68+bQx61F8spoAUuJ8aksKKk53VedssWJGgGl05xsbyPLuE76u4TxYGK3NqSURxAGkxJKpjWpPh8BG3whbW4sPD1YyDZ2pTCl2+RuUqIqDCtb3b0JNheL7GI6bix5iUxKHA2uKjzBaa7ouH/5O2eHK7oyjSzSQ4AFyNiF31f3cy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhezX1LSwox6AYIH2xLzVo0Y0QIMN4lg5bPDoYTsjD8=;
 b=X3SkpLDMdRADcZtjGc+ssxLz7Wkk4r144JzuuQALpQbQ0sxoiRF9tN3WzlQuzBDOXmEyL1IOEg0wZVLJ0RRl2RW8AyiGS4Ur4eEzBGQeDzRRoN+e7uceBiLNcoVm67LY8VQdtNcTuvOqaF2EpeWzMBa+uAr8VvpRXMAHFbb4qrM+sMbTo+AGJFDi8aQ0kqM00vYm11wXotbWoTt7PuB+jE2QoNynUkbESGmdfXKthmECfeJAyI20ekgT3wV0YOwAE+sKnI6BEOZQKAWEXDhQ1au5gC5U55lsHuCcHPwI1OJ+MyBqCjjKtoSQyVve+Kprie4dTcZTcC4aaIjSJXg4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhezX1LSwox6AYIH2xLzVo0Y0QIMN4lg5bPDoYTsjD8=;
 b=pOm/3Wv4wC0Ffw3/PwT3NhQjQEHT+jbtOrdBBHiHSzk74Qi88glPun0EN2jYq7LOw1fXM8tb+mqqmLH3rapu5JH2nmXQhi8Nh66PWWp6DpItb2mdMJ+wme1P9oMssQK2TsNEfjSka+WS2W7yKUSWqqrxJvo8XscFn4IBZJq3eDs=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 08:46:32 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:46:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
Thread-Topic: [PATCH] drm/amdgpu: force using sdma to update vm page table
 when mmio is blocked
Thread-Index: AQHYDOLz9NJJp1Ao/ket4CY+uhKskaxrmDUX
Date: Thu, 20 Jan 2022 08:46:32 +0000
Message-ID: <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220119031610.832211-1-KevinYang.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 Monk.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T08:46:31.558Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a9a9636-6d7f-435f-2a80-08d9dbf15bcf
x-ms-traffictypediagnostic: MWHPR1201MB0048:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB004882342793E674973BABFD825A9@MWHPR1201MB0048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYLKHy63BroQDjJRYZralPn3IlE8CnIvi9bnZ+uTJpbadCik3J4JKjZbQ0Kp3P3X9xzh9e4a7VfM6OAOmFlCz+SAbw0Y6uxgomIb8+PR6NX+NlUaewtKMhxcZb0d9KietquZOPf3Yj7PAtvuWysaciPCrSH5LUHt2kMY3TnwlaS0e+zjlilsMv3Mjw2EKopBa55LgGVTzeetvdUHEruZGbS0Wm6XpZbk4puP47vehhy8euqN1WzYFrs9Ziw/ROoyyJset1UUh0OX3yjWs8xZdXm0shal98LM7I/tscmAMMqNwh1f5iFxZ9q4MaNzhAo7JN282fYExf+O2at91XAMf45lN7Mw4qVYSzO3Lkke07/gEoMQcLTjwtLhROFjJ+Akv3CjSVKfDdJSgOwOekfVWfVCKP6m5+CToBjjnzEk7VpyILX3IiOCP80hRJVplmO/gJo/b6I0x6BtlMshTtRiMIOgS1W7iinuxFDQ2BB5+2f/oBgSRwQ3r/juEAXU/or7pUqYXHv1he55JbWzZ/vLXumY/8tCD59qB+ly+jlC+vMNS6SDeOMp7ELaERHIrtCmKXaknIwQOBC5wCeaiEDLLyK0sjxobWd0nIim3edWHeUnuTn2/1GW1xzhc6oXWhk87bdnijWkkLcOmCTCDg8E2xY8MU1AXg1wD7weKBJ23zcY95bLuNcXXVV+hbCtHm3vMXM8XKnBF75j5rrucW5hRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(76116006)(66946007)(91956017)(508600001)(15650500001)(19627405001)(122000001)(38100700002)(66556008)(83380400001)(33656002)(6636002)(66446008)(64756008)(86362001)(71200400001)(110136005)(6506007)(55016003)(53546011)(186003)(316002)(26005)(2906002)(7696005)(8676002)(9686003)(52536014)(38070700005)(4326008)(8936002)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Btf+rdmtpefdWLQlSRJVYOXeZJWJ8UZ+T+WoWyzt9fhqESbBuTBInshjW+?=
 =?iso-8859-1?Q?f9BrJQYe/1Zn8iFFvlIuVc0rOpt3ggUoJEFVqK2P/3GE7vyt4prIEpNwR5?=
 =?iso-8859-1?Q?5mnvpWRM350N0AFCx4a2yTXxkLVmf9q1bsvyx5Zt1gtoImKBgvFzVwC2AH?=
 =?iso-8859-1?Q?/cYr9X7WTBQNW8ScPSYp7KFfa9amUqsa6PW7LxgZfyhHaXcIGWSOZK8Q1l?=
 =?iso-8859-1?Q?5pErmTKyrOfcLocJgJA7kUOZqtfaHfjDqJQ3ryHK+4ejvZmKICp6utGeha?=
 =?iso-8859-1?Q?Gi0LongKp7gY/ED//wWy5VMRFjojkkXUmro4hsXmTamRTNSn8YifM9A+E0?=
 =?iso-8859-1?Q?nNLpc1nj0nFIY909KQkCDDPW9boVwA7lkAy7XzikDTtEcli21YEXlc6vpT?=
 =?iso-8859-1?Q?oqOl5w6753v1LP5Yd37gv9ffR1ZuH4M6Il9qxbQDNUFiFJ8JI7rDPBIXrI?=
 =?iso-8859-1?Q?p9j6p5S4yBUYirKnn5KSB/UJK/jnBMv/UcSb6/vOq9rJBWzIiF0ju+kR70?=
 =?iso-8859-1?Q?sB+KPHdNj0o/sUxgutJVgNGXj1rYx/GXE+3F8uizcullGC0eAfWBTDJ9x3?=
 =?iso-8859-1?Q?/HovKrWmAobPleuNEZobCdSFdcuzLrd3jMW/+i7Rw/wzbxrI5Gpuaj6sLf?=
 =?iso-8859-1?Q?dA9q30KKJ5dbQ7SoLwjIIr0Ez1QDplfvTj55/wwnyR4BI/D/WhQfjpUIhB?=
 =?iso-8859-1?Q?JDey2wnOLN7+muGE/qgRDCZmV96wYRyxfy80P1KWyPQYSSvWBtY02654WV?=
 =?iso-8859-1?Q?DbMRJr7CG8UvXEC32JwbtM52rZof+O1nZm/E+8ORj+C2+9V94z+64+g4xk?=
 =?iso-8859-1?Q?KpQTkAnPwNEtFCvvMJmggZcIkHDq1PhdAgHZwp6AXv2DrM9CBuv4PWnhA1?=
 =?iso-8859-1?Q?mmtK04I6jfWTeHHD/G856CfIzf/UPHrPP+PZIz9UNTjErsXTS0hYb2P0lH?=
 =?iso-8859-1?Q?TYIv76tP+WQ1LQaMEMg7edi6HgpDUtZLVDE/wJCLL7KRSMK984EpAs+NIj?=
 =?iso-8859-1?Q?hNkNekWIs/nzZz8Ecu8HmSdii9cu/IjX9e2hbjzvLmUQ/rk8G/fQN2S/N+?=
 =?iso-8859-1?Q?aToRTNEFbvJbQNE0g+3shNMBhnfAVnnhVyCR9p5cc/7WKrfvevuewBK6H7?=
 =?iso-8859-1?Q?/hASsMeSDZHKwmf7PZrEIS1u/JAXEi3sYpuxgT6LZLyCJAtv2KPW9zuWmZ?=
 =?iso-8859-1?Q?Dph/ui4CcKVB+Fu3GR8W9rvRG7jnPahegDK9VeDKkAV7PbSut2Gu3+p6Ce?=
 =?iso-8859-1?Q?XTH0ixAsvkSE6rRiBJeLaSp0bsZZnlOm9Yq68OyLDDhVlpz7S2oZ5rj6BI?=
 =?iso-8859-1?Q?arJypIIGinJTwjOcRC6flnwtxY/vdsDdBkt8WC0560KFiiTAZnwjDZmDes?=
 =?iso-8859-1?Q?JdqDeKuUso/7cebk91ILxI2oKZn99UJSG0w0sh4tIkPYuY+pHkV5O377GZ?=
 =?iso-8859-1?Q?FfaMwPR7XG0vGGaYiyAlQYuPD8G7MPZ/UrC4ByVkTztIXvq2oWxYeVNana?=
 =?iso-8859-1?Q?8nKj97ovpncwxYZk9cyagz4gRp6dfgGNgkkFftFklCwRnOM8N+wNTCg2h3?=
 =?iso-8859-1?Q?snyb2t9N6EahmsBsqHT7L8uBPlep69JSh6zcgwqvdOttGC7FcWiIyd+M2c?=
 =?iso-8859-1?Q?1aLJjAQwpHoEQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54731E9FBF54A2E86A320419825A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9a9636-6d7f-435f-2a80-08d9dbf15bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:46:32.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLWxtiONDTGgmg2L2+86Vx3h9vsPGNhYke+BKpBQLStMFEqaSMe1ovfCkweAnUKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB54731E9FBF54A2E86A320419825A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

ping...

add @Liu, Monk<mailto:Monk.Liu@amd.com> @Koenig, Christian<mailto:Christian=
.Koenig@amd.com> @Deucher, Alexander<mailto:Alexander.Deucher@amd.com>

Best Regards,
Kevin
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 19, 2022 11:16 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: force using sdma to update vm page table when =
mmio is blocked

when mmio protection feature is enabled in hypervisor,
it will cause guest OS can't R/W HDP regiters,
and using cpu to update page table is not working well.

force using sdma to update page table when mmio is blocked.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index b23cb463b106..0f86f0b2e183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_GFX);

+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)
         /* Update VM state */
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+
+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
--
2.25.1


--_000_CO6PR12MB54731E9FBF54A2E86A320419825A9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
ping...</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
add <a id=3D"OWAAM160069" class=3D"P8b7u5KH31KY6Eljcf5yw mention ms-bgc-nlr=
 ms-fcl-b" href=3D"mailto:Monk.Liu@amd.com">
@Liu, Monk</a>&nbsp;<a id=3D"OWAAM254265" class=3D"P8b7u5KH31KY6Eljcf5yw me=
ntion ms-bgc-nlr ms-fcl-b" href=3D"mailto:Christian.Koenig@amd.com">@Koenig=
, Christian</a>&nbsp;<a id=3D"OWAAM277931" class=3D"P8b7u5KH31KY6Eljcf5yw m=
ention ms-bgc-nlr ms-fcl-b" href=3D"mailto:Alexander.Deucher@amd.com">@Deuc=
her,
 Alexander</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 19, 2022 11:16 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Min, Frank &lt;Frank.Min@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: force using sdma to update vm page tabl=
e when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">when mmio protection feature is enabled in hypervi=
sor,<br>
it will cause guest OS can't R/W HDP regiters,<br>
and using cpu to update page table is not working well.<br>
<br>
force using sdma to update page table when mmio is blocked.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index b23cb463b106..0f86f0b2e183 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_GFX);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update VM state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_COMPUTE);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54731E9FBF54A2E86A320419825A9CO6PR12MB5473namp_--

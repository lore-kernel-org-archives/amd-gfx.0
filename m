Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676FAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 14:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0CC10E994;
	Wed, 23 Feb 2022 14:26:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65A310E9BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 14:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDCAN2IICNPhY47LT+Xzd+fpDGOWOacvuGgx3wfSucxpOs671w+OyDDqSu59AtRU/135DzZb8XX47Sgg1ICG7nWC5iILW+yET0YVcJ6b8asxIi6g9Hrl29Mf+9bb0xhv7vLi/DZ4sLue1j193BBmU1IkWRy2AKYzHgtNf3Iw2oqyaRegKFp3XJmISDTvmA62O1zkhpwknxNKmQEULaKufFpqI2eNedguUaGDZpWkqTzOm+BIlvyk2G2lOSPmz0KkxpnMmsGgetvdmrHWixwH3qlxjOt7sq5Z89GutGnlPanPu3rQnbTRDutnTotI3XvLYuSh5yFtLI/Z4Zi9ykDqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rHR+eyR6X+JW82O8NU6rEibH2s7lNX69/+/YHeviAA=;
 b=Zvi8TftGA2vNQT+TR2FOV+2Z9wdIFThu3uQf7MvaDwChmfYHx0BSt3NFksBp9TVxG9dP8ZWRKSQpNwzre+uFd/taEJ4PDF1kQmzzlAjgbSyzQgdKKsndbykHlBsL8mN6apT0ipb/V1Ow8YzfNlzzCSVrATy8JlkbTTBMMyq8EBdqyJYnnwJp5XtI7Svpa4GTiKAFXNAS8291Cpy+gPgy2kskGoUqdfi6HFwL61Xed1uWeFsK43K4qiB8ENT6nBq+EvabVgSeMAo96fTu5SW475TAIjyEzo/1Ing3gWL1lG5rch2d/JmJA6mnRsOMc7XWcSN+fShkzEENNODMjxLJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rHR+eyR6X+JW82O8NU6rEibH2s7lNX69/+/YHeviAA=;
 b=4kLenrZdM3ueWCqUEItswa9sZ/v4lrN5jjjNVCv+mrrfLXZxr6igAi2KhBErFsPDxlaGDWckMQeLtqKMqsJJwyBMINNmSnDK2+oIZ3bY29t7LwHI7RWRTQN7zGxeBS14tvhHUMW+dtcR5PnOIozkWyAGBOlcsfgfmXmFUl9SBZ4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR12MB1683.namprd12.prod.outlook.com (2603:10b6:405:3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Wed, 23 Feb
 2022 14:26:22 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 14:26:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK
 to fix applications running across multiple GPU config hang.
Thread-Topic: [PATCH v2] drm/amdgpu: config
 HDP_MISC_CNTL.READ_BUFFER_WATERMARK to fix applications running across
 multiple GPU config hang.
Thread-Index: AQHYKH4lQdHV5vpiF0miG+bR/dz+V6yhMXIH
Date: Wed, 23 Feb 2022 14:26:22 +0000
Message-ID: <BL1PR12MB5144160D25AC133DD768BC77F73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220223062410.1875224-1-xiaogang.chen@amd.com>
In-Reply-To: <20220223062410.1875224-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-23T14:26:21.610Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 92ceea90-dea7-fe11-d4a7-4f9fc2f5b653
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172deede-75d8-45e5-bee3-08d9f6d87741
x-ms-traffictypediagnostic: BN6PR12MB1683:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1683F79DAB565C0CF441D74CF73C9@BN6PR12MB1683.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWWCgs7hSePW+bNCBw5hIHhHN3MoDGtz47G/Ol61mSNWaQSkn3DG62+HCLp3ZmM4KiFmrYPrZWYLnPgPEe8slEVbnbypmbQGvzwQroVcWrrnv/7PY6OFIY2W+qUu8dQDy55b9hhjzIvE3Gju3iS1HYc0GG5jMaIhUgNYzp8FVPNqobt3j7Mn5nD2n+8pr7g/2cQ5/8lh8d9LkIjNH/eUS8DK5tEMTUL4x2bRhJbz22NYGEh/vfNWStkJKEljKMOCan8R5bKZv6QGacFC0jtpujIbrNWDo0Ls742dsmZwtG5TZdgEqA/5X/8eC9Vi2mMiliHmoHifIhDhVhLMlVPgTVNDM4O6YZo2YXWMC2fRMU/l3RXXKLs9cjixjiH6yUZupz4NT8fFurwz+1AMnsoEm41sXGlJIYAVP6kdn83yFTCS5vcP/DcWWPaz0sTdI15n2QKUsuYS3QI2G8UPP4tE66InuTG4B3TMSfJslbbR0nVR8s5VGTeUygpglP5ZT2E/HXK//wv5AfE9QWgEwnqL4XU0PbBYzXGNLlEf6ETeggygn4NxQoD8Q8rrHxZ3Y4OVT3C2tqlZzIhbX5niH/vdttLozF62oFAbUaAMU86qbjWNqdBZIppwirLTUDwKe4J3Vk1pT78+iQxfueuLVme85qBbO8f5F1cBYPK0XKo97PwNaWEay40VDw7UBSnD+Izj/+5trQZ5qEd+U4XJhQoUbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(64756008)(5660300002)(122000001)(4326008)(8676002)(8936002)(19627405001)(52536014)(38100700002)(186003)(83380400001)(38070700005)(33656002)(26005)(66946007)(66556008)(66446008)(76116006)(66476007)(55016003)(7696005)(6506007)(316002)(53546011)(71200400001)(86362001)(110136005)(508600001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x4jg0NkoPvH6r7l6Sby3h+3vq0X0Ow7qTkl0L3B8jpZfNkwAd70JqH5gtTQi?=
 =?us-ascii?Q?+PYxjs9xGUhLmBx+8EPXyVKBCRHpi5XWKkagCWTmv4uBkGkKcwLce+WaVDAQ?=
 =?us-ascii?Q?UUezrAc8Xp4T74kkKAnu+2TQ2OdLrthOCl2p3+NmEMidjAyrja5eS8dWwj0Y?=
 =?us-ascii?Q?YbBeDLZurDFUcbXSIiwk5rShhe3y0fRb3ArrWJYZDBXVelZ1Z6ysAsoNbOTT?=
 =?us-ascii?Q?NLp+j1E00uq4bkI5dbecDxRC054gV+nQQGP3vo0SIq7X6uzzVkP/8PRqEZFw?=
 =?us-ascii?Q?M1IWV/0qvKsON5mDKkDoXCSUnJJDknBm3R00HhnzIx/YS5OuZe6KQQ0JWMa9?=
 =?us-ascii?Q?L1sKmsijViGDvzelR3A7G5z9RBu87CaN51KF/FZkujwg4RDyHsWXnj5FWV3Q?=
 =?us-ascii?Q?24NYY/rWYywWdSeuIpWXsyAXeqm+/7mspzSCMuwIJMJKGcVGsNF9xw/8kOkS?=
 =?us-ascii?Q?+6/nS1bXC6PpW85ImYjto9j0UasyhJxDejirVWjTL/Rwu2NjXvffA8yJFnXe?=
 =?us-ascii?Q?KK/9IPi7CP21R/krX8g9QjDtUGbF0i3Q8SVAyc9taiaHJbUHwkcPk4Fo9yqe?=
 =?us-ascii?Q?wQEHso/+QKbuYCoadTnGcvHS/EdvKTosQYAIdOsWY9l8u1BpcjElBgFxNfV/?=
 =?us-ascii?Q?CIKRxLSX4Ky1HHqU0Pbh4xXdUFhL4UQWTAjAO3CoYHbq4KV9sfwtg99snhYj?=
 =?us-ascii?Q?olEh7N+zDRonP5U3SYnOa7Hc28xPZbPFlPdkH6OWz6AU28jexVigbTYpYt3c?=
 =?us-ascii?Q?jzaLcLJKYN6jh7An5pNDd45aOtoLGB2HJpXolY+UjmiSVl3wCeauhd2pf7KD?=
 =?us-ascii?Q?yoHpZzTvgz0ZIVNl4/UeShKOvy2lGaIpAoI849VxfaQPbn+gD1KO6sF6mJlt?=
 =?us-ascii?Q?1ZsDdEJZWxOaXzKw65WQjP0zNnj3ATdlCfAsTvHtVm06lXZmnJmQmCqZ53TN?=
 =?us-ascii?Q?UO/KNUHo1pCKgCbKlkYcrgufLg3CXhxKko4d2ffjKdpd8ihYdXPWxGhaB7z1?=
 =?us-ascii?Q?5Atedqnv09CyIuhIHcFMwwARATTWBuDjmvQtgoGJjcB+J3nI2wDu78FzvD1m?=
 =?us-ascii?Q?iwor4ykNyWK5Ur+Ho064stic+zN+81Vo8vDMPKuBx9Yp8KdopzKTk4g4QP8x?=
 =?us-ascii?Q?SJXHqQ/p1an7eFGfwffyPrjdzvZ3cHwt2dlCLCv3Ir8wj5c6R4aKPGdSKKxh?=
 =?us-ascii?Q?raJdxBaxQF7xQViHZr2PsVg+jACSAQ+5M0ioE4kNhH0Xvam6sOgORPu/f8AR?=
 =?us-ascii?Q?T+hEh2m4gq6USUdNXGDF7S71xrdNTotAwBpeSEvC/TI6VkX2/frwNKxcrMMQ?=
 =?us-ascii?Q?LHllcF3qCjEcc+J2AXn7j+07LUCk4mOFs+jcPxFrnxn8+wiG+2Ycdo68RCTw?=
 =?us-ascii?Q?Bwjp+v2kU+oZu4Gyqpb+gA/Ekvu46y91n1qDwmG9m6PyQKv5R9h0qedAVV4Y?=
 =?us-ascii?Q?RBKnAThfU9axJ8lGeXlQLbFchfWX7/o5Ypjub2poccsSTbTG80+snoidv3Ns?=
 =?us-ascii?Q?wZaFFSgzit+eI8R4IrnTBj/uFQ+SmNP3yn/1gFW+5VeewcskUEY+PVDuQvZJ?=
 =?us-ascii?Q?N5so/ZW+meyzS29AG40h8KsPiOqcrDNZeXkk4mg8Gan9i+1hXfTPbMuZUGcv?=
 =?us-ascii?Q?k9fS9C/lY+0y3XU4B3Z3N7I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144160D25AC133DD768BC77F73C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172deede-75d8-45e5-bee3-08d9f6d87741
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 14:26:22.2708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H+6vbM8FFAXmXs5voQvCi4Ip5jyb3rfC2/irAPBTVRx0KLOVPzLNO1yUa3RIMY3wPNnqD3KwBKdGqvOGIY5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1683
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144160D25AC133DD768BC77F73C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Please include a patch description.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Xiaogang=
.Chen <xiaogang.chen@amd.com>
Sent: Wednesday, February 23, 2022 1:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Xiaogang <Xiaogan=
g.Chen@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK =
to fix applications running across multiple GPU config hang.

From: Xiaogang Chen <xiaogang.chen@amd.com>

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                      | 3 +++
 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index d7811e0327cb..02400d97a95c 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -146,6 +146,9 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)

         WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);

+       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))
+               WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK=
, 2);
+
         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start =
>> 8));
         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_sta=
rt >> 40));
 }
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
index 25e28691d62d..65c91b0102e4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
@@ -104,6 +104,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT      0x5
 #define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT    0x6
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe
 #define HDP_MISC_CNTL__FED_ENABLE__SHIFT        0x15
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT   0x17
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT      0x18
@@ -118,6 +119,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK        0x00000020=
L
 #define HDP_MISC_CNTL__MULTIPLE_READS_MASK      0x00000040L
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK   0x00000800L
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK       0x0000c000L
 #define HDP_MISC_CNTL__FED_ENABLE_MASK  0x00200000L
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK     0x00800000L
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK        0x01000000L
--
2.25.1


--_000_BL1PR12MB5144160D25AC133DD768BC77F73C9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please include a patch description.&nbsp; With that fixed,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Xiaogang.Chen &lt;xiaogang.ch=
en@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 23, 2022 1:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Xiao=
gang &lt;Xiaogang.Chen@amd.com&gt;; Kasiviswanathan, Harish &lt;Harish.Kasi=
viswanathan@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WAT=
ERMARK to fix applications running across multiple GPU config hang.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Xiaogang Chen &lt;xiaogang.chen@amd.com&gt;<=
br>
<br>
Signed-off-by: Xiaogang Chen &lt;xiaogang.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++<br>
&nbsp;2 files changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index d7811e0327cb..02400d97a95c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -146,6 +146,9 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP=
_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(4, 4, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK, 2);=
<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE, (adev-&gt;gmc.vram_start &gt;&gt; 8));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE_HI, (adev-&gt;gmc.vram_start &gt;&gt; 40));<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
index 25e28691d62d..65c91b0102e4 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h<br>
@@ -104,6 +104,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x5<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT&nbsp;&nbsp;&nbsp; 0x6<br=
>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT 0xb<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x15<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT&nbsp;&nbsp; 0x1=
7<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x18<br>
@@ -118,6 +119,7 @@<br>
&nbsp;#define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000020L<br>
&nbsp;#define HDP_MISC_CNTL__MULTIPLE_READS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x00000040L<br>
&nbsp;#define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK&nbsp;&nbsp; 0x0=
0000800L<br>
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 0x0000c000L<br>
&nbsp;#define HDP_MISC_CNTL__FED_ENABLE_MASK&nbsp; 0x00200000L<br>
&nbsp;#define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK&nbsp;&nbsp;&nbsp;=
&nbsp; 0x00800000L<br>
&nbsp;#define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x01000000L<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144160D25AC133DD768BC77F73C9BL1PR12MB5144namp_--

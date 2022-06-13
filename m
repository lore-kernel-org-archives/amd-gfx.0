Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC165C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 13:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395D910E2CD;
	Mon, 13 Jun 2022 13:23:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FD710E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 13:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU2o3J/mbzzX0FJvr47oEfmvxtCYqcVpFBzUsqo0HZ+AFUMHB5FnY73y/lPB3YiVOqkkKWTjC8Bj1EiQG4p91fVwtAGj21Qrosk8lESeuoQzFsfu+vGimwBvM2nMRybQ6sL/kb9gUDQd0l9lZ7yndpCfBrKUNLG177QH/B2QsqJD4xhnptj2lKnt2S0skciAfNMH5baJ/OAQm5MC1bfUaXfSjlvfxVZPvCoBXJGBiTd/5XCxLS0MInAARTq4kjoIr46aA2X+87jiFYmkP8QcKApFnFpQ9uqkBYywvSpMwmnfx1SlYDNCNniNSOFN0zGwH6bEH39PzagrkDWvCtlrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llFvUdNR3F7aE+kbIY3EG2KBj36DjsU/PlNvxuoU+iE=;
 b=X9YaO2T6kA1i4uc0h8iHJXi/lCLfZUXaO+Xecj+0UrvlM30B/E2GsC2rOOGLFpHu3HAIT+AzoEANnSsOk+iepM+tgQ5ZzMJ2jcLLOy6sT92kfqIkUq28a5l33XZjaNpsYI17WljCTLuYj4ypmiMBYqBc66ZvFkj7H/7xcQVJJXW+HHgZENsk4zDXE0eZzgrbCN3oh5kN1vH8vKxKsPH6VJnmMp0F2h0quyP7LRZpV9iT2RmZtd9W9u1qD46aLWWjBB/HtvIRCGsZKKJhqxD1Q4AA1XI1T5DPwivtmUKywlAofUL2GQ0t66/2DD9YVfHebMrK/7Zn1ZQLWtw/CJfQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llFvUdNR3F7aE+kbIY3EG2KBj36DjsU/PlNvxuoU+iE=;
 b=qwksaHXHtkK1sx/iFe/4IT1zijAslJKBNx3K9/d0ag7+VNoaaixu0iKkbOUSqUDDCAiM2iaa5wblyHUc8XdGbsOynDNXJWxma/Ajvz1kp6ct8tARAuc3sYkiLYnglUVicK4Uq0OY1C72tD7THOJKRdqEiadPLlx3Mu2mNYhQLa0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR1201MB0084.namprd12.prod.outlook.com (2603:10b6:405:57::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 13:23:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 13:23:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq
 setting
Thread-Topic: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq
 setting
Thread-Index: AQHYfhV/TOoqlxuSUE+Egk8F0D5+4a1NVWrh
Date: Mon, 13 Jun 2022 13:23:53 +0000
Message-ID: <BL1PR12MB5144E6B953F3F4603632D303F7AB9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220612043143.2755859-1-yifan1.zhang@amd.com>
In-Reply-To: <20220612043143.2755859-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-13T13:23:52.862Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83aa2a17-3b11-438e-c2fc-08da4d3ff619
x-ms-traffictypediagnostic: BN6PR1201MB0084:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0084C77B310D557ECEDB88A3F7AB9@BN6PR1201MB0084.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NlTO1cOSZAPVIfP6hwdLVE++Y0aVc2u2tWwutkjzsS0gkETsMifLcTf2etPI9yKrrlFEqqfynPXiI3r9DVJb+rjG3py8O5RL8pXj1/Qmd+HLMoz4xi7VOOmI+b4LuZ86OjATrihcSdBb7MtpQrD3Tt4W77XoSj3p0S2Tnpf9G4lBktgilvsbSnxyxf2nXqmNjBx1BQjOBtffCsCcGZ82nJQziUBFSSfpC3T0vnIETwelBNTUBhnasURp/9Amj1G3cyYk0t3DOLoAuUzc+thyrZZ+n9tshXJOYKC66LoFORkscP7digtxtPjb1dYYUGEi2+rt4o0ez4djhFaNuiU2+v5MYsLGJ9Fnwsbpje3k9Kk6HW4vYWq6vk6FsbuXbWVq9JRvBN/8JY2Vr/RxQmQPtsfj2tSVV+QkB6sS4Ca0XYGGW7pdukdw5mL6UYiWwuHDzepx3xYI7243OBxi9Jkv2aLa8cF816qld8YLYbfOrf57Nh0F2m3E0HlZ7eNscyl+JiRVEsS9A2n0kfslODdfHowPFHdkZLOgtYgjx4JyAS20xuB4IFcr5WD0Tq58rDIfh1zzrsDJz+2Z/XRtATXGs5L7sLmHlC0iqLSTpuDmeG31pNhRlTvy1wRSbnUOCsfRl8r1J93DuAf5KHN07xgC7PMZCJpbpwp1TPNpXsf/+i1aBX7YPkrQKcSYlrAlDypWgVbVJdjA/sfgbLG1qsK5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(52536014)(5660300002)(8936002)(33656002)(66446008)(53546011)(7696005)(6506007)(66556008)(508600001)(9686003)(122000001)(2906002)(38100700002)(38070700005)(26005)(186003)(86362001)(316002)(110136005)(76116006)(55016003)(71200400001)(64756008)(66946007)(19627405001)(8676002)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N5lJaXQY04OkRvOF90xKg8v+f93IrQf245BWVyb4Yxy4tlZ/pG0wUaMgUvuK?=
 =?us-ascii?Q?Y6vIMUVzXbuYb8WrNC4X2PkHamdeoqghoBJwfEDql5gxkoanfFF1yO66ZQBS?=
 =?us-ascii?Q?PVDYVI78IB2OXrSUV8WWfpKeMMhA2JKAJokxq26f9tzdgMQZirUOnKQSUcsb?=
 =?us-ascii?Q?jOfgiXqA2Hjk91xCng27qyiVtNWCBXxiFopBlA1096UGrZWkS6439MJebs5H?=
 =?us-ascii?Q?1CwPJYysFxruOPVcbs7TGUgbIDIZehZKmEVfdKbz0auWmSDuW/SlayIXra7r?=
 =?us-ascii?Q?ad2sXjSGRFQfclPZr6fr4iygAgkutYhZIbhcY7GrdcbRM1+om1qcQrtOkMcO?=
 =?us-ascii?Q?jhRUbasVp6FJJiDwhyhM9pQP2k8fabrDhieyR28+iv7Vl5AH0VR44eIDbU35?=
 =?us-ascii?Q?UzWKMM2eF+GT/9+mexba447Cg0HHcnORIOzhVQXJOfWcHHDuNLV4WDwOO0Ou?=
 =?us-ascii?Q?xBqL75Fil3I/r8p66rSJDuWr02ods1mJo0WJBasZIli1zcmmXMlH7KxL00tR?=
 =?us-ascii?Q?+TWkVJBk7r8zdOiPQo5xw8Iu2u5M1NmnQ+1eN6AG8ybJhP54daeBMdgEV6L/?=
 =?us-ascii?Q?R8N7rGI+psbR4bGSU5DA9+JVvX186ChB8BQAhTky73UT6fwh7VcGTKQHwhzS?=
 =?us-ascii?Q?NucvOK5bXaOSY0XycLBBkCxtY4IWqXbvrkxuX8++6XqnThp9+ny3b6v+SpWS?=
 =?us-ascii?Q?JDuSftDABkEdsvgwtzMCxW10lFCqIYRZkHvV8OelEKEiVTliLrTereaXc67A?=
 =?us-ascii?Q?59gQjta09RfUVZTXvDQTq4TdIqLZz9hkuFOQjypCD5C+se9Wo+odPC+AKTRH?=
 =?us-ascii?Q?LpJEd8QXwOHezgIwmgsYtMlQDo3MebGonUZm3pjjbGQdas+LNfpCVVlfXqp0?=
 =?us-ascii?Q?/C2Q+WqXkYPl31m8NG/wlETZ1/J/t+rRgn7EKo6UOlwgSiYBxqPEmPdMwBgo?=
 =?us-ascii?Q?b1uxQD0QuX5Ur4UyE3erDJAgSNclVCuG2uwXaNHbFWBZNhzBDbkZnmviRfsb?=
 =?us-ascii?Q?6Hz2O2gytDFEYTorbkq1E6mH9RFBpAodODbit1WVQPc+K7XjrsiNuC1u8mIt?=
 =?us-ascii?Q?BxrEGTzo3CimkrxJrwgjRszUjAeIg9M7fWvqxW2G8gy8AZoz8Vcli+Wt1Spm?=
 =?us-ascii?Q?A619o5N0Cca1VVI7pY3l1WKef+rgdT0OaTSskpkhpUicLikYpdyNjsOnUWyj?=
 =?us-ascii?Q?nsyU2WQdxyRISXsmkaKJRqoZGi9r7J1HPiUE2qG0dhjJkHS0ncOG5IjCVKdE?=
 =?us-ascii?Q?hG2PiTa2NSkuAUsRfpsfJ8NruW8uZo/yB5A3bgFnqZIn+7TnDkdBAaThqLJj?=
 =?us-ascii?Q?f8d3dGzbMfSoZjEHIh/x919Tk27RCVDQViWMxWiYLnJiLdSsP3ZunnzZ4ssj?=
 =?us-ascii?Q?NU1WlD5RwXxaCTQrnaB+brBTBNt0CZNtfB1ZG4BSoa1WaWiXO6ppkpdfJYQc?=
 =?us-ascii?Q?tD6SzLQ0pe3UTRxDO0SCbXinnSRHD5onLBQBDtCEqYlu/u3apMG705AW3/Gk?=
 =?us-ascii?Q?9sc+fJED9C1jXK/mPcLhVvOxXW+ewB9WYNOBPzsd8F/bxbLvbTK0f4pkkV2a?=
 =?us-ascii?Q?fpsFbm4p8CJoVKhz9K8SwDJWa9DjoPhnW0EMzXBWswtKGKn3s7wuY1e9A0NP?=
 =?us-ascii?Q?fAEEjPGWPlAqomQ3o2A/rlsT1UzxzRM/jkMXT4+NJ5Pf/EH3RtxyZ4aedLwy?=
 =?us-ascii?Q?opKbXl8Kh7duU2HAWqjLDLu/am5onbVqxKnTPL4cqL7NhnmZ?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E6B953F3F4603632D303F7AB9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aa2a17-3b11-438e-c2fc-08da4d3ff619
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:23:53.3039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bP2K9ee8KJaAQhLBeL9uJAN5sHLbpiRVbnaW1Yjq59FUPPsD0KAyUzClKxzqiHI/qubNJs7OvXCKG1V/KfwwsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0084
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

--_000_BL1PR12MB5144E6B953F3F4603632D303F7AB9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Sunday, June 12, 2022 12:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_kiq set=
ting

enable_mes and enable_mes_kiq are set in both device init and
MES IP init. Leave the ones in MES IP init, since it is
a more accurate way to judge from GC IP version.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 68a53528089f..2b92281dd0c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3614,14 +3614,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_mcbp)
                 DRM_INFO("MCBP is enabled\n");

-       if (adev->asic_type >=3D CHIP_NAVI10) {
-               if (amdgpu_mes || amdgpu_mes_kiq)
-                       adev->enable_mes =3D true;
-
-               if (amdgpu_mes_kiq)
-                       adev->enable_mes_kiq =3D true;
-       }
-
         /*
          * Reset domain needs to be present early, before XGMI hive discov=
ered
          * (if any) and intitialized to use reset sem and in_gpu reset fla=
g
--
2.35.1


--_000_BL1PR12MB5144E6B953F3F4603632D303F7AB9BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 12, 2022 12:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove redundant enable_mes/enable_mes_=
kiq setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">enable_mes and enable_mes_kiq are set in both devi=
ce init and<br>
MES IP init. Leave the ones in MES IP init, since it is<br>
a more accurate way to judge from GC IP version.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 --------<br>
&nbsp;1 file changed, 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 68a53528089f..2b92281dd0c1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3614,14 +3614,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_mcbp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;MCBP is enabled\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_N=
AVI10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_mes || amdgpu_mes_kiq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;enable_=
mes =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_mes_kiq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;enable_=
mes_kiq =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reset domain needs=
 to be present early, before XGMI hive discovered<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (if any) and intit=
ialized to use reset sem and in_gpu reset flag<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E6B953F3F4603632D303F7AB9BL1PR12MB5144namp_--

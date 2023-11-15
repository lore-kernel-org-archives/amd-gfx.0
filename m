Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2A1C47071
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 03:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A44810E3BF;
	Wed, 15 Nov 2023 03:12:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF5110E395
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 03:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncu6zs3G5fAxG7RKTUzXZpBtNLnwXbmoCLOzVqEQRXUB/Bnej7iH2rrqe4HaQeEETzEwnm82KDqhhfgXFOYfngwLa+FpAzVP6pxLWjdJf+NHjrbewzsw6z9q/VH3yTxfOOgOSG+p6rSSsBrbkWDwFzbCIUVGmC0YPUsjg7IR/lmC9Fxv3NwFDjS/KDijlIVHaj9Gef835GMdNK64eOXIGHTrxggJ4+w32MpNPvtsq1G+R9W5kvqWqNZBVhaatHQoIBKCKWqiXRALHEqfh2nNEvM4NVNDtd4x6sKqB7oxqucqpwwi9tIUKL1vious+rj5sXlACIHxqwJZz8dz1AnYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb6Tabl127nLX8CBhKQQhl7wV/AtX4B0ZbvRfmoWepw=;
 b=cJGOiR43SzH0GoARnCnsQHtJb8rKfoJoePpsMWoGB6Q0QB3tg0bZMmQJtfQgbXFa6pF5sFZEyYyjmQtHCm9N1hYJXdRc9zupVhRcRSbrkPqs6AUQjUEEZBzXJqo5ne/tTMp2PIsPmZqas5DiqH3eBdwIui7igWXIO+WqCQh+8ih19ZxXyHWuy0gmL1uSgoSAUSadkVVr0/bf5ny/dn+NPnk09O2CLej95Zc4unkT9KAZQgEsvsfKfS6pY0eWAiW4u3i2BlRtj+AWlgkuC3u+Io2/HrPKt7C7wQPu4ZEi6jDS27bDoy0Fo5tvw4WEVCyqOeFdzc51EPYohIaghyH86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb6Tabl127nLX8CBhKQQhl7wV/AtX4B0ZbvRfmoWepw=;
 b=xH0yzLcrCc72QonPkRf2FGaTBZxtTtQGuG6t/0mq4vsM5eE1ITYr+65dq/SeUlAXJCodDSd2eVlyQxE98hfyG7b5lHqvt/+MvLBMK1pB7dgl6INfwqR94BhqEzJM+6Oxb9VfFuiA1ap9tdKQR15JNM2ThuA50DbPs9aJ2ZUoLD8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 03:12:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6977.028; Wed, 15 Nov 2023
 03:12:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Don't send unload message for reset
Thread-Topic: [PATCH] drm/amd/pm: Don't send unload message for reset
Thread-Index: AQHaF3B9qzWKYoYsYUO5tLF5aRvsK7B6s7s/
Date: Wed, 15 Nov 2023 03:12:11 +0000
Message-ID: <PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231115030425.613561-1-lijo.lazar@amd.com>
In-Reply-To: <20231115030425.613561-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-15T03:10:37.3816342Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS7PR12MB6358:EE_
x-ms-office365-filtering-correlation-id: ad5609cb-d598-4619-27c0-08dbe588a90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2+p/XDxKqeooxGgi3gwF9GeDEeP2rZBjG6mn+55bJkU8hEMbOXwKOPWEV5aGNBZ8+cqS/E0HfNsl+NR6ThE1vOxlr7p0UoNgYITjgG/sR6ZvtpWT1O+Q3+utsC67+DJpKox+jb5twjr5TOE9ScqlOnM3BxrvadrQgzN76MBjutCg0kXHo7k58fLEnfvnUh7ePaPj+PKvg2q5FqvDPq7ggpky+Z1JnsTCWYMXdtvgS3t0RwRQ0nkjBrVRHNNOupXjYhLsiyzrKgSStkZxQwNnChXz+31bCOp4H+n84oDezliYZyPE6QlVsRDQvRE0ix14xEq/bQHlHuRY4AB/iapPnjDS/fR68Zvq0tcvKaNZnUAs+BeyVibfwEvk7XKHIr20Mu89ZShcBcEz6/blnoeVek6MOmcguD0xfrjscSbs0J8BEWGaB+73eTnmkJsh5T0szCQu/BF8nfIDlNzU3kn3EaEuwwYhhmGvxClHitLlq8nUiX9XAqFUjD2/1T6ZI4eKjsqkw2dopO0D24+dR9eO75iRJYqLDqCQhq2cHRsdAggLxZ/6ZNzFt9lqbxJ/eqD/18jqPD6ruJTCP4hVujmgOP+9WlHQDiUAMv6tv34xXDv3GzVtEDDcZkJy0Z591wd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(122000001)(38100700002)(55016003)(83380400001)(86362001)(5660300002)(38070700009)(9686003)(7696005)(6506007)(53546011)(478600001)(71200400001)(66946007)(76116006)(316002)(54906003)(8676002)(110136005)(66556008)(66446008)(4326008)(64756008)(66476007)(8936002)(52536014)(15650500001)(33656002)(2906002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CuDC/A7pH8htXKnhtBg+5FHypN1bbVp11jTyqtwaJh8EidPJyn0kDMHXYrd6?=
 =?us-ascii?Q?/kFLbu+5fgfZOZH43PY1x0MFp0LZlx6G+UZdwFc+WuspSqtK4/pSVkk56efC?=
 =?us-ascii?Q?euEXYgWRmE3Y0JMCbPFhRaToEGu++rLhWthob4jrGcWIFrmRmUWwLUNom7EA?=
 =?us-ascii?Q?l11poD87k3ZqyTTxyexLYTOQbwURN6LUMC4WzLWYVSEEKmjTuN4JRei2xdEQ?=
 =?us-ascii?Q?S1f3VkD/D/JlmrC/rthdp4eLL5SeUU4zixYSoqKwFtAadSTQ1CpVfav/fQpb?=
 =?us-ascii?Q?vFs+xeDAFy9FrqFnwY8VYh5qLAHa5+Z6x6iG/YVU2TLMlzb4m1LOxAmMojyX?=
 =?us-ascii?Q?pmoXcOwrID5i48dEq91OiTSGiiqJVD5kply4eDdUrZ2NVbJ28k4/xW1dIRQ4?=
 =?us-ascii?Q?IPJcNj9e2Ufm+uRHFfZtuZLVfBBlEZNWBq2G8qzYAuXh/f/Khhk/fgw1W1ZR?=
 =?us-ascii?Q?0Uav/0VJVLoh1zUTEnD0Qhsux2H2toBUydi2ZleaI/Ysg5yEDxIp2Xsr5nMg?=
 =?us-ascii?Q?yVKC/kKd0uDkUyAoTVb5w5Eb+F/9mnEbeTr++Rz4N66ll7n4wiHqd0iqpIlx?=
 =?us-ascii?Q?nXNzhyrEA1T8IXNVLwa5LX1y0XV5sdjw0aANj1NO0Cl7vZLb/+UiBr1unO5U?=
 =?us-ascii?Q?4aqwKl8OyjQjYCfyqEqj99LzVroThYjGUHJby8kQykByI4p3NmeuCsaEyJvv?=
 =?us-ascii?Q?32GpVR0jLuDDIhcccKwbUemvsbif8y+PuI47nF46dtl3Eum1CmT3L7qX9O+f?=
 =?us-ascii?Q?ZnmObxoZdwzwWp5xQetMwo4rfwE0w/XGbsaOWBF1/YD2uhc8kzH77MgyCiwA?=
 =?us-ascii?Q?CTxsk3OJirbs53O0BY3+Ga/0vHTex7wNO5QZa421YyOipmHbpq8l1BbHBBQa?=
 =?us-ascii?Q?fmdVFG5EvwI8Zpeb6qWVLz9QCrzfZtkXdGoXgfDqkSKd97Wa98ltWkkkSVHY?=
 =?us-ascii?Q?W2XONAEISR8FvAJSRiIXkUtYni/AzeHROck7ldlYp/Y6VZBEnePMzY0zehSt?=
 =?us-ascii?Q?wHfSH/nW7jaNmvwp9rTdOxPjJNcJvnwqMfRSYZFWz3rkEUQSrtLGdKYsQFCf?=
 =?us-ascii?Q?ZBRWKw1bx+mR6L7LS2QB5h4v+RgZFWuvTaAqDyhdyDLQnwvPOnkMN/s8KWHS?=
 =?us-ascii?Q?Fck+wtx8jC7NniDt/5OlcKXbL5uP3O4ukjlM6oprn6eeus0wUd6LHHHhSJ97?=
 =?us-ascii?Q?S2fLZEmawHDCLSA4uEYSj+VUFDcUT/uNpAoEteC3O4jLr5MfKev2hqKDxev6?=
 =?us-ascii?Q?ThYo95+EOT1+OJlaCbvsLaWMvFOQ9CGGlGhzFZPrG4H6yYge4UboDn7lTPLB?=
 =?us-ascii?Q?ads/LfoC5yBYD1XwH4LWQeaX2vFdcilft8VWsX6X76H2RbqpkoNrTbNPtm+B?=
 =?us-ascii?Q?CXbU1rZ1rA6fQBVapC0odSj9zP5ZDnU1D/Q7zQKLK6uiXK+XT4YcWTWBz1sc?=
 =?us-ascii?Q?Ke1UdwIJsTA+2EH1JgjFHz8SpVKSy7qO8WwB8IhG+1CNQ7Y/J3mE25YAVLIE?=
 =?us-ascii?Q?2rtuDWw8HnZThBp2DuJar9w3qa9JP2pl/C1qp/yTUR5YQ0lsI+V5Ta/uESFK?=
 =?us-ascii?Q?cNa0PP1U7njJ2nddBXGwOH1mrntIq6KUDrZDHs7I?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5609cb-d598-4619-27c0-08dbe588a90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 03:12:11.7014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgRd9bNX+3CkvPyayBt3lchsW3cQO9jhXjMiAfqlPDWtEfTLyEQb8VoK+OxhvRLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1APH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 15, 2023 11:04
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; =
Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Don't send unload message for reset

No need to notify about unload during reset. Also remove the FW version
check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index b51cd9e50e64..d431553ad8b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1500,7 +1500,7 @@ static int smu_v13_0_6_register_irq_handler(struct sm=
u_context *smu)

 static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 {
-       if (smu->smc_fw_version <=3D 0x553500)
+       if (amdgpu_in_reset(smu->adev))
                 return 0;

         dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
--
2.25.1


--_000_PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1APH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 15, 2023 11:04<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com=
&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Don't send unload message for reset
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">No need to notify about unload during reset. Also =
remove the FW version<br>
check.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index b51cd9e50e64..d431553ad8b8 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -1500,7 +1500,7 @@ static int smu_v13_0_6_register_irq_handler(struct sm=
u_context *smu)<br>
&nbsp;<br>
&nbsp;static int smu_v13_0_6_notify_unload(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt;=3D 0x=
553500)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(smu-&gt;adev))<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;adev-&gt;d=
ev, &quot;Notify PMFW about driver unload&quot;);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1APH7PR12MB5997namp_--

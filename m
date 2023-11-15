Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9070AC47071
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 03:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A02910E38C;
	Wed, 15 Nov 2023 03:23:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2144C10E38C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 03:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdbVqZE7wUH1iBFgjuPF2PY1M9505KDwckqXGfYAd09fqTN3UEgiTBoVUIt9l6m7gwqoeFias5xi42XmJIZSTQddq2FiE2GwChyDb+ew0xuYabPTV94j5gcEP6sHr5bBrZG6F2anbiGocsPiVU1yRAZhUR6Yw32iOEuKB83WpyJ7Q4gfojcnXFC76r9Ny25iOzeV3bwsTnwJCWaPScr8Nh8nTgLruSa7BW3bS+puOl6kCvPM6vcMNOQl0DGpFMjs+y/FDGGGIE+ObdCemzAXsEvR6C3dBLikbDUMSAPJw6H/Bqy+FmYGCOs6s3Lgvi9dxUI+gf7q7rgNairF1ciM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGGI/8PJ390+0TBVCvCoWr+GfhpRVChRHUrOfXmJ+/4=;
 b=L9iekEOShizF4+1C4M6VDGroh8LDvc0EHrWF/pNByhHt0hTT2Dg4xw9hMajp6xHZfMRCodWMUjoV4BuJVFNTgFtb/uJldCiExQ3hEI/gmoiTzj+KskIfzkOC/VjKga8p2ACq+aOjUNzCQQvkcN0Nt6c8ScSaixwaOp7TpSqiyxMI8X5pUtInpezC3BhtWe6lXKfc7Ui46dlztu407L4AXFKurqnNRNy0uWJuKiej/DucgPJzmSIk6utCkf2elqmjq58KVtt62aYK6zP/NvBLChpdPJpXm55R9SCMCRMYw3kTcMEPhd38stBB5HBRNwfDlgpCng8XQvyCbctRIJU+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGGI/8PJ390+0TBVCvCoWr+GfhpRVChRHUrOfXmJ+/4=;
 b=43P0qM950+U5I2OvNAoXZsE1rftcR/aRV+Urd7si/3GacoKKklxw9E1FSWBktK7hZN6S7RzIUT6EXAFF2TvADwAKCJQyrvZgyAqC9iZzV3lHBWjZDlqjxJuYZ9f59vR6AqXm8MKW/y5Pg6gnUQyg5h/lAL1cSNogUKEO4Uvc3K8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 03:23:50 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 03:23:49 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Don't send unload message for reset
Thread-Topic: [PATCH] drm/amd/pm: Don't send unload message for reset
Thread-Index: AQHaF3B92rBORHsWPkaGYjd+41a5lLB6tCuAgAADIsA=
Date: Wed, 15 Nov 2023 03:23:49 +0000
Message-ID: <DS7PR12MB6071719BDDC8F6A2C44B3E258EB1A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231115030425.613561-1-lijo.lazar@amd.com>
 <PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997FA8F2E6CC3968AEF5EB882B1A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-15T03:10:37.3816342Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB7549:EE_
x-ms-office365-filtering-correlation-id: 71969c34-5501-4f90-6e0b-08dbe58a490e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrGa0r3P7RGtjT8VtYy9nXwrAtEFyYsDCu1gIuqqjrz/NfwL3ioXixngJmzXkfmX7sNH3RSnDUFBDTS87NLD9RJDQ8nYXRo8DEa2S6Tg4NMqCP4Huuv+MFh9q3opPcevOiv4i0DOPKZdBH8291ouKDYqoHwbCE9cN0SHvlJSzOA3H9ePy9o0HNTJiAtH1CF3XzbpNZjLBb+o8vMOhAvjrtNrb69EuVYurKN3F20VNBYmjYzOBbhafvdLwi8mR39OPuY8G18uBssj9pRYIHFTxp+IUf0zb0/OxvACf9EQCwW0hGCnixer+yO5owovQeCeA/012sLXilvNLtEQgdou+dNhrmXXkQZOLYDzi3Fze4hVlEBs8qOJH7+vKcQjUPrJoPVzRSvbodeWgLfu3eEOEYtBOIPjop3X2lsQ0bxwGjg+s2siKaJX5rLGCZLu1q/AR07AGMJ32no6ZZrhxjx252BtJYQnBzeY6JQ/4J3pVCpzNIuiPbppmQFcAC0euGULe482V2XRjrbvB7FMXUMw0XTDP3nNwS5zZ00vuZlX3Ui+hAozalKpciSaJN0r54mMosTAWT2sJGKPd8UdZGG3azpt9+6lH6PgvS8C5fzIkvYcQyRg5sPvvtCqpcdw1/11
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(478600001)(122000001)(9686003)(110136005)(55016003)(38100700002)(41300700001)(53546011)(71200400001)(7696005)(6506007)(26005)(8936002)(316002)(8676002)(54906003)(4326008)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007)(52536014)(86362001)(5660300002)(15650500001)(33656002)(2906002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FNlFhTQwTqnEP5Q2154uVEr0LTNSwiOq/TX9i1+rroB72HG0gRVOe+7VrucN?=
 =?us-ascii?Q?Vz/439oDHQVjepDZF+Le60jIhL6mhfiW9V1lT0P9ci57U1+nuYPwKMj1JPII?=
 =?us-ascii?Q?k3+XiHoaooADp+DNvT4ufmU1wFJ2fymsPTQl5RlEVmTx+zbWAzn33/szm62e?=
 =?us-ascii?Q?FGO37Kiy8ftW0rcdvP5C14POkWvGHfz1ZexzpwpQSXfTofvv1y2FS64Qe9sv?=
 =?us-ascii?Q?+SN4QBvYqZwiC5vgOIHgXEz3hWmHHV7HI0sDtBSMWu4svyKcwhrAaNZkjds3?=
 =?us-ascii?Q?kWpu0bG7hOGm3MhVT999LJuVLR7i+h632e4nDpmiv+iyp1OLJvJ0b9wx4HVX?=
 =?us-ascii?Q?3/8dZAa+g/Oz1c4uT3shD1duXhmP3k7Z345rG6KeGR7GuMwxl6hlZzeSrNXE?=
 =?us-ascii?Q?4UuQieYlxVafHcHAq/sT/oLOIg0BE/UN4UZtIpJc7bIF8IsdYsOJMuqvqyR4?=
 =?us-ascii?Q?ETHdgBBJVJFfsWHiLRHuXBvGwahF2/6qg/B4v7vxE+EOp4wyck4UJg9hGFUs?=
 =?us-ascii?Q?NyzHR8F+X53TAc/H6qsx4TB5mUhzTYZECttDb+F/UQcN13HuofFxmMVlHqnO?=
 =?us-ascii?Q?h2hNW4OCise/TRPf6D0r+Ins4d+YuzIaq+0m8FgQNZt4DU2ReiJffjCW+3An?=
 =?us-ascii?Q?3BdaX7IOxggQvI1iigqiFjWVFQk2Ht7a9BeDw+UrX/cjlEu5GkZjB5XJnvtl?=
 =?us-ascii?Q?aXHEiE1QBiOIiZpqTDcigpYASlt2uasLMx7e1fvJSxpofIR8ceyG809EOSJK?=
 =?us-ascii?Q?NiX7IONA+VZ0b8l4A5xgoTSsgU8U9WadNmlWRrtV5zxUa4cSuK+eNKexUZeb?=
 =?us-ascii?Q?JQq2mPFGb9jJXqJzqjZyfUEfFKAXXdKYmIB3rPVHFBLIgW8IytCp7jDvrScF?=
 =?us-ascii?Q?72oxrXlyhdgo6BqEOLF2DQauv8C8h4nm8CMW7GEXK3MpSJjKSCuE6p4prfrD?=
 =?us-ascii?Q?r+AcAYfzBpEaz8rX0/yb+DgQb7C6tNO7ysa9/BhqriR42O1V5WcJJGYmoyUO?=
 =?us-ascii?Q?K62rHHFUsSuxpIVaYC7lNkpS21mHZr34FdTGjNiS9i3TcEsve5sQGbiP3RgV?=
 =?us-ascii?Q?kE+s2K7NdK5sk83fy1nBd1zvq0sdzxLT16r9Y7R0B7UK91S/iJPuW6NsGzdW?=
 =?us-ascii?Q?baSqarnEB+cBNrhDd+Xj2RadkTwxkj6FpPtW728t1UrdOEVD9ncaLWDC2Ood?=
 =?us-ascii?Q?j4NdHiwda22pLB4SMDVUQNYyBTgQig6KivUYV2m9SBCBnwN9grp85a7Ux6QT?=
 =?us-ascii?Q?XH2QjiF1FLj6U4IHgGTiK2YreErFs0IH6+OKDiVXRZKn7TQue9kx/aqGh3Ov?=
 =?us-ascii?Q?SMe+5oUTWzuou1dXkpFuRPoFcenKwXFWuZvhUi+BmqUJozOGfH1OMnY5DTyV?=
 =?us-ascii?Q?uhoqVabibal2jwXPcCPwY5hN08ozmVzRtzCbY5OooCjTGzsj+Tvrs3srKgE4?=
 =?us-ascii?Q?sw1fBJogmMPpCDPrZ8cl7Daq+8oIj6YpUhbGnqsCUp+Iw9k64zAwICDe19O/?=
 =?us-ascii?Q?hoc6ubL0a2mp4Pni/6c422FubQeJSuc7xZpLenereQtA3JD/Tq3kxQQQQyyG?=
 =?us-ascii?Q?WRAiOm+ZpxYOEfzSAOs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB6071719BDDC8F6A2C44B3E258EB1ADS7PR12MB6071namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71969c34-5501-4f90-6e0b-08dbe58a490e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 03:23:49.6982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/ETwCEgfQGM9iuJ4HmAjfEm7HVPr6FiRH0D8ndsk9tQJOWoTwE0Bgg+l8mqoRYLf3i9Yroi3BM8CPcX2vV+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS7PR12MB6071719BDDC8F6A2C44B3E258EB1ADS7PR12MB6071namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com<mailto:asad.kamal@amd.com>>

Thanks & Regards
Asad

From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, November 15, 2023 8:42 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Don't send unload message for reset


[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.co=
m>>

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Wednesday, November 15, 2023 11:04
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>; Kamal, Asad <Asad.Kamal@amd.com<mailto:Asad.Kamal@amd.com>>; Ma, Le <=
Le.Ma@amd.com<mailto:Le.Ma@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com<mailto:KevinYang.Wang@amd.com>>
Subject: [PATCH] drm/amd/pm: Don't send unload message for reset

No need to notify about unload during reset. Also remove the FW version
check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
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

--_000_DS7PR12MB6071719BDDC8F6A2C44B3E258EB1ADS7PR12MB6071namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Asad Kamal &lt;<a href=3D"mailto:asad.k=
amal@amd.com">asad.kamal@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Asad<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt; <br>
<b>Sent:</b> Wednesday, November 15, 2023 8:42 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: Don't send unload message for reset=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">Reviewed-by: Yang Wang &lt;<a href=3D"mailto:kevinya=
ng.wang@amd.com">kevinyang.wang@amd.com</a>&gt;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Kevin<o:p></o:p></p>
</div>
<div id=3D"mail-editor-reference-message-container">
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, November 15, 2023 11:04<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Kamal, Asad &lt;<a h=
ref=3D"mailto:Asad.Kamal@amd.com">Asad.Kamal@amd.com</a>&gt;;
 Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.Ma@amd.com</a>&gt;; Wang, Y=
ang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@amd=
.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Don't send unload message for reset <o:=
p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">No need to notify abo=
ut unload during reset. Also remove the FW version<br>
check.<br>
<br>
Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.la=
zar@amd.com</a>&gt;<br>
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
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS7PR12MB6071719BDDC8F6A2C44B3E258EB1ADS7PR12MB6071namp_--

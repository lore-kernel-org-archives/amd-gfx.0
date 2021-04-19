Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88124C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 09:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218DC6113C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 09:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218DC6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8DC6E1F3;
	Mon, 19 Apr 2021 09:02:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274366E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 09:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exyjr/1l2pwcbUuSTwbQ3XlmA2EbJF6b8WMTicaiXu1Z3h42fyiCopCTRm92bID0+4/oP4zYpNZtXJKQW22lqPQsqENOkdI3AtxZ27Cf44fnCMx33h1UiVhH8i2nBsU0EHAsM73cqx/M85LHiXLGVV4hTVBEhQuwQ2A7Gl3TY5ltrUO9T6QJXLrf0j3h6tl8rliRyPuq1N65g1cw+2gEbBYc1qsKOqvdRszr4ynjHu1FmUl773oIdfd2I2BrX2nZ9kHMIdwXxKlzDkGtTR3ZdI3c0eEKj4LZ3Rv0V95Gp2zrgEnr3rdbdza++AXqgc6cElzWEVrMFRHYIMRHdfn4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ97E4GdxVtoLi2hy3DTWB+ycAHJZRxxaco8yY4y6NM=;
 b=BLwi4j3o+2VfKwHXvkGzLE7AN1h0zfIqtCLgbCuYVXf51rSyYY6olzJEs5Ty5ISiqBfjs3gOgobD+tR5MuMUOnDoUeoo6r60nXIe+N/4cqZSmioOvpIMcMhRaoY+sVwqkgRKAc8nz9R8/Z1XzcQ5qpyS2H8E9dRxNT3w2+g5y3KXURVaircgGkLkceVI90QDpvK7VuN2ccsEC6s5qS3i+sRpIaBd74AFFKdi3ECIfkAje2sD7gxAiBG3Q6A/rKYLTFgLJleuIhxwWniOM8NFOTqiN10RnHQSxaNTzNGNhMW+HHLh5CkJddqBCgeJoQJg4b25QI0YZcMxSPgsPqwrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ97E4GdxVtoLi2hy3DTWB+ycAHJZRxxaco8yY4y6NM=;
 b=FoFNBlRW/1/X1ZVbnp9MMJ5WuF2DBVy/EFfCLx+gFZQ188Vgzd4SbtASQVwyqxSnu87cx4oNfMKwMqZ7PqFkR/rheHqXaT1M1yQaDqu4Kg3IrBV7al0HJjpPWoqTljinyqr3XfYBVd/OnHYYsrnhDehbzLU1gPB+e575xgcLjMg=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 09:02:27 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::8812:1cd3:be35:6bdd]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::8812:1cd3:be35:6bdd%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:02:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix GCR_GENERAL_CNTL offset for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: fix GCR_GENERAL_CNTL offset for
 dimgrey_cavefish
Thread-Index: AQHXNPih290ANTI0ekmf+eKIhn2da6q7i3PR
Date: Mon, 19 Apr 2021 09:02:27 +0000
Message-ID: <DM6PR12MB46503B320F6FCCEC17AB99F4B0499@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210419084709.4955-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210419084709.4955-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T09:02:26.548Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf7a4f51-b364-439d-7fb5-08d90311dafb
x-ms-traffictypediagnostic: DM6PR12MB4059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40593182FB704D18A9331A57B0499@DM6PR12MB4059.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xolLQvPOmiCxS95lXVbHOkP44nkzVX+ZHS/376NXt5pt0CcnE8oeNXN+/DwhPRDptfPCZVx4C54OFsSk98ZtM9/VQJrDVg2+9Rr6WRpOhWY6CYxuDw13iiUn20bxqfDzFUtrtU6F8aXT0Nj+Jn2l7z+u3rMhIHJipOY2GEFJS67zoQCkFzFeeh16f0gpZRK6m1AmUMF5e9iSBBWzzcZNXrbC8KmgexH3UXrGqXHKq8vtN8Ztf0CHIh2IMLFqonvtS30JWE+1+53lf9DId2ZgyKUiA08lXFXw9T7FJjvM1dqzgTOZjLecRYT3Y2gFpJUTe4bsZTPJc36tuNmJNvc/fp/RcENXntRC5o6HKdKZk2EdPAeo5yFgtzEwklCQIhhhUmkgrj2AEORfGgkUgIMl9YJEgNKXiWxn2niVW1vNyVKle6yWm769QLbCSvXInXR0R2eXIbRu0sVRlFwKTOMndEluNOeAk7K+pbII/lbUy6wAFuGl3eWCLNT9Yz6dseblNMyUKKbIdk39+XUdwjiW5n5QHq0QK96ClerlARjN5SEkma7wjo0iNOIMxIWtvP1XHAcUata7Kry4+H0DzeKF7f/x4fe89vJSEE6dmnXaei4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(6506007)(66556008)(53546011)(7696005)(478600001)(33656002)(64756008)(66476007)(83380400001)(86362001)(66946007)(76116006)(19627405001)(26005)(66446008)(91956017)(186003)(71200400001)(8676002)(2906002)(8936002)(4326008)(9686003)(316002)(110136005)(38100700002)(122000001)(5660300002)(52536014)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5GMvY2d09iQ7nGs/1R8ghBCmV8nZwRSh0G/WU8OyxIonPtJR4ANRYRDFCeLD?=
 =?us-ascii?Q?SedAVwVkgtjpgJskF+hU/aOOvgJFqgoptQal6Jy4EAIIdvM6GJfGX8SZk1Wf?=
 =?us-ascii?Q?qLoS8h+/+tq+K+gErid4QWwGjAy4odf58FBBbKtdq1RvWm0q7xUwfqDUyEdr?=
 =?us-ascii?Q?J0vVYDkRLfp1IqMe7pPTjRgOceM3xmvhfp8si7dwAXQbs2Amv/gMPAad9mVx?=
 =?us-ascii?Q?lsKeoYS2MAhsblkhFnkwtX/YjH7msIYc3EDzGU5InMrLPqwFDK7Z9vFdXBm8?=
 =?us-ascii?Q?YetvyeL3su+p+lHLAPsggOBQKSs98tO5vmAh0E8+NnB4CEVGp3CSa5j1BDOx?=
 =?us-ascii?Q?S6Y0D/qzJy+UTimVj38h2LSvixMiYkn3egsEZTNTE/brsbGSIR4Q46gEdsIj?=
 =?us-ascii?Q?5C5c5HceCtdroPx7T6DjgAMSPuawc83bPnwG+XLJ0oLaviQsrIZLdYwfrOEp?=
 =?us-ascii?Q?2D8I51jYEyppbmi/b1SOP3x2K2zW6q/YuncI1kbikyQA9Czb3IaDT5YhSmph?=
 =?us-ascii?Q?q1gUIVZ4XGEE1hTXhQIp6zQK364gVVqLA8QkdeAaVsl4fPe8fIO9gCKxAtS6?=
 =?us-ascii?Q?7Aq0eBWW2y/VxuyI1V+P0CFKB5dDH+78RMEfXkiZwmYSlkWazOHtAahSgIeX?=
 =?us-ascii?Q?Q0iOImq337/OzvwuoYZDebTYzlfWeeJkgqtJnLvpE/dFYD/uQmkzMpo2LLwB?=
 =?us-ascii?Q?qrU1lPwH4KPJDNhVyqYQlCP74rl+Y9n7ZIpO7jjF58RW/baNUkUH7T+ETCUY?=
 =?us-ascii?Q?Ep61ZKe7SptP1CVjtFKH6keffWpPSyJKcN7YhOFy5AsN/HHgmcw1jEqdLtcI?=
 =?us-ascii?Q?N/olRJuI392HwrXNrS1+fLwFj62Wkn6zD0GHTDz1SwFRyCFDEhUTxbRMpWvt?=
 =?us-ascii?Q?SV/dYCUU3SgGF9oSpJCR96aF3jJCH48MHUFyUmzfGwlou5nWkzRKsJyrOrmm?=
 =?us-ascii?Q?3OQIrGArVRsO7FnWzsvuYFQ6eNuOiOkIcovmnHI7XQhgb41ItMKEvrcGY/XQ?=
 =?us-ascii?Q?cQ0jmo9UuZZ5IZz3dmOwLbW3aKZBF97Orgn7umS5yXzikOhvjMhpZS3i+9qu?=
 =?us-ascii?Q?AM/xYIQieZPh82SGbvG7iMs0T32TZ8KmqaAZhzalThkoH0F3WVEIEmsWp6Fo?=
 =?us-ascii?Q?Ky7tnucyWNvJ7Mc+0SvPnaA7LbEe1PS6IRW3DsdZb1knFs8137JtCgOGbpM8?=
 =?us-ascii?Q?+HVeTys1c/mpS1yFiq619ITZsutwyFqFqjASuIqZJdaG2r1Gf9v2382QuQ7f?=
 =?us-ascii?Q?vgzTEF0kNla7cSjEQvBgH0TEZS9T4M4LbUO8SBBH4w9FK9q74S7L1rg+I7+K?=
 =?us-ascii?Q?P0g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7a4f51-b364-439d-7fb5-08d90311dafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:02:27.1459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOSJX3o/tY0+9Ir0r9E/R09IduCMIwLim8i7Gl82IS0RpE6YLgs/qbAKilgKXkxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>
Content-Type: multipart/mixed; boundary="===============0890143094=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0890143094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB46503B320F6FCCEC17AB99F4B0499DM6PR12MB4650namp_"

--_000_DM6PR12MB46503B320F6FCCEC17AB99F4B0499DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Monday, April 19, 2021 4:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Chen, Jia=
nsong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey_cavefi=
sh

dimgrey_cavefish has similar gc_10_3 ip with sienna_cichlid,
so follow its registers offset setting.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I2c8f1022c0b4c5baf70d09ec99b7b2ca8da36bba
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 85a6a10e048f..49fd10a15707 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3377,7 +3377,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3_4[] =3D
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c0=
00),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0x00000280, 0x00000280)=
,
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0x07800000, 0x00800000)=
,
-       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x00001d00, 0x000=
00500),
+       SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x=
00001d00, 0x00000500),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003c0000, 0x00280400=
),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, =
0xffffffcf),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, =
0xffffffcf),
--
2.25.1


--_000_DM6PR12MB46503B320F6FCCEC17AB99F4B0499DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:black;font-size:12pt;font-family:Calibri,sans-serif;ba=
ckground-color:white">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1=
@amd.com" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApp=
licable" data-linkindex=3D"0">tao.zhou1@amd.com</a>&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jiansong Chen &lt;Jia=
nsong.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, April 19, 2021 4:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Gui, Jack &lt;Jack.Gui@amd=
.com&gt;; Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey=
_cavefish</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">dimgrey_cavefish has similar gc_10_3 ip with sienn=
a_cichlid,<br>
so follow its registers offset setting.<br>
<br>
Signed-off-by: Jiansong Chen &lt;Jiansong.Chen@amd.com&gt;<br>
Change-Id: I2c8f1022c0b4c5baf70d09ec99b7b2ca8da36bba<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 85a6a10e048f..49fd10a15707 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3377,7 +3377,7 @@ static const struct soc15_reg_golden golden_settings_=
gc_10_3_4[] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmDB_DEBUG3, 0x00000280, 0x00000280),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmDB_DEBUG4, 0x07800000, 0x00800000),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_G=
ENERAL_CNTL, 0x00001d00, 0x00000500),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_G=
ENERAL_CNTL_Sienna_Cichlid, 0x00001d00, 0x00000500),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGE_PC_CNTL, 0x003c0000, 0x00280400),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_GOLDEN_VALUE(GC,=
 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46503B320F6FCCEC17AB99F4B0499DM6PR12MB4650namp_--

--===============0890143094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0890143094==--

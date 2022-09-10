Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DD1C6FA82
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Sep 2022 02:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3529C10E283;
	Sat, 10 Sep 2022 02:27:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0610E27E
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Sep 2022 02:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNYIe/MR2ETBUeHAwRHv7Ea+oCs7bJJ3wbAyGIpnl4TvhkBAqbtyvd5mbGzHABCEZCoMVRC7iw5QwqmmTsm7KUkwT/A6zx5XFPQhWfzS9A8VCs3P01rcgNytelUmY9Uq3TB2tlOzlYGyqPE0GDkh5f8d2t7xDqjtNDr+gSriRzW1UD6Xkr3QGBh27mcTPPu8XxBV0lRb5CUHRL3uHkNzftbXJ0W5htZJwB1VjK74ftTnhmjXksDzBwowQ6Senb+k6o2vPIARnkS21IEsO+tjSGVHpdHc66aNNdrD4Awxoinlmf5CAUDNOBeBYvtuOari8YXgysbamrnJR919/uRqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIcL10u8dIY+GMjla0rVRnH7SsDTB66FGezEF9778CI=;
 b=UMfb2X53XTWkYbISfMAhbz0TO5rwHI9aZUPu+xmrON4y+x/UbgiNq1fhXci26cEk22NfR44skx3tgqsXl/QzTiO75weL7k2yOoTKoswtOTM57GFf2JdV9AkGvu/YQ9R8XCyXNYcv6giNHE39fsgCKmTPnDBHIEs04PFyRY1RCWAwsf5Io8Mp0wmWadZJER+TH2QWgIQq/P2j1M7jg7+aguuj3OPpejaJiJiklSUBpmxwV1HJEH7gdUCOxbaNlzRW0k4+EYypsQCPcWF9A9OuIMOwYKdfPWDVWswt/k/It461ifOVNFtHL/ultEgtJLKXx2A4noeCkuTHwJ3llNOVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIcL10u8dIY+GMjla0rVRnH7SsDTB66FGezEF9778CI=;
 b=HzHyOm7xrmWYx2hawY/yyhA9g3pAXnP15wiuv6w5Mp2dBMwLa+h47Nv2VTvG/PJ0R7tLRbW/98Sv+F1WF3OUrunUbE6ISaETBxPTkKirXgw5KJ8+QzUQ0r4cxaTgjcKukNhonJxY3JqfaPl44I49z0Gx+TKzqoLmBhD0efIX+e4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Sat, 10 Sep 2022 02:27:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.021; Sat, 10 Sep 2022
 02:27:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add EEPROM I2C address for smu v13_0_0
Thread-Topic: [PATCH] drm/amdgpu: Add EEPROM I2C address for smu v13_0_0
Thread-Index: AQHYxJ3mvmDnuWfKPEyAPzedL+nzC63X8E89
Date: Sat, 10 Sep 2022 02:27:05 +0000
Message-ID: <BN9PR12MB525717E20553C1151657E1A4FC429@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909224516.5738-1-candice.li@amd.com>
In-Reply-To: <20220909224516.5738-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-10T02:26:45.1783663Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: 1fc32101-f65a-4237-cb49-08da92d3f3d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FshF+c54hLEgAdLEVrzL7AWTln6/sC56Sm4qwxBTiJIeKkFdaD2HxNT0GJv48oEA5MRdM3vGUMGgS0pYF6YSGbnhnqXHy0Aruy+9R0UMJuBKYe3Oq2J6k7/Z1rlPPc8k7m9q87Tvr1rxDmMzpvOQQSFj0MdbuqDXIF6t1CyYpc4ev+JygD78AU2xoZLsI6/KYfdXxPudrUQ4a1Gjo77DY4yIK2VXqSdBc4WrkcWFZwZHXdJw2PXNdDmxP32pkl9G6SJVG+ZydA8qSiAmEqUGBhXD4p6gPB/G5fxPwwupT2zCVMQ2hEGsI6Q0Ejtbnym2rBO+nr0YP1rkNe73fQS0lhZFZDFJ6anzi2x6MoulQFz94u6pXUS9JWtnPu9TecMX/PJe2kawo5UGp+0QQUEq4iGaHMQYWv102e3RCs9zO8WwZNwyuXhPSxFzaybWx5udfnc1GjvyZDDtkqmQWmcUjkPwmcfXUg2uuJh6eo+KBrHX3/6Q344tAf0CIa/qPIFBf9kCMih/lv96tGJejxrgZfztAU0rR066mwzvE3+97IMEf43uPP/trnl9JFEp+ATObUTQ53ZOgDjpxE7MFLxg0jR6qooV91kI41O8dgsm8hovg9exWa3uwj4wIIZN8VL5y5BvV1rvQwEBhTx2ADWjc+o21Nk9qnOShkYcJaJzfDdcWt+/5c4kg6xN/spRNm+ByQs5AYuBZIw98nM01pxUErjTJYG9rqVxwEVY8pV90u3PppCsn9QGeFhqHSaAN5kwuLhOvGQTi0CHXZBYs7fzZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(122000001)(110136005)(38100700002)(33656002)(53546011)(26005)(6506007)(7696005)(9686003)(4326008)(66446008)(186003)(8676002)(38070700005)(64756008)(66556008)(5660300002)(55016003)(8936002)(478600001)(2906002)(41300700001)(71200400001)(52536014)(76116006)(91956017)(86362001)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/WTr+owQj1J1EL44ewENT7J6CQvbP5FqAmn4ZlTW6FzpNxYBUVAhkBwe/C2?=
 =?us-ascii?Q?VuVPaS/4V7iWewJp6/ssBHfmZbJYSnJghgk7DS19qVEqqmKJxAdKqarLSIwQ?=
 =?us-ascii?Q?mOP03Bxyq1ySfXWFJoVvoYq09TAowiAwsdGUHaFG+A0scAV+RgaLyM+LN8a6?=
 =?us-ascii?Q?La1j9Lff4uwflCFQoRlhnEc3npesHjb38J7NHyIe3zGgJ9xMHQFBTuwGdM2k?=
 =?us-ascii?Q?2c18ihGOg04S3bCvAigxWAJp3JZPHeHtJhy+wMZqygTicQbi+DfUd7+fBQHO?=
 =?us-ascii?Q?tsDLbq4Q+0EfjzHCI+mHPMheVjuWHTgsZJFdc/3dfsEfsoVAgk/XLcTrAp3H?=
 =?us-ascii?Q?K1UOuTAaF0KMGwmGJIxNRWFuh6IhtsFxIPBoQRc6Uc4agRMDmNL8iTokAphv?=
 =?us-ascii?Q?790CYOoV1aYeVLbH35ivyEbJboulCskYCqVSIf6gMAMRI/NPq7iNUOzgtbMd?=
 =?us-ascii?Q?fNKFXFzfML288zBa1dW8Np1JmrS0s+Ba4h4inf6PGtrQXXaa9r0qLX8Gz0OM?=
 =?us-ascii?Q?IlvlR6ZCOv19NB98uK19LeM3bXC3MJpOjRUDyEnjEmZ1oYNg3lnSr19LHUWG?=
 =?us-ascii?Q?027JbTctrdh6Fega4/79KEcvjrTDeYyeIQg8uTs47EFmQRWOHEz03ihoFUqj?=
 =?us-ascii?Q?Q8CqmZBpsADaM4Q5q6rq5wbtNOjGP/HaOgT2IS/2mCAt5Z//kyL6yKywjDfQ?=
 =?us-ascii?Q?GFJ9HIfKKRNryY1vdo65h0paOs9mGuHWZ9FtVeprsFuNXficU5A8Qo4tvYTN?=
 =?us-ascii?Q?QIQOdOk9Oi0iNVUKo7+yXOLr31vqhjIOEoIzFY1u/3ePFjnmEJqXpk8cD3HH?=
 =?us-ascii?Q?73kkhN0kY/x6zzL2TvOF506JjlNgYknZF+F10NHWldUfCBpvUautPmbZ1jb8?=
 =?us-ascii?Q?eIUYxCDzeYu0zU43tnkz589LWX60Rv3VXFI373rdu06iHUU6SEc5HGa7eg+q?=
 =?us-ascii?Q?ej9qgA0c2qKxSv5dCL1U40YSdt1m5OqSHJsEjEEVbHchxSUAlODLRBCD2QCk?=
 =?us-ascii?Q?onBsApm9MptAwJiEngStg66eBJdJMoxZBXEFdEkCrr+xqziw9kVCUt6PUgdX?=
 =?us-ascii?Q?Vv/rv+9Jxon+7pFB25jcE7PYPuZQUkYNvOQ5np6s8pIRmSuF2BkzfPq1LsCq?=
 =?us-ascii?Q?lsQvzHHQi/wV+We3F8ttFiIdUuT/kfRWQbr4/SWbY6AN/19+TwC3SMrsaMsE?=
 =?us-ascii?Q?JgAjTf3K9qeedXYAl7VnAdUrOmcjaXaLm6wWmqbRiwqKCuOf7Qu4V5i50ciG?=
 =?us-ascii?Q?+894xeVhJrVtkLcqkv/S0jylONWfr9qyuwhpw/Fwixb4naFAowIXvK87cPLP?=
 =?us-ascii?Q?pAwJhQ+5nzUdfNj7Ss7zAUpyHOXeF7IAJqvkrlh1lijlQdbitBwXnDr+FZKT?=
 =?us-ascii?Q?qbv3UlXzByTNe9Zh72QtHLIQw3l6zs4da0T8Y/T4ui8BPQRACEKiBwUVtfCB?=
 =?us-ascii?Q?rqiwosay0bOFOCMloqxaj40wIP2xqMrVM3NK6HyiDJ4uVxb9tddWSfhC4OVE?=
 =?us-ascii?Q?p9gyE5tVc0xCcShlOH2f5O6K0UjqxCKdyJLHM9Ant6YVYWrm0cBpy+AkjXJy?=
 =?us-ascii?Q?ub0r6XNSOsxXGF4qMpVnFF3wedn3inUPmgZxRkli2nFhXEO0+xRVxRzEwpkG?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525717E20553C1151657E1A4FC429BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc32101-f65a-4237-cb49-08da92d3f3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 02:27:05.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9Ed5WoDikZsWe+qy/naPhaViL6Gl5OQskaUGA7EEx/K2Xb5QjoOEpdLJxB9WT5FGrUwzMvI654DxcrCqIzKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB525717E20553C1151657E1A4FC429BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <Candice.Li@amd.com>
Date: Saturday, September 10, 2022 at 06:45
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Add EEPROM I2C address for smu v13_0_0
Set correct EEPROM I2C address for smu v13_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index c4283987bb1e89..84c241b9a2a133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -38,6 +38,7 @@
 #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
 #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
 #define EEPROM_I2C_MADDR_ALDEBARAN      0x0
+#define EEPROM_I2C_MADDR_SMU_13_0_0     (0x54UL << 16)

 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -156,6 +157,15 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device=
 *adev,
                 return false;
         }

+       switch (adev->ip_versions[MP1_HWIP][0]) {
+       case IP_VERSION(13, 0, 0):
+               control->i2c_address =3D EEPROM_I2C_MADDR_SMU_13_0_0;
+               break;
+
+       default:
+               break;
+       }
+
         return true;
 }

--
2.17.1

--_000_BN9PR12MB525717E20553C1151657E1A4FC429BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;Candice.Li@a=
md.com&gt;<br>
<b>Date: </b>Saturday, September 10, 2022 at 06:45<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: Add EEPROM I2C address for smu v13_0_0<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Set correct EEPROM I2C address for smu v13_0_0.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++<br>
&nbsp;1 file changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index c4283987bb1e89..84c241b9a2a133 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -38,6 +38,7 @@<br>
&nbsp;#define EEPROM_I2C_MADDR_ARCTURUS_D342&nbsp; 0x0<br>
&nbsp;#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0<br>
&nbsp;#define EEPROM_I2C_MADDR_ALDEBARAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<=
br>
+#define EEPROM_I2C_MADDR_SMU_13_0_0&nbsp;&nbsp;&nbsp;&nbsp; (0x54UL &lt;&l=
t; 16)<br>
&nbsp;<br>
&nbsp;/*<br>
&nbsp; * The 2 macros bellow represent the actual size in bytes that<br>
@@ -156,6 +157,15 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; control-&gt;i2c_address =3D EEPROM_I2C_MADDR_SMU_13_0_0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525717E20553C1151657E1A4FC429BN9PR12MB5257namp_--

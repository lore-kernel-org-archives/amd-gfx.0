Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E076C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 03:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3015210E4CF;
	Thu, 18 May 2023 03:07:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3733310E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 03:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCzFchSbgQFbcAYfbP0ctUBPO2Ws5YFX9BvQCN9wWaoQ5fIZnAdsnjDt4tkFoQCTZXwEgJfH+tsdHqLTv8/zbxIkrVO0xFtU+/108RH5SVuJjfhjC7omfoJ0o2UFjLM46UWyVcITBfQVb/BhSzbkB6WVN7WwJE7ogwzGxq0C5FL47GGzmI4JD7VasFzW3r0et0/4gbQ83ATdpN/fr6ilwhC5vbmCwWan601K2SCfCgEJiLf4R6/mV9sizNW5e5wRq5DmBdUS0AhRj6yjOEq/WaL2KJ42Lyd09bhkeREThrA02jOZIsrpNvrQaiGuTYyeGWN11CQsKlhN+YA5zkNWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxaODyWlPzN9TQrXigOS2z2gC+6gNygeJz56c7YrkRk=;
 b=M1KEuqw9O1ZtlVwupRIPPKxwDH5xn3rqV3TM2/b/FCbv7PNPevrSOXbzmFsD5aSCn/e11VMDuNWp1MLWoULHNzVA3bwp9Kla7NC7hEl4kRv0MZmOaog6Wuq126rjUxQXgWUoqxlyNOr1KYdl7g0hCUsYf5Qtfjh/84Pk2oNMaQElCX3qc3CRPDgKY4NdH/Ij5vm5G7gO13Z3eYj7HI64lEKamFcD5UWRTWWXNgqnGx/PzT9FnxbZyDukZk1Lp0ap/fyebczdTWyTpCj8J38V7dgPR3mxeTVU1syzyflwe1L1YcRUmfXrycJMSKqZMjMrj4XzjmJafmd7pPUDHN5hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxaODyWlPzN9TQrXigOS2z2gC+6gNygeJz56c7YrkRk=;
 b=RiZsqHDodypNe/Chphx++zw/XW/fQDBHm1Qq1TA53LSUQ6bsGTAsARnt7uCayVt6RcPpy1H71tgLHljIq1JdfWPwurm/4Nny3UdyZXdaUXIR3BHp19IadW/m6hGKntdpbQI4UCdGfBgbUgUpooypqJhG6jrOjFz+Z7S/jfLogQU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Thu, 18 May
 2023 03:07:33 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a619:b94c:f2d7:26a3]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a619:b94c:f2d7:26a3%3]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 03:07:32 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Aaron"
 <Aaron.Liu@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: [patch] drm/amdgpu: don't enable secure display on incompatible
 platforms
Thread-Topic: [patch] drm/amdgpu: don't enable secure display on incompatible
 platforms
Thread-Index: AdmJNeJwSbqQpGX4RjC+tCH01Vjf8A==
Date: Thu, 18 May 2023 03:07:32 +0000
Message-ID: <DM4PR12MB5152890B7B1FF6D586223AB6E37F9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-18T03:07:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae4d5803-206b-477e-8525-7fc6d0780360;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-18T03:07:31Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9bc06b06-8028-48b7-8df3-783b7bf24857
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ2PR12MB8134:EE_
x-ms-office365-filtering-correlation-id: 82eef21a-6b6e-44b7-381e-08db574d0612
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bXDDe7ePc9OzxeJ2pnWANE43kgl525vYyeD3GnmHs2FpL3iqu/ahiJNy3hTSN6bgkxM+LFPm3EbsqdnosEUG86/muAzAYYLdDSzp2DIZW7uHlhj1jgdu1MFsDqiLo2cSnezdVn942Y3G7N4MqEbEyYiizG5oekfkioHuHI1JRy8qhdyqNEYEdwrfogq6gEN0sn9Xvtl6Z9ZzeXwhBoKzkHpIT+KR4cDU9OoJFX0FD/oLicLCj7zUVLO3EmVeaFwllTJs7/J56vrd6UmdW+KLluChDWL//GKrLGdexn8bkGvdj96Dh6/wN3SMNMQhg6xkNLcN8YxMzQ5auZNDLP4NS3DJy88VgMtPnJxZCOqlbOx+is/Ts7U9K+URXj1f9kMHJRMen/iRbVIbmqW9vex9J9Euf8EqmOg+OmX2aWySGHZDb6h1hIRaBaPaw1vd9vVl8idqSzE/wpYiM6xcPbia8RcVDQh4FkDdr95Q5/W+MjCu9yvSaPEem4e4gb5PijwJX1niFlvPpDeOP1P+rmvU+m5QIR5NAY987e0Hn/kt4yxGU3+L6BQBtZRWz95i4UQlfSEs9MC/lXMSuZsWhmi+VqNWJqPYtQVwHTv+/fFaIidbelxgbF0V2CRBBnK275D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(71200400001)(83380400001)(41300700001)(2906002)(7696005)(122000001)(66556008)(316002)(66446008)(4326008)(76116006)(6636002)(64756008)(66476007)(478600001)(54906003)(38070700005)(86362001)(38100700002)(55016003)(66946007)(9686003)(26005)(6506007)(52536014)(5660300002)(186003)(33656002)(8676002)(8936002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZ/3Sp81QgNIsAFhXAP2HrY7iD2cu8amn7PP5nVVt6ayuMyj1Wt9aLUFBwT8?=
 =?us-ascii?Q?1U51UQ+Rq+bwNYOx4OkI4FH0r39DYpwI0ONXkh7DGTyCugTBQxKcsNmo8t9I?=
 =?us-ascii?Q?LgUm1At6bMmGk5+uiqTPJnhyg6BYuSRenpxsqrYUw35NZdsyIlXR8iObTR4e?=
 =?us-ascii?Q?3he9AlVDIpGKHWu+goBtuiLBtoltSmFihPzFIEOLmfEne+TtDE4RySNCQpzK?=
 =?us-ascii?Q?yBBP+zLbt/RCMU9/9c5QwyOceKtM5dLQ6pgILD/qVLdRZrYxxMN2hoTtl4V3?=
 =?us-ascii?Q?i7JuziK8RBS1sRQPTUdhz2KC+gTa+GCf3bkMEJSf+lbMSB74TSzQ2rur1ArQ?=
 =?us-ascii?Q?RULEu9OJnQqw/BnZtf39CSEF4Ljawcu41+8DkNCEpxORFixi5rt7eC2f1966?=
 =?us-ascii?Q?1TsTMauwlqRIMWO5pY382ru9yxioyzCYMdrpR9+lCEgMM6uHKvpck2iNgyar?=
 =?us-ascii?Q?6jp/zV2FTY24T4IE0EU7vYtuR/YlVXMXZbxJ0C7UXz5wDaDC6GOjTzNMx4VG?=
 =?us-ascii?Q?NSnC5Ib3m7x6jtpvSRz9rP6S3Q7lAO5PWedR22cqxIDvOMUJFFdkJ2fZoSif?=
 =?us-ascii?Q?My336xbZjwQtyCJKKDwXPKRhTrWHyJiUDy+7pTHZoiKuks2JjF85SruUY1GC?=
 =?us-ascii?Q?Y3yN+5vQjKJY6xLybQxzvVWxnyO+k4ozFdeeYom4phRh7KV+vmy22U4dJ7ce?=
 =?us-ascii?Q?HI1nufFoLf+z64rJiCHa5F3Q96MmGfIKuFg5bTmTFAQ7VNVsQkCejKL5I9yp?=
 =?us-ascii?Q?Y2T8BUD1a6PZ39IBR6FiikAc6cRT2veF38fusy/U6Ls0mWMdPHc6Rkbn8moX?=
 =?us-ascii?Q?jQTNihE3+f/Caqm6LbfPt3qgvZW/PqBMmUx7ipLMtnrRgwKdA933OY33gGRx?=
 =?us-ascii?Q?KyppYWczH5O8v/emQtd3AnBFPY7LomX505B1dLyMamsY2ITEKa/tk9xqg3Ew?=
 =?us-ascii?Q?i59IWXYzeQp14P7BaJBZS2Kd16We5Y/C9spHXObJWfmOD92IatQQFF+vSleH?=
 =?us-ascii?Q?jUBryFmwdCEAUbJyIvj1JANRE2NPraII+txySovBdma3Dt+CmGu74uzKmBRx?=
 =?us-ascii?Q?XaWJ/9N5CvLW/38OPEdZXCtCjXefSXavj+TxGuNbWcMJUXmWQT63zZNWU0kL?=
 =?us-ascii?Q?nw1b/8I56w0ydIE0UdiTsvB+g6jUhkihGS6fKFAy5H6a8zOIIwEuTk0XpaJT?=
 =?us-ascii?Q?neul/E0bO7rr/OdZhZBebMquy5jForlcKnFaa4gI41dHbwr56guVbg5QEJO9?=
 =?us-ascii?Q?DDFkaK3NNSM9xEZ4ZQGuRQDd2mFodmPYMi3SOmUGS2jfnDzVytZ475QOG1nN?=
 =?us-ascii?Q?NUW2Dzhlh/WvlXQaqnAr0vr40HdCaoKE7UvCYIeKETCvHZlQfBGg/OeRR3l9?=
 =?us-ascii?Q?eUI8ivHWN5OGa854uxpTKBBZ6JUxx/AxBivr9n8ILZxHvcQrEUW75tfpjsKy?=
 =?us-ascii?Q?pfK8249O9McjbM4rzsq9QsK9Rik1Xuw+e2V/n3+Ve96HT0QMJtfUzHT/Rvb2?=
 =?us-ascii?Q?qTuXiZbSgwQXDIRUmd2Aq2aO0cTMoDqN0JE8nHrvNo75v1QOO3UGYiXT+BQj?=
 =?us-ascii?Q?XjZKPgNrKeiqHdsOvmc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152890B7B1FF6D586223AB6E37F9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82eef21a-6b6e-44b7-381e-08db574d0612
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 03:07:32.8532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifXqlFOkBVYfFiyOae5fDrcuF1aR56yZ6fafvRzPnNvLMn8ErvYsWEGC20S9+xHiyoiO//5n38CuGyNzr04Tcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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
Cc: "Shavakh, Shadi" <Shadi.Shavakh@amd.com>, "Strauss,
 Andrew" <Andrew.Strauss@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5152890B7B1FF6D586223AB6E37F9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

drm/amdgpu: don't enable secure display on incompatible platforms

    [why]
    [drm] psp gfx command LOAD_TA(0x1) failed and response status is (0x7)
    [drm] psp gfx command INVOKE_CMD(0x3) failed and response status is (0x=
4)
    amdgpu 0000:04:00.0: amdgpu: Secure display: Generic Failure.

    [how]
    don't enable secure display on incompatible platforms

    Suggested-by: Aaron Liu aaron.liu@amd.com<mailto:aaron.liu@amd.com>
    Signed-off-by: Jesse zhang < jesse.zhang@amd.com<mailto:jesse.zhang@amd=
.com>>

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index e1b7fca09666..5f10883da6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -57,7 +57,13 @@ static int psp_v10_0_init_microcode(struct psp_context *=
psp)
        if (err)
                return err;

-       return psp_init_ta_microcode(psp, ucode_prefix);
+       err =3D psp_init_ta_microcode(psp, ucode_prefix);
+       if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 1, 0)) &&
+               (adev->pdev->revision =3D=3D 0xa1) &&
+               (psp->securedisplay_context.context.bin_desc.fw_version >=
=3D 0x27000008)) {
+               adev->psp.securedisplay_context.context.bin_desc.size_bytes=
 =3D 0;
+       }
+       return err;
}

--_000_DM4PR12MB5152890B7B1FF6D586223AB6E37F9DM4PR12MB5152namp_
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
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">drm/amdgpu: don't enable secure display on incompati=
ble platforms<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [why]<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [drm] psp gfx command LOAD_TA(0x1=
) failed and response status is (0x7)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [drm] psp gfx command INVOKE_CMD(=
0x3) failed and response status is (0x4)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; amdgpu 0000:04:00.0: amdgpu: Secu=
re display: Generic Failure.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; [how]<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; don't enable secure display on in=
compatible platforms<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Suggested-by: Aaron Liu <a href=
=3D"mailto:aaron.liu@amd.com">
aaron.liu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Jesse zhang &lt; <=
a href=3D"mailto:jesse.zhang@amd.com">
jesse.zhang@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c =
b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index e1b7fca09666..5f10883da6a2 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -57,7 +57,13 @@ static int psp_v10_0_init_microco=
de(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ini=
t_ta_microcode(psp, ucode_prefix);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D psp_in=
it_ta_microcode(psp, ucode_prefix);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;=
ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 1, 0)) &amp;&amp;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;revision =3D=3D 0xa1) =
&amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;securedisplay_context.context.bi=
n_desc.fw_version &gt;=3D 0x27000008)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.securedisplay_context.contex=
t.bin_desc.size_bytes =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<o:=
p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5152890B7B1FF6D586223AB6E37F9DM4PR12MB5152namp_--

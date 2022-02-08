Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C32C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A19810E60E;
	Tue,  8 Feb 2022 14:46:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B0B895C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 14:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu21HlB3K5x/AyxG10qbDHQzfIIgQ4YxAOZof/Vd/N5j7NjtzU2X9x+eRmN/JbsdKOxL6buQScuTi+8N11oVTF7xY35xcywKjDOlzFBRb+NtvUjAHDwKrl8+uTQ6k/petjUpBWDYWR8xwtsHX6Fze3vmedEj7eOTEv6EvRFp931VPqYuU/Ffg7BakKbXVLea4Xp/k8+jGc7KVqqs/T4gXB6BxkkVTSxCMysIuJituiowiC00+EcLlvnUqDtgGjXZR7+2Ukn6YeVo+ZmQRvCb8gY0NXjq0YE3idNESbEwfizaVd7i7tzH1qNyUCvUrlA7kGEcbWnRPFP1QT/l1iSu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5q1+UsTisEwIDmNbqWRnlyLmQDZe+1xNqBcyjaUAEQ=;
 b=hXDqpqD5pZAcdKTM9by3s+joM5zfe3seCn4TI88VS+5YU/NkCBYMruWJ/NwBtMNWDRmDlNWc3YECFLqCSmR9NNXIhlc5Y7jmF9ZGliEHiLexzVjMrs+4yY3Eo/HexYUONvUaELjczvl1QkxMcsvpaveppEJes8+fLv1ghTKELxACCR20Gxf00w7W4+tJ6Y0nIacaoHwFxnyqiwOaIfgpUid7FqKJ/9VhavzBBl6ij7+YoRVk6bcmofEjKifLv8UWUnTIrjlEzdqXxEx2HN88geEeXvZjHIWIRridhE6IejgIqv4ye8FPJPTPTtMoqkLu+dFXcEwPA9euMZf4MM5Krg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5q1+UsTisEwIDmNbqWRnlyLmQDZe+1xNqBcyjaUAEQ=;
 b=5GHvL5MHkxx0y+EZJqtjfVpq8LAGjy2H5UYZswkJw36DVzqkbuFOjeGA1AOC0iuuRXHE8zNzGg8Ziy0Q9N5ojM3GBUZ2LdxQ7jeTtjEGX56uNXSLnTd4At5gnSCbZHWZiEjFMUGzg0vHLvaXA6K2HV5mg2Xc8NLdEUoqHZtoqT8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 14:46:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:46:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 7/7] drm/amd/pm: fix some OEM SKU specific stability issues
Thread-Topic: [PATCH 7/7] drm/amd/pm: fix some OEM SKU specific stability
 issues
Thread-Index: AQHYHJrdDeDP1F9HZUK2y5V9AAv+H6yJvAz+
Date: Tue, 8 Feb 2022 14:46:47 +0000
Message-ID: <BL1PR12MB5144AB04704A7D7F4D5E95CDF72D9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
 <20220208032009.763982-7-evan.quan@amd.com>
In-Reply-To: <20220208032009.763982-7-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-08T14:46:47.035Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 6eb9c131-b14b-0370-2a1b-0b9636bf3b8d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 281cc0c8-8050-4c65-472e-08d9eb11d564
x-ms-traffictypediagnostic: BY5PR12MB3777:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3777ABB9C1C5A31154522C60F72D9@BY5PR12MB3777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t1xHg7ZeRgkuwa9Q4U3XOzRAB6nYeGNp5YEh/Cf4H9OnOiApXalMoiHGeihvpCCBD+8ch3cpTuo6V/kKWPcdNpq/Vvw13aG9XsfDp3W+6vDRFK7qyahaPxAUXlRX1fO62ufT172M7II5MW9/XI8JYets2QZwDkXE9lId8BSfdMgVCLHFPE69hpBM0BxBTdFDKDbJRb/7A9rlz8YJjIsShgFRkN1YNO/GfSgwb4JZlFiiHouxBucHAgZ8uLZnIhXFp/4hi/3wsFvmGv10nCcnuJrHo4UyVYgOqiC679MwCY2Jk5zay4jCUGl80ViuI0nEXRrA4VlpShBr3xKsV3pXRsh71Aa9JE1a2FkYngQ3Diu0VA2DX1CziHcZSLtwFIXLST66Y5ZlY1WnECRFVE0zVFsyKoLXFxDpBF5ffaF9KHDZClBLpfGf4QMhI23+DqvHTSMlN06UaGxugDfGnIJ0+XVbTnTizk2j1MzAJgWT959IIe36g+GBgBARjVdMyoJ6JwOkccrtxbZuHgTJxcAdhRqe9tW7nNGo6JJ0bczkMxzOq4LRj8GKxBAmjP9cJWpvpPTHbmSMcB7ORoNGqtJhU10y89dEhjMrO9SRUPpJvjkNd2n28o/UU2mq9qqe1ktQ5jHQ8tFlCpaAVq1MVXFYhvVGGu047kmvYn2u6nOGjFJnuBonGnO7rGr9h5pCiwCFMO2end8vyjSfR7KuQEDFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(66946007)(110136005)(2906002)(5660300002)(316002)(76116006)(53546011)(66476007)(8676002)(38070700005)(52536014)(33656002)(6506007)(7696005)(71200400001)(38100700002)(19627405001)(9686003)(66556008)(55016003)(86362001)(66446008)(508600001)(26005)(8936002)(186003)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mi0ttEbvgpOrUp1ejUxfufmqNvHA8NmaiffMKZ3A5e9WtwVAVTPc2imCMlrJ?=
 =?us-ascii?Q?UK/RBko5GKp9881/wahrkQulZIZ6wPc+MZnU0Z/l62atAIB+1eP9ZT5ON1wz?=
 =?us-ascii?Q?FNtgz+qS5mo7DQh1sz/lyyt1XIYKgvXJ7Y7wxcvKZEqPIe303dBAwZz2HGma?=
 =?us-ascii?Q?7C6w17/f0uuiWgKCQfvYG9sfUXnyx4XOeHhk0In3y1anNtcp0VioHTABpM4w?=
 =?us-ascii?Q?taXnitMhc7z1hjOP98f4/OH3blei1jUO1RcSPfbnuTpumhlBIUZ3NOfa2lfg?=
 =?us-ascii?Q?+4SCwWlYCA+FXRWrJ9eOLI81W1e45ZZc1Nka0qtQFljIg3GD/osb1lC2Az/J?=
 =?us-ascii?Q?s0GvgmLjc/J3idxcDABK5yAB525o47TjWEzTkXQnp1kTfmJdu6zt/xu+kd4c?=
 =?us-ascii?Q?wFymK4cBzRoTwodjOb20KSbXs+bxo0pXiciuX8O1ysxrf7sql2iC8sCbo3gn?=
 =?us-ascii?Q?9VlwC9mh+CEJ8XpWImfnTwZZk8zQ4m/+chJPKNdhTnfzyxg1gxU8fEnmmBbm?=
 =?us-ascii?Q?gRB87vO9ZfKdyu3S8rQJG4B4R1y/B62y6wIa7vEJqWkImZE8WhYAU2qmzihZ?=
 =?us-ascii?Q?u85kyud5c/i3psMqy8uCPfn9iE0gs8Zt5/DND58IuHoYnU1UwNM7YclW50+j?=
 =?us-ascii?Q?bB+FeuCX8/rfTIG81MtPlK4VVpNDikg22iEfkKyVSxWFAujd5Q1ZDxWsnB2E?=
 =?us-ascii?Q?NaWeGDH/xLVdx4CDGXNchoATm2dUiJ+7S8kfge0EE7+U/1VmCNpCLJkjvgUk?=
 =?us-ascii?Q?WiuC9SbpM/wpqPThg1MtovF45zvkIlBSht42S1a7Uy+Bu/oX713jI2veRc5N?=
 =?us-ascii?Q?hlo+wcbLR6hFhGUpLI7mkV60P8Q95+FMxIDVHZ03LjVd2oW7n3AyDvMEkjIJ?=
 =?us-ascii?Q?/CJk2v657XBwsT7rMcrsONON3EHxiONaH0HQqy4Grnq7OlHMqC/ZfSYXNWCN?=
 =?us-ascii?Q?5mRq6eDMwzCX3OPc5h6vbsGvo2kriahYdeZVsSAkxKJkhGPeQJmtSjp2pHHj?=
 =?us-ascii?Q?fvz9MFoJtFNNcwJfbm7/kM1J6Snt4p6y7JnhRULPYqwmE6Txvgun4e+B8u6m?=
 =?us-ascii?Q?iyi9v/S6dpHJ7duR3lOmnx3dL5RVaFK0fkAK+UAl3GrBnPKQWEB4jrTB8DfA?=
 =?us-ascii?Q?G05UYD1ZnNu//e9LOi7BB18s6s2l4dEu1XOUbQ/Bms1a7HR7DEju9p5cj9pn?=
 =?us-ascii?Q?Ge5/E1S6EQ+Z7IRIctIVFpUHFshm/yejmG3z+H7REpgfHlWzySbbSnRbqsVr?=
 =?us-ascii?Q?7f+6PfAIFgOjw7dzwcWHHt9gGzo3vqKptPFt708ZPxM02Ex+Tvs6gvphHa1X?=
 =?us-ascii?Q?wttQU6W/oDr+DpVNgs5FoNDTV0DwJvEsGirlPJB2Ay3IdO0pMcf5lwVW1KgU?=
 =?us-ascii?Q?inQ8LCJmECif7QFOtbkyrPcLqMURhJgnyW1+I93hEBmcxm6mray+qoxz0TYc?=
 =?us-ascii?Q?rHmtfIbKWQdi7Wjz5YHhL4i6zBLV26aNwX63UItfqB4W2IN8+Gb5wgRIkxJ6?=
 =?us-ascii?Q?on2blC31DEJl5Kd2H1WLmM3g/ALXPrbKzpgOzA7tuTZzf8liUvn/MpAj43Lz?=
 =?us-ascii?Q?hYh89FZ1VJfoOwpmXAI7rd7KYj2S7y3BaU87kTlZK3lJcDxMp11DrbujdiBA?=
 =?us-ascii?Q?wf/cT/86P7wdbcsRpdLsM2Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AB04704A7D7F4D5E95CDF72D9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281cc0c8-8050-4c65-472e-08d9eb11d564
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 14:46:47.5476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zO33L4yYySFvRQjNLQXbNrb7Cg53AJ5DWnHefaMbKofHpqi+05RYoWojqp+vyAVua2Jyv9pV9o8eCxPGw43vug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3777
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

--_000_BL1PR12MB5144AB04704A7D7F4D5E95CDF72D9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, February 7, 2022 10:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH 7/7] drm/amd/pm: fix some OEM SKU specific stability issues

Add a quirk in sienna_cichlid_ppt.c to fix some OEM SKU
specific stability issues.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I172c6429c54253788dbf28f7acf877375f2bfc5b
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a7bb5358d4a4..f964af05f376 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -428,6 +428,36 @@ static int sienna_cichlid_store_powerplay_table(struct=
 smu_context *smu)
         return 0;
 }

+static int sienna_cichlid_patch_pptable_quirk(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t *board_reserved;
+       uint16_t *freq_table_gfx;
+       uint32_t i;
+
+       /* Fix some OEM SKU specific stability issues */
+       GET_PPTABLE_MEMBER(BoardReserved, &board_reserved);
+       if ((adev->pdev->device =3D=3D 0x73DF) &&
+           (adev->pdev->revision =3D=3D 0XC3) &&
+           (adev->pdev->subsystem_device =3D=3D 0x16C2) &&
+           (adev->pdev->subsystem_vendor =3D=3D 0x1043))
+               board_reserved[0] =3D 1387;
+
+       GET_PPTABLE_MEMBER(FreqTableGfx, &freq_table_gfx);
+       if ((adev->pdev->device =3D=3D 0x73DF) &&
+           (adev->pdev->revision =3D=3D 0XC3) &&
+           ((adev->pdev->subsystem_device =3D=3D 0x16C2) ||
+           (adev->pdev->subsystem_device =3D=3D 0x133C)) &&
+           (adev->pdev->subsystem_vendor =3D=3D 0x1043)) {
+               for (i =3D 0; i < NUM_GFXCLK_DPM_LEVELS; i++) {
+                       if (freq_table_gfx[i] > 2500)
+                               freq_table_gfx[i] =3D 2500;
+               }
+       }
+
+       return 0;
+}
+
 static int sienna_cichlid_setup_pptable(struct smu_context *smu)
 {
         int ret =3D 0;
@@ -448,7 +478,7 @@ static int sienna_cichlid_setup_pptable(struct smu_cont=
ext *smu)
         if (ret)
                 return ret;

-       return ret;
+       return sienna_cichlid_patch_pptable_quirk(smu);
 }

 static int sienna_cichlid_tables_init(struct smu_context *smu)
--
2.29.0


--_000_BL1PR12MB5144AB04704A7D7F4D5E95CDF72D9BL1PR12MB5144namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, February 7, 2022 10:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 7/7] drm/amd/pm: fix some OEM SKU specific stability=
 issues</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add a quirk in sienna_cichlid_ppt.c to fix some OE=
M SKU<br>
specific stability issues.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: I172c6429c54253788dbf28f7acf877375f2bfc5b<br>
---<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; | 32 ++++++++=
++++++++++-<br>
&nbsp;1 file changed, 31 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index a7bb5358d4a4..f964af05f376 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -428,6 +428,36 @@ static int sienna_cichlid_store_powerplay_table(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int sienna_cichlid_patch_pptable_quirk(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *board_reserved;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *freq_table_gfx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fix some OEM SKU specific stabilit=
y issues */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GET_PPTABLE_MEMBER(BoardReserved, &am=
p;board_reserved);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D =
0x73DF) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;revision =3D=3D 0XC3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;subsystem_device =3D=3D 0x16C2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;subsystem_vendor =3D=3D 0x1043))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; board_reserved[0] =3D 1387;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GET_PPTABLE_MEMBER(FreqTableGfx, &amp=
;freq_table_gfx);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D =
0x73DF) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;revision =3D=3D 0XC3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;pd=
ev-&gt;subsystem_device =3D=3D 0x16C2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;subsystem_device =3D=3D 0x133C)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;subsystem_vendor =3D=3D 0x1043)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NUM_GFXCLK_DPM_LEVELS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (freq_table_g=
fx[i] &gt; 2500)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_table_gfx[i] =3D 2500;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int sienna_cichlid_setup_pptable(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -448,7 +478,7 @@ static int sienna_cichlid_setup_pptable(struct smu_cont=
ext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sienna_cichlid_patch_pptable_q=
uirk(smu);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int sienna_cichlid_tables_init(struct smu_context *smu)<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AB04704A7D7F4D5E95CDF72D9BL1PR12MB5144namp_--

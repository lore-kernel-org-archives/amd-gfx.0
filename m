Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EECEB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 10:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8357E10E537;
	Thu, 22 Jun 2023 10:20:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E881F10E52F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 10:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld10HKzwv7hi3ZEz09vO37ljSoiANojhziCOzF5sX+6ZzIhzoLjWz1u6+vTEihMT+JR4p1ZZqzI3unRQX3Z1heSgpUP7WOAaHqo42s1GxTP6Ry2A4Q3y6bcm3T11gwdXzBj30V2ffTINutjOox2I/hjRIukq27dcBl7zI8VUWXsrlF1hkKSc75hDoWORjVYVZutyuERDlUxv8OKS+18uhjjJ8T93wXyry7Ec/Mp6NiXCEhn13i3tI1NvkXk5XR8eq3N1qAX3CRh6gDCFnp8TziQHYtEMu1bhS/PVnz8hU3MR+QxeH5ZZMo+2tvrxFMeBj7XpIIo/DFX42cTS4xKYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IRgk/PVVKgtqfkx23VfF9y+/RZ7iIYpHuMY4ZOk4Ho=;
 b=A5hNznj9cnGo6SgRuDNmrG1MpnTzUtM/X7lBJQ0PNQNdpvISMwyay1CsvSvptIfLakTqZvzIyP6MWmoafcVPm0FfIi49KMaWDep/sbGV7y9oZJGnpyJiXks1nKksRwzMF64Epe4IvF0AfGKSqAnvp/F29Gar3+n2MOJU2kNtOFOEjLULrenhkEmr7atPVkbP+ZnQ5FkWLpYHRzrD+k9XC73RkiOAFEnJuDmyOuJ0DM9r16s79Pbuv7wVS6GPYFfQyAuavPrRK956a+kNG2xeNatgg3xmM3wNnjxc2caFHUvik/GIVwqjIpXsG3L6qkrMR6jq/np9AfCow5k5L/QoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IRgk/PVVKgtqfkx23VfF9y+/RZ7iIYpHuMY4ZOk4Ho=;
 b=voue/yugOesLj/Iy2epYP4IMiT7p8uA3QQuHYbGIjZ6qscmQWhSxSENAabqoyqqsfxYQfgQ36AXLLjDozo9yRtyc8czd5u4+bIC3/nj4HR6OrbkZK+7/VHvXrqDdBfs4Dq5JqLjGrb/s3rM/xPzcsgohfA+E5y0DkUQM5mb8O7E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:20:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 10:20:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units
Thread-Topic: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units
Thread-Index: AQHZoquFeLAYJ8DyU0uXY/PjWB0diq+WU/EAgABM1Xc=
Date: Thu, 22 Jun 2023 10:20:18 +0000
Message-ID: <BN9PR12MB52575002994B14146067A107FC22A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230619124215.2085234-1-lijo.lazar@amd.com>
 <BYAPR12MB4614293E9ED8D77971B8CDED9722A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614293E9ED8D77971B8CDED9722A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-22T05:44:32.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8845:EE_
x-ms-office365-filtering-correlation-id: 521ee189-62f0-478c-196b-08db730a4775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXuBZ1er96WZf9iq3MI15BGXTmxliu0v1I2CfpC9tJbYPHGk0TFOPhMtaCjJPvAxSllOJyQGmRu9w8G4djqopEmhsM2FsoYrAgUDc453GXMn30HE8XO4xA3LrpA9X6Hjb4jmD2FVofPy42jMyQYj46hUiKyy+PtG+fzf7Umz6/EpTQt0l70RI93LjJHQFo8uwRIRyLQ+z8ZLQY/J9umeoHxkGc1be5bNuTbofFhTfzqERnYSmmqRsr4OUYbOvwJZdS+Jq7xKM6Fd64wPBy11XjDfYODVhW0XsjmeBqjtKTs5eHfnajzOrwFjdO1UDNOos099ee2LMpyVy/zd3GYaE25b+9mNRoA35cnY0cADf1wWMMQIF4SEa+SGzeYdBpbXIqM9c6RYO16nefdKI9WvaopIaq1E39wmyPBYbW4w3tsknEJRsVwFgx9PJTSdr44VyN+W67nPEjpQ6fsxcNGIOPNe+QYvsqUnGvTRX1mKXtayyyuOc+GSOV1ycQpAWeEXwci/Iv8BiO3oewDpLioLxB1l1U+zFMd4NUn2Td0s8QEidsbp5M48qaEbSCyv5t1NBDa6SM8uoCFLUCk9Gzhv3ywLkT9HxDZr6XqyshjIYwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(38070700005)(166002)(122000001)(38100700002)(86362001)(55016003)(316002)(66446008)(64756008)(66556008)(66476007)(8676002)(41300700001)(8936002)(91956017)(66946007)(4326008)(76116006)(33656002)(83380400001)(6506007)(53546011)(7696005)(5660300002)(52536014)(71200400001)(478600001)(54906003)(110136005)(9686003)(45080400002)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?naLznDK60C/m//V9Gpxp5KgVyZocuco/vDdnJHGcsxlgnMig/koI6lhHC21H?=
 =?us-ascii?Q?tcWMZT78miC0eDx2pftUrsfzlVc78kuqsceHKhHcM4UCWTrHvAe6l7MC9cGw?=
 =?us-ascii?Q?1YA6q3x8YiUhnT7oCjkSx8QOy62BtptF4mxaQ9RYmQ8Ocftro1Z18K+44jk4?=
 =?us-ascii?Q?BUVSMNsUTEYUdCmp+NiwazLc1aVUFt7FiAg/Dcdkm6lcLKG67xuI7wQDBv6n?=
 =?us-ascii?Q?t9sNrD1fJ55l5gYZdm9oopCYKWGpK3O5jacikqAKcaubkY0SVhwozUQhXvIn?=
 =?us-ascii?Q?fGBk4SQmi9PlBOMuOKGjKbgBP6vdzaS9vpD9r39MOmXfuvsu/dCnFkfDOwe7?=
 =?us-ascii?Q?RsXZW/Sq7ZBc387SKWPFWIcUFcnyp1zoUBnTC4B00H5xRk0sAAW5+3Jju6UM?=
 =?us-ascii?Q?YW8tUCItCIHcIcQqVQ2ySpMXlx1AvbOM7uZvi8jtUmYL3x685hwYEADclQR7?=
 =?us-ascii?Q?h7sVQau67rRjr/HmRBPLag4Eu1/bADHXceQnGb2r+RrJZVtEVoHVdYZTes/s?=
 =?us-ascii?Q?Sp5PTtB5xE2i6PIUYlhHTbc6WnZn3Jjn1NXEv07R+2Ei7zDiAbtG4YDDju/n?=
 =?us-ascii?Q?y8Y7drsVzPKlylDFoeFoD4oW3mE/YW7jdqyCHdfFhkNMbdKJrwJwvN6P/6kk?=
 =?us-ascii?Q?tKlAoPmeq4dzH9Mo+MsHlJuaGdEyfDP58+8wevNgT6tSkvxiEl0NAsheMtBy?=
 =?us-ascii?Q?b1zRz9O6PsELpqIL84WfYP30HU5VH53ZtFyKYPKNW9L8GJAjLv487aCdJsgB?=
 =?us-ascii?Q?zjZ10g1/c9TnqWm4ZT353X5Y6Zen289SKeNqNqt5vQEMsdseDv0iLV0hKztK?=
 =?us-ascii?Q?8DuZnfp1jd8cHG+4nhzTWOpvJvjB6vClK/4hWE+ZwwS+LqU7lk3Lp1Ur8xFl?=
 =?us-ascii?Q?/r6vk8J8X1ZaYCR85Ue4yihVj536AOpZhSPsKGpSKqByo8/S83SXTommlf+Z?=
 =?us-ascii?Q?OP70CII2p9mHq4aYA0vvaRfGgGMkv2sdEL6fLGCPtRad2T4BtoccAwLMePGK?=
 =?us-ascii?Q?ECjTn2ycC3AQwjkDzU+iquhWlWNdI+PuLWFDr5PO4l34WjyR1RK79W4xnC/G?=
 =?us-ascii?Q?YPFJTeCcRolKpkii2FYbDWYZyqyuhsYLrAgTOuUAWaQ8M/HHvJbSo9B3bHsh?=
 =?us-ascii?Q?bhrNOm4m5WBLrGvaeY+9/O+zM3ukG1GseQlnPOoNRMonPu/+2VyXhpdPwAcs?=
 =?us-ascii?Q?aMSyOrtsRRUiURIDTw1Q1WI9va1sY9PTcE+4XjNT6sWELiLcPZK2hwlezSs8?=
 =?us-ascii?Q?Q+sMHqyh4h/88adIpLT6I3ccyBuFE3TRU5vbOuLaUFnEn1BJHMmVnwmcnHqo?=
 =?us-ascii?Q?cvu0QhYpbb6jONz6d3W6b/oBhc9kMnWDt05qXgDLucINJgLmVyHef1w6ek99?=
 =?us-ascii?Q?Tk8YN5LtfcXNSfg312cIdFP/UnfqBoeuBf7vewm/Kzh8dA4dD+9zlTiVT8h1?=
 =?us-ascii?Q?iKaKWUw+Tfvj47USFlgEjPNKp58rdE8dWPtTFO8xYw7jF7CjmjoEH1kJXaqg?=
 =?us-ascii?Q?8dB98hbpuaQZhV6SalXMRkihTpuXWR7iPyTMZdc5T12Jd6m44U7qAtQMyG6r?=
 =?us-ascii?Q?Y59eQYDZBkahwOrFZtR/vH5mSibegAl1Eklo1Lrv3aTd5Bb1BlD0R0F+mJQg?=
 =?us-ascii?Q?Iu+g4gFxFOdQx/j396kP03h3ChLlQSw+ArBid2e/OfOx?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52575002994B14146067A107FC22ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521ee189-62f0-478c-196b-08db730a4775
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 10:20:18.8301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dro1bpldM04/E/Nh8jP1mu3aM2YKexBdzf2wGoLrP8JTfQiT2yn0AVaAex1zFzdqDIe53le8UAX0w8WP3lmEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52575002994B14146067A107FC22ABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, June 22, 2023 1:44:42 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, June 19, 2023 6:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units

Publish energy data in 15.625mJ unit for SMU v13.0.6. The same unit is used=
 in Aldebaran also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a92ea4601ea4..6ef12252beb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -200,7 +200,6 @@ struct PPTable_t {
 };

 #define SMUQ10_TO_UINT(x) ((x) >> 10)
-#define SMUQ16_TO_UINT(x) ((x) >> 16)

 struct smu_v13_0_6_dpm_map {
        enum smu_clk_type clk_type;
@@ -1994,8 +1993,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        gpu_metrics->average_socket_power =3D
                SMUQ10_TO_UINT(metrics->SocketPower);
+       /* Energy is reported in 15.625mJ units */
        gpu_metrics->energy_accumulator =3D
-               SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
+               SMUQ10_TO_UINT(metrics->SocketEnergyAcc);

        gpu_metrics->current_gfxclk =3D
                SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
--
2.25.1


--_000_BN9PR12MB52575002994B14146067A107FC22ABN9PR12MB5257namp_
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
<div></div>
<div>
<div dir=3D"ltr">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</=
div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 22, 2023 1:44:42 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ uni=
ts</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - General]<br>
<br>
&lt;ping&gt;<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Li=
jo Lazar<br>
Sent: Monday, June 19, 2023 6:12 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswanathan, =
Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;<br>
Subject: [PATCH] drm/amd/pm: Provide energy data in 15.625mJ units<br>
<br>
Publish energy data in 15.625mJ unit for SMU v13.0.6. The same unit is used=
 in Aldebaran also.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index a92ea4601ea4..6ef12252beb5 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -200,7 +200,6 @@ struct PPTable_t {<br>
&nbsp;};<br>
<br>
&nbsp;#define SMUQ10_TO_UINT(x) ((x) &gt;&gt; 10)<br>
-#define SMUQ16_TO_UINT(x) ((x) &gt;&gt; 16)<br>
<br>
&nbsp;struct smu_v13_0_6_dpm_map {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type;<br>
@@ -1994,8 +1993,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;average_socket_p=
ower =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocketPower);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Energy is reported in 15.625mJ uni=
ts */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;energy_accumulat=
or =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ16_TO_UINT(metrics-&gt;SocketEnergyAcc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;SocketEnergyAcc);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_gfxclk =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SMUQ10_TO_UINT(metrics-&gt;GfxclkFrequency[xcc0]);<br>
--<br>
2.25.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB52575002994B14146067A107FC22ABN9PR12MB5257namp_--

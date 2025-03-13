Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07826C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 20:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DF310E948;
	Thu, 13 Mar 2025 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtEDAvIM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9240110E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 20:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxR1Nog80bsqW9oSDkM4cNyUBulpbeTlS+1DiMPxsy2zgTitBbI0dyF2JmXsaWPNZ7dfBsTSye2MYP9+3cHhQF/aWILHqELs4Jike38jVI69onBk6hFOecw26Y+BcaBEdcqt9+rE1nla9PoRTUiJfUo8Lss1rZmAlhH4WHYkvK5/4JWVdZfSlfhHR7/P/qvDakYupd+eBLtJQQBdEIHraBf3wyBcxh9TNj9gAfXdLgEoUEFlQTcoG82NIP5uj8XNMSSKSfctxJldhC3aSroRZuAlAVjGCJDGuTKUln5XjdDXP4Fsuwldv5ECIYqVCjz+BREYomMzkDmIfA3lH8lJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fs37QMF8JcJfKOQ6yyfw5wsBqmhgBq3w8ud5W0dAPw=;
 b=iENmiU0FFjfy50ePRlfDr66fI1PoQ+bDEIMCL0Gi5JsfKE2yzPT7rENrnDUWtzBk7a05oA8IC9IZBAEpXKCeFFlN17n0+5fsMRbqfg9174716bmeiZHAQ5YjhZyp5lA4P+MrZ1lGcXomtZlZcfvEGb+6O9iNjNwCAi6mqigGqNyvLQ6yx94CnnPk3IYB7Tr3gAnGTaQ+qFCs0tKUO2J5XuX/PqVrzqOP213DjCbfe+CxYZUEwbhSNIOugVmOHfZrh3BSNQY0GuxajCxQSQZWia366oeQMl/7snGlQcUJsDLB+o325YsMtoXk5AnAquUsU9eazH/713RvQOo9l1oyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fs37QMF8JcJfKOQ6yyfw5wsBqmhgBq3w8ud5W0dAPw=;
 b=PtEDAvIMmfeWJtQjC4QiWYLevzSbPoPflxewGjeTL5rm3g6fPGrv55ioFz+nvYfEAmkGWNLwPnVvmweoQ7WUUV+1SXM1hElhLcaT0wKkJTfrOycyV+21pePpzIV1y1LrYOTXLWeioJMOimw1a6TetMs7ncSHkiqVL3Is4T/2q3Y=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 20:53:12 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:53:11 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Kaszewski, Dominik" <Dominik.Kaszewski@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add debug masks for HDCP LC FW testing
Thread-Topic: [PATCH] drm/amdgpu: Add debug masks for HDCP LC FW testing
Thread-Index: AQHbk/VEmr0yRV3CK0SoAv5nz5iu0LNxi85k
Date: Thu, 13 Mar 2025 20:53:11 +0000
Message-ID: <CH0PR12MB528461424635C09FE489D7C58BD32@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250313085231.5042-1-dominik.kaszewski@amd.com>
In-Reply-To: <20250313085231.5042-1-dominik.kaszewski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T20:53:10.868Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: 06ef4c27-72b6-461d-1d1e-08dd6271110e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zeZEuowCByk8sa34BnEdFrbjOLlpJAAegUr++C4eNl1sqHm8LB/Jf5x3mkPS?=
 =?us-ascii?Q?TCwqs6Q0dpDkLgJ/XrvRqtVsaicSGbo+NcfdxduC+9uiWRbfI6gaW5anliwU?=
 =?us-ascii?Q?qzBT7FWhpXV7bHbll69oZtuTPGNCihDVfb20oxzkrwa99zjbWs/gDdtvzprf?=
 =?us-ascii?Q?QC11aFnOTiVW58y/2YFVbN2YMdy8iGdzrBbBExR5pD1K4np6jzmpAhT1U21x?=
 =?us-ascii?Q?k+4XxjZhDIbZNkshXtihFU1yt+SW5coTZnuTwwadawQ5pXi1f7kfXftb+Kax?=
 =?us-ascii?Q?o7nS6X/UNFEN4v7PAOl3kmyHsDN2ksJ2HViPCJm4NAe6in9UwMiIVSn7/mOj?=
 =?us-ascii?Q?fMsdxT0GdI3Kk5TbI4iXE4D6lGGmnvVp/3hVjBkLLk97gTy9/a9E/6py1nqn?=
 =?us-ascii?Q?aX2Vmt1PflL4T484gSt1ungAtBGrEP0xvmqDhK4b7TziY3cE6qGrD8M6JT38?=
 =?us-ascii?Q?xEi3vLsUUFlCGf6dN/h+REsEnDQtm8WVUFO7NXkF/WK0DKtirKz6N39T0dJa?=
 =?us-ascii?Q?RbAHv61UTcuZfyRX6B99XBkg0qhxxAEiB18QEF1JvsC9FQCN1VVl/vEhJOR0?=
 =?us-ascii?Q?Ng7o2xHK3pxYU3bm44dueRMavevkoMhvJsmNQ1DpxiEpbTSnjvObpLnuEsfR?=
 =?us-ascii?Q?qv2gM1fz0j8vDphoQ/HClgqEzQF7kenlXyuCNcN5cEaR8auW8XuUNKDUwPzQ?=
 =?us-ascii?Q?xYVCPtCOUnwQzQafTkZnBgFs1vwqBYVFMafAD8DAvzYngb7JZwGRXfdwi403?=
 =?us-ascii?Q?QaWU/WCEKpRUxWRnkTg2l9/4mINcmWLVUHEjwy7yonvzSLazQVMWo+UO5W1y?=
 =?us-ascii?Q?I9ETV61CHUMDdlZUXBghY3WY/n6gFx2AB8sVgDg5HtenKIusjmOi9aMwFLqZ?=
 =?us-ascii?Q?OfXIKuIfWVsUndXcMh7EIXk1SCZU+BvrU/Qq/RnXyGGDVPeaofrxeF6yuEPp?=
 =?us-ascii?Q?DbNIPehYv584id0FS3I4BTcJPYUHdNm+Yliu2McBCxpNQupJWuDohgAgNan9?=
 =?us-ascii?Q?15mmEsS/G8NS157E7zzAZ5iMwKjx0ZiLmKsOeMfTBa7suwqAduplgz/54j7W?=
 =?us-ascii?Q?sNUOttzoyNf/m6zeTdhwxiZRmb/4lTA8ljHXgIyhXw9rARRGQfpSmeMsIxS7?=
 =?us-ascii?Q?Cnv3MIs4S5017k+wdipEC78yG8BXkmQpluS/d+62gLp8KvX7iQ8zqwZkCabb?=
 =?us-ascii?Q?4Tzt/1HLr1fcVfxW57uaaemX9MKhu6/7jogo/YAMnSV0pzA6jNtOEZmpw+If?=
 =?us-ascii?Q?Sk9FpAvjd7o0aGwdll2FYbFW52qg41viCRlWfsWQUPhnnXijQXqjfySAlHX5?=
 =?us-ascii?Q?5n04hg3TPSK+OpuE0Rf6QZeW7BqKoUhMnEGsBf1DfhbzTE+AjKiQNiny9lhP?=
 =?us-ascii?Q?h00ZbWpGgfgicEqr971EZ8MmZzrLlWfk0dJqD4gNYjkWKGLPO3AEq32QiuO5?=
 =?us-ascii?Q?Dg9PX+4Hv6icCsw37Idfu3BiuRsRfGnk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vjnZrGVMSI51YMTzY0OqxaYqol4DZThykJtMt16B5pjngKI/+cTanJGsCD+2?=
 =?us-ascii?Q?pfRaTI8izb4ptqDzq8m4ZOwsF97Evpmj3FgkAoEUaPzHSLn5RUbqCJSqOZUA?=
 =?us-ascii?Q?R8qrPk9LIeCObh/2cC6lRqRJQ7uzVJog11FyvJh6Hi3ie70HwTYoHAAN5BjZ?=
 =?us-ascii?Q?d2LO/+Ep1lmGxSUlfhLQpaG+OL94P+4IruRCQgWx0ukQC/0/DLyu+MeXVOdA?=
 =?us-ascii?Q?NzQhq3kznIvfmQxnEaX3ik0h4QhjXKKrYamdrlJzg7+NmHT5omKHtRM781yG?=
 =?us-ascii?Q?Z71yjLWnfjt7aePSAFM5O30EuB0+JjpiSkhZzqNnYIsXaf7EMVxymMl1hSPO?=
 =?us-ascii?Q?d68WzK4HzfwMaV95EOIz2aXWk47KCrfokSQ9OtNqmpQKfGFH0FqoJfuTGaPR?=
 =?us-ascii?Q?Y55x1aessZn10zlNx5OlLkOv8beBVevt2jHvT7Gl77rkqAHuRdh/fvGiuQfu?=
 =?us-ascii?Q?1GHtiFiCxpTtobrXkm2hBhNQjGa021YOXllUvDuIvGiMPBsHOp+fX/KNZ4BC?=
 =?us-ascii?Q?cIbsT2B5SP0tY0ooDgvLpRpeUUDqnYYIUL0gX9KPG+ygYWjc9anDCkZqOsmf?=
 =?us-ascii?Q?4mp2UxMxfbW9vl3elTixe8RUpmLNCCbN9SiaDw6F/rXwhAj1UNwJT8MUqj+m?=
 =?us-ascii?Q?FaoQVrryGSq0NKws5iH9xrtEOSgEeyJv2hsvFcNXJXiFU0kjHib0rjaRGLQX?=
 =?us-ascii?Q?mav5KIqe3N3mq1YcVF8i7KI6+SQNbF8dP+94ZyG6LCidyImOa9CzYKDAUdSK?=
 =?us-ascii?Q?BEgNktXPawST5Ur+FjD25VfUa6rU0cySzLIMxGVj+UXvEznXdBlKR/cJOD+W?=
 =?us-ascii?Q?vhVs7xaByNID/bVUscnwNamtB4ZgGH/OmTZdZXNyOhuqRmHBCekktM+r64jO?=
 =?us-ascii?Q?KWMIbbYugSqpySe/IFmiGjEtrR4Ktm55Dr9SCPdV1FXKeOChKDZdVB5EZ9e2?=
 =?us-ascii?Q?QAKfw+O61tySWrfsSMPExaRx0vwE4pGwuxtBwcXTno1hz30WFUi/zGYXU7zS?=
 =?us-ascii?Q?Z+ojKDZNLPl3jE/bwocLCdWD95F0SRxa9UY+5XRh75CzCUWqHHCDgcFzGDSb?=
 =?us-ascii?Q?go63RRBqnX97Z6r5R4F4gAvUtUtEABsL9KcEk9ei8zVKTtauThzOgvPDoM3h?=
 =?us-ascii?Q?hVOTNGjvw4ZHwtZclz+bB/QjeYd3oi2mIVfHpbymL/EzpgSl2Xtbr7F96QUX?=
 =?us-ascii?Q?kDrjxfomRFX64sN1MzC2DYcDNEcF+xxJI37yN9R4IAe1H3xz//IwAfbaNIXB?=
 =?us-ascii?Q?ExYp8Ci3BruY7FME78i3ZKotze9RzubkPB8lqbZyB2AZU6M+5g87Sw+GZ3so?=
 =?us-ascii?Q?XVJE8/5ZHxS41F7VdL/3PTv52rWz8ukKkYslBRMk01+XH6eRKpEwz87I91to?=
 =?us-ascii?Q?aHJOuRgovXP7SlNP3eGsGeAx7qVlLvOQm1c1lJm/ewwWF+kU4MZBdQi1J+2L?=
 =?us-ascii?Q?EZcnCN0H02wFX2jObBchv24d4SauFUEOxn1wO85N2MjMoVqIaiBHvhInsQ9y?=
 =?us-ascii?Q?fb3/lEasRFY/pmjtSddKHqh6UTy+ZJNFd8oxuw6HAuhf7UzBoCe7b+icOeNl?=
 =?us-ascii?Q?C9203qO4tyza2314xTM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528461424635C09FE489D7C58BD32CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ef4c27-72b6-461d-1d1e-08dd6271110e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 20:53:11.3305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvWWmsjJ8ixXiSHLw5sLKhwBZaGRPFFwXDRvYKHQRu3TMr1kOTavsCHATG7bpDUydMGxDXr/HfzjevrZBVb+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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

--_000_CH0PR12MB528461424635C09FE489D7C58BD32CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>


--

Regards,
Jay
________________________________
From: Dominik Kaszewski <dominik.kaszewski@amd.com>
Sent: Thursday, March 13, 2025 4:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: [PATCH] drm/amdgpu: Add debug masks for HDCP LC FW testing

HDCP Locality Check is being moved to FW, add debug flags to control
its behavior in existing hardware for validation purposes.

Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 485b713cfad0..4c95b885d1d0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -358,6 +358,18 @@ enum DC_DEBUG_MASK {
          * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support fo=
r custom brightness curves
          */
         DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE =3D 0x40000,
+
+       /**
+        * @DC_HDCP_LC_FORCE_FW_ENABLE: If set, use HDCP Locality Check FW
+        * path regardless of reported HW capabilities.
+        */
+       DC_HDCP_LC_FORCE_FW_ENABLE =3D 0x80000,
+
+       /**
+        * @DC_HDCP_LC_ENABLE_SW_FALLBACK If set, upon HDCP Locality Check =
FW
+        * path failure, retry using legacy SW path.
+        */
+       DC_HDCP_LC_ENABLE_SW_FALLBACK =3D 0x100000,
 };

 enum amd_dpm_forced_level;
--
2.43.0


--_000_CH0PR12MB528461424635C09FE489D7C58BD32CH0PR12MB5284namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dominik Kaszewski &lt=
;dominik.kaszewski@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 13, 2025 4:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add debug masks for HDCP LC FW testing<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">HDCP Locality Check is being moved to FW, add debu=
g flags to control<br>
its behavior in existing hardware for validation purposes.<br>
<br>
Signed-off-by: Dominik Kaszewski &lt;dominik.kaszewski@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 12 ++++++++++++<br>
&nbsp;1 file changed, 12 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 485b713cfad0..4c95b885d1d0 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -358,6 +358,18 @@ enum DC_DEBUG_MASK {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @DC_DISABLE_CUSTOM=
_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_CUSTOM_BRIGHTNE=
SS_CURVE =3D 0x40000,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @DC_HDCP_LC_FORCE_FW_ENABLE: =
If set, use HDCP Locality Check FW<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * path regardless of reported H=
W capabilities.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HDCP_LC_FORCE_FW_ENABLE =3D 0x8000=
0,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @DC_HDCP_LC_ENABLE_SW_FALLBAC=
K If set, upon HDCP Locality Check FW<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * path failure, retry using leg=
acy SW path.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_HDCP_LC_ENABLE_SW_FALLBACK =3D 0x1=
00000,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum amd_dpm_forced_level;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528461424635C09FE489D7C58BD32CH0PR12MB5284namp_--

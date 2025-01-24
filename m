Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C79C0218D
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 15:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF8110E9C4;
	Fri, 24 Jan 2025 15:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="etz/cWVy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1AE10E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 15:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9x6r/9BilnuTqtfptXJDAF85y+h/oHdwXou5SO6Gez+3ZoPb3Vs5KnL+oOYn9u07oKx8zxeF9O70p1ZEaVT30OrrJ5oQAtgnr02BCzD8A+bOMr5i+UVtxAxh/DniabR0k6DECGM56ayoxuoug1m0v1VSxWIJB1xqL0snFfb3Dit7Jub1MrQQJ7E1QtnMKM3LL7obJSO+hJr8adv/ES6DgbjgrmYMTBlQb5OpZkxaqLc5j5Q1JY0uP1u9ipCoYQwYTpwKf6sTGsy78fqRIRkK5xFSD+kgni1Y+8egp6NQMmUJ4IQN6b7XDzDgvFFYetrl9wqAVH32gEiLUCbsc4EKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0a6mUBRQt11wTiwR9i98Ca/h2h8KiL43T4f0m3sSlQ=;
 b=qiaOl7rRWPVoRShXhKrRsmqJpX5jgF9+HK41IbRT21/nOJtKU1O5osPf5ZnRoiI01KtgNhV9B2jaf1Zx8nzgljfnwjwnR4kGrzZ6Bnn9YCggyRui0O+W6U3WxWmASk8XyfY2aztcw7BREFFvodEfrevirTb+5Ht1HrKTdAejhfY2FP4kn6uLPY06+U8AufXyUYCmeHlhbVk6CyENOGKF9TltgeUkIrPlyGdeVWsIfz2q0q2SNN8GBLQ4o76vv0y1H5KUrdTZvK/FOLBO+Gz6qBsEjoW459QZ5x38mAL+8vRCUiJqVarso1VZHglkUE60cSuJd1a9yfo5mUbaO7mSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0a6mUBRQt11wTiwR9i98Ca/h2h8KiL43T4f0m3sSlQ=;
 b=etz/cWVyRyFwARc6fG5dowfmN1b+43bPzSFZ1hR17+TDox8P4wdLky5h3F8bN9562PploA4L6she5jixyhakmmMM0rbDrQaa7zvHU4YKLh2nO4bIc8QdOtm/V3CGM5UxZ7WMoDhKm9TjZsqeB2RcKd3IRM3REnbOqoacgX6SrJ4=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 15:26:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%3]) with mapi id 15.20.8356.014; Fri, 24 Jan 2025
 15:26:45 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Wheeler, Daniel"
 <Daniel.Wheeler@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>
Subject: Re: [PATCH 14/14] drm/amd/display: 3.2.318
Thread-Topic: [PATCH 14/14] drm/amd/display: 3.2.318
Thread-Index: AQHbbDxUDX784dtfJ0KF5v1lHz/50rMmEBWR
Date: Fri, 24 Jan 2025 15:26:45 +0000
Message-ID: <CH0PR12MB52845A34470B134279E36B408BE32@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250121193919.3342348-1-zaeem.mohamed@amd.com>
 <20250121193919.3342348-15-zaeem.mohamed@amd.com>
In-Reply-To: <20250121193919.3342348-15-zaeem.mohamed@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-24T15:26:44.920Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|LV8PR12MB9270:EE_
x-ms-office365-filtering-correlation-id: f8fcd74d-cb1f-417c-056a-08dd3c8b8328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rQiGsKWUeYnECSkrr07TIoQloyGq4Mre19yQ0URd8bJS2U7MRAFo/w8v8Qff?=
 =?us-ascii?Q?mwjxScfSTt+Brz0wK73khjz/qcI7iB1yI6yJTW05a9XfX29dKZ63JcgCZlOQ?=
 =?us-ascii?Q?k8hi5SOVV7B7pTylS1lgfx1+jNBycMEwTFX7e7GAfXDXBfi7zCtt6Y6MDzMk?=
 =?us-ascii?Q?wlsTF1hfVS4sYHFdvhgwwBj2YE4fM+pRvjiwVZVl9yfkWtVz4EOLyievrf7O?=
 =?us-ascii?Q?H1Jlb82oCsVwKRyWOEkgxg1+XYyivvGryocib+m+NwV0glAkfVesV2WPF3M3?=
 =?us-ascii?Q?TAVr+Qozvm6Susa5a+UDplSStCXtPtV8g2ESdqTmdI/oWlFLMPxS1/LI0u9+?=
 =?us-ascii?Q?4rtu+K17r1mAYOCYPU5cXPtwHuUWdsS5x5wzfl2+B2op0qrA5HsMQI+oL8iu?=
 =?us-ascii?Q?iHxXAhHsqtvW5uFjLpJH9Y87uS27VCbeIrNM923wEj4Lbp7JUqetsHm1BiPX?=
 =?us-ascii?Q?GiKavgzI4yfcIICZxvK/4LuRasyXm79LlHfmh4B86KbbJLm5tBRXWlXLtfLf?=
 =?us-ascii?Q?Wa6NWMtWnlLQmvlI7Nn6To4a4Qti1OFC51Xor7IlyVsW2ON1F2YUwbdAZ+dZ?=
 =?us-ascii?Q?bOImqLNQpHk+pJ0qUyv2EhAXC8sqK/c7m9Y9+6THvW6/JlO6Q5Ut6Xq+Af+2?=
 =?us-ascii?Q?xuOEaec3VWSLcuRPFtH3iVgs2ULxKOzkEVCMJCk+4q3S0ZJICZF2M8d6kcGh?=
 =?us-ascii?Q?FapINbRXuSDw7LYJ/+++OzSXI1U6BwEgEAqW86zPKOMkZTSQNUEVtCWJ9jst?=
 =?us-ascii?Q?Z/il4hb+R+AHU7FLza28jVzm5DAFO4ajc3YJzqU6/Q2iOXGMllxRRjAtezud?=
 =?us-ascii?Q?DbvEhbSHkSARuFVOp5EvWQOvpGog//2r+k5AI1ngboYeCoUXxoERzjDBtG6s?=
 =?us-ascii?Q?ZfB0LGrxZhvJraXesjSTDHL3IQbmPQXRbOaaseijFbg3jTiL6aVatujePxnN?=
 =?us-ascii?Q?TZ6ehGYFwQ+6u3Bw25b7IVV5+soVzeuuQl0v7IgEqx4hwZ0xf78aSVjqUMeo?=
 =?us-ascii?Q?vMKOst9EQN9pTJHDGH+hkTieqTliLd9zthJLk+tPceidAa6TYwu4EytWE2Gz?=
 =?us-ascii?Q?dY5VXQOWTOk5osQ1cHEX1H5xqDwYtYyDzvmMEo7+SsCQk6qeEwUBSzVJHU19?=
 =?us-ascii?Q?XaY1OdJ9mdIbfiwmFqwxhPolnfv9Yj+SfmYpso5PxfbPAZrhDoebH8cHdK24?=
 =?us-ascii?Q?QEc3/vvubptjyAWjNic2yjkK0cjKHl58MZj7CcklhjzGh2pWz8jdreG0FdQZ?=
 =?us-ascii?Q?NBPW7YQptV27YypbRlPS6cY2zpscZmjioffnfN3bwQfBpi4D5kIRvulGoWUW?=
 =?us-ascii?Q?p5bXEd3qat0+HOu79gPyj2f8BMJmkBBu1co5YRDQ0oMajt3BCAyncPSFpAzz?=
 =?us-ascii?Q?UZ6u1x9g4c7eOzEoOLHLnOlfH+3Il4yEpYXPC28Zn26k7p3gWWrlT+xGDQRz?=
 =?us-ascii?Q?J4I6KIpmMYyuzjiHXHT4wlmwuR5S3Gql?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AdQqmmvdAktsYpdTracpwmlTZXwOg2xEco7pXRz+78n4RlhwEq15Ub4DNqLc?=
 =?us-ascii?Q?3ZpuKlk3M2N7Bbnn+hBwvCUxpUs9LTn7q2Vd1Qk/lvcAlPdTIXcH0UpBhyZR?=
 =?us-ascii?Q?rYo5n+eZ3cCeXEUT6FUILUvZPvEhbmPkid158dClPn3FSbV4elCz4jC8Wip7?=
 =?us-ascii?Q?5CgmmOL/77iYKT+Fmbz4SE4goMZKA26RaQkhbt/6b+/HQioa1vwLy2FSQPQG?=
 =?us-ascii?Q?hoRGUFIowDr5iGnYtDjChQEffqLhMuonqAvZoKmHxBDku3OiyR/+iancEWBa?=
 =?us-ascii?Q?OLq1Btvhn1EOQf5IaB5+VSA+gm3E8e5b8890mYHfD0zopTEq9utf4w30Bn+i?=
 =?us-ascii?Q?W51q/CyWyMKXxvdOefSw1+u1XxKxw2NtmkqHM1Qx2ppAwil2SxvQd5frrW40?=
 =?us-ascii?Q?l41nzRE2we05J/YOKqhMc/tO0LZN63J7/Ywtwgc51JBwFyKhqgD7ORIHGX8o?=
 =?us-ascii?Q?05mF1WiyXuAlwU+5ZEuwdWUYLbcg+7oXE7hcX8HjKResPnHmCkEGNzfMg+vd?=
 =?us-ascii?Q?M2Cob8O1QW8WAXsPNj9R/dW5z7dF1bc7a6ihjhM5SlfUIRvc0uCC/H9kozkM?=
 =?us-ascii?Q?1oijoJLIIyJtkp4TbibAP7GWxEn/kRvi82z0EbitSdsdAdKqDuGMz0VNwI9V?=
 =?us-ascii?Q?H2bgj3siep75MmikA1dqEGgc65VWMr058LYK5Q+4efcEy/Y+wQP/QaMWh7Rh?=
 =?us-ascii?Q?ZbNLePZuasX3xf5lxAUUEL4z63wXawwjdKBBmjq6wpKmb+p/MnwnDpr/Bcd/?=
 =?us-ascii?Q?vC3qTZ9o0hPGHLoj68DkT7rIocInA7QkMZ1Cmx3GfxQ7eVCx97RR7hQqrFpR?=
 =?us-ascii?Q?5YeH4nWUQPLsoxK9olPT8RZwm8b3XDZYkhmDFU+5pcTx1queCS7q0QqTnST7?=
 =?us-ascii?Q?jOK3NJdSjb1/E7v9r6vqDVjY+JaH44SRiTG3nH01lZ5FbtAm80jIC3T8HSUD?=
 =?us-ascii?Q?X1wMOKrGBaEO0w/vNLC3izhxbtCSzj+Y0MA2IbOjnj83SSuLBigQAA11leNh?=
 =?us-ascii?Q?HMGaoiqop/gb/kN9WQAF/bzgVSZDjpl37PCDkzg11jo3UiQ0vyIP0+wOqF7k?=
 =?us-ascii?Q?teiuSXw9TNfxGNwcMX2nmT4CcVLgRo/MuG6bGaW0Z9PXIuElQocRZLB0MOGx?=
 =?us-ascii?Q?uWEWVoNyuC+jGwLpnFn4gRwp7aYEJyepnOnTXGz5kJJqFyH/ofQhPZ2A776r?=
 =?us-ascii?Q?UguRL9mha09S5ywH5suhHxs86L0YpT7dE0javXtxTBMEjDRjmT5whaUHvM4C?=
 =?us-ascii?Q?pFSNQ7G36Q97EHNPptBKTq/BewCrzBdWdPy2KEGtC46OBDWgx7bFiQHNbhcw?=
 =?us-ascii?Q?TyHzdMuo4WdrwNiMjddoGJcl3RIJUcdGX371OXLqr0b9Qc/1CvrWSMsrmf0n?=
 =?us-ascii?Q?aUuiL+boWHe006RznQf06An7HeUQwy9Rm+lOrFTcRxamKuY5o/CzrF/gU1ct?=
 =?us-ascii?Q?Ta/8Lm/tAIhiKkPREc18KumFuS82y6Ha9FS0fEnGT7UIvt2QJxYiUSrKTdb2?=
 =?us-ascii?Q?FD0Tovh7lfdnLOakz02vSvmWHE1Ixj8UlDHBFQX9Yw0yswHwrOqTL0ReOAnc?=
 =?us-ascii?Q?V7AGIdpgjlLKMPNNIUg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52845A34470B134279E36B408BE32CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fcd74d-cb1f-417c-056a-08dd3c8b8328
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 15:26:45.4410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ndv0UYj0ejPdNtaw5nGR5APJli80RMAEueXIT6Cej8neAyZOCsj96FYbGQSsyhfPQjMir2czi6FRDT2nMHm6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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

--_000_CH0PR12MB52845A34470B134279E36B408BE32CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>


--

Regards,
Jay
________________________________
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Tuesday, January 21, 2025 2:39 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Cyr, Ar=
ic <Aric.Cyr@amd.com>
Subject: [PATCH 14/14] drm/amd/display: 3.2.318

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h
index 06d9cf0a7edc..559446dcd431 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;

-#define DC_VER "3.2.317"
+#define DC_VER "3.2.318"

 #define MAX_SURFACES 4
 #define MAX_PLANES 6
--
2.34.1


--_000_CH0PR12MB52845A34470B134279E36B408BE32CH0PR12MB5284namp_
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
Series is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
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
<div style=3D"color: inherit;" class=3D"elementToProof" id=3D"Signature">
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mohamed, Zaeem &lt;Za=
eem.Mohamed@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 21, 2025 2:39 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.c=
om&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Li, Roman &lt;R=
oman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Chung, ChiaHsuan
 (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@amd.com&gt=
;; Mohamed, Zaeem &lt;Zaeem.Mohamed@amd.com&gt;; Chiu, Solomon &lt;Solomon.=
Chiu@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@amd.com&gt;; Cyr, Aric=
 &lt;Aric.Cyr@amd.com&gt;<br>
<b>Subject:</b> [PATCH 14/14] drm/amd/display: 3.2.318</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Aric Cyr &lt;aric.cyr@amd.com&gt;<br>
<br>
Signed-off-by: Aric Cyr &lt;aric.cyr@amd.com&gt;<br>
Signed-off-by: Zaeem Mohamed &lt;zaeem.mohamed@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dc.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/disp=
lay/dc/dc.h<br>
index 06d9cf0a7edc..559446dcd431 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
@@ -55,7 +55,7 @@ struct aux_payload;<br>
&nbsp;struct set_config_cmd_payload;<br>
&nbsp;struct dmub_notification;<br>
&nbsp;<br>
-#define DC_VER &quot;3.2.317&quot;<br>
+#define DC_VER &quot;3.2.318&quot;<br>
&nbsp;<br>
&nbsp;#define MAX_SURFACES 4<br>
&nbsp;#define MAX_PLANES 6<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52845A34470B134279E36B408BE32CH0PR12MB5284namp_--

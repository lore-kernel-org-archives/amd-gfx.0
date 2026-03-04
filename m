Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA18EF8FE0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 13:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7E610E9B8;
	Wed,  4 Mar 2026 13:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xj7OO5mT";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7154910E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 13:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGH8MzE09LSGZ3FnPeZgUvKN7rtmgYhJ2CWyXbEKuZ2RJyMrS62RWV1RyhoGCQNcEKi7OjBqzGPTZRXd2VM/66tbcoI2H3AWf0fx7TMBtjm2hCtT8eEyMdq7ew0o0MGXAJdbXHwljeJruZevOQDyyX5IgbYOFg4IVvG3nloSB1ThwvupQhwax6L/tH1MNLcdZb63E3fGtc6C/XaPfUx0Inc3n4+vfClwbLYtxQq6CzcxIq2C3qHA2GzqZgL9/xNqwZ7qh7EXM/mX86JSYNPAvmIn++R2ZykseTXS3Ud7GLAFyybk2bTL2J24thNlR2IPXOmY0Bh4CsxzlORpddgTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJYiABCtly3xLMNuRotP9B+VCXkV3cs23k0NigFynl8=;
 b=Hn5Aa28l8YWVvmYERALbjqqSz4KTCMkXx5xY+asdVu+EJiq595lB2O0lihvzSXhxlZS+f5gxKlZrGKhXCQcJ3rhrYCd7fC1us9UDXwdZRS3aEAtQg9LyQrpjU9Z5XK8cP+qLOty5H35I/RQ4Gs2opxTRCyzFN6a4iBOVQQRSJ59jrNnWaU0d3b8GmEaNtwkxY8dsVYFRAdnSA7+p8xRLb7JpvGEJv8nSY7oRTbNNQyAMEJGmhyZz0814ef+5+OY6jklv+GWHDbzJbtw5+M1rdFCL2Ss12CKWYJHSEaXJJwq/s8GVzsNCwfFk+P5+eMwxwPZ/fqdoSkFWSf0dI/YKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJYiABCtly3xLMNuRotP9B+VCXkV3cs23k0NigFynl8=;
 b=xj7OO5mTHOw8UvMX8PCSLFSePR7NzI0XUuMDC9RH3vQbpdEEusWSMGv767UMlsTnl/PLmA47C1PircO0u+rMxGLVGhZmfugWCArZDXhAuSOioh0woFCJEyEVYe11Bd//j84ETFo85N0nBF3u/5bP8CqO3GjfwPkXnFJJgL8lTWI=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 13:09:45 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 13:09:45 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell xarray
Thread-Topic: [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell
 xarray
Thread-Index: AQHcqzDDo6FP34ZQVEyLwzOjqbwLKLWeWehW
Date: Wed, 4 Mar 2026 13:09:44 +0000
Message-ID: <BL1PR12MB5753AE9D4D5B370D32242FFB937CA@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20260303171111.92396-1-sunil.khatri@amd.com>
In-Reply-To: <20260303171111.92396-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-04T13:09:33.6769067Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: 4a72b920-0007-4d6b-4560-08de79ef4e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: CHtUFfoDyAwuy6BUiIiE7IDZwzeb0ln5h7AwM2ClqJvueZL79tywqtvN6IIMI+q+4Zxy+pP/V3YR4miXyGZMiO52AsK77CZ9qqcXj88rOGx4M4h3zeanx+VCiYL2rFValRy6UTcaU+WqxtKzlQn+7HnVFqVzxfl//PNCJgmBk++V/exUj3Tz2UFobWZeHq/QzYzq9E6+eGCOIYGog15nLOLneHD/7TxjZZRcbUODUlN2WZprM3gXgtZ0/2vbSgCQM4P5Hifw964YU5wddxm2YRHshzNXSoNAjX4wH6/At3fZxj/UcRaqfWoHuGaXJwMMjztNdeCKplZISfvDq7oDjMwHJWl3ENKWP7+RjK4YQIsQNZyjnExqfiWrl+OGgb24gLoiOmpk7Ofe9em8i9/GU5x9nZpZMg9U4zuX3dlSP0ghVosDMVSLrxbJmgUIw4tMX2z3UO17A7etJdb3mS+8frIOHNm92E7Bq2cGHBlcPrU63xfK4GD/8XlCtvZj4ct6Wrpm7nb0ybcQI93d2nGUxcihD5wTN//v7CC79NZ+mklBjp6SfzSVm4qcx+y4jZuJ03Vc6tEEtH7w5oBzuWGcA7yU7ZkEYNOOI0n9mLFP/B4MGrhkpUTtrLsru8+yegynX0netIkBBzzC56lvL5UCCoHpzTW6QD1r7KXCTkQb3eSXkN5FxKM2ksDa7ZgEt7DhugJ+G0msbIGnYn2ZgxpE2h4j2BhOcY8UCMDyWFjf6RFaP29qCd+N3DIHL7gEe7lE2MJrFBTNWZOY9GNwLZQZuU9e24XQ7zFO/rIKbGaui9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MeubVeGjzQTtjm0OmHbJbnlqZWFtZxP6WwNKmad5xBOwd5qhcYNE/NK8I7fw?=
 =?us-ascii?Q?h1tInoDqBrr5SO098iD/iKdpubcgLCLXTO6CIadWQN5Cm1M6au8/GE+lRXTT?=
 =?us-ascii?Q?G9Xpcg6frXJQtXbcaLJ24Oh+qz+UJFTEsIRNc1dB4rZ1BW8Ln8xpCkn7ewbs?=
 =?us-ascii?Q?uiqnbKsLwF7AxoHzy3bjWKc4uGKY1mYMmCn9c22foDIWGClFHEk/xkTFF/iG?=
 =?us-ascii?Q?Jesu/Z4r/DlphXN8tjmrU3sagMMOeUrWrMU7/1dUh9MEWnI0TGGSn+e7uvFS?=
 =?us-ascii?Q?Kp1zMck4BRKlxAb++tUFiRPLUf3YDnUV/8BrHIw4+MinTQV1SQZbk6iirOek?=
 =?us-ascii?Q?MNWPZgXPvCCjCH9D+6qzrOYK65yXm98T9XNhgRqWoe2mTzV92/ouPMGntMmf?=
 =?us-ascii?Q?t9v5h900ai44GEoywyIrQ4b9ZyPTu8s2SXOWRnwGNnH9cplo/A5UGL28Cy46?=
 =?us-ascii?Q?+Uc+BLiAneYn2vxi6hkJ8L4JM5emoFjHkKtGlCUTSoz2j7k/G7hWEz/NGl4X?=
 =?us-ascii?Q?ppUDvY28r/jlzldyApCl0df+2ycViAgtsx7oWH9jvdeJrziXIj18O/qKsatr?=
 =?us-ascii?Q?Yte0+rT5uypr8Q/WAvyz7hT4JuTBoFG2ryltVCI4BFhr/TBZD+nRg7ALMLzN?=
 =?us-ascii?Q?vNZXhjE47DgySvznhw65468DxCSqww0JB0YAxEZuFp/ecHb4/yR0vrb/HHBU?=
 =?us-ascii?Q?TpjMoAYPHMVlgloKuQ8lIQLcc7IpdqJ26q7uLtTIrG6LKyxfD5aTEg/HZswh?=
 =?us-ascii?Q?j4mxmqD21Aqd8NG+JhWcsdA6j4UEM5TsVe9G9Rn3VzGhG3mFHt4QHJa79tML?=
 =?us-ascii?Q?5EeCVlW1xneolmH87fizOVl3zg8WwaCYXlR0YzJRwiswjvIqYhazwrza5GuN?=
 =?us-ascii?Q?sonA1J6D/7Dx0msz30uRUHEqSuxSb/Xoy7HN8fG0uXer30YiQ76K0LaM8+XJ?=
 =?us-ascii?Q?0jkklhOJ8azb2sF61LOXL4yOdkfSdorPVKPejGafANz0tMYLG2n3hOJ8mKaq?=
 =?us-ascii?Q?1xpEjU4N4EJnYM6014HZkur6gZDftxiEtKSADOyoSe2KWqmP8yg6BzF8rWnC?=
 =?us-ascii?Q?guOVWqN7Q6fH3oog6P9WtVIfOZFb9ukdYWkPgIiTDlsPlUZLyT0nvGluuTVJ?=
 =?us-ascii?Q?LmKZXl/gHppntlkoLVtIvIJh/GEjBdT9J/tXDVHIOgKApNtn67jsXNH63suL?=
 =?us-ascii?Q?CF9XDFTtD2Q3gJj9Fa8rffDK50emNJEHj/aVFwQaIli2ifIGKdTWdZs/+8a4?=
 =?us-ascii?Q?n1nZt/EK4u0BpoG+FUg18JIOtCCkG74lbFGNf5oy4sD73YnMou++kXXlAL4C?=
 =?us-ascii?Q?KyWB5p4XDyrOCJUr/Bxwe+nrcXoJtg88szNDc233YF2o1wJ5BZIfOQkNYCAO?=
 =?us-ascii?Q?nttpDkyXr4p3USvOiQ9YTU6jAwgwsJWqkgUnVCRa+OGfu18ndKT2xaGchx4Y?=
 =?us-ascii?Q?keTAx/LvELPjoiPsuJFNXyDAw8Dw8WxZld9dDaky42c3gDv0m5ezG0MpWu54?=
 =?us-ascii?Q?Dd/oJaENjWFb3QSXpc+Y0lSY5aIkoIvoxamnn7TXpcQqFPeHbULaiI68tivP?=
 =?us-ascii?Q?NdwVvOsk5sHP3jTzayr26N11IC8wlqVm650ru61JqARbJg8my8putrKdlpR7?=
 =?us-ascii?Q?3n36DJ4m+jEoLW5wHAAbmPm9YnndpqMU9piKdQvqNiHLW8M5Q667X5B6wOE+?=
 =?us-ascii?Q?kcYGLGc6LQlPtVoN1sAvKSTPePIrGlRxHRbJmhIfLHcm7kaqp9f8puZcf1rM?=
 =?us-ascii?Q?EHBQKpb4+A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5753AE9D4D5B370D32242FFB937CABL1PR12MB5753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a72b920-0007-4d6b-4560-08de79ef4e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 13:09:44.9470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kriTC6y5tfgcNNAY2YFGy4K55axFIAVX7n21MVNRX1HMgqOb+ct8DjS4C8WOhiM1kvhQHsnboiz+Skzn4+K1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

--_000_BL1PR12MB5753AE9D4D5B370D32242FFB937CABL1PR12MB5753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Tuesday, March 3, 2026 10:41:10 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khatri, =
Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell xarray

In case of failure in xa_alloc, remove the queue during
clean up from the userq_doorbell_xa.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index 001fcfcbde0f..5224871a099c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -865,6 +865,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_am=
dgpu_userq *args)
         if (r) {
                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id\=
n");
                 amdgpu_userq_fence_driver_free(queue);
+               xa_erase_irq(&adev->userq_doorbell_xa, index);
                 uq_funcs->mqd_destroy(queue);
                 kfree(queue);
                 r =3D -ENOMEM;
--
2.34.1


--_000_BL1PR12MB5753AE9D4D5B370D32242FFB937CABL1PR12MB5753namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, -apple-system, HelveticaNeue, sans-serif;=
font-size: 12pt">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Ping</div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, -apple=
-system, HelveticaNeue, sans-serif;font-size: 12pt">
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sunil Khatri &lt;suni=
l.khatri@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 3, 2026 10:41:10 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b> [PATCH v1 1/2] drm/amdgpu/userq: remove queue from doorbell=
 xarray</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In case of failure in xa_alloc, remove the queue d=
uring<br>
clean up from the userq_doorbell_xa.<br>
<br>
Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index 001fcfcbde0f..5224871a099c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -865,6 +865,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_am=
dgpu_userq *args)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_file_err(uq_mgr-&gt;file, &quot;Failed to allocat=
e a queue id\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_userq_fence_driver_free(queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; xa_erase_irq(&amp;adev-&gt;userq_doorbell_xa, index);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uq_funcs-&gt;mqd_destroy(queue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(queue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D -ENOMEM;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5753AE9D4D5B370D32242FFB937CABL1PR12MB5753namp_--

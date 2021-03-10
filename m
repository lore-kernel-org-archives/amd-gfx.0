Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDCDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6A164F95
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6A164F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26476EA43;
	Wed, 10 Mar 2021 15:29:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E7B6EA43
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 15:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSNuwNPwoIMxB3jOU9bguZZi8b/esIaXS0WLF4YoE50bQ1qWYKljN8/OqKcYAkCvxMyOGUujniszQpVx+ksig+uBxdqFuPoQOlmPcT0mI8XAUtW8Z6iWDBAxcVZaMd7u0+03lqBvimaQ/WEswAnMoSBzJ25+IBcIj7arqm5J6pK42pUal+TsSsBfOdN3OGzqs8oMFkonesHXhsRHgF8a6qgKjI0zdFpCmrn5q2RU0gn04gVx08iH6OT/t/NAR3QhtBplJXTVGuo8SoKhrG4D0CTMMsrPClo5stvbA7/FRUfPi7Vc4myXlPy30E0MHrx8EuKAa2xjgIT7CYeRnNOo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TZtmWtRErLjhvDXVoiDAXO76Q6tfl0yVoy+9+Xl9NU=;
 b=bbkPUsdsuq4M8K+f7A8EyNIsLl0knfkQ6vX5IKmRvUyFrGsUypDrsXO5YAfeL6FDYSWrHvA8V3QyciIiiSMZE8yM0gOPXatGzhSiEJC/hrJ/z9dC1CFjTO9APZZdDWlSrocoPcP1jshwVibX0KMlDmP0bOGcwx6cJdgPgzovuwJNI6aDqw0dJXG738C8QGcyk6Pq1j6IugOK+UOKBMzRNQN5vz/+1KOtuW9CLYaW7KgkXmk8oQNPRqa7Ons+2WhOIDK8Ygg2F1qwoVdy62RzFFJZ1JEAbCfDL9KjhMQ/kp2+Yk8XgKldOS9x0RHgpoeooRoXqqreqxVRzxO1MyL7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TZtmWtRErLjhvDXVoiDAXO76Q6tfl0yVoy+9+Xl9NU=;
 b=l3fpTzCtJfZGinmLQfErdT2qDpvI+25zxRieg3+QHaa9cv36LxqT4UyeldRqAefgBruVErUz8CdBDEeWMuFVByiuYd4o6dOLzon0nuoIO7NtPrPSxcsnfBOWyaBfc9z2I4X7OtwRcuZCGftqEPDj8xJ4IsOsknk0zVdNEeTPb2Q=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 15:29:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 15:29:01 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: remove duplicate include in
 amdgpu_dm.c
Thread-Topic: [PATCH 2/2] drm/amd/display: remove duplicate include in
 amdgpu_dm.c
Thread-Index: AQHXFcG7xYnelyD/+kyCAAA7dPBTKap9WHE6
Date: Wed, 10 Mar 2021 15:29:01 +0000
Message-ID: <MN2PR12MB4488ECE03EE8D03EA13AC452F7919@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210310152607.33953-1-Anson.Jacob@amd.com>,
 <20210310152607.33953-2-Anson.Jacob@amd.com>
In-Reply-To: <20210310152607.33953-2-Anson.Jacob@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-10T15:29:00.872Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd7617f8-855f-45e4-cb81-08d8e3d93b4c
x-ms-traffictypediagnostic: BL0PR12MB4995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49952D01D06A3026B9523D16F7919@BL0PR12MB4995.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1XxceWCbP6F2eYZhZL+ub314JtyKT2U3FGPvyy/0Og139a4X2zCgMCMIRBPFqaMebZUHmjkieFfzXpdmoUzTWKtUwxTqWieEXTzTL7UWaISs6p3VsOS5QK6na9SQ1h60usygz0f6S9FosuGBFmV+epZL9BrcrXnIhNXrCs/5QyyxV3IZcuumVxWuNoGSMQXfOuPA7hSjKWVHDLPGf+nHAJ9Rboh5GOsZCJAH5cMcLLHKJrdK91VzKqKcdcGlfOhkRbNq0fZZBx+X9yA5mIaF8JB+SpzldAL5Sq6jd1vuBL+avYU9u9ljDqxlorVueE5onxxh3ub8geJh9/u97eyKzJYB64vkjpTUjNlS85z+jAnqUEnv+u87OmGjWpIgXMtZpvjhiY/gjKOa36bf5vQl8jmhVzf8kQmV83OBXHK/Bdvx8g1ZgsL59g1E42/GYtujFYHgMPImLyCXS5lL97U1Kp9DyIqZbpzVxax4C/OjIVPQNH193+tBAae0FvD5msrwdUui3zmrtFGZPmruMTha3S9WYipqHR+bDm3sBJ+V8WxByFMkw4Q9qSd4YgkIjpt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(55016002)(86362001)(76116006)(186003)(19627405001)(66446008)(64756008)(66556008)(66476007)(2906002)(9686003)(110136005)(26005)(8676002)(45080400002)(66946007)(478600001)(71200400001)(966005)(4326008)(316002)(7696005)(5660300002)(166002)(83380400001)(33656002)(52536014)(53546011)(8936002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?flBgnArfL1wzAQ83IeSbDXVBp7rwN+37br/ZUM9aZN71fv8N3jxrhdmKe9VB?=
 =?us-ascii?Q?hRcGNFYB/uSXPzvG3YSmiql84OZw/2hH4lZDyd/CtNomEXHgApgK1yRUnWL3?=
 =?us-ascii?Q?+Xeury0iOd4VA/ZEgqJGjkBcyKAo3ESYB8dBlp7zp8BzLakpGjFdJkj0Q18B?=
 =?us-ascii?Q?dB7drG7GtDaIjfx7FgEQXn0PfJq4fO5Yrny8uSjk9INaZbROyqidJTdjQQtN?=
 =?us-ascii?Q?q37Cw6LJBTI6O2q8YlRcdBC47+mxTfpP9Sn+QlYWyDimxm94ECuBGr5po92N?=
 =?us-ascii?Q?olhJn5QvmKm/ZEuIRCWABDeJ56AJzD0cw1fmXiRkPRQ+sxtG/eu2JyJ20kyj?=
 =?us-ascii?Q?FqF+x/6II0dDwArJNouBG9cTgzSznAUG5dTFhBmDunOhvwkX1EnaYcwDf6pM?=
 =?us-ascii?Q?Ra0AYo4W6S0jGX2E5Q0QxT1F7ShGGHWwEYFFzUZTdqjMh1IVG8YrHLjxtEPV?=
 =?us-ascii?Q?2LcSO7y0Y2gPyN3+lr02WgKtuMJNdcPfMK72uBdkg1y+YAbZ5qdrAX2y8c/Z?=
 =?us-ascii?Q?yf498yWgYIlooj5H0PwYEczdly6IkafjeHnoKm4S3opvFmcqwka5vnTvLbzQ?=
 =?us-ascii?Q?LaFkTu5jsDcbOVSFjykSD6R7Vl7x5VBbct8kO93YwN9S86lNtnHW2LxsINmD?=
 =?us-ascii?Q?AtUPnAVGpU8TIbU1r2hOKrNrCfdKgGQglFBMt8E3yjMXaM+W6YeO00pdnLxm?=
 =?us-ascii?Q?N8rKhKT0OFsP+mf6J3yF56p1slJ7JRSSnrCEZhy8UwGHW3guYjsF+tlUFMOi?=
 =?us-ascii?Q?qQ3eBLWsSL2QXtwWs/9Z+hyescnejaIBpSWUt+kODRd5NW4ctlSIxaWyzXmJ?=
 =?us-ascii?Q?TtWcDRHwpJX9PzsVg7fP3hjkb4Q2FpJvPYhaPLxe6JEhf7X+PDw7g8L5tM5q?=
 =?us-ascii?Q?WJ0RR/zuKMjBBo7xE1gqA6IftqGCkGICRbzo1cyzJ9lTUNx//oFeb5eF8RyU?=
 =?us-ascii?Q?Woy8Q3W5SReTYpN137Wtzxmsstn+/P6fY6PZrWlzq0WVanVAXiZ1MPiRTwq4?=
 =?us-ascii?Q?ip46Q+d8MLEdrHJYaEJ29aPu7cxYtaoAwe8Hnenj0JfD2uIZZYSd7SSNVeVM?=
 =?us-ascii?Q?Qt07ZgGoWVKAtigGg8pq0pkIOSpzNFDpkFYq4Os5gaxoI+msOT6MhQ/kBwPo?=
 =?us-ascii?Q?cWR8NBYocFdzt7VC8AFY2aWlDVExByN8EUndET4UwrqzrN/PTWLwPRCi5xKU?=
 =?us-ascii?Q?EYU1uzxnu2DXLPb3y88txpsRg8+I/ehR262cnynXw1wgpWXjf/eNilCYImrS?=
 =?us-ascii?Q?ee9waxBPqoYczq6KT+oSvCD+octIbSuCxCNnGIq3cf45D7kPHv9YzFBM+2eJ?=
 =?us-ascii?Q?ZCEnGp0AGpAT2df6o90nDzcJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7617f8-855f-45e4-cb81-08d8e3d93b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 15:29:01.4107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5GKSyRUovwF/mS9WM3IEaXxVYheg6/ApMYsjK46qfJ7/ntTKkUcAZ2drWtAUe9nNMKqV/aq7Qv3F0h4ZPmevIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
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
Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Content-Type: multipart/mixed; boundary="===============1947671699=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1947671699==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488ECE03EE8D03EA13AC452F7919MN2PR12MB4488namp_"

--_000_MN2PR12MB4488ECE03EE8D03EA13AC452F7919MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Maybe just squash this into one patch?  Either way series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Anson Ja=
cob <Anson.Jacob@amd.com>
Sent: Wednesday, March 10, 2021 10:26 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jacob, Anson <Anson.Jacob@amd.com>; Zhang Yunkai <zhang.yunkai@zte.com.=
cn>
Subject: [PATCH 2/2] drm/amd/display: remove duplicate include in amdgpu_dm=
.c

'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is duplicated.

Reported-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b5a75c73ad71..f9513c5ca2b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -76,7 +76,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
-#include <drm/drm_hdcp.h>

 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cdd52479bfffd40b27d9e08d8e3d8dbb0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637509867847855120%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DpJYigzOJYdGcIGSlfFG41GkPNRc%2BipBcRF5KDIcHL1I%3D&amp;reserved=3D0

--_000_MN2PR12MB4488ECE03EE8D03EA13AC452F7919MN2PR12MB4488namp_
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
Maybe just squash this into one patch?&nbsp; Either way series is:<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Anson Jacob &lt;Anson.Jacob@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, March 10, 2021 10:26 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; Zhang Yunkai &lt;zhang=
.yunkai@zte.com.cn&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/display: remove duplicate include in am=
dgpu_dm.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is dupl=
icated.<br>
<br>
Reported-by: Zhang Yunkai &lt;zhang.yunkai@zte.com.cn&gt;<br>
Signed-off-by: Anson Jacob &lt;Anson.Jacob@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index b5a75c73ad71..f9513c5ca2b8 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -76,7 +76,6 @@<br>
&nbsp;#include &lt;drm/drm_edid.h&gt;<br>
&nbsp;#include &lt;drm/drm_vblank.h&gt;<br>
&nbsp;#include &lt;drm/drm_audio_component.h&gt;<br>
-#include &lt;drm/drm_hdcp.h&gt;<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;#include &quot;ivsrcid/dcn/irqsrcs_dcn_1_0.h&quot;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cdd52479bfffd40b27d9e08d8e3d8dbb0%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509867847855120%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DpJYigzOJYdGcIGSlfFG41GkPNRc%2BipBcRF5KDIcHL1I%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cdd52479bfffd40b27d9e08d8e3d8db=
b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509867847855120%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DpJYigzOJYdGcIGSlfFG41GkPNRc%2BipBcRF5KDIcHL1=
I%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488ECE03EE8D03EA13AC452F7919MN2PR12MB4488namp_--

--===============1947671699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1947671699==--

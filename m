Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC3C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 03:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C6620773
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 03:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C6620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335FF6E947;
	Tue,  8 Dec 2020 03:43:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C7E6E947
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 03:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFFAqAA6Z4jRVCIX7m8Fm3gcLyTuMjkskn9Ja2KlaGPnOMb8nGqHbW6Z1xGD7LrXRpiyI7IacY6qUlANXsDVTBLuhqs9gRsF9MuADVTWyfoQynxCXIMH4w/7hp2jhC4JlRnPRx2MVXBF9tWrIjhBsxoPp17GX5T8eZUdw8VdNaz8GmHdNG9y3XUGmd0u0kBLUSgxVuxogJTmH1rplBgteO03fTEKtDOJAdNgxsmRyEiZoJI69rGR1JaZ2muE7qr7r16pO+mlJl8QMWXIlhBjW+vG843sB4QK3sZ4NWhipyhvZ7tqnci9ZaUzYhBYdRDMOTB6bA2FgcfyFzQ9O9exCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fvOsmKMsf6R+0OeffW3TXZm+ZIRFcbGLvjuYigcMlU=;
 b=aYteVUlHz6m2FiINirD+LzzK1B+Lvf+EdE4zz53Gp5Q6rpgTjwG1/clCAGNyjqCtGtRhwq7w8YNhJ0v77+TCxcNYRPj9LT8avsfLbxbAldsvCLrQeerZR9Tmo0BgkdJW9kGaOaKbE3XMQS3cOYaldQdLSghnD9UqU8q+TtrTdnts2MDElrCbUXFQT+nnCrpLJZAgJhZQi+RugPZByMF7kRvwx0DdqXzSPWeGFkK26XNTV0AGmh1y6YM1sUgyf3JkfsRmmYj6Ol641FjlyhJXfgUg3u3xi48fWmr5z0Yx29NYYfD0f7iZ939U48++F1eKrDGg56nuXLWpHivOzR76Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fvOsmKMsf6R+0OeffW3TXZm+ZIRFcbGLvjuYigcMlU=;
 b=ia8c7JNn5kq/bRNCoRH3o1HSHpk6jYHCXt+y//te+3ltLcYoCk28l1LcOQ8cMP1yFBijS1ZrUbGOnwt8X1vOmYXL53oj+xjf1Ww6IpkJSfzMnLNr9s8qmMesCPkwx9S7svWlAvqoxRfr3eSXEBrJ5uE0WwFBsHFQBQJPU/Btag8=
Received: from BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 03:43:11 +0000
Received: from BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::92c:21db:bd9f:52e1]) by BN8PR12MB3220.namprd12.prod.outlook.com
 ([fe80::92c:21db:bd9f:52e1%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 03:43:10 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Index: AQHWzICrc/N3LKZC5kGSJFMZp+FvVqnrz6uAgACrUsk=
Date: Tue, 8 Dec 2020 03:43:10 +0000
Message-ID: <BYAPR12MB32222491A1C7877B86C69B43E1CD0@BYAPR12MB3222.namprd12.prod.outlook.com>
References: <20201207100623.1353365-1-jianzh@amd.com>,
 <DM6PR12MB407541859F78FDB91937FB43FCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407541859F78FDB91937FB43FCCE0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T03:43:09.893Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f74df8a-c26f-4cf4-eb2d-08d89b2b623b
x-ms-traffictypediagnostic: BN7PR12MB2740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2740E16C7A8AF7371792EFABE1CD0@BN7PR12MB2740.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bR+mQo0YMEY3AFsQKEvbW9r7yYqd0q6QvgZJdckYz4CGg0kJfxeu2Ga8Y3XBuy3UgRciYrk6t4Xe7dZnuZbQ6qmKIy447Jr8sDOObau3UD/+zUhFS0zas2/iuhectlRfNN8dpvH+mxupoiIxrc/OhzpQefHRlz+P7T6IS990NJq1w/9yXUQBOJBWh7KRSuIH2jAZj77vZZUaT9QxXxKDto+7frI+dzdM5E/COEq/8coegglhXBv6F9P9eYY6JCavABDWt4+SICziktsjzOfynYpQb8MZBQbqNkHFxBD8LTY4I+wproR0LauoF28zPMVX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(6506007)(83380400001)(66446008)(71200400001)(53546011)(19627405001)(54906003)(76116006)(64756008)(66946007)(91956017)(33656002)(8936002)(316002)(2906002)(186003)(6486002)(52536014)(26005)(110136005)(5660300002)(4326008)(86362001)(66476007)(9686003)(66556008)(478600001)(6512007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iZIvzlthTxwTTrDnOa8cPwitWp6PgQWLR6NWGYLqhqnPJzGtmKCYxQCk/fiS?=
 =?us-ascii?Q?cp6FUm/yKsWoXOvtz/8BBhy1vramveK/Brcy8ZsbwlI5s9rGLIdEa1aI4n7r?=
 =?us-ascii?Q?+2JJLJfnV1X9bCSTCxV2JvS48GZ67PS8tJu5gzaXpxvQNJ+/s+tnRogFVdal?=
 =?us-ascii?Q?YozWnu5ZJ5PgZJthGMEjVSAO8yVQjg7ZYvz2Clz96k8cdE/H24xKjtHYtSKb?=
 =?us-ascii?Q?ZX+7dvL1mHlTEFQmRmev1Hkxb84LF7IwOGCKO7xbmpB/j5vx82n2rLzUgMkB?=
 =?us-ascii?Q?1c2Uddt0w7G6NMpLHEc80etoIoxvgwKO6gLmSyYUB3p9dLy2v9McNUWu+Nww?=
 =?us-ascii?Q?oNcosol5kMamOTikMIW9U1kM6yll5QgdbvdTdabT6uMz7DcAR0q7slp6aP9I?=
 =?us-ascii?Q?obUlwbmUxnEbDDZzgGqRAE8rO20ivj6oWnD0vgLo5c5SsKR4YkmPt1krMO8a?=
 =?us-ascii?Q?QTCJNgBKaRuVLq4vUU/uPz6FmqWShMS0fB6pW3M647btw0dVsg0EFQtRkD3t?=
 =?us-ascii?Q?3U7cj55zy9apAVnT7Fhx1XoMqvBimIHpAs1O0JDOgXbm6Bw28iWjfOy9doAu?=
 =?us-ascii?Q?C/kXQaH6uS1GWYb6A7VIkZpHO9gP7ilSYd4hDgWOrm1+uQDGJARCx11qaKT2?=
 =?us-ascii?Q?LQUr4eSfwkHHxE/wj+hUEEn4GH4zDAvf14U1fO2B5+KqSTfU9NDtPuhibpBC?=
 =?us-ascii?Q?HLxNYzcRJGlHohACFvLyFlci9bt/QPNCc8o7lezwyuu+kHri87H4yyjbR79h?=
 =?us-ascii?Q?E2mEgQf3/RVu9KAY4sXZrPg5vvpCAhCZmeCZOG37GIvJDyPETsBeI2BMeEkB?=
 =?us-ascii?Q?yHBM5o/rajUc2jfKSp+pqQso2zOJq835HTW2uhYJze7zH/IvI4O0a8HdJMo6?=
 =?us-ascii?Q?8ChkcEl/eSoXwFdx2BRail9xE6ftffIqeCuHVOSxO3d36C84Gg+nWoEc3vL7?=
 =?us-ascii?Q?TdJh1zAcMSUyHUCVuSDSL6wSQA4f6UqOLBgg8/ezUXs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f74df8a-c26f-4cf4-eb2d-08d89b2b623b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 03:43:10.5728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxX5Fd6UbmNZvkblB8+pLVXR/IouoFrUofP3CMet85G0amfTDMro9et5dfRbJacQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: multipart/mixed; boundary="===============0180434193=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0180434193==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB32222491A1C7877B86C69B43E1CD0BYAPR12MB3222namp_"

--_000_BYAPR12MB32222491A1C7877B86C69B43E1CD0BYAPR12MB3222namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Hawking,

The process is to send request first, and then to poll and wait 6 seconds.

So the time delta between the 1-st request and the 11-th request is actuall=
y 60 seconds.

Jiange
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, December 8, 2020 12:16 AM
To: Zhao, Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Chen, Horace <Horace.Chen@amd.com>; Zhang, Andy <Andy.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period

[AMD Public Use]

Re - Poll happens every 6 seconds and it will last for 60 seconds.
+       int ret, i =3D 0;
+       #define AI_MAILBOX_POLL_MSG_REP_MAX     11

The definition seems not match with your description that the polling will =
last for 60s.... with that fixed, the patch is

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhao, Jiange <Jiange.Zhao@amd.com>
Sent: Monday, December 7, 2020 18:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.c=
om>; Zhang, Andy <Andy.Zhang@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period

From: Jiange Zhao <Jiange.Zhao@amd.com>

In Virtualization case, when one VF is sending too many FLR requests, hyper=
visor would stop responding to this VF's request for a long period of time.=
 This is called event guard. During this period of cooling time, guest driv=
er should wait instead of doing other things. After this period of time, gu=
est driver would resume reset process and return to normal.

Currently, guest driver would wait 12 seconds and return fail if it doesn't=
 get response from host.

Solution: extend this waiting time in guest driver and poll response period=
ically. Poll happens every 6 seconds and it will last for 60 seconds.

v2: change the max repetition times from number to macro.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-  drivers/gpu/drm/am=
d/amdgpu/mxgpu_ai.h |  3 ++-  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++=
++++++++-  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index f5ce9a9f4cf5..7767ccca526b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_ai_request_reset(struct amdgpu_device *adev)  {
-       return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
+               ret =3D xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev, dif=
f --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgp=
u/mxgpu_ai.h
index 83b453f5d717..50572635d0f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,8 +25,9 @@
 #define __MXGPU_AI_H__

 #define AI_MAILBOX_POLL_ACK_TIMEDOUT    500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT   12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT   6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT    5000
+#define AI_MAILBOX_POLL_MSG_REP_MAX    11

 enum idh_request {
         IDH_REQ_GPU_INIT_ACCESS =3D 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 666ed99cc14b..dd5c1e6ce009 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_nv_request_reset(struct amdgpu_device *adev)  {
-       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
+               ret =3D xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev, dif=
f --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgp=
u/mxgpu_nv.h
index 52605e14a1a5..9f5808616174 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -27,6 +27,7 @@
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT    500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT    6000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT    5000
+#define NV_MAILBOX_POLL_MSG_REP_MAX    11

 enum idh_request {
         IDH_REQ_GPU_INIT_ACCESS =3D 1,
--
2.25.1

--_000_BYAPR12MB32222491A1C7877B86C69B43E1CD0BYAPR12MB3222namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Hawking,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The process is to send request first, and then to poll and wait 6 seconds.<=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
So the time delta between the 1-st request and the 11-th request is actuall=
y 60 seconds.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 8, 2020 12:16 AM<br>
<b>To:</b> Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chen, Horace &lt;Horace.Chen@amd.com&gt;; Zhang, Andy &lt;Andy.Z=
hang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait =
period</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Re - Poll happens every 6 seconds and it will last for 60 seconds.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define AI_MAILBOX_POLL_MSG_REP_MAX&n=
bsp;&nbsp;&nbsp;&nbsp; 11<br>
<br>
The definition seems not match with your description that the polling will =
last for 60s.... with that fixed, the patch is<br>
<br>
Acked-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Zhao, Jiange &lt;Jiange.Zhao@amd.com&gt; <br>
Sent: Monday, December 7, 2020 18:06<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, Horace &lt;Horace.C=
hen@amd.com&gt;; Zhang, Andy &lt;Andy.Zhang@amd.com&gt;; Zhao, Jiange &lt;J=
iange.Zhao@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period<br>
<br>
From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
<br>
In Virtualization case, when one VF is sending too many FLR requests, hyper=
visor would stop responding to this VF's request for a long period of time.=
 This is called event guard. During this period of cooling time, guest driv=
er should wait instead of doing
 other things. After this period of time, guest driver would resume reset p=
rocess and return to normal.<br>
<br>
Currently, guest driver would wait 12 seconds and return fail if it doesn't=
 get response from host.<br>
<br>
Solution: extend this waiting time in guest driver and poll response period=
ically. Poll happens every 6 seconds and it will last for 60 seconds.<br>
<br>
v2: change the max repetition times from number to macro.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-&nbsp; drivers/=
gpu/drm/amd/amdgpu/mxgpu_ai.h |&nbsp; 3 ++-&nbsp; drivers/gpu/drm/amd/amdgp=
u/mxgpu_nv.c | 11 ++++++++++-&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h |=
&nbsp; 1 +<br>
&nbsp;4 files changed, 23 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c<br>
index f5ce9a9f4cf5..7767ccca526b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_ai_request_reset(struct amdgpu_device *adev)&nbsp; {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_ai_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; AI_MAILBOX_POLL_MSG_REP=
_MAX) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACC=
ESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev=
, diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_ai.h<br>
index 83b453f5d717..50572635d0f8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
@@ -25,8 +25,9 @@<br>
&nbsp;#define __MXGPU_AI_H__<br>
&nbsp;<br>
&nbsp;#define AI_MAILBOX_POLL_ACK_TIMEDOUT&nbsp;&nbsp;&nbsp; 500<br>
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 12000<br>
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 6000<br>
&nbsp;#define AI_MAILBOX_POLL_FLR_TIMEDOUT&nbsp;&nbsp;&nbsp; 5000<br>
+#define AI_MAILBOX_POLL_MSG_REP_MAX&nbsp;&nbsp;&nbsp; 11<br>
&nbsp;<br>
&nbsp;enum idh_request {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_GPU_INIT_ACCESS =
=3D 1,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c<br>
index 666ed99cc14b..dd5c1e6ce009 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_nv_request_reset(struct amdgpu_device *adev)&nbsp; {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; NV_MAILBOX_POLL_MSG_REP=
_MAX) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACC=
ESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev=
, diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.h<br>
index 52605e14a1a5..9f5808616174 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h<br>
@@ -27,6 +27,7 @@<br>
&nbsp;#define NV_MAILBOX_POLL_ACK_TIMEDOUT&nbsp;&nbsp;&nbsp; 500<br>
&nbsp;#define NV_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp;&nbsp; 6000<br>
&nbsp;#define NV_MAILBOX_POLL_FLR_TIMEDOUT&nbsp;&nbsp;&nbsp; 5000<br>
+#define NV_MAILBOX_POLL_MSG_REP_MAX&nbsp;&nbsp;&nbsp; 11<br>
&nbsp;<br>
&nbsp;enum idh_request {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDH_REQ_GPU_INIT_ACCESS =
=3D 1,<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB32222491A1C7877B86C69B43E1CD0BYAPR12MB3222namp_--

--===============0180434193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0180434193==--

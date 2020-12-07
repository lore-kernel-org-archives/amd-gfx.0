Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42685C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C015622582
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C015622582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC8E89286;
	Mon,  7 Dec 2020 08:14:34 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99D28910A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 08:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZUaFIOn2eRggxT9IDg0aaYrQF0D0il+HLWO6WFs5/cmLUaNzjiv7Rl9dbkjwROKhRwBsuW0ylP55FGH9Iha00E9mq9LaGfch+RILS41XJzcsMrKlW/80OXYslvEEw0TmLgfQsZDSr1llRsE+trPYNiLd8CIxVOcaFCOeM7GTS4Xar4vPrHvtgfxMoSUo6wuPNKWa930JQEQEXt43CVGXRuQQSgc2T5nrsJmXNCi99MLVC0HqWMTwSbmGXkcsy4Mm/fbOV36j8QtaNNzBJr3f3jr54T7LxKWAw54j4C2URp0XRjy3aCRVfRU6/i77ZEniLGiuArwvXhO+3EBsWxRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq4qKb7WXvg89vfKIzGFgIV7PQQIUdM/9MM04xUCczo=;
 b=HnUBU5uu5QDMfEOjFIx7d79La9IddbvCJTWW8bXFGRuUqyyZ085dIPyxF63v07nHHNMS3TY9u6jvteLBTqGhAlJHwLst0ZfFLhT5aymPyBlwoy7mrHowFVS0oD/3c1yPK36om/CvWJ5XXGebmYiaEzk7LcMzCQAzGif0A8gMw/n+rzQD67MB/AcDbCpL1ivao+vdTI4+BsjKmcNTnMQPR4qMAqpze3VSGka+11Sa+nZGtqbeZUAUYfUN695xDReks9AZBv89vrosRmNDxOq4AosariqFisHoTdPvqEQQTyJiBXxliRi2O+SXmBExY2if2D67v7rB+kZFALr0t7o5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq4qKb7WXvg89vfKIzGFgIV7PQQIUdM/9MM04xUCczo=;
 b=XJdI2SXDzJFr3ZULeNWjtVEbqTbZBszTlxq+li8McxqPyy+JCTIlZ/HmZb+7Ym90uIoWLkPAP5c7cM5hJW16qnQI0e+AB6DB5eb/R6Z5gvj9cOuYKTOm9qhPBkYFMXYDKkr32ZdUB04UWVV08rolBQxNvJj37AbdG2Id7Ix5DZ0=
Received: from BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 08:14:30 +0000
Received: from BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::9c89:cf2f:2184:1b16]) by BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::9c89:cf2f:2184:1b16%5]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 08:14:30 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Zhao, Jiange" <Jiange.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Thread-Index: AQHWwzTBL5mW4YDs30uWVrMjNCey5KnrW3mV
Date: Mon, 7 Dec 2020 08:14:30 +0000
Message-ID: <BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0@BYAPR12MB3222.namprd12.prod.outlook.com>
References: <20201125141012.301219-1-jianzh@amd.com>
In-Reply-To: <20201125141012.301219-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T08:14:30.204Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9959fcc4-9617-444f-a53e-08d89a881f99
x-ms-traffictypediagnostic: BY5PR12MB4321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4321A996CB6998AED4BA1E2CE1CE0@BY5PR12MB4321.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DBaMiU/S2FrgtDwAqwmdnWCU6eDACpo3dOljhKVPl/4f7apwrgmofF+uUiVBf3I2xbga6mcNMfQQ2jNNidM68/IzNQKvA2PQzuGZZfCj8GiO60QvtHtbLG4/XqmktDds0zZ/rE+5QXUbNi8glaOO0eMLtKXbT5P+CfonNrN/u1fzvsREJEwF4IgS5bvYjlE3xL2FTe1rxDux6g+kn7xQZgupMKGVzNUSWILGceNA5/J5CaH5xhMrqpRAfSTAYw2j7mb707QxqsoS/NjE4RjCGEXqnHitiXBgIY6V0vupekcRZjk3NyqUX81H/WcsQSnK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3222.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(8936002)(64756008)(71200400001)(86362001)(8676002)(91956017)(83380400001)(26005)(6506007)(316002)(53546011)(478600001)(110136005)(66446008)(186003)(19627405001)(7696005)(54906003)(33656002)(66556008)(9686003)(66946007)(52536014)(55016002)(2906002)(76116006)(4326008)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?47wB6pLmSdw7ntYbecVlOT5H+gyXJnabHIIqyYbLDlnnDegedp9eW9Drfw2y?=
 =?us-ascii?Q?Zb1HFv43lu3JFF4ROQiuTwoA6kn9IlX4DtdrfMuL5KB3ffrjjw8HH4n8K3hb?=
 =?us-ascii?Q?W5D4PL4H6kL0SCFDgJdHebV729XRdxpglYey38qnUdC5dRn7d9kjhGtLp0KN?=
 =?us-ascii?Q?/FfAsYjKg3CQ1JyKSnGtSL9KtDaUwRDA2x6rwoTyCnWCNqZzC+FVxZL2U05I?=
 =?us-ascii?Q?TMCgJGAEWpPnjORIf59nlZKxDhXNDcyFQTOfdRSShLTGETtUsdvnDGeMf4DH?=
 =?us-ascii?Q?MEC2G5BGgy4sqfPrJVsamlEn1dpCG8ArIoQz4ZmQv7kyguqxG9CBEBYKtUWA?=
 =?us-ascii?Q?dfPBXS+bOiLsZTJPsMiLt+q39VZw/cBH7plI1jpd/42p6PLc8CrGtCLGdsXF?=
 =?us-ascii?Q?Hyijh1sRH3Iu8ug84diUeCmGUs8OMWSLuhkvtS2PbHROHhgOHvLxPNnbLl7q?=
 =?us-ascii?Q?2PNnpecH3artJ8TXbSg6x05yYxd43K2jsIJ5FGCnpsRC++ulpdgHAptAG6fy?=
 =?us-ascii?Q?JYvr99XJEA+IMZj4auAB6CmrNLvjgMlEmXkm1yM6EkZmRBzfQLrsu2S+Y2Up?=
 =?us-ascii?Q?an1xK2vi2ilffm9tBwQO2WVOTsYUrVsTmJwnU5Dy5NdPk1TjxS66HSW6yxlf?=
 =?us-ascii?Q?XO1Z6hE7pwToIWDn0kGvCba7tdgdj+WEvqvPHiePMmhhu9odRWROCrRfNHCS?=
 =?us-ascii?Q?2d+MBbizWZRiTyzvXLdBvWFjNJdThwcUZ2WnmpJPAMDBEd2lU2bZ2042Z6aL?=
 =?us-ascii?Q?t5iBtB9Hwe9ITCu+EslyI7JwyQESuUVZagEzQy+4CWdR3p3rrlFglCD2noXm?=
 =?us-ascii?Q?Wmg4DAezmwznV3+3H+VaKKX/K9LVL2wP/GKhpT69pNSJt63aNUPYPOh4Nt5b?=
 =?us-ascii?Q?6S4mxI0eJDE/SFaka7xEEQdtqCBFIljyFiDYJ/oytQbS3jVO0GVNhEm9IdGu?=
 =?us-ascii?Q?PQqk0oMbKLq2znK486VEawnkdncQ74oIrm5Sf23VAp0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9959fcc4-9617-444f-a53e-08d89a881f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 08:14:30.8458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ79QiJpukp1ZSQgYyY4gC298MS/cLsKRITYaeRPkpruCAuWMXyetnZcPzmKzy77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Min, Frank" <Frank.Min@amd.com>
Content-Type: multipart/mixed; boundary="===============1714241086=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1714241086==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0BYAPR12MB3222namp_"

--_000_BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0BYAPR12MB3222namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

ping!
________________________________
From: Zhao, Jiange <jianzh@amd.com>
Sent: Wednesday, November 25, 2020 10:10 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Zha=
ng, Andy <Andy.Zhang@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period

From: Jiange Zhao <Jiange.Zhao@amd.com>

In Virtualization case, when one VF is sending too many
FLR requests, hypervisor would stop responding to this
VF's request for a long period of time. This is called
event guard. During this period of cooling time, guest
driver should wait instead of doing other things. After
this period of time, guest driver would resume reset
process and return to normal.

Currently, guest driver would wait 12 seconds and return fail
if it doesn't get response from host.

Solution: extend this waiting time in guest driver and poll
response periodically.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index f5ce9a9f4cf5..d8d8c623bb74 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
-       return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < 11) {
+               ret =3D xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index 83b453f5d717..20ee2142f9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,7 +25,7 @@
 #define __MXGPU_AI_H__

 #define AI_MAILBOX_POLL_ACK_TIMEDOUT    500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT   12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT   6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT    5000

 enum idh_request {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 666ed99cc14b..0147dfe21a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,

 static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
-       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS)=
;
+       int ret, i =3D 0;
+
+       while (i < 11) {
+               ret =3D xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESE=
T_ACCESS);
+               if (!ret)
+                       break;
+               i++;
+       }
+
+       return ret;
 }

 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev,
--
2.25.1


--_000_BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0BYAPR12MB3222namp_
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
ping!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;jian=
zh@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 25, 2020 10:10 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Min, Frank &lt;Frank.Min@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;; Zhang, Andy &lt;Andy.Zhang@amd.com&gt;; Zhao, Jiange &lt;Ji=
ange.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait peri=
od</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
<br>
In Virtualization case, when one VF is sending too many<br>
FLR requests, hypervisor would stop responding to this<br>
VF's request for a long period of time. This is called<br>
event guard. During this period of cooling time, guest<br>
driver should wait instead of doing other things. After<br>
this period of time, guest driver would resume reset<br>
process and return to normal.<br>
<br>
Currently, guest driver would wait 12 seconds and return fail<br>
if it doesn't get response from host.<br>
<br>
Solution: extend this waiting time in guest driver and poll<br>
response periodically.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-<br>
&nbsp;3 files changed, 21 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c<br>
index f5ce9a9f4cf5..d8d8c623bb74 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c<br>
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_ai_request_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_ai_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; 11) {<br>
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
,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h<br>
index 83b453f5d717..20ee2142f9ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h<br>
@@ -25,7 +25,7 @@<br>
&nbsp;#define __MXGPU_AI_H__<br>
&nbsp;<br>
&nbsp;#define AI_MAILBOX_POLL_ACK_TIMEDOUT&nbsp;&nbsp;&nbsp; 500<br>
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 12000<br>
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT&nbsp;&nbsp; 6000<br>
&nbsp;#define AI_MAILBOX_POLL_FLR_TIMEDOUT&nbsp;&nbsp;&nbsp; 5000<br>
&nbsp;<br>
&nbsp;enum idh_request {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c<br>
index 666ed99cc14b..0147dfe21a39 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c<br>
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static int xgpu_nv_request_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xgpu_nv_send_access_requests(a=
dev, IDH_REQ_GPU_RESET_ACCESS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; 11) {<br>
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
,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB3222F97D3A02992B2ED3FC7EE1CE0BYAPR12MB3222namp_--

--===============1714241086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1714241086==--

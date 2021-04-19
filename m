Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFEC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E08611F0
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E08611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99BF89F1B;
	Mon, 19 Apr 2021 15:42:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4584C89F1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 15:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoZhvrgsEzlpaLfMe/dEp7KevR2lpzdixWPG0DdYXsOZS06lZa/Uo22cCwREqqEOWO+RULTk5PcwB0sDadDqK4oNXIYJUhPJHholNFXXRgmWjTJzVjX1DWJVH2fmnEThdTtfyNzQjx2Eh4o7J0hzLgfcQFST6NReuMySxr/9dzIykWLyljPjdG3pNEBQi/JaL22de0Ba7iFIr2l73YafMybDDYUyAFJvHQzCR3sYO0oqm38B1d4sH6/GzjTIYXe79rdZ9umbCzlEvrk82Gj1sk2c5SKHIiCM0+NgbJR3c4Men4SKXsDETlgxLrcDmz+/leTH5bG2XwqdGNtA++WyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpHBDzL66DJ6gLX/xtUIegggO53OQNP611RSVyAmNqM=;
 b=RHqOpLfOqXurNUGY0D6HtyVvNXdgQrgoBBiOMBLt2A79MBCSreIzpcWML+sSuywykp/e8zdDI647UGcYClfphzBampoImZx+srTVug6qduFea1mrg5vDRZ1/oKKUD+IscDNVBoY0BtiOT3j5O9a57Eh0m9hiwtkjMx+ipg1S4qAOaXzGemhfd6LD6S46Cun2vGqS+SHkCHxy38UDFR+dZ+QuWIjTPVseTJTl8SLr6p3sdnjQZRlLwUxbRwv10nw2cVHHyQBrtCF4r6phJlFWZlqkTAWMG+XI+OIHGtYTq3+miTXh+HO/47Huv9e3+a8c4/Gyqx5TwKOn/YpwsiOkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpHBDzL66DJ6gLX/xtUIegggO53OQNP611RSVyAmNqM=;
 b=azmNnwbroyInyH6sfJLb3qR1t+4HIHQGmeiQy0iF+p9og8KRvHa0RI9fFRjiPh+4EKSpfZnAVhclsuA95glEVPyQ7mjsDTk9kuE36J7gAlVJgX7eo5Z0nVjQBjONOWsSGUUigtXESLVyne5gdZZdrSdBWn7gAu1o1yza8gShAVE=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 15:42:16 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:42:16 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 13/19] drm/amd/display: force CP to DESIRED when removing
 display.
Thread-Topic: [PATCH 13/19] drm/amd/display: force CP to DESIRED when removing
 display.
Thread-Index: AQHXMs2iXpLQCev5f0yfySJXNPGzVqq7/whv
Date: Mon, 19 Apr 2021 15:42:16 +0000
Message-ID: <CH0PR12MB5284E53E08A23F2E2965499B8B499@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>,
 <20210416143417.611019-14-aurabindo.pillai@amd.com>
In-Reply-To: <20210416143417.611019-14-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T15:42:15.835Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c351771-277c-42ac-fa1c-08d90349b5a5
x-ms-traffictypediagnostic: CH0PR12MB5124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB51242A91A9461C6E3833D5DA8B499@CH0PR12MB5124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vv2IlxYpWsmkEvBLATbRkKklOfrkPA8RRH8q1eTW69J3vHm142rpcOOJpPDy0LS8yNWfg4EOCNzBDb9DABjSMu3k4d3EVx1iq7JqUvtXbGsLAnFXeiyyGGBSaEME1JC4cMvbNGUZKwbzQ2RuQCnFTdIF95xgmNK9Wj/oeL224V45l+1/HEdTPVjg228C0eDlG85APxbE2ll7cke2wI3RXYWbqpt7U2k7qzLkmP90IEdDzR/6RNcTAcC1uwCIYYnrypCYUd/IxihLbA1c6xCl0ysKiTWT/z0jnHpG9mvubKOstGM4Hsx5vtAJa2OBmw3Eli2rAqzOI5sm6003IDOt8FEl1X+HzvncuoxCNfvm39Ck4JsRrzFavdDHr//YTTx7whjHpQ8+oGpwu7mUxkSuLYM4InX9tc+JO6voRXEeyxpHVxqtlKF4YMqV/9RR+OCM5olwAlC+UNCgmJEvdlAgY/wlxYcxdoqN9HrxP4p3+w5UiZzjJBHtCFWDi4/f85hClD5S15Qokm4ijlVcKBplApR3xpR8VCVeH0MMZ7z5Iu3+RNecPCTE787Rdo9nymDSVcVm7DbFjrD0/SDG8Q9dqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(66446008)(52536014)(7696005)(54906003)(76116006)(55016002)(316002)(66476007)(66946007)(66556008)(83380400001)(91956017)(9686003)(64756008)(186003)(53546011)(8936002)(38100700002)(26005)(8676002)(33656002)(71200400001)(6916009)(86362001)(5660300002)(2906002)(478600001)(4326008)(19627405001)(122000001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Bfv/a3K1ZV9bpPlTdQmMQAzvqd0nXd2jMUi2ZB5fHBi8FV7jFd2xCQQtxpxm?=
 =?us-ascii?Q?zfF84mpIaRoiOnI80arB/jDn+uOmXZb56iarHlu/3ocLu9MK1c4sy44CcWcC?=
 =?us-ascii?Q?MW3QUhISw8tCJF9dPQOS5KJk7QAxpleX3QiJmnEqpzGnxWw86+J7Aka03w+Y?=
 =?us-ascii?Q?P5kNiMhNO28hnrNScXM4Cw0N2+eD8uDJlyp3p6PayOMvkVaUYSMvOkD3Elkc?=
 =?us-ascii?Q?nYKzVvLHxvgfipX4BcA04a4lEC5A/En8fVbbxQgFSmI528qX16V+047qIxFi?=
 =?us-ascii?Q?tffzzjldaefuufk99ei/0Y7Xjqap4YCDwR9WxfTe/v7kiUzHOE44yGyBa0zP?=
 =?us-ascii?Q?NTFmLS/ypkaF6InuxiohVIjlkhrLxTZ2Cbb83Wv1eCIU8mORVSNvU+Mctsuj?=
 =?us-ascii?Q?T1Q7HP+Rewr2lUl8znUtO31iWb5jPIIykC8yPIe8CoG0JQjAWsAKXVu53p2n?=
 =?us-ascii?Q?ErDZH1YgWYBtjkP8S+2z8bpMoLPlQSlJOyuHZCG0+naQceFM54BXaO/j7l+x?=
 =?us-ascii?Q?DuWkGlG6P7PTS7rw9cGbOBXj5AWu3fm1LJXDC/OUTrZ1p+xwtB4c8ZBDoCSI?=
 =?us-ascii?Q?Zz99eqCyoSmlJPZ+LbTP0Geyb+gkvugOSlnqxfg3AwdaYowt+C532MkzoiL7?=
 =?us-ascii?Q?IrRVJbPO8a33qDYvKOLO/4oefhepDtO5YQ9Ult9hkq+jswr/0nPdzKwe0Kns?=
 =?us-ascii?Q?vBsdMd08h8U50ytUGk3UzSYflG5S/tx9IivFnNI82t3nt7ZsVETZfS7o8nRE?=
 =?us-ascii?Q?epGffXSxmt/WqiRu6fXDHtvV+sufsg+zuPIIE2CIs1LAhQMRR6tqwgGeElWU?=
 =?us-ascii?Q?iHVggnuY/KM195A+0zafHYBFcdYme9VCPQNTJqBhBjXwq8qLlNSOTu/U+Ee1?=
 =?us-ascii?Q?oSQxuWJKRq03xhB2KTZlAyx0OcI8rOsooRRqaDyN+mOCDiio9AMgWpdBFTwZ?=
 =?us-ascii?Q?AWRMCW7v3LLyfLRxSJQqPmh2eEvYyzMuMzB6fkjJlqKPrV6hX2UpFa/qLWnk?=
 =?us-ascii?Q?K2ySQ3bxsO/lcVSGDVOW6PidFM4rtnuqT9O9ohF97jUBIhwR0JPndQqhvdx0?=
 =?us-ascii?Q?XI0q2Tih6/AjLbAfK71cEe2Gy4L2SxN6mmi2oosUAkoZRH1ZIQwYPFGwzQ+n?=
 =?us-ascii?Q?qk9/pJ1IXRc2mdp1ykSe6oLaWcUuIsO4/sZYpjNYX+U4cm+uemrrOOgSfElu?=
 =?us-ascii?Q?YRBhkxwozzmAyJlVGR8izDpcf30gYFNNIK0GJtMm2SVOi57gLBxlWKHxBbxF?=
 =?us-ascii?Q?Jnjh11bF7jCy1EBCfAMjDhbi5pM+ZMNbYPIDdjK19h80uaZ/iroUbG7aCVdP?=
 =?us-ascii?Q?opXnEihYyX8xmpafraCtG8QB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c351771-277c-42ac-fa1c-08d90349b5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:42:16.2704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXhdqtp1zmAKoXfCk9/NimchFUyHjmiLhy1/ENxoiZIdaKBr0eHyp+Snc1Bh1SrqfD9uz0gliWQv14kHSYauYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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
Cc: "Zhang, Dingchen \(David\)" <Dingchen.Zhang@amd.com>, "Brol,
 Eryk" <Eryk.Brol@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============0987640083=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0987640083==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5284E53E08A23F2E2965499B8B499CH0PR12MB5284namp_"

--_000_CH0PR12MB5284E53E08A23F2E2965499B8B499CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

This patch introduces a null pointer deref on MST hotplug, so this shall be=
 dropped.

--

Thanks & Regards,
Aurabindo Pillai
________________________________
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Friday, April 16, 2021 10:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; R=
, Bindu <Bindu.R@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Zhang, Dingc=
hen (David) <Dingchen.Zhang@amd.com>; Zhang, Dingchen (David) <Dingchen.Zha=
ng@amd.com>
Subject: [PATCH 13/19] drm/amd/display: force CP to DESIRED when removing d=
isplay.

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[why]
It is possible that the commit from userspace to cause link stream
disable and hdcp auth reset when the HDCP has been enabled at the
moment. We'd expect the CP prop back to DESIRED from ENABLED.

[how]
In the helper of hdcp display removal, we check and change the CP prop
to DESIRED if at the moment CP is ENABLED before the auth reset and
removal of linked list element.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Dingchen Zhang <Dingchen.Zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 616f5b1ea3a8..50f6b3a86931 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -160,6 +160,7 @@ static void link_lock(struct hdcp_workqueue *work, bool=
 lock)
                         mutex_unlock(&work[i].mutex);
         }
 }
+
 void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
                          unsigned int link_index,
                          struct amdgpu_dm_connector *aconnector,
@@ -222,10 +223,22 @@ static void hdcp_remove_display(struct hdcp_workqueue=
 *hdcp_work,
                          struct amdgpu_dm_connector *aconnector)
 {
         struct hdcp_workqueue *hdcp_w =3D &hdcp_work[link_index];
+       struct drm_connector_state *conn_state =3D aconnector->base.state;

         mutex_lock(&hdcp_w->mutex);
         hdcp_w->aconnector =3D aconnector;

+       /* the removal of display will invoke auth reset -> hdcp destroy an=
d
+        * we'd expect the CP prop changed back to DESIRED if at the time E=
NABLED.
+        * the CP prop change should occur before the element removed from =
linked list.
+        */
+       if (conn_state && conn_state->content_protection =3D=3D DRM_MODE_CO=
NTENT_PROTECTION_ENABLED) {
+               conn_state->content_protection =3D DRM_MODE_CONTENT_PROTECT=
ION_DESIRED;
+
+               pr_debug("[HDCP_DM] display %d, CP 2 -> 1, type %u, DPMS %u=
\n",
+                        aconnector->base.index, conn_state->hdcp_content_t=
ype, aconnector->base.dpms);
+       }
+
         mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hd=
cp_w->output);

         process_output(hdcp_w);
--
2.31.1


--_000_CH0PR12MB5284E53E08A23F2E2965499B8B499CH0PR12MB5284namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
This patch introduces a null pointer deref on MST hotplug, so this shall be=
 dropped.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo Pillai<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Aurabindo Pillai &lt;=
aurabindo.pillai@amd.com&gt;<br>
<b>Sent:</b> Friday, April 16, 2021 10:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd=
.com&gt;;
 Brol, Eryk &lt;Eryk.Brol@amd.com&gt;; R, Bindu &lt;Bindu.R@amd.com&gt;; Ja=
cob, Anson &lt;Anson.Jacob@amd.com&gt;; Zhang, Dingchen (David) &lt;Dingche=
n.Zhang@amd.com&gt;; Zhang, Dingchen (David) &lt;Dingchen.Zhang@amd.com&gt;=
<br>
<b>Subject:</b> [PATCH 13/19] drm/amd/display: force CP to DESIRED when rem=
oving display.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: &quot;Dingchen (David) Zhang&quot; &lt;dingc=
hen.zhang@amd.com&gt;<br>
<br>
[why]<br>
It is possible that the commit from userspace to cause link stream<br>
disable and hdcp auth reset when the HDCP has been enabled at the<br>
moment. We'd expect the CP prop back to DESIRED from ENABLED.<br>
<br>
[how]<br>
In the helper of hdcp display removal, we check and change the CP prop<br>
to DESIRED if at the moment CP is ENABLED before the auth reset and<br>
removal of linked list element.<br>
<br>
Signed-off-by: Dingchen (David) Zhang &lt;dingchen.zhang@amd.com&gt;<br>
Reviewed-by: Dingchen Zhang &lt;Dingchen.Zhang@amd.com&gt;<br>
Acked-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c&nbsp; | 13 +++++++=
++++++<br>
&nbsp;1 file changed, 13 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
index 616f5b1ea3a8..50f6b3a86931 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
@@ -160,6 +160,7 @@ static void link_lock(struct hdcp_workqueue *work, bool=
 lock)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex=
_unlock(&amp;work[i].mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
+<br>
&nbsp;void hdcp_update_display(struct hdcp_workqueue *hdcp_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 unsigned int link_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct amdgpu_dm_connector *aconnector,<br>
@@ -222,10 +223,22 @@ static void hdcp_remove_display(struct hdcp_workqueue=
 *hdcp_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct amdgpu_dm_connector *aconnector)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hdcp_workqueue *hdc=
p_w =3D &amp;hdcp_work[link_index];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector_state *conn_stat=
e =3D aconnector-&gt;base.state;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_w-&gt=
;mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdcp_w-&gt;aconnector =3D =
aconnector;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the removal of display will invoke=
 auth reset -&gt; hdcp destroy and<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we'd expect the CP prop chang=
ed back to DESIRED if at the time ENABLED.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the CP prop change should occ=
ur before the element removed from linked list.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (conn_state &amp;&amp; conn_state-=
&gt;content_protection =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; conn_state-&gt;content_protection =3D DRM_MODE_CONTENT_PROTECTIO=
N_DESIRED;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;[HDCP_DM] display %d, CP 2 -&gt; 1, type %u, DPMS=
 %u\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector=
-&gt;base.index, conn_state-&gt;hdcp_content_type, aconnector-&gt;base.dpms=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_hdcp_remove_display(&a=
mp;hdcp_w-&gt;hdcp, aconnector-&gt;base.index, &amp;hdcp_w-&gt;output);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_output(hdcp_w);<br=
>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284E53E08A23F2E2965499B8B499CH0PR12MB5284namp_--

--===============0987640083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0987640083==--

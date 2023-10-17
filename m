Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7735DCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 21:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F206110E329;
	Tue, 17 Oct 2023 21:09:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FBD10E329
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 21:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG4qDogpkOta5GtFI3s2Il7j+BY2TNubhVBFi7Vq3qUniL0ml9n5RjIUkBcqR4w/AF/06Z0jZ0DIr1sDu9XFX/ujFUj+cL/0VIKJXlcM/y55K+Yrl3R2u3gqKPfs5+daMdDfqWCskrj0PLZuVMvYfkHMZCpYzd4egrVhwc960zu+StuMsIKvXrjo4+MUN3QqZxhsGnQiUbJaA0W/B0SG+Ui0vJUiL99bPMQPy7w+K8BIxibsLZUcEGTJZEPsT/2jO5JYXCJZfyyZpS56uarxln8BIJY8uPIfwTD12dUvM1PGk7VcL1DnJ5q8kDfAzSBX9wWZg7mC6ZRwmKO/0U9gNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg4ePctPjFCjHWgryAoN6si/RsLY0LGyJo2joyiJ9NU=;
 b=JrxJnN4ls7qMP75rJgNkaYw1uvD3+ifqIanVQoi9jGaRf6cPv9nAaNHCmea2VokLCGxYBuLwchAvpLnGy5rjShA2wwcsOd/o0pfpK7vLW7e14TxnRPOmMgZbNvO+qgYchnTmwL4WLocQUwPjMvI/o4XHNFbQFIvNbomydQIbWDgUnpaE9zlCU2AKEVV5G7eyH2aVREDGKPNL64cUDxSW664cKmRsTeB32teqqwOA6+oLtGdjKm8LsPQUbXg0m00WwK+4F6eeg+IKYhYPtlx7JC1hg8OZtBgzZuorpAjq81jBBCHtNMLLGvqMU2Boj8aUB3207Bzvm7ob4JU/t2BmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg4ePctPjFCjHWgryAoN6si/RsLY0LGyJo2joyiJ9NU=;
 b=40mW1mhDG03bTsfnnw0xq6jgdlVdNNhqT+h9aGJsrNaBLpONLQhZgj3rTyQMmDmdt3VMvFOZFCCu7/LpLN0KKWmqv4/xlO/ThawxzxoEX92BbhJwHjTxRzzT644eLyFL/tumQEDDmyOxTYX3XTw5eYNPJ/fyhuwBiXf6t0tSfXU=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 21:09:03 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::98bd:2785:2b62:7777]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::98bd:2785:2b62:7777%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 21:09:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Add missing kernel doc for prepare_suspend()
Thread-Topic: [PATCH] drm/amd: Add missing kernel doc for prepare_suspend()
Thread-Index: AQHaATF2sqbPkZxim0iNDHGTsTnPq7BOedoH
Date: Tue, 17 Oct 2023 21:09:03 +0000
Message-ID: <BN9PR12MB5146DD2303BF910FDA9898C7F7D6A@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20231017193743.35821-1-mario.limonciello@amd.com>
In-Reply-To: <20231017193743.35821-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-17T21:09:02.590Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA0PR12MB7700:EE_
x-ms-office365-filtering-correlation-id: 9e0da665-ced3-4de6-8c45-08dbcf554aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6TpDz2Mgp8xzA9eaL2hm7u5Q7FN+/G8lb6IfUs0oEmdcl2gMDSJVP6WTQw4ZatFzEsYrSpts6zGte+2+1N5ceT5g2uVEMaCgkuZMiCEGOMkZkmgC0c/+AXKRj0p0eAKRBd9RerV+F/jONP1nsCYzsXrG/nvNMK5sI5SUwqsotSKsbQveDZkaT6gqIqp9qGg3MXWK2eAORAU9XpRVi8dwqff9BK6hTJXTs8hCjSoS7n9nshIiPMw6iU/UU9jWaehYWVx9Feeu3QqWkzav4OBbKFenE0/F33/GL4OAvcSeBiz4CP32noJi2nmAoxaNHD+CEdSjPscscWGlYB/NDM3kSIXehhxfkhhv9fz1pbv+XhijMof6IykzeWRhSX9ZABZ8EHf1L7eCz7UQ9RINblhgQaf/Kez47If00uT0lMoE8UkrKUCJoWidBW+IIioWfzmICe8vt+nSfcE+NVdTN80nRoWGVJPve06AVziqqeJn7s9XjvrHZVq3gjLdRm2xNl3la8nYlqu3sBGUyVwv+5lJpfQIPjBn0GwnF+liM53/nyH+x6l6eVmqoobYvETljc68MxH+m3EKsP8nj+mHbx8uHUWDXsPOVPbT8HhEYHUFNI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(33656002)(19627405001)(26005)(55016003)(2906002)(478600001)(53546011)(7696005)(9686003)(6506007)(41300700001)(5660300002)(166002)(38070700005)(71200400001)(38100700002)(122000001)(966005)(64756008)(76116006)(8936002)(316002)(66946007)(8676002)(66556008)(66476007)(66446008)(4326008)(52536014)(91956017)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yjoPnbtmfs8D4gKL0lv3XyvhMO+71/bMkIT+BF6/fHhEmsvobumgWcVH/wDS?=
 =?us-ascii?Q?Ws15uqAnkfnzRl0BaO8mth5JpdfKuQqjQuowqcPa4bZRfq/cCs1c+Zxmc2IB?=
 =?us-ascii?Q?sC1maAobTG2mP7apdwdUCNe6X6Fa9FOixInxCVMOAdKwJkLZUNJ5XyNoAYyO?=
 =?us-ascii?Q?QWSNHlB1BIpFm0KN4ysacla4HqIRncntdE6waBkAcDGOU2xB3KL7fxFsnG9y?=
 =?us-ascii?Q?SQ4n0jGa5RaBbCwat79DRYmcTz9AmH0puc+x6gCwUAQQHFnB0bYN62jiu92L?=
 =?us-ascii?Q?ZxtqW6SFEQWNr93JYTb1NwdCaGwPuEFFUOmUfigXEwIxgTyBozDNGnZpFI/l?=
 =?us-ascii?Q?f8JcQmvib7ISKhyvui2yrCfHhZScuzWHy6VR+jvHnIk8BT+kTKXb4Qjkst7O?=
 =?us-ascii?Q?s36YVDPWzuaA5cgD6Td5wvOX+fg0rzYN1Qh66g3+7LFA8GqsQdx1GnvJL2Ns?=
 =?us-ascii?Q?8XQgNFyXmlbm1Cl6nlD2EoapWH39rm71bwKCFOJ45mRW8pCn1u1BG1p0LEUA?=
 =?us-ascii?Q?gZ53gooH+n/dej5mYS/iCI1foONQfRcSG/+UW9/0tzRWhCqo7uH17/tjqRC2?=
 =?us-ascii?Q?XuKmxGoQHsGfgEeAzy64aX3hE88l+7vYZsn4dva7tQC/ck8xV7HEx13JvRvb?=
 =?us-ascii?Q?IqpmyMUnd1gxNgA6k4TL5ZFwE5rLCIH9SwPJ680xDkujiLTRak9oyGEhaBDc?=
 =?us-ascii?Q?2+oj/lQ5eVgph4mYugF0MlufMbjaAS2R13sPw5KrgMS+WTLe+es1fiUrIqa4?=
 =?us-ascii?Q?WF20SeRG8oT1ZEkkMlmB4YV8lFisoDZ0oP7w7BapwrGMcHohCM9vUiJ7NWWZ?=
 =?us-ascii?Q?tUq3PM3PtWRiNGylqX9d1jslSEE5A9ltEBHMkno2KNBlvCdxelLfRQT2mbsi?=
 =?us-ascii?Q?AQ9ObqxWl5wK4VGHeOADBlnrZ1x6vPEsDKqauTbDHg6jnm+WLOqrs1PgqVef?=
 =?us-ascii?Q?fHXS2iOwVcABeDiHofpsSnvjo0dinF6lSD37PWZcoBSJa+K5/vQ5qWCT9VKf?=
 =?us-ascii?Q?Jo7iLLrhENdLtd/NIuXiC9XX5zTMXuYyc0lfUC0mnhuHwc2NAWyp86tGKXci?=
 =?us-ascii?Q?95l5no8GcQsniLaAONUa1ltcTgEvtd0s8jyleVwzsS5XZvajzpYaLWVoDjRd?=
 =?us-ascii?Q?c5vRbavXJ5j+4Ni/b+2v6tO0FaUrhkNxw6NlGtduFvc0BSGMTtoRBWU1yqJE?=
 =?us-ascii?Q?WBbaReDsCZwYEFxTpEhkGgYEl/vgS3Af+p6md3zD6KFOdJAAyOGXtN9dvgqb?=
 =?us-ascii?Q?HZ1m37vZ9gnrjhcyUmwQnJoBw9YMoNXISQWus3CMqA4olSg2uFcZvmmOUc/Z?=
 =?us-ascii?Q?yOElZjIVkxvmep7xgeCUFc3lrF5iHr3FPMy5YPgEurC7a/ieq83FOhz41X7p?=
 =?us-ascii?Q?khhvyhtkl7C3VvTt83MWWOWnz8F1UW6g9ltT/NXf9WmvELij7mar6ahovQ9H?=
 =?us-ascii?Q?MLNAp1+GIDllLnOCgYaXkJV0h08hiM4pflTyboxzH+o+P2mIJYJd4ggODkoW?=
 =?us-ascii?Q?it4eFJlalO/mOQG+2M3r593w+D7C+GJIHIpH/fKWkUd4ttrTFkk6xjFDQ35Z?=
 =?us-ascii?Q?12IV2nm22MTFuIPutlI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146DD2303BF910FDA9898C7F7D6ABN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0da665-ced3-4de6-8c45-08dbcf554aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 21:09:03.4292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tC+H26ojTG2qxd0Jsr5U/+aHgkpda4BTGF3HZgpHjKF/wDgDLubBFi7mfBdZbcoQtTxFlMsbWqWngFXG82Cy1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5146DD2303BF910FDA9898C7F7D6ABN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Tuesday, October 17, 2023 3:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>; Limonciello, Mario <Mario.Limo=
nciello@amd.com>
Subject: [PATCH] drm/amd: Add missing kernel doc for prepare_suspend()

prepare_suspend() is intended to be used for any IP blocks
that must allocate memory during the suspend sequence.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20231017143555.6a6450fc@canb.auug.org.a=
u/
Fixes: cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() seq=
uence for IP blocks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 98e60bc868dd..579977f6ad52 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -271,6 +271,8 @@ enum amd_dpm_forced_level;
  * @hw_init: sets up the hw state
  * @hw_fini: tears down the hw state
  * @late_fini: final cleanup
+ * @prepare_suspend: handle IP specific changes to prepare for suspend
+ *                   (such as allocating any required memory)
  * @suspend: handles IP specific hw/sw changes for suspend
  * @resume: handles IP specific hw/sw changes for resume
  * @is_idle: returns current IP block idle status
--
2.34.1


--_000_BN9PR12MB5146DD2303BF910FDA9898C7F7D6ABN9PR12MB5146namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 17, 2023 3:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;; Limonciello, Mari=
o &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Add missing kernel doc for prepare_suspend=
()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">prepare_suspend() is intended to be used for any I=
P blocks<br>
that must allocate memory during the suspend sequence.<br>
<br>
Reported-by: Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;<br>
Closes: <a href=3D"https://lore.kernel.org/all/20231017143555.6a6450fc@canb=
.auug.org.au/">
https://lore.kernel.org/all/20231017143555.6a6450fc@canb.auug.org.au/</a><b=
r>
Fixes: cb11ca3233aa (&quot;drm/amd: Add concept of running prepare_suspend(=
) sequence for IP blocks&quot;)<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 98e60bc868dd..579977f6ad52 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -271,6 +271,8 @@ enum amd_dpm_forced_level;<br>
&nbsp; * @hw_init: sets up the hw state<br>
&nbsp; * @hw_fini: tears down the hw state<br>
&nbsp; * @late_fini: final cleanup<br>
+ * @prepare_suspend: handle IP specific changes to prepare for suspend<br>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (such as allocating any required memor=
y)<br>
&nbsp; * @suspend: handles IP specific hw/sw changes for suspend<br>
&nbsp; * @resume: handles IP specific hw/sw changes for resume<br>
&nbsp; * @is_idle: returns current IP block idle status<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5146DD2303BF910FDA9898C7F7D6ABN9PR12MB5146namp_--

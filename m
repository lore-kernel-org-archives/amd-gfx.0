Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE82DC624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 08:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E161410E590;
	Sat,  5 Sep 2026 08:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yn6FcXmX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF58B10E590
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 08:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycpfF3PEyty4o7K7y5oU6CJ8NepSXCTzzHMVlaDaLWTmpnNK1M+OCQwr6FOc0U/O6XKjOnQu0vGhNb4eushm8TMjQxjP9WMenrRG9tOxYnqLb20A5OTMG1OK9qjXJzsR2CjpIz1MY0oZNBTtVpVKNv//OakbC6dRlo/+L7+1z6OYfiD6vkGa/cO5g3XPjcS9KHVNscTB572m2F0aHYSYeNojbOIyk9JOTY9rD6xFRLuYP0oTSJpZj/oIedZM1mLbuNpRlcj6v9axvDGipEGh5NdPMwVrED9485wVEw8sZjlcaxGhzP44xZybuN7nvomuJhuYRnnLsZWro8BeelmcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wxfcr5nq0TKZwJwGj6gOAUg/4nUcbA4z7ITMSuup98=;
 b=ksZ8BOQOvYVzifPtqKlRFHIYCDuOLKEGlL/eHd5YtjNKd9SIcDzK2oDFQVHt6izb0LVe4WlJS3LJ0qwl/oIZUbsEn9crFx8f3GYtC5xXq6/doCRoG3g18We5gAwo2Tizgrwsl7NXkNOOaDHTYsq/Kqbe/8FOACViLOVVWg6QvIBIcFkOoM35c+ETv0LQdye0nKanE0jvKpGz0f4aiKydR8/bF586MTVHND50nG6mlaeY0/ylSpJBlj3k8+awOPz7YjBKDXhyrsOY0sxFD8aXPo9gIlWGSwK+RGh3AXSB0CjsYJiqO/ENvli7QoEKI1xGcau4eIhzlE+AKlbIuHjVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wxfcr5nq0TKZwJwGj6gOAUg/4nUcbA4z7ITMSuup98=;
 b=Yn6FcXmXy1lQL1XFUZttXiEIKjEBWq9KR40Wca8FsEPK738upBny9/hyp91acztiougAuQ0G+Gbe+gARmU2BfzzecMIFHuaQoFCQoOWS0dSjI3ducKcZS7qh+JeH7T+4CM2Sm1cVQQXVpe0xSpAhXJwOrAuvPMQiVzKBh7+x16o=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by SA3PR12MB8022.namprd12.prod.outlook.com
 (2603:10b6:806:307::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 08:23:39 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::4c6e:70e3:2347:8cbf]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::4c6e:70e3:2347:8cbf%6]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 08:23:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/ras: reprogram MCA settings after reset
Thread-Topic: [PATCH 1/3] drm/amd/ras: reprogram MCA settings after reset
Thread-Index: AQHdPO9e0nK94nGkf0uJ0aE/bYKk4La/pEZg
Date: Sat, 5 Sep 2026 08:23:39 +0000
Message-ID: <BN7PPFFF39339DD421DB0B977A57A024F58FCB42@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260905043031.1015676-1-xiang.liu@amd.com>
In-Reply-To: <20260905043031.1015676-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Ce.Sun@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-05T08:18:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|SA3PR12MB8022:EE_
x-ms-office365-filtering-correlation-id: e9de0dcf-225b-4ff1-5159-08df0b26fcff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10086099003|10067099003|22082099003|56012099006|5023799004|11063799006|6133799003|3023799007|18092099006|18002099003;
x-microsoft-antispam-message-info: wg/UQZjkKLRCWngZaoL/8Wqo7Ws2Gnde1UbLl7Cj4egiJK5y2QNiGaSn/95r5+L4XXST9oqeWEnvmls75o90eWZU+3kVxhgX4fM6EWCoXHPLaxw7JSaxCgDccP1B2XYaw6pLby0bH4wR39g6IS5wml7Ep451RHKRcNHcm5QEAJZ8/Rv10JTkx/ytmQhKd/YQvWrHzUE2IE/J0glZYDiNUmhTTRyD1t7NSxliFOl8aLup9+rDE6Lmznu56kJMLIipTxVfkJYGsOy82jq2tyrH114w+GOa9MvuSZiuy+S4cq68bfAeL+UWyx74Tp8SyMM+n0wWMT8Mx4oYbtdTHu5mzgA/o399HpKjVBGxHbCgfFVQkpL8jP2u+ORLjF/3wn3fvFU2EmM5K67QQ47hgWKMMqoHNbPx/dOIc+TfnwQHUwpczZJeX9HC2c7eCt234lql1wbSLWCoZvgCdqV7veAxTV76lLUhIZ0yBG07nNAu5ikmgHu42n0dJKJWwEzFKelE478SMz6DiqqD2SI2SL9rDrikCDQvEcNs5VjvAXU3aJ5ziWQB6J+QL3hwACzkZVxw0ChQ2NsNodcnKEUNliYZM0NjavKTKQ8qyaVy2c3lNX6A+2hmOxXf6QpHngk/XaWx5xmrPc0W5naziNOWZuzqDRf2J1WgOHXC7MWD+HiCgx1ZzpYfPjRdMmpVTL8XA6CgObhiP3z12FYgvodiquPq6K40KAVdMBimIdHuhCna2wk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10086099003)(10067099003)(22082099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1dnMlIJliEm++SqiZfpbiCNc/QTs6FfVRoldmJgL9xQlfWjZctk4CUa/5wnO?=
 =?us-ascii?Q?ViKzJsPrMHsxpIGHTH6sj42WFMVmiX/WX2wCxf4vIEEwEevao/RYtNnt3Cgx?=
 =?us-ascii?Q?sFOw6qlYNg6w67bHWcgmZEFelkLrSvqhIAPn8KnS423bqN/xKPrkdx6uwAOX?=
 =?us-ascii?Q?oLqzS2FZHWn/rdWCZA0Jad7+idRqbFCSPosMhevc6lm2Tyej0xk6/5gWec0U?=
 =?us-ascii?Q?XcAUHham3q3XlSGTOaEjDbZhk9rjIM3Rj2dw/kkgYFd8p3QPyhXX2FdhLrHP?=
 =?us-ascii?Q?IVqOM+OYdm9S2it6YFOsL6RcD9QXs02KqdiFZ4bJ3eu3deLrivAPg45zzEA9?=
 =?us-ascii?Q?5ExqZ/ABT+38ZjjvvHPQXyIMr+DoCLyPmbXok1m4l5x0ZXgQc8KwVVRTeaRy?=
 =?us-ascii?Q?S+OWF820RzdCxD/jOyc+/4zqOfPw+EdBioGtC9L+4DKtW3KdD0htpA4zcbdM?=
 =?us-ascii?Q?hyRUUucZEDs+4UMrujTSTNK7sSxCR3leITGyVoD/WcobhT2RfcRKLFVpn/RX?=
 =?us-ascii?Q?s4cdTq51NXe3733t6YB0q5HG8nLRV47SCaWosMNK8QLWnMWQ0xoVWgFLn/Oo?=
 =?us-ascii?Q?dHSWjF0Ps+xwPnJMWOuVEvEpcJ6qdmyemhtTU/k3g+1uIXA96IclJdKaQUra?=
 =?us-ascii?Q?dUtNgRwvdLNuIVLJG27MCphIZEk4Md2/5lRYhaWb1XrkgqrjyvGA2CxHesiq?=
 =?us-ascii?Q?KFnsv7qzoqkDu0iQ1g3wNiDMiOmErZjU7nDcJM8I9TA98kNVKiRrIQoZVKLS?=
 =?us-ascii?Q?srsFBwxEkKjq72bqPr56vzcmrHSCB+00GgN/u/gOpZQkQ5AS/xISxoK/W1DU?=
 =?us-ascii?Q?uvMRWtB1bhxvInFjku5VftRcu7308xe5Tavn1ZwzrCcJS9ozz0HENEyhL4cC?=
 =?us-ascii?Q?7v5+pk76/Zw9Qk2j6EU3W7j6/CZum03/J9ejCYbAdF0WxnnObl1n3vpjgpDU?=
 =?us-ascii?Q?QhL2915rgEgy4TUXUwzC9iXvG8L4412KOU3eycZJgWBiN1V0GpH0TZWId+V0?=
 =?us-ascii?Q?m6SBlJjW3E2m149loo/lMifU8kUdbCtZEcIWNHkkpKjH8Fm/l4BIW7oqzwcN?=
 =?us-ascii?Q?xSBVt6F9V9vPF8/IPZDOBWA2jOkloPNUZzeFTlsACG17boqVd0vk9Igumllk?=
 =?us-ascii?Q?LAYewxQiK/za3uI5nh5dStupyL6bgyeARe3iABhXZkLf1LeOlTcE4roXuReH?=
 =?us-ascii?Q?NpJLK0EabRyCoSA+5yl9ByA6dDTSPTgkeLKqmhs+jenCvytKZ7YWbFIym8cp?=
 =?us-ascii?Q?HcS5S857BDettNHrZVgCdsF06jrO/719cJ7/Y0+RYIEnXuhPUoIujG5duQg/?=
 =?us-ascii?Q?QRpWx0hsZfRktL2Gz3dI4mShKRxNyn9nTutlZTBgFCSEqy23ou9HmZQOnCmB?=
 =?us-ascii?Q?nV9oa9r8OKr9LDZKvjGzas0iPQFW7HQplyQjro4UYnyWcm5BmNsVRcICak6h?=
 =?us-ascii?Q?DgGAC5EOuF+fjKdZnIxSUFxkvf+QjPlFO0PU0v9k+X/Jf5/0cxcmYjf60FTL?=
 =?us-ascii?Q?Xr31OX2KtT74phq8I3IHZEQktAs0cjXs/M7eJIc+6UDpruLgYc2D7IyxzF5L?=
 =?us-ascii?Q?gBdX49xdtz9D3FjC9Bj2NCcTAChQ/MsMOdiXPb0a7H6ImqrH+MCyqSI+uBcm?=
 =?us-ascii?Q?/LujS1ec+IQlEf6u0e3CPlJYg1Rp83lPVVxA+4OKTEEznK2HPKylS7f5ff6W?=
 =?us-ascii?Q?an13oGqE5FueywazIm9qQu+DvDQDTQOx3s6ARl66SDrLACGV?=
Content-Type: multipart/alternative;
 boundary="_000_BN7PPFFF39339DD421DB0B977A57A024F58FCB42BN7PPFFF39339DD_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9de0dcf-225b-4ff1-5159-08df0b26fcff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2026 08:23:39.0868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK/m2CcCnMu0Sc3QNwLHiwU5KdcZxAyb34KaMfsCfFZf7dJgB6eX3ckdvbY0ohubLQfRWDrKHnIdxU7CInxWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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

--_000_BN7PPFFF39339DD421DB0B977A57A024F58FCB42BN7PPFFF39339DD_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


+ @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com> for the discussion.

Hey Guys,

We may need a cleaner and more consistent initialization sequence that cove=
rs normal driver initialization/modprobe, regular GPU reset and recovery, a=
nd XGMI reset and recovery.

Could you please evaluate the following changes?

1. Move the call to amdgpu_ras_mgr_set_debug_mode into amdgpu_ras_mgr_hw_in=
it, placing it as the final initialization step before the marks uniras as =
enabled.
2. Remove the corresponding amdgpu_ras_mgr_set_debug_mode call and the unir=
as enable check from amdgpu_ras_late_init.

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Saturday, September 5, 2026 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: reprogram MCA settings after reset

When the driver is loaded on a device that still needs a hive reset, the RA=
S IP hw_init is deferred to amdgpu_ras_mgr_resume_after_reset().
The MCA configuration is sent to PMFW from amdgpu_ras_late_init(), which ru=
ns during the reset while RAS is not ready yet, so the request is dropped a=
nd CE polling stays disabled. Correctable errors are then never harvested a=
nd only show up on the next driver load.

Re-apply the current debug mode once hw_init has completed.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..f550e83f2b96 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -483,6 +483,7 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_dev=
ice *adev)
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
        struct amdgpu_ip_block *ip_block;
+       int ret;

        if (!con || !con->uniras_enabled)
                return 0;
@@ -497,7 +498,12 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_de=
vice *adev)
        if (!ip_block)
                return -EINVAL;

-       return amdgpu_ras_mgr_hw_init(ip_block);
+       ret =3D amdgpu_ras_mgr_hw_init(ip_block);
+       if (ret)
+               return ret;
+
+       /* amdgpu_ras_late_init() runs before RAS is ready on this path */
+       return amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
 }

 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *ad=
ev)
--
2.34.1


--_000_BN7PPFFF39339DD421DB0B977A57A024F58FCB42BN7PPFFF39339DD_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ <a=
 href=3D"mailto:Ce.Sun@amd.com"><font color=3D"#2B579A"><span style=3D"back=
ground-color:#E1DFDD;">@Sun, Ce(Overlord)</span></font></a> for the discuss=
ion.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hey =
Guys,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">We m=
ay need a cleaner and more consistent initialization sequence that covers n=
ormal driver initialization/modprobe, regular GPU reset and recovery, and X=
GMI reset and recovery.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Coul=
d you please evaluate the following changes?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">1. M=
ove the call to amdgpu_ras_mgr_set_debug_mode into amdgpu_ras_mgr_hw_init, =
placing it as the final initialization step before the marks uniras as enab=
led.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2. R=
emove the corresponding amdgpu_ras_mgr_set_debug_mode call and the uniras e=
nable check from amdgpu_ras_late_init.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt; <br>

Sent: Saturday, September 5, 2026 12:30 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>

Subject: [PATCH 1/3] drm/amd/ras: reprogram MCA settings after reset</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">When=
 the driver is loaded on a device that still needs a hive reset, the RAS IP=
 hw_init is deferred to amdgpu_ras_mgr_resume_after_reset().</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
MCA configuration is sent to PMFW from amdgpu_ras_late_init(), which runs d=
uring the reset while RAS is not ready yet, so the request is dropped and C=
E polling stays disabled. Correctable
errors are then never harvested and only show up on the next driver load.</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Re-a=
pply the current debug mode once hw_init has completed.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 +++++++-</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 7 insertions(+), 1 deletion(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm=
/amd/ras/ras_mgr/amdgpu_ras_mgr.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x a02167397ce2..f550e83f2b96 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
483,6 +483,7 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device =
*adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amd=
gpu_ras_get_context(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_mgr *ras_mgr=
 =3D amdgpu_ras_mgr_get_context(adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ip_block *ip_blo=
ck;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con || !con-&gt;uniras_en=
abled)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
497,7 +498,12 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device=
 *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_block)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ras_mgr_hw_init(ip_block);<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_ras_mgr_hw_init(ip_block);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* amdgpu_ras_late_init() runs before RAS=
 is ready on this path */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ras_mgr_set_debug_mode(adev=
, ras_mgr-&gt;is_debug_mode);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> str=
uct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN7PPFFF39339DD421DB0B977A57A024F58FCB42BN7PPFFF39339DD_--

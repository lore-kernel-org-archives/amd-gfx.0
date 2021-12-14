Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5DCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 02:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58D910E872;
	Tue, 14 Dec 2021 02:42:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CC810E872
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 02:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me8z9nZbUj3NFO7StttVo4BsS1jbyp+7UHVmv90bp+jl2QotJnyosvbL4Z7CCClxr6W7rleYc7zzdXaO4ChVkEGjTJaE2J/kjC4LXX0uyrAhK4VLUuFnOpeSC/vF9ahLb41/5n1uO9HyJJga7cTP/uqICv41v6gRWwshBUWI+guCGqAzt3WD6+bH3YU+WqhHN+oKQudSk423io6wwgFW8x5GnG31ZZJbJTcoxGU5Oq0klBS8RcZAHUm6ZlbmZyqED90JxI9mQ3lU0oqfEoVD0VM+A7fn3bqRX0sxnZ/YAj5GRBOmRZGX7cy2HzDkLq6RN678HauiWcwWiTlTsG4EIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyd+Axs7O0cYDMRdRsQ7DpOj65uh+SKmeEMbuR9Bwkc=;
 b=DZvvLaAjlhR1kGgZncEbnkoyyT/qA9Vg/i2FAHDbCmOaZC24Jx6NWdRUwOjifAzUuBxNVcDQu4gcLyd+D9DNOG2uRfQmz5ZiDZbYdDeOLrIw6c9x1z7JCBXdQURy81jir2v+fdllf7qmcfCYdLO2RVBgOn6owGRf1Mgv96R9WoMwxBQFp2cvqbCI4Wrq1y31BLMoUcRd6P6vvidYil4531cDQpe8FsPhGbeuPWC2jzkTTtzD+gpvR92XypO9oVbNVZ+y1LVQ+BFZcRd/6XK2ghL81/YvKSH+YF3r0e33f7IMFVJRemgUOZIaxCDHlW1ev0eAm4MUhXfRJ1VGV17+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyd+Axs7O0cYDMRdRsQ7DpOj65uh+SKmeEMbuR9Bwkc=;
 b=P2jDEjOOCbJhpFowMinJ6i/eirjdm0gaWKx52F4HZPuZ/BHf1HeIgvCOd5zEKUj/JbwYvzgXbhCIWYxAYcrf7ELLo9o7Vxa6EDY66xohG4WrDGDdgvYouz52VZ7eMR5O/EZla9og+FqbVw+nvsAtS5fl7jyvSIwtdlJhO0TFA/M=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Tue, 14 Dec
 2021 02:42:41 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 02:42:41 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Thread-Index: AQHX8DNU+JEcsXFL8kqXKkIyUwvY86wxR7yAgAAAPuc=
Date: Tue, 14 Dec 2021 02:42:41 +0000
Message-ID: <SA0PR12MB4510CA0476D240F6C39329ACE2759@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211213150842.21141-1-mario.limonciello@amd.com>
 <DM5PR12MB2469F11AABDA9E7A723EA67CF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469F11AABDA9E7A723EA67CF1759@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T02:33:59.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765a976c-da27-435f-5e49-08d9beab6634
x-ms-traffictypediagnostic: SN1PR12MB2365:EE_
x-microsoft-antispam-prvs: <SN1PR12MB23656C6671A44030EA068022E2759@SN1PR12MB2365.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SoRLddffi6JxiAn+oYx0Y10qKN9Q3L/APUvIazK5/mcr0oF6wCEbBVFaRnR3SstGohQGLicMWV9vxZdjPhbTXKukGSIJAFLNu5hQoLi3KvC5vWH4Kpaj2cJddhL362afUMdmoOIB9iPzAgSRuxWM9byAekQlXBQWDlXYYg58mP2ybJ02Bf7K2aM8JyCcmtEk0NACFbpXGzdIayQIMlZuVNDKZvmdrpKoA5qF/NHAD32uRii3Uqpag+d0s75VE267OpzqrrThQrMkrl+z/cQrolKZfvyepCBThjDTWaEBFiSQAPEl71FSF0Tb6eZBfj+URvo1lciCUMRntCsSFv8zfB3QIl/fKkRxqugPW/uBw0S0EMGvLYZSAIyyKaeXtavvERc4woM7OcdSvTDasD7Qhz6/DQfjkI8AUBFlxjCp0sFdJfgYQ6A0aDMNdUFSzpU/TaqCKVxM57edsccmSx2ofR3uIVjIHdFlTNqTwG57w2kbeEMyopRllTXoyM6+9mMzFKoKyGadsTVBSNh//5zQFpCuIokzk+JUOeXnNB7L9co3T86Wqx6Cn2Aa6VhJLD2olc7RZX+ervwCG8nSqvyrigy3j8RaaPdPL/mzDL5L2x192NetQgQoNUXGBCb/a2aF/BJTHKgdnij+7wAbMoCkycvFximU1Qj59Wbg4siYj7xD+SCZqsNOnfPugKAzP1PQgbPEYSkhR+T/fjZwDLcVyC2TX6rsPsKRAEW7xlYeed3oXepeRNJsuKXpQR94ukAtPKaSmMHV6o0GouCSmNarSTech9ZpK5RbEA90oXmegU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(9686003)(64756008)(83380400001)(66446008)(76116006)(45080400002)(66476007)(52536014)(66946007)(8676002)(53546011)(2906002)(110136005)(66556008)(508600001)(186003)(71200400001)(33656002)(6506007)(122000001)(166002)(5660300002)(38100700002)(26005)(38070700005)(7696005)(316002)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YZmOVDSMDhIZPXfN58ieFSljhgqYjDgGrrNBmw1HUfhCuMSPVL3I1zhvkXOc?=
 =?us-ascii?Q?UbQ94YJnHviUIisnJS9uG7mwZLhVEtwOtHlMa5oehLFlNkcLrIyypEN5YKvO?=
 =?us-ascii?Q?NwtLfoULu4lg3hkb9bdlUdshfgl+/IljNoXj+t0fpjJZZQ1zZBOGJEbnHiXB?=
 =?us-ascii?Q?GPLXRst783r4tO1ZdM/raxBLNGbCd+osXzzYA/NB45F2b0rmGp2qcYNOANCz?=
 =?us-ascii?Q?lM5oruGEZsyjaDOx0H75ORrDDJKxGTyGvtwrz0B/80EPi3muUjWIBhFt/Vim?=
 =?us-ascii?Q?K+uC27uqF//0BVrks6/BBiZOiLl+594S0qKgSsQU3+NKrkfh1DQnLcP5849x?=
 =?us-ascii?Q?9HpOa1wxoBFIUxtMxZqyKx8yAfWGaMbLFhteGUDot73fYHck3cGjnOJyz+z/?=
 =?us-ascii?Q?NLfE+hd/x4rcXQc84svA0NQpfnHNNJpAqbL2o8klmcc7xZGDtxc/jsNyeD5j?=
 =?us-ascii?Q?EZFpRQtXdEN5d+LiQE1Omq8xVTabFFKxkNDyGb+Glmyv0Uncgz+x0q3i1wjG?=
 =?us-ascii?Q?UWdU/MoBbE55e2H+2L19Oo7BnMgLONc+pDu3Dc7Jmhzk1TwTbF6js12WFsdE?=
 =?us-ascii?Q?/qeWaxTp7QGgyWjPUwAb+rDTIURioSfiavl6aB7Q1DmeGGT03EsPvfqunCX2?=
 =?us-ascii?Q?J+hxgEoTr/5LF2YQ//8rkTgiAURuzO2fObEBElGFgUOChn1i9b351ZW7sREF?=
 =?us-ascii?Q?fv2LZ43FcPaA/EDSn97cVl4KAIngjMFcwbYEyRoebRy325bwe5BA9OtBX/Pg?=
 =?us-ascii?Q?06eFspcqV7LHcn6SYjFHje1hHK2T69RnDL2+ZD5M3dyTo5PrZ1ZpO2MkXqqY?=
 =?us-ascii?Q?zFFF8udu6w/9bLkp10OZwdiq9XbCtEy4XK33q/tuelK8odK3iR46bgDs4+XR?=
 =?us-ascii?Q?VIN23WakQd32ZKfIiAwyh4PruIpuw4S0p+3DiD3Ry04tVk0I8c0MZNyGSnhY?=
 =?us-ascii?Q?WMbG5I0N30fzPWSpACF/FKNwF6NGGf22jeFPjvrRHw2atseAavGcWNn2eXOC?=
 =?us-ascii?Q?0lJ8AgjTcVOhXCCo5KvIeG4u+4+FljrG3d05uX0irXgoHyBQNPt7RlIqD4i3?=
 =?us-ascii?Q?Gk0BpWORuxS7odLuCyVbKLPHLMX6RdEcLwkASLR88QCoJkScmWdUxspRLZHb?=
 =?us-ascii?Q?3az8iQDOf5L6h34VHcyQAhjDTGIgswP/TAf1oKGMYE5/AiITzOSOTNI113Py?=
 =?us-ascii?Q?ehEYmO/7Xisp+G+rT5pe53zs7gT3DQhBGcT7nMcZME8A2Kb1SZr5ja9U/GZB?=
 =?us-ascii?Q?BJYReRTyqNVzxB7KjH5vmmUN8LLX2MLW0Q9REQ7OSh2JM+ldZVjDTQJRndqN?=
 =?us-ascii?Q?mKiR+XXlKcGE4kf7T/nY/aKpKsacHvH5sCcqDyGWg/+u7tj+pCoxR6IQkc1w?=
 =?us-ascii?Q?P1gJvEtS54Qsohi2U8qGaxLlftgK/9wZFZbNMcG8qrAenCpbnjZqhFmkIGWR?=
 =?us-ascii?Q?14VutNhhPHHRVLkahvTsQsogBFOnkQt7rcVCUH7AMciS//QGs1k4oKww5Bfx?=
 =?us-ascii?Q?sE75KwinNcmCcavUA/iDv76OOc6mOeKBlFmGqo6nIzy43Se2JsePqpiAmR1z?=
 =?us-ascii?Q?dmyTFg/dWc5hl/21RnCFILXnqpt4XZDPqLgZfHAqayNieSLsQAllbOFHeCIR?=
 =?us-ascii?Q?4W8aDAcKhpA6Bj63VsOQ6PKuES78BvvgBSSHXPR5IfLQ?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB4510CA0476D240F6C39329ACE2759SA0PR12MB4510namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765a976c-da27-435f-5e49-08d9beab6634
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 02:42:41.2590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZ3XSXNpoMOlEmooYVRqVCOP6T9gnZQeNGqxzFgpv2v3RukfvMP/D3kK2aT9/EzpJmcU+byw5RerJoMbNiplRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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

--_000_SA0PR12MB4510CA0476D240F6C39329ACE2759SA0PR12MB4510namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've pushed it already after Alex's review comment. I'll send an extra patc=
h tomorrow for this extra cleanup.

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, December 13, 2021 8:41:17 PM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from amd=
gpu_firmware_info on YC

[Public]

A nitpick.

As we have defined a local variable 'adev', so code like 'smu->adev' should=
 be replaced directly by 'adev' in the function to make code clean.

With above addressed, the series is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Monday, December 13, 2021 11:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from amdgpu_=
firmware_info on YC

This value does not get cached into adev->pm.fw_version during startup for =
smu13 like it does for other SMU like smu12.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
* Run on all v13 APU to match v12 behavior  drivers/gpu/drm/amd/pm/swsmu/sm=
u13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..7fdb63da1316 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)

 int smu_v13_0_check_fw_version(struct smu_context *smu)  {
+       struct amdgpu_device *adev =3D smu->adev;
         uint32_t if_version =3D 0xff, smu_version =3D 0xff;
         uint16_t smu_major;
         uint8_t smu_minor, smu_debug;
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         smu_major =3D (smu_version >> 16) & 0xffff;
         smu_minor =3D (smu_version >> 8) & 0xff;
         smu_debug =3D (smu_version >> 0) & 0xff;
+       if (smu->is_apu)
+               adev->pm.fw_version =3D smu_version;

         switch (smu->adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 2):
--
2.25.1

--_000_SA0PR12MB4510CA0476D240F6C39329ACE2759SA0PR12MB4510namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I've pushed it already after Alex's review comment. I'll send<span id=3D"ms=
-outlook-android-cursor"></span> an extra patch tomorrow for this extra cle=
anup.</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, December 13, 2021 8:41:17 PM<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version f=
rom amdgpu_firmware_info on YC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
A nitpick.<br>
<br>
As we have defined a local variable 'adev', so code like 'smu-&gt;adev' sho=
uld be replaced directly by 'adev' in the function to make code clean.<br>
<br>
With above addressed, the series is:<br>
<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ma=
rio Limonciello<br>
Sent: Monday, December 13, 2021 11:09 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
Subject: [PATCH v2 1/2] drm/amd/pm: fix reading SMU FW version from amdgpu_=
firmware_info on YC<br>
<br>
This value does not get cached into adev-&gt;pm.fw_version during startup f=
or smu13 like it does for other SMU like smu12.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
v1-&gt;v2:<br>
* Run on all v13 APU to match v12 behavior&nbsp; drivers/gpu/drm/amd/pm/sws=
mu/smu13/smu_v13_0.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 55421ea622fb..7fdb63da1316 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -196,6 +196,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)<=
br>
&nbsp;<br>
&nbsp;int smu_v13_0_check_fw_version(struct smu_context *smu)&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t if_version =3D 0x=
ff, smu_version =3D 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t smu_major;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t smu_minor, smu_deb=
ug;<br>
@@ -208,6 +209,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_major =3D (smu_version=
 &gt;&gt; 16) &amp; 0xffff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_minor =3D (smu_version=
 &gt;&gt; 8) &amp; 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_debug =3D (smu_version=
 &gt;&gt; 0) &amp; 0xff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.fw_version =3D smu_version;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;i=
p_versions[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</body>
</html>

--_000_SA0PR12MB4510CA0476D240F6C39329ACE2759SA0PR12MB4510namp_--

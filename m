Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE51C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 15:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5FF10EE48;
	Fri, 21 Apr 2023 15:21:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADFD10EE3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 15:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpVPvlTnXVnQQlwHlW7uhJjPPkGkEo5VCpyx8mswEeLWGq88sAvRu0H1yJPZyx1vd8My4rD1TXUv4aO7iDb1GcmyEi5KIftYtNZXTmL7PNbcfMZun+fYgjK/Zx9EQMBjfM9tzVKjjq5CWKIBDwTElK+XSr5mWziDEdNo2TbmTGiKkElfMj9LB1Cp46QbCpi9kUbT0T/1MJ9a/X7zZ+Tfe9Q0UKgj0elJtcZBvAp/YnChqWLRgkHu1eMNd5SKGXHfjcnvsBVo/NsakAko0wBC8CV3PLrMtZB74quiHuZf1p09guM3BpENBMa+gpv28ukZfDEjk6GJjfzhdutnWe+2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS0goNjI7IwV0INb/DjX8htm8j0VQzSNfO4gl/5QTyI=;
 b=Vi1gnpQ9fM/IQKUEr3gNytK/RS/hi5Gwi64cwrUBhpDX45Au+AaZdXw/sOB7Mch7ZqqhonX7xdFTBsj3o7CeVqRAyHdznj5mWc17wS44gv+7gpWN3qqsjoJwd1idpxjKztRi+WhiE75n0CmYdDYuQ/PCMf0O0Zdk6j8Zri9fRluN0ifq6oB6wJA3JTgJVw5/O3FPCtW0Mp02Oo+G8kK2PDaa8PAWokbL94KnIOVio3irtDKdyWfqEdDN3QTxyGMmZQFJtnUMnMjpKuYI1dS4PDGxdZtLvAvx0S9rNrQ80lmMI6mo2jPCXqYk4BAEeJ6kbtn8SRPiRvau42/Z5Vz95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS0goNjI7IwV0INb/DjX8htm8j0VQzSNfO4gl/5QTyI=;
 b=Dve83KHEV1KMbrngWjc5QNd1KHlVPx6chjr61T6h95iImRXesePiCs5JIC/4pDy1xzfVQJqS6AGW8H1ogRgT3cgVu7EgkFMK8vQtDBy1BmctxEu9QbC6M/5HOgKrz2G2QuYfuBO42pzywj5YSntoUeVm9TwN7pBLycHP5Vey5Rg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.21; Fri, 21 Apr 2023 15:21:11 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:21:11 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches April 20, 2023
Thread-Topic: [PATCH 00/21] DC Patches April 20, 2023
Thread-Index: AQHZc+LZJJ6V5hpRL0GNpiZElsiAba814bdQ
Date: Fri, 21 Apr 2023 15:21:10 +0000
Message-ID: <DS0PR12MB653451022BE5020C220A9B9F9C609@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-21T15:21:09Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=abaae81a-9f88-4178-af91-c03e530f2c29;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-21T15:21:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0c8d02fb-3b07-4124-95a7-d5fc30408ac0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB7596:EE_
x-ms-office365-filtering-correlation-id: fadbac30-978d-4939-624f-08db427c09bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D28p16HZIVQTylF+QTgSlS0cAwkrLeJo76IYgoWg05mQ7ayk1lPyuZxxC9egGpKvSh946dPN+9LNemIF8hU1izkPA3sG0q//VexPfiZxiGytWY/6lz/S0PwQIgjUJ+02XEfgeG4LmD1BGZ6F2rp7yhTnPKAHU7srhORxLZ/FCMWDMgBk0CGDBlD3fVgEubkrQW6FSH6/5OKL6rrsYHEy0Ee2JcWWF5bxoqnzcVGqwqZ+5xMC+RZ/LXGcx5pHnpoVXcJx9LnlUMGVcAPfbmzNvQZQF7QYMU1O+RhU8QrZ4wAsV7Fm0zIaeHBk5vN2W0nUUjtZw30QCfAlCKZpyeEpquif5Hy4ozpmVgEWiOP+YF541/X0TgOnig7j1s6FTfZKb/ghOMlxh1Yjqt2sdSjZte1t0cfE0QJKLf1IRoKZWjHaF7wUa3ruIfStaDwlWqHiqCRinFWmd/pPl020PmwXcXtRQKg7K5Hy43AHjCclnXizsBaxW3P0Wht2WShW1Ess8mz3dOOC3nHTOjmmKXoomLOpfuagK4E1XCMOm7nrEA2TYnG0WFNJcqtbuD1QeBEIanN+Z8YA4AnYTul4mQzrLiBijAVl7ERiufByCwnpB4QHTbLYSSa7/mRXECY2HMdL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(26005)(5660300002)(38100700002)(52536014)(4326008)(122000001)(41300700001)(8676002)(8936002)(316002)(55016003)(6506007)(38070700005)(86362001)(9686003)(53546011)(2906002)(33656002)(7696005)(71200400001)(83380400001)(186003)(66556008)(110136005)(64756008)(66446008)(76116006)(66476007)(66946007)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LCQfw4qiE/zuRxg0aHPLI6evuW23lQdXk8PqQ8wabycC6+xFxmIbC//Dz3iu?=
 =?us-ascii?Q?yDIt86mpO6ymJb+B/3oPJvfTc+ywesxvjEARhjTmdNXIZQd8IpMUMmr/jgxk?=
 =?us-ascii?Q?aKQpUHqoWM/k1hEDrK15Pm27vdNfsEBY/t+wVp8spmgwl8uyE+FQfCvZMxh+?=
 =?us-ascii?Q?znez41/5F7OPikWUvFjcQeS7ujusGNF51ZNGw+oEcBPVuNSppc5dVjo4mZwg?=
 =?us-ascii?Q?jOthORSvNXLEJsZsuCoMbjzNg1dfnDbaelpHBfkyvNxCYmK75pB8u7dEz6bD?=
 =?us-ascii?Q?/5GxS9/v6dSfMHxodEokAGb3JhA2ftgur5myUdcVpdDqIp29nj4JbCa9peps?=
 =?us-ascii?Q?LXIZeZzdezyBA/erZtBoKHuBKkR8wX0Kgi7lepwyYyMuSKXBGCNOlkgS7J+E?=
 =?us-ascii?Q?nDn5O2owBAjDrK95E/HgkpWP+QLyK8jmcrm8ExRfiS853YqOK144wEgFr7wT?=
 =?us-ascii?Q?9MYKGT2I+Iq2Gc6lqSMHqTTgPHceFAik+Ie0YVHqfYqfbhan8PKesCKcZJ/7?=
 =?us-ascii?Q?FTSx+OwGG9NACUoDvMIMyEsod662GEIGrKtmzsyZFMM+iS5vd9Jg5XAWdXQ7?=
 =?us-ascii?Q?3X6gjUmCvqtSTMFj24i3OJB4dCQ0T56ZtABEWM9Zyv+wRS0ik/FRB8j0fuSg?=
 =?us-ascii?Q?Toa/VxPCP4JP16pCjQStefd8NhttyWyNw2mAZG8h/dzFN2gs4Bho85vxb4Dv?=
 =?us-ascii?Q?TBA88CmdUZQkFP0qkHp1ShDrk2Uj0UoKFXOcW9ru3K9nxgDLzg1FWX0wQODk?=
 =?us-ascii?Q?EtB7hq2mX6RVJfxDgOHv2su6s5ru9CrSd8ELUbGYZKpEoH9mJH/MrnQXXyLj?=
 =?us-ascii?Q?spv6qDQyXSgy61W4k02LGVnb29+/6/h/uVtZpdXwynkySZ+ZxNHvfrwjrmTQ?=
 =?us-ascii?Q?ddeUMjcjDhIEN6eueA8GT3QVIpHp9MNb9p4GzBsjRLtQRe4Em79kvfi85YxL?=
 =?us-ascii?Q?mjIWV9jOTG4nbCa+7/D02f+ukILkvlBKl+qfyt/+8MQjDLVqPaxkFYIgi54B?=
 =?us-ascii?Q?45UrCSHKjuBeemvMFNH3qeVSj5PE+FKGAlXfd6iEH+bl/K7pL77buqLHbOu5?=
 =?us-ascii?Q?pwXpQJuRgb0V7f4a2Ng4vTs1u8YghtxwpRwNyWJlmQ+VCDvpsOucJCb3kJjz?=
 =?us-ascii?Q?bzW/J7b9WbCrxvUN45xDptmQMBGaR72v+kRkreQ+gQG+63a+uBklSJEmoDrJ?=
 =?us-ascii?Q?ilzCtKBbeuMV8bpCxc5TDZdhuufGLHtUzBC3RQrX9MTD2DktZMreKS5Ks3ov?=
 =?us-ascii?Q?FqGR7ydoArLl4r3Q18efK5PPf7s0pMmbVS0Zh93Els0HbpyJp4A1EBoKvEOM?=
 =?us-ascii?Q?M2OaRiYPhehKwr3j8R15an4vcpVyS7KglXZAhs7TQ/mPM6r/QLJ/vPaIjiWE?=
 =?us-ascii?Q?kbJC9+yXUlu5yEa/SPRG3NC9p5rl0mYw04mXHZ2FOqqumHh/0jOAYssPOfEB?=
 =?us-ascii?Q?/isXQGD0/grTqcZ5ZMXEHh1PiZvpewlRuhIrYIuxiAq2daJPUoL98xhjTDAk?=
 =?us-ascii?Q?bh6fuCTiyfvSK6YSMtvnWFZa5x4J7PJWs7aRaLz/ykDDQtfvbWToqtPjv+x5?=
 =?us-ascii?Q?hBS8VIQh7vw0gH6svoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadbac30-978d-4939-624f-08db427c09bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 15:21:10.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shiZWZiLmLHfPSD8YhqHK124atVpAczOm1aV6147WkgdnXRORJCGnoAIXWfNI14LDuu1nm74Ip1i+gdPObTa6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the amd-staging-drm-next branch (Head commit - 329=
fb1a32e80 drm/amd/display: 3.2.231) with new patches added on top of it. Th=
is branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-w=
eekly basis).
=20
=20
Tested on Ubuntu 22.04.1 and Chrome OS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: April 20, 2023 7:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/21] DC Patches April 20, 2023

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Improvements in the SubVP feature
- Keep disabling aux-i delay as 0
- Add p-state debugging and improvements
- Fix in secure display context creation
- add an option to use custom backlight caps
- Lowering min Z8 residency time
- Restore rptr/wptr for DMCUB as a workaround
- Update FW feature caps struct=20

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (1):
  drm/amd/display: Fix in secure display context creation

Alex Hung (1):
  drm/amd/display: implement force function in amdgpu_dm_connector_funcs

Alvin Lee (6):
  drm/amd/display: Update FW feature caps struct
  drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO
  drm/amd/display: Enable SubVP on PSR panels if single stream
  drm/amd/display: For no plane case set pstate support in validation
  drm/amd/display: Query GECC enable for SubVP disable
  drm/amd/display: Enable SubVP for high refresh rate displays

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.163.0

Aric Cyr (2):
  drm/amd/display: 3.2.232
  drm/amd/display: 3.2.233

Dmytro Laktyushkin (1):
  drm/amd/display: add pixel rate based CRB allocation support

Gabe Teeger (1):
  drm/amd/display: update extended blank for dcn314 onwards

Hersen Wu (1):
  drm/amd/display: assign edid_blob_ptr with edid from debugfs

JinZe.Xu (1):
  drm/amd/display: Restore rptr/wptr for DMCUB as workaround

Josip Pavic (1):
  drm/amd/display: add option to use custom backlight caps

Leo (Hanghong) Ma (1):
  drm/amd/display: Update scaler recout data for visual confirm

Leo Chen (1):
  drm/amd/display: Lowering min Z8 residency time

Michael Strauss (2):
  drm/amd/display: Convert Delaying Aux-I Disable To Monitor Patch
  drm/amd/display: Keep disable aux-i delay as 0

Sung Lee (1):
  drm/amd/display: Add p-state debugging

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 56 ++++++++---  .../drm/am=
d/display/amdgpu_dm/amdgpu_dm_crc.h |  2 +-  .../display/dc/clk_mgr/dcn30/d=
cn30_clk_mgr.c  |  4 +-  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  7=
 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 18 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 18 +---
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |  5 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   | 97 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 +  .../drm/amd/display/=
dc/dcn32/dcn32_resource.h | 14 +++  .../display/dc/dcn32/dcn32_resource_hel=
pers.c | 15 +++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 31 +++---  .../drm/amd/dis=
play/dc/dml/dcn31/dcn31_fpu.c  | 25 ++++-  .../drm/amd/display/dc/dml/dcn31=
/dcn31_fpu.h  |  3 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 39 +++++---
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  3 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 14 ++-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   | 16 +--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 83 +++++++++++++++-  .../d=
rm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        | 12 ++-
 .../amd/display/dc/dml/display_mode_structs.h |  3 +-  .../drm/amd/display=
/dc/dml/display_mode_vba.c |  6 ++  .../gpu/drm/amd/display/dc/inc/hw/dchub=
bub.h  |  1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    | 23 +++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 17 +++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  5 +  .../gpu/drm/amd/disp=
lay/dmub/src/dmub_dcn20.h |  2 +  .../gpu/drm/amd/display/dmub/src/dmub_dcn=
31.c |  5 +  .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |  2 +  .../gpu/=
drm/amd/display/dmub/src/dmub_dcn32.c |  8 ++  .../gpu/drm/amd/display/dmub=
/src/dmub_dcn32.h |  3 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 17 ++++
 .../amd/display/modules/power/power_helpers.c | 43 ++++++++  .../amd/displ=
ay/modules/power/power_helpers.h |  3 +
 44 files changed, 518 insertions(+), 131 deletions(-)

--
2.39.2

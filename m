Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0374EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 14:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2E110E82B;
	Mon, 28 Feb 2022 14:16:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C172810E813
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 14:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDgQKLQg4z1DStRFzREJDQTK0udk4YkYkqOdqaFhcfRvV6ob/DTqarQ+ehhlmJc2hHN+x+3hHZJG8dvgIcXhObF4NLaJgbLrx4+wJCi/VV3z7X5v/C6U6d4QSVnw7itzcwtbrc+zeWZZiWXF6naGMSwr6kDKpqWyEGPGYiqpsXpSLQ48fwgGhIppIjC/vbF64v8COx8TauK2VxWHRBfBb4waO0yjGScTtqyC7Hvz3iYrboSVMxYsCCvL/j27re+lglVlV5LR8wgTxgj0QCINltJubpDo+XjFwsjhBinj/NwDLvDEPOXP/zeBuHXpDKmyTFeL4KS/rB3mQdzqAOOsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn/+Rx7ell/of1Jvw9C/JPruOgO2FxB81aFLCvGcqjY=;
 b=diz2+PSTV1brGbfYsE2NcnTIgbjFHhTvdYle4ABqnhTt8JVT3VMf5Qz4768LZFyGz2ZuRb5e1NpaY3t4YOqHb6wlEpQNcuITvH2Nj4dLk+Cc9fwfSYgQ45tCYd5/MGcYRwamREKnuu4FykaZvTrm5bUb++istbw4AuFZDe2hvrM+kBSJYq2iWUyhHTqZacxHdFkaRoM/2DZsxjbjvrVtPiXAZJsi455ogE8vCoq2LSx1rPpqeQ/TYD8ZASlCSbJ91zDcCkbY7EtGZWf0t7R83SIsFD3SUzP+NV/VH2BY/EzI/nt7haEievpn4ZGjQUa3xrraqsolS3YjY5Nn7lxe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn/+Rx7ell/of1Jvw9C/JPruOgO2FxB81aFLCvGcqjY=;
 b=Hj1asxy8wepn4rjSjRc0Xut5/tkqa7eoVERJJ0ige84+WfWjuxtSTb4ZJb/mglnFXSllaRc9MGtLJlaF//z50NZwubLutS6F7HYPJ6d1xCbxutQwyOOUUqHBqTwMVZcxvZvhxVyOYqbsLErArEs2VjPJOauV6AR3EI2EQ+FEX7g=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 14:16:22 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::5125:da91:f54b:aba4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::5125:da91:f54b:aba4%6]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:16:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches Feburary 26, 2022
Thread-Topic: [PATCH 00/14] DC Patches Feburary 26, 2022
Thread-Index: AQHYKydVr+ZzxTFAmEi61KE7W4zdhaypBR2g
Date: Mon, 28 Feb 2022 14:16:22 +0000
Message-ID: <DM6PR12MB35294E2D0664FEBAD1FBEF699C019@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-28T14:16:07Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=57d151f7-2c07-4a51-a312-a758806ed311;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-28T14:16:21Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b71f95a2-04de-4f93-9090-8e0d7f8e2394
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34791c53-70ae-40c0-9e68-08d9fac4e5f3
x-ms-traffictypediagnostic: CH2PR12MB4874:EE_
x-microsoft-antispam-prvs: <CH2PR12MB48741187CCD27EC88A4ECED19C019@CH2PR12MB4874.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQoG2Im/eu5C83NxfCGyemJ41tTTB6U/XenIV6YknMegv/DL518VOlj62iRhFQ5pmf0/R/t8TEh829cxfhjrqBFf8ymN873GGGq+KLXJpvvOn6nuN13EVQdqtdN7QuOUSHFIg/nyGipRg4p6/CZyrQx+e6B7It4GQQV+Dl0B1br5ZlNkmFZXXjBCnMRA1R+PkU0FWkOtWEQKlJxh6h/DePDWchowM2BsmBSayWDZbbaqUqQfphcs8DTh96VYKT1To2i5MHlfPo793aoSffeEAGyt8bNcFmWFyhSiqwuyAGuomO83HGZukkzU5I/k8k41tSAcV0DrbkFk6JytczSCcNRKE3JNwbfPNGV2J4RzbD5Yfr+TDCzKD7xHqSywclqwWDbcO2aTwyISECbTuroTKwVYXvJVb4TNiPjQvgzlBpuOefGuK724oUqV3inBK8TTmRmyijFj19FGFLGd1vlRLBdgC19ZyWfz7y7hxirXVq/KFNEnPi5LchvekKMEOsZRVUKElNfXcA4b45/rXkM8IX8oD5Joop/MKqwrei7RpZlCo1KglNTL+IPGZ3+k3hLPo2LYtUYYD0fZh6pVkYCpb2qG3KTh2mWQT9R3eIhuv2d2EVPL+1NOpYbUWJp9GnZuzxqySe1MDYcVOD9JAeliQ0pUFwy7skFcguRrizCJsTnXYdfpO+v6BZNmTKjgYUg/iKCNHKR7GIz9LCEoq1teOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(9686003)(316002)(6506007)(7696005)(26005)(186003)(54906003)(110136005)(71200400001)(508600001)(8936002)(5660300002)(55016003)(2906002)(4326008)(52536014)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qPmowhtgwU9rRO/LTrWrfQlWLAflvtGoDaXW8Oa9b95cMxBJhUP2uNYAT3XH?=
 =?us-ascii?Q?yGUOQGAudoD7sV5+1n3u5c6dre9L5bebEFz2xc6xVnbOKgU4NvksqU5/YJZP?=
 =?us-ascii?Q?ntOy+iptguXGpCqkLu8QosSkX0FnF+jtd71dHT7tdBPAaM52b4fSfgEIn207?=
 =?us-ascii?Q?dWV8mPIV5Xx3Mb59GEfoqNI2dibO+dNX7Ap0TCUovbW6l6QZQyC1QQspkiZa?=
 =?us-ascii?Q?96JYCBkBOOgWWrVIbKB1a8IhwmpVrcXcR6kqaJDS51FJayaqTmiqVc0ON55v?=
 =?us-ascii?Q?xga1EaHxkOivJf8QqbXONkni7sdlPizvk6jwrVlmxdi+v/d/fLSgc0gLRnXX?=
 =?us-ascii?Q?TSXDxZrRVhA8rKSwz374QuX0lQKJ76xLDatlRX7YxWxklWadrJrGkRB1psY3?=
 =?us-ascii?Q?fPKVY95pbvPPN6B4LxfqYkq8ptRkDAODfhH9eb1EbXL6mgHrwZHNzYjQjzR3?=
 =?us-ascii?Q?y2FoSjsc2p0cNtFTaLNjgU/fypKmolHtWvBkQ5ViW4SerFmXW7xNhmWs3o80?=
 =?us-ascii?Q?ax/Xg5d6clBAEJsRtNsGVs6rhnEHb4uEikATrocVl1IkccWARyRBVQlL2fpm?=
 =?us-ascii?Q?cxs7/yXgtZR9El4JB5dEAtvs60/Nv9lXJHlg7XPxZ9Xd4Hhr4/rnHt6uIihb?=
 =?us-ascii?Q?XpnFOY6RGGIADeBBRYZo6lR22avElu/RNque8rz2bm7GYsOdfyF/leV3rX4/?=
 =?us-ascii?Q?Mh66hotcVJl9nqGdSZCFfZeKZv9LsIcgZhdGJXnY8Tq0pxJAapH+bL0ptCGY?=
 =?us-ascii?Q?KnwsLONGFZvJXLVM5balrR/XiXF5ST/Y5OSLCXAvWpth1ctr1vHikDt/zRmr?=
 =?us-ascii?Q?kGDtvPe8d/g8hWTKHldqXFpH5j+/GYAjN9MiUbL05BE8p+2Z35H21h7g4QeV?=
 =?us-ascii?Q?HVUuhN9Nc60KEzQTTnCyHImCsD5sCHsQBEFmfr1EdGsLBpx1fFN3COqSpjN9?=
 =?us-ascii?Q?yJNIUdGy9LhZ9y+s+GYVK/2I84tF0D8yTPjDXGy+dUm97GIPd5Wleey11tN6?=
 =?us-ascii?Q?AuHZMicpvvNFmiV1g3CFDpHVLjcOJQ29SEjJ0vhh+D+EVb+KiCOwnQoM1Bca?=
 =?us-ascii?Q?HJYP3QyUWWJQOq0GDfABUKbT0iJ3rnmzx6TrVaMiAMTbk/JLCuMbs/k971QF?=
 =?us-ascii?Q?ppDWI8wWvt6aY5sfYo60mvn6i/885uZbahHRsHunEJVRmNGH+zGTBas2KCac?=
 =?us-ascii?Q?iTlnjFvpmv3EduK4vWZ4EaiCHLegK6pCNp1IckvUr1ihRtBX5USb8LIgdcJY?=
 =?us-ascii?Q?S9JONcMPExZ2Nn36fvi2rmYQ0ad0YJTRw/5xpoRIOfAk0CzNfQBN0KG9QyhM?=
 =?us-ascii?Q?t94h6fmsnr+fjWouo/lkDu7MtLdNFeCASUG5Ro8+o6Qq2VARexeI3Xcn91LF?=
 =?us-ascii?Q?QmamyF6czuJp8ev97Q6sf3rdJMGMY/TjytfNE6ScBbuWNc3owGjJ4pSYU2ct?=
 =?us-ascii?Q?BAPOK48l1mQQlpnWbLsTXoCrKDOb6hs44osFu9fYV58g4cEmfhcmMYeD9mw2?=
 =?us-ascii?Q?0agg00bBAJ2qWy3fQWGZS+4NzU+FF93i6E1WWNAVycSeLRjoSlWrDGy/qtY5?=
 =?us-ascii?Q?2GwBOimSneB/welAB9G0MmQ5mAgm86i1ZBzcGd3w666iwFHFG3uo6l7eiPVo?=
 =?us-ascii?Q?7xyvGJuFshVR0AY9KYl08dM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34791c53-70ae-40c0-9e68-08d9fac4e5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 14:16:22.7024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed9A6206T0l+YA3k5EmWoaI/VuZ+O3BrUcRsdQMVk/MvmzpyfF89K/rGt5042Xs8d+tZuj+4EwdQJVo87gA66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.13 and ChromeOS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alan Liu
Sent: February 26, 2022 6:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Liu, HaoPing (Alan) <Hao=
Ping.Liu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry=
 <Harry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=
; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com=
>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pilla=
i@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet=
.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, P=
avle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/14] DC Patches Feburary 26, 2022

This DC patchset brings improvements in multiple areas. In summary, we have=
:
=20
* Removing legacy invalid code.
* Fixes in DC, DCE110.
* Enhancements in DMUB.
* Improvements on DCN10, DCN31.
* Firmware promotion.

drm/amd/display: 3.2.175

	This version brings along following fixes:
	- Remove invalid RDPCS Programming in DAL
	- Make functional resource functions non-static
	- Reset VIC if HDMI_VIC is present
	- Add frame alternate 3D & restrict HW packed on dongles
	- Reg to turn on/off PSR Power seq in FSM
	- Modify plane removal sequence to avoid hangs
	- Pass HostVM enable flag into DCN3.1 DML
	- DC Validation failures
	- Program OPP before ODM
	- Refactor fixed VS w/a for PHY tests
	- Pass deep sleep disabled allow info to dmub fw
	- Refine the EDID override
	- [FW Promotion] Release 0.0.106.0
	- Add verify_link_cap back for hdmi

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.106.0

Aric Cyr (1):
  drm/amd/display: 3.2.175

Charlene Liu (1):
  drm/amd/display: add verify_link_cap back for hdmi

Chris Park (1):
  drm/amd/display: Reset VIC if HDMI_VIC is present

Dillon Varone (2):
  drm/amd/display: Add frame alternate 3D & restrict HW packed on
    dongles
  drm/amd/display: Modify plane removal sequence to avoid hangs.

Hansen Dsouza (1):
  drm/amd/display: Remove invalid RDPCS Programming in DAL

Michael Strauss (1):
  drm/amd/display: Pass HostVM enable flag into DCN3.1 DML

Nicholas Kazlauskas (1):
  drm/amd/display: Make functional resource functions non-static

Robin Chen (1):
  drm/amd/display: Pass deep sleep disabled allow info to dmub fw

Shah, Dharati (1):
  drm/amd/display: Adding a dc_debug option and dmub setting to use PHY
    FSM for PSR

Shen, George (1):
  drm/amd/display: Refactor fixed VS w/a for PHY tests

Wesley Chalmers (1):
  drm/amd/display: Program OPP before ODM

jinzh (1):
  drm/amd/display: refine the EDID override

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++++-  .../gpu/drm/amd=
/display/dc/core/dc_link_dp.c  | 16 ++++--  .../gpu/drm/amd/display/dc/core=
/dc_resource.c |  2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 49 ++++++++++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  5 +-  .../gpu/drm/amd/dis=
play/dc/dcn20/dcn20_hubp.c | 21 ++------  .../display/dc/dcn31/dcn31_dio_li=
nk_encoder.c |  9 ----  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  5 =
+-  .../drm/amd/display/dc/dcn31/dcn31_resource.h |  5 ++
 .../amd/display/dc/dcn315/dcn315_resource.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  3 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 12 +++--
 14 files changed, 83 insertions(+), 64 deletions(-)

--
2.25.1

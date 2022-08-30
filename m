Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4013DECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 16:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E84E10E1C4;
	Tue, 30 Aug 2022 16:29:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C8710E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 16:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1WqGa3MAgDe9ychH16yvrIiMxtlvMm5UG4OqA1hg4AZOY4tU/B59BK7PigOKwjpo39vgusiSbF5rhEgp7w2iTkLsKcv7Ltdw1Dn1a05Xpdl45VkmThFev9OKGpzG6DT0qeFmKQwuAboLw7OD4TeXdicwYg5bO0zOq1c2eT6YbfX6Cfzbo+vk6CJ69kslX+F7DUgQM1Y82qnG/e8mwu2wfI8WcZZaEV3DduMKl5xfCA6C+gNAL+BwnmrbEVxU+skFalMOjfjPbXnLpC9AFibSF+pci8etF/Tfc0ntyc9V1Pj2vTL3x3nhUioXtGWb/nljIphBL4LBoIoYdlrYos8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNmSMxx5QqUxBsXarg+/ihGmYf+IKc2tTN4Yx+Sek7c=;
 b=MOAs2kszBM/vNlXwfT4QPATHx5wRreygCn7VVwZD1Czi/oDW2LmpRasKNu6oRBmubLJ40CtqDf2DzTHEABhPuDf3pfBA19CEO3sOdQgK1lCeLZh/zH3WjQ5p/8sD4LAbXg1NCNBTj5Ug9JOjHlsQwHhutnpEqbd2AXBMLkecmHyw6qjDR7ivZINq6XTVaEXn16wr1OpMR4axAiFSr0SsPmsJj4wAkVWnCDELS1rTXNNFqo6amAhHcZ004pk0hq6eD8yRKgCX8EPm60gYQ7FJeMFhnQfNhtNfKFoy1gnADWKRRbYshXClcc5E3OfZFX/qJCW5VG/DssO2tr248c5IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNmSMxx5QqUxBsXarg+/ihGmYf+IKc2tTN4Yx+Sek7c=;
 b=k9TlFeVO03BNWsUBqXI7WURM8lh6PvkCeNEJy3ygM/3OY5MOWUZvyIGqTvwqTn85hVlxqOH7RlLMowyAqCDqmb/fiuL7L4UEeHDOOqpw1CNZ9GjsJpOedAgdO5/w8o3+b24KkpfgdQssITVKOM3/nvdXstLK2QWUITpxvL49Vno=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Tue, 30 Aug 2022 16:29:07 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:29:07 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chang, Brian" <Brian.Chang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/33] DC Patches August 27 ,2022
Thread-Topic: [PATCH 00/33] DC Patches August 27 ,2022
Thread-Index: AQHYubx8+mAAnV2Ue0Ga0IhnlpLb8a3Gq7CA
Date: Tue, 30 Aug 2022 16:29:07 +0000
Message-ID: <DS0PR12MB6534B9459928D18CF8B5437B9C799@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-30T01:26:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0fe906d4-ac37-42a0-9550-df934d166dc7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-30T16:29:06Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 30a40ffb-4863-4e78-b7b6-1b1054c3da27
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e42386e1-0375-4132-c630-08da8aa4c2ff
x-ms-traffictypediagnostic: CY5PR12MB6180:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5M9JWSZG8CKOB2TcGr7AowaFl+t/E0hTRBgSHpfNlKk2WwcISgsTnaA6uNesND7BPLj1E/50VAG4R1fuPCtlZO6g+Q+X2d+pg9gluDVLH6Y83T+YskbZIQx/cmsA73JEzUtQVI4e8iuAgKq8GV5uvoUVbDn44IbB7sITexATvTJMI5JQZ47mYnI9FGGwpVDU4kToSbmkDJH4b5GMNQmSZ1/9hLEyvAkSqp/AJyagFD/X7SSRpIZq2KTx/G5ROfHnTgRxfkgTB1u14JtwtT2vfBLs0lNXLBGvuP9dmb40QhbPwUT2g/HnBGbsqKVPnZ3ev3HXxPSTtOzmOH2z6JdezXhgYHjFLgncg8dFSNkM9bC4auAwSDcKTcKWl/30oXFH2jzH8X2cQtnn0rKC4Yi/C5HgQ8SBCL87FkQ3Tbme3TybzwtLQ6/k97HeGZLy1JGqnJbkGLt3rYm8R0Ybp8Ou5Ny28gsgQ6LHZOsykcKpybsAL2xRhYdb1QDYtKNTAMYxx8APoi4yHPIRBguelDBI+rW8ev2eRZuDsELz2tibHlyvezRJXhoFwhh3pg+guClI5zEbg3fR+Vm5L5dzPkSPEN0Pyz0kpxD2BzYYjRLSKzGsCxBkpPNj8Gy7lgy9673kRpaSlDpPzXhkcRakBzCgQFlFHTwLnQZfYuyYX60ta2mk6imVAqyMGIOpN82jibIomoaIrUtJ64DIlh08teWP+mBJYwUcqAbS4A7XXcVgs4tOdQSqIwXIYD0QwGQ2A9INV6opDAXqlC6GSe8wcvmKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(316002)(110136005)(66446008)(66556008)(66476007)(4326008)(66946007)(8676002)(64756008)(76116006)(86362001)(5660300002)(54906003)(478600001)(8936002)(41300700001)(52536014)(71200400001)(38070700005)(122000001)(26005)(6506007)(53546011)(2906002)(9686003)(38100700002)(83380400001)(55016003)(7696005)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P0GP3Ers4QPY+AazaeAjfvFPdlhPeWUq1IKPgTH/tFP57dYZUNhM6e5Dr5XQ?=
 =?us-ascii?Q?qVKz3QXquABF21QUCgR2CVli94dMovNQaApYNI/mJ1xDGGBv2GPOEIPPU9+t?=
 =?us-ascii?Q?Xh+LaCY91BpQMtdYMcO0U5EzklXrMYfG+Bbo7v8J+mnLRX9cxQvKLcf4ms6u?=
 =?us-ascii?Q?CIl/ghCWg5IERcQcy/adQPfzZbteTnibNHcWICO4ZNaBC694dqXVgvzt/jxF?=
 =?us-ascii?Q?8ybXi0Yp9QpT3E1Bw6Q3poiimSQCzvTnb2Vp5xTER6mG2ksryq0iiKlBjVQ9?=
 =?us-ascii?Q?hiT8yYmWYdCQQ34CEG3Pig1v94CVYpzkBgK1AP+Jy+iiXs2jWigRHcGeD35d?=
 =?us-ascii?Q?clpF097VnEinfX/+jmbcrwup8/dzKlH+q8DXiNrPsugR2HgIZqEVsG1aBHGg?=
 =?us-ascii?Q?yNy94Puk+ptD5w1YoyjeBgZvjOlM5v1EkSXKTykdvVfqHHgaaI2uWwLA5paz?=
 =?us-ascii?Q?z6wZNRTO+9/UCzfnvHIrKW0TWO1IIUjgdv7VZKkpG0mpvwQNnPdFXzLyGfbz?=
 =?us-ascii?Q?v1+Whsr9E6y3KIPBhZQ1e17xy1kPusy6NBo2F2F1c2bswVJ/lfgvsyeM5rfx?=
 =?us-ascii?Q?BRhqpj7jkr9wc8jeAsG1i8TmQs+hic9RefN9wZQfew4S/vfCirbnk1SHlyQ1?=
 =?us-ascii?Q?KnF6Sz5hb9ZtKeFw7A4yQoMXglFLbyL+is2p4fNt1728VR8IxQYbtvZ7kaRK?=
 =?us-ascii?Q?OAQ73BBdn8TVA2d6Oi6BhQYVtEO6uT0z0gz95zGbV0204RApZbq5Yu829yr+?=
 =?us-ascii?Q?iVR8iHrAUlcG5zxHeTj3OH0kYL98PuQmhmOVy7Z0R9Fnsxi7pn7w6aJV+Ws+?=
 =?us-ascii?Q?sPUi2ZRAmFF/be5VIeIjk7yWKKoS1zKyB2IM8e7RxeuOHq98ikGIwMQk6ZA1?=
 =?us-ascii?Q?Y4awPk48WzgQGxb/P8bc/lR5NdzX9TaULMjv5//XTG5WEH8yqU2TG2edpL1/?=
 =?us-ascii?Q?3Y4YJYfYCzqrHz+3/G7/xOfLKR9fHtlgalI+QI8Dwz3Cs/mkONDmVexh8X2X?=
 =?us-ascii?Q?I0YoOFh6OTK0WyJdPvOCqBX7cB8Sfw+S8FwrjAKYPWVfSgQrfWZd2rtXiCQ1?=
 =?us-ascii?Q?rR2abq+BgmvphgY2Y4AC4uaOm5cbAVu2qBBpTQU5fp8XRpa3bOMvurygBXiI?=
 =?us-ascii?Q?0bfnU6dmE1svIkOvfl3dou/5mEssWoTeq9tPACeWPpvqj6+E+7an0Q+yBhHu?=
 =?us-ascii?Q?hA+apPheS2hiakMad35YQyJBHV3iyUZWKwAWMZ98VclD8Q6bLCOgI+hLv7Kd?=
 =?us-ascii?Q?fliKpoNoVH5pFL4Vv+MsPVzvOlphWVQjpWUiZm8B7NPhmSqXi3mfdoRvp+Jp?=
 =?us-ascii?Q?BhcsjjBILXid4YLvJZL7WHSojqoCZDuG7Phqf+7pbYP/HH6OTwTxB/vrw0vc?=
 =?us-ascii?Q?z8oSPfOg6YF+ev9Cgf2+Q7kjTrdTELjEfF7nILwWFh+TYv9Pg+0YESIZGFmt?=
 =?us-ascii?Q?fUHm92kbJXDN3Il9+WTmcWEEGaMXP4/ddfq5vl062Xxa4rWX84VoS21wMO6J?=
 =?us-ascii?Q?9r0SD1+8Y0UeswT1+PjfRHf+jO5iohdgbiQLp6NL+HxCy+DW3oWZKE5ELRZB?=
 =?us-ascii?Q?r9zze/YL9oOoF0n9EvQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42386e1-0375-4132-c630-08da8aa4c2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 16:29:07.6522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSspttla3qBoVuju2GMotk5g0/SN0o1Hps0nlnqNKUBcYE/Ias/o69Ez3VUwa8jsD0+2GSpgleGPEOuADmxPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chang,
 Brian" <Brian.Chang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
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
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz)
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
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
The patchset consists of the amd-staging-drm-next branch (Head commit - afa=
4f339ec6175bdd2e9d12d771aef3cfedb5960) with new patches added on top of it.=
 This branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a b=
i-weekly basis).

=20
Tested on Ubuntu 22.04
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of brichang
Sent: August 26, 2022 6:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chang, Brian <Brian.Chan=
g@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry=
.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Sique=
ira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu=
, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.c=
om>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@=
amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <P=
avle.Kotarac@amd.com>
Subject: [PATCH 00/33] DC Patches August 27 ,2022

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Correct cursor position on horizontal mirror;
* Fix black flash when switching from ODM2to1 to ODMBypass;
* Fix plane and stream check;
* Fix viewport after pipe merge;
* Correct plane for CAB cursor;
* Fix comment to correct visual confirm option;
* Fix SubVP related regression;
* Fix primary EDP link detection;
* Fix wrong register access;
* Fix cursor size allocation for DCN32/321;
* Fix display fresh edge case from MALL for DCN321;
* Add HPO instance;
* Refactor EDP codes;
* Add SubVP scaling case;
* Add support for visual confirm color;
* Fix PHY state update;
* Cleanup PSR flag;
* Fix cursor lag with PSR1 eDP;
* Add DC debug optioon for LTTPR mode;
* Add override flag for some dongle;
* Fix SubVP state after pipe programming;
* Remove assert from PHY state update;
* Fix dig fifo read level before reset;
* Add dcn35 basic suppoet;
* Fix OTG H timming for dcn314;
* Fix aux transaction;
* Fix DCN32 DPSTREAMCLK_CNTL programming;
* Fix SubVP scheduling issues;
* Set ODM policy.


Alvin Lee (3):
  drm/amd/display: Don't choose SubVP display if ActiveMargin > 0
  drm/amd/display: Only commit SubVP state after pipe programming
  drm/amd/display: SubVP missing scaling case

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.132.0

Aric Cyr (1):
  drm/amd/display: 3.2.201

Aurabindo Pillai (5):
  drm/amd/display: Fix CAB cursor size allocation for DCN32/321
  drm/amd/display: disable display fresh from MALL on an edge case for
    DCN321
  drm/amd/display: use actual cursor size instead of max for CAB
    allocation
  drm/amd/display: Revert "program k1/k2 divider for virtual signal for
    DCN32"
  drm/amd/display: Use correct plane for CAB cursor size allocation

Charlene Liu (2):
  drm/amd/display: add dcn35 basic support
  drm/amd/display: fix wrong register access

Chen, Leo (1):
  drm/amd/display: add a override flag as wa for some specific dongle

Duncan Ma (1):
  drm/amd/display: Fix OTG H timing reset for dcn314

Ethan Wellenreiter (2):
  drm/amd/display: Re-initialize viewport after pipe merge
  drm/amd/display: Fix check for stream and plane

Gabe Teeger (2):
  drm/amd/display: Cursor lag with PSR1 eDP
  drm/amd/display: Cleanup PSR flag

George Shen (1):
  drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming

Ian Chen (2):
  drm/amd/display: Refactor edp dsc codes.
  drm/amd/display: Add comments.

Iswara Nagulendran (1):
  drm/amd/display: Fix primary EDP link detection

Leo (Hanghong) Ma (2):
  drm/amd/display: Add visual confirm color support for SubVP
  drm/amd/display: Add support for visual confirm color

Leo Chen (1):
  drm/amd/display: Missing HPO instance added

Lewis Huang (1):
  drm/amd/display: Refine aux transaction before retrieve caps

Martin Tsai (1):
  drm/amd/display: Correct cursor position on horizontal mirror

Michael Strauss (1):
  drm/amd/display: Add DC debug option to force LTTPR mode

Taimur Hassan (3):
  drm/amd/display: Set ODM policy based on number of DSC slices
  drm/amd/display: Remove assert from PHY state update
  drm/amd/display: Allow PHY state update between same states

Vladimir Stempen (1):
  drm/amd/display: Fix black flash when switching from ODM2to1 to
    ODMBypass

Wang Fudong (1):
  drm/amd/display: set dig fifo read start level to 7 before dig fifo
    reset

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-  .../amd/display/amd=
gpu_dm/amdgpu_dm_helpers.c | 19 +++++
 .../drm/amd/display/dc/clk_mgr/Makefile.rej   | 17 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 +++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 38 +++++++++  drivers/gpu/=
drm/amd/display/dc/core/dc_link.c | 22 ++---  .../gpu/drm/amd/display/dc/co=
re/dc_link_dp.c  | 53 +++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 41 ++++++++-  drivers/gpu/=
drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 12 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  9 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 13 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  5 +-  .../gpu/drm/amd/dis=
play/dc/dcn10/dcn10_hubp.c |  9 +-  .../amd/display/dc/dcn10/dcn10_hw_seque=
ncer.c | 83 +++++++++++++------
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |  3 +-  .../display/dc/dcn3=
1/dcn31_dio_link_encoder.c |  3 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      | 10 ++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  1 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  3 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |  1 -
 .../amd/display/dc/dcn316/dcn316_resource.c   |  1 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  8 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  5 ++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 75 ++++++++++++-----
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  7 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 36 +++++++-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  4 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  7 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +  .../gpu/drm/amd/disp=
lay/dc/inc/hw_sequencer.h |  5 ++
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 47 ++++++++++-
 .../gpu/drm/amd/display/include/dal_types.h   |  1 +
 43 files changed, 469 insertions(+), 139 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej

--
2.25.1

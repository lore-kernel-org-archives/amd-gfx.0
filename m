Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 14:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7AC89A59;
	Mon, 22 Nov 2021 14:27:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D5689A59
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 14:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOADe7KJ7C+qBxNF5ao+Pe4OqOOmaatyr7nXXtt3zoLA4bs1UDH11SAS2kSibsFDdoaz7pS5Cub1wrfhUX11BVBYIouujh+R1llSlgb8jCgUOItSs/ssUt+3IBK6zY5J1YU0+d+V7/ed1d9RBlL5G78UnQEuDZhFC0fxoy7z3Pl+mYq64i51eMr6yQYj9t09hLouwCa1Sv6ANjUFps80mPjzQCzRK33gIitaGeYursbydyjDd9ITwY04z6VAHwghBybHPadys50q6glklHhQOMqz/0IuqGFNOHZTmwxmby60ec6Dbfu/C0vgonF2v4dqanN7D1AD9gJ7TPFzy1e3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ptQDNRmtCIQl+gfEa4os9RVxA0erDAvHhOo3WQPmYQ=;
 b=NfoJtMghfxrShslMLMwXavw3MG60qmXOo7EFBSb6aFpbsCLSUKBugps/yITO4VSwcFVjDjZIECIS+XgU2IYsoLAhhC5ZDMcVtpSlBRAFO2Lwn2hVICN6WGn2fcWSoaMYeMH+EEAeUB9GQjHIyEbCbHsRZmIlI2cv6T92ZS8DyIE4RxrXKQmUwsEchXSkYfDyj0rMce6FABySKui8u6YKXQFStd0Qn3eq51pmd8ED8LDY+SJ+8whSbf3Q6cgvil9l7LiCgnkzY1QcU51/H7zpcrtXnLaA6bQG8wKXiQ28U7EKAhzzL8QJOm9sYlOQf+tzWYLjShghvGtjkimjA3HpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ptQDNRmtCIQl+gfEa4os9RVxA0erDAvHhOo3WQPmYQ=;
 b=l8BHvNrC8NxwR8iWXIiDtgiyCgi7IO7JwHj2EFhFwyNUtOTEAgtc5dsSdSS5HCvd2djAkPsiyctQrVHjTWnnxJIynW8PIj2EeJ0Wx1ceJPXiiM1gEQid7X8E2M9FoS9fyKM7SkEFaYFbEzhzquHHvx18286lULpWyud3jQ7qD7s=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB2475.namprd12.prod.outlook.com (2603:10b6:3:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 14:27:31 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 14:27:31 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches November 22nd, 2021
Thread-Topic: [PATCH 00/16] DC Patches November 22nd, 2021
Thread-Index: AQHX3X3LgLWEmp9jlEGvnrkyPUbgjqwPnwTQ
Date: Mon, 22 Nov 2021 14:27:31 +0000
Message-ID: <DM6PR12MB3529AEAE5C7DCA488C59743A9C9F9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-22T14:27:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0df83a65-2c75-4b09-bcd6-d11ece5d1406;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 490e3bdb-609a-4899-7d41-08d9adc437f3
x-ms-traffictypediagnostic: DM5PR1201MB2475:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR1201MB2475EB7213AA41B3D1480DF29C9F9@DM5PR1201MB2475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0A5mmgzSVc8Pae9B0vg8gYGlufVx/UL+TxmuT4ZQxCq+yCZCJSaPnsz3KF4q/MJ9zwoXZ1snZOpkvvNdvUDl005Y0bMgzVKBgFZP26IIChTAqoCBMij/UAQ445yc+/BV6pe0fsK3Vk+VwLc5eRwyeoLKGw5gQbWIMyM3CHY/ZDTUQuZMQKEivNccoQl4O8zzbpPF+iXbBC8ZBUX+f6bJ4CE43XJ3h+Wb3uKuNjJBuIuzKNXYCKRbFbpr0HKn1ypR2fGXDIjiGk6wiE/MsV7JyMtXuQCIBV1/px4fNXV+zM8kVbukThLRyCVo0szdof07nusDpxDpjkMynYCATTD2nJH56lWJdThBwmL1Uny9i2kCsNk5Yk0IIjl2fsjCj9Dar/m3uG5mmrpUTSlJyTqNEAQjgl/WKx788qUnMWL0eu43htIIZjULCt62xg498+YEdqhlhjmYhFI/a+1kfIVEa2Wy3YSOb4c9rtDSzcAhjYTQf7fdtrnCwDhpfAsHLqx9nurBFUCbKncf6XDDH660iDfEuLmg9ZLzhLcrsVy+a+buLgeRXjkEdlPeOcusYjSv1TEiNMzf6Gjm9fDOg0CD34cy4KZCVC4go9IIG5luWRSgXscOCjJfUbgL7OBQfDN728JL0AkgfRk/tOGlHkrjkt3Yxqki+AaX5hv5k/MoMk7+gpDJikMJNhB1ijbsy+Ul1NZPYt8T+J2mUKdxMLDy0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(76116006)(38070700005)(8936002)(7696005)(316002)(52536014)(110136005)(5660300002)(508600001)(8676002)(55016002)(83380400001)(6506007)(54906003)(186003)(2906002)(71200400001)(86362001)(53546011)(26005)(4326008)(66476007)(64756008)(122000001)(66446008)(66556008)(9686003)(38100700002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0sQUgmpvX4GMfX7z2O1IHLWM/UeLTOSzVV7xHg0Bu5lgdHjXFy69QuMzYA?=
 =?iso-8859-1?Q?/Tj2jlKyiLcyi33rbVmY0cPivCGdKe64zoPBq8c765Re6SCIJzxWFI36jz?=
 =?iso-8859-1?Q?d6DHYMHS1E9hmOCRGRyLyXtI6lcUcgyy3Itbi6LoiSzcFIsV4aLZi9apCH?=
 =?iso-8859-1?Q?n5FmG2lSFdoyBe0ov5mGGNupPtaIyyJBfeQACRavjy7ubKTA7nRnKzGQhi?=
 =?iso-8859-1?Q?MPAjMJIcCt6+BUQJ3e0EFeyMD+4NChjeeT+BqFI4u4keYQkVOMVRURzc2J?=
 =?iso-8859-1?Q?+GEY49YV6KTf3SnIBCU7x11xkqJ17wYbFaWGn8kxww5ngmujq/ZGJZa2kg?=
 =?iso-8859-1?Q?HUrrnXlN9RXBCKw9h1Rgb16mpRAkSau3T00PII5e9FSLMJS8Mj9//36DWu?=
 =?iso-8859-1?Q?xlvx1rhqiuoHWEjAoq2RlhqxdJFTfaYhjWWkoLVUX2KRrqIuRf1fsZNx75?=
 =?iso-8859-1?Q?go5hCUiTtJnJT2PuCn3cZJ462zO0/5/zB6B8AyN+TJCNCriMQQ1urHxSR/?=
 =?iso-8859-1?Q?gSnMHnw6njvnjkAd5VrIumCk7Ttr1PHGQdlEWGa72TK7ggOZxuxdnobqBg?=
 =?iso-8859-1?Q?3BVh6P91265u3Ex0slU4cNNuzHGXnxa+9dfDqNR3cWDplFBfcWHTDaY0Ws?=
 =?iso-8859-1?Q?Vpm/oAhgRPXvG0OJ+5h7k0LW0/MVN369RgszoTx+fAL5NKsP3UyCwzY+5o?=
 =?iso-8859-1?Q?tzVtMJnCvwc4G0QrAQupcJBXjPegX6+PUoKgIzSu5ZQhB4PZzRmQRNxj1A?=
 =?iso-8859-1?Q?aDISydU83n6K/r8BNWQFae+GitwV+/0bb3v8GiZ10USzKQ/gZZvSL4fMVd?=
 =?iso-8859-1?Q?Rjl00a/ODDEHbQHwyy0U5OZdmvF4m61xHJzn/ys67Sl9erUdvnoucCSnkE?=
 =?iso-8859-1?Q?q1M5Q2Td6iDPsAqfW1tfcXr5JfJoVrQtIiLMXhd4kB0VCr/o9cI+Mt+h80?=
 =?iso-8859-1?Q?FjDvCKUHFIehMac7E7GWPplSKy/FfuSkcCADJjtfJA3h0bzqUgX+jYn3bw?=
 =?iso-8859-1?Q?Qui0wf+Nn/t1U3VpRKJ3/y/bEEPdQUbQWzsW2nMFAVIkRj9w2vrw2PEPOS?=
 =?iso-8859-1?Q?C4Pg4Aw718LRU7mX5+UI2kyzz97yBa82/5Z2h7gIB8CrCIgzB+9BEeB2QM?=
 =?iso-8859-1?Q?4NSZ72jZHuzb2YL+3kK/82wGn8fQvwo6y+OdLOTf8E0lo9kEvxiK1uSCHB?=
 =?iso-8859-1?Q?bd8eti/QR/BKygcGdzqjjY0Wb/7fyKZgx6z8r/LifG9o4InKD84Y7Rjm2m?=
 =?iso-8859-1?Q?INs7uKxYkbn2xjgsfycuDfb4+d9M9jD9AJYHCKwj+zwnLrsA+cA0Gzcqz1?=
 =?iso-8859-1?Q?ao/zcq+hWlqxlqc4jMa7xvP+Bl6MNUZ+UtmHt+46GI8rwvWXn4ch4/GyRf?=
 =?iso-8859-1?Q?yELpgBJ4J5BRYbri+qb/7PzGKLCu9BCIKvuyNe/3ZvJMC6NL2xJMJbbtxv?=
 =?iso-8859-1?Q?Dl9KTtugsiLfQyOKq5bXI8DWuqhtHxPWpOtltSOtBUxwwIlrA4e6EDou+2?=
 =?iso-8859-1?Q?8T7Ui1FfEU4g3wG0MD5IhIgnRJfi2vm2+YpECzF3bz+ijwqGqt6ofNvWPQ?=
 =?iso-8859-1?Q?o8QsLTXIukO8MCQHpxnIKqINhkD4As8EjG7KzZJ4rFF3nXxxt5dWvpqiyD?=
 =?iso-8859-1?Q?Tua77z3X32PaXy7FjQH8rfEUW9CQT4KMWnb1s/TlGQsRSah7NzcL4C4awv?=
 =?iso-8859-1?Q?UgEGNCBdf3CTLX83vNU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490e3bdb-609a-4899-7d41-08d9adc437f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 14:27:31.1246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /H3/0OVPjuTqgKdpbNNC1oi/DPN+MjH8OqVOPTnTzBSboQ432bJPu0vxxfryBYCrIj3z2nbXnqAnCV+06bLgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2475
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=A0
Tested on Ubuntu 20.04.3 with Kernel Version 5.13
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: November 19, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siq=
ueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Ja=
cob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.c=
om>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>=
; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agust=
in.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/16] DC Patches November 22nd, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- DC 3.2.163
- FW promotion to 0.0.94
- Enable seamless boot for DCN301
- Improvements in bandwidth validation
- Fixes in flags update, link encoder assignments, DSC, ODM combine and mor=
e

Thank you,
Lillian

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.94

Aric Cyr (1):
  drm/amd/display: 3.2.163

Charlene Liu (1):
  drm/amd/display: based on flag reset z10 function pointer

Guo, Bing (1):
  drm/amd/display: fixed an error related to 4:2:0/4:2:2 DSC

Martin Leung (1):
  drm/amd/display: add else to avoid double destroy clk_mgr

Mikita Lipski (1):
  drm/amd/display: fix accidental casting enum to bool

Nevenko Stupar (1):
  drm/amd/display: Display object info table changes

Nicholas Kazlauskas (4):
  drm/amd/display: Fix DPIA outbox timeout after GPU reset
  drm/amd/display: Run full global validation in dc_commit_state
  drm/amd/display: Set plane update flags for all planes in reset
  drm/amd/display: Reset link encoder assignments for GPU reset

Sung Joon Kim (1):
  drm/amd/display: retain/release at proper places in link_enc
    assignment

Yi-Ling Chen (1):
  drm/amd/display: Fixed DSC would not PG after removing DSC stream

Zhan Liu (2):
  drm/amd/display: enable seamless boot for DCN301
  drm/amd/display: Rename dcn_validate_bandwidth to
    dcn10_validate_bandwidth

sungwang (1):
  drm/amd/display: Fix ODM combine issue with fast boot

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 66 +++++++++++++------  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +  .../amd/display/amdgpu_=
dm/amdgpu_dm_helpers.c |  2 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  6 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  2 +-  .../gpu/drm/amd/dis=
play/dc/clk_mgr/clk_mgr.c  |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 +++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-  .../drm/amd/display=
/dc/core/dc_link_enc_cfg.c |  6 +-  .../gpu/drm/amd/display/dc/core/dc_reso=
urce.c |  1 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  6 +-  .../drm/amd/display=
/dc/dcn10/dcn10_resource.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  5 ++  .../drm/amd/display=
/dc/dml/dsc/rc_calc_fpu.c  | 31 ---------  .../drm/amd/display/dc/dml/dsc/r=
c_calc_fpu.h  |  4 --  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 28 -=
-------  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  1 -  .../gpu/drm/=
amd/display/dc/dsc/rc_calc_dpi.c  |  5 +-
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 11 +---
 24 files changed, 99 insertions(+), 113 deletions(-)

--
2.25.1

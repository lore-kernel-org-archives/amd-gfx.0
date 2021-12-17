Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5207EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA0D10E6A2;
	Fri, 17 Dec 2021 21:44:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3821E10E6A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLq70CWGFvmrob61UiEvH2tHmpu4UlZTlEL9qHNzYMou05dIpo6vMmqtZXjuyGCqVdy5Ew2L6q949CnCYbnwJHCzfd05zh/oxE3T6RZj+Q7aqQ+gwl2YA+1T9ipEba5L/fRTL2ZBw1aL2Wo4NBLS1bbUwQS7lE+C8v6EVR9mZ8X8Y9kEDtqZiwVPFfWut9GtwCm5DNq7HxhYoRw7Zl+pmUBTsy4eQZJQML9+z9OB19PhD0OqYUqPhlkKVlHE8uDKpqGRD+/E7cLP6OV9JkwE3SVl74bW+NOVjTeaS/3UFOj60XkrUF/ehdVxaAyr26SSqCksbK44OcSjsMG/8nis9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+86oYV7x0UJUmB1MVPhF2S9SwLx8ilAbXTl5JDyGFA=;
 b=nveSGBPabfyoe/F7uWgg65LAKTuKCXXdikP6h+XPuCWry9Z8dmA6k4ErNHvGgYNrOvjOQau1dc8D51XyLWCht0L9R+1g01AeVtwK0kdESmVDzwMkmt/c7vel+XCT3EyqIVcqwI7ff1Czxa9+AtJVadonOEDypPeIAZ669nzW/Aea36V8ySCqB08hYw/LFV3GunU34QKytBgfKfFFD6QM6YFV63lsRnBT3SEaurObzl2rOwUYm2UAbFLu4/xqXFNE9hlkRDPyg3mWby+NBLYFW5B+QifsoDOdq7LBMKUV8WoW4pOeKesTVZ5CwW0yX3osvpLcdHWet41+cL+drLBuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+86oYV7x0UJUmB1MVPhF2S9SwLx8ilAbXTl5JDyGFA=;
 b=zI7qC4TiLYLglSVIsek2VHLrYAKRmBFB3N/SaNKOYjaJh9RlLAP/YkUX+Q4BE6OxcVqg1Mh5ZS4a/9DbL4pnEqoXpfXGruFzZbpxRPodZE6BHLMljKuvXbP7hmgXEaJ8vGsjEdyoteWIsfSZfkgqFyalGW6OqRgCVDhzJDLTLik=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 21:44:13 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 21:44:13 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches December 17, 2021
Thread-Topic: [PATCH 00/19] DC Patches December 17, 2021
Thread-Index: AQHX84x4hkMDhcXKUkqyH6C8pw4c3Kw3N0Gg
Date: Fri, 17 Dec 2021 21:44:13 +0000
Message-ID: <DM6PR12MB3529C949D4A31D33CF8F79E69C789@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T21:44:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b0d1704f-281d-4b4d-9185-ca590e4480f4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T21:44:11Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7e674702-aa17-4f5e-b7f0-b509d16f958e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce112cea-1007-4036-593c-08d9c1a65dee
x-ms-traffictypediagnostic: DM6PR12MB3788:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3788EBC6DFBD07E6A39C78309C789@DM6PR12MB3788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WczTRv4yukoGBmj5H8J24sRIv5EXCPOLEu7NeV1Sl/xVcl3c9/MjnrC6dCx1C6/u88mnZdzTv0IBxJloH4roPrDr05fGz5LrULqf77y/hdqrsk7s5tCGtbGr4IUSXfUmrLuDUnls5eNT1BU1Mj5nb4blR1uJKIKudcsFlmu+bB2cJ9fb+aLBwZV6h+5uJTqJOWgk4IqmPaV07Na1f6kW5g+dMyVWIcv7lQU/gAvobrzzFgRrJtM3rUyPLIkDFkH63wHuM9YJ3coVMXiyLhkKM/huOnnuZHMDcDZVzEDum12aqsRuwUvp81GHMsw2mZZzIxCGPBUjxPk05WZ7K5hMylnfSQXd/3xRvFZNUZ2WLxRrulNclZVXBrtf9W3WeqI3vanTRMOCcyQiUbF21rrTBdr9ReFN4A9gysgJ0dwNwXdOn9VEjvcCyVrIAMeA2b8ELNkQxuIzaQkFCwWr3rbs9FL1vtqlmr8jJGm50jfqH85YYiVY8Zo7hGOnzs+8/qCdNKzojwZXCjHUhgpE7LnLy3ndJh6mSiqhftZnJjzp79rayYyZ0CgPMb1bWaDfQLzaKXW4mzdISVIulnu1VtTf5LPCU0vsklFc/5jR3JsDNgk6Jnrw6aFGylPl9JMiIu/pFYZ21rRVnu7kT+Gc9TqsQby4SM58M8JDEJq1viIzGqqPVhIRy/lA6y+hHCPhy4aoVwfJZ+wdCBXLMUqTU8Kd9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(71200400001)(52536014)(26005)(508600001)(5660300002)(66446008)(76116006)(8936002)(54906003)(33656002)(122000001)(4326008)(9686003)(6506007)(2906002)(55016003)(66476007)(38070700005)(53546011)(316002)(7696005)(110136005)(83380400001)(64756008)(66556008)(186003)(66946007)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n0BkoZFKO25Qb5t74jS93vF8yHK3u1cPFrK/WMKvuThBKOsPpFh7+VhU6JCA?=
 =?us-ascii?Q?o70GzEQTBIlfFPnnjeK5yMiWbjQQl9yptDl8TKmjS9s2+kllNz/ihmyH5yki?=
 =?us-ascii?Q?lD+GH12grevQ3qEhabfmM+lnoY+62toe6AxqQo5CV1IBvN4EKJ1wm9CPw0Hb?=
 =?us-ascii?Q?xYGuyJop1vHXq7uEPCofcfH5/x8Hvx3M4pFKLT0QckpTxK3Ak5xAlr7t8o16?=
 =?us-ascii?Q?X9tqb8mZBo9LJ7mPZVyEDEjvd+yXWVn9goCCbGzrPw41b9YVA1G4Ot63H1Ri?=
 =?us-ascii?Q?iel0jLE3DAtAuSbgo71RhhfR/7GS1Y+UcJ6vD3SIVha5hzWzQDC8tx7Jv9ru?=
 =?us-ascii?Q?X1iUJKKeuzIUOrx2hEsGWUx6n5R2qWwEIjStzFpYRjZbKRKY4eDDJziM86Y1?=
 =?us-ascii?Q?Q0VtP2hCUeGrnTIiEsOh04PdlMw2B7MYqbMdsnuAUXtg93t6hb1e9yYnkLjf?=
 =?us-ascii?Q?6u/ZPUgW73hHqDupgy8e8ft8sd1OIZ0INEIEe24dzrjwILbV924MqfBP28ah?=
 =?us-ascii?Q?jJW942Rq+Qh1B5nGoZDD70NTffONiukmEScHbUD5+el+yHCNJ5UQXuew2VWw?=
 =?us-ascii?Q?xZIPVJWF0OGiJNBKnPHHg026hyRS9gOyPA02CgswOWVZGek8YLQVzIa6e7XD?=
 =?us-ascii?Q?stWYbhYI3OEteREFjX62mn4nXpuVTEFZ0J4JkOvewzVifBrg7VK9d6reTM37?=
 =?us-ascii?Q?94FLpRrrebPj8rZ2qKGu+Ky/jMaKScTTgWi+EG6VYcZTXIBCkXRd2Q4KOZ/t?=
 =?us-ascii?Q?8OW3+4fGmm0HJ7MDpkn922XvLdL2zshDNKioTCLJJZEIt3sWLAutMXlR9Xv6?=
 =?us-ascii?Q?8Q2EIiZMzGOkFoj7Ak9mfO6vR3ruA9SlGw5En86M4wmiATwEfwbzeTbmpcJt?=
 =?us-ascii?Q?Nv/MdSLBMTpPcxoIWjFUlSjHpjBM6uxUW2b3Y0Jq+fjDp7WegZasvNarfKdl?=
 =?us-ascii?Q?FK7IgzdSdZoS6mJNO+l+Iz+oERoUmkcWP1va1uWQa76XrLYCTAWD541ste1v?=
 =?us-ascii?Q?1KE0KKY9AgXQWKTMFoebs0RORf25ox7l/vfOTQfSnoKQeSM745hhulg00Pt6?=
 =?us-ascii?Q?icUloZxfr/K2vgQYnMG1wceFigJNhb4CUKgQmeE+MQYZkWhdJ6GYvGTKOUV2?=
 =?us-ascii?Q?ZJ5EuliAqA6YNt0V8rmoVQMO4jBWEfuvWE3x0fBLCfcbZugqPjTjaPTBS/Mk?=
 =?us-ascii?Q?y8LzP/yR7mmCWQJW159I8YeecnEKhzksW01XK8psX77wZP95twpxe129Ki0G?=
 =?us-ascii?Q?uPANcy1ExPZDWpWbtrEejN58ENHN9xzENt146qKYufGyR6D14rUPeoPJ1/H0?=
 =?us-ascii?Q?YcDL9nmiFaA/T5ORWa6gSiJBKTgaapveyAuCy7QP5ifppyr0HJTe+CZ+fGI/?=
 =?us-ascii?Q?NJQQmSERBmwpZjK3O+SjYdPbVj2FbfEzGM6X9t0z71mf6tc61znnp4O0a8mh?=
 =?us-ascii?Q?B9x6Y4oefU1jBcsAgvKTDysBnwD5qS+liN///BN8V0NPoXYl+nxHKXmdV6DS?=
 =?us-ascii?Q?6sm9CMcAwgtKN640a8uhngiLWykoWeTvhnE6h4XUUUpD5c4ZHboWxl51YXAj?=
 =?us-ascii?Q?rhqmIzyOviMlzZAKVBdYdfjFN2IkgF0eSqovhjo3zSfyZ5nVffbgq5wL5rWR?=
 =?us-ascii?Q?xQ7IUN2/IR378+xCKOVdfRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce112cea-1007-4036-593c-08d9c1a65dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 21:44:13.2620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYcc/u8M4+nd/va9dx404dGs7K8io1+lX0m11CyMpXZcA73u7pkO/EqupShc/KQpxAbsH3NKkdFoEjfnfrGowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

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
Tested on Ubuntu 20.04.3 with Kernel Version 5.13=20
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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: December 17, 2021 4:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Lipski, Mikita <Mikita.=
Lipski@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.co=
m>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>; Gutierrez, Agustin <A=
gustin.Gutierrez@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches December 17, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Fixes and improvements in the LTTPR code
- Improve z-state
- Fix null pointer check
- Improve communication with s0i2
- Update multiple-display split policy
- Add missing registers

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (1):
  drm/amd/display: Fix check for null function ptr

Angus Wang (1):
  drm/amd/display: Changed pipe split policy to allow for multi-display
    pipe split

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.98

Aric Cyr (1):
  drm/amd/display: 3.2.167

Charlene Liu (1):
  drm/amd/display: fix B0 TMDS deepcolor no dislay issue

George Shen (2):
  drm/amd/display: Limit max link cap with LTTPR caps
  drm/amd/display: Remove CR AUX RD Interval limit for LTTPR

Lai, Derek (1):
  drm/amd/display: Added power down for DCN10

Martin Leung (1):
  drm/amd/display: Undo ODM combine

Nicholas Kazlauskas (3):
  drm/amd/display: Block z-states when stutter period exceeds criteria
  drm/amd/display: Send s0i2_rdy in stream_count =3D=3D 0 optimization
  drm/amd/display: Set optimize_pwr_state for DCN31

Shen, George (1):
  drm/amd/display: Refactor vendor specific link training sequence

Wenjing Liu (5):
  drm/amd/display: define link res and make it accessible to all link
    interfaces
  drm/amd/display: populate link res in both detection and validation
  drm/amd/display: access hpo dp link encoder only through link resource
  drm/amd/display: support dynamic HPO DP link encoder allocation
  drm/amd/display: get and restore link res map

Wesley Chalmers (1):
  drm/amd/display: Add reg defs for DCN303

 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 -
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 234 +++++---  .../gpu/drm/=
amd/display/dc/core/dc_link_dp.c  | 501 +++++++++++++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  48 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  63 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 199 ++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  15 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  13 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   |  20 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   6 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  27 +-  .../drm/amd/displa=
y/dc/dcn31/dcn31_resource.h |  31 ++
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  17 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  15 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |   5 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  10 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +-
 36 files changed, 964 insertions(+), 321 deletions(-)

--
2.25.1

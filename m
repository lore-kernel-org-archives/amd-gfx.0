Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF81C77B75
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 13:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BDF10E2A9;
	Mon,  8 May 2023 13:28:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5F010E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 13:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fANE1fDhtYliHRniv9ne5VrE95vK70I66kgEZpxP6jnF8lU/kk3AHjCI59p+pykgRJ/hQ02kF8YSOaZ5cZmFrYLTJsodQKgk3FQxDoMakdFSFTOmGwY1yOlP197YjRWg7/ecl1LFuSC3xah4jYpcl28mnY8aQXAjA3doAdyqG70Ygqel62HBnAIQEGNoOcsPZRxln4KWfVsYEAR1vVabgE4eote/p7eM9IELFhfCSFShGLAT5TDvkB1wQodP9yEQwvfEKkiWg2RYIV/v2bXHK27vzw21B4FpsKzBoUA4WuLM2GYFiGZ85CmbRoh4NiPmqqP7v1/WlridfzsoMuuf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUIYo5coVxf5htlrrLuu5hjvGkFbRUAFIdC9+hqDVrw=;
 b=IMi+oMVJsizLAiBmIhxXUogq8OU2eLH3id2OJxB3GKi6LrlRaMcFzr6IP3TTxGRWoW4358uy01Xo88rdD+NnjpgyIArLGjIUrUh6T6QfOde1Bis3eGdl7rIvpCoVNmRipT+McWbfm/iHYfQVzwFH2VQBM+i0lSLNwY/wThSHqg/SgCSLkhlievxWIRQrNhhFnlKPy5t/47nDO3SABlxHcl0V9IPlWDYRa1vFkuknurb/P+riPtYA2DE4pSsnpheecIT+dwirfziBvPly9Wq8csStTxT6dDZ5Pls5uhuZyOYuTPbGWsR6+buJ+6qJtpO+Jlv7TxiWBzHyHnyY4Tj92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUIYo5coVxf5htlrrLuu5hjvGkFbRUAFIdC9+hqDVrw=;
 b=APafMWgePVdyUrhlTLv2KaEZqbuEmBtvMwBftSwbkS7TtXcY94+lGNR2L8euGQazE+FN9ybRBKUS6ojTjpdcCaxL1FUXJdkIkns7OvBsnCSHGRWrhtMvEn/eRqokn/R9NbTnDms4MTJRLn5MioeV3swDvnSQVM1wCi2VPvTyYRg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 13:27:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::d28:1514:96a7:864e%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 13:27:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] DC Patches May 02, 2023
Thread-Topic: [PATCH 0/8] DC Patches May 02, 2023
Thread-Index: AQHZfWAdWH/BH77kwUeQJdQ52hGokK9QZp7g
Date: Mon, 8 May 2023 13:27:35 +0000
Message-ID: <DS0PR12MB6534EEB9E80277771909D16D9C719@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230503013853.2266793-1-alex.hung@amd.com>
In-Reply-To: <20230503013853.2266793-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-08T13:27:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d41547f5-486f-4871-9e5b-e6aafb6a8459;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-08T13:27:33Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3db55215-7ff2-43a8-b58f-2675e834e953
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB7224:EE_
x-ms-office365-filtering-correlation-id: d438fa9f-f965-4da6-b52b-08db4fc7fc56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35/28PzNvTV6FuUa1ePhsCLSvMPGg6Ojw6hOb2d5Ul60jbDV1evntWobam4PSEXZhGbgORlg9ZpByc38Tl/anREKGxI3+sZOWzaPfnSYxun3w69AgtXx3xh0DZC6xdp/0WEoAEXJXy3ViKsfFojrhvtYHjAORjpLM39p1XCRq/ZcGxaNRbC1AQ4W85Omc1ue9tor0VW7RsEn3/Z4/8XxDOGdpHWnsBmMJw0a+0P0dFX1glafcZay44t+ueivkb5YdYhdtp9+UZojX0HW6vSFPIKulkaSqY61/Zp4YClhhaFtoViFVAUJHtnIUd8K9fQ6dncU66RRCgGATvvfQyySlBBbF+4EyzMnUMs99fTdBbUVLhGVxjUEBwYoMBNFrRX2BPL2cfQt1OLIy82oy6UWykGxTV71MPD1Ba73EVvruD4zRJXDOWWhVwWAXoDoOJKFy2mJVRsIKAoOdraC8ipm8E2knHbYSV6IFgUu3ZsP+twmDmBP3vTiuQZ8/9/6iFKdMV08e7i8w9Mx+5CT/4xAHuwvOBv3/D206W8C+KsIygcIxiOYz/Gh+ozoL5v7NzaIgOrO6LLnqt7twapuJx4g4N1idBs6gLIO0YgsvQ6SaanzsM5kS1YSyHvR70v4TZD/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(2906002)(54906003)(8676002)(52536014)(8936002)(41300700001)(316002)(110136005)(6666004)(71200400001)(4326008)(5660300002)(66556008)(64756008)(66476007)(66446008)(66946007)(76116006)(478600001)(7696005)(6506007)(9686003)(26005)(53546011)(186003)(55016003)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ysFm4UUH9cXJHTX7enQdOrGB84iereF5GOskYPIy+cg77PtcjR+GuWTKlKyY?=
 =?us-ascii?Q?RkffwARosl2HUZV/DSSbKuCD7i4TGd+21xNFb1d8AZjoIg3JcvcEJUI4Ywnp?=
 =?us-ascii?Q?DDbCHsiQL9gxO9jzZpAvuhyeGB/GCmYMP0t/fO1kQ9+YrsZuSRnCn4ifiHPc?=
 =?us-ascii?Q?+MpQ996zowpAtgHe7pYF4ePa26L7wR4y3aS7yDDZBPwuckeXKQB2qp5K7FXH?=
 =?us-ascii?Q?jD0q3VWITbAw2gYw9aWp/COkCV9oNgxYpXQ7BetMtH+aXBGi/y4al6k4cpUg?=
 =?us-ascii?Q?YM/cuvZ7kOLlQlpZbPagVGcg+DTZZQfcPo8UBboHxjSdDkTcie8LiP3Lnh0o?=
 =?us-ascii?Q?sE/OLQjj9uo2ThqJTlCPAMZ7kHzRcT0GWfafzZVW1bXv1JG/vRhYwl6Z/s1F?=
 =?us-ascii?Q?kk0WOqipBuBdPEUGfO+od/4AILBsgVZDtPHQ8o3xMmotx1GLmF2faMNUBEZm?=
 =?us-ascii?Q?xNOzAKkS1HIi24G60VE4aLSzz+WNx45Awe2HisLqu1n5AolFlG2NkFz2v+eh?=
 =?us-ascii?Q?bdv/NpQOcMYRfSCjphSTOuwLmP7PPzUD1n0xRh0Kn53jWhjYMBvzJ0RDx80F?=
 =?us-ascii?Q?+QAF5XeRP/P+eIyEBbrHy9wPrvyVmgFEttdHJ4o5QzrSmbjrg3Q4rX+PkeIs?=
 =?us-ascii?Q?pPa8/wjDjtglkHeYDlvvPeBK1Zr3+Ig1qIFKtfAxstcZOlk3boTe6mBVaEh2?=
 =?us-ascii?Q?uFkFbrRoDjFxpdZbSjasJxpPaob0yTcPYTyt0NAjvWD3C1Pc1wqVGYEYEd3n?=
 =?us-ascii?Q?xj3TPtxQRXE7F9WIat7aojbGAeqJte7kcom97xIB1KPpSbPSm+Q0f+vc9g+b?=
 =?us-ascii?Q?vPR7JA25Z+eFCSG7WvtXrE+4HcxeYupW2Vv0/EwtRjkcQRruD/zB65zfdHPI?=
 =?us-ascii?Q?IJmcpyh77yMraSZdIPn/jQ5RbP0zBTgaiZHb6n6vKrgVDwwOG/fcDbS3hVPg?=
 =?us-ascii?Q?KZ1+uPI/yoEekN2EFqfOl5E4y3UhFBIYOa3YXgdwQ6wipLpR4QZ0zryQD6VY?=
 =?us-ascii?Q?taIidBT691lFujBkiWj1IXn+WGf9YRg9FQVX2YQLileRA0XfUWYwJ2HQ3P9P?=
 =?us-ascii?Q?ybGRuc9y1YRi3rvI2bZMewZ0ofR1n7PwfPQ3GiJgjhkf6mxFdZ7kC84fY/ka?=
 =?us-ascii?Q?L0CuP8bZheA3bsRUkEB1Ptu4z8x2aXrt4IKbUi0BtU7yYCxIx9WICIefXJx0?=
 =?us-ascii?Q?5CB9Ci25HJSmjxlArUqj+FT8qMIICoBY2sdSME/ilFFFU+ju2glAFuxIh8RL?=
 =?us-ascii?Q?kjqs8wCDVVgNcNBW117PmDBZKNUawSC82kQDJKl8hI9HOLSNZIAh4YrH40rO?=
 =?us-ascii?Q?FMKIVWkoScBegKSXT1+ImAiyhfY0i53uDyfgE2bKw/AgN9duzBOsNvvfp2Jv?=
 =?us-ascii?Q?zQD+PX8YgP8xPJGIYeLEsus+mnZCNTS0jS7h1gPCYh8wSrG3yjx/va5YPvBR?=
 =?us-ascii?Q?kzaNYaXOMtuXbHufKFO8cxcBmbXxqFMolncS0wisztXEnD+gVzYB7DfKKJk5?=
 =?us-ascii?Q?hhHrdFMbTtaxnl5dGkLWgJgiI38o7V2+7gBdOsc8gXPLaJzDUr+CmK7LLkon?=
 =?us-ascii?Q?rsYF5ZXVA1CLoay77/0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d438fa9f-f965-4da6-b52b-08db4fc7fc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 13:27:35.3467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEXFWF8Bnr2V5RcN9kpGdZNy2eKievh3Dqg1LZresKY9U+snmOGmmeYXEj8qHq1rR8efrAiIdF9vKAzZrAMhqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 6bb=
caa25b0c180dfb9c1a90155fc1cfe964f3e36 drm/amd/display: 3.2.234) with new pa=
tches added on top of it. This branch is used for both Ubuntu and Chrome OS=
 testing (ChromeOS on a bi-weekly basis).
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
From: Hung, Alex <Alex.Hung@amd.com>=20
Sent: May 2, 2023 9:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Hung, Alex <A=
lex.Hung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 0/8] DC Patches May 02, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Block SubVP on displays that have pixclk > 1800Mhz
* Block SubVP high refresh when VRR active fixed
* Enforce 60us prefetch for 200Mhz DCFCLK modes
* Check Vactive for VRR active for FPO + Vactive
* Add symclk workaround during disable link output
* Show the DCN/DCE version in the log
* Add additional pstate registers to HW state query

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Check Vactive for VRR active for FPO + Vactive
  drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes
  drm/amd/display: Block SubVP high refresh when VRR active fixed
  drm/amd/display: Block SubVP on displays that have pixclk > 1800Mhz

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.235

Leo Chen (1):
  drm/amd/display: Add symclk workaround during disable link output

Rodrigo Siqueira (1):
  drm/amd/display: Show the DCN/DCE version in the log

Sung Lee (1):
  drm/amd/display: Add additional pstate registers to HW state query

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 56 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |  6 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  6 ++  .../drm/amd/display=
/dc/dcn314/dcn314_hwseq.c  | 65 +++++++++++++++++++  .../drm/amd/display/dc=
/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  1 +  drivers/gpu/drm/amd/=
display/dc/dm_services.h  |  2 +  .../drm/amd/display/dc/dml/dcn32/dcn32_fp=
u.c  | 10 ++-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  5 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 17 files changed, 164 insertions(+), 8 deletions(-)

--
2.40.0

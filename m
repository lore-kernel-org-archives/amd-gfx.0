Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16322CDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 14:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7507E10E0AA;
	Mon, 23 Oct 2023 14:12:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDB810E0AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 14:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWN0ZlwLFxDUFPiMkh2MOijfy/Ph4dc+py3PraHme6GnH4BAgWkPe3hycvbBI2uCUMjOeSkyrCk/V8Csz3ZyzUdVk+egp55sowg1UlT5+t1RBU2EY8lbBlaI9ob6I+zDdKY4V+NLngel8huJlAbqePTJN526rEW0hhjwDqLbb2fu6fyggedykA1YNMHhAxYnKLpoobSKV6GvnoE1vJIKObgNm3XE4af9j0Vmip0ABGL4/ZodVqYusVAu99b8Ja3rBa9HhgfFXY5ByFp/RaQi43Hnv5e1HqwavnczpU3BZ1dwDVzBGIMBqydO1X7qpMpDZs6rfU+PH2QTkLn9DnIlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr29BlIJ80k4KvBNa5nTm+sQ1oMuEp/bCiGUnGUpEBY=;
 b=HUyODeTwO93z1cCty+dJQXxAM5e0UPw90RfSqQ3vcC8Ob/8CThDWOi85dH4+AnXo3kkIqkE2zcM7uzeUr5egO/jWoNtsbJ5PCVDjKURIM8uxbDE7QjeV+/ZgucqFZUranGtrEhw7I96v7dULBgCFnbWsGH6lt03Yh2HGn9AbzewUnJS9OqnE2jLgSldywYXKgQ8l4l4nlqfl8qEWEVLG5ocVxKEU9wcSsm9Zw7jAlQyvXfVbfWmRFIn3MkmgBfACvczH5Pqmo25gPxpmRpdAq1NckYwT0dSMtqvZ07kdQoB+V/BsZYMGw9egGpUKRucznrFrnrIVi5k9xUr8zyLScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr29BlIJ80k4KvBNa5nTm+sQ1oMuEp/bCiGUnGUpEBY=;
 b=yK3o/x/kfPMjvZdi3HI3j4I4erRRL7wWl7XPu+HlYN62ulhlCeEMI8sY/83Su4LxXtqHChfVZx1B4d3fFMDaLjJ9qMN2698qXiB4oP3BTWXnoFelvIS0To9XIqvsRxK4hJOJa8tV4BpbhGUapv+okxqcwdRjUYJiee3HzypTW1c=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Mon, 23 Oct 2023 14:12:35 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::def8:c635:30da:20ad]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::def8:c635:30da:20ad%2]) with mapi id 15.20.6863.046; Mon, 23 Oct 2023
 14:12:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 00/24] DC Patches October 18, 2023
Thread-Topic: [PATCH v2 00/24] DC Patches October 18, 2023
Thread-Index: AQHaApC6kNvi0rq3EkKo6OU6HvpPMbBXcEEA
Date: Mon, 23 Oct 2023 14:12:35 +0000
Message-ID: <DS0PR12MB65344C5F319CEB9259F207BE9CD8A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=72b45385-0847-4b39-9b7f-f684444fe10c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-23T14:11:37Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PR12MB7580:EE_
x-ms-office365-filtering-correlation-id: 99a4d167-2d90-4391-8330-08dbd3d21af9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQUoXVCXtZ8jk/m10UXBEEa77S6MlyWEsqXjRByBH/4PqcMdqkgw2kmXMNhAoMye13FfPdAvxxOQbzyvKSuIvH6zJmARv2j73JLf7lR8Hr58AjXYkW5UahGeWXuiVPYlFBNgXcers0hnsSL4HQtnrCgTS0jnO1RUAxA9NliqupcHzY2WzYFI+FimOVhLr0l1qnE0oRjchoVvsmCh/9U6jcu0WGJXoDeSXoZdqxJaUt7FlI58iSQHhRCFoJviNJS+s8JpzwisLjd97IRVzRRE0axvtxPQyOcbi0E30CFZbppUWJW2I5Y0D1BnPGBh4BdCRbp9A4oPYVxY2sPJVgDkKkeJ2ivOPz6clX6nqwAanUqzJ4CoQWnm0Pvu4AAsMEg494nnPztTHiJkhzbAdu0gS+uc+d7m+25UJi21As8PEi3+SFDuqVWjBXs47NjF9XELxSHC+pTH8FUF6I/CI1oYa/22AwrINj9GR5nZLvTDq1/86xSW6Z3KYUuLDDA8AkVkbo3ZJoS42DQSFKwXUaEcHyBEp3+SWIDlmXYDIOpd6UT4o5GBSo9G9MGYPBHtWjeG6Agy10fpkgFtYcFejB2n+UFFZHzkX1+eRyQDe75ez0iUDbBS2G0Y7ocMHUQNbskd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(26005)(53546011)(71200400001)(9686003)(7696005)(6506007)(86362001)(38070700009)(33656002)(122000001)(38100700002)(41300700001)(4326008)(8676002)(8936002)(52536014)(478600001)(5660300002)(2906002)(66556008)(66476007)(64756008)(66446008)(66946007)(54906003)(110136005)(76116006)(55016003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+dKWzmXLTVqUh/sBcAygvy4AnNbOO7QY3p362nVoY+T7yzDWEeK35nM3jiYB?=
 =?us-ascii?Q?FxszqH0ffRXxcNkVZ4flpRUU4PxBMMdUMdzJjTVhoVla9IGjQkOG5pj6jrP8?=
 =?us-ascii?Q?q3IWsB3yrw3w0vFhWAjOGPkJPP2wZ5xY4SaeZSfVBmrmNTwgdreR35dVG/Ec?=
 =?us-ascii?Q?zAe4i8yPMn9DBDaqXhqFH9i40UAMCFYPQZJxd0Mbc7yf5tS8C5N9ZXICZTcd?=
 =?us-ascii?Q?7hBWX/INa9nMReaVN1Y+l98rbYd+pqIigy54MKp7RHcfwaEKqBg+q/qDcg93?=
 =?us-ascii?Q?g5wGuUBgS8SaHWdjwndERHRPsmBp7W5AppI/6Ntos4bPswOKg3KPXDjQl0cj?=
 =?us-ascii?Q?H/e8xm3BVxt2BzcyfByZAlEDe55ifuqHf8V7Ur1qcd1f5zlFzoO5ID156Tk9?=
 =?us-ascii?Q?rWmEqnMZleVksPbr/a54DsWbiInM71ApAzD0jIAtrPqSRmsVnHtVexxnWoQO?=
 =?us-ascii?Q?LruliNMRQxe6o+IkaW5pZjpNnnRSzLWBONtDK04J9zBVeo2OP5VkRvoAHoez?=
 =?us-ascii?Q?qBdr4+2HDW0DOsU12P4lABmzDsNSRJ+T23SiiSFuV85Aex8mVctX5QaNK4fH?=
 =?us-ascii?Q?XDZlmIl4OCv0IDdZDRNoBGoYISlTFbx+PdjI4ibtPK4yNhCLlYNOispAf6G5?=
 =?us-ascii?Q?67Hb9/6lZwn5bJy1wnErFIuya7//bYgGZLxF9JOAa2AaKvnEKLA5XvOJQ7qM?=
 =?us-ascii?Q?w5ksk2QYzsjRH/wCgzrDio2yCRK7rvZB7tPBJVZ8xtTDgn1ed6R70FrUVuu+?=
 =?us-ascii?Q?DI4qw4S7+Syjc3sbEss1iH8MTq1MlH/wyQ4gZkT55hs4S4g5SLl4NkwgEtWU?=
 =?us-ascii?Q?azLw2UAiW7q6e20J5f6hmhFo50XYzGiwFlqIw/evA0FInE+6i2rLpPEmZlSq?=
 =?us-ascii?Q?Iv6M2u/UM89i3ZD/h0InqajjKAqHPBjhVybDlkEaGnT0fVAOeISA6YUSVpTr?=
 =?us-ascii?Q?Gm9permahwm5Lp1+04VPzWJsdEFaUGls1irNNfJOLGaaCs0PfthTvgahE+/W?=
 =?us-ascii?Q?6TO8El4tvrwQlyHneIgtMrCtvtPvL02NRkFVS9KU11D/Req2boyBD3feNYXQ?=
 =?us-ascii?Q?MtNQSNl1w16tBkyD+iIputjR2+9fXbScbHeCPOl8FHmcO3pw9QIaONAGx2We?=
 =?us-ascii?Q?HkGr8TrUBPzu97LSiU4BVaTUUmHRjsJdu14jgWwYfRB+j16J5mf1hXkjc5ne?=
 =?us-ascii?Q?kxl+GdxVNdqJPkPzSG6IeKnSEy4dPrPItfkySPkpJxgWEw1Lot3aCIVjdvgu?=
 =?us-ascii?Q?eQBNgfqlNS3E7NGfopy1OsB3JUZ9hkjYA82Ty83fna1TzoBkZY/X50sUnMg5?=
 =?us-ascii?Q?K+D5WwXULd10kCxSau42KGkdR1WEfGzgYpP1vetmrmX/om9OWBU73iK4aZKO?=
 =?us-ascii?Q?GcK4ZxJMwsAG7XOAdhnrMYTkFfu4OqqieXrwTve+HdV7GWi+b87ECwJqaX3h?=
 =?us-ascii?Q?+6iT1d85TO2c1q96Jf2FKjQVR+G1zMmQ9rDZMvSuQj0+VGF1iWaxYJJuNU0k?=
 =?us-ascii?Q?ySaXJeYnx9gDRPk+/vxKpmzujddQqRvxv//OoYX07kvc4T/Znyqkh4o6HwZB?=
 =?us-ascii?Q?fvdEbEarFK8DnI56KVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a4d167-2d90-4391-8330-08dbd3d21af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 14:12:35.1807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6Zb0X89hSxnsHtgmkuEGF3hmNbLuGGVJtmxDOU+5MX7qk4DgJ45HwsE9NvOj02EB5moC5Im2YG/0rdDRWSPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 310=
b5f1a3c9eb1ed96e437ead40f900f3b7bf530 -> drm/amd/display: Revert "drm/amd/d=
isplay: Use drm_connector in create_validate_stream_for_sink") with new pat=
ches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Thursday, October 19, 2023 9:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Kotarac, Pav=
le <Pavle.Kotarac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>;=
 Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@=
amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Li, Roman <Roman.Li@amd.com>; Whe=
eler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH v2 00/24] DC Patches October 18, 2023

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fixes null-deref regression after
  "drm/amd/display: Update OPP counter from new interface"
* Fixes display flashing when VSR and HDR enabled on dcn32
* Fixes dcn3x intermittent hangs due to FPO
* Fixes MST Multi-Stream light up on dcn35
* Fixes green screen on DCN31x when DVI and HDMI monitors attached
* Adds DML2 improvements
* Adds idle power optimization improvements
* Accommodates panels with lower nit backlight
* Updates SDP VSC colorimetry from DP test automation request
* Reverts "drm/amd/display: allow edp updates for virtual signal"

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Agustin Gutierrez (1):
  drm/amd/display: Remove power sequencing check

Alex Hung (2):
  drm/amd/display: Revert "drm/amd/display: allow edp updates for
    virtual signal"
  drm/amd/display: Set emulated sink type to HDMI accordingly.

Alvin Lee (1):
  drm/amd/display: Update FAMS sequence for DCN30 & DCN32

Aric Cyr (1):
  drm/amd/display: 3.2.256

Aurabindo Pillai (1):
  drm/amd/display: add interface to query SubVP status

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Multi-Stream Not Lighting Up on dcn35

George Shen (1):
  drm/amd/display: Update SDP VSC colorimetry from DP test automation
    request

Hugo Hu (1):
  drm/amd/display: reprogram det size while seamless boot

Ilya Bakoulin (1):
  drm/amd/display: Fix shaper using bad LUT params

Iswara Nagulendran (1):
  drm/amd/display: Read before writing Backlight Mode Set Register

Michael Strauss (1):
  drm/amd/display: Disable SYMCLK32_SE RCO on DCN314

Nicholas Kazlauskas (2):
  drm/amd/display: Revert "Improve x86 and dmub ips handshake"
  drm/amd/display: Fix IPS handshake for idle optimizations

Rodrigo Siqueira (3):
  drm/amd/display: Correct enum typo
  drm/amd/display: Add prefix to amdgpu crtc functions
  drm/amd/display: Add prefix for plane functions

Samson Tam (2):
  drm/amd/display: fix num_ways overflow error
  drm/amd/display: add null check for invalid opps

Sung Joon Kim (2):
  drm/amd/display: Add a check for idle power optimization
  drm/amd/display: Fix HDMI framepack 3D test issue

Swapnil Patel (1):
  drm/amd/display: Reduce default backlight min from 5 nits to 1 nits

Wenjing Liu (2):
  drm/amd/display: add pipe resource management callbacks to DML2
  drm/amd/display: implement map dc pipe with callback in DML2

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  48 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 542 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  26 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  26 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  23 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   9 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   8 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |   5 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 146 +++++
 .../display/dc/dml2/dml2_translation_helper.c |   2 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  16 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   6 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  11 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  39 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   6 +-
 .../display/dc/link/accessories/link_dp_cts.c |   6 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../drm/amd/display/include/signal_types.h    |   1 -
 31 files changed, 646 insertions(+), 343 deletions(-)

--
2.34.1


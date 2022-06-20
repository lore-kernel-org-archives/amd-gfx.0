Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 13:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFD110EF2F;
	Mon, 20 Jun 2022 13:30:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F39810EF2F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 13:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEbAbzeD44uFggP3xD0hRbLIc6LcQ/4hs9VnnGLudEHzppibz2R4llqX+4hEqv0912b8fDW3ZUIL+zW8VVhkpqOmNi/jVdqRdZUWYe0hO6w3g0eK9gk/aMwqcTRxzYsarGu7+O2tAHhcwBtCGqVKtxAqnMAwYxPjulkeP5ErPvMCyqvp5xIcmM4rEvg3YAesvAoYbJRELEXd2vEpNKqChd5juKRpVExE9WknOZ5RxHl04Klaeq72Uae+YU9kF1wvr3EQFTtTxqspX0Y6g1bwT7Y78nRd3x5g8n+tvlwK6d4LJ3ThPWw+/hDmd/M3uVihrzRCCCj4gWojhZjSJ45AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWvP9ysxDFswLummV3rNzeiMITF4001WdikYKf/M+Lg=;
 b=aQlC236TUsDuWhQSWqdgfcHZpu0wAMyoaEJR5dEpH5mzMtFwt5ofbyz/oMznIz2hWi0/QfpGvi9f8kTkmaZ916v+H3wQ9oVLmv7jHK0jBu1FwMZb7bErHX+u5DuFMupTlWF0BXpaBJaiDr6z9Hp69MecoeBw2SqUvVL9vJkk5AfQyiaOuf524vBuPCuoxx9lZpAw9ezNEUTNV8C723GBrKxqjjO03BQf+unR/GJ9brxkZfJPX1cfxWGYoOMqKEl7s4NRXzF05omnJ+3uBI2jOoJoNtZb1DwuxzMWYh7FK9KHEGb6w+UnFZ2zCNGidwWzG7KsWn5+ZB+awaUc7B3l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWvP9ysxDFswLummV3rNzeiMITF4001WdikYKf/M+Lg=;
 b=pGlYe/dKe5S6fg6EhXE/2HCea0ylzHsrpObkS+KjRxG8nMmL7CEC6FzXeacv8FN47UTNyPiKp8XUYsOGa29vF0phiRp4QFoZn0qAue8W7uM6Pb0wIp1uQHiFyf/85C1x8ugihlEMusiVkl+1xA6Y48THTCVN6hTU+pyxXat+CR4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BN6PR12MB1538.namprd12.prod.outlook.com (2603:10b6:405:4::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 13:30:24 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::c989:c063:cdb3:1d4d]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::c989:c063:cdb3:1d4d%9]) with mapi id 15.20.5353.020; Mon, 20 Jun 2022
 13:30:23 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/31] DC Patches June 17, 2022
Thread-Topic: [PATCH 00/31] DC Patches June 17, 2022
Thread-Index: AQHYgoFwxeI9GtmyW0q70/NB25lGCa1YTqbQ
Date: Mon, 20 Jun 2022 13:30:23 +0000
Message-ID: <DS0PR12MB653497960D2993AC3B78BA059CB09@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-20T13:30:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=115489d5-06b3-4b5d-8852-355f2b0fe6ff;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-20T13:30:21Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1092b2ad-0c48-461d-a7be-7be0cab9ff8f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6720742-c63f-4c77-0987-08da52c10774
x-ms-traffictypediagnostic: BN6PR12MB1538:EE_
x-microsoft-antispam-prvs: <BN6PR12MB15383848A6F0AFD5ABFA8B7B9CB09@BN6PR12MB1538.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaMK6m/20044xkuIGc+wmHvA/GkVI0s9Gc45wcF1JrC2ohBUn4V1iImz1Y+mwmblJHQ1Nm7qZH4mnGYaTsmHKbehx+jhD3IZtE7FRCu+V8gZYjH5zTtWEpUYABmr5yxx+Gl3HnhnjwVuIlHtKbpKXXSzj7hxxlRsloKRh42J3bayv650B5rLCu0DQK8VHkIB7STh7GQSLdd/6F/C+W90EWQBt0ZJIFqJejMqlkjBUlLAlaTSU2WBPTW4puwUnHZ/Bkjpk2mlHEsYDZ9kELjiZuFBKcyHpQTIVz3Udb8W2LGmEPZ3amm6viXCOGCeKB2qwQ8La/O+rjSo9tPbMjpILuGd2tNhEJu+bn2pgehrtrHkYbtt4PeWuLjKiXrcPPKUEiLyqy4zvNDzTCgNshfO1XwlBrQS7+o6U2C4HFCpdIRoaRfqwFQwWGVLI/jNaqU4YUJ7nVqJ/qnRHcj7xLK4LBkGa4WyHqUiBpMdIOok2zBlXgJPt8YmUTnZvdiqF7+7TAYptHePA2ChYpnT18rCwQXNULXXZX/0GP7wh89+z91svp5XXesjoiK6jm/xyExd8cYhmFq99uDj+0PEnULArpkk0OqROq6tz9qHZEv9NW5Er+W5nlQo0MaxSrHZPQTJnxpPr7mB0nGxsarMRUaZsvnWGedqpq7XLlIc7eWB5CNiFw2f3RR4XmKwbTfkJpNhFQxJlMZVkYuMO8Wn6Wrqag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(83380400001)(66556008)(66946007)(66476007)(8676002)(4326008)(76116006)(66446008)(55016003)(186003)(110136005)(8936002)(38070700005)(54906003)(478600001)(64756008)(52536014)(71200400001)(38100700002)(316002)(41300700001)(6506007)(33656002)(5660300002)(26005)(122000001)(9686003)(86362001)(7696005)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCexUrp7eruSc3CPZC2o4JhBjl9XVrbh22m/+CfgP8zPu6kr3v8LdC00NLVD?=
 =?us-ascii?Q?t9znVvCO133RmdAkz6ms1naqu58M2N78TV5+eQuwp7H3mR6ScxA21UAz3uXg?=
 =?us-ascii?Q?eRwP4wAwk/NmA+mHFZCmyrHyHphy9cB113y4nXuLYaV/mpKhf/1HBhu9p/Ct?=
 =?us-ascii?Q?BSEicRIxS6zNJG9kckcm+jcGwMmsqDBoR4XUpYNQBHYd4CxYmHnIUSha8Wf2?=
 =?us-ascii?Q?NmI0rxUBuMrQ2rhgnaqYtt+vZ2I38uVHbHY32sj9qAW8aE11L34FSjZANsqd?=
 =?us-ascii?Q?0I/pUc6NV9Z7PBLQ72P4mIvMizEyruGoW4VjqOce2dXfUZ3+TOWikhFAC6ey?=
 =?us-ascii?Q?dW6IdWgJwU6LaNahb2XvI2I/dXlzPqXYB5Ai+4hduIZ00yRQ3CV+2vh62LEP?=
 =?us-ascii?Q?p/84vbE0Fumu1HIJfbLkgNHNbvVgSD5esvnaNdFL6YGVUpXr5AIptZTAqERk?=
 =?us-ascii?Q?a60g9kBRixaCzQgPuanDp0NpTtQojamXhizUsHXW4K7V42iZ2o1CDyBiI1yP?=
 =?us-ascii?Q?XGhiJoS15TMo7f5zZi5HLS0/CSEviZQu/w1p0iPXySPc9ZzjSkGdBomLWxUz?=
 =?us-ascii?Q?OgdsPPsfoNoAyyGC8t9pMH+sL/6ligXM+D6Yq7blkSKoE2RSO8Y/5CDM7eQ6?=
 =?us-ascii?Q?/od82kwtkvkxCziwMg9PY+2mxIdpOG5Lxd8II78dgv6uJAAeX0ZRHnFT20xf?=
 =?us-ascii?Q?nAWCpQ5PlB7W0wrXvhYTRBGeoPOtre/AFTZdFHzd1GNnigevip/kbJEi8FQc?=
 =?us-ascii?Q?4C7AouVmFE7SZgZHf0FuYlrJgSo47JGWm/avhMQROK/+DlRj9vHW9IVN9vwm?=
 =?us-ascii?Q?EjZQJwCwIqW4AFXinhjUqhO4Qf8ya0jEs90LVMk9yTYSIGbDIg1Maal79sca?=
 =?us-ascii?Q?pgQqFPkCy4JTXQf+RPz8KeNXDAbU2UAE7Co0SZ+U33/08kXFP6kWk57VnEPx?=
 =?us-ascii?Q?1++ZBmRXPv47cGqzclalyCW1pXG0SI6Zn2m1TyHuI5OPl3sKeMfKG2Plo+Xd?=
 =?us-ascii?Q?Q71sr+VxjUouMLzexamnvOqXm+QO8sCbloMSJV8F+jEPIx25EKu21gifKzYO?=
 =?us-ascii?Q?8lg5XcAox6Nf45V59Al7WN1EqnpQzEp+yIsWtFmJgV/QyFkCcG47Wt44IBK8?=
 =?us-ascii?Q?P29VPln+w/Jk3YbsH47ac8N0SpSZdHaLONlmIpCLmYBpJRNtI68ei9WfqwfV?=
 =?us-ascii?Q?ytmY2yTBzh1QMZrWgRHBK/Yj+5cROt60ApMOicyydpd2djNmCacYgocr7Qzl?=
 =?us-ascii?Q?ZrBS6fMny4puGB/Fb+Hf15Wxk2P0g3kzqDX2DbD3hmqYatkioEQUSNZNzZFB?=
 =?us-ascii?Q?6ITlcufCldcH11cH9otn+SaKobXZz7zBr+VcV3pvGZhfBPJujEhBoT+C9K+q?=
 =?us-ascii?Q?7Xow7vDPpZtJiBH+3YOg8RnTlQeHRzguuLBzoCLE6AGkPf6OwBWg8Zn8O0+k?=
 =?us-ascii?Q?/H8PgRBGfMQ12IWPdGcFrxk/5M67hGg2ZWLd/k3RQ4KJp/NKShL/r044y/9u?=
 =?us-ascii?Q?c8GA6cJ167crwSdYOQYXcrZkcH6DsoxpWXZUa3b335cJ7X5LNfUxeyt5s0RI?=
 =?us-ascii?Q?z5GHlPC73DklAYhf+NthNsLOjEi8XbIUI6vIV6KHTA0Askyw9fK4DiyD8Pfk?=
 =?us-ascii?Q?jI6g3HiL457tvwsl5+RiZoYdge4l64VK4Xoqa0elFrPonBc19jSHt3JACjwG?=
 =?us-ascii?Q?9puI703NLBS7MZnj/KhPazCK9odVZN6vxoBjJMXkKHbMqM9M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6720742-c63f-4c77-0987-08da52c10774
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 13:30:23.3245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CSrDyAoofBgUKR4cI1b9XxI4mcg3Fc4cYp7RCWtyxHs/UXBEtIgACs64o6fjHjO9vd7uCpIaULdX5jtbjxcjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1538
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
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
The patchset consists of the amd-staging-drm-next branch (Head commit - daa=
21bfa14f16caef5b7d8f8938a1334c620aaf1) with new patches added on top of it.=
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
Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rodrigo =
Siqueira
Sent: June 17, 2022 3:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;=
 Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; La=
kha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.G=
utierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/31] DC Patches June 17, 2022

This DC patchset brings improvements in multiple areas. In summary, we
have:

- Remove unnecessary code;
- Small fixes (compilation warnings, typos, etc);
- Improvements in the DPMS code;
- Fix eDP issues;
- Improvements in the MST code.

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Update DPPCLK programming sequence
  drm/amd/display: Update SW state correctly for FCLK

Aric Cyr (2):
  drm/amd/display: Change initializer to single brace
  drm/amd/display: 3.2.191

Chaitanya Dhere (1):
  drm/amd/display: Implement a pme workaround function

Cruise Hung (1):
  drm/amd/display: Remove compiler warning

Dmytro Laktyushkin (1):
  drm/amd/display: Fix in dp link-training when updating payload
    allocation table

George Shen (5):
  drm/amd/display: Fix in overriding DP drive settings
  drm/amd/display: Fix typo in override_lane_settings
  drm/amd/display: Handle downstream LTTPR with fixed VS sequence
  drm/amd/display: Remove unused vendor specific w/a
  drm/amd/display: Fix divide-by-zero in DPPCLK and DISPCLK calculation

Ian Chen (1):
  drm/amd/display: Drop unnecessary detect link code

JinZe.Xu (1):
  drm/amd/display: Change HDMI judgement condition.

Nicholas Choi (1):
  drm/amd/display: refactor function transmitter_to_phy_id

Qingqing Zhuo (1):
  drm/amd/display: Fix DC warning at driver load

Rodrigo Siqueira (4):
  drm/amd/display: Check minimum disp_clk and dpp_clk debug option
  drm/amd/display: Get VCO frequency from registers
  drm/amd/display: Update hook dcn32_funcs
  drm/amd/display: Drop duplicate define

Saaem Rizvi (1):
  drm/amd/display: Add SMU logging code

Sung Joon Kim (2):
  drm/amd/display: Fix eDP not light up on resume
  drm/amd/display: Turn off internal backlight when plugging external
    monitor

Wayne Lin (4):
  drm/amd/display: Revert "drm/amd/display: Add flag to detect dpms
    force off during HPD"
  drm/amd/display: Revert "drm/amd/display: turn DPMS off on connector
    unplug"
  drm/amd/display: Release remote dc_sink under mst scenario
  drm/amd/display: Take emulated dc_sink into account for HDCP

Wenjing Liu (3):
  drm/amd/display: Enrich the log in MST payload update
  drm/amd/display: rename lane_settings to hw_lane_settings
  drm/amd/display: extract update stream allocation to link_hwss

hersen wu (1):
  drm/amd/display: add mst port output bw check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  57 +----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  70 +++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  12 +
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  12 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   8 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   8 +
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   8 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 151 +++++++++++-  .../dc/c=
lk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |  10 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  43 ++--  .../gpu/drm/amd/=
display/dc/core/dc_link_dp.c  | 222 ++++++------------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  38 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   6 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |   2 +-
 .../amd/display/include/link_service_types.h  |   1 -
 27 files changed, 421 insertions(+), 290 deletions(-)

--
2.25.1

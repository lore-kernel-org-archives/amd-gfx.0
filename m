Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B434C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61AA110E27D;
	Mon, 24 Jan 2022 14:06:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903AC10E27D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 14:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZpXBMRnENIs6MuvpQb74SzfkDipQVJJQ4mSnQoZreFSIry7yZGk2Bc82KzWwxhShPTtHF4aSyCETVSmr6RkeDM50Axihi0hyhxHrLgiTC8w78bGhj3U+qWKVS4gL/FYqQrNYxFLzHupgICxLDTb6msDsmGIwCyjiZvHMZZQ5f9Xi0RrezP76rqYgrwznAbcCfKwEJIi+8LMjexyDNcsT1m7aTT3TfGqUMFmZYCaNfqqlX5mAhvpJeal9+I/FR+DZ8eV6q5xJalgfPjNGVfDrLDISN2NkFSWFQ8bDKet4V+x1o+NlXwuoPXrQJ9yG5LQWFn3xeWL5sgKg2HHXFMncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbFJZyyuL2v4Z7zymLUmFItow577TrzSKwCUpTL6Yno=;
 b=CudO79UlJMOX/PWHDEP9U4uF3Oguf/UvtFovFwiR63hCNiuaFfm9G2YXbxeOG7hSsyr5pjD1QfGp0NBBlrayMUPkDnaxu7rayGoKkIWrF21dTJcfhChJmDQR0XTk6QiS8Y7EZJCjoDQSjsJs8xApzWkxJDW2JyizD2fD6SLRzrbEgAIvkmCGdEb47tsYWm7DC8xzVRhVGvzKlUMns/7O3yjbz723LbYo+v4Du4xjZwESYra7fax546pcdVlDfjgMikwuAVWU942gbdkGEEzkz7SvKfrb9HNpaICUGZTidNIjomfros0vviKrObwZz+RZvHGAsh3A+IbWABrPl7zXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbFJZyyuL2v4Z7zymLUmFItow577TrzSKwCUpTL6Yno=;
 b=JkAQuaP4SGbPET3QoggZP+BnL4zTrHk2TKm+ghSEymaTMTRh1sTQt6PSow39XRXk+3pdlz7i/wWH/1npX2yZiGugmcoagQYKh4nrfGO0Bapv7iE28NL+nn5WMHKnYZkPtS543tU6VMnBHjtgkbFTw6LwkIX8XHsT13HofvzynzI=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 14:06:31 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 14:06:31 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/24] DC Patches Jan 23, 2022
Thread-Topic: [PATCH 00/24] DC Patches Jan 23, 2022
Thread-Index: AQHYEIX6EqKKaP4FxEavFa9clSxIUqxyNgCA
Date: Mon, 24 Jan 2022 14:06:31 +0000
Message-ID: <DM6PR12MB35290BD0B71A8998EFFA1AD89C5E9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T14:06:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5e8bfc9e-87f6-4b30-a17d-3fe3d6f1f546;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-24T14:06:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0388f887-7534-4241-9a5f-8c8a07f78093
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e3d6d6-fa1b-41a1-1c46-08d9df42b922
x-ms-traffictypediagnostic: DM6PR12MB2636:EE_
x-microsoft-antispam-prvs: <DM6PR12MB263676196D4F44E86D2D467A9C5E9@DM6PR12MB2636.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhjOwBurBqBLxTOmhh39g8YBUXoYz+/2J0agR3CbIwJoWDTi5Dmusg2JuuhmWhSDCkOjYVsmn2sg3MFaWjI/vs0QYz2hhGRIXZ8QqElVhlXxGEs+Jth6+r5oXUYSQMznvQXVBb6FGQ8bazoSPdnjZ0KOQYo3M5zTwLKe+hHBRHlOXsmS7PpSc2EHiCvkQkmVGnZNGA9cu53LaeRKr51t2aLbzXymSuV36TfaZO+u5U8hX0khbjhQFEzq3bOCL/0GWkxrljDXjcLx2wnZ8hczZQ3CrfrwW6R9yOptpD59ar+MX3+jbFeIi+wb3TPasjX4vbEwCYM+Brs9cpRuYW2vUTQK/DrhoYFADALPyKNAA1J9E9Pr9lIWNHT0edCdSXNOCKVxxRpQ8z9lsZ3L24np9ob+vd7Dgl23k0LYRWPTbEzx8xKjHxQ8hNV44pQ9jFTnvebYyxkas6erFki66xWnmgIZvyun6u7/N22lDJVMrlonLgiVj9cxwMWvUyPu1my/Ksyssq2T6apUwESofsZjtGLi3Oa95M2PComVZtzV/L09f8js8f8Nevp/eWIWI2V1CX7Kj3A4COqUZ1XfmXaxbXVxTK8IFQtkFc5URSHANfVLFFvSGl5pirrMo+fAjIZ+MFlelQowwk8wSxNNn328E2ZobDcxAHqAJAECrpO6a4Fipn170oAmEzHfBXX4TbMa3gBLBvWzxHAlVpXtdOo2wA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(83380400001)(2906002)(38070700005)(5660300002)(7696005)(8676002)(508600001)(122000001)(71200400001)(110136005)(316002)(54906003)(8936002)(38100700002)(33656002)(55016003)(4326008)(66946007)(9686003)(52536014)(76116006)(186003)(86362001)(53546011)(64756008)(66556008)(26005)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HNz4sklKTapXIrXqCpaWG1nkA0ZwOc3J1Ae4B/OpJy7aLYV3WQSGPe/Z7Swj?=
 =?us-ascii?Q?/NTis0relgcmM9gu3du1pxEV8qILEYeTRTGmPFoHhGBsJZDX+gjvlSFGunuL?=
 =?us-ascii?Q?cJkqlO+9+AhmvW2w3MgzSRcT49sy+5He6vWIz9Lzz6v57AfCvTQBkZiz7TmN?=
 =?us-ascii?Q?M73pea+3kGrnF0Qiea6dD+fKPftOjBNMegI7pt1ZduStqL+Q8vpYHj2mPNuE?=
 =?us-ascii?Q?xahDt3ecrlwNeILr6f0vJaW7stNSjHEr7WSU08Q6GWmwZfdKM3ZH1yCA8raI?=
 =?us-ascii?Q?sWXaP/QfURWTao/S/oCQl/Eo5XmCrGQPjXrrjlWLvy9A4YmZ+wo0Y+p8WE3l?=
 =?us-ascii?Q?VrHuVNmktWqwea2sBWRzgywlCrgxmX5Lka0PGteGxKSVQAIO9RoS/j22YWzx?=
 =?us-ascii?Q?k8gIvxJKOyrsGuQk0anfl8mBrAlziH3diKqcDXSZ+sh2PbMxIrIxt8pb1XiJ?=
 =?us-ascii?Q?/gtn8jme/Yd0PeZz/BxB3NFyMHG1xGRchK95xo7DftaCmx/UUWb0Oy8K9+p9?=
 =?us-ascii?Q?hHHu1md6VpYY/Myygfxrhb0pBPsM9VWW/i51A8iQXFwL4oQR8o+AM4/4c/iV?=
 =?us-ascii?Q?B1kV/qyiHm0u7z548h/0W6/kpyIKFUwb+CE7gKhd9+ceQwMPdJd82awytV7W?=
 =?us-ascii?Q?e2HsHCJc8o+VlWku+VwTb/p62vsshIQIMS/v/q08asAcz8y6HVtzmnvQfdlV?=
 =?us-ascii?Q?MyDM1JlOC9vMHVpfG6My3bz7rTt5urXmC6/ichoVFlNqcB5Y+R+bIto0ubIK?=
 =?us-ascii?Q?zKLFzjw7YJnIoN4tipt9qYpJvijbrfuK5aK+ACF5vU+IVymbIsjVTQv8G70j?=
 =?us-ascii?Q?dYhWZwlMcK5dHVEmoZIQJf/nthAA3yPrGN8LzoQE4tgD2d7GKhUYt0Q3DDiQ?=
 =?us-ascii?Q?2PxKU9xd4KSVBswdS/SLqoy01kO35MwNugftxllCtHIp6LsZj8IUNX1ypp6M?=
 =?us-ascii?Q?UGaJgp/xwOpVTShGbqhbZjr83bt4a0kbIqgt+qkuZyKAKjOa8A7ryh5wuwV1?=
 =?us-ascii?Q?IH7eaSB/3Ji4oTtV6AcFWPNUfDum7dUX7D9ruuEsIvOFIl6mB3ZV6Tt7fM+I?=
 =?us-ascii?Q?UyivTA16IQDMurjyboAinThe6vuLG3Id8rtpkcX778OvQy62pYJT7o9kP8uo?=
 =?us-ascii?Q?rdKFysvzGK4xLAf3/ppsolWm6lUKwRIvTO3aq1+Gse1Q+CG3vbkmbrmnuGHC?=
 =?us-ascii?Q?eHEQ4fSDH+SoUbGNuG69nQ1T2xisQ9CgZEQ4DvusaRBc3SL3V48rSKpvLubw?=
 =?us-ascii?Q?jlaE00+wLnXD+35EgsImjvk/xcsyD93FwDvyPrW6ciER2LdVIL22O3NT3T6G?=
 =?us-ascii?Q?2abiHN0R9hA+kF13VHL84HPiZfXvR/4mzrkSuLPLqbtB81GQuAHeaiIlcPf6?=
 =?us-ascii?Q?HE2OFF6ilM91py9bu+3oXtUbbzecXWHOgxzvdOVORIUnRBlwqV3m9MbdRHqU?=
 =?us-ascii?Q?L5Xvod4BbwWynC1E1NOzIyBMH6KGq/kK6qDQJ35XsqYIWAWNFbsWjSaPdjss?=
 =?us-ascii?Q?wu3LjzXc0U7qOetWN2aBnFfsg+IXQhkWaHouGc32mkyOFbaxoRVaG62qvS1h?=
 =?us-ascii?Q?ghyPvZIP2C1V5XzIsLmyBPcBmSRRZy00LPcfGm10k1Xa4OrxeJD5IRgnqLWk?=
 =?us-ascii?Q?4EUKbytHWDT/B37wibCo0cM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e3d6d6-fa1b-41a1-1c46-08d9df42b922
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 14:06:31.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Iif3mh6K8gJ0mcZNDOnZj+Pf4jVPIjGnuIzZ4Yu4RSVKaP0Ivej7HFDLnxE+EcryaYQTQ2NnusRqZNn8ai2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rodrigo =
Siqueira
Sent: January 23, 2022 1:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/24] DC Patches Jan 23, 2022

This DC patchset brings improvements in multiple areas. In summary, we
have:
 - Z9 improvements
 - Clocks management adjustments
 - Code cleanup
 - Improve DSC and MST code

Thanks
Siqueira

Alvin Lee (1):
  drm/amd/display: Driver support for MCLK query tool

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.101.0

Aric Cyr (2):
  drm/amd/display: 3.2.170
  drm/amd/display: Remove unnecessary function definition

David Galiffi (2):
  drm/amd/display: Fix disabling dccg clocks
  drm/amd/display: Disable physym clock

Eric Yang (2):
  drm/amd/display: fix zstate allow interface to PMFW
  drm/amd/display: add debug option for z9 disable interface

Fangzhi Zuo (3):
  drm/amd/display: Add Synaptics Fifo Reset Workaround
  drm/amd/display: Retrieve MST Downstream Port Status
  drm/amd/display: Add DSC Enable for Synaptics Hub

Ian Chen (1):
  drm/amd/display: Change return type of dm_helpers_dp_mst_stop_top_mgr

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Martin Tsai (1):
  drm/amd/display: add protection in link encoder matching logic

Nicholas Kazlauskas (2):
  drm/amd/display: Only set PSR version when valid
  drm/amd/display: Use PSR version selected during set_psr_caps

Oliver Logush (1):
  drm/amd/display: Basic support with device ID

Reza Amini (1):
  drm/amd/display: Update VSC HDR infoPacket on TF change

Roy Chan (1):
  drm/amd/display: Support synchronized indirect reg access

Shen, George (1):
  drm/amd/display: Add Cable ID support for native DP

Sung Joon Kim (1):
  drm/amd/display: remove PHY repeater count check for LTTPR mode

Varone (1):
  drm/amd/display: Change error to warning when hpd remains low for eDP

Wayne Lin (1):
  drm/amd/display: Reset preferred training settings immediately

Wenjing Liu (1):
  drm/amd/display: allow set dp drive setting when stream is not present

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 205 ++++++++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  25 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   6 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  64 +++---  .../gpu/drm/am=
d/display/dc/core/dc_link_dp.c  | 128 +++++------  .../drm/amd/display/dc/c=
ore/dc_link_enc_cfg.c |  23 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  22 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  60 +++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   4 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   3 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 106 ++++++---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   6 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  24 ++
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   4 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   3 +
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  34 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +
 .../amd/display/include/ddc_service_types.h   |   3 +
 .../amd/display/modules/inc/mod_info_packet.h |   3 +-
 .../display/modules/info_packet/info_packet.c |  25 ++-
 38 files changed, 641 insertions(+), 205 deletions(-)

--
2.25.1

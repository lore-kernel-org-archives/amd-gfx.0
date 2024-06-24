Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9192C3064D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 14:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2871A10E47B;
	Mon, 24 Jun 2024 14:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b/DEuq9U";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B5310E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 14:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbeMFU7lRXIt9JDXO9KsJX9eB8iFQLjj5K/hFIqWcqMn+kGH3G9UJCUzzfFQx5o4SVPKXBVr17SiHT2qKZfirVps11tvSk9vOk8v2YkjIbDFLv8k2PHUqPhjHty5jcaya56XWmwvyyROnzOr0JHnHSuWpeEIX60LOtta5l6K6G2ew/Sh+PaYlCT/W8qgxUzH9dVwXygJsG/4vpWJ0TkkRfYyiuxLixW5o/hMuL+JHBWMz5eTT2P7rnkaFYyIH1pZCsJ8bK57lzTy7dsRUs0uaBFQFgT6SnJywVUCSdVjuj6D2Go3pIBBKdSQ9dZwHhMzmOTEoPe4H2Ra6dKf4fROlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/h+aBhjrPtfcTlM3CgLv3523SVWWCDqdqQN780s0xY=;
 b=MQVTRC5xQTnyVN4yv+GTuErIlG5ezSB0PtaY+/uZpgMjwAKdjwhsfKG9dWB5me79WHksXsOhcXSAZMPtwP9ll7ZMIc9qPvJjXMQcNTsWR7orrho8Hjr1+VVC0VHCXhBDhgQG6ykSrnlxS6WMNPA0461rgkm3KRQ7EHMsYbvnBeMjfWrK49q+IBXmSuiE94+kfNNkooHZp6FEoVpstu8vrb/uAIqCsvRMXi5lEJUwCLasYrjG8bjts1vZlhiyjlX4SMsruQ2iouE5wi1y7p0kR+bo6YXWa1pqo24jGrKh1QDT27H6mCoxgJRL7Dgjsc9ELqxGKDkoKjXDBJ2rbkwbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/h+aBhjrPtfcTlM3CgLv3523SVWWCDqdqQN780s0xY=;
 b=b/DEuq9UBdB/bFR7jwswnIvUMdjZLdt1I5P2k+z+JSR9ZWJJHh/W7v+g8WBacOENEtmPwB84lgiXj5wlxs3MUN8HJC10Cet/6jbXKJetazmRkq+Gv2GJhR9QirKFYXW7PhV1/5zLL6CroxglcHCyuhMsZBGyftK1plgzXlaXunI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:46:19 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:46:18 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/39] DC Patches June 20, 2024
Thread-Topic: [PATCH 00/39] DC Patches June 20, 2024
Thread-Index: AQHawyygKTCeSAibuEmfvLekruDWALHXA6BA
Date: Mon, 24 Jun 2024 14:46:18 +0000
Message-ID: <DS0PR12MB6534252C986B4EC13ECB97E29CD42@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=844d6799-149e-4df7-ac5d-722d4b06e1f8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-24T14:44:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN2PR12MB4319:EE_
x-ms-office365-filtering-correlation-id: 108a4c7b-8c85-4b49-fe42-08dc945c6847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?A6Bmp5/ifwBKphuHAH98chbPFZ+dM3vKzEXlOUoXpoV8uxr5LHYteXnhs8mq?=
 =?us-ascii?Q?I0OR6rLHtIZJ+AhnuTvzZ3BWwm72JwIherjIwwPzKMkE3Nt9LKJs1bw+PP6x?=
 =?us-ascii?Q?32QMuJJLhBuqSoB+/qKk9MeChDRZtPWhn41ivcK3wiXihqkRGVPAPdO1r8bi?=
 =?us-ascii?Q?yix5enTjUIWqaFf56oKhCtRngGiaZ/d1TPk0Zh5DvR71/d/8h4i0q8ZZWAYX?=
 =?us-ascii?Q?BXLPZm4HWfIuI58xrhARspDj70ZQgaL4b7GuX6wNvApmTJCsf7hZurvIWufq?=
 =?us-ascii?Q?C6p9cZxcaYtRyTJ+JDQ6rEj9ppEipdWpbLWHky2pVwXAlpCHRUAgaJm2ltzh?=
 =?us-ascii?Q?eagMKjMSHW4+afEn+WBARL4m3XeRncY9FMaXOJdEcaxorYdQnViBBEA6ib/P?=
 =?us-ascii?Q?DC+PXKU7+iy2NJQl/+kdEjKl9N+nolrbWqyqhyhdNxH4Dj0WTs9oLBXfN31M?=
 =?us-ascii?Q?mHAfp2jXVRZivu3vArS8jwR3B6B45M18mcie81Sx283iS/UWOagKTRklIHXi?=
 =?us-ascii?Q?7WHShWUmodEsL5pgQt8GbdNxAr0YwIYd62QmrefKWZEv7oom6LlvSGAKDgVa?=
 =?us-ascii?Q?p0JZyUf20eaTCqsl/AB7BPQtFKHnciTFAPoQg9JeNc6Lv+8gyloXSzuIHUkA?=
 =?us-ascii?Q?LkEzK7hibi7+MesKhoJKWYPR7LdXifaH/a31I6nwOkixxZQB2h0FUP99z2xS?=
 =?us-ascii?Q?ap16E3pgrtmF+JB760OjJs5PW4MfvhrfKkkhrcgEYwoNYHg1N4Y0qJwzV4WO?=
 =?us-ascii?Q?JhNhOpbVMvEJprm3PuSkDP1eiQlcaqBDMiTklYBo2V7QXMAf20m+/IO/Bo6V?=
 =?us-ascii?Q?purmAizSgD36a8IjHckahnS6R+zilsvtvP/JocIt2qPS7XaTE/+xXDKq6uVD?=
 =?us-ascii?Q?s8rZdOr3gYIWDG7c75s2vDqJEfEdBTJspsZtrnwgdYRU50PdmyE4DpnpS7Nt?=
 =?us-ascii?Q?GGxG1PD5kjw08wSJszK9obsEsRAEqlYR+VAcgVwH40Oxq7LmAZe3HWiOZT+B?=
 =?us-ascii?Q?MylJGu7vAuri1FQ/+D2nhAYCH5AvDG4BsT2cG/AwZGjJ6hfyRBwLgh1JbjR8?=
 =?us-ascii?Q?vNppe5Ye9mYdhdn5mBOair8oYl1jDZzRwNrhJ4tgjKb4ADECGRjL/zNmbLeI?=
 =?us-ascii?Q?WuOroZb5O26Cpb7oQwwIB+rLFG3t+ZsrB3pdRY3fVQj19gIL86F9F5/Et2Uu?=
 =?us-ascii?Q?LyXo1xs4d3oKOvEI4rQd7vMe20XoWoA9SypM4jGLpr9Sa5GgPo5vAdpACN0f?=
 =?us-ascii?Q?EksOC7DBoxNKCSqdXybv7NztAHFkUl05CXtJ0YssSCy29nSoEs/s3xkxlN1u?=
 =?us-ascii?Q?JDDkm2LNiTyX0vK5j0Z8LWmeOTAP55Mfs6DoxWtlhc5v4WVyAnKSxpbVgcrM?=
 =?us-ascii?Q?ZYbO8lo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WVM5OHZEE3m0KoY+Kw5Xr6GWufouA5evWt4tk0N0hxsNvgkAdIhU0wU/nAHF?=
 =?us-ascii?Q?ajSrMDOPsk8UTaqtlpFTioeTg3kXtq9Gz7yv3idyZHgDCHcOLrzhVVc52HkI?=
 =?us-ascii?Q?Zj/ZVT5iemHpjg0lHPeUL2MyiIMs7Vc5KaZ+51h0HtY6OyAeylmOrXeLMFDi?=
 =?us-ascii?Q?CQW1ikK7depSCCEohN2MJI7OPs94JF+94Janl0kXG6Sjd+DGqumiPardWMiz?=
 =?us-ascii?Q?Nz1jBikRAtFk+bgimzkR5bnDFaaQvc9Rm6R+zGRxUqgXQ2YQOzsdIlclL9Y6?=
 =?us-ascii?Q?jo7ckRg1IeJoUFbGAeO6r4KEDz3VbLIC+A/HHYgtkGgEKqORmLQxkS963Pds?=
 =?us-ascii?Q?5F9GccKTjxBC0I3SagfGPaxNCytkP9JETuDGXJzg/LmFPNH8yIRnxUzPwN81?=
 =?us-ascii?Q?fYdwDsHoagRkQACbo7wYfJofjbwj4OI28T088Zqv1yqnAIn4hGbuMc8q+kSt?=
 =?us-ascii?Q?X7tWWVP7Nwelzs0OXRofCh+SaJcTfDC2m2f9IwX+NKnq/EbROv5q6FwgVvKt?=
 =?us-ascii?Q?2WzDuTMzfDVm7khkxHMEBGvpdu7Bu5LA0YbscndLoiWdI3tqciPZ6K4FJ7ka?=
 =?us-ascii?Q?bPXhdfrESifqA+Hu1DTDiIlpR4dnlJQsaOOMhzUZ8445266pDO5tF+LfRMKN?=
 =?us-ascii?Q?KlaECpP142sSKNiOH/5AZvTXuRADR8ZmErMdPFt28JhdF9ytgFsQRtNeztoW?=
 =?us-ascii?Q?aAyRshuqi7lK+HFfAYRFJqn+NXBFmfHPtGn/rqo82C3eIdRR4V/eUl1qr7OR?=
 =?us-ascii?Q?ek8Lq4Fk5Cnh5TvZPewxp0ql4HrPqdG9Ca9ybzBueiojUM2tahivWmrfR9t7?=
 =?us-ascii?Q?y80yCLtjHKhB8xRZbi6y1P8yVWPq5hdaNLHneXCnoHeNO+3eam7K0BQWozyJ?=
 =?us-ascii?Q?rjMQ42HpbmOoIXjl58eRkI+nBfZZ5oe5fuDYB4KsACHhcBlXUZLOgOUOvUha?=
 =?us-ascii?Q?qrigAaKXeUAb8gsxKS6YHLdRse/cHS6Edi4EqbCiED5YA++wZ31cOISd5d4g?=
 =?us-ascii?Q?yWn0h4o9yy5f0GiEVoznuoTJvCwOV9mPcb5mGP0dyA9cBpVketwy1L74QcUu?=
 =?us-ascii?Q?FaQXHgQELBoLGD4xoLrAcanOWsDgW/gesqlFGf7TuzgoHpZKAe8bp2i3wh91?=
 =?us-ascii?Q?k0O/03/ljmaCUziZELi6HGKamAVrgxZoWQQOum3NFInJO4PdoXHBhDamy9N+?=
 =?us-ascii?Q?6R1YphYvM5wgaQzPcSxPLacA5RWxl120WY6KqV+A+lhZpw+7UsoUxlARCCg5?=
 =?us-ascii?Q?wGtPCYfBTxJKX+7yy9+nm6TXXEGPew184ZGVqTy7TAyrWrXcfH0rP8kPEsrS?=
 =?us-ascii?Q?/au88u4GKT97AZ+/am2RG6lb+dOjzGq1L+ZSnlAl6U5m5R438H/NIeYH3JFQ?=
 =?us-ascii?Q?bBcYrh2riRkdpK7SSDaisGFlc0cY0gyN5+83pguIg3EIGksnk5qJgq74jVem?=
 =?us-ascii?Q?ioRwxwIkdUcO6x1yXWCdzbQ6KJQs5AJU1pPt9LzHF1g0R+KqJcimywJ3FsJV?=
 =?us-ascii?Q?cTFPmQbAsgyvlyc2uj6d2UdZVFYfhH4G07cuQgXR5yWrxwb5Bjp53RVbFygK?=
 =?us-ascii?Q?PNru02TY9palvu2bvFo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108a4c7b-8c85-4b49-fe42-08dc945c6847
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 14:46:18.6863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It6tMj5Jn6ND0PKUrU4ma7msArGK2HtYOBLyQwg7kbU55b0qKYPPnmtN1HkkP2S6bbd69dyMWHP9vFyhiIF9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

[AMD Official Use Only - AMD Internal Distribution Only]

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

The patchset consists of the amd-staging-drm-next branch (Head commit - f79=
aa6503388717045d02f0d268a8c59b3f005fb -> drm/amdgpu: remove amdgpu_mes_fenc=
e_wait_polling()) with new patches added on top of it.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Thursday, June 20, 2024 12:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Hung=
, Alex <Alex.Hung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/39] DC Patches June 20, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Enable DCC on DCN401
* Fix cursor issues
* Misc Coverity fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (12):
  drm/amd/display: Remove redundant checks for pipe_ctx->stream
  drm/amd/display: Run DC_LOG_DC after checking link->link_enc
  drm/amd/display: Fix uninitialized variables in dcn401
  drm/amd/display: Remove useless function call
  drm/amd/display: Check and log for function error codes
  drm/amd/display: Check and log for function error codes
  drm/amd/display: Check HDCP returned status
  drm/amd/display: Add null checks before accessing struct elements
  drm/amd/display: Ensure curve to hw translation succeed
  drm/amd/display: Validate function returns
  drm/amd/display: Remove always true condition
  drm/amd/display: Remove duplicate null check

Alvin Lee (2):
  drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport space
  drm/amd/display: Wait for double buffer update on ODM changes

Aric Cyr (1):
  drm/amd/display: 3.2.290

Aurabindo Pillai (3):
  drm/amd/display: Use sw cursor for DCN401 with rotation
  drm/amd: Add reg definitions for DCN401 DCC
  drm/amd/display: Enable DCC on DCN401

Daniel Sa (1):
  drm/amd/display: Fix reduced resolution and refresh rate

Dillon Varone (1):
  drm/amd/display: Make DML2.1 P-State method force per stream

Duncan Ma (1):
  drm/amd/display: Reset DSC memory status

George Shen (1):
  drm/amd/display: Call dpmm when checking mode support

Ivan Lipski (2):
  drm/amd/display: Remove redundant var from display_rq_dig_calc in dml
  drm/amd/display: Remove unnecessary variable

Joan Lee (1):
  drm/amd/display: Add Replay general cmd

Leo (Hanghong) Ma (1):
  drm/amd/display: Always enable HPO for DCN4 dGPU

Michael Strauss (1):
  drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is
    present

Nevenko Stupar (3):
  drm/amd/display: Fix cursor issues with ODMs and HW rotations
  drm/amd/display: Fix cursor size issues
  drm/amd/display: Fix cursor issues with ODMs and magnification

Nicholas Susanto (1):
  drm/amd/display: Temporarily disable HPO PG on DCN35

Relja Vojvodic (2):
  drm/amd/display: Refactor dccg401_get_other_enable_symclk_fe
  drm/amd/display: Fix 1DLUT setting for NL SDR blending

Roman Li (1):
  drm/amd/display: Use periodic detection for ipx/headless

Ryan Seto (2):
  drm/amd/display: Add HW cursor visual confirm
  drm/amd/display: Adjust reg field for DSC wait for disconnect

Sung-huai Wang (1):
  drm/amd/display: Add workaround to restrict max frac urgent for DPM0

TungYu Lu (1):
  drm/amd/display: resync OTG after DIO FIFO resync

Wenjing Liu (1):
  drm/amd/display: Remove a redundant check in authenticated_dp

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  39 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  48 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   3 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  11 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  29 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  57 ++--
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   5 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  18 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   8 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  14 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  14 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  14 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  14 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  14 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  14 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   4 +-
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |  17 ++
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  29 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   6 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  50 ----  .../drm/amd/disp=
lay/dc/dsc/dcn20/dcn20_dsc.c  |  24 +-  .../drm/amd/display/dc/dsc/dcn20/dc=
n20_dsc.h  |  13 +-  .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |  58 ++=
+-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   3 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |   3 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   3 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 280 ++++++++++++++++++
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |   5 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  14 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  71 ++---  .../amd/display=
/dc/hubp/dcn401/dcn401_hubp.h  |  14 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  17 --
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  34 ++-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 169 ++++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  31 +-
 .../dc/link/protocols/link_dp_training.c      |   3 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  13 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   9 +
 .../dc/resource/dcn401/dcn401_resource.h      |   2 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +
 .../display/modules/hdcp/hdcp1_execution.c    |  24 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   3 -
 .../include/asic_reg/dcn/dcn_4_1_0_sh_mask.h  | 110 +++++++
 75 files changed, 1021 insertions(+), 431 deletions(-)

--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D88CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 13:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74D3112128;
	Mon,  6 Jun 2022 13:39:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695ED112128
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 13:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifK51iVG6m7T9dNMOhoWXHo8ksRHm5LryJj/O5lm8tpTiavop94Lq1sJZpssBOixqUA8KE7aFuYFyzOs97qmeqGtGRT2MGXknlcTpd0zpJj8DhBqaO/fgp6GLgRKYTTJ9GrayWaivd8TYLoUqrI6sSzN1gqTz0GcYzCnIJUWeepl2bbGyLBClm57Q3hUvmzoFy2U521LXjhSW2BfbxXN694Z2SevkMXiqXZey+9M/HaQ7ec4cbIVPsQkENgP84jGu/Os4RNJmIDGV1PENhAGmJYFLRZu/YdO5G6qnOj/9Ps16PrH9kQuA1xqwfbIU1HO2CR6hBsTiAqasApK7imjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhcnVe8G4nBiq8MGQgd/8I5ogl3JdKqNF30VH0teYD4=;
 b=PrCNShXTWFZJYoA513suY1UgOYGtWLd+IxsJeOGy/vAR0jZLQ01+ThCGTicvXrDPImEqNgXlJrn+lS4MGT6bxUf+FtQ+yRo7ErZB0NsJ0cMHpi7Pv39n9lzWE+jfH3DeEZYoGJKvs4tnqeNaWYda7++GAUkeOyQBcVr6Fa9E6rerG6XyxXIq0PQ3YHOhw1RhF7s2MGuMuhOT9u7857gOXlXhGE9hpa+MAkvU11kQxuC1lDpKi/yrR98Qf6ZJmYlZDWKS1D02OSUDXXqtdATHOcTrUVBT8auYp3SIJCQ3EsjPaqtH6jBM6x5lZShkNRV+bTuewjG94FaGmhmd49Zx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhcnVe8G4nBiq8MGQgd/8I5ogl3JdKqNF30VH0teYD4=;
 b=T0wOOsJnmP3R/84x6xRhUdxm1zmftPhZWuq4W77dQbxwJHTxvL7ghEWNwt77RxMS7pdOISWyWCSuKyZq5AGWT5mxaukTfxKaWHzhk5A7nB74gwcpNw06p4r13fpXUVYY4EBDlIYcgMMh2OOvVb6FJJhXHhdkNQ/qJsQKbTVqsJI=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 13:38:59 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::7d38:c217:66b:ac19]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::7d38:c217:66b:ac19%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 13:38:59 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches May 30, 2022
Thread-Topic: [PATCH 00/16] DC Patches May 30, 2022
Thread-Index: AQHYd4ZEFZBph7aaOEK/ecSM/DQ3Wa1CYv1g
Date: Mon, 6 Jun 2022 13:38:59 +0000
Message-ID: <DM6PR12MB3529257C44C286AED61A7C1F9CA29@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-06T13:26:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a31ec82a-a6e0-4ac6-b64c-a3ceef99bd4e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-06T13:38:57Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ba18113c-69d8-4f7b-8f63-910837a6ec84
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f99e916b-2363-4d70-f5fc-08da47c1e95e
x-ms-traffictypediagnostic: CY4PR12MB1270:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1270792DE3390A77FBFD1FAF9CA29@CY4PR12MB1270.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raC3pkbh0OoR629WmlCjs4Qb6Gv4p33bxduhYSRCOqCCMOcSBhAa0nbDorMRx//mh1XfSHeFWtsF67BxB3iWYJ9/L6xudohsLH5UdGTY2bjxcGmgHTqUqv6ve5g42tCN4xCSr6z+3lb6fU698c4DrI6txTj3OCIs2WKWYVSNMrcaAeh1TAfVSl/fv8eAwtItF3d0b0FVGPIEVTdx2iOWv4mrLlahe3btarPt6bkARMU9Uzno+iBByzDk6p95BBB36Fw7wGMQx4XVm/yOLBjdhLKVN8qgBRST13HnFPnmePbRdAUJqYopGDj21iqkzYpmBanZ9RZXTU43bw8YnpaMDWFUDtKI11NwXIX0vks4WXof2n5weDUGipn6KiKJWsp2XUwTRiZ2xqPs/66xeAjM4bBKREfBn/65Vlioaz66X3gcf3yO40uYdNVlQGulsxh1WVsvF2azi/KcLR1OKXBI8kVa8ggR8IeCNDxAH67MXCHfoAK5EYxM+t37XEO34qFGQteg6Pc6qT3MyrcqWer11L8CtIAIyVDgVhbaxuxnDh2w5gEXZa0Vfv5Hk7dlPa4zvWDxiQqVoQTcPbgVnitFKTcfc8ZpT535w1Qy1a0hVw4H6PIQjsMgavQaI3nRHL8zUhoaS/i4xkbgHt3L/k/8ENZLCXF/y4TKVUGrqM4OYbLNqdN4MZeaGq0u1gBRb7d83B9VYJRIDzKy9t62PWdMzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(122000001)(38070700005)(52536014)(66556008)(110136005)(5660300002)(54906003)(64756008)(66446008)(76116006)(33656002)(2906002)(316002)(86362001)(71200400001)(8676002)(4326008)(508600001)(66476007)(55016003)(66946007)(186003)(6506007)(7696005)(53546011)(9686003)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dj3Qu5ho7Tf6Lp5fONJaSbSe1yHpJV/ot50colsZA38WZPia5SLqfLnF3QtW?=
 =?us-ascii?Q?mqxzNRvxLqDf/NB5JPuWgtOVneiWjqfWARDY1R9bsF4OMWYUMH85lqL0ygds?=
 =?us-ascii?Q?/vcX/HYhZuQ0DZTHLzKs8f4UV41cN20lE6wzMj9+bsXysp2zHjjmFlBsCkWb?=
 =?us-ascii?Q?Cu970MomnZCpzSINJECKpdaapFIkDzuzTd2c7WNyaLz2mEgd5G9l4WfpKgmW?=
 =?us-ascii?Q?XcNeWQmACE7ERnt3RYZQipcLRXKtNO+inIBk7ZCSFyw6m0HVWRUj8jfZvCc7?=
 =?us-ascii?Q?BqR34E+d7IrBFI1Y2k2aw24qFg1qrAFperHy0QwabhDqUZT2DRt8em4r0fI2?=
 =?us-ascii?Q?qQd6eVMv82b3QlUIHgkFDo/XbTs/rdoBFE6eixeabnh4kjqGwnrsZLOq1C4R?=
 =?us-ascii?Q?sASYBgAPRTZnEt5JIrVXa4Xwz/oTY7HRrDzigloc/AzSZqx4wsZSjjzlx0vf?=
 =?us-ascii?Q?Qr4uhVLRR43RskCAB44V+R7mdttCQWDzy3ptJesiDlA4oqGSLE9SkJa6z8DR?=
 =?us-ascii?Q?rU9tzSyOmBr/H/YVNoGR9TGn4VKsIkA13fmY852D3PoXiAeFCAaEFs3sBpAt?=
 =?us-ascii?Q?0/ymTAVPVl05Rpj3DqrWjaOn4glPs8dqw+uZUSQWJt5qexcRTsnUXdCGyglg?=
 =?us-ascii?Q?LX1QF70kfEA6YNmFvI0PUj+VAsk63gPY5PY8z++seQD11HSYa11g43UwRIjk?=
 =?us-ascii?Q?/GSmRcTc9xk28OvERNNbPwPHKWyPXyS9jINCnVX4Aj3CVqfuQg1gns3MsqLc?=
 =?us-ascii?Q?jXv4qyjeaX3iW/C6hZ8UxCLthrZD3A6EDTLOYfaXMefvOVJyXEKgz4+CZayV?=
 =?us-ascii?Q?7dHAgu9lHt2EoDqWSt2oKRBJhsbHGndnGC0w+67n5YI8exBe+JsS+tEJe08F?=
 =?us-ascii?Q?feNRBO/+/pTeTRBuE3zR9qKmbzTMqkTDm9Knbmmp89OIRSPR69z3xY1hT/fM?=
 =?us-ascii?Q?ZQXkRL3PCz1ZPtTx071EetQQLy0VVd+zlEJhJVqExw6UR7k1iKmvQ1e1b01a?=
 =?us-ascii?Q?kKGQvyA1fSs4I0Jb4cMD3Z1M6ATdadMEtqh2xBNC05tw2ZqTqF6zNAfR1DcP?=
 =?us-ascii?Q?yf/QFlvOl2fTFt4MqU/YXeYCAJrlBYHLkNYTgdCQFbKL7zHAZqCWRcmBuJAG?=
 =?us-ascii?Q?loyaQPWqwS96fDHzEG/HJCw0pxLES59EBrChppE71koK7zGuxKo2Zsi6hOVx?=
 =?us-ascii?Q?AfrXrW5US9rtbsfbcFeGkjO6RF/VJEPamPEGONJhfBjiOdTT8vvEKY4Q4wN6?=
 =?us-ascii?Q?0IqSv69ZvfSvMSYs4HtKMpXNaP94/k6v5/TFGBORvuIbbYnO4BBmvG8ZPg8h?=
 =?us-ascii?Q?RdPyEifHmpNKnUxo54hIMel0L7UrnHkPrZzw/W7Tddzw1WXCCTfLSJmcZefr?=
 =?us-ascii?Q?CVrGGMRgISlJqSD3WOnW4dqQcwZNMIZnpx0yohxBK967iT8aqUrB4R8TmOew?=
 =?us-ascii?Q?/ugx9pu66OaGnxgWLt+gCeOG03K0heSGG/IIY7uAePEVbeWY+sXPwqGjo2Qu?=
 =?us-ascii?Q?WYJjqmWhRMR8gUUvcrb47yLtHMDa38tE4SRHLrHhdmUfV2ZmdoxKTFOo91hN?=
 =?us-ascii?Q?U+0AxoO0FCnSk4gyHEI/jl2lm57QI/qeRwWwKoC18w5RxwCSyDrXrfN0dibj?=
 =?us-ascii?Q?vW2kbRDa7MxCXCHxgrGYtQF09ZClaHs6YDrVyjjHpKLY586HdJZi+pGcPXVv?=
 =?us-ascii?Q?IV3dZRauIpo1RV/O06XTEVclrbHcpAIJ6zY9G804ar9Bk8rM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99e916b-2363-4d70-f5fc-08da47c1e95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 13:38:59.5608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHE0poJdJj80SK1sMad8EIG/jMYIktR2E5QK9BVu8cgrr/g8C+Iq9Hi07uybP/sG0VYKUA0T4rj3L8WZhxGT7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 79d=
15ef553971d39ae0df0c3ccf35905e4e4f1bf -> drm/amd/display: Add DCN32/321 ver=
sion identifiers) with new patches added on top of it. This branch is used =
for both Ubuntu and Chrome OS testing (ChromeOS on a bi-weekly basis).
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hamza Ma=
hfooz
Sent: June 3, 2022 4:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;=
 Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; La=
kha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.G=
utierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/16] DC Patches May 30, 2022

* DPP DTO fix                                                              =
     =20
* Transient encoder fix                                                    =
     =20
* Restrict the reading of LTTPR capabilities in LTTPR mode                 =
     =20
* Increase maximum stages for BB                                           =
     =20
* Distinguish HDMI DTO from DP DTO                                         =
     =20
* Optimized blank calculations                                             =
     =20
* More robust DP MST hotplug support                                       =
     =20
* eDP bug fix relating to ODM                                              =
     =20
* Revert a patch that caused a regression with DP                          =
     =20
* min comp buffer size fix                                                 =
     =20
* Make DP easier to debug                                                  =
     =20
* Calculate the maximum OLED brightness correctly                          =
     =20
* 3 plane MPO.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.119.0

Aric Cyr (2):
  drm/amd/display: 3.2.188
  drm/amd/display: 3.2.189

Chris Park (1):
  drm/amd/display: Add HDMI member to DTO

Duncan Ma (3):
  drm/amd/display: Blank eDP on enable drv if odm enabled
  drm/amd/display: Correct min comp buffer size
  drm/amd/display: Fix dpp dto for disabled pipes

Gabe Teeger (1):
  drm/amd/display: Update optimized blank calc and programming

Hansen Dsouza (1):
  drm/amd/display: Enable 3 plane MPO

Jimmy Kizito (2):
  drm/amd/display: Fix entry into transient encoder assignment mode.
  drm/amd/display: Avoid reading LTTPR caps in non-LTTPR mode.

Lei, Jun (1):
  drm/amd/display: Extend soc BB capabilitiy

Nicholas Kazlauskas (1):
  Revert "drm/amd/display: Pass the new context into disable OTG WA"

Roman Li (1):
  drm/amd/display: Cap OLED brightness per max frame-average luminance

Wayne Lin (1):
  drm/amd/display: Detect dpcd_rev when hotplug mst monitor

Wenjing Liu (1):
  drm/amd/display: add DP sanity checks during enable stream

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 38 ++++++++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  8 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  8 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 +++++  .../gpu/drm/amd/=
display/dc/core/dc_link_dp.c  | 77 +++++++++++++------  .../drm/amd/display=
/dc/core/dc_link_enc_cfg.c | 45 ++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  6 ++  .../gpu/drm/amd/dis=
play/dc/dcn31/dcn31_hubp.c |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 24 +++++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 .../amd/display/dc/dcn315/dcn315_resource.c   |  6 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |  6 +-
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |  2 +-  .../drm/amd/display=
/dc/dml/dcn31/dcn31_fpu.c  |  3 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 16 +---
 .../amd/display/dc/dml/display_mode_structs.h |  1 +  .../drm/amd/display/=
dc/dml/display_mode_vba.h |  1 +  .../gpu/drm/amd/display/dc/inc/core_statu=
s.h  |  2 +-  drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  1 +  .../gpu=
/drm/amd/display/dc/inc/link_enc_cfg.h |  7 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  1 +
 27 files changed, 234 insertions(+), 69 deletions(-)

--
2.36.1

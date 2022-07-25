Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4DCC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 12:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1015BAFF95;
	Mon, 25 Jul 2022 12:57:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17B1AFEDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wom1LtNkjXrHkLRaXUdPeCwHn0iKDdFARuPwkWp7bdT0tiXceCsSEd8e93D47DBPnKo4XSB9OtqsFkalLjIE5up+ROdX1dURJBSXgG55UcWmSIEw3A9n9i3hbeaYNCpLeEbB7DKsHfq0/Eexb6/TlROO6+Sou61TFUkmDOt6+BF1+QIV12ZUDl7EQ26gKAknUvnMTDpovkcHj9PQx++04Ht8r58SE5ubnZZSnYDxqJxGjDoBv43aisL32b4KQ2Esm6vcQwWseyNnxI32HDm37QmSTDt4a6NdhfsSYoM3nSsDgqlkSJzt22VhXfsPOD3Cen9ShIOHjrXAzryZq76v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pdz/zxWRmhtLT0AmbvvSYyYwt9Oy60FBkEBR2rzQoGs=;
 b=miSS3FM+jV/K6V39zU2j2qFO2Q9/WUhGu7HpyleMRuUW5nceNAQeHsuL9SGWsnC19qHGLAB3Z/JGRAw352Zxk8MVkeJpqP60XQgocfYe3FQkKf7+Uw04i4kZ9HPZ7gCOKU35dN8CPRzU82Ntn2ilYGqrOxRuXUgaa1Kgxy3NTAZ43LZTDSR9BuxdUl2S9IytWkhOGoO1dapRBO9wI0ku2GbfHcJ0mCmTVhfjiHqELzqNYhyr9Hal4Bshsgx8/1x23I3KiL2tfnjBRUOf5txMNabqXnhivu0Xeav/0aevbpvqZM0V9MtnenGmger/AacH/pZ0WWiTUBkrG6yXraEkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdz/zxWRmhtLT0AmbvvSYyYwt9Oy60FBkEBR2rzQoGs=;
 b=TbcyZuBj7bCgztzneQp5T/tw7m/BBWONIWyLR0hVq9uI4+3ez9lnoAuIus+PC8SrxtKXGF87Nzv/FDfzsGB9WFh+/er6a1lfcN/WS3+TQ2J0vCy1st/i3LrmEBO5jiHgXmdba+3FYRlx1tnKap5MrRqULE20p/1Fj9dyyUTryTk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 12:57:32 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 12:57:30 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/31] DC Patches July 22, 2022
Thread-Topic: [PATCH 00/31] DC Patches July 22, 2022
Thread-Index: AQHYngraHe9AKyq3V0mk65bt4BaE9a2PD1ZA
Date: Mon, 25 Jul 2022 12:57:29 +0000
Message-ID: <DS0PR12MB6534AC6464EBCFB0235A17729C959@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-25T12:54:45Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cb547c75-cdc4-4f94-87b5-088caa269dec;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-25T12:57:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: bd4a6363-a270-4c7d-ae60-9aaab185dec5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2cb225b-27d9-4bbb-0c4d-08da6e3d3b9b
x-ms-traffictypediagnostic: SA1PR12MB5615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUJVVvpLVQskorWBTShQbZHqdpNThsXM1imxpIirhLIfxGdFYPtkQjTw9YB0J6SUxRrjICPmfAVtQ6NeaHJvWKYJnd+3Y2yJDtF405bgHYRENxG0tMyVd5jbNaUAleeGG5s5KtG0mnYYnSFUZKEEApGlvfgPcPOoP9mneKQGbQFxNInwa/as52pTVKsQMTjl4rYABo7NTrJ++lxs6HZcTcUQ6o8/amThPCmAbBGUi2kChCTIJOiYey1WfMudyw7oHpHEV3YoDgVwUDE9ehuzVqkfYJ9V8zx0BOJNfhjM2uXYz0oGGwP7PApEq6qwQTzC9kjL5Ea9v0ZebnichBLMGEMhIzWvUqXBejp2dLt0WhUfspf0XgnCGdhoBL1ggCI6/ypEwpn7IoZjPyQ/U4ESPw6zPjHivQLyH/Q6xKWKz2+iZLp75PK1dlIDZLqovbL7t8hitkTh7NB+8n0w4wNwRiGp2vsvYe7BMirA0YYbMBhY2bw8hRRpkZE2IKWb7hL7/TzUWt9AKJRzDqEf+KTJxddkiMQYnwjLvWkEU8SkoxEhWNxvBaRY+gXbJ4YQ5RMX7MJD57VmmFf8lvQKzGUH04VpKvp5p5GVkwLRX9rYEJGrSOYZQ5Zq1XwJ8PF3vMq2CM+mnhPBARGJNvG4Drek4i1xtoB+xJlSYXUtizA9XIyMIQoMBb83JCwqj+ZL6TYIASyHU7xtJsBgX8rAeQmngXSnIxE8k/EjZmUd09l0VdWZeoiAz6FmknL2XS04wKONGywZnIpvZoyaCjHxRr7DYJdlWpeXp202Rm86RxpvR+A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(186003)(110136005)(33656002)(76116006)(54906003)(316002)(2906002)(38070700005)(6506007)(53546011)(7696005)(9686003)(26005)(41300700001)(66946007)(122000001)(55016003)(8936002)(86362001)(71200400001)(478600001)(4326008)(38100700002)(8676002)(5660300002)(52536014)(66556008)(66446008)(64756008)(83380400001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B5FdAdHchDeAY7k+sPoyEUeGQ6bWBXosY8jhd9wxrboS6GazqwsiMUUjmYGv?=
 =?us-ascii?Q?rr6zm9pf5kqg+psTtfOvMzHxXKLTJ4LlIksDVbKw/IPlxQIFcgD1sdAA9wJo?=
 =?us-ascii?Q?NpkQpoqVGNbr7rMTEfCo4LLy76kuGpATN66ZC9DjQL7nMsJhTqz4JulL2zYe?=
 =?us-ascii?Q?IWLFARJdrLnwmjCwL54cuOWa5c2Ab7fDOEohZNrl4BNr5Hbd0+XiC575JTN9?=
 =?us-ascii?Q?KW6bQtrT8NtEuGoaATN3Fq/Ia5l8keId6Adyv0JkBIYgNn/fJ8bwbOtYRHre?=
 =?us-ascii?Q?M9SB+CPkGZh4sDC5QfqUHMnKtmAGkLPMtW8mS1H7ilsGoqstXSL6n1h2wQ/W?=
 =?us-ascii?Q?ZVTWjsIN03EhNeWE01tdhuPoZd7wzmUOdAKlGbgso+sP0Z07keMy2Vk7/GZJ?=
 =?us-ascii?Q?MKxdeLQQFVDfmQYwKCpaX+MM6CNABbZt6PokzXiGFaCahWG7bLSICMSERPZp?=
 =?us-ascii?Q?iPD7FYR2PWK+pDYkYE6fAMI3LpsT3XR46koyA0+8dAHiwPy0BBSIyPr+Y7LV?=
 =?us-ascii?Q?W9wY0e1M7BL4653tIKRsNizdMNMhBavNhR8GygxakWDxjmWqhs5emChjgYOW?=
 =?us-ascii?Q?PnS4MfCiHjYtTYS0GMNf6ZNf6ZFZE7yiTcCyEdxHqtLmTOU8IoT3OMIyAYXI?=
 =?us-ascii?Q?tIfV+zhTWxSgTYcBzzQrFuYSkKxeBY/BGp6S6YyRfPey/ntvbzAXV93x9GZ5?=
 =?us-ascii?Q?JsGDoLx0sl+ao9lSUdmEvrsSRf/lOkcqIntHfR6bllq3bygXXbkbtDGnP4OM?=
 =?us-ascii?Q?X/lyajlgOlvwn1PI1R210Kz+ZTZqedq97T4kX2iqQhks8vTGlf3pqub/FAEN?=
 =?us-ascii?Q?/suHMRNI4S/NPQLiV83eZg6B91XTu96e/p3A+WhgpZovM50M2ZtzEs6+q1Go?=
 =?us-ascii?Q?2hn/FXUGQYAUQBOudrhPi7qE6W3z54of+jvcZ5+/DLS6yvHkHdLZU0Lju5Qh?=
 =?us-ascii?Q?qjLjQ1h4mxouXI+UI6d6MQ2PgKHaa/CFsWyWJOjXUkZFhL3oJ+xlnay0L6AE?=
 =?us-ascii?Q?sijKva+5seFnIzQ8WDgBaq0aC39L+vU5ga3rWWep9BMAEtVBfYFJoMndSKvZ?=
 =?us-ascii?Q?1fflNDvN2zFkukMwPXuxIqoq+FkK6jIajBecTn09gqBaELQFK5ek5JsALnJp?=
 =?us-ascii?Q?N75uc9OGsYu6eAbHwhfA8Pl5AMonx0B1BiUoCRZnDSqkA9tnNiObl9chNsAt?=
 =?us-ascii?Q?91gaj1H3pQANn1uX2qLMxpmowgtM6seU+H/2P7J41+DpEfM20c6Hc87m8/qv?=
 =?us-ascii?Q?RQbMpySUxJjUNNRqQGJaffA13SQfr138Wdx2s+esim5hGHpmVTM4Zf5TsuPU?=
 =?us-ascii?Q?5qvUJGOREdOuXvHj42/5p6XhgvAplRWwPrT+r4yTAAcY5nTyVAHxyJT3awso?=
 =?us-ascii?Q?zv1z1ssKSlvIlZBHxXdYzZsX+fFrSeY/WTBcujNdCeni+OFMG+ZA9RKkryiu?=
 =?us-ascii?Q?7WHDkrGTxbCi66yoKSW80+s8ENb599lVvuYGfbw+t85L0Tioqgc9TmrK6qVJ?=
 =?us-ascii?Q?3knJxQhMtD55SZWfaZjdU2TWSRIShrXeOHnWhOtKFHVe+UAgJcHiIR/y+RmE?=
 =?us-ascii?Q?90y8H4C8G2g73/AXy7Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cb225b-27d9-4bbb-0c4d-08da6e3d3b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 12:57:29.8111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNrDW4BKy6pl147jzjTH7A67Y7ikaTmn/W+TIqhJoFeP3PNIi/g+PCFUtTMwmxVFyxGcHC46V+Zk4ktFYmyluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Broadworth,
 Mark" <Mark.Broadworth@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
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
The patchset consists of the amd-staging-drm-next branch with new patches a=
dded on top of it. This branch is used for both Ubuntu and Chrome OS testin=
g (ChromeOS on a bi-weekly basis).

=20
Tested on Ubuntu 22.04

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
1 Commerce Valley Dr E, T
-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>=20
Sent: July 22, 2022 4:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>; Broadworth, Mark <Mark.Broadworth@amd.com>; Hu=
ng, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/31] DC Patches July 22, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Copy crc_skip_count when duplicating CRTC state
* Add debug option for idle optimizations on cursor updates
* Disable MPC split for DCN32/321
* Add missing ODM 2:1 policy logic
* Update DCN32 and DCN321 SR latencies
* Add reinstate dram in the FPO logic
* Add dc_ctx to link_enc_create() parameters
* Cache cursor when cursor exceeds 64x64
* Add support for manual DMUB FAMS trigger
* Fix dpstreamclk programming
* Add missing AUDIO_DTO_SEL reg field
* Add OTG/ODM functions
* Use correct clock source constructor for DCN314
* Use correct DTO_SRC_SEL for 128b/132b encoding
* Add pixel rate div calcs and programming
* Remove FPU flags from DCN30 Makefile
* Create patch bounding box function for isolate FPU
* Move mclk calculation function to DML
* Remove FPU operations from dcn201 resources
* Fallback to SW cursor if SubVP + cursor too big
* Drop unnecessary FPU flags on dcn302 files
* Reboot while unplug hdcp enabled dp from mst hub
* Reset pipe count when iterating for DET override
* Calculate MALL cache lines based on Mblks required
* Fix two MPO videos in single display ODM combine mode
* Guard against zero memory channels
* Updates SubVP + SubVP DRR cases updates
* Fix OPTC function pointers for DCN314
* Add enable/disable FIFO callbacks to stream setup
* Avoid MPC infinite loop

Alvin Lee (6):
  drm/amd/display: Updates SubVP and SubVP DRR cases
  drm/amd/display: Calculate MALL cache lines based on Mblks required
  drm/amd/display: Fallback to SW cursor if SubVP + cursor too big
  drm/amd/display: Update DCN32 and DCN321 SR latencies
  drm/amd/display: Disable MPC split for DCN32/321
  drm/amd/display: Add debug option for idle optimizations on cursor
    updates

Anthony Koo (2):
  drm/amd/display: Add support for manual DMUB FAMS trigger
  drm/amd/display: 3.2.196

Aric Cyr (1):
  drm/amd/display: Avoid MPC infinite loop

Aurabindo Pillai (1):
  drm/amd/display: Add dc_ctx to link_enc_create() parameters

Chris Park (1):
  drm/amd/display: Cache cursor when cursor exceeds 64x64

Leo Li (1):
  drm/amd/display: Copy crc_skip_count when duplicating CRTC state

Michael Strauss (6):
  drm/amd/display: Add pixel rate div calcs and programming
  drm/amd/display: Use correct DTO_SRC_SEL for 128b/132b encoding
  drm/amd/display: Use correct clock source constructor for DCN314
  drm/amd/display: Add OTG/ODM functions
  drm/amd/display: Add missing AUDIO_DTO_SEL reg field
  drm/amd/display: Fix dpstreamclk programming

Nicholas Kazlauskas (3):
  drm/amd/display: Add enable/disable FIFO callbacks to stream setup
  drm/amd/display: Fix OPTC function pointers for DCN314
  drm/amd/display: Guard against zero memory channels

Rodrigo Siqueira (6):
  drm/amd/display: Drop unnecessary FPU flags on dcn302 files
  drm/amd/display: Remove FPU operations from dcn201 resources
  drm/amd/display: Move mclk calculation function to DML
  drm/amd/display: Create patch bounding box function for isolate FPU
  drm/amd/display: Remove FPU flags from DCN30 Makefile
  drm/amd/display: Add reinstate dram in the FPO logic

Samson Tam (2):
  drm/amd/display: Fix two MPO videos in single display ODM combine mode
  drm/amd/display: Add missing ODM 2:1 policy logic

Taimur Hassan (1):
  drm/amd/display: Reset pipe count when iterating for DET override

hersen wu (1):
  drm/amd/display: Reboot while unplug hdcp enabled dp from mst hub

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  34 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 136 +++++++++++++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  20 ++-
 .../amd/display/dc/dce100/dce100_resource.c   |   1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   1 +
 .../amd/display/dc/dce110/dce110_resource.c   |   1 +
 .../amd/display/dc/dce112/dce112_resource.c   |   1 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce60/dce60_resource.c |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 +
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |  24 ---
 .../amd/display/dc/dcn201/dcn201_resource.c   |  11 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  30 ----  .../drm/amd/disp=
lay/dc/dcn30/dcn30_resource.c |  58 +------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  25 ---
 .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |   8 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   8 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  30 +++-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |   3 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  38 +++--
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  36 +++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  37 ++++-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   8 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  23 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  63 +++++++-  .../drm/amd/=
display/dc/dcn32/dcn32_resource.c | 153 ++++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  18 ++-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  87 ++++++++++
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |   4 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  63 ++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   8 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  71 ++++++--
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   4 +-
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   |   7 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 71 files changed, 867 insertions(+), 258 deletions(-)

--
2.37.1

Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A062C28E86
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C57164F26
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 13:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C57164F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EE889DC2;
	Mon, 15 Mar 2021 13:59:42 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680055.outbound.protection.outlook.com [40.107.68.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D827889DA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 13:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fys99eYdeyjtUAOyWtc1NHN0HjofrWvUiXPxx7Pit0m3MVxmjT4GURX+5Pa+shrtDH8fQ6ByTD4OYPYQcWrW0XgvUie/RQy94prVp7ZPOtptU8EqgwVP983iFKOOt4R1eAmqB6lI0wLPFYWAHS1/cqRCeMaP8I6g/RXeyHBMUPr/o24AvTU9gB0OzdUBPJfNmC+MOvJKHEtJyKx7C/dmlGJIGWRXjc9GXEUZ3V7lu3GeuPTiyNTEiRb3ZfUQiY2PNdNSmrE5YftGeJdo69/v7GH13CZpdW4CgFKf9jZLYlP88XrANUhvxn07jI5ciAsbzrIbctN2noy8PJvK20Z+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzod6z87aIExsXdhVMalcncUHzLGsM6a+ENZsm71rc4=;
 b=m+2f1isZX7qG/vnQg0whNUmo5umNnfEsaLIBvPbbWonIO4DWYiZ+5SGA8TvkCZn4JijcBezXUZapUnCP95Gr/hwmkd/ulX7UD7nLOk8yJJwCyaJ6Yvd62ZwP2+R3D6PFEw4Xq7nP7VmgUS71B4yRp7ll5VJk6jXbvzaMYaQNDundxQlyfh3Fxr6r9FUVFgE7iSEVlBdU4lYQNsOYT/u85+cgJaCvyFvyenvMW/Gf20B+j8YzmQmknZMwJEi4DucRD6wF7jvO9sVneLjB+zCAknx+GKD6avNtxTlNmmdm9ZFc8hQ+ddp1/n+uDtocyTJc43x127Vi43E5FfFaoHwsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzod6z87aIExsXdhVMalcncUHzLGsM6a+ENZsm71rc4=;
 b=qEd9r/Fls1GAe6ALpcDzB8B9tV5vSmAey7BtbZj9/CkVjsq0eO4wEzeclXtFr/EP4VxVrjiM1FycvuDrfjHGiP7TU4z01FdatuQrFOJz/GkfH90h7VBqZ3zcI6OeJ6RTBJvAD6WZ5coLf70mLk8ZJJ7C3AjIvOBLgfzMBOAllg4=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 13:59:38 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 13:59:38 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chiu, Solomon" <Solomon.Chiu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/23] DC Patches March 15, 2021
Thread-Topic: [PATCH 00/23] DC Patches March 15, 2021
Thread-Index: AQHXGY14cJLc/Ox/GkKy/KFPAwFZeqqFE7Kg
Date: Mon, 15 Mar 2021 13:59:37 +0000
Message-ID: <DM6PR12MB35291056DADE4C67BEEA3FBB9C6C9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T13:59:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=08f2092c-5db6-4742-a463-64cb5c722c75;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4cdd68e-2859-4cc5-60fb-08d8e7ba9280
x-ms-traffictypediagnostic: DM5PR12MB1321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13215FA66260D5139C2486719C6C9@DM5PR12MB1321.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBWMgEuzCd7qqfUYGFdxrMw6n3byJGew1uNUXt7UQcgR75hEMY6tJEGKvUd1H5RCqzedNHz7XLUKvgCwu3PkDE6gYhVnRHH7ELflwXd+rZ+RTv12CnfmYvnIWoircURGhRJRp8HSOZy/Vpxh1b37tsnF8fha4q8n7MChOwApCCy59T4/WltJ2bCioUB2uhBKKexUti9UDwxKgLtRxChKi0mwxWlh3lzS0WzzQvhNVmmA5N1xDoVWo5FjPzjvIsjXbsNha6gAh+/qOvetmr2jzVcbJsrJNMrt3T+McFoeKjglIKusl0eFLo8K0VWwayk/3Y/tCNg7wl99pTG1eazCByWNb408CxrYiEGFGNhHavcqR3wwxmdY03No6rucVf1Nyc9uClAexhMZGV1TUnTgPBbXvhEnJ1hNSp5BNW8VRAUh2xzqUb58pk/6Nw3juWplmuPM3RQaMwM/3WVZn64WA8UI6o+vyqgF2zaZ2wX0wYVdLEn7+mRcGAH+S5tVkHRaYFrXbSNDjvcxp/pDQqJ1fbtdAdq1tcX1bwFP0OMysQuOJwk3ZrvwSwfzp5U7eup2zQNy/U/rfA6H3Pyi6VaXrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(9686003)(66946007)(6506007)(55016002)(53546011)(8936002)(76116006)(5660300002)(64756008)(66476007)(26005)(33656002)(86362001)(52536014)(4326008)(66556008)(8676002)(71200400001)(45080400002)(83380400001)(316002)(2906002)(186003)(66446008)(110136005)(478600001)(54906003)(966005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?F9fxY4wcjSVn1XgMjVvxxOYn8fP1Y0OHecBV63XoVUuHpZi6mnzwe9ZFe5?=
 =?iso-8859-1?Q?16cMEdnBPoQ9o7XPlbJY3jXRpMgMZ26I0CqWAjXl1wTGCzAXJMtCnqOGwM?=
 =?iso-8859-1?Q?PEwrbXtzP9IfOOA5ngg9UuFEPcEHyIyr6n8vuxQ7gjiN1xOh/hm+WqwZ5c?=
 =?iso-8859-1?Q?znY/+stupzWnPrRrR9ThvP4JYTy+kDH4B77jYR9dEoRv16Pbo+YYh9WLyt?=
 =?iso-8859-1?Q?3Yb8PGboGQz/NnmS61hSTbkCtORSi07AvIleQ/WNzXxsHEf3JtUm4NE/D5?=
 =?iso-8859-1?Q?KaupBT6FpW4JN1jzQK6hudxea8l5Zrk/sSFEYSIcdOtnIpsWgjR+W1+LcE?=
 =?iso-8859-1?Q?xytcjyaE+wkG2Q58LAdJYJHx3IccYQsYxwlXy/PeG68qC2j7ylV5iGBB3n?=
 =?iso-8859-1?Q?479wzYQfyIK/CHywLzsabIymoQJ5q7yUPOqK28DfqBaRSzoRh6iYRWhHPa?=
 =?iso-8859-1?Q?tFfpV4EKloZ58ADNY4kEU/4EV/YkwZIqZ7xIur6Nl5fKgdutJWGJE1Gbtx?=
 =?iso-8859-1?Q?P+j1s7f9/lOvLou3k8qBYlN0lmxh0VHQfQw1mswqHpiLzBOuiKRyJ2sof2?=
 =?iso-8859-1?Q?bLfrSQ3hfP/7fE4CRmpy4QMwRJIq5G5NcMPvvuP1d+C+na66Kz3l16a+GC?=
 =?iso-8859-1?Q?HTF7W8/PfvPlLr3tOAG9AdnPlKlunWNiyDR+NRxnULqNsLgkx/W+4JWMlR?=
 =?iso-8859-1?Q?ZTMxP+Q0Dxw0vpbrDeya1XglAAEDPB9GaYyZb63ljrlrIcKD6gNrLgjLQz?=
 =?iso-8859-1?Q?Qe3r30454WtuK9rdnCAyoVotHA2n8jYhft8v04Z1aXlbCerwPHUBmWgVD+?=
 =?iso-8859-1?Q?X12oFrOBAH9/p0368kNAtam2MzD0rWmZdoBEGNVvKg3fUdw2XEjfN2NIkB?=
 =?iso-8859-1?Q?5f8f0v5WjeNWrbCGy/WJTyj2JO9A1zB7Em4gm7B/vwmdTMs+EA1AXri4lI?=
 =?iso-8859-1?Q?GDNm6VVDl0O3CidQ2t/UbGCxCq3L+UnNcAxPl3xY6hyyYts59/XkJE3oG2?=
 =?iso-8859-1?Q?xOieXllyXV6aL+HcnJmX26y9TU+NCQBFVXObR5jA/mAaOQ7pm7VtuuXdId?=
 =?iso-8859-1?Q?b88dhgk6uGER52z02yu0S1E+LhJIpO44oCIM0MxY1NdF+vAA0ZjtTW+onK?=
 =?iso-8859-1?Q?kUj2sFdC9kBoG89IeCwTyZ2FHUinskr/+5p91jgXB/ozy1P8/2qADkngtZ?=
 =?iso-8859-1?Q?sVEItybq3vubgUD6fZ/5tGlTHZOUNe3N5LJNLwUvOASEWJcStKX+5t0d/t?=
 =?iso-8859-1?Q?pUZn0+1K0NDCTUB7xi4Gj5eM+DVV7ZlGjMgWFdlnXsqgLLhjhigPchz37H?=
 =?iso-8859-1?Q?ikYVfB4MnXwPSYI4jlc4500GfHrxtTviBKwNrnRG4Gtjgc8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cdd68e-2859-4cc5-60fb-08d8e7ba9280
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 13:59:37.9636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+znt27Lxt7uGjfdemjHhxxVPCJ/eORTYW7UQF9k2UnoX7V86lMMI4wkevDH+lUfJkg9lGCd0vqqIMn4exUTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: "Jacob, Anson" <Anson.Jacob@amd.com>, "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on a Sapphire Pulse RX5700XT on the following display types (via DP):
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also tested on a Reference AMD RX6800 on the following display types (via D=
P):
4k60 60hz, 1440p 144hz. =


Also using a MST hub at 2x 4k 30hz on all systems.

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Solomon =
Chiu
Sent: March 14, 2021 9:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; L=
i, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.S=
iqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Au=
rabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R,=
 Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/23] DC Patches March 15, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Add debug out when viewport too small
* use max lb for latency hiding
* System black screen hangs on driver load
* Fix UBSAN warning for not a valid value for type '_Bool'
* Fix for outbox1 ring buffer typecasting issue
* Bypass sink detect when there are no eDPs connected
* Increase precision for bpp in DSC calculations
* Add changes for dsc bpp in 16ths and unify bw calculations
* Correct algorithm for reversed gamma
* Remove MPC gamut remap logic for DCN30
* Fix typo for helpers function name
* Fix secure display lock problems
* Fix no previous prototype warning
* Separate caps for maximum RGB and YUV plane counts
* Add debugfs to control DMUB trace buffer events
* [FW Promotion] Release 0.0.56
* DCHUB underflow counter increasing in some scenarios
* fix dml prefetch validation
* fix dcn3+ bw validation soc param update sequence
* add a func to disable accelerated mode
* Fix potential memory leak


Anson Jacob (1):
  drm/amd/display: Fix UBSAN warning for not a valid value for type
    '_Bool'

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.56

Aric Cyr (4):
  drm/amd/display: 3.2.126.1
  drm/amd/display: System black screen hangs on driver load
  drm/amd/display: DCHUB underflow counter increasing in some scenarios
  drm/amd/display: 3.2.127

Atufa Khan (1):
  drm/amd/display: Separate caps for maximum RGB and YUV plane counts

Calvin Hou (1):
  drm/amd/display: Correct algorithm for reversed gamma

Dillon Varone (2):
  drm/amd/display: Add changes for dsc bpp in 16ths and unify bw
    calculations
  drm/amd/display: Remove MPC gamut remap logic for DCN30

Dmytro Laktyushkin (3):
  drm/amd/display: use max lb for latency hiding
  drm/amd/display: fix dml prefetch validation
  drm/amd/display: fix dcn3+ bw validation soc param update sequence

Jake Wang (1):
  drm/amd/display: Bypass sink detect when there are no eDPs connected

Jun Lei (1):
  drm/amd/display: Increase precision for bpp in DSC calculations

Leo (Hanghong) Ma (2):
  drm/amd/display: Fix typo for helpers function name
  drm/amd/display: Add debugfs to control DMUB trace buffer events

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for outbox1 ring buffer typecasting issue

Nikola Cornij (1):
  drm/amd/display: Add debug out when viewport too small

Qingqing Zhuo (1):
  drm/amd/display: Fix potential memory leak

Wayne Lin (2):
  drm/amd/display: Fix secure display lock problems
  drm/amd/display: Fix no previous prototype warning

Yao Wang1 (1):
  drm/amd/display: add a func to disable accelerated mode

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  33 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  10 +-  .../amd/display/am=
dgpu_dm/amdgpu_dm_debugfs.c |  43 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +-
 .../amd/display/dc/bios/bios_parser_helper.c  |   5 +-
 .../amd/display/dc/bios/bios_parser_helper.h  |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  34 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  11 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  26 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  23 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   7 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |   1 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 105 +--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 668 ++++++++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 33 files changed, 758 insertions(+), 362 deletions(-)

--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Ca16e903f56f147ffeb2308d8e7a49859%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637514041434999129%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DgdPgcQHGPw2agSMyp31ZjkqfwI6%2Fr9LtYpnnfijn2Tg%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

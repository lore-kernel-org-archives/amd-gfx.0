Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCB9C001DF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 13:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8BA10E095;
	Tue,  8 Aug 2023 13:35:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D973910E095
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 13:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehAQvDSvWzSxjDYYbc/oglJfjdf97DjUPMoDk01Ty46VIKd9n//6cHWUzQSzou4YIGdktUQIShVYpLU1zr4yBtcsYnIH0/7iv3RS0SaRDgff86uHajYK+rYnBhSua/3zrlRPn9AkcBDKnMH5tfLYs/fZs+bUWV36cU7+oZVTQh1cw9AAyQZRvjrsH7DJs8DE+qgTDzw8ZgD+Bz+yJNtTT2/34GiZN/NorbUG+Nmt+D4LyGs7n2wXNFHTMu7xcJaiYh/WZDj3sqYRGk48wqVb/R1hnXcJLNgu6F5sJfJGkgJrQ0KzJg8hAcg7xjGupN7S08FBKnMZiAJr3pvX9o82TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE1DJ5to4LpRtCFWuWr6Lq1BUh5yFf126HpRlktZwXs=;
 b=EhymVl+ekQPxSu8CWFk5SrrqSEjp9ytPmBoLUcgJEcyV99tg9sVy2ytHdVFvxo/kGmnLmW7Iuu68v6uj7izSJC6ypSE5oMcd9RuuUYn/aI9/476Tf/XMDAMT89tGcps2Ny/BfYG2AtFK+kU6lwcJc+oaHH30SnCNGhGQZMcYPJ12kMIOjBTpppi84BSoARa645qrw3vZ1mu01jS3fKTxGlzKnsykjX1HCvT5/f+pEeXoyh8j5NlcWJU3zAj7adImvAc3gp1g3g4UtP3md//n2ErIFi+Rl3L+Gye3O+jh4VOiMAy1nXDWgq8xUl5Y7afVMCorYS9fnplK/umwJqz/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE1DJ5to4LpRtCFWuWr6Lq1BUh5yFf126HpRlktZwXs=;
 b=F2Pat4p+XgY+qgBidZrUUQy5qxyXoG50tr6uKdLrhZS1oD1eJU3hFFOflWetQjl92udjTQWIJkKg5EFP730gwKZgZUJA5veY3gaZW5kOJfFxHN3g1YWmVOYui1K9k8CX15xMSJhVk3sM5PDZrMg1nEbKil631mnxXzsfvNTz+mE=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 13:35:18 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fc6e:93c6:2283:ecdb%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:35:18 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/22] DC Patches Aug 04 2023
Thread-Topic: [PATCH 00/22] DC Patches Aug 04 2023
Thread-Index: AQHZxQ3OvG3CFn0sqkuAlozQ8F5/Da/gb64g
Date: Tue, 8 Aug 2023 13:35:18 +0000
Message-ID: <DS0PR12MB653467DBDEEF793E79C5421D9C0DA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=56801d92-7703-444d-80fd-6a305e5a309b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T13:33:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA0PR12MB4446:EE_
x-ms-office365-filtering-correlation-id: 75cc23a2-5c3a-44e8-24bc-08db98144e52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wE665XsoGMxEFui23DygsgTiZqPRRZbxg8WkdwzkQJcslVz+3kn1GsEVhdXjenyRxsBuMnOZ2azdtPa7BhINDGaNRx5f0zDAEYoa+2v/6nH/p7exyw5W3lA0cvF4zOSP6UmFmMDEHkf0T3lhAwxJjawRsOzRzuxH7OlU9GlYi2DyGXFTz+YIPq+ga8EaPNIh2bq78GSvAAoBk2ezeTWJnWpA4Mlolgq5Ka59U6UOwqUwmqz1lrDGM8SqfB5YjFFddTGHygUGEk+3Rfjo8mIpKyK8E4ZO3GDZsSy3S4DXZgfvGu3PaB2pZGPDfDCSkLSXr45sR6wjEBDsfbDHofKH6o14uYOPc9Dk81RnB0uMZ6JZQ1UWO1JsvpqiXqWBkHwvyN5LSTF0AsvuJqSVzaUg2vFWKZ23qUC2oaF1s4ufwqM+Irt5CYpP/3KTKFFgAIS+8Xw01OVL/+8+i9mEk5IxP5KZZneJpybqRfy3SJt+vpSy3jl8nIs+eC0vUf6sPRIh44ezmyXfsIE4rkSYA4/cEUpv0eHmnYJT+lo5w2VViXw1kPf2OpqDUjPdWNhmGapG/BjX/H4h2v2ZHmxJSbohmxdaD/BNYCmfDQMAvMN0JRe8Tjp+lMU19RHLDxzpKZdR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186006)(1800799003)(316002)(83380400001)(4326008)(2906002)(122000001)(8676002)(8936002)(33656002)(52536014)(38100700002)(53546011)(5660300002)(7696005)(26005)(66556008)(66946007)(76116006)(64756008)(41300700001)(55016003)(66446008)(66476007)(478600001)(110136005)(6506007)(86362001)(54906003)(71200400001)(38070700005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lv/XtPAwaNrOeSTOXL0kJenn23pRm7PQVXfIRkXwayyg52yoIqybtJ2Ga3cn?=
 =?us-ascii?Q?WHeIJTckIyUQhTT+fX65/qT4ph5V6eirQ3sOvdWMBH8ZqD8Asje8FYm1qYYX?=
 =?us-ascii?Q?USlOZ4771M1SyleICHvh5yWlQdugg0Dt4MrBMoxCXbZhW97NjbYrlPQHxvJ0?=
 =?us-ascii?Q?au5XKMlHbv284GWCDpYKB27aBDufFUwCdAfcFIjXEmUU1vrrDul8EG9NvYjJ?=
 =?us-ascii?Q?VLAI2SpVFyJAmaVW3cMF6WjTDgwHtlAnlm8n4AnO8GnfPcKfTQDezLU0mO11?=
 =?us-ascii?Q?qK4P67Mv8ZHdPsPp/ffhN9Pfman5Efa9UA03U/mea6bVzyrRR38dA3vAG0Lo?=
 =?us-ascii?Q?IIjlyfpmaOT+r2htFuu5HOthjUvRMuqhXsck4net8ffyuglyHukPjhJLdeBD?=
 =?us-ascii?Q?fqHqVf/GCgFCsyotGrCQrXOXmIoWRynr6XvXlvmTVYe0lAPO1NqyBB5L4w47?=
 =?us-ascii?Q?JeS1ILgTICQDM45JDHXtwozIVnbgOMMH7ix4MC7t3M5CMO8bvmnp1a42ZXNQ?=
 =?us-ascii?Q?cXOw1O47998rp/Jonf2hwwynXf6svwVGa4Qu0Ml6q2S7ZkESY28scuRnAeQw?=
 =?us-ascii?Q?uAX4UGpFGzkriDuipM77XEmbcUSxIh8JVgJlAGfYMPBX/g++t978kwm21WT5?=
 =?us-ascii?Q?UyBjCZSX8YDXJsk6YteK9E7YfasZ9DlyN3ASNqMcaPUUbfQkayj+bBeZNAn/?=
 =?us-ascii?Q?tOG+O3fzb3tqKCI9rkiOQPJQ+3fZ7bCJqQYH6lUtpnoTKLiZai4Cnr4F0dEQ?=
 =?us-ascii?Q?ku8qPlqcm+6D3KQICbMi3wSSU2lAiycSOKMj+C5zW3L576RgCGoKLMzvmq3f?=
 =?us-ascii?Q?d78CIKjpMA6UyHrH5nxv09XTkMnB3Sav1LdU4n2cvU84Mad8qjxTejKXCddO?=
 =?us-ascii?Q?mJwuvJNCxK0c2tgTN7JLGQ3e9rdIjZeU1IIj2valGstd+SMOLyZorIA6t1sa?=
 =?us-ascii?Q?9auxkbTZUVsicuTOkfGpRqWogvhuCsbRincoe8uTqJ3Cx/aQJWly7t9EDP27?=
 =?us-ascii?Q?vL2WpVTfg2+yUum79+/QGuq0SECyDUyN3WtfrLp4+TMdwUWbN5oDVMDBro35?=
 =?us-ascii?Q?ISp4UdpJuwvgqI5BDTrJSMNgzpczI8ipiFx3BOGdpF2H5o+BCjSwcMEJF8MC?=
 =?us-ascii?Q?xFCxvLfKzs8zVObsdp/hXsM8vvxUn5QGBoB8J/K6Kqfxs/a+/lOeiv6Gx4a9?=
 =?us-ascii?Q?ljjHzWnW92wh+8vzcg3vG5q9Wsv4K2fIWSDsnTGwYo9P2Wk7jnpVlCnKkRjx?=
 =?us-ascii?Q?tEzK4VTon0ExtmX4vFzHcbeBYPJmRKOCTq0ecI3d9AUloaKGQYKO+P3s5m0y?=
 =?us-ascii?Q?9ae8UnYe7pwFJRxuNo8hYCKfItZgn6VKtriBSbaP8pnUpeWd/vj4Rwx0GB3n?=
 =?us-ascii?Q?nWiUnKZesy2VH97c8flBXKk0/Tpp5+fiYpk+g365ABFDDkLEsxDXNMPI3BnA?=
 =?us-ascii?Q?yM/waWfCunFdcj0jFzU+1E5KS1cju2N8s/3RM/4aHRZTpmc0UsnYiecx0a9B?=
 =?us-ascii?Q?ARvdeLTi8jvx5UC7HUoaCKy/boiMexJu6WPfbnTkLmzXXq7fut7Y3s3ptoQ5?=
 =?us-ascii?Q?t9FAVWleSPs9RfZiB+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc23a2-5c3a-44e8-24bc-08db98144e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 13:35:18.3728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcKyKi6wAwrKUfQ6XrVkf50QUmD3U/U6P7oTfsppaypXC6TEY9tmy3XYbmZjiZAfx/8uCkKR8e92OCDjrMgXWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

[AMD Official Use Only - General]

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 389=
af3e7a5f7 drm/amd/display: Promote DC to 2.3.245) with new patches added on=
 top of it.

Tested on Ubuntu 22.04.2

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, August 2, 2023 2:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHs=
uan (Tom) <ChiaHsuan.Chung@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.co=
m>
Subject: [PATCH 00/22] DC Patches Aug 04 2023

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fix a regression in blank pixel data caused by coding mistake
- Fix a bug when searching for insert_above_mpcc
- Fix backlight off cmd for OLED panel
- Update add plane to context logic with a new algorithm
- Adjust visual confirm dpp height offset to be 1/240 of v addressable
- Add interface to enable DPIA trace
- Support plane clip with zero recout size
- Blocking invalid 420 modes on HDMI TMDS for DCN31 and DCN314
- Make mpc32 functions available to future DCNs
- Change HDCP update sequence for DM

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Use max memclk variable when setting max memclk

Austin Zheng (2):
  drm/amd/display: Set Stream Update Flags in commit_state_no_check
  drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK

Bhawanpreet Lakha (1):
  drm/amd/display: Change HDCP update sequence for DM

Leo Chen (3):
  drm/amd/display: Revert "dc: read down-spread percentage from lut to
    adjust dprefclk"
  drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
  drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314

Martin Leung (1):
  drm/amd/display: Promote DAL to 3.2.246

Mike Hsieh (1):
  drm/amd/display: Add vendor Id for reference

Stylon Wang (2):
  drm/amd/display: Add interface to enable DPIA trace
  drm/amd/display: Enable DPIA trace with DC debug mask

Swapnil Patel (1):
  drm/amd/display: Fix backlight off cmd for OLED panel

Wenjing Liu (8):
  drm/amd/display: fix a regression in blank pixel data caused by coding
    mistake
  drm/amd/display: support plane clip with zero recout size
  drm/amd/display: always acquire MPO pipe for every blending tree
  drm/amd/display: update add plane to context logic with a new
    algorithm
  drm/amd/display: adjust visual confirm dpp height offset to be 1/240
    of v addressable
  drm/amd/display: do not treat clip_rect size change as a scaling
    change
  drm/amd/display: move idle pipe allocation logic into dcn specific
    layer
  drm/amd/display: rename acquire_idle_pipe_for_layer to
    acquire_free_pipe_as_sec_dpp_pipe

Wesley Chalmers (2):
  drm/amd/display: Fix a bug when searching for insert_above_mpcc
  drm/amd/display: Make mpc32 functions available to future DCNs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  80 ++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  32 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   7 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 111 +---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 589 ++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  29 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   3 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../amd/display/dc/dce110/dce110_resource.c   |  12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   7 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  15 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  28 +-  .../gpu/drm/amd/di=
splay/dc/dcn32/dcn32_mpc.h  |  61 ++  .../drm/amd/display/dc/dcn32/dcn32_re=
source.c | 188 +++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   8 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   4 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  38 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  21 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../link/protocols/link_edp_panel_control.c   |  19 +
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  18 +
 .../amd/display/include/ddc_service_types.h   |   1 +
 45 files changed, 651 insertions(+), 705 deletions(-)

--
2.25.1


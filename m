Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C64C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 22:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19F64DE4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19F64DE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577446EC3E;
	Fri, 29 Jan 2021 22:06:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B126EC3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 22:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPlOKrnnOGG4x+kyxMo1alkPktDMpASy+HiyDrbJfaTVDcnMCEDOFwHpmZ2DqLIrMobjWBOOI/QZoqVvfxIbpQUvZbf82uIV2qpkmxHJQ3xjVT64u3Jr2ICJg3UN9ZpPnrB7ZL0bW7mt7v/isESwmYvdMmGC0o6uZN936SXIepnicwerHiEW9RJEd3yxNXxL050ufNQM5ZiB87B3PRWnn19Eq6SAo+8qGgThdbAa/8jUyY50bYCyJ2jCB49yO3yHru6Weg3h+cfbFFErbiqgPCYcTJ9Buih7xKLye2/wUKuJlMiMjguJYUbR7ptZ1e1TKMdvBYiySdu8L0DIbH/8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGMLUp4FPlU89X0yKuhP1xjvlF7FzWqZsmVmPKs5EAk=;
 b=dwqQdfHBQqiV7B03LGDWFI1i07mq7N3x9wxJLbnL10BL/YJ/m8smuk9mty8nZxTZ7k8cgHCPCV6xngqjGhR04lSywjJp64cvwyVvEYcOPMLeAqPGZDL7FFd402KWCf4DoRYDrmWEBikp6mILEFzqGzqv5LxCGy7lU/iGHoT1uWDBsAwAZilwBYAU1aJkPA6r0oORI6hRmP8gBWzf3F+oc+X+AsU6outUFh6HX4l+7OjS8JEYb54A6GfQ8jMTN2FTeilbWRqdAyJEP/aEL+aWF9UvBiXOphZyVIvd+UTV2LpT42NOGjhmB+dfGuK/Vq66Oy5Pcm+4TNI2ovaak4Sbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGMLUp4FPlU89X0yKuhP1xjvlF7FzWqZsmVmPKs5EAk=;
 b=s4/JB7TxJAugLdhtoui5zose48DaO65jkDKKvAs2kDk4rF6bhqHt1OovHGovHFVlHkI/vu32ZFT93qZuBHItbwegNb3yMCaZEkT+X3HrnqpxkbYukMWOSxtet090pY91H6xKl4dMGqe4MAhMSkwhhjzq3mm7C8QL3m4DDkVIO/8=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Fri, 29 Jan
 2021 22:06:13 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1%5]) with mapi id 15.20.3805.019; Fri, 29 Jan 2021
 22:06:13 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/27] DC Patches Jan 29, 2021
Thread-Topic: [PATCH 00/27] DC Patches Jan 29, 2021
Thread-Index: AQHW9oWkKkQqfx7VoU2rEm5FQJk1Oqo/JM1w
Date: Fri, 29 Jan 2021 22:06:13 +0000
Message-ID: <BN7PR12MB2833FFBFD012D9DA71605FE09CB99@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-29T22:06:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=73d7ad16-a298-4908-a1af-8ce394254fc5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [24.235.164.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd581dd9-90e6-4e67-eab7-08d8c4a217a4
x-ms-traffictypediagnostic: BN6PR1201MB0148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB014860F98B693F12C47893729CB99@BN6PR1201MB0148.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLS2ka8GVXRfTCikjZ7yuSyrKH7KcQrVIWnZLAeKY5VR5Vvq8xSimL8sDv61990izE18h52/oImW4QGUfoztnVQJsRi5WPb+ZyfM9ZFDWmN3L2lPd8EfaGiPEOC6kbEyXuFFM6sDqg+qnyuxfr/bU9oSzCjalAksShPDiY5xduClnTOJIGcqnyP/cst7Hk+els0UESbHUxhER5N0Z29nu9+f2Jwrn+ChGh3uTcv8yq+wAODQ2Hba4dQ/F8p/Mo0GraPKhZjeHx0v60MHcll2Nu6fHCrC9Fhmf7844VHqSFR52Um5M9eLbIwRPiCbhSuhRrHyslWtv2jTc9Pl7LeuVeR+SBut2Ywx38r7562DKGKmO93yP7JwgDp8hQFAer/JouMX+usUbxrAWIahBBJ7rPEVPGvAs7WhXEK9WyWa4qpxW5rYrWFa6qWewXLaF+gnreUTDBR5vqL8A6uLPrU4JMvQvDNaLvBOu36eiGUNSGKPJO+BQhQGx210K0086s0KQun1vBBYQduy1T7u+Ieayem1XylLUoCIOip5/rZtXXhhB/ylefGSU/8BiAfR43G8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(45080400002)(26005)(8936002)(33656002)(966005)(71200400001)(186003)(316002)(4326008)(54906003)(110136005)(83380400001)(8676002)(5660300002)(478600001)(52536014)(6506007)(55016002)(2906002)(86362001)(53546011)(9686003)(7696005)(66446008)(66946007)(76116006)(64756008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vaOnyQXarHWTufxDNWmRjM9/0LaUyO91QdgNaBsGZi1r7FMnJRwscmn4/8?=
 =?iso-8859-1?Q?OAyb8fqaPK9bGJ1mh8wHAZlaSyyu8GgMLSxh8ayAGAUfKpNb8uGB61jaDO?=
 =?iso-8859-1?Q?DTQukfBSUTcMG4khUYuW76mwiZkQFCFTrbObTpiJOSPXmTHAk7FuiEnBgw?=
 =?iso-8859-1?Q?Ep0M+qMyk2/YFV5tXNkLJf+MPEVVS9DvINT2ZppjedoUWRvbITebNlFsGA?=
 =?iso-8859-1?Q?cax47iJ3sv7EOfm8YlLbEnk4QbiaiI8XNmoaBH3hOJtD8aV7tk66RWtYhq?=
 =?iso-8859-1?Q?ilsQA2soGmX3b/cq/HMPP6z/AHgX/KKdu3JlpF5c2G+FBFnEqSsLHS7TAa?=
 =?iso-8859-1?Q?ufKmVysdF2INdGmq1hCbM8EExjOrBc1SrSuK9G9gP/MC+wq/c7IvJlJJez?=
 =?iso-8859-1?Q?uKnzYPC6xE4nkUU+b3hShS9JH2Os3GnLsoG+XldOxMqAU5pgoVbaIBwos/?=
 =?iso-8859-1?Q?4uwMuOYBkqwGFwwSZGauU4k6yAuzKHw7MsMGpMPNkMpMaJMEbJVeBR1id5?=
 =?iso-8859-1?Q?5Ok2SH0KIPAlOxVh0eo4iqNFsyyianE9GUZ412Qb048VUCESHlANKTcfWl?=
 =?iso-8859-1?Q?u07shT2HqRS1YQc4VaezIM7KRLzLLU9N0bRFQutEPglaAHLWkefVXvVDAR?=
 =?iso-8859-1?Q?S77i+4o9euXinnA7wU6hymjf2+FcoP1+BnAhkgiFX4e0JmppbTV6jgit1N?=
 =?iso-8859-1?Q?TiY9xfsNrnTixVzBq5tcBWMt98BKzlL2KmQfVI6C3y+GvE/h4UTuK7+MfH?=
 =?iso-8859-1?Q?BwbpUsWwN4FGsPgv1DuXeD8KBFLyMcFRhMY0U2oxOcAPi1gfvT40tJcsIZ?=
 =?iso-8859-1?Q?3BBsac5noGEjLRLW5XzHLZ8pqSNfnCbHYxRR9yM+oQDE7wgXzNmvatjCiL?=
 =?iso-8859-1?Q?06VKlNMOcrz7fHSPmPUTe4RoOsFeZNEFETVl3tJuBH+JppfsYuaGu27y5h?=
 =?iso-8859-1?Q?XHyixykfTCYUlw4Koej6/SyRcyYz7DBK/kgyweUhqEvJvAihBcKWZuU+Ym?=
 =?iso-8859-1?Q?L1PFQ+smxjsg/18JQQsy9jI880j7MrhxxK21pCrC9Vo4avIZ1u9mo+ba2O?=
 =?iso-8859-1?Q?pySaVVFB3Z20z7Lg9HXDZYyrsXqg6u8fwSNnmoE5PZk1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd581dd9-90e6-4e67-eab7-08d8c4a217a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 22:06:13.1336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HntSkeB1XbSvpo2O0yUIS47O0eHssaZTaqp+fkojbLkHhAaHQbewNAoNfYMOajlPBVzyxiO4vplZlzxoRjptfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

Ran the test this week on a Sapphire Pulse RX5700XT and a HP Envy 360 with =
Ryzen 5 4500U. Tested with 2x 4k60 (DP) displays, 1x 1440p 144hz (DP) displ=
ay, and 1x 1680x1050 display. Tested the laptop with these displays (via us=
b-c to dp/dvi/hdmi/vga) alongside it's 1080p eDP display. Also tested using=
 an MST hub with 2x 4k30. =



Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: January 29, 2021 4:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/27] DC Patches Jan 29, 2021

This DC patchset brings improvements in multiple areas. In summary, we have:
- Better handling of dummy p-state table
- Workaround for some legacy DP-VGA dongles
- Add Freesync HDMI support to DMCU
- Enable "trigger_hotplug" debugfs on all outputs
- fix initial bounding box values for dcn3.02
- implement support for DID2.0 dsc passthrough
- fix calculation for the pwl backlight curve
- Fix display detection on HDMI ComboPHY
- Drop SOC bounding box hookup
- Fix DPCD values
- Fix multiple memory leaks

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 0.0.49
  drm/amd/display: fix calculation for the pwl backlight curve
  drm/amd/display: [FW Promotion] Release 0.0.50

Aric Cyr (2):
  drm/amd/display: 3.2.120
  drm/amd/display: 3.2.121

Bhawanpreet Lakha (1):
  drm/amd/display: reuse current context instead of recreating one

Brendan Steve Leder (1):
  drm/amd/display: initialize i2c speed if not initialized in
    dcnxxx__resource.c

George Shen (1):
  drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Joshua Aberback (1):
  drm/amd/display: Better handling of dummy p-state table

Jun Lei (1):
  drm/amd/display: implement support for DID2.0 dsc passthrough

Lewis Huang (1):
  drm/amd/display: Set power_gated to true for seamless boot pipe init

Michael Strauss (1):
  drm/amd/display: Add null pointer check to is_dig_enabled func

Mikita Lipski (1):
  drm/amd/display: Release DSC before acquiring

Nicholas Kazlauskas (2):
  drm/amd/display: Drop SOC bounding box hookup in DM/DC
  drm/amd/display: Fix CW4 programming for dmub30 cached inbox

Nikola Cornij (1):
  drm/amd/display: Reject too small viewport size when validating plane

Samson Tam (1):
  drm/amd/display: fix initial bounding box values for dcn3.02

Stylon Wang (3):
  drm/amd/display: Revert "Fix EDID parsing after resume from suspend"
  drm/amd/display: Enable "trigger_hotplug" debugfs on all outputs
  drm/amd/display: Add Freesync HDMI support to DMCU

Sung Lee (1):
  drm/amd/display: Add more Clock Sources to DCN2.1

Taimur Hassan (1):
  drm/amd/display: Workaround for some legacy DP-VGA dongles

Victor Lu (3):
  drm/amd/display: Fix dc_sink kref count in emulated_link_detect
  drm/amd/display: Free atomic state after drm_atomic_commit
  drm/amd/display: Decrement refcount of dc_sink before reassignment

Wenjing Liu (2):
  drm/amd/display: correct some hdcp variable naming
  drm/amd/display: remove unused force_ignore_link_settings debug option

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  76 +++++---  .../amd/disp=
lay/amdgpu_dm/amdgpu_dm_debugfs.c |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   7 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  34 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_ddc.c |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   7 +-
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 +++++++++
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 +++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 120 +++++++++++++  drivers=
/gpu/drm/amd/display/dc/dce/dce_dmcu.h |  11 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------  .../drm/=
amd/display/dc/dcn21/dcn21_resource.c |  10 ++  .../drm/amd/display/dc/dcn3=
0/dcn30_resource.c | 143 +++------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------
 .../amd/display/dc/dcn302/dcn302_resource.c   | 168 +++++++++++++++++-
 .../amd/display/dc/dcn302/dcn302_resource.h   |   2 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  29 +--
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 37 files changed, 625 insertions(+), 438 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C23635029eab44087addf08d8c49cc452%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637475524912193583%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DqOO7HpFb%2B7ppkLj74PEX8QPMShPT77M7ymr15ZFCc%2Fs%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

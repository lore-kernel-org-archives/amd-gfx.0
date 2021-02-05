Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8DCC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C17464FEA
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C17464FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281686F516;
	Fri,  5 Feb 2021 22:26:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB6D6F511
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKXezm9nfdtUMz+Lf5+0EpyPRSLFyBEAa8hN4j5s6QSDsbaTzahCwxPLr3Mp40rW5r5SgvktTrfue+j2ICXLmtGNulB7RhQiASbSeiv41h1hmy+6xMeBlQIxxoggdu5NO/wB6j4BErJK3C9KhnUXiJ86dT0VfjqNaU7MG43lcCYEZYTOrQTJIWdx8eWUqA3CH1J+Nr+d59R1bVabyf0A7svrXwmV9m3uz0pddTHyJUncCuwHqrEzZcHShxJ48WsAgQwaRs3ALOhsBB46Xm2432EfxiJfup76Bipv5vSG8im3rjEobXJ4hNGPKZX/bIykVQs+Us7xkdYvROmJHq6m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3LBOM0vQtkQYRPzuA4aQ2JKiqxprvTji2AVK8nQ/98=;
 b=LWo1BggYlRdeqC3dmmRA6hwfcjkbnw/SEev9aNpVfdQH8CTVp3nQuuUOu+c6PJOg3EALRa9iIscpQ69WqctGZThA03eJ5+va9OeGINTWR2PiE3f3ceZA9CVDeHh3FnWZTfr3mg01N3DfdxNGXd3tPeEIaOgGxpzxUfYUBHY8QDTKRqUrC+VPq2XrM6IU/Y25uVmapOnCsp+rcltWSHG4pmyH2evJZw84JOsbVYlIxVphKYHHQ/jze9mC4hgOAhH6lzv+tomOi1ar3x2y+hXWkUWoDq56S2YsyZhch+DnW5sXPEZFiH+ykPvD0P0Cgas8bCPbSD55A8NZ5n4AmjqF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3LBOM0vQtkQYRPzuA4aQ2JKiqxprvTji2AVK8nQ/98=;
 b=L6/yRker6W8TPiBkCNi89bntzTUPM5bQmxqXVxoJTkGcC97j48VAy4bsCgNPusvUHWQGS/38PRnoSU2nSJw0Lm5GrIFguhHDNBlIY5/TYf/nCHBrAyY6mFW37zLA9jy2TeJ671dQj7VVJbayK+yNYyKK8ULIK4cSIXozV3mvFxM=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 22:26:08 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::39b4:c220:1dd0:9ca1%6]) with mapi id 15.20.3825.024; Fri, 5 Feb 2021
 22:26:08 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/11] DC Patches Feb 5, 2021
Thread-Topic: [PATCH 00/11] DC Patches Feb 5, 2021
Thread-Index: AQHW/Aqw/tEDXTW410u+EMB6fuvyyKpKIenw
Date: Fri, 5 Feb 2021 22:26:07 +0000
Message-ID: <BN7PR12MB2833792C5C14D3462DBCFC3B9CB29@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-05T22:26:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=408beb76-3d74-422e-a4d3-ce36b6dfe75f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fcb4c33-8ca4-482d-d58f-08d8ca2508b2
x-ms-traffictypediagnostic: BN6PR1201MB0017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB00172A8701F893B5A28C0C759CB29@BN6PR1201MB0017.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhzP4YN6BILY/Zm/L1Dd8gBDZADltWmmpsI/UXU5ylEmQF/8pM4UJmb/Qroo1BAwFyQ1M3ivmLcA06ros2bzgg2kIAmwmvin+N4aqSbhim1UbUkuaI2Cvgv0jf6mr7XErbOiL31cjseLReJhE9iEH/io8MNxFhO2t4/iakSVIqVrEv9jfJnkXM8nh7pFlDMhkjeZIubHstQxwKcVkzdjCQs912F1Le1dzgjCPISF5SfMxSc5sOjusoJW2n+iQ7eIX/ttk56+nJBxbtRxY3kWzsmsO9cMVUs4TucCSLuTStjuodbtriMb1UwZFGmwpK80z1waFx7U27qhpc5x2ddPsH7U95ceMKlY92lXRKzOsZefSBas2E/B36lXDpauM0ThTvguLa9I87CbFl7WK0YQvfjqxMH/oHu0FN7EANdMq2WVywSLmtp4V94RpIE9KPULmWT0bPIkMVsqA/DNcmJLtvi5Bt0hXmZR5NjNI/o9hB4HfnDdE1oCoOqh6bdZQOzPSWg1sGKKhgvsjrNao7unqGcO+gxhEETL1+L7gGilFD+A9ywSfv1byXiseTMKMLo1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(71200400001)(45080400002)(54906003)(66556008)(66946007)(110136005)(5660300002)(2906002)(4326008)(6506007)(53546011)(66476007)(26005)(76116006)(8676002)(66446008)(55016002)(64756008)(52536014)(9686003)(966005)(33656002)(83380400001)(478600001)(8936002)(316002)(186003)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?sBB7TXSNnX1WJtgbsgiABgH5rXiCdpCVKG7DVEPX/72eqr5Qe9LyCQlSIE?=
 =?iso-8859-1?Q?GHXlrauqPR4eFzRb3XWOviPNf+7g6berYYoF9A6rrZMUlIG/3Kzeo//1wr?=
 =?iso-8859-1?Q?MvB+Xl9oxdJYF1XQL3WjMotdu5noHvvCdIMRjh/V6i18U4WiLwJwNtcwoR?=
 =?iso-8859-1?Q?xpq+1ZTgJz8p210InzpS0srk2J5dBBiXXyE0MybDiC4HivEad6fHiTLv9m?=
 =?iso-8859-1?Q?nfAFY7C66aURtrl4ksVdwuCsuwydUVTtH63CGVdUvzATKpe8UeBSYK0RjZ?=
 =?iso-8859-1?Q?3AknuaeWIjZzVEbWcUFStBYNo6XzuV1ucXcszXpxy3pCK20S3imRYru/02?=
 =?iso-8859-1?Q?pMsDhzWWGMENuczTC6lF5EfIIyo0Wm/Q3UXwUzYwegFbYxXWekh7CNmmGw?=
 =?iso-8859-1?Q?kOtrb2sA/OHh7HIyHb4Z4JBSnEI+d9mw/QARffYgLLuC5N9gr9HtD8o+Fj?=
 =?iso-8859-1?Q?lMu1isnewNO/EigAqGe0gUlxK/xTwkr+78SpmzDvS6saKcMdsUO9THZR56?=
 =?iso-8859-1?Q?/C7AgroR0s3PBFaUtcUGhCM1hiaRMCO+HmdsbPKOeiHwXOUyVbIz2Vb/l5?=
 =?iso-8859-1?Q?ohY6Gr5qJSlyt6y6gJqnzP5cB4qVAt02/lcggQMdBweOPOu0R7yauvkmOI?=
 =?iso-8859-1?Q?fexNAAP35OIUKbGsq9EkIhvecH3ziiHxQcRcXtlulqKDug/SpfFgf7mglD?=
 =?iso-8859-1?Q?MHDSbQcREgTVGGKGBlpoIneQGiFfQ3wwbbObadHrG1+0QQEWaq1g7LN47e?=
 =?iso-8859-1?Q?eupcXJiJxodyO4MQX5SbwcG9twdTEehFTBb4t4WeXuTb3OiNdobd4rs2yb?=
 =?iso-8859-1?Q?Oe5ZnzV2rT03SSbD1yKXhsBZUi560xRjyntCmwPBPpkzHiUiBXHvXM30+F?=
 =?iso-8859-1?Q?IJUJk8BvfMCjrCXzjQn0ZGr7upIWKeKURJ2uR+XAZ/zANMg3SQGK66F/jj?=
 =?iso-8859-1?Q?AQdtPVKjUkmniyY0CXMggQWhwk9pBN3WwvWJgleyZgfKpEojf0V+HUof5B?=
 =?iso-8859-1?Q?O0GDIK6QUbK82QVDgYaWz50TLzQ+xGXfsL5yd3fkzqz7QZlw+A+ooNVFI1?=
 =?iso-8859-1?Q?i37Jmk0VhJGj4delHyRKjqVZHYZHRKowYFDNpLVK3avxZGZfV0aKYFQBec?=
 =?iso-8859-1?Q?hOCXwKVN8YneEjwKOstlh2TBgt7GLif5RfoXeK1lUELoH4sYdbrRfejGdV?=
 =?iso-8859-1?Q?3k3m6p+49x9L1UmsNTA0tIII3GwJwV2Bg1TVKDJNl8dMj3ATjPTP3R8q/4?=
 =?iso-8859-1?Q?Trok8SoIwfiSXLCFzXLxjZkWXlRsjwuaXanm4Xn3GkprluhQJOabv8NcAd?=
 =?iso-8859-1?Q?Vf/IdJfMqKyxVkPUQvxqaKUaUhHtX1LxODD0DbR3hxy1yNk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcb4c33-8ca4-482d-d58f-08d8ca2508b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 22:26:07.8875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgp177sF0gUF4MZyLT1WRrauBIUS+CKAL/J27tO1EEbWAt/34MFykf3eYUHK8FYqCcaIPhAlVtrs521BxNlDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
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

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on an AMD RX6800 on the following display types (via DP):
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also using a MST hub at 2x 4k 30hz on both systems.


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
Sent: February 5, 2021 5:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/11] DC Patches Feb 5, 2021

This version brings along following fixes:
    - Fix error handling in dc/dcn10/dcn10_hw_sequencer_debug.c
    - DIO Supported for virtual displays
    - memset dmub_rb_cmd to 0 which fixes issues talking with firmware
    - fix 64bit division issue on 32bit OS
    - move edp sink present detection to hw init to fix hang
    - reverts a patch that caused 3x4K60 displays over MST
      with DSC enabled to not light up

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.51

Aric Cyr (1):
  drm/amd/display: 3.2.122

Dale Zhao (1):
  drm/amd/display: fix type mismatch error for return variable

Derek Lai (1):
  drm/amd/display: Add DIG_CLOCK_PATTERN in the transmitter control

Eric Yang (1):
  drm/amd/display: move edp sink present detection to hw init

Fangzhi Zuo (1):
  drm/amd/display: Add return code instead of boolean for future use

Jun Lei (1):
  drm/amd/display: revert support for DID2.0 dsc passthrough

Lang Yu (1):
  drm/amd/display: fix 64bit division issue on 32bit OS

Qingqing Zhuo (1):
  drm/amd/display: DP HDCP Compliance 1A-08/09 tests fail

Wesley Chalmers (1):
  drm/amd/display: DIO Supported for virtual displays

Wyatt Wood (1):
  drm/amd/display: Initialize dmub_rb_cmd unions to 0

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  8 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 40 ++++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  7 ++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 -
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 +-  drivers/gpu/drm/amd=
/display/dc/dce/dmub_abm.c |  3 ++  .../drm/amd/display/dc/dce/dmub_hw_lock=
_mgr.c |  3 +-  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  6 ++-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c | 15 +++++++  .../amd/displa=
y/dc/dcn10/dcn10_link_encoder.h | 11 +++++  .../amd/display/dc/dcn20/dcn20_=
link_encoder.c |  2 +-  .../drm/amd/display/dc/dcn20/dcn20_resource.c |  5 =
++-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  4 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  7 ++--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  7 ++--
 .../dc/dml/dcn21/display_mode_vba_21.c        |  7 ++--
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../amd/display/dc/dml/display_mode_structs.h |  1 +  .../drm/amd/display/=
dc/dml/display_mode_vba.c |  2 +  .../drm/amd/display/dc/dml/display_mode_v=
ba.h |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 29 +++++---------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 29 ++++++++++++--
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  2 +
 27 files changed, 135 insertions(+), 69 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C433a80a665d74bdbbe1b08d8ca21d1dd%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637481593899259151%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DXLPWh0rjpuIMRc9z4KqPZzgDFSHGASRiwAnvO1dcr%2B4%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1642C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 22:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377F822BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 22:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377F822BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8395B6E4AD;
	Fri, 15 Jan 2021 22:36:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3F36E4AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 22:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpI/kZlpckP38l/gxkPTv1x+7fuxheTY6Ene3l6MjBXpumATB7P51TqsRiGaVIDyWkNHaNUcwcYK/55jiIz9q4siiovqVT2xGYAFYmSj1X4Grw5lVaeboO9Ad4Wl7Rcgs7U46aOzQJBdRnx7+BH1IqokiBqZ1tUUWz8ijh3JNnsu2IKaFbefu1lbSpbGrXe82SwemlXMDD+gzE8pdiCTW5fzaBJPc1IQq607yEPWryRnQ0N9GfrZ5hO9RVIlXt37TcLB+H0slsD88MDn+Jk5XVKr1PXg8+OyWmfSXe0brMP+PkoixpL+kGUDYi3Hgc7FnDFJADN07xlouuCNLsWt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7SWBK6YxfxW8sSrk9imQ0ufu6M1Xwm0pJuPmzfouYQ=;
 b=Ja6Pf1SPa+BVLsD0Y/FihmAMiOLxJtGPLCNDu5991slUGxpmIKo3nyCtamk1AEa0tD1vxYTorhiGhi86BnLRShVeDUEWaLyB54SWj95UG6aB5vRMNhOc4JI8EBelxBlgM7wqb34dWClFESKS2ucFsUKcJg8SX772aUbTotvmeJFIAxIJ6oWUhgzVmj2hfgqHBb3SL5pKY4SmWBwUHn8OVXf0e0rRLg8+TLa+CeWgV+4vxy9xTBq8rRjECFLb779MFQoBFkDaAtEmDKHTbUTjg1u1cF1WpcSMz9XKFDQZo8YBEb5FhsSpN3vVDnCJs59oQBa/mn91PacuuFS0xR7TGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7SWBK6YxfxW8sSrk9imQ0ufu6M1Xwm0pJuPmzfouYQ=;
 b=08m2ENrb01NQqDbz7QiQis4oreClwjFzMqBMNavTj2c+Hmn9k+yy0bnlDvlKN2A9b0L6nc8NXI6LQio5Dtzx+sEjrOLj1Au3MfI7x7Sw/866jmzNboyqIUqCmIfXnwZyFuW1sIs5dEPDYVPOffxmtEs9VV656bKix7afpromeOI=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Fri, 15 Jan
 2021 22:36:35 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8%4]) with mapi id 15.20.3763.012; Fri, 15 Jan 2021
 22:36:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] DC Patches January 15, 2020
Thread-Topic: [PATCH 00/16] DC Patches January 15, 2020
Thread-Index: AQHW62PFy4Io1k7Fnku9+qGu9IT9RKopQjXg
Date: Fri, 15 Jan 2021 22:36:35 +0000
Message-ID: <BN7PR12MB28332C0C3EE8AAB6411FDC6D9CA70@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T22:36:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=653033e8-b831-4d81-bac9-291f00067df7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76068442-2aae-4585-eb17-08d8b9a603c8
x-ms-traffictypediagnostic: BN7PR12MB2738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2738CA8370A6552FF10588CB9CA70@BN7PR12MB2738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X54vh0/fk6TyZHsxug7uAPX15I0xG06mVv1b5rW56t6pLCFbTF90W5reJH85aJqh/uS4H63OZebt8rQXZTBhdG2LfGhjjpBUgO9WhbvbfdhdLnjDiJ74OTqe9ffcKm35wrYTxerabaFr8C+wEbFx8YY0G+ztbcdiq3INpCM5R0FUxdJyiHci/+yQUMoDYVgtmey8/jzxt8Wer879SGLAG+uSjYBOVi/dUta6pTyVdf2AwdmQ0qVRADvrmkWY8IOEqSJhxZN73dfjzhHX6m/RpEnqq513nwPQLREExcNXZnDo1G6udgZR89TPeCLpqtyY3KloY5Z8F0mZPlgMRnisV8A4RJ0gb245PBSoTr6h0LIaEEnQvJDcPsd/6w8a7/cDyoM4rwrq9w2Xf/TlepR/kAAQ7WEgNaAvVp85EwHTfYU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(966005)(76116006)(9686003)(66476007)(86362001)(71200400001)(66556008)(110136005)(45080400002)(64756008)(66446008)(55016002)(66946007)(7696005)(8936002)(33656002)(83380400001)(186003)(26005)(5660300002)(52536014)(4326008)(53546011)(478600001)(54906003)(2906002)(8676002)(6506007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Vaml5D9bug9q+CWYayr1G9CX23x/WNaZNWBK2yHbIPLnJZISW/TYwUt+dh?=
 =?iso-8859-1?Q?pKKPs/z6ZbM8dgx78poxEyCwaxnXH1ugzdz3raNVW6H3HBeS6k5aUBdPc9?=
 =?iso-8859-1?Q?X+tXPEfCWLry7C/2qs0Ubbne6ms771xCwf5h0HVt7T4QTjc3D7xQ0dE2vY?=
 =?iso-8859-1?Q?Lw1QfK33xa+mgPNTXCwugQ6CpOHbUyK6xpmYIFSMIXBulFjunv7G+m+rjX?=
 =?iso-8859-1?Q?NErUUnwNMZ/vvHv0BHYDWoXH7LttCrbajcA47wXrdH+Jx6y0RE1qhAo+8h?=
 =?iso-8859-1?Q?cq7v3AIUNwAG8LmxGoiCkAHwBVl3W+S8R7Eg1JGnOs3GJ6x86YWSd/6Zw9?=
 =?iso-8859-1?Q?PNmfZwPJY2zH95Q2HJkLhXkxFoSR569/Lw9689acsFgSMl7A/QIoIB+IUa?=
 =?iso-8859-1?Q?8EfeEHkSG/JW+1kdkjAl77cVW2azRUjaKJndhRl8YZCsW9/3Ka8lkzgQf8?=
 =?iso-8859-1?Q?TTDW5GS2ZTJ1w9ZkC8z9Aq1QSTKxMu9JFRBs1XbPAOfLTBQ3odsJa2ZQfI?=
 =?iso-8859-1?Q?8oEZpjV32KVzbFwiQNZ0XNb5Br+1Zb0nmsxAm5c9sIuzb7VEtZ65/xLl06?=
 =?iso-8859-1?Q?cjTItQ89KP6iaBsm0rLsnsQNxTlUwraKF9XzAJJ30dcsWaPetfJM5yB0y6?=
 =?iso-8859-1?Q?7TvJ2x1nFcZ0ZfBpWpHZCiScosMIk3KjRnYin1YQ7u+IHOrXPfEBbOKZp+?=
 =?iso-8859-1?Q?zjcsyTVWGYSlttHH0blEfqHgrXIT1z2nQshOrLaTQqeq152DE2O9cpNHxG?=
 =?iso-8859-1?Q?4UQ4ZrBH/S3yortzHYIzNpX/KRaB1pOBrwwCv1VHWKtOxhSnwxiMg7pAHk?=
 =?iso-8859-1?Q?BoPpM1klK0JGLarcqVYRd8Dl6Rnkg7rY98clkXNXpwsEI8NnsBH1058hvt?=
 =?iso-8859-1?Q?iVB2tseL8fsH0ipM1QI52kCwYpSsRKlqPeJ1viX0SO34t37ZuuP+6/R0jm?=
 =?iso-8859-1?Q?zZJ9JPPRBKUIaNdgilMjzGnVpoog6NJ9wEC4ltGTWGPPYZSzy28ABBP3m/?=
 =?iso-8859-1?Q?SbuZ1L5M9zuPDZvH8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76068442-2aae-4585-eb17-08d8b9a603c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 22:36:35.0974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hNzJYkESpbkP4/Uq+lJ85OVy33Amb2OO1f2MS6XTHxm+EL5hM5L1chOHggcGaPT1I27MxzEgG03uvEHZ32DaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2738
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

I tested this patch on Navi10 and a Renoir laptop (HP Envy 360 with Ryzen 5=
 4500U). =


Tested the laptop with its internal 1080p display and externally with USB-C=
 to DP, USB-C to HDMI, USB- C to VGA, and USB-C to DVI to 2x 4k60 displays,=
 1x 1440p 144hz display, and one 1680x1050 display. Also tested using an MS=
T hub with 1x 4k30 and 1x1440p 1444hz. =


I did note a headless boot issue with Navi10 that I hadn't tested before, a=
nd some HDCP issues on Renoir that don't affect it's functionality.

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
Sent: January 15, 2021 12:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/16] DC Patches January 15, 2020

This DC patchset brings improvements in multiple areas. =


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.48

Aric Cyr (2):
  drm/amd/display: Allow PSTATE chnage when no displays are enabled
  drm/amd/display: 3.2.119

Bing Guo (2):
  drm/amd/display: Change function decide_dp_link_settings to avoid
    infinite looping
  drm/amd/display: Fix dml20v2_ModeSupportAndSystemConfigurationFull()
    to check DesiredBPP.

George Shen (1):
  drm/amd/display: Log link/connector info provided in BIOS object table

Jake Wang (1):
  drm/amd/display: Update dram_clock_change_latency for DCN2.1

Mike Hsieh (1):
  drm/amd/display: disable FEC while using eDP

Nicholas Kazlauskas (4):
  drm/amd/display: Use hardware sequencer functions for PG control
  drm/amd/display: Allow dmub srv hardware reset before HW init
  drm/amd/display: Guard against NULL pointer deref when get_i2c_info
    fails
  drm/amd/display: Fix reset sequence with driver direct DMCUB fw load

Stylon Wang (1):
  drm/amd/display: Report Freesync to vrr_range debugfs entry in DRM

Sung Lee (1):
  drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case

Vladimir Stempen (1):
  drm/amd/display: Fixed corruptions on HPDRX link loss restore

Wyatt Wood (1):
  drm/amd/display: Allow dmu_stg to support cached inbox for dmub

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  28 ++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   6 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  18 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   7 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 117 ++++++++++++------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 15 files changed, 171 insertions(+), 65 deletions(-)

-- =

2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cb065e874864344b4d28d08d8b97ae6b6%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637463284804293550%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DrFljM2OjzTVFZyXGFdGBV1gq5MHrXvcTHMCpoj2jpac%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

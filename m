Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEAC48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F260FF2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 18:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5F260FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D47E6EA6C;
	Fri, 18 Jun 2021 18:39:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F206EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 18:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmTmTEb72OyRXLPDWWdopZCQhk0NKxcUj2djcT2TcXdSXkvvdU1L8YSnrZtnA3sw8p47A3QFAklk61dWSsKtX+elSq9nb/2aiGXLT8H01k6pjxYQAZxkiwKKut3E3b23XjNZDeEe7VPOFp4EFlem1MNnEIFq/TbicRPnVlYkCoqDK4pn/Z0qBdMWvnnd4qSeXs2ZRDB/iBKbau4UHDu8c6zUrU1TREXbvn5jtkjhDEuByRW1SxQOlP27F84PlDbP9Vf83Ipfq5/okIAMCVK47/F1Y83HgbLFzIjTFYj61g57hFTVhAWWkJR0gqMVK3UezWw6tC8aS+k4uNO+mjcPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMRecMLy9VAQnIYSR/yOCbn3Rk8lwIYzkNxquiBycOM=;
 b=N6oLspcXKp+sds3S5xrY5FDySLip2SQ1TAKefsXM2DBSs3mKgQ6TA1aASB9Lo0Nd0Pz3fKIuGj4LbyuRROa4r0Xx0M5/s9FbNR3beHtaakrVzCZTV8LpSsYN22aYpjAJpk3BrOxqSowcD/eRVzjv53iJxjtywMT+cMdHiG5iR5x52ciTV3J3ndeUaRTMnGcYQ4pK9kgUklnbWo2Pz86ylxsSiYloSui0g5KFCa2Pvph0IYtAYmTzTrgFBY/X3oo0sRDO4dIyjaFXEBry1ivzzVbEYEjUfw2f+TqfR/hHOdG6K62PqWMes7GfP45xoZ6LXGVQLY1ysBU03PIRBOtEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMRecMLy9VAQnIYSR/yOCbn3Rk8lwIYzkNxquiBycOM=;
 b=m9LCfMUzJtp2+AXM76H6sjcpPLKF5kO/nEo4ezf9KTt/K/pi0e6kJzFuscgeP680BnorMeLPZF/zsBicfSzWpSw8fxy2y4BFJREfGhU1Q9gvVC2QIU3i3xDI8gJVpLZAXlgwOHqRXuTp0Bi4NORQxxIXFjWlWlDxTfWlBhLWKCM=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 18:39:57 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 18:39:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "R, Bindu" <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] June, 21, 2021
Thread-Topic: [PATCH 00/12] June, 21, 2021
Thread-Index: AQHXZGhYr4iAeS2+VE2k5WWl/B4FTKsaGcyg
Date: Fri, 18 Jun 2021 18:39:57 +0000
Message-ID: <DM6PR12MB35296BE51EFC2FCAAE869B0B9C0D9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-18T18:39:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=14649d61-746a-4aee-be8d-41557d255420;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.68.110.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 640dcf66-755a-4b5f-163d-08d9328878bb
x-ms-traffictypediagnostic: DM5PR1201MB0092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00924AD91684019C73A1DF469C0D9@DM5PR1201MB0092.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjaJu1ayVvwtxaDSHBHBGDl0O5TSH8EyJ+T18LEq5Kd6EPKhVmSFEM0GdZx2bWovb31w0Lj9HTJ9uMzyHbF5eBhcqU/DFFUSYFWe6PEsY+juDbdekKHjTWxzHZEL+jmPUpunSlqoHi0beJYK12plpEKIisO4kVE0nyhnVLM1x1vsRQ0N2vW2RPqIKUomiRlotW0WIBFbZGikPKDp+aUuTWqa1O5tQyzdQq4671Q1pxxosdiqjqRIU1T2WY0pq8rIsQdbuwTdH4opKH3ynLNdxdDIYSpcIjjCQhnAz7adWEScRNMlMPJ1llRyQmObOlYAIUNQQfOa1Ozh2R6uL3WhoMpT48aQMPkRc229avBfH8RHhduEseZbG78D9h68Nn9hMh4umckPLc5n6eTZE1hxjulARz7a/yDNx8xSALywSx4Oq0Abn00FuBGiI8WulM9fDtxXLwiC1MxvvHZ33k5qa946fyknRUHTd5NcNc8pwn+gmugKvib+kJ1GaADTmE1ONEG3Qg8WDCUXWQfjyUwqNjS65yPeLF/IvxKYBILD68C2XorHO7clpYBKXUd0FUXOZdFvKgVuBMtR4+i7vwddc770b1rmJPrhHPZICQlE3e2Y1M44RBaSM+O7Nq7f/f3Hbivfeh4EQfQMxLcSgPxxTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(38100700002)(478600001)(83380400001)(8676002)(52536014)(54906003)(8936002)(110136005)(66446008)(66476007)(66556008)(966005)(5660300002)(53546011)(316002)(6506007)(45080400002)(4326008)(122000001)(9686003)(76116006)(26005)(66946007)(33656002)(64756008)(186003)(7696005)(55016002)(2906002)(71200400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z/iFJoO5ebLzVf/5IPSXeN/pUxiyo9wEmz6sibXLjtOpEU8HdIvYrvs/fL?=
 =?iso-8859-1?Q?mBsS5afeR+IWpjy7WYb+cLEtrzDpCFkHr0AlUGXrsT2FJvwFmJVcgz/utB?=
 =?iso-8859-1?Q?7siS6iLElaafEjCW/sr+MnKw8xUvo1mDKvXtQwuxmttJpCmwlJ1lyNQ0+G?=
 =?iso-8859-1?Q?6o6CP4PoFnXGfX9YTF+ec/VE9VdEN6k4ScrCr8TFHHsnY7pyakn6fa60NF?=
 =?iso-8859-1?Q?bYF0fLZ8E5Rc1R2stuGLKtPGxifRVXrIEcPpzmlW8/opJ98JFHoLwP5yHN?=
 =?iso-8859-1?Q?9f6Yi6SGJbFQTmqf0mWpOBTtEkO8rKXbLcFBxgd8fmiGV/8xc3x9xeiTEc?=
 =?iso-8859-1?Q?NZfNXfOBKElmBzSotQRYvE8a6eQH7kUr0+fVsAQ05ohqZUTcoasy3djlcx?=
 =?iso-8859-1?Q?eqLG5UnwQfJqh4tYu+2Vhzhi56EbaR8WL7fbRU2Kqg9WwR7rPbGSO4ODj9?=
 =?iso-8859-1?Q?xABlcggGALWTnsVvw4p73Qr3JAEDCgbtKrKomO9ZuQ4cYodexign3N7jyV?=
 =?iso-8859-1?Q?2yV1wzeZcTXkcQNrxogMMYuxpsEUr+rRuIIPg2kPlkVhfxaNWU8NUPs927?=
 =?iso-8859-1?Q?XJoIIBMr4pJyRGZ0de4FAtpnL2MziwmKbu/tq96NCAEkyN2eFjIqHv2/St?=
 =?iso-8859-1?Q?ucSOQ33U5nQFAiqx48Zl+qIRu0JSrswVD7DEkeRo3X4cEHvj/ljv7e6be2?=
 =?iso-8859-1?Q?b9AD0uLYwtq+K3/5WA06DcjvCjZHRBGX1MMgJAxQ7O+Zjkug1slGYG3GyB?=
 =?iso-8859-1?Q?pAByDzSSf/n10YhF2i9dQm2K46ts9SQzmqKoNK8mGw7D80L/c4yhZvrmVM?=
 =?iso-8859-1?Q?4ES8+ozvO7QGvulnlimNUh1UTPthRoo2WGM5tnBZdZLUKwKJxvUI0QaDuL?=
 =?iso-8859-1?Q?oVY6ObLY7ZLiE6qbn5yBLZJe0tj1ZHmO6rsVoufmvazB5eLu/24AevCndL?=
 =?iso-8859-1?Q?GKVeq6u8BT6PlIGC/ReBvnV9FnbDjyhl5XfIs/gWDQBG1D6Whbqvg5/t1X?=
 =?iso-8859-1?Q?Tnh3wt0Wf5dWZO7h88wC3SJsWx1SVh5T3sRV6jbMV9fB/UKt6Y3QdpQ7YS?=
 =?iso-8859-1?Q?7fcIw00CGL4hQBEOtam2gRZxAZYSus2H5uhw+vXgWYrxlBGx2TcfkC00Md?=
 =?iso-8859-1?Q?0rBAibvVJ9gnYKfR/RMZKB3d5bhXLbUhSYEqY8OikOBlS1TFuX/yM4T9qn?=
 =?iso-8859-1?Q?f3/B3nRTzCUSj6LVb3rLOYfS63s6mKWfuZo/h5T0Fb7AN/akdYw7JyFQgK?=
 =?iso-8859-1?Q?PPWBfLFVElJOzrS5iJEEOAJ4mVsFHYz9djKK4AC99u6A9BWHyIa/HcipnV?=
 =?iso-8859-1?Q?XuxUYq60TOosG1PtLLgP9S60Nio8TefKTtLbUenqwfOqB3as50OsYNbTJS?=
 =?iso-8859-1?Q?5m9+XgNibF?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640dcf66-755a-4b5f-163d-08d9328878bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 18:39:57.1444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NevPC8pxCWUY9uA5QgwtnbBzQepDx8csJSSMJa2uDrewDI7WKXnmWWw5YouwTf0I4jpZiR1sCS7ERUYvaeQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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

[Public]

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
AMD Ryzen 9 5900H, with the following display types: eDP 1080p 60hz, 4k 60h=
z  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60=
hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems.
=A0
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bindu Ra=
mamurthy
Sent: June 18, 2021 1:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/12] June, 21, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC 3.2.141
* Firmware release 0.0.71
* Improvements across LTTPR, edp initialization, DML calculations,
  VBIOS for dcn302 and dcn303 etc.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.71

Aric Cyr (2):
  drm/amd/display: Multiplane cursor position incorrect when plane
    rotated
  drm/amd/display: 3.2.141
  This version brings along following fixes:
	- FW release 0.0.71.
	- get socBB from VBIOS for dcn302 and dcn303.
	- refclk from MICROSECOND_TIME_BASE_DIV HW register.
	- Clear lane settings after LTTPRs have been trained.
	- Clamp VStartup value at DML calculations.

Aurabindo Pillai (1):
  drm/amd/display: get socBB from VBIOS for dcn302 and dcn303

Charlene Liu (1):
  drm/amd/display: get refclk from MICROSECOND_TIME_BASE_DIV HW register

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Martin Tsai (1):
  drm/amd/display: Clear lane settings after LTTPRs have been trained

Nikola Cornij (1):
  drm/amd/display: Clamp VStartup value at DML calculations time

Roman Li (1):
  drm/amd/display: Delay PSR entry

Stylon Wang (1):
  drm/amd/display: Revert "Guard ASSR with internal display flag"

Wesley Chalmers (1):
  drm/amd/display: Fix incorrect variable name

ollogush (1):
  drm/amd/display: Fix edp_bootup_bl_level initialization issue

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++-  .../gpu/drm/amd/di=
splay/amdgpu_dm/amdgpu_dm.h |  2 +  .../drm/amd/display/amdgpu_dm/amdgpu_dm=
_psr.h |  3 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-  .../gpu/drm/amd/dis=
play/dc/core/dc_link_dp.c  | 66 +++++---------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   | 13 ++-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |  3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 15 +++-
 .../amd/display/dc/dcn302/dcn302_resource.c   | 20 +++++
 .../amd/display/dc/dcn303/dcn303_resource.c   | 20 +++++
 .../dc/dml/dcn31/display_mode_vba_31.c        |  4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 90 ++++++++++++++++++-
 15 files changed, 197 insertions(+), 57 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Ca309462e10d641ec36f308d9327f79a4%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637596345349689067%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DqX9J3g2j%2B%2FzJ8ZTp8Z7cY57N49S2S3KI5NRw7RMYXkM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FCC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 18:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA5D60551
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 18:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA5D60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1C86E0EF;
	Fri,  7 May 2021 18:11:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB736E0EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 18:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KODSXOkybQmPU3h0YEPueqpJYliZ4j0oSfI6kVchB+ojOgHlxwibTLw/kmaPmHsowpyf5pNY4ZUXkErLXv1HllHESIafninFmvxSmESIe/DuAtdQAMI5zHrwxMGTMb6ugDWZfBffcLWbj7La3pYJ2VfsHVC1xtQ/QIkRd6gVYe41KJp8WqjNXP21HXQUdUZJdogvFB8pTHREtSuiJQ7RbiRt1lNZZn72QJ2vmyArD1KkkrfTmPSILEO44wl32d+nmXGy/g4PRA1+nUhbyuf4RcCmzCi+eyop+P6AfRPX4EogA+UPn4cUcGY7Z4xu5PX1iQs9Kc0KbafXQh38j4iHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D2TBV+PV5Pc24+TISdMCiJ2HQbHStRqn9AVyYDxTyE=;
 b=Nq8HYNF4lbfDcEJRRigDyPGCksNzpNMDvb0Atqtx7Xo3huzCvealPWPTdL9T5Ql/xo4PTxM53AOWSk4eOqFLZ2iHvZTw1EuiXgHUmTy2pfEiHTTzKLw33pG68s84r8bvCHTtoFq+xzXOUCSrrsj5bk4Zy5F0G5WIKhq5Nf2Zt4mKNsUkJ5t5hYgFn1HJ3IQ3itdXeShMvMlXqDsyAT1w+P5B22tU/EsR1Yy43TA3ua4ktWS/tL+FHyMjbDA5p8H7UeM4DLgm4uLIt5P4RubkFXzPODsgVsnKXRocQg1YJc0K9WLLwRHHFmgqm/cFGzVdqj4CtvI3zO+Wb4dQOgUdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D2TBV+PV5Pc24+TISdMCiJ2HQbHStRqn9AVyYDxTyE=;
 b=iB3ug7RKFOQNn8BR/iEY38iNQMyGx82+Zlxrg6Bqw7bGySriLAgSvnyyFdb0e4RS5Kt26az6x61flYoIp++wux78QBwWRQISgKyb7ItkelqOm0FZRsH7fuRPdzp2NeI3zrh+zjfQgwwfcKKyObHXSTPO8W5xRbThwVcgFtr5Wpo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 18:11:01 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 18:11:01 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches May 10, 2021
Thread-Topic: [PATCH 00/14] DC Patches May 10, 2021
Thread-Index: AQHXQ1GCncPFPDUBY0KZFo69yHqhdqrYUegw
Date: Fri, 7 May 2021 18:11:01 +0000
Message-ID: <DM6PR12MB3529C6BCC628CCC2F444F4489C579@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-07T18:10:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7fc3e9c7-4d79-45ac-b575-b0365aa139bc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a23ae7a0-de38-430d-5ab6-08d9118378af
x-ms-traffictypediagnostic: DM6PR12MB3529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3529D263A59517EEBA58FDD69C579@DM6PR12MB3529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VIK/gIrw3Sj910nVi6RUxxUO8TojPv+xaErIXnd0ZgvVB7eD+iE9x6HcS760nHj/3AXwodu0ucynIWGIxL7GmGunC3hm+D/yirNhnbo7uOUNcgf3QiC9tu3ki5/0+S7cLXqjbACC1z3IC82DLwy+l2YObMoyygyfJAkvdDP5Po8tnzm5vDPpiyRmXH1X1wEe2ZQsTTXwxZMdBZGRm6LluLjt3+JZCMAHxdgRgW6QjGCr5UwLlZ0gQXzCl5nlJi3FQLH/pl5JO+vdTiQbCl4IvXC9/cMUQ0yJf2KAhDSggpW0Jk9YyLrp9FXHc9u6oWelTvD6Ihpbz+fX/Lhb//fVCxHZcUsS3QJF/jJ2IbkdU4qHxC1s6BK93YW5W71RwbZrSjusOOrlQ1PbGuM3ZfrZoE6QTE4KY7FAHoVVgjfxEaTVBx4YdTZRrENQCpDN5QLXjzyLzFHl3fEqEAF2rLZuLuoxHjMbnQYNOYtwdAUH3o0d8lY42UjtWbwDZDK4bpZrzIs1ErNmo8ULYVWkHiBFYJH3YPPjg7jtz/5Z4/iX9X/VGJQttj8C721LomHFflaH3bqptCNM0x0eV/XmxMQCSVq/ANDYTuHKM0frvES6DW8ZAiEv03ZosbToxEjqNzPhX7MWSQCz1WaHZvcejSYzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(38100700002)(6506007)(52536014)(478600001)(53546011)(83380400001)(64756008)(66476007)(86362001)(66446008)(186003)(26005)(122000001)(66946007)(45080400002)(966005)(5660300002)(8936002)(9686003)(33656002)(316002)(66556008)(2906002)(4326008)(7696005)(110136005)(55016002)(71200400001)(54906003)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?hMgpLub32EscmvN2rhXmg5IVENK/WyMkMGvF+Z0QQEY6whDOTsVR3PzwgV?=
 =?iso-8859-1?Q?WzuZjtsg5x7drAr4wZRlYsjSkCfyvmkqdyvzwANlRZiIUNIjPeDEmQeGum?=
 =?iso-8859-1?Q?74BqhGVsbR4j44WnTOXz2UFpni8N3v6WDZzucW2PZNw6UYf/ndHRppTEZH?=
 =?iso-8859-1?Q?9D1jTJbFhbDH/8TQzScWVoXCurJjQcOUibxJItu6yXpXN2Ft2ZmP/lxJ11?=
 =?iso-8859-1?Q?NTtCs1oaKwz5BhStwF/IAN6cylkGQObg1M1exCPP3YWigt3/gR7/OXrVAy?=
 =?iso-8859-1?Q?9gYplAUszL9LzEvgS/97Kd5U3nP90zHfYDmvPt/eN5fRDkjvH8xrap/oR0?=
 =?iso-8859-1?Q?oioDsrlBHq4aIIZn+x/VqDhTl8Y3PQu1c5T+1/DnRfEK5a56FOc0R3GVJ4?=
 =?iso-8859-1?Q?7VrCp1sh+3J2K6S4zuEMG6k5cpsC3UzRl7diFdmpdV+WcX1WB+KwNWjGSJ?=
 =?iso-8859-1?Q?pP8MOx+RJ18O3L6jDQg5GttQf05gKriH2Yp8ORdh18B6ZC57hZm5Ajsu+x?=
 =?iso-8859-1?Q?w51Np5U9zWolAjNQzhKqnTz+wqeiar9fN6NSDeWwCtTyCb7rrB3IO3cv+n?=
 =?iso-8859-1?Q?AhoZzXBKcvbAkVagowNGgNjb7RK3RYA0MvHxv8g0/iCIvqssKZkEKINfgh?=
 =?iso-8859-1?Q?sMqUEIet3XfuCVRrZGdy2SQYuJgJpXZAnvIZR0iIFHFPblCUwVXwZRAYdi?=
 =?iso-8859-1?Q?H5Jy5KdXdYnccdWZ3Tm+uH/vSqaPbj/o7UOP4NL5mi6VD/6x2kZ+j1lQJR?=
 =?iso-8859-1?Q?JHSQ6n0v1cirLmmnGdE+JXhw3Z+b9y0uo0IRRH5LwMrrcdZ9bZP+VlYr5Q?=
 =?iso-8859-1?Q?loba4JKZgChwodRPL4jDU5neYe/B8Nz3WeMrZcCaZt1FN0cHDgJ47stpgx?=
 =?iso-8859-1?Q?R0IG2SU8QQSWtASBtwQUFLB3r2wzPjy3imkvCZ5g0GUqooQLKZGFc5cWYe?=
 =?iso-8859-1?Q?PAIAda1g2553WpEfoi43I0+dCFCA5HuDgUF34SpsUFYlAXsozCNuCsfEcB?=
 =?iso-8859-1?Q?9E1gq8F6eZYtEQsjcMY4KJVZ2fvIB3znvh1HqPYCQOVuvdWzTgizcRxEvT?=
 =?iso-8859-1?Q?KzPNW6jUb9P/0EWMZdC9k9Txfe642v5rPN/p1EG5ifYLmED7qtxIMQgnww?=
 =?iso-8859-1?Q?o6ag8AecJ1D01jArA0kgDcE4Sc4t/tebDrXyLzCKxl+PrQLoG5/k5iPXkk?=
 =?iso-8859-1?Q?3K/q0DOu04QU0ynokEo0jC/43/yQXkE4ENq4aB0k/qnEfwoGoxYi6D1KQr?=
 =?iso-8859-1?Q?r0enez4PKPzvhB7EwPenggBEz9fTth0T9VMDBGLb/aS9sgxP72ZJi6eLa8?=
 =?iso-8859-1?Q?gbpsSejdw+bhd+WP3TEpTFkx1U1HEl3fiDwaZN0PkbcduQBmEpCh4IEisC?=
 =?iso-8859-1?Q?KMrdcLBFkU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23ae7a0-de38-430d-5ab6-08d9118378af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 18:11:01.1512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6bTnW54pYHlF1R6x429M/Mn/To6NATMqhxkOp+6R62bXoBYq/ovu820R6fg0Zl1LAPUE75/dPqSZwrqmZDZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Brol,
 Eryk" <Eryk.Brol@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
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
=A0
This week this patchset was tested on the following systems:

HP Envy 360, with Ryzen 5 4500U, on the following display types: eDP 1080p =
60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), =
1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT on the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 on the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz on all syste=
ms.
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stylon W=
ang
Sent: May 7, 2021 10:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Brol, Eryk <Eryk.Brol@am=
d.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wen=
tland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <=
Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aura=
bindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd=
.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/14] DC Patches May 10, 2021

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.135.1
* Improvements across DP, DPP, clock management, pixel formats

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.65

Anthony Wang (1):
  drm/amd/display: Handle potential dpp_inst mismatch with pipe_idx

Aric Cyr (2):
  drm/amd/display: 3.2.135
  drm/amd/display: 3.2.135.1

Chaitanya Dhere (1):
  drm/amd/display: DETBufferSizeInKbyte variable type modifications

Dmytro Laktyushkin (1):
  drm/amd/display: fix use_max_lb flag for 420 pixel formats

Fangzhi Zuo (1):
  drm/amd/display: Add dc log for DP SST DSC enable/disable

Ilya Bakoulin (2):
  drm/amd/display: Fix clock table filling logic
  drm/amd/display: Handle pixel format test request

Jimmy Kizito (4):
  drm/amd/display: Update DPRX detection.
  drm/amd/display: Update setting of DP training parameters.
  drm/amd/display: Add fallback and abort paths for DP link training.
  drm/amd/display: Expand DP module training API.

Wenjing Liu (1):
  drm/amd/display: minor dp link training refactor

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  86 ++++---  drivers/gpu/d=
rm/amd/display/dc/core/dc_link.c |  49 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 211 ++++++++++++------  ..=
./drm/amd/display/dc/core/dc_link_enc_cfg.c |  22 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   7 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   9 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  33 ++-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  26 +--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  26 +--
 .../dc/dml/dcn21/display_mode_vba_21.c        |  58 ++---
 .../dc/dml/dcn30/display_mode_vba_30.c        |  48 ++--
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |  14 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 123 +++++++++-
 .../amd/display/include/link_service_types.h  |   8 +
 22 files changed, 525 insertions(+), 230 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C9ec96aa8589e4c0fd3ed08d91168a357%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637559963391150266%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DPLlUpyhDx28WCzqtbiy3361vSUALhAKIJ0P6jQVI0HA%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

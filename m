Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E94C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 17:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C20613C0
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 17:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C20613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438A66E145;
	Thu,  1 Apr 2021 17:31:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AF46E145
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 17:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQJff7h9JzmyR5YC8qvIzemSuuxMoGkuaT69ved5Fa1v4BxSx+H54ZEa5KNXkrFCTSeutygJAXQtD5RzObdTKYCMX/lh2dvgPTekgb04T6l4t95JK89dj9uewOg5TUAra8lZ2lO1Y+F8Q+YdFZBG3CnpFQe/jVLETVBtA4lfZUtKHP/cV7k9UvYzKi80CvV6XjgD6tnyihxfbWrU7cW1trjWDz1jnDDvZ/3y5dn3Bxl6+SLwsabUqpHSkN+yvX6IZEKncC2hFBG88yhqqjCGdbdUdTdJVUu5UXbLSVXz0wzfB2auUm9GmLBnsCfRZIT4n52VFZuWzBgA36oWmjKX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+X1jxEkY4mGw3ii4TMWrmwQcddSSjIgbGMeaBW9g00=;
 b=EnXI3R7j9D0tu2h99c4yYsIcoC9jEmin6q3100fa/J4A5Uq7YK415qG724oFSuk1MkVRboWH9cpazlt7Hur4hblp+r5xgBNE9vUcvn+B4phGG/+OUDc2zyHYM6a87DNU7ODhC1iimjtw4spwsLiIRRE2FUDYIEBHwqUnS0hqw6ucirMXPTRojOkKbstXYxMJJAVPP5ew7z0yZ8LF0eN39Z7AdEEMFvg2fgXRxuM3VwcVtyr9kBGLN7XICTo3cLJM1tGyO0LVjEzX06+aECJSzEHwCEN1SytddxtFfwHRXcwgtWrqHo8d7hWoiyEkEUXhdaPGzW3Lg8v04X9WLbkI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+X1jxEkY4mGw3ii4TMWrmwQcddSSjIgbGMeaBW9g00=;
 b=ktAKHanFbh3hrFIXzxHZZF2bPerzg360MdVzeVFCfsySOY/N75eDhB4zJhSWlNexyFrVCu+sarIxfIFN+HrZZt4mOWm0FHbtff8ADZy6l74tM1TyuzGE+0El5YGLSwBswOyeuGQq5uCv3+jngKdvgWG0ypWqz4yVRIXERF6e68k=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 17:31:50 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 17:31:50 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches April 5, 2021
Thread-Topic: [PATCH 00/21] DC Patches April 5, 2021
Thread-Index: AQHXJxZ/LvzCnA5ftki9qU0784rlXaqf64ug
Date: Thu, 1 Apr 2021 17:31:50 +0000
Message-ID: <DM6PR12MB35295C9C57F9CBEF5DFE3C9B9C7B9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-01T17:31:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0e09c55b-b0b0-4817-abcc-b4ef3140b6c5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.68.130.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27fb65ff-e89d-4548-d509-08d8f53408b9
x-ms-traffictypediagnostic: DM5PR12MB2456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2456E3ECA363004CA1DD9C759C7B9@DM5PR12MB2456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uz1b8PlbUjCvpSAUtLfs44CGNkak6Y3qAmQrERoiSHlpyiWRy/a1/S5Va6+l5rXWY7e/WSb1KLGLvp6lyHIUTTsvmJTFVQAy58rCr3Y0Mcuq8D9CphccLN3EUX1jfljICNTDTfylupeTnLsXhU1fMJ6mrSWOPmiUaQ2eV6CgOBX/VcHMy9KYymv5nsK3B4XLh1oHpQi9ZTOm0hVFWEMIOZc8Jl+9ya1Nnyl1TPJf84mqornoJz0qDwhc6L5O1DRrU+SAnIl7zjzGuhP/l+6YO7AcaeNfL9LjA4eUACHSjmCR9cF+puPMkbMO+YIybQdIgW8k5WjR1TZQ30ocuR4X/swQh+3Q7t8yciHx3my38ijeFYwrFHisZ+ofi0Ro5pp0JGxyjSfUdLCbjJgsKpD1liO38yjGmUMSpti6YjoQU6yGwV+Jaz3s3N5dq2hyzeNeR2VBfXpah2j8GRBYwubZy2Uq1Ifms7LH3Q5eMVHS9TPzmKr+PUbSFphoRG0GKLpQ0KafO13qYODRAH+CueoEBLiVEuHFwkI+ky323YgKKul4tGfOkktuxYjN17WQBVyxIMT69PL5hd9+RtR64hU5EeAdq+YIktQNSBhgXdVrPeg+lP2HeKh1/4rSntdNtiQOhQLhk+uYahsDY3IdIUEX2vAs6RQxI/CEU1N0NwabElCNjX4Bg3rpqBqMzAOikbGw1pXjBXh+n/SnphqImJ6bew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(64756008)(8676002)(66476007)(66556008)(5660300002)(186003)(33656002)(6506007)(86362001)(66446008)(53546011)(52536014)(316002)(478600001)(110136005)(55016002)(9686003)(54906003)(83380400001)(71200400001)(4326008)(7696005)(26005)(966005)(38100700001)(66946007)(76116006)(2906002)(8936002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ZL3bvtpNkbX2/bsHR3gTHNrGHTawDUeGUvaVjj4yC9K+LMbNWsrlUoH0Yq?=
 =?iso-8859-1?Q?kedjzQMrbXSxIGO3FlXkFksZUru6FX5LOTx/EmPTSNtLqdbxOqBYBqxi+T?=
 =?iso-8859-1?Q?K1yjkWeGAEW5hoLVqFPha6raMxn9+8LrJNo+bqsMSxhYmxehblQpJWeyzD?=
 =?iso-8859-1?Q?Jv6mCHuHtNdlCOX1tSEtbwgjmJ1o/LUiFio0Z+98YvM7c5npiE/UGk2idj?=
 =?iso-8859-1?Q?r5k0VmX0AtZ+ZjNgeAJtdbBpEQtM5+5XSSwSNMZjDPNIo49Wiew4/QoRRj?=
 =?iso-8859-1?Q?5YQOBLx6fQkNHWSv+w1ALZ4+/GaMdRFbu7wxh7RZ/0vOE1H18lM1J4BSVg?=
 =?iso-8859-1?Q?UdWn+TKZ3uXs2j+lwUhUSRmFlX6WZARLpB4HDCUu3XYY/px3tSxFgTIS3R?=
 =?iso-8859-1?Q?elc9cA9ld8FYKR21KSUF0ucFNlYJNcinq1RBOiJvtZ8LrhUi/IKS4+s6yg?=
 =?iso-8859-1?Q?WJteBeSsXuodzRLuYFqk9CqQE4eocs6zIKBdYU9gSNogPtXnVFZXo9PxGL?=
 =?iso-8859-1?Q?18WNnBX6wA8bg26oRxVMZ9r7XEcaR5LNprPOppCPf2twkPXHod7WFdkzz3?=
 =?iso-8859-1?Q?F4OD9hd2MQ2f+vAU0ClyUxvpd++ZkgOHQ2gfr6NuJQpo28RAnjysSxDn7Q?=
 =?iso-8859-1?Q?e04k3YhdB36MhfmI8GYOw5L5xjzZhzBSFXMO4iOgsQZ1VzrOgIVk+RQVew?=
 =?iso-8859-1?Q?WPjOs9M/adHau3Q4hBgwkWqSw1gYkd5ycCR5yo5lo83QjukgOy0Ngjg8ea?=
 =?iso-8859-1?Q?xiSvarBzmJIZGKOm/fDdaTvWtplHaUp1QhbHKShKyTOsIugRGkEz9sivU2?=
 =?iso-8859-1?Q?cJqzTlL9mL8tl5RrBwI9WCE+J7mWoArv6OD0JK5K0GsARKgz7ZLKYPbuSr?=
 =?iso-8859-1?Q?H9yolzvXxechO/BCu0Hnp7hKQCAgBGrLDoAJPZHf9kW1SeLgeN5BLSEngJ?=
 =?iso-8859-1?Q?wN57K9Y1VoEgI1osbp+/bAhGby58AD8H+PthDT43a+YyN2zE7zVRkLQP9o?=
 =?iso-8859-1?Q?hd/FT88qRo7hviDyKKFbqWDxkxhgzmDdNxWpa3V6vgZuCCItOhL3NW7ivX?=
 =?iso-8859-1?Q?5EJ0lvbzc8w655WGeA9sB4jvhW+AlQY8NLx2GUH76k0oEiUYDp6ouNshIr?=
 =?iso-8859-1?Q?st84xiusvnUC6r0bKqUqy09L16CMdBMNug9KM40/CalxOCsn+z/Ror31yy?=
 =?iso-8859-1?Q?FOvbut8u91FLO8ktn9pe01mpNLlDY+t7t4S5fcebkUkcsbqBvLXRtE/xwr?=
 =?iso-8859-1?Q?2mSKSmOAdpejPXFbbhlqOTSMxej3owdLlM+xN39GUuqVGiBBm116eVjmeB?=
 =?iso-8859-1?Q?XlUuITSCCoQX9lEuqYdpvxrHu5tn50JRPGlZE3dBHIDgN2nk/l1YR1Tfb3?=
 =?iso-8859-1?Q?Y2nJPOpQjc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fb65ff-e89d-4548-d509-08d8f53408b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 17:31:50.5106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sw4QM2bwXmnW89qsOh4YhFFrohaVqIeHwxsIWAqiEat24+CcolRxEXVmFYD6fKdpKWaqLiAxK9iRfqdrwAxuuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
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


Tested using a MST hub at 2x 4k 30hz on all systems.

Tested by Dan Wheeler <daniel.wheeler@amd.com>

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: April 1, 2021 12:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <=
Bindu.R@amd.com>
Subject: [PATCH 00/21] DC Patches April 5, 2021

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Firmware release 0.0.59
* Fixes on display experiences for 4k TVs, register mask missing, etc.
* Enhancements on MST, code cleaning and debug messages.

---

Anson Jacob (1):
  drm/amd/display: Fix 32 bit compilation of dmub_srv.c

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.59

Aric Cyr (1):
  drm/amd/display: 3.2.130

Aurabindo Pillai (1):
  drm/amd/display: Add debugfs entry for LTTPR register status

David (Dingchen) Zhang (1):
  drm/amd/display: use MST downstream AUX to dump DPRX CRCs

Harry VanZyllDeJong (1):
  drm/amd/display: Fixed corruption on 4K tvs

Harry Wentland (2):
  drm/amd/display: Add debug prints for SMU messages
  drm/amd/display: Add dc_debug flag to disable min fclk

Jake Wang (1):
  drm/amd/display: Added dc_edp_id_count to dc_context

Leo Li (1):
  drm/amd/display: Move vupdate keepout programming from DCN20 to DCN10

Mikita Lipski (4):
  drm/amd/display: Set initial value to a divider
  drm/amd/display: Directly retrain link from debugfs
  drm/amd/display: Add MST capability to trigger_hotplug interface
  drm/amd/display: Determine synchronization edge based on master's
    vsync

Nicholas Kazlauskas (1):
  drm/amd/display: Cleanup DML DSC input bpc validation

Qingqing Zhuo (1):
  drm/amd/display: Add missing mask for DCN3

Robin Singh (1):
  drm/amd/display: add NULL check to avoid kernel crash in DC.

Victor Lu (1):
  drm/amd/display: Add function and debugfs to dump DCC_EN bit

Wayne Lin (1):
  drm/amd/display: Tweak the kernel doc for crc_rd_wrk

Wyatt Wood (2):
  drm/amd/display: Retry getting PSR state if command times out
  drm/amd/display: Add delay in dmub_srv_send_gpint_command

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 207 +++++++++++++++++-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  29 ++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  29 ++-  .../amd/display/d=
c/dcn10/dcn10_hw_sequencer.c |  16 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  16 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   3 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  16 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   3 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   3 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   3 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../drm/amd/display/dc/dml/display_mode_lib.c |   2 +-
 .../amd/display/dc/dml/display_mode_structs.h |   4 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |   4 +-
 32 files changed, 364 insertions(+), 71 deletions(-)

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C84c9e134049d4e1f021508d8f52da0a9%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637528923620041029%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D4Sg%2Byv5%2BEdqOLHP0Rulb94nfeyZBvEeIlGZb0DjzaCY%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

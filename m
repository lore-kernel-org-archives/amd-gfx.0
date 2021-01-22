Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55A4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 22:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB0420684
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 22:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F926EA68;
	Fri, 22 Jan 2021 22:37:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29F86EA68
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 22:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJgJ+HadtR2B/6XWgSvUuldCCVonpjhSR4lJrSLGQJUQI/Z1xh0mOzQuDmKTvTJZdyETAq7W6FTRrSmPcYZqxidFtoLDYKvW0cPIMrbKaAbz7SiM3g+m6RmT0k4uTa0FXaBQYFd3nqGGajInFCzl15tk1A7q3z3XeFXTZx9yJ/vc5ypD+60oYflCtMbDRLl+Z80nLdiAREOvny6ymUE+Qn78cRvTwFolAphfE8SsEt8wcfz3KIVA9AnVAizDOvJ/ZPAP4ttHUB//WwuuIzIRvl2oiqCdH8RbkQhjVmutmwW1eaPQhyR724g+uS4+vW1HU8IVjVlOLYWMdGsO6axLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBmwz522TSEWVUvX9CfpIic771xOYTswegVgDSAq+VY=;
 b=WDiIYYWaGs1mdAziXn9mh2R40Y3bNtnStE/DDTyIjfT+fhbeZvzx1mR3E6F0PDhmXkQlc81u+m7bbtI9coyFmxwb9aYzqRW6MDpzcGvaoCpvOj1VCSl/PAAT1JqQECHBNQO80AdRIFysGkz9HTTd69Rx2WVZOuzzm4rpyF/HPM/pVdoB8D1n/B2b8fium479C3/uOddeqPBFAKfi2lFqHle3ckVEgow6AYb3R1RdzZfX1G0pqUuByYpLJ5z0GlVpvYBfKyt7/0HRwVV0CoRTK940B06tVFqhEh2nppDwb1ZDfGg+UkRtumgfMjZVDxFANaCio/ZuwlDASUTQflU8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBmwz522TSEWVUvX9CfpIic771xOYTswegVgDSAq+VY=;
 b=IxeIuUfSwt+24BmDyd+Of9KH++jw6Ndt7zp1n273SU09xjbW9CzRdSwi2MvKd0Cr9DCBJTYuEjh2dvOYuml4M34Cu5bU6hgRFE/Gll6bmVOFBLKoSxvj28IV6bNUFdf/b9gU+WChz16zNn9Lv97/WqpVCoEkv3OiPRZqDAodNaI=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 22:37:46 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::ac26:e595:45b9:42b8%4]) with mapi id 15.20.3763.012; Fri, 22 Jan 2021
 22:37:46 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Jacob, Anson"
 <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/12] DC Patches Jan 22, 2021
Thread-Topic: [PATCH 00/12] DC Patches Jan 22, 2021
Thread-Index: AQHW8PopX/M0KLljn0q8QhDW6248TKo0ObwwgAACVdA=
Date: Fri, 22 Jan 2021 22:37:46 +0000
Message-ID: <BN7PR12MB2833171B3846AAABDD4AC6909CA00@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
 <BN7PR12MB28334DD1E14595F2C964EB8C9CA00@BN7PR12MB2833.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB28334DD1E14595F2C964EB8C9CA00@BN7PR12MB2833.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-22T22:37:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=04fc67f4-9336-4c1a-ace6-11ef7b0bd7ea;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [24.235.164.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8adf5f30-6ca6-4783-db98-08d8bf2656ec
x-ms-traffictypediagnostic: BN6PR1201MB0018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB00187ADAF07781C260B494E79CA09@BN6PR1201MB0018.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wj+/zI7GWGrTgqeTaPb/m5PkaFm0bFRU4aef7ZqGlx303LC+bY4GRRcZCBnPLi6PVZ+cNep0iuYAjHNp2XVENLuS4yj8Kk+NT1ErZ0eIDQTPE1g6KHNtWmjN+M9jfrmd3gp8PwpPU0dCLd+GynkdkOWaMYsZn5o+q3x5UW3/45ftcxy+QDww+FU8B006FMqmgoLKO7ydGdDYGPhOQGNHd4YiIUpZ5ZL2nDG3vsf1PSykpIpSXGVaxJUusipPtlpeBrX46Wtg7FpEToYiony/CCy62jbYJXLYPX3T7XfhQfFy8VSWion0j0DTy3FIWGu6DoQQIoKgvvAEwASYlQ9wv9fziDnE8AwsH1oP/OIG3Zj0TXK193FDiyN5DJnKbm8sLkchH5N3SCBRwm0AQUGi+AhGpRr0IRSEEqDTWGLbMag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(7696005)(86362001)(8676002)(64756008)(66946007)(66446008)(33656002)(5660300002)(52536014)(71200400001)(9686003)(186003)(55016002)(2906002)(66476007)(66556008)(76116006)(6506007)(45080400002)(53546011)(26005)(110136005)(8936002)(478600001)(2940100002)(83380400001)(54906003)(966005)(316002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?oIv7V7mkxuZYcjM58obk20f1TKQaYwdGqNTrkv4M48dHILdXm2i2TOmN2O?=
 =?iso-8859-1?Q?KfmQVwg81JnTBgwGLUQKM24y8NiTE6OGQmvGDP0gJFU3upZ/X9etEosU9q?=
 =?iso-8859-1?Q?v8XLZOXcIC0fIzT6pwt1colfQpkyS3Nj5vwpFclO5cL40dokvQ//6GyHNh?=
 =?iso-8859-1?Q?vBMdF+8RDP2T6tt+aFvcS4Ho8X10mooUOx0uoatRXq/agIrajAtHDseBrB?=
 =?iso-8859-1?Q?6g4MzwAerBo6rvy55/xAJ3en0bIM5XmWhVgRFMLLGWisjdiqgRsQVzveEo?=
 =?iso-8859-1?Q?zvpEOjNJv3nKuvh1JOClvwA/hjP0JRL6+jasDQu2k/0wVbTdX70ZxK0qOx?=
 =?iso-8859-1?Q?5SDU8P+H1fjvQQvcIWSEpr29ZcNGHqNPsqSxrz2LzPj5hnQVQV18XP2Yqn?=
 =?iso-8859-1?Q?KfBp/eAtlUmzkcc/054TLHguvTSRoYlCM9ZryFtPRAdyVurhhVF7AgOpB1?=
 =?iso-8859-1?Q?QVdeeA+r/arTe9PVmY4P/2lyaHwnftTJOUN0ZYn7CbaQigbPOnEQwhbiyo?=
 =?iso-8859-1?Q?bMn1BPrr2FjTpnqVJ+WwgI3uDmriRCf/RWqpKs1CBWWvCjQDcFSD7tJjqA?=
 =?iso-8859-1?Q?FjGo+ir/3s4MpJagvfhQD68aclUAl4uy06FXolYcAj4t8Z/6lan37P10xs?=
 =?iso-8859-1?Q?7tI7mQbT9eA4OPTp4bgra3LUL5ZHcfIXBqKNDdQGvDM1iYhGy2ICaTA2Jy?=
 =?iso-8859-1?Q?/qaS1CArgSB/doHrHgkuLinSVhUS4KN4cdKOyx+1zuz2/aF44NCNr6tY6X?=
 =?iso-8859-1?Q?5wmlbtT03tajrkdFKMdwrujmy1VWa9xHBWHx6tmnlfsLApXNGptQDsBJEY?=
 =?iso-8859-1?Q?xtFi8fDVy71F9Pp43jhg4KL2YnRXv9UNowM7CCyxbLUIp/ldNfY/3yquM7?=
 =?iso-8859-1?Q?4DB9eh9CYMFPuzhFYijAsKrI91EVLBXL8R1XImcJB77yPNDVdPkw6ndSAG?=
 =?iso-8859-1?Q?aJn9B4ZlMcGM3B3KX4seLp2nSDuuPFLjazfdy4sBIyVyUQxsnkoED9Yy/j?=
 =?iso-8859-1?Q?kRg/LZlYEn91NYMjKreRLxNwQYcCDWVJZglMkCV17ovixwWV5ga2qci09E?=
 =?iso-8859-1?Q?cy9MFqf6vuQatq6vxvM6vi2v+of+XKM5utW0pQJ4EV9g?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf5f30-6ca6-4783-db98-08d8bf2656ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 22:37:46.0151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McpR+//zJwAfqk8NcgVhqgOqCtXc6krI+4BHjmAdsGLfyI4kKE4F/108Log6PxKwDIHTQP2ozQ11f1mrN+5KBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Disregard the tested by portion. Forgot to remove it from my email template=
, sorry for the confusion. =


To confirm, please do not apply this patch set.

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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wheeler,=
 Daniel
Sent: January 22, 2021 5:33 PM
To: Jacob, Anson <Anson.Jacob@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Zhuo, Qingqing <Qingqing.=
Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <=
Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wentlan=
d, Harry <Harry.Wentland@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: RE: [PATCH 00/12] DC Patches Jan 22, 2021

[AMD Public Use]

Hi all,

This week I tested on an AMD Radeon RX 6800, and a HP Envy 360 with an AMD =
Ryzen 5 4500U APU. This week we are not recommending a promotion due to mul=
tiple visual impacts with MST.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6 Facebook=A0|=A0=A0Twitter=A0|=
=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: January 22, 2021 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/12] DC Patches Jan 22, 2021

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix display detection on HDMI ComboPHY
* FiX PWL backlight calculations
* Drop SOC bounding box hookup
* Fix DPCD values
* Reverted a change that caused memory leak after sleep(S3) state
  on 4K HDMI displays

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.49
  drm/amd/display: fix calculation for the pwl backlight curve

Aric Cyr (1):
  drm/amd/display: 3.2.120

Bhawanpreet Lakha (1):
  drm/amd/display: reuse current context instead of recreating one

Brendan Steve Leder (1):
  drm/amd/display: initialize i2c speed if not initialized in
    dcnxxx__resource.c

George Shen (1):
  drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Lewis Huang (1):
  drm/amd/display: Set power gated default to true in seamless boot pipe

Michael Strauss (1):
  drm/amd/display: Add null pointer check to is_dig_enabled func

Nicholas Kazlauskas (1):
  drm/amd/display: Drop SOC bounding box hookup in DM/DC

Stylon Wang (1):
  drm/amd/display: revert "drm/amd/display: Fix EDID parsing after
    resume from suspend"

Sung Lee (1):
  drm/amd/display: Add more Clock Sources to DCN2.1

Wenjing Liu (1):
  drm/amd/display: correct some hdcp variable naming

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  30 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   7 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  32 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  14 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 111 ------------------  ..=
./drm/amd/display/dc/dcn21/dcn21_resource.c |  10 ++  .../drm/amd/display/d=
c/dcn30/dcn30_resource.c | 107 +----------------
 .../amd/display/dc/dcn301/dcn301_resource.c   | 107 +----------------
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 19 files changed, 80 insertions(+), 381 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C26e5de69949f479b003608d8bf25bd55%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637469516133833459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D8IaBqOjVlehR0vNvG3btImdlR2%2FM6pt1IniAgLW2Q88%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C26e5de69949f479b003608d8bf25bd55%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637469516133833459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D8IaBqOjVlehR0vNvG3btImdlR2%2FM6pt1IniAgLW2Q88%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

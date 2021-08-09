Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33994C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 13:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4386101D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 13:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF4386101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6990989A61;
	Mon,  9 Aug 2021 13:20:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1998989A61
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 13:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmXz2S4Vtm1U2AaiF4TgA4QaJwEoGX1IsvdeoALDsBzUFH6eotNPW6+l0CA5RpvjPe2n65J1X6dGa7T/vdRb1Yq6MwMhoQ5l9euMV6SW/V8Lwj02m9HuMfvgsOd+KlVvreaU/nKSUaXWV28EEya3O4c60Jbqn5o/2jQoawuOrgRiLu0IY7csSFEAfHTOHFsyjxDOTZHK2TBivua5ffr7NNPuPZJnDegGq4rC+yhLgv/PQUJm4BFWQHp0dlYFaN69Pvv+0kkt3bX1Eh0iwNowbAk2Th1xzAYICRSoNSnRq3MoQUaJxE3mcuJDSRT0ET9SEKcyBMu5Kypz0kNGEaqD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVHFvQb3iwkutl4q6gyzNeyto/H4dta4LFVgspH9RTo=;
 b=aMrY1ew/X+du9rwLtX/lw/i31BkDwsHIXb2wQpCbzt7dPtaVK1ngxaVMaPHkePXlDf0hLuHAfpXckcxhP72kWXa/h5BID98Qri7aFGU/vefwmX2CTh0mXNz3pAaqUWb/Vu2UriB1bXfJzGTWWc3MVceDih3QIwCRM9Hdnhe7qAhHLEZxIzHMpJktkhb7mYz3fUwLpboAqcHo0ipGHfJtthIBgGp1xZ+QnpwyygJPfn+zsUMJY+tRyEfDVincp7U5Lk5GeRi9jkPQTsbBln+5FW01AiSPg8IlF2aRqy9SWBLeE3uk3nQzhtKKPu0GwYTc6MRP09GGDFYqvN98jAaX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVHFvQb3iwkutl4q6gyzNeyto/H4dta4LFVgspH9RTo=;
 b=LG7HoaNs5KNSTAeUcCxDY6xzKTyduAqow62xM41aXGWX0UznGZ+fNEtoDd4rSV1Jz6vx+gyuQI589e+hkd1FpK5VgtdHtorilGi6lMWN3UcPu8VfcoIdLSrpxKsv4kuAzR23i3pj9iobQHwn2ZlNwaajwyFOpMddnm1C6QmElos=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 13:19:57 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::8d7b:512f:dbbc:f7c4%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 13:19:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 "Eryk.Brol@amd.com" <Eryk.Brol@amd.com>, "R, Bindu" <Bindu.R@amd.com>,
 "Jacob, Anson" <Anson.Jacob@amd.com>
Subject: RE: [PATCH 00/13] DC Patches Aug 6, 2021
Thread-Topic: [PATCH 00/13] DC Patches Aug 6, 2021
Thread-Index: AQHXiuEeBpV+IfqBzkSVz0PTjM/pG6trLKNg
Date: Mon, 9 Aug 2021 13:19:57 +0000
Message-ID: <DM6PR12MB3529D450DBF9C3BBBEA967C99CF69@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-09T13:19:52Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=30cc6bfc-dc24-41cd-8f2f-4a191cf035e1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50d0850a-f2d7-43a0-9bb0-08d95b38622f
x-ms-traffictypediagnostic: DM6PR12MB4418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB441849A1043F3BF857BAEB2B9CF69@DM6PR12MB4418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9yrXYgdNBHrC2aNZmX4y4MxNC3pZadviqYfsv7zGLzwnAz75uBygiJDEy9qeyWVcGJJH5350v5LoGeIZlJezjcXUJgFfSq8VnJX+6v7NjUKRSqhBtFpow01P4IahwBtHALB4DxO4keLZq0qfjoDt+vta5OKSkbi52Q8qpLE1iAGGGtdxid6zmUrYb6AwGCzasTjmN8BNx+j9Z9JjNg7+1CSuuEtGibhEcEV9X4cCm//4buorcJs6AHLF0AIkQ+abOB8njkNCrdwNiud/kQ4zeMb2/HE85Z39YpkewooxhywIx4wDpTjg5pPS/pwD0JlE8mXB6k6Ck+1f0iA3DOBB5hxK2Svigj1pA3wAgJG2DKhgpuPLrxz3CCYpCJE1LW55Z+TLGyYAyszaPeo9cS5QLNmdR+IW5y+zNeqWgaCIxMD7JEd5V+cbEV2GWbkYameyrFrTGKYpbr8dKkXdDTXmYGzK9bxludw9DGvm50iUDiEo3P0WbXnbwpSwC8ew7y8YFBGw/L+dQOaU0EMPAA3DlXyYzpFWCElB8ZLwFOVNjQVF2kihXNo86rFP92rLmIwwRVZXlD16xGAmRPLiVnQgijbmjo/AFHk4855HyBNMxEiD9dnPJArHCDki+w95YESsAIm6imYxL2OysiVZSisBVus4hsziGplxJHnSqtvnVENQnBcPOpu4lwk7k2d3QJ1uzG6byoPfm+TAsEf+P2jZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(83380400001)(6506007)(53546011)(64756008)(122000001)(55016002)(66446008)(186003)(38100700002)(66476007)(71200400001)(76116006)(66946007)(66556008)(7696005)(33656002)(54906003)(9686003)(316002)(110136005)(4326008)(508600001)(8936002)(86362001)(52536014)(5660300002)(8676002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d0DvoZF5LyjcCTsuoSV94SrSCNIw1ks/Q463C3ytQ6tcJJyK3imvCOpO2V?=
 =?iso-8859-1?Q?+52pMBKWg7GxX4fcVMbwMk0VOS0gEP2AQqqlLauCYzwROtDoyfn5UoxWMv?=
 =?iso-8859-1?Q?fdWVjj5FffE+TEGwtQkSVQgLcoVTIgtu9yZiejjMluwnvAn+MIQtk8rt/i?=
 =?iso-8859-1?Q?hjnxDEuieOFuA1RCeF6S/ljR8l2S7A1H/7ze6H8HAvKqz9yNhkz/Lj9sC9?=
 =?iso-8859-1?Q?h5sQG7WbbwbGhm7hvp4Ljn4MOWxFCDXAIYYebd5n17a8c6LzlHO0MDhhla?=
 =?iso-8859-1?Q?0BKdq2c8f4HFVb+ATEa4JRRoL029tzp9ksM57vSZsseIkWXVEOkKdIhUto?=
 =?iso-8859-1?Q?lSxA7yApy6lKVFgvM/EhYUOcJ0Zxsz1BcNYuwm0VCgZHTug7LDPR8jiWtt?=
 =?iso-8859-1?Q?NFnd8csGF/rDymzR/izk/R3f1gLFMFJvpymPY5z0YxxmfVKtGlddwAm07e?=
 =?iso-8859-1?Q?4WZZ7Mhjk9moN2VOcFcsyyuWPdNg/XYxXS0R510tY2s7PrXu2J2eSbJqsK?=
 =?iso-8859-1?Q?9P/m56s2+nMI0Jae0skxcKog7/GKUoCRwD2eAZnif1Q/gXdIAFwG6N0nU5?=
 =?iso-8859-1?Q?hc3Sj/J+DaKhXpMgLOPYTWqBQpqrJ5ROiasG/Yu+UZSHkjVbh9M6MsQjq0?=
 =?iso-8859-1?Q?w91tzM6iu8rvd5vZd0ILSXbfIm2YX5k67mpk5nJj6ukqG4gvWtd7ztuyH3?=
 =?iso-8859-1?Q?UGSH3dSstViAOoZt3fMKzfW1AbZ7U0gcKkkuKz0HdzKCo/px+ap08kqfgw?=
 =?iso-8859-1?Q?y1hvTpSMZFHIqgFstMLHDLcMxgK3ToPgFOKHasbAULe1weXvc3ihdDHDcu?=
 =?iso-8859-1?Q?ndZwPsbphEM1kq2fDqAimLc5Foo0NXAM8KIjI2DeAt8sLqYqfEzL8xtMIw?=
 =?iso-8859-1?Q?heYM6jVC+vaLFRmppTyr0HRL22lTLAMqB1PncI8rFf3nIioYeG+BcCRJM2?=
 =?iso-8859-1?Q?1ciOtFp+T/pjMQS4mxR94m4b/KVKxWHedHLD5euuvqQhh/2cFoL7DxQ6DT?=
 =?iso-8859-1?Q?4MJpErR0MOIGhlTJkxFZlrJnlA3Qnqr8LNpsFtblaJGio2cjjOXmwT45jC?=
 =?iso-8859-1?Q?AQIvP6M+cEj4PExVxnmN1JpBKdJDAtKhJ6BcBzIOjZBsJBmyuL3uAcwxRd?=
 =?iso-8859-1?Q?fznhtj9MD1uMSc/DEfGrVMbzxh0qiNAWkLOpx5pG8NKvUgfOTdMJppVyGu?=
 =?iso-8859-1?Q?iYQhE+jSdY3Sjlft65mndz/7tJ3J0EP584UXW9Qp1XDVbkU9qJBXQJL0HE?=
 =?iso-8859-1?Q?kR775g18US8UuEbFWMWZSvuS3SgI4u7JkPOs0rHeujybU/pTl+rYBi4/eo?=
 =?iso-8859-1?Q?nv2P0kBVN2bKQqFUOClxV1883L9EskS/nZ964ViX90CQ9ow=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d0850a-f2d7-43a0-9bb0-08d95b38622f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 13:19:57.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWEb1h4Eyp64gneazIGvMwnFhJxqtczufPBVlz7I72vebyJLqfHNXDDP3jKpCdiW5V9Z3dnD7/yXjyLE3yvleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: August 6, 2021 12:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Eryk.Brol@amd.com; R, Bindu <Bind=
u.R@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>
Subject: [PATCH 00/13] DC Patches Aug 6, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- Fix memory allocation in dm IRQ context to use GFP_ATOMIC
- Increase timeout threshold for DMCUB reset
- Clear GPINT after DMCUB has reset
- Add AUX I2C tracing
- Fix code commenting style
- Some refactoring
- Remove invalid assert for ODM + MPC case

Anson Jacob (1):
  drm/amd/display: use GFP_ATOMIC in amdgpu_dm_irq_schedule_work

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.78
  drm/amd/display: 3.2.148

Ashley Thomas (1):
  drm/amd/display: Add AUX I2C tracing.

Eric Bernstein (1):
  drm/amd/display: Remove invalid assert for ODM + MPC case

Nicholas Kazlauskas (2):
  drm/amd/display: Clear GPINT after DMCUB has reset
  drm/amd/display: Increase timeout threshold for DMCUB reset

Roy Chan (5):
  drm/amd/display: fix missing writeback disablement if plane is removed
  drm/amd/display: refactor the codes to centralize the stream/pipe
    checking logic
  drm/amd/display: refactor the cursor programing codes
  drm/amd/display: fix incorrect CM/TF programming sequence in dwb
  drm/amd/display: Correct comment style

Wenjing Liu (1):
  drm/amd/display: add authentication_complete in hdcp output

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  62 ++++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 106 ++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 192 +++++++++++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |  90 +++++---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  12 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  18 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   8 +
 .../display/modules/hdcp/hdcp1_transition.c   |   8 +-
 .../display/modules/hdcp/hdcp2_transition.c   |   4 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |  74 +++++++
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |  72 -------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 18 files changed, 479 insertions(+), 198 deletions(-)

--=20
2.25.1

Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB23C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 21:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2538C6507A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 21:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538C6507A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45F96EC54;
	Fri,  5 Mar 2021 21:11:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616686EC53
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 21:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg6UTVPRh1UrtTbo9wCGos2oMOtNQ4UReHlDBYhwW5hMlOMT+JL1ovEfiFJNxQdoqdzB5ocSAqkj5V9msVgQwBkVm+LaPnnofH/QLJUt2YExkk8I4ZYJesDvRLU9nHUJCxX1fyUghdiFs1F7lyl9ixkS/29kzOpyVfqd+CAs6uQqeUmm3cIRZHlG/3GJpjTejwq9zmVUWNCTuB9FXGR/oC6GPxcJ4cjhN3Mj6jubaN5yNni4WrfO618DDbXqiROjtWAECRZ/2RsWN7C7q7maITTkXcyFmU1RQVRSArNVdQeq6r4z+/Jw2tXdXQPKh1L76WmkI2gJs/V+greNIZfLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJg4gqTDUgDPZ93E3L3P6sKFsly1fujEiVNynNvlooM=;
 b=RAcXhS6F4bwbX7yrCZpyELgnDNowoVYOFsOnWH2TajnsULRZ5KEdikP99UaqV1QW2qI5rvpNQKu55+VWw7nYQdAU2Y5UluF7VUtKw8vVPckaYJ/BZIUrEW58TQhTDpD182+ABURvBXzrg1YWQCU3vmX0yE5n+72o0ZSLYevLIIiwH0FrAwa2UYEicc9fXK8GPiUnJ3178DVsUOPvIR31q7M+OJJo7wxMlbi2H4w7gWhFmwDFzoiZJ9UZa/1a+GKtNM3CBLIMliYGVrzRJ8SujYvAkXNdI10JVHG8WE2vwVBmDVjuBTy5MmSZTeMZESWeSBrV5935ZMQzLw/uOGRoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJg4gqTDUgDPZ93E3L3P6sKFsly1fujEiVNynNvlooM=;
 b=t2XcH7snN+vZVuOSMbkENqvbtU3hCXtuHwiyzK67ryzyfOgJ81Dq68/heqZo41YvQZnWs2ycjTkc50DVEby+OeZvQHBX6f4a+kQuQ/V/0eH17pHcwCvSPdV2YL0zeKAcs+d+bc2HYprXTWwcYM5VyiVXFNrzyDAXgYk0xtiSMk0=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 21:11:34 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 21:11:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Brol, Eryk" <Eryk.Brol@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches March 8, 2021
Thread-Topic: [PATCH 00/14] DC Patches March 8, 2021
Thread-Index: AQHXEfqlPI6Sdyk90UywNBAfd5ZTOKp15BhQ
Date: Fri, 5 Mar 2021 21:11:34 +0000
Message-ID: <DM6PR12MB35290DE58BDEFA600A03E1949C969@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-05T21:11:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8d2f2b20-eb32-4912-9c4b-cc42f7806a9e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0323f2d-0ec4-41fd-2d0e-08d8e01b41d9
x-ms-traffictypediagnostic: DM5PR12MB2471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2471108C0AA85853194056D99C969@DM5PR12MB2471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6Ps3FPSJ2JCtgRfP4pwJ/nmKVnG9EccXg0PlkEEGEs4lXx3rN3fCQF5OIwjC7GvF5JtWgXC2eXRw4SGeHNdubhlOz5/Suei3gBXdhYjaTAL+KT3iC/nrAeKi2NXNd5Zwd7HtjfM4iClfj6neoXb7D9Fm568MerExI6UIiv7fHoeD18c3u48CCYaKIwYSAwvBrOVRwftYA6h5FiCvKV4YrKh7NNspfHq/sI0Z8k+vzMbkjJdUR9avrfLarIcMu4x37y86yiAG4rh3z/msjKp6bc4Wpti3VXotXi7cXgTEdy7HwR4wcnTfIdo9TM5GVHN2aZoZ/XgQW7quMD2RQTnZbxNib+CEkj8lxcinowgrlFNu5Eabl4M992TBkqny+4OVfUU3z/XiV6Dah4+iixwvKtGDSO5zzw2WQKlvTgRwCOLtqeEAQuRPAHGwReuaim0oBjqaJwfd1dAT57eCq1gmZAglpgv+Mz19im9Lwgbp+VoH+TANHRzPnxvpqFX7oE0Uv3oTgtM1nE4IvWZUsoaKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(33656002)(6506007)(4326008)(52536014)(53546011)(5660300002)(26005)(8936002)(186003)(71200400001)(110136005)(83380400001)(86362001)(9686003)(54906003)(2906002)(316002)(66476007)(66446008)(66946007)(55016002)(76116006)(64756008)(8676002)(66556008)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Q271BLe9AUisR7ggy8IujXucDvn6rsexh6IJ1zhkROy5kkyX+klz153MSn?=
 =?iso-8859-1?Q?gIKPCFfu5bVj/1HV6M+/T9iAIsteMOE7HrYVE4ua+osqCxOaDBzzT3491a?=
 =?iso-8859-1?Q?++QKLOKFG1+YQiu/1+MZ3T/phLYC/WxBKGbBCff5mWTbZZAa88fqkW3MLT?=
 =?iso-8859-1?Q?VqfgEImpqZ+4Jqxg0aFQ5C+Ka01bHm+cJZDEvR8miP2xJtjgfu5dRusHzL?=
 =?iso-8859-1?Q?YptOqE4FUjmf/1AAHX3XGMQW7aMOUhdPSSIFhHNDGwcVucz0SB0UhXDDLq?=
 =?iso-8859-1?Q?+/dW7yYuLoacGov6QUbxZi+ubK0sjSggOyJiDlwW3DGP3NdCgi1yLr8b7f?=
 =?iso-8859-1?Q?vXjp4AY4L7q8HfKiyZov+DSkZPhL1YNzO9vClsqKWHIOL1ujuWMTJMJI1R?=
 =?iso-8859-1?Q?yiZumkXaAmfUdmR/s5ZZUcGXyBw3FbrUYG+ygRWsFG34vCW+kpi9rmId9v?=
 =?iso-8859-1?Q?FQ5D1iVV91/flpIIqTJPrApVQxuA4dCGAWPuRx1OkNwm6q0ypoSpr6DBsf?=
 =?iso-8859-1?Q?TH2cfTguixEgK01uQRqfLMLieXETlu/uVtE8tIoDnRSN5CL3fiOPnt7YbE?=
 =?iso-8859-1?Q?uBPQVExety2THvLzNQ37QTBaG6/vkMUsObqngRghfF9vncm5xRlIf8yc5B?=
 =?iso-8859-1?Q?O1TkQr25Ti7zOuNlUDqNls3C2yntGcqtj6GOigyEyVILAe4zgID0sPOrr8?=
 =?iso-8859-1?Q?U/cCDmwT9houCa/xB0BXWDqQM/Jcn+6QAox8l2hpny8t/R7LSTjVNY73KF?=
 =?iso-8859-1?Q?SSGXOJKjvJCEs4ruloFJ+DOdpR2Jk8DIy+MZ2+sgowVdHq4dQUWxMSrDSm?=
 =?iso-8859-1?Q?ck+8PQL1jmwBZxF6sJ8hqlmN0CebfcPkW65lz/ncrHXYsJsRFkx4/jmh+l?=
 =?iso-8859-1?Q?Vkz6xTpcXt9XR0GOYsShkkqLuBCVvbiQ7sQFHso8UUWLxcBB+lXMjYh7nE?=
 =?iso-8859-1?Q?VpELCdrER/AVx7J1uagnkVyIN0GaiftuSWAIn7C/FA08P30ceB0aNQUSsz?=
 =?iso-8859-1?Q?sm3EgX9FXVA2O2NBGV26WoV/I9hSxmhIelGJ9HF47NUPyutbGDXB6NCCy9?=
 =?iso-8859-1?Q?Hpo41ccoiCA8BdAffAwFiuz1pR13I1obcFOEZqRIXG+gn1xVAt6DTrqAuZ?=
 =?iso-8859-1?Q?AnUZFJPZHn734ghTFT0M7RtXxDz7O05FeI8ccQtU/qOolvGExEwWb4fmYc?=
 =?iso-8859-1?Q?x8+05KdErZDqP/3upyQxXI7myuJJwpMPya2vFxnK/KjpWdIoyYMUOThtVb?=
 =?iso-8859-1?Q?pSJdoPkCBjqkiEvS1Hkj5465wTLlOgmsKTgtBsJDKz83mxMzC/DuVt4GTO?=
 =?iso-8859-1?Q?wOgz6fPGkoS1pnYoh1KMv/17C6S9WbajVOPvcfXrg0cCsOU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0323f2d-0ec4-41fd-2d0e-08d8e01b41d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 21:11:34.4966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1gTdPyZYTl7WHM4y23kyESif+oxuspib6thFv+LBR5KTY4QRJvYXGpeV99cM+7tz+ySjx2C2EJ1Jga8vGAC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
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
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
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
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: Eryk Brol <eryk.brol@amd.com> =

Sent: March 5, 2021 3:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; R=
, Bindu <Bindu.R@amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Brol, Eryk <=
Eryk.Brol@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches March 8, 2021

This DC patchset brings improvements in multiple areas.
In summary we highlight:
 =

* DMUB fixes
* Firmware relase 0.0.55
* Expanded dmub_cmd documentation
* Enhancements in DCN30

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.55

Aric Cyr (1):
  drm/amd/display: 3.2.126

Dillon Varone (1):
  drm/amd/display: Enabled pipe harvesting in dcn30

Jake Wang (1):
  drm/amd/display: Added multi instance support for panel control

Joshua Aberback (1):
  drm/amd/display: Align cursor cache address to 2KB

Martin Leung (2):
  drm/amd/display: Skip powerstate DC hw access if virtual dal
  drm/amd/display: Fix typo when retrieving dppclk from UEFI config

Qingqing Zhuo (2):
  drm/amd/display: Enable pflip interrupt upon pipe enable
  drm/amd/display: Fix warning

Sung Lee (1):
  drm/amd/display: Revert dram_clock_change_latency for DCN2.1

Yongqiang Sun (4):
  drm/amd/display: Move define from internal header to dmub_cmd.h
  drm/amd/display: Fix dmub trace event not update issue
  drm/amd/display: Read all the trace entry if it is not empty
  drm/amd/display: Fixed read/write pointer issue for get dmub trace

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  11 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   5 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  21 +-
 .../drm/amd/display/dc/bios/command_table2.h  |   3 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  17 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   6 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  31 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 846 +++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  25 +-
 27 files changed, 948 insertions(+), 84 deletions(-)

-- =

2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11014C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 13:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C486191B
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 13:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C486191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3F26E42A;
	Mon, 29 Mar 2021 13:45:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611D6E42A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 13:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3vuBFlHql2CkFvFGgEdysadfJ/T09i7KoOf9Nl2WcYT0rNrvdJ8mwr11E/NmxfRvOM/aou5BOdE5BVWmFLsLzrtmQSB9mVkFg0c0Zpz2td4U/Sf6M5P2HEOiFilKx8++u48N5IjRxSXBXo+CcdEUzcK9zyEDha4QrVdL+BXgcn04ZMRC4ED154Yoy7f9B8RxgmXhQDlHgTgZ0/c2SD1CthGFCVgJOFklzAiBZuw0CSQWKGPWr11b6fKL7CqFUBuTdrpYWUjXzALa/08oULjlToVS7CqD/T/wXRpQxH8CiKsgVzvbX+pRGrm27C+RxZme4oswIxutyL1SsUAd3Xk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZeQauOnwyC3Wsy2rMjRyxQCMdTsTHweznCwda4UCfA=;
 b=C304sBzsCznpBrlvR/PutGGVBYSreO0o699GHV1EGy8WBlw2XGqMTMlim2nhdpQg7w149w29mM+N9bPBhf/Y40LUuDyuPIXakMoVB01jVj3CqxO/y8P9vcivA7IVGjvMNZpbuQznj34AfQADlG2HiENXVd2182WutEqfLtiKI809DNYESoaD0nxj4WcBi1nw6XTHvLifNees08UfIDRt/0VsCO64uZbcRqKEaP4bRajw7YRpsmw6elJKnCHi0L4X1o9UVCiq+braracv8lFqIuEsvl8PAe/VpcMo/xcqKl0zBYpjhaQKbjw8INbs5t/vEBVYV8P3NZw8d+4sFtHANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZeQauOnwyC3Wsy2rMjRyxQCMdTsTHweznCwda4UCfA=;
 b=buftR/a54EgqIkG20Qg72tUv+UEDtM4rPnFJVEpdCw9gFir984XtQS92OmJuysAh6E4F4xcAuRdgDXAzR8O7iIcbekD0HIwifFJXkOW9GATvRFxCOBQcJt1UIpxv3I+q5vR/7wVcGqbHY7TCA6yzHioMZ+lPoodqkAPAxylvC8Y=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 13:45:34 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:45:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches March 26, 2021
Thread-Topic: [PATCH 00/21] DC Patches March 26, 2021
Thread-Index: AQHXIowsiTgmCNCSzUytBCdjQ7lNeaqa/fSA
Date: Mon, 29 Mar 2021 13:45:34 +0000
Message-ID: <DM6PR12MB3529B753DD6C5536162121D49C7E9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T13:45:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2b3aa2f7-b883-4d49-b7f5-26aea664d39a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daa56145-5b69-495a-3668-08d8f2b8ed59
x-ms-traffictypediagnostic: DM6PR12MB3164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31648AC7BFF048E45E5F86909C7E9@DM6PR12MB3164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qMfAMWDb3gDEjOI6l4Qm3Fdit6+ppGTwE7nGKGdPwjGCILwbpgPwm0CkwJVV6VfyOq5JLxY83Zuy4f1bU5kEWxsTw8E2lHg7scsy8otQx2JK5cWVuzS5+QNCZH79paD4wt3ctklv0eZAA/v3hUOj58NCZ55BNbb+RjjumCkGBEn/lxa7IVywahVzoMHfwq6MiiAZn6IhKZHP4xg3u8uc0s+LZ2vnmOEtzhv5fKBiOR2z3Yd/KGLcl6Pq5tS3rFICuMMChktddmVrs2t8o0Am7/cOpxdS9o1cMsihh4uvNl55ZfNjirkwcTnPjqlAhFsEnh8yPTjV1Uidf+8axpGuL/MV86JBhLMDCCa48BV/3JdtiuK6XxuMF15ZZQkAMgE/3s5Mnz6VnMvRvy0neE8t4NPtzh2rB6PmEKIK/pnvh/RJv1bAt23XpaMbd+pJ9QBY2hBgHJOAxtlBMiI9v9mrtytGrHLFIgbvd0clr0oeVjy0SBgMwpD+IGMkZ73mLhcV+pSoB9bWOrKpFFc6TZnvVhBQvDE/jtkQ0h+tUU+FprrD7Ggl4W1T+Gj/lGtJG6kuKNGN09NUmZp5KEIabNUwXukRL5T35FYbSRsfXxKXgj1Lz7BBuEo/NB1r7f/W9xSw6KSiMYb7VMSd7d2HqqvA8ukfriOZ3gRLR6LCrnS6rr4DfMPKIl/tcOuDbL9USzdr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(7696005)(4326008)(53546011)(186003)(26005)(8676002)(52536014)(6506007)(33656002)(71200400001)(86362001)(55016002)(966005)(66556008)(64756008)(66446008)(9686003)(66476007)(478600001)(110136005)(66946007)(76116006)(8936002)(45080400002)(54906003)(38100700001)(2906002)(5660300002)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RN/Ok4X5dYSLB0K8v3spRFL6drzgo0hi5MIGuF5Mup1j+eydSqm3GveBxP?=
 =?iso-8859-1?Q?CXGNQwOcbBZKxloo+y24Ud4U6nce8H5kAe850FO8J7B7hiucpXd7fzfjVA?=
 =?iso-8859-1?Q?X6j4KX+j/rUg/8tv0GLJfa4szx79UhE7X9a/a0K6+M6RPqhr1lZGTNqCho?=
 =?iso-8859-1?Q?Ygg02cn4ABWISdDxuhF5p+20GO8R4GNlef7BWMfNaIpcTPg9oLgUy3EG5Y?=
 =?iso-8859-1?Q?BBzBVcl2DpZqn2R/pV6YlgunYjxEfBrb11eIEvaUTBO0zuFS7NPDy/hVfp?=
 =?iso-8859-1?Q?+3yXvGzObFqVOKtRmSFS0vc8MoZIXZyQmLMIvPz+dBDF81iwMh8wwxENNI?=
 =?iso-8859-1?Q?Fn5F0aERpCKOgnf5id0eWBPRxaK/f9nF08QBgbb66j6BHOgQUXv5RxPe+G?=
 =?iso-8859-1?Q?f70/viyWJ+YRJ82DQMUe0yXM0bdE66GzpO86dWQXO4CrUjbvULXyfwxcow?=
 =?iso-8859-1?Q?q1HO4rb/NHwqGgp6Meru+9LQCAWM2Ho4DV3FgWgSSupFDFDHmDilsaRaOz?=
 =?iso-8859-1?Q?7FK0ijWK1JHNL3rm9df1r1zNZTLeHxvN3ZF3wzSZftgra96zCYfOUWXlyD?=
 =?iso-8859-1?Q?Rq6x62tJRdvPUVX/4DPD8A+sxoawEw3WIT5G0z6iHa9197CLKAnmfGWH1n?=
 =?iso-8859-1?Q?agXa6XHZRHrFhqJhUum+4Ke53TC8U6blor/rWA0N2YcIAl5YKI8IteCM0g?=
 =?iso-8859-1?Q?A3/coQL/DRJsKuOHvmSzrx2DfCx6faW0iDPwqkTnFyRiH4Uh4pkFGgxbju?=
 =?iso-8859-1?Q?nY/kIlCpG60GdUZYefWMV42yLH4B87Ce20oBQNSjsjizasKSEQoiH8ujbE?=
 =?iso-8859-1?Q?DXhyQWihr6ps9EzjNcZlYT9cYjNuM0nEy23LzW+eSLtVbtnYN5/W+bUU8C?=
 =?iso-8859-1?Q?1FdNcCSMOqIV8NtmeyfSM1cK2cuERGrc6B2A9pIX3Rn+wVxQOYEny9hTP4?=
 =?iso-8859-1?Q?u2ztc2UxSvzbH7Q+2tRjxwL36YCPE0EhwaJhb2MpkiXnmRBq+ImTR1FXB1?=
 =?iso-8859-1?Q?/Rsgy5EgBjzEa1hVeIEJG9dnT490ESaB0lF9eOABozMsocGoRqeUFOaPqj?=
 =?iso-8859-1?Q?5ZzakrNjEWtT1jxirbFEmh1S6bD0lnyh6W0VzwWWj6r3xSKZ7OlxnJao0I?=
 =?iso-8859-1?Q?61B3qgCiQG61xpcEfWdNWxW6v278KYIVY5Tpy8dw8htg3kXreZ5O1fPQNa?=
 =?iso-8859-1?Q?2Gs74v25fRkqtHRhJIIJD3Mn8fklr9aYCrBq7vUVe0kjeahBb3tAugR67+?=
 =?iso-8859-1?Q?542bwJIEq/HYJRYofLqpxr0LHnWsM3Y5fu/DusKgsXQOkSOi4y9JhhdoIR?=
 =?iso-8859-1?Q?c/LCB2Ky9EMEEqQzWNoZfwjSU6Xp1ZhI+L1mHDmSg/QdQrMJbwAd2Jf5uW?=
 =?iso-8859-1?Q?yuqh/ka03J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa56145-5b69-495a-3668-08d8f2b8ed59
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 13:45:34.0637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkNhQxbNYhdOStjSuP79+oLA3PdUfsai6gpAkleXdESTShZXFintX9NLQeoZqcKLQrDJIxyu37rEYFjxNTsgMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: March 26, 2021 6:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/21] DC Patches March 26, 2021

This patchset brings along following features/fixes:
    - LTTPR improvements
    - Disable MALL when SMU not present
    - Fix bug in HW that causes P-State to hang when DPG is enabled in
      certain conditions
    - Update code path for enabling DPG
    - Update display endpoint control path
    - Add dynamic link encoder selection
    - Fix debugfs MST topology to dump from the root MST node
    - Enable DP DSC Compliance automation for Linux
    - ASSR is enabled only when DPCD is supported and the display
      connected is internal
    - Added kernel trace event to print real-time refresh rate value
      to debug VRR issues

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.58

Aric Cyr (1):
  drm/amd/display: 3.2.129

Chris Park (1):
  drm/amd/display: Disable MALL when SMU not present

Eryk Brol (1):
  drm/amd/display: Fix MST topology debugfs

Jimmy Kizito (2):
  drm/amd/display: Add dynamic link encoder selection.
  drm/amd/display: Update display endpoint control path.

Krunoslav Kovac (1):
  drm/amd/display: Rename fs_params to hdr_tm_params

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix static checker warnings on tracebuff_fb

Qingqing Zhuo (2):
  drm/amd/display: enable DP DSC Compliance automation
  drm/amd/display: add log for automated test

Rodrigo Siqueira (1):
  drm/amd/display: Add refresh rate trace

Stylon Wang (1):
  drm/amd/display: Guard ASSR with internal display flag

Vladimir Stempen (1):
  drm/amd/display: Fix typo for variable name

Wenjing Liu (2):
  drm/amd/display: define mod_hdcp_display_disable_option struct
  drm/amd/display: add mod hdcp interface for supporting encryption
    state query

Wesley Chalmers (6):
  drm/amd/display: BIOS LTTPR Caps Interface
  drm/amd/display: Interface for LTTPR interop
  drm/amd/display: Enumerate LTTPR modes
  drm/amd/display: LTTPR config logic
  drm/amd/display: New path for enabling DPG
  drm/amd/display: Set max TTU on DPG enable

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  19 ++
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    | 190 +++++++++++
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   7 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  35 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 197 +++++++++---  .../drm/amd/display/dc/core=
/dc_link_enc_cfg.c | 303 ++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   6 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  16 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  15 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  10 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  27 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  13 +  .../gpu/drm/amd/dis=
play/dc/inc/link_enc_cfg.h |  86 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 142 ++++----
 .../amd/display/modules/color/color_gamma.c   |   6 +-
 .../amd/display/modules/color/color_gamma.h   |   4 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   4 +-
 .../display/modules/hdcp/hdcp1_execution.c    |  37 ++-
 .../display/modules/hdcp/hdcp1_transition.c   |   6 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  10 +-
 .../display/modules/hdcp/hdcp2_transition.c   |  10 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  10 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  10 +-
 drivers/gpu/drm/amd/include/atomfirmware.h    |  38 ++-
 38 files changed, 1141 insertions(+), 176 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cd50542cfc59f441ba27908d8f0a34db1%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637523931470435149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D2oJd%2FsM%2BayBUtDiQH3e0KtNUUe%2BAgw8wpQLXqU9PxVk%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673DC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6356127C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 15:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6356127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894666E3FC;
	Mon, 19 Apr 2021 15:45:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DDC6E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 15:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFPlpEhgXguZEhVO+GRkrHPCX5lkEfATFTHUxUtreJg79BOB+lJdHoIaRUks8MV6GKriOiExZLSYo0YfLbaUxWLliHLf5WOfoTZDcJQcfEPuVaQWa8kfDMNGOokhSHeOaEhBXrNK853dyydHWHkvsTs8XKUOUUTb3hqxhXdE8bZHBrwpsq5HBxvFZ2kkzv6xpgGgtQUVi+kxdS8zPMUnBgM2poUWkRaEStTWU/djADLVWDG7oU7sVUMX4ta/XY61r6UW+A7kDkReBdidgnwvTOMZaeNvk7eqD0+sbGsxYZ1vfj31hbvuO9K4VuQY31aIJU9H3DI8DfjQW7TnXqw5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad1VAnyt3l6po4aEsrfcsqzV7p/m+mfALNrJYMwZPMs=;
 b=UOfWGZOm+3bQtARMxM44L9+cPCA9iIk1eDo8DyVRA5s9/IXNYuGOlOGevkcTMk7I09WVvknBLSbU7EnMN27iJhQHu2F7VcyCFchBbr3UUJ75f5L+CH1FSkFtXMVUXRCzzlEMn7n8bgvcvQ8TsJGGKVXspSFePMx5G/cKExURedvuoRrWM7sryx6qu1Q0meKcmp3DhbPuoeK+lKt0B0YxFFOICVWJ5nTCXZvP7plQD+0Qi254w3OWCFbCQhZfg4+3/0EEZ+UZvRbxU7zWZ23hz1fOBp1lYQ+VZHCXskLpLAvqTUqp8HAXHZeNCZuDrVdGmDS03daWMR2VWujf10HSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad1VAnyt3l6po4aEsrfcsqzV7p/m+mfALNrJYMwZPMs=;
 b=QbwDPP67q0bnuwrPMoucaKLs4QU6tNyZyjvcFeO+WkPbha07n7+qpQZ3gCmUUExuabrtvUp6EStT3Nj4bJUqT7xaR5E6clRcbk/h4tQm0dBCYovhfg+TSs76gg1GhS2z3r2I6BzqnoWrQ4eVhTqQmsl5MD+r0+7sewGwkLGVwrc=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 15:45:14 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::2c98:4b1:875:afa1%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:45:14 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/19] DC Patches for 2021 April 19
Thread-Topic: [PATCH 00/19] DC Patches for 2021 April 19
Thread-Index: AQHXMs2b17oazbjZrEOZt+XDIro8Oqq7/j8g
Date: Mon, 19 Apr 2021 15:45:14 +0000
Message-ID: <DM6PR12MB3529E51046D88F6D5FDDF22E9C499@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T15:45:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d3a13534-7c20-4c95-9e2c-7eb2f9c617dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: sending to open source mailing list
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2c93ed1-7d52-427a-0bd4-08d9034a1fe8
x-ms-traffictypediagnostic: DM6PR12MB4138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4138A27C558CBE90EF68BBA19C499@DM6PR12MB4138.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GudwPRhOOnmrIJfEqZ6UDW2mCQa1xpT2dXGlUx+y06cCuelhwC14LYXa/jdf/jdtQkJdHgF6ZQsWJiPb5f8t+moeFvCkdch/g7t6aX66f19N9uxpWjs3i6PIaDE8plq+WI+HOka5oHGgekA8OBxLOdxgOhGhebvEHGAUUZQZUDFRI5OpeGdftsp3wG4cc5tXIzs3+Uux4bI3ZfDg03nxw6zWQRj0/VQ6IBIX8k6axhb1C8R6O/rTwCzJZNO8TuwLyYn3Mqh/79vV+CeVxyunow1h2bEcbw3dDwikAXhG8Dy4ukULhTvSSrglB0vT9F7YXllBASg9Xh8g/Gix7F/jrfBaYCMMYj+XsxBn5uovWMbwgbEg3oX2cRPUPmSsmpxkwJC/aUbhpMCCWtp85JPfz/BW1ZSRoyvlXMzo+XQbJUanPodNU4j/ZjgJrA8IvCfAk9g/SlB1irSoGbv4sgXo5F9HM/5aj8bEvoZS6maRwWa9zQ6XC1gVzbP7RbKuPGMYcc1u48if52I4B+4xCg+cfw0/rPDq5QNKcnMwLpNYe5BbI+JbrVcyvThIEBXGSXtTOaC+G3GJF7wJx4Y5adDzkifmhEFyhF4DqRkv5DTf4ezgFCbK0woKmQCPm7mb6ZzJ5hocgVzU4Nvkop5AyV7yLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(8936002)(86362001)(316002)(7696005)(966005)(8676002)(54906003)(53546011)(71200400001)(110136005)(76116006)(186003)(45080400002)(6506007)(2906002)(33656002)(66556008)(4326008)(38100700002)(5660300002)(9686003)(66476007)(66446008)(55016002)(64756008)(478600001)(52536014)(83380400001)(66946007)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?k1cyJ/afuk6MGVWvIn9K4ugln7kP0v3Gg7n57+zL/6MshbsJx3ljhDXyDX?=
 =?iso-8859-1?Q?r6jSKW9kXry6kpS7c2ZAoAwzP/v52hMt6nOt/jV4rtixzW/xFhh0L9GuLx?=
 =?iso-8859-1?Q?19benM+CvaLQEOZq8x2cZx9YuavSqJr9Z9Rziz70mautcnPTH07O1xZdgL?=
 =?iso-8859-1?Q?vKILOnoKUNNLzoF2KL1bLfdRBgrEg3tggGJpk8043BT1DMProc8TKdhkIS?=
 =?iso-8859-1?Q?Phdjo8PhryHcEof3PhibeEmpdEWXUFucxX5O6PW1i0KYezxhR0KmbFNVkU?=
 =?iso-8859-1?Q?IS+PBzd/kaL4fdsBNpl5nuwlOQD1ny50th5i3wd9pQpefde4E6/bHAkJEH?=
 =?iso-8859-1?Q?7DTWi0QGrSCl/2E9H2y98invOJ9TYT3cqSDDEort3/Y4QOSO5f8VD+1P6U?=
 =?iso-8859-1?Q?wcskodtnUfHHUzLwCMC36XjfEPfoO0VleSyjDWZTMdYpWMyQBPw34HzX+L?=
 =?iso-8859-1?Q?u+68YmVlHjQW9wp+zknMTXTpFAnn+oE8gyOPuIhoIPWtXgeFGXWc7nf978?=
 =?iso-8859-1?Q?ciKiHnOFm+w92E5UpYH7/8GaaY070qM22fYjxcpzZxJr083RLxG5zfStOy?=
 =?iso-8859-1?Q?63HdtXRtvz8I6ShJb9dM6XkishTmMzc4avWWEcT3kkcAGWfl+Wl0LUM0+E?=
 =?iso-8859-1?Q?UHsYGaRWcXneHGOfxr6lOhI8ufvKyx6RlAAi8KT1Xyk1aMjny2r87fanCx?=
 =?iso-8859-1?Q?vIdnoXRVKOZ76qxd/MizWi7nUfFJTQfGFhL5EP45alIQCln/Om/d1fRuVO?=
 =?iso-8859-1?Q?nJOtuD8NqGbA9US0eBZfUY6wbtkQS9qedsMF0DDtkzT5EvqKJs9O7AL6Cz?=
 =?iso-8859-1?Q?a9FQCrdT+Sz2XW4/HJgq50C9+CdUTEidl4wa83wiXmnRwvnLnR0fN6zv7R?=
 =?iso-8859-1?Q?ZLxYIjLA2VV9BH5oT/KpjL6gvKvlYP4fyl8IjEYuwHpjWzEuqXRHM0tyHq?=
 =?iso-8859-1?Q?xWPdnV7Vg0CAWycM3k/4rOMdeqVfBVvx+c3x9U/Xcc5avNTIgQfkOhMUD9?=
 =?iso-8859-1?Q?Ei0CzbTa9qnhyo4gy8KwpmpCTPdwSRXOoxg+cfYAjBU3SXHnndNY3BLI3r?=
 =?iso-8859-1?Q?Emx9vhSew/I9F3dedsgy0lNLDiGjUEAIMpO+uq/lDYcWyPgA3PNeqBQTkm?=
 =?iso-8859-1?Q?/U/FgySHWyHFLDPnQ72LQYWh8Z/bYUseVaumaHimdBBfT8FVHDSD7sptk7?=
 =?iso-8859-1?Q?OdWYb6DXWVZN8BhXTi/eoMJJiA88Ysmrk3aG4/DyvG+eGIjOLWnMZU3HFR?=
 =?iso-8859-1?Q?3IeD2aSVWpEjI3Nou4LgG51fY0qiu4Pmn3HLFuu6dmwvQDzvWFpcNo0D1U?=
 =?iso-8859-1?Q?FWMdtkSclDDhmIPm6ZnJfrBC5gxjAuqJtGfsYonlYOtQfNrAXvG5o9z3XB?=
 =?iso-8859-1?Q?xfEFWP9IbR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c93ed1-7d52-427a-0bd4-08d9034a1fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:45:14.5131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LmHVKzR3tpvl7aXxp2AYBMuCGxCXxSe992W/jNtVv5B1gUXPwRDgaaqV+jyg5um64kVf2QFgEwkfhsQwPUJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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

[AMD Official Use Only - Internal Distribution Only]

Hi all,
=A0
This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDM=
I), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and=
 then DP to DVI/VGA)
=A0
Tested on a Sapphire Pulse RX5700XT on the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Also tested on a Reference AMD RX6800 on the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Tested using a Startech MST hub at 2x 4k 60hz on all systems, using DP.

We have noticed a regression on the RX6800 that points to these patches, an=
d as such they have been dropped from this patchset:
drm/amd/display: force CP to DESIRED when removing display.
drm/amd/display: fix HDCP drm prop update for MST
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display-----------------------------------------------------------------=
-------------------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: April 16, 2021 10:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/19] DC Patches for 2021 April 19

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* DC v3.2.132
* Fw v0.0.62
* Bug fixes across HDCP, DSC, FreeSync, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.62

Anthony Wang (2):
  drm/amd/display: Add DSC check to seamless boot validation
  drm/amd/display: disable seamless boot for external DP

Aric Cyr (2):
  drm/amd/display: Fix FreeSync when RGB MPO in use
  drm/amd/display: 3.2.132

Bing Guo (1):
  drm/amd/display: add helper for enabling mst stream features

David Galiffi (1):
  drm/amd/display: Fixed typo in function name.

Dillon Varone (2):
  drm/amd/display: Fix call to pass bpp in 16ths of a bit
  drm/amd/display: Report Proper Quantization Range in AVI Infoframe

Dingchen (David) Zhang (4):
  drm/amd/display: update hdcp display using correct CP type.
  drm/amd/display: add handling for hdcp2 rx id list validation
  drm/amd/display: force CP to DESIRED when removing display.
  drm/amd/display: fix HDCP drm prop update for MST

Hugo Hu (1):
  drm/amd/display: treat memory as a single-channel for asymmetric
    memory v2

Michael Strauss (1):
  drm/amd/display: Add link rate optimization logs for ILR

Nicholas Kazlauskas (1):
  drm/amd/display: Always poll for rxstatus in authenticate

Robin Singh (2):
  drm/amd/display: fixed divide by zero kernel crash during dsc
    enablement
  drm/amd/display: removed unused function
    dc_link_reallocate_mst_payload.

Wesley Chalmers (1):
  drm/amd/display: Unconditionally clear training pattern set after lt

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 130 +++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  25 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 ++++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  72 +++-------  .../gpu/dr=
m/amd/display/dc/core/dc_link_dp.c  |  18 ++-  .../gpu/drm/amd/display/dc/c=
ore/dc_resource.c |  33 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   4 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  15 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   2 -
 .../display/modules/hdcp/hdcp2_execution.c    |   2 -
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   2 +
 19 files changed, 257 insertions(+), 136 deletions(-)

--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C0a93a7750f574b38722e08d900e4bbbe%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637541804686826849%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dkxcn%2FAwrz%2F9fKJdhEww0DPlQZUysvci5nxxE%2Fj5eGfQ%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

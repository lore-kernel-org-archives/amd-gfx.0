Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC25CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11D210E2A6;
	Tue, 12 May 2026 15:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2Lwjr+y";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C094410E2A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uobdrsEPTdM8JeF1qMYBsZczpP+A6thoBHu+2G7trH/ITT3wZENVjzjl1a1HKhkLh4NtNu2CJRt7Y28XlURIp81hNX1UdSLEnYjTum9UiutDhm8OutB2AhW/x50xWggjZ69PAPqpNlicbJDzJREYrW+9+1VjSSPyPmE+9pLPCJyfyuhu8eE2nWbTrRxnh+Mm3N2BKhnpnXe9pnP5ftR1hn7SpyPIj48Er75eiJasqdMUEuPyeNHj906H2Z47qLc/LhVUTDIAWzBr5rt3puZzueXPbc7i0dzgIRLbG+g06UCf64LzByCV0K33a/94ILzqLlMqzYKGlih31uYYbHHyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82grNsZ+aFYvcdGHPaXe1dk2CFi5vDYiTROZfbS4OHg=;
 b=CGcc6RZq7oxnqoGnK3640zkxwGQgGTC8JPhud28WJ1UvwlwmCYm+0tqM9vnPNyDv+nef2xZA0AMNdQplLsW7f4MlBVYyohEqgGDdx14xzur7XlhKAkwWwrCaxNSry61oPxK3t2BauswLdJYtMdHCCK+C91HlpveTydwLZiTbssF8smhBszD7wQtgbxZuoLo0doUsIptzY8Ppo8xTPkKagINl2IV+ucLcO5klH03YvktwZRnMRLmcSTmQqHRRuOPCLyQ5RmHFLCrBR2VoE5N4EX9ywJpGe/k/nNy1oSCE6xtddj34Ai+ooplrh+CmtAHcffw70uFVcFPbTh7ZrglJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82grNsZ+aFYvcdGHPaXe1dk2CFi5vDYiTROZfbS4OHg=;
 b=W2Lwjr+y7Alr6WsbaREKQaaG8tiMqMAtMzaacKqALEYY506WHkJzafZ1e169unlcUtc4ssUUvjxKrytzr8qMXjk8OAOs/qArOQVqCkGgTxORZ7YVmvT1zzlime3HawCL2z3/twVxzjke7EcvVBrx+T5c1G+44KsBo9zdOZ9OGCQ=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by PH7PR12MB6693.namprd12.prod.outlook.com
 (2603:10b6:510:1b0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 15:01:42 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.20.9891.020; Tue, 12 May 2026
 15:01:42 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, =?iso-8859-2?Q?Tomasz_Paku=B3a?=
 <tomasz.pakula.oficjalny@gmail.com>
Subject: RE: [PATCH v4 00/13] HDMI FRL and DSC Support for amdgpu
Thread-Topic: [PATCH v4 00/13] HDMI FRL and DSC Support for amdgpu
Thread-Index: AQHc4hrhN2Z37/fCN0SZFAz1BbOM0rYKetzw
Date: Tue, 12 May 2026 15:01:42 +0000
Message-ID: <CHXPR12MB999220A4791D476071F2032DB3E5392@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260512142308.131260-1-harry.wentland@amd.com>
In-Reply-To: <20260512142308.131260-1-harry.wentland@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-12T14:56:38.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|PH7PR12MB6693:EE_
x-ms-office365-filtering-correlation-id: 1eeb2044-3007-4dc2-de79-08deb03760bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799003|3023799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: bXD+q+S1j5GDnNdeD+3TTwaCO0Zap9Xt3wG46SQ6GMvI9wc8/UNdz1FNTV9hYyM0jV+nCMqH2epK8DvG8IR3z5KMbVDiDq/SXjWujhge2mpfPY/PUwNSfp0Vq2smGBV8EDpkOWEloTOjxUHWJGE9m6xuFu/TDzS40p8acWNPYh7TChcPwUD4ucwnsVMcPC+R8XxWwfN8I5l/ZCNxZ/YD2HZDnOziLAYnTBV4i31AqVl7cWAGV8nKVDP2D37w3GWNXxaf8flZt4unUhWKsxTt3KnTKQRtUnEaROfFUNuuTAnKd/F14254ldrXI/V24aLV+wzArirCe+oFc1oC8Sx5ycc76Njvp8bW5O08s1J9vz7Qg0n5jrv+uW2ExNKh2Im1DiZ+aFTUME6bPez1fRA17/gGnkvaXCYG1I4Jbw0m3ukFooBZFUaA6x6Fx4Xpkf5udq8rhX9oAwp520+49erlaAuB68LzdfvQRQqni2EevpiJveXBGwdPHGpMTdzCiRvv7f3FwS9gfL5+se9i9wqHaDWo0dbK3Vp6BrfUXypvo9r/cocv19mjrglU9nggkmBqTtn+T2fH/BbumgxjUrIsRa1Qg1lMCLzUlt84uw+ujVYkKldHGr6UcshQsBfUmJD9I9dGA9AvsP2SRQiDoHrv9VhLfBRVOXxutn2FLGARCwTQZTkquyjzC613y7f2dbFWBXbThrI/tWKnvkgL9MhJaZCn2NkhscFp2hkxvSyLr5wiht0oUJ/9Q82bxgX9uBmb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?3fRT9ZrR+R4JvG9SmmP1HmEuz/oSr7Skp8fp1pjm2ZWDQudBNxPolB4i47?=
 =?iso-8859-2?Q?rVQkWne+lJQjP+apN34nKULzD7cPiuhbSWPZxojNWWxZpNfilcdluSbmF1?=
 =?iso-8859-2?Q?wK3B5IHIDRqeg4HWn0prb6ZVzTsqTGGvTBqdqqVKPNmMmidK2ome3kFoK8?=
 =?iso-8859-2?Q?7UDl9PHl5qdM7NQ94HD6L9xVvfnV8tcvRWlh688P90AQTmap77d4czXd1K?=
 =?iso-8859-2?Q?gTJMbZ4n6F6ERxsA7JGhDx1qtdUdopfwHocP5qYLfkiaCffZ379tIav2ho?=
 =?iso-8859-2?Q?p5PiXLFbxEOJ8JUoyv8oqHbOSX1hyPFziFcIwJjXHIjEj5Xb+yBRIWfF8M?=
 =?iso-8859-2?Q?vwfqB/Zrl9JvzMRpalBQykdvdZpcBZBKuh7DKu4jkgKtwRqNaUpeU9sHFT?=
 =?iso-8859-2?Q?zPN53kcXWdjJdYLZ1QRh2JX8VhRFIsVT+X5WjBXFMVV7ljv1TsUYCy0dbO?=
 =?iso-8859-2?Q?2vX+sA/2Cc65VCiK4vg8v91cnnuZdHe6moGbM5l6dz1bfQzWYtS2skXzUw?=
 =?iso-8859-2?Q?PNf2dEVAo+VLqWEMpPIGvHF8k6VVOcaD0uQM5Ups8xjOlJ77OFJWkGTmm2?=
 =?iso-8859-2?Q?ArjxJixKto5EyoHeGMoOF/Z9EaFQcixWMYmf5yoZ4EdJM4dGEDXn/wbH2N?=
 =?iso-8859-2?Q?aWKJg6Kh6YH2lLhnRSlrxV8YqQLLuYr12KIXsFN6IhkC4KfhQJiBmzGFO4?=
 =?iso-8859-2?Q?t0744NuqHATRlHJFmUBXaPqiQfEBn6alImEf34CL1GhxtXJUYUmULfwGTt?=
 =?iso-8859-2?Q?XHUupu8kCAovLrb7np6FSr8dtzQUNgBD0QiJxmsA3yvxl3lt18AN9LbUjo?=
 =?iso-8859-2?Q?RWmRALGdVuhLwe9VsmfiU4+0CNxYkyYPrl523+UWrfFJGJVotszOUUeajD?=
 =?iso-8859-2?Q?dRJtZODdZNkqRyUnRKbu1QKKvMQkfdqhCS8rPUeIMbdBR0TIx+wsjZdQlW?=
 =?iso-8859-2?Q?w9k9GSVzjlHYballm//dr2aN+W9kq17PcuONUTZeImsRQSEy8wKWG4E4LZ?=
 =?iso-8859-2?Q?vS5EHyEAOQQAmoAFhR4Y7Ej7HDhGeeR4781YeUHO0Bl3Oo6W/V8v00cbdZ?=
 =?iso-8859-2?Q?NM3W3SBYrfuVbxLhUJRjPQzyYhWBwju9xg1Bb379ev/jmxjwMywoBCiJkG?=
 =?iso-8859-2?Q?cmxHC1poZ5wJr9E5XQMSuwwITdWnYkfEZjifzfWVEisJKY8m5GooZpOeQh?=
 =?iso-8859-2?Q?foiGPxaa77Q86Mj4eJFfOuB59urDGwcxyV5eBycuypA6r1rtQWPTg3br+L?=
 =?iso-8859-2?Q?LgE73lzl2TIv3PqT05K8HXrhTHmxd+n0TO1mXR+WpKVMdY/rgf5M8ajFop?=
 =?iso-8859-2?Q?FqSr7QGLsCwHIQqkoiI0FwuszP7ZGRqJ/3hKdCzuBwKDxJKAFHaJK5+NFJ?=
 =?iso-8859-2?Q?1nCtc9JLZbYOrDgGUWCCAXswk8XJyJvnJ3dhNWdTkrBuP9YBq/nI8O0ont?=
 =?iso-8859-2?Q?QvylYtQAfT1nB7CWM4gACHmIpS58qLHoWsZ2D82wzk/39nIzIMkmlYw94n?=
 =?iso-8859-2?Q?ibeO5JzmT2v39XwCAVDvv4MFALGE0dNFMRNetQ3p1+bJMpUoWfUJzrjlTj?=
 =?iso-8859-2?Q?nwa4fiRFsK/OLNdQrpighR1ytb+Hk63QQw7eK3jmw7D9JNb3qMJRrKuoq4?=
 =?iso-8859-2?Q?RIBOoixLfI5bRXUVKU1xYqEREbV0xtU+gN56gvXHRvFOTGCxZMug7SeUDu?=
 =?iso-8859-2?Q?qiHiCyGc3uOoxKyIYtUF5c60aF2jDoO+ll1midtIFENkqTqK5W9/j68f1Q?=
 =?iso-8859-2?Q?wjJwEjs4WcoNB5k5xIPzY9VTE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeb2044-3007-4dc2-de79-08deb03760bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 15:01:42.5656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoMnZuDa+Pe083HjERDHrqL2qPCTmnl8MUOWIS4+u/XodmayINDfjDSZ81Y892Hg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

AMD General

This series is

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

> -----Original Message-----
> From: Harry Wentland <harry.wentland@amd.com>
> Sent: Tuesday, May 12, 2026 10:23
> To: amd-gfx@lists.freedesktop.org
> Cc: Zuo, Jerry <Jerry.Zuo@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>;
> Tomasz Paku=B3a <tomasz.pakula.oficjalny@gmail.com>
> Subject: [PATCH v4 00/13] HDMI FRL and DSC Support for amdgpu
>
> This patch series adds HDMI FRL and FRL DSC support to the amdgpu display
> driver.
>
> This work passed a representative subset of HDMI compliance and a full
> compliance run on this branch is in the works. We don't expect the full r=
un to
> show any failures since it passes in other environments.
>
> Thanks to Siqueira who prepared this work a couple years back and
> unfortunately didn't manage to send them while he was still working at AM=
D.
>
> Thanks to Jerry who has been making this code solid on Linux and running
> the compliance tests.
>
> The first patch in the series isn't related to HDMI 2.1 but included here
> because it moved the code around some key bits of the HDMI 2.1 stuff
> around too much. It will land with the next DC Patch series.
>
> v4:
> - Disable FRL over DP MST due to lack of testing
> - FP compilation fix
> - squash fixup commit
>
> v3:
> - Add missing DML2 bits
> - Merged register headers to asdn and removed from patchset
>
> v2:
> - Add missing function pointers on DCN 3.x
> - Add DSC
>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Zuo, Jerry <Jerry.Zuo@amd.com>
> Cc: Tomasz Paku=B3a <tomasz.pakula.oficjalny@gmail.com>
>
> Fangzhi Zuo (1):
>   drm/amd/display: add HDMI 2.1 Compliance Support
>
> Harry Wentland (12):
>   drm/amd/display: Add HDMI FRL definitions to includes
>   drm/amd/display: Add DML changes to support HDMI FRL
>   drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
>   drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
>   drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
>   drm/amd/display: Tie FRL programming together in HWSS
>   drm/amd/display: Add DC resource support for FRL
>   drm/amd/display Add DC link support for FRL
>   drm/amd/display: Add support for FRL to DC core
>   drm/amd/display: Update HDCP and info_packet modules for FRL
>   drm/amd/display: Tie FRL support into amdgpu_dm
>   drm/amd/display: add HDMI 2.1 DSC over FRL support
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  160 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   11 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   68 +-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   79 ++
>  .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
>  .../drm/amd/display/dc/bios/command_table2.c  |    6 +
>  .../dce112/command_table_helper2_dce112.c     |    3 +
>  .../bios/dce112/command_table_helper_dce112.c |    3 +
>  .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
>  .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
>  .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
>  .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
>  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
>  .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
>  .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   32 +-
>  .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |   49 +
>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
>  .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  289 ++++
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |  128 ++
>  drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    8 +
>  .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  164 ++-
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
>  .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
>  .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
>  .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 ++
>  .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
>  .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
>  .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
>  .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++++
>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
>  .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
>  .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
>  .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
>  .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
>  .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
>  .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 ++++
>  .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
>  .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
>  .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 ++
>  .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
>  .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 +++
>  .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
>  .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
>  .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 +++
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
>  .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
>  drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
>  .../drm/amd/display/dc/dm_services_types.h    |    1 +
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  127 ++
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
>  .../dc/dml/dcn30/display_mode_vba_30.c        |  280 +++-
>  .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
>  .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
>  .../dc/dml/dcn31/display_mode_vba_31.c        |  243 ++++
>  .../dc/dml/dcn314/display_mode_vba_314.c      |  241 ++++
>  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
>  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
>  .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   |  127 +-
>  .../amd/display/dc/dml/display_mode_enums.h   |    1 +
>  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  786
> +++++++++++  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  173 +++
>  .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    2 +
>  .../amd/display/dc/dml2_0/display_mode_core.c |  104 +-
>  .../amd/display/dc/dml2_0/display_mode_util.c |    3 +
>  .../dml2_0/dml21/dml21_translation_helper.c   |    4 +
>  .../dml21/src/dml2_core/dml2_core_dcn4.c      |    1 +
>  .../src/dml2_core/dml2_core_dcn4_calcs.c      |   29 +-
>  .../src/dml2_core/dml2_core_shared_types.h    |    3 +
>  .../lib_frl_cap_check.c                       |  396 ++++++
>  .../lib_frl_cap_check.h                       |   90 ++
>  .../dc/dml2_0/dml2_translation_helper.c       |    4 +
>  .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +
>  .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   |  413 ++++++
>  .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   |  109 ++
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  704 ++++++++++
>  drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
>  .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
>  drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
>  .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286
> ++++  .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146
> ++  .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 1043
> +++++++++++++++  .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436
> ++++++
>  .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  907 +++++++++++++
>  .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++++
>  .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  207 +++
>  .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
>  .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   13 +
>  .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
>  .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
>  .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
>  .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
>  .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
>  .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
>  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
>  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
>  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |   34 +
>  .../display/dc/hwss/hw_sequencer_private.h    |    3 +
>  .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 +++
>  .../amd/display/dc/inc/hw/stream_encoder.h    |  231 ++++
>  .../amd/display/dc/inc/hw/timing_generator.h  |    5 +
>  .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
>  drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
>  .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
>  .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
>  .../drm/amd/display/dc/link/link_detection.c  |  111 ++
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  223 +++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
>  .../drm/amd/display/dc/link/link_factory.c    |   44 +
>  .../drm/amd/display/dc/link/link_validation.c |  298 +++++
>  .../drm/amd/display/dc/link/link_validation.h |   13 +
>  .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
>  .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
>  .../display/dc/link/protocols/link_hdmi_frl.c | 1185 +++++++++++++++++
>  .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
>  .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
>  .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
>  .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
>  .../amd/display/dc/optc/dcn30/dcn30_optc.c    |    8 +-
>  .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
>  .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
>  .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
>  .../dc/resource/dce112/dce112_resource.c      |    3 +
>  .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
>  .../dc/resource/dcn301/dcn301_resource.c      |    1 +
>  .../dc/resource/dcn302/dcn302_resource.c      |  109 ++
>  .../dc/resource/dcn303/dcn303_resource.c      |  109 ++
>  .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
>  .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
>  .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
>  .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
>  .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
>  .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
>  .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
>  .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
>  .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
>  .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
>  .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
>  .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
>  .../gpu/drm/amd/display/include/audio_types.h |    1 +
>  .../amd/display/include/bios_parser_types.h   |   14 +-
>  .../drm/amd/display/include/logger_types.h    |    2 +
>  .../drm/amd/display/include/signal_types.h    |   12 +-
>  .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
>  .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
>  .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
>  .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
>  .../amd/display/modules/inc/mod_freesync.h    |    3 +
>  .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
>  .../amd/display/modules/inc/mod_info_packet.h |    2 +-
>  .../display/modules/info_packet/info_packet.c |  122 +-
>  179 files changed, 15127 insertions(+), 113 deletions(-)  create mode 10=
0644
> drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_librari
> es/lib_frl_cap_check.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_librari
> es/lib_frl_cap_check.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder
> .c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder
> .h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_enco
> der.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_enco
> der.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder
> .c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder
> .h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h
>
> --
> 2.54.0


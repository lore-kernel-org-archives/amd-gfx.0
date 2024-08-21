Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13762C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B639810E6F4;
	Wed, 21 Aug 2024 21:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lutVoBh5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F5D10E6F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC4Q/ubMnrkHABLN0azAsmFiJmJm2jFkddtAcVf086HmMN3M7AC51HACrwimv6njhry5mTqN2xqFZcVJN9ZA1DagLggh2lJokQWhBfJc2oAxZop9BtpWXesoYDf85grypt1e/tXi4uOB+vhoxdFOa+5gUuaeEYAKEnOWzNWPc10Zzmu8ZmvXhFZldJomdkHyi/XPvI4eF0N0jzfVoz8eJi6CBRp3zEwvebHd99ZNVOXX0BMXKVeLEI0ilbcLQtcNxwEXbcnQPqhuZpWhnUDQ89OmLtSH9B4e2FPk7CiRLUBw3PyS26CULNcu6v8ZqcB701uK4kuUAcFWqBXvoGSx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxNycRDgebbqfhTnuYqMbFbLVA04WTuYZ1TMbeShtR8=;
 b=AEJhKvepRm7kyN1M5QtzvENjyPfXzTnt7+5bc6e7eieGhoetmLmH1mSlPWKU19I4b+lFVfs8E8ESLCnky/D814MqyFTYaf1WN3Kgkif866Occtf62CKEsDc6VLvFMGD4Q/fw2aWbiPUWPI0+ct0Iu2o/98hq4J8sdjO+M/9pio0K0pZ1gGJ2MRMsAddlUKQH6r9elSIy6Ff4OjXaNTByGPs/VTpcwaWM72QFxXnBrzAR1dxLOQxOm0/owU65gcwVexaFWP9Wf0JgkvWmx2StS8ONx6ipwUZ08G7dbbvQkoIgABgbjPftkjHceNBT4QrJ6l2U4OAJK2h7+ROQ+o6qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxNycRDgebbqfhTnuYqMbFbLVA04WTuYZ1TMbeShtR8=;
 b=lutVoBh5rcocriqxAdD1sd6HjhlhVxSM0lJyIzpCozZC9bXav+bZOOz8Qh3wF2qCv98YVPGwwEaYjoWtL7PdRFbGX8gyD/ktUU9cWr7N43FO4jvnF44P3bdCEjTXNDiVRgFvNhgkkrzwfYbwgYDH+3kGJm0nLD0RZa0e+nxJmjc=
Received: from CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 21:56:54 +0000
Received: from CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7]) by CY8PR12MB7289.namprd12.prod.outlook.com
 ([fe80::9cc2:b7be:be33:58b7%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:56:54 +0000
From: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>
Subject: RE: [PATCH 00/16] DC Patches August 19, 2024
Thread-Topic: [PATCH 00/16] DC Patches August 19, 2024
Thread-Index: AQHa9BR0SI2y0pNymEW02frXywkU2rIyQbzA
Date: Wed, 21 Aug 2024 21:56:54 +0000
Message-ID: <CY8PR12MB728903A12277DD1958B4F4A1E28E2@CY8PR12MB7289.namprd12.prod.outlook.com>
References: <20240821215213.1496781-1-zaeem.mohamed@amd.com>
In-Reply-To: <20240821215213.1496781-1-zaeem.mohamed@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=986bd938-cea4-4223-aed1-d5a59a254fc6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-21T21:56:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7289:EE_|DM6PR12MB4154:EE_
x-ms-office365-filtering-correlation-id: e0e6fdfd-477c-4a36-e900-08dcc22c2b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YLzfMQOMwpAd0ffhp9qG3M497YInePOp7wpoRPwrKvl2S3dGPwCAJY3ybNHz?=
 =?us-ascii?Q?6hwGzTVmYegtSartuQ0qXbkzsqVakClZslKLCMDqIT6Woywrxix9aSwrM9gn?=
 =?us-ascii?Q?T3rxlAs4x+fu6AT+HjaCuGyeFtUYtXYX/1PAZk3UPrysME1eP2ETQ09qN78k?=
 =?us-ascii?Q?nV2eWQ6bwOQXtZ+4YVGN/KVbONZydjuq0xitCswAkosxs0w9l0bGBocdMSYK?=
 =?us-ascii?Q?1fORM0U7B1LxEHh/ss+O3jGS99p6t/jAoOwe1cezZeJvFIsSk2kRnpSiRgme?=
 =?us-ascii?Q?Y97PHiHwig0W76naD87605edtAxb/oXlSklFcScxrkYciBQP6ooET0O2qo/2?=
 =?us-ascii?Q?PaAxMd8yg84KR9aGnOWpjFnh3dQr2SV31LTtFP8qJileBKQwdLAJqp0edKXv?=
 =?us-ascii?Q?ZV7ej7bzyBaVw8n9CLZDIQYKAEFPdA1dVvD04EbHwT0rwL/zC/yrj158blcJ?=
 =?us-ascii?Q?NPtOBdZzIVGM4oA6/rdQ4Um03XW3QwG+7NKntF4+IWAHLTzuJxq0mAV/hXUc?=
 =?us-ascii?Q?Sp7qaz9xFEUx/3cQ0Y+2OczGxo8UPzsIpsMQqKzS4uokQ3bE27c1zvjnf/ke?=
 =?us-ascii?Q?DC6eLd5ZKVrIcA6G67w2/76VfYWly+eVWvrgMo2kyLp0Lb8A/owypsQ73FgJ?=
 =?us-ascii?Q?o8bYfSHZupgtUBjRipNLBTft1lrsrDEBRUZpnmWPi0ACPiCGL4U12/xIZmgf?=
 =?us-ascii?Q?fxibSjml3yYayWNjVXrMVRdshswLFD1DXivKdA9dLltRUQAyAqYQLPCQ5e+S?=
 =?us-ascii?Q?9WPU09+zyigfbEy3J6T+ABbrRZrMpvdiQ3vSUe3xHpCDJOOnmapicf2ejhol?=
 =?us-ascii?Q?C8bD3BDRSRI3zIwaT3k80cU67gzf9oPi8Mo1oNRiEz+mr5Zeqyp+8VdFY079?=
 =?us-ascii?Q?OthsVh7i/ZCzBWHXGDeLteQEbd7cViCX+aZg8R4g5dLJn0+3zxH7WNTMJnAU?=
 =?us-ascii?Q?0hA9JWdrLpsZURKEph0hXhhCRZes0xjqAJASXwILgV4B/hSWuwSMwbGBuTaU?=
 =?us-ascii?Q?9c/gYCZtqqOw2JNf6ZW7aoxj4KPJYQO4FnDW7LnZ5PILSYbW04WfmvV16SDP?=
 =?us-ascii?Q?mtCwjqv4YlpCeKg9ksnzn++Zcyp0P+iWBr9QJCrmaDFI99l4HDZKp4HBhLOA?=
 =?us-ascii?Q?5C2SrW1faM/eEgINIQHaiO+D1GYDiiSclGjAnJKJstKu9K1OgQW0Pmew+HHs?=
 =?us-ascii?Q?GDLhRw7KANw3q7W/FYve4Wckrb5P4BcwKq3bQAgUqAXs4UKzJksEExMi8dVh?=
 =?us-ascii?Q?ydnoyGYHc3A/ofXvH44QbBXdDJJmGpZ0IThTdbbV5ZGKouDRaZE7n7tudh6Z?=
 =?us-ascii?Q?7CteLMX2kQhFgiT4ZaD/ekfxr4JiDbWaSIogCM0jBDFTiUNWZX4wOSZR2N1M?=
 =?us-ascii?Q?Jd/4SJlqxDzjgn+ZXUDUsmAozoUCVNktdsd05DBcqHvoatSVQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7289.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKlsA7HDDqZSemwpQ5doW+SUXyNJMnhpCXHfDuZY/d0PH/CbJSatflBVYld6?=
 =?us-ascii?Q?mr8t4gKsEMlc9oRmcbyFxWiH9ak8JtMeHSDVnTTnTDeKwBhUelxA1r2fWqyX?=
 =?us-ascii?Q?fDSYVujVINWr5580j/4Mtn07e247bOlt3N6xxcRzPxSGLiTe73NAN7s1gbsH?=
 =?us-ascii?Q?RuN9tpg1kzq7P7uaYKK/WcJlSt/9SvPK3DNUUyxOsNV5MUl1NJOq4wtcSLtv?=
 =?us-ascii?Q?Tsf1R9473z6ZM8EURVySOriiXuc2GQkvIAjcpbRb8S2wBKjERsPTx8n2qtq2?=
 =?us-ascii?Q?6uVujXHdKtU1BrQBtf/BU9OKCJwImDlVoT6bRacz3xrE250hvtBKTEUBRI/K?=
 =?us-ascii?Q?rAbUzRI+Nm74QF4e8nrSGVEltJPyQcrjTrK2mmVmrM3Ap/fX9+m3eLbeI735?=
 =?us-ascii?Q?Mb+ihpgLxvYFRpHP/uPlNbs10nUSgUe5BFVaVJDQ7i2WeCw9cilWotDT3cfw?=
 =?us-ascii?Q?hMkXzRyawFdqjh03sE4B2AXqhPkKO2+QNQEUFgjXFZPNrbwgvPPKbFFjfE66?=
 =?us-ascii?Q?hy0HJfvSzXdpxgFM+MtcU6OJ9wncqJT3YYDMDfbvgaInCJKUUikInLkT+xXQ?=
 =?us-ascii?Q?8S9qBdfS4yGr6ZlFAq1D6rcms09Jdj476roGXrPXJx3UKdpwPbZDKKw+OHJo?=
 =?us-ascii?Q?UHYR+dULC6x81RWwIlTtZRzZe1CO/N5C+q7pILAh+K8ZoQ46PDsSrpRKgXY+?=
 =?us-ascii?Q?vgBeJprEMBSF4bJ8CWNZ5ZTZj++jDXYudzbrACZ4wBEZcYMMbeSVJa3zJ7ms?=
 =?us-ascii?Q?5gZdYQySUdXkfdHb9xNTyfh1oU3eKxhavMjJQi/PqcCTwpGJ1Y1vVZSNeXGw?=
 =?us-ascii?Q?FHISVmtFZRNwjJiqMYi1+uKDO+onzfcB5jVp6/WLW8sPOT/gHWC5+JX3jrC1?=
 =?us-ascii?Q?DaJzwiZXfqdbyQPDZMVxqldXrAxjl92CAS54OgaipO/54TjztqjvWJmhrO+Y?=
 =?us-ascii?Q?hv9gbbTfvlmkesmXmASpDgajdulFFvOSG0XF4TBFjQ4y5bQC6ok/bE4chO6u?=
 =?us-ascii?Q?aRSpvlBwIAd2GGeeLV4De8y2oNJYUeiq98Fnd6SyHDa+Ag0Nxh2/itfltu17?=
 =?us-ascii?Q?pEoQkO3msBjRBWN2oepQIeqBTj1z9dTDG1gx21O1TFfHX3n8PZN4QtvEQWTG?=
 =?us-ascii?Q?cT8S8ww3+LklwahjAz3wD2On6xGeyLEY0GSJRropZug6wsZGu3x1wfxaHCaC?=
 =?us-ascii?Q?+Wk/kNLUBsHzpvRY7IS33h/3bj9TQGBI31ZSxf6CE5aziZJ2EPLvwJL3rXI+?=
 =?us-ascii?Q?pin61wMG8QKcutfbXxV/380MOCMvcSr5iB67Maj7wW+DAob13CxpNKA9F8OI?=
 =?us-ascii?Q?YrDt8Nx3SI5OxmkwDiTMSUp2rd4OBbsydmxySgDTMqBf3w4M/hFXEF++kttw?=
 =?us-ascii?Q?Vw8ZB/xdMJPtiomxXb145lyi86WoygaEjYRFJwqsKm4aXpfUdrbbfsTOguKt?=
 =?us-ascii?Q?HSiRDYvEO38llV/4pD6jLPx2ziK1kSGlCdru+7/MVSzFmydUZr/xKWsq8/d3?=
 =?us-ascii?Q?CaN1PJoVHCKBsRFanJF9jyi5x3CJIZl+5gF+m3Hd2L0s//RgaXNQgSZF1J9X?=
 =?us-ascii?Q?8tsSDKL+VPV8Np2GAO0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e6fdfd-477c-4a36-e900-08dcc22c2b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 21:56:54.5697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PgbD4azV/G3MApIUL2ViD1ySFItxqC4vcZ4Oo6bPaN/va66q3Nadcp2xhgR0Np/Ifagg6JPZLF7GuSb85AnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ignore this series of emails. Command failed.

Zaeem

-----Original Message-----
From: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>
Sent: Wednesday, August 21, 2024 5:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com=
>
Subject: [PATCH 00/16] DC Patches August 19, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Fix MS/MP mismatches in dml21 for dcn401
* Resolved Coverity issues
* Add back quality EASF and ISHARP and dc dependency changes
* Add sharpness support for windowed YUV420 video
* Add improvements for text display and HDR DWM and MPO
* Fix Synaptics Cascaded Panamera DSC Determination
* Allocate DCN35 clock table transfer buffers in GART
* Add Replay Low Refresh Rate parameters in dc type

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: guard write a 0 post_divider value to HW

Alvin Lee (2):
  drm/amd/display: Don't skip clock updates in overclocking
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.298

Aurabindo Pillai (1):
  drm/amd/display: do not set traslate_by_source for DCN401 cursor

ChunTao Tso (1):
  drm/amd/display: Retry Replay residency

Daniel Sa (1):
  drm/amd/display: Resolve Coverity Issues

Dennis Chan (1):
  drm/amd/display: Add Replay Low Refresh Rate parameters in dc type.

Dillon Varone (1):
  drm/amd/display: Fix MS/MP mismatches in dml21 for dcn401

Fangzhi Zuo (2):
  drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
  drm/amd/display: Add DSC Debug Log

Nicholas Kazlauskas (2):
  drm/amd/display: Allocate DCN35 clock table transfer buffers in GART
  drm/amd/display: Notify DMCUB of D0/D3 state

Samson Tam (3):
  drm/amd/display: add back quality EASF and ISHARP and dc dependency
    changes
  drm/amd/display: add improvements for text display and HDR DWM and MPO
  drm/amd/display: add sharpness support for windowed YUV420 video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  133 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   24 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   52 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   19 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   18 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   11 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   68 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    5 +
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    3 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   27 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    9 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   45 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |    3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |    9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   16 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |    6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    5 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1361 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  460 ++++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   35 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   45 +-
 .../drm/amd/display/dc/spl/spl_custom_float.c |  151 ++
 .../drm/amd/display/dc/spl/spl_custom_float.h |   29 +
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   25 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  497 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  525 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   38 +-
 67 files changed, 5210 insertions(+), 1114 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_o=
ld.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

--
2.34.1


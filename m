Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DA5C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E6110E4D6;
	Wed, 14 Aug 2024 15:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1faK0DCC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8C810E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 15:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7YxOIMAXNuHXaRv6VXd50djCJU1yUmcu6IlkzuqQgASq3gRhQiNp392l/ZYCd55L5l6DlB2cHWoTwEQcnLKyP3wAYZoL5XdUZphpk+/+usIrKiaCPQiKWD0zUCHxm9YM4IgjG16ST6qBs8GbnIO0/EEGIQdVlHy/7QTEnebH1D3EV5fRy/hM/XdQk1r/312S6vTL68zReE9qCxHEgVoxYZwKQueJlXNXb3L40OV7tcZwcA2HP9qss/Hzj8/uc2JoJph+HHHVlZOkUI/YXMfgehhsPHS82PWWboM7bfjEnRTKy37oYYrwFOz2MjWLtCZk/lzLR2rOE3KIB6vA3rLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEauWE4YhD3intGvgdrRdYUrSNRmLYvNpR6kwP+dPZ0=;
 b=IGZk0HSUxCWFJSb4OdCRtZG1vfUKE9lZwy+tJg5NwHfiq9LcdYkZ2caDaGVIo+YB92+qJwmqdZQ8sCzLTHXBAVLwjakzds8cEoIDLfyiN1d58RIMnZoOoVp4DtNwGrk8HfQBDQ6yMebLknYrKSBVndPpDQkjLbcf21yKcvRYAF2uuiDGVFsqeohtpAt63pzk52vMIaO/mn/dQMO3T+Ez23tGAVJPonW7KRB1pig7yTUpwCjVq8k5U01Rwp3zUUxV8fH0LgFXJ85QMO5fyynUYZPa6qz2oIG7rSgwP6vyHW4zDr06bxsYz8sV4M20W9JkUpVTSXtbsU0ff7yAc6Gj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEauWE4YhD3intGvgdrRdYUrSNRmLYvNpR6kwP+dPZ0=;
 b=1faK0DCCV3AKBFsvcmYXRtQklsH6yd540wFZwFDMrHUCwhxFbh5OPK73m8HDOeMLR1hAMDwhb1i1WHUpqUGeLjxCYgXHwf4Wv+Y+d4TC4pu27e5w+G9sZaZG4zSUPkNK0X1T+i/cceiQ9A0PDRydYmtfVeMLchXIRFxnn82+wSE=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 15:40:26 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 15:40:26 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for
 GFX11
Thread-Topic: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Index: AQHa7bKk/Cs8TqjNG0ecwHioILGo77Im020AgAAQeJA=
Date: Wed, 14 Aug 2024 15:40:26 +0000
Message-ID: <BL3PR12MB64255B3AB6636C5BB2608775EE872@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
 <PH8PR12MB7112428270A7AB50BEAA68848C872@PH8PR12MB7112.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB7112428270A7AB50BEAA68848C872@PH8PR12MB7112.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=65eadb7e-e6b7-4d7d-ad6c-679c62f9e2ce;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T14:31:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|BL1PR12MB5995:EE_
x-ms-office365-filtering-correlation-id: 66d57bd4-cac3-47ec-56cd-08dcbc776b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZN9ha6gByFjTkJyKgooe/P0USdNL3BDdlcf4AcISZwPqIncccab1GYDroSxj?=
 =?us-ascii?Q?VGRmAoOqcAyRABj1ZJyccby+5N+PZMC4UUapXKecnybFXZS6s+F03lqcOO57?=
 =?us-ascii?Q?/v3sG/6iCqJLyMf+UvUDiu+XYxzOHW53OdG2tcg+zuV6Oz8GNk5KwOMWUOyu?=
 =?us-ascii?Q?dqR0XkzN8uV6m+7PiO7aSNs2GVOKT6zlKYAwKD2GcOP3HWMbzgZ7GucJdby/?=
 =?us-ascii?Q?yBand2hUlcRwHHy59Da83nl+CKcJ4YiRBESRvZ0mmZ2pNGxB+4fbldwtWfOL?=
 =?us-ascii?Q?cgiu+rlShaFZUi4Fmtyd8VhIVBN4TYusXVimH1VdlR+IenHPVXaiS1E/Vkok?=
 =?us-ascii?Q?Vn5KNXq/Gpv4ijk9NIEDj82NB1XTSjsGgRSzUa0++o/P6LSP0KQn6e5p6FgA?=
 =?us-ascii?Q?TrF9C2Ptaoe4LlmOapNlC4xZ4yEGssYy6eL5D7JQz537hDgF/HXj2qppQ6VE?=
 =?us-ascii?Q?g3tOX2qrwDwqfe6qp9M2qNFO/U9YzMmnrBpwY9xbiFx055aenxB8V7Uf9Eb+?=
 =?us-ascii?Q?7/KUE6FONlNbCtzaYDIacP9Bpm9cL80BiTmtbE+JM+AGED3pEXH++DqJ/a1Y?=
 =?us-ascii?Q?42EZTCCCkTb+pib1Ie9XFFMxWngTlWwUvt6wFY9nI4mw3QRlP3ci8pjMOT7p?=
 =?us-ascii?Q?AbprFQAnhG4uVxvuH5hUSg3Nl2e2JuzaXZzXpYhmYvSjxeBL9a1eBjv9GSdx?=
 =?us-ascii?Q?51frigqzDPbusDUAIhrs3rx9h+ozw8RCTaSJ+IsQx8PS7vqQil4H2/BO2PiV?=
 =?us-ascii?Q?wnfXBO0Gc1sZF/DTY+deh0DmtT7QLWmk6d65tiayh/0N9ieN6+c/V7CWCH3p?=
 =?us-ascii?Q?/vBRawPaqidqtt5dFt8PqDlDNPUsjVzawP+sK5SZYwtKgYZOS06/78NrtGTv?=
 =?us-ascii?Q?V7kQpVssvTdYDcGpWAE4Z3Qm4+mMNRMAQgwia3wKje7jYYgAFJRoFz1mYPZV?=
 =?us-ascii?Q?AF2uCtMZcq3+uYCun1m+Q7KBLMYU/yPk6muG94gvtzvHu4Dlk8iSU9SRWWqd?=
 =?us-ascii?Q?GZmAGA/KOQOMrR3gdoG6/wM5bim3EWo8yupgUhRPPFjj14YgaUNxYQJ3bLRd?=
 =?us-ascii?Q?IWKC4dMdKW3BVJsbyKpX8QiFxMURSN/cj6H8EqKy4YjcylXm6Hg1QHexfhs4?=
 =?us-ascii?Q?nCVFvlSYTuZsq7bmzsIcY4UfKtnvbhqpboeaR8IYMnrCRfkmPPZ8HYbG3Z3y?=
 =?us-ascii?Q?LPZjv7e/KSXB+rPqsjSVr3UNUD4R3yHPygA9Ugv068zKDuXYDgZx4btCR6Dp?=
 =?us-ascii?Q?wIQkaq2mVISLG+1pgI+ZgHxEs6kABufoVZE/S6NlhF3lDTkjUXlvLgNI8Tzz?=
 =?us-ascii?Q?6iiXha+hL907yVVkZngMs6HrgjGLFwBENPugsNYv0OT6MtSStgmZFU7rM2qK?=
 =?us-ascii?Q?9PAguQWBYH5SB8orwIvw4XhndY+dvfR7OmgaWS6E40+mZq45QQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H5SM392ef0QJ4c+/hG5R1x1sNJMQhDDtpZFvoZ2rqxAgm1uAlMQHPI68YTZN?=
 =?us-ascii?Q?/UGaGTrvZiJAp32/39HYPSs/TjWu3F0gzhgGndYhj8T22XlOaxOAZmkdujLl?=
 =?us-ascii?Q?x2DWDPpCVq8S5HMIJAgG+a/uXp0yXfHLlTcz1JV2tXDHcCv/g28GNGJIV0OH?=
 =?us-ascii?Q?mKTf3pZZHLUeg5gyiut+yF53nzqGZGxxYG8gqt4ggtNoQtC+7p0/r5mRTxHQ?=
 =?us-ascii?Q?LfyjakYQKXgMo5VV6yOKCJlzZ/1zu+iNPgpr0YUWVut754vdx85VUx7Lpr3r?=
 =?us-ascii?Q?480PeY1HAiwNR6cPpZgIe9kIs1wKZf1hB6xAc2UJxzbi6Y4tcc586UUjauGn?=
 =?us-ascii?Q?VN6QNOnTAwI7a8bg8sGIu4MTvhG8VueXQS1lHP5ywP+kx6ffHbL8MU6GKcVI?=
 =?us-ascii?Q?jjJe5LiBc1MhlgVLjgCT54bSCorMUA+cIVawX1U1QHy4c4h8RVyskBmZLdyM?=
 =?us-ascii?Q?MiDcPHDFy7OGGH534gaiQhGuR3bUEpYih3/HVKIpLbPyYke/niOZeHnlkt+9?=
 =?us-ascii?Q?9OcxsHmnjIhW2O0OCPS4CqfB3bPyZmtwoactd+z0rblyEuXFpDZ7WQWOaXRQ?=
 =?us-ascii?Q?USTvu5/3anfszlg1+9OFB7rJimquKYJzRt5W+uSLy5NUkEjT9GuAoT5sS6Re?=
 =?us-ascii?Q?ji92lbFopvmD7Rfz4zpo9KV0KUEh53IeSWRX5tCWSl7RbONKjmA5NES2QTvb?=
 =?us-ascii?Q?Fort/8qIpfeM+2oMqUAUOrHrzh9tHuZ0AWmxpzAf1XLz4qVWQPCq8XTFcUl+?=
 =?us-ascii?Q?ufzOxl0kD3DDkxZceU2bAOoR92rPY1yetel578Z8fk5eOpjQyqseVuB3qacB?=
 =?us-ascii?Q?FheRngiNhvrzE5M/u6A6VzQ/Jt8tf8xnp1/ylrPZ5fWWRHqdwD13MZOzWArg?=
 =?us-ascii?Q?mKUkgg5J1xs10EJ4XwP89PJvNN+8s+yjnQYR1amg1x0j5CQAknkHKvHbnaS1?=
 =?us-ascii?Q?/jv3wdlLyn8suWLBS/plfgHc/gRfqiVBit0+/LZr2RIh62D4ME60alU4aNSa?=
 =?us-ascii?Q?dROFtfnldMxtSSYZqPeIKUKqXSBwHPXklhJ5me5t05KCoayA2wGrphtl6CSy?=
 =?us-ascii?Q?IWtoKgHrNdKozbqlDxuRJRuwoqUnErqbLLpZAW6EEypozgWT5a/nm0ZpDAvG?=
 =?us-ascii?Q?8pu4OzFu3JCwwch8dfjbFesJ7ObQp8nSXxCi3cFME71/bEYUAzQLzp7NuH8n?=
 =?us-ascii?Q?BQp7rxP1GhyaSNsZDmzOkQZPfACDeLG26xtoraTvmQB5892QpnWSbL2acA5g?=
 =?us-ascii?Q?iukWAc+fNSqwONcgGR/XNY4LyJOBA0mEGi3v6a6IAA7XvIvHJxhsLfyZhkdo?=
 =?us-ascii?Q?rRvG+3k+4NWNVDG4/sB8p5lDZpkv7jG8P+8B6kF+ubezvM7C7V0RGHwIAMhe?=
 =?us-ascii?Q?t79E1zRK8cEQFNmTRRONtg9Vl0eTJl4vm5PdV/CMn7ld1ZF3Ss0KWIXgCBvq?=
 =?us-ascii?Q?QiTo6ucwfoIPTONanxrOfuKy7cqwcMFzUcxxP5kYJhQd3YVpE54NkQFOnE+v?=
 =?us-ascii?Q?rCqG3sNyy0KuHjulUEko/pbNqX7KM/oKU1s0vUrBm1EH69QfDhuOURddEMwT?=
 =?us-ascii?Q?8kA487Mox+L0oPahie8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d57bd4-cac3-47ec-56cd-08dcbc776b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 15:40:26.7886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VC3uPWkK+BSYYiAyM2vnMPtWjMPzkQ/Z/YJPMc6CgkAM9lOZxglUhK7Erv78FN72nPSojfzlXug0tL3Mh2QGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Wednesday, August 14, 2024 10:37 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume
> APIs for GFX11
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Do we need some checks for FW version for backward compatibility? Apart
> from that a minor typo in the commit message. "Support 'f'or GFX12"
>
We usually do that in the callers of the function. Having said that, adding=
 this implementation
requires me to update the code during suspend/resume, which I missed.
I will fix that and the typo in v2.

Thanks,
Mukul

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul
> Joshi
> Sent: Tuesday, August 13, 2024 2:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume
> APIs for GFX11
>
> Add implementation for MES Suspend and Resume APIs to unmap/map all
> queues for GFX11. Support or GFX12 will be added when the corresponding
> firmware support is in place.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32
> ++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c0340ee3dec0..a5c582674db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct
> amdgpu_mes *mes,  static int mes_v11_0_suspend_gang(struct amdgpu_mes
> *mes,
>                                   struct mes_suspend_gang_input *input)  =
{
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +
> +       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
> +
> +       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
> +       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gan=
gs;
> +       mes_suspend_gang_pkt.gang_context_addr =3D input-
> >gang_context_addr;
> +       mes_suspend_gang_pkt.suspend_fence_addr =3D input-
> >suspend_fence_addr;
> +       mes_suspend_gang_pkt.suspend_fence_value =3D
> + input->suspend_fence_value;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +
> +       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
> +
> +       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
> +       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
> +       mes_resume_gang_pkt.gang_context_addr =3D
> + input->gang_context_addr;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
> --
> 2.35.1
>


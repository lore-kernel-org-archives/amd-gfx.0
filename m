Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D22DC54788
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 15:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF43A10E95C;
	Thu, 22 Feb 2024 15:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1L/cogp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FBE10E95C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 15:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll1rPK/PDYZXYxVVTC604KmTU1F63FYg9G9akgUKQN4IdXnGb8kwKMJADlYWJqsUkWuZQeSagWvevMZTsEqMQXKYO5PiTU37C/SFmTGy2zyp0JZMu3jGrw8Tuqiq6X6MMnAz7UFpgOnePs8+lFTrX9XoCHWgb4E3tizzGZgVZgFRqEx9NQU64nrBeZ+ShGMrricCWmvWq4I/eY+UE5v7fuddafIxSIzlKc2fcp+TbPQqEj30R+pqiIXCdPnYQ6HcTkMgCA1dzaYdk87GP7ugNY7YyCVGaOCTDuEwiqKqSRnMvsEwixU3n9tO6UtNFcDZUzzC1anFFEc7OqAlRCfTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDwxvLW86D04HLS/LNmhlnkxTQrC27MwpHPUsy51LG8=;
 b=mWO36pUUW62L1pFYCDA6Q1ghtG9ZhzMQvAsaTwy69aItzMLox4gpzFkZVWym4VV66ewUl5Pln4NZDAMR9ysKMBzKtEX2IySRCYdcwUEn0zZnTGFLO28uwY8Id2sM3lH1MFYYw3uxMQhXVkctDgqbhI1Hagr+CMf9Jq64nQ/iR536EvjJu6upf6cClQSaNCwAyj/2RQ+qbTAmLlCpDxWUwzr6C8IRrRMpsccwBC/aq0eFB7METmGvMR4acMDsbI1gMoCvSK5t0OlsUi7l3p2pT/JhFHMTApGyYwBqGLI+GzNm04Z18B5ph5t1njdFc8uzNGSo9s1EUmgQOJlWNGipuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDwxvLW86D04HLS/LNmhlnkxTQrC27MwpHPUsy51LG8=;
 b=Z1L/cogpjAKSheNIVuprcUrpJdHx9Um2yMgupT5yYwK40EDTY2frdtEMBp7KpJBS7dqm+qylNb9wWyeqvaf8TKfengSKq/K1B8HZBBmaJCjwoVbeby+icRmstzY9AE4X9jnyrefIN7nHM/1dD20Czo73hXaimcNA5rKvtaD3T00=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:02:54 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 15:02:54 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhuo,
 Lillian" <Qingqing.Zhuo@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Prevent potential buffer overflow in
 map_hw_resources
Thread-Topic: [PATCH v3] drm/amd/display: Prevent potential buffer overflow in
 map_hw_resources
Thread-Index: AQHaZUjnfmnxnTjplEuIbDy8TbyESLEWdWhA
Date: Thu, 22 Feb 2024 15:02:54 +0000
Message-ID: <CY8PR12MB8193159E9586B82CF213D3EB89562@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240221063850.293956-1-srinivasan.shanmugam@amd.com>
 <20240222043723.669677-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240222043723.669677-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=7b1f7c6e-8b29-4e7c-944d-a1c3f204ceb4;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2024-02-22T15:01:24Z;
 MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|BN9PR12MB5305:EE_
x-ms-office365-filtering-correlation-id: 7b6892a1-7537-4546-b940-08dc33b7592b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Hop6ZE2b5m4lyQEMs9znacBbTrZGr0krz2ya6EgcjcEDS+5F49OoAsk2uUwSRMtKUR5cwS5OXTIXvwhj/LrHPTRKaNRus1XmTGsGyBAdddJCDn2dqNCQGbpXtu/KiwC1MVirC5JD69lh6Dm7Ie8GNLBOpDvpFRmrcI0DAJPNwFiAz+h5jJ9SjX8UICHpMqBLEepwQ921BRkDnoU8UsGG3jzcaI/q6LD8ihVCoGzqaRgDSHhorXjJCiaZL2zxgQsOIBuC82tCkxrl4F+5STmL8+5gb1ghLcddkZrOJXBsCNUrE/h4HX1I8bKoQcawkpVkGNZImFyoDg2vLgBFPA6v2P1EsmrmFskR8xnJCWD1eGVzfMBFESNg7MecbIfBfP+KXGo8FqUJpB8grlxRFM91UoK+6S2Dba7a/77A9bEKOZH31Qemqqfr36YyMr+jV5FM4nOAJIHStnKaQzHKYAe/D1EKBnJjWfuP5FavRNe5iqPKz+1uVUz48SOT7nU0BevM7C2EIm/9BMn+fsIHedDjVvyIXQMmqU5ysx2oG6+4asapARph40BET2gFl7HEZOu4Rvh1rNP93LNtCA9X3IxANTc0DYihUIhooQ63QxM5Ba5r6DRxhKp9K1vQXUtWFNY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NS8D2yNCiMIrStFiQiAUiJ+tzBa3PG8uH6ITaOmZ+vAwCJ9yG1IwFVIasSHo?=
 =?us-ascii?Q?CmcuJdheepTKgxzf0mnGh+PNRglwJPQNQNgrYyr8g4Fosstf7fvcc09MJsVw?=
 =?us-ascii?Q?qzxEKcnEr3qwrufHriMiD8876IBwaeh3lemV6ShHXor0qLT8jSyawRv8YgzK?=
 =?us-ascii?Q?s54Gy20OA2zmoJ4mi5wJxrNii29kX+AnwWb5sFocvRc+zY3isaKH2qk1dHXS?=
 =?us-ascii?Q?LDeWnQn4yG8239EDK715vQCgC5lb4klAHuR8x5cssi/3+0NvhZD0+Rk4AIok?=
 =?us-ascii?Q?2YOWaxPCTnpDcOdpiq9Dp14c8AhS95WQY1sYjiOdBqtJPhejrSPPQOw/nDbi?=
 =?us-ascii?Q?+57Ezk0t6kAxEVNl1KvUrYoWnzah15KyI8zwObON1a3f5oNQlzCqWlBCsnyu?=
 =?us-ascii?Q?1mSafQeSz/ug0BjahqEmBrlWypUrjNMczKa8TEBoLc0qLmYcKwCh/j2cFWPC?=
 =?us-ascii?Q?roM7dwOWYaQ4ky2Cyqu27s5Prvl4cmjE+yesDCViaJwrSzQp1YjWVR9QoheJ?=
 =?us-ascii?Q?eH39mDKzLk3mZB8IGzyJWZ9HaILHcwiBvxHDCO3X2Jg80zf+bPjtOCn/tvez?=
 =?us-ascii?Q?66KGQP9l4qQ/epJaZv4EMRb8DKrpt04eqt9ay0yyrVLHPFs9p+F4n2ux49MD?=
 =?us-ascii?Q?qKnYzVUkopi3xyFgzbY/86Csj3QuhMwPWA38paOG+iaezW8W9TMlW0PYVukr?=
 =?us-ascii?Q?qsuGixOMF9GtSAUB2yfpoozc/9YE5R9gdanNC2EDG02P6EmYinlKRjbqgSZq?=
 =?us-ascii?Q?OP7YD2ESNnnOBgEiJF/5tsbecyZ3+X0wJYWf+R6+A/c6dsmO38srNMc4x/xy?=
 =?us-ascii?Q?hn09UR9VmSmK5Oh1T3rjtythLSwO8mwRcbMCoSk3VA5HrLcEg50beCvT7P5z?=
 =?us-ascii?Q?r4XU3jG4NzdVg3mt17Cc4hjM4LL5G6qEdIOOSiUQh6YXNK6s4OF1PcvK5rRh?=
 =?us-ascii?Q?vT6j9W3fg0vuD7HfZtrPZ0GzERo47RKD9Y2AoJiFtF//OJOmgpPOe5WcTsBN?=
 =?us-ascii?Q?EjQdO1QEX6pRVgWXA51s6UEsW5x0tC/dVg60M+IrKkexmM3qdxUXv0WKWwOy?=
 =?us-ascii?Q?MLt5CZbp2xdDQjB+udAJxS5j5wcGQ5Rx/c42FW0dQU1J15TE/gpa2TkFVCe4?=
 =?us-ascii?Q?tPx7D/sI8nw2OhfYq6rN5p9dnG6R0ao91f0NIlcMhETu6Ov7kjjahfAabZrX?=
 =?us-ascii?Q?GB2coYXhQmOeE270V64vneR6k/8uZsIAZ9rzsr+nE73rMN8FU/FK+lsQ62PV?=
 =?us-ascii?Q?khp+x8l2bzPTxyOjLF2jF/Pgvo/qxiIKJyxcsMRhn6OUJQSvZYAto24XMZcs?=
 =?us-ascii?Q?38MCHGBEiKlKl0V2CmjNwTzv6PunBBe8JIGRht/1nAc6Dl468MgSQrbLpWxv?=
 =?us-ascii?Q?c7NbXmwYBTHrtSxaNROffx1n5ZHhM8gylFi7kp/HXDTuBKpbwF8n/TXCTnWs?=
 =?us-ascii?Q?u5qE/xhwVX5Ihoyl50o2l8zKcBMrDkQR7UsLZVXZfGE2+WsDnQK4MnK8YVeD?=
 =?us-ascii?Q?iuAtdVZwtivr7g6Qr+e8azY8okR7bHsmmmJlWoskRxa0yLmNDZZJLOJveL+R?=
 =?us-ascii?Q?L2NEgAelYeIiUFXNMbs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6892a1-7537-4546-b940-08dc33b7592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 15:02:54.7785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IO0J4r/PqQxzvJX+M6HpEXDqw6n35aCbleLt5nevmKuvGdYHUBQOoHetCQRbGMyY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, February 21, 2024 11:37 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Zhuo, Lillian
> <Qingqing.Zhuo@amd.com>
> Subject: [PATCH v3] drm/amd/display: Prevent potential buffer overflow in
> map_hw_resources
>=20
> Adds a check in the map_hw_resources function to prevent a potential buff=
er
> overflow. The function was accessing arrays using an index that could
> potentially be greater than the size of the arrays, leading to a buffer o=
verflow.
>=20
> Adds a check to ensure that the index is within the bounds of the arrays.=
 If the
> index is out of bounds, an error message is printed and break it will con=
tinue
> execution with just ignoring extra data early to prevent the buffer overf=
low.
>=20
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:79
> map_hw_resources() error: buffer overflow 'dml2-
> >v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id' 6 <=3D 7
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:81
> map_hw_resources() error: buffer overflow 'dml2-
> >v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id' 6 <=3D 7
>=20
> Fixes: 482ce89eec1b ("drm/amd/display: Introduce DML2")
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v3:
>  - s/return/break as return may leave the system in a bad state
>=20
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> index 26307e599614..2a58a7687bdb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
> @@ -76,6 +76,11 @@ static void map_hw_resources(struct dml2_context
> *dml2,
>  			in_out_display_cfg->hw.DLGRefClkFreqMHz =3D 50;
>  		}
>  		for (j =3D 0; j < mode_support_info->DPPPerSurface[i]; j++) {
> +			if (i >=3D
> __DML2_WRAPPER_MAX_STREAMS_PLANES__) {
> +				dml_print("DML::%s: Index out of bounds:
> i=3D%d, __DML2_WRAPPER_MAX_STREAMS_PLANES__=3D%d\n",
> +					  __func__, i,
> __DML2_WRAPPER_MAX_STREAMS_PLANES__);
> +				break;
> +			}
>  			dml2-
> >v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pip
> es] =3D dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i]=
;
>  			dml2-
> >v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[nu
> m_pipes] =3D true;
>  			dml2-
> >v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipe
> s] =3D dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
> --
> 2.34.1


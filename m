Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BC5CCD187
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 09:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00F410E585;
	Tue, 14 Oct 2025 09:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ol6E4epM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD3610E585
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 09:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFhnuhCo4Oh7syyyVHD1gbMfuU+Ma8ogYsyqMjzrSzR4rv4Kdn7IqRH0V1ZLIzFo7Ug1PAUAT77feTFeRxFEmK25b5RCIHT1Eu3UELrgaEdafd+LEq4G6/7VjAodFYtBzmzSMR6RT2WXPG+2wjzm8c7UkAPSVYJTnacghRSNSc/XXBXVSKOM3zvS/3GmICHQNa84E+wYGQZPVcYilXq2qwwsXNmiOXlCQFnEkmPC/O7sgvy0m7Gau5xBBs/ji2QlPdgayzR+w9sOcNx0NVtoN326hEsbkwNLVRhVJldcOFR1myGpwB0H+pXgSBQNw5Tv4+5W/Rogh1f29SvfBsXh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2+bOEKylrp0MUX9xUkY9VUo/uQyteAhQIPJufDx1As=;
 b=eI2zF1v1pZjLpMYZGUO/Ps6JdDOgEMorpS4fgYRIrHMkt8TPi1KszkFwJ3JRTaR20FB/mQz4gk9Wz7Q69BTHOe3j2UGn65JQoKDT34sMQ/RGp1VldT8qm1A8j8E+wc9ZDYDIzL94b7to3/b8Nm/KAqIcMTwB6bKRdyWo1sU7qT1ooQge5KIQ48HyLfkWpTF3wLZLJtAMJz+Kw+b2188vuLtoKVMfGL4PpSwX/fs2DnfA/vEizJU22wLKkmlF+vAZ/VFupkL027MGKj8gW3IMH3N0Y6FWyyNZ2+iav8ao9Liw1dsihEvXyckynnT1ORw3HP8VoAgAFsHKo+Ebtu2MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2+bOEKylrp0MUX9xUkY9VUo/uQyteAhQIPJufDx1As=;
 b=Ol6E4epM11OarZcIG9z+1gfcOPbd+KvnViulmabMq/BKq+8URBSbDSg1YXJ8ZcPBbAiR+98b4GMaRgC+A+vjkYuHQjhT9eipLmweD6DD77H3LZOR0ApjSmGA6uR9FKoQNOrGDrCq9rTVkZRY821H05YZiXWgHubyeordEus4jsc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Tue, 14 Oct 2025 09:06:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:06:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/6] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Topic: [PATCH 2/6] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Index: AQHcPFxwIOvR74/BSEClGkvkFEpV27TBWsgg
Date: Tue, 14 Oct 2025 09:06:08 +0000
Message-ID: <DS7PR12MB600501942FFD6E9A0849E1FFFBEBA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
 <20251013161352.1628044-2-alexander.deucher@amd.com>
In-Reply-To: <20251013161352.1628044-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-14T09:05:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH0PR12MB5680:EE_
x-ms-office365-filtering-correlation-id: 5ff8f17d-74ba-4c3a-e48e-08de0b00e9ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vmZCEBGppy1bgjAJxFUIAzhU7r2RZdjGZqm7CtgsV5wwTSKjhm1nDCTsbObQ?=
 =?us-ascii?Q?DkWvoP4TWkNrP5kctYbR2sPOLxG4BdPcb4O9aRAVUeuu2zyv4cy+x010j61m?=
 =?us-ascii?Q?BWsqvYNQrS3a8/Qr/wssTk9lhxcVNScPZaargfVAql6v4YeacBbQE0B1bYec?=
 =?us-ascii?Q?cO8fmZ6KhlZi6ANaiGMQtD+VSfkNtnuTTZ3PHBLnVSoMeWxxfyTCSRMq9H+6?=
 =?us-ascii?Q?Avjqi/C76cWF+E0kniCqdtDkX/IqcTxJwzZ1KvBpOAJkDU/NbkSP22PYNu3X?=
 =?us-ascii?Q?FzEwXnicjFT0MIuG0NqRJjjBs9GtiTdSvyqUX683WmtMTEetzDfkJ4vX5tWi?=
 =?us-ascii?Q?ZCDtJT4wj0JKQgVT8vO+YFL4eRLeeZl81XjAyrl9afeeSpsVovk7Sy7LFtoD?=
 =?us-ascii?Q?IyIw3sa8W5YvzjFgQAkI0c1ziq2EPHROYZHzxMH1/X0VuZHvurs7fBeSujIC?=
 =?us-ascii?Q?FaQ5E743q/9cVFj4d+wd3az9U5/Cyq+bul+VDyLKBfeuveNKVDDUbE/oNPpD?=
 =?us-ascii?Q?C1e1ItGoLMNzLPF1hTuQqjDkoMg+iKrVnZPqGF+g9xYGdx5ZVh9R8ngiPHu2?=
 =?us-ascii?Q?tYk02AN2Ua+nkjpMO2YAFk9MvVq7UW9Dj/APosGw2eCREV26l3JJOSYSMWCq?=
 =?us-ascii?Q?hEMxFS06KDwL62WfAZgGx9nqws+VgZwwlVOFQQwmaBh7avaN/gW5RUuYlOEs?=
 =?us-ascii?Q?UQb/E3pJ84KI073ejrFn6jQQUWhY9qgwbMCdz84kG5vhGqFuCrUAsRZBjBiR?=
 =?us-ascii?Q?n5kPnpUZy5NePEP+96Q4F1f7EmOSQDfufrc58divqk/TZ6GY96Cl8OFLfOmy?=
 =?us-ascii?Q?zdxoMd/tLnA+1OYWlm9yHiN9LEbrI6pvmjOuEL/pXP6vztiVv/hAXwFBrfRz?=
 =?us-ascii?Q?lcVd1KHUYQYWDNm9dV1WWBEBTp3rXIjCHNCZNNoBqpN5EnqKCsycuT8RnhVk?=
 =?us-ascii?Q?uTIcPSiWqkbg/Neor6rzBjuv8rJZklsNt5H2ftsZyu0KdvdpPa67QBZtUCN3?=
 =?us-ascii?Q?15ffolT30Zp16tmrNG3o0STdE0w7L8xNV3Wh8zxUeNt5nvbWkr9z1EGryF3P?=
 =?us-ascii?Q?Hf9JShpYoUI0rtdLN/mUmPOXQ3mEWvJ24xbF/x/6I56IGG21e97ddkne5niD?=
 =?us-ascii?Q?MYVQUHmm9BBFT/wKuZnLLG3JfllcIHKqNXHGYD1Yt1TjXOp8En6Fyi/BUkIA?=
 =?us-ascii?Q?/olXan1JADr7zQePs7aFVc1JmT0C9Ws4THSif6Al/oB0eT4dxxe+7mCgH578?=
 =?us-ascii?Q?0Y9V5mM+YLZ9bSAnXOObbH5UXz1vEBKAl2cxUT6YFFxwMBxIVYv3jrAJcms7?=
 =?us-ascii?Q?lxVJeSdAZKJZOiDXZ/IkqkuAlCjzTE4q7h+DdjZtl5YM1eqe/+E4ki0E+f6i?=
 =?us-ascii?Q?3FxFr96IgqXtJgZZ8yS4dFgR/OmbBFRT/KOLu/NKTu4/WcYbP7nK/Fz1pc1e?=
 =?us-ascii?Q?e60tclPYjiWrNUFb0Qb3X0EulzFiNF5S4KqplRt7batkJvyTVENi9+tioFHp?=
 =?us-ascii?Q?yy2yZqJc/G+PaQIUF1iIWTTdKJrW816vK+2p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+RPQL2y9RhoB34hyUaYAlTyaGZDfG1AJ617QucF0n6E13llD/0sPTAmnoEH+?=
 =?us-ascii?Q?HyPcaHOgjGdLu17hmXM6DZIlY5Wy01T+ZUSItIEOKexI6lDDTptYekzx1As9?=
 =?us-ascii?Q?GLZ864zmV5RcdG3rdb0SjYWvMQ3aHq8W+VIfIXNdFNpifto2/Ros53mvGJ7Q?=
 =?us-ascii?Q?8jyjE5z7efDkseaVzGKlEVw3r20z8MtLQbmjm84jZDgCfI3SBMMj79vJCi9N?=
 =?us-ascii?Q?wwJWGBtR3YggicZhV6UAp5HIpLbqa2Zsub7RqwW3aD91S8tF0xoaBZH8l7k7?=
 =?us-ascii?Q?QrG2jnbfWJ6Z7jGmYMKXiYmLvc9z+JavpZz7+3DLD4QxvbPZNDhMEFbrLCWL?=
 =?us-ascii?Q?NQtgu/lDAVUq+AGj/iO6pJQn1wvyeQGwIt/nJeyRvMewNJOKOXCjR1N4WpP1?=
 =?us-ascii?Q?piyML7OYMRRcbbbJYtUMEFFC6PGSILkjpcnq65MlcDiAh5h3of7y4gq+APIt?=
 =?us-ascii?Q?8ooueTElThYP989W/tHT3HpDreHHpG9r2AKsyym0qfWlb9w/v3cMzOufll8R?=
 =?us-ascii?Q?EkPpvaKj7CzmGFdDPulkKcYJkWCfvYjOa5edEUyWSjgZOIe3e2VtFHgN2lRO?=
 =?us-ascii?Q?v9WaRRWiBRbNSuhUcO0CvyWHo5CkA4ryk9I9PpwiqQM9pVvRb6TSMpV+J9bM?=
 =?us-ascii?Q?PqsipA96/XAiTQeeVM2jnpNbwY7s76tt2wJwSuVr+kTnAe/+G7F0TpRPZObz?=
 =?us-ascii?Q?SXKqfdvjojCR2ZCuqXZdsDh4zR3Ynl4zVDljMxps3Nn3COrh2g/dhNFeekDC?=
 =?us-ascii?Q?EFxorThVLoU/vCLO5D3rHbuETgbXbEcAj9iL4bg0MsTXQbimx9cfTZgn5jHc?=
 =?us-ascii?Q?DsOVg/X8V14sgD4xt+OWZxRKEsrCgCp9I21yMESFkZV5tLFFPshZkMISbfRi?=
 =?us-ascii?Q?Mr1ICES6EOCP0cS0mCNNSC3JTMXQDpsPDfX+ZJqkZiWT35ZQG489FQ+28tCS?=
 =?us-ascii?Q?Lq/v2/86z6sNqh0ZU83rcpZY0418ECcuBv+qkPKuMhQSN0TxTxX2p48cBDNr?=
 =?us-ascii?Q?YJjxQvCLEiFanROMww68aRJGL3uAhJ/yNJyCURaGb/UB4nwHzVGpZQAOhpHw?=
 =?us-ascii?Q?gb4yCVN4JUEJj1z1+xKP2LusijNgquE1lBwH863vpeala50TMY9Rcu3g4Sig?=
 =?us-ascii?Q?0xsHbyZrAfIB9VrOWznxiCfu+bqPNhOV+OeXHnvcdAVndGgmRsC6G0m1hMFN?=
 =?us-ascii?Q?3B73RNYkG3QHxrcslWAAUp05qh+ONL9K9fBD9zlpX5XWEuxz03xXennEcH/9?=
 =?us-ascii?Q?OBJdWPAKpeZQX5oJKKFlir8gGH4T/gMpiy651GNvLCWSf+3miQsk+OQbQwn5?=
 =?us-ascii?Q?+sGFUDLapgftlISgQC3cGlUfSEccHEAeDR0er3eYsQXks64MHHcT0ySAzzjG?=
 =?us-ascii?Q?b1cjo3VFEusAtd8bsIQnZbuehSPhbu99l26u4qd4btMF6gfN0J6lkL5I/J6p?=
 =?us-ascii?Q?FCTRPudiBxYfbjgPaDQsETNdl8JD5+WyaCcbbmnGVk4bDa753mJExQEW6L8t?=
 =?us-ascii?Q?MBig9lvKnUItM1NGeuX0DFOA35LIbgDtGOjSdIVfujbWs5DFVbZnyMcGAqE+?=
 =?us-ascii?Q?FN5xA9XFNt2HU54pq9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff8f17d-74ba-4c3a-e48e-08de0b00e9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:06:08.5504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcDd+s3ReI4DO4qiKAs5xU17d267vU9wHf37SyBmSLQGhCa6wqX6KAhTrxCdnwFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, October 14, 2025 12:14 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/6] drm/amdgpu/gfx: add eop size and alignment to shadow=
 info
>
> This is used by firmware for compute user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
> drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index fb5f7a0ee029f..7109a2ad9ec36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
>       u32 shadow_alignment;
>       u32 csa_size;
>       u32 csa_alignment;
> +     u32 eop_size;
> +     u32 eop_alignment;
>  };
>
>  struct amdgpu_gfx_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d61eb9f187c64..001ffe3820be2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1052,10 +1052,14 @@ static void gfx_v11_0_select_me_pipe_q(struct
> amdgpu_device *adev,  static void gfx_v11_0_get_gfx_shadow_info_nocheck(s=
truct
> amdgpu_device *adev,
>                                        struct amdgpu_gfx_shadow_info
> *shadow_info)  {
> +     /* for gfx */
>       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
>       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
>       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
>       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +     /* for compute */
> +     shadow_info->eop_size =3D GFX11_MEC_HPD_SIZE;
> +     shadow_info->eop_alignment =3D 256;
>  }
>
>  static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev, dif=
f --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 93fde0f9af87f..f067ad4146454 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct
> amdgpu_device *adev,  static void gfx_v12_0_get_gfx_shadow_info_nocheck(s=
truct
> amdgpu_device *adev,
>                                                 struct amdgpu_gfx_shadow_=
info
> *shadow_info)  {
> +     /* for gfx */
>       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
>       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
>       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
>       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> +     /* for compute */
> +     shadow_info->eop_size =3D GFX12_MEC_HPD_SIZE;
> +     shadow_info->eop_alignment =3D 256;
>  }
>
>  static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> --
> 2.51.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA13AC54FB3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 03:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B0010E246;
	Mon, 26 May 2025 03:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WA6P/68f";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323EB10E246
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 03:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH8YhjbyRzhibSpcDWcakCVubTpb2Q6OuFTzJd54H5X2TlAKLfnMFCrda+Ay3r4VYL8HxKFLiFMzgwvH+QcAPDUyIdaaAhyRMuFIJrJcVRTu3pRzuE8pg6bessPC2htF1Oa7vThfl54TJeyAyBk0eHQURibrNr1ekdjBf32O4Is6HgUc8VZvVcV0QKagsgLBB9QtAwnwqd6YRynQfCqH7e2VbyM715HPmSWDvZ73KVHdY96KiECa/pwSt6iW1gk/Pm/xIcnhs7wgd0oX41kpmP+gy+Uu6sfGPcadVI8PA6oltt0dpM3tx5MwsssMS54pt1And1jlaNP3FlgSMsy9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utx2aEyXspP9mPXaCvJP3G0To7y7ANwTBFuXcmjP7pw=;
 b=kq4xl+vOwiDxLp/xETMbDj1TiqBiR8AZXPSfj5qGKhfeUwiJmwUOqjMoQV1PUikPpRSljr5KamqsbMGM9x+noPIrM0chWULL7Ck4grxel9PramW8Vbyc9MEwicUz3gB1IxACKsxl/EYvE9yVk3IP+kkwrbeqsuHTsU0mpQyZi0dPuAZhjAcyvaxBHEqf0FSuPH1oEvJcrafkx/Ct2NbEyGfb7ulW46cHiy2VNQ9R2Ds7Dil3OhFhpQ828BKHfWRTMqRtx0llBt8kAYHd1/mizMz+zhwmo7foU354qLwAo2c8zin/h8LhygllbXoxjir5jgmx86ge8y8Wvhx8CBeP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utx2aEyXspP9mPXaCvJP3G0To7y7ANwTBFuXcmjP7pw=;
 b=WA6P/68fWdcjEXg+KkLODYIp/55xsaIiZTG7Ihz/xCviOOpb5vBZjm1PaUds22WW9XXT76QxLzA6Zpi/lceMtpQ6pmr+h19Y/6llKNcW59iYV8xCXbfWJWrDZCIPgUsddwS2VpTlA9FIvQbyqmyJPYXYGmPPq+U500E0m3/rh3k=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 03:23:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 03:23:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Get mca for old eeprom records
Thread-Topic: [PATCH 2/2] drm/amdgpu: Get mca for old eeprom records
Thread-Index: AQHby5Y0wUe6MUveU06yNw5tSOzIZrPkPyvQ
Date: Mon, 26 May 2025 03:23:41 +0000
Message-ID: <PH7PR12MB8796471DC6CE8CB1573F1145B065A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250523035155.63467-1-ganglxie@amd.com>
 <20250523035155.63467-2-ganglxie@amd.com>
In-Reply-To: <20250523035155.63467-2-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c55e5b7d-cf29-4a58-a119-67210e4fb0a2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-26T03:06:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: dd16fd08-103c-4300-4958-08dd9c04b6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HSFLjjN0xa/hZLjV6ktGe2yZo4FCtGvYZKq7hsIhwUMQ094P3VGzdbtiI82I?=
 =?us-ascii?Q?zWMBNs1ZqoHe6vpljAuK3wX+j7bY6fYH5dIQIzgnaMwHU57H2duZXI36RrsP?=
 =?us-ascii?Q?YwmAIhmhpMHuSSX9K6DvnJ21gw6mpYBNjCJQ4MKlQ5DzmWA9kYkCHwJ8eG6X?=
 =?us-ascii?Q?QZvSL+lt5jf5Z/aCVz7cRkGYup9HODQXyoHw58zl4epcxpn7oF8DjDIjLDui?=
 =?us-ascii?Q?j4AclGYinUkQg9T7JszsmYECxQCprdhYR4pZOleqv6r11IFl9FALx7U30JGG?=
 =?us-ascii?Q?mj+h30nXjU3MxmtQkxYC6ZlKRGmooVFS5Sykjv3KTOFtxCLMJrtHMHQQFcDp?=
 =?us-ascii?Q?qH/r4mJaj3UgQK8UOghlkye+b4dIv8KhFFVVdJs/QRDcXdzomYSiFrSqLqf0?=
 =?us-ascii?Q?ljz++F/8Xs5SWatD7d+e4QeIZ7qi2hQy0ei6HpHnhiWOSR3En5SOBRYtFwVE?=
 =?us-ascii?Q?lUF1o/+jes1+MfVEkWTfr3dMWISdCpS6dkq5g9cSauUHrVwQxMHeK3T1DAfS?=
 =?us-ascii?Q?KDNFTq8FtwqLHZGkG8uY29PQyNSic+lf5VKmoWO0UeyAlhosDZJaxkjT6IPE?=
 =?us-ascii?Q?KgUvUj+QuVDYuR2CIQv38e2gWxuRIzgNyb2mLNasyzoG7KAWEZwki30N+gX1?=
 =?us-ascii?Q?ZLm2JYyL6zKFZTA4vGoznSXBodoLBv4BVYR/pfNPx2FdVCLsOZKktcZiltBV?=
 =?us-ascii?Q?fOjFmMDiB1C1J5s2qYS+yeCnLWYtTYUHhCza1NA7g7095lDeBTGeXqnv4Q2G?=
 =?us-ascii?Q?V2xVqNmzPEtdBqqVqKqZ8qqQWICXbjtse/MOMAe143hqE04Seia8nkCZYMcp?=
 =?us-ascii?Q?5zy/B82P4LSUYZu4PWsPnB3CWbm9kMDEjkG5DeIaa4A7FnG4c+qkG2H+qdz+?=
 =?us-ascii?Q?i9/unHWys7oztZ/2BSWFsAhAAaDeKWlF9V+757pufWA9phrzVuC/kG5AQUHk?=
 =?us-ascii?Q?oAsSMDtWxU3k74I8l9BZjBOV+eSQ5yokaDVe5JSmHCg1lVbsvQ/mNyo2EmgD?=
 =?us-ascii?Q?hVrblkDhoe21CB8n98ngx+CBby86X82sOMWI0L7SsJ7bn3aB1kCh3nVnGUC1?=
 =?us-ascii?Q?gkEzY7Ih3vCqiVgn4OwNLEtNchHs2YtlKJ02unZ7nrDraWDiHx2jKFW5jm8D?=
 =?us-ascii?Q?UDBt31Yc50z1fRJGR3KT+9TpQncdn6Fr1w2bbhliu42ZW2cBiQQDvDCrudu/?=
 =?us-ascii?Q?AVpsJ9D71YDnv4d8NQRCfq1u8FX2s69nJ1c9v4/TTx/9Yiat1ZWAZYVVlxuy?=
 =?us-ascii?Q?k5QdHsUhJyE8Pt8xaGi3Cqpnyq3mliJN2UG8MiKctMtsFT/AVslTYH5zA+ys?=
 =?us-ascii?Q?noyPP98EHFIo/M8My7Z9NluKHez1NFXORNVMvk/5CQo4hzEMKzYq3+X7TTBl?=
 =?us-ascii?Q?S4iy1dDX23/Mrax/Q5NfXAhUw1HlWLtATSY/Vy1eWZ7P8J/EJJ+JulaJvmGa?=
 =?us-ascii?Q?3M9/22muHHju1dBZod7nJaBCn7B0pMuJSP0QMJMoxgNwNSNni30DIkUDMLfv?=
 =?us-ascii?Q?Zrw+gGCTVRDweIE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BaGcbSoAzJpyBXyVrjF71P8+Frv3MI+0BycfDnED0/2vX+pTNKMbZx8zSHvb?=
 =?us-ascii?Q?NYDy2Edz4rvtRSl631M2qasePK85ylZF8it/QRTZkEFvvriBkOFaGFz8tp/p?=
 =?us-ascii?Q?SpkWV+amCAAeuKoySthgLob4kFCDsqssQrbCiXTLRsw6BQ8fnJp2EdIbkbBg?=
 =?us-ascii?Q?gQT1SssrEas8MOvVbRzMLEdtgSq/rH5oaf40xBl4zvbCGlEkY/x4MfUbOpDp?=
 =?us-ascii?Q?U1CBYkbraS4phQ/luTA8idV++N3eR0X+wF7w8ua5y/1d6IQrr7g5XIDO23+3?=
 =?us-ascii?Q?Lzccb2VtOmawB3dbK3bL5gQIlFJuGnrW6j8xOCZDi/ZAx88nrRaPrEQ4QtfH?=
 =?us-ascii?Q?2vJ+9g4J6qxqyaOADRHY9S583BYqFMnabrJyB4kbqhWYQjT5bjHqs/qXT87w?=
 =?us-ascii?Q?6tLhjeDCLTB0hRSd3HN5q3ztyTN2SHhDUCiy69W4g3EFrSY1m8dtaaKYaURx?=
 =?us-ascii?Q?EPv20spvb7YhxUsohuv+qdLF1QrjboiRdOggIeHM1UEGLl7rgyS0rOiu7ZU4?=
 =?us-ascii?Q?iQSSc1d/TKfbZwoSvlPKSy4I2gATPDReODSVNGKaqmNigLaLNeo0JNX9FDyc?=
 =?us-ascii?Q?+XTWFjb802fPbygQjZzVJLbTBQss8Eg37bjB0KD8plNeCdhC209ru4cnz1yy?=
 =?us-ascii?Q?I7pDWO28IN4GNKN2MdXOQxSFhPsqfZ5+hEyUQpydmg5yIqx7xjohluyfrkGn?=
 =?us-ascii?Q?frU5nR463rM9PWB/0kNQmbrNgKDpUcWe8VleBNH3fsBUpd27KELfmRrAtxsp?=
 =?us-ascii?Q?C61fVHVLYAB1G1kqY+pcy8Y2DKjTcWcv1elLKamrohnlbj55521ADIYMocmd?=
 =?us-ascii?Q?sPgHYT0ts2x7uvJW0wWOEkvhZi2fw/MdTKRIo76ZymQ/ZfnftxAHwVVJMJn4?=
 =?us-ascii?Q?TbFjTo8Y0tVQQ0BH65EPnIEOSoM2DPkQts6tbh5l852t2Q/skA3yWPHascI1?=
 =?us-ascii?Q?HE5h/dOt3lI1AuSYu9BXjUVdsHyGQFn68XK3vRD/rgSDqT4a77Mx/CmHLJF8?=
 =?us-ascii?Q?CSIbva2P6UC4dPCR7A+We5zkb5eoVvTyHE/FV88cVLShJAxedKqwxaEvx5IE?=
 =?us-ascii?Q?4+78TP/4gYuIBGS5opD+vjJeCjJw19JERnSN9wTh3BMMIY6OwjQanCTqIOFs?=
 =?us-ascii?Q?iiJ47HYRpAWNaIt3oBfzfzEn4ooeYPXMbA9Tb5YplyyA8r3QMDKAZpZ8a0h8?=
 =?us-ascii?Q?LhZ3Dmn6pYZYbtWREUSX7JQCjh67XRM6NQZr7NBz2kFp/JiNKd6IIuqYgzHN?=
 =?us-ascii?Q?OI1YBa3oycDNZ79JUMoZsr5uQi/XbyGpjCJ9NT3tQx9S2uu03mCti72vPZAN?=
 =?us-ascii?Q?0uqc/r3WpJRXy4+N/V8hh12UD29n9oXT+KVg/47gI+2MeVPb8rbgV23tBDA+?=
 =?us-ascii?Q?HqkrOP99emuVYEr3TA5+qHpfa5uiFTVVJly6qoSpkj0QLGZb27FAGrz8q0Uv?=
 =?us-ascii?Q?LLhXZrigTsIXHn9EkCwpGUfyBehTL0w/pRH3tYJuAiGlJMO4vkApx2R1snEc?=
 =?us-ascii?Q?d6GdsBx6jxEF+Zoxg2OSIHKfX47aYBiltyuXkt02F5lpXRmPcy8Pu2CxHCo9?=
 =?us-ascii?Q?hPaDK89lf8dLjmIyttA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd16fd08-103c-4300-4958-08dd9c04b6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 03:23:41.4385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: If5q2l8BzI/bOaJ4PVOF/zi5lNu+J10IinN9o2GdTJ8WRaBDNF5ZO54yROshxrcY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, May 23, 2025 11:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Get mca for old eeprom records

[Tao] change mca to mca address is more clear.

>
> after getting mca for old eeprom records with 'address=3D=3D0', it can be=
 correctly parsed
> under none-nps1, or it will be dropped.
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7d4d31c6ab48..f943b9107067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2860,6 +2860,12 @@ static int
> __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
>                               return -EINVAL;
>               }
>       } else {
> +             if (bps[0].address =3D=3D 0) {

[Tao] better to add comment for the code path.

Apart from these, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +                     if (amdgpu_umc_pa2mca(adev, bps[0].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             &(bps[0].address),
> AMDGPU_NPS1_PARTITION_MODE))
> +                             return -EINVAL;
> +             }
> +
>               if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
>                       if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE)
>                               memcpy(err_data->err_addr, bps,
> --
> 2.34.1


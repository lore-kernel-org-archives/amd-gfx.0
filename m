Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE64CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C7210F9BD;
	Fri, 29 May 2026 07:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdFYVgti";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A93E10F9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIgBfwuk7NWtiln4jIGQeOsYp7Wlmg7rZgAwz9qiFaSYEqU1vLjiIfIEaiFNQpY6SsbuTKcHqvjARdwZ71CTPJOC2bbqNFibRnulOUqtAZjVssu5Cxv4YNk+n79wqr8ccCsQa9mvPXXioY/fzbFbUvKCaZ3HiEiwSMmrfXjNVFG+21whvt7eREH2lUVNydEbrPM9UG4wvh8J3giKP5QfM8Oxo6ACBLSo5EppF8IEmzfvyjTiLAvJG/ekCLKjwYLOaK4Thls5jSKIdD/gJxCs8npz+VRV6iCKNdftTvMxXHSAF2FHuV2GoD0ijI+BZMsD47gvCBOsbK/vhS0GwM6J4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTq2ZMOKxmufDeWNB888WTMI43M8dr+EJZDvBjsY+34=;
 b=nTe9/70jeNXq6LlwWYBytf0q5OkCEn5G3riRLmP8/sLhh/sV8D4aDot3wMHbzbt+V80Hxjt7WlhHU2CQQDNe0Devi68H99WwXliGqff+drNB0rW2IH9C6SSzR/xX+hhkGYZfrhPGEBg6xbbx4dsAp5MLwHSUFX1EtkuLIoU1+MEMLwu/zw2TT3OdIqxMG9vLqlbJ2OMvtaFyjBFpVlKXR9fbVDseh2hsmCchxZhTnY+3lQedimUbbmN0izO9Fyq0mgSpTrLJQ7AvgtTyEfaIOa5DblnpAuTG+lyTBqir4JMm5aQ/KJ7BUUFCzHoD393yoVUl2hqpBLH4HSpIz0mCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTq2ZMOKxmufDeWNB888WTMI43M8dr+EJZDvBjsY+34=;
 b=RdFYVgti6pV69KK86L+qpLFacQ/VPfk6d8L2a6YU4NqsSLqPWdYfANwd/HMoAA+O0v0Pd9QjUqaSQC40CQb73IGnb8u7AoKgqttf9QA45O5wFFJIgCd/RbkY0S4WSEJXEyRRtIojeKaUylM6a+kKXdZnXOP2tTMqWoUzGcAjlCY=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 07:02:11 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:02:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
Thread-Topic: [PATCH] drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
Thread-Index: AQHc7zM/9x/o0lVAh0WuGO6w97+gtbYkk6PA
Date: Fri, 29 May 2026 07:02:10 +0000
Message-ID: <DM6PR12MB2972EA423A40C5E8A5D45D7282162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529062008.357699-1-asad.kamal@amd.com>
In-Reply-To: <20260529062008.357699-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T07:01:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|PH7PR12MB8156:EE_
x-ms-office365-filtering-correlation-id: 682fa998-0ffa-4be8-a6af-08debd50348e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 5fimFmJVACQY+ho4jbf0QwP6ej+GLvgLzdFq9Rz13B+TaQ62Z3tiF0VfUbFAmH7CYn8DV4oZFIbMdw9OnmXwgIyS/HLEaPvOJw5HZOnCz1ZNcr6cXxIzpiAtjV2FFCuNyalXY/y+Z5qahV/Vu/uYmKd+iAC5xpJTXFIk2Y75SgV0m2Lm/sfwKDWVP25h6jGZH14nmYiKE+HByR7vkq/U76abBfshoQO6HA2/2XLwlU84XzyirK4/fnJSsU5NiEXafa1OGVYp9QkF62ej4tby6i2x0MV6Qbg8qu7w3dzebovQPWMTM/sYaYjmVzppteuSpzoKtdovfuoFG2SYt0acNFHRbwm76eslfw8XKd06rf/OOgmM7SiysJaQUpxFReAFTKORlskdeIoQh7+p2EsOgg4IUzlU3lsFIK4+Aka4rX2s9X+X0LSs35YIKS/X5yW2A5D7Yyd1XoSGHzb++eIDJwTADmdKUyqtWrV3Gp2AAfLxHn24YCPxm7Z8gP5PyVjgKPAN6KwOVcdY0wzETpPJIGJnMulOzA3gsjwvIdUAnp/CcyC2tifaPoH+4e7os74hzHvhzZ7hsNHvZQAh//lOazwcCid8pFolHoFPrplPJwC7ltQN2b6ziS/iGHY21PxTsbGx63TdgWzEIoOAKyTL9rOUtNPzIUDUnPa98dr8sT77Mkqhvw9nPuX/Mv3etKgpbLEVB+0eV/kMpqJmrK3vi+lMVbZWQTBB+e1ttHwkJYXhOx8VI4ahc8fCgx7hkHdv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1cxGaj2MU1gSJo/jdIhJUuzqjL7iRTl4i71UHN4Um8vyEVqVnKauIBVZoCOE?=
 =?us-ascii?Q?pDf5zJM/HOGRtGgDAn+G6WrfyvC4kEFOqqI+YK0026EfPwvsu0SVe7bW3E+3?=
 =?us-ascii?Q?w05fmEhxkQa0jkeoj79ovt5c5wSnsJHN99D1y7Tg7I7bh/201YHaGY4teEmQ?=
 =?us-ascii?Q?7F+RR53lWZtX8kKUhOQZrh1cDO1mrh0ud3E5PwwGrJtOyrXwLGgZtk9+Oj0B?=
 =?us-ascii?Q?lwL3xYuNXL1uaDA2XTZEToalmD3xgx29sYyk8pGJFo76M7qD6uCs7nf2dr89?=
 =?us-ascii?Q?kMoVUh09MxqgmJ8RuMQY7DtVWiEKAzRH7Q62pdC05aRT9JyDEREHYcQSHPfX?=
 =?us-ascii?Q?g0/Dn3PNDbH3v2SzzcPqkCVYtMGn/1xPePVUQzDMNkD1ueq59Epf69doDGo7?=
 =?us-ascii?Q?Y5Kwn03p0fuRUNW0r6rTd6N/3Ulj32Gn2z93bWtLkJ4VsLXTIHZm/hXSotGM?=
 =?us-ascii?Q?g17Gs4IJ2KVDCkhh4CxO99DwNf9eJPAyenPy/Q3qjPx28OKBpq423ajbO5CA?=
 =?us-ascii?Q?TLqdiSpHsaepFHhvtsKugpKbEkRpieEP9aTOmHcb85+oY8ZovjMpHVYVXHtu?=
 =?us-ascii?Q?T2eBw0N0l9WBGPs/korY9NwTpXFtMZe3OAqnVr4q+rk0DxEmXpZ0MwEceOVo?=
 =?us-ascii?Q?mlyDU8qN7Ek5gDViiOeTKIBCrhQTeK6nzKPgrplI32lcROYt1wSArsPD+94w?=
 =?us-ascii?Q?RaRkWLaK9VaJ3/5DojK21k9UEBc4PLhTzTozo+SOm4El+TXwCcZqDVf8BKUp?=
 =?us-ascii?Q?jsRifWsa6pGmjqNN0sMzR3oIa3f0ZKmz/gFSgqzkB+pmxoa+A2gAi2yqmAE2?=
 =?us-ascii?Q?Rg9bIWiXjZ8llQgVNscGEWNnOZbXYfEx6bD5hbZtlf/vbaukIANnXIk+LfJ1?=
 =?us-ascii?Q?5FH34459qhptfe/qmI7nhCwsHCLYEbWWwTQ55pIPpmuu27knpONHByUGGr79?=
 =?us-ascii?Q?3ZiTFZl2Hw3sWYQph9HFHAo46FfJayPdSxtt6WqdPw5f+jU0LE/sqIo9xsra?=
 =?us-ascii?Q?s1JPEpD6+1drYHu1H9fg9Eqzzssy0+rtD4lCfHUpwcPS+/2hCxOZkyhsqjjq?=
 =?us-ascii?Q?onwhFiS4YPPYq78Ka7Z0BhzLEoq4QoBypUV37QlpGhKEFyZuwN+wIjF2MycT?=
 =?us-ascii?Q?Kk1gQ907aUEVc1GlCQQEDzCX+uX6QnSslL7bEP9K7daYYniEDuSRVaCFH59w?=
 =?us-ascii?Q?TqzmwEvQr+LH54SOIM+DcPRqAqof7RXjNVMtyEDYa6uVaHqEn4OHJM10/Exo?=
 =?us-ascii?Q?/8xhVvYe09vKqS0DMeEp4ZZhR1KgkixcS+KuqzwS7KtfRN/zbba0CHTcqlN/?=
 =?us-ascii?Q?Z7KBFEfZYNeZxJ2Tvf84A0XnVK/eaBg//XNwx7/T4xvlbSF84t6/fULw/dnA?=
 =?us-ascii?Q?UkmpBPznOZ5K160jLUKLiFTVk9VozCFYpokThiZ+dwRhNiR3V4CgVf7qczuw?=
 =?us-ascii?Q?Yv213rz/Il+uTTAVpTmSjbkgcDEYuMTX5SV40rjSfphSynvAToBdBUst3JpF?=
 =?us-ascii?Q?0+ZrlczleT6ZIEELo68e1RAlpcHjzeVunq6xJri7ID/NJvE77uYkxhk/2l8k?=
 =?us-ascii?Q?nT8ys/f4eNwIbkSkH09r9dSCUUmWupUG+S65ZEc5JqRzhQv8Dzj9Vh2Pd4NN?=
 =?us-ascii?Q?oMp40CmdbvomtlZtPPHuY1HxA7L0Wo5zcS0gyNdQn9Z10ICds6lPMae/8w2H?=
 =?us-ascii?Q?klDWJ3FxPLIdDz4Xx5o3cOlu+ZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682fa998-0ffa-4be8-a6af-08debd50348e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 07:02:10.9392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhFgpC8+EujxlWUp40U9Gz3K9XKKTb7BLSwHXjrgsD7p/pN5o10VDQUikTy6Laz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 14:20
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
>
> The powerplay path allocates hardcode_pp_table once with kmemdup(...,
> soft_pp_table_size). memcpy(..., size) used the sysfs store count (up to
> PAGE_SIZE) with no upper bound, causing heap overflow. Reject writes wher=
e size
> exceeds soft_pp_table_size.
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 3ee910503775..35974fd02b27 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -665,6 +665,9 @@ static int pp_dpm_set_pp_table(void *handle, const ch=
ar
> *buf, size_t size)
>       if (!hwmgr || !hwmgr->pm_en)
>               return -EINVAL;
>
> +     if (size > hwmgr->soft_pp_table_size)
> +             return -EINVAL;
> +
>       if (!hwmgr->hardcode_pp_table) {
>               hwmgr->hardcode_pp_table =3D kmemdup(hwmgr->soft_pp_table,
>                                                  hwmgr->soft_pp_table_siz=
e,
> --
> 2.46.0


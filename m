Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DB606BE3D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=B97C1rCI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0431910EF5E;
	Mon, 16 Nov 2026 11:06:32 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E8710EF5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 11:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8V/RXv9fe7emGkBTopAideXyEBkD0J6PkKGmAVrs/uZHfh4LyijrpWffzUvBuqueEqh8pZyjZapBuKLH15JsDBxI0eX9BimY0MGoSrL4a/aQSHABmJjkzph9CqU3E6adD7xmUBZUajVzzd2Y5hKHtEIlx8DPuZk6fc91hyOkGgqn9KM1ww0gPRPQq9qeObCzhtcn80XhM8VrhA7RlEHkrQVRepA7iKnAlbq34uNkDBN/1IB7FCKbVxg+Ql+j1qs8To/U+e4hHVfFIrgklLAACh1dBzsbDn7Sg9jHyLnBeHMBSkfMMuChBj7tuGDN3ooC8FHQMxh3uHe7W+km8mtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7sL9zBs3A4xgdLhJC+/BmI4Fox28/BquzpaOfp5G3I=;
 b=qYyiIPgMz5OFwGp5B3A3RQllWLhlu6XTTAjAcPYd8UdTMRAV2BX3ctUI5TmZKwJLd3RvHX3IY9WtOiygYWqmtqKdVZRqnmR6Oy70bXfEPcgsvdBLWlxOr8TMOAdKNnOtXCwMp5riOshqKbb7kOvUl2ZClqawqPd52gqmT25bDSGO4imX1gpGYSrbuY8Dd4y/LYOLtMu/awVMUa8Kz7dd8ldSBYU46MRKsd3zZ6lgBTj10x2hTkYRCr0YBGjTsOYuFPFDNEC9RM/uhv203CxsYPrII5XoZka8wYJEqxoaLZ2rjmezdFXJzsz3fJN1eba2rBY4seNCTsNyerNk14jALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7sL9zBs3A4xgdLhJC+/BmI4Fox28/BquzpaOfp5G3I=;
 b=B97C1rCIHHcuxc5WiYGsF6ubPsQoOWFKsREii9mZsBpXO8Wrgks7M8JlG1RQvp0mjMRshc5uv0BqgqatWycseQjoAOXncEuz+cIda9oSf0OqU4User7pro6qvSD/C+qYQket7KTNkXioWarq+KHXBG69kh44qMsjLVTSj6AY83o=
Received: from DS4PR12MB733313.namprd12.prod.outlook.com (2603:10b6:8:50e::9)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:06:20 +0000
Received: from DS4PR12MB733313.namprd12.prod.outlook.com
 ([fe80::88b3:1cdc:5d8d:46c1]) by DS4PR12MB733313.namprd12.prod.outlook.com
 ([fe80::88b3:1cdc:5d8d:46c1%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:06:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sun, Ce(Overlord)"
 <Ce.Sun@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Topic: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Index: AQHdc2S1FCSOKiddj06Xf93iwAO/6bcwjd0w
Date: Mon, 16 Nov 2026 11:06:20 +0000
Message-ID: <DS4PR12MB733313F11DC7E17326F4995A4CB07C2@DS4PR12MB733313.namprd12.prod.outlook.com>
References: <20261113032813.352632-1-cesun102@amd.com>
In-Reply-To: <20261113032813.352632-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T11:05:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR12MB733313:EE_|SA3PR12MB7998:EE_
x-ms-office365-filtering-correlation-id: 971da073-9a5c-4292-b8d8-08df43d1a4d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: tcHl/aakOY6HQOEG/52hS/gvB8C/xxBejMeJrXJqoyvUqvXPyzU7VYAkuRC4Da5KF51OSutdgBbfoRTBZ/6u9jHpO+VGXd2Z2x8mqgpdxuTf9PMpfBiACLUk4iDf2bi5utqOT7pu8NHgX5anos25OszIFaE7RYkONHFU1+Fe1KupvhjrI4nYr0GF64goP4XeecA97eely4tRIKpD+mjg9oeFTPV0j9gU7QRh9Bo0GJCeC55trNg4/8syvNMv1s/njDoV9kqEtfT1H2YdiSCiWf8vsv5vc3Bgecg2CU0/V+hB9BNwgbogRK7lN2NiJnQpbGbrpERLFFduhAn1waSsJk4VGfWQi8YkIzCNgdJClZ3yXCaxIOtEoSJZW3zwL0JnMEN+08kXARxQN1xUlVxm8bSFGTuyIXjp63P+8b3QqEYy9XJIFtZ0yuG99191BQVQXitKFxNAF3WvFd+8g6mbs4vpXHkxgZEbzNOKS/Mfs/YnhOFnxNzV2x+rtZZQ6wZQoR9bICMebsk5/TCpOAHPir6stR4jrlrM88Erl8gbEN3oueV/sQO/Y9doiRDddwYB5yLi/bGXwOh2P4BbvZhbrX/9tdONse1poIJbC+o1oBDMKwAAsr5WSYD+RtkZoS9ceaft/yCv+vgQCTgK3gSJwyMREwRRO9FcHFw5PyAxw42danvC88KcxhRa+X7dCJHTpG+RoMD+XWU9xac6kV6xt4ZaqTqgBd8UQ/wItDhF6LY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB733313.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sj+PjaW4rR6Wxg1S1hAq6KY37FDw7ABPRup+01bJGC93fNTugQLMiFXpr+Qu?=
 =?us-ascii?Q?O4IHukF7WjlAH/3zjDIJERlgKk7PUU8gnbQIRM5rvncWdvKEijI8dariNN6s?=
 =?us-ascii?Q?EJ/L2Iq03KaRWajFsZpKowaWaqDup3e1FMEPzD88wgtXsROrW1FtSSzx+r+c?=
 =?us-ascii?Q?LfNBO0GGTti/mFVtIJmVzMWXa0QI5e3sy4kpu6bMpCmAt4oaiGv4lKdrvQed?=
 =?us-ascii?Q?3g57xMYebh2bvzhMNEqKyX1D5MG+Nl5HRV7IB7dN5ieePW3CPG/+OkEmzwWF?=
 =?us-ascii?Q?Kk7nCf3rYefPo8lKIY9s9kj7hxjP89MuyGOGA8oySaqOcR9V9CnAIx8QUGyp?=
 =?us-ascii?Q?+flMmCKUJPVxrBu6DiiSDuCsgp8KJfsw0JfnisR9aXeHrpKHyJi5S8c446iC?=
 =?us-ascii?Q?ri0XP0R6ntN/uIUp+cDf1KkwJItCLwkIE/W0bL4PMoz8928E4gXRpEQoeRcM?=
 =?us-ascii?Q?lu80SgYchq0GYeZ3MeaZDz0B4hgJRzlfSAdKx9yYDH44tUzR3cjIomi6WbIE?=
 =?us-ascii?Q?3vbvDdJ6gJtFD8YtXkEUDFE47cG2NUncbsgI/VhidR7YDY/grBsxrEB5bKnD?=
 =?us-ascii?Q?zHW0esmBL9f4P538WFCMYO5fRpYcIlbaKhjlnzF10YD55UuaRaitkP5wyG1S?=
 =?us-ascii?Q?SF85B6JswS8fOHebIaWoi7NNbUeWZ4BS0Ng/kwW5fHB/KIDS63XZiCIVYRnB?=
 =?us-ascii?Q?gZT1iPGtcA85M/4kPmlmXESkluXvG638eKLMrTbaSawnqMat66TKmkVOzp/6?=
 =?us-ascii?Q?VLGEdoYRblhMgQgzzDQ59l7dpHDcQVvUX9zIEBVmdo2IbO2l0U1laTdXQLu3?=
 =?us-ascii?Q?iwqw2rEDkOtzPphONvFaWtxDKKNYdSes8FsHCVBrswiGZqVy7QhHdSE+85kk?=
 =?us-ascii?Q?3K6jf0eY3cyGz+upgyV99LRQS5TluCSQNBNU/FwDJKRMi0G1nIB0re/W/DHA?=
 =?us-ascii?Q?HcTksV7URHIb0EDfYmizjQvWkL2YAsksHSf3k3bfScJmexHZiGALJyFOUDqx?=
 =?us-ascii?Q?X+7fepaYCJhJbH+FkCNLYfmGqb08C1WZFjObcKjyF1JCA14g6vlW3rRjZdHw?=
 =?us-ascii?Q?wQEdBIs1EJ/IuYyjRAzoiWHHluPmBQ/pwrKfHzsRhAwGRInyT5CYUakwGKfc?=
 =?us-ascii?Q?RIqrUzf5MUuGrw+2f3ctLFoOfSe8MNLj0art1GDwEY+9VAsXRVOvNYjpc3aK?=
 =?us-ascii?Q?Br5p7QAwQ+ch394eo3sY+Sc80cDO4WOxmQvekLq7zC8D4wM+uk3PTMNtonX7?=
 =?us-ascii?Q?yqlEfa/UEIxamUHXvvNn3+OD9BvZQk5/lkjrHeuAOGRJtBLsnaoWoNhF0mlH?=
 =?us-ascii?Q?RoHiejHUkoArW31OAukBs6/czWIjQEv8i06kOJXKGsiMNhLV3qpiKXFli9w/?=
 =?us-ascii?Q?+R1rnxlzd+NwsJWB2JH3OHUaWyrJtL3CNbQnsjrq6jYgVujPF9WAtyUPG1lT?=
 =?us-ascii?Q?sdMCptKy3rBv86msQBn/Ysif69I2KS3RUzYfaeKF6p2ekXtrePjXcLwMuAZv?=
 =?us-ascii?Q?h5vI12NQtp7wYqz5HZbkEpPeZiI5TsFd3X0mku1yXO+sghvGsfKcyncQ7AWv?=
 =?us-ascii?Q?NVBC6nRnM/hU7mu8Kwmb412j3IK3ZwvKgF2exhixFG3klN28ymDQ8Z10/dTa?=
 =?us-ascii?Q?gbozGinWcq11bevK3WatNBsCj4A9JANLq+QL/Y0kLwBXf+7KvF6UJgS4CQ1T?=
 =?us-ascii?Q?2Y4gD8avgjUExzDbVL4Et1lzccfxZFF/4Ue4fgH1t26Qb4Mf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB733313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971da073-9a5c-4292-b8d8-08df43d1a4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 11:06:20.2460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycsW+V4ge37a2mt9KcS39ZmwhTZeVKiWgC5UZ9tXsJJovCVJPI4PycsA8hDur/fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Please add a comment for the added condition check, then the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
> Sent: Friday, November 13, 2026 11:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset pat=
h
>
> amdgpu_uniras_query_block_ecc doesn't support being called during GPU res=
et.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 08c6e55a7927..7be33d5559ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct
> amdgpu_device *adev,
>       if (!amdgpu_persistent_edc_harvesting_supported(adev))
>               return 0;
>
> +     if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
> +          amdgpu_uniras_enabled(adev))
> +             return 0;
> +
>       if (amdgpu_ras_query_error_status(adev, &info) !=3D 0)
>               drm_warn(adev_to_drm(adev), "RAS init query failure");
>
> --
> 2.34.1


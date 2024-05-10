Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FEDC25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B218A10E5C4;
	Fri, 10 May 2024 07:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OR4UvhuU";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E2910E5C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXtl62m75i5PvBEsBtL5Xy5tUlFl8XqSUhtDzvdBL+R32o/iFFG5OiW2gMzpIhnELy6hD2+UustxLuDKg74QSA9JlQLUS7l3CEQIXHKICHnqHdy9URGhXfOXDKcwFC7j3Bk6LOD14m4u4AsM8ofr81lnmtnvdmYylDPWQ02aBZeMEmYA4DaM2jikbnm91MMmzlVjXdmEzjKPL83JrB0CZG87sndk3WipT7DjPP1H6mXTR5ltAqRp4oUf399iKm83MvV6xr090tCOQHzI3aF+6gAD31Yq3eQVVqwkKIDAGl7l6XtbP54Li3wAGc0Hr03S5/bfoXhrPfoHSsOySFAzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjtTdle1iz9vj6JiYDvFQqQlgCW+80AwU5OGNbetnWg=;
 b=Jfric/1kC9bYAPNG3eJrxr12lFhISE6xMYkE5zM+pj8TyQcMCj8O8sUJKJILMoIiI3zNzX/xqFzv9bkI+xEbgGKeulFPEsMladXepk36U5nUlhXkc323MoA/gUrN8mh2XNmcXxlojXfn23OZjsbQh3i0NRuxGjRTr+Ly040vv/qnkMnj07MEdKo3ugzs5HX0l/5updb7rg/ibY43Q+0Jn0t72+FFTEsa/bjWjGTi2wxkfh/FrKYiQuNiS3pjjuAABxJJTRMgGDI/HZxCsFOYZ4iTSxYz/Sfgn5qngJQD/C9MB5CZXLAX9ANVKgodpmLL9lz29IQ8NMoZTAKvze1Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjtTdle1iz9vj6JiYDvFQqQlgCW+80AwU5OGNbetnWg=;
 b=OR4UvhuUsFuNPZ2ZfnHajS1RzHRKaOEKDJeQbDultomgIU1N2WpoOFKQ8HyotYdKF/yrJmk2NdOAABT8rUQD4er4ipI5MS63oZIfcsti2M21hi1SE5hXb6Dsa5YRlDqGYz8bw8LdtBEw/TJr6QMkuoeZlaGGN6YUQvm1aFHBCcU=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:42:15 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:42:15 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 07/22] drm/amd/pm: check the return of send smc msg for
 navi10
Thread-Topic: [PATCH 07/22] drm/amd/pm: check the return of send smc msg for
 navi10
Thread-Index: AQHaooUnpPDFyUjpKEOBk00rA5W0rbGQCi6Q
Date: Fri, 10 May 2024 07:42:15 +0000
Message-ID: <CH3PR12MB8074E2B0017463B77990A1A5F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-7-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-7-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b3a5c07d-b437-4995-892a-f9d480379e7a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:59:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB8349:EE_
x-ms-office365-filtering-correlation-id: e54cdab3-16e8-488f-af0f-08dc70c4b626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YTn5/2R5I446GD7/1hTa6Aa9/h4Jh2IXaLfSFrx7TZ7IlhNGO9QAujEjQq?=
 =?iso-8859-1?Q?rbyxWceFuLIHIpMetGIOcEgqRI+QVZ2gxen6KWMxpSxMqex9J6DBJDrqBe?=
 =?iso-8859-1?Q?XpLmIH63gdoF7PkW/TwtRVHH84Z+6oljvtZc+J3kjA0ygeD81ZH7mtFi14?=
 =?iso-8859-1?Q?7Zs+nmqoQBa+N4PjrX2EciecKFSIiXL6Xh7PG5Yw7g74SxOkqnmUPv/MFn?=
 =?iso-8859-1?Q?JRiSE2cFUdqUQEtdGs+rsmnVWm1K6mxQdIZkrX7fDsW0XmLdfBKU12oN7c?=
 =?iso-8859-1?Q?xSL8OvY6pXyXz5t5atgfcYUGSTTM+lzxcsh1Z8mLy/p5sqJIOxNX4t7J3E?=
 =?iso-8859-1?Q?uNZmJqcaYz4IFmetZLK3oXWof35IXrg9+Y9dM4tF+YZyZWbEhw776QtZ18?=
 =?iso-8859-1?Q?aT1D3gc0GGhu1HQS6lyIbwuBZQgAV+Grf7gyj1fBWpSnTHZzi+gS9fmR8y?=
 =?iso-8859-1?Q?wewUfDs0ayXP0HaFvQAogaIOAk8vsI+FDVUhXSGIn1pvqVa5ZDuOJkWtsx?=
 =?iso-8859-1?Q?q4iq3oK99LnsVcEkDUeIFNU+z6UIJZcWyq3U1GznjpooMrTLA8kAVW+jyK?=
 =?iso-8859-1?Q?ODpnRQlGqSrQn9pRhskyqwAtPuqx0e3zz76Br7OQ6tvGoEN1XWgMjph4vG?=
 =?iso-8859-1?Q?AGQtItx05mlpIFQPIXmAlU4MMqkWoVf2PziAdqL7tIzwo1gBHpEcI0uRKw?=
 =?iso-8859-1?Q?o+S9kauXjGIuwnnLc605Cf2/udApCocWPycvDkf3yP40C/n+szSuPDAMEF?=
 =?iso-8859-1?Q?gp8BFbHHi6LFnD1fBMn/PZTY4th8cktKu5RM7Krz3xFSJVFJrc14SmU+ci?=
 =?iso-8859-1?Q?bufZCG2Ug2VowRnnykMl30ysRqyl4MZrkiQRCyJuyr8ZiHazBjkC1gzMMH?=
 =?iso-8859-1?Q?zu7n52E1Dd0xOiHNw+RySHtaMxLyy93A42Ze4L3txEHfKkTUjUT2RrbCFP?=
 =?iso-8859-1?Q?kSFHSXfWI+uPSQaakVkz7VsMPbZrBAjSwhJZuyte7JW5LujSfyCHpX66nS?=
 =?iso-8859-1?Q?3rg2WTNtNelivOo5c51klw//RIJ1oTm56b23Wb6DEo6AUDdFuUKYLfdwDn?=
 =?iso-8859-1?Q?b15O6kPns8W6Vgn1sIaTfyNbOhOBmvlSLk/D7Ygjm7Y3EARiGEya2r5zXO?=
 =?iso-8859-1?Q?YkOyId6utnxYTQuAvdvFST9qIbkADrr3KIumroqkRSPHaHycf8K93oJXn9?=
 =?iso-8859-1?Q?DTnCiRum0tdGznA+SDn9l0LtzUUoZ2C0oMBpb36mEsF9Bu1/lZQp7Y8pT/?=
 =?iso-8859-1?Q?MvosoOftDgjCAJuwlfcSJhirXkbjh6dIjJOJ+2h04bKgIN/S3vkeP8mP9O?=
 =?iso-8859-1?Q?q3NPT9L82syO//5SKA+aXN+zcfBh26ichOUqyIN4ceAQ6PtK7OzOt4YLDT?=
 =?iso-8859-1?Q?91MDfYWt25IkseD6iS4Ei3hVAz7nR9wQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hN9pINqpZMk5/3fLkgW2atXq2yH+tKWGOrBLaudvgLk1oLel3OU1WE5VDr?=
 =?iso-8859-1?Q?kgvyVoz/tJ79q4tnSBE/b/mednxjB+lN4AhO+z708byoL+s1Q7QWf+j4qA?=
 =?iso-8859-1?Q?xR1EXVrQFNBOecwRY8ZOZ72wS9OKN0GL/9Fp0PJkVXZ/oprOIVlfBLR7/i?=
 =?iso-8859-1?Q?f77LW0zE1FNhawL0KG/hU/mNEMA7PeT4OYzOtc3yWIlhmVthg6/GpLtnXf?=
 =?iso-8859-1?Q?meSYNWn6sOFzXUCjPv+OsEidP+Jk2anEr0MoTghcNSuhKG3DwWsIq/24rM?=
 =?iso-8859-1?Q?vyQW/Nlq2+neNoS8mLBcdadqelF1cNf2J80tDBrgfTBnr2TRy/z78OX/2g?=
 =?iso-8859-1?Q?O3Up6fZ+rRNxiQPEGAAtK6iBLgcE07pVm+t8wRxuM+aWTmxs/4ABTbQTWp?=
 =?iso-8859-1?Q?M0YI1Tug4i5BiUMUs/MAX+u8ZGOyK+ZNykdIIDcboy7GjxCDlzOUJx/TM+?=
 =?iso-8859-1?Q?Sq8rCu+N7J6eLO39vOIVtttdgk/P3ZgAUVfrczS8SaeiRZ7jcHL7RDtxJ3?=
 =?iso-8859-1?Q?5g9WBtTDysB7zQ5DweVVoPGfzgDVIEjlBSAS5lCtn0vfF26TqJZ5/OzM40?=
 =?iso-8859-1?Q?XIKAUftaXcDXbIcu5Wes6DxITPreAb5oE8i3xCZ1BAzFI4rDPDQC+qEciy?=
 =?iso-8859-1?Q?SQwg6XtrqnVbW41mrwsgYqAnkBwdRjP5SEn92n5xndmznqYoD4RpsxM543?=
 =?iso-8859-1?Q?Zod7p+aiuFkq9qazxKvAHi1iDVBO8XRmO9j5Vnpz3CccgNTAj0DHmIE4JH?=
 =?iso-8859-1?Q?mgvlGWU7mhINM3GyTQVSa7xUWbnuDm84sGL9MrqIFoTB4ZG9bqo1jcStE9?=
 =?iso-8859-1?Q?M0DnTxRAfWsJ57j122IOe+ftoaBtNku3fN4ZrFwI3+XaFF2J+mQRh7sg+k?=
 =?iso-8859-1?Q?vEPX84ModCr8UCFa2botLJEzKQnNaNa7GuUpX2lZ5NYx+EDA8OjE2ZLBqL?=
 =?iso-8859-1?Q?GHjdpUufh1OIZMfNU2auFLhBWu+qajv7wMhy619Z7zQXCHNlp8iUP2LFcZ?=
 =?iso-8859-1?Q?wDDa4171YiNcTiWlxhqcOgRGwNLJXGwPBSuyz4wyC9IMcD1w+AMCene3RV?=
 =?iso-8859-1?Q?73hWe8oNysMXr2cMxhiaMc9NyNO7rxHBkCvzryHrsBg0BChuwxKMspFobf?=
 =?iso-8859-1?Q?zFDVvvYZipMBkjxsmrRYEhkildjNP7sTvKlzt54r03KPRADc49xTzaYbqW?=
 =?iso-8859-1?Q?MbcfvOuFYzvogfX8d053p9XZDSZ0qO6A5T2HayUzMmNv6YQIwQd0ZWbkbS?=
 =?iso-8859-1?Q?gUx+OZh54Lk5Wc/DEq74V+Npa4JUR4yf2JfB+CO2xPKqTkLxpisPT4AEDa?=
 =?iso-8859-1?Q?eQ2I1YWFPiP3jpB7HeZ40dfIQIrupd9WUfx/XF7t/K2mD7N1VGCgK9phlZ?=
 =?iso-8859-1?Q?lMIm77/Sjgat1uAk/64P184nqWfU7uGIAbkHuL6Th92p7ApcnUUwCeSU7C?=
 =?iso-8859-1?Q?fCZ4nckbEYWCoWnCFeehy0UeP4v54xeDQwwPbKX6a62imUS0z8FpAglSYm?=
 =?iso-8859-1?Q?GxlqkpsuG/8MGWESZw59aIG5OiKClsIsuWFMoKczJMui06zGuQR4A7VPKb?=
 =?iso-8859-1?Q?zCsmJsxowpbfNp6HXTWJtPUbsekunrlHqoy20cEoLwrBXWldoZRkXJyqD1?=
 =?iso-8859-1?Q?7nCQ9oHccE2gh2LIkGUqDdozReDP1LCcHv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54cdab3-16e8-488f-af0f-08dc70c4b626
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:42:15.1532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIufCkRE3YuFAnRMzrsZuK0vi2o6/d/IBMKX3tLRPVi8EjIsNz2X/9uLdWLt4sP6jmIiHekAq/MMPHoLCuqfUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

[AMD Official Use Only - General]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 07/22] drm/amd/pm: check the return of send smc msg for
> navi10
>
> Set smu work laod mask may fail, so check return.
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index c06e0d6e3017..f30f1facc0f6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2081,9 +2081,11 @@ static int navi10_set_power_profile_mode(struct
> smu_context *smu, long *input, u
>                                                      smu->power_profile_m=
ode);
>       if (workload_type < 0)
>               return -EINVAL;
> -     smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
> +     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>                                   1 << workload_type, NULL);
> -
> +     if (ret)
> +             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
",
> __func__);
> +
>       return ret;
>  }
>
> --
> 2.25.1


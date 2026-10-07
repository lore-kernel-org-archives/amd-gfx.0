Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0689CA6007
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 15:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C1D210E02F;
	Wed,  7 Oct 2026 15:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1TUttjR";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B8610E40A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 15:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbfj/4y9lrTtz/3LZKqZAKp7WwMDUHJf+/6DLL8Wjn6p5Y5hTmyByVNAkKrrYvaGs+F0PaHGBgpudd3Q1H+OOs7MpO2CQq2S4WHzkuL+kumM0n7TrP0PGu2WOu3KcJ8j0BNsR+JcskmQorbUCaKGuw3fzIar4DGzjIFMR+IMm90ZkLR4pC0L0a7Rz93MgJVdQgZJxTu4uWtXz//lUH794O3/0OpWfPLa2CYY9yasSSI44BhQcqBjHwhQJzCt2wZrOqPS90E0OZsF0ZJvQbFffoY8iXQwwfFi4nV3/KEjIMJLCV+Mw5gG2/c0hNVp92H34kUlqvCRilQG2/cZNexaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxJfkCdyy/mAvGaW8YEU29l+CuH3If370IGWfR3l1yM=;
 b=rogbpLBkCM6Rcu7ZLgJcSGhHEGWqoXv9KsRpjlaQsXIiQmdx1oDzP87AutFws4Vqu4+58rDntsXGWCTnUrie9e0VH4STpv+zIvdWIpNdWET2z7bTubQNvbqEfQKnX9kWSPwPqRYom9cRiZmKixW/pv3iDF4HYe3X/Zd2vRPyo0s/6Bxrnx0dge8K9KClIq1yyv8YBAftS2cfI/rcxEcUXvGq2i7+MLuQDtgzjst+qXYETDyJ8FV5nizEvPPOlRoVxcF1USqDgORNJcYC7BT6HUf59pkeeVm9GHWkJIrYAB/pEEWdn8HIKEXtDFhZ6JTZ9cXmP9mRH4MaMF/wS+e8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxJfkCdyy/mAvGaW8YEU29l+CuH3If370IGWfR3l1yM=;
 b=h1TUttjR+7R1JsMVM4nQZVDBSXVqCYViUkhbLGKVxbZzpYdffMvtj3o86m11GEKvosmyh/iZrLdeEREpjFU5o2I8kpSpujFsFUhJ4wLZoo4/l2XO8lRUhQeovXUt4mpV5UA0D/Hu6A+CcdXqCsz+Jxq2At4TSbviQfMSX4kLnDE=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 15:06:01 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.21.0451.024; Wed, 7 Oct 2026
 15:06:01 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhang, Boyuan"
 <Boyuan.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/psp: Fail on VCN firmware load error
Thread-Topic: [PATCH] drm/amdgpu/psp: Fail on VCN firmware load error
Thread-Index: AQHdVPgHRh5iUDHW+E+NI3ZFHJSSCLbyMLEA
Date: Wed, 7 Oct 2026 15:06:00 +0000
Message-ID: <CY8PR12MB743533BE1564163CA4737C48E5942@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20261005183245.432709-1-boyuan.zhang@amd.com>
In-Reply-To: <20261005183245.432709-1-boyuan.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-07T15:05:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: d2acd139-96a3-4cbf-1c37-08df24847fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|1800799024|366016|376014|38070700021|6133799003|11063799006|10067099003|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: jvLmzl92Cyn06hi7DtLKQRIrpTE5DLuFRAbAhvFCwvT3txB402LfWkw7Hc2/QMSBcTH1q0y5xC+b6ky/KNIV8Vd2IgyQihRTiOLTApsBx3c/V5KHAcbNOyeSmy/ggoycBrjYpKzLEQ8A9no/266tE+feY/4PT+k4CSWHbgdNrr2vYOGri3O6cWHP0He+8H2tKriX7cXgUGy6//ts6vtKwgHr3eYGmR1NCPn0kpHuU6EB2AsDr+ZL25M+oXlldx0bOszowgj4PBLSn5SnTFFjzP8A116rT4t63SxL4/CcoR27HeOXW1Ok8Wn2tlvnCIYOfEzP7ThSB4QLsh069QwcMtP0E1AKDnPAoxrukrPL9n8mvxiHm1jEf/Z0BMvLKlFYF0zU1BHU25AEDli8CTDFGobey8IVPdI+AaK45E/mF0ddu1qK5v5tG9jb5U+2q5yMpcQKzqU9MUZ9bj0+ybz2ZTFOe4CClNPwQ91gt1Hzb2ekEuuuYqtXxYyX/q6/IIWYtHP+reln9jixRW4vnIfPGUaPuNULMB8qddEf6HY3fKKk9ghCiWMl6/LubeVp/lmc6d5vQU3sRjTJfmSZkFlqbJIual8nW8PH52vd+JDlEmuvTJgMDVbwViDVNfx2QZXFBWZfL4Svg57AEylFxTSBRN2ajyvP/tNSs2TmoRcMpveL/xWljZF1+BzLkXNsTjLs0Su7IxFXFCRMfVrzryoiLUNPi+ypUAd69wK/lkpH0Lo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(11063799006)(10067099003)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GfLEJBIcyUbhjbeRYrcbmhdKypbkQGo5igHeAU97qPd5Wu/qtHchnuSUdBcf?=
 =?us-ascii?Q?1iYDTn3ltDP5J0wzXDUdSTu+rPxewDayan7XQD7IQmUcbMINrG/C7bH+mZJn?=
 =?us-ascii?Q?rbbfXkkQexc4Dd/BFbkCfzCd4psYFTF41ELGL9qwu7Y4f4/28mLqBw2bnQic?=
 =?us-ascii?Q?GC56yA5kQHGV9p8MT4ltPmXBbzdqmUc05doCzF8KC89/cngG0WsFyZ1x4paq?=
 =?us-ascii?Q?xT+hPcDNZ3m2qAoAxXcGvX+xsie3QupjWxpw9R+84ebw93Alh4zJmKJtuqMT?=
 =?us-ascii?Q?PZoQO/1N+EMMfBnm9J8pHu3wIKkSqK9tZof90nwhZgYE9tl1Eqqct1RMlp0q?=
 =?us-ascii?Q?SFsCGyrQc9xN+5LLHXSlodrrnRU1eefz+/jpQXZBRKA8cCYHjJaUbBfJKGUt?=
 =?us-ascii?Q?tea/QoRV420lvKkmm8uNHWSA2rmYTH97PfF/u9MB0fXtbNbwRCCZkejoveHP?=
 =?us-ascii?Q?9fOJjFoq48539avyd+XGRaZMqeHHcCdRU5IgF2iAsZv+8uWarHicM9RGcqg/?=
 =?us-ascii?Q?/P9/zJILV8I6s9XoAdC5ga8qv3O67D5KuTe2FHTGVH8a+KzDgCJlHSDHAycN?=
 =?us-ascii?Q?1AFjNVcv1jZXdqZ+Pv/ijJHuWuRaXcYmhVowOfIFFYS3Q3O2FtA4mPWW7JDA?=
 =?us-ascii?Q?odLFmwkDIFHZZTKO9vosyTFt71FM4KCICXjBEr+yrmDf++o208sLgRVHfh09?=
 =?us-ascii?Q?ATLjQCs1uq69m+bMJ+uLCI1rQx+5A8a9U9E+vXIm/MW+NzU/URWfdVpYbeKR?=
 =?us-ascii?Q?ialqiE5vuJ1ExiYTQwL2sY/GhvQuB1MoZv9Ppi/XEMQIhg7543r0MVtEjiZW?=
 =?us-ascii?Q?KNyUH81i11X4vWbhBbLJHKoUigrpkYYYNtZBhpuiTg7qRvHtlfWhBea3xY1k?=
 =?us-ascii?Q?rTtjRkbNcH0SaPGOMn+l+OUbmwb08V7baJFt39u4pwqnarE0fNHYNZEWU/Ni?=
 =?us-ascii?Q?nqogfaVpDmlj3rCBhriCffoQ7LbOB/aMWYng4tygu0/v3zgUL5RiVvZzn4qf?=
 =?us-ascii?Q?b/kn8nQOpIDy5ckvQejAn/JS4NKp1EB5/Bs0e/ZZt5g3VTXzhIwtzIrSyTTL?=
 =?us-ascii?Q?KV/MNd8vPI/8eXQOmrQN4i5x1YTAi+G3IVkydjdns4cZgvmSrH9kLi3vM7hX?=
 =?us-ascii?Q?6pqLYMA3ObociVZqdgeUVq2rnzJNfoZwenLgAlZyWoCvOIgAMcNEG4fLxx3x?=
 =?us-ascii?Q?pYbdYv2gcReOogwFYbHV0RYrVjBSj9ktmLqolDPszpQSIuX9y+QS3nveW5PR?=
 =?us-ascii?Q?heXRCGPI2USGtGScPR/WKuUK4JGbK4l+QR43/IbDQpZS83sKfO+EtDAEZffa?=
 =?us-ascii?Q?WLG06j2lC1jXirt4I4xtbh71XZvnx0K4d/TqPrjR/U7d78Vrtz2dfYuBgr4X?=
 =?us-ascii?Q?LM/1pZs2Fs0mhlYOCJlOSLOSWN1dT8yEyO8g/uqsgX/POptBcXEJyh6VDy6f?=
 =?us-ascii?Q?eLYeu4C+T9CBuRBrJh6WkiaFAJhWWXn1vsR+9uVlICtHFLhvTGMsD6KQYAZv?=
 =?us-ascii?Q?hiae3XZTlSsalB6iek7L8DXZcMcaAXoeRzbOgiliaBf1yZnH7QMtfLlF96PN?=
 =?us-ascii?Q?p30t46wYx13yYsgXOrVxFtvTZr1sVSs/enm4rtOW5x4rMS33ZdOWDSyYpYf1?=
 =?us-ascii?Q?O9jrHGzdvcESHb0z2ibFEmc2/WGSkzWPJNeFKpRnq0PIoqe6uFgm7akFiYwu?=
 =?us-ascii?Q?c0clQCRurCWBiIhma5Lm3yta5KrlG7Gb7rJzgSJj9UK0h049?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2acd139-96a3-4cbf-1c37-08df24847fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 15:06:00.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci0Gz+GwTXK+wOqiPY1Tedw9fLxyrS7ikCjKJKYhRsNnE14qkA/66UAw6RP/sha5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> boyuan.zhang@amd.com
> Sent: Monday, October 5, 2026 2:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Boyuan
> <Boyuan.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/psp: Fail on VCN firmware load error
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Return an error when PSP reports a failure while loading VCN firmware,
> preventing GPU initialization from continuing with unavailable VCN firmwa=
re.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 04f6ebf31cca..1d853d2e8cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -784,9 +784,13 @@ psp_cmd_submit_buf(struct psp_context *psp,
>                               psp->cmd_buf_mem->resp.status);
>               /* If any firmware (including CAP) load fails under SRIOV, =
it
> should
>                * return failure to stop the VF from initializing.
> +              * A VCN firmware load failure must also stop initializatio=
n.
>                * Also return failure in case of timeout
>                */
> -             if ((ucode && amdgpu_sriov_vf(psp->adev)) || !timeout) {
> +             if ((ucode &&
> +                 (amdgpu_sriov_vf(psp->adev) ||
> +                 ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_VCN)) ||
> +                 !timeout) {
>                       ret =3D -EINVAL;
>                       goto exit;
>               }
> --
> 2.43.0


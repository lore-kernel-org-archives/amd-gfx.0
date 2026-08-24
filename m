Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5008DC5DF97
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 02:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BEA10E09B;
	Mon, 24 Aug 2026 02:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GwblTrm4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACEA10E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 02:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnkdE7wgWszbDt8yAoKiNdju0MEKY1kYddhMHbQmnYdPKY/0hrQ/w0mYjj+c9nBEESyyCLwPFJ6amAQJH5Y2xsFkWwetUl++Ks0XtzGWNm7S6Wrlh6XtKi90BVjVL4890k4b2t+TuOvoz4feUmHGTj1WXGzyAGePXkTEeyxWO/F8AFXLp0LrouaBtvigq01NExwVIDFYpEvkUrjw/pTClL+H7FRASxey3vzY6+br6K3V9GMbLpOdWHygUg9PEWh5OkuUIs86TH1f4GtSAfHO9hd5vE8wcbViPGJZ3vPAtHR3QPUmP8nhNkbT/g38WEwdQgJV3AWwryM3G/2ARoIqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08EZku1xNXEAGUN9HzDlXq5DutyCeqsBojYeFVgSMeA=;
 b=XNO1C1GYDZuZ9A0Qix4dmo2t6+wLmMB6/c4VA/SqWjKBxLQbaC4cls1pqyQAO0dWk77IIJVqkeksLKD5umMqZ1ac6Slln1FFu5a4KpzTxcisrFJieKvudzy2bB3kRkHcVKuc7VXl8vIVrj40Coy/FSkU8ux15wqxw0g8CMEQFGb+I5jD2LcMxy6OgR8JQpoXwh4VgQVgvnCw/mFuE5FHtEq56TPlm1bqH6idF0tCki6v6AgtigWtc9MMN+oEOEB9NbR0VFjYB7gQ0ZHCxNj88MBTzoBQPrnCtNWKAtgdhYfe69cHVBJLYUag7GSCU6zN37p5Lq7rm1f96vowuOplkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08EZku1xNXEAGUN9HzDlXq5DutyCeqsBojYeFVgSMeA=;
 b=GwblTrm4uqOJ6SFXXG1iIunszkGHJywF57y4Sm/xNnunatUodpM7JN+tzDNoa2a7F8alwbXHSy2NkVjuLYywrE5+fVYgo/gB/ZLcJ5ybiNKPrC+xRKcaN9MK4Y5ssQZjpFa5kgq6zukMixHLsKlmoZBdSSYZll/QwYIPoMJdwuk=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:41:31 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:41:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
 control
Thread-Topic: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
 control
Thread-Index: AQHdMiC+xY9LF3L4v0qdxj3uJgNaW7asfzow
Date: Mon, 24 Aug 2026 02:41:30 +0000
Message-ID: <CYYPR12MB87297410AD7E8695546DF551B0A02@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260822102609.84913-1-xiang.liu@amd.com>
In-Reply-To: <20260822102609.84913-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T02:39:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|CH3PR12MB8850:EE_
x-ms-office365-filtering-correlation-id: 39dbf91d-b532-4131-c9c7-08df0189346a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10086099003|10067099003|56012099006|5023799004|11063799006|18092099006|22082099003|18002099003;
x-microsoft-antispam-message-info: M02cekzFQS8O0tnFz1Fqg/NBnDpbZ1ngGFgNFQVTVYJyPtVUd6PHlrFwiTRIZw1EYd/+pU8CtM9tjxym3srcsjWzzRVBxO81XNahOTKLdcNOvt3qyyVWGYaPMZ8wIWEMLbp6rzbjU1b1CMZijDtGRgKglfp+JSdJ7gRivq20oUo8PrPYw3kyshXKYw+/FLgRFDu0yXYMkcXRSQvNnT0M1VOa6FIpibtHIqmXvxDJEzhq+QmcudBCUy4u7b2woUlwmmqjSfqbxwyBfRKJiOHHJwz3JWcfEmAEYqKa5A+5viA4S8wKcXKhc3zTmmkhGwNraxRbjZpgm9d5WCBot0rLx3XuQKQYHfFprEjXDq6sIailfrQt3B9cpWipflV8PfTv5Uza1Q+ISGE4iM8Sc+S0zF8raFt/Bz8DM/QwFDR48yKPxsP8BJAwuuj/ipSoNqqI1Tv4S0TcyM9viR0ss2IetNVNRq3Bi9BT/a3th8g0R11xcqnAKBQmqUhBWgOFst5adZg9eMH3VR/tLLheEhOfLPM3QPjxy35gPjhqdi/h5T0ChRRJassBIu5n8YSYJSmtbYieFVvbX8x1EeaR6yJikbrbycE4+9Z+o3iF3Kfj70wmJshNjCZcWhvf8VfbhNi9CBIR0p17P+T23TTJvvK4CgvrGS7rCd4JEeIY/tE2S7Hw+VBzP5FlnXPo8O57V6ZAjJKKiYZH7lM1YNwvdwfVGh56cPmj2Xv52tK0z81qoJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10086099003)(10067099003)(56012099006)(5023799004)(11063799006)(18092099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vb2dCzlI7MCNOB0pvuvDXLwxg9nkM25aMoVRlteBhbIcV25Nvnsls1R6L6YG?=
 =?us-ascii?Q?t3C8iC6FhEi5/NpxTvqnn91h1whypfUpnFI6CrZjXpAJtZtZPVyyAyASDGPa?=
 =?us-ascii?Q?DKXVeGuFnMCd0njqw8Mf0tWJxFT896HbFqncN10TK3HMW/onvj25vRpYjCIG?=
 =?us-ascii?Q?5HWRKMD2CX2xHftKxvFMB6KCyie3Zv0gSA3dplyEcgvFUmcj1bawMMiQntyf?=
 =?us-ascii?Q?SGJTxOuq3FUVLcTXyC3BKpp4uDDJj1XKSo72UX0Cuj0zAOpGOCF0qc/vDC5s?=
 =?us-ascii?Q?JNfZ6aU2jyCE68cO7VvaT530RMZxu1eQqtO+kA2Ik2flBuJMKwJ/+/sZhXI9?=
 =?us-ascii?Q?AhmyEtVKPdhaTeKz9/xJJJGAOzutUTtN3IXSl0PZQQWxGo02/OGwQfOiIrKg?=
 =?us-ascii?Q?5fY5kq/s/PmypIOub885PASjbZjv/sS4X+fOoLXHy6gWCfladg2ad0lReKRw?=
 =?us-ascii?Q?7DMCob8b1Rh6zAm47FjlXYvXDKBluogaGb2CcZIyxw7xi+/zggM1X76UiBjr?=
 =?us-ascii?Q?IV2Elv4vP9S4MtIIDfWLADkl1p0LUskGIdRSYLmbULXh1cVpbBQJPYBSBst5?=
 =?us-ascii?Q?zkHLJTka7f/uSlaSq6f6hwxoG+4UyEghb8GqzxEn9r9XTYKov5uf1vJxoqrS?=
 =?us-ascii?Q?OdgtTxrRM8iqUWuiGRFyWgshgK9xJ28N8bdYFGUnvAa5xgoyLV4tPim/0ZCk?=
 =?us-ascii?Q?WeifIHEGrwPvcAV0vmH/WTYx/0M6vtc7i8qCVl4PT9Ex2g6vHCEIIMBagpV3?=
 =?us-ascii?Q?hhzwFqmTZGo5Tmui/G77mC1vf2m7gIXiqxPep74NDWOzyDe1di+GVfuLUrSW?=
 =?us-ascii?Q?LeL+ABPn8YlXwVLzaPq28G+Sw9rcwoP/dYyD0ExE2bDDb7O997QP38qblfs8?=
 =?us-ascii?Q?j/6qWzibPbXeEMstV0Uxiv3G1wodobeOyJvyhPbsITFd9cdltsAE89srSyzA?=
 =?us-ascii?Q?JTGcPjQ8xmgrPCUZtfCzZSo+9nnKTH9dvUQZPU1bPODfQAeW6MGlPAzFGGHF?=
 =?us-ascii?Q?+7P8uKrTB49VXRyURg0k5+XZjKfbnTEbqJ3Hx/uzYJ8ajA/9Zq6gCue0neYk?=
 =?us-ascii?Q?/lBKvPcV/bZGZTjjNu+S6I+Kdx6vuU4J/H3TWsRPVpYYQdPe0f/0tvKf8lTI?=
 =?us-ascii?Q?D1jXcWLDPqS/iRSv3bNWWVQowln7MJ1L7ymFCYBfA4YQQP2S0uvgpvPRZ97T?=
 =?us-ascii?Q?WeaMqJ9zkpYZRQ78EMlB55UxsT6stuJ7+oSJ9s/TbI37nF7AzUsIrWbSNAZl?=
 =?us-ascii?Q?mk0WKiA8dyXecuA4v3k8VmQt0nOQMwyhK9busIZgNO+8/lvg0tJSmDlajXfI?=
 =?us-ascii?Q?CJJ9LrUYAWvFpjuBU0q+Xv6xnUADO9NImQpisZZ2TcGjPPzi92gzZHB/bdxa?=
 =?us-ascii?Q?j+p0aQOxnkj6GJ5Vb84r92NfOjK6QjdfDXcD/2Ew7GBvKf+qSpTFcNqt6nQj?=
 =?us-ascii?Q?nczSR/jkTM3OyZ8w131qQIAjcodaV6XFpEHGRNDP6fYiCG1iPr9PrYAQ3xI1?=
 =?us-ascii?Q?PIZH0mdeKHBkP07w2LWQnfnONIkkM0jrhUS77szYIyqNPXWDQ2VlV3xF4eiu?=
 =?us-ascii?Q?iRcQ7xnxqnfjepsZCbZOd8SP4jltnKVjJjxZ7JUGcrWa5PeLxriiqVPu93Tq?=
 =?us-ascii?Q?EnEEtdXd8ekKjKf3gQGhSNmksbAW0Z8INuy2huEOAALbOOQ6LcFbHCk6c6g0?=
 =?us-ascii?Q?44FfdWeRIkdBzMh1LGIeeBHunu8R4lRzsTn9CIK/WtehpIM8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dbf91d-b532-4131-c9c7-08df0189346a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 02:41:31.0819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKFjv8wHELIK5yOO3QP/NP80SxLB71FuNAWPYH8nO84LjvGtus47ahQ7wCROBKOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850
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

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Saturday, August 22, 2026 6:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
> control
>
> ras_mp1_set_debug_mode() reports -EOPNOTSUPP where the control does not
> exist, an SR-IOV guest among them. Treating that as fatal fails
> ras_core_sw_init() and takes RAS down on every VF.
>
> Nothing else in the MP1 block depends on it, so carry on.
[Tao] you can also add this explanation as code comment, anyway, the series=
 is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras_mp1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> index 2452448806f6..781faf6a7529 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> @@ -203,12 +203,12 @@ int ras_mp1_sw_init(struct ras_core_context *ras_co=
re)
>       mutex_init(&mp1->op_mutex);
>
>       ret =3D ras_mp1_set_debug_mode(ras_core, false);
> -     if (ret) {
> +     if (ret && ret !=3D -EOPNOTSUPP) {
>               mutex_destroy(&mp1->op_mutex);
>               return ret;
>       }
>
> -     return ret;
> +     return 0;
>  }
>
>  int ras_mp1_sw_fini(struct ras_core_context *ras_core)
> --
> 2.34.1


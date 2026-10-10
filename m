Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C2CA9EBE
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 11:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570FA10E0D2;
	Sat, 10 Oct 2026 11:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ec5ET6VD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CB610E0D2
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 11:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L77DI6ULtmgx6JjcJaGRfJsDZ/GLgltf2DaXDKrDcpgzPRntQj4bOT2NH0ppzhw8AArJUDSYynArdlX0GOeYZKU9C6mwM6kJki20XxZUudyYueXBurhPx0S+PVLuKN7Oxa+Irs3VcSCfKjii2vGzWtiFHFdw2JkhhqsIXMJfKOYCmAxnkiK4fx9Fu2bEKLiXgMPBJ1eD6od+GouHpj+ETGxlVMyArBXLt1Jeg1OWzlxuvLfjGyDOYCSBOY6jvjtDY5ozIm38sH0suX6KhaXH0AEc743R4vFFUYWZOCGV1PBg3U5+8+eTPgpDCjKMmTWwDCOnc6kWyn2FUKp4mAa51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpZlALVUdaoj0yvXQOIBO+88EN0/c99ew3HJM4s+FFw=;
 b=Emfw+GuCwYy6I5nS125KSeChXWY7J0TdWkXXqQV7w2kpnpdp2VJqcenfxkrzU2zqMZ7brf9MXj5zyHLqD1HuqwsP879mwOvhkyYOci5voHGFKAI8z4g8U1rorhkBnx/nomUJntiwThKZdrLDslZ15XCCIW4fhJg1xOfI9049VHM0O2grvZiV2bMgwpeP906EQup/0cmf5pF369kq9nKT5eGf+hrA1LGPHvaPt7WFWS5rB+XNSV7tU924lgwFCo/V88LrsQIixPkMCGv1fJWB94mcc7gMZyUCyhVlsFRviVSG/4gJRYcYkQ3l95mt+/tI4z1XXtrzs41ILuHu707vTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpZlALVUdaoj0yvXQOIBO+88EN0/c99ew3HJM4s+FFw=;
 b=ec5ET6VDqMhhUg7O8/JDPtwyOX1Ev/RKAchTolxL9X3qAjXGJVTYTNwKjiZ/tltjGAN7qXKJDDR9Jz6Doe3ZeYEYsjfO68NRc76zTLLWr3KOqRspAnDYmUgOfFHS2z0cPlrndJuTWGV+9IAd6oWkmGKEDPfvy7h6HKuYIHnl9TQ=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 11:24:18 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Sat, 10 Oct 2026
 11:24:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/ras: Add pci bif ras aca bank info
Thread-Topic: [PATCH Review 1/1] drm/amd/ras: Add pci bif ras aca bank info
Thread-Index: AQHdWGYIaNkQKBK04EqCO1EFPuIky7b2ou9A
Date: Sat, 10 Oct 2026 11:24:17 +0000
Message-ID: <CYYPR12MB872996D3A63FB51D5C7F5BE1B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20261010031807.105487-1-Stanley.Yang@amd.com>
In-Reply-To: <20261010031807.105487-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-10T11:24:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: 1e882d99-ddc3-43d5-2bc1-08df26c105dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: R2BrdXIYlC236J6aI78Cl1cj9leChKmgzcnLNFfdY/D7fQZ590kQnmF/E1H7XTReiRYOjtemoNw5Xc7CThVCP4PB2sKW6gB3PmvAaPmmLvD5ttL2O7EIGMuW19vvkXy4+JCKoZmpGnpy2DZRNEiZGYNvcdW+K2e4sDZWWtNGtNUQzmRiQIPzPd+Yk/V8LSOZVSowkXsAAeuh9oSEmb78aQamQ9ixSykWCnnd4hVWXLjqYtEppoOqb3wOtf1d+SRdKGU+CCNzCIAbvwDwTh7pzsG3dRTwNZ9Ve4iDQ74cZfc3DcWdq4iz9CQGT37k+Er7m4jwTFpWIQCbFh0WBYeLCDn28F6v9FAos/HQ971XITve40nWDGPGq31vWwIptT8WoIdTZ2VpWegkKKFhbs0/lR+IWM7Hd1sATyS0aM/hSXbOIsXaWAyDj5UDd7P9bPcUfdMylG5BmzIJGu6dE5TKZ3Bnjs+eA27MJTfwcFWXGPESwbwKlfuVtv9S6piQHylpyumso9IvZBdh8wnkoQIEpYXeW2flzwLxEE6R0qDnnp4Xb4UQ/hYoKmF4iZs246arwZ20F5xbq9xpxY2Ok6/YUsmbO3QhrE6+jgcRFe8M3inn2tnb/c+WZJpTOebjdx5nlfPpAbAIlK4euP2lCiOFVbeI7PvOWGxNfNZ4kdHyRvRW+FDO8of31Ymfz1foDyzyRjlsk/KbAH0rPZ964dmCFNqSZTY5dfSN5mZSUG8bLBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hg9X+TWUrNokX5ssn1NEf4j2XDDwRCEiKXiAyLKRf9iFH/SefZSretA6Inx4?=
 =?us-ascii?Q?Ckti3+NMK/qb+vUoctGqNJM4fQ6eSh5t2qJ1V3QfjdYNLwUZLAz9qTUBuBAU?=
 =?us-ascii?Q?6aX48y3m+t+BlAy3WvmBBJp/KqbEUT6jqqInE9aa+lG/nreL+ldyeWW0JTd+?=
 =?us-ascii?Q?Wfw/62cAxr0J7JzBfatzzLDo2Qq75wgCiOhKSKev6ahCjDNvTuJha0hoISxg?=
 =?us-ascii?Q?nCjsxkiuDkaq/KMtEFFBsypraebMgp0XKq3qg4X4uOFCQ/TmBZUvrvMvSMzT?=
 =?us-ascii?Q?VTgiepYeZ/XaTFE4SWhaJXhX92FLL1qEw6cduFIlQcyDmq0R8Z33VJPbADFA?=
 =?us-ascii?Q?XZZEVSkf4I2yLDOEQC0FHNkF5VAiPeZXUPucThBUMK9aIKEgYdaXLCm1HWiv?=
 =?us-ascii?Q?osUcy7yEm8Jvpw+6Ydv5JJ48QHFQtfR3vwbDMJbwR1zzA5MnfB8eEmtOoWV3?=
 =?us-ascii?Q?4CROyC/I2nUPiA73oXv0+h0r+l7y4ohiZs2q1yJvNTxCNpURmG1P3lqf5CjJ?=
 =?us-ascii?Q?j5jBS1r8hxPx3kOL4g1woozN47HIqbbJYirMKZEHM36jc5XPBWCNqJotR51s?=
 =?us-ascii?Q?/QI9NIFEBuPW1GtPPajLuhPWskJt+74vXsRSaShNSQqZxG1kxx1qJr3fH6f9?=
 =?us-ascii?Q?z7zQ/gkQgvPlrmHM8Lf2S4OSdn3/eRSDQRT3K+I8JLbhM+leU8yx8aRdzFqh?=
 =?us-ascii?Q?f3UEjmlBf9TcHUbWeRePhEGM+ZCWecv2k/MRrnJBmeLmlxcDVF6XlRY6ItDG?=
 =?us-ascii?Q?zG66UJmZGw6B823oo28pY1C/mUQlA/9ZEuWYCvTTYZVYCMbr3ohnY0BMiB1e?=
 =?us-ascii?Q?w/hIJOlId9zrBRBKWP/7KPYOwECstNwhcBCQRofGBVScTD6DR9URfO5gZv3r?=
 =?us-ascii?Q?yHrHbqH/884Q96o1uxOYHVB3Tz2zj9sZCChymH8QVHP13wcGP+xZMBbx5ymI?=
 =?us-ascii?Q?gEuyqivOjgwx+UA6MkTLNUlJooNvUsPGfpDamPuFUlMQmufc5yVbD7CVge/I?=
 =?us-ascii?Q?lbZ4NgD8sIdd4VxjMCyhyfypxpSHhowYiuzGZhvJuva/ZBthhWOVdwRtKUrg?=
 =?us-ascii?Q?HkSHGbLUDLKydiUukP1ffrqEpKKlyMFBxJy1MyHMS+6QuKHNHc3PZ3I4lHoO?=
 =?us-ascii?Q?Ua9y+uABMocfH57aTwerFD6fSxNydgQXH9yBC3E6U2V8BhkM2HZ2fC6fY5hr?=
 =?us-ascii?Q?9TEyOYEXdbQpSAWQ1gNCTHg+wiRqPHDw3dtykkrYGSo8Y29oJw1qd0qrh9K3?=
 =?us-ascii?Q?iek0kkU8KVwHx7Pa3u5Y+odnSBAINfrE2TqvQ9Jq7h5CJAAumDspGdCO5VL4?=
 =?us-ascii?Q?k1wHh4NusTLyhD19oJNTFN+Xy5+OwEnjgpxTZCYiCj7ePvG/hCsDKIIk+SfG?=
 =?us-ascii?Q?i/PlK4toz9OInFq1529csd36R8RoTm9vYEcXUYUWd1499zDCURmwdxAskaXY?=
 =?us-ascii?Q?cAsjJn/2VdkkdfEvtdF0qN9YklibM2q4BVNS2A3mcPY5b/uuCcN4kI87KW+s?=
 =?us-ascii?Q?wlLZEQL5k5L1okC6TykTi0kfLbCAoIhVMU0vF0vxNdFrM7lWqGJ0lwQxC9iG?=
 =?us-ascii?Q?I/HzVs1TFm/x526a6jQHwZdRHfZ/+H4x6ztSK2Di0jV2/nRQ68pcQcmEjOer?=
 =?us-ascii?Q?RKmB2HBqmPCF4nTBii8XhCFW3M25VHCjffRWAV+zapWczKnclEgX5Mu1UJ4Y?=
 =?us-ascii?Q?Z7+Asn6u0kwC98PKxa0vEI0df2V8HA9W5bPibh+Idui5pV89?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e882d99-ddc3-43d5-2bc1-08df26c105dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 11:24:17.8198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zu66OWVMyVBVNzEwbDGkMrzz2Vn6SCupLDvmFGg1xHwf+eQ32UqolDb/6XQ9VPQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Saturday, October 10, 2026 11:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amd/ras: Add pci bif ras aca bank info
>
> Support set pci bif feature mask to support error injection.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/aca_v1_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
> b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
> index a4145f30f45f3..f4fe95a8eca33 100644
> --- a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
> +++ b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
> @@ -353,6 +353,12 @@ static const struct aca_block_info aca_v1_0_mmhub =
=3D {
>       },
>  };
>
> +/* used to set feature mask without parse error info */ static const
> +struct aca_block_info aca_v1_0_pcie_bif =3D {
> +     .name =3D "pcie_bif",
> +     .ras_block_id =3D RAS_BLOCK_ID__PCIE_BIF, };
> +
>  static const struct aca_block_info aca_v1_0_xgmi =3D {
>       .name =3D "xgmi",
>       .ras_block_id =3D RAS_BLOCK_ID__XGMI_WAFL, @@ -369,6 +375,7 @@
> static const struct aca_block_info *aca_block_info_v1_0[] =3D {
>       &aca_v1_0_gfx,
>       &aca_v1_0_sdma,
>       &aca_v1_0_mmhub,
> +     &aca_v1_0_pcie_bif,
>       &aca_v1_0_xgmi,
>  };
>
> --
> 2.43.0


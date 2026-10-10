Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B19CA6004
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 11:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0618410E12A;
	Sat, 10 Oct 2026 11:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PEkmr28";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407F610E12A
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 11:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgBI0uOPlxhNLTpg/JSzMAVbof18zUgMC4ylDd1PZKWzIsEiJi6HBTYCs6fbzSMyEOCpQoFnT+nGHX1I9rNYw0b3A25VDLZ2VRNFjaOriI+qTOdjpFuJ5QmbB6pSaS8Gu+6H+fGDA3CH+k7H0nwb1e14RhsT4AUkToEmQ0dp2B213rxojWUHoZLZ0bZuZ27HLiWmW1mOyLH4mJBtPjYkd6fKHk7n8Ovz3UfH5sW0p+wgCgf2mMUZ4V0tbcA602VDckwxlNaoUGZTqovddfcXyKQvZacDWzJ5vdE2vpiZVYBYUeHdSlLZBz8jEl2YQsWnsiLew1R8ak15FuCiQYCVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/nLlYZMB3evsVZNyiVWrRahFZe0SbKPK6Zhnl2izbA=;
 b=l/l348Z8BVyQ2UQxB9Dx+A2FSrMECcIr1V9dj2jD+g7Gi53RfHVVUTgvkV+YDf6pU3xnNpMtBj4Xb+YNe69pjvylNFBbJrA/OrrP/+2+RPSg++tp+GOjzHt2P3sG3k4LXpqWxBVmjT1eFg27WrDWzeCSsSqkITLKqAntbRUFz7AzLgUAmt+cMpFwSMbnlFUV6eD1ZhtN2FMSBXRYv1sg4fRkmII1h7H0vRHkuaqSeW/Yqpo2SOTtNM4qn0skoo3dSuoLsO4SkMcNUBFnjj8MNsDEzhown/Vhyhm5cX154UAbpl4zyMJiJjKIGX6ogCYNqzzoQhzi1faX/F3T0ainrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/nLlYZMB3evsVZNyiVWrRahFZe0SbKPK6Zhnl2izbA=;
 b=3PEkmr28fcTJuPmZGEag+u+TnVpqnbPj1hfkWG+IdCTP7/gKD/eMMWv5l0FoFgbPrGdH3z1zCFPqzB65SVtGZfkB/NDEBNXLfcTquhhnRYwNwWoRtJkw0AFJ/g+4In40E1gTb6OKNRDm9hXmvCZ9rGY/tOyVpf5Fv9LY8TpAHdc=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 11:30:04 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Sat, 10 Oct 2026
 11:30:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Use MP1 feature status to select fw-managed
 EEPROM
Thread-Topic: [PATCH] drm/amd/ras: Use MP1 feature status to select fw-managed
 EEPROM
Thread-Index: AQHdWKMqm2Yjt5pjWE2o8OrCvwb5zLb2o8Dg
Date: Sat, 10 Oct 2026 11:30:04 +0000
Message-ID: <CYYPR12MB872900A5B22AC9B88499BDD1B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20261010103551.211173-1-cesun102@amd.com>
In-Reply-To: <20261010103551.211173-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-10T11:28:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: 33beb2c2-d787-44aa-3da9-08df26c1d49b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|260925021911599003|56012099006|11063799006|260925021311599003|260925022911599003|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: ZIByD4u38sYaU3vzFD56MLBfVc9Ay+3ET6EIZTb7I9zhb5LJ7DVOByEqRk5DsOHmQ6e9e9FigBO6k7cvKvzTe9aka7vb+gVO3cTNHseJxBLv/eaTSVYmHz62WG0fBv1CqdNzLFNgmGa7AqDNJ+yN8oV7KwlamZiIDvycggN3paN0zbjFDQmPQDTPDs5grjGVGSqbGTYmlengx4zPwumycj8O2BaxEuTXv4dt7hoGy7Iz2KMXOwbLQrAkp680NmxFFV+xBUrAUCwws7bD5cjeAmgWuU1GnsRvY9D0gHfN6nZEVgkE9r5sVn7RgYnEoVWX9LQGUaXVf4h5MwfLE500fYiMitOr1HIcTBE4MECxn8NWI14RYw5Y4SjfObPTjOmYsYZ59+sh4O4UI3snMkTVpGEMt7F+qDfYamnmlR3a7OznChoW8RLMKCjXDR6P6ewSGYyvfs6CvUIqg/rN2heMnYvvAukkBLeqolH/ajzKuJ0CK8l+9yIcZUEPkSPDVE91w0Ww1/3oesKwpnJcB3iwGp8i10iYrX0YGGPm86d0TfBHqDVM9aQgXHqWbx2yxTZFuSrifCF84DoXpUGaiU3XjUtkMFli65CBD6Weylg8jHrQeXior2YZA3WHkAt937QGBp39aEWvJnWgFQ1p6tJFAeidyoEAhqQWqybF1TF+s9s+ZU6SE3Cefba9YebDtjBIX2ZHj1S+WE6RqPK092FuyNppm10NwwQVHO62TweuQSc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(260925021911599003)(56012099006)(11063799006)(260925021311599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+RToFAZr8gi2th9p0jCDDFr/DPVF+6TkYW0Z37gJlRwjOA8r+9Al4FZ3W9v?=
 =?us-ascii?Q?QIMbU/FpO+0a5TouJFJn/NCmIHngQ+7CChke2m81dw7t7VsLBiAhsxAmZWub?=
 =?us-ascii?Q?I5eUad2PGGmuFkxXjRG9D8ajA+I3EliBdYXyIPw11WTtXna83Nsrf+HMSpWq?=
 =?us-ascii?Q?2Q/UL7c1QHw0SUKesJ8Xu4d3hAbtWlfS1mEt8VmFcRDQfQWHRWezz3BJlCEq?=
 =?us-ascii?Q?hkj2ZeT1ZfoTxpkyJlXMnb3RKm2Zm5bZSCilPg3XIt+E/V1IOeSKVeTiZiGu?=
 =?us-ascii?Q?+s96FX2gDen+7jwlFlt+n8j8vXQwOqCGv/5JPrz+MZ8Xv9V2FigV+54B9vPg?=
 =?us-ascii?Q?cO0N+9S/wHR+adPe2mDgGdzW03HQ7ViEKfqRj+CeFHRRe+BbJK5Iax5AK2CP?=
 =?us-ascii?Q?vYtoZ1jDZtJCX96DTwsHlxrEOXge5ns0hndjV8KzP3igbzeeUmuaSnDYe8ZE?=
 =?us-ascii?Q?0rWzt3jmKYuLO0WVYgayJrhIAxIVW6RUlQ/A5OSztvdOTTeUQ4Lowra7pxL3?=
 =?us-ascii?Q?QvNI+z3TUnlKpRDDub91oND14PJFhTDPcKXrsL3shwqt+dWb7e4JS8mQEcqC?=
 =?us-ascii?Q?yfFkDK7JV1vGnAIwYyV07lk931oZHcCTuymJmna1MgPar/W8/Pj+eABiiQ1x?=
 =?us-ascii?Q?ZLST/to5hrAbZIkIc7ad5w+1CwRM3crPA9UsvYLCoN8oo0QWaH5LgxUyn3Hx?=
 =?us-ascii?Q?RxMMVC3L46MEjmhYzRsUQs89+jYjH90rWeTQDJr6ick/WRQm7Pe7y1bGf2Y7?=
 =?us-ascii?Q?6k7VnaPbrB2w19E7zgjb6Q/gSHva5YHyMz9Qw6Y5CGvHXZ6JJCIm1dLL+XDS?=
 =?us-ascii?Q?uNiigkxNPW1cn6zSm33/YQjLMTAbeQY6z8ff1nYuQi9gP8T5L7UWIvWMZ7J+?=
 =?us-ascii?Q?e/NNakcvT6oVCykR50VyA1LY74KOTf6UTjrjy/ABLiVLPHMHk8pl5JF/XyOh?=
 =?us-ascii?Q?HGzIZTQKxeRP+XGgVnTEmr84Wd/q0RI7oXOD28kqDXRPzGIrJN37Y6bDb1aa?=
 =?us-ascii?Q?LLGhXaz/Ym7iCA5RlSWs4BiU4Ss/A1T7VIQwEvMyBese7F3Wlcbj+S9ZOsVo?=
 =?us-ascii?Q?0yB8PMn0zagQl7ZNWMW1CRosd8rs/m8ExVJEKA2g5tK5OM2bZwzQqVq3hYHP?=
 =?us-ascii?Q?SvqTDE+lnvJs2Gsc4SbkKIps6UDxtGb7QlJVRidjt++685gWrBmKdvkgRr2G?=
 =?us-ascii?Q?Q98+L2ajdIx55DKbAh/5Tp0B2zgKdAjfiBqbuxiLK10DTrgi5APajYjOH8eU?=
 =?us-ascii?Q?M0eZqCJPJSOI+Srxtx9P28J6eq7D12us0ZtFEjS5PHAV5GOu65jUchw+NLQS?=
 =?us-ascii?Q?1zSpJNLkbJZlliPju8bCgASqMu62nwOjMsG7INU0wL2OKn3MbSpl7kOPY2s6?=
 =?us-ascii?Q?ffhhl857P0HlQpfphKXq1rADWZPUe7mLB0ssnAsSRZcK8iNs/k0ewlOJKb3Z?=
 =?us-ascii?Q?FS1Xt88VK/yG4BrSlKbS7fKwzTuecsiVhx9ZzSKy3iuGvbEvY47roD2hlkwW?=
 =?us-ascii?Q?raLndQVrDexJDOW0HjEJM91R32vyG43LcTYDv3MBqUTbtWNZ5EHRD3Tldl+y?=
 =?us-ascii?Q?lCvN65o4RQ/oImNxJyjKL3Q7zhM5fGvOEb1UlciNT7fTmG5LjVun1TdWWFpg?=
 =?us-ascii?Q?8EjEIsrHiH2H4h4Od/itrrX1oa23lofBrWG3HDN1EZrzCz6roLEMtvm+RDbR?=
 =?us-ascii?Q?xQfXawnUjJKN37iozA6LhfPhXlZf6XNLmOaxPDidzbZaPw4m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33beb2c2-d787-44aa-3da9-08df26c1d49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 11:30:04.6941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiMu+RA71EbqCZdodUyB0k1VKhDqDSpyISpouOpxybt1lrhNXyhJOF9Tfqf/dX88
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

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Saturday, October 10, 2026 6:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amd/ras: Use MP1 feature status to select fw-managed
> EEPROM
>
> Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM
> to determine whether to use firmware-managed EEPROM.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras.h            |  2 +-
>  drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 22 +++++++++++++------
>  2 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras=
/core/ras.h
> index 73e3960c7c8e..1b724aa23594 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras.h
> @@ -60,7 +60,7 @@ enum ras_gpu_health_status {  };
>
>  enum ras_core_fw_feature_flags {
> -     RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D BIT_ULL(0),
> +     RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D 0,
>  };
>
>  enum ras_block_id {
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> index fe0e35357af1..6b9661409534 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> @@ -26,6 +26,7 @@
>  #include "ras.h"
>  #include "eeprom.h"
>  #include "eeprom_fw.h"
> +#include "ras_mp1.h"
>
>  static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)  { =
@@ -36,25
> +37,32 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
>                               struct ras_core_context *ras_core, uint32_t=
 ip_version)
> {
>       struct ras_eeprom_mgr *mgr =3D &ras_core->eeprom_mgr;
> +     u32 status;
> +
> +     if (ras_mp1_check_feature_status(ras_core,
> RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &status))
> +             return NULL;

[Tao] for old FW, do we need to set return value to ras_drv_eeprom_ops inst=
ead of NULL?

>
>       switch (ip_version) {
>       case IP_VERSION(13, 0, 6):
> -     case IP_VERSION(13, 0, 14):
>       case IP_VERSION(13, 0, 12):
> -     case IP_VERSION(13, 0, 15):
> +     case IP_VERSION(13, 0, 14):
>               mgr->eeprom_early_init_service_supported =3D false;
> -             return &ras_drv_eeprom_ops;
> +             break;
>       case IP_VERSION(15, 0, 8):
>               mgr->eeprom_early_init_service_supported =3D true;
> -             mgr->fw_record_enabled =3D true;
> -             return &ras_fw_eeprom_ops;
> +             break;
>       default:
>               RAS_DEV_ERR(ras_core->dev,
>                       "EEPROM(MP1) ip version(0x%x) is not supported!\n",
> ip_version);
> -             break;
> +             return NULL;
>       }
>
> -     return NULL;
> +     if (status) {
> +             mgr->fw_record_enabled =3D true;
> +             return &ras_fw_eeprom_ops;
> +     } else {
> +             return &ras_drv_eeprom_ops;
> +     }
>  }
>
>  int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
> --
> 2.34.1


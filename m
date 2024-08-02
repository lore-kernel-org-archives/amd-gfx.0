Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC6AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 02:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E04610E98E;
	Fri,  2 Aug 2024 02:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aouimK6s";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E937A10E98E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 02:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOHsXYwd6eDpwkfUA6xuvad7os1S3rtGV0pLBxPK0pOtOuNN5pS2JLBQNDywGCa6QFyKqm7ENKSOX7rImunls7AwP9RRhjDPU1shd0w836UG7JYdzW4SeGbGNtRp3cfxSa1ysDrvuNEfPSCA70EUEl6h4iAP+nTVuBIxU7BWSfD0TYB9BwT6zA9wOOL9GS2Qas/CTDuZBZT/gkbE6JdVWzg0Vm8szmoap2nKWlxlfBNtOIQ8F+1iaU0wC4pxdt1WlwS+CHAlip8IXDKpYT+u17+X9klihZt28BZbDGv7i+tD/p1gB2qUgKxsRFegIKBcPbgY15dYhTmaXfGjcVMpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUBRIFHnNtDFrXgpdyv1FU/35Gs9EQrwX0V9xPmGhpM=;
 b=JM3FfVX5PwfkL5YLOgwf/CFHHEukGyUUuebpR9/nAmoKKn5E64lGU+DMWBq5IDKK1MZXsmuEWYP3SjFp5kRWxapraCtOyfEVBrbEPCJZDeCZsLd3uCv/FTYH1b03rzbpgwG/wHA5IVEOPrgdqBxpwDsnTn5asM1YDH6Hs/uqSU0ArDq58lc66Z7J9QRiuxrZbsJONX0v50EOuqyTOe1xy2SUBwGhDInIgdCFItIav07ayBeV3I5Mqkbvw8+tRTwsI8wyXiXC0un2AocuyjqEEdHCn32e+xMZ/6nyK1J2nxMDpAqsVfRiQ0i+tOA+QRTHGJp33BVWioFa5gSn/AeNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUBRIFHnNtDFrXgpdyv1FU/35Gs9EQrwX0V9xPmGhpM=;
 b=aouimK6sr2vig9EZ5aEeRiiqHb/y144ZGgvRWN822NlhP0HHev72L01WdUqPVXtecHHdVG3+MBFGCnIxzOY10JOxLmjnodpFC0dY76wU2zztEbza290bpGYsCvl2R82cGg4u+Wjc6OMGe6ZLdEruiOgwhxRE5zIIt3MBbNIKhIk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Fri, 2 Aug
 2024 02:28:23 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 02:28:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'
Thread-Topic: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'
Thread-Index: AQHa5IKV8d5W+iDLCES+efnEPhdeq7ITPbPw
Date: Fri, 2 Aug 2024 02:28:22 +0000
Message-ID: <PH7PR12MB59978FCEF0EB2D127F0EAC8D82B32@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240802021805.2093640-1-kevinyang.wang@amd.com>
In-Reply-To: <20240802021805.2093640-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fc826ebd-6256-4447-9038-4f80707c8df6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-02T02:26:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7911:EE_
x-ms-office365-filtering-correlation-id: 380926d5-2ce2-4dc2-6634-08dcb29ac7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9LksBGFTL3k3YnMh7oQc3d4h13njmoimKolCxwFeKppDLTY68XmkPHqbe9Tf?=
 =?us-ascii?Q?pCDNoL84gDlR89fxfWfS8ToOerqMsUsJ8KjiPT9J/0XVKUcPYxvqGvMeaY+i?=
 =?us-ascii?Q?tKR8+QzVbwHniFS3oqUcRyu0S5An7+4bUNPKSFBlNOKazZcBWcqlLtNrzMjf?=
 =?us-ascii?Q?kml+JWmaDSoxugoo/ruDdwIgTB81w2+Ga4Hgy2Y2SHjHCuP6v+KNPSRUjvGe?=
 =?us-ascii?Q?NboH7bRFOzyhim8iuWya0oeyMFM5WgFwTzUotwgM2bxWGg1t/DDPD/uEdfnv?=
 =?us-ascii?Q?dQ5wfvWNkCe+kDECd8bMHwawvL4oHVU5FdGqX9QTJAIvpd1ch0Y/J25MI4ve?=
 =?us-ascii?Q?iyKLLozPNlpOMEpC1UFDZEZAkQ5W/RU45ikINelzHR5vM523j2SdxDjzDLfg?=
 =?us-ascii?Q?t3ZCiJH2Tw8PSoHhSdTdzIew9eLOHpWMMYaWGsFjbfx+JwnLirV52MJ9xNPz?=
 =?us-ascii?Q?D3dk858ija8pkp4A4DrrRSIGmzUnAGl1q2rFbJh3CZrKmEfyrnMVSg8rv+Vq?=
 =?us-ascii?Q?IXO1wsogqQVEJiM3uNleQgEewCykqeM2p1ioddpFrDb7mq4e7GbC23md3ypl?=
 =?us-ascii?Q?IiuQY3HlKfnMcA4P22eLloZfQ8x1MageFIgMhFn2AJa5QpvdshTy1flt5unJ?=
 =?us-ascii?Q?c0axkW1o5NRgSTaEPQ5pHttKnPoIfEnL9c0N0ZcVhCGpEutbbkPJ1Pojqbfv?=
 =?us-ascii?Q?/KgriOJXnlNNnsCb74x2boOx+qvwyR2lloW7bcZl7z0EeReofvXgiRmSEFb9?=
 =?us-ascii?Q?23oB6HCgCEQa9nYGebEeDXCv3n5E6xRPok/ZFZ4MGLcX7Sul3VVyyDMNfXzI?=
 =?us-ascii?Q?AUkrd9Edcak24ptymU9+c21XNO+ck8ro5xJF/Oe4HAdiDE8DHYesr/VuH/t2?=
 =?us-ascii?Q?kW1Wh46MahDqMssQWxyfhdBHDpajHuj7B56zcyUpGE8pqrI5QQh2U5ZQv5GB?=
 =?us-ascii?Q?IHl+UpxYGuyzYthjt7Ju8YvMAw7rWJzsCyPFRyc8pM55/HLUyOS2QSAoDesU?=
 =?us-ascii?Q?TWle6uEaIBkUz5+ADH/RJEST+54k8kWYwhxkisASWuKuoJpnlIpm/FHdvMKM?=
 =?us-ascii?Q?77Jift7b7lUsEVnhVlxswGMWcxYcbNcfKtsDbC4d0jgLF0sH+o3eE59mahHJ?=
 =?us-ascii?Q?1MuSfYWFADuLv4fFTqzZopxVjj0SZlRekCmt1NCgJKEYWd1htiSYbCrwuUBW?=
 =?us-ascii?Q?9HkYsssvObsMHyYiQg4j64aYrvEroftp9BJ0UaepUK9WDc8tl6YWA49wwzD2?=
 =?us-ascii?Q?pkYC7oItxuJ9ql5ItUaQ21HKJ/pl+Dr9kpxSYE/ql2TQvsB5p2lZ/CYY3YYP?=
 =?us-ascii?Q?eL72VSX88GBqwU3g2A5CrwHZVDtMaJ89/6t+mBDJiJO9OKESAmM+7ThzDhYK?=
 =?us-ascii?Q?ropirzdPyGeVCcCyMwZGhtu8TSj6XC6UPDXog/VW4BD49Kj3RQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzAdg7LWPE9B5q54o36v1zLTyg8lkw10MKogp/5BVM07mWndA2DY9GqOLbxd?=
 =?us-ascii?Q?a4xGGICBaHlebv3TEzpObXxZv3o6wmcKqd8jUiOuBv7uEdjCYWx/0N0en8n2?=
 =?us-ascii?Q?Y5tTiltkHVUR4tLO0rzDPHP7IbNMCPsMl/ZYD0qcWUGE55F2GgDeZiZNDg2B?=
 =?us-ascii?Q?Myt3YgY3FWBCJlEn14R3Gl9C0zipI7+JaEqfEmsGiget/J9aD2fRnPhvMYd0?=
 =?us-ascii?Q?zeBzbnzF+8vqa3XY4P4ceAxG4lnHLw++wpJBt/PLZEtLGUTwyFDV5uHPUnC0?=
 =?us-ascii?Q?LwZqcCrXjgmxSEpgYPY+hSt+5aGGn2L0QTtduOZ6FYFkzlaDN3cOSOSsuT7A?=
 =?us-ascii?Q?pjQ1WpgVkimzc8gOiuOF28GNDOaRAE9PJWK0daJYb/iYdZhZB0V3l/LMsP97?=
 =?us-ascii?Q?8JH6yzOwBdTln6ZmU17aOVbFseFW69ZmYoOiAy3TDa28pss6BjaeR5vev+ju?=
 =?us-ascii?Q?hpKBdRPevewtaouqIqjv+VK0irbKFYWdssgGsKK81Y6IA3RdUbZZLa7cdiHM?=
 =?us-ascii?Q?x+h1Yfz9diMlXY2xaWSyu0KiNNtDQQqB7mQQvLpzWmwf6KNlyR5NoYkfx85k?=
 =?us-ascii?Q?vM2V80Ns1IyYH/hBoX0CrhHHnlK0oes/YXGfo8YGAYq7c/HboTHdah2QoBZD?=
 =?us-ascii?Q?wB9DGOycl5wyHbS4HEwfGAOBO8uTy6MPcJ9Evkv/25H2furjPk76OLgMp4lq?=
 =?us-ascii?Q?QAQNjTeB16/VHmbOvIR8sNJNz8T5Z0qtKjQAjx+yqzprd5C1tJ75XAJtSbIj?=
 =?us-ascii?Q?KOdZeNIpacqhMLqM0O4RpjNJa3s6VYwc1s80QSbp+XKBAteUkK/nhE49vc8a?=
 =?us-ascii?Q?070qxvP0Tnc8La/ShBQ4QYeUPcz0ttycZIuX91OV8LTHeS032yJvpfa5qadL?=
 =?us-ascii?Q?L+TNYCBJsmfNDq4lXnsY4EQwMt7ZZEm4ZInd9KoiAroUCbUMLpkdBWvMwuEJ?=
 =?us-ascii?Q?fNCB9SYhCWUQAGj4wVBAQSC2NVWuqLM90GUdoNzY/Z4vKU73tagVw5MX6l98?=
 =?us-ascii?Q?gd99lGKi6nO585OnRWKzHLjGvltcEE7Z4DLr7Qp9zqM2jaJjKak/Ob8x4PZr?=
 =?us-ascii?Q?rEsRZcRHEbLGBOFkxjlcdlVIkX5BZdh5Z8LHHi211wt3yzUaFhBAlaA4WA3Q?=
 =?us-ascii?Q?BLYsxfE6facAxs897uZ9pTE4d5M1Glqr4M7X+Iav93J5I9DU+JXrFM1rwiQa?=
 =?us-ascii?Q?N6iQYIrMa2jB4cHgbJT+Ol/TTgYdhOi0SyeupTLv+rzlgOQifpFE7H5Kw9dh?=
 =?us-ascii?Q?nEtIZNtFVT2Mfd1YHFiJThfUiatYNXgesEPW3XFpdxDsBIhBz1kIveMKLfRx?=
 =?us-ascii?Q?aEPNN3A5PVNErkCj7oTUWluL8SD6cxJLstBDBzcrOqgW58AE0ZDhy/6YyIYR?=
 =?us-ascii?Q?TlaSRl+aF7fnkCH8z+ESX6Z1tcVyOe0BfZ9R5kf0vMi6zN7BLWwck4oY7mTM?=
 =?us-ascii?Q?Qlq2jzut00KgSpOuzSsJbkwgV2rwWSG6zJOG50tg8AGh0N8h8g5nVk606ijt?=
 =?us-ascii?Q?Dr9QbbQVzZU78fFAWbJEWUH+p769HVZBoSCI6nNYK/Tf3ZXyfQB6+JuMRQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380926d5-2ce2-4dc2-6634-08dcb29ac7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 02:28:22.8753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+WSyyc+/sO7d2rRLlfSSIGHmE8nNT7ZiFyKIqa3rjk5Cbxau9gG8o7F3/sY7r0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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

Due to certain network issues, the same patch has been sent twice.
Please ignore this one.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, August 2, 2024 10:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: remove RAS unused paramter 'err_addr'

- amdgpu_ras_error_statistic_ue_count()
- amdgpu_ras_error_statistic_ce_count()
- amdgpu_ras_error_statistic_de_count()

The parameter 'err_addr' is no longer used since following patch.
Fixes: efc4009da0dc ("drm/amdgpu: Remove unused code")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  |  6 +++---  drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c  | 14 +++-----------  drivers/gpu/drm/amd/amdgpu/amdgpu=
_ras.c  | 18 +++++++++---------  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |=
 12 ++++++------  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  4 ++--  drive=
rs/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  4 ++--  drivers/gpu/drm/amd/amdgpu/m=
mhub_v1_8.c  |  4 ++--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  6 +++---
 9 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 19158cc30f31..929095a2e088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -453,13 +453,13 @@ static int aca_log_aca_error_data(struct aca_bank_err=
or *bank_error, enum aca_er

        switch (type) {
        case ACA_ERROR_TYPE_UE:
-               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, co=
unt);
                break;
        case ACA_ERROR_TYPE_CE:
-               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, co=
unt);
                break;
        case ACA_ERROR_TYPE_DEFERRED:
-               amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NU=
LL, count);
+               amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, co=
unt);
                break;
        default:
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 2542bd7aa7c7..18ee60378727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -396,7 +396,6 @@ static int amdgpu_mca_smu_parse_mca_error_count(struct =
amdgpu_device *adev, enum  static int amdgpu_mca_dispatch_mca_set(struct am=
dgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type ty=
pe,
                                       struct mca_bank_set *mca_set, struct=
 ras_err_data *err_data)  {
-       struct ras_err_addr err_addr;
        struct amdgpu_smuio_mcm_config_info mcm_info;
        struct mca_bank_node *node, *tmp;
        struct mca_bank_entry *entry;
@@ -421,27 +420,20 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_=
device *adev, enum amdgpu_r
                        continue;

                memset(&mcm_info, 0, sizeof(mcm_info));
-               memset(&err_addr, 0, sizeof(err_addr));

                mcm_info.socket_id =3D entry->info.socket_id;
                mcm_info.die_id =3D entry->info.aid;

-               if (blk =3D=3D AMDGPU_RAS_BLOCK__UMC) {
-                       err_addr.err_status =3D entry->regs[MCA_REG_IDX_STA=
TUS];
-                       err_addr.err_ipid =3D entry->regs[MCA_REG_IDX_IPID]=
;
-                       err_addr.err_addr =3D entry->regs[MCA_REG_IDX_ADDR]=
;
-               }
-
                if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE) {
                        amdgpu_ras_error_statistic_ue_count(err_data,
-                                                           &mcm_info, &err=
_addr, (uint64_t)count);
+                                                           &mcm_info, (uin=
t64_t)count);
                } else {
                        if (amdgpu_mca_is_deferred_error(adev, entry->regs[=
MCA_REG_IDX_STATUS]))
                                amdgpu_ras_error_statistic_de_count(err_dat=
a,
-                                                                   &mcm_in=
fo, &err_addr, (uint64_t)count);
+                                                                   &mcm_in=
fo, (uint64_t)count);
                        else
                                amdgpu_ras_error_statistic_ce_count(err_dat=
a,
-                                                                   &mcm_in=
fo, &err_addr, (uint64_t)count);
+                                                                   &mcm_in=
fo, (uint64_t)count);
                }

                amdgpu_mca_bank_set_remove_node(mca_set, node); diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.c
index 0fb2d9285834..d9546a756542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1223,11 +1223,11 @@ static void amdgpu_rasmgr_error_data_statistic_upda=
te(struct ras_manager *obj, s
                for_each_ras_error(err_node, err_data) {
                        err_info =3D &err_node->err_info;
                        amdgpu_ras_error_statistic_de_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->de_count);
+                                       &err_info->mcm_info, err_info->de_c=
ount);
                        amdgpu_ras_error_statistic_ce_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->ce_count);
+                                       &err_info->mcm_info, err_info->ce_c=
ount);
                        amdgpu_ras_error_statistic_ue_count(&obj->err_data,
-                                       &err_info->mcm_info, NULL, err_info=
->ue_count);
+                                       &err_info->mcm_info, err_info->ue_c=
ount);
                }
        } else {
                /* for legacy asic path which doesn't has error source info=
 */ @@ -4618,8 +4618,8 @@ static struct ras_err_info *amdgpu_ras_error_get_=
info(struct ras_err_data *err_d  }

 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

@@ -4640,8 +4640,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_er=
r_data *err_data,  }

 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

@@ -4662,8 +4662,8 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_er=
r_data *err_data,  }

 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count)
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count)
 {
        struct ras_err_info *err_info;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..ad75359dfda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -937,14 +937,14 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amd=
gpu_device *adev,  int amdgpu_ras_error_data_init(struct ras_err_data *err_=
data);  void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);  in=
t amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
-               struct amdgpu_smuio_mcm_config_info *mcm_info,
-               struct ras_err_addr *err_addr, u64 count);
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info,
+                                       u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_inst=
ances);  int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ra=
s_block blk,
                               const struct aca_info *aca_info, void *data)=
; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
index 821ba2309dec..7de449fae1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1389,10 +1389,10 @@ static void __xgmi_v6_4_0_query_error_count(struct =
amdgpu_device *adev, struct a

        switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
        case ACA_ERROR_TYPE_UE:
-               amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, NUL=
L, 1ULL);
+               amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1UL=
L);
                break;
        case ACA_ERROR_TYPE_CE:
-               amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, NUL=
L, 1ULL);
+               amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1UL=
L);
                break;
        default:
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 98fe6c40da64..673926d3c6d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4075,8 +4075,8 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struc=
t amdgpu_device *adev,
        /* the caller should make sure initialize value of
         * err_data->ue_count and err_data->ce_count
         */
-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
 }

 static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev=
, diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_8.c
index 621761a17ac7..915203b91c5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -670,8 +670,8 @@ static void mmhub_v1_8_inst_query_ras_error_count(struc=
t amdgpu_device *adev,
                                        AMDGPU_RAS_ERROR__MULTI_UNCORRECTAB=
LE,
                                        &ue_count);

-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }

 static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev, d=
iff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/sdma_v4_4_2.c
index 9d4091175d29..57f16c09abfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2243,7 +2243,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(st=
ruct amdgpu_device *adev,
                                        AMDGPU_RAS_ERROR__MULTI_UNCORRECTAB=
LE,
                                        &ue_count);

-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
 }

 static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev, =
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 0e6c3ce3ea8f..1a8ea834efa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -157,9 +157,9 @@ static int umc_v12_0_query_error_count(struct amdgpu_de=
vice *adev,
        umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
                                            &de_count, umc_v12_0_is_deferre=
d_error);

-       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_c=
ount);
-       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_c=
ount);
-       amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, NULL, de_c=
ount);
+       amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+       amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+       amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, de_count);

        return 0;
 }
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1668AEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 00:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8925A10E386;
	Wed, 21 Jun 2023 00:51:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED86A10E386
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 00:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd5ajBwq+Vfy8+WUBY4b3Fao8yEEpkql98KY/NZfnZ09LIB72HxI9cvfZzQXG2EcqcbswUGeph+XWEapLe2+J7dVwpaY4Fy/tEGbCOPQUuTtKJ5gV0wYEIB1tm+zPaSCH6QE6Bpc51/WPsdBGr+moIjaHdz48hKmoVVXA3HSyfOtl51SLjXdQkwVMwYty3EKhuAWFUN17R4tW57Nly0iPXu9hxmWL1Pw5SIq+m5C6IPEruQoF6nk33XBj0Yyr1bblL6jJ5PHdv+XusxxcgWCoh/R+7puUV+racDR5AgK2vANqc8neYMqzxNKGsOaXRg5v7sgXM0mT6g87hX185oMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7X6BC49aBT/oHCVhw/L55lMpLT3aYfHY77jlBdvjx8=;
 b=hluvXnwRx9m/8VTer1Fv22cszmKDhpZzo2Ao0270Q+ZenOUEmjLqPgO7iK/K5ueR16JcHjXUITDL5t1DlNX5Ot9OwndIDBSngjQajd1cvF/dztSm+AukpO9o97rFTYACB0W4WyRu9nbvSBpNJOM+82jcFQl/QHzmLKTzrq5EuWbTCXBWH88g2mVNgO96gG0enAP+a/fOng5JJe/FZd5ysxHo+4aiGGA/fkw1JmUGzF0HJ5P7sxwjMAriEPZL+MEZh2SzDzop3/Qvb4/L2SfNjPdicS62WYs5Sd6zsDdK8xtyWWmAEOGhac2nLEODAz2SSx6/ANKjOlpj/1Yw3yA6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7X6BC49aBT/oHCVhw/L55lMpLT3aYfHY77jlBdvjx8=;
 b=AOa0rBW44fPxXMljW77cS+FMayvPlSkX/OiVkZy2UeVjrmPi2BarWIgrObJPNGe886NtGZN5ietNzvCEXMQRiIi1s8laNX1pGuPkbvoJBHS4ii+v5yG9XVfcMUy8Am606GVV1DxACqoQ6UBOW4+mBzB9g51Y9W9cQEBD6Al8sfE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Wed, 21 Jun 2023 00:50:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c%4]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 00:50:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add abnormal fan detection for smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: add abnormal fan detection for smu 13.0.0
Thread-Index: AQHZoym2FEy2/xV12UCkbq6Prci0hq+Ubnpg
Date: Wed, 21 Jun 2023 00:50:58 +0000
Message-ID: <DM6PR12MB2619C3423DB9319D56DB2413E45DA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230620034537.1495445-1-kenneth.feng@amd.com>
In-Reply-To: <20230620034537.1495445-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fe7b732-2447-4a82-89d6-8cbc6e8e5f6b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T00:50:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BL1PR12MB5141:EE_
x-ms-office365-filtering-correlation-id: cf0dfe21-479f-464f-be93-08db71f19404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85nB14Pd+aQLLdJCeEoOs1deAHhQWluEyW2f9kS2pY/ywDFKA8KuNiFRnk70742i7KBAREbGpA8eELegFODe864Etx/J9nFBsLObovGaNnjiRvKB73+q93/gQCmbPof3cpLz9gFozn2t8v/bWHFQj/02K8R6Omju1quImK0TuUoWHCWV4ggi+7CZEXbScOtm+R8Ix7wRczW8nohjW657ySgSTS+2dmOI3JVVwu4NoYtbeWAsn3U308EtQFKJo1aekO0kHm/YMGSjAqPOZZGD3X2G6RLkseLrDwh8bOCaX18PcbCajBVBO8YNMf0E1JORnHvZqgcR9e7oEM5HbImboQoNs+lEeGPO90+0sCocr4ckZZxIRL37gFNtfO/rHqBfCK1LWYUJA+oc6943Uw6t4EKX4x9+ohUkshMiaEi86GH3JOzQcnJe74rx1pg8FUUSfBC9IPFHv9WfAtDycpK0O9YAfyMUbd/a4x9GK5Dw/X4962XtbIxbE88dDhgk0hW6522YXdbmqteOeuQXyWjcWosfeJwB88DCw5uXeOB0Hsd/hrATVJjoc04pgD5hFmj1k6uC5W+A/L+xxyntaBHgv9ztE1REAjCvHB2A3J0TFHYzQJ6O4nYEWLE0+E1ULPt7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(478600001)(8676002)(66946007)(64756008)(52536014)(76116006)(4326008)(41300700001)(66446008)(66556008)(66476007)(33656002)(38100700002)(122000001)(83380400001)(86362001)(7696005)(71200400001)(2906002)(5660300002)(110136005)(8936002)(316002)(6506007)(53546011)(26005)(9686003)(55016003)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tORlxw1GEM73lC8518kyjxO2BE4pEybhiKLfjl0metoiRAHB4i98bqLLZgn6?=
 =?us-ascii?Q?E20kfeJ5zON3V1SZKK/wDVJ3a1k6xEi6qZWgS7qxksR2dYKHvo/IV702Cc0J?=
 =?us-ascii?Q?/RE+2KW5dgRaMKs1XXlwAXhRka7OEB+REL9oJsG+Yl+lr/xaDEMDVp/laCp9?=
 =?us-ascii?Q?EPVp0hnQ2MWbvWA9/79xKz8U28B98fp/AYRGJCtIsXh1gDRyS16kQ6ossWt+?=
 =?us-ascii?Q?j0Szi7etdgd5lBl0iVOvn6Kik10ZkrO2WDwcQC2TmaE1FKsdqz4pqKAgPXYC?=
 =?us-ascii?Q?yUPI3bjW7tOefSO7KM2PM5s6iB1pMevG2v1C2XVWWqd53G0fitZ93NfQUrcy?=
 =?us-ascii?Q?eZ7zg/zBzngAWjvw3Be/4xLauv0qY2Nz3saFwqYBti3SQareZfSai9FeCE87?=
 =?us-ascii?Q?1asptxrUqpbQ770olN010NUhwYn1e7sU6OdsrnoAmOXRS1B1rS/8GBuOetD/?=
 =?us-ascii?Q?8bPBQtemoBUIMLR+ihUXLnK+EgEFhkVBP8eV2MRHYuPczI7BfusykFRj7hRk?=
 =?us-ascii?Q?8zxspKonaGqkWcvbaiCgyUICLEkfuczlkRnxJJwdngJX26rlEKOJAnXgsDul?=
 =?us-ascii?Q?SeWzgN1mnjP4yAR4KclTogC8QCwZ5CJgjUpyrlR2iInXBhBglVdq61af1Tez?=
 =?us-ascii?Q?8/jOY4jPwsa9daUdKGOgZ0vMx4CoZyNgwYK4zskbnOL6pI3aJMcEf3uKHRt+?=
 =?us-ascii?Q?jKHnxOaV/pgnDlZt1+1hIVZ4GEdDmHkLIJHfeqfQmJccLKnSvURos7uKVf47?=
 =?us-ascii?Q?/oWz+rh3IdESt1kJx9+2DiShN/O1LP/bC0ycM9MUnPyVzCdcyTBiLc6q48A/?=
 =?us-ascii?Q?v22WKsnjRrP9qes8KKGF9D1mTGghZZHCW5I1QSWxUEfPtZUCuMXUDOc6yZNr?=
 =?us-ascii?Q?c2gtUKo7MgLPWU4cd7h2CnQjQEvybmsWRc6IA6UunOnRYszwGwkC8YJsu/eC?=
 =?us-ascii?Q?zVwy9+YudeJ9l3sL/yzRcbHjrDsb7f5xV0T1A0UrNoWttPMtb5vnI4ZFwHcm?=
 =?us-ascii?Q?cgweKvro+M2YZIUoqCf4COmUPRw7ZEIvNOajlHWeLT1VAJM1xpYeZVSFfnZU?=
 =?us-ascii?Q?mD2cgEA2i1sxDpPnnY3Ia3r02ULNyf859HUlwqY7WtmCgFkXIyR9R8S05YXt?=
 =?us-ascii?Q?yUCsEKH+X8TZ6a97BVPo3RwQfJK36NzQDDtQlcJcCIKQ7a5bdebaiiczksGh?=
 =?us-ascii?Q?FhpAgGtccJO3WuQCUZcj1ptfuypWzkXpcOp7mrGtXiABWtIfIwhmjy8k7n36?=
 =?us-ascii?Q?qriXE1QVyyQsFbaIf8zVdxAMly7DpBT5O7n4xo0jC7MOdCVOde7ECpWErOIK?=
 =?us-ascii?Q?QwgEzLrnt9wPn1zAYn1L/LdpDUiTW1urU1mwlBpGMeCIi9gEVE9F1VsEYyH4?=
 =?us-ascii?Q?aSfSLqH8tXohiTa1EOcD4XGHpezWoKu4zEg5huNUfjeS4YoJecUBbpugE3t7?=
 =?us-ascii?Q?q4GigfYDedUpVAshOz6mccq/1/JOSDWZazm5il0X1FCx8taaARtxSolftC75?=
 =?us-ascii?Q?0IaU+mqhjZinI82FmrMr4V0GJBKHWti9+XvE0e0XIQP9hGOTIX+0qcJ1T2K+?=
 =?us-ascii?Q?Gu3LFC7VQZLR7UCkRJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0dfe21-479f-464f-be93-08db71f19404
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 00:50:58.7182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbaY1TCVcItRxDHDg5kK4XgqTzUQ+S4GDQUXjcdV/YZWzFGqg9ZSk3tejMXDTPwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Kenneth Feng
> Sent: Tuesday, June 20, 2023 11:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: add abnormal fan detection for smu 13.0.0
>
> add abnormal fan detection for smu 13.0.0
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a6083957ae51..124287cbbff8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1710,6 +1710,7 @@ static int
> smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
>       range->mem_emergency_max =3D (pptable-
> >SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
>               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>       range->software_shutdown_temp =3D powerplay_table-
> >software_shutdown_temp;
> +     range->software_shutdown_temp_offset =3D pptable-
> >SkuTable.FanAbnormalTempLimitOffset;
>
>       return 0;
>  }
> --
> 2.34.1


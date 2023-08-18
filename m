Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD3DC05052
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 10:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBF910E4C8;
	Fri, 18 Aug 2023 10:38:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614FA10E4C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 10:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWjdwmVx9ruOENNntOHoBiSDMhCpMgtFEccMpMK5d40TmObaxNonHtfBZmADC4lZCp8nEzmZhnLEpCTmYYzbgFG4Zy3atf8wDEKxD2A1RVQKLELUyDSDqT9AuKRXpqabh0Gyqf8BMUZL3jGd4l/+ldW4Wo/oi/lIEIWjOAb+PE+K6AGF9l0osnXK3CqHKpxDHPwpPvgxXJXuTythdSaG86AZQo6I1E0mDbXOyvK8fD1otqtdBG9g/P0XavOrbkUtMj9wDGt+whMzqFJTfwxFCNMegRQmIh7eN4/11STBDATDjjBsEuxxvaZWVLS7IHfasloY7tOPh9LsnlRAmYwT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN+FuRgChYHDpw4gjgIZZoetNef8mOl7+xOYpMQ7ihA=;
 b=PEVnp9Mo6qXK9bGoUZ1dolZl8XogIKxjUAZKyn8CyH4E/Ow9cZ544aUfTNxmCVjxIyLjVYj2pI9fAUxvHE9uAA+M+W8IIFpk+/SibHMwFF9pBRzCo00LusqVWTTbUO5JzEDhOceCJy4ZqiMnmtcazuTziKeLCC8sK459pWStEof/y3moKApCHjRrLzuTwt+fdJePCINeBQyxR2WkGOLqUkcQl/5V4KvXKxP+rBmC7jcuu4fm8Clph0n4RDw2gF8q8Npydfj/XJyR8s/vCZ0ZqaX4k9sXiWyBfYrg/bcX5JNjkdNvemStQDDbQKGWmoeKZuzIQxxHNSZjj7ZJBFaqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN+FuRgChYHDpw4gjgIZZoetNef8mOl7+xOYpMQ7ihA=;
 b=gfNi/tt7RIGFEZ1P+7isHHORT/ce8tLj1R88jQMS4vZATKI0aD+3WvJQwPrwtG58JAotVtkNl2lOkVdsyUjnnZwnyZUn3E8l2JhN3XrfKrC9rqTJABcjmOJbyC8UMhvAhCS0lOtmy8qSDwmp/a9L37fm+2twoqKiTfg4NYmqaOQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 10:38:16 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 10:38:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Thread-Index: AQHZ0b73+XvrhjvfQ020Iy9JWI8FGa/v3H/g
Date: Fri, 18 Aug 2023 10:38:15 +0000
Message-ID: <PH7PR12MB599710F9DCB44B4A1D5C64EE821BA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230818102943.1229872-1-asad.kamal@amd.com>
In-Reply-To: <20230818102943.1229872-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c479762c-2980-4380-b7d2-fab841ccc849;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-18T10:37:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV3PR12MB9216:EE_
x-ms-office365-filtering-correlation-id: a9593fd2-d68b-4913-ac4b-08db9fd73af8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NW3rR9IyEe85skKbpgFD91HXPa+9XhB5QWlXMu8Scy45GxZ0kqteeiRNiSGCKtPQxUdMrgyPfejJ3LIHbfK2dOD26uDurvEliaepBxYJW0M9sSG/lijXXHE0HxrlJu0ulc8S//K+YV3idKbRXfnt7x5kF+MBgC0TWZ4YrWVA4RPy57r7oh3FrE9Z4k/idroc4YE/rAkKCSF5oz65ORQf+sMlMvgvbX1RzmQfY1j3/2NQUhdS/WPubqXlzznMHLNPvQowKcczRkCyhuuaSXdRo8nQ9JUe6RyLDPmjap9Tcc1V5aiUIaEKI8Lpzc7eKTAPISz2RcMhp298E4zljUHPEBvPW2iPqUFWYw1NfRy92WjZ+U4iPgwsXjFgVy+zLUFoIivW89RsFcpe1khwHNYWNjRuc2cJ/2aHYmArYifrJG6gLxgbzFwyc4KSWQs3swRsd04JXiUbMHyxzaTIiG0RYmGYxfMnqwmCCJ/0JX4v7wyXlG2CM2Id7e/cPtiw9VCmkYanCRQQ1BZSS9amcJUK0Jah05ImrbjqSfQcH15oLiDjHQzh+dcJUIOzK5aBl9V9hjXdcXDNF/0Sx3CNDexAvlP0qzZ1/+ZeWS17skJIPzeDv9oj5XPM/RIoDd1RMINE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(7696005)(38070700005)(38100700002)(9686003)(122000001)(53546011)(86362001)(55016003)(26005)(83380400001)(33656002)(2906002)(54906003)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(41300700001)(110136005)(76116006)(5660300002)(52536014)(8676002)(4326008)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZHKvyFSpvkxY93AuyTcCsvPLersCfFDB3qutOdzZE1uhkyLSj88yWH+60sM4?=
 =?us-ascii?Q?DDJLU5k8Vuo90h7mlKp+QuSCUdZBbU8hIkQnhdrGq7jLDtDQLZiUROi6vgc8?=
 =?us-ascii?Q?ktSsdL6I3qsWcmpPaBpTgwcvJjxgR0XACrYk+s6JrgdyOlzxXK0i5qEuZfYZ?=
 =?us-ascii?Q?zd8s6miVGNV1EPqachgYWLsabpHVCZHuxY84ft28fK81n1legh56hNRacRPe?=
 =?us-ascii?Q?xz0MDCiQjbeS3MC1YEhpJAW3k0nofdoR7R559/kyxacaUHVWJ+O+mLfM6dM4?=
 =?us-ascii?Q?7zWwwuHHEx8aGSXNcqhkhwIMh1PZDoXxjR5uJTC/DxR8047mJnKfUVTLr06I?=
 =?us-ascii?Q?54epwU9tpfZEOubcMKRUJ4am3hPuLfRse4AmHUHCh0ESzduuwPRDzxW0K1+b?=
 =?us-ascii?Q?czUlseGSCEtPuYcD+6r8UPDUUgMcgDaBpnPGIjPjJkdl9uHMXe5IC09g4r2f?=
 =?us-ascii?Q?FHhQawI2wxlodmaSriOvHuXLkNNYbwisDZEhMIComC/oRwTPiaE51II6o44V?=
 =?us-ascii?Q?RIOrGvNQgwNB1HN8Kpr1RAIbXhmrqSaArRRfMEfOzd7aN8JIKEt/KmFmBO51?=
 =?us-ascii?Q?BHYMrspYxrexlJOhKfGWLZwZmf6MpC/pkXy18uLMUvDdldte67hYqU03p9pF?=
 =?us-ascii?Q?WJDN9cAFpxHESyEcTvLQ15CgbfWPKi6eGZngrsjkJZv9+r2tgfaJ2jSh/ewJ?=
 =?us-ascii?Q?zabdbTD38wdHsvT4ID4s59c1Ic5N88+QLNWDk3IaXkC5lriL2ej1JVrCYDR6?=
 =?us-ascii?Q?x+phH/QG1iTSXP3YjO2rGdic7oofT6TDuyh7YMs8m9v3LsyO3Aj4hh3ixgEi?=
 =?us-ascii?Q?/ZTPDTCO43FGPbNeIPON/b0UcKJCwh0yAVdSIxpLT8kcGVYWHmw9AZ59+YOc?=
 =?us-ascii?Q?Ta2SVAPSfI43vCUT3Rv06Jm/r2uwntnfJTmMGsV4+4rQ5PgOOiDF7cLh5U26?=
 =?us-ascii?Q?gBFx092pOhWGdSKBZ2JzvAtqXal/aGFelHNAwJFK2ZUrkIml0p8sju7BJl2L?=
 =?us-ascii?Q?YkoG6ClQ+NhzsIWw9e7H+5mYRhv7/7LTim7wDuH/Jz36pY4d0Mv02LbyjYxO?=
 =?us-ascii?Q?2DDFKxXBFtS/e8iInhrpeMn/UiX/gq00z8D6xt1lpTmqUT5i/FdB/uO6CNba?=
 =?us-ascii?Q?tNTyW5xRBDlxCB/fD5lEnwfpVplogdF5VhHLTKUMCxFcodJjXIm1BmxIjnXO?=
 =?us-ascii?Q?pAuEfrjIPe4W2gYx6YHi33Q5VWD/UPh3avqEWW70mB7Ggmmqvi1JqSz9q2TQ?=
 =?us-ascii?Q?gcxYPFF7wLvYjPXS60t1JFIk0RDAfUKqR4NGn197gxLK0xvvnYGYzIChwbdu?=
 =?us-ascii?Q?TFPrMmP/m+Kqgbziyyp1W28rdOBsxHg34S6L9bYot3KK7o9LiQeH0BK1Mix4?=
 =?us-ascii?Q?0I2Bpcn9Ot2JGrSgpT9CA9CPX8voBkOhKA/y6kK4GzRE9XLQh3P+0U36glzW?=
 =?us-ascii?Q?YAtN0HZ3fWIn972zEN5lIAfFSvmf5Z4HEzD+I4PkRHBGRoo/HXjZlQgP94ai?=
 =?us-ascii?Q?QalSvxkvLmUOrT2bVgiKK0F2XV1rBC7dmX3mCsmxnS5gCt6dTJ806u5y8jMF?=
 =?us-ascii?Q?6MdUFS242l4zhceNlkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9593fd2-d68b-4913-ac4b-08db9fd73af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 10:38:15.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh1qAF/q0zydUwhCQL1MGdRplPs7CJjTPlZerYWOGI01bL2WvC82mLhoUCzOr1oh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "Ma, Le" <Le.Ma@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Arif, 
 Maisam" <Maisam.Arif@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Asad Kam=
al
Sent: Friday, August 18, 2023 6:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,=
 Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Arif, Maisam <Mai=
sam.Arif@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix critical temp unit of SMU v13.0.6

Critical Temperature needs to be reported in millidegree Celsius.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7d8af9b309b7..32da779dbd27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2086,7 +2086,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                                                     struct smu_temperature=
_range *range)  {
        struct amdgpu_device *adev =3D smu->adev;
-       u32 aid_temp, xcd_temp;
+       u32 aid_temp, xcd_temp, mem_temp;
        uint32_t smu_version;
        u32 ccd_temp =3D 0;
        int ret;
@@ -2119,9 +2119,11 @@ static int smu_v13_0_6_get_thermal_temperature_range=
(struct smu_context *smu,
        if (ret)
                goto failed;

-       range->hotspot_crit_max =3D max3(aid_temp, xcd_temp, ccd_temp);
+       range->hotspot_crit_max =3D max3(aid_temp, xcd_temp, ccd_temp) *
+                                      SMU_TEMPERATURE_UNITS_PER_CENTIGRADE=
S;
        ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-                                             PPSMC_HBM_THM_TYPE, &range->m=
em_crit_max);
+                                             PPSMC_HBM_THM_TYPE, &mem_temp=
);
+       range->mem_crit_max =3D mem_temp *
+SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;

[kevin]:
You'd better check ret value first.

Best Regards,
Kevin
        if (ret)
                goto failed;

--
2.34.1


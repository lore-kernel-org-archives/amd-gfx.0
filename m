Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F654C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 05:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B08910E162;
	Wed, 23 Feb 2022 05:34:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2D510E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 05:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8qT3MCHXF1fEn+6p0VB0BV2YOKW94NCnckPBhKierbY2gS+AeIqzVh5Df6Qd6Knp+PJ1FxwslEMVL/7FIJeVOBaa59wREztSnaeyZVlKNFwpNxjl8dEr2Yn1mX3cYWAIIkJfBItyLLhxdpHaU1IvKZg5Z8++3nshSVjJG9gVV2rYJqJ41yNED7S9JpTrCSJz07KnIIgEGV9FHmhnDGwvNdr2YOS1CW30FPcmXCVIFDj7ujYdJGPXrOeMjH6o6UAQiriKI2ky9GDIMoMbkzngRY/QAUDBoB/M6bI1tuJX8qRiWq+wjRJKuBqihStW4YCQNhsz9zyD5KePPPRom28uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vHhHLvrFsjsDdObE9HSd1pb/d1keOKP+9qDeIMyLvY=;
 b=mHpHbpvZllQFubySgbNSlix/xDl953tw+AkrR5SS0/qJL9GyPxcmNKmbHmifKkKuYoBeng3xZy4UaVAoWhZ4ghgU08c2u/kXg4actawTliCScqLqw4PVaZB8amBSmCzfIBK97pilD5wFv2WlYwvRyWXexGkCq7cSHdzf30nBO5eTpW/0c8CA0urFrn0kbZ/bkhEuUOm/+55L5OJjDSRTlfWCAGcMN2v5PAvCuWFwCPMz5JWWWQ/RCuj27cJ2Jj5dt1UQCoTB2Ao6BkAFrUI8mvFWhM+DQ6L3PkUohK50p6J2l9bHAcJ71oAkPjiCw8AEulJbelSk+cY4tEV3bOAgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vHhHLvrFsjsDdObE9HSd1pb/d1keOKP+9qDeIMyLvY=;
 b=kqLNm0L6p6P5j++cEaNkkSjFVxhXw/tEgB/qBlGWimUHYwW9W5XnpTPo18L95HWwQPTH9zgMj01mlgfZXho6yPIY1ygM95fz/MLsDhscH4To4hDAY7y/JOtgaLwQrzVfY3vh/jkLGKcAXjhzuxaavQUmEr+Dt29kZvnPafPLymk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.19; Wed, 23 Feb 2022 05:34:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 05:34:11 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix missing prototype warning
Thread-Topic: [PATCH] drm/amd/pm: Fix missing prototype warning
Thread-Index: AQHYKHYTYVdsxZz0w06hcP1gSvMWv6ygnOnA
Date: Wed, 23 Feb 2022 05:34:11 +0000
Message-ID: <DM5PR12MB24695D857FCC6978D90151CAF13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220223052711.621708-1-lijo.lazar@amd.com>
In-Reply-To: <20220223052711.621708-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ab225b-32dd-4825-190f-08d9f68e1f40
x-ms-traffictypediagnostic: DM6PR12MB4842:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4842F9728A3EB44F9FCA452AF13C9@DM6PR12MB4842.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A44H1o4dsLLWVcFKZiZW2lNQ7yDof96NXHhfLQN4ny9shIQ3W2adoa+eH9FuuuVtUIZc5k3kpAIghrISU0g/buy/ZNLkpVWiQmuMEHnFAtlsJN74aD3S8I0nKrB7b6b95AhKCjtd0RsuIuwyDXpxtzXf1qc4S17rdssd1xptqVOfJ5Vuf4GCDyLDAZYocXxzDGTdGXxKLZg/S31+VqpIpPc7tIfLoPM31df/KCDvT9vvtl1UPzA6wY5N/hyUrrlJW3xJnUehL938AvS+ILhcACdy1dg90PTAr3bWMnYXmfEO9oYOwwWs4VhiTFQ5GepsohKeGVmOpFilndoreSzyaxI+9zOfGFljkBND/EcEVU1GK8L+baiJ1FatRBMhZUXNyODW21zoFU2qnrNgFyHVsc1y/3gsk3Sn7qhOf3aiuIld+eNUzxWAwXQ7KfDY4tA6LqQ0U33U9/mMbWhoeEzdF7TbcprD3wSUN7pX0LUdUPipg88rOTDG38GLyzJq2LimLTkCgqG1Rp30cBQb+jUfCjIK2i6DnFYiuBRhsM1OB5tARGa3ol+zumPgi66ggdBxrPasOs+8Vk0+7lXtremi3gyiiHOAES2MSlGbUnaYX7yvCDuiS3Ad40hYdHKWv7I+ZZQ151v8ySt9uOGHcTlFFIMKlbrudjOJey7yIQ8vrDCaQ2VnOx2K1ez27vMcpf3Sg7amDZGsFyyBfvkQWLDrpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(66476007)(66446008)(8676002)(66946007)(76116006)(122000001)(66556008)(110136005)(54906003)(86362001)(55016003)(64756008)(316002)(38070700005)(53546011)(52536014)(8936002)(33656002)(6506007)(26005)(186003)(83380400001)(508600001)(2906002)(71200400001)(5660300002)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sRTc4JhE0PbQdMc5ApwTvctXOjmRsmjE2biUv6aY/mvv5FWTubSjvLpcVOxN?=
 =?us-ascii?Q?XIf+11ptbY7i+GCQWSuxPkqTwNYbl4g8DRxFQ2ZCDjyL9/P6QP/JpFsdHl5A?=
 =?us-ascii?Q?aDxRRQK5JCvDtTGqNeNRmX2dvFxEviFeHqsEAPWo48g2bwD9ub7BCdqXMkad?=
 =?us-ascii?Q?3+x7gD+1QAdulOWULt0CWyygROYBZf5oFyJggXHJdcB3ij7fb+U/j2oPeq4C?=
 =?us-ascii?Q?W4brzahztjvAFPLpD395xEHtbpG3enxXYTk34eCgIkXbJn8BDng3BwPTqscL?=
 =?us-ascii?Q?AlGX4DGo1eT15UeFm6JIZHMVtpKqNT+1rVMQtrcPWlIawwgksq+xqpsl6PHH?=
 =?us-ascii?Q?c0bxqosMkC3OTT2TjLAkxifs0VlfWJYWxjO4mY+c+SSIkewXVSOcqoLw3MeC?=
 =?us-ascii?Q?hVu8Y6a4V1LTz6KmcswTdc9vy6SvQf613d/3ozYIXWmrrOFr4Yvn610dekwE?=
 =?us-ascii?Q?kpmKkZa71/F6GJBjWwShDr9acM05yZZvZConIORpgn7pUq6aXR+sIufY/UrD?=
 =?us-ascii?Q?07Le8YkIYpyF4oXx3/GhtJUBybKyayKThdNoLArY1D2wD+S6jl8163wDeXKm?=
 =?us-ascii?Q?YT/+vZcpeU3cz+dozUVYtAcFlfgxMbPdPOEyrlsFAD5B9EsVvdwqa+BTkYtA?=
 =?us-ascii?Q?dicjjPmM3PqjskHx6ZyH9b/RmnKEVKl7CFNqd6p0J0w0BFAhAAWAjnusAbCQ?=
 =?us-ascii?Q?lRHXMau2KBzXPFMvLF7ZmJgBTVpWgPMxJJb4LuzTpNeuBkOhtJmLKUOlovUd?=
 =?us-ascii?Q?gEnqs1qAogjWjZs7Q2FO87DpFxblOpnYZarOegpouAtvgdrsipLfRWpa4c7m?=
 =?us-ascii?Q?t6PWQQ6qDiEg1JiinUVobb/PAiBAWc9Mr+yDDoot2Cu9xBQ/twgB5qwnELi1?=
 =?us-ascii?Q?9X+ssrEfdc1xtzQPBUYJbwiKiDFZgcsxWYQ193CcBCYNkjiU8B9YYRWOae12?=
 =?us-ascii?Q?A5Y6diSEeWoOM/oyUo6mzxCmuAJ/p40lFtXL2hGuNZofg0bFPm8iLe44cyVd?=
 =?us-ascii?Q?2Q7Ej0jlPTRY6X3rbj+I27Cl6lcC0X2f60h96K0XsbUXng4mu4XE4rKwDm9o?=
 =?us-ascii?Q?qy27DP408c6yd7rPmVNyxJSt0vi9XSHvPDvo2WLIj23dQSDBDaSu9yaocfD8?=
 =?us-ascii?Q?NnLQxwZKWiCQgt38lA6HntxFFrG68lIfXRd3Q13OLO8iiNU0TZyPEmVrLgOf?=
 =?us-ascii?Q?UsSNN5EGbzOVcwW3U1z8K/okIjLVrKYbLAxknGw7uuAEiG59lFU7vy3c+IIW?=
 =?us-ascii?Q?yuZVBzDzdivKnnA1lWFAEv+tsRq2lFuR6sXuxWEGF+5qAijPj8nT9u5xAglu?=
 =?us-ascii?Q?C0ajvJeYlSs8aNUnR/laUqbYFRU0Kwf8plIpt1k4RKzMFWBDmNHUItBee7Sc?=
 =?us-ascii?Q?UfYx632Kld9FTqBjJbBMccvdHSAv7NNB3GK0fxCCO/rf70ZEBEJo1V20TIJV?=
 =?us-ascii?Q?AeHDV7RVOcMcVhScunaDTFPLEdncTxei1POAIU60asmnxdQiqYCFmx3L83rj?=
 =?us-ascii?Q?5oNKSBNIV1I7Ouz2T3iyDDNlWT9RfOjjUU1wy86r2NqGDOjR8xx+NaedFOEI?=
 =?us-ascii?Q?xAyLLWoaE2TOz/CSeIDr4xdGBWwV2OSdo5OFQK5wVgsju1/8ytT7putGsmHj?=
 =?us-ascii?Q?Lfz9nL8kGho6P9i1TfqqN8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ab225b-32dd-4825-190f-08d9f68e1f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 05:34:11.9250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5JeHICoB4kkvRYYZRb+A/35xZi6wfQ7hUr8YHvCjo4sHpLl1xfrfwYk06EOSsxhiWokNiyz8hCbT3+MuM7zcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, kernel test robot <lkp@intel.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, February 23, 2022 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>; kernel test robot <lkp@intel.com>; Zhang, Hawking <Hawking.Zha=
ng@amd.com>
Subject: [PATCH] drm/amd/pm: Fix missing prototype warning

Fix below warning
warning: no previous prototype for '__smu_get_enabled_features' [-Wmissing-=
prototypes]

Fixes: 716622108a9f("drm/amd/pm: validate SMU feature enable message for ge=
tting feature enabled mask")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 1bd6edf2be41..590a6ed12d54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -523,7 +523,7 @@ int smu_cmn_feature_is_supported(struct smu_context *sm=
u,
 	return test_bit(feature_id, feature->supported);  }
=20
-int __smu_get_enabled_features(struct smu_context *smu,
+static int __smu_get_enabled_features(struct smu_context *smu,
 			       uint64_t *enabled_features)
 {
 	return smu_cmn_call_asic_func(get_enabled_mask, smu, enabled_features);
--
2.25.1


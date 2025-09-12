Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3EBCAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 09:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8858B10EBE4;
	Fri, 12 Sep 2025 09:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/adXMZp";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1A810EBE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 09:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBvLS/ItIc7EuYxrcMa1KYO4fDyKBk9iGruAioQELI/JaguyFeN0oGSoTbC5VyYkmmxGxhgie5WLAnA+xzukHwDi1STrvAIEp4DN757MiNe9Iew+y8P/CsXfHbE9zQYHv43gI8xooyFM7aZd4eI3+eMrSm9ma9RU6ASSbkTU10QmxGPRg8ZwJr6XGX+0cFi0jAmWRfpd6ea0F6n5T0+9Td0NnqtGPUMJRYKy1UaIpK933rnZ+A0HEjVosEZ2eQeDzQ7a4w5B8T+LA0+LqFiIjmGaGS7dXuf6pLkaBxxGFHUzgZ7/d6D+UYsVLKdXHOiWA+uKZaPYuhFAF/le9CKuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFt1PZYVFDkmzoIC9ycodZ7evFlaXSIsqHn/EXs4na0=;
 b=cO1iJgU0fojVg2ctShI35fpFZ5pMUbcsEBB8wynQhs1jA2en3llzS/Ini1btpkavBGp5d+o6IU6F31Bb0Ig35J3s/Mp65M3WI7ky3HH15aRTBL2B2yDYmcJzlpQjqHDsQYST4sHoqEB/JE78nPgr6mBJqotQpVmmbS4F/gXmjvAEQ1MMRnDlW9biwqgrSsk3te+TUiZBZQ+i5m6mrTZNquCmGSoY4I/kIuz0vxJc73O5W/2NPnhvWhg3be6VijinLakkhs9E25/E49d+7fJVuc7BDzKT8OnWS6F6KQIJEu4+KHwRF9x86bq+kf0Iwppls/C1NfVKvmcRbT4klzidQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFt1PZYVFDkmzoIC9ycodZ7evFlaXSIsqHn/EXs4na0=;
 b=Z/adXMZpo34HTtRkadEq6zRA7XuFpM9ho0Mq0UXBuWyYI3oBWANgfYhCGtCRCkS8MnVfyas9AtmieAx7BqoYezPNJmhRrc0TKhgR0e7rdNWfRMVwr7hCpQkefqn9j6LzaBeED7VSi2WtgsAgC2/p5Weoh9cONwpVQrYIxZv6x6Q=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:03:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:03:51 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Topic: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Index: AQHcI7xZmGcYC1TEz02+iRxlOI1lS7SPQETw
Date: Fri, 12 Sep 2025 09:03:51 +0000
Message-ID: <DS0PR12MB7804BB857D2738008AA8E7E69708A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250912080734.3121325-1-kevinyang.wang@amd.com>
In-Reply-To: <20250912080734.3121325-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-12T09:03:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6830:EE_
x-ms-office365-filtering-correlation-id: 78838239-2cf4-47ef-d3df-08ddf1db4b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lnyqUY+/DKknV637uyuXJn49M9H+W9OS7xQArUpPhYinSXcvhu3ObAmZLEl+?=
 =?us-ascii?Q?bLwP1bqg+M6S1pcrY6i/FC56Nd85/j4Uxz2Itj6rcxNNN+Dz3m+v3FDZsTLd?=
 =?us-ascii?Q?U/Mbh4wpgXGdr9PlVTCeJgwxMMQIwAIMy3Zx3VxxSXOsQyzUtSnCR9HlD7oh?=
 =?us-ascii?Q?5t9X98lupPalsJWWoGVQGGm4/EjX8B7/0439wvLqrqNa8TM1gz7UksSVUX1R?=
 =?us-ascii?Q?c82rL76PFhwiwnaM+a7Cn9TjXbmdhyegf717iPD9lo+sqgYNjpr9H+IQfqJ4?=
 =?us-ascii?Q?EE832vl7b60yeDdHe9I2WS8uzTN95DnIemOaqr2Pzz9LG2sY1XLjyyqt2z7/?=
 =?us-ascii?Q?XzhhIPrM2WT2I9+edm76/AQhIynIf619X7N0FUSqC0RGxfsHBUw4+45Coca2?=
 =?us-ascii?Q?SlH/J5e7zwj/1E1ejYqEOOCttXJPZaJwHyO8sYQqZctkxkWoInSbIuNkrN90?=
 =?us-ascii?Q?oq7aXvsIqgoXedl/jV1Ol+iHFSi76PKF+fB01hHXEMf4ZUDw6QtZTeaUvM/k?=
 =?us-ascii?Q?xESgvU33vfoh/Q1/G61Az2CA/O1Ev9/r05ARHcMtG03HerVNtbR+C45rZW+P?=
 =?us-ascii?Q?1iR8ZwrxXoXocyeGGsciV6IHO0F1AbKqZiY+06uB+7QsrL3o+oRsBjHmmyZy?=
 =?us-ascii?Q?+bxx9jn6QBiOlXV/Uo+46o3qrcm50+R2EsyokFJvQruwZA0+yESnOMl8fgkX?=
 =?us-ascii?Q?mlrrXKpF1OHkabZ2zK/aSWXBKB0x+tkGcyfKktbWKHG6Obuy9CQgd3YREGY5?=
 =?us-ascii?Q?068KrAVaDfK4zACl8mNyFZL2WeRLkXNjPnWkoQtBh1U+YqOD3XGL5tn9VZUz?=
 =?us-ascii?Q?1HdzSdDFJnT/AZ8SaWOD9D2sgZj4i8gpPtGL6VdIU6/qR3pmfKQEJWSJETOV?=
 =?us-ascii?Q?4JU2vNacF9BCWYqLRkXZbKgSYaL9U//F7eMDRlN4ItUQyKFpnlOAeVhJskkG?=
 =?us-ascii?Q?NfM67keXT2P4t7lpZCs9Uz0qmludhyB0SZRiVfPzuCKiHWKNWlIfReqymlO7?=
 =?us-ascii?Q?YuR5vrObR+VYsguUX5Jr7+1hRs4X405Bm5rHr5tx2PPCRq73Zjbme+sgG2TX?=
 =?us-ascii?Q?pDPjTOMtPhrbcsRaOP61rc+FW5d5BrjUBsYu9gFjlLG9A+pcXJHAIYecTih/?=
 =?us-ascii?Q?f01gUFIVMjwoEx4og1mjkUzS8Qq6Oru4YPk7sf9LZ9jaMXVefazGYGiSOMB2?=
 =?us-ascii?Q?9BdB2xM1xH3Yqt+WlkxVk0GUApq0XPTppe0FY5KWvWKswyA2lwI77dFRG1FU?=
 =?us-ascii?Q?VansyMNVWpL7W0/rmlGj9eaplFO3MvNV+twSbD/q3JC2R0UJ5yzT11WNmk31?=
 =?us-ascii?Q?et9SRE4TbkpNwq1D3mfMghECf8N0CH+O4nwHjdcVZTJ3Fo8Nb/ZEc2vVZ0/8?=
 =?us-ascii?Q?X1So7F+S5uKFSBJJpGW0ufBM0dFRjiff5bXPx2b2NLP6LZ7O+T0jnco41mLc?=
 =?us-ascii?Q?KfXpu1YHKcL5xYc4YReaqCbzTAnuAtnjH3VpsdUf1pl5rBV/gUMLpPLxBcDQ?=
 =?us-ascii?Q?4q7+s+U6NzbtY7w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GqnvVfSQhtOnNhKQOuKDPQ+KMwxxfs4zvGHXnxD1FC5PAjiMxsVDTnAqolRs?=
 =?us-ascii?Q?hVJ8I5uQfUyLvX2cKgJOdTPxQQKhcqD7wEU8PEvvNmPaXzOY5IxM288GbZQJ?=
 =?us-ascii?Q?YUOBDOPudRLcEpWbfnopfizKqR5GzlVWLQsQsHRU59qu8+MlCnXNeqxYK/NA?=
 =?us-ascii?Q?CwJkjhpTohZJxijW9WeNfvrvsKCcRiNVuDp7qfFd+foiG2ZI6wiQugYhqOmm?=
 =?us-ascii?Q?uL233wz/qrUDsbXliR0qwaP7R1jJ4SKbb45X61JZYqGBxdBfhIvU90Us1g4c?=
 =?us-ascii?Q?n0FL5c2hsDKCEKjD/GjWJcUm+uQVkULbQc3YJY94AW4S5AkPww/uR8uOpRsv?=
 =?us-ascii?Q?f71mK77WvfvsqEntwAL2oCh7nMCrmFY9lt8u0++k+Wj/0DG9E4d7HX4UsJXl?=
 =?us-ascii?Q?9J4tt71h6EblWgjmQrBffrEE2GZ1uspEMmhd8t5Cu8L+NSYY6Y4ilzSmWRwy?=
 =?us-ascii?Q?hhBHBi9iSfFYjdMvcrbDnQ8ehj18SWe7INOYKceE+J0zYT4LCxAK1ya18NPw?=
 =?us-ascii?Q?wkdS8MkbSmkFIaCbywChMzT16HzrpWULQXr9qHaYrZYWRuhilYQh1GM7XqPh?=
 =?us-ascii?Q?2HAeA5ylXh0QoioXhjxe06gl1prWRz007o8x0R2OeuHwjCxrdn8q9F1Yl1WW?=
 =?us-ascii?Q?llM9+TEbubj5rTCtnLnKcy7/4TrvU+gmu7CHUkDq1AVPt7fGpaDXwck4Nao/?=
 =?us-ascii?Q?DhGB9RH1ubiA2yIEQW2u9bpeW3Zd/tfBHRih70c3OQLdG52cPfoECDS/Q3a/?=
 =?us-ascii?Q?+cLVXA63eGHu0E3LUL5Rx0ssm6u6nrC+YLHtqMB7iaKN4KI0zvdngLq8xg38?=
 =?us-ascii?Q?mog/qQvKt0xD3CMHVSV0+Y4B+7xXH60bT4uG5BKHqb7V3yMyf+oUgCBaVHD4?=
 =?us-ascii?Q?IWxFmI71ywVztbogeRXW6HM/ajHIHaDw0B6vs9zmxwp0ueu0Ha/q5DMgmKMz?=
 =?us-ascii?Q?rIYDh0q+wG8xIhB1w++kH2UYLnZvmt1mi74k1PBGyD0FSp7oyTt8T4HBTmXx?=
 =?us-ascii?Q?9EBLmdSqLQYO1GKyWg/k9Io7WC+t2438vtaH49l8044CKQW4E5YJMZCVES0D?=
 =?us-ascii?Q?QWctQdHIrc5QyE0Ww/RRICACRvJKFSIuaZh1wKSXvXqFR1WSU/2WuLmVwzeU?=
 =?us-ascii?Q?72NXrM41IvNkDQ77rmAPJI85GJnZ4Hitdv1VWfQp3PdJgkZXgvQPA0MAENmn?=
 =?us-ascii?Q?PF5k20vVBKNxGsj9Uy/zNE1wlxqDADhjW6N7bPADfBIt66BcRP7RM3YhrYiL?=
 =?us-ascii?Q?qvJ6srNUK2roHD/NdHDkg/ySUYbuUo09tYUywhk3LIl0WZxC95OK9H8D5JDi?=
 =?us-ascii?Q?qS+ZNiS/KeTwoQ4484aVasiRyKLGK3c5To5Eu+A4SCJ97WQicxe+eHh6SQTP?=
 =?us-ascii?Q?5aqTU/1RItEcOXNCyWFwmI8yhr97MGntf4sgvufgv0yhbE2SjzTnv9UTKQMV?=
 =?us-ascii?Q?QTO3UxNAlzm9icxDVXg7G+3foQweUlG7+7437xYdzLCQSQKbs6kux0jkLDhn?=
 =?us-ascii?Q?giRpilHrFWbaBsLy99cimYsMyuq7dpoKf1CcsAwmRuNo1oJjHh3N4PJtigvH?=
 =?us-ascii?Q?TdEKulvSAlmIPhwTC7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78838239-2cf4-47ef-d3df-08ddf1db4b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:03:51.1707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXq9QGm8mRVbSDQavRUGUHUX5Pr9sTDDHspYWB36xFwN6SHUECCIKTfi1QOkTlav
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

[Public]

There needs to be a specific callback to do SOC specific things during late=
_init stage. Presently post_init is providing that, I don't think that shou=
ld be moved.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, September 12, 2025 1:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init() s=
tage

it is more reasonable to move smu post_init() from late_init() to hw_init()=
 stage, beacuse the smu specific hw init should be done before call other i=
p block late_init funcs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b140f6fc50f6..f113b1b1b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -891,12 +891,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_bl=
ock)
        if (!smu->pm_enabled)
                return 0;

-       ret =3D smu_post_init(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to post smu init!\n");
-               return ret;
-       }
-
        /*
         * Explicitly notify PMFW the power mode the system in. Since
         * the PMFW may boot the ASIC with a different mode.
@@ -1957,6 +1951,12 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
                return ret;
        }

+       ret =3D smu_post_init(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to post smu init!\n");
+               return ret;
+       }
+
        adev->pm.dpm_enabled =3D true;

        dev_info(adev->dev, "SMU is initialized successfully!\n");
--
2.34.1


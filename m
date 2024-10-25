Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D08D0C603
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 12:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5505910EA91;
	Fri, 25 Oct 2024 12:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzuof8Zx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F416910EA91
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 12:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apfsl8NYB5iF/sUA46YtgNlr5fkOacX6TE5glopBGNa9RvOn0Bc9Cevv5xD4Jbg3Hpgv1llEki01R895Sp189m8xFw3/L5RfeXwwvnxOSttx2pvdi6i1As6vkBLmWCKdrEuTo9w12+xZGJymeRuwQnlZOy3BpsOnRDYLodq8YAAEz8/g40Rp1Gqb95SKxvMe1+tAhjU7RKZ8uCQGHNils4+GRia+Ps7laD9Yo7OVcmEFJx/n/k77nNN9vfX67BVnK4SZpUTBIAX4wlaL7XyuJCFW6nluGlyIfYqoaYXrlofD57fbM+EQ0lP3hrb8BJkV8o9pMs/UkHZr6pBIUnvy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxCFtAjiP4OE4Q4xtVqB/IQutpjhQC9SC9ivDnnCcRE=;
 b=sO13xY57bx1p/lVB/DS150LDdmSJLrTL6q2zD70TIkgwQJDPFNZVp9/Wntl8y5a++d5RowZiBj7ojfkbv74vdN3CZWlqiYJ2RvOj4S919OlCSVbSvxswT9nqFe1IRqtCeLs8E0fd8zoPZZzfinax4mIPG4PyD+eSVMIYbEVlMDxP9b9rblMQVbGW1JEfPO3obYNIaq/OOhidN9rJzZnhuKrV47NJ4FtKZIrdgaRtmGcTlNJGTpWCpTOFADw5hCv/P26RFm+/La9BVs3ndT9KOCRWXActkgsHEuCWr0H88u03l4fUEkSkgXMTTOnpbN/JpSSCbp3nOWuWj5eaP3nNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxCFtAjiP4OE4Q4xtVqB/IQutpjhQC9SC9ivDnnCcRE=;
 b=jzuof8ZxQgKxUzgq4Bn2N2p+sw56C+D7d1SdGARIBhnbTSFMFHIoMwT4M0fkqtpPiqid8V5DTl6VdsZczG4PbLojNLciBikH+if0K7tvclOuLdHX1kmIqRJ6Z/Wd+Mu4IX6J2VFyjT/vCLPZyJ8HHCV1zY1yEZLIVAivGjcgHLs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 12:33:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:33:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Topic: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Index: AQHbJq4/9bp1LgoK80GKW1wS5+6ay7KXZsxQ
Date: Fri, 25 Oct 2024 12:33:46 +0000
Message-ID: <BN9PR12MB5257F8B8506C1A743F3B7722FC4F2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241025071922.95979-1-kevinyang.wang@amd.com>
In-Reply-To: <20241025071922.95979-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=72d4d709-23c5-4481-b741-3b94d1e7e0c2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-25T12:33:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7259:EE_
x-ms-office365-filtering-correlation-id: 0973a7fb-9d5f-41fa-4941-08dcf4f14565
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hp4H2f3bwGWfPdC8agCJczjQh4M6QJ81zMKWdQkYmdqwG0VIC8S+HjBAcmE5?=
 =?us-ascii?Q?BT5ID1bvSeyRuJlP/LR28+SQoq4wl3t+j7shnqU3U85S6j3CNajJNWLkEsxM?=
 =?us-ascii?Q?G3K5HWY3pkINJD39x7vj7zUBG1kytcYLg2rx7fqAtScFCwAMGrFKnRlA+pzX?=
 =?us-ascii?Q?8Pl5sac4pgrFjbjlq2MgJf5HRa3vQc4mOwSPC133qxKL2NoV3NfgM8N1Yt8r?=
 =?us-ascii?Q?Mgc5i99ExhRimrFzbFtdfylvWiDWrKPhajmGJKKL1HoyZVepGToVjp2clfHt?=
 =?us-ascii?Q?Ipjs766rPuVzmBZlWytu7A/f4cvBysvZKga3m4Zg1qC+eUUes3WvLVsga53+?=
 =?us-ascii?Q?tYKFLV2gru1m0lCuBJZcdZCpN3BPKhW+NNMNUCwpawaL1vBIWOJe3X5w1Zm4?=
 =?us-ascii?Q?SKNtrhHs8eaGHGzElvbp1Wy032myxAILVuHrBTMTc5lI4MTJ6GNY1depmjAq?=
 =?us-ascii?Q?VT4mILeGQLJikY/uLz0gghP3AngzcwAvMUslOndszK7vjlyEpKyJqYvwQjNa?=
 =?us-ascii?Q?+a/23lgFG0y8SDKFctMkEGcd0bfY2ueSjzWX3bu/rS9ptxQT8pV3oYhg3/7M?=
 =?us-ascii?Q?SS3t/Ez+zb+6FNKCwceNonpN1d6+kYoJhTbIK+90pE8L4aCKamz0Km3rCTLZ?=
 =?us-ascii?Q?1lUa3t2fjxExjUfY2vidB36U3lrf3FW1ArUm6Favc2YPoYWt8lPsstkCvj69?=
 =?us-ascii?Q?y1np54Qu8wTCaoBYCGfuy4HVrEi8c2DpumwG9wBnYY6oe4rxtEJXu0zhGFUl?=
 =?us-ascii?Q?WzBDwrQpd0xuM0mjWwenfJTHEQ3YHKcTwQhKbMtrEm6Oic7v3vNZMsWXTGvf?=
 =?us-ascii?Q?2+Wl46wOzN3BJ060a7WOV7X5kErr/yQjfeRZEQIvlGy+csAssJZD5zhbyoTX?=
 =?us-ascii?Q?j+VQ1YGznM21QT1qGcwB6XW5dN7B7gdWaa9V19XP9z3O2npmP23dlx/iSMiO?=
 =?us-ascii?Q?nAq7+tW7RGufB16DQn0suf2djuh1R9Qf4i5jwZBRARYSOWj9w8FD6Xj0S3Q4?=
 =?us-ascii?Q?OSFcEsmivLH2UOgp4j6BzrUGr0k8/9ASfHzYZoRGS4Q3DRLisKlA6aAGflhZ?=
 =?us-ascii?Q?JxqLXZXfaRk/0sKL1DZYPM22dVsiaIFy9hhpebktzfhni8pSvM8DpumTdQiy?=
 =?us-ascii?Q?t6ByjWtByo4jz1Rcn0bKM+Ga/EYGP5bWFOGEqvBEBLxfOVDhw9M4adlWUuzy?=
 =?us-ascii?Q?PnB8kqD400mgYkjPUoQqxkwUXakLECwBMtU1+8DA2tcvDZzDJ+7leW8WkI06?=
 =?us-ascii?Q?iciwWwez5NjlOJIc5KFEOBHM3xCE6MX5IdDM3nqNE7evziufIgknmet764Aj?=
 =?us-ascii?Q?WYb481bRoitp7aN7zYO21X4k5ge3t1ZHzkA2I+6eabI5lPgJqgOji4QsUeLe?=
 =?us-ascii?Q?1WYfIsU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XZsEyIItcUSkWidpSdZ4BTwg4x5er/G3YPGQTkMw+S33ZPEbOF/2xcju8x1w?=
 =?us-ascii?Q?J6/98Jrww4lSb3xEkciy3OimTMCpCRnFqtFAicugPn7hzBDCSj4edAAk0Va+?=
 =?us-ascii?Q?b7J/yaqXOfF+vg2rFSxri/YZNGRyoJ7E/XS1H5DPTKBw7qPQIrW3miKsiEiV?=
 =?us-ascii?Q?Skq45NTZoqtrfJ0ZYU3uzQnPMJzhUbVxjB5gmCIjvJjRdBYZ4Zyi+iYlAQhp?=
 =?us-ascii?Q?YWDas/5hL2g3b/qUTv8Ro+Zt1snw7L8NWwqj5Iux7fjXpNxj5ZBWoFP81olE?=
 =?us-ascii?Q?2ee1GEU9o6okSgZ+KTycavrNas9z4icDVY5A35DGVulzF2T1C9YVxaQEg0yA?=
 =?us-ascii?Q?otIyNvQXJZmiYCfc/T8bTuYU6X5DgeIi7NkuiqRqlOLFj8wjCPCZq1bFQZO/?=
 =?us-ascii?Q?ggMVVBWHpQnNfm9NfwIYM2gFCrtOJLskQz5fFCxcvyta9sQvG/lEn8mHjhTX?=
 =?us-ascii?Q?PUB0ljBI5j4dCvi9Iz2jYe9GAL5Q7HAW0NwoD8lBepd8+V16hko4/Dm0/n+0?=
 =?us-ascii?Q?ARjdFlA2WkFAZqCC/Hps0ApjHVVKZwhBvzQhdwnD2KsttrLtFG0Kk5NiMhWV?=
 =?us-ascii?Q?/9qgtOuzswGD/SEEZy9jW01z0C1oVYQRRIknEuU/+TluuTEfccGyj6MZk9iZ?=
 =?us-ascii?Q?W6rLZ7LxS5HLcmJEq13DJlpNTTVWmvjmI3KYDjkPPYs97XO2SLPmoYGMZXnX?=
 =?us-ascii?Q?DkFgHb6qlY5PNBj24mh8Qrd5Hvfqk/H9vukpCaNt+eRdPQU+iHbYBpMyCEIT?=
 =?us-ascii?Q?t7EKEM291jLwQDH6IK8CfbEkQAUab5rKYty1i0Cb6F6P3UGCvxh+rwU8PeFR?=
 =?us-ascii?Q?GwYpJWpSATCgoQDQ9XtT+QlFax580BZ0rCnPFkfrtGytSCo7NjH+I9+9SklJ?=
 =?us-ascii?Q?0FBylWtBUu9nAb8nKSCL9JllaeVzZTatruNvBRAAx3x22JVf3aywOYgF3zYL?=
 =?us-ascii?Q?Hne3QgT3kx5gCqudXh/Qn+7nUm4UvBqM+zDJOcxGwbvJb1yNRGPgNrTFa+t8?=
 =?us-ascii?Q?GjpGlvSiZUeXqAmOxPGJcFnN7MhsVuIf5Y7l2VOFu1x4ys13v1FN0ZZxY7oA?=
 =?us-ascii?Q?KUyy0cE3hcF6bB1SBSROtuNENgK4upckaQrLWE+9Yj7JNKD99kCgr+Qrt6Ym?=
 =?us-ascii?Q?R5w8SIZI1wZ1HRw5iwQTupNfg0c91hTDVihdCSvjFP/7QDSp3H7aDi4yso99?=
 =?us-ascii?Q?mVzApinyvtmBZPnJnDxE+MYh5QnJufg+GkSNH3cMvfB90y09DhQhDaImsICJ?=
 =?us-ascii?Q?HRljWc+g4Khz/ZonXNGEoPUwl5/dYzcwBURKU9EPvKj1svbm4ggbvuLNjaO7?=
 =?us-ascii?Q?ywtu8j6bhUywWDt+bi6ny36gdTCdflPBT4H/IfO7JNcVDQWdqUwBfxwbzLLE?=
 =?us-ascii?Q?b9H5h9/SUyljaIahU5qGezoHu11RsiswIdG8vclX3fZWu/vBqBQVRPMvZnFV?=
 =?us-ascii?Q?fVVth7AM+9AZ+BUUx4zUsO1rcjcW8nmqnimkBKjtrlir6cDzmZEgM2C+UGNw?=
 =?us-ascii?Q?5jSMRKzIc/JHeZHFZtGmbk2nqkbpgobrfWf+cYjDvaVPulb32+puiU02RGD+?=
 =?us-ascii?Q?jhzvqxS8GnJjLryvEA3bbRhQ39AwMI3B3qP1wWjh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0973a7fb-9d5f-41fa-4941-08dcf4f14565
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 12:33:46.8114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXTEfMZVtbeJflxUnhu5L1XEBszLj2G1npwJtcGAvG8Ijso5/Qy89G6ztVOvJAuuA5cd/bRFwniVPMP2FzN2hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, October 25, 2024 15:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize ACA log print

- skip to print CE ACA log.
- optimize ACA log print for MCA.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 18ee60378727..3ca03b5e0f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -348,6 +348,24 @@ static bool amdgpu_mca_bank_should_update(struct amdgp=
u_device *adev, enum amdgp
        return ret;
 }

+static bool amdgpu_mca_bank_should_dump(struct amdgpu_device *adev, enum a=
mdgpu_mca_error_type type,
+                                       struct mca_bank_entry *entry)
+{
+       bool ret;
+
+       switch (type) {
+       case AMDGPU_MCA_ERROR_TYPE_CE:
+               ret =3D amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_=
REG_IDX_STATUS]);
+               break;
+       case AMDGPU_MCA_ERROR_TYPE_UE:
+       default:
+               ret =3D true;
+               break;
+       }
+
+       return ret;
+}
+
 static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amd=
gpu_mca_error_type type, struct mca_bank_set *mca_set,
                                      struct ras_query_context *qctx)  { @@=
 -373,7 +391,8 @@ static int amdgpu_mca_smu_get_mca_set(struct amdgpu_devic=
e *adev, enum amdgpu_mc

                amdgpu_mca_bank_set_add_entry(mca_set, &entry);

-               amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
+               if (amdgpu_mca_bank_should_dump(adev, type, &entry))
+                       amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx)=
;
        }

        return 0;
--
2.34.1


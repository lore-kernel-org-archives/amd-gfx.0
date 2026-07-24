Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE7C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 01:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9EA10E434;
	Fri, 24 Jul 2026 01:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JY2YyqP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D38810E434
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 01:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1cpc1IsHbDdTRvdPBsYQsz+Xg1lf/OPKcNQbbunOgvG+Hw6hj2UNc4lY8++JEl/t76aBoKBTN6wkb6QYaLSujwae94tSNfWtftSKxud5pkI/TWGYgCs3MCx2Ctux23VGzFsfh6fj4uEWj9jwnmi+RWUkaIXL35xZth4BDQnBAhuSPD6rhCRaygqJWTiGPj1RuPQbZEv8ly7QOOx/faeKw9NopMPWVZyGacwFlogihFR48pSYgzKl0giAv9NWRxlgcdEtceGVDr5fUfqWZbP2vsfyhJMYzhuJoJOKC0EXTq6q46cIpafam/1zToOjIP9+tKOKhP27eXvGeO9hGNsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmmRM2R1u+Zu5sJ9rlZ09g0FWfnWDmhiR73a10pAmjA=;
 b=kfVp0BGD/jr/nZs3PwaX/lRu0dDBmArgNs5KFL8Ltz0CeHjJn+eS0qntRGbugq7eopCdD8SlzvY9DAtIIM+EzbAGRsavjf0rNneXfCzujvibzjJ0jf5It6qAadIoZYCtrxK0sJKOPX4wadGPt6uWU1C+ht6gQyURCo7oy1XWZ6NzPa4wwEcdU7FfFZetzqXAmOChH9VN9s3Gng3Y0dhRxb7oOBpuvXiYhlNc9gZxmk2RyyFIQfTyFacC/RnXjePGM4psLsDqFS6A7i3OT6tjyHlZuBYrJKFI7eBKI62GnB1VJi7OWLhKIBFPzHuJ+qEhpd//963w81k4vUezKBw4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmmRM2R1u+Zu5sJ9rlZ09g0FWfnWDmhiR73a10pAmjA=;
 b=3JY2YyqPPExfl0PFQslxdP+0E4dC137UVDUFgHcaH0WMyPPbHau4/9Xi4FOttAIcqD0U+t8LyOInRIQoK52om+4z2L3I8Gsah3Pa/5fg+mACI6Z9WwnkA6IiQFKMrh7+OrGl5hk/aNKt4s44H3LxNpWTbGedL/i1eTwvloaoh8E=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 01:59:52 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:59:52 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Sun,
 Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: normalize error return of RAS command
 wrapper functions
Thread-Topic: [PATCH 2/2] drm/amdgpu: normalize error return of RAS command
 wrapper functions
Thread-Index: AQHdGwLkuhDU9jv2iUOf79apA2RwDrZ76XXw
Date: Fri, 24 Jul 2026 01:59:52 +0000
Message-ID: <BN9PR12MB5306988B9D11F3E9546D81ABFCCF2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260724002440.1091132-1-cesun102@amd.com>
In-Reply-To: <20260724002440.1091132-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T01:57:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: 2341ff4c-7f0a-4935-00c4-08dee9274009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|18002099003|56012099006|22082099003|6133799003|10067099003|38070700021;
x-microsoft-antispam-message-info: fLvrVjzkW4TS9dxe6yXNuCrPIunO9WstEt0JjM9vEk0SOUGwJzWOqo+EOS5vfyJwl1YdtUkoDHgcg8mRi3XqIyp2hLtAodX/l46tJvY6Rni/lgETVx4cUyNPMcbthNLhRhHXcwom/IRVo0EkJxztf33CeT8xnkLWMIHYCmwXH8md+Y2WJ2AgO2azgL/wzjVd7HZdNPYAeoDeQ1bl7/uF90hc6txmePKofKKTr19/ExORvdMR8oHAJi+iV7LupexVVPHGQ/1b1RgcjY2iPqSnsDXJB8zVuaHhl9qCywsp7olvDLHTmH5H9Gv9ie4o/WXTfFbiI3K+qzu0E/Zvw1bizJU7+mH0XpSzOBdglITlJAqpiEd5ZA7Gu2oMq5EEGxfovzSwt+HSgXoE0NreJw+ocEF6bbFLAzY+FjMvWL09k6NTBD4ZI/L2g0CML+GcjVUh72/ILzUQLNoD/1KSywMFwyU7hYnojyXZPcao6YzdSlW4fzNjquV8NLF9gfmSm49Gn74heXXBACdDygrya4ANMsrxePRlorBtvEPCqsgfSaDo0tOJBiYbIWgQqKs5zkyGgiumS74ThaQkl1TI/WI9nQl4ZkhDXx/S8+nHPkGKS5E4yCR8rZ5KeVJzuW5Ck2+i192JvwSnO63ZKa7Tuuh1hmHBDoU5bHq0vVWDbwc31x1e8/1ncjipRFHihaD+f8A4c+jF+FuKKW086YfDHQQDgq9qRXxq0Lt9RkjZZH0TJh8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(18002099003)(56012099006)(22082099003)(6133799003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kn7H1AnxV3JqQjIO92Pe2i4KSVRR2GJPxB2ePMJ5YvDY5ZHo9LRZG7mTn+/C?=
 =?us-ascii?Q?mbdnBGlVhy3fFH4hXVEMQQpr1A/I6KPHGc9AODhSBceNtGG00eoO/HhkqX5d?=
 =?us-ascii?Q?HAotnSCukxISMSlpcxQK2GWpDDXpbFqwy9+McWx628xTS91CbiY+UjHvXmGs?=
 =?us-ascii?Q?RMc4e6YVLOWPcEm82L4Zj2z7eYNJg3HOHGPvMTk9jCQu0Dw4kdi82ucXYLMR?=
 =?us-ascii?Q?FXey3+0CJEqOIoxSLJB6PpfHuo+424Dn0H2MUeK2tyjlCfipLhEGMubdteBV?=
 =?us-ascii?Q?wG1GKjcigfJGm/PxA9VI+d/VPSMX9vxFUMhMk7dpFH+PYBSXh8ee8vzhgzkv?=
 =?us-ascii?Q?Orah8Wm5SSqbd6CNqG5bNGvwdtbTfCW5Fhf8oE9DQJkCBmciG6l7VOXBZBT3?=
 =?us-ascii?Q?qW/A0kizhDj7TRcgvhgnDijxpkdJtheLP52G0Hpe+j0dlUulCS4448d3htVc?=
 =?us-ascii?Q?FUQ2vquHCSX4TimmIEPCF6BQnMFHhFYYenVyiCS5eaUr/amZlcuHF02F9Pmu?=
 =?us-ascii?Q?Qb7ySbvJYln7DGH0IxYUug9Bo3jn/CKNGjH4gbLRNLH47Wns0Z4oMNR5Ep9B?=
 =?us-ascii?Q?Wgoqpdtz2pyIWCSzwWWJjeDKdxIHGICLl1Kjsfald69+CXppuQotaGvxJ5kX?=
 =?us-ascii?Q?QBazdrvE40lTUiYorNs3qxgzwR24iDRRGyf8kMVNDXKKv+g4KEUFJMFhRLIi?=
 =?us-ascii?Q?Ty99o8ElxpIl+BbdvFDThFdrihc8NE2WUUs/ZPrzQ3TYa+wzu1UmNBPrhZaJ?=
 =?us-ascii?Q?IzRGmsfkyAnwRZLroqH0rApTx2NZgEi22FEpmZEd/b41YvL5E4JTbgV83plZ?=
 =?us-ascii?Q?8bLpfcg98Q6JH8YGqaUZBIGKdoYJTe3mlCWg36r0MoWuaiwuqe4BVgRZkTCw?=
 =?us-ascii?Q?ejqLtJuVReUT4h/q1Z06ln9ygMl1t6niI0znPl2UgT6PTnkYoi6LeBLnDLYT?=
 =?us-ascii?Q?XtlwSZCq4w6M9uZw9we2GFz3zerY9wBh9GKMfcq3mvBdOXsrRi/LGx5wh9bT?=
 =?us-ascii?Q?RDb+oXqTIisnLbiwBa02Lhvf2GcaO/GRb38Zhsjv/wtcDqYWM4zkJNPHPC0r?=
 =?us-ascii?Q?jxnJ6EIumjkVfXu+XBQNR0b1mxcDHLEJWc2m2KOJ7tAgnPBeSUBUgMPUy4Mi?=
 =?us-ascii?Q?y6yQWjAXW8WVk0nQoTLvCAcN+3eW3mq57AoNThsBjc5VSblliEROPAkmtuzc?=
 =?us-ascii?Q?a3kQPduD69mR17lJF3rQCDQ/Belqq5uccLp6pQaINnbzCL3yoiBqDUJVtUWk?=
 =?us-ascii?Q?ZSl6wJ05vZ6HG7cH4XetxuC7dnTaxp4VSVYrwLODs6FHveF/JYOorQk74pPD?=
 =?us-ascii?Q?ctOSiQnw5HkQq5UGzPpFwtSlPHsmJ+5aw1JPJGw67swj2V64YCZHah/ZZfQA?=
 =?us-ascii?Q?sPqv6illPVOhKZ34kJx/CkgfTSwpr/v80ntSJ1grcXTcsfpLQNSV1lpavzvD?=
 =?us-ascii?Q?++MRSzJljICYegzafn19FilrGmL3zg0i0O9JbsiqOY43wvsYFUOFS78hI2jV?=
 =?us-ascii?Q?Qw+0iexx2oeZVwnm8KinWv815vU8TwHyWtdiTRiR/M+Utl3XmjZA1ToIWRpJ?=
 =?us-ascii?Q?Qibtwl5GUSPYS47wyj/+mXBYuFDLUDiEoaEuHmMqdLnByChAxYortIpDCm0H?=
 =?us-ascii?Q?Rcr7elpNUrFyjgNZ71rystUk7T43TkAJ2vn/kALepApGppwy5+JqiPn2wGzU?=
 =?us-ascii?Q?Pi0PFkKZnClcANwPH0zTlBtU9bVgD6bEEXS/l1GCbTBgWFuU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2341ff4c-7f0a-4935-00c4-08dee9274009
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 01:59:52.0486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPAsL+ZGpn4iBAgAEkTBdj6YzSG0SG6x4Cm+HmgzSaQZvx7vkSJ0GQBHcv7dvlodBbsrB7MM6udeT7g9WGrm1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

Best Regards,
Thomas
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Friday, July 24, 2026 8:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: normalize error return of RAS command wrap=
per functions

normalize error return of RAS command wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 8 ++++++--  drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 24fd24e8d874..600f9239306d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1436,7 +1436,7 @@ static int amdgpu_uniras_clear_badpages_info(struct a=
mdgpu_device *adev)
                                &req, sizeof(req), NULL, 0);
        if (ret) {
                dev_err(adev->dev, "Failed to clear bad pages info, ret: %d=
\n", ret);
-               return ret;
+               return -EINVAL;
        }

        return 0;
@@ -1457,6 +1457,10 @@ static int amdgpu_uniras_query_block_ecc(struct amdg=
pu_device *adev,

        ret =3D amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BLOCK_ECC_=
STATUS,
                                &req, sizeof(req), &rsp, sizeof(rsp));
+
+       if (ret)
+               return -EINVAL;
+

        if (!ret) {

[Thomas]  This condition check should be no necessary.

                info->ce_count =3D rsp.ce_count;
                info->ue_count =3D rsp.ue_count;
@@ -1536,7 +1540,7 @@ static int amdgpu_uniras_error_inject(struct amdgpu_d=
evice *adev,
        inject_req.method =3D info->value;

        return amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__INJECT_ERROR,
-                       &inject_req, sizeof(inject_req), &rsp, sizeof(rsp))=
;
+              &inject_req, sizeof(inject_req), &rsp, sizeof(rsp)) ? -EINVA=
L :
+0;
 }

 /* wrapper of psp_ras_trigger_error */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 0d34f0eca991..686c92e96025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -526,7 +526,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file=
 *f, char __user *buf,
                                          snapshot_req, sizeof(struct ras_c=
md_cper_snapshot_req),
                                          snapshot_rsp, sizeof(struct ras_c=
md_cper_snapshot_rsp));
        if (r)
-               return r;
+               return -EINVAL;

        if (!snapshot_rsp->total_cper_num) {
                if (!read_header)
@@ -568,7 +568,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file=
 *f, char __user *buf,
                                                  record_rsp,
                                                  sizeof(struct ras_cmd_cpe=
r_record_rsp));
                if (r)
-                       return r;
+                       return -EINVAL;

                if (!record_rsp->real_data_size || !record_rsp->real_cper_n=
um)
                        break;
--
2.34.1


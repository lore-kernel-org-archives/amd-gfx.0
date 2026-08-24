Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D33C5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 11:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5654810E71E;
	Mon, 24 Aug 2026 11:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtYlPB/v";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1E110E52C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 11:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5trHX0faqlehDpKko4NBUXrXSNLxY/PuL/alBaf36j0XFuXcrAKdtyZNOo7mlxC5FsEjgvUsBX/mjr/ehq3S0Bvpo5aBZLXOkO1l3UrZyPH7wiUTIPks3fr16+hZisnxq8bH8B6QFmNOEg7fUE5cqBETLGvgqVZl+XyVzPIWpPpUn3wdt7bP7+T4htIIjrVS1PEGBE7d+b6kSLOtnEFpUkCRJ8iGLCwHdgcjH+yv5NhV1/ml5rMnqi60EVparMZvc0pGt20GCedxjwUKvj0qxqOTYaFKiULclq3zHY3ohBLzeeVRnLeCv7Yr+0erN4BBq5khNohZFLmlsKWmiZgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMGeW4d3u2+qzkGz2Z0ha8v925hUXKfT2eDZkAtmiGY=;
 b=dfmxZU+63Qdh6BOC/RulE3KJsVS8/mCSjZiG9YXfwfTx/2Gm0UOAck0ictSpggW3lweacnv3yVAOmffxyn9p3etxbuzGaHqk375p3DcNIiqrKFR3PamI8kshfUGuHVFbgsHqIXmeyXB52tEyJ8tRfSw05ZRNnm/m6qe5pSzkGt7zWt1C62Az/FwHh9WCpXvzyX5MGbs+YLlqAM7KxAN44jAPR0ickv8nU34MNEbX7GJVmvOyMa4q/09qhrSxrX1dE1Ng4NAMwWbuZr7hj5JpGYZhtaAbgHFiQLr48Dv9OIyVxeKEQ9zvbDELsHtjaM7a9lyjflhEfFO5DEFZzmLh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMGeW4d3u2+qzkGz2Z0ha8v925hUXKfT2eDZkAtmiGY=;
 b=mtYlPB/vQXdnmo7tqWG121ecI/MW/cOqVtF//CI/jnDoDbSK5JR/vnda87FL0amQZof6Yeosetgkf2QJ9WoPpVAKvX1FOrpAHDhIiS2DmjqAkT8lMjk0jF//fn2QM/O/kpeJ7Wqc9jmI90hoF+bfLZ2L2vqTBqjiFwsbkCMCjwY=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:01:58 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0339.010; Mon, 24 Aug 2026
 11:01:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: tell KFD the reset came from an ECC error
Thread-Topic: [PATCH 1/2] drm/amd/ras: tell KFD the reset came from an ECC
 error
Thread-Index: AQHdM7JpBboEzRwWlUCGX/JDl8yjkLatCBBA
Date: Mon, 24 Aug 2026 11:01:58 +0000
Message-ID: <BYAPR12MB3192250D0AB49003A15097DCFCA02@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260824102111.264161-1-xiang.liu@amd.com>
In-Reply-To: <20260824102111.264161-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T11:00:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|CH2PR12MB4230:EE_
x-ms-office365-filtering-correlation-id: 9261f932-a6bf-45b5-e880-08df01cf1df9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|5023799004|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 6euhe87M4SlPaZgbonN0j/p/JhqUuX/Sryck8WxjM+Cfj7bdMhgG361YV0X1rgSynp52v1y+CNdBZwSkfleHJyiVjHRIuFe2MpHzFkKKIG1NLmGRTWKwef9Xc/+zjaRESgV5gtFFQeb4yPgCgYfdwfYfOOapbMWvH11CsZTwKcgqq0nMg1WESjYctQ+455Hh//UA1fBywGFtTNfdyZ4SFgtUl/XvfB/h//wOV9z6Qe98p+Eh4znvOlys6WzxQqURvAfI7BrY/wSZUx4GyzSxo0dqM6D3dBIU7lVkZnPumhyl0ap36xpNuRNr4mipybqdN55vAmEDXO4ogz9qDzWpxR6oiPpwZNNiWnTQLu7Bsaubd5XgaNHyu1eONrGIzUGkOsus5rxLDTHxS5jS2AcFoXiY7fTXYdWiPeIMxbOjsdHEa+W+753TiOGNUYlvwu2CD9bT6S54Vtouz6xczpN5r+E77vos30uVbtbNqkAgpLwS/qZrAKnol2qRnIqKipolWD1MbWXsp32serGJx4SquWphP8FKQReLhBB2db0EihYxcxDLpRC1utUwwGGTgb4r7H+FXsHpgdU6QzLbS/J0La/UyXO2nIFuKSJ9m1frjuUqpvDPtqQgyB10k6evvrvecJQsI9lsVfaMj/cs7J6vH5bJrO2RfUxC8W2d0ivdhp5Ooo+zBtegypg3vKBVwQC4C7DDex+TqLzOR3hBKm9nUMGTYkeCQljXQOcKgbNXkbg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(5023799004)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/sHlGQHIprHfYRkHFVltSF6p58WI2V9dwukco90nqv/YHPOOPljNH8LioOzc?=
 =?us-ascii?Q?xszZlcIAm0YptsG4Ep1m0AfkEPBqCSiyjl40gfhX2Op4Dsfa5P4eOc9gvPVu?=
 =?us-ascii?Q?cdZ5lbwwYyGzEwhUqHb4ZeTV+V4YVIBKVDzyH1vcs7jtpsh74znlNn8JwjHR?=
 =?us-ascii?Q?1rQwlmcFj/o5f33t9hH2JuBz/u5k7SZFmQuI8psXKeSxv68hNw0QMBDyuJoB?=
 =?us-ascii?Q?rK56qnZ6/H0CGiLgEXP2pLSfZdLKSAqEYxIfXLNKBXdlt2mGXPq/fFa4BaSI?=
 =?us-ascii?Q?nL46LLwhKXczsFTsS+9lITq8BGMhIInYx5zwVnsjPE+LHrydmx4dJnPj8BcT?=
 =?us-ascii?Q?gUC4bZjsGeXH3UnJl+u1bat3OoUXTdRVD6rMR2cYr2RS3G0V2VdfMt0V9NIy?=
 =?us-ascii?Q?GTMJOYA7u4BLUTpGWuyHA3h0DFOzphIXRfjKJiMmqFCyOpRNMkSVzpT0yGnP?=
 =?us-ascii?Q?PpfXhOlmXVOKqkNSGCHzaeo8PQK5vCMjAL8ZGLTAj3lASKAiklWPYSEi78AN?=
 =?us-ascii?Q?p2KGF8fpmxHRzBsb3O6zXtZlSpZu0eNwqv3HNRThuRjbydArBaOhxngmiKtD?=
 =?us-ascii?Q?IZnoznevc/d1NteumVqUC1uk/qYcrr1T+brUe9P9gALh0zguSTDtIizw7XFT?=
 =?us-ascii?Q?7xzPFY4xGkkjXvUrPIyc8HhPN5E+Y0kRQiAf4ZkOGAsfpQx2Q5NEhtcvZY8P?=
 =?us-ascii?Q?kTlbCG10ng7mWh2C3Sti1Uy1vPJ5+fK4lKZ8uDY57jAPchPDTGQumxXP6L3a?=
 =?us-ascii?Q?c9tXnacdWTaZnWd6Ad4ZGo1oGq0E1oJ3GD2pg0X4rbUlUXqe3NoxaEFMlz1q?=
 =?us-ascii?Q?9P5+tv3TcxZ5abCg84l017MZYriCCDCzeqZ1yLpxITgAW+tVFqrBHGjWEdTi?=
 =?us-ascii?Q?rMxG5fyOhT52AIcm7+BTTRn7pUEMOuYpdEv0T5DJ39ATR+FGTdkgYs/Q+TaE?=
 =?us-ascii?Q?fc5cDLxeHyWnZ7HBsdTBfUuaA+N1Z1BOWJA3JlSRMRoLveb3lgy+xKqn2f6E?=
 =?us-ascii?Q?ZmYBS43tjbQcTeyyBc9lxvkiVbZJfKsKNF29AeM3lZVLYpwbicbmec5PMEox?=
 =?us-ascii?Q?zqH+KK2lukvMib9roR16fl+PlEwk2dd2/7C770XI4hkHR+QsUfjhCjIEEjXZ?=
 =?us-ascii?Q?nLE0U3iH/Gw4m0qDllKCxuLXmx+Hs6ZLCGcJSMGMkZLszmR8oQG0g6bIJ/4G?=
 =?us-ascii?Q?WOxli7CFZ6OzhCOhk7lzexxcK1O+DJtO4mu5kfUIGMZdfHvyTa85q3JBny+0?=
 =?us-ascii?Q?cMAvuXr4ndteXTPLDDkPasy1EMnucqaFvICPswS68/wP8FZS6CIN4QfwfwVW?=
 =?us-ascii?Q?6x3AtvXA0LShrVUPBnOuptBdmTmkYARYPSbjY8YJrWocrpqN56p+aveR0WsF?=
 =?us-ascii?Q?VeO7BbYw3px1x7pan1T6YJDmMBgfwV2xvBiWwk1NqYiN1UJod2EnprsVbdQI?=
 =?us-ascii?Q?BmzjJsH8vpOtX6BH+VStAV8/LZ8PRx8D9OBJJhgtpqN7S3Nw7TvAYUBEkOm/?=
 =?us-ascii?Q?fMq3sOpW7B0zs0+s1XgeRfOu6YlRqr3lGyJxWJPkw8YryHNgcqPaTWWaQTDP?=
 =?us-ascii?Q?EfX5v31+BKLmcN4P37Fp6O080LbuDAoCVLsmfEkSCQT4QDj/mb0Grqr4uIsZ?=
 =?us-ascii?Q?eikLO5eSTh2YcFtU2MTw3j5ceDt92JlN0B6diRjTQ2lnbTOmdtkL1HQNcv6I?=
 =?us-ascii?Q?qfqVK+FUsw3fnoshyfKJi8R28MawGSluoEIwVpt08GI5xcBl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9261f932-a6bf-45b5-e880-08df01cf1df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 11:01:58.2425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGCBFF1xD2OfMKEwB05HPG7rXQwvSOqGRi+l1IsYziQeBy0MZ9y4oTCduMVfrjDvJ586joV1pVFOOl7q+GfQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Monday, August 24, 2026 6:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: tell KFD the reset came from an ECC error

kfd_signal_reset_event() picks between KFD_HW_EXCEPTION_ECC and KFD_HW_EXCE=
PTION_GPU_HANG from the SRAM ECC flag, and only delivers the memory excepti=
on event for the former. Nothing raises that flag on the RAS module paths, =
so a reset caused by an uncorrectable or a consumed poison error is reporte=
d to every process on the device as a plain hang and the runtime carries on=
 instead of tearing the workload down.

Raise it the way the per IP callbacks used to.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers=
/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
index 39452a900615..9dd44fb5b885 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
@@ -89,6 +89,7 @@ int amdgpu_ras_process_handle_umc_interrupt(struct amdgpu=
_device *adev, void *da

 int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *a=
dev, void *data)  {
+       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
        amdgpu_ras_set_fed(adev, true);
        return amdgpu_ras_mgr_reset_gpu(adev, AMDGPU_RAS_GPU_RESET_MODE1_RE=
SET);
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index afb539f068c2..081516c46cf8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -54,6 +54,8 @@ static int amdgpu_ras_sys_poison_consumption_event(struct=
 ras_core_context *ras_
        if (!req)
                return -EINVAL;

+       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
        if (req->pasid_fn) {
                pasid_fn =3D (pasid_notify)req->pasid_fn;
                pasid_fn(adev, req->pasid, req->data);
--
2.34.1


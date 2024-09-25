Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94E3CF58C3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 13:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520B010E0CD;
	Wed, 25 Sep 2024 13:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDWZt9V0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB52910E0CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 13:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMpxiJaHL6gRMcg1JsWhMrEbCIFwTRaN1wz723UiqrmhQV/zvB9SushBgfGu75yVQ2bnVVX5fJxHrzS0ouOToPHwfo9cGCkSC5iyvM0C/ZoXMso3lt4uN59OYkXXLOvFO+dVIVc+5jHSs7TmAEGS017PLyJS5vXOUh8GBnC3LJpWbJ+DO5Iw0bcakYxd8MDfRx1Q1ydYCValoDtLG3PrhCk4Y8LiYhmPRuN8IfqVZ7Q7tQzE/64ntlrqshJ1lCcRfxboLsexNSdcdJmuOTPOSohvBMv5oTjF7F0/dy2O/rm6InDnhFPJSFaXT0Q5CFba/CNtMdDloQhfXkMfeOW2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkcf8N1rNTMUWSHdLSK4l9AtjZKATfNVpKUOKmb1jbc=;
 b=HAEE/aOjuuJH8ZcWYLakJDpuSYXSZ2ajfuF2vYpe4BOALxK2Kv2Lj5F8bE9VR5dURtOWbcHvwT9ScV2fSoxFfNIeKkwQP7mhPhBloT8YheWwpmSnJkiNWy8b9y5T7VfJHqEvA7hvGtjcKBkntGqm2RM20ET+09djNpxlkOUjLeOVaDy4zx3edz76rgn+xlgjQGFu4lIcSQowBTzlVWm/23mFV21ZJLL8uCoea4j1wyKCYsS+C/brszxA21lPL+RbmS8bL1PmQqxEFpDsM/FB+8WIL/m9kC/ReijSVxMZSbkWKxACcD0SiXAH/9mf4ZQ7RDZ7RpgYW93pUHInZgLEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkcf8N1rNTMUWSHdLSK4l9AtjZKATfNVpKUOKmb1jbc=;
 b=eDWZt9V0HdjzT2643FXMtzo5/42BKbKUcYtQPZlE/qBG9n2bB24M4aBvswMzslpy9p+igNvcQbtG0pVHUY+145/Uk1Vu/Jhn5XoGW0Wn0kcA2Rhnwzo4uaF5bGpH+VNUVjLJQ1u+atu7Bk26ZIGwdGbg9+pZhl+HycGMMYwj3Mg=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 13:21:57 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:21:57 +0000
From: "Chander, Vignesh" <Vignesh.Chander@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Fetch NPS mode for GCv9.4.3 VFs
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fetch NPS mode for GCv9.4.3 VFs
Thread-Index: AQHbDkdxyPcsSTcqiUSZNQ2U8vVMrbJofv7q
Date: Wed, 25 Sep 2024 13:21:57 +0000
Message-ID: <DM4PR12MB5055A194268B470426D7379CEC692@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20240924060250.2678600-1-lijo.lazar@amd.com>
In-Reply-To: <20240924060250.2678600-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-25T13:21:05.4790899Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|CH2PR12MB4245:EE_
x-ms-office365-filtering-correlation-id: 41d47a01-2427-4da6-996a-08dcdd65082d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7UdOGEMBL5BBK8C3HjPHVlGo1QJHBQLHntOyNUnSjm8noG7DPRJoiX1fKICZ?=
 =?us-ascii?Q?XLtOQBYWKInJ/O/Ml9cgEvZrwRuHlhAqEF+3QCr8x2av8r2rgB7h9B7UcCC3?=
 =?us-ascii?Q?Pw5dMWPdrpl8vmh0h3dI05Na6enxWaevQdfs6QWoGm0FUwSlnltu7YSE0j6m?=
 =?us-ascii?Q?yWvjXRlQsP4uBQtXs4Wtn2/1Fka9P8hsJLmiDAR9uAXGm0ZESGMx39ZPFZmI?=
 =?us-ascii?Q?g8bXe3RfokVowWWjW+mrO9W5FxatBUvGOGSaOjQoxER2auTKse51ak3I9e3/?=
 =?us-ascii?Q?P3uqn8IT52VvP36jy4pDHERN595uMMIXLTfMNJWAkpjUfX/JWs/SpoGJqCRy?=
 =?us-ascii?Q?2uTTF8xuBTpfgWQnbFxEX1ncWvsB/Bq7uz5uZfgCuzqa4Bn7y4Guj2ntDiEn?=
 =?us-ascii?Q?fRJKnhsp6bf9by3VVOAtOEMtPJN89rHHW8PI5s9VYjF6VsaT1Q7lhz+8mU4S?=
 =?us-ascii?Q?36sHyWYI6eITg5pgTmHSFD8ufs2P0blsLbWbD+92L5jIhedOW6RK6XZW+mwI?=
 =?us-ascii?Q?n7h2N7ME70r1s6Bg1HRySmKPsvczkLiZG8jYlsPUIq6TPpQjTOOfI3yFmEh9?=
 =?us-ascii?Q?eqbtK2NmbUrPDDOsEObZJtD2Q7rm6J4YyKwAKHgUQrxJRhZ57S+0QK3pCDp3?=
 =?us-ascii?Q?El0uNv+uo4WYjhJsP2v7YooC2DeErQeT5nIG8ITKuB/gXxFFsTS0b1JNwKMT?=
 =?us-ascii?Q?vQjkEpHs/8+ykLS2ouoGKW0yF9kByZdi7QLJuX2XuNSGz8WQVwTsj2riuZr1?=
 =?us-ascii?Q?zxqhJBR/hANCBwp80nWG8USvdqIKq5QjPjoD4yFXuAl4M4ORIu+SK9+Iqban?=
 =?us-ascii?Q?rEGa2qwjBSHHoAc6TGTXzfSDLuCLZdMdgV2jr/jFSdy8dp8XjdSW+mxZiBKz?=
 =?us-ascii?Q?4VZCUUtdk+5fSzRTtQIAVc/BvxWVTnkWsN4JpJfkOWdFyEa9wkF4euvFLQaw?=
 =?us-ascii?Q?KC4uLDjZd7Ou1kwfFCtz5iEHdD+ue1xk7pFS3Qet2BHy1/bmOgMjswvXQcq0?=
 =?us-ascii?Q?R6LBc0hVr2DdX1yVVWGhoozNjknOC5usDMt3+8B5BzUMLE8nnHq5o5c6HZ08?=
 =?us-ascii?Q?X3PwLaF7IXx8okwkz3KrhAo1iyrHKZvQAjIojuiM+u4MBeni1ignyDyC90mv?=
 =?us-ascii?Q?hB0c+nxugMVMDumUkejcxSruHnN28fNunUxEDnbbEBmNKcdl675MlSakdpaB?=
 =?us-ascii?Q?71xRSi0H6R3JNgbB/2NPuOnrE5DubbCgRmd/b3eN5NYxQSUznUcnI8KyUoGp?=
 =?us-ascii?Q?6OJL3WJrSJcsMmD2O77Gnu3gqAwtJb/uq5GKOimteQPl32diXYhYNT6MDgjF?=
 =?us-ascii?Q?N2TBxtkpiJqUy/nPdTtFw01Nd8iLPoibaHa3T+Vvn+RGSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aM+ozskPk/w7Tn5VT+rSb53rlIlO1h0bpyflncO6u/bCDvwFOlgKx3855lAU?=
 =?us-ascii?Q?3TbT8u1aByR2dCEPnstNPWn5BDOdpefTImeHT31fr9x7CR9DMDRaFHwkPE1O?=
 =?us-ascii?Q?oGF/g05d1kM0aATSde2tSOYRNHTheK9GOU+lBX2KVjrQbg3UHa4bZqtU621i?=
 =?us-ascii?Q?oOanK11/b5QN/dA7we8AIi1aQHJ969fQhubf8CF3r1SRgSvn6pqbsu/zBvBc?=
 =?us-ascii?Q?r+FF9yg/xZECqv2Tozdohhu1P1pT6dq33R6uyuuD2bwS9ecQq/nQDjnzuPgj?=
 =?us-ascii?Q?6QDvZDcNYMxWaFCIZTdnh+66cl3ihN9FHyGtTaqpsp2kSaYD2PGIeidXYsJj?=
 =?us-ascii?Q?SeitjzTSXVXJwNPa6FXm5aC4s+WPoKf1fT+OepW0Qf39smt17u71FDnMb069?=
 =?us-ascii?Q?n+aKTx/STV1PX7hs4hCRoCB2IfxfqOKgR94eR9DAzr2CI8KI9LRHYA1r3ymK?=
 =?us-ascii?Q?eln3aHQUq67DroQe2H0wQrJZahUKiKuNU50SEPB4pfjw8NBGL1jP8jZZyNXm?=
 =?us-ascii?Q?9nz8KWT02a5VYRkwf4XDgUeM08FHnitjqq7s4OPPOeE++MPsQuBAoIkZkG/I?=
 =?us-ascii?Q?UobLnHSsBr3u0K9mwKf+0djwIbx+4Ty2fhuw7KGzXn83xXrA2VuXu58nL39c?=
 =?us-ascii?Q?u7KJB0+kbeunOY0MQqQ1BwTztJdUI8PKtT3+1aC44tqXJevqb+UFKRz0Vk/c?=
 =?us-ascii?Q?Uw0BzQnrKP+iP90hZgYHmC/ECtDSMCgVEFsRmrhMT1aCGlIWfrzQjp3QFdUZ?=
 =?us-ascii?Q?iwo5Kndjwfsdaqx2S0OOqkgWX8rcjTspW31Kvfc5129MoWncl+fzRDtuUdqa?=
 =?us-ascii?Q?+alkHBAB4VIf+ce7SGOetx0ZroMWRpJM8I2c8pEgWRmaLPBACsVljvyE49NY?=
 =?us-ascii?Q?Wspsf54nQsjDo8ZELWwwG5V8hysVvSY6C5/77Ve0YuY3TTbt4dQ7yuDfpgTl?=
 =?us-ascii?Q?WaVjVp3jg/myHrY1IM89EoEhl6D/QrKaZRXqOlXQsbSHcJ8cH+RqbwTJEXI1?=
 =?us-ascii?Q?WptgIndI3pd1MGRvc2cdEDadjcX5iWCIFX2AErB2a+il+WMaZiElinnDfhJz?=
 =?us-ascii?Q?DsB1qNBqIRI0BXDfc1FGfXc89HJxL99Lh+wlFHuBdCmC6tfqzEpDcUeybRBY?=
 =?us-ascii?Q?bOuI1UR5j6cTcSSC/NCYngsa78vEnnXZRn7elqioqisLEeDGEpA/vYlynJAq?=
 =?us-ascii?Q?k97ogZltClYsmDzEstCvWihj4gbsiKpxAc1xlDZZmBnCrm+AnJlOmWrSERsc?=
 =?us-ascii?Q?dCOxxhW8en303PVdhSY1G0XgppoJqcyMMPu7hZ9KHCIxB3DV3tK1Qsyhdd/r?=
 =?us-ascii?Q?YMogT00mqoMoIBT2hBbkcBbcEGVt8t4E7g0IbncYlWq5uhtxdia+oQW45xJb?=
 =?us-ascii?Q?JiVCtTgGAvGvPq7FVu28qji/UOPz3HiCCrY1Q8y+mCzWc5HHdk5XlmjxDykp?=
 =?us-ascii?Q?1mFrZVE7exSMtp0Z39pqjzDM+5FTcvVDTjNPgnFtAkGMd5T8JTUm46yPsr1Q?=
 =?us-ascii?Q?ogHeIqN7/4EIW4k9PboKaSRofXjgqVs5R3BidNIhpJUKqC4tpTuIBq3KKcYN?=
 =?us-ascii?Q?Emm5tJd5EAPp1ttktVCuPG67x7YyfkQkdKqfbmw/?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5055A194268B470426D7379CEC692DM4PR12MB5055namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d47a01-2427-4da6-996a-08dcdd65082d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 13:21:57.7814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOggbDdMMOPkKIZ44Re73r3xA/mUcAZIUUHLZkDIEHlUssgj0t82mjbaCqfeFpJRt9cKtp/8+p+vaEftHg9Whw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

--_000_DM4PR12MB5055A194268B470426D7379CEC692DM4PR12MB5055namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Vignesh.Chander@amd.com
Verified-by: Vignesh.Chander@amd.com

________________________________
From: Lijo Lazar <lijo.lazar@amd.com>
Sent: Tuesday, September 24, 2024 2:02:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Chander, Vignesh <Vignesh.Chander@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fetch NPS mode for GCv9.4.3 VFs

Use the memory ranges published in discovery table to deduce NPS mode
of GC v9.4.3 VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 30 +++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 011fe3a847d0..4d8d229ca457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1256,14 +1256,14 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *ad=
ev)

 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
                                  struct amdgpu_mem_partition_info *mem_ran=
ges,
-                                int exp_ranges)
+                                uint8_t *exp_ranges)
 {
         struct amdgpu_gmc_memrange *ranges;
         int range_cnt, ret, i, j;
         uint32_t nps_type;
         bool refresh;

-       if (!mem_ranges)
+       if (!mem_ranges || !exp_ranges)
                 return -EINVAL;

         refresh =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_=
XGMI) &&
@@ -1277,16 +1277,16 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devi=
ce *adev,
         /* TODO: For now, expect ranges and partition count to be the same=
.
          * Adjust if there are holes expected in any NPS domain.
          */
-       if (range_cnt !=3D exp_ranges) {
+       if (*exp_ranges && (range_cnt !=3D *exp_ranges)) {
                 dev_warn(
                         adev->dev,
                         "NPS config mismatch - expected ranges: %d discove=
ry - nps mode: %d, nps ranges: %d",
-                       exp_ranges, nps_type, range_cnt);
+                       *exp_ranges, nps_type, range_cnt);
                 ret =3D -EINVAL;
                 goto err;
         }

-       for (i =3D 0; i < exp_ranges; ++i) {
+       for (i =3D 0; i < range_cnt; ++i) {
                 if (ranges[i].base_address >=3D ranges[i].limit_address) {
                         dev_warn(
                                 adev->dev,
@@ -1327,6 +1327,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device=
 *adev,
                         ranges[i].limit_address - ranges[i].base_address +=
 1;
         }

+       if (!*exp_ranges)
+               *exp_ranges =3D range_cnt;
 err:
         kfree(ranges);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index d4cd247fe574..94cb4f94f43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -467,7 +467,7 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);

 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
                                  struct amdgpu_mem_partition_info *mem_ran=
ges,
-                                int exp_ranges);
+                                uint8_t *exp_ranges);

 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
                                         int nps_mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 6a95402985ef..eb82d78c4512 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1386,11 +1386,30 @@ gmc_v9_0_get_memory_partition(struct amdgpu_device =
*adev, u32 *supp_modes)
         return mode;
 }

+static enum amdgpu_memory_partition
+gmc_v9_0_query_vf_memory_partition(struct amdgpu_device *adev)
+{
+       switch (adev->gmc.num_mem_partitions) {
+       case 0:
+               return UNKNOWN_MEMORY_PARTITION_MODE;
+       case 1:
+               return AMDGPU_NPS1_PARTITION_MODE;
+       case 2:
+               return AMDGPU_NPS2_PARTITION_MODE;
+       case 4:
+               return AMDGPU_NPS4_PARTITION_MODE;
+       default:
+               return AMDGPU_NPS1_PARTITION_MODE;
+       }
+
+       return AMDGPU_NPS1_PARTITION_MODE;
+}
+
 static enum amdgpu_memory_partition
 gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 {
         if (amdgpu_sriov_vf(adev))
-               return AMDGPU_NPS1_PARTITION_MODE;
+               return gmc_v9_0_query_vf_memory_partition(adev);

         return gmc_v9_0_get_memory_partition(adev, NULL);
 }
@@ -1935,6 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,

         switch (mode) {
         case UNKNOWN_MEMORY_PARTITION_MODE:
+               adev->gmc.num_mem_partitions =3D 0;
+               break;
         case AMDGPU_NPS1_PARTITION_MODE:
                 adev->gmc.num_mem_partitions =3D 1;
                 break;
@@ -1954,7 +1975,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,

         /* Use NPS range info, if populated */
         r =3D amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
-                                        adev->gmc.num_mem_partitions);
+                                        &adev->gmc.num_mem_partitions);
         if (!r) {
                 l =3D 0;
                 for (i =3D 1; i < adev->gmc.num_mem_partitions; ++i) {
@@ -1964,6 +1985,11 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ad=
ev,
                 }

         } else {
+               if (!adev->gmc.num_mem_partitions) {
+                       dev_err(adev->dev,
+                               "Not able to detect NPS mode, fall back to =
NPS1");
+                       adev->gmc.num_mem_partitions =3D 1;
+               }
                 /* Fallback to sw based calculation */
                 size =3D (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU=
_PAGE_SHIFT;
                 size /=3D adev->gmc.num_mem_partitions;
--
2.25.1


--_000_DM4PR12MB5055A194268B470426D7379CEC692DM4PR12MB5055namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto">Reviewed-by: Vignesh.Chander@amd.com&nbsp;</div>
<div dir=3D"auto">Verified-by: Vignesh.Chander@amd.com&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lijo Lazar &lt;lijo.l=
azar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 24, 2024 2:02:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Chander, Vignesh &lt;Vignesh.Chander@am=
d.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Fetch NPS mode for GCv9.4.3 VFs</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use the memory ranges published in discovery table=
 to deduce NPS mode<br>
of GC v9.4.3 VFs.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 +++++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp; | 30 ++++++++++++++=
+++++++++--<br>
&nbsp;3 files changed, 36 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 011fe3a847d0..4d8d229ca457 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -1256,14 +1256,14 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *ad=
ev)<br>
&nbsp;<br>
&nbsp;int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mem_partitio=
n_info *mem_ranges,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int exp_ranges)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *exp_ranges)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_memrange=
 *ranges;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int range_cnt, ret, i, j;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t nps_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool refresh;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mem_ranges)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mem_ranges || !exp_ranges)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; refresh =3D (adev-&gt;init=
_lvl-&gt;level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;<br>
@@ -1277,16 +1277,16 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: For now, expect r=
anges and partition count to be the same.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Adjust if there ar=
e holes expected in any NPS domain.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (range_cnt !=3D exp_ranges) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*exp_ranges &amp;&amp; (range_cnt=
 !=3D *exp_ranges)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;NPS config mismatch - expected ranges: %d discovery - nps mode: %d, nps ra=
nges: %d&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exp_ranges, nps_=
type, range_cnt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *exp_ranges, nps=
_type, range_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; exp_ranges; ++i)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; range_cnt; ++i) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ranges[i].base_address &gt;=3D ranges[i].limit_ad=
dress) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_w=
arn(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dev,<br>
@@ -1327,6 +1327,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range=
s[i].limit_address - ranges[i].base_address + 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!*exp_ranges)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *exp_ranges =3D range_cnt;<br>
&nbsp;err:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ranges);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h<br>
index d4cd247fe574..94cb4f94f43d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
@@ -467,7 +467,7 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mem_partitio=
n_info *mem_ranges,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int exp_ranges);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *exp_ranges);<br>
&nbsp;<br>
&nbsp;int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int nps_mode);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 6a95402985ef..eb82d78c4512 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1386,11 +1386,30 @@ gmc_v9_0_get_memory_partition(struct amdgpu_device =
*adev, u32 *supp_modes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mode;<br>
&nbsp;}<br>
&nbsp;<br>
+static enum amdgpu_memory_partition<br>
+gmc_v9_0_query_vf_memory_partition(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;gmc.num_mem_partitio=
ns) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return UNKNOWN_MEMORY_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_NPS1_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_NPS2_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_NPS4_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_NPS1_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_NPS1_PARTITION_MODE;<br=
>
+}<br>
+<br>
&nbsp;static enum amdgpu_memory_partition<br>
&nbsp;gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_NPS1_PARTITION_MODE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return gmc_v9_0_query_vf_memory_partition(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return gmc_v9_0_get_memory=
_partition(adev, NULL);<br>
&nbsp;}<br>
@@ -1935,6 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UNKNOWN_MEMORY_PARTIT=
ION_MODE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.num_mem_partitions =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_NPS1_PARTITION=
_MODE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.num_mem_partitions =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1954,7 +1975,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use NPS range info, if =
populated */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gmc_get_nps_m=
emranges(adev, mem_ranges,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.num_mem_partitions);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;adev-&gt;gmc.num_mem_partitions);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; l =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; adev-&gt;gmc.num_mem_partitions;=
 ++i) {<br>
@@ -1964,6 +1985,11 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;gmc.num_mem_partitions) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Not able to detect NPS mode, fall bac=
k to NPS1&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.num=
_mem_partitions =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Fallback to sw based calculation */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D (adev-&gt;gmc.real_vram_size + SZ_16M) &gt;&=
gt; AMDGPU_GPU_PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size /=3D adev-&gt;gmc.num_mem_partitions;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5055A194268B470426D7379CEC692DM4PR12MB5055namp_--

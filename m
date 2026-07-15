Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E63CC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 05:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083CD10EEC9;
	Wed, 15 Jul 2026 05:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipvfumzs";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EB310EEC9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 05:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK9h/w25nQMCd+Ey3xoXPZq3Ao+pZFN6Q7v53zx/P4tT80A/QwqulKo8Sp66B3hE8OWamY+t2MJc/WjjMy8j6tG7td96IcSP9Ut5oS/wFlMhecV7gefSqwEk/F++c6wDbrALJPWQIlet3zRIeXYe5SZbVfUWzCeKe0v57EYgtzvdL+n1Fbjygh88LbqLMbUPDf2+xPkKsuWe1cPSjK94mZ+7sAcv+d3MjgaTqfCwUSJWIS7GTK4UQw4fxS9RBocNb+E4llcqj5yz92l6Q6AuoKTJrXGeuMf4nWqMmulELHDAJf+t+xZ1ZW9pFbbEGnxsZwGYFFZGNJJ/Twd7koSqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJn42GmyjQOo9HPuh8yI3mzkiYShQenY3callFxq+W0=;
 b=Fs5yRxaJSneDAfjUPm1yaFl355vval8ewxwTscdZ4dS4V3nIVWRuGa/Kejp7S8jEC1/ANvEQA9u5sG0+JH9s9VDH6VIHSN1DleMyRhQL6YkMJEeEVKI0mjoAGtVZeLCgfzY/g0tFQgJgFx1s2LFblyB6N7qsFXHv+ujVLf8UcQVmrzrd61dnZEfZMIwJEuvCp64Vh9r1oVn5UMndeJD2i2LxPzOqOHBxTM3Tx++8Qdr5sotbkfpuhv04XEVBDIue24XGHtAXez7AIk7WqJvvDaMpOpcOOgjL153emjFfbi0ukuHMbDQ6zTFM89rUIq7ihHeS5iGxHIefs0BLjPacCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJn42GmyjQOo9HPuh8yI3mzkiYShQenY3callFxq+W0=;
 b=ipvfumzsKIxfu3YKPXFEH37KKex2DeSTzGY/mCADZir5gT1b9iqO8+79bZ4bs7qJ6rGjRN6se2hMP7BbxHUd3RrN//8i+65oBClKmM19QdcrCBxD6Go+y6HonqQjZkaI7NCv/1Ep6WxIQtTOI6RWyh4V/7QQAhFp4Kzqd6gEFt0=
Received: from CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 05:56:39 +0000
Received: from CH0PR12MB5297.namprd12.prod.outlook.com
 ([fe80::9d57:4d43:58bc:70a1]) by CH0PR12MB5297.namprd12.prod.outlook.com
 ([fe80::9d57:4d43:58bc:70a1%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 05:56:39 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Topic: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Index: AQHdFAZoUXE/mSjAOUyAF/obuVsbdbZuEaTQ
Date: Wed, 15 Jul 2026 05:56:39 +0000
Message-ID: <CH0PR12MB529760041D3F3D8421686C95FCF82@CH0PR12MB5297.namprd12.prod.outlook.com>
References: <20260715030229.1050986-1-cesun102@amd.com>
In-Reply-To: <20260715030229.1050986-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T05:43:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5297:EE_|IA1PR12MB8262:EE_
x-ms-office365-filtering-correlation-id: 25bf4ea2-abf9-4f07-c250-08dee235d66e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: lel8xPSwISOoz5BUxWx6sZ1qbM/qyH2rJ4BdfpNpuF2YLZD8G+dcVCzz6yA465ZJEiFAcuVGFTwsy0pTrVibtD4sNdVV2qttLCCJB4PzPgyU1WDX8HKrPUXEN/eJUB4dmlBxKW0PhYxwPKBdyYjj7aKrkUH7Lq6GxGIjmKVjJ8dvkoCfzJD/zWbJ3TbJQ/KChWuPLlFwZ0nYw0hRobqHCetAqzf4UB5N+efIrMvAHe4bT/aNu+WwyzMoV7nd7XSGEVZGtxnRfvvOjK6yNkuPZA2nSM8TOrL6IN18ggkSqMRI0f1FniTuTd91j0CpR/di9c1FII6jNG9w37H+q7FJW9CxgLXKawUi8Ij61NUn0qwnYkbMN45RjzXZY2YrfSm4fww9KhgMPUqyrkZZkx4iPKAdNcT+5hOzOr9ckd+dMvz/L6xYe16MEkugE8uzSED+cGHu28YDaMxtLC9I5jkP4r6IUYs9rZl8vPZ2L1aBxyT+7PWkf91PKwbNrV+XW7D/WokAWSjqnkyrjtd+O/DhGNeW4I3A4m4GYB1IfXCZhAiiGNicrlsqZrnqpCMzj/bHw522CoamFEO/JFJPMeTMyD9e7r1hHkSacWT4FS5hSHGvkG5ItOTzAX02M66CnqT4k8gYWiqrVwiDGjYZDKa8m4ofmZGO492/jiz4dNqgOv4iSIZSVBYMFMbFZd6b/foVvRCRTQes3AmgMJLMqex0ANcGa4RyFAVwYLdx/KI/g/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5297.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/z9UsjTL+NVptr8tf+q9gDvrlqjGz/gxgj0vi3mAfzwFzvsad9gl5FHj7GSG?=
 =?us-ascii?Q?N46uUZfuzeqW0pa2P2/THUEju4pYRkUO4lBGtgPXY9yHUHHqEA3ROdq3gPYV?=
 =?us-ascii?Q?Fld5RA7aUGwuwWtx7/ZI6w0hUHZdYgPWF01AN8ezyX3tZcjI5O4FzEG0A6i9?=
 =?us-ascii?Q?5IVQqQ1Z0A/e4G5NS1tUT4WmjAN6RqjEZmSdbmzn6anB1vltVjQ20Nm0poRu?=
 =?us-ascii?Q?psVp/6w/f4/XYrPeMga5WpicJFrms9OjMvgCE2eHp4v81v5g3yplpwBMeVRP?=
 =?us-ascii?Q?asloYzM17UlDWa8GtGiHoJoVT9uMFJIiyUaeySHChn6sMA8VtxoYSkOyi/in?=
 =?us-ascii?Q?YnMHzSaq3Y0hEDFN6+ro2eHJwBsxvP7Eic7+34ADi/Q++7jJItV6k1Ka9jIb?=
 =?us-ascii?Q?7gFqt1Sk2YAFPzF412nzWzYigCtO9OK5SorgiRasopupK7DcbNkOdvBFYJFv?=
 =?us-ascii?Q?xhY7121frMXMcw1Vc3qIhvOQ1cKNUjZFSXtInS/OYHIg+0iCoizIu4lic5uh?=
 =?us-ascii?Q?MRxzgh941jE//iLinNLuPH79aYXp5mGcUB9imXHjb1lVCFVto6qjsCpUskuK?=
 =?us-ascii?Q?pRcBMjQZJrdfhgWNjrlUmc6UvLxM0AAgPVxux2zeTY9nESnaVFI7XXASRNc9?=
 =?us-ascii?Q?xES85wqGJUYzBEJa4FlFgMg2wXm1sO0f9PNaUo9xlGeTYsH9sTmr2TK+8UPg?=
 =?us-ascii?Q?+srNCJI7fM2hT0rerERMJUbBCwPN435JCF0gdi0Gsa8T2u9krhUbgQK7VMWB?=
 =?us-ascii?Q?pkTyIe3EBp780tk8jpPSh4BIKrhfaBrfZPg38bDNh8z9VAG7TOothTi+mOJm?=
 =?us-ascii?Q?HUWM6jho6PeAyNPsCKOOdk0//mWCXQ95my6B0XT0n+nTxxOejvYRDzSDqIk4?=
 =?us-ascii?Q?H+cq9rIDc1LEhhjsnFrRQq21ODAcNLipzsuoCfivFmHvwSS0u5AXWQDzja/a?=
 =?us-ascii?Q?0rcvFbUPaoRlYFlDAumcZ8ho9jifeyV24x2McafcHRY1hdJ24nik1e/znZct?=
 =?us-ascii?Q?35xoRQLGHxg5rfmUlh1uB1I8No92yzkRawcETmPTIx1wueuS3Ry+pLcKZ3fC?=
 =?us-ascii?Q?J8jA6FlMt4r6eQ22xmKVygGawDTm7qTN6rU+dobksAqzNREttQdeIWEYMzV8?=
 =?us-ascii?Q?jeNN2YEjpNdvkt7n1W1xmxTu7/CjDVJBV5LkFJBbTHwNLiJ5STRrAt5eYeYd?=
 =?us-ascii?Q?6x6ylb2wotUFGge2ma9q50FAOeIebV+M9lYt05JsP9p5h+c3ctMgjJ/Tlv+c?=
 =?us-ascii?Q?jqtTD/jrpvrMLTjkSZvlwPlfYCsHWX3pEHSlWGX3yWG1vYnoxhQt8bsWCOxj?=
 =?us-ascii?Q?sRSyPwnkXIEeqKubSTSr+fHmozZBVOunROzEbcP6WGxYeGVcawJG/LU+Vkx3?=
 =?us-ascii?Q?HE8VM54orGL58CNxnizVvhzTaE47yUA/a4HT5b5DLBYS5iOMnhH8OoLAmIfN?=
 =?us-ascii?Q?nlrHhvoS37lKN63381oRnDp6oiCo+Ti4ql0Dfl+lhDQDoqp4v7NUFNFBBPUT?=
 =?us-ascii?Q?YwydIVSQ/RcBEb6SbqDWjQncIO3Xj8C857mYBijEEx5NnDpdLuPdt873gbmO?=
 =?us-ascii?Q?ucbEmtDA0kkVVqHkSwthGIhkZkY9jKSLeZFjGMLeGYFqh7ZT99SnFXh0RtHq?=
 =?us-ascii?Q?Nt2p2TqlQdiVSl7DqIFO1PBinBH99Kg+xEcnV/mHyAK27KE0FMI+Da+b9Lt2?=
 =?us-ascii?Q?TIdFegbjIkyvRrxbDQaMKAJjxUTVQnLvZx3RFzORharGdlW+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bf4ea2-abf9-4f07-c250-08dee235d66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 05:56:39.1851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/v6tUtVPpEFQOj8qG7IxpZQn7dY0KpFaO2P3CVkaSd8qTzlGq3CUnMpuxQeMoYRHW0Uw9nhiAWlcKCp8wjo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, July 15, 2026 11:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for unir=
as

Add debug mask to disable kernel logs of RAS correctable errors, including =
both ACA and CE error counter kernel messages.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 12 ++++++++++++  driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c        |  7 +++++++
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h   |  4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 10 ++++++++++
 6 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..2be008a9da6a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -437,6 +437,7 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
        ras_mgr->ras_is_ready =3D true;

        amdgpu_enable_uniras(adev, true);
+       amdgpu_set_ce_log_state(adev);

        RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
        return 0;
@@ -510,6 +511,17 @@ const struct amdgpu_ip_block_version ras_v1_0_ip_block=
 =3D {
        .funcs =3D &ras_v1_0_ip_funcs,
 };

+void amdgpu_set_ce_log_state(struct amdgpu_device *adev) {
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
+       bool disable_ce_log =3D !!adev->debug_disable_ce_logs;
+
+       if (!ras_mgr || !ras_mgr->ras_core)
+               return;
+
+       ras_core_set_ce_log_status(ras_mgr->ras_core, disable_ce_log); }
+

[Thomas ] Since ras_core_ce_log_disabled is a boolean, consider renaming th=
e function to xxx_disable_ce_log() or xxx_ce_log_disabled() to better refle=
ct its semantics.

 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)  {
        struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
; diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index a20bb8fdce87..efbdb25241a3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -63,6 +63,7 @@ extern const struct amdgpu_ip_block_version ras_v1_0_ip_b=
lock;  struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
                        struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
+void amdgpu_set_ce_log_state(struct amdgpu_device *adev);
 bool amdgpu_uniras_enabled(struct amdgpu_device *adev);  int amdgpu_ras_mg=
r_handle_fatal_interrupt(struct amdgpu_device *adev, void *data);  int amdg=
pu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void *da=
ta); diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/a=
md/ras/rascore/ras.h
index 878dfdfcb18a..5911ce63f889 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -346,6 +346,7 @@ struct ras_core_context {
        spinlock_t seqno_lock;

        bool ras_core_enabled;
+       bool ras_core_ce_log_disabled;

        u64 ras_fw_features;
 };
@@ -403,4 +404,6 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras=
_core_context *ras_core,  int ras_core_check_address_sanity(struct ras_core=
_context *ras_core, uint64_t addr);

 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable=
);
+void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool
+disable); bool ras_core_get_ce_log_status(struct ras_core_context
+*ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_aca.c
index 67a35409ff0e..5a46a265e26d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -99,6 +99,8 @@ static void aca_report_ecc_info(struct ras_core_context *=
ras_core,
        }

        if (ecc_count.new_ce_count) {
+               if (ras_core_get_ce_log_status(ras_core))
+                       return;
                RAS_DEV_INFO(ras_core->dev,
                "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors detected in %s block\n",
                        seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk)); @@ -114,6 +116,11 @@ static void aca_bank_log(struct ras_core_contex=
t *ras_core,  {
        int i;

+       if(ras_core_get_ce_log_status(ras_core) &&
+          bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
+          !ACA_BANK_ERR_IS_DEFFERED(bank))

[Thomas] Can we use " bank_ecc -> de_count " as the check condition ?

+               return;
+
        RAS_DEV_INFO(ras_core->dev,
                "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events =
logged\n",
                bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h b/drivers/gpu/d=
rm/amd/ras/rascore/ras_aca_v1_0.h
index 40e5d94b037f..c42a47492d4a 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
@@ -67,5 +67,9 @@
 #define mmSMNXCD_XCD0_MCA_SMU 0x40430400       /* SMN XCD XCD0 */
 #define mmSMNAID_AID0_MCA_SMU 0x03b30400       /* SMN AID AID0 */

+#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
+       (ACA_REG_STATUS_POISON((bank)->regs[ACA_REG_IDX__STATUS]) || \
+        ACA_REG_STATUS_DEFERRED((bank)->regs[ACA_REG_IDX__STATUS]))
+
 extern const struct ras_aca_ip_func ras_aca_func_v1_0;  #endif diff --git =
a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rasc=
ore/ras_core.c
index 08e17a83ad5b..80974b8d6297 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -545,6 +545,16 @@ bool ras_core_is_enabled(struct ras_core_context *ras_=
core)
        return ras_core->ras_core_enabled;
 }

+void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool
+disable) {
+       ras_core->ras_core_ce_log_disabled =3D disable; }
+
+bool ras_core_get_ce_log_status(struct ras_core_context *ras_core) {
+       return ras_core->ras_core_ce_log_disabled;
+}
+

 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_co=
re)  {
        if (!ras_core)
--
2.34.1


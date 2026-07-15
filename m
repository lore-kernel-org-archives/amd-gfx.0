Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B6C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A35C10EEF3;
	Wed, 15 Jul 2026 07:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F8alMm/G";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8653310EF03
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e38tzBdBP51Eiv4PvEHRbiyj4hvnm01pAppB9EQ8MhklZWOlQADwAwz7BMr4SNKIx0I04tEIuildzel5bI3HDMF+N14NMOF6EDmDN9goz5tVC3yYMGMyT4FY5yJpsQClH71ojGyn859hKLKkpfWCSDOUkc6xhoBg4/WPG/4hVDCUtu9UMBjs9ZyMiIfHm3rgJ/OmiCEE7O3XsyS95Tp7IIcbHMBaumyE+3dofCrQY5U+9fQVECE5C0mIhQnUlbzIrzDwVkcyXI8vgZXlJkpIGQdA14aVvINlQ0Dz7tONW//g9SUafwRODN1E8gFVwErbQ/sr9VGXSbJV/CM2M8knqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhKJwe6B+6svZa2SeRHmQa8fZ8tX/UK8uuaDqF310Mw=;
 b=UwFuHuMPPR2QR9OWQvULvgRq21BnSPcNavbd1Weomy0khjnKLL1/gSrMVog8e9Mu7tBh2MNZTBX6EQAzNlOrB85GPdCQomoCWh8rDDQS611QWQX/0MfR3e3ehhq0tbkM95KAaJIwlrT9rSV2V00HPUBl+25t9aNF8JCu99vZIELTo5HI8YMqyM2VdeOiqmNQWUizY/uFqPk2WtBEP/d9iKuWqjM9dW5RYUTUc2OhtRdp0H2qaE0CW6srgXbSi+Cy1YQ1BzlIUtTZRWnxFZv3mgGKAAnDK0MXm0/EmhIKyJrf/fWOltcBJnJLfJB6VPj/1HlpmeZaQxnk2Mn63NbW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhKJwe6B+6svZa2SeRHmQa8fZ8tX/UK8uuaDqF310Mw=;
 b=F8alMm/GJLCfBPnGxKhv9c58UPSCx/zCoLF1nWT8slN8gRbBb3ULP89L3Hkzik2jqFwm75P56/ugfYAXBUKZQphZ7jWGJ59pp6+qBSLEFjmKBs2atkx7K4gXnTKLrHZCyvhJKYVMkV1anWM53Ns7s+iQuD7Kvjh7dhuMtq0UHgE=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:39:48 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:39:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Topic: [PATCH v2] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Index: AQHdFCh8Kjj9LIPq40ucPcUeOM4YQ7ZuKmIA
Date: Wed, 15 Jul 2026 07:39:47 +0000
Message-ID: <BL1PR12MB51270ACD24C82CC99D4D2DB3B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260715070627.1052215-1-cesun102@amd.com>
In-Reply-To: <20260715070627.1052215-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T07:12:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|LV8PR12MB9450:EE_
x-ms-office365-filtering-correlation-id: 41f4a50d-2907-401f-b090-08dee2443f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Gl4C22rNntvmjRMa6zJ3ym4EbbVAezT9AZ5LUT5eZ3tKuUsTu/uayUMyre9Dr/COQmrf2//fruQ2C99XF1YIg72Fah58q3dktNCUs3V8wbCLsJ7B7DHYyeYIw/ZOimHuMDG1aDazeAsN0VYh2gFH1HMOBk8NyfzrHuajQfU0JtGynVR/U49zfVMap2V2kDTJ2yrHgIVdxUszXG3IZJF0WiNq+mWB/ArmvXxA/M1IlwcOTJMgn4n/nzUL3xGvkUMfirYYuheg2zmIPP5cTd/+InLCTiBkiIlgYhwNmCAKlVWinz3aFDNSXv5Df1z8Adxr0Tm/Tp7fdXm7XF0lfnHweipCIapB2iVXTujkhr7DMx6ZSaW7e1lOi2fRstOTVVeQenf1EHS0y/88OlQwevL5leuZENd6F/JxDrDMNU73amVFJJ450K06nY1EY3jpkwTmeYJfBH4mwNuTvBoR6/pYN7CQxn8dnH/Mk1v/L3UxptClbpfbMr48lJDeZcBrzrtdSsmYy9bn8QOc163FvRQZzHfYZPrZSHQJs5yRM0OWsVvOtCIWPwLwXGICGLVoNRughF7QdvwfZ+pipNvR9n3GWrLvuLDPu3QdpLfcoiKaZ/VV22U1F6Pn5qGuAWm2gjwotle1MvpXLNmRPLOyCYLl4rftFyHjxkky6AdyPG+Sz+J1DArFq7uetb5uX4cfMzZNZYut4uAlh2Gacf6HfTDlEK05HlLLypvHla/pe2V7EKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?diaqReQ53pMeOyK9LzhBB2418IJkxQpawJICSRZo+s4hA8uCYkzESLyMFkgb?=
 =?us-ascii?Q?hZkRIxqJ4/zHtgswjt/lfbHWHPqHGn6X+ZY9o1cZsIEZGp4PMhRf9T2mPtER?=
 =?us-ascii?Q?83U0EHFWQbsmP45PUFVhEl+BXufGLKbVPcfcfQtpewsJ2cDBMpvoJ/pbp2RS?=
 =?us-ascii?Q?dKy14O6ol7zTDJj7nyJHuzcJAyJD1m/l4Ih1k6MCLQrDiran8bdXTYYgWuqt?=
 =?us-ascii?Q?GfY2Fb/kMfdplk6UUFvHtkFj+UEGbkulv0nsEUuLidOLPWLRp1xpd8VLTVJa?=
 =?us-ascii?Q?1wIKRJRGL2NCfbAXGvtZBS0AOxDZvns2+Elgo0WhZiU6ZjWtbKx+j0qU3ByV?=
 =?us-ascii?Q?wohfExc7tO2XsHpcsVvJvOHxJHoG/Tcp2rnCudkl0T6APR6cIljopSuhz2ZO?=
 =?us-ascii?Q?AbK1Qfn7gseJX2PAXrgN+2sSjLE1QsyE6mMo+jajeFl9vdxi73RmagFgfpFW?=
 =?us-ascii?Q?HaIs3w19EsNoThwkN42s2GY8StHYSlVsR9HImxidKm2tT9+sjh1NBsmmxY9A?=
 =?us-ascii?Q?GEUm0Omexf25NyZj/wZ///pGMsqeFf6CMMg4jcCUJF8a2Zh5Z4Bjli0wWfhK?=
 =?us-ascii?Q?B1+5DPbRFAKFjTZHNcSJKIOpu3nS5y9Q+8jb9Bvkm5m0TPfmq2IRkYD+2S5W?=
 =?us-ascii?Q?LUeJlvfdNx5M0CNAvDZKv01vz7YIGtozPwNkF4tPaJTr3U/4lMc+oHYfAf/I?=
 =?us-ascii?Q?blKL+t0JWUhiwC6S4L63xNRUhDGNTTygYVbCsADW4w4j/gXpmEkUu853HGHs?=
 =?us-ascii?Q?jw5QkEYwYUzk+xmGzgO8GFMVWlxG7odumOnZpdyFx/sFIwRICP5OlH4kcx7W?=
 =?us-ascii?Q?YWC9+SHsprnfR4h89k1D8zsTO6jrBdjQGNlQXP6ELkyLdEF4kxV2X2RpZL8G?=
 =?us-ascii?Q?5G51tU8k8wE/T1gc4kWFrStISB+4/7L1lMNHYEpvO8O5OZCofOKlk7D91Oj8?=
 =?us-ascii?Q?gkHN8ePPUtWsTkCCQBbb3f+Wiw9eUi9EZ9FCG+3xClOF6uTnrA/Iu9kuDhrz?=
 =?us-ascii?Q?jKiIlkGz7lu5ZKzbZY46M9k1vsRyWZ6EYspgNHdbcoW24uA/7Wrbtkkg5cYy?=
 =?us-ascii?Q?ONfj4dvZ2XohvTD4IB4uAJdGTqaJ2suLuL1j0dHaFOYzGt0I0gj4jS9oYbjo?=
 =?us-ascii?Q?DNjEL3LP/Snk9b9c5GCZWUvt2XmdEe29agvPfIuBJ9xZtihhbLO9ZX1Gi/0D?=
 =?us-ascii?Q?PnuYq17piCLBS3/rvYQVgwqoLu0E4BVLwXmuMznUnjTDWNac1iTWgS5+Mc75?=
 =?us-ascii?Q?p4XkSkagKV0nFdrHUV7QoeikUwTOaDaI1UiNp6zKn4LozgC49V4oE8WIu4/9?=
 =?us-ascii?Q?P2M6LdcoZeW+4M5DsbZEfoQLgO9tRGQWkuI8+JQG8CAkYhTmC6Stl1+/yT3E?=
 =?us-ascii?Q?vHoKh8eLUThSlabLEd7UwKkTX1ed/gDW77R70dy7vcabmEhOXSS72iAhxv2U?=
 =?us-ascii?Q?/a7xLVYeVu85TdpEWRt2EIOYdACyx3fxe5Q/NpKHWXtjFSz1R4vlDpidVKlc?=
 =?us-ascii?Q?FosWmufvFemj9WgicvL2CU8ytEVMsOJU8Fq3kQfkcHkA18gRIX6HfSoNMqqZ?=
 =?us-ascii?Q?/fEOjCV57NDBbESZGwE0IloONYEqGR2ozMfWqdw1XOVhtUqq/wF2MpZ70OaI?=
 =?us-ascii?Q?JKDX4yGfwpe6YS4UGApTYGXp3pPEUBtpGQI2oyWTucKqvJl1q9fPHxp30hnI?=
 =?us-ascii?Q?4gwVURCtaTV4PQR6FUsVd+I2t1RyuMZW0h2xJe00AOLXWIbW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f4a50d-2907-401f-b090-08dee2443f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 07:39:47.9547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeEVN7SEl0a75YDSF5Hv0uo0um9/R20cm5LBDSF7TMizT9ujo99ropw/EmtUI3Fz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, July 15, 2026 3:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v2] drm/amdgpu/ras: Add debug mask to disable CE logs for=
 uniras
>
> Add debug mask to disable kernel logs of RAS correctable errors, includin=
g both ACA
> and CE error counter kernel messages.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 12 ++++++++++++
> drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
>  drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.c        |  7 +++++++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 10 ++++++++++
>  5 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index ea95e0f93d1c..bdc9d9583bdf 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -437,6 +437,7 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_bl=
ock
> *ip_block)
>       ras_mgr->ras_is_ready =3D true;
>
>       amdgpu_enable_uniras(adev, true);
> +     amdgpu_set_ce_log_state(adev);
>
>       RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
>       return 0;
> @@ -510,6 +511,17 @@ const struct amdgpu_ip_block_version ras_v1_0_ip_blo=
ck
> =3D {
>       .funcs =3D &ras_v1_0_ip_funcs,
>  };
>
> +void amdgpu_set_ce_log_state(struct amdgpu_device *adev) {
> +     struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
> +     bool disable_ce_log =3D !!adev->debug_disable_ce_logs;
> +
> +     if (!ras_mgr || !ras_mgr->ras_core)
> +             return;
> +
> +     ras_core_disable_ce_log(ras_mgr->ras_core, disable_ce_log); }
> +
>  int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)  {
>       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
; diff
> --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> index a20bb8fdce87..efbdb25241a3 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> @@ -63,6 +63,7 @@ extern const struct amdgpu_ip_block_version
> ras_v1_0_ip_block;  struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
>                       struct amdgpu_device *adev);
>  int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
> +void amdgpu_set_ce_log_state(struct amdgpu_device *adev);
>  bool amdgpu_uniras_enabled(struct amdgpu_device *adev);  int
> amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *d=
ata);
> int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev=
, void
> *data); diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 878dfdfcb18a..0c362f9e25d6 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -346,6 +346,7 @@ struct ras_core_context {
>       spinlock_t seqno_lock;
>
>       bool ras_core_enabled;
> +     bool ras_core_ce_log_disabled;
>
>       u64 ras_fw_features;
>  };
> @@ -403,4 +404,6 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct
> ras_core_context *ras_core,  int ras_core_check_address_sanity(struct
> ras_core_context *ras_core, uint64_t addr);
>
>  int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enab=
le);
> +void ras_core_disable_ce_log(struct ras_core_context *ras_core, bool
> +disable); bool ras_core_is_ce_log_disabled(struct ras_core_context
> +*ras_core);
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> index 67a35409ff0e..7219a1008dea 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> @@ -99,6 +99,8 @@ static void aca_report_ecc_info(struct ras_core_context
> *ras_core,
>       }
>
>       if (ecc_count.new_ce_count) {
> +             if (ras_core_is_ce_log_disabled(ras_core))
> +                     return;
>               RAS_DEV_INFO(ras_core->dev,
>               "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors
> detected in %s block\n",
>                       seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk));
> @@ -114,6 +116,11 @@ static void aca_bank_log(struct ras_core_context
> *ras_core,  {
>       int i;
>
> +     if(ras_core_is_ce_log_disabled(ras_core) &&
> +        bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> +        !bank_ecc->de_count)

[Tao] the de_count is always 0 for non-umc blocks.

> +             return;
> +
>       RAS_DEV_INFO(ras_core->dev,
>               "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events
> logged\n",
>               bank->seq_no);
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 08e17a83ad5b..76cc98e0abc5 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -545,6 +545,16 @@ bool ras_core_is_enabled(struct ras_core_context
> *ras_core)
>       return ras_core->ras_core_enabled;
>  }
>
> +void ras_core_disable_ce_log(struct ras_core_context *ras_core, bool
> +disable) {
> +     ras_core->ras_core_ce_log_disabled =3D disable; }
> +
> +bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core) {
> +     return ras_core->ras_core_ce_log_disabled;
> +}
> +
>  uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_=
core)  {
>       if (!ras_core)
> --
> 2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBF3C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 10:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D266510EA2E;
	Fri, 16 May 2025 10:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFrsiF1H";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596A910EA2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 10:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9YjYFRGLSv1+xyQ+YHUNDxsgvYS28FpWyHv51Em7BwU2A4XdPLoF2gH9ZZiVXFFOybFDDY1vQWoTG8ffbCGsv/fipEu9v/xY0abfXf3j1qOmcgz5Xt7Sbg/zcGNjtTRdogLUUm78TEEwr2hM9VHeq+EBWWOStjz73dIv2DbIqSNLKoWlCPgwQcz3iI/JbqMO0NowwuGwbaJ3noYyPicbS43BxsF3RIDRJHqwWAvj/bbcfrZ4UjtkV4h16TQClQ2T8WqMAPijym+4gbs5MauwYshDQYtyH5BCoXC1XXcksZkwSLjsQmcPbAgsr1BSGBhEpcbTScRZ0aZ5kLEGHlLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWy1TWCwf4DRsiGzaOoYT3qBadDBbGf24qI+AZ9lQ3A=;
 b=IK+jYe+PpSKHFQZ74p3VMdQZppALWmzEMuoaVAQg2VR5MIxu/XGyfggM18Peh9u1LsMECEON7qakqvFjAv2noX+pe1dCbUsh9xYINi8X32+Q07PX7ir9DERRU9kP6Y9S/1Gh5jcMsZBAyoxB93g+HHm5jzEbTOpc66IWJi8VnwR+a8DDtn7T+dCVsQv9M9RCd7L2FskAwXy6q2QHBopby9i+Gn0gsNivQxwGIiS4A/TBLl89B8hHVzKo3uZwYt3sNUjExLy5+2FzAn+MzChGFXMlJdI+M69vXIHf85Ju6IrObrTVUnFyj39iUWBniqZKZBsXDj6bScsZjRhiDgTqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWy1TWCwf4DRsiGzaOoYT3qBadDBbGf24qI+AZ9lQ3A=;
 b=aFrsiF1H7d3wFadnlpk0fP07OQVW+J2+7AwTSjYEHJVx+WrruC6OFR0v3KgqEfMi/+mqpbMf0+Kr+hxC1tzXDj5yeTjkijr2JquTAtmQl0hLSFKb1cooSaz2w9B5uCkB33YwXEGiiPU6uBUbJ2WrzXSQ5zSYp2tZ+omMdSAI2YU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 10:14:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 10:14:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Add support to query partition metrics
Thread-Topic: [PATCH 1/4] drm/amd/pm: Add support to query partition metrics
Thread-Index: AQHbxkOdP0y0s4XloEiv0N6Kjnt7/bPVCh6w
Date: Fri, 16 May 2025 10:14:58 +0000
Message-ID: <BN9PR12MB525720F0B6394D94A7ACDDE0FC93A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250516091852.447786-1-lijo.lazar@amd.com>
In-Reply-To: <20250516091852.447786-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2c8689ce-5b42-4b6b-9c4c-f170c8f390d1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-16T10:14:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8590:EE_
x-ms-office365-filtering-correlation-id: 7433a84d-6e7f-4f8e-fc8a-08dd9462831f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aRC9FpgcErDjhnu0cFTVemsJJi+S/zF2caTg3BJxSshiGxbwwC8IO3Txi0Zg?=
 =?us-ascii?Q?4WD9uWtTN5KQ8m5lw8moxm4uHnESeQXul7Hk1L+DwUEQAM5ypbfmDSIGkIIa?=
 =?us-ascii?Q?UyYvoVC08ZYw1ahDpW430GpqEnLgBAicaWFqtb1BsGe7dyUrue4LxNUsB5QP?=
 =?us-ascii?Q?EZ/pBmiygtWLk5nzkdcmOz8omcwbNPPxNHw00pHJsm1VU4yIRPar6aOcZP8p?=
 =?us-ascii?Q?7X+RZ/t/aM5xUWvWumqVhO87PKkEEkV4QAFW4gUhPj0psQm02G1D+J+KVuSG?=
 =?us-ascii?Q?QxN7Drit01tPDOfWM1Rt/gGEbugf+xmwhYH++9KHopFcrfp4DryJs1VH/LdB?=
 =?us-ascii?Q?9hKtevTrJP2nCNG9ThpFRMUyk3AQQfY880H8OQCmPkNW1OJy3w8oUleUjIXt?=
 =?us-ascii?Q?l5YXWvROdr4JTykHNUNj3uVw3ZaHAl7WHhxVUdoSeVo0hErax0LdpXcGyKqz?=
 =?us-ascii?Q?YPzJItA7PAWc3w6ingWWn/bkCyR0Wb70V+tmziuBUNXkS0K/7ofqVTiMYeYs?=
 =?us-ascii?Q?Y9037MIJM7Bl3o50eEo77FECJvML6/N3YqBprpcYf8I8sXOTLjKORmUekqjw?=
 =?us-ascii?Q?ht8EUyccR2QbBu6DiJUUEsuj5JHLsUtOAiVgpy7h+gra++Qdwx7Bsu/c78St?=
 =?us-ascii?Q?tK1GavRHkg7PpELtgU1bZCu3v6dorYX7wPfWka+SiKOKGiGlD5f1m4YBH2DC?=
 =?us-ascii?Q?CIVYBcx1nAnJx0rRR3GJSWftP9JoNhFDePQ+2Ntmpv8yXefTpDoPkUEFjz6O?=
 =?us-ascii?Q?2gICoU+0s3+35+UWblJM7fy0gr82T1E/qJT+CkAX5FaZEy/MAdcsuZUJye1b?=
 =?us-ascii?Q?N8vNQs0cKdyoEO2eMJNQVer/ytIwrcqFy35QNxO387DuiaVVJUc4mnrWf/YY?=
 =?us-ascii?Q?8Udn711lK6VYI+vvs1DZmNL03JjQ9Y/0YkxVTSw6JdyuIb+mBfw1kDyJHA6t?=
 =?us-ascii?Q?cBOLRqNtQEcPaG1a5D+hyT0tonCBRQ41Q/ic71UH3D6JME9s88aNz0ltsPiu?=
 =?us-ascii?Q?K1e0Qg6M65C1Dl4W7ObYS7m14w/qkcqkNw5qE+fxrz8PLY+mE7MmcLAniXvK?=
 =?us-ascii?Q?75jCkiYlKDH8FmBIpOM+IHbVkLv0q0271V0ea69Y/Ar/E7CWIAog4NMFn7dV?=
 =?us-ascii?Q?yuuPGHNdDE+vIZQjGMBxad9Q20hqOM0JKPE8rUcJBmoJd3rV61riWKBLeLzh?=
 =?us-ascii?Q?yCfejuz4Kjg+jxA1YdeCm8b0tH49NJ0Fqm2xw7kZpTnI+OmJVj+ZC8tYqvcb?=
 =?us-ascii?Q?IsMsDoFhWB7s6/PbZHGa/SaJJVePhufibfvTx+ttDmd6XKt4Rr5meDZBhStK?=
 =?us-ascii?Q?S8NVXqAbuvUNdeW3ihfG/MRF0+Arh99TC0eTQCoXkJi8y8QSmqVMM4fUFtKn?=
 =?us-ascii?Q?7YjxPlb/Y8GKeWZO+Y6PVzgKVVg3tBJL2ArpUGtjEvV29DyEbzZ50B3O+Buj?=
 =?us-ascii?Q?V8BpnR6M6VVKD70qmBOaJ/JCob3W7mfxPhRYD0btUAelxkl71ZpI7h6j1CeD?=
 =?us-ascii?Q?7uGZ4YV0E0+fcmE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5SUC+PI7oPesfSXIHDGIS7dZLjrKUYtJHYfCW0/TNljDYPcGyWrcHFuzMpU?=
 =?us-ascii?Q?m3TQMSx0wKu9LKlkc4p/BDikEJ8UARyVlZWHvzaGMgwl8BH1LTbV4sEg8jgz?=
 =?us-ascii?Q?gXoilXq90VwIEaYaIMKaVr4ikBd5DGuusCJCRtxRI+hD6mS3QmroS5cA6avO?=
 =?us-ascii?Q?OC0gVsaQ1WdeKx974BERjaI9Vu5ZgCxKcdfocngI0k2r2G1w3VVmC+aVGG0h?=
 =?us-ascii?Q?3l4mmTcoUvdGnQb3Ywe6drTdU2oFGYZhYd5xmMaJzPKWDSlcvYoXPl78lNDw?=
 =?us-ascii?Q?F/LjTHNGN5Rd3Vogjz6U2n7XnYw8/m5NC3t874+ySjKi4ATxFR8z2Pm8ePhw?=
 =?us-ascii?Q?l4EckffrvKEUHFAjSmy63U+Yx+Wgbi+i22o7/s7f+9Ry/BFZcKcdLl60e+M6?=
 =?us-ascii?Q?rgIYDsbXLyRZJxUCUNEZrZZuWLO0UpLBmybIdXPmsyRsfOgT8wnhi8KIsxqC?=
 =?us-ascii?Q?v0TW6fE+j/VssPekMDhe/t1sh4AWr3hfG1wb6GEbk3bIcPsTOgr5/t/sGWEE?=
 =?us-ascii?Q?KaBau08n/61ib9/XB4QK1yBRLDbsrfNvnTkS4egM1AX4Jp36Yy69trkX8MPi?=
 =?us-ascii?Q?7E+xi5KzGO9FvpYuvOk4sM2BcNOQXChnBu2Kp470fe1uCDKTLdWn5my7YT36?=
 =?us-ascii?Q?cJve0A7bS5IreOYA4h8daxawebrkL+1Tn8MAWDXWeXsECwY/mXhkEw0ayvft?=
 =?us-ascii?Q?qrY2z6e70fMIlVVvApUiQceSbKDOEw1y/I/dLz3yTOuvChkoUVeLlMfYyb1Z?=
 =?us-ascii?Q?OdYCfZ54NXL57PLrnw3vPUTO2+49WvHw/Lf4zz9mu4eOr45NIKNAxHEqg135?=
 =?us-ascii?Q?TpY8qycdJbINVJ5xAQc6ft+fU0v2JC7wytSSosv7VciS4EJzNBmR1l3QYPkw?=
 =?us-ascii?Q?aVB8LvgZBI8T+4YeqTsyPC0JMKf9HbdWu0NHOet2w7BO0yOG05WvNooAC+w9?=
 =?us-ascii?Q?NQoHV0m0zMzuR8UBtTab5+2/sIr+o20SrJWZFduGoqOKfiuz5W5aAU8NfyS0?=
 =?us-ascii?Q?gsb3xYp1IPvORcedeTM+KXTFJPxh1HLDH4O2OHt+8tE3qHx9ArcDbEbo1xnJ?=
 =?us-ascii?Q?B3GhU5oQWw2iodcydNe88g0dnXTCo+S3/nTp6d7bdLDAXy7y2bE2SA36uYe7?=
 =?us-ascii?Q?Y3qMuB2oyQRsPx/hFcODMCfr7O6Ka7tffrD4Ol469vNLNVj76AZw7VMlZjcB?=
 =?us-ascii?Q?kRrINfHYdzJQgyEEKLb5X5RcpcpH6tFbwfRI5h/1tayEA6UpEuO5RFUQI6pX?=
 =?us-ascii?Q?hdSp6/JnVhSX45ycJ/84O2/aj7rl+56CFiLV8rjYbPW8Hc/OReyDAJaQ4Vvs?=
 =?us-ascii?Q?3hyVb3fVjIYoW3jV0yHzvp122RqhrGPYhuBi/2Xkup8X0uFy53SvZltWCVFk?=
 =?us-ascii?Q?oau7DI6rwFoamDsEYfBoEKhSPNPySarZRLANmOsuBFKWnFMffGkpqyh9qhAJ?=
 =?us-ascii?Q?ZESVNo7I5VPVhCgThipfwg7Dh4yO9I0uHRVJa/mRdbwVDBgD8VycrD38zJ8T?=
 =?us-ascii?Q?S3i5mRx3ljFosXXQUboD2Jq2S6kOwoj3JMiv+odJdBz6x/B5eYTwXnLQrb5B?=
 =?us-ascii?Q?BPv50VAEwRb08U+S2KQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7433a84d-6e7f-4f8e-fc8a-08dd9462831f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 10:14:58.3525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgr9HbuQ17sHzoewsFDyVFNv4t3p8rh1Ep90jzRV+hX364hGvluoP7PfND2S0TmeZ2njuCvA2jvNO3F1b2Auig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 16, 2025 17:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Kamal, Asad <Asad.Kamal@=
amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Add support to query partition metrics

Add interfaces to query compute partition related metrics data.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 24 ++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 32 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 10 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 12 +++++++
 6 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 9538357b6ba6..30c532ab11e4 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -503,6 +503,7 @@ struct amd_pm_funcs {
        int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
        int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
        ssize_t (*get_gpu_metrics)(void *handle, void **table);
+       ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
        ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t siz=
e);
        int (*set_watermarks_for_clock_ranges)(void *handle,
                                               struct pp_smu_wm_range_sets =
*ranges); @@ -1601,4 +1602,27 @@ struct amdgpu_pm_metrics {
        uint8_t data[];
 };

+struct amdgpu_partition_metrics_v1_0 {
+       struct metrics_table_header common_header;
+       /* Current clocks (Mhz) */
+       uint16_t current_gfxclk[MAX_XCC];
+       uint16_t current_socclk[MAX_CLKS];
+       uint16_t current_vclk0[MAX_CLKS];
+       uint16_t current_dclk0[MAX_CLKS];
+       uint16_t current_uclk;
+       uint16_t padding;
+
+       /* Utilization Instantaneous (%) */
+       uint32_t gfx_busy_inst[MAX_XCC];
+       uint16_t jpeg_busy[NUM_JPEG_ENG_V1];
+       uint16_t vcn_busy[NUM_VCN];
+       /* Utilization Accumulated (%) */
+       uint64_t gfx_busy_acc[MAX_XCC];
+       /* Total App Clock Counter Accumulated */
+       uint64_t gfx_below_host_limit_ppt_acc[MAX_XCC];
+       uint64_t gfx_below_host_limit_thm_acc[MAX_XCC];
+       uint64_t gfx_low_utilization_acc[MAX_XCC];
+       uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
+};
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 2148c8db5a59..a130afb22826 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2019,3 +2019,35 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_dev=
ice *adev,

        return ret;
 }
+
+/**
+ * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
+ * partition
+ * @smu: Pointer to the SMU context.
+ * @xcp_id: Identifier of the XCP for which metrics are to be retrieved.
+ * @table: Pointer to a buffer where the metrics will be stored. If
+NULL, the
+ * function returns the size of the metrics structure.
+ *
+ * This function retrieves metrics for a specific XCP, including
+details such as
+ * VCN/JPEG activity, clock frequencies, and other performance metrics.
+If the
+ * table parameter is NULL, the function returns the size of the
+metrics
+ * structure without populating it.
+ *
+ * Return: Size of the metrics structure on success, or a negative error c=
ode on failure.
+ */
+ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
+                                  void *table)
+{
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       int ret =3D 0;
+
+       if (!pp_funcs->get_xcp_metrics)
+               return 0;
+
+       mutex_lock(&adev->pm.mutex);
+       ret =3D pp_funcs->get_xcp_metrics(adev->powerplay.pp_handle, xcp_id=
,
+                                       table);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 2c3c97587dd5..c0f9ecb97fcc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -524,6 +524,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_dev=
ice *adev,  int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *ade=
v,
                                      long *input, uint32_t size);
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
+                                  void *table);

 /**
  * @get_pm_metrics: Get one snapshot of power management metrics from PMFW=
. The diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/=
drm/amd/pm/swsmu/amdgpu_smu.c
index 475555af3e75..de794bdb7ae3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3758,6 +3758,19 @@ int smu_set_pm_policy(struct smu_context *smu, enum =
pp_pm_policy p_type,
        return ret;
 }

+static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void
+*table) {
+       struct smu_context *smu =3D handle;
+
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;
+
+       if (!smu->adev->xcp_mgr || !smu->ppt_funcs->get_xcp_metrics)
+               return -EOPNOTSUPP;
+
+       return smu->ppt_funcs->get_xcp_metrics(smu, xcp_id, table); }
+
 static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        /* export for sysfs */
        .set_fan_control_mode    =3D smu_set_fan_control_mode,
@@ -3816,6 +3829,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .get_uclk_dpm_states              =3D smu_get_uclk_dpm_states,
        .get_dpm_clock_table              =3D smu_get_dpm_clock_table,
        .get_smu_prv_buf_details =3D smu_get_prv_buffer_details,
+       .get_xcp_metrics                  =3D smu_sys_get_xcp_metrics,
 };

 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,=
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/amdgpu_smu.h
index 69a48bd041e7..e60f8942b001 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1495,6 +1495,16 @@ struct pptable_funcs {
         */
        int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
                                        struct freq_band_range *exclusion_r=
anges);
+       /**
+        * @get_xcp_metrics: Get a copy of the partition metrics table from=
 SMU.
+        *
+        * @xcp_id: compute partition id
+        * @table: Pointer to which table needs to be copied, if NULL retur=
ns
+        * the size
+        * Return: Size of table
+        */
+       ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
+                                  void *table);
 };

 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index d843cced8069..31660bcb7938 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -52,6 +52,18 @@
                header->structure_size =3D sizeof(*(ptr));       \
        } while (0)

+#define smu_cmn_init_partition_metrics(ptr, frev, crev)                   =
  \
+       do {                                                               =
 \
+               typecheck(struct amdgpu_partition_metrics_v##frev##_##crev,=
 \
+                         typeof(*(ptr)));                                 =
 \
+               struct metrics_table_header *header =3D                    =
   \
+                       (struct metrics_table_header *)table;              =
 \
+               memset(header, 0xFF, sizeof(*(ptr)));                      =
 \
+               header->format_revision =3D frev;                          =
   \
+               header->content_revision =3D crev;                         =
   \
+               header->structure_size =3D sizeof(*(ptr));                 =
   \
+       } while (0)
+
 extern const int link_speed[];

 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
--
2.25.1


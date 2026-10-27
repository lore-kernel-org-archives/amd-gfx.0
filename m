Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D7606A33F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rWzrk324
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E5310F6AD;
	Tue, 27 Oct 2026 15:48:50 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B661410F6AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF4ksVnup4cGYS8DkgDgUCXd/CXyPeMStP9Jdx7SiG0fziqj9fqe7WW5MbUPUhrjEUh5FO7wVlbMeJKSKWs7QI1iNbme36rXl13ytrTL5VKH3b7u1pCh65Q7h/WvburoK7DZkDCecqAYSYKtZwUBym0vtvnVoq5h0+CLev32L9STkLQQQ5oXZajcp738xHiY3bOaZgofpx7Xu4S4w8gvTVpEl5xktkBkibKypbecDfHn6X9dCApmZMRDnn1esm9m1hSZQEMefZ8pJWfpkXUcFYpkwXd62/CQTz8rBu/bj0Omz/2P8qG4kKOoEIgSVqjiiBRyQ1dKpXCgYeKgo6hH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKIKM81xsi2az6bI0bOMc/qz3ecB/4G3owyTWzPekVQ=;
 b=JxhJayonMTht2A0UcUWNUN70wM6lj/n/Zzi36HLz9Kvrv6SNeTHIt2F73gqg6XLzns2aPqSzEkfxPwoK0rCPtIDhG0N8Jdjm1ptIJQLK4Eiq8X8qbB66YYpS6m2S7qLCFTd+lQxMxczqqCbNYH4kKCgdCjv8/qrrbV9icetLS4cysnJhGLZNQP7N5BwhqvJzhInldXZUekjTjMlOhMfVVrPPa8JNlYAoModeCXaIT/5Udc/9GCWPiFrYQCQQpv4lsBt1Tq8gYRXtOv7JGKGtW8Kw95x7g6X406w61Y4x8zTmHghfFGCrccdfTNsY/xdNlhZFNb0GJysMkfQTUkVoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKIKM81xsi2az6bI0bOMc/qz3ecB/4G3owyTWzPekVQ=;
 b=rWzrk324NXGjXIpvj7aifMLXc+2Vrb0hUuL9/of3lPtzcmceAiiJNNuVLm6WVRIOb7MLWWS/dK1g6W+IyZsDedtDWLUNHQOhND39ouGXaCzKDeOLwDE3azcLBME2PxEuhIRzym0bzu2cVcHEfwQPEkWwCEq747sjRUoGQWnH93s=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 15:48:38 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:48:38 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Mishra, Apurv" <Apurv.Mishra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Welton, Benjamin" <Benjamin.Welton@amd.com>,
 "Tang, Jason (Markham)" <Jason.Tang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Topic: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Thread-Index: AQHdZXp2AT596T2lz0KFpevbFPlQ7LcRih2g
Date: Tue, 27 Oct 2026 15:48:38 +0000
Message-ID: <BY5PR12MB41791F254F2D1CC3230022F0FD602@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20261026184707.103933-1-Apurv.Mishra@amd.com>
In-Reply-To: <20261026184707.103933-1-Apurv.Mishra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T15:47:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|MW4PR12MB7334:EE_
x-ms-office365-filtering-correlation-id: db9989ac-3aea-4ff5-6614-08df3441c489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|5023799004|261026140227099003|38070700021|11063799006|56012099006|261021123027099003|261009223027099003|261022075727099003|261009221227099003|261022105027099003|10067099003|261021121427099003|261026121527099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: HRP3OrW/wzQh74SXqQKg/wrHdSplT90OmLPpMX8LNrUVS+OaU1RqlbsMA0ayWl4I7Q5R4Cv7l7klLhqKv/R3Xh2tyI5B/E7IkkMA7vD9k6A6aFh/6tcAmvU4hqqiM7nx2ppVJ0SK8a9PeVr4W33g7l87mM+faa2W1N6RHOgWSk2mqNflTuLMGpsK9QCHdnLPC+Uwl3m7aT+P2ZXvuNTV6JadbZTHMBoejNPn4HYAWeVBW0fqtBZrXKOIYkK+I/QcyRqvETi6feXDXEKcnRtUMY/rluUEMZPvwrJ0Xd9h4CpKAMrdMAXfY1ZhXYrDU3jUEAFh/1xuTkbrT5yne0VgaEAtdlnkdj+dMzibYXNsl6uhMrnjfIfxH2SAvhOy2tM12a5+6soSEwRPoDrcVCoUN+bHuUjs1e7GiQSOcsuSLpHw2fZlwoYVv0EvF+DB0/9FWrjH916rUtP+lvYXyIUoYTC/fT1FmfYEV8GEQG32WwgYhNxcGOslUAoGdVfgXjeQ1M3ZQA7HiMVnmCHJKDQMhk54xKplrJ7bIyZEUydSHcy34XZB0fWTydncdhVv+o9ML8P+JHnV1clP2kQAFxJrr5J7VDCuO6eKOHsjF4N7dzhEWYaHq3vDgej6xsB3pbj3sM99iQgMOnf4SvQdi7w5GE6yhtBaR8JBsAm21Fb7V8ikgSwVDuSIzRyV9tHOfXoOvNxntbuHPw510xWPXPluw/EUgmhmRv2LgSmJ1oWwXPc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(5023799004)(261026140227099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003)(10067099003)(261021121427099003)(261026121527099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YjDt4icyqMM8pryf1+iRJTLN0Tj63wVyi+hHxw7WRKRnOqaZxjX5ejQJ17ji?=
 =?us-ascii?Q?YIRhtCFcoR8cfuxU65etIE8uMNgIJy5Yf4MBfXeTvOIoYkLC/BfO8N8zgAXD?=
 =?us-ascii?Q?T5CVQuZcQFZuUF5plwthGHJ1O6w2mh++PVIjdPsvORPfOEen5JPFZyMjwBrK?=
 =?us-ascii?Q?oxshFELWULNLXDneXSuis4VpG9Di7D4dsSWsr9vC/7l/NBPHPVBRJwd/Wrry?=
 =?us-ascii?Q?TKwdkgcVM/NMTayevvbgF6vTMwTMnk+xbbLPkZdrF1fgDyBmpTZePZiV55eo?=
 =?us-ascii?Q?K7CBLhPL/ZOqJzHkVMgnY+wuleEvOZOQjLxjI5/R8izoGdu6Hh+MlHnxinnh?=
 =?us-ascii?Q?FUdTmCl96Bmp9shSqna3xmyga7NAu+OAIsebFp2wknCBqAqx2DF2PNldMGAP?=
 =?us-ascii?Q?MEKvpf34suwBh0Bo3ZYf7k/oOcBPTCiDHjlke9REgWvNeVgnmY0DG4yhP3qN?=
 =?us-ascii?Q?xsfpAB6rKUJknMxwtueqYYV+RVLwWdgutu/L8oThbBP1QTBkH2mu4FCmSghM?=
 =?us-ascii?Q?FIG7C914J8RpoQpfFpPyOP97VaEDOQTeTPiyFRSIBwkswPtMT8QPGbUniuSZ?=
 =?us-ascii?Q?9rWDWeK9GNJGxVGbLgsDQBxudyeI2taGFXd9M67K97+6gWEcrSqMmmYnLnYE?=
 =?us-ascii?Q?xMFatRH3O/U/J2MDPmuDMMMxVDGWfH0twW4cLz25+y3m2s2SY3LPIEYqnmqL?=
 =?us-ascii?Q?BvRhw2UJ3QUA2LYmqXUkVWUSP417px7dH9T3XAcaZCFW1cnpokF2EJp24Fn0?=
 =?us-ascii?Q?BnhSZGGhIsr0H6rAmLeQOQkbF78RIEYhoUE0poX5R0lCMSEPLqrSQoxcg8p9?=
 =?us-ascii?Q?SSM1HELkledgQ+fAvTLElcADB+YI1irWk2c+sS1WchfBz+xJatF833fwQ/bt?=
 =?us-ascii?Q?hqNfWly86YmHhFVCfZiRJYufWNWX74kInPC4+BbQzL2Kj39uoBnAQntTtrDg?=
 =?us-ascii?Q?rutulN2r2f6qVE2T5pqWF5O9Y/j5SdGVuE3bRkF1aDKEwJs5WjNCoehJV16H?=
 =?us-ascii?Q?R5tw8ZT9Djqjr6OBYasXzM32knC4BM83BlPbKA86t6G9Si/VsWtzSO9J+mIQ?=
 =?us-ascii?Q?HY/0X1pQ30dqyNCZHopLXkm8utnxn1GVgc8AbNkGhd6225rzMR+VAwZ86F8k?=
 =?us-ascii?Q?po5Ahggm9l/4yOdH7anPsoBCGgKEH2qwSitnbTFhmSYD4E6Z6jSl6klT/tRH?=
 =?us-ascii?Q?vDN1WEdbnMO3QegyHSD9hBARwjADLJ7CgbQq5n558yZPAVc+KTZ/NebvYThs?=
 =?us-ascii?Q?XVtwxy6pSQb6n1ImXmdtXtUEFZMPCiAphi03hG7S/Wr/F70X9FI44mtmc3ST?=
 =?us-ascii?Q?rahUNLC+HjEldAcnrB5k3N1lAP9lYmOyZM1RUYZqb+Sf3GeE+E8RZryV72LV?=
 =?us-ascii?Q?bXHcWvArBIHbDsy1i8nbpf3uXHctHp/JwdkzX6jV+H/t8/MZri7mgffw3v2a?=
 =?us-ascii?Q?lo+/hQIDE2z2BqZYEoT6A+LZS21EmlOr99YEPJbHzFe65bvOQSDWPglDMJgs?=
 =?us-ascii?Q?3WQGREKaN1qNHTo/c6qJOF+hvKCIFHfs1WLcHIL2UGfBdA4yKPrlOv1yW4SF?=
 =?us-ascii?Q?31Ao5bhA1tTRSlpoiznXa/ZwtPZOhvA5ckPwnGanPvb2L66Z+hQfktmgQ82X?=
 =?us-ascii?Q?dHI5eWd5Q/NYUOF0iIIECJ2Qc0vZ+Y1fQ7rSpswkjLuxW1T2PNLQmXHaQlbF?=
 =?us-ascii?Q?9ZzHswqQpw+VAqKBEpyoooqJ0ObQS53TwwRAxW6XEn/6W7VB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9989ac-3aea-4ff5-6614-08df3441c489
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 15:48:38.4313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g9TSmKehFmyAVA3idj/hmO6xOHAnBkU6U+gfTGa9/grkzj737pUM94OmIzpK4YkyDSKzVHffTbkzr+L+1MIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Add Jason T. for test results.

-----Original Message-----
From: Mishra, Apurv <Apurv.Mishra@amd.com>
Sent: Monday, October 26, 2026 11:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.c=
om>; Kuehling, Felix <Felix.Kuehling@amd.com>; Welton, Benjamin <Benjamin.W=
elton@amd.com>; Mishra, Apurv <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC reques=
ts

Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because RLC_C=
GTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing workaround=
 (STABLE_STD) needs root and pins clocks.

Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the perfmon =
clock on per XCC, holds GFXOFF off while overridden, and restores the previ=
ous state on last release, resume and reset.

Use it from KFD_IOC_PROFILER_PMC:
- lock=3D1 (device mode, CAP_PERFMON): held until unlock or exit.
- lock=3D0, perfcount_enable=3D1 (dispatch mode): no CAP_PERFMON needed,
  held until process exit.

No DPM change, no new ioctl, no struct change.
Bump KFD_IOC_PROFILER_VERSION_NUM to 2.

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 79 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 30 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  5 ++
 include/uapi/linux/kfd_ioctl.h             | 10 ++-
 10 files changed, 198 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5069042b5279..551051c5e6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2773,6 +2773,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)

        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+       amdgpu_gfx_perfmon_clk_restore(adev);

        r =3D amdgpu_dpm_reapply_umd_profile(adev);
        if (r) {
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        mutex_init(&adev->srbm_mutex);
        mutex_init(&adev->gfx.pipe_reserve_mutex);
        mutex_init(&adev->gfx.gfx_off_mutex);
+       mutex_init(&adev->gfx.perfmon_clk_mutex);
        mutex_init(&adev->gfx.partition_mutex);
        mutex_init(&adev->grbm_idx_mutex);
        mutex_init(&adev->mn_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 0ae6e990c310..b1b3fbb49a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,85 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_dev=
ice *adev, bool enable)
        amdgpu_gfx_do_off_ctrl(adev, enable, true);  }

+/* Force the perfmon clock on, or restore the saved state; @save
+records the old one. */ static void amdgpu_gfx_perfmon_clk_program(struct =
amdgpu_device *adev,
+                                          bool force_on, bool save)
+{
+       int i, num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+
+       amdgpu_gfx_off_ctrl(adev, false);
+       for (i =3D 0; i < num_xcc; i++) {
+               bool on =3D force_on || test_bit(i, &adev->gfx.perfmon_clk_=
restore_mask);
+               bool in_safe_mode =3D adev->gfx.rlc.in_safe_mode[i];
+               bool was_on;
+
+               if (!in_safe_mode)
+                       amdgpu_gfx_rlc_enter_safe_mode(adev, i);
+               was_on =3D adev->gfx.funcs->set_perfmon_clk_override(adev, =
i, on);
+               if (!in_safe_mode)
+                       amdgpu_gfx_rlc_exit_safe_mode(adev, i);
+
+               if (save)
+                       assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, =
was_on);
+       }
+       amdgpu_gfx_off_ctrl(adev, true);
+}
+
+/*
+ * Refcounted override that keeps the perfmon clock on for profilers.
+The last
+ * put restores the previous state. GFXOFF is held off meanwhile, as a
+GFXOFF
+ * exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it=
.
+ */
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool
+enable) {
+       int r =3D 0;
+
+       if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
+           !adev->gfx.funcs->set_perfmon_clk_override)
+               return -EOPNOTSUPP;
+
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
+       if (enable) {
+               if (!adev->gfx.perfmon_clk_override_count++) {
+                       amdgpu_gfx_off_ctrl(adev, false);
+                       amdgpu_gfx_perfmon_clk_program(adev, true, true);
+               }
+       } else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
+               r =3D -EINVAL;
+       } else if (!--adev->gfx.perfmon_clk_override_count) {
+               amdgpu_gfx_perfmon_clk_program(adev, false, false);
+               amdgpu_gfx_off_ctrl(adev, true);
+       }
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+
+       return r;
+}
+
+/*
+ * While overridden, record the requested state for the final restore
+instead
+ * of programming it. Returns true if the caller must skip the register wr=
ite.
+ */
+bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int
+xcc_id, bool on) {
+       if (!READ_ONCE(adev->gfx.perfmon_clk_override_count))
+               return false;
+
+       assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
+       return true;
+}
+
+/* Re-apply the override after resume/reset reprogrammed clock gating.
+*/ void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev) {
+       if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
+               return;
+
+       mutex_lock(&adev->gfx.perfmon_clk_mutex);
+       if (adev->gfx.perfmon_clk_override_count)
+               amdgpu_gfx_perfmon_clk_program(adev, true, false);
+       mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)  =
{
        int r =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..1690eb3e37bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
                                 u32 queue, u32 vmid, u32 xcc_id);
        void (*init_spm_golden)(struct amdgpu_device *adev);
        void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable=
);
+       /* set the perfmon clock, returns its previous state */
+       bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xc=
c_id,
+                                        bool on);
        int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
                                   struct amdgpu_gfx_shadow_info *shadow_in=
fo,
                                   bool skip_check);
@@ -503,6 +506,11 @@ struct amdgpu_gfx {
        uint32_t                        gfx_off_residency;  /* last logged =
residency */
        uint64_t                        gfx_off_entrycount; /* count of tim=
es GPU has get into GFXOFF state */

+       /* perfmon clock override for profilers */
+       struct mutex                    perfmon_clk_mutex;
+       uint32_t                        perfmon_clk_override_count;
+       unsigned long                   perfmon_clk_restore_mask; /* per XC=
C */
+
        /* pipe reservation */
        struct mutex                    pipe_reserve_mutex;
        DECLARE_BITMAP                  (pipe_reserve_bitmap, AMDGPU_MAX_CO=
MPUTE_QUEUES);
@@ -635,6 +643,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device =
*adev,
                                        u8 me_id, u8 pipe_id, u8 queue_id);=
  void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);  void =
amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool
+enable); bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev,
+int xcc_id, bool on); void amdgpu_gfx_perfmon_clk_restore(struct
+amdgpu_device *adev);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)=
;  int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_comm=
on_if *ras_block);  void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev,=
 struct ras_common_if *ras_block); diff --git a/drivers/gpu/drm/amd/amdgpu/=
gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..0a80dacd0932 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);  static void gfx_v11_0_userq_priv_fault_work(struct=
 work_struct *work);  static void gfx_v11_0_update_perf_clk(struct amdgpu_d=
evice *adev,
                                      bool enable);
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);

 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)  { @@ -1147,6 +1149,7 @@ static const struct amdgpu_gfx_funcs =
gfx_v11_0_gfx_funcs =3D {
        .read_wave_vgprs =3D &gfx_v11_0_read_wave_vgprs,
        .select_me_pipe_q =3D &gfx_v11_0_select_me_pipe_q,
        .update_perfmon_mgcg =3D &gfx_v11_0_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v11_0_set_perfmon_clk_override,
        .get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
        .detect_hung_queue =3D &gfx_v11_0_detect_hung_queue, @@ -5499,23 +5=
502,32 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev,=
 int xcc_id)
        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);  }

-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
-                                     bool enable)
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
+                                     bool enable)
+{
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+           amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
+               return;
+
+       gfx_v11_0_set_perfmon_clk_override(adev, 0, !enable);
 }

 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev, diff --=
git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/g=
fx_v12_0.c
index d334fb805020..8774dfd64022 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id);  static void gfx_v12_0_userq_priv_fault_work(struct=
 work_struct *work);  static void gfx_v12_0_update_perf_clk(struct amdgpu_d=
evice *adev,
                                      bool enable);
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);

 static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
                                        uint64_t queue_mask)
@@ -957,6 +959,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_func=
s =3D {
        .select_me_pipe_q =3D &gfx_v12_0_select_me_pipe_q,
        .detect_hung_queue =3D &gfx_v12_0_detect_hung_queue,
        .update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v12_0_set_perfmon_clk_override,
        .get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
        .get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,  }; @@ -393=
8,23 +3941,32 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device=
 *adev,
        WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);  }

-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
-                                     bool enable)
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
+                                     bool enable)
+{
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+           amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
+               return;
+
+       gfx_v12_0_set_perfmon_clk_override(adev, 0, !enable);
 }

 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, diff --g=
it a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gf=
x_v12_1.c
index 1589fc6413af..0b9e41c26182 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -211,6 +211,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_dev=
ice *adev,
                                      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
                                         bool enable, int xcc_id);
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *ad=
ev);  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
        struct amdgpu_device *adev, bool enable, int xcc_id, bool force); @=
@ -746,6 +748,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs=
 =3D {
        .read_wave_vgprs =3D &gfx_v12_1_read_wave_vgprs,
        .select_me_pipe_q =3D &gfx_v12_1_select_me_pipe_q,
        .update_perfmon_mgcg =3D &gfx_v12_1_update_perf_clk,
+       .set_perfmon_clk_override =3D &gfx_v12_1_set_perfmon_clk_override,
        .get_xccs_per_xcp =3D &gfx_v12_1_get_xccs_per_xcp,
        .ih_node_to_logical_xcc =3D &gfx_v12_1_ih_to_xcc_inst,  }; @@ -3155=
,23 +3158,32 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_de=
vice *adev,
                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVE=
RRIDE, data);  }

-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
-                                         bool enable, int xcc_id)
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+                                              int xcc_id, bool on)
 {
        uint32_t def, data;

-       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-               return;
-
        def =3D data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT=
_MGCG_OVERRIDE);

-       if (enable)
-               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;
-       else
+       if (on)
                data |=3D RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+       else
+               data &=3D ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK=
;

        if (def !=3D data)
                WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVE=
RRIDE, data);
+
+       return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
+                                         bool enable, int xcc_id)
+{
+       if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+           amdgpu_gfx_perfmon_clk_defer(adev, xcc_id, !enable))
+               return;
+
+       gfx_v12_1_set_perfmon_clk_override(adev, xcc_id, !enable);
 }

 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *ade=
v, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_chardev.c
index 6c710e4a5220..8e3104ce181a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3410,6 +3410,7 @@ static inline int profile_lock_device(struct kfd_proc=
ess *p,
        if (op =3D=3D 1) {
                if (!kfd->profiler_process) {
                        kfd->profiler_process =3D p;
+                       amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
                        status =3D 0;
                        mutex_unlock(&kfd->profiler_lock);
                        if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_SU=
PPORTED) { @@ -3427,6 +3428,7 @@ static inline int profile_lock_device(stru=
ct kfd_process *p,
                }
        } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
                kfd->profiler_process =3D NULL;
+               amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
                status =3D 0;
                mutex_unlock(&kfd->profiler_lock);

@@ -3444,6 +3446,30 @@ static inline int profile_lock_device(struct kfd_pro=
cess *p,
        return status;
 }

+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t
+gpu_id) {
+       struct kfd_process_device *pdd;
+       struct kfd_dev *kfd;
+       int r =3D 0;
+
+       mutex_lock(&p->mutex);
+       pdd =3D kfd_process_device_data_by_id(p, gpu_id);
+       mutex_unlock(&p->mutex);
+
+       if (!pdd || !pdd->dev || !pdd->dev->kfd)
+               return -EINVAL;
+
+       kfd =3D pdd->dev->kfd;
+       mutex_lock(&kfd->profiler_lock);
+       if (!pdd->perfmon_clk_req) {
+               r =3D amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
+               pdd->perfmon_clk_req =3D !r;
+       }
+       mutex_unlock(&kfd->profiler_lock);
+
+       return r;
+}
+
 static inline int kfd_profiler_pmc(struct kfd_process *p,
                                   struct kfd_ioctl_pmc_settings *args)  { =
@@ -3451,6 +3477,10 @@ static inline int kfd_profiler_pmc(struct kfd_proces=
s *p,
        struct device_queue_manager *dqm;
        int status;

+       /* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON neede=
d */
+       if (!args->lock && args->perfcount_enable)
+               return kfd_profiler_perfmon_clk(p, args->gpu_id);
+
        /* Check if we have the correct permissions. */
        if (!perfmon_capable())
                return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index f0ce5fc4a138..f753ecae842f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -895,6 +895,8 @@ struct kfd_process_device {
        u32 pasid;
        /* Indicates this process has requested PTL stay disabled */
        bool ptl_disable_req;
+       /* Holds a perfmon clock override until the process exits */
+       bool perfmon_clk_req;
 };

 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd) diff=
 --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_process.c
index ac18c2be6ecb..7a8da8d36962 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1180,6 +1180,11 @@ static void kfd_process_profiler_release(struct kfd_=
process *p, struct kfd_proce
        if (pdd->dev->kfd->profiler_process =3D=3D p) {
                pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
                pdd->dev->kfd->profiler_process =3D NULL;
+               amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false)=
;
+       }
+       if (pdd->perfmon_clk_req) {
+               amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false)=
;
+               pdd->perfmon_clk_req =3D false;
        }
        mutex_unlock(&pdd->dev->kfd->profiler_lock);
 }
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h index 564faefe6978..d7fb52c30df0 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1558,7 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
        };
 };

-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*
+ * KFD_IOC_PROFILER_VERSION_NUM history:
+ * - 1 - initial version
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until =
the
+ *       lock is released or the process exits. lock =3D=3D 0 with
+ *       perfcount_enable =3D=3D 1 forces it on without CAP_PERFMON and wi=
thout
+ *       locking, until the process exits
+ */
+#define KFD_IOC_PROFILER_VERSION_NUM 2
 enum kfd_profiler_ops {
        KFD_IOC_PROFILER_PMC =3D 0,
        KFD_IOC_PROFILER_VERSION =3D 2,
--
2.43.0


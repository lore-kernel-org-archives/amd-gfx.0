Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF1ECA0EE0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 03:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA29D10E0E3;
	Thu, 14 Aug 2025 03:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QBbYsNz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D884510E0E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 03:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bufV3dIOd42BV8MhNZfsRlo5GnE3r4C64cDR1SYLl3mLwLRzk54zFHTW5jihTpUrDdAb8tvf95UBHIr1nXQXAi1HgduyA+w+lJ9aMa2g33xn+90rVBA51TkE2SyJ20BriReCaNmYWGY2TsVmFZBbC15zfGaU834erAgRu0AD7fx9uzQsFWLBBGhdVRXqz3hDkn33iT+KB4mqZjxVCJtdSCEL/6HV91Maj579krNhaVvfdJjMPKgHO5UkZzVZJtEOpgCQvbD3MujNQGTzc0Lu/l4vxUTrEMGDCFX16Bc7yznTKsjGzhJ8L4GzI54IWbouoMGBnFjo0GC0yJS/N6ovoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3n+iiw3mUOC02TdbfVffmkdrCZnDXsh7bXAnPyexmU=;
 b=f6ApTTjqemX4fzVgUUWmAoj0Wuf0RpvEbY9U1W+/22MlqSN0XjfgW3orQiuiR143wwygDXcdTdkb0cLDMDpGba/vVM/6emsPdetncMfGg0memopJd/N3N7GnmyXFFoZoiQ6BnmEpGJed2qJIQHTZ38y3ojIh655RN00z5ZfVxiCfLDswTiGSeXp5l9eKSfGixnSWkQ9yTwP50ENxhqv6myRTXaaHITEtULKJt8EGVMD+VT32CCWar634l8TRsDNyFtQPg93cbZWulPc5ig+Fsykl1adKWDHt9DG7suXcN9X2rcJDe3N+/pcIthNKKHYdNfjuRKJ/E8g0qhqdr2sNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3n+iiw3mUOC02TdbfVffmkdrCZnDXsh7bXAnPyexmU=;
 b=5QBbYsNz2mRQiZ9iafYhj9KWuUHVYIhfnhtHN5MY4S9YEsP6nVklI5ZcajtElApJTPlBCoopebfomA6NyyPFainV/zPq5U79SlDlJA0lUPi37U8Rn4ehZVd3dkbJCgUxDrYw7CRGo9+Jp/Caw7fsgPy7B9mhCVH2ZqPsb/Ijvkk=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 03:05:44 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 03:05:44 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 3/3 v2] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 3/3 v2] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcDD4MavBTbZYneEWaMt6KJ3X2cLRhdzAQ
Date: Thu, 14 Aug 2025 03:05:44 +0000
Message-ID: <CH2PR12MB4215E0FEA2D8DFB4C7C23237FC35A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250813103540.264516-1-cesun102@amd.com>
In-Reply-To: <20250813103540.264516-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-14T03:02:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SJ2PR12MB7920:EE_
x-ms-office365-filtering-correlation-id: ef79cd86-355e-470c-19b5-08dddadf75aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p0owbWW6TA2RzCaeR3dfPHmfn3QgP/kVGtv//bA5ckYIxFTCcU/r96N9CfvU?=
 =?us-ascii?Q?hv7HrUvCPOXUXXavbLnzcDM/zH2s0zHl6YXXV1z4weWBm4iLIxqm5h9MtDNy?=
 =?us-ascii?Q?g+UxUyrSrsyj4bBvYyfWJygGEj8cBQRCKRimm0nsTVh0l+D5lUyyJ+Mfr1wJ?=
 =?us-ascii?Q?Jdxc7pgD2Cp1Qz++bjB2y4y+7UmObFOsOKOuQD9hkC8OImtSdN56PjFLhG2d?=
 =?us-ascii?Q?SiQb2VSUoYeM9HGB4kPs3ePE16fxNHncrppdPw8lNqA2XE86tENb0T374TpW?=
 =?us-ascii?Q?CgHjuUiVPUM0I+kA4gIMUmLcpedMp77EgohUvzoIeR40T5AfiIvK3hJ5prM+?=
 =?us-ascii?Q?dajtHy4G9LLl6DfKWsc+gAfabQ/B/86FdZXsDnDUY6gJ5Qse5yFGVAXOs/uM?=
 =?us-ascii?Q?CtI3fIpY2c6E6bkNrllJICqITLA0y/UU9K0eC0YoLkO5Crgff6w4VI9nozPD?=
 =?us-ascii?Q?ueB1ludCl5dfR+HUBg56V15t9L+QhpeV0kGbrXXz5amFWdH48vBSpSMqJut/?=
 =?us-ascii?Q?aR1JHNxy7AvqLV8FZI7DdMJ48kMD7gQ0hfGhXlQ5AGUEzquoSLwDRYG/p3xn?=
 =?us-ascii?Q?VA0ASU5/xYf0aM3mUg6nHRuxWQlNPagxxCLs69S2umy5TzneIh6pbaMFfBzM?=
 =?us-ascii?Q?PUpUa4471SVClpwriyxeu5vqKEouBcXefGrBsbXtGj9sd/z1bRioAsl66gxV?=
 =?us-ascii?Q?c2sZs21qNP3gWmorcy96BAvE1KAsx2ZKgGHFzFbWJXs1xxF44uJ6dRlQjcpu?=
 =?us-ascii?Q?jnDPtVk2U4jhBYM146/qcpf3tHLufarjBcRlLiSDRLpdvzkh3MoxgOWCk6wL?=
 =?us-ascii?Q?A6Yea/boo1AFwUTl3J1pfwH91s9aMwRZz1ZhQ3RvQbOD5uUKQjCiW2ghFf1r?=
 =?us-ascii?Q?Bd7k/TcXbYH4e/DoRaCHfkAVUBgKSYfIkayJT/K9z0lJrtm3+Jpb3pZ7njCN?=
 =?us-ascii?Q?o5U6+vArsXpAgt8rNBrHet7SXbJM9Gz+RN/qxG/5RJHdV90bCpnFXJjwk/E/?=
 =?us-ascii?Q?+Hr65n/hfMcdLsz69Sh6jvPGoVuZnh6bB+jfH0OodMMWUElCJzA++3hJLKQJ?=
 =?us-ascii?Q?HD8ZO67VajjIehE9PazNgdSUOXTCJqbpKxmspwycwBIM0ZXqkI6eaZYoFLSc?=
 =?us-ascii?Q?rty0gPMY/E0lBgQsFRmVaL3079bKVa+IHCHKVY3SXvsyg6TfMC1hBJULZHyF?=
 =?us-ascii?Q?SadxXW+VPTrkwcGdVYqfPBIHM8JkHhKGq3/eWNTwl6Gzq+TEPu+2wDrvM81H?=
 =?us-ascii?Q?4tk8mTiJq22VZKxpXe237+adTCZ1s1sEiJBSnyl3aAdrU3pgclFjT8HdHH6W?=
 =?us-ascii?Q?KH7ugQJzP3vPH+sX8n3tHBsH6dTr2zmmtmR/9tsffIHUNQQWbfz5+Mo8Lsfx?=
 =?us-ascii?Q?BmvSU08zB1j6RvMzjKJShIWAtSkgjGsH7tdvaC4p4P8P59LQlO0oIYkEi+Xh?=
 =?us-ascii?Q?xVsmlXOGFP/f/a4U+PzZDwsS3FKOdkYuqEbHbEXN8MbVweQAW54koQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y/lQAVDEnHI9JIyKmZ4Y667YR8WOU6ajr9QAKAYFa64rp20F+2X9SPuFkEYL?=
 =?us-ascii?Q?TH55hYq2El8SnacI4mCBKVtyuTW3Zzk2VH8+zxyRhdp7tJEq7+PdLXL9NroG?=
 =?us-ascii?Q?m/OlS5cQtLVxL6UVKE7t2rmgoY/PDGar5TiHkcqttsIxAv8UJzA/2I4x03mu?=
 =?us-ascii?Q?ifo4h2DmglYppauTDbGse1I7t3xM5FkFORlRUolHugl6/Ky42GMtkBb+rl9u?=
 =?us-ascii?Q?mR2BZ2SmKdH/HoxXSSjVkxk9uTrrWInqX84l5M9RzQOR8ooWz0QeDE1LxvS2?=
 =?us-ascii?Q?lTH7cJuE7bHisT5eVo7d/ST08nPU7JVAdPgcqSOySisdqgixlyyrUGWRp1gI?=
 =?us-ascii?Q?uEZRs3Kw3uiIeUmXRxsRNRMYErLCjGpcck1lyN5uqtBOjDwaPXhPY/qqPZpI?=
 =?us-ascii?Q?L2UGii7BmXaEJiV4+ppVc4TLZZcBH5KngEpEDR73bvt4GaLdiRBygrE9otir?=
 =?us-ascii?Q?tvN5dTkPxxB6zZ/Hk9CrNIck2ktaJnZpwWbdpmOV6AoUFeZt77incTs2f6yO?=
 =?us-ascii?Q?YxXbOxcmGtoUL5eO35QRBj5nMv0Eki4DxvxkzXaVE3IoeggLvLKt7isZ/aGV?=
 =?us-ascii?Q?tYi7zCjOcplWMMg0gtsgiPaCZ2H0683HCc/9mYCKHAODxzniHkn+/1Mscqkd?=
 =?us-ascii?Q?un+BLOBMOj6CkUbjG2/DS42aEGqqIMQEgOfcvWwF1K/AMBMSsG0+mUWdZ/oO?=
 =?us-ascii?Q?RQPYJRvBwlex2HLA7sf0/qL/MdMmmZ7tcCRujtuxrcv12UF+L/maVLHoym53?=
 =?us-ascii?Q?cMrLUTKqcAyZxTd+htAn0/gPCQJeSpl0+e/6ysKsdv/zMXORNA2tjdlXnTDN?=
 =?us-ascii?Q?Vk+f2GH7uzfePx94j68OJpqbvoRknOkohE55sv3nUt0jdUjOmYUjKetzwGix?=
 =?us-ascii?Q?rRbMoUJS/oU0m+kLTunO+1cFTwPQqPa/lOsbcvHbqAwOG12YCHFnrDHD36rM?=
 =?us-ascii?Q?b0Td+M7dEyXM/ALHCibtejUrqBOXwPobX2er6siFGcfITDb184J2ZDKqgdS7?=
 =?us-ascii?Q?ITzFB4N7uKy65FGNh/mVshEtTwg07YIXpQCsvibEPeZeYcIC6imTZHRbdBpQ?=
 =?us-ascii?Q?xnkynCKKaEdvMP0j2JUfe2OUPmRUJy9vGWH6rOhLWoKXlgOc1aiKTz4z9942?=
 =?us-ascii?Q?L3TbLh1e0Bj94ro/3QZEO5UbAd91PYUs30T5D9KeNww5VOG5jAI38RMTU41/?=
 =?us-ascii?Q?Km4El7u5FLPIP+aE47r0NQRkcH8vTt7QyysSToYClWo2YcOiCcCMHSiXV/vJ?=
 =?us-ascii?Q?ziNtTip/nfxRA+zW00wOVJtE9fDsBxJwwcxdgzy6Jkaf8TM4E1uIEN4UlxaD?=
 =?us-ascii?Q?cCLH0PG8oJUY9WWFz5eufcvBGvPOaIhT14tvzu0aLSW/Oj032WrkXxhQcqzl?=
 =?us-ascii?Q?C9QaoL24NcysZ+LSobpme8AvD+0vPv99mOVmpgzNCxaHJLBM46XlXHtHkBHT?=
 =?us-ascii?Q?UkDXV6eEq9SvKtU/jjj8TvFdeo0Sj+Xhxr8hXpEggCAXPIemmQZCCCRktp0z?=
 =?us-ascii?Q?0p774ZzNZ1AbbPv2UIB2LgnQVWHO2IpQEWg8h3h7FhtMmPdQRj2/TSn+b5I/?=
 =?us-ascii?Q?CFl47XxyF53RDGDwxX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef79cd86-355e-470c-19b5-08dddadf75aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 03:05:44.3075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlsuGtJoxLMrc4iVHrE/4goxDxYSOvrtUKhFfmuDgCtu4LhTC718RJxeS4snYj3BumUpfizYD7XnKQv7u5OM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, August 13, 2025 6:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 3/3 v2] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_ras.c | 44 +++++++------------------  drivers/gpu/drm/amd/amdgpu/a=
mdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  7 +---
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 92c2370831b3..2beaf30ccb96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -877,7 +877,7 @@ size_t amdgpu_aca_get_bank_count(struct amdgpu_device *=
adev)

 void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev)  {
-       atomic64_set(&aca->bank_count, 0);
+       atomic64_set(&adev->aca.bank_count, 0);
 }
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val) diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_ras.c
index 185b9e538f98..23f583492bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3306,8 +3306,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3326,8 +3324,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }
 #endif

@@ -3381,49 +3377,33 @@ static int amdgpu_ras_poison_creation_handler(struc=
t amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);
+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

[Thomas] As discussed offline, this code can cause system hang under stress=
 tested.

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 7f10a7402160..df93791eb645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
 };

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..b3bdcf70df2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,12 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,

        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
-               if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
-               else
+               if (ret !=3D -EEXIST)
                        dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);
-
                kfree(ecc_err);
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
-
        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                pa_addr,
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 01:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D7010E296;
	Tue,  9 Jan 2024 01:08:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B879F10E296
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 01:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQXoMbd91RMhqXCs2pcj1wFimV06zjBuo81f+h+Lgt6fTxDnZcmal1Ruqb57E2Of/VyZclgNWFTuIhOKfdJp5rZjxY12JMHVUvxT3WVjvrP2DhzHMF3UA/KriUGu1u9+AUE6DFVVnGnfFACsyexjq+Q4DfUq3u+qy2u5bX0Gt1Wekpr/HCQtctSAFAQ+XRNWvax3u8LwNAHOwiyMzCz5D6TjrPeQtqZln6C75QcmePW8UkND6iQFrxSayJxdB1S/rWc6FN2ANP0zEPcLbW5trETpwVItvx7S1l7tN70AX4Bh+P0ng0CvWpK1lrOUqfu3vzoYlVLMLfki3iLBsJ+LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHxa5trZVnwhoCmHDtr8yYL3yYlrSfFsL4O2LWc4Ppo=;
 b=HeeKOhnSkF9wTnM70CLm7AHk2M+/u/zPBK9SWuxFflwKeT2SQ2JjeaMPy6k3niN+6dtAay5Xt5joqtY8Uh3hCXR16rlCd20dE+q7tbMaPfQHMviX0jKPlGagkI2CykTj/MCXuZBct3OUq+jZ1VfCRNYmArC4i+WsCH5xr0c/7CKLZp1JTcSVxfZVsxkgZR9dSUU5Rf+OcB8A7cw5fohMBiisOqOMVtAxf4TCYQtSZTOmNVKX3kaQKaZyvmpxNZCdmKdglTwNC7ngPPQgh6qA4/5YYOSrSZm2i3Fu9h7N2DDHswfWWc2iielrk95bU4NiAhVe7CemPEugPKlHXwoWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHxa5trZVnwhoCmHDtr8yYL3yYlrSfFsL4O2LWc4Ppo=;
 b=OdP570+Co+cW3SwxY8xPLtqOyTZxKjgnQsttWxCDbT6eP8XYaO8mA7LBLK/DzHqYS2VMd5CdS+WSBD3ffsQbk4A9kenPMHJKfHPcQb7ySKp8WVZj71U4kJc5cKfUiLT98tLBqbdK8afqHtfPVnG6iiHPfzlQ6dQPEgiiHvUc/wQ=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 01:08:45 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::28b7:3ee9:2c4b:6ae]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::28b7:3ee9:2c4b:6ae%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:08:45 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move kiq_reg_write_reg_wait() out of
 amdgpu_virt.c
Thread-Topic: [PATCH] drm/amdgpu: move kiq_reg_write_reg_wait() out of
 amdgpu_virt.c
Thread-Index: AQHaQnsFdmbQLh1m4UqCGTkuc/GhlrDQq5Rw
Date: Tue, 9 Jan 2024 01:08:44 +0000
Message-ID: <CH0PR12MB53723DA7A4945021517367C8F46A2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240108213811.18711-1-alexander.deucher@amd.com>
In-Reply-To: <20240108213811.18711-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8bed7b84-38dc-4e32-96eb-5250d917354e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-09T01:07:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA0PR12MB7628:EE_
x-ms-office365-filtering-correlation-id: b8e84dae-f416-4395-11cd-08dc10af86f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOv1EpD0UhlhdXwfluz46+qaUE7gZwm3mqOjguZtnCIbpzRaOvE4tNL24avgYVTyQzFWKT24Nt6dsMFfkS+kDIOFVZNTFmp2gFvGBXSg8FeYLoUaMbv2jnvjQWcMcsANJeExEcr5ryJQweGqcAH3nZVRAlv8eVoMOLH/mupH+EixjaOSEviqlstkTLLq4hQbwQD1vgETuGQeVer0O3fmr1Bq9GwqQ/Mk5+yIujN7eEnBZmhiyiu07LTA6pkRGxTos6vZpX9fA5GtW7S8HwskAn0lKs9hF37b9Gk11gplsGXKRNW1VCcb7Es+ERwmcUCIvZtHPyHYREEuXeKo5bVSCLEqFyZu66HvCLmf02Dp7BUda1AXoN2qvz+LFBFIR04FW1aTGnd5qIV5RvjlHwlVKkrXtUot7ZtO+ihYY7izaWxKyfw5OL4EqC9tev3OwL9ganbCW8AALSb3+YGeqkNAT3CQKE1wr4GYcf/JaWSSnOJ2qgGCfXbrveXmb2EW+b0kjQV++mr6VJmUcr44fEItrro8hwVXZJ2daICB9toQpGVHhn5ZHT0FifoQby+37R4z30yRvggDmWlU8p//5W2DgkGXX/8av4WQ0l/t3xJu51jEMRVLv0vTdAN3NZgDhmCG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(83380400001)(6506007)(33656002)(5660300002)(26005)(86362001)(71200400001)(7696005)(122000001)(478600001)(53546011)(38100700002)(9686003)(41300700001)(66556008)(76116006)(110136005)(66476007)(66946007)(38070700009)(2906002)(64756008)(66446008)(4326008)(8936002)(316002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t20mKdwC0niziWPXjgUusJ00douA9SuVSQrLNIRZ/ntl/aBaar728YEdneGW?=
 =?us-ascii?Q?1xn07jv/KWj6QihvovJtmZPc6fDWljJB9yV6P22Q+ooMHeD+QFhYk32NpZwG?=
 =?us-ascii?Q?R0T5/RpRhsDhcTQOBypnZZadrss5qW4n7zzbtJVTHPbvIkmdpPt+ar+gOTUo?=
 =?us-ascii?Q?uIXw/5w5HLO179lBtncMIOfZ2KNLpSAkwMFSomd3M0fAEHSnIfms5cqvPWAu?=
 =?us-ascii?Q?Gl+65f3Qaaveg3BbPUyJSOxvpN9SX9DbDFT0xOsgpBaT0CtoAk+gG55DH6DO?=
 =?us-ascii?Q?ycYWRevO5CDSEgddguYJL1CFNIG2GZVDOwtnH4qSvJGIZ9vM2GSD4ptOcx72?=
 =?us-ascii?Q?cjTHWT/yyCa/TjtwOlB8nhYxKnRj16hCOR7ArMN4XpJa7QXVcwom5Kt259M0?=
 =?us-ascii?Q?j8914S/bMhyZWzie6RId5A7/o95YQRmcIyuO8B2zHXYZcVdAnAf4T/GqUr3f?=
 =?us-ascii?Q?4acwTiHoZCtyTwK0ID998e98pQ+x0xQmrs00Gku+Y6uIwkwz6QZyWYHGmov3?=
 =?us-ascii?Q?6GXp+8zDxyTxltcKaExVTgfsJWQ2kRKtGP+6ApLOTFzWu+cJVzGFODZAK3iz?=
 =?us-ascii?Q?Q/YMn7rzesUlI7WjMuZVeagIIj5qtYnaKZrwjHuA0dUHDIVX629OTN2rNXys?=
 =?us-ascii?Q?wdpIjzhEAurdWMIh7tySWICSXFSlqQ/0liolpOmpII8YhWTuy1y08osIQ/T/?=
 =?us-ascii?Q?2GYAmB0x/hypNgD+QQK3KGYEqjhNrAzj413sTVvvTW76tZP/yKFYMSVodp7J?=
 =?us-ascii?Q?WLywNvf/PYVIPrypFGAM6QO5sl8K4/pdfxwt0auvF2dD2Nqw1zJ5lHMUiD0g?=
 =?us-ascii?Q?q0pNPakhVAv95OIzlC/PI2s2W8tcNUxoIshpSR7n5WnhXQPfPAVJjfOxOuu8?=
 =?us-ascii?Q?Jw7b0Md8dklkEzRdrh13Nlb3fL2ZJSRTAJilWJxK8oy2WF+dsKAcZb6dVWYz?=
 =?us-ascii?Q?PTRdWxXsDJj8hlia1oUGpu2nV3voCi9zDJDQ07bPRql/KX4GjXjAsFNL0LdK?=
 =?us-ascii?Q?J56eifAbF5Wvd50iqggMOULo75GMtdXODzzTEtoadr+YT8kf6wK+LmfmtV+G?=
 =?us-ascii?Q?CxctK9UR/oNqZZLcwiaYd6wZYuz11l5p0d+8FyecriS5KGGMKlu1cB5W+szc?=
 =?us-ascii?Q?/CpoGWloShKoWT8isT9mLv1GHpbcaMdb2NFbYrdubgvLU2pMwrNmndXoRTak?=
 =?us-ascii?Q?jO0O+8niF35orWSWw1DBO7HiwHsU70vrcAKmvDDwvRTb3L6Xly09zLk9M/oj?=
 =?us-ascii?Q?MWxKeXc5qeux0J9Pui6QJu/rxeRjh3F4I6HvEoVL47JOJai2MA+0BxR2UUQp?=
 =?us-ascii?Q?OeukHM10Be02sfnSFlMQuoQcbF3SnKhp799LAsldWzxqbFvS3O7pzUay3tJv?=
 =?us-ascii?Q?bqEsx9M0XQxP4PfuDX+MTLmEArtHNXzsuzlZ2C4Djt79IhEA6prg1TLXLpXp?=
 =?us-ascii?Q?2ofWcuNITWWp8D1R/UOb4nnslAkOKLbjGolQM1e3591I/Sct4gTiuLnTttNG?=
 =?us-ascii?Q?6o3EaDp2nKkUJqUQKHVLxpq01wCz/Tb21n5/T8t/kZXYSAQk+Cv3p2nKiEsA?=
 =?us-ascii?Q?Pn/H39+DguQDlNKvAqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e84dae-f416-4395-11cd-08dc10af86f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 01:08:44.9286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxS29GjCkDWy5B9fr/okTpSSZS/90pD48tNEVF3hYeqbnTh7Ta4qig1rYP5yy0lP2ChBoZJbmLrDuFkebJuE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks good to me .
Reviewed by : Shaoyun.liu  <Shaoyun.liu@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, January 8, 2024 4:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.L=
iu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: move kiq_reg_write_reg_wait() out of amdgpu_vi=
rt.c

It's used for more than just SR-IOV now, so move it to amdgpu_gmc.c and ren=
ame it to better match the functionality and update the comments in the cod=
e paths to better document when each path is used and why.  No functional c=
hange.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Shaoyun.Liu@amd.com
Cc: Christian.Koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 53 ++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++  drivers/gpu/drm/amd/amdgpu/=
amdgpu_virt.c | 53 ------------------------  drivers/gpu/drm/amd/amdgpu/amd=
gpu_virt.h |  4 --
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  9 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  9 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 12 +++---
 7 files changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index d2f273d77e59..331cf6384b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -746,6 +746,59 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_devic=
e *adev, uint16_t pasid,
        return r;
 }

+void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+                                     uint32_t reg0, uint32_t reg1,
+                                     uint32_t ref, uint32_t mask,
+                                     uint32_t xcc_inst)
+{
+       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_inst];
+       struct amdgpu_ring *ring =3D &kiq->ring;
+       signed long r, cnt =3D 0;
+       unsigned long flags;
+       uint32_t seq;
+
+       if (adev->mes.ring.sched.ready) {
+               amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
+                                             ref, mask);
+               return;
+       }
+
+       spin_lock_irqsave(&kiq->ring_lock, flags);
+       amdgpu_ring_alloc(ring, 32);
+       amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
+                                           ref, mask);
+       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+       if (r)
+               goto failed_undo;
+
+       amdgpu_ring_commit(ring);
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+       /* don't wait anymore for IRQ context */
+       if (r < 1 && in_interrupt())
+               goto failed_kiq;
+
+       might_sleep();
+       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+
+               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
+       }
+
+       if (cnt > MAX_KIQ_REG_TRY)
+               goto failed_kiq;
+
+       return;
+
+failed_undo:
+       amdgpu_ring_undo(ring);
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq:
+       dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0,
+reg1); }
+
 /**
  * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index e699d1ca8deb..17f40ea1104b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -417,6 +417,10 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ad=
ev, uint32_t vmid,  int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device=
 *adev, uint16_t pasid,
                                   uint32_t flush_type, bool all_hub,
                                   uint32_t inst);
+void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
+                                     uint32_t reg0, uint32_t reg1,
+                                     uint32_t ref, uint32_t mask,
+                                     uint32_t xcc_inst);

 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);  extern void a=
mdgpu_gmc_noretry_set(struct amdgpu_device *adev); diff --git a/drivers/gpu=
/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0dcff2889e25..f5c66e0038b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -71,59 +71,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev=
)
                amdgpu_num_kcq =3D 2;
 }

-void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
-                                       uint32_t reg0, uint32_t reg1,
-                                       uint32_t ref, uint32_t mask,
-                                       uint32_t xcc_inst)
-{
-       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_inst];
-       struct amdgpu_ring *ring =3D &kiq->ring;
-       signed long r, cnt =3D 0;
-       unsigned long flags;
-       uint32_t seq;
-
-       if (adev->mes.ring.sched.ready) {
-               amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
-                                             ref, mask);
-               return;
-       }
-
-       spin_lock_irqsave(&kiq->ring_lock, flags);
-       amdgpu_ring_alloc(ring, 32);
-       amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
-                                           ref, mask);
-       r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-       if (r)
-               goto failed_undo;
-
-       amdgpu_ring_commit(ring);
-       spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-       /* don't wait anymore for IRQ context */
-       if (r < 1 && in_interrupt())
-               goto failed_kiq;
-
-       might_sleep();
-       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
-
-               msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
-       }
-
-       if (cnt > MAX_KIQ_REG_TRY)
-               goto failed_kiq;
-
-       return;
-
-failed_undo:
-       amdgpu_ring_undo(ring);
-       spin_unlock_irqrestore(&kiq->ring_lock, flags);
-failed_kiq:
-       dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, re=
g1);
-}
-
 /**
  * amdgpu_virt_request_full_gpu() - request full gpu access
  * @adev:      amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index d4207e44141f..1b49c007ff62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -332,10 +332,6 @@ static inline bool is_virtual_machine(void)
        ((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)  bool a=
mdgpu_virt_mmio_blocked(struct amdgpu_device *adev);  void amdgpu_virt_init=
_setting(struct amdgpu_device *adev); -void amdgpu_virt_kiq_reg_write_reg_w=
ait(struct amdgpu_device *adev,
-                                       uint32_t reg0, uint32_t rreg1,
-                                       uint32_t ref, uint32_t mask,
-                                       uint32_t xcc_inst);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);  =
int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);  i=
nt amdgpu_virt_reset_gpu(struct amdgpu_device *adev); diff --git a/drivers/=
gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6c5185608854..db89d13bd80d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -262,16 +262,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
        /* flush hdp cache */
        adev->hdp.funcs->flush_hdp(adev, NULL);

-       /* For SRIOV run time, driver shouldn't access the register through=
 MMIO
-        * Directly use kiq to do the vm invalidation instead
+       /* This is necessary for SRIOV as well as for GFXOFF to function
+        * properly under bare metal
         */
        if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-                               1 << vmid, GET_INST(GC, 0));
+               amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+                                                1 << vmid, GET_INST(GC, 0)=
);
                return;
        }

+       /* This path is needed before KIQ/MES/GFXOFF are set up */
        hub_ip =3D (vmhub =3D=3D AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;

        spin_lock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index c9c653cfc765..6c68135cac9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -223,16 +223,17 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
        /* flush hdp cache */
        adev->hdp.funcs->flush_hdp(adev, NULL);

-       /* For SRIOV run time, driver shouldn't access the register through=
 MMIO
-        * Directly use kiq to do the vm invalidation instead
+       /* This is necessary for SRIOV as well as for GFXOFF to function
+        * properly under bare metal
         */
        if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.read=
y) &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-                               1 << vmid, GET_INST(GC, 0));
+               amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+                                                1 << vmid, GET_INST(GC, 0)=
);
                return;
        }

+       /* This path is needed before KIQ/MES/GFXOFF are set up */
        hub_ip =3D (vmhub =3D=3D AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;

        spin_lock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index f9039d64ff2d..9bff72356a37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -829,23 +829,25 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
        req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
        ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;

-       /* This is necessary for a HW workaround under SRIOV as well
-        * as GFXOFF under bare metal
-        */
        if (vmhub >=3D AMDGPU_MMHUB0(0))
                inst =3D GET_INST(GC, 0);
        else
                inst =3D vmhub;
+
+       /* This is necessary for SRIOV as well as for GFXOFF to function
+        * properly under bare metal
+        */
        if (adev->gfx.kiq[inst].ring.sched.ready &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
                uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
                uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;

-               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-                                                  1 << vmid, inst);
+               amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+                                                1 << vmid, inst);
                return;
        }

+       /* This path is needed before KIQ/MES/GFXOFF are set up */
        spin_lock(&adev->gmc.invalidate_lock);

        /*
--
2.42.0


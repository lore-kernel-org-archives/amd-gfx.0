Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E4BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 14:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E179210E774;
	Wed, 13 Dec 2023 14:23:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDE110E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 14:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWPFCuIE8ZXmBCGehOilbweM/LfMyJCLxG6buLRoeiFhY5OhNMtsSeFaZQuZXzggwQc5l7ESlg58vVPdVh9GEYpAolpCdHfn/XEFhKY+7vlMIZXValFedhS5H+L+jsLGYGD8atk0WRfIt4kh9YjwdSQvBq1TAr1gymNLTBVv/3FCUKJwpdigYCKCyI4vGNbx08+T+Kr2iDy36WDfD7UGKIGElibfUqvzbcHpdWWk9eIdpH5h4yf301WCK6AodKsG8sYs+p0R5cePsHRYMAGNJascio8+hu7Yqijkr5Mho8lkOE2sb5tjHpl0Jd9c6jPTGKE396KB1LjtBwtcycCLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FABhgM7GS+AaJguhi2chr93sy2qQ/mUpjuxqFd4vGiw=;
 b=S2787HP3V5VO0QFeTxoAZ9km7KGfmnFLKU8h1PYDj95oCyiPDWQgqXnaIIBqm2gCAs01ErEKcslII3fSHy4UuQ8OYeIXzALoBSW7sA2Ybq4gjyRJ15WfxEHH50piVeqeQd0JkeQjEn2rEtBL/8p2BhBYuPakMDcYwReg5AukkSOdkgZaEv5lpscu0ag172C2UD/ij/C1afTh4AjF6NBFqwxZfBfv1LHJUAvxQkKNOUJYGEnBkMhLhT5ihnKOSA0ifZDmB//zemmppfJxGM4pDqjUcv+wJDnibPTknRYmAhgG17nzBtLA1h96qnXH+UJ0KkKJpTxqp0eeuVFsHeZcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FABhgM7GS+AaJguhi2chr93sy2qQ/mUpjuxqFd4vGiw=;
 b=3heKhZ6uXUmmHWu4+M0EBHOz/709Kzm/MRanZcLgEdaK4z1oiw4y6ydzcXoNlH5aapFaJ+1tBJKhcpUNbYkNKam6NMEYP5zwfKJk5kaMIEnI7Mer2O+nqxe48PGctXsUNvDP95XEJFTwMZdLe8DVM/O5gJT4ZJtEYGU5q7M5fdQ=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:23:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:23:33 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: support return vpe clock table
Thread-Topic: [PATCH 1/2] drm/amd/pm: support return vpe clock table
Thread-Index: AQHaLW7L0hVlCUNOxUyR6cwyICv3DrCnQKjA
Date: Wed, 13 Dec 2023 14:23:33 +0000
Message-ID: <SJ1PR12MB6075B354BC9E0FBC8D935F2AFA8DA@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231213024909.1384762-1-peytolee@amd.com>
In-Reply-To: <20231213024909.1384762-1-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=80a1de3a-b97a-4bb3-ad24-e495433d58dd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-13T14:07:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|IA1PR12MB7734:EE_
x-ms-office365-filtering-correlation-id: 9af78bae-bf81-4d47-1b1b-08dbfbe7167c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oOLnTNSzYW5Gg37xmvC6/munnwjMgKM3eFA1GOzYHnHlCUSrFl1byp8HUnmKoz6CskghYyD+6IouwP+4bcA/EpUsv9u4NrP6fpeZ1Jurj1M3V9goT4vaZh25IIqYDbg7LWS5EeM6tYfy4zpwkVNADcu62C93+a2mDsz6qob/1idiBa47/5Wp68lemSYWytj4DFOHVYgMLkkZV28dnhWsiNCePfpbDBLGD0JcqHY+/iWolCUswnh3QiJZ9kR+gVuwZsXkXwIVDAOHHed+VAHe+i74hSpdQuBRmorNuz4YyHH/EcTCOcKJJrlvktGmGQtSp3nqWIr7UrNTObIJmY5aBJHn0GpNiSdbUnNcEFS2tL8RgslIv5uCfIHUzDcuMj3y3QOHCw3gb4BIOxjNugoRywYxbIiniFT7f1515olINnxxVYo2pjS5pD2XrzGEEZAKFO6UZrnJeP6Yx6EhXmwOIE69Yhrdue5Zm6CFfEh///YLk0Nsb6+2hAYjLfuMM+te1Itd7m6HbspN5ROhNJl20WCUnXksTKVwQWxqg7ITB9i5DTTg9aQNDu5WYE363crP7moCbeDgSTgppesPjcAZKoM9Fv1psg1TC8zCos907IQHghBHLR/5z/y7FetdSvn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(33656002)(55016003)(9686003)(7696005)(6506007)(53546011)(41300700001)(66946007)(66556008)(110136005)(76116006)(38070700009)(38100700002)(26005)(83380400001)(71200400001)(54906003)(2906002)(8676002)(64756008)(66476007)(66446008)(478600001)(4326008)(5660300002)(122000001)(52536014)(8936002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OaPxY5zbbtZNe0i7wSnFa7wOG2xiVYbVbU6revKLYWf1f2E0H8xkR5kTdDl8?=
 =?us-ascii?Q?Lol9b+EmD4FE41C7aylK1EMpaDKjCTY42gECCJBNH0yb+l2On7ZFdeZVmrGR?=
 =?us-ascii?Q?vJOlSdx32RgWflZj0A+gM3NFRMJZ26b3UgmqPG9o1eVrJJ8keaXXv3zrviYT?=
 =?us-ascii?Q?b2IO9aWX/70w7jU+c4nWtjZgurVylTBBh/JHjMBsUuS60SeJgFXpjHyV/Eiz?=
 =?us-ascii?Q?IY6ADT4PcTPlN2UWOKa1YTqwdMLeguML/z6mCPcDB/wmf7bEjEWdWbI7o+n4?=
 =?us-ascii?Q?SR3vNQux6mPg3EsH95OzjnSsEoTgLrdH3VsQo3/I7I5j80gNm8TLq72NMk+I?=
 =?us-ascii?Q?+nJoI5IRoaRfzG47LU9mxRU2nU1EdLo+TsCe7q181o/SQk/fXSPQxUfucRUW?=
 =?us-ascii?Q?Tm+0n2YD0FF5BWLjZQLuVqwJBmPVfvGOH6FzsXYHvU8kVDbq5XsQVefUT7/+?=
 =?us-ascii?Q?ljMfRSYLDOjmYlZ72weG28hKXOssRrOjqNgN5uX2d99lPPw06s2fAf55sk4H?=
 =?us-ascii?Q?HtyEepJZKKiDMiRH/Gl5feaa8UprSBT9x1hGPyLraIIZM44BVZcd5/DlZD8A?=
 =?us-ascii?Q?HMftQ8MU0tAj2CH8pVl9pdWc7Eu6KrQvuAKqDcACdmOxz89ceOqmLfX0hExW?=
 =?us-ascii?Q?2BZTfW8UYvJi3niPkkf5TAc5HIT8JffMRLVnLBYyAwuNb+560HtsOS+SqbVW?=
 =?us-ascii?Q?jYAHp4L+RXCT9NdehKlIorhmwPO8GAi1ASje0nadSGyF1AQFEwtdPiKs5v+e?=
 =?us-ascii?Q?t2ieWwmrausTlKRQ9D0lf1OoqrXO/qASBGscbFNqcGYv/9rpnNhP0H+AUCMZ?=
 =?us-ascii?Q?diXGRqZtdVurvcNx1YtuONEszJpIlh+D3lfe1bcJos2y+X2N949J651iIiW0?=
 =?us-ascii?Q?VGO3Iz2XjhYbKz9b6pCk7xVRyc4RE/cFbnb4iPA7uOtCqo3uy/9HX14MNimr?=
 =?us-ascii?Q?QcRsCbnTB1sbnt7WkpXqJrPB7t9iUuUhCq7L3CBgcv+Bm8/SQ9PYP0KV+zTh?=
 =?us-ascii?Q?z76tLjXiV4r/sspAPD0SnW6qug4gbPV/nfpNySIUFTgnd1vIkLgzHaGXSBxv?=
 =?us-ascii?Q?e3DZ6SxQmQxxxmTem0o7/XRgBNECQ290vJcQL0Rq1oTIvp5ehPmyRZPix+kp?=
 =?us-ascii?Q?aFStNRotgfM9ZJVzcsar1oG/JOuj/HWm8Md00RWJE6z1MvMH5hktI64wsaMw?=
 =?us-ascii?Q?VADBZzFo0CqLw8BVNL0t+qgQ0hZwv1EPnJzz4M8l7YvldmMcCw9cBxphmxHI?=
 =?us-ascii?Q?xMswAwN3+A08b3A7w27/aTA59U2ROJV0AeQcDskRKOS6zKWL12MQ9yss2DFZ?=
 =?us-ascii?Q?ufFlefLeINpBGmS/uV4V5szC7UX6KhIC3+dziEHXY9yYNE9VeNBlvUtsqn0J?=
 =?us-ascii?Q?OcdcQY+63zJNclBUXVJE/+WFC4tXzUEzRDY/CLVqLIJariWkdjK6yb3WoAqV?=
 =?us-ascii?Q?ijr/4IfnLjxiUC2iStB+PAYFxTDNzcHM5J53V7L1xKjQxImZR8q853nnDatX?=
 =?us-ascii?Q?tTuuPnXR0LhIgiZSZ4fy/vWIlA6ZJNmQovseMeeHayi3k7KZj6H0L0fLIuk8?=
 =?us-ascii?Q?5AtIIaVueKmhf2ul3qQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af78bae-bf81-4d47-1b1b-08dbfbe7167c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 14:23:33.6119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soqElTKC/KuOnUAncsbmi7KCPZIs1keX6qDTS7Lb4RdIhl1nX9ZRy6evdyP4wd2ZUqZwm/8cUT8FE4WPeKPJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Peyton,

After the format problem fixed, this patch is
Reviewed-by: Li Ma <li.ma@amd.com>

BRs,
Li
-----Original Message-----
From: Lee, Peyton <Peyton.Lee@amd.com>
Sent: Wednesday, December 13, 2023 10:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>; Yu, Lang <Lang.Yu@amd.com>; Lee, Peyt=
on <Peyton.Lee@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: support return vpe clock table

pm supports return vpe clock table and soc clock table

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 10 ++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 20 +++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/a=
md/display/dc/dm_pp_smu.h
index 4440d08743aa..bd7ba0a25198 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -247,6 +247,7 @@ struct pp_smu_funcs_nv {  #define PP_SMU_NUM_MEMCLK_DPM=
_LEVELS  4
 #define PP_SMU_NUM_DCLK_DPM_LEVELS    8
 #define PP_SMU_NUM_VCLK_DPM_LEVELS    8
+#define PP_SMU_NUM_VPECLK_DPM_LEVELS  8

 struct dpm_clock {
   uint32_t  Freq;    // In MHz
@@ -262,6 +263,7 @@ struct dpm_clocks {
        struct dpm_clock MemClocks[PP_SMU_NUM_MEMCLK_DPM_LEVELS];
        struct dpm_clock VClocks[PP_SMU_NUM_VCLK_DPM_LEVELS];
        struct dpm_clock DClocks[PP_SMU_NUM_DCLK_DPM_LEVELS];
+       struct dpm_clock VPEClocks[PP_SMU_NUM_VPECLK_DPM_LEVELS];
 };


diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 97b40c5fa1ff..6627ee07d52d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -616,6 +616,16 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev=
, bool enable)
                          enable ? "enable" : "disable", ret);  }

+void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable) {
+       int ret =3D 0;
+
+       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_V=
PE, !enable);
+       if (ret)
+               DRM_ERROR("Dpm %s vpe failed, ret =3D %d.\n",
+                         enable ? "enable" : "disable", ret); }
[Ma, Li]: here the location of "}" may need to be modified.
+
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_=
version)  {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs; d=
iff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_dpm.h
index d76b0a60db44..3047ffe7f244 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -445,6 +445,7 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *ad=
ev);  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable); =
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);  void=
 amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_=
version);  int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev=
, bool enable);  int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device=
 *adev, uint32_t size); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu=
_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 94ccdbfd7090..47fdbae4adfc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1085,6 +1085,25 @@ static int smu_v14_0_0_set_umsch_mm_enable(struct sm=
u_context *smu,
                                               0, NULL);
 }

+static int smu_14_0_0_get_dpm_table(struct smu_context *smu, struct
+dpm_clocks *clock_table) {
+       DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
+       uint8_t idx;
+
+       /* Only the Clock information of SOC and VPE is copied to provide V=
PE DPM settings for use. */
+       for (idx =3D 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
+               clock_table->SocClocks[idx].Freq =3D (idx < clk_table->NumS=
ocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
+               clock_table->SocClocks[idx].Vol =3D 0;
+       }
+
+       for (idx =3D 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
+               clock_table->VPEClocks[idx].Freq =3D (idx < clk_table->VpeC=
lkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
+               clock_table->VPEClocks[idx].Vol =3D 0;
+       }
+
+       return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
        .check_fw_status =3D smu_v14_0_check_fw_status,
        .check_fw_version =3D smu_v14_0_check_fw_version, @@ -1115,6 +1134,=
7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
        .set_gfx_power_up_by_imu =3D smu_v14_0_set_gfx_power_up_by_imu,
        .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
        .dpm_set_umsch_mm_enable =3D smu_v14_0_0_set_umsch_mm_enable,
+       .get_dpm_clock_table =3D smu_14_0_0_get_dpm_table,
 };

 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
--
2.34.1


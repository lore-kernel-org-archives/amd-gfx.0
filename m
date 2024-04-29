Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 08:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC1410E37D;
	Mon, 29 Apr 2024 08:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpVq23gR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0745310E37D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 08:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdaCNclV2SQ7AbWQXoyFcckHymhhoA1N46QtRBpJst3itZkImvZ455gpf7nIbSfefiFoK/bUDoAGKtBVZefTF/oqJ2NH82lFUjcbpBSeiSBCAjEgCKNlSy87zxN62BCf21a1oHYIl6Q5cZ4/bnMfk1NQO7KtuyzgJWP3np4lUD0nihS5Mv5NLfWZFudenrIJ7tUdqxzUvrI/arX0WsQ306A1EZIgLU84b/83fP08MhHlilKk44OPTONi6nUPy7KBWguYx3VDPAX6febP3CPqlaUjotmYhNEyCsKKCCDuYyyEwlgfR1T1IPoNZyzT33Fbw2ojGtGjvRfMsEzI0IaCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+EtbJE2MA10fDKsZ+PvYbDDSzGVfk8f+9pKvP8bMMU=;
 b=jqjOxj2dYpwsJ4PqM56rv0XGFXxI55TOX2X0NxxecOkoRgcF0rDWj1cFG1HgVg+nj6IuX0NrGQ3O/pjDZ6rtua3KIFwWoBU6qgpPBHSr2BIbYY+EiU5ANTP4FDnPvkX/2Ui4LM3hRNx4oQ+PyrP//P9pJ61HCvGsM7vIxLeVgmGrU7ogqCuDOxBZbZhujrtuVIrHPqYRVe8WQMe+eZylpJ2TckGWwMJF4BwjbsFuYUV7BayF/u+vVdhGGY9rSZK/AnJTEu5SifVI77mUQQ/A1oJzGRdslL+V+yK0HV1VhAAUk/tEfaDVrGuBp9MRpQii8JQKmShpCiCGdiBP9H0XOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+EtbJE2MA10fDKsZ+PvYbDDSzGVfk8f+9pKvP8bMMU=;
 b=MpVq23gR2Dm4oCVzEwG3PI1CmpLIOgHYVPJYV+B/JNAtdajvpNZ5ZxeIREL4fMa1l19ay0vSEyqRzMkJWAVIRN+5yntQLe2OpnDGMbmSqtdiVozIJNDASI1CHWoBCtcPaGfCOXa3eactHnEJHhHjLJg+8+vJ9SMRWlkP/fc5vSM=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:14:53 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:14:53 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>
CC: "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Aldabagh, Maad"
 <Maad.Aldabagh@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft
 recovery
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft
 recovery
Thread-Index: AQHamgdG1U/NBMw0XUihwQYt5KbtubF+5kjw
Date: Mon, 29 Apr 2024 08:14:53 +0000
Message-ID: <DM4PR12MB5165D1DA3E54E3C6BE20E3CB8E1B2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240429073132.12611-1-kenneth.feng@amd.com>
In-Reply-To: <20240429073132.12611-1-kenneth.feng@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: GuoQing.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9916a8f2-d642-4109-b8ae-b0b32766c6e5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T08:13:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|IA1PR12MB8077:EE_
x-ms-office365-filtering-correlation-id: 94246fa2-a317-4625-8b0e-08dc682472b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?uAjq82ozevZbxU49AQm7tCfKoG94c2y/T9d/hI4Cb4skPtxYngE0WQq4L4x0?=
 =?us-ascii?Q?8lJig7p8Vh3BNvj5VzPE1iqzwTjeCj7w06md0wgdPZF7gg6tf1EtyCFeY7yY?=
 =?us-ascii?Q?nAS44Ud6vjhkLFMWOMz+GvCfb3Y9g2Lw2D35OskKzU6QeFfu/qksyWBFYu+R?=
 =?us-ascii?Q?qzAOTeW3M3G9EJOGACbegvIT5BVT2WcmxjZ6cCidSG8cIV8uCEtbV8PHBNtg?=
 =?us-ascii?Q?cTVr2pZB6ne20x6F4zmWp8/pgMRsFFgtN/6gTFipPde6OPF2CZGeBb076/DG?=
 =?us-ascii?Q?p133QygHBaQyeY88ONzC4XOrn6oEic1L7jN9fAAXF8f61AcSfG+vm3F54mX+?=
 =?us-ascii?Q?09m/IW8MVcSovqj7osV6xFMTNi4ho59K54XTgccLhUx43uNPy4nDvGZDqKz0?=
 =?us-ascii?Q?jKa4jnzG/ecgQXRDL0y2Ibfz1Ekuj8R7exFhSyXnTFOnt5rIsjE5RGG/2bWe?=
 =?us-ascii?Q?v/UvO40WveYFCIUzUiApZtuSvkXNSpNT6lirHgOCAbefyPOTJOaxpabVAyEK?=
 =?us-ascii?Q?j4xRZUVIhbtra80bPowqSerX7y2IPc5Ocg1rv7a8Rr19r5SLaBauEktl4/Jj?=
 =?us-ascii?Q?H1maCZcRqL8T4IdhLGNreawVzLYoYnFI/zpLHUyDhXazmgvTQ3dkmXwHGUen?=
 =?us-ascii?Q?gxVhTZHXibvZV6EX6g2p0xcdPeSdZaYuNQ6o6ZVAcTSbjzg++v3pIkpfBaxz?=
 =?us-ascii?Q?8Z/vBZh41jsYeikhsXtEAh1g+lXmO3PHuiKIr8a70Y647+NJrGkCoSiGcmdx?=
 =?us-ascii?Q?T/ASuyPPY/JOSLwdv8Rgul1gptd5BrC6YSw3sYjR2MU0Ss4rawXvWfdAIel5?=
 =?us-ascii?Q?5pDH2PJEQyc7p/nK6IczAqTE4YH6ngjkaQF6q77pEeqyJm55U499g53uQFWe?=
 =?us-ascii?Q?eTf9fFXEDwBKlBpOIuwYNI2CLrolKDo1qfnsK0SeSjNBh0j+dyqXLl0vNfG8?=
 =?us-ascii?Q?W6R2X2LL6+r0WJFuwn+KVr3KSE70YyEF3sllQ+r/xJWGMlOEcq/8Up7iZL7N?=
 =?us-ascii?Q?fPsIN0UObCGdN6rhUCsEU0yUEviHsZuRGJvhkC9uguJZDAHK7yZfAmVYQJD8?=
 =?us-ascii?Q?SSP9p5OslbTuOxWcfW8pe4dSWzM6SiLA7LOuMY0cMsYajEncx7uJzTEa9NT2?=
 =?us-ascii?Q?qLPDk2qjIzCm2UNEKcsOw5wtPEETdHJKwcXqcIFEN4OijiH/8cH7z/4eBrtB?=
 =?us-ascii?Q?ZVCEPppUlLS2mUdH1o9Sf07k76YHOw54zm8hwoaxmada0lqh8xsBC8bsvp/H?=
 =?us-ascii?Q?1SiPU4Fj3Xw50BD0TJJ9LJxHl8zEUP5/1USUIZCiAtRNim87co+PAF2T8hBo?=
 =?us-ascii?Q?GqavcAP05lmEVQBhIYS6GrCcWbMwdab6O2zSWDXpPwnmow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oQLFmJAVp9jcNOq4T1n1dImWWwFY/xGjhJcaT4M5es/9TyH7G28fOeoiLZUK?=
 =?us-ascii?Q?hZYK84bHPlMO+ZvVqANdR2gY/sEvE6eiICqlm5+645/aqumWUMddBKNY0bP8?=
 =?us-ascii?Q?TbW6T3gTL6d+EF47rzbTyf+r2ROml93qS+x/dMqDOn0JXvvcc2X0wMmN1VU1?=
 =?us-ascii?Q?xr9K2g3qi86C4Zk8djGvH/tYPN3AvnOUs7CZ3oepiocGNJRWk6n3h4RRs1v8?=
 =?us-ascii?Q?1yjbNJFtOjuSpBrsUCIP/XUP1oCRZrxhYhPX3Xaz0+PFjYawWOcuIu5V3rxM?=
 =?us-ascii?Q?8ouwkH/b3+HESgD/1ne4S/lwUKjwyaYOHOHLkSmmpRSwbBeSopfi61HqMFk6?=
 =?us-ascii?Q?27RK0ZAiwV9I1/my2OA5lM8nEmZW33Hzp3+/CuV5eVN0WA+/Eea5oGQA2N+T?=
 =?us-ascii?Q?uLjqe+Q+/GJT3UT2cI7wtaU/YfGY+/Y7ZPivEfz9vQv4pc707hMrxwlPRPUE?=
 =?us-ascii?Q?DyR/8q3oLvf5BX5NnTDq/jYk5sJEj5KdzgkXx0MV+TNYvnRlBfDuvkoInNHZ?=
 =?us-ascii?Q?YD5gIiqRLRyhdKqik1LNt0faYjm527BvJC9tkgp964s2IOCRHJu1fZNblx5q?=
 =?us-ascii?Q?hRgqQIEGJuERp7R1SB18C3FRoxr3Qtnz1oiTd5pF0GfISCScdlCjh5ONrGAC?=
 =?us-ascii?Q?zbEVyzGyQgE5vVUT+pbbMjPOA1Rljo64nUpniPsL5nOal7ImK+hMxvldJo8I?=
 =?us-ascii?Q?c+XtR1bqKEgr2qzdjxmBqJ00AEuGqD0QQGpxvXCx4SOTCXLrnHc0kA7GRjmL?=
 =?us-ascii?Q?PAHiwZBqcvqTEtlg0CW8wPBuf2vlaFd8Ju//NjpJkejtb9qfeSgaE2dWKdu0?=
 =?us-ascii?Q?hkutRP1J11ZxXpej5PSFKk2piKbO+XaCuhRPrOPk2t2tXvec2RFHfoxCbLma?=
 =?us-ascii?Q?wrgQzoFJ2sG0Q9bObeXyEuNxaWQ3rKIoVqHmL9BGLAzPFVZPrpjvtPqP+033?=
 =?us-ascii?Q?cDo+FUUzSL7dz4s5/CkepwGdXaYWpNI0xmmlTLcjYdAcrBXXZUfudEt/2zB0?=
 =?us-ascii?Q?uM7S0draXzGmpaw5uu3lqNoOSSGEElzrA1xfHVwLDO9rDQn+F8EeFMe7IhPq?=
 =?us-ascii?Q?V6JR6GsuNJRZgZqVqF/e8p/7tgmEIAMNyOkugXwB2nDGvkYJLLlWymI5Vxke?=
 =?us-ascii?Q?xsbbOzcDl5RTl8x0zYCgEXHQrhR31FIClbBZVqW0xytKWMsQawgmW6TKAyMk?=
 =?us-ascii?Q?qlvUzFg7PnCkI1rHnSbrQvv5a9J8tiW0/jipADcye7Fh7oFRGCYounfe5dDF?=
 =?us-ascii?Q?dpG0vfOjMef5MlXUFTb1u7oB15WCCszUio/yQNZ58K9j9zNsV+OTVBz3LK4b?=
 =?us-ascii?Q?XNCDH3Ckd9w0kLPbcsVJ67tjjI7eYO+1+cMc6OkvsQGDVMT260I+nZmNd3Q/?=
 =?us-ascii?Q?nDAtABF0KvV94xAr3pknE+W0+bQ5hIQz1anCALcrD1P8yV9Xwe5fJcOsnAfu?=
 =?us-ascii?Q?yvqb3EaTf+HIEHD8CnaFt1Lj68y22tDfpvMpClqcwI1qOFjNw9wiC4fOW8MQ?=
 =?us-ascii?Q?LvoSGLJnXxibzNeCoLrzWUDwW+nR1hls+tuVFqu2uRrUPhXU32+a/CEB3fmr?=
 =?us-ascii?Q?PvX+6WiM3brXIEufkxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94246fa2-a317-4625-8b0e-08dc682472b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 08:14:53.2417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0ri+S9dK2dA3fVJf0GGIyJBxJ3DKSMT0yjSU9s2j4k2qyNR5+eIMB92wiqt/4GX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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

[AMD Official Use Only - General]

+@Zhang, GuoQing (Sam)

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, April 29, 2024 3:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>; Aldabagh, Maad <Maad.Aldabagh@=
amd.com>; Ma, Qing (Mark) <Qing.Ma@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: customized the reset to skip soft reco=
very

customized the reset to skip soft recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/amdgpu_job.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index ea14f1c8f430..65c3a387fec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -548,7 +548,7 @@ module_param_named(compute_multipipe, amdgpu_compute_mu=
ltipipe, int, 0444);
  * DOC: gpu_recovery (int)
  * Set to enable GPU recovery mechanism (1 =3D enable, 0 =3D disable). The=
 default is -1 (auto, disabled except SRIOV).
  */
-MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D enab=
le, 0 =3D disable, -1 =3D auto)");
+MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =3D
+enable, 0 =3D disable, -1 =3D auto, 2 =3D customized)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index e4742b65032d..5c75993698a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -51,7 +51,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct=
 drm_sched_job *s_job)

        adev->job_hang =3D true;

-       if (amdgpu_gpu_recovery &&
+       if (amdgpu_gpu_recovery && amdgpu_gpu_recovery !=3D 2 &&
            amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->pare=
nt)) {
                DRM_ERROR("ring %s timeout, but soft recovered\n",
                          s_job->sched->name);
--
2.34.1


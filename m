Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D9CF9C70
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 14:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E523D10E26A;
	Mon, 23 Sep 2024 14:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ts0HrF88";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD29B10E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 14:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH1rEMa+Rc844Zs18HyszLvFBCxO6N4mvZzOkA9IFs+z5KwnnoDguIiUlLVhFvMB2qOnu0UVUJrgR36C3Uw1xNxx5fn+MjaW06kNH58yAYcsczQYoT27O8X5P9KXVTyweRHbqmR1YLGsUvkCzsbAlsBwsFohBzny0JOBv2zpWvlwf6nQCmn5a9BA32uNPkvjC/25Or2BnVpJqs108cl4o1/UzJJ0XOw51YKABfQGN3QLlenbw9xzerXDSr2x05xbxjTdaeTIIOsM35yJ4wrEu0y6Q3B/N/PiLZOA0UNmabyDf3HnOQS9St959vOOfHIqbD6bA4Sw2Ul3hcG0yhlzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04gV1jGH+XyuE2eSovDWzIm9sd288cxIY7pabfsETyk=;
 b=oqQ8ax2hODIS7tnsoQtutY3K0SRyLxlSq2NVOmt3iwXT4wSrfhY8Dh8Lm0Ld6jPokvKl3TGIJIIflibputbYowS9DpeNQ9gaXmLhzgs3IQn/npX+fuvlCqFIalZM0zlthXKq2Xr+HsbTYxghZb22Rz+fno4N0KumCN6AvX7yGTPGDPMCgQvhBfpZaIdQCDBIbpuYJKEuwHhCBx2I+ckRhPlxzJinZAat254zobBMlQil0KsbkJuV3Yc71Kh9SuigYhBwfA5hrqs4uI6Qicwsj59KRF0ikzM727obhG1Vg6u1snvYxQJGwYqayBxkwPLngFRZnic397c7PGersE0+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04gV1jGH+XyuE2eSovDWzIm9sd288cxIY7pabfsETyk=;
 b=ts0HrF88ugYAEZZODCazimDVCz4vp6aG0MksHT2HhYNQBu0CIIuzPRpPzW5hXurXPPdCweidBEeE1LWfTQNidWLrHBdHaj1ZaOcm/JX8hQ3ERClxYYPrFtCOd+y94smhM22X6QTLW4Yu9Ie2uzjtTlZk3Rpe1kmDRnyn0/f9Tbw=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:31:00 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:31:00 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2 1/2] drm/amdkfd: Update logic for CU occupancy
 calculations
Thread-Topic: [PATCHv2 1/2] drm/amdkfd: Update logic for CU occupancy
 calculations
Thread-Index: AQHbC6EehpPqcDRFTUCjavy1j2463rJlbIGw
Date: Mon, 23 Sep 2024 14:31:00 +0000
Message-ID: <CY8PR12MB70992FF09A9532A0E0FEE9E48C6F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240920210715.64118-1-mukul.joshi@amd.com>
In-Reply-To: <20240920210715.64118-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=50413b78-a53d-4fac-9482-4366a623e52e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-23T14:07:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 3016e2eb-0600-4226-944a-08dcdbdc5884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ED4nLkeT9Ee1sembTZHYCrBgzmocJwGsdKMM/qgvPJkEdzuMVm86fE2x22v0?=
 =?us-ascii?Q?W7d59HRxtiUdN4Y4a9ZV3H3NEhG0R+uGpFqBFEkpBPX5s0s7pGk/ZYo2EvEI?=
 =?us-ascii?Q?+mAX/DddDIub8oifqPw1HQyIoKklxe3g+Zyb59BIDe8v2aXICRlXvMK3TiFf?=
 =?us-ascii?Q?WURYIIJOqXiDMUOW+UKo1jxCVaToY+US4DSmVq7o3lJiRPPmxnOofyq7oY77?=
 =?us-ascii?Q?RhxWh2xCTcxn8VuA1ZtN+p4k69kxJzZ0602eyYn/uHW0skS3ykfMiaor2+67?=
 =?us-ascii?Q?T1e32617nNsSy/VbH1+QhHxj75WDzzXP4RJTdn0zkfI1XzyKInhYf4HwYmyK?=
 =?us-ascii?Q?nPMkisB5QAopBXCvDREYggNTKwIQIv9k3jBwlpN2v7B/89hlHI5K9W5TNdl1?=
 =?us-ascii?Q?EnCVUKsfux8yW2gjuvUEBIKJxcnw2f1rQ/jEsFSufGh5u54nhaCQSlgElWuQ?=
 =?us-ascii?Q?fLomkEQyLz0+CzjosXaEmARMrt4jS+feWeFyd0TB7pexKh+EZ9alUpKGIzX0?=
 =?us-ascii?Q?BFXCVqNLgc9CFRqdgnjFtysRay26w9MTLH+3QfMYVpXzP3FTjLLUI2yYCN+y?=
 =?us-ascii?Q?fcenuadwB2FX0sXam24bsxGM+uqETbGm0WsVtqevCgnxQCna4SGMi+1H6vjN?=
 =?us-ascii?Q?bZVdS3N9ytscquYts4FWB0HiQ0q8FSAOaxQ0kA+dfg4rzaQuqRX9UJGs/Do8?=
 =?us-ascii?Q?dXuo0xi9MqJ3YBa6Ba1VJda15d7PBODWoD6KxyXZnpoo3lsJtY9eH90tgDft?=
 =?us-ascii?Q?XXDVumwxFX7rYqtunk47OxSx1plyXxnzgax8dFlHKo7R2usx0Cas8bdvlGF5?=
 =?us-ascii?Q?pAtk29GEHJjrBSIbjv/7A73ViHg7ZWXVqmZKZEXXascnXDUGzAtY0nTH8tGA?=
 =?us-ascii?Q?S6DHc2zDX+U028tJ44sj/zxqg/J8u9Y2OD5UiY+J933ml17T+1m2kyy4KLCf?=
 =?us-ascii?Q?eEH+/zvmX7FcpitBOclTblHB4z6+XE+Bo7z4UB/ppKN4WaGdJRGPiNoN01/T?=
 =?us-ascii?Q?Umw4Xmbx0frUzhj0Wjm4dvs9y6YPt3b/oY3S9Y0ylnA1Sd3MfOM2XaUqVFi9?=
 =?us-ascii?Q?HOB/uzaUJxlQw4BdnBEPbW7Ue1WX2ajA/6eewNaTAKDHJuNQ3Mp0QWS4NZI7?=
 =?us-ascii?Q?LSgqojqzqaj3mg9kATqBSjNG86kZZxydsYsBAXXu9hcmMPSp/B0ngA77+tJa?=
 =?us-ascii?Q?1xKTtD4dPwq5ZQYEcQfMabtR5AmTdqY8GKBV6brjmiAIlo9i4f38yVbXUd+p?=
 =?us-ascii?Q?+aaTuJP9xZnIkxZTn7wQ7sROaNIm4Vz/j98ImQ5TKgg0IuqnejOvTQf63Al0?=
 =?us-ascii?Q?hpiZyQ2uKsYk/7wzIMeEm4MCQHmL42nY9dvn3lcywnaGvN5679wUwm391IrS?=
 =?us-ascii?Q?aF8VfmCY3EVPZWgTPFwDvnheSh9CVk+URLZQrbeSE96ybWnUPA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GljxEmbQqY+Pgf4AWE+zz/v7RKzn0HMvUlXPG6Kgiu+XTBMavoIugPx9rUxT?=
 =?us-ascii?Q?Lp0W+enjYJwVByM8MVzUsd+HyI16ET8b1oDbgyQSmJfjrpC2pGpyw32kXhEo?=
 =?us-ascii?Q?HkDyKzwIURUZPqqULZZ0f0laxn18EQ4cdGpU/UpPwDEirlMYELiaoLDeIBH0?=
 =?us-ascii?Q?zyy4CZqP9lMToXrizgbsBRkwJ1C7RR807Ihpw13OHxkflIHOfBzsv1ho0Zv0?=
 =?us-ascii?Q?GKP0sfVxdD8QRu0R5NDIK6jZisIhUzI500YRsXXiDIvcjzDKxtQc5sKgPptg?=
 =?us-ascii?Q?QnjjyrQycaGMUqkn1r4O0lPYOlfvjPhA7Bg9sbsuhYe+LSnGJPkY0zs4ZLxZ?=
 =?us-ascii?Q?RX2AHdPsFqCkpDfdXFqwl1ZZ46gWD8VUPfgyWPyoKtaKK2iSvaSM7bmsqNX+?=
 =?us-ascii?Q?soPUuJem9RdMsaI8e0QVtxmOvSk7J3QWychY81WtjQaZ89H6rAYFipCPWOZ4?=
 =?us-ascii?Q?B/eL2Qpc+Cvjj20Vr408rQ645meUhvkSI/HG0nHZf2DoY29dGf97ubmC4zSY?=
 =?us-ascii?Q?EbJvyKWAsoGUNyvQoOOylkbxnyU914I+N3qcI4eAL5Ob0OopP212uZ+gOK+q?=
 =?us-ascii?Q?RQf1f32/cThxC/ydiOouAfK7ccr+3XQP7xCuqPdnlg6xm+dv8M/bduMcbBOn?=
 =?us-ascii?Q?FJQ8yyrA+16mXjhl+58hyyE750KiRW3ZPZQfZknx10Ezx9WaU8yPJmxbcbfx?=
 =?us-ascii?Q?WLoFMRinPaI4Bm923YQKQZP/i9Qinq5gjf01yLHy0+xvN698Tt3ZciMMBVkR?=
 =?us-ascii?Q?ICluCOjRhrbBumIEFwJqn/o8bg4DYBrz2hOyJK0qcfs41B4T/Wg7tFjKzMdK?=
 =?us-ascii?Q?ZmXa7aYZ7aC++PDumBQhmuUbRsN70X3vFspiAxjNiZzTpN+XiCguacYRatGD?=
 =?us-ascii?Q?6Kl6lbuwSWfoM7J51+xYE3nHDqCiQnW0IKFU5pZBxWug0GGIu/4SKP2G+iKK?=
 =?us-ascii?Q?piVjxMJr6HYgRKjLFfdWn9vLPLXZGIpp/Ox3RU+NYjneB+C9sH00NDhCSrld?=
 =?us-ascii?Q?7wnFGMB+QHOBhS1dKJeXzUcTFZG6t2oBRfENGydfvxPr4OeyuQuLV63shLSS?=
 =?us-ascii?Q?z4IY3kjGg2mNPvWi62Skuzb04T/x1zlXrLr1wHN0hRfv0cMquEHSYZwrCia/?=
 =?us-ascii?Q?9AZOvcNwCCt1PznMZAbWPz0w/DoKeLudlXZMTpevqmMkMM/876giiQwY9sia?=
 =?us-ascii?Q?/0Q8yNQvIiswX8NPTuae8GYoFMQIiZ0reC0pil5SmHRe4wLcZ4tv31OEw8kk?=
 =?us-ascii?Q?lt7YovacQQfTa3HYUTDuQgyxIdVkjAFLIxWAIZ1DODXS+RpWPvVsiEP3QKE8?=
 =?us-ascii?Q?HtBI+ttT3BdB0G/dFpTJWhLAFW07+N1qJPoBF9H5QtABXaydeXxl9kF9TaIn?=
 =?us-ascii?Q?UoCZ4wgaUF32fiYYm3MdXeYUdYj+4d6cqqsjhOWj7ZxAO1gvWzmi1Zzbm7CS?=
 =?us-ascii?Q?Qnef6MJj3CYEw+LNkdInk82UGBM0RlUN30oGPkQmGAc4ov/jz3RiKjmWcP9c?=
 =?us-ascii?Q?CS8QRkPR/Zc6hVxp45bwNw0smu1tXhpVDvCfHthT6qx6HZMU4+F2mIZTVsQc?=
 =?us-ascii?Q?ufuxoWavLiK8xf5ibPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3016e2eb-0600-4226-944a-08dcdbdc5884
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 14:31:00.4115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6C3SzSgIH+jXtAYj+Z7Kq30TlCFyPioHcya2tKj1q/xWtAwJAusowlBxOJseRX7o9AbtSZIQnCpq1vkFd5jQDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

One very minor comment below. Apart from that Reviewed-by: Harish Kasiviswa=
nathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Friday, September 20, 2024 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul =
<Mukul.Joshi@amd.com>
Subject: [PATCHv2 1/2] drm/amdkfd: Update logic for CU occupancy calculatio=
ns

Currently, the code use the IH_VMID_X_LUT register to map
a queue's vmid to the corresponding PASID. This logic is racy
since the CP can update the VMID-PASID mapping anytime especially
when there are more processes than number of vmids. Update the logic
to calculate CU occupancy by matching doorbell offset of the queue
with valid wave counts against the process's queues,

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 97 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 ++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 10 +-
 6 files changed, 87 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1254a43ec96b..fe8a8e7e9a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct amdgpu_devi=
ce *adev)
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-               int *wave_cnt, int *vmid, uint32_t inst)
+               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
 {
        int pipe_idx;
        int queue_slot;
        unsigned int reg_val;
-
+       unsigned int wave_cnt;
        /*
         * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
         * parameters to read out waves in flight. Get VMID if there are
         * non-zero waves in flight.
         */
-       *vmid =3D 0xFF;
-       *wave_cnt =3D 0;
        pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
        queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
        soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CS=
Q_WF_ACTIVE_COUNT_0) +
-                        queue_slot);
-       *wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
-       if (*wave_cnt !=3D 0)
-               *vmid =3D (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
-                        CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIF=
T;
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+                                 mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot=
);
+       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+       if (wave_cnt !=3D 0) {
+               queue_cnt->wave_cnt +=3D wave_cnt;
+               queue_cnt->doorbell_off =3D
+                       (RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTRO=
L) &
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
+       }
 }

 /**
@@ -1011,30 +1013,24 @@ static void get_wave_count(struct amdgpu_device *ad=
ev, int queue_idx,
  *    number of waves that are in flight for the queue at specified index.=
 The
  *    index ranges from 0 to 7.
  *
- *    If non-zero waves are in flight, read CP_HQD_VMID register to obtain=
 VMID
- *    of the wave(s).
+ *    If non-zero waves are in flight, store the corresponding doorbell of=
fset
+ *    of the queue, along with the wave count.
  *
- *    Determine if VMID from above step maps to pasid provided as paramete=
r. If
- *    it matches agrregate the wave count. That the VMID will not match pa=
sid is
- *    a normal condition i.e. a device is expected to support multiple que=
ues
- *    from multiple proceses.
+ *    Determine if the queue belongs to the process by comparing the doorb=
ell
+ *    offset against the process's queues. If it matches, aggregate the wa=
ve
+ *    count for the process.
  *
  *  Reading registers referenced above involves programming GRBM appropria=
tely
  */
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst)
 {
        int qidx;
-       int vmid;
        int se_idx;
-       int sh_idx;
        int se_cnt;
-       int sh_cnt;
-       int wave_cnt;
        int queue_map;
-       int pasid_tmp;
        int max_queue_cnt;
-       int vmid_wave_cnt =3D 0;
        DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);

        lock_spi_csq_mutexes(adev);
@@ -1048,42 +1044,30 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_devi=
ce *adev, int pasid,
                          AMDGPU_MAX_QUEUES);
        max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
                        adev->gfx.mec.num_queue_per_pipe;
-       sh_cnt =3D adev->gfx.config.max_sh_per_se;
        se_cnt =3D adev->gfx.config.max_shader_engines;
        for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
-               for (sh_idx =3D 0; sh_idx < sh_cnt; sh_idx++) {
+               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+               queue_map =3D RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_ST=
ATUS);
+
+               /*
+                * Assumption: queue map encodes following schema: four
+                * pipes per each micro-engine, with each pipe mapping
+                * eight queues. This schema is true for GFX9 devices
+                * and must be verified for newer device families
+                */
+               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
+                       /* Skip qeueus that are not associated with
+                        * compute functions
+                        */
+                       if (!test_bit(qidx, cp_queue_bitmap))
+                               continue;

-                       amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xfff=
fffff, inst);
-                       queue_map =3D RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_A=
CTIVE_STATUS);
+                       if (!(queue_map & (1 << qidx)))
+                               continue;

-                       /*
-                        * Assumption: queue map encodes following schema: =
four
-                        * pipes per each micro-engine, with each pipe mapp=
ing
-                        * eight queues. This schema is true for GFX9 devic=
es
-                        * and must be verified for newer device families
-                        */
-                       for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
-
-                               /* Skip qeueus that are not associated with
-                                * compute functions
-                                */
-                               if (!test_bit(qidx, cp_queue_bitmap))
-                                       continue;
-
-                               if (!(queue_map & (1 << qidx)))
-                                       continue;
-
-                               /* Get number of waves in flight and aggreg=
ate them */
-                               get_wave_count(adev, qidx, &wave_cnt, &vmid=
,
-                                               inst);
-                               if (wave_cnt !=3D 0) {
-                                       pasid_tmp =3D
-                                         RREG32(SOC15_REG_OFFSET(OSSSYS, i=
nst,
-                                                mmIH_VMID_0_LUT) + vmid);
-                                       if (pasid_tmp =3D=3D pasid)
-                                               vmid_wave_cnt +=3D wave_cnt=
;
-                               }
-                       }
+                       /* Get number of waves in flight and aggregate them=
 */
+                       get_wave_count(adev, qidx, &cu_occupancy[qidx],
+                                       inst);
                }
        }

@@ -1092,7 +1076,6 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device=
 *adev, int pasid,
        unlock_spi_csq_mutexes(adev);

        /* Update the output parameters and return */
-       *pasid_wave_cnt =3D vmid_wave_cnt;

pasid_wave_cnt can be removed the function comments also


        *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
                                adev->gfx.cu_info.max_waves_per_simd;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 988c50ac3be0..b6a91a552aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -52,8 +52,9 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct am=
dgpu_device *adev,
                                        uint8_t vmid, uint16_t *p_pasid);
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
                        uint32_t vmid, uint64_t page_table_base);
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
                uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
                uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b465f8d83e..29578550b478 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct device_queue_manage=
r *dqm)
        return debug_map_and_unlock(dqm);
 }

+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+                                struct qcm_process_device *qpd,
+                                int doorbell_off)
+{
+       struct queue *q;
+       bool r =3D false;
+
+       dqm_lock(dqm);
+
+       list_for_each_entry(q, &qpd->queues_list, list) {
+               if (q->properties.doorbell_off =3D=3D doorbell_off) {
+                       r =3D true;
+                       goto out;
+               }
+       }
+
+out:
+       dqm_unlock(dqm);
+       return r;
+}
 #if defined(CONFIG_DEBUG_FS)

 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..80be2036abea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+                                struct qcm_process_device *qpd,
+                                int doorbell_off);

 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *=
pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index a902950cc060..d73841268c9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr=
, char *buffer)
        struct kfd_node *dev =3D NULL;
        struct kfd_process *proc =3D NULL;
        struct kfd_process_device *pdd =3D NULL;
+       int i;
+       struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+
+       memset(cu_occupancy, 0x0, sizeof(cu_occupancy));

        pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occup=
ancy);
        dev =3D pdd->dev;
@@ -287,9 +291,17 @@ static int kfd_get_cu_occupancy(struct attribute *attr=
, char *buffer)
        /* Collect wave count from device if it supports */
        wave_cnt =3D 0;
        max_waves_per_cu =3D 0;
-       dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
+
+       dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
                        &max_waves_per_cu, 0);

+       for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
+               if (cu_occupancy[i].wave_cnt !=3D 0 &&
+                   kfd_dqm_is_queue_in_process(dev->dqm, &pdd->qpd,
+                                               cu_occupancy[i].doorbell_of=
f))
+                       wave_cnt +=3D cu_occupancy[i].wave_cnt;
+       }
+
        /* Translate wave count to number of compute units */
        cu_cnt =3D (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
        return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index 7744ca3ef4b1..e3e635a31b8a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -71,6 +71,11 @@ enum kgd_memory_pool {
        KGD_POOL_FRAMEBUFFER =3D 3,
 };

+struct kfd_cu_occupancy {
+       u32 wave_cnt;
+       u32 doorbell_off;
+};
+
 /**
  * enum kfd_sched_policy
  *
@@ -313,8 +318,9 @@ struct kfd2kgd_calls {
                        uint32_t grace_period,
                        uint32_t *reg_offset,
                        uint32_t *reg_data);
-       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-                       int *wave_cnt, int *max_waves_per_cu, uint32_t inst=
);
+       void (*get_cu_occupancy)(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst);
        void (*program_trap_handler_settings)(struct amdgpu_device *adev,
                        uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr=
,
                        uint32_t inst);
--
2.35.1


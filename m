Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF35C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 07:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7145910E1FD;
	Tue, 13 Jun 2023 07:44:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBAC10E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhGFifkbWuTmOXuxGy+42jFtbNnzgM3DY9xR4I6Ziyt9x3/OIZuV5p0+/pw9Uc02dxMXb0XE2h6/xsg6RDFvaa7w1UPAIJmzCIaySvKaEHyJEiwviCYgv/zrfcm2Kl34PmvAFoxTySa1rBwvk1qtWnEXvaiJcT44xGHTgSWf2s9xBmuvHA0FArsWztr7aw8PYM7Kv2e4G0cdjXh/w3jdjHIyjsnWSckTXDyaXlm8JJRM7FxRYVBy7e9hvXSqGm8kR9RPv+w8gX5tP19CPNjh3on4i0TrZ1xo53rQB2ZGrETgs/rYQRWBDpVp/BvzLMhSkyeMv50Iv0WyXHNst6NwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDsAgow7xo8yuMK/5Z5Mze7CCSQtPTnVc1ph8fjfiSM=;
 b=Tr4tRVd99KSwyLVcfPDK2Vrg1Qnu9Oo3AOEqFvCvYXAVBgryVgPeQV6sKJkVH7OcnoJxtUqmybx/KFXSJIOGRRSP4nZ6i81JOtrN23MrlS5Gtcty+nAXPxSqz8om3Spd7v5PuUTLU60v7horiQLw07MOhYClgcptncFoVm9+axhJdr2Itj31K/4rObHBDA1xg5Hwq+r0cESB2edWrguAoqdzDEVInydADIz6Ov2aUWADGZ4UahXm4jCh8wbRptd+ND5OHy6WXnmUnqALo5Uon+OWkjeFcox8E4s8u8NrBpQpigSXBVOTZ/lSi8eToFgtZbzvkbAX9Qsp+IBNjicb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDsAgow7xo8yuMK/5Z5Mze7CCSQtPTnVc1ph8fjfiSM=;
 b=aAdIfudauyRmCrecaNF+dO9OoZC74129b4xikTyjR4p1LETrMbwcYOiEWhPSXAKw4WjYKo8ksgSxneTob7JF+Z8atDenqAYyfH9ZUrg2LKpuGK0bX3+NC+YiLueL5blfnGD8Pwk0Wk5TiYJiFlQVdsEDAKGWb45iBt/wDFki9Fw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:44:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 07:44:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add wait_for helper for spirom update
Thread-Topic: [PATCH] drm/amdgpu: add wait_for helper for spirom update
Thread-Index: AQHZncjX37jnArAeT0OcabQasOV9eK+IWAMAgAACC2A=
Date: Tue, 13 Jun 2023 07:44:16 +0000
Message-ID: <BN9PR12MB5257362191CFA6A99AC66904FC55A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230613072924.403550-1-likun.gao@amd.com>
 <DM4PR12MB51818D4B32943D71C8D0D8C3EF55A@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51818D4B32943D71C8D0D8C3EF55A@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8453970e-a394-4795-8fef-dcec98ab82be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T07:35:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5063:EE_
x-ms-office365-filtering-correlation-id: 531b66e2-387d-4d2d-5d21-08db6be1fd13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh1xuK2yKzDW81RWGR/GtNgdN8LLuBaYtKUOB8yEPKNCPy3JmboY2lUmc4IAGJVLql15jcsprKhEhZOeB56V5Swod+lw5Gst3umMCgHx5tgl3wO1D3GPXsB8IlkWEB5jex2KX2+rK4Jr5WUPAzbvb30VTpKOxYpfyX85HhrzgS/FFTCff2bwTUqNvJDwbV52nFQkCX7GpBG3RzaurBdcrbdaEDI8vEOcJQytV+Z7nZtN/rEP+qhBR+1VwSk11TIo/0TrYEinncGxXqoeTU6gAVWm+Kj6jDSULzNBstgfCMu5+GAnuW+pUGKHPt6NnZbmO47dZkhy3rk3+P1n+D1E5Hy4AX38Qx/ndTjDYaE9uWfHw2D5Cd9XDGKN/N+JnX2XPOFwYzLJO08V50KEXdR1FH/bY59rBjzMxI3atv4a6LYrhIFu6Ek6cqKXPjvF1+9IpIHsAy3TyKtg9BXyOyPIa+H/ljp6qGuCSWTF/Lc069TJuh0/YuWyBG9DBy1oALTdU8O5+hfcpU28PeePCKJ1U6ucYoIsrjKadV7Hfbfo8VI+E65qG5jB68KwYYgR3XxJW9XyCjIRT0KQoWQaO2LE0gO185nn/cSD1BhPibuzyJhYAveFFTWY6kY4s3lbV0Eu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(5660300002)(55016003)(7696005)(110136005)(122000001)(71200400001)(66556008)(41300700001)(8676002)(8936002)(478600001)(66476007)(66946007)(66446008)(64756008)(316002)(38100700002)(76116006)(186003)(83380400001)(9686003)(6506007)(26005)(53546011)(86362001)(33656002)(15650500001)(52536014)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dl37OI/Gya7anC7cMVa+AfiisKI1yLs7EODpoUVKzAz1Q7tEig8Vg7w626FX?=
 =?us-ascii?Q?kqtDZUsdEqs9x0xYtiQdB8St0+pzyL7Ek8Pubb3v36b3Dmk+Em71yDue0y1g?=
 =?us-ascii?Q?QUU/v2PIGmNw7bHGA7kjR2e+eP8mOXU9obkNuMtuNxQ0pFLi6oVAzot00bze?=
 =?us-ascii?Q?X7kARIR5QL1XjqChjopRAb6DeyssofyFY3FB8S+o7HpsEluNQpLkKvbqRrQn?=
 =?us-ascii?Q?q1vFsnPL2y2TKsnGNsL6tg90WubGeKMY0AoCvWsw5o3u1Fw1STkh1qImAWBV?=
 =?us-ascii?Q?fG71PMP2d59E2kBMXzDh+09TaBvWk5uwErt2aMRipI+pMqq1h6nKyblZnmJE?=
 =?us-ascii?Q?JDN3zob+BopqsNmZn8jZBZxWxNxK5mnugI7C/6Wlq0Z7T+I5+n/2G72u4lyI?=
 =?us-ascii?Q?GGrW30GJQnrWHh1K85nDWrfMm3g8/Upa5vpDEODafywaddOFYzDaHiV2WLXU?=
 =?us-ascii?Q?kZG1ByISkmjrRyTlGCZvkSBoPUvBregHTS3c/lgOrt3eogXADolHFfLiRhV1?=
 =?us-ascii?Q?VUAH9ahCl67dkE8VDFmGDrlbESY1S3O820uvbdAb1c0geEZAfqe7T0j4ZW96?=
 =?us-ascii?Q?PrI/4qzJ4UKPfgVMlxZcsORIWUmxNQTez1B2WFRzXKj/si5oenydAAzbPQPo?=
 =?us-ascii?Q?YyEVyXCTHtO+aEWupVul6pmxyIERgKIIqKmutyOzZ+VQs3Iei9t+5HxagE1I?=
 =?us-ascii?Q?5zoejHC18xkGqpXXKo5ixfzb/rRZYs0qE1W3/u6E4ALfuucaVA83jFN2XGbb?=
 =?us-ascii?Q?R7Msbog23ZkfhXjydNIbiJk0W9uwhO2M4A+DgcjLJ7aKNzLvslYR9JM5dfP7?=
 =?us-ascii?Q?Qsad+N1PgTWeMGEaGW3tzcLodQseM9O+95JyeSMQLBvFaY/BABtH1kMehvGK?=
 =?us-ascii?Q?tj/75AT6dRI1p6d5FK/bCITXqk0UwDge0RcY8fjeWCk+PxiGoAlGpHFMktdK?=
 =?us-ascii?Q?qzgOU4FM6Hu2klAf/4fP+hEeNCxKMul01Zez1oNEfCqDvB2xkEhwm2S8r5HM?=
 =?us-ascii?Q?ciwEX5umVglAQ8/vbhLWWNFy0Re5DpJBGvi3Sr9KGrhSjr03BYYdYUe2Hd9S?=
 =?us-ascii?Q?ch07DWdI1sb9aHpdu6AFrzg7lDSc1Ihafohnj9iTIp4L8wcw6FZmTFJlVoN7?=
 =?us-ascii?Q?E9ToiB89RCV6B9lFAR2nR/6kI89iR858+MSJU25nBBN7qEVUP6zH4DQ6xW46?=
 =?us-ascii?Q?tXgQGRKAEFwIj4djFxYNZ8t60+AT/qZ4RYTZPcSKRkiDk/ptmhmBxGTaHtjH?=
 =?us-ascii?Q?ylEYMeruPgGo2QKvNlztIUOI2CsZbvw6Rvf+dZUBrXDqRHHO7irwTF9nQKpI?=
 =?us-ascii?Q?hTVT7NPyC7SV5OpmIyylioATplJSb7PbfkD4oLG5GLYAeTf7DTHYIP43fs4U?=
 =?us-ascii?Q?9eWdXpdKZvFh/h6cO991otDYjNEMvpIcLO9DkXMmeanl6hfwpNBy78iiDBV4?=
 =?us-ascii?Q?4lLOdEuvQ+b3iXGWYcRe26yhtaL3ou6VPQ+KT3MQBe/i/UjW9ndyM09sH59K?=
 =?us-ascii?Q?zCd17UNse++AjqpVb5wsXwpSzN5oh+44nayyx/BAzlQyp8Gv46Gpdx2CkmPf?=
 =?us-ascii?Q?bOZp0Cs14AxUv0g4bIY3HnHl27CJHzAEVqNGwiYg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531b66e2-387d-4d2d-5d21-08db6be1fd13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:44:16.0235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ar6TO0jhDd4DnDYN1RcT8OoUN1TDZmThvUHb10QiqjMS07BC2AsC/UblW9m4s0NuE4n7YnxRmk2zXh6v2Tai+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Tuesday, June 13, 2023 15:37
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add wait_for helper for spirom update

[AMD Official Use Only - General]

[AMD Official Use Only - General]

From: Likun Gao <likun.gao@amd.com>
Sent: Tuesday, June 13, 2023 3:29 PM
To: brahma_sw_dev <brahma_sw_dev@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add wait_for helper for spirom update

From: Likun Gao <Likun.Gao@amd.com>

Spirom update typically requires extremely long duration for command execut=
ion, and special helper function to wait for it's completion.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 20 ++++++++++++++++++++  drivers=
/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++  drivers/gpu/drm/amd/amdgpu/psp_v1=
3_0.c  |  9 +++++----  drivers/gpu/drm/amd/amdgpu/psp_v13_0.h  |  2 ++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a39d4ddf7743..fa06da014473 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -560,6 +560,26 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg=
_index,
        return -ETIME;
 }

+int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_index=
,
+                              uint32_t reg_val, uint32_t mask, uint32_t ms=
ec_timeout) {
+       uint32_t val;
+       int i;
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (psp->adev->no_hw_access)
+               return 0;
+
+       for (i =3D 0; i < msec_timeout; i++) {
+               val =3D RREG32(reg_index);
+               if ((val & mask) =3D=3D reg_val)
+                       return 0;
+               msleep(1);
+       }
+
+       return -ETIME;
+}
+
 static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)  {
        switch (cmd_id) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index cf4f60c66122..ec3f3fe5efff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -455,6 +455,8 @@ extern const struct amdgpu_ip_block_version psp_v13_0_4=
_ip_block;

 extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
                        uint32_t field_val, uint32_t mask, bool check_chang=
ed);
+extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t re=
g_index,
+                       uint32_t field_val, uint32_t mask, uint32_t msec_ti=
meout);

 int psp_gpu_reset(struct amdgpu_device *adev);  int psp_update_vcn_sram(st=
ruct amdgpu_device *adev, int inst_idx, diff --git a/drivers/gpu/drm/amd/am=
dgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index caee76ab7110..67e216373585 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -624,10 +624,11 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context =
*psp, int cmd)
        WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);

        if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
-               return 0;
-
-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_115),
-                               MBOX_READY_FLAG, MBOX_READY_MASK, false);
+               ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0, 0, regMP0_SMN_C2PMSG_115),
+                                                MBOX_READY_FLAG, MBOX_READ=
Y_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
+       else
+               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_115),
+                                  MBOX_READY_FLAG, MBOX_READY_MASK, false)=
;
        if (ret) {
                dev_err(adev->dev, "SPI cmd %x timed out, ret =3D %d", cmd,=
 ret);
                return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.h
index b2414a729ca1..9eae5e23b2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
@@ -25,6 +25,8 @@

 #include "amdgpu_psp.h"

+#define PSP_SPIROM_UPDATE_TIMEOUT   60000   /* 60s */
+
 void psp_v13_0_set_psp_funcs(struct psp_context *psp);

 #endif
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CCCC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 07:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E80010EEB8;
	Tue, 18 Oct 2022 07:43:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5100810EEB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 07:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENDSGGFPi392vgrmQ3TVvEZRUjRsqo8lXD/sF3vJDJFRcMs8lH9rMQOENEMQQbnGNzh7irX91P0DBa8rlEzNcODmUBggS7eCv6aSzKp6QJ75/0B5w/ze/sIpCaksFCKazfpD31/ONBdhgoGPaZT1RCz/dz64CSIFO5MHRBKmQGThm1hb+M4DpHHr787bE/kBF/8Pj1MBdnV1+PUgqaHdYozauqJgu5D9GT9zMR+mycyp/tDUm36VteMLGjXrM8Bj3NJCGzx+cP5l5T5V2ontp2PDOW8zykKplXWUoXJo4+7JKvPitXafBCSKl/6/DQSUXnImsAcPdsMdDF3ItxvbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVN0GWhHiQn5VMKViQDmkp5w9WVcis4qaY0EGOZXckA=;
 b=gwl6DjwPJHii5TWcVHcuK2mzLbZ5/Krsx++G3yzc7fWG7V5PSAwbxcaJ8oiqjOW0vQDj44z5DMVnqCPd3TjE2N8xL79QkUCRZJi/npi70WXrmAqW8lUTPOY8ixoXDUNSuXEAVRHbi7Kac0FIfXqj4fdPa+NYJbSL7wjcJB4fO4XnaO8S6yJlmHfWo/lZSQa/FIL42XIq76HB++yyMOBtJGzKVxiw1sVn+apOxigp/yAROahkSl8Khl7wJ5VrNRwuvFwP1jyQjh1qBvGNZJqpamZVxm5WWDJiSv/UIuBUvfI2+hytCa2F6BJPP/rBe89hoH7CUlyZRii46fxKxZfYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVN0GWhHiQn5VMKViQDmkp5w9WVcis4qaY0EGOZXckA=;
 b=gViTjjE/ItE9thW+twqA0/46gR4H4Kx7sEHZC+BWsDbP9QUqPG7GYtt8P59Wv0+eP8aoOAkBALcaQBFRJABI6Y1LbvG2SIa0sXsVib6g3sTBMc7mG+bePNlLPX/AdIqJMBDXP9BZ9aZeilf4Sr3cF2ZCG29zQQQJFNUh7kZ8P5g=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 07:43:19 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::9cba:9f5a:fcf9:b07f]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::9cba:9f5a:fcf9:b07f%9]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:43:19 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Topic: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Index: AQHY4rQ2l+84avvarkifo7CdEoJjnK4TxKu8
Date: Tue, 18 Oct 2022 07:43:19 +0000
Message-ID: <MW3PR12MB44587D4F651DFF2C6EB385FFEF289@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20221018053742.135890-1-YuBiao.Wang@amd.com>
In-Reply-To: <20221018053742.135890-1-YuBiao.Wang@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-18T07:43:18.650Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|DS7PR12MB5888:EE_
x-ms-office365-filtering-correlation-id: ed8c2d92-c1b1-4283-1fd8-08dab0dc6cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKolwg/4LuBsPzp9Ny3NsvZXVeMGCEJXAKySBJRtKHxJJEeJ3iH/w1aXH8BndN3dFhmb6xafW2WubjHRbEcft7Bia74nF+6WBaaPtsnw12VcP93P+d73qZjYPt1Uy+vZZGZkjDeb0foJBnVnA5UF7gVpiGH5Ddh9CtGoFg6tR6l65M7auy3pQIKV+JpiCAaKTp1ZADxH/JF9eC0YxyCJoJStf/ukD8FLbJTTvMry6Rcb8rqwsy3BT/x7id988FHvBDYOBHBsJG+4WzM+NyNzLhH0UB0Z2CrThr3H7v9TJFfSVPee/IGUveZtxPZvVu988+c6BfDop35TofqaTfU31G2jMDQ532mQ1O2MRNoi2FCD+cxbCicZT3aKThG5EsXr3R/F9M6s5b3/vfa9QBYQYrNRntl/3cHFQH5bPMJy7qD5wZvpQelGTynEjB+gpzo55DXVYbbXprxH+Hb0cJRKmXj0xt067Lqdl+S3ejQ9/HNZQeQaNHf7m2Tff39PkVTIAwouwAiWE/uXhSVVjj7MfMANwBByemgAU2b4R5amUjHQmPJLra+eTD8wjffecyfnJRKoejUkrTTD9ddjHn/pH4tcIV5h7G2cRqukaRIgatem8LkPlkTHr3nOoudP4DhMKfOFexb8MXf410AjygH9kjI0uFOW13HR3Bo6NZnQ+jjenVLIM7ovQ/c3RSYn3C2kscUTCRCTV9CkmonFFgZgN7STND5FnHmGxhM5MIfJNYg11rdHoUWMg9gw5R5seXAAbxJKME8+CGlaDhseAoP7Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(53546011)(6506007)(7696005)(9686003)(26005)(33656002)(316002)(91956017)(19627405001)(66946007)(64756008)(66476007)(76116006)(66556008)(66446008)(478600001)(186003)(110136005)(54906003)(83380400001)(55016003)(38070700005)(71200400001)(2906002)(86362001)(8676002)(122000001)(38100700002)(52536014)(41300700001)(5660300002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sz+s6cEekS9oaOcqciU2i/Z5cevV7pIWat5OpuT7vdVDZiSlzIVwhUG7yopH?=
 =?us-ascii?Q?r5AHue7TeoE6jrRZ4gUBs/sSBqdLySI5GT0IF+++wI9rMFMb3UgntCtx1qUG?=
 =?us-ascii?Q?Bn05BZZ9D4Fc1nAhzQcbmr0kzSYjvI153q1JUU/MS4wmQ53ug8qf1DYLp8N6?=
 =?us-ascii?Q?YFKnfPtQNzOhzLnEYuCwBQSC4lzrfC9r0hII5zwoArw811H9enbdTMdWkKrT?=
 =?us-ascii?Q?dbJIehPMdvrpFm9ifZa7yKB/JWvsHjurXTJxMyLri4549O6/0XpvSZ+ld4XE?=
 =?us-ascii?Q?N0e5MwsHbuQse2X3U7XIZFjr73ek1vEV5BJDZB1bRN9JHcnnVFp3IS++yuCC?=
 =?us-ascii?Q?Bd/iJBhCoxM9ppvACV4e0E7Jq+KUHwk+3Ez38YCWVdDel9MO+/DueG34Mmyr?=
 =?us-ascii?Q?QyLRu3az55C003cgZe/dSenS4AeVl/RdSN5ao3RIr1hUCw/4U+pV5Bem9/P+?=
 =?us-ascii?Q?GPEivIZK+xs1/oLuyE0NYTcL8HRttavzaAtI9YICkzTsZKHM1/+JP6/WYVAE?=
 =?us-ascii?Q?5aTWn1pe5t7JYGhjjzICggsH4E0JDPqIAcL0M6mYt8c300oBbhPtQlukScrN?=
 =?us-ascii?Q?Zl2Ep3O/lwe19l8TWojj4ZikAjrOwXVl58w46bzhAsgjMMa+QnBhEaFmpx2U?=
 =?us-ascii?Q?+dJbCF9cgE+DrqhwtQ1B5S+t/uXXDLJtdUG4PcxiZSw44JKoRGGcGOY5wf01?=
 =?us-ascii?Q?PkSguHkYKAYPFQUBxYVB8gfsazg6isgthZwlSefheP9VlcwjPEHLhDL+O4K7?=
 =?us-ascii?Q?YEZ0x2Tf8jg31I3VAEAlfXSPPpUGIBlcMa7NF2sS7AivcEytkj3b+zGpjxox?=
 =?us-ascii?Q?PROXlLKCSQ2vzWcGneqLAgz5+igfYhrkAq9q2mPEQuBp6xadKM8CxiEUnO5f?=
 =?us-ascii?Q?wfYDXZlUB2rj4yp3n+ZbEuYWThGus2j029ngIMbe9FBqVzlm1AK4vRFi/Cwu?=
 =?us-ascii?Q?6d9DR9F/NO5By2T14ifR7PlQ/eenbrP02CA3N/HPmAg/+PYmxNNVpxT61wqE?=
 =?us-ascii?Q?k6InkyVC0LLMngBslI15VhYcbZig4qiYnepoUsqJNN7kIwbh9SOdCGVX72EB?=
 =?us-ascii?Q?pLVavRf2cNRRnYPRzxspwc5tElQqVOUdTsVeAUT6gr8APlvN2i1qHHhg/N6H?=
 =?us-ascii?Q?0NEOlBXi9ZqBSTpz37/gdJ8HAgUoZWj9vTZWhF5oL1lJd/V3jF+x8bhCvYTX?=
 =?us-ascii?Q?3vaQB+HDUCEbb3thfY8pSC9mGqvfBIpiIYz2+gRzDB89N7mTv0LLUzewqgIi?=
 =?us-ascii?Q?pIXbV4mu6jnxecpPvGEFNOeA8meEGBmc2/37WMov0RxlHG/fkioirOba1Kjo?=
 =?us-ascii?Q?cZqxfzPtRkiP0SW4Okbr2DWF3yreDV0SsteWDjGuGaK/0TKFcRp+Y6jgDH4z?=
 =?us-ascii?Q?RSUmqJPBJtbNuV7zPrmFhBARp2f7ZXBGK/6/Hbf+EssNeWlumVigZphoLit4?=
 =?us-ascii?Q?zR7Ywinzi98tRnhCJNFwjUaFK6IK19C1Su+1250UwUy4APSt/C08YtqBe826?=
 =?us-ascii?Q?A3gMJ2+2VL4pwwHuZxY9Ot7Jbv08xoY6LR3KHg1I/7wfrXBefoQ6SXcQDHs1?=
 =?us-ascii?Q?Yow5xtTq1qqoKlmmw20=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44587D4F651DFF2C6EB385FFEF289MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8c2d92-c1b1-4283-1fd8-08dab0dc6cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:43:19.2429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZBwvn+IWO4QuVUhKoLF8Z9MjFuEt8UUPWwqF3s16e1sNoEJGci8fn6KCpnkUNch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB44587D4F651DFF2C6EB385FFEF289MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of YuBiao W=
ang <YuBiao.Wang@amd.com>
Sent: Tuesday, 18 October 2022 13:37
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, YuBiao <YuBiao.Wang@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovs=
ky@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>=
; Chen, Horace <Horace.Chen@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christ=
ian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.=
Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini

[Why]
If mes is not dequeued during fini, mes will be in an uncleaned state
during reload, then mes couldn't receive some commands which leads to
reload failure.

[How]
Perform MES dequeue via MMIO after all the unmap jobs are done by mes
and before kiq fini.

v3: Move the dequeue operation inside kiq_hw_fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 42 ++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 1174dcc88db5..b477bed40d61 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1151,6 +1151,42 @@ static int mes_v11_0_sw_fini(void *handle)
         return 0;
 }

+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+       uint32_t data;
+       int i;
+
+       mutex_lock(&adev->srbm_mutex);
+       soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+       /* disable the queue if it's active */
+       if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+               for (i =3D 0; i < adev->usec_timeout; i++) {
+                       if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+                               break;
+                       udelay(1);
+               }
+       }
+       data =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+                               DOORBELL_EN, 0);
+       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+                               DOORBELL_HIT, 1);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+       soc21_grbm_select(adev, 0, 0, 0, 0);
+       mutex_unlock(&adev->srbm_mutex);
+
+       adev->mes.ring.sched.ready =3D false;
+}
+
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 {
         uint32_t tmp;
@@ -1202,6 +1238,9 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device=
 *adev)

 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
+       if (adev->mes.ring.sched.ready)
+               mes_v11_0_kiq_dequeue_sched(adev);
+
         mes_v11_0_enable(adev, false);
         return 0;
 }
@@ -1257,9 +1296,6 @@ static int mes_v11_0_hw_init(void *handle)

 static int mes_v11_0_hw_fini(void *handle)
 {
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
-
-       adev->mes.ring.sched.ready =3D false;
         return 0;
 }

--
2.25.1


--_000_MW3PR12MB44587D4F651DFF2C6EB385FFEF289MW3PR12MB4458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 Conten=
tPasted1">
Reviewed-by:&nbsp;Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 Conten=
tPasted1">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 Conten=
tPasted1">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 Conten=
tPasted1">
Jack</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of YuBiao Wang &lt;YuBiao.Wang@a=
md.com&gt;<br>
<b>Sent:</b> Tuesday, 18 October 2022 13:37<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, YuBiao &lt;YuBiao.Wang@amd.com&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Xu, F=
eifei &lt;Feifei.Xu@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; =
Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Tuikov, Luben &lt;Luben.T=
uikov@amd.com&gt;;
 Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan &lt;Evan.=
Quan@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Liu, =
Monk &lt;Monk.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;=
<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
If mes is not dequeued during fini, mes will be in an uncleaned state<br>
during reload, then mes couldn't receive some commands which leads to<br>
reload failure.<br>
<br>
[How]<br>
Perform MES dequeue via MMIO after all the unmap jobs are done by mes<br>
and before kiq fini.<br>
<br>
v3: Move the dequeue operation inside kiq_hw_fini.<br>
<br>
Signed-off-by: YuBiao Wang &lt;YuBiao.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 42 ++++++++++++++++++++++++-=
-<br>
&nbsp;1 file changed, 39 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 1174dcc88db5..b477bed40d61 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1151,6 +1151,42 @@ static int mes_v11_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 3, AMDGPU_MES=
_SCHED_PIPE, 0, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable the queue if it's active *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, regCP_HQD_ACT=
IVE) &amp; 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;usec_timeout; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(RREG32_SOC=
15(GC, 0, regCP_HQD_ACTIVE) &amp; 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_HQ=
D_PQ_DOORBELL_CONTROL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_HQD_P=
Q_DOORBELL_CONTROL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_EN, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_HQD_P=
Q_DOORBELL_CONTROL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_HIT, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOOR=
BELL_CONTROL, data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOOR=
BELL_CONTROL, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR=
_LO, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR=
_HI, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR=
, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0, 0, 0, 0);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring.sched.ready =3D fal=
se;<br>
+}<br>
+<br>
&nbsp;static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
@@ -1202,6 +1238,9 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring.sched.ready)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mes_v11_0_kiq_dequeue_sched(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v11_0_enable(adev, fal=
se);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1257,9 +1296,6 @@ static int mes_v11_0_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;static int mes_v11_0_hw_fini(void *handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring.sched.ready =3D fal=
se;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB44587D4F651DFF2C6EB385FFEF289MW3PR12MB4458namp_--

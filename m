Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C639C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 09:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7499613FB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7499613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2A8857E;
	Fri, 14 May 2021 09:23:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298A86ECF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 09:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8BmwbjmhpgTpEra+JLZBHg0UHOG6EyW6jKH26+qAPoXnPUR/8OctOVRxXvLfLEbn0sWCfb4P8CjboKemJ1gYqKox3mrs9FUagfLlp0Ka4Lkmz4wY/7uX5Pgl/M+H/dRXw/bDDmDMPcq0CcBZAvoedAvX2B/k3iUUu40BKUgd9SYi+WYk4FcbfmHiId0ELRTWByQDyBVR+7bA75JEEmw7dcMZgv0gixiOkonQzfDn4S4CDOWX/i4MYt+SPHsmj+5rCibkzL4oL6s7OSpQH1yMtm6NiQuZEzMiFCo8umjcHTC0cLtOvVOpy+kf7w0XulHVc4hxGj9PbSUanpYgwU/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgPDbsFOcPTrn/c60Nx826NL57d/cEh28CMKrox6a30=;
 b=eZ7XbdxKf/7qnr3rz1NsqCagZJQ2epNIMIkm/gko9UIakvX+jxXwHy5/lGVmePqPlRPYQW6AV9eyvjb6DuCZeB/ELx7MzX17Q5FwnS7EXFeQcNTrISNNbuiaPAMmkj/bgY2+d7JU+fdSMH/eK7LSUFL4g2dgpWy6OsWyD3D0Ttg3lX8+Ju6ObUOyuzPdJTRKVHV/MaY4bne8lQ01umPJprY14Oyebydt3q73Rix+7uvgj1Dzm8ElzohivvOH7dc8JuE2kZ3DIQFr+4aDPDoMz9sd+nKMEIndlk6RnqKG7GO+bxnRsmoleZFVzLIhminuS4MDtyAaiS0qx8Uv+Ouh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgPDbsFOcPTrn/c60Nx826NL57d/cEh28CMKrox6a30=;
 b=TaQXHGidOD9baES0HUj7jAuRD8nBU7VfESj4sJd/qtXQLFFjTVD0nH9y3K6STtiABg9lfi6BUbWJ/Z8cwq7q2eU45Xvwqh0SHYeM75S3V7mQmHU9zySc6kiA5HhTIIaD8grxzOFAVN+60nTmlaDUjvcwzsyyT1e6UTlEOwjSefU=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 09:23:48 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::e0a9:c676:5e4b:64ec]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::e0a9:c676:5e4b:64ec%3]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 09:23:48 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, YuBiao"
 <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid
Thread-Topic: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid
Thread-Index: AQHXR+Nk+ZWA+hoZcUGHp6RFPZMP/6rhc/0AgAFBXXA=
Date: Fri, 14 May 2021 09:23:48 +0000
Message-ID: <DM4PR12MB5072E1F3B246859B6B1C532BE1509@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20210513103308.601043-1-YuBiao.Wang@amd.com>
 <MN2PR12MB448825CC5EC52F626AEE1938F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448825CC5EC52F626AEE1938F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T14:11:35.930Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f643c510-39ea-4513-dbde-08d916b9fb1b
x-ms-traffictypediagnostic: DM6PR12MB5535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB553571412831EC7692C83AC6E1509@DM6PR12MB5535.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UIgr6U38d+gzXoo0MDAboQDJSe1KTNfeP4ANDSYAX2B3JgfkfU7bypBm5jBCFpD4qKCutjzLd2xpGnBcz3Whld/EuZRoZxCFEnc/w5sBosKWbNY2iIe7bLnFhemODfhyQ9UJaODQVMefFWFaHKcU0yP26pAENTzQOltDKYTzS3A7jrxq4mUKfU4ss1URybfPd5tCvUQjFZW5saYDF8ZoZPGymxOttjyoEXzI40tgk6sK4Cw1fnBKy+G31nZ4iRsXJf3QeqDqcbf5q4XJYb7PnPZE3ArMO5g0WG/4mT1j0rWydqneKfnrsiPJVVx5FaTFOeENPfzU/680nSkeNRrzzEQjcMEZJo4eCg7m3lBIM8gSSz1k78nHJ26Q/+SH3Ed7Mq6irqkSc54YK0KKjAKDNzxd590t9iHHStWp9w4LGHNrWflZCoSkTRXLrR1snF1uat6+MdxBfyB6CEoZb+DExViJw+B5zak1djGHy5zHAEzQE7HNaBCEofPCEqpsak3uR87uRLGLbuz+U2W5LYwXCTLNcjc9SSmpuTQVS7JGAV8kMahBdhY0uj1hADgcMt9T3PcQzRoR16rVIASqLSSUb8bz3L7Mp8l7EFAGCS5O6I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(478600001)(66476007)(6506007)(8676002)(66446008)(83380400001)(66556008)(9686003)(71200400001)(26005)(4326008)(86362001)(64756008)(54906003)(5660300002)(38100700002)(33656002)(66946007)(53546011)(76116006)(55016002)(316002)(52536014)(122000001)(7696005)(186003)(110136005)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kzxRi6J7aBQxzdcItPiX62YycX3RgwtpkksaXZ70BY4eXSXsYA7m4EKG7Csp?=
 =?us-ascii?Q?bzFvvhjS5/ToMHZ+AdF8/rh7TFuy4/pKSAGyxyPYogcHFemTXIl7Jg6sDlJD?=
 =?us-ascii?Q?JUK5w+T4LVfzHWM0V932nVGFCSFollVWtvXOmXZSXUBpJFQyBAQD1ATdT+tG?=
 =?us-ascii?Q?u3e8uKkXph1E4TXKwKX4CRgTEqEFcI06/hzNLO03CJyKa2yQ3VRojrimNYqS?=
 =?us-ascii?Q?5KlBlLsGTld7qMtOU2YVYfnKJvVBPKs3nGGvMUupGOUnQn/fi4QElJSA+PE3?=
 =?us-ascii?Q?mIwkDVgNF4dQF6TvvOgDU+R/D3RhhT7QEl9DZZs26Tb/mqDSBgQ/VMutPCxq?=
 =?us-ascii?Q?5A3xCWMMsA1+xoPBRLff2mYIw5r6Yh7dqlswL19c930Qn8jMPioT6ONWT1EB?=
 =?us-ascii?Q?R2ZaCxIVjDVRBBEcJkijEs4dgT6Qvc0UWYvszPeqdZGyVW5xtADypGLgHFD7?=
 =?us-ascii?Q?FHKR40194aRvEBlnj6Hx2EAVWrOw5f8qOyw4gfq2Dkm87L3FagaIzNvl+y1Z?=
 =?us-ascii?Q?D6PtTLMIYxsIoGND4keb87XRBRbrnXmR5IL3bmTMNyNRGqLgxbQTEbep52S/?=
 =?us-ascii?Q?jFW2EJ/qdc5SmqhVcxcIPluH9ndyLmFYLykJ+hc+rByXj08oEDMaIPU0ZNpz?=
 =?us-ascii?Q?q1C7ZNMWkDEL6fDb//s8xXUBXUL1Mz/wdthHFzhEEmmqemN/SZqhTrOGTqHh?=
 =?us-ascii?Q?69pVfDD6FVyQAbbOjwHGP5J/x2hOWqX9YqqDZnJpr6dPE2ljyOdvorfTdJ9g?=
 =?us-ascii?Q?FaAH6vC4uroZqUoZ7Vgy/8D+dODtR3xFRsK7hU1K5/1gA/al7yX6d2cVdEXq?=
 =?us-ascii?Q?+uW4xdnLI6SkYsLQYAf5385BPLkAWkt4+oo9BD7IMh4vm6O+PQgV0/xvn+JF?=
 =?us-ascii?Q?ZJe+CPwW9okaqvSSeHbZT2xo+pNABfzDRRwJCsI1rgzMQsnFa/+ByNPQQGtV?=
 =?us-ascii?Q?eJO7OaD7vANA7Q0OY9sJDNl1nt4Xdt2Bb6CtF8VIDGHkrsE8c5WlXm1x0ImC?=
 =?us-ascii?Q?P2skpBM4lxhhhVkzHP0rtM+UJtVuoD9U/iQeaPm56feMZYKZkiUztm8hlgYk?=
 =?us-ascii?Q?oE7UYs9ZQWCHWKB0IJSGWlNh8/I15kMoIxJlAZXKR6+n+j4pJaPY8vgJbX+u?=
 =?us-ascii?Q?r+e8fVV2TRe60/oxnYVBygXb9kKbpB0nmR4qoR/1cczu11O4no2X3x6/KIZr?=
 =?us-ascii?Q?j9rAjt/oCFbHwktQgfYVs745FNnou7QPRWbKkwim1oOJbPYrG4Ila8L+JEmX?=
 =?us-ascii?Q?hfc0Zy+ghUn5nB5LLIk3tNbr3Y/we+ekKminndfrhAFfXIzEMRktiRd7IWKp?=
 =?us-ascii?Q?tw9YXWgkG5A0PRPLwob6d7aL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f643c510-39ea-4513-dbde-08d916b9fb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 09:23:48.6576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trCzDDjo5DzjpbvGZ5HISHOJRx3Y8T6VtsSVlRkebxfNksxfYXQvNd6X6dagSUMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0465370754=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0465370754==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB5072E1F3B246859B6B1C532BE1509DM4PR12MB5072namp_"

--_000_DM4PR12MB5072E1F3B246859B6B1C532BE1509DM4PR12MB5072namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Chen, Horace Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, May 13, 2021 10:12 PM
To: Wang, YuBiao <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.co=
m>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichl=
id


[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: YuBiao Wang <YuBiao.Wang@amd.com<mailto:YuBiao.Wang@amd.com>>
Sent: Thursday, May 13, 2021 6:33 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com<mailto:Andrey.Grodzovsky@=
amd.com>>; Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Chen, =
Horace <Horace.Chen@amd.com<mailto:Horace.Chen@amd.com>>; Tuikov, Luben <Lu=
ben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Koenig, Christian <Christ=
ian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; Deucher, Alexander <A=
lexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Xiao, Jack <Ja=
ck.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>; Zhang, Hawking <Hawking.Zhang@a=
md.com<mailto:Hawking.Zhang@amd.com>>; Liu, Monk <Monk.Liu@amd.com<mailto:M=
onk.Liu@amd.com>>; Xu, Feifei <Feifei.Xu@amd.com<mailto:Feifei.Xu@amd.com>>=
; Wang, Kevin(Yang) <Kevin1.Wang@amd.com<mailto:Kevin1.Wang@amd.com>>; Xiao=
jie Yuan <xiaojie.yuan@amd.com<mailto:xiaojie.yuan@amd.com>>; Wang, YuBiao =
<YuBiao.Wang@amd.com<mailto:YuBiao.Wang@amd.com>>
Subject: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid

[Why]
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.

[How]
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com<mailto:YuBiao.Wang@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 12 +++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c
index f4e4040bbd25..5ee923ccdeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,
         /* enable_intr field is only valid in ring0 */
         if (ih =3D=3D &adev->irq.ih)
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enabl=
e ? 1 : 0));
-       WREG32(ih_regs->ih_rb_cntl, tmp);
+
+       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
+                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+                       return -ETIMEDOUT;
+               }
+       } else {
+               WREG32(ih_regs->ih_rb_cntl, tmp);
+       }

         if (enable) {
                 ih->enabled =3D true;
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABL=
E, 0);
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABL=
E, 1);
         }
-       WREG32(ih_regs->ih_rb_cntl, tmp);
+
+       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
+                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+                       return -ETIMEDOUT;
+               }
+       } else {
+               WREG32(ih_regs->ih_rb_cntl, tmp);
+       }

         if (ih =3D=3D &adev->irq.ih) {
                 /* set the ih ring 0 writeback address whether it's enable=
d or not */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 75d1f9b939b2..2ec5d4e1f363 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -764,9 +764,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
         case CHIP_SIENNA_CICHLID:
                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-               if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_P=
SP))
-                       amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_bloc=
k);
+               if (!amdgpu_sriov_vf(adev)) {
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
+                       if (likely(adev->firmware.load_type =3D=3D AMDGPU_F=
W_LOAD_PSP))
+                               amdgpu_device_ip_block_add(adev, &psp_v11_0=
_ip_block);
+               } else {
+                       if (likely(adev->firmware.load_type =3D=3D AMDGPU_F=
W_LOAD_PSP))
+                               amdgpu_device_ip_block_add(adev, &psp_v11_0=
_ip_block);
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
+               }
                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP &&
                     is_support_sw_smu(adev))
                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_blo=
ck);
--
2.25.1

--_000_DM4PR12MB5072E1F3B246859B6B1C532BE1509DM4PR12MB5072namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Chen, Horace <a href=3D"mailto:Horace.C=
hen@amd.com">
Horace.Chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, May 13, 2021 10:12 PM<br>
<b>To:</b> Wang, YuBiao &lt;YuBiao.Wang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; Tuiko=
v, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koen=
ig@amd.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking
 &lt;Hawking.Zhang@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Fei=
fei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt=
;; Xiaojie Yuan &lt;xiaojie.yuan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienn=
a_cichlid<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> YuBiao Wang &lt;<a href=3D"mailto:YuBiao.Wang@amd.c=
om">YuBiao.Wang@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 6:33 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;<a href=3D"mailto:Andrey.Grodzovsky@amd.c=
om">Andrey.Grodzovsky@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Eva=
n.Quan@amd.com">Evan.Quan@amd.com</a>&gt;; Chen, Horace &lt;<a href=3D"mail=
to:Horace.Chen@amd.com">Horace.Chen@amd.com</a>&gt;; Tuikov,
 Luben &lt;<a href=3D"mailto:Luben.Tuikov@amd.com">Luben.Tuikov@amd.com</a>=
&gt;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Chr=
istian.Koenig@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Ale=
xander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao@amd.com</a>&=
gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zh=
ang@amd.com</a>&gt;; Liu, Monk &lt;<a href=3D"mailto:Monk.Liu@amd.com">Monk=
.Liu@amd.com</a>&gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">F=
eifei.Xu@amd.com</a>&gt;;
 Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang@amd.com">Kevin1.Wang@a=
md.com</a>&gt;; Xiaojie Yuan &lt;<a href=3D"mailto:xiaojie.yuan@amd.com">xi=
aojie.yuan@amd.com</a>&gt;; Wang, YuBiao &lt;<a href=3D"mailto:YuBiao.Wang@=
amd.com">YuBiao.Wang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_ci=
chlid</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[Why]<br>
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.<br>
<br>
[How]<br>
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.=
<br>
<br>
Signed-off-by: YuBiao Wang &lt;<a href=3D"mailto:YuBiao.Wang@amd.com">YuBia=
o.Wang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 12 +++++++++---<br>
&nbsp;2 files changed, 27 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c<br>
index f4e4040bbd25..5ee923ccdeb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable_intr field is on=
ly valid in ring0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (=
enable ? 1 : 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
amdgpu_sriov_reg_indirect_ih(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
PSP program IH_RB_CNTL failed!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih-&gt;enabled =3D true;<br>
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_=
ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_=
ENABLE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
amdgpu_sriov_reg_indirect_ih(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
PSP program IH_RB_CNTL failed!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* set the ih ring 0 writeback address whether it's e=
nabled or not */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 75d1f9b939b2..2ec5d4e1f363 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -764,9 +764,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;nv_common_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gmc_v10_0_ip_bl=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;navi10_ih_ip_block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (likely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP=
))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;psp_v11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(adev-=
&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v=
11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(adev-=
&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v=
11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD=
_PSP &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_support_sw_smu(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;smu_v11_0_ip_block);<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5072E1F3B246859B6B1C532BE1509DM4PR12MB5072namp_--

--===============0465370754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0465370754==--

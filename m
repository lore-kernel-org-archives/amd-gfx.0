Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B9C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 04:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA0410E592;
	Thu,  3 Nov 2022 04:07:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869D610E58E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 04:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7vscAdnyOSepnfBHLthZUISXeK2TQOyK0eV7uhrdKjh6zPoD4Svw4uBuz+5unXZb7l9FrK8GYusw03L4PsX74gE9lZ9iVfgfogHqyBOTw0efDTBrK523fetrjYcLMSJ/AjDNJ+LKI9EhYk3qLsQxIp0ZvU33+037J2RAOq9KqQiBAji1pMg1ixQl9zEW8wm+qNPo3Oq9N+ej50/0CmAOrALhjYeVKyVaI0mUUpvNQO8x1zhbFOhJ81Ju3Qj+Dp6aK65V1g1sm9rv/bjMHyEf2PC9e6/Vw8XwHfVp3bSeH60y8uG+E5PsFYS4n4Swrfh3C+XkFU4rcaEmwrxVq2vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMEBBRwRGoe6XiExBH6b9BIA/JHXDjHUpEfH2li2tyw=;
 b=SSD+rD0Df0VyovfXpIgXclJASQb2fNNzLFmUxXzEqFPfALQ3/tJw+ua1CZ4R/UjMQczFs+39VvCplJueXRmOQ43tUoKzRIubi1T2kCyZ9ljtshG0m2CTDos+Com62arCjD4h+Sd088i74lb2Uhk4Ll95dzxVJdYDM0yzA46G9KMwKdlpWjgtIjCa8AQjJvX59Z06OrrDYgZPx1F8aDGMwZqLd6GJmJkyeUY/SmJbaUwjpo8umZq3prx8TRMSJun1r2cWpmI5wzxTdbtX0o6b7hTK8VaVtZTnKq7QkiO1l63sEYSCgGYF5ewn9PPsE7tM91P5Ncfj78LAUcBRxZK7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMEBBRwRGoe6XiExBH6b9BIA/JHXDjHUpEfH2li2tyw=;
 b=ekrYFT4La3QcrdCKAwObb+BVSmxs145w4utcl70LfNAIOF394Kft141SVv5cHwIC4nRXqdIs2JNvwjWm+JKmC8k91S96DmI7EnEJFUnNH/d+iZJB8LfxxM2CP1Wu+KOP9usPqRtBDpc9LY0mRn0Gc2fFmJBmjmEgyWPlYlPZemg=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Thu, 3 Nov 2022 04:07:37 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::5ca6:de04:a733:69b3]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::5ca6:de04:a733:69b3%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 04:07:37 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Thread-Topic: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov
Thread-Index: AQHY7zmg7Jkp1P0N1UGaQyHlZJdBYK4slOZA
Date: Thu, 3 Nov 2022 04:07:37 +0000
Message-ID: <DM6PR12MB43400434192DC55507A93424FA389@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20221103040605.796752-1-Victor.Zhao@amd.com>
In-Reply-To: <20221103040605.796752-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T04:07:33Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6eaaa2c-8a79-402a-8f8b-d1d39d486a5b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-03T04:07:33Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: dfe5ab84-6474-47b3-a53e-877f7b89804e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|CH2PR12MB4086:EE_
x-ms-office365-filtering-correlation-id: d86a869f-362a-4c14-0d00-08dabd50f177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3+q041p1KMwy9HqHgAZ26Wt91uYFHZxUZI9uo8XHK2JBoMl5RDnRQufrOD1fWw6TKlSIOYXJo9+KaSHDfjeuGskpJuHYYKBX3pSU9HPQfZ6p2BtHA0czOSHugqV4PI3JO98Lq6qd+tVQSr9uMc+Kqo/jB48gGHW9Pl/6fL4aGwv9yPFgMmRIurAaaee9HXDK0ExgiN0DMWB8zL4wUUsHROjXV/6sJR9d95DwZkZ08cgHGjSPDiNXYZkVoHebu1VxXgDe1uCvOzyYsuNwNH7xFaxr5z6VXZnI+OLnHUNPGLrKZ5csGKYmerPQLdbV8Z8K2M9a0r83gufifzFbGMtrENsPCMPqFxjotI42ohZowybK7abtGP7D2BaB2vaayeXTYeyevjAS167DjWhOO3W/SFH7wtwL+2s3MPelyXSo9c25ls95fbXTkxk7excQ2l26U5Kcs9XXc/vpQi/Rvrd39i9jnzp+/mo08DidpU+h/5pk6ktrNWzRtkKlr8RAWG4sKlZvbpkIGC6iD8TimTz7voKyeQfPkjTRqmA76FSKiUUa1lOJQgWwkJGFbQhJjNqqNmR2jHahKSIiKkMJU7TO+WwG5/gY/zUCmip4wWKDlalEqVvFW6MNA5ugqv21refdo1k8Csa/K8GmoNGCj5DbqchR1H5gRHPJ67eURopj64SIXnGjzYJku8SaDbQt0SL775RKT011nYBpUqwh+Kx/IO+ppCYSbREnUrE896Ls6WIYdvsihWwc5riu6u+hdk4NLDISoaDrQk2MDI7nXzUKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(83380400001)(4326008)(8676002)(66446008)(54906003)(478600001)(66556008)(66946007)(64756008)(76116006)(66476007)(186003)(5660300002)(38070700005)(6636002)(41300700001)(33656002)(110136005)(8936002)(52536014)(86362001)(55016003)(2906002)(316002)(38100700002)(15650500001)(71200400001)(122000001)(9686003)(26005)(6506007)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GlSovTp4DsdQ7WWwZC8TlW/0tLsWT0Dwf3NRBI8N1kFAlX4r2QmL0VTVMfHR?=
 =?us-ascii?Q?N5gfK4siuGc1pU3Q54Gk6tHprhGA1zY9vbJsXyKm+phoHkZpR/oxv6NZj/MV?=
 =?us-ascii?Q?mNGqjsRwhBBS/uDD5tz+9moQsEyjiXK6cNeILhaHw/mGrC2VUwy7+r5cUagf?=
 =?us-ascii?Q?kziiGd15DdlAB8QvK+qq/XotTacCQg+RdkOPiOXWmJkk7Heo8SCmmSj0Sh/f?=
 =?us-ascii?Q?pNmSqR2pnqr4ikCfYz123ntXPGAXL/yN93Exr+WI0tJh3/U+rzxiIFclzkNX?=
 =?us-ascii?Q?jYmAPrSv3aCR9/6xRjVJtPAJ3pVe2ISGGGsCNkMFrvLcVF36C+lWrQb0nKei?=
 =?us-ascii?Q?vH1TIsNN+mAa4FytMSSwtwJntKin84XMfiJebciFsxy8bMEnenEvM7P5ktFD?=
 =?us-ascii?Q?0sHvgKOCwJWWtQrY12ReNM8Zh3KcXIR6BJs/mmJPxBrTh5ihLNB12JwlHSEr?=
 =?us-ascii?Q?RqDtpasDfy+BuW1e78P8yst3ZPkY5HFqhXJcCt/izbkOIeRzNBdayvve/H/g?=
 =?us-ascii?Q?Kx0wdGfpWij8TWNAz1w4Lp0hsA0S8t+7Qn/4yvai4tAFTVtkIA8Q61DMbhyv?=
 =?us-ascii?Q?ADqMOgnq6p78sMNI1IJrfIl5D9qdVkEc77xh4c18f7VNtcfPNreQNEje6u+j?=
 =?us-ascii?Q?kJeqItw/Pm9RdHEYk/4XgXm1HoSHP4k1OKL5B8tDLGkZ4NzYir52ErLg6Bie?=
 =?us-ascii?Q?vxisLzqJP5QcE86Y8MjxRtj3V9mS1LS0UEyPuoLg3WhgbZZtKdcZg/LC7pyX?=
 =?us-ascii?Q?b/OhDYOd9etFUwv/hsHLW8a+T7KTFCWjDNvlTfbMzA3uHxJQjQsGMBDABm5m?=
 =?us-ascii?Q?NHppOuJHoxpRAWsYSbzsuIR1TwOKdZudV1ct+8ysviBEpWxmnEPW4jmxJhVe?=
 =?us-ascii?Q?JB/fusB7+noBtNZxfyb1V91gRgmeKW2QvnKjNVezegEAeqX925+mCF18yOwY?=
 =?us-ascii?Q?5sRqKQj0RHmF0rgx5WCj799wtR1wfcu3iRKS/lzqd8zkeJqkXp/591ISC3GW?=
 =?us-ascii?Q?zrVqnCah6SSNZwcEMQqz+4vcNf171cJU+LqHbP0bzD6UOvYW2QCA72+vajMh?=
 =?us-ascii?Q?NpuewQBh3bavFUbd0/E/JvxAEw7TEJNNcUPJRvulyMrEF8F8INTtD8EGcVVf?=
 =?us-ascii?Q?Wpr7DvlH1VkcU2Kliq2hbSesfmnkb2v2e3stReaTFAof4uoZShFxuSR1AU2x?=
 =?us-ascii?Q?NvfCocgtDekaIoQFimGS/N0/i6j1enlTMJgKCAN8IDN43ItkjLXnHazTGql/?=
 =?us-ascii?Q?y0uMQR/7D/qPsK962JOQKao8muizeVivE257ImzGwIIbbD1uAlH+s/RVEeWB?=
 =?us-ascii?Q?uU8CzhPGUOn/9fUWIenn8q0LynZ8kIuB8NGL9iuUdVNLkmU+skOWQ/xQwprs?=
 =?us-ascii?Q?E6Y51V28jasbQNOnCazraX0JF46i2MarAGMVrnfqvm7GFHeSyHTVL4v44VGq?=
 =?us-ascii?Q?+o2u2uZuJ20RKRoHbffITqhwmbGt9wPKhk90l7ifvMNe+0xj3azEwlfmE5zi?=
 =?us-ascii?Q?j0HRrzR7pWyBpIGjE/xPapLip8RWolhIYdPMvF9r6R57VR3083m9nsb6O+js?=
 =?us-ascii?Q?KKzTIMbpTC88GOV4s+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a869f-362a-4c14-0d00-08dabd50f177
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 04:07:37.2178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJlzkNY8EppR3TVk6PpbFsFO1a6gzVLGsBK511LljLzx7WSgaLfCjT9FZHiQAj7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
Cc: "Chickanayakanahalli, Sirish" <sirish.c@amd.com>, "Zhang,
 Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Alex,

This is a patch fixing the sriov suspend/resume sequence. Please help revie=
w.


Thanks,
Victor



-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>=20
Sent: Thursday, November 3, 2022 12:06 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: fix for suspend/resume sequence under sriov

- clear kiq ring after suspend/resume under sriov to aviod kiq ring test fa=
ilure
- update irq after resume to fix kiq interrput loss

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 522820eeaa59..5b9f992e4607 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4197,6 +4197,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)
 	}
=20
 	/* Make sure IB tests flushed */
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_irq_gpu_reset_resume_helper(adev);
 	flush_delayed_work(&adev->delayed_init_work);
=20
 	if (adev->in_s0ix) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 7853d3ca58cf..49d34c7bbf20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6909,6 +6909,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_rin=
g *ring)
 		mutex_unlock(&adev->srbm_mutex);
 	} else {
 		memset((void *)mqd, 0, sizeof(*mqd));
+		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
+			amdgpu_ring_clear_ring(ring);
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 		amdgpu_ring_init_mqd(ring);
--
2.25.1

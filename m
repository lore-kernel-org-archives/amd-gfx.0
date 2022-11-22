Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBCC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 02:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEA910E35F;
	Tue, 22 Nov 2022 02:16:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF0B10E35E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 02:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=der9xJwQUHbEdEGZId6qjl5wpN1lxnZhmOWvLbmOZc2dnwR1rfMqNOutR55IJQth4B2ThA1OUmH2a6rChWFMvbN0TI/DJTtYGcZEvAi/vsWGi8kO+f65QAOqNPCsQxeKC0ROfTf//ccXEXODlp1v62D/G/zYEgtN/YpkF6P/5dpTUPhhhcEdM9DT+oTUCAex3eFE741prxJCvIR4unbouqAmytcScjrZdLGWSGYAJgSOkQ+OYbKvpIFI88gxmbWIOADe46h/uD+Qf7BjLY38cpImkEHJTr8BYyH2eBJUXKZcSRExNlkq6+dU0KtSCJdduFIdMm9nZJmu/Wpn9YnEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M44dcbwdOBpVxh0pBe2ts+vC5eTndgsxOQLVhmBp5M=;
 b=juB8WzWkt+ad1lr1Fw3cwU65UbnrLSzxbvrOdW8zuLza6hAaudJd/G1dAt3kPPOTC3TFLdZ4QfzQjmNTohY6eYjZ+Azpc7OLQ2awT+BVvVGcpNk4P9WhTkWII02hibBCUxZzaTzlDKo924IseN0oF5KCMdlG5U8BXoEx3mTvKbRpN562umhbbaEU+axFJu3K/Dy429TjMBlJXdCyrndGWg1rPHDHPdin3H3Eid510l0X64IDpyXgkkqVmZSC99DZkMHBDMq/Fu7WgZw0kAtevaHF0W2oo30DNWHpqyFgCSfOZnXjt+IR7MuB0OjdlFgcTlwgPjN3bDYp95aPoqTpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M44dcbwdOBpVxh0pBe2ts+vC5eTndgsxOQLVhmBp5M=;
 b=ZIOXvx8RdvhXTUfOUzXnN3UOsDboq6YHtuUOf1zPo/vTlzcpEHGY4JGSnCp5tUsdL9CKULeV8vve0EnbaQfYGWXRaWxkta/1JHXoQyoG0/fEvkdnek0TcnFzdamKZCMWiGNIwyUwDDZR90vI5JcEQmPC2uohEk+KMbQ1PcnaVCw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Tue, 22 Nov
 2022 02:16:28 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 02:16:28 +0000
Content-Type: multipart/mixed;
 boundary="_000_DM5PR12MB2469FEE0652E6FC89ECA382BF10D9DM5PR12MB2469namp_"
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag
Thread-Index: AQHY/UGv+8SxDMuFvkyD4G1fJ3aOgK5IpswAgAGPbhA=
Date: Tue, 22 Nov 2022 02:16:28 +0000
Message-ID: <DM5PR12MB2469FEE0652E6FC89ECA382BF10D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221121003858.3296035-1-guchun.chen@amd.com>
 <BYAPR12MB4614CF63A50968A29AB037A3970A9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614CF63A50968A29AB037A3970A9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <DM5PR12MB2469FEE0652E6FC89ECA382BF10D9@DM5PR12MB2469.namprd12.prod.outlook.com>
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:24:46.6738656Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH0PR12MB5607:EE_
x-ms-office365-filtering-correlation-id: 8bc5e650-3734-494e-2d86-08dacc2f90a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUdlvbptwLkySZokPXJsZAfTDUhrqKSsr4ga3h4eiqRVudlWwWlIW92tIkuYlL6IxVIYlIklcjeWU2n0qpS/ICBdO3ZTzgLWD2YxV0r9hsc3QcVJNLZUBvrFXUeop+ywUs91SnCfRod69DIbZhZ1De5ZbsRZmzLns/hs2CQvjLc7k/8c2Fx6f4Oat6ddyXDfW5INW0d3hLSa8QsGYyw4A6VOlQu5GGX9vcr8wlrjoyDwpCIlER3gYUfHXa19MC5cE9Km0EtG2zorzdXjkUg5HIlADADc0Ypq/bnjyvHlKBVw0JJ0mTUnIoy5GlYY4C/qRocexjfDeDEL12T/8Jv55ZPPnZ4I1IMazqbHS6O3g1LdDcutqU9nDZ5cDz4CMaZ7F/ey7vSAVO/tbeWcVayCg47AJYBuLiXFKedSPkcQYQCDmey8On8gbZVbIYmlirXu4O2bmqdJ1Pv214Wk+owRej5Z9H7BowiVRrfSBGKAkSP2JiPjC446xYJIfIHymki9F1PzYDaVdUam0hKiaz3D1y3Z55yeG5ak1DjbnDY9gmqDqMxX9qfYrxxlHnmtWgyYh9LePZqLTbzax3N8aUfjtZCklXbGNZPwtkTrR4QLxu6+0epICdGor4J4S6+o5bStjQMis86APMCTN69zg+QfsBzMJA1HdbCnDa3i6cbMZ9O+XlDvElFnjucLm3JLr2Bv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(86362001)(122000001)(83380400001)(66946007)(8936002)(38070700005)(2906002)(6636002)(26005)(66556008)(66446008)(52536014)(66476007)(6506007)(38100700002)(53546011)(76116006)(55016003)(7696005)(71200400001)(41300700001)(64756008)(9686003)(5660300002)(110136005)(478600001)(316002)(186003)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSaxvrQyVs3ZrzPJhlWAHQCR4RN7Rf2VsGf+GZEgoNW6zWeM8TRuxwMoPmqw?=
 =?us-ascii?Q?MuVbP8KoR46dZToH2Guas+guZVIeoDgR47Shk29iL2nXORtJ35wLIeJ5uScf?=
 =?us-ascii?Q?mqCpe+Hn5NzgfHMZ6emgpjwskWdyqIEB2kfKN7oQHCdoLyUa0YpKywDAYqzX?=
 =?us-ascii?Q?7SPhzT/UoIwKZEeTjulNTpnMiprG+XbmA2pIYGz59vo4DjLU6Bzx8z2/7AKR?=
 =?us-ascii?Q?ExtXDuSOzdnMFBYJ1cU3fBQgYlBQacEQVFA5DrpRZTOErLI6LQacXPuD763L?=
 =?us-ascii?Q?LxQZYjZrq958hRlYI+ThxoIadkm2J5YqUk7YpQDjJEf0+so+ytqkgLnUJX/O?=
 =?us-ascii?Q?7rNb7eg9zu4jjwbcRZdObPlS4tSynlOGn/rjjk+8Tu05zQacv76zNhw69+Xe?=
 =?us-ascii?Q?FFcTDbQPhXul1hHbdE1jlOaZ4ytLH4K/O43tXRQ8Coz4MlfMklizJKrGu+O+?=
 =?us-ascii?Q?vYkaWCS+ioQu6f4fXxRNqQkP9c0RYNljkB8K2wZYRY3p2mAYRLMedQpaLk3a?=
 =?us-ascii?Q?ydSpH7YY3X6wt+xhYn54H3cU4IH3k/HgmEIQ4tZ82CNvmstZYbCciQpQ53hn?=
 =?us-ascii?Q?+w9q3M9eNosWtlLZ/WvMzJ/59oQZmB1X/G0NbHhncGMTpLiC2XHX1kB4KnfE?=
 =?us-ascii?Q?8Cair77oKBoNO0G94idY44q0Q6jsqagG+RCwPJDTTSFHvhsifdp6vF1CQZQF?=
 =?us-ascii?Q?Y3+QOR3IcYImgFBk6xhXyf9VDRlSqVO0VWiExoVpKLm5FOaIj8mKpudZ7l4m?=
 =?us-ascii?Q?Djadz8cOQnF7bJIZnG2SAGu3FLng7QarCJ2g95zjDJQiiAzV+0qUK+Vb6H8g?=
 =?us-ascii?Q?srBbwrcVPQ4OcsEpzld7qwI4ZkJygxhm8UnnbyV5QtHf3erOxPK0wC/Igi7/?=
 =?us-ascii?Q?b/KxgAjN7IffMWFH+JdeKQcjKEn00WvuiwNevGn65WT4rOzncVKdauF5Lj/t?=
 =?us-ascii?Q?AiqlWViKLPmnZ/y7cqLF4rf/VbSaQPTUDucz0SZf1aJKsV2ep+k1JF43I6SV?=
 =?us-ascii?Q?YQJ1i7e24LVxpJriXU1YXP8DdJVUwdIieIKaRbCNDzL03Ix/kMA10xvmRMbm?=
 =?us-ascii?Q?Te0BehPwEN/X8BKIba475GX7qdaarUctOkVy1pqoBYMkNZfUOQTsgvEHaicb?=
 =?us-ascii?Q?EgZnIwfoVVa8DkIUA/sqonKDDkym0ZpCwvqVA4OQ1fgcAjZLtZ4bpPeoAt6s?=
 =?us-ascii?Q?UCVoei6f1ZBs0U7z3Y2XAFm5VqA0Lk887G67SPdMsxrCH/pjuR48pTO26BP1?=
 =?us-ascii?Q?OxMrDYGEmL2r/60IGFTVEMcGsOLjWOcssBJbmY6HCxteHRHx1gpWWoPBl5zH?=
 =?us-ascii?Q?Z4YeK8bhPhj/+p9MAFZcOsnsmet1QP93q1UoUZ3B1tuQPVnM5g5jQr8eOLsL?=
 =?us-ascii?Q?pXpqNmdoS0ZagspiWCliacdM1DGfVAyjph+K7T1WwyJzM1ra3ViS9/KudzMU?=
 =?us-ascii?Q?ZoF+ipfRlSv8WKR5tQtBdHpQCdN7kGLLCIUCYyizGpVmMa48eV6OfPCyZnPY?=
 =?us-ascii?Q?uMNi5D8e0H82xEr+njTIJkH1mux8qkN/Ibn+r1NUX7lqto+G+jc8jMWTh0rG?=
 =?us-ascii?Q?i3CxyrhbB6Qd7Rc+H7P8gqE4Be+y3hZIWF/GR+Nt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5e650-3734-494e-2d86-08dacc2f90a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 02:16:28.8060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMjD9EwQxIY8LXeCQkO29IsoJP3cBtWwiqFkK5p4FXZjc6gxfEmw/rdJOuZxw6YJ3ie0kWl2vMMQ1VHDa5WRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

--_000_DM5PR12MB2469FEE0652E6FC89ECA382BF10D9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Good point. Let me update it.

Regards,
Guchun

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, November 21, 2022 10:26 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag


[AMD Official Use Only - General]

Runtime PM can be disabled with a module param. BACO state is supported for=
 non-RPM use cases also like regular suspend or a reset. Relying on RPM mod=
e for BACO state is not the right thing to do.

Thanks,
Lijo
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Monday, November 21, 2022 6:08:58 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Lazar=
, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan <Evan.Qu=
an@amd.com<mailto:Evan.Quan@amd.com>>
Cc: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag

Driver was not calling BACO exit at all in runtime pm
resume, and it caused the timing issue leading to a PCI
AER error, as once system enters BACO, it's not reliable
to check runtime pm mode by talking to SMU. So use rpm_mode
instead as a general pm mode check to ensure driver executes
BACO exit in runtime pm resume.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_=
device_capability()")

Signed-off-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 25 +++++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ab8f970b2849..40af21040b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5619,7 +5619,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
         struct amdgpu_device *adev =3D drm_to_adev(dev);
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

-       if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_BACO)
                 return -ENOTSUPP;

         if (ras && adev->ras_enabled &&
@@ -5635,7 +5635,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
         int ret =3D 0;

-       if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_BACO)
                 return -ENOTSUPP;

         ret =3D amdgpu_dpm_baco_exit(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..be03f7b1cee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2532,7 +2532,7 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)
         }

         adev->in_runpm =3D true;
-       if (amdgpu_device_supports_px(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;

         /*
@@ -2542,21 +2542,21 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
          * platforms.
          * TODO: this may be also needed for PX capable platform.
          */
-       if (amdgpu_device_supports_boco(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                 adev->mp1_state =3D PP_MP1_STATE_UNLOAD;

         ret =3D amdgpu_device_suspend(drm_dev, false);
         if (ret) {
                 adev->in_runpm =3D false;
-               if (amdgpu_device_supports_boco(drm_dev))
+               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                         adev->mp1_state =3D PP_MP1_STATE_NONE;
                 return ret;
         }

-       if (amdgpu_device_supports_boco(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                 adev->mp1_state =3D PP_MP1_STATE_NONE;

-       if (amdgpu_device_supports_px(drm_dev)) {
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
                 /* Only need to handle PCI state in the driver for ATPX
                  * PCI core handles it for _PR3.
                  */
@@ -2565,9 +2565,9 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)
                 pci_ignore_hotplug(pdev);
                 pci_set_power_state(pdev, PCI_D3cold);
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_O=
FF;
-       } else if (amdgpu_device_supports_boco(drm_dev)) {
+       } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
                 /* nothing to do */
-       } else if (amdgpu_device_supports_baco(drm_dev)) {
+       } else {
                 amdgpu_device_baco_enter(drm_dev);
         }

@@ -2588,7 +2588,7 @@ static int amdgpu_pmops_runtime_resume(struct device =
*dev)
         if (!pci_device_is_present(adev->pdev))
                 adev->no_hw_access =3D true;

-       if (amdgpu_device_supports_px(drm_dev)) {
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;

                 /* Only need to handle PCI state in the driver for ATPX
@@ -2600,22 +2600,23 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
                 if (ret)
                         return ret;
                 pci_set_master(pdev);
-       } else if (amdgpu_device_supports_boco(drm_dev)) {
+       } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
                 /* Only need to handle PCI state in the driver for ATPX
                  * PCI core handles it for _PR3.
                  */
                 pci_set_master(pdev);
-       } else if (amdgpu_device_supports_baco(drm_dev)) {
+       } else {
                 amdgpu_device_baco_exit(drm_dev);
         }
+
         ret =3D amdgpu_device_resume(drm_dev, false);
         if (ret) {
-               if (amdgpu_device_supports_px(drm_dev))
+               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                         pci_disable_device(pdev);
                 return ret;
         }

-       if (amdgpu_device_supports_px(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
         adev->in_runpm =3D false;
         return 0;
--
2.25.1

--_000_DM5PR12MB2469FEE0652E6FC89ECA382BF10D9DM5PR12MB2469namp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

eJ8+Isx5AQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEJgAEAIQAAADZCRkQ0MkJG
QTMyNDQzNEY5MjFBQzczMTY0MUYzNkE1ACYHAQ2ABAACAAAAAgACAAEFgAMADgAAAOYHCwAWAAIA
EAAcAAIAPgEBIIADAA4AAADmBwsAFgACABAAHAACAD4BAQiABwAYAAAASVBNLk1pY3Jvc29mdCBN
YWlsLk5vdGUAMQgBBIABAEIAAABSRTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogdXNlIHJwbV9t
b2RlIGFzIHJ1bnRpbWUgcG0gY2hlY2sgZmxhZwDiFQEDkAYAVHUAAGoAAAACAX8AAQAAAFEAAAA8
RE01UFIxMk1CMjQ2OUZFRTA2NTJFNkZDODlFQ0EzODJCRjEwRDlARE01UFIxMk1CMjQ2OS5uYW1w
cmQxMi5wcm9kLm91dGxvb2suY29tPgAAAAACARMQAQAAAPE8AAA8aHRtbCB4bWxuczp2PSJ1cm46
c2NoZW1hcy1taWNyb3NvZnQtY29tOnZtbCIgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0
LWNvbTpvZmZpY2U6b2ZmaWNlIiB4bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9m
ZmljZTp3b3JkIiB4bWxuczptPSJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8y
MDA0LzEyL29tbWwiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxo
ZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7
IGNoYXJzZXQ9dXMtYXNjaWkiPg0KPG1ldGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNy
b3NvZnQgV29yZCAxNSAoZmlsdGVyZWQgbWVkaXVtKSI+DQo8IS0tW2lmICFtc29dPjxzdHlsZT52
XDoqIHtiZWhhdmlvcjp1cmwoI2RlZmF1bHQjVk1MKTt9DQpvXDoqIHtiZWhhdmlvcjp1cmwoI2Rl
ZmF1bHQjVk1MKTt9DQp3XDoqIHtiZWhhdmlvcjp1cmwoI2RlZmF1bHQjVk1MKTt9DQouc2hhcGUg
e2JlaGF2aW9yOnVybCgjZGVmYXVsdCNWTUwpO30NCjwvc3R5bGU+PCFbZW5kaWZdLS0+PHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUg
NSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IlxARGVuZ1hpYW4i
Ow0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMg
Ki8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBp
bjsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlm
O30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0K
CWNvbG9yOiMwNTYzQzE7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9DQpzcGFuLkVtYWls
U3R5bGUyMA0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25hbC1yZXBseTsNCglmb250LWZhbWlseToi
Q2FsaWJyaSIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0
DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5Ow0KCWZvbnQtc2l6ZToxMC4wcHQ7fQ0KQHBh
Z2UgV29yZFNlY3Rpb24xDQoJe3NpemU6OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAxLjBp
biAxLjBpbiAxLjBpbjt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30N
Ci0tPjwvc3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6
ZXh0PSJlZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBn
dGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2
OmV4dD0iZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0t
LT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSIjMDU2M0MxIiB2bGluaz0iIzk1
NEY3MiIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIj4NCjxwIHN0eWxlPSJmb250LWZhbWls
eTpBcmlhbDtmb250LXNpemU6MTBwdDtjb2xvcjojMDAwMEZGO21hcmdpbjo1cHQ7IiBhbGlnbj0i
TGVmdCI+DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF08YnI+DQo8L3A+DQo8YnI+
DQo8ZGl2Pg0KPGRpdiBjbGFzcz0iV29yZFNlY3Rpb24xIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
Pkdvb2QgcG9pbnQuIExldCBtZSB1cGRhdGUgaXQuPG86cD48L286cD48L3A+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5SZWdhcmRzLDxvOnA+PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+R3VjaHVu
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7
PC9vOnA+PC9wPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci10b3A6c29s
aWQgI0UxRTFFMSAxLjBwdDtwYWRkaW5nOjMuMHB0IDBpbiAwaW4gMGluIj4NCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxiPkZyb206PC9iPiBMYXphciwgTGlqbyAmbHQ7TGlqby5MYXphckBhbWQuY29t
Jmd0OyA8YnI+DQo8Yj5TZW50OjwvYj4gTW9uZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDoyNiBB
TTxicj4NCjxiPlRvOjwvYj4gQ2hlbiwgR3VjaHVuICZsdDtHdWNodW4uQ2hlbkBhbWQuY29tJmd0
OzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciAmbHQ7
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSZndDs7IFpoYW5nLCBIYXdraW5nICZsdDtIYXdraW5n
LlpoYW5nQGFtZC5jb20mZ3Q7OyBRdWFuLCBFdmFuICZsdDtFdmFuLlF1YW5AYW1kLmNvbSZndDs8
YnI+DQo8Yj5DYzo8L2I+IENoZW4sIEd1Y2h1biAmbHQ7R3VjaHVuLkNoZW5AYW1kLmNvbSZndDs8
YnI+DQo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHVzZSBycG1f
bW9kZSBhcyBydW50aW1lIHBtIGNoZWNrIGZsYWc8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9k
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIHN0eWxl
PSJtYXJnaW46NS4wcHQiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWY7Y29sb3I6Ymx1ZSI+W0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEdlbmVyYWxdPG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiIHN0eWxlPSJiYWNrZ3JvdW5kOndoaXRlIj48c3BhbiBzdHlsZT0iY29sb3I6IzIxMjEy
MSI+UnVudGltZSBQTSBjYW4gYmUgZGlzYWJsZWQgd2l0aCBhIG1vZHVsZSBwYXJhbS4gQkFDTyBz
dGF0ZSBpcyBzdXBwb3J0ZWQgZm9yIG5vbi1SUE0gdXNlIGNhc2VzIGFsc28gbGlrZSByZWd1bGFy
IHN1c3BlbmQgb3IgYSByZXNldC4gUmVseWluZyBvbiBSUE0gbW9kZSBmb3IgQkFDTyBzdGF0ZSBp
cyBub3QgdGhlIHJpZ2h0DQogdGhpbmcgdG8gZG8uPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9k
aXY+DQo8ZGl2IGlkPSJtcy1vdXRsb29rLW1vYmlsZS1zaWduYXR1cmUiPg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5UaGFua3MsPGJyPg0KTGlqbzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
IGNsYXNzPSJNc29Ob3JtYWwiIGFsaWduPSJjZW50ZXIiIHN0eWxlPSJ0ZXh0LWFsaWduOmNlbnRl
ciI+DQo8aHIgc2l6ZT0iMiIgd2lkdGg9Ijk4JSIgYWxpZ249ImNlbnRlciI+DQo8L2Rpdj4NCjxk
aXYgaWQ9ImRpdlJwbHlGd2RNc2ciPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5
bGU9ImNvbG9yOmJsYWNrIj5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImNvbG9yOmJsYWNr
Ij4gQ2hlbiwgR3VjaHVuICZsdDs8YSBocmVmPSJtYWlsdG86R3VjaHVuLkNoZW5AYW1kLmNvbSI+
R3VjaHVuLkNoZW5AYW1kLmNvbTwvYT4mZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IE1vbmRheSwgTm92
ZW1iZXIgMjEsIDIwMjIgNjowODo1OCBBTTxicj4NCjxiPlRvOjwvYj4gPGEgaHJlZj0ibWFpbHRv
OmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIj5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzwvYT4gJmx0OzxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyI+YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8L2E+Jmd0OzsgRGV1Y2hlciwgQWxleGFu
ZGVyICZsdDs8YSBocmVmPSJtYWlsdG86QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSI+QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbTwvYT4mZ3Q7Ow0KIFpoYW5nLCBIYXdraW5nICZsdDs8YSBocmVm
PSJtYWlsdG86SGF3a2luZy5aaGFuZ0BhbWQuY29tIj5IYXdraW5nLlpoYW5nQGFtZC5jb208L2E+
Jmd0OzsgTGF6YXIsIExpam8gJmx0OzxhIGhyZWY9Im1haWx0bzpMaWpvLkxhemFyQGFtZC5jb20i
Pkxpam8uTGF6YXJAYW1kLmNvbTwvYT4mZ3Q7OyBRdWFuLCBFdmFuICZsdDs8YSBocmVmPSJtYWls
dG86RXZhbi5RdWFuQGFtZC5jb20iPkV2YW4uUXVhbkBhbWQuY29tPC9hPiZndDs8YnI+DQo8Yj5D
Yzo8L2I+IENoZW4sIEd1Y2h1biAmbHQ7PGEgaHJlZj0ibWFpbHRvOkd1Y2h1bi5DaGVuQGFtZC5j
b20iPkd1Y2h1bi5DaGVuQGFtZC5jb208L2E+Jmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBbUEFU
Q0ggMS8yXSBkcm0vYW1kZ3B1OiB1c2UgcnBtX21vZGUgYXMgcnVudGltZSBwbSBjaGVjayBmbGFn
PC9zcGFuPg0KPG86cD48L286cD48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+Jm5i
c3A7PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPkRyaXZlciB3YXMgbm90
IGNhbGxpbmcgQkFDTyBleGl0IGF0IGFsbCBpbiBydW50aW1lIHBtPGJyPg0KcmVzdW1lLCBhbmQg
aXQgY2F1c2VkIHRoZSB0aW1pbmcgaXNzdWUgbGVhZGluZyB0byBhIFBDSTxicj4NCkFFUiBlcnJv
ciwgYXMgb25jZSBzeXN0ZW0gZW50ZXJzIEJBQ08sIGl0J3Mgbm90IHJlbGlhYmxlPGJyPg0KdG8g
Y2hlY2sgcnVudGltZSBwbSBtb2RlIGJ5IHRhbGtpbmcgdG8gU01VLiBTbyB1c2UgcnBtX21vZGU8
YnI+DQppbnN0ZWFkIGFzIGEgZ2VuZXJhbCBwbSBtb2RlIGNoZWNrIHRvIGVuc3VyZSBkcml2ZXIg
ZXhlY3V0ZXM8YnI+DQpCQUNPIGV4aXQgaW4gcnVudGltZSBwbSByZXN1bWUuPGJyPg0KPGJyPg0K
Rml4ZXM6IDg3OTVlMTgyYjAyZCAoJnF1b3Q7UENJL3BvcnRkcnY6IERvbid0IGRpc2FibGUgQUVS
IHJlcG9ydGluZyBpbiBnZXRfcG9ydF9kZXZpY2VfY2FwYWJpbGl0eSgpJnF1b3Q7KTxicj4NCjxi
cj4NClNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuICZsdDs8YSBocmVmPSJtYWlsdG86Z3VjaHVu
LmNoZW5AYW1kLmNvbSI+Z3VjaHVuLmNoZW5AYW1kLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0K
Jm5ic3A7ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwmbmJzcDsg
NCArKy0tPGJyPg0KJm5ic3A7ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwgMjUgKysrKysrKysrKystLS0tLS0tLS0tLTxicj4NCiZuYnNw
OzIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pPGJyPg0K
PGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzxicj4NCmlu
ZGV4IGFiOGY5NzBiMjg0OS4uNDBhZjIxMDQwYjQ3IDEwMDY0NDxicj4NCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzxicj4NCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzxicj4NCkBAIC01NjE5LDcgKzU2MTksNyBA
QCBpbnQgYW1kZ3B1X2RldmljZV9iYWNvX2VudGVyKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYoZGV2KTs8YnI+DQombmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc3RydWN0IGFtZGdwdV9yYXMg
KnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7PGJyPg0KJm5ic3A7PGJyPg0KLSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoIWFtZGdwdV9kZXZpY2Vfc3Vw
cG9ydHNfYmFjbyhhZGV2X3RvX2RybShhZGV2KSkpPGJyPg0KKyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBpZiAoYWRldi0mZ3Q7cG0ucnBtX21vZGUgIT0gQU1ER1BVX1JVTlBN
X0JBQ08pPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVy
biAtRU5PVFNVUFA7PGJyPg0KJm5ic3A7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChyYXMgJmFtcDsmYW1wOyBhZGV2LSZndDtyYXNfZW5h
YmxlZCAmYW1wOyZhbXA7PGJyPg0KQEAgLTU2MzUsNyArNTYzNSw3IEBAIGludCBhbWRncHVfZGV2
aWNlX2JhY29fZXhpdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KTxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3QgYW1kZ3B1X3JhcyAqcmFz
ID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaW50IHJldCA9IDA7PGJyPg0KJm5ic3A7PGJy
Pg0KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoIWFtZGdwdV9kZXZp
Y2Vfc3VwcG9ydHNfYmFjbyhhZGV2X3RvX2RybShhZGV2KSkpPGJyPg0KKyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYWRldi0mZ3Q7cG0ucnBtX21vZGUgIT0gQU1ER1BV
X1JVTlBNX0JBQ08pPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHJldHVybiAtRU5PVFNVUFA7PGJyPg0KJm5ic3A7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldCA9IGFtZGdwdV9kcG1fYmFjb19leGl0KGFk
ZXYpOzxicj4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmM8YnI+DQppbmRl
eCAzYzlmZWNkZDZiMmYuLmJlMDNmN2IxY2VlMSAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmM8YnI+DQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmM8YnI+DQpAQCAtMjUzMiw3ICsyNTMyLDcgQEAgc3RhdGlj
IGludCBhbWRncHVfcG1vcHNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldik8YnI+
DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4N
CiZuYnNwOzxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBhZGV2LSZndDtpbl9ydW5wbSA9IHRydWU7PGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19weChkcm1fZGV2KSk8
YnI+DQorJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChhZGV2LSZndDtw
bS5ycG1fbW9kZSA9PSBBTURHUFVfUlVOUE1fUFgpPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRybV9kZXYtJmd0O3N3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9T
V0lUQ0hfUE9XRVJfQ0hBTkdJTkc7PGJyPg0KJm5ic3A7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qPGJyPg0KQEAgLTI1NDIsMjEgKzI1NDIs
MjEgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZp
Y2UgKmRldik8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgKiBwbGF0Zm9ybXMuPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogVE9ETzogdGhpcyBtYXkgYmUgYWxzbyBuZWVk
ZWQgZm9yIFBYIGNhcGFibGUgcGxhdGZvcm0uPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICovPGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9k
ZXYpKTxicj4NCismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFkZXYt
Jmd0O3BtLnJwbV9tb2RlID09IEFNREdQVV9SVU5QTV9CT0NPKTxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhZGV2LSZndDttcDFfc3RhdGUgPSBQUF9NUDFfU1RB
VEVfVU5MT0FEOzxicj4NCiZuYnNwOzxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyByZXQgPSBhbWRncHVfZGV2aWNlX3N1c3BlbmQoZHJtX2Rldiwg
ZmFsc2UpOzxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBpZiAocmV0KSB7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGFkZXYtJmd0O2luX3J1bnBtID0gZmFsc2U7PGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKTxicj4NCism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFkZXYtJmd0O3BtLnJwbV9tb2RlID09IEFN
REdQVV9SVU5QTV9CT0NPKTxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhZGV2
LSZndDttcDFfc3RhdGUgPSBQUF9NUDFfU1RBVEVfTk9ORTs8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIHJldDs8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4NCiZuYnNwOzxicj4NCi0mbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9y
dHNfYm9jbyhkcm1fZGV2KSk8YnI+DQorJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGlmIChhZGV2LSZndDtwbS5ycG1fbW9kZSA9PSBBTURHUFVfUlVOUE1fQk9DTyk8YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYWRldi0mZ3Q7bXAxX3N0YXRl
ID0gUFBfTVAxX1NUQVRFX05PTkU7PGJyPg0KJm5ic3A7PGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19weChkcm1fZGV2
KSkgezxicj4NCismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFkZXYt
Jmd0O3BtLnJwbV9tb2RlID09IEFNREdQVV9SVU5QTV9QWCkgezxicj4NCiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAvKiBPbmx5IG5lZWQgdG8gaGFuZGxlIFBDSSBzdGF0
ZSBpbiB0aGUgZHJpdmVyIGZvciBBVFBYPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogUENJIGNvcmUgaGFuZGxlcyBpdCBmb3IgX1BSMy48YnI+DQom
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgKi88YnI+DQpAQCAt
MjU2NSw5ICsyNTY1LDkgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcnVudGltZV9zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldik8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgcGNpX2lnbm9yZV9ob3RwbHVnKHBkZXYpOzxicj4NCiZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwY2lfc2V0X3Bvd2VyX3N0YXRlKHBkZXYsIFBDSV9EM2Nv
bGQpOzxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkcm1fZGV2
LSZndDtzd2l0Y2hfcG93ZXJfc3RhdGUgPSBEUk1fU1dJVENIX1BPV0VSX0RZTkFNSUNfT0ZGOzxi
cj4NCi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfSBlbHNlIGlmIChhbWRn
cHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZHJtX2RldikpIHs8YnI+DQorJm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0gZWxzZSBpZiAoYWRldi0mZ3Q7cG0ucnBtX21vZGUgPT0g
QU1ER1BVX1JVTlBNX0JPQ08pIHs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgLyogbm90aGluZyB0byBkbyAqLzxicj4NCi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgfSBlbHNlIGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oZHJt
X2RldikpIHs8YnI+DQorJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH0gZWxz
ZSB7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9k
ZXZpY2VfYmFjb19lbnRlcihkcm1fZGV2KTs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfTxicj4NCiZuYnNwOzxicj4NCkBAIC0yNTg4LDcgKzI1
ODgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlICpkZXYpPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGlmICghcGNpX2RldmljZV9pc19wcmVzZW50KGFkZXYtJmd0O3BkZXYpKTxicj4NCiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhZGV2LSZndDtub19od19hY2Nl
c3MgPSB0cnVlOzxicj4NCiZuYnNwOzxicj4NCi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfcHgoZHJtX2RldikpIHs8YnI+DQor
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmIChhZGV2LSZndDtwbS5ycG1f
bW9kZSA9PSBBTURHUFVfUlVOUE1fUFgpIHs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgZHJtX2Rldi0mZ3Q7c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRD
SF9QT1dFUl9DSEFOR0lORzs8YnI+DQombmJzcDs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgLyogT25seSBuZWVkIHRvIGhhbmRsZSBQQ0kgc3RhdGUgaW4gdGhl
IGRyaXZlciBmb3IgQVRQWDxicj4NCkBAIC0yNjAwLDIyICsyNjAwLDIzIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3Btb3BzX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldik8YnI+DQombmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKHJldCk8YnI+DQombmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIHJldDs8YnI+DQombmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcGNpX3NldF9tYXN0ZXIocGRldik7PGJyPg0KLSZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vf
c3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkgezxicj4NCismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgfSBlbHNlIGlmIChhZGV2LSZndDtwbS5ycG1fbW9kZSA9PSBBTURHUFVfUlVO
UE1fQk9DTykgezxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAv
KiBPbmx5IG5lZWQgdG8gaGFuZGxlIFBDSSBzdGF0ZSBpbiB0aGUgZHJpdmVyIGZvciBBVFBYPGJy
Pg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICogUENJIGNv
cmUgaGFuZGxlcyBpdCBmb3IgX1BSMy48YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgKi88YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgcGNpX3NldF9tYXN0ZXIocGRldik7PGJyPg0KLSZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyB9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhk
cm1fZGV2KSkgezxicj4NCismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgfSBl
bHNlIHs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYW1kZ3B1
X2RldmljZV9iYWNvX2V4aXQoZHJtX2Rldik7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IH08YnI+DQorPGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldCA9IGFtZGdwdV9kZXZpY2VfcmVzdW1l
KGRybV9kZXYsIGZhbHNlKTs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgaWYgKHJldCkgezxicj4NCi0mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfcHgoZHJtX2RldikpPGJyPg0KKyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyBpZiAoYWRldi0mZ3Q7cG0ucnBtX21vZGUgPT0gQU1ER1BVX1JV
TlBNX1BYKTxicj4NCiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwY2lfZGlzYWJsZV9k
ZXZpY2UocGRldik7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IHJldHVybiByZXQ7PGJyPg0KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IH08YnI+DQombmJzcDs8YnI+DQotJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX3B4KGRybV9kZXYpKTxicj4NCism
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKGFkZXYtJmd0O3BtLnJwbV9t
b2RlID09IEFNREdQVV9SVU5QTV9QWCk8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgZHJtX2Rldi0mZ3Q7c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9Q
T1dFUl9PTjs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgYWRldi0mZ3Q7aW5fcnVucG0gPSBmYWxzZTs8YnI+DQombmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcmV0dXJuIDA7PGJyPg0KLS0gPGJyPg0KMi4y
NS4xPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2
Pg0KPC9ib2R5Pg0KPC9odG1sPg0KAAAAHwBCAAEAAAAaAAAAQwBoAGUAbgAsACAARwB1AGMAaAB1
AG4AAAAAAB8AZQABAAAAKAAAAEcAdQBjAGgAdQBuAC4AQwBoAGUAbgBAAGEAbQBkAC4AYwBvAG0A
AAAfAGQAAQAAAAoAAABTAE0AVABQAAAAAAACAUEAAQAAAGQAAAAAAAAAgSsfpL6jEBmdbgDdAQ9U
AgAAAIBDAGgAZQBuACwAIABHAHUAYwBoAHUAbgAAAFMATQBUAFAAAABHAHUAYwBoAHUAbgAuAEMA
aABlAG4AQABhAG0AZAAuAGMAbwBtAAAAHwACXQEAAAAoAAAARwB1AGMAaAB1AG4ALgBDAGgAZQBu
AEAAYQBtAGQALgBjAG8AbQAAAB8A5V8BAAAAMAAAAHMAaQBwADoAZwB1AGMAaAB1AG4ALgBjAGgA
ZQBuAEAAYQBtAGQALgBjAG8AbQAAAB8AGgwBAAAAGgAAAEMAaABlAG4ALAAgAEcAdQBjAGgAdQBu
AAAAAAAfAB8MAQAAACgAAABHAHUAYwBoAHUAbgAuAEMAaABlAG4AQABhAG0AZAAuAGMAbwBtAAAA
HwAeDAEAAAAKAAAAUwBNAFQAUAAAAAAAAgEZDAEAAABkAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIA
AACAQwBoAGUAbgAsACAARwB1AGMAaAB1AG4AAABTAE0AVABQAAAARwB1AGMAaAB1AG4ALgBDAGgA
ZQBuAEAAYQBtAGQALgBjAG8AbQAAAB8AAV0BAAAAKAAAAEcAdQBjAGgAdQBuAC4AQwBoAGUAbgBA
AGEAbQBkAC4AYwBvAG0AAAALAEA6AQAAAB8AGgABAAAAEgAAAEkAUABNAC4ATgBvAHQAZQAAAAAA
AwDxPwkEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAAa/1Cv6MkQ0+SGscxZB82pQMAFwAB
AAAAQAA5AACmqm0Y/tgBQAAIMH59Hm4Y/tgBCwACAAEAAAALACMAAAAAAAMAJgAAAAAACwApAAAA
AAALACsAAAAAAAMALgAAAAAAAwA2AAAAAAAfAHAAAQAAAHwAAABbAFAAQQBUAEMASAAgADEALwAy
AF0AIABkAHIAbQAvAGEAbQBkAGcAcAB1ADoAIAB1AHMAZQAgAHIAcABtAF8AbQBvAGQAZQAgAGEA
cwAgAHIAdQBuAHQAaQBtAGUAIABwAG0AIABjAGgAZQBjAGsAIABmAGwAYQBnAAAAAgFxAAEAAAAg
AAAAAQHY/UGv+8SxDMuFvkyD4G1fJ3aOgK5IpswAgAGPbhALAAYMAAAAAB8ANRABAAAAogAAADwA
RABNADUAUABSADEAMgBNAEIAMgA0ADYAOQBGAEUARQAwADYANQAyAEUANgBGAEMAOAA5AEUAQwBB
ADMAOAAyAEIARgAxADAARAA5AEAARABNADUAUABSADEAMgBNAEIAMgA0ADYAOQAuAG4AYQBtAHAA
cgBkADEAMgAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAAAAHwA5EAEAAAAA
AQAAPAAyADAAMgAyADEAMQAyADEAMAAwADMAOAA1ADgALgAzADIAOQA2ADAAMwA1AC0AMQAtAGcA
dQBjAGgAdQBuAC4AYwBoAGUAbgBAAGEAbQBkAC4AYwBvAG0APgAgADwAQgBZAEEAUABSADEAMgBN
AEIANAA2ADEANABDAEYANgAzAEEANQAwADkANgA4AEEAMgA5AEEAQgAwADMANwBBADMAOQA3ADAA
QQA5AEAAQgBZAEEAUABSADEAMgBNAEIANAA2ADEANAAuAG4AYQBtAHAAcgBkADEAMgAuAHAAcgBv
AGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAB8AQhABAAAAogAAADwAQgBZAEEAUABSADEA
MgBNAEIANAA2ADEANABDAEYANgAzAEEANQAwADkANgA4AEEAMgA5AEEAQgAwADMANwBBADMAOQA3
ADAAQQA5AEAAQgBZAEEAUABSADEAMgBNAEIANAA2ADEANAAuAG4AYQBtAHAAcgBkADEAMgAuAHAA
cgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0APgAAAAAAAwCAEP////8DABMSAAAAAEAABzCS
haJtGP7YAQIBEDABAAAARgAAAAAAAACWbQCpaEVDQ7HGeTY1wyOZBwB1i7nHGR9aTrbCgfb+tgXB
AAAAAAELAAB1i7nHGR9aTrbCgfb+tgXBAAACONngAAAAAAIBEzABAAAAEAAAAPvEsQzLhb5Mg+Bt
Xyd2joACARQwAQAAAAwAAAAMAgAAMGG56ftGK54DAFszAQAAAAMAWjYAAAAAAwBoNg0AAAALAPo2
AQAAAB8A2T8BAAAAAAIAAEcAbwBvAGQAIABwAG8AaQBuAHQALgAgAEwAZQB0ACAAbQBlACAAdQBw
AGQAYQB0AGUAIABpAHQALgANAAoADQAKAFIAZQBnAGEAcgBkAHMALAANAAoARwB1AGMAaAB1AG4A
DQAKAA0ACgBGAHIAbwBtADoAIABMAGEAegBhAHIALAAgAEwAaQBqAG8AIAA8AEwAaQBqAG8ALgBM
AGEAegBhAHIAQABhAG0AZAAuAGMAbwBtAD4ADQAKAFMAZQBuAHQAOgAgAE0AbwBuAGQAYQB5ACwA
IABOAG8AdgBlAG0AYgBlAHIAIAAyADEALAAgADIAMAAyADIAIAAxADAAOgAyADYAIABBAE0ADQAK
AFQAbwA6ACAAQwBoAGUAbgAsACAARwB1AGMAaAB1AG4AIAA8AEcAdQBjAGgAdQBuAC4AQwBoAGUA
bgBAAGEAbQBkAC4AYwBvAG0APgA7ACAAYQBtAGQALQBnAGYAeABAAGwAaQBzAHQAcwAuAGYAcgBl
AGUAZABlAHMAawB0AG8AcAAuAG8AcgBnADsAIABEAGUAdQBjAGgAZQByACwAIABBAGwAZQB4AGEA
bgBkAGUAcgAgADwAQQBsAGUAeABhAG4AZABlAHIALgBEAGUAdQBjAGgAZQByAEAAYQBtAGQALgBj
AG8AbQA+ADsAIABaAAAAAwDeP59OAAAfAPg/AQAAABoAAABDAGgAZQBuACwAIABHAHUAYwBoAHUA
bgAAAAAAHwD6PwEAAAAaAAAAQwBoAGUAbgAsACAARwB1AGMAaAB1AG4AAAAAAB8AIkABAAAABgAA
AEUAWAAAAAAAHwAjQAEAAAACAQAALwBPAD0ARQBYAEMASABBAE4ARwBFAEwAQQBCAFMALwBPAFUA
PQBFAFgAQwBIAEEATgBHAEUAIABBAEQATQBJAE4ASQBTAFQAUgBBAFQASQBWAEUAIABHAFIATwBV
AFAAIAAoAEYAWQBEAEkAQgBPAEgARgAyADMAUwBQAEQATABUACkALwBDAE4APQBSAEUAQwBJAFAA
SQBFAE4AVABTAC8AQwBOAD0ANgBBADEANAAzADUANgA1ADMAMQA2ADEANAAwAEIANABCADQAMgAy
ADEARAA5AEMARQBFADUAQQAyADkARQAxAC0AQwBIAEUATgAsACAARwBVAEMASABVAAAAAAAfACRA
AQAAAAYAAABFAFgAAAAAAB8AJUABAAAAAgEAAC8ATwA9AEUAWABDAEgAQQBOAEcARQBMAEEAQgBT
AC8ATwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0ASQBOAEkAUwBUAFIAQQBUAEkAVgBFACAA
RwBSAE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAzAFMAUABEAEwAVAApAC8AQwBOAD0AUgBF
AEMASQBQAEkARQBOAFQAUwAvAEMATgA9ADYAQQAxADQAMwA1ADYANQAzADEANgAxADQAMABCADQA
QgA0ADIAMgAxAEQAOQBDAEUARQA1AEEAMgA5AEUAMQAtAEMASABFAE4ALAAgAEcAVQBDAEgAVQAA
AAAAHwAwQAEAAAAaAAAAQwBoAGUAbgAsACAARwB1AGMAaAB1AG4AAAAAAB8AMUABAAAAGgAAAEMA
aABlAG4ALAAgAEcAdQBjAGgAdQBuAAAAAAAfADhAAQAAABoAAABDAGgAZQBuACwAIABHAHUAYwBo
AHUAbgAAAAAAHwA5QAEAAAAaAAAAQwBoAGUAbgAsACAARwB1AGMAaAB1AG4AAAAAAAMAWUAAAAAA
AwBaQAAAAAADADdQAQAAAAMAAlkAABYAAwAJWQIAAAAfAApdAQAAACgAAABHAHUAYwBoAHUAbgAu
AEMAaABlAG4AQABhAG0AZAAuAGMAbwBtAAAAHwALXQEAAAAoAAAARwB1AGMAaAB1AG4ALgBDAGgA
ZQBuAEAAYQBtAGQALgBjAG8AbQAAAAIBFV0BAAAAEgAAAAIfltg9iORgTo4RqC2ZThg9AQAAAgEW
XQEAAAASAAAAAh+W2D2I5GBOjhGoLZlOGD0BAAALAACACCAGAAAAAADAAAAAAAAARgAAAAAUhQAA
AAAAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQAAABJAG4AZABlAHgAaQBuAGcARQByAHIAbwBy
AEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAKgAAAEkAbgBkAGUAeABpAG4A
ZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAAAQAAAHAAAABJAG4AZABlAHgAaQBuAGcAIABQ
AGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBpAGcARgB1AG4AbgBlAGwAUABPAEkASQBzAFUA
cABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMAZQAuAAAACwAAgAggBgAAAAAAwAAAAAAAAEYA
AAAABoUAAAAAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAADhQAAAAAAAAMAAIAIIAYAAAAAAMAA
AAAAAABGAAAAAAGFAAAAAAAAAwAAgAggBgAAAAAAwAAAAAAAAEYBAAAAMgAAAEUAeABjAGgAYQBu
AGcAZQBBAHAAcABsAGkAYwBhAHQAaQBvAG4ARgBsAGEAZwBzAAAAAAAgAAAAAgEAgBOP8kH0gxRB
pYTu21prC/8BAAAALgAAAEgAZQBhAGQAZQByAEIAbwBkAHkARgByAGEAZwBtAGUAbgB0AEwAaQBz
AHQAAAAAAAEAAABKAAAAAQAKAAAABAAAAAIAAAAUAAAAAAAAAP0GAABDCAAAAAAAABQAAAAAAAAA
RgoAABINAAAAAAAAFAAAAAAAAAAmEQAA/////wAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAA
ABwAAABIAGEAcwBRAHUAbwB0AGUAZABUAGUAeAB0AAAAAQAAAAsAAIATj/JB9IMUQaWE7ttaawv/
AQAAACgAAABJAHMAUQB1AG8AdABlAGQAVABlAHgAdABDAGgAYQBuAGcAZQBkAAAAAAAAAAIBAIAT
j/JB9IMUQaWE7ttaawv/AQAAAEAAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8AbgBUAHIAZQBlAFAA
YQByAGUAbgB0AFIAZQBjAG8AcgBkAEsAZQB5AAAAAQAAAC4AAAAAAAAAlm0AqWhFQ0Oxxnk2NcMj
mQEAdYu5xxkfWk62woH2/rYFwQADQpS8vAAAAAAfAACAE4/yQfSDFEGlhO7bWmsL/wEAAAAWAAAA
QwBsAGkAZQBuAHQASQBuAGYAbwAAAAAAAQAAACoAAABDAGwAaQBlAG4AdAA9AE0AUwBFAHgAYwBo
AGEAbgBnAGUAUgBQAEMAAAAAAAsAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACYAAABJAHMAUABlAHIA
bQBhAG4AZQBuAHQARgBhAGkAbAB1AHIAZQAAAAAAAAAAAB8AAIAfpOszqHouQr57eeGpjlSzAQAA
ADgAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8AbgBJAG4AZABlAHgAVAByAGEAYwBrAGkAbgBnAEUA
eAAAAAEAAAAyAgAASQBJAD0AWwBDAEkARAA9ADAAYwBiADEAYwA0AGYAYgAtADgANQBjAGIALQA0
AGMAYgBlAC0AOAAzAGUAMAAtADYAZAA1AGYAMgA3ADcANgA4AGUAOAAwADsASQBEAFgASABFAEEA
RAA9ADAAMQBEADgARgBEADQAMQBBAEYAOwBJAEQAWABDAE8AVQBOAFQAPQAzAF0AOwBTAEIATQBJ
AEQAPQAyADUAOwBTADEAPQA8AEIAWQBBAFAAUgAxADIATQBCADQANgAxADQAQwBGADYAMwBBADUA
MAA5ADYAOABBADIAOQBBAEIAMAAzADcAQQAzADkANwAwAEEAOQBAAEIAWQBBAFAAUgAxADIATQBC
ADQANgAxADQALgBuAGEAbQBwAHIAZAAxADIALgBwAHIAbwBkAC4AbwB1AHQAbABvAG8AawAuAGMA
bwBtAD4AOwBSAFQAUAA9AEQAaQByAGUAYwB0AEMAaABpAGwAZAA7AFQARABOAD0ATQBpAHMAbQBh
AHQAYwBoADsAVABQAD0AUwBhAG0AZQA7AFQARgBSAD0ATgBvAHQARgBvAHIAawBpAG4AZwA7AFYA
ZQByAHMAaQBvAG4APQBWAGUAcgBzAGkAbwBuACAAMQA1AC4AMgAwACAAKABCAHUAaQBsAGQAIAA1
ADgAMwA0AC4AMAApACwAIABTAHQAYQBnAGUAPQBIADEAOwBVAFAAPQBEADAAOwBEAFAAPQAxADAA
MQAAAAAAAwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAEIUAAAAAAAALAACACCAGAAAAAADAAAAAAAAA
RgAAAAAOhQAAAAAAAAMAAIAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAACwAAgAggBgAAAAAA
wAAAAAAAAEYAAAAAgoUAAAAAAAAfAACACCAGAAAAAADAAAAAAAAARgAAAADYhQAAAQAAABIAAABJ
AFAATQAuAE4AbwB0AGUAAAAAAAIBAIAIIAYAAAAAAMAAAAAAAABGAQAAADYAAABJAG4AVAByAGEA
bgBzAGkAdABNAGUAcwBzAGEAZwBlAEMAbwByAHIAZQBsAGEAdABvAHIAAAAAAAEAAAAQAAAAkc2f
9rfD5Eq5xpfMbNOgzh8AAICGAwIAAAAAAMAAAAAAAABGAQAAABgAAABtAHMAaQBwAF8AbABhAGIA
ZQBsAHMAAAABAAAA2AIAAE0AUwBJAFAAXwBMAGEAYgBlAGwAXwA0ADMANAAyADMAMQA0AGUALQAw
AGQAZgA0AC0ANABiADUAOAAtADgANABiAGYALQAzADgAYgBlAGQANgAxADcAMABhADAAZgBfAEUA
bgBhAGIAbABlAGQAPQBUAHIAdQBlADsATQBTAEkAUABfAEwAYQBiAGUAbABfADQAMwA0ADIAMwAx
ADQAZQAtADAAZABmADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMAOABiAGUAZAA2ADEANwAwAGEA
MABmAF8AUwBpAHQAZQBJAGQAPQAzAGQAZAA4ADkANgAxAGYALQBlADQAOAA4AC0ANABlADYAMAAt
ADgAZQAxADEALQBhADgAMgBkADkAOQA0AGUAMQA4ADMAZAA7AE0AUwBJAFAAXwBMAGEAYgBlAGwA
XwA0ADMANAAyADMAMQA0AGUALQAwAGQAZgA0AC0ANABiADUAOAAtADgANABiAGYALQAzADgAYgBl
AGQANgAxADcAMABhADAAZgBfAFMAZQB0AEQAYQB0AGUAPQAyADAAMgAyAC0AMQAxAC0AMgAxAFQA
MAAyADoAMgA0ADoANAA2AC4ANgA3ADMAOAA2ADUANgBaADsATQBTAEkAUABfAEwAYQBiAGUAbABf
ADQAMwA0ADIAMwAxADQAZQAtADAAZABmADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMAOABiAGUA
ZAA2ADEANwAwAGEAMABmAF8AQwBvAG4AdABlAG4AdABCAGkAdABzAD0AMAA7AE0AUwBJAFAAXwBM
AGEAYgBlAGwAXwA0ADMANAAyADMAMQA0AGUALQAwAGQAZgA0AC0ANABiADUAOAAtADgANABiAGYA
LQAzADgAYgBlAGQANgAxADcAMABhADAAZgBfAE0AZQB0AGgAbwBkAD0AUwB0AGEAbgBkAGEAcgBk
AAAASAAAgGvFP0AwzcVHhvjt6eNaAisBAAAAHAAAAE0AUwBJAFAATABhAGIAZQBsAEcAdQBpAGQA
AABOMUJD9A1YS4S/OL7WFwoPAwANNP0/AAAfAD0AAQAAAAoAAABSAEUAOgAgAAAAAAAfADcAAQAA
AIQAAABSAEUAOgAgAFsAUABBAFQAQwBIACAAMQAvADIAXQAgAGQAcgBtAC8AYQBtAGQAZwBwAHUA
OgAgAHUAcwBlACAAcgBwAG0AXwBtAG8AZABlACAAYQBzACAAcgB1AG4AdABpAG0AZQAgAHAAbQAg
AGMAaABlAGMAawAgAGYAbABhAGcAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAAuAAAAYQB1AHQA
aABlAG4AdABpAGMAYQB0AGkAbwBuAC0AcgBlAHMAdQBsAHQAcwAAAAAAAQAAALIAAABkAGsAaQBt
AD0AbgBvAG4AZQAgACgAbQBlAHMAcwBhAGcAZQAgAG4AbwB0ACAAcwBpAGcAbgBlAGQAKQAgAGgA
ZQBhAGQAZQByAC4AZAA9AG4AbwBuAGUAOwBkAG0AYQByAGMAPQBuAG8AbgBlACAAYQBjAHQAaQBv
AG4APQBuAG8AbgBlACAAaABlAGEAZABlAHIALgBmAHIAbwBtAD0AYQBtAGQALgBjAG8AbQA7AAAA
AAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAAeAAAAYQBjAGMAZQBwAHQAbABhAG4AZwB1AGEAZwBl
AAAAAAABAAAADAAAAGUAbgAtAFUAUwAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACAAAAB4AC0A
bQBzAC0AaABhAHMALQBhAHQAdABhAGMAaAAAAAEAAAACAAAAAAAAAB8AAIBrxT9AMM3FR4b47enj
WgIrAQAAABIAAABNAEkAUABMAGEAYgBlAGwAAAAAAAEAAADSAQAAWwB7ACIAaQBkACIAOgAiADQA
MwA0ADIAMwAxADQAZQAtADAAZABmADQALQA0AGIANQA4AC0AOAA0AGIAZgAtADMAOABiAGUAZAA2
ADEANwAwAGEAMABmACIALAAiAHQAaQAiADoAIgAzAGQAZAA4ADkANgAxAGYALQBlADQAOAA4AC0A
NABlADYAMAAtADgAZQAxADEALQBhADgAMgBkADkAOQA0AGUAMQA4ADMAZAAiACwAIgBwAGkAIgA6
ACIAMAAwADAAMAAwADAAMAAwAC0AMAAwADAAMAAtADAAMAAwADAALQAwADAAMAAwAC0AMAAwADAA
MAAwADAAMAAwADAAMAAwADAAIgAsACIAbgBtACIAOgBuAHUAbABsACwAIgBhAGMAIgA6ADAALAAi
AG8AcAAiADoAMQAsACIAYwB0ACIAOgAiADIAMAAyADIALQAxADEALQAyADEAVAAwADIAOgAyADQA
OgA0ADYALgA2ADcAMwA4ADYANQA2AFoAIgAsACIAbQB0ACIAOgAiADAAMAAwADEALQAwADEALQAw
ADEAVAAwADAAOgAwADAAOgAwADAAIgAsACIAdQBjACIAOgBuAHUAbABsAH0AXQAAAAAASAAAgAgg
BgAAAAAAwAAAAAAAAEYBAAAAIgAAAE4AZQB0AHcAbwByAGsATQBlAHMAcwBhAGcAZQBJAGQAAAAA
AFDmxYs0N05JLYYI2swvkKYfAACAhgMCAAAAAADAAAAAAAAARgEAAAAuAAAAeAAtAG0AcwAtAHAA
dQBiAGwAaQBjAHQAcgBhAGYAZgBpAGMAdAB5AHAAZQAAAAAAAQAAAAwAAABFAG0AYQBpAGwAAAAf
AACAhgMCAAAAAADAAAAAAAAARgEAAAA2AAAAeAAtAG0AcwAtAHQAcgBhAGYAZgBpAGMAdAB5AHAA
ZQBkAGkAYQBnAG4AbwBzAHQAaQBjAAAAAAABAAAASAAAAEQATQA1AFAAUgAxADIATQBCADIANAA2
ADkAOgBFAEUAXwB8AFAASAAwAFAAUgAxADIATQBCADUANgAwADcAOgBFAEUAXwAAAB8AAICGAwIA
AAAAAMAAAAAAAABGAQAAAFAAAAB4AC0AbQBzAC0AbwBmAGYAaQBjAGUAMwA2ADUALQBmAGkAbAB0
AGUAcgBpAG4AZwAtAGMAbwByAHIAZQBsAGEAdABpAG8AbgAtAGkAZAAAAAEAAABKAAAAOABiAGMA
NQBlADYANQAwAC0AMwA3ADMANAAtADQAOQA0AGUALQAyAGQAOAA2AC0AMAA4AGQAYQBjAGMAMgBm
ADkAMABhADYAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAADgAAAB4AC0AbQBzAC0AZQB4AGMA
aABhAG4AZwBlAC0AcwBlAG4AZABlAHIAYQBkAGMAaABlAGMAawAAAAEAAAAEAAAAMQAAAB8AAICG
AwIAAAAAAMAAAAAAAABGAQAAADoAAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AYQBuAHQA
aQBzAHAAYQBtAC0AcgBlAGwAYQB5AAAAAAABAAAABAAAADAAAAAfAACAhgMCAAAAAADAAAAAAAAA
RgEAAAAqAAAAeAAtAG0AaQBjAHIAbwBzAG8AZgB0AC0AYQBuAHQAaQBzAHAAYQBtAAAAAAABAAAA
DgAAAEIAQwBMADoAMAA7AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAABEAAAAeAAtAG0AaQBj
AHIAbwBzAG8AZgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AbQBlAHMAcwBhAGcAZQAtAGkAbgBmAG8A
AAABAAAAggUAAGUAVQBkAGwAdgBiAHAAdAB3AEwAawB5AFMAWgBvAGsAUABYAEoAcwBaAEEAZgBU
AEQAVQBoAHIAcQBLAFMAcwByADQAZwBhADMAaAA0AGUAaQBxAFIAVgB1AGQAbABXAHcAVwBsAEkA
VwA5ADIAdABJAGsAdQBZAGwATAA2AEkAeABWAEkAWQBsAEkAawBsAGMAagBlAFcAVQAyAG4AMABx
AHAAUwAvAEkAQwBCAGQATwAzAFoAVAB6AGcATABXAEQAMgBZAHgAVgAwAHIAOQBoAHMAYwAzAFEA
YwBWAEoATgBMAFoAVQBCAHYAcgBGAFgAVQBlAG8AcAArAHkAdwBVAHMAOQAxAFMAbgBDAGYAUgBv
AGQANgA5AEQASQBiAFoAaABaADEARABlADUAWgBiAHMAUgBaAG0AegBMAG4AcwAvAGgAcwAyAEMA
UQB2AGoATABjADcAawAvADgAYwAyAEYAeAA2AGYANABPAGEAdAA2AGQAZAB5AFgARABmAFcANQBJ
AE4AVwAwAGQAMwBoAEwAUwBhADgAUQBzAEcAWQB5AHcANABBADYAVgBPAGwAUQB1ADUARwBHAFgA
OQB2AGMAcgA4AHcAbAByAGoAbwB5AEQAdwBwAEMASQBsAEUAUgAzAGcAWQBVAGYASABYAGEAMQA5
AE0AQwA1AGMARQA5AEsAbQAwAEUAdABHADIAegBvAHIAegBkAFgAagBrAFUAZwA1AEgASQBsAEEA
RABBAEQAYwAwAFkAcABxAC8AYgBuAGoAeQB2AEgAbABLAEIAVgB3ADAASgBKADAAbQBUAFUAbgBJ
AG8AeQA1AEcAbABZAFkANABDAC8AcQBSAG8AYwBlAHgAagBmAEQAZQBEAEUATAAxADIAVAAvADgA
SgB2ADUANQBaAFAAUABuAFoANABJADEASQBNAGEAegBxAGIASABTADYATwAzAGcAMQBMAGQARABj
AHUAdABxAFUAOQBuAEQAWgA1AGMARAB6ADQAQwBNAGEAWgA3AEYALwBlAHkANwB2AFMAQQBWAE8A
LwB0AGIAZQBXAGMAVgBhAHkAQwBnADQANwBBAEoAWQBCAHUATABpAFgARgBLAGUAZABTAFAAawBj
AFEAWQBRAEMARABtAGUAeQA4AE8AbgA4AGcAYgBaAFYAYgBJAFkAbQBsAGkAcgBYAHUANABPADIA
YgBtAHEAZABKADEAUAB2ADIAMQA0AFcAawArAG8AdwBSAGUAagA1AFoAOQBIADcAQgBvAHcAaQBW
AFIAcgBmAFMAQgBHAEsAQQBrAFMAUAAyAEoAaQBQAGoAQwA0ADQANgB4AFkASgBJAGYASQBIAHkA
bQBrAGkAOQBGADEAUAB6AFkARABhAFYAZABVAGEAbQAwAGgASwBpAGEAegAzAEQAMQB5ADMAWgA1
ADUAeQBlAEcANQBhAGsAMQBEAGoAYgBuAEQAWQA5AGcAbQBxAEQAcQBNAHgAWAA5AHEAZgBZAHIA
eAB4AGwASABuAG0AdABXAGcAeQBZAGgAOQBMAGUAUABaAHEATABUAGIAegBhAHgAMwBOADgAYQBV
AGYAagB0AFoAQwBrAGwAWABiAEcATgBaAFAAdwB0AGsAVAByAFIANABRAEwAeAB1ADYAKwAwAGUA
cABJAEMAZABHAG8AcgA0AEoANABTADYAKwBvADUAYgBTAHQAagBRAE0AaQBzADgANgBBAFAATQBD
AFQATgA2ADkAegBnACsAUQBmAHMAQgB6AE0ASgBBADEASABkAGIAQwBuAEQAYQAzAGkANgBjAGIA
TQBaADkATwArAFgAbABEAHYARQBsAEYAbgBqAHUAYwBMAG0AMwBKAEwAcgAyAEIAdgAAAAAAHwAA
gIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBmAG8AcgBlAGYAcgBvAG4AdAAtAGEAbgB0AGkA
cwBwAGEAbQAtAHIAZQBwAG8AcgB0AAAAAQAAACQEAABDAEkAUAA6ADIANQA1AC4AMgA1ADUALgAy
ADUANQAuADIANQA1ADsAQwBUAFIAWQA6ADsATABBAE4ARwA6AGUAbgA7AFMAQwBMADoAMQA7AFMA
UgBWADoAOwBJAFAAVgA6AE4ATABJADsAUwBGAFYAOgBOAFMAUABNADsASAA6AEQATQA1AFAAUgAx
ADIATQBCADIANAA2ADkALgBuAGEAbQBwAHIAZAAxADIALgBwAHIAbwBkAC4AbwB1AHQAbABvAG8A
awAuAGMAbwBtADsAUABUAFIAOgA7AEMAQQBUADoATgBPAE4ARQA7AFMARgBTADoAKAAxADMAMgAz
ADAAMAAyADIAKQAoADQANgAzADYAMAAwADkAKQAoADMANgA2ADAAMAA0ACkAKAAzADkAOAA2ADAA
NAAwADAAMAAwADIAKQAoADMAOQA2ADAAMAAzACkAKAAzADQANgAwADAAMgApACgAMwA3ADYAMAAw
ADIAKQAoADEAMwA2ADAAMAAzACkAKAA0ADUAMQAxADkAOQAwADEANQApACgAOAA2ADMANgAyADAA
MAAxACkAKAAxADIAMgAwADAAMAAwADAAMQApACgAOAAzADMAOAAwADQAMAAwADAAMAAxACkAKAA2
ADYAOQA0ADYAMAAwADcAKQAoADgAOQAzADYAMAAwADIAKQAoADMAOAAwADcAMAA3ADAAMAAwADAA
NQApACgAMgA5ADAANgAwADAAMgApACgANgA2ADMANgAwADAAMgApACgAMgA2ADAAMAA1ACkAKAA2
ADYANQA1ADYAMAAwADgAKQAoADYANgA0ADQANgAwADAAOAApACgANQAyADUAMwA2ADAAMQA0ACkA
KAA2ADYANAA3ADYAMAAwADcAKQAoADYANQAwADYAMAAwADcAKQAoADMAOAAxADAAMAA3ADAAMAAw
ADAAMgApACgANQAzADUANAA2ADAAMQAxACkAKAA3ADYAMQAxADYAMAAwADYAKQAoADUANQAwADEA
NgAwADAAMwApACgANwA2ADkANgAwADAANQApACgANwAxADIAMAAwADQAMAAwADAAMAAxACkAKAA0
ADEAMwAwADAANwAwADAAMAAwADEAKQAoADYANAA3ADUANgAwADAAOAApACgAOQA2ADgANgAwADAA
MwApACgANQA2ADYAMAAzADAAMAAwADAAMgApACgAMQAxADAAMQAzADYAMAAwADUAKQAoADQANwA4
ADYAMAAwADAAMAAxACkAKAAzADEANgAwADAAMgApACgAMQA4ADYAMAAwADMAKQAoADgANgA3ADYA
MAAwADIAKQAoADMAMwA2ADUANgAwADAAMgApADsARABJAFIAOgBPAFUAVAA7AFMARgBQADoAMQAx
ADAAMQA7AAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAXAAAAHgALQBtAHMALQBlAHgAYwBoAGEA
bgBnAGUALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBlAGQAYQB0AGEALQBjAGgAdQBu
AGsAYwBvAHUAbgB0AAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAASgAAAHgA
LQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBhAG4AdABpAHMAcABhAG0ALQBtAGUAcwBzAGEAZwBl
AGQAYQB0AGEALQAwAAAAAAABAAAAggwAAHgAUwBhAHgAdgByAFEAeQBWAHMAMwBaAHIAegBQAEoA
aABsAFcAQQBIAFEAQwBSADQAUgBOADcAUgBmADIAVgBzAEcAZgArAEcAWgBFAGcAbwBOAFcANgB6
AFcAZQBNADgAVABSAHUAeAB3AE0AbwBQAG0AcQB3AE0AdQBWAGIAUAA4AEsAbwBSADQANgBkAFoA
VABvAEgAMgBHAHUAYQBzACsAZwB1AFoAVgBJAGUAbwBEAGcAUgA0ADcAUwBoAGsAMgA5AGkATAAy
AG4AWABPAFIAdABKADMANQB3AEwASQBlAEoANQB1AFMAYwBmAG0AcQBDAHAAZQArAEgAbgA1AE4A
egBnAGYASABNAFoANgBlAG0AZwBwAGoAdwBzAGsAVwBkAHkAcQBJAEUAQgAyAGsAZgBLAE4ANwBv
AFEASABDAGQAbwBMAHkAVQBhADAAWQBwAEsAeQB3AEQAQQBZAHEAegBYADcAUwBQAGgAegBUAC8A
VQBvAEkAdwBLAFoARQBlAFQAagB1AGwATgBUAHAAbgBNAGkAcAByAEcAKwBYAGIAbQBBADIAcABJ
AFkARwB6ADUAOQB2AG8ANABEAGoATABVADYAQgB6AHgAOAB6ADIALwA3AEEASwBSAEUAeAB0AFgA
RAB1AFMATwB6AGQAbgBNAEYAQgBZAEoAMQBjAFUAMwBmAEIAUQBnAFkAbABCAFEAYQBjAEUAUQBW
AEYAQQA1AEQAcgBwAFIAWgBUAE8ARQByAEwASQA2AEwAUQBhAGMAWABQAHUARAA3ADYAMwBMAEwA
eABRAFoAWQBqAFoAcgBxADkANQA4AGgAUgBsAFkASQArAFQAaAB4AG8ASQBhAGQAawBtADIASgA1
AFkAcQBVAGsANwBZAHAAUQBEAGoASgBFAGYAMAArAHMAbwArAHkAdABxAGsAZwBMAG4AVQBKAFgA
LwBPADcAcgBOAGIANwBlAGcAOQB6AHUANABqAGoAdwBiAGMAUgBaAGQATwBiAFAAbABTADQAdABT
AHkAbgBsAE8ARwBuAC8AcgBqAGoAawArADgAVAB1ADAANQB6AFEAYQBjAHYANwA2AHoATgBoAHcA
NgA5ACsAWABlAEYARgBjAFQARABiAFEAUABoAFgAdQBsADEAaABIAGIAZABFADEAagBsAE8AYQBa
ADQAeQB0AEwASAA0AEsALwBPADQAMwB0AFgAUgBRADgAQwBvAHoANABNAGwAZgBNAGsAbABpAHoA
SgBLAHIARwB1ACsATwArAHYAWQBrAGEAVwBDAFMAKwBpAG8AUQB1ADYAZgA0AGYAWAB4AFIATgBx
AFEAawBQADkAYwAwAFIAWQBOAGwAagBrAEIAOABLADIAdwBaAFkAUgBZADMAcAAyAG0AQQBZAFIA
TABNAGUAZABRAHAAYQBMAGsAMwBhAHkAZABTAHAASAA3AFkAWQAzAFgANgB3AHQAKwB4AGgAWQBu
ADUANABIADMAYwBVADQASQBIADMAawAvAEgAZwBtAEUASQBRADQAdABaADgAMgBDAE4AdgBtAHMA
dABaAFkAYgBDAGMAaQBRAHAAUQA1ADMAaABuACsAdwA5AHEAMwBNADkAZQBOAG8AcwBXAHQAbABM
AFoALwBXAHYATQB6AEoALwA1ADkAbwBRAFoAbQBCADEAWAAvAEcAMABOAGIASABoAG4AYwBHAE0A
VABwAEwAaQBDADIAWABIAFgAMQBrAEIANABLAG4AZgBFADgAQwBhAGkAcgA3ADcAbwBLAEIAbwBO
AE8AMABHADkANABpAGQAWQA0ADQAcQAwAFEANgBqAHMAcQBhAGcARwArAFIAQwB3AFAASgBEAFQA
VABTAEYASAB2AGgAcwBpAGYAZABwADYAdgBGADEAQwBRAFoAUQBGAFkAMwArAFEATwBSADMASQBj
AFkASQBtAGcARgBCAGsANgB4AGgAWAB5AGYAOQBWAEQAUgBsAFMAcQBWAE8AMABWAFcAaQBFAHgA
bwBWAHAASwBMAG0ANQBGAE8AYQBJAGoAOABtAEsAcAB1AGQAWgA3AGwANABtAEQAagBhAGQAegA4
AGMATwBRAG4ARgA3AGIASgBJAFoAbgBHADIAUwBBAEcAdQAzAEYATABuAGcANwBRAGEAcgBDAEoA
MgBnADkANQB6AGoARABKAFEAaQBpAEEAegBWACsAMABxAFUASwArAFYAYgA2AEgAOABnAHMAcgBC
AGIAdwByAGMAVgBQAFEANABPAGMAcwBFAHAAegBsAGQANwBxAHcASQA0AFoAawBKAHkAZwB4AGgA
bQA4AFUAbgBuAGIAeQBWADUAUQB0AEgAZgAzAGUAcgBPAHgAUABLADAAdwBDAC8ASQBnAGkANwAv
AGIALwBLAHgAZwBBAGoATgA3AEkAZgBmAE0AVwBGAEgAKwBKAGQAZQBLAFEAYwBqAEsARQBuADAA
MABXAHYAdQBpAHcATgBlAHYARwBuADYANQBXAFQANAByAE8AegBuAGMAVgBLAGQAYQB1AEYANQBM
AGoALwB0AEEAaQBxAGwAVwBWAGkASwBMAFAAbQBuAFoALwB5ADcAYwBxAEwARgA0AHIAZgAvAFYA
YgBTAGEAUQBQAFQAVQBEAHUAYwB6ADAAUwBaAGYAMQBhAEoASwBzAFYAMgBlAHAAKwBrADEASgBG
ADQAMwBJADYAUwBWAFkAUQBKADEAaQA3AGUAMgA0AEwAVgB4AHAASgByAGkAWABVADEAWQBYAFAA
OABEAGQASgBWAFUAdwBkAEkAaQBlAEkASwBhAFIAYgBDAE4ARAB6AEwAMAAzAEkAeAAvAGsATQBB
ADEAMAB4AHYAbQBSAE0AYgBtAFQAZQAwAEIAZQBoAFAAdwBFAE4ALwBYADgAQgBLAEkAYgBhADQA
NwA1AEcAWAA3AHEAZABhAGEAcgBVAGMAdABPAGsAVgB5ADEAcABxAG8AQgBZAE0AawBOAFoAZgBV
AE8AUQBUAHMAZwB2AEUASABhAGkAYwBiAEUAZwBaAG4ASQB3AGYAbwBWAFYAYQA4AEQAawBJAFUA
QQAvAHMAcQBvAG4ASwBEAEQAawB5AG0AMABaAHAAQwB3AHYAcQBWAEEANABPAFEAMQBmAGcAYwBB
AGoAWgBMAHQAWgA0AGIAcABQAGUAbwBBAHQANgBzAFUAQwBWAG8AZQBpADYAZgAxAFoAQgBzADAA
VQA3AHoAMwBZADIAWABBAEYAbQA1AFYAcQBBADAATABrADgAOAA3AEcANgA3AFMAUABkAE0AcwB4
AHIAQwBIAC8AcABqAHUAUgA0ADgAcABUAE8AMgA2AEIAUAAxAE8AeABNAHIARABZAEcARQBtAEwA
MgByAC8ANgAwAEkARwBGAFQAVgBFAE0AYwBHAHMATwBMAGoAVwBPAGMAcwBzAEIASgBiAG0AWQA2
AEgAQwB4AHQAZQBIAFIASAB4ADEAZwBwAFcAVwBvAFAAQgBsADUAegBIAFoANABZAGUASwA4AGIA
aABQAGgAagAvACsAcAA5AE0AQQBGAFoAYwBPAHMAbgBzAG0AZQB0ADEAUQBQADkAMwBxADEAVQBv
AFUAWgAzAEIAMQB0AHUAUQBQAFYAbgBNADUAZwA1AGoAUQByADgAZQBPAEwAcwBMAHAAWABwAHEA
TgBtAGQAbwBTADAAWgBhAGcAcwBwAGkAVwBDAGwAaQBhAGMAZABNADEARABHAGYAVgBBAHkAagBw
AGgAKwBLADcAVAAxAFcAdwB5AEoAegBNADEAcgBhADMAVgBpAFMAOQAvAEsAdQBkAHoATQBVAFoA
bwBGACsAaQBwAGYAUgBsAFMAdgA4AFcASwBSADUAdABRAHQAQgBkAEgAcABRAEMAZABOADcAawBH
AEwATABDAEkAVQBDAFkAeQBpAHoARwBwAFYAbQBNAGEANAA4AGUAVgA2AE8AZgBQAEMAeQBaAG4A
UABZAHUATQBOAGkANQBEADgAZQAwAEgAOAAyAHgARQByACsAbgBqAFQASQBKAGsASAAxAG0AdQB4
ADgAcQBrAE4ALwBJAGIAbgArAHIAMQBOAFUAWAA3AGwAcQB0AG8AKwBHACsAagBjADgAagBNAFcA
VABoADAAcgBHAGkAMwBDAHgAeQByAGgAYgBCADYAUQBkADcAUgBjACsASAA3AFAAOABnAHEARQA0
AEIAZQArAHkAMwBoAFoASQBXAEYALwBHAFIAKwBOAHQAAAAAAI30

--_000_DM5PR12MB2469FEE0652E6FC89ECA382BF10D9DM5PR12MB2469namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A5C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 14:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E579610E05F;
	Mon, 30 Oct 2023 14:27:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B93D10E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 14:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6tEjmXdHs5hLhlvH/0OP4oHihGjDX0d+eLXTujaginCmITHSysB0+fMulJCkSQvD4suxyUMAXxrtuqvJpvtYN8IloWZJr7a6q08+dWj0P6qRCDG1kt1l9skobWjHghVOV7cJwk5mAAaqhSnY/YpA4e2bLu/YYoaEsUdnB85URNvukxvjkeQ5yEKnyGGxUHnEZYRHIeQoaUWyclFOpH6wS6pmdD7QGs8VGXWMM90FKOqXfoVLvEeHzvxcwUG/lkdT7S01RqYU/EeWvjorrU+b8CdLzN6kCvoiwfcksaS/JuIYiKJXREceM3relgHtbFbR2uJ4yGz2141vhYRFG7fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f22D8GBdSvXlQwr6u/wng/8lqLYMoEJyKdA0sVNprFM=;
 b=es2tTAIt1McWtJPSBjUxQi5lUYx5CP+CgBDIApzqUjOjjF7idmtKbzzELnjOYhyTa1ir3Vh7Ol+ML3yR+maHUTApcG5C530MymZWp/myDoB/xC1O4JTDWSJFc+QX/pvBH1ercWv7k0mWYkHbwzBacWFTAONIotBxxIr8Kr+yatGkAfMQArj00efgx1Scny+mBdpwoJeVnVIQd0QzP6qfggutyZA/nP1u7AqS7pcXtQJJJc/vI1wx3ZCxsmIPr5vtD9R3o33B2jUXCPqS0v1qhAOVoP8LDJTrIOQgqntuVkxlXABDEOgoK3OTfM3WIA712x8IZ5qd1lmCOWzYA1JP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f22D8GBdSvXlQwr6u/wng/8lqLYMoEJyKdA0sVNprFM=;
 b=vsVOKDBiLYH4DlpFaFudOGYob611sf5/b44e+WZL4vTy4Nyz+rreFPSHSMgD7Mo6B9oL4QhjE1ftcYemaX+VqbBZ33mO0izrBRwVVpaRkT6IcaUA+0WfFNC/RjBXea3TYe8klt7DH1JVp0H2OiYiq659Hq2xXaWx/ZNSJDxIjrI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 14:27:41 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 14:27:40 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: move kfd_resume before the ip late init
Thread-Topic: [PATCH 2/2] drm/amdgpu: move kfd_resume before the ip late init
Thread-Index: AQHaCwyvzeDxH+ahT0eSEwOsgdm5/bBiZEVA
Date: Mon, 30 Oct 2023 14:27:40 +0000
Message-ID: <CY5PR12MB636964176321B3A785E96147C1A1A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231030083658.537469-1-Tim.Huang@amd.com>
 <20231030083658.537469-2-Tim.Huang@amd.com>
In-Reply-To: <20231030083658.537469-2-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8017e5ac-c527-470c-a32a-7ce14c540aa3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-30T14:27:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA0PR12MB8837:EE_
x-ms-office365-filtering-correlation-id: bf93bf53-0ffb-4381-a028-08dbd9545faf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIUsC587pEUX6xGSTjENV7QgHlnGCltWNBR6mviwVaoj0mQbIbt60lEK5WzJuudrbJ3hwO1M5yHBy8ZyM+nm0cFv46ApxCFTjMLaX5Jko9l6IcyCo6jLLSzvildzSPnO7mxP0S5mu3pqSDojeyspzIlK6MuvJ+Jz2JPorK81K1IsSboDqyhh+vIxASKU76c6taGlPtGY2EMY7XDF2DQF2W7569t/b4kr59B6XU2MTVEgUfk2/yfUZzUfiftfMU2OYVe2fZPh4x6Zf4x6QzYa/ebWb9PgHWr3jKPZJgh63LiCsdVduKHfxbA/nxFV+tn6pM6eD1n/rcFIu3D2kq+Qi8lTaaXn2jbQf3okuULLXq6A5d38z2Ii2RJlB4+M8ShBOt8QlGlOY+ggic98LNXj66IZnCk4GJzeg5XlXgPT+Nc6am0AovqVIbEbUCoMuRD9/Hh4kdZT0jNNGded7n3TSKd8kBkbexIYQRf4jpblyRNhO0niuyS591iD/4YKTPHN/+n1KrZAk9ozqaur/8Ode6WwTOB7rA+RE1ypDq/yKVA0MIu4X4/4DOPSFg4ltG/nAkJ4V3sqcOtTaJLVgBk1vmakmjVZyecvu2TQm9ahGWjawN71Q6M2+lkw1h6GWoTI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(64756008)(6506007)(7696005)(53546011)(71200400001)(9686003)(478600001)(83380400001)(26005)(2906002)(5660300002)(66946007)(41300700001)(66446008)(66476007)(66556008)(76116006)(52536014)(110136005)(4326008)(8936002)(8676002)(38070700009)(316002)(86362001)(33656002)(38100700002)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cRvHMa7IejwRQJQO+xA1i5S9zorbG9qDrMoUj6/F4eYiaAZj/7ANjGm7jTiV?=
 =?us-ascii?Q?lEw3F4ecxDPUaWOACt7OZbYVZy5EI0ry2SetyTRi8cmXF+viV6QPrmFEIHq5?=
 =?us-ascii?Q?e81S8Bk6utkBYgaPRv8XC4JWiIyD+5OdRfjiKg60U/hv0WvYZVjOOFSCqTsd?=
 =?us-ascii?Q?76+mZoMuy5IL/FL0qHGGAN9frHB5Wd3YeUwYFFNhNCShJ1IRZ1+b3eWuqY7L?=
 =?us-ascii?Q?nuViXiGvpm8ZC05x0PNbBg8lwXSEZq7OHWb92ANKUKyGhvu9HMMvt1UwfJtY?=
 =?us-ascii?Q?4iNQGi9NqcLvu55LhFFJFe6X0yLMVMPRGF7uOxfSPM/K+WhRqJ/1xZOS94DE?=
 =?us-ascii?Q?rAHPzmOIldV6wa+BWmll+2l/nnQch/UMXTYkdxvATf+ilmEmvP40i5eFkR/k?=
 =?us-ascii?Q?igUPE8mlHlhhPyXGXRGN/E9PtewVCndE0+l5AwsAGCX6mkXqLAY8c6eDCZQO?=
 =?us-ascii?Q?Y/uZnm6YI/p9r99FXoTLr8bgrKE/B9NCi6fpE+tPIDpBjO3BLzxmfV8grWPP?=
 =?us-ascii?Q?8v/G8p/p49k0TO4qDjFsdAkGdGEAlJpobvQBEBCCUOYFmHrWud+fGaszassP?=
 =?us-ascii?Q?gk5daV6tWvTa5fzw81K1hOhGdi6t56N2CjPeYJ/0lCUAUFoNIwQHwIute28A?=
 =?us-ascii?Q?MMhDcV6RseeSxyByprAyqcn9SGTNFltRDkRz07YqJB2dI3hWfVlMlDcSRbVb?=
 =?us-ascii?Q?BmhWpWm2qHQ+K4I5eECX7UlHOySTWdkPpfFZSNWHMu53tY8o4kOPF/2P3Wac?=
 =?us-ascii?Q?FGHZAvUzSWUWaZJ+hPkDrG4ntV600Zhoe55cNHX9m+IgzqKESk8qF3lLa8k0?=
 =?us-ascii?Q?kFLXvbj148+gSEW8xcuezkEPNuiQF2EaqR5xoYrQorQhy0exCShjRuqHfXX+?=
 =?us-ascii?Q?KX6VhLiMwVp1VUSOpTefw2WPlNxVtWIbS4NaMVw27bwQCbvLQqFsycignvRq?=
 =?us-ascii?Q?JMBt5KXbB2kkfNcjbPTN+iTDYqZUq3VjuBX40g7EQUw1LK5fzJ0eUpUcUtFA?=
 =?us-ascii?Q?oR9mt1c6spA7wkMujR/RdUvfh9ZqJvekiK/VabDHJO5fmnb0+eQoZyd4JdOX?=
 =?us-ascii?Q?Ivvt2+17KsePIiT9qwDBVpsTR6Is7cQs3PH0GuE6xeQe6BXxeEKXv5Nf9JAA?=
 =?us-ascii?Q?+7j0DKjnCb3SjpDSUyJtwcCTIrMR2Ha6NMgHI7X0eLmCv+PdX05If97myp7q?=
 =?us-ascii?Q?j6gku+47nDyE2C3//NJYn47iykAGz/TsGuSEuU9MAsnJcjIg01raZTgZXANL?=
 =?us-ascii?Q?R81WXLTvhlpF/5oMWSFQbw8TuudyGBj0Ub9AenpNSZ9OKuJgs0XZMXCzo8vv?=
 =?us-ascii?Q?6QpjOrrk3X8kU8mmpU/SBSCuROot5nSWDn3u3R5WihScd4ie89YBul0yefZu?=
 =?us-ascii?Q?9twGxLQKKPrajZSpdQmvHou795q6K10QMquWIFSqCbHRloTa5E9jpfckxXkM?=
 =?us-ascii?Q?gHQT7oW6tC8FVHoCMNMXogzMrEleAsAJr9QqjhyCDLfPVZwW4YiizUcSEtX1?=
 =?us-ascii?Q?TumWd0ahHIgtFA0vtIK57nowTORbwq+FmbuDCPlkaC0hHUs8PQijerOa2J+Z?=
 =?us-ascii?Q?bmZ4O8GMY9W/bGwHt2E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf93bf53-0ffb-4381-a028-08dbd9545faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 14:27:40.8377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynFb3VDZg+KxgB1FFBXW7VPZVVSXZMB+eBg5FTyGtfNv5YkjHn7/iuZDl085XpHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This series is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, October 30, 2023 4:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: move kfd_resume before the ip late init

The kfd_resume needs to touch GC registers to enable the interrupts, it nee=
ds to be done before GFXOFF is enabled to ensure that the GFX is not off an=
d GC registers can be touched. So move kfd_resume before the amdgpu_device_=
ip_late_init which enables the CGPG/GFXOFF.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 21b8a8f2b622..ad98be349100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4478,19 +4478,18 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol fbcon)
        }
        amdgpu_fence_driver_hw_init(adev);

-       r =3D amdgpu_device_ip_late_init(adev);
-       if (r)
-               goto exit;
-
-       queue_delayed_work(system_wq, &adev->delayed_init_work,
-                          msecs_to_jiffies(AMDGPU_RESUME_MS));
-
        if (!adev->in_s0ix) {
                r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
                if (r)
                        goto exit;
        }

+       r =3D amdgpu_device_ip_late_init(adev);
+       if (r)
+               goto exit;
+
+       queue_delayed_work(system_wq, &adev->delayed_init_work,
+                          msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
        if (amdgpu_sriov_vf(adev)) {
                amdgpu_virt_init_data_exchange(adev);
--
2.39.2


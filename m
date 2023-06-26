Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E477DEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 11:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DD710E1CC;
	Mon, 26 Jun 2023 11:17:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAE810E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 11:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeyHGirqAnvPZh/GVtT3lgb2QT+h53vpH4ftok34Vbv/2DeoO9OaedbSvC+ZOfMXoVOgF9clGSumULWgYT5c9iWp7xQQGNxM7nShxX4PKAEK+hS0lh/OEfWITb+gPqOK7h9vkrgqL0IDK6LcDGkkoooxIoTEKGY1zDaIHuWv4JxdcN6x1D/HI0cUOSfkL6O6NhJrQck3beuwk8K83Zoy+aKWdGDFeGIPJ8IcKKdo+VK3YsFiAzYDQXiR/zTBc9G9o73Sn+jL4mwo25bn5OqgUlJIcrlCQwTyTZUC9KC5KfTJ/lL3dXvcpjYik4MR0ZdkyJi3wsAEgswFqkIHQlj3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjgCfKTMQMTyUEML7D7gsNeU2akZJqWBRRU23jOehEA=;
 b=frKdIK5h1aqHThhaSGlZHTpbE+dUxmEdB/3nTlJ85p81kKx/UM3QPQd/HrZtLLlnv54wGgp89L3XpZT3YNcU++LCtT2CDzwmrB83uy6IuvPRydnux30Jxx5oXTPHrxqd5qL4pKrzVoIdfcwdZviMBK/pOgoOt27npPWe1LIYAsB2epyUHEAcin63md6LV4puqSjKDa3VrSnDGSPXGWLKIMafGFiI7S8o9itxiI2ZTWdBFIDxf1/2JuOIN+43uUHJk19+ffIn1GU01HE8uDC64/R+ZhhIrerERPAWFIjIkYQRJZlGGnP1XEwv0vQEQ6S7/CL0NBFu7ftQPb1R9ItHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjgCfKTMQMTyUEML7D7gsNeU2akZJqWBRRU23jOehEA=;
 b=qq9+NRbfDJmB27OEx7mQz9NrpZtR/mmBQH0qRbhZMAP7deRtbOXgabFAn7rE0YImH01d8MzPlaOsvADZDStSTOvlikg9RxROSiP5wEj4f0DY4AikPJld1kyD/dG1alXTPDziHzSjpYAqkYEMWZjbYgtKEd7YK+QK8iuAEuAZAy8=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:17:25 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::5a8f:ad4f:8874:8e25]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::5a8f:ad4f:8874:8e25%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 11:17:24 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: make mcbp a per device setting
Thread-Topic: [PATCH 1/2] drm/amdgpu: make mcbp a per device setting
Thread-Index: AQHZoJcBtvfq4nHzOkyOxpad15ug6K+c/kTQ
Date: Mon, 26 Jun 2023 11:17:24 +0000
Message-ID: <DS7PR12MB6333437BDB9528EAFC2A789CF426A@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20230616211011.31578-1-alexander.deucher@amd.com>
In-Reply-To: <20230616211011.31578-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=910faadd-04a5-4c8d-be18-5d633b9095a4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-26T11:16:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|MW5PR12MB5682:EE_
x-ms-office365-filtering-correlation-id: 69935479-080f-46d9-3297-08db7636eb09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tM0etyJ9l+qK9v1JsEEFi0gmmXqxHI1ac5btWa2jLAXm5/gyP7T4AD14hYCo4ZRN0eFaaJLC+7eCHybDPgArPJdqCs0b0o1pe/+6eePU9OpiFSkCFFsYm02scp3vbjAaRSIG6GEuuvw32ELpBSRZCv7ju0mZAkstP/Sul6sgE8kggtGWXRI9wkUzQluTUBHhyZ6vqNbpxDPq+Jy7QJIe8vjpy6IDYf2SNZNglRq+6OT47VBgAiO/KqZ/RsDdosSyQULQmXGlUtA3l3+XdKeqwvmwf13AGoJHDVWObm4Hry/Tg3/2cOymme+2x0FLCPd6oWl1JyzLtJDyPOxZyiHOxUmn+3vC7lX3zNdHzwwzqPmTV/GZPelHDRaB0Icybj0VEEyffR8EmHdX9KTKxyJz67q2QdXaECoEO/Ye5yvBEBmo+AGwg1QZArFB8hfx77m9f4ygGitJwZBXPzdZn6HMEXDA2A9HDIkn95zrjUYNar2Tchgq8sH6lWA93KG3MuJWPfk5JNd5UKr6XIA7zcsF5cZn+90IvO02ixYvK21f6CNjZjcrymuGRHu2zkAlyvZMopKEOv9ovMNj1zdj5LLM7nzV7ap9Rm4vOw50WvckZp4wja7WKwZ4UsPxVkcyZ7Hb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(478600001)(71200400001)(7696005)(83380400001)(110136005)(53546011)(6506007)(26005)(9686003)(186003)(2906002)(5660300002)(33656002)(52536014)(38100700002)(122000001)(66946007)(76116006)(8936002)(8676002)(316002)(86362001)(66476007)(66556008)(55016003)(4326008)(41300700001)(66446008)(38070700005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7n6G6ZPdykTFhdKatzmzK1Tc4VOD7uhmt5HPGsv8Up2z0d8BQFdo+VfHzler?=
 =?us-ascii?Q?L92kJ80PRrK66APjBcXO3kXlvwBHCR0q/st3EmqCZ4FYCjyKv44VwoLSRxb3?=
 =?us-ascii?Q?NdNrqbp4eud9KsI5aD6dtwLoK/l+tEqRyykKskORCdcefQ701QlBGFQt8HV4?=
 =?us-ascii?Q?Z+LGOU7hrjxMnqybV+YnSjbx/mvfG+5luvbyBDRoxmpyq1MwEqFMjBp5WUAI?=
 =?us-ascii?Q?arbgg8uugGkK/ofPTCgEv+TDVymgjbnUgiZnKqwRVivpdbzbDFiLypGO+l5d?=
 =?us-ascii?Q?zdkapH9QzumcYHkmDVXGTPx3PeOTO/QbtnCxyHtaW7Uzflna9C6u/ifngl0R?=
 =?us-ascii?Q?obLo3S2QKCl5i8Kc5hx2KlbTWKBpuIaTFtHtPKxRyXsPGAx4oQXXeW4NhoFb?=
 =?us-ascii?Q?9zu+lnC9tujR+BSqMYP1ceTq3X6cH2mztuvedvgBs9wGHx+pE4t/Kj2PaBmq?=
 =?us-ascii?Q?u/J9Yptm20j/L0lAur8ez1DkBFZNZqyD+tkAq8fyiKDv8XhPtx8m/zn3GSRm?=
 =?us-ascii?Q?EJrdP1PjeJ8Emsyk2SVCYCLxy8PV+0T3sMoE2Z+ijXVbZ/KvL3ks+uC2tluu?=
 =?us-ascii?Q?/txsYiXk4LJChoNvEM66q/O4mnRzn3dR5XxrT37Jt4Fn367VssntBCoKazn/?=
 =?us-ascii?Q?UgaEyZcAh9PJ/3aAXixcnIPukffPPXliMm+nYA9sofhfkLmODPue0YlGfdIO?=
 =?us-ascii?Q?FZGkE/qEUrihgn9+nrj9bebpuVfPnQ0OpGqZqKX5qA9SmiefwZhUtRBYb6zw?=
 =?us-ascii?Q?j2HKZ6TYt+CARO4tvzBB5lMyzHkQfUnuvSHR+XWuEqIKK1CugwDqdfet80pc?=
 =?us-ascii?Q?lo+JQWfFyDSBQMJ7Mg8MRHK9ZuNbyiWljjcV3V01mEMDRc9w68h8nNo/3Qzj?=
 =?us-ascii?Q?4V0BxRHad6m6R0FaPUbhviqzXoaolI0ezgwvMCPfBkPvfvkACOYnz03Rse+8?=
 =?us-ascii?Q?yNvAD9CutSHGQaMjvES2jtqB5sQPK7ICEqtIwO5kVb8ZdCOpSqziSjDYh0eM?=
 =?us-ascii?Q?aa2aDemAbMrdDXv5bAFjZBb0uJRLLjybCp7QsgkVIPrO/I5xF+2CBw0VcH86?=
 =?us-ascii?Q?0DxBXKU33dHM7+4csMgOUkYYkuMo4TBYGTOfuKqthxbn+TQAXCEgPKruBJu5?=
 =?us-ascii?Q?xRkhz6Ny/9xD/S53ICOS0IGPn+uH8teYaL//OeOSegBLESOYtrpDX6Nw9Jle?=
 =?us-ascii?Q?k+yCLDOehA1HNY9X4c46CndguH1lb2GNPRaN2ZHcUqUk9+7o2TCQwBsCgT8S?=
 =?us-ascii?Q?d2WAFaivw/0GScqm/47hZitd2icsnmECpQdTScy3IPwdD/W9lUHCprjOpbX7?=
 =?us-ascii?Q?Ab4h/MCz+WX+PiGimdv76G8X+/BfaSGWsjKwb+ouHZIcVlqTL3DYbrLzZMwf?=
 =?us-ascii?Q?cABJmtOy+5sAzTJSVfw+819VPu6du1Ur6xIeUyadMZu6JzXMBcWxPOVoF1pU?=
 =?us-ascii?Q?MgL8PPEOC067qB/H6F2P0L4KyRBa0wfsMVGrbtKFz+nANJ6OzgYBxux8yk3l?=
 =?us-ascii?Q?C5CnyIMOCqdlWXYOtAe6uj5tnW3JkrNrco9gMNQojVY5QEVzJs5Ox1E2Fod6?=
 =?us-ascii?Q?i1oaONKJp73Dn2fV+lo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69935479-080f-46d9-3297-08db7636eb09
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 11:17:24.6113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /f/q53mO0zMZmg8SD1b7ntIeKNgbvpKosCwHX9FjiEqrVXK4tmIEWazLSPf6+EcrtXQlvLW4gHqeClxhXhgQ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

Reviewed-and-tested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, June 17, 2023 5:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: make mcbp a per device setting

So we can selectively enable it on certain devices.  No intended functional=
 change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +-
 7 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f39db4a2c2cf..78c6265fe79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2551,7 +2551,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
                        adev->ip_blocks[i].status.hw =3D true;

                        /* right after GMC hw init, we create CSA */
-                       if (amdgpu_mcbp) {
+                       if (adev->gfx.mcbp) {
                                r =3D amdgpu_allocate_static_csa(adev, &ade=
v->virt.csa_obj,
                                                               AMDGPU_GEM_D=
OMAIN_VRAM |
                                                               AMDGPU_GEM_D=
OMAIN_GTT,
@@ -3672,6 +3672,18 @@ static const struct attribute *amdgpu_dev_attributes=
[] =3D {
        NULL
 };

+static void amdgpu_device_set_mcbp(struct amdgpu_device *adev) {
+       if (amdgpu_mcbp =3D=3D 1)
+               adev->gfx.mcbp =3D true;
+
+       if (amdgpu_sriov_vf(adev))
+               adev->gfx.mcbp =3D true;
+
+       if (adev->gfx.mcbp)
+               DRM_INFO("MCBP is enabled\n");
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3823,9 +3835,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base=
);
        DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);

-       if (amdgpu_mcbp)
-               DRM_INFO("MCBP is enabled\n");
-
        /*
         * Reset domain needs to be present early, before XGMI hive discove=
red
         * (if any) and intitialized to use reset sem and in_gpu reset flag=
 @@ -3851,6 +3860,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (r)
                return r;

+       amdgpu_device_set_mcbp(adev);
+
        /* Get rid of things like offb */
        r =3D drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, =
&amdgpu_kms_driver);
        if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index ce0f7a8ad4b8..a4ff515ce896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -434,6 +434,7 @@ struct amdgpu_gfx {
        uint16_t                        xcc_mask;
        uint32_t                        num_xcc_per_xcp;
        struct mutex                    partition_mutex;
+       bool                            mcbp; /* mid command buffer preempt=
ion */
 };

 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index e3531aa3c8bd..cca5a495611f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -805,7 +805,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                dev_info->ids_flags =3D 0;
                if (adev->flags & AMD_IS_APU)
                        dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
-               if (amdgpu_mcbp)
+               if (adev->gfx.mcbp)
                        dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTIO=
N;
                if (amdgpu_is_tmz(adev))
                        dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ; @@ -=
1247,7 +1247,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct=
 drm_file *file_priv)
                goto error_vm;
        }

-       if (amdgpu_mcbp) {
+       if (adev->gfx.mcbp) {
                uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) & AMDGPU_GMC_H=
OLE_MASK;

                r =3D amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.cs=
a_obj, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_sdma.c
index 78ec3420ef85..dacf281d2b21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -72,7 +72,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *=
ring,
        int r;

        /* don't enable OS preemption on SDMA under SRIOV */
-       if (amdgpu_sriov_vf(adev) || vmid =3D=3D 0 || !amdgpu_mcbp)
+       if (amdgpu_sriov_vf(adev) || vmid =3D=3D 0 || !adev->gfx.mcbp)
                return 0;

        if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 25b4d7f0bd35..41aa853a07d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -66,9 +66,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
        adev->cg_flags =3D 0;
        adev->pg_flags =3D 0;

-       /* enable mcbp for sriov */
-       amdgpu_mcbp =3D 1;
-
        /* Reduce kcq number to 2 to reduce latency */
        if (amdgpu_num_kcq =3D=3D -1)
                amdgpu_num_kcq =3D 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index be984f8c71c7..44af8022b89f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8307,7 +8307,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,

        control |=3D ib->length_dw | (vmid << 24);

-       if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+       if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
                control |=3D INDIRECT_BUFFER_PRE_ENB(1);

                if (flags & AMDGPU_IB_PREEMPTED)
@@ -8482,7 +8482,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgp=
u_ring *ring,  {
        uint32_t dw2 =3D 0;

-       if (amdgpu_mcbp)
+       if (ring->adev->gfx.mcbp)
                gfx_v10_0_ring_emit_ce_meta(ring,
                                    (!amdgpu_sriov_vf(ring->adev) && flags =
& AMDGPU_IB_PREEMPTED) ? true : false);

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 690e121d9dda..3a7af59e83ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5311,7 +5311,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_=
ring *ring,

        control |=3D ib->length_dw | (vmid << 24);

-       if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+       if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
                control |=3D INDIRECT_BUFFER_PRE_ENB(1);

                if (flags & AMDGPU_IB_PREEMPTED)
--
2.40.1


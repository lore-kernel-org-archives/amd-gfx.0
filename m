Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D699C48260
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 02:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDC810F138;
	Fri,  9 Feb 2024 02:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlO/z8Xr";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B100110F097
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 02:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h84OvRcCSIfeZk745tp9DH1ycvy1ozBkR/md4VX5WKsl2jPiaAqjcOAj1pzi1Oaja/NeaUiFIW3RQW7hdoukHjXQQmrBvcOEFtTyRzwQEY2JfCh3wWP0h5/0cPncGO1hhJUwIiML45BwvrokXGxOFsiodDhjLaQBqKi7iwAiEEhHhEhkgb0iTfdcWO0yw/TmkFYkX1jDjRhY2FKDta9JXTlYiNm0OsGUm9ZugL5JAZA4HiIC8NCyQ3ks/HVYsM5yoj9IeRPyaDpB/+YU1w3Av1vAGsVAI+6K0QgI6Eiw1hGLzpzmBiF0j8cOZFAcefW1VMmyUXytSdfu4yy5DAr4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuU6u0Da5XVLOsAAd95MCr9oOm+SFS3fVjd+DXkuRKI=;
 b=gxBgNIptAWhkYNKhWSKa9xDz6Sj/tcfkWn54Ofm6DynILZE6eu+rNG+K1BsWIBJmY9FmRyLdL0FBYCTBaoSSvrwy0hLbKUf4gr3QfDmOq2L5ggK+xZkAu5SdjY93YYGQIlNSbpVxF1u99uanDrv99QxQCC2rOusnC4MthddZrAeTESA7GluiiMIoD03+jjTeuxNqMv21OMB80Josqy2zErIeSWULc7OoTB1CTH/r+kn8U8n2pAUN1DpjoiFJNYivgdC9y0738JnI0qSMeYOhyMnjUHUciABHcrda4KhWQMqKI7PF/xKSCxa18ensc34e77MoBCio3AJMaBXPVxTaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuU6u0Da5XVLOsAAd95MCr9oOm+SFS3fVjd+DXkuRKI=;
 b=vlO/z8Xrg5mgDt4MysaBYoFoEkMG52jsXAVao/0z9iUESmcUpFmLYYE9jWNQ96mGdFJ02+vLZVrGIyA6dv+GXp57TjwPoIBgRT75Z7ziK3hIseWlc9LxSbbS+vj20UyIc/VWSbU255uSeMTsc0PhQVhrFF3/lQnD0ivxE5FbiQc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 02:55:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.020; Fri, 9 Feb 2024
 02:55:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/psp: update define to better align with its
 meaning
Thread-Topic: [PATCH] drm/amdgpu/psp: update define to better align with its
 meaning
Thread-Index: AQHaWtP1WpL6psyDTkypVB+4t5w9pLEBURzg
Date: Fri, 9 Feb 2024 02:55:22 +0000
Message-ID: <BN9PR12MB5257E53C8D2C6B85D7EC39BDFC4B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240208211502.431836-1-alexander.deucher@amd.com>
In-Reply-To: <20240208211502.431836-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=728ecb07-13a3-4795-9111-55bf8603db0e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-09T02:55:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7581:EE_
x-ms-office365-filtering-correlation-id: 8c8ed1f7-f6d6-4eec-7282-08dc291a8efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0MiT90yO7d4I0WtmpA1Befh/jOzGBn0SGwxSWusIzhnafHT+8njLRPlgdCDQIuajsUXuQPpILXvULxCfJK72HBqI+rtRP4xYaWM4xActNRz6w0l4rF0x/CbT/jPCl5h+DReRqZ5rZHjsqoeP4yz9mU+VBnOAIau5va5B+tML4/a3fQlIMl5HEkHCMdmY3+nV26dn6f81AMiesMCV2BdcvW2z0cwSSAH49hsMxHPSfFP/E2ABkzTfodnNP9bcI+WvbHekurfTVmwojsCWEmpJ+ffnpYPXishj+Iag/5HTxoSj3ne8qdbfu/NypfbQA8J3Xlj1Jp3r6MW+11ljVBrWZjDWR+0wEHo7EdhpUvdOFXC+o5Wh0bGSy8qcL7sAozpXz/EMH9Qsp3rsPIIvJaWL4NajLRLuhCpFHkxPOELxwZQugQ7N32yN+bxLErzPsDwhE9P097rVXRqc7uFYakYdKqV7M5OPTnrPzy4Zr85mDrJ6upFBN/IHGoXL0y0xtmKrPGtaPSplVMgfSUJBEMxNVgI3+xsxhWybxHNLlTap4yM5+raspSAF2/XENOYqEpvMvad0h1Rrf/4yOsMqsoh/zjxg6e5mtv7582sUhtUkfOD/3w/lpgqqQoudluBqJ+Kn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(53546011)(6506007)(7696005)(2906002)(71200400001)(86362001)(478600001)(38100700002)(26005)(9686003)(33656002)(122000001)(55016003)(66556008)(8676002)(66946007)(76116006)(4326008)(110136005)(66476007)(316002)(8936002)(5660300002)(41300700001)(15650500001)(64756008)(66446008)(38070700009)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GrpLd7b3ARsRrGCneKcwixu1uv2j5deZiOXrFuyNVbBPtBn3lMeDbbH3y/L2?=
 =?us-ascii?Q?klLcwj6SssgcgQzlMs1KmDV55A+lJckxRxPf6rGHo6Lb1q0sr08JAArqV8xv?=
 =?us-ascii?Q?6/2rOW5ApLGYa5wo1Vmh6eCOY8rJA87eMam72U6RkLPjoP+otaGFRN+ZO53j?=
 =?us-ascii?Q?HNIbOjyrf6BfLRGdOlUY8a74iOK6H1rjSMsG/9jv2dIf/kICqUPf/xw2lCEL?=
 =?us-ascii?Q?WTVZq1X/qhH/2ldazkiNIRRnkmLISU3lRvDtzSI/XiGoFeQTx/aDJf98Cwg0?=
 =?us-ascii?Q?skGvdMuXirCbj6/uEi9FV7z+HikGTHmNej6bFhugdt/4etFkjonN6Uwx8DSf?=
 =?us-ascii?Q?Li74N+/0pUPhKSyEoHH3PkU9OplBreb3svrwqXmd6zOUSUbyroA6KxTmmlwW?=
 =?us-ascii?Q?oRl9bLg+I7WNvzJH6Gx1kGIS7KOQxH+wJhMEpqIdHMc+t/q2bUaTaIcqdQTx?=
 =?us-ascii?Q?Z1FbLEy+C0e7P/x+/6Oqe1f/LKwEU7FsZVX7Talj9xty9kEBOxO7ERlVYgF9?=
 =?us-ascii?Q?etLy2NaYyLOxiyXGfrmZ30aLdANRbc0PlCozun/4xLyvYYI2Kw7p2zTu2Jym?=
 =?us-ascii?Q?qZY6TCIPRWir9oVWV6cv4JQJ8NVpQ5CpII/uYElju8lJLs9y4ySANtI90X8G?=
 =?us-ascii?Q?N7D7a96Lfk+RLcDDyprAjNqape6E/X1l6CXD6A3rzYY4QffWBFgpKrm9ktC5?=
 =?us-ascii?Q?pOSuy/5hR+Aamtn83QiU8Mk9oNv8hfjE8vhT58p3D6JvkoZFX9J374d2KdUN?=
 =?us-ascii?Q?ZqphKEcCeR1XcSSP67hUzG5sbsruIMWooujG9tA3uquCYA8sh1YYLluDCIPt?=
 =?us-ascii?Q?dJD0xPt+AAepLKGRqaBgQBO+9nV1vd/w+V5EclA8irmdZwZho/dXqyK4DR5U?=
 =?us-ascii?Q?cf1HdbiB774FtZ5EqoRfG/9+2IDbhBjIFvEHOgsYn1rPDe23fKVcn4lYa9bE?=
 =?us-ascii?Q?PjnGSMINz9mkRtjmFjsbco6L6H/iB1nFU6t6ipvna+dcZUyDoFHgT81cNq1x?=
 =?us-ascii?Q?gHeNVOFptBpyB6bfxgAA4VvkoBIX9GAud57Yl0yEllIQIfiX+6SW42rHdh4f?=
 =?us-ascii?Q?w0I+tSx75DT/A7+T4C5nJ0QXpGv0alBKtoeEw/9k5UvVwPzElYAkRGLH47Gf?=
 =?us-ascii?Q?LJv7RyA/tvHPkK0N80AREaaiWQoTEEmxtsxzJA6v6+/nU5gPbknch+6mAuyx?=
 =?us-ascii?Q?rkR76Yr9YNvFodN3KHAKHpi0TLJjR3CeZ4ueenItWTtJ4wIc4oRGxq2usIgb?=
 =?us-ascii?Q?BR21OEgsgaJeQYotEsDEkwdl3h8KYyRJy5blAkt/Biq8w45BwYASBGC9b1o/?=
 =?us-ascii?Q?9WH3uJ0pY3dtiFsW4Y3QS7Fg4VChAGCB36cuvmSgljGK1D9I3/GC3jzb4ldB?=
 =?us-ascii?Q?p2Izu4zqrDeL8PzACuWi80L6nKhxrzaPG7+zIWXdSCwKeM37MUER5PkHVxfv?=
 =?us-ascii?Q?p1rboY94JBEmt/I8kEANzGQK73AZUp5W3RJ3dZw+HsgTRQnAdhNvEdOpbBV5?=
 =?us-ascii?Q?5BfofCAoLoAXuwVbwUIyK6OlOqtoPQ1dgJLaNUhUZHYm1ZPGICNcmZ5CVWoa?=
 =?us-ascii?Q?6/Gqw/eRZARfeNgLsx2okxKMV0HftcrdPCMXu9Hz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8ed1f7-f6d6-4eec-7282-08dc291a8efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 02:55:22.4089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsJBxsPc1W8o8MiBehURfzAPmAMJfQPqqQzAsqa5NQWBkSBtIgchFdYNIebBeCRJQGBleT8jQeTYmmY9EbRhjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, February 9, 2024 05:15
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/psp: update define to better align with its mea=
ning

MEM_TRAINING_ENCROACHED_SIZE is for BIST training data.  It's not memory ty=
pe specific.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 +-  drivers/gpu/drm/amd/amdgpu=
/psp_v11_0.c  | 2 +-  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 9951bdd022de..47ffaa796264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -203,7 +203,7 @@ struct psp_ras_context {
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES  0x1000
 #define GDDR6_MEM_TRAINING_OFFSET              0x8000
 /*Define the VRAM size that will be encroached by BIST training.*/
-#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE     0x2000000
+#define BIST_MEM_TRAINING_ENCROACHED_SIZE      0x2000000

 enum psp_memory_training_init_flag {
        PSP_MEM_TRAIN_NOT_SUPPORT       =3D 0x0,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index efa37e3b7931..2395f1856962 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -506,7 +506,7 @@ static int psp_v11_0_memory_training(struct psp_context=
 *psp, uint32_t ops)
                 * before training, and restore it after training to avoid
                 * VRAM corruption.
                 */
-               sz =3D GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+               sz =3D BIST_MEM_TRAINING_ENCROACHED_SIZE;

                if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_ba=
se_kaddr) {
                        DRM_ERROR("visible_vram_size %llx or aper_base_kadd=
r %p is not initialized.\n", diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v1=
3_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 722b6066ce07..0e4329640ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -561,7 +561,7 @@ static int psp_v13_0_memory_training(struct psp_context=
 *psp, uint32_t ops)
                 * before training, and restore it after training to avoid
                 * VRAM corruption.
                 */
-               sz =3D GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+               sz =3D BIST_MEM_TRAINING_ENCROACHED_SIZE;

                if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_ba=
se_kaddr) {
                        dev_err(adev->dev, "visible_vram_size %llx or aper_=
base_kaddr %p is not initialized.\n",
--
2.42.0


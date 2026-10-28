Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F8606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1Yh8NQPY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B0D10FE1A;
	Wed, 28 Oct 2026 18:48:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA8E10FE0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 18:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYh4PfuNnsW2o940zwonDvfY4blMiz89MEwvPQyyectVKkpQrYZMtJ9Zh9YS6GJwBdezxgQbbhIXmhiyzm/pVOAtuyCS2kdEdwqmyAU6AO33geiatue5XFHLpYj765y4Iq87TUzGltpKsrxJ8+zufrRHVzLEI3v++7LEXzBlyV2XENlB6Zw3uKoKPb7Sbpo8qarMrl4D0G2y8OxsYSLaYGxeiPGXYkM8/N9UA+WIdoi+W2xm7N+O1gcrWC1iVcZ9zf1hHhF4S7oyaWhvgJr9V45lHOkEbfhWbmlRrG0U7ZIukPEJgGDHDITmwYr4L2FGs+DKNMlzme/HhwCRpy69Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypfgoKUhe3EbOvdo+hC7t+N0/F5gjbdmXLp6KKl6S8M=;
 b=Fv+wVbndi15vAKe2VzOb7GBCqo+HXicrYVDa9bFs5/UlLBFA4GzlecRSfM2pqZlAh7LKJlHTeHTd7a2sKBfx3yPjVrDdoLTf3jvOkFJ2ThkYiJ8Ds5T3j0h/txbal9VQ8RkUtJ3AYNVZEiUhGGXJmsH12u9Dc4NTidLwtT6DYcFebJ/8i1VQj4VZmaatNuNhg9bwb83vN38PzOUEGSpa4yIPDqygQTI5cdKIyB1pbuAX93TEb7plMeWLPf6QfnihaNIMSZreTaFCUcvqCtdBTfBnNUE+HuAQgyGNBifjL3jcGLXYDD7iX1JW+7MVEu143h54FcJKhwivicbsrSMXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypfgoKUhe3EbOvdo+hC7t+N0/F5gjbdmXLp6KKl6S8M=;
 b=1Yh8NQPYQcJG268jJVtKUX6sm64F0B26Wt6yPdXNdxIBRnCuciNBMxmzS4qzLZAtC2CybmLpp7AIkOpnQkZPtMH4b8DyHtaAOscLlUaaEhphvbhX2qrLLwLgsS5kcqTqVSZkMnhxJCCfrwJRYx9w9AsaX29HDCxDzrXlTm5wuyQ=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by CH3PR12MB7619.namprd12.prod.outlook.com
 (2603:10b6:610:14b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:48:29 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:48:29 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v4 5/7] drm/amdgpu: Add a new ioctl for listing client
 contexts
Thread-Topic: [PATCH v4 5/7] drm/amdgpu: Add a new ioctl for listing client
 contexts
Thread-Index: AQHdX8oVdlf8qdOG50ynGRk4K/aCr7cTWjed
Date: Wed, 28 Oct 2026 18:48:29 +0000
Message-ID: <CHAPR12MB99924785371BD43E9F3652DB28EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-6-tvrtko.ursulin@igalia.com>
In-Reply-To: <20261019130159.11739-6-tvrtko.ursulin@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T18:48:29.019Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|CH3PR12MB7619:EE_
x-ms-office365-filtering-correlation-id: 6a69405b-fcdf-4282-c0ce-08df35240ed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|38070700021|260925021311599003|260925022911599003|260925021911599003|261021121427099003|56012099006|4143699003|11063799006|261022105027099003|261009221227099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|10067099003|261021123027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: imyipa1c6xVKYwAc6HkI1ozYbGveiVPQXgiVnCGU34fjD86GZC+Htk8L1zuzJZvs2abHmgmKqQ3988qgIDirDpptKtitXjQQI8hFstfMMX+rKZWtHshrWQ1LfrSDEunPanxkJ/4LgNm5t5biS1PbLIdCcZc+7gWChmSRnh7aHHpxFYfJKfyVOrn+g27ujnqL4gw6M6CgESKemehb6vnmlynO9LUwA7fVJ097et138heZh4/17kLanI1rQAoaGr2CfloL76fJEAwXlTBJfjSspUv1MD+Ya7kbUc23J4CRBiyEW9J42chh/rofaeVjcSskzganM3oH7g6XvFib3M5PEnzeQpy6APIYHY5du42zVzP9IxMB4deqcCaWV/nCbH47tK6B3Ir8Yx8/63H+Cc5BB9vbJ9akWwceJJpcYE1CqzTCzfPVNXCrEx/u+TUD1l0gW3MtdhPMRU42uv6/h6506A2Kg8+ZsvvkFM/nZtJ4hQEeRCEazeQiTN8MifJcGvEW13H3ScEz71RO0FUXkR6AL1Jw69Ni0PaF/J2EG2L2vHcfieJmLKfMuxAbnT3MGKkg4x+nBNxIVEJFklK/muZakEJSR4woT7zDNiPutTgH73fZkhUYRLrBtjcQL6yeeBJEc7XdTOfiG4Ee4NEL/7caT9RKMNgdu9DOfFORRhrY2NtB4eXk/jIjcdqeNpiB85vy4rkux8c9CkChHgD0a7Yyy+iW2Z98liLYKEN09fo7XWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(38070700021)(260925021311599003)(260925022911599003)(260925021911599003)(261021121427099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261009221227099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6T5eaaHoinSFrE1vnGYCvK6XSaNYBsluRV/4uLf9rXhJMhTqVwCpiY8P61aZ?=
 =?us-ascii?Q?K3/TlPpyszw11CyBIgwuOarKx2Ni538TJyrWUs0vYz/13ViSXSIK+PG2a9Qs?=
 =?us-ascii?Q?dieTt1k3fKdvk9bffHZmezb49A0ARVF56FDA5uXJrZclUzzzlRop40nPqsDP?=
 =?us-ascii?Q?gm62ZdBezwwmG2yRXaQNy1hMdCX838cZZ5KmoA6Wb0nAvTfc52msF7Qw/IeV?=
 =?us-ascii?Q?ZVJvhgaiw9JIYhuUsaSWN2WTpBKTLOQFRzphauz41HKh74S0FgFHkjwTbN/a?=
 =?us-ascii?Q?OHkB4aqzyytFCkSUw4Pw02KySV7ou+C7pnJCCcudMB2tvTKjEac4wYCEClzg?=
 =?us-ascii?Q?Z/lJfDotsP3EHEfEcjbRf6SdFxQ9JX7At7S+hn3YPGKIg+M05ZQv158q1WWd?=
 =?us-ascii?Q?7fp2Tu4ye8UBccCnlfsLG4OM2Pe9j3Va/8afEFkXzrv+NYyaKl9pW/8PVyEB?=
 =?us-ascii?Q?E0Zua8Td5RIAtEzdBSGaloctJmDg+fT6h4wxmZzoF7m3fZTrsnKPsIedkD2l?=
 =?us-ascii?Q?v8jnRDqh6cmJOp5YvVGVJ6n4oxoVde3BJrhOesz4BPMZ25N1hw1+bHPWFPzb?=
 =?us-ascii?Q?UdmTsqLo/vKcOSuxrh+gCifIzJMI1rsC+nQeWcNTc/Amj1hlIng/cqicoUr1?=
 =?us-ascii?Q?GV5uXcI/ZALqLCegmTc2JkME3PBLBgJFCcBxkw/60/jhD/o+zxY6MVnf/RzV?=
 =?us-ascii?Q?lIpfseLbjTG1cdVyUS3zJMmPCh/rxutDWxDm3NJc85EX6RISfoUOVlrkXozS?=
 =?us-ascii?Q?pQ3RTfs3mvwMpH8FkVeQ7Op8GMdCUh8nOSqxFrYZopsRxsDGeOAOj67TPWnJ?=
 =?us-ascii?Q?F0fkX7rcNfDzJ51CkdpKNWQ4nANKWn6A11SXxByUb/CGK0yOtPVY3VNPRy5k?=
 =?us-ascii?Q?Kq7Ep7bQuf7adnUHVvFeLVA/svm5LEjHGVWMld9yeUvMpu+IiwvTwiw6KLTX?=
 =?us-ascii?Q?XCA8OpvQkYoD8UcckQ4uBX24pnke4mrtOCRq7gTskTDr+CqGuEFHTc+KPSBs?=
 =?us-ascii?Q?BS4d0uZKH/9uC2ikFWET6BpAqAqdsXDx9P5MRfxoEJC6cgaI4emT/FzSWnin?=
 =?us-ascii?Q?M/yU47qtCQjP0KfwRCZ76Du+7Z8UdUmcCzMLe6npLNNjYgwRSmaRLdedhe77?=
 =?us-ascii?Q?aH1WtudBweYXrYO8JNIkfK33Ko2Cl8Xcg3qPeJVY6KIgfNj+pAo8vvFNx5F2?=
 =?us-ascii?Q?PuR0zUfnMIrrlGfM5oc4Ax3vM3Dbgu0YQrsNreEriLoh/8NJemS1UehqKxES?=
 =?us-ascii?Q?vvM6XdXiNppQNEjjIW6uOs2+C/tizqoQQB1NddGg+aECM9jNE/MPzF+5+7GQ?=
 =?us-ascii?Q?l3niQ459SU11i+21iUNSKEWqyAAD8xcSb+5azI67fcDMGZ33zshGIpmu5nCl?=
 =?us-ascii?Q?qF3zQz1y8ornFjTGesN0/rg5MZ/OJwGVdu7W0RoPx6FsOuxQz9HcMEqeKcOD?=
 =?us-ascii?Q?AuWoguGrQ/ubEtevOkEw5XtXKGvWrz/PlSsYet0wzbIkag2EuEOHZncBdrNb?=
 =?us-ascii?Q?5mS97AuoBJTeyA7YqidG93847KIdnBK2LnmA8c/hzsFqqb4csDIu5Nda/AVf?=
 =?us-ascii?Q?S1bk9zxzLYQBlJARFQsQg8Uko+dgO3AOaU7h7SqQEQ5MlKzNp+ZHmc1OK2VQ?=
 =?us-ascii?Q?kB8WMXQ8TG7eB9SK/Ofm9xpX7+GSY12HlPDIZL95dlfRK+eYogx/MdayZduc?=
 =?us-ascii?Q?/a8Mth9HSXDzZeoa5dslYcndI0eMLWRKirC6u205qrPwK6sU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a69405b-fcdf-4282-c0ce-08df35240ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:48:29.3173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4WdmvARnu3nA7Wsrnkkp6eskctEgypKg1BdLjGgk5DYW6FiCnvPvQNuKyNNklOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> +       xa_lock(&mgr->ctx_handles);
> +       xa_for_each(&mgr->ctx_handles, id, ctx) {
> +               struct drm_amdgpu_gem_list_contexts_entry *context;
> +               enum amd_dpm_forced_level level;
> +
> +               if (idx >=3D num) {
> +                       ret =3D -EAGAIN;
> +                       break;
> +               }
> +
> +               kref_get(&ctx->refcount);
> +               xa_unlock(&mgr->ctx_handles);

xa_for_each take the read-side xa lock, so not sure if these xa_lock and
xa_unlock calls do anything.


> +       if (!ret)
> +               if (copy_to_user(u64_to_user_ptr(args->contexts), context=
s,
> +                                num * sizeof(*contexts)))
> +                       ret =3D -EFAULT;

Should be idx, not num, right?

>  #define DRM_AMDGPU_GEM_LIST_HANDLES     0x19
>  #define DRM_AMDGPU_PROC_OPTIONS         0x1A
>  #define DRM_AMDGPU_UALINK_HANDLE        0x1B
> +#define DRM_AMDGPU_GEM_LIST_CONTEXTS   0x1C

Might be my e-mail client, but the number of spaces here looks like it does=
n't line
up to me. If it looks right to you with 8-space tabs it probably is.

> +struct drm_amdgpu_gem_list_contexts_entry {
> +       /* gem context handle */
> +       __u32 handle;
> +
> +       /* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
> +       __u32 flags;

Should probably note that there aren't any of these at the moment

Thanks,
David

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Monday, October 19, 2026 9:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com; Francis, David; Koenig, Christian; Alex Deucher;=
 Kuehling, Felix; Tvrtko Ursulin
Subject: [PATCH v4 5/7] drm/amdgpu: Add a new ioctl for listing client cont=
exts

Similar in principle to DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES, we need a new
ioctl to list any contexts created by the client.

Lets add it as DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS, and the respective uapi
data structures.

Structures contain all information required to re-create the context,
modulo the handle id replication, which will be handled in a following
patch.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 102 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
 include/uapi/drm/amdgpu_drm.h           |  31 +++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index 2f0349233695..5eb156d72db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -723,6 +723,108 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *da=
ta,
        return r;
 }

+/**
+ * amdgpu_gem_list_contexts_ioctl - get information about clients contexts
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_list_handles
+ * @filp: drm file pointer
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
+                                  struct drm_file *filp)
+{
+       struct drm_amdgpu_gem_list_contexts *args =3D data;
+       struct drm_amdgpu_gem_list_contexts_entry *contexts;
+       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+       struct amdgpu_ctx_mgr *mgr =3D &fpriv->ctx_mgr;
+       struct amdgpu_device *adev =3D mgr->adev;
+       unsigned long id, idx =3D 0, num =3D 0;
+       struct amdgpu_ctx *ctx;
+       int ret =3D 0;
+
+       if (args->padding)
+               return -EINVAL;
+
+       xa_for_each(&mgr->ctx_handles, id, ctx)
+               num++;
+
+       if (num =3D=3D 0 || args->num_contexts < num) {
+               args->num_contexts =3D num;
+               return 0;
+       }
+
+       contexts =3D kvzalloc_objs(*contexts, num);
+       if (!contexts)
+               return -ENOMEM;
+
+       xa_lock(&mgr->ctx_handles);
+       xa_for_each(&mgr->ctx_handles, id, ctx) {
+               struct drm_amdgpu_gem_list_contexts_entry *context;
+               enum amd_dpm_forced_level level;
+
+               if (idx >=3D num) {
+                       ret =3D -EAGAIN;
+                       break;
+               }
+
+               kref_get(&ctx->refcount);
+               xa_unlock(&mgr->ctx_handles);
+
+               context =3D &contexts[idx];
+
+               context->handle =3D id;
+               context->init_priority =3D ctx->init_priority;
+               context->override_priority =3D ctx->override_priority;
+
+               mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+               if (ctx =3D=3D adev->pm.stable_pstate_ctx) {
+                       level =3D amdgpu_dpm_get_performance_level(adev);
+
+                       switch (level) {
+                       case AMD_DPM_FORCED_LEVEL_AUTO:
+                               context->pstate_flags =3D AMDGPU_CTX_STABLE=
_PSTATE_NONE;
+                               break;
+                       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+                               context->pstate_flags =3D AMDGPU_CTX_STABLE=
_PSTATE_STANDARD;
+                               break;
+                       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+                               context->pstate_flags =3D AMDGPU_CTX_STABLE=
_PSTATE_MIN_SCLK;
+                               break;
+                       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+                               context->pstate_flags =3D AMDGPU_CTX_STABLE=
_PSTATE_MIN_MCLK;
+                               break;
+                       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+                               context->pstate_flags =3D AMDGPU_CTX_STABLE=
_PSTATE_PEAK;
+                               break;
+                       default:
+                               ret =3D -EIO;
+                               break;
+                       };
+
+               }
+               mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+               idx++;
+               amdgpu_ctx_put(ctx);
+               xa_lock(&mgr->ctx_handles);
+       }
+       xa_unlock(&mgr->ctx_handles);
+
+       args->num_contexts =3D idx;
+
+       if (!ret)
+               if (copy_to_user(u64_to_user_ptr(args->contexts), contexts,
+                                num * sizeof(*contexts)))
+                       ret =3D -EFAULT;
+
+       kvfree(contexts);
+
+       return ret;
+}
+
 struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
        struct amdgpu_ctx *ctx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index ab6f9131ac11..79d57659d748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3139,7 +3139,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D {
        DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_A=
UTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_=
ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
        DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
-       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_io=
ctl, DRM_AUTH|DRM_RENDER_ALLOW)
+       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_io=
ctl, DRM_AUTH|DRM_RENDER_ALLOW),
+       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_context=
s_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };

 static const struct drm_driver amdgpu_kms_driver =3D {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.h
index b558336bc4c6..0e17d9fc665f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -69,6 +69,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *dat=
a,
                        struct drm_file *filp);
 int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
                                  struct drm_file *filp);
+int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
+                                  struct drm_file *filp);

 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
                                struct drm_file *filp);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7620d6acfa0a..7f7aae3c2498 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
 #define DRM_AMDGPU_PROC_OPTIONS                0x1A
 #define DRM_AMDGPU_UALINK_HANDLE       0x1B
+#define DRM_AMDGPU_GEM_LIST_CONTEXTS   0x1C

 #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_=
AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
+#define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM=
_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)

 /**
  * DOC: memory domains
@@ -888,6 +890,35 @@ struct drm_amdgpu_gem_list_handles_entry {
        };
 };

+struct drm_amdgpu_gem_list_contexts {
+       /* User pointer to array of drm_amdgpu_gem_list_contexts_entry */
+       __u64 contexts;
+
+       /* Size of the contexts buffer / Number of contexts in the client (=
if larger than size of buffer, must retry) */
+       __u32 num_contexts;
+
+       __u32 padding;
+};
+
+struct drm_amdgpu_gem_list_contexts_entry {
+       /* gem context handle */
+       __u32 handle;
+
+       /* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
+       __u32 flags;
+
+       /* context initial priority */
+       __s32 init_priority;
+
+       /* context override priority */
+       __s32 override_priority;
+
+       /* pstate flags */
+       __u32 pstate_flags;
+
+       __u32 padding;
+};
+
 #define AMDGPU_VA_OP_MAP                       1
 #define AMDGPU_VA_OP_UNMAP                     2
 #define AMDGPU_VA_OP_CLEAR                     3
--
2.56.0


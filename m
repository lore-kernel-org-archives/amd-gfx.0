Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1839CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 05:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8098610E58B;
	Tue, 12 Aug 2025 05:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfe3WHRk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A77B10E588
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 05:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFtdlC7oFBIYqoEXtlVdmMdNMAOcro9l7k9drsAf3p/fiKf1kEtSYJk1ZIZmABgmT97O+Ikvppx+gqu2hEMnbn8sJiJndGu6z8VMyVhJOAiHV4Gdg8VM46t8Y9e6azNiH7nVvNRlqfQPGQr7T3i9gwcgW36uZeuDizzSm1RmqwBObUWjNphHiXT5/1FESneTrfSBJ9eidwMk0NjrIznSe8qlVYEvwgHFNEdlS1zCZIqjXs17ophWMaIMWsgvfnBY/qw2uQwufzov4CTRcaPIac0IbT1jBFwrkUsNjZtmVe8qDiP8bu0nCUPrY3jpZgy39azZOJXp24BcbaAN3M8Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X4zd5m7L0+W3YDR6iE4ixTNbAiYFv0TggoK9M5r0s4=;
 b=FkzRbrdwGCXpa995bR8Yjwhrq4Vd5RB8szz9hWeErWQwvKhg3HKaZib0zSWgX7I9eKGIWHnY25kpAnqiAmjLxSNXX5gJx/zuFrBx0tGzV6vyKn6D9lVm8tgOFnkXtZ2tM4bEC/IM6DMd25wbhcg3pAG+jLxzNjINo/YO8tOfW7jyQx/4goy5fW0S1J6CXrk26PwLuydFIaGHD3tDMt05LgvkHKSxRQoeJ187fAg9IIShC6tw0O9UA3lVQaGrIgSbQjb/+KChXKqyS/bzjfaIY9IccCCd8f7S9KeRbVI9/qr/TsDnxaiIK99OfSP8aMh6zwxh9va3YjkDJQXoSZIJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X4zd5m7L0+W3YDR6iE4ixTNbAiYFv0TggoK9M5r0s4=;
 b=cfe3WHRkWnklzXTjkCWfqAeM62JEQiw7WdrEOfXLIzaglP+Kw5RmNpRoQgAF41EwGSYCkpyNCU8cD2qo06gs5n1fZcWYWvcRtjurC3GXIAKTMnGWCXg6DsL9uTI3wEUynLaCq1lEz/8dFN0Y5SljaHj2gdGD5mRwiHSVIq534u0=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 05:43:16 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%6]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 05:43:16 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect vm flags to map bo
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect vm flags to map bo
Thread-Index: AQHcCz1EIzXPYwcjVkSNiRCAXyU7nrRegWjA
Date: Tue, 12 Aug 2025 05:43:16 +0000
Message-ID: <DM4PR12MB51816F82AD7AA9EC9182CB2CEF2BA@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20250812035720.1257216-1-Jack.Xiao@amd.com>
In-Reply-To: <20250812035720.1257216-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T05:42:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: f6fa1f78-486b-4c7c-6ec4-08ddd96322cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+P7fgvLeMYv/bfBtmU9pKw2GWY7aryP9ltTx2HKAPw9l8sda0piQw3eLk4jg?=
 =?us-ascii?Q?7Y+8NOfFZyCX4lF8fgD0OuBa7cwCy/j+PVHiH2AdAlo6ebietUzL+IG6n8Bi?=
 =?us-ascii?Q?Thje1N/omXXTLC1370TU+LyJcZtYQSEgHetw6ck9o7ywsANrqm7t5jGel15p?=
 =?us-ascii?Q?Uei055TeocwNKu/s5+rZYcBE/y1nxXQsiFpwWwGrGW5JAbZC3MtZDjyb11VE?=
 =?us-ascii?Q?wykmvZhbFaA23nJqS6cmcKBiEu/YFdHAcn7Kh6zJB1sIoyinFnqPwDJMrHiL?=
 =?us-ascii?Q?wBjGCfn45+Y5inV4HdY+mWOcdK3urY1GCYR4Qh0HYe+v0s1W0lPSixj5ExJs?=
 =?us-ascii?Q?hyVMYPwOEo+D1ih/WgA2n+AXVtI6yrawi058kyMzR24BiCLClhSlV+kVf//j?=
 =?us-ascii?Q?dvlzsS0CqLXcowCuT/jFUKD3HY4NdI62w6CORTILkc4mGu8nyrrvEESwPnh8?=
 =?us-ascii?Q?5v8y4zi7k5Ol3Lfr/W1dPLmd2REMV1GqpmF6G28zrncehEkQrKeWLC88NFC2?=
 =?us-ascii?Q?vCit+tl+4qovPXq3O5qHQ0pQhAzQXI/WnrTLAWyaqLp3OavTVISZt+RZEzyl?=
 =?us-ascii?Q?8PwBn9g3WHY862DLMwrb4844+U31FTzKp200J2fCGVbnSQykaTJ7V6hTkpTm?=
 =?us-ascii?Q?1Z6VIQxNjiK4oYNm1bwZtq3OLFCMYZmWy1ikQnDpe/Na1vx72Om3jvrzfHrO?=
 =?us-ascii?Q?cMZaAA7dUMFazF3rxsKoH3jA7IgjzwXnvdDvwATAhIr/ZPm78MIvRqvx1dx2?=
 =?us-ascii?Q?rUKPfa+3rhWKyf8K3xAwnDBes2c0CTOnXZPmvSjZUaiLI/2qZG4BY5Mu6BM0?=
 =?us-ascii?Q?jRbRt3FDjvhnKbhOfp9Hfmjrh0kbSaQzCLlzh6KieZMLcrRV0Pf2DgGFGgo9?=
 =?us-ascii?Q?Sj8eCkZRuB9lWOuf5HEuOFS9EGJ1dvctC2z3M0re+4K+Bb0thmPbdzzCDKK5?=
 =?us-ascii?Q?/Fre4WnoAhdbyu6KqXzvCfKeq5o/dXuvJAiuoK2YOplwAA6Im8YZVCfxM8HT?=
 =?us-ascii?Q?cqHh2rxXWaK20NbvTJqKeLwPuJVUT9BbKH4MxIRCSn8rBGYJZRUFcK1nf2Xx?=
 =?us-ascii?Q?/JntEA7V9Qr0+h4MXRl7VMidt16VhSsrM56pOTBhaJnDfRyZB+Zut6sUhONI?=
 =?us-ascii?Q?xAssnXG8fiUWIIA5ERHM2dmbquo8CKN0uERX5xcuhcqnc3KCP0cuKHW+xaLy?=
 =?us-ascii?Q?hOxzwJSkLMUtBTdtrWigyKCGRXiOyNU8fjbxZUSYSI3Jbrh9goRyMJ4tl8Pv?=
 =?us-ascii?Q?uAXmYnOqYDXMtlWiJPLKWmByg+n1HLlZVfDrmATKmUwTljEfoOBIq/fj26++?=
 =?us-ascii?Q?ra53MH9nyccqplozTk93zIvIq3cW1CtXGfVJp9DdsRhqClxWW4Otw8MVHlQb?=
 =?us-ascii?Q?z5UqcuMYBwZv8pHIpOGzWBQ4ysoSA3WJ6dwZjHmYHDRhjCV1fqD/P9+2p/Ru?=
 =?us-ascii?Q?7KES/FNTSTpDkPAsWX2pf4V1Q9uIn9AnZ4vd1DGpq3cpZh0SEmg99zZ2NKEk?=
 =?us-ascii?Q?RJaYbNKPyagTO/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e/hZaEb8JLweBCwBA8kriRCkmqc5EOdzVGKBsNOoOF/CbjA6wrzNrQ30gUOL?=
 =?us-ascii?Q?816zV5Kt9uheR5UbfRf0nQPeVCgnC0KXCaXtH+LpF9KB3sIZayljtLLver1E?=
 =?us-ascii?Q?viYdSOpvUZKg0d7D/0uKd0Q2FcFxf1xY5CDSg/XUS2Ew/WjAiLwqbfPKkIgY?=
 =?us-ascii?Q?feVUugoP2CnhuBd7XyOXUkvT1wJysiGBI6RCDs0MxzhM40GoIfXbdjfh+RhK?=
 =?us-ascii?Q?qQ9oMDu4tySPbYy5C4S+vLSN3Mrl/HTN970Dck8rEsNscSM3wp7WyY+Nmw77?=
 =?us-ascii?Q?QuNfGi/gvhJm2DnXCyJaS7TAqnZTyRPCoe+xdH2EOE5PRzdrcMO9dArRwphS?=
 =?us-ascii?Q?0C0UddtWo77C+hiWmrCO8iXYyosRdt4jmKzQ1Wa3V+JcoIbwztB22SOMtt0P?=
 =?us-ascii?Q?/RI1OpcvfnnV0cfKfDspsbleFC4tYwqVOWIaLusmLszzLxcbvohFOlsWMYtL?=
 =?us-ascii?Q?4aaaFEEHOSmggOM9GVJprnrsqjCXueBV+eT/3TETu9ZIZBAHeX/lvna6jRl8?=
 =?us-ascii?Q?aZiz7Z/1lZL6rPJfvuZFkFZYGbskgcwUquy6b73A1RY+nzpKXAokc3XabhPk?=
 =?us-ascii?Q?RwjhlyX8For7JkXgi3Ciw1D/aWOiLHBIgchJnRx1uXsp0vx8eQgt1NQ+qxcw?=
 =?us-ascii?Q?jRz7XL5QOeF1agUv5Y1QjO5PHJcrPR9amnQ+MI3rrl4wFgaEYL+qg8vECdP6?=
 =?us-ascii?Q?BlanoAUzbv5mVfJ1NvG6ZdIOw6Mw6lZ3gQSegXVh2Orb3wxdSoGyPoZDriUR?=
 =?us-ascii?Q?LzISHpw7Agl4d1aGL4YAGo6IwyuqdivcQ55v1hLgRNvYW28MHXnAojo8yoqo?=
 =?us-ascii?Q?tI/iOsgtEVKLoxfe73UxU52Kn50WXDbZzcmlGlPLUkiArJvrfI3QaOWIfRwn?=
 =?us-ascii?Q?msittgplm38HfsI7JwaPt9I4BmI9oOqRZsml4GoLy9vA+YwyB2uyQ7HRVEJY?=
 =?us-ascii?Q?aj/oEQJ+4065bpG2iA44Di/j4Gok+SHz4dtAr/ZhGzY7T2yQucMDnx2uLusT?=
 =?us-ascii?Q?7xx033SNa9C4PAk9yOIXxQX8NsZ5fiMK4uezZHg20eJcKvz2LqUpxjc23pew?=
 =?us-ascii?Q?zHrIcxiEb/xyWHa6whym57KYyJSrFBDWlq294n6u13h1dDYBOTjrZVEPqqQr?=
 =?us-ascii?Q?PTEhGhCv9HASsKZFxEMRDBznaY9nMijcH6PzlJNBPeHvvsP+uMWoy3pHboKP?=
 =?us-ascii?Q?1WfiI/fDgaS/JLOn6XaIjDSe5zt4qr5EyxX+ZDBBH/M2JmmjXxcsdKU+8Dpr?=
 =?us-ascii?Q?faZWj0PVhRdqoj4L5vaGsuhi5EhwvQNcoo1Su/UZm0TjybDVps4ION/xj23l?=
 =?us-ascii?Q?+djkM5XUldDJzQozfi48TDTomjik+CJ0w54JS8b5LgTEdl5WPV/NO2hcgv9p?=
 =?us-ascii?Q?N88gGpWZjmuKqc4HHlDvZ4WzNzHTEB1Tf5+65xI6VT6t5+OrVjXeJAjnN1qH?=
 =?us-ascii?Q?6EMtdKbu0CbmCmSGF40OG6pfJFLmLYc1X+cog4WM090SICFpuPm/P7VoGXIX?=
 =?us-ascii?Q?ih/DjB0KXXxu+G9LwNUxxd1VSUs4bMv6CD6KM1IBkqgZ74gQ3oC8Tej8JW44?=
 =?us-ascii?Q?Q9LP8xVmH5IhBVtetRk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fa1f78-486b-4c7c-6ec4-08ddd96322cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 05:43:16.5185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyQqzjQZIhUHYho/QWD33pbByMURay1SfY3g8Mk3D179asluqflZJgA+5KMEP0Fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Tuesday, August 12, 2025 11:57 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect vm flags to map bo

It should use vm flags instead of pte flags to specify bo vm attributes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_csa.c
index 02138aa55793..dfb6cfd83760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -88,8 +88,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
        }

        r =3D amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-                            AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-                            AMDGPU_PTE_EXECUTABLE);
+                            AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITE=
ABLE |
+                            AMDGPU_VM_PAGE_EXECUTABLE);

        if (r) {
                DRM_ERROR("failed to do bo_map on static CSA, err=3D%d\n", =
r);
--
2.41.0


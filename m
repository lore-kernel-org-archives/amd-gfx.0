Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2001DC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 01:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AD310E3CB;
	Wed, 14 Aug 2024 01:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLP06Zka";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0083810E3CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 01:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5EMeTj+VXbdXAHIszZxrCXxzQ+AcPiCCQ0tPVesccIMBFcnBzQw8EYQjz7j6XunSE9sgxkyqv9hUJAbrXqcDBllEHqQfrpFdcrwN5wBcT/KCleY3rsd50bOdnAOUrsf6jnJnyMW4WApxZ7dkgcTyaqol0CHxu2pH0/sTAGNQaejQqdIK69mvGRkvhXUnU21UzsWUk0DTAreWb4RJnw4XXOr5owr+qwAmaDu9Pw6yBiQiCW0IIuKnYhjzPLgtnmFSPgQnA120ljf0jQhm45lPKjiYEkXwlYOmQFTHL4lCyjEs4+FYBiUz4NO7Wcp/8PaHXYaNaXvCmpG4+QmAu9Aug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVbKB2dBgHZPc6jNmTV1pSvu0+LKM1PPo+gIm3Pjzu8=;
 b=Uick9PFp4eE4Mj5ovByzP+JAJyZXikQgDACDEumvoixCPu96xjTcLa+rjg+maXy+kAGu8SahjvkUFYFR2tiMelq1dAU0YYvXoJ+nfko6jBeufWhhbDlSjfBr8zhVGGgX5IhAn6LpS8qjaSdeWLk39rjoiSKq1K2T9Erx1+e25JLZt8gfizI2TxVJHiOkHSjR6k2hGaHzl4tPNkCuj3/lG7eg1cT84a0zcOloZbD73XS2h1lodB3T4Drvj8qWZANDlHibiaou8v9Y3Ot8qfgG7PmKbTrHAB8tiWS6m97MxH78c15lFTxMQO9ys020G6qRJWMFCbLaX3xqhH1GKz1l+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVbKB2dBgHZPc6jNmTV1pSvu0+LKM1PPo+gIm3Pjzu8=;
 b=LLP06ZkamheDXvNxbNimzliAo1zwE/C8AMtmY85Py6BLi7q8R46QJsLDuR7vyX4K+/7EcQD7O/bZG/u4/L55mOB/f3KyKeR56WtdiGuXTuvkCmNKhgESY5eLGSmadDW3ur1pxEKB6X7eMm0oXB0w2ia5LhWeTNxfHdwl/I2jZrg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Wed, 14 Aug
 2024 01:38:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 01:38:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: abort KIQ waits when there is a
 pending reset
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: abort KIQ waits when there is a
 pending reset
Thread-Index: AQHa5/4xORVP2ShGPEKwdpHkLHbyt7ImBRAQ
Date: Wed, 14 Aug 2024 01:38:01 +0000
Message-ID: <BN9PR12MB52574F8A8AB0C1E81D0DB0C9FC872@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <df43ccef-651e-46c2-8d33-8867dc75a02e@amd.com>
 <20240806124235.444096-1-victor.skvortsov@amd.com>
In-Reply-To: <20240806124235.444096-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=16b15d74-838c-4cbc-a7ff-87713fee7b10;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T01:37:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6317:EE_
x-ms-office365-filtering-correlation-id: f369b740-b858-4c93-4238-08dcbc01bc24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iyj3L603FS0iV5CKQs+O3y5v3Ff/LiAwEpD10Lr2kt4yBgQeJhwIJsZLjkKr?=
 =?us-ascii?Q?DOc8aS/HQfyQHv/VYUgOxNrfYrwTtl/H7dSX4Scsd0P/clLpLSkA3eXj7xe3?=
 =?us-ascii?Q?TQuH6PsFOaERKVUOIUIomGa3m7DObZGA0XPRxLU2k1uIVQFsDpQ3lKUPyNGD?=
 =?us-ascii?Q?XuZPTpBKpBqq3CUwNm0H6KGY2IJlxV9ota2a0lzbo7wlsO7lzpCfV5khomz3?=
 =?us-ascii?Q?pm2wIuuWPg9ro+EkFi3FztGe4+DlcNlcRZwxjnyhY/UKTgquHdMYkxK4HKzz?=
 =?us-ascii?Q?aPjPePFa0ZArCYQteIQOrNsPWNkxlLfgQ1Rwpx9KHC/elh7C99YpneCg3N93?=
 =?us-ascii?Q?fuiS2lfIe2WAAzCJZv1m+YNlrMpyCMptvxkB8WsP/4xJneD8M4dEyTRCPtQe?=
 =?us-ascii?Q?jfv9ZyyM5KKUvHr+imynRZ4azQGE4uAKLAA+WexCyky5GhafFvtPMxJu53uZ?=
 =?us-ascii?Q?TZo0PhDGXrQ9JY/c+jj5i6/rFp5n9oqrf/qhIpAQybXhlHcCIJbH8mZvfDUf?=
 =?us-ascii?Q?IYippnswyhtMumbIxrjNY0xF2faMBk+OXwW8R+dNDSDFzI2iDgZvWv1Ecnly?=
 =?us-ascii?Q?MLnAhx7TRJDwT4Pv/p/GJ/7yOf+eiovKjW68fjzzurolO1cNfEpQBE+JRMQn?=
 =?us-ascii?Q?KrhlFYRaeHlWXZ50qZ33j6VrpmItAgONvygE8hpQRSg6Gy8QLy17HCNh48GQ?=
 =?us-ascii?Q?yqGhN9459YfQV5kJKFARODgPpLAP+is0kO4+UP7b/QxA0e3Sm/GP11uwU1mv?=
 =?us-ascii?Q?xi2ImZFY6rMOL6DQ+e4gUKQ3ZmP7wTPWqahn1b44EAV1ocwQW77Vx94kbJbz?=
 =?us-ascii?Q?WdGXzct70b+otmvEd6LFucjSA5TmLr77bMmF+trpDPnQpk2regV1ywPfaJ2G?=
 =?us-ascii?Q?aqGqEtDFC4WdGLCFvDG7FsHxrVDP51UttR5bvswVLBqROF+13pexSMfRLESr?=
 =?us-ascii?Q?hNxaP7qIqFYlh5FDNaXtfLrjdxzs7EZPR0xoy4HPeK/Cszg4f0Z/dPaiC2N9?=
 =?us-ascii?Q?3Ify059slZXI/STPSHsQ3QXy5iCKgeIHEdtZllMYLxZcVZlKDVCYNVU9HSsQ?=
 =?us-ascii?Q?mAlR/0xpgLPlodOTiUbkdQHzBHMXIuy9QlAYwcSwlCL94Y1Ac1UgzsgcuLhV?=
 =?us-ascii?Q?5KiYYoLfkoo/2HK8MR8IuH/31NmXx5j49N/jrBlJxdC5NB1cxVvfMtMkDmTX?=
 =?us-ascii?Q?zAH/rTmwXJl0cNwUvoaXAosYvfZnTXKTnNMHfNN+YVMi7d0hP+mDuGeX10sP?=
 =?us-ascii?Q?L7spCGqCu45lJIMVneXW8xWYrAtOOifa4825DAXUGkPlxtDIYEOppSf5BtBq?=
 =?us-ascii?Q?p484OGNJuF8CtE/4uWOJWQifu/T3udN0c8KO7XJAUJwc00ItXfMb9Zh+mZG1?=
 =?us-ascii?Q?jLcqKZB6PDZlx7ipryO3RV3EVPif?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HS0EMmI/Z+xaxelbk/96mYKNxamtby17ULh8wdz1HxpM7+fhCM0r4sAU4diy?=
 =?us-ascii?Q?4uYYQm9m01ZuRJirMoxklPdDP4uJAGOwDwt+iKpqsxOmo5jnicomXlpEigl9?=
 =?us-ascii?Q?aJ+wxgzdDcnRHl1KpATKFETPtN+TYLrwWC4ptJ4Hc3ciKdP1n7iAkaYk05pq?=
 =?us-ascii?Q?RvEhpOgGk5hvgDF5wstPZfxr7e3Sdy4dDtQtZ0tANjsqUTzuXogfIJcAkGvO?=
 =?us-ascii?Q?qNJXsIYHtNvOT6vgWBUn0jjI3eYEakMuDRObLb2M4Tvn19yWXf5kDqoc63u6?=
 =?us-ascii?Q?JvQP5BtuYhtYsGiXIAK0Aw8KJAc/dYlGJz4PwcFg4TvJoLFogZUG9HB32mfy?=
 =?us-ascii?Q?clzf0ECJsX5kY7Fjek75QQMtihrtSMO70amDxc8UCWXawHWaj9ioq+mafk1P?=
 =?us-ascii?Q?ObmUrJIGG+E+b+R6ClNfsUt0V1ljU1Oy4JOGAs4EAu5JVMbcUBdY6pvsopn/?=
 =?us-ascii?Q?/R4iyV2VeLToVfYhoInI6/xJHl4a1L1CKJXBs1BgLYPzQYehNdFYxeqawVAY?=
 =?us-ascii?Q?UMW/+F+yWw2Hxnct0vwiKX5Dg2A+YfSOHVO8dKudgOq4udhKRsBbvRkO7kAb?=
 =?us-ascii?Q?+K3PlVMAl4bMDX2re28/IbUNp/g2mPog1Tutmcz9ZlXR9WvodaVmuz5YIjpq?=
 =?us-ascii?Q?EdSX1+UesGsxpMP6qEfFwKwdkrCfp/wNu93kXE5PR2Q0sVUNCK5eYG5cV457?=
 =?us-ascii?Q?m6SOpga+9SdzqeWvddY2Z9dd5jC+oH8BrCWl2iiq1kRg02FJ6YN1aEIFCYwP?=
 =?us-ascii?Q?XBzGlLEyotnPwr2IE5OR8ZuPtVRths97YSMpe15mtYgNX3eZ4iKYhKLjybMU?=
 =?us-ascii?Q?hokUKfg2CuP0QqzGxC5v+prgKE9sq3G+BelCQkBvBplKIOUpXU9O3LvmQH6v?=
 =?us-ascii?Q?1OZ0y3878I4Sp8NgMI+HAeBD5lGSrPHaf+UOfsN9upRhAlaZw6pwJ55TDTO9?=
 =?us-ascii?Q?V8rmMoEsbY2WM696yeDJ6XQWM6/AebAPoA8kVEkvd0mvQHOskDsxoF3rZ7/i?=
 =?us-ascii?Q?PIz3aly/fkhshRUwlwnpJlm2Ej1KeU6CHsFLk48YG+ZefR+jDERVpHWybB2A?=
 =?us-ascii?Q?ROorte+gEcOQR8b2w6GwpXLFTK7sMJNlVjo7Hmp595ei55iqlYn/VYp5iVty?=
 =?us-ascii?Q?8I9PtvEddCNpZsytdqgflrEdoWc43fmN3ZXSLhZ4X6XRRHFMTJvWGQ8yzRyG?=
 =?us-ascii?Q?LJ2WPPYrWhvWJcWi1YK9TRrXOzfLVEqMR34Ss2CFZ0EjH1pE9wYAGmktF4vz?=
 =?us-ascii?Q?izHYCddIdIPmUVZ071lWUtyWnsEoXFKIRoUs1/LYtmlzKA5p1MBMZNG7N1cc?=
 =?us-ascii?Q?Qzu6xiECIr1/y57OW+esXA5P37zProhk6A3uBIscBqbX4SmQYfAwGDyQmiIl?=
 =?us-ascii?Q?GWNUCT6DRlEihbuXHO1RCeK8SP1L5rY9ihaqrdzNw0wglTmngFyuCrqpu5UE?=
 =?us-ascii?Q?yGjEIc+VKUTUUvT/p62Vo8o1Nwf6r0LkcQ1yJhHxWGbk/LpoANKpGGJTnC+8?=
 =?us-ascii?Q?9l/ouYwR+cOd1qFPUy6SiTYI9nvEY/JCbdN/aUtaB4ZOhRV1uLlOJ5IXSJsB?=
 =?us-ascii?Q?r6JnPCD9DPVVep6GQsKZAbEsZYtO3bFvcQl0kkJi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f369b740-b858-4c93-4238-08dcbc01bc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 01:38:01.6977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icsqhAHi+GpMC8+ELghwQmEGeLiMxOTLAcppHGcwJsStp4DXnIT4MwIuin0H5BjZOIBBrCj0OzjShD9Ry5WB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

Series is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Tuesday, August 6, 2024 20:43
To: Chander, Vignesh <Vignesh.Chander@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Koenig, Christian <Chris=
tian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: abort KIQ waits when there is a pending=
 reset

Stop waiting for the KIQ to return back when there is a reset pending.
It's quite likely that the KIQ will never response.

Signed-off-by: Koenig Christian <Christian.Koenig@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Tested-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index c02659025656..8962be257942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -785,7 +785,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_dev=
ice *adev,
                goto failed_kiq;

        might_sleep();
-       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+       while (r < 1 && cnt++ < MAX_KIQ_REG_TRY&&
+               !amdgpu_reset_pending(adev->reset_domain)) {

                msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
                r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_reset.h
index 4ae581f3fcb5..f33a4e0ffba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -136,6 +136,11 @@ static inline bool amdgpu_reset_domain_schedule(struct=
 amdgpu_reset_domain *doma
        return queue_work(domain->wq, work);
 }

+static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain=
) {
+       lockdep_assert_held(&domain->sem);
+       return rwsem_is_contended(&domain->sem); }
+
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_dom=
ain);

 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_d=
omain);
--
2.34.1


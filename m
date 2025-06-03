Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE38C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 20:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A1F10E10F;
	Tue,  3 Jun 2025 20:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WlVwZkn7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CFD10E10F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 20:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRxeEM6XfvHi3ur2NWJE4HzN2o8RUxcqL8y8ZThGWyJCvaWFJvRT6ECloQ4KObIOjeb2UIGFz0DaXOxXdkWppKCB0HwsFD4rwTsKKcVoeIs0bSOgL+7NzHIgzmQjPw6UXPq0OCFNQb0KvqMeTflmrGUpDRcyVXvW25PUhCT7MSjZFYFmF1rhRRpLf1kaiGVyxrsuciLqJua3tSz6ZY99omk4e0fPdgWCLCl3Rkc4iP1/mNRiO2Gu8Kd6vFcuIUEWydjSI18Fgqn+rrwlb7Z9GNaVbyA45yZuF/MRSNM3iwu4IV4uSG7zowmIwxdCegBf1ejXcLpxRQfBtDbW3z1mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAvAg4DRRl8vSiZ3Gcx6VbeOjjzf92IVv2K78eRUT3A=;
 b=MveJZP4YW+w+ZlgMo6ZbB5GVP/VO4AUXZ1OcKkDNAfb+h3yvphRJhz1+WaSEvr32wB2MA63oPjJnTn2TUk54Pz03zo/yc0hH/5WJnnQhk2IFHEY/mJzKHWWZooauM2rgB6kZ5AadlsnV2j79xN0OWuJZz4wHxTFnV8T3KxASXZP0NlAE4K2YIgw8UMTeJzkB2OKiRmNbrZOrzSlH9Ifb+8h4Srcmgg1MduZLAEiVnT96n6r/zRGA9XL4/HelNdm+NHMoazvRlhKJzZ1z64Yv4d+cCtnY8tx97AUoh9E5AMHTa+S7GD1pDfCGikKgJbr0+8C9Go71Y8sIVItARcZ99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAvAg4DRRl8vSiZ3Gcx6VbeOjjzf92IVv2K78eRUT3A=;
 b=WlVwZkn7AIlPca5Vz7BmMTTwfu2dHSJZIGnY8V22/CAIiAK8xj/6eX6lua0GJVAZ0DWicVf6HlFiZgiPC0yGrRVz6YddeQ3SWXzYw8tiTtysakhO0s9CHdtmU7BKlY2O9PQ6Q+yrV3keBkmffOSoTzhL+GNopDFbQHcHG5Yvlns=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 20:03:00 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 20:03:00 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Allow device error to be logged
Thread-Topic: [PATCH] drm/amdkfd: Allow device error to be logged
Thread-Index: AQHb0XXpD7a2DZLmxU2HZKmZfqtfAbPx4Uvw
Date: Tue, 3 Jun 2025 20:03:00 +0000
Message-ID: <CY8PR12MB70990DAE31956847AEFB30CF8C6DA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250530151654.2503769-1-Sunday.Clement@amd.com>
In-Reply-To: <20250530151654.2503769-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=825964fe-3587-4915-b054-77cb8505e485;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T20:00:27Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS7PR12MB5720:EE_
x-ms-office365-filtering-correlation-id: 9eeaf95a-1f2b-498f-8d86-08dda2d9a41d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aJmBAKQCx+wx/dEZyN+nIHG/Hy6cwkby8dFr/nynPHHtKG+Is948SmW4lxOk?=
 =?us-ascii?Q?6L14o6oJ8TUDn3Q41yr4O3a1zRsge/fz0xFgxAeO1A+AkllM7sJYIdp4DB9i?=
 =?us-ascii?Q?ZwnyfcwNGp7jDZm/qgGnNBn7orBabAwzF1IvIXM/SS5VoMbKQrDzuehjcFTy?=
 =?us-ascii?Q?GHgBjSirG+yAhwvV1t+JqNU/UrUC1pi/3SCXsOw3EEwwlCWm80K6WHi3dfhT?=
 =?us-ascii?Q?r5Y5Xzdb/xwge7c3qNAIrfCTlr7Kc3w8nz3dlwoqr61FuRbEaePwgpIgsgRW?=
 =?us-ascii?Q?z/qJfwZcgQP0DNe+IXjy7DxgkienHphS64CLiroxy0gli8mcxcXbxgKnwxvR?=
 =?us-ascii?Q?zpf2eGfgyhaPP3+mRH1egfACaDg6LSDGdju7sVezWcxjmQTzT764/uNT/EnX?=
 =?us-ascii?Q?cI+HoFxH7qEi5gWO3/dX17AcY62XO9ZKoXyET10jwtVJZnZSHxhJaYb14F5I?=
 =?us-ascii?Q?T+QlypfIb2EeFnDuwgCX6l1yBvn7ZcgYBNAps9bjlVDyy8oUoBdrma4EhE4l?=
 =?us-ascii?Q?G0VkipP2CXGKNlQs9W0TT5l1SQHkIg8m4VGiAF98a0BU+HFvcEWgg/X91Jde?=
 =?us-ascii?Q?vfoa1uK6K6QNi5qL/rdGvyWpzkbEMt2cFTh3mG1jPFsACy05M5e3iDTPZ4u4?=
 =?us-ascii?Q?8EtPgUJCMVD5hLXSb2gw9J9+SePQMRN1a93cIjsb56H/GFcz6wNybHXbxriJ?=
 =?us-ascii?Q?6Ds9v9uzXI8GIHbtWyZz2Ge8GpTetC/vtN1uPU4+8Mdh9N+S4p1rKkKWN6ts?=
 =?us-ascii?Q?TiYDm5ffLDZm1F8tW5g3YZ/Tnp+0g4WF7j892BDG9IHUHWMAPGcyUK5ejSe5?=
 =?us-ascii?Q?Uw8UhPHsNYglKS7QMHXGCUYFr06+dpuQihsTuM4Gi0EudfHYP1FiesE/Yep0?=
 =?us-ascii?Q?6Weu42Rr/XzfbpYb5/4BqZ7ET8vmnV3SOYPSNm+CxAcSEE0ESKnJJyDx8d1c?=
 =?us-ascii?Q?mMuszjwwsKszmyj2bI05IXIpkNvTNYHH0xaHZ0os6AfYIRigTbwb/9SK7UdB?=
 =?us-ascii?Q?fftVZgM2/rtcMNX9s18a6F5UHm49bVNuxFtoHJgopHCaBacUdxuEjzP/3qBr?=
 =?us-ascii?Q?Lq3ju57VqA/l6FuxUdqLR9dnjMTQ+CMTy+K5RLXLSBFjZWHpXl3P1NegwgEn?=
 =?us-ascii?Q?fJ/evjprPNW4HLM0k2ghpvhl+8oPVsw/O1qcGAA/n6zmlCl4pMAlBVjIF5v3?=
 =?us-ascii?Q?jgS8sEye+72YQPss8iZHl9erCkPzeFANtli/YCR8rLjn0TvPzR1po5V7H68j?=
 =?us-ascii?Q?chtf+q7FcrpywQ2Ayk/O9B5OE3X4aZHHgZSvk6aDc8sOeK7qTZauWqBM0y27?=
 =?us-ascii?Q?XX868a/4N6uBslJgmUi6QmIJWYiEaqKN/b1DWEAH1evNHJoX9tBNUJLyuW5e?=
 =?us-ascii?Q?KA3cnCDycgUw2NQZdHt1qh4YElO5WJC1Z4fk6C99be7IMTV8MYxE/Gk3TxYK?=
 =?us-ascii?Q?zbquN2eBkYsmfd/vNy402iTgVyrPnu1Hl79WxE0RcMn3zBoFNxzMuPCp1gT9?=
 =?us-ascii?Q?J5lfLeaYQLQjF9Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GdvWwsycc+GZLb+4Tz4/XLwibPn/xeJTjhRxDIQHQNo0XNEspu4uxtKxKeJZ?=
 =?us-ascii?Q?7wHbbqsRQ6txe4IXTY4XOJC3GjvF0JPkOGGnmvyvYQ0GOjVlSMrMGccDTLTF?=
 =?us-ascii?Q?TKV+L+HIi+s0wfFu/8k4oahjvjyPq2fZ0OdEru7ZB85mhP4G7vZ+WyzJirJ9?=
 =?us-ascii?Q?Cmo/cdraVzpE2X/O03zagyGFaMAPY731NHnwQORqoLy2detc/0fvETHw5VL3?=
 =?us-ascii?Q?lw6Ud59wUvKPAtnPgyHU94Op7O3K1NNeIGa/N0A6QWr9CyyVebRKV6bUCWlX?=
 =?us-ascii?Q?gjYTEVB7l84JMdjOss/kVbzcAkCpPFpEMSyCW5SEcL7pLl3uifTfIrGPge3g?=
 =?us-ascii?Q?MNXavhJN9dzaa07wAcdm9uV7SQZrCQQdMuVqkxmbSTkZXzY2aRt8rPZ6WD1q?=
 =?us-ascii?Q?UN5/k6NcoT2plPaQPw+BR62Wb448io0KNwcvrrFSutvRs8i7shzSrXugnWJh?=
 =?us-ascii?Q?lP9zht9Vf9Rz05uQLOf1o0JEY+quNzPy/+xZB1qfv77tPkPcNdN6ndRf7vyY?=
 =?us-ascii?Q?kZb0ku11avweGeI+w73BRXPZS2FRx3YZrKvlMbs5+gAR3R1Kdj/n619jgcLv?=
 =?us-ascii?Q?48BNQ3Wa+qOQNWJpWlju3tp3Sn99HEFAJMkzHhpYYsMrFrIVAXK1qz1i00rj?=
 =?us-ascii?Q?1t55QqiXO+Fah+3KSBaI1TPEEApz9i3jPQkT7uGJvGL9RvEH48uRLix1FWqK?=
 =?us-ascii?Q?8a+YbbVvzKx0dT+XQjqM9Bsc73ZH8XUTXw5ElSwxOjvfM5DENQvEtnMT3nrv?=
 =?us-ascii?Q?ugsAiLhrGCRvKqNZmaluBV0jYJ68Tufehxl4AfywerFdAWH+9Qa4hXkUoUzR?=
 =?us-ascii?Q?mDUK3JUArUaiNvBp59C4DoR8N/+PejddPlbYiXNzWkMdUdyMrQxjr0TIG0Tn?=
 =?us-ascii?Q?pxOZuCZXWZZmZHJY8fgdgD92ncVN+f/moc7jZ7kZds8VYGla4LvkyS9iJOZf?=
 =?us-ascii?Q?ICKglsChe8sxobhAdxkOJCavtNSdsAb9YraYIiGxSonF8j1lDLAavQP2G+hD?=
 =?us-ascii?Q?Y5M9VYzLuKkBR2oPNrJQh+71AyC22zp7YUnv/QBLfFF6fPnOq2IZKsOiJ1dj?=
 =?us-ascii?Q?W2iFCkrC6RAJ5gW8a/wvkckXifw3yul9KU39kWw4bIkmG4rt57sYn4nY8KkO?=
 =?us-ascii?Q?6FCJaFyswiAPGWQdU1ZhZoEZ2QEuxctAvmWc9nGaCQRuFdGFlL1gdxxasfTH?=
 =?us-ascii?Q?4QN50HeagDNhccqzmmsQRFd0RP/D9HtlWcE6X3rG7w0n+klfGir/JBpDPxDS?=
 =?us-ascii?Q?UD9+4iu21ONci3FIDuMLOJUZGfEg4ipLZg/aU8GXYnuqRydKu481E+5bhGvY?=
 =?us-ascii?Q?y6ta6wN+WhyiuAuvxFV850RRqPBqzYLlDJjRveLPwPicZ7NFo4LWyfCVuEqK?=
 =?us-ascii?Q?VBJIxpWP6K8nuguDtnX0kwj7dGi0R/NkVj19T7aQAPs1JCVO+jNcsR2BqknD?=
 =?us-ascii?Q?zumu/wCMV8EK5oQd/zuDNNCC/wiJthUTL5PLW4HhnpZdU/dpn9fqFHCLMR1S?=
 =?us-ascii?Q?mkHsS3M+INP6Lw5O6N6FYKyrsmExGznp8E9yZyp+7PdbqVqv1Wos5g1L0haM?=
 =?us-ascii?Q?VMvSdmvtttKuQcLXyhs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeaf95a-1f2b-498f-8d86-08dda2d9a41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 20:03:00.1400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtiIv9VrHjRhD4gA0idqatlfBaCUOCnZxRQeWPA1Kx5zr1CGm5mFdQ/N3/qAXyO4AVrH/Ki13YaCteJMbtOuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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

[Public]

-----Original Message-----
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Friday, May 30, 2025 11:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tudor, Alexandru <Alexandru.Tudor@amd.com>; Kasiviswanathan, Harish <Ha=
rish.Kasiviswanathan@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Allow device error to be logged

The addition of a WARN_ON() check in order to return early in the
kq_initialize function retroactively causes the default case in the
following switch statement to never be executed, preventing dev_err
from logging device errors in the kernel. Both logs are now checked
in the default case.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..fb3129883a4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,11 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struc=
t kfd_node *dev,
        int retval;
        union PM4_MES_TYPE_3_HEADER nop;

-       if (WARN_ON(type !=3D KFD_QUEUE_TYPE_DIQ && type !=3D KFD_QUEUE_TYP=
E_HIQ))
-               return false;
[HKI] If you want the dev_err to be printed it might be better to move the =
following statement inside the if condition

dev_err(dev->adev->dev, "Invalid queue type %d\n", type);

-
-       pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ=
,
-                       queue_size);
+       pr_debug("Initializing queue type %d size %d\n", type, queue_size);

        memset(&prop, 0, sizeof(prop));
        memset(&nop, 0, sizeof(nop));
@@ -69,6 +65,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct=
 kfd_node *dev,
                kq->mqd_mgr =3D dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
                break;
        default:
+               WARN(1, "Invalid queue type %d\n", type);
                dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
                return false;
        }
--
2.43.0


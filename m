Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32894C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 03:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE992611C3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 03:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE992611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FC36E0A8;
	Tue, 28 Sep 2021 03:22:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F2089E01
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 03:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC+QpbcveRIg157bn0GYtNl1oaSFCSphibPY3Wj7jw08o7nzo0dxmguVzJD2z1gfv+ZMhmUBMWzvMibnTQfX4+pBUCNR1+HIvVrBLgdnBLft7VUTCHQjeC4rUCViHMVp2H6+jlrK/UTKfUXIR+cR4DLxWnPdN0K8y98qW3A48Rux1sC0g90uemJvtHU1TlgjrBkz3/3szqUUiQ1xxHog6Rd7cn2KewsblkxQgjknLe4I5xzLKCybjAbmwg34awvXT9+vPHg2SskDmZRhs8un9YpmVv82w9sMRm49fQQwNxdQWqZGKAKumqSoRIDk77s/yER5B4ws+AE3Hv85FifgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lmMQsJ4orjKP0I0tqIU9GZB0i7kVN2JTgzGnR5QhIJ0=;
 b=A5r7T4LQZtK7okWdq/U1sGml710gYFbyU6Z4BAYj9ETjUfwwhYm92R6svALnlJ49NpuOPpC+i2R0NFAUC9PiHSfov3cXjHd3RlFZLWW5Hb/V6yJYW6+U5IrtmX+fZhkcCiJihXKdP2Jdhi+MITjAlg4fRVAHpOQEkXOufHRzfwfwBIZptfyOEBDTxkVB3qmeuVlWQ8qiWfmGZbQpfy1N8mVzWRX+d5VHrR43bhgBdakVI1a9NSpjvHrnOKM8w2ISjpXpU53l53RGFuCKXLQLus1LZd7T2FYHX8QH4mPc2iKY3KEenxA9A+ql/LuJrzdFqDi7fq4MVh64VqsH66X3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmMQsJ4orjKP0I0tqIU9GZB0i7kVN2JTgzGnR5QhIJ0=;
 b=eZ8cuN2dYACSiorjQngNdv5BzfiqFJz3huuHldYYbcbOZBQWlduAuwdUpQCawcXQQ5vkGFqQq/GlUZ2fQgtGP+xYEHbz/jkSdZHkbb5fFCNhr49chVNck+72c/j3P5ImGL1Y/orKaLAZ1gbnQfd6AEwFpgFHeR5CqIUwiql642I=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1739.namprd12.prod.outlook.com (2603:10b6:3:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 03:22:31 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 03:22:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 (v2)
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
 (v2)
Thread-Index: AQHXsR9wO0IDtEbeXU2zyEmS8uUGrau4zdZg
Date: Tue, 28 Sep 2021 03:22:31 +0000
Message-ID: <DM6PR12MB46508BE1B45F240BA21B2381B0A89@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210924083725.17318-1-tao.zhou1@amd.com>
In-Reply-To: <20210924083725.17318-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-28T03:22:31.120Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 95bc53ff-0aeb-644b-c1b3-d012cb379f3c
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da3b9f5d-4f64-4feb-28be-08d9822f3551
x-ms-traffictypediagnostic: DM5PR12MB1739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1739EE89B238F94658AF1D41B0A89@DM5PR12MB1739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DDKdCcPXzk/85b7N3bJzgRYG906+YSoZaWQ8kwbnTieCwee1J104UuqT8hWZWQNb1YaIuax+FwQsBK6y5lx1/3OHkVkvrwIO9jWwF2FwW2NVvBW5esI5hcx2a3baz5PGoLvP7Q4KtPQSwA3ULrKeZBLZpvminIcwSTSgZV5vK9GW0AcObHN5Uq2tn+ctgybnpMYHFp0BkmKx+zfPxjUR6ey8PpydHQ7BSUf8Iv3jSCXVmzBCNUpOIcRkO0Gk1LwEJZQSmoL/l8wB6iBVzCGqBQHYy1FlUaAEgqfySl1tgxbv3XEWU9EMndfyta6PXDVgDaMEDDETvfWMWzWAL/WWvx7uDRYU0IeITYPo/YXA6OudcuSI+2Th7rg6Z8xNwSw603eH36rntvbQjjPd0rBLkK5ALEwRflJNIm+3ih1xXj61MwYU60AWt9P4bVVnBdaQ+ifsl5soFk7Lo0KRsidjXQaHMPePP25+1Uc+Z7tcTzLUOpivmQ8+3iO/3/4u/qGv+TJc2GYkvfMt5vi/db4LXRAfPJOD79SbGZg87lUhGYM5c2WvzTgrqcJJ3f+I244//qvUYHzEXxiUEj7U+fvGdyaCGefHosta9GGVz8yECz+c16FKTqQIBu7V5YLQrVBf4wg2dQKWduvwlNfcr7zMMMIJ/LeLIg5HYos4htHPun1c2AQSV2vmR5h2C/9w3Q6NWNgJfRypavTcPGkyeoBWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(71200400001)(122000001)(508600001)(52536014)(5660300002)(7696005)(83380400001)(8936002)(26005)(19627405001)(8676002)(53546011)(6506007)(66946007)(76116006)(186003)(86362001)(91956017)(66476007)(66556008)(64756008)(66446008)(316002)(2906002)(6636002)(33656002)(55016002)(9686003)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?280K2ywAO5cZVDSYB2onEFfU6GZThnf/6v0aqw4UN8gREn4038KFJqqFWNXI?=
 =?us-ascii?Q?B8+ClRt3vveVHj+B7B4SaTnV0wuKz7aBffxSlJBNU3FL2SzivTI/KKWwMXQQ?=
 =?us-ascii?Q?PtbazQQf/u0Gi7rryhATdRPMCBsblv/DzgzLFeoeyyku+vKQzG5fH4589l71?=
 =?us-ascii?Q?iXRn+rk40i43xpgWg4Y9qvV4nASx9PisB93oCoTSo9zX7xJ/UTpvzBvgixpn?=
 =?us-ascii?Q?AhqAjDKognStoOKNcFZB4AP6MZwq3fUnovRAi6p5aL7pBB7Mtm9Uo4+N2tSJ?=
 =?us-ascii?Q?ip4STWnPwfr3n3dAV1x9jUgvO6mHt1ZdKBr0g7mH31/5Zg7WN0W94PmUk6jY?=
 =?us-ascii?Q?fQbK00Im5dplbdhkvSe7ZV1I/3myZxbVX9N0RrmEUCxzeLyjI6eDt7BW5LQV?=
 =?us-ascii?Q?Afh4GobsjqFgz4xjeSEjaWPawe+rp/1Rwlj7RDpWWI1kKfQUHun/3uNUSxcl?=
 =?us-ascii?Q?pZqBsHSgN0+8R9HbYdhqTHLK/AR9W9RhnWRGipYiaIguIMKs1XPnZT9z9u41?=
 =?us-ascii?Q?+LmyTGs4tl2GPnL+QoYwbk6C40p23jsS7NmPUi5Xf7dP6ksINTJcH1ztND4f?=
 =?us-ascii?Q?rR9+5NFdW0u7DIf8ONPOBHukD4yEsqgWlg/BfXYVsCV56X7meAfzLeD7vHRW?=
 =?us-ascii?Q?qHt2Zmw3CW4qIZOnusbTCuqxi5XlH69QP52agAwP03zsWg3oYVTeCwhF+D6y?=
 =?us-ascii?Q?MScZTmcaEu3kLdcOUKuSIjtsdVFP+sfJfUjpfdf3SZbmKIPBdxw0g4uFNwJe?=
 =?us-ascii?Q?1UhwmRzyUTNz/PmrKt7Kjb5OOcXOBRZHvRpEba5sfGQXUrPReYV8gBJAWZ2E?=
 =?us-ascii?Q?ulWV88L5G+IO+0YkM794hT7uiUVyrndn+SRhw9blFsI3oTnx9Tx9/r+sMFM9?=
 =?us-ascii?Q?vHqt5D+VZBw2TLZ3vTYUbKgKzgBf8PKoQe2H5zAtwgmX5RH4O5r49fVDx71S?=
 =?us-ascii?Q?HNPbgZKAxzuG3Mi8vu9AclI9AgtQA6ufPuyq0IfLL4DOEsCOX/3ZncsyVv8z?=
 =?us-ascii?Q?3agvBuECLWE0uzMjingamPZyyDtvpU86nYi0RUyzczP5ek35wm6FvOzYiMHV?=
 =?us-ascii?Q?yRmkgpml78dwPmUhP+7rYqrpzp2s9ae9QQgsn2XQMt+KrOUmGEvf9v8fr5vk?=
 =?us-ascii?Q?A63evwYjimRPtiWQJqPgB/GCj7X/dNPNLWBGPeQ8oODd32zgv5twOLLZqE61?=
 =?us-ascii?Q?emJ7IMEPTju4DMaXrEvu1KCNSMyxqeJrqkIENtMs42SRiae3FgDH4JOXWHtH?=
 =?us-ascii?Q?ks2KUUki4R3Fykh4JwZYm/6xUURfYOdWs5/WTR0jcrbnM87Vvow8ngXranT8?=
 =?us-ascii?Q?toXlA9uMagunYNsrEa1kD2R3?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB46508BE1B45F240BA21B2381B0A89DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3b9f5d-4f64-4feb-28be-08d9822f3551
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 03:22:31.7312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SQ5psy7A/M42JZw86lf7gmCjMhQBa56/qj1oOK0aobjBFu3+/gBiP1CiivP8CEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
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

--_000_DM6PR12MB46508BE1B45F240BA21B2381B0A89DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Ping...
________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, September 24, 2021 4:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; J=
oshi, Mukul <Mukul.Joshi@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma (=
v2)

In ras poison mode, page retirement will be handled by the irq handler of t=
he
module which consumes corrupted data.

v2: rename ras_process_cb to ras_poison_consumption_handler.
    move the handler's implementation from ASIC specific file to common
file.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..7bc4248a8d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -31,6 +31,8 @@
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"

 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -780,3 +782,15 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev=
 *kgd)

         return adev->have_atomics_support;
 }
+
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+
+       /* CPU MCA will handle it if connected_to_cpu is 1 */
+       if (!adev->gmc.xgmi.connected_to_cpu)
+               return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL=
);
+       else
+               return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..d118e1dc273d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -290,6 +290,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *k=
gd,
                                       uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
                                 struct tile_config *config);
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..543e7ea75593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                                 if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TY=
PE_ILLEGAL_INST &&
                                         sq_intr_err !=3D SQ_INTERRUPT_ERRO=
R_TYPE_MEMVIOL) {
                                         kfd_signal_poison_consumed_event(d=
ev, pasid);
-                                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                                       amdgpu_amdkfd_ras_poison_consumptio=
n_handler(dev->kgd);
                                         return;
                                 }
                                 break;
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                         kfd_signal_event_interrupt(pasid, context_id0 & 0x=
fffffff, 28);
                 } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
                         kfd_signal_poison_consumed_event(dev, pasid);
-                       amdgpu_amdkfd_gpu_reset(dev->kgd);
+                       amdgpu_amdkfd_ras_poison_consumption_handler(dev->k=
gd);
                         return;
                 }
         } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC ||
--
2.17.1


--_000_DM6PR12MB46508BE1B45F240BA21B2381B0A89DM6PR12MB4650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Ping...<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Friday, September 24, 2021 4:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Kuehling, Felix &lt;Feli=
x.Kuehling@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; Yang, Sta=
nley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amd/amdkfd: add ras page retirement handling for sq=
/sdma (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In ras poison mode, page retirement will be handle=
d by the irq handler of the<br>
module which consumes corrupted data.<br>
<br>
v2: rename ras_process_cb to ras_poison_consumption_handler.<br>
&nbsp;&nbsp;&nbsp; move the handler's implementation from ASIC specific fil=
e to common<br>
file.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 14 ++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |&nbsp; 4 ++--<br>
&nbsp;3 files changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 1d41c2c00623..7bc4248a8d49 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -31,6 +31,8 @@<br>
&nbsp;#include &lt;linux/dma-buf.h&gt;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
&nbsp;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
+#include &quot;amdgpu_ras.h&quot;<br>
+#include &quot;amdgpu_umc.h&quot;<br>
&nbsp;<br>
&nbsp;/* Total memory size in system memory and all GPU VRAM. Used to<br>
&nbsp; * estimate worst case amount of memory to reserve for page tables<br=
>
@@ -780,3 +782,15 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev=
 *kgd)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;have_atomi=
cs_support;<br>
&nbsp;}<br>
+<br>
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_data =3D {0, =
0, 0, NULL};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU MCA will handle it if connecte=
d_to_cpu is 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_c=
pu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_umc_process_ras_data_cb(adev, &amp;err_data, NULL)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index 3bc52b2c604f..d118e1dc273d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -290,6 +290,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *k=
gd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t *mmap_offset);<br>
&nbsp;int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config);<br>
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);<br>
&nbsp;#if IS_ENABLED(CONFIG_HSA_AMD)<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void);<br>
&nbsp;void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c<br>
index 12d91e53556c..543e7ea75593 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sq_intr_err !=3D SQ_INTERRUP=
T_ERROR_TYPE_ILLEGAL_INST &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfd_signal_poison_consumed_event(dev, pasid);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_amdkfd_gpu_reset(dev-&gt;kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_amdkfd_ras_poison_consumption_handler(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_s=
ignal_event_interrupt(pasid, context_id0 &amp; 0xfffffff, 28);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_s=
ignal_poison_consumed_event(dev, pasid);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gp=
u_reset(dev-&gt;kgd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_ra=
s_poison_consumption_handler(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (client_id =3D=
=3D SOC15_IH_CLIENTID_VMC ||<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46508BE1B45F240BA21B2381B0A89DM6PR12MB4650namp_--

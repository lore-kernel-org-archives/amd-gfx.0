Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D781CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 13:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AFB10EE7C;
	Wed, 13 May 2026 13:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gsAbN59/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8156510EE7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1lhNn25pcMa/HrcstS92rlueSqUP0WrDmFrsO/mHFMSUnSM7CJSQSJWhYzqbjoIcZ+WbkSVvmzHJmG+rjA5275FognnRepdEE0sXY+I1dOOBHwPZvO/tmuq3bJdm0rNjiM7GKo3a6PQtk9dhYvWHCRG7whru+6/jzxvsQ7YVsLJ2IPastPZvLuSgjVz8yubeLC4KeYSALcjw48Ncy6o9+22acXxreJ7bqRWVyRpa02u7aAsQbgjuth0IK4fZL7hD7ju9+2BfyT8tskb7r3i+sILAyTOcIMGFHqCEYeekTGr7C0hQYylEqqHxehCjTIm5V9m6XdicO2jwgX+i6wVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5jDYixB9ZNydTCzijBg3gSmRYF3cB1uckAYWwBfOVk=;
 b=v4EmZ8+XNLv3EO3JOgBBVOXSXO527tlqQeDUQsYPjY8NNzgdiNNWASjBh0YHsmGcZdVDEvaj+p5/TuXbdJKDYmd5CbkalAlbthFM9zainnyRyFCwrmRXSj83VuWbjucNuzov+Rwn3TLgip6d3bl/+yt2xS5t4hdLXOZz6ss0WAJSve2nELy9MogqqoHtJMNXv/9YESbI1PcNZOSyvWGFwU2c/AEN2r/CTf+vAkIkFa6mlwL/Ece/28Bt24G+FSWuJVeK7Ca8NL67hQKsyspWWs2G65R1dTHmZpckkofEYBkG+tdnDO9MyYiSOa0e+5j8QjBlsjHgaRK8OwX/yvXFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5jDYixB9ZNydTCzijBg3gSmRYF3cB1uckAYWwBfOVk=;
 b=gsAbN59/3mkz4yxr4tcbrufDyBoTc5k/EUBcMt9boQ2m19OdIDVLf/QUylb+MBJpHGWjUp0V1kJg33ly0xTZv0gYENT1hbRt+wa31eMXZg9e4cKa2mNdro+h9c7fJ+X4CvxqbkEqbsWARVwTEjzYZrEbHZKhlLMtEV+6WKEcOd8=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:18:52 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:18:52 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue
 restore_sdma_id
Thread-Topic: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue
 restore_sdma_id
Thread-Index: AQHc4kWQmadmnk2kc0eEHXVV6nrP7rYK5yUAgAEKHsI=
Date: Wed, 13 May 2026 13:18:52 +0000
Message-ID: <SA1PR12MB8144B39217CF44A4EED3858FEF062@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260512192824.3682569-1-David.Francis@amd.com>
 <20260512192824.3682569-2-David.Francis@amd.com>
 <SJ2PR12MB8650498A9E36854C050567428C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8650498A9E36854C050567428C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-13T13:18:51.685Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SJ0PR12MB7459:EE_
x-ms-office365-filtering-correlation-id: b7d19c12-9fe4-4283-6441-08deb0f22d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info: GXbh27g43z9l/1+rqXOKwrVQCW1iJ3LO+p2lt0F9zg0O+HxkHYiQdKwTbFVk8kT3wzm/X/ywTV9gMoF9uhHhT2RObS3A3hj1CE0t6DHvmOc2fPeN/GEK1XABWdIyNUWXcvtX+NY2TRzoBOhqdoIVlDhcLFpcl4E4VRZ2EaltBA8LOisc+1+8LjYPWBA+sbGWPkdSOgPvBf/U6sNNvTrLBdc4NaJZpchiUBY3mk65hI4GQb1iLbJKwPyyBruOCFXXmUZRPOryvh6YxdELFDYccRZGzyDB6igBm1G0fP8Sw2y+xyDSfVx48u58QICB7+oR/849UXju6GfazOvrjZnxkHXRYdQf8bDjdAVdgyzw8jrG0Fa4wMjN1ncM7vWxGRIqLDV7VSipO7G74dAY5CZJftR/2mT3GP/y86DnToNCJW0FpWYfVg7TLCIKouZM5XAomK/MCxyZS8Rym/qkPOMxH0C/xgWwHUTIghF1CCHs4+9u6WDu7tbnc2gYqwGMjkdPot7vQv2u1txycKMtpEI41FdNRQwJMVTBABKe1nn62i8RCPsc6I/Ws/npi+2eBPSfe/33ulhPemfpBT1rkcCKR7sd/8hz+yAiQHIUB7klwbMgKDKUNRj4OPDGm/U2R8fKpzDUvKR7VZ/4PakrSb/HxZsJvg7bpPgQB4AFM5292YiVZFYu27+KYLcNj+/TDpWD6fW76xNGiVwHtAipMTkrk/4dSnp0jEumQcAAx/CPrDqZjWtIpEBQ7GRNfaEzLSmK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NRBtDUwBGr+J2WZ19I25ouIAEEfsDUeP2c0wX++v4ReUhJVXrzU7/XpreBFj?=
 =?us-ascii?Q?4ZeuYzPj5E0TiVviHCbgpNFF/QOWnLUtlkAfD7iWvs0EK0+iD5OuwF11Q6II?=
 =?us-ascii?Q?q0LAldmdH2amnSi0nKeprV7TV/pc6aFXipJRoDIdGFMpqZi6RdiBu2ZJVVx4?=
 =?us-ascii?Q?9Wy28rhA5AkJHOQHxrxwbTEMN6/zeYH22soPVnDFvgGfvq/I3wnnl83pfJxE?=
 =?us-ascii?Q?IySxuUGdPWpFVcFvYgdm6qlbYYn+zU0tgLF58V781I4YElMN/coHY7W853C2?=
 =?us-ascii?Q?tx7Q1+llHoJ78T/gAGmiOnsCGuG9Bhgh1y0G44b+7ggXvzHUYx450TWJQVDv?=
 =?us-ascii?Q?uMTFqoUgPCuJgErws9Nrz24TZovXCJhaQ8CxADxX2VgaOIuviZkFkNa86vAb?=
 =?us-ascii?Q?mnUGLcL5Gqyr43uI4Dyg5Gsdn/jVeOHPhW2yK/9F23XuTubAuxUSS+WSZkua?=
 =?us-ascii?Q?vpCV/EQzMVYLX5LcAdM1xYJ9/Z+lis6JfoICsCjv7trq1TFdMQu042CFRblM?=
 =?us-ascii?Q?V/QDP95yKD+atWcY3Q/oXDn9mpEN3mLTca4J4/jCGqPQcKg6GK8mskcwMg8G?=
 =?us-ascii?Q?ZbEtw32gnCZQ+GDX66+ebK0lFHcmYOG5QKrHq1ouaBrCQcTf8IL3dheD0gq2?=
 =?us-ascii?Q?BfaI8+qKf+cfLWrW1wxP0DL8nsMGGC1Dl3AEzuSs/l9OdG2pSYbIcql4FcRO?=
 =?us-ascii?Q?KpfPSY2KA2XyMyBVu2uJm5qnMXgkkjyVSHEuAsmokVa7k4jIvKP1Ttzq0o7f?=
 =?us-ascii?Q?SNZ8corO1uQhCYwTi0vZoFCsIEZB/fsMxSEwols+iPbBthIkluksoqcY+0ui?=
 =?us-ascii?Q?V9UC2ggrfdPATRVaD2k4qGCgFoMgwx3dRmYAKnGt2SDbf3slM3ml3vd5Es29?=
 =?us-ascii?Q?N3sVu2MYE2W8uY4l+7wow5EKBtS3PDewkVt0riim7ORuuDlZKyHGg685X8Ob?=
 =?us-ascii?Q?3/Qr1Bp0SZs3fDasWSn3ycQ/DceRk7WjUrJ+E+W+25mi1gq8L6Vm7wHDqBSP?=
 =?us-ascii?Q?5qPl+3DL67H+PLHIa3I3GG3ExY7xbB2H3IkpmD9JKQGVvqqaNZKvbeISG5eF?=
 =?us-ascii?Q?hx96exfQRRaZwmmxoxJz4FJQRV9H8w24FfhoZqoRNRQjWus1ZHOqx35Ca543?=
 =?us-ascii?Q?v3tw0fY/Cps3vk/Ul80FqLjkLt7Y8yUa6RPy5nDgiH8/hHMRyrABdKhZW0aL?=
 =?us-ascii?Q?sXpoL6iTGnwR6K/20Fml0SIBEbULJRFLwrj3bK3w7AYgBSx+Bx+44gN7nCE1?=
 =?us-ascii?Q?08NXycAT3Fyb5t//KoFn+UCNtkfaSd9wIRb1aDZZ1LXuSPY+s15DInBtqQOU?=
 =?us-ascii?Q?zDdiWCfDMAk9LJ/Tfe2hFUGzxsvjguBxec2tgknqy1pMAsAJnJHXIzvT3ofZ?=
 =?us-ascii?Q?BJWZJ7DER1eJ0DcCN2shz7N7lNbBFQwCRT0fMdPkn18dshg/EVpXdrbGqRIj?=
 =?us-ascii?Q?phAUBmnGki9MFoK7d6xXcoMxndu2KZKs45T4hrJn6d1XaYLZKIfsu1Onb567?=
 =?us-ascii?Q?wdlivRlFarD98e0ObQ13hbqjXKl320ygo19nv91+QwJCiyTXrfLzs/XV41bs?=
 =?us-ascii?Q?eyKzhxojQMdXrncyEu3zlN4GnzFWLGos7uokOPOdg6ay/g/vpTjmc4fzdJgM?=
 =?us-ascii?Q?HEpAj7c7bY67ZVLpPwwAlzQOhJEPjz7kDM3kbYotYLxeH78wSlKdMLLVbtBz?=
 =?us-ascii?Q?aXHaI5H0Vwm4ndJ9z7gmGDDtAyo1APNkelYzFE32fDYxOxvX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d19c12-9fe4-4283-6441-08deb0f22d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 13:18:52.1288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ1oQInMC51sq0SE4BPyvSj9cnw8s0Vd/i82YdxCXA2tDd5wmrnMlPmXjVA5zJSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

> +                       if (restore_sdma_id >=3D get_num_sdma_queues(dqm)=
)

Just realized that an amend didn't go through; this should be *restore_sdma=
_id because
restore_sdma_id is a pointer. (and similarly for the other changed line)

David Francis

________________________________________
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Tuesday, May 12, 2026 5:25 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue r=
estore_sdma_id

AMD General

This series Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of David Fr=
ancis <David.Francis@amd.com>
Sent: Tuesday, May 12, 2026 3:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Francis, David <David.Francis@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue resto=
re_sdma_id

allocate_sdma_queue has an option where the sdma queue id can be
specified (used by CRIU). We weren't bounds-checking that
value.

Confirm it's less than the maximum number of queues.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b4cc74138f1e..ddbc4bd8ab10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1727,6 +1727,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                 }

                 if (restore_sdma_id) {
+                       if (restore_sdma_id >=3D get_num_sdma_queues(dqm))
+                               return -EINVAL;
+
                         /* Re-use existing sdma_id */
                         if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap))=
 {
                                 dev_err(dev, "SDMA queue already in use\n"=
);
@@ -1753,6 +1756,9 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                         return -ENOMEM;
                 }
                 if (restore_sdma_id) {
+                       if (restore_sdma_id >=3D get_num_xgmi_sdma_queues(d=
qm))
+                               return -EINVAL;
+
                         /* Re-use existing sdma_id */
                         if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bit=
map)) {
                                 dev_err(dev, "SDMA queue already in use\n"=
);
--
2.34.1


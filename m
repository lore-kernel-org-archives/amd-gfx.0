Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617B2C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 16:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E964611231D;
	Tue,  7 May 2024 16:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zd2h9YVI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4D61124F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 16:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOew55nFNJ2+jv7f50lRipkKfZZKvRUiPunPqyX7a4k7Qm+Ig1YJLZktZCVGfohpVLeKQvlG4XwIjU5OD/itGJaD9UveEjsMIvBtvJi6FEFqbOc4uJXuNdgP/Rk513IIQI23yHa6aIpAcuZ18fGuMfawTu73RIey2eAsjohtzDQuBECHvGEzT1hFGAur8umhDnsuQ6rb8Pl0aemEGlTgVxAoYQJRLXYtNHX911mtUyPbGr3+dqOfEzjf8yiAhwoS6ThRlDlCpl1otCogR+r0NHnsexs/1Pakb3V99wPrySuqbVb4Xh+cKENdowARkD6CU8liplZBKvF17G5uWzLPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjXhyldCY6RS8dbBbEcNChL7wB6SSLzxkHV+4NEosbU=;
 b=lA+qdoUFtMhHNJPWcFM/MII0vX/Nf54jTh3fkHBsbaO0uE42VfAEi739KSvs0VmckNZcDaLWTXtTRMJXuQi8hynoSz7ls5WhhXMow9IVYslai9tawUqtPVXWvXnAFg5yuOCc+eXOknReeZB1bk1hu56nribfFObwDatGp0gdJYsiKC5krdx8bZD56dGVmxWlHV3uaybd2B8eUw7wdGY1lHWcwOeBJwA4Qk4+YmkMD5u1mACSCYdJkXz8QmYUDZnLlV0rVM99DIouoV6ktaB3LGE6VYo+NLISt3LUg+c5My+OgZ+sRN/FgA7fKogG51i6Tc0DoE3qKhx23chfdhQ/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjXhyldCY6RS8dbBbEcNChL7wB6SSLzxkHV+4NEosbU=;
 b=zd2h9YVI9VaZzacSqU6M9XkcG8a0MjjFVU9ZY2d9KIqnJptfMF5bviLqTwMA6/KWC3Z1H783IxRsW3IrFay65aUn61Oro0/qJcOjb66o3l3UAdqs55FIUQahoT0sCeYi5pQVewdNWyzqpnsLnKnXdPpSJdWO3A3vG1IZdRZhCUE=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 16:06:06 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:06:06 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix mqd corruption for gfx12
Thread-Topic: [PATCH] drm/amdgpu: fix mqd corruption for gfx12
Thread-Index: AQHaoJh3qnaa6SoyKkmq/Ps2wWKasQ==
Date: Tue, 7 May 2024 16:06:06 +0000
Message-ID: <SA1PR12MB565939BF5969E2CC88C3E70CE9E42@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240506080821.40070-1-Frank.Min@amd.com>
In-Reply-To: <20240506080821.40070-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=222c89e0-e072-471a-8376-22105dbdedc4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-07T16:00:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|PH7PR12MB8015:EE_
x-ms-office365-filtering-correlation-id: 3dc549ca-8082-44a3-a3ac-08dc6eaf9a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q4IU+Bbag/v8YTXXo9X7DbqSzwCyQwRNyA70wVmY7CPQYkL1DcfL4LC5lu8U?=
 =?us-ascii?Q?YCTvIE9K4P1PngZ7IJEQ2IRohNNnI7OnTt1VB+5XSaJY8CYSisEKeNaerNCL?=
 =?us-ascii?Q?iCPoEx34Onz3zLyYWwVuEBNnhgVeTsnAhhGrG8wco36NrVyywv1GgMUZZew0?=
 =?us-ascii?Q?7s9CyF1bKMy8kxrOpnnRnWKH8B8EtWE6k/qSsYmxDRSW5ss6wbs620rlCxeA?=
 =?us-ascii?Q?VzTiXUy6DRaMzTWk04Ly0SPACkSEunwenADPVow6O7APTG+lefM+i83IzGaM?=
 =?us-ascii?Q?FNuNWJ0FLV+5WjDUGKkUlvr5YHmFNbAXtCD685YRpBpH8f9RitD7mOYHU8+d?=
 =?us-ascii?Q?152D5TcGtfu+sES4EZ2QX1Kc9S6gqcMbnRmr/uWF1xkX+8XIHUo9kqTu5lCR?=
 =?us-ascii?Q?4LEnNSBUdgaUPOFsdplHKIfJRGBpkfOnKOsWJlxbrDZgOsbWbfAH5NIZYV6B?=
 =?us-ascii?Q?KaB3+bQBmR6zadaB34aLqGaYK8ilP1PXPZkHFfKgnDr88xX6EyeZdEUhh1Vs?=
 =?us-ascii?Q?ocfTmxDARG8EGA80zFNA7tK2Of2fKKETtea/i8doviltUL7bHJH+Iuyj5ckY?=
 =?us-ascii?Q?C1wGNv7x1dCmReKGGqio7PojxMSbK/Bw77lNkNaoUzaLaDUL+wtyStQEaVoV?=
 =?us-ascii?Q?TYVQDX8V9/VOADXC21eHEmrIS1aKCGpV4Yq4Ak+FtNE5RoLS/TYKCUJTXwI/?=
 =?us-ascii?Q?FxK+X1mX22a/Fb3aeigl719L10Uu/qRD+D9gEk5dpXkpJxt4ZeaQ39224ctL?=
 =?us-ascii?Q?OTgxlwWNDrpHs1A79Brccv38f1zRsvscicxUE+QH9PkdlIqFx/05LYhgv1Yd?=
 =?us-ascii?Q?UPrm24bCnh+cVvjWGUYlb066niYC1Te6nLPealy/jft+838yDbUWF+9JlPWl?=
 =?us-ascii?Q?qIjp5d8AJT6EIUYRqGkvYOnc/80yK+QuXJsId1dvnSzfZHXGK+UOYX8ew2X/?=
 =?us-ascii?Q?VkaFWn+lV4a73mtaB8mxltj8i6DorSgWjCjSZPIJyfVn4+63W/inbsJmv7FT?=
 =?us-ascii?Q?nHviGO1UyYE2YqMKqfLhjuuz5LgC6QWT7le0aAoTz1WXgcT7GUEL77KVfoX+?=
 =?us-ascii?Q?FkwH1BgG7VmJTeqncy/YoTmn3RQnueOJmM0PXtvquhcFpaCioFQWyJk0Yya4?=
 =?us-ascii?Q?Q15qADOughDkLLF1khpIorA3QsFAsPTNgFFcMmoNjAgOvZdWPVTWVkGNZw71?=
 =?us-ascii?Q?9Qb3WzyEvthBd9aXzj59Krp1gVRytnTEu3MF2NGmGZtq2q0UkAbAEP4DQCav?=
 =?us-ascii?Q?aVbnM4ZiewmFmPS/WjCXsLrKyl1642otbdc1gBIfn1fA9OGrJTjJToilIxvn?=
 =?us-ascii?Q?VMT+0jVSgp0kLYU4DQj0fVtFzfwLAWh8SxjsxuAGx08nWg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kpD3f4kA6OXV/76WwlS/8izQF7PAIWPY1wM+xjtaVVM+cZC6weUgZRwCkuKe?=
 =?us-ascii?Q?jN/Kt0O5+1ov4Lmk9YBub2alz+pb44cbeVm6WD7FafK0sgyayyY+GmLq6k2N?=
 =?us-ascii?Q?KanQmIMdLWgX9xvq6SQzg80R7k12L2bI2aQ/5Eu3MKBbyjRFWmsYiYUAMV5e?=
 =?us-ascii?Q?6QnUrHe77a+ErsROpgy36Eh9qwTEEcRIZGkUXBl+jeNkJOHeJpV3hAd51FWO?=
 =?us-ascii?Q?wGZd4masAnRRA1MdHW3cXkQBSQogh8U8iSHFPn52QBZkcq7L/rabf4J8pqkI?=
 =?us-ascii?Q?Nec/fN7YPCdYOOOn9/14+VfRhRzIbSTtPYfhLoFRAn8vnf6WbOBgfor19Gk/?=
 =?us-ascii?Q?gSLxy44tEpCNksZ80BBsnsgGzCNyCYtz/5vnxn4xYMgebPRkMV9S5jStBCsg?=
 =?us-ascii?Q?6ewumpqzZFQP8fNjMk4Uz0W/LNl8ghMC3fIV/vNTYNx/iFzeEsvxIxaPcgE1?=
 =?us-ascii?Q?WfNC4j8aivoyNmTuntBbwwxtx+wyrOUiyBWyisEk/cjKhLTeq0NGz9j81ROI?=
 =?us-ascii?Q?yuELCh1b69E43OmzJB3WnvDb/7Ae6tJbnF1D8zdw6zl2jJ6yIu2gmzBEYo5F?=
 =?us-ascii?Q?kGCCEZYFU6k02D7dEX+jGUfUggKZnPjBbcIjBySOkCrrkEKbQDflQVRaYnF9?=
 =?us-ascii?Q?hXBpozyXQX33Q4MCx8t8ysfLpHME7y1T8Gci7Lz0cMghBCoWJPr0DCNpsFX6?=
 =?us-ascii?Q?e5WqYayXFTIDjyPx55PVEvUq7NwjaqV3E8eD7hZY1zzR8GLPzFNjNWXeZFXh?=
 =?us-ascii?Q?tHByJWuss9iYLLIfOzu5JduXFagNsc/RdpsBonnbyRVqXUX7EbmeciAJZAzp?=
 =?us-ascii?Q?j1PHcTtFulp6t0T3U+PpgmA0hwlen4XVXyEsvqLNl0TmRXdo1TwwezEW5Bna?=
 =?us-ascii?Q?UD01wqc5SyQ1TflfxDDrjlPY4Cw0ftz+5r3CSk4BE/yaae5sDHirINakpQ73?=
 =?us-ascii?Q?WB5FqIqAyRe/lkfO3YOJI68bU2tL+8qpbwGLdtl4XvrgcyTyN1yPKmF9wFLx?=
 =?us-ascii?Q?sWUwtKJqcgwpIDYem4M8zB2yLweLfK0AphiKVbp/J4Jdmr9T2YbDCMaKXD5j?=
 =?us-ascii?Q?YN+LsvBAzjEcWFaVcTSZNUy6nFhDf6GTO5FlbNJoskLF6o+FfuNvIiXgevic?=
 =?us-ascii?Q?9EuRf5rf4XRC3nkTNR6HIqUGHHCJPU/0lRFqpPFDUGBjhQ/AP/ldQ8u89y3m?=
 =?us-ascii?Q?SH/+GbEPOfjzQm4sq3hqeQQR6sexqzWbRquiT1crH15vUDfd8ySWHtinY5L+?=
 =?us-ascii?Q?W1sMDZk4QBIkYukbprxzodzWoa+TDxLo6jCBYeVAXJHkH8vyPPhFFxR5uvdZ?=
 =?us-ascii?Q?N18UtkOL4xh7mRPGqkyxl8381sFowfVItPNWms9PiN2DJsjlREAeemyX48xA?=
 =?us-ascii?Q?Ulf6htbzldWwq6JFaZC1/5nw0FEBlfLDAUxl8/ogWpl4rm7Yp3yfZRL2tuCN?=
 =?us-ascii?Q?QHanpVlJrI6d96nccStcGPs92ZQFPDvnKPRtBCH2pXnNCzQIb7o68Snld9JK?=
 =?us-ascii?Q?4XZZYsSSyyuqIwkOOOl7WsElW5GNa2NiMYp/BILZTPQXk7SAfSAElrTj19+q?=
 =?us-ascii?Q?ZaGWL/ce/QftL04bKRw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc549ca-8082-44a3-a3ac-08dc6eaf9a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 16:06:06.6255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZlv8UAg9pDmoEyXOZ8gdEXUWtAw6SnJV6flNJ4TalM2styYvgH1t9czgim58oAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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

From: Frank Min <Frank.Min@amd.com>

1. restore mqd from backup while resuming

2. use copy_toio and copy_fromio while mqd in vram

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 0bb119be2284..974219386e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2720,17 +2720,15 @@ static int gfx_v12_0_gfx_init_queue(struct amdgpu_r=
ing *ring)
                soc24_grbm_select(adev, 0, 0, 0, 0);
                mutex_unlock(&adev->srbm_mutex);
                if (adev->gfx.me.mqd_backup[mqd_idx])
-                       memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeo=
f(*mqd));
-       } else if (amdgpu_in_reset(adev)) {
-               /* reset mqd with the backup copy */
+                       memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd=
, sizeof(*mqd));
+       } else {
+               /* restore mqd with the backup copy */
                if (adev->gfx.me.mqd_backup[mqd_idx])
-                       memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeo=
f(*mqd));
+                       memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], =
sizeof(*mqd));
                /* reset the ring */
                ring->wptr =3D 0;
                *ring->wptr_cpu_addr =3D 0;
                amdgpu_ring_clear_ring(ring);
-       } else {
-               amdgpu_ring_clear_ring(ring);
        }

        return 0;
@@ -3091,18 +3089,15 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu_r=
ing *ring)
                mutex_unlock(&adev->srbm_mutex);

                if (adev->gfx.mec.mqd_backup[mqd_idx])
-                       memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, size=
of(*mqd));
-       } else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-               /* reset MQD to a clean status */
+                       memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mq=
d, sizeof(*mqd));
+       } else {
+               /* restore MQD to a clean status */
                if (adev->gfx.mec.mqd_backup[mqd_idx])
-                       memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], size=
of(*mqd));
-
+                       memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx],=
 sizeof(*mqd));
                /* reset ring buffer */
                ring->wptr =3D 0;
                atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
                amdgpu_ring_clear_ring(ring);
-       } else {
-               amdgpu_ring_clear_ring(ring);
        }

        return 0;
--
2.34.1


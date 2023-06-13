Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CA4C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 12:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9498A10E26C;
	Tue, 13 Jun 2023 12:39:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785AB10E239
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 12:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw8zLKqfLPnvC6Gz9I+gcTzolrfnB+W8EEc3ImzwEFvi1zKcD2LrkDI9XOA7qx7/vH/rjQxdRMarUjI+kjucdb3EMywujM+DYwNNriPYfw5XDGiokHpd2t6vjzeAJVxSWRwMBKW9cAdkX4Lf0DWKxFnhNvu5BN1NYbzikmoCfrM39RduZ4rWgSIcM67LVqqOEL81YnMeSa/HA/p+sp7eAIuRRKa6HqUQLkl1hFGVrfeiPotSoB/bRmWTWJUFmWMaZPqdzjhsDS5AeVeEnYIcDzpx6M9wvz+BLSiHi3I0NJAvTU2syucIToSrlxgFk4lARiqgfu6l1zvHX1q/k7ja5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUlEwp2U1cu797mHUk/Nk66hL9BUEc2JARFUGJc2EhU=;
 b=R/fH+3OLClQNi3JxY0NbiL4CDCm6sN2h24akGp3WwS52o3ioUdRcuJcVVL4K1LHThYN6Ncf49qc49r5ehQWVLdjrXB2aV3JNplrALtt+1hA9qyf3MFcTPdG2FSiz26eFXGOaoozfKswqtgvzK2/BY3lqDxaQS8Y8eEhyyRD+fx0SetHm/lKQTjZJSXS65ptqzfud3ICOLZ9IoUxjGyi6XugIxEQ4Dy2p/gpxWzXNRAoxrw6exb96DAEZaj/80gB46ojrRw8mRfMNicZyCIkyKt9xslf6K6R0ZiON1pe5mCzyiSWPKkwPF1JMfxT+NrDqKIlhbdts4sgIhhMPg3fIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUlEwp2U1cu797mHUk/Nk66hL9BUEc2JARFUGJc2EhU=;
 b=VygGcsg/bcZwaRyCsYfXRtQCNKgZRhzI6VMx2AjVHCVWilPkGq1qnceGxdQvX82h0Z3bAZtgYR/6hYrn6FqzPBftdHF1Y/4fBcS2ySR9yIV+pyxGOJw87Kf0iyt009lpP0ndG+KX8wgKdOJFgdH4Xe4Og9BZ2NHLXuHBsiOSf7w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 12:39:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 12:39:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Release SDMAv4.4.2 ecc irq properly
Thread-Topic: [PATCH] drm/amdgpu: Release SDMAv4.4.2 ecc irq properly
Thread-Index: AQHZneRVdV7SsnvEXkqFc4ZkyoyVRq+IrDbg
Date: Tue, 13 Jun 2023 12:39:06 +0000
Message-ID: <BN9PR12MB5257091520D54203069DCE63FC55A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230613104621.1545379-1-lijo.lazar@amd.com>
In-Reply-To: <20230613104621.1545379-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8ff9a0ee-4f36-4f46-8b39-b4efb0d43f97;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T12:38:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB8529:EE_
x-ms-office365-filtering-correlation-id: 0fd0c388-2969-460f-e40c-08db6c0b2d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3Brin6SKMET1oz3QjC0li4B9LCuoFvT5gQ4hs+3A97AdOQ4Y2g3rXZjFBmiz+Ltm+llCbbThMak/23Ce4bUDEY4QFCv558/wIIUWUKwMnoeyRu/Ef61f1UCFfvSDIg5UhXX+sIanZKUncNfB2BPcQBAu/Fgar2bfbhuc+BhGQ76KosIBO90gXuSTFUs6dyMDKhraRwOB5PIWg0dBSBOg37pNP4Ej7MNqW7lzxM8xHzhEpz/aNcAYsKNgvuxP+AF7pyvYn1Kyod1TmStFc3QStcav6AlVhQ3UUsdwU+7pTr7CKsKJDGP9Efso2zc+/ExGSNsp4IgSPWcchxygyEMsfKpSQV5CQosGkr3nMmgGi/21m1DACbt7LOAOTnJOeKhEDtHRLpUVfnEVzw/1R5BBjrBwagSRbldRhd6nansxaNo7Buf1lFfhvVNFI/J6NYWwQBWLv0GQPztWpKOjfs4mGWKRj2rKqMu7vAfNgu68J0vUq3KMKNOvOY3n6NLDSUZgzCMnOe71Bzs7jnN3Mw0lOFaiBghu1HlLXbP5O+jZPQ+Bjdh6Xa51qlD9MUGAiLK3vnd7/0dfRHnVkemU0i99kOF3BPkw4ynsBL1JngHltP0Oh+7HptC95Uc1aoNwBZM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(54906003)(5660300002)(110136005)(66556008)(4326008)(8676002)(52536014)(316002)(66946007)(41300700001)(8936002)(186003)(2906002)(66446008)(71200400001)(64756008)(478600001)(76116006)(66476007)(7696005)(6506007)(122000001)(33656002)(53546011)(26005)(55016003)(83380400001)(9686003)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYeK0nqB0SJFYQsT32KkjWYQF19ZX/NOvjShu9YjlAPr3GBBVCbgCRfAArpt?=
 =?us-ascii?Q?/esH7jeSF0bVVDprpNAInE8vqEIh7buRn7AGNCLVlucJxDAvx2xG+i8AxorU?=
 =?us-ascii?Q?2LS+o8lzxeoxtrVa60oVQlH1cvfKxUPktk6eNvntACbkNtbOhdMljSJnMs4T?=
 =?us-ascii?Q?gDL3IGQdo9VUL57qTg25NVlwmTSmIFvYiN+kkjlu3A2gjW6Mu4lE3zRLly+x?=
 =?us-ascii?Q?YgdkSG+OmTuyAUdOHqyT3WA1o8hjmmDEI23GuF5KeccPwlnzQxWgkWqRMeO5?=
 =?us-ascii?Q?0IDApQ5KaJqqCpYfoBjrR/yBuxYXV7rizlkQMrcf1XS/C1qDSjEMGW3Pc5WF?=
 =?us-ascii?Q?0vpIJBIDOCd6DgQ40L0LpREnG14UnhzhTPbkvghAnIkXaE4KFSKousHLzcve?=
 =?us-ascii?Q?5DEpxBPs6pvFxoVYFXHlpAvabHD1gh68CXH/dBSR6DPLLY+1cPsO5fv2WFIk?=
 =?us-ascii?Q?9hrlIN9reeEcFCr5uU9hIe4gKeDxuzm+lvqfhewJV2R47WULtFTJbffe+wAn?=
 =?us-ascii?Q?xsIpnwfns6B7NA6S3mmX2TBZI36NJhQdzs8tlF43RQTzDOjzR2p0cJsak6J3?=
 =?us-ascii?Q?YiaSeLBwF49I8fFEU/CcbuY7B0Jpc9Nb7HYA306QnQZbPJD70r4IkdgHVY41?=
 =?us-ascii?Q?1ejPWZwfz9VU5LhHIuIpAqIaAQ9WOXDXFkCH9DlC7hlA3fb9u99B9R1G1AOR?=
 =?us-ascii?Q?T9TEv2xTCSVeU9oxqmzZe5jDH2gAuuTlXqX2xiVXE+v2Y96a53tY4OixfV6O?=
 =?us-ascii?Q?KjFt6wJRuzRW6CjsiCZ81v6Ouk8V6jABbUZXqIK2fyF1DYlct6rMwfecLDD6?=
 =?us-ascii?Q?Pi2Dw7hW6zeLOCdFnIWyISJUMBcWan4H9n4tDo9WocKwPLaclRItDIqWuKRU?=
 =?us-ascii?Q?v1Cc9GAvZ50UAmFfnkN3PHKxG5XSBELehmXbKiJrzjYeBJM4AZteXNTpHXRl?=
 =?us-ascii?Q?sLMOU61kC9sSQQklABaScCbEN21aopTfaJKQNAcONZt6sb/RIma+WsPbeZ9y?=
 =?us-ascii?Q?g+qg1jUTKaEaB322zliU7PI5mqFIIgif9bARhBrF16Bqc40oX90A6+RBAN1x?=
 =?us-ascii?Q?NTGioANvaxShI/3KeEpUjBcbI6/EhC/AR/C8FZOz2TNAW5Ts7Ec5aAgD5UY/?=
 =?us-ascii?Q?GGz0kX7LfqG7VMDftTrlSKxQj+ZcGE+MDGhm/KzqD/4tGnU3V200088TvQG2?=
 =?us-ascii?Q?4lNzUP1WnIgSITretpXQZNfrD/aChbQeV4iVbCmAO0NBBsD/Pj2DTSRIjH/H?=
 =?us-ascii?Q?tCb6wxM7MAG8udFvM8YlTvkR7Dboz0ajpgADYW0xVbfS8axONWz6puVhprFM?=
 =?us-ascii?Q?HDu/hjlK5/YB2tglhERwOFjB425/lZoGFg9g69Si6mMe5Y8hRTb0yLK0G5i2?=
 =?us-ascii?Q?BGA8olGlazzRQbLAF+KX3PNqagACOAUrikOXc33pu2CtPGprP3vMEZOWBKEK?=
 =?us-ascii?Q?DucTbiIfVfpr3Gg/lxGEHxISGVgJ0Hxn4Phyfs/ClLZpSp3gUsB45ctZk4cN?=
 =?us-ascii?Q?qq1HE38Btb7KoF3eA/zUZgjXa4NRohUF+kzk+WYvnpTSN2uEC07/ik8qmvlD?=
 =?us-ascii?Q?Qulb9uBUGpcXWBi7fYww+ISh607vVBOq9IRQVTjL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0c388-2969-460f-e40c-08db6c0b2d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 12:39:06.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8XRfyZUJNz81I4rN3UrrTVwxuZGstipW3D46A85IR8iC6rdshg5dTDID2JAjT+CdI4WiKXHEawbc88RSC19PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 13, 2023 18:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Release SDMAv4.4.2 ecc irq properly

Release ECC irq only if irq is enabled - only when RAS feature is enabled E=
CC irq gets enabled.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 8eebf9c2bbcd..77ebf27981e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1434,9 +1434,11 @@ static int sdma_v4_4_2_hw_fini(void *handle)
                return 0;

        inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-                              AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+               for (i =3D 0; i < adev->sdma.num_instances; i++) {
+                       amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+                                      AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+               }
        }

        sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask); @@ -207=
3,9 +2075,12 @@ static int sdma_v4_4_2_xcp_suspend(void *handle, uint32_t i=
nst_mask)
        uint32_t tmp_mask =3D inst_mask;
        int i;

-       for_each_inst(i, tmp_mask) {
-               amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-                              AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+               for_each_inst(i, tmp_mask)
+               {
+                       amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+                                      AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+               }
        }

        sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
--
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14533C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F92410F907;
	Wed, 15 Dec 2021 19:20:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DB210F907
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvrjARUE7dYoBlgf/7sm+jJ/WBR/HUCjdyBTlZeYDNQCifk74QjhwBA+85L//iP3sYPTvhiXgICbwSwdGgnvPWsb0bny2ATCb3tB5eeCGPnRtt3VtDWY1Bejle85TiZwuLe6HXGq5HV3/NzRiLbTjvY0BlYv+aRQHoLXU/CV4rCm8Zhh9UJqnrUbJwIBvtGjSgpSUcAu2rk+rvJzX0wRERntD5AkSZf+FUIfsG5fkRIcWLkz0mPfL8lATZ02Iws3bpp8T7wi2JkeiMmF0g9QoUgjoOyFiC1551hY8qoEhJ4/UtV56MBthhFqR1KX7ILcpVC8bC1GGNhFK+UrL7/yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy2bdGBU+/cWoTVC7/svoJoxP/iqWfQRWtrRE0Cu/Kw=;
 b=IqCtyZy3QoyJqTHbZ9QZ1oJ4lAOxtrOZLD8Y8flNO8z0UVwAG2oxL+0nm5XKoWLWeMnO4R9aUYHmN67K6az6wmpO/B3fljPzSZSsKIC+w1LC1EPkpqTVUn+z3SKyDwVnXU1ArL6dKYqOt4sBZIFVMq3cnGFsqSVZTPY+AyD/EMRgswzskj3OZtmQeOzGbE03lCtD0sPkQI91rRh77zODjl1LEzwp0aSBc1FYEcZoSzXTeY8TehOqawg+mgt3CiV+iqyWVXUiiRL1VrY+2UWF8inkR+3qWZQLE3y7Ees/w/s2YnR375Ny3rCW/EQ/0mT28tAY4ccR/3FMOqSR+BPqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy2bdGBU+/cWoTVC7/svoJoxP/iqWfQRWtrRE0Cu/Kw=;
 b=tbVsrU34puKS+VmcQcfxlFJkR2GorewrowvQvOBaCCY9Bi8tch1lFsr2rvihZwiQsEbn7iPoZTBbzxLZ6r9bMAuAvNdzbV+4dr0Keq45EGwHO5Zl8X3G0Q4QAqdcIn40+SsCfGqmrhaJH/0/56cSgbQPeDyvnW9Uxa+7SbI6qi4=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 15 Dec
 2021 19:20:08 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:20:08 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Thread-Topic: [PATCH 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Thread-Index: AQHX8eVWyluks1UgEES7t7+xitRLkKwz7MuM
Date: Wed, 15 Dec 2021 19:20:07 +0000
Message-ID: <BYAPR12MB2840B1948370983D178DDD7CF4769@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-3-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-3-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:20:07.389Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 46e587ea-fc0e-17e3-f978-3e807316eb57
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17dd22f-e1b5-4759-6153-08d9bfffe818
x-ms-traffictypediagnostic: BY5PR12MB4856:EE_
x-microsoft-antispam-prvs: <BY5PR12MB485674C84FE91C228FAAD228F4769@BY5PR12MB4856.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imJwNW9Im65vlSpXZD5vxjgkF5JQJqHzs1FDJLLrHszO9hsIJaeFSTLoHQq/zzotAFDAjLGDP//0P3AqaUdFRDUsZSPLlujasFrfwShDUMpy63cSz7xUwMOV9Nhbvkxblf5fdQh93W1sC8Z+TkL/HdsdDBoACNlMuhdw6oQ+4bR57noaZYMFI3zDGxBOOrh04k7/3s0SY2jfmBMwnhoi6oeOBzOqk08eAxe3u+9gSOrGL4aYlvQxbRe0RZn+K/u32DnD3Sa6yDv255lA8WGlP4o82x4vkhkPnBI5WsacKg6x5Q7x8r8gO+easpfaOHcVnjAm7SDGjAEJoFs5kBFwY7/0WTGxxp8ia4nr/UKHLbS9a3VWpqsA6IbsvczXadybHHc9reXiABNpfuoSohLly8fCqK2Cu0Rqu6v3GJ8fj7J79QrMan4BU8GB5rtvE+zF3s/07i0oz3dXtiqdNZbDvMgGM1t7rH9++0YxpjQG7yS9W+cp7sbA4J8LvhQmT58YoOcBMwBFYu81pAMf+/VupJeGOf81SwaTAWqlugOhir4vVNLjrKlfikCsrFLnrsYkV5UXHK8d/7sxBhyuzFQTxbZRkkrniL4aLq+KVm8AaHlMx/p9Y2cGFPSLcHgz0VXlAIKsmsbS+wNX/NAl75MlFUE/Xld6oh+aGXYkPvRxD9sHgLzpb8JGoT+DCqlNLcpShliIa6sASDRaWjlbnnsUr6/r8JNkqLCqZexwURnJprQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(64756008)(9686003)(66446008)(6506007)(508600001)(5660300002)(6636002)(66556008)(186003)(7696005)(921005)(86362001)(122000001)(83380400001)(71200400001)(38070700005)(52536014)(2906002)(8936002)(316002)(76116006)(53546011)(110136005)(66946007)(8676002)(66476007)(19627405001)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PRU8naJMQivuv5L7q4FpgDkGNuHssQNfqei+WO6y6Tsw1TopDLIZbkY1TkmX?=
 =?us-ascii?Q?iuh1PrHTw8zI3L9oG8byVexWnkm8cMC1pUM+XaDijUKvRBhjUByrSeE1kn0W?=
 =?us-ascii?Q?zGPf1AAg49i4xE/zD3bk6nn3yWZ8YZoYPlYHgnde2SU1RIxsy8DKCJvNq/R1?=
 =?us-ascii?Q?s41Hsla7wvu4/oWU+1PlOwMGEw2L0BQhydXIzdtaQLfhffaGXhtLmPUHPDRC?=
 =?us-ascii?Q?C7fykAe0LS2yFF9B9f6e2j00NMOMd6lh2vw+zopO3BSnAcB9dDq+FldOLIU2?=
 =?us-ascii?Q?blmZWteJFjmracb2eYeMa1lOYO45a6cb2Z0xqWYnEiLQUI7Int+VPaO+FJrg?=
 =?us-ascii?Q?JzMkNOe7r2r0m/IcrAthWsoj4lQ5BPkt+x5+hOg9m6cbzcFX1WW1hQYbIrFC?=
 =?us-ascii?Q?hwBv4Ra2LCl5P9iyo5VGytaOlsCbb6c7pZMg/SS8Oov1JqJ5T3Q6/27kgCUt?=
 =?us-ascii?Q?Hum1Ss4frMqwOXw1P0Qkc4hi1LMSutHSK7YXgfyv5LMtiU7sQ3FjPFV0s0nr?=
 =?us-ascii?Q?ySHr07B+8FId8xPZAe4gt7b0t019jh6yKIouO19pXjKJZNjd7tUbGUMxMq2G?=
 =?us-ascii?Q?vegBDJSiyTbeiWLR2J96UXB+/HigLf9FuBXk5HClo98H9MWYQ/Wk+2cTk8ck?=
 =?us-ascii?Q?ZTJoCWZFH5ymuW5jD6Qu/dI1JZtErJHzyEVqOGeKuXuXY5H5fKfV2uwAj79R?=
 =?us-ascii?Q?nU4pepRJH3xHqb+8k4HYlm5RuvmlB32Psv+F/6FRZICl43bmDATHpPCjCVOR?=
 =?us-ascii?Q?N0JphPzPZQC1769UpZxtu1Cy8dRP5i16+tdDirDl708PLghx3JNjxHzG2m3k?=
 =?us-ascii?Q?FcaJOclGuN9XDXlosMVU+0wTqi1a9m1oJxeWZRMfwet2DpDaLM+Ke9J4t04B?=
 =?us-ascii?Q?tpF5IKq5JmlrZki8JmIWy0xpfXRacxzATzIFTCvesSa21EHBEi1RzPZeLnBo?=
 =?us-ascii?Q?iybU6PnZYF29JQm36O6XMa+CtlTD9P/Wqe1x0KufaNLolIokjpBg3Azmk0s9?=
 =?us-ascii?Q?62yvFE2Xsq9LtGnooRlHiKW7mJnNcrJf6xa+mNw8QUaVHBsJ4mY6h1jMOur5?=
 =?us-ascii?Q?9orcbqqrG8BbszFZRqBCb2XiV8KuZ02EAXDk48N6RXESHfk52gNCZH2A+qi2?=
 =?us-ascii?Q?V8g8inOKhm5sAqljwahBvQGJAjfSZ/7Nz9eyp7WrClZoQu8pL7Crkf0wKOjT?=
 =?us-ascii?Q?c4VxRYj0z3Xze6JYWir+XHdOyi9aTsRItFsj3mBO4v07RUzKQcnJ+3DR2Bp5?=
 =?us-ascii?Q?98UmXWIjzvJ4wsTE3ZUAGBAvD1LyAutPZ2wy6NpuDDYfPKR2fr7ZQJgSf71K?=
 =?us-ascii?Q?ASvUkt3j7Ls2U50rSlsi+wRh9whTr/ReO3ge9WkYQz82tm2mYyBd5IMBNxMP?=
 =?us-ascii?Q?Eho2k8PO6SPRtg1pGKacoz4C7m4IvPdv7C0BoY/zkIGF/6IAS79iTUlbqE9i?=
 =?us-ascii?Q?HAj6mIUivRGynyKrFRT5yedsdzYII93zUIT/o8yP1xGjTLWo336qgKCI4SIB?=
 =?us-ascii?Q?CplAmjmUoMmgTLmMTqT8tUKAv+GNVOqsRnTOwZpzmYr0j9WzUMfLSpBIpD07?=
 =?us-ascii?Q?Ewt+B8b22VYRTiSSz+Vz7V5+lfZpu5qkcH9m5bay?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840B1948370983D178DDD7CF4769BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17dd22f-e1b5-4759-6153-08d9bfffe818
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:20:08.0134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULeel58ub2vuIFVOferP8UpD+ZjYcxLxaE9kMA6kJE8LToHrOQwT2+Auk3RKvTnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
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

--_000_BYAPR12MB2840B1948370983D178DDD7CF4769BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I don't know what others may think, but this coding while correct:

-               WREG32_NO_KIQ(hub->vm_inv_eng0_req +
-                             hub->eng_distance * eng, inv_req);
+               (vmhub =3D=3D AMDGPU_GFXHUB_0) ?
+                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + h=
ub->eng_distance * eng, inv_req) :
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req =
+ hub->eng_distance * eng, inv_req);

if is bit difficult to read. I wouldn't mind if the results of those functi=
on calls were stored in a variable, but here, you are using it as an if/els=
e or a switch statement. It is better to do it like that:

switch(vmhub) {
case AMDGPU_GFXHUB_0):
//yadayada

or

if (vmhub =3D=3D AMDGPU_GFXHUB_0)
 //yadayada
else {
 // yada du
}
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Modify indirect register access for gmc_v9=
_0 sriov

Modify GC register access from MMIO to RLCG if the
indirect flag is set

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 45 +++++++++++++++++++--------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index db2ec84f7237..345ce7fc6463 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -478,9 +478,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,
                         hub =3D &adev->vmhub[j];
                         for (i =3D 0; i < 16; i++) {
                                 reg =3D hub->vm_context0_cntl + i;
-                               tmp =3D RREG32(reg);
+
+                               tmp =3D (j =3D=3D AMDGPU_GFXHUB_0) ?
+                                       RREG32_SOC15_IP(GC, reg) :
+                                       RREG32_SOC15_IP(MMHUB, reg);
+
                                 tmp &=3D ~bits;
-                               WREG32(reg, tmp);
+
+                               (j =3D=3D AMDGPU_GFXHUB_0) ?
+                                       WREG32_SOC15_IP(GC, reg, tmp) :
+                                       WREG32_SOC15_IP(MMHUB, reg, tmp);
                         }
                 }
                 break;
@@ -489,9 +496,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,
                         hub =3D &adev->vmhub[j];
                         for (i =3D 0; i < 16; i++) {
                                 reg =3D hub->vm_context0_cntl + i;
-                               tmp =3D RREG32(reg);
+
+                               tmp =3D (j =3D=3D AMDGPU_GFXHUB_0) ?
+                                       RREG32_SOC15_IP(GC, reg) :
+                                       RREG32_SOC15_IP(MMHUB, reg);
+
                                 tmp |=3D bits;
-                               WREG32(reg, tmp);
+
+                               (j =3D=3D AMDGPU_GFXHUB_0) ?
+                                       WREG32_SOC15_IP(GC, reg, tmp) :
+                                       WREG32_SOC15_IP(MMHUB, reg, tmp);
                         }
                 }
                 break;
@@ -789,8 +803,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
         if (use_semaphore) {
                 for (j =3D 0; j < adev->usec_timeout; j++) {
                         /* a read return value of 1 means semaphore acuqir=
e */
-                       tmp =3D RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-                                           hub->eng_distance * eng);
+                       tmp =3D (vmhub =3D=3D AMDGPU_GFXHUB_0) ?
+                                       RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_=
inv_eng0_sem + hub->eng_distance * eng) :
+                                       RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->=
vm_inv_eng0_sem + hub->eng_distance * eng);
                         if (tmp & 0x1)
                                 break;
                         udelay(1);
@@ -801,8 +816,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
         }

         do {
-               WREG32_NO_KIQ(hub->vm_inv_eng0_req +
-                             hub->eng_distance * eng, inv_req);
+               (vmhub =3D=3D AMDGPU_GFXHUB_0) ?
+                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + h=
ub->eng_distance * eng, inv_req) :
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req =
+ hub->eng_distance * eng, inv_req);

                 /*
                  * Issue a dummy read to wait for the ACK register to
@@ -815,8 +831,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                                       hub->eng_distance * eng);

                 for (j =3D 0; j < adev->usec_timeout; j++) {
-                       tmp =3D RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-                                           hub->eng_distance * eng);
+                       tmp =3D (vmhub =3D=3D AMDGPU_GFXHUB_0) ?
+                               RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0=
_ack + hub->eng_distance * eng) :
+                               RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_e=
ng0_ack + hub->eng_distance * eng);
                         if (tmp & (1 << vmid))
                                 break;
                         udelay(1);
@@ -827,13 +844,15 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
         } while (inv_req);

         /* TODO: It needs to continue working on debugging with semaphore =
for GFXHUB as well. */
-       if (use_semaphore)
+       if (use_semaphore) {
                 /*
                  * add semaphore release after invalidation,
                  * write with 0 means semaphore release
                  */
-               WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-                             hub->eng_distance * eng, 0);
+               (vmhub =3D=3D AMDGPU_GFXHUB_0) ?
+                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + h=
ub->eng_distance * eng, 0) :
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem =
+ hub->eng_distance * eng, 0);
+       }

         spin_unlock(&adev->gmc.invalidate_lock);

--
2.25.1


--_000_BYAPR12MB2840B1948370983D178DDD7CF4769BYAPR12MB2840namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I don't know what others may think, but this coding while correct:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
 WREG32_NO_KIQ(hub-&gt;vm_inv_eng0_req +</span><br>
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 hub-&gt;eng_distance * eng, inv_req);</span><br style=3D"color: rgb(0, 0, =
0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-col=
or: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
 (vmhub =3D=3D AMDGPU_GFXHUB_0) ?</span><br style=3D"color: rgb(0, 0, 0); f=
ont-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,=
 &quot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &quot;=
Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-color: r=
gb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 WREG32_SOC15_IP_NO_KIQ(GC, hub-&gt;vm_inv_eng0_req + hub-&gt;eng_distance =
* eng, inv_req) :</span><br style=3D"color: rgb(0, 0, 0); font-family: &quo=
t;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&=
quot;, -apple-system, &quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&q=
uot;, sans-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255=
);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 WREG32_SOC15_IP_NO_KIQ(MMHUB, hub-&gt;vm_inv_eng0_req + hub-&gt;eng_distan=
ce * eng, inv_req);</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">if
 is bit difficult to read. I wouldn't mind if the results of those function=
 calls were stored in a variable, but here, you are using it as an if/else =
or a switch statement. It is better to do it like that:</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
switch(vmhub) {</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
case AMDGPU_GFXHUB_0):</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
//yadayada</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
or</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
if (vmhub =3D=3D AMDGPU_GFXHUB_0)&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
&nbsp;//yadayada</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
else {</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
&nbsp;// yada du</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
}</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/5] drm/amdgpu: Modify indirect register access for=
 gmc_v9_0 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify GC register access from MMIO to RLCG if the=
<br>
indirect flag is set<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 45 +++++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 32 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index db2ec84f7237..345ce7fc6463 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -478,9 +478,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub =
=3D &amp;adev-&gt;vmhub[j];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
i =3D 0; i &lt; 16; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D hub-&gt;vm_context0_cntl=
 + i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(reg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (j =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP(GC, reg) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP(MMHUB, reg);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~bits;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(reg, tmp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (j =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(MMHUB, reg, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -489,9 +496,16 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub =
=3D &amp;adev-&gt;vmhub[j];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
i =3D 0; i &lt; 16; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D hub-&gt;vm_context0_cntl=
 + i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(reg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (j =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP(GC, reg) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP(MMHUB, reg);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D bits;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(reg, tmp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (j =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(MMHUB, reg, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -789,8 +803,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_semaphore) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;usec_timeout; j++) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* a =
read return value of 1 means semaphore acuqire */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_N=
O_KIQ(hub-&gt;vm_inv_eng0_sem +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (vmhub =
=3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP_NO_KIQ(GC, hub-&gt;vm_inv_eng0_sem + hub-&gt;eng_dista=
nce * eng) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; RREG32_SOC15_IP_NO_KIQ(MMHUB, hub-&gt;vm_inv_eng0_sem + hub-&gt;eng_di=
stance * eng);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
mp &amp; 0x1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(1);<br>
@@ -801,8 +816,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(hub-&gt;vm_inv_eng0_req +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng, inv_req);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (vmhub =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(GC, hub-&gt;vm_inv_eng0_req + hub-&gt;eng_distance * eng, inv_req) :=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(MMHUB, hub-&gt;vm_inv_eng0_req + hub-&gt;eng_distance * eng, inv_req=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Issue a dummy read to wait for the ACK regist=
er to<br>
@@ -815,8 +831,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hub-&gt;eng_distance * eng);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;usec_timeout; j++) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_N=
O_KIQ(hub-&gt;vm_inv_eng0_ack +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (vmhub =
=3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15_IP_NO_KIQ(GC, hub-&gt;vm_inv_e=
ng0_ack + hub-&gt;eng_distance * eng) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15_IP_NO_KIQ(MMHUB, hub-&gt;vm_in=
v_eng0_ack + hub-&gt;eng_distance * eng);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
mp &amp; (1 &lt;&lt; vmid))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(1);<br>
@@ -827,13 +844,15 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (inv_req);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: It needs to conti=
nue working on debugging with semaphore for GFXHUB as well. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_semaphore)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_semaphore) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * add semaphore release after invalidation,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * write with 0 means semaphore release<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(hub-&gt;vm_inv_eng0_sem +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (vmhub =3D=3D AMDGPU_GFXHUB_0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(GC, hub-&gt;vm_inv_eng0_sem + hub-&gt;eng_distance * eng, 0) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(MMHUB, hub-&gt;vm_inv_eng0_sem + hub-&gt;eng_distance * eng, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;=
gmc.invalidate_lock);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840B1948370983D178DDD7CF4769BYAPR12MB2840namp_--

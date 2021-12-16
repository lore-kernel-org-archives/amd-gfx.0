Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61422C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D873E10EDEB;
	Thu, 16 Dec 2021 20:04:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EC010EDEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6E9ty9aEA5ftbOA7q5VbAtcTHFjSyrAQyhAGNnJsIFvQPxW4YiBJJW7nZEqMNubUfIY02ZuqdbHC5DZgx01CGw47coWp57vRLIpn4ZnX68Lh092+bK1MRNNRvt/xs5KxN+XlGNRzFVMr/moDWC+nnYk2xK5Bcjxg3bCc6lH2veYtgeX2ukGPQXwZddlBkPBPscOCf255eAX99fXcbNDWPhE+Zkb+pocslQZK6C2pT+qZGURED4Vf/8QLWSdM3WeFlIf3ip5F+VU0+HT4R2j4TK4KxQ6YStX1AbYR8i0So3RG2jAXHagd1xsmfGg7vSdSlVezUU5/8EoH4F/nSWFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOY0B8u39fJ3DqY3rQJYt6waPV/oAF9dLNx+1/mhMzg=;
 b=aWiLAJmfqTKBngL5bGz8HFv7fDH+TomaejQhoKiVLXdfSDfZG0BzzkunRsOka/q7hWzcs+2Xf9izm1wPktfoiPosMS9KRoHYaR/cVK5z6CTL1edsJh9v4nDzOW4bbP5xuFLf7MpzhiLQWPZEQkHINHxXEGMOX4Sr7h9TQEBIDVkF48CJtZD1w3hQb8RfuqTyCPI3OhorAjTCHg+49wwNlGhtwOXTq3dJYnizDyLQi2BnnXQkuziPVcUnECfg99h4Nqxq0WKXDzuWdSV0OMWuACvpl5NB9WW3Nq9kEUvypKpQbg8K7MZIgFiTn7NJYzRK4GtTSzUAsH3pXwDEhfpgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOY0B8u39fJ3DqY3rQJYt6waPV/oAF9dLNx+1/mhMzg=;
 b=p5gFguWHjRNwUPGR+CX7LkDkGV4hZgin6QlX9w8pD5FnLo/EZIRyinyvp3zcYor7GXX4M92MQgLfinb32UnNQRmOYbaXHGRuPQLNss1HxZPnGXaX2I+BNHLatwrSyBCkyvZeUuWdk41/PwMfRJzJd4Frxtik9L3jbuf+uffEPfc=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:04:02 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 20:04:02 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH v3 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Thread-Topic: [PATCH v3 2/5] drm/amdgpu: Modify indirect register access for
 gmc_v9_0 sriov
Thread-Index: AQHX8rUdmh8yTsO6yUW7YC4SS/Yw7aw1irbF
Date: Thu, 16 Dec 2021 20:04:02 +0000
Message-ID: <BYAPR12MB2840DF4CC1B2F91382DC81DFF4779@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-3-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-3-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:04:02.127Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 54fa2ee6-d084-f1ac-7e75-1ea6fab084fa
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17627d86-32e7-4d2f-b784-08d9c0cf34f9
x-ms-traffictypediagnostic: BYAPR12MB4630:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4630433D3EAF342E7AE0776BF4779@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlZLHutjG6xJCfg0h2OiDjLfvlgAaB2Iz2m+y4y525fIKCcnWiqjXSBLs4D81Ep781ITev1QJRJEehMZ68EfH/OaiobfhvIGLcvI3kyevE1W/cWvxeIfaFNxAxhIbWLoL9uPw0q9c8UREygQhZlHiHh3SYY4zp1FtMbSe8LMzEl7ngPc67lsgY3cfHR5Q/gWW8VaflYJkmvxKzaZ5sUfGsEIA5aae5TrlZXfqtPSF5QIDztqrBcHRZSNWgv2SUknEgcOO0eKhtVFRdBB9c7yDKpbfC8Nx6mewJf97KWehE6kIORjhyZ4jlQ5nyqT3ty2j1hw7F8bJUrvNpVBz2Vtme7ujM5SNUWQs5fh2wEkUSiRf0BQNxzmfzLUDnDwgVoHb/K0YDB+sg0RhcGq/pJmFRDZqaEztWoVydaGNGf63d5Sqm4O93ogHypX382pm1yAyD31zo8EdjvmdPvfdRuGFWxjixeCy4SuIAB+t/ftfnQEe6zp8Sb+o8ob7Kboh34kzOKP8GgI4dsHqfKxW9fY82tpDpgeOg0MW3pcLntGeD1fQnceOW84kjetKoGfv/ZqECmPFSrU2ydWHJNDJXtPzgjJ4eKS08QwH3up297IPv66/t+id1cLhfHhNh2VyhZ9KqM7tU5WvVIxZIx+N97+H4jG8qKOJbmz6p47D+73IjvfCtw+BzFy510hQdu/Glft4VaJ7nwJDnH1JH0fDaveA+jX8DzxQ3e5VC9iruZGpgU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(110136005)(55016003)(2906002)(6636002)(38070700005)(19627405001)(316002)(66476007)(86362001)(7696005)(53546011)(6506007)(52536014)(83380400001)(921005)(66946007)(5660300002)(76116006)(8676002)(66446008)(64756008)(66556008)(186003)(508600001)(9686003)(8936002)(122000001)(38100700002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ojlzcLyoDGioIc7tN02Z6PAqnRCceghU0NlDw6drH8j8ZjWre6Hm8dhs+HH?=
 =?us-ascii?Q?DLjl3xpdezspc1ZcElAhUQIpoH8w2XoabuPjTusbfK9+xoLSOx/3V4iLAGwr?=
 =?us-ascii?Q?Av7vk5e8jeqfz4a14WgTtmm2teuPBwLwYZW9yMED3sdYwBGyTWbStvUxrHLo?=
 =?us-ascii?Q?MUNL0ZfHu/wyOJ14VfROs0LLCJKU8Z49gBP1k2B245nCUnQv2TrVnv1FZCaE?=
 =?us-ascii?Q?LdGxXBK45GUNEoye8S5P7TdUT0WTuDxQikNIJuvnoppOCVIRlS0m9pgwV2d6?=
 =?us-ascii?Q?MeN/8WyGbtUAmVpJMkGNGVfYZWAAFe9MnkzJjfN+m7YFEhTGyzP0Hgikbv4c?=
 =?us-ascii?Q?s1qPvIUcdUeq4gsxFT10ZY1CHi493OUxg1tyfZtn7bxhexfr5K0Bt4AU1tV6?=
 =?us-ascii?Q?rSvj2NS1YfDsIuaE/QMMHFULm29RJt/0mR99wUA/f3EV7p19h/6btYncLjXc?=
 =?us-ascii?Q?uPGScEILefxVDvTFjpVMZPehidcuA98TZECMwwcGSSIidDmpR2WH6q4mx0xd?=
 =?us-ascii?Q?ai1fKe1IJvhXb/X+bnXOzzhN+4NVVdKo82qsKv7xGhUNepvcbtS1AAGc0Tkv?=
 =?us-ascii?Q?Vnc6Q7WjI8GTNZ4IrUYYWwHIl3rHwltZUEOnA9C/IBRs/Z3YegNK2xezjnj/?=
 =?us-ascii?Q?dI/F1a+hdk9DIytP+Z4Y0sAWhN2OXv4mjeu6xFCF/vwNVkgR/FeuD6kfDSAT?=
 =?us-ascii?Q?O6NLsL7jphPOThPTsG4aLfeCUqa7Utl9mUEeEfNlhaceHSTtIadFQEDzA7IQ?=
 =?us-ascii?Q?2fRpH2k96IU6uALxySrGncK16STs7zGq9p+laS1dB0GOwrF62hWQ3ypLJJUv?=
 =?us-ascii?Q?Gas59pDnwjN9OCoSAq72UXRCOjNKBvJI9aqKuV5AtgHYIXMBmU6ffzcMvYKM?=
 =?us-ascii?Q?Ot9i2IiapFClERDr/ky/C4+x0RXEDRnWz/HXdgeoc2PqXBoaM6MlI2NK13Je?=
 =?us-ascii?Q?HbtJk/kinEcsqJ+IVjXvkW7VyEK10ds8AKG4jM1ad8zLMyTZkKEYDBu3j1cu?=
 =?us-ascii?Q?6U2J0eOhDVcE6wVwpOcJKE+APBCTyoQbZG7d1/EJlX3NmDnoVH4JBtVIc3tW?=
 =?us-ascii?Q?5K1IFp452efkJQsZjt5LaSfT0cbUEXLwnCrZPHXmMZNugarfi+MNmcsbtZzN?=
 =?us-ascii?Q?Hnl4+gfjtJIcJ/oL8pXVW/ImOYZ0tQdmOy4s/ZakDOkVnCJR5UMy6KnHJcRb?=
 =?us-ascii?Q?gte6rHtE+0laTYJ5oYTq00BYz0sXSK5dw44nS47CtQ06ezOHVmjW72+DpqQV?=
 =?us-ascii?Q?zNu3Pjpg6Srx6rLQ4igQ5Wam+GuUXaQg1fjtx8zZELO5qEezRpnpt0dFKZgM?=
 =?us-ascii?Q?g5LetPdKNNs5abN3dR+bDxRJxhRl49x7xEQEQz8/UB5Zr1PwzPPGhpS3FUH2?=
 =?us-ascii?Q?K7qpjbfKORNmcHbR39VzwsGDR5OQu6d1dt54t81ewWw2gXsh3hHAQ9U6kn07?=
 =?us-ascii?Q?M8JBCeJWmSnUTzov0en2+QHs4iy/zfvF9eqr4zO8zjumf/dDi+auZl/7lIe2?=
 =?us-ascii?Q?FEJsOuZmNyPkfKCYHQaYvY6MKSVJHgfB0qLHFCxSDlTVvelu0PSjS/sRxU08?=
 =?us-ascii?Q?6gLjiHmkpagSbqSoaZOKED8lrTVoWroX7DBxYcxz?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840DF4CC1B2F91382DC81DFF4779BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17627d86-32e7-4d2f-b784-08d9c0cf34f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:04:02.7270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+G4o18hOB+pPeNjJDV5LhozVO3pyaQ1hfnWwVaa+Rummd1jTX/p381xvAke4WDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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

--_000_BYAPR12MB2840DF4CC1B2F91382DC81DFF4779BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: David Nieto <david.nieto@amd.com>
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Thursday, December 16, 2021 11:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu: Modify indirect register access for gmc=
_v9_0 sriov

Modify GC register access from MMIO to RLCG if the
indirect flag is set

v2: Replaced ternary operator with if-else for better
readability

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 57 ++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index a5471923b3f6..2b86c63b032a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -478,9 +478,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,
                         hub =3D &adev->vmhub[j];
                         for (i =3D 0; i < 16; i++) {
                                 reg =3D hub->vm_context0_cntl + i;
-                               tmp =3D RREG32(reg);
+
+                               if (j =3D=3D AMDGPU_GFXHUB_0)
+                                       tmp =3D RREG32_SOC15_IP(GC, reg);
+                               else
+                                       tmp =3D RREG32_SOC15_IP(MMHUB, reg)=
;
+
                                 tmp &=3D ~bits;
-                               WREG32(reg, tmp);
+
+                               if (j =3D=3D AMDGPU_GFXHUB_0)
+                                       WREG32_SOC15_IP(GC, reg, tmp);
+                               else
+                                       WREG32_SOC15_IP(MMHUB, reg, tmp);
                         }
                 }
                 break;
@@ -489,9 +498,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
dgpu_device *adev,
                         hub =3D &adev->vmhub[j];
                         for (i =3D 0; i < 16; i++) {
                                 reg =3D hub->vm_context0_cntl + i;
-                               tmp =3D RREG32(reg);
+
+                               if (j =3D=3D AMDGPU_GFXHUB_0)
+                                       tmp =3D RREG32_SOC15_IP(GC, reg);
+                               else
+                                       tmp =3D RREG32_SOC15_IP(MMHUB, reg)=
;
+
                                 tmp |=3D bits;
-                               WREG32(reg, tmp);
+
+                               if (j =3D=3D AMDGPU_GFXHUB_0)
+                                       WREG32_SOC15_IP(GC, reg, tmp);
+                               else
+                                       WREG32_SOC15_IP(MMHUB, reg, tmp);
                         }
                 }
                 break;
@@ -788,9 +806,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         /* TODO: It needs to continue working on debugging with semaphore =
for GFXHUB as well. */
         if (use_semaphore) {
                 for (j =3D 0; j < adev->usec_timeout; j++) {
-                       /* a read return value of 1 means semaphore acuqire=
 */
-                       tmp =3D RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
-                                           hub->eng_distance * eng);
+                       /* a read return value of 1 means semaphore acquire=
 */
+                       if (vmhub =3D=3D AMDGPU_GFXHUB_0)
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_=
inv_eng0_sem + hub->eng_distance * eng);
+                       else
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->=
vm_inv_eng0_sem + hub->eng_distance * eng);
+
                         if (tmp & 0x1)
                                 break;
                         udelay(1);
@@ -801,8 +822,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         }

         do {
-               WREG32_NO_KIQ(hub->vm_inv_eng0_req +
-                             hub->eng_distance * eng, inv_req);
+               if (vmhub =3D=3D AMDGPU_GFXHUB_0)
+                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + h=
ub->eng_distance * eng, inv_req);
+               else
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req =
+ hub->eng_distance * eng, inv_req);

                 /*
                  * Issue a dummy read to wait for the ACK register to
@@ -815,8 +838,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
                                       hub->eng_distance * eng);

                 for (j =3D 0; j < adev->usec_timeout; j++) {
-                       tmp =3D RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
-                                           hub->eng_distance * eng);
+                       if (vmhub =3D=3D AMDGPU_GFXHUB_0)
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_=
inv_eng0_ack + hub->eng_distance * eng);
+                       else
+                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->=
vm_inv_eng0_ack + hub->eng_distance * eng);
+
                         if (tmp & (1 << vmid))
                                 break;
                         udelay(1);
@@ -827,13 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
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
+               if (vmhub =3D=3D AMDGPU_GFXHUB_0)
+                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + h=
ub->eng_distance * eng, 0);
+               else
+                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem =
+ hub->eng_distance * eng, 0);
+       }

         spin_unlock(&adev->gmc.invalidate_lock);

--
2.25.1


--_000_BYAPR12MB2840DF4CC1B2F91382DC81DFF4779BYAPR12MB2840namp_
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
<span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); d=
isplay: inline !important;">Reviewed-by: David Nieto &lt;david.nieto@amd.co=
m&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 16, 2021 11:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 2/5] drm/amdgpu: Modify indirect register access =
for gmc_v9_0 sriov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify GC register access from MMIO to RLCG if the=
<br>
indirect flag is set<br>
<br>
v2: Replaced ternary operator with if-else for better<br>
readability<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 57 ++++++++++++++++++++------=
-<br>
&nbsp;1 file changed, 43 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index a5471923b3f6..2b86c63b032a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -478,9 +478,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
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
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(GC, reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(MMHUB, reg);<br>
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
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
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
@@ -489,9 +498,18 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct am=
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
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(GC, reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tmp =3D RREG32_SOC15_IP(MMHUB, reg);<br>
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
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; WREG32_SOC15_IP(GC, reg, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
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
@@ -788,9 +806,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: It needs to conti=
nue working on debugging with semaphore for GFXHUB as well. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_semaphore) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;usec_timeout; j++) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* a read return=
 value of 1 means semaphore acuqire */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_N=
O_KIQ(hub-&gt;vm_inv_eng0_sem +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* a read return=
 value of 1 means semaphore acquire */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmhub =3D=3D=
 AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub-&gt;=
vm_inv_eng0_sem + hub-&gt;eng_distance * eng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub-&=
gt;vm_inv_eng0_sem + hub-&gt;eng_distance * eng);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
mp &amp; 0x1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(1);<br>
@@ -801,8 +822,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(hub-&gt;vm_inv_eng0_req +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance * eng, inv_req);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vmhub =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(GC, hub-&gt;vm_inv_eng0_req + hub-&gt;eng_distance * eng, inv_req);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
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
@@ -815,8 +838,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,<br>
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
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmhub =3D=3D=
 AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub-&gt;=
vm_inv_eng0_ack + hub-&gt;eng_distance * eng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub-&=
gt;vm_inv_eng0_ack + hub-&gt;eng_distance * eng);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (t=
mp &amp; (1 &lt;&lt; vmid))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udela=
y(1);<br>
@@ -827,13 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
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
bsp;&nbsp; if (vmhub =3D=3D AMDGPU_GFXHUB_0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP_=
NO_KIQ(GC, hub-&gt;vm_inv_eng0_sem + hub-&gt;eng_distance * eng, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
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

--_000_BYAPR12MB2840DF4CC1B2F91382DC81DFF4779BYAPR12MB2840namp_--

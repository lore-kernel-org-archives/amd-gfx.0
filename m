Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BDAC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 14:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C0BB20C7;
	Thu, 11 Aug 2022 14:16:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1877B20B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 14:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi2fzfQ3YxhEQ7i9APqYOm32Axkrr2CDkE2dabuA3BUzQJiVkY7HdiADMIXOAOqyCcZT4hKJWxZvZ1Bz+7KyZE2dWFkJadzjiUg4Pdseh3IlYGiMR5TfMf2LoF5OgMuJTC/wtPeKJBRG4fUZbGNatHg0og0DShKcInL+OuU24S+seBfWA/MSnO3Ibuo2835BpqcZTjLVXgHEWOMOHtPkS8wRadqRRQGYZNy/h3/XP3dLtRFy+OF7HT0uXOAT2ATHVxdR8/td588hkxiZGOfnENLhgEis62dMs4dGuBCsx9EHGtHkccXnZTq5csWXeX2QAT6YzlcmnxHNYNN6eOD+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vin2AbDre2DB1gi6aPUjmsfSZS1IU/ME5ASfsXt78Zo=;
 b=M5JQ2jVKNvwmrY8ZloSIW700QdaiwloK7MqB7+Ekntoe1c2pqmmu94MiJ7kMVEFGjBuI3lZnqCWUh06ue4kHeZbwNI0FKGkmxzVi6lop8FA2JjJQR6np8tjl5TTp8tGHrPdMENhQynvJ5Q2Fyl9oK0aMjC1cZtBfxbRCmaE7C4XxtQ23/z3BpetdybuGgTnciAYKxBBbfoR4rJxPoauH/q7V28Ge0nuPdJC6zUjefOwbKc/KS+gKjzOC7MCpu22uBNmqpa2PP1XN6nn+zyJT4/TWzMeC9k4wpkyHSjjjw+iQaWpK9d3ZBuFzzSVdsi8f3+7MGQ8PlRl/HR9Sn8wP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vin2AbDre2DB1gi6aPUjmsfSZS1IU/ME5ASfsXt78Zo=;
 b=ouod8zVpoX5YIiAh3MMmn70NRMz2WjMXuolTcEeT9Tut2wk5tARPOrquHccspw5sP+VqRTsly7kT0YN/jx9BOwwe5ZJ9Rx9NbVG6Mfi6DSqlFFc9IbtNUuwPXtG3ThK/li13xrJE+dJ9Ua1Bx0z5yrIZGwz2Wh9t5ghTN/4MS8E=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CY4PR12MB1493.namprd12.prod.outlook.com (2603:10b6:910:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 14:16:43 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899%6]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 14:16:43 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov
Thread-Topic: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov
Thread-Index: AQHYrWlUGup9UUeQLkiVt4FYgaqm+a2puzuw
Date: Thu, 11 Aug 2022 14:16:43 +0000
Message-ID: <CH0PR12MB537267005EC57D1D8F969C7CF4649@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220811100039.122346-1-Dusica.Milinkovic@amd.com>
In-Reply-To: <20220811100039.122346-1-Dusica.Milinkovic@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9b9c58c6-07f7-49fa-ae1b-f8c6731ae9f7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-11T14:02:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7947f485-9f99-4ed8-422f-08da7ba41ded
x-ms-traffictypediagnostic: CY4PR12MB1493:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGkjsHgbMQY+Ld/tQv+ZU8n0LmQRsokf6Bq4ir0xdHwPS8sOWlAq+DuVUm2ylCuaM21Ja6djiF9sMNBhRCqcAVakyY4nrDUCd4ACaWOFl79bL7WPMXosZ1QSQ3MEbIYnq3fmfB94Sq/eEXAN4yvTY5LqYyYufF9Z+a2BCydda75WgKi9xIa4pmKi/QvxTOPVKOEGfVPHoGLzIJVJePqW5HesT63wAqKi/vVEGFBp7sKFsQYf7/0kvkvwuIUFFcYWn1u8tZr48lVi7Yd8//DhvOuO6uHJsx5pb1EeVu1I29EWfhlxtkwxN55p0tKv9k1NrXom106igsxGyeoerEkmRYho5jZv+43gDczCHtDvK7Awwqdkuhs/8Idbx9vl3jymxJLSrePNCoaXqLHGSVRy6MLuqXASPyLlquRC6DDco67v2sjy4pqGMqO/z3E6sMQT1iwV4HBnpAjTS0Ej7OacCx6cL4+npgeUETVlCljf7BXc1gw73/oltpfAlHt32MbDLBSScO1TQRGiLm0mymax+ZUrbZt/dJsV86xxH+l5wDIINmqiN0SinEKJ14eMJN1XLYSxLzJC3f/ixHE3iYI6AYQNdYew1uL3Yau83akJJjVUapzMxo2liZFseyza13NaXC9UBYuXbnt7o65XwDJXH4VmbozQmjoHvtfLvsxdfYa9CdJ+5HKfiXuPKjX9g8C6V9ayl8hFHqVpKwTNmvafEtfRQrcEglJp9WVlUnQan7jmBTbbNY6XDnvV5ocaoIcbiCQhkZK25IFKs50CYqwHaE5W8wUURTGUiJDgEivNoDuewUg2QbuFKWfOw/SbY3i2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(83380400001)(26005)(186003)(76116006)(53546011)(33656002)(86362001)(41300700001)(110136005)(7696005)(2906002)(316002)(66556008)(64756008)(66446008)(9686003)(66476007)(38100700002)(71200400001)(6506007)(5660300002)(66946007)(122000001)(38070700005)(8936002)(8676002)(52536014)(478600001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GVmbyJZzEXsrnnF/+gvEM8g7Fd1M9zcRzDKy+woOlQswDG7+fRzsZsDEVuVq?=
 =?us-ascii?Q?ELVSU79kqUFZMtxvK6PyDUEkzxUG6h1lEIHUnrUOKtq7r9bUS0UJUdlqFUsR?=
 =?us-ascii?Q?P7izi6i1sJZhw2K1L+o8gTDe/oRuztcsreHaljh2ovbpcmODwos44CUPaa5z?=
 =?us-ascii?Q?CeGBxBvfQZGT8n3Wa4M3DTH/DyZdadYOA+0hlbXNdYOWNNC/YEvmkpJbai42?=
 =?us-ascii?Q?sKPo4vWYvuqoPpLYw49Qm6MsFz+QUqrhCkJ1GIZz/TO0ocj2bWMQnLjyXO1+?=
 =?us-ascii?Q?VaxVseZofWa7Mm9FWfxhWMNf7L87IHFiCul7Zp+frYs+O3v5pnGjPP4cfszJ?=
 =?us-ascii?Q?ctCif3nqLJJla1RpGF70mOlx250SEh5BaP7k5ZcJUuGYM7xkgI3sBx7QCTkz?=
 =?us-ascii?Q?EGbIOtnEOYf4r7ZkyNIPEafSW/EfgC7AWlbtVAus9J9EZskOCPlm8Byn2lOE?=
 =?us-ascii?Q?69RFeVRWRDp2YRNH61Zkk5ZXFc5Mk3aAiH2jyhfi9CN8nfHJCskVFfyHphfL?=
 =?us-ascii?Q?Yao+55wr4QZR1jmWtZB0b4EgA5Y5UiJ/6cXdP5RdtctJe5dBIGorHuLD4I9W?=
 =?us-ascii?Q?lbEtMUJ4YkAKidHA4DJ/hHRQfeIFcDQe0c8IU7876xjPg8un/DmBNE8U8hEE?=
 =?us-ascii?Q?w9hrS9+xFTjtbhEnfmB0kDc9cpKz6la//YTdLw7Qx/2MbOprzL6B9PD05lO1?=
 =?us-ascii?Q?NY4GDqK+AIXfK9UDDqEQxsWksRJaWAvua8FfTa0wpQ/vtXKCsXrGK/NT1HW5?=
 =?us-ascii?Q?xjckWRldMCn7mrHWYw4QeLZrkTBKbVyz6y0mNQteeKBVZmqNoT1RIb/j9gOo?=
 =?us-ascii?Q?NF784oz28OrUtfrxTV/sg9eu3Ky1iN2oBjmB3bijWJPIz6HIVi8eq4NdZARv?=
 =?us-ascii?Q?kvjLth51dGtevCv8MSe/oAxhl/6uMww+4kyioyIdfEUiNNwPA75mM/uGqUmm?=
 =?us-ascii?Q?SeC6a1C+tFDWdwCqqtpm63ABjqRZ+oOQSqXzDvv/GMCz7eEF/afxtHx2qSFP?=
 =?us-ascii?Q?Zr+a86EJQw+G7ZobizGmuPvBSfUGf6GNDPPElNQC9L9KAVIcAN+/XzE5KLw4?=
 =?us-ascii?Q?+dO1Ubw/+BaSjc6mw+uslXocwXJU/7qa+0K6vl3JoR5Ry/W765fwJdqmmyGa?=
 =?us-ascii?Q?fe9BOUIdLJyssZFkkiizcJQ6FIsiEAz37c3etQQrqoSvTiQCTezlh7j2QyJ7?=
 =?us-ascii?Q?sWT68O/55NLupJkDQaXPyYjF6N02TxOdOxP5kyDBjvMUcsLeJ7gl9S0rcSRC?=
 =?us-ascii?Q?ujzlljbzKnte3h2Ux+6xGelmRsBFzXC5PzABFA06EiGoaxgiIt1/SxuVgk7Q?=
 =?us-ascii?Q?S4bhaHQ4r5OGMvuH/dvqihZ5PC59AfIjyxYSVKMTGnadxACKsfNgcS2ESYrb?=
 =?us-ascii?Q?qs5OhEw5KiZkIaQkBviEBU0zULReiiH4UbDkBhsC6nNYXxIc8TKeS8Lsibhb?=
 =?us-ascii?Q?mxSVNZhRmNm+idVZXy9WdHiLg9rf3jzV9UwRDwQ0VUA7zm2erKWzqPnUyuFs?=
 =?us-ascii?Q?YI6WNZDcdOESYY/H8vPEnrw7E3JgpQ5Oc8ZYILRL9xykT6Aml9+yDPY+AceD?=
 =?us-ascii?Q?Zd2/NRQv1oxfKn58yMY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7947f485-9f99-4ed8-422f-08da7ba41ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 14:16:43.2819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwS0t5NANPjcM4wJ77LAFKY74IY4AgeQxEy/DsKbmzDe3+3uuHKk5eFA2QvTT8gMgiEP2+YhXHSBPcdkh9uldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1493
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
Cc: "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

From HW point of view , the  maximum VF number can reach 16  instead  of 12=
 . Although currently no product will use the 16 VFs  together,  not sure a=
bout the future.
You can added Acked-by me.  I will let Alex & Christion decide whether acce=
pt this change.

Regards
Shaoyun.liu



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dusica M=
ilinkovic
Sent: Thursday, August 11, 2022 6:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: Milinkovic, Dusica <Dusica.Milinkovic@amd.com>
Subject: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov

[Why]
During multi-vf executing benchmark (Luxmark) observed kiq error timeout.
It happenes because all of VFs do the tlb invalidation at the same time.
Although each VF has the invalidate register set, from hardware side the in=
validate requests are queue to execute.

[How]
In case of 12 VF increase timeout on 12*100ms

Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu=
/gmc_v9_0.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 5a639c857bd0..79bb6fd83094 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -320,7 +320,7 @@ enum amdgpu_kiq_irq {
        AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
        AMDGPU_CP_KIQ_IRQ_LAST
 };
-
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 9ae8cdaa033e..f513e2c2e964 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,
        uint32_t seq;
        uint16_t queried_pasid;
        bool ret;
+       u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
+adev->usec_timeout;
        struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;

@@ -437,7 +438,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_=
device *adev,

                amdgpu_ring_commit(ring);
                spin_unlock(&adev->gfx.kiq.ring_lock);
-               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeo=
ut);
+               r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);
                if (r < 1) {
                        dev_err(adev->dev, "wait for kiq fence error: %ld.\=
n", r);
                        return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index ab89d91975ab..4603653916f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,
        uint32_t seq;
        uint16_t queried_pasid;
        bool ret;
+       u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
+adev->usec_timeout;
        struct amdgpu_ring *ring =3D &adev->gfx.kiq.ring;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;

@@ -935,7 +936,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,

                amdgpu_ring_commit(ring);
                spin_unlock(&adev->gfx.kiq.ring_lock);
-               r =3D amdgpu_fence_wait_polling(ring, seq, adev->usec_timeo=
ut);
+               r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);
                if (r < 1) {
                        dev_err(adev->dev, "wait for kiq fence error: %ld.\=
n", r);
                        up_read(&adev->reset_domain->sem);
--
2.25.1


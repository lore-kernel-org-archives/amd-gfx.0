Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805D5C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E0310E395;
	Fri, 14 Oct 2022 06:59:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACEB10E395
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAZALkGgfrKREGNsjuz3aVD7zv1lAktdkoEwXsyuoFu960VHnY7GGIGaxiYUSQSrBseRkJEEQhIKWCR209BSY1zFBqS4wP+qVqrgO3wtl9q/7axcxX308dna+a9i97KDnwX7MzA5day1z7TlkaJqI5tmYf39ggSDIdrbWNkrNahAHMnO7MxyDedxkhq0ESziGeUjlf3RmD9AUudOMRTVLp42BVKkolXqxbH2AtKSdvmHFgvCXgA7rBmw5YvVPSvBJo0KKN7Iq3ZUUQj3mxwEW1leAC9A1/USfqffAn8KTxCgmjC1bTx+rzJWFc7EPWMY+IaEeByULYrs/1jS41Wnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjscm7IXJdjnAT6o/Z+uo67JU9/TrPTLGbSBraZQtJo=;
 b=bwYCnciWBG4BbfowF+e2MNxhSh+Kb3nr11eHwSmX2x1C1l8AZDg7rttCDhY19CiuAB96NEqkyWa5yL+eyLpaqGgIhtiB2bnJ86eg91jdsH0cIRqo6L9lzbpwmcqe1XbdT5O1BkIiw5cRuCWyYSJCqKlbME1G1tqPyvqDV5Y/lN9ea6AE3KyLJDogzYX1rlGoaDYJvC9COU9FmpNi1ysHVRoKzZdfCGQbIPebS6pIY/sf4lomheSjwudzkg3cwOqlwHlH/+my9oGlA39qmfv9WODoV41UB+wwjYs/S5VSblZCxuX6itvkARD9L1JhyGLvcGL6l9E1aRgwrk7qUPSudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjscm7IXJdjnAT6o/Z+uo67JU9/TrPTLGbSBraZQtJo=;
 b=C7WJk0QGksJ4pE3qc7A7isPZj40nGFr8Ea3fiR1lx99ANkzPcQKO7sN4K97Ewh3N8VOF3Yh/6vh7lH+UX9nvDdYFk+AHzFjp0TtsrNHYnyF8r3ep3Fu+swaLDoVbcrqFsMjqf1CVdWFd/GaEP5u1NXe+uen4oIUXsdscBaFTtMs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 06:59:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 06:59:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Thread-Topic: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras
Thread-Index: AQHY35Tuob0a6FHGYkOp55/H3r0R064NdWiQ
Date: Fri, 14 Oct 2022 06:59:00 +0000
Message-ID: <DM5PR12MB24694BCA63275FECC1724B13F1249@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221014061918.21494-1-Hawking.Zhang@amd.com>
In-Reply-To: <20221014061918.21494-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: c10a721b-fab7-4001-1763-08daadb192b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzSQ4ETu8aC/0FqVKm4+K+hlKGqVF5DyudnlUUl8mgkoOh8yyd7ARgxS6ZH5ol1t+JHicFXUxMmQm8lUYjKUAYgQwESVz4M6srNaBpUfzke4u9zWhdapVUe3yLVoDeR0knv+vcO6Xg+79XLHNFlboHKiuu3TOZdcfiuxhskooy2phHVwU8H0Qe2oZSU3ZKumPQDY1o9FyalwcbFAw+OvypXENa7zuiK011iXFBnCMPRo+TggoVb0KwlLB6e6U4UeDa27MwGklUWdkJy3O7LdhJAECSUenc4+GtyeqMInN7u+ehYIRHU28CMvNYeMvG0t+6PK4o8YWyKMLoAm48+xnocZsm4Ig26XrbaUG1SdaMxAuiVOWvLecAW9eh8reXwbZpytlrUbNQMagSTYnipiItEG96XLQ0thF6RD4ss82MGE/rVpIqF9FEqQPsgqr1L7S9XQ655SnQXr4AChjSGgfY8atolswtoGcGiOyqrziVB3+l1YVbAmsbnfF4fXChJPIp2PCCbGjKS+H/+z2OHUnNE5vqL9rEjMfWJFStmID4B0oVbj6aQyryuC91zcRYR41gc8Yu9FD7hAwU9g/hjqjcu/adlmmBOjGjMuqfWjCLcRRc/oBrJv9rDS1PjfZPFHMM6eRw7y8FDubN/RNYpf/UOWKSBEsS8SUAIPq9FlGtnW0euDoeC+wBG/iIUS5tJIBO5823Fq8/AXkN9kH3sDo7xd8u2wFG4HK0dj3lGxLe0wC5FRFD9Jd1vtTH4Yfx5TQJQzIrhmWv7J/bnWqEkSoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(71200400001)(478600001)(110136005)(54906003)(316002)(6636002)(6506007)(4326008)(8676002)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(53546011)(41300700001)(26005)(9686003)(7696005)(52536014)(38070700005)(8936002)(5660300002)(86362001)(186003)(33656002)(83380400001)(2906002)(38100700002)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8mY1JzLEE+GelzUi/KAgWPBktBvC5QaG/ftRv2Ekh8DV9LtgZDbHY9ZufHee?=
 =?us-ascii?Q?L6R/1+uQ1abLoDZNax+wTpMygngSrFA4NjKFBaq+KskRwTRHKiFvEAPWaMBO?=
 =?us-ascii?Q?F1hLZ6Kdyw3Khu1f/WWlClxZrt6M0QNeLVr8gVfm7XVfIWxUE3899PSl44R4?=
 =?us-ascii?Q?gCYi9uHQCDVVNaR4QDfdip41DCl6CH6L5KbH/Y+4LYqmFqVWYAiLl/5giZND?=
 =?us-ascii?Q?FWIVhDsLp9BqlTzIJYN1BUPw6IekVuKsjib7tRfJpvN9JnHQRW9HUlNQMOCH?=
 =?us-ascii?Q?f9AP7jP/5ZSnH+/r4KEbZkxVPR+7dQRwrJqXQs1JYOu2K/vu9lfk9gpR/bhO?=
 =?us-ascii?Q?pNzSega6+1ccNkKV5o1knO5h1Jsvd4rT4Bbc3hYoOyjdDrZbeHXO2ioOAjOV?=
 =?us-ascii?Q?yXh0cUiNLFarw6YYYUg8KOCISIVSYaz+asaaF+FQixrOOTl+K0QBP09z71IY?=
 =?us-ascii?Q?Pm69UTxhRgiXD/EBT5S/UNud2/e1wI7tFye1pKaR5A2ws1ZrPHdNd7IfyoFq?=
 =?us-ascii?Q?fA3pk2n+hoLVLu9bQvSSN1qeeYHPeNQs0j66I2qEhlSVmGiFN5APBlB3ZSOS?=
 =?us-ascii?Q?2GNlf3sZZDhCTI9i0UVm7NrUSF3i1lIp1CrQs8HShg0ZRc0vChMzFkNbttu+?=
 =?us-ascii?Q?HhcvUbHRg8Vxm/uuQOtcMhCK6smHgXc/wYblK8/r0I19hXNf1xsokcI22L0s?=
 =?us-ascii?Q?tCiJpVVO21EGhCuy07sbXdpW9HU6DHXkJ0nH1s0/5qpyGQlU/eRHxrzhmBAY?=
 =?us-ascii?Q?ZdWXyqzebHijwPBKV0x1dDnRNa4cAfh45+M7cFTCjlc6mE0/j/kqvG0pKvYK?=
 =?us-ascii?Q?lQ5x50ygTLjgPGJQGvYMCE+ayQBFHBwh/aTroCi3gYYrKtB/lT58ITYRhM2S?=
 =?us-ascii?Q?qgMmLdbl1DBtX9GeNHsFmaxRbjSbKVmDrIQ/0bQuNrKBTMedrNveoDzLYqaf?=
 =?us-ascii?Q?NXxQpFqoAtscKUGqu0DeZ1Weofq0c7jXsREKJUn8CDx2vZP5dUjTKp3SdIrE?=
 =?us-ascii?Q?gbOm37aOy/553238v1fi7YSTEwMjsvpC+UbEnQNye+5qH2+tkTD+vmRxxXSA?=
 =?us-ascii?Q?yUZ9pLqjl7JrPYHzhf99GcxRLsHcLF1ghQ8jz0c9zyBt1TXLH6X2nq2CCQYX?=
 =?us-ascii?Q?/oO0L/gSTuGVxluCLpj/DsLkJyXODtFq5uk+1hVE7yFRQw6wJxP3QP+2MoQw?=
 =?us-ascii?Q?7ZBTA1DrU+7ue1549sJQDWDEQeVKH5BjjE/tI9dzSomGievFgH4AwYOlxZRa?=
 =?us-ascii?Q?Lvbr3WR9izh+3DTUHvwBYtLn1fgZEQmy/G6zY8kaBTPmxuMNLQvf/ucrfYp8?=
 =?us-ascii?Q?swNhWn4IyLU84iIeHhBQRekyCaAcW6kgV6CYrd0eV+2zQ75/JDQDzaRXXVMT?=
 =?us-ascii?Q?VSZlwiYr3bLnbuAMcXHUPgh7XCl+9J8Jm37K/6UogEONU0Qy3KOC9f9fxuGB?=
 =?us-ascii?Q?rwpgOqJKvTaeZJcQwxCEGDTGyk9WRigh7CUor7a0Wpj9tRWu96S20mU0JplT?=
 =?us-ascii?Q?z59GHFCL795oLYwtEuVRqAJGjW5YHziLqef2OqM/UHjINyIL29cecQoOSYUg?=
 =?us-ascii?Q?LznHI3koWVMSpnsuo2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a721b-fab7-4001-1763-08daadb192b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:59:00.8061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJGCKnZ/CT7/+mtPXed9Yu50lHWKV+KautsFlxpDc1t1LJKHMyV5fqZ4Cvobh0fRUZeEsKc2JWIrC74aiEXWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		return NOTIFY_DONE;

Before returning, maybe it's necessary to free err_data.err_addr?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Friday, October 14, 2022 2:19 PM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: move convert_error_address out of umc_ras

RAS error address translation algorithm is common across dGPU and A + A pla=
tform as along as the SOC integrates the same generation of UMC IP.

UMC RAS is managed by x86 MCA on A + A platform, umc_ras in GPU driver is n=
ot initialized at all on A + A platform. In such case, any umc_ras callback=
 implemented for dGPU config shouldn't be invoked from A + A specific callb=
ack.

The change moves convert_error_address out of dGPU umc_ras structure and ma=
kes it share between A + A and dGPU config.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++----  drivers/gpu/=
drm/amd/amdgpu/amdgpu_umc.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  7 +++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  4 +++-
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 75f1402101f4..ff92ea99d513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -36,6 +36,7 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
+#include "umc_v6_7.h"
=20
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2885,10 +2886,16 @@ static int amdgpu_bad_page_notifier(struct notifier=
_block *nb,
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
-	if (adev->umc.ras &&
-	    adev->umc.ras->convert_ras_error_address)
-		adev->umc.ras->convert_ras_error_address(adev,
-			&err_data, m->addr, ch_inst, umc_inst);
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_convert_error_address(adev,
+				&err_data, m->addr, ch_inst, umc_inst);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		return NOTIFY_DONE;
+	}
=20
 	if (amdgpu_bad_page_threshold !=3D 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr, diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e46439274f3a..3629d8f292ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -51,9 +51,6 @@ struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
-	void (*convert_ras_error_address)(struct amdgpu_device *adev,
-				struct ras_err_data *err_data, uint64_t err_addr,
-				uint32_t ch_inst, uint32_t umc_inst);
 	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev, diff=
 --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu=
/umc_v6_7.c
index 5d5d031c9e7d..72fd963f178b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -187,9 +187,9 @@ static void umc_v6_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,
 	}
 }
=20
-static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data, uint64_t err_addr,
-					uint32_t ch_inst, uint32_t umc_inst)
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst)
 {
 	uint32_t channel_index;
 	uint64_t soc_pa, retired_page, column; @@ -553,5 +553,4 @@ struct amdgpu_=
umc_ras umc_v6_7_ras =3D {
 	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count =3D umc_v6_7_ecc_info_query_ras_error_cou=
nt,
 	.ecc_info_query_ras_error_address =3D umc_v6_7_ecc_info_query_ras_error_a=
ddress,
-	.convert_ras_error_address =3D umc_v6_7_convert_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.h
index fe41ed2f5945..105245d5b6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -71,5 +71,7 @@ extern const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANN=
EL_INSTANCE_NUM];
 extern const uint32_t
 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNE=
L_INSTANCE_NUM];
-
+void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+                                    struct ras_err_data *err_data, uint64_=
t err_addr,
+                                    uint32_t ch_inst, uint32_t=20
+umc_inst);
 #endif
--
2.17.1


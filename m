Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16894D0EE19
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 16:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A3E10EBA5;
	Fri, 11 Oct 2024 16:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhI5vvgz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E45F10EBA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 16:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUxkGXvZcYgZH2t4c+bnOrmXAK49lJbOKe/RkHyvqiKSGQKNodudasS/JMSRmig3Xn8anuc8wbTD9h8tI0HKw5pEEUbTyvURP8pCGonmQ1BlzO0y2uH2FrcUzRsFB1LqMiG/vQhw3yUb8LmjpCaRhO7NUEa63ujxPwq5H8jYXi8g4bOLAXfBB/j7w9PSFB5ylqLLtMpgjO9+3RjRjPnvB7UuaM/LnWRwAqTVJ2bX1lYIp05RMB3cBPAbT+hACwnJ6GaAublr2VleY3qZCZbmWzD0N+xyV+CrkSyFUWXOKaVYjpQIPpCTHW/2UyZ1ynvmgEg64pAx4l07ycLrUI8BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0TSSpc7Ssm4a60k8lolpGvhTPIUjXUGsnx8sBYoq+s=;
 b=PrPjeH2TCR625XKJRG0ravQsNa+qDZ3uDmUjxUI6+F6pbGI80DSCfFCiTn46bi8vbN9HyNzhqvgkC7plCYHLbB8e0adLS14AkRgIYBLwWnTppmoZ7BXY9K1t51W426kbiU0UV8VjdwQgGbeHrpfvS6WV5dELZrllasB9Dl6IrbTRGn4PHxHY/GbSTZazOGP8ZxF1sHgjANGlAbZ8O1zujs3869pG5+uX/olAmbqC/imqfqtpnnrlenDsXVyV05UIj1Z5+/B50M+23ePhbn2efrCY6Tn9I+YnJYp+2qs8v9Mcep813b2uyYRXeQyVvYRaVh/DTSJtYZ0CT8jwRKO61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0TSSpc7Ssm4a60k8lolpGvhTPIUjXUGsnx8sBYoq+s=;
 b=OhI5vvgzpEZYw2D1dw6g5ES9nqox+UUdKUE25bvIdYniOXoBKP7+nWFuxw7lGhs0nffMiF7dBY3mitMXj1/FY9Aw6+zJJY1L6Te3vV+pimHOzO0rWJit9dCNi+qOCnZ8VZ0+sLaJIgxdQjqEBd1sOh8QroH+42nSsCPu5jmPKy0=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 16:56:37 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 16:56:37 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Topic: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Index: AQHbGy7vBz6yYsAPoUKecJDZCj28xLKBxp0g
Date: Fri, 11 Oct 2024 16:56:37 +0000
Message-ID: <CH0PR12MB537294897F02C7B52A8EAF6AF4792@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20241010161015.624089-1-shaoyun.liu@amd.com>
In-Reply-To: <20241010161015.624089-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1996c33b-d484-4ba0-96aa-068d3b890968;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T16:56:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|BY5PR12MB4289:EE_
x-ms-office365-filtering-correlation-id: 432acbe2-7b92-471b-ce6b-08dcea15abe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?u8UZ2yk7/QTr8qF146dgGrnDBeeXiNOzVhJW/WIwgNOx6udeotBOlMDpUyH0?=
 =?us-ascii?Q?hc8/3w1Gp5chrVzmQbbDMALYl4DNns5Ob0etqUiC1X+CaRzVkjofhmkUQQF7?=
 =?us-ascii?Q?aphAfP13dlW450uYExslYMkhiexhzk6cwvFdP5xu8F6UhuKcsKvJpueKVfvG?=
 =?us-ascii?Q?wtnG4bHZA30BL7i8uIJ9NyDh/AkLFKhc46R4uVd0wzpBXDMtR/j/LoKaibzX?=
 =?us-ascii?Q?jw/jTaRWu/DdhGwhbIq6DvgNMJJ6hwZ5WSVLnoTADk/RXuvlDXj0w0KOXRlr?=
 =?us-ascii?Q?F2ehnSXST/7QR+IXKHXAOg1lQ8pZYzZMWqG8e+VkHYqsfZbiwLMrCudjfYcy?=
 =?us-ascii?Q?cGZwgduI3X/P9KVDgGvGweTDbfzlEjDr6RwmYZq9wNNx74z7s491Ryt4OQ2f?=
 =?us-ascii?Q?ddK6TQgzbhGa9sGyaOSs1VMa2WDzl+HEWpCQwv87IqBAZT8wUDyy13ax6eR/?=
 =?us-ascii?Q?Vt6rJW+JIiri6rxpsnMVMzV/6o8/LefKepoiP6nprk9c2DIvFEi2ydMaITBe?=
 =?us-ascii?Q?U8wrJQds7PFJH2CXhLBmmH3vDkB+kWRShhtVXr3IPlrg8T78l7Auu2FrYFwY?=
 =?us-ascii?Q?zoXbPAnPwXYhVB7JhmKuz0Yg0F4MoztWOLYKfCALqhVyPIlaoxnh1tp5ShkN?=
 =?us-ascii?Q?j+H+0fjWfshVyx+zS6Y5+AT3ToGtPeEEXlc785kkYE6APRcOsgoqBx7GQ4MU?=
 =?us-ascii?Q?FqPTK0rviWyJAd1B8FizrDmPfmIYrE9pLFuBAoBzNd46ivZS5ZWr2fenXqs7?=
 =?us-ascii?Q?e15YRsBPs9KmNr/o+/jndwhUVtzPN8V0wQ03VT9wTN4vzY7ndz9eUSdoeHFb?=
 =?us-ascii?Q?/q/mUZj4eK4ytlRJ4A06kc4Tjss57HKnKUNonK0wUw2fQSTOPJ6R9ETZ9E2e?=
 =?us-ascii?Q?bjE3pkeEjXopoK/nMcBK/h49MCdcURdvm7qlfydLKBwUHe8twnhwNQWxezqP?=
 =?us-ascii?Q?ZfaLVGuFPhRqeB3PX+d9fccNDJZzLNlR/ma0Em5jIveWX8M28zrPylg/wOAC?=
 =?us-ascii?Q?E+xOSc1Hik8iMpZarFXig5MXso4gZ02PUy7q1+pNEvzENk37542SthvodKgi?=
 =?us-ascii?Q?U3ILi3Hwh+DDFirmpPMw8qVAfX+IX0JBlyTykg4KOiVGrMTCnuKAPAmPLKHp?=
 =?us-ascii?Q?mhcsDc9haCfHXjcys4YbzPaUooydr+O+18uVnnx4zxs+sPsd6C0T3KhPvC0b?=
 =?us-ascii?Q?CRUX2RfhB1sK73n7310BI3meGQ9dFlYEuYgWLfwVZx4SdTKmwN5Z0PmJa53H?=
 =?us-ascii?Q?aNo71kDazLkWGQTRNs7Lh2ZvmMPVrsDr45x6/KG/vVX5YCLhTwo3fcKSqB0s?=
 =?us-ascii?Q?ZkJ4ZyJxPrr/5AdyOjkonXquBhMuEfCPa4IjiueUL0VKuQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D4sOZKw3mjv/oKhZYxc8fB+KX0jaeIARzVYHJqv3jbsIIXW8BTzUwB0ha2fF?=
 =?us-ascii?Q?EN7pvPDiIXz6/IAyy12i4me/yZ5S3BY0ga4+tUwbIJSv7y4KSlBYzslJAAAW?=
 =?us-ascii?Q?ItQnPFLS/IGQp0JvNnfEgZ+9pUV4f5n784DZLy2gGNmbhx4mPTpuHVAxIlI5?=
 =?us-ascii?Q?wdFLwrpV1JzdiyE5HkuvL7yDkzjeVeG/SYj1OE4rt8NhxyJ6JnPuRErf5yTe?=
 =?us-ascii?Q?0p4iA8biFAte2tubmEVe5n39BOYyTmwDb/eLER7Q8FhXPDGJYbkadYNI4m8i?=
 =?us-ascii?Q?9kzVJYQPnvor+/sgywOcMEw324bX4REEW1R9q2NB0tkb/GYibq6SqpgO8Bjz?=
 =?us-ascii?Q?tZiWlbOY7oiPdGo6pyU5ahwPxEoV15qm3fNEFyABBqnANYPrFG3FRCIkqjEp?=
 =?us-ascii?Q?pmM+Rt3awCYt5TUtL5MIXXEpKFS+pa9YJrFwXvRUta8FhO33UMKzUafFb07m?=
 =?us-ascii?Q?j8CmIq9LWpwZgurUNLtWED4+GWJBmMnfdvGbn016x4q/OtFjONoGvw9mkSn7?=
 =?us-ascii?Q?B34lYSfbF53qzZQmJnLlhI3yznLHV+hGqsXeSpIRl+aYC4qA5w0q6XkTMAwt?=
 =?us-ascii?Q?9IkG4W9eucMIosnljN8YRgaxwexsFdKtBFqnalPpqHfTPhdgI2bpzPYOc6s5?=
 =?us-ascii?Q?GlzVNQ9ZuIZmtFxPB75fnIEX4QqYvKGmioZSgEQp/P0VeMr3WqjB+qF2r5N6?=
 =?us-ascii?Q?aqhJkDENcELiIA/F0IOFQLP384fMn8m7j+ucsvmwDdLPqUs4BHrg3nv6pPXt?=
 =?us-ascii?Q?T5F4feRs8fmyjZfCcFZs8E9+pKIVvPtFpElVliTK3X7goGB+FzmZ4udsVR8M?=
 =?us-ascii?Q?jw8WnL/OTuOSUNUWfsx9nqjZfHeCbthcyEjq7ccPA9jF7EPDmBpCCxwYTx9s?=
 =?us-ascii?Q?4zwJtfjLg/WWiVgz7D2q/8EVYJtD3r0dNclIuQiCxoq4R1mm3Fq+Wl1JqMJY?=
 =?us-ascii?Q?UQXdFm/bsSvE2y3EMYCtjXU7QkZo1JVreaW+2c9FbQPHRPE/+EHWw5Zg7exq?=
 =?us-ascii?Q?y7tvVNeSBdmwlutQsx3jj9zmxbed+0LTR1s+CMICXzYxgbXyLLo+buMXbRqR?=
 =?us-ascii?Q?GvDrOYsqlT+r/zYvNpJSYB7jM8vVNG3ZKJpr8VgP4oFLI3Un1/qZ321SeaAd?=
 =?us-ascii?Q?BqERI60kkwp5Qo9UJgV1EbNvfSwOdDetD1W8PP8XFIwoatGsx/i34TPt0RrA?=
 =?us-ascii?Q?1yMY3m/c+/LFGLNyAKHCV8ba0LVg+3CWeNAgYFlcRLUblhzvjbKWNWBK2X1e?=
 =?us-ascii?Q?la1+fSOnW9dDW5Spow+ycgVdq2cjK8g6woBb3ECQEsQko0oNP9rZUF0C0s2h?=
 =?us-ascii?Q?Bz4G9cSgGSdanVfk9ep70HK4KcF+svyPLdKE1wf3X57vPkLoOZ23HjFryEbG?=
 =?us-ascii?Q?GatemhF/YujdiUsgKgIPSkUVKCXW01C0vtsU/QCbokRnurUpef3+61SBEFE4?=
 =?us-ascii?Q?tbU4XGPiW7+fAZQmECG2ot7fN8bfyf/mrcYkQ7Mo24ID4i5ed0IEQKJacSyK?=
 =?us-ascii?Q?WwNYPyFCWgzdxz/dMF8vnbjMArgrzFF6frJMgunccU7022xCV3A5pbu5al36?=
 =?us-ascii?Q?HWEu5vxznXW7ZKZp6Ho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432acbe2-7b92-471b-ce6b-08dcea15abe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 16:56:37.8750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6JUwfEEUhTjqdvYjX7HodXX9i/wHxCCk5X9ph6L2f52c6EABdTWgDJfFq1Zx7567QaP32/HL/TpBi41S56uFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

Ping .

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Thursday, October 10, 2024 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch da=
ta

MES internal scratch data is useful for mes debug, it can only located in V=
RAM, change the allocation type and increase size for mes 11

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_mes.h |  1 +  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 +++++++=
++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 83d0f731fb65..bf584e9bcce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -104,7 +104,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)
                return 0;

        r =3D amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAGE_=
SIZE,
-                                   AMDGPU_GEM_DOMAIN_GTT,
+                                   AMDGPU_GEM_DOMAIN_VRAM,
                                    &adev->mes.event_log_gpu_obj,
                                    &adev->mes.event_log_gpu_addr,
                                    &adev->mes.event_log_cpu_addr); diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_mes.h
index 45e3508f0f8e..79f13d7e5e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -40,6 +40,7 @@
 #define AMDGPU_MES_VERSION_MASK                0x00000fff
 #define AMDGPU_MES_API_VERSION_MASK    0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK   0xff000000
+#define AMDGPU_MES_MSCRATCH_SIZE       0x8000

 enum amdgpu_mes_priority_level {
        AMDGPU_MES_PRIORITY_LEVEL_LOW       =3D 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 03bf865fbdd4..aa2e9ef4ff12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -913,6 +913,16 @@ static void mes_v11_0_enable(struct amdgpu_device *ade=
v, bool enable)
        uint32_t pipe, data =3D 0;

        if (enable) {
+               if (amdgpu_mes_log_enable) {
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+                               lower_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+                               upper_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       dev_info(adev->dev, "Setup CP MES MSCRATCH address =
: 0x%x. 0x%x\n",
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO))=
;
+               }
+
                data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, =
1);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, @@ -1375,7 +1385,=
7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
        adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
        adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini;

-       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
+       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE +
+AMDGPU_MES_MSCRATCH_SIZE;

        r =3D amdgpu_mes_init(adev);
        if (r)
--
2.34.1


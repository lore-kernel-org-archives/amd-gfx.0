Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7345CC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 02:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44C110E873;
	Thu, 14 Dec 2023 02:07:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1011610E17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 02:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+56BOTJni5KlyVrF+khOSbqaisXIoV5/oQFpUka6ktBQh4OTA8RjQqdav5bDh+IjJKmpIvSafF7pOyl+xrH+x0EMYp+yXPB8MfPSXn1XoIqGf9bCRXb5lzHt4IWh1lyXy6MKvw47AaM9o/Zck25tnRetq+WBDoCxuxnY138Y5sCXr1MaObGWajZs0E7exU27xPCNmfixt7D++ksLw4aPfjmqPSNtNZo3D50PGYRoFW2hy9cNVknBdKdC4b7YXx1FwOj7CWiUaOFuM0ljfi8rUkUFPx0CPjTAWsKhp0fxi8xvtPmMR3HvGcKiT2PAeM85tn16DRy7d2iFFBZeQpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiSw/xaAOWXXc0GJycEvvnCQulh3Tt7Y9BGSfNNgdp4=;
 b=PA/tcXGgShvM/2tTyziwG/ePUhhPe6M8r7ZV99gP9+8iNGII2ASWEwJSSGPWFYrZ6DPg63+0B5IrSvlF7x6xHsgtxUy1Yk8WULwQAJAKcSTyQzm3VNOyAVn5g+VOn2SP6D26TC7695kJ27rJMtXD+H0Qr5oPcWjqhI8COaN5LG+TyWReO8EeZekdjSIHCNR/+804PjjnGmajrBA6JRieu1oWVfYtSMkh6AZ4ICsVgQZQVHc2CspT/LrbBymS2LA4FZ7dN+w3Bsmi1gmtmS/f2BqjfqSFvW6lAezYx1HXMgjiZ1+uAS7Em+kQ3zdVZ2kMhg/KBdn6JALe0/XpDRyE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiSw/xaAOWXXc0GJycEvvnCQulh3Tt7Y9BGSfNNgdp4=;
 b=4vPQgOK0w78xHo9eOz7qf35Fa2ZBYSjfHIzXIMU1CmiCM5m0IvPiRwKhNkQfAnp1oCcAGPVu5FZZEw84+mIJg2pTX0Fy3Qo106s/tNuPvNgv8BANnjkmwgqv2pR8i8ozwHZ16Si5jkDTb4MvRrc1Xw9953N6WPSfXdEwhhIGHPI=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:06:58 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::7b2b:ed83:1f7c:7498]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::7b2b:ed83:1f7c:7498%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:06:57 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/vpe: enable vpe dpm
Thread-Topic: [PATCH 2/2] drm/amdgpu/vpe: enable vpe dpm
Thread-Index: AQHaLW7ME9xArjzRv0KoqqlpBQU8/rCoCUNg
Date: Thu, 14 Dec 2023 02:06:57 +0000
Message-ID: <MW6PR12MB8898E4EF96525EC46192931CFB8CA@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20231213024909.1384762-1-peytolee@amd.com>
 <20231213024909.1384762-2-peytolee@amd.com>
In-Reply-To: <20231213024909.1384762-2-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2355c29b-df38-4366-aead-40241ef073c7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-14T02:06:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|CH3PR12MB9147:EE_
x-ms-office365-filtering-correlation-id: 657d816a-5d99-4ccf-48ee-08dbfc495a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2TMFTNhGOwcCcnUL+8Th8aw8IdqbMpjdwZ2ek+45NrX+6ETkhssfQQdX8b8BE4Oc3WoWQPRxg3Z/XdP2hwbcTanzT6CpOcWQr8lNtyJN9gb7ia6W/V1Kh0QpyaYKcWrDs9gMuJKuSYWkRvLZvHDm0mdkAeZCC+N5+NEL3Dmwn3RmTmBYFwbrLfKIJ5yz8huNaJegZwLMSpRYfMOU16826jNxyaz9l39s3v1UARKdCsxo7G4BDzlev+D9baze1DMWrqWweAEKFnmn6fdRWkO7mHn7exY90QTrxzR7JdbW14DsntqyDh2z8F0n5DcYU/q87j2lqcMaQGS0gmFdcZhXVhGul3LXKkKltuu84HxWQdd9aNXi/Bzj7Y4njAWilE78GwuZUQClsjsh+f9BexeJxbFzhuS2BYpV5qIL/mshvl3KqsUsS8yM4MEyfzI8kDwZN7/qRso5RoikR6O/IpELYO362Z2O5I6DRa1TmgnWXvvGSq7pAj9WtivtsHapIBiWHopbiJN3aeXJKtN7De6cbEuHsUA0BexMJTsm/zqzw75sX2UKqspkTMT3Gpc6M0hUki0hRwBIyliHpfJBBcLl9NglqOZ3/6IaNi+KwVR1Ax5xKlk63doVsmzLtEjY4gy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6506007)(9686003)(7696005)(71200400001)(76116006)(5660300002)(52536014)(83380400001)(41300700001)(4326008)(2906002)(30864003)(478600001)(8676002)(66946007)(8936002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(33656002)(86362001)(122000001)(38100700002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UMzdOKRkQIMvkPuk9oG55z2S83DejtruIm7wUlUw9+Urvbu1B3vvusFn9Gs?=
 =?us-ascii?Q?xsoRkDqvJ7xz+/M73pG6EvgEvaU/6t3S2UKh+C5OLA2KjlYPPlRlZvZRskre?=
 =?us-ascii?Q?vGJJZgueHKGITDuAFp1vKhracTtctWBaV9fNyZY41bVleQJ+IoCWvpSvqkqz?=
 =?us-ascii?Q?8WEdoIhstq+Mox263Ty6xTCZlVxLaLozNoOQO0MhxucVPTbGyax8ymwsLRZE?=
 =?us-ascii?Q?9CN6wfggobC+zPAH64ErKuUcMxw/aMGHM0ts/AOqa5X4Z+aM7PLuBEgRKejn?=
 =?us-ascii?Q?RlaeDve05eHHBiOWToIv+PpXqvk2RzAgCH3Ou2xDMRX8HjFtZbLmGf2xd6TZ?=
 =?us-ascii?Q?IFlNim2c/SdI6dza6FJ/YgNQfWOgq2ML8hzDxB0LYyvsty5TMUwDA+IVHi47?=
 =?us-ascii?Q?2fDKmDv4ZnehoQw9cQFX28IcQoH06GHLTwZnQ6agSN23b5d9Uzv3ZrC4OxNH?=
 =?us-ascii?Q?BNPjIRK8lgwXev9xxEA5SJ48UOrGlKlzCusGdkW9Ojrzk3XN/pYDkTJ2ZaS2?=
 =?us-ascii?Q?8OkhCmLFuwJdjNbxpWAdeBVwXd5xSAEmZcKkE9u2prB+pO/7sdjOCzEh3m4F?=
 =?us-ascii?Q?puri9ks3XVqHUxctY2ugponFpffuRFBGo3iJMDWWn+SyrFbiroPYBUrrwWba?=
 =?us-ascii?Q?457wusKGpG1aKagjREAYGUwR4B8PNwpeg0l8MCjnjlswKLnRet/m9HspP2V+?=
 =?us-ascii?Q?s5hM1QhfhN4Ot6OGcB9Sx/M0XxbnfRZ0gpW2FmZt4hkh5Oit/KJAOiGbVuqO?=
 =?us-ascii?Q?nEeF3KxXtOf5L2LnGu75EhK8ZmmdVx/Cy5CAVR6fzz5D9rl/AG8IdBKqdxqC?=
 =?us-ascii?Q?EKsU2O9H17gTp7ToSX6dqIwGj2zW00Yiey4pxJj+kX4xxfUaGlGgb8qATBsL?=
 =?us-ascii?Q?FnGOoE2lRMGozsOXrWhFa+OvM+6FTYmsscdf6yrUN1bM2RWJ0eGMKHYqhGlC?=
 =?us-ascii?Q?yAw35nG/r+YY3H6OEl/rVzzleU0V4MwyoHfr5HhEDRltuy/WFgCJKyVpTXx6?=
 =?us-ascii?Q?qFJcWu7USPiVZX6/q71aERluNI2i4EWn6nrRHqwzp1YcnQpnGTxYR36DRcmY?=
 =?us-ascii?Q?tktJfVegklPmblw2FNAI+PRy/4JDPQtGY5y7/rxtEuYvSdtMHS5ygKW9St87?=
 =?us-ascii?Q?N7gowp+ahQfjP3TOCjWrFAKZjYwHvOGxZJwGnIPPYxu6cI1mEowSmdD7w59U?=
 =?us-ascii?Q?YPyZX1hm5EZdFCgRm+bxphXXiHLNKWXaTXTtsYdCGUe1FOQ0Z+d9v1OwMXVp?=
 =?us-ascii?Q?Cdz3qkbHF3c6bW5inSM+He59VYm6DsrnN4G7bMXSvH3ChLrmvKbIqhsv82wt?=
 =?us-ascii?Q?Co9hRuHikxAGOGgBrl7b3UW3dQkl87gUAhYXgjc0PWIOHUpuB0enFA7YBWBp?=
 =?us-ascii?Q?nyO9E8loinAp8+fpPJOOyjJaMuBcNxq03Ynsx+QB7HCaYjL9pKyPDDf4i6hJ?=
 =?us-ascii?Q?wWWeNUIm7Bcsh8cU3R+H7lY9suQo2Ew9ZhyPYiafE7As+UaurifaruFZDwQ/?=
 =?us-ascii?Q?TJOaKpJVVI+jwuMt8lSm5zTottEJBjQXJ4SiubMpRw7GyPvC7BX+m1PPol9Q?=
 =?us-ascii?Q?PnNDywQLowbTm+dWwxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657d816a-5d99-4ccf-48ee-08dbfc495a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:06:57.5867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZOaPnIJpGJ5NoZZ8N6hkbHhFh4S7hTUtIbZwnVfF+O4idhMr3jHjJ7lSvbyUfpElR92mtMBqSBgNvU74ZXcvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

The series is.

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: Lee, Peyton <Peyton.Lee@amd.com>
>Sent: Wednesday, December 13, 2023 10:49 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
><Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Lee, Peyton <Peyton.Lee@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu/vpe: enable vpe dpm
>
>enable vpe dpm
>
>Signed-off-by: Peyton Lee <peytolee@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 250
>++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |
>12 ++
> drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   |  15 ++
> 3 files changed, 277 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>index e81579708e96..2020ddb4182a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>@@ -26,6 +26,7 @@
> #include "amdgpu.h"
> #include "amdgpu_ucode.h"
> #include "amdgpu_vpe.h"
>+#include "amdgpu_smu.h"
> #include "soc15_common.h"
> #include "vpe_v6_1.h"
>
>@@ -33,8 +34,186 @@
> /* VPE CSA resides in the 4th page of CSA */
> #define AMDGPU_CSA_VPE_OFFSET         (4096 * 3)
>
>+/* 1 second timeout */
>+#define VPE_IDLE_TIMEOUT      msecs_to_jiffies(1000)
>+
>+#define VPE_MAX_DPM_LEVEL                     4
>+#define FIXED1_8_BITS_PER_FRACTIONAL_PART     8
>+#define GET_PRATIO_INTEGER_PART(x)            ((x) >>
>FIXED1_8_BITS_PER_FRACTIONAL_PART)
>+
> static void vpe_set_ring_funcs(struct amdgpu_device *adev);
>
>+static inline uint16_t div16_u16_rem(uint16_t dividend, uint16_t
>+divisor, uint16_t *remainder) {
>+      *remainder =3D dividend % divisor;
>+      return dividend / divisor;
>+}
>+
>+static inline uint16_t complete_integer_division_u16(
>+      uint16_t dividend,
>+      uint16_t divisor,
>+      uint16_t *remainder)
>+{
>+      return div16_u16_rem(dividend, divisor, (uint16_t *)remainder); }
>+
>+static uint16_t vpe_u1_8_from_fraction(uint16_t numerator, uint16_t
>+denominator) {
>+      bool arg1_negative =3D numerator < 0;
>+      bool arg2_negative =3D denominator < 0;
>+
>+      uint16_t arg1_value =3D (uint16_t)(arg1_negative ? -numerator :
>numerator);
>+      uint16_t arg2_value =3D (uint16_t)(arg2_negative ? -denominator :
>+denominator);
>+
>+      uint16_t remainder;
>+
>+      /* determine integer part */
>+      uint16_t res_value =3D complete_integer_division_u16(
>+              arg1_value, arg2_value, &remainder);
>+
>+      if (res_value > 127 /* CHAR_MAX */)
>+              return 0;
>+
>+      /* determine fractional part */
>+      {
>+              unsigned int i =3D FIXED1_8_BITS_PER_FRACTIONAL_PART;
>+
>+              do {
>+                      remainder <<=3D 1;
>+
>+                      res_value <<=3D 1;
>+
>+                      if (remainder >=3D arg2_value) {
>+                              res_value |=3D 1;
>+                              remainder -=3D arg2_value;
>+                      }
>+              } while (--i !=3D 0);
>+      }
>+
>+      /* round up LSB */
>+      {
>+              uint16_t summand =3D (remainder << 1) >=3D arg2_value;
>+
>+              if ((res_value + summand) > 32767 /* SHRT_MAX */)
>+                      return 0;
>+
>+              res_value +=3D summand;
>+      }
>+
>+      if (arg1_negative ^ arg2_negative)
>+              res_value =3D -res_value;
>+
>+      return res_value;
>+}
>+
>+static uint16_t vpe_internal_get_pratio(uint16_t from_frequency,
>+uint16_t to_frequency) {
>+      uint16_t pratio =3D vpe_u1_8_from_fraction(from_frequency,
>+to_frequency);
>+
>+      if (GET_PRATIO_INTEGER_PART(pratio) > 1)
>+              pratio =3D 0;
>+
>+      return pratio;
>+}
>+
>+/*
>+ * VPE has 4 DPM levels from level 0 (lowerest) to 3 (highest),
>+ * VPE FW will dynamically decide which level should be used according to
>current loading.
>+ *
>+ * Get VPE and SOC clocks from PM, and select the appropriate four
>+clock values,
>+ * calculate the ratios of adjusting from one clock to another.
>+ * The VPE FW can then request the appropriate frequency from the PMFW.
>+ */
>+int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe) {
>+      struct amdgpu_device *adev =3D vpe->ring.adev;
>+      uint32_t dpm_ctl;
>+
>+      if (adev->pm.dpm_enabled) {
>+              struct dpm_clocks clock_table =3D { 0 };
>+              struct dpm_clock *VPEClks;
>+              struct dpm_clock *SOCClks;
>+              uint32_t idx;
>+              uint32_t pratio_vmax_vnorm =3D 0, pratio_vnorm_vmid =3D 0,
>pratio_vmid_vmin =3D 0;
>+              uint16_t pratio_vmin_freq =3D 0, pratio_vmid_freq =3D 0,
>+pratio_vnorm_freq =3D 0, pratio_vmax_freq =3D 0;
>+
>+              dpm_ctl =3D RREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_enable));
>+              dpm_ctl |=3D 1; /* DPM enablement */
>+              WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable),
>dpm_ctl);
>+
>+              /* Get VPECLK and SOCCLK */
>+              if (amdgpu_dpm_get_dpm_clock_table(adev, &clock_table)) {
>+                      dev_dbg(adev->dev, "%s: get clock failed!\n", __fun=
c__);
>+                      goto disable_dpm;
>+              }
>+
>+              SOCClks =3D clock_table.SocClocks;
>+              VPEClks =3D clock_table.VPEClocks;
>+
>+              /* vpe dpm only cares 4 levels. */
>+              for (idx =3D 0; idx < VPE_MAX_DPM_LEVEL; idx++) {
>+                      uint32_t soc_dpm_level;
>+                      uint32_t min_freq;
>+
>+                      if (idx =3D=3D 0)
>+                              soc_dpm_level =3D 0;
>+                      else
>+                              soc_dpm_level =3D (idx * 2) + 1;
>+
>+                      /* clamp the max level */
>+                      if (soc_dpm_level >
>PP_SMU_NUM_VPECLK_DPM_LEVELS - 1)
>+                              soc_dpm_level =3D
>PP_SMU_NUM_VPECLK_DPM_LEVELS - 1;
>+
>+                      min_freq =3D (SOCClks[soc_dpm_level].Freq <
>VPEClks[soc_dpm_level].Freq) ?
>+                                 SOCClks[soc_dpm_level].Freq :
>VPEClks[soc_dpm_level].Freq;
>+
>+                      switch (idx) {
>+                      case 0:
>+                              pratio_vmin_freq =3D min_freq;
>+                              break;
>+                      case 1:
>+                              pratio_vmid_freq =3D min_freq;
>+                              break;
>+                      case 2:
>+                              pratio_vnorm_freq =3D min_freq;
>+                              break;
>+                      case 3:
>+                              pratio_vmax_freq =3D min_freq;
>+                              break;
>+                      default:
>+                              break;
>+                      }
>+              }
>+
>+              if (pratio_vmin_freq && pratio_vmid_freq && pratio_vnorm_fr=
eq
>&& pratio_vmax_freq) {
>+                      uint32_t pratio_ctl;
>+
>+                      pratio_vmax_vnorm =3D
>(uint32_t)vpe_internal_get_pratio(pratio_vmax_freq, pratio_vnorm_freq);
>+                      pratio_vnorm_vmid =3D
>(uint32_t)vpe_internal_get_pratio(pratio_vnorm_freq, pratio_vmid_freq);
>+                      pratio_vmid_vmin =3D
>+(uint32_t)vpe_internal_get_pratio(pratio_vmid_freq, pratio_vmin_freq);
>+
>+                      pratio_ctl =3D pratio_vmax_vnorm | (pratio_vnorm_vm=
id <<
>9) | (pratio_vmid_vmin << 18);
>+                      WREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_pratio), pratio_ctl);                /* PRatio */
>+                      WREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_request_interval), 24000);   /* 1ms, unit=3D1/24MHz */
>+                      WREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_decision_threshold), 1200000);       /* 50ms */
>+                      WREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_busy_clamp_threshold), 1200000);/* 50ms */
>+                      WREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.dpm_idle_clamp_threshold), 1200000);/* 50ms */
>+                      dev_dbg(adev->dev, "%s: configure vpe dpm pratio
>done!\n", __func__);
>+              } else {
>+                      dev_dbg(adev->dev, "%s: invalid pratio parameters!\=
n",
>__func__);
>+                      goto disable_dpm;
>+              }
>+      }
>+      return 0;
>+
>+disable_dpm:
>+      dpm_ctl =3D RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable)=
);
>+      dpm_ctl &=3D 0xfffffffe; /* Disable DPM */
>+      WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable), dpm_ctl);
>+      dev_dbg(adev->dev, "%s: disable vpe dpm\n", __func__);
>+      return 0;
>+}
>+
> int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)  {
>       struct amdgpu_firmware_info ucode =3D {
>@@ -134,6 +313,20 @@ static int vpe_early_init(void *handle)
>       return 0;
> }
>
>+static void vpe_idle_work_handler(struct work_struct *work) {
>+      struct amdgpu_device *adev =3D
>+              container_of(work, struct amdgpu_device, vpe.idle_work.work=
);
>+      struct amdgpu_vpe *vpe =3D &adev->vpe;
>+      unsigned int fences =3D 0;
>+
>+      fences +=3D amdgpu_fence_count_emitted(&adev->vpe.ring);
>+
>+      if (fences =3D=3D 0)
>+              amdgpu_device_ip_set_powergating_state(adev,
>AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>+      else
>+              schedule_delayed_work(&adev->vpe.idle_work,
>VPE_IDLE_TIMEOUT); }
>
> static int vpe_common_init(struct amdgpu_vpe *vpe)  { @@ -150,6 +343,9 @@
>static int vpe_common_init(struct amdgpu_vpe *vpe)
>               return r;
>       }
>
>+      vpe->context_started =3D false;
>+      INIT_DELAYED_WORK(&adev->vpe.idle_work, vpe_idle_work_handler);
>+
>       return 0;
> }
>
>@@ -219,6 +415,9 @@ static int vpe_hw_fini(void *handle)
>
>       vpe_ring_stop(vpe);
>
>+      /* Power off VPE */
>+      amdgpu_device_ip_set_powergating_state(adev,
>AMD_IP_BLOCK_TYPE_VPE,
>+AMD_PG_STATE_GATE);
>+
>       return 0;
> }
>
>@@ -226,6 +425,8 @@ static int vpe_suspend(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>+      cancel_delayed_work_sync(&adev->vpe.idle_work);
>+
>       return vpe_hw_fini(adev);
> }
>
>@@ -430,6 +631,21 @@ static int vpe_set_clockgating_state(void *handle,  s=
tatic
>int vpe_set_powergating_state(void *handle,
>                                    enum amd_powergating_state state)  {
>+      struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>+      struct amdgpu_vpe *vpe =3D &adev->vpe;
>+
>+      if (!adev->pm.dpm_enabled)
>+              dev_err(adev->dev, "Without PM, cannot support
>powergating\n");
>+
>+      dev_dbg(adev->dev, "%s: %s!\n", __func__, (state =3D=3D
>AMD_PG_STATE_GATE)
>+? "GATE":"UNGATE");
>+
>+      if (state =3D=3D AMD_PG_STATE_GATE) {
>+              amdgpu_dpm_enable_vpe(adev, false);
>+              vpe->context_started =3D false;
>+      } else {
>+              amdgpu_dpm_enable_vpe(adev, true);
>+      }
>+
>       return 0;
> }
>
>@@ -595,6 +811,38 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring,=
 long
>timeout)
>       return ret;
> }
>
>+static void vpe_ring_begin_use(struct amdgpu_ring *ring) {
>+      struct amdgpu_device *adev =3D ring->adev;
>+      struct amdgpu_vpe *vpe =3D &adev->vpe;
>+
>+      cancel_delayed_work_sync(&adev->vpe.idle_work);
>+
>+      /* Power on VPE and notify VPE of new context  */
>+      if (!vpe->context_started) {
>+              uint32_t context_notify;
>+
>+              /* Power on VPE */
>+              amdgpu_device_ip_set_powergating_state(adev,
>AMD_IP_BLOCK_TYPE_VPE,
>+AMD_PG_STATE_UNGATE);
>+
>+              /* Indicates that a job from a new context has been submitt=
ed. */
>+              context_notify =3D RREG32(vpe_get_reg_offset(vpe, 0, vpe-
>>regs.context_indicator));
>+              if ((context_notify & 0x1) =3D=3D 0)
>+                      context_notify |=3D 0x1;
>+              else
>+                      context_notify &=3D ~(0x1);
>+              WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicat=
or),
>context_notify);
>+              vpe->context_started =3D true;
>+      }
>+}
>+
>+static void vpe_ring_end_use(struct amdgpu_ring *ring) {
>+      struct amdgpu_device *adev =3D ring->adev;
>+
>+      schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT); }
>+
> static const struct amdgpu_ring_funcs vpe_ring_funcs =3D {
>       .type =3D AMDGPU_RING_TYPE_VPE,
>       .align_mask =3D 0xf,
>@@ -625,6 +873,8 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs =
=3D {
>       .init_cond_exec =3D vpe_ring_init_cond_exec,
>       .patch_cond_exec =3D vpe_ring_patch_cond_exec,
>       .preempt_ib =3D vpe_ring_preempt_ib,
>+      .begin_use =3D vpe_ring_begin_use,
>+      .end_use =3D vpe_ring_end_use,
> };
>
> static void vpe_set_ring_funcs(struct amdgpu_device *adev) diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
>index 29d56f7ae4a9..1153ddaea64d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
>@@ -47,6 +47,15 @@ struct vpe_regs {
>       uint32_t queue0_rb_wptr_lo;
>       uint32_t queue0_rb_wptr_hi;
>       uint32_t queue0_preempt;
>+
>+      uint32_t dpm_enable;
>+      uint32_t dpm_pratio;
>+      uint32_t dpm_request_interval;
>+      uint32_t dpm_decision_threshold;
>+      uint32_t dpm_busy_clamp_threshold;
>+      uint32_t dpm_idle_clamp_threshold;
>+      uint32_t dpm_request_lv;
>+      uint32_t context_indicator;
> };
>
> struct amdgpu_vpe {
>@@ -63,12 +72,15 @@ struct amdgpu_vpe {
>       struct amdgpu_bo                *cmdbuf_obj;
>       uint64_t                        cmdbuf_gpu_addr;
>       uint32_t                        *cmdbuf_cpu_addr;
>+      struct delayed_work             idle_work;
>+      bool                            context_started;
> };
>
> int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);  int
>amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);  int
>amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);  int amdgpu_vpe_ring_fini(st=
ruct
>amdgpu_vpe *vpe);
>+int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
>
> #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs-
>>ring_init((vpe)) : 0)  #define vpe_ring_start(vpe) ((vpe)->funcs->ring_st=
art ? (vpe)-
>>funcs->ring_start((vpe)) : 0) diff --git
>a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>index 174f13eff575..d20060a51e05 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
>@@ -96,6 +96,10 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe
>*vpe)
>               adev->vpe.cmdbuf_cpu_addr[1] =3D f32_cntl;
>
>               amdgpu_vpe_psp_update_sram(adev);
>+
>+              /* Config DPM */
>+              amdgpu_vpe_configure_dpm(vpe);
>+
>               return 0;
>       }
>
>@@ -128,6 +132,8 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe
>*vpe)
>       }
>
>       vpe_v6_1_halt(vpe, false);
>+      /* Config DPM */
>+      amdgpu_vpe_configure_dpm(vpe);
>
>       return 0;
> }
>@@ -264,6 +270,15 @@ static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
>       vpe->regs.queue0_rb_wptr_hi =3D regVPEC_QUEUE0_RB_WPTR_HI;
>       vpe->regs.queue0_preempt =3D regVPEC_QUEUE0_PREEMPT;
>
>+      vpe->regs.dpm_enable =3D regVPEC_PUB_DUMMY2;
>+      vpe->regs.dpm_pratio =3D regVPEC_QUEUE6_DUMMY4;
>+      vpe->regs.dpm_request_interval =3D regVPEC_QUEUE5_DUMMY3;
>+      vpe->regs.dpm_decision_threshold =3D regVPEC_QUEUE5_DUMMY4;
>+      vpe->regs.dpm_busy_clamp_threshold =3D regVPEC_QUEUE7_DUMMY2;
>+      vpe->regs.dpm_idle_clamp_threshold =3D regVPEC_QUEUE7_DUMMY3;
>+      vpe->regs.dpm_request_lv =3D regVPEC_QUEUE7_DUMMY1;
>+      vpe->regs.context_indicator =3D regVPEC_QUEUE6_DUMMY3;
>+
>       return 0;
> }
>
>--
>2.34.1


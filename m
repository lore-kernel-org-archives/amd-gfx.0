Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAEAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 09:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BCB10F39E;
	Fri, 12 Apr 2024 09:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x4fQfboM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B230F10F2BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX7f+Wu+gjmC+jrFd8535aOzmxMf99Mq2qkqX/PLDuNXpDpyKzKV0f8uT43uEW5/jpo6PMsgDwNSxdxiYPLuLP7kRDW0w0nX6ygOBwMr2vrjWa2WMBkpVSt2bYW/NYGc4Ain7OfZQMjtndCEc3s1/ddjjl4yOtt61Akowz6zSlT0taar77KN3mPcLwW8TC5EAxcqrR//yym2ZMh4Buv8WQRO20pvtnmnpiwpXakQzLo+BgIpLiknplbmXBUI8Tqje5A8Rg8YyIfMG4c229tsy6IDQcIjMjDbAQAAX4az9j4OmvQG8CW8N7KnUlnnC7oyKTjQKVxb/vQ3aupghwAlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBUlG2tHFwKFN+ncDj/Xg9nBhK1EYBJv44FIFhtldLA=;
 b=M0dw+Uzqy+su3b+FLS65CXKJ8EKtHiSj5vyehcXoS99KkwXuCgt0fqhA7wzln0YxE7d8oQzJET9xpRpy9j/JDu9RNEsKCGXXpDtGdQD2EB5OSp0/jSkMtpn0rWchFlJ//d7k/EXRKGE5nAa6K1LrLQrCfqtkkrOiLm10HAWTg0DbDO0Ck2bg96n2yohLbpHes7cIdkyO0pVjMedzk3m+qB37brld0vASx5z00l+gjLB3+vGSFv7BqRqPGCQXLLFCJs3UJozOU47PF/aOYBLlDohQHaAMIsbzK3N6DVdTFykBpPf/KRNvOd5JISYgLpsDtl4IJuQBuTf63lPEUwqlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBUlG2tHFwKFN+ncDj/Xg9nBhK1EYBJv44FIFhtldLA=;
 b=x4fQfboMU9QvlpsqrhJfr0rdXi/o7MpGLKTzBz4uiNyuWy2rAM8P7eIihhxSa3ZQQ8tTl3YomCTbw9gxiryuAfkMF62Z6K+Rq2tziIiRiwSx4hXsnzYIiv1e/TyvjieymNLnFFpyTUzoZwnp0psli5fsa6s//CVyPkhKWIQ3UWQ=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 09:01:32 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 09:01:32 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support of gfx10 register dump
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support of gfx10 register dump
Thread-Index: AQHajLfg3rZA6NdVxE+r75t4NTeTsLFkVogw
Date: Fri, 12 Apr 2024 09:01:32 +0000
Message-ID: <PH7PR12MB5596010031A15D73673D5CEB93042@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240412090016.10897-1-sunil.khatri@amd.com>
 <20240412090016.10897-3-sunil.khatri@amd.com>
In-Reply-To: <20240412090016.10897-3-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ff7f2af-ca00-4073-98df-27cdf99eaef4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-12T09:01:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|DM4PR12MB8452:EE_
x-ms-office365-filtering-correlation-id: 1f93cc03-822f-4b26-6fd1-08dc5acf2609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lDdACjBYAouxLIkMYFk4rEEQ3lm3oohnlHkLV2KenrLt08Tsl19N3maBhUn0/K8qUn6AFG2rpFSsASRRG8OVQUeH5JsYiFKzhFtYPhb3C8lJB9TlUwhs13SPUbC4Gr7rFv2AjDL2cWA06g1Z3IaNhk5fkvqJWGY7WDnOUdo1qpH+NwuNgV4x9oaXWjQm9yA2+lDGSZFmAWULsM2g/lnbPGGQ5l/VtYfn5ZLpyiyVGPFL3nke1XL9eKK4fxFhGfaJZL4GxzP8pLlXQt8TDnE5rBkWsHlnL9Wx9oSx3e9ZIhyb5m3Y7qnBBz9V5ooFigedVP1AhuEs0Y+Hmc+dIPhmn//3oVZZqMKGkG2kntE2znIT6EuBl2exNA/t8tP84StkUHd0N0pPlytMSDqmAqIP7UTY79CAiQv+uCs3hBYYREkOUclnWwaZxucJ4xL9yi7WNCGIG9wwUltGvH1fihoCQdKCoWh+NmBdCQkjYCbyIkzA830r4C+JnLNLgRvs0XHFkY4COJYD3QG6l8fZGk7zKr8OJrPb5mz1puMPytmFMEJ/VAeye5AbMnna8+9uA8F0mcCS2Ad4K+BNPqthT5fcfL7ASR7Kc/WQB6Osp097rqez6M+LBkIG77BH1bOoU6aeGK1rTUsSkiv/PEm4WRG5pzJRmc+rq66mGk2nPLV/IMciPaKO8/+uyzk2/UXSsQSg0doaAjvaPiuyFEcqIk9lmZbMzsHXJ3kND8vIDN2AN0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQxhvrg3eCi32U6CU7o50impZJpmGr4AmS+6YkCv4NiScGhlhmsp1QhXwPBq?=
 =?us-ascii?Q?pXqWTrwUTdwiE0fIXkD8eK/N36pfXcLyFEvF2dXK1kOtc1TovRth3GMZx1zg?=
 =?us-ascii?Q?Oj4kFvGQtIdVmZnQ6X1Dippl4FN7OG6+Xbv5nNFtnJjyvi4IfiMa/H0AnUG8?=
 =?us-ascii?Q?M/IbNp4YkyazVJPyB+dfrRLFg82nfghqCFmFBWoxu4qZNv/QUhevPFBcbIP/?=
 =?us-ascii?Q?2jQVGFlV9WrByf+9jcR0xnqHnYkR8minWRFoP5kVPc0boCqFwhIdjHMAi063?=
 =?us-ascii?Q?OdSBAdrNESE8RCRONisO/BpYXkcGO8Re/rd85ZDiC/ATNTIpXowSqK6/+j+M?=
 =?us-ascii?Q?Vc4VGleU/DWw0tTeZkF99wktCbm/Qu6VZxPniEqzhiepkdjX+Mf6etrZCxM5?=
 =?us-ascii?Q?WhYrjvbjVPy3rypzL8beG8Y09qVCjERjobIdhkKCeORNdiYBg+UNcLTg2AeG?=
 =?us-ascii?Q?uH2ppxp7LZhYrAl4O+0auYkZ1fNu3ii40OVLOe3eavv05FX9rOBra2ESbGTD?=
 =?us-ascii?Q?FXmG2m5mDulJFyNN0XliNnz+UyeFTWBR6403KbkwVPAsfBCNkSFARHbhRtuB?=
 =?us-ascii?Q?VThXqhxdu9bjxRF1463zDEmuQUk0BBN2dyXZkxEyX+0d5dffDUQMS8m/nvp1?=
 =?us-ascii?Q?PRpwV8/w+qv0u5ky+24gzwj/IzyU8qyNgNcxsF6bTHugvF3Jzm8hv9CJWPlu?=
 =?us-ascii?Q?AFkuJxA+RmyYHaEHIhKCYNPl6ikJJfmEF/fG0l/OUBZKs5J97zini9yc8sMu?=
 =?us-ascii?Q?N5jIrcKhI5/4bzmlFNHwqFWUl8l7Xr1/HphsrOd4nYzbM+97lNzBqL7uwAys?=
 =?us-ascii?Q?idqYhseQXa2MerWirZvxPox+yrU1PkCqqq+tgjvR6s7nPUiWMFeUz4VHgCi9?=
 =?us-ascii?Q?YD8Pf+JWXKF1wciM4ljjBR1qvjw75ZelMNWMN26UAicn0SmiRSWoxoDALVY7?=
 =?us-ascii?Q?p277m+Lb/TwcstCc7dXH1p3ceOrMFQ8tagGb0+4GuBw8ILOpRRLYMksfEf6B?=
 =?us-ascii?Q?xS7xDEVlR4IuTLr1bwIDGlbXlBES/C7TGeG0lmHBsg9w5j56yU3XdUQ8bgae?=
 =?us-ascii?Q?JFHXezr29lPV3548V7AafXjQClDA5zfZPGQPi6h1ezWZXvySAyJy/YkEuDpq?=
 =?us-ascii?Q?wV40istn5Lii0lGbBOZ6y1C5bN0j/MZi8+wkOJcwHy0Hfq/UEVHH+F9yYsRK?=
 =?us-ascii?Q?iE1KSaSbzBhNVCzCqvqF8lq2p69cp8R+a08s6L0hvwxL+3oBuWdx5GtHyd3b?=
 =?us-ascii?Q?WDmn+oZDYObwPHNQSCpvpzHCYtxBlEoOpD5laklkqahTThuHJ9Dl0ny9Xvos?=
 =?us-ascii?Q?1gXF4FQonrGiZgpRCjFlcWOvdscLRfiMDT4BbBqRV+/oLOl2LgB9Hk256XDf?=
 =?us-ascii?Q?xE9SSgjZIDluEw17UM0v0fuixF6Hs5PaHc6jsKV+rnS/dlhawhwdAYUmQEbV?=
 =?us-ascii?Q?6GiLuW3Fw0Gani1g+l8Y+zIzbG8iHi04ogCTNRkvGn+XpIFUSHyTB2t/3d4P?=
 =?us-ascii?Q?UgNGWkPaccmY9VShNzMo0SkCQlQYkshLxIHYLMbEsO7Y7rvHziZNsMviLtHq?=
 =?us-ascii?Q?9BNSQG8/7hCIABN2vfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f93cc03-822f-4b26-6fd1-08dc5acf2609
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:01:32.2104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6EP9Pt8iBmRmAbTPvAuL8i/MSWlpATsttnv3x3kjox47DextbmPk6Rf0Oh63avEKAJeLoU2wVI4EQal0osyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

Ignore sent by mistake.

-----Original Message-----
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Friday, April 12, 2024 2:30 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add support of gfx10 register dump

Adding initial set of registers for ipdump during devcoredump starting with=
 gfx10 gc registers.

ip dump is triggered when gpu reset happens via devcoredump and the memory =
is allocated by each ip and is freed once the dump is complete by devcoredu=
mp.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 ++
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 143 +++++++++++++++++-
 3 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 65c17c59c152..e173ad86a241 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -139,6 +139,18 @@ enum amdgpu_ss {
        AMDGPU_SS_DRV_UNLOAD
 };

+struct hwip_reg_entry {
+       u32     hwip;
+       u32     inst;
+       u32     seg;
+       u32     reg_offset;
+};
+
+struct reg_pair {
+       u32     offset;
+       u32     value;
+};
+
 struct amdgpu_watchdog_timer {
        bool timeout_fatal_disable;
        uint32_t period; /* maxCycles =3D (1 << period), the number of cycl=
es before a timeout */ @@ -1152,6 +1164,10 @@ struct amdgpu_device {
        bool                            debug_largebar;
        bool                            debug_disable_soft_recovery;
        bool                            debug_use_vram_fw_buf;
+
+       /* IP register dump */
+       struct reg_pair                 *ip_dump;
+       uint32_t                        num_regs;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 1129e5e5fb42..2079f67c9fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -261,6 +261,18 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, s=
ize_t count,
        drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", faul=
t_info->addr);
        drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_=
info->status);

+       /* Add IP dump for each ip */
+       if (coredump->adev->ip_dump !=3D NULL) {
+               struct reg_pair *pair;
+
+               pair =3D (struct reg_pair *)coredump->adev->ip_dump;
+               drm_printf(&p, "IP register dump\n");
+               drm_printf(&p, "Offset \t Value\n");
+               for (int i =3D 0; i < coredump->adev->num_regs; i++)
+                       drm_printf(&p, "0x%04x \t 0x%08x\n", pair[i].offset=
, pair[i].value);
+               drm_printf(&p, "\n");
+       }
+
        /* Add ring buffer information */
        drm_printf(&p, "Ring buffer information\n");
        for (int i =3D 0; i < coredump->adev->num_rings; i++) { @@ -299,6 +=
311,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count=
,

 static void amdgpu_devcoredump_free(void *data)  {
+       struct amdgpu_coredump_info *temp =3D data;
+
+       kfree(temp->adev->ip_dump);
+       temp->adev->ip_dump =3D NULL;
+       temp->adev->num_regs =3D 0;
        kfree(data);
 }

@@ -337,6 +354,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool =
vram_lost,

        coredump->adev =3D adev;

+       /* Trigger ip dump here to capture the value of registers */
+       for (int i =3D 0; i < adev->num_ip_blocks; i++)
+               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+                       adev->ip_blocks[i].version->funcs->dump_ip_state((v=
oid *)adev);
+
        ktime_get_ts64(&coredump->reset_time);

        dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT, diff =
--git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu=
/gfx_v10_0.c
index a0bc4196ff8b..05c4b1d62132 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -47,6 +47,22 @@
 #include "gfx_v10_0.h"
 #include "nbio_v2_3.h"

+/*
+ * Manually adding some of the missing gfx10 registers from spec  */
+#define mmCP_DEBUG_BASE_IDX                            0
+#define mmCP_DEBUG                                     0x1e1f
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX   1
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR            0x2840
+#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                        1
+#define mmRLC_GPM_DEBUG_INST_A                         0x4c22
+#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                        1
+#define mmRLC_GPM_DEBUG_INST_B                         0x4c23
+#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX             1
+#define mmRLC_GPM_DEBUG_INST_ADDR                      0x4c1d
+#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX            1
+#define mmRLC_LX6_CORE_PDEBUG_INST                     0x4deb
+
 /*
  * Navi10 has two graphic rings to share each graphic pipe.
  * 1. Primary ring
@@ -276,6 +292,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");

+static const struct hwip_reg_entry gc_reg_list_10_1[] =3D {
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
+       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) } };
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x0040=
0014),
        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8=
000100), @@ -9154,6 +9263,38 @@ static void gfx_v10_0_emit_mem_sync(struct =
amdgpu_ring *ring)
        amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */  }

+static void gfx_v10_ip_dump(void *handle) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
+       struct reg_pair *ptr, *gfx10_pair;
+       uint32_t new_count;
+
+       /*
+        * Allocate memory based on the no of registers for each block.
+        * Since adev->ip_dump is common pointer and we add more
+        * memory to it as we move through different IP's of the ASIC.
+        *
+        * This memory needs to be freed after gpu reset once the ip
+        * dump is done in the devcoredump.
+        */
+       new_count =3D adev->num_regs + reg_count;
+       ptr =3D krealloc_array(adev->ip_dump, new_count, sizeof(struct reg_=
pair), GFP_KERNEL);
+       if (ptr) {
+               adev->ip_dump =3D ptr;
+               gfx10_pair =3D &ptr[adev->num_regs];
+               adev->num_regs =3D new_count;
+       } else {
+               DRM_ERROR("Failed to allocate memory for IP Dump\n");
+               return;
+       }
+
+       for (uint32_t i =3D 0; i < reg_count; i++) {
+               gfx10_pair[i].offset =3D gc_reg_list_10_1[i].reg_offset;
+               gfx10_pair[i].value =3D RREG32(SOC15_REG_ENTRY_OFFSET(gc_re=
g_list_10_1[i]));
+       }
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
        .name =3D "gfx_v10_0",
        .early_init =3D gfx_v10_0_early_init,
@@ -9170,7 +9311,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs =
=3D {
        .set_clockgating_state =3D gfx_v10_0_set_clockgating_state,
        .set_powergating_state =3D gfx_v10_0_set_powergating_state,
        .get_clockgating_state =3D gfx_v10_0_get_clockgating_state,
-       .dump_ip_state =3D NULL,
+       .dump_ip_state =3D gfx_v10_ip_dump,
 };

 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx =3D {
--
2.34.1


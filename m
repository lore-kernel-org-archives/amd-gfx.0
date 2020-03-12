Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83649C4CECE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 09:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6E72072F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pcUsVUZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6E72072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B846E0E0;
	Thu, 12 Mar 2020 09:51:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C046E0E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 09:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtVtHmuvX76oQ7IZcnu9+Sh+DTgax7RiVFzik/sy85iqXHcuA/S/QhgdiF73PsXT2vi1a0fovqKpGW8oe5orCwopbVW84hco+53iZ17xDGAKSWyHNmO3L0V9jUYMX6IyYeH7dpmoZ3Lkn4mwnKqK4nEjMRhHDy4dHCS4t4aWeyTFq8ns2MkBxCpxUYWfaMP8kKBcu+7mEPl4MqLqaEvpOS+2U6Ia6ZCEbLeBWc5GLBmW6q/HVPbLRjlmzyDuhaXk2InJCUlUUzBSMY9f1rCRTuh1JB75GCniLG8hWv1BpVdNAjkeB3kPVRZSoW/a/C3QizF2o84GA8AhDNlvnAUp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT9F/HN+rh7BPqTFl8Vt2aM50V5ZtyuGHV71h2ihXgo=;
 b=BbOGvIWSqB40DpdzxR7rwEuI+zum3TGt5XFPd+DQPDPvJgzBuhldAS0XijOR509W7RkGxo7apbQ9aPmzTfJTXbLSNhZFdHPBLIMFZhXa/t7S1w8ZH9ZHAKGgxiYg/wAOXQqZ7kEu3zfLRFOZ8+QhmJviOeS1DCcrCNdwryMmbeDtBZOst43MbVUktJTFsGxZ4Ihdmh+5yqx2AA99qWRGiCp/qMYniWt6YTnp7y/XdHfGNJKGjqaJxmqUshC3KsRULxfezQOdVum+YXzomwuoWblAbb3Q8JRH1gVwMibJmCL1QsASE/+JarIFDg2wMFT3G48cdQv3uT2k/fVjKXw9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT9F/HN+rh7BPqTFl8Vt2aM50V5ZtyuGHV71h2ihXgo=;
 b=pcUsVUZPdEMmbNJ1C8HhIoYl2lfcfIALh7bt7MqFeTVewpfmtJ6BxsiWk2yPnIX9OGxPZUKm4w2W2Qz7XhpGY7rnQY70AhCJf9hbvOpSNrFgvn+ISTXDBrhTqFUJ1tjiJGYmP8Mro49hhh4DPqAAio5oT1YedM8duMN81+l96Tg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (2603:10b6:208:aa::11)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 09:51:30 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0%6]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 09:51:30 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: clean up unused header in swsmu
Date: Thu, 12 Mar 2020 17:50:56 +0800
Message-Id: <20200312095056.3921-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To MN2PR12MB3296.namprd12.prod.outlook.com
 (2603:10b6:208:aa::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (180.167.199.188) by
 HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 09:51:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55131401-8a5a-4a20-6321-08d7c66af08d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:|MN2PR12MB3294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3294C5413ADD150A7E88337DA2FD0@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(199004)(5660300002)(7696005)(26005)(8936002)(52116002)(1076003)(86362001)(66946007)(6666004)(66476007)(66556008)(956004)(4326008)(81166006)(2616005)(2906002)(81156014)(6486002)(6916009)(8676002)(186003)(316002)(36756003)(478600001)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3294;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va/4oNzCIIG3Fn6VHl1RzH+3pXnXQACHXATDhJUfZ7tBZSIoxQjruRl1r4h5rMR32/p/1y5RuGvydSOsx/POOsvgXrfupU78mob/yjwewkLVS4NQ1CVUZguHJ1Xx5xpPy0Ch+dK46eui+x3ScCh6MQQFoqjMtB5WybnCU9rRe0k0QSTgARs+Ve0P87fGX1u0sS9fgSfoABN5sV/U4Cg4yMEVt40yz5IqEFpIWj+c0KD4wtzbRH+m5UwxtK0lmgj+z+XZ29jGDcZPFuHdlUG8GoA44rQgezrgcbBFymS5uHJw+Xn91iYzHKG6znleurn/EF1ZDxYg3tTfIuqhu+7fhCCd+WkYXvMHEUNRj7YBwU2rzGigQy480x0Dgn55/LzVIorpV6AXJPITF4QSLbTpmmRmZseDB3ygLljgKtP/im0VejmoJrTMIE4DGocSP8yx
X-MS-Exchange-AntiSpam-MessageData: VERpvWsAjkHZg1Mw9WNwCuqzJRv84I96QHTQc2eTiAdAjF693WXe/PaJptsgFWCcGkisyajeGfAy0SHKIjHd0UEHYCxDBXD6CEnK/DmYmcvAiHuxFdN+ZDMRupX76C6mIkhNglvBzIr2RvL1xj3MOw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55131401-8a5a-4a20-6321-08d7c66af08d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:51:30.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WlMtPa/RMU/Hm9XgYG6yJ5hpERkQm1q+eW6H7X5GimaRljrENOJqcmeUbo5SF9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Cc: Alexander.Deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 Kenneth.Feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clean up unused header in swsmu driver stack:
1. pp_debug.h
2. amd_pcie.h
3. soc15_common.h

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 3 ---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c   | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c    | 1 -
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c   | 1 -
 7 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f18e3fadbc26..8de8436f0839 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -23,15 +23,12 @@
 #include <linux/firmware.h>
 #include <linux/pci.h>
 
-#include "pp_debug.h"
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
-#include "soc15_common.h"
 #include "smu_v11_0.h"
 #include "smu_v12_0.h"
 #include "atom.h"
-#include "amd_pcie.h"
 #include "vega20_ppt.h"
 #include "arcturus_ppt.h"
 #include "navi10_ppt.h"
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index cc4427ebf169..61596e8d522c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6e41f3c9ff1b..d66dfa7410b6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
@@ -31,7 +30,6 @@
 #include "amdgpu_atomfirmware.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_navi10.h"
-#include "soc15_common.h"
 #include "atom.h"
 #include "navi10_ppt.h"
 #include "smu_v11_0_pptable.h"
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 653faadaafb3..7bf52ecba01d 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -24,7 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
-#include "soc15_common.h"
 #include "smu_v12_0_ppsmc.h"
 #include "smu12_driver_if.h"
 #include "smu_v12_0.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3a5d00573d2c..4fd77c7cfc80 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -26,7 +26,6 @@
 
 #define SMU_11_0_PARTIAL_PPTABLE
 
-#include "pp_debug.h"
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index d52e624f16d3..169ebdad87b8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index d7fa8c02c166..49ff3756bd9f 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

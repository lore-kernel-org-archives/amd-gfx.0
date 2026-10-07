Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A85CA5FFF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 11:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138B510F506;
	Wed,  7 Oct 2026 11:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqb4Fagt";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4950210F503
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 11:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mucAU9yOjGQ6kk476qJMtDHIdgz4tx5FlU6Y62zaTKzyqbtrQNGZpfQ4AC+w1CWRMHYH88yW6WoOwXxX/3UL6nGofTE3yeKj4oAheSQUkQcPM4WskpGUPbsu85PijB64bf3DRDEwlvlHUp0PtPTQS3IfSslNct6qFDTDUIPos+M9qZAuMdoaJwR0Ej50qAMhIdKYSzbZCd1/Q2k9xaoQNGKpPBR91y9bCe1hN0DrVnArHWtU+j4vq2PMXftd6opTQZpsLLi1D6ybXT4jlbaOPizijqPKy+TJ4Wr7HQn3OMYEG7BdTLV/i1kvXKhXUIgiPYVwUrpRQyTvTDneDfzZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43lJ9VFpg+EgRoPLLdPbGeaO9/s2QUCQkoX92quksgQ=;
 b=DzmH+IJMuukqCQqMHoUjBTd3TTVWqUW3jtHYkw76z4UDwud/iNWEnK/yUGf+SSLZqDKzePOw90w1uhdluGrsTjzXw1iLYp+XxpdhHuZPMG3CD3wc1VBx4YiHK08l7z6ATS7BEjyjp4L0cUbkEtRtR/QIjEEYGCA9Qk/qT+EFyeFpez9kaQliq5w/ig+iTJ9LV08wU2G8u8LJPUwhB5uzcqrRAXQtgBQ6/ADpn6innWHW5/ASms5Di96OIxTDoqid9AnxxBGeoFFDkETAvdlThjalSnExyDzN14MpU3cUzH2HajguQ8zMHDrtWLk1fvwUETs9roD0v4dJnJnh15BHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43lJ9VFpg+EgRoPLLdPbGeaO9/s2QUCQkoX92quksgQ=;
 b=hqb4FagtApgsGbN7h/cS30rcfg8eyCSKtRrgxPBJFGVyRw7W+hDAryIqG+0+xGMvpNhEi1fBs4EuzdmducTjaOx+BXCaN++VXlFIdVATm7W7cak+/th0qXXHMSoot7dpvXRw9QQ3cqqltOyo60BQ9AnfQKTnY3KHKbhZ318p5b0=
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 7 Oct
 2026 11:05:38 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6d) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Wed, 7
 Oct 2026 11:05:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 11:05:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 06:05:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: Add interface to set debug trap flag
Date: Wed, 7 Oct 2026 16:35:05 +0530
Message-ID: <20261007110506.1065076-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
References: <20261007110506.1065076-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d4a17d-2943-4808-50d7-08df2462eb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j6Z+fQY5uhpF98BrKwYvmCCD323bvMvW74a4MdXf+/sT1qxKOpmna8XXgB7c3rAFagR21BPPFzerZpd84F9MK7aChzpY1o4e0TGfBHPEjO64d/mK/rtT9UhTOu3WsgnqluoctC68fljbstJsvba4/wdbItDaV1ZdKhcUdchT370VAWA6pJX9hL3z83QPKp43usfWVAYafwi3CZZ96oGJ5fnuzvjLKRkaqUnMg+vz/vA4zfnkvemuH3/oZqgsKSTCPsEgxIaruYB0DEtcUk46tS4Nbx0//VK8OoeNKHokJ9hkFglT//ekeTQXDk8M729ESpnEGHzzsSO79A0oc1d+/id6hzRmtpMKFJNapMpRX3wMpr0n5gUxoeXC5oDpDTM/cfvvMA6TuDVuUjhjkjEPhf0oJHh0oBgkxW2rXidPzWHIPdqg2wIzCJaDI4AvazT2v9ZWKLd7+ZerEkq4d9MQ2dexX3aF3eiV9WQfmG7WYXx3F7l/2Nlq25JY+cPVFWdSEJN1IKtitGAr82AAisU4tsBV321h/nvAatYUk+kN91e/0V4wRZr6eOCl1pkN2jyGeXeM5XcANEI8Dr7SY+idBKLAf5Jvl4GfdAULhAfj0CdgLTGy244HvLa+Tr2UNWBnXTAY6Tb+473TInyOBdaEvs395uqSyRJ3TMlu6Aoduk1m5zd02gOviLLAVEuWAyFLILphLJBFilpPieVPe36EHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ueTrFUrF359rqCCp8+j5UYyKu34GzQKhXvPOa8pNRCzZ7rqJsMud4pVh3CrC7N3AeLKjlaZDuhTRT1J3b9weyAeCVL73Bf0LguMeUC9BWWc16ydaZYedweXHB6JQCLxl6+h/jofauERvyoQivb31zYrxawY1Bu0rljk7z8fx3L5/rafsVw3JHkbMOA+uZqsTOjUFhrnzW+TMa97n3Pdo61ToW1gkQgCkFQh0ArCFMvM8dH++l4MHKk3Ktnx0Pa62ldexgdKwjY+rLA2dumQ8c5yZgGpavvZgtckPEhWX3rTTdLS5YNZxhELdaxadC9baAxeKzj4ThefJINCB4a0soICWYVfbOizCqpK+aUPzE5b5joIIlys7qj5K8LXbl/bb73ejY91blq9F9OUq/0UIRsQfgXqGuoSRZAqEftkpct8q7ZdMeHxBBhQihDuy6Kw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:05:38.5511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d4a17d-2943-4808-50d7-08df2462eb83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add interface to set debugger trap flag in TMA region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 1db74e1fc97d..836bb5e314af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -19,7 +19,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
@@ -636,4 +635,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 
 	return r;
+}
+
+int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+				    bool enabled)
+{
+	uint64_t *l1tma;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_obj)
+		return -EINVAL;
+
+	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
+	l1tma[2] = enabled;
+
+	return 0;
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 2cf485111e8f..06036954627e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -92,5 +92,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
+int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+				    bool enabled);
 
 #endif
-- 
2.34.1


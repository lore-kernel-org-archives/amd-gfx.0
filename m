Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8FECCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 09:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480AB112719;
	Fri, 16 Oct 2026 09:52:44 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63EE1126FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 09:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZbk4Isj0Ox65XjT1Ilu6ZgWKSjw/WPa245ZnwGiTgGx/rmefU20nXrAVDRryqR+oouujbvy+yidZG6+CNJrt5ysI55MFi9KRHNHy0cxXXkqwnWvqLqLwb4VirSUXD4VuJkl0+0hv2sb9EyTfASm5/5pOxGuYNdv6+zGKeEpd5q2zEGwJlL5K8Gpf7PNqe33Bpl2NC6vqiTZTm1VodFBWm6b+QDEGXt+T85nP4PuYiDk243JLLSojVAkzPtNF/l6k9iCRO2b5UB9s+59/tk7YJ1dzsmf9jxAClNk7E1r2+898ERHh/zHg5fMhG5v7ch0VTe6GwQO7/+5tUgWLw/Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/r/MjM7Hi07wl0NNWnzR4rIEZXgAmsXcwwcdvWAMk0=;
 b=VrCeGqznW7E4djFrYRWIErOOi6Wt9ByvRsf2rNKChcFipYfeC3QjTyEMJM7zzH80FEffqaNZMgIeTnUTZ1NddVFofb03CbZQxTLitMspSrjvtpaDGuoefAGI9JW5+cauyrvm9zmTCh+Tbi4++Cwi+OKsXSHf76esEoI/ueqgnJOYqYWgmMDzU87zZcbGR2wj5bopktt6nb/B8Pb446En/NUpxMF/89/WFwvCPYtKlilWA1sCaUzX63XtJTL9yScE14BdlpFeAkwq9IlbFmRtodfWxDJygTC6FdHmfEIsgBDmvNEdYIE+X997bOXrb6CejzlT+CKNKq0iORfLQI3X7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/r/MjM7Hi07wl0NNWnzR4rIEZXgAmsXcwwcdvWAMk0=;
 b=wF80cId972/b5hkV0fHOkxMCDbxBLu9GUYH5cMiXVQPAsegm+7F8qe2mvN56kBLSBNL371osx/0D4g1KmmhCuAC2yaEeUTKIiQsUYZtF5mjSUSKAvnU/Y1p4vqcTh1XwPsTrqVN1+bBCodVAiIwSsFt6TliJirP9WFcot3rrnTg=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:52:32 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:52:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:52:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:52:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:52:24 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:52:22 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF
Date: Fri, 16 Oct 2026 17:52:23 +0800
Message-ID: <20261016095224.461911-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016095224.461911-1-Victor.Zhao@amd.com>
References: <20261016095224.461911-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f1e51f-50b4-4764-dfaa-08df2b6b3270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aVgetajD3S6/Wd3h4T7x9Xu64pc7uzqM3f1Txh5rBh2ruW/DDTpBXRWDOxHkNT4Fj4NDsIIOE2YqQItkWjJcOe6V86dlkZulAo4/LtfwMwFFPnnRc4DH1q4xtxxMFzC7DaUvGGMHwygr443t7e799S+in5tQyAhpNE6wausndV40jkta3RD3q5yvCYBu6mOfgvTF6qh2Gn0C1qptx6gqgPTQG8LuSxLw22tZ8fekX8EQD0FobNm3v5Kzo/t4VxGN/zw6w3CElXW/ugKe1TWLaYCz/1IeTeRiCIOF+QxLVb4BzDDUGpiGp3eWYW4dZhxuGeRQfgROcbvr9oSG88WCDiw3fvXkyjd8GC2f0kTY/uwuEJB3XqJ0d8tgQarr/FANTssXEtHu61Dd3LX4SwG/isIQDqPQjH2HGL9TpMDVWLTnS/d9Ud3BAudBtYMYdvDNvpj/SbOSEWtvLIea/vFj10fenwsT0CkBJbUC40JEpv1QqTTBLh/3QU1nf2q8kl3AR+YGwKPdHzdJARhiCybXl0VwodRNx4HPUOKyzjedYR1jsLShfKQHFD0WXri/9QzskJdP+C1Dg3mEQ82o3mDJ2cuoPtPoflVmFX8i2GBGSUoAGPu1Cwq+p0hMSPvao24wvhWg/ZJ1ijaWB+uoDajC5hLz5GkCBun0Ub/SabRRm2DL+8VjvH4slxsgFt25vrAM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h/L8sUVFdc3is81qSHDF9uX1acRx5San3imF45wmnzMiGmB0vJIuDvhLHeWqdizqMWTKA2Uj/sm36UK+yYWmuV4lDbZVuobeWrXH1aTLfBM3QfrlPhyBAdjVQSOMKxCgk2JTwqfszHZZrae6fIQjn9YfVg1uvq7Gg16OeZ6iQUb0tma6PcBhQetn6iedQyCrPNQrPmrTlIAb99yuI/VJs6v9mb+gLYFj9z+OcQOv0xe65Xl79eM4BCCeX9Y7KPBW74qn0L/0PWyfxV9Ztf6FoNQk6tyU79ndIQp9tUScwq+/5vn4MpVGqRHVAbPL6k7rhTuUBoGRVvYiiXaeUMET4Tu8VPKge+rDdY4PPsTkaIFpocYdyPldf9yOkZooXUr9jSbb9JsJJhrPgbdPRGMzbSplZZ1fn2e1RZKAr2S87DYAnP7h4czW4Wq7jSHr2P4W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:52:31.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f1e51f-50b4-4764-dfaa-08df2b6b3270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

[why]
GFX12.1 VF timestamp queries need a SMUIO Golden TSC sample, but
direct SMUIO MMIO access is restricted on VF.

[how]
Read the consecutive SMUIO Golden TSC upper and lower registers with
amdgpu_mes_rreg64() on GFX12.1 VF. Swap the returned dwords to
reconstruct the counter value.

v4: use SMUIO Golden TSC for GFX12.1 VF timestamp queries

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d6f70d33201a0..93c8f8e449bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -37,6 +37,7 @@
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
+#include "smuio/smuio_15_0_0_offset.h"
 #include "soc24_enum.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_12_1_0.h"
 
@@ -3168,10 +3169,35 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static uint64_t gfx_v12_1_get_smuio_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	uint64_t clock = 0;
+	uint32_t reg;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+	if (amdgpu_device_skip_hw_access(adev) ||
+	    !adev->mes.ring[0].sched.ready)
+		goto unlock_reset;
+
+	reg = SOC15_REG_OFFSET(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	if (amdgpu_mes_rreg64(adev, reg, 0, &clock))
+		goto unlock_reset;
+
+	clock = (clock << 32) | (clock >> 32);
+
+unlock_reset:
+	up_read(&adev->reset_domain->sem);
+	return clock;
+}
+
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return gfx_v12_1_get_smuio_gpu_clock_counter(adev);
+
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->get_gpu_clock_counter)
 		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
-- 
2.50.1


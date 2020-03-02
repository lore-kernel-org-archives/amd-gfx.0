Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023CC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA55C21775
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="05zyNoYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA55C21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966066E297;
	Mon,  2 Mar 2020 10:34:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854C96E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 10:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gogNW9Khc8EuRb+QG5EQXdk4kxaHkgnK3G1t0yAQeGfbV8GoRzGeZOH5XY9/oZ7YXGKcJAxx1UK/rE05lZkCFs5QYSeURU7cS8zVlhSX7/62bCm/Kmr2HoKpqZkyJyKrTTTm5X5fxUzboXWO/ArhkzF450ObY2JYeE7MQq+EOnk9QcH2HObk/rdtQ7nO00I9N7hWvF6K9dyEvyQuq+czKMGHsHo5JiuGx0srHD+meYLHLMSAw3ZTfQwAcLAOulFwInOsgLLHJQWtr+PpyTL4j8xypPDZ7b1qKYsgYhDawEs2oVl4/LywtuueUi5Pgw6Hlg/jBps99ghWN7FOrXxA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8QWduOO5v94r5ZTmFTDmlJGNVzOO1nL93eeH/PQPDk=;
 b=fwb3PScaRfzMTHKw05zQwTj3Gmb/lfhPSgW78FxXfjOj1+OGNsL0CkDXXiO/mFI2QKAe9aVEgVKh0Wx6jZzKgAgVSEIan+It1nk527xjtKxAvxdHg/8itvY1YmHyr5KvqV7KTuQOTTUOLnrluL9jypi9ZLyBoFzmifqnpniVGD4uslcMq5Ps/J3Oqbu9stTR8DwO0ZkEOhAFi4HVRTwCbwJYjxqy09XcyZixfrDUBCFTre5A294fz2xVMSPtGa6QOQ92sI0iFNOve38G4DdwEURlBQcN4IBGMGx8HZxwhDZEeyf846+DD1iTawfwKbjJhiugWu2ZB2W8KyAa7nblAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8QWduOO5v94r5ZTmFTDmlJGNVzOO1nL93eeH/PQPDk=;
 b=05zyNoYkGewwlGaXT1xdkGSUDXqG26lw2xuOB/D2Z5vtdD9Snpf4oxajBc9hyE3JaB13uIJmMVf3pQAeH5R20/Zy62junLpsb9I3XneMLRapoupzRnkbq//H2GRCndCiPku3KsPqPQ1TYZpvKUcIF8nSCo8al0Zf+YWtV5+5ryU=
Received: from DM6PR17CA0008.namprd17.prod.outlook.com (2603:10b6:5:1b3::21)
 by MWHPR1201MB0125.namprd12.prod.outlook.com (2603:10b6:301:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 10:34:31 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::8) by DM6PR17CA0008.outlook.office365.com
 (2603:10b6:5:1b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 10:34:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 10:34:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:29 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 04:34:27 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Guchun Chen <Guchun.Chen@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add reset_ras_error_count function for MMHUB
Date: Mon, 2 Mar 2020 18:33:37 +0800
Message-ID: <20200302103339.31723-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103339.31723-1-Hawking.Zhang@amd.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(199004)(189003)(1076003)(7696005)(356004)(6666004)(336012)(2616005)(426003)(36756003)(5660300002)(86362001)(70206006)(316002)(478600001)(110136005)(81156014)(81166006)(6636002)(186003)(8676002)(4326008)(8936002)(2906002)(26005)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0125; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b671c86-d993-43dc-4094-08d7be954ab3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB012585FC0D279E2A0307E980FCE70@MWHPR1201MB0125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsLOTeWn40b5vomAm+2N4mB3Fkp+9RKFlT2PCw1VGtXEu0cKzurbOGl0bdC7TuQfL+LkVAx0sbH/Molh00XwovI0vGV6BseHHic/op2F4yrKe/+/lcPrk59yKojeT4GEURsAPitg9FiV8fZuCtel7/TvIkIDqIc8LEgN9T851SdZv+E2KRl8g/VRN1RDx1BRJT0yx7WCDB/R/6mSTYcQLgPY4hGQiYCPkIoWEJQJDAAnp9jCGKSP1l2CLwj9Iv6iaa/C9xLhx6cIdbB9syRkIarCym7uet12k1GpDvxkQYMsOKvq3EKVRLRtrlzlA5JhW1NsGk6Wj1zOxdQ+2bAxzcTfk1p0IugbK5DTSB1G253hQgAGIhZbg9cJVnhkZthnkcbzsYwkzBW+a+1wKOPkW6JKvqDuvnEkG+PEJ96oaHYTO1nC/BSzddlh95cvuqYW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 10:34:30.8041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b671c86-d993-43dc-4094-08d7be954ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMHUB ras error counters are dirty ones after cold reboot
Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c   | 12 ++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 1cd78940cf82..e89fb35fec71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -26,6 +26,7 @@ struct amdgpu_mmhub_funcs {
 	int (*ras_late_init)(struct amdgpu_device *adev);
 	void (*query_ras_error_count)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..d15a433af699 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -912,6 +912,9 @@ static int gmc_v9_0_late_init(void *handle)
 		}
 	}
 
+	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
+		adev->mmhub.funcs->reset_ras_error_count(adev);
+
 	r = amdgpu_gmc_ras_late_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 49a3a56ec017..396c2a624de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -747,7 +747,19 @@ static void mmhub_v1_0_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ue_count += ded_count;
 }
 
+static void mmhub_v1_0_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t i;
+
+	/* read back edc counter registers to reset the counters to 0 */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		for (i = 0; i < ARRAY_SIZE(mmhub_v1_0_edc_cnt_regs); i++)
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_0_edc_cnt_regs[i]));
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
+	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index a5281df8d84f..0d413fabd015 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1596,7 +1596,19 @@ static void mmhub_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ue_count += ded_count;
 }
 
+static void mmhub_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t i;
+
+	/* read back edc counter registers to reset the counters to 0 */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_edc_cnt_regs); i++)
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v9_4_edc_cnt_regs[i]));
+	}
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
+	.reset_ras_error_count = mmhub_v9_4_reset_ras_error_count,
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

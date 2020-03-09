Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C82C18E5A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91F420674
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NNevJMJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91F420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AF2899A3;
	Mon,  9 Mar 2020 09:12:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BD0899A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 09:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK84CdeDS0W2t5wkUzFdap06wwc1WVDwdRrub1w7SKu/2FcEe5JexrYUjYu1clKIzYVFwLWQt9I5FuFlGphoEgWSRJQ8lXhUUwEnwdW8sV3ufldqdR8Shw7xHLUjb3946coo7nnVeuT00Fs4Co3FFgEK45kORs7dASmYd+Ha2Kd+DkGkrytwEm1w0jry2D83Tr8IJZD3RT+NM8MdB0zUCJJq9xudp90kpBpBBv/j7hMEwyXGUwb0nlW9W6fJfeBTz7EPy9JvwZ/y97tOHB9ypkZ/hKyYKOfxgUQKePn3VKNncVcR+DcSLoqQNrK+O+pPs8uWT/klo63+dgihLrGO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwWoHdt+6VgRIphTkTYN5Ppb3EW7OQx6+mObomYGAEU=;
 b=Y9VrSG5SEMK8aEDT1jC+XxCCsm8mMnSxvGPEs2fTV3KPIJaV/2xeJFgBzwy0es7PgtAHTKnBxePy0Zyv3f88zEM8IQ5FnodM1DjuRCamaG0auqXWKnf4JOfOc57Hk7TgVY98aDLKL/M1u+CXNgWtOAOjIRPRtn65LzI1qbv+2IkiVBsxnBHxb+nXQVB2eDIOzVdHFOQi1Ema/UFLqpwJ4hu63WrLElhOxy0fv+ZAqAJvFxvqueYlZqfEVywiBmwcMEOHZ6tUDRqIeuDLJdVWhwXyWHxTmSln/5y5CNDK5ExwS1vHc0lmTxFS9YPzmPozidNzyNB8rpwkXaqtC4b9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwWoHdt+6VgRIphTkTYN5Ppb3EW7OQx6+mObomYGAEU=;
 b=NNevJMJL9Aus0JADki0poOV2De1QCjr+N9lLuPrRBoU0xaCP7Ymw9PT+ajs1hI0tGh01O1jggReyApz0dQrEZlORP3lAEgY0ra7cQULM3P43h2WFg0bidg4o3BqHkeqr+y7JfULJ/Aa31VL3hvITnbgA98KoDPSI0EgtGVI9UhI=
Received: from MWHPR19CA0058.namprd19.prod.outlook.com (2603:10b6:300:94::20)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 09:12:20 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::80) by MWHPR19CA0058.outlook.office365.com
 (2603:10b6:300:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Mon, 9 Mar 2020 09:12:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 09:12:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 04:12:19 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 9 Mar 2020 04:12:17 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add function to creat all ras debugfs node
Date: Mon, 9 Mar 2020 17:12:14 +0800
Message-ID: <20200309091215.26768-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(199004)(189003)(4326008)(36756003)(6916009)(81166006)(81156014)(356004)(6666004)(8676002)(8936002)(70586007)(86362001)(316002)(336012)(70206006)(2616005)(26005)(54906003)(186003)(2906002)(426003)(5660300002)(478600001)(7696005)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2519; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27542077-37c1-45f8-d67e-08d7c409f8dd
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2519397D844A850D07B2FB769AFE0@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0337AFFE9A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3uJae16LFTxM/CN+rHrXD1BHy81M+y+ak+U4Fqhoq68AvPlMAE7YsQg1XNrEbWKFoEHeepkhCLp378IVoHc/gmW3yoe5jRQ5tkzGtzhnTlPK+GgkS1iYPM0xBjtHnUoP85eTsjqup7f/iwhemG3DzkTwsNBJwYwg1RTRoTZ1tNqPUCKP0lFTEYdj3sO2YZsMA40H78sruTXQDTBNraqaL2d/3g3JCJaR5xqzUNcNQZK9Q7FIeBO9n78lWwt0DflbZPdmR7zwlmrjB9ix3VwZgjUT7oePynaT/LrmZu9oFccvr/TjzynthP8oQ1ghas4HYh41UyLBWawHSXaM928V2Kk1AF0caIkvqZgJburfAZ4zz1YuMGrQDIY87yGypWM0mc4TJSQhsJzlHK5UEskdWdag4hw/+2Y1rRw4qbzH6iJXp+j2Bqkgbg2p8PZevXD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 09:12:20.3623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27542077-37c1-45f8-d67e-08d7c409f8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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
Cc: Guchun.Chen@amd.com, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, john.clements@amd.com,
 Dennis.Li@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

centralize all debugfs creation in one place for ras

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I7489ccb41dcf7a11ecc45313ad42940474999d81
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 492960e7d5f0..422cdd1ce3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1117,6 +1117,35 @@ void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 				       &amdgpu_ras_debugfs_ops);
 }
 
+void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *obj, *tmp;
+	struct ras_fs_if fs_info;
+
+	/*
+	 * it won't be called in resume path, no need to check
+	 * suspend and gpu reset status
+	 */
+	if (!con)
+		return;
+
+	amdgpu_ras_debugfs_create_ctrl_node(adev);
+
+	list_for_each_entry_safe(obj, tmp, &con->head, node) {
+		if (!obj)
+			continue;
+
+		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
+			(obj->attr_inuse == 1)) {
+			sprintf(fs_info.debugfs_name, "%s_err_inject",
+					ras_block_str(obj->head.block));
+			fs_info.head = obj->head;
+			amdgpu_ras_debugfs_create(adev, &fs_info);
+		}
+	}
+}
+
 void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 		struct ras_common_if *head)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a5fe29a9373e..55c3eceb390d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -592,6 +592,8 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 		struct ras_fs_if *head);
 
+void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
+
 void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 		struct ras_common_if *head);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

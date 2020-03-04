Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3B8C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8144E2146E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T126Dr7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8144E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3656E079;
	Wed,  4 Mar 2020 16:23:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24826E079
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw9ZWOzeKr6zodRJojIr5MW8CO2I+xPqqrzpx4ge2S409qSrRI6bwj/v9EnvGGhpx7hTHIsCpccVrZgAdNKNUodsmwHhxj2QCAvOpbhDELX0TIj3eHX0tJ1OfZmrHGWye5mu9G59KEdEsqx54j8s/OLw5ZlJ+eh9xsBef4jg/bBJo0+FjKAobGkDem/1kf1MlkTDGy9aAMV4SYk6nLnLUklvAbKtf0VO5X+C6YvW6EdvQOSKDUp5mJ+hGI+LVsPc+ISkbdGe/IIyVuQVl4QqNTILcojggr4Uokkg9dCmckYD9kcDMG9Qv6sRz5JW/m0qQ47IabtVn3ZRXzeYPt44Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=n6PQGTJFnyayMOrQUBP2KB+2Dchm46paNBtmXcIgzN4kl0dh0G6/YXRrf2A/Fbhwt0FK2RI6rjAuJaJPrWuf/6/FwpoVMrZDM3cMEd+tBlOxq+x8y9ekEh2/rcAb2otObwaSaYs3eNQ4le7wg2iy5n+WXeipHjxd2yU9hhguxLgO7AGZBY2ts/WeUTf2t2FRYM89tHsy1Hb74Q7C2GpUhZyYGEahX5w3uxkluTVm8/fpu46I5tw300nmM6zNPajIHt06UAwqlpNLffXaW/yQHqJiCV4hCwwm76I7H8G8kNo3AT0HuMNCEHzp9dqmVcXVLsem/cqiNWJKSy44hBo3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=T126Dr7hGK9IZpdkwCIajr7BoQ5SYgPNSYheZ3Ep7Us+3p+8GYVCKO9Sv7tyoxAp+q7p9gZakwRusgt9mp2DYuVwT97pAd0nHjrOnsECEIki/IeiSuWZh7WamgIZHEMHAMXuNabVyqOM7khuw7ZX6HU65jpG+1LDpYj4TRsiuY8=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:23:45 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::10) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:23:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:23:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 10:23:44 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 10:23:44 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/3] drm/amdgpu: Add USBC PD FW load interface to PSP.
Date: Wed, 4 Mar 2020 11:23:39 -0500
Message-ID: <1583339021-12298-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(199004)(189003)(8676002)(6916009)(86362001)(26005)(54906003)(81166006)(44832011)(7696005)(2906002)(81156014)(8936002)(426003)(186003)(6666004)(2616005)(336012)(356004)(70586007)(498600001)(4326008)(70206006)(5660300002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1806; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0820826c-c426-4b07-0549-08d7c0586920
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1806192FD5007AAADDD033FFEAE50@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk2bJxW7bOTEhe7C8N8AluxS2B9G/4TjMd+l/AsIh4Zfo4yuvli1c+M6y7CVGaa0vq51OUxdYy4p/O3kIESRClqqw2+H7eG3rqX9gMia2Loyl8rYUe5m854A0uKbutQGmtYxL5N5JKWI4knJke+9ucRLv4Cwtgo5S3hS9Yzo838S1rGVBJ/i6Gi74DBr87e7SMdqeq17VxJSOq1AS3et9lZMf6uFICuRHlq7+Y31hBye9C2WX7jQeiWb48EpkjZq5cWgugprSRozvVANvLYGctrsOuCAFxzucIjQpBqbx7wllUeEpXycuvfQgAReZ9l60FibWaKAbMwW/uhMXBK0DYI7iSR69ImMArXKDnTvnLxt0xDPsJrqoEGSQWMJU3bqod5WOMMriwlI4/erqdsIsjoaF1qHzTqTXj4jnH9jq8ZJbG12iOVkM4W3UWfOtXZG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:23:44.9145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0820826c-c426-4b07-0549-08d7c0586920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to load power Delivery FW to PSP.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 37fa184..297435c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -114,6 +114,8 @@ struct psp_funcs
 	int (*mem_training)(struct psp_context *psp, uint32_t ops);
 	uint32_t (*ring_get_wptr)(struct psp_context *psp);
 	void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
+	int (*load_usbc_pd_fw)(struct psp_context *psp, dma_addr_t dma_addr);
+	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
 };
 
 #define AMDGPU_XGMI_MAX_CONNECTED_NODES		64
@@ -351,6 +353,14 @@ struct amdgpu_psp_funcs {
 #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
 #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
 
+#define psp_load_usbc_pd_fw(psp, dma_addr) \
+	((psp)->funcs->load_usbc_pd_fw ? \
+	(psp)->funcs->load_usbc_pd_fw((psp), (dma_addr)) : -EINVAL)
+
+#define psp_read_usbc_pd_fw(psp, fw_ver) \
+	((psp)->funcs->read_usbc_pd_fw ? \
+	(psp)->funcs->read_usbc_pd_fw((psp), fw_ver) : -EINVAL)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

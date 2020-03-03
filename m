Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF905C3F2D9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0FF2146E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kmpyOn7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0FF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADA16E95F;
	Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7059A6E95F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEoRT6RBp9eOqEnIyYxQeM+5krIVbzSjJjhhaC4xVJeccySoGPBFHuByJgwC0TRyCCq/jHa/P45WVA32bu2vJlZr3qX/k+cay3UiFMHH7Xam0s4WQTkDD3rj8p9KNYzoAgh4y+ns4WAn3tzRoiVLg5X8cSaPfFwFh/3+OkE/zpH5KdtGVz9yo5ZDA54WVifktgEsIZyWGy83syY5HKvSSWFPkIZ+us4Dipd58Dq0jfPLTXrrVo7qGUov073qjJL4T9yfrKwik/5DQxHY1P0uiIhRcrFvLHDiTjrGW+AvamT27LIX9Ff6JvpXIUAWyVtNgWVpyrCjsGNkzts5LwdlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=ZUdLlhNXwJt6e4rWFBP5nN28/bKjEW0vqwrjAdIvz1K2Nprn1BlzCWrNJMKdsyg7ZLlHic9o8GkzLAJ05L46Uv0WHFFy2OJQM1a24mBJ3h96nYQnnb4kLhwgY2eu8myAqLruaIAciFfkkExn8a1ncrj8QiR+X83WReWgHqlHRLLcVFY9Gecnx5DcPOdGpYoD+ERly491RLf6IdDgmnZ14ZlEaFK8QqT+T6+U+HMVQyrdMHTnIVDmvUOWk0h7NrDQ2XBGrIpRBAPzK5EEbFHgBbqK7mLRlIDCo2O11dhx0IrZ/h+GTEKYXfElJ/dIyuZP53uViy11WqUSTvHCcRLoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=kmpyOn7ND5ttsY6WyqWJkR/vBq0EGKzgXX0BT0LdHqcbBI/uO75Tr/x0yJfoXqYe3CKM189117y8DMsg4SgiNmeLCjQp+KgCC28uXhp03WIKZhS8xKLTCOUAbqPkwcd31ndu9pQkjhYFR6iuFE19T/vLmKhJ0Y4ibc3d7TVhBhM=
Received: from BN8PR15CA0003.namprd15.prod.outlook.com (2603:10b6:408:c0::16)
 by MWHPR12MB1165.namprd12.prod.outlook.com (2603:10b6:300:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 21:54:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::5c) by BN8PR15CA0003.outlook.office365.com
 (2603:10b6:408:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 21:54:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 21:54:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:31 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:30 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 15:54:30 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Add USBC PD FW load interface to PSP.
Date: Tue, 3 Mar 2020 16:54:25 -0500
Message-ID: <1583272467-25895-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(428003)(189003)(199004)(86362001)(7696005)(4326008)(478600001)(426003)(36756003)(356004)(5660300002)(44832011)(6666004)(2616005)(316002)(8936002)(54906003)(8676002)(70586007)(26005)(70206006)(186003)(81156014)(336012)(6916009)(2906002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1165; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a5c9a0-7ee1-4742-ddca-08d7bfbd7449
X-MS-TrafficTypeDiagnostic: MWHPR12MB1165:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11655A55BF4875CF77E12F85EAE40@MWHPR12MB1165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMTPxkpFJXQJwoGK//yd8yDQCBDio/x9BowsST/cH0x3fy1RIDqCt9N5AT4ctqWepmmkcIz03tdeC4TBDmYP5XXZbH94NzR9vc0mVLZLs1Sp2lyBsiZhRMYmykB7pQMe8h6/1D6aY/RD7onh2+utIlghkuqihZHFxXvfgHM/zK8efMbrQcJqPSSqFTf5wn/apfJm1XkQow83CqFpfwxdSaP8MCd09A6grS7tm/Z0JF1x+umMGcGNb+NC5aQnttqyTYV+/34hMpKB6M+IGRzbxOD1+2/nZ//zPPnq0FAtDG2F7vUXeHhil1PTdoZ3r7G8ovHzyswfpgBZGR0UKT7GSd9DZc31T6C9Zzp7r6h1r8/EUtybJVo6LCoeWKRBQquUtEtVClLjOpvE8vW+uA9shTvJL3QeEs1Z3aIsrPtEHh/cXJU71awhow3oGLVBWiNa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:54:31.6506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a5c9a0-7ee1-4742-ddca-08d7bfbd7449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1165
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

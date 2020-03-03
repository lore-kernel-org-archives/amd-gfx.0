Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6459C3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986EA20870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xCYHhnx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986EA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A906E59F;
	Tue,  3 Mar 2020 22:02:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319F66E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 22:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwuGBPOrmU8EZA7MxGAR8IzIzeBNEuDpYwzD0fI2FFeftvXc/DVxAMPKua+osAYBcIuXGQ4Fxf/CTwe3YsIaej+firtgsyLAJ+ElaZbVS+7gEQbuoOLcWZNC+s9pi1qMF+NwyUB5GTr2zFZO8BwLX9SnRwZe6uwPiqeIQc2bd2bO2wKRDvaCSuUeng/7ik2z6icpqq2fvdUGg00x7Z7hJ9IA38Ps0GV9ant3iecJOj3WWbhoN/HNjTsgDK+BkxX55YdZ545RvE1iPFq1lY5kP2QRQoHkw1qMvfJDPX2oX3n6r3tQ70Ocksd3iW1d+D9xOeATPIfxoUwrka3LKQeLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=PDphT/ehE5P/tZYjVlbmencn01OgpN4Q1eqRKufrSGpHyKBrBv4UBiySk14CFWYqHxQuIFwWpIjr50SQX2NrvCG2/ukhq3dtcbGPg5W7vyvPc2FAnPytcjohsUlXZ/cg+r92EgA6g9GPI9A/s8iBb0v5Jw4o6EoV6llI5XeuK6eVEaXGs4sG/PfnxnXrNUSG4EQhFuwIV4XUsfTPgNzzs2XDyfjAvMVlGNTfsFxEp+NkFbooG+hBMl8gDk26XKlHKHMtdES5dlgsP67MkBebHKIb3zdLor2Edxksri0sSJG34P+nO+wtWBT6GMDxV75JLg7yKU+pbkOOy1CjQ+jh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykFnJVWwEFPiCfxJUDmHn2a11kuF9TblFr980CzoCs=;
 b=xCYHhnx/1m/vtMoSj/K3cs7QayYvXf2AxUTEZ3aL42rAxbzsVL2R8zA7kk92NUVKc+WQ8jMN49PQQlhg1IUczzICgoEVHzuOvOJgSIv4o/d2QNAki9ho0jrNmdWncU6W3+SzMLbXtvV6aOcvZNvrCjbJ82jGnkUSsOZXhy3SyDE=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Tue, 3 Mar
 2020 22:02:13 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::f6) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Tue, 3 Mar 2020 22:02:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 22:02:12 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:12 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 16:02:11 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/3] drm/amdgpu: Add USBC PD FW load interface to PSP.
Date: Tue, 3 Mar 2020 17:02:07 -0500
Message-ID: <1583272929-1038-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(199004)(189003)(70206006)(336012)(36756003)(426003)(2616005)(6916009)(186003)(8676002)(81156014)(81166006)(7696005)(70586007)(478600001)(8936002)(86362001)(44832011)(316002)(54906003)(2906002)(6666004)(356004)(26005)(4326008)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4488; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d10a093-cc69-4b96-9cef-08d7bfbe8729
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-Microsoft-Antispam-PRVS: <MN2PR12MB448862BA2E6A15C37899B37DEAE40@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbYm1L9zrTCdqZdQErlIBpGPKbmfFf1j/kBQ3EFGHnIGCSqC3Y4m/Njortz2BSEHhQEX+iNmSXs4hKik+VCDvTSkpcNhcfJ34tsoUbj62CJZ/ET3GyhtRyWlqHz084MBkiUMsQ1p5GFK6wTl4YTrELFdUKOmVSKOG4l9sKSGfkZe2GXQJHWIuT4KA9mz/UwFKlqb07KY9i0bJs/hWtdKhOBSl7HbwX4TD5WJF2eMPppL/X/qa8PvXllj+/xnooZjNZ3XZEwowsgmEY9q0707mIwzK6qLSYk+qCBRKici6eDNUsUKen2f5JjO2ZWr9pz/Id/D7qnMx2g47e/mXbUlNzFgp8WiO5j9QEFH9K8/nQbcNe0tnRUAsTqFL2VnmSgDV0sUN2IydZOMBE31kv0P/AslYfMygvAXc7Ixr3xUt1x8xH1Z7K7lIkfyVf4VnTF8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:02:12.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d10a093-cc69-4b96-9cef-08d7bfbe8729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

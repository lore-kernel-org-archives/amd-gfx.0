Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F8C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02AC2173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z/eMYpiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02AC2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36026E7E5;
	Mon,  2 Mar 2020 19:24:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D186E7F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 19:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLzDnycxRg1E+auBmBKux7N/9HLbwYpcnSyI2qeTbje6bDpk0eyDEWbX80swOoPyU48O/dlnAjIPqhQN347DQ7yGyDM+yulZR0nSvUc9rQXVLoWoufYiY5B1MRgiutedLBER2aLlxnTlonCQP1kSeU7YtTLK9klPz/FrwdevmLT4m572g/NhxaQX3seMWFt3Hc5NlTO7Yyyg/LKBx6JWCg8VsfLJLIyd11LqHqO8qPNz6ZtLCMU4tkvRSMkf/ulmXUd9ZDQAgTM6zpGg/tgM4XUV4xX08ZloTU10TSwHOKMrrGMWY+qvHs9mQuzqYUeXvvzWT+fuE2JqSySn9uN/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYI4eL9vpbO0QylnTE+oHZDZAOUQ4fzZaBI9Fesn6IY=;
 b=I69Pn7dbWwm+Uw5IzZqcq9y4O8qZw6zQuAeLpE8yUE4atlk0SrXpA3NONhr+webPqrMwlOvNaHfAROnjqLHETvw2u20RzvTiHoT/9gTBLUt7YGZn8N0YysuyYRC1jQenHkrJI9EkBZSmeYtv6sOdXnRSyzQVfXptKqNZJFPRhdY4pes1nx717GGo4PIOMvcDYlddelHypaRq9WmirlJ8YTNzBsvZocbE+wjDZisSilPaWREYT/uSkHf+OXHkCrN30dhXZSOn82Fj+XxTymBW5VZt0Yn6tpQFZtFRCDUFIzT865hkJfLlFq0q7/4n5+GMqy3WuK5on8Si7rUqh4+OQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYI4eL9vpbO0QylnTE+oHZDZAOUQ4fzZaBI9Fesn6IY=;
 b=z/eMYpiMpcd7x6qNzXE4xrjRAaH5raC8edxq+5CezAEyU2v+Q/OnoK6fIxQk2jMeEtWkFq5q7wwMaRkJa87OitBZus6kmUr77+PDUSXrtolawYQceIqqKvpJPgaMr7Cnly7FU+oxsp+SDtps3usuEwBf2l2Bzz192my0i5xJXiw=
Received: from MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) by MN2PR12MB4077.namprd12.prod.outlook.com
 (2603:10b6:208:1da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 19:24:29 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::a2) by MWHPR2001CA0006.outlook.office365.com
 (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 19:24:29 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 19:24:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 13:24:27 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 13:24:27 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add USBC PD FW load interface to PSP.
Date: Mon, 2 Mar 2020 14:24:19 -0500
Message-ID: <1583177061-3115-2-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(428003)(199004)(189003)(6666004)(356004)(70586007)(2616005)(70206006)(336012)(186003)(26005)(7696005)(36756003)(6916009)(426003)(54906003)(4326008)(316002)(478600001)(86362001)(5660300002)(81166006)(81156014)(8676002)(8936002)(44832011)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4077; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1cb7b00-c16a-4728-25b4-08d7bedf53b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40773BDB3A7128FAC0354EFFEAE70@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qdf//lpGKKGlAwUSxgGkRp1Xjr9pvK6MKkMviF0rP32DY6wNBBdra2oKNKKrCN4EiurGBW3FScnR8wwKOLJIeo4PPkjVj2mFHC3yCKl9X+w+dACI/ANNZEoIJP9IPRF74RcSax9br6gyUsSgdNHWUkzW9w0hn2SImV7Loiszns0V58Z1x+QXcT/3YiQFmXqrxZeJ08stkAVAv79YfLdcjf7YYWpP9Eo7lTGdJ1fmaT+hM+6meexjyB43YXBxdeVueKLm4DyTyXOTxjeX0MSicPqRKXha1s9DultaWQmgLxd0QSpDbUvVfNco6YXkiAmEugolyfRMBilQ23aZofCpl8iaI+7Lv11Iqf9j1zCCzLu+uXM12wGceAG34l9X3f6miSfQt8H6r9itQN30ozZW3mBD22lK3xOBbof9wSQEuAlnRiu3Z0Wh5xkHGzWoB9f5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 19:24:28.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb7b00-c16a-4728-25b4-08d7bedf53b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to load PD FW to PSP.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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

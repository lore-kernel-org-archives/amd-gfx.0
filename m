Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D047610E466;
	Thu,  8 Dec 2022 07:51:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6610E465
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNcuhPV7ma4u8uN65RtRt4JeNJUz2KIDQ6Nr9aq8xsHjX1SE90bDEeFlu/ASktnsaeBpCWzNaraOYp02ovCnYMEtD3nZ/3IXJpTleYRW2NF5yP+pOmEQ6E3RmKrOBRzMUBbjox0OHMtlO0LAYb8WgQPnOKFIsJWlKe3atm11Pv5tRpYSdtBoPhEzQ2ebuDYhs1nxH+V5EkOpw1lRU0/SoHWJqKre5TwfbuUhaCN0BUyu74abp1dxz/0fkabZoLBGeTjIfxlc1Ozyt+H8fzp5pTRLjUHQQBvBRlo/NeSa835ZGJeXqZ/QmqrdStYSaQjvZOJ8zsHbzeu7Zul0N3q3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZZ8N6xq8Ysrr+0oGD8UTUC0emcO2bMRvNZxej3qZI4=;
 b=AFw2nCQvRF3AX90WB1wjr11w8YL+6PLAiprCr7caNfnLTpjaDD+HuuHmoSvfsML6rVHv2b1z+kIl3eu+ht4PWQrbc+cOA4U1vFwtmckMpBy7NZpKLlvYeNzsfqV2RVA7IlSKIqMeUmfBhwU3Rg2AOQKSWEkhunFECAvZFXK/ONR0ZpC2/VF+kwLEL+Qp69IarhLslSPlMmg6M1IlHUn17F+fgdjhHBlmAFSpu2LLMWBtzGaeUjYMsRcH9T97E/970DXJdljNIrT7ojmcYZwriyBiO1GpAwPzryM3X/hBmF+3LLbiyHj8XVCjKY45yLOXkqpc6VTh+jaBM1y1aWUHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZZ8N6xq8Ysrr+0oGD8UTUC0emcO2bMRvNZxej3qZI4=;
 b=Gk0V29P+tDLP6iqC5+pqNo2MwY7OZKovSQB71ZN0r3THN9ZKByj/bpZ7h6BvbDkVT5l+aCCzgbuDzbHqp9ASPsLf7fgopFp4i/rmT8yjKFAEeBx3HUz1vLW0w+2g9NxDubDOIbrj+uahp7NxwBu6Pq0t0Ag3wS/uW89UXYv4bD4=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:37 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::14) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 07:51:35 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:33 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add RAS poison consumption handler for NV
 SRIOV
Date: Thu, 8 Dec 2022 15:51:17 +0800
Message-ID: <20221208075122.28702-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|CH2PR12MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: af29df4c-aa00-4b54-71ba-08dad8f10822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW13NYeRDUVntCTsJk9vWfq5euoFc+ucVcfW9XjES5k2LZ0/e8vX7yWbNEfHJn83AmxqZAQ/fGj1PvUEnW5SRYRRad3zsZyPYM7qqhVfr8byapMX/MklD6Ev4jvsmM+miFBUFdhhKnxXpqJMsO1oRWfL3B2r88Hf4Rv6VvgXZRF0AkWnN52lYKehwFOGf8BYJS6fdeeiNf9qkr7DNG7AAq6HyPwknDR8x/hRWng9Mj/mPQmC+IwArm5j0c8H9kubv6Tb2vhOpJgylyhu2Ny0dwvXQy+9GGtfzM0INDhwW7kUWfjgsIbQQdKS1v7wgtfvIraV0ZlhzO1suJC3D8hLwzYx6eqrf59rcsRnP2wUfcOkyMWFXKEqIzz0y3/o6rQT/nRzzYp3aDtPzwSJMEwCpvqZGpeVL1qrPsyxuBRIriNAKvZ8Y5qy3yB4G5jwkZVkWPOhgGyQ+N+kBVfEZKjIMWzoPxLUAlyF4c+Fks5KmBAZTssMlYXy9XVW9RhKLKBGjz18hP/NikGl5n2QKmtK99WKYHC4R6sB5GtdU8v0KedhkUADKDXCmUObG2QrjFo3iPoU/Ql8Vb+88STzGNwZonfETukQrwI1cNeVcwGBM1QvdNejlAl6PvUoJpDjqNo6Kv5lA4ju8XdfjTerHwK95Qd8FoGJujwdLykVHgM0nEBVim35T41e0K1u5dlK0ZUEKs6faiDvh0Vwev8i0w3yOWppkfOdyXNsYJRcRYACUrI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(40460700003)(40480700001)(70586007)(70206006)(16526019)(36756003)(2906002)(186003)(336012)(1076003)(41300700001)(86362001)(356005)(110136005)(82740400003)(81166007)(426003)(26005)(82310400005)(316002)(2616005)(8936002)(6636002)(47076005)(8676002)(4326008)(478600001)(7696005)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:35.9977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af29df4c-aa00-4b54-71ba-08dad8f10822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send handling request to host.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7ad..cae1aaa4ddb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -426,6 +426,11 @@ void xgpu_nv_mailbox_put_irq(struct amdgpu_device *adev)
 	amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
 }
 
+static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev)
+{
+	xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -433,4 +438,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.reset_gpu = xgpu_nv_request_reset,
 	.wait_reset = NULL,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
+	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 73887b0aa1d6..d0221ce08769 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -39,6 +39,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR	= 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_POISON	= 202,
 };
 
 enum idh_event {
-- 
2.35.1


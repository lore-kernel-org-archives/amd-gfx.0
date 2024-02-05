Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B66DC48291
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 08:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086FC11241F;
	Mon,  5 Feb 2024 08:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaTSKw5q";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CFE11241F
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 08:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoiT8fl43CukWW/A5IHKEK00751NSD/SIppfaOGUADFQL9sB6dYq4kBewDKVMMYDOfyd+7vlpWAGlQrcYr00ZW2kf2zCCMMymDQwKQqwUbaltao6ERxR5ePdWXCU8BoFuThwfo12fcz+ZPzcO30F2aIlpvnVz0r5IdIXhDIFvgW5go72JPt3GlLODAQPI5Sdn7Pp5J48GYz6FIj0DUN0idLnTwiXCOeiBa0toavAN9z4EhWSUXH3KYpAJNamrdCXtKdFkZKElBAAt2QVd1g+gaSkQ6iLHVR2bAW6YZOqTcpNkaka6b84k1BY6VzWs3vtR+f/a22CSFlvAAya46hjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ3PbIkvZnFqngmi8npQ+y/gzAUz3Pqmv8BuIt1Vvx0=;
 b=PI//4vZAbRFVw68LwmVGCBB55+8+37XYGZ+M7nCPu5Nov9bxJ8lUkyLkfvQA00Mp2cBomc/s6FQHI0cJHJ3TC25txWT9jEIPmD17f58ybP5xqGWE6/tWRAIqzoeX0Na6Bd/RjHunvH9JOsrn4zrQz94CzCY7cgyB7rv9snNRG9tIUjviTY+KQ1V2zPKFkFS13faTxrlVzEUHSKsiVMruM922LUaNzpWG5gv6BIyyt4szYjkI7olPe0N46E5z6U1WbXdlOhH5ErUImoHx0doNos+74hwDnqa+DxcsTmWuPb9fQqVC4+CaTNairOj/4tuGpWejrVOZYdc6UaRmSHbLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ3PbIkvZnFqngmi8npQ+y/gzAUz3Pqmv8BuIt1Vvx0=;
 b=UaTSKw5qd+6zdAIeX6HbWnwasPLUhQNFxyk15A8THOCObwtVDr+zUWiZl20XPwN5ICv2ZDGKEC/7gT5UTw0LuaGuykFIeJTX4RRDoqrgWfiYktj8P71gPCIaqi0KaXd+A68rmLnNaDt9htuOlmBghAib2y2aPov/nFRTag1+c1U=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 08:10:21 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::75) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 08:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 08:10:21 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 02:10:14 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix shared buff copy to user
Date: Mon, 5 Feb 2024 16:09:55 +0800
Message-ID: <20240205080955.1378983-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed5c0af-e80e-42ea-7dc4-08dc2621e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0IOfiYnFg0n3KGOwF8JtgWXI64TfaBUoyFhHApeiizRwo0sL874TIPtTzZX6wKlhSNPrswx1wCwJiZl7v541/4B61rHukafnOS3aH/sBU2vPUEEYSBE9doQRhBgSv9QkGglHaUWCVFv/Q3RlKR4VISntYkiLSpNSOILDnDZpV/Q4oeUa2Afu6m6sZdDBiDGoAYRmLCKglgbhUpd4wSbghut+ddgeUKdl02U4OHPJObGEf7wb9URPO6blFvlS8ngELAq57zPWOWdSCOTxXjyzrEN1q4YZYwsCPo6/kW655E7f7MIuzvRCX1G8bdtMdNOO10SWrmVCH3fEElxQNwCB1Jt4JsfsDuCVZ5RON7voq6pOshiblKvpSc0IxnVI0diQbeXvrJXwy8N+0knRTz06a8VjDYxS/BdIp1ogAk7/j4c6r9eBqGZniEUBXT2ahX4M0iZ2m6WDBWc1HIZ57DQ425+yH3YX7jZQMuDH701GpRT4wdhyC+vkiglxwCTptGGu0cRVdVVs82g40o9j5y+Eu8Nta54pmKNrt1PAdX0llytvum8bSy32/dAAolfvL5UwHx1CdRD7CZRORJDZXMfEztsTX5Ac8mHk0x6R0wovKt65Od72muNIbjWIzB1+NNcusoUVLxbLV+Fr2mmCZ7BijJ0fMw82YoW0rmBunvZJmm9TjejImL7FzsgWvxUazTIa4Goo+aGQImfO8KVpxZK2r7dLqITfgD23ZMbgXOrdgcksN30oZbQAOZuDQZqMmBz4cbOdoFPSchjWFIWPsizMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(2616005)(16526019)(47076005)(1076003)(336012)(81166007)(426003)(356005)(82740400003)(26005)(41300700001)(83380400001)(36860700001)(8936002)(4744005)(316002)(8676002)(6916009)(6666004)(7696005)(5660300002)(70586007)(70206006)(2906002)(4326008)(478600001)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:10:21.4053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed5c0af-e80e-42ea-7dc4-08dc2621e60a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

ta if invoke node buffer
|-------- ta type ----------|
|--------  ta id  ----------|
|-------- cmd  id ----------|
|------ shared buf len -----|
|------ shared buffer ------|

ta if invoke node buffer is as above, copy shared buffer data to correct location

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4..ca5c86e5f7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -362,7 +362,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		}
 	}
 
-	if (copy_to_user((char *)buf, context->mem_context.shared_buf, shared_buf_len))
+	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
 err_free_shared_buf:
-- 
2.25.1


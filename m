Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8567BC47098
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E52C6140C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 04:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E52C6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB6C6E1B6;
	Fri,  4 Jun 2021 04:58:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF826E1B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 04:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHV1CzMMCPL9YKaXqHFHwoE+6ItMu4PnlXIfA6OEQIDNJ7BRlnr+hEt8eK1RLJULbGBCYNQtMwiZnIIwyjPv+wp8Ji8FmI/S1yqv/k2ZtcSpFfinAD1AHGKklckzaUrpLV4VK27zdlb2XMOKwL+mcCy3VzDEWQN/1m6fwfQ1cUJi+k2rQ5sy4Wuc2EAUFiBVYxhipXIj1FLxBh5Vcy+mhIwBHexGfowoxihyangLtpNa3YHcWbdaWhLF9JV9Q21bw6M5s6d6WBWpcNbO1Y1V51++vQryXQswuXEoRVr9V/+vIbX6U4o5p9w09fTCnPDQrSjvLNKNahIYcB+gk2ylXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAlc9AGY1ul7Ep9aqX0sIn3TQ/1NKuIs4EegvJ/tqCY=;
 b=CvNyhafjxnAPa5Sa4eU76jjcpK3C1C4pigwWXom6ugVgw34wDvq/A8VFXpFYB+klS+uGS6pgls873e2sT/xzvlJcDRpcJw+g8CBYrvkV6jQFlgcPStTYU7+3EMf4ttUqgrCCVuyOfOYxx0o496diBA+XYbyP6XNEhvWd7O+8PNZSnJsVh1Xa1GYmcPkWgjDP6kkjyHfA2ukQrCyj+Y11bw7+MuR/OHUsfUNJOIJVfruotekRr4MFF1nJB7BlSeylupxTymluLG/RXWdV1WOaq/LjoK9Vbq5chA37W4LwVW4ok8pAYIrV7t8nd+o/jSKo46Xss5cktVuNUzW3wa5txA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAlc9AGY1ul7Ep9aqX0sIn3TQ/1NKuIs4EegvJ/tqCY=;
 b=LM76Tjhbywudep7eKg6f9NtW2TsI73nCJb+o0tSsYSp1ee6ER8AAgD+goCkS8ud0VypD6HfFK1AgCT/IXkDwdofHn8c44SxCzxrSSJPnfaEeVLo0wAdvwg8ASxU+voYDt2yPq9FPXoPuxnpRpjMXZgR71VVKxAoKDK/K5cfHdg4=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 04:58:39 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::4d) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Fri, 4 Jun 2021 04:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 04:58:37 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 23:58:35 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: add sdma poison consumption handling
Date: Fri, 4 Jun 2021 12:58:21 +0800
Message-ID: <20210604045821.14486-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b912ff3-42c2-4ae0-602d-08d9271569fe
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5424:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5424ED20855826EE51CAF2A6FC3B9@SJ0PR12MB5424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJD3yI0gs0DkIU8n1Q6RMxe35otj9weQ2a1P75jcijJX9cp01uv2jrqZAzTu3KaIz/Rp6HBQ2I4uRg3u0/JNTX15etP7YehXeBmkApO6uiIf1NEZy3GmM+r4QYrEB6YRxEEXl90qPoZidew4g41gXS+zw+UMgFRMLgWtjIiP0Qp2+vTDGw9P059KCKLdOOzDHcnZSdnw8ULKew5Sxy4QOo2P17z1Yd9yftVNN9rV35dPhP7XYTDoKnCUfAkLuxE1YKJtGF5u2yutJzLdKp7HAxrWgpyw0/4eBf0YJ7ZjdsD+9sri+1hYjo4BwBPE4D/DWE/EVXxBTet+McjSJa7MEald6rWnCNSKyhe5IW8OT/4c10f1tqH0i213CKAEYvZG0jY97DmC5IKiWcnUOgl90nNJxWiY7F+0gOtiNIvpAMrbvNZADygiQYROmAj5102dUE9zShl63Wu1CASzHkTro0MZa5cZHLm0WmJ+FzqbaicxjG/ju19RBV1k6KOGagjQnniTJHxEsYZs0j3OvegL4voV45TNCU9zkMcaa/9nRW07QMDfW3lzg5kFG+LAczK+AyQrdFulxaXbrAPZjQOO3K+a+SzOo13nATZKVG6oXdASjowdO2LiU0rMBI2K20s6OkvSdqx6SlSIqHgAdEmgiU3khaAOEmgb/69TdibrH6CefAGljjTu/U+Dc9q/Pvzm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(36860700001)(426003)(47076005)(8676002)(26005)(1076003)(16526019)(186003)(5660300002)(478600001)(82740400003)(8936002)(6666004)(2616005)(2906002)(81166007)(336012)(6636002)(36756003)(86362001)(82310400003)(4326008)(356005)(70586007)(316002)(70206006)(7696005)(110136005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 04:58:37.4261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b912ff3-42c2-4ae0-602d-08d9271569fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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

Follow the same apporach as GFX to handle SDMA
poison consumption. Send SIGBUS to application
when receives SDMA_ECC interrupt and issue gpu
reset either mode 2 or mode 1 to get the engine
back

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 7 ++++++-
 drivers/gpu/drm/amd/amdkfd/soc15_int.h          | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 02dd12774261..2e2b616c1bb7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -309,8 +309,13 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
-		if (source_id == SOC15_INTSRC_SDMA_TRAP)
+		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
+			kfd_signal_poison_consumed_event(dev, pasid);
+			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			return;
+		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 0bc0b25cb410..daf3c44547d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -30,6 +30,7 @@
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
 #define SOC15_INTSRC_SDMA_TRAP		224
+#define SOC15_INTSRC_SDMA_ECC		220
 
 
 #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) & 0xff)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

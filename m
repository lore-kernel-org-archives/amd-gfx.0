Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE98C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985A910E326;
	Wed, 16 Mar 2022 09:26:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272A910E326
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kstyuEfAQMfm9qpqIQKOn0MrzSKVCI8Q8zK2l5FoiyWMD/TezcIbbOmqRuB8yvkyZdwun75R2/Lr/vl8vcgZOaTWyzn+pN5A+q7EoRrMtiSr2Vlh33DHUEf6tsxG5kjsWF25juKbOYtuLEy0EYUXE12x0K0iSS+MCFDjU01gDSOoA8jc9+sPsleujlsyii1B/98d7EUwhtD0eOtkwMTsojRdg4I/pHTY2WAQiB3QEhJTBRcMPwp11F7QT/WGWxohvckaPH68SdT/ljXB3q/k2/YUt6uzG720RAeuAtXJkmT4yCqk5oKSdpGOrL8csRYXrb482Qhly5TRDWOx6cRwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdErsoERLp7b7R6/kcbzjkjCiFcB6EeAfBaUF9OSQzA=;
 b=YpPiRc6J+YDyFgq6Jqz3DSYXdSeAOEoYJLKdNvpVPFlWyv5Tx4eX3nNioFHkQBTHknq6SaRIrCLbdhesicuigKeA//OhD+m9xGIYjOXBbMdKQ2B+ReKdqygvF291R9qbYQUY5QlbUPbyNQpm7wH24fzhwUr1UeTK9XNmFqb33yH8CS1lY6lE63GSfZbwUihIERthAPamTngTyUO/j4JR8U0R/mj5Hw2fxAMfOyIZJ0cjXIY6s8+sTSrQifrm0qm+SsqIXpG8DqRpHlPF8ODMmjhnRxUJyJ3hqgQaxlue7M2PyK33M/8tzVbGHGqQ5Buv4HeoDtCgj+9gnUtA68rcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdErsoERLp7b7R6/kcbzjkjCiFcB6EeAfBaUF9OSQzA=;
 b=XdmNOr12DEmUG7D+wt0qrIN+5ydtnucRuOIFTdTTtRr0NZZj6d1bBsvXjYv3sPgZ+DRgvSo487h/8fZKCbM7ZYfWMlzqlbQ0CXQZSeJCwzUtE5AqP6rIQf67vO335LZSGQQwVhj7cLPWy65amLI5WN9UXBp7ph/Hs8Fj7W5Q60o=
Received: from DM5PR06CA0087.namprd06.prod.outlook.com (2603:10b6:3:4::25) by
 BN6PR1201MB0162.namprd12.prod.outlook.com (2603:10b6:405:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 09:26:40 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::22) by DM5PR06CA0087.outlook.office365.com
 (2603:10b6:3:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:39 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 04:26:37 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Date: Wed, 16 Mar 2022 17:26:24 +0800
Message-ID: <20220316092627.17359-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce276d2-6f5b-49df-1da3-08da072f1354
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0162:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01629643B81D904A5D94775EB0119@BN6PR1201MB0162.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBDUa4bKDUpDCRh3H72RuyZNNyLOxm02b0bTtgxVTlVqwjTpZJR+OK/6UrwDAr+9SipQWuxMmaGylgokaz5sdBApMqtYOocqEsMLweizMhvZO+Qh3p2OKFRMIbNP3NzoxClSulQQy3TKZg+dTlaoNESEPlJljxOkHfvjYWTk7Jx3fFS9WBgAvK/UGHbEo3IHOzPL217t6PElysK300yLd8xZWhEdve8ffgunmXTiqhPc8eBpP7NLF2E0BPRa4HVCWB0OFYFD51OmN/lnPGmVgA21Y8FvDULctnHr1+s1JLcj8z0uS0ijRg7guJ1JsrHP+5BrhCt24HyqS5Y0D/DgsABNTOzGZcwTpVXM2wuDIWKpmbv/BjVM2FlIfBIj+Nb8O7ogGD9GxQ0OhIqiMzEhGCsLrkwSBCHjelEEzxHvATfzCw3FQUiCebi4+DSPw0Ac/5oNMsOqIpo2kFD/4xnGVYZhIhHPWgEhhXKhYZc2Yq7CY4QmIsmrdouKX4qvrbGu3lmWdPOAnfq/1lZ1ogsrWYktjBGLXDPmWcAezkJxkLmlLPq8F5cIzkE/IzEzs2CdwSCzU6tYD9ZqIcNkxs5dhdtgI7U/cEJF1n2YVyjd9li9Hixj4bZOP8/naa3l5Eo4SXXnKNMtzwB9rC16pbroVIebusZtPxJ0LL7cfQC3IXzfy9R44mrIjMUCUjcSfhHrC+IU+2Qrf7x5ox9jWmQkxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(6666004)(110136005)(6636002)(316002)(82310400004)(508600001)(47076005)(86362001)(26005)(2616005)(1076003)(336012)(186003)(40460700003)(16526019)(426003)(81166007)(83380400001)(356005)(36756003)(8936002)(70586007)(5660300002)(8676002)(2906002)(36860700001)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:39.4389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce276d2-6f5b-49df-1da3-08da072f1354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0162
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

Combine reading and setting poison flag as one atomic operation
and add print message for the function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 7eedbcd14828..a992798ff8b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,20 +93,19 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 				uint16_t pasid, uint16_t source_id)
 {
-	int ret = -EINVAL;
+	int old_poison, ret = -EINVAL;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
 		return;
 
 	/* all queues of a process will be unmapped in one time */
-	if (atomic_read(&p->poison)) {
-		kfd_unref_process(p);
+	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
+	kfd_unref_process(p);
+	if (old_poison)
 		return;
-	}
 
-	atomic_set(&p->poison, 1);
-	kfd_unref_process(p);
+	pr_warn("RAS poison consumption handling\n");
 
 	switch (source_id) {
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
-- 
2.35.1


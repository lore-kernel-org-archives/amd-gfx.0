Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BB9C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DF710E5F7;
	Thu,  8 Jun 2023 17:07:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F35110E5F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnOldNXzjUSa0l1JUZl2x4AArcheuDtMQhukiDYeKtkLKuP4y81wPBWXcl8B078UriLbxe+ip/9MHkuaNMpo71jYS7PRiCeoGXcOcEwF8k2oKvFdVNXS58nXA9dOr/zYpno9mkPDH5VrEfaTRKDXZwhMwY0R2eD9k1sP3EmbtZeZ4Txj22zo66ThhLiJKVYKaSlfqRJ0OlHP7g9ldvQMB1Yo/145GJhhomZZ4Mbr5BcUCa6bZecsS1ukt4/iXwJTh77isN3NRtJDN8XjUY8sqW+vWw0jt5oQ0AGO1wvIEyHTx6T+3xvqH0aPYdUaGaDv3hDY0A66cNxkYOp8X2ODOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3/fkEvecRzXApwonNU9A2/BfYyXmQxbuRQuq5tlT9M=;
 b=TElgiNVeE2oTd4RjYmfFJ8JEpTAP5jpZ6JTQK9qgmCOw66vRIRriVPjuIEBYntbs/AZdUpJO8onVzkpT93kezPkj6SWy2W3L6Rqegc8kKEbjS1BgGJq/78/pQUMQPtUUCdvSGH4LQFwluN4MJEmWw92Yj6Qq3KHFO7Tr7SRYGgq5u15csgWBN10mMCvt9hFm8yMON40P91K0VEZEilIeMqzHSF7gajUR2QSLmzEMfeD97gz/NvByMVi8dakiDlBvnH2ZXTAPWNMuRnxzlEZE1WPKJjQvLaL/Lo3/TQ8hbJPRcfsiY2JxRuwLVEEfouIms0fJv8yU68bDFBvGMeg+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3/fkEvecRzXApwonNU9A2/BfYyXmQxbuRQuq5tlT9M=;
 b=TZg/w9IqeiUsr5OieUD6KBkaBaBixmAnfDVQgRILoU9w3yB4jJ6YTtf4eq8E2F6H4mQK0G2/AS3boUxLorJ8rtuzzp1MIyk/X6wVdHfLa+erzbFDOGUZOLcF2ZhpJmvgrjQ6ajgw3o6WHsenPnCMh3mO+y/FPK2OScGrDtlkT44=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 17:07:39 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::d5) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:39 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:34 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/5] drm/amdkfd: update user space last_event_age
Date: Thu, 8 Jun 2023 13:07:04 -0400
Message-ID: <20230608170705.2271276-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-1-James.Zhu@amd.com>
References: <20230608170705.2271276-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 75220aaf-8cc4-46fb-e624-08db6842dd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjNr/zF4AlxmePTjedXCZdhwd8BMvd7LAUxoQdk2O6pziBOKpDk5lE0S9+dP/82vi1qQc1qSE94luBZmUJBmuVhl/RAScuBAnhtVGT/SaqEbxd2leb08qw2G18HZ+hz5EQamBkrhybPw2Z3MBsNJ9fLxpODc3mQGf2gcpZ6oScj2syit1DGAqCOEN+4ZyF+cD+JjtcwiFvDNBhxwIMZaAs2rIQdMrxfLLay00vKExrSqGWdaiOmjm/jPunREw9kkIzjOyyk91eYv5GG+yPoZzw/SbhjsZUhXL34scZPT0GvVk7aYH7IQgCW6ngWWlfX6R5aj9ofDf6MDCIn1bh2qe9muMGjNoBdkJBZoUlIBy9WLYCEOOtHsRHxY4iq9LuxqsAxHTDfEUWRuv6jos6CIgFznj6YncLMPDGZ0xKR+AKKtDZbV8mipiKfS9f9r1Ki6gZzKnSLwt1Y5IfDdEJt2ZCXcS93fnEmjHdgYK1RLORZw5ZqjaREIL8r8ZU0eoYLQS4UiDQsKpxjJ28V2sJvaryXTv5ZtuGZ2BbNLtF+4wRDfsyHPe0bQbtBpVxgpSfxgqoz8+2uAJDlu/yMwmcisBIzWdP0rilcMfFoIuhBm7BkkAnGIy924F2ShQ/iNI/HGhy0OOBIzUIcfcWpXJNp1uniUldfwOc2Vd09IGRDWlQoYlHYR9kBxLiGnXXlvjtY4q2EjXl3Lj3idcQEorcXBtav0QpJpYWoDvYab/dgCWRqE8YwBS7hXu+1cJlSQp6MXpo7TrHOnoCWFY6Jos+++1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(54906003)(478600001)(40480700001)(5660300002)(8936002)(8676002)(4326008)(2906002)(36756003)(15650500001)(86362001)(81166007)(6916009)(316002)(82740400003)(70206006)(82310400005)(70586007)(41300700001)(36860700001)(2616005)(356005)(1076003)(16526019)(26005)(186003)(47076005)(83380400001)(6666004)(426003)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:39.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75220aaf-8cc4-46fb-e624-08db6842dd3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update user space last_event_age when event age is enabled.
It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4c6907507190..9fcfec57a094 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -863,22 +863,29 @@ static int copy_signaled_event_data(uint32_t num_events,
 		struct kfd_event_waiter *event_waiters,
 		struct kfd_event_data __user *data)
 {
-	struct kfd_hsa_memory_exception_data *src;
-	struct kfd_hsa_memory_exception_data __user *dst;
+	void *src;
+	void __user *dst;
 	struct kfd_event_waiter *waiter;
 	struct kfd_event *event;
-	uint32_t i;
+	uint32_t i, size = 0;
 
 	for (i = 0; i < num_events; i++) {
 		waiter = &event_waiters[i];
 		event = waiter->event;
 		if (!event)
 			return -EINVAL; /* event was destroyed */
-		if (waiter->activated && event->type == KFD_EVENT_TYPE_MEMORY) {
-			dst = &data[i].memory_exception_data;
-			src = &event->memory_exception_data;
-			if (copy_to_user(dst, src,
-				sizeof(struct kfd_hsa_memory_exception_data)))
+		if (waiter->activated) {
+			if (event->type == KFD_EVENT_TYPE_MEMORY) {
+				dst = &data[i].memory_exception_data;
+				src = &event->memory_exception_data;
+				size = sizeof(struct kfd_hsa_memory_exception_data);
+			} else if (event->type == KFD_EVENT_TYPE_SIGNAL &&
+				waiter->event_age_enabled) {
+				dst = &data[i].signal_event_data.last_event_age;
+				src = &event->event_age;
+				size = sizeof(u64);
+			}
+			if (size && copy_to_user(dst, src, size))
 				return -EFAULT;
 		}
 	}
-- 
2.34.1


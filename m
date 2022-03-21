Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BA1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 09:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAC610E300;
	Mon, 21 Mar 2022 09:38:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6817010E300
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 09:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZHWq3vDqC6vEn4n1XiodX5OloNxAPYfRIjpcDPdHDwgGolquIqVkOa8Su/AZzq++FhRDYFgFt4hJqEzD6vc6aMefG6Uk4nZvfD6Q8RwBF7A0iKOVDNtxDIAQxYRch0buOPsNHLskDx/Sfj7NwOKR/8n2pAVQc1FkatyM8WdCdkbmBgVXaVgS3Eglbjwf1l6owSfZLEPRbwZfZndmH/bMf7L/53QgP2W52kFFr3T0Nh4rluUjWn0uePKJkxHy5cRQHzfNmi6NKbkHu1lKVSn1jAv85pVCHfL9KBaMBHtTnYot6HjUJu4JZt88sYwTBAv1wyV+mSMKhtJrJvJa0j3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjPzSyHvRJ+4Mf53vuuZ4JGCejNn1W9cQK/vJefGaWQ=;
 b=BnwuJHrcQwQWAzT6T87uY72+A3jTut3z4b8wOStGidceineDg38ec3TsZNcQMQh5EGGTBJW2EP4JnSUiXYaAh7cT1FmE1rAAaDHuvGKcWHe2lcQw6Yy2WUcGR5oYR5VUCvOfp/Z/RMAVXWV12BpQfSqg7DkYC0v+XVqXipz1UO4BWyQ7SqFVYL9+cgBThBOwwEpwwT4GMtk1Sqh0XVPBh7/j/8XNIXcWVNEKv8hJdwyUv9oe1zjE2+mroygyyueY8pWQ8tMuwpaCXwkRyboMYCPkCMLv+dUhGwlEhv3qYrL9ywBBo+a0sklAcAwUkqIZOtiiNupla1jChdtfM1rjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjPzSyHvRJ+4Mf53vuuZ4JGCejNn1W9cQK/vJefGaWQ=;
 b=ZViBqhvrghtNAp285XdoqoJl8IbHPrsQyuVnkAKSp+zOQKJQxYv0IdUMPX6MkP5Jpc2jJWI9oKYjgn3NX+w4r+/GIEp9iBfFwGYDTpL73Tc8IU+uM7oAQbyES4vKt6uwhiJv/dMjEt738+K7HmY46sl9iqhnlrKS7i6jj9y72JI=
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 09:38:36 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::42) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 09:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 09:38:35 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 04:38:28 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Date: Mon, 21 Mar 2022 17:38:18 +0800
Message-ID: <20220321093818.24270-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c99b42e-0801-4fb1-826a-08da0b1e923c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB312976BD4CC763923C747BA2B0169@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEdT8y5ATA2pFiY7TNwnJ7+I97ZVSUc531HkPKmRZzXaXklYNyM9uiMpQmVNlbAp1OaWdzl6BX4a7gjD71a+RJf0ktH41MZf6AdDodXK0Dhrmxey+rjBmexRC7IqKaQKrNAdGYS4gLVaIzNNs0nF7FGTqaplrh94duOIRhmp3689qInQdp7nVt9TSCrQZOH3/A5bceiN4aAI7ToaYN/E/0oe3KmY8+nyVcwRfK/fROIX/TFLrbcKcoBb2eicWFyXdq7AKIq038JzO0D+aozqUFWh6Ao46kJLo7+wQMqWfMbf/So0y9iJzEsxy6Goq5qpetBNwTLdS1KQXnYKE9xzLqqmQTjrDHIDkAwygn0OPuJfpOj2PqceE5jktGB8JsaLWTTHy69WQ/U3dvm2d0Ig5N0F7+/n/vRT+Tkz836g7XzM0/Xdqmr6kHwfeO7AVjMr1S+k0gWaDg49ers485Em8XqnZoUaIY/YRMnrRsNp0ogB0wyJXiLzP+ma7U+aAUNRIsMaanfy0DgCrry/Qs61CnO/uI6T1ZsDjQ9DImQrdhq52CP+y/eudQHntb8KPjQRtuiXg+GhxTbwyXUSA4Nl42woMBUglHJSSPWZYIgAY7JuA0jU5ms5AQCwS1yD59nJkhreRcDS8hHlazojLD2Y7hgEtMeUXkl/d47avQ4f+/yNkP7YTa7RWXIqPOG+4Ydk7WLNAMVKWoyCAta+SPgDaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(82310400004)(16526019)(7696005)(356005)(81166007)(26005)(186003)(36860700001)(426003)(47076005)(336012)(83380400001)(2616005)(6666004)(1076003)(36756003)(110136005)(508600001)(8936002)(6636002)(40460700003)(86362001)(316002)(70586007)(70206006)(4326008)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 09:38:35.4991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c99b42e-0801-4fb1-826a-08da0b1e923c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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

Print the status out when it passes, and also tell user gpu reset
is triggered when we fallback to legacy way.

v2: make the message more explicitly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..32c451f21db7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	if (old_poison)
 		return;
 
-	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
-
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SE0SH:
 	case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,15 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret)
+	if (!ret) {
+		pr_warn("RAS poison consumption, unmap queue flow succeeds: client id %d\n",
+				client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
-	else
+	} else {
+		pr_warn("RAS poison consumption, fallback to gpu reset flow: client id %d\n",
+				client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+	}
 }
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
-- 
2.35.1


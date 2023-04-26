Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD9CC7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F65F10E19F;
	Wed, 26 Apr 2023 16:15:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEBA10E19F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl5UoY2gAmVg2oQ21A0EjISBjvSNXYk3bEt206sVQ8V4qn97dpS+9eIXhTlirpnju3RsjqEka7V0Y26aAwfl51N6yj7jfHBcsPedBQh2/pJjeXKwJY8/a+kWZ656GVU4I5KDYkSpVsFc498TZPazdTd2iJ19bTIHQlWuZFO1CWIVMFy74nqacPVY0iscR51IvFD8iX5W3T0TwKFgYs4g6OE+mv/IqwBioEShd2iEns5LoM9c+Z1f0wr4xkWLxMW7BaUdu13xSk7Bj7TG7g6uMwZL6o5wvvlMAhLP08ptVWdstdWLVWC428eKo4i+8HyQVsAtvr9p67Ye7iQYJwmgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf1T448peFVpl3/AWbxuJPC14Ki2HVFgEe5KLmjhC2g=;
 b=dq1NYPfij+y5KaqyJSF0+Fs0wClCfjCtCFYzAYaJPifN6gfFEjU/JO6VFhI5ZIwIP8dRqRLnpALiGCj9X0HENzAfZoN22WplboyJY3XIIvDumxL1ubPRLwtqFuEwJbHHCpyd+AnorIF1tFr0bhEajlU/9cqAIcvwg8TEKTeABce36ttUQiKVSV/+pnv373oWvtI9auZjpczWwaoPdwRmiAOyXIdatAzKWC4+KYemTsrz1hsawxk8efEZnbm8+Er3jV+MWEOK+l6GI32pei7BwV0l0oVjUDc5JI6ysqJwxWnfQz/QUwBDyp0aeSeT/F+jNjw9bPy18hnhxTnvEp4Tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf1T448peFVpl3/AWbxuJPC14Ki2HVFgEe5KLmjhC2g=;
 b=bgCraDdhnxpjV6I9rsoSPiUEREl00QrfZv6uVGJj0KNE7B+znHeSxdBebAUh841zRJJjE+xPT3Y18kx7lm2xl7DymfZuHFwm/Cyo7J3U9v5uF9iLRMZbyIndZdf1ieUHNs99cMZX3NzYCefxk9Wj+w7DBxgUJtn6oPHdmJf/EAE=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 16:15:37 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::a8) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 16:15:36 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:15:35 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: improve wait logic at fence polling
Date: Wed, 26 Apr 2023 11:15:19 -0500
Message-ID: <20230426161519.7840-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5b9973-f7ca-4702-b99f-08db4671788b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSkbLR1icP2CNZH6EUolW5udWsQlw7OkYH71vrcge1XCXc3sLHvD5OkXpKpJST358RFOQ/LfK4LvxUp3Nv0VRy7r2/CeRFRYDQyE/QzksBDsLkPH6ZuK6jmKSTilKv5DFsGLPg1RhB5FR51lyRxazK30u7F8T4Xnl6IYLxP2JTpXs99lfaWh7ia5uibo89nvlf4JKgB7+ZZYW8qqUPVp6YXkwazPYllyYURFcOJsE/BP5XQ5nRKKcZ6d+XLkv56DP9Yw0PmHUYiowX2gBZ0rwHB/sc8tKkbcux3IwJv2jLpJ/GU0Ty0BElJcZlY99bL96Y/7Ure04Di/q2CE8gIRTb0UcfPr1A77AV8NFP2sX+VNegrtSlKJezQVcK/m8JUl47olbEnVAUKAaPT3IE7BBpVYXSzU9X066vuAV5P1eKts7cO0iAIW7PHm9Zm2CEO6WIu902V8h13ZiJ97WsxIqP9wWLmvp6UJTC/XPDonhIc4Ha0Ai3HErKAEqi2SqZmDWixb7D4FiousiDuwuFmtMK8y7j8skhnnbs1rkqj4w0lYsLA8iAjdi07np8/wqDFIHTA+FVfgCkrIiTyH+O9wzFNGmQB4OVqYW6sDK5sL1qBwOg9l1tnmL3Daw5Svvc4hGeTo0TSmNMFdk2JIkkJ+Q0fCvRIha8OsNZwUv9ySB33nw7ZplMu128rW40HXxEhnYRVLdhEtGchadTTIZi2kal45yOadUfxzyv3B0grSZHs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(83380400001)(336012)(426003)(47076005)(36860700001)(2616005)(186003)(40460700003)(26005)(1076003)(16526019)(86362001)(6916009)(316002)(82740400003)(4326008)(70206006)(70586007)(2906002)(44832011)(41300700001)(81166007)(356005)(478600001)(6666004)(5660300002)(36756003)(7696005)(8936002)(8676002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:15:36.9947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5b9973-f7ca-4702-b99f-08db4671788b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
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
Cc: Alex Sierra <alex.sierra@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Accomplish this by reading the seq number right away instead of sleep
for 5us. There are certain cases where the fence is ready almost
immediately. Sleep number granularity was also reduced as the majority
of the kiq tlb flush takes between 2us to 6us.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index a7627cc0118d..9192896239e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -377,14 +377,11 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
 				      uint32_t wait_seq,
 				      signed long timeout)
 {
-	uint32_t seq;
-
-	do {
-		seq = amdgpu_fence_read(ring);
-		udelay(5);
-		timeout -= 5;
-	} while ((int32_t)(wait_seq - seq) > 0 && timeout > 0);
 
+	while ((int32_t)(wait_seq - amdgpu_fence_read(ring)) > 0 && timeout > 0) {
+		udelay(2);
+		timeout -= 2;
+	}
 	return timeout > 0 ? timeout : 0;
 }
 /**
-- 
2.32.0


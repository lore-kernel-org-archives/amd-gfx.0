Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6CAC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EEC10E91A;
	Tue, 14 Feb 2023 16:15:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE53110E91A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Woxwb1RTHbLubY10QpwqEcjitOsleUjn3faV9t4RV6+x6UiSQlnk+AP0Us/BS3KOF7VpWNQUaqL/M1BYP36Df8btzPcGUDer7egzdcy9A0GtKTjVfLUSKePcHJnlonkRAfOxz0w3Y5Qq3MRSn/GORcdWIPt4yZb/c+HVcMao5AuNEokz2b7OfCDOaX5Kvy9obQqYM7Aqyt0ioO6ypYHTKa6rL9pe0AlPDAqftloujMld9+4PatmGLFFObHXXiCNBVKY4yrtJoQBw/ikIbA6TMAAga0xPsVB51eLKOH/l1I6PepBrVT4FkbUJWcT1OHACF00qdAmJQueTOEx2JgwKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUGRnQJH/bGkZ8LlnlYikQzI2j8DqwORGbZZxaYoq0U=;
 b=eIMg5ou6+JHTOh7Af5roSLnzAd5QQxAfyHNgbQy0ZNQuM62ZaGsWW6ND0E5UiYLoogNppjcFzswc0n+c0UYc62FS5irznmHyAN8eVRfPgzUr9BFchVn/7Gl8oIUn1lt6s7QJXGNqH15RX4iDpy/U9drB1hpM9/5ZOqEx4EBAQ+31892z3T7/5E4+7Ltx780zFlBZwazvARHsCZQH4RbP7choqYsnyu832c+w9RRdbmOlyETZGuoq9vZ5akt0ZXWNsxGQ+UjYH39b1C009VnVW33stc70jUdNQULlO6RTRyyUw5C1laNmLBjva4RG19YaKqmgilACCKYYsPPjS6gZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUGRnQJH/bGkZ8LlnlYikQzI2j8DqwORGbZZxaYoq0U=;
 b=aT4x+lLNyecPs2FXWGDE7l+ov3fs1Cy7xCALKGTFOqJWgYx1EGNfVijN6sbf2zjvLcKD7bqj2FTkbcY/Cy8LVBKPN+fixjIs8OaqIU8EGVFf0JlwGSDG4p69BunB8g293VerDMqTkWl6BOpR2b6dIvKVX9ewnLgcQDYrMJMd2uU=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 16:15:46 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::eb) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 16:15:46 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:44 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/8] drm/amdgpu: add UAPI for allocating doorbell memory
Date: Tue, 14 Feb 2023 17:15:03 +0100
Message-ID: <20230214161510.2153-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d2bc7e-1acc-4b5f-55c3-08db0ea6bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kDIhwOdxk+60bMH2nEXFSd5UEtLC8T1DP52yovgcjBtGqjKr7WDFYbuG250L1Ntur69zvmwhVtmnJCibp8ruxQlnqdPq+UrfGXkrJPiF+5p3SUU+RGuEa7puDe9I7G/aOvVxaBeOFfO/i/Ph5+Jg+olW+dEMRQRxhqwPR9n0jkVbR1+VJw+aeSaIbYyJP47fQmBFg7Kb5bZ7av/D6QyVA28gHGfj7eNm8XU1Y5jtaVs01ztL8I+0cfN0fPEf11mTc+ajsS8e8QKqgFNMbr+l68YtFeH9sqf9N2n/dqFUAkEN8fpt3I7tuoCEu2Kzpj9vjuwbzyVzFr4NevRAjGH6Xyc73SdilrHts/sBD28n24/G0OgJcacwynuSLytRduCPL2SltlA1y1FL/9zx9HDISR6GWeEgKZ+sWEmL2XNnuIjPYILzVA5zz3YYkWgwpE8eestI8Q0IVeQKXph8rplcx8ykJ3/kkjNkUALW4kxiYXKiHloF3sC0M6oEKxceUwuTD+t+gL7AILvh0KEDhr9dJ7uuCZRrb2ezHT1YrymZuRE3UaiSD1kdMYRQ6IzyK9qq/Ria2mXExkM5DT/iAQX8D8rbq6gRLgtZYAA3FS92aXEW6XHlX+Io94gI1KSN+ImdFyhNRrleh1DbZ/zxuwBe69dqPydHn/d3eP8l1wiQLuIFhSRTAdPmHPRafNMzqOnZa/iSVr0KngU1zw8byTTrzWxbeOxkG6v/d5RL7Y0vkQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(1076003)(186003)(5660300002)(26005)(44832011)(41300700001)(16526019)(6666004)(81166007)(40480700001)(356005)(86362001)(82310400005)(82740400003)(36860700001)(36756003)(8936002)(2906002)(83380400001)(426003)(40460700003)(2616005)(47076005)(336012)(316002)(54906003)(7696005)(478600001)(4326008)(6916009)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:46.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d2bc7e-1acc-4b5f-55c3-08db0ea6bab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
in the UAPI layer.

V2: Drop 'memory' from description (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..cc5d551abda5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -94,6 +94,9 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_OA	Ordered append, used by 3D or Compute engines
  * for appending data.
+ *
+ * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
+ * signalling user mode queues.
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -101,12 +104,14 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GDS		0x8
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
+#define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA)
+					 AMDGPU_GEM_DOMAIN_OA | \
+					 AMDGPU_GEM_DOMAIN_DOORBELL)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E376BC7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CC210E87F;
	Wed, 12 Apr 2023 16:26:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4AD10E87F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdvmtafFQi+DKDvD21H8tvTMSSbzAqGcgpk52brW8upZwXD6pLlRQsE8UCfT/zm4j5mSG31rrljgWKSEA+Y5F1K4k3bRBaa7rGI5M+LUypOoxY833SKyAIkJPcw8OPr6urNsqbEl0cblOed2yhJIz2G/4P3ecRhdVqpORZ14mZ8HfdgET4qehBPJnHuTRn0yGTjRnC8Jpb6yOkKgPm3CHmcRU0s7ppytp9/ijKfIiBfwEmz/oRSPtaDHY/tqtmXFCIzJOWwED7g/ZyGuBmdjFF8qaTruKiePXdjuMCaWbCCh3n2EaBAddn7NQNfPHPzGA1GPm/xDZYk6j69Y9G5K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8NMAc9xaELi6YqQFymuKFTw9G/B6yAT/4Icx7z37iM=;
 b=dP7uHWpAHWn6UO4J9UkEKC5RIw4VjcyIA02iiRTnM5jF5DS+Exc4ge9Tett2bZ4klidn7uxRwlu7iT6oC5knb4Vr6zR9GBOOqa5LWJRqSutsG67PjKjqBP5bNaN6IqvhHJc7THw5EVkbWgsfdy1oYOl887keJBJYbx3/1tjMjyvYKgCL3VcD1lKI0gAHx7SFX4zgK8OKAsLCQRjPH4OTQU293iMMIurnwiuG8jeJpsmI6XU5nhH1XzH8nrAGZhfRWWTRSDQjmdKBww23fq83g0pnK6+6bw5Vw8K/6rVudbOeah1fJTJCE6bCwFrwHWJuWuAvCX4F1hMj9PCtc5XF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8NMAc9xaELi6YqQFymuKFTw9G/B6yAT/4Icx7z37iM=;
 b=HDyZ8+q08MtROrfxJ1mOaoNetVL+ZUPeKKVTzkgW4MsaMJgZH/8VRhsg8liraBmRGtf8bOnHrop3QiCaIPQ/cCeQlaNMc/xuEUOPC9S+74P8FaKZpnmm+AqgHzL6d2MfoKsXFJLV7pW8s/Za2P/zrUlDwJEM2LMU/6UVn73QUu0=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 16:26:28 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::47) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:01 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/12] drm/amdgpu: add UAPI for allocating doorbell memory
Date: Wed, 12 Apr 2023 18:25:27 +0200
Message-ID: <20230412162537.1357-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d1ea36-2454-44c1-8bc1-08db3b72ab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCd4dCJEVIcPdVkFZtHN1mgi5PvIcqSUdjYz0iDx2ugYeHJA/CytywhrhTFFQ62kkl8c0VzHjTDRdX+XMESnN9Zuoys/WUkIWqloJ2YuXKn8agIM9QsMXh6kAq9QRRv4RTtSHsK8ophWh2xYJN6g9k22FT3Oxa7S8oisNsF4Dvl6a4X7Zw3Zq4MfUnRGU4Wab75+5HcmkPxxQFvN81mhhAke3NQZFs7lO8qwv/Tas3n3oXFJcYIby1xO0IHSjWBNnWbElvL7MOX0iVe7P+WiSkir4t7FhVP/sRWOjIz5SHstyUYF5CWmyyJfGdnxkJYR3UV5K4bsLCH4ucjRKHr1W6xmh6jh139a85Ro9XW3eBo59mpqc6k7CcMF6CPf3llivqKNXjIbW5rZMqcxXs2NL3CL5+gznsvUIOURheoN8cE+1z0IkY46q//0VfsFBF3FG07fNukkWnd4ZRloDmZAOgolGUpgtex+74d0KixiSRk8gXkwhQDX0Xn/mo4wy53XacawtDEn3pcLWnWHeCv4Ck7UPeZtIXFTe1mj1HwwpIexv3gZ2vpDtfrYmlpATDoRtf3NkQiZDDeLXnl6oOGKLQhNRz6TMb8PTxTwFyxVj6XVtT7wLFuzwqpF6jYr0VX61urM3PgrnDJBSr0EVTQ7ZiDIdkv9i6SDLNAO43NsmB7pTNdwMU+YsRvbV+C2wr1QI+/Ul2Puifook2HFNsAUsXzX+I7Wp/0GstNbGeWrzmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(356005)(1076003)(82740400003)(81166007)(26005)(47076005)(83380400001)(16526019)(36860700001)(336012)(2616005)(426003)(186003)(8936002)(36756003)(7696005)(41300700001)(316002)(40460700003)(82310400005)(44832011)(4326008)(6916009)(8676002)(5660300002)(86362001)(6666004)(40480700001)(2906002)(478600001)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:28.7377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d1ea36-2454-44c1-8bc1-08db3b72ab36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds flags for a new gem domain AMDGPU_GEM_DOMAIN_DOORBELL
in the UAPI layer.

V2: Drop 'memory' from description (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
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
2.40.0


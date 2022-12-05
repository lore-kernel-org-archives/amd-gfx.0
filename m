Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5885C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 02:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EC810E093;
	Mon,  5 Dec 2022 02:28:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306B110E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 02:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyBOeVN7wGwYldI59ab/PMSPpzWIu1ZJk7n1c183txU9pLnfIuBnnLViMjpGa2mRMfqXcob7Ad/xrCElOaFabDvcKGXrJpnIEppc0PRlfzveAhLOc7hrv/wTIkOhPfZ5xBJj911hMo6r/rBjgj0sgrRytN63uuL6+KvulaJbTU2sB4AkQBSlPuucbal8hDs4HK3XwYsOmlsxiD9ArIVYIZy42J93ypCy4cmv0Lhf+bRi9ODZpd2PGhmN8T7xKEqFyzfR4ateTKSNGV+NW7jppP75+MXvmhwKXnPWkjXNa6vQTUXFCry2X/IHa31raxk2Ut9z4o5/BoYz8zxgrJaUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsHKE25YhqNi0HMGqBBqflz4xP+ja0tynCy2BF2ma0I=;
 b=T1YLuiHimiOwQirKWHlydhK4tZEbKGBUEbzqclRtJ+TpCZ6xOVpdtX7G8dpX7FyQBc5iHBtZgaeIbbbTQHGWOIRkjMLmIg81GOmDoE8l22ZAtWS8fVTh8u+Wx/ULzoZNalj7I5VtAFVcLaNgSCUODfcNKhiCoHbrSpINJVDDZhbIeNXPwp4fyLXpL1gEzF0e+hi5beBQgXR/KtR+wyUka4626oUTDQfgmWBDdVc87klEs/xQm/CNAKTZuKbkDF03O2vIxGylj0QH4QyJw7JJB+KYwAGXRnl+tyS2eKGy2p5syJ07Ga9ZbFX4Gfr1GoZ9mdDHMVozhTRMqGSF0gEOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsHKE25YhqNi0HMGqBBqflz4xP+ja0tynCy2BF2ma0I=;
 b=cN8SdAX6tFMX4q2gHWK2x63TgSS4+gTvOSaKpkpuQuwgJF7GA1AiyVS86EUAAd5PrKSXsb0CnXZN+f7nfG9ULFR8FVlRhrxmIM/URf7NdiAbOiM1PQhhteLRms+qJMsKEmuCR0jcbYZdS6wEfvbGYmea0qZzDWarktgEUy6D/3s=
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 02:28:03 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::33) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13 via Frontend
 Transport; Mon, 5 Dec 2022 02:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 02:28:02 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 4 Dec 2022 20:27:59 -0600
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Make amdgpu_ring_mux functions as static
Date: Mon, 5 Dec 2022 10:27:44 +0800
Message-ID: <20221205022744.1024401-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 7648a95c-7881-4248-8e41-08dad66855a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28mtS24W/5qJk78p7QzSJs+az4f3pe54FeDZ2YZdNdDvBDaJ44Z/NTETZ1jWF7DltHUEz8McHG6XvFR796TG1A9ao/f2tHr0ww1DQ3Goutpu1NFIcGk5RccwaOTlkuHzCTdBGEXaK+CXh4OvYYcwFAP2C37q8KJtKHX7QhEFm/QDsgcFPsuAXj/x7iFpWrHa8S3qZauxOG/sWy+YhyHV4N9etVRUo1g/8fmrbAj6ffeRtnV6t+QQa+N8kDIgKuXWTwMCBKjcPXvvJao9C6+JJRFq5G9R7o+AQ+sohqprS2FdwB11r6szi2yOBzwALhUOVgXfMcK/W8AITYn//Hul4LsUOW6AHFu31h39xik9bqyiRnd9lhlav+3Kx8jqwQKiaMawsESZ+7xKJBXmJR3ZLD2ImRQaTryZo535VE776228cRmHrdZ24DfSV6M2iJNWhcZ6/9mQcnJHG1vTSmRNaTT3SA+WmDpo+PCzBeHH/4ouxxrWJDjZpr9wkz16QAoYBLgR16QcrbgvCKQA12KRC6AAvo5ZBkkzcMXw66u6xZu8eHGdhPgjC5mKK8IVxGF08x12RrR6PJeoI8Q3h+C/Ob1yyhIe6nusIQnfFFEj3Tg6ESOG7Roj9575aavGmaUbUq4WoOiw+1WFRj0otOeUtspvfJLkkvFYT8oRZAuhsa0u3nKSKg0S2vA5RbMU8RvmbbKXQL/nEXOFHG/TYofGSfT47XQS7oz3XGKRd/eowV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(86362001)(356005)(81166007)(82740400003)(2906002)(2876002)(70586007)(4326008)(41300700001)(8936002)(70206006)(8676002)(5660300002)(82310400005)(40480700001)(7696005)(26005)(6666004)(16526019)(186003)(47076005)(426003)(336012)(1076003)(2616005)(6916009)(316002)(54906003)(40460700003)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 02:28:02.7824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7648a95c-7881-4248-8e41-08dad66855a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

lkp robot reported missing-prototypes and unused-but-set-variable warnings on
some functions of amdgpu_mcbp_mux.c. Make them static and remove the unused
variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 3348337379da..62079f0e3ee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -350,7 +350,7 @@ unsigned int amdgpu_sw_ring_priority(int idx)
 }
 
 /*Scan on low prio rings to have unsignaled fence and high ring has no fence.*/
-int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
+static int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
 {
 	struct amdgpu_ring *ring;
 	int i, need_preempt;
@@ -370,7 +370,7 @@ int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
 }
 
 /* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need to resubmit. */
-int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
+static int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
 {
 	int r;
 
@@ -434,7 +434,7 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 
 static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
-	uint32_t last_seq, size = 0;
+	uint32_t last_seq = 0;
 	struct amdgpu_mux_entry *e;
 	struct amdgpu_mux_chunk *chunk, *tmp;
 
@@ -450,8 +450,6 @@ static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct a
 		if (chunk->sync_seq <= last_seq) {
 			list_del(&chunk->entry);
 			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
-		} else {
-			size++;
 		}
 	}
 }
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3642BC35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB5610EA4B;
	Fri, 15 Dec 2023 16:01:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D8310EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yil4R2gJRnDEPWC1KTcfeLKJ151HLHkbAJhD1xb5fviJkeTwSp234RIVRhpJSni6mwRfP5685P5lwnLbR0th32mWDBbK1hC90NyekB2F3htaBLwd+qTFmw8RVIm4hCHl2VdSN8l6vyXZBIY1EmrNETJt7fjbBVA6HPgCcSC5PMChg3e28VnOOGw2wS0DgxSFjD/c/UXUvTm8WVN2OfD44q14XfoMWaaqf81MVCASntVhN7xeRuQAi/kCaeguiTR2JVZO3oiuvqDugHzlY4MGg2OIemv574fGWF7itdL1ir8vRYE3wKDDFVGRTudJIB/q4cPGk+XwvZSmdybcsS2FRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWNKK2/dtZEYLO+yd2kbK3L9aHjDPeDEpMNcSI+kCUY=;
 b=OhXdf8jF69FVRq3JExcnM80HiPVXyD3KKuNykQz7bt/6ajBgIMr2+6tCIHh+7/+RR/7yYoBn7u2atCcKuNMbeUA9Fj8WS6KI3PlhrI4AK7wTTiIOB+dAwJ8+jkpUUBbqyQJJGW/34hQEUBNpjBTOC9+SFzsLYiPnb2wmSP4L3FFqQHZ4ursm5S9HAJ9Gy0Lb8T9ZP9BDJxqQW6DLBFJCxsNhcgKIgpo6WKXTu9bFsOa4zqYAbJZXoDl61PKNMyheBb+9Tpk4GeJ6RRlLOEIZ054PcP7S3dK3KQhSYV06Y3AfchL0++BbVoDBnKyIfV2LOjCrkYv1ZL3q6coLkr1adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWNKK2/dtZEYLO+yd2kbK3L9aHjDPeDEpMNcSI+kCUY=;
 b=uaNx6POFwx+/8xoyGJWvWIIH991rUF7qjtQd8fqzQI71h22CAFqXWwgW3B27GN/1u5qLV6V1lo7QBUrLVyM+I0xoDMpnDud1pt2H80FOpSmCXW2XXBeFFK9uF5raL4MoSy8sV0xYGXICpZT79mVtv5efJd4ehqSSHbWpgLlkrxU=
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:47 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::2f) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:44 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 18/24] drm/amdkfd: enable pc sampling stop
Date: Fri, 15 Dec 2023 10:59:45 -0500
Message-ID: <20231215155951.811884-19-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b3a56b-4362-42ad-7739-08dbfd870032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BoMrmDhTjd6B8zLXmvbTh1RwJh0YejjaTUr0uNu8rEGOd/JmlZVEXmz6UWrazX/CG11kp3rRLTwMzEsjm6169n/WsyllBzbnQWKuAG5GmH2P5Fv18elezAGKjbNT5AKjscigML+lzUbCFDdZDC8ahX2xTpx8XEU+0Lt8ECLZHln1m7HQp/wh2wkU62wYljGikSkC7WeP6LuqEmdQ99PUT2ha8X079FV8mApcYO0j3EcUBhjjnkaSOSShXuvEq57mkGDFxZmzCqeLO/Qbj6i+y16KDlsHKDaH3JmC8CPVM0LOC53shC3x7geg/09ycBXbkFo/O76s2PPq6CaN896NJ6WUYGLZvgJr5BjxIRdNAvaKLmVHtLvkghUt9oi8ZOfL59qtDqQ1R+C0Y4WDCzAzCIhui4J7q7H2427dpyiPPHV7oyk44BG8RK3tVXtFbZTRveOKerOIFPR2t56ZjvWJl/SRrMdy/NLkOXRJwUAE1lMCSA7HxUJHkwu8O0kOkf4DT7nQLVLlEmsKmfzhubjwQCRyz4GUFHcwOfY1j+cNNML13jgmz1ej+THD/WDWIe6w0TtbpCRuxro5R0h5VO02MWGn377GwmQ1JA3UHRckc8jHWGiAkuSdV9a3zZe2Q7AnyTwk4tVTTJW9EtUDbvKHMXzEpZU/vyTTP+42q/DR8ptbMYIUt+KQO3zozi34xZveDBSLN0AMEuD9arh+LnypiV0rA+oaN+TPHPRlrOEFE1EMCZ8BxuEpsaF63cPSILDm3+/cJoPZQwbeuC8Gxz453w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(83380400001)(336012)(426003)(16526019)(1076003)(7696005)(26005)(2616005)(478600001)(6916009)(54906003)(70206006)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:46.7370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b3a56b-4362-42ad-7739-08dbfd870032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable pc sampling stop.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  4 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 07e4c4a32e7b..02fa481d7457 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -88,10 +88,32 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd)
 	return -EINVAL;
 }
 
-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_stop = false;
+
+	pcs_entry->enabled = false;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, true);
+		pc_sampling_stop = true;
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	if (pc_sampling_stop) {
+		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
+		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, false);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
@@ -233,7 +255,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (!pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_stop(pdd);
+			return kfd_pc_sample_stop(pdd, pcs_entry);
 	}
 
 	return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b9a36891d099..0839a0ca3099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,10 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	uint32_t active_count;      /* Num of active sessions */
+	uint32_t target_simd;       /* target simd for trap */
+	uint32_t target_wave_slot;  /* target wave slot for trap */
+	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
-- 
2.25.1


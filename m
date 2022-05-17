Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE679C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D7A11380B;
	Tue, 17 May 2022 19:21:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179EB113802
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFfXlrfVJ5WR1somuY38rCR15CoGoqyP2kTOMIo5qfRnvrqwFazSozmHIyKfP9k26JlFw+Cs6kOlxkdaUo+MCFgDzpNDCVb1b02pxReBwEGuTLJH0ZONiME9Vs2z/8qujbpI8gLGjP9Hup3k6xTG0N9Ct0KczUVDxm5jItfSiD/cMYxjTyYd3zLHppZEtKEC28cGUMZTLIZySZf2ILK18R5Z0ls9viJzFXk/YSFFAroh5ILBTpJODZHdqpI6h0pXkZFEFRjlgclflp9Q2/L8n/bHwfS3K9Rah/3CtRJRjAt4y0Dk4sRHg6po4Mc2NAhLRV8OEpQvkDDvVOgSgvHRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFKf3cCpBc5nrjjoYOGMjW8VENM08PLvom1XWtLyo/s=;
 b=LyJ5YfsEx0VYXGJ9ecEjoSKKzsC25FY5bciE5Yv7DpfXs/wPaWwRd6JHsY49LVyr4y9UJGhoOeTzy4QPi4xpm59SXDESQgWVP9gRM4qM5gVDQjYDzFPDlnYhOAXGQkS9hOdttPQHAJB7ZLuKCSJPG2mg4H36Cj9r8RZs56gfQzTEGBU2kTNFA35f9STRA4NMKNTbzm/+pVC+54EQnFFdZDuwnmn50oIErdoiiC+Qis+HNJOZr29DuvKV5Ko1cghMjTSIf44FDM4jYuEZvFMzQ18FcpLM4M+x44cVZ+vUt9AgpNBf2eiZT8IjHkLdYx/FsWAR7AbEE22O8siEJooAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFKf3cCpBc5nrjjoYOGMjW8VENM08PLvom1XWtLyo/s=;
 b=tB6wVOEW4AxZdtZNc7Bjd1j7j2MkP94wawjWcie/MApswp/1kxBUwUc6qSf8Xnle6GwVxwBB1WCeNNOkfyZ63YkUbCDJZJBA55fQGqpGUNXimaLMkxjhkW8U3aQMM6YdxziSnciIkI87KW1iqn8cEZPkahgHzZ+yf9IQU0TBdRs=
Received: from MW4PR03CA0286.namprd03.prod.outlook.com (2603:10b6:303:b5::21)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 19:21:34 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::50) by MW4PR03CA0286.outlook.office365.com
 (2603:10b6:303:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Tue, 17 May 2022 19:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:34 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:31 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Date: Tue, 17 May 2022 15:21:02 -0400
Message-ID: <20220517192102.238176-8-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2a28cc-6f68-47de-7a23-08da383a74ae
X-MS-TrafficTypeDiagnostic: DM4PR12MB5748:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57487ECF53F5F85B27B2502FEACE9@DM4PR12MB5748.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4hqD2LTZ/BV0gQzBAVTTECDr+DfeSMYO1nhiwYZQEdV1amnWSk1/KEVE3pJATGDj9mU9iJ5rjNFMMs/jJoUN9tcHT45JwNf8yvPYA8Y6njJYZpS2oCzLe6qYhTgrV/3ZQjEhzEkSHID1cqSdzHXCEDXIhlkv0iir2dL9ipBNjPDcNObcTO17KwdjnFfwnVBHljQH241VcXOq+MOMOzOeLaOhTb9vbBfgiuOwS63CVYBxROEmLvZ60/WZTDuBIxhV0xFtbivZKPg4kijgsD/Gd+apG/ByHoCLDtIMhuYJkiYatcPecd/MPNvnTRHQYdJfe/ezECkmBnG8woQnrgymxA8EeU+so8xo76eRr9PcLwg2mZq8TKbUsCe54MmP95wZFMWS9HnP+v0DAKfGmvrbdsBzLngNa7QsItJLnYq/fuOHJ8xJnTiYTSJqHhS+AQyPpAyxuDHXygdAgT9GGtmI3jhU/JPWOLpiLBQYG8N+EgDUn90pBDxKzvr1c3M5HcweAiuU9PgPMhWhRAM/Q6Xj/Bz18frDTXOV4MkSczt400p+VO9hfbS2AQfiKI463B3mAT1Eq9wYot8MGnH09KHo6RwHh7lc9jPRuAj9jHhLW6tq9AozyCYmi/ce+msCGWtAokskNEeVaSjO/fin+Gtwls3tSdY6rLl8gICsE48Y1VA6RSPT1QIysKj7Iske/fMAxhllT4xpXn0D+P55siS0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(6916009)(36860700001)(426003)(336012)(2616005)(26005)(54906003)(47076005)(8676002)(82310400005)(8936002)(4326008)(44832011)(70586007)(70206006)(1076003)(356005)(7696005)(36756003)(6666004)(86362001)(186003)(2906002)(83380400001)(81166007)(508600001)(5660300002)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:34.1321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2a28cc-6f68-47de-7a23-08da383a74ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We skip rest requests if another one is already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 65f738fd4761..43af5ea3eee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
 	}
 }
 
+static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device* adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+#if defined(CONFIG_DEBUG_FS)
+	if (!amdgpu_sriov_vf(adev))
+		cancel_delayed_work(&adev->reset_work);
+#endif
+
+	if (adev->kfd.dev)
+		cancel_delayed_work(&adev->kfd.reset_work);
+
+	if (amdgpu_sriov_vf(adev))
+		cancel_delayed_work(&adev->virt.flr_work);
+
+	if (con && adev->ras_enabled)
+		cancel_delayed_work(&con->recovery_work);
+
+}
+
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5209,6 +5230,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 				  r, adev_to_drm(tmp_adev)->unique);
 			tmp_adev->asic_reset_res = r;
 		}
+
+		/*
+		 * Drop all pending non scheduler resets. Scheduler resets
+		 * were already dropped during drm_sched_stop
+		 */
+		amdggpu_device_stop_pedning_resets(tmp_adev);
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
-- 
2.25.1


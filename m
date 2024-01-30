Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD208C48285
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 13:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA221130B3;
	Tue, 30 Jan 2024 13:15:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE02B1130AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 13:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7wOsWA3qg+hYG7Gj5QJygdq5AqlZcalxuzNKxdStUKDHWvwGNmGWYv4G8xdWvh22G8r5b3Nkv3HnKG+T9G+LbaoM9MnVYXkGoi591ZB2g1OCWRmF+eRWpjLspeKZVQncRP+EkhYeaQxWUvb3kfr5Sfb5aegfJEEYpqoi0KRgevVZyor2S+XNxEJvYRdmGYj7xBWZnta2y5+JvuCcZdqzUrHVNmmHrVHSmGLM6pR9pQCNDUcJBZgzcPPuwSqwxKxrckyIHYq460Wt7NemI+4yP6CqX+zF4qP8inZ4sGVhMYIImDAj5HExVKcH6fWgJ8hPI5Vn0XzdjhFH5nFJldxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEwqW/iPtxqZ79DDYaOpGWn4coW2EcWvd0hS7MLtgCE=;
 b=gAwT8R0zdURBFpQ0/wp4Acq6gJpp0lvip1KQ9Yj9MmJy83MxsvVCpgK0q8KN8VoXwH/rL/3C8D0P31F3qOofX15c+CQPibtgH/ZomMTTUMaq04zJOFCgVdwdop+HXnvNtXLx74D2Q7fwjD8RSlLoyo+MFptOnwQvre5PrtNq3Y8haRvosAmGs7FPMb+0zAIoHDDDACksjWLHX8yhUByt1gkoRV/jZg1gS4tHlcqWYf0bv47KXZDzKedDVc0J26iX1AbAH4ic6AAGEL5ZmcDWHYxORTYnH4I6FexYrWYhCANHLKn+xX3/09M5N/D9EbQrRRc15g5FzQSft6oOIofyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEwqW/iPtxqZ79DDYaOpGWn4coW2EcWvd0hS7MLtgCE=;
 b=GpUWcFMH4V0VOcTF33PG3/2KE2q8Em2qhAzn6q/3LBt3D3xj5ZLzBw4+rColPQaliIbJHuX/npqybxPtHi6zW+kZr1jYimO760YfRUVBIvhTpJAtX7n/Dfxl9WFZDl42Z15cnuPYudK9D47hyXWxlyq/ET0ocYShTOuU+sVBWts=
Received: from DM6PR07CA0116.namprd07.prod.outlook.com (2603:10b6:5:330::13)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 13:15:15 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::3) by DM6PR07CA0116.outlook.office365.com
 (2603:10b6:5:330::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 13:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 30 Jan 2024 13:15:14 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 07:15:10 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn 4.0.5
 suspend
Date: Tue, 30 Jan 2024 21:14:57 +0800
Message-ID: <20240130131457.3433971-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 070fafec-040b-42d9-fe0d-08dc21957f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCaWMNOtwUSMvAhBBdnwj5SIvwXG61D/2CL1NPSehuVl6fXGOSibkwEtjKXa+l3hhiEAhQ5yK4gVGueoiygh/N27LW9EB9IjzODlM3DAyPVT3yUzmhyriVB+xqs0iv1nVKaef9HiQopIrVh7J5V2fCQzSg9bt5TtY/p6VIGTLO54yBmiVT9w2RVEvBG/54HMPZFXlXzLlIFTQ+qJx+XmcetGiQ+atwdhB0yJF/UReeMQ4b0w4wnmRzcAPsPFjx2qoihgJII16xjOVl9L3U9LzuvQgkXo6aDxhzBLZ0paj/HEDzcVUbgrcEI32vXQO/7xoLJo+gVQmiZmw0Ipd6Xy3a5w1eT+d+6aqfUV3sSHH+8QB6it5SAWczxQED5bZ+QtizaYadP3IeiTQFni9y0VetjCrF9JAjO2pbAbBCoybeeFe0nCWiF1mYX+PoKemtj/GK2g+jtUBLKDHLkEwqR+0afttFtWa6h7zzLnExVXUF1N2BnQ1l2sA7m+3SotekXA/eX9hIO5cNBI6VxE6uqQmmCBLsLLt5kJ+d/+3CjKaja35algk8/+XFsHe1a2R3ed+4u+IFWc2II4blDpQAJahm8QORzf6Ouk8J7xlnQ9FK9ktcAc8heq4u4KYjx28uCMrxcBpGddfkpKWp3oIny/aOFEXLdi5T0LOldksSfmo6LAN0udDAm2BSPektTVGj8D0tjX1cOYAe7elZdHOY64/dFvmYL2bmsKoK/xkKv6d3VwG54yWvciI6XIWUweWgw4XbS3PcFv4huO9BYAml3Q/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(82740400003)(81166007)(356005)(40460700003)(40480700001)(316002)(36860700001)(47076005)(86362001)(70206006)(54906003)(6916009)(70586007)(7696005)(8676002)(8936002)(4326008)(336012)(426003)(5660300002)(2616005)(478600001)(26005)(6666004)(1076003)(16526019)(2906002)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:15:14.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070fafec-040b-42d9-fe0d-08dc21957f3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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
Cc: Alexander.Deucher@amd.com, Veerabadhran.Gopalakrishnan@amd.com,
 saleemkhan.jamadar@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no irq enabled in vcn 4.0.5 resume, causing wrong amdgpu_irq_src status.
Beside, current set function callbacks are empty with no real effect.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 -------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 169ed400ee7b..8ab01ae919d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2017,22 +2017,6 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
 	return ret;
 }
 
-/**
- * vcn_v4_0_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v4_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
-      unsigned type, enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 /**
  * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
  *
@@ -2097,7 +2081,6 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v4_0_irq_funcs = {
-	.set = vcn_v4_0_set_interrupt_state,
 	.process = vcn_v4_0_process_interrupt,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 2eda30e78f61..49e4c3c09aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -269,8 +269,6 @@ static int vcn_v4_0_5_hw_fini(void *handle)
 				vcn_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
-
-		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
 	}
 
 	return 0;
@@ -1668,22 +1666,6 @@ static int vcn_v4_0_5_set_powergating_state(void *handle, enum amd_powergating_s
 	return ret;
 }
 
-/**
- * vcn_v4_0_5_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v4_0_5_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
-		unsigned type, enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 /**
  * vcn_v4_0_5_process_interrupt - process VCN block interrupt
  *
@@ -1726,7 +1708,6 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
-	.set = vcn_v4_0_5_set_interrupt_state,
 	.process = vcn_v4_0_5_process_interrupt,
 };
 
-- 
2.37.3


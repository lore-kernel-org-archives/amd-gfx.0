Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB40C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 16:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24FF10E038;
	Wed, 15 Nov 2023 16:16:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1836C10E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 16:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOMtiFEDWxApLRUvkp2G6r9iUVXbsvNom9me6esy46Il4GJSBm/pJ+Zs025KMhpTTRBOyO/+wiPt67av2mNjoaqojE5aG5yNxuPF6uFFjdntXXjW0xaxDOYu0ubaNn45qDOHQ3g8UhyBu1MDvLvzjhdSuLArnyUnppiXGMe8E95zo8Z3su7x6U7drAE7IIWVikDJ1xndG0wfeJ+6VK0Wo3YVNFlPt80tIbKlHM0kBNB2MAnu8jkSN6DCN09EmnrgmziE68VeZopDJg0zuryt8OECuShlKAzxRe8pHseYrd5nTLbMcb6a/wAgeqNso+Js8q07swWO1VlvNSghBySeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQHQk9/8JfG7LuelTaqm0Y0A9ZHmOoJJwDqJQhIMUKg=;
 b=ZVkFBsnq3mwqfM/UVIUffwwLbWFS0kkV3QUQTEaODbof1yfBXu+BjU2UDfVzEsGUmfBSE75q4wxzcOBKkqOpnQm4xgCq4DE/lCHVA9dRory05mGKRxTYPQr7oc8wdaeI7V2PwAqu/RM9eN/gts0zWnKaS2Ebi38F5Vi9IMuLNs/UXr1IxHq3n4JOfIP0dvyQTKrFj1RNE59g+uwTBbA5QqWTPnGMlOvkimVxrG1zGPJSYF3gyFM+u0dYz7Ty7qemvzyGpOsSzeESg88E4yJIPjqoo+EmpFk0/mqJHjXO7UQhSuzM+aiDWCquKs5bAKNpz+GQuXxHqegYmws35BhTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQHQk9/8JfG7LuelTaqm0Y0A9ZHmOoJJwDqJQhIMUKg=;
 b=sjwdbIfCzbUquxNpi5nxhWzGqrV/sqe2wow86N364zsXLc45jUbmzfrm0GcYZBxFqbQjiS6Q+xMOPkDyeazwXf4cayq/p8YUmplWw9jgb51TFHBcsZgbLN9nYolvkCxNAOPFR9O8XM2FmouI36W85o63RuiDVgCRC3ET4Y4HdCE=
Received: from CY5PR10CA0012.namprd10.prod.outlook.com (2603:10b6:930:1c::12)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 16:16:10 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::4f) by CY5PR10CA0012.outlook.office365.com
 (2603:10b6:930:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 16:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 16:16:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 15 Nov 2023 10:16:07 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
Date: Wed, 15 Nov 2023 21:45:40 +0530
Message-ID: <20231115161540.72584-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
References: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 11576db7-205f-4db1-8fcc-08dbe5f62e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HqiOMfuK7bYigO2SYkV3jiiBLFUCLwwNIqJ8bA5My2bCAWjlt7qXvjJLwWQw5XqrpV7f12A1JEOgOz9D5po628ehbEuPejrOlB7ZN2q/onI71M+ljSkxpxZkEEtCE2h87XhsOVqdx/vatMqZ3J0M8LT/YueVZM03DuymNOoBdooVAhfda0sObgOeV6E1tMlLIRFHbKpdtQZfRTcFUFyvftv2PZU52krpw0DiOC3KHruJxkEbFrTIIhSUHAngvEsRKvL5Ic+efxhrVYDnG2RQqemP3sHvkTmbjtkYco+vpDruELBWWAd6S1Fg18Fm28hKoUchccPoisuNg4OW6Y09uwYKMMC7e8rShKi6Ps0yoNFKDUqqJa3UMp9fLhYiYVqS81zzQARiYOwMH7/HAkajqjpw3C/QceLo4w74aUjKoiDSAn9yWtWGUIo7Qp/HW0x3fGY0EzlzXGXugB9echV3VJP62yN+OQAafkZRcVhLPyGxju1/sVffHk0AAgN+TxuUkQ8HA86l2z67EzT7EGxblIxncmVgkd29aHT19WjW+8mJs7/zMU6KPGbG/Sg0o3VBJ02j5hkQA98+okbvVMp1lRPK7/s/BZnh/u4hqFqDNungtDe7ms8SEyUJp9fcWCa4QPGYL/zsporpAk7YOflfW7SCacYIWIwyhtnaLOWt/5OCE7ybT+EUilURqtL4w/jyOTGqfwrGArE0j6ZM1IK3sBfk/F1AIuUIR0b2/3QfZ/sYzKc5ZbyExIDteQ8XTapcQYXl0URXzSejdiLh0LQ+A24VxACOh1A+sVG00+AMxPvzUAQESs23C1HSVPzBctP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(7696005)(4326008)(8676002)(8936002)(40480700001)(6636002)(316002)(70206006)(110136005)(478600001)(70586007)(86362001)(6666004)(83380400001)(82740400003)(44832011)(1076003)(54906003)(16526019)(66574015)(2616005)(26005)(426003)(336012)(47076005)(36860700001)(2906002)(40460700003)(5660300002)(41300700001)(81166007)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:16:10.2137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11576db7-205f-4db1-8fcc-08dbe5f62e38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function parameter or member 'xcc_mask' not described in 'amdgpu_vm_flush_compute_tlb'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Updated xcc_mask description "mask of 
XCCs that belong to the compute partition in need of a TLB flush"
(Felix)

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index be084cbe7501..9cd2595f6c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1360,6 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @flush_type: flush type
+ * @xcc_mask: mask of XCCs that belong to the compute partition in need of a TLB flush.
  *
  * Flush TLB if needed for a compute VM.
  *
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31915C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 09:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943416ED12;
	Wed,  8 Dec 2021 09:41:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55906ED12
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 09:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6zup0ZcSsDu9teeNj/6SIQ74lUp1tDVhnZpVqrI5fNPOXjnkVJwoI6Z6OLWDUaB+f5t18ZilgXoyPsq3pzVZW0v/6IuN9gBC7O5zDb0eWRQ4tgatMyrT18KK9hfID0V/oRznX3LD+XX42d5+4wb6/yLblP+d286xX7tRQmHTNo58kdWfz7vZU0Z5FYogV2QZlLXbOGq70oseyn42ffbDgnaCiFihS5ma3NPy/Ok92BXv7NGs/0duWHzF/7M0Ix3lnjsRdy/LC+2x/H/WELQxw/RrxJ9BjjBSsPPke9WNZAyQA9dDuhaFczbsaIbDQypLO0LfCv9k8TspHtxTleZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxOpB7rEznOHfXfF67dE9O6+YsVl1R2LGufQbK3UZH4=;
 b=h5AmU2HrFi7pWLyk1Pi2djuQRD8N0s8WaAbSd2Ww63zxvM/fPsdAu1Gc+F9BXoqS4W2l+CSPJN1PeUlWsOsMbkOQYCaRq4dd9oILORadG9i34edDjjCveX2Cr/zaINg7MMraaW/qS7XRnsDOG+YogjR5PfmiB1em2Ba6JN/gZzppR3sMgOWnWecVXBdCEJ9W73ZaFIqSN2/GShPgC/UTXcS1eolj3FiH8ECTe57abRVk0TYInaPVCnt2V1htXvHlwl4AB+Amst5gIrMpG0F0SZFcma1ap6klAbzeE1scVnNi1qZqrq7qUqOo7vx//AaHoSvgIzLfdUjscYnlLVf3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxOpB7rEznOHfXfF67dE9O6+YsVl1R2LGufQbK3UZH4=;
 b=IeWnPdlLZtk3VbiLxjbBpiqF/PrDwHZPGBHi9VH39Db/astGfZTpbgbgLm2IerWGJAwtkprsYU0JOxOpIUit3W8W3WBlzF0ibRyswzLcpaVomyUj/crLMOhhiwwAjxOIIX1x26FZXd4fMN38cBKiw+U4wHJFHrFHD4uecTBGoMU=
Received: from MWHPR15CA0032.namprd15.prod.outlook.com (2603:10b6:300:ad::18)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 09:27:37 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b9) by MWHPR15CA0032.outlook.office365.com
 (2603:10b6:300:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 09:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 09:27:37 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 03:27:35 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: only hw fini SMU fisrt for ASICs need that
Date: Wed, 8 Dec 2021 17:26:42 +0800
Message-ID: <20211208092642.173385-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208092642.173385-1-lang.yu@amd.com>
References: <20211208092642.173385-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33cd2f69-5001-4e59-43e9-08d9ba2cf976
X-MS-TrafficTypeDiagnostic: CY4PR12MB1270:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1270A83461F4D35DC97EFA3BFB6F9@CY4PR12MB1270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71wkUHL6fETkmJppNkuyaIsvOTj2XeRUGs2vD+ewXOhmI12iA6map6fqEDSkWsrd5EsrA3VYhNhgfZNYu6d2L1YW++T9goY0nudZkhF0xAoSYF2QcH7e2wwBx6Br7TrA+VP3cwu7SD1y2UFn+8tPT4/Q+VdQ3LwZgp9kJFQnw8ddC5qfS1CayYuaDPMs+J6g1Fwr1WISeGSJc/0pMWJQW8SYvFPp5VlXk41RCT0ckK/EruYL92sQ1AOm1kj1L1/ANCfvj6VY/xXG0SlyfOLUiFda+Itm5HJ3XJJGOT557qjit4Hd/Tz1eRViMjRclpVHIjU7ELeHS1RsTNd3FCLA2kK2Mr04/KHIEoruQ2pPhlA/IwmupiKZPWygVD76lQ1lro4S+bRYEX7qz1cJFC3/ZVxGIZi6pHmhyH/xBm2lVQQKsECqsl+WRaQVaU0qBFdXJcKOwocF7wiAwaZwrEPpgo+gKH7WmHX8vBXD5JJmeukLBjHpEr2W4DmHTy/xxX4rTGY1JU9zUd/4d/rc35m4NrHCokSXFoRG3tUPD8JpKXcm1jTJR31Lu2+EONh322Xjt/z3b6EFBCm9aEjfXgzb0ZHLCfqtB4olWLh1DddRnexi5xjGPmuwQ27ECAaBWR3p2wit3Z7knk6VSd53a1QAr6FEK04rb6d2zacEQoUW7NgFyraMkh1dPFblVZr8l+3ccDqK1/Wlep9kMhmfgT8vHqMsVI9RzlOcFJEclJ3cQdU/tchhMpt/ejceBBWuCsrw6r/WMnlOP5f6HztWWgO9TM7yr6qoJ1+C3DXtUG+3t2LXzGIDap7pjRX5b00q9NuoRxRLbtRe0ZY9O3R+dYKiIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(26005)(6666004)(7696005)(2616005)(316002)(6916009)(1076003)(186003)(40460700001)(70206006)(82310400004)(8676002)(83380400001)(16526019)(70586007)(44832011)(356005)(81166007)(54906003)(4326008)(426003)(336012)(47076005)(36860700001)(508600001)(2906002)(86362001)(5660300002)(8936002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 09:27:37.4663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cd2f69-5001-4e59-43e9-08d9ba2cf976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We found some headaches on ASICs don't need that,
so remove that for them.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +++++++++++++++-------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c5afa45173c..b5b32a582c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2656,6 +2656,36 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_smu_fini_early - smu hw_fini wrapper
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * For ASICs need to disable SMC first
+ */
+static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	if (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))
+		return;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+			r = adev->ip_blocks[i].version->funcs->hw_fini((void *)adev);
+			/* XXX handle errors */
+			if (r) {
+				DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
+					  adev->ip_blocks[i].version->funcs->name, r);
+			}
+			adev->ip_blocks[i].status.hw = false;
+			break;
+		}
+	}
+}
+
 static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 {
 	int i, r;
@@ -2676,21 +2706,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	/* need to disable SMC first */
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.hw)
-			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			r = adev->ip_blocks[i].version->funcs->hw_fini((void *)adev);
-			/* XXX handle errors */
-			if (r) {
-				DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
-			}
-			adev->ip_blocks[i].status.hw = false;
-			break;
-		}
-	}
+	/* Workaroud for ASICs need to disable SMC first */
+	amdgpu_device_smu_fini_early(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.hw)
-- 
2.25.1


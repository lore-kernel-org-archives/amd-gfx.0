Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ECC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F1F60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96F1F60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AB96EA16;
	Tue, 21 Sep 2021 18:07:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2046EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJzZWsPBLADQs2fDi+Fc6N2d46GiuOhxSM86GObkYB3axukMY0YDRwbjO1AgIK43Krt9jahnlCSIAyiEk3pY/rB0mawVHandKkHFD0pPlo8FCQzORdqDSd03d3K7FDUEU7c4s1ZLxBfm67TJM7+EQOPSV1M6NJP6A9xJnIkhy+68flboDB9fxc76u3frKNOISQTAt4kSCGJenNtREGTVVuYb1s6EnU3Ja7EFawsxMrH+S811V1mZ7qM3snub2QLK/hM3Jx0vjb8fDqsdC766XmmK/uWX9NeWx8Kr+lj03ffV+WYsosARCEq4L/TTf6qVErguu8F8/Lu7rlK4wjkr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cOtialm68vFWCwRof4ROxqgHMf4TyAvqJVRZtIqgBO0=;
 b=Lq56bHlrUAysOevhWb9nzili7a4U0HKwrcREgMWHiu4tiVL+UPUGwDBZF3g0CyGYkRr+EkIQ9u+xtfevY3p3kq+OD1wvUwRRoDPd27pfnVG6ujcYIOtetbvQgXJyP9DV/HqhsuiQesWAW0gNpw8HHqhqwRMgVCKT9Q5psCnxlHyvOpgGgSZdGQ5d+KVh0hD7DhM5AzClfkstzT46GHY6cmrojU4lnEmVcglO5lzgkljcj4xzezaqF7sKPOC/+3NdbjwTO6yoZoEcopaOMOOl1kmiXdKbU1fcFn8yzJMjxIRm2nX2gHoNVa/3gbqc1wu6qrbwa60OlZlxqBeYBHIQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOtialm68vFWCwRof4ROxqgHMf4TyAvqJVRZtIqgBO0=;
 b=ZV98XlGMfjYGUD6KJuuS7Cw5YqvHCyL3eMwUMyTki6bDp97oHKS65DT+nTu3e26oBu79KrK8mpD/DO9InUk67upsOleENEdGXREQQCuWA1ZC5IY2kv49hKCJbhqMSZfYEU7x47D5B09vl7hVB0yWwB60jOhFr8mvsmLQjRaQqB8=
Received: from DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:41 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::6c) by DM5PR11CA0014.outlook.office365.com
 (2603:10b6:3:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/66] drm/amdgpu: add debugfs access to the IP discovery table
Date: Tue, 21 Sep 2021 14:06:21 -0400
Message-ID: <20210921180725.1985552-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476ba7aa-45be-4a8a-9efb-08d97d2ab440
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:
X-Microsoft-Antispam-PRVS: <DM4PR12MB518290E44A019E1347F30B86F7A19@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvPsqdEp7zsNbdd3nDPmbdoqpcPUB6lqpoo1bqp2F1ea0qnkSKLF7WisZAjHgbDVcYS/em9njCxZ6h1dOEVn4Gk+8nvh1O1zdXNW2P9qcyfoUUJPTIhwdCvWgZWOtAVIGAyktqi5/AzrOCRScHxBcLu+EhDIz+oEMEpt4axUPxDctlxRpHJKHYay9POyIthYg04fTffN4zqqqvdLQreu+YrvOKjER6Q+66Xi9KuF62ZnH9dUvm419c1AbG6XQoHI8KT/9jAEADpN3alAIql+TN0Skj+0TQC0+N4PZ2o+l+JmGYf6/g+qu1cEJ3dbohMpYO8SobpTiOmZAApaoGyVNzH+JPIPsySLQ+qfNe41CHOGXHVnxcOasdv0t8e4Ysau4/6H0iRmGQgrsLvwQjN1obc8bIbkhsHGpljn7hVI2RlhlLl45NIdiLug+x5E3S4xfDU2qNGRhd23AEFuvtIYpMQnRomW8BHODz6/ugh2AjQJPVRhXSk6zL+J6Kn1EAOdWz3Zo8Ugtp/t3mgK0yBcHvO3obRoYlCZ0Bc7I7JIkS4SEqDuB93a0Y05ALF25FmNzwUaW58WoGbKufxwDilDA8p/kRL5Vkkx94L6dLPOM6D5S/5pCeg68Uzx/gZ20UGJJGuWiPA9A7HzUatGLDVCqx9//3qEQRU33tC8S603h18buIz+Re0jiYT19/surKDp1Lw1Urj8fWVQ+1yBxbsubTqwF/TsLjl8zE3JBOnqRiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(316002)(83380400001)(6666004)(4326008)(2616005)(508600001)(356005)(426003)(47076005)(336012)(82310400003)(36860700001)(70206006)(8676002)(70586007)(26005)(16526019)(186003)(2906002)(8936002)(86362001)(7696005)(1076003)(5660300002)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:41.5068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476ba7aa-45be-4a8a-9efb-08d97d2ab440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Useful for debugging and new asic validation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d356e329e6f8..cdb963b9bea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -830,6 +830,7 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
+	struct debugfs_blob_wrapper     debugfs_discovery_blob;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 074ffcf0dac2..31e16a42d4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1757,6 +1757,11 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
 			    &adev->debugfs_vbios_blob);
 
+	adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
+	adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
+	debugfs_create_blob("amdgpu_discovery", 0444, root,
+			    &adev->debugfs_discovery_blob);
+
 	return 0;
 }
 
-- 
2.31.1


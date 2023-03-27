Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF79FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7EA10E72D;
	Mon, 27 Mar 2023 19:36:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16C510E728
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH4J2G3qnCG0sVOq48w497K3819KhJXtcegttQyrz7l5EUyFAUlvz2NM3PfWjQAgEi6Utu6deO5VpYn3pNBIcVMFnX2852QtmyNjouaEIKXOOMNa1cvWzVvIPvEn/C4u9HE3U6OSp/GJRXas1d5beUyywxh+JnRPwM3UD8ALIyBZIFmyvqnzlDSLalrnK1oS75z5LErGCCvFABZd7FSJsCGt/+4CJSwRLJa/Ez4Zwp4l3U6+RmJ7ZnrPEK54OhTsIJigiYIuNXgktBN+dkUMMAuCu7NyK7QeibMN38XqEsjcnGXFHQEg8Dzr8aSM/+Y9xFnQyn7uqjlvmhpkJefW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjMGED0XSsN+TrkhJqXmrOy5ELxL3ZpK+PuW9bn4mRk=;
 b=aUl2XogUN9E9VEmZZxX4MsqMaGooCjr2mpaG3H2Xxr8Sghk786ufCrc2SfQAkhwfVEfyx19nvjRy18lHeq6rdt2/KQKEpMm41AW8mzSicgyqyp3aGP9U9PygLcfRAysnq08u0ICf121pEip9Um0DnmHbJe6SfS+sJL2EXMuVDn6TiCK8xUmXir9OY/g3ygVRUmjP5xuXHxHyfFUfdWbmKC51Az8P3hWwiT2TbYwJoQ6c0QeKgPXkAJi/EB9PDbR+eoawWuw9vnwBXfqoCETLkUmMHN0xy6oVKhUoboxU6hqkioON7inRqu44xlmSNrFXVYHN3v9jbqKIxMQJooyNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjMGED0XSsN+TrkhJqXmrOy5ELxL3ZpK+PuW9bn4mRk=;
 b=stzvvxxL6nHLeZGN1YgJzphhjrhNoq7H+JEKEYcWb/VqKPdysgrHNET9ZPMFFGiSbfw6+NXnUDiRQXtjUgeslAHI2PimQyjdPOuYbuBycMkv6q6qYKog8IRKf7nJsB6uC3eK0WP1pa2CBmgsKlm3j+l5O65tbuUuABd9+uaLbUg=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 19:36:36 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::2a) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/28] drm/amdgpu: add sysfs node for compute partition mode
Date: Mon, 27 Mar 2023 15:35:56 -0400
Message-ID: <20230327193602.7901-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aa9b8d-144e-4118-a52b-08db2efa93df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX9LwRlvsGDaGakhoO8GmnjS6FeXY0cRin44YfT9ASOoPyD3U/vNyT16fWeBSzfKemBAagEYEmYr/B9QN51NdTrLjTWxuH1zHra+VeJwLeixhEM7pYmN+TqEeqimD3uiJ7UeO8TtPdYen2nGsZQl4IcwuqZbnBeBWgfaotvXCQoIb+QaM+SmZ+EnvI8K96mGwTOeURygjAyEF6eaQhtAZQzbfBoElugTmCXl56Bd6le650DDy72EjMRawJQtdg0JZUG2uD4JV3mS2SmQly2ffhaem3GTl5S18aGX7mGx9h8e5S0JvQqYbvANdkJTSOhHnLhYPhg9Cq0+IWMw+o5vVzPgn4PkWNho/dUEwgA1h+QIkd/qnitA9dcZyvr5X0d3UxDh0dHxF6TOD0T9HRM727enDx2YrZk57dWMk6ZDczx6OgrfsvGuN37b9I4ON4B4dggsSqsRlq8eGe2MwcCkrDnEDKSTQSHAcdhOUpGHhDWm7IAwf13hSFO4PUcAK33ZLPdkuTnkaeEKt7SxciMyNxE37AYF+fUOt0qtEBW1yT39k8by6HQzzg8MdaBGUC54hnci5FRXnmvB8YfnsI0xUQKZXmddWdnExhVYC7ZI2+tomU1cV27pJ1HiYPfJfRcurGxNRT5KS7F1iXSJQL5/rlDD9Bv1naT3graHoDmiofoyJ7FF2hG0mZDIQqpHmrUHBJH8uVKIZg0QGvygWCHBA+u2u9aO+bcB2v8KrJdi3GQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(16526019)(186003)(36756003)(82310400005)(26005)(1076003)(83380400001)(2616005)(40460700003)(8936002)(81166007)(8676002)(5660300002)(41300700001)(6916009)(70586007)(4326008)(70206006)(316002)(478600001)(356005)(82740400003)(54906003)(47076005)(40480700001)(30864003)(7696005)(2906002)(36860700001)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:36.0197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aa9b8d-144e-4118-a52b-08db2efa93df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Add current/available compute partitin mode sysfs node.

v2: make the sysfs node as IP independent one in amdgpu_gfx.c

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 132 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  67 +++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c     |  32 +++++
 6 files changed, 241 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 065f5396d0ce..12dd2aa85b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3630,6 +3630,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->srbm_mutex);
 	mutex_init(&adev->gfx.pipe_reserve_mutex);
 	mutex_init(&adev->gfx.gfx_off_mutex);
+	mutex_init(&adev->gfx.partition_mutex);
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5e1e8e043a69..14ea9bbc3715 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1096,3 +1096,135 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id)
 	return !(xcc_id % (adev->gfx.num_xcc_per_xcp ?
 			adev->gfx.num_xcc_per_xcp : 1));
 }
+
+static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
+						struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_gfx_partition mode;
+	char *partition_mode;
+
+	mode = adev->gfx.funcs->query_partition_mode(adev);
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		partition_mode = "SPX";
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		partition_mode = "DPX";
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		partition_mode = "TPX";
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		partition_mode = "QPX";
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		partition_mode = "CPX";
+		break;
+	default:
+		partition_mode = "UNKNOWN";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", partition_mode);
+}
+
+static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
+						struct device_attribute *addr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_gfx_partition mode;
+	int ret;
+
+	if (adev->gfx.num_xcd % 2 != 0)
+		return -EINVAL;
+
+	if (!strncasecmp("SPX", buf, strlen("SPX"))) {
+		mode = AMDGPU_SPX_PARTITION_MODE;
+	} else if (!strncasecmp("DPX", buf, strlen("DPX"))) {
+		if (adev->gfx.num_xcd != 4 || adev->gfx.num_xcd != 8)
+			return -EINVAL;
+		mode = AMDGPU_DPX_PARTITION_MODE;
+	} else if (!strncasecmp("TPX", buf, strlen("TPX"))) {
+		if (adev->gfx.num_xcd != 6)
+			return -EINVAL;
+		mode = AMDGPU_TPX_PARTITION_MODE;
+	} else if (!strncasecmp("QPX", buf, strlen("QPX"))) {
+		if (adev->gfx.num_xcd != 8)
+			return -EINVAL;
+		mode = AMDGPU_QPX_PARTITION_MODE;
+	} else if (!strncasecmp("CPX", buf, strlen("CPX"))) {
+		mode = AMDGPU_CPX_PARTITION_MODE;
+	} else {
+		return -EINVAL;
+	}
+
+	mutex_lock(&adev->gfx.partition_mutex);
+
+	ret = adev->gfx.funcs->switch_partition_mode(adev, mode);
+
+	mutex_unlock(&adev->gfx.partition_mutex);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
+						struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	char *supported_partition;
+
+	/* TBD */
+	switch (adev->gfx.num_xcd) {
+	case 8:
+		supported_partition = "SPX, DPX, QPX, CPX";
+		break;
+	case 6:
+		supported_partition = "SPX, TPX, CPX";
+		break;
+	case 4:
+		supported_partition = "SPX, DPX, CPX";
+		break;
+	/* this seems only existing in emulation phase */
+	case 2:
+		supported_partition = "SPX, CPX";
+		break;
+	default:
+		supported_partition = "Not supported";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", supported_partition);
+}
+
+static DEVICE_ATTR(current_compute_partition, S_IRUGO | S_IWUSR,
+		   amdgpu_gfx_get_current_compute_partition,
+		   amdgpu_gfx_set_compute_partition);
+
+static DEVICE_ATTR(available_compute_partition, S_IRUGO,
+		   amdgpu_gfx_get_available_compute_partition, NULL);
+
+int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
+	if (r)
+		return r;
+
+	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
+	if (r)
+		return r;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4c5881a24f6f..0cf3591c13b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -250,6 +250,10 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	enum amdgpu_gfx_partition
+			(*query_partition_mode)(struct amdgpu_device *adev);
+	int (*switch_partition_mode)(struct amdgpu_device *adev,
+				     enum amdgpu_gfx_partition mode);
 };
 
 struct sq_work {
@@ -383,6 +387,7 @@ struct amdgpu_gfx {
 	enum amdgpu_gfx_partition	partition_mode;
 	uint32_t			num_xcd;
 	uint32_t			num_xcc_per_xcp;
+	struct mutex			partition_mutex;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
@@ -464,4 +469,5 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 						struct amdgpu_iv_entry *entry);
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
+int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index c686ff4bcc39..6a636c34b717 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -95,6 +95,9 @@ struct amdgpu_nbio_funcs {
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
 	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 	u32 (*get_rom_offset)(struct amdgpu_device *adev);
+	u32 (*get_compute_partition_mode)(struct amdgpu_device *adev);
+	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
+					   enum amdgpu_gfx_partition mode);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index bd3a049b20c3..9a9e52e1c4fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -667,6 +667,67 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
 
+static enum amdgpu_gfx_partition
+gfx_v9_4_3_query_compute_partition(struct amdgpu_device *adev)
+{
+	enum amdgpu_gfx_partition mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+
+	if (adev->nbio.funcs->get_compute_partition_mode)
+		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
+
+	return mode;
+}
+
+static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
+						enum amdgpu_gfx_partition mode)
+{
+	u32 tmp = 0;
+	int num_xcc_per_partition, i;
+
+	if (mode == adev->gfx.partition_mode)
+		return mode;
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_xcc_per_partition = adev->gfx.num_xcd;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_xcc_per_partition = adev->gfx.num_xcd / 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_xcc_per_partition = adev->gfx.num_xcd / 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xcc_per_partition = adev->gfx.num_xcd / 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_xcc_per_partition = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* TODO:
+	 * Stop user queues and threads, and make sure GPU is empty of work.
+	 */
+
+	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+				    num_xcc_per_partition);
+		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+				    i % num_xcc_per_partition);
+		WREG32_SOC15(GC, i, regCP_HYP_XCP_CTL, tmp);
+	}
+
+	if (adev->nbio.funcs->set_compute_partition_mode)
+		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
+
+	adev->gfx.num_xcc_per_xcp = num_xcc_per_partition;
+	adev->gfx.partition_mode = mode;
+
+	return 0;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
         .select_se_sh = &gfx_v9_4_3_select_se_sh,
@@ -674,6 +735,8 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .read_wave_sgprs = &gfx_v9_4_3_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_4_3_read_wave_vgprs,
         .select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
+        .query_partition_mode = &gfx_v9_4_3_query_compute_partition,
+        .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 };
 
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
@@ -863,6 +926,10 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 24d12075ca3a..5f2270b1d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -347,6 +347,36 @@ static void nbio_v7_9_enable_doorbell_interrupt(struct amdgpu_device *adev,
 			      DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
 }
 
+static enum amdgpu_gfx_partition nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP);
+
+	if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, SPX_SUPPORT))
+		return AMDGPU_SPX_PARTITION_MODE;
+	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, DPX_SUPPORT))
+		return AMDGPU_DPX_PARTITION_MODE;
+	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, TPX_SUPPORT))
+		return AMDGPU_TPX_PARTITION_MODE;
+	else if (REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_CAP, CPX_SUPPORT))
+		return AMDGPU_CPX_PARTITION_MODE;
+	else
+		return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
+static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
+					enum amdgpu_gfx_partition mode)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP);
+	tmp &= ~0x1f;
+	tmp |= 1 << mode;
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_CAP, tmp);
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -366,4 +396,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_clockgating_state = nbio_v7_9_get_clockgating_state,
 	.ih_control = nbio_v7_9_ih_control,
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
+	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
+	.set_compute_partition_mode = nbio_v7_9_set_compute_partition_mode,
 };
-- 
2.39.2


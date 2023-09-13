Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40EFCA5520
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 09:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323A410E05C;
	Wed, 13 Sep 2023 09:32:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E9910E05C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 09:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbXLzNFzCOP/JNmQKYKU4InagdI8bL9BxkyuNGWHDYohgcImWRYQ0HkCZ5ESvfcvHcSE4NBoQ5Klatjo4azlbhla621mwHswagRkKORJC+l23cPHZ4dDX2378uu4Kb0lNFHFvYKwfQmd6bYCl7628DerPI95V/lMqSbLZgy7KkAeMkAPYy7Ti/jHchjH2J2TrKddcS5sthFApjBMEj6XrMWIFKbq725Ud/iZowlJxDhD499Bq3nSc3lDljhRSiWcZzznfetjr8KDpqx7bSGfTtRM8SOrqQTPYFP5TmQ3plwNZL/z8tZVtZE0VJOb3D3OjQpm4kQOjVYy8daoQui0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEjHbth38Y42CdH208I3pKvMX4YYHCM6h+wCw1YTnEU=;
 b=VDOKA61ZuFmpvrIQH0dUzMeaeKNG6Te87BGDY/TNSffjp6m7JdsXX+qNBEiyObIWN9kOiYub4roLUfp8Kf6XBqFYJj+6OmvRu1ffGz5GdLXX/sFDeFHV+DKA6CuY7jxE3/kqpWcC1PmGIJfTEwDsiwoccwUyDJFPtRJkoOqa2BQa8YeN4dQZIOM96Cka0mNKno6DXw1MYWA5RNAOTn4kgRbkpKGA7HnWETuncFzcjP5UL7OIDwjJofzw39MyIj490tDHP4M0PRW7RsTPYDNw8jMIvr74ACVcqkQJ8a/CbBogh8sw721KIzP55hwS+Bk9CdnZN83kVD0eVVOff0Q3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEjHbth38Y42CdH208I3pKvMX4YYHCM6h+wCw1YTnEU=;
 b=kCHk+YqIoIXgKeCDNTHvgevvMUaNLeWBLmjIP8vsAMbG8MIihY1BUYGE9521/Qzdps+WLK3MH03eCCQOgX7HEudEU45gtsp1u3A/Ki3X3vJ4uVYbw2UuVRMcNTQ84+7FENVdZeu1S2/OyOui3sidbfbKY0zcnKvlldGOMINkk1A=
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 09:32:16 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::d5) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 09:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Wed, 13 Sep 2023 09:32:16 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 04:32:14 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: add amdgpu mca debug sysfs support
Date: Wed, 13 Sep 2023 17:31:58 +0800
Message-ID: <20230913093200.312429-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913093200.312429-1-kevinyang.wang@amd.com>
References: <20230913093200.312429-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: e8221871-1a14-454d-8abe-08dbb43c5195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l39JQ21/YR9Vz99jpTb5kYJmHGqbkotjdlnU7DM8CunJ+hQFqFYMbTLMJo7fwRMh/dh8Yno48Tj6J21zNWFbS2TvuT6TudT+ShteXKj2EerRhAOanMFqBAyZsr6lcctA7DeLnsxEcEcUnuDY99kVwcoon4B3LHYdRSKNdCwWTGbXBHz7AVigY5LnMZQP8uZZksL34dQsENqyUSsaAIpAHqxHyRJdbSl0ONnTf7ifSlX+cm3CJLkCJflJk3DALbYr0pHwMmP4Q/Lesi9Ht87KE/by3+O4j70akQoB3oBnWPvVdBHsZNO0s3Tsje85yXqjun9yfET6YbgFg6LgUddORGcH2M/FtZaYxvM1OAvcSoKBgc/RnHmJkifJZMeLioxGMkSLEJZfj49nkzxSbn6TEBgTuzWpKsCqwhwpDBZoluv4TYo88ja2ACXpn6ivpd2+HfQJa5qCU8PnR5iqbtmO5ViEax8THj2turV/jjMsDxUQlWIujy1aLadlWb4Sc/N2RK2RDnmyEN2hHDqKfJuFG/LvkF2W1Dqpc6bQXwAu3zQWMGx65VGO7W5sq08p/gDo+IUu4HljsDksT4a37WE9WBG/wfDBjvfyLVz2TrTae/wPhugnbI+w0OgfX8e4asZQXHwpRLVLifXyXQBqX1Evxf7vDkADN64I5gEuSmU1jwk9zDBwJys2EmEzvtIXjLLuMU9v/r2gsLW2IJsCgyS31d/NIDBcXvUdwRTi7zRu3goADojKz1omCfoHIKHC6cRWNlGQDqfIn/HOwDaXfAgNvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(81166007)(82740400003)(356005)(6666004)(86362001)(2906002)(478600001)(83380400001)(2616005)(47076005)(426003)(16526019)(40480700001)(1076003)(7696005)(36860700001)(36756003)(336012)(26005)(54906003)(70206006)(70586007)(6916009)(316002)(8936002)(4326008)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:32:16.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8221871-1a14-454d-8abe-08dbb43c5195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
Cc: alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add amdgpu mca debug sysfs support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 116 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +
 3 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 9fa88ae81b12..35d592293106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -210,3 +210,119 @@ int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev,enum amdgpu_mca_erro
 	return -ENOTSUPP;
 }
 
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	int ret;
+
+	ret = amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+	if (ret)
+		return ret;
+
+	dev_info(adev->dev, "amdgpu set smu mca debug mode %s success\n", val ? "on" : "off");
+
+	return 0;
+}
+
+static void mca_dump_entry(struct seq_file *m, struct mca_bank_entry *entry)
+{
+	int i, idx = entry->idx;
+
+	seq_printf(m, "mca entry[%d].type: %s\n", idx, entry->type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE");
+	seq_printf(m, "mca entry[%d].ip: %d\n", idx, entry->ip);
+	seq_printf(m, "mca entry[%d].info: socketid:%d aid:%d hwid:0x%03x mcatype:0x%04x\n",
+		   idx, entry->info.socket_id, entry->info.aid, entry->info.hwid, entry->info.mcatype);
+
+	for (i = 0; i < ARRAY_SIZE(entry->regs); i++)
+		seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx, i, entry->regs[i]);
+}
+
+static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct mca_bank_entry *entry;
+	uint32_t count = 0;
+	int i, ret;
+
+	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
+	if (ret)
+		return ret;
+
+	seq_printf(m, "amdgpu smu %s valid mca count: %d\n",
+		   type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", count);
+
+	if (!count)
+		return 0;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		memset(entry, 0, sizeof(*entry));
+
+		ret = amdgpu_mca_smu_get_mca_entry(adev, type, i, entry);
+		if (ret)
+			goto err_free_entry;
+
+		mca_dump_entry(m, entry);
+	}
+
+err_free_entry:
+	kfree(entry);
+
+	return ret;
+}
+
+static int mca_dump_ce_show(struct seq_file *m, void *unused)
+{
+	return mca_dump_show(m, AMDGPU_MCA_ERROR_TYPE_CE);
+}
+
+static int mca_dump_ce_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mca_dump_ce_show, inode->i_private);
+}
+
+static const struct file_operations mca_ce_dump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = mca_dump_ce_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int mca_dump_ue_show(struct seq_file *m, void *unused)
+{
+	return mca_dump_show(m, AMDGPU_MCA_ERROR_TYPE_UE);
+}
+
+static int mca_dump_ue_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mca_dump_ue_show, inode->i_private);
+}
+
+static const struct file_operations mca_ue_dump_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = mca_dump_ue_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_set, "%llu\n");
+#endif
+
+void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
+{
+#if defined(CONFIG_DEBUG_FS)
+	if (!root || adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6))
+		return;
+
+	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
+	debugfs_create_file("mca_ue_dump", 0400, root, adev, &mca_ue_dump_debug_fops);
+	debugfs_create_file("mca_ce_dump", 0400, root, adev, &mca_ce_dump_debug_fops);
+#endif
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 6915ae0d5b92..0f8cbfb929dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -110,4 +110,6 @@ int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_m
 int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, uint32_t *count);
 int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev,enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *entry);
 
+void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index eeb695f9ff1c..4e4ba2149595 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1570,6 +1570,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
 		}
 	}
+
+	amdgpu_mca_smu_debugfs_init(adev, dir);
 }
 
 /* debugfs end */
-- 
2.34.1


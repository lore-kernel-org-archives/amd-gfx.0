Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4259EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E8D12B6A0;
	Tue, 11 Jan 2022 07:12:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E696A12B69E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft7uvHghho6XZlQWywjdak3Yxzrn1C7mhUb2Pgw3Y17aE91CG3J3QsCH/y215lZ5R7PejTS4VqS/ejpJXmE1PdmLuAvF/O4P6WfBwKslfJ0c8fTv2xCJENycXdy38SvqQPynNQAN5wY8H2W52jJdOm8n7/J1i5Hm0H11jw7yXs67m3F8W2Lv0y67LfveuW1Nwpf2wTkDOoo/jmzKEJXoayZbWecApNCnwaajnl6dhqpMVqOO8nUpXM0K2Pd/5fN2GEgKEfaZRpkqETaddGBf8/okHW8lc/qZowvl46EqLWLDIhHRavCvajIZWAajtlA2DbKdCRonbJkS3OA2X2vzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IQLHXymBStpXt0ivkVU7pzxIVYUCxEQfVOeUBvDhBY=;
 b=VhMX3jfy3KIn6cvl8hhwgpbYFpeg1l3S/6uZXgPd5OOUgOuZsNPI4MPIwgSG9SLK2Hr/w+FBEZ0xlrD6+Z8RC02//FsI0CM560DvykQ8+EojDEX3YRNNQrAEbE8iGVq5bjTkFFLIcOUjmbOONKGG/PBJ51KmC78nlNhN5ACK7G/yEiExDGhQaqMdbjn1u7RrGCRhpsSkms8JR22SgsgxpnqDGPmBUMM/3+EIaZwsivY7lc0Rz7AQuPX1hLbhGYb9y6oDPuARNO2qAhu2eN+IipM6JFGZe9ee5RSD9i5LvGY6deTA2OAG2NBexDkCdroSedjJBnKobGt4jIsx7D9IrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IQLHXymBStpXt0ivkVU7pzxIVYUCxEQfVOeUBvDhBY=;
 b=0xitNnMK5jxl0xXcMv/wdX4xm4edWcA/OfEqeb6OOr0hLwiWxLFbFowdaYgxuoa1wuGmE67Pb9y668DgM0IRObL701DvBfgiDSMlDOkkXU1DZjWPM2+GZGRJlDa8dmp6pZfvGQE70KdGrVNNKGYwD+j68TS58TGnhIf7EPl2fsk=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:12:11 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ea) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 11 Jan 2022 07:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 07:12:10 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 01:12:08 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add debug fs for AMD GPU reset register dumps
Date: Tue, 11 Jan 2022 12:41:50 +0530
Message-ID: <20220111071150.5551-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55273e82-3e3a-44a6-382b-08d9d4d1afb0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1162B1D4104E8711BE884AA3F8519@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/9gvy99neYp2dBkckATvfvOw6GJbDg0jP1gm7tXNYzHkOQfZ3ki9sEoE7NkZMNdOx4YQDgRddliO2WgLejf7MpZqQ0XKpTRn9+26JX6p631zTqJIbTc6l2dY/AvWOqupB7QTM6vwtilBxTZV/X4nQ/vsoZPiiTStObY3GUsW6YSNDXipS9Lf4Kho4aAAv/UKYnGrRuqdzNbRreTDynyPuyFnEWOlJAEmo9bqmmlMZfEV7rhCOLBB5I0k/RTpOmBjmL3igfFk/8VvsjYny80wfCl9fxv705wNu/3j6DT9s207kYgXNgyaQYJxQF+tBNEFe4lvnScdLk6b/bCMkysCCqgfhj9WOjBQ0Ggm25tmySByJ6VYZ6vZnCZcwsVQARenhthOS7CbuLKXbTE5hcFOqQ1F0Hsj3Ff2TJcb1cs3wgVitPzY5J1h03ejTj8jDp/Kl4b2RVAFXFDQboQJpOPZa8iVrliwiDIehg9PKI4n3F+pYtxdfwenARvoYZSJ28trm0xG9AsMv9Mo+ryhSUBszDMZf+dki3ppalKsA29j8fID77VEQuTiIwvUlbdhBFWZw5vLmKY4CBJLKAsOrlHAlk6S4YQ8NzAFQZRXoGT45XeoOdZbVsdtNtLv9haNp6MWioHGfEC5rgWtDCALoyVRRKzuzTRQSv+847ZpqjD4Yd9kK+zYRfyVOE6AiTMpJ3XGVgZC7QruW4StkuCBITG8DkA4m1k3m7kYY//e6lVnou+hqA0YcLUdp8IxzVhOKZ6Eu5YfxX0cOmlC5NYOdsKbYAb2SbY7krbc/LFfbzJB1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(186003)(5660300002)(426003)(1076003)(8936002)(16526019)(336012)(2906002)(86362001)(26005)(54906003)(6666004)(36860700001)(8676002)(40460700001)(316002)(82310400004)(83380400001)(2616005)(356005)(7696005)(81166007)(70206006)(6916009)(70586007)(47076005)(4326008)(36756003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:12:10.8888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55273e82-3e3a-44a6-382b-08d9d4d1afb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Cc: alexander.deucher@amd.com, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implementation of debug fs “amdgpu_reset_reg_dumps”
to capture reset register status

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 64 +++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..c56d7b451aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1609,6 +1609,68 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+static DECLARE_RWSEM(reset_reg_dumps);
+
+static void seq_reg_dump(struct seq_file *m,
+			 uint32_t (*dump)[2], uint32_t n_regs, char **names)
+{
+	uint32_t i, count;
+
+	for (i = 0, count = 0; i < n_regs; i++) {
+		if (count == 0 ||
+		    dump[i-1][0] + sizeof(uint32_t) != dump[i][0]) {
+			seq_printf(m, "%s%s:	%08x: %08x",
+				   i ? "\n" : "", names[i],
+				   dump[i][0], dump[i][1]);
+			count = 7;
+		} else {
+			seq_printf(m, " %08x", dump[i][1]);
+			count--;
+		}
+	}
+
+	seq_puts(m, "\n");
+}
+
+int amdgpu_debugfs_reset_reg_dumps_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	uint32_t (*dump)[2], n_regs = 0;
+	int r = 0, i;
+	char **reg_names;
+
+	down_read(&reset_reg_dumps);
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(
+				adev, &dump, &n_regs, &reg_names);
+
+		if (r)
+			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
+				  adev->ip_blocks[i].version->funcs->name, r);
+
+		if (!r) {
+			seq_reg_dump(m, dump, n_regs, reg_names);
+			kfree(dump);
+		}
+	}
+
+	up_read(&reset_reg_dumps);
+
+	for (i = 0; i < n_regs; i++)
+		kfree(reg_names[i]);
+
+	kfree(reg_names);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_reset_reg_dumps);
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
@@ -1672,6 +1734,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_reset_reg_dumps", S_IFREG | 0444, root,
+			    adev, &amdgpu_debugfs_reset_reg_dumps_fops);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.25.1


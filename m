Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB68C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A196510E737;
	Wed,  8 Nov 2023 12:58:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9162310E733
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViOqGZ4r0i1lRY7UI2khv7JOSXx2ZsaoHe8KVRVfz1em+8IZ+3IRMoNwxMS3x/Td9Q/sRvmqo/PlYMExnNFLfjrIYXexai+Dg9Phz+46W/uC0A2IMAXQCEn+dafIZKyP6OcVUaxmnxqHE5gUVKO7dtklvZQgd05BJNxuy7r8Gmvr0vEBGGBRSe2rEAQLIPxfEY3Tryq6+kke3HotioK7ANZmKT0RVfM73qa5SBGvu3HnrrNTlPY7ipAerqYwowWR8xopV+nwjOzagZiZ3etu0jOfz2rQGrN0szq07ShUP6WxCfvZ2/bofzyYg1fghPfRnClxsiQCZpFYtiHr+oA91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1372yAoqcw16thsPGkC7Pe/ZIvTsJURQDBfhq6QXOc=;
 b=DgFjIjbdHx4AuXJlb8ltITmdbC8nLCbnU/T10SKkghloqb789bxSB19RorUjKe/q54fx3+LZOZ06ut8Hhv1XfpZ24wRnXEl/GVencNJT4RELWbeLbWsKzXAWiHUXaFcI35p77UFF/0J1RrQNVNIRe7Wdw3vPCj9fmR4n+8RL3t/oU1qlircBYT33DZuymVkIV3AQdNgjJY8exqbE4RCL7sZMlkYwN6gN8m+bxg8oUHnsdH0I2vLFw/EHDUatUplBBupBiQrL74gO+3fWIRdLcVRVS0CAX8rRQAWardbw71FoaQQq6jqt6R10a9AtvueXsYfj+ahnOhnDRKQmR3LReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1372yAoqcw16thsPGkC7Pe/ZIvTsJURQDBfhq6QXOc=;
 b=LwASNNdJlj8ruzRj6u9zRP6l6dK3O5owMKy+3qKZxbRg7GFmnRvOSLH3E5YIUiv3RRI0cXYJTd6IejQW67lB7CErv81fZSvK0+uK9loZqziWTiRMYx6WGp4CH8PNdQHWM3zn+nCCAkAvuF59h+Vw5vfWAeM5cqnARtmsoqFDAUQ=
Received: from SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) by BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 12:58:08 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::1a) by SN4PR0501CA0106.outlook.office365.com
 (2603:10b6:803:42::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:08 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:58:06 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: correct mca debugfs dump reg list
Date: Wed, 8 Nov 2023 20:57:35 +0800
Message-ID: <20231108125735.2497856-7-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BL0PR12MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fc53bc-2694-47fa-17f5-08dbe05a5b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUViAxffjwv+jVW1NZVsxB58DGUyQSOtW2RM3hPyFL3mueA04stNVDr3VDcosXi6CPnTgUfZqgV4/rexOlsscreLIbjukFHRrG+xo6qHccivVD9K+DeIaE8H1t16GuTrlaTD4gypzde5VSZ9l+xrKxwgCmOQVCNaM/RCYcXUUFXcoiwSNnbUXVhuxbdPLGrK3f9RxQ6+C1NU7wFlsxuHrqRijgy6W4S9hVWtNlRDn+NEeFyi0bpBqKsaa0iNBNPGT6BUJz1gEd8BvkNKvh3yvp69hKDcPaYw6gG/9FOBj9XwM4YMfXnDybZ5xKwBE8LUmnqKtSeEV76V/VjGdJqIEj6CR9ejf1dRvHn1gQgRGV/2Bo2sB02FfNtXbEyXRbjvHhuUkby2Bp+MZ+9Xb4QIdZ6d0j769h0+vfbN4+xDj5hcJhXRfg6sBMwE1Kg0gWZWdNzNpz/1F4yhxLrxyDqLngrmHaoBb9EELrNAlRadqg0a9oJgrqV8RVgrjSJLd7y1dNU0Ng8nh+y+oGoLwF7hYkMOj3yxWEzOCw2ExTQYNaKPHyA3t3pcaOUQ7IjMPpDntUIIPgX2X8WhUyMiPYiozrPvrreAl6blWrYFvn/3pcP1p2VnFi3eNKY91sxYsB84z1mBKispk3JLI/yxC2IFaTfsQTLFCgqs7IVKBM9/fXgJgh53559U6Ju+7VEl3yowyH2Km3Gxc4R2U5wydQXOqptJZGNKQnFdjFia6D5AWZTooNiSPByM+0MdSpPH1AHebDI+F8UuTYSch/oJyvtbPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(2616005)(40480700001)(40460700003)(478600001)(47076005)(36860700001)(36756003)(86362001)(82740400003)(83380400001)(356005)(81166007)(426003)(70586007)(7696005)(336012)(70206006)(54906003)(6916009)(16526019)(316002)(1076003)(26005)(41300700001)(2906002)(5660300002)(8676002)(6666004)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:08.3031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fc53bc-2694-47fa-17f5-08dbe05a5b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

avoid driver to touch invalid mca reg.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 65926f3c708a..cf33eb219e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -389,14 +389,21 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 static void mca_dump_entry(struct seq_file *m, struct mca_bank_entry *entry)
 {
 	int i, idx = entry->idx;
+	int reg_idx_array[] = {
+		MCA_REG_IDX_STATUS,
+		MCA_REG_IDX_ADDR,
+		MCA_REG_IDX_MISC0,
+		MCA_REG_IDX_IPID,
+		MCA_REG_IDX_SYND,
+	};
 
 	seq_printf(m, "mca entry[%d].type: %s\n", idx, entry->type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE");
 	seq_printf(m, "mca entry[%d].ip: %d\n", idx, entry->ip);
 	seq_printf(m, "mca entry[%d].info: socketid:%d aid:%d hwid:0x%03x mcatype:0x%04x\n",
 		   idx, entry->info.socket_id, entry->info.aid, entry->info.hwid, entry->info.mcatype);
 
-	for (i = 0; i < ARRAY_SIZE(entry->regs); i++)
-		seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx, i, entry->regs[i]);
+	for (i = 0; i < ARRAY_SIZE(reg_idx_array); i++)
+		seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx, reg_idx_array[i], entry->regs[reg_idx_array[i]]);
 }
 
 static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
-- 
2.34.1


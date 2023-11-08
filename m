Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B7C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCC510E6FD;
	Wed,  8 Nov 2023 04:17:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8359D10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3/X4CmFwLwvh21WGBDeultsXn9c2W+sT/367IkJT4bhhbVHUjGjQfwbYJ9up5zSW1clbmaJ+OgCgkxmJcnCxRNuFKPy3ZPLEsj73s1WMhM399jiMM9wTEtrWcSdN1A2QICyyZ7gPx1CpJILtZne5H4zwNYIp4lRErHBCpf0GEvxvqOCNtSmTrhL+aUKuVuuAZrqMRG2q7nL6dck9PwAjWJ7K1bFRq1WNR8YaPSWzF2dOChkmZY0GPHaezhiU+f4Jl5rzf+o2CjnWiTAP6XKHeBwLcIwwv9cnjnE9VEB63xmxmjWUdxt/uLrMr6lhSWHEBP5Sea81iBxkjhD48+fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/Nm+uteOaaA1BUW8Qv5/NweKQYOlLgv22wXQg8cZc=;
 b=aPtwN4QThGP7OHl3qq5FUkh9GffNWaItqceqUpN5WmDWKBXw6lTAU0wVYgiUvo/D4R+Xsba/cRrg6yPMClkE8x9gnX68uJmiz2bvOVVDiNDNlJfoszW/J5Bw9/QeEtdTtUEi6lWltxLHgGBE/iTlt2sWy7WgOAbpXv+MZ0TwdX2HoV6RmAv/LxSr6oA68jRJQsjsO/M2kYe5bo07djiw8sxYZEvfiJkphXdgGHWwKX0UYpAfz8dOSp+khzt6IJSsGeZO3+pg1qxJaugdh9ekEVSDekw5HNF9CtCtPJ65+k9low68GBF6Q4uzFtc8ex/ju6NV0yVQ4DcVZcDHuCeODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/Nm+uteOaaA1BUW8Qv5/NweKQYOlLgv22wXQg8cZc=;
 b=IwIyN85obdVU2y0mxQrZc4E2if94LCmmLXw5+3+KSvRJWxCXP6/VOuA+ybpYqnDTY28oI0u/l5bK33dGygrkekuVhNSMquG6xd4u7V2/viOMrvVzxGWhvwSt22G3MacZogE34V4sgZ7NELHVgWDY0hWy4yXkbjv0AT+AnD/Y384=
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:17:38 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e3) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:36 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Read aquavanjaram WAFL register state
Date: Wed, 8 Nov 2023 09:47:04 +0530
Message-ID: <20231108041705.528194-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108041705.528194-1-lijo.lazar@amd.com>
References: <20231108041705.528194-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d5b6f7-0e34-4540-924e-08dbe011a456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1f+2tqKExua5Kg780RWHK4FqUKxawl2XA2Ou1rst+Q6fwmbhS3Vxg7TGg/A2tzRNqzbaGokF7nNhxYt7p6a+SfmtLdnz5W5gx8keoa872f9l68Yznj2k/8ztELNV1dI3ppRmUykgAXpuJ1GcH7cxr/nzois0jw8Nx2uijw7IQ+xo82ve9pWhslwQPZosafDCerCPtNTKPxr6ix5xqG8qE6JV1KxSJ0WDQkyLS0usJjNdn6RrDgsU0zVAsaTQwWwFMp4EDCaXBLnFTsXzmPUeOxBzoOI/raAiBsKIptVaHovkF4MvHAhFaQM6ZliAUHqvVzUXdr6HukyW45XF1/pj1y4ovYzCHP+5dKjI41tq1JLYRG12BoPUUhD+C9eBxQRbDVzPfcdKQVsdq4Jb+HKOzU95N27Db+g4D6EpjFBxleikCJLBaZ8h1VjPNetSipNeJVqcrzUsJI02giElsVUWlz77+w8A2rGKYsjbjDPHYPNMqup0nxAOI2nAbbjQpI40KYwMYFd96xoMBy2rjOLlnKOZhm9UniNusK8P9tnN6WVNfNrlrX8he/3PuRSb8ws/F25gqmMSiP+jNORtv7eCdsX08KVZ0I4sfPCFhBsIYBOcWejeNr3c3m4j5iBuNdU6Vmqg755kuEMBKUSuqhIxPM7NPpVBAEQLJFpMth5Qm3H36SP4vtiqxIVnqY8V+Vz0lC57knaz9quJNclRVS/uA2rsE0AKovvUXEjdrMBMoMfFxa6n2HwJ6ahXQOzRZ3JPyZ1SqTNep5/aKMxg/mF7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(5660300002)(36860700001)(40460700003)(41300700001)(2906002)(36756003)(356005)(82740400003)(81166007)(16526019)(426003)(336012)(7696005)(478600001)(70586007)(70206006)(2616005)(26005)(1076003)(316002)(6916009)(54906003)(6666004)(44832011)(47076005)(40480700001)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:37.8478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d5b6f7-0e34-4540-924e-08dbe011a456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to read state of WAFL links in aquavanjaram SOC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index a00b8c6f0a94..eec15f1c143f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -848,6 +848,79 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
 	return xgmi_reg_state->common_header.structure_size;
 }
 
+#define smnreg_0x11C00070	0x11C00070
+#define smnreg_0x11C00210	0x11C00210
+
+static struct aqua_reg_list wafl_reg_addrs[] = {
+	{ smnreg_0x11C00070, 4, DW_ADDR_INCR },
+	{ smnreg_0x11C00210, 1, 0 },
+};
+
+#define WAFL_LINK_REG(smnreg, l) ((smnreg) | (l << 20))
+
+#define NUM_WAFL_SMN_REGS 5
+
+static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
+					     void *buf, size_t max_size)
+{
+	struct amdgpu_reg_state_wafl_v1_0 *wafl_reg_state;
+	uint32_t start_addr, incrx, num_regs, szbuf;
+	struct amdgpu_regs_wafl_v1_0 *wafl_regs;
+	struct amdgpu_smn_reg_data *reg_data;
+	const int max_wafl_instances = 8;
+	int inst = 0, i, j, r, n;
+	const int wafl_inst = 2;
+	void *p;
+
+	if (!buf || !max_size)
+		return -EINVAL;
+
+	wafl_reg_state = (struct amdgpu_reg_state_wafl_v1_0 *)buf;
+
+	szbuf = sizeof(*wafl_reg_state) +
+		amdgpu_reginst_size(max_wafl_instances, sizeof(*wafl_regs),
+				    NUM_WAFL_SMN_REGS);
+
+	if (max_size < szbuf)
+		return -EOVERFLOW;
+
+	p = &wafl_reg_state->wafl_state_regs[0];
+	for_each_inst(i, adev->aid_mask) {
+		for (j = 0; j < wafl_inst; ++j) {
+			wafl_regs = (struct amdgpu_regs_wafl_v1_0 *)p;
+			wafl_regs->inst_header.instance = inst++;
+
+			wafl_regs->inst_header.state = AMDGPU_INST_S_OK;
+			wafl_regs->inst_header.num_smn_regs = NUM_WAFL_SMN_REGS;
+
+			reg_data = wafl_regs->smn_reg_values;
+
+			for (r = 0; r < ARRAY_SIZE(wafl_reg_addrs); r++) {
+				start_addr = wafl_reg_addrs[r].start_addr;
+				incrx = wafl_reg_addrs[r].incrx;
+				num_regs = wafl_reg_addrs[r].num_regs;
+				for (n = 0; n < num_regs; n++) {
+					aqua_read_smn_ext(
+						adev, reg_data,
+						WAFL_LINK_REG(start_addr, j) +
+							n * incrx,
+						i);
+					++reg_data;
+				}
+			}
+			p = reg_data;
+		}
+	}
+
+	wafl_reg_state->common_header.structure_size = szbuf;
+	wafl_reg_state->common_header.format_revision = 1;
+	wafl_reg_state->common_header.content_revision = 0;
+	wafl_reg_state->common_header.state_type = AMDGPU_REG_STATE_TYPE_WAFL;
+	wafl_reg_state->common_header.num_instances = max_wafl_instances;
+
+	return wafl_reg_state->common_header.structure_size;
+}
+
 ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 				    enum amdgpu_reg_state reg_state, void *buf,
 				    size_t max_size)
@@ -861,6 +934,9 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 	case AMDGPU_REG_STATE_TYPE_XGMI:
 		size = aqua_vanjaram_read_xgmi_state(adev, buf, max_size);
 		break;
+	case AMDGPU_REG_STATE_TYPE_WAFL:
+		size = aqua_vanjaram_read_wafl_state(adev, buf, max_size);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1


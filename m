Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11CEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C7B10E63F;
	Tue, 26 Apr 2022 18:29:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9639910E63F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APNYcMv7H3MeK+oDAct05bc71GekJRFqcKaByMgVEbx9BcA1SuJNjlxwXaCuJ7Rp/byaGSH+jApnWhqbu9q0/cCOAJ3fprz6fnbZcN4gX+v8E1gkx5OMohhsJs4OeWqf8nENEmitkF+QlHiDr93OlAjU8XusblFuq0dH6hcQQtzN7tQg4BDzeaHPl2q78oemH1w6fQhSM1yvAux2hwCkMqyn91hBkb5Ir8STope11Xn+GCwjV7hFpIYtVjOJDVePwS8UYyYYB2dvt1FQ5EjnFA2VGhd2NJ6/T0lwPOuiQ9W0G+Lni28VUgIYJgav3PTPpx3l+RU7oEDLmGfwxqJX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JlYgSRHMAmrNrlskGzq0YhrQ0NiIGciORjwcet96QY=;
 b=if+MolJ/UJD3NUXkW7iG8QVvx4RQGUASYxdP9rIPYxYG3sAarIJuCCstr3iLJZIk+i5FJhItbgf6UqDlA0ySYUbWIYqzly5clvuUHDPy5zmhbVWReNTMrYHHEQZce4m8ltuPCtCHhNdPAFkxtIfEicigTkGFo2uYmOhNQr/jMJYXGWIQptnkkWFqDw9IWPkQ7NSvmEKLWSnBhrr1Ly1xJeH06+K0XbodwrTCem9YsfZN1z2LvT1Eo4j4YMS4jjVeG5vVS/FY+5EAbTtzUwYXw2ZtGoDGa03WTrnx7RFeuz647rQF4JefSaiJbXNjht2+61hQGJL8t3T02ML3a5dEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JlYgSRHMAmrNrlskGzq0YhrQ0NiIGciORjwcet96QY=;
 b=c5R5FRlnAqzPdmibjBe8p/ioDtDvdK/QmlCW5BrZC/W9fcVjV56JB41Zu1WaQFj5OoLn/VhzLqjRINmzjd1DotIkusKK2mqlNqHrunZd5VpFJKWH0gGoxZzF8WxuS4bKGW9vnURYvDvNqop7N7Pfy+HGh6fOqx6P6NhIYkDzg+I=
Received: from MW4PR03CA0131.namprd03.prod.outlook.com (2603:10b6:303:8c::16)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:29:37 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::8a) by MW4PR03CA0131.outlook.office365.com
 (2603:10b6:303:8c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:29:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:29:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: support query vram_info v3_0
Date: Tue, 26 Apr 2022 14:29:17 -0400
Message-ID: <20220426182920.3007060-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182920.3007060-1-alexander.deucher@amd.com>
References: <20220426182920.3007060-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 602b2eb6-5fba-4c66-8a29-08da27b2b80e
X-MS-TrafficTypeDiagnostic: SA1PR12MB5658:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5658C39ED74BF4ADE915F244F7FB9@SA1PR12MB5658.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZiUDFyb8ofP+vvTTSP8GNzm0MeO/0PaVRy5yGoYPRKsNLoAP4t5l8LM6HNHig4PGYggUpr4ctJP6F+Hpv57zxH6sWvRlMzDpt0IwRxuvCo7Ek1pfGV4IXwUzcqbnRkeh0duzD5PNvuxMa24s44v5wRTAcYBSRBX3Uq186MIR2YS4nn6pR6yujp1VCSgU0l7N/VhF4O7bbqFzJoOpIeDIINKzX6MdmJa3SyRM0CrIldUYszage8jvtXhONZFs4eax84AUgsBhKFBo+9PwZ21uGdgsC2Wv/AByy9ybH9evk4NNs/w9tUXFAbeESgI9skrOd6Ko7zOxbFamDoZR3MgPyM5v58UKNj6y0UuNBfD0CJzJ7nvoZkeJyBZbPB+P/6Vb6edPHTq8bzFRT7mxXbX7QtsCA7XNViMvbbqenlKk5EeMxF4ad0Ru9Gb+6jIlRCxV+flnCtol4nr6js1Ocbm9BBCi7f2aj63tuAUYrZAUT/Cl1OCJX4gELP3MMtiwDMEljW90bJ3jC+b1PCkZ/5iJbNnm5dfncDwyHQ0lXgVL1ISoica1MkuQbJB+PV6l0XMZvLT0L+1A5mB/Oc9oQW2vM6Dfj+O+FVldKZXVTyxjD6NDAXnOm9LvjeMnqu8wbaCAYNXBJnXcPI/K+ZKJ6CoMvUz1qLjuVL00AoBGFVeKkoQOlwpNrWcWPYazubnvzuK20eZmpKUb+Lj6hq0CJr8/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(47076005)(4326008)(508600001)(8676002)(86362001)(40460700003)(70586007)(6666004)(81166007)(356005)(70206006)(6916009)(54906003)(426003)(5660300002)(336012)(7696005)(2906002)(36756003)(26005)(83380400001)(82310400005)(186003)(16526019)(1076003)(8936002)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:29:37.0094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602b2eb6-5fba-4c66-8a29-08da27b2b80e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

vram_info table provides various vram information
including vram_vendor, vram_type, vram_width, etc.

v2: correct the calculation of vram_width

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 190 ++++++++++--------
 1 file changed, 110 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index d27323ccc5f9..6034578cf57f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -162,12 +162,14 @@ union vram_info {
 	struct atom_vram_info_header_v2_4 v24;
 	struct atom_vram_info_header_v2_5 v25;
 	struct atom_vram_info_header_v2_6 v26;
+	struct atom_vram_info_header_v3_0 v30;
 };
 
 union vram_module {
 	struct atom_vram_module_v9 v9;
 	struct atom_vram_module_v10 v10;
 	struct atom_vram_module_v11 v11;
+	struct atom_vram_module_v3_0 v30;
 };
 
 static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
@@ -294,88 +296,116 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 			vram_info = (union vram_info *)
 				(mode_info->atom_context->bios + data_offset);
 			module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 0x00ff0000) >> 16;
-			switch (crev) {
-			case 3:
-				if (module_id > vram_info->v23.vram_module_num)
-					module_id = 0;
-				vram_module = (union vram_module *)vram_info->v23.vram_module;
-				while (i < module_id) {
-					vram_module = (union vram_module *)
-						((u8 *)vram_module + vram_module->v9.vram_module_size);
-					i++;
-				}
-				mem_type = vram_module->v9.memory_type;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-				mem_channel_number = vram_module->v9.channel_num;
-				mem_channel_width = vram_module->v9.channel_width;
-				if (vram_width)
-					*vram_width = mem_channel_number * (1 << mem_channel_width);
-				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
-				if (vram_vendor)
-					*vram_vendor = mem_vendor;
-				break;
-			case 4:
-				if (module_id > vram_info->v24.vram_module_num)
-					module_id = 0;
-				vram_module = (union vram_module *)vram_info->v24.vram_module;
-				while (i < module_id) {
-					vram_module = (union vram_module *)
-						((u8 *)vram_module + vram_module->v10.vram_module_size);
-					i++;
-				}
-				mem_type = vram_module->v10.memory_type;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-				mem_channel_number = vram_module->v10.channel_num;
-				mem_channel_width = vram_module->v10.channel_width;
-				if (vram_width)
-					*vram_width = mem_channel_number * (1 << mem_channel_width);
-				mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
-				if (vram_vendor)
-					*vram_vendor = mem_vendor;
-				break;
-			case 5:
-				if (module_id > vram_info->v25.vram_module_num)
-					module_id = 0;
-				vram_module = (union vram_module *)vram_info->v25.vram_module;
-				while (i < module_id) {
-					vram_module = (union vram_module *)
-						((u8 *)vram_module + vram_module->v11.vram_module_size);
-					i++;
+			if (frev == 3) {
+				switch (crev) {
+				/* v30 */
+				case 0:
+					vram_module = (union vram_module *)vram_info->v30.vram_module;
+					mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
+					if (vram_vendor)
+						*vram_vendor = mem_vendor;
+					mem_type = vram_info->v30.memory_type;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					mem_channel_number = vram_info->v30.channel_num;
+					mem_channel_width = vram_info->v30.channel_width;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
+					break;
+				default:
+					return -EINVAL;
 				}
-				mem_type = vram_module->v11.memory_type;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-				mem_channel_number = vram_module->v11.channel_num;
-				mem_channel_width = vram_module->v11.channel_width;
-				if (vram_width)
-					*vram_width = mem_channel_number * (1 << mem_channel_width);
-				mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
-				if (vram_vendor)
-					*vram_vendor = mem_vendor;
-				break;
-			case 6:
-				if (module_id > vram_info->v26.vram_module_num)
-					module_id = 0;
-				vram_module = (union vram_module *)vram_info->v26.vram_module;
-				while (i < module_id) {
-					vram_module = (union vram_module *)
-						((u8 *)vram_module + vram_module->v9.vram_module_size);
-					i++;
+			} else if (frev == 2) {
+				switch (crev) {
+				/* v23 */
+				case 3:
+					if (module_id > vram_info->v23.vram_module_num)
+						module_id = 0;
+					vram_module = (union vram_module *)vram_info->v23.vram_module;
+					while (i < module_id) {
+						vram_module = (union vram_module *)
+							((u8 *)vram_module + vram_module->v9.vram_module_size);
+						i++;
+					}
+					mem_type = vram_module->v9.memory_type;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					mem_channel_number = vram_module->v9.channel_num;
+					mem_channel_width = vram_module->v9.channel_width;
+					if (vram_width)
+						*vram_width = mem_channel_number * (1 << mem_channel_width);
+					mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
+					if (vram_vendor)
+						*vram_vendor = mem_vendor;
+					break;
+				/* v24 */
+				case 4:
+					if (module_id > vram_info->v24.vram_module_num)
+						module_id = 0;
+					vram_module = (union vram_module *)vram_info->v24.vram_module;
+					while (i < module_id) {
+						vram_module = (union vram_module *)
+							((u8 *)vram_module + vram_module->v10.vram_module_size);
+						i++;
+					}
+					mem_type = vram_module->v10.memory_type;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					mem_channel_number = vram_module->v10.channel_num;
+					mem_channel_width = vram_module->v10.channel_width;
+					if (vram_width)
+						*vram_width = mem_channel_number * (1 << mem_channel_width);
+					mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
+					if (vram_vendor)
+						*vram_vendor = mem_vendor;
+					break;
+				/* v25 */
+				case 5:
+					if (module_id > vram_info->v25.vram_module_num)
+						module_id = 0;
+					vram_module = (union vram_module *)vram_info->v25.vram_module;
+					while (i < module_id) {
+						vram_module = (union vram_module *)
+							((u8 *)vram_module + vram_module->v11.vram_module_size);
+						i++;
+					}
+					mem_type = vram_module->v11.memory_type;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					mem_channel_number = vram_module->v11.channel_num;
+					mem_channel_width = vram_module->v11.channel_width;
+					if (vram_width)
+						*vram_width = mem_channel_number * (1 << mem_channel_width);
+					mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
+					if (vram_vendor)
+						*vram_vendor = mem_vendor;
+					break;
+				/* v26 */
+				case 6:
+					if (module_id > vram_info->v26.vram_module_num)
+						module_id = 0;
+					vram_module = (union vram_module *)vram_info->v26.vram_module;
+					while (i < module_id) {
+						vram_module = (union vram_module *)
+							((u8 *)vram_module + vram_module->v9.vram_module_size);
+						i++;
+					}
+					mem_type = vram_module->v9.memory_type;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					mem_channel_number = vram_module->v9.channel_num;
+					mem_channel_width = vram_module->v9.channel_width;
+					if (vram_width)
+						*vram_width = mem_channel_number * (1 << mem_channel_width);
+					mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
+					if (vram_vendor)
+						*vram_vendor = mem_vendor;
+					break;
+				default:
+					return -EINVAL;
 				}
-				mem_type = vram_module->v9.memory_type;
-				if (vram_type)
-					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-				mem_channel_number = vram_module->v9.channel_num;
-				mem_channel_width = vram_module->v9.channel_width;
-				if (vram_width)
-					*vram_width = mem_channel_number * (1 << mem_channel_width);
-				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
-				if (vram_vendor)
-					*vram_vendor = mem_vendor;
-				break;
-			default:
+			} else {
+				/* invalid frev */
 				return -EINVAL;
 			}
 		}
-- 
2.35.1


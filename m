Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7025C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2D510F7FB;
	Wed, 29 Jun 2022 03:21:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B721A10F778
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6FCbhg2ip5jKq851MKiQazFT1cop9iFDsiXkU8sSSRD36/AFp2r9JLHuuJiDA3mGsCVo7Ht5JJkW9egLWWTKgOxFRzd9cZdOWi6xYAZUuTmfp8Dric+LQJ+OOeFaf2GVEaYShtvbZ8Cnd2ckvCNVSP279cCX9lkMDups0ZhrcRugLJSPG7Ws9ltKoYAV0tUhHUmxnUc+kERhI9GIVL72NLdVWopPrfZAS+OpJWXQrMfy+SzZnC204VYAnnQYDyC9l6DtLNfoQGrrKwBhamVaeUGvSH0cIw8D9PKoOIUaQB02oXYJVxaaEvtL6R8APL0nH6DJsjZgSvuqx9LsbE5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkf1JNAeFqHQrOSQ3gi8HBQXI7E6CcV30dWKdjw2OhA=;
 b=JDVSIqACdETyYM4KZnJtrr3OkRjLU1VcT2ZpKs2Vy3SGe3leIw9qgs9Fsol736wGrX9y/7l/LZqyRq0YRlAhZI8Fo9vbr9XdUzJQd9pokj5CxmeBpxLPsZGdMImrAXFPreigsa6JurjxikZu2IEGEgarAv+hswBzddN9yBq0i6EskT1xA/7UDxB5aQnzfw5H/Gopbx8c5zvBhDg07AwElwo5CBLiYqTUu35d3hRYiIvEBKioRdC9BN1dNr+HNOm/001STL8hLB4pQutEguO5AYUX1/rpmVAhkwZtwbxLAXxcH8ycYdV6gj8ZNE5ZLUOjEu3w2ssk8bxX7PiAiu3wuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkf1JNAeFqHQrOSQ3gi8HBQXI7E6CcV30dWKdjw2OhA=;
 b=ZMZmqVi7ZF+y+3U/2I6LQO4aj0x3TCNKq0/WIDRtwJujXJWjLlIpMI3NXt3ibK2G97BYG1hS2juJn/Ams+r0V3MBmR2DTlE1Sc6MdoGsVgtTzmlmCoBP7hdmrwGPVwPs7nNKA3afYn64my2icxNmt4QNqHUrd6qvg7faHqvNc5A=
Received: from DM6PR05CA0054.namprd05.prod.outlook.com (2603:10b6:5:335::23)
 by CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 03:21:36 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::f0) by DM6PR05CA0054.outlook.office365.com
 (2603:10b6:5:335::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:36 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:31 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/mes11: add mes11 misc op
Date: Wed, 29 Jun 2022 11:20:30 +0800
Message-ID: <20220629032034.2994328-3-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629032034.2994328-1-Jack.Xiao@amd.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8578e06c-75ff-4fe3-1208-08da597e79a6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1639:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sbwl0H/6YdWxrySIyMj6+LcJPh5PBr6weyEXzjo7AezGTJvSDxfMV556zKClF4Ypx1dPT+FvpfqZA3EtcB//ZZJARC1dNsQ1sbZWaEP+OUE7NjjPqJPGvpeSR2pyGbTFjiwy2rm/19czPIBv/hC9cl90S6e30qDsBQx6FGygSsb9SwGBSjpli2jX0b6Nho61MbHNoXoCWT8qy6XJvACiJjlMdgBzKIpnWouOQ8sHK0vLLFDrwFVIOQh3esfLldbh3Xa8oMyxofD1mFze6ylBUCyH+RNRYWUPet8PAFqFfOKClgmG6vgh9yUwf2YicuuGOWhxdmm4SdD00M4RqZ8OAg3BXZgGSxKPXzN9MJJaIlxOXt2pklI4FIBx4M5D6euf7YJZ+f0I9LvCbmGpsE2Rga4i63cyJk51gtY8K2BPTq+q1YDrXE7Ih8i2OkOPSf/bxJai5u6lEh2JHkB3m0Ig0HG1YyhdUi99YoEie0WMDROvHCFFagJ1SYFSwNGoaEU4xpDtQcqQTvzso/tzUA5x8VVRBfCAzZNIononcMbI0aNDVxdEo3HvLkc+krmSMrKYUx1M2kHLHCxgdTBxSFVZUWBReXn4t5FAydjx2Y29hOK/MlnEtwTqMpw9mBJyuEIy1jRz5C5iDrDtOyw85PTJHo24Wb2qj+ME/wdq/CF2r1ViJOM3FrYSqCiVFgMnUm6dDgiupcXih1tXpIFrCjsW60mquPdkA5gusdh1st4ZdxL+iW3aMKiqU576t0pBovP8s1W0KtGBXRMzQj24mdJ0oxHjphbHqSZ5tSo5myuiPVqdomBfPbLOCJXX8lYStzlV1sVz+cNYXOIgul/M0bZ3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(40470700004)(36840700001)(46966006)(81166007)(4326008)(83380400001)(40460700003)(478600001)(426003)(7696005)(47076005)(26005)(16526019)(70586007)(40480700001)(2616005)(8676002)(82740400003)(356005)(36860700001)(336012)(186003)(70206006)(316002)(2906002)(5660300002)(1076003)(6916009)(36756003)(86362001)(82310400005)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:36.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8578e06c-75ff-4fe3-1208-08da597e79a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add misc op commands in mes11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d5200cbceb8a..e2aa1ebb3a00 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -262,6 +262,58 @@ static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
 			&mes_status_pkt, sizeof(mes_status_pkt));
 }
 
+static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
+			     struct mes_misc_op_input *input)
+{
+	union MESAPI__MISC misc_pkt;
+
+	memset(&misc_pkt, 0, sizeof(misc_pkt));
+
+	misc_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	misc_pkt.header.opcode = MES_SCH_API_MISC;
+	misc_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	switch (input->op) {
+	case MES_MISC_OP_READ_REG:
+		misc_pkt.opcode = MESAPI_MISC__READ_REG;
+		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
+		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		break;
+	case MES_MISC_OP_WRITE_REG:
+		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
+		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
+		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
+		break;
+	case MES_MISC_OP_WRM_REG_WAIT:
+		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
+		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
+		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
+		misc_pkt.wait_reg_mem.reg_offset2 = 0;
+		break;
+	case MES_MISC_OP_WRM_REG_WR_WAIT:
+		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WR_WAIT_WR_REG;
+		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
+		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
+		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
+		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
+		break;
+	default:
+		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		return -EINVAL;
+	}
+
+	misc_pkt.api_status.api_completion_fence_addr =
+		mes->ring.fence_drv.gpu_addr;
+	misc_pkt.api_status.api_completion_fence_value =
+		++mes->ring.fence_drv.sync_seq;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&misc_pkt, sizeof(misc_pkt));
+}
+
 static int mes_v11_0_set_debug_vmid(struct amdgpu_mes *mes,
                                   struct mes_debug_vmid_input *input)
 {
@@ -355,6 +407,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.set_debug_vmid = mes_v11_0_set_debug_vmid,
+	.misc_op = mes_v11_0_misc_op,
 };
 
 static int mes_v11_0_init_microcode(struct amdgpu_device *adev,
-- 
2.35.1


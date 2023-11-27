Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C7FC07D5A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385F110E0A3;
	Mon, 27 Nov 2023 18:57:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0662310E0A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxc1AICu+yDUkEOiMjxg0pUqtxXQRvC+9T4ghUjoRjSJdjxzllFbDUw7lPhEVVh26EvCWokMj4JKxMn3V36cxfdEzUutrW6YHl0xO9YWFXfQy46uM28eGd8KIPh8rTirnir6L6Gtvv8HkOalWLJz1tG9HTEjd5psuYl4fN1OnDsqDbEIL80VBVApD34ihtVjb2WLizGWul5gtMAJnTtrONia0HkHZ613Xu0xw5Z5t3+UcMwCdUvwz5FLhHxHBRReKi/9UQVETLbObsJJnlJmLhr6rzXW6HrpnCZSz3WWuilsBJbpfZDGcVfQdRM1w7YRavUGQ3ElfaA/TcDtKp6jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKqfpN/aGdidH+t4mz0T7Hr1oH8zS4SddzmlmgT09bw=;
 b=Ylf56lMpdx1ZYFv5b7PWbvut31XtQhAy5tl0e8YfLryyeznd4KcEGLXXlTun/jvD5RxU7ZuLzKUqdsn+PSwvnqV2g4UHFUlCGRoD84xHx93UXeHLagrkMha2nO9brb2dYYWAc0Po0J5OFSfS5vYmV21HyNhdDEjugZKyVUmnlcBqARvPZ6vRZyMFBX1AG9RBW93XqdwyjrTMlq4unmy3FnTFXgmF072HFU8dogtTdd3ZBMzYYtgsU5os13vlMfjzs+LnWMOCwMklFIKl7ItkJBmKDxxzs02ZsSEOEwmRFiPGdQahbnwV8tlkBTDvbtsyvbY1FlTosUU6k0Otr4d/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKqfpN/aGdidH+t4mz0T7Hr1oH8zS4SddzmlmgT09bw=;
 b=PmLMJ3NiXiI2d+/g7jCrBExHWurQf2qh5KduB9QnKMkddHUb1M0o9D/jkXxc0D3daSLxYp19XzPoP909x69z7kWo9TROeys2ik2v19rfGTUukxQyErH9ys3kUKOtB+SPoPrkHgDfd2Z9Xt6W664ikuU8RDJH9KhEve1NY4pNnIo=
Received: from BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 18:57:45 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8f) by BL1PR13CA0159.outlook.office365.com
 (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Mon, 27 Nov 2023 18:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 18:57:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 12:57:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix uninitialized return value
Date: Tue, 28 Nov 2023 00:26:15 +0530
Message-ID: <20231127185615.1110293-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe9f99f-4ba6-4cb4-b157-08dbef7abd9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaBVxsRjfLz9tsQaAoTkxu5L1Cz+qxe/I6a3HWM1rKhEPZhJPAm8L+SvQE5z2p7WFfRpiXb8s6zPZpUYXteNCHgbb8rghpOAReZpXJMU9HHnVrUbIO1MqhBj48hhKh6Neh5bKVdBeXuGv3gfNbQrBgxNi1pBQEwykm9BTjaNoLIotbc1fXHff0gpvltg4kaP9iBMu93lUNFHiq2/6aTet7Gn/ZE5Xj9xqlIClAtr/LoXEY/3zQc0/XQ4jr3Lv+8khAZ4FSMJyl+JE2MYCugW9rnttcsEstc5Z292A+RwMqatnhkeDR7+I3ddJe0jdvj3MWKZlw8ONHvKXIrcx2IJlYYaqPX5vrxak/sN47R8/dCWh4zMzUFL1uua0FunlkKqhsawoynhJ+i4A3baHd7C4koaPnai6H0Zj8McLgNlMn9vm/rnAReOqdUSgEYBA5Z/6ZnmzDujrU9JK3R2/ydofZno9Q6c2GOlR9FCLo+ZCxd4Me506t7opMnNTRrjiO3wT/TaOwZnU08N4CKzL/2mVzQB45r+Ww1ND29pma9UsGjhHv0tlHf9xQcbXxCxQm4MPzPmy6RblawWbuVf1q7u/vmGc1J7LuIyK9G+fBlRb9gEJDwWZH3PKS7OsjJRYjtoq07Hxlq+mp2VDIkuq7xQkh0hHA0tvuraZz/ydQjiHxOl8YDH3hiUdLPCwDDQPJaUSjfp8eHcNV+CAxtMoBofwr+LdjNFv09jwfig8c0iEcS07GayHI1X2zAcFC90IKoYteXP1d4qD+UwuRrP2eA+zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(4326008)(8936002)(8676002)(7696005)(6916009)(54906003)(316002)(40460700003)(478600001)(81166007)(4744005)(356005)(47076005)(36756003)(40480700001)(41300700001)(1076003)(86362001)(26005)(44832011)(70586007)(36860700001)(336012)(2906002)(2616005)(426003)(16526019)(82740400003)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:57:44.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe9f99f-4ba6-4cb4-b157-08dbef7abd9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

The return value is uniinitialized if ras context is NULL.

Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Avoid variable initialization (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1a8668a63e67..79fae180639a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3416,6 +3416,8 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
 		if (!ret)
 			con->is_mca_debug_mode = enable;
+	} else {
+		ret = 0;
 	}
 
 	return ret;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C3AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC2110F2C9;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B70F10F25B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G106a8AKRjKGg1CqcdyYhMTsKvZbKAFWAF9F/x3yAG1BGOgBL3k+0WkNEjRCLypNAex+8NFgilZbYFCqcNJL4AAOT/wdWoDWSbQJhe/UUWChCEMe+gHrwUNsiQDagcwEp2mDmiADyJlrhGsXH4eCpVVQ+1lxclAN2h8atpUAWSciTLYZlBpI546kFVnTJJF3DANn1wQc+rHyp/AfWLDK9pHKmRMzyW3HOyRLMDUvrSv3ndty+yX6mkmYEU0IieP9DqkdqNvzfJHuvnX3lHsykAf0gCMj5ybBBonqrxG1vPExjkYdreqfThFfIjOjjps2Xxhjl2T1ABlWo8COvUsWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSlavJVftlYCcR2Ltlvu5gNQDoP3AcTUm1tvVJpRnPw=;
 b=dXbCEhVEZVHgHyCnwHI5rFg7Gok/PNje5s12pEU+ITmVnBxuBz7gGKly96dSu+ytTv8ZLofCWNMuX1qXvVA1pvi76bE3Qjj0lTV1yFgOmGNkgzrdOAbTCIdGkeeBCRSfpxlViQNyxrTq0sFtBaRw3YMxNTE2jU93zK86CinCD8t3WnM8m4Bvojt/3qxUwbiRtOx1RGuEaCowhAnM+bbhYJ+Wj2RXCMLn9hZ1CQwZK+e3aDYPXizSvBmuklmTi1qLZAM+whoJis0LuCP+lQOu4lt2mXdizIYvFJ78/EGlQGUPY1msxzpx3mSdno8qvAtAG/zOLN81CZIfiLYReZysxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSlavJVftlYCcR2Ltlvu5gNQDoP3AcTUm1tvVJpRnPw=;
 b=p95MbKKONeRveJFn2rzIkUOax/yWkGifpoDxQyl3UmPy/EHRpbvxrunQCSQ40Kqo6Q913zA3h0k0K6RnTlsUWljECtTkj0i99EvK44JG4xxBq6OVH3PTgO4a4xF61ZWYzTJt0M2JJt8TRc4vUbRPjqbLUkBWDq9p/F77x2+If7o=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 17:47:09 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::1a) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 50/73] drm/amdgpu/mes: implement suspending all gangs
Date: Fri, 29 Apr 2022 13:46:01 -0400
Message-ID: <20220429174624.459475-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ff0384-4a04-4b6d-be6b-08da2a0848ad
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6354828300FB1E8A5205620BF7FC9@IA1PR12MB6354.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bgv4nnz5W4852IzzwMilSj8bqvh7ZX4IHvCLwuv5L1JBUk1GNidAa/0bFfLIeJlU4RbeIzLIL55vhKhDhpAw7I2tawTHNLMlAuanBss2gohrMyo25aIQu0RUutUfW7N097c7YxavMvCc681tnhe71pZvPgg0vOeWNcBcpgx/czuCVq64Mn4TwJUSunfQO4u7wcf8sA8XpTq0OAUYT5/2fLVM7gXAyQcoD+B7Cv6ZBZhxNmlB5s3zEp4rg0GKhbBSyAzAPmUuZ++QScHN0jql3QJ1OBMUhy95EAXgecJjU88NYFJnfgVkelDdxNsF+jy87xjHBMJL/ZzG6l3eqV2k0WskBODlTfQ2rP6dyG/SYu+k9/6tl9dCqVuHsED3DfWw4/KFZapJKNSJMvv1obXdXUoH1O/u1hTYZTqRDc7zttsgsh0ORXkq4oYtI/+BECAcucGNKU2DPbhb6fVMzHVpi4kJIpql5vfcbTzxViIOlTekXl2nCUa7EKamryWtlGPq8caIOBnkqROpCluf/1qVrWK18xDO1gFMz2WhUHeDYol+Y5QpDYtHQ5UTaIijVeIHR88NYmXMjg0oBmSRC7Om6FITE74NriMhKDwiUqZZx3iQiNCDucgSNSysSlp3RB5Q/boLVoWhCyNb9iAFj/uwAVq0Sk/6mfs1H4eZkNPxXF3TcdIhxv2T9B69ZoFPUJi8r/zQGX7yDSZWr3IS4lQ/NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(15650500001)(8676002)(2906002)(508600001)(70586007)(70206006)(2616005)(36860700001)(4326008)(36756003)(26005)(316002)(1076003)(7696005)(356005)(6666004)(5660300002)(81166007)(6916009)(83380400001)(54906003)(86362001)(16526019)(186003)(47076005)(426003)(336012)(8936002)(66574015)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:09.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ff0384-4a04-4b6d-be6b-08da2a0848ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Implement suspending all gangs.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 07ddf7bf6a3b..e64f2a4b5a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -446,3 +446,28 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
 	mutex_unlock(&adev->mes.mutex);
 	return 0;
 }
+
+int amdgpu_mes_suspend(struct amdgpu_device *adev)
+{
+	struct idr *idp;
+	struct amdgpu_mes_process *process;
+	struct amdgpu_mes_gang *gang;
+	struct mes_suspend_gang_input input;
+	int r, pasid;
+
+	mutex_lock(&adev->mes.mutex);
+
+	idp = &adev->mes.pasid_idr;
+
+	idr_for_each_entry(idp, process, pasid) {
+		list_for_each_entry(gang, &process->gang_list, list) {
+			r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
+			if (r)
+				DRM_ERROR("failed to suspend pasid %d gangid %d",
+					 pasid, gang->gang_id);
+		}
+	}
+
+	mutex_unlock(&adev->mes.mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f401a0a3eebd..667fc9f9b21b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -230,4 +230,6 @@ int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
 			int *gang_id);
 int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
 
+int amdgpu_mes_suspend(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1


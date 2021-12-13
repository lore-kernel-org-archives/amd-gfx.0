Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF9D10ED00;
	Mon, 13 Dec 2021 03:53:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEE310ED0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wypcy6Gu0mqKao+LAB6D6jH+jqLYltoOFf9PV8QproCZo/2WJHhE0DHIMT5W51lUcwu7Er+uKddMdK6gp7u8cduZ0IWNyanQcAmMNYvHpitbwEcDKRCJMXmYIj0wWDp5A5yx8aNJ5RngloBtok98uaVkqT3s2uTisfbPJh2b3JdSsrpxQSTOrUpYM5uAJRlOQBY6j6lL232gguNxjq0530QB2uwQN/XnJUymRlqT5Qblmjh5F7G0luJb65H8tnQrLH4j7zvMdt0LqYunrpUlBVZZkaCWYR2OQkYy1I7E/G0Kga2ESK0ih2BrOXnw8llUlSYa2lnfVYBYUvnRnb3DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKwfDqh6ErZvo6I77ZSrC8/xBmhclT5K6Jt0AhjM1Rk=;
 b=DO6KeNI7qbXMFPJofH2R3sGwhnpcSvVK6CEC1/gBtEILx4BssVSKS3M3KYNl/80L3r/dbA2AiNOHwk7W2WKjH2LtFGIoI36i0+k+kezWS4IAn772QMXrcTgW4oIUx3esmsLiOViPlpSNUOoCdGem8vCu7TZ7aU+TgrmleleWvTM8U/Jxah8PUOcjcLSMzGd+/JVqPhOmJsG7ts2yYSRmc8tJ8yZLQz9Mq6MrBrVw9uduI63K1in6Unqg/FgUxLI1jO6u1h0c3Xa078tC3R1gq0Wv8CwMGl4WZeDxQeesMCv28lLLqChoGmqe6bU3ccvAhALeC9LamyZHRSbw5SrP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKwfDqh6ErZvo6I77ZSrC8/xBmhclT5K6Jt0AhjM1Rk=;
 b=2M6w8HGtUhdoqPFDQ7z3/BJLd6BhVn50Tc4oScbq1KOv978kKQ10d6eU2+Fsh38bl6FEec7BdWtrrJgqD/lTICRfWuJMHzfAtwDVKuuTPcAEW9pA6nIwBNmfTE8Rs7MCqfkvn4Mm7UVdpm5+lM0zIWCm37EuldzoPWhUbhL7nA0=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Mon, 13 Dec 2021 03:52:57 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::e) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:54 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 08/16] drm/amd/pm: move pp_force_state_enabled member to
 amdgpu_pm structure
Date: Mon, 13 Dec 2021 11:52:15 +0800
Message-ID: <20211213035223.772700-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a0548f2-de42-4eb8-7672-08d9bdec0c35
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3194A70C4F22E6244003C7D5E4749@DM6PR12MB3194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KerXPnAgH24WaBClCEgk4Ek1SpM5sJi6/eC5iIUcEEDxP8S6pP9iUoNHtrKAKHWO+O8JcSMGXE3zxOpd5wNF40MwRF3S09e0NP1fu/T7xEHX9JObC4L82wYDER80MpVIT2lhDL5tlLZLj4KCb45EFBs7PEW6vrYFQjYFmMfQpP9Q94SfFHfGMzecl09oA81H9/Y6sVCfDng3Oli3gRdDZ3t9nkHOo4+5Vz2tIyC3PrzFZ6EaAnOIF/FOQ1NhVWR+CQFkP7M860VwE0MLyLp+P0j/ayvtTXSbZAOr0VYwOI9078DCPFammrdpwf1McDAperQ0VnjeakEGbv+ge0DuiXJ9F83F2OZ8928vNDYIYtZvByY9I+bIdbffoEX3oozgnSQZVrsvorqxsW1WMyKYiPxQzPDizdfUrXW2V7+dvvAq2a9ZYIjTWgRcrFk8YRGOX9M9Hp1BS55x1sCyIaWnF6pOn5BcqIt5BPTCcM88PpG7itTJFKCLl7IZ0Yi/xe2f7N/HkVg5jht4uQmop/iPJVvRdvtv2tcQLGdjPMPQ6KvQlyaXKRbGMDAqKYeBABYkBDDtOdUBjG8d4wdrjk4GDAWm4+kxRtIHfJfAmyDWfSRo3vvQGrQTwCCo0vRwvjmN3BWbNN+bqHb+i//WdKjQgKSoZcnPdtWeaFZ62YVLfii19+fco1QxiJkBCCefp1hmSUAosLVTQdBogiLFv6RUAOppXWoSlbarr94lCkBw+KHkfWsN+6/5HCaafwNeEf4Rug9c0iXCNvTVe10yqHrF8jlpmXa2QdFV2NlpmE96JRY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(186003)(82310400004)(83380400001)(26005)(47076005)(356005)(426003)(336012)(36860700001)(36756003)(6666004)(86362001)(1076003)(2906002)(508600001)(44832011)(6916009)(70586007)(54906003)(2616005)(8936002)(8676002)(70206006)(16526019)(40460700001)(4326008)(5660300002)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:56.3460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0548f2-de42-4eb8-7672-08d9bdec0c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it lables an internal pm state and amdgpu_pm structure is the more
proper place than amdgpu_device structure for it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7890e8fe7af2ecd8591d30442340deb8773bacc3
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 6 +++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9ceb8f3e73de..2d8070a9394e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -953,7 +953,6 @@ struct amdgpu_device {
 
 	/* powerplay */
 	struct amd_powerplay		powerplay;
-	bool				pp_force_state_enabled;
 
 	/* smu */
 	struct smu_context		smu;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3382d30b5d90..fa2f4e11e94e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -469,7 +469,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (adev->pp_force_state_enabled)
+	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
 		return sysfs_emit(buf, "\n");
@@ -492,7 +492,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	adev->pp_force_state_enabled = false;
+	adev->pm.pp_force_state_enabled = false;
 
 	if (strlen(buf) == 1)
 		return count;
@@ -523,7 +523,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		if (ret)
 			goto err_out;
 
-		adev->pp_force_state_enabled = true;
+		adev->pm.pp_force_state_enabled = true;
 	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 89caece4ab3e..b7841a989d59 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -335,6 +335,8 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	bool			pp_force_state_enabled;
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0


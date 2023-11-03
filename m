Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690BC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEF410E9CC;
	Fri,  3 Nov 2023 13:12:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF01710E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+1kfkfgq3eT3+fDSPtRzu1AL4WWxSlDNOCnYLfLd65aAPJfXiHQNKf78VJ4kQNS/Bkn0ujhfCy6qNF6BZZXiE9uyT9RN6lnce+cuQbHXef2LJ/G8pUiczFek/DJWEgTZml/94/L47+c9XYcVb7Ve63Xp560INYnL7hm88nufMeo0RuzFq5MhWIUSB0sA+efpuMUcQyaRvpb781xe1SAji6HkDI9LK4tsxhOTduKbDc7bYMt0hy5SFa9ouGOqUIUsAFglCJOFqs14HsWxZDHIFa6sN7G0GoRE1v6n0b3ufBTDEp9AoCDK8kSYlMCL1cBTWx0GkgCSwlsJ1l278A1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lWytDtvTEa2hz1PNZAlxHPmpl/9qVQbgXhbBJ3Aq/s=;
 b=ayNfuLaEsXcEQexYClqcIRpyZ5lsRla3mIJH5cGFthDweY25nQp7E+QybLjSgWdnXiFb0EcNU/im94NgTyb2KYYvDzqXQjY0zmH0U5tNZHAXwVf4VGuinIClud/rerPavFq2zNQLY88Rid/l4AWCct7S8rvhntaLFbaG0q0WaYTh+fHY4wAtacXLewILg2w8L7L7kAmEyPu9QoRJ2xQQfI2OhO/A+eTAto/sjQyoQEojRvsNZTRjTM1CHwlYTHyTEgBGVFFbSCoCr9ioBDVrWQERreXr3vrLfEdj3tywPh09Au7x2lMx8c+6lPglk496WGU/UiIbuTeohnm7VtsKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lWytDtvTEa2hz1PNZAlxHPmpl/9qVQbgXhbBJ3Aq/s=;
 b=XAjZAXheurHRIgRd/bOEAsMtU38eZTcoE/zVM1FLAJiXjR0x9Pmab8pXKagDYgx7Yul5utcu7YRtMfoQJby0IHcgZRFwxeS8vjXpu55P8nI/9YHZucWB9hVWpnipR2Zr/2Ay1UrdTM8/esNlVFY/HmnHYDQfcz1NukwvvkJ0npw=
Received: from DS7PR03CA0118.namprd03.prod.outlook.com (2603:10b6:5:3b7::33)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 13:12:01 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::d6) by DS7PR03CA0118.outlook.office365.com
 (2603:10b6:5:3b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:01 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:59 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/24] drm/amdkfd: enable pc sampling create
Date: Fri, 3 Nov 2023 09:11:20 -0400
Message-ID: <20231103131139.766920-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 3277e6a4-26f4-42b3-2d33-08dbdc6e77db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BV8E00D+PcaFn9sUdJ0/f0vNbmYQVvJKHo57bsQj47nqeZKtihfDjiiQGbpPVSjG55mCnIWlm2Hiw9/i0ghIRSew+Y0+9OOcW6iFzYW/eD4bO00fUGbMX729CCveQP2Czq711J2wGynczn3YZqtbqd4E2wZrZQc7+jR2ozTV+hj7dOMxkAmUS7yWBZwPSC9Jq8r/NIZYUFzIh+UCBhZNJvlEo47P5gZppWsT4LoIxYpurcFkMCX4w/gS0vAJwk3o/DTRIcTPgrD0PDazAUi1K1xAeuRg0dPcMgVa/4AL4v0uNul1UaB05okamXNe4A/tsKzy3UbaSrdx/OnDw0y7hAg8xfn0cHy54hkR4/0g/i7L9GM45ypYn2AjFGvBi1O3liT/FH9Oq/PFoBqmb4CB9k6VMnCqKmOgi9eSPVtKGPXmzjh9vKakarAJUzk7aRV11uxLp/xEhKGS87fKpNdlkhYB6O6Bo8tZ84Xnn5DTtmPvxR+sYlLP4QuZ3ESzB/RnVN9rKlLbHYMMMieItzexsjaQ/CYTMMvBCzoLmzWlAkismx8wNtA+u8UAT5q1B/KarNKv9xI8PMmJ9NjvUiOPZVJI5VG91T4qJr5tCOSFm+On3ylnUWpT9QRBvnLTCvSIVk02j62gPM1J1wlUpbLwazORTE56Vz72PFFDFlb5n/lDv9v8Sa1s+ao8QQM/dZeB7jQJ3eQbV1INLRwgEW9GekF7otAi5Wtjzjkx89KOzc7GIJIBVIc8a7dmc0aV3Y9vzKOO2G1vXJb6PxaWqdlryw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(316002)(5660300002)(6916009)(336012)(426003)(40460700003)(4326008)(8936002)(8676002)(36860700001)(356005)(83380400001)(86362001)(81166007)(2906002)(6666004)(54906003)(478600001)(47076005)(7696005)(26005)(16526019)(1076003)(82740400003)(2616005)(36756003)(70586007)(40480700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:01.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277e6a4-26f4-42b3-2d33-08dbdc6e77db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling create.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 49fecbc7013e..f0d910ee730c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -97,7 +97,59 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	struct kfd_pc_sample_info *supported_format = NULL;
+	struct kfd_pc_sample_info user_info;
+	int ret;
+	int i;
+
+	if (user_args->num_sample_info != 1)
+		return -EINVAL;
+
+	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
+				sizeof(struct kfd_pc_sample_info));
+	if (ret) {
+		pr_debug("Failed to copy PC sampling info from user\n");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version
+			&& user_info.method == supported_formats[i].sample_info->method
+			&& user_info.type == supported_formats[i].sample_info->type
+			&& user_info.value <= supported_formats[i].sample_info->value_max
+			&& user_info.value >= supported_formats[i].sample_info->value_min) {
+			supported_format =
+				(struct kfd_pc_sample_info *)supported_formats[i].sample_info;
+			break;
+		}
+	}
+
+	if (!supported_format) {
+		pr_debug("Sampling format is not supported!");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
+		memcmp(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+				&user_info, sizeof(user_info))) {
+		ret = copy_to_user((void __user *) user_args->sample_info_ptr,
+			&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+			sizeof(struct kfd_pc_sample_info));
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return ret ? ret : -EEXIST;
+	}
+
+	/* TODO: add trace_id return */
+
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
+		memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+				&user_info, sizeof(user_info));
+
+	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	return 0;
 }
 
 static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4a0b66189c67..81c925fb2952 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -256,9 +256,19 @@ struct kfd_vmid_info {
 
 struct kfd_dev;
 
+struct kfd_dev_pc_sampling_data {
+	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct kfd_pc_sample_info pc_sample_info;
+};
+
+struct kfd_dev_pcs_hosttrap {
+	struct kfd_dev_pc_sampling_data base;
+};
+
 /* Per device PC Sampling data */
 struct kfd_dev_pc_sampling {
 	struct mutex mutex;
+	struct kfd_dev_pcs_hosttrap hosttrap_entry;
 };
 
 struct kfd_node {
-- 
2.25.1


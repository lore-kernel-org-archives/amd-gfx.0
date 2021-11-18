Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6EDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B66C61057
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B66C61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642CD6EA57;
	Thu, 18 Nov 2021 18:19:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F656EA57
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 18:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDL3yFCTnC/AfZfS0NmgXCydkNLnWjyJKxN1ENP4EOhIOtrLg/XYLhWl6nW+WbiKx/LpIR8JqBPJN2wDjy0BnibmTlbBF+xMZL7KGUc+5kR+fqbL1cBKyXqz0jR70qQOUjig58STIlXAZEB8ACGmHorcTQR8MNq7wq6yAknuLpkMrSW+ju0EpnxIrcJLP97Tu2L/gk6aGG+GKjDM4+k1fo3fWHFzaCZ+hWJqFdhcLN5w7AZ26pks9AH6t4YPGb66WodwK2LpbImVNRbEfdzA6WcrmyIvAm/XFo6hVf0cXxoED/L6narZ33tBor+aWJyMXPFmHaFuSK0wwUkArtxKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/FRqE4Q2sVIWSqLkU10QnOSGKEUosBfbr+f2eWfQQk=;
 b=WUTmODDjK3rGQJ8BIk7ZaokHLEz7qdF6lH57os79V1bdu2gSXAfXfwDr4rx7ZTNK4yhdb0GxzbfqCGyG+r3dXXLkhlF+lzXferHQqFg6W5dZbj1d2iOPRaFYhJn6bGR0djx4aX2NU+M/o2qFKqqCsQK5Z1Jb3KTAI4Ebhan5WUr/1IM76X0G9nirYqthR9G4iXqv7DfTzm6exWOi/DNpsCW/VqFOkxeOdy6OqveNvwfXtpBOdr4jhInBqRDWLug6a4MJI2Q0H7QWxtfhDOaTFWL+O9MqU8y45tRx/Mrd1JKKyCxU9JVjUajrmRbGhrSzzowCBCa4B6so0GW+Op+XGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/FRqE4Q2sVIWSqLkU10QnOSGKEUosBfbr+f2eWfQQk=;
 b=AXrAjcSGO96alm6TY0Y4sqeSmeYvYt8fqxBfLKZdhqldNgFggNfUt6jNqvlPs6rGvEx1jzziAJ9a2nCRqfATCwug6EgNt3Bkfp9E7Dzq6l+FUEkFL/YoDnhDf/j4hyiXZtNz4Q8/4HBnvEaYz6sVJgH5NfPwUG3Aney8Jm9myis=
Received: from DM5PR12CA0049.namprd12.prod.outlook.com (2603:10b6:3:103::11)
 by BN8PR12MB3412.namprd12.prod.outlook.com (2603:10b6:408:65::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 18:19:03 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::ee) by DM5PR12CA0049.outlook.office365.com
 (2603:10b6:3:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 18:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 18:19:03 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 18 Nov 2021 12:18:59 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 1/3] drm/amd/pm: Add STB accessors interface
Date: Thu, 18 Nov 2021 13:18:25 -0500
Message-ID: <20211118181827.237115-2-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
References: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10be6f50-0ab0-46fa-d073-08d9aabfe69d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3412:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3412F6E0EA16B18CAB470FC4EA9B9@BN8PR12MB3412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPZKAEhQttBqH1fWDGWjTdyy56vfJpqghklsgqdcVzrM/1VB5gJAK4GwAl5W36ZM6+009XuyWBMFu8u/YD9kfIi6AnikZo2nz8DnO4I1mEtXRveSvMVbT1ExG8NFs7Krp6oNywNk7cNqctDgI6980P1l+4zNkx8MAjdZVPxr6ww+C+w78pjxQ7rTDqmbTK4vzwlLbIO4zXaToBpZq1CpPyvqkO3dUDDuAtDkPkHL8pD0Z0+2P5kmqD/e91MWfYS2+oDKPAZ/1n6lyR+s1CQOHKkVZudTv87lXh+ulpi30CmXJ4TkiXZK1o2Gx1PywIZRBTd2qjwo8EykqxVhs8TBS+lxSGsb0fTfWumqHGi0WNq7f9COjvpKRglOPT5xuywB43gBkWBF6q8/Foa4VzoBPAkm/0ER8RNz8eAFAFAWxXjM+hSyhJcBNgj/GEjDmhx0+/IvTJnWgAjcxeHWqM5Xhs1OtU6sstnlcQqsHue+u8GP6YQ8a1L3Cdrkgq+DGkg9ziZ2L48Nksx5KG709TozgvRislT704gy9UQdUL8iTr/afhWGtuoTXe0H96zE6vugrIi2V3mMwGY7Hr5WjlZXn/rok95GHHU92NRGskH11Z1phjci/0sNXMmC1ixFaHuEIJ94Kz4f5JJBxq3o3FS1lOV9vbQ7saOpl+wu3Wn7Bg41tC9kC0bVzJqBaGNagvU1+e8KVBITVNWe/K0obglaZIORkfd22dHiDQjGZVXvalg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(426003)(336012)(2616005)(316002)(5660300002)(70586007)(6666004)(70206006)(82310400003)(1076003)(36756003)(8936002)(16526019)(7696005)(36860700001)(2906002)(186003)(83380400001)(81166007)(6916009)(356005)(47076005)(4326008)(26005)(8676002)(44832011)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 18:19:03.3413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10be6f50-0ab0-46fa-d073-08d9aabfe69d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3412
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
Cc: alexander.deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 luben.tuikov@amd.com, Shyam-sundar.S-k@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to collect STB logs.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 7a06021a58f0..4301403af761 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -474,6 +474,12 @@ struct cmn2asic_mapping {
 	int	map_to;
 };
 
+struct stb_context {
+	uint32_t stb_buf_size;
+	bool enabled;
+	spinlock_t lock;
+};
+
 #define WORKLOAD_POLICY_MAX 7
 struct smu_context
 {
@@ -561,6 +567,8 @@ struct smu_context
 	uint16_t cpu_core_num;
 
 	struct smu_user_dpm_profile user_dpm_profile;
+
+	struct stb_context stb_context;
 };
 
 struct i2c_adapter;
@@ -1268,6 +1276,12 @@ struct pptable_funcs {
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
 	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
+	
+	
+	/**
+	 * @stb_collect_info: Collects Smart Trace Buffers data.
+	 */
+	int (*stb_collect_info)(struct smu_context *smu, void *buf, uint32_t size);
 };
 
 typedef enum {
@@ -1405,6 +1419,7 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
 int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
+int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fd3b6b460b12..97bafba4c5c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3175,3 +3175,21 @@ int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 
 	return ret;
 }
+
+int smu_stb_collect_info(struct smu_context *smu, void *buf, uint32_t size)
+{
+
+	if (!smu->ppt_funcs->stb_collect_info || !smu->stb_context.enabled)
+		return -EOPNOTSUPP;
+
+	/* Confirm the buffer allocated is of correct size */
+	if (size != smu->stb_context.stb_buf_size)
+		return -EINVAL;
+
+	/*
+	 * No need to lock smu mutex as we access STB directly through MMIO
+	 * and not going through SMU messaging route (for now at least).
+	 * For registers access rely on implementation internal locking.
+	 */
+	return smu->ppt_funcs->stb_collect_info(smu, buf, size);
+}
-- 
2.25.1


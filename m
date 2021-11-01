Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F79C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 19:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC94360EBB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 19:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC94360EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7303A6E176;
	Mon,  1 Nov 2021 19:10:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95FD6E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 19:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlDW9RdbQwH4rT4EOn4JMwtADg8Wrud9Tdqm+fmUwpzShM9X28IPRj5ZVss3jaD3cCkqOeXrnFYkJzUW1tNB4tQfkyIRQRkpo4fDYKRgNLBzROvY7wxfP9RtDqO0eQq1AisfD7Qnrhsd1ZJnJn4d3YIDAZx5qE7w0IAuaMfONkH8KGKW87L5ySs/cQPac2W/d8rYG/IAGdF8o24QG4torElLX3bdC+aj2cjmnrloA2TqpBcW9iMJ4OlzFqRDlaZ/ly5VA2sdgh75EvZTKtDUO+2YyjrYE35251Mwt8Ewqmq+DIVPnuxcS2xXbq5fde5Hi5cOjtvq1fAjsokmqkSWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOM7Qh9ZJsTmKuggsYT30/sOO8xBbP3ctEH7uj0ocao=;
 b=ZUdt6RlA/J1LNWbFLP2p7GX7KZVf9nO/hP1FcF6gpjD4rZXcif6Cse0w6xkjM4EpHmH2j/monPEvSWX6peY42ZQas+773uJ05aO2yrKk0lV0w4oWYQh6eKJ5KNEiVT3Ee6v1/04AnbDgDDlovKV+aptUmc5KsgZ79iAzErR0XFhgTjSfp5hx+XmY61QZWvagrSlDQW763hDNF5dV8eVzidYuwsyXIXbV5bBJC1Z0GJKPfvq3GQSjgiAUvxQbtPBw7pKhAGhMe+JMj9pyGK4G1OncuV3mWWrj7x7jWy3/xhPxu/osx8ICbkFed2nY8lusFm2W5aaR3izMj4kxVeHtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOM7Qh9ZJsTmKuggsYT30/sOO8xBbP3ctEH7uj0ocao=;
 b=i44f/vsGC7bwutMnO2W4xyqmnEnQcK9Neh0DT+BJVTFzXZCa7kBoy2/aNYZ+h5246ZTHKFm5D6appZmVYBryKpbJFiEtT9h/WM2w/jFPXt+p+wU4g+ULrkdNfgFiyhlJy6yypZiHC9a0lApn9+gF/qXfJqOieDsjD6CcZvVTQq4=
Received: from BN6PR22CA0031.namprd22.prod.outlook.com (2603:10b6:404:37::17)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 19:10:03 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::22) by BN6PR22CA0031.outlook.office365.com
 (2603:10b6:404:37::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Mon, 1 Nov 2021 19:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 19:10:02 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 14:10:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/pm: Don't show pp_power_profile_mode for
 unsupported devices
Date: Mon, 1 Nov 2021 14:09:48 -0500
Message-ID: <20211101190948.4374-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61115520-9971-415d-ed3b-08d99d6b3538
X-MS-TrafficTypeDiagnostic: MN2PR12MB3263:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3263A4E9C07EE010D47184EDE28A9@MN2PR12MB3263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCLKN0hrdTGiPAyJGIb4P36sfbPWbwU2L+wbopHWwJIMXEx/tUCNuAF3Jt2n8G5x7dt4Y2emjZ8UbaSTYz8rPQPhdFD11tOTXnq4E1eNO/B/zkttyf5DfhhKwTT9bpSVLfBjsgaS6iGqIUboA8GncRFsWSiRIePhD6uN0mlGpl8ONMxfIkFPNQfLCL1c/hcBRJIz8LQNYlVDnSvlMAdP7qoRKBBIsDQHguwxb9VOuvojHkeWEZTDiyi6/erVTP/Eu1smJ7EnygpxjcL8N3bv9QLn9+HD9m7RCjGJCZRXs7MVpnJCL3SG0GUhK45dcSLJB0xTa2dNPbVas2qP2jvL2jYK2VhQ67BqemzV+9ivClE0lAvjLF9XQGdvYUjNoSBDHoaWp97bbOVzWO6Ihz9wLbL2VqF2+8xJAiFkrEXNj4WWIGdoojxMoG0c5XL9l5hI/Mx4ktQw28PobdXmZ4Ic9rwUBN3HO6cLoF6FLwoUNrDQ2bYYcj+bCHmJ3jy1cDwAHNIxkLTn67o+6ZQXCulW3z7AF0egS7sPySSC0z4VDwt2PP1EQse05GAJakwsMB5Y6Cha9wruC6UG/tjeCUq0/dg9oyiRYEbzuNI9He3mh60UUKny3yEBpCnWIeHNvSsRsOY3i4GaKrPvi1YcbeCjzbIO4GLhBbWwHyY7uXydJmqHvxc2OiudjAu4rrN57u1qsGnvPKLkOcCVQXKvqu6fQkR0bZCCLWb9indTuoxnbOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(86362001)(5660300002)(54906003)(6916009)(426003)(82310400003)(2616005)(8936002)(81166007)(44832011)(2906002)(356005)(336012)(1076003)(70586007)(316002)(4326008)(186003)(508600001)(8676002)(70206006)(26005)(47076005)(16526019)(7696005)(36860700001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:10:02.9190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61115520-9971-415d-ed3b-08d99d6b3538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This command corresponding to this attribute was deprecated in the PMFW
for YC so don't show a non-functional attribute.

Verify that the function has been implemented by the subsystem.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v1->v2:
 * Change smu_get_power_profile_mode to return -EOPNOTSUPP if not
   supported by underlying implementation
 * Check amdgpu_dpm_get_power_profile_mode to determine unsupported
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  4 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 49fe4155c374..41472ed99253 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2094,6 +2094,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
+		if (!adev->powerplay.pp_funcs->get_power_profile_mode ||
+		    amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b06c59dcc1b4..821ae6e78703 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2534,13 +2534,15 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	    !smu->ppt_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
+	if (!buf)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_power_profile_mode)
-		ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
+	ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2554,7 +2556,8 @@ static int smu_set_power_profile_mode(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
-- 
2.25.1


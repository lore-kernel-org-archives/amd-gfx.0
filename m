Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A5661184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5A5661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEE06EA7C;
	Tue, 21 Sep 2021 18:08:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45306EA81
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPzKuriazl2IjBctw7hkULiOLYgh3WKiL+nhutCQhJ7UyK09qI4MacniRIZ+XfYVaTyejTQsxQABdvQhzoI9WwkmM4wbWgbPR6NxmqrGXA/jBj/JiSxWEoeiQg3Ky4mktiqGl9U2m0U91oPUO5iba15Zx69VyGxzv7OyI6PjdxkjMKJkYLJYNfkAAkl6S+Og5uQu2asXbs37qmMWxsroO/W+9WAdbMhUA5ivubHINgHcikkSU4i2S8eBn7QVl/eeZf3XVz0mlN6LXgIpFdv9EdSOC7aOIKnbf0tTuE2vUs0wGrnI+5hLF3nJFUhm1BvT8JMap/2xLCgnto+QE54MtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bnDK46Xp8cp8RWIZSAPtcF86iKb+mzHO7Ji7rcor0Ew=;
 b=QADvejrOBJZtvK5HB8yNaz+0Id76uRfFz1Elen6igdYOK5qADnRQGHs5njWUmaKbRNta2hUXvpzmHN4ODAjMRMUCD97NfK1CIV3SAbRFY9QRfXUas54tAqMB2nKrnxrWnQOrbb/bE6Gwp7AIPNTh2G4t4ELbhAZNCCQJPUpOl2Hz5XzrvRjqkeZPLN+bAY/4iUeX1LVUUHQ8ADRWPm2BdG09DlLyzq9DLxRjD1/b3kxfoHkXADLb17uQgr2/n8TIsUWHsIxZYQMNNVkKmirahdp76H7q9CWyipSG1ZP5Bhd2xbKcqAz0vKikTz9IQF6esNs5jPH0SQ2jaBX4vzWeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnDK46Xp8cp8RWIZSAPtcF86iKb+mzHO7Ji7rcor0Ew=;
 b=prTBdAk/kRgVrnIfZMTWu1SnOzqU793LnwzocBkBr1usPCzRTGthmsvJJ9WrllZmHGNZVgrqTA/qzK5HQCZZiu+k0OJVZfpb2+xP5cXEK4Er9etlXpWCr0imM655sF3f+A6Fo4sNqXqV0ewMTPEF7ckM887NER7Zp45ms5ds+Sg=
Received: from DM3PR12CA0061.namprd12.prod.outlook.com (2603:10b6:0:56::29) by
 BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Tue, 21 Sep 2021 18:08:03 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::9a) by DM3PR12CA0061.outlook.office365.com
 (2603:10b6:0:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 46/66] drm/amdgpu/pm/amdgpu_smu: convert more IP version
 checking
Date: Tue, 21 Sep 2021 14:07:05 -0400
Message-ID: <20210921180725.1985552-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2459c6-58dd-44d0-6ebc-08d97d2ac0f2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4711EACDF25B9FB9D77A1C56F7A19@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ot4ZmVCLwINf3BS/okotkrWNt0eMTPuMMn/aw74peHF389QyKOHbMKU/NUZTc4F+tOa89PoC8/6nYTZDnbD6B/jVdS5Ox8i1JKvLNesPEh9kgAe4IR5nTUMtX7tFRF2vqdGOvn03EvY3F3IjpRWtiFiSJyq61hhvxTyCtj5H81W89i1a5+ZjNhVZwvbHZ+tF3NBpmRz6NGVLXQw3TD9mHtIdkwWukEukmUPuH04LtktxfUFOTsvOIRZplajhRShYKSWGqo6ot2yLI0S0ubjD1OfqUdzFkU6haTpPM4JRYN1wcsVkE0OvRGv3CvlKTffGn/7E/+7tZb2Eb/qKqK2Vut+aAj2ABRjdfhAHz2niYJ8usywgew1pmlrH9KHWgwYcqL6JDmuI5qfeLto+U1KbeKrSU6yAvgoJklRJVXbBW2QLf+W7O2XzdX6LRUz+jkPpMpzvntqF23Yus7vOvZKNmMZdo8GL2CZ6Z9S/y0rP6C2Jq3ew3Q23gWj55s98LjJCczNrt/j4UT9rQ1JRmMjHg08dUaz2J6hr9UMLluW9lfz4VnSxYN/KmVxv7c/ta1YYDyPsYC319AB0jTDqxexWDVuf72oB5n/MIpJg2Zi5fATnWQaQiNesr/13zoplzcTNeh8uUBEDRjcBDevDxhcfMCbOFSUTvE/DgfrqylXGu7pDI1/iA48vPaLPbl4ZbF/wTqbOaMBQn5H95F3dNLjj9f0d1n1IgoS5QKr7qMhtklc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(426003)(508600001)(316002)(336012)(36860700001)(26005)(186003)(83380400001)(356005)(70206006)(2906002)(4326008)(8936002)(5660300002)(36756003)(8676002)(2616005)(47076005)(86362001)(7696005)(16526019)(70586007)(6916009)(82310400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:02.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2459c6-58dd-44d0-6ebc-08d97d2ac0f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 41 ++++++++++-------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5f372d353d9d..150cac4ea75c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -455,8 +455,7 @@ static int smu_get_power_num_states(void *handle,
 
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
-	if ((adev->asic_type >= CHIP_ARCTURUS) ||
-	    (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0)))
+	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0))
 		return true;
 
 	return false;
@@ -600,23 +599,19 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 8):
 		cyan_skillfish_set_ppt_funcs(smu);
 		break;
-	default:
-		switch (adev->asic_type) {
-		case CHIP_ARCTURUS:
-			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-			arcturus_set_ppt_funcs(smu);
-			/* OD is not supported on Arcturus */
-			smu->od_enabled =false;
-			break;
-		case CHIP_ALDEBARAN:
-			aldebaran_set_ppt_funcs(smu);
-			/* Enable pp_od_clk_voltage node */
-			smu->od_enabled = true;
-			break;
-		default:
-			return -EINVAL;
-		}
+	case IP_VERSION(11, 0, 2):
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		arcturus_set_ppt_funcs(smu);
+		/* OD is not supported on Arcturus */
+		smu->od_enabled =false;
+		break;
+	case IP_VERSION(13, 0, 2):
+		aldebaran_set_ppt_funcs(smu);
+		/* Enable pp_od_clk_voltage node */
+		smu->od_enabled = true;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
@@ -2288,11 +2283,11 @@ int smu_get_power_limit(void *handle,
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
-			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
+			if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(13, 0, 2)) ||
+			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
+			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
+			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
+			    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
 				ret = smu_get_asic_power_limits(smu,
 								&smu->current_power_limit,
 								NULL,
-- 
2.31.1


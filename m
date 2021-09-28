Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA8C6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FA8C6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32016E8D7;
	Tue, 28 Sep 2021 16:45:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56F6E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpyiNCjUa1PfylcbSaVMYZH1x2Km9NHfPJzQktx1ZzajiwgL2IryQmuQs0ITcCvF58ZJh2s3lMEV3TmnVdnJdl3/OFFiLs0CMl2tm7t+bdbJoi0mIff2ukB0B4EA3fsg8e8vetbbE/dUsITqPvat+bL3RdwaKk0G0yithGA+g1Vd+mGZfN/AD+NNY/xvtk2nOBE6esQNra6uLIOZRR/vzDjiXkHwhZJ44XkwY179VvrvxvOV4Nn+prAjCl2PTUwyCmqajkMA644xx6kGKOEMNMqtorbRpAsUzsvVFCAEKxmyUoPfJvbcE5pyCNigkt6On7k/uu5xWTI/rU+WyZZLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JyGmni7Uml2Rb7304ODsXQm/mnzrW2I6RLWbUQIQWx0=;
 b=mJzEPqhzZlgCgI6mt1//1DnV0ciBBW/2ewl9kFh318vG+HRVVdzoeFP4pNuFOyVZ6K/WRwZ7Q7kO1N9aNtr95Dy98gB95scnujc5EQHZvbsHq75B8Wp0Vg0oA6fe0FnlcDeFaaEsrZo0CZuQtyQQ2GvhAnQlcJJw6ylT7tEpZNOor3/CV3Fe3VFeQCTL1//7Ve7wFd5VblnNfsgS1Qd2hMQ4x2bshQ8BOvA1+omkjAqRvMSdoQ99U4rlLjpevG6Z35hZlyLdlmEDOJHsuAPATg1N8RuzUc+EE1nznhnjBhzBYS1vnAhl4CEQtDSzLH1Kb5uC4filXxyJVQjuFrDrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyGmni7Uml2Rb7304ODsXQm/mnzrW2I6RLWbUQIQWx0=;
 b=NYH1lD1chkv/GUDYq89/1r/BFmyx55Zm8ES8V4tfgRJaBBCeI5PGV38o4XNuqCvPVTknNVS+KIqBeaj3qb6FMZ+T63mOr6wBXcZz/an1J2sm5AQbq/IR9MzUiytSQLT2927SKzPosGeMlKdMfbzsFzTVK70KK7atTR0JuBLF52o=
Received: from DM5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:3:101::33)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:45:10 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::c1) by DM5PR22CA0023.outlook.office365.com
 (2603:10b6:3:101::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 35/64] drm/amdgpu: default to true in
 amdgpu_device_asic_has_dc_support
Date: Tue, 28 Sep 2021 12:42:08 -0400
Message-ID: <20210928164237.833132-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ecdd7de-94b2-4d23-0ef4-08d9829f55cf
X-MS-TrafficTypeDiagnostic: MW3PR12MB4428:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44281F9BF09E9D3543FCC8DDF7A89@MW3PR12MB4428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1sgc7E/XfqCOWfISmc5Bo8H0DFHkJEYnhnW5B87e+T6l4aYYRXGUfEo4/cB1VHYPfEUGPXi6YUiDbe7flD70ZofrMPaRO+X0hTJntUhO7UI2GPQu0kIkDcPQUehhMXuk7d7KOCU27syxDx/1TTSZbNfDcIDq9VtQil2lFQq6tvKPrq1HeA+GjA5AURPhJJSr6qnNkwZs72GZDuALKf/VXNu4ijl8vAQ3aMNEQnn7xeA4Jp5qSA/Ompo8c5GZdkwlPZxorDNHbEGPmlw7wm030y0QSRCv7W8UibfmcBY3cZ/S8C+u7MvQyOylVnK32qH3ZqkwxZWm4GwJ3EBCcOHaxPiFkpScMkbPROwLS4HkSXmTfj21JdEQ+AT/7FFaRornOEKFi897aXy04mqUJHVzjd88C3n4EX9M3FAuNHZG/rdJKlVdAzCUbpes5yeQhAlSHN1NXPRxLEi+Cvn6+fP3iQvKHOMcDUyDE1zCOTtTslGAvh7N9HOjF/lQqZAoOJJhrvP7G3E7k5pvFeRuY071OVnDt+fNSP72ZcW9BlcYUHjlWkNWA61pXP4Nf7HFoAIcFOqOgyLXd3dJKEigGM4+RZqSyaAlR8uV30bGYP1t4yiq1f7yvtQG9wZ0S0rMNDLwW+T5e5ymCWK4HJDQGyvHpASTL/3jqbnNN8S0Oz5F+BSXBxPvR6wUbNtw6XH0AJedw5Pw51/Yequph/AClPGvzhnDiJloVMEeqmmHj49zUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(54906003)(508600001)(83380400001)(4326008)(6916009)(26005)(2906002)(16526019)(7696005)(2616005)(86362001)(8936002)(186003)(70586007)(8676002)(1076003)(36860700001)(4744005)(82310400003)(5660300002)(356005)(316002)(336012)(81166007)(47076005)(66574015)(36756003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:09.9890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecdd7de-94b2-4d23-0ef4-08d9829f55cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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

We are not going to support any new chips with the old
non-DC code so make it the default.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a4da9ea9d07a..5e53b54bbeff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3213,13 +3213,15 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_VANGOGH:
 	case CHIP_YELLOW_CARP:
 #endif
+	default:
 		return amdgpu_dc != 0;
-#endif
+#else
 	default:
 		if (amdgpu_dc > 0)
 			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
 					 "but isn't supported by ASIC, ignoring\n");
 		return false;
+#endif
 	}
 }
 
-- 
2.31.1


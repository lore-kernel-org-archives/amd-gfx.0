Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA61C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0E361262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C0E361262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0566E8DC;
	Tue, 28 Sep 2021 16:45:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9BA6E8DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiHNUJH0g13Z+mMyq9vAMK9qhhZgnnM2m/oWisMLqqHxtorlhofmziSftAMNl328eK/DWCFOCvEBqV7hgl8EMjUe6FSwoVRl/fgW6pxbLr4ay4A7pySu0LXV7VT4YsOVUfXKCZOHFH3k7dxnCSDAvhFPRpPJsoCKNSeUYMFxPB2QcasHHq53Ffy7ISvEbXGKv6lH6mxVf9RkwLVSdSDvD4sLFK6I2vZCK91szX5O/FG1jv5ovf4APNXn4mJxm8Lp+J2Nvrm9OQrgNBo5b6pqLiC/qcJDtc26MIQtQIr8svyNd1g/wmuv2waicimRn/qXgKosG/pAsz2bgtF9aY9tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LKvycMFsiwt96ZzMvi2qeowfMJjrW2Q0XIN7t8PNqiU=;
 b=Hw9RarWftgMEjLEM8JooN6irryTXNcMnf3r5dQquvF+G+F+s6Aze3pPxfAPcHXG2vCAVTqJy/dVhHDSHCb3XnNcNiT2LS4r6+TbBYfmvwJ7GJLjC+4ebYEPgduvNp8xSNf6pZysFuoQr+AQB7XvB2lgvyOLZqz8RgCqbyrE4IUOqGIWMFRc4QOHaIcQXjialOIXYH9PERVgQRKlGMZ0N7p5HsaoVJZ/+J4j4Klyv4ddR+tGshIs9lJcaIIn2t8xAOq5Vz2okJXJsaYKe5PflzbDv3GP1Ht89aD+OUrnv4hOox8ASvD1+5JacRONvD2LgGlsS05Eiitg4ELVRVj48gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKvycMFsiwt96ZzMvi2qeowfMJjrW2Q0XIN7t8PNqiU=;
 b=bWEX9rMSMaHgOlJ7W2zSwdKw3WqZ8o329UJTlh+JN7IoM/9tshROJLaUbGZGfa94UyfkADnyFvwXd4M38NgaGAAtohBFX9AocpFLviMeHm7qzZoj4QBAJpW2fa8anxqNsNCKu6ng5PjDNno/GBXZe6u7SyEL01omwubHI71tZQI=
Received: from DM5PR07CA0137.namprd07.prod.outlook.com (2603:10b6:3:13e::27)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 16:45:39 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::34) by DM5PR07CA0137.outlook.office365.com
 (2603:10b6:3:13e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 44/64] drm/amdgpu/pm/smu_v13.0: convert IP version checking
Date: Tue, 28 Sep 2021 12:42:17 -0400
Message-ID: <20210928164237.833132-45-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3106d3a6-8294-4757-7c05-08d9829f66f4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41387B2C3BCE2FF5D808F7C8F7A89@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9D/o/rW4c0eU0lV2xdrZO8S0+AftTSzzUbGIz+yU+GFGrXXCjy6Ptmx9+07sTmdXXWbu7F4pySbBM13kahUdReZXUMITGHDbPl6hW7FDcVPRkYIQv72GMD8m4thIHkDWbznKoXba8k+zHntK8iRxUkQh3mitP+1LN2N1H5P9XxAaC4TC7rHrIjTEfNyMCYCdugNRj5+ZnQQv7KK2UQ3WIeebAAwph4QPPo+oGZ83UuPc/WoAaWMkHnkZU8RnZu9aUkWY3n6CyVEAPq1nt/yl53Mb84Z+GTnCiQubfRD0Hn5WMuKDwWT0jPB/AARqWbvPDNRdnnuwP9GsLgUFUh4L0fUCojjqa6Ca9g6F9dF4wiY7KqDfSN3hHV2m8iHSNAdFExfoqpv6ym5/nJkb6MeFPnIUHbA4GJi4R2E1yFMmueIIB3AXKHvoUEe9twuTTmByF6gBTkp0f2Ga/tnyOI72Hz5UDNdoJYc6u/ogd4SLpx/0e935Xxeijd6rEmtrCAAjGRShKZYVrhm9k+uVCDJ3sXQGCBrz6nwMnPv7e1p0YSHOaHBrQeDIEWi0S5c+lNPB9e/D+CIqX3Re6i06Pu/sTkOIDCYjgr4h6JJyY4y7vYM3wSPaUa6q8tLTUaEcCUuCsEk9KjahCJOfb1jjYw04zuTvNxzbUuIryTpf/dh6AxEKM+BZEDyYjm0QsgGoZmDkX9LyUlvRVyeuLWomWfQ5YbpFZNGRZr5kv6h6JVQJK/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(186003)(16526019)(70586007)(70206006)(6666004)(54906003)(36756003)(26005)(426003)(508600001)(2616005)(4326008)(86362001)(8676002)(47076005)(8936002)(2906002)(36860700001)(7696005)(1076003)(83380400001)(5660300002)(82310400003)(81166007)(336012)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:38.7585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3106d3a6-8294-4757-7c05-08d9829f66f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a0e50f23b1dd..08f3cc809fc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -89,12 +89,13 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		chip_name = "aldebaran";
 		break;
 	default:
-		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		dev_err(adev->dev, "Unsupported IP version 0x%x\n",
+			adev->ip_versions[MP1_HWIP]);
 		return -EINVAL;
 	}
 
@@ -210,15 +211,17 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 
-	switch (smu->adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (smu->adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	default:
-		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
+		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
+			smu->adev->ip_versions[MP1_HWIP]);
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -740,8 +743,9 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.31.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A825C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0A710E1D2;
	Wed, 25 May 2022 02:09:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F127610E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqeHUYpelOqLXLmIXuDiA1RCszLVQoQYgsNv6nRdvbz5gHfFCYiL6Ipr2uuw8+CC/6BvcbvyEa7FM+P7krrE5z8+kQG3dqLArYLrLovwZxOu+HQt5Apvbgq1ONTTUjX2Box3CVtMP6P1RiAQGuO8KRK4QuJliBFIOqcijN8UwhKy2qnKburRU1XCMhkKc/UTtcpZQjsXcuqdRzDP8rQcUUIuT2l9uO551/iFzVtVZ+uV5TjjjsptiOmYO1eQDCL2yhuxqfu5gyGFntOZT6MudpPMvIJ8g8YRsTAse2ELVP8I3TeDw4Cy6QipdyRHABLTY/KuomXYJoG5ef+9VSV7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I29fn1DuIjlnPiopDu0w332rWVC8ovNGbs5zqDk53uw=;
 b=c7dxrfaF6YU2E6OEYpAUMY605pxUydpCDl3H5+n9H1vtpY2MhgU4kQIElW6Yo+kkl117Y2ai8qOGtShnkXv7SZnn221pfVkB4ywzxGFUjWeBapeZ0OrHXBO5dtZiGJHxUQTY3DwyOLyVS5rPthvAllJJKlueqLVtX2QYEQ8gj/vA7AGY1usGC+E+HSnSYrrZOuRNEIyh+pt6auYvMtRYrUDm/J7uUHZihPg7XWO2VbIg9dxQW3rzAn367HdAIO9Eic7Wp+IIo8WR6KPUhukm37FEdllowlEwnxRrFFa8MfJBGSnPB6No8cyPa8hvlBOgyUAJhzReSzOI674WqfmVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I29fn1DuIjlnPiopDu0w332rWVC8ovNGbs5zqDk53uw=;
 b=IS2wcNUyD9VW/C5cyiM1vFJMxqq7zkcF2dyeUtHF0YYyDNs+LRTZhrVdFeXX51is8p+lOHIBySLzIlEr9KY2FibCLD0lBWWsYY0Zn4/TsGH07y2X07LYBrzqnOJgB8u62BrLLcasRIxCgg3E3UrR4+jJkRpzSGSdWrW+dO3ff9w=
Received: from DM6PR17CA0001.namprd17.prod.outlook.com (2603:10b6:5:1b3::14)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 02:09:44 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::46) by DM6PR17CA0001.outlook.office365.com
 (2603:10b6:5:1b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Wed, 25 May 2022 02:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: convert
 sienna_cichlid_get_default_config_table_settings() to IP version
Date: Tue, 24 May 2022 22:09:25 -0400
Message-ID: <20220525020926.1951685-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525020926.1951685-1-alexander.deucher@amd.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4b9ce5-ffb5-4800-03e9-08da3df3a2bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0042:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00424B9AEBD28DBC6004600FF7D69@DM5PR1201MB0042.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ3CPV1Yzz3Yqb3c+2UVD87tK/zb5Tn6XTbxTeSJ8WmHzOHx9buXms3UoXgZur21CEwIxXPKm8b55yz4QHVkDs1FUqnmxWgy9dLPGK6CKU8d6VlG9ZjRDvBnvjbAjUd3Cobqbk/9kbLJu6JU0R5vnS4I2SWCVhKxGjLubSBhgoftVosJmzCiMahea29C+qrUD6z15L+wINo6wBRIi/pN4ETfW/3pX1e4YuPEgBsd+00eRZGnb5bnMiFGI9rTN0n/7y7x2flXK6NzTCMx/PZizCQSAuyqFF2IQu+WAw1GHVZMqAOARMoufEfkw/tKAtsS28pIoGOXm92xlS0QbUrY2mwHfCLgXugm+fLv0oiPneAC3g9Yjh9r3OCQ7FHeIEQdl8FTsb02iCv68nbFWqbsLcWd7xNPW/x2qrmLnIyJhwmfr7Q0yyIxYmKvX2btSUISmMvJ9VwAydpzSieLc9/8RQf9wF4rPtkMxq42tUKZIxn6WNiLDHEzmlj7cCf6AHLrlqdCuAygnfMoDCorJ5THzZbGBKp5XgCS2bTQoZGMT2TTODj50z7rz1KhBPg7FDjMEq87S/AqhHc7wzyxc3iV+HELbTDzZmCMw3RLXZKFPBx2FqSX/0st5Dl9K6hp1voql6I1TQLTFjMLG1zj8ajgTtqrea2ScrH32wPmk7PNRxD5z/LduYWb99XoP5telV61EU8KF8uh8pZ0Qz5TNaRJVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(2906002)(508600001)(86362001)(70586007)(70206006)(6916009)(5660300002)(4744005)(36756003)(8936002)(26005)(2616005)(8676002)(4326008)(7696005)(81166007)(426003)(336012)(40460700003)(16526019)(82310400005)(83380400001)(186003)(47076005)(6666004)(1076003)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:44.1987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4b9ce5-ffb5-4800-03e9-08da3df3a2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP version rather than asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 871435cca3c1..1c5ce9c5cba9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4192,7 +4192,7 @@ static int sienna_cichlid_get_default_config_table_settings(struct smu_context *
 	table->gfx_activity_average_tau = 10;
 	table->mem_activity_average_tau = 10;
 	table->socket_power_average_tau = 100;
-	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7))
 		table->apu_socket_power_average_tau = 100;
 
 	return 0;
-- 
2.35.3


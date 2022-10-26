Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE32C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 17:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE2910E3E6;
	Wed, 26 Oct 2022 17:35:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6183C10E3E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 17:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewJZM9wNJlrWXiaQ1niVXutb5YPsdZd/gEM55GWAzYH+F/nDpcfPoOfAN955PYkdkVYYDR56DASdkJxXIuq7kNxWSajc4bzzt38Q1MEX2TltdFO1xoku2jdpgpVXFsPj8MUXrkHRTBEIQ8Df+K7XoYxJ7ay+yyWukso7psG+xoWfoYYw35jnNMJYPANVFz26cLm1xJKL2o1mpG65o51M9V0gXEEKPZ75kQsMGeIttxbMZsGtjfoLmR4LZ+re2bEa/xz4sknJStW8Uyp+FLbge1miU0NCUkl1cWL6vm9vdFQCXABiI4ezFqMRX3Z4EsOIBgZsAtXXKTgmhqErgO5g/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLyvfYrv68577Mndv00V2ucTQt67bkIYOluSkbeu3/0=;
 b=NQ7kwtf1MfSA4NaFNer+1xeIhGBGKAYyOEcFt+g9hQyRWwpUlZBf/BJtYueIDB9gyf5yVQ6bpBPDePLFRK0wy30A7K5WBUvnZA1hWGkOEvd4mlKQyLYhjuF5mSSw5cjDmYHxqh2DW1DTG4ufjeZJR6JM2Bw/Z+SD5yYc+JdC7wLw0UilpwBOi7uRDiymIW6Z2AbvP8d3fH9w6vIOJwU5ePK9NuBd3M1soh/CNO0z7JrOZjrPoTAyugJaEDWbEZTTLaZTHrpJ2hrf2NXFVqxMAmiWLdV3qosCTxIbLA1tZOoYQHyAzrR1HSpTGEkuAmZgrDCQ/0My3ysHrwfkQ6BXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLyvfYrv68577Mndv00V2ucTQt67bkIYOluSkbeu3/0=;
 b=MdaNSLn6NFDv1v9AxMI90YSo0YHtW2DPig7NTXcM2ryAbSuVzWvYhsJrf2Kpz+EcoqCIwuGostk/b3UJ+meG0DwOR2ZK/i0eYNvVHBbDcJzJhOK8P+nKlG6Ipz1gLJBVOyii3CgsWko/ErxUzjCbaXrtf2KKKn92CYUH4Q6DvQk=
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 17:35:11 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::fd) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 17:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 17:35:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 12:35:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: x86: s2idle: Revmoe unused variable hid
Date: Wed, 26 Oct 2022 11:33:40 -0600
Message-ID: <20221026173340.3777280-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb515ef-75a0-4125-6670-08dab7786ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0986KG+VfNm68vjeVnLETd591Vp5nZYfhZHVUjX4keOuv241aI53+PS1VPQNZyzTF0+KwaO5VF+SVKAL/cm89fSGZrTXCTu6H77OHLejD3jhTJOQqzeir82t9wAIe1+hJJuUXvz+nsQnlDdX4ytj+wqH298eBJm/fXCaSl3Hpwm1BndmzELBHmEWcqmZBzummQtwDEsAOHYKfqldpGr2tVClX36d6O9R3IMDsAnYFoyQUwsCi8z7UH3YFn9uqvTTXY8wdqQRbzhaiR2dnh0Q3X1t78Vldlrh/S1+B4PMuupO7B2RsBOWcz4mjTsXxoSzaO0GwUG3Z8nJLGxNWkTyVOTUZvU8unpiKe4teF7W74QT+ESZfaUgRIg0x6T+40Au8UJ9lGrwSo5MxQtfiuEylUmcTDz4wLeX+Aiusobh6ceK5SfocNFoMU0NlKt1ozwtSYdRIi9EafOlhwuC/60+SCXWjSlDo/KV0cB1vXS/7n3c8iKnvunDNTCQUSfYWSX8uo8WoWbtUc1v4BNePpWyCVGOvRF0h8b0G0YtUhvcn/Opw5RB/YRET/1fY0JzdiXgkkt6dzr6mmoioJDzl2AcqFMKBqcn50LQcPDmPp52A9ok0b6Llk2TXKKs+n+fU2l6BLriy1EZNzf+USAg6cCPCxtgYN7PYltx0iwULQkR0M355FsfEjR22/nPenDwPTNOtWVEsjLLy6axYeMfj2YPqvoYGOaQg6FPYQjHpN6ijnZi9qH5g2A7u+rGQjKg2vNe5UOknSRF0adKKVRjjhM2tgaF0Gn0nvQRAFKfrRouZRQY1Yhi4GwSyT058JV8g+R0GWQRnWP9H8ekwnlx0CzlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(4744005)(86362001)(44832011)(6636002)(70586007)(110136005)(2906002)(36756003)(8676002)(70206006)(41300700001)(5660300002)(316002)(54906003)(8936002)(4326008)(26005)(40460700003)(7696005)(36860700001)(426003)(1076003)(16526019)(186003)(47076005)(2616005)(40480700001)(336012)(82740400003)(478600001)(45080400002)(356005)(6666004)(81166007)(83380400001)(82310400005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 17:35:11.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb515ef-75a0-4125-6670-08dab7786ef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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
Cc: Alex Hung <alex.hung@amd.com>, Rodrigo.Siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This unused variable can cause build failures with allmodconfig, and
therefore it should be removed.

Note: this does not applied to mainline (included in 100a57379380) but
to amd-staging-drm-next only.

Fixes: 6648f8587530 ("ACPI: x86: s2idle: Move _HID handling for AMD systems into structures")
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index bfe611dc08cc..3d0cf0ace4a9 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -475,7 +475,6 @@ static int lps0_device_attach(struct acpi_device *adev,
 						    ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
 						    &lps0_dsm_guid_microsoft);
 	if (acpi_s2idle_vendor_amd()) {
-		const char *hid = acpi_device_hid(adev);
 		static const struct acpi_device_id *dev_id;
 		const struct amd_lps0_hid_device_data *data;
 
-- 
2.38.1


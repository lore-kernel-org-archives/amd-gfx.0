Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F4C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8FA10E8C4;
	Thu, 11 Jan 2024 09:44:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B994010E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 09:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP4Q6M1vIChlYHEMP2rGZCbRzHJbdI2hJqETh352AoartH0fZApd9U/ZD/pu9o+BYqQC8GJINi3Oj03D6+jq2rsLEFqqE5FW6JfDZpmbDGg7zBsE0xNaooKOw0hnVXdDmJ78dkSSN2gZURrIv6xQfXy43ZFT0qqfwJbTwefnfB+jvO0ro+vPI2R+RPwK1LYOH4mzJGazlRZ2yk/EQuH46OGH7XFfAFUFP5cwFfjSOICOopmKRaaQttQWhFoQah2GicJ0jNkFnjTzMCstMjDilVwk0hZcTX4L9yPGGPgG4kbsKHZWYCHEoc2aLG5UDT8GznMKOyxCyTea7Y5sGcR3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzO+KHZfciK0P4Sblun8d38hU6f0ROYGvCYGtXpDhhM=;
 b=RnZ79EZ32jsN3+4ZXmr7CtAGcFv1ccJHJKN1evZIFld+tGvq9US8o//M/uNcQyViALrp8gbU8kh5XunmP6gjIzkLCCwVJSOmI88U3a/GFVKBXVMRoeudcq7WKP1ICUDGNnGGyKuZNkbgkmyIW9TUFaPSWyWGcTZNor9iZNwt/1+Bh9jeTV8Pl9aVxngVIW4PoadpThEhydV8SAfE4YE0RZuUj6BI7hdCIj1BGeUnHoEwFDCTrKu18TFhZ2Lzzvq03TEB5nFSerXLxD8pC3DrdGFY6Ret6PCdf65xBMtvTKGxAnHzhnUHBa2OYBtK/BGwMdrCX/V2dM7Zh6hhcfAj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzO+KHZfciK0P4Sblun8d38hU6f0ROYGvCYGtXpDhhM=;
 b=FF09Y7x/8014oNDRiokRE69NyGSzQg/JZGj/wU1qSRfjFssGA8nsG8MX91Ygf/6+iAVhGomVNVxqF2SOA6NDkvp3Ul8WnJ+uh3fvXV63X/R7Ub8HVIO3nlxT/tbcRLJxnQGscCyuTOlr5LNqZtLx/tY+V0LBXvcxJ1wt3nyjdXE=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 09:44:50 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::d6) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 09:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 09:44:50 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 03:44:49 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix the shift-out-of-bounds warning
Date: Thu, 11 Jan 2024 17:44:26 +0800
Message-ID: <20240111094426.728784-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: f046a5f4-1245-46c5-6437-08dc1289f4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3VDZ/o20w36KQ98mCmk6T33mH5luNc77jGF/c4griqFLsyiaF8FMGLNXxSKQvGjUw2yyxs53AfQRtnL8kExCnCXd421Mrj9fnRknbkE+RY1REIeDA7/P10H/nTO1XLQuRkjI893RNbedRIoakG0Wy0Ugcxhbrwgmv+Y6aFrfgOrUrUFb0BK6MTLnatIzNWjgES+Pxpr4sUv79a9ICZqvjybKQspbNbr6qEZWoOniqzpeCIMT568n7+/8vso0ceVikhmXt6HxYLguJDkqtjqB97CAxwOok4X0pm1FShTQDPz3FWXb+MvBgbzH5n95eV0AkT5qnO0SoWIG8aNJs8XFReEOnN4NAGzPrdZy7zYQ8KzMRYCuob4JpjxHkQYlFqDai0G2wwGwSKicnbRdzyZ5Qkd+XYsqI27TpiHXmKLFzDJzSSWMFqPJn3Uy5S9GsCG9hVfKclfLfGGBV7Ll/bbUr68JpyHEZ8HScyJPyWhK3sW43HjZvwE1zafJfax1afvjjCe7/9AvgVmwufu7DCHbu9kQozJdvD5lw7PkgsgziERpmJkx7T7zZ5EI9iJc0mWuSfLDP93yABQO3+kI54jhR2jzKYEcoylaKvlUfDa8G31K303GXevnsoo+UsLKf+HCv8flT/2vTysq5S3nn7CWa0YfRqALIlSVU98effCcFqvnvLmB9ODlJr9gogGhrUx+GaXsaVwjoL5w1A5bHlO3xRwrmsmfrSd+lF/dUF3M2c1lfLIi4e7x5722Yfj+Op6cgac8BNCJe+Z0tFAV6SY4uR5Gb4KbXMis3Qbiz8bU1Nt3Xb+Of5zxmVkPcYTiq2K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2906002)(4744005)(36860700001)(6666004)(5660300002)(478600001)(81166007)(4326008)(356005)(41300700001)(70586007)(8936002)(70206006)(316002)(6636002)(36756003)(110136005)(47076005)(8676002)(2616005)(86362001)(7696005)(1076003)(426003)(336012)(83380400001)(26005)(16526019)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 09:44:50.7414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f046a5f4-1245-46c5-6437-08dc1289f4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is shift-out-of-bounds warning following if ecode=0.
"shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2aa88afe305b..90b04c0401fc 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1004,7 +1004,7 @@ enum kfd_dbg_trap_exception_code {
 };
 
 /* Mask generated by ecode in kfd_dbg_trap_exception_code */
-#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
+#define KFD_EC_MASK(ecode)	((ecode) ? 1ULL << (ecode - 1) : 0ULL)
 
 /* Masks for exception code type checks below */
 #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
-- 
2.34.1


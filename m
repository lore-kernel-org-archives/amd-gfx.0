Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5922BC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 22:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E1510E1D4;
	Thu, 16 Mar 2023 22:40:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2FB10E1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 22:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi18O0jxlpY3QbswUV3ZVt9dNeSg/ivL69SyoNixp5C8dy2NvGIcbch5CmwMLj8KVgqVVy8OI16v8L6uGIYOm98t3b2iyqegoL9+NUZn++mAwGwEqLLcvG7PoewFGw8qizOZ2S0cDTlS54qZgTt5fs161LrhhuGrt6xNLGpoPvq3jVWZpV2Fmfzi0PINy3PjUEzZXBDXpKTsUoPxv6aIoPv9TjqOD2oypzIEpeQNwo81f68wD3s1IZb2mUzGOrprt23C1TaLyE6gkUHuso+q3E2LNmGL+v7cwWJsUxqKKP5EC/2fcnCGjsM2P4qiHNubch4tr5iFk0mfAlfnFCHYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BodiD4RSHGvVb2mVGEJ5L9BOWaXET3V+xN3y8/UIz1g=;
 b=ZQXx9OzDmiqUpyGlIxuRixR8tE5jSOEPGP7FpvXfDH7YPiPF/zFN1LC03gcnuzZx+vd7nM+EipoY3lQQuPZODbYncPt+f5D/1T4IyotHvyLKH9bsMfSmzoXM/tPdU5gHLJ+dhoI87rzedCX4wxY2NCuKKZ4voPS7x3X9FvltgRC6RD1nafK+YMTRoXYrWDAppR19SwiNlIKQYjgHq3IuMVJ/c4NFnH30YqGKQntqG5QGcru0Itt2miQbPS2B8Hp0fS66KNRd4SQJGK0NVuxG6FZJCzCYTJP0GXU9MvOYKS9Y9mpTl2PpOtpBlE2jVMzlol3EPH0g/9LIiQaFbsoB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BodiD4RSHGvVb2mVGEJ5L9BOWaXET3V+xN3y8/UIz1g=;
 b=4J7RbxK1Qm6iLvuc1jMTtQ1xoa9Wafmq0igyObYMyqJCA1MFYloclrhU14U0+CKjiD0FoeFgGSOmfc8wLQeX91ULubE2PLEU03ohX6bNVmE8WncSE7QSdNfbjF4wgNt3lCjFrrErMXdGqlu5hI4tpMYcjyUDW5UPcUe4Qw+g3AI=
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 22:40:34 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::1) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33 via Frontend
 Transport; Thu, 16 Mar 2023 22:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 16 Mar 2023 22:40:34 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 17:40:33 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] tests/amdgpu: Add all 9 optios to the help output
Date: Thu, 16 Mar 2023 18:40:21 -0400
Message-ID: <20230316224021.67963-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb32359-1dc2-4a76-63f6-08db266f74e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpAJSCeHWbSW9EWUmD0HjBQBmkOuxSfue9y6ebyhcaN3JVTLTMB0QlxwykehGf9pAFY+63wPz3CllCscF62I2MTEo1bDKmqhPyYjWOCnHKY2rrTo1JQ4CeLQob+MvXWzR7yusA1ZCkevGfIw3hrtCXhrORSXt7WPrBvOaSrRP+M83wZBGu2+FU9vgJYgJtkZER3ylBXrqQmWFteanryAEt2UcN6c8FDjVDJGe0O5WAJ4BxUZHJJWZ33jDZWZieJ4Pzi6K0DIJuBfpT9oOeIBtj9o9WfzKwaId1UIkOEvGjpbXseE6gMQlxU7Uv6Xi5QkOVfZUFSrnEjLtCftv8FIrYr5dmT/Cf/vvbv4PR/lS1jHinqHrfBUDYYCe16VqP7CEJXMNoEDSLqCecax58NfwrJUfn2pfDR0RFDVbMYXbopQhWR04U2OMXVBRgbTRuvvECwFX4OgbINC+ZLtOunsKpWeLb2WIpXCfFuTcR1W5f2DFzVuDnsPKkRRghhOVEeTwlIXnOdQC04W3vMHOjAnKJhjLbNcbM6ZzK7EK491INujyyo9rZ+jR6Dbgw3qYLTfXjHkRDLabkc//yh4sz+x03JDDdaknZVvjMk7lx5MxQSqc1xAaZRy67B8/NTVgNsz/qKW3x5YaIjnhoD5/7LQmv1j4ci9aL/7LJIzvDpBOzxIjYr/jZVnGz5jcqXwxi46UnRUmMFPOwSLZEBjoI8vVzvYmHZckU6es4IxEGWwYyM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(40460700003)(40480700001)(36756003)(7696005)(316002)(8676002)(70206006)(6916009)(54906003)(478600001)(4326008)(70586007)(186003)(1076003)(2616005)(16526019)(83380400001)(426003)(47076005)(26005)(336012)(6666004)(356005)(8936002)(5660300002)(41300700001)(36860700001)(82740400003)(81166007)(2906002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 22:40:34.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb32359-1dc2-4a76-63f6-08db266f74e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add -s and -t to the help output, as well as sort
the options output alphabetically.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 tests/amdgpu/amdgpu_test.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

MR 291 has been updated.

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
index b8fd638c5f4e97..59ca49bdef5f20 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -298,14 +298,16 @@ static void display_test_suites(void)
 static const char usage[] =
 	"Usage: %s [-hlpr] [-s <suite id>] [-t <test id>] [-f] "
 	"[-b <pci_bus_id>] [-d <pci_device_id>]\n"
-	"where:\n"
-	"       l - Display all suites and their tests\n"
-	"       r - Run the tests on render node\n"
-	"       b - Specify device's PCI bus id to run tests\n"
-	"       d - Specify device's PCI device id to run tests (optional)\n"
-	"       p - Display information of AMDGPU devices in system\n"
-	"       f - Force executing inactive suite or test\n"
-	"       h - Display this help\n";
+	"Where,\n"
+	"  -b      Specify device's PCI bus id to run tests\n"
+	"  -d      Specify device's PCI device id to run tests (optional)\n"
+	"  -f      Force executing inactive suite or test\n"
+	"  -h      Display this help\n"
+	"  -l      Display all test suites and their tests\n"
+	"  -p      Display information of AMDGPU devices in system\n"
+	"  -r      Run the tests on render node\n"
+	"  -s <s>  Enable only test suite <s>\n"
+	"  -t <t>  Enable only test <t> of test suite <s>\n";
 /** Specified options strings for getopt */
 static const char options[]   = "hlrps:t:b:d:f";
 
-- 
2.40.0


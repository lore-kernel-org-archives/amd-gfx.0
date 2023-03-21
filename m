Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF593C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 13:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7204E10E0B7;
	Tue, 21 Mar 2023 13:52:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302C610E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 13:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU2io4G/apFERzaqSJ2ItILsFjgZi55jvw3a0MI29oeWyDGKJ0ZJS+axS7YSmX/tVy/kEyHJB2IC4CuwXQGPWPvDpTcdDBv6Wzwsx1DahE+LQNsygmOA1kKXPeQoBtlf+xKSG0tdTVopx1uQXz1ij3aTDKTstLI8O/DDEIKV/z355xY8EhXO8RilGP4DoZ9lgrdsl+MqayiwXS2G80e1RYEhMHnZhzgtD69Wx1ldaKQHhmBU7dSo0LhjZIO97IgHZN4X+C0fYxnobYwahnf2T1Qn5fyidBfoZXleCilHbjm5B5ZtWLqrNUshChzGZKVMDYdJ28Mh+q6bM0nv1jJwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxrN2PcIJOLrlVvg6VdyBSP4T3iyf+RUm3lRQdTOuBU=;
 b=DwuBolqVqnuj8ZXcPefNTFe2J1SZQGoNnOlwfwHb/yoPi4FOMhhGwerHfqfgMHnIwXhYV6OU4VGW+ia8nwffGdv0rPHkXEjn/DxlD7kBkAMVCVWh7GzuR6g5TjJMHvp7KdN0sOp9P0PlytxNBtjqdWgxRV2wNxz1fMS3x9f8DE1y5P/SrTRxb//HucpIUIOsH1Cbsg1dxBThnKVJvRsqi7jaSV4gzODhBDk014U2Q02tK/fz3f1ybWiR5KusY62n7s8rrm7N4oDPu/GbYicaxZPB6+xsM9w1Nwncm64gnO9qW61++lQ7EXQb9W8LVfA8Dmt5wrRM94Q1Mx14eZMEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxrN2PcIJOLrlVvg6VdyBSP4T3iyf+RUm3lRQdTOuBU=;
 b=TtbvGhg+x/3sB2KhuK81qEkhsyCLslTgdUBx8I1VcGL0bFeBLK5G/Hj6FtWNk9nj3RyW3Y7LWX/ARWgFCfKfwE++14mqYIpfDV1l/6t9bwMxUDm9RQstSrqgvM9ZSU4SudkgzgQc3Ln/iupfzOv15VDjFCvzjEaaVixezK+XVI8=
Received: from DM6PR02CA0167.namprd02.prod.outlook.com (2603:10b6:5:332::34)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.26; Tue, 21 Mar 2023 13:52:31 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::f1) by DM6PR02CA0167.outlook.office365.com
 (2603:10b6:5:332::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 13:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Tue, 21 Mar 2023 13:52:30 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 08:52:29 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] tests/amdgpu: Allow to exclude a test or a suite of tests
Date: Tue, 21 Mar 2023 09:52:00 -0400
Message-ID: <20230321135200.109608-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 744cd7b2-12b0-4425-1841-08db2a1383a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DooETooa/LujUQShIwvIa4SZ645mNHkx5ijilW8inrtw/1ttWteTBnjg46Me78N0I/hZYqVZ53GobhrhsEcTdp2wMt52/yPADfvY09XIIZk9QaV7tc2wfdKAXAKbxu0dVGaHGi85Eey3SwVtJIZnqrBTe3cPhF1zrj/kG+ZJGTjAap2e8Gzz+UNK6c0QEMIUGd/Xbpj/RUwsUDwiwNfb4gvklmqA4sG3MrNoG1ixq5mNpFV86pc3TfZNWMl8QrVa/7qAFxr7fInS0PFWzR2wEMgzlLfeF2IbPAsnXzqq7Qzy339VBc4EDrvJ983HJ2i/2OZ2e+gfl0/Ot1azQcvU+3l6RWrQaqoFXNcYst77aWlK9JxsTFFynGuawJMIquWFgzvp+BoJevUwlq51orOngGf1qM0qzRugbouYi0b5K88ho6IS/B+qn6q1frX05Wo2Ar/3jE4h6JiLi4ibhMJhAJo5RAYNFNGW26zIr1UnpS4DkB9EqoSwFadE//iCBGknJn7EC1FmrYIQhGsshAxQGeoClQg7GazInpyuEMmkLsbAwB3kZ+T5aVw70BTqOn+X1na8a4jDROjQY1r/DfCQa5FAUcRwz+IbEGv/BNKBINXJhGlXKFuxo6PCTBwEfUNbJzT+sCBnL2Xuj+B0hvJ/e6QO6yfnBzm7RP2p5ttq6M6yrfUu8T4u6AD5tAkZOPYr83Clnv3t8WOTp1CN5yQvrBz2etA06ymZ6hzn9NT0gw0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(36860700001)(7696005)(426003)(478600001)(36756003)(5660300002)(40460700003)(336012)(82740400003)(6666004)(1076003)(54906003)(40480700001)(16526019)(26005)(70206006)(316002)(47076005)(356005)(44832011)(8936002)(2616005)(186003)(70586007)(41300700001)(2906002)(4326008)(81166007)(8676002)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:52:30.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744cd7b2-12b0-4425-1841-08db2a1383a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

Add the command line argument -e s[.t] to exclude (disable) suite s, or to
exclude suite s test t.

This is useful for instance to run the Basic Suite, but disable the GPU reset
test, on the command line, like this:

    amdgpu_tests -s 1 -e 1.13

This option can be specified more than once on the command line, in order to
exclude more than one suite and/or suite and test combination from being run.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 tests/amdgpu/amdgpu_test.c | 187 ++++++++++++++++++++++++++++++-------
 1 file changed, 152 insertions(+), 35 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
index 59ca49bdef5f20..ec787889afd25f 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -296,11 +296,14 @@ static void display_test_suites(void)
 
 /** Help string for command line parameters */
 static const char usage[] =
-	"Usage: %s [-hlpr] [-s <suite id>] [-t <test id>] [-f] "
+	"Usage: %s [-hlpr] [-s <suite id>] [-e <s>[.<t>] [-e ...]] [-t <test id>] [-f] "
 	"[-b <pci_bus_id>] [-d <pci_device_id>]\n"
 	"Where,\n"
 	"  -b      Specify device's PCI bus id to run tests\n"
 	"  -d      Specify device's PCI device id to run tests (optional)\n"
+	"  -e <s>[.<t>]  Disable test <t> of suite <s>. If only <s> is given, then disable\n"
+	"          the whole suite. Can be specified more than once on the command line\n"
+	"          to disable multiple tests or suites.\n"
 	"  -f      Force executing inactive suite or test\n"
 	"  -h      Display this help\n"
 	"  -l      Display all test suites and their tests\n"
@@ -309,7 +312,7 @@ static const char usage[] =
 	"  -s <s>  Enable only test suite <s>\n"
 	"  -t <t>  Enable only test <t> of test suite <s>\n";
 /** Specified options strings for getopt */
-static const char options[]   = "hlrps:t:b:d:f";
+static const char options[]   = "hlrps:t:e:b:d:f";
 
 /* Open AMD devices.
  * Return the number of AMD device opened.
@@ -664,6 +667,48 @@ char *amdgpu_get_device_from_fd(int fd)
 #endif
 }
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(_A) (sizeof(_A)/sizeof(_A[0]))
+#endif
+
+static void amdgpu_test_disable(long suite, long test)
+{
+	const char *suite_name;
+
+	if (suite < 1)
+		return;
+
+	/* The array is 0-based, so subract 1. */
+	suite--;
+	if (suite >= ARRAY_SIZE(suites) - 1)
+		return;
+
+	suite_name = suites[suite].pName;
+	if (test < 1) {
+		fprintf(stderr, "Deactivating suite %s\n", suite_name);
+		amdgpu_set_suite_active(suite_name, CU_FALSE);
+	} else {
+		int ii;
+
+		/* The array is 0-based so subtract 1. */
+		test--;
+		for (ii = 0; suites[suite].pTests[ii].pName; ii++) {
+			if (ii == test) {
+				fprintf(stderr, "Deactivating %s:%s\n",
+					suite_name,
+					suites[suite].pTests[ii].pName);
+				amdgpu_set_test_active(suite_name,
+						       suites[suite].pTests[ii].pName,
+						       CU_FALSE);
+				break;
+			}
+		}
+
+		if (suites[suite].pTests[ii].pName == NULL)
+			fprintf(stderr, "No such suite.test %ld.%ld\n", suite, test);
+	}
+}
+
 /* The main() function for setting up and running the tests.
  * Returns a CUE_SUCCESS on successful running, another
  * CUnit error code on failure.
@@ -682,48 +727,21 @@ int main(int argc, char **argv)
 	int display_list = 0;
 	int force_run = 0;
 
-	for (i = 0; i < MAX_CARDS_SUPPORTED; i++)
-		drm_amdgpu[i] = -1;
-
-
-	/* Parse command line string */
+	/* Parse command line string.
+	 * Process various command line options as early as possible.
+	 */
 	opterr = 0;		/* Do not print error messages from getopt */
 	while ((c = getopt(argc, argv, options)) != -1) {
 		switch (c) {
-		case 'l':
-			display_list = 1;
-			break;
-		case 's':
-			suite_id = atoi(optarg);
-			break;
-		case 't':
-			test_id = atoi(optarg);
-			break;
-		case 'b':
-			pci_bus_id = atoi(optarg);
-			break;
-		case 'd':
-			sscanf(optarg, "%x", &pci_device_id);
-			break;
-		case 'p':
-			display_devices = 1;
-			break;
-		case 'r':
-			open_render_node = 1;
-			break;
-		case 'f':
-			force_run = 1;
-			break;
-		case '?':
 		case 'h':
 			fprintf(stderr, usage, argv[0]);
 			exit(EXIT_SUCCESS);
-		default:
-			fprintf(stderr, usage, argv[0]);
-			exit(EXIT_FAILURE);
 		}
 	}
 
+	for (i = 0; i < MAX_CARDS_SUPPORTED; i++)
+		drm_amdgpu[i] = -1;
+
 	if (amdgpu_open_devices(open_render_node) <= 0) {
 		perror("Cannot open AMDGPU device");
 		exit(EXIT_FAILURE);
@@ -734,12 +752,37 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	/* Parse command line string */
+	opterr = 0;		/* Do not print error messages from getopt */
+	optind = 1;
+	while ((c = getopt(argc, argv, options)) != -1) {
+		switch (c) {
+		case 'p':
+			display_devices = 1;
+			break;
+		}
+	}
+
 	if (display_devices) {
 		amdgpu_print_devices();
 		amdgpu_close_devices();
 		exit(EXIT_SUCCESS);
 	}
 
+	/* Parse command line string */
+	opterr = 0;		/* Do not print error messages from getopt */
+	optind = 1;
+	while ((c = getopt(argc, argv, options)) != -1) {
+		switch (c) {
+		case 'b':
+			pci_bus_id = atoi(optarg);
+			break;
+		case 'd':
+			sscanf(optarg, "%x", &pci_device_id);
+			break;
+		}
+	}
+
 	if (pci_bus_id > 0 || pci_device_id) {
 		/* A device was specified to run the test */
 		test_device_index = amdgpu_find_device(pci_bus_id,
@@ -782,11 +825,85 @@ int main(int argc, char **argv)
 	/* Disable suites and individual tests based on misc. conditions */
 	amdgpu_disable_suites();
 
+	/* Parse command line string */
+	opterr = 0;		/* Do not print error messages from getopt */
+	optind = 1;
+	while ((c = getopt(argc, argv, options)) != -1) {
+		switch (c) {
+		case 'l':
+			display_list = 1;
+			break;
+		}
+	}
+
 	if (display_list) {
 		display_test_suites();
 		goto end;
 	}
 
+	/* Parse command line string */
+	opterr = 0;		/* Do not print error messages from getopt */
+	optind = 1;
+	while ((c = getopt(argc, argv, options)) != -1) {
+		long esuite = -1;
+		long etest = -1;
+		char *endp;
+		switch (c) {
+		case 's':
+			suite_id = atoi(optarg);
+			break;
+		case 't':
+			test_id = atoi(optarg);
+			break;
+		case 'r':
+                       open_render_node = 1;
+                       break;
+		case 'f':
+			force_run = 1;
+			break;
+		case 'e':
+			esuite = strtol(optarg, &endp, 0);
+			if (endp == optarg) {
+				fprintf(stderr, "No digits given for -e argument\n");
+				goto end;
+			} else if (endp && *endp == '.' && esuite > 0) {
+				char *tt = endp + 1;
+				etest = strtol(tt, &endp, 0);
+				if (endp == tt) {
+					fprintf(stderr, "No digits given for test in -e s.t argument\n");
+					goto end;
+				} else if (endp && *endp != '\0') {
+					fprintf(stderr, "Bad input given for test in -e s.t argument\n");
+					goto end;
+				} else if (etest < 1) {
+					fprintf(stderr, "Test in -e s.t argument cannot be smaller than 1\n");
+					goto end;
+				}
+			} else if (endp && *endp != '\0') {
+				fprintf(stderr, "Bad input given for suite for -e s argument\n");
+				goto end;
+			} else if (esuite < 1) {
+				fprintf(stderr, "Suite in -e s argument cannot be smaller than 1\n");
+				goto end;
+			}
+			amdgpu_test_disable(esuite, etest);
+			break;
+		case 'h':
+		case 'p':
+		case 'b':
+		case 'd':
+		case 'l':
+			/* Those have been processed earlier.
+			 */
+			break;
+		case '?':
+		default:
+			fprintf(stderr, "Unknown command line option '%c'. Try -h.\n",
+				c == '?' ? optopt : c);
+			goto end;
+		}
+	}
+
 	if (suite_id != -1) {	/* If user specify particular suite? */
 		pSuite = CU_get_suite_by_index((unsigned int) suite_id,
 						CU_get_registry());
-- 
2.40.0


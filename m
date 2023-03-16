Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF84C6FD19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 19:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F3610E132;
	Thu, 16 Mar 2023 19:17:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E9910E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 19:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THDmsRKi0NtOjSL4oleykWGACA8P0RNRzQiUL7SarIy7p4eZsIcvZgTVy8pEunsUz6zXICtKQu3Fx68HyLtq6axvCxpsmqDOAmGvvF3z+E/m+CucvWn38AEkEXFTZT8xDoWM8FFl+tm4fn16VhEqhuKNTyjiPMifhNztmuVRAKNc+GHcjodATEOGUjA33ygNqDPohdgcC1Cs2rrW76tmq/bkRPEjz6T2dTUsQWLJrkRKWw08XIvKpJJt3A47ReWZby9P2yNbaInP26lvP+IWW9akp6Wh9oDoshsvsiTes6V4P9Mic50e3t9ps6sNFoigjeyWGkEiFM+HuxJJyzrR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlu2YAKrWzDaIIMSmrXzVlqJ/4YLKiayBn8O0aP1iEs=;
 b=SuC+IIBtLkdj6KTYi8ijXEWy/4YaWl2GHaAE056v8Ai0gopI80GgDy63e6H//cVa8V629FUX5AJG5YKh74TV3RgpTdgZ3OfG5eE6zqydbzJJl0YOT7QKEYjE1AW+IyrL+KbwJ/mTkTDkFpnHhZz59LkZBRLEwz7YZkah5ZjfrTdrWXU/2B4I3LYwRL8MCk5s4lvZoo2EMJ6HciHX5Fh5Ci9uhbU2XBU92kDFJtA8Ye4hf/Du6I8pl9jbD3Pc8h9bTVyZWjIzjkjdVcsKrYoyo3VBXlL4DkcRBzJri1s34cxPv3FErMJsQQefHMqtO63qpWKdl8rkNpJj/QkgCnyKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlu2YAKrWzDaIIMSmrXzVlqJ/4YLKiayBn8O0aP1iEs=;
 b=pOENLLioLRCNI900FYSLwEy+uSSmT+n9anfVwAaJcJvBbD1gidj8W/ayjFqqgfqmK1eqfkHSt0meZ83xSQR21TT5GCeTxIW3bIr+vd2VkClMIDGjysBACg0FWSRiC4r11NMtCqB3/0b6zzz2AyTawtVBYwCnHWOj02DI+Y/1Yy8=
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 19:17:36 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::92) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33 via Frontend
 Transport; Thu, 16 Mar 2023 19:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.18 via Frontend Transport; Thu, 16 Mar 2023 19:17:35 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 16 Mar 2023 14:17:34 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] tests/amdgpu: Fix Usage string
Date: Thu, 16 Mar 2023 15:17:20 -0400
Message-ID: <20230316191720.12289-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|BL1PR12MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: c72362d3-469a-4eb4-13c0-08db265319b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/eq2sewtu81GpFWGtikAzpkwtyNYOi+wqcgUhkhPL3/iLZv/M3niaHJSEU3duNcLkUjrPb6em33sx3rekIchFLeueqbT4mfzUppTv6UXFr9xAWZAKMD63NEN3B3ISYaZBUe/c1QseNUlvUqOO/Hfg6Xemb0+Rzpgrhc7lJxoiU3i0PyN3Ff9hrbp1uEgdkVyK7wp9oS8GO8CARi0Ek6KyqoVNMrVmXCuhlX32NO1kzTR8EKO/cB+xbkRVSkRjO/qoDlufKTBsGSIjRpqrGQMaXnKqOF28eBJVntLzHmZb/t4Df06MD4IdHusg7M09WRQDclYR1kKpaMoDax1y9Xp/rGTVnkl2MxTKh4KjyNPBXEYIzexB2St35MqyPfS5+tmQqgmNdvt9ORhpEkvZPsDbv+bqWb4Aas7JsCmNiu/QakqibcSBFC7HglA4shcbMwE7LuFonRXWR8lASImCxWDPK/odvaNdgzGKGqDbJTTWx7EctgAIc44gG0n9suNQGgsVQTl8YBgqt2ofdxJKie1caNkA3ruoe+NzbpDY4QjdmYQnIQKJ8cv/HlQGdm7K8C00/BcaJmwfHfuK5ZJdzpUQ8iSGPnFdb1lGFaLCNg/jX4da5enzHZOnB4aal9PrDDZ/pB3qG3zdvR+U/OWTHqm7UgguzB751BPvnpOw39tgD150lJx3b1NQJ5Ng95JjFGUUQDcHN92Rvi6W+9awe3rSmH23c/qX3EpNIEqEM8TGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(336012)(82310400005)(47076005)(2616005)(426003)(44832011)(54906003)(16526019)(4744005)(36860700001)(86362001)(186003)(5660300002)(316002)(478600001)(40480700001)(8936002)(41300700001)(2906002)(1076003)(26005)(82740400003)(356005)(81166007)(8676002)(7696005)(6666004)(40460700003)(70206006)(36756003)(70586007)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 19:17:35.7764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72362d3-469a-4eb4-13c0-08db265319b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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

Fix the Usage: string on -h (help) in amdgpu_tests.c,
so brackets match, and remove mismatched angle brackets.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 tests/amdgpu/amdgpu_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
index 9abe5730905ad7..b8fd638c5f4e97 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -296,8 +296,8 @@ static void display_test_suites(void)
 
 /** Help string for command line parameters */
 static const char usage[] =
-	"Usage: %s [-hlpr] [<-s <suite id>> [-t <test id>] [-f]] "
-	"[-b <pci_bus_id> [-d <pci_device_id>]]\n"
+	"Usage: %s [-hlpr] [-s <suite id>] [-t <test id>] [-f] "
+	"[-b <pci_bus_id>] [-d <pci_device_id>]\n"
 	"where:\n"
 	"       l - Display all suites and their tests\n"
 	"       r - Run the tests on render node\n"

base-commit: 332809f3ee19f07abc03b62d5892fae51b9d9902
-- 
2.40.0


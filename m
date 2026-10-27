Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234E606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bjgP6vmE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2F910E46A;
	Tue, 27 Oct 2026 19:59:41 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7473A10E02B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1ThNcRPkO5Z6IjWrh6C6rlheCtxG1/6OB+wUGZIZerFy10xKtBiauYgnmo9n6pHVdIxNes4dYmQKZNQHqPUtVwBJCp4NyTIjZHNHv0I4GEQCPf34K8vzYgT3gh/aNZVKpBiX5tu8fWITmSDxsPY1SnPpuzxaf8hyI84ryT5FZT9UYst9o241qXYO3MUp7gEK0ibifHP4YJfywvjkwBo3TMX+ivqDpL7Sj7MBQzdpIO0uKSyIHACKxyy22GvsWx7MXRc+l6r2F0OfTSAIwPvJ8nQGIPNGkeYlNUuxBgGiMDWzfVBPIXsJ2IWj3Rlsggox3ILWPG0MbdVqUQCXfvVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD9Z7PW3x5jHX+H6OYLC6ri+/Oe2BRxe+zd6t+9btX4=;
 b=b5nfAwnxJEfiBY5BvqumC2odmnZYE43iK2IQkrAtPhiIj6Tq7YH7TN2L3zkQVqutNfAFr80IEm7wNxcUpDNH8sE9ozqBtzABN9iGU1h8WqTW9j2zoUtNpWu38ngpDtpKncEkSYPHqTyiBXxTKU3yn5BzUfT+kEZlwXhZc9/+VV+rsxLGzRTyYh5Jp2o8sdR6HmxS2ZP9PWx1QhBQ/i8LxxXbkTMtP+1mltBhedcUGPsG02XJ2C1WpP4uqaht4s/QqQ42hDsQXKTXHmJPo3rRUg/H/aOqhB1YNKrwnDskebk8qlo+34XTcGvoMtAUi7uZibe3VtRvkJeqpo6HZUEXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD9Z7PW3x5jHX+H6OYLC6ri+/Oe2BRxe+zd6t+9btX4=;
 b=bjgP6vmEFkyv6f+bvTL56mEoNLWSN67/kyubNQtlA1HMadjCnBzRLF/qX4YT+/weqRyORnaw1QWqCREuNqwvZjMROhbCpFppXK7dB92NFsogLAccH8cFwF2535FxWLhml+vGs89lkiDlAZgcOXTom8QK5vhdb0/WuWjEqm9qBSw=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:30 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::2b) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:29 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:28 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 0/8] Add UALink Loopback support
Date: Tue, 27 Oct 2026 15:54:13 -0400
Message-ID: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 19724e04-f691-4f33-630b-08df3464cfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|261026121527099003|261021123027099003|56012099006|11063799006|10067099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: nd+lloXk+s7GXIonDKAnyu5AccgxJEGl/dY13Imja7rkdEEDWuO3ec+UeSw7lg7VKV46Xbz/4JMJCgNkBFdyTzDFYhKwutRJyr1ms7YOLVgtvCro7vPCHsNcRhx3FCcHQZ10dLyDnGtmlxbSprNOOW64oBo71g2yQCMlkFWNoNxVZ6X2qIgSNJUbTR9uywfcK5YLwiga6CfGWseMILqBcgOjD5y87Xyz6yzMjPEPEZIoj2YYxGHIqHk0zz417kWa6DvZCG7uJtICo8vRoc6loMV5ddsRBlx3m9NNOg6aMhaK6/5i8Ly+BDtC8jr04NeFjxcCJNOavUxTt0w7p+BzQW4/25ozJ4GThJ6tatwI5vCNpUdRblffj8lqHXxFPbJGyCPjGfBu5QWKMmfhQvjU6m4moHQijOX4CFCCF6MviOQ2Dezs2YnuXf8RY4a71TOJK2qSPkK9pcqBQzPBly1tke7HqfSQow0Of4J6wrDxlSsANMuKrB4GeiItiFrmKaQ6S7alRJ1qUGxlI4kZbd9gNmBAoP3vSCY5nAdeNfdFXnrPilrM6u3Qasq7kzUv7qtofTVt2pb8NsV8J8JvHdJXNLMbzLlq0+S5mNZem+u6tpJJSaATj59CLBftpAI6ndelGsEmxoncRufBZ97NfEwSY+wEHSc05rkv1+ff0pLRW0z7rl5lucuUW4c/GwIiXz+qM44KXvTNEU8oq4l3/x1PWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Idbmhvan0CW6ZjlsE/INip91Xe7D4bsa67qcDmjBBKDqi0Ybhav7RRKuzg9s+lI8SzuWuRD+G5Txx2TI5yDddFyQMBsmzJDUdlJgl0G++2gzMdBEFTz1cp1fG9eHrptn50liJtGxiF094OCd5z9TD62CRMEZRPnqbJ77GZB8fOIxLc1da1YLM4N4ZCl+idbUAFa+zyuMI09IsIzwoga4LTZID0AIS9Gl5/6SFZ5CoWKRiwBJBA7xQPujQMV7smp9kMXKyafAuA+R5d+UXZqdxlFHUTrT1FXk9F7NwQ+gtPkicXWJRRSffebESUG701G9T2F6o2woVeutJvJjO9p81o8GSBARWfeenZb+glWje/dRvvsID15iaHbpF/zyhvHoWohJaBO78y3zNJiylnAUCnfXUjg+JoDLFaly/cHOUEwdnudZ4Alo2/QCrJ+XVtW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:29.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19724e04-f691-4f33-630b-08df3464cfc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series of patches adds UALink loopback support. This will be
used for validating UALink HW path in manufacturing.

Mukul Joshi (8):
  drm/amdgpu: Add UALink loopback infrastructure
  drm/amdgpu: Support VMID 0 GPUVA completion WB address for UALink
  drm/amdgpu: Emulate exporter->importer UALink messages in loopback
  drm/amdgpu: Attribute UALink loopback messages to the correct sender
  drm/amdgpu: Set up UALink rings and metadata for loopback
  drm/amdgpu: Enable UALink loopback mode
  drm/amdgpu: Reject config updates in UALink loopback mode
  drm/amdgpu: Temporarily enable UALink loopback via module parameter

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 491 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 ++
 4 files changed, 466 insertions(+), 68 deletions(-)

-- 
2.55.0


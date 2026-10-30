Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBA606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JhPw0FPw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346D211282F;
	Fri, 30 Oct 2026 14:06:18 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457B511282F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtQrqdL+egVK7fnnoDVbCyTQPM2DegzszZPhN5XvV2kF89AeA8Nd1ubVEcZuzCDl4LNCnjg5FDobow8GF38QI3H4+spibdWCx0gVH/+hDsDjCTnP/Y2njh9nut91t0q/WBbN5/H7z1/20uuRhMGAg5rnWun1IAx9PW+0RSLwYpR0EVEsg0imAZIGLzN3yohkT53QkHzfaJo2MnsqJcL0/+2mnhplXdaXGfGvpUgXTabZKpWIf6qGjBv3JWQjE2yjlDWiTmRO646XcCJNEMZN4WfW+d35H8BfMlid6bZQGsG1LQ8vWhvVs1uHeqDf/4eMfN3MuhDJrE5fEp8DMn2mkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcIqLoXbElYlobzV6y1NWtfPCC/Q8ls2OU8AIWKTMhI=;
 b=ZhCpKT4nb4/WFJOfvHWoBt06N7tIDkp1zLaquYrAr6VSNGQpZk7wiViLLN7Dj5k4EAcQEUw8jO7J3X2zwTTVlVziqwgKK+04OV+RczBnbSiR7zkeYAmFpYnj1UfFjH59HOE8x3F6OIwbkQecU4cEzpr/+d+3XGh/J1l+TmwBQe94ZFy22F0SyemqjfN2Lc5zjp6JeyqG3NQkUlzt7y5Lvi818FOoXIFK7n19HR4Gu84zqOUUfSCsHmCMUift5W12MO5uRiN+jKOpeqTJU4rAAxcDNa1emAEowXY6j/HdanpKssqEHcXdWBfL+qMtRwGGies3a0xs802tBJ8PSHvpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcIqLoXbElYlobzV6y1NWtfPCC/Q8ls2OU8AIWKTMhI=;
 b=JhPw0FPwZqv1Ww9Z2WuBqoQpwB9Q/6bM/BmJs+bu2XgA0nSmTzsxNY8kQPErYzD25IdvfaEN6I+ilnzIgAo8EVw48vlKY5bXvnUdUz4DsddAayzTbv/FmP+hY5lFewFcUpTsxGe9xd/RoMNgbmgC+GSRCjStZ+c5QozldWrtPNw=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:06:05 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::6c) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 14:06:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:06:03 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:06:03 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>
Subject: Get references to queue buffers in CRIU restore
Date: Fri, 30 Oct 2026 10:05:47 -0400
Message-ID: <20261030140550.2524662-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 70725e20-6482-4bed-edc8-08df368eef3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022075727099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: iMzJ4l4Tk+bA6JbPkXEZusGVoHy1669HdJX2FxakM9N91gO/cU20kRiD4z2UB98DXGgGXy0biNtweuGC2Ma+zRKPGCc00mPs1ZGiitLsX8DQFRwo98Wc8WQYNG/+yM90u3cb6M9nnOfiz9wNxlQgVZRP2mZaA39c3FvD/xftcD2qPJHmnGp0VAhE4wagAq4pz5+NH4s+/oHeZxWZkGAWjUfM9S72/3mARWtqJH3UtvHgXQ0U/j7slOtonrXhaPkql94Gu/hKiFquSppu+QKcHTvLD7+4cD/aEEYno08qAh0j4I11PEhMPnOsT1gGgfLf9apW5GdBOphKx5jxwWdwzW2B/75hCwxs8BDvo9MYOpW+tV0s8sF9cDyihFwankL9WnRGzWqvI2C6odpq4TT3AFyIFebD70rEDHRzxpl2E2V0ajQ9DKWon0o1+GP6M9DKcEKBVwMtIaAZTINhVkQCPvmHxuF6bAborz5Q+FaEBAiIJx4YTKTvfayjZEjf7fTfqHjWm6Tjbr1X5diIZl1cgsHfKu+L9zEPp5Jugmef4wujzVdC2lXIzTcC7ky4xYucFE3vpdDHUGnf1g0y7jbJqxiglfyufrm+mSZ4HZ36Oypfo609cZOpvqbvBaHbaXTGpjIkZ/uA98i+9FKnmDayAiwaod3uwhN2caU09mpf4M2uoENMBU//ez2kpK1eMszWFxJAorYdQydVLYoD9mkBNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wh0y2O9wTLzfiTvimohvBnY4cNPWZKueB95hNlMtic1qnjkjZSW/8QLms94LXys4Feux1VtcRugl8oDGbAeH1nwajICNB7gEdDx/d658OSDV8QS5oeUl46S+pQSCVJpLmgHDprZeIBDXTElwU5jNmyfXO3Qqx4Ez4vVJykhNQRnyu+yhBVV/ZEiSaVwF8BilsXAgGqxHIfxW4TXeC81Hll4aaqueJiCwB7Mx0eb3DDkDHqDhD50fMs2Y3hu8qz6mGYCmBRpm7zgPLM5oJKuWy9zw3om+AYDS7xi9VKxi48wP6pnE8dbGUUM8P/R591vmJUzE7X0LzLG74kS8+lGg/KG/5Dj+gA0sn4lnhC00TobXNvLq/CmZy5msg85d+udn2dQyqyGTizIf+57yR+qAzqzbnDf824O8G7WmK8foQkcggdBu4cWFG2O8Ls3cvDKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:06:03.5843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70725e20-6482-4bed-edc8-08df368eef3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CRIU has been blocked for a while because of a check for the
queue buffers in the queue properties.

CRIU restore has not been acquiring references to the underlying
buffers, leaving it vulnerable to having its resources freed
underneath it.

Acquire them; non-svm ones during restore and svm ones during resume.

This exposes a spurious dmesg warning for not having the vm lock
during svm unmap; also fix that.

I am aware the third patch also may require follow-up work to
handle the eviction case. I hope these patches can be accepted without that
work so CRIU may continue.

David Francis



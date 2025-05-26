Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ADCC54FB3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 15:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD5310E396;
	Mon, 26 May 2025 15:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tc0sxTTO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E742810E380
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 15:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9H7j5ORnf2VIpcMKLHWvrmwktU2Qkjub1tWLt2ocr83nfoy+dcaoY9puIukv4ElcoWWZpvrPf78Nl819IzHZwPq9f0MqxXyXtxmGoMIhinCM6snAiM4BPsNqKbDpCJNxVm7kxUJtZaxSL3TB/fygvRid4R2POYt2YkQQNS7kN5ayJ6V8fyxi1Vr0aNQ9f+Dqrleu8uspH+aKg1Bqw6JkjfQSqmt0i1R7eoxk0zUXom3lIAFt1jFeIs22KtCB7ySsdzWAKdLdu0ux3v1Zf93E1LNJDZTq4o5N2UuM6DnJ2lFgRtqQSU6YYs0Qs/kq0pip0OQk6IQmWfoVTJmeItA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNzJBZHlElm/9t9O897CjUlf3fXafeHORCGakrQdn+c=;
 b=DyWzseo2noz8HkvXKJx9giKwukCe2oXNwMWxX0fLWEqaTqkC5hk+XMBh1wUkJjS9RCGZPD9m3uxlX0YHlUBW0jRjiD8728VckB1gUmKYmf/CwZit6H4DSXPdcBEJTrp3KQqBu2QWjnFU6YQmdMKA1T448kcIPcrkilMUVi+ojLisG1aKF8ADNNg8RAN9UJ3jslZADnEe0gptiQbeSrQhstEfCVV2/8fs1HV5jzSkyBLLy3dhB74wJhEjoxFMePKq52oVA8CCso37WUrThflc07+prQuc+Qa35Aq06E2XUb3rvCVczw3W0ZLHM5WmskW0vu59nXHchDLXr/J4B237ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNzJBZHlElm/9t9O897CjUlf3fXafeHORCGakrQdn+c=;
 b=tc0sxTTOQ8zqWN1nLfQ6WAQzQQPQHc4D+8duc196sQUXVzwtBdjAB4U+/eg33IRaEngI8L9IBc4jMgu/F6dXtxNxfEyc9+PGLdslVvsP1v2nr+4wFB5/5QAON7rx+XjaSVNlyNn0rsJGPiJfZJPkqoqq/9tTex8Y032etDU5Xcg=
Received: from DM6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:5:190::21)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 26 May
 2025 15:12:48 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::a6) by DM6PR11CA0008.outlook.office365.com
 (2603:10b6:5:190::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 26 May 2025 15:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 15:12:48 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 10:12:45 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Enable static metrics table support
Date: Mon, 26 May 2025 23:12:30 +0800
Message-ID: <20250526151230.732802-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250526151230.732802-1-asad.kamal@amd.com>
References: <20250526151230.732802-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: b46745d1-09b9-423e-390e-08dd9c67c698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cNEbqOlgyZW8L9aq3rjXZ8LaDgKwNqPG4IMfBG7zPLWib5mYuQWnyEoCYT27?=
 =?us-ascii?Q?rKdNjkqOEgiRLyVuT27WDk4XLJHqpms2sccgj8La4nKgCqMs6r+fo6LR08mv?=
 =?us-ascii?Q?Ivojkpwy+MmaVo1cbddmBGKpZo8tqUcTRQS4frvF+crihXYS5hfK8+VXs5eP?=
 =?us-ascii?Q?uRdRaCxCflbrWYsGJHi3ZTEerOM07G5AVbJKCRineKBsKwd3348hSgVnJSvq?=
 =?us-ascii?Q?1MSapRu5TZ57siOcgTyB4ru/TxTbmKbod49x2nlXhV+Jk4hJKJODKe4ifhk5?=
 =?us-ascii?Q?q2sU3iubEbgeWv1rWWme6rjxYNT25nR5RzNmcmrVuavsmKdaO2UoeAQEvyQX?=
 =?us-ascii?Q?2nZwhjjd1SuSRO3D1JpsquCJoy+17bct9AtgNtdQeu6EnAxmIDkzvPzkxNJC?=
 =?us-ascii?Q?Gx1KNM+H/9q7zxRYeyvXkVS2DQzfdBMJhOs6z/AgRAOq/LFbvYpDpMki6qRV?=
 =?us-ascii?Q?R+GteTGQR49eKK4e4RfZ6F48qGl/qKAly1tsbzlTl7DsXnkt7PO8QtIm6jip?=
 =?us-ascii?Q?bMbAY0FVh9MDcdKLaydotBg+HMoh9kTwn5+R+kK6pEmh/TlucrxIDxCsSbQs?=
 =?us-ascii?Q?UrgjzMUurFDbVctRVELuWCIsum91tED+f+B2cC4aKgN7Ub4Mtr1xVICNGnXp?=
 =?us-ascii?Q?oiEW38GxpEZcbxQ8M0RRrEmc8N3G8KGFbhv/BPi48gPfTja3farz378IAzuR?=
 =?us-ascii?Q?2Mqkxjo0NOFoY9iuromKlgHxfYfrbrFuCTqw0GYPjK7k2k55w3HOUSmpFgqs?=
 =?us-ascii?Q?EAItDVg2f+qZR5fEcN0QnWmR2ikLEmvK4fkXfb0dpGIaCcu11dwkyZovF0rc?=
 =?us-ascii?Q?UdK3gwm+kMEOXabE3DuGMlJsFHvEl5pRjPexeEwtkyLtoQA+3nLtn4ex0FkZ?=
 =?us-ascii?Q?vbbRxSUe9QSelV08rMxwc1HwT2ow04C3cw+sRMg5pBqLxPaxoPZrbNCraGkk?=
 =?us-ascii?Q?jVsEw7H3I0FY4YQhfVeAzaxu/UaztalVhPQXSSO1jsHl51MImiTfUGtP8GRm?=
 =?us-ascii?Q?+0CSJfTGAJ91mDK6esINyNllVIQijkqq+v148H9nZUPEzaKQCpf11kdf3PuG?=
 =?us-ascii?Q?sL2+j9P+fyXAUS+WKN5bj9LAhF+QwVhYWJHpUcert5OfSVZa/+enU2FusCQj?=
 =?us-ascii?Q?6tm4HHO8On5M4XnM8rMWWrKFB6jhUBYffxpJ1ilkbr+KEOtlXV0MnoSpG5cx?=
 =?us-ascii?Q?TwHLQWrTw7z3wMo0YkWFlb5gcwdav7dGXXmDNYvFpDlu4oqUdXAaWhn5Whsi?=
 =?us-ascii?Q?Jf3fDYaJ7jNkgfNTjWb2rXuNyNHdFbZBYeYcyvCOKMgwoyJagsCxpSyS8m2k?=
 =?us-ascii?Q?qKVj0bT6B6x6cwzxXDkEjE4BtEbyIAkLDuytarl9WxmKWT2hPn4gt75i+zNH?=
 =?us-ascii?Q?RN6VCqHBW2Q9qHNnrap/RN67JDPK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:12:48.3109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46745d1-09b9-423e-390e-08dd9c67c698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

Enable static metrics support to fetch board voltage and pldm version
for smu_v13_0_14

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2651c8c41ad7..f00ef7f3f355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -312,6 +312,11 @@ static void smu_v13_0_14_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	if (fw_ver >= 0x5551200)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+	if (fw_ver >= 0x5551600) {
+		smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
+	}
 }
 
 static void smu_v13_0_12_init_caps(struct smu_context *smu)
-- 
2.46.0


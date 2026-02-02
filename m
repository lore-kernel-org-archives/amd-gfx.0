Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB24E73157
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 10:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8053B10E440;
	Mon,  2 Feb 2026 10:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x59YyJjl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13A510E440
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 10:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKO5E96YAZ8MV7YR8GGeIXJ8rj52OUhU1z8c0ovuWTidMDDmU04un8u2M/A5zhQH7lZfzaE0sqe0Qf9NSTbtLLlfl0/UCvc8aMk6SiauVIjAYaeveCH7Bx9BV10Pt8dwpFRK2u2lPspyqacRKyiH0oPzzGixGDfbVz2PlCbJv3SLjYxjaV7XPyaFV8r7yts+t81kiphze82AVg6a9wIFfbf7VshKsGVQ4zJAJz/+KmVSiULb8avMQp5SGgR9/aObM6AX5WY6BOPRpq/PseiqeTJZPZzpZ4Hhy3xGEYStyRud6gWWafDZ+CHYs10XWr7AkSxY/3lQlW8qRRXij5NEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGRLL/mYL+QxnVqlPyAk5SesAxwwIl6h1P4ZmzdOvCU=;
 b=F454Ezy7QuzZf8zsiAwGpLk+v9g4DApfFcQUA8Pwc4Wip6ePIAvBeev1OQVuk10sdTCRqIq2rrRqQ+Tb30WiJhGbHxvHvrcwEQuaycyybW5eM2bJtW3WjiQ+FRQU6PMUKnPerNvlF5jrq3i1/KRvKg4EmC8rHILocVnCuObcqVR7GYLRlDfHwxfHvP1eUavpECZBSClkB7A7CHN6X+jm/93Fy57ctclVVr5Gjx0sxux+cQtH5j/VRQEt5LN2pra4TIVgnXv8+nd9PNLS7/6yYLwkUIb3PBoKAEuC5V5P60S7XC+jJumajh+rhow4x4mPvz61Z8dbO2e4Os3GbiXwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGRLL/mYL+QxnVqlPyAk5SesAxwwIl6h1P4ZmzdOvCU=;
 b=x59YyJjlI5Me3LkjmmY6RGcC2GuIDgGQgm7m1VmiSBhy/DQ/vLrDiIsrx6PEjY8t+/173jnB4PDm6SR+qbxmXV7EDtznlj6jLHRnxgL4ueEnex2XsmKngNbcqt34owyyszvS9fTHkn9sL/yOsc8oEVyIqOMnghCOZsbuoqg+E5w=
Received: from DS7PR07CA0007.namprd07.prod.outlook.com (2603:10b6:5:3af::25)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 10:54:02 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::da) by DS7PR07CA0007.outlook.office365.com
 (2603:10b6:5:3af::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 10:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 10:54:01 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 04:53:58 -0600
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <joseph.greathouse@amd.com>, Andrew Martin
 <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: Disable MQD queue priority
Date: Mon, 2 Feb 2026 05:53:26 -0500
Message-ID: <20260202105326.140826-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 918ecc94-e8d4-420f-6a6e-08de6249601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLHLons21LzH3Xfq8qP8ehparUmIF0qXYW/X7Y5Rf5tIFWd6guJTsqRQ4gpC?=
 =?us-ascii?Q?w1RTxQK5+RhnG6ZycF0zl1wgNgZEIOmP2+7HfW1Ih7O8xulWFLQN3U5t1z84?=
 =?us-ascii?Q?ggZJG724GmSnXYJJqXkWaz88DR8aFgckPFnrFSa8uX1wxfRdIrEvUs1Viqx0?=
 =?us-ascii?Q?glg1Tlpn9u3LfVuyvSZQqadx/+0+ecCCUaFvgPQIl92ILm8ub9fSkkQjec3q?=
 =?us-ascii?Q?UXLnnw0cgoBXFZhPQZrruEVDab7QNaSeCQB30O1QqPGeJ99CFS7N0rYbpNpQ?=
 =?us-ascii?Q?FUIJP2TdiSwlLfOn+qnpYvpWm0nA0d05nsE6ThpupVbSda7ejfZdWmV1w233?=
 =?us-ascii?Q?kly8bejzcoC/ffYSPdL4FQETAgC5Ar7tljj2ty3q2FMxoAY1onQhD12gqPzC?=
 =?us-ascii?Q?rZL+MlGjoTMtQm6+b1ql7cokpujPRCNvDXQoNDb4DnMOfgI9Jj3gbj43zq/H?=
 =?us-ascii?Q?bbGejoT/FRs+JsJ8OvuLLCzC69Ck1UvfPcNnkXXpaM8mmt1UeWUDmzLapfZM?=
 =?us-ascii?Q?o7bT+EWpOGHWUvhwiB893eNW9UzWky+HisR1nHIftOGIyGjjFrFuwbvTdHQf?=
 =?us-ascii?Q?+ZJ1nVuB0rqoAASpT4vIOcohIALURKZhXz1fpgPYnPxTsarpOXvbhiO/DHR6?=
 =?us-ascii?Q?SEolhxQhShuNWQZshqr3YtL1ROwJTBDLd9IwDJawla2dHJk8xD2jbseT/0mF?=
 =?us-ascii?Q?mWyCQQiIYWHcQKPS8/vIjQ7jbfEV/4qkODf4vatutbG6TyycpLemzjOghLrQ?=
 =?us-ascii?Q?ZuN1HZHtHNVvU/Zt0/MsjihkJW1YSwSQWdoux2PhBwNRtlou8aQN4cy4Diyy?=
 =?us-ascii?Q?/xjF1jDv78mI0/0nlAhV+74AB9EK0XdNEb3UfkzQwYMXzxArGZN8D2+drJqn?=
 =?us-ascii?Q?kst9KGY5PahdWnAVSZEsZo7UFw2MN4Zz57sIZNmmk0RWH/8bPuvFKPWlj5YE?=
 =?us-ascii?Q?gtoWYrsq8Wk4lYGczmnp+YBmCPqEInxpV7zAH+3kKp6MCLdrDEKHhP2vfRap?=
 =?us-ascii?Q?TQF7oOMlYirObKV8eSR0SpwNh1RFtjoCFmH2dbaiIJCD6fdbV0L6ykXcNW03?=
 =?us-ascii?Q?sh3SUuYAQ4W1Oc+F9BzqzFZq6cPgjels+qEBH/ggFH62DMKeouxVqffEtc4P?=
 =?us-ascii?Q?tUGFmzqeq+uQmnmJUnRG7I+09Y4HonYTm+gT9wMPrL6XfZEZ5j7Kh/QdyGAN?=
 =?us-ascii?Q?CD+/HjWnFY9fn7ec7OOK4ATPrkX692f+NYSzzmZkvS8SZuqPc2yeNmz3qhJk?=
 =?us-ascii?Q?/t8vimMZIYIBIderpBm2IpUfQK7AV7/MtvbN2FG+KsgeaRFPtbBedb9SiTra?=
 =?us-ascii?Q?WK1Pxa46sEq5yr87IsIaG0yEawgNjWwOfs56hw3YxbayqFW4XoA1ck55nZ0M?=
 =?us-ascii?Q?TtSyV52ExDyZEMNLu3A7ydAUlofxKGYBsIBb5B/ZC1WXmWABzlKCekW0OQat?=
 =?us-ascii?Q?DqOmKIAlatsxzsGMS3e7joSYl7wEtZ6PKut04Pw6oh0ou2MXufP+pKc5dcFj?=
 =?us-ascii?Q?Z0iPPEBdcU5K4ggyxeI0dqok5ksf2GA2+3qc35GaCSqpb3jRJW9kzO8aIjro?=
 =?us-ascii?Q?NKr6kNaEUl06r2Fd1oQsZXwLqNWsyU12qeWY6sRgtywecKg9lfzdoaJQIdux?=
 =?us-ascii?Q?ThKkjEQjznOzeAqT4fkaS3fkIdILdC4K0ysBVemO2XJITfaPZHBocur3GynP?=
 =?us-ascii?Q?fi2nJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0tO7r8sbNJ95CHCR83C46Wj+IemLAZ6FEowPZPu7QC9nRi7+Xm2s3TBcwaR2jncNtdwsUcBiwGzus+EqoIqLzSkc2HcXJTQT4QHoaxe9KBJ8ne4UIldbD28Rv3Cb80s4PReayjZkxk7poSCFCKtaYI10fVEurYQVkhdN1Rjrn/3qqtNDdewfWxTFAXHWgKpUkQ0sSRGTSOTQ8WUqTS3EDNm9IlsCxHgKTNIBk5aZVK9EL3Vy85VaE7iba1jhIeekgH1qlYhyp8UP5wkzHqFHgNPhpKOa11Z6kvsdB/nByY+ROXG3kxkyPbJ5Ji6YVFNagJ7WKC7Cu9kMdpfaa6u38Zy1DqY631FkP94EiXmWHAm7ik5tA7kg7wQnrbmMsLFYLGbDQBfXzX/HkI+PA39I5krFdOtdKW3jOCDBC5NaVHVN87+McgJv93aazf7E1rMs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 10:54:01.7073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ecc94-e8d4-420f-6a6e-08de6249601d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
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

This solves a "priority inversion" issue, caused by the language
runtime making high-priority queues wait for activity on
lower-priority queues.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..bc4ceba35908 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -106,7 +106,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 {
 	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
-	m->cp_hqd_queue_priority = q->priority;
+	/* m->cp_hqd_queue_priority = q->priority; */
 }
 
 static bool mqd_on_vram(struct amdgpu_device *adev)
-- 
2.43.0


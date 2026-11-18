Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F90606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PjPqSCki
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A49910E5E2;
	Wed, 18 Nov 2026 07:19:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C7510E5E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 07:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMUeL0MFNdQV6uA7e80yk794d3Ue2osw3320FAkontjQ7GPNrunQcDSu27lWaggmso6oEa9FvEQkw2k7+pgKXvRRo1tu1IVAlejZ1zS8H2j6kAI8k7LRxdywaUps1Hr80uI8/pWUsDRdNxRmZxUHrmnxrumHH+ln6dwQEHwe9QXA9eOKvUzKxW6qaJeKuzR8OkotOpDaInsJ9U7ulha03v4LH7gguZ531I0VBnUCxrZJCch6rfg3Z48oUvy+D+s1LJHB+A+ob+Va97y0sl/kALpv2oayjsOHpU3SMdU8pfNo2B+/KYVHafdlKGiNbTHVOYBXibpxvah7ECzMW8fYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f2eCb9wYYSG+/P0HPiYiNAo2ruPqLB9/nT/YgvnYAQ=;
 b=J6ffZ19Xw23Ht8bxCpbVzK7vWKDDD/TqmvD1x9cGFtl+eqyf+ikdV8rLteaMp9ghP7bLh31p+VDDirjF9dGKsGsu2hI2DrYKqFLr59ai0z1+pAbqe2JLvt0ULDEgNvgGw0Wy5m/s5OtbER5pj+g+NgCcIestuXWMKYTH1DYKc6FOZWUncimTI11q5Z9mxd9IW4/RlHsNRtYcEpzCV6nATy40yxcqBFMJkH6VDlsIGZd3LuOE6d54WIm1UWAT6xvG7eDNPIbo0t8xEDOblbntkQ2GDFXHT+OqQIpuW+HfaAIXV76dlwwQaKnBAK7mjpZelujXuStI0fL4vxNCxAbqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f2eCb9wYYSG+/P0HPiYiNAo2ruPqLB9/nT/YgvnYAQ=;
 b=PjPqSCkiipftKxfrZpaSxLvokQqLgYObSOwnuXhB4GznsRw+wD5+U+MGzXX2yaJrbi0HMExZodSHaGchoYozNDx+OFMFoonhoU/b0PybPeRvw33U/4CNudECECNdoi9p0ulBtUhm5SP3rwIlq2Ot3An+CN5Gy5FheI9oQNThrxU=
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:19:49 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::45) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 07:19:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 07:19:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 01:19:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMU v15.0.8 energy accumulator
Date: Wed, 18 Nov 2026 12:49:27 +0530
Message-ID: <20261118071927.2149652-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc19e02-6056-4203-13af-08df454454f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: CmbXsdsrSltLN54w6zxMUgz5cqurOD44W1nK/DJ/nO/DTmQUjqBGW6eG9yZy5kcpp4O2rY+Ch0RPw8FirHFKiK/m8oCGonuL7vtrS1mg/xxDggnrK3JQw5pafFeje2OjbTs6MY1qea3dn564/Nyv1cAKGt/YiIXpSlg3uP8zG/PhZrwJGToF1EGNLLGkTzchZZ6GccFCbIz9FJpjelPKFmFGCchbJBu28XH8eqTXKgrYUAJsdt03etUF1WHGHMFdntvQ8ubmNy7OCIBrm+aHplkT/5AqI4x2p2JyADYrBtHZe0QyZnUovJpD/gaH1ckjl8REAZ4IBOPvyzQIMKlFAgRVt2+IWyAZAHnWbImXD2wOv6cT34JR5T4ou1jRem1f+GZYiAzUbEu1S5K0ttTv+Ds/1VypiGNOjR7pH1YSdC9WDjqt6WgbSAVFywqMx4OqJFmhh5Q09aGj2l4XUQW5hH/GgNw2VD9vTY7a5iOfmvkSfdQw6auxT+ceA/kMYVZJoBXQvCme3nBts2XFXyhUAxjtKRgy7+KhRM3tHupLjh8BEhkI7yhzzpDuV2Q+1jWn4002iiL1gwmNYSoJ93Ywrtkdfn2rKjzbSzvlqBDCYNhYOQoZbZWb7HFUA7lvtZG8LbmZSCY6oNwxNsWq/tEAtg2fEhRlcc/u9858iPc+y04RJXu/ZIKxBbJXCfpGHviB6gxJSURI0q3+ZSdvyKXDzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AFuEwjkZ4CZeJpAKO6JcsDvV4bj8fPSSLcltD3hXtYEE9Trb3Mrgj8TWIYf1elOh9FZ9dMQvS/xnzHxKMlyDTcqt1eiboSyWEx5MMJHE7CuchmuSqianiBg3fvKPDSUBvvxdPlEeAWwM0uIdo/A15m1T/pAqRtglJ6KqS4GfYccOa8kOP7u7acGT7L/iyrR7KFLDDI3aMvngLzvN0cSw4Uef8VB6ojYqmL/1Q5+ylJbBhpChnPNxoHKtFCq3z9ZEOe7W15YRQ51LfS2x3vEoJATfZ6wEmZ4BpzcJkyamDdez34muZWukdO3ciIKzUbnWrk9MiagNw188yiXb0y/IpnF5IMeJj4ABPUtTkmay3X9C0f8JZn9f2qrV1506bJ4dZdjY1iz7Qweko5eeDiqzK3m5Okkn+i8ZsvTj5RTQIT9wroxBRrU6PyUFWgXVw8mj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:19:49.4759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc19e02-6056-4203-13af-08df454454f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The energy accumulator is a raw counter in 2^-16 units, not a Q10
fixed-point value. Report the counter as is.

Fixes: d1168b8cfbe6 ("drm/amd/pm: Fix metrics formatting in SMUv15.0.8")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index a9cd1837239f..051aaa203fe1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1966,8 +1966,7 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->mem_max_bandwidth = SMUQ10_ROUND(metrics->MaxDramBandwidth);
 
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator =
-		SMUQ10_ROUND(metrics->SocketEnergyAcc);
+	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
 
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
 		xcc_id = GET_INST(GC, i);
-- 
2.49.0


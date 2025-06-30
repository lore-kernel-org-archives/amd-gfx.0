Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2DDC83026
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A844910E0EC;
	Mon, 30 Jun 2025 06:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JB6yhB1K";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BD810E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 06:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv3vq9KRJzqD6ncmg2bqhF2jLVwdqPGjy6sBho/N1UUP/T1SC69LumqfvYkYBFwknDcYIKeNbE2QUZKjUkleC5nbrjZIQQWRiTwjdYROmQeDXaekdabCp39NRRrUQqs6ozSiwGrreTBdeu0GIjkwqvd9k1ksGsvn/Pxl08jRv3nICVPTnkheAER4bIVAISOLDmmiyASUTUhmzCuD7sPG7YpYxUTisNUWJqnT5XahADp1c3P/xu0veVLcpEG2cu/w+sijoy4BjLLkxOFBNfhVqFQwCjin1rOVnjcDv+e0gumgpkTtPZV7+o5/a1KjFud4mIF7CSDG3qsJBVdYqEjSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MsS9s7NcluTyaMygy+5Ekg/DtmvfcgYWR2hFelrLI0=;
 b=DBgcH2+KTubjrA2IHm396WEpac4V/P5unvrlpxMhYD2RtoXE3oVdfPDnJTxrxeRgvSfc87Ab6PjqPei3FZzFwOiTC+gMWKTRLzL1apZihN08tdt1QAYxyHSaPAI/ifiKXb9jlTP0HAlwQllz3gvcIRM2N9dJXvckJ6rK0Oddwb4YtlwkXH0Tumo7m/0NXtLSTot3iOHeO5SX8+Pi1Hbmr4F7izmZSwTsxKrwMc4wF2JpnCop+BR/hTQe0dJspnneqsmmwhPZoPcIN9rpAtxIavMORM8CvljLKDbEqexMcfZ+O9bBoVDQIHviRf6kDjkRFGS940KvqxVhBa9xzJp2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MsS9s7NcluTyaMygy+5Ekg/DtmvfcgYWR2hFelrLI0=;
 b=JB6yhB1KEITURcN6Vu9oCxph5qL2ZaWTByokR7mHFTtqQnwA/eCcoFWkhCYhCeOs5JYbaGDW6zdeuuOhjCidYuW9qBsoZgZwOBMRvhYRs6KvdgbVuYowxxdsnRhoy+mnR6Fnu+2fPpb9ZisXsfed9H7FSacn5oZ8vzO22yCU9pY=
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 06:54:48 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 06:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 06:54:47 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 01:54:44 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Remove useless timeout error message
Date: Mon, 30 Jun 2025 14:54:17 +0800
Message-ID: <20250630065417.3534309-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: e266e3f2-fbf2-4278-03e9-08ddb7a30093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Etv+mJe+shW0YwV23JY9Pl9gkGNRC8tKaop3n2wXJ29pNPVqQ6RAosE+9gB?=
 =?us-ascii?Q?deO28EK5esvqlhhU6OZ/Ar7XPwLhcKWpiT17fSC/faJt80DxcB/FBV6jSHiJ?=
 =?us-ascii?Q?fNegtUCMOp0NQMR1bu0lh//d2xTFJQJXqTDMfiaxlzHcGedXpXPgs5sOTkpO?=
 =?us-ascii?Q?RPlKLnNnWSs3hN2m8rwTOc0nORXbbSU42hDuH8qkf+zAwWu+nlfwtkTSqgpe?=
 =?us-ascii?Q?ca2XRzlWSmWIoDp0m2mbiO9qe4ObHoXmumN3NKkDqpU8tCeQ+jqFhJ3C0I1x?=
 =?us-ascii?Q?k9bIRWLiKq8A0s249MPAagkP4c1373huKSsTvL3x6uy/6+zB7dXtvNueeaIX?=
 =?us-ascii?Q?HGNxVMmdeT2XcLUa4VxqnnI6X0IHnJpqP0O3HML84tEYh8scAnUchshRfpg5?=
 =?us-ascii?Q?ej+DD/yRvtgGA7MwpK+foTNooyLi04bveiNAxg0Cjq57S2kSSnLo+mw70xgx?=
 =?us-ascii?Q?2PzU4Kgacjj0fvvoRUUP06yG3qvD6VLHbYabDPmdCsB0S8Hxwobgaa9YVHCn?=
 =?us-ascii?Q?e3S+8/atTi2S4/oj+RZC7OkLEJqh0LdAWx/F7IE3IUFG0Cz1O7SetLP9Ev8E?=
 =?us-ascii?Q?2sB6quYLr8y6pj1NZda2PlKXdHAfNuq7wce2UUA3ERD5cjievjoaRcN1LFJw?=
 =?us-ascii?Q?l3VvFOyozlCp7XAOOBuvtIcEvqfcDpQ9A4PnvBn+iKFruRThz3fhL25GUhtf?=
 =?us-ascii?Q?HzfJghgDCnxVmtmKIuue07Jtz359ouyiTw5Jjj0MUQFAgShnrcb/KB7PBeUX?=
 =?us-ascii?Q?k8Dk/cxedH2+ZZU3j5vG4PUPm+NXoDnOczXFkfwcB/O5xFtnhOagh3gGo9cL?=
 =?us-ascii?Q?wmRZl7XUsOrDRT7dI2vgf19y9kN5Z30J3LKHZAfToZJnqWTUOmIcGcWWsrmB?=
 =?us-ascii?Q?FfYwpwAvNCsQoTigtQaMPpipCZrwxKOKF2U0LbpgIRO9jfDDfeKx+K8S/V9T?=
 =?us-ascii?Q?gqoJfeJUt2sSn2ApGg0CAnz1zXrgXn5UN63rJ7ZP7G/UrLBSK7k/HIENtnGA?=
 =?us-ascii?Q?I6nSUlKdbJeoamIUAHFrP6Rcsoe7HE22SKmU7JL5/isy0U3GHuc2joJNyxzQ?=
 =?us-ascii?Q?uXoS5Rq1UYQd/wSvli8bS22pUha4PwuSG1A7YxLY97TEQ1ZmQ5euNC8p5CS6?=
 =?us-ascii?Q?e/1rveLW1BGbH7G5j5Sy3Os/73zFZU8d1fLuaRbaCgPoGUQAKNhwctClA5/p?=
 =?us-ascii?Q?Gd0opQs/HXeA0r3BXt3Pb/lMVTpb1DZTuH0vqcjJG0xq8owjZ64CqLFItYJr?=
 =?us-ascii?Q?hogbc8uYJx9v2MDxxgd0pojVLfnZENJmFNKVY6MTVVRc5ipuM/RBDkYNmm7U?=
 =?us-ascii?Q?+qAqEJUtk0FZ4W2lYdBMLRgEL4tUtciZ6kHRvExpMFvv/jDKbg7g0atcGY/n?=
 =?us-ascii?Q?Nc+hzBLZeMBYOQIy1bnuGT3i7XrdcVTo2wk5CuWkUHvmKWnrE3QL/tIeNe8G?=
 =?us-ascii?Q?BRZ8dxklzMNtbV7AM1tDXid1VqmZeYjYRLo6PHkVr/1m3JMPoNCxf8ylNKC8?=
 =?us-ascii?Q?PH3Xsf3pjD/xQ9I5KRBmHu7Ekwr/GxTg2PRJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:54:47.2312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e266e3f2-fbf2-4278-03e9-08ddb7a30093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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

The timeout is only used to interrupt polling and
not need to print a error message.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 514b56e5d8ba..daab4414df50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3304,7 +3304,6 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	uint64_t de_queried_count;
 	uint32_t new_detect_count, total_detect_count;
 	uint32_t need_query_count = poison_creation_count;
-	bool query_data_timeout = false;
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
 
 	memset(&info, 0, sizeof(info));
@@ -3333,21 +3332,13 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 
 			if (timeout) {
-				if (!--timeout) {
-					query_data_timeout = true;
+				if (!--timeout)
 					break;
-				}
 				msleep(1);
 			}
 		}
 	} while (total_detect_count < need_query_count);
 
-	if (query_data_timeout) {
-		dev_warn(adev->dev, "Can't find deferred error! count: %u\n",
-			(need_query_count - total_detect_count));
-		return -ENOENT;
-	}
-
 	if (total_detect_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
-- 
2.34.1


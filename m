Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C23C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B6010E4C1;
	Fri,  8 Aug 2025 06:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mUmAcInx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BE010E4C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMv1AjVTYnCz6XTXQMa+nHwqIAcfpllp06R6pj+iM0Djgxg7Bn2c1LEURud8dMhffgmgv5EPYbxzu07H5tVnDodlPI79q91PqfUksPIjZp3mOLhkhNRsG+aeZvmwWWdVzNgQvDHvvoSpxe+uwIN17IyeNprOgoFy0J5viDsuZPRVVAwSD9G20uoX1yyifrqM/jXUzZuAK+ijtnOTjwpjoQLfC/qErP/Xe0pDf571O94mil3bVH/9a5yFNb4pKsm49yYClcFEYPVbz/GelaJ053rsTz6OBYwn9GkHiYuGDYRrs8Ygm8om8WtjXYUyc5VDGYVYbnwqlXXaONGBOC6PEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/UuEIhPQ7hYzNQrP6uhCHqrFELrDunHgeqg5dKW1Rs=;
 b=pzbTnGKE/qupjZZy/pGw9fic0+BNTHbXVSVBWm8Cz/0Iay/pVAWk1V7o47jQoUYsR3XJ+NEyoBlN1ELKu00DJ4+5YXfUxTTGfbBxsojV2TWmc1hIZHg/x+c98VyL/uvSMcVqLxokkTVOZ8AtqcXSGH/La9efwGDOEZGR0Yxc6ezuPoPfGfcG8cc1MQTf70+aVhVwwepx5TuAJ9GaEOvCjEzVK8TYoPOqEUSA1bAc8l+OaRSeCsil6BR6VbOn/RbcwUnja1ww2e2koxNqJ+TyQ5o87wzvg2FtnHkjNrFp3P9nKB95AvdEr+MlIFZK4Rio0nPVrz5Ziy1bVvaUMz4LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/UuEIhPQ7hYzNQrP6uhCHqrFELrDunHgeqg5dKW1Rs=;
 b=mUmAcInxki3uyfSqCU8YP2cJwZl+8f/z/nFVh1iMrF2SmvF2kQ59Liiqt7OQ0FU/XQk3z9/h9HEuNzhZ5V6M8+/YNiL9/+6kY1jo07h5lTar2yiNSVbv+P6C/xhHGvty53hkYhmLemrd8UeTaI94KEczncQgM67lqO2odRg+xsU=
Received: from SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 06:29:46 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::9d) by SJ0PR03CA0171.outlook.office365.com
 (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Fri,
 8 Aug 2025 06:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:40 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 09/14] drm/amdgpu: track the userq bo va for its obj
 management
Date: Fri, 8 Aug 2025 14:29:05 +0800
Message-ID: <20250808062910.1613453-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fbea36-8340-47d9-405a-08ddd644f736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zbxerIZiSbwDI8llJRTyxjce8j+xwB+xRt98KSKXl1HgtPm4LmUrdxZHg144?=
 =?us-ascii?Q?BOpeuDMJGynyfomt1Mx70t1J5mvH5AOJGjwMRCsvQFt4lRIH1XEk0MROqAf0?=
 =?us-ascii?Q?o4vgUJbnj2JxPHbPysTwipqwsvv8aeLH6cwWoVzdRux+GnTIg+vRIlSAa+Cm?=
 =?us-ascii?Q?tvoxSLsSeE2RW0u+6Pj8jjUlHm16ttVVjMG22gHLpPHuxjR66j9t1rnJOdxp?=
 =?us-ascii?Q?vhgqhUKPJm1PHH4evNCB8pMYns2BQje4meE3i+9KwLNK/V5pNgbZ4PbZPJ0T?=
 =?us-ascii?Q?/mLY9X4pbUQdIxtbTD2/+FQdV5O4beuJjN3axrsK3ziA11uYykmzuO0av/p2?=
 =?us-ascii?Q?hjdFxu0JT1y8xvIILL54/RZGCO1rHY78VO4VjsQHoNashNrhe5fz4MTlHdwe?=
 =?us-ascii?Q?34p3cBlTu+UMEJ3+suHOGLIzyL/Tdh9D0vJhZxUjSrTWofD0PFDzRE3kRm4l?=
 =?us-ascii?Q?XMU/dyQKP/bDkNc3kNkwBKjON+gGAVrjBFUz5nT4r4GGdLQlGnywqqeJRrmZ?=
 =?us-ascii?Q?Myb6GTaopABdMzey2a9/G+QtO48eu4Is7cIquQlJZulKud0CuWCF+i7YcQAM?=
 =?us-ascii?Q?N0SqhljA4k0wRnhUL6qbxh5NCCcnVWHD3ZEPbCKQGieVDIb59f9eLukTbBVv?=
 =?us-ascii?Q?BNRJv+zqShlelQLLuVa+ug523T3yhVZSdLFam7ZJ/241UVFTfN9I4P6aQ+iA?=
 =?us-ascii?Q?o1oNiGJXP1R2ypKCkWJynpRxB5V9NG/WQ3zvOEK9FVXPSHfCroxqx19kHCu2?=
 =?us-ascii?Q?UeCqRI4Mt5UoFf4iz0mUrXLlOpgM2yp/OwZqb5FrpwRwvqChIQW9ZviJLerp?=
 =?us-ascii?Q?WHAeY1CsfAKwWuWIjvo7EfR7dW5xNbCnAhmlM81Usy3qXWhrfseh+Q4wHC4z?=
 =?us-ascii?Q?+PTg66m+h6wsB9Flkf/iI0K+TXBZtLyIZE6uhPzP+Z9ANZYlTi95uG+SOVQW?=
 =?us-ascii?Q?wOLkrczJYpjIl3hsCu5NDknC2UV88epJACdve5LYjhtTEgCJdUcgs65vZgHf?=
 =?us-ascii?Q?JdBXCQ5jjpbVwux0IApMuFHQHDyR9u6jQBc7XYtJyjoKn692DIpZi9T8HF7F?=
 =?us-ascii?Q?Y/J3pJ3mRxNkOpMmJNN+CuHLb7JvBZfk/gd8OqfDaZh5JzyJ/xQo0mP9FKTm?=
 =?us-ascii?Q?VISvuMBYgZRoIpOKjor91G6jUvBUr2vuEOwoeJXaCSuQtqZGIKfzFnmJKoeZ?=
 =?us-ascii?Q?tljFXijKYkZjfvTGIIWzz3Ujwn37e/pbZld4w5bTB/3NwBtngaecwWH8TCIQ?=
 =?us-ascii?Q?TZabEBcra/Lmo2GrcLVF7PNDmr+g+Fl+DFN9G3d4qMzYW/c2hNSujSwwgj/w?=
 =?us-ascii?Q?6QLluOrl52Wf/fw5Gw9TgrCHq6lS0DtH6Oh1OO+4toPo+rB2UsBuvcVbI4Il?=
 =?us-ascii?Q?ciCJkuuRyMhUvIXm6xM/z4c/8Q+WGa2ZXyiJONhqshjxaUgE+Q/34LpZEUWb?=
 =?us-ascii?Q?qQ+67NFssmTGlbdO0FkW8QrhNensuYZjko5knlvTbRRUTKPe4jLuIXnFR5kG?=
 =?us-ascii?Q?FQWGyypSJnf7uSQo9nzBnFEAhsuNiRKzz4rX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:44.8785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fbea36-8340-47d9-405a-08ddd644f736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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

Track the userq obj for its life time, and reference and
dereference the buffer counter at its creating and destroying
period.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 562d12f9d0d2..6cdfeb224f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -306,6 +306,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_put(queue->vm, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
@@ -646,6 +648,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1


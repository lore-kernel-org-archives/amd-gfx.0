Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E6D4920E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 05:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9961510E06A;
	Tue, 19 Nov 2024 05:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK4WAsyB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B09010E06A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 05:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgUnhGk/UnpGl576nS+Ad0XPtcDQlIXp6zOqRnAHPrZnchzSabJB0xlIbEH/jUVDDVmBCIlwiczJ/cRwF2cXx8hrhi6s3dK1vG/uR9uf+Djr1MTBhnw3W2ePvgZwf6fHXW7MXzfruukyB5YL+84c8OPzqpzwKDuphEpG8qJW7hlyItOCtsglamoov5g8YL8CG1Gyp4PhMzO13giO9SDqPit3rJqPinllMKZWkVg1aq62HeMeuuOO9fERYvJlNqTeLQBSCv2JxrvEtve2tRJ+MPixOHoiKDjBKfwdkw40+W1qP8CvRMJULPpCU3EtH82rXWjgPwo5DuCqOxFVisWVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvMt4LVG+CrF3JGzCGUmI8IjQdytUfw2cwF0ganMrTo=;
 b=PeVxEam8m1lB5oKSmdqLIw/g53D+FQxfnWX0vKD2e3+aH0S4yBTvVTtqGO4xqRy5rxIQv/kIxxXVunH4vhG4rbpl3XB+sZ2OWv/JTEHWoKBdk6VZxirCM+XaDuXDyEPniLM7xUJ7gFBytCGqvKlcFAngz3odXIn4t4e6nkSZszZlfnK5tSSGuhhSi+8ZnZB/MTPLzMIa2hJAIVFKY7D9suRk6IsIy0qUGND5OZ0msxR6YK7xI4+FAWyEQLwYakeQnD8c54qC51AQPpjkFlK858MJLrG87xaFWCh6v7HKI7FUb8BroPaphg3kQaHaj2z4FQLBKEGqiLFu8nleQjEuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvMt4LVG+CrF3JGzCGUmI8IjQdytUfw2cwF0ganMrTo=;
 b=nK4WAsyB1k0XC4mxRD1phKTM6knkPklpeLRnWxdSX89hYpQ9yvToPFz+cfr/xEkOeqiZ+D7wwm8ffDgnqCHW3LLReoH8zaa0mAPMKoUI6d6ATHW2U8ChxgEfaZ53Z5XQJ5ZH06U/TLKXQTsYgNL2HOwe6q0Wg96eE3xtnZcLMhA=
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 05:48:27 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::11) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.12 via Frontend Transport; Tue,
 19 Nov 2024 05:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Tue, 19 Nov 2024 05:48:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 23:48:26 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 18 Nov 2024 23:48:25 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu/pm: skip the power source check on smu v14.0.2/3
Date: Tue, 19 Nov 2024 13:48:23 +0800
Message-ID: <20241119054823.436238-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 394fd725-02b1-4ad9-9c5b-08dd085dc9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IBB9n5DSOvv1I2GtEuk/XXeO2aRS3SDvh5tcy/dQH5dq/G38OwRKYL3WeeoV?=
 =?us-ascii?Q?DgW2i4DUhG9BTCQpxnqZh51tue8NuFtfi4yCvPVoKtJhYEa0KZWCm340YEVF?=
 =?us-ascii?Q?j12pXQC1dphbF956ODVJrzpnqSrKuq6/ZcbOsG2tLSXm5wAlGJEZqWKyKmO8?=
 =?us-ascii?Q?zD7aXVz7TwZHnPfAP/fABzkly3STsKsDHFKa/fRpq2dMjmcrnBo68vlLR5aY?=
 =?us-ascii?Q?vq4q7scXyC1nSGg9qrzwnOXQyc7jsG9C9Qyv/e8NZCMfuqaQ0HNUVn5rqC9Z?=
 =?us-ascii?Q?vSabHV8zhsNcjj1fo8duyGfEKu79NcuElqHHMUeKKe0fXkHQMdqGu0yyxa9R?=
 =?us-ascii?Q?G0vKgWXQ4XJKqgBBajmGbG0vtmVn5mhVzEQCnAtf8I8Bp9dBC4Rkwkqv51tZ?=
 =?us-ascii?Q?8T0oXGDP3yz19TGmQp4vJu4Hq1YLjZDw/fjczfUXyz+U7hynNt8mdKH85kUX?=
 =?us-ascii?Q?mpyrHufo9XHKpFntF/5sgcxxFVzq93HLIwJpxxewOQmDVzlx/9F8ew8ch/Ft?=
 =?us-ascii?Q?ZzvzrxkHJj1CAHSf6/nXOkDzqYnKK2/7u2qKoa3W6k8wsedpWyxKx+48cc49?=
 =?us-ascii?Q?Gofv+aq7/QF8IpERQJrfXhfryKY4QdeDiOHkUEtmgmuIJNo7OZZnO3wGyW7B?=
 =?us-ascii?Q?/Fk3pbHlsFehbZXx1LxnFjGYQeYme/EzOOwK/s7Xrj2ixc176uatlW4MQ9nc?=
 =?us-ascii?Q?6cuI7Gq+qUwb4GqolQ3DJPJ8yEW8wwvxGBpVHxVdN/+EPtKigTYG8dc4nYzy?=
 =?us-ascii?Q?LezZ3Ms7/oPgtNN5neeSZa/MnurOYXuCzGk1swPoCKvdi1rZ6Z4Zhr3IdHaA?=
 =?us-ascii?Q?00nGNpfgS8DYutjyae2G6leHVPDJvq9E8xyLmzzodBXWlsbH9UobfI/BA8f0?=
 =?us-ascii?Q?93KX8T1tgsmY57XfwvPZ0cz4xzr0LMURZSIltrvk3NSI8f9ha8t5Yv4U1Y4F?=
 =?us-ascii?Q?2RxIK4IykVyeq2j2IT0Jqq4Jz9yFCW18JdSu4bjzLR6ASxeUIGJgEux0UKcZ?=
 =?us-ascii?Q?W20Fp9DYCeQl0om0att4edYi404crOOvTSAZqyNFAZGfPKtb2zi7nQDjCQBE?=
 =?us-ascii?Q?FKE4jwHxxp867KyapcVA6ZVAJxOdrB4yfhbtSoKE5jXKQszTXsajbu2IiOVW?=
 =?us-ascii?Q?SUMQYeWueKxZRj/CdV9CWo+/zraXZzz8axi2OuPgFM5CTWtks7HKADe9hb6p?=
 =?us-ascii?Q?cY0BIfsCCVOOf5gHB40QcEiSz8O0h+T1ORrJ/UsrlDbAFTwlIiGysS6f6Gds?=
 =?us-ascii?Q?Hn/iE49tV4aV4269d9u5/8pXVYbnVHcXPyOU+Atf1qMzGNCIw3CcFbI2wKdo?=
 =?us-ascii?Q?6b9je46aKPCic7iJkGEIFDvRns4LC3ImVD8q0hUTzevLQyQCmj8pUjCSgCr2?=
 =?us-ascii?Q?+vgRe/3QbnNNBdttU0vhQLSbLVRlPAu9Gf5hGJhLqSJpDS0erA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 05:48:26.8667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394fd725-02b1-4ad9-9c5b-08dd085dc9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

skip the power source check on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5460f8e62264..b60837bd259f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1365,6 +1365,10 @@ int smu_v14_0_set_power_source(struct smu_context *smu,
 {
 	int pwr_source;
 
+	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 2)) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 3)))
+		return 0;
+
 	pwr_source = smu_cmn_to_asic_specific_index(smu,
 						    CMN2ASIC_MAPPING_PWR,
 						    (uint32_t)power_src);
-- 
2.34.1


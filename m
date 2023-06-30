Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ACEEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 00:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F88410E416;
	Fri, 30 Jun 2023 00:05:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8404710E403
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 00:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REDZ/0u0jv/D9WC1itVnn6t+iIkfXaPva8Z+ZsyfOJJGnVUk1QvyLDzKC1ItfZVnShbxmmdurlT0T4fVnHn91mi13g9Cs0TU/l8038E4HivjvO5p++tM9eoD0kpnlGuzNtAtci0iNk/oS3nULWOy1ezChg4fPCN1QZGI8aqStCid8TFp1MmkkZXLYq+L7lajdcOe6Mi1fmjFahlalNM58hDAojSKjnuFp/b5fUuha6dnw7aRNZqWEAwYB15umJI1CHTury8V8RmtSOQtNawunVxQFFJMM9vM4zf/McxXa88RW0ad064mMArEtHeM+C8vvho10CFb6+YUX5hVZlihCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AWXqSSxQwwdsv4U1QdsGWG/QxACFcLiiYwvJk9kEuQ=;
 b=PASYHAdAZTruStENdSdlzeDiLHF97cAaBb7/I6RTjdK1OpUkk9rFw0rUWNY5ROBcZ4P26PureZfPAhvQEwSy2iP0C0+kVUoHpOiuvHOAKo0D/fhpSV+xnNKbQIkFzufv/yCwYLuRd2jI+I59qx7tm/A5A/Ukuf1FBtw0vsa3uif6Kx1qERsfKHXEamLgLGtmTsdaHfl5DGU444HtGeK/KX/acP3gavusmDCPvnMBSdxlK52t6rRqOQJFCuKJI3vtKtwrFryuU/SEO9DP/Bvml8kCTOHPNMPyZe9Mdtx+/DQKJI83VlmGrXr9V4fs+9k/1goKXfoIDQmtb7ogT62YDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AWXqSSxQwwdsv4U1QdsGWG/QxACFcLiiYwvJk9kEuQ=;
 b=j7U7aMh4D52UW9ZNDVR/fCmoVux5E94w2iBoXoRzSoJqDfE9+pMe1C+/B5uYfAbsdmAqniGAvwWrCbb2c6AvekiyjNHchb0TG0m9FJxHHXB9xm7OAFQAgC4Cz1hA1hcWRmi654wIu4StbZ/k3O/9yeih6bex8g/rBXcxx0QVjBc=
Received: from BN0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:408:ea::18)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 00:04:58 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::49) by BN0PR04CA0073.outlook.office365.com
 (2603:10b6:408:ea::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 00:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 00:04:57 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:04:57 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add cu_occupancy sysfs file to GFX9.4.3
Date: Thu, 29 Jun 2023 20:04:08 -0400
Message-ID: <20230630000408.686895-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: e49108ef-72a9-4651-2ce1-08db78fda43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPSDvGTRe0yR5oHAD7vRTDmINh2+MKqQyI3BbdYYJhYmqAv1yEcj+0pZ0IZ9A1rbe3uyWB1lTQzwhj6djm5mDu33+xzIdKC1Xy6EMWNJgNz6UK5h3oQhFS8DKF1ivNglzO9qDP68PRK+ps/GD16kaHBDslxEeWHYr72I41lCO8rFk/5tSIbZcd+KL+dEgTBzc16rRwJgCP59rukR8nszFR7DyNhF9mtyePlfy/eir0s0m+DApTPdy+CmFHp4S/b+dBJO8H9DS0i8q8wwQlv3IKgqnjhkrVQMqfRfny3WkAAQcLngnU/dBfSlsOzblk4c/JegqcIDzqAVdphp2NvIaQqxOQ8v42yqT0HANf6xneRkXjc0NNPZbOgodAJlUNPBmZqKtIXsjqmqbu4xkhMEqQF9Za5uiYZYNThc+GWhqZ1xIuQ3/zKH/7rKQrC5Tnhb19ga1Yqt9szk9VVxsiSNcVK2TTWUolcGL9JNhyGsEqkHXhJFrhh0x1MTBrK82DSN3kTvMF+3UWHZDjlBz4tN3KBBeLpTrnKGFm8I5NyKCZrSWMGNvvYwo5Cn4IRNuXSk7HaUoj8kenqUeuYY1Fl9yLVX8Sg2XBPR+Xe847vB/N1SnTApLilgXZkxr30sbgIh1AFNkweaMPTbBhjz21qfT71IWgqMMUR2lGEG6imG9QCLW9GeWfyuLYlwqYE++J7U0hFTokFLMd/Sol0t1eH6dRWFfcLXlGprJECy8UoFSvFRmDtaXmU7DWLaBygDAKVlpdcak7Lj6eYQ8O3L/kME8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(36860700001)(41300700001)(1076003)(2906002)(478600001)(47076005)(6666004)(7696005)(426003)(336012)(186003)(16526019)(2616005)(4744005)(26005)(6916009)(356005)(5660300002)(44832011)(40460700003)(70206006)(81166007)(316002)(4326008)(70586007)(40480700001)(82740400003)(86362001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:04:57.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49108ef-72a9-4651-2ce1-08db78fda43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Cc: sreekant.somasekharan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Include kgd_gfx_v9_get_cu_occupancy call inside kfd2kgd_calls for
GFX9.4.3 to expose cu_occupancy sysfs file.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..0ac5377a2fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -379,6 +379,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings =
 				kgd_gfx_v9_program_trap_handler_settings
 };
-- 
2.25.1


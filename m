Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0B0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9E710E08B;
	Mon, 19 Sep 2022 17:16:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776F010E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfhoj4PDelFneP003H430nsnVBMHVu7nwDajUsOdks3wB6pEUlBI6l8e02QE1dnpA9OdkH7xiztjyHfQMc57ga4kugp0z/i0GYjnjQnSB2CwpCenW6QCcmsKtIaJqYy6gBD+yb8GYUuI3Wk5m9pAge01bBzfaQ+ZgZZ9rz8XpQrQ2zhQanptb+UMQGD9d6qznba5SyXXM55YddOH8+h4EpaaF+DYqED4Mc9W01tApSfV5YvwFmFgy96xY7ivNqRqZ/NrZ9VAiLlg2x8HM+Cv9EIbKaD6q+OF2E5YFf3ocAsFz7Cjwdp7FyZycaC68LhBndpp5CSL+A3jtXGF34Fykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knx0fqyS8hJYVZeD/VFrMoxtkw6QU+2cr8gMXK2//bQ=;
 b=JWuuKRBbWPCPIKIKr6ybU5JYUcPe0yLuMbpd4kncquf7r+tkxXV4jXS2AU4W4o9aKPSInT0uY2ogkHtuBrRylHXRCP7WGHLpkqADOXyzmjqXaBYIWZPEVIHIckYzFopJZIw9ZOIWmW1koLCgDeMvPxTgSoWJWTlRzMOvFbLuwvbEbvkBZe4jonbdhSgNJ/Mfa/sokqOEQuxROC88vE7hWyQT9YZhiVgJscvy6cXnFYrSx05x2QZ0Yih971eRPLBMPt2jQJyW4xR1AW45VYVmOTHdT6SCgfyUseKmxw0wX7yj2okdwjDUyKgwGGGwhoBeGq3My6BsATnN9MGWzYrydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knx0fqyS8hJYVZeD/VFrMoxtkw6QU+2cr8gMXK2//bQ=;
 b=v+Y3N6NS96U86mq1PMk8OsHI1sPNzuS/KRTW+Ni0nr5/AkuR5sfrJnELoZMzMfYsruO+UtHUiH59O4JI/svQl6TmpSx8NduSH01IH+LY5fIdPLNykK0LqE1Z0GHXsiHi9Fregq2hl9bj3wfsgpjHktBFmyXjF8IR0TnZRlDsfOM=
Received: from DM6PR08CA0063.namprd08.prod.outlook.com (2603:10b6:5:1e0::37)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 17:16:25 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c3) by DM6PR08CA0063.outlook.office365.com
 (2603:10b6:5:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/7] drm/amdgpu: Use vm status_lock to protect vm idle list
Date: Mon, 19 Sep 2022 13:15:49 -0400
Message-ID: <20220919171553.11286-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e3fd45-d12a-4418-98be-08da9a62ae62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sd1ZavNudFb4eZafefP1an9EcLC2PGbAqx28AUZph8of2uUedstJjnFcV58EECyKN5AYdUthiHh1H/Eyx0Wvm1f+Q3QcHeoiIKtuz/lEWQC8bdxzseR8tumjvhES5YUUnLQFEKvn6UNU0lllUHsn7hlWUQd4l9jtbecmlEwZLZBOzNE8f3Wpd53SfHTj4nBYgwxPrDdR6MqZZBoKujSu8BmI1pdimBeA+ma2yzkYIdoxBFdwnERu4oARwUROJPpR+kVHrY0+OHm8yuI3Fpd6PcqR6kfeM6KBPo7d6woF4ZWp/gmkhmkenU/yq5+na+ZvgHUcGoG3Bz9lJaR1xdHEZap3VtWsQhrMtGF7l0cbUs/b/NfBsHkorLTjr9kzhLw/a6tLhwWgn2CSEnMFI2YyNcgvs7WWejL3otcJDsS7kVNZ9lA9qoLIZvgmcbEPW7mPkoi2ATF78E9vkgSRR13MlGE+9re+ysTmciqjoj0/oLNX3/mSGePI/igSzZXN9oxf0TYW5frIOI8QXyCJM2OzxAdup7+mb3lMQK5efLurJgKkqhbGiOeGArqeJBYkqmwl1bEzS6Potf5JIMu7BRIlOXp5NL1TMDhzIszBkLWTnMeraRtLlZACzwD/HrSOsos2JhcYtDlqAaO9xeo7LL2B/4vrX3aLz7x0mTLNfjjZhx0iP95WonD1m508YslJYMHTfiZ7qzWoVQ5y5J4+QYWXpJCK8J3h4GP6QLyzBdD+oH2mMX9BtFPVPzKJR0aOi9hXc5kfl1vFeXvtKEfdtVb0djEUSpeH21BqhtasxIpnKwrPqyNT3grq0j7rpO63wvpP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(1076003)(426003)(336012)(356005)(41300700001)(2616005)(8936002)(16526019)(186003)(40480700001)(2906002)(81166007)(26005)(40460700003)(478600001)(316002)(54906003)(6916009)(70586007)(70206006)(36756003)(6666004)(7696005)(4326008)(8676002)(86362001)(5660300002)(36860700001)(47076005)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:24.8422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e3fd45-d12a-4418-98be-08da9a62ae62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4a1cb20deb2d..c3412709e626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -211,7 +211,9 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
+	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -2554,6 +2556,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
+	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -2591,7 +2594,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C2ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D9C10E0CF;
	Mon, 19 Sep 2022 17:16:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C05B10E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTOfc8XYfC83HiRbVRzvel9I+mmcoRlkIv3EFzrPbXDZaSa58SmNqYQ7+pZ7k/kf50F4I+iuqYZFnlg/fR0L9VyEAKVG9AJEkRAXaYR7EqiLdMojGIhFPwcXeSs/fJlFnf+ZGmsmQEZj+aQzCWdbl52cNbXzgRAiXpCab/fB63F+zolIp/9KmkQ8BsVPGDqbjjY0efs/ahDHbp9vy1E1GHHlPQA+lekZnuKAsQ3XGxIuhGHT4pvFe30QkZ9LG5gtj/d67cfGACMBlJb1BpPOAL2I6UQxYnsQgQ9qHMMVSl+2CIIbE/tHPtwnD6Z7jIawce0mGBRrDLucqbOv+w6fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqPDyTCQrTUYtv9hTe8kqKD+jJwEAZAvEJh55Y2lqrk=;
 b=Gc8mxtove9SmTcLE9Jln3povMO/K8ws3vLwFelpdSjZtXY119EDT1kVTc8pi6xKz4K7pbOYX0e8QoIo2ANAJVauFzE0mnACp+e+mRj5eZ0w1zMQQKB8kPG6e8139Rxh0QNEAQcuVRTNH9tOUTpB8WbonqQsMgK0MpGmR9QmVK5s+kxImACr3S+eKUeLpOzEjwTINPl+EVI05m+C1KHIw9gb9+zhR584Ff0PEhyIJmsym4Lpf6zVT2AufO3jHVgG+FiFZEOYavLfqXzyqMwsy7eITfWvABoqqITvpXngokv5d+0T1lGcWolJhglIufklUA1W89ILpCdMQPwxNScGl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqPDyTCQrTUYtv9hTe8kqKD+jJwEAZAvEJh55Y2lqrk=;
 b=xvK5JVKv4e73fwyZcQuG0bt56HSyhEnFZ1Z2ocsMtX1Ue4zrDvHKzv6b4+OaFiZqRS4QzqNu1o6BNDjxFqY4nVwVT6hmJv1aiGLkQqzhfJpV1mx4N2n827HvyXQSiqcrSqBmk9z+QxnqCCDT0fA+oM4oEZAizC0nwwpbU7sJBm0=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 17:16:25 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::1e) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/7] drm/amdgpu: Use vm status_lock to protect vm moved list
Date: Mon, 19 Sep 2022 13:15:50 -0400
Message-ID: <20220919171553.11286-5-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CH0PR12MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9d8099-46a4-48e5-44e4-08da9a62aeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXTqIbciUCMI5yVyMGvdMpd4IRTZoWzraBUazed2msr5OUxyUkW6Aoh/0G37iNmUMut5S6igdRyzN+PW+NSQrDCD7hzCyHVv1P7BaZMf5FXndlkqdoFeW/G5WTRexZ1yAvtucHEIL9m0F0IiZj2mazIOv9MZly2+FXnLtXsRFYEV1fsbAJKpbQKaM9Kwupi0cPnNjHTHG9LcmvVVtY1P4NQE6ZnF3H8ta5y53Rjf1/uKCK5uLy2JDQJVDhp+vVWGxGQU8VTPWVsjBCXZLJ5HFIcvUmFThs+GKO9CJgR0IDiW3G8nE4J5h2ZwzC2YZRV1fw98x0xCBI0HUnhgDJGUgHD+COlAropb3P0azOi9KNfEb+6yKUq1XuT5axu01ooiELyh+4T+USYbQk++E+yaLD+7CchvvFng1dK+K0etJDUZZ0Eq7H14hlCN9ZTezLp0N53rurLjWnufH2vwnxNQcluiMo+c7iGl/Q+cKnP2U0sl8DKfJZB2lBXdPUMp1EQD/UfSrplVgn0mx23Xaf8rHg5g3mxi3TDx5/N/IEhv2Hk/BLb6fMKFRExZU60kwezKMZW5iHzvLiHgebrqF8V+vyuMdCCws2NoFk0d/6zewfVswFniqk/TV01JYWq5qpogQ8xyOT5F3RsmOO9HQSz+gCjwgJeZQMzxXSp62/5+FSKrAOYe57jg9GWiUxycZJJq2++ycC3QT11+JQb8F7naPFqbOGRdwRSgWAfkaR1cKMsE81Z3pgGBlJX3/QwwT5JlrBNB5ON25bfYcjvqkhB3/P/zEPxI+aNIZeTaYQWWqIpqg4H77V2lEcatozK5Y6O6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(54906003)(7696005)(82310400005)(41300700001)(356005)(36860700001)(6666004)(40480700001)(4326008)(8676002)(70206006)(70586007)(83380400001)(6916009)(426003)(316002)(336012)(40460700003)(1076003)(36756003)(5660300002)(47076005)(16526019)(186003)(8936002)(478600001)(86362001)(26005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:25.3734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d8099-46a4-48e5-44e4-08da9a62aeb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c3412709e626..168875115538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -198,7 +198,9 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -1287,19 +1289,24 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm)
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
+	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
 	bool clear;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->moved)) {
+		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
+
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
+		spin_lock(&vm->status_lock);
 	}
 
-	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
@@ -1396,7 +1403,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
 	    !bo_va->base.moved) {
-		list_move(&bo_va->base.vm_status, &vm->moved);
+		amdgpu_vm_bo_moved(&bo_va->base);
 	}
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
-- 
2.35.1


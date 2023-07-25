Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D07EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 21:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B826710E180;
	Tue, 25 Jul 2023 21:11:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F03F810E180
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 21:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAUP60buG9gWREb/ZtBzYkLgfU0vX3ns9COCAeihV+IyTO0fRQLY0AzrdFzLc+evY8AR0tTMxYth0pguK8kivkFRBuiMaL+z6ZLP1Rf0ybPN/8Jv+CkvhbyJKfcG1XO/QWom+4n5BeLbTIs1L0y/5Kzdst/x6iel+kg0ckRaog0bgZV5gRCT6MWKSCa931TcdmU67GK+yTuEfrphLXEgjWKLNTA5eUa+0baLaNb8HyLvrEvrf0Tb16DabGlPUBnJGy81xECw/vPOAteUWC5roQhmZ5JPazkGYSnM26NBvFDvvQFNYe/7bcSlrhIdZDm/vociQXhWUXUs0DJsAmtUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulZxwpe3bVaJTX8Q2lF7T5eAZsV9YbLlouI5G9BVdZo=;
 b=T8orvDZ1jSX/zWpZ+IpwZJ2rL0bxBDSj2PeVIqlmRrXj8kiZEnB+h38lNnF6kONikwRtJV8JXhDe1DYe7wmOS603Nt7CM4KN7+IUge+M0nnWwHhQiIm/g1OlXxwe9NGnDNNBJUUOtpQAtXFLaULQhP1JsccdSgTOQdScQFhdoTqMWjsBXsLJO1VmeyaZbfY0X/NJj/TushUUSNz9Rqt79Le8xnwWQ2GjuKanm4BcNOec0kkXUWdxVy/EimJjM8bGPzdiVmydD40vfxeqvU9iZHKUVLI1hMEg8OsE5mR3i7PLICpCWrOJWMmCBcVeRkJlK8VGYMfY2+3G0Z5P28x8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulZxwpe3bVaJTX8Q2lF7T5eAZsV9YbLlouI5G9BVdZo=;
 b=26K+kaskW1xlG5LSEaT4/2EdK9MwJCzCLAbOGwB7EbqqsdWFXlB/sxvb50LCZTcF+Iyevii8UgYaISED+UBCFJoqiUi/sYkQ8AKErQul0ZvbuJlzkvol0YcbKpSP6jJnsJQKQ7cgYBkeB6wf/Htb1ipTaB5aEGjMoF/5BrgeLq8=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 21:11:54 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::63) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 21:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 21:11:53 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:11:52 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch V2 v2] drm/amdgpu: Checkpoint and Restore VRAM BOs without VA
Date: Tue, 25 Jul 2023 16:11:44 -0500
Message-ID: <20230725211144.2212114-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: a8de482b-db01-486f-5fc7-08db8d53c57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJ6Fy6z87eIdKqIPopWodxZGkUpGHkYHL3Fw/FEIwJ5DdupyuZMq3ZZ7f6iFr8k0UjboP5dptZXXO6kLdwOBTKiyHtReYH1RmTsR1TPWANqx+4h76SopSi7vn5S0wE6RJZYi5oRMTw4wUFDdLRdXn7x5pPKKPEOAr/0GiJ0h+LCGh1dLUwe10n8Mh73qE0WHalcnGCddbvzywFDPcXyMZGesl+T/VjarLMzO+ikTMSjdYP9QKmihN9NugOuQJ4jY6WRiaVHdERyS7o4LdzubQ7WmJlo4X406YTLh3cFx3hBiFvDZHaolIeR2ScCqQR0E7eUiFu6hCIyq7/8cuyLrKHYgC6QahePEhecNWWkrUtRKxT5SpUTa0iRBDviLQYFY39lB/cWxBJG8TD7UaSUhx7G6oJO7DYhivFFd1ieoG7JQ9kcwIuIhE1XTe+2m++x+N0nfij9af7sTpD6vyJmCy3B+bMpnT+1NzF+QIF37Kv6hqmgCp9Tz4JhjQKttiEfIfjLGnCvetmCkXzf4U5W4IqOctKDdgLFoHF5GVpObWoDqxZ0sR8/gB/BCDvqu1WLjNmf+BzWylDyo6S5m279wtdiEzBx8F/n9eaWNxGgI2zfmpafpGz+eXISMk5rbUDPrDpG748unmJM2foq09cjahwEFhzeRVK/kzDMm3K6yxRvYrNwRAjrtG70+yDgyNDFwN1Whr8J+yktSBytDD5FkxTGTfKPUwRYcGlUkxjhlQzNuCw8KY29gmRKKDKp5reQqZnBL8S0dsE9jBiXxT6ZnOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(47076005)(2616005)(70206006)(426003)(356005)(82740400003)(40460700003)(36756003)(86362001)(41300700001)(81166007)(8676002)(5660300002)(8936002)(6666004)(316002)(478600001)(7696005)(6916009)(40480700001)(4326008)(16526019)(2906002)(186003)(70586007)(336012)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:11:53.6690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8de482b-db01-486f-5fc7-08db8d53c57e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend checkpoint logic to allow inclusion of VRAM BOs that
do not have a VA attached

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40ac093b5035..44c647c82070 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1845,7 +1845,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
 			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
 
-			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
+			if (((uint64_t)kgd_mem->va > pdd->gpuvm_base) ||
+			    !kgd_mem->va)
 				num_of_bos++;
 		}
 	}
@@ -1917,7 +1918,11 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			kgd_mem = (struct kgd_mem *)mem;
 			dumper_bo = kgd_mem->bo;
 
-			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
+			/* Skip checkpointing BOs that are used for Trap handler
+			 * code and state. Currently, these BOs have a VA that
+			 * is less GPUVM Base
+			 */
+			if (((uint64_t)kgd_mem->va <= pdd->gpuvm_base) && kgd_mem->va)
 				continue;
 
 			bo_bucket = &bo_buckets[bo_index];
-- 
2.25.1


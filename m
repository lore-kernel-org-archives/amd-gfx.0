Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB046C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B1510EDA9;
	Thu,  3 Mar 2022 08:05:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C3810EDA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRED8z2kRyIMOEjiWhhss8P4n8QtXaAppISSq8xKZQ5bBheVqvX/BWlQqTh7iI0t731uxJvKmwTKAPUM1YXwVwWQs8PKgPFYWNk3x1SlVb9aCLQS8BC36yeCv3bBcb4fXPybcODu3VmXea2juJf7ZlvaTre8vEazGiUwXUXDPkQN6gQgxXKvMeGDvPDbcz9qUai41Pq3ETQM273fU4ETfdqT1Rao5bMQPNNQMXOnEyjsPRW3yyRsC9BgWB+bh/bbtqB4iCSDua+qnXFM5zKJRfHOWAAtYEQPKfpPyf6dZslcRP2c0NanIVetcTy5LHJf8lcnYqBFJnOXpr8+kx5Nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUwrlC9ZANgvajNhKlNIdUKxl1ZlvfhddtYSDAVQQLo=;
 b=AlwyQ2kuuuXNK83ox6bm7D+F25yaPqbgZ7our9Awuw0+IF+cYev6XMpwX4v+zcA/b+gNijkPbt96Mukd0xxwewyUaOVxsf8JODOd5DmDUR9DUONnoBsf6YN1pwSKrAEc9SXYXnG49p0++GbJWml/uiS8vuW4Dk4EoyKqyGHAfIRZN5rvdHQa3wItts95CIegbNzRR2vZWnYj240no5PjK5q4o9/YLCLJugAipTFic45XhK+V4OS7ygD1XTR9Elnlgr4dqaytVj8LGWD1Qwe26bLwfNRZrAyZoeLKCSzq9Cu44lNEQ1Uzp+JTMSCtpKAFZ+2FITtz343vzlyfxvBFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUwrlC9ZANgvajNhKlNIdUKxl1ZlvfhddtYSDAVQQLo=;
 b=F6j5XPpCBUY0whjK1wUOaTUoMnXMiSDd4XCbB7vnTIkaw6Pl046wSCYGtwkEuKn6NX6kmhOcIW0VeCTzjWStA9TG5/KGSxV4xcZzTauMWlK8naQyauqZLPrpixbotBpT6Fnv5vHCBXME4alo6B1bbQaZEZ4JnFllunxHCRff78k=
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 08:05:56 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::19) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1 via Frontend
 Transport; Thu, 3 Mar 2022 08:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 08:05:55 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 02:05:53 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: judge get_atc_vmid_pasid_mapping_info before
 call
Date: Thu, 3 Mar 2022 16:05:13 +0800
Message-ID: <20220303080514.680150-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b88256-0705-4824-a1da-08d9fceca4fb
X-MS-TrafficTypeDiagnostic: BL0PR12MB4931:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49313D025CE555823C406809C1049@BL0PR12MB4931.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alVd4WSJ2Dr+Divziuoqw7W2zpiFdeVj/M/asOPpIiCYISrzE/P+yKhYMUT30xa7Bn6Sf3I0Zmz0jEHnumrGR0qVAxyhETAWd7TMTbMU9rN3Z0VUB+QohDx+B61unfq/IvxiW/I1rdd6m8lS4BxGUhBL7YKsum5Z4xrgf7aVuONu2YqndLwioq5zLu+taVSaaxdWqSmN53AvzoHGW2LbLbuPgXA90PnFQgClxapSB3z+H4Ml0nST7v2dPJJ4nwOlMVgIQe/Ti/meEyG7FRGTnV9wU6gDBQ6gsKPeLzQPVfSmDRrdL3BxgK9C8IR9NVn23or5Su1nqSFCbl2cnpsp5MWUo4CUCDEU3JyQewY15U4Gd0ZixtvOLuU3jKMZ7M4MQUTaStr8sB57W85t/tQFG5bphsf233k1U0S9MXvnNkMvH18gesiQei0BWwYBhWxHXYwEZw4CRoMK/DkB5KFQMlmZte9B9rrjmpGNpvYRtkbz8JcGFxcjazPliFunaP6RT/NqeWtb4mSCEVpqbVtCJSOWgvaBDucOBTdf5cMwYG3Cc7PF+X+XwDKj00z3Zb0W6V70rFHDVCPD/CY3p2vCuwNMg2OTdhsRGioQLS0FY6oENP5iJmCrOUDn+j5/+YibAoOT7EASh0KhB/wBHlpknwEZ6QqUM6QAFBvxc6LByK0/hgNr4UmHyJ92fRY7s4FykbksvkIKBN0KyGHlZ7/k8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(7696005)(356005)(81166007)(426003)(6666004)(82310400004)(16526019)(186003)(2616005)(26005)(1076003)(336012)(83380400001)(54906003)(47076005)(86362001)(36756003)(70206006)(8676002)(70586007)(8936002)(4326008)(5660300002)(40460700003)(316002)(6916009)(2906002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 08:05:55.8977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b88256-0705-4824-a1da-08d9fceca4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the NULL point issue:

[ 3076.255609] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 3076.255624] #PF: supervisor instruction fetch in kernel mode
[ 3076.255637] #PF: error_code(0x0010) - not-present page
[ 3076.255649] PGD 0 P4D 0
[ 3076.255660] Oops: 0010 [#1] SMP NOPTI
[ 3076.255669] CPU: 20 PID: 2415 Comm: kfdtest Tainted: G        W  OE     5.11.0-41-generic #45~20.04.1-Ubuntu
[ 3076.255691] Hardware name: AMD Splinter/Splinter-RPL, BIOS VS2326337N.FD 02/07/2022
[ 3076.255706] RIP: 0010:0x0
[ 3076.255718] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[ 3076.255732] RSP: 0018:ffffb64283e3fc10 EFLAGS: 00010297
[ 3076.255744] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000027
[ 3076.255759] RDX: ffffb64283e3fc1e RSI: 0000000000000008 RDI: ffff8c7a87f60000
[ 3076.255776] RBP: ffffb64283e3fc78 R08: ffff8c7d88518ac0 R09: ffffb64283e3fa60
[ 3076.255791] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000f
[ 3076.255805] R13: ffff8c7bdcea5800 R14: ffff8c7a9f3f3000 R15: ffff8c7a8696bc00
[ 3076.255820] FS:  0000000000000000(0000) GS:ffff8c7d88500000(0000) knlGS:0000000000000000
[ 3076.255839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3076.255851] CR2: ffffffffffffffd6 CR3: 0000000109e3c000 CR4: 0000000000750ee0
[ 3076.255866] PKRU: 55555554
[ 3076.255873] Call Trace:
[ 3076.255884]  dbgdev_wave_reset_wavefronts+0x72/0x160 [amdgpu]
[ 3076.256025]  process_termination_cpsch.cold+0x26/0x2f [amdgpu]
[ 3076.256182]  ? ktime_get_mono_fast_ns+0x4e/0xa0
[ 3076.256196]  kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]
[ 3076.256328]  kfd_process_notifier_release+0x187/0x2b0 [amdgpu]
[ 3076.256451]  ? mn_itree_inv_end+0xdc/0x110
[ 3076.256463]  __mmu_notifier_release+0x74/0x1f0
[ 3076.256474]  exit_mmap+0x170/0x200
[ 3076.256484]  ? __handle_mm_fault+0x677/0x920
[ 3076.256496]  ? _cond_resched+0x19/0x30
[ 3076.256507]  mmput+0x5d/0x130
[ 3076.256518]  do_exit+0x332/0xaf0
[ 3076.256526]  ? handle_mm_fault+0xd7/0x2b0
[ 3076.256537]  do_group_exit+0x43/0xa0
[ 3076.256548]  __x64_sys_exit_group+0x18/0x20
[ 3076.256559]  do_syscall_64+0x38/0x90
[ 3076.256569]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1cd2ea536bd0..77364afdc606 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -505,14 +505,16 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process
 	 * to check which VMID the current process is mapped to.
 	 */
 
-	for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
-		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
-				(dev->adev, vmid, &queried_pasid);
-
-		if (status && queried_pasid == p->pasid) {
-			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
-					vmid, p->pasid);
-			break;
+	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
+		for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
+			status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
+					(dev->adev, vmid, &queried_pasid);
+
+			if (status && queried_pasid == p->pasid) {
+				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
+						vmid, p->pasid);
+				break;
+			}
 		}
 	}
 
-- 
2.25.1


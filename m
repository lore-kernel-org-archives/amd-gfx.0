Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13832C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 12:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938BE10E06B;
	Thu, 25 May 2023 12:31:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF7410E06B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 12:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+eHe8KdMHeUy87qRRzVvLMDpLlLpkDu3tEmGeWlvd7bCjQAYc+5IuN42LCyN42rqK4SP1VYjXjQG+Ng5zEYXrdykHlKsb59N14pV9eirRhpBEgsOYcCPm/+/E9yafQxzzfz0jIOfFG4+QHs2PpMUtDcwX2hCed+B2OlVhRo9zSIxlUuyRiziN4zRRszynvILvwQ/KTgj0E8nWSTDZCL0DptKkJX7bQgTWng1vnhD/sXiafrN+x0WNm3r0+njo++JF907wD0D2Felto/J2yWWk1ULNJEgkKZ4Zj9bK6D/Lce7b2XqSxVoquuZveL1mWil2R+q/t9jdTibWM+fSFdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNkohU/q0h2MrujVPLa7r5y+woE16Nsayh5dWGnWHm8=;
 b=jcHqlVcUgy9FeWfXMb2L43wdbZRRNE13ais1FchOgu1dwVIgYNcWSZXUv+VsczMKXy9r18Qe5nyIjkhl6SJoUv1y0clNLCA8Pjj3av+GY40qCbylXPqdtOjHM6ISGFjE9mCfHmfgBPSR9eMfj+NJerdcqAVK/wuvf5V8VWvQv3/2TGs9wGifEWavgi78zSqnchFOwT8mA33qUdlLC/m0XLb7HfIEtkU68udBhxYtTU0G/2BBHaXH9oWAE/YrR/P+vi/XUTFBzNbfihuzQiJSqFODH9di5XynhRYJu07N+1OYwVhWwRsUjw0TAu1IKVxu2hn5mHGB+CTahjA4Y4s1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNkohU/q0h2MrujVPLa7r5y+woE16Nsayh5dWGnWHm8=;
 b=V7LfcY7tsVjY6k4xL7n4NZzy6oDoCp7tQ+MxFOL6M9JdGlw6VwiTrEONUI+tcjBU/8tRei6oGoe6R2TmWpqeBE+/zJ3esYeH2+zTePK5TMBbnDnoXX6rOju0x/PZRgyvvIbZborv9fIAJBxeNhOlaeORHsueTGAeurOk84gtL6A=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 12:31:19 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::c8) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 12:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 12:31:19 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 07:31:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unused sq_int_priv variable in
 event_interrupt_wq_v11
Date: Thu, 25 May 2023 18:00:59 +0530
Message-ID: <20230525123059.550220-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f330b0-c797-494a-8a91-08db5d1bf102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJjp6i1QK2EKsHsxesJwqEb44Mx4doU6rMqv0UQIbZVsm24JI7Q1/Fgr5w7OLPuB9N6V+W0NnRMJxG+QIStvadPDUbLtNhAZ/YJA0Bv9A30lqkH0sMaQRUvFd0dR2CkWryrdG+o8sHEK6mADxHL+2MTbjYZJET3H+lBxKGTfwtMnSFJegDnI2jSrqoE9EhPVuaeJzSTSTsOpSbvGVn5d5liic7CkvuLkyxmCUwzgrS4DDFfrHUsLno2V9ocNBHJhy5EB4vAQ54uCpACQye2uQmGuLegm16wyKYjH8Jr4vVVE6Uo13fghNeRMW0YaXYNc5ULI71fGnt1tPvfbr09IfJ3O5/w2KRLN3qUQwLD+lf42MH3R3S3f7Uv637KnTnZbpFg71GNDMcjoSx79ZNwA1rhzjZBEJOpPSfdN5D4jqfvwHUGjCjw6fZd84WYF5gWtkNFYhmNs9W18JUEG/iE72YWiS/Kel6S/Vg85k0TiFSJk4M+Nm1l7pNudD9KwtHU/J1T1bzvPRC4gzrd0M5HCgEE2ITIokySKtB+HLkRc7t9lOkh1Zu9s539eYfBGV5s9xX66hWOXu2eLnBWFp9Bm+hVMXoa8a1DOrKYM9RZ7GdZY93rkw1qZpg/RpEFZGATBUOtZVdeWXBr+fSlQ0N49/9n4fftTctAm+VWvMwbzSPOHL0WgZqUoSm5bjMjwwL8g8yB9Ok782itd7POLuY8l/CrB19/hv0n7NRUh0tafJ1kZks5aeD60KHEn+jn8fee28qt0qDdKo1deP1aT4gZwKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(426003)(336012)(2616005)(83380400001)(40460700003)(47076005)(66574015)(2906002)(186003)(16526019)(36756003)(86362001)(82310400005)(81166007)(82740400003)(356005)(40480700001)(36860700001)(70586007)(70206006)(5660300002)(54906003)(6666004)(7696005)(316002)(41300700001)(8676002)(4326008)(6636002)(8936002)(26005)(1076003)(110136005)(478600001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 12:31:19.1251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f330b0-c797-494a-8a91-08db5d1bf102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c: In function ‘event_interrupt_wq_v11’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c:282:38: warning: variable ‘sq_int_priv’ set but not used [-Wunused-but-set-variable]
  282 |  uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
      |

Remove unused sq_int_priv variable.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 0f0fdea4cd8a..fa0cf6d17baa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -279,7 +279,7 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 {
 	uint16_t source_id, client_id, ring_id, pasid, vmid;
 	uint32_t context_id0, context_id1;
-	uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
+	u8 sq_int_enc, sq_int_errtype;
 	struct kfd_vm_fault_info info = {0};
 	struct kfd_hsa_memory_exception_data exception_data;
 
@@ -348,13 +348,6 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
 				print_sq_intr_info_inst(context_id0, context_id1);
-				sq_int_priv = REG_GET_FIELD(context_id0,
-						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
-				/*if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
-						KFD_CTXID0_DOORBELL_ID(context_id0),
-						KFD_CTXID0_TRAP_CODE(context_id0),
-						NULL, 0)))
-					return;*/
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				print_sq_intr_info_error(context_id0, context_id1);
-- 
2.25.1


Return-Path: <SRS0=d5aE=NF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7863C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Aug 2021 10:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B82260F36
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Aug 2021 10:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B82260F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053E66E595;
	Sat, 14 Aug 2021 10:12:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC776E595
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Aug 2021 10:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhumQAVQ/5sHlGsvCtQme9cEB66HF0/r/W/uYoApT+82hKA6DiolPD9th3RiIwfLo1SY6/Qcixm5JLmiXESizWf1Rt72+VqhLicFOzPCgCmzTvbQkAbNOmsJO1BYoEnCdhMP/TNkk5PeGGxsbSTrmwT23PVkM9iJNtxA0/EyNy/QRv9ikXUKdo9qf6qN0pMngwOE8Ke+GfvY1PGn3fKfJNh5UuafijYZn8JHw5detahCUXaEmKR1kfJXLc/cpydq4QiLb/n8kryPS121h+KIZ481dHIB36onup3oVlg/vk9/Kqnl/FelBIGEcU986zy5vJ6ERB3YbabN2sB07npDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBt5gsi4AX5Zn6sWxG+97/ptxybdAay7tWxx6Nkl8kY=;
 b=QmXuAVfaGP52dBO79Vlp/CXZirsksWgZI3Bl451XtCpt06/hZ6HtgnT6oVDKbh24LNeV4kDdhYrWZLllHVs/B3YsSY2Ma8DXF9l5FIoAW3iYfLB7TLu395RlEGEc4rEyozDBpiKUhIeI+RmM/xG4XXE4aK7KHQQrUwXr9ab225W+lwLxlX7kREBfZ1eaRMAqr5x6fUxmVKp9N/UjG0T6zciZACqKjcMyYSfEIMJlWdftX3ATK9UTDVdKxzY21VdCgWkf65J98guvY9pcI5K4REWlLMvt81824hiOT+uomZ37hEdNpp/hVmVkqKeMfvxzUej+rr6RT031a2CuZs7jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBt5gsi4AX5Zn6sWxG+97/ptxybdAay7tWxx6Nkl8kY=;
 b=b2HRY4VVEpvDMvgpWO4rFtnuxa35feVZvzQ3y/9/gGhee3lmIfrG71/wIb8Nvc2CssX1UL1RzR7ltHRDd+der8k20QM4TROEgJvWuSwBYM1jBKvO3aZaSZqVCKLK9qebhIb/apcDw22QciCtnkI2nXxTQOWSR18ihZFBznbzF5E=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Sat, 14 Aug
 2021 10:12:18 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::51) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Sat, 14 Aug 2021 10:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Sat, 14 Aug 2021 10:12:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sat, 14 Aug
 2021 05:12:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sat, 14 Aug
 2021 03:12:16 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Sat, 14 Aug 2021 05:12:15 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest fails
Date: Sat, 14 Aug 2021 18:12:13 +0800
Message-ID: <20210814101213.3936141-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cad70ae-7a8e-403b-07d5-08d95f0bff77
X-MS-TrafficTypeDiagnostic: CH0PR12MB5217:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5217CB343D4995F923EA8DCEC1FB9@CH0PR12MB5217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZ2OZZxavFyb8eXLjMJdJUfKtcaulF/+wAWBjgLEwcGe1QWhBruQJ/umebcPVwQjnSA//VSqahPwT7kXstniI+JZTblmGUVgzHplhVFc5xkW9kzb2g73QXyyqOLnLDOqmoyUIOfY7Yktqvx9a0K+oprrU0eAxqCjFO9Gx9ol3XUmXLbs4MXaIgUkZ/ZnC7KoLgG25oMzqklYCoePc/lofTrNOLELDq3Z2bu2CtM4tWr3NgYjGTkj/zCWxAJz6cRr1k1KlW1rfrnPDaUA0xop5BMjq/QxqjDcSJ38V6uS4o9Nck4ziLkQ8E4+/iUlO0dnO/WlyF2p7QYsqfj07yH9zpCfZrp0LjNRrqa6X3y+DAT/2Z8regG5oybtqWm56ed0/Pd3LzGRi8+Zi+207Se5Tb46k0aMI6yLE772EmOvh+msSDIJjltG/RSCipQPr+AYR0BqntjuV34Mc4YQ3/xk7e47iMPHwBEeThlxAQ5rHVn3qhWnOYlQ9mXLb1oNm60NM4rR2ut07aTqgJhKd2U7u3I0zWKyoEfvRNrtMG22mD68Csw67+wRRezQQmAMzhw5EaISz57E3OrBmENpOiRtqpHBiTOiu1CHUa0pdcZdqcEc/V9PMGT9ya+moUNc1+lrKo1owBIGXGwOqJDgM5ovcJLdUqrzjkT31Vn/YsjdYrb821vKvK5/eHXPBMVQyJ8nCFPNVGTGSGgtGpGNt1DclI5CzkfQHxSHDGX4LbJ2Cf+zgQ6bctoeIOcYulNxZaHDxLQJ7UaYzs2xbYp54CSc0wuFM+pifuE2lhvmDMB8YU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(7696005)(8676002)(54906003)(36860700001)(5660300002)(336012)(83380400001)(26005)(1076003)(478600001)(82740400003)(6916009)(2616005)(316002)(426003)(47076005)(2906002)(186003)(82310400003)(70206006)(86362001)(8936002)(36756003)(81166007)(70586007)(4326008)(356005)(34020700004)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2021 10:12:18.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cad70ae-7a8e-403b-07d5-08d95f0bff77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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

[ RUN      ] KFDSVMRangeTest.PartialUnmapSysMemTest
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:245: Failure
Value of: (hsaKmtAllocMemory(m_Node, m_Size, m_Flags, &m_pBuf))
  Actual: 1
Expected: HSAKMT_STATUS_SUCCESS
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:248: Failure
Value of: (hsaKmtMapMemoryToGPUNodes(m_pBuf, m_Size, __null, mapFlags, 1, &m_Node))
  Actual: 1
Expected: HSAKMT_STATUS_SUCCESS
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:306: Failure
Expected: ((void *)__null) != (ptr), actual: NULL vs NULL
Segmentation fault (core dumped)
[          ] Profile: Full Test
[          ] HW capabilities: 0x9

kernel log:

[  102.029150]  ret_from_fork+0x22/0x30
[  102.029158] ---[ end trace 15c34e782714f9a3 ]---
[ 3613.603598] amdgpu: Address: 0x7f7149ccc000 already allocated by SVM
[ 3613.610620] show_signal_msg: 27 callbacks suppressed

These is race with deferred actions from previous memory map
changes (e.g. munmap).Flush pending deffered work to avoid such case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3177c4a0e753..982bf538dc3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1261,6 +1261,13 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		return -EINVAL;
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	/* Flush pending deferred work to avoid racing with deferred actions from
+	 * previous memory map changes (e.g. munmap). Concurrent memory map changes
+	 * can still race with get_attr because we don't hold the mmap lock. But that
+	 * would be a race condition in the application anyway, and undefined
+	 * behaviour is acceptable in that case.
+	 */
+	flush_work(&svms->deferred_list_work);
 	mutex_lock(&svms->lock);
 	if (interval_tree_iter_first(&svms->objects,
 				     args->va_addr >> PAGE_SHIFT,
-- 
2.25.1


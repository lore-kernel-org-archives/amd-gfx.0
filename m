Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F938EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 05:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043CC10E232;
	Wed,  9 Aug 2023 05:42:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828F510E232
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 05:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkcuMCzK8rsZlFVpACULGAMj510pWVqS2wkCbs1f6kJm9FQi7onISJNGRv+X0eXexzKD+1Va46B4ltrpCcnRoAJdQBWXuFarkwzKB4t/2Eypik6dohn4ITFxi5qSY1zYUzFfWqZA/GYQI6btfdC/qBpPa5N0BEzO+pofQRCmFpaTBGwPXqkJ/C3yTxSoz6IEUrXDhm12jysKTgu/BpOXNITOJT/mvA537hF2rGJejyOsbvkx7g+cnUmKym2+dY7L6QUk14eQ0R3quoqfyoSRpmlhvxT2PLK1gcv1PB15jYsDNQMapjRjr8KbuVMB1S/Z5rXmTRwjqxJpZPVTg0UgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plWyBvP/2x+qAurFswXpgZUt1EnV+dSVLMkGrWC+PUY=;
 b=ZQ8B15qI7aeIoHqzC8sNTMA0579Z+CvEm6BTnAeTF6JWx6aTFgMVIj+dlMdrP5wuhhzuRC0tgGtk6e6IqaEmWoJ66H/pugG2WLCkTwOUIZVJvYfGF2rFvMpOjujbXzXUiLlCoSwCe7suzfEVVuEl5CO3rewUbpeSsUyQ7Qk1/CI/eLtNNTBe5ofpoR+eoURlETgtQxGZT7To+ZNDsqoq3glxzZrfaqrjlakIL/5aGDDbSO+8wDrG/c3djVQmXEBlzPRUySQyGRnBk/UUApeRmH51YqgGMcHBKPrml9vIQ96Hb7U8g8eN/GkMVHQAwHJx27foYh9aqAmACQtdMPCZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plWyBvP/2x+qAurFswXpgZUt1EnV+dSVLMkGrWC+PUY=;
 b=lvO/zLimG8ql7hjpolGeOpK16qcHXl9OKgUdKqG/bdNvxVgFkdM0/I7ISxgem0KUsJvw20Is6Maxr4QiBSuf43Y6SQ2p6deDxgYOyShqGXFZF8Nl7MbY9baYNsmrxWkDQJLr3tkefhXA78WYQ+ei/n7ZHBK8md5BHPrVq4tzKRc=
Received: from SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36) by
 CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 05:42:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::3e) by SN6PR01CA0023.outlook.office365.com
 (2603:10b6:805:b6::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 05:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 05:42:45 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 00:42:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix missing comment for wmb() in
 'amdgpu_device_aper_access'
Date: Wed, 9 Aug 2023 11:11:18 +0530
Message-ID: <20230809054118.200523-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: c91cdc35-08de-45ad-25c8-08db989b753c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7Fx3k3ylKgQR2gxOgurFTaU8i/w6AQGIxzrYxbi/E0QN1KhplEDgyO9X3pC46rTLPjYNTPtTkCe7IQkMjaN3OEXuDNFK/2oxPWkqCO77vwRSjMb7+u8M0xeDvjxwyEqsFMkNn5yRDRV3Y7LS2VvcFHJUWPeUneRmqY4G1BD6LVgwAuXTkQv7Myxe+rpIP1YO6tGZ29lJVr/aUqoasJ3UxZMHm46jasLerKccBmKwepc0QfV6B6PKGHHXPn+7M86Z3ugvKwzQwkK+auce75NS8uiH/e6+VAZVt489sxuP2xZx2Qttv3cwroE2xKirVICroCFZLaS2rww002RJB1PWM03LtruvF6SsuCgsWcCPv+5wsHczLO6RgEa63JKpKMauUKzYELVKpfLhFXY/f62zmzqAFelOkjahzDZ7ZUqyU32X4WdILyajbfCeHBHh9ufJmoiz3db2Y7yqV/fert7WtWkL6wEZ46pveWf3q0Qqe3ZF3PHDt0u7OHNI5c8ts94Rv4YzaxpcO1jB/T0YdIeeTvaY7jJ2ydKkFh2OAWmhOQM7I8J9MjiipBkqQj7RZ5VMaeARNOLRs83dVbbYOg3ju+135k4XFiTMHj2ffAaGLD5eBMu9NB9Ez2OGNydBKAHrFaurcHtxLrXlV3AWt3bcDr0Tm+l4GYI3L0zFSuvQjvhOlle4EtZZcbLHTh9PyaRtK4ylPdWVHMqE3gKnS5sVBzb9trvSdVPPVihHSRU2l5Zdm8U5fwj0YD+tn2EFKSgA1kyG0A1UqId1/z1PP5T9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(1800799006)(451199021)(82310400008)(186006)(46966006)(36840700001)(40470700004)(40480700001)(1076003)(26005)(40460700003)(36756003)(54906003)(110136005)(44832011)(5660300002)(86362001)(2906002)(4326008)(6636002)(70206006)(70586007)(8936002)(8676002)(316002)(41300700001)(7696005)(81166007)(478600001)(82740400003)(356005)(66574015)(426003)(36860700001)(2616005)(83380400001)(47076005)(336012)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 05:42:45.6661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91cdc35-08de-45ad-25c8-08db989b753c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

This patch adds the missing code comment for memory barrier

WARNING: memory barrier without comment
+                       mb();

WARNING: memory barrier without comment
+                       mb();

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Fixed indendation issues.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4f818f13dc9d..bb65e12ed027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -305,10 +305,17 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 		if (write) {
 			memcpy_toio(addr, buf, count);
+			/* Make sure contents of system memory are copied/flushed
+			 * without messing up order of writes to PCI device I/O memory
+			 */
 			mb();
 			amdgpu_device_flush_hdp(adev, NULL);
 		} else {
 			amdgpu_device_invalidate_hdp(adev, NULL);
+			/* Make sure contents of system memory drained/invalidated
+			 * before copying contents from PCI device I/O memory
+			 * to system memory
+			 */
 			mb();
 			memcpy_fromio(buf, addr, count);
 		}
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2E6D65C78
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 16:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09E110E149;
	Wed, 17 Dec 2025 16:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ytIvWc2d";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010051.outbound.protection.outlook.com
 [40.93.198.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5779410E8CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 16:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYYRheiPTJzKscaKyBlP1W8O54Go1qyCXH2k1vhtb+Y6fEfLlDqrvbo0OsNQWY/JnahzLaAbsV5i6EEH+YXc7BwpbA0sG2H9fkM5+LNCbnIBM66Kfs0+GFxylsMIhbBzKnFpze1cElihjlRCA6eJNPRbNZUZ5jWy3xiDc6vLZeD+Sk5qKCXvjufk69/qiFvVKxol4JxxHemdElkm6ORboj8OjIJ99SF4bO40CAKqBE2Qic0hVYPsJBIPj8avuY594+obpkj4ztpv1gTFGN5dps+JhgX2Zucdw8d9kCeloyI7B51f+xouKRNut+oiYsZRsEhO/5ZaEi01EmjzZ4RdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qad9HeDmBl1/zy6bLcUgpjAkB5vckfGbboLtHqzUF/g=;
 b=XFGQkQWPEk4slQUVcSWrJXSN8LNDE48/aG3hp9sr1XkADLD1XpFkDDpTbqfgbV5fpCIU13BgHpA8CI/UllaxRL+Tvne4EqI0wL+lDfPuBAANmegPFnBV1sUoq3kjyyEwmF9uduWXp+FCdGCzSZ5EZw16SZgWNBOykVA0MyaUv1Po72+00A7iVlzhhhyPND+miLPgU10RGoEcZd+4E01Qx3ft7bw3IDewWIzn4rxE12uts7KFK3vcy47F9mt/hmKtP7flD1eByRPaTpYswy+9c9gT3hhwzvv/xMQTnh3rKJBu06Ao9v4h7xPqlcwWZOEpZkznhgZyT9lcTwCqH/0Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qad9HeDmBl1/zy6bLcUgpjAkB5vckfGbboLtHqzUF/g=;
 b=ytIvWc2dRdO96uKu4RYg+k7K2xITj8inqYU99VqQDXrIc1J6SUedB2JBVicDX2jYNGd3qcoTx6N7zIDcArqFvoMy/tWRcViBztuRcHhE+IYDa5wvadEfTdVv9uZuSH1yraADr3qMQvIewrB/90GgJzc4kAzvy0IMDqOlbmqKxAg=
Received: from PH8P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::26)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:10:22 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:2d7:cafe::45) by PH8P222CA0016.outlook.office365.com
 (2603:10b6:510:2d7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 16:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 16:10:22 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:10:21 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging cooperative
 launch
Date: Wed, 17 Dec 2025 11:10:15 -0500
Message-ID: <20251217161015.1666802-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 595c23cf-95f3-43ee-4c23-08de3d86c7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CR0JdODkv/FSdkRnNEHtCLsW8BBmn1APg4iOaQb29d5Hpw0MoGnLjF93eDz5?=
 =?us-ascii?Q?k07RigE0IiPgCSBZkdAEPNTr/G6pqLkQ/I8/efC/InEwP61mJuN0eDWndW+b?=
 =?us-ascii?Q?dmqMvqt0VJikGex1Xe8hvvHd2T44oM5eO02Wkm7o4tU2Hq3eTDagpQsXVajZ?=
 =?us-ascii?Q?aDWyhktOrzbEeFqEjewIMXntFbAq9B7hoTwtk2hNtjQ61tiooGO2Y2aqMKkG?=
 =?us-ascii?Q?enz4NQLMgtc26Zr9eL+ShmtU2mlh2oZ1IYCwke9JEf+uFhXJiXTr/w0HnS6o?=
 =?us-ascii?Q?qQXADPNEaH+gneKiB1TP3s/0LTu/zA17qnltfXzd53vPNf0ynreypIEjUu3z?=
 =?us-ascii?Q?IsezviMK9CJ8CYkuGh9XE96vtPlh6zC2d5QKIQilMyV4iM8FRP+g3IXDCDZA?=
 =?us-ascii?Q?dFOEI0XdcI+mkN3VVb3bGtFQXHiwjLYD+BpNRdlD7srgci3UNQfPoIs+/cCq?=
 =?us-ascii?Q?ziix9mYjCgnZp/3T3lcZmDSsm/nCaY2pNmOAkPaTPSQyG6fL/op8LAwysRvD?=
 =?us-ascii?Q?hqBcvNmf/Ij10ZOxx/hoFUxHJ63+ROYAPSPUa40NXc0u6FbiwJp+23Qatu30?=
 =?us-ascii?Q?Rh3B9i+JfYkCvGFPVRyMzsb7jy/xMADXlFajbCJQlG2wVkF4XzIrd2zA/trV?=
 =?us-ascii?Q?fnOJ8Sp6jvOvvTnXgqC0lZSbh7glchXGD4+4E66mHVrWcGn1yUzevhnAueWV?=
 =?us-ascii?Q?sUz5WV4lfIRm+b06Q/HNWLuzVzWsLpG4j6YXyy/H4va9ZuC41vDk2YO5HYIj?=
 =?us-ascii?Q?4koXdAqPxHss1fRCy3z+z+FmVJqzmL5eUIgJFe6t58Z+bb05A4WzUz+yyhCy?=
 =?us-ascii?Q?yz1T8bWD11qy38KH5vBDcyXB0k8wJ/4SdMGcDNyXu6+WwF/FHfpeJ+nIN6As?=
 =?us-ascii?Q?iyRnYANULFq8FUAIkzrjZRlTNOn62TfYZTHkeETmOcSKhCAwnsaqJZVm//9C?=
 =?us-ascii?Q?S69t8INHwT8f5Wj+xf7J1V3WC6O9DufU9bB05SCtEWTFsykN/C2txLkh0LlO?=
 =?us-ascii?Q?930vQlUnh3w27RUwR8MrzntW4FtN2Uq/cobVUH3aA+jrkfnsyUdygLzLNvyp?=
 =?us-ascii?Q?eEFFHNyG+aON+a9aQ0FJ+vmTvR/MgTDIVoKx0UPt0YFZ5iXdsVtgdRGXk/K7?=
 =?us-ascii?Q?um9MD/o/vk2FNHgKaEYmrQpwqxBXleI/ZtzIvxxmT/CKDdwLPG4ncct0sX7V?=
 =?us-ascii?Q?Qo0Iys0RXgwSMRoB9QdyE0+Uaxo0QwDUxy30mT1VXvCVByC+U9mDQLelA2J9?=
 =?us-ascii?Q?AziKYLwFX7OVDjHdNhXRTdpsu4w6Qbky4uk7taAz5hIgX0B+zJmnmu7D/10i?=
 =?us-ascii?Q?7O3VSCAGcVn3FDySryz2wrB5a0J4VIQ9RulHkB5wT1G49rR4GkDuG0tjF8wH?=
 =?us-ascii?Q?CFvjJSV7P+6bKt9dGdsKq8jhTewnhYIVNj+gRWuIERwIJoUx6di5EbCOSau7?=
 =?us-ascii?Q?k3ICE9qIkrWxLksflI1jp6iZQr7GgAqvt3UU6dtRiNgDFOsOnkSTXDn0Ww23?=
 =?us-ascii?Q?E7vlN5+A8uA5cdAptT3TiDzSHaHgp4Xze0Tb49eXNXNVGYNHOKqnRAa16pFf?=
 =?us-ascii?Q?bfd/URNigFg8sQ4a9W4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:10:22.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c23cf-95f3-43ee-4c23-08de3d86c7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Restrictions on debugging cooperative launch for GFX11 devices should
align to CWSR work around requirements.
i.e. devices without the need for the work around should not be subject
to such restrictions.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 27aa1a5b120f..fbb751821c69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -120,8 +120,7 @@ static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
 			&& dev->kfd->mec2_fw_version < 0x1b6) ||
 		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)
 			&& dev->kfd->mec2_fw_version < 0x30) ||
-		(KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
-			KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0)))
+		kfd_dbg_has_cwsr_workaround(dev))
 		return false;
 
 	/* Assume debugging and cooperative launch supported otherwise. */
-- 
2.34.1


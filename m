Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1326C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B2210E25E;
	Mon, 31 Aug 2026 04:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWeOBpw9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDEDC10E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sas2PV+3Xvo/rTCvBM7ZkvZze22xXgo5n9ncrjWfU3pMookmt8SbSqCruzVB/0QHyJtZdSDl0rlycz8wGA7C8koQKxRZuGe8AhTjsSM6IddaY5Ov1B/YpVTS4FnkqIB5pXm941GcPSo2B80RX0R9zO71hfabH/naLYx4xgX7j8TSJYBHxIiJwMAu4xDM7pUWL5hr0yGuHrdpOZema5brJ3v+JMGju/8ayRj3RqADc1Wym+NLWhFCGiHbtlKNKy5foFfWQy8Ehm540hWm8INxcEirCwp7MZ0jZek1aGaLnYtio6bSiDxW3vXfDwva5wTxeoQRMZJDCmH2a+zpypE2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbbxMLMgBQYGkpbm1kFY0R9HjI2VkU/Z/vemZ6WD4mw=;
 b=EoWom2hZrlWK9AVyighAPQIiwV0vlN5NxNk6BmPu/BgoPEL2xsxaibIP74RQzO9wbGrfQm3RFrNYZY/TGQGzOaz1lY6vaEMd7uBQT0m933N4FDUw2VJc+4kU0oOeW/51UoCyNqfbcFX1nKP2NcGzmKXg2t4o5+8tAl+8WM+FxTURB4BTkIK07CaLftwV+4w2Tgh0cCIYDPxhwhwASvFTyfKuq0tahFpwuhwERDE/ndD6t2MhzSXJ4564ww5nlDJS7+stti+4/y9Qr0sB3o1uicDIUayEa0b5M7xpqlOfYZGu8vCT/dFyLySz+KofkKw5pLDcyx+FrRq/fzole2vpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbbxMLMgBQYGkpbm1kFY0R9HjI2VkU/Z/vemZ6WD4mw=;
 b=vWeOBpw98Zb0OErI3AIeW0UAWjBp3TI98N+y+g/EOVPxY/JfFDdkPxdHCxT325CxqGtpOn0KYV7Xs/zKZawieqHHlf3b0vZQMwlbwqMQSBLrtwxg+rNSNc2qIn5ZO9HpqL9NNMeN3DNtQJqpMGiPNtZtv0lAwbgUDajjetwINps=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:23 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::1a) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 04:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:19 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Date: Mon, 31 Aug 2026 12:35:00 +0800
Message-ID: <20260831043507.523599-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffe5d08-04bd-4bf2-7635-08df071944ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|6133799003|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: L62TE21oN+hbAtUVGqhLr1UIBO4vrISDa84uL9ltHYATvgrqv0Q4kjFpCdWPrnhj2Gl1B1m61LxMdH9MaB/8BXrmeT2zaV6QxbW5O6uZCqp6GxsRWtEj2ELSMgmvyAtCiDMpM9rqUwB4intEbkGW0WV+psT1DBm9xpSwWghPjDgMSb0rg5Puk81+RCp45cQE/VXsRopvcix6SCuimIKZmZ0jQDwO1aCRtKAyQMLWwgS51J2Kn0m0wiNFcn7XU1jIkSp9mRg47TcBQ5ZoILiSNqURWmPvHeHGok8bGnZKcA1lHI7LlTpOyJ+MNpo5ddO6XnQz56kC14ZDX2fiPXO6By+QSOAMRU1lBOTlTzu+oBb7Ud585HyshhntgbOgo5/CaEFch55DcyecqtRMnWrqcfH3dJvTsuGwpPy1qcFzF4gZaN1vU3pJg+uV5nIlG/uoB9M9ePvajr+GkIkmdxPscjXY8/UjFTixqaWg7egdcs3mJOOvw1i6Y5qflRG0NWqbKAEHV+hjRJE/wpRwaA7iHUlC+7u09ibxIJMrG2mAISTiNtdXrTbGcyo19n+oCZbyKM/+jkljU2OxoL98J7rbvmwcTHXLRTdZpgWZ2OXHXaSLUPAiBMmjdF6b8qEvUF6YHg3SxMrsmGNskspG7qhaWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ni2QUoRy3nuNsINpxkMNdv0rDFL0Rp3hwdP83N2xmPKG3NGnYoyT9VNG7wyBVqFqKpsGm0gv/rOG8L91mzlmXx1dEPU6OmluENTNtWUWwtm6kvcm9uYFYRSDTxowdmgioKPhLvl9TTdKCzAFL7rNiMO7mAVqOnA+W2P7YiOGiOoyWTWgJgBM555hY2hL7CPL5liQB47DVi/ktjCKsSu9UHRkqG2DXlkFpPrtLZ7SSxD2mk3ck0V0TEON5fTcIUa2RbGOeXouytj2rmS0xO90G+GjvcezKnMAOS5blL0hXdm8JB1JZ2+vKkEGZTLECRPfU5BIRCj3+Aoj0wl70SSXotAzAIX2b+qHy+TUHAZ5FoF5rWPtNo4E/ygMC1k+SoX7ctmJokoel0iqgvXET1jUrGYowMcaHAxOMmrp+I1gIIdwFSP0SM5TkwaO4AedPwkz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:22.2641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffe5d08-04bd-4bf2-7635-08df071944ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
users edit clock, voltage, and power settings, then write "c" to
commit them to the SMU.

However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow on
every SMU version. Some backends restore their cached settings and wait
for "c", while others upload the reset table or send frequency-limit
commands directly from "r". As a result, the same userspace sequence
has different hardware effects across ASICs.

For example:

- SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
- SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
- Navi10 stages the boot OD table, while Vega20 reads the current SMU
  table instead of restoring the saved defaults.

This series makes "r" restore default values only in driver-side
staging state. "c" remains the sole operation that uploads an OD table
or sends frequency-limit commands to PMFW.

This gives pp_od_clk_voltage one consistent transaction model:

  edit/reset -> staged driver state -> commit
                                                                                                                                                                                                                                                It also permits userspace to reset a staged configuration, adjust one
or more settings, and submit the final configuration with one commit,
without temporarily applying an intermediate default configuration.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690

Kevin Wang (7):
  drm/amd/pm: stage od reset for smu 11.0.7
  drm/amd/pm: stage od reset for smu 13.0.2
  drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
  drm/amd/pm: stage od reset for smu 13.0.6
  drm/amd/pm: stage od reset for smu 14.0.2
  drm/amd/pm: stage od reset for smu 15.0.8
  drm/amd/pm: stage od reset for smu vega20

 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
 8 files changed, 145 insertions(+), 88 deletions(-)

-- 
2.55.0


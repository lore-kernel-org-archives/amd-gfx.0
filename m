Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EED3B7DE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 07:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36A110E3A8;
	Mon,  8 Dec 2025 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAq8L9FM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D59210E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 07:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp10jfYwJb15oqzOqijnyvVz3cAYnMnG02z9HzoPGS5qcNHNtC6tKiq4LoaKBo1QlzT9NjBCtd4HAVeurulR5WqP1moccwtvSthyq9vu1+LEUn91TXN3m60YR/sYwvZzcRHXwobYYoonvAfUhbQ0QOv3KSiKgHSbtZZ0dfDI7blJSmShAn8RgVoPbf+7VeNSDBPsUTUQ1gAI5pK4cvvqrioq6Zpu5k/gsA/6f/9DOl6gif6Nk0qiSMr+lIT8JS8uWEbDR7JsQmSn+hvuaiLTwslgH+aGYuU6SQ1G0BfT4PcfMtBns+Zfrm1vmQw2gqCFC4rW93ZWACedndtzslerNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NtrvWkWNEvPTFTe4nLiJJWJnG+DPgP2uPCvW+zUo00=;
 b=hAOiMEyCZiUoV/VjEqh0+wup4Zlu2yaqGXD3NV4krRCnOKpFBTEc3sfb/TlvX+N9nqm5eXPWapkqOXf2fzrvpxIdJbfs3vRBp9fJz09gEtoQHPMqgYsqGJNxCjrIorOEs6n0HTMfygZI6CDjlVyROb7pgYo7oQE7fwkFABOKXkoZCCckKSeFU2qWqQqWfLioIimiovUTut9bBJIDKBAhVwdgc58zBSOzXadA3qChktvTFe1UxTUn+mHDp+nnc0utX2i8txcUmCrwXyD8dE26cwezOymY05PPxfdJVklbWKG3kOlDdsc3+A1MMU4/INVHp74I1jr/D6sMZXuS4mdydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NtrvWkWNEvPTFTe4nLiJJWJnG+DPgP2uPCvW+zUo00=;
 b=fAq8L9FMObeZ7XIm3oCNvWLBch2U/osVqo/CUEYybWYOtn9ZeuFhYx8MMaCewDDEEG8fdiNC+DSPgaUZZXWlLsVL/5tFFkqJ+Nl+MMmmiZX2zKAGBeqdOPGq9DLj2IPGLELADzzF5MyvHFIBWo4BDPnZauCiVJajQ5HbS9nLTYE=
Received: from SJ0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:a03:3a0::19)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:34:00 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ba) by SJ0PR03CA0254.outlook.office365.com
 (2603:10b6:a03:3a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 07:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 07:34:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 01:33:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Change set ip clock/power gating param
Date: Mon, 8 Dec 2025 13:03:36 +0530
Message-ID: <20251208073336.1381340-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251208073336.1381340-1-lijo.lazar@amd.com>
References: <20251208073336.1381340-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 76446e05-b001-4d82-5372-08de362c2779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ksZnR3XOSpjamqhy3Z65psa7q3Kfho/Zh4PpN/theF8rkXOmWu8e/eAGpFqk?=
 =?us-ascii?Q?RfBZpNRMRfMUInwsXSt8D/DkOhMYxDK90HgsffKB2SBr0OX0GksFCC7F0C1y?=
 =?us-ascii?Q?SUI1gwFwf9VqJ/XWCL15OIxDxmLbICDNk9sM5lGisYyvzTA4g/UK7PqOe7ck?=
 =?us-ascii?Q?b1XGLz/WmEaY8jiigiK5TCfYWZ67fg19ljDelu7jHlNeNMBbASWMa1JZmJpk?=
 =?us-ascii?Q?pS7/VCsovsnMUqa6ilKRAFHg7yk9HMjrxlYuqRt0YhFeiQ6LnFZCfhSI3wZW?=
 =?us-ascii?Q?R+zmPcMEZXQeupLINfhiVhdfuI9GdzBAdHTPvXqNyukzgduX3bMLBV1VgLSK?=
 =?us-ascii?Q?rtb9T/xOv0k0/RH1SNSYL6YD4A2ssjbIaShipMlTOjhxhO0n9Pclv9o2Ptga?=
 =?us-ascii?Q?4bOX62LFq8TE9JUBEinkoxSiaih9R0lR6X9dNtqcbLFxTHqGeZKR1jP03zlz?=
 =?us-ascii?Q?6A0BfaVu7q+UWdHOpe4NBE2XN0QV3PSITiw8zXGy6vIc8AEu7j0y0Oj6GIFE?=
 =?us-ascii?Q?VdmkTQ680C3624DoqXpRrsoSgTOo9vi5HXs51ki+iJ1O/ZIo5LubXDfi5/ol?=
 =?us-ascii?Q?0c8y9INP08LpNnmTfr5ICXCQCbr6YhV3zHtZ6XSnAqTpmAuxrdNejJtMTNyn?=
 =?us-ascii?Q?9oQ4lhwtrdxOTftCZY7TxqEU4U6MF2+0WuDs+GVk/C5nPxAere1RTyKItLq+?=
 =?us-ascii?Q?cKfAwhBKyr9lMBF6TjfF9RJTsncodz6aJESAzUEPiThQ3drD6PCQKuoJy0lZ?=
 =?us-ascii?Q?hySzOsyUvzkqjoGgh5USAgaX/pqZa4TGu/ZSXmc4/pmxkwN0fmZEz3k3yYf2?=
 =?us-ascii?Q?7rDmAlPcqAsxcT5NRoTG2KD3lQT0QT/DgBS00VU989cRpZ69m/jqcn+u3SKH?=
 =?us-ascii?Q?t1jVP90ioQS44x2MUFsiel8f9E/3jS7XJfZMo9yet91F7gik7QcohGl0svC5?=
 =?us-ascii?Q?eERR60JPMk+FScdPTil8dl6N+jbz/2RD59PgZMt1ENvWZ1zjIn3trFbvc5sr?=
 =?us-ascii?Q?+HKSu87t3zWsm3tf97be/dhOWE2hUsY5q8JsRhVDCD5BxvV5fBPDgUelp3Np?=
 =?us-ascii?Q?ktxPDKcPC9Git66thRnVoGFc7QGvbEz+vzQTxP95qV0btkyVIQqAJYcZ7+wz?=
 =?us-ascii?Q?C9dLNOtpz/JWTyGFaMQP/B/YvHkChVZ+Pj5imFzE2ZizMxTSMM00wkEiEEoS?=
 =?us-ascii?Q?vSgo6OvJv6j2BNqcaYJqQu9fcvIPvfy6QSfrTfRChCJ9DgMUXPzdSDK0RUwh?=
 =?us-ascii?Q?Rh2/1WpKjFUbpi8ge77SRV3eITzSkV94kbRzIKErNWoeTSL6PGo/OVLRlIml?=
 =?us-ascii?Q?jipc1eHOYNSZJCMsnazKZCEKzJmwIUGaIfbPFRSAJHAKPqw0V5D3PNCcD4gC?=
 =?us-ascii?Q?4688dbg7K7e0oH2jjphi4GiPkrxLNrQZWEHvRT5OaEjL1bwPtjMpXIXVBRdu?=
 =?us-ascii?Q?0lmD4qYbozyYlGIapyjKv3T3gCYOrAfyZnv3vo3gqk2yIZrMOJUJcG8Wsxg2?=
 =?us-ascii?Q?5Ongquw0KTlgWHes3NDg769L9zdWhehu2P+X14yY4Nrxgr91DkSOVkeNzDu/?=
 =?us-ascii?Q?MPSw/km/DwoaG0Mlo0A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 07:34:00.0567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76446e05-b001-4d82-5372-08de362c2779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

It's not required to use generic void *, change to struct amdgpu_device *.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 677f730e2654..6aa54156bbc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -254,7 +254,7 @@ int amdgpu_device_ip_block_add(
 /**
  * amdgpu_device_ip_set_clockgating_state - set the CG state
  *
- * @dev: amdgpu_device pointer
+ * @adev: amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
  * @state: clockgating state (gate or ungate)
  *
@@ -262,11 +262,10 @@ int amdgpu_device_ip_block_add(
  * the hardware IP specified.
  * Returns the error code from the last instance.
  */
-int amdgpu_device_ip_set_clockgating_state(void *dev,
+int amdgpu_device_ip_set_clockgating_state(struct amdgpu_device *adev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = dev;
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
@@ -289,7 +288,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 /**
  * amdgpu_device_ip_set_powergating_state - set the PG state
  *
- * @dev: amdgpu_device pointer
+ * @adev: amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
  * @state: powergating state (gate or ungate)
  *
@@ -297,11 +296,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  * the hardware IP specified.
  * Returns the error code from the last instance.
  */
-int amdgpu_device_ip_set_powergating_state(void *dev,
+int amdgpu_device_ip_set_powergating_state(struct amdgpu_device *adev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = dev;
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 77d1c642953c..1d0df6d93957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -136,10 +136,10 @@ int amdgpu_device_ip_block_add(
 	struct amdgpu_device *adev,
 	const struct amdgpu_ip_block_version *ip_block_version);
 
-int amdgpu_device_ip_set_clockgating_state(void *dev,
+int amdgpu_device_ip_set_clockgating_state(struct amdgpu_device *adev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_clockgating_state state);
-int amdgpu_device_ip_set_powergating_state(void *dev,
+int amdgpu_device_ip_set_powergating_state(struct amdgpu_device *adev,
 					   enum amd_ip_block_type block_type,
 					   enum amd_powergating_state state);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
-- 
2.49.0


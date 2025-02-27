Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B51BC021B8
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 02:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA2110EA0A;
	Thu, 27 Feb 2025 02:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bmSxXWax";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F83A10EA0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 02:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONaHFXig7qXYfOh/30Y5t5g6HrGeQlSPiHSFTOqYpdjdzsDiitBbXISCVcRl6vZYhw+X/NjC8wMMoOZsa5ffQzgcUembWtHYc6Xds09U47twwCs5Fl1rGjeBaXxmFMXMB3w3kfyqNbbP3dt5D/gU+nBwLVSMhDbRRpPLR38Qw9S+ic0Iwa4wztrcZjtdNBiH/lFVH14Yn5D1isyK06e5u4opKLN+jx5uCAkoY5aVtRLf21FaM5UK2LRhlPeKdtsCPVDYplp3LZRwtwXFzmqpMJp9TKb6uv8Lc1tPoJl/KLOa8cba7Z7f3n8A6Z1Ak3X4Z8dWiZPEb5WAr9O6//vIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izMhKer+8FlK4AkOaJbz6VJjRYAJulSOilq41a+zKmI=;
 b=X47ja8BemIdb9/MTrWjSILU3w5+PGSoHfcFnjehK2Un6cBC4VDwj5neENDvu37Z/DinZM9VIqv+c8YZV8U3C72BMgVTr2P1kbdNTLvHOnngWbKZCkqveiiPl4Y7QGxRBcxj9i2oJQInD6P47SyEmkkFucctlG0MpAIMYWngFb65fIaKyUZV5Btyo/TPFJvJI78EMpVri7TrmuxOnVFzhrPJQmQqqhmeOenfma734tSe3+jIeuyfDNnnOkVRj/PGBSb1P2McazOKOQYs66OQAHA1q2bAcrsh9F/ElhHNMAgpzgTFj6BSIPhQtln9+K+l3JZ6efAs0X0H+o9R6fSxArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izMhKer+8FlK4AkOaJbz6VJjRYAJulSOilq41a+zKmI=;
 b=bmSxXWaxg+zqIFnAvh1tvkUpQfO+A0jkHkPqzgtRsEzYMVMPZ/nkoUCXOXZ+MU+CiBRMM/nkyLHyXEI4W1vZ5stPeeIlg63QfxMaUErlZWuGKIr5y4lc4AAeW4HxcjijhMpemRjGsrFx7PtV+ZwynW2W1H6GN9/0rIYCuI5l2y8=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 02:15:42 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1f) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 02:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Thu, 27 Feb 2025 02:15:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 20:15:40 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 26 Feb 2025 20:15:39 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: add fan abnormal detection
Date: Thu, 27 Feb 2025 10:15:36 +0800
Message-ID: <20250227021536.523386-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0af060-5499-40c1-9622-08dd56d4a26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ew4iL56APHqabMlEKdgGu82N8EH8HslmhuOzVP0gcsu42e/K+bO9ZwiENt3l?=
 =?us-ascii?Q?Qv3XuBaUbOihrVKp94RzzLTp6Izqiux5IA90+iBMfqSEHQdG2FHvmbKh08q5?=
 =?us-ascii?Q?tpP2r8TtYQBg2Ke/N8uL5xOLlECQESY3w878Q8F4F10diAW5+GpkH8+giCLQ?=
 =?us-ascii?Q?zy0CS99gh60+A9lmuHJ+DX+SHNbzk7FGbrTsMWXe6bvZaZ6hVgMCXV+Htsrd?=
 =?us-ascii?Q?hoV1f8+JkQ18z5iO9XdTCxKNt68+50urdEQdo8sEyOHcFEucndk8A6Rrv5fZ?=
 =?us-ascii?Q?sk7jd2+hrTeu4vxnLZ8J4djEdJMPl5rICXAhh3wiPT4YAi/2Iw7RPQR5KkOy?=
 =?us-ascii?Q?qlIEe8zKgM24BO8CwSeFpKntGmn+fiyme7CJl7oZuzpVzYRru6buCUXTrxxz?=
 =?us-ascii?Q?cMuVpFqWLK7dG+NxV65xfSY1IK9UZRms8rDZfW1Kl6RHPf3i5VULei/8LwPR?=
 =?us-ascii?Q?h/KoJbB78QvXq7S/80b0nCas6E9wCaLTsgD6m8aLgxVRivfUmLwhJPM8Cwco?=
 =?us-ascii?Q?ZVaP4olITwx3Fj4DvMFKiSEzX5Vi+vTvqdJvOrsgL6h0snokUrfKo2X/RraC?=
 =?us-ascii?Q?5OeQ4MqHu52cIvaspLw+mbNeLU88F/nfiTAreNSbMJp3gES6O9klO9a6EvAl?=
 =?us-ascii?Q?icOwZOFtMcg4nWLDRQ8i6lU9NrjiEv7AhcL5ITKYhNqnufTpFCSPROp3SpUT?=
 =?us-ascii?Q?3P4eGydwPjfyOp/8L8DINgIkClsGNTW7Mi/CqkVi3Nrbo6ltPlJ258cgbAZA?=
 =?us-ascii?Q?Y2lGhAxYVPTQbHsVaAUb+3S2e9kHrOvHfr18R8ZBeJkb+bKirr0DNtKJl8Qt?=
 =?us-ascii?Q?tcXRQLlEQkkJDAjesmlkebXVnfDqWghvA6+iKEQqToEpSPMZD5pWNHfQcMie?=
 =?us-ascii?Q?MFBz51I92gBNt63c2toH800kzkBpOchErYOPlH3TD7+IweJBB97jrGBhhJuw?=
 =?us-ascii?Q?68MPEfD80LOT8LLKh6ff2tFqx3CmOES0cY7d6n8/8GorLsTck2L7uIOMTWCR?=
 =?us-ascii?Q?b0RN5w5cv9INtsc82zpFVOOb8JGrxK3cXGfPhCPeNSXY2Byx07FdBD4LgqKW?=
 =?us-ascii?Q?R3J5HYnpMi6ZvJ/pSbm3SFL7MczwJzmAFYsXNh7LN1f+kcNA71FCgmT4wwFD?=
 =?us-ascii?Q?+BVeBaB/j8O5VD/whWl1SKtrr+qz1AHrigslxlvULkyc+0XOuQYfMuzPsFdT?=
 =?us-ascii?Q?5R85SpALqN+gXUYO0ocWQqbBFWkWqGmZA97S2pwlnqnVyZ/aTioYR0OOmhyC?=
 =?us-ascii?Q?zw/F3P+0oc6uTM5nvWa8TdyX2sjSxkomABY1UaalOt7uBA8iEvggiY9rnQSg?=
 =?us-ascii?Q?FZ3cA0XmM2LdtGa9tLkTsWTGfTbtR0mf+r9RFq7RzvE3DsLgq/2Gkep6OB34?=
 =?us-ascii?Q?BR8uP09KP7CS5QG0JuQ4UOSJD+tkpNcLdFvBKCYBPWj9hPbcpQGdD818igb/?=
 =?us-ascii?Q?dfG9Vx8kEjZZxUpRy52r1LXqzgerJX4lzSkMn5cDBZh6NT1bB9fajeFzXsrT?=
 =?us-ascii?Q?E7tn4SexIHFs0MM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 02:15:41.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0af060-5499-40c1-9622-08dd56d4a26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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

add fan abnormal detection on smu v14.0.2&smu v14.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index adbb6332376e..14a5760082b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -950,6 +950,14 @@ static int smu_v14_0_irq_process(struct amdgpu_device *adev,
 	uint32_t client_id = entry->client_id;
 	uint32_t src_id = entry->src_id;
 
+	/*
+	 * ctxid is used to distinguish different
+	 * events for SMCToHost interrupt.
+	 */
+	uint32_t ctxid = entry->src_data[0];
+	uint32_t data;
+	uint32_t high;
+
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
 		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
@@ -964,6 +972,50 @@ static int smu_v14_0_irq_process(struct amdgpu_device *adev,
 				  src_id);
 			break;
 		}
+	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
+		if (src_id == SMU_IH_INTERRUPT_ID_TO_DRIVER) {
+			/* ACK SMUToHost interrupt */
+			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
+			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
+
+			switch (ctxid) {
+			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
+				high = smu->thermal_range.software_shutdown_temp +
+					smu->thermal_range.software_shutdown_temp_offset;
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     high);
+				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
+							high,
+							smu->thermal_range.software_shutdown_temp_offset);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
+			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     smu->thermal_range.software_shutdown_temp);
+				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
+			default:
+				dev_dbg(adev->dev, "Unhandled context id %d from client:%d!\n",
+									ctxid, client_id);
+				break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A27CCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 05:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C8410E1AD;
	Mon, 15 Jun 2026 05:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8QdO/SX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F2910E1AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 05:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4KkfrywnGUOCnDnip227MYhPyrHtMmRJXtrloB7YFUrh0pozHw/LYcrLxiSC74gobrr5ZuMQuRvEsPJz9qfFTojjKVp8sWsK0dv5Pcx/hHY2yVVoKu3C366SB1e3dHxVrd9jKfDi2Ts3SwvmmLOPCMqkFatVoQHanQ3TLeubtPr11MSygGJKu3QXemYDq94u0ktQMYJJC8Mr1KUiNSuhziNCoJu+yFpeLldoi5hWtXP4rxZDcCzZBpDUuPEX5l9xwF1ZN0cwm06LSlD6ra8Yu75Qh2ej4yd8HkNji4/O5QAWpCjJLhgoQzbUcBvKO/6gcNgNrwkHbSKbzLCbHfK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI4RrWpgFdMKYvptI2IX0zUqhl3Sp1Ak3VsnPOwj914=;
 b=fd7C/O5Czkz3dkW7+iQ7fEVdsvalYOARQ311o4P4rrmX8JHqY5hTCoDKcHt9F7itND2o+BRzUrDwv5NhTjPya0RKyiWN3uuuOY+nOJyrBqQFz+tBilb7u2X0Gk7ZzIsw/H2KxHkCOS1Wabe1o3dtgM9wU0tAP5e3wfXMykv7rPpz7zKq12w0OLMHLMLCkPcTjflBVyJTsovwTjI99o7zk2jbsB7lk6LCUZk7Kq9LcuDsL8v+kqoDYIaLSJaFRXORBkrx44JBveXf1k0+22VmyEcIabVftpHPz37zNSZKzBYWwU1GjzE+4vORfkIRmPaPnK2Gt5p69NQgrv5hAc1FUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI4RrWpgFdMKYvptI2IX0zUqhl3Sp1Ak3VsnPOwj914=;
 b=f8QdO/SXtUg/NOdT4wpCOZig26zvd5O+CD8ss4ReWNW76Qs6pd+AJIXHitxPMp0agtDEonpaAfJF49/pO80kuFqzseteDpBZzTJREGFogrED7RrXV1SsnxwumDCHb7D3oqpC1cVdptkLavhs2fxsY3ANgdLhO2EfXJXOJ3QkZsY=
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:20:52 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::47) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 05:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 05:20:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 00:20:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Validate ATPX buffer length before use
Date: Mon, 15 Jun 2026 10:50:30 +0530
Message-ID: <20260615052030.42134-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260615052030.42134-1-lijo.lazar@amd.com>
References: <20260615052030.42134-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 106c0b31-b483-445f-6263-08deca9dde2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: NcvhfmYxOI+hbDXy7bXfE/V8dqow2ndONeGizkKM8CsKtlEG3ntR6RE9c//g6g7YW7ROrhEphHaLVg6ysUbX2ABycafofuGMa3et2q/8SUwecHaqhrB+78eKl8O+75GM3+Go+tK4YdZuR0N+n3hvCWbpiiKvbOjnH9lQaMXfVXQJYd9txCjrwpuhdeT9a3Cz9NLG2FDL2mRusRaQylj7bZvrMN41FmJh+NIzRySZp+wmKHlkgKHyaynDaK9Alf7LTgzxXENLBWTfoFk0W96htq4bl/pFd0SNcwJXDVhVT/rYWNM9h8D6CINmOnOn7hiOuqmtoM0Fa3SrbDWfofUN9q4NbG+cPn/0b1Xofm7DCwnuPVPjGSydMf6LD46fx8EOpSUb4MQ/ljFNUrTjqfOpXmk75K0Nhbw0mUlUgZeLoRlIjprRaaAcJ+t8tLFPJf0Y2RrIYsk4kUyiId9PNR+f7EDeLVxedm6lL8IQZmmxnpunYyKs/CEj5Erp3+ZvgyAesPj1GRIAlsJhj4JWPei6P/BtXthDCb/IrNJWJh3yyEc5BVd66Xhv+nwmm9oGXuVM2GkjIR6X33GKXar6MByFD0Mc2rn86lCBFGi26QrgOtldyviOXIEydMnshN41IkujEgWV1S8oAmRnqm8y8HOfFDvyvMbIfhmbEuRxgipPV2iEqvD7ORFyWYGEJe3OjKdcsfapYZFJwsNzUpeA/3aAH4ZWGdK7OQ9qwO2+cujJZbE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pMeVcpM7PxCZIbP0kThe2Hxu8vvBz/lSW7/EsKh/XD4Z59/cm/+UxJu8ALDlXRmS1ZayIJ4MuQXEF4kY355LlBLb9XpnLFAPwkSzIom251Xa3+vEEjTsBnXTXrDK1KTbTzf4/xDp6ejdwVMHdKPZ+MsOGaCuqikkmA14ry2nQN621hxZ0IBaEqqvQqC+cedgpfjQTwuAQDXBc7dIjct2Xi+7zc4lPU4AVfFbCAQJyN2LWc/PwzoGWsgJXnx078ufkUhZkbAKjpijMi+s+JL3ifx5BztZtJHxYBtD5I68v2kK0AP+1U91LXmqABfmhMDpYvgc4uvIzwo9tXt2hWfo6+/wAXnfParD1M47WVZE135DftY+j+31ZqV9iAS0P1M1Ah4h0VloAOoD38VvlxeLpNZvynAHcMa1Tb7VUNHDm+ZI2SmZxtxT4b47aUErO9wv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:20:51.8935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106c0b31-b483-445f-6263-08deca9dde2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

Add amdgpu_atpx_buffer_validate() to check that the returned ACPI
buffer is of type ACPI_TYPE_BUFFER, is large enough to hold the u16
size field, and that the BIOS-reported size does not exceed the actual
allocation length or fall below the minimum required by the caller.
Use it in VERIFY_INTERFACE and GET_PX_PARAMETERS callers.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 33 ++++++++++++-------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 3893e6fc2f03..e2a4644896ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -89,6 +89,15 @@ bool amdgpu_is_atpx_hybrid(void)
 	return amdgpu_atpx_priv.atpx.is_hybrid;
 }
 
+static bool amdgpu_atpx_buffer_validate(const union acpi_object *obj,
+					size_t min_size)
+{
+	return obj && obj->type == ACPI_TYPE_BUFFER &&
+	       obj->buffer.length >= sizeof(u16) &&
+	       obj->buffer.length >= *(u16 *)obj->buffer.pointer &&
+	       *(u16 *)obj->buffer.pointer >= min_size;
+}
+
 /**
  * amdgpu_atpx_call - call an ATPX method
  *
@@ -179,15 +188,15 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 		if (!info)
 			return -EIO;
 
-		memset(&output, 0, sizeof(output));
-
-		size = *(u16 *) info->buffer.pointer;
-		if (size < 10) {
-			pr_err("ATPX buffer is too small: %zu\n", size);
+		if (!amdgpu_atpx_buffer_validate(info, sizeof(output))) {
+			pr_err("Invalid ATPX GET_PX_PARAMETERS response\n");
 			kfree(info);
 			return -EINVAL;
 		}
-		size = min(sizeof(output), size);
+
+		memset(&output, 0, sizeof(output));
+
+		size = min(sizeof(output), (size_t)*(u16 *)info->buffer.pointer);
 
 		memcpy(&output, info->buffer.pointer, size);
 
@@ -258,15 +267,15 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	if (!info)
 		return -EIO;
 
-	memset(&output, 0, sizeof(output));
-
-	size = *(u16 *) info->buffer.pointer;
-	if (size < 8) {
-		pr_err("ATPX buffer is too small: %zu\n", size);
+	if (!amdgpu_atpx_buffer_validate(info, sizeof(output))) {
+		pr_err("Invalid ATPX VERIFY_INTERFACE response\n");
 		err = -EINVAL;
 		goto out;
 	}
-	size = min(sizeof(output), size);
+
+	memset(&output, 0, sizeof(output));
+
+	size = min(sizeof(output), (size_t)*(u16 *)info->buffer.pointer);
 
 	memcpy(&output, info->buffer.pointer, size);
 
-- 
2.49.0


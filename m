Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB78C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5FE10F3BB;
	Fri, 21 Aug 2026 19:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cZHgujtp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA76210F3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8mZyjb/HYnF7I0YgjgtZLk/iY8PbHjWb2/LoR+vea7q97YVUi91o+QkqwO7leSYrgqiFw8xJy/flQ83SP2jFEhd+PXnW2Yz+bcpN/mhQiJizjiZcaNl7Ia+ViBu3Y+fjeycwAhMehz7uPmM+GgV29DDS6kuaUFspmMNnEQgkzgYw1fdlImFQmzyRlWGBVYtSn4WrUZQnpY4wJelKW7o24s+scJArLq/HqmG/mKrMy3IL50TyagCKk5ESPJR8Ma8MJZjBnmLLjxNVE+HDY0fGpqK0t1eczSQYShBN0KIBE1lTxeSCgy9PJSz7ntCac9KjdB6fudkncOI/NB7Rqsd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTCL/vnbXuAeUqhzVMNRdchDttGi+ZNXwmTR0nbdBNc=;
 b=gLNUy5zFnI2z0e/t4HQJ5pX1ivDSYxkMgRB8oJdOpMDlGJKKtR1odJcGuEDvk70MvMlFUgrkyAUkY9U6RmwJsl/6h8CjYRLZ6D3PxAhAgVNajyRRQQHiumTwejDd6Sgv8Pc1go6Xuknbd+KLq1JYsTrEq/PP+6AwN3NY2XltJ00Ga8wfU3bVVV9Qw9aSPC25x/eMlbhkcsQB2pOzJ9fbUCXCWEHCPZXil3YaN1AQ3wwum8I0IHkWSPRpi8wa5teQN3gNbhDlILOi9DQCSwFLdp+02cQSd8oFL3wXMhWiK2LyUYYGzhoA4bnqWILSYprZMlSAZW47vScnnLF9hVKyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTCL/vnbXuAeUqhzVMNRdchDttGi+ZNXwmTR0nbdBNc=;
 b=cZHgujtp9lGrjmkJQ9Idq+EU2JP9xPLKVAQ3mHdmCIELQ6yFxwp0cuqtafrtRCk9SzpW2RRqQ6AF3DXUPpmEWmDrtk7kjFpiaS14zGi55cJlxVbIVpi7elMUFknbe3GYpDadc6JzAQm0pQ6w4tjNcS2/XeMEZicBgpy+KnfAeTA=
Received: from PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::17)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:14 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::50) by PH5P222CA0003.outlook.office365.com
 (2603:10b6:510:34b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 92/95] drm/amdgpu: Handle concurrent UALINK handle import race
Date: Fri, 21 Aug 2026 15:34:55 -0400
Message-ID: <20260821193458.808626-93-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: f86df72d-4979-4dc8-4e36-08deffbb760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MvLRkNRoiGnjUxmA/x1bARO2zj27nrzEGRuoXepayYJoWDWJBV8kYOzDgUMHNcLomylgtVZC2WK17aIOwQTWkXXO6aHFJgx02z9ajau3oZ8bacdmWbuMKW4XPZ90dZUfN9fJ6aPX0FxPsuDYgb2zIkekiWILkPv4Bof/QLWlpVekCIDZ/BdMl2WnR4drcF+K2pRS8v6+TAeW+mPDSQm/kOiQfdD6YDttr3dy64xT2b5CzozjBQSkLPPwhAECbIKPN6Nu21sN4O3mH11pv+QcxEC7EoQnmiq1qVdJp5Vl5EHJUNM748TSgQqjWOUuHXiyRRsAPpepp4iyeGcA9VeM+a3x5DSam6hoHFeN5fYmMWL0mxM3uMWyDjv2g0HptbkeuzKvIM43zS8Wp6T30NiNmLarW4OjmBERJb4i28cL4K/dm3ZeRw5Sz+7o7+PwgGHs+pA/RO+V6l8f9OncdiEzBZEBJMkGYxny7ubLVRxHCeWtV4hEu+3hatMVumSV9wos//mC6rdk/wx+y06YPHVxhYlVRFLkNv+7Ynq+CThZc7ivkBa9GQtNVC0T4iAWvFjz1cUbfoOmM2oQswGlv+3xSJ+55L7v1oAthm89a2VX02VT5XiPiIIoYLzCvOGOk5pt7IN5q3fL5fBSIJyfgClSkvWtxejUbfZtRBuKihwDOZfaB4ylIigWwdrIbj1g6nYdJgoEDwdByXZrEao+YDpt7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 39LEx3zTMzQihRG0pC/pc/zuWLib6iDgHsanplpirShSprthlOjHvnQtfKkzYlyet1kIv0XASEFPzMkZJM19BpeOVn8sGHLcmVH+w5FVB8hTxW5el3LEk1IT3pudueNN6OAnaHR3bfx5aZkxp8qpfGD8IUxWI8j5cUMH2yQEA5TSuvEIHJlJkmwI0EBp6bu1Zy5j5QBkbIdwYTmI6I5U8wDkQEgkEc7gpBG9cNK+fYVfLCWG09sGw9e8rXQTEWlNr0B2R+rDQIuUbciZNSZ3VwVxCMfDEC38X3dhwaVFkOGnDHoIrt9OrRXkIFq7p7CdVNRipC6MfKI0ZSOZPYQcokCdacC1RVq6NZNlyztzO7xuieGUx31F6FyfU6/J2SnvtWwopbinRhX7uEyJdVFH7yubCSYhLb4o6iC2OoCYlshEboHfsJISpmL536Cwcwhy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:13.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86df72d-4979-4dc8-4e36-08deffbb760f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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

From: Mukul Joshi <mukul.joshi@amd.com>

When two threads import the same UALINK handle concurrently, the first
xa_insert() succeeds and the second gets -EBUSY. Convert -EBUSY to
-EAGAIN so user-space retries instead of seeing a spurious error.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 765105aea09e2..444b0e29ee9f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3807,9 +3807,15 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 			      imp_xa_node, GFP_KERNEL);
 		if (r) {
 			kfree(imp_xa_node);
-			dev_err(adev->dev,
-				"IMPORT: XA insert failed for handle:%llx:%llx err:%d\n",
-				handle.handle_hi, handle.handle_lo, r);
+			/* -EBUSY means another thread raced us and inserted a
+			 * node for the same handle. Ask user-space to retry.
+			 */
+			if (r == -EBUSY)
+				r = -EAGAIN;
+			else
+				dev_err(adev->dev,
+					"IMPORT: XA insert failed for handle:%llx:%llx err:%d\n",
+					handle.handle_hi, handle.handle_lo, r);
 			goto out;
 		}
 
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2E9EEB59E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 12:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D645210EB64;
	Thu, 12 Sep 2024 12:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J+dIHh4r";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996C210EB66
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 12:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7v7irctEtwmRV/q0smQY33NUNq9KsJnItq4jzKlDg/MKFPZPf+V7gun9NOcIOMvzHhJ153M9IikOdic8G/LlyOKIflygFKyrWeicMIFlayFvV6f3IxX8NUDYX7eyuIKsisxa7dcerVGHnZbVozDiqPvNl98fKibUgUKtGJO2j/zBQ8vOoKCkFgdq9qJz5SvoRZuzEv4xA9N2sC9mzLNUS0i6xW2IkXYmuLM0zPWRYySLyhK+twIh7bLSKJCt9nYoTqpNdqqOekaLdI24H8X+dNCjYDK4se0fqXaV9KuTlK5F5gGCn1Sm4sSoBlbLQ0Np5XQgh0eokKsbRKubu0PzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZbqmCEOGmDQAX0yLewaWcxu6JoRyvgdTz16zr3MUh0=;
 b=i8vhkWAIJte+zImYWPfjx2naOE50zEMaDGFl8H6UNLaDnaHuIcMKXPNeVsaBxo1EI1L0ipcCwGt780hrx3czKjCZWpAc3pHIHIzmS8rqzd+/3WlR3PIwc075EOEYok+drZZVKSnplzVsx0BtdXGC04wEMoW2v4XCfdLxKdS1RY6V4/xTXE6lEGPlXz+qj8GfVylqMuBKW1abt9oeA9Uo8JPwdtnq+jJRTmw33TgOfQ5+LpPTNVSIYT2H9WvnF8SbR9TmSTN4wr5hla8O5MzzqCwJhNQ/21JFHg2sj6uNfOVpjC9M+1gEjB7z4J9WSatAXuYvZlwgen6oe8tlZQ/0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZbqmCEOGmDQAX0yLewaWcxu6JoRyvgdTz16zr3MUh0=;
 b=J+dIHh4rLJMn5Y8jLdT+XjAeo2XIUCezXO6MH6U0f3Bh2d1Cn7cHwEneLRUSSy91tH6d0/1Dl73YhoailXhO6287oK97AMjsOtBT81q0d00XECOHBpO8QvUT/dGUHHdcNjTWl6AozutaD2TOQYp5hNXzX5xvu7GTDJu+01d9W60=
Received: from CH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::35)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 12:00:19 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::be) by CH0P220CA0015.outlook.office365.com
 (2603:10b6:610:ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 12:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:00:19 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:00:15 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: Fix get each xcp macro
Date: Thu, 12 Sep 2024 19:59:46 +0800
Message-ID: <20240912115947.2208807-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912115947.2208807-1-asad.kamal@amd.com>
References: <20240912115947.2208807-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c93ae7-63a4-4c9b-850e-08dcd3227900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xV8IadVlQLd+UrHNNiR2J0xA5lLhB2iXyq67l7i0UZVT8tMYMmmqgtNTlVLe?=
 =?us-ascii?Q?f+DDYOrAFc4L8uhuQkkCVAPYSYjMIHxekkmrWSCRTOnkqzehqiaHbH8RNB8A?=
 =?us-ascii?Q?OxQZd57ADuTKlHvdLSJxr1wl4jGcVnFj+eCXKuIf9xmbf2axkTxoZF/T/hIp?=
 =?us-ascii?Q?nYsdQziMpH2TRLSCZlKzgnN3CSk8XTUjhkogtN+k1R1h+Prln/+3cFxZxVsU?=
 =?us-ascii?Q?read4oezhcfk7YIrb76e16wQoZ7NszgqZ2Wc2dMSGONhX/Wrmm1xprXFZnIB?=
 =?us-ascii?Q?JPvBvOwnFmOxf9kHfdTA8uvCiq4sL2KI2KrJQxf93Fqa3/p9d8/um9erg8u2?=
 =?us-ascii?Q?/l3DVwAZ0Dz3gNWo7AH8EAL7zG0ecePLSLuyD0bLWZ4xOQyyJ2fv7Am1zsCH?=
 =?us-ascii?Q?nm/9FZDamX4Ks2TlfeOngUzkUbF7oE5N3soLWzGsf7wbTlXt3F2XjqSAkjSc?=
 =?us-ascii?Q?mrJZyxnNZ7D/qvKMQY4ijtdyhJ+3YQNok5W08VUPtxFbPD8S5eH3dMS/up6v?=
 =?us-ascii?Q?w0BJXQ4Jmesj95Yih74IVaQEyTBY5P75NM4vYcQYIs4nsCgOsyZZtQOwRLMq?=
 =?us-ascii?Q?sF8opq33zRBEX3pSKSnor6dtPgw2pkq7eVx+xRcu3h+GAPkOmzQzluW3WMJN?=
 =?us-ascii?Q?IIuXV2qXmCuL6Q6eyBpWBT7JTelBGAP+on/FDXWnfhNwYmR3CEVYxW245/vl?=
 =?us-ascii?Q?45HPQsA1WAIuXKSVWzEbW5B81La4rgZ/h3+RmRYZqEf3BaNwwD2qfPFMWKio?=
 =?us-ascii?Q?8ILNvBo6H+wl/AC0jH15PhHaaOimJCqZ1Ua8l+GRlmLbuPsFmLjxU9JCe6eF?=
 =?us-ascii?Q?bqssTNdNcFB5MmL1hzSQ6fP3EwAd7oR8ItCQcoGnIEQ6Iz8MsgL2rqU8P+Np?=
 =?us-ascii?Q?SQ1ganZzTTvWXO5mMOmZBhTVPiBBHJi9Sw2q7eCZmeb0RAxohNdCf+QVjejZ?=
 =?us-ascii?Q?JHGw/K8Kb67RAnHHZm6zrTYhdFc7RkfNiJ+4qWohP4uCD2Nb/mtQ/rj5nNIZ?=
 =?us-ascii?Q?0j1w/J0edxTOXeIRnTBtxTWeafo7WIh58HrjA+WDODXLaUTp+8k2fg0kKlHI?=
 =?us-ascii?Q?yMYfR5JO5dGFTfgRTWy68KupI+GQhspL29iz7mOG0oMFHboSgecv87/6AmTW?=
 =?us-ascii?Q?sastsZ0bI0iKGtg7FI52n+GmqgpLhmH+cKJa871NM0al/QEivPaVavP7mHwu?=
 =?us-ascii?Q?CWmbZqWyBcxepvDQZ2g9Qii3BValgE2/Q15kf6jVUc2Nhm8ceL6hiaQBHR6J?=
 =?us-ascii?Q?Ee6bpU7mCYp0yFFm+t6bz45iuV6KNiul9Xx4hUye3F5xfHkpNcYRc4f62hHR?=
 =?us-ascii?Q?3UBC3JnUmfX8hQnRJh5QA8dnFQV7OvrZ1bq3rGQcSaQfxKgCnA2kCjL3cliT?=
 =?us-ascii?Q?A+G4LwW6h6YvAe5pu5vjN/joQIhfvPV9DSFv5EAiExHUEN+29IXTqnarKPKA?=
 =?us-ascii?Q?hMQEuRctOZmsuNHkOTSrugG2eOK07AtZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:00:19.0787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c93ae7-63a4-4c9b-850e-08dcd3227900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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

Fix get each xcp macro to loop over each partition correctly

Fixes: 4bdca2057933 ("drm/amdgpu: Add utility functions for xcp")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 90138bc5f03d..32775260556f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -180,6 +180,6 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 
 #define for_each_xcp(xcp_mgr, xcp, i)                            \
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
-	     xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
+	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
 #endif
-- 
2.46.0


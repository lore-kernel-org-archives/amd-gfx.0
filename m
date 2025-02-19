Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013B8C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 04:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AAD10E1D7;
	Wed, 19 Feb 2025 04:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Nk6fnLt";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C81410E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 04:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVDIoqz31ubG4BNNBNadhdJN+WEfyPHppFP0RfNBVntAVSJyDpdWmTf9lSjgiQFhHNHw1JZOVa6e7mluQapkZRogdlQvogR3tNDpp9IBQRmu96Nu74Pz6GWw+jhh4iXOKnD/YLlE+9urxfjQrZoyrpEcLeJFeRYecS4x6A2uj5werwBIva2l7s83sZUeLs9EBTZ9fFKoJjvEieSyYYE13zBX13o1PVRbc3UEz/x6w6lw4bfnZUnQg65ShoAlBLn8RVDCpnsS18WTKSH0xVOZAZhlR7a7oWDgzmQrAJQhQfmCQoGUJEf0KT+hyZuFNd4dk7Ko30o+FXQVXHp35F9zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3ggFpQmudHR9P8whEW/c3LzUg3hbad5Cq22D7zQVF0=;
 b=bHt4AQCB+m16o0275lo/lEflijg7UfBW7jacYdo7TMYQM+3Ws/aPCtThQuSttJsAp8Se+/c1W0JUUxAb3M5pHjyApK3KK4D4SQ8YZ2kA4kWkIgkcminPa6di1OKwgsdinSM8TvZkfhVca5UgUiNt70YA0mnaLv4CSP7QsIraZweKF8lwEjQDAjsI6v8qVYEuxFgZqtF98laJ4tNAYH+LGXlD32XCVBpX/Wka5tB/3xxIpRS9bZutbhOucOHb5/HJ4baTABXoMVQq+Gbh/vq6xEM4Av2wxG2drOqbMl+qOCwJKkZZQEmXq/4kJ9TBM5dhYQOFCHYb3QZ2ripHWkr/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ggFpQmudHR9P8whEW/c3LzUg3hbad5Cq22D7zQVF0=;
 b=4Nk6fnLtwdJSglnagKjNbnLuHrRL7tbbgLabb8XaX1WVYAO7/iCtdDq/k3YILQ/nhGReTZwaBUw++yhqLLEaavef7XHlMRN2HlbfHm94CxFIKRnBqWqg27JbWo1FxN4QDQtx/kta3e8ZTwKQCKnsWy/+PsjNhBIS3WedYRnB4Yw=
Received: from MW4PR04CA0308.namprd04.prod.outlook.com (2603:10b6:303:82::13)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 19 Feb
 2025 04:38:18 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::f4) by MW4PR04CA0308.outlook.office365.com
 (2603:10b6:303:82::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 04:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 04:38:17 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 22:37:47 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kees@ijzerbout.nl>, <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, "Xiang
 Liu" <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant check of adev
Date: Wed, 19 Feb 2025 12:37:24 +0800
Message-ID: <20250219043724.717663-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: ed996586-3362-403d-724f-08dd509f3b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aHlWdNaAmLtV/IusYDnayNihmGIh9XJz1BUkYgxnGOfMiNbFMYzQX3epO4U4?=
 =?us-ascii?Q?fbBloiFnO2/pOF6QmIyGkScWkXffcwjV6eJ6xGs4+DMKM3SthsvmcuJtZ/t7?=
 =?us-ascii?Q?+MXJPCjL5hzKsS2qgRNrnIj7dnzzys8eIcAqsDOrpX26KjAFMRBI+Zn0+XUo?=
 =?us-ascii?Q?v0XJjt7h0NDNZwbZfpCnWblkeXm7KJq9qn6SOgOsHAQTrcMAy+OxMHKIw0e0?=
 =?us-ascii?Q?caUuX/F2gQ6h3mvgbIUctRRohEQmeq30xDKq6UeRd9zy7v0QOcsTVazBV15K?=
 =?us-ascii?Q?hnCd+9Onybjfqw3vVvc+g77m+P0ZV7MNuzhm8vXU2/QF/cPL49dpLld3BnWY?=
 =?us-ascii?Q?1hL8jFcFOOtI4rrzNBMnAVr7HNK0vrZtMz+iF0roia9kSWDwaPyU2Wx1UJBb?=
 =?us-ascii?Q?qubZtuDt01ee9xIBMHqxjtUy+Qq65REbX34Lu3BcM9h9ehUEr++uJ0zMFDsM?=
 =?us-ascii?Q?/aSWGUpSyONsWD0BCnf5R5JGqwSRDFXHeGq3CwtsOCXNmKKnTdFGtG7uxJY+?=
 =?us-ascii?Q?g+O8IKdYqWFRnm9246F2+YL52Iz0jOQxyxK0JeQz6YtnIgrYn7sgTvttlNeF?=
 =?us-ascii?Q?GXINaVtuEyCmC/tAUONu0MuSD+N11epNSbgEtP4tt6ZH2z/Ea6also7dFdRr?=
 =?us-ascii?Q?N2SdNCPjNH46L8xPZRJKVxfumV9ipSkfx+QIe4KSSmRc8sGvExLUK8w7KWl8?=
 =?us-ascii?Q?+hzVxgKsUcME8MZivv1C9AgIwbxALPB5xKH1Rtthdy8ewlxLUtpHPx7imSPX?=
 =?us-ascii?Q?pkiCCCBGpTPMkXujv1KAP54IXfkDIQYoSFww0FzSQOtxVox1AgqaVO3+9onK?=
 =?us-ascii?Q?lD/XS38j6etuBalr2VyK3SkGOvAss4lqSbzHnfYjUmJvQFINlUqB4Vw5yEJ3?=
 =?us-ascii?Q?tcYMIxYahh8BtIA3jvAzI4DV4RgjKlalvoJbK8F4QTqHpPZiO/NfheZ4iWA2?=
 =?us-ascii?Q?rVoJnBKqTIepDti4gcA2pzNExn1gr6Ag869X+3kRMhnfPBMv7c4Qps2PO9VA?=
 =?us-ascii?Q?38t9QEqzI4Y27S1KeNQf7lvMPctsBBvaj8JGytyeC+0Iulwgg0amS7+/aAZa?=
 =?us-ascii?Q?CEBL+hN2xb2sw+CRWUe+DhQJpJML2uco/DiOvpfmfLRHlXwX/SJxAsx2yeJW?=
 =?us-ascii?Q?4cvHMZM1//CIPkRiy2NHzT7p4EKq8ld2eSXVWqLrm7C8Ta/UA6UDMqp/QOMC?=
 =?us-ascii?Q?DBBY65eOUptaHQOHxboltqk8wjEE17+KrSZsJlZRhIVrWieFCbyEOmV50Vf0?=
 =?us-ascii?Q?4p0+/EFDArncPz4q/EQIlNTItBZMFJVtNSNBv5fDAiaGg/Ot80oCDT6DPs9p?=
 =?us-ascii?Q?1aUjGM5qSbmEiawRtSSO+8Fc66Gqi2g1qzsTqHJhXiHtnNlzE+pZntXKYIsh?=
 =?us-ascii?Q?Nl4TfQUMYUmssvDXFcmhNp69OTNR2BFemZwqq2WfWEhOdPWN8fEsdP/B5Q38?=
 =?us-ascii?Q?L3xVBbfCaT4+txSz7N+mLqAi9io3BRRuMH5lYT6FmFMJFxxbABfr1vMKesBm?=
 =?us-ascii?Q?9U0cd1LWjSMQqhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 04:38:17.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed996586-3362-403d-724f-08dd509f3b0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

There is no need to check adev for sure.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c0da9096a7fa..d11593cd1922 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -392,7 +392,7 @@ static void aca_banks_generate_cper(struct amdgpu_device *adev,
 	struct aca_bank_node *node;
 	struct aca_bank *bank;
 
-	if (!adev || !banks || !count) {
+	if (!banks || !count) {
 		dev_warn(adev->dev, "fail to generate cper records\n");
 		return;
 	}
-- 
2.34.1


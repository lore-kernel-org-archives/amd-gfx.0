Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228DCEB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 05:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A2710E2CC;
	Tue, 18 Jul 2023 05:14:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BEF10E09B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 05:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMa977K5pP3jD0PHuKgqjjCSvY7b2EBubStR6PPkT1a9RkZLe8cqB/VN521e7ZlcSniTdjZWGCuID0W3qRDZnWyUVYkXRZDnsgwcy5QDA3NVWdpTmKz0fy+W2YBcHTBGPDGyX722jPzOFtj+qRM/6oT7rQcgVOTeaqUYMqeT3kBXCj9kreYcou4NhzRcjHzCPqRM3GsHb2XSaErVG5Zmk+yHCGkTijqzpv6fN3ApdEih3NmtwcuNYSukNFI+DOuht5pPhQy09YuhZhLi9ETv7QVWKiC95AXcMGEFLKmKbAT2vQTXLZZGOj4yK83kuMYXqpBjPiFeAqo8gh6iO4E5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeEGltZXpUKA+dIu0nBtkVafz+C4fKlYXvOLidKDWJ0=;
 b=jrL378oUOWHGVXyRjSc++MvgLfTP00FP7uwDstUenhdIvXkH9AjkCSMqEgLdKC2kmT6OzcmqMCriJAW1y/go6ivP7k7YXT0KLK5w0gc9mSaGAEBEr/1wY/ZHTLe6Vi86vfFmy6YFiOIO+UZPp6bmDyAeg9LzsWJC4NUkAi6zSXZju39KV0FRZ0PJ1q4xO4iUgwjcDS6L8P/4kG3dwAxwnymt2lchZa4iXY0QfxP/mSb9P8zRINTzq7TrGf7bnoyblZNwdbdt2S+I7RYbl+JiiHbPpBC5ZX/T110Jp7i9UfFFJkUVxYT+JlICeIc2BieuDNNRuOPDsHCapdHdT2OwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeEGltZXpUKA+dIu0nBtkVafz+C4fKlYXvOLidKDWJ0=;
 b=ti5Jp8B5KVspaq+3JNua1TcbElj+iF8hHNjZtPzz+Rmq1/ma6TQ38t2ewbKQ3PbWykMGkSCDKAMIAp6BSE6IBs4GkUiQJYRV4wgruzovwUTrEiMYg5IjAlNj8TgwBRyv1PzgYQkCjUIQiuV5QZZE12nTQwVQVn2Ct56AbQmRiJA=
Received: from BN7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:408:34::30)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 05:14:21 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::cd) by BN7PR06CA0053.outlook.office365.com
 (2603:10b6:408:34::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 05:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 05:14:20 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Jul 2023 00:14:16 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vm: use the same xcp_id from root PD
Date: Tue, 18 Jul 2023 13:13:41 +0800
Message-ID: <20230718051342.217902-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718051342.217902-1-guchun.chen@amd.com>
References: <20230718051342.217902-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ac1ab1-35a5-4337-ebf4-08db874dd80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tLSoayKuH1kpOwbpq4vMzVxdU20MhatmXXrlgYpheU7m5opWV3jJlD+WDFLAoLRHyfpppUVmEcKEm24TliZ5V1UWnuB5gUT+nmM2Xp8yM/8ZAaFWqCp1TdzXdvqFGAUOg7scbe5EjD3nyE/SDtv6z57HtUpBDtUsrzAWBRANLuG5DZauvZyY6IoAGXpjQE19zuAUrX2ApxKFQzyltgHC0YkzafEP42tE96XIR6fsWLAZom24oOXjNVnNm0qy90FeZeCEcWHEGa/UUMuLEedMIVIVVSxf1JTqnu1IS5iB2sjP0UGETCOSV3N2id8j3pJBR4/IJIFJneiR1hlXzmetCV1soRoDjw0AqJh4UaGjRK2O+IonsnehG6VbRrrD43c0/E2s1xt0h4WKapcIduHv25GOS8mf9xmZvBLZ4WxU3BqBgty2gwJzSjNm5k7TN0FecuH7E78jvP6JY1fc9+35nXaQwpQIx8O3wa4kJZNaBtJxSqoh+Cgzif4D3wpB0zJruUl7LVfizAKoARNG+TqwEmA3FO88oTh+iEkGnxOWFovwau2GTooXD498ZhJxXPgf2jyTsFIvM4Ev0eT+aF8O4OkEqNAKWmLe8j5Xb9VyDilwIKEk0XWJMpU1kgDA9Y6pTB5jH/co9NrkPgluSN/QRXll7mzQGeivaK8Uf2LbtBWC/S7mVcdB8cDCEvLubb9TJ5/no4W4VKgNZhmYoa/lJut9UuiXc9AiHYmakm50yWoVRk0rvNqPTCBBTHa867T+NWN+zQdZU8x9vVAnDOG96rRE8xeHoS1CNXT4QOm/us=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(478600001)(6666004)(110136005)(7696005)(66574015)(426003)(47076005)(83380400001)(86362001)(40460700003)(40480700001)(4744005)(70586007)(2906002)(1076003)(186003)(36756003)(336012)(16526019)(2616005)(82740400003)(316002)(81166007)(26005)(356005)(41300700001)(70206006)(44832011)(4326008)(8676002)(8936002)(6636002)(5660300002)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 05:14:20.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ac1ab1-35a5-4337-ebf4-08db874dd80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Other PDs/PTs allocation should just use the same xcp_id as that
stored in root PD.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index eb52dfe64948..83e1923f6775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -607,7 +607,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt, 0);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
+				vm->root.bo->xcp_id);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
-- 
2.25.1


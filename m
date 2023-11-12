Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5689C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 04:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06AB10E111;
	Sun, 12 Nov 2023 04:46:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D873D10E111
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 04:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnLq87CeK1SxDNdtN1R2rvptL4xiDuctFZCzUqE0KMzWXQpLg95PR9GelZPtZxNNBbdxOUqoDt10XersHCRZwJN6KAydVf+TdsbRpFmV8OeQN8jgHSS6v+Af1LcjYg/sKBWN2mZOzsGHYS8PvGzg5TeeH8ADA7AQubyNPYHY6E3TVPTo/ts+K4hu23tovG9kDuYAfM1yDvbbLfkWjN78ZsGx1jSsE+r9G0XPGpbHm3lnX/4LC0KAie8Mn+3FGUuC6Dn6DJQQyKLkLPsDJzrId4JtgFjbmr1qAKKyKuXUK2q2LrOm4ljn/WvlP7EkX2hn16V/bZ1E33+WIqADynpRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho7iJnGCgO8BIeQ/vGbeoCOwB78pFuBqq5JsTC74ZTA=;
 b=DA3sSKnqZeTeaDqfWoDBGfPhUEotczeLischscOh8KuR8emdQH7zilFSPIJ0PjPZwGKVzsY4ryMpHIkiytTcaSGTkgHKXhHQZ/EnyLcKTN3uUuUTEKid3rSQ+q5en8Zw7FmRpsHCIpsEyiHCUC9MOISPWb9tNwAiXILFwgN3JeBZtqgJ+IbJ1A/73ZDAKvrcIYXeQZLfiqby+AWJSAKYnT1JXPvTvYMO1e8OrAnighzYk2MGPAh91BGiArDNY8TOfGtN0LHpoQPiintvbNHbtJAQ0KJ6oU4Blnq9xdxNrMiZQ7+XZuLEAXwjNKIxibBkkjJ84KEDQcnh+K1lVbx24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho7iJnGCgO8BIeQ/vGbeoCOwB78pFuBqq5JsTC74ZTA=;
 b=OLAn7ws4xVVqPOC9x4CccnB80kfbpdtF9+nBwS8S3C+u3ndlNfF/WS8G/q9TJErKZszuTEKmqlWfLexJes5MrdyPHI38LA5+duy/NrzG1FSkIjeiV1rsMzuvns0H4etGydqTLK0Bqvf2NlUavhgZp8HiHLr3IY2VoAiKnsaOFqY=
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sun, 12 Nov
 2023 04:45:59 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8b) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28 via Frontend
 Transport; Sun, 12 Nov 2023 04:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Sun, 12 Nov 2023 04:45:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 11 Nov 2023 22:45:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
Date: Sun, 12 Nov 2023 10:15:34 +0530
Message-ID: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: ff88e639-b886-4ab6-23db-08dbe33a43f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvVK+aDbONtxfRnNAk2qQUWKbJoWvyhz4hHLj5YwWkpi4gxyp/BNMMQZOy7v0NM7JaZDRjkz7E6kj9+09tA1LMtnfaTzi8bUCoQTOBozcWLnBeJN41W4em4+M4CMXkUotzgWgxHX7fZfYIl73IeJWqLvguJRmhHyvma1LiHINNU/RNdN06bwHId9u1A8UwzLNQIWTJ+mnKntwTTMAKC163ruG8zGHJ2vNqRyNcuoM9vt7w5bWGu+YAeeWR+jGp/iS8LGmVwZjMpt+sZxhYjX2mlvjh0ZuqTt/BSpmchn6HlKL0zrrQQld2fPgBDqBHX3sZVVniCJwlucJPkEFVxWRJBfROpuzOe6qGDfQkcetPwHnRxYM1Xt1mqMfpZTyM1sdVhdX5Q/09WtaaNHBNtidJTKfbf0ZNkYFoUUF7lr3zxU4vsmAPW5yacrIksn2dVISjs21bPJZu0y/Sb7/bKUd1CIAK7SBIUCfUoSgWUq8PHyMcEN/XIhEsNFQc38woX97vphcusnsccmiDxLNp8EjRSJ5Fmy1WyBl5FcYCJuDYgT6Rxz8lqhQg4WNenGicTcD5y66sg5VpruaYlY3XqqsOzKGr03KW7AGcJr1eO8JGqipz+1Qm4JoM7rbPwU/EIdPjZFILx7Cy5NSvNO0U/wou76wm/7Jk8nPBDlzUm6JztHi0/lfrbALROJ4HFPStEnDLRh1/8l7QED0UVy0hzXKGtgltC6d1157cYvJ+wvnsV1AptUa44DnRGJdCDKPEFZhlvSF1+dsmvMySAKqqTM4cKoZUiMuvKTAcZDWINOdY3Zx+YtTw887vJjHwqbWj5l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39850400004)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(110136005)(316002)(70586007)(70206006)(54906003)(6636002)(478600001)(40460700003)(6666004)(8936002)(5660300002)(86362001)(4744005)(41300700001)(2906002)(36756003)(8676002)(4326008)(44832011)(66574015)(426003)(336012)(82740400003)(83380400001)(2616005)(26005)(16526019)(1076003)(81166007)(356005)(47076005)(40480700001)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 04:45:58.9695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff88e639-b886-4ab6-23db-08dbe33a43f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function parameter or member 'xcc_mask' not described in 'amdgpu_vm_flush_compute_tlb'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index be084cbe7501..cd4970c2efc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1360,7 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @flush_type: flush type
- *
+ * @xcc_mask: mask of XCCs for the XCCs available on ASIC.
  * Flush TLB if needed for a compute VM.
  *
  * Returns:
-- 
2.34.1


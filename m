Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B656EECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91B310E0A8;
	Mon, 19 Sep 2022 17:16:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41C310E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQmItlXNbg2MU4+tqXHp/KV3OEmSjq0IIivvjD6u67Ev+6HgMV5aZRaCryrWeUPrrwpHrcgTNB0JdSe0VveU01voNfLMpczHPFUtnARTHy9atYnBye+P+jJwtKZgnZtfKMsKnqva1rWh++GE0wUfiFy+MGVFaBtzY7gBJhr33KQi8lkCFkYmwnxVYR7zxLIMgcEJcGhWp/uCskyR0vJbOKTj7/QOu4mfzvobX5VuDsz2ic/MoFKXNn4XKPdf6MJKvWb4aWnxjkJyCVHXG833cikF3s8O1sii1QTxCaHFrWEzLPtqTHhGMLWl2WFV6bErfi5L0CnoHHRR69LDFlyYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo+pcCfvyXE/s3WLTbDX0iFznRcHbNVaPovrb4r+Ryg=;
 b=M6/Vqxup4G7cwM9I/4IzhvM2JaIfljln7s5V0ySTCL9S+S0N0MvAj+qwxzvHllz1JvDVZu1hD8FI7MwLa2wcGd9sNIwi85Yq0sS1cFgZsTrueP1EQJRJiTIGoNo1x89ze81dQcS0pKb06382o0dUCGf4PCwmN54zKLgtMOMumKEhDxPH/1+kyasisskTBvtLre962aq92zejfIN6b4NQSdwjGNWuTSUQV1QCmGt2PeU/elC43t7BknNcPex0m/vqtKrHpXCIafzoL1pq209uDJmHHWHYbk8ByJ2hBIo4/vt+AwdSDXDRtV3H8fZO7tkKGpFrf1u6ARUUUM0GKvuFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo+pcCfvyXE/s3WLTbDX0iFznRcHbNVaPovrb4r+Ryg=;
 b=0LrJ4F1+5O5JFdz9lPVNu3kEaBgEFXSsBO1DLgT9fsruvm+2LW1Oo8y5y8FdZrAqf45PlLeotU8eemMES3yGnFhVWa/va8vkbSeDFHaYFEJq/RUDYsT+GAphynuYsoHfKneMBSSVTIovASUbIRPd7LhHQAG2EI7GRaOCGF6Lraw=
Received: from DM6PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:40::41) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 17:16:23 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::aa) by DM6PR03CA0028.outlook.office365.com
 (2603:10b6:5:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/7] Fix amdgpu_vm_pt_free warning
Date: Mon, 19 Sep 2022 13:15:46 -0400
Message-ID: <20220919171553.11286-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d2ea6a-43f3-4b19-b57a-08da9a62ad61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qRZLeX0uTDNRsEAjvrY+PU8aGFzKOMO2uPmve6UywEY/RQnQH2sj22gDKM9WH1FUs5KD2EEUlE09EhUqC/c2R+eatXs/l3HcdVw8kfvJ3uJ/Bqi7OAJGulb9uCLCbkqd1yoGDyybFJLRUbyGF1qabuSo4p9NTyrYzIRT/zuffsxNi7MJUFah8sK8wDuT4uNICs0VwOdGZEjcLoGXkB0hX/8VJ+UADqFx21akeCn7LjbVnW3QvVDv7kXc5QZIcTOG1BeNe4HXxcsfPN5GS5mky686Omo/HfA7cX6ZG2wW5NWxS/XE1m2lIftqrQdiRt5gNBGaRjwh+JKlMzIwZven2FPqHRLabulkEnH5qVYat3hlCleZXxWzLNpEPhQS6Ey5jtruqD1eOctFsabecuADxKwJm15+7nGRcpyzltm812ZYOVWAujpWqmhO4/bcqBnYgBlEOoME0unvHPrn/pag+klmA8O4fa66lEv+DSuTF0lr4mMNxMEoKr38v+qk6ivizyRumiBsNLUB2kPBpruebp+qGQsBpMj4RvK6w3+gmV5yXMTOlAYjxdr9cPtg2oEr6aO0hTeMf3dN+2OKo3n7kZc0lC/aMeVWMeysBjeuFyHO3Hm1yaKcHQAWzyZi48+0Icu7tgFWAbHvPHvGKI927NxIX7gwR149733nXWc6veQkw15pAslCqTPjles8YjcdUYn5whCe2JRVk8Ca0d1zfOw3UQZWeX3iXNYYQwySH2uQMQSOQQpClzDYsDIQ2mlvghTz7jMJQFvcWavyufdPwJtwwDhmRxG8/w4LbwwXXFBczRCgaKR+GHwLaQBdbtz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(70586007)(2616005)(16526019)(36756003)(82740400003)(186003)(1076003)(40460700003)(2906002)(83380400001)(426003)(336012)(70206006)(82310400005)(7696005)(316002)(41300700001)(6916009)(86362001)(8936002)(6666004)(54906003)(8676002)(4326008)(40480700001)(356005)(26005)(478600001)(81166007)(36860700001)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:23.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d2ea6a-43f3-4b19-b57a-08da9a62ad61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When SVM range is unmapped from CPU, the mmu notifier callback update 
GPU page table to unmap the SVM range from GPU, this is the unlocked 
page table update context as we cannot take vm reservation lock. If 
unmapping from GPU free pt bo, this cause warning as vm reservation lock 
is not hold.

To fix the warning/race issue, we schedule pt_free_work to free pt bo. 
This has another race to remove vm_bo entry from vm status lists. Some 
of the vm status lists are protected by vm invalidate lock and the rest 
of lists are protected by vm reservation lock.

The purpose of this patch series is to use one vm status_lock to protect 
all vm status lists, and use it in pt_free_work to fix the race and 
remove the warning.

v2: Correct comments style, move status_lock definition before all the 
list_head members

Philip Yang (7):
  drm/amdgpu: Rename vm invalidate lock to status_lock
  drm/amdgpu: Use vm status_lock to protect relocated list
  drm/amdgpu: Use vm status_lock to protect vm idle list
  drm/amdgpu: Use vm status_lock to protect vm moved list
  drm/amdgpu: Use vm status_lock to protect vm evicted list
  drm/amdgpu: Use vm status_lock to protect pt free
  drm/amdgpu: Fix amdgpu_vm_pt_free warning

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 97 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 44 +++++++++-
 3 files changed, 116 insertions(+), 34 deletions(-)

-- 
2.35.1


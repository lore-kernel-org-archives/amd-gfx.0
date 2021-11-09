Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D86610CF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 93D86610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56F46E8B3;
	Tue,  9 Nov 2021 23:05:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FB36E88B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 23:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVwiusISUSo4ikmKTVAEU1u472uoAk/91VW3oqE+RwCWrVLHDBiMT8TvJ8mHsBFtJa3WymzbOUbH+RcRJ9DlA5gVWVOokBWh4v50V1aZNPXFmy5KATbuh5lIrLkEkoI5Eh7UpsthmD85yhhDw2Ot68e3Dkq761QpQgcKT5oo71i7S3/NG/yiHL/OC8DqhNBrT2BIpgztjiFiv6ivTBHZ1hlOtW6JZjV8p0rWjqpVU8vYOP7QJDg2WAFmOV7VHL2EmoUG8IeZkLRVzHz4WYpQjHfxOwfeQoT7Fuld/gE4Wb2ym9gBhhEsNBDnOUdMpYzPGWz9zcnxs5kMvSzcGHLB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qf6iX6rVuS9SCijZG1u9vASeihHcHhWib5qjiEpWT4=;
 b=evLnPmTyUpAcYcqBpNpF88Bhi5ha/wUa8v0k1MjMuV310CTcTvKyvyIZJsRXkmJuLkkYp4YllYyRccy8XcaaB+aySVOOqtrFjxELjUS6vSwTSg2QsFL4OlCfvhi53dSMqLbYwU+5f/+Y2QLXADV8iW9qtQDAB8ddPu611iRi8AVtknLC/LJ3MHNcnudZXMQNye176/ktta3QfuMGuWy+zd8NNHA6vLYA8671wBLKTusb01ZYGWY8pz+5MAZ/a4lM9I6VwYL9eM96Lp1Sd/pu/xEadSm2DevvnDJji5dvgCGXjZVQIdqwutAvFHWuBdb30zJyQkeYbb7S4MhuV+6SkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qf6iX6rVuS9SCijZG1u9vASeihHcHhWib5qjiEpWT4=;
 b=VnqKLnkW+4JbHlkGRIuBKbonhWbqvuFfHhbhh15gC7kSJhpIh78hBCfRHkTrhXnz8qJ9RDNkk/bV+xgOx/6zIudwA2SlrVdZDXCFHfm0TwNcA51Ilpq9DH+zAX4lWLJ+W8rGWxMmEFu31JaDOoK3Pss+tFHN54TxKY1M+PkOpy4=
Received: from DM5PR06CA0061.namprd06.prod.outlook.com (2603:10b6:3:37::23) by
 DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16; Tue, 9 Nov 2021 23:05:12 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::5e) by DM5PR06CA0061.outlook.office365.com
 (2603:10b6:3:37::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 23:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 23:05:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 17:04:58 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: svm deferred work pin mm
Date: Tue, 9 Nov 2021 18:04:32 -0500
Message-ID: <20211109230432.3947-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109230432.3947-1-Philip.Yang@amd.com>
References: <20211109230432.3947-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 497e824f-ce65-40bc-0f3b-08d9a3d56225
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5230088259C4C698D13CBB34E6929@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpriVdneGbc76Tc0QvJ2cQj9VEhklMHnkLnuPjLI/eDWPEcDpk75yIij/RqJj6Vo0IDQYLDtsapOV3ZN/6HixU4OvuRDjLMWiZxT3yIH3eBR1zTs0Q10U3Zocw+nvu4RkuH9YOOX+lnCTtOcFWz/CJ0MwPS/BuvkpkQJR+b5FBshSbzHLesIRMk4UzB1XAzjos0T3pr3OBKVLO4weLXqmb2bg6Q9oQgA/9hmCXoMqvIBWvFNjZGEj504XBFd9GKYTepKtcGpkh3G2s93x9ITXIHvmx5AuDJEoRoR3ThTTjIOh6vHlsDRRqrPCu4Djeu182zpDVSGLTXh1q8zBd64/OaqxXbWXxQsbXNRKw8gHvzu41UihRyABiw8soahLOLpTJt+QaIWMcpSZdlZRUYabqOpiJwFrqPSmTd1+4QBwXVCQXf2oNDc0Ez1ODd+L4q8aZoIjoc1h1KjtqS6lIl0DahT0XEwIy6f6Pou5uDIkSD/uLIWxBBG4y0ySShCC7JzFPgTurroqhNRylyEYbF4TEGx/uwHCFuwymvVUWNd5156A4kTIIx7vQ0fUy2FiAfS2NHq3bNBBCmGr0daixOn/F66z8qHvqwIwhxo7lKYdsNfiTOkz89bumpOeUU5q142hM8k8ko6PuG1bh/ILmfdgs78H7Epy9ehJBvor9TR6fC+E3hMPVyy9hGm1fQrcTsj/2zjBuNADSAY0+/vJVh4/YnNAdRX/1IVcCwIy9T25pw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(82310400003)(81166007)(426003)(2616005)(26005)(356005)(2906002)(1076003)(186003)(16526019)(36756003)(54906003)(6916009)(86362001)(8676002)(8936002)(36860700001)(70206006)(70586007)(508600001)(7696005)(83380400001)(4326008)(6666004)(336012)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:05:11.7844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497e824f-ce65-40bc-0f3b-08d9a3d56225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure mm does not remove when prange deferred work insert mmu range
notifier, to avoid WARNING:

WARNING: CPU: 6 PID: 1787 at mm/mmu_notifier.c:932 __mmu_interval_notifier_insert+0xdd/0xf0
Workqueue: events svm_range_deferred_list_work [amdgpu]
RIP: 0010:__mmu_interval_notifier_insert+0xdd/0xf0
Call Trace:
  svm_range_deferred_list_work+0x156/0x320 [amdgpu]
  process_one_work+0x29f/0x5e0
  worker_thread+0x39/0x3e0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2083a10b35c2..fddf0a93d6f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1992,6 +1992,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange->start, prange->last, prange->work_item.op);
 
 		mm = prange->work_item.mm;
+		if (!mmget_not_zero(mm)) {
+			pr_debug("skip range %p as mm is gone\n", prange);
+			spin_lock(&svms->deferred_list_lock);
+			list_del_init(&prange->deferred_list);
+			continue;
+		}
+
 retry:
 		mmap_write_lock(mm);
 		mutex_lock(&svms->lock);
@@ -2032,6 +2039,7 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		svm_range_handle_list_op(svms, prange);
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
+		mmput(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
-- 
2.17.1


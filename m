Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE898C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 03:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7613410FC4A;
	Tue, 12 Apr 2022 03:06:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D982510FC4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 03:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWcNtpLWLcPXv74//mWFgtu6RK2dcPPQwucs+wPm941+ujZYz+5a/HeZ5XSfQHU5QHjd7oc8GM2WXfnnXx/zOx9Y3hXlhmuak37Qon2P8PuwnXJinVYHO+FwFcRxN8Gv0lQCDrVRdykXpU+Fv6GVjiOka/jgJmsxDyfd7ae4CqgwOlQmocFTCphIIAKjwHb0L94F0ytWhNwsxl0z6vzipbcEeaO9yzBVvlAXPWd5+oRwhHpIOOSvSwfF7apDNchtCEIj1xo4sPJ+RmtKuul0fouUHOSWbioNozBCy+yUUNOTpo2AkKghUi7NVArxecJLai89SofwC1AlQm/opz8eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F99B1fnlyWXm9xGPIB1zXSJ4XWXoA8cPb8GizrHa71I=;
 b=guSa6JVQWqfAuEOWabqQfYEHq09MQSWBqkIMs2HkUJMXvYeLwAYPnAXrJAKKVenYiQwAmBqcTA+x6XMllTForBgc63jGiP9WeoY+96eRV6ibcUbbbkgfolNhl8/ZVWD6iycbnW61egX9ZwplfJZ1KvrFDWUn/vmkmHoiCfTB+seZyjWKPB8lZlosEVJZvLgQu4+X8Tf6lyVr9iqRIEORlbJ+D81hF4V4uReywkcruvLk2cXOvSlqW9lJpb74ISv7cqveXUwOZkpos6hrFt8ARd13PKt+cOU93g76IIOOIgHj4POy/JnDpCemmVhWkx3jcNHTBbOjqctbb1FheKx20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F99B1fnlyWXm9xGPIB1zXSJ4XWXoA8cPb8GizrHa71I=;
 b=bDbB+wWHsaMW4Al4Ytfh3Lg2umJIp5/l3TogF7qsc7sJ2rVViDBYjSyBURlGVoxevXC9DxaXM8ElkKOJmTUq/LjJxLrQ4UeqU/8bz8xgAlBt9/XsUSoPeVmyZ8bBWn3Poozl8y3HT4XvfPlihojD33I1bGnaqADUPZBpq2kpxTU=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 03:06:45 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::7d) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 03:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 03:06:43 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 22:06:40 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: shrink bitmap size in struct svm_validate_context
Date: Tue, 12 Apr 2022 11:06:26 +0800
Message-ID: <20220412030626.557729-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ad2e98-a1e5-42e1-78fe-08da1c31794a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34140C0BF537A324C44C1B40FBED9@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9W8Lj52Qv2uJft2UEvrVkqHNuRz82AvmZsxw5kk0PwA3wN7gEanaUu5rV8QZJr0zzf0LpgPjuhQM5MUHNJHppjBSIGVBuzw9LLiBzyczOru2WzSfgXx7OT11ktFi+TTQgUJr/smwo9xUtkx/U/mpM1iCWoYHiOw5DPoGHRdh63sWmYwOqpYXlHn+m9XBnh7hGq8UDLMtQP0pYMPxoeGIFTw5O9oKz5Qbut00ryjr0UqfekTQYqdtn2D5OyvfeR1rdkfzILzuENP6j4/+f/yJsOetIfSw8Olr1sj6KmPM8/sJTBd6JFlGcIJ/mf/5UGHoV5IgdfOEl2cO514QvDCVCVPfeQXH/fu39Sx/ApfC6g/D4XcZq0UTtN28qatYMDS6NibeQHasMINIUiJl3UxgOcrfw9HPjWptGty7+PuhGyHtdz0sxu+2KW0EQB90aFt5m6vc1nS88Upd/1pVULwmuWz2+Lkm0sJbGWus1SB3sco6rmg/C6Lv+4rhvqQCoiZIkumK9ybglGQLfrqH5QBcocV70mLwAwXItI0rL0aUSNxor8pak9+PetilRdTF6Qy8HCwHTQW1Ot860c80BtAm+W/kZnbto1bnkaZhdAcAqYCIT+eY7O+2CCCn9vrrBB1YB8xKbIqVsABTvUpjzs2/0zjpn3fmalKXfqscvYE95aeVgVuAhgvos08SnQiVHziL345ktraw/u4kWrDYEew1ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(8676002)(36860700001)(356005)(2906002)(70206006)(70586007)(5660300002)(8936002)(82310400005)(86362001)(4744005)(81166007)(426003)(336012)(26005)(186003)(16526019)(36756003)(316002)(7696005)(47076005)(6916009)(54906003)(1076003)(2616005)(508600001)(40460700003)(6666004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 03:06:43.9620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ad2e98-a1e5-42e1-78fe-08da1c31794a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A MAX_GPU_INSTANCE bits bitmap will suffice.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8b6adc142e25..459fa07a3bcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1370,7 +1370,7 @@ struct svm_validate_context {
 	struct kfd_process *process;
 	struct svm_range *prange;
 	bool intr;
-	unsigned long bitmap[MAX_GPU_INSTANCE];
+	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
 	struct ttm_validate_buffer tv[MAX_GPU_INSTANCE];
 	struct list_head validate_list;
 	struct ww_acquire_ctx ticket;
-- 
2.25.1


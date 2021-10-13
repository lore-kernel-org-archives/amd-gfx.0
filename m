Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5393C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CCB60E74
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82CCB60E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCE46E0A1;
	Wed, 13 Oct 2021 07:33:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73216E0A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 07:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqpSxI1V3JW9lLXVDfJYPfO9PyUiXBeNWtm1VI5jRThEmJVqZ/yoM+FVTWnf5/coX2k/n20Bk4np3XRCpG5syLrmhPLdspLcnVeVq7M1J3misllWWJizUgXgDX1//FmnVp8+HKxbCsksKFlyZ+avzAk3ZyL3SbSQs4R4EuwegnyK937JBaN2kz1Qq+kOF39RBPX5MsNdbmWGMMaBun28zGFeRBdkrwGW6vZwvhnfgZvFm2Zs8wALl9H6cz0ha3j4uMLW+bdC20VWBMI8QNJLt/+CdoZv5JLSK7jXQIOXhv0Q4RpJK9/2RK6lprtM9AoKncblFYhwuLRMgnu4gZbcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bkdUz21oV5zXABUjnTl5T9xS+pKPJio1kZgJ10E5Tk=;
 b=XK9sBBb4wyuZEWI0Cm0pPbqfYWpcAOWc2p7FE3gbOZRgBtYNb89cr8LUBzvmvyouPzimOBHN4B+poP6IobLuwgQGOQ9Ja7cS5gjY/ClVIH3Jy5jRP6CHsR9IcprCH68o3ceTw3Ctvol7GCPvLuybt+hAxqU7jnn9ngJsXIkRfdr3H/bkppaWHGK3vwbSoAT4fPwXKXvkHg1V3Dkm2QnCfXkYjTRVV9yx6houlUVW7q2ODgY0EgS0DjoQK4NlCimQr64X5tJMAFaScu//fqEUhMy0ACUT7bzE8GnE2zmtU3psiJ1yqKyA0YaIupt3DrHrhidLXvkSCtV/9GIu9Vk8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bkdUz21oV5zXABUjnTl5T9xS+pKPJio1kZgJ10E5Tk=;
 b=iCSV5J7EvoBrn5o/D6rU5SANrsvkhHoHhGiUXelH1PS9yuDs8WAkoLAqCUEPEXb6P1mB8NyRcDV8MwpbF8IifQ/nUqfz1I4FrZi1+ze5RC+ZkKSvWUKtVGHLjjPG04J6zS1ETmwrYdILlh08fyJmOplns90UlqTib4oRulBJNKo=
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by CY4PR1201MB0181.namprd12.prod.outlook.com (2603:10b6:910:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 07:33:51 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::9) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Wed, 13 Oct 2021 07:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 07:33:51 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 02:33:48 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Fix a __user pointer dereference in
 create_signal_event
Date: Wed, 13 Oct 2021 15:33:34 +0800
Message-ID: <20211013073334.987240-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05115d50-3f28-41e6-bb7a-08d98e1bcd6f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0181C830FAA45A60F5BED504FBB79@CY4PR1201MB0181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pR7RimEDxLWt3gxh9S+mllILAb8SLs2rEptvVCsk7wMtc1+Iv3Y9tBw9uiJUUoYPXSvwOJ3DLDf/ns550ZK9FMUgYp5XfwW/FvIWMzTbEfNG0jeh3eUsb5pL9e1ddBjZPDrUcuMN7X/zgRFakU8hd6nFbeiLqMrVJs4DjVOsp54R1cQctKWwnicrxEiv7GUhW2ueyKGsjMgGzgR2+EeUg6Tvr1h3T+CaagDurYNqDIX/LekT3xbQaVoq5Hasj0sDVNFVF0xrHlzbBCQdkvBOv7HUGUCIhpXaJFRR0i8jwboorsRP7CiDoxIXq1eZJik3Rn45u3unPF6GgqtgxCxRM43BbwrqvGV3sh3esco/mU4AyiZFEnQvDJcpe+ydD275Li5YFBQ8ZE69kATpzgpUkcZbwmHtjnpO3GNq3DEnOALWSnfFlu7bomBs2oLsFLODURY5UvNYu/WvTFQthsaq0/Q6Sl5QwHrnoZqRJd6if/X0z531kqjWkRm+fjjVRqAlJk6dI7FIkrNTlnE+Nqlmv2EhhjmTJbKsXpElLltO9gSlBAbp1ptjFLSMCCth25cZIlgbsDMWE63l+dalaJ+8Jc7FpjeUzAx+jIr4kPNAM+Z3dI0Kp9UFOo/ZsE/IKsZwFkYH2YEIrBwg95LFWPmaLU2S9FTAZWXCZfAO1r2uqewieSkwKuldivVt0TkOB/r+8bn63YhsXCcbR+Q0ZTJzrgoZKMRU3B3RFt8jRgu8x09JTXHcKlvfWX0VDuW2ztZWRAbqKCMIyld2JtE6z67d7+9OfPeanXNyXZXd30zJXHmefpXU5eLuP3b+AVzvL5Z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(6636002)(16526019)(2616005)(26005)(54906003)(7696005)(4326008)(336012)(8936002)(508600001)(186003)(426003)(4744005)(86362001)(70206006)(83380400001)(110136005)(36860700001)(316002)(36756003)(47076005)(8676002)(1076003)(81166007)(356005)(44832011)(2906002)(6666004)(966005)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:33:51.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05115d50-3f28-41e6-bb7a-08d98e1bcd6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0181
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

We should not dereference __user pointers directly.
https://yarchive.net/comp/linux/user_pointers.html

Fixes: 482f07775cf5
("drm/amdkfd: Simplify event ID and signal slot management")

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3eea4edee355..74d3bdcfe341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -201,7 +201,7 @@ static int create_signal_event(struct file *devkfd,
 
 	p->signal_event_count++;
 
-	ev->user_signal_address = &p->signal_page->user_address[ev->event_id];
+	ev->user_signal_address = p->signal_page->user_address + ev->event_id;
 	pr_debug("Signal event number %zu created with id %d, address %p\n",
 			p->signal_event_count, ev->event_id,
 			ev->user_signal_address);
-- 
2.25.1


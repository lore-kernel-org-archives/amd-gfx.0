Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB05C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A4660EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95A4660EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FF66E1B1;
	Mon, 25 Oct 2021 17:56:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF236E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbJd+MIy+joefi6g9GJRAUj1nQvDPhuq0Odn1au8Xa6cfVOZ10dbstC99adB8S5+9lHeEd4xmul/x/tWCw4n2ooUo4IHo3Y06X8b0mdiYyDJe+7m4ypIabONEwxtOQBObHeNYqettY8VxHE0Qzph+ot8sEbN8mVuQMwwXP8hxFpcCGOfUk85evNKjRdzMPEVgHpJI13VgrldMaZb4tLLU6eSI93xx7Kb2v4QGE0I9YqBIEcrIONn9THYA7VBEthTDyjEqJca0BRKspsTRu1u/Bp2UjicvstcYKyBTAZR2OZIn43PpsJ3fnmkwVszjAHGuRlH3XSeOJkSZ4rnNz2+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCxSsTcaWW8631I/EK9YZNuDkMV4CWpO7MYgeU+BciY=;
 b=HBtP33kGhElr10g5B3nBBxa2OAfJDcP73IR699d6Aurt3z7gdluizxkCepOkXjeVJZvfR2A7EBp4lJ4fthK2goBtiWMKwv76898baqZWXinLfSEGqICS6jC0iJktWA98XUHZc7r85kPBVom5acFV9GifiU/KcTRjyhDzUZ1qpMot+RBFfamsRAEzRriyWgPdc7unS/nDw2KcpksJDhcT/btLcfKJs8Qww3+m0ttKe9X4foXKT/ZvS9yXIwphrvZQJNH8pah+fGovUDBd4KjosH88i1hebBs40mZwzN2pdGuv+b8m+Fnc4F644DbpIgccUAw/46lvACBlhbfiiL0vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCxSsTcaWW8631I/EK9YZNuDkMV4CWpO7MYgeU+BciY=;
 b=MMz8pE6Ph1rfN0mwGKC0ZapDzP/UDbquJA0V4Xhge3TnDdb5A8xy7h4Jpi+8UoAQF6UCGpdv42S80o3WmOy3LvwelKYASFxHFUHttdxULoQK3Kuu+C9tigGdXinQh7GoENf0MONh6uGplqO1HJk/HMFV4hyh11syNIqfLz/2qCA=
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:56:12 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::c7) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 10:56:08 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:56:07 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Jude Shih <shenshih@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 3/5] drm/amd/display: Fix USB4 hot plug crash issue
Date: Mon, 25 Oct 2021 13:55:55 -0400
Message-ID: <20211025175557.148601-4-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
References: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7706e508-b500-4a05-a68c-08d997e0bb92
X-MS-TrafficTypeDiagnostic: MN2PR12MB3376:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3376FDEDACA8341EA958E121EC839@MN2PR12MB3376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HEXDniVI673lRf10bpdqNyZFolMgxe+yh0C71pRpS4u0U/bPwIBj9sl8M/w9FSNJivMWast8t9tetKINn2snoX3/4hq1lEF8RNmvBNAlFjkBK9Y86XJhicCNyvp4WSy8zPqgbuuOtJU5pO4gjImVlbipBs8t9iM5mLeTf2qECrViRvwVe1knjl4FeyFfrIEmno5/PbKLat37+yeCtOyc+BTrcwMEF7EE2WUF3JOuXQdEmECT1zPsKxKQrIxCep1vZWtgQPDmJyoNQJtT60D8E/qF6z5ylF7W8LwoA3caWRpyUpiNobUMVh2ie9f9eDgVxIgZe/gwe5MjiDsL9eJzZoJysNNoK6pm18oVfo4G2LzUxBrp98e/S9BTFYIyMIqBkapVsRm95wuc0jXHZ9kVSguAvLzO2s/HHtRkVX7AC77I+E+R+lWALHfpl5OAff0Az1RoTrVwaRxTji8t3BqsJJVNJ0jDds5g9dtCjU7LFEDjZZNDiQTI+iYTQm+ZYSVJgRMBw8oY9l4uG1EbJTeRxGLKw6DBUkcPMZPFptzHY69Mfh2BtZ8KU0ftHzcUIGaLihQR+PC6cFcnm3/MC1bTV3BORkTJkxBu6ebgaW+OLU5ZxAIFvJcVIVRpFAZ7pp9bBqO+U+Qnte69RsfyqQZU6g1gwCZLHjq2Tp31XWHbtwQxTqPPQ2cuW/0h/Lz/D1IR2mXYqh6w9BAT46WJ1or7x3l7VnsGfqhBVeUmAs9GkE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(336012)(508600001)(426003)(86362001)(36860700001)(81166007)(1076003)(44832011)(70206006)(2616005)(47076005)(6666004)(8936002)(186003)(36756003)(8676002)(4326008)(70586007)(5660300002)(83380400001)(82310400003)(2906002)(54906003)(356005)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:12.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7706e508-b500-4a05-a68c-08d997e0bb92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3376
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

From: Jude Shih <shenshih@amd.com>

[Why]
Notify data from outbox corrupt, the notify type should be 2 (HPD) instead of 0
(No data). We copied the address instead of the value. The memory might be
freed in the end of outbox IRQ

[How]
We should allocate the memory of notify and copy the whole content from outbox to
hpd handle function

Fixes: 5cecad78ea53 ("drm/amd/display: Support for SET_CONFIG processing with DMUB")
Signed-off-by: Jude Shih <shenshih@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4cd64529b180..0ad6d0e2a2d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -730,6 +730,8 @@ static void dm_handle_hpd_work(struct work_struct *work)
 		dmub_hpd_wrk->adev->dm.dmub_callback[dmub_hpd_wrk->dmub_notify->type](dmub_hpd_wrk->adev,
 		dmub_hpd_wrk->dmub_notify);
 	}
+
+	kfree(dmub_hpd_wrk->dmub_notify);
 	kfree(dmub_hpd_wrk);
 
 }
@@ -755,12 +757,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 
 	if (dc_enable_dmub_notifications(adev->dm.dc) &&
 		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
-		dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
-		if (!dmub_hpd_wrk) {
-			DRM_ERROR("Failed to allocate dmub_hpd_wrk");
-			return;
-		}
-		INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
 
 		do {
 			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
@@ -769,7 +765,20 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				continue;
 			}
 			if (dm->dmub_thread_offload[notify.type] == true) {
-				dmub_hpd_wrk->dmub_notify = &notify;
+				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
+				if (!dmub_hpd_wrk) {
+					DRM_ERROR("Failed to allocate dmub_hpd_wrk");
+					return;
+				}
+				dmub_hpd_wrk->dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_ATOMIC);
+				if (!dmub_hpd_wrk->dmub_notify) {
+					kfree(dmub_hpd_wrk);
+					DRM_ERROR("Failed to allocate dmub_hpd_wrk->dmub_notify");
+					return;
+				}
+				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
+				if (dmub_hpd_wrk->dmub_notify)
+					memcpy(dmub_hpd_wrk->dmub_notify, &notify, sizeof(struct dmub_notification));
 				dmub_hpd_wrk->adev = adev;
 				if (notify.type == DMUB_NOTIFICATION_HPD) {
 					plink = adev->dm.dc->links[notify.link_index];
-- 
2.25.1


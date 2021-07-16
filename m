Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC2C636CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA33613C9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA33613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A91E6E8DF;
	Fri, 16 Jul 2021 01:34:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CCD6E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9juxvHlM49IgNhbhvQrsNSHQRHoji/tygnYyT9zCJDjgJOQCho9UUlTlUlRLpF+rA+6EVYN8JZuRIjMhwD7rjjG8ritq/icYtSIAcBC6EcMrNDYmh2HYArjhanknn/2JaixUtSFbKtXrzUZUkuuJP+0d7OvjGA56PD0AuARgPbwelrHus7XbIZhVtRuGxZHJSQT1tQFmI/9AHMyZ7gJILp9H9w+5ElXkNCWT+EokWOb/Z/zwtlFMkVHgRUwBVAo/XJ7Cxae/Cs2Xkb4ztH+1PGSu+1G/Rr8xCdCVszMgretGI2d40E0T0pALbC+NQwlbc0M1Ow+PDLPsIqFTxgrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSo4f0Y2IlscCPmjHPvotxeKbnfNPdbS6C+Yoyj9r8E=;
 b=L6DiBd5KaYyDG3d90g3Ed6RxLpOaMDiGBPXMkyGAgyRFJQjauUyUcMirjGG6V8lYNc1OvaQLZ86aLB5VJLEKgOeYUMd02YLjvTjPe7TFQfuzutiWhJYjigXWBJlPDvEriW5vfNvEJJlixn633YHDx9798KIH3JZ1AQsAyyQjRIImCc2DBahfL2nkdPbx7j36v8ji2Dio/jv3OtCq+u6mFt3yuKfOxw+72g1KmYnL3941ntKWMWP4N4WKpFLktxZB3eLmMiH/GFpA+1jU/TPKzEf2d260EU81nOw1L8CMN/hRZ+xrn1ElbcbIq9zMPXNiQtVNgzl5D5GdNKvO/SGMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSo4f0Y2IlscCPmjHPvotxeKbnfNPdbS6C+Yoyj9r8E=;
 b=IpDVFqg+g/50LRZC8hen2SZb5DgjhiMIMj4MpUmETPfe3VV18dV3vciAoXvJPl/+Pz5+HSwEE/liOjuviVUVr/b16DK7n2okFTARzapML70E2fKM3Hq3I1caZQfNhNMTRShZY/3ImX7kxMfZe0DLankK8FyNhAyZaxHwtJk5QHw=
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Fri, 16 Jul 2021 01:34:42 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4a) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 01:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:34:41 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:34:40 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: Set priv_queue to NULL after it is freed
Date: Thu, 15 Jul 2021 20:34:32 -0500
Message-ID: <1626399273-21347-5-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bfe8098-6df7-47b2-0f40-08d947f9e258
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5415156AAAE03724AFB2589280119@DM8PR12MB5415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0coSrpgyXjF3wdJPuEvFq98+QjO531xYP5qQPgvtE8lG8nhPFptcXes2twSQEOQZWcvPOBWN0natlOnbltCuPjRw6UpsNZWcDoMmqUR2H48kqLRsJKaFxxiFAuaBpNYIYjU4o7TYg6EovdCQL6b5lc+iWXXphkpYevG8ym2sHAghl6YEV3yb8zgvrmEmaSthZIKCGmxUYBrtLgx8hVm1gYpvG5NCSHvWJqqBYUk0xMRHSQZliGp/GzOIiZtOMJ2ZFLyROKruH9Hu69TZNMLOrHA3CwDT6vTP0bK3zUjar0QGHe280EZdDwbhwb7LgZLUadG4HNvbEU4sHtvN4KuGNGamAik8LHQ1kvGwcyyxAgEklAb8f5SRV1uMTd8351LwG992e2idaKx2N1Q/MAMvnLMogt+5MjtN/3fhY0LwRgRky22JIKVVI6W8lDmMn0p3123zMdJ4AASQ42FbfgbUBg6nwKyBBU+oAJm6KOaPSMF1oXPZhUoGwu0V+IFiJOx3xx6hZ1ciaj7Re1MZsGCIwKZrrYmaGd0rprj1KjgbvlXet7kQDjf7Olp8N8gbl3cqV1QgYwrxEF1e78iaFnGiDD+NWWBBZl9QQSheDqFeWvRdTz++kyCcL0o97x0CUkiOgZ6xDa1qjhQYIGPELrX86lIFWHSItWuEQT5eaCsqdlfKajTAr36kJ0DPi5ge4KeJ2M03fRIzl5ocv6qYrJhenj265DpoNx1EbUfdHholtLI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(6916009)(82740400003)(186003)(316002)(70206006)(82310400003)(70586007)(81166007)(16526019)(336012)(2616005)(426003)(7696005)(5660300002)(36756003)(26005)(83380400001)(6666004)(356005)(47076005)(86362001)(2906002)(4744005)(54906003)(36860700001)(478600001)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:34:41.8446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe8098-6df7-47b2-0f40-08d947f9e258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This variable will be used to determine whether packet
manager is initialized or not, in a future patch.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index d8e940f..b130cc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -278,6 +278,7 @@ void pm_uninit(struct packet_manager *pm, bool hanging)
 {
 	mutex_destroy(&pm->lock);
 	kernel_queue_uninit(pm->priv_queue, hanging);
+	pm->priv_queue = NULL;
 }
 
 int pm_send_set_resources(struct packet_manager *pm,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

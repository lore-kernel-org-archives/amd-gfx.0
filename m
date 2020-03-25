Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2D1C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E412070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aIf2EPg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E412070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53B96E870;
	Wed, 25 Mar 2020 14:30:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F14B6E870
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIQ0c/ZFm9fVLc57EU2TOIFBpjpEpUmpYwpt15T6XPicbx7RJ6qJW3wx10L/H7fENirtN00dumQQOk6sy9M6U9mLKzvp8dYjwx2KbfHWEu+M3ctjHFf60U5GSzqzJRNS4etFVqlrgWsp06aPFlWeZJA+tl39w3s3gonxCJk7GZySj5o3eca/1iALgB76SsRLLCubNvRRxhog99YVxhbC02/aqCACZ07bGJ2+eDJ83/aENJV0u4lB6fRFIlalkht5flYqI3sT6+I8VwZrKXrWO5iTtzhHHoDBIeWijy2DtWt/VWhGfVDHR1Vg5iAUc5orQ/GEU333p/qj7TPsloRDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FREnG4j+3bJQBqmcDeApYJ08KGDDSDGYDa/9rzaCFU4=;
 b=BkpJWjaYDBvH29nF4ARtCeLV/UX8nkLB6fqiTqhRgYz43G21zc9pmTyxc3h4bmSJdrDPhqtl1Kcyj5uUwTG4PxxBy4jTo+4192TTmyZIniw1LpJyY004yh2h/lmr27eZr5XVxZORv+3SiKhUa6raI9bgljj12X+hmao03mZSFTTQIDCkUoWZHd014hWInhYpXoj21+p4+gVry7uAqw1UfvxeEgemJnjVpnDtzZYsxzL88FfKlTtpx/qK4klSPIqGhdHjy6dQuAqxjkcLNenF1gmJeDL9BLv0D7C7+DSMgDeuCjdHF2oTd6ibh31gCDc9uvaPOZ/zXnH1o3cvSvHUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FREnG4j+3bJQBqmcDeApYJ08KGDDSDGYDa/9rzaCFU4=;
 b=aIf2EPg/wpwty1SPXkYjZ4tPAdRuH+Ui7ZW3+DQztX4mJp6Tr6wK0mjt7r3zXLMVEDQxien4NyIpCTdhUr43GDL+7yb/59hfrHxyj9SUvLRvwwY13m5pAvPLnntZP6ym1xkaVsLJ5IxxA0x95vsNutQNtJULMqss5TBqXytXTvE=
Received: from MWHPR22CA0018.namprd22.prod.outlook.com (2603:10b6:300:ef::28)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 14:30:00 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::e9) by MWHPR22CA0018.outlook.office365.com
 (2603:10b6:300:ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Wed, 25 Mar 2020 14:30:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 14:29:59 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 09:29:52 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:29:52 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add a UAPI flag for user to call mem_sync
Date: Wed, 25 Mar 2020 10:29:40 -0400
Message-ID: <1585146580-27143-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(46966005)(81166006)(44832011)(82740400003)(4326008)(356004)(6666004)(81156014)(336012)(5660300002)(2616005)(47076004)(2906002)(8676002)(86362001)(7696005)(70206006)(6916009)(316002)(36756003)(26005)(478600001)(54906003)(8936002)(426003)(186003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1362; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c09fc168-efd7-4fa4-a9db-08d7d0c8ff73
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362DF6E93D61BF65DA26363EACE0@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj3viYsURSLop40I90y6REapsKfbPD6/n2InX8+wMmL1YeAhBsr9kRY24RMkWASZs6hLirILHNNjZ4ahyMo5UA4yAjGgWBrTDuQa63C6z5KBDE43LaHCBWpj86Ip8Zx7+55a5XAIur1dk2RqOVg3shdyIexdpmcAOs9Lbx2NyylTgcoy7Rx9P1SAwhAE8YS6TRxhYFeLUKoccDeVrdRjMu5WLEOKtXTPy03oqxf+fWGOzxe8zrweLmSadsMUJc53C0tA6ScNXZdeEklZ7tIvU72r+GMPOvt6/s/pK9HM2CAxODcSBpvP0weCy3rfBHIiJCV5CGzbSAQLkuDG91HgW2HD17QyHm2034D5OveJsmrYDs7ct79gssAB0n46gVbq7XZXCNgGX0SNhcM1WCg5pTCkxYU9VHA5HvuqljIH+EfiXFb86J7IVpvq4gMfjY85NJnBy8jXhVCmecwyVh/pV+FAnO7fmeajdvtIpyAP5w9Fvgm23L9QXoKrXoJyG3fC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:29:59.2442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09fc168-efd7-4fa4-a9db-08d7d0c8ff73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This flag used to avoid calling mem_sync without need.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8304d0c..d9ad841 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -238,6 +238,9 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 
 	if (p->uf_entry.tv.bo)
 		p->job->uf_addr = uf_offset;
+
+	p->job->sync_mem = cs->in.sync_mem;
+
 	kfree(chunk_array);
 
 	/* Use this opportunity to fill in task info for the vm */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bece01f..9168150 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -182,6 +182,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		dma_fence_put(tmp);
 	}

+	if (job && job->sync_mem && ring->funcs->mem_sync)
+		ring->funcs->mem_sync(ring);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2e2110d..7b08a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -61,6 +61,9 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
+
+	/** UMD flag to flush and invalidate caches */
+	bool			sync_mem;
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cfbec27..f04998d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -566,6 +566,8 @@ struct drm_amdgpu_cs_in {
 	__u32		flags;
 	/** this points to __u64 * which point to cs chunks */
 	__u64		chunks;
+	/** Tell KMD to flush and invalidate caches */
+	bool		sync_mem;
 };
 
 struct drm_amdgpu_cs_out {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

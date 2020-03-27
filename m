Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5302C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018520663
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zl2qt34D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B018520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2246EA72;
	Fri, 27 Mar 2020 19:38:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D8D6EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yny6NE37JDpax6d7zgRxT8zpGJFo2yu9xs9MgwfkHwa4Shm5MLvIXODf+SI/5XMzYaLLqdNpujoowDLXt6IeWxTSOj1zTBonN0Xp/fDLmpk2plpmJjDmOCeXtPEgXPUNSXDnGo9xXDej22nj42bykRStnVoxehDv8/u7y/nppZWjidBr1I7BZL0mvmXwqEONd1uuxhoxy4F0J9apD+HnS2DMGpAv7CH3UO3R1cyg/4wt3/Pd5rOllNmj6JJdLwFAa1BgidlQpcCYZwOE9DO4jd3eU82cUbEMhMEwwjGD6hadSAmA6F4yOB3dGaopOYlGr75TBBK76MdRUwLyqObLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ip2KzYfENlfzhneGyYQvYs3aun8I0YQe4gZfgafmk8=;
 b=c+iqVJ54SzYoJlEYOD0wJ4ZT/9UBqfxFhMJ2pur6eDLgdTi+YwnB7edjMq5faOSZ7ORf6NfNUFHX8AEkN1Ijfy6kmwdYiegNSTYlVPE22fSDY4gZtvp9v8acn4yK5DUvZwN4pNvwOgg5SaDnBZ07wSyDV1NwuUJ7CeV25wTm4VChmsqgjQvDOaDmgyzq6+ojlLpEBzNlESg2JNe29JgvhD+pUm52HuTumYGavH82PqbhQdz6Q68KpFzz0b6aqi+F/5iszkrsdGc0a84ueio1PQyhynr2LJWzUYqw1ITI9f84kIBNykDIneA0KQUdMAopSfD3gk7qyNYD/EjAVjq6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ip2KzYfENlfzhneGyYQvYs3aun8I0YQe4gZfgafmk8=;
 b=zl2qt34DpqtftaDeicKaCtCq3GKC55B+rS9cVkbX5R4kyp6hu7QAGPXS686XAIqhEp6FqkqAdKpfRI2X7S7H/mLE6oxA8a3jXIK26YJBbgCLi2H+SGkRz2VY6WhuhMCiGuBluf17KyA7xXOhARbecd7/ofNl5nosrU5MPtN942s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 19:38:19 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 19:38:19 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: reroute VMC and UMD to IH ring 1 for oss v5
Date: Fri, 27 Mar 2020 14:37:46 -0500
Message-Id: <20200327193747.8520-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327193747.8520-1-alex.sierra@amd.com>
References: <20200327193747.8520-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0201CA0011.namprd02.prod.outlook.com (2603:10b6:803:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 19:38:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e49bad63-0139-4c91-c323-08d7d28666d3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:|SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4413DE4A3D8E16E51E3C8C5CFDCC0@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(52116002)(316002)(7696005)(6486002)(2906002)(16526019)(8676002)(956004)(478600001)(44832011)(6916009)(186003)(66946007)(5660300002)(66476007)(81156014)(6666004)(8936002)(2616005)(26005)(36756003)(81166006)(66556008)(86362001)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4413;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JN0fKLLapXwWoD495s4lm2UfeBg7tgSGD2yoMPYi3Vv2LXh4ge7bmGYCbIH1P3n5gpYCV8LDuDZE4dozZ3zSMhYRarGz8aw/KS38/sLHiUEclfOuJGcPw2S/WKkjZnBOyuCKyDU0smepERNRBasihvCk6QFieA2mvfhg5f8eBdEwdNZa8gZlGEhqae69ILUuh5Kuceut7C7qHqQ8Pzpqt/Qh7T8ZrNWCenj0jiWpgRctbH7ze12GarvlQXW+DOtPkk9QSu8PnT9yRsL3/CwDDNxzhTFZIA8M/IDL7fyZmNaZQjIxZL0hLZpeK4wvEfYolHrtcA0pYX+bk8z27oR1b5kHu271MGZIOa1O3cuHMdnhTns7a7IDXcp4ICvgwVCw8wW/euga6JGUjslx3q31cvPocMpAS/onjn9sa5XE8JYb40xzX2T5oXVTU/HcgDX2
X-MS-Exchange-AntiSpam-MessageData: O9OLKXtpwOq8hxRsuKV6+peedfc3G/Kv6Cuq9jbUEnxZrg9FPV/s8gfSaHrUDpolenzelCHygVSwc9aaf/0pqMRXcXmXUPS5Q9JurEESmbSXFPeBV/3/B8soyL12xCDSwX2mMcGLUA9mYNJEPcJa4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49bad63-0139-4c91-c323-08d7d28666d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:38:18.9834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDay+gaW6msKBV9Wmu3QyoeG9DdKREE2zXTyZowKjooMsMgFsVF8H3+nmBSuBBEQl6QMsSuDGuSmuCdyCgmc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Due Page faults can easily overwhelm the interrupt handler.
So to make sure that we never lose valuable interrupts on the primary ring
we re-route page faults to IH ring 1.
It also facilitates the recovery page process, since it's already
running from a process context.
This is valid for Arcturus and future Navi generation GPUs.

[How]
Setting IH_CLIENT_CFG_DATA for VMC and UMD IH clients.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4ce42635787a..6fca5206833d 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -205,6 +205,24 @@ static uint32_t navi10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 	return ih_doorbell_rtpr;
 }
 
+static void navi10_ih_reroute_ih(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Reroute to IH ring 1 for VMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+
+	/* Reroute IH ring 1 for UMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+}
+
 /**
  * navi10_ih_irq_init - init and enable the interrupt ring
  *
@@ -243,6 +261,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	} else {
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
+	navi10_ih_reroute_ih(adev);
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih->use_bus_addr) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

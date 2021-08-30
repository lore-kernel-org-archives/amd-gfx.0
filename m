Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C57C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 06:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A404660698
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 06:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A404660698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B94189C37;
	Mon, 30 Aug 2021 06:24:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04889C37
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 06:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI8wBmSAACc6wxWEXlO/ZVQePdxuTvnjAuAVuhIomqsPfQwlYagw2Oh/B3gDqH/fEd0y9AsrqLWng1BCO472iB6M/yhqT4JljDEYgGBs/O3vk9bSjNSnpkEURHTCF7ctTco+e3FbzFAfNkMpT9lWD4JVqSjcc+9T7u6mORwsM1A6nG6lHfL2XtYDc8TFSWL+oaoDO8CN+yRkZ952mgoEWdy8VZ3qXNYZGLYbjbqZJStcNAK2ncTKMMvNSNZwJkqk50afoaeQeZxBJjELku6pry16fGe3Hh6quu0AgYbiAX4x4eYeco3G+E0lbATIxw3QuGWJ7e305PFPSPzvnY8cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffbkH7YvJP6V+lBVNzW+PflXRST9kNfK8A5vrB81GzY=;
 b=Bd0kAM5M2KPq9Sj1spqksbjMWGF6nnELT8mK+CPqsgovVFNWihqerIhlFkqtiHQragoUELO8psfH5H2bXuxBE7QzqrVe6XNW7HAdAlIeRNnP9PYiVcxZ2nGLzIATcVVZsouBK/maRlokqPXSuss55JTKhQkpHEL5HBaHxLekpQl+eVJXN7axk+Ef4vVFxz73SmynxyQS7oPhvI4LuF+Ljdr50Y05/ul3k2kzx6fneJdueJYCZrNxgK0blUIb2CIXgeOPEazph7YzAOn2XBmiqthM1CMb5EuZ7WXsSFdQSZofMvEdb3NeqEcycWM0xOoWNUGkziB0JW8J19gZyiNuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffbkH7YvJP6V+lBVNzW+PflXRST9kNfK8A5vrB81GzY=;
 b=diQzSMoVCRNhZGBF7DoQqWKWb8zNTbwe16Pm+/n2nuzRbRhfYCDN9GAy3+1zsglDEzgjwUXHvkTMtGq2mWtyKwV/kLbM7rQS+YdJ/v+ER9wAxHpe6fyw2KHZbZ2mtJcyosZPY05vSa7+oQ8IEd19pbLSz/STGofir3fVRXAY1wA=
Received: from MWHPR21CA0026.namprd21.prod.outlook.com (2603:10b6:300:129::12)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 06:09:12 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::95) by MWHPR21CA0026.outlook.office365.com
 (2603:10b6:300:129::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend
 Transport; Mon, 30 Aug 2021 06:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 06:09:12 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 30 Aug 2021 01:09:09 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <mike@fireburn.co.uk>, <alexander.deucher@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini (v2)
Date: Mon, 30 Aug 2021 14:08:55 +0800
Message-ID: <20210830060855.12583-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a2b0bb-8028-4e0c-c8b7-08d96b7cb024
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39376329336EE7B7835FCC99F1CB9@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCPQWNT3KNoskREQKW+lkAyapasxVBfcrXZgTMVT8CxP+0IyLYhDiuq+OKAGozuSbxty74Z5K7oitfCK3M2LctR0RbdGIEIyNkaKWdut77P3E3xBj+ACSJr1RtEZQLksZFg2z5fIHlH0EROk/Ems4fPRyQA3K5+a/yESvqudXABP27AKzNLCqWKDQruwyYwSUt/0ivv7GjXXsmCsfQ7GAvCXjlPH84Ds7Gnv5yq5MCgdK3Gmro+Gy5ta77GJVo30cLhLsdW6y+SNlkkpGGBhlr1xY0lSqRnMP2ep0kvjaGFvIpNaKJmeTLVAQ7lqQcgQD9zzJAKblsIi3fOb9U9k4S9wTGSNnwMZtv+GlYf1oxSu+X3idoj1JVvRXmDeKNBvJo8JNl/pOcKxWy8JcgSlMPcuRy9zNEgG0MjYeSpzihEp48aXV6nMYL+sjwV7UyXI07EQLZHlV8oZnu02LdNmWMjxpfjwcagD2PGbrsxsAXWSTsinYrYmdceb8Hls5RR0rEAnvRODIvrEMBsI0J1ebKZ+YRoDzpX3VAwwp+weUPRyE7b+26fp4tIiUFVTS3aN6uzVSvg0M57B40GGs5b6rL+Zpvu9jnHfSx1qxrGsaM9y5Ly7nrvDldHJXhxBt0Gn7BAjtuhdia+tYw081lLRl6Ra+lazqrTgB0TkUi+KmeX5fC/uDu69bdQQk3jRMY4F4HTW2g2HuMp+eEuJf1gLNJ/pkmJs589w4AagLlf0xg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(70586007)(70206006)(186003)(426003)(356005)(8676002)(82310400003)(86362001)(36756003)(16526019)(47076005)(7696005)(6666004)(81166007)(26005)(66574015)(316002)(82740400003)(36860700001)(336012)(6636002)(110136005)(4326008)(5660300002)(2616005)(478600001)(83380400001)(1076003)(44832011)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:09:12.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a2b0bb-8028-4e0c-c8b7-08d96b7cb024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
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

This gurantees no more work on the ring can be submitted
to hardware in suspend/resume case, otherwise a potential
race will occur and the ring will get no chance to stay
empty before suspend.

v2: Call drm_sched_resubmit_job before drm_sched_start to
restart jobs from the pending list.

Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b439eb7d4177..fd4ba076ff8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
+		if (!ring->no_scheduler)
+			drm_sched_stop(&ring->sched, NULL);
+
 		/* You can't wait for HW to signal if it's gone */
 		if (!drm_dev_is_unplugged(&adev->ddev))
 			r = amdgpu_fence_wait_empty(ring);
@@ -611,6 +614,11 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
+		if (!ring->no_scheduler) {
+			drm_sched_resubmit_jobs(&ring->sched);
+			drm_sched_start(&ring->sched, true);
+		}
+
 		/* enable the interrupt */
 		if (ring->fence_drv.irq_src)
 			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
-- 
2.17.1


Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E0B61930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0B61930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C241C89F92;
	Mon, 22 Mar 2021 02:55:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C87089F92
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtkk4+Pe+8VNmgU1OxueIHiKvfnvLUyfmDiSXHLyo2LRAt1GzTypt0gS6TDtcXv/INii84H8BeWYHyubQ2DFQLrQ7NJvqHQERRfZJAEgnyxBIn9fv1Zc+hOCtw0Wd9cJFjC7kEQshqHI702qWEj6YQDuE7mk6oLU0LbFMMbBbc2I54IteYwUidg0a5t+lyz4hkEWHSwHs8JD5zebjEicRMxZHl17S8xLH7k2BCLd0oLW/O/4S3ShNZwat+Cn5mMxs1+qn0hTkqOO8PQVodqxv4m/sYkRAUIDVXdZU10hbEgNBEoHL1t/oDrfbQgj1oPcd6y29WeYDh7RXmr5zBKqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8834dAkwVo1uLglTypXYONK59gkqIYznAlglo9KamTs=;
 b=krVoFpmEBduHTVt/jztTzBkJ3LqbbGvVf0D8XjcTKHhjsX8iI1X7ZtdtmXkhmATyfdX3EglIKFhQWaBbYGuGP3gSwkqnocSt6O3d7N95pRkYnV6BwsvCxfMk5q+3gKhy0MQpNwqwvVQbvTs+PDr3xTfw9qIrtq9oSpEZxHLqPa1JtLJH6ZvZqq4Dwav2LeuHiFu26ypJWdnZPnJr/G8bSwSlIgiW4NkOhrbS1C1z1VFzD3muD0lJNqutDD+esoGrzUievpjdczTsHs4wd2vSaDno7l2r2jobz+mJfx+evNHSlJqOZaZfaWC/w0Fpouz0VeeQKk8WiSbm0gsr4RIulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8834dAkwVo1uLglTypXYONK59gkqIYznAlglo9KamTs=;
 b=wQhIlPudMqIQMohBfdQA8ZPGqwtYuMA0Zax2iTQYGRK4tNLeMyRKL8cGkOP/il19t4rpboChZH7VxlpE64nIsxu/kmyb6KLk8A/wc6PK4FNNkOPmBXhb3sGOZIUzFYlMcTZ1VjF+rZJVXMZjuL0H0tqwgoF2OCehCMLxfoo/sPY=
Received: from MWHPR18CA0053.namprd18.prod.outlook.com (2603:10b6:300:39::15)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 02:55:01 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::59) by MWHPR18CA0053.outlook.office365.com
 (2603:10b6:300:39::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 02:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 02:55:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:54:59 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 21:54:58 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] SWDEV-275015 - drm/amdgpu: SMI debugfs tracking
Date: Mon, 22 Mar 2021 10:54:08 +0800
Message-ID: <20210322025410.30570-4-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322025410.30570-1-Roy.Sun@amd.com>
References: <20210322025410.30570-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9648e953-4096-4a9f-cec7-08d8ecdde2ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4315:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4315FDDD814D8676BFCDA431FF659@DM6PR12MB4315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOn8ikryPSgTCpWgincpTo+VjfNyhpjDaX2Ngzp9UNdPbLfQdZ3Cjp4oKtJH1NZWxai8DucnQNy+x8zkySt2nTkuuVJm4GyZL3Vz1aUHpwleEEH76VTiTUQjiJX4GfAC8YVsUOzUt6clDbzgwOO/K2jnk5SYx0sDDSa3cVS5Nz9ZTot5S2FuyxKL/XrBHhOYXb5GTwRTUz6D6W1Gw28iESYIOi/0Begktl9CmJ1xkbDjeswuqWByaVsmAbgvwgQjM1AmP0P6YT0ZoIRf9H9AwL7DNrUa8sWlphcTyBUUr4n+GnzbHSeBkN5g7F61/pFnlgyItMhKc3+s/Vl7QNmK8PGDHYKpQUqqwOeKWaZ2SBvqi4adpK5R+Bcxnx9K7+G0aL6+XUvETJM2AKQ8hU0TdRKqyuREk2R6mkd4ookVSAiECoMcXzVRrezCe+88Ida2ETX2nFkGJTSwj2tzJ8x9Ut8ey/X+E8XA8FGoSg7p5nYONfcXrYMJw/u2wVPCoZ92Y+KYTsmg/6xDT/VCUuIBQhi1CLUYG7mOJFOaiZput3wlRYrnnzOVhtgk5zLyaXXS7Hq5wAsiSU2k4fcstEsSrMcpd0VwneHW2SwQuX9xCwN0gFM4rN+Bd/URNMRQnVusc8++4GIkeQUwuBQg17n/83czBjAQTmj7eCWzc0pQDP1dR5hHOLcQ99YoCFJgzGYM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(186003)(2616005)(1076003)(6916009)(36860700001)(6666004)(36756003)(4744005)(70586007)(82310400003)(82740400003)(426003)(478600001)(86362001)(336012)(8676002)(47076005)(316002)(356005)(54906003)(81166007)(70206006)(4326008)(2906002)(26005)(7696005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:55:00.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9648e953-4096-4a9f-cec7-08d8ecdde2ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add folder in debugfs structure for tracking of per
pid fences

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bcaf271b39bf..02534a059f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1544,7 +1544,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
+	ent = debugfs_create_dir("proc", root);
 
+	if (!ent) {
+		DRM_ERROR("unable to create proc debugfs dir\n");
+		return -EIO;
+	}
 
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

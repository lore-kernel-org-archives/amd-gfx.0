Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E454660FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E454660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7056ECCB;
	Mon, 13 Sep 2021 16:56:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFA06ECCB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 16:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My7GsQKXqEG6z1izAYBTj8e0jCyqofTKUORwtzyU4mp0XbaRdNYkerwhmv2FhSIrh+DyBhvBOnA1UU/D5Ruxd64OH3ZzeF10YfBHrR/pLx57R6cjZAC0+dffkcm/6fFJ1M5EfgW3pzy1QACph4RMg+QkYxCizJKArfRHUH24pyatiM1znQuXQ5l4At6zxTE5hYe92AlP5WPqnmHa0kS/fQE/mMzKhZX/5AlBsZxN3ImiylEnI1edJJBMSD1QJtdUY+pHT+Q13CDybajKGPtDXYRZKu1fra2imPjnnIFO/uINlXyuU5FbIbfel710SPhg2fC/GAs7NEwR4X4+Ful4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kIbQ3pjabTOnMb9yf3NBTQS9L32p+zi/FPZ0GZxrKdM=;
 b=KyX3fKZs2Tu34ag+3spyUdh4WrAdtpAMflZG7ovnjjLaQd7Pe4Bdg6B1z6yNgjYe7H74XvSecsXi9ifpA4n6zPFbbRVfi67rHQNGpYVPI9fbAJh89jXUH7kygp2T4Du5gkcYqy0q1lR7tFJr20tpAGt90wj6ujl4oxTojis4WYAKsmveEWFB5EW/dwHnzh8AL9jbZrptQ7ssfJv+8Pe9ypNcmowI6eYGA6QDq8lcwVHfAD9r7nkj8HV29JjCOER7GCC748y7AlmUyEBuBBCzcDgAYXN/0uStkdSIuOcMZTSpdUqHRsEKz4ckotezkfsvz1Y6n8tDFNMYWuOfx4KGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIbQ3pjabTOnMb9yf3NBTQS9L32p+zi/FPZ0GZxrKdM=;
 b=vkqvspzVqMT3biha2NUjP2zUe/wxxxr+724BZZdQ7FyhFOt1vf4p0R8mGa7+xGBj4S6D4Qet1jeHAg/DabUPl14XzC7bK71gcLE7D81yQjol5UBZ+Tk/09HfdRx3K6xDfGoC0yVHYi0ZpJTWQqYEDMmy87uu4uq/l23YWyaOD8U=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by BN8PR12MB3586.namprd12.prod.outlook.com (2603:10b6:408:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 16:55:59 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::4c) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Mon, 13 Sep 2021 16:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 16:55:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 11:55:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 09:55:58 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 13 Sep 2021 11:55:58 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Anson Jacob <Anson.Jacob@amd.com>
Subject: [PATCH] drm/amdkfd: Add dummy function for kgd2kfd_resume_iommu
Date: Mon, 13 Sep 2021 12:55:56 -0400
Message-ID: <20210913165556.1970603-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713142d0-b4f4-4566-73ac-08d976d75cc8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3586:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3586C2C59206251A4E83E4A4EBD99@BN8PR12MB3586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpaihLNK+cjgklYnzhgH7+8CqKltRpYqaw0fqi2QlHW4bW+bfh4o4G4CX0QlkLg1GbhOGD3tIdRr92w6LC3SysqSOgnBfi5h+NVADUf1AHz3Wi+5WYO4sXuc083iDSytQE/FS1FhmZdvPzu7U9PqCpzNfA61uDnoyBpFZdqRoTvN9UmYEzBneLEMCLrjm4ZTGPb6pYkZF665ghz+IQyGnvW7QmoHIh6UYXDcOJxP0WENTDjC+k2k2MdvB3RwxBLDTSrVQG0EB98ojZJK0HF+r4gKeYLm6+uFxDvzBgNszH2UJbQcQb8y+VRS4YKwRIMfE50vSzr/qdv4BsAO0bpt9apFrBU4tIXWzW9PwXmWKWkyjQmK381r69KM9RIum4bAcm0HH+gzuViph4lqcblaVqhwo9ObX9TUfWILIeqlwjMb8nuKRcKBPtGXFj5V4gCIS4gkPXyQQHbldkGKlUtagOVpzhdOwgdV751UZmF9GCjKpgx9f8Rum7UCO33E20OpgtyxNw7kIhnYPe+PBbyZqfGMZblEThcEXTG42IKTRgB3/EV472R8cIHxrFNz44AoIeS3YsqJnxnYOdb7cvS6gNK18FVSaHu2IPNyiNQOEO4UUk/616iJQ0AMZ7YANSuSodnsl9JsXr3pOmjYUjDVXH2nW4kyHpaXdMz5mG+SE3algXAbSgv7whkCN5C2kJDd6OoHdM2fq2sYmecrtJOb2oaoIkDjfO+5as8zDsk8ZYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(356005)(5660300002)(4326008)(1076003)(82310400003)(70206006)(316002)(70586007)(426003)(26005)(36756003)(2616005)(478600001)(47076005)(83380400001)(7696005)(36860700001)(8676002)(336012)(82740400003)(2906002)(8936002)(86362001)(81166007)(4744005)(186003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:55:59.5463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713142d0-b4f4-4566-73ac-08d976d75cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3586
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

Add dummy function when CONFIG_HSA_AMD is not enabled.

Fixes: 433d2448d57c ("drm/amdkfd: separate kfd_iommu_resume from kfd_resume")
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b40ed399d2cf..3bc52b2c604f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -367,6 +367,11 @@ static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 }
 
+static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
+{
+	return 0;
+}
+
 static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
 	return 0;
-- 
2.25.1


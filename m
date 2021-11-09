Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B85A610CF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B85A610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A95A6E88B;
	Tue,  9 Nov 2021 23:05:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A276E88B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 23:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHxMT+R7XSg9Xn+AbSQOnP7fYVDTFR4acC4i2rdc89z458neaIJsNX4Ti7uYrPBZF6BGcAvFuJ4He3XtWoEyUAvrs2KQtLdrMn4dk4xK37o4uXEqo4rLLtILLkzMQADWSz3NtqVdI6FEJ+PoV2hDqCpjs/6iDJrG5k2a8/RIyRZDA7AMqVlKU6XPUdNsvJameczeK9cEGJKuEsZtNpNE06Ss+/RZKxqv+/zKQ6NPLe8G12j+fNdZ8ahrB/PUu2/EeFV9FnpoGk7lbjgkOsc26atR4UYhKN3sToayoaEpLSrkWVoWLi4brGOT4/JZrJ69OjY3eWWQOdRHJlK4TP5W+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKmZjhgJbNKBURXt2+DAWeQMfMbEuW4F9vUR+qpVg2M=;
 b=eZE5UfP/Saun6oDNhRuTMnT15hNOiHKdtfPUtl1EUgnQK6L17HlymiHusC7I5HGSPRkdIdEtjWeOtP1Ly93RPvrfjWcE7x9i52E2Kz4nyaS5HIHql4exTbBWDf1NDPo/j/vEBWWi1FEASAgTbIV20tAHRHF81awjUGRcWnARepyXcZ+WkSRT+2E80uB4/Evhl8r25naAOuWIMO813QkLBlNYzpPvsWYeymbrY3TeCQ2hS5txGRZqfFo+JolKFzszJw3DzXhON60JBGUL7E6eoUZNlFCn3fVtj3oAxcvTtiSUEIQJmEv9a3+ZCnSpV+rOBQv+1qfiRxBlN7lqGBgPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKmZjhgJbNKBURXt2+DAWeQMfMbEuW4F9vUR+qpVg2M=;
 b=HcfJXguy4v1ql4uYy96Br089+W4aYQuBfkWjTJ/hEW9bAEhHfFHpZgwKJgd4b7WHyEtHbn/WsD1Gk8IEi0A9/abzgF9e4X5SUaoCtfqmpEiOGx4SiuET6c89hjqDwy5ttZRXAJlB0Tay3QimX4ixSj/VYhvUErs+lczDbfWDq/U=
Received: from DM5PR06CA0065.namprd06.prod.outlook.com (2603:10b6:3:37::27) by
 DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Tue, 9 Nov 2021 23:05:11 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::dd) by DM5PR06CA0065.outlook.office365.com
 (2603:10b6:3:37::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 23:05:11 +0000
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
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 23:05:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 17:04:57 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: restore pages race with process termination
Date: Tue, 9 Nov 2021 18:04:31 -0500
Message-ID: <20211109230432.3947-4-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 237aaaf5-e89a-4432-9aa7-08d9a3d561a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3194896378F3D3647C195298E6929@DM6PR12MB3194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLnLR0KCXpWywEnUu0+MEPr98/as6RrlwIEMjpw0APIovXnMABPLMS4YyrDFDIbQIgwwyGuus2ILdDDFCtpImwje21+jkNVs8vmlbA3Kiz94UkQomiv4J6v5vpCwLQDT6grgDqw6vNnVgENFxnWy9hZmzeaUIVHFd18lS8ZFDKi2YkOld2op+exGgSYZALkpxiwYo1FAHTxReLAa8lx1KOuvYASfXvkcnuweR4KQ1O/L5vNVfBJj5l4v4+oQepH/9hdjK7ms44G/PhMJ2QaXFS+2QIIv6G0kGpVQG42fR5KDS5qnn7psFgq7RqM121untD5hf/aKvkVKH0SjlOFndOb7gV/9GTvuBR+4E5GSYEHQhVj7RAwSp7hRZz0Ks8+Yt9vcMXRm4IOxkoJS+SdEMXGAzzdWVusMqTsL4/GY4rB7rSQZzuFsk6nMgh/4zK7oFBSfYiRzGZdJ4faTLxzlj1iF+hs0IFFAUHSpPvv+3bPKcvSdPZLkXHWUkrnvd26OtfBA62+MCJISPKJlCN2K5WB4G6ZwXenhmOLZl2jAmfkdMfjjQPC/m6kKaOBwSEw11yVB2zpUlPuuq1jwe+mGBEbFR7KQT+Rv31lGQ0jPL8Wohypl/ujUhuI2UVzixsYjHYc9SZ3Lask8F0Gw4rBNlbz/BjVF7vNUx4zsw9BBNnYi1Gumf+kDeXjDdJLiikDwIQOwvbzSU4SEZLcrJtVxZrDDzykJxuJqJya6VZP1ezI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(26005)(8936002)(5660300002)(2616005)(356005)(6666004)(508600001)(426003)(2906002)(83380400001)(70206006)(336012)(8676002)(6916009)(70586007)(86362001)(316002)(1076003)(36860700001)(7696005)(47076005)(54906003)(16526019)(4326008)(81166007)(186003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:05:10.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237aaaf5-e89a-4432-9aa7-08d9a3d561a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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

restore pages work can not find kfd process or mm struct if process is
destroyed before drain retry fault work schedule to run, this is not
failure, return 0 to avoid dump GPU vm fault kernel log.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8f77d5746b2c..2083a10b35c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2596,7 +2596,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	p = kfd_lookup_process_by_pasid(pasid);
 	if (!p) {
 		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
-		return -ESRCH;
+		return 0;
 	}
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
@@ -2610,7 +2610,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("svms 0x%p failed to get mm\n", svms);
-		r = -ESRCH;
+		r = 0;
 		goto out;
 	}
 
-- 
2.17.1


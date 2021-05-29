Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C7DC4708F
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 22:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D41610A8
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D41610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B64F6E14F;
	Sat, 29 May 2021 22:51:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0646E0D4
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 22:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRIHZL+Wg3OCvi4O2ysyCbLoAXkZRkDZ7dr6xDwSF5HWcjypR+Jxz+bBmB0r7G9LXd80Sp02MHPEQBs7DGcScIPoKHqsL+GbfrgFlzx+why/0zV7O7Fn4f+bPjudjY3moFIgBgj5HCittKXCIPpH4wzuHP9WGjAHqpUjnBMV1TyfaxQEuqjCi/K+6RYKgltyn5mSOxCsGSOV2EADdzscpZm8jKrepQLYOjleu3jcrTnH6/7FsXP9u3ARyOoM50H1A9tw9flAHm1fZwrKVg4e8RB6Wn3nlFmIjC3yezJ21LAiJl3xKWQQ0OOFdUelGf8OZt4C6/ZnIEijC1EnV5JSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVXzJgcid8Ujg8fomfvjqe85K95eb9vhvKz1Lhwwniw=;
 b=kcS5juCsGlBsxojGtyrljZpDAL4tfoLNhDLP4Fk4SEDDap3nTl2pXZnHgpXqAXTU++ecku0h6kV4u7C55F2/O/YBobyJJm+fgu29TSLuw+6YAVYYYAtp5nN59yP/JFegGV6Js1XTRKc787IAOtzWfNkynsjiLHQgarz2JGCvLJDJlAMUrMUBe/g9pwuuZMSQYCEzXZZplxXxisbM7GKIQ4GirEz+kLKcmBxWZXmjVax8lIwuho0rdtNLADxyRcgc+WSZA6BOfiXrKiC0p8zZBqoRAcMr342p94TcCtULJqafUVBsaShN9WlmnxEcy8TZV6ZsTDSEtF7LmplRvCRiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVXzJgcid8Ujg8fomfvjqe85K95eb9vhvKz1Lhwwniw=;
 b=UFvzpTkxE1vr3p8AqwDQkdp7FfIX7IuDf3H6kVOOELnShjGx2fJ0kWb0Rj01GerGSjdk/jVcLbywOmeYEzWiZft/DLP3oqnfKbBoT1sZZhMfrjXB1F/yqIO8s+BnAmIytxnZkRGblK+hWLHdfkz0UIwao3yParwJKTGiwG/HirM=
Received: from MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) by DM5PR12MB1129.namprd12.prod.outlook.com
 (2603:10b6:3:7a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Sat, 29 May
 2021 22:51:18 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::62) by MWHPR1701CA0015.outlook.office365.com
 (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sat, 29 May 2021 22:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Sat, 29 May 2021 22:51:17 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 29 May 2021 17:51:16 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix a bug on flag table_freed
Date: Sat, 29 May 2021 18:51:00 -0400
Message-ID: <20210529225101.459466-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 813aac79-593e-48be-1b39-08d922f44562
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:
X-Microsoft-Antispam-PRVS: <DM5PR12MB112960EA3FD383E690F0AE4482219@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: li65QpkxE6LxacSgamHtYNBmEw0+O+CcGejYvP9NCWNTR47PH5opXuhaxzqGPw8N7wvyd4A/UQu4Wimngoy4wOUpw7DPSWxY2yM8Dhoot5YOPIDWu9JOhe3DQ751TsnqITWw4TbcXCstn5K7ZescEXBbkhY8pomla/yQyjcqwH0StcA6ewkcFL7ZOWumXOGLbYK35Tu9fAXgHn9fexKtKIg8PJdGzNcASnTSB6wP18JevRsJHCcsQI8RxTFxrqgwG/PV6wrQvkQvMhtYEgCNAlo+KiuGNLWnUcjq3vEcrEX7FR6aZbWbYkQ/XaV7A18Bz4Wb9ZazK7w5aPEAGnHYp7zD+iVPX10yiBiIVSoSI1aid4Omc6Hh7H3ENvRTKj+XHNV9xysvsxp2xoTeTtWsrZKTydEVorpLwx4otQS22/rKgILifBWl9uTGMzospuTyha557k4RLVPFL8R2c/JQOUG2lVimBjdoK41XdSFiQ/HTv0wy5PBpnQCbIfRu226zGYT8bpM2IYh85mRbUN+IyOHvaBNWRgGZSOsf9N7ET1pyMQAu3z9grxF8bR8lp1CWRT2OlpqVw2xjSwXV1ysfDsk23z0+DTZwj2B+iAZy3A5WS+M5ojboTSvMb/fQXSxgevYH19RyOij7vXC1Qki/h+7BuT2Fq1LhyszIH1P1DnsuxUMsbjWL4uIALyulpLtC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(81166007)(83380400001)(356005)(426003)(86362001)(82740400003)(26005)(4326008)(8676002)(6916009)(2616005)(2906002)(8936002)(478600001)(16526019)(186003)(47076005)(7696005)(336012)(316002)(6666004)(5660300002)(70586007)(82310400003)(70206006)(1076003)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2021 22:51:17.9448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813aac79-593e-48be-1b39-08d922f44562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

table_freed will be always true when mapping a memory with size
bigger than 2MB. The problem is page table's entries are always
existed, but existing mapping depends on page talbe's bo, so
using a check of page table's bo existed will resolve the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0dee2e8797c7..95b94c95adac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1582,9 +1582,11 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			 * completely covered by the range and so potentially still in use.
 			 */
 			while (cursor.pfn < frag_start) {
+				/* Make sure previous mapping existed */
+				if (cursor.entry->base.bo)
+					params->table_freed = true;
 				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
-				params->table_freed = true;
 			}
 
 		} else if (frag >= shift) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

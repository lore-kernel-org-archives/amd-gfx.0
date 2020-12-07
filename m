Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE2C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E256921D7F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E3C6E8B5;
	Mon,  7 Dec 2020 20:03:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AD76E8B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 20:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2KX+uFw63nzs2RDVu7heY7i3q+r7nyCGsxth6AaHjbdBSUASyOLGAYoEF9IsP12uQ+d/8EdDkO3SBqLNNRSkXHSseVWxoldCfPF/r0XSBKT110c3G1bij/TSfG8oCnFtjZN+mPk3/BUGJgftcYqk5SLtipictEXP4+DivxZj0Y+e9hDsmj0TBMPWz8t0CgrKOgJktkHIyTXUVduC7XKqegw99Cmo5Gk5zW4sVQJCmgcjdWQpWnKLzyU2dllbF0WRrwd5l82ja1SgwtW0raIhEj5Kmbbq1nzGUWZWldQkOg8W40Uk9IQi7/3NH17EqcqEBaF1YKVDXk1j7OcHqmzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY0uWBXHPaANxtjy1cCaILU2jJXVPiFDRVwkNTKPbSc=;
 b=VR39MTLOfhN4t3bTsKZEIZ+GC6dJ7WJ5eFtwkKJJ95krRcfUEb44UJDKC+WZYSOjNfU6MNfNk3cJifBnDMiFGBIO8Czt+4tjw4/JPm97HWm7uEwUlvbV0g92eBT/nhI8Jmv8QkvCUxzpwA76B6PcuYk31vony3f7NfsBvmz92iasXUWQbg6CzMfLUX6TXlE+KgrvSYfG57fVFNncTNzzDPXFIQFbCwyl++6ljyhKz0B5bUK6jTYUTKAiYktRKFsvPlKYQac8hLWlhRKojUDvzJaL6JdaqjLc8XBZZy+uw1hs84BvaNBtHrk45JysjDL2vqVqcuILbucJCcqo0ozaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY0uWBXHPaANxtjy1cCaILU2jJXVPiFDRVwkNTKPbSc=;
 b=Rx8amwOGwQf1R4LqKzebCi4qtEmWPKN7YZuvVz84ISrgI/wHgWu4I6MMnrBdCe7AdX/NhbrAuyJJFfmf6QABYSxSKkj0lVzpHw3spbTiRNtO72iHO7NiN0wkRmd3nNYSzAmC1EAUvkyMhZOku6StUlbQfISIzoOEZLgdhS5KDzI=
Received: from DM5PR11CA0008.namprd11.prod.outlook.com (2603:10b6:3:115::18)
 by BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:03:20 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::3) by DM5PR11CA0008.outlook.office365.com
 (2603:10b6:3:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 20:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:03:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 7 Dec 2020
 14:03:19 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 7 Dec 2020 14:03:18 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Charlene.Liu@amd.com>, <Yifan1.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/display: add S/G support for Vangogh
Date: Mon, 7 Dec 2020 15:03:02 -0500
Message-ID: <20201207200302.11479-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201207200302.11479-1-Roman.Li@amd.com>
References: <20201207200302.11479-1-Roman.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae8e00d-681d-4174-e1dc-08d89aeb250b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3061:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30611EF63BB03C328FB288A889CE0@BYAPR12MB3061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdkZ6Y0KxZe//zBwMrD2iQiVi0SwzTiXs00BPWLXs4472CiTpanqEIzBfiIJCUzElzA2A5GYhbXWjpZxKYTDXehybi8cGUUaYb5y7DykFyz0uqVQNHtP49Kq9IRpC8K9Q00mKgvF3LaOPWprB06lrYhMBZX1AMwaSTveGQD0jIqPFTRvC8EO/A26tudL1NQzVHnh029TqDPwy61CsiHjZ7s4SH6oQ1XB1r6yBFEPl3/JXi7uG81bofPZ4pw0hOTsqWnxgDRcZFLmIr9HL4R2h8Fz3EFcdLF1ZJ69Mqr813sXgtSbAQvnDPkdgyOecwKYKgcKVEfz8XzN+keHGJT0dh0I2fXpdkEpggOFoIikHJl20A2GscM84WeDz8Cgx6U76R/RxMkqJ5von7V5N5+3xLUP+k9jFSSIgoijDbAWPLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(36756003)(26005)(478600001)(316002)(86362001)(1076003)(4744005)(4326008)(426003)(70206006)(8936002)(356005)(8676002)(47076004)(110136005)(81166007)(6636002)(70586007)(7696005)(2906002)(186003)(82310400003)(6666004)(2876002)(82740400003)(5660300002)(2616005)(336012)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:03:20.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8e00d-681d-4174-e1dc-08d89aeb250b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
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
Cc: Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Scatter/gather feature is supported on Vangogh.

[How]
Add GTT domain support for Vangogh to enable
display buffers in system memory.

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 63401bc8f37b..a638709e9c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -526,6 +526,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 				domain |= AMDGPU_GEM_DOMAIN_GTT;
 			break;
 		case CHIP_RENOIR:
+		case CHIP_VANGOGH:
 			domain |= AMDGPU_GEM_DOMAIN_GTT;
 			break;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

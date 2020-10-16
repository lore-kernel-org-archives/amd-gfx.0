Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E88C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 08:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266BC207F7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 08:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y/KhjHgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266BC207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0D2898AA;
	Fri, 16 Oct 2020 08:04:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4700898AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 08:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIl6IAdIIJeCBUITk+HCxdvlR9XJpDDcIFodZ5yku+3YM+1PivMKlg14elY44hc2kom81HuGGJgTtM+r4v1mUy97kv0iwp6C3sdvQKbvEzyEZdiNM5ivzsmHgx0DDUxhnDt3hW2/vSibu6eZekSDO8dg5lkyjVz9jUnGon6F41K8+9JkJYahZSf3v18UYQdy8I46y/hoAi72g15qizVtwDkmFb5l8jCTnJWyTuyZHXGWDxj58ScpeF5s7y4ABTBgrjj6lez3ZTfr2lc/Naa1UwvYxGbsDswUISlfxzJWQiFgyZ4Lw0jQi4+L0sATVwAA3PyDNUykrVoNJcX33dJLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUWumWkOp4Z+TL6/Fpwx+XbEl9cG1PzD+FuTH1PrqFw=;
 b=Fk2F+12vuIq/VQWOw5p6/W6CFmMAyZtEejddWx/wNBwxXiJALQgWiEwMHLPn063ceDNtE0Kjqme7HB2BMKKMFNkWAAxBu3tl0SjmnLOUJvus0iKLGIXlCeMUtVuVG/W570vPzfa/Cv1S9AltS5XoEzDMtqHKN99LVczn3t9Ba/riwDU0p4d0gVtmbrXZIqSPCMlCFwPspKelPztA5yuSQnvMcq7V1NDfB8NRKhJBDx8H74rRdtIewoSG7nxpLGE0riwZ6eJQW3KevdTbXYuGKpnG3l2vSHaDs27qpKDkViCHdiaOTKzxiKPue+trygkZl1gdMqe7/9dAa1B1VHj10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUWumWkOp4Z+TL6/Fpwx+XbEl9cG1PzD+FuTH1PrqFw=;
 b=Y/KhjHgEF/alKmK7ppPNWhQeun/isS9mtTgc4LnQh+kNee/xLdmXTE+Ar9qs0lYNVcfmv5WSW0bWb0J8/rfa46SZIbzZa5gzuw/rWd8bXbxuQsLMNswJaEjRHZxLJbAG7JR0k5tSIDAwX3CHbzdBpFmELF9HcEFjCR49EsLNM7w=
Received: from BN6PR11CA0048.namprd11.prod.outlook.com (2603:10b6:404:4b::34)
 by MN2PR12MB3533.namprd12.prod.outlook.com (2603:10b6:208:107::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 16 Oct
 2020 08:04:54 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::c2) by BN6PR11CA0048.outlook.office365.com
 (2603:10b6:404:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Fri, 16 Oct 2020 08:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 08:04:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 03:04:53 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 03:04:53 -0500
Received: from guest.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 16 Oct 2020 03:04:52 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: reopen sienna_child smu ip block under sriov
Date: Fri, 16 Oct 2020 16:04:44 +0800
Message-ID: <20201016080444.1784-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022f8b36-ed13-4b79-7e94-08d871aa2a45
X-MS-TrafficTypeDiagnostic: MN2PR12MB3533:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35330DDE314D192E1480D621FF030@MN2PR12MB3533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3jb0D0x4BhX+748l2RwxjKdyRpVf/Qf6IdA/Bp8WXL7iDMDuG9e1Jf+5oKBw3S24bHXYMz6y+yz1CpqsyeFI5FPUWqq3jrk3tSo4tv08GmYkGZqrj1YQerarCB62fYxhWzHYTzH0My5hIX7nL0c2wkiuXE3qRir0OfNfLsnM3CIwHe3LkETyqUCBAW5MKZg8cUm/Oq7+z8uPqGn6bqlgHi+hX7dOHNq1Vqx1QAvumTo6pg6M1S7jlm1odgrNtsA5F/6cPwfUTz88+cr5C6CEX8iizyit23Ayk232djTcS6+qLEtwGLqpugOH9FxQhqg/E2xwlq+gNstzOis9EMQ+J9cHdQptkbSayid8D8ycN8Ajb21TkIt7yR1EZba4LJP4Wz/TcNFW6IQJlFbWpNAqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(83380400001)(81166007)(2616005)(7696005)(8936002)(2906002)(47076004)(186003)(70206006)(70586007)(356005)(36756003)(5660300002)(26005)(4326008)(426003)(478600001)(54906003)(4744005)(1076003)(316002)(6666004)(82310400003)(82740400003)(6916009)(8676002)(86362001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 08:04:54.0051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022f8b36-ed13-4b79-7e94-08d871aa2a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3533
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
Cc: Frank.Min@amd.com, Jane.Jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

open smu ip block meets with one-vf mode need

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4b1a4acb60d9..ef52d46b1458 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -572,7 +572,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7FCC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B51420639
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DnbQWZcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B51420639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A95893AB;
	Tue, 18 Aug 2020 09:41:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB47A893AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 09:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7TjiBqJfKQ4jgONcv/sCeXbywaPWZyGbB6JHccJeH3Zgf9OmPyfWkXC+YfqEysSzu8Gb/EtVJCW1lG4zVfoXRBbARXhsHSuEcuXtQejPlSIYddCOet9Oh+v7T1LBlYWZfg+lBLq/4crm5tDTffOTIu60Pe9ARSKfu2BpZUv3PHFLaCsVwVs93Ut1asDn5Es/yiQagVkk/vvdXF6otgB3O/PVpQVBGD/DPYq7rWujO1cyRPTUG53Eq5C6zsChYZTmnJ4uB+QpNOu5j2sSXu3HauK/VWTYB7zfCzLPPvtx/p7sQm1sth1/1Rlbs3kwJelton2iYE/OzuQEe3SY8bKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS0a27Eo72Hs+DNdorBJ0cnQuOwdKD2SkSiMNwBTPgo=;
 b=nQ4A2t7sGIJ5xm7oRrBcM1Uj17VdiDL61mL0xc01ikuVwQAb9trAqAFhaPg6TXqoLgjOrcbr6NgGXEMu0rzoK7Jd2iaiQrg39LCRPU3IeKbX21G9VR9TkIeMAc/NMjGYExpAuGxKTBeNnamEf0dFHCRtSKvY6MY8h+WuvsT/gHzcT3jaYV4XptSIqlRT0mHmpVwbZh7nClo5sQmLlMpUD97qqsGMSAxnMYLXJ0F+LQcua+JaTJ725L5guJmW0+0JlbiQ0mDTvEIhXDpQg3+2EdQAWGQpyeBAdQNHoP9c2g9RVjVMKTr88qyBjWLpH5sBG0E/63IXsfCmyT3PNTzFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS0a27Eo72Hs+DNdorBJ0cnQuOwdKD2SkSiMNwBTPgo=;
 b=DnbQWZcpzIOzl1TzxDXjuXX/12uEOwcb1XssyCqGm0cW96CqHNaLd2vyFCuBLJJ7FShUTd3W2mjtJf4P2PMFVHNck0GCh0sG8D3XUDnX9JXXEngA+Ebm+MBc3CbWW8OD0/RMqnDjRlG6OUWF1Rp2WXUqsnWyJAry16e2Hsdt9Fg=
Received: from MWHPR04CA0045.namprd04.prod.outlook.com (2603:10b6:300:ee::31)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 09:41:54 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::56) by MWHPR04CA0045.outlook.office365.com
 (2603:10b6:300:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 09:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 09:41:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 04:41:51 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 04:41:51 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 18 Aug 2020 04:41:50 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
Date: Tue, 18 Aug 2020 17:41:44 +0800
Message-ID: <20200818094144.378857-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818094144.378857-1-Emily.Deng@amd.com>
References: <20200818094144.378857-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82edc1be-f124-405a-8739-08d8435af00b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43452B0BD275C0A7474535568F5C0@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ry8Zf9TfR3XBtOqB9VvuqS6uBfQBCsgYJyMw+eMnNhHpmlD7PwKVwEpHayRFl8A2Cy/Hms+ZQNSQfuMr/MkGqcPVxSYC8nm8j+903CoJ+qov3OAInkPlwNN4Eeh9baUhPECpgXka6zvTg58Iob+eG7Rz0LprDdLHF6iVUECJh7u66D7ay/P22w4PSGK8lNxSht2tLzjB2bZ2+HezbGixy1fK78DE1bdZPi7hEz3wOlmQVnm39ZcP2ZSZovPp5Rec+SsZ703KAOmVQBi2rO2orZWkYx+iOf2tgTLxON0cqDOHBt19aZE/cvlJZOtfWxTBCViRtNuv/N5w5eNDGy3heFm1x3IlnzNLJ3hbxe5wR3Ye3pOVOJKhDGswzeBFQ5T6LWaKsZ8S2GSTDM5Vd/qkaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(82740400003)(316002)(356005)(83380400001)(36756003)(47076004)(5660300002)(82310400002)(86362001)(26005)(7696005)(81166007)(186003)(6916009)(70586007)(336012)(478600001)(8936002)(426003)(4744005)(70206006)(2906002)(2616005)(6666004)(1076003)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 09:41:52.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82edc1be-f124-405a-8739-08d8435af00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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
Cc: jqdeng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jqdeng <Emily.Deng@amd.com>

Use function printk_ratelimit to limit the print rate.

Signed-off-by: jqdeng <Emily.Deng@amd.com>
Change-Id: Ief05debe30d975cbcf88e473c9f486d70b5a202c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a94b3f862fc2..727b909b4b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1296,7 +1296,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_parser_init(&parser, data);
 	if (r) {
-		DRM_ERROR("Failed to initialize parser %d!\n", r);
+		if (printk_ratelimit())
+			DRM_ERROR("Failed to initialize parser %d!\n", r);
 		goto out;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

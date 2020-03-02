Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D484AC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771E52173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XlmRzUZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771E52173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C5F892B1;
	Mon,  2 Mar 2020 19:24:31 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D9C892B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 19:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+nn4tQW7Yg6Wwea7ScUBgZNSyrHU9pcEUgPnabPqbInXzXlUDoylQJh0ypLkqe+oFq+KZh1m+aJdf7yexquFXbhYgBLlISAfSpxK/RkzLLBFt10K/H+FnD7qBEXTTIXNHGfuiNx6KIvVt576C8O86V1TQs676AXwaJYFm/ecMoDozzabEErPAWxtOhxLn6DeB4BE3PbMDzqFPwRdHsGZVFNWQxjQO/As69uv1wil8Su3V/8t9+2LPNi5dDJ5ETmMAJ4fxR6fIieP4BC4bZDS0FfXTErrvsJ/0GpteoCJhwGckj0bJXOwcM8yloHMFDaytyguhxHM63fI3aKvuvJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJBHsDdm4li5Qu6xOgJcK20gPjsyents/UR48ViHxzk=;
 b=EHcn1MzZOUdiTwvaSNOv0XeWwHseheGwAI0FWJc15GnXZrVXZ4LVJw4frnY5ZqklAWGcHtbPZpjCSQw4C0K2CtprBSwYLztfYRLlhGXRKhtctJAfOo6BR7SI1Og5o1YtZItnCW4CwxhIQxyKAF2X03PNV2F3s3X5sWpJyC9wjPXWdXXqd3iSpJZWCVte9yrjRVLZLkXXWnNJUMcXh00i8DZEQ+/yXlsgv6IDcMH1PRARtdSCbYtHqAULCnp/tVMmqj7C1ZVNukST6J5fyP4kpKAIT25P0sxQJh7m0WioiwHQrDTG2doctnW+cMihHDYUBpLUBJ5R8kFepX0RSpxLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJBHsDdm4li5Qu6xOgJcK20gPjsyents/UR48ViHxzk=;
 b=XlmRzUZ6umfDD+AlgBnyNu4I6ejC2U5b22R8BbGrRmEnEb98NMdtbrASL7U8dNg4C/5PtCKwGRQnmcus01EbmhtDMvNRXBVdp7+sfEAACbAoVKcKCsZNsY10c4gl4iGYIbnNAtES7qCriqLJdQScH/Gco3EFz4G+wOsKH/BnFHE=
Received: from CO2PR07CA0054.namprd07.prod.outlook.com (2603:10b6:100::22) by
 BN8PR12MB3234.namprd12.prod.outlook.com (2603:10b6:408:95::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 19:24:28 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::f5) by CO2PR07CA0054.outlook.office365.com
 (2603:10b6:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 19:24:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 19:24:27 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 13:24:26 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 13:24:26 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add support for USBC PD FW download
Date: Mon, 2 Mar 2020 14:24:18 -0500
Message-ID: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(428003)(199004)(189003)(4326008)(8936002)(478600001)(2616005)(81166006)(81156014)(426003)(70586007)(26005)(316002)(8676002)(6916009)(70206006)(54906003)(5660300002)(44832011)(186003)(7696005)(336012)(2906002)(86362001)(6666004)(356004)(4744005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3234; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd6f61e-59f2-43b9-7486-08d7bedf533f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3234:
X-Microsoft-Antispam-PRVS: <BN8PR12MB323409CDBEF54F7A4C8F9252EAE70@BN8PR12MB3234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3q+BwRN1IIhUhKa/s8pW59XHSJE75BfDSDQIAVv35OZVGfd5oQFguvNr4SVy6+uGIhC+7/BwKbIr7tCiVxT4fxrwmul0PN6IRjWe6y9sAiVveLLYOfxkGzeV6kMnhIDDle/IVqM6e6mawhl8Ih6YzIyWaVCVg7yJ8G7kJenrVaTaC8fzYfSbkD1Di0dWbHBn1HLlRu2UCBM6fHQ7DVF20U47aiVt9Pi+mdoWmXc6nclmuddyos5j1M9XHKkpsyOQw25Zz96ewDoR5JPEaJDPQ1FAYFccV+C4YulzyYqpO7MHbj1ZpvVgtEQBaup4RgOEvYaPeB+Eq3Bm4PUtXA2+5GpVa5HwPxqE5nl8khHo61U+gJbyvQah0NtZAbL4n3QM+ZeksTPq8OiUY1bhHQFRgcrFXzgVTp8UbxelnSnXulBfXHE3YPQ6OfOvV2C9cKG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 19:24:27.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd6f61e-59f2-43b9-7486-08d7bedf533f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3234
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset adds the kernel driver part of supporting USBC power delivery
firmware downloading to USBC chip on the ASIC. The FW is placed in DMA buffer
visible to PSP which then proceeds and copies the FW over I2C to the USBC chip.

Andrey Grodzovsky (3):
  drm/amdgpu: Add USBC PD FW load interface to PSP.
  drm/amdgpu: Add USBC PD FW load to PSP 11
  drm/amdgpu: Add support for USBC PD FW download

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 76 ++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

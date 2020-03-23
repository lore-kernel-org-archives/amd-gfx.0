Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E1CC10F26
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 05:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360BF2070A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 05:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vdj3K7F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360BF2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E5B89337;
	Mon, 23 Mar 2020 05:11:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED3589337
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 05:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdiK8a2OjyE5xZDn4lFSnU8tOW4yGt7Yp1VIHMfYtTfeHfr6G1zQydWbYushG/tQlDk7oQpkN0EKXGPMfSo/Q9PFBsKBd2SZd88yXvRY4NigZartos0eG5JnbL68h+JAwYKUc7Hdp7Xjjjohsp9CTygifoxAIY7B/ykRnlWJSbKAnF/cEkkjP3/L/JVivwLVWdcR3nbtSH04AbpM3g8RqbuR29I9N43QRyM5RucVoz2kfgxPCDyPWjwloVI359Ol16Yuu4ViNuV7730PNO1aNW3eFt+TPBgBepvMCJkGRjDUzpjZo1pg8ci7k9JvUxhXFuES18bIvvZe+CReNeVuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3w5R2jzbb8D0eBt59EkPNU7j0eeEGCNIhxehAgKQCw=;
 b=XNjodjTRh6BxSOjRjJhQNXQoT0SBUULzhpuG4D8lSWuQJwfyFj1WygqI1brNWufa8+qAkFcQBQMz4U7VPhEGIOnZ3IhIWZGdo3qJWlEDpVbD9ul05JvpIjfTQOPP67F9iNMILK1FJ0bYEVrUSq3zJRaEeq7GTQL8oOOxQq0gqtj+V5qg5w5LAI3tsOPfs/Mb2u1WrHT+PNPNZfVBMEu7pE2qTF7LfXby0ivd9y84En1aXE+IPO6DOfH3eY+GuNxdrhnQZsaGpLAEmpFhk1hqVPJJsAvfrYPReUmzlPb/AYfA7uY4I+kOLPKb4CJUrksCw+zhNlmDG/w2vQGOwsyKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3w5R2jzbb8D0eBt59EkPNU7j0eeEGCNIhxehAgKQCw=;
 b=vdj3K7F5ScLRRTWpWuKK1bTM5LXmFb9WUQeH48GtvYtefA9iyOWNtyoLvdEXK601eGjweNDii1DCSPjXrtrHFr4YSCSTY2Af12aBxRoiWTAfALzBJE//WwSIW1Yc/aebJ/0Oomh/29j4DJp8+GOAATldB0qzL6BFG1myfraYg4o=
Received: from DM5PR1401CA0015.namprd14.prod.outlook.com (2603:10b6:4:4a::25)
 by BN6PR12MB1793.namprd12.prod.outlook.com (2603:10b6:404:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 05:11:21 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::2d) by DM5PR1401CA0015.outlook.office365.com
 (2603:10b6:4:4a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Mon, 23 Mar 2020 05:11:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 23 Mar 2020 05:11:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 00:11:19 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 00:11:19 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 23 Mar 2020 00:11:17 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix the coverage issue to clear ArcVPGRs
Date: Mon, 23 Mar 2020 13:11:08 +0800
Message-ID: <20200323051108.19558-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(428003)(199004)(46966005)(7696005)(186003)(26005)(36756003)(8936002)(81156014)(70586007)(70206006)(5660300002)(81166006)(478600001)(426003)(8676002)(86362001)(6636002)(2906002)(1076003)(4744005)(316002)(4326008)(2616005)(47076004)(110136005)(6666004)(356004)(336012)(156123004)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1793; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 495e8445-64d5-4e92-9fcc-08d7cee8a007
X-MS-TrafficTypeDiagnostic: BN6PR12MB1793:
X-Microsoft-Antispam-PRVS: <BN6PR12MB17934B2E11702C83BFF578E0EDF00@BN6PR12MB1793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-Forefront-PRVS: 0351D213B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIHyspjVxPvDVio4ZxY7q33ReK5gGh6FndJV6QwsZoGOi4Ja73uW41WmplMVvmtbSUKrWUswt5FenfJW9o5jqPDUWuwfU6xXAUTxSiwjerO8d2dMWg3WjqjC6X6P1ZkbNfVmS0kh5ZrAknUzLExn7ZmF8vTfq376a7oJZYeryMdUyxPayMgAXOp1Pr54+R6L9YDpmT/jBsAVmc+LlxG25sh46B8eomGycvpyCHF2oe/fLlC+BIO0BcsPVFJiuhSZTaVta9jlr/6UhJT8lo5MeoUY5481bbIsSR3cAySBoyUIe9HrfMs14Gydosrw1ACgIFm704bDxqnH4URFsGrqzCSN42ADr9z9slRo7XcH4ULw/GidSqpRkKIg4AohJSl3VFkNnJP7BYKysVGobSnQ1B/iepG03Huios9ioZjd0QKFVCkfz0wU5iq8i4e4FiKTorIUGLWodMkRxysNqnu37YBoPdCtkj+LkfHRdi7aBRSPLUxQ7h2E6iblggzX1HgJ/ZMqbZzjl7Jjc8HDoX8Y4SBXd6mPOWFJ5XZqHO69vEbUz5ngQI2byONN975TWVXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 05:11:20.7903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495e8445-64d5-4e92-9fcc-08d7cee8a007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1793
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set ComputePGMRSRC1.VGPRS as 0x3f to clear all ArcVGPRs.

Change-Id: I296c3a162c0d5c7b84d4b48dc2002340a5c22e2a
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
old mode 100644
new mode 100755
index 324838baa71c..44fb64460c1f
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4264,7 +4264,7 @@ static const struct soc15_reg_entry vgpr_init_regs_arcturus[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_X), 0x40 },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Y), 4 },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Z), 1 },
-   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC1), 0x81 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC1), 0xbf },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC2), 0x400000 },  /* 64KB LDS */
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ADFC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 19:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023022242C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 19:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W2Uk/jdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023022242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B321C6E82B;
	Tue, 14 Jul 2020 19:16:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689CF6E82B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 19:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3xJICk4UcRfDxZFpfJ4qnwDYR1EDl1MkN9RnRfJLsN+T6rE8QIU02jlUgFJeKiiI3La+2ntM1SyImBPg4jHT9RuRYH83MKXKEritNZojbJ2VbiMmovEonAuM3QM9OtFLgn61V0Y4l7dMwBuozYmOmSDX3BeWkWix/XOrfR9/uh18e/TXd/8zcyOtTmFmZKyl8mpud1p7niGPmUF6SuDHjvJ8e/U6MQ1SNMIaIuZsIijvUtEDUhw/KFZDRW2EbmeBWv3qeYKrm7bZiaV49tKAd7GmkELnEDX5ecCv0m9Tp4p08EQAK6o8+rEkrD9ofucJrg3ZSVUJvEmIsrGwSS2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S53RBW33l18MrWlc8wn6hVZGB4DR4f1TCG0P17VsOd4=;
 b=LJ6zKNrq/eci7Jel1pUZDQfplXahojJJ7g6ptTI+4tcKlAlk/qNQbYqBW65xnh72pL5jzo3/+ol5KIXr4jf9yQaHNt4T/ZIR2zVAEDUfZnGPVSu8+1x9fj2UW6Ri0szFB+2YTymYoXHXE6SUl9BMbgIWSrVxrhrbPbuIRcuizssT3qzLdSSlNC4mIQ0R6rTa1eFJGo64zPRCUZWrIlFwdivi9kH9cwXK/4Gha7NCj0uaH/AA6NMkq6JlKcU5zmZKLFYlkWQ0ppzuyl7JPby4l6ypVa+Ftnp3AK2kM3ZTdy5QkO+r4x0wL7OdAT7f8vFQ3sKojBG3qRvRv2Z3Lvb1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S53RBW33l18MrWlc8wn6hVZGB4DR4f1TCG0P17VsOd4=;
 b=W2Uk/jdx48dghCn8ONQdRzK93t5flwO9DaZ4GPIab714nwxx8L9rIeJDbpmKwVnbeNmt5jGg50WGpsKbYwiAuaLs5Rzmrc5aefCO+MrZRQidALSDUpqS2Rx32LTlYswyk/XzzBBjjpwLNNPHvJmu8lLFz5WRsmZjU7NBi9YlIAU=
Received: from CO2PR04CA0088.namprd04.prod.outlook.com (2603:10b6:104:6::14)
 by DM6PR12MB3641.namprd12.prod.outlook.com (2603:10b6:5:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 19:16:47 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::b0) by CO2PR04CA0088.outlook.office365.com
 (2603:10b6:104:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Tue, 14 Jul 2020 19:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 19:16:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jul
 2020 14:16:45 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jul
 2020 14:16:45 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 14 Jul 2020 14:16:45 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: load ta firmware for sienna cichlid
Date: Tue, 14 Jul 2020 15:16:29 -0400
Message-ID: <20200714191629.28563-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(426003)(478600001)(4744005)(336012)(36756003)(86362001)(5660300002)(2616005)(81166007)(82310400002)(1076003)(356005)(6916009)(26005)(47076004)(82740400003)(8676002)(4326008)(2906002)(8936002)(70206006)(70586007)(316002)(186003)(54906003)(7696005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4847e770-db3c-4843-19b7-08d8282a73d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3641:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3641F3F85E7493425445EB61F9610@DM6PR12MB3641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYxM/Dtqbr7b8xaT2UyngmkofK1UWnR1cD4WNGpXwk36hCrFEu1nHxZy2ODWPEm0tltUzwoO80ggPRklgR4vnolz4GuJZCifD7jc/82kgQVg7CzFlYYCBJ33T6GhJ/KMj5+e2XOATgAQSvN1z4EQw4ypkh10qDDZpUqq2lo1dA3g4Ci49eUv33r0dZDqgLe1RyfyC+MBaLKw82vQO0Xrfh1I10dqrOQB5k+zCa7tzdl9Rbl6dpVhWm4hccVlqMS58FQSqS4SW4BGg6/BFvEd+WWSv6KjjXz0OUnRybBMfNrppKMJoPtODKXTuDVQ3hhnWu24abnVdrqi/WyAGniHU4tjRRfSZWM0EtyNVS/NvUPF61xsnm+E/faRjiEgsa07g1AQS5WbD+/m/eCzXeNYfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 19:16:46.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847e770-db3c-4843-19b7-08d8282a73d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3641
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
Cc: alexander.deucher@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 john.clements@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

call psp_int_ta_microcode() to parse the ta firmware.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 423386272920..798bc7b2db39 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -173,6 +173,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		}
 		break;
 	case CHIP_SIENNA_CICHLID:
+		err = psp_init_ta_microcode(&adev->psp, chip_name);
+		if (err)
+			return err;
 		break;
 	default:
 		BUG();
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

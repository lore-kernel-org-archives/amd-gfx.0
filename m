Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC18C00A89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 17:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B8120731
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="au3GgGSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B8120731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71676E9E0;
	Fri, 30 Oct 2020 17:10:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F0A6EDFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 17:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxywdD+xn5Oqo3omDsv9b2uS8Hmrx6JlLpit88/wsN44nY4/gfkHLFwMlkeKWSSLro2y4dYr2W3qpfujc/x8pJinp/v6qHyhD8SRGG4dm4H1f+qHIHzrPCAjmJ5p9VlQJW5Q9s89vnq9sVg/O4gRhyhXdzyt3eecR6UNCcgdoX8CFl53w/m3+CZynLaChH/86Rt8ogvnRdxwZLXcJwes8GvN+1YYlRHUPGImvdU0Yl3Gx9RYPiri/o/gri+uMPwg6/p5QM25T40YNpehNCg+mMhjoRJghfodX8gYk37wEUNh9bDXmXUNvM1T/567crpUaqbvfuLrpwmlFgikpUpg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8B2X0TGPsMjRnE1jHNVOWwtlHJpW72RzlJH7LByMrI=;
 b=dfM+i0viMuK4O+3yYK/5vTZFIJGzHEIqJzfxn8yam5MzeoPJlUEITRihIG7SulUEJST29xht7Q3fot89yXs+BBHgUOoyWab5FtaN3aQY8QU9yyMMvYBgJEFIsIw9u3Nc6B9iN9REaWInqWcIIbzoZ3myFDOpK6kr+DWT0nefKuhvaZyMlFEVQNzZ7xzlttvbPtmTKN8L/elYKo6oumLwyGRNMsCbJtDRleXSnS6ixHD4Otww/YnhxoYAL+nS7QslZMX2g+31uDFKq1fNr8Yr2wkCr+gQpzXH9K2l6UNl8W9BPJthddHTSxpdfT1hYSZqg/KXMNR3pWgxbWSpf/8K+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8B2X0TGPsMjRnE1jHNVOWwtlHJpW72RzlJH7LByMrI=;
 b=au3GgGSoxnYAlxCrA7yBCMmv08W0JioS93sTaqGYJathb9cd+SBgYO/BXousnEHiVvf6L1hsRmQpu1+a1Zm6P6TEXZGUTHbUINfz0tKsSJBGBfjkSJ9yBnahQCxZZL4/Sf4FbVKOzUA7fpoze4dcNemYBAQAiQhn7uj81eKXG3I=
Received: from MWHPR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:301:4b::15) by CH2PR12MB4874.namprd12.prod.outlook.com
 (2603:10b6:610:64::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 17:10:51 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::43) by MWHPR1401CA0005.outlook.office365.com
 (2603:10b6:301:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend
 Transport; Fri, 30 Oct 2020 17:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Fri, 30 Oct 2020 17:10:50 +0000
Received: from amd2-Dibbler.mshome.net (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 12:10:47 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amd/amdgpu: Disable VCN DPG mode for Picasso
Date: Fri, 30 Oct 2020 22:40:03 +0530
Message-ID: <20201030171003.458965-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f94cd1f-9867-4cdc-55c6-08d87cf6c0ce
X-MS-TrafficTypeDiagnostic: CH2PR12MB4874:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48744BC7AA6353761FB61E2DFA150@CH2PR12MB4874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2wX9cRcmgp+PKG4GvluKj/1FE9Li7oH91prDLNDUqI7OFAInVebUbG/45cmFUlkx7ABR+gmzjkWAvPtguwAHlYOtUmh9RojtqigtSEEy7GMdRlm8gYHqI6P+sKzK+lmf/i9aE9VpG79SrpJ1n6ez+cpeKzVFM1nmTsansRMXrCH56tawRjk4y6nK9Jyr5Vexc1WeuvbsyGS3XgnFrUjbcUNDpVXn7LMwtAHQMTpyweUqt0F2tX9UMsybutDE1Ep3w43f7cRsos5buLNn0oi3bEj30eRVoSEupdq6XL+jVmLoG/BgxM3uSryIJjWCqhe9ObczwjHEs9iyL7X7XJinqiWiWB3UD41r3PAkDFK7WLlIi8nUcn6bPBR8i18Kzi1TAtvcQFeznjRKSmo+ROweg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(336012)(8676002)(316002)(426003)(54906003)(16526019)(186003)(26005)(36756003)(2876002)(4326008)(6916009)(8936002)(2906002)(478600001)(86362001)(47076004)(356005)(81166007)(2616005)(6666004)(82740400003)(83380400001)(70206006)(70586007)(1076003)(4744005)(82310400003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 17:10:50.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f94cd1f-9867-4cdc-55c6-08d87cf6c0ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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
Cc: Alexander.Deucher@amd.com, Veerabadhran
 Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, leo.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Concurrent operation of VCN and JPEG decoder in DPG mode is
causing ring timeout due to power state.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index ed7342bbf801..f57c5f57efa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1195,8 +1195,7 @@ static int soc15_common_early_init(void *handle)
 
 			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
 				AMD_PG_SUPPORT_MMHUB |
-				AMD_PG_SUPPORT_VCN |
-				AMD_PG_SUPPORT_VCN_DPG;
+				AMD_PG_SUPPORT_VCN;
 		} else {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 				AMD_CG_SUPPORT_GFX_MGLS |
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

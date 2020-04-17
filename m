Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECDCC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C4520780
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 21:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m3YQ4eH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C4520780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21EB96EABC;
	Fri, 17 Apr 2020 21:46:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D066EABC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 21:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvY2ELhN+IEx/tb3ZwAujX0+YnNVILJRqeP2sySCcavqkxjSMEHfqS0+LW9crLwawebjNLs04d3/NNMcLeWnTKS8OYk3OMUgfz2oOoAPFvwENJ4JzpBR3R/mrp+v7MGx4oexY+gzEUPMwY97wqooLs9POYB3ckxXQ8FHCAhHEjKy/Cju7vTAD+tyRu92k28cj4OSX2K11Jk9aHVuCRlYr4UUwTIbP0HFa90QP21wfJD+2PwNRnF+JZCTnpNUVQo2EHHkPuMJarcVyK5jrATxChxr+OAU5TgGx1wEPRDxgJtSccPfYQLtu6IMYkuSnLqUDg70pNjf8fVlqI9FUB6Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmrtGuSbFET/fdVVCh6gT6fcGBdU7jMG+43W8g1kKPU=;
 b=DOnCKTaDmsXBmSt7ZDjEM5kxfXtKLjJ99EK2/d7mCfb0dT1+pitts/u1jpLhuCZJXy7Ruzi5aOGTW1e8TEJmSe8co+XY7SKDWkpI+WQBnyAuyC31ROv0Se+kEWE8TuIVd7tV0S5rZKbGrNR+QnzpVQHZtZ4DKHLUkvQIU0EXClR+f3pvjO87Hr1m87B4hjjf6xjDOUlS9Y+pWVlfwl/qs/Bf5M1FO0YHPsaSC8noFxX40xFMuOY1NreWeuiC1jYiz4Za36G37+FS6llOYL3tQxL0M67Ddx2Orm32f+AvCkJZYqsM8kkWWT1daprfJPIdOswqNUA3KsiE8M4SvuZLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmrtGuSbFET/fdVVCh6gT6fcGBdU7jMG+43W8g1kKPU=;
 b=m3YQ4eH2yzeJI1noI3HXeYUGhNM6uk3Wy4zjlClYuovXGfT+zhNgtG5Yau/iTMe7QA7Yrh0Ql0Guh9MocS8d02Qjna3yWnKeYmRDShNigZe3GGMR/dFdECvCFW7AMRK1pT0swg+XOIdOB0mUFIIcFKCUv8+810IkjTTrEhljE2c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 21:46:40 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 21:46:40 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Print CU information by default during
 initialization
Date: Fri, 17 Apr 2020 17:46:24 -0400
Message-Id: <20200417214624.20047-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::37) To DM6PR12MB4482.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 21:46:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5951708f-26cc-4f76-eadf-08d7e318cfc9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:|DM6PR12MB3228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3228FA9C95D4F65F6D0E154EF0D90@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(4744005)(66556008)(66476007)(66946007)(26005)(1076003)(4326008)(2906002)(6486002)(5660300002)(478600001)(8936002)(6666004)(6916009)(36756003)(7696005)(316002)(8676002)(81156014)(16526019)(186003)(86362001)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhntnzvaGdIhra0OYb2FEj13cgdHHiphNBeYRwMktUnwdw0BNlJpqFwZkOOjXBeJlJW7bE8jWm8XubyzbSxnYKzZlczCopihzAic+/PeqPmgwYq8mM+iNLeC2Vxi1A6yvBz7cy07wGUD/rvEx8pqS7ks7EvqleS9QsZEnBftOlgNxQKTiUhGtdFVZSc8Pi05weley+h1zMPO0WMfS5/3b0ona+9R5LKBHhJr7gJ2l2qxSraT01Qw5EFmwOeiHXzIth48X2OrNb+P4wS5YkUbJdII8xRcjiBBbo5Sxrt7u+taMIIUzWy2Fm0HdWLrZ8aGfiPFgmzJKnEDQ+TUG/p0yeOZovTs1B63i8hD+zeuQ+XJM3zoG84uHGl9FtCVF2f1rATEIeYZP+XGNBOqentmYEBR014oDiZ3t27g204ltpxXP84A61HyvIkm6nxenGOp
X-MS-Exchange-AntiSpam-MessageData: BKW7tOPDGE0XCGPc+Q4qKSaMUSINp0ehz4ped+29Zj2YZdSQyXobYF0N4Eb8MEO6aLblU7RJkqFoolWULHlLkcgwFjwFn1pNu69qMe4Zu1EtrKlNXJAY0wFO9T2CrTEFCKFaOAUmZKuVP/UfdNVT+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5951708f-26cc-4f76-eadf-08d7e318cfc9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 21:46:40.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m8JstqCknAI7txUPe9AXRdEdha3QoNqWBYMmncCq8NrVx0ZHlUdnxBD7nVeHEa+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is convenient for multiple teams to obtain the information. Also,
add device info by using dev_info().

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71ea56e220ae..423eed223aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3170,7 +3170,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
-	DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
+	dev_info(adev->dev,
+		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
 			adev->gfx.config.max_sh_per_se,
 			adev->gfx.config.max_cu_per_sh,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

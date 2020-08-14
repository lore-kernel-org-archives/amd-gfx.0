Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9860C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA99620866
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NoeHtqE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA99620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897DD6EB7A;
	Fri, 14 Aug 2020 15:15:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F536EB7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 15:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldgD2hpk6VUcWMBozrIG5QA/c+i/U8Xu/qZyXvYUmGtQjKzrpvrMXCuWn4dAcRo+Bb6kWxm8oSiCElB8aOGVwJawo8zLiT8rmfO8n8mh3FXf6vr/4Ub6ul+N9Cv5frVzASJ7dIyAopzMBE1LgnDohEYq44yw5DrHN4810Eokg1U6kCN4/vFZaCNPgCQ9AazIul/hzZxR6siOZwBCXgsRnBDGsL/iWJ6dqHYG0z62CkxdSlW2hLzgFdYovKnwLrML4OQiyRgrVGcpKRBJBhVpzcIAdNFwrFdMWUIpCTML+GNx3lrB7v0t/8K3BgscPeZnu9IHpbr1PC7YIbB0t29u9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFZbjwamgPYdpSTM4auy973oQ4MRbQNJQzIxoSim5X0=;
 b=ce+Vi7vS1vIYvCR4109IcigNxO/P/g7zP1RVXAeEr9zCiKmr7XVNtWl5pjjHQx2CScsn8zUYSRiQk+fKgyyt7cN0u9WwR7BsjVyxt0jRKuoZ3ZLFRyuvr5zNfGI5DvM6i9hwZGN4DLNGeIZ6ewqMlPjvqvnIG2scIFq/Pfhccn3P+AbkRQ8WNWHpVce6VyEXBcSo+E2KCGd14NwB3L3pzizIk74iuMM9DBoz5B5SKKSaHoELFa3mw+LCQHCmwbsQLOGTMwDmlHliSO3nPrlC8C37H7WqUHsjdzoLmXtmFKmaYnefcyl9TpaOj/wmcTxn7pIq4u/EpSWtKMk3zQmrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFZbjwamgPYdpSTM4auy973oQ4MRbQNJQzIxoSim5X0=;
 b=NoeHtqE+CJ2Ll4Rtl9ZnFk4J+5S6Nfkde5Yi1kWNo+EF4DP0fpsE0YyP5VCfxd7Bt0QcGp9cio7/svnjN/12UqAOPYdVLEDVqLsMRZcC2l3ayL1RR/fBcSDzzw8yzGpsr85W3IocY82ssSjvESRnEv83p8BQUWpW9lHtciauWaQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 15:15:28 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 15:15:28 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
Date: Fri, 14 Aug 2020 11:14:47 -0400
Message-Id: <20200814151447.12862-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813194047.13162-1-leo.liu@amd.com>
References: <20200813194047.13162-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu-Golemit-RV.hitronhub.home
 (2607:fea8:a3c0:203:605e:e342:2709:5c29) by
 YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 15:15:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:a3c0:203:605e:e342:2709:5c29]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1764633d-f587-4c8a-9820-08d84064e02e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB418768A5501FCABAD821D764E5400@DM6PR12MB4187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zA5r2MeRNTNZQjRI7F+KpmK0MRzl1PK4R7ZtKQXrwVp24+F5VZ1rK2SjNjRHunz5sS6f6/M1rWW3q24Mx4fYmdhJfKlQQ7geAqMuOxR4vZsm8TGSK31kwCmBHglWtW1kjY713wHuSC7qfKyy88385TUFWlmX33VEcHrUJcZKPemS5vSXhJRh1wC+TYUQRtxMDLKAdmGfnVPtSw4b0+Gma6vtBforskta6xevQ6jLb1W6Y1a1rLciDcqRdfuo745qDvAmCJvXOttPwGxdjXBgIU+tag0wE1qUgb+pYSp3IVXRH8SIJagdwe7X71FTCd9j1+3ZLRfDn/xjnP/GyIoMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(478600001)(2906002)(8676002)(6486002)(86362001)(16526019)(186003)(54906003)(6506007)(5660300002)(4744005)(1076003)(2616005)(36756003)(52116002)(44832011)(66476007)(66946007)(8936002)(316002)(83380400001)(6666004)(66556008)(6916009)(4326008)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 690FCsHfDAVm0xeAyPt4CgbbtIlo+eLqUS656qbVEvJOK8C9CBq8a3F8DboFXCnCYyyG1xelrNtauoKlgE9JGVEOGk5WtKFkZJmnE+ooMBEJ4VXVthJ1hHmyIfVYJPExftFGzTsDqP+Ire15dz871tkBU5ObUmGlo36LL9MQJw8vuYf0ojKHScrF/qYGBWqxyDuR/Y4njIS8m3sjnX/ZnxYPqqnrJEo26w1me6rhaE/ScPKMo82zgffVFR0SzLEYm3WfviGAp3rOwOPlEztiGRGP7d7Aobgn2nnCHXQ9z9k9LGFZUJg+WXMWVXQv10mzu+P6+YWc7dLhZke2poqWoudA4v53zOYC7gAhiO5Ka4xSM0jXAkPHFklGTskYSn0x/ZB5YITiSU7wCR2pOOG/yZUjmvKcTOj+n2B8HFnTY/CmSs4IRQtt9ZNFnFmtwS+9W1EsIJpT6y7eScoj4Usx0cqolk8rOKFxfM+VQIW3EE9yy5qgpysIpvwxfA8rK+UKWe/2qEBYCpYLrUJmZeBulqgY2sWsdqFUAa0OnKz14/HWDZ8kW0d3zvbGjituYrClDUL4+KuvAbTJ4zWMTTqoaLNfIs5jpuFLmrtFyq9Vgz3zJaYU6x1UNg0xiOTznr97VekqRjWe2dETBw+vrlw/I9Cl1OeDSIVJyZB2+GCCHYcpOiCZ9TrPTGTI0aX4o9lIQvLepVzo5sUf69WvfrYIew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1764633d-f587-4c8a-9820-08d84064e02e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:15:27.9110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM2U7mTRzDFubWyoj4N0rFByyClhYv+rJ23mZGvSzEaMHmoQ/NwDLy9SeAB0maIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix warning from kernel test robot
v2: remove the local variable as well

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index c41e5590a701..3a0dff53654d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -460,15 +460,10 @@ static bool jpeg_v3_0_is_idle(void *handle)
 static int jpeg_v3_0_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret;
 
-	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
+	return SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
-	if (ret)
-		return ret;
-
-	return ret;
 }
 
 static int jpeg_v3_0_set_clockgating_state(void *handle,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

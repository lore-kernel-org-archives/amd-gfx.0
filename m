Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DFBC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DD3212CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DDaI5bs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DD3212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447956E1B3;
	Wed, 17 Jun 2020 20:42:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999DE6E1B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 20:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htd7Sv8NON3KhS2JsuBgo7tXUsj2NcYgQWV54jA+TQredjZ9Wn5PR44iLqbWZIjNTO6feI91hymS524YReLF0jTa5bJcKt/IejgvfHMI4jFiz/nL/WYTaNuTo6l4aSxYvfNoSo5rVq3uAXPR5JDMFvfHQTmUPLQFprVxOuPXK6p2gBJu7bj+GtfIVTf+aRIuENTheGLY8boldD/wRERLIu6ugwaMlPNiAGCS1L+jQHoCyC2mkbUP81ARW8NpSp7Gi4ubSyTL2mYGDOSuQbNEBEp3iHQey/LN2oK3W++C0c5ekzrxu2nrYojlW3xbJrbhb9GeumkImxMKv+NL5+rnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZl4ihTJpdCrJcnnQk0Bb5bzMPw5+YuujIxSSB88E/k=;
 b=RTNsHmOcjsXw71niE9a7dYfEjZ7E4Y6xuLNE7ZsU7nDwtKljrOjxtquWAwaAysBaiU28DvXShAckwd9rNi7SRr1ufpGVD6ILry5MDUKR3CTnlnPYkiAervM1dqe38E3+kobiLAGyyq7g4PZw0t11iClXe8L6nHaikR0G9myMBNSH/aZ0Bk5DDGrQJkc2Kr5oQ42MsAI6Qxzlb2JShkhdOCZ7IkIwlwWP/7SHLErf6y6nL5+uDZEW9oaWEfSWXPEA1878IlZq+ymnwY9ov0OU4VKj6VRtsOnCq0QeUsiqcX8mWGYDQWN79MiU9S04y3e4nfq6rbnBHxWNzsSFYYtB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZl4ihTJpdCrJcnnQk0Bb5bzMPw5+YuujIxSSB88E/k=;
 b=DDaI5bs73H6O1mIHXdbZ9bKBHBmOD/QcIrghzIR9MMp9ug7D3bvm38FRmD9JtayRPlO2CBEPkRIFZgmxXWrLvrew2Bf51EhO5sBY295lvNw8m2dr0+rqCf9oiSKMd25bbr0OaL+ugsZs2WtNdZ2fZx4PGDvRCTUzTubfnPTcAVE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1420.namprd12.prod.outlook.com (2603:10b6:3:78::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.24; Wed, 17 Jun 2020 20:42:07 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 20:42:07 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: vcn_v2_5_mc_resume_dpg_mode() can be static
Date: Wed, 17 Jun 2020 16:41:54 -0400
Message-Id: <20200617204154.1199-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jz-tester.amd.com (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 20:42:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c12b167-d8cc-4fd6-371f-08d812fee65b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1420575A3F203D0D100EC3B5E49A0@DM5PR12MB1420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMtTCCACEKhX/lV2QNYt2erTeXAx+mqdx7yabL2kNR3vL1gvk0+FnzkoyLK8+x0FLgA3DjIf/ykd0vniO1PC+DLzHQMpT56YSNsZfzhQuw+Sq4BvsVohAR+9Bv18xB6rHNTtkshAkXC/bRgHURq6SMXX3haXjTaTyYkie3XX6Z2ENyOPr3bfccYN0dno2XhFqxqjkSzVv/6Wrx+NDnN4x+cCFTvVXRG2nT2E27bd/XVkeWdiUCT2SNXcQvw0IssMyFRanikw2jje5QBp9d12wUiDziybV1bOZFwvq+ew5bHT9C+/28tiFSKBqUzcvg7JvVJihtPdxmm2HoZ3WwkiHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(36756003)(6916009)(6666004)(66476007)(66946007)(186003)(16526019)(5660300002)(66556008)(1076003)(86362001)(6486002)(2906002)(478600001)(8676002)(4326008)(83380400001)(2616005)(26005)(316002)(956004)(7696005)(8936002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yTazV7EY5N+UZMpnS7Bpqu8jrDuDyeixIXffRGjWQHp6Okw6bNPPE0Agd2vj023sZIJsFjYCIrGViRKjXx5DgnytXU2om5NaocAcn3r0OxTb/8KHWGMJRp64PxO10/q+p7rUi05pxO+0Fc/dwzKAWrT8gxPNbMYqRw+ERYL3Fp3TJtr7t/F1do7CT5OUPuWpR0z95GmFTAwfcP1s8LOm0Lx9hZskkWs/T6LCXdilIz8hGcq8kzQvwaVw6axqlt1QgSiRXNftTtbqgudAymAMdy+rIee9Dk8n1NH36OyvD1/6dsesT9vmlfFubLRIrJhGydCqXh933Os0lWpn0QP2NMyAeDhvkf+D7tn1p/RxbInlObsjYP93e9U/9YLFiLmhrkWgltIZ94wiXSa0Sf8DLblZ+bcOCXDvms2/bwpxp3ODSSjY2xsf82wZIF/yXABTRdyRpUHN9WZw59mhNUKerYoREseGmsbsODpzfO3fnGrjWoQnqCb6Dasp6odE7jZy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12b167-d8cc-4fd6-371f-08d812fee65b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 20:42:07.1004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQ7RtkrsGsCU5ZroUErYxfEcOKJYnj6/Ye5yGj5ZdPGNyZU6ZmxRSIgLgBZMJw8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
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
Cc: jamesz@amd.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: kernel test robot <lkp@intel.com>

Fixes: c422a628925d ("drm/amdgpu: rename macro for VCN2.0 2.5 and 3.0")
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 261afbb504bd..ba1c4fbc19dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -443,7 +443,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 	}
 }
 
-void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 	uint32_t offset;
@@ -657,7 +657,7 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
 	}
 }
 
-void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		uint8_t sram_sel, int inst_idx, uint8_t indirect)
 {
 	uint32_t reg_data = 0;
@@ -1300,7 +1300,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }
 
-int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
 	int ret_code = 0;
 	uint32_t tmp;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

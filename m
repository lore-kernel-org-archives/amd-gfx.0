Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC31C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 02:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4651720872
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 02:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHlMIu1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4651720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05C96EABB;
	Tue, 27 Oct 2020 02:43:19 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7DC6EABB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 02:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAhkYDKZKImpmqGIE/ZDuU1ChrGYyl1pTpauJQvNoe05Nw2lIYri8wCzzk/Gxk5VDS2jmiKRz4Z2jVGE27MbmsdtvCuSZaoNJykZdzQK6/UKzy9zxOhXX18o/DvZKKvYDuR9ihkY2KCoAbZy3Yay9C6mgBjM1EfKRykvadXWov1YZbwPDXejWRPTWxj/f23T9mw09/ct+h6aYFL/07O+w6HFkpcrJyx7K8z2HyJ78YUeO5IqTJYjtDVbmV4NLZ4p1NX7VqSk2PAocWdVPOBHjOWzGdkk/fGJr47LpuQvDhVFgo7tue3Ynf4jKVvHkDa0U7NvewkgiyHtAc1Ob+hKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DABHkY87wU3IZzmBlhHjHRB62NWsN8Z/D6rMtAp+QY=;
 b=b5/1y50d7ONnuNBrNb+d1w9J1y08P6NAnggnrH/XjHTd1+N++L9SinkpRNFvs1ZplZ4Y1gzP8VIONOMrwbTXFScFGfBTeR659ICLpWOX8r1xEJpqN5EtEqzzjL283jkNDSFMpY+immUNW/vWLE/iaIHSriQ0MBulIHkjdOp5HXU5yDMX1NAOiMjlAlIH89jWObiiAPfM+H1zGbIgfC28NyGd6aNvVlFLyXZSTmHjTGx9c1p2QZgQcMZY49hb6vxEXoEX1QHCsEU/Jt93Fn/7WUTmzeLyLldUCthgflQhuNyOblEox+nXGtqipJRs4q4xUQ0H5M63rqK29nVLQjRhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DABHkY87wU3IZzmBlhHjHRB62NWsN8Z/D6rMtAp+QY=;
 b=xHlMIu1ldcvZe9IfBGSqPUlM5pXhDrZAN8kDX7YYOYKWlkkDwNT2zGrLUYad0n3pbGn4+ajKRzdirBbMPeYxFVEj1pKCYyYUfAKZyiRmTDJtEVRToKdqJrrLkWjsYoAMuhZ/H8L3O9zLJFxWQpTMYxOEdrxKgBPHlPd9CxYnkVs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Tue, 27 Oct 2020 02:40:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 02:40:46 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
Date: Tue, 27 Oct 2020 10:40:24 +0800
Message-Id: <20201027024025.32269-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0032.apcprd03.prod.outlook.com
 (2603:1096:203:c9::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0032.apcprd03.prod.outlook.com (2603:1096:203:c9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 27 Oct 2020 02:40:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7709820a-8bc0-4809-a0aa-08d87a21b4aa
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2620DEBAA1D65E7CF2C5E3EEE4160@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZoYSwtXYxmUl+YLpYiBG0mma2pj2LgzN/r52ytnEMO/Z8P48KmTqeAJwJpM0JQukTUtoJHp6J0cWdcaExRGMl+K/wpFBKe/GGRLmQLhxJS1qYnEm+kxvr4/Sryla/+5+KOYHNfOaTBVjtjG/5oyvQpVvnYp+8GW819uJeBuTaOD4TaGxDwPUxxuj64gU5wxXAnHe8ITFv/SNXa7jjCo7gHyJB0fx6dUuDVjFqZC9nOawngRANSUJH2/bQ6MB4X9IPwwef7YBPaYIcg1ZEfCAhCvqqqOtwUKiMvvA9cWn2vLueKcGO16kMniv13G/yaLqlyaotAsIv8kDmWkjTytng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(2616005)(8936002)(2906002)(956004)(83380400001)(6486002)(316002)(86362001)(1076003)(8676002)(478600001)(26005)(16526019)(5660300002)(6916009)(36756003)(6666004)(66556008)(66946007)(44832011)(4326008)(66476007)(186003)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KimujWo1O2TofeOzxMuLr8NKvoloYm9Zlyc36qBziS4WXDOUiOd0C4t+tScYRx8ef3xCz/TNkZ3DOuEfIQJ0Z9YZPb6YB22ypAsnEaNmVp5l3jzAtZeX1iBPRVYSOxe1p3wMdAZwX0eZbSjldARGJY9VueWaPoOKyE1zrQdjO8TC+P2BBpjaBPXIsz7QJDA0xoMEcxZH9FTeumpemibMFZpMBYImZaqhMcb4IJKIWU7C/kNKMW+15jGa3TX3L1BkA5I4au94m6WwbNFs5uyaR15X72Q1n76V6s85yF4rZoeDA3ZC/R3T4ECFxSqxMvHE3wKU99qgWuTdILI7v3zDWrMRUMaYxh8bi/6CNCXYb1KMTNhLku3dl/Ki5pb8fvV74DyHvx+jQcFirOJjhWd1TiVRF6W3JR7etBCGV4vOAKdVYk2HOsR4QkjWo3SwbeqPDjnP7dmtz3wosseeSQjUKAaK67+spGJx4PvxCAygdSwqwiwcrdHyIvtKomvrKQfsh9L+y4bkYskoYejlGMB8oUN/aF1pyJFqeDaLW4RXnTNlcZn1dY6zYAo1IqzL3Nt45fP7e6CX89AVSB5M8CoE5cQA3t7pXYnibe2Ij7A0JeQx7HElCv2O6hNmjbqrYoQRMCNqxRc2lsK42SVJcAdKCg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7709820a-8bc0-4809-a0aa-08d87a21b4aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 02:40:45.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc6jIztfcZ8o3yIgTAijAbZ04tn5EvYjltKHdtRE2+thn4qj+09qX+2v7GH5FlQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Which can be used for S4(hibernation) support.

Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c                 | 4 +++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 03ff8bd1fee8..5442df094102 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
-	case CHIP_HAWAII:
 		/* disable baco reset until it works */
 		/* smu7_asic_get_baco_capability(adev, &baco_reset); */
 		baco_reset = false;
 		break;
+	case CHIP_HAWAII:
+		baco_reset = cik_asic_supports_baco(adev);
+		break;
 	default:
 		baco_reset = false;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
index 3be40114e63d..45f608838f6e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
@@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
 	{ CMD_DELAY_MS, 0, 0, 0, 20, 0 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x20 },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x200 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c00 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x10 },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x100 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
 	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0x00 }
 };
@@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
 static const struct baco_cmd_entry clean_baco_tbl[] =
 {
 	{ CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
+	{ CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
 	{ CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }
 };
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

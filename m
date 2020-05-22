Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC90C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8371420738
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fPyQwqGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8371420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067D76E9B1;
	Fri, 22 May 2020 10:00:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F876E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 10:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLdRPV2cTZ3shUhFjl1liuwmPlXftcUg7eNAjQzIk6ySG6+7/t43S3yW0mvS2mqsopBRZjyighDczHT/GIC7IhWQm/j5ODtoepw5lbAcfyBdlZ1gmC+VIn/SOhtiBiqywRL63iFatFcZ55LB0Y3ydV0X00rDUGw2KZgVDM2WjnZY7pxvqsosqxWvkBPO9VVWPD+uLgAytZW1MJ0th0k+EY46FiyAB2bvtwp7NqUDyJdc86xkDFr3JQVwe6lKKoXWw0ycjseHWwcs8+kGxB+h5lQQfZ8xizxci3/lVyme5GAismrVGAF5xKZ/Y6W+Axnb/cSnlYdZmxUxPnMbdu1CfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr9qQiksvbY0XS2+EJ8pz9BbXFTfMLyMPR9FKWhEpHA=;
 b=AH2R6idoOTqH/rBW3LDBxQlIMt+gAt65y6kLiX7jJyK6zYcLOkoTna1Ciz50l+b/6H5aB7yJxC8SPGxM32QYZocq0ssST7si/ypZ2OOlnnUtxxaqFZS2Wba9N8ZqZXGzTNa7iaFIXitFt/piyBd//1lLhAUU6AVBf+tdKm7dQ2ziDSUHcCzC3ypaKTel8UEmv7xV1ByWo1i8PauqFuZxdNGBVvnLk2l0HreL9HBKqNDAt9rItizELskI4zYfr25syMncgwz/yQ2kKmhxwK0PfvAxTEPCmj+xUI1AWXRYc5k+WxAKi4yGAjPZepMwBLqjukXeVynojKz3coRpGGzx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr9qQiksvbY0XS2+EJ8pz9BbXFTfMLyMPR9FKWhEpHA=;
 b=fPyQwqGHEeUtszpsehTpz4X9Ivpr0J9dZrq5Mi6NcvgAlXBfQqJmyriKVmmSwpIdoZk5vAeUv201RI/+eCxyxEOkgaMJHf11b3wHAs23zdr/BvvpmCHS3/PQzOi6xGAMI+eQ4bppeQfLX5kmIFQ2aZdyirYSx4NY2ezg4inmm7Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 10:00:51 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 10:00:51 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: print warning when input address is invalid
Date: Fri, 22 May 2020 18:00:33 +0800
Message-Id: <20200522100033.3813-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 10:00:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1a86220-42e7-4937-e271-08d7fe37024e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12874F5954A2404C1C323AF3F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUHrL/v/ZcfGP0biHzdZB40SIsoL4If6KJRIKTaXPrbPFtCS1i3Qvas6b6L/u3Z5/Fx8oxlcxh52mh6Ppbh+ImhP3JgUSVEGeS5bx4kiGpQc8eXQ/F/DypiEIRPkCO2xMMTte9LSx/NiazTTEN3yaVoIE5LG3YtrEQMCb0B6HbQKlMAGTGo2/fUO2OZt/e5ubzk42DFJ3HNTTH/szwWDWFER+GuRwwMZpjvkUOVKn7s8YnazpniO77A54PLSc8xpSMOiNMpeUCIgILoCkjBiiV4OFdR+DpG3brWn5KrhDcI82xXR7IdjJq//M54SVM9Hk98H3Oj/R8eaw/TZwhLKYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(2616005)(66476007)(8676002)(52116002)(66946007)(8936002)(6636002)(44832011)(316002)(7696005)(956004)(4326008)(36756003)(2906002)(478600001)(26005)(66556008)(86362001)(16526019)(186003)(5660300002)(1076003)(6486002)(6666004)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tONp/HBPSLTjc5QLtjWhy6f1377emDebxnxKXGsVVWG0Q8M0Vv5K1pHRLhCsoULM38BkVyGpb4sLQ0BwfHK+i45Jw78slbyqiG8JkWCPoHF1C20gEscb6hVPsSq48NpiOQdRi5H95xmkgfmKuyjLoanD1HTnmrLjRPxYUBFG4hl/nQ7c82yAmkS3+mlBfVOXiUPAuyTQmRBrWaEzbSFIz3tOa4vl9go1uB9SdBg9vi4I/NMwiAK7C5LxgK8gupk0Lu6+yMe9Jf7Yd+aKUAyZv7fBuLkdEAlmiQAhoZg0/H2VcEbsu9jsiMqAXu5142yhIxDg+bpdJrheQQ3EAZ7Kf3tbEb/DuRWK1leGg9z9/TMtve32Cwrw2pkTNfM29gbVigzQXAIHE69t2XJm0LTM8XyrzXCO3/bIqlD0Uyr1hE9oD8nhwusnPKPAJUHnTRdd8/iRhKRSKJg4vS9LwIuPAey5+LZ9Hb0IjQ2FlHJ2lJ1zwM2/lTA7eENAFE2nsw4E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a86220-42e7-4937-e271-08d7fe37024e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 10:00:51.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1K8HUqDRif+00c+k17cdyjupTAJ+PTqoGmhnPgMS41pxHxjN7+VMEGAKJGFd0zrxxyFuR9w+n7nVZD1AcM6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will assist debug in error injection case.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 50fe08bf2f72..9475891ee989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -318,6 +318,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	case 2:
 		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
 		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+			dev_warn(adev->dev, "RAS WARN: input address "
+					"0x%llx is invalid.",
+					data.inject.address);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

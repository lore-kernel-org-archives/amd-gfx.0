Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14513C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA2320776
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bz+GJx8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA2320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3656B6E102;
	Wed, 17 Jun 2020 04:00:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFAA6E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 04:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArgOPo71t0MDD1AlMFJvwD9sKg5vs1vV8YbHwoKfy/ITEyqjRcAUojsOEFhwC0RXURnXCAaS1DfKGtRIKacE7ZftCVDz02ElJFzwY/sxRPERVAD6pHUTNwry25gLbjR7bcv9dkBJPs8ZsEHbICyekelBILe73x/zLpaRcou+jJfUZF9OmIoMemfcKVU7fxb+5ytduop4vs6RFpWE4AyRnURQbzrwtWnR2IlqSDgDjh0zCOUGbGuORN51LlCS4rywQzHADp41uoVSosR0tv5kZj4TMqHmKAonnrCEQBd7hZaT75xJfo/HJ7tBVDJpYoenKfKUW5Ny5QrV2iTJqjz1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m5xJ7mM0y9XK2ZPlG33VI2F3dqz//SxIipMvS3zVqA=;
 b=DNFvGTF6ybvJ5uLq0RnxSvXv7VaYzWxMV+2mZwUy5+F9GLThD9MJ0S2XjvmDGV0f4PJbXv0cCDchBKFdrBDnxZYoRamISEWXdgtk3kmEx4SZrZowvVceJpyE6pUmkwaqK3EjWtDjnRIJmcTMN91V93+2qt/BI/I8eQjjtEuwH+KMJuJ+vtXmdt0Fc5Vr/mgcaLZW++R6DtPIDusZy9bxqlod0EtQpRXkCqc2KnGjI6W2dmKfOMf0AVWyW+cXnyTivjcqojc00e1r8QELap6bN11jok5LH9ytDE6WnQvoJ/l345FsjsuxRGel3UcxPdLxL/L0HV2yplgCTbKJhlBI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m5xJ7mM0y9XK2ZPlG33VI2F3dqz//SxIipMvS3zVqA=;
 b=Bz+GJx8UCXGindqXSEuxtjEVsed+y3l/J+tAilTJM1sKlKQQQoqW2WkExUPRhwNCu/T0+PrbKo1f8+/QI0bv+UDuSPwZ5buRXFMac8qlz6mALPrMqhe1g25SWvsqV7KGa/TvHdYcZdbmzr2YQyNhwMoz82Hq2ts3xEzFXYM9IGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2501.namprd12.prod.outlook.com (2603:10b6:4:b4::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23; Wed, 17 Jun 2020 04:00:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 04:00:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: drop unnecessary "@" on OD sysfs output
Date: Wed, 17 Jun 2020 11:59:48 +0800
Message-Id: <20200617035948.10855-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.2 via Frontend Transport; Wed, 17 Jun 2020 04:00:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2c8d5eb-5650-488c-2164-08d81272ed6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2501D33C5B862EA0432C6816E49A0@DM5PR12MB2501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afCo734QuUkIPoO3lIoYvWhNviUqVQ0njaKGB9SzPNCAyA6hpd4cy2coFCqLf+uJr3AwUv9mNWxInfrtOOE0XRkQY/koZ8EmM1FCOgfPiXFhdG8RwfVJNDFb+t2VdKyEv714mUMrGJeM1It6AOUfexK6zSdcu4im3b8Unp8u6plEAERIuVxwvMxJ+A0ZRKNxbfcOjjgLAxBCISmVFFNiODOtYH8+BcC/kVc/GgGJ++NiCGUqJKzQxDfyMbljeYEJZYx5PdQP3PszVkYe85X5ez6ZMcHEF6N/+CoAHyzFH6NzB5hn5kaLMs7NJIhoOpAC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(8936002)(8676002)(36756003)(6916009)(2906002)(6486002)(66946007)(4326008)(66476007)(66556008)(86362001)(956004)(478600001)(1076003)(186003)(4744005)(6666004)(16526019)(26005)(44832011)(83380400001)(316002)(2616005)(52116002)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2F8IuCD3TfMMYWD7RfFghEkzLZ5uKv6WcgVMnpavcl8XC6l7A8Q4Pikz71mFnqkOC86JZeSTZwZLuN1sGjd6SpQ532hWAeynprUUPhBChTCFyGwCCJxk6hqnAjgUD2u3rsTPCWZQDsCgW+MAxX0hgP8nSG0SyOtjuSGnE50vWCIgwHAJts9imBqZPdBresn4s4oy3EhQnqfBeUAQBTVoPJQZy0ygWvRslOFiUYAQ5sXLUp9Aj48S3875bx0KxzE6TVo0POteeC5nenSUNRNY/2Tu6uh7dT8T9sObb0Mj8LEI8zab4zRfeDqFA8G/2hcFHxbqNTHvg/mwFSkI+PtkV7pw5WYZitOgbdkRLwIm1zlsYMBu+JaOb/H9rz94lz3R5ZSBBUIb3axWTfeWd8h76cq4Cd3TOcS31H+aIt1iqjSOfephxpBYW85MSIJArv95RCClWoPh1l2YgVU+IwRr3LDJFvke1cREbLasQlGYjjo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c8d5eb-5650-488c-2164-08d81272ed6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 04:00:09.5686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfxO7rV0MStZXL0zbkuOZVdLpNHJ5klmNZKvYH0QpUiqld9/AFfCgXEWVsXzl/A2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Chris.Freehill@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To follow conventional style. And this unnecessary "@" confuses
our userspace tool.

Change-Id: Id4cdc611d63e800cf5a93449b6331a1e8323e727
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d0f9991c4958..e99071f1fa59 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1035,7 +1035,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			default:
 				break;
 			}
-			size += sprintf(buf + size, "%d: %uMHz @ %umV\n", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
+			size += sprintf(buf + size, "%d: %uMHz %umV\n", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
 		}
 		break;
 	case SMU_OD_RANGE:
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

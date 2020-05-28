Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F1C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0AB2088E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R7oJfUZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0AB2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DAF6E19C;
	Thu, 28 May 2020 09:03:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34036E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 09:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/TnqaokUyJ2DZDbeMPIy9FoIW5gwpPxTVKMWdxkyRt+XwuMm3t0ny5qOCBRRcbYospAti6DeqZGXQzVrqh+poiqJumQ1hWeYzuC0X4fLjjRlo5AJV7M6Cg9vKxtOAmOiOQKFEB3fJZURWzwXC+brB2e9hIYE6tYTHp5eezUKXvOyHw/hWFqxEr29uUCJBpRN5niEoM95u3QGecOxaCMSdyFRGO58f9H3nMlm6wi1VvGdxTVu43Olg+4PERUhClsKyq2XYejwJ8k2gBR1mgzUz6LMhiX3UiFTvqAmT8NAuE6VgoZGCTbwL0kmeohPP6IBR2A9JMIjp9nkvQPmNflew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szK6Dd1p9xan2mJ+f/E3NpQS9R0R0m/3qKi//I2jPkM=;
 b=m6DVGp2CwaSEJ0tkI+RY882pn4mZObdC7NpTiPDh77m+o1Ehy7xJ2w5VR5Ip70ifRqXQuEMde0xmk2Yh80ZqvZWxC5gUr6BC+21F0aPWG+/IcQWzLxhL+JpYSqXykAEO5bn5qnKH/EId+O+0IMtWNZEkOVXPTUBEST8esUj7vjGOBeWoyLol6apDzuKDz87wL6gyKlb3eM4YSD9qJe7qEYAH47IuJlLAGQIq3UpUwMjxwG7jWsy2iaw6jwLu5hD/juZvIGJA53YHvvfWPph1pr+kj4zfPb9W71xnO9HxGpF91B+b82CTC5WXgRh6PlgYftOu+lep+inQO41Gdxfiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szK6Dd1p9xan2mJ+f/E3NpQS9R0R0m/3qKi//I2jPkM=;
 b=R7oJfUZYBSFA3bLZOPQwwKQk1pbplzoEQIdVe0qBUPqrJAJFASBX6Kv7UGcDAL0OaftHWuvfFtKGzwHuv0mNbGeBbAPgW7u7NfdZoBVrM7+GPCCgkixJ7pAAJupzvqZhfH2c6r0Dis7EYUfe20YpxVb4FTaSQl//CtTN4QFZcQQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Thu, 28 May 2020 09:03:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 09:03:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/powerplay: stop thermal IRQs on suspend
Date: Thu, 28 May 2020 17:02:39 +0800
Message-Id: <20200528090241.25291-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 09:03:00 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 190236c2-0c58-47c9-6ac5-08d802e5eca5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435332A9ADD3ABF8820000F2E48E0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L7O1HSYnQtLxlLW1QpH6paUYdkL/1zGug5m4l2i5mkP0X4q7fdGou/X+UdVkYT949EtYLvtgKSalUS61QcLZ9dZBI2ESrS335ly1p3iiHRta9iwb5aPC9mPoM7pu4QsTLOk9Iz56YgwgxFBueSmLutlUG5F3nGzmXcKbVngH8KiNQFNfUSfbTVSD2X41FyLL9IboR5XJ4SHKK13raVDgJAHbt37pkXJBziL0PurJNFBO2pnfC4EHzNiIqN4Sti//K5SEmN3wavWF6EZHk3RKkXoTAkWL7riB0Drby/oGOgkkLJVlSa1BqdQMSdi8zvD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6486002)(2616005)(44832011)(15650500001)(66556008)(66476007)(66946007)(4326008)(4744005)(5660300002)(2906002)(186003)(83380400001)(1076003)(316002)(52116002)(956004)(36756003)(7696005)(16526019)(478600001)(8676002)(8936002)(26005)(86362001)(6666004)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: K6BVz1T0aEorBQ8ZMMQ854epqtEY+2gtYH+RPKsu6Td/cEQ4gdk/6USFSB5a2tdQzcZUHykWynvc+vcnzXSkRJ7ze0y8Isw1p7iRlNC98RZwrELPEBNYqUV2facuvp5B43CUwOG1Tm1uYtmna1pcDIn6VvgoqN9WDwqnVEqglI+0oBi3ENKisqKg0FQSuqhMYxcZ36KM9/iWR6SpdRfXmWMjzptRHJaIdohL7TwOpReDQ3olcnU4TMLa5EQFSILjyPKXYUoWeaKfFWGWCjvMMHLOiiFsANBKEqw4PTwd7ug+grdShFgwaN/K+0nrn6evdAxQz9pfmeXnVRCj+D5u63e9CqSkVsAupASJux3tAM4nzqJZZJNWo2KNDgSLQDOLC182RpKDqU+E/ixC4azWem18gcI2cdb5y+JkC81HMzMvmfSalatWVyc+DVb/qLPCvmzkvelyekOECV92ZKoEBVjPyFQJtElCmWUcFmnwZl5ISKWeQZIspsZASFCVMgib
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190236c2-0c58-47c9-6ac5-08d802e5eca5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:03:01.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoaZ0zz1J9tlwKZHWMFn1eVdJrK/ccxZ1DKDHL8ySLW9de3Kep86o3z9eSr+pGF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added missing thermal IRQs disablement on suspend.

Change-Id: I959a1d56930de434cc8534334220d3faeadf79f8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8ce907280dc9..12511407683d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1537,6 +1537,12 @@ static int smu_suspend(void *handle)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
+	ret = smu_stop_thermal_control(smu);
+	if (ret) {
+		pr_warn("Fail to stop thermal control!\n");
+		return ret;
+	}
+
 	ret = smu_disable_dpm(smu);
 	if (ret)
 		return ret;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

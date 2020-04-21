Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1AC54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E932076C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q2vL3lz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E932076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104D56E884;
	Tue, 21 Apr 2020 05:24:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C799B6E884
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmvZoI26ZbVnvEBQ1n0zhO/jpO6mpvkW/j3ijOvw25jeNXCeqS1VL9pPY71SUiIOHhCuUyEWXSlnGau0P3NHNPP0LYWrp6PFIZEOXuc1iGp3pv3GHzzACPkQO9gH9Jd8l9UfPPaknP8GdhIfdsUHSkt6Sd9j8MjCnOY12hWfVgYfFu9xmoVoagTS6ls9vxy/ahuH9uVRpD8gz6kuR1Ez+hXe2lgI7DaJz5KXygzGeF+4XJFx7L/KVrWpAaD9c5LMzIp6sQNAO4g4zJ4sLIRYiF100qaPrAl9UlfJA7W1EXXV12H4XqfuX2eEWUZI0QCRlvACFxnH/6zLCsGwqpR6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRageAe9kwq54/ktn+MxOZbYK3k1bo4roNGq0fQuMwE=;
 b=SN97rK7n0mooqGdA+B995rkcqimXa1GDK1qb3XC4viWVlV9az4w9Z2kws6FPUvsg8pWMvRLrMBapZguyvTmop1AAHde9j2aY9nT4xRjpQo+zMarmGwslpTnVu29CRi+mVO8L9F+ogpg/BjgdhiLwYqfMOlpyoSTWSNXqJouqffcGMbBIoTmKlSYi20lJsN9Vvdh/3wIMS3uOOWOa+s2c1oMLgHMKovknOzQs5Nkc64dlPBxetxfk1fMCP8yH8VR0G5mYJbCmorUsiRiF2FhsmMnI+ofDlalko+eJb+TkXPOAsdvxgRA2rq9247LAfH4euU7UcD9OW717lP8OrNBnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRageAe9kwq54/ktn+MxOZbYK3k1bo4roNGq0fQuMwE=;
 b=Q2vL3lz6n9INPDtMumhZY//iJcQpNdNJnnFu03BOCKGSDAQVj8hf2cyJv6B9ONFew1w3fGUYe8rBnfhEWfi1tZw0kUTpU6rSQI0SIlJBGDFPhutmeL4jDkOavmPRb7PnB1LWPNhN5/Lwsb1JsWzYPn/fXLGjvkzFQivUn9D7DMw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 05:24:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:24:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: correct fbdev suspend on gpu reset
Date: Tue, 21 Apr 2020 13:23:39 +0800
Message-Id: <20200421052342.23037-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421052342.23037-1-evan.quan@amd.com>
References: <20200421052342.23037-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 05:24:32 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5caa0ab9-3ab4-44c3-33ba-08d7e5b44738
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:|DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31646FD8C067B486D006D51DE4D50@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(2906002)(2616005)(956004)(44832011)(6916009)(36756003)(8936002)(81156014)(8676002)(86362001)(4744005)(7696005)(16526019)(5660300002)(186003)(26005)(316002)(4326008)(478600001)(66476007)(66556008)(52116002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hL7+SGYjaimbaHV3qhn2cOQcYct5eHex+PGt7YmG+VKgSj3KEQfm2fT37Wefbf4x4J1erZ837CTZc/vNBgP3a1AWpoEWRdUsX2B9QhKR8e0bPpMkHwOUezjvN7NxxYpt6/Hahn5T3R1rWaYOAmCDsmv0RKfqxj1wbF2WX9FS1fxd04moLezLx4JXoWGPAK1v2pB4VX+WxV4+FEVinGv8Zs6rdRW1xzCTyTfyEZbJwWqYw7/T7N0ZKTTp2mA7wL57zufcOMgn3VUuYa6sSpeDeQS3AHTVebhgFEAkzvHzogGimsdYuOESR14vW0B+f8b85luMK/lGwDnf/M36Z56NF8YK/BA4TQYe0kHfV5toBEmCMTq8Dwn78bktWJzc+veU5pQlcUNka47qBa+ZGpt7Dl9qKesLKfjLT19/mXLXN6MVOPUEmMIj0r60nO2B/rX8
X-MS-Exchange-AntiSpam-MessageData: UuhBqC1v8DcSFpMdnfz042JW11+3x54y5SUfOCFGUAK2Khd/Mzx+vX8HUjSVpIxNqngK7/r+gNh4XVPq/a3ciX4GJUvN2DdPhpzXDLzqkZO36yKUKhXAzK2L7tHd9zt1LnDDRnFNHgWr39SUKMvnAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caa0ab9-3ab4-44c3-33ba-08d7e5b44738
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:24:35.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qox7foPejwu9X+ozRth3WQlBxYqVWahD2yeZ2ET7ioZlE9OoYpxDR9Sqs4Qgc+Uc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Alexander.Deucher@amd.com, Andrey.Grodzovsky@amd.com, Jonathan.Kim@amd.com,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for XGMI setup, it needs to be performed on
all the devices from the same hive.

Change-Id: I25e6364d31f0b34938cf424a410628aa54dd2edd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 079c9c5ef381..6cbe5140b873 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4254,7 +4254,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		amdgpu_fbdev_set_suspend(adev, 1);
+		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
 		if (!(in_ras_intr && !use_baco) &&
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

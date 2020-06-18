Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 07:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CB421841
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 07:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tEoZEwzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CB421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3D889907;
	Thu, 18 Jun 2020 07:53:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868F6898A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvTMcja5eZ4jxha6g3dl7ary6AN1cQ+2kKNgb6qgE32L3hS7BdPANAeM1gtBDe+icYolP7mPpy9TButIPo/I6Jkm91zTRDEfUxHsDLIWtEn5lXO5n+IhLHRM0kxWnbyUVBguL3XWAYQzqS1g3pYMOreKBLpP81TMCWvr6X2ok7Mmx+h3Ubq7zSqhOCCq65VdN6sDnKz9TraEwIfawGNyIZPuB3H88yWI1XjCrLbXMSmz62KaNh9ah4TQzfabg+2I7gnxvzJCqcUpKnlMFhTypyMXWevW/cdaqZekdwO+9fCUIkstlLp18wuozujXpkUD7D8e9PmRIcPdaa7uWQV+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghq5sWynunP9UFiniWa0CvYu0useqql1rwbUikMpE8c=;
 b=Kmsu0sxtG7gaYbVEojd+fmx7lOUtqXEibl/B8dmOthCxBFPTwMf5CzJnb42ZEh4IFyo757GbxvZuXLSdN5zm5Q+4hIg0RQWVmkwCACoVAK2P4JtFpcsOp1VhVKzf1ewo5xgqdPAeMAxS8HGRY9qhYRfGIMy6bDQw6XiUTy9Wx+Og5izfGMgM4zVHIrnZeXAxjxz4NhgpOLAL4zoubqlV61OQBtOLF9A7B2xpH+AqluboeFQ+OvNq7XkbmmyuzEOJeoKusibqkyCrWP+DyVekFLFjKMtv2pg7JXzMI/I6Ln4ehWBmmRB5A84oH5t57y1vdA1sZjCwE5zC7KwBsx902w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghq5sWynunP9UFiniWa0CvYu0useqql1rwbUikMpE8c=;
 b=tEoZEwzEL9jPbKxrP7NEWc5SSN7A2LtrIbu7cOq5ioOAEe7y0kojTkxWuXFVwbYmNHNDs5MZ5Sf8uymmqH91Ie1rTfC4vgizyviyoDG+GHanC4rejlmB2/0fRi4m0olOGYzi0GCl+zR+OZftkY328iafSWdx9mQ6WV1Ts+O1cK4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 07:53:26 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:53:26 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Date: Thu, 18 Jun 2020 15:53:07 +0800
Message-Id: <20200618075307.3721-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618075307.3721-1-Wenhui.Sheng@amd.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 07:53:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8c95aab-a413-4d39-93f4-08d8135caed1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4215687114C110C7E1A192DF8C9B0@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XQzSH9ldSXBf5npk+V2imjCXb49OQ98H+dexh0cs8Ba4twGrCZtguFpD49zGqJuTy0gX0HjzdbUaMM7HfFrsX6KfGepGAyn4ctaBNkp1XSQQx46NCw8OpibT9lA1UcbfemnVlzWdU4wAyoWVZKET1ibIKC+T5BW0zxCSdgLNfgUVF6vIcxenEg6ODPgNon6nfaegaujq15/turUo7nlMPVyRpoVJcblwc3flJhaVETsJ6D++mKhcybWoVQ7lpTU9UNgJPh6dOzTrAGD7vetWsbcmUllo46M7928OJtUKAbHXAvMvIuADkkFXoyhX7qUckNzzZWevBJ4Roq9Ur95xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(66476007)(66556008)(26005)(186003)(16526019)(52116002)(7696005)(316002)(83380400001)(956004)(2616005)(86362001)(8936002)(6666004)(2906002)(4744005)(6486002)(1076003)(8676002)(36756003)(5660300002)(4326008)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ogp+c3QGoft3FhtXwAQ9hvWKrjal3SwkO0n5ZPQslPk4DNYTrvuQ8jpDARKExwv7c2PcIBq8jz2yFGy0+tDUIFJiFrgWv9u1Tvdgz/q/SY2pa2KcvX+HXr9AMlA0FQrVWd8TM7Udlmpkh5tgB3oi4v2f2d48c9m5MSkuDiu4251hDlU8NZesaU3sjHkE0I7BQUZ8cE4Rn07LdwBFt25yBx5pbytUBqero6Ho7RhoidZ4gutDCYr1uvY5RgoBI1BB4JelV5QqqG+h3UJQHJEel3cbkWcbKhzhJgMoOoaq9waHOj+RiHv/iVkQ0/uE3Hq6b3Ci8lM4WbdimGpfT/XnsFjOyVQNjK25DI8Cm8hxKvdAMUZxOk7rAdfIrieOGLHuZ69D86VI6jB2U3LvAQTo693XxB7sOKBzZByxDZ0++9stWPxnc5cIhkDIZDR/xXa2y7gC2YtUHleygSFCzNUb01WbM92XvPYrIAvF4cxpDIFN7r7UTnOG22LFjOzVSnyP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c95aab-a413-4d39-93f4-08d8135caed1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 07:53:26.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmrmVB6nkyjlt4CoESPql+dVvZ2ON9DP4tOXtTjk0Olw18o+Ipb93DaOWt70nKKSneJzPvjaj9oeHBz9SuuXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++)
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.instance[i].fw != NULL)
+			release_firmware(adev->sdma.instance[i].fw);
+
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+	}
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

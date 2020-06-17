Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E746C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0532082F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yUH0kVcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0532082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B323F6E908;
	Wed, 17 Jun 2020 22:01:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026B66E908
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+W5GR22ShqjB02CPs8u8eFph34HFC3viDj+BC3h2oiXfyATGzE8rpLLk8FgdpXKnTtM6qpEu7EA7U60uA7NksB30Kw6SimmmiRAfMLPI12B6l8DqG0x0R1OW5eJP2hOaWUXxTW8b5XJ87gScssfO84+cweIkBjU+NSCixYx2icQ7Epvk4JJNboofLFA3qIYgguSJQH2zgHmgk+qTbSIfRIVQLTAlisrUt/gmoh9EQ2HVkpyKgY43v2Wv6q2GD88siLrmVpGFlEw9kMWqQZbxHGoQv5lV7BbfNgE6w1ApUrQwnPBnWh8cIEpo8wdy4rS5J7SaXtnK3NCjRAidKjQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3gw2jZEP7ABkcDh7rYyCyDHSaWChidR2W9c0fPFyk=;
 b=dfziyCinR9OQux5Y65pNlg8ADJD0pZyPo30ch/AK+YZVXN667db/zVtV3yGoFa1hqzePraZyWr6y2w9DyzuzQd0w20wuXO+AZ6AbpBTjKIyytYqtv8yupVgrUlzPuyhA9ItW2P8Eh7mKuf3qiTQXRpTtTWxMXiKa32kOmlRcW31Ti6iAdFqtGynUS4j5gr5S1Yl9ojwimJDBDOMq1q/oLckdFKd09mKV4u6XnN6GC0E5bqffZtCsYgpnqJgxIG7NvTClYS6dDqCPl7hnBjqQFPmLLekrUUOShaaTMVwg/j2KQT5JcFYh0j1UyetLUcaf2E+FxVVtjZPENxGUgN69Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3gw2jZEP7ABkcDh7rYyCyDHSaWChidR2W9c0fPFyk=;
 b=yUH0kVcsuUnmwQnaj43FoO3xO7d8Pp9GPpQ7rDllRztD+yZSr+2TF7b1/aEn2bPpZdpg8bg30D5FTWTtOnTBeYoab4iYGSpsGHeIMce2qbljYg18YkcaS+okdvggZiDnl/RoQnGYiZwcfCnkFhgnu2a3fB0L/D1wC+7XZvE6G5U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:01:00 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:01:00 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm amdgpu: SI UVD enabled on Verde, Tahiti, Pitcairn
Date: Wed, 17 Jun 2020 18:00:16 -0400
Message-Id: <20200617220016.4844-7-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
References: <20200617220016.4844-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c1442bd-2e62-4ff7-82d3-08d81309eb7a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185764C8C8C005F7FD64559FD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZvk56d8rdqpBIfPc+0+N032y5ybJmXlhSAWvsu1IXx4QrSEQxYbzq1ysUJ8bRs8YOMkdyNJ/wlBIIj49wlUuzBDH4Zz75dqzODsbRvpkiyedpIg8691rjapDvT7GsAPkiSDrUMQPPfZkuMK2en1TQ5q9DUOTm6knb2mGo+vkzkUkCVnxV6CC/65nwWsAEIoqozZzKevKl+DFGWLY0zT6HMnZLuCSubVVD7EWrMH+gDr9SZw4VoqrG1cQ59z+68vCNRqlcO9W/0vBdRMLoww7g8XbfkWm+PnJqZJac1V6XAc1N+4HMemzGHO8gGOduNZeheQzqbNuahiMXHwO7S5dczzZrq+sUfN7hN1vBTrOPrziYuMZ4ng4uOn42C8eH6t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(4744005)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BCX9bc5lvK+Q1NlikT+UTMBJJDnh3PL3X2q3r1W4iR/oOZqSmLX3WiE5hXJMKWq8PBkDJVFRR2ErnFkXIPmTuIIvp3SREOfl+0G0wujNJTsayv28zlnTRwYXqgTY3nXGiQZrPXY0A7Grp8TqnasQqEsHDa0bwgPljScylH2QJrJipig+Ycf1bSf2ieqj2kx5ljLJ7NPoIidQwEKi5RUYVQ02ir+h71Sr/Zv8uZNcmogFeKNo6mXepw/lKsuPqXkvaz3zKVr3d5dYqDUxWrbbvJdb6Qcglaq0dZgmVPsQ2RVGdtnAqs/vvWAA2SOJUd2UOosfCI0bAWZFA8jk0KVIk8OcF8UqlIuLe739r342WepGERJn0WmiwvBzq5Pof5u4wVQXId2mv9T8/gzXV/FmLWhW0iQkasU86ZrwSDQlBNTcw7jgcEyz8CoYB4PHdo9/Vmvju7uvyTVmoyLe6w2hWzs+IIT/pK2PcsrtqC893cd8ZCHfUNBGiKVM2ynp8w2G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1442bd-2e62-4ff7-82d3-08d81309eb7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:01:00.1481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi1NdJfgOyDJxFz0+U/khrylJlO/BPArCRQcJmqBGUlVIqv6Oaf69DZg4k/+DCijJ7NvzApGv1q98G6B0xwI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/si.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e21561fbfb82..cda9aa5e4b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2196,7 +2196,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block); */
+		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
 		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_OLAND:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

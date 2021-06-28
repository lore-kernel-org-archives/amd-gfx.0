Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395EC11F66
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2291761C85
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2291761C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F956E50E;
	Mon, 28 Jun 2021 18:49:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FABF6E50E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 18:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEB+9uPIzyfi/pefMwsa5S2+e9e4vnv6uxKXOyQMjxHTmrr2WFjC8M2PeuFqMPnWpxGjXxzWU5uedKcvv570hxf52YGYVi///X5OeUkT/J4/6XrIQO+Yld40Re/1q7HcikOq5+eXqD6KDziulxuuD0fjQQIhuz+YattBMtyAoi5Ws/J5Vw4CHFbTkeWbzbqVfPdRfC7XDME/SKqT2Ses0KVUhAu58G05NsG5MKww1O79iu1GZ8Dd+sycmqiaK/i9ECCZY6iF2LjG71fZctM3bOSVeEErFyBBMYllkzN6225IGdc6FnK0lSv1TsMSIryhtWUfQc0tXXwyt46wjEgyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiPYjD2zAckV/K5Fq2gJFGjTGWuX/K3eA7CKhK0DrXM=;
 b=ecJ6t4PWMsIgJzR61Nz6NbnaM8SHUi9EKBKy6BhBoNk6lbTrL0vEkDotps8SZxVDcN3p7nmQjnpBRX31QlN8zSjW8CO658SEf8JKP4hMXjqxSXCxNpl7//JvpkWBSWXORHFQEJUiJY70EH39rucqBWz5V5uNsBdJRVWvDKvlzUkcoPd/VZKQNlpAHbxQdGLL6ZWtifSSWMmpC5o44/pLNK1o/9dQ7hsVVPoN38U3vjcDOToiTDt4hyA6TlFYZDMJhEo/BIaYoAxIEKKbTG95Hk4uMI3WsEqU96v8TCTB2XQ5Vj2ViZSCc+psGUAoSFPaKdfdKlCum2Ham1aWnAy3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiPYjD2zAckV/K5Fq2gJFGjTGWuX/K3eA7CKhK0DrXM=;
 b=kwxonHCn+jeZkc2xHBZoG2kNCUsXtsjM0tZUQH6WyGzv/iLRjM2a0DFDK9iaAiUfVXPelwMjgPqs73mKeYsW6XbLoT0ebNm1mTX9Xa/iPoK2iGptrgf43FMbjRu0Z0EqiEr33zfrPfshxibRlwUUcvuvMZOgnh5mlm0nEXoNycw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 18:49:01 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 18:49:01 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: Fix I2C controller port setting of Arcturus
Date: Mon, 28 Jun 2021 14:48:35 -0400
Message-Id: <20210628184836.84530-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628184836.84530-1-luben.tuikov@amd.com>
References: <20210628184836.84530-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.amd.com (165.204.84.11) by
 YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 18:49:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed501f2c-4841-4923-8329-08d93a6564fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4959EC30D75437AD8FFE2FD699039@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnIh7LPD3CEpCCTZOkkLvt86SDmgXOdQCR5SnLlxTsMsr8hvTxrxFKiVey0VIAId/ImHR24WG+0RWQmGuBeRgmG28aa+ThPTHWO8IzP9qi9lfKGhlNIhHw323SM9hPixZ67f/wr0M8goktWSS0jlXqF6pGnwz+hyNIPQKqBDrK3OAcTQhZfyTCH8kt+auMrZlScDaIwizqes89DS/gZ6WGjnIlxPhI59mUcKKzWMK1pLyYw4BYrVxTJyQopBsPkGo19vb8zFkj80ZJuV1qLEJLYMBW1RyrLgR2SnyZvalDbjfEpFD/Nf40x5tdQVorwX3yisTGInvh/s/u/WdH2ZsAGU/U1cKMkp+z/SiyTbtNHLtrKf1ipT3w30vaB1wx7gRXPLXEv7NIKAAMNjvjZP/Ga7zgTtIL+3m7I/5Wn9dOcfS2u1AUO1miMqnivJWrrwRyL8G0dDOA52V7yzL+FCE6LVwH6E1DobdsDfXDgXcXzhQGHncb2XIbO3eQfeFz/zlM6Q0xuyE6aFxWN3j6xHec6T66ykr606r3ZitKlKhgO0mIHW0yDx0xP7582S7uc2jiBIFSyndIcaHQka1aQf5XvMSBdrZoiwy8jNZKECiKS/Nhx/XxaEY1H759ppi1G7GEYEyVZMyBjqV/xzurMYX9hc6sGLu9B/nnSsBYKmm8fp+HP8Qvo/4bf/QpZdm/i93i+onz26rYG1gn6WeLGYeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(44832011)(52116002)(83380400001)(8676002)(316002)(66476007)(7696005)(66946007)(478600001)(6486002)(66556008)(5660300002)(956004)(38350700002)(36756003)(1076003)(4326008)(86362001)(6666004)(38100700002)(6916009)(2616005)(2906002)(54906003)(26005)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwlEV4hK0ICPMtjBkHEdSGtedt9yf1Ja3AnptGLT1LKhKOUWJI48ZzKhY/kh?=
 =?us-ascii?Q?hnUQY5VoQitJ3Tr62jLGZHCDrbTdMbYJ9o1TE1ra5trdaVICt8Gyo+eX8fdz?=
 =?us-ascii?Q?GWnRGOXwfCPFRVsjltN5iRsDP1ua1TB5hsfbN9CWr+F5AI9ty/dCJnlnL0H6?=
 =?us-ascii?Q?N4I5MptAeZYipBaiEiAChfhcLuEk/cfeNY4i9VcPYgqMVqlAYs45uecO0oSd?=
 =?us-ascii?Q?jTtAlP3SGiMlaFEHEazl+c+GTBlSIYHfvquDN4tNUTjURuRP05Grm7uf2A1G?=
 =?us-ascii?Q?05bSdCS0F42CFwutaHPabV8FRHi6x0/1T58gcdi/XP0jY+HLCihkMUvt8ZgQ?=
 =?us-ascii?Q?mwAXZBdLcMtH0qblln3qQKYWZIPpBDk4nQF9JKCm/nDwr4XwdxHiDz9iy9gi?=
 =?us-ascii?Q?YFqfTmFZtk/KB0N/8IBm2QhSkiNnjDchtAeIwa2XQ4uOphQLXrTnt0bJKx1+?=
 =?us-ascii?Q?RdCA4vSF6f4CfJoFrBG+1y/bv9xK9Q02JNzLDgUGVA4c2qcm+ahLeoVp/15x?=
 =?us-ascii?Q?1ViNefQL/8Sogy98F39xgng+bfJAh0V4ro4VWV6hxdqoqSCRcjztO3FVRgAS?=
 =?us-ascii?Q?9GPetG5RWvs45FSvSXRxWjhfcD0NWN/ZwJoc5EkEvIoWviD7EGgdQOsvzRO/?=
 =?us-ascii?Q?sXG1XVVvUFPddNI86V+/dNMo4cl2HG66ujF0Hd3+UragBYLtIiJYSLHWVGWK?=
 =?us-ascii?Q?pjsZ2AQOm/XOSOQx8kF1/GqgDGyDOmlYt56qvhEFy+UeWDl/iKxbKBA1c9xp?=
 =?us-ascii?Q?tXeSaOxn34RWbdmkbxeDfFhSxyZikefPvkR+fx2LaG9sGGjCLLJinw2OxSRC?=
 =?us-ascii?Q?880xRRaKnq+Ee8A8fTvgDkq/NGEr1EKn9a25yaYqPxKajTQVYFA97nadxSBv?=
 =?us-ascii?Q?qHbVaaJSjKzgPxXq1yLBx+zZrQUzcBfw+VDlbVgRag2d32RJVL9rZ5Ct0apC?=
 =?us-ascii?Q?8dlxZHCAQ18eVgBFgw1xHRGYAVVFmIfsrfb5x/MJGKM84T33WWM8OHHx7ZQu?=
 =?us-ascii?Q?8obspDTsF9GlcCL0bb0bDlAHtzaHDFafVaa0rLln6C5Kq7A9kTEHqtTwjEbP?=
 =?us-ascii?Q?D7xHdvkLLHIsMI96sZOWUXK0UZrTgDzlVEBoEU5M46JpxZutCD3gA1cpaSDH?=
 =?us-ascii?Q?H1LN9wiS5a5AgzKrGuvKXanKBJ04WLpyYIPb+BX1Hlh6xQcc1OaqygVAOdxe?=
 =?us-ascii?Q?2s8AR/scoMW+lB2RnWOuj6m95gT76itMLDBFcGXlJe7vUlzzLXWA/ZY74riS?=
 =?us-ascii?Q?cLkpbY/zYDQwvaj7p9yrHoyXvGpZGWcxDm9RkNknxdImN8Y4W7R9JKSgi5ds?=
 =?us-ascii?Q?lfArmMqjqYmFfzjGjKn4EXD1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed501f2c-4841-4923-8329-08d93a6564fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 18:49:01.2181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjJHQxnohaeEe7lFQdQNjrRcAoywNmGioWIDdusPizdBFCDMf5E9JNHhovLDL3D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix controller port setting of Arcturus from 1
(incorrect) to 0 (correct).

This fixes a previous rework commit which
introduced this typo.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Fixes: 10e547e01291e1 ("drm/amdgpu/pm: rework i2c xfers on arcturus (v4)")
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index dc884b719717ad..b1adbe17b6c2d4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1950,7 +1950,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 1;
+	req->I2CcontrollerPort = 0;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

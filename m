Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8953C433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 08:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D1864DF0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 08:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D1864DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AC36E0D5;
	Sun,  7 Feb 2021 08:52:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159106E0D5
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 08:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXBwGbu1xzdQ/7rzyysnl1k/qnY6HraBydLYXKDhcLg6bYMR6lF1DeM0cWkvJ7N/xhl3xyeExpcI3rjaed0Kl/V6oPYWmn+L5m3+MNfn50OPap2/BtrTsWidkC5AGk2EeK7koV3H8MvmBUqSFT2VO4xoGnJs4BH8R/HFdT3moPK68SKUPQ0XcsNqRGQuJXcjlpiChE3M4dp/KTBIn3fMueaoaMp0qrEPXLWaGHzdDU8PiyiEgt7lOQwA7aA2KtUZ4l9qLjD6rUAoRTgXURUObZk8Hu5ezNXPqL6P+VA6CoUycK4U1iKM4OMPMezuvyagLAlV9q/8a/oq8KH6uzT6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwjAM0GA326fJuUHRTBMrYXgmoXamepL6iz/N6pKMBc=;
 b=bWUcwmYnfQHRy8qwkFquMs+sVpNDVdlFhWS6JhSe3YZceuWIc6F5IKZZHsp+pqDXof6mStgk8Ty/5uzCUlnL8nXCLQ0DWNuYwPyicxnX0BhQXf+761I0LebTQ8k7kZtsaN0gkj2ZsRo+91/hxAUP9GfDhfudE5zS/PKefTjXP8U6prBlwlj5XxkCoG9sgWOWC0l7158nKYKI81LcKdVmCUCgYjbjhJMCSMG8iMJc1grG7ezGT93JS8brZ9CtTpAE8kYymkbv0vR6ims3Vos0XuRujy/YS19IYjdEiQGu2gQn3WjbZ8zl/w1kson0/ydw3IngBqRSOAQuvh/JGoDrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwjAM0GA326fJuUHRTBMrYXgmoXamepL6iz/N6pKMBc=;
 b=m5Jr2cZZiiRK3Gh52LY7Jrtnu3Ialgx/wutoQGhbvYz3nB/rJGYjNWR0Tvw25N34QzZS62LYVt7V+WzIo81WiAFF0P5vmypiROnzb8Ox4tuYxDeeDz8hwP4jH+pJ9WVMrAfrpwFf8TWmRT3fJ/akQUEd65dbCoAT2UXsjtVCRy4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sun, 7 Feb
 2021 08:52:29 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::6034:a5cb:2764:f533%4]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 08:52:29 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable gpu recovery for dimgrey_cavefish
Date: Sun,  7 Feb 2021 16:52:13 +0800
Message-Id: <20210207085213.24012-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To DM6PR12MB4650.namprd12.prod.outlook.com
 (2603:10b6:5:1fd::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Sun, 7 Feb 2021 08:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f428a6a0-e722-4ee5-151c-08d8cb45b2c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33388B3DE26EE474A342B86AB0B09@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUyWCXoYCyrb8dtX9uTqq4vWhV3W7wrgntJqGeYDvZSe9qTU5FERAdn6oTAj4oNHybxJXZx4dt1gfNhcFsrG6Rng7lruJAoD6g2hgHVPtpSFqlhryoty+cjzK2opmGTTl6mQ4zeOKn1HoCc/nZv9c6zlAwMLRKuBhb1Pje3Dm6uVbPXhCr0rhxiogGT0BFyzD2y4KrtLlEszqFXXRpQG2jrZf/69MXCkJSlgf6KO7Ro/eO0hx00X9F3NREtwXmzq7Unrpd1kqktQGdnkdksSNU+6n1nKdkOu4fdd3QM16WF3sfVJFN1mJcDw19uKSgzB5HD6r7Atlhr08zFn3LmtOQEXkd73gYEWLom0hS1Yp8dVcUGOZKPxOCvyX9fJSIaczTCZphnOorE0aDBCzaQjPh5g6GoycPP2hR0FKDJmXKPftAEfwAXTw83WXKs9o5DrYvF0nAa1yQykb8uFTO0x96n3NOhpUCFuY0MTiTLgrxp/QFv/JYOUHK6BWkWdpHL/QgEhwxBVRodbkiCYpqlYHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(83380400001)(316002)(4744005)(956004)(36756003)(478600001)(86362001)(66946007)(1076003)(52116002)(6666004)(8676002)(66556008)(6486002)(2906002)(4326008)(26005)(5660300002)(8936002)(66476007)(7696005)(16526019)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Vw3MGweeQcV4J496yFkmYF2CO6hDqpxjzownyM29zDy4VjqewCmyXcibPojT?=
 =?us-ascii?Q?2YRsf3ao+IDQhN8h3uSXggQgXCpjpxAuEuJ2vk6CAPFSqzvaNxILxkAQtUWV?=
 =?us-ascii?Q?1QsbFc+WbAJ4jfbmBNCDxOuh97iNLQdqS8QDKE/9YxWI2QqDML9Y8dAigWrz?=
 =?us-ascii?Q?wk+W5sooXAlUSI8MGDn31s9HT046oLbXmep7V7zcoKog4K88Ke6wfimqW4W5?=
 =?us-ascii?Q?ecFEcbudbn3dAsAdq2E1oAAYMPDbZK/3STUlgf3GvMzFfMCW9lQd3IfjV83e?=
 =?us-ascii?Q?drbRdtowXaTds4TblUtGhqLZC9zuMOlktPdTjtm48R8bqfImS7uP7rKwV1Ox?=
 =?us-ascii?Q?IHrGExlsax7mTdS3WIij9FIHsGl+nqKpUkjJAgq6IvyZQRvJGNHwnxJJ/yXB?=
 =?us-ascii?Q?fMJUusN4W8X1Elu0r0CsEhZS/GDe5ocH7DdsLF6Rm9Wht7NkiOVCZvLwZ5+u?=
 =?us-ascii?Q?8fgKiSMKyTQG9e3B/oLgKwsslWJDADvjjstGTELzjL7NAjLaokFT5he39haA?=
 =?us-ascii?Q?G/+6fZaBFZYxAQ1qvRPGHjffrHiI2sBAtQxLE3LhzqNgqHVyG0IKD3VChZ7o?=
 =?us-ascii?Q?JKJP6KKfK3u13jPry1sRZWkWkzQmS0CUdt3G4dTkzwAonr4QBhefs3XHTypb?=
 =?us-ascii?Q?9Yk+BPd+PgcJrgZJoiOaZrJGhUX0EGqLZ0OI5c5sORaMG2ao3DG56ZrZoKtq?=
 =?us-ascii?Q?OB06kkYZ9XXIa3E+MGmEsoUlMBzw+xBhitx+tw9eVfVQoty92AqeoPMedhU/?=
 =?us-ascii?Q?PJUPvRpGEd49j8oXj8EUqPFhbieJ6hfO+pFbTnG6N9Ef5Tq1DG7D4b4bO6XX?=
 =?us-ascii?Q?odJyMd7MM2yVzno6H5MRGapLM2sU9jT5Ec4YBFry+qqyY7c0aeqgcN3dOjxo?=
 =?us-ascii?Q?sNeSc6A0ptNDkNPgZJT2BD4Fo49PUKi86QRezWqQSypn0JUdz+mvBjp7eSKi?=
 =?us-ascii?Q?ktbtYu++akZs07N3yt0IkviG5OJeaUwb0zrW6Yw77qEZrejEMUIfsLdIEe5n?=
 =?us-ascii?Q?ojve9Z/CJ0uIy8tQ1MiUKaLtcJmE8TJ1tm1gsjAyMFIxgZiFvTv+ycq1fGYF?=
 =?us-ascii?Q?615Tu6DBrEUipsaoPWP+aNgKKJLy5Qraenqw7eSy64dHIGe+nT1RnQrkF4tD?=
 =?us-ascii?Q?avsZdwP18AE04Nt+/6dDTu/fQRYy+emQXFJsbuZ2Jy0H2aoJlg6mHToD//d2?=
 =?us-ascii?Q?zRtwKSHIp5MPqjA4rwEFonNOA77Kta3a2fnpYzrRdBxaCeoledgolI3Hraaa?=
 =?us-ascii?Q?Dqg7sxA0q9rFTVo8FQlfIzK7O/qElvc4Z/UUDrZMM6rbYhIAtTI6TasLl35S?=
 =?us-ascii?Q?ZEYPWleWiEAxA7ucxhFpJlvJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f428a6a0-e722-4ee5-151c-08d8cb45b2c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 08:52:29.0047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMLzdd956TNIHbg8YC5mCXUYUAHwJTCeWlFi6GFJvIq0j1U2nnsDjF+IFy0uTwu1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As dimgrey_cavefish driver is stable enough, set gpu recovery as default
in HW hang for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbd57482bce5..4a7f6c9bcd0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4209,6 +4209,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
 			break;
 		default:
 			goto disabled;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

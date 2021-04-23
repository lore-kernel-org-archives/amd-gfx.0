Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FDC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40ED613F2
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40ED613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513B46E06D;
	Fri, 23 Apr 2021 03:23:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033CB6E06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 03:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEyTH7/9elxIKAkuC9774X9Rh/yz3buf7UmiPKmGKWxJdYkdOQQsoEwURMr8/arJm6NrbON2v76gYrFDyMXZcMggk/Is6yhBQFiHeBndn5Bkq6acThEM9WNFH3sa0CMpD1zqCa4eOiycfGHlFI/6S5txXUHF9s7yzcf290EpNIRCvLWrVTGtRg3Du1TTeL4lDkZtulriJncYGXqxcbe66+NbTZLBvUOzMssAgVGBTGzeJyveWE/YVxXuHKN29Co+plno3tQKJbLSq+6Kd0ATF3aEkb7sk2Z9kdkArxguL3nM+W8SNaO48hXjUMBvu3Ed/hUV7j1tmkh4YoMT1DbYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieSEqHfuv09/0tyjvYe5zmQhS5CfeFYo4rG4lchbYZ4=;
 b=hOD3umi/RoZCPOYch5U1afulX09E++vRGsJogKTdhRDQ3NFEstgEp3FPDWpCNBNx6UigFVy9Ue7v5qRJ0xA5TgIaGIzSF9pqUq+CRi2FINiIXOvWr6yReI11UtpImSFUzkNYcjUpvGx59NHHN3IoDsIxUiP8yiNk2qP18psTEtQ8dh1tF2oetm7afOHuiO9Vp9+E2K5O0CXMIwi78lTMyZsl/eGWThpnNI1LISDC6OJ5jW1PpqjSOlu0uJ6typYXzXtmEhtXYxMTdEF5Swz7SFSFNvtu2dTUgzgwH5IxoTPFmz2zXUnh6/5Btp0YxqWBN5N0mVNxlDVwp7iH1hQIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieSEqHfuv09/0tyjvYe5zmQhS5CfeFYo4rG4lchbYZ4=;
 b=13O7ODysVtCm3P9CDZmzIpZvBTc2mEeSn4YSCJlsQFVrDuITKS2a9NW/euUCgQzP3SgQtakZZLda4fQbeFAD0jahLfus0k6bjRu/+4g9Yvoh7KH+kV02FvoL+UjW7gAekKoX5PjlErIGnvPxhbuOnTi0E7Z+vK4uU9GMSQk73q0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 23 Apr
 2021 03:22:57 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.027; Fri, 23 Apr 2021
 03:22:56 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] amdgpu/pm: add extra info to SMU msg pre-check failed
 message
Date: Thu, 22 Apr 2021 23:22:34 -0400
Message-Id: <20210423032236.6379-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423032236.6379-1-darren.powell@amd.com>
References: <20210423032236.6379-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 03:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434e0f5b-fc79-48c5-45a8-08d90607167d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29561B0CA6E32C82236D737EF0459@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIZuLhmmKOCKdqAU0URoejff62jXMrkXsHjp9B2C9/yMbQOJJRFS2UlZw35nZeFbHLQNW/O8kWclU7Gf1CZfFN+E1FCBlYFhdj/z+fpDJrRAG/vzdx/BPDmrQKzF/tQQj1F4KUcLCQIS2iE2csKq6UY7nF2DLGbATLBdiFunXMBIrHwcZ4d6mvIiCCv87TwXgc0V4pR4h4a+wYIogDujYPr7GANCmmtBHv5yDS2AXOjBarsVMOS/yO0XDqEFQMQYofEShFqZQWDWUZGQZH0v4jjcPM/RliPHfsHpATNlygDb1uHC5AqHS9D0UysGDfS8Fi5Ync1AFrMNutkFne2bqz9tVf8GajUqcwkSF2OOTw2bXs/m0IoKcV3YkZ5bhzfkzca1viLg7DWYPyP7CGWtY32zBDYvA8v4Proh8KnbZh2cDh6Bu0bFENZ9J8vYmylmY2H9E1alSq+FOXFbsTu0VBzmqht4h/HESztRiJpZjOTfQfnh5AkQQrXZmtfkWQ3dnkrwAjJOx3d53rZYnggRwS9ONg3mh07i+RILnqvAifksZNzrx+ZaeiQYi/HkpNq+aSTPmPiiuuUZYT1Auss9hJ8mRGwH/pDr2YWXfHvKWiUggfuifXK6GyM0zdowrNfD5Ml0Nf/iTisdP40OvqREjUs8rTrPRQmsLFdEmU5TUZLydKecDEdSKeV5ovh3y1ho
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(86362001)(2616005)(4326008)(8936002)(38100700002)(956004)(16526019)(2906002)(6506007)(6666004)(26005)(15650500001)(52116002)(8676002)(83380400001)(36756003)(6916009)(478600001)(38350700002)(66476007)(66556008)(6486002)(44832011)(66946007)(1076003)(6512007)(186003)(4744005)(316002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GWGxC7uVoVhDqlQkOYJnJtUXnpJ9BgIFhJhl1trpNXa8BSe9lfe2mou5hb0j?=
 =?us-ascii?Q?+AdMsUXhim4ZIG4rmbed4o8/ttNdIdAGkjsxAccF0UPhRGDk+3+HumqxWntS?=
 =?us-ascii?Q?rkHU7lxAVoWSv00PwUugxTqKQLGEOQKwcDdQ/G1FXgXtsCNPwqBypSdVxBYu?=
 =?us-ascii?Q?My9EaxXTHu8bA+sT97dbmpZDKIwe2nFRlv/jXmuKXEdLJhzQE3s8QCa/08P5?=
 =?us-ascii?Q?7+FMZLB0h2N2OicDKxOrDX0UTyzOS0oI1psoVnxNKvIp0Psr+DuKYizZrBz+?=
 =?us-ascii?Q?Z7q9+hCNbovLZdrJQRneCuHY7Oh3Ts4FvwR+YW9WDhtVFq6Mblvr0fbVFPHM?=
 =?us-ascii?Q?Wa/75LIhniRgL6PHdQ0+HRdiT5HLPJMJ4IvWZPnrMpAhYClgofHtIMvcejgT?=
 =?us-ascii?Q?UQMsputdYO7YUPZpzDdzGJgajriXApDII99MAS4O9j7Akuf/KF/YVmDCwaHQ?=
 =?us-ascii?Q?SUB0e/kJg/YqXOSq7Q36/+Ou3KvdVlp6+OyDAmDB4yjqfGlBjC+hscDG7ilp?=
 =?us-ascii?Q?57ew0ol8Fndrvap4OUCRQQX6o5YxAW2SNI5qDOtojnGA0VwDXLDBRXBshk43?=
 =?us-ascii?Q?puuZxJtS4pO7CzsiVGkXPDrkfrwLA6UruyCsZ46kRvPjmBKU18SSkwF4GUkM?=
 =?us-ascii?Q?88+ag/estVFs6z0p5VaV+O6jNPeuEzD9oTD7/cT7dLK0wTi5HpqEr8maM7j3?=
 =?us-ascii?Q?0OY8hH1l+JEhA8KCDLitBE9HSFnREmASj4bUNMcyAs1dBltFQtHcd5UhcwHb?=
 =?us-ascii?Q?Rl3LuynTy8FflFRIrcQFO8iRDyBn1e/4CaXcVTY6dAPDy6roPE0SEJ7teX2a?=
 =?us-ascii?Q?Rg2vNeYAJOR1acbINCKq6h4h5TXiR2phvbOsuEzMTuoV9YEnir9ufb9M4Sg8?=
 =?us-ascii?Q?gdsv6pi2tyb1RPPEDaDjQDg0iw/01ojmiePUWzmqZxq8/iV9gkMDUMUTcSPF?=
 =?us-ascii?Q?SoOK02aOjaxEMuohj9C1lUtyFBdHqQzpIbbyvoVRiPJm0U+EC+FJtzcnhD5O?=
 =?us-ascii?Q?Gk+tljm1VNroWFqCU7XdQImMtoruax9KDwwr8dMZPuCzqisl8bVu1t0nFOsY?=
 =?us-ascii?Q?hxJB9tXNvSkGigW0K/OBpbhRN9UPhPwXjLNk1TBZrPxHop/YTlzq6STKwynh?=
 =?us-ascii?Q?1g3G3QopIGHXnRcqLRD6gRWpd3V2GiTzilncdscWRQhQVIaPgUHJwoGiAsLz?=
 =?us-ascii?Q?CKaFdaacpHwcUVAZD+Qmp2a93nnfKTrELYcqOXesGSdiSYlFiHcafVDdoSZt?=
 =?us-ascii?Q?2SPNEfC7vojbEnHJa9W1XRGgwwbqwTNXbE+EeWqtV6s1WgHXR70411B78ZZ7?=
 =?us-ascii?Q?r6YavBC3vTfeWICQoExpXww6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434e0f5b-fc79-48c5-45a8-08d90607167d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 03:22:56.3760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svLgJPexJrn2QzXVNC8JXTdZEO3QoxBpgvB1CfwHlTyxIMNRsAGclyAkfNpecuNJhnM8kUbuRQ0y9mPS5/kYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Insert the value of the response to error message emitted when the
SMU msg pre-check failes

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index dc7d2e71aa6f..5d1743f3321e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -104,8 +104,8 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 
 	ret = smu_cmn_wait_for_response(smu);
 	if (ret != 0x1) {
-		dev_err(adev->dev, "Msg issuing pre-check failed and "
-		       "SMU may be not in the right state!\n");
+		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
+		       "SMU may be not in the right state!\n", ret);
 		if (ret != -ETIME)
 			ret = -EIO;
 		return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69496C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD7764EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD7764EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BD26EB8E;
	Wed, 24 Feb 2021 22:22:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5056EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnZScq4E7CZ76eY+y+TjTGsNgeBhXke5z+cwDQQiVU43LnD/qe+KFDkEWUHEbRdY/NQUhksB3VgAieUQDThfNq14+QmeNjFTdjD1HSyxQdpZOHajeQT5fLz+btJclp7Jo6E+f4Y7JqcCADXTBuTDEsNgnpi6cBKggNgSKkeexqNWUIrsBrtX5ji+a3yFJxQvjWLrLk5XiRA0BodluLZroPnHbEz2okrV1/6br6sI8d11pPjfwopOCTv1WK2H+BeXoijnW/cxGPdAsEU+SRWENbnJeOFbRVeWpaKc0+rOsSQrxgVN7aBTP6O6fgzUx3lk/DKcu7U/EJh5eVLsrdplSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spnqb1rcif9vhwdvN9H2rqIvkIvEmRVEwgOlyfvnMyE=;
 b=jf4MEfv06frbtMU1mub/ojzJNUsHh3U/vniz6Ty6DG9mlQfupFAsdxr1WoSzSW4S44qIVW10Q8i91YmfvtWLRTcWn43ImrWy1e4BT/Hm413WyJxdC+0J7leh6i+FBQYncnS/0+ESPabcxWHPl8XVl1tUpZX4blJq9JwIrjtMGLDTxpOFZThjl4YRFJorhZLgZA7pBQyECbDfg5MNKqjfbwI5kxVwzw/N8e1XYSVpPS50WkdH/hT41Ca9GJsuOQQOSVg3iy7TCNQ58Wm/LNmmfNFdjW1aIel86PTCNhXjq8Dz8ufoqhg+IyGFnFm0TQ0xEk44YdBf5kvPIxGSwLnqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spnqb1rcif9vhwdvN9H2rqIvkIvEmRVEwgOlyfvnMyE=;
 b=bfDDXCNgjBgKAGbupDF7u0/YnUuWnEXVxIRnc9ovGGtXyZY1N/HwYBx5w19LxNl2NqXyvNdOMNT85RDh/sFNNvmYfw+qj2DJEtDH3JpBo0zgfY0th2PTdsHbM6HENZaxKaMJx78CWq39FGvzrcEAGeLNVIWO37UouTV1VWp5zTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 125/159] drm/amd/pm: Correct msg status check for powerlimit
Date: Wed, 24 Feb 2021 17:18:25 -0500
Message-Id: <20210224221859.3068810-118-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7feb384-0163-4b32-c70f-08d8d9126fe9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807B549A2870161545A38CAF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEDd8xNTNd/sAMxNiaXxEUzKRISKaNcQohTW2hrDwYgn0n9U6RfQ1FvU1oCg1vOmW6cyuN+Zl7857MhWO5HPlnN7d4NIA1LiljBtiTgq5ABrRskbjIeVTZ3HoJA+I+Y1TL0q/ROrV4yFWccztKMkFZFPPTpKe9pqrbgwRfq1d89mlMIBs4G6ARFxuu0sLxRcOSHnqHQwzsbAPPW+8wDEGOEhG9ncjgYEi+MV2BglReiywlGz4fScLJE7oTWXnHjg6OX9hHt7CAbWPrAu7qo9SNXf4qGbkUl+ZDTHCh4r+ewwXk35SwulqyTLwr1Kceuj6gByCF2RbKNg9z1vWOcL6zCc+QbPOH718lUcf2Bkc3YhJ1EkoeKfUsMJq+AzwEEn0ivey86kyrNYOEKssH7rNF6Vved0WbOitncR/80fUuO1o8elB1R98RWZleK6N+wa9OUds/FfZ0sH/V8tTIym2J3J6bY4IMmZ5xb/ay9aSehVnLOn/1sYK67P/vNO1qehmrVBbI/j2C9ItMXQ1v3/ksnXkvlY30sIwa89cYgdCh9rIKW3Xrb875CYqR/zBw6laBtxjzLzXPsyU9sw5vsX6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?H9Y3k1HGQPutym435a1pAcXKz+aSDFICJ8DwTYXuXWc7bztU8blh0CKJ79+L?=
 =?us-ascii?Q?7+XJQpv8RgRkh3ZJrv0s60rddcD2MPUR8ijUpib8DX15Sx7Vrb0vMmYYSrrG?=
 =?us-ascii?Q?+nNqzlaDQ4f+jjSP679ey5m2NpvAipVHoC0mLwTMVUKql60yHEOxSh8NrdiA?=
 =?us-ascii?Q?s4N4n3/UpvK04r66SOisrkvUx2GP1YxOAjEVVyWbck4Ez5zioTtgG6XJoUe9?=
 =?us-ascii?Q?jr4Cg5yhS6QB/t5Cpq0BjiNqk6JDkg5eWeUBkJ7hYXOP7hDj/3KjP0p6QN1M?=
 =?us-ascii?Q?w7GuKXhDLE+yYIM8Jez2Lw3os5dxD2uNiqB/AkSiFmXR4AjpJVN1B/G6O4vX?=
 =?us-ascii?Q?AH6Dp+ewzsG3Na8Iyy4ryuKuYtHnhqJWfIlpeV+Lqw4wDlLHusADBWVI+8FW?=
 =?us-ascii?Q?6rGfrFY4Cj0En/h4SRBRhmCFshX7QT7SwIqhP+rSxMRX+yIoW+tcNI9FtgWd?=
 =?us-ascii?Q?OqmctD/fshWApyM4yeR920Q/261gceqpbGPzvJmTUC3n/Sor0oOYdx5DoVnG?=
 =?us-ascii?Q?jrlbgEBdaFS63RIDLc0kRLti3JJiVquCXYMnL7UF8p1sYR4UFFqVGnMeCiff?=
 =?us-ascii?Q?cFtEeyhWmyl0uT7/Qr8t382OaOQT4iXZby1bzB2nGyr94NujOucWMfTRZlSz?=
 =?us-ascii?Q?S30FCnkJ0rL5E1EPbMajHsZsGB+cs7EK72HFxyq/2rpPIt25O1O4Q8kQfUTg?=
 =?us-ascii?Q?ibkAit2gzgdFOhEBbr6Y8JY5AJg19HkMtiBlZBI+XLQv8WWn+qJkgCDWQ/vh?=
 =?us-ascii?Q?LGJ6pHShWUsdquSs3zoC2H2JGUHppCVXlv59y3WQGgatb6S6QdAtB7C3j5oE?=
 =?us-ascii?Q?mQseEJNfmEDVNRQ2wh0ygDy/dTMnoMfAmnXE9n+kpq7yJHjQ1qNZhlPSXBO9?=
 =?us-ascii?Q?XTo02NtGWgWH26Tq0u+AhdPK7TQ8/r7Y+xnrWfmCxarW24cVGaOLiJDplpXc?=
 =?us-ascii?Q?lIwiU2NL3rIymSRrbp3FjN03PAnugLWpX2q98GSsU8opfPStPvTqemMSabKa?=
 =?us-ascii?Q?mLJgrd+IDOp77Pt80KoUlAyGdvguRCsZml7OBe2MugmDtzM799l4RyAfRFf1?=
 =?us-ascii?Q?DRXsRrI744PuoXnUipKGjmcJ0T/gXBPmM4mlMdOP5yRGPwSsewSaCGfH8HC6?=
 =?us-ascii?Q?LMQ8go1KXC2SE/W1K8720yo++febPMmFSxTUOvHnfDl+0yulJI1MiWxwM3/c?=
 =?us-ascii?Q?jTsF+SrPd7w1SJuOW2bHHlyv9LOspX8drzXI21klDC64jln8UGsS+VenKyhz?=
 =?us-ascii?Q?Ys3xmmoP/rXe44hbgy8V3YrubVN+ZTxGBxmlwVpIVp2sDF323SIon0R5n2oo?=
 =?us-ascii?Q?7VUP3qLZTcrrep+QZABoG7OV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7feb384-0163-4b32-c70f-08d8d9126fe9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:48.4987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9KHAnZR4I9lWPXLRtZ3BT1DyJU/z6l6RHyJEykG5TUrr4m0squ8dQoqaAkUsNBS6kAbaet5aWsy0Uzrev0xpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Status 0 indicates success, fix the check before using PPTable limit

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>`
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 629523858660..df94604edd97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1072,7 +1072,7 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 
-	if (!ret) {
+	if (ret) {
 		/* the last hope to figure out the ppt limit */
 		if (!pptable) {
 			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

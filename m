Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB6C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 09:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB1F61456
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 09:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB1F61456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D916F4FA;
	Fri, 30 Apr 2021 09:10:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E216F4FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 09:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPLWO5xR5iXtptyimk4pmuwq3EfHO3d2BtbRV+qsWLHScFR3Hq5ICl4QNlCa3raZhJJMoyQ84Yw28goQSqEAX1XUw3cGddiwrEqZakU4bB7UJsEt/kcaGRQE4DFqAI+15xTvfeYRzltFAJxKexz3Kjj1gQi+UEa2Fj8Su4g40JjaS6nxM0rchaC2ZBy97EXwj/VrKBL+iU3VsdPWgdzsQ6B2pWXQJ/97xuEjXsmjU00lnoMfNBW5Bw2fkdlQiEr+duQ8RqCkPpgArwQcNYXrZnlV5Iz5/s9IW6UD2AFQVc/0PezFmPG2QM+aWnFOPN7XSt4GQF59rkCLohrx/Osd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTccZ/MTnGsa3/EMiEBnw2Nw0D8yCMAsOCCDtye7Dr4=;
 b=ao1fqD8t6dbUSBAmZCe9oXPwXH6SeDKzdweHY5FuOGbj0aCYbtIu2gleK2tsy7iSwnEnvk8NWO+q5oUekeqrqJwjiZRHokHRxfI537Y61BOJZ5XTC6pLdrTsn3Nc/lAMVL70rRys8WDRa82P3bZM5EdaGhwE9tXaC7Hx9KIjhduZ+OQ4cdXF3TgNVE0NbxVhgxxA2PF84l60STWwSSOrPy1JkRm9rrk8WX5fJf1KrCDovtRR0ZdL66irm3Ak2a2qz42u7PtCFnJKX+/WKoyvNgiD79iVx5gBnA1b2Z7r06XeQumNL2U+MoadBqTsOSGn3iXZMEB0dvIGLiTYK79Drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTccZ/MTnGsa3/EMiEBnw2Nw0D8yCMAsOCCDtye7Dr4=;
 b=X4w4FRkiuWL1Fz8ff1scweU+4vbnR2TM3xlE0BAZ8Ooap/w8+n3aXU51f9NA93amKCaCt7MDxjO/znDk+rNveCtpI+2OsIxnLXOOwmSVS7j0y3p4Jgn6NKo3Bn+zp92SjsmwDsaUxHYtRffz6Sf1z9LSrkTJuYAS+jt0nLQdZXE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 09:10:07 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 09:10:07 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Make svm_migrate_put_sys_page static
Date: Fri, 30 Apr 2021 05:09:53 -0400
Message-Id: <20210430090953.31524-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 09:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08d9cf4-417a-429d-5bd9-08d90bb7bfb2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-Microsoft-Antispam-PRVS: <BL0PR12MB48970D484D4E5EC48226913B925E9@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUfACYuwjtviVNTKK3F15chwzpYXOb5Iq55Egq3R1y8sNRaY8oGWuk3XpaGjNqaW8JJH/HFVF4J2o8Edp8kz8xBRTo2EdFIg+riuX4acQBmmvzPdl2yNtfhZLb+rVDqk8eEJOQSZw+W3GxVTX5f0R4mybAFO1VNo5dC37f8S5tSK+Qhm8/2NTH59wAT52DMZ6e4IRr8meeQybI/pjgM+DjE+lvMT8SGAozMu/pfw7fbzpn6DzCSsZYiAc9EdSpkCpNEi3qvYPgHd+UqAjLn4AsqkVaa6iatxvP6uXf6irG2N7Ozf9hTcWhLBC+CnbcK0MvBu75e9VbjkDhaRz4V++vW3XrvihaAG6k+qtAb2JLogobbGKSJmbooWRQ0F5yHfU3jovGMygevd6Whijoi4MEfnnCpJ0sb8al0J3bK6K9C6UaLXO5yhmDor0aLIfmnhz/z/Vx7IwtucllccTSGyI40UB5Iq3At26H0b/WvzmLnaLtxfA+AcIU8oNKDiFNJn0djOVCtp/8/cvDVAEIxAvIyK1LdjNTLg2HwZMhd6olv3/StqcBQNGlJwuhV3HXfFMnugTMdUDIDE8vk2hGywWqHDAFDJDlAr7fNy9xbsiBAxJI99drG3RnNHLo4ZIF+BxEa60ZO5AVGZ1MDIGR1d/U58JYk1FeM0bjF8jKXHsgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39850400004)(346002)(376002)(396003)(66946007)(6486002)(38350700002)(83380400001)(186003)(16526019)(956004)(2616005)(8936002)(8676002)(4744005)(66556008)(66476007)(38100700002)(26005)(86362001)(4326008)(316002)(52116002)(6666004)(6916009)(1076003)(36756003)(7696005)(2906002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sJjFnXaVKwtM5fuwsUPmXNMr0niPG63vdFlVLuu65YWQjzSogikKiBCUsOaX?=
 =?us-ascii?Q?leBo/oPHoWLVa8wSA4andfqvPVv1YDO0D9FrMpT/WjwpK9ZeOM1gE8dUyKta?=
 =?us-ascii?Q?citzur+rrTXlYtn8j5ogBSc4VZAKN3AfJF6lU6AFIirZCD6mKIAVTraGgIwE?=
 =?us-ascii?Q?d4zrye4VMf98suyRGLcOsM2keURr3g0cVRNNjRY2vwtIrRt3Zsl8uaCWtymh?=
 =?us-ascii?Q?6H7rtM6y1bhn/0SIOjAltnKuzEHh7iLSu5CS89I22U06u5iqRMSPsEI6LKFs?=
 =?us-ascii?Q?S8DXKPBgaD40a6iMgeWCtkdivzJizticZAF0fp01fdIAtsuxgoVVfNqD1IlR?=
 =?us-ascii?Q?5XzAf6SPm/G/bD01kpvaMVmGON8AtG/O394wi3ir4IRa6c1FiKr/9aZSf0Db?=
 =?us-ascii?Q?wO2rfb+cPTA0MbG1EGRi0XdGTmeQGj83qSANVaat9H3+k76g3kaxlYsgRTGc?=
 =?us-ascii?Q?e2savyQ/1cr2A5BgBlYYmpxH2JtqPmcNmHH+Kf4srgH9ipmLNb9efYm2yu0H?=
 =?us-ascii?Q?qBia1WsaLLiUm2uSAHGtTSjCd9Jr7pBnnFRBznvZuoAfDZewRaurLJSwU2/v?=
 =?us-ascii?Q?GEK+c8kysmZEcCNfkuEDZLbAopXciB6+h2GjdDc0rb0I7S5D5fUVdcDxKUsU?=
 =?us-ascii?Q?OK4lPn+LETOCnYfFyppKWYHK6JBnGGZohrzYPKRsKgoULXiV/4PHS/2L9HTA?=
 =?us-ascii?Q?HkCpwzgQjlnkHofFWfQNEE+/DcEeQ88R13+gvLUvS/BBdA+7NnZV3+kgtEta?=
 =?us-ascii?Q?lpo3Uzn4pyUFFm6TePFfuQTuREkNJWpFNKkgXeNCp5Y6tN6COXbDR7yR/+9N?=
 =?us-ascii?Q?j76+eSfVzSTJmGdPbvneRNAJUKruNqOedUa0VLoPuKJfe+PQQVO62msBFced?=
 =?us-ascii?Q?mIzbVWmXGDtg/SgPjKE0vF2sy51RnliHmjlu6EShotdPwuluxnBjX6YOnlxe?=
 =?us-ascii?Q?ZGJ3wyNL6RGTc3dMeM1nJsbYTBSKx61D+SgLDPMIOu73lDEXw0an23sysCCw?=
 =?us-ascii?Q?4zgueAqnphBAkeyCRGq7hvELyJSPMzI4TC+2rf+uNqSdNNjfVEUB42IRRx9+?=
 =?us-ascii?Q?HABs1dcOD2bxQ72iq6RtsS+3Q8OGKiygiKnD7dHuAwY1Tk2v3K3hmoDxI0Ew?=
 =?us-ascii?Q?Yw83mfwF4EW3apwDxjmrseZ5SLR0vLF0weioV8tBBk7tlrPhcGwXVPgeko4Y?=
 =?us-ascii?Q?AyR8kI+hlRxCvJHBpk8PBzwe8dwZNKmVTtjDoZBZ9LYA1QjW1sULAvxB7Q51?=
 =?us-ascii?Q?sSjHUzrgA777n71JlkO642acr+QOCNQrA3mF9P0D01TzzN2jne4eaupl9gOS?=
 =?us-ascii?Q?FleI1QH4oDArqp/o296a4MHM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08d9cf4-417a-429d-5bd9-08d90bb7bfb2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 09:10:07.4157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzRoDBT7f4M4ktztIeIDy3CDcyNnNZGrO3x1s703q0vKlnyAdiWkT1Inc2OMLKoe3gjk7PVQdUrnkSZ9EKx0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function is only used in this source file.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b810863f6ba..bc2fc528ad58 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -281,7 +281,7 @@ svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
 	return page;
 }
 
-void svm_migrate_put_sys_page(unsigned long addr)
+static void svm_migrate_put_sys_page(unsigned long addr)
 {
 	struct page *page;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

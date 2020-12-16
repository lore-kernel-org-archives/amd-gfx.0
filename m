Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF8C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 03:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B825224BE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 03:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B825224BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92EB89C97;
	Wed, 16 Dec 2020 03:40:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451B89C97
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 03:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c393x20OINUHD4ENTulUO3E1K4OCkWub5ZmfFrrxUTQBoiU8ft0e6RuKlYIy18/8wK3IY6xmcarAj/ZmNFf/gh1bXaNcZ+Q8D3jU9ARAsCHJKuIZFiXmHz/BOwHDh07h/Q6qqn/XeFL0o4V5azGmYuoxsCHugXPMn1hOWry3bEiUUUOPbh4E1kRQVk1EF7yNY787r9YLKqSNFgoSyp8wv6fgcRAr2hx1otP0XXmkzSyqKZ0IR9uyg6aUhhd+lDfcz/FKCpNA5nF2g2m0S9gBc/G/IFwimvtn+CrNYKcyvmmbG/EJAdQ/CVHz9Y1FaNCnd4i5mOotefdWZFKlRINSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C41AOXHYN5aRaWFNSiMkFNBQDKyIBTjmmeVL6up/cbM=;
 b=AG1oyp4G/q8FuOO3IeZd7ziMHzHvoJHxreGVHgMaXzc2o9BPeaTkNpI3qtEYqjWJjUucH7xsrKs13fOdBt2XjA9pDMJlFk5uFMihR6zzJn9m4y6MF4asthginkb6cFXnEbIKSw/P11f+gIlxYlvhu/qnrHMsTjXhhbjJ8G3Eg/aN6peNGcTY1F4MZ4PUD7Y5fi24kcaSRn3MQIe8xhfuIy65tlKJI2CqvOpz7g/QKSDvxGNdRqK1QT6qQH/jdNBBqnlHRf0NBV4BbuxM+FYZjHfs+ncRg3h8ToulnNlkslwAJd6NN2DTQF3Kj0b76H2/vof4o66/RXAkz2K/NiTYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C41AOXHYN5aRaWFNSiMkFNBQDKyIBTjmmeVL6up/cbM=;
 b=ArgNNPxkYl7QHDiSDb0gCNji/G+N/ziJIJNCuOMCcw2lpMGeqHKur+5twvdL5Qu4blcexJc0fnZHVoxW+qRLWBelOC7ATuR5CMRfMZcBMmtscOfRauAkg1/gQcfDrWBU5LviDe4xuCAcbUNOZsjaW9heQwNBHq60IKzKR6/0RqE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24)
 by BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 03:40:28 +0000
Received: from BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006]) by BL0PR12MB4961.namprd12.prod.outlook.com
 ([fe80::b520:3528:f738:8006%8]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 03:40:28 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: print mmhub client name for dimgrey_cavefish
Date: Wed, 16 Dec 2020 11:40:08 +0800
Message-Id: <20201216034008.28027-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To BL0PR12MB4961.namprd12.prod.outlook.com
 (2603:10b6:208:1c9::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.2 via Frontend Transport; Wed, 16 Dec 2020 03:40:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 264adc42-a300-4543-e2d4-08d8a17454df
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB235398E5B16A3C6BAA5F010CB0C50@BL0PR12MB2353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gknn8DgUykYp1/cjIeRWaLNmpudyKDN0EAzbtciU8ZHo/rzT4BbGKNTQRD1h7b9S6B2mONw1Qo389PVZVOyHONLam9IRmumz73EKw8Y4PWdHLUopZ3NnRePbxtFRluGmzDUP6AV31SklXpzk/9spALvBdwI03EJELXVNlpchPQHOXyaCz8ZOTWeaXWCFLisM6KA9B2TT0yA3/wI7oJBhYruqphOhf1+h65y8BYGAfjkv3Fidg6C+iKsK6hF0b9SodIulOPxrOoyQBworJHKmx0XOBsKjRTFEqfmZjVkt6pXZrjbEeRLfDd/PCzQlnfD2Z2IOiVZ0/ENS4jAuzPrEcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4961.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39850400004)(396003)(376002)(83380400001)(66946007)(26005)(2906002)(66556008)(8676002)(5660300002)(2616005)(86362001)(186003)(6666004)(36756003)(316002)(478600001)(6486002)(8936002)(66476007)(956004)(1076003)(52116002)(4744005)(4326008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5LuRxYnwGD/P5TNRIhFNUjGdoVfTn5LY8ofEh5YbmausUcFiF7hkwITGtHXi?=
 =?us-ascii?Q?cdEjulr5InINAPrgsnsCa/1PbAAmeqxKFy+TXgXrnpOGJHtOZ/0g8H86wQPW?=
 =?us-ascii?Q?pTwfhJfzaPe9FwZyoMABeZ7NhNPwJWT6R+ulCXJO4q3fDpJjb9jEEj8BEao5?=
 =?us-ascii?Q?nKnweiir5NbDAYkbq8ahAKj2Tczv0Nvyb9xxFwz5tk5eq6Nb5axzdjkGdYHu?=
 =?us-ascii?Q?Mbt+QDlD+xJCR/vhxdSe4vaq3IuIL5nsOHm2d8VyVJibGUZWMTSoV5VyeHxp?=
 =?us-ascii?Q?UFqH0jNHZvOnkZ+CBwB9MSrB27FEtdlBEKbB6d9n/PN+ll5vBBhGKWOHusk8?=
 =?us-ascii?Q?z0EJlKic1RP/o4RTwbfi7Bww/avc14ZVf58eG10P2aFZAEheDOFFk7H/Iggd?=
 =?us-ascii?Q?EBTn9mhcth8RyL8s0pjly6gayjeQNkgeDqGJyd8FymZ8AETXIUnLpKzOQMDn?=
 =?us-ascii?Q?ypI3XumRbfJY6hcQwkxJJrvRwN9B9O3j/OqO3RMo/5KT+wdv0tSMfCVmUTYS?=
 =?us-ascii?Q?liLeAJTLLVVMsvaMAUaziQuKqasbl1BkDj96vH8497n/bSQvNoICCKVdJWpW?=
 =?us-ascii?Q?jr7lE8dRtPS53ptSBmRV6VDvo0PtxyBxLuZDLOUPAk0qtJ4YlLK0KGdzc8SZ?=
 =?us-ascii?Q?39t8yrh7oVer0csLTJvHESo4Ye5Mt65bB2sAe/xmlllTnJ/m7Y0+aPaIO615?=
 =?us-ascii?Q?Z95tFVkxj2HTUoNezogyUeCtDiTthBnFjxPhkKs7KLxvj9iVNx83dmWCjTRA?=
 =?us-ascii?Q?zmczB2j2z3Cco5Cvyukf50Kguq0psK0VfWycHRSgPFfiAGTbvNlLH9Hg0by4?=
 =?us-ascii?Q?Nsc4PJmYgHOqkJ+wZqsnJQd5jqkNYERa1WWKnBJqhgkdTZ53/4GI4cAqBjrX?=
 =?us-ascii?Q?/z4IbXn7dZGjL5CA3T4F4yNEXAXIYojPpWV8LJzWhfKeqQHdnpG69A4aVevi?=
 =?us-ascii?Q?VnLd+Kx57Lw0QM9YG2JwxUm2BiampSUyp4P+QaKoWM9AcY5yshOny+TMoSBR?=
 =?us-ascii?Q?BoXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4961.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 03:40:28.4604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 264adc42-a300-4543-e2d4-08d8a17454df
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbUPDPUTbUNDk7Plcp/sU1JAcxMr/xSgkVYsfW2IofjREXybSQWrnpHGO8EcjF+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
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

This makes it easier to debug what block is causing the fault, same as
sienna_cichlid.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 092ff2c43658..f107385faba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -136,6 +136,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

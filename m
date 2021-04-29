Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A22C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 01:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83F361450
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 01:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83F361450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413866ECE0;
	Thu, 29 Apr 2021 01:54:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB666EC73
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 01:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJpmfZtsgOSXtvwUhWnCDPvpWcd58hVASORJk6GN4ef4t2oXC2AzDK09QJQIJvp3Nyt9IvnKyH4h6okIiOvGOjeXRWd8c52QJnxf2Cs7QpApeM/T/cHNrhrIw1+lUBj8oB1tNEalE3S9OXrupPzNv6hiJpanA9dA8r42qsQVO0Ze8po/hvFQyn0xUsBe5YTf3Ai3rr2gO5YmGKAc1dmIiGXtm2sNdbgVvBVXOH6UeWKVo84kifRhGbzC8Fxbshmyv3DK3Wki2FUpkFsOPpFHafD3R1Tk8bxmHRrU7wbirw5pDkiVhZE3k1+shiAQknuCIdZXjyzMfbdbxrUq6wzTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSz33lFyja06v/OkSQoJjUyjJvB/2Z9LC6bnbUD7p1U=;
 b=H/mFn77ZCTIHbOCwks6ttZYa54WlPGq3W+UfTe7Jzz0yw4kzRwMSqtjiuk9jkhb2QU6mDLiFNgFxy9pKnDlaqPaPu8JVDCoRE9BtyclYpW5E6FlNCQm5pdJ1rlrYWnsCyYmi0EkKSPRUMAevP3XqeZQIc3pwAw5L7eNw3mocYZ5UQfFf7xUOWP4NQaJgkTjehrSN2IA1+mYlbCXLHN60Nn9Hm2qF5kK8YTk+AlRjmmhFc2JPUO0PLdyWzk1U6O9MMYTwKLsi90fsNQelOZVIEqorDQNxA34Wmml8vJ5vEY3+X7864Bzo+GCcN39mDtaebdAhk5xEFykDY2G2s5XhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSz33lFyja06v/OkSQoJjUyjJvB/2Z9LC6bnbUD7p1U=;
 b=xofxaFDwbEi1B7DSdL4f5N4A8NQ+JkedZQi7GANkBEQe4LtIX8H2ZJOFy6HLVuTjVUBh7exeZC7W29BlxM07br8n5fsfZbMf74qzwLLBhz/E70ZZgx5QqhncomNj4/zc33wgxYe5QRAmJyDB3qhRligt5A5sqxoOsP6UJMCTMFU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 29 Apr 2021 01:53:54 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 01:53:53 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: wait migration done only if migration starts
Date: Wed, 28 Apr 2021 21:53:38 -0400
Message-Id: <20210429015339.13047-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 01:53:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6168cc96-ceba-427f-5f2e-08d90ab1a428
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB351498DA746ABE74E03FA516E65F9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nGXEEoF2c4fIDAmmfl9xROlsGM+2p/j0xcqQCsiPNsFk66Rsh+2WhbkiTBDpn2usOC6XsB+nm1Zy5n+chAB9hDn2COqhVU/tVyMhFVRdBAsrmxCw11uN2CKBjAJx8fzgjLxr1Gf7mNTxphvAeUfCznLUSALkTh9G3OasDzvgd96V9O3aW8FdqfUfOmhmjl9SL+tZ2SEfEAVpMDj2ZbKKRNoKGHESCotTJkvsR9sUSWxIAXhmv627KP/EyJv3/w+LLpI+BS5WvpWNMqO1K0+zAD47xT+rTJKsWBKdLptzrFDXxW4J177jl3YW92Ije/lIFmhNEKoNXPIp1hb+4spx6VejanbDDRF08t3C0SH/KRk6qcbpXhg0brvJP+6CYi6IOujkMqEzoeOUKoomLrQXIdAc07mQ3RvLqNICOTgVB39sM62jAmNJdw6wrhto417TbEX+IR+BzMDsEfqAP/8Qczo1PE4ZVm0qnptBd8gavZzYEEa7OHOCQBXmo6apaz6vqZSNyXb8gA3jOupDnDdok+voNPwNf+nDEPa/MBF036AwlKjSDAZW3DEXla+rg2mkmm9tmAHn4Wc8Gn5kLxoHQ55oQXgFTpiLYfDS/dmuefipVyl5doXPMVMT++HI8qE/3l8+WzpOw8dhUM6dt7dso9HD8rg+WI4GSh3vpMRpGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(83380400001)(478600001)(26005)(316002)(956004)(5660300002)(6916009)(86362001)(7696005)(52116002)(16526019)(6666004)(2616005)(6486002)(66476007)(8936002)(2906002)(8676002)(1076003)(66946007)(38350700002)(38100700002)(66556008)(4326008)(186003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MK7ZMCVLx2xo0RnndHgkK3ZI7OkocRdhjWZlY2vIa+AwgIFh3H4SRQCNwzPu?=
 =?us-ascii?Q?/Bo4ra2/xu5l3k4TSy4lGIC7dY57bLjbZhdpM4MZGgDUBjEkaPV4fs1kSXrR?=
 =?us-ascii?Q?wbqrOk5grY+KPElamq7yYVS4sUQdsK7jsLKkEwyXw8gU7mfM7h+F0vl4wJMD?=
 =?us-ascii?Q?TtK24BszPUo3M+8kvFBr/56Mnl5EGSeuxQSxxmt0Us2L4hgMohUHyRtyl/Xz?=
 =?us-ascii?Q?OKMPOiuaVHCv0bIFsTDaCIUEoGAlt02aOtAWKayYmqkZnmLA9081aJPGU+/U?=
 =?us-ascii?Q?rP1rm6UoY+lDhy47vb29BiZE3s/2FOystifSb6Xo0vwaad+TFmWuMnVt46uJ?=
 =?us-ascii?Q?hkURPEjz+KM+j+AhLISv4mw2exlCwuN/sLiX3AssoY9Uy3LrqhNOeCQJ1jIv?=
 =?us-ascii?Q?/n7ZaIW4zagpdrj7iVHts0UALr+hNf4gKoj8H8qQQAvqZ0E+dYzBNN9SqwS6?=
 =?us-ascii?Q?FrdzLBHB7NUQxaj7+F+pOl8zxfO7tyjpjJK4EasneM2DSwS9v+X95i1TJDqF?=
 =?us-ascii?Q?F1v4gIzEDIFI4DMw9r0J8Zjns9yHMi0MJJK13w6sDHyiEuwM59e5Plgheqa+?=
 =?us-ascii?Q?bfNyDkFVtiK8B/+qn5IV2MOX/UMcrOHIs8kXvnX+Bvu774F0LqnKXXAQeQy0?=
 =?us-ascii?Q?9WaHZpbnxkTp9pBOMKv9b9QIkUQJiBz6UCm3mOnj7qT5Zz+DaCL0Ae6kAX/m?=
 =?us-ascii?Q?jJgrnssE/OGSSA1jGSwUUSKGfRcF3IeargZYcEOf9ZOZZIY/2tD4A42SDFYt?=
 =?us-ascii?Q?OCwNykvUJ9OxsqLZdxIAxb9r6cZw6wD40HHQms7QuI3O1E2Hr4kIy3UMmwqc?=
 =?us-ascii?Q?OuzMfVy3tOSkuPYLjayxhV+VfdFlLQsW3jrcJ1ODuiWE7Jz0kFOzQg9yLRlX?=
 =?us-ascii?Q?q29bmVWPq/Y+qrB4o/NWZldCCxc9Thj2Mfc98597aeTJpLBE7nEOw8kbwk2z?=
 =?us-ascii?Q?Fd4zSCxsdsXMvRf9haO3gSdsSPsMs3m0Xsd+Hgl/JX45SK41z+ZTZhAdqEt5?=
 =?us-ascii?Q?b3/R0KhUWIC2zX6rmfGmQf766kjSAhi400vYL4EqSNR3JDVukq1E5/aOgSBd?=
 =?us-ascii?Q?HwYYpzxSZotoNFtYDH9mPlHcwNejZExeloKNCAex5TT3nIBntFPl8UYYVJzP?=
 =?us-ascii?Q?ijbeD2pu7wpMuJ2lld55oxckGK/H6NVgHB0CjkBO8bqqe/1ZLgbynfrQQmQm?=
 =?us-ascii?Q?kAuXPoAjOgvI69+3800guIdBJ/CB/veO8dqW37ffCzDeOCT2o9Kap4xUUw5M?=
 =?us-ascii?Q?9Lh4YmXDGeNpQTqhwl45BhW4NCoY9tgX2SNZvEJpzb8IQhlFcVpj5b8c2ZOG?=
 =?us-ascii?Q?SADkwVW0nYE0/BoOOfKhUrJi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6168cc96-ceba-427f-5f2e-08d90ab1a428
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 01:53:53.5220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WzM+e61DC4aiyx+5gdoub0Lnq27Mbsw6BdoTEjLL+M4xeLEQXUqsgAfQfbDe3LD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If migration vma setup, but failed before start sdma memory copy, e.g.
process is killed, don't wait for sdma fence done.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b810863f6ba..19b08247ba8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -460,10 +460,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	}
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
-					 scratch);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
+		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
+					     scratch);
+		if (!r) {
+			migrate_vma_pages(&migrate);
+			svm_migrate_copy_done(adev, mfence);
+		}
 		migrate_vma_finalize(&migrate);
 	}
 
@@ -663,10 +665,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	pr_debug("cpages %ld\n", migrate.cpages);
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					scratch);
-		migrate_vma_pages(&migrate);
-		svm_migrate_copy_done(adev, mfence);
+		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+					    scratch);
+		if (!r) {
+			migrate_vma_pages(&migrate);
+			svm_migrate_copy_done(adev, mfence);
+		}
 		migrate_vma_finalize(&migrate);
 	} else {
 		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

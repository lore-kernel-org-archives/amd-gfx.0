Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E7C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B7661941
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B7661941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E056EA92;
	Fri, 19 Mar 2021 19:08:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94686EA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 19:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCetnKDtuD9VxBPQ8WmPNjoDjcCWUrzmQ1eVvdG2rIeqDSXhHfrAx43WuujL8xv0JU95E2Y2klDuZcr9CAjMfUFxKiU95uKDtkb7pt1cIY2EvQ0tnWkml7BhE+lnd4Qt2WIuGN9+WVfuLfEaTlGP+5WyAqhh5hbxBXijvF2ryC7x3Jl6eEa4LVC9WkkxKqq4C5Yf2aHXh6I1z9CDYbMSIN05UDCET85IswDhzeZaGdt3iF6IjFogfDm/mwZFEIHIB2QNb5QqB1L/wBlKGSmVWZSfhRMaCdksh2jUDAtYZbntlh415cxctFn0yhWdQvDPT8q+xT6sBhhI4tZjbTrVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLStCQW8UXZoOHWdlhNXMh66JjJpjVcnyVSKsN4oco=;
 b=IZsXqZmhb+TMLUfpGP9Ec5jHMDjkO4114clHK07mJ6WoF/4Upvden2gj8JOpUn8M6mtC0Mrv/VFhE/vqNgW0HaY51qLBVdPakmzwZm4CiIVRu03jX1bcx6bcwHuvmVLx/0nJDrx4PpxSe4eyfwWJg2mPfSNmlxCmEprsv+S2PLb1+SK/2NkCMBaG4I6vrYH1CJEYmVCrczfkd1VP43MZTLmlK4LxQGSyT3sZsZvmEtRgvDKTKtfR6ER5SgY/hIEjYznL3VG0ObIULoYc3EHoXA93cVeHKxoF390kufGmS1SeMo7nTcbZvxrvwfVogvRmZklaKDK2zz91uZC7mVwfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLStCQW8UXZoOHWdlhNXMh66JjJpjVcnyVSKsN4oco=;
 b=XVy5VvXGeb8BaBxddLCOcJFje40FGry1cpr7KuPNDKJf3ySoZatb8D2RvQpHXnX5bvXYPHKms19qeRnpALFHHN13dcviTEtNPgl7bvGOFWq3nvhIZQTjpEcao2OX44mm3u5lPCN8HtG/i+3Na8oSj3u6+9PnaM8qSE/4PKjGv7A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 19:08:36 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 19:08:36 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: fix amdgpu_res_first()
Date: Fri, 19 Mar 2021 20:08:23 +0100
Message-Id: <20210319190823.42905-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [93.229.58.99]
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.58.99) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.15 via Frontend Transport; Fri, 19 Mar 2021 19:08:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e73b9601-7165-46b4-b0d5-08d8eb0a6589
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1237E22143B6DE6A9D7847C18B689@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHlPRjFGp+jS0DFUU+xmqBOt1W0eKnrFTjAVbW1xJm364Zr6hHNp09Z6yvLv/01AtQbYnxaVfGacpH2bYReFJe53OW9efJ3+oCzei2TBO8HLXKh8FggomQJPHPPcDeg582+ZQTx+ZYVL4neY8ahM5GN7W/7ARFpH0r9C82oDKdBwE7PMcRi4HiaZX5NWdl39pnmJvjjgEJjGxHzl6rIRplTcjN2b+9BfvKvIbYsH4CZ7TCH7EZf/8gwdzdMuXlBHKoV2l4jgCuWi2gir5sLjNJFjKfweJqNo9spgGl7FqPYecc+frRvtg7do6VugtH/n+NV91qlydU9nsDzZFqtqxZY5FJUWaUIds5Huzaxhrhx3qvT6TiVOf1yWcPv8Bpl3ev+oGiTS+rnQ/vLVWOK1WwyU2ybezx7DTwfz3N116BkzWYAjFNs2A3jAi2fZBJfo6JFQdrkeJ09LRYlJMyl5dqB1tE4LE7FPMoAEOXLCyciPLkGAilNex/ko4FIjzDgkXlPGRhOHZMBxrKl0QFP8765tbu1pKKO8Fevfnmn/kGllNRyrpKYkF7A/9gNKPwedG9EToi7MP2/ybsEVp49PW/jUrlPh+VjXAQYmE0ImLyuR0O8RBkLmjz7EM8EdQ+H9/pj2FTIALY+cQCph631IGt68MXvEO0vwzHBMMW0Wx6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(6512007)(8936002)(8676002)(4744005)(52116002)(186003)(36756003)(6506007)(6636002)(5660300002)(66556008)(478600001)(2906002)(1076003)(86362001)(38100700001)(66476007)(66946007)(316002)(83380400001)(26005)(16526019)(6666004)(4326008)(44832011)(2616005)(956004)(6486002)(37006003)(34206002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TDK18193UW1VNB/WmuUpmpG2Zlei04rIcRxtmWrjgGSSWnJn7Vdkv7033t5C?=
 =?us-ascii?Q?xJdK6BJgZqCUuMX6nxGktmjOBpmCOS796ByUiwKunKMNwS731/ROZ/Ctgawb?=
 =?us-ascii?Q?C8MB8XYTAK+KTTGE1rGlwtGcun6QBV+RMdrHa+Pd6saC82NDpcawpbi25YrQ?=
 =?us-ascii?Q?vxYuhSM5ax7VPlh4YUY7vtzbTb39LG7kRYv10cosGCAoGIFwg7sICJ0/CkxA?=
 =?us-ascii?Q?NcinqvOOp8kgaXFf+GqsXUHByrqv9J1Mm17jFfnBrD0fUoai5Aw4FMAn2mf5?=
 =?us-ascii?Q?i1GnXQXv7MDfpdtlyfofBgG2a+WdqDxl0zMnWE80IV3rLZLJz0u01Z35l0ml?=
 =?us-ascii?Q?1D0fdQfecM07Yh37/WPcqqwRtos9WW+7PzSi6pvawqOn5tqweteZ8hOFA9m4?=
 =?us-ascii?Q?r5D43tAF+3+zUtKA96rzAU+d7aj3JQwt5+sM3Ouu4hJjpKxzCnFRK7QqLTra?=
 =?us-ascii?Q?OTXiNOUEKLk8p5EFZx3VvJQdkS8OrjQQDWwosL6xawHuf1hqhoafrxWKl75+?=
 =?us-ascii?Q?SDrulMlBM89TNt1KURDgtLvVBlVbYZM422M/EPfeoPkbYLEtOkmM5f6cR38+?=
 =?us-ascii?Q?agX2nqXM3ASy8gRkADaoNdu4nDDI58Fnlj/SX6AJhSEFxZAMed0uyhZ1QtLn?=
 =?us-ascii?Q?TKLL2XOx0zZXmT/ruI1VHh8dW6a2s7IyDpMkaUIulrBdUQTHY2e54DDpmeeT?=
 =?us-ascii?Q?zwGBWY2LJ8+aadAxfAxYAPIzG47umpHCCgvfdgZAxKNLVs9isYWWAxrDgmaT?=
 =?us-ascii?Q?hz3r6VyDlfTUJvTYPjX+ga9O6XXcdhKWXUaRWSgTM7pEmBFAiuy4WDDlAEnD?=
 =?us-ascii?Q?pGq+fvO7Tc/MLe76Od+fOY2pxEoZXLSoIw2eQdT9ZIPnlVtlkwV2l4Ms7Oft?=
 =?us-ascii?Q?e7wGiHi5364iMaoAJu3EytitRm2qn0H8TQq7eHK8jy5gMFBRcNGKJIan2mRr?=
 =?us-ascii?Q?hoTfSui9tPk2Op6CITcno6tOL1rZFmQsU5emxwtq07n5U1WV7VtlhzWKWaZR?=
 =?us-ascii?Q?v2e9MV4AOjMvpiBxHYXw7FiVJHfIUfjMGpbkUMY0Xgi9Vag/ynNxxLQ4CCOK?=
 =?us-ascii?Q?6V0wzsS2jbT8t+fyBcS99qS1QQ5wUNcX3H1n6ScozpwlvYFdH/V2AOsdoceN?=
 =?us-ascii?Q?+ayhXEo1DB2MB04TY3k0DWBhQ/c8Zkac5DiHeF5yvGPK5f1f80ev+4AdoPnA?=
 =?us-ascii?Q?H0YoXOI9DZk2M9T0xWTF+6lxua1CGELSBzRFux3Kv5OVUoZCnD2Ci4BzhFkl?=
 =?us-ascii?Q?/biq14vBMxk5nxe+ZwAU7hn4CSHHnP1m5mDzfNDerBu2Kwf6dTfaDyR/xTlL?=
 =?us-ascii?Q?9FVOJfwG6hJP7KH4XBbu+OHO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73b9601-7165-46b4-b0d5-08d8eb0a6589
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:08:36.1856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BN9MzV4GHwipCw9nucgc8CweL1ofR04O/Cwsy2WP7R60Sd9V+3sCWslEGYTA4gOQEGkEqluTiPQXlf2OFD1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix size comparison in the resource cursor.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index b49a61d07d60..40f2adf305bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -64,7 +64,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 	BUG_ON(start + size > res->num_pages << PAGE_SHIFT);
 
 	node = res->mm_node;
-	while (start > node->size << PAGE_SHIFT)
+	while (start >= node->size << PAGE_SHIFT)
 		start -= node++->size << PAGE_SHIFT;
 
 	cur->start = (node->start << PAGE_SHIFT) + start;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

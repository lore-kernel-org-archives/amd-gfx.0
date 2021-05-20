Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87DC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 15:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A953610A8
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 15:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A953610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F446F4A9;
	Thu, 20 May 2021 15:56:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECAF6F4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 15:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZAc8CeC3Qyqr71FjnrgnYiaiAQk3b3q6Yf4SJ11ONmtAYg0H3CjrEHm0zwensI9fv1/B9MHRp/BtG/+ZdUQI6j6bWp3SqCSUI/jpc2or/Y++LzaTyYcLrUPIhrRTZRh+q9cec3ZVgkETJzUeUixBZcFyT+kgw6yGX29xoBek5YM2Kyk80LEuFh6BNIoa5vteBnlg/rPK2IX8flbM6wayIXu/xhNf0sm8jcyCqvVrwSFCuXI2qn09bO376wWSQ/REeeK2ijTDlFgHbwuLQqdwHLV5EBsgdjiv3Mja3waifOLYlWs64gdD+zdtnVWiV4dJ177A5/aYnb8EZ6tCsfCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj5rWLbucm6tsNchERgMXocNyIsCtJUoI0ES9pAh17k=;
 b=HmUZPz3AgwS6Kkq1mo0ZRMeGvimD28Ot+7UuLS0sGTpWLQhw6WvqhtSc4Ed6Mzp19c70QIZjVFO6K2f3hwxkjVTvlLbMWFiDmM9ZGIsBiI0sTWcDhk5xu4h2u92FqK2ntGYuP6NLKAgCy5OhVrIGq3U2YUpvRDBpfS2E5WJaCNQU7gBgGW5IiuySawZdlmVdYqXqJtqrECTE0lSl57gq+5sd5HCFY3tR2p+qU+phuUII546aDRwzkWBihKpwWxTrgHxvu2En3uHfF9zN+ytOcuhRuN9wdl/T/sxjPWhmayQwxNZAoRKwIuvvAhnYYH03yCPUFNl7Kr3qwhxQiT1Mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj5rWLbucm6tsNchERgMXocNyIsCtJUoI0ES9pAh17k=;
 b=a1qzwYXTx3CcXPQUII6gb1lWil3KpkMMovIclHs4e2i9czFu4lP3pMxDC+Q/lu5hdtObXGl5jL8FlMvBXN6ttCcWtaR80MYpInzLWYCRMOCDDK0F5KkBrYnb1l7kiA63XFSoe+7tEX4eYuR85V3MdFmIx7ZCSZjkdqkOQ4J1UII=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 15:56:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 15:56:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/apci: switch ATIF/ATCS probe order
Date: Thu, 20 May 2021 11:56:14 -0400
Message-Id: <20210520155614.309986-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520155614.309986-1-alexander.deucher@amd.com>
References: <20210520155614.309986-1-alexander.deucher@amd.com>
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 BL1PR13CA0061.namprd13.prod.outlook.com (2603:10b6:208:2b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.12 via Frontend Transport; Thu, 20 May 2021 15:56:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de9b0e3-3f9c-4d4f-620e-08d91ba7d565
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3759586125064EA1AEA6ADFBF72A9@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAKEeqaZ0gZh7ZeYRIed/wj1/6vzo9DW+5aEDe609xqCyFia85ueOP4dedQkzB7Zf0sjTkrF5ugbhx/Pu7H8TSS1FUvoY/Px4ItfRQ6ohLBnwpvb0KzJbMatW8Pu0B1YfFZ7x5pso+RNdy1OqArN08YuKj6IyUDpjUP0nvE7nocwSpT696CDcdsmmH6dUGbXG1CS/+WJicpljGjUx6pkC/wTCV7kTVM3QJ5xCHAxpA4URNCqAbSnv9GrK/ROzd1mCXxnU0sJrSHj0v1C6gSenZDlfZtiVbeo+Ai/UhYuI6BlY/DGJR1yc3kiLCmldaib6R8bjnnWtOhMpzDI2d74rv0aYsI7hbRNhDnVB1M+eF1wXiobl1pUUrTT4Fqkcatnoqx/pFR83+Jgj/hjcGM3fIQwjGILqX3rZDIEw3Ns2Abp9UKgjF963o5tRfbZhNjKcpyrSj+R7YMqE3XEeWsU/IiCNT/RzNUKSqNNApuSN/MkoHearyFjmcEuXLME0tb77IYnHlH0Z7iSjakmejR50CKH+UvKVbDNGHlU846S4RvUBc+0HxAzpMxw/t4a9vouzmwV8tOwDY147Knj8fDrG482o9jJSmFQIU1PGfTaaYsZTbDQ3h7cfz7KTK2uV91FZpOQkHKG28asx8uP5icblEAqOqX6zBYBy95JALxHyMCcadvdodJCGByOmQJ2O9sv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(2906002)(316002)(83380400001)(52116002)(38100700002)(6506007)(38350700002)(36756003)(66946007)(956004)(86362001)(2616005)(6512007)(26005)(66556008)(66476007)(6916009)(16526019)(186003)(4326008)(6666004)(478600001)(5660300002)(8676002)(8936002)(6486002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7rISogEVbusPEjNmdvvpfQ3Qyp1C/iqqHB7GNhrlngyg+RQkCuGzN9Jf7Sm3?=
 =?us-ascii?Q?RucvHhHEuAiASQlWvwqeeyTNS2ezFZdHkzdGhGBGKTigtNxulTcmDRexKUSr?=
 =?us-ascii?Q?31S9cbIGnwzZPS/F71oS9qQXt4EIk/zzyUYXViesIgWxRUtjKJffWiS1un0f?=
 =?us-ascii?Q?CwOnS35kdecvabur4wXFV6iM4Gz+6m3XD91QKcn3Oi8piL+Ru4Xjfm8mDR2j?=
 =?us-ascii?Q?qXiNpxgirinF9EzTFfJgcbpLBqm3SfuHJ6budoGKZ0muawIdAQW0X/JHpPVM?=
 =?us-ascii?Q?2JHQIR/G1JQlptU2Os/8z39xRIevg7aDShWye4Y/61BFV6gvTeTTriItuwo7?=
 =?us-ascii?Q?Nn3OlQvB9JBwlr17Z4WOqDbp2yrgdTahrEMwSaLV21wOJhBbACMXXR4lCdeL?=
 =?us-ascii?Q?iwlpDv2u9T3pQBg5DUGa1LHFDmG9l1EvdOnF/b+hWGCxzv3MHkjXkyV2S+oX?=
 =?us-ascii?Q?kSAA6LBo+QnKg1N5g/dAglv3DqrQZ+HyE3IM6EqsOzTVlaKPZGshCXo4i80d?=
 =?us-ascii?Q?VuG41RDf7J2x2E9a6cK4MKGdge99du1SMQMBWVW9A4+/jIT49o8q8gEBsHiw?=
 =?us-ascii?Q?1X77qdeXOmebJFE97tFOhEsiToRwKef9HHNpEhamFNaYxzixfDGcq/HznUq5?=
 =?us-ascii?Q?A8DikoFUbkYTRnItG89+3+HjN7NYjvv5vDbxsBDa6MHm1ZHY6bf+BKlzfvg/?=
 =?us-ascii?Q?ztDwtUW/0Ht9alnkG/0wZzhNW8dMdiq719OTSdxdLJv15eE2TrNXZLsSjMmd?=
 =?us-ascii?Q?jVaRyFyEJx02ymOjlBIGY0auZvS66qUhp5WpDX8M1bRa1uARsDLAsnM2Ppi9?=
 =?us-ascii?Q?+lBYws2d2QJhCqJA2l6fn7Os0cFGPSAHvVjWvsu7xCTXK0Ea5kuYW9+0GEds?=
 =?us-ascii?Q?0bKQwbKMqvNICBuZ5DBx4N0VSW9VmmcmUPDmom7BR7nUh8jaUQWK6iWWvePx?=
 =?us-ascii?Q?oCKTZAmanc/W1Yo/5lKRIVpiRVSC6R1ppx3pp9YttBmZXmJPVDrR9/601APX?=
 =?us-ascii?Q?ajvhlTJOW5Fuw6khZ1KjTB0DE8oDvIuipaCpvVshyYdLoMnhqEw9Vvfh6zoW?=
 =?us-ascii?Q?Q67zCAVItPGJAIVNKEdONl7gC03Uh49iK5Hv/3YD26JJeVcpbb4I0uFqrcsB?=
 =?us-ascii?Q?XfAUWETN/rn1/Z8dyky/0qFwYuXmF1Tmy0bMkPuqCCWhYDM6lcfJHeYDUSDT?=
 =?us-ascii?Q?i6ZwgQjSTWYn6g16NCgNwxDbUyv7pXNfC8QczJiQuNJT8lhZ2UOQ5Z5SyR3U?=
 =?us-ascii?Q?DZMovYwe4ZSEi4vOU7/b8Y7guID+23gWfc/4xubo1dtBnMvAMsMejql2jDsB?=
 =?us-ascii?Q?30HDVNPMlyQ9W34FIb5IvWVW0hsnUhWHjzcMn1K5A4cE5Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de9b0e3-3f9c-4d4f-620e-08d91ba7d565
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:56:30.4560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VIWxfbojQDFE6ppl1asMAjyvnzA40Vm3a5w3R/z633JRWNP0+18pcBKMQPCGhD/WgPtEhebobm5AZOOmc0x7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Try the handle from ATPX first since this is the most
common case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 29708b5685ad..49563ff87f1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -231,16 +231,15 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
 	/* For PX/HG systems, ATIF and ATPX are in the iGPU's namespace, on dGPU only
 	 * systems, ATIF is in the dGPU's namespace.
 	 */
-	status = acpi_get_handle(dhandle, "ATIF", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
 	if (amdgpu_has_atpx()) {
 		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATIF",
 					 &handle);
 		if (ACPI_SUCCESS(status))
 			goto out;
 	}
+	status = acpi_get_handle(dhandle, "ATIF", &handle);
+	if (ACPI_SUCCESS(status))
+		goto out;
 
 	DRM_DEBUG_DRIVER("No ATIF handle found\n");
 	return NULL;
@@ -260,16 +259,15 @@ static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
 	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
 	 * systems, ATIF is in the dGPU's namespace.
 	 */
-	status = acpi_get_handle(dhandle, "ATCS", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
 	if (amdgpu_has_atpx()) {
 		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
 					 &handle);
 		if (ACPI_SUCCESS(status))
 			goto out;
 	}
+	status = acpi_get_handle(dhandle, "ATCS", &handle);
+	if (ACPI_SUCCESS(status))
+		goto out;
 
 	DRM_DEBUG_DRIVER("No ATCS handle found\n");
 	return NULL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

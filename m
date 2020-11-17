Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58484C6369E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99C624682
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iZEZVtKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C624682
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BE66E046;
	Tue, 17 Nov 2020 03:32:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3068F6E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 03:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn1894dnkXk+TSd74orOYQzkB53R/kbphH8uLK2cPKqVyewD+06P8sHt6RH7aVcrmQ3U/uzRuwYIaqENSDuFxtQwP4dPRvPlhmUH+0fL0vs8GgSHiiKC/0YX1pHPqsgU0pVL9aAw4SLgiS+TRzlp5cmJa9vbgJwOsS8bh+uasJgqmLbsGG7nESRF283pTJ/0VTLwYqtXoObz9xwPhrTT2wA3Qj+ZS8aEAkdXPgiuRw3a9xoUtbLNITLPFonGWmA1087owGMTMJF1QPukloYrYptn/K3dttPoHXEdZqfvRoHHn7fh0FGohb4YLKzyq0DvUhc/0GloumCAfjBrnW7ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB7VnpQIcBRkAi12ZrpZTr5Fcril5EuZGXEpeVWuaQQ=;
 b=e1+x3Je0ssUpC1AaV8ymbbA8w0+uUWfG/aMr13d1FIjNNJiEiW/2uPODGUNIz3zXr/ARL62gcngOtjSDwjizkq3bamNuLoZKBC3iGFydYW9WFhGXs1HdlsTTrdQ6m5it6C7dYqe9m5BDMHLSWhfdQBEj1QDsx4TjmOesnHciu6WtaqcQn+6PMNrnnpcOHjcSvNw4Shlh3fUN0rbBEcOZ7lU9CiSP7XdUeqKwHdNoZrPJGJeWHV6ys4jviv84nRdTQwK3cndMo9z0Hu8DKay1hagEHCa3COuUUivzRQ8taN9viRdEcB7SXFt2+wWWG0TVXp8Ps9kgCf/RxsvXgbnINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB7VnpQIcBRkAi12ZrpZTr5Fcril5EuZGXEpeVWuaQQ=;
 b=iZEZVtKdW0s2iqYPv8k2qfV53xh7XOzUMKIUyGfhC4867aWekhthDWDMSfLBuUOwB5O5cQHDIKfln88T0hOPN3CInms9sRSS9jxYElzyv0wkh1SUVx4bjfMYAy51cxMgODvP08jfnEy7zew2sr+gNq7W6RHm1drEpZPyaxxrduE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 03:32:06 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 03:32:06 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use of
 soft PTable
Date: Tue, 17 Nov 2020 11:31:52 +0800
Message-Id: <20201117033152.19568-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:202:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Tue, 17 Nov 2020 03:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 971b25e3-6869-4ed5-239b-08d88aa95af3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4901A23F1267CDDCB37631B0B0E20@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJYcLCb7mLDJrIFHClVYpm5qAwfP55unhuxwzgVF50Q55wf/5tGNDhRs7VbldjC8mg380mF2J4L432TrZfMew9d/an3L0y394X0PpNfb+jaWZtPHK0zSVAvFaWKe5FX19vHdsvAFoMjSxYMysQSxaoidYdinnbxscjN/H2AqpsadlWGznG6ACpsCJ3ZUvO7bJyUS+H8VL1lpAtT/FopOYxnBZsW2n+O/Xt5pkDv8/Z1Ncbp9AqWHQDHf8RrkQo+qNHET2+/r10EoMqlCzUZJ+X3W0zC8iqE37Y6JcxgLdyKDiTtqVUaFiMW/Ll78ECF3w2CJCNqaHcsvnaVW1F0N8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(478600001)(186003)(6486002)(7696005)(52116002)(16526019)(8936002)(26005)(86362001)(4326008)(36756003)(316002)(2906002)(8676002)(2616005)(956004)(66556008)(6666004)(1076003)(5660300002)(66946007)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: drGAE561iHgb+PLqnfCHUX5nKmXnvNPe8VgkOFouZ9R5CCqt3K6g2LlzczM3zpqcUmzLh8foNCieiMlVm7/NaNEdwpPU/5/e34JQQWckik+u5JaVPg5XMpoD+0F8oGd+RT0T84zBjrWUunBHEdPhrDJr38isPoNhOMwbVftqGnbZHILcoikiC2qxd8DaWNcHc2Gg61xDlZqged2qRrNB5hNsBT7AkZYOm4ZUxin59KHHoDI98ktbOIBVrflgRvA4LWPV3d5cYmvfhTPpYCePQGlRJC3Po+stZNR7qp3sKy0ZKKQvFg29PiH5u8az93ZdWOkAuqYYZVwV0IXI3NI9JGC4OlW8FJZhnuZkFD7y2OqxBgG6Krk3qoRPfJi3qy1HRslnOMvD6ni1KixrgS7Tr08uJMEa/r/mkOsAMY2wddDAMgOIAr9kZT9ujfNTWq/jVB7IsAw14Iy2OjPcnQBPrAYlTaXlAOr3JF9UkVN1tlg0qPNQcTOOP5gjAe2frxjJnFqU6NZr+FRWF1cBvVik2yeJMYNgcsUt7DDnxfvtpqarPiVprtf035wQrcETpO64koeI7LGHo19JJYI8670rH4fletgCnjqqcIG7UcZ6JCJJKj82G3nBmy2h8kvIntInASmH5mdJfc9MWCxxVSx5jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971b25e3-6869-4ed5-239b-08d88aa95af3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 03:32:05.8911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXJUfvgY2Id9BoS3VCKt2oXhFTUtupaxkyN7z5vq6xDYegzwo9Zsxq6D30KD7/Tv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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

The PPTable provided by VBIOS can be used.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b23311096467..d5fa0d9dd7eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -339,8 +339,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
-		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-		    adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
+		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
 			case 0:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

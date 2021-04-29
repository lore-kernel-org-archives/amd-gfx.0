Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5BBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 09:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B903600EF
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 09:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B903600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADCF6EDD5;
	Thu, 29 Apr 2021 09:35:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B996EDC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 09:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEtxHNhcwR1dm92cJJteOsBluDpL5Alj3elVBAWuOukJiXmatQWstD473tfKQJOqF8jHmioOg+I5Na1aphV7zhPrALVvEIC89sg0QM55+pHNxbxubrVU1Qagdprc7VbXy7dhCP2byzQ/8kFgVbKUCquuuIq8E9uEpf9chxcwgE4pak1Qry/LYwiiHY28N3p0OHE0HHoerOe+d4JLJOhhFplQKkAdR+Fd/JJnrUgsbLmZyfGmpFqoDg8UkSseZCJ/8Gg7Z2B81JKlYaHoAFK4L9J9uQj3lGN9rU2QpXuPKQUzkczRun9AZTAxFJUiibDbd8TNOeMnTDyd3Ou+PpXSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1vteDmlg4FqNdlXKK+CckBhVcBYJ7X5s+lKnJwtNMQ=;
 b=e/PYUpPlXBfErlR7JDtbuBGJAseN66GYxgcr+xeRBsx2yTZrMo8EK/1otpd0CZHsN+S2WnzrrhCmY35sQ3Mvn9QPBJ7hIJFV+/eRhurNauIf5GAqXg/nPq6Yj+wIZmklZOFgNwPkTAS0S4N7H9MKFdQXl8qdu4sQ8DCEf4CGB1vhblIAgtH/QDR5bpqlYhhWEIQXOu0VyH8c6DDSGnCiTKQRCyK8EtNmHWqaSqvA8Lw8dlSCJ0qZjLY26ZVpAYOFoBktpmZn7i92c17WACqiHpQsvvhEeu1UDXaD0jNH5Lar1R+LgPKLChD/P07On9mB5m50wIiMnwU037fyhiceGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1vteDmlg4FqNdlXKK+CckBhVcBYJ7X5s+lKnJwtNMQ=;
 b=H9M1NRw0EJV+sVl7+/Xn+YqDY/HrdEo7MOfahSfwJ6y2n9cNOXQxmqlQglIB/AY9cARFf1G0s7X2T+o25gdJ5j2QLmsPZlmIixRkvaITT6CHuKyv8XG34KmJxt+wvkX4VzdVuHrnQBavNW9q4TvIWx6fCH8WrMn701Z8Uo5KeKs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 29 Apr 2021 09:35:50 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 09:35:50 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: report the numa weight between host and device
 over xgmi
Date: Thu, 29 Apr 2021 05:34:27 -0400
Message-Id: <20210429093427.71281-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::9) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 09:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef82b66-4321-411c-8744-08d90af22c9e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1353637FC18C43628EF65C5A855F9@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhLZLC6W947g9YFaKl1h+eJ8uQGir4XRX4bnjxj6CYPYbO6Rve3Od0Z+aVc3PrBtXoDuVt3W9w2V0hAnTqBfm0T+f9Mm8nIRcBgiqmS9jXFcHCsuIYLL1l5P6MbYHBRnSSojvReApnh3z6PBlEnVK/d9wc3yu/iBsC0kBE7q4/rQx0+clDkfe7Rr8MCjAs+KCSuMlzY64gKZtYEAWqL4qRg9o5IhZ5P20IjCB1AcvSQEbkz7UOBFDQbCBKKrg8Iu8HMiX+oQnXr4/9hZTLwCWMLWAJHFTQXMaJKSkcXmZluOIfjW/DwkIqiZ8fkknSr9D/61HGosF1dK0s2jSLbQZfFMAnuaeo0hp//BGHi7IuPRuFDUClPF9a7qF5bsB48F+/TbJ8QjvmmB/Uxw6Qhbz3FUO+L6wyc5uO22OxybSB8RhL+FagVzQm+7NLHZ8A5BPbxQvfgi5rZ9asoCnehbI8hDI2aISdgRfCHVGfKaV+Y72CFXPy5CmciMWMe0qUiPXW+cz7KApplPb4XRpP6Weh+UjWOpZixbozA4swkywu4UL/xIMEEoVPugdvZK15TFjiVkbdIK3micVTw9Zb7WIrSFqCylbYswTtX1FXELiKnKA4SQVY0BXWIt8er62DqdO7R5k8R9e7T8SMJfcqyB09VUB2rQETpFJ2JypzSuG8U9iZ/GGxKALNEXwY7E5iUiKfE6iurrSPYt4q+8hDNPgZI97xQmlXPvDF/Wex0ExdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39830400003)(376002)(346002)(136003)(6486002)(1076003)(8936002)(16526019)(508600001)(4744005)(7696005)(186003)(5660300002)(2906002)(8676002)(4326008)(86362001)(34490700003)(66476007)(52116002)(26005)(38100700002)(66556008)(66946007)(38350700002)(6916009)(2616005)(36756003)(6666004)(44832011)(956004)(16393002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5MsI+uXzp6TwoE9a2t7CU78fZdR+B/pwUNsn7rLRaP8Wcg4F140K6bJwS7ft?=
 =?us-ascii?Q?L5pXA0pFaZLjYDFEa+Zf7zsGH135xrp+ulbh2hnf4sHDV01hl1Lf1HhOIlQe?=
 =?us-ascii?Q?tSEs193cshk407YEr7MzajSKFSuZx1hNHr9MEq76ikzJoVN/iBuFr540B3EH?=
 =?us-ascii?Q?cMd4nAbEi5ljxOcwn/GodyK760fq/rDXSGRIOH9HOSmVYFzX+abdy6Xc+SGC?=
 =?us-ascii?Q?VllafkVCTX1uipfmYvHM+uJI9H21cU5zMQVO53hs6pl8hC0kxZwAvO7ra6Oe?=
 =?us-ascii?Q?MI7GKgaHpW5wlNXY3PV+ulIdj+qI//KJ+gHrzPfv7tnwrCVKHgJmvjKnm88V?=
 =?us-ascii?Q?QwWM/IJ/ZS905/N2OEfgU/gMkDdJNPcqWQzaBNHkMrGasoXln5YuI4kfcih3?=
 =?us-ascii?Q?dljMBRG4pipA6JZCqgLtZgLwIedKIPwi4Pz0ELV7qoyMZFPBfN/rlby+u6ih?=
 =?us-ascii?Q?AiOH9YiBCv1yN4AucvkAgsnlWxJTcpUGGzUm4OuCO4gYXyp7sVZ1AbVVpXai?=
 =?us-ascii?Q?ab5GDFqDviEi5S1imBshn8Ud53mk0vZYXGHMRyjgcEcIisR7YjhvvkZUX6f9?=
 =?us-ascii?Q?a4lLNPcN0UufQf752UXHnn2Dh8s3Ku5voi862Dl3sm7Bzr9hmweQzaGRhmVl?=
 =?us-ascii?Q?RadiBXvyjJkC4dcqtL8zHkXts9gN6pCI2v+FLIsLCfizhc8lKAgv6xhI0sMp?=
 =?us-ascii?Q?a1ZQM/cfGoBquomz3O7CnCZmCWNEoZRXtavrgYuzkyRKeyqgXyxV9dhtLTnd?=
 =?us-ascii?Q?1smIs2v2R2OgqXYsOeL7ofGy7bmLNI805k9nKpL2d+YHe3GqyCsBPRuQKvax?=
 =?us-ascii?Q?Fwp7wZLWbCZJ99T2xG9PsFxZtHrRy9nuFsBIvVXiBX+8hNanQdXCXBLl/BgR?=
 =?us-ascii?Q?4quiw219fuSoBX13u3UN5Hv8weJWWPW3rtdkZsIISv28QgctLYY7ceCb8dFr?=
 =?us-ascii?Q?CIgIsyy5zO2WN/43qAVRD4kOZwAC4LAJ02QfOLsFRFF9yvon2F0epMEcS0hb?=
 =?us-ascii?Q?FCuNKsSdh1frdRBmPyK3DMLLEzmz1OtxkLexhCPzi5PyIWYDGLGzXVYig0u9?=
 =?us-ascii?Q?VCZvASeDOADuwmLsuS2ShRvcl9IgKuE/flVE2KqBM9+LgoChM6KwwVJYA6Qj?=
 =?us-ascii?Q?VJ4JWBNJzXvDLh5fzgys7qa/+dQWnfyYZ0Ya8ZGAzSMDUcjXQIVDgaw6lILc?=
 =?us-ascii?Q?61Ob7mpzXsYdpfwXm3MEKm5DlCUtsc8SOEmEXwI1AJYYVJKOoNFnmLRsQrqf?=
 =?us-ascii?Q?BSRWwgWywU89zx6Now3hUv281dNfx0Uk4p+l6mlbbnVL7tgxF5D67pWhCzS/?=
 =?us-ascii?Q?9/MmxlGmiTrDR0jHD426T7IW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef82b66-4321-411c-8744-08d90af22c9e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 09:35:49.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8KffLoVA1fMaHU4HXG92Zdp7kfqiiyZ3Cuxd4/3atebMxhuc7DLz579eqaov5SE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: Oak.Zeng@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Ramesh.Errabolu@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPUs connected to CPUs over xGMI are bidirectional so set weight by a
single hop both ways.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Ramesh Errabolu <ramesh.errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index eb30324393a8..ca90b710d76a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1789,6 +1789,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		 */
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
+		sub_type_hdr->num_hops_xgmi = 1;
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

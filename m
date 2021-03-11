Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7285C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 18:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5855C64FEF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 18:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855C64FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD3A6E489;
	Thu, 11 Mar 2021 18:00:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710D36E489
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 18:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5bKWIWOg1BnM4RZY/8tCaVZe9Y2t4IgVa8jIVf5Tm0kLxZU0x0uBBrSbCjg/71XtXz2Wh0Y/qlpfNFH55vpZecnW8cIyvbCGnjWSv3AyYFObT9XlFfWQkRG/4/Nd+nRr4PW+m5vke0lH8cNMX+ryEdg9e/T7ipRgbIe6SbKfHta6cnE951isZRjqUB0WPCkxpUmTzsqSDlHkDBCI0AgXEVu68K0ZaIOAo1yutAarEAzUR6Sszic/JLp0+xaXvLy+qr+bU8hrWZt8p/xyp9AAEUVxmoYULH49D1WaQLMJ5mPlivm0yQUmVSNSa3g883dvjW5VCi2mdlUTAqb2oEUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhsXbUEObJio+3ropIXVDVNt/umlGfHhfJ7ge+lLNiM=;
 b=RAZ3e32nhN9qWFvnbq+jjeFwiDHBP20AtobwfVinTfI3KNwZK5Vj/+xZffZ3sZ1E12OogKDzEam/PxnAtyh3tE2tCoroAFUBjN0kcR2/TYSUB4ooNcDoDYpp3N8680eE7wDgBBvBtNCKD2eZAqntDM6hQ3v/m6fzaQBHmJSrsLtl+uDYus8OZulLlEHY2JuUWx9kvnlw1awqBzNVSpr3W8O0dm2Cns2By5O9Vg9VCvBLHNEul6oDU6f2/CRTUSQuuVbPGY4L+UXfKuw/K46lliDR4TccCFkUhGdEYOoaVmTGOtDqUXXW8JAkWzrNBvV7Uxc+a3HOYG+ubYZTqvYn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhsXbUEObJio+3ropIXVDVNt/umlGfHhfJ7ge+lLNiM=;
 b=dRAvhbIUnkvD3he2xwH8DIhJrOefzNKzjh8aujYx2w6msFTusilwhVDqemvnnFrqFJX2ucuuPHGEMv7MM+V/N2LeUfJJcQLz92VUd6j9WhkzFQ+7Kvh9bG00aku5ClUQCl4vhCqYEOzg4k9S4YdTyOg4SE+t4LKJTkEGFSNzz3A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12)
 by BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 18:00:50 +0000
Received: from BY5PR12MB4903.namprd12.prod.outlook.com
 ([fe80::d1dd:413c:9c5a:f59b]) by BY5PR12MB4903.namprd12.prod.outlook.com
 ([fe80::d1dd:413c:9c5a:f59b%6]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 18:00:50 +0000
From: Victor Lu <victorchengchi.lu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Free local data after use
Date: Thu, 11 Mar 2021 13:00:20 -0500
Message-Id: <20210311180020.1103668-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:408:e4::22) To BY5PR12MB4903.namprd12.prod.outlook.com
 (2603:10b6:a03:1d6::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 18:00:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83eb466f-9938-4414-2781-08d8e4b79a62
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39538E1DF1A2682764A09860FA909@BY5PR12MB3953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju6C/URH5ISNBgbrqOXEjDmB+QDiAr1Mzn5MpHGw2gZUUa9soXSEwLwU+sncXFpJvIzRbw0HQN9dgn5A9AihPz2u6Bhc3fngpEUm89PLFO8EEfZ970fCyJm1h5oOi+i+PMbYrfdA/TjOfpJFe9Nux36z/ekA+fJqj+6LmNgdFDZQSBp60lr5LFECI7oict4EBIxOieTlP1ZOw8WCkIqcI30gbONLMPbkPW+FihAh9qM34l+tvZ1RkXbCrm8UWx4vzQC0CEdWvyiX7LutBEZY1Rey9r1UHKziOzWriipagAjuv51Wlj4yR3T53PnMvGs0lgAvfJY0bOUDH3ecVZF85/T2GzpJrPnbX6cCmFqvazOSQh0Y9lV+hTX9iMFnQMnTx8zWKmlUqwqo7peio3mnvkZswShuCWu2R3yxHEDFLZExTZlDgGp6vOhOJ0V5etLNAUXZeTu1z1JcaUYmu3EEMQEFQ5UyCSKHXkg4DS29rKCjOfvUZsO8/8oHbNo7yPbqIG5Ezu044aEeinOsjSgOAB03/CRzaetsiNOKKvitCbFRFQPcuxKuy72AhfbphV6wLb+RS3Xzc4b/upFavFs8ZHRSJcs+qPQ1FQ7Bgix0HZJ20/cbiEdZX2LqiAKoIQYxqbOkmFatcpeFzEdrp50qgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4903.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(5660300002)(66946007)(66556008)(4326008)(66476007)(8936002)(6486002)(6506007)(52116002)(6666004)(1076003)(86362001)(8676002)(69590400012)(6916009)(26005)(16526019)(478600001)(36756003)(186003)(2616005)(956004)(6512007)(316002)(2906002)(505234006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jfNRVSXTTP/hjlMhUBI627N8+izD8txsC4RGQau3RZ+T/igju/9wuuJXxrKS?=
 =?us-ascii?Q?1DLuPrGqogQiIb2zK7ZUoWPcFDbYvQ/6MBJojikmFFX83Mu94Fngzjb4TCu+?=
 =?us-ascii?Q?p8zKbQx3tUMQU+jEKNdzf2NtqBwd9mWC/k9fhj7SB6SgoJN8Ivtsl5QhjSEH?=
 =?us-ascii?Q?ginD5CXrGDsiLMozj1xKx1DFZg5Tzr0MNYmGyTUtZfxF3qKdMzuHgbHzGRDk?=
 =?us-ascii?Q?jWYDN1V0Di+avXMnaRD9Z5gj3HlMDqAlGlA5vqgXZkTNmZYOeqdHSegSHvAo?=
 =?us-ascii?Q?CnJHYXyD8wtuBe1b9E5wGLXE8P8gzV7v2rFVCpv5UDKORADR4wG2SAOE+jMY?=
 =?us-ascii?Q?IhJpY0Zz+ao38F1m+QR4ZuQvjElzkz2XxCEnwA73t3VsFsVSJF7zrFlMVHY5?=
 =?us-ascii?Q?oTeqoHvaKmmxMXPob6Mx90DQKKPKbPaZOVcT0ld6LG6FUT6DATD3yQsG45Pe?=
 =?us-ascii?Q?bqNqT9VNGk/nDT4eO/FUZSsHYs8N5sDKZrxpC2EZoLULdpVaf837ST8EKkFv?=
 =?us-ascii?Q?U+Y1Sa6018Kfppx3UI8t2gFeGRwqLbACLiOcE/FLSZGZj4pwO3dlgSwzKdO6?=
 =?us-ascii?Q?GsrQ9pkgt6IF2ks9ar2k13Hs0GcdlaXx893vGfmI8tM29kKy8O3Xog733puN?=
 =?us-ascii?Q?LoHdAk6UUgD8lD3owoZui53CXkTl5YAlk8lGX6E3CtGOFII4VD2jN92UGJR2?=
 =?us-ascii?Q?tblyD8/wnFVLwkxJhROkhsbdaJUO+IGiPCGAp6Kq4LxTsJzcYrgmsftK2l4Y?=
 =?us-ascii?Q?sQ/3sx7wxX3zQ8YOkO43aQUo7YPK23Q+lvaJTQ0j3XT1qlHrBbDWNsRhLmqm?=
 =?us-ascii?Q?ZdbC6d90NhIPRFw2lSUkaBsV+kRqw/mL8VDNSvdZvWfwmdEhZgDqR7PN6Wfl?=
 =?us-ascii?Q?8VufDhr5xf+aWNUvnDPjVTIKwOeaTOsV0ONAoOM4XTeiHhvX5EmwMhh2K9Y+?=
 =?us-ascii?Q?qnloUb5MM+K88ntgUzBuMF7tbr8cjt5M2TgA5bWwVcoCx2fJdTERzUwU8ma/?=
 =?us-ascii?Q?IMhBm+g7j7vIxtUFOWhudxhvhgueh0/+U6CnTJfmgVU2A0wTM0jMP+Gv9/Ev?=
 =?us-ascii?Q?j+yBTG/45Tskd2aP1IURcDpnikdLhqjqYtWDt4UEvn3bPziqAidHU22m/Cg5?=
 =?us-ascii?Q?7yYLoQuw3gP5lGGlP0VwcQSb36j8jC7kFnylmKMI69XoWAcdiWeTw4zPW5le?=
 =?us-ascii?Q?YPG+D4Tf9b7r4DcZM9As2XGHMQXtlUqYKI8qyuUFJi4AWfuiqG5pP3IWjukN?=
 =?us-ascii?Q?ARBSyaRcNq7kLD6DjACa6P4DHi5GjNwHcSXGjFKzQ0W0T/Ewm8N3T+D5MlJW?=
 =?us-ascii?Q?zjCHVrE3xEA6MlItC9OF4V7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eb466f-9938-4414-2781-08d8e4b79a62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 18:00:49.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vks90JcBgr0aBOx9CObdcL281NCoGhi5PrPVF+3sKhG7IGolvxeHOb1Rqt1t/ehYh839xiLVH/hboPqY1syyrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3953
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
Cc: Alexander.Deucher@amd.com, Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following memory leak in dc_link_construct():

unreferenced object 0xffffa03e81471400 (size 1024):
comm "amd_module_load", pid 2486, jiffies 4294946026 (age 10.544s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
backtrace:
[<000000000bdf5c4a>] kmem_cache_alloc_trace+0x30a/0x4a0
[<00000000e7c59f0e>] link_create+0xce/0xac0 [amdgpu]
[<000000002fb6c072>] dc_create+0x370/0x720 [amdgpu]
[<000000000094d1f3>] amdgpu_dm_init+0x18e/0x17a0 [amdgpu]
[<00000000bec048fd>] dm_hw_init+0x12/0x20 [amdgpu]
[<00000000a2bb7cf6>] amdgpu_device_init+0x1463/0x1e60 [amdgpu]
[<0000000032d3bb13>] amdgpu_driver_load_kms+0x5b/0x330 [amdgpu]
[<00000000a27834f9>] amdgpu_pci_probe+0x192/0x280 [amdgpu]
[<00000000fec7d291>] local_pci_probe+0x47/0xa0
[<0000000055dbbfa7>] pci_device_probe+0xe3/0x180
[<00000000815da970>] really_probe+0x1c4/0x4e0
[<00000000b4b6974b>] driver_probe_device+0x62/0x150
[<000000000f9ecc61>] device_driver_attach+0x58/0x60
[<000000000f65c843>] __driver_attach+0xd6/0x150
[<000000002f5e3683>] bus_for_each_dev+0x6a/0xc0
[<00000000a1cfc897>] driver_attach+0x1e/0x20

Fixes: a8e30005b47a ("drm/amd/display/dc/core/dc_link: Move some local
data from the stack to the heap")
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9337e87a73e7..b60e0a4dc4bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1615,6 +1615,7 @@ static bool dc_link_construct(struct dc_link *link,
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
+	kfree(info);
 	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

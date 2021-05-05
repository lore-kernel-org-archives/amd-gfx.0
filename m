Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A7C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCBD6101C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCBD6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D9B6E4A1;
	Wed,  5 May 2021 13:51:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747436E4A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 13:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUN9KzBSfjfr3htu6UwnIUQ4RBKmFn5YHg6qhs4HTEIJYD8sB1s3jclE2XkZQ+J4TPRnFcqDuOw6FWZfYcxKuj+bbDd496SPh51xOBZHo6RMoq91+zeaFTUvWLS03vGqzfXh6v3opcv2NtjcEi+E7vNLXJ4PqTFDzMQgE33Erd+cpnf7nmkIDJHag/W9b4EwDTf5BwUjnjLwsdVjZCxhmASsVCxt8n16jJw3pFmCm6EaSibD+UPyexN3d4BOM8V5PxGUaca0kqu+RrixjSFPhd+rIpQivhxFP917HBxO9ls4LALl0IhQnOqs0bXdSxgWwD7JzhqfFA9Y/SmkbB8Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/7+Mi4KBm+x3WQ+4Sx8V+X5u7vRq0nIcMsEzZlZWno=;
 b=Jz870LAN1+RYEBzH0v5dbmUpECjqF0hoLyqEUW1jUFLH3diF6YxY+SBGg88QHrMzrXS6rQa9BviZkp8QBbNfS2LHjZVvBzrr0I7FUI+E23/UaI0eXQK3+aOU7r5FSb8mqQrMSLFMFYcQHQuomNKIbvghK1vJ+gSO3Na9Bp7+OmaY/BYRSPsSvq1RdkI0ND4cWDBJvgWoAGwLD1s5ZAMvmYe7CgyJ7sOhqLdCBL76Bck4ngVZ8hBz3KXrZmel+/5cO82Xt/rXEW0650CBXAZvGD0zFd5puMz6+QKgFIV3Y4I2veo+6/zMPknen0brhxEMUd13/EFUqdsrgrSDPknFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/7+Mi4KBm+x3WQ+4Sx8V+X5u7vRq0nIcMsEzZlZWno=;
 b=Eu5goqGgFPg7Ktm1Nwe43hpPkjD9+ZvT+IGF569LUhecMT3KPWUnIH+oB5aXE7Ok/SlVfjuRbFMy98QuWx8hkaITu3tvX+U/3HUSJQpB8ws3wvje9fCEZy3zbB9LrjXVm2qCHbEOZIe4CnbPqer4gX/TMGI67iAnJkA03w/+/ok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR12MB1946.namprd12.prod.outlook.com (2603:10b6:3:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Wed, 5 May
 2021 13:51:44 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 13:51:43 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Date: Wed,  5 May 2021 09:51:34 -0400
Message-Id: <20210505135134.8229-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Wed, 5 May 2021 13:51:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f55074b-8c54-4a97-5819-08d90fcceabc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1946:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1946C6EE268AA869724DECF282599@DM5PR12MB1946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1Fj3LD+HgwY7hs4oYtRHYE6wYhx/JihmRx6N7of/pACqWqFTOqH5pfa6Pf+/WIeKMEKsCjalVi3Zqf9xFa3+THvOBNrvH9aHaQn9EEelrFS/Evnw7Cw3YFJA9pkLaOcGIEJWyCUVtcyWL/UY0kNCsRrHlYuCy/Fn4LZV/awIwtRDjr6JpHESyXCgkISOthGi6SuMcsPHwARtME8i+CTfkmY3RGqcZCNRPhzMgySdkhPTfay7WXN2fsz84VL5SrM1iwyJOePhFNMbp0lgHRKMAYeKlETp2mPm3cjfFLxN0DZ2gj0YZsEwmbupzJvCE2KnOOvB3gtxfF+ji0pgZpR5a2m0I1hlXYcdH5FMcXIY9jQ/bVLe6eVddso2Xu+dKr8vwHQrR423VA8rgxT9oVDt57x6iLHX/s2ZclputLzRMRT5Xn6EeEmCErGPN6wPvqbC6JGpAOuRFDVZspXB00wVd85BQnJEs3i37giH9H+a/0IAijsEFGnvBpg9Zu7w56Gn/a5g48XVOgxws4C0xwm5dcZm6Xh0C1f1AkAZsdoBFNnhVrtNdrtlPvIJ4EQyPN2sinznd+rgZNSFFzvufalX27BqINKQyBb63QxYboElys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(66476007)(66556008)(4326008)(38100700002)(66946007)(316002)(2906002)(52116002)(478600001)(7696005)(8936002)(86362001)(6486002)(83380400001)(5660300002)(186003)(16526019)(2616005)(1076003)(6666004)(36756003)(6916009)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lQ3sR+t17mqfNF+u047heHd+rN4UiATsF1/y5z4+hEj+Cs+guNTsmTSK4PkI?=
 =?us-ascii?Q?RBuoSA5ZOHExaxWm/NuvY54QITF4j8VutIWktolOzAqVD6r2rdCSRI05bMdw?=
 =?us-ascii?Q?2ib8dwLllMsDjPpjk5/GDXcM7bShezvSaTgvhF5LFY5yx2/YNL52k7qVbeNU?=
 =?us-ascii?Q?zpjrog27fUg8hR0X+5PIC1ICnVqYXdIH6bbTyDeta8ESzN2gJnIuwyeVrmtl?=
 =?us-ascii?Q?Ffwv7Df/fsnk7pcDM9Tqkm0ZEB5Cm90UsiGzJztIbMnDeSRUGxQoHHZztKCI?=
 =?us-ascii?Q?61CyAdRNo8NNK8o4RQ5S4Z9N+6XGYGdmhDFsccXLnnqXnrxEUDiv0vmFyZQV?=
 =?us-ascii?Q?rqREaEhowKUizzkd4R9+UrFzemCX3WYknPXKPW/ijo0x4pkO0+oF4bzFyXJT?=
 =?us-ascii?Q?Emt4UpDOmyhFGnFPRmYlKTi4kPzspaonDbaskPdo1LGgaOPG1lO+RdVeHyLb?=
 =?us-ascii?Q?CXB8lNM7iy4A+GJnbG6ySUiZfSVOzLhGMYL82Q6dPsZSQdwanHm5DG7Pwe2Z?=
 =?us-ascii?Q?VT9/x5KmPQ/SDIm2IV3hbUubJHMdU/OnhzxNlU7eOx89BR1dgiA0ZmvU4wid?=
 =?us-ascii?Q?QwTHz9ah7qPhpDn3su5g9Sxj3CyaYYdMtImcXduhZJulAcW/vYxo8/mNhQC9?=
 =?us-ascii?Q?MRPLFETpjW3qKPqTdMDPUbLFSuI9T8E6c6H7HFn47/0iJGqYymK2dB4rgRVp?=
 =?us-ascii?Q?URrtKRKwA22XApuF1f2tOBq2x4gzZcQ+BRxuXtT8fgtFD5uTQMcMW9S3GzE3?=
 =?us-ascii?Q?JnAKDZFvghH33+ffEbORxLKHpeYWxJRzHalK4v3/eR5yJ9ZOksmaB2RpxRNY?=
 =?us-ascii?Q?ELz94A105L275OgG0+6YUhE+iWtPW2veFoks7WKGEPpMD9rwqzweqyjCK9VL?=
 =?us-ascii?Q?PKXSzxCaoH5aszlmeiCXji6ibm47QrFB/OaxM9s5ox6IUX11erZpKGA7JxZ/?=
 =?us-ascii?Q?ZmfxGbuEFfr8iTpe90/HZ1v83n9N2Ko+BFnA+tcWUjglj/1aisuRYAXqEbEq?=
 =?us-ascii?Q?VBO4sR73BIJdM6M3P1KPjFH8V9CSKQs9Mw0vMs1C26Hw/JmF9NkkqiOkDSyo?=
 =?us-ascii?Q?+dYbd/nMap2lpeR14WpryILTbUQwXxVnYfiDwfFFKd9qZjZp5vlwlNAroS25?=
 =?us-ascii?Q?y6k+Je2rx+YVWYvOJRq9Ls2xp8iIgL3oqr8sNpIs0d5X07VHNOlNtXxhiPDC?=
 =?us-ascii?Q?AhXNW/fj3Mfz7rwERydjhtBcsGHLUODT9+PqXj3UeVNIyhjXTPzBi/Pviq+1?=
 =?us-ascii?Q?i20E4cZHjkuuSdZvYcdC5UEclRP4YW73jcnBZDJSZOhvRCLR0vO0XNmITnEB?=
 =?us-ascii?Q?SyUfvElrpGfddX8Q3UVsXoj/HrbK4VsNAMI3jOeT9j8YG5wTIEeuBm56vzLa?=
 =?us-ascii?Q?yZQqLdla2ArAWsqYDZ0SkVVfGfgn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f55074b-8c54-4a97-5819-08d90fcceabc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 13:51:43.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIBAtv3bG1oyfg/s5qUgMabv0m8L9SkIVJTAuw0RV3HpoboqbspCywQ3bll4H6E/lnJGmFJF4ZTWby3mKNhAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1946
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In NPS4 BIOS we need to find the closest numa node when creating
topology io link between cpu and gpu, if PCI driver doesn't set
it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 38d45711675f..0972b1014d6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1759,6 +1759,92 @@ static int kfd_fill_gpu_memory_affinity(int *avail_size,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI_NUMA
+static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
+{
+	struct acpi_table_header *table_header = NULL;
+	struct acpi_subtable_header *sub_header = NULL;
+	unsigned long table_end, subtable_len;
+	u32 pci_id = pci_domain_nr(kdev->pdev->bus) << 16 |
+			pci_dev_id(kdev->pdev);
+	u32 bdf;
+	acpi_status status;
+	struct acpi_srat_cpu_affinity *cpu;
+	struct acpi_srat_generic_affinity *gpu;
+	int pxm = 0, max_pxm = 0;
+	int numa_node = NUMA_NO_NODE;
+	bool found = false;
+
+	/* Fetch the SRAT table from ACPI */
+	status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
+	if (status == AE_NOT_FOUND) {
+		pr_warn("SRAT table not found\n");
+		return;
+	} else if (ACPI_FAILURE(status)) {
+		const char *err = acpi_format_exception(status);
+		pr_err("SRAT table error: %s\n", err);
+		return;
+	}
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	/* Parse all entries looking for a match. */
+	sub_header = (struct acpi_subtable_header *)
+			((unsigned long)table_header +
+			sizeof(struct acpi_table_srat));
+	subtable_len = sub_header->length;
+
+	while (((unsigned long)sub_header) + subtable_len  < table_end) {
+		/*
+		 * If length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		if (subtable_len == 0) {
+			pr_err("SRAT invalid zero length\n");
+			break;
+		}
+
+		switch (sub_header->type) {
+		case ACPI_SRAT_TYPE_CPU_AFFINITY:
+			cpu = (struct acpi_srat_cpu_affinity *)sub_header;
+			pxm = *((u32 *)cpu->proximity_domain_hi) << 8 |
+					cpu->proximity_domain_lo;
+			if (pxm > max_pxm)
+				max_pxm = pxm;
+			break;
+		case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
+			gpu = (struct acpi_srat_generic_affinity *)sub_header;
+			bdf = *((u16 *)(&gpu->device_handle[0])) << 16 |
+					*((u16 *)(&gpu->device_handle[2]));
+			if (bdf == pci_id) {
+				found = true;
+				numa_node = pxm_to_node(gpu->proximity_domain);
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (found)
+			break;
+
+		sub_header = (struct acpi_subtable_header *)
+				((unsigned long)sub_header + subtable_len);
+		subtable_len = sub_header->length;
+	}
+
+	acpi_put_table(table_header);
+
+	/* Workaround bad cpu-gpu binding case */
+	if (found && (numa_node < 0 ||
+			numa_node > pxm_to_node(max_pxm)))
+		numa_node = 0;
+
+	if (numa_node != NUMA_NO_NODE)
+		set_dev_node(&kdev->pdev->dev, numa_node);
+}
+#endif
+
 /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
  * to its NUMA node
  *	@avail_size: Available size in the memory
@@ -1804,6 +1890,11 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	}
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
+
+#ifdef CONFIG_ACPI_NUMA
+	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
+		kfd_find_numa_node_in_srat(kdev);
+#endif
 #ifdef CONFIG_NUMA
 	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
 		sub_type_hdr->proximity_domain_to = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

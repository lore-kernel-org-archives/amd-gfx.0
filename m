Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9060C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601696101E
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 14:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601696101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D496E0ED;
	Mon,  3 May 2021 14:48:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B07E6E0ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 14:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP2tpR1QR0iHNNACUe6ULZCJ27yXAz7OncBcbdZerLvh1xiEvSao2xfICUdhdBCToUtQEUnCLpF8yTYS8h3u5/VQY8heW7dH3CZrVgjD5GL3oLOUL3AJr1D0zWbKF0yAGyXWqvU+eoNi+AQMMPNnRtY3r2UdxPzumCNPpfWI9wjmjr+UySghEefC7tv1dvROfU7JXej3prSYmAAWeho3io3xQgG3UZaJYXU20wwTyT5Cerb2egfQO7VUXUfQfpzJAv+nbELIFb1Jd5P4yiFPCinXXvPoWJm1KF+UnU+JRTJBosMT6lLxB9Dz4yrgHAPc2mjdyOJZ6n4wzX5yPWQDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YOqbn1xQ9KyStHMptcmOcw9geKKwzm/6mbYKY5hl7Y=;
 b=VaE+0lXTLLEGDiYjT9CBh5p6OwXTK6PY3COfOc/Z2ROZsna8UTBBnmigLeI1LDmEWgP7neWbVqgzOD7Rs++6XSMzojN8yB7406dzQMWfA0IlyMDk63rUN4W8Z1XG4US5Tx0VtAApyZUygKXRLuLumJcWoz8HRR6or9FaVzHdvhieqkJJJB6HVVk3I6igrjCMREDnpXYjkbNHPIJHzZT+P/Qyca2wCRymNU8UyMcJmS8/xyVXvuvfxKF4yy1zFfw33rQ0Kl+/3CcMJGGd92qM7EWgXEN48pTbDYlOUjvgMGI61DAp8SNjYgY/DBT8onRo1QoXMM9VSpsN109m94XeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YOqbn1xQ9KyStHMptcmOcw9geKKwzm/6mbYKY5hl7Y=;
 b=RnnF/rzQiP+x2iZ69bGHQX/zMmWD3moAbwpL2c/DrdkyepS7Th18GguAPoiaA2EoGLkUrSaz+mV+rOs1fP1FjiTNAYCHqe2JBhKNwlC/vw33ahmJbCdXG0VKm5XFNTlkCaz1dx7MElMETz4gEu2pYrREdW5yk5iS6OnyteD3K28=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR12MB2341.namprd12.prod.outlook.com (2603:10b6:4:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Mon, 3 May
 2021 14:48:15 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4087.041; Mon, 3 May 2021
 14:48:14 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Date: Mon,  3 May 2021 10:47:53 -0400
Message-Id: <20210503144753.9795-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.37 via Frontend Transport; Mon, 3 May 2021 14:48:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf003c7c-a7e7-4e9a-7550-08d90e427b1b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23414F46E4640421D0E68323825B9@DM5PR12MB2341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XxjGhuUAeX1L/42KlynK3APqwuE5pz8cdR+oh9oyanMw3cg1FNE/xn2CFSF4/660PxN6vYxdncpfBt0cvanQJ4VNRb9TKAPn2BKmi79l6TMJ9GuzpC3nisjsis0OpMVDC5C+Yt2ZH1O5FxtI17H2yOhrZYJsQKffamHOZY2CVYCf+jkDMGD6D4HnUtAaBtzAx621jkZblBCAFzX+CyCX5xQSxJY3yox6XfiQz3tWpEU+V0OfM6OeX1AA48FrvrmgSWIi48miK7rXU6KCroOqcyvmeTOnq63BciFAloU6LG9Qv/3ezvYTHQgbXnboTNmp5Fqv99rpu7hQQq3a3eZ++uzx5NWxyUWndADE+F1nXY5VqzZm/nfoBvPLOBjFGnmC3fnwpKsPv0iLNcjKmAA9TJ+XUUr2chDl6dLKZIgvtOv8Hyvj4IYcqkc78/KxQdEFDS3P41Y0dtSTwbSLvZfGINs7RrG78ILqMc+q4CjHylt64GfQIRkJ22uzR0+1BkgHIfWvbogzqOhDSE05++PjQJeNoe7W225aaAssXgC+cDLIH/GBNAJ7MPtxmN7D0fTYifLk+FBOuloGzIN9hrOyIklH8brU0wYfBJn0IRG2JY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(66946007)(2616005)(66556008)(478600001)(2906002)(7696005)(52116002)(8936002)(38100700002)(66476007)(6486002)(16526019)(186003)(6666004)(36756003)(5660300002)(83380400001)(8676002)(4326008)(86362001)(1076003)(6916009)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vBmmluk15DgIClLhZz6+Cdsgnx3LNMm/V77YI3sE/Q07r191uBLmkV6I7165?=
 =?us-ascii?Q?aPS0oFv8lWag76WlyRUEOd2oQ94ON+wcLhQeshSHIM7hd1tTUOoMq2KcJeyT?=
 =?us-ascii?Q?xVlqhAnrDmKw6ENuSrsB+1qXiUIPOjSHc+zO/bKFE7PmsNhA6VQ+JVMS0lVe?=
 =?us-ascii?Q?YrclXMeiYFEGpXfVAbVmtTVtUoYpbMagJSMY3PPK7Q80RvDcvwY+oyDxnVzX?=
 =?us-ascii?Q?9vaGVc76bqF2piHc82YoveaMDgflrGMpMktvNdVJJcsiDxOL1ZUkuzKRP+Gz?=
 =?us-ascii?Q?gfPy1tAAyXyGyKX4gzYGTcZN4/EuA6teGuXLDHNeX6ag3j4YhXCoR3V6jQZO?=
 =?us-ascii?Q?LXq66Y/nq1uQTmsSLQA9CzajJ01GE1ojE0UOf/JT+UlDulVKKCln8tmt0/Ip?=
 =?us-ascii?Q?s8tDeelfzigKGbe/m8UMZqdGQZ7B+PqSEwT8RFC+2yjoCO1u3UPVvK2YjbG6?=
 =?us-ascii?Q?hn6z4QKtiBQf0ShCirLhwPumfp4H7wq9kDyli7Du1vAQVvA09oXgYfDB8pUQ?=
 =?us-ascii?Q?zZK9aMw1dZzjMwQ/ysECu8PPooO4x1Rut7U4pCN5eFjaWqvg67IqEsh/n/BZ?=
 =?us-ascii?Q?5lhIVkGQZFkd8CHSLHh3XJcmWB1jDrbZIi7KzzwmLixUuP7PqMDbD6lyP5zc?=
 =?us-ascii?Q?EEVbAs4fDNuc2IsmfZB6RXSmW15LmxZCiA4toklWXguWUWAm20x3XY5gxQ3M?=
 =?us-ascii?Q?xogYxigJDxClSVsU8+z2SZEF2HN+A5q3p+pQMBXtUIhH+fs/VFxd8kp/UTqG?=
 =?us-ascii?Q?ARIhbMXgIlyAQ977tVWU90OFH+mXDd9UpDhCKMMdBkeGubsdJQ9AguAEHRHb?=
 =?us-ascii?Q?rJ8Rfwkq6hxEqSYB3MAXdEKfHtFre5+j0Dq79qsZynHVibsxWkmf68iNeMe6?=
 =?us-ascii?Q?O8re6PcsfC/mkup8J5u44IZhsBAAL+TiXaA7RfhZ+blFq6n+ISdLy+6hEhlU?=
 =?us-ascii?Q?5Dod0PIfObPc3l/RQl0+gNEe3b6Cju2hsaSTpQMrBh5TMBcwrTga2IISzMD9?=
 =?us-ascii?Q?3Jd13H7ppLAAtSIgpV7aP7nZPqbRp0eZZF4nUfnCNEeHa+sVElSwjNGvJZml?=
 =?us-ascii?Q?3g2EWPoGqmDoRt3A0wEmPM7RJgWmEqBkJJciqQdG09B4S0EybUiqzs33bkRN?=
 =?us-ascii?Q?KGvv9qAPnO1oQuneIC/2LoHX497vJkP/w6cc9glRfRsgsAsgaSNEElrIA6IA?=
 =?us-ascii?Q?tYXU3Jp0CsWiumlI9nWdz9ER+QC+9iqSpkAqoT555E18lrFpZPiWk2jH8KW8?=
 =?us-ascii?Q?rKjBslnvmcqQdV+w1vdD8Rm5qMIbMDDdfBInNPk07fiP+fGd0OnEfwWY2/AR?=
 =?us-ascii?Q?0WXGh1t00PIyNnh6RYLLfiZBz5UKOrRX58NNY/2vko4Y7nZHyzU6c0MvndXK?=
 =?us-ascii?Q?HYUO4NML+d90/QQBaRVXVy75Npun?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf003c7c-a7e7-4e9a-7550-08d90e427b1b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:48:14.8112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V6sXSFuGUiWSOwntA7rY+X+y6AFzjqRXkvi7wiuJOWld6dN3zgKh3XyTc3dLLv3Bzm1fJ8YD4DJnQZN94SUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2341
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
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 95 ++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 38d45711675f..58c6738de774 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1759,6 +1759,91 @@ static int kfd_fill_gpu_memory_affinity(int *avail_size,
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
+	if (found && (numa_node < 0 || numa_node > max_pxm))
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
@@ -1804,10 +1889,16 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	}
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
-#ifdef CONFIG_NUMA
+
+#ifdef CONFIG_ACPI_NUMA
 	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
+		kfd_find_numa_node_in_srat(kdev);
+#endif
+#ifdef CONFIG_NUMA
+	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) {
 		sub_type_hdr->proximity_domain_to = 0;
-	else
+		set_dev_node(&kdev->pdev->dev, 0);
+	} else
 		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;
 #else
 	sub_type_hdr->proximity_domain_to = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

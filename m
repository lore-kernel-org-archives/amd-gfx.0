Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6014AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 15:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE7B613F1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 15:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7B613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFA96EB59;
	Wed, 28 Apr 2021 15:12:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBA16E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 15:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXPWJRFJtEV5OqHp0Kx0I7gnu4CZZc1gwdFrSKO11EhOKF7xu96iRi9NG536Yty30rbwEZpB+oDvur3kAxhX34yeZDyt6Tm+Dbwdcq5W52Zsyf6q1m4o84+39x4NeFrP3t0e0r7cHWjJsb9YtKZ8gv4XAxUSgWeaMePtBwCsphut7SvLBBlOAgdUahlj4Jw4njLTSEZdFven+Ph33oi5mQGfiXgAWkzNDV6Cx3A9496opyoOBAYptzeFT7VK1dfH1wGy4+Ee6nGbWsDXKGuEgr1lxIqHoqEAokt331oWbRtTiE2MTvtelMUuUUfxBjm6d8DURuV+QqULaMw5LD/yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKkM14UHPs7ZPJjy9tQqfHADDRltobt428HyHGr+kKw=;
 b=UkcYRdwnAfqv9nCUMitd9EegbTN+5xOxGKeaUCtpGWOsRrL72ncJWs2SLn3iKmFm4hi8a8uciS9eeZbZrdTBIzJgt3+9H4FIVNQY/RZkSml/be7rYoDsOrsZEZEv0QHg1dmf9S1JhTtvMihZLDL3omw4qekiuJPw8L5hiZ7QBF9xnB6ymTFwcASjZRlF+FLJGowoVYJikE5HWodlnnZJ25JRMxhnwn1smaiywj/X12r2Nb7EaaxBLzXjkPYScJQWF2toAly84pJJRH2dyhxud1XWLQtmRMHa5TOd5JMLluDkSFaGkux5PN0IHm3SvzHvgfq9vcIT7rOVX3oMRiX7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKkM14UHPs7ZPJjy9tQqfHADDRltobt428HyHGr+kKw=;
 b=ptIGWJEkkGb/K3rd50OFX2+nZTY5Iw0t4EfcCWA4j9s5lLA72/NLR3TymbSdYGp6ppW4ywd+seHbgVnljBrrou9gazFfogZpARaW4LNyjLfhuJ7vrQVvnGJuNrDvX/CpPEayQlRQNxi+Sp7yP1i77EbNJPUHE5047uFE78LJaIU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR12MB1498.namprd12.prod.outlook.com (2603:10b6:4:f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Wed, 28 Apr 2021 15:12:14 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4065.026; Wed, 28 Apr 2021
 15:12:14 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Date: Wed, 28 Apr 2021 11:11:54 -0400
Message-Id: <20210428151154.28317-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::32) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YT1PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Wed, 28 Apr 2021 15:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9701a7bd-bf8c-4875-f40e-08d90a580153
X-MS-TrafficTypeDiagnostic: DM5PR12MB1498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14982B4F27CC4EB6388A83C082409@DM5PR12MB1498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A89s0VtUV/+TPr2IdNvDxqRufQDojwf49EYRnvlF+n9lLl3w/tD1DTgHJNArTJZ1dxqJv9cNv3GqwtZOuaF6rDaUlu8zhW8FwRCCMosENfm8IyLK01OpIxv2oQU+eRFllunJaZY9LmREydqXbmK/z2yby5Phl471R6/3C2yfHkGUqqbbn5qJbGZkNx/77onEpgdXARvb/P9cvr6yWeuJ64PBtBQ5bl6p79eiU4sUReHkPAm/R3WrLYoN/69G+XK+LtzWCYhwDEnhM74l1QBHDkz+r5/zZ5p2TRivi6KkTbiRB2EhTBG+eXYB4Em2Z/rOWVupYcN9ae7c7rDrfPhajMQlHFlWiabjicWaBvfSiX7NuKfxC10cfNRbSpitUfFQLzD7E7tOx9YPVFNvtuAYDTZJsB7Z8yRfDJv5gKgenu9QDrcE+a3sUdpk8U2bT0dBUlWaHnri8vWh1kTkAqV1VpL3ap2JXADu16ozkaqH+ucTiyLOLga8BCfoGGJLjkdDrvEcf02RtrSuGxyKK2quk5cEIPUfPh+JGIJ/8z/B9fOZd3x+zKT8sumzzs7fYwvTY+rixe59mgXSEdMaQJpQi2sr6gCaznl72Y18S8d+DqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(6486002)(8936002)(316002)(66946007)(1076003)(8676002)(4326008)(66476007)(5660300002)(66556008)(52116002)(36756003)(83380400001)(7696005)(38100700002)(2616005)(6666004)(186003)(6916009)(16526019)(86362001)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fuWog9KFHyee15NPKAjlIzXmWLdPB+OoyJaRQeoaQdjNT25a10Dpk51cN34o?=
 =?us-ascii?Q?Vxq/SwJjFYcMQcJRGpI9fJs2/aVd+bInbi+/ysYip7CzJRuMeJNRkg7NBuFM?=
 =?us-ascii?Q?LLuqVPC1lBbRFw/EmAsOqxf09Es7Ha3lp5xL0LgWf3T1xmn/QUYAZQoGX+ro?=
 =?us-ascii?Q?4YvMRQ9ZhBIz5jk1vDRZNbESZsGlZuAnwXQX9JKX9Pb1hPS+VCjb7n8emRQa?=
 =?us-ascii?Q?PMsYlQ4JQqxlSBoYSAmWu88QZMrg2k/YD9tI8B+FEZlzo4cJ0ApxWaG3bsp8?=
 =?us-ascii?Q?EVnSAS+/yCGjfUlvpNozRz9BX/enYVczqIdLM2d5zA8pt968HzfiQ2f55hva?=
 =?us-ascii?Q?T8M7aBJmOderwpmqUT1R0DpH9Q4dxmC4VktUlJvBErPrGhq7joOaR8vOIvXa?=
 =?us-ascii?Q?4NlHgTmhu9BFB5fQwlRWD9CSLg8IyLhWvrG8+aWBLm6mtYk01Gjmj9hfPgfL?=
 =?us-ascii?Q?BZO/ghP5qfBtMtwlQH8lveO+IKf0C6HlxdUfpJxmwZ7dfpFHonQu/6bopWcK?=
 =?us-ascii?Q?pLW17/4KJMjlOFC06Zv5IonqU7EcmomzS9aShrnmQub2cf5ZyylxndQXbQ8Z?=
 =?us-ascii?Q?zkcehkiMLhBBVhLbozd4beVTiTTcyLZ9xWPhtsyYdkvXMqhWaiemZUEjynK4?=
 =?us-ascii?Q?otTVJP6xAEAOminNwgTe5ZLPlXrJRUOjxc2JLwqc2Ivzg5mTISSFM7lNXCIr?=
 =?us-ascii?Q?CXcx8LltIviOIbxkDg5wSp4bQMIK8Kp0X4uceI2UFidkX0jZvSC73SQzvUjQ?=
 =?us-ascii?Q?58V+ykjjiskpDqicIXbBMO4AKK6JvP0ts0mKZCft/s7YbxZVDm98iZRnRCYk?=
 =?us-ascii?Q?NSxsj0JjgGvRy357KF07O4HQcCkvWQ2Neeqfg/TI3RI/0JACHLzDlv2/DtXh?=
 =?us-ascii?Q?JFVMVZ+A55HpZskR6OHrnt893xyDHEk8ozP76F/dSd+VWONOn31AMAxbuvDW?=
 =?us-ascii?Q?xxBM14SgU3DI1Griq1PwD7fO4t7Si48HeAIqF9By7yifFYxYb84j6K2oCYTi?=
 =?us-ascii?Q?TSiz1TRInLlNQaT+JStATcFUE4JExleK3OIjBmHU4B1jCoggHyzya4+c3gXt?=
 =?us-ascii?Q?OnUy7X+ytkxMgGJtEA9fgzy725ddsJOR6uI40oe/SB8shnYjIueW0GUNIVlJ?=
 =?us-ascii?Q?DGXGmky9OnEZni880eMq60NCgBtpufYwzzEdEJtLGW97Q17NGwoWcLnL0fkU?=
 =?us-ascii?Q?hA8y+axnldagHvX0xqEbjo0P9zjOA8euAus8Gt0S2lzaHZRNGhJu2VvjOxjK?=
 =?us-ascii?Q?XqbafpUFuK4PW/z4irSYSf1w8bPbQB3ECtH6tt8GwDWv1HOVmURZoHonXwHt?=
 =?us-ascii?Q?NRIGSi9HhDWAoSrvNSC6n0xf8QKPXd4UYr/5IY+q16N8r2GixRg/kmgQse6x?=
 =?us-ascii?Q?WTyZIlhnQ4tK1xaH+i+ClyEpHxKI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9701a7bd-bf8c-4875-f40e-08d90a580153
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 15:12:14.7044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nqch/CGoe3lcVcS4p68b2CVoKJcevIJo3RYCbdKNEVzWbsDXnBEdIoyHa9pHuqS/fQDMZIFila2qBQ+cLSJofQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1498
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In NPS4 BIOS we need to find the closest numa node when creating
topology io link between cpu and gpu, if PCI driver doesn't set
it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 94 ++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 38d45711675f..57518136c7d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1759,6 +1759,87 @@ static int kfd_fill_gpu_memory_affinity(int *avail_size,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev,
+		int *numa_node)
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
+
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
+				*numa_node = pxm_to_node(gpu->proximity_domain);
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
+	/* workaround bad cpu-gpu binding case */
+	if (found && (*numa_node < 0 || *numa_node > max_pxm))
+		*numa_node = 0;
+}
+#endif
+
 /* kfd_fill_gpu_direct_io_link - Fill in direct io link from GPU
  * to its NUMA node
  *	@avail_size: Available size in the memory
@@ -1774,6 +1855,9 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 			uint32_t proximity_domain)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
+#ifdef CONFIG_NUMA
+	int numa_node = 0;
+#endif
 
 	*avail_size -= sizeof(struct crat_subtype_iolink);
 	if (*avail_size < 0)
@@ -1805,9 +1889,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
 #ifdef CONFIG_NUMA
-	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
-		sub_type_hdr->proximity_domain_to = 0;
-	else
+	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) {
+#ifdef CONFIG_ACPI
+		kfd_find_numa_node_in_srat(kdev, &numa_node);
+#endif
+		sub_type_hdr->proximity_domain_to = numa_node;
+		set_dev_node(&kdev->pdev->dev, numa_node);
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

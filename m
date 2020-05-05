Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D884C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 18:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF582068E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 18:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mPhHPbZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF582068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194286E479;
	Tue,  5 May 2020 18:57:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AF06E479
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 18:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWiiB3z5zGNPUWynzCIYPegsH4+qk9icU1EIEagQmYM/2OMI0w+O201dTdWFoCrBYauOZ0mtBtyxDk6WmMA7zPmqN+aCVMVK+s+kP2LG4/G5Pm8txpbdYgVsIL39CEp/rOSCmW8am5zJCGYs3osbLGZyiojqJKOhoEL7a1yhnMUIhfyihcJFHb6Jj5bPP8ixwGgUrzsuaAyCaIiP4QoAMiEqemUwPF8Lp3JXu48p/Vmo1f9vm5CgsjoBmgaTSA5JT/Bv5lFe9iS6rrEBGpt4X6GSfBkR47atMDAGO7vayiZK8Amg/i30uhBtofXYGRcYMZB+ssW75JiCvzrKZX8sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnzZuldmPU4iZB9KHF0kIRwv027XbkZWGkbfwFaG5Z0=;
 b=canKzIdGRDcCOVQkhemnSCfl1CprEE/LNqAy2pC6awEsB9Q97pITRfUqPIs7VaUh35f78w+KpoIjJ/6P8tzq9sIfFUxudbPRwhAH4WvWQzIiJNzBIzjxpPOfkzWGvJODK7xz23PCTFFNarqLD3llJQ5W6/2lyyWjvK0EaWgUJ/F76hgyM8c6vbrkJ0CuHYVDa6mDC9siq7/5tZfRVUNGNO2kdt6ixAZXTnJVH3zmrIGhck9Z9xOtTR3GS+94yeww528yNPtlplgvFZ9u9Ib96bDyy8oUkVoTjo6Vsc91EV/on4WhT7SWamGO43lI73JpvxTrdu3R4DrZ6mhnBkbhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnzZuldmPU4iZB9KHF0kIRwv027XbkZWGkbfwFaG5Z0=;
 b=mPhHPbZasNP7BlyTNBBTmOj5aTFdn5towwzG4AV1o+lo8wBiZ47WlMYG/c+QQ/wDABjC52gZhpTklqjOyf7CAbjmXGEtNDnS9FzsXs9+9WYyk8twrLk6as+ZDEBmJjk69XulBzkX2ekR2WyM5364wfNucFhmiTeB9UNIrBT+mzo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 18:57:22 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 18:57:22 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2""
Date: Tue,  5 May 2020 14:57:08 -0400
Message-Id: <20200505185708.23373-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 18:57:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15bafdd3-12cd-4dba-1ee5-08d7f12624df
X-MS-TrafficTypeDiagnostic: DM6PR12MB2971:|DM6PR12MB2971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2971E3C8B8348C5ABBF4163485A70@DM6PR12MB2971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0xrSEngvfN+ZQohBU0caKtB4ij+kBOXGeHTprE1jWpbrSd/a3Ivap1ALKzQzfAuGCCkCoA2sOkxrtE67x3Aj0Uo2xTUWst8ew3JwKkGOSnTtH7WCbiP47CRiIZ/MEw8WGd6x9DydDRAvbHLJXf+mooMD0+pZzLBK8ZsTt8SjBShJYtKOuHBmRgawGPawMtBifNa+bxBKx/Vrs9J12aEZ0fpEPgPeA7KsurH5KnCfWbqFehXf6IM7f2yR2GTOYV0pj6zwPKEFfczt+cnQAMC92rIITlaykOncXHmg9k+b457vGOTsztWC0Y8YuxCmEJ2mTI5f+LgVFUJdyVQ3ltlDlFbxlsYLM1Ijc9hjdG0tnOmxeVqmmuW39x2Ua7JjrusRydLMIpXXrIkapusXRek9SeozL7DP4Nj6+5MG8pWCl1nTAhcKDrjxsTL/2gzHyz//WYKhvz8PzoErmCZDHwcYj/uaRpaTyXfYas7f+rjR5dd5keDWYEd8Wp/w1B1PmcJCi9PwiY2OdcoR7e2a/ScBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(33430700001)(36756003)(33440700001)(66946007)(66556008)(66476007)(1076003)(8676002)(2906002)(8936002)(316002)(6666004)(5660300002)(6486002)(6916009)(956004)(2616005)(44832011)(7696005)(186003)(52116002)(26005)(16526019)(478600001)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SdsRnrPbaIe/3yLatVtaZ++qA8bPx62qlCtZegu1iW/8zTFQRnzSt/RMVaj3VEJB216E+41Kd6aiE63OabQu4xWZInadjRk0/EbBM6jOVTeh+J/KXZYrstK9JLfEMpIerX03BRVSLA9VH+NTtmOoKJ40KanUtalnTy/3g8s8R2RhGdgHslLfN+5Yk3BvDqgVrKtU3yBT5Sy9sO4sTuQIOTuSemXS2d2d6lqQWbA12wl8PFag3yKAIanT3zFDrTh/uIKcaZTdcfFS+zGHVTHkOJw0c4+dJYR+TKbE858YBX8bE2piwcSJHdgJ44ruvVDcF0jvIZIWxghPBMEkvoYpXD2qoxLTED1fbxb5zn52236zQMMJ0zwnmvcnLoP8I4XfkBpEmMJ985+b5q/sWko0zCLRKwNDTqVW/N/Mv5fkEnw6lR2UtSdyEPtG3SdNsxyomEp6JYURfQRGykuBGjSpryYsmN/V1YHFQfqAZuzZYQY2Td310PoqjXXnlcvRwH7v9KmA89JuLk9eO7SqR98eGo99dCbWaEWK5WzHO4w1ijnLOyEYAX8oFM1esklCaE6UtwAMxuWPKpZpiarToVxGdTpNcxZgmZ6imlgKI5Ke6DGoXqoff8U3HBvnzgLPALnxjYrMBFrzBH5rIswwLFlKILCsRCPyT5czX5CM8FRvPbjhlt/bLvRXUfaw5S3FnT//iB8xCQWC5iNoWifx6uYeE1G+1y2Y0i7Tmy7t7I+Gi9OiDzT5LQNEVGWluSZCyEaODv3R7wYJW7mkwECP6jYOlsR49vfswZWxjVpqavAO7tg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bafdd3-12cd-4dba-1ee5-08d7f12624df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 18:57:22.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgTLuNvqs8GvXUEeYWxMSyYeDcGoMCFhyzzSnRzAiSqShiFoqgotiokZr7DwI8ULM7rzanxxYQ0R+DXWm44bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e71391880aa72709fac53f98d96a2d4e8875b9fa.

The RAS issue at the base of this problem appears to have been addressed

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I338a985e19cae8e103bd44b0f238314e9460d396
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index caa38e7d502e..bf302c799832 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -255,6 +255,32 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 	uint32_t hi = ~0;
 	uint64_t last;
 
+
+#ifdef CONFIG_64BIT
+	last = min(pos + size, adev->gmc.visible_vram_size);
+	if (last > pos) {
+		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
+		size_t count = last - pos;
+
+		if (write) {
+			memcpy_toio(addr, buf, count);
+			mb();
+			amdgpu_asic_flush_hdp(adev, NULL);
+		} else {
+			amdgpu_asic_invalidate_hdp(adev, NULL);
+			mb();
+			memcpy_fromio(buf, addr, count);
+		}
+
+		if (count == size)
+			return;
+
+		pos += count;
+		buf += count / 4;
+		size -= count;
+	}
+#endif
+
 	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
 	for (last = pos + size; pos < last; pos += 4) {
 		uint32_t tmp = pos >> 31;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C36C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 07:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C497610A2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 07:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C497610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEAA6EA98;
	Tue,  4 May 2021 07:47:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B076EA9A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 07:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKFo5iclOysIh8ai1Dc1yMTHbGEr+Wt9HgfKYyJaS4LeA7vcwkhUdPqTYMeGvpj03KNfG8DHmIqFpmzgGJ6EPJvMJ1vbSD5He38T9DwjQ43e0R2LUspAcjlaP37l9XdjuiU/auMRS3sVDH8ZjPTv1nUpbMzWTUbZYGFa6UFEDV2CUA5Nz5jnfJhbMpJrnOVudxv5RuvW7/oa9OePeZESG86H6w7GgKB+BQbc2IPWr61kxgUmuGxyP3+0t0me6XahVWxHjBnIykqDi42Fklnz1/7qaexllstXjSzJLFIDbocHROLXW52I7yjibRB2F+KGVQuCt73muKIuwC4Ohx059Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DsYQShvH7gYUl5IhLBiFlgCRdulkrO9PlRdAIjAoN0=;
 b=YV2ogzt8TKLcdRi/1BKnN6xG/ZPUnan9AOOlR1eNdDZq8BmhVAWVwoY8Ad+/owZlPhE2NUsDkOwn9sv00VABEBtn17EFxi7N9t0W5uzCUIWpu94OvY65cy3H9AiTPAetnIzK3T0eS6agObaRU8vBOzybeynqEQ4TklmZ+pHi2vwS4/h/1zp0yMxM9bUgUjNwg119wmAPFt1/b091HccxLLaag704ZtTDckXPoHnk/fOdaMw1AGULYs8+KHhyAcGur8592nxpG2z090gz9m/yAl3le242UJ9xepwhwKqx4Hdrma339fiGVuvkrGJTSh+Ivt86jSl5DkFjMI9cIKkGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DsYQShvH7gYUl5IhLBiFlgCRdulkrO9PlRdAIjAoN0=;
 b=wwmstgYGR67f8KIfjtQAXLLHnAdc7Fx/nW28n5gMJ9NipMIOPK9CoNK7vCMcny5anJoKN5U4cR2JioPzvuz3SC6NfYTYosrxqqTdPNNipQKtKAFT1sZINCsZa7D3MhC065N648u7Za1sQTE/yw1ULWmUnf6Lf6LQ/AnavxUpz98=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 07:46:58 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::b83b:b880:25cc:c1b9%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 07:46:58 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Thread-Topic: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
Thread-Index: AQHXPEDkmcu6EZNVCUG6NeTIImqf/KrS+adg
Date: Tue, 4 May 2021 07:46:58 +0000
Message-ID: <MN2PR12MB4549A0F3CDC8BF13CF2D115A975A9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
In-Reply-To: <20210428151154.28317-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-04T07:46:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5903b00e-4f5a-4cf2-a1c6-1737139de801;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c7e76e-1fba-4b31-f2c2-08d90ed0cbaf
x-ms-traffictypediagnostic: MN2PR12MB4518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB451822A40015D99072D95A93975A9@MN2PR12MB4518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38/wAoXeYnGpG7LtuijEVaWcmNCTrfDnvtJ1QVNO6IFzSr+NhNAAvxh6TaU9i0ekiDKn1fnW5KDsd5tSwFRHTsL3aCupAV0vmGExtfEDuG0nMmf66jWLZDYTcSdCjoTK8jDj3IiNRVl4W8pDNnwc4LsM8nlCz2MTcir6RYmE4nSzx5Mi2IKZwHJdoAiowWCqhrRXJu29nZq3sl4kt7Ar/Azr3DYsGJWzMsGz8cZVWy2mrXoDrMkI7ncpy4PCZF9cja3jdiQe0dZ0waAP+mWatAIS0GOwrgzI5OIr7yCdM+u3oNJdVrKVoBkOOGn9M6w1/V/A35owB9P8/kdl2FofhXWhXY9weHuOP5qIQnwOAGk0Tb1SpOdx6HWoBqp2yfynDUr7YzQ9qs7K8sIccmOsCUE0laBUI4YMRItXvbU6u3AbZq4lyJkW8IpyWoZUtnNyw8exE6l/v7/a0psExMGw962A5viZ4fLjLkLR3atgk/utHsPbGXV7AtJi2qrTRfL67CPQiZes/G5zyuneqfZPcJicc+h0Y0w7McoJwHhqoVO2mnHzqIV9U8Tb/1+Pp/g0yYVoN7jR4hH5vKOiVFFB3dbxu843JsBZovnl33VgCqJqNhEhbDeOY8pc6FLFw5MGeJd6iE5kYpPwU14wU/m2Xw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(52536014)(83380400001)(45080400002)(8936002)(38100700002)(64756008)(66946007)(110136005)(66476007)(66446008)(8676002)(9686003)(55016002)(86362001)(71200400001)(7696005)(66556008)(478600001)(53546011)(2906002)(6506007)(966005)(5660300002)(33656002)(4326008)(26005)(122000001)(186003)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YQTYEGIQPZED+Xw0ltrRZuNvPYURS7/74G8U4sYntClHaTnxrNHea/RFXe7I?=
 =?us-ascii?Q?uvl/hOJzpPtiis00jq5ZY9WGWU13eg0AMLDLsTB7eY54snsuOmkETQRZS0Wl?=
 =?us-ascii?Q?45Q08lxVyWyz30b3FtL61YojHa7Qp0Lxdc9YJzqJtvGE086ZhS40TuK1yXn5?=
 =?us-ascii?Q?bK6JlsgKpYsc8NrZS7mGTGpxvWuA42oPwYsfzRvA95ZImPZxhx9PggaMx7q0?=
 =?us-ascii?Q?/DVfuVX5Cjq5I9vi+s/jM0iaxx26qmV41gVSDsxrEaPGgvUwYsnO3kaUtvGY?=
 =?us-ascii?Q?1quZXx1c+sVsUmWMf25On6Jb9NeobQx01Xpy41Gb29hz2XDdeTXwOOGzLbL8?=
 =?us-ascii?Q?T3tUKUggDkrqrOozgQrrksFsToYAVz+LOq147eJT/bethocC1gxpRLhNQC4g?=
 =?us-ascii?Q?F+2Vn+jcmxTsF9LaxSm9W7XDt4D9MtEha5VbjDjaXI1x9kdeJCqKhyO6f0pH?=
 =?us-ascii?Q?57mu9Fzudsf72BwIgkT7cKJgaH73I5r83S1gHZ6z/l+5+pc+ivpQFv8TKYVe?=
 =?us-ascii?Q?f+am0aWsWXXZ/rRTlAxQukQ1IYecKN+rksey/TIxkMnLVaDu4s3/CRGa8fix?=
 =?us-ascii?Q?xqUnpBz+uKJKesUDd4cUwX7aCjlnm4w8plYPvb9MruJv1ffCUKD3K+po5nf6?=
 =?us-ascii?Q?4sLMpPFcawkwQ4oHIgRS3aLdhKRNvCX5aIlgC0sQnAW4pXHBUsUY2hslpZ4v?=
 =?us-ascii?Q?TBFWLPyWj4RWoBHa301/5bfKf31F74TiC2jNJPONvMz8Rt1RQKMe5aMM6kxz?=
 =?us-ascii?Q?TKL/jUQ7g1AYfvjK6a1GYKpxcZFK1yMonASFT/feRMSoDR+0XrNDumQiuhR8?=
 =?us-ascii?Q?8Iey9Y2u2Gj4VLwfFEYAM2pC/htU/kIwmEB8L1Q6akZb74I/W+/LyF7taqj5?=
 =?us-ascii?Q?3QB5ebfCy+0QkPxbIa56xI7IXL0uo3p1dma6KibcFEWX8J5OpaIuXyTJI7v/?=
 =?us-ascii?Q?H+meLUIhrtH0FZSshiMFV/PxQPC0Jnc19fUg7Zel4zj1RaDrTeGztttWJP+P?=
 =?us-ascii?Q?fqv28HpcdappPOml76qe1uOwUIcbPzKTZcESpffOIekQjSv/QtPkrIC75a81?=
 =?us-ascii?Q?7l3LVq0KXhvCN4Q9aQrmhYBtX3STHPP2ms0CU4cvwmSoHjr9tmkPaImAD1fU?=
 =?us-ascii?Q?xkDInwXSfKCFeZJe9wYXa99+amGh7aAf7kUbXikUizp7TbmyJNZHNF8guHPn?=
 =?us-ascii?Q?7uZ0Rze5+ft9ZJE/BptkzrA71Y6ar16gnLHLFxYySd2y71wKuvbccEc5OzWm?=
 =?us-ascii?Q?nriJG4JDB9X89PwoUPuS0dp9dAngIA04i/Ae8E+XaQkAJRxZ7h1Z0Rg6k0qO?=
 =?us-ascii?Q?S9h6fHnr4Vlpa2+MUCdy2Ae5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c7e76e-1fba-4b31-f2c2-08d90ed0cbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 07:46:58.0588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2+/M7ZHThfi28BQbpWKON92JdoeMH4do+/6/w4sEigpMSGsupq316496e0lhzld
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> *numa_node > max_pxm

Why numa node number is compared to a proximity domain? Since you are already using pxm_to_node() API, assume that should take care.

That also will avoid parsing ACPI_SRAT_TYPE_CPU_AFFINITY structs.

Thanks,
Lijo


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
Sent: Wednesday, April 28, 2021 8:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology

In NPS4 BIOS we need to find the closest numa node when creating topology io link between cpu and gpu, if PCI driver doesn't set it.

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
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;  #ifdef CONFIG_NUMA
-	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
-		sub_type_hdr->proximity_domain_to = 0;
-	else
+	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE) { #ifdef CONFIG_ACPI
+		kfd_find_numa_node_in_srat(kdev, &numa_node); #endif
+		sub_type_hdr->proximity_domain_to = numa_node;
+		set_dev_node(&kdev->pdev->dev, numa_node);
+	} else
 		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;  #else
 	sub_type_hdr->proximity_domain_to = 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C96808a6aab7b40861eeb08d90a580524%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552195438132467%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ipBmGTX%2Fokto1zRuQ8jlDA8p%2B8BOjHZa5WGGKNJszEY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

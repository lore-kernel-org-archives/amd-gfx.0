Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D303CCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C2410E711;
	Wed, 29 Oct 2025 07:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pN+W1sFC";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E0A10E712
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYIVufWkVOnq52zaSzRGIoycfgSzaizMyFOxynO1VEim0ClJOu0SlylbpVe4p+IvSMv0JlylZ0aDN0e0PrIVEM7JOTHJvq/K48/0saosHyXSnUTcy3rGQJHFP8+fnATo6zl5EJdmlINIHYrMJ7JHwj631fLQtYhD+GxUvyOGcVRpojRbCf9rMsDkZxnf5NA5FNtnKSzSKTWR0II5B2Wlv3H+sCAd2bvB5JasqD6RoryOQ5DQj/y6mvp2U0suzXYIKWajP3lN2GNc4UDY7t8D7UFsewnyQ1OqSJZ5VQ0BhZmSXntMs3+xzEbKBDSZeZvsNussMPPNYH6KlvGylkyRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj2Og1D/rqSVIF50inuS/b+g/XGBg0NMh3Dj/mRRpLg=;
 b=AvXwpdD0iRN0TLmBuC0xXnsd4DbEP7mMav+woHWcVN2DU63JkhJ7e3jQAKH5y2CNMLO1S5b2dVWwZ3MZM+wIhXcpVjjfhYmMD+adFrzF+/Fykv4y0Xu1bzC3nZ7ECNBKowGWJAjO8yloP0DOx3Dav0yREysgKRKEs92L69S/U14v1Zxp8dJCoJFF1U2yTpaKOmTz3dd/LKnvqqLmAtsqH/sTDPEbQp6y0XKEwPPao4uOEHiL8gQjt/nebWvYB/zr+48eCjqwasb5o5GWPVF6mxmufyb74ujxo7ACJuDfuyKzX81jeIeO1mGGAvTr91dl3tphjiwmcJqZRIzXCenX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj2Og1D/rqSVIF50inuS/b+g/XGBg0NMh3Dj/mRRpLg=;
 b=pN+W1sFC3F5jjMKidJeuUxb4bCenF158xAS0k+XO0Fc5qLOGWniLl0Ogz6R6USbuI41fgZ5PgbDjOqe7YY9UGHfkHL1x2TTpSsa9Z5npIviumzQR9soquBdSWq0EKcZEuMmLkYpRX1GuREWMxqsV8J8KxWwVGSi9FjinFFxDtzI=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:32:12 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:bc:cafe::29) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 07:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:32:12 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:32:10 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: add check function for pmfw eeprom
Date: Wed, 29 Oct 2025 15:31:07 +0800
Message-ID: <20251029073108.1698129-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba8fa01-6cf5-4dce-ae5d-08de16bd4688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bN6Fyj9jztvzGB/pVJvowaym8uT8HNOiF7al+YACOUSAL8FWkC/70y0vm/Z3?=
 =?us-ascii?Q?Kg+PbWrkFdp8KzXvQK40kMItDG9Qk/DmbpO+yGUQASGY2W1BLVdT5xSmItc3?=
 =?us-ascii?Q?oviGb8uJmM0nNGpILI2R4r1BxOeev/Mu0R/jJcvh+M8i6HOWLJMpBV+k9aRy?=
 =?us-ascii?Q?32bvGyBCAdsbtUg0dJZv+MblD/wAJYv8p334bcaRhTrCMvMj7h2XoASNpmpe?=
 =?us-ascii?Q?sRAAxkdlJvZu4Bpz+pt/eqnoCHr8Reqr69HU88Tj+xTfM0w9YGJ8j7Ji692h?=
 =?us-ascii?Q?+6CLOW/1ckXM0OJHtfRehWWktY7Vunzb6np0O++stjl9hbJXloWPsiBXqR/j?=
 =?us-ascii?Q?Jar5ZG/btymxkeVlqPqeSUpF7LeB/blsxV5oA+b9liTlAEV7ksGKES9RtEUF?=
 =?us-ascii?Q?+AYkYV7i9OT+fkcIJOce7IAi9k/pP00iDlMfHARvAXZ2okdnIjCcoPN+aKgc?=
 =?us-ascii?Q?aUWK+PpoHLK6+BIxsbpwzOYgmCHZmEucxFT/0y4AqPL8m0JG90jzCIZ+m+z+?=
 =?us-ascii?Q?fIreHLi20Bg+2vr+sC/xVuY8To2ycz0nxJGVdzTPaEp/dcW3HFC+Bfa3gbEF?=
 =?us-ascii?Q?nRbpv+TSfxINBK3LcToDKFSGf4pwGNIk48s45Xh38wfvF4HUMdB0aqdF8/Ad?=
 =?us-ascii?Q?hz9fDFiRCLmZe11n+a7NjoDR+vMMoyTWeyLPD1cUefYEiqV1wLVBTLxEyWY0?=
 =?us-ascii?Q?nMfY42c0AyQ1ZTl669nfkeN2hmp/Q8uAlJTNsypRMNNe/4HNAEtAE9POrnCk?=
 =?us-ascii?Q?omr36Ses0dO6LAQuJjr9yCaMdLN91zVH7THmmiOJTivyFcI4C9cW1hCLqFWU?=
 =?us-ascii?Q?PJT8vWfwZBo0tzP5DjsDNzmW2FzbxD4hAt36c7ty6Y+kBsuREjUpB2MjOa1W?=
 =?us-ascii?Q?ni5emeoJ0yaYPF3D/U07gZAj9SSRSmO9YmUyC0gCCSRk8djOkOb0snRa6N75?=
 =?us-ascii?Q?uQaMVBNjFUlhpAiDY+YLvCd5ilLuPVuG7NArY1CFklHYHenj89XY0/VWlkLI?=
 =?us-ascii?Q?GLh2PMXVy0qlUZxDZ0goU3ZHQpsaq6cH2VKWfPI4XSvQweR6ywW5J/xjCIde?=
 =?us-ascii?Q?3IAteq2L0Dki9xwyEeVUC3BBvWr19gqR9gqrbYwmD0I7uZ9B/ZZmSNXJAnwF?=
 =?us-ascii?Q?+9pKYV/pkzPqEyIuZGECVoXvBg9fqA01DAKdIe3lBqZQDZrQVTbryXcV1g8C?=
 =?us-ascii?Q?+lbRoIqXe/LnvSfXvhmKixwBuYlVGiDBMdffpHY4oue4u8mW+QL4HV/1iBA/?=
 =?us-ascii?Q?QOhMXamb0EgrzmyS6YuwjK2z5m5Ziriz6Lkct2ciLZmEmMgYr2nzXMTdl0Jg?=
 =?us-ascii?Q?yVr5C+en8H/UXhXYVLf+5nAel6ns9xtuI4haWVG8KTtJEpntfOHToUiCc+rx?=
 =?us-ascii?Q?9Vt+vAfzq8EZRTWJPYAnpz+HM+9H5gWitlewEkwV13twxE/p6E0tJPsK2ckK?=
 =?us-ascii?Q?iKgf6jQORzCynMgZ1omwPvaEBZzdei4/sjFgKovV+X91MLSWAsYmmPCvih+8?=
 =?us-ascii?Q?7Dt2tetJ3dvxVEAXcFjiA48olpQqZnIyG3eNuqRDz+u0Ryab3KpgcItRtzCo?=
 =?us-ascii?Q?U7ma5jkTd6cGorVmLlw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:32:12.0656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba8fa01-6cf5-4dce-ae5d-08de16bd4688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add check function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index fafdd7b22316..25471d286566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1498,6 +1498,47 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
+static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!__is_ras_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_bad_pages = ras->bad_page_num;
+
+	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
+	    amdgpu_bad_page_threshold != 0) {
+		dev_warn(adev->dev,
+			"RAS records:%d exceed threshold:%d\n",
+			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
+		if ((amdgpu_bad_page_threshold == -1) ||
+			(amdgpu_bad_page_threshold == -2)) {
+			dev_warn(adev->dev,
+				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+		} else {
+			ras->is_rma = true;
+			dev_warn(adev->dev,
+				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
+		}
+
+		return 0;
+	}
+
+	dev_dbg(adev->dev,
+		"Found existing EEPROM table with %d records",
+		control->ras_num_bad_pages);
+
+	/* Warn if we are at 90% of the threshold or above
+	 */
+	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
+		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
+				control->ras_num_bad_pages,
+				ras->bad_page_cnt_threshold);
+	return 0;
+}
+
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1505,6 +1546,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_check(control);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1


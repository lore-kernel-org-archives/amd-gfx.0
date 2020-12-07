Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B686C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E257227C3
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 06:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E257227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A8089F8B;
	Mon,  7 Dec 2020 06:42:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C46889F8B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 06:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm7zfKo+iBGL0KHx2VVnj3/9qoFlZipXKtNuuzARCJtwNxdhgTxo9CGbv+tsN4rKJuGrFSg+68Jl40MFs/UpURjBCaJYBQ4sd8AFwzeiHylnjm7j4oPoiS3ZZrvdVoVcK1cvDj29TKIMY1lN8btrvyPSuU3FlmpiyCdGcLepvO5MuE0EdsFZevon0l+6CdNqD1mqZyCHachp+4k6BB19I2vZbSfzfdyHP7uSLr0n1rU7w7B2sVJ9A92UNoqlGFQKHRvkJnuX5h2OLqGM0274MTRKEieYF55vr5Q1XJqIR2BGoWeOGyygKqhxCzncOLsiOqC4e3lwb9pTQvjIwlTWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26xs6B23WcNaZQysWCp+q6eiqGnRJs7AOcJqhW93w4k=;
 b=fmpFd3LzGKGVcyPwVCnIqXfIfgPZ1sMHnuPv10F8Mke0LhS5rTkWS2D+3QVIlSw4D7IYdN4I7KL4WRGi4DJ8+St10ldCJd8VkvH+EYxqmxq6XiAjVic9YML3Kso+xOgYzQACL/NmsB3IaMt0rctyx1te7AhOrsu2WRQQ1vEW68q+h7SEve3+SgLhT5k0tpBxJVacJCUd2DytS7XOPNA00uW+DznUAn2v/Yg9Sgtc2w28fx4Wk7wB4yQgkn4diUWRPA0dWMzPDkSTaccyaymeYV549mrJO+a6UklAdLHV4dZ8qikSkRE8bwnBIkKmHzx0EXjrq+L77NqeAoVDP5PtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26xs6B23WcNaZQysWCp+q6eiqGnRJs7AOcJqhW93w4k=;
 b=umtiTWVvHxQZnHGJ9ezZTRLEta1LLaxqEmY26o6gYlwGJtKaolafEOfr1Yqarv+9wTlBWYrasyASmW7TLmOHG28XYwUAwOhylF0d9qljTzOjgS7s+PeLq6B68AfkMgx2zQNBvCF832frT8zNFnYwh9UoboFW6VAA/yITiw7PqEM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 06:42:35 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 06:42:34 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: add smc v2_1 printer in
 amdgpu_ucode_print_smc_hdr()
Date: Mon,  7 Dec 2020 14:42:11 +0800
Message-Id: <20201207064211.23822-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 06:42:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24363330-d358-42e8-a0f9-08d89a7b47d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB2960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2960801AF094D45553C461BDA2CE0@MN2PR12MB2960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yxrq6kBYOgn42qFXzi8Z9DyusMhQTRPC/ftbLKyz/FajkSqD8Eu/Zb/CBd4ZbWcchfs9fsijDNxxLX1D4R33AiZu1EqujG8QAFCmspjUKyJ9RN3b+ZYyEcup+cg8d0spQEID0kx0GFEKty1Yh/8bdyHZy/WaXOXxS/QlRLIoLpdAJbSc78hixPa/+NF1mK8TTskMkDM7R17Nk0QvHcsVn57zGFrYObqLR+9cuc9Re4IFow1CWLoumeTQyntsGNaEodN7zW9eCFRbMJZ/eebJrmCqNfU4FRcbljeLmzkBRq61nKccqKWuKMiQAJ8BgWeV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(5660300002)(52116002)(478600001)(86362001)(8676002)(4326008)(6916009)(83380400001)(26005)(316002)(16526019)(8936002)(6666004)(956004)(7696005)(66556008)(1076003)(66946007)(66476007)(36756003)(6486002)(2616005)(2906002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Cr96+sbpsI5D93cQpO4I50NfLjmuGkgGTytCqKc0HqodDudhv2DGQ0oKoqP?=
 =?us-ascii?Q?cwORo+9nfYfGcnGi/JtA+bYTbX6JdB7oGelNpwLIPtuEY4bitCISWtTlnoRP?=
 =?us-ascii?Q?6Un9AIuATTEmfCHPVaAojaHJb+nivFgWdJBMIz/EMGUMvJ/mZNvMmL9eX2LV?=
 =?us-ascii?Q?k0e6uj0DsO4IgPsM0xQgesx/I2mAestLo0vBcXTQAvPpdFujG8hEpAkSKltc?=
 =?us-ascii?Q?t17p81t20/ZU/PbJf9PW3gjGs0rtzoZtvZfOwoqqx43xx5/RfiOhNjCgV0aE?=
 =?us-ascii?Q?s1HKikqBX+Z0VogUi+GLi5JPeOapPvi9wsbiBCJRyn3aUXLeMgqXguRDj075?=
 =?us-ascii?Q?DcYysUQMdE4WOd6NjN91pHnePTXkScIRXdxCvF5sAWpKiJug0keJsJJhIh2s?=
 =?us-ascii?Q?0mSLDuwFoWPvkYs/FYBgt9yyJJrJhpc9Wllf+yBdisJyr/ee5yZlVZES7j5a?=
 =?us-ascii?Q?1G8c9OCaJEsDQPIG+rt8WwdHtFc84ZIVFpxfy8/fjrLkma7Y4Fb1f7C4VKtv?=
 =?us-ascii?Q?KiTCZlmoHlZ9ZLTfBTjFbAFiKtUNSS5Q32Bxpf4xgCz3ewZCrLCEMUGXZX5b?=
 =?us-ascii?Q?SwMjEZYz2eDuu7vMXPbHiYmlxoK1oYY2D5uC2B39bDYwaPjLhb1Xn0P3CNg6?=
 =?us-ascii?Q?yHnwdZcMMEYHsBRokl9lMcmX5rK+ZhJ8P7QNFr0yf08JNXLU+e7EafzZhL/p?=
 =?us-ascii?Q?SAYcdxmnneSuuiEBUYM9fv+FUbrC7DogwUPbtWF59d+8TeKwRxZYBogG4t0h?=
 =?us-ascii?Q?UlAnbF0zUgwG4JlKvWma3eK2qRXKMRGUW16RlZSI9XW5XydsQw3hhy3+iY0W?=
 =?us-ascii?Q?NXao8n9PKBwghA0WF0bfUbzgQdBGjsu7//+vexfLm5cagiCOMsd8BCkPo5JU?=
 =?us-ascii?Q?q60t0U8sv1Ew5s0Dj+MR0RUTyVcWStCTz5ef1wTLjaJYVxjbdND8wwRIIk5j?=
 =?us-ascii?Q?p3W59fPVlQEUfEa2BwEOkRKoLAP+VDwJi5Xj1u8tbeauemHzIuIvH+ssX65d?=
 =?us-ascii?Q?LvlT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 06:42:34.7952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 24363330-d358-42e8-a0f9-08d89a7b47d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYJQyOibw9pEGHwk0m59V0XANQJFK/dp+hBbCNC5c9mqRlgZGQmWgkMmX1F9LBps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
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
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the smc v2_0 printer is not compatible with the smc v2_1 .
1. add smc v2_1 printer.
2. cleanup code

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 2b7c90b7a712..1beb08af347f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -68,23 +68,32 @@ void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
+	const struct smc_firmware_header_v1_0 *v1_0_hdr;
+	const struct smc_firmware_header_v2_0 *v2_0_hdr;
+	const struct smc_firmware_header_v2_1 *v2_1_hdr;
 
 	DRM_DEBUG("SMC\n");
 	amdgpu_ucode_print_common_hdr(hdr);
 
 	if (version_major == 1) {
-		const struct smc_firmware_header_v1_0 *smc_hdr =
-			container_of(hdr, struct smc_firmware_header_v1_0, header);
-
-		DRM_DEBUG("ucode_start_addr: %u\n", le32_to_cpu(smc_hdr->ucode_start_addr));
+		v1_0_hdr = container_of(hdr, struct smc_firmware_header_v1_0, header);
+		DRM_DEBUG("ucode_start_addr: %u\n", le32_to_cpu(v1_0_hdr->ucode_start_addr));
 	} else if (version_major == 2) {
-		const struct smc_firmware_header_v1_0 *v1_hdr =
-			container_of(hdr, struct smc_firmware_header_v1_0, header);
-		const struct smc_firmware_header_v2_0 *v2_hdr =
-			container_of(v1_hdr, struct smc_firmware_header_v2_0, v1_0);
+		switch (version_minor) {
+		case 0:
+			v2_0_hdr = container_of(hdr, struct smc_firmware_header_v2_0, v1_0.header);
+			DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_offset_bytes));
+			DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_size_bytes));
+			break;
+		case 1:
+			v2_1_hdr = container_of(hdr, struct smc_firmware_header_v2_1, v1_0.header);
+			DRM_DEBUG("pptable_count: %u\n", le32_to_cpu(v2_1_hdr->pptable_count));
+			DRM_DEBUG("pptable_entry_offset: %u\n", le32_to_cpu(v2_1_hdr->pptable_entry_offset));
+			break;
+		default:
+			break;
+		}
 
-		DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_hdr->ppt_offset_bytes));
-		DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_hdr->ppt_size_bytes));
 	} else {
 		DRM_ERROR("Unknown SMC ucode version: %u.%u\n", version_major, version_minor);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

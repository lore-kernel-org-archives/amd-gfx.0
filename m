Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F2C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 22:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028A222D2B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 22:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028A222D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5275F899A5;
	Wed, 16 Dec 2020 22:34:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCDA899A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 22:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAxO8tKT8BozkAIlKNge59WN5EmDyetOwaH0squBWv7cqJLY/PhYtTLWwlsXaOVDx/VV+5lGow4xRLdAaUsrU8V7ItT+HKoMk4x2PipCWr0BAB446M17y6OMUH6TkHbUfDM1qRhqK/aptik+Y2qrhEc23D9Vc698/bBaDxGi8vjea6rU/z0ZJ8mAIxQjg13B0cdSL1iGswK2je/whnPGEb9b4UppKmgMlCs86wG7R7eDoUtuLotMAd85eSrzysFItOPdJFfHcdVlzMeQfPCZfohm2VfZvsuVF6++RM9EShjemC2yXAbXNnw4kP4weHzLKHg2Qc5uCDSfEL/7yWdujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08GXOAxYEzt3GsNl8Qm0FR9B7VxSge/BOrwVNYsuOf4=;
 b=PW55U/QcledtJ0CVQpj3b4YToW7vPn+KevA56D3Y8PZPn00CU6sF+urPm3TNuVsH3u5zdHE61w4uaR288ZMtZS+0pCMUTWHx5rg6j/MPFVR1xFo8QRm1U6CkPPNac0jHTEkaTflTptFfjV+URCkc9ZorbYCfqGwtAqKuj05d/pNS7CWavAlc5H8d4Vt/5AsEfLQjgyZa1yCdm39jSveUr5PmU3a+6uxpyQNAlY0X9XZ51fDpgXFfvDRoeZU07NNRS02Fo6zYrDMk00hgO0pDgqYCcxAA3xTlhYE3VXQnXsymrh4i1GvHZ3NepX948WJUwih9GprjiDbRs1nunHZXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08GXOAxYEzt3GsNl8Qm0FR9B7VxSge/BOrwVNYsuOf4=;
 b=Fk+ysfx22lJ1+b10a4AcCNgblUD+H/NUq61ydPolQDjJIml0zkK1fRHqfJPFKtH5itiw6qq8Hnic9+ybx6LATPo1YvHLtHf9ZFGHE+7eyCVfReNfUm5xX4EZUR1pZ7m2Ie6Sc7vGRwhsxuFKDGQTVQTygxXq7Qu/ZVoC/dsa5YU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.17; Wed, 16 Dec 2020 22:34:27 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::61fc:9601:8a3a:2cd7]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::61fc:9601:8a3a:2cd7%5]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 22:34:27 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: PCIe atomics required for gfx10
Date: Wed, 16 Dec 2020 17:34:13 -0500
Message-Id: <20201216223413.510714-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::37) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YTBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 22:34:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7db50df6-4c2e-42fc-d61c-08d8a212bf2b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB290775D34A89F1673BD256A78CC50@DM6PR12MB2907.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Se3AFxAq6CYbgHgLWdfX5AsGIiqaMjV3IoTDh3qghqusUUJRYmc97tspmNdJGKOGjCe/dagDJh5nbsJ2g+XnAPsZbyLFQXtRRMb4EFM3lXAI49D6Xi/dTIV0PohVwmJK5Tu4YXE7gZkgTIWqHgQBnVXT8r7WbOhGnELzFOvhY6xIFt04CElCWTVoC2qMSGup2V3h3tZCeqybyL+A0brjU7sDFOiCE6btfWXHfpoRVlRKK6x8LpcF5BTE0E8KkjwLOQtLhSVyshQFDXs/eCSyQCeimwac2T/nV+fWUH/V13gu8SLnFc/yTygzCL/DNVGsVvbMYo3UyEVxQsAfgss5hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(8936002)(8676002)(6916009)(956004)(7696005)(66946007)(2906002)(66476007)(186003)(52116002)(2616005)(4326008)(6666004)(316002)(36756003)(6486002)(26005)(16526019)(478600001)(5660300002)(86362001)(66556008)(1076003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Bpx36ZMRmraJ0rtTWqbIbNsMl4I5jfhCmsvjkf2sGB+bXSR7IdmUrzyyg1KX?=
 =?us-ascii?Q?mLeQwzCaY+6x4au1R7Ur5O3Yq39sYfYjVUdLwb8O2nPow2EzXGXLRQrACjhW?=
 =?us-ascii?Q?byThsMQoOQvhV/5Gzhdjo+9gybMtmaIURX82PG4zW1aywJ/Ai6681kUFlX84?=
 =?us-ascii?Q?0UVIjtIKhwRCMnsgzNH/0QDsbDluthrvUq76wwlOkKLpIUyhpv1+HnTYcwj3?=
 =?us-ascii?Q?cMubnkcZTo7UR5I9GvsUALut0toLGd8Tpot+xAQmGZXBiG2CkJdAgt8/v1oM?=
 =?us-ascii?Q?WjtlAvUHNbx0WQs6zNpXrvP5HSPmoqOVhvcUhQIUrdejCmpNnqsm4u9lyA69?=
 =?us-ascii?Q?4Q80OsEW44Trnxg+hQUuoECDcH0eE5/ZAilySNQrfJGFLMIBbfAwDUGp4MMd?=
 =?us-ascii?Q?FBgH+4fF94XAe9xlk7KvfUuvxb1jLgNYOrG2KO5cYCPd4i2dZabMNC2ymyix?=
 =?us-ascii?Q?z73E50PB5DcaNFh+1pmXJjZ4T9gSSkOmzlC+baddOY5fMqdEL+oFWL081i9c?=
 =?us-ascii?Q?mCotTAOJKCSKX1JlQf98tzL87FQSBf2KAMMA3YbZvmCj70h3jz6CMNJmn9av?=
 =?us-ascii?Q?Rb9Sg3EgG3TYHdZbG7u1rbMGgZnBTFxBOsjWMa1LAe+wvjAZCkzCb0y2D5Ep?=
 =?us-ascii?Q?7DHRojG/WNyDhM+T90pNBFSB5Q6wbOLCRyFPz1Kvul0isIZzIHNKRBTlUJag?=
 =?us-ascii?Q?mxXP5/apz3sE2MbuvWDckDWwhY2kWLmpWnHuwfG+xk4Bm4z/aWJH3bgOlTjK?=
 =?us-ascii?Q?IVqfLL7ryKOfy1/pqK8PhMdoj/e58zACv3IIopFdUrWfK7SvPxHXHg/7Ceqy?=
 =?us-ascii?Q?P3H12LBf7L+l0xZhDOQIA4PfCb0Ne2BlcWTF0WX6l/nQlrAhZ4PaiNSdKFIA?=
 =?us-ascii?Q?TQbHvGIobnquJseschtLyHhXalSQkquYGHjgmu87QKb5FFnueYNVdK4pdV/C?=
 =?us-ascii?Q?4Hb9LdxiIlmNjKtabaCWIxO78h7OKF75vYS+Pj8SfvL6dAzd5ZMFqVGV8bbZ?=
 =?us-ascii?Q?SaJ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 22:34:27.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db50df6-4c2e-42fc-d61c-08d8a212bf2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjacbgUMXQHnWilj5L/gqvsttlXkkS0GbMDmSpY78qKBiPrt9e9O2z1n2LZHXFd/E3NIZU/GFJFbjNZ2zUsEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Change-Id: Ic139a8b9c8bef1df183804e543103be206405dca
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 50922ff2927b..0e1838637c54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -422,7 +422,7 @@ static const struct kfd_device_info navi10_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -440,7 +440,7 @@ static const struct kfd_device_info navi12_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -458,7 +458,7 @@ static const struct kfd_device_info navi14_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -476,7 +476,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 4,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -494,7 +494,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
@@ -512,7 +512,7 @@ static const struct kfd_device_info vangogh_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 1,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
@@ -530,7 +530,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 	.mqd_size_aligned = MQD_SIZE_ALIGNED,
 	.needs_iommu_device = false,
 	.supports_cwsr = true,
-	.needs_pci_atomics = false,
+	.needs_pci_atomics = true,
 	.num_sdma_engines = 2,
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 8,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

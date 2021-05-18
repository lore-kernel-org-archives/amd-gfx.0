Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050DC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B017B610CD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 19:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B017B610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BDA6EC75;
	Tue, 18 May 2021 19:51:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1DF6EC75
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 19:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhQFkDA+l3ZP7kfo6LzL1ggWpbkr/gPe8laWDwLlRzG7AdUsm0JpSxALj9I9Mx3EEn9G2sLkZX/K4N3nQDT6MvyKAKy+uqbOt3Lw/Pb1Lx8vnTPna46hlWRRFo0TObmpqUgR1RD2uh6J4dMA1nKL/dh706i/xXD8BuDUp5SLf3EgdV9t+3mpzbWxo9nMmyJ7gB22lZCJUx8oNQDa6coWgUsBUCctVR3srL4UL/p9XANnfXgNZ1nfPjWZOjqpZu6Dh1gb3C8JCVGn78PN/Dgsj7CD31JkAsqWmRPA5+Q0n/KvxAwi9qRz64kKWPErdVw4yy/FgWj1aRjGtsPicJtitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8UP+ieLoCud/s7zhDnvQLA02KiWUOuNgKdFgh6CX0g=;
 b=NddCjAkUPNUmgY4Gox97nCAlYBNVEwdbh2j8h0UMGKyqm5SOKHdxL6ZWETiQTVMJv2boJWleNZWazcnJUn1OdaUb/pByIDOeGkx4PYksFs4pV57C+iL+SSP/f/ZDYRpUu+NpXzApOs+zevaCC2czVR0omQElsrSMA54WbwWB/LDoAhqLyQkEPP26uixrQ4XJ3LQbQPnl7N77aWsLGlVE87WPbiyB6wJzF3LP2jtQ8hpRkuWRVCZE0PLQI3Q4DwVAs1wjRtylzN4c/KVUXdwu49W8JkYuNj3sJ4zXhQH8t/MgyR3BVFCmFZetxckDQZxqlogVEHtupRF3JMg3Rdg8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8UP+ieLoCud/s7zhDnvQLA02KiWUOuNgKdFgh6CX0g=;
 b=WKL7FEgwHdDHQkPHVtfiOXarVk6z4CzYbsf4cdDnUn/zGW5YASJJQohn//mgHc5F0UVk+2CTqsRiVmdnlS6GSo+SnLPQmSPJbEFZpSqojFMdPnoPyXI4qZ20Ppnym0ArOXHg20xvTDlZh/qzaSnQ4OF/F4oU1l4s256mgomw7oI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 19:51:36 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 19:51:36 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Query correct register for DF hashing on Aldebaran
Date: Tue, 18 May 2021 15:51:23 -0400
Message-Id: <20210518195123.5272-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To DM4PR12MB5263.namprd12.prod.outlook.com
 (2603:10b6:5:39b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mukjoshi-dev.amd.com (165.204.55.251) by
 YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 19:51:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88df098-2eda-4718-a894-08d91a3658a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5519711751BA106E8FDF356CEE2C9@DM6PR12MB5519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LA6VRxSs9GggfpJ455XUCN663YnBXAZ8d+aJC4raUhg2+tuJjJfC3TJTSL4E8HpiUGuHbCWFSlJphf2M1Y4o1W6/UC2AUjQayCmQ8wunvaL/ZEeFr360VGLsJf+jqAXJCSYAkL6r/t5k6TTKBapX0CzgGHxWJl/HA6zTreqEu+AtTQw3/BWmC+GnOp6Y8+g4yvNU5A/vvuHuO/y1SEjwBZSt750edaD1iO8+zvvLznlI21Vkjci2pJWxcXuOZrQsyXjY4UYks210Kl5g3WRpS3zBz9Ex0nkDRHO/trZg/j+AzxCME3oqMiod/cL2cPbQ2PPEt8JeCu4btxCaG/BVWd+FqlzpawN178o4VqbQbWaaGDRRA6jvSbw/LHv/a2ALrb7V+6x7SSeIxotK9NvrKVYPqXBFFkk1EmlRzufLSsIKXgWyV9GC6N/FCdUmzzOoyv902SzmAgGJQtKGo5jss45ikBlpBuBQv8i1A2hIYBuFSwlAnHmoGN/6zCKpkMEguNyagtYnzMk3Jk56oJ4QLFLVjzRu4snp3cHQiiHdkKatCsafzSuxVjFAX5bN9PpxB6Ytw/mdQdhjPyJW1fbVvqatBPy3ITeuhkJQ+wWcBFyUHYDv1iONSUhdu8ZiWGyBrHvul6TJ8r3dBUPKJIxvdU93SiarVHlLTu6uBsIJFDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(7696005)(52116002)(19627235002)(26005)(86362001)(83380400001)(4326008)(6486002)(6916009)(8936002)(2906002)(38350700002)(478600001)(38100700002)(5660300002)(316002)(186003)(16526019)(956004)(2616005)(44832011)(36756003)(8676002)(6666004)(66476007)(66946007)(1076003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hPNdMGlDZMAeNSlECFQM1g5Pe2I32coybEd8vRVeNUMKmrdeOyLUSl2j1jjQ?=
 =?us-ascii?Q?fGcuWar01VEltIftmjKpi7V4Rli1NADEO3tsmo8hZ5cLakGFJ7eEEQRRyNVk?=
 =?us-ascii?Q?td7dpVM9XDe1zv1+hCZravaNXHC5ZT5kozrG3j/9Mi3XosNKj4b6G8UgYVMa?=
 =?us-ascii?Q?bHvxO+bxVcTrNvCyMvJSliogmTQYT4izqoLlRUDFVNrJIplfvLBlwaY/41xq?=
 =?us-ascii?Q?W5GTBPfkh/dgC4GuyHQ7dgnH6qaDRIbgqNzxIbCGLC+eY50BEDPvsU9PweNm?=
 =?us-ascii?Q?4VCuCyf2lcT0XJ5NentjO4P1Qmk1r1udVzNu4hXqFZKD4DcqNgTg1MCPsVTe?=
 =?us-ascii?Q?iMsNeQrefJ+/AZxq9IYV/j6OV11sAOvuSufKFI8lr10ciFXAOPew7HbsjtWO?=
 =?us-ascii?Q?KkoJjIR0d9cPqbtQZcKoHmbSOvsb6UkPVOKl9gKZy2Y1nWe7zfVs7Ppsd3H9?=
 =?us-ascii?Q?4pU59rrH2wvfB9ScmPoP8Ppg4+iVGme8dmwWNhhZr0s37VC0QJ4VzrdqJNKR?=
 =?us-ascii?Q?QbCYJrnsHNuXaojD0BCDecbFBjDzipLIDA5H+dnFzeG+tDODaje5UJULKUq6?=
 =?us-ascii?Q?CneJmen5XyBpaDqo/YKGnFBuryxrOPQxgls0SA0r10/5rHP8RvnxxoUxZiFU?=
 =?us-ascii?Q?DluPZhsYfKsSd4Md8rVPVBit/dX6iRLlCoS4IcEeq1+WDxUGpG5LARD1Kvii?=
 =?us-ascii?Q?P3wzyPfhq/zLkMB5dyPeN6iDLAMU756DudAU1aXx5cihvp8uIb0mYww8oEin?=
 =?us-ascii?Q?lI+dKtQhsgaHPJ7/9vsosHu+Mj95/1GMs26fWU7dPq9KHq+MhvPMoeHIE28R?=
 =?us-ascii?Q?fS7KRtloYofxQJ6AxHduOu3swQNvuq6Gy1BTj+Lkh2iu/oeGE5+lw5SmnPX2?=
 =?us-ascii?Q?JvaD4CFsHWYF7Hnc7rPbZHb2GQPjsFHt42Ee8HARQvlXP2D5JU8eyAJx1hYO?=
 =?us-ascii?Q?3kQ+hXI6BVOWGLRYTEcAX0VWWUeUqHJH0HCITM3iuvQ8G6P1RkZHz2kpp1ml?=
 =?us-ascii?Q?lIGbOkxLmYTAgl1DrC15Ac17YswnRQXdA7JzBmomRv3GCdAoztj/iyBrRhRH?=
 =?us-ascii?Q?e+pQQnlMca5/fmLXcvImskes84xVjy19r5Seuq5wXMwY0jeCUykwR5E9tl+r?=
 =?us-ascii?Q?0u4Ou0opWzvBTegUqwsinGNMopHiU+SSghf+d23C2i99+J2N8G8xShzcTZP8?=
 =?us-ascii?Q?UzQQEu0tf0qovUEqf7asAYivAZXvwlDbjmrl9wxeojhDhhGjcnr10NM0DliJ?=
 =?us-ascii?Q?9grmktQtJkuSKBlkdysBIXPRuQi4RZZ/2BOJZonmibJ4JJ3xCIIo8kFJ4f1v?=
 =?us-ascii?Q?+FKyb5bQ1A0MQet8/Oukef34?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88df098-2eda-4718-a894-08d91a3658a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 19:51:36.8445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRzYct9/f8DgQ/1f3oi2Q630XMjQ6T1Y4nziOfv9AyMQfcrqN+OaLRePrY4v2B2Pk2agUrQTNWD78yA/Os4fTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: alexander.deucher@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 joseph.greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Aldebaran, driver needs to query DramMegaBaseAddress to
check if DF hashing is enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c                    | 9 +++++----
 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 36ba229576d8..14514a145c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -277,13 +277,14 @@ static u32 df_v3_6_get_fb_channel_number(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DramBaseAddress0);
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->asic_type == CHIP_ALDEBARAN) {
+		tmp = RREG32_SOC15(DF, 0, mmDF_GCM_AON0_DramMegaBaseAddress0);
 		tmp &=
 		ALDEBARAN_DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
-	else
+	} else {
+		tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DramBaseAddress0);
 		tmp &= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK;
-
+	}
 	tmp >>= DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT;
 
 	return tmp;
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
index bb2c9c7a18df..bd37aa6b6560 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
@@ -33,6 +33,9 @@
 #define mmDF_CS_UMC_AON0_DramBaseAddress0								0x0044
 #define mmDF_CS_UMC_AON0_DramBaseAddress0_BASE_IDX							0
 
+#define mmDF_GCM_AON0_DramMegaBaseAddress0								0x0064
+#define mmDF_GCM_AON0_DramMegaBaseAddress0_BASE_IDX							0
+
 #define smnPerfMonCtlLo0					0x01d440UL
 #define smnPerfMonCtlHi0					0x01d444UL
 #define smnPerfMonCtlLo1					0x01d450UL
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

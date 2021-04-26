Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E3C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 13:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EEF601FC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 13:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EEF601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062C389DE1;
	Mon, 26 Apr 2021 13:44:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6973C89DE1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 13:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBZnGD/FB3ZzmnWIVMhPFP4lizecsR1f5KPILBNFppxONOWOwWXHp4XwVSfqM2sR1kTgURs7FZndHsyjNLL+pKaELn7E7DLIQaIWG+XlMIVPc3h3hxLFOr/NIV/K/xjPW6fQfEMF5sbADRUkTg/1FNbAfchWzqb/4U2Uqir/dtaOjVU1RY1WaryVB7eJy9g4T/5Sjm2YTI9pcY4Qm4JXfkfPIz1p0u1xrVtGRsOS3FQ7K4WUf/NjrMz/c2uolZ7Ix7eN88WjtnAkfaCQlzWBOxhd+MZIcBn/8c7nMmAYySPPNumQ4BCYpFdPdufAvUWMsMsphMtxAAWRX/ntfbXUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZyob2Pz+m8C3CL6q57+FR1NPg4eFSWWJuwaD3lArE=;
 b=b9Y7MCvysXkG0+qVbhQAQfzgtkI5yQ7ba54Dfhdy9WDPp38u4Dj+U/iw+qRP/jBrRaoiKxD5mR5/jYaHx0rCgzX+okh6ikMaYKGisnpniE3CaLGfDfZp9+kb7IM5x9FIYfL6ZMsG+sZcDmsCpooosV9jy42KMkYI+O2V9Cej1+fGtfqt1wVIlp98v7oBPRIUkdbJp653BmlmgFNrdkYlB3S1giyYFZNtxhopDgsM5DK5STnUlyhlRcqAWCisKbV9lHMkAKY3P55E8Lol2UzP0AF1zCnR+Gv+Mr3wrZQGv80yDDb89aA8ToN5MTKbXf6KNNf8SWG07z1HmwWfX3SylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZyob2Pz+m8C3CL6q57+FR1NPg4eFSWWJuwaD3lArE=;
 b=4dMBKMsAt+2unAqXHVTkRdpsiLyiR2AUrmGEiSeD6EaS88dvHYmhrkS/eyM4tEYQZSts3UR2V/3M1K+5AfI7jaW4mbVHfrDVRSe8N6rj3qaySNlumO2RcJtYlIITf4Xl/i9oDef0YFl5es9yNLhB/n8dyNc+lfwtdV4pUt6qjuo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Mon, 26 Apr 2021 13:44:33 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 13:44:33 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Use correct typecast
Date: Mon, 26 Apr 2021 09:44:18 -0400
Message-Id: <20210426134418.2198220-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Mon, 26 Apr 2021 13:44:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 064b5468-06ac-4f22-0533-08d908b96c31
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02360E02A18C3928305BDC158C429@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AxSxQ8tOtRw2LvKsbeOYxIwXixt+UpSL+95O6QCfUNPrsh3geXlEZPeZqlTdw2QPY5uhULoqxh0Sya41eBal1SN8Uz2X2m06opk845wu0Q4+8B5msfqLVlpavLTYs+WF5yKfJTlzCihSNj5gM7VDSw0s8Kpzyidp1i3Mi0Kix9XxERHp+EFUWaq5chALziXXo9XMzk9RhZ4dkA3bR4pEz6k4HwYVGHXdkVNnAhRMDr5Nskofo4u8xUzlTNzDHH6oj8UkvZ4Egr+TXAwyTKi5oQDEW43udpoAMTr1hdhwKabLK00AgO9He6YIxTxFrdmeS7r7DhccfWR2EhZuww7D4+mgh6KI/tA0nr99jBjCtrSWtG3Pbgh0odRZ3Qz2rnV5v/TT3FIIOs9O2x/erha/G9Xf2eNZi0wjf3jV4vCPsYcS+YtkQrqgDRbYGMe5LvvbT9GbbexwP3nIIfsq1L257dZo8ZnnCdAKIZl6fT3heMBLrKXHso5G9E3POjes5TyRh1BGJsGuF7qtAfmlFaGsnzav7Q6T1+Yr2w9m3JQ+RpXoZx8lpoAcnl1pmwleV/jd01laosDKPu0Ff+bx2UX5fHQrIyuSPWv/auCH1B7o+NjE1Ld718ja8VBX5KP+6MX88TrlQWFSz7rDzrAWOmlyKxq79g9rNcGCqBYR15m3sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(83380400001)(6666004)(26005)(316002)(66556008)(16526019)(8676002)(2616005)(956004)(4326008)(478600001)(38100700002)(38350700002)(2906002)(36756003)(186003)(66476007)(66946007)(19627235002)(5660300002)(8936002)(6916009)(1076003)(6486002)(7696005)(52116002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FqFsP4Qq/QoNzpqQUTiAs9Cvi2Yid2qX2juwYYceP8vUJlikBPzbo1H4/XC5?=
 =?us-ascii?Q?W7MgQ2oJGQfUcoFZMIFFSUAhA5wUMO0OylcaMrCmLkaj+rloiNkI6inqzskD?=
 =?us-ascii?Q?rY5VLUyK/GNyXs8vOQMdpu0htDrDp+5yVRG0WCxfVnt1II5xiNp6nEN5x/85?=
 =?us-ascii?Q?2VdWy5cfJ4d6Y8xB1HFGiTem+Tr/5MyaIqYe2PbAyAh4PcbpnzJSeI7faSi1?=
 =?us-ascii?Q?pSRZkXIk6MbB0DXhMql2UvVFN+HdOKk0iXPkLZ+ztiRpmh+Qi2tHD6y1nRW2?=
 =?us-ascii?Q?RnJJ8p27hgprRNKjNPGzqG8rSQM78qL5bqyT4jZWzbEdheI/eqnGSooDJuCd?=
 =?us-ascii?Q?kB1IrQIOB3GpVUtobeDJFOYBEdeZ5P83wDBwS8irf8ni3UchY/N4duvYNIlP?=
 =?us-ascii?Q?h9VexPZsuNR8oFezKZz57aj1nc7Nsjjbt4AFIiSuDfSLG8ZpDqQVK4LffD5U?=
 =?us-ascii?Q?LyuqOc5MQxt9Rggfs/Z9h4SePlDrSsjBg/teBY114n1Oohf/gGaQCY2gOXWI?=
 =?us-ascii?Q?DJDOn5TMnnVSw0l9GSqLEAaEkAv7sJ9xZ69o5hpgLw9RA6rfpTa9enoXE4WB?=
 =?us-ascii?Q?QmNWwDZ+HtBebrKKHss6wWTvQnbRY/hx+3DOj9xy4xPAv/SWaSKiOUgH4XDm?=
 =?us-ascii?Q?mSTgbB5ZfT7OmfuG11Yz3oo3JL19h1BM3LoaCfHaFuEMX4IRicmPCpyaTQvG?=
 =?us-ascii?Q?MNY55y71XxB3T25Y2AatmQeVOw1AeXk4k1I2O71kB+aFRIBnaKIeNVveGoEr?=
 =?us-ascii?Q?KF/WXuYwdBWOoZIiH/ishs1ngKFAjsTzrTJIDRLV/2fxBpqLt2eDSGS4H1ri?=
 =?us-ascii?Q?8CQ7uEbs3Dofzsqx4JxvOLp450MZ74Nda8u2BFEDP9l3x67qlg68n/FIk9NV?=
 =?us-ascii?Q?s2xI2HfQ6+QvdFL2+5z34WE5cn+HUgKAy+Q3sgq9wbdMKTS3+9eb83xRU7sR?=
 =?us-ascii?Q?x2AEzD1liBai3YyY8SPZbkwmt8HeAxpeNCnPisji8YrPV0RYiM2TL0d8p9JY?=
 =?us-ascii?Q?7Pyxw4hC6v/fKSA8ywUxrX2Bee8qSjpxvEKdiJWf8ehy9h4NU2ZoAYZKB7f3?=
 =?us-ascii?Q?Dqyh3j2BiPIH65NNERrOidOJu7LDp0vnQwgRX77k6OojiycO4GXHaUTpwOiU?=
 =?us-ascii?Q?+hkbs6t6EQdbZWUoqVMWNpUaKnYvCz8e5GDdLHdtDD6zThzOHxhc8nIZ8895?=
 =?us-ascii?Q?3ZGjoCjXYUUwXPwsEwYA1ZfEcTnzZGgOu6q3zxfbjhRZTTkg6/tdoo9QHgWi?=
 =?us-ascii?Q?7iR6Zr3dLVqIq/e2WIVO/g0FpWIfDElieGlazVBQxrnEkr2RyusAM989oRdr?=
 =?us-ascii?Q?6gNTTduxnaZ1J5AgTTdCo14w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064b5468-06ac-4f22-0533-08d908b96c31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 13:44:32.9008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2ACEWfcgxx+vX4+aRiF8IWO1qwA7WK4akE+UqeH8F/vzjbhYs2MNuVgOyWNBYEyADPQ+rr7c2mi7nyK+N/Apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
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
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 1f02e4ee2909..771e2f0acdd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1657,8 +1657,9 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = 0;
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics.EnergyAcc64bitHigh << 32 |
-					  metrics.EnergyAcc64bitLow;
+	gpu_metrics->energy_accumulator =
+			(uint64_t)metrics.EnergyAcc64bitHigh << 32 |
+			metrics.EnergyAcc64bitLow;
 
 	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B866C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D3A64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D3A64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D356EB95;
	Wed, 24 Feb 2021 22:22:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4D56EB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWHRWaEAHjqXAk7asGs2ZNgxtqFE6/Ea13bZ02O0YfpemyUmWmnTJpK8tDWSdKnVzkNCiI71RZ/xrrsjQnMk6ff2Zx3CXizZhXe/EbY2EGT97ZSIyTPn5mvpMJFos+2WACSgIu6v1v+OQF3rk0zv+eBDvSJ90wlvTxW0+nphD7z0cMVKcNVZWkoshbkY2BVPXRnawXHtUETMR0vCYbFqIVA3m/cigCArUkeyntntf4YSeWWMIJ8eHBwybaRGHRrxZUMlVyFCUDCKf7/QCxYJwWSvyKMmrcoOuMsgu2mB+4ULiY2xMEIaxUOwARE43YpCK7Xtte1/3nCpD0wBkN58AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLBSRBVAtszWU+ZmrjqeDav74FYpLO5MAw0WbcUvvIE=;
 b=YL3zPn9UAtM7ngoaM6wFxcmclCjm7+9nAdNdlxe/jqX0lzkyqofT8IH7kxVWVdiRESf2HuWa6gsmZCkp9S50TtXEtWEPBd3Gp5o4Bf4ZlvkojSY1j3Ry4muJgTuNqUy25b40TKyGYH5Mpft+TYfZ0S1n6lRdSSwIH5LPTEia7o0iQ8Pacs9SiQ6hXvDIDTqaB+c4y7MOhvkU0Xt5PgzReLoORBSBEcnZEZ646T9kc3Su6e4oW9Lfd1IF0RCJPmLQslYrLTqdLAK6T0pZWGJok5eHh8d24idxF6C0HmTW5Pg+1PhsqHGmzISl8xt07ggclk5XBh+A9r+APRJLQpL7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLBSRBVAtszWU+ZmrjqeDav74FYpLO5MAw0WbcUvvIE=;
 b=KDcFTTbSAfmKOiFo9tRFiTqelfcZz/IPSUMC66MT66PYse8STYrJdlMaIiMI9xq9WyeDXHpwkvEMyk2xGKlEbgtQKrwAFcsjM42gwyQSRVM4EXQQHo/VwO2Ra1hZbfnNf8+1qmrQtOeo+hlCJ5wRPE7RPPUA/wLwNUrETsPw7VE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 109/159] drm/amdgpu: add mmhub client ids for aldebaran
Date: Wed, 24 Feb 2021 17:18:09 -0500
Message-Id: <20210224221859.3068810-102-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70f7a392-67ed-4d7d-8333-08d8d91269ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798BD619D822BC3D675F183F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jw4iodhesWmiwFqm8iyfnmyNFt5oHLYjBrel2ZqIy8Vk1iNDv0XnPJIZF6GpqET+KVLiy1gCaUAgAfjS6zmCmEqJ17TtwHE2x5vTsNDV29WxqqPme4MchbqDqUKSmhX8RNu+e30PdQ1LKmiHwgJMHpZb8Pl9YZXI2uo07OGE+GQwtNAm1/TvUCk7TxApaBPXIIBbo7cTWM3mA5jB1YjMLbkKzKlVK8Wjeeq0TzudWHo452hurgRqkGR9kiMBHF7shQ8u8LxiwJZKXvK7iAChj52RvJWDN1SNvBAU8L7P5zP0gjmxg4D2ZZrzWulRFh4ijhz2f4L+oJMY0y8dS/c20MEDX7v+FoerKR+i8GrtGdhIIpJizKBWkAOiSWu0XAQ4Sg61guFCinPS68pFExe/nn9qO1XlJW4H+agi6TFFjJXHCKeSRRBlQG+cr/4eNSUzKp8Gzw3cIbHeZQU/PIWNIzA0INpAvBTaQ9L+LlKc9MZ4TUzvz75FjiqzLxCDf0QPYMvIEE5KQRSoDg36VczO+gSqBatJDmT3LXPtdRSkjqUDCuHUu5EevP/smNHMRrYvd0qSaM16kpOsoAgEybKuSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2O60SHogteDUI462nk1yERwl7pfrNsGmLNFNQkf0xm/U1KTAD0lP3I4HGIgH?=
 =?us-ascii?Q?g2S7FzKDbQmY+k1uuNBAsVhY1rnuTzNinvqWP+PJfbLZIz36ytqSMkZDKO7t?=
 =?us-ascii?Q?oGoR9wWzvrqpru25krHbT7iR11QVrWE/2Ns8M0E/2S1bybIV4M92Rv+RkCxt?=
 =?us-ascii?Q?33CMk6tMFRoapW3VJKJ+yImpWAzd8j5tYDIFtbn2CkJM8U2OjwU+0lOnhKwM?=
 =?us-ascii?Q?gG2ubHb7bhBUM3nag7yzW8o4vwllc7tozEopz9VVGRFKR1YVYDKkVYpPDPlH?=
 =?us-ascii?Q?63tO8GOf82KSf1oJJfFDsYFmZgTeAlHT92/o97UoEQy6pw2+ele4nMnZ7MRQ?=
 =?us-ascii?Q?WZmZCgwAPFqcscz5ZhZ3rw/bYkLbwTDhJ7tzHQFe4ma5Q1nCKYf17r9aqp/0?=
 =?us-ascii?Q?os+uT+0zvsPPbgPA3hEgu/f+RgcGlQ/FQxPanUdO+W/dQ12FpB4eWrGUjlcx?=
 =?us-ascii?Q?xvJp/4b3FLth6oc5tpQgEgDKwj9MD/lsU6DPJPf14kkDysYLsKiCMJ8uuizU?=
 =?us-ascii?Q?wpP166ERXJDWtsb9LY10hKkQSPvf+vzSYlyvl+M3iNgplPi+zCEAK5PCgYXT?=
 =?us-ascii?Q?4tlHmSwnM1eu9cvTOirTYL/qpNj2aeCl3mtGFlg+2beHQ6nUk7P4DYbbRNys?=
 =?us-ascii?Q?rr9PTlN9mMag6Oe3gT3zOF8SlYX5/q+oLnuDGEFjzFjOzfKOmKoK6SUG/1RJ?=
 =?us-ascii?Q?sTuXYE71p17tUoW/N7Xe/zphuQodI8LMT3rvccbgGHczuhjMB0zaxyEe1qXO?=
 =?us-ascii?Q?1W3prMoxcQpnAG+M4e3l+VTlGKyqi18BgLfD8KNuJTv6rOZTV3IEDLFU3qT7?=
 =?us-ascii?Q?YB4/JMhAF/CUNaM1YHV9PEWz4lkLzUd8n0A48tdtZMFTcQrENxAmhHd/dVv1?=
 =?us-ascii?Q?yvdK6eSUGmxwvFzazWWBMhK+GxRuYLgbjpsVOzO2RAiYpduy3j58O8FETzRi?=
 =?us-ascii?Q?Ec1lmOybRH+AJ5MDlWCcWe+oZ8RmxR4dPdcW+7IHo2ZIOGsGr6t3JM12I7os?=
 =?us-ascii?Q?sprGP/+tynhliFageK2B1w6b4uFOhX6tc7OEkDbK0r0bEsHpSaS7Chpsa2SL?=
 =?us-ascii?Q?tEkdobHojlYGY82GwXYEADsriP9QPdx41Y4ejarYdE8VNbkH+UtQxfAfWAX8?=
 =?us-ascii?Q?gpk2Skgvfj7d7OT59YMOemh6wK09LxNR+GeExTNa7t8e7M1W2Wp8qYPCCWrr?=
 =?us-ascii?Q?y3vnYrtEiC6fCx+sAs1SiHPZFEHX6E1bkNVr6ZwdJea1exbXvQoqGMq2pSFm?=
 =?us-ascii?Q?SeCN30b3HLaANBI0kNig6Iihe86z9ZQ/cJ7tnYfFez/5dBGOwspQA6Qgx0aq?=
 =?us-ascii?Q?25nsWelU7nrm2G07AuEZmoUj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f7a392-67ed-4d7d-8333-08d8d91269ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:38.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKwEFjxKXs72ko+dZzaGbOYRt4rdCrWDX7t+26MKdQ7MZAVpZIE1b6LTSCSS9s/o06Gfv18+CYPFqWolkhgazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the mmhub client id table for aldebaran.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b25ed18a1fed..e7efae0f98ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -280,6 +280,44 @@ static const char *mmhub_client_ids_arcturus[][2] = {
 	[384][1] = "OSS",
 };
 
+static const char *mmhub_client_ids_aldebaran[][2] = {
+	[2][0] = "MP1",
+	[3][0] = "MP0",
+	[15][0] = "SDMA0",
+	[32+0][0] = "UTCL2",
+	[32+4][0] = "MPIO",
+	[32+13][0] = "OSS",
+	[32+15][0] = "SDMA1",
+	[64+15][0] = "SDMA2",
+	[96+11][0] = "JPEG0",
+	[96+12][0] = "VCN0",
+	[96+13][0] = "VCNU0",
+	[96+15][0] = "SDMA3",
+	[128+11][0] = "JPEG1",
+	[128+12][0] = "VCN1",
+	[128+13][0] = "VCNU1",
+	[128+15][0] = "SDMA4",
+	[160+14][0] = "HDP",
+	[2][1] = "MP1",
+	[3][1] = "MP0",
+	[15][1] = "SDMA0",
+	[32+1][1] = "DBGU_IO0",
+	[32+2][1] = "DBGU_IO2",
+	[32+4][1] = "MPIO",
+	[32+13][1] = "OSS",
+	[32+15][1] = "SDMA1",
+	[64+15][1] = "SDMA2",
+	[96+11][1] = "JPEG0",
+	[96+12][1] = "VCN0",
+	[96+13][1] = "VCNU0",
+	[96+15][1] = "SDMA3",
+	[128+11][1] = "JPEG1",
+	[128+12][1] = "VCN1",
+	[128+13][1] = "VCNU1",
+	[128+15][1] = "SDMA4",
+	[160+14][1] = "HDP",
+};
+
 static const struct soc15_reg_golden golden_settings_mmhub_1_0_0[] =
 {
 	SOC15_REG_GOLDEN_VALUE(MMHUB, 0, mmDAGB1_WRCLI2, 0x00000007, 0xfe5fe0fa),
@@ -570,6 +608,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		case CHIP_RENOIR:
 			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
 			break;
+		case CHIP_ALDEBARAN:
+			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
+			break;
 		default:
 			mmhub_cid = NULL;
 			break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

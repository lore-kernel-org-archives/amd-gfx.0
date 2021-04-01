Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A076136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A076136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FC46ECF1;
	Thu,  1 Apr 2021 16:46:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F3B6ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZbSHzg/64g3tfUHHfqFLiQGDqBsIcjaDWTIY1fs99Jw2GjNyPKRn3vmyt4ZQ13hJziXxnJc9MWjp9NcGd+YfuYSh3OR94wBKUdhNevTZ2BsE6caKSs1m/+XgjYI/KZk87wfKKgwjd9/LJX5ZSoRMLQM3fOfVrXkMKtne0jeJn7TSqHKO8c8mKKnWyt51OSXnvjLva4Ms7ZrQV6uRZSFPjjQfszjuvQZfqz/WhNFVPmmqzVeamDpfrEFADeaOU+xebzYErGPNL78oFxZElPh1RjlaHQ5SBWOe2R6C/RlP3KCeIAwRCCx+nIXIDJGN2vUX0YhA74gRJU++TepRTE1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaumSRxOdGIr731L3r1LgNnFsKlQT2PWja6Q/xoshSY=;
 b=fW6jFkEcoZoDf3v0v0GZzmagSvle0S/6dr0WKHNfjJ5a5Dtk+NAKlyIAwu15f2Hxj//kaaP0lDGPe3IIBR5ryNUsTbvDL1YDjrCz5cVJm+djO7aZkm6DTN/Ce6CW+diiqcCR7aVPxg8c650dhbnPe/kjXyQqZWpr8jNZ9Rb4keQ+ML8pDB0xMhqwhrc0M4WyZaIqrcRDhmEJJ/bXMTmYZQpxLmyjRUYTuFcmo46/1QijphJ5vomapeZj/Bq48Vx7R1p0IjT42aQv5Tolm5e8jdYTLnXtcXa9mIkm2Zk9AiIFVMlO/OmvJUOzAJcRfEJa0L6pmgNcR58AKCFufoB5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaumSRxOdGIr731L3r1LgNnFsKlQT2PWja6Q/xoshSY=;
 b=Ev2d66lGAb9ESogYwWUkfFnaLOZAImYUasFU6YvHRochp3/KTCogMJW0YuqXd2WY8iMGcgr4CrREA4KXOVOczLVLJ28VRkfZUXZjEHogtULY42Kw6Nspdh/xmqF/nuyNcaJC94u8L3E7xxobfrIz76QZHwAZf895AEM9YdvnLpQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:12 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:12 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/21] drm/amd/display: [FW Promotion] Release 0.0.59
Date: Thu,  1 Apr 2021 12:45:26 -0400
Message-Id: <20210401164527.26603-21-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aeebf7a-7012-4c33-6ef4-08d8f52da852
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114879BB99440DE7141AAA2CFB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kXwKGXiFjwmrC/GoMbI+f9bs4z8szHjbiN2e9nkz/pfw+J3jwuh/sur0CwoXvhFDCUhqrfJ/oeAWSr3lKO6qnBszaLzYnpv4V5lRFSi4YEv72kyBAxkIuDZ8hX+sks1jK4M94mvqWRXW6AdBa9SCmwezXEQN1nN/JNA2vHUp8cLqZvxt/Ks3BWqCXaoeBlSTwPiOoyPzCCZU4+i9pqNW95UeWzuQGd6w0yB0ITPM7FSBiMQmPVOkwceOdoB42zupOh609Fz9vrTnqJPxr+Aubjd4QcTuoNHq96en1Znp1TIcMVE3QWz5DM3GoQ35TMUtc4qG1Obqm8nZAqgCbGYd8hZBIRCY7a+mUFAG4/g+I2zUpY6GWEI3GPifLtvCwYglJA6CGRNXjh1OwhtG72dqnghepVTdLzJHHTl3JWZquJCEBZPNBMwnZZKDjW0L1FZ8AUnue0DCl/DiDb+n7vYp/dHbFjndMDlq7ii4s5YnG24YPzb7GFKksO9rvzfBlySSIKWJX/z6V5rF9mUeN6isIui1pBc7P9HDXt8Ig5c5RrlL3sSBCigANZN/6Ig6H36xxmd9AeJEW9ZRWmu2RacDTlrdjDv6cHhwRnYxFYKXHGU88ZgQdrnqe30xuCw4YG2E2u2B+n7o3bFWOO5YOnYwkEO3x+/GIGO+7rOY9Gz3fMS+7OVYpOt2APdxSZBkgBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?abdp6vtKCCqiSIvnOiD7ppVUnmPCdN/7AV21yI9epdcGLbDUq6nUqLLmFxIM?=
 =?us-ascii?Q?QrwlXdQtUdL8Vb9A3IOdWIKYZPUlpbb1AMXItvWfy0uHyo63cZFmMZRWvzgh?=
 =?us-ascii?Q?Nu2VrgxZg1hVx9HadGDI9K+tYqXR5aE7K/bM8WTk8Pc+kfiQYwcbqYwmaEHH?=
 =?us-ascii?Q?JQSAlhx/KtWFZG6xmCuglNP+tsGv3ynHQUEibWXk2mn4eCIRNF/PEEnAhmq6?=
 =?us-ascii?Q?YMGr/jix72NK17oflgN9tIJJtl+UthclGrHbpxwf+sXZ2wkNFq+I7o8iI8pU?=
 =?us-ascii?Q?GZoMJ//LHIbFSaZX589XW/z9WbacRK6g9wrsQdiD1coGxSQN0YeLcHDbfgih?=
 =?us-ascii?Q?ACXeI9r7CybjBtsEQ+cTCLgweQVOnfI3L1bK3nOV+BUxtiMJGeD91nJvGZS+?=
 =?us-ascii?Q?FZByiTJRRgozqliWfIWPEO2SQKEOzOwnxZ7zjBWredqTXyDCmIAsn6chysYL?=
 =?us-ascii?Q?IE91Kiz128euOrA6db6wHuUQZwQxdtXW9/7Vogu/h4t36CoUHYJSIeLZEODb?=
 =?us-ascii?Q?Q+pOex1QqfpeoXit9Q67N1nP6+1281Ipgjt0faOp8Z1JwJ3EvX1roO3Y940X?=
 =?us-ascii?Q?xs5rHfuw4XfqPp3Uy6/ST8X6/4+/LKT+L6Mfso0GanaPLQVkKJad5MHOxsyU?=
 =?us-ascii?Q?mEFUnA4XRe6aU/A5+WZ5vClJIsfZ1KakhES3HITWGToULk4JJTvv+zwJ3VJJ?=
 =?us-ascii?Q?dJ+RreaQcApPbcSznGXsOHW6jDz277N5ZNtdGQCd0rzXU97/yKEiuWLVTxc5?=
 =?us-ascii?Q?Iq9df7UUaQBVLHliTu1ihGa9pwPviWhzmVGI9fHGQR86lIYg02oEd/01cqra?=
 =?us-ascii?Q?+joQVMi09oe5Vf0B0GYCoz7fyLB92pgok3DVoQjU4nWjeEZvvvjt27s2tZr7?=
 =?us-ascii?Q?7CR9Rxwa2XKf2lC8F/JhdKpbMQdIY6a/ZLUvyCoyayTAjusgLAp3t7/fxsHm?=
 =?us-ascii?Q?ogkSH+EiQFm9hERMW1rDWKbLvSWhsYdRl9NB1lnday4ehhKI0PFoIZap+KSn?=
 =?us-ascii?Q?m+HDofvFOI/rBCpU1XrFOXiSRcOc6foKo5Wf4GB3fPuwmiWf/ynRBVQ5Dpsj?=
 =?us-ascii?Q?h4h4FAkbPfR4pS+BBU+uidZqJjbXYDyxcdRoF3/zoyYlYsCKGhE42G/HtqHj?=
 =?us-ascii?Q?qBN4XChEPut3ky6YJMetfwBSP2WMF3q1DzSK7bBs9lMWBhix5Z/bQf9en631?=
 =?us-ascii?Q?4rV+zNuAXfpMFvna1ULuRQCQnKW3GvGcCiDg/f2z4jY9VQ0AIP+E6mn9KYNx?=
 =?us-ascii?Q?PyxvBL9B+vvUOxfSOE6iivyYbu8vUh0HncMAy0Hs6EO+2m7j5qdAvzoxqcz2?=
 =?us-ascii?Q?2KXtXUOM5rVtw/FkZBusw+lj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeebf7a-7012-4c33-6ef4-08d8f52da852
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:12.0722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gktCnvjvXuKn3Ut6EW26WIIEHXSaoNbXZ5ESXGENo4Pmr5BY/va4zcxlXE0pKaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[How&Why]
add params to send FEC status to firmware

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c5776a55e2a5..44003836fafd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x8bb402f5a
+#define DMUB_FW_VERSION_GIT_HASH 0x7f2db1846
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 58
+#define DMUB_FW_VERSION_REVISION 59
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -1229,6 +1229,19 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Length of each horizontal line in us.
 	 */
 	uint32_t line_time_in_us;
+	/**
+	 * FEC enable status in driver
+	 */
+	uint8_t fec_enable_status;
+	/**
+	 * FEC re-enable delay when PSR exit.
+	 * unit is 100us, range form 0~255(0xFF).
+	 */
+	uint8_t fec_enable_delay_in100us;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad3[2];
 };
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

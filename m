Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C640C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D397964E61
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D397964E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7496E045;
	Wed, 17 Mar 2021 17:14:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A9E6E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqoOsLpYX1MGZT0Y9X+M9EYIpUYKsdsrVePyaDWUmlWQxDfierVCxJqyhrySCDy19exT+Y0SJBM4jjHRob7nfQxVTfhxKsv+/XKeuzyGMgGewds0uxA1eSWzzthVMqUv8BOkvmbRT+IXWmjF0x3kQ4HBHPNl/inPlSkxI6YRQJZ8SnWEgK6I5aIGRttdD7r/y5+2jAfoo8AbczJ6ftUBsMv1ocVKq9wBq08KxJLkLREAiVxyMHmxPniZfdS86C4CIltPqwtgt+TilQBdyRM72PsGiZS9xmGKkQOPPf5IWWQmBf36VhVtvjJHe1GqI37YDVNWLTvaf9JA/UNsWsHdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FELfbYEGeLaHHsE4fDtF+oWla67qaFJGsme0jT/jMgo=;
 b=FsjJHf/atdw4ZJT2eUTsyKJQMKLLFIt5g9ZfzXfdtEhytWBe5F5gPbI82X9Slu/kUVbD3NeibYDLPbDuxOtJD+d3I47T+4ZnzBGhez95xMuvzQFpeWWmv26Eeu5vIRBj5G4IpQq0gXcPhXj7wZIe0gqyrOAzeUtJ+hIPAyrptCFnEPvYyLOeZhlgUaihdzw242SQrgy5WGaP1Rvrxmsp/R3HeiJ4nBd2wSAq7PQJ8X3VpH+UfUCPrSrRcQsvITu2jCJvMytQ7vW3Isz1e0cRxxSmyNPwmfHSLTBUBXB8o8zbKAO4UhBGfN7W6X5P+10AbHtBHIBK4f2sT7vcKAG5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FELfbYEGeLaHHsE4fDtF+oWla67qaFJGsme0jT/jMgo=;
 b=v/eP4ZY6czlpl+AfQZxA0DK35XS4MG59ncGfTPfRzJXBTLD/hZ4XnCz/kmlcdCEPZPd8NT8yAY0R38SSEL3q9lq2NV4u8tEivLIOdjw4bR9Br7HJ0K1IdxU7uIIFsSQYVqiNoKyYb2xGIpnLRyaqczkU3IAnUUzMNwHIBrjUIbQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 17:14:54 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3933.033; Wed, 17 Mar 2021
 17:14:54 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Remove unused calls
Date: Wed, 17 Mar 2021 13:14:42 -0400
Message-Id: <20210317171442.11344-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQBPR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::20) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YQBPR01CA0120.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 17:14:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7bc8ceb-fa0b-4d59-2d10-08d8e9682e8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884A4A125E6D0DFE004EDC6FB6A9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDIEefMS8zpovQ22uGWHOqqKW5tvTeGVnIvLi3UF2+C05dYzYCtOV03hAFpZrAXI3lBzQbV8pd6FeTCUAd4/JDIt5PH54+APL0GPoppSfdhyMTeQF25Y8ky29KLJC8SimIslxvBdcbFJjY+X3Rq1ZeTQjK0NA0pYsReTRVSccwGddjourvcocOY1GY/SkFyAg3AkERzZyZzBruSviw1wC/YmEgtiE2rhE/gVGOC1I40lUE3ua9ogTmecwOdzEO68v/GJCWn9jmApuY0G5vkezHDnGc1DFUc4Z9kJTphirr6NtRE47BXQmxx56OdoQSP0/zQ/WDgHA8rKnhJq8xAdES8xbdeCIwiXPryf8XLwJ+3MzzuEGZWhU7aM0FHwlMWXo/mgnJtS4fOBa+NIUUelQrKtitFKfLBYbiXiMxOrIoUZRg0Wa2T1KFnTh5zjlhzFrLjOzGFsVgxM2GiIYXrMiYWf2sKVA934oCY3/qUCnqBmLAZy3k+wWMVkQYVRPXmYiIo63VqWxrbV0GyxcUwNC6qNopmkszeKxfcpYCV1zi810h3JQeJd3KOVHzRP7uCP9CMZo49epBZG3rFenUThQCWz9xMhFD26GXJ/CuzgbyG7K3AxW1IgUI+BpxXOcEym
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(316002)(66476007)(6512007)(956004)(186003)(16526019)(66556008)(86362001)(478600001)(1076003)(2906002)(36756003)(26005)(2616005)(83380400001)(66946007)(4326008)(44832011)(6666004)(52116002)(8676002)(6916009)(6506007)(6486002)(69590400012)(5660300002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?17/+WzL5hpzNEuUNLJrETTqwlj5IUhToJIMlfuw0MexuH3a4eYAn9vKqeI0h?=
 =?us-ascii?Q?L1YXh4XHOi29SYBIMMipw93uJTuc2klGJkYBMZ1senHE/jI/oYy8+GiP4rYq?=
 =?us-ascii?Q?clBlpI9/d5EyB4mMZH9sfwngzl1n0hbmspDqiMQww1B3CHgctLHjjV6xr8tA?=
 =?us-ascii?Q?pF4eI7AjPeTeQYY/YlNQQPDDmSvDrKrQryvT+ozCmEltWx4d7+fYttAM5Y5N?=
 =?us-ascii?Q?RZcN+WXHpR3/iUxK0yBcm71fxP85pTmH2+nNB3Yg/jAbwI2FR/qAXcS7/FMP?=
 =?us-ascii?Q?4Wnd/24XqT0eBPMTDLQBIR29fkOErJ98ULKQ8zCFuZR/geuBvhlmKN/57RLN?=
 =?us-ascii?Q?mDYMejit9IqkkcKgZAI73nKI2rhCxkLoDAPfkCYxgvOhB8iZpMGvkR0nJ4BE?=
 =?us-ascii?Q?bs7lrg0F7arrKdGhMhB+br3nay4GDRs6Y1A4YuKemxwDixvuCs+mCzxWFHib?=
 =?us-ascii?Q?hPYR7eCCP2MktqhBv7xoR/DEHWRBKYSGNhFI1KyRBmAuTYTH5FeCeFaN/SlG?=
 =?us-ascii?Q?5HrpfdLzgzji8ZmHdB1Wrqk+jfp5pQhgMm0281vgj32I37waCgpBidSw59vp?=
 =?us-ascii?Q?bTknDwnXFQvtuvxusIZyuE+TMFC/cRlUXnUea4x+teE2MkLNEg3cWiO411+P?=
 =?us-ascii?Q?SbD4wsw3QXZUlqtDpRUan1BoO9mytg0yO+IaPO5eApDmUCbBVP7A1XaMVPAa?=
 =?us-ascii?Q?ZGTdlzij+5Tv+i7gpdcs4vWl+s0LLaPE5UdTkotb0rpvEl8xkt7QVxgN1xaR?=
 =?us-ascii?Q?SjHpZxf5tv1rJQOGXTpD6i543TqF0+eBoc2ockRCpoyF6raxvIcNx2To/mMD?=
 =?us-ascii?Q?NFFcWGBmE9nrdJzR0jLF7oht0FhboTAXH6sV3qixNhj5C0dkEoowNLbPYNwY?=
 =?us-ascii?Q?NEztV554agEfy2hAT17tm4cotFRto/TYQBT0/kGWEhVVF2EaySCsmKk3hpav?=
 =?us-ascii?Q?WMs0UXeYtntqYpkZNp3jHDw4lM4MwFRfs7n7aJtLUPgjSE7v1xIqpKLCD2Jv?=
 =?us-ascii?Q?+3WtOM8BpegJGC4S9BW8yvfZNJAxosVdW8HAETKbEQLriGn11wUi3I+NNwTg?=
 =?us-ascii?Q?8wfIch7jwMlOAKKuIwq9d2vtBKJLxDeWJbSRd0HK5rCsKy0KZs1sfVKOehxp?=
 =?us-ascii?Q?zUKL2vw1SbcXRwTBYtQ+Yk5IofFClKgDzy3SFj0SNwh0ljPnAYCD82d5DRJ5?=
 =?us-ascii?Q?PJ3eL1B+GpBZRYA84gsidGVrHrgYmLq+0HCmBtINweoJrKaF65Y16JBQYdd0?=
 =?us-ascii?Q?ouRlui67uxQ1H8jDOTePRb7HpPHKyoyeZ6U6abQkwDZTzaaSshvkELi63Exj?=
 =?us-ascii?Q?k6uLfchBKHm2IWycKjaFhWaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc8ceb-fa0b-4d59-2d10-08d8e9682e8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 17:14:54.2477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k57EVLAAcgj9GBGS7zwaxQfHJb2ZsvWkNjz+8H8QNcVioZh27LluRnE9jR8u48Ee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dmub_trace_int_entry() was introduced unintentionally, causing
compiling issues.

Fixes: 53e9c0f651421136 ("drm/amd/display: Support vertical interrupt 0 for all dcn ASIC")
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c  | 8 --------
 .../gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 48a3c360174e..3908ad929176 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -278,13 +278,6 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
-#define dmub_trace_int_entry()\
-	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
-		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
-			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
-		.funcs = &dmub_trace_irq_info_funcs\
-	}
-
 #define vline0_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -411,7 +404,6 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
-	dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn21 = {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 68f8f554c925..4ec6f6ad8c48 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -276,13 +276,6 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
-#define dmub_trace_int_entry()\
-	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
-		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
-			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
-		.funcs = &dmub_trace_irq_info_funcs\
-	}
-
 #define vline0_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -405,7 +398,6 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
 	vline0_int_entry(3),
 	vline0_int_entry(4),
 	vline0_int_entry(5),
-	dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn30 = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

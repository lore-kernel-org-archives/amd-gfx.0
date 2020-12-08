Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B7DC4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5863A23B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5863A23B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755E96E9BA;
	Tue,  8 Dec 2020 19:28:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC8B6E055
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi6jtzv1W/N92Mtc56Mq+MTm7tbkIbeWbZxH9zRiqjR1y2MLXsOO+44RRxweujRCvri0X1MlwnvSaW2jeV2ks7tIu00XU5Jrvv6FVui1kdRoQiYeJRPI9PSLxe8A9aWQ8S6lZerX2K2PKRz8I1rA/yTtKi/hw75MAGKQnYdbo8taoUm7hsF3A/jbT7G9tqPpDIn0kh9tYvYvytfqgdlW0msivhp962spa3XjDfp1WL7n/HsE+6tTApsXM0A5bAUC9U4LKNAsVf8B9Ht1qla8PIPLtXOVcAvUtU1SesiIS8hFfL+YoFCKugi6sE/Ti9KrjHzXZ6WQD7WfKEAEIJuM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMU8JZgzqUz7//BTUM7egmUQdGZoidwbK1Xnjh9Epco=;
 b=BXgh3O/eEJT/cAYP9nEZg9ma7Dcv9Pj9U4mYHtgYFIzBsXtS0+kKbxWBD+e+qxeGXTG7uV+bGgwnu3DQI0YgyGDb0W8eOPxwNWLo3ICmNT9Su9P+CTSiooC3G+Es9CotqUmqAT/xOMCd4wXyt1/6FktymHKX2aWw4qc9Gr+YwZ7PhyhRFuhtWKr6o4WtXD5FaoQJZqpG0qvZSM0IcQ5hPskokWD2wj+Ur3Rk/3RLbzHmCRFoOOiqbq/wJupLIgtdQV7Lo6uFNnanvDDOdbvPRG1+oILqjajRzNAoIwAnX759eROB1pdtGGIef4kDXEx/LUm8x2umQbSHBJyMitCaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMU8JZgzqUz7//BTUM7egmUQdGZoidwbK1Xnjh9Epco=;
 b=SblmB5bHi7tOtLdzoj497rIERIgFUAi58sn8IZnBgsrrZ9krnM+r4ojM+VqVPhyIUYDzBIkvRpdh/I/9+ovUaYoC9RqiBdPxyKasvsQlYPf/3ZICVW7beiJ1PRQ+F+oucWeuMrXZRdbLylWEC1jDneNV7w97Cg2JFijW7g9HqdM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:57 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:57 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/13] drm/amd/display: Add missing DP_SEC register
 definitions and masks
Date: Tue,  8 Dec 2020 14:28:33 -0500
Message-Id: <20201208192844.23580-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da723c83-ad09-4120-9bde-08d89baf81c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB438882E49D0671497DEF81AAFBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+cf7QXRK8cwayqqWi0z7PicplalDEQkYsgVFBeFif9rKNta1gE/9iltsLVNXHD6OhIVn9MxUX86Yul1kN1ujNmzLzOLYMdJg+WiXTRGXRzq6qmEO3//NXK3Jsh1LAN8gMkqp7PcR5bpJlYE7BTz9JURxsuzzG17N3f3UTI4tepUdiuoNH01hIgM8I/JWwyy8fV7iUB/ckmDQwG1mT0BdjjFoMf8a94dMgnBfNO51+jbwF+t9yC1UsGzDpB4Jg05wKH2cOeH+/YoMJJ4bvT1OiEhsNhAZQdxaVmm20EcnhhYKF/7W+lCt2ODlL7tFafEZfSLHMIbHTdvB/1qI+vziXdo2IzMgY3MgdAgub+Lq3sfvdAx6pSk+1qa6bWbFWdh3woW0E53zYlZQBY6VcTr6gedSPRcH/WblBjR3jKFyTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Oq1z6nItOPV7jvwOn3PCCgFTnWi1OjdZbItkWShNgm7s9DmnCpUwJVoK6d1m?=
 =?us-ascii?Q?dGGefXOicFnVJvRVgxlQDu7GqzaIlowsI58bAmlMLi+Rwy5LVLjrvXGJgvsW?=
 =?us-ascii?Q?6MUMAlMeErIhwELCUUApddcp8zTZGwk+hF5iEvd9TtNdrhI2kvPrv2e1vta0?=
 =?us-ascii?Q?AIl4qVOM6pvOMCmXAxCPmn99zkPw7woTTYXNkCdO0+P26omzSOIxruDuWC1t?=
 =?us-ascii?Q?xETfDUQp9EZwAt2BBvIo99GPtKn90+zYWBuc3dZpzekte3az8yE0O2yF96BL?=
 =?us-ascii?Q?t0opYNEdVVuvUWPNi4SKtmzLBc9HdOGdIv+aVEfVgbDhVKnrURoVIiIPBMMR?=
 =?us-ascii?Q?fjUw/jdfD+2j4mMe5aVWFg6HJGZJlbDrdWC/kVipFzUIPd4q0O3OS54pkJYw?=
 =?us-ascii?Q?B1epi/efsEcI3R1NDfSl5GelmrnANMA++i6RghhwmG52uiU1G6hKLoJGQUNm?=
 =?us-ascii?Q?9yW0O0/sZZo32NJrAXe+KA2fRw2IG1VgnFDMiWsFrsYBM0v4/crfY9cBlUcJ?=
 =?us-ascii?Q?lHzbVMiOvhk7byH/eEHjlSX77M4uCaoyGZas+Jw6igWVWh5H+vIJTF/D7bt4?=
 =?us-ascii?Q?CxpVkyhGgNymwcMs0u6vdz+Vy8xhr/vq4/H/EuOROIf1iWJ4gZyHU/dJUmR6?=
 =?us-ascii?Q?rIcmmarXBiw49UlY6IVmIJvU+fCHTLQqEbkpwEoBr7NejuSc+oDb/+TYQvdI?=
 =?us-ascii?Q?t+n3Cwod1W0L2TQ7Ao6U79qaZEGcmI7TNIGMUNKo4yFGEJ8uUC9YsF2whlqF?=
 =?us-ascii?Q?fboyEpOB6J98+4KQsDQk/44vzGYUmIrz5NvIBJZoEvriN+ZYyfJOz198112Q?=
 =?us-ascii?Q?f2EsLNXIF1X3e0ULf6yNcEjla63VrU+6og2/CWsWIFPSaDF4X82USsq0+pI8?=
 =?us-ascii?Q?mRXh6l7VNjcmraNMtw8objDHRGFXe5t0+XxigiIcGiYZ9/C+KdTy6DKEqP+W?=
 =?us-ascii?Q?vXd8YVbT+QBpnQY4dV8O+J7EoAIjycL1r6yMC4BFmY1ct/z4owN59f5Ow3DC?=
 =?us-ascii?Q?bDPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:57.0221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: da723c83-ad09-4120-9bde-08d89baf81c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETsNZ7Otg9ktXMIt2JtTmZdFgwSQljH8LKFT5qRCwGiEwtFSEZ9PnoFkYGyV+4co
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com, Max Tseng <chuan-yu.tseng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <chuan-yu.tseng@amd.com>

[Why]
some DP_SEC register defs and masks are missing.

[How]
add the missing defs and masks.

Signed-off-by: Max Tseng <chuan-yu.tseng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 9e38c37c1d73..76b334644f9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -81,7 +81,9 @@
 	SRI(DP_MSE_RATE_UPDATE, DP, id), \
 	SRI(DP_PIXEL_FORMAT, DP, id), \
 	SRI(DP_SEC_CNTL, DP, id), \
+	SRI(DP_SEC_CNTL1, DP, id), \
 	SRI(DP_SEC_CNTL2, DP, id), \
+	SRI(DP_SEC_CNTL5, DP, id), \
 	SRI(DP_SEC_CNTL6, DP, id), \
 	SRI(DP_STEER_FIFO, DP, id), \
 	SRI(DP_VID_M, DP, id), \
@@ -126,7 +128,9 @@ struct dcn10_stream_enc_registers {
 	uint32_t DP_MSE_RATE_UPDATE;
 	uint32_t DP_PIXEL_FORMAT;
 	uint32_t DP_SEC_CNTL;
+	uint32_t DP_SEC_CNTL1;
 	uint32_t DP_SEC_CNTL2;
+	uint32_t DP_SEC_CNTL5;
 	uint32_t DP_SEC_CNTL6;
 	uint32_t DP_STEER_FIFO;
 	uint32_t DP_VID_M;
@@ -411,6 +415,8 @@ struct dcn10_stream_enc_registers {
 	type DP_SEC_GSP3_ENABLE;\
 	type DP_SEC_GSP4_ENABLE;\
 	type DP_SEC_GSP5_ENABLE;\
+	type DP_SEC_GSP5_LINE_NUM;\
+	type DP_SEC_GSP5_LINE_REFERENCE;\
 	type DP_SEC_GSP6_ENABLE;\
 	type DP_SEC_GSP7_ENABLE;\
 	type DP_SEC_GSP7_PPS;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
index d2a805bd4573..9a881e639709 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
@@ -83,6 +83,8 @@
 	SE_SF(DIG0_HDMI_METADATA_PACKET_CONTROL, HDMI_METADATA_PACKET_LINE, mask_sh),\
 	SE_SF(DIG0_DIG_FE_CNTL, DOLBY_VISION_EN, mask_sh),\
 	SE_SF(DP0_DP_PIXEL_FORMAT, DP_PIXEL_COMBINE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL1, DP_SEC_GSP5_LINE_REFERENCE, mask_sh),\
+	SE_SF(DP0_DP_SEC_CNTL5, DP_SEC_GSP5_LINE_NUM, mask_sh),\
 	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh)
 
 void dcn20_stream_encoder_construct(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B69C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAAF208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A+cjbWEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAAF208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B145B6EA88;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BB96E948
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8TiT8w0JzChJtBAyU74Fp9DPPwdN/Y8K5Vyl8PRp4aWbinJeWj2XLVrJstFLptDgCPjf+TSyCPZLTId3v+GU6f2tQptqcM1GqaNYwOivScFKqLgo0OwBwufQvHz69a/oKZwE+mrtchNSi37MM/h07lAkGUCr8MRyZhhyvu2puz1pXQ3iekEoNXUNwq3WM4S99DziHKfwSJg/8GOp1bytgC/st1sCbsQSszWDvUb2tCvmUIDiIknNDKUqUBUK+ZCsQEx8UEO8Lx+0SUNVaTuP45XcPhI4dCUNkp26Gb8gyUpvsc5WC+GCyhBLA9rFHv0G+4/0eASbUnNNPy4xXZqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9caTOiGBIL1ywwfKyxMiitdw6gBQ8Lag6QSckhuiCg=;
 b=iYUt1p/KWTTdbZbxw++2a1FnGmzyfp2yvjmGyS8c0/lD0mg7t0lRzGekOadx/L3x3wynF9Bl2MZNvBq6w739b1aPCN7185Ya+iH0pCsLTpvSYHNnGGB6tCtRSMkv9wYyTtsxsTdF1aSW74ljCehudvxyNvv09ppB7GQe9C59uWzy5uMjdhMqp0KYNEJ+Wz57uMpBbE5CzmSJj5xhINYHyQh+6aTf/OI5nvXPrPPWX+x90P9gTXyOYX3eqz1Eub/wV2s6szxCZYgfHKtS7Glzglc6ms0acvDEcXyoWh24yhr+NZLpDCHQ/98c0JGw8M6RpwIs1QxrS01cw4yGvvf/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9caTOiGBIL1ywwfKyxMiitdw6gBQ8Lag6QSckhuiCg=;
 b=A+cjbWEMMi0VYmJ2moWMyegwnqLXGlLXnugxxpCyw4tS+V2HJsMCQXblTOj21A6UIxPLjAEVZ+ZPWclj4iwOlsf5ND9tz0LOpUNhrSJLC/BYA/NzazPxMLei9/9cPf4dKOByxcgWfvsN5SccMIW0YShXsb8B32saGTYkSJKA/YY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:07 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/30] drm/amd/display: allow query ddc data over aux to be
 read only operation
Date: Fri, 19 Jun 2020 16:12:18 -0400
Message-Id: <20200619201222.2916504-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:05 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fdee839-2596-4cdd-1099-08d8148d2d57
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40870771248AE4092350081598980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEx28EtK0+T1QcHb802OpbRB9LQ+rtZnruDSvc2NnytBuJQIg9WV8CUfOLeEKeB2ZwnHcuDcmNx7iD9KJq3PVY1fNjSdDkSHJ8D7yxgzbmPgTmbUlynBSU6EK8Mi15zTtjHat2ET1zrufNPuhSp51LnmqnxNrA4nZj+9PEVcpDHy2lT6OnllfK2D1XoT2XQhqejt03U/04JezMGPZH1lAXoyzKK1EcQBzuCHgVcVGU0ObuJttWBJWybyoQDCjvwv1XojN6gus6P8Ri5W8CpVpyqdN31xFcd+IfWDZalCEhAjHFG0u2i1VpoI5aOMYshSKd+6+xqvVLPBIMwJHH6mhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4/ZQtzC+HrPLPnVS3BtfzQtBlqpFPuThLmeradsM5KU/5EbZtSpY2orYEsGUHesolBb9Tb3TFIYgWe5dODrWSEAQSfjz9u2myPBoAzVtnZ7MAGZqeQBQ2I2hD9aXCl8smXlZdWZXwlzIgvpHKjme2d2UUDHnq/I+EjcbUBTgQFNUc9/AldyCxcFBDuy28+mX2SdJZGVGel34VxVC/OSMh2skd2qZ1OPAfEBrYPmxnC9RzyQIn4cMV1+PUd9FH2N+EwTzPuYMz+V3uUjdU+5+jS9KtKstnMirTRmyOyiApbctyRS0G4o5LpsQjWxVxf77x0gzJJO+4df5QG2prdhkqjR9ILB5Lm+6HVKLryL1+ysZtl8LwOoksZq3C/TaOhlX3jK49exU0nGWhBpFZCiLmViyy4k4u9qEkn1l5to8DrM7RTXMrldZHCDxftuZym0uyzxNcak9YJkD2GR1LUmnh/sQ8KpC2D/tpWAhR2fojF1DrDeWxCXNhMsGiWiVB/P3VaHkdRRuuzI+uFv71g4g6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdee839-2596-4cdd-1099-08d8148d2d57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:05.8192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neRjPGxK72QWxXfvRa2wUyo9yrCJnGELyUakVDyUn2F/DtxT6fC802Rf/u38yRkbZAxFRLZQOClY9FGl2Id9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Two issues:
1. Add read only operation support for query ddc data over aux.
2. Fix a bug where if read size is multiple of 16,
mot of the last read transaction will not be set to 0.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index aefd29a440b5..be8f265976b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -503,7 +503,7 @@ bool dal_ddc_service_query_ddc_data(
 	uint8_t *read_buf,
 	uint32_t read_size)
 {
-	bool ret = false;
+	bool success = true;
 	uint32_t payload_size =
 		dal_ddc_service_is_in_aux_transaction_mode(ddc) ?
 			DEFAULT_AUX_MAX_DATA_SIZE : EDID_SEGMENT_SIZE;
@@ -527,7 +527,6 @@ bool dal_ddc_service_query_ddc_data(
 	 *  but we want to read 256 over i2c!!!!*/
 	if (dal_ddc_service_is_in_aux_transaction_mode(ddc)) {
 		struct aux_payload payload;
-		bool read_available = true;
 
 		payload.i2c_over_aux = true;
 		payload.address = address;
@@ -536,21 +535,26 @@ bool dal_ddc_service_query_ddc_data(
 
 		if (write_size != 0) {
 			payload.write = true;
-			payload.mot = false;
+			/* should not set mot (middle of transaction) to 0
+			 * if there are pending read payloads
+			 */
+			payload.mot = read_size == 0 ? false : true;
 			payload.length = write_size;
 			payload.data = write_buf;
 
-			ret = dal_ddc_submit_aux_command(ddc, &payload);
-			read_available = ret;
+			success = dal_ddc_submit_aux_command(ddc, &payload);
 		}
 
-		if (read_size != 0 && read_available) {
+		if (read_size != 0 && success) {
 			payload.write = false;
+			/* should set mot (middle of transaction) to 0
+			 * since it is the last payload to send
+			 */
 			payload.mot = false;
 			payload.length = read_size;
 			payload.data = read_buf;
 
-			ret = dal_ddc_submit_aux_command(ddc, &payload);
+			success = dal_ddc_submit_aux_command(ddc, &payload);
 		}
 	} else {
 		struct i2c_command command = {0};
@@ -573,7 +577,7 @@ bool dal_ddc_service_query_ddc_data(
 		command.number_of_payloads =
 			dal_ddc_i2c_payloads_get_count(&payloads);
 
-		ret = dm_helpers_submit_i2c(
+		success = dm_helpers_submit_i2c(
 				ddc->ctx,
 				ddc->link,
 				&command);
@@ -581,7 +585,7 @@ bool dal_ddc_service_query_ddc_data(
 		dal_ddc_i2c_payloads_destroy(&payloads);
 	}
 
-	return ret;
+	return success;
 }
 
 bool dal_ddc_submit_aux_command(struct ddc_service *ddc,
@@ -598,7 +602,7 @@ bool dal_ddc_submit_aux_command(struct ddc_service *ddc,
 
 	do {
 		struct aux_payload current_payload;
-		bool is_end_of_payload = (retrieved + DEFAULT_AUX_MAX_DATA_SIZE) >
+		bool is_end_of_payload = (retrieved + DEFAULT_AUX_MAX_DATA_SIZE) >=
 			payload->length;
 
 		current_payload.address = payload->address;
@@ -607,7 +611,10 @@ bool dal_ddc_submit_aux_command(struct ddc_service *ddc,
 		current_payload.i2c_over_aux = payload->i2c_over_aux;
 		current_payload.length = is_end_of_payload ?
 			payload->length - retrieved : DEFAULT_AUX_MAX_DATA_SIZE;
-		current_payload.mot = !is_end_of_payload;
+		/* set mot (middle of transaction) to false
+		 * if it is the last payload
+		 */
+		current_payload.mot = is_end_of_payload ? payload->mot:true;
 		current_payload.reply = payload->reply;
 		current_payload.write = payload->write;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

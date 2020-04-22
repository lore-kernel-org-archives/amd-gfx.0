Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F9C5518C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51232076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="joHmEK8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51232076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7541A89E38;
	Wed, 22 Apr 2020 22:08:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66AA89E08
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKH75lY9PTmXhCuwljVyx6bnIGQj1WLdB+rHrkypQjaGZ4dBpbAyP+d8Lq0iTgzjO9Nf7Gp9qgPq0nKiX2ixCfDl7n9iJ8toMKsCv2Fqj/gYO8Oi2LsFA3ptlY0M5kO7aF79JC8EAGiq3l+eDC8Y3Nn6PAp4ZtKsfsBWo4Ws0JHOhsetfgewKsiucZgmZx8owl9423rv5c8MzkuvVO5+xH39BvXBlBbq8qDS0KeG7jobf9sO7copFNI/wCUoXDjHnPmwWexMvw8EmqGwKMzuEx8bxltZ3eIvnpMKKXZQ/pfMZ6J70mnkwGN4+Ro2O5WzL3laZ18AY9GSAbv2NUr9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El8QRteKu+L9XBJPqlAU/M/9jZ1ABdcbqwxr8G4RNm0=;
 b=PigCru5KRppamA0XYvjWWx5B5y1Pt1TkQ8LU6B91u6hLu2el7ELH/N+q9ho9L3+/ynVW6EV/ZkIVKZHHwwZ0s6HAZQ0RPqAObtPUl42QrjpiigpsRZTR40DhqsphE8m99QuvR0omwvIhqxMJaa0QTjb0jdcP818tQAa9mO03V4JdXzyEbXXZMGY1/N08HmVk123k0t7+o8IFlFEOh73e7w9iODC4pT6mnR07bUAL4Vl6mnhIbzBNdtDW6dcsnwuKgX+K9OnKRsPUv5MVwkKaubTX1ZDHnVD6zScmIXnvk15qsZEYFyMTufUbuRaKx4XPXIGwgXqwOpOZhc8ZUlTbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El8QRteKu+L9XBJPqlAU/M/9jZ1ABdcbqwxr8G4RNm0=;
 b=joHmEK8LXZ8bDgekrBUKHqyLdJryYH79EMDX/itBZrDeeuClIKD0M84oo+iOkHr1qm5qr0Z/QS7aCegw5sLCCtr7POb2rFjLaZ90VZ5KBPHwNa8rCOQ+S3Z9RsIyNy1puses/gWbsZHJAiKB6G9AaICL0AgTNxlU85z+yGPPl44=
Received: from MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:13 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::d3) by MWHPR12CA0035.outlook.office365.com
 (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:11 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: Fix DMUB meta offset for new load
 method
Date: Wed, 22 Apr 2020 18:07:49 -0400
Message-ID: <20200422220805.15759-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(428003)(46966005)(2616005)(81156014)(82310400002)(86362001)(478600001)(8676002)(82740400003)(1076003)(336012)(356005)(8936002)(186003)(4326008)(36756003)(2906002)(5660300002)(316002)(81166007)(426003)(44832011)(6666004)(47076004)(7696005)(70586007)(70206006)(54906003)(6916009)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f24bed-5cef-4d1d-f86f-08d7e709a66f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4281774387AEFF2E572E4BF88BD20@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCcQnsO/9dFsUzCI5A4+EfS46NC/jzQHyceyvJ1EvD5MRD+ubV0VKHbd28mt1kiEISXrZI4WNJ+tnAJiKfIMHTMWEHOLqJ4ufxPXlP0Q9wgawVq96RJ+S0NrsJtqirb9wkVXsxCczrTJmi+ceYJJvNs7f/j+di3B/BevNBLU8gf8/MIy/bSaTf8xNyVfLQ8STiVO++vpOjFbeDxxMc+w5jhe+IS0wykT3yWn6j4gPpKgRtbHZpVdtG7t+RvfzZzpnQII3f7RqRtIqrWv10qvWb+4Cde1iP0OWcksiaOCNeEgaXcPiqPCl4cF3N71LmhYHfA3D8Vs3ZyUR8P6k7tSMl/vjMIhiBgXw1YBel3hmShyqnHzo83uyTRDMQoC1r/3rA5ApXjFbaPiUD6XVI5HIPL9N/Hi1BgqqVRoYdgRqWTu+wR5dP3FXL3KWFJcQ5Yh1xP879csvVwg+DyP84asFiIA15q5Cz+iBdrSOlZycr9oAZdneP8G2IB1f3TtaBbdSi21HEhmk+ovOJATZ4fImQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:12.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f24bed-5cef-4d1d-f86f-08d7e709a66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The new metadata offset is located at the end of the firmware binary
without any additional padding.

Firmware state is currently larger than 1024 bytes so new firmware state
will hang when trying to access any data above 1024 bytes.

[How]
Specify the correct offset based on legacy vs new loading method.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 0a1a851741c5..a6e403227872 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -96,25 +96,27 @@ dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
 	const union dmub_fw_meta *meta;
 	const uint8_t *blob = NULL;
 	uint32_t blob_size = 0;
+	uint32_t meta_offset = 0;
 
 	if (params->fw_bss_data) {
 		/* Legacy metadata region. */
 		blob = params->fw_bss_data;
 		blob_size = params->bss_data_size;
+		meta_offset = DMUB_FW_META_OFFSET;
 	} else if (params->fw_inst_const) {
 		/* Combined metadata region. */
 		blob = params->fw_inst_const;
 		blob_size = params->inst_const_size;
+		meta_offset = 0;
 	}
 
 	if (!blob || !blob_size)
 		return NULL;
 
-	if (blob_size < sizeof(union dmub_fw_meta) + DMUB_FW_META_OFFSET)
+	if (blob_size < sizeof(union dmub_fw_meta) + meta_offset)
 		return NULL;
 
-	meta = (const union dmub_fw_meta *)(blob + blob_size -
-					    DMUB_FW_META_OFFSET -
+	meta = (const union dmub_fw_meta *)(blob + blob_size - meta_offset -
 					    sizeof(union dmub_fw_meta));
 
 	if (meta->info.magic_value != DMUB_FW_META_MAGIC)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

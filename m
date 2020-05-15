Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231BFC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43ED20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XG+6svFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43ED20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1FE6ED18;
	Fri, 15 May 2020 18:13:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D5D6ED19
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcccScsxT0NjPqSOf1OxtyB3s1Qv6MpaGpKF+3tzgYCOcajomUmeRUQt0BKpwQLKirZ2x47o65O0C6fBajekuJ8pKVLaQ/j6SCdZRkiJE/6AH09hff4jAzykRHcahj2yWGG/lLYOecCA0Hsq9xCPE8PERexdlWsIt4cjt1MCMNN+aAAG6pHToinGTbwCxWvwFmuJiR+IV+iDeJpsJeawfCfAUGevkLEN1XzfH+neV1PqLNPG7FvXdQNpibIPcoI+x5Ox1GIIL6+lP2UAOYRSkB9LDJ4FDRI0JRX51ZGJrvZJSsgOaAJ2kRQlSUcKFmoeL63whmWOZRfGLzo1CvRhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smy/emq3CFXtCiDc671vMAqGNKFLASl3ZCm6zwxTzbc=;
 b=QM/IXDLFG6edO3uTEs1XePG3FuGxm8I5BXEkTph7gCnB+8l2cp+IFjuaNaS/IjZR0Pi7EjZtABZLPSV7BDWyevVtPfwIVCSDbuawaq25NFp8RNTDNPyb3eNT9gmzulKcqSl6XjNUM9goBG3Mkt2v2Nj6ayhjtCXbiipv3N3xnGLksHi89i8qRof1Id79F28TxPmPeiSvn2cYNeW4OBQqiTPvpg9qsFfmCfQ9xGAKeGfxHpj9ecbaZzhm52MUgYIHMeoTBPxkhhAX9/GZDsOMWyK3xthpVgOE2peBAl4mRqs/dG9ApvwUnIuo9Ifnvh6qfCj+JijbG75GiVKyW2GjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smy/emq3CFXtCiDc671vMAqGNKFLASl3ZCm6zwxTzbc=;
 b=XG+6svFQ+iqzckOUqToWut+v1Lqwn5Pa2qcycSbuu9V20iHf/SV6LL6carGGoTqskrsNpJb+CAOugZ7voK1MtORFmPcn8hvROX36aWkQUTx+9G2e+fh9cxkgLJarwwuPYhJff7drueABL7FSV4+1tGS0EuvHN8/ZHRqSdH0YVu0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:44 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/27] drm/amd/display: Check bss_data_size before going down
 legacy DMUB load path
Date: Fri, 15 May 2020 14:12:53 -0400
Message-Id: <20200515181315.1237251-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:42 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 823586bc-e08c-475d-4d88-08d7f8fbb3c0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39749374E5077655E54E5CEC98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJUhtxr4uPQ48NcWOQuekL0wYciRBcTdx3eNaNSbw1HAmm5CqDgdXg/3c2X8w/qH0weYCYpuVahODk61pBFduieYWPaAsqUcijGWqeoggXW9ie78UDBGC0JBcM7BNbZ6cR8NJhBvwPfF7Nfgzy2+gyOrv+/a+OMkR6gw4p2/nqqIdqtUwMOxVaupBtP4Ru2T2sMm8LklNp5ftb+LNvzcLPhUomIR9JbHzyFmNIGwiWN0i2F8KsSCHJ67zrpUTBFTnh3NFU4NbrGqn2BA556TaUwOcyQLi4Jpa1mOte4/QPqtWH9HI/aVLH1iDcETcN26mxeZnHmdNttRCjdU9P8npJW/9g1dNkUpE9jmvMj4WikkMpWpBv2goijJHDuG7OwzuBP+Q+S9yXYnHWtuc5UxlvKGryt5w71vpiOEMZFEBUyFkUHWZLs2pgsossXUpRg3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: R/2ooIaDG/iCZNL/JD3mzYSCm4/Hy8Hce6PbomtFDcQnO7nLWZ8OERM689dO37jZzDifmFSQrgaSJjOhyX+E2F+AuKdf8DsMh1nhAzrOyHwlu5rkDU9ONV6jwOVeE3IbQhP1f2W4y3wYRxWZ2ULoqyZbnanOzsjQCpmKIQEAfLl/yQjbLYSnRM+tPcariG9dCh4Kaj2zoSU9maCuVYKDkUkTgOR1wK8JSkHo5O1k0dMSIF9NiNBbXtDsRWh3CGz9StQpSw9RN+CVTULDHsve7KS0RsZc5xXSruxHh9k8bDe2ETGdU594kg+setzxgFiUdlVrSY4HL2kq+9D0OZTSofwX+NmVpNowyKvYn28ZKtglZoMWlcz/MdAOqgNNsMiMJujUuG1pOkq3odEKrs1eFfymxjslb6uKLN9DQh7cm2tlv9vobcf+E7GF5oqdh/RlPt0NCewXLmoIX1puJskR8rbWu7T9BpmAqfvVSSJRo632a14kPQa+xiODM8vDWetC/6dSbEaYE2Le4Y0ROurZrw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823586bc-e08c-475d-4d88-08d7f8fbb3c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:43.4459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Wdn00okk9fjAc2/OG7qLsjqLxjTlshrkAu5CxfdwDDHn3ep39KWHvvrDYn1m/lXouRgxumBgxkZqLxs3tskFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
New unified firmware binary with only inst const still passes down
fw_bss_data != NULL and params->bss_data_size == 0 from DM.

This leads it into the legacy path causing firmware state allocation to
be too small.

[How]
Check bss_data_size as well.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 0e3751d94cb0..3cfbc27f3eab 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -98,12 +98,12 @@ dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
 	uint32_t blob_size = 0;
 	uint32_t meta_offset = 0;
 
-	if (params->fw_bss_data) {
+	if (params->fw_bss_data && params->bss_data_size) {
 		/* Legacy metadata region. */
 		blob = params->fw_bss_data;
 		blob_size = params->bss_data_size;
 		meta_offset = DMUB_FW_META_OFFSET;
-	} else if (params->fw_inst_const) {
+	} else if (params->fw_inst_const && params->inst_const_size) {
 		/* Combined metadata region. */
 		blob = params->fw_inst_const;
 		blob_size = params->inst_const_size;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

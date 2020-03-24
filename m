Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7846EC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 11:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4879920870
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 11:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YF2Zw2yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4879920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F226A89DB4;
	Tue, 24 Mar 2020 11:42:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A635489DB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 11:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqy/pFej5t9lN+5CcwGrpHv2ufGpqR929TkeArnkpgFnYXiPwgoAug5o/8wxVgI7x1Q9SZMawQ0fqEBdrhwmrzcwPFQYcZ47SpePS96nTqCLEIxIR/zwgSTNcFlav+KmWkcq95iWjJ9+EpXh9mzohxmi6IqC4wFESg95wbEFJbodPA8E/QB3r6wcPIkcU6BkR51w8alMvYEVaoFzKcM8SwXctULjCSGVO8eocIqaHgJJsxstLsYtKbfERzProgW3Mp0MEQfS+J3ohlzsRwBJnbYyx+p1EJ+ei+VvTZRxo1tgxImwugn2HDkJ/daaI3bBY6lY041bTVRxzuk5PRKkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB6hRFtBMH4sZjQEbe05BGiWvVPS9B4jwHnvtBUkoCY=;
 b=iMyjzJvyMOIUIt9gmG8AJGXtKTM80etI/ZaHwUsfEGk+Cl/1pMAsou+5UQ7So76xwhniNol7kW30VfZih68GzsPKebCvz/7wKJaw5glWiNnQ82Gx6nyRkF4OAHXoK6kNfSaRxFwVelmvHJIi3iyAsrtydOlZpywWfB/lP+AABuH8bvHuzGmlNM3ErdpAu7k1hQkgEzkvHB3j6L1tQxFKP2c9smEaZUmHuqaScb6Nn5il+hHjZYWbk8CJbokII0CUkR49JdcHsgUdLYqsZboqxrJSVW/OlHPS0Uuaw02PPVI4zQzqO2bzSh/bw8PIRbyE2m/fxGTx2i5zexN8Q9XV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB6hRFtBMH4sZjQEbe05BGiWvVPS9B4jwHnvtBUkoCY=;
 b=YF2Zw2yqXL6JYNqznJrHQ4ORag1cWG7F0WOz7JVVa1MehBEF3Z7n4dK2rWHNz4ZkY5D9ed2HlMaZdpFFhR0N7G2DHulmRZys51gKa+Q2TCD4T1FqDY5xOCCwzgEdWC1mFLldSq+eDprgtSQ8F0zmUtNVBZdBMQQqdjuVS3xEjhU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 11:42:11 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 11:42:11 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Expose TA FW version in fw_version file
Date: Tue, 24 Mar 2020 07:41:59 -0400
Message-Id: <20200324114159.23131-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:42:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebf4a0c9-5a6e-4309-6bff-08d7cfe863fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4467:|DM6PR12MB4467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44672EED87017D0CC89FC48A85F10@DM6PR12MB4467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(6486002)(316002)(8936002)(16526019)(81166006)(8676002)(2906002)(186003)(81156014)(7696005)(52116002)(478600001)(26005)(6916009)(66476007)(66556008)(86362001)(66946007)(44832011)(956004)(1076003)(5660300002)(6666004)(36756003)(4326008)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4467;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFr9pjEEgjpF1wr8F1814/DH5MMMGXh6tiT42Na1nDRrpqjbfUqa7f7Q5nsxsD8jyCquEpMypBMdZpONg2qNoRBia9s77S68bDImw1WhwqUbiaakfDCAbblh93TijFn3tareKeWT0kNryn3HVNw/cQHur5bIDFEiP5LU3z/WXKNUEzGEs8SaNtwLWCd8LzN4MPhmcQbGlk7Wj1XPhiaPJsOWql9srQQqYV81s7x5mrXTbva0ClzsWx7MIzv8vyK6HsOeWNHW+uCyen0XlB9jKFT24o0xQVS1t4X+vO9QMxKeDP5jcazUOuLAAAoRrz8McGuWlo8H3/Q7LnxXD/fu/7tGqDkySvLMX6ZxVOgpA5tqH3USMx+hd5w8gIYg1w32eBAGoPor9UidIdl8iulhmgfKA1Y/+FeGF+0w78x1tQZDsByRDPwCzKBStbya8GQ0
X-MS-Exchange-AntiSpam-MessageData: OI7EWC4kvGpjVEvisdc6ptUWwuERJUBe1DqC7bi0IUY1Xo+6HxO1yAIEywFKGlXA3j03WGc6AHVZdtm09/S8SVV67f+tjUBAj04bUWOtbXQLu/oq7eLQx21jouDtBzXIH8wDboKgbHQWdm/CO4Xz8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf4a0c9-5a6e-4309-6bff-08d7cfe863fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:42:11.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wpSJCq89PxWcgcbijJEDG90yPBvmklpLN8mQBqbHCaFizGqwZA3GonaEvaCjqb/9f2BOocUjDcy0c64jWYRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reporting the fw_version just returns 0, the actual version is kept as
ta_*_ucode_version. This is the same as the feature reported in
the amdgpu_firmware_info debugfs file.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 9ef312428231..65bb25e31d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -403,8 +403,8 @@ FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
 FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
 FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos_fw_version);
 FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_fw_version);
-FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_fw_version);
-FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_fw_version);
+FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ta_ras_ucode_version);
+FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.ta_xgmi_ucode_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);
 FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

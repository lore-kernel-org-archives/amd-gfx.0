Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E424E21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hkMfsDDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E424E21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB126E5CE;
	Mon,  2 Mar 2020 16:47:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEAB6E5CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEKZBH6j0AxyNl6MtEzOxAQCtM+MmB2xYgaZZHGnp9NvRUHE0FGSDAmjmVxcsfbdZ4Fn2xYVBsgfTo38WkETMEizXIF8HJzCb2c0k43AsNLkWYg2Jz18vDF//LmFf1ZVKaWx0dfLT21oX6z0tLxMGdHOMZEzxGs78jU9j7rwUvIuhsdUkMDZNfYkol7IgQDopGGzjOmNwnXcIKle2Vixa/tC0rs8IfDETs2Nvnxst1dv8qJ8RfaojGUocliQJiBZkSS2tX18cHFuHVzvSdhpHETLrMqC9feQ2B3JcVoX2hRAoSWphBI8RpbAU9unEZ7bk8bkZYpfbkrgJ/ZkYxyFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkbiBg7GMpfvb7AAcv84pqAsua36cI5BlB5nok3RZYY=;
 b=MccNv64Jfr1pYpCiTB3C7MTLdPrbY+5fj9vr0E7Abplh4SgbapuH9Y62xByv1WB5Zb8anGz0WROvcKmBmaM1HQPt/QtXGgT8wsYbmzJqZu5xzXijXsxUfSmzRt0wVyielB12gn6/WH5TiN+GQnTSdJZb9ohqIWXFjQWekd6ldjZRVXPGt9d/0WJ41umbSdH2YBJfAq5PYw1YmjH9vTBEt1qRdsla1fK2SGZSO+/7Ixoq/tcN4+t397uiLt7BHaUdiwRyb815YzaCss1URHteUcdzNdVcnvnnumH7qH6wgoD5etmqU2boQR3GJTXknJGJHixplhfvNnofW9BiEBhKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkbiBg7GMpfvb7AAcv84pqAsua36cI5BlB5nok3RZYY=;
 b=hkMfsDDSyJF0BVi0j5INzV7Z7cqvb9cVfGiRpRigwt5hGhL/jLftQpit5kiUKLxHmRAz9sW4Di/8khwPQbIEfi4XiCJrvM+EL1+wMt210KmI2XXJKe1gwBxAVFrmKik1JxsBpMks5vf+PLsL+lVMTHLoFf3RtS5G0K3mUtOWIkY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:47:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/22] drm/amd/display: Make clock table struct more accessible
Date: Mon,  2 Mar 2020 11:47:20 -0500
Message-Id: <20200302164736.89429-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b71526d0-1b7c-4af5-bd01-08d7bec97497
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25404CE65C9BA5056C77794398E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mslZOaS8EuESeoIEDu58JiwaXau2Fwx9+h0otPn/Peg0aoaruUdJWbWjFUHZBiS3kVZNbnOm4ObYuCR9yfWkFkTU9Mtm95xM+l/4StWDs3D8t1MDjFpOsNlJ8nyDTkbpSnI/o6NXkvEjlTjn79p9LgsL07njsfw3kojUgKCoTp0Fn70/J0LdEmTCVN+S5uirUHEkkAMImNCWDkgmg5wPH0Xc1+gKYoh040Od9fQRW1QnVWq4TwLI4vKZXhCjrRBBSFmXGCg6J96U93scrudga/erTdMfgBwpP0SogWu+97jBXHB2j7slMHR1vKC3KA9L/dhl3EUqBtKhP6zWCaSrf4MOtTpDkq4nmvXhovWdEljFwaLSgWCfz6an7cIXVHtT6ua1YjAhORge9cZ/rblf8mSDx/bpc9L8WOCH0+E9WXmXrsDCnDVu3XqCFwH4/345
X-MS-Exchange-AntiSpam-MessageData: bByu/V1hxHD621mlXnGoq7nHoowsc9Nph1uzbLC9OUo5bfFHysoFUUDxzXs9cjxpCWRYN41pseZQ/JjeX0acs2TQWTRamxfDZarng+W/Iam4MzRdbfa41IlAdxpiSX48vrzHZtITBQbZIZ059rnRjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71526d0-1b7c-4af5-bd01-08d7bec97497
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:55.2358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MO4xSlT9CCWsPGSODQbL84+MaGH9U/0H12DpEc6qJyTAyEGSoa+KyywVx8Gd9nbZOGo4IuR7YoPNPNOR6viXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Sung Lee <sung.lee@amd.com>, Eric Yang <eric.yang2@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
In order to correctly intepret clock table, num_states is also needed.
This field did not get moved with clock_table but should next to it for
easier access/viewing.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index a56b611db15e..a1d68e06cf21 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -69,6 +69,7 @@ struct _vcs_dpi_voltage_scaling_st {
 
 struct _vcs_dpi_soc_bounding_box_st {
 	struct _vcs_dpi_voltage_scaling_st clock_limits[MAX_CLOCK_LIMIT_STATES];
+	unsigned int num_states;
 	double sr_exit_time_us;
 	double sr_enter_plus_exit_time_us;
 	double urgent_latency_us;
@@ -111,7 +112,6 @@ struct _vcs_dpi_soc_bounding_box_st {
 	double xfc_bus_transport_time_us;
 	double xfc_xbuf_latency_tolerance_us;
 	int use_urgent_burst_bw;
-	unsigned int num_states;
 	double min_dcfclk;
 	bool do_urgent_latency_adjustment;
 	double urgent_latency_adjustment_fabric_clock_component_us;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

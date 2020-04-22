Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4BC5518C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6636B2071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x/Dybci/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636B2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295C76E12A;
	Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86D289FCA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXe7kB2Vc5ntK/Umlt5wY4akoNK/Wg4r1TRFi7YljDEMbqsxsdkD4hEwjWlhyL6SsibDPFIz/r/ankqLwmb6e2JUoD8k3FDgMUUi+55t/indGPI4FKBdneUO0Id9l0awpdiusoMJrn9tx7prgaud8EXzlRyO80OXMx16Z5zBqbg2rJx4u90GE14WzSsOTAw+2XuSwKstZWXmwe/bALpEhHmBwI9HU5Cbnrshj0JRvRZPX2+X4UPNsOK83j/TQPtB6kIUO2HvA+7rkBHgRilIlWv9NRQTf3CwMxPOFv6tz99Ci0F/8RMSJ4na4tu3eDcm3JgqbdAD2O719STPCsT/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6llVOeYzQKhXoIWucjDVaZyPHJ2mqCEfeYS0gNwWyA=;
 b=HeGJXwP6yIlFSlMLYBUzwrgNWt3XC8UPTzDEGKRzWssJfYrOLL+DkO1MuYiVMd4556cpLuPDoh19plr6vSXd4ug9JYZuQUZ5y+YPApKjhDfYyf4IRHXNJeodLDXE8umAZ+sfBqtZRX0I+Q7U0xF46aR3k9ZQuZifb/ammuWFjuNf36DNDmwys1BrdfKcEuU8pKq+fjT3WG+VPZZs1YAft9Yq9A651UWGWy0aNsoIdMmZfHacM3ChooYPlekuB0WA8SdBTCh8medBaxiBJWZY7l8giEhbM/OcQsxDPIlFHcicKg3weMXAjupEQhNtVCHqhLZujOGkMmVUEFowinqYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6llVOeYzQKhXoIWucjDVaZyPHJ2mqCEfeYS0gNwWyA=;
 b=x/Dybci/95Jsvd8y1HFqLbSs3DmRtuHVKbdJ0heHgyUc5ZQjJixsuOqTAnwipuw2r7aOKOHH9xTP2UQEfi/sT7aeEZVCaEe5AegaKCi9b1Seh9ecPtT7GeG+cDBassSUOgmy9TuDMjzxfZbsE2BfHHWJmixZIwwvNTj6obAkYAY=
Received: from MWHPR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:301:14::34) by BYAPR12MB2599.namprd12.prod.outlook.com
 (2603:10b6:a03:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 22:08:24 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::cf) by MWHPR1701CA0024.outlook.office365.com
 (2603:10b6:301:14::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:22 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:22 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: Update downspread percent to match
 spreadsheet for DCN2.1
Date: Wed, 22 Apr 2020 18:07:57 -0400
Message-ID: <20200422220805.15759-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(46966005)(82740400003)(70586007)(47076004)(36756003)(316002)(6916009)(44832011)(2616005)(70206006)(7696005)(82310400002)(86362001)(81156014)(1076003)(8676002)(336012)(186003)(478600001)(2906002)(54906003)(4326008)(5660300002)(26005)(81166007)(8936002)(356005)(426003)(15650500001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823a1c5a-6a41-4a9b-56ec-08d7e709acfd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2599:
X-Microsoft-Antispam-PRVS: <BYAPR12MB25997EB8F41B5F1D2A091F3B8BD20@BYAPR12MB2599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OFVv1s8c0dh+RNGWp8TIepPMYo91EhPWYEuDUZSjCeVpSVwUtji5nebZgljg/Pi130isTJKTeAmlxigph1+73vIjVJDbZ/eB1GXKRcBWfJOphLvzesn/m/AgrU7T9aY+z/AvBYOwQ+LJXdCb5ABpI8LjLFOtg2b4ClPddtALiunvKzGzjKjj0amo/aYtZ9+iHVMdOYf5ZJ4fxYv3opQqrfxjiD7Ja6Qwnpi00T5om0vtMPAz3X1optY9wmFGU1sBHUtRuC1k/wWLgaRUO2glyFqA1eB/QrP4JOyH/Gnxb9zlQ+gnI5GI8sikbjJplAULskJigjU07HhHk+KqMgJ+u26udP8LCwPa2B/MnpJ5fxKWVXLGO/v2nK2m6ieTPaY6mhpJwYNy7cXiJZuFiF0cNsA0JC9iUYCN02cFgX7KlbO6RA/9Zk5hwWa+mZRktv+tTU4jpYXYI646TWz9+IVioFzfyj7zZaaQ0ywyGxgLMQF82qh+dWVr8dhQR6Osp0GBHgxIerrmVpMSCNh7CbAsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:23.7601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a1c5a-6a41-4a9b-56ec-08d7e709acfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
The downspread percentage was copied over from a previous version
of the display_mode_lib spreadsheet. This value has been updated,
and the previous value is too high to allow for such modes as
4K120hz. The new value is sufficient for such modes.

[HOW]
Update the value in dcn21_resource to match the spreadsheet.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8fcb03e65fdb..802372f09dc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -286,7 +286,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.dram_channel_width_bytes = 4,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.dcn_downspread_percent = 0.5,
-	.downspread_percent = 0.5,
+	.downspread_percent = 0.38,
 	.dram_page_open_time_ns = 50.0,
 	.dram_rw_turnaround_time_ns = 17.5,
 	.dram_return_buffer_per_channel_bytes = 8192,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

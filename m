Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CD3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB9D10E1DA;
	Fri, 25 Mar 2022 22:56:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B2610E1DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxCcIy4hWZKeT3abIjILViyfhapM5jb6XhNSZZeKjoABh5tCWzktKfD10eqMAXTjrZqj0pcCwK4TO6t7FTdw+c3+y3aolmx03cA06nHxA35owe2oY1pecaMYrc7mSt8c5bhyPuT7WCNEOLYQ0PZyWMcs5pBgXqYAJHqn3Va02/3i1aD64zQ7GXyCwG3gD1WWq2LwxSFHYWQ0D4QNVrMgi3HhG+q/bleS9bSUS83dgkaTe6hf9Pz0KB2wXkH68IcvgzgTznzRBDSk25pQSLZtnRq+i53wjgiF5Ki9EVGE+SuljePR9ARxd3sDCZzPBtiVVeo/T+zNpmTkVMk9/apQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpiebQp1HCJap8+GwTLD5kVPHJteEqNnExKiiO9ltJE=;
 b=ZHnv9HcDPysftp5BnowEedFDLOfIHRyCAmOyFiA5AghIWAeXjmvxH65P7OFlBHTAACNqFl5rC8hAVasMoPmzJZ6C1KhhSqn8zOKAsCurrjcmPc3iluedIpm77ncRgxsOA3Xvetc9ipk4Gw2BCHEy7lMB1XNN0Ems2n7ISE6xhWjZY7sFEsVPAY67OyAGKG+6kdFqFlw4WTUW8FBzAk8VhEVqMxNxvrneyww4XtpibmTd9TfqBKnu8qAv9j6/lRLxVXqLFuxqVqQi0BnBsddfmEn0Ag2vHSvZ6Dc5dKsK8kILLl0HPlbyGt0BrD21WUeLZHUsgCO7bbcEabeshcxcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpiebQp1HCJap8+GwTLD5kVPHJteEqNnExKiiO9ltJE=;
 b=DQth5LJYwSbBtvgt7U5c/nEYIECoeGeNzhRhaVFDXje8bK2/gfGY7bqxyaHyWXkIzJloSX3b1TIylJOr0fEfEdPYkTvf0rUTQevJeuQsz4AgPasMjacPopSPjus6pY1YTt8nJQqsF0gqBFbNE9TdKWNoriWipLv5uZyAQg6sBLc=
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 CH2PR12MB4808.namprd12.prod.outlook.com (2603:10b6:610:e::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Fri, 25 Mar 2022 22:56:21 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::8d) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:56:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:56:17 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Remove redundant dsc power gating from
 init_hw
Date: Fri, 25 Mar 2022 16:53:53 -0600
Message-ID: <20220325225402.469841-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8f3149-fc55-44bc-ddd6-08da0eb2adae
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4808CD7ED2128E769E0A37C0F71A9@CH2PR12MB4808.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVzBqlldoVtVVKi5jNUjDLhFkMiasNWGLY9sQS9Cu8A2LRDMk4eon0ngqTVjfhBlsowur+k07FBg1Xr5JU3OW6w4Re3Ab3lFQ32ko1uJ5v9PzSqSTOZirYg7X1ZB7ibNQU2JdOElCWt7YH62G/wMEUa/Z14Dk68NFJbx9Mq3hsfeYT7Aaun/Z8Mkf2EbpGaqiyooY05U3K+F3KqbRff6bRNSQzKdfqGTuidU+FJfExAQnpqj8GkNN6alWBCUuo7ywE4zeFRX7CgvWVflbqlWfoNC+kJKI+K9RWgyl107+Wuiy2B0u72j69eRqJKcPOsN8AuHQpEig6IFaoYU+/9hZxoXMp1r6O7W2zSwuXVfMxI1Mp09lrpnw69eXRoXAVBm6RSNQZdR8NdrXVGvTDGPqoSPuVeCqD5WRsiI90M3aWR7bJSx0qC4LOwenqG8LWSJVybN2/0nZWAVI6c038Gutp4LJJJRoNOZOadzCA69IEG07bMmZexsPaR864uz3miGCop9mdQvORHMoFui+7LprxhT42ON8pQIRRcZnKq4jHbwiGKzHoK8JynrH9B/7Jl9OGjrtWAuCB12JlrP9BfBPXWvhKkl8osf/0X/oX48VhHQLSwqWDomuyRT2FYJshn/QA2WNOtfUxCmSCj1Hn6xrdB17q06oVnjhPKiAkYO/vtLj9gY3lkK6NBUADs8O/PHTuM0K/xq1KPktQ/EVrmUSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(6916009)(336012)(7696005)(426003)(6666004)(356005)(508600001)(8676002)(81166007)(4326008)(70586007)(70206006)(316002)(54906003)(82310400004)(8936002)(83380400001)(86362001)(40460700003)(186003)(2616005)(36860700001)(36756003)(1076003)(26005)(2906002)(44832011)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:56:20.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8f3149-fc55-44bc-ddd6-08da0eb2adae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
DSC Power down code has been moved from dcn31_init_hw into init_pipes()
Need to remove it from dcn10_init_hw() as well to avoid duplicated action
on dcn1.x/2.x

[How]
Remove DSC power down code from dcn10_init_hw()

Fixes: 8fa6f4c5715c ("drm/amd/display: fixed the DSC power off sequence during Driver PnP")

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 911c5d103c64..bb309ccee3e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1501,13 +1501,6 @@ void dcn10_init_hw(struct dc *dc)
 		}
 	}
 
-	/* Power gate DSCs */
-	if (!is_optimized_init_done) {
-		for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-			if (hws->funcs.dsc_pg_control != NULL)
-				hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
-	}
-
 	/* we want to turn off all dp displays before doing detection */
 	dc_link_blank_all_dp_displays(dc);
 
-- 
2.35.1


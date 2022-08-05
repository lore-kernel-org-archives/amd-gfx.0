Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A151C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F285B18AC;
	Fri,  5 Aug 2022 18:02:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C736B1A30
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejxU0lFZiZPaLCHE642EclgJNqICVRjUi7SqswPReLzWF72QruwSa0uTOZxP6549EcZk6ZwWWchZHxKMprES0OQyeL+BlNn/ClJlkoCnWCj6pNaEBvyaYVS1s9FMs9G44Z8+vwRqnXe63rbgwR+Oy/epNaQChiRadPUbD4nMjTguVwhdGy+vWev9Np7zu2bRlwMTa5WNyhCjLV/En5qjk+jFDwAv14acy4daBCM90z8Mnkj5NqIBnBXVuQlpUYEGB0T73zlRqClzipZpthxYC+mit4uiasvdO2RMB97q3x+E07IxYXdnAmJ/Ktn5y66/9bYz1YlROcSE37fTgPhqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lqY7eChRhMcxREjV83FnEQtyERHtCpufa+5g4ZIf3A=;
 b=gn5oi5ztQCcf+M6MzT3tNthy8g4h53x0kQ/o9tzOdj2I0CF2ref7E4b5GF4VPjc4Zq8smrkHnN4FiLLY+rMgyLcJ7mEogvljlt9ybhLSpFwY+l+MjfXnoJ7YNlIotWbIcauWBSRqT9sZ5kIdJ7LKUy1451OzpCEeKFbYFF3CAS8eU80sY9G3hp0xk8tnPewmUuB8nRSkwFrr0381lrLTWl/6KT87CPOd3qCH0dpbPp/B2w3Nya62W31jkjCIMVQIl0oWD7Sn0BBJs/1uR+K5Pcu4Dk0sb1eqEsygY9Mb6nJMAsT+KwkPqdBW1pDd+0Nz/X4JcyLh+VhLAqTjyIuKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lqY7eChRhMcxREjV83FnEQtyERHtCpufa+5g4ZIf3A=;
 b=HGsuucDMgom6q64HUy0sSJWJ+YyAWUfHpD8fPv26BwqWQhARXhxZNcIGVBdmU14UJeIJt45sF1FnPJHgh87xtjT6HShIzkAXXnCZxHnvrV30gYOlXj5LIT94I5R7p0dVKSQYjLwnvQt2T5VdhrtF2yPdEFnIwt+P9mMtXNcBjuE=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 MN2PR12MB2880.namprd12.prod.outlook.com (2603:10b6:208:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:01:50 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::9e) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:01:49 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/32] drm/amd/display: clear optc underflow before turn off
 odm clock
Date: Sat, 6 Aug 2022 01:58:24 +0800
Message-ID: <20220805175826.2992171-31-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c49345f-eea5-48f9-5528-08da770c927a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2880:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV6D6cea53V9TdSnO6/57Mm79xx8x87o/odJOsGUzZIvOdJdm5VtOflkixtWxUO+Z05f2NUuPoL+Hw4lblS9NzTuWhSjw0HByh2ixW/Tt1WsTBU/t+cMd3aNH/my/9WkBuOIbjmAHvW/Ndm6dshBK9Cd9pdiXXq8Vu/vrrOKUA48zppcZexTCaMKDLvdk4+f4kPIopT55WsRlUrN+PpVBuXKsl0A/1LjZBwo69R4HjF+1aE2RwAxgS8v/w4NacdaVXb5v7Zriw5YSyBgUJAJhSB2DzdIVdi6MvGjk+tfVbcnwSem/aLHPgGjD8/jj6yKBkd778W8998zHWZ3C0578rtyvoTiTHT3ImXPnjiTH1GePjkE5DcvDAlgG6aem2KjCqfH36iaBcXah4QGddl6/5zRhLZhlaXzZ5VsFe0zJ78OlKlb/nI4f/7V11ys/1DYJZLfFU94SFhIuZb6IhB5n7OMd6ASgQZ8S0+tBPGZ9MP2lcWJ1xgUAT0XHkmR6ZbHvIzOSe9APIWuWRUFg52QKFL6fzeHNCMkDyELJclUV7fPl+H4+tdYzkwMBZ8y7jnhCgaFWgmiIRSw99i+6YP5SDBepWX3whCOuUJI2qZt/G6buJuhR4V6G+Ryr2lVs4N8BksrUNTNQZQgV7KPkyltSooZuuUmX0HrUR0W31pPhL4H4ubGp202pmqHknbHQjI76p5xDMjrfBbLGYmCi8zHWRro2N82Q6SSHdzkfithoeLVFofDAVcdIllUdBtccEL0N9wA0peoWmEL7SoS06GUppgIUNRL25O6sbp4C8uW5msEBovnJ3oN2MO9HQvKP0xxZzmKKKmfMIFrJ5p9LdrHdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(54906003)(8936002)(6916009)(36860700001)(82310400005)(5660300002)(478600001)(70586007)(4326008)(8676002)(70206006)(36756003)(316002)(26005)(7696005)(186003)(1076003)(2616005)(2906002)(336012)(41300700001)(6666004)(47076005)(426003)(40480700001)(83380400001)(82740400003)(81166007)(356005)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:50.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c49345f-eea5-48f9-5528-08da770c927a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2880
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
Cc: stylon.wang@amd.com, Fudong Wang <Fudong.Wang@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fudong Wang <Fudong.Wang@amd.com>

[Why]
After ODM clock off, optc underflow bit will be kept there always and clear not work.
We need to clear that before clock off.

[How]
Clear that if have when clock off.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fudong Wang <Fudong.Wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index bcca4847590d..cdb6e2f220f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -479,6 +479,11 @@ void optc1_enable_optc_clock(struct timing_generator *optc, bool enable)
 				OTG_CLOCK_ON, 1,
 				1, 1000);
 	} else  {
+
+		//last chance to clear underflow, otherwise, it will always there due to clock is off.
+		if (optc->funcs->is_optc_underflow_occurred(optc) == true)
+			optc->funcs->clear_optc_underflow(optc);
+
 		REG_UPDATE_2(OTG_CLOCK_CONTROL,
 				OTG_CLOCK_GATE_DIS, 0,
 				OTG_CLOCK_EN, 0);
-- 
2.25.1


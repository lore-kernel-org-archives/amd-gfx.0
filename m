Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD32C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE78923AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78923AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670036EA40;
	Fri, 22 Jan 2021 20:07:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EE36EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOqYGCeYaGjnKc/1PMJubTYfKjR19UygAzg1zduSc7nNYsIccTXwR0cj74exiTZWXmb+RBEnWZaMeNl+d5bIVgbFQCJEJn+kon5hDE0LQkOvJOxUuy86BQXj6w8jObdqGrRH26l/Jg/e+mxhVCLtnxqpQC+fyBnSnRR4sY4Ofsl2/Wk6kFPz6aqtQUsG6I39925WeQ9YFL6sY4A83PBs2KZchisloUfJCE9gLGtv/Cn58ILKPfx3lA9b0VyoL8lgSlqU3q1Sc9KAlBSZpd7j3grSyjvd1K9Mh8NozeFZviMnXnfFPWUojGeRWBAqYH6F5eGrHiiPGWcXT4bv+Q0oAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ0ad+07+MxQLM6WxOMFbxBMhtT1/+5DwjXFKy8L978=;
 b=g1nWUZVgRC3P5kBEvcAnvAxozkfymQ8cQweqV9P32Ig6MaO0iBI5I6VF+9ZH3LfKlA8kH7Ev9QB0u4vD8usYCNi1st6wzbLj8DgJgbvqcNe6xXjTKzI+YmkXD6tK1xH59mhdjFWyX53yNss5DfdYkggivrkyCOq+yU0gmUSchBvtKwcPlmYooHqN5eiJ3eDf5QqftAkz78b3niCS7BY4Q5rfuTmf9xvlH6jAA6hi369WlVtGrWl3m552BN5KgTXkckq7JKCLUZ6F9DdGyTnJBgGPIDynUcxFIwfegZ2uvtdIkwdhWkWVdhl8ylDE0fOe3ubm9bKlRqU+uv0dsaUZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ0ad+07+MxQLM6WxOMFbxBMhtT1/+5DwjXFKy8L978=;
 b=bdbf/8KImNdLAnj0LtX/SHsH42B/TtUQvu1NECDS342FuZeCxvNi/yf72DznvRM2LNyjuWdNRu0Fq1ZNpgxNgi4HobTZ4IXcp3RW2wTaP3brjCSeCeNGAHL8Cas4pmhRKr6D8SAgJNTr4ChOnQhQk9wkiNVW9BBqPUFJgKwtfXM=
Received: from MWHPR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:301:4a::20) by MN2PR12MB4847.namprd12.prod.outlook.com
 (2603:10b6:208:1ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 20:07:05 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::1d) by MWHPR1201CA0010.outlook.office365.com
 (2603:10b6:301:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:02 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:02 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:01 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Add null pointer check to
 is_dig_enabled func
Date: Fri, 22 Jan 2021 15:06:44 -0500
Message-ID: <20210122200652.197934-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452eecd9-1ede-46f2-ba28-08d8bf114932
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4847D25BEB30F128F01487AAEBA00@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEVJC7g9a7SbRqd7AjiHMwP+NLL30DVIOeKX4Ig5f6rHpQHyFSSctLLdvVnpDR01wJdRqw8Iy8gYgJ0mwvNmA9vuLhNSWFnpa/N2fJedkScFMRjpB8N6nij8MqVzMOggrkMt6UzhXoZMiItwlKjsc7cK2kkJTydQYjDZwxQ96mrh67Tkw6HGPydC00PSRFRfTcJOhb/LKJOgbo88+vnZaVPruTD7THCrpmSKZrQvcsNJ8KfuJF1rI8kkyljzV7gARmXLC4IxquxkmkV19/1vQ7MhGLTNpKMJO2k05l1J9raisrHAJqGDs22jF16L0l2Zi7PIy5fwTSP2cJJK4Qmtm/Ym2RTp1WOCii6UsytwPEVRxIyJxyZEYluYzQO+NlWAOiluW/H09aVervcwLv6ozWRMPtq22mjsiJHWEFMjEBDSmjlxyum6t2G6fvZ4fj23RPchiAC+KPWq8oB/tviPy5PPYlTjrr3xIVyJhgglD0xr09bEH1Lkwtx5fH2F3iyw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(1076003)(47076005)(7696005)(6916009)(8676002)(82310400003)(86362001)(6666004)(36756003)(478600001)(2906002)(356005)(426003)(54906003)(26005)(186003)(316002)(81166007)(4326008)(70586007)(83380400001)(5660300002)(70206006)(336012)(82740400003)(8936002)(2616005)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:03.4646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452eecd9-1ede-46f2-ba28-08d8bf114932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
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
Cc: Sung Lee <Sung.Lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Safeguarding as pointer may be null in diagnostic environment

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 991b9c5beaa3..aadb801447a7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -75,7 +75,8 @@ int vg_get_active_display_cnt_wa(
 		const struct dc_link *link = dc->links[i];
 
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->link_enc->funcs->is_dig_enabled(link->link_enc))
+		if (link->link_enc->funcs->is_dig_enabled &&
+				link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

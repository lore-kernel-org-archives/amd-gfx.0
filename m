Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092EC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF4C619FF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4C619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804D16F4BE;
	Fri, 26 Mar 2021 22:06:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A7A6F4BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsYfX5e0cYikd0hyMywf8hzPgGvq2lqS+iNEthj2gXw28ugMEkqFQ/l8m+AyU2kgJbSJkVdWEg3taXb7Eo822HzUsuFvsNaNywa6pCLvxjsCoXuRVsE162weucBYm48YrDNL0AL1q+ltIxK9IL64KrErLQ9K3eERIBNtCK3G2r7dGqFn2vjbSq6BQ/22KYY07/zUq7p3KfiKy0MonbD7PO3JlbR4iORKSCzMbW7VWkiocOsKXrSIK6QW1F7QF+Kw8zXo2Yv9nTDHACzm1SkYzAdW/qJtd7wfdXRQgXMYocC/KGv8uMur9+LW7JHOIjyemYqgw0nrsoICicDCvyaf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BxwYkS9796xcDd9KEfDsxpf8R5qeNAHT50NA5dzDdY=;
 b=eqz4rHbn2jTP/+nw7LLM3UKrjc6v3fveKDzMIZ5pS8nYjhWQkGotFnn7BSBQyGflPPdBLjrnTspDgiyefMXNjNUHfJe6ubNvsD+oPmmGr35ladjZsjdXZutjoAf8jRjfVtldhXIuHoauGEpzhgzMR5+kcRTvl3KPB+zLXCyIGiMI9K52lC+GbMxuFrWV8w6WiV3rC+SHK8/sQPXPlbwziSbh1F5on6ZuysLj4x9J3BCyn6C81geQKFhBOm5/NO0Na33WaqRV/nMfNqBC3JKcmSm4WhJrK6APq35KEFvIk5gPq629JPc0IbLJ6OOGCKQ9r79Z74SIU//KCBJNep53fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BxwYkS9796xcDd9KEfDsxpf8R5qeNAHT50NA5dzDdY=;
 b=Xt43v8wWB/hKhyTU1JxmQ31WF9cH/xc+k4r7VM09bKRS4JVmuhaHCapHyR3c+lX6F3CUwTLH5CwMXdtRezVo4vJSx2mlx8qSp+iPMg6t7o1m8e+0mNt56P8jOV0vtVXnwy6rPh8Rvrh/estsa3aCc4Sy9MKtGkO9v6xpKcVx2Wc=
Received: from DM5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:3:c0::23) by
 DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 22:06:13 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::b6) by DM5PR16CA0013.outlook.office365.com
 (2603:10b6:3:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:11 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:05 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: Fix MST topology debugfs
Date: Fri, 26 Mar 2021 18:05:26 -0400
Message-ID: <20210326220534.918023-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5878a5ae-239f-4dd5-956a-08d8f0a35e24
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3194AC8DF8DD78F1E0D5D2E4EB619@DM6PR12MB3194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEif3wNf77CR1H8OQ7pPpyTh3kVrOmhCf/O9TQFiFak26+FtLAKLJiQ5/DOfdsGLZxDyfbReSFKakcHOMo2jmShohZ7ig5Jae6iws4f2bTLeD/FEmgB0ErorcKl5yBDVy6xxVcQL64+z4xIZvbLzvpKT0Ax2malWINrJLCi/6gY3XXi6T7qZYfrHAuTUjm723gx5K6amOZLLTtugpb9k15ywNNP2IbE7RCumEuGB4f+NpPzQ5EwzyV/20/v0oU5b9g2xzhDLIx/yvq6XUfVU2XF0/H9XI6aAAFc1HMqvdvsOdzS8PE+TPq40guAoYPcTpqTONEKx9IB1wEEXlxUC4PdvH8Ecrjttmqi8I4FYaSmf8q3M1EM9ZttYVfZzfMzGOS02IzRewrn2Gcw7VyZVck2WTWh62PQRqqQskJxuIgP3UPhvYrGfcFYKGBYM3pkUtSoM63ImiB7Y7QUKL6/G3PCD/KxBNHb+mFBkbcWUd4f57JrnUNnFbQXeZ0Irwb3EezOOffw5eTDRwKbrS8b3oU1MDO6i08yoZ6x/63dlGELUtB2jzwyjXxGwb/WWM1TaW4jsINPIVzbNFYYkx3dyMnbsgGnjsQjMjM2FGBaJbdJ8HkCGF35X8f3ngndMPWnvRhszXkYLk5HUSIAvcf8091tZg4uidkLRtnAbtQ46qBcmMlR/T/G5RjdhpBuPos4O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(8936002)(426003)(70586007)(316002)(6916009)(1076003)(70206006)(4326008)(86362001)(2906002)(5660300002)(336012)(6666004)(81166007)(82740400003)(2616005)(82310400003)(478600001)(54906003)(47076005)(356005)(26005)(7696005)(36860700001)(8676002)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:12.1697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5878a5ae-239f-4dd5-956a-08d8f0a35e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
The drm dump_topology function was previously called on all
DP connectors. This resulted in empty topology dumps for those
connectors which weren't root MST nodes.

[how]
Make sure we only dump topology from the root MST node.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f6f10a8c3e43..5a9809e33af8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2901,6 +2901,10 @@ static int mst_topo_show(struct seq_file *m, void *unused)
 
 		aconnector = to_amdgpu_dm_connector(connector);
 
+		/* Ensure we're only dumping the topology of a root mst node */
+		if (!aconnector->mst_mgr.mst_state)
+			continue;
+
 		seq_printf(m, "\nMST topology for connector %d\n", aconnector->connector_id);
 		drm_dp_mst_dump_topology(m, &aconnector->mst_mgr);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

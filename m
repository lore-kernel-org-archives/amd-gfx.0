Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6FFC433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531CD64E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531CD64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCBF6EC2B;
	Fri, 29 Jan 2021 21:28:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48406EC29
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W44s2h14MYHZO+hvz6trPmJx1wYD3LmskP9aZEy661JzucHzuq4GmXD5ntTZx1/T+VC5znk8C6hVagbCS/8pxb8QeMfNXLd0A7ArLOXgGGRAEet1z+1frYge6z8R/ulcEqNbfGt9WC57p+x+r468AlbZQ0CsiPaJItn3a3C9LY3A8qs6mTm15wDQerT+/ad9GZN586wU9Ui9PkaKgTsVxJjICHua5Mli9KdHFGpIB/0zb0UvjPb4oTKcpn1JyL1mp6VsADQ7TxY8tFT7iMo5LtrPn2GHe8v0aOnTX+UY/WaGMYBnyf0dpGwHb7Ik+1hyDGQ+cSYpyoktDvo5go4GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvb6FTSo5b1klGEmeUdvukdY7xEqg3QiXX33ifB41zM=;
 b=PKhV3vg9H6IG7UVCTO5uZ9PF6fuDCc0G1hPsv3Kfk+7VUVEL9gB1jl7PYKwT3vQ0Z4Z3dKDurW+87Nma5iiKLC3c2/IKbUYQ+XJl0bFCIMrDSfDx+8kuCN8Bi9Y/kZdOnysofKd+COn3XUyV46aXDy+YiH5jsXcpFjXRHRYqEc0pD0xiiJogxzTw+tfve5Pkove4Rd9myWFgRB8pHFsxlSiQ/dOOMSDahpvJQl+9uMVtcOQVUugAWJWYkuL0HxaFfbna+mdm77TPmmiqsWJa+kKSd1H9IK7yKf4h4AN+fVZxZV38W3FEuHf5fqN0cC5a/FrXTz4Sul4+RC71kR4lCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvb6FTSo5b1klGEmeUdvukdY7xEqg3QiXX33ifB41zM=;
 b=FmJ32RlNht7eZW20T6uf1uQbYNDG2MQR1EmjJ34oVO6Y9WfrrOyOhZHhg2tnITgNRWH/cub5sMHSPO5QGJrvtWW9nrWChUMkPfIp+BFpEeqEXaaFW8/QHQHpiq5UzmmGqpNly18l6g8+JibT3aArCfun4r+AmgIUkk0LMuDN1yI=
Received: from CO2PR06CA0063.namprd06.prod.outlook.com (2603:10b6:104:3::21)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:22 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::96) by CO2PR06CA0063.outlook.office365.com
 (2603:10b6:104:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:16 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:15 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/27] drm/amd/display: Release DSC before acquiring
Date: Fri, 29 Jan 2021 16:27:38 -0500
Message-ID: <20210129212752.38865-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca4f751-afe6-4632-3035-08d8c49ccc99
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4690808206DED56918D94B59EBB99@BL0PR12MB4690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zODHBQbY/SBuo3DazYOjpJtbu69mVhXoB0bo/rWq0uTX5DWkCDp49All3votVztAz1KHEJ9wl9SlQGTOgMC7+COpa13DqntaVEnI6FBD8ktojzpteZDikugmv6OlxI2H4PYSUuLzTDOB8nprQLReuAc/mjwa0By6tGZ7Rrz9ncLvFhl6PKtTPfTrw2NK5zWfADQQkyuD1T/+8faou4jRtyeEWeB5WKOzfQgUh/Fx8NTcdLB2SbVi9HScR+YWBTPXYg97WkRxvYflktA0zqUs3lUzreVVKA9EnivMDmiHZydFlfL7d+zzZOEPMzi2DPF69iwLHoQ/bwGNpnJuBDS0CjiRUpUVdjDptBfTXN9ag4rcEmJ6Bbk+NTo4YDnj4YIp2QlYTMv3ROG42wtfJ72RgU62ZEVcPOl7juWEaxus/jQdPoyEpIZJkKbbc0BX0s3bdrieYxy2VBUrkVtlxvUvJq3Rs9wY5wLQWvAl/qswAv6r0phDpwuhFn8DcYLbeaX9GRnD6JCbAGNHYmAGSmBuUo53CDERp5W5JKcXL8TqtKU/GtrnLm79795NbMPmpmTco9RMUBTC783qb7Kacb4QIuv8e9vxQoETy0ywSqYQ+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(46966006)(1076003)(70586007)(26005)(70206006)(81166007)(356005)(336012)(5660300002)(47076005)(2616005)(7696005)(186003)(36756003)(426003)(498600001)(83380400001)(2906002)(82310400003)(8936002)(54906003)(6666004)(6916009)(8676002)(86362001)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:19.7729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca4f751-afe6-4632-3035-08d8c49ccc99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Need to unassign DSC from pipes that are not using it
so other pipes can acquire it. That is needed for
asic's that have unmatching number of DSC engines from
the number of pipes.

[how]
Before acquiring dsc to stream resources, first remove it.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Eryk Brol <Eryk.Brol@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5340c41b85f0..46d1efd44461 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -829,6 +829,9 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (computed_streams[i])
 			continue;
 
+		if (dcn20_remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
+			return false;
+
 		mutex_lock(&aconnector->mst_mgr.lock);
 		if (!compute_mst_dsc_configs_for_link(state, dc_state, stream->link)) {
 			mutex_unlock(&aconnector->mst_mgr.lock);
@@ -846,7 +849,8 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		stream = dc_state->streams[i];
 
 		if (stream->timing.flags.DSC == 1)
-			dc_stream_add_dsc_to_resource(stream->ctx->dc, dc_state, stream);
+			if (dc_stream_add_dsc_to_resource(stream->ctx->dc, dc_state, stream) != DC_OK)
+				return false;
 	}
 
 	return true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

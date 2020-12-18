Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD96C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD70823B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70823B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F2789C03;
	Fri, 18 Dec 2020 22:30:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3153489AB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIEPjEMhsi97Bizb55WNIkA5LMc4FbVxL+BXgV5OrBj175Slnva/5DIsMCOq87Rf4AsiRc8CdSKAnyWGDuxxvL8u1ntYcEQ4xP2Ub7Sz+VRA1AM1JfFPOXPWEkG0FI+Fky3VtRS3WpNh5g/8m46TmgfZNTPgEosvlktsylJtow/c5lFqepqUJmF0WpfHQkpFBP+WzwO5P7zt4jQ/rhxrG12tGamJDO2A7lLDBQ7eZtPbuG5Oga44FCJTQAAM2Lmga4JoIL7TDaMwha3NU4KCdqBOEEAHlevLb4mXdRGTUavskFobMymdLce4yPe03G9e6t+OdaYdxxYg8XIn5l0hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/swsxfnhRvBo074wnV4D+IwQ+zY/7giN32qyM0pU5Fs=;
 b=gJyke9mNaXKqhMwILDHEZPP0cy1E/xtZjaohGTenbZrNGcrO47XiyJ8dh8qfQRdKg/rvUh1jdB848MWh/JsbxPJyGSRQyTek9gbMezmC901BJb2vqQspBSQ0wIHj7L/R6gTMEq+7j0KLB8iILDg30YawtacjYXQ7/kOYTDBoX8fZoKM/2xJTr7kyQGPJR9tBaoIa9NqBIxYrW7hBlrWY3r5uxzBn3TP32BA4k1B99dVnX0qeYkPbzdgWVI0/JZdGvAL8lT/ZrpgvACPVvgfFk6ZT13JpyYYyZSF7QKj/pKEengde9/oJIwwoyoid3MAUqLB/BU4PTeFs435M585sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/swsxfnhRvBo074wnV4D+IwQ+zY/7giN32qyM0pU5Fs=;
 b=MdVoKIYgW4S5t0F94jB8EP0OBQe6lLRDDwWV7PPGF5wlpzUhJb/dy8qsV9RHslDouE29MnOXUVfb1iiSHI/z6T8qU4INZsURsXHNtfQh96kJ35HiASXOhfflH8Tp/cPKjQCs3Ug5uxxH5yHBQfL7sdEx1R3X0PFi1ospGdAaCpg=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Fri, 18 Dec
 2020 22:30:08 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::d6) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.21 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:04 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:04 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:03 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Acquire DSC during split stream for
 ODM only if top_pipe
Date: Fri, 18 Dec 2020 17:29:00 -0500
Message-ID: <20201218222904.393785-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a86b37-2183-45b3-4369-08d8a3a478aa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3316C35705535499618142A1F5C30@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oz6YQKW7MxNP/LJg1pMKS2zeumBaw3CjKOSmxYXndtWBew/e1Kw7y6I5oUBtzFK0aQLJi/uOPEIElhlkkDnpByBm+ijpZCxPYKcVhRiY+9hpBdwgs+HWcL8FMb6sotOfIR8gUYiNXd4le2lQwQ3qb0QF4vAomNu1+4e4BOzZDCGUoBUbsVRQF1ZNTrmhLbfXiJSeudSTZZPV2h2sqcXY6Xw4dw3Ni/eEX4s/lXwkBWUs95MWipvm001UtUJiqiKFq7a7oEdI4cM5fFW/t5E/OL+VrH0aGqDEmH5jDWeyWSJJ/3Dy+SqW/4PWYSFIK5h2OK2/zGKFLBHUZijak1PqAlfrux77O7O5MADJsnNJbqsAhaGNCkI2p7ld7l/DOxivkuhM4sMMciFcWLPHrlHkdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(316002)(1076003)(47076004)(81166007)(86362001)(336012)(36756003)(70206006)(8936002)(8676002)(82740400003)(70586007)(83380400001)(186003)(6916009)(26005)(2616005)(356005)(54906003)(5660300002)(426003)(7696005)(2906002)(82310400003)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:06.6783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a86b37-2183-45b3-4369-08d8a3a478aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
DSC should only be acquired per OPP. Therefore, DSC should only
be acquired for the top_pipe when ODM is enabled.
Not doing this check may lead to acquiring more DSC's than needed
when doing MPO + ODM Combine.

[HOW]
Only acquire DSC if pipe is top_pipe.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index ff36db5edf6c..e04ecf0fc0db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1933,7 +1933,7 @@ bool dcn20_split_stream_for_odm(
 		next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
 	else
 		next_odm_pipe->stream_res.opp = next_odm_pipe->top_pipe->stream_res.opp;
-	if (next_odm_pipe->stream->timing.flags.DSC == 1) {
+	if (next_odm_pipe->stream->timing.flags.DSC == 1 && !next_odm_pipe->top_pipe) {
 		dcn20_acquire_dsc(dc, res_ctx, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
 		ASSERT(next_odm_pipe->stream_res.dsc);
 		if (next_odm_pipe->stream_res.dsc == NULL)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

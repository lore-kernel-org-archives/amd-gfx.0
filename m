Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73BBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B80564F7A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B80564F7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED2D89DB7;
	Mon,  1 Mar 2021 17:06:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690047.outbound.protection.outlook.com [40.107.69.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA9E89DB7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 17:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCb2KIfINq9NP6XemrZjRV4V5fPFIMPiHtUvbrEJs1FCdayYQmGJtooxfx+r0WfsKJ3Fy99x2JzdF20YKaMTtKClf2JNWQn0a58eRpg3vvs004EC6KNKdmIUc6ORaIliec6+rAXP/gD4CC5hA/OmXWfUROb4Xqm+WmQhdYNyV1Ud7KpdpoCL8Qcj1PYbHckvHBLz2o4uqFkTejWyiYhkBvM+QEAE+kvKJaBsYKasaaefJrSlTgWgcdAcSGzajuupH6CZiHdbZQ1Eq9YmzdE4DSTFZoNYMcTAR+G+0LlGIMC/KLWFcQa7yERh3ffOiZuXJoZHNG7WJfSlyoHT8+cXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+5h3FHdneL/b0Lzp1rTszedOvRPC1BxXFvEsrsNoWA=;
 b=TZN2JJg2ezQI2oaTnKlSPUVID2LXFbTW5NR4y3D2vk4KhlNKAoVjhCyqNG5mi/KvdLZhdHEiGSyxFZRWTdnSDru0ZhSIhfXP/mKnbBUXdV5LSvxMKu+I7MdCkURU0EU/zTeKrgPzkc33cQk8JmdpkA13dF5DMOmMwJpF+6vubBVq9cRXD8B9eOLfQIdvqlnmoNYU13GishYfonevptWareQBoLYwjQ1eOunADnrkzRbCoucA9nnweTlmaahJnJ0XjXx7mGEeaLmt8J8OVEXv4LRxaUwZgYbTinUnghvlbpFJA0Y/ZxLFq5IVVNZjgZEM/RJYBuxJ2Pw93zDQuiU7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+5h3FHdneL/b0Lzp1rTszedOvRPC1BxXFvEsrsNoWA=;
 b=UqgY0twNUtGDQZmy3jVYvDt2Wzo/fD5whoP3Lxf6x5Or/9OHgHzMMmWGvqdSlcf6nUip92b9pZp02QIL4urhS/VfjJoDv+UsZzmr3PdUxFo+aamdDaslXl3Fdnq/WnRUKog8xYpMZK4apL6CIPIOTlu1ZUXPar8uOh+BOoHDSkY=
Received: from BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31)
 by DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 17:06:44 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::38) by BN8PR07CA0018.outlook.office365.com
 (2603:10b6:408:ac::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Mon, 1 Mar 2021 17:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 17:06:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 11:06:42 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 1 Mar 2021 11:06:42 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Fix for 64 bit divisions on 32-bit platform.
Date: Mon, 1 Mar 2021 12:06:29 -0500
Message-ID: <20210301170631.94988-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b3dc75-ca39-4c51-3766-08d8dcd463b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3580:
X-Microsoft-Antispam-PRVS: <DM6PR12MB358085C35AA4FD072E9F64B9F59A9@DM6PR12MB3580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cOoVP2WI5nqIpyhYNksmxnRBNNMrR1g7AEOcOSnHBfhp3Eg/vKaudz41cN4KAmbR71UTyMY/fcEa1Y686xrfVjKbww+mNUJOyxT41aCRODzimRiXjkYQQ7qxXS9hCDa5tMV/D2d34VFx32IMfOU+xMJ9wbZBiNbwMZu9zI1H1yWNCk3HS8gMfNhBrYAOg2RjImPETg4TPRv+NU4/SvGmxsUUU7pM5OvndKthGonGHHMkZ3mR5RiDp0hERlzIOtdu8vLH1iOFOqXachWtvV2RSOcRv/lrXLi5D5mNeEXclLV5rFepg+I/hwA5szN7xanAKsx+pYq/0l7efsbUqldfvVJwh5E6PeGVYkKkZJqS5R9sAFeUARuIhSiTwBEBbVsuwrZtEIVkVgyZzAKGn0HsyX9KpoFxpSLiFmCUVp5S8zmYUjn7l51Zzx2AyJmu8ZY5bROJ4lLz8QV0ogDTdc2yLn5+PUQcpBJwXacvGXGEutJsMl9RE1L/GVnMCxLNoZBOf8GbGXucUvkpApsgzEoeZz/Jisd0nR44I/mNCNhsU0r1Ruou4tBkaWSrbgLMfxcd0nNKzxcf6e+fUO/BLbRdwbDmfRwQr9cM8z3oJNWHTCkfdxne4RY1Cs/A5IikLHplYkB8YSIm1DYHmlRFBgoASJz06QdKp0vpYkXAQBAGGi962V55pEMYMEWKqPe8izi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(26005)(36756003)(7696005)(36860700001)(6916009)(316002)(4326008)(186003)(54906003)(2906002)(70206006)(47076005)(70586007)(82740400003)(86362001)(2616005)(478600001)(1076003)(83380400001)(336012)(426003)(8936002)(82310400003)(356005)(8676002)(81166007)(4744005)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 17:06:43.5844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b3dc75-ca39-4c51-3766-08d8dcd463b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set fixes 64 bit divisions for the display
synchronization code that caused a regression on 32-bit platform.

Vladimir Stempen (2):
  SWDEV-266369 - dc: Fix 64 bit divisions on 32 bit platforms by using
    div64 API
  SWDEV-266369 - dc: Fix 64 bit modulus operation using div64 API

 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++-------
 .../drm/amd/display/dc/dce/dce_clock_source.c |  6 +++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 19 ++++++++++++-------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 13 +++++++------
 4 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26400C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C727E23AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C727E23AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504326EA51;
	Fri, 22 Jan 2021 20:07:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469546EA51
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hyf34f/EAkC8STTYQDC4M7negOYFrLaONRYNnSvSnMM+g7pYveWDY9J4wxoVFtLVRILlp8F8Sk8Ds2g0xVCHIWqIJgtzIuy8Y5TXNMX3suEUkwv8c0Kro+V4OxtQdGU5IazNLWqBVzTs4y8QVZyvRKHZbQqF8gxT1uu2s7XZAMgTcX+iUj2D9qm4SqqFjsESOnQb7lGhgkO2T0b4eN4uSqdEvpSgpkt7cDCBil4plk/t4hSuYb7bddfjoA8R12XHOtlyjrnfKptfYW7jOvu/sOL7/vMO/gaIVHWqfYU1dnZD7r/wakjuWQyA9J4wqmeht7XupFEqZF3niuIn0b/PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+zzdBppddtY5xqj52ZoZ50QIYHH1qygsaBjA32anXM=;
 b=VA6OCv3/SKovZ9ewbozQSQvo4o9ecZg/VJ2QnREF2fVRcg644qnUwQiyykjlfiCv0Gm/3cVgV2aOlASL6NmoaMHJMLvDr9dOtojJRLgWhqgQsXogaTC06UXPXeM/yspNZnysDdFXjQSLYqRURk9HeK1Z/X6M/RRqWcEUUKyEbqkaEI8J1V0eav8ABmvaaN7+ZF+jKk7rSwZOHlrJ+rMTqRjFeFwgKvKoAM87cl4BJ9e5skDSDgX59GnPj4zePbw1/eU4vovrvB2OSbdjgz96TAU0zZHQmABb6g9sQQoYpxYoRJOLXbL4/L3GR1VHBLIlqfBYfgDCHmjvdCD5KrPq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+zzdBppddtY5xqj52ZoZ50QIYHH1qygsaBjA32anXM=;
 b=hMI6jA1iH1/RjZ7cmiVYk03pafmQlfJ2JzIXpv1dh2xjA5jLLLDndJz2m/uazT87qENKDCHicu9/xApgyqGhagtI1rPF7hVoIx+/Vp4uWk3mEkJLSiOJgTTArVR6YfMwNMPz/r4HXRADM2Pczdc0VoaFw096DbiXWeAUpzuSKrk=
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 20:07:23 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::43) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:23 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:15 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:14 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: revert "drm/amd/display: Fix EDID
 parsing after resume from suspend"
Date: Fri, 22 Jan 2021 15:06:52 -0500
Message-ID: <20210122200652.197934-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d731d9e-c2d5-4353-8864-08d8bf1154f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256459B82D226CA0E83B43BEBA09@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7OtqpQ37uKPYxpCYPmtaHMUf8r8ERN8/iFzpSXGK5xTdlJUfONw6J1s2cXDM1EEZ45FjamWCUH39v98tyHI5uPSPujjh2+yksVKM6LuURBGQ4BQGwVPvHLe5ypZOll7mxOePzIVQnozzMKFDP9IulTiS90BYC47FyHmLy+NAl9S2P/MM8krSHGRdaaFp4zukjLlqKICEzSx0hgw94G2bm/BWGfmaEemedERXChf5LoLL9BvIQjs6id4ZaRrmIPNl4WdVsWP1HWazjqrJGDEMOJ6BipYUxF04pXqovBXsxU38SrVRs+6MqSXnIDCZg2WsUccDxKsMWXtFkbjQ4HKY2cfYKEBcraWp+MdNEgiauTWF5XLafqCspUjuqCZHmVsbJWk9DG0SFapIrQ+cE+DnkQ3ile+VMIoMFnAj8ZP3FKbn2Fh5p0ECFr4E8syV0tN/Ea5sDBZ7h2Z34E42WGnZbsowN0V7MXd9YGyeWAzoUj0jA+7k+gzCJl4gkYOLtt4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(47076005)(70206006)(70586007)(8676002)(356005)(86362001)(6916009)(4744005)(83380400001)(82740400003)(36756003)(81166007)(5660300002)(1076003)(6666004)(8936002)(82310400003)(2906002)(4326008)(316002)(26005)(426003)(54906003)(7696005)(186003)(478600001)(336012)(2616005)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:23.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d731d9e-c2d5-4353-8864-08d8bf1154f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

This reverts commit b24bdc37d03a0478189e20a50286092840f414fa.
It caused memory leak after S3 on 4K HDMI displays.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a2aee616755..6566912dff71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2348,7 +2348,6 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			drm_add_edid_modes(connector, aconnector->edid);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

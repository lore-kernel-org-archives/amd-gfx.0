Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B5C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD1821775
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tA/vN9MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD1821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56596FB60;
	Thu,  6 Feb 2020 21:14:40 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680061.outbound.protection.outlook.com [40.107.68.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B849E6FB5C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 21:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB0GAssET1XDvvtqxnrn4u7FClJtVwA1wkViJUSSoH+Hb8w6G53hbR8ETrmdYk4j6lKrpyXQXZ3wgF91Z9gfJTtThZuKZZ5VZ8VIWk3ADYO4F9Y6NqvkLj/IzOEoZ93JdMWylhoabcf1B08iIj8eYu1ggTUG+2DN9N9RCxPbnl+uMMGHa5NmL4224g+hlQQGVkoiNvoOipTP0veqyXuYGi1dzG2DizAfMxIq47ALzR4fSXAM7yW6QPVhYcIfVfsv2XRRe985qzHNaLEvUNz492RDmsU6zcnhJww/DMYj6kg8IXclj2Jj/SmGEZ9jsl8frLDypRLQrnF8s3QRBhaLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnAXNP68sm71SN1kvBMB5YChI6wBDkFEXZyjIeOXfTo=;
 b=ILInZTZo5/JhMRJ/PMBWIxDM27izp2qELYR83aVfhw83ZDIg6gJzZjhIdP3kXSxiltenBG7BaolNPIy2NaoDXpT84/NX/GzHmDTjwV+CO96t+Q3zrZCorhJlRqf5wZpLzA6IuFuQ2AEbHqi5KpHEXEQhHCPzJa+FwtTv21e0U3iRU7Ux2UVn9kT66lQMC/I7fH/PLWhXKRcYuQE8QPEZ7mpY/NC1Flw/IvCOSNrzJyociYlNeApnleMpTXrTLQXlSP0lQu1l5BogYV0+7Fdh8/O1YbzRGdUoKbmvqal/QsioQ7BnPqos85Afy/yRjWy3Ujy2ZaoR92aKYTNfF+InBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnAXNP68sm71SN1kvBMB5YChI6wBDkFEXZyjIeOXfTo=;
 b=tA/vN9MVf8kMmADG9JrkvDaLYvu8GGF4MIMc5IcMRTlt1a/0GtP1TR4hEie+1PYeGchYf2BnHvqBwjeHQ/DDn0v2VZGqOF3Jor/Yc6FQSLqbEcb1eI0F6qNXcOa8TYAE8BfLjqe5WmDzVheZmSn9pfkEtBdJzjjUeHrlL1GXwac=
Received: from DM3PR12CA0057.namprd12.prod.outlook.com (2603:10b6:0:56::25) by
 DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 21:14:38 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by DM3PR12CA0057.outlook.office365.com
 (2603:10b6:0:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 21:14:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 21:14:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 15:14:36 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 15:14:36 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] HDCP fixes
Date: Thu, 6 Feb 2020 16:14:20 -0500
Message-ID: <20200206211425.20394-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(199004)(189003)(2616005)(70206006)(70586007)(8936002)(6666004)(356004)(8676002)(81156014)(81166006)(478600001)(86362001)(4326008)(54906003)(26005)(2906002)(186003)(7696005)(1076003)(5660300002)(426003)(336012)(36756003)(6916009)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2940; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3749ad6-b9aa-4805-b0dc-08d7ab4992d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940D43775CF875BA8E9DE69F91D0@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YMhV83CHUaeH2QJdL2H44m/wqoLW8+/Ta+9RChqIP30TQt8/Smf8qXbfMwqLONJFm34qJpoLEXnXEfahktwZaemw9uSNWxQEYby0clRB+fESmc65fvmH3LXqXvJ5Ca29r5S+QXV4v1X5Jud2WdkAS5yUGOP85mhQxcwX1kby+sai9m2OZb3IFi5g0dWhAG0qF47XCBjoWfUHLegaLU8fBk6Sd9R9ER4M0QE/2EhedVafF4HKAYyIjDJ8hx8iIYJerDHmdNIR+KCrLr7qCwvqnh29pB+EVO5KJk02hRUxLGMxbmxl1W0nOoWz5ZgG3ckR261n8lbZFiYE5MJXEEz01brBXd8DdjcqjfRIilAYRhyk8RbX2dEoT8tAkKB4heM0FzyR7eWLrip2qe4ZLTvWo23bYWDdJfEPGJDCfZ/Vv4n+yhSBqXfmjH/fiFwn4mC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 21:14:37.9285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3749ad6-b9aa-4805-b0dc-08d7ab4992d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Summary of changes
*handle revoked receivers
*don't retry if revoked
*fix rx_caps check typo
*fix enable encryption call to psp for 2.2
*update DTM right after HW programming


Bhawanpreet Lakha (3):
  drm/amd/display: Handle revoked receivers
  drm/amd/display: fix backwards byte order in rx_caps.
  drm/amd/display: Fix message for encryption

Wenjing Liu (2):
  drm/amd/display: no hdcp retry if bksv or ksv list is revoked
  drm/amd/display: update HDCP DTM immediately after hardware
    programming

 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  49 ++----
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  11 +-
 .../display/modules/hdcp/hdcp1_execution.c    |   4 -
 .../display/modules/hdcp/hdcp1_transition.c   |  12 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  10 +-
 .../display/modules/hdcp/hdcp2_transition.c   |   6 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |   4 +
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |   9 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 164 +++++++++++-------
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |   6 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +
 11 files changed, 150 insertions(+), 127 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

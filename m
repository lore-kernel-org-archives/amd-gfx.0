Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB82C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1673410ED55;
	Mon,  7 Mar 2022 05:51:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F37E10ED5B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiI/kjP2PZGlk/6bvvQdjXurXfdq81Rh0ExE/nFDiKF69GRhpTd4zXGuPPLOIe04xu7oREl/qc7WV9AJXNCMsTchiLYL/kP+eXU7CK5EsOG3b54FAuEuWlOXZsfpBe6pblW+en8/m27hIgdVXxMTeAQtxToR4iJfSIeH938g4cp9AnjdNQXdxSZQ318zC996KtqZXCRVmElYAHL9X8qYh/QDB6VUD3sw522h8E2bDltUui8JMhBegx7nAFD+U9CxdozYVn1leckJ2CZyiO0kCOgD1vy1kJSEIiwrSZ1QgRoMgnOpLi6otEDBGaDY6MX4vvEyWRQ3fw9SgunQv5bU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/mAPDq3dQdMKmtfRPtVskqZodqtiR8rqoEh+QhyuOE=;
 b=HvrPDYTDRIPAoMhnnuzXWglsNOZUdzf/OS2zqDQ/zdoYYGg/CNRNtIcz/z/pAtP3jlt00NeIgBjrxOFdpQ3RHnm07QoP4JU3PzVzETkoFoliAPF/pI9Ns0Q5hsxkNijCogtD7dSwtDIYUPdjPp5KwYSEKk6xNcpSbbCJMhJ9XIitAWReiJuzHkFdsguu6coS7/+T9o2Hl5aQh86+25c5C8KT9OXtHwE3fx2kgv0m6GgSsYRdRt+p+Uqjo3TjcRkPBCwEf0EN3VowSyZAzzmlu2Mv1b1npHZ2VKSsFNS8T4YZDZWtIICyRFbHeHqyiG5y7nCCsWBVCSMG2ZJJG6huew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/mAPDq3dQdMKmtfRPtVskqZodqtiR8rqoEh+QhyuOE=;
 b=N9AfZg0oKpqj+8L4zfnhSeqCErDnzilIeWTkc/FxSO0ZM+fCm7UUPyALNa9hwpl5sJjmNCaRtoWasaQuDhgq9/KLTtBlsRZtLIqaciPPahqB5Nmg+iA+Uo9e01gmHQ97syaBFpLsjvBBd6rVHwefmrpjIJqjaD+o+Gm6v0RqHTE=
Received: from DM5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:3:d4::17) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 05:51:33 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::ea) by DM5PR05CA0007.outlook.office365.com
 (2603:10b6:3:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:28 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:25 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amd/display: 3.2.176
Date: Tue, 8 Mar 2022 05:09:38 +0800
Message-ID: <20220307210942.444808-16-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ffc6f4b-24cb-4236-8d91-08d9fffe889d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5971:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59716A6A274911FD4141C994F5089@BL1PR12MB5971.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjXcG9i2ENlqbOit1ii1KlPQrNXjdy3TXIXP9QjDj1nbFg1k9t+k9Yypie3yPAS5T3zznE+tpS80I8+s3I5xoGjXWmLkHABL2Q9r8OWSnWjpIe+rVORPFlBh3x82bC38aqLBIv8WMWzsivAyjeidek2VPCS7mqWubfHPcxY69QZUBGk2aO6m5MFpT4M+mufw7Z3FCnWzZrdO/iyoGEBVoU2bmu0yynVPpBBlqSeDBifh6lAVladIz4fq3SqJZUaJcPf0vDIQRVdMggKVqojPR2j3pHnfgaDf4t8S9sV/lsQ4YY4uQYYA/KkCKLrJWEvcGDVf78hq3TvvfNUA8Ci7s3kT/jVoJZIIDB5F3sGAbY1iFHK04YdsKXFljQbP/d87DtELCxa2r6m/3aHQuDfUeCoGZSaEzQO+shs3rX/o7O13HtCUNezqAwOTG/DEcEBC7GE3XnYWPxQ/DCCz28m9CUWtbMI+tjuATqft+IPbkBhoHPNxAnqSIDIgfDLkfVEHQvPIfjYimT6f+lA/oOlLm61Dyw8uO6+xBRXXOdUKxXqJAer9mKqKVg1g7cLK2P0lMtE8bnwoOwQmtJMcy3M1kyjXfxFiJHaLdcObNjx4e5eTqeoN0AvsXvDvxyS2aXBlpBLfHUxdI91z7+UsEZA+n02PgclaBz7Yo3Avdf8Xv1YNOecRFCkmnh/WX2goPylrKi7MJEyHZ+9nbzp8Y0t5YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(7696005)(81166007)(6666004)(6916009)(8676002)(70206006)(4326008)(316002)(8936002)(508600001)(5660300002)(70586007)(356005)(54906003)(86362001)(1076003)(36860700001)(47076005)(40460700003)(83380400001)(2616005)(426003)(26005)(2906002)(186003)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:32.7501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc6f4b-24cb-4236-8d91-08d9fffe889d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

drm/amd/display: 3.2.176

    This version brings along following fixes:
    - move FPU operations from dcn21 to dml/dcn20 folder
    - move FPU-related code from dcn20 to dml folder
    - Fix compile error from TO_CLK_MGR_INTERNAL
    - Fix double free during GPU reset on DC streams
    - Add NULL check
    - [FW Promotion] Release 0.0.107.0
    - enable dcn315/316 s0i2 support
    - handle DP2.0 RX with UHBR20 but not UHBR13.5 support
    - disable HPD SW timer for passive dongle type 1 only
    - add gamut coefficient set A and B
    - merge two duplicated clock_source_create
    - Add link dp trace support
    - move FPU associated DCN303 code to DML folder
    - Release AUX engine after failed acquire
    - Add minimal pipe split transition state
    - Clean up fixed VS PHY test w/a function
    - fix the clock source contruct for dcn315
    - cleaning up smu_if to add future flexibility
    - fix deep color ratio
    - add debug option to bypass ssinfo from bios for dcn315

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a57ac086f2bd..bd5f718a9eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.175"
+#define DC_VER "3.2.176"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


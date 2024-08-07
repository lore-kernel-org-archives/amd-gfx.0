Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDC8C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33EC10E44F;
	Wed,  7 Aug 2024 07:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAovga4J";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728D010E44F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgPpsB/gXPwh10uHjvXEB+vDB5Ln1Elyt4nOtd18i2DcK5CLXkbOI+N16lcoR2/2hlTdXlQCENPgRG65UaPCDKiXiLt1Llx8hqsU1IhsJkU8f+KpvmdTZnEDD90qx8l9GWjkgXpTa09gFxCYgEuGeYglH3mmp7lkVb4AOKGihMcW4l/CLwfFlNPKgaeLg+xXnWO5CmTGhy6tln79ZxScANTp9FWVQPRtK8ToTCRnCZIb+Tev6ieP6XSHNcq5zR26xc7oAzDbsBLRrOjDaHt0T/iAkU2ys2RjaCtYTcvDTrCfH32Yw+kXSAmq5mCmR+psHkg0qfzBgLCESb/xGEZTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TKutokYVaXRoOPbgkB795S/7ojfGTJiAkRxCx4yTTA=;
 b=Zjr4N3VZffXQ/0NJg49ll1Tn38gg6KsEnr6WJia3+Eb8MXI3lR5jPUQjWne12ZccW1anT7Q6CNQfm5lO0pqETS7tgKqPVYjdxGTafcFkSE2MtEoVvQsmvwcxxqli50Aj27uR8RxsqRiYSxf1IfryTUdtdMV33IBGUiWnV8i4w2rFaqeBTuhYaga2rW7QyOVHy1v3FRirwDO1GZ+4+4Kd54TK+MlB0XV1ORI9bN9uncFwNcV7tIDffJF3WjbRKXy1qc1OMcIzPV4pmalAFqnvCRyq5JotnooTYxdlD9BmflnK696tSAZpzv9cLpyKS521K/rYXkWdvJbaD/1SoLCrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TKutokYVaXRoOPbgkB795S/7ojfGTJiAkRxCx4yTTA=;
 b=AAovga4JbXTT7vSXSp90RbZyieSugMHvxYXOhTFoZpNwwsQdWIUMkagEJEWdWL6N4U/Rwwhqh+cFEl1hE/c/ylrA1F66kEcJ6gRBYU5cMkO2vhgimurECUNxFGZ4CGXqb3JwNQ5jmpxOybHg8YpnfujPsDxLVvPvUAtPC+yvTvs=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:57:44 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::86) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:39 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 23/24] drm/amd/display: Remove unnecessary call to
 REG_SEQ_SUBMIT|WAIT_DONE
Date: Wed, 7 Aug 2024 15:55:45 +0800
Message-ID: <20240807075546.831208-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c06165-6708-45d1-bdaa-08dcb6b69e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ka69o/6+AWY2gq/JZwVwjHN70aZYT/zGuUuM2kU+3FSfuvSJuEXYCqnqCOIw?=
 =?us-ascii?Q?7MPoklDRcMaXP7q3YvRW7dOp4oQQIyPFgf0HhZk0L7iOlsXPezbsjQYHhfUU?=
 =?us-ascii?Q?KJUDhtU3YHmrYHUIlQdio1F838sUSGtlooqRmYmRLnfEzjiuk2voBIkHcRwZ?=
 =?us-ascii?Q?T22Sqop4kCIaUW+dvHxxibm1HO6ztmiT3fQ5BROABgVAzX/9Fed5r1NlHWFo?=
 =?us-ascii?Q?VoOSjtkql0RZGGbHezYV/wSqrZl+OFoareEcsIMy96/RDGlILgILMaX86l6D?=
 =?us-ascii?Q?F3tBs6LqCQt3KflpM/WPLRdsD0bslotinaUW+fXvMiV2zhpsXY8hgxfokb11?=
 =?us-ascii?Q?hcpy0FeXww+PVSM+nTxd6eXuUkUzwqnLcQUvCg8DGc2fpxr7jDzWp1mF2Pm9?=
 =?us-ascii?Q?BUrfllFre2EFLOBZQk8YjPu1EPi63zR2FcvZgOzFPDuD3p0ToAm5h7dI+wXH?=
 =?us-ascii?Q?xqNO9iHJF/VY4Cy6t8Jh65ajgNDGPuJx2tD7ERm1Gwv9p6YUOZX3N+whSWP3?=
 =?us-ascii?Q?OBufuDuWchWLHTGfQLVpyVtkczfuil7AvGHvS6zyxJP8gg4+5u/H12OQ9su0?=
 =?us-ascii?Q?222qIyNeA1lZnpWpoU+mJP+KaLdh1Sj6TyRyz1zU67wCep8a2aZcmGsUB0Dg?=
 =?us-ascii?Q?oTDdHmmdIxOMDZcuXktozFStQWSWbW+1rSiX4Z7AzmJVr0Oz5D7RE8Oelnl8?=
 =?us-ascii?Q?joUys1vR0zwhmLPVCC+3Ax5uSDDWnmyXm0tOxH2xljp/ToqqNbJpX0cE4Vfc?=
 =?us-ascii?Q?d4Wx/weN3ErzIJ0m5YXUFQsFQrd5RSOCLuNzRfpa+X2Ug1uf27iukbq507kA?=
 =?us-ascii?Q?BQri887xxTnBlLWqE/f49FEFJc+XdOVkigvKESI2nlIxI+b82dk0Gp+dW5eu?=
 =?us-ascii?Q?FQXaCxMpqvJgvdVaPw1QguyYqdahy0rSr6CoF++rGU+kX6r6yLihDdz7FGtS?=
 =?us-ascii?Q?h63TfRtILbOr5RMgJJTqDhyhyU1JLZHO8RVg/7z7Lad54WPbhWvJ6m9PF1N4?=
 =?us-ascii?Q?yv8Vqv3MKYCi7wPUgMADY9rh0qrk2It7pNUVNi+rmagoRuW+oxkEXUeWsWOL?=
 =?us-ascii?Q?Cdm6PhcteqhvZ6Zm7GeRb4CsuToJcpAYjQVDjmQgpzbqpywdYj4j7T5o6cxh?=
 =?us-ascii?Q?5gNvRuP+GoKP8eud+WOBSsAgDBMV5iyliLO/K3XOEsTkeRHFTHajmTnaZ3p5?=
 =?us-ascii?Q?nrlh3L5VJHRoWyNYH9P2bsX7QgGvIRCgYuhXfqeGvgKLOZJPVm7QymaxXfuc?=
 =?us-ascii?Q?YRZIC4p0XiguC6z9amLGxfhzcYEjUZNzzebgqtIMQq7kHB40qNr8aiz42qYw?=
 =?us-ascii?Q?+t7zoqjTN1G8kaeyuIURu7Za9uIad2Y+O7CliPPPI6ktDgpxF696dcVutssI?=
 =?us-ascii?Q?sPzwUIQP+MZC/I7TB0fUAUrYslDuYJ69VCNRl0RjdaNFBlc8KvZoY4p5I7Si?=
 =?us-ascii?Q?qbXmLAXQoVuVjizQ7w38AYZekzGYPYPF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:43.7437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c06165-6708-45d1-bdaa-08dcb6b69e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[why & how]
Remove unnecessary call to REG_SEQ_SUBMIT and REG_SEQ_WAIT_DONE, since
those macros are not necessary anymore at the dpp1 set degamma. Those
are part of an old implementation.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index f2a2d53e9689..f8f6019d8304 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -684,9 +684,6 @@ void dpp1_set_degamma(
 		BREAK_TO_DEBUGGER();
 		break;
 	}
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
 }
 
 void dpp1_degamma_ram_select(
-- 
2.34.1


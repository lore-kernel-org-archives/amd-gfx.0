Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69546C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 18:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A909B112233;
	Fri,  3 Jun 2022 18:51:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3121112230
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 18:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfKkCvsOkVS5Zn35SjeB5cRFHHk6wCs7Uw1iftt8ZfwMvpAFrKlb6R9ei7ejRnXUiwFlCyd+XAW4oVttn11tNwUYQ9jK34T/SWxaGIJNVtcjEIV5sv4NBr+yXKtudPufo1J9u3IcnmFheH9C6Ls0p5Pe9UXTElGD/6kJwbmK2ColgBVYdm9iMbdPeomQOVrCEymURJ7BmNoiX8WXL6L333LCmbNijjx1wA90PD5vsVB1mleAWH1BOd6kVD545AN9DoQNCFVEWxW8nJGTFW593frZGVVhr1jH+E2CQSEfLhrrxGJWyz61mYio/V5ttlMkiYLe+Lxs2ZLxkz3g8WesVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi8m2WIrjNiJ5FsjwVASUppUMq+uET0PpebVzS3VSW4=;
 b=YIySccj9oOOv2Dp16Fl7JQiy0uyXiDrAe2qkLhfodUtgqVu7TUiHFqkv7OmjriEMkfoBgEpuKjvQxX5E6Q0zm167eb0CVxM1KeZAo38rnabvPwff+G+MQ/hjeYlNPrwYGWGXCa9j5gZd3TNGrWbt8xhfiyjwNUk8jbf2TwQU6oSFwishvn3Aut+t/o+GH8m3CffId3mw/4ZIOMjHkPQtMyw+77I9ZjNfUbK+J0N160lA1qrwBS83Dl8YlQcosWLlskCL+EL5bIZhFjh5X9PXVRMUewiXwY2eHbOnLkhejDp3EqMkV/3DzvfX4GAgZEY3EJufItZdkvRzLzG5vdxIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi8m2WIrjNiJ5FsjwVASUppUMq+uET0PpebVzS3VSW4=;
 b=IUF+R8sUXJeDKWZA0rS01mrYdCBxWk540slyC2V/hbqr2OFcc68ME6RFuH3/aEdHCJD0l6KcYEjNDBrQ0qO9rhhuFg19E7oygVqhcduULhv8hfjlpPfaTztN3diuspABQ1fYilPsW9ZfLJPMDVuVGLrzkfRJLMVXV3xbpWZ5S2w=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 18:51:01 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::31) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 18:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 18:51:01 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 13:51:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Cleaning up some GCC warnings and other minor issues
Date: Fri, 3 Jun 2022 14:50:36 -0400
Message-ID: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb95e23-27a5-4276-f665-08da45920108
X-MS-TrafficTypeDiagnostic: BY5PR12MB4210:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42106A69F1967838A7300A4998A19@BY5PR12MB4210.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bi9tcX2d9DiUGsjoznMbaPPI/y2kFeVErI/Jb72lMkYa0cVSwOKn5RvDGP2v7dpJAhv30oYHelz6C9kwYyUsXazb3cJxDzuIgyQlQI4sAl/oK13WCvT8l6pVCB/FZA/NwR958BpoKfIwVcUJ40tZBHBv9ZnOReMZDTEOaIRPUvL+MF5DjuaNuzalQys644qxZKRybVpogR2B/EZd74zVkMfQDQBtc29Aw67GfX2QJ35I0R4rO6DhVY3QHSd8n6T/3+zFQ0sEDfyr/NDnGG7GO2goQbCyhsMiQM0iqtd+716UyTNLVBRyVbM4YyJwJAp8dkNft0wx0Ubi2hR8I3jjfTuJh/QOARxgq8UDS5IKFwF66LDUelWEDEjlivwJqbDjX8xPfLu3Nb3OcMdkdmHAPg2fjP2uJhz1TvX78d/UATohQc9ruyOK1vZyXvI7ozQYv5/e4xVDExcSUofOuX/LOIP08JRnD7cV/xg+mnzxUiZimnggE2nSRhAamrRD80HMa/YhSvipnox3McMY4CVke3lYqj9/i8pxEn9/pExIWTvDgQhFVKi3p65+oP3bKKjOABSboAAHoCkFjq6nud6Q0LmasS46hcNgoUbGPp3bSoVgBUYyFLlYdvlBxHt6fTpepxil3gqwfE1baXJPpNKBjbJZMIXio504TUUkpNslbT/YfXG7C4ijSq79MlacdK6ENY8vFUY7b6ILE4BeNBN3oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(40460700003)(70206006)(6916009)(5660300002)(8936002)(508600001)(2616005)(26005)(356005)(6666004)(86362001)(7696005)(1076003)(16526019)(426003)(83380400001)(186003)(2906002)(336012)(36860700001)(8676002)(82310400005)(36756003)(4326008)(4744005)(316002)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 18:51:01.0471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb95e23-27a5-4276-f665-08da45920108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It looks like that we have some new warnings on display code and a
compilation error when using allmodconfig. This series clean up some of
the DML warnings and fix the compilation problem with allmodeconfig.

Thanks

Rodrigo Siqueira (6):
  drm/amd/display: Remove duplicated macro
  drm/amd/display: Reduce frame size in the bouding box for DCN20
  drm/amd/display: Reduce frame size in the bouding box for DCN301
  drm/amd/display: Reduce frame size in the bouding box for DCN31/316
  drm/amd/display: Reduce frame size in the bouding box for DCN21
  Revert "drm/amd/display: Drop unnecessary guard from DC resource"

 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 67 +++++++++----------
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 30 ++++-----
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 58 +++++++---------
 .../gpu/drm/amd/display/include/dal_asic_id.h |  6 --
 5 files changed, 72 insertions(+), 91 deletions(-)

-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B17CC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12E110E430;
	Mon, 19 Sep 2022 02:03:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA5810E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnyMjTOA9Mxx1pOeyvNkwpSThYxAmL9rSBn6eSVX/efthmFa1GBOrc7JBG3IWDDBxrjE4m1qZyOSfnJHQYQEiLWUAYogz87TO0IUp+LMgQpXemVCK7Lr36eWRuH9oivjRWf8J2dAmC25nOI9870rWj/BBID/vDbYVpakgCyUKpIGAZC9xD6ONcGZOkcTAJ5AgnXpwF9hbKtHf6pH+mkCm9dlZxPGOlnGXLBjOE8PUTkT+aO2x8+Df49AvO87rluc4O59gZnZzXwEzp0dHY1+3SPo8Y7qFHZMtWNf7aKMFHJSvTV1f75U3s+vHkfvbz12vyvsUEjmOPv0c5FVGh3r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nYIFiObR4i3JaOTzDRgBzRYtpFVgPVIRk0G+qS75tE=;
 b=JslcKcdD4xwVF1K7FuyT4ZuxhfBtVMLEdXadDSv2lrLazIH01F0M14hSufqfhNzSV9kumHC0oK7KC95MvJV0sJTjkknIEGewAaTy9O9dYv9KaHSx79u0shEYx6pNGFWBO1zcKRTvK31F1RO7CYHO9Orwi9VYNN5G2DjA0iZHpVu2MCsq6cTp8P4tvsM9mu6mlSx1Zgh6PBBhgBXaDIFFLuPitwazOJ8NFhEidGo1Qe4jGvv2/FCKIVH85XTzhswNNNixn9NrABlcB4GQXPSzwem8yR9y8PQtzyBY7Drx9dluRVLeUqSH14R+0tBw1chr9WTy1R+lgZys0P2j/kP59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nYIFiObR4i3JaOTzDRgBzRYtpFVgPVIRk0G+qS75tE=;
 b=xBmfwXSjtxhA0ucVqdnlLL5eUMhd6A+0rxUHKuYktEbm0o+q27CAzEILLKm79o/fAOcYGiJHrjloqtC8+EVIVJMmAz8DeGqN42uk2hLVVSp6wbRfNYjmw+oonFGbXZ11iyq81kjBftmHR6qhPInj72PH9EHH+dELpcHNNLsu7YE=
Received: from MW3PR06CA0021.namprd06.prod.outlook.com (2603:10b6:303:2a::26)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 02:03:24 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::33) by MW3PR06CA0021.outlook.office365.com
 (2603:10b6:303:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:18 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/7] drm/amd/pm: add support for 3794 pptable for SMU13.0.0
Date: Mon, 19 Sep 2022 10:02:45 +0800
Message-ID: <20220919020251.7048-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec48d5-d649-4ede-f9d7-08da99e32297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX4YlayAwc1+LmOh4qEvJAtj6UbHSaomR4F1JOhxA4sBIzu2GnsqeOyflEDwchMhAeXx+b/aVQKxXoLoEsX5R75algpUp/UL8dOSIHqS/tLc7VRa0YLqn/kxt+/RPg+reYCbALNF1jlh1sV2Q+fBuPkw759jvDRL1+FxinEXI7nkaw0OKbY1gBY3fFPccnuOhSUFFbiApdQ/ZzI5KpsE/+6lZvAlAOSCnm374K+JgMiIDHruBhrOYQrneoPUbHYAt3zLNLaXlMFfe4MWPijObC13+5ypkCkTJv+Qq+i5bsAgkDi6YuJXuN+kSbymoC/90Zr+VW6u3EPIeBNKH/d5+gygRu5qZmPNASsdkdlFpzwSf9qWSfu/qAt1Om15hQLbuXvtM6e72tqrC7hcXBRG9qOGkhAFxH74k03qUOL6Y6uodA7YLaX9XbKGOzEoxyz5ycc6NZlXDVV1uRCbwnfY4n/xKIKz+RsVmCGt2GVjNuR6vfiJv6ECk+rflc7j4BxXPs+u2ukraXli9Ofma3Ucwf8wnYEFa26oPhxKpycreeYpzAkVcirDUpjZyBhGuSwTKCnNk64epmsBaeIDG6s92meQx+xu60zlXEsXwBVDvlP+1rhVsag59azXkAl/jKSRyY6niG7O6G8QhOX/jfACBzjDkOgA3jXvZoaLfgEku9dr7KB7A/7xrrOfaWnDfqkSakhx2PHocpaVIv5O82SMIlU9De/GNBTLstlY6LIOot5xlRQYQfiTdYscuu12YqVjru4Nkx+7Tzpvr7YBhWGA/sqMYjLal1usGV6UrItE34PxkxwpwtyFJS493ftl/HV3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(70206006)(5660300002)(8676002)(4326008)(8936002)(54906003)(6916009)(86362001)(316002)(47076005)(426003)(82740400003)(36860700001)(16526019)(6666004)(41300700001)(40460700003)(7696005)(478600001)(2616005)(336012)(186003)(1076003)(81166007)(356005)(26005)(40480700001)(82310400005)(44832011)(36756003)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:24.1482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec48d5-d649-4ede-f9d7-08da99e32297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable 3794 pptable support for SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia208531c9eb96611b6136975bcbd8d27007b9e14
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index de779f8089d3..a6b7319fbfe6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -406,6 +406,7 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
 			case 3664:
 			case 3715:
 			case 3795:
+			case 3794:
 				pptable_id = 0;
 				break;
 			case 3683:
-- 
2.34.1


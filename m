Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F0C49361
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA52613F2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA52613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A706E134;
	Fri, 18 Jun 2021 17:35:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D3A6E134
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f96tO5r6UAWeD1amGuAfRFtYfSC/B24HpbIXFHj4ggu3aaWkbTwKxULRDh5vmuJfzG7dni0CqGLPeSVjfd88//wCrgW8L6HQx89JRDfMyC7RTCe7gFwsVVSCZQ9RmKUa0LIu74nlgDYCkG7yz4AAPwK/9mhm4mONU0Ph0++ZNTbJ7yzM5F6BXLgUkuDimTMeHfjFzbwWMNlmmTYE1+x4o6gPRf/ZnzpuBHLNQ9gZeUCqElTWrzTnV1xtE3B4LYf3LUigTFEM6Mjdmwjd8r7y6R8HEROdBEmaPlSsEIBZQAY6PNfCyZNQgdD6guI/50D0MbZbCH95VI1QbYoS+Bf7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu74rGBX9w7iat/LRU3aWKe20eUEGUO0OpvEUgyCjAM=;
 b=kCWBsXi9etUa7jsstRWzv2F2fOyD+1XUL0FFMAUOBtITsZ5KwgkD2Sv0lN8lP3bKMrjHHCADedQRu+41wFnZ0G/+hcEIunmdsWxf2ov8SsLw5XTLC6Cj86IPU9u0V+wIvlLbckAptwl95ySvNlaQgorkEch2dZyFyDOGU2fmE7wz64t0kAPM5YBN6OtxLij7cFsabfaMcmnsJ2owNGSqYCtdeDhu0hFUq8+5VC1WOXO76ZfLoaCj5R2ORY9t9kDgNmfdkRvXA3ZLBdrHNeQRIb5Z2DZJoSrifKUaq5sBa/qEDXfu3JsJMo1Wvu3bUp8g3eE7qQ8bJnlXUzaOHy3PIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu74rGBX9w7iat/LRU3aWKe20eUEGUO0OpvEUgyCjAM=;
 b=w7XsbZEYiuO5Y8qt89rxc8MjQtCaQGVmWh224NU2WRWsIM/Epv9eyu42uIT7/mhYuay8IWcJwOuMOZ2rKQx6lRSIIYBYSqjjSWufVbXS45DyZRLDSHXcKa/QMhQNgtnmR+vFiR3eomtGIwaNC9dvH6ge3TeR2fQPiuq7BBfnDew=
Received: from MWHPR10CA0056.namprd10.prod.outlook.com (2603:10b6:300:2c::18)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 17:35:30 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::b1) by MWHPR10CA0056.outlook.office365.com
 (2603:10b6:300:2c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 10:35:28 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:28 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Clamp VStartup value at DML
 calculations time
Date: Fri, 18 Jun 2021 13:35:04 -0400
Message-ID: <20210618173514.430647-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29826462-aa7f-4e51-02ba-08d9327f77ef
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5454:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB545496BB62FA1F6B3016C8B7F50D9@SJ0PR12MB5454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKuBAF66a2DWTOPqOtsAOoZdWcyu6BmdQgLT4F/j3LAPumU/j2kye6b4wsGMneZSA3AmvKPDa9aJzVFcH530H/1C/bBi1Arco45rIz0Do7bqQIaKUCOc6MbfS4i9pWJmmDoBwTvi6PrrUYLFwfBDh8qdIWM+T372JlwAPYAnqNoL54ztwL/zYRHiEJCslCaZnNO0cMbFURgkvEkqpQxyeB/+/ScKJOUAZHGFk4GTpCGNscNjZbakuYOCHf31cCI6V+UECItgS0mWMmQIbdliRTZTQYRySMTGqCNevSxnJcYUHyYzsdcj64+R/p5G3uXd6hZVzyPwYfOzoLJpFkt1MCBcO0KFxEnC8DkXmL213ZkuiIlkWaZx2J+5wiMCpaVOI9Osh5yzX891Zd9/OvgXDlA1pFVqO2DvFZv72mm5Hc0wRTrS7KucrNE9t/gIVoUWvB0FkQ4XlHieDhyY0YoZ6k4yHQNiwqDmffk0pshSIoKPk1CXWxojPL8JYwDiHdNVZMx73yFGSrs25Kg8UcpOco+tt/OOs8n+a79dECJG5vfQo+k1xnHMPpl1Xk3WBDZTxxp+ccLofcxQSLEwCTpFYnmdPo9hAkndk4ULQGhnG0mW6dYC16nV9wiJglyE8oEMQ+IuqpXszFiBYa6m6h7U2fSebH5BhLTFZJqaIHCPFXa/1lrtdFUJDvxx/g9X1Ax4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(47076005)(4326008)(426003)(36860700001)(2616005)(70206006)(54906003)(498600001)(8936002)(83380400001)(186003)(26005)(356005)(1076003)(6916009)(8676002)(7696005)(2906002)(5660300002)(70586007)(36756003)(86362001)(82310400003)(81166007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:30.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29826462-aa7f-4e51-02ba-08d9327f77ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Some timings with a large VBlank cause the value to overflow the
register related, while also producing other wrong values in DML output.

[how]
Clamp VStartup at the DCN3.1 maximum value

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 06fac59a3d40..718d5a99dada 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -2668,6 +2668,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 												(double) v->WritebackDelay[v->VoltageLevel][k]
 														/ (v->HTotal[k] / v->PixelClock[k]),
 												1));
+		if (v->MaxVStartupLines[k] > 1023)
+			v->MaxVStartupLines[k] = 1023;
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%d MaxVStartupLines = %d\n", __func__, k, v->MaxVStartupLines[k]);
@@ -5064,6 +5066,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 																/ (v->HTotal[k]
 																		/ v->PixelClock[k]),
 														1.0));
+				if (v->MaximumVStartup[i][j][k] > 1023)
+					v->MaximumVStartup[i][j][k] = 1023;
 				v->MaxMaxVStartup[i][j] = dml_max(v->MaxMaxVStartup[i][j], v->MaximumVStartup[i][j][k]);
 			}
 		}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

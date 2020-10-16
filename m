Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29765C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A551B2078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="quwHDb0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A551B2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D166E97E;
	Fri, 16 Oct 2020 03:28:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059046E97E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGdwzQ9TesIHluMZLSgT7vnmEnWN1MlED+SfcKKX8U3RqwnPabr0n1exJRJgveDIu65mugb76KGA/imBdxbGJxyH4xqN71Td3iaCFJ2qq/samGiko5Q+joPJRokwAGGerM/f+bPeyKEDA6Qwtov89BG4w2D+0tU4VsJBnBm3r+M/zPyU9VkpLe2s1BiazIKdlk5n5KY+P00FzDeDu9jGmpwFTbwmgEyGMLZlVDwsA3DoUbLlTU1MxvYPQCZl5FzLuO7A+72ZGnVHrVR8KoAlEnbvxxKdCiOcQEggJD00gf2k6q5kc3unE2ahsbYrPiANxyKSA+QoVizC1ppBXG4rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M9Fe0Enx5O4UQOGk/1HLFaIwThkjRnrLjT/5TlkBVc=;
 b=SkxyLVB8M0RhECo5QOlpB8uqkdZhTrIEg+4RwipvkO1XR6sn/NCVTqYiCigg1VKy79wHufEtE1FWtar/hP7/Ebpsi42AM2ZJHrXGZMrdMUP2Vz9wBVPhjYcBlp/Vgxlt5k0iy4jtR9+s0ms/bFXfuXfK8o5+6kZgWcnN35mVoP5hm4XQy6A8f8PPYF5hOuIzIg8AKDdvjxtU0gEylkhaM45s53XCUGHsUiLRTWw/fJZ9BmtdcS1vGcqT/IWcZfGwi3GKiWCTCDMMz1h1wsz0voCLgPxk++UIUHuoQeudI+la3b4IW1re6tpHFt3W4TzC28NZuCiLfYeJXa1FWCZA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M9Fe0Enx5O4UQOGk/1HLFaIwThkjRnrLjT/5TlkBVc=;
 b=quwHDb0O/ogBNpTBsK/zusJLf3q48mnwHkBlESvUCgXbf7GAsgOHcO/cPW6cLimC4rm68X/gvrL6dakqRRtZ8J1DailQcNfJyn5866f+l4tSVmI7BxBV4J8fipJ6qkrobUpAL/TWyTPrrDHv74P8Yz01cgNss/zXLxubwFo4z/o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amd/pm: correct VRconfig setting
Date: Fri, 16 Oct 2020 11:26:39 +0800
Message-Id: <20201016032652.507-28-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c9dbc55-579c-45ed-52e1-08d871838771
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13541F8EDFF7E1DFDB4798F1E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFMxF1XSiuIRS5BLlYki9c+YFbM40k3W4RvHpXCwXeMcdXzKJXSBEi5Jw01fn/6Zzk4tcTM26egJEzpfVbIGwKe8SpZe2IdCHWAkYCc1c1HYabND+R50X7XfRX+DxzcG+H1hY2UZD/sFOpXqTuCQPSwn7w59GRPuZHbE3fohP64XkaoRg+ggtjsBgp8YEaSSR5HWgkysqx51xoSyUKYyByPDfNezYuSG69uy0U2VArJBxbHjBIl6MeMHbVOnUz18o5emfBNTuKihKArrBadrWqPQxR1QhPWmGw3OxZmrtCKcJ+tAxbT4nej+yEjp3sb1gSPVz6xgpv22S4Wvn14mMCSk9yk87g8ujCNPKOG2T+jTMaowL8OS0+KIFAMEsbk6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eOvJiIXWMAz/ERzJpEqRG7s2hhvVDLRW9o1wqRBmjjxB7E0Vvp9HIDU58gH5IZWWuwM+FskHjcRCsKJTfZf0TM3aCZLGnoyPP3RXdTZ5V6r+KHfeeBhG6LHb+4D+c5bZ0ulkQpofpXSgIgFMMqu7Gz4kjYj2XLL7LmlVmC+Me64hBAiwYYGf0NcyZ688gO3P+uuxv4hbTV+HC/mzi069zLVVrCNWmhvscdWo4VeeN4d3wD2tgVtTKZsuvMYpu2yDqkfVuSBE8G186qO3MhaoghLK3NVTMAxDARFlVGLejee4fIuyqhTGpo7dsuCLAAtlbAmSHy9QpAjHfJDleb1pY2jX8x+qspLxiavrDvo9m/O85qIDaWeWHAKx4AG5uihCZNedKUP14e4t+HsJ0TPJbqYPvBOeoT1fwd7eH11+Ir/KHer3BLiDyMMwtslasJwlqCzTqAzRc/gwPNfpdRuzQW5ggcyJAbAQbCqwJ85tI7FDlzzi/j8J/gOYCRXogGvjwcf5oBpJwoYURi4pWshT1zXyyNdG8FU6FIZDQSnQeC9MUYWEqMIg1ZPQSXGE1GJZWUVExUfYQoARW8mgXFUS9NPcRa8vToHXRAC3Wf6oT0wwhKSE9TuPjxuYeyJhOeXggppsnj9hxbJhOaQj2LrgOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9dbc55-579c-45ed-52e1-08d871838771
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:20.1429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We1XD+fsWHusQbmC0M4ye3fuZ3QNNdTkFioKiPAX3qexaHqHTYrLTsdrVtKS8SZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris VRconfig setting.

Change-Id: I8cf3151c04f130ff25fb12b6e4bf994cba2bd91e
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/powerplay/smumgr/polaris10_smumgr.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 72ca4bd2c2f3..997b996b25bf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1712,6 +1712,9 @@ static int polaris10_populate_vr_config(struct pp_hwmgr *hwmgr,
 	if (SMU7_VOLTAGE_CONTROL_BY_SVID2 == data->voltage_control) {
 		config = VR_SVI2_PLANE_1;
 		table->VRConfig |= config;
+	} else if (SMU7_VOLTAGE_CONTROL_BY_GPIO == data->voltage_control) {
+		config = VR_SMIO_PATTERN_1;
+		table->VRConfig |= config;
 	} else {
 		PP_ASSERT_WITH_CODE(false,
 				"VDDC should be on SVI2 control in merged mode!",
@@ -1730,7 +1733,17 @@ static int polaris10_populate_vr_config(struct pp_hwmgr *hwmgr,
 	}
 	/* Set Mvdd Voltage Controller */
 	if (SMU7_VOLTAGE_CONTROL_BY_SVID2 == data->mvdd_control) {
-		config = VR_SVI2_PLANE_2;
+		if (config != VR_SVI2_PLANE_2) {
+			config = VR_SVI2_PLANE_2;
+			table->VRConfig |= (config << VRCONF_MVDD_SHIFT);
+			cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, smu_data->smu7_data.soft_regs_start +
+				offsetof(SMU74_SoftRegisters, AllowMvddSwitch), 0x1);
+		} else {
+			config = VR_STATIC_VOLTAGE;
+			table->VRConfig |= (config << VRCONF_MVDD_SHIFT);
+		}
+	} else if (SMU7_VOLTAGE_CONTROL_BY_GPIO == data->mvdd_control) {
+		config = VR_SMIO_PATTERN_2;
 		table->VRConfig |= (config << VRCONF_MVDD_SHIFT);
 		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, smu_data->smu7_data.soft_regs_start +
 			offsetof(SMU74_SoftRegisters, AllowMvddSwitch), 0x1);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

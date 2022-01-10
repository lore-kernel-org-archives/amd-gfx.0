Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A516FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 09:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD8D12B040;
	Mon, 10 Jan 2022 09:07:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ADB12B044
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 09:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhKb1tXfgFi4hPnkuB7f1dYWqCQL496sid0u+trogqqZRlZ6wez02gTXW5fsLBNUd+XgwN8R7q49HASFC1z5fPGVCtSyjqF5Zoq9T73lOnLCwFHa0BXfVhM5hwQ+esk9NmeutEPfGxpdus/m6F9zhEa0gaQu+JHCT/Oa+9j3gsm90pNMo2HBpYql6RvpxUfwXbdidHxiLNRb/dHYbohMA+NJ4YL5DKh/3kS66DXTBMedJ1jTyV5ECTI1CpYdmH7Q+DfYMhpoFfrlsJFwAxed1V0TxQLzfAtlujyLmJLcU3fG/yA5AR1uhDeXQQR5NVoJBfK2Hvj9/mFQL7YALsxSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9lG647xfQehDdFsuPPTY81t9DAEhTKuSlLDzOG8+iY=;
 b=mcGY3/ZhNm/T358+MOa54naq4eL4ovJ5hOHTKAUS4qwVfF/5c6X1zPb1WuYVLOpl/2uXS6gtMdQwaYQLPcpAFbP+ZZBwWndpkrasFIPIoGrdgyDXDuCuqTLfFXGbe+C/2k8FKrNMyJDjv69PLYf4CkYLmzz5u7bpzZbHcF7sY1qfhb+dVMFTr03NdqcseN6hjsbP9A9BPu9k1cVm/OeLIrYCdC9nZrFA99EoTQ01tkrwWXO9ORoenaEHsXsFlqzy3dNj2c19p3TXyLQ0vhhgfpHBrJNtz2s8UFsj6sNO9+mYpCYcbsJRfyPSHCb7HM/YJlPHTBNApDhsS6VPuLVFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9lG647xfQehDdFsuPPTY81t9DAEhTKuSlLDzOG8+iY=;
 b=xthHpvv0t+BmEprfnE3Dx09Pd41lnKI2VDjHxlHbmxCK7gELAhu7uUUbkbULIW0CP+kRO2fAL6sOocku74NgFFrBVhL3Rjvczy/jdSRY+eGAbMc4u1XRSBihHXQhrZjex9LM6X1GCVtdvEA3yQasm+LItXUkHgxZSLQKh3IYsEM=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 09:07:09 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::46) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 09:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 09:07:08 +0000
Received: from ETHANOL-DEBUG-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 03:07:06 -0600
From: Rajib Mahapatra <rajib.mahapatra@amd.com>
To: <hersenxs.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Not to call dpcd_set_source_specific_data
 during resume.
Date: Mon, 10 Jan 2022 14:36:52 +0530
Message-ID: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1743460-1cec-42ef-488b-08d9d41894b8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51442D825ACEFA3500909973F2509@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vb7HJpxUuZegnz4gFZgRbH1muS7pUMgzW/htJTwZJr87PIo0IITr2J7R94vWSHTlyfDGSVsYPmy7DWoQVfsfyauxTvOzzK5IVpHlC2XFaXOQ/6zrOx5tx8Z3bq7Gu+am2rWkpKiQ8s9kx3k7oXKrRv1MxIyhFmzkON+fICnaqzv1pem6wpVnbAPCI2AUUObkvtIj5LGzA2Z8Zvs2/xjEeE0aOyRdFwd4odP1Yc1GsUeZoGISR25hoNIghTo30vTiVZ5hKKUwjI8GP+nMZgyWDDL9i1hl5MdiKaNjfo8SFQdeVb8fET1edEJZg5YUjNl6+B25jIkX4NLbxws53Vv6GNLqL+a9VHYtoxvaMZf/PVocHf/kfh+jATbSpyRisaqnivjft8nbAOm2i9cWf+sjHpeTYTxxlpFv3Nc62ULgelAo8SP2TTe2Ilif4fOU15ZEqgecApdg5pa18SELJs3V/IBGKbanffPFlZEcrF0oBQxLUbKZEsFBeI5WSIrOrTNWU4NQ14N/VLN6SZZiuUbKExOv+hN1fKtzZubkTyXVMuFh39gxIgBbBKSY3NrIhkHa/2rM3XYru7poM7ile3Q4YxKyUacyE6ApCET13cD2z8o6j7uOfuRf+eLRT2kZ6gHOJ7KdyINy3hZu21yzBpBVoidijfg1hqDjfd5YHd0mKKgagtkHT79pawm5+TAdtMSUl9wJwryNtpEA55dUsMTMIMi4StzqEtnUpX6HEq2of28wqtssV0ck6JT137qA158oZXL96vSpdOicMw080DD4kzEdJNWNbYeV+ltB8d+QgUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(86362001)(54906003)(83380400001)(6636002)(6666004)(40460700001)(82310400004)(508600001)(110136005)(47076005)(16526019)(8676002)(2906002)(356005)(4326008)(426003)(5660300002)(70206006)(186003)(70586007)(8936002)(336012)(36756003)(7696005)(44832011)(36860700001)(81166007)(26005)(2616005)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:07:08.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1743460-1cec-42ef-488b-08d9d41894b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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
Cc: Rajib Mahapatra <rajib.mahapatra@amd.com>, amd-gfx@lists.freedesktop.org,
 shirish.s@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
During resume path, dpcd_set_source_specific_data is taking
extra time when core_link_write_dpcd fails on DP_SOURCE_OUI+0x03
and DP_SOURCE_MINIMUM_HBLANK_SUPPORTED. Here,aux->transfer fails
with multiple retries and consume sigficantamount time during
S0i3 resume.

[How]
Not to call dpcd_set_source_specific_data during resume path
when there is no oled panel connected and achieve faster resume
during S0i3.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c0bdc23702c8..04086c199dbb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -892,7 +892,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		(!link->dc->config.allow_edp_hotplug_detection)) &&
 		link->local_sink) {
 		// need to re-write OUI and brightness in resume case
-		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		if (link->connector_signal == SIGNAL_TYPE_EDP &&
+			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
 			dc_link_set_default_brightness_aux(link);
-- 
2.25.1


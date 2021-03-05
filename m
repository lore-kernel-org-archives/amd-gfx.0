Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE1160200
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1160200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFD46E372;
	Fri,  5 Mar 2021 20:03:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DA16E372
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzOqnbRf5gvq9Wp0vosTZun5AF3ZPjdFdd7WNWB63rWZj41SnIgEWrMBWCUIMFXWzja9tvgT3fudF6+BzBlfd1BHzhemprgEEV/JrJC9ah+YKV2MZJfJZ/yQ8wHvYipNflzUImRfW5tp/oTe2Uzv0N83qVJ+VCsW/tp2jRKOPucp6PODTJl2OcABMVPuD9dSV7HrNav8XaTacq4M4/HbszZKE3V4XvMXxQZ9oV8AkczqCVtev1ujSuEoahb2tJY7G3WVP9P03RY6ZxvzX2iLAbuaaOlX2YzuN9DSVK0VURVnBU7Ez/Gb6eJu98mPTb5zPq2zfFUQUQyUb7HBze+fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYQBBxi2aFVMrxP/rn0tbDNr0ksB4+zxpxxLaXGJws8=;
 b=Qi1W2dWQvJVua8/S7T5MWO6hAPwRIY/GsHf1bUnF9cCaPltEKp+o9jN+5mbap/Dyj52RvTlPKK5MXUOGDbIYB+fL43TCcc/YFoBzOj6yZImANKBrURfiyzXr3iwdslLWHHn6qvI01ulhgzw34qk3Ien/BJjjRetOtLz3bsqpYjC8rSuPK0kzUH2lP9gTOGCh69282aAEbu7fqqTcsVUN3Mpcy49IlYaEryJljbcbUw3EZJJnZC5KwTNiLt3crOqUIVp1ZDLCSwE+Z5lfQrH9A3pFRnO02nGitg3Ulzo/fRZ6jlDxj0veoP43VE8s4AYnU6uFSvOXiu+SZ6DmZa2+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYQBBxi2aFVMrxP/rn0tbDNr0ksB4+zxpxxLaXGJws8=;
 b=c/hliz2j1BYVosIBhsaZDgia8Rt9apAciF/9racenf+4kHHF7GGatEe1xBjQaDPERLR1xxzjlhT1U0vaIXbIU7pY3QyilRgLpK9wMIxSFoWMw20w2/dR9tysf/nRJml16Qwi567N/3uQDMlvxtLqRaDNAbl6Z63AdRML7zzn3vw=
Received: from MWHPR20CA0027.namprd20.prod.outlook.com (2603:10b6:300:ed::13)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 20:03:53 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::50) by MWHPR20CA0027.outlook.office365.com
 (2603:10b6:300:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:03:51 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:03:50 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:03:45 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Skip powerstate DC hw access if
 virtual dal
Date: Fri, 5 Mar 2021 15:02:49 -0500
Message-ID: <20210305200301.17696-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2e95d77-0986-4dc1-16e1-08d8e011cc37
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32602E06581B4704DD7A0B6EE5969@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikakmVaJwYoXxVriT90Y7Tp1GVSNMRDTE0WzrmVI1cVg8MEeTCedNe/VrEuplS8JJTMRLp4BK8S7T2FCGAisIFYfsEGoknBfANl43HWGKqJI0/9s1FssmXpWCc7PwUmbDs+HZKdtVzQw4OskMIweY1wP/Rh8wYKTstOk2XWZZrOQeKny9tphEDz+oAnu/YgHSZgPk7Mi0iB530N8BKHSqAxDlyvHZ/ffUUTZiibTDrSBLnngOQtmcB1D2PUUp7ctiMCqeuSbW1d7qxQ49LOaooW0kNlkE0mfExR3TArq/pgvUyZA/p3en3J541Uxiy0nwkR6c5pHrWEzpCKYaqMIZkRh180pUkMI6EwfhKoq7X64NLCrLwqRC9yhhJ0bMwTmosXte7jDF17Dwdivl6sr3JwBiGQuW/q3Y5iSLd4yKsp0XtijiHZDAKIGcLe3yjBThYD/kpiaAytdWunupFbYBJowUBFCRZnULWHOEIxZGB+N3FOAN5kU7R2aDAykH66f2Z1kZrQUtB3k3rmuaTN5vVEhOJqv+4X/pWWRUhKUCfLNSEqYNhVLmJDzzIpvL8uocQ2GaOEKUPvede8iSp216yHBL8bMnNb4EBcukFlmh+rWF7J70hSCcTsMsW5BHvYX61xsuBL9+5F5Xe+M0K9m6l/sIHLkA8mK9AQNrTFeOl3ZMTA2Rr54nQ0td0wPVJzd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(82740400003)(478600001)(36860700001)(82310400003)(36756003)(26005)(70586007)(2906002)(186003)(8676002)(86362001)(5660300002)(44832011)(336012)(316002)(8936002)(54906003)(4326008)(47076005)(81166007)(4744005)(2616005)(426003)(1076003)(70206006)(356005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:03:51.6654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e95d77-0986-4dc1-16e1-08d8e011cc37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]
On baco-enabled systems running virtual dal, can get set power
state when hw is not initialized

[How]
Skip DC hw part of setPowerState when hw not available

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 87b8315cfbb8..daf1b20028b8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2887,6 +2887,9 @@ void dc_set_power_state(
 	struct kref refcount;
 	struct display_mode_lib *dml;
 
+	if (!dc->current_state)
+		return;
+
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

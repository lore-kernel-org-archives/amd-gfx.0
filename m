Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B112CC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7809B61248
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7809B61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50E489E3F;
	Mon, 23 Aug 2021 04:33:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C2A89E3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 04:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvefQKfA59mRKqN2O+uvsUCadAmQ/ZPi+EnRnSfzC+NFfmqP6hmo5921XSEFHmJ/+tme3ZaUNt6HhmBH3MHBGGqlUvz2rhqEML+LVqZ+8EvfAGRMDQwZ2OQEyG2MeHhkzdQALir6rILX2OwiOPitvc/VwDE2aRvPgC+Z8i1qQ6VrDDQAYj1iLcUZlSV1Dec1YPN0v1o9Z5LPgXP7Vo0fQ1SNkaOHP4vX9F/8IFjODL4Hn5RT+qnsifF8u8XDp66hlJU3pE/gFgWvhrS8a552NO9NThq51kxv43OicBGFCcxuAzBcWnXWY5kqKMii8mWawpm5Qwrf+Ek7eqCrk+/JbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGWrlx6mQDfagyH7qVEldlWzMOrpmt65BFS6G+asBz4=;
 b=W7sa1H7o1Wc5ffjocy50xI2hs85EMOU9KhflaSDN25RxBE5LNl3z7axFPjoE+bcZQDEleud2UsErX58Oq17Ikz0f7+oxvV7FUFeAx4bGyEjKrRnliXhoMivqmIuAvq06ARlDQQrP+zz4gfz7HMGOx+82iM4mjCN3Ggw2xQyALes+XMx4N+wcZsLZGbcR+pHa89bovCxsHmg8axrhNwdVskzFSBwMhs0ahjSPEGc0x5IPav5XAqg8tdGD3JgKILoOvCcfsBggXfmNThvzpmf1fdROh4J0Ur0h9iTAtIUcQF/ztlHUiqRxECkB7uWLLUdStJMao49Hen8pNfNLkqS6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGWrlx6mQDfagyH7qVEldlWzMOrpmt65BFS6G+asBz4=;
 b=RNCQpGye0jxdn7EOBxYXdKQmuCt/UUyWs6JZIKaeNJcAjlELMU3L1XbT06ZVgOE2DMXL0gurDRiMUgl5hrj5WsbWEmgdVu6pkGtox0bYbFN5i0E0CXWTtamgVOqFY3BPkNxjOBB4NMkLB0XjmmIhBa55q5FcdUnQH+tkhGu6S2A=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 04:18:00 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::22) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 04:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 04:18:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 22 Aug
 2021 23:17:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>,
 "xinhui pan" <xinhui.pan@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Date: Mon, 23 Aug 2021 12:17:35 +0800
Message-ID: <20210823041737.48921-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210823041737.48921-1-evan.quan@amd.com>
References: <20210823041737.48921-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f554c6aa-7fbe-42ef-055e-08d965ecfe3d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:
X-Microsoft-Antispam-PRVS: <MWHPR12MB126403BEFC57AE361F5D9F7FE4C49@MWHPR12MB1264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh3yESPKuR5Nr7gIt0MPnX636zVwUcHio8Mrom7gHc0vW04iH4oJZ+oYF4TBWN1SWIiI+rSkEvCcQO2PTqWlYHjETuG3M8oBVY4hTY6fFUPjqlRxx3/S4haR9LZndgm0FbQBG/gOKjo7qJ4iUhvlh8fLojqMIPWotI/TXiLFA6bG1oc8KWR4++eJPaiwnysBN8KVAaNimMkFHJSbUPKO8EVKIQrqiVTOd/vxgVRBcoEpZa77Ys4/pXhhKMsiBPm0oeOxrftWmLULZl/Lwm4igcMWkaSlMSCccyw+FpFnn66NL4oQ4+8EnLC83bH7JveJ8bZtWQG34w7domgUjbUztaz9b2DRZBh4yIkaW0cdDGeVS0oQCiMXCCOOgd1UsfdcP4SWcyZGu8voC49o8zZGXR2SgsyYgAiJkQi3CCXTCt59kSC6ZafUyNUAWu4udSwT1oNREltaqrNJIiRqWCruYl6+IQ1t9j6BJZt0nKcnJkcRhOqwPTpsH8MGR/ZYMtyFOD1vbI6P3ik4PHbVb/JQwULGgYIriDSOFJbPXuKnoDiNIoscvIHISSeHY4vjKGDal3/9AZB5Ah1+uCEYGjxmqH5vIfaKnFDFMRMZCf6yIYEgoSHlh6yXExuChf/AsJK+FM94pMyO58txIgCTAUrjtwTyuAoy3Yt7SH3i/8R1LSnPSsioxdgtviFGR64x1Gd22NDbxoCEp1BbBnM97OT32ZiSA0U8W0Qejlmvo5evxkShNaeWgpueG/iT9QNgJSrbkdaGFOwDEWIIl8YYr6SCFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(36756003)(356005)(70586007)(5660300002)(2906002)(8936002)(70206006)(6666004)(82740400003)(47076005)(81166007)(8676002)(86362001)(186003)(6916009)(426003)(336012)(26005)(34020700004)(16526019)(82310400003)(83380400001)(4326008)(316002)(54906003)(478600001)(7696005)(2616005)(36860700001)(44832011)(15650500001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 04:18:00.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f554c6aa-7fbe-42ef-055e-08d965ecfe3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1264
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

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
--
v1->v2:
  - move the changes to ->hw_fini() (James Zhu)
v2->v3:
  - correct the sequence for clock/power gating (Lijo Lazar)
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4eebf973a065..b45d0914b20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -543,6 +543,30 @@ static int uvd_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v6_0_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6d9108fa22e0..67af20a38ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -490,6 +490,29 @@ static int vce_v3_0_hw_fini(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+	}
+
 	r = vce_v3_0_wait_for_idle(handle);
 	if (r)
 		return r;
-- 
2.29.0


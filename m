Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E084EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDE610E155;
	Thu, 20 Jul 2023 19:20:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49FA210E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEzzMRMRsmnLJU1rtGW+Uu/lc/eSwHtQgJa6dDd/wOZmqMfbEa2h6Ui9m+C6MasJSpAqGG26qM/e6Ep9erv0tt0ei+64d1i66uMA7MMxvKAos5yZTlqlJHxSjYCPeGoS9oCk8VeJW8LI2xFs8KmhaPnss4f1zRg5cNJdt8YJv1W6YluxWuQKfYvo98OSscPlXoXdRhdVIVOQZA3M1oLCUKtQR3AGUdf5c9iCaHsrPAVpU/HbuBZsrFSDSi4g2COVRZ8a2BfM7FwI+iSt/xAP2S1iW4A3amd0Fj81iVJneb0j6AnrMZLKRu1SmP7eh1l693c49XVHdnghUkW7LPZdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=DKTh4yiHX2ydKL7Wxd5Fpqd4oftVg+b7lLkCLbFq47zi3zTjJqWgJ4LuJfV27LKcLnTffQGcHbCbbT/Mz9oMPx72EkQjxuIDtXIv9nv+Ug3/9Dcybf3xhSx6B3fhz2GY1L8lOmTV0XxVDYKXUpL5FdCv5PYAsH875GoeFVCQwGMcuQgHW2WNkr9T8vRpuI3H23aGRP/u5SJ9DF5mf+5HYBO/alzfTVH3XAw1U5F/WEC+/Nhz3VhzjkF3aVBAE44tRbK1q7Vni7IqQz4W47ScqEhHMGSny8QA1I1i0JStU2U5yGy7bEobwJqOnsheCc+oQ8V6WNgZgleq0ETcVsi9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=vlm7fyyz1f1X22nZCFXxs/Cfw/I8MEJIydg4W29/nDdbWvpkWxOyisVnyS72P5+YL8hizNNBxxoCQUYdj23WmRWcZl0gRcbg3y/TDCoMRqsgMtsJM/k+VgTEBPeMTX/aYBn3yDUFTnRzxkMCqTJBz1ABh00IimZ8MU2VA22dVgY=
Received: from DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) by
 MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 19:20:21 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::c0) by DM6PR07CA0042.outlook.office365.com
 (2603:10b6:5:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:20:20 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:19 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu/vcn : Skip vcn power-gating change for sriov
Date: Thu, 20 Jul 2023 15:19:35 -0400
Message-ID: <20230720191940.780187-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: e57febcc-ff87-45b6-c66f-08db89565c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miafpTKHnUQstK784UEVN805fb9Qv9t+bJaUVdBPf+dyS1xaztA1BAl0lft6H+BPT8j3/07ZkfKcDuz+Ac4hGZYUvyoX7eaTnKDuQg4n58a6CGjVbMSMCMAuZIuGDi/LAESLtdQRH8qVXk0p9cYTKACqRfNX2MUxmqkBU787k5p6S0Hpl7aoMX3MI6NyWr1Km9H2W1dipQKQEg2/om0op8MC2ux8BNEqePyH8nyIsAdKoyCq0gcLoUts7z9Mozs16Tmd1Q1C2/sun7mRMG0PFaJkYgMqNNYctLIjfTpOsZZyDsZhAKtTzhlFfPHp7TmHd9j0keo+xqdh0jPqHuH/HgNJYemQg9Ma/Ji+TJcxYbi+mSxWdVA+3RVE+oCrC/bZK3APuF/IRINMOhjQohEOf11m8s3Y4geZeaycTNrFbyCNtbhv6FLfRjFm9Fi/aj0oAm0nmjLfdx2BVKRVV6HEmDpOW3K39sKv6wAYafQGbtn20KDmXUrx4ve7jR8UN+ais1hSO3HMT6G649YiE3Xhano+UwviKfzyqf3zUPIvqbT/tf03flzkEupZRwP3HGlDDlTlZJREpfmrOdm/7zfoJiDrh1ayJOnx3R/QalzM7J2ZUiXaay1ZDdNyO/QyM3L+bERju9Af40yYSpjRH0BrF8jTCA0VWhjeGtQ+Jrf9vqWfcErHlqdshh+Bcqjc4wS6e56KO2LSFt1puJam1wnNrNjdGbRjlJlvrc4cadrESstO7B/hFmyv1+tV5XO/fWy/o+lATd5wVz7mq3pttVIfVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(5660300002)(8936002)(316002)(8676002)(70586007)(70206006)(41300700001)(4326008)(6916009)(44832011)(2906002)(4744005)(478600001)(83380400001)(1076003)(26005)(7696005)(186003)(54906003)(16526019)(2616005)(426003)(47076005)(40480700001)(6666004)(336012)(36860700001)(81166007)(36756003)(40460700003)(356005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:20.8054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57febcc-ff87-45b6-c66f-08db89565c1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 550ac040b4be..411c1d802823 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1317,6 +1317,15 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.34.1


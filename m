Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EEC11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 04:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942D161469
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 04:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942D161469
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222A46E9BF;
	Thu,  1 Jul 2021 04:37:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B276E9BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 04:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmKic5tj0FWePPCfWZe36qGMDywwxMZXiwLcM+ET4DKDlZ/3yd4HPpWIaciT/fKaLXWHwnaqAAPS/Bxes+HL94Fcj/fEnWAdDJ9Tm1uUnnNXcwyGve7IEdaaizxj+cTHleLsxBBLyp+6/VYr73N6gUMr+AgfnZTDs8os8kC3IF/nId8Lca8zhNm3HRWrl9it5OJAAeyhmDvOjL9/LrqgZ/MoNSwqmlqtKsIrMj2fxNcWB0j+PpX15L4o/PuEig+AGuK0Nm4Z59Wi6zaMxlbLsPeB91h9Fz88zSJX5MU6Am439OszlUBMdXQeY4yW5AnappiuJQglOi6wxjFHL24dpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNlbyb6jE3WRM6/DpWCQE6y/nSYLHtMyu8gm7SWIjLc=;
 b=G79rtxRM5w/XsWWfo4mB3KyITrlNJ9UbAbtzmmBVxU6iqRkI4qWgX4RD8rRMeKiV0xdSsA8OwoUw53NZn2kr//veLOHs9Xvqi+gvgJTcMw9UDavSqeYaLCt5fF11MBkl6+BwhsQPReELOrjhbui4D3KggWgxZGQK64JvEG7WD7zBFMp/t9NpULUm3fJ2eKLEIRb0OY/MsPZfmLHOhHiiv30zIHbKAiy79CSnFNXlyHnR2b3Dd66ELI5EJQyCh7/+IqDQFuxB92cAjSdwwDCFc5HwY/Ma2AVFsR2Nw34wEkYjMMQfeoWBZm7cTWqqcLOr+ZE01wvIFF+XQ+4Cc21Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNlbyb6jE3WRM6/DpWCQE6y/nSYLHtMyu8gm7SWIjLc=;
 b=ZDohj9qZxF5BfvJQrmYmMuBQBCUwNTEQAfh5/KgsPyjRa7c6hW5wkag/MlEsxwOP6N4sy/ItC6iervaon3GD+pbn+cs2Ke9Dqf65DwKuCd7k+T0Exou6lF6Pgfa1cFepDAxYJoU6hbSaCnM5l8HxGYqpvMm8lH7CVS+EoW2Mzgo=
Received: from CO2PR04CA0153.namprd04.prod.outlook.com (2603:10b6:104::31) by
 BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.26; Thu, 1 Jul 2021 04:37:48 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::35) by CO2PR04CA0153.outlook.office365.com
 (2603:10b6:104::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Thu, 1 Jul 2021 04:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 04:37:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 23:37:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 23:37:47 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Wed, 30 Jun 2021 23:37:46 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Date: Thu, 1 Jul 2021 12:37:43 +0800
Message-ID: <20210701043743.10663-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10129277-52ee-41ad-cc51-08d93c49faad
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27762450ECF3BBDD668126938F009@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGaNbKlrFujPT2L5wLyNabnO9Zg1FBKwCxDiT2S3K9+QvB3wyNVrs9xCnd3LLipMO74bmzvPWKxc8jLi3SPa83+jnrtyeEKJaUTTL7YlSU0Ko3Iq+saSD3gTfkJYL1OXVJb5SlsZqz6W1SB0RmGFnNpdxX/IZsq+gdneoHXhOFGdk4K2bhJp5jRaHZeKTi45igtgPx1ivrtjE3O2mEIkh9oFesaEf8RSCV3ZGy0nITictohhTkQjOyxDgtqsnpQKkKNqhthBv9R8Vu/4cDQ1URk36LSJrqOsvsfTEsGU5YtU8vLh58VUCRUTVFAC+2dkWipYO+DdTLmaseFjFvYC3H27uuUFVJKupCxNdEbuaqInaAXspaYNlcJ67KdwHW0jH11JQsslDEmvE9fdh1TZYDWz3AtQlF9Ulosx6YDLRpkptO8s2Puo4Y72uMlosdapfLDVmAh9eMpyG2S0Dk72mxvJl80L+HGO8fgYErLekeb/7bJCbcUOjUglfnl6ieLM0EK70EOjknNVGG3AT0LkKgOAT1KYcPeJgEIumm6cJqdjuW93qoqNQEkV07+fqJCqEcNbhieuX1OUA7iFtwgTXaZxupK4ws3HSS+lSkU+VqozJGeEulYVYBziQLPGsDUfuTHHSSTStqZKaOKgHFMo2bzstwdQiea1MEIEdAkPArYMwgfJjKNnoz+IIntVhSjQV0glQB8Z89B9mp719htsrmnLh/v7ofGQerzg6ZMkkUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(478600001)(82310400003)(4326008)(70586007)(2906002)(7696005)(36860700001)(4744005)(47076005)(5660300002)(82740400003)(6666004)(186003)(36756003)(316002)(8936002)(70206006)(86362001)(1076003)(26005)(54906003)(8676002)(6916009)(83380400001)(356005)(426003)(336012)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 04:37:48.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10129277-52ee-41ad-cc51-08d93c49faad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
Cc: Emily Deng <Emily.Deng@amd.com>, Victor <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Victor <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 33324427b555..7e0d8c092c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs dce_virtual_crtc_irq_funcs = {
 
 static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
+	adev->crtc_irq.num_types = adev->mode_info.num_crtc;
 	adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

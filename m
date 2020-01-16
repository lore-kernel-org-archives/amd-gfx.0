Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FEAC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4978A206B7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tKXGMAAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4978A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6186E1F2;
	Thu, 16 Jan 2020 04:47:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6426E1F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 04:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oak4gjQDnEdpCLbSlkn6kFuWw5gBnNT4LjrVDeNsTqF3gLAbjEe9GN6zH4NzyNB6jwKUbtpw/2n2x+crpfDA7l4fuDzziOG/v/aZQXvZLFCNozIAMK87rYBBwBhgqXW+kAKngEdu6ASSK7alEkl2lH1Ebz3Z0AytkH4DXllW4o351iCY2P/2o8duWOqW25kMiGXFlrtJqNk6wemCaISbY9PcRjEbnY7jtMM9ItzmqcSu0k5SzwAC9MMMA23DAqGUqg0axvDfYX2RVfJ3MqT8DAX/Gb0KvufLX+DqqIC5YRA7Rr8y89n33T8tsnWts30N0mB9Bz1oLG1bYPmJB4C7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOJmlZ8t3LHU7YBrxQ30TaJl4xCMst2qEdKCPdQiZOM=;
 b=Jxz0K54hdSZ0ToOxdicXpxsZcNEFyjJ5oNjrAAqzv3K6SCd7NugWUH395ZAe9vmXZNoay9uX/0Tjlgafk4L4YU8YfOYrI+wkVMTSzusI812qVxmm+iFkS+zeDMaGZXclW8rkNTmJZdQPEwWMg8Fw85IJTJzMZ/5leBl/vmtTQck5vwtre4Z3PuCuIVejK8oyEPAYuOQMiZGZJCxivC2m8CgdNC4otX/q9WA4GigKXYZleZS0ywWyAsBdwyWPuFFNuVctFFnvEqlpGjuexWBBCT2VQ2HhXztIIENNEeeJnZtPeCGOebx4bxT1lwtSslOOosi5EAG5GScU+As4mTkFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOJmlZ8t3LHU7YBrxQ30TaJl4xCMst2qEdKCPdQiZOM=;
 b=tKXGMAAG3SZf16xDWrygaOUuIVxTggxSE9DVkevWsNVOpoi1A84S0wBWxP+0RcRZ04HY+k5nL+eA+qgIvByK5Vq7OMr1Wl2qrtZKaUkrN/0xBGM5geBYVKFHPPdBc5KA7fI4Qjspd5QZM0IS1Q30TI9ObOBOZVuEKH3xN+Hj6p0=
Received: from BN6PR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:405:4c::15) by DM5PR1201MB0169.namprd12.prod.outlook.com
 (2603:10b6:4:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 04:47:11 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by BN6PR1201CA0005.outlook.office365.com
 (2603:10b6:405:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 04:47:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 04:47:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 22:47:10 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 22:47:10 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 22:47:08 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, John Clements <John.Clements@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Date: Thu, 16 Jan 2020 12:47:04 +0800
Message-ID: <20200116044705.9398-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(428003)(189003)(199004)(110136005)(5660300002)(4326008)(186003)(7696005)(316002)(26005)(70586007)(36756003)(336012)(4744005)(70206006)(426003)(6636002)(1076003)(2616005)(478600001)(6666004)(2906002)(356004)(86362001)(8936002)(8676002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0169; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f25d44-9dfd-477d-fc45-08d79a3f264d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01696AFCB0B1ADC22A13053FFC360@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFMOwuBL6XP/GPQlJp9z5wj2BO8YAsVY9FZew1x0G4mqUMPm5qiNCsYj0QO9NC1oQQnBYnAl7zPlIyO3iUrpUSsPHrlcLCU+IdeuALTKnn8UYQ73qK25oYJYprpg9PgMJqTKVStJnZPanITYUWvNCRze0p8UZemtt7jV2pnFLDYAhP+CXciz/VvJX0l1f0Uw2AO8Bv4i5cUY5d4ctGKyV7681dtj1wi/+tGf7MH4o9+dzqzP1ElJyAUQTJsw5icbrtt5F6Z//Mm5F5bXp2J9qigBVlZ37jQ5SE/XJ4+JcQJx15ZGWGCM7f2iw1t03YGcnPMS9r+xeb0DKt+tpH+uGuKQUaqipiI2AB5ddtgGYVEvrU5LCkA6Iw+qFGEoBxms2lAcsFY/Ms6TO0O7vjLcK7HXNIJTGUNZfJJ4n6hn2fTaaYlIed6CpPj4wcW9Zhr9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 04:47:11.1646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f25d44-9dfd-477d-fc45-08d79a3f264d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow the flexibilty for user to disable gpu recovery
in RAS recovery path by module parameter amdgpu_gpu_recovery

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac9926b3f9fe..492b3ba685cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1356,7 +1356,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_ras *ras =
 		container_of(work, struct amdgpu_ras, recovery_work);
 
-	amdgpu_device_gpu_recover(ras->adev, 0);
+	if (amdgpu_device_should_recover_gpu(ras->adev))
+		amdgpu_device_gpu_recover(ras->adev, 0);
 	atomic_set(&ras->in_recovery, 0);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

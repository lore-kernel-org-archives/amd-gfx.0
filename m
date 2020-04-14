Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C0C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05CF2075E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n2bOZHPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05CF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863676E0D5;
	Tue, 14 Apr 2020 12:05:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C056E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 12:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9Aph4wtAS4GYBaOcV79rqu6s8y3wHPweoUD7Rdfr+mCg/GQS50qZ2g+KEXM2LjuFB/cfWszuQP/MGxJ+G7AcBY+DubOvJS6zFcHdMreznp0kJ+32nDQ36Ypv5A66lUnCEEG7GnwoyS+gHdjIFCuCjl9yKFGLZcll1KBu1PuLf6GoEKd3h15jrlxD9cmYZPb5ewCXc+AJe6WzASK8UyL4wF1nu5y/jbljEWLHIErTfzI0hXTu4M25xaWYT2iUFhy5YXjVk65LBvdLEdSMBx5C3Nco5tzkkgLsP8FD9X1Nro+j/cq4pSH8MJ1GHs33415vwE8PmtK7jS/VSveBeY7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg9zbVSQpLtorRQh5EoGiA52jMsPyycCRODQz4eur6c=;
 b=AAZLML0xt2G4Owe6MeEYmC7V22DGr+bFN+mSOObH6Tx7joPgB4aOU0+hGgdikn46fZdr+DtniDj4cM0At/ScOcRkYmcS4kVzhyX28Rh0tY44e9pmDm4cRyW709aectNMpkJPt6YkiZwOwFp/OrgdzdwTUh/cnvBbwewkm7+ozgRbjI3dT8j2JuWYmzf6xksWvE6bn6/u8i2ptgA8y40774IEcQpiWWFbGsdJ5vfxu8MDV/M76a4SDWDzVgPI9+oFwV80hWvE/6kz20CKO8mzVn9tBaHNAkStRcaGzPwDtWU/BOyMO4NVjOEVqeoL8HZUtYO1oSuWeLGd6be4YoxhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg9zbVSQpLtorRQh5EoGiA52jMsPyycCRODQz4eur6c=;
 b=n2bOZHPevudPuGE3iwWv1+PETXWcMPAiNsjzOOp1aO9Q4AvGI9mHeDi7qSzWRnlsejutuBVIiNjrqDMOEo1wLFT+6avMfhYW9d9p69kppeD9or60iBUYDhe42LJBpkV4B3jP8hXMOi22KQz8YH+wEyhgFTzPUSXQGQi6Vm8T4dI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Tue, 14 Apr 2020 12:05:21 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:05:21 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Date: Tue, 14 Apr 2020 08:05:13 -0400
Message-Id: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 12:05:19 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eba36fd3-90d5-4e8f-9445-08d7e06c1a31
X-MS-TrafficTypeDiagnostic: DM5PR12MB1499:|DM5PR12MB1499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1499C7CC038B402021087FB2E4DA0@DM5PR12MB1499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(186003)(956004)(2616005)(6916009)(2906002)(478600001)(6486002)(5660300002)(26005)(4326008)(8676002)(8936002)(81156014)(52116002)(4744005)(7696005)(86362001)(16526019)(66946007)(66556008)(6666004)(316002)(66476007)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBoavVqJ/iq5Ep+x4axEUfPvSSY5rr/0i4I2k2+BLHTyTPjodRbdkV/PfvHMhqTWS9Tm4Xp/tWRxFpfjUgVJ5Cdb4YE9A5q5bursgLqClTMUzkMwUCE6fXr8FvDAR4DSeZZMXYz3zqWwQ5w6UCVVtTbrOAiCAxGMApuSE9x8FzI86+EPvw/GiK/WsMtmqgkdbr7u3I+4NWTLO+PT554NXGHOyfbkwGLMGkbOsS9MNoVDY8EMqGNCdN7zPQwDoVbdWDAFovBZjWQXWCfksUmzox4kawNTcTBG5SOX3sIPRpyZjzLgE8JVD0ACBwYAdCj2SfekwyM2QRwN2JVZLIEZ0ngB+92dxFfahVAXZPO6yERaf0O2Co10+xPFEqcD5RPDO0uRUdLJ9MeXtdYtKSbPDFYsPR6jYT2P8CUkgnnXyOJpQoDADIQa+fpxhon87NFo
X-MS-Exchange-AntiSpam-MessageData: UFd3XXjhDFePmwXcH1rHunGmP4/i+Bl1B3GUd/DgkcnSjP5+lbhGjpW6hRTltN8Av9dv8lX06EgvUF+mBkIjvaa8s81S7aU+IFB8aypkHlmoSl8tHQI6/J48Dlp0hT1aG3mUE2zEMECrS5KbGbHuzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba36fd3-90d5-4e8f-9445-08d7e06c1a31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:05:20.7255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4FMXI1BdBdbL9hfK8FUjTgL4b8Yen4b7jfiuVZ1ZbmrL176xbMq2VFZEbNEQbRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
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
Cc: jamesz@amd.com, Changfeng.Zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Turn off gfxoff control when vcn is gated.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dab34f6..aa9a7a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -369,9 +369,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_gfx_off_ctrl(adev, false);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (adev->vcn.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+		       AMD_PG_STATE_UNGATE);
+	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

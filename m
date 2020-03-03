Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46CC3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45EA20656
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MTCptRL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45EA20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827296E859;
	Tue,  3 Mar 2020 18:16:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C6F6E859
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 18:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExMZebNJ4o8ImFnKMO+mqsu90M/OxRT1oEy1kjcDmQC3qNjAkKZhWF8ICjfgXpv6HB4IjVDBg/huUJdJUCv7hKPd1xRToGLqBvqh5FZe73MebA+CQwf4vjkmbwZwX+dSjuyA61r+zZxrMuFjIa+t7vA53LzP9HSyZAk6/8JvtH0/jODsidE7dc3oaeVdy5oXzyNafvuPSMMzORkD1Vq8q22AZIzXGS5aC6bT+peC3dnMPyDPy4fby8U3IznfUJZYDL8GuPzFduGblUJZh7eJ6scbX6lknO5IfB8xXl22Nb0ZpJUhkqA+1CZOzfRQezw1McSXnX/nO5TlkOSqyy3Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGXHhShB8a4A1ZGgYupd+IB1BBHU5oZPpkzXsRKNwPU=;
 b=H/xGifqxpdCk/KjVWpElREmDKrK0aF6CWJuo+vkiEx/AeSfMPk1Kjmw+pHjtnkgMU+DFwdSdX8AG9jZMlESWQyoqFOlL6jwHwTec4918CfKWNUUfarFMg14vSkcA02kHswoWh4AUf4QEbTdrGflLdzQdJtJppxlURd2ERp69q07Ev2Ttt2Jb0gXOBDUeN9cB2u4maTV57PVp0yFj5UNWHRDNG/fc859rHpvLNn+Yj4FwTImsC6NYm0qEDquG4dzIiGkkNZlc2TszIuSu/XKy0FHB3YtCjO1gQuqje9hvd7rENRji8Uboypvib/eBOj4VF3lMb01LP1OMegm+CYYy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGXHhShB8a4A1ZGgYupd+IB1BBHU5oZPpkzXsRKNwPU=;
 b=MTCptRL1sd6cEmAeRS/F+BN7kbA5bvSmiU7J/B4ERt6Aem2MYKQkFN6IWgeW3UA59OcY/MBRHoFOtcA+INqc8g9j/u+GTNp5KXtwLOXuF90ea+wfBR69AQYzP0LfHMBO9oqah23wYIEyezpcbQ4IIBszArlWoTy+W/66bGZLTuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 18:16:40 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 18:16:40 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu/vcn2.0: stall DPG when WPTR/RPTR reset
Date: Tue,  3 Mar 2020 13:16:30 -0500
Message-Id: <1583259391-21834-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 18:16:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6cf703c-09c7-44c5-15b6-08d7bf9f04d2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:|BYAPR12MB3382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3382156BF88BE3E733BBE4C2E4E40@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(66476007)(26005)(2906002)(6916009)(66556008)(66946007)(86362001)(186003)(8936002)(52116002)(478600001)(81166006)(6486002)(316002)(81156014)(2616005)(5660300002)(4326008)(16526019)(6666004)(7696005)(36756003)(8676002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3382;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1SjOeYiIWU+JHDz5/12ew2IZWGOuPhaOFuZY61Rb0jxQ4sBTOlvHaXZok6rhcGw7cIgGliy0JgXs55/9h1i0GNXD/BSeokYK2XaVzbLE+ncR66xvNfVlu6cmc2JSnAtmqrw4XmzZrqXu6fSYwPT770hc6qGFCoELlyzx+ZiAIr5BIJ8Ralr08vKACLos9hyehWnqC3yDYdIKYNF3ibSBrT9rhT63wKKZMAUK4v8hW8CtNk1Xn8djzh/xyoXmqOgUP+4vEHSlOfZa8i//ouRlfA8NG7RH9gJbKp6Sy0ZPs0qARbRCcRDK7zi2EXLarj6NBzo74kgIhSJoHIOOo9E94h0U6sE3LX7fNXAIeCc/l5S/SPSCyKmMKf3T3BDKqPbUlsk59WnxU6igF561yp+jL2xkOYnB6T7jf36I+Z+6KYUSDR9JwupnS4nDoctyO9K
X-MS-Exchange-AntiSpam-MessageData: kJOR1G5AhyMp2YBV2EoJzTMVQ5DZZZqsHuk942LnNKiVCU8A//y+FBPoMXhGN/qG/8C0eL/xH5XY143PyphfSVoHKFW9syR8U5jhq9EPp544CwCd5ijHaPMXPle9s13P89KGYaSrDXGt9Z/4Jjn93w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cf703c-09c7-44c5-15b6-08d7bf9f04d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 18:16:39.9375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avt3k/fJTLROifeudei8nvkIOlASGbR2u/1pm9S77KytIWCv62s6pK/2FZvvHLJn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn dpg harware and firmware synchronization to fix race condition
issue among vcn driver, hardware and firmware

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c387c81..7719f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1158,8 +1158,12 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
 				ring = &adev->vcn.inst->ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1167,6 +1171,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst->ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1175,6 +1180,8 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

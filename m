Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82001C10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 19:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24743222C3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 19:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fI8fsVN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24743222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA556E39E;
	Tue, 10 Mar 2020 19:58:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567E66E39E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 19:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhhhjS4KIlWRwHSGb9/XYPkkchNHLpHUPVFR/gCv183bKg5srFxtUm/oDxDwrfiTlDTbYaApNBt6lRGVUAiJ780dlooA9jB+F+QB157ke2nhN9e9ZHZrLKS4x0c7levQIAKQzYonzEsYv0aGCysfqfOa5XXcJ4GGqWihtrb4ycdb56pEPjtEu1HcIgqcoWmP1267j4WeZQYIRG7IcnuaEqUAFCPrKvARTX/y8Dtuygx+3UqRHHmY2AQqVEh9O2vzYyh/3FPQOFsHirjGRbSOd1ohYcFoDlGhmp+K7nVglBeuaLf11Nvz/zRI9od+V+VH7Fj6eVBJ7PWJ+fDc7CxblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD7/BBs3x/12Pq89o1bnniP/SjZH9gIPLv/5gSDeAdw=;
 b=LeCl6sjGs2KFupx8Iu186kbZ3mqs5hSObhuRDaRhPzGSdrrh9gSBIOSnrBpEnIVwdqm5PFV7kJ3lbQL8zKIxwPhAJqQIUtHM3O7iKtgSk/Hj0jB+IqM9gU5KRhpAD8k44+J3n8z1PBY61ps/LyXi6wlS73HnpXRWuZXCdIA8Zaate9PbwE4QYuR+DrAZLSubk2n8UWrXcgfiGyKD7NE28am7sawi9i91DfcnCs4qv5G6CcuoQ4HKMVlwhhjbzK59SQzbEQnGYxAOD/ajMiXTnq+MJMNvkVZnatmHFIeiaRngRc10U/81fEP9Ks4S8T8ZK+CucCWxg7ysS4q5FRLeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD7/BBs3x/12Pq89o1bnniP/SjZH9gIPLv/5gSDeAdw=;
 b=fI8fsVN/4kLPI3rwiY2AcGj1hHkj6S7aWWIjh+QRkIhpvCx58JfcQXjJ+SbTGg/byZYskx6V+9Dj2xOJyulQjujhVunKilgMPtLuShdt8l5TI8lgG4encKVXgmKEr1xJwlsIja4sZEukcmAGdBxTSZ+mGYRPGVCIXk3lNJ5G+os=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3110.namprd12.prod.outlook.com (2603:10b6:a03:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 19:58:07 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 19:58:07 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/4] drm/amdgpu/vcn2.5:  add sync when WPTR/RPTR reset
Date: Tue, 10 Mar 2020 15:58:00 -0400
Message-Id: <1583870280-13102-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-4-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-4-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend
 Transport; Tue, 10 Mar 2020 19:58:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94b840ca-0bf0-4d44-83fa-08d7c52d59c1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3110:|BYAPR12MB3110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31101854EF0F2DCA3D338902E4FF0@BYAPR12MB3110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(186003)(66946007)(16526019)(4326008)(66476007)(66556008)(86362001)(478600001)(2616005)(956004)(316002)(8676002)(8936002)(52116002)(7696005)(36756003)(6916009)(6666004)(5660300002)(26005)(81156014)(81166006)(6486002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3110;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njTh6JUxE0jRmD6flqB/XdyxqUvLuF5BLGm8RYHZrQmx/Bv/3X/Crek+yVJrZ01Gzmct5W4qS3pBLj5NOYG/whI+7S4a5rq5gxBZPWNVpEcWCItON3bcKBMd2fSeqZqlGZTQB+9Cee9MhJdsBSlehvvSmG/IPPpRrwoowts0H2GDZuLP8tt20Q+u/zEMiKnNVje5QsZgCzlTzrRdfd5CwExSmVGVBYwul5xS0Baf7jSqDqGeqvoEb9C46Ya6w1CkTshRf/Y1xACb4DmLTpKWNVByzk7nfSpD2/vS8amRm17MINSRTJHH0OQwCAhdJFrypOhlY7dSjFP0yBC62fWpg382eTTuDTa9nkLYiNhDG6kk4QeB3K9kPhWXRcGpuvZAm6yY0tSC3JuUG5uZkj1P1wkPWfZ750jsG83eMBYUTWzvQiuJSxp3UcjAGIPtCuGA
X-MS-Exchange-AntiSpam-MessageData: Zj8tb4BbuoGHoQqIb3WnlqMrl3eHcmWtGhCq9R8PS8zFZb0fI0n4NP6Q/mePX0KbJ0tYchKJgAA/EfevKOSiDR7O2MSTPWRy65PPOmWA/frcOfxnXWcolBhyuV5v5jlHVS7YZk1wtP8Fl3WjvCiJfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b840ca-0bf0-4d44-83fa-08d7c52d59c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 19:58:06.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOfg/dpv6vE4eK+4elY9nejWsbTnyLlRct0Lj83jkujHeckJDIOrh0K83hIG737r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3110
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

Add vcn harware and firmware synchronization to fix race condition
issue among vcn driver, hardware and firmware

v2: WA: Add scratch 3 to sync with vcn firmware during W/R pointer reset

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2d64ba1..9480039 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1034,6 +1034,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		/* Set scratch3 to start dec/enc registers reset */
+		WREG32_SOC15(UVD, i, mmUVD_SCRATCH3, 1);
+
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring->gpu_addr));
@@ -1059,6 +1062,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+
+		/* Clear scratch3 to finish dec/enc registers reset */
+		WREG32_SOC15(UVD, i, mmUVD_SCRATCH3, 0);
 	}
 
 	return 0;
@@ -1388,8 +1394,11 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1397,6 +1406,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1405,6 +1415,8 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26CC2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727C120749
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S1fhdrWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727C120749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015E66E50C;
	Wed, 11 Mar 2020 20:49:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93CC26E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2prYbeG9w0Mjdja3zTKXThd0tgPlS7Vpca7WQ+eAxyjr7OVDhtGFr9Y8TbQYdrxqU0oB6wH2nps8/QRbbu1Segw6BP3kvFptXFvySS/F5Insc/tAFrlnnpoqDH5mmmo7GCBHXKlIBr4d1rQv3s0ejkd0YmPngDWE7UAIHEtrW2TSBbW+Fh5jx5X0NIUH2yv49R/4HuOC4wJw9fmzLoRw6/AJQCe0tCq+fnmVvxRq+4TwRsx/E/74l+7snSy5bXP1S/csTPfogvlySWVPXv7bADSHm1z0pRm2xc7KjAalelTzcyzff+BwxUleLh67nCpVzKtW3xtldIdcwzLG79sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NApPKa9kl+1asER9pOXrXJk9B+6Oa1f66Xuqg0YsUA8=;
 b=MJx35RCBvenvWqOCw5me2oJuuEX6L1cMBVmb28SBrifPwPu8Y1ucTGntrgs89hl/PG8Bcl6faPcLMq5tA/qGhkRcrjHriW6dA2HXoiHmfyEiAE/qdXcQpJGCZjiGAx/3h+80o/FbYuajpiAAh7OEyf1LDccmzZ4WZ4rRZ9RONNEV9N3HrBR90swxeJeFHqIXthFiP3NWhxBEUGZR/GQpAigd1DeDCd7CZdqNbW9D7XokQJqba0tLkK+z2fZ9/b+KPnfPDIeHd29bErh75ePHeOWv9pbL4XXyM4lki+MDPJ792uEi0JpLAtZ+5gsd8oFAUtsanO3WQaJMH1TN28Up/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NApPKa9kl+1asER9pOXrXJk9B+6Oa1f66Xuqg0YsUA8=;
 b=S1fhdrWqdv1dmU4eg5px0hFJT4WYcbzgaq4SpjIkxhkIv0l8WkbzFmsKqWzVavTy/JnjPqy5u2B5I5dP9IFMs4P6ckhU1uHRtK3EcbnizwLNr3zMYXWw3EmoTXTMJwtTqmeQ5IV77eyrbVwLZsR9SIj/lsqGgu1askTlMOua54U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:49:45 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:49:45 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 3/4] drm/amdgpu/vcn2.0: add sync when WPTR/RPTR reset under
 DPG mode
Date: Wed, 11 Mar 2020 16:49:33 -0400
Message-Id: <1583959774-16570-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
References: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:49:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd7621a8-2ea0-41da-579c-08d7c5fdbb3c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:|BYAPR12MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30792C4269C76E9D7F270907E4FC0@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(66946007)(26005)(66476007)(4326008)(2906002)(66556008)(6666004)(5660300002)(7696005)(52116002)(6916009)(316002)(81166006)(8676002)(478600001)(6486002)(8936002)(81156014)(86362001)(956004)(186003)(2616005)(36756003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3079;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/b/0Jbf8PcYXj4GYefhiCevGAOWfmRg+LVqj///U2Ej+CAqXGb6hTUpIDBAN1/0Kb2HWXJUBcs4qQfHoIHXv8uyMwCuDXJPpRQD9X/xBmI4drv6NoHaFquj9ZEJLTE0H7h677j8xPIf2thZgHHZ9HRWSKXFUv6pNRmhfMY6CiTEfwcXeKcHSO1/HEGazVz4hZov2OPl3g5QfW+cENy3gNrJvuDpqrIHpFH8KqdZraPhWJ9HsaF+AoqWbyWgHnsn3YpeTvP2gecyC1gBds+/qki+M4YU1FS3j/RSe87mt+Zupq11KJGkZQm1TlI9SpapzUtxHoTMVYD8Kz7SxiIZBR3agHM8Y4nQ5ODzjbilmR+G3CkQzRA8VyWRLXUzujjROUXCFAatE41Zg8Mug6boNnWiowvK9e3pR9EzKWlzAWmF1ND18DBDqLtMzGFiUQnh
X-MS-Exchange-AntiSpam-MessageData: ln3R/42l6A2IU7LQd+jF1ktZRJEOwnaYlykvrhY0qLHud4jToozg0/6kUq2UWo+clIOIWPgrdf82ycwlAfakm2NhsRq+ZIj77TGWQ5IShTBCD7ZgCutjlY/uPjL65lX1kYYyURkCBbJzFHY5iI7HZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7621a8-2ea0-41da-579c-08d7c5fdbb3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:49:45.7634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlYco5WlDxnneMRIwFyG1KS7SXv3wPfea5tTjhIgG8BXhO+KFBmVdYjiZ2+/MN2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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
issue among vcn driver, hardware and firmware under DPG mode

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f2745fd..415d65c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -872,6 +872,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_CNTL, tmp);
 
+	/* Stall DPG before WPTR/RPTR reset */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
 	/* set the write pointer delay */
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR_CNTL, 0);
 
@@ -894,6 +899,10 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	/* Unstall DPG */
+	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
 	return 0;
 }
 
@@ -1189,8 +1198,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
 				ring = &adev->vcn.inst->ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1198,6 +1212,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst->ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1206,6 +1221,9 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
+					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC7BC2D0ED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522FA20714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t9k75J9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522FA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D910A6E282;
	Mon, 30 Mar 2020 12:14:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009276E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 12:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgiDnEiDahgXcifc6LhXOJ1+Fp8bPJ70j1uvGvZ1/JpvihcSryZZHd255sdo2Q8aIco3ZXGjgVXuA5UGm0qcuGdOZbzl06r3vfgH22hsJ1URxHucusf+qz6hocilbDhUyLRvzpFz83wAwq7DeG9JNtoq0MkLfQH0Kyx+atUQLj3yZVMSS9w+0SzZzgZACRU9N+M8uOHPEz+PVnOFw2yWc0ZsfPeRFhu+NMvwzQE+MOzSX3Df9AoGvzwHWHOMCvYDriMaDhcxGT6v5vRIKaakwzD65XFyTF0XJ15uSVYWs6ItoEE2fSgmhjvK8FWL/pLGieMUsJssnM96RpldnyMz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmeObR5wXK7hKInKRU7oZ6C+LH8mVrMW3O9x28Po+zg=;
 b=OV8lzvm7gBr8UCW8WQXN8LDtwBc/M/izCGMOc7IlLKy29FU7a36z/JX4aqnWvDs04cxoVV81Gr+F7tvqq7IDFQBYvnplW/LVRC39qqws/tga0UO5qn0NLop1PQ4Ic+BWmYqyOErvfn2CStPM73/y7m09gDBXPbWXPYijRf9JX74sEDG197EWPD8JXduVhTND65gfC2V8XTy89rKqFWHnEZi+uy4K0CvmcIkrOj+y35rBMjLf9Qtqg5aSlA/TBP4/8TEQ2uuTBgm305/gJaAwqGNifW0tRds581hZ0KY1zRVIWKWd4dXyZJUChKVCWDmkA3Q17dvg+7eNbgM0Eg3Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmeObR5wXK7hKInKRU7oZ6C+LH8mVrMW3O9x28Po+zg=;
 b=t9k75J9DCi7FcH94/S1ABIpqbsqLulqoOiDCkLz/xy7sEK+wO9i6xy/USLk8q6HeTVJpy//FSOyUr6UXN4z44Eh8RaYmg6AOzoatxF2yTLel8KZCMAx5lEHHSbitWwwdDkvlXqGgvaEt9H6laFnMJP8gkZQn59hQyES1rQfIa3M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:14:30 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:14:30 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu/vcn2.5: stall DPG when WPTR/RPTR reset
Date: Mon, 30 Mar 2020 08:13:35 -0400
Message-Id: <1585570418-13894-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 12:14:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58f31946-4295-4ebb-b39f-08d7d4a3e5e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23581F4E6668182A996B7F6CE4CB0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(81166006)(86362001)(8676002)(81156014)(8936002)(6486002)(2616005)(956004)(478600001)(66556008)(66476007)(6666004)(52116002)(5660300002)(16526019)(4326008)(7696005)(316002)(2906002)(26005)(6916009)(186003)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxWAUWWdAzmURi0Y/ENuuO3EfrZbwZ0Zsk1sCVIZ34pKT6av7swPizFoZrQ73w5lnIW1ahvwX0HaNEWV/FUZ7M38TD0rCYlmuPAXLflOflfsVcf4vhVU7SD50RBfjTkL0q7HquvNjPoS0SCam55crNFw2k0DtxCPzbSc1s16ec7xu88OPRRpHiL73EbPyT044xea6D2etFiCKUL2qGzMWykj44vysmrYkIKF24Bsvs9YDCd4802tNsG8UzTcr9rzGm2XBA2WkPtQRBaqfGKIjoxj1bGbfZBYZEdje9zrza4kBAPWl6jjhmG1vUdTilXCvmCY9IQ19cU8/ORYVN+FAyLF3m5/V0HVL6ejiD0ZLJTs86sFD5UcqsABXCe8p87H3WiNfP74F/Qw/oa43C1j0+3a3wGIYUVgutbC318+uorZ59183C7QzOaoC1qutAMX
X-MS-Exchange-AntiSpam-MessageData: n8XyxIP5pPFJbmLrZnKTpa2l/TidS3Jeot2TNV8sp2JGc5/QCKeW+eF9eLXQHKDQnbpwpTbGyO1XxzBRNWMiH+qub07Uk5NoS4igUWXmJ+6Gl4X64JYkcks52qY1ExcC+FGO00dH5R7P9r0XPpsfXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f31946-4295-4ebb-b39f-08d7d4a3e5e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 12:14:30.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoyyTerjmilyoEPcfhpMKnqkRAO/Ofgrw0EOhqyxkya6/Noloho4vyM8xTAOFJH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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

Add vcn dpg harware synchronization to fix race condition
issue between vcn driver and hardware.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c6363f5..7eb3b9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -855,6 +855,12 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_CNTL, tmp);
 
+	/* Stall DPG before WPTR/RPTR reset */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+	fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
+
 	/* set the write pointer delay */
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
 
@@ -877,6 +883,10 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	/* Unstall DPG */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
 	return 0;
 }
 
@@ -1389,8 +1399,14 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
+				/* Stall DPG before WPTR/RPTR reset */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
+					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
 				/* Restore */
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
@@ -1398,6 +1414,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+				ring->wptr = 0;
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
@@ -1407,6 +1424,10 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 
+				/* Unstall DPG */
+				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
 				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 			}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

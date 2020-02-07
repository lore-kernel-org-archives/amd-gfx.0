Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96607C352A2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F783217BA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xwOzomAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F783217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C29E6FC89;
	Fri,  7 Feb 2020 13:17:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29ECF6FC89
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 13:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/iSEARMwO+oexk4tf9c60OLhC2iTpY5bQmK5w1a/65o/I2V4vLVPWP4Mvj0YhDtOs5Wx7WWciV7qQdjwbsT95zVp7nvx/G0hj10ASoUpatcl2oHFwE0St6VLzU9Xr+N9Ii99Ch7D7VUwGl51I2Xmv60QM4w3mItqYQVioEtNfKVphq7YFBjVakMELH9bCtb7MW+INpqg9GqKMFFZNYgHO/qkvitpeZ/1Lg7vRba4uVQkh5fqzaNUsjvvmkP56/6lkFEMNh4f43XClPNDRhJMfLfSL6P9r5oKC9WNXit18+KJXUKvCUC8izhn9Gv/zYgZz105xgd0IuLRV353LuFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX9GEhSNlo4b6ru+bOsCOkv9dIV9IAIbNQqBV0YbONY=;
 b=d04DmzougWYSPLqI4e4PNrYR09ngpKs7JZ1BVoFuyoVjtPZJb02nI3teEt5b6Wt2J4bCxGb+RGW6Sg+wg/oxrOfMRW4FXkipejG0sYdx8Yy957nMRnZyowdcnj9JH7/JbciZWM+U3mK7dc8uIBgiQlCVIRXAs0nXzFr6v3le5AorcZSgZ0bpeo6T4CnWW42EaJ/RBHZzRxOs5m61pBRGuIHR/aw5spRpI9kVcFw/JiqClAyeWoSAcUI8LbyoEA4XeWoZIpGLq+5Tpdpp5cBSOiA4eftZBPHRj/+QReGOL8XzRJDbsAmQ0ZDfeXiDAs2x7w7AWmttgV2iLqJY2IrB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX9GEhSNlo4b6ru+bOsCOkv9dIV9IAIbNQqBV0YbONY=;
 b=xwOzomAKgktK+8Jt6Db3RGuxkJXv2t5XAP1mcEkKwmZrZzQuAP9A8RuviQlrfPT40KMa/B9fa8RC/ZKskaG0HhkRUJ6bHqbqhsqlgI/2sPgtkS/c46ngBZm6fkScVP3l/nw6JshCa3zmc9/hYnu3hPkmNQy2uDTd/mbm+h0zCxA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2839.namprd12.prod.outlook.com (20.177.126.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 13:17:35 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 13:17:35 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn2.5: fix warning
Date: Fri,  7 Feb 2020 08:17:27 -0500
Message-Id: <1581081447-1508-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::26) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 13:17:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d5da5cd-37a7-4480-0a10-08d7abd01870
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:|BYAPR12MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2839E48E191EBB1685984F2FE41C0@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(5660300002)(86362001)(4744005)(66946007)(66556008)(66476007)(6916009)(478600001)(2906002)(36756003)(316002)(6486002)(52116002)(7696005)(4326008)(81156014)(8676002)(26005)(956004)(6666004)(81166006)(186003)(16526019)(2616005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2839;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39azlkZ6oi2YkGzgfB03xk8pcGBftZeOovLBoAg+s/yhltekI8Vb0CBNeJ4ghuDkK5hOhFISLFRZI9bfXeFtJ6qa+VTvUKwJBzSTRqsADC8rJZjA5mk03DQAzZ3svDtAY8U17WLnozvUDWVGJdtvk/kMoDe5r5yTbm7C0yUns8SHe95dr/o8Y1Ry2ARCWUTVtVvA6PPfBdagP8T+Y9esJMO/UcYfkWs6C7IzQtzYFrfn+Yqjr6mG/75GrTxHDk+dCOUIFkl7VlTfuCZQtcwWsGx5Rd5KlPG6HBW9O+laqu/VKdl/i6LwN18mUong5e6bPzTHhI84ahCJy2bqHKQXDveeVXmqA+FXTQSi4+jntyy7RfKCsU8yocCm+DUY/hFzOaVJvL99zvsT1DFjnPRZjX6WAorR/VmECOO+j/+x/evad+HXgDNeBukazH8cRJ1S
X-MS-Exchange-AntiSpam-MessageData: /WHFRz1gMyqNWohuED73MyFQE/BTGbfc+pM4kP2meIVMifJDmq1qGdalglxPpOVbc5O6HqYg5GgVtsN+bMeOc4erh06cOaOtz7RhhR/JZ0NWW/CEHxDc3mKFdhDnymN4lO4TUN8oMbflomDO4lDBOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5da5cd-37a7-4480-0a10-08d7abd01870
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 13:17:35.0146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8acCz2JbtJIFWOxq0VsVXzwtAHttGzgRCWoeCoshcW1U5oun2GLzF+qY0bjZMTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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

Fix warning during switching to dpg pause mode for
VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 97ab44c..2d64ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1407,7 +1407,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 
 				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
-					   0x0, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 			}
 		} else {
 			/* unpause dpg, no need to wait */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

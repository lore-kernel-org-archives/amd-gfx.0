Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8949CC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF7520BED
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1rvLvybT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF7520BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB0E897FD;
	Tue, 29 Sep 2020 06:14:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D883897FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=finDpf2UulfeMeI/DpiLH8A52JxuVnJsX32RB6OzdSg9+3EKcqhw96Ts9oVNjkoeNPM5zS7mJbb5rruc2BvFIMkYMb6X+XcdmH5YgYtMS9yxQfpWqtbkTk1uEpsBxc/UmVX+UHXSrrQ0e4DQQYf0Xj5mlrEcFqBS4r7SpmKZkOpZc2NFQIzp2wD2LmMijVNszwKg8Pit1BFITpe4H6eoa+L/7BnuWUZQU58S07OwEJzJmjL/nW9MAdXPY0kZoA+oOBCUfmG6wnKEf8uv/FbJ55vMcFaR97bXrM6vG5YvdpmNovjGL2CEyyzT/x8mBM5FFGj29TUQXtBgQHeQuy0a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zszlJIhqMv5QXFBGpthIkajWrfDLdBT1NZrKNNbeOzU=;
 b=ZbZJhjnENJ/AUazBbGyenD9nJJfvBEsBD7MaujnCKO7p5PDA4gnhQw7NwrKL4+D0/LzaP3sQ3hczKHOZ6FVwwCvezfDvc0j3Ew1RfXgQSG7lcV0ipgrHetLJqOdumMQ0835Rj+Jlk6j08f8kxMtbx9cr5Ye50YFRIXVO4evluhIK87a3b0JPcZgrhb7DCMaDeqr7rXwMfVb6s4wjVpHInSzEuz3Iv1+ET4zQ0AYzIIvP1Nb9q7rDqaAPkN31w7mV/2fwngk1tRGX8bXUrcpkVvvJ9yavEiNAlf9tO40mUYkVsdEvXXozufhbTzC70+nG82KU8NV/vQh7S/wIW3yflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zszlJIhqMv5QXFBGpthIkajWrfDLdBT1NZrKNNbeOzU=;
 b=1rvLvybT3rormXmUMjjDUw1x5AL99h9z8KPmGtWbiVGDOKWTaGKCTZ2iBfzx/AibF4PChTEHVyu41yR4T7xv/rgVjg4Z2hGzyK9AkQ29hl9H/O6pa52ouogGtiwFbYgYtuirdkIFWKnqU0T+wPvLUZ/MFHcrwo+OPfd9nUDeKKQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN8PR12MB3410.namprd12.prod.outlook.com (2603:10b6:408:45::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 06:14:23 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c%8]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 06:14:22 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v2)
Date: Tue, 29 Sep 2020 14:14:02 +0800
Message-Id: <20200929061402.29064-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To BN6PR12MB1283.namprd12.prod.outlook.com
 (2603:10b6:404:19::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0081.apcprd04.prod.outlook.com (2603:1096:202:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 06:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 625032d2-4348-4aab-8a63-08d8643ee833
X-MS-TrafficTypeDiagnostic: BN8PR12MB3410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3410D9846D7A0256BBB18D24F1320@BN8PR12MB3410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZE71MK8LKZ/pJa+HxmQqicOVikAvBQMyK/1DDHA5TohPf6KEya6qyY2+9kkZs0A/BaOXwxMB3r/wu0/k7Ppd/HVsFv8qYWt+cH22vaJ4sRW52vEkDApleq/tftft+vu2lW+k9Sy1gSKTWqrC0oeNE0zxqPf3uSuwPUN2mo+sJu9ewop5y3jd4KNocUJudlYF2g5yD5cQkv1/Q+xQXukjADHGgvYo/XCbyJoDZCfgPMNxlDkLNw2XIGVv4zn9w0EmIVnGOxLq+I2Ixr71ZjxHT1jA8J/vZ0zYi+d/fUV0epz0vHkQGM1Mg2BEV5/xheXPvtfSvZcB5oZS2vTHRsfMcZZYxKE0Of0tsKxpDF/gAX7/Useu4XXkC9RkYt9j5+i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4326008)(2616005)(956004)(6486002)(66476007)(8936002)(66556008)(478600001)(86362001)(16526019)(186003)(2906002)(5660300002)(66946007)(26005)(7696005)(8676002)(316002)(52116002)(36756003)(44832011)(1076003)(6666004)(83380400001)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zDKWalssMheDWP+M+bnTXq6/LBe8d+TuY7Oufdd841Mza899D65Diev6oTLFZIdUb9s57aYWQy/M3AM2g9rVrpLsxSRPKGB+xqei9hQWQV1IOiFS5zDoiaELCIvqBgZgI54s2MrtdN7kNHMis3SYMixvs9VAEReV2yz8x/wXvQniiS9I2Il2ACgjq8IDU3Pg5FcdJiHnYmTiLbOjScoBewIIRnaeE9MkZR/RlqH7sgCV7o0yps1LZZYn1b/vwmSioA3mE8ZoVFKVxx7lwAQV5br/ynAvZ3UiwiAXU1giwNFxpVrwsTKbsSpX2AlqhY1dNaMTBUeEPMABYyBCH8vEUxOTk+W6sSOQkejROwoSZYjHt8cVup/G3W0N1NIgHyunnYsk4EwjCtX7avBIu8RVOmEChlnkqpWNNPVdTYuR1bXJDu653EqGwvMR+oVsCztrzX90SSBSYlytbwnS66368swVBEYQJ9ibxL5DApzx7pzEPHoDL4uWU9NqST1LTAu2ZAanQyPCbptkiqRADHWZLR9do1s0add/b7gjinMIJz7uBnDqBqIOFcBuohnQTmVM9EOuJLtgxK/Q0/zKV6Rqyp1BQffObHkes3hoDH//3jPLRevdfQE67WaV7u7KES+LlO2Ag++suQJCVhsecupP4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625032d2-4348-4aab-8a63-08d8643ee833
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 06:14:22.8323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0WiH6qNp+qPO7qbjfj3OF/RcTiamorqeGnSBr2PpXsrEu42Il25Tb0QBkkYoroIGjgNlrRv2YmW0tuZbQPi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3410
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same ECC check has been executed in amdgpu_ras_init for vega10,
prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..c80840ff762a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,13 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (adev->ras_features & AMDGPU_RAS_BLOCK__UMC) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

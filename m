Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD34C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 09:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B136113B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 09:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B136113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFEE6EB5C;
	Fri, 16 Apr 2021 09:45:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8806EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 09:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzHUMY6dERQVmbYOTLZp6T2vxgH2XI9jRF1vk/df5cvgdKKzWCqlwjeJuaR5C04zbntDr+NSxjQGDB0Acwrvdton2BIAw06L5Y65RzoQKHM8nefSHkKY395gMXcVMmarKY1pL3FNeL0aqaVVrJiNxJ4cHop+S3YtjaYa1ttcv6HZpuzasPqAR8Uuy8sLbc3e8Z2/KYjcdo3O5HE0pLwywukxZmIrJ9VSF6ycAC9fur1GBQN3Qt6XikIpbvZlgaH2lGrkaZV/FlXZWvLXCeCjaqPGHmEaFQgUlwVsGhIhQIKjXDnPWAPDJdoTjxq3Tdgza1+BDH9Jh8pJ6lLvVWp4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4yHW+Nqh1fUJiFrGlIjBASc1nFuVl7LHLv18t1VmMA=;
 b=m9Uo3uVXqtLsEBU/6s6hY/cebP3AwT+h4Pm3u+/pnwNVbu18qiKJOjDTj8Df+FQjhQFfMFl+Qc9yhwQ866WAKwBb1iNZFxBSc1lhz4mG3G3RYFuypSsrQsYula9NfxYijSNScbQehh/lbpsVZfwvY2fuuLkaCo/jJXO5HBttwWllQU8xg4vLpq0bmV9/F+/6YnyZrCIM2RaBtTdIX1Pmz2dJNTY7hGjMDZV5kL6z85ItgnXebTH/2ESFlOW8DLpAnKfB+kBMDPaJ2whH/d7SUN/1XstA9ReQgG6hJBJB71+rszgSL3jM4Kk0VZeZzieHmtv/mBf9xpZKbx7e6wfdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4yHW+Nqh1fUJiFrGlIjBASc1nFuVl7LHLv18t1VmMA=;
 b=z0X4SvM0bjutNAa+zEcZe8HRj7W5YZAwU3DInYXjNmhG3vPrzQbnRXerii+3PDyXNjYlsPQFGTClIWKklm2cQki+KJGQ55CxIruClGBzJ+GspQiM5uQj0X0lZcqKF6d0CytY62tIwTc/qY6FPsXXNtxNxZPAYnnOX0eUi7utQX0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 09:45:25 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 09:45:25 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Stanley Yang <Stanley.Yang@amd.com>,
 John Clements <John.Clemenets@amd.com>, Dennis Li <Dennis.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: only harvest gcea/mmea error status in
 aldebaran
Date: Fri, 16 Apr 2021 17:44:24 +0800
Message-Id: <20210416094424.18955-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416094424.18955-1-Hawking.Zhang@amd.com>
References: <20210416094424.18955-1-Hawking.Zhang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To BN9PR12MB5368.namprd12.prod.outlook.com
 (2603:10b6:408:105::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 09:45:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f99fdafc-0017-4bda-a86f-08d900bc5ca2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368505029DA093AAD91E165FC4C9@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ytk/Ik7yvd7hT0IxP1tSkt1Sc+MLktDbRFrwK+N0ZLmNOjOkrvIYW1YBsHUudRO6IBlQn5Gu7opU6zk/HJ4qJye+tp+mvWycH2TiXWc0cqybU4licCBSQKCdvPlnD4Tr1rKIzb2oL8g37fGhO9axoNwvLLVq1rKwFjboKhs/RXd3jYS2Tzlb9vmwNztAUPYZghdGfX9eX99OHoJLK9QbUDsuz6oUafGxII9g0um+OVFgOY4smvMPwj1L6fOKPC4kCl4Dwy+jHOEmLrKBbgx+ITjtQG3+7RZuhomL8NwcvyflpBkNbQSm/bBAa8Vfm7+47S+8Xiyd34j4Ytzh/2PY+zPX+oVVgT+Mo3UoIOEnL7K0sPOP+aOJiMSzaGWBwcLqCo7XRxQX5d1bNtJMh1dELGkCSyP/uEoVRDrffSa/vVBhK94aaTCCY/BAqCGNqbKBvH94l1nNTafKFoe5vVIuFXzWO0PchR8TpRKEu7lIu6CdM3WoTcjWQ89RWLxrDQpeQUaNa5pCw2CRAPzYcGV+1gc85TRUDOx0OA2fwoL+lTDqdNB8qryPmgp6ZdlJdHeyu0nNB8hlLI/+vzblm4iE0eRSAyfzxh6o9z7tOnzzyD2+XCqvme5r0fB4FUo/6KmVq7l6+qQKz24dDQT1gK6hRnyf+EP4KuVYsR+NaKi1SVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(52116002)(7696005)(478600001)(26005)(186003)(316002)(6636002)(4326008)(86362001)(16526019)(1076003)(956004)(6486002)(38100700002)(38350700002)(8936002)(5660300002)(2906002)(110136005)(8676002)(2616005)(66476007)(66946007)(83380400001)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eaKpYECcUuNdWy1oAHxFJvxLUzhxewFdSboeHNSrAiKvGB/2KF+DFhHPsq2v?=
 =?us-ascii?Q?PZNo/BmYm5f4LzrjRXBoxF4kz18TWcsODjitdYqtuimTXAr1cEfNxgfjI4s5?=
 =?us-ascii?Q?XJawafZxmkSAZ0VS0b/5eiRIWHDi5G1en6OdYf/H4/1nvRlVfUckmpAnE2+z?=
 =?us-ascii?Q?WVX0rBtFoJjS1q6UU1OxgniyMbCQZiEchBkXktHoNurTunN5bCxirJGeXi4B?=
 =?us-ascii?Q?abhyQNrva35+JNeiMjjp3Dk0K49QtT/cdiDdAUF6n/169ViF3N2xpgGK8tU7?=
 =?us-ascii?Q?AQm8UXenpsOS/o/50el6T+y+DVWip4Kw3Lb7Puvl05YwYLBw2vtdT5Hmu4/9?=
 =?us-ascii?Q?Bq8c0PFrg+BNH4XsYB/Twy24wLlAQ1h7SO3MZsu9pgrYlN0krUJCIQa01BzY?=
 =?us-ascii?Q?n9dTUf+U+foP1LUHYJXIWOgcud7HfZAVoS0vQYX1hB7OOE421DObIORRKv4J?=
 =?us-ascii?Q?NlPtNVIbib1zU1hnxD92JCf9JjKjXEyjPIYcYKaXYgR2qqB+I9CNfa6GZP+T?=
 =?us-ascii?Q?SY6ArS9YQytGZmZGDDHmoAh/qR2mFGw5H1ifV/MQZ7UlHpqoPlke99k3AC4j?=
 =?us-ascii?Q?iJioV2THfSYwHLlLWkfSazTxKeMfGm4XCDXhU3juAwoO3w8t3T7TsCaeB+Hk?=
 =?us-ascii?Q?I3+xf5vgGyqZ5MnB5jD5BR2EVBcPyI68mfIBovStj/c8p6O22OwgoC+khFjg?=
 =?us-ascii?Q?uweoh8A5aFa7FEKhQvDjHLejB5mFlFgBf6rHpwQydOWoRcLfae1n+sf+r5vv?=
 =?us-ascii?Q?Gyv2qtCyy9QKLy1caMlEu4aLfPm4MKeYaTTgmHISzTzT9yd9/KwYGvKGalp0?=
 =?us-ascii?Q?yYIskFkh+R/R/QzVsezs6mmOx81mZRirXzgVubrMflaa84eeNcxpVAn3wUDJ?=
 =?us-ascii?Q?mbU7vt68S9wpk7hqkUQZPK/G9Q78vwWjxjsj4+JWdX+a/zimflRNVr2PxTw8?=
 =?us-ascii?Q?gYDbklh3wYMoXtqE/sNUiuQtGe5Gav25WU4dGPR+sSgHwUPRsSeHFIqRQoo3?=
 =?us-ascii?Q?9zBhcl8uPYGuGhWIW4mgrQrjL9SkWnpXuT3BmUK1QoqxuXTL8TAZsyMVqxoF?=
 =?us-ascii?Q?lLVtpGR+8/lQI/AYtrM1rAXZJM7cGprITtzrXLQxv24jTWVJOkaMviwJV2OE?=
 =?us-ascii?Q?3zVDz06yinBgIpWSatIu8iPnFTkZCqCQjzADKa07YG3Hme+HnGNZ/m2SrjCQ?=
 =?us-ascii?Q?RsKVaWD8iKJgbsfcDsq2gytcvnIa52aQ/ku2zjDAV5+NifNyO8ANu/hYLOiH?=
 =?us-ascii?Q?o+WvfnoYhUzVZ0HiEYcDNdJP++bKnQ3oBh11JV2m1HB4NDfTNvnnf+JD2af5?=
 =?us-ascii?Q?ZU7t4kKY81vusc9eXsDOYAQeWJEWW0LgfQHhUGyB+4fyVg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99fdafc-0017-4bda-a86f-08d900bc5ca2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 09:45:25.8617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJuap65Mpe2TOqRv3ojLjm+1dk2eWD7vQdWsIVbcPpRVrgqvFl2sJKdmfIWF9QQ6J1ogykaF46ON1b9Aa5zuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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

In aldebaran, driver only needs to harvest SDP
RdRspStatus, WrRspStatus and first parity error
on RdRsp data. Check error type before harvest
error information.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 11 +++++++----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 9ca76a3ac38c..91427543aabe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -808,7 +808,7 @@ static struct gfx_v9_4_2_utc_block gfx_v9_4_2_utc_blocks[] = {
 	  REG_SET_FIELD(0, ATC_L2_CACHE_4K_DSM_CNTL, WRITE_COUNTERS, 1) },
 };
 
-static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs =
+static const struct soc15_reg_entry gfx_v9_4_2_ea_err_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
 
 static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
@@ -1040,11 +1040,11 @@ static void gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
 	uint32_t i, j;
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < gfx_v9_4_2_rdrsp_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_2_rdrsp_status_regs.instance;
+	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_rdrsp_status_regs), 0x10);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
 		}
 	}
 	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
@@ -1089,17 +1089,20 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	for (i = 0; i < gfx_v9_4_2_rdrsp_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_2_rdrsp_status_regs.instance;
+	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
 			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
-				gfx_v9_4_2_rdrsp_status_regs));
-			if (reg_value)
+				gfx_v9_4_2_ea_err_status_regs));
+			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
 				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
 						j, reg_value);
+			}
 			/* clear after read */
-			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_rdrsp_status_regs), 0x10);
+			WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_regs), 0x10);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index d0f41346ea0c..cc69c434d0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1286,7 +1286,7 @@ static void mmhub_v1_7_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-static const struct soc15_reg_entry mmhub_v1_7_err_status_regs[] = {
+static const struct soc15_reg_entry mmhub_v1_7_ea_err_status_regs[] = {
 	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA0_ERR_STATUS), 0, 0, 0 },
 	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA1_ERR_STATUS), 0, 0, 0 },
 	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA2_ERR_STATUS), 0, 0, 0 },
@@ -1303,12 +1303,15 @@ static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_err_status_regs); i++) {
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_ea_err_status_regs); i++) {
 		reg_value =
-			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_err_status_regs[i]));
-		if (reg_value)
+			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_ea_err_status_regs[i]));
+		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
 			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
 					i, reg_value);
+		}
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

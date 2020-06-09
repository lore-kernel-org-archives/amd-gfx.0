Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02378C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA136207F9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZSJASXLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA136207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACCD6E088;
	Tue,  9 Jun 2020 10:21:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861D86E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goN2Y406nBTp6/6NtgW0oKom4YI10mhlgqpdZ/XZj67UzFUm8zTMLPhYcBYzJyXh91dpo+bGavJsz/oO16b4sDdDFOKnVr4gIHb6mLY+7cQbRCUFqR9Heb1fCFVxw3ytCyUX/Q0s/15HtB296ZXeMO/cKLOoidW1gUdCoTAGW1Tbg79ZotGmJ/EXVKERF7FnWzEioSdNVq+22iRxppFakg1zwjb3NrjX7CKpkUfsOc7mTZJrz6ic7MELg242Hf78fUuaHyCeODJOx84uMRnR6NUhyP/20IS54QSOxrs/2dFqMOAEP0/db4X5dklwLRU8dKp44MqBzcBJWM8tnD/P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m+KubZ9SvvsLWgmvIiH3BKx3ON3BRxVdlnYApa9cjU=;
 b=MGCgk5pI6InGJK2+8Kb1YtOkhIoRbMDgvzN5u4dFfmUT89KZqTW3YUHCu7E1yJZxCRhXuBJVQ8CREEITPys/oWcBmx2hCegoij+KxOEo13+NiJLSAOoBMuquGGFuEu2txADQeQGrEa1wU+TcjNzY5g7au+RZLo9/zkUG/1/XpHJBnVn1FA2G9FKWTHDsQBi3PTMx2ZOkqDuHqFhEqr+beeFKLR5Z/uAGTyFdt96eWO1/Ga081o0ZFyAz5rUBaSw3FV4cWOGPLr4kyvLhSk0FFvI/C8+n/Iew9oKxj0BWyUYMqpiSUYdvTVr3yqmyKE0CaY8LHVjpP9BVYAhPCliXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m+KubZ9SvvsLWgmvIiH3BKx3ON3BRxVdlnYApa9cjU=;
 b=ZSJASXLzmB+XXz1GKKZwu3LsNYJvylENm4c7qu1390mk++erNRCVhaMhfaXMrV0/wtbxFT6EhezGMRW6pQrQWXcmC8fqVwKGw5cITfjhNzWNX/sijvUv39pvn3rrxPhnSWG7HvSfSWApxu6jFkpA2ecm209fokfDCWIxFMQh8Go=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Tue, 9 Jun 2020 10:21:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:21:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/powerplay: maximum code sharing on sensor reading
Date: Tue,  9 Jun 2020 18:20:17 +0800
Message-Id: <20200609102017.12478-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609102017.12478-1-evan.quan@amd.com>
References: <20200609102017.12478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:21:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0feadd6-afd3-4114-1c27-08d80c5ed434
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB446601F2113C50636C8841C5E4820@DM6PR12MB4466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6Eu0OoC48w/jMHuXB+WVqXJfHYRAqfl8mAQx88TbyIEDeScvni3I8V9W3/558PGWDMQsyBNcbkUsBrZCaA/qswQRwLg/tufyticSMD9kQo6fR0xsiZRDva1WK9K9E4mS+s6p2JI/AbEEt7tvRHAEthHlkaLDZEvb9me+Hd6rpdI4n1BeQhyWkLUuLSfJ8K6vwbVD1NZC5dplXhldhYHg8GmLF0VQ9haWqmp/AYL7f6drJuEQKYBe7DfEJv7oL4h94Tay4FyAEZTcPux56yyehJ/VdR96Mx69qapKUdrM5ApKOXjZ0n/sDc9v3fgqUaAvHtLXFzaMWU7nCX/Ne0WNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(6916009)(2906002)(956004)(83380400001)(478600001)(44832011)(4326008)(6486002)(2616005)(7696005)(52116002)(66476007)(6666004)(186003)(1076003)(8936002)(26005)(86362001)(66556008)(66946007)(5660300002)(8676002)(36756003)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +wkPwzfy/kwToU/5/kgkP2GZHwtrGZTlmVWGntD5n/VXX3D4gBYiQz0s4ZKiBLNtoIrO/6m3ubiQvDiOWbW38uO0VAje5qKgJNARw/T/FjeHnv0cM5Uo0+YXJinsQIv7PmdFfixbQQ5pYqhPj0+6uAlExfNNmb/5n/TfuBax/UI4ZOd9hgmP3PuA+oiDV7FU1kN/r8BXEESYDYdt/qzWYO7lNXA58+8agUroGsH60b3tlGZGlj2vmMzJnlFxbUyoCJ8ltK+v6edclre+5Xw6930mF5knRHwFfyqVa/vFlKGRRPH/3lMN+m1eo/NYtAw5a7ii7xvDcySbZksqOk6MCQRUhXG1aI9qOAIhqClMl5hAKq1roR6sQ0dsyjSLxSp6HM+JGnReOf42o0U9a5uwM3121DIFgUl387IHPEOsZ4kHesE9iKUyLQCfhq5uzs68LO0zlGbcGA9EbBC4R433L8f1p6D05nkdj2xGK+Wo+kKBBiQTafSTY8z44re8rjak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0feadd6-afd3-4114-1c27-08d80c5ed434
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:21:10.1248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWZtC6UgBV7bGR19R2XtI+ezSrZ8VXfRLq1yUkyzkB5Dnd/JXcsc8iCe5fPDNs05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the common code to amdgpu_smu.c instead of having one
copy in both smu_v11_0.c and smu_v12_0.c.

Change-Id: Idc59c6f686139d034348a613f1a7b9213198312d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 4 ----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c  | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index c032680c52b0..8415b383e7ae 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2322,6 +2322,10 @@ int smu_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
+		*(uint32_t *)data = 0;
+		*size = 4;
+		break;
 	default:
 		if (smu->ppt_funcs->read_sensor)
 			ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 1a17d853afbd..993976452467 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1193,10 +1193,6 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
-		*(uint32_t *)data = 0;
-		*size = 4;
-		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index ae1035575808..b03127273d56 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -221,10 +221,6 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
 		ret = smu_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
-		*(uint32_t *)data = 0;
-		*size = 4;
-		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DFC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD0E20768
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LSd1+52y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD0E20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57BA6E8A5;
	Wed, 12 Aug 2020 04:57:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA596E8A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 04:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clMmYWC7zPDT0vJ8ERQchwrxci4g6R3+749GSe/Bikz6d9+XuRj8+vwzmBNhrMy2HjOwjG6c1+pwBS4iIKFtZ/nMiFaDP/c4noUWuLExycZDzGs3Eknpa2spEJNeXjivnwtW+i65LhhErV+bow0/kC5dH9VrkZxei9TzjPJ9wFOuE7BRYiPqAzZXdaDjvr+hUbTN98llZlPxafVhrgZCfnPMd3fWAbgJZdwNt8rHPtAjQf7s/YdH3qnuqjMJz4VRQ5rLOyLBHdI6/YztGv3nsYanz0XLYBWitSlyDGP2RVDDbcza/5pI87AQplKAT6gY3mjbI11sCOetrKoQtAJF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhKDYW6zoXqi4RXR7/ghPeeLm53QYXPwtfJhbeODazY=;
 b=JOHTXjNb5gzrcBsjgBJqH1T7OpT4qO6wlu+hQ3/DIoBmjZVOnbh4+XuVaTM7FsbQ2HII7yunt9QLFmZuITaEXy8G8uFBnYbetewefTz271saxr8PApcL+VkhHDpOG0lSp3BNgTLQJoU5mUBGSPQm/7wn3WGtMOpOwf0K9+pvB2Snj6WiR1Xdbase64zomPpmAPjihLuLFKsn1XoWQ2zMd49kPzZvXZDLZ34W1yJ8LrjCoxDtc3xfbBO8kcBOszn3gtlO25eECGHelxg3xrQmxZCpUuGsn36loqkOKh7N38kx4x5+MiNBiEHmF8GPyiK/iQV1JFJpISiUrA8FGqjP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhKDYW6zoXqi4RXR7/ghPeeLm53QYXPwtfJhbeODazY=;
 b=LSd1+52y3leWAgHE+UYc5X2ekn+44bqLQ4N7fJykCU0qiukF9Me0TQW9fzOfKJAYCGxasC+6ENLwusqLsO8CorPCbGR19C8GkJ+uf9u/ZeeBlOd5w5EvACtJJLO253phryKDUPwrhEBehqs3kFAl8AUbXOpP2sX7x3utFQ6C2yg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Wed, 12 Aug 2020 04:57:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 04:57:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: enable Sienna Cichlid mgpu fan boost
 feature
Date: Wed, 12 Aug 2020 12:56:47 +0800
Message-Id: <20200812045647.20541-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812045647.20541-1-evan.quan@amd.com>
References: <20200812045647.20541-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.2 via Frontend Transport; Wed, 12 Aug 2020 04:57:26 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ebc32b0-76d1-487c-4c72-08d83e7c3603
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502B0CD6655AC75969B4808E4420@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxnU/kOxIXsrGK1SzIT0VS8h75+U+bQ9cWLi34P1mfF/8E28S1E2ZOeiVXhvmKoHIQEzJCNuKer9GpHGYCPGFDWUUcXA8ir2TZ1WCeI8bQ84hW9sZNj2ylTx6VGpJrsKJVzA3DOg7eSJqEooE2mL/9n70GEUpambbBPwC4l4hJpiISTH8nkr+Mt43EL2hGK3QKVZaN7WMDfAh0GmxlsRRE/0kmkKFfvJaB8sR+VCCTrOfqfUwYEmp97yVo6O2hxofKnPeDCKdOkWH58dH8Dt8WsI+3EoiwOAv69Q5k2sYdXagE1YozL+52Ff73JxcvhCg0Ypmt0eM+kP13S2rVvOjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(83380400001)(36756003)(8676002)(186003)(6486002)(478600001)(956004)(2616005)(8936002)(16526019)(52116002)(7696005)(26005)(44832011)(6916009)(66556008)(86362001)(1076003)(2906002)(66476007)(5660300002)(6666004)(66946007)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lVllmtb5f/fJYHAHjuWv9oOSoajw65vd+EX6qDEnyn4MVGK8kthlzmqm3jRskkJdgdoQ9XIBan/OSFp/DwRwAQR37ACaR4Dts2LgmZr/Vnw0Jf6mq0ozz1QFZeTP7J5BVU4uPLfpp08SMVD6OGkIWmuvuvcsz7IFiDL04aW3Wxr1zoHFRGszMoutGGVUDwi43AEtJJC5mESvrJefEcpOhb9jypiD5ZTyMi4NKh9DuNVjm7Y3SBQUFY8++elmBbNsVSFLYFP4eJ62AzvquLgp6omLkZqVEkfoj41wge8caH5D+iCFZgSngd9DV9IWkHaF56tmpzcs8kVUyvmIIm569u0p5KEcLwjDPMv/Uq0sMg+SAnJYwobpm0xlyH75ID4NFinytfhN1hTz1FTz8zep6A8wcdj/Zc70Bh3jL+kyi3KEV10azJjZOK9+06cPuhBUT6BKNV1h23KInWWo3d55vONwPH9nB5Ta7xGUx2rX0bn2ARPAI88Gu3y/DlBNIT0sEGO0hiUCS/lc59nozhMMGgtAEvELN0Gsg0FlcuHTswW01MM2Xp/d4ZEdH6235bDWZboYqRBRqZhthGm+Eh80Sf5vdt594YDgs3nf416jLA+3xj0UtYPYswBiun0mn7vHbjAwF1w9HCP4oxvVltaoSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebc32b0-76d1-487c-4c72-08d83e7c3603
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:57:28.0855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1xHiyt0yWBPGLlm251dMWvDKpMEzxBUI1EeD9g8dGtAj9YdCn8C2+bqOCXDidxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

Support Sienna Cichlid mgpu fan boost enablement.

Change-Id: Ibcaeeff7c0accb490402a1714d23adbe1bb7804e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f55dd0c2f3c8..907db635f959 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -124,6 +124,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
+	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -2707,6 +2708,14 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
+static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetMGpuFanBoostLimitRpm,
+					       0,
+					       NULL);
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2784,6 +2793,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
+	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

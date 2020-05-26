Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27312068D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zLO8aiFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27312068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7439E6E138;
	Tue, 26 May 2020 10:06:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BD76E138
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDKM4GYcqpqHka2omJidwuAX2pYe+KwXD5YRu2iPSjc957qwNRcrNV+offhe7qYJkFKLCICRg2qvovRY1IP7UHGnftKzBHQRkomLBGfxOj6guTeedIKMcMDg7Cwygcq0FR/1lLkfbWlLPix4dFcLmvitYYSVLMVVl5UPV2t/Yj60vjGPT/IrnRXzwBw/w0XiLcoQ0eoPuuf0k2vTtZsKrmlOtP32wMkhMRcwhUCOt4bmhiSP38X+RZH2Nk9TPXZAL23S9iAuhYnAkbSGjI0f41XkLmaQ8tzufRt81U7zT8F6OZkCYqtTPdDZW18fmgz8NT4Y5u7iUkSquX2HQRpoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efnb7dxPmNqmvEwtOgVHrlDZrTg3UYVx/71+lk7FOYk=;
 b=LRqhFPxMNvlAcodxNlTGmtfV8xW4emZEQa7lIRS8na4VOAIc08akQJ3iq5lInAS5mppVJBnirX0MclsUM5y9hScopziZ6SEuKLR1vRt7oX59UL8gdhDtrfJDlCr1ML2mxtw4bs0A6lIFs2BZl2a7RrUbelaqAmbpZOUybFysNn0M07G9WyncxlvDy52K8SuDmSpL2On9y9oC6+2pW/8FVd4/xm7hkeu8RkwhOIBMfXwQ/2gTrH3Rhei+zBWKtBS1DvXAwvhmvIJgDIXnXeakpqFe2L1f7WteQPw1jemrgj1feFjOmyJMyFQLDKms90WqABfXwzydm48anZbXnvD9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efnb7dxPmNqmvEwtOgVHrlDZrTg3UYVx/71+lk7FOYk=;
 b=zLO8aiFeYUgtsWKrWZAgWKBOzpBdoSCgAaUtJVEkrPPyq3B773LH9SVJxoehV/pWbpQGQ1fvRNiif7jHf+HRLReO8oVCrOUioOflCjC1MrVU9KlFuUvSgJo4cpkbXyXuPsC3aGPd5Qo9U7aDkwo7kmRrFJIAm1Qca/MynN5JTpA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 10:05:58 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:05:58 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: add SMC message filter for SMU11
Date: Tue, 26 May 2020 18:05:40 +0800
Message-Id: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 10:05:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e95452c-b835-4de1-6596-08d8015c6299
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB395867B6F6482DCDF9A2FA388CB00@CH2PR12MB3958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhJmWZy7OgWVdUZzkF+vl0G/4c71bllygmL+GzH7ADvkU6RnoesYfxBarXRanta/ywdDVNHGIR67V6dwlWVQtlzKXaGKuN30TvaZIqOQmBdW5oMYAO8rN5mzpGFrlthQjm5s7+fH8sELQ5M5D34t4l3cCQi/CI5mhdva1wuH3haExdAw6Z1YLr0u4/luOZhLACWQAEjYFYDe+kmMlIDup4EAYRGWZaquqM/4kKhKc1r+W21oUhmZC9gpbfr26kmNKAv7hKx2P2weW63N+Fd6Cix81ECiTiqf7YvAn5ItrtookJP9yC09OirqsRVCkld+EJTw4MHixKahuAUzDSYDBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(30864003)(36756003)(16526019)(186003)(2906002)(5660300002)(86362001)(8936002)(8676002)(6916009)(2616005)(316002)(15650500001)(4326008)(956004)(26005)(66946007)(54906003)(7696005)(478600001)(6666004)(1076003)(6486002)(66556008)(66476007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LLSn9EGsTJW1uvZXyr9jo6yvxSxPVtWLnumQrFW3Th2chHHwyGUGxrMM5w2JA01smnqtVfv0pWVZo4JBupfXqnrH8cLk1aX5Bk0oPAo9nwOkon/hK5nvWuVfCG0D6DyOEp8Yqm/xnLFxARLNF7yokxEZ31TTNXjC8XEQN35VJCswGleK0TRyGQ5ynfjAdFYglh8AlDrM9m0irImR8WiDBIVHDaQkRuM9y4sKu7UC4PZqgQZRg9tTvoloRoI7N6+dPqkW1qbNmBf0K13gKc5N2/wx348kp7i3tUWWXWhAmPE7Ym7hWpgL84rgGRVYl6syJD+WZWWpJscbi0X2VHM6zy/QLjoYXIr7vlNV8KJpsexfYHuyU8XT+uuYSCRRenB63cUx0bG02PRD2sT7Oh5avx9hATJJlJQLuAVNecX4G22SbinKQCr7BtlikHoSHjn4ZZFNFiwTMiCwBRWfj0Zf4/VCQSgZwwKu3UpFsI9r+aU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e95452c-b835-4de1-6596-08d8015c6299
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 10:05:57.9846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go1V518T1uuXMJoRNgHI/OOXj0R8du7E1amPETM9H5SrPpx4dbJM2mDdyEpXdOFDjI5gxMRPKNlJ2zEnBTc39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3958
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. add smu_11_0_msg_mapping definition
2. add valid info for each SMC message in SRIOV

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Change-Id: I887283cceb8ba631069a2300ef6756ba4902dcdd
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 124 +++++++--------
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   6 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 146 +++++++++---------
 3 files changed, 141 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 27c5fc9572b2..fad6f3a60dc9 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -48,8 +48,8 @@
 #define CTF_OFFSET_HOTSPOT		5
 #define CTF_OFFSET_HBM			5
 
-#define MSG_MAP(msg, index) \
-	[SMU_MSG_##msg] = {1, (index)}
+#define MSG_MAP(msg, index, valid_in_vf) \
+	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
 #define ARCTURUS_FEA_MAP(smu_feature, arcturus_feature) \
 	[smu_feature] = {1, (arcturus_feature)}
 
@@ -70,65 +70,65 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON				1
 
-static struct smu_11_0_cmn2aisc_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage),
-	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion),
-	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion),
-	MSG_MAP(SetAllowedFeaturesMaskLow,	     PPSMC_MSG_SetAllowedFeaturesMaskLow),
-	MSG_MAP(SetAllowedFeaturesMaskHigh,	     PPSMC_MSG_SetAllowedFeaturesMaskHigh),
-	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures),
-	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures),
-	MSG_MAP(EnableSmuFeaturesLow,		     PPSMC_MSG_EnableSmuFeaturesLow),
-	MSG_MAP(EnableSmuFeaturesHigh,		     PPSMC_MSG_EnableSmuFeaturesHigh),
-	MSG_MAP(DisableSmuFeaturesLow,		     PPSMC_MSG_DisableSmuFeaturesLow),
-	MSG_MAP(DisableSmuFeaturesHigh,		     PPSMC_MSG_DisableSmuFeaturesHigh),
-	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow),
-	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh),
-	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh),
-	MSG_MAP(SetDriverDramAddrLow,		     PPSMC_MSG_SetDriverDramAddrLow),
-	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh),
-	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow),
-	MSG_MAP(TransferTableSmu2Dram,		     PPSMC_MSG_TransferTableSmu2Dram),
-	MSG_MAP(TransferTableDram2Smu,		     PPSMC_MSG_TransferTableDram2Smu),
-	MSG_MAP(UseDefaultPPTable,		     PPSMC_MSG_UseDefaultPPTable),
-	MSG_MAP(UseBackupPPTable,		     PPSMC_MSG_UseBackupPPTable),
-	MSG_MAP(SetSystemVirtualDramAddrHigh,	     PPSMC_MSG_SetSystemVirtualDramAddrHigh),
-	MSG_MAP(SetSystemVirtualDramAddrLow,	     PPSMC_MSG_SetSystemVirtualDramAddrLow),
-	MSG_MAP(EnterBaco,			     PPSMC_MSG_EnterBaco),
-	MSG_MAP(ExitBaco,			     PPSMC_MSG_ExitBaco),
-	MSG_MAP(ArmD3,				     PPSMC_MSG_ArmD3),
-	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq),
-	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq),
-	MSG_MAP(SetHardMinByFreq,		     PPSMC_MSG_SetHardMinByFreq),
-	MSG_MAP(SetHardMaxByFreq,		     PPSMC_MSG_SetHardMaxByFreq),
-	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq),
-	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq),
-	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex),
-	MSG_MAP(SetWorkloadMask,		     PPSMC_MSG_SetWorkloadMask),
-	MSG_MAP(SetDfSwitchType,		     PPSMC_MSG_SetDfSwitchType),
-	MSG_MAP(GetVoltageByDpm,		     PPSMC_MSG_GetVoltageByDpm),
-	MSG_MAP(GetVoltageByDpmOverdrive,	     PPSMC_MSG_GetVoltageByDpmOverdrive),
-	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit),
-	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit),
-	MSG_MAP(PowerUpVcn0,			     PPSMC_MSG_PowerUpVcn0),
-	MSG_MAP(PowerDownVcn0,			     PPSMC_MSG_PowerDownVcn0),
-	MSG_MAP(PowerUpVcn1,			     PPSMC_MSG_PowerUpVcn1),
-	MSG_MAP(PowerDownVcn1,			     PPSMC_MSG_PowerDownVcn1),
-	MSG_MAP(PrepareMp1ForUnload,		     PPSMC_MSG_PrepareMp1ForUnload),
-	MSG_MAP(PrepareMp1ForReset,		     PPSMC_MSG_PrepareMp1ForReset),
-	MSG_MAP(PrepareMp1ForShutdown,		     PPSMC_MSG_PrepareMp1ForShutdown),
-	MSG_MAP(SoftReset,			     PPSMC_MSG_SoftReset),
-	MSG_MAP(RunAfllBtc,			     PPSMC_MSG_RunAfllBtc),
-	MSG_MAP(RunDcBtc,			     PPSMC_MSG_RunDcBtc),
-	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh),
-	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow),
-	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize),
-	MSG_MAP(GetDebugData,			     PPSMC_MSG_GetDebugData),
-	MSG_MAP(WaflTest,			     PPSMC_MSG_WaflTest),
-	MSG_MAP(SetXgmiMode,			     PPSMC_MSG_SetXgmiMode),
-	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable),
-	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl),
-	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl),
+static struct smu_11_0_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
+	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
+	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(SetAllowedFeaturesMaskLow,	     PPSMC_MSG_SetAllowedFeaturesMaskLow,	0),
+	MSG_MAP(SetAllowedFeaturesMaskHigh,	     PPSMC_MSG_SetAllowedFeaturesMaskHigh,	0),
+	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
+	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
+	MSG_MAP(EnableSmuFeaturesLow,		     PPSMC_MSG_EnableSmuFeaturesLow,		1),
+	MSG_MAP(EnableSmuFeaturesHigh,		     PPSMC_MSG_EnableSmuFeaturesHigh,		1),
+	MSG_MAP(DisableSmuFeaturesLow,		     PPSMC_MSG_DisableSmuFeaturesLow,		0),
+	MSG_MAP(DisableSmuFeaturesHigh,		     PPSMC_MSG_DisableSmuFeaturesHigh,		0),
+	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	0),
+	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	0),
+	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh,		1),
+	MSG_MAP(SetDriverDramAddrLow,		     PPSMC_MSG_SetDriverDramAddrLow,		1),
+	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh,		0),
+	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow,		0),
+	MSG_MAP(TransferTableSmu2Dram,		     PPSMC_MSG_TransferTableSmu2Dram,		1),
+	MSG_MAP(TransferTableDram2Smu,		     PPSMC_MSG_TransferTableDram2Smu,		0),
+	MSG_MAP(UseDefaultPPTable,		     PPSMC_MSG_UseDefaultPPTable,		0),
+	MSG_MAP(UseBackupPPTable,		     PPSMC_MSG_UseBackupPPTable,		0),
+	MSG_MAP(SetSystemVirtualDramAddrHigh,	     PPSMC_MSG_SetSystemVirtualDramAddrHigh,	0),
+	MSG_MAP(SetSystemVirtualDramAddrLow,	     PPSMC_MSG_SetSystemVirtualDramAddrLow,	0),
+	MSG_MAP(EnterBaco,			     PPSMC_MSG_EnterBaco,			0),
+	MSG_MAP(ExitBaco,			     PPSMC_MSG_ExitBaco,			0),
+	MSG_MAP(ArmD3,				     PPSMC_MSG_ArmD3,				0),
+	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq,		0),
+	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		0),
+	MSG_MAP(SetHardMinByFreq,		     PPSMC_MSG_SetHardMinByFreq,		0),
+	MSG_MAP(SetHardMaxByFreq,		     PPSMC_MSG_SetHardMaxByFreq,		0),
+	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			0),
+	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			0),
+	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
+	MSG_MAP(SetWorkloadMask,		     PPSMC_MSG_SetWorkloadMask,			1),
+	MSG_MAP(SetDfSwitchType,		     PPSMC_MSG_SetDfSwitchType,			0),
+	MSG_MAP(GetVoltageByDpm,		     PPSMC_MSG_GetVoltageByDpm,			0),
+	MSG_MAP(GetVoltageByDpmOverdrive,	     PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
+	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
+	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
+	MSG_MAP(PowerUpVcn0,			     PPSMC_MSG_PowerUpVcn0,			0),
+	MSG_MAP(PowerDownVcn0,			     PPSMC_MSG_PowerDownVcn0,			0),
+	MSG_MAP(PowerUpVcn1,			     PPSMC_MSG_PowerUpVcn1,			0),
+	MSG_MAP(PowerDownVcn1,			     PPSMC_MSG_PowerDownVcn1,			0),
+	MSG_MAP(PrepareMp1ForUnload,		     PPSMC_MSG_PrepareMp1ForUnload,		0),
+	MSG_MAP(PrepareMp1ForReset,		     PPSMC_MSG_PrepareMp1ForReset,		0),
+	MSG_MAP(PrepareMp1ForShutdown,		     PPSMC_MSG_PrepareMp1ForShutdown,		0),
+	MSG_MAP(SoftReset,			     PPSMC_MSG_SoftReset,			0),
+	MSG_MAP(RunAfllBtc,			     PPSMC_MSG_RunAfllBtc,			0),
+	MSG_MAP(RunDcBtc,			     PPSMC_MSG_RunDcBtc,			0),
+	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
+	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
+	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize,		0),
+	MSG_MAP(GetDebugData,			     PPSMC_MSG_GetDebugData,			0),
+	MSG_MAP(WaflTest,			     PPSMC_MSG_WaflTest,			0),
+	MSG_MAP(SetXgmiMode,			     PPSMC_MSG_SetXgmiMode,			0),
+	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable,		0),
+	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl,			0),
+	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl,			0),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
@@ -199,7 +199,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_workload_map[PP_SMC_POWER_PROFI
 
 static int arcturus_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
-	struct smu_11_0_cmn2aisc_mapping mapping;
+	struct smu_11_0_msg_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 5c6bfe76d596..09047c3010e9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -70,6 +70,12 @@ static const struct smu_temperature_range smu11_thermal_policy[] =
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
 
+struct smu_11_0_msg_mapping {
+	int	valid_mapping;
+	int	map_to;
+	int	valid_in_vf;
+};
+
 struct smu_11_0_cmn2aisc_mapping {
 	int	valid_mapping;
 	int	map_to;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0c9be864d072..2dd48b2c580b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -51,78 +51,78 @@
 	FEATURE_MASK(FEATURE_DPM_LINK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
-#define MSG_MAP(msg, index) \
-	[SMU_MSG_##msg] = {1, (index)}
-
-static struct smu_11_0_cmn2aisc_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
-	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage),
-	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion),
-	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion),
-	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow),
-	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh),
-	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures),
-	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures),
-	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow),
-	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh),
-	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow),
-	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh),
-	MSG_MAP(GetEnabledSmuFeaturesLow,	PPSMC_MSG_GetEnabledSmuFeaturesLow),
-	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetEnabledSmuFeaturesHigh),
-	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask),
-	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow),
-	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh),
-	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram),
-	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu),
-	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable),
-	MSG_MAP(UseBackupPPTable,		PPSMC_MSG_UseBackupPPTable),
-	MSG_MAP(RunBtc,				PPSMC_MSG_RunBtc),
-	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq),
-	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq),
-	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq),
-	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq),
-	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq),
-	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex),
-	MSG_MAP(SetMemoryChannelConfig,		PPSMC_MSG_SetMemoryChannelConfig),
-	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode),
-	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh),
-	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow),
-	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters),
-	MSG_MAP(SetMinDeepSleepDcefclk,		PPSMC_MSG_SetMinDeepSleepDcefclk),
-	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt),
-	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource),
-	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch),
-	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps),
-	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload),
-	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh),
-	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow),
-	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize),
-	MSG_MAP(ConfigureGfxDidt,		PPSMC_MSG_ConfigureGfxDidt),
-	MSG_MAP(NumOfDisplays,			PPSMC_MSG_NumOfDisplays),
-	MSG_MAP(SetSystemVirtualDramAddrHigh,	PPSMC_MSG_SetSystemVirtualDramAddrHigh),
-	MSG_MAP(SetSystemVirtualDramAddrLow,	PPSMC_MSG_SetSystemVirtualDramAddrLow),
-	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff),
-	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit),
-	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq),
-	MSG_MAP(GetDebugData,			PPSMC_MSG_GetDebugData),
-	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco),
-	MSG_MAP(PrepareMp1ForReset,		PPSMC_MSG_PrepareMp1ForReset),
-	MSG_MAP(PrepareMp1ForShutdown,		PPSMC_MSG_PrepareMp1ForShutdown),
-	MSG_MAP(PowerUpVcn,		PPSMC_MSG_PowerUpVcn),
-	MSG_MAP(PowerDownVcn,		PPSMC_MSG_PowerDownVcn),
-	MSG_MAP(PowerUpJpeg,		PPSMC_MSG_PowerUpJpeg),
-	MSG_MAP(PowerDownJpeg,		PPSMC_MSG_PowerDownJpeg),
-	MSG_MAP(BacoAudioD3PME,		PPSMC_MSG_BacoAudioD3PME),
-	MSG_MAP(ArmD3,			PPSMC_MSG_ArmD3),
-	MSG_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE,PPSMC_MSG_DALDisableDummyPstateChange),
-	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange),
-	MSG_MAP(GetVoltageByDpm,		     PPSMC_MSG_GetVoltageByDpm),
-	MSG_MAP(GetVoltageByDpmOverdrive,	     PPSMC_MSG_GetVoltageByDpmOverdrive),
+#define MSG_MAP(msg, index, valid_in_vf) \
+	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
+
+static struct smu_11_0_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
+	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
+	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,	0),
+	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,	0),
+	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,		0),
+	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,	0),
+	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,		1),
+	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,	1),
+	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,	1),
+	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	1),
+	MSG_MAP(GetEnabledSmuFeaturesLow,	PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
+	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
+	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,		1),
+	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,			0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,	0),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,		0),
+	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,		0),
+	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,		0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,	0),
+	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,	0),
+	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,		0),
+	MSG_MAP(UseBackupPPTable,		PPSMC_MSG_UseBackupPPTable,		0),
+	MSG_MAP(RunBtc,				PPSMC_MSG_RunBtc,			0),
+	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,			0),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,		0),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,		0),
+	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,		1),
+	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,		0),
+	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,		1),
+	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,		1),
+	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex,		1),
+	MSG_MAP(SetMemoryChannelConfig,		PPSMC_MSG_SetMemoryChannelConfig,	0),
+	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,		0),
+	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,	0),
+	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,		0),
+	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,	0),
+	MSG_MAP(SetMinDeepSleepDcefclk,		PPSMC_MSG_SetMinDeepSleepDcefclk,	0),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,	0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,		0),
+	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,		0),
+	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,			0),
+	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,		1),
+	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,	0),
+	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,	0),
+	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,		0),
+	MSG_MAP(ConfigureGfxDidt,		PPSMC_MSG_ConfigureGfxDidt,		0),
+	MSG_MAP(NumOfDisplays,			PPSMC_MSG_NumOfDisplays,		0),
+	MSG_MAP(SetSystemVirtualDramAddrHigh,	PPSMC_MSG_SetSystemVirtualDramAddrHigh,	0),
+	MSG_MAP(SetSystemVirtualDramAddrLow,	PPSMC_MSG_SetSystemVirtualDramAddrLow,	0),
+	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,			0),
+	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,		0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,			0),
+	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,		1),
+	MSG_MAP(GetDebugData,			PPSMC_MSG_GetDebugData,			0),
+	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,			0),
+	MSG_MAP(PrepareMp1ForReset,		PPSMC_MSG_PrepareMp1ForReset,		0),
+	MSG_MAP(PrepareMp1ForShutdown,		PPSMC_MSG_PrepareMp1ForShutdown,	0),
+	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,			0),
+	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,			0),
+	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,			0),
+	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,		0),
+	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,		0),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,			0),
+	MSG_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE,PPSMC_MSG_DALDisableDummyPstateChange,	0),
+	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange,	0),
+	MSG_MAP(GetVoltageByDpm,		PPSMC_MSG_GetVoltageByDpm,		0),
+	MSG_MAP(GetVoltageByDpmOverdrive,	PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
 };
 
 static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = {
@@ -218,7 +218,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_workload_map[PP_SMC_POWER_PROFILE
 
 static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 {
-	struct smu_11_0_cmn2aisc_mapping mapping;
+	struct smu_11_0_msg_mapping mapping;
 
 	if (index >= SMU_MSG_MAX_COUNT)
 		return -EINVAL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

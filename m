Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E99C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655A2225C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sFeJCR3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655A2225C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4411F6E21B;
	Tue, 27 Oct 2020 09:42:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874A36E21B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaaJSzEB/fc1+ERij9JOpWv/gtdLPxRgOpqK7IcwXLZHH5qNhmtH7+esk5I1dgsB1kG+JbmTs7emSHluPJQ8Sjclb1e8C7fYv8kRK/jJlwZoWyvby5WEI7xpsNtO2nGkJf3VTbqo5qH+zY5XTldqJpQJcGhmp86svFRmdYII5Wk32cYwGfz0RfWcTKOr4XDX10jbQFEv4B26uz0lZKykhL+I59zmFSSed3nAFOnpwecoJUzcrk/XMoR1xbO+P92sadyepyYef1nCSm/iCDN2k+vETXPvsg5rB6b02eUZy1vK48oalJbQq/6z15t9T0zr7+WiOEzUdna+IV2PUf2yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM0jfx1pOvloWg6Qz0GSJCQfVRATefUBDWpQ8K4bjC8=;
 b=lkY49FleSC1kSjmi9isxJh0GQZeKOzkK1RVrkJZfgyOP9HFsBS0heIXK4gEHTjqRZ4+btbyChPSIPBn8j+kteHbOxJMUF5zWY94px/lcHrS/JedVGNjgkJ2D8Uhdh0slImNHsH1nR5uCkCdl+qMprBvPVNw+D8swYFOYEXzuGCzH22wHdFKj+7KdW4hpy/D2jIV4QXQJ5+D2HecZ+BSE9+PxQ5dvgxeVUI6/wg0/WZ5m35QisFRbQdFgXRJFig4tfPVgCzuHPzh0v5AKcVg6ScFvFagWLcECHi655WvTx8tNigvZFWbjrP2xfIV+9fC14QS9Sr7qr+b0lSHfaz1ZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM0jfx1pOvloWg6Qz0GSJCQfVRATefUBDWpQ8K4bjC8=;
 b=sFeJCR3BOkqBEkIw2Dald5DOipUKSIt3pY9K5V2FwZntAFBbD4VQyEONhtiFHff2ngmBQvQJkKwG5e6ZPLBxlbD97C2mXDat+gsag8aSbOUmv8xpfHSIgciLX+d0sU1hvawIDkSDC2WukTuUJ/Q6nIyrzQen+sHFtyz6lxlusKM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:03 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:03 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 03/10] drm/amd/pm: add new smc message mapping for vangogh
Date: Tue, 27 Oct 2020 17:41:26 +0800
Message-Id: <20201027094133.21881-3-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b703244f-5e98-4fab-85c6-08d87a5c8f4c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845B9F0C8B98DE727C948C3F1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYAmHOI2E6dGLFWAfmHe275SK2XVOTxjuRmzTS+cvHWJhT37jmCc6YRKGZCrB2qJdrNPti4VlZvwIqY5JGNrHa9Sa++uSj7UEHYldfqw8i5c9tZGeKnr2u7OXhQxHwnH9bFZa6Jm2BjfcBlhNKQ6jGfQDt7VusLNDbwao5RjT0rrNI7wGrW8iHAtuIDyKrRjLi7j0kapodXdoRnutFahORGe/XRT0ZNNlzzj/R4BW44UUwFvQM2peEgc3ZZ0yeQbtlwu7fkSG5aID0ep5RPnGdMq2xj7cVfrj/3KioBy++qcpT7V0XA9L2tqgoSsd7pDGSLgExCeCZOx0PsmbabbEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(15650500001)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S1b7reb7F01K9KsMXGVdkkjDNj8/bof/OZN9lMB/R1N2Tu5zyPbDRGEYYgHCTi9Hr24p3Xu8cF/nuy5HdH5OwECu+lWWP8r9/sCCKejsldfCSEDm6E4oZc9qd7Gh9Hf77XccDJ+i9D07pjpoJ3+M6zg0aBSBIh9xj+Ooq+ISIjvNmz+0twgE3TRApE7zXAyBWbFQXipuFZ8znrBlo0C5PSLSpw04XNLPmmBEMXjqqj/MVFiFVz0NgR6dFk4p+MroXbMDsnYLFn1Fce7s2nC+OyG04SJOER2EjWpXs866j+5iVY6xgzibdv33oZoR0MGv09w+khEEvbjf8AqgAY5d0B+jEh6/JjEGh15nGrvCjP3zL4YnXCSI65gq8hVQ/i3uODZDogk4WQ+rs2sEydZrhGNz+MpqJqAq7O2xA9KiWttG8J0Cy6DPT+j3wjKxuDmmARM2cunXPcgjFdpUCKT+Yar3uBh4Wcolhas/TBpbUbrRNEZJvoKu+u7RuuZccBw3T6lSgr4E5YLCdfodHdsBX2owQstUAcunkUZY8d7LcdwGAAtrY19o2LrkDdKIOJzDh1SpdVKtxwjMC8PUQ7NlFsOhogvEmv81VqE7PfnvE0555Geq6/lghh6YMjdVDO0mwVHKfoqMIZYTFEUvzCDyoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b703244f-5e98-4fab-85c6-08d87a5c8f4c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:03.4321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpFbfZHm0GgkqrvtNmRK7K8s2dE/tKcEBWplCE4m1cl3j1OveJXUNz5LFDTMG6w+7Kq2myu2+E4tBPy8uTGwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add new smc message mapping for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index c8eee2a427d0..1e8558da84af 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -184,6 +184,30 @@
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
 	__SMU_DUMMY_MAP(PowerUpCvip),                    \
 	__SMU_DUMMY_MAP(PowerDownCvip),                  \
+       __SMU_DUMMY_MAP(EnableGfxOff),                   \
+       __SMU_DUMMY_MAP(SetSoftMinGfxclk),               \
+       __SMU_DUMMY_MAP(SetSoftMinFclk),                 \
+       __SMU_DUMMY_MAP(GetThermalLimit),                \
+       __SMU_DUMMY_MAP(GetCurrentTemperature),          \
+       __SMU_DUMMY_MAP(GetCurrentPower),                \
+       __SMU_DUMMY_MAP(GetCurrentVoltage),              \
+       __SMU_DUMMY_MAP(GetCurrentCurrent),              \
+       __SMU_DUMMY_MAP(GetAverageCpuActivity),          \
+       __SMU_DUMMY_MAP(GetAverageGfxActivity),          \
+       __SMU_DUMMY_MAP(GetAveragePower),                \
+       __SMU_DUMMY_MAP(GetAverageTemperature),          \
+       __SMU_DUMMY_MAP(SetAveragePowerTimeConstant),        \
+       __SMU_DUMMY_MAP(SetAverageActivityTimeConstant),     \
+       __SMU_DUMMY_MAP(SetAverageTemperatureTimeConstant),  \
+       __SMU_DUMMY_MAP(SetMitigationEndHysteresis),         \
+       __SMU_DUMMY_MAP(GetCurrentFreq),                     \
+       __SMU_DUMMY_MAP(SetReducedPptLimit),                 \
+       __SMU_DUMMY_MAP(SetReducedThermalLimit),             \
+       __SMU_DUMMY_MAP(DramLogSetDramAddr),                 \
+       __SMU_DUMMY_MAP(StartDramLogging),                   \
+       __SMU_DUMMY_MAP(StopDramLogging),                    \
+       __SMU_DUMMY_MAP(SetSoftMinCclk),                     \
+       __SMU_DUMMY_MAP(SetSoftMaxCclk),                     \
 	__SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
 
 #undef __SMU_DUMMY_MAP
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

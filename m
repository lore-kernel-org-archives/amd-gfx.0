Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B63C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E04660E09
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04660E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3856E0EC;
	Mon, 14 Jun 2021 17:46:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8586E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URD59eUP3yrlR0lyCC6t/oqpcPP8I0Y2c10hrZekTOVrDYIux8ocnATtfvxBXZs/K+n9nUL5tC9zNRKnf//nC+A5elaFUqyu4Z0LLQxAyzAAo4EcsiylXFFd5GlR06Wn14uw+WWJL7iDRfNzmCOEDuAV0b2AoXWwCGqi3utDYGJEgOOP7+lZaCQnEQumduBjqM9+304xUfzNPdWDhR+Zq8h5nQV242N2fGRwmLR8Tlp3S92eJC8YFTqkAH69Luy4CN8Bj/KGzaaIf5ULfcbLelvwV41j6hmDOJyRfl2Y7FXG1f+j5nD0ReIsJmringkkbHlWcf7M/p+ijVqqAdCj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=nPRksORje1+EB4LQENFqC2ZHYRGktYBawuItNs09ntDMMKDQ/A38wbuykJhYmEX2XQpetJalUsEwN4ICRUkpEZ8VTimqVtIHQkCT2vGIWITByXajWYh5Rpxv/pXuaWjx57KNjeeDmQxZw90v25jGdvbL0YJlr47zT/FhIwcQQ5BFeKH6Mq12amNrZYb4/WqEW9zyBeq/Fr0EGVenBykPEZW7HZDFsoRPQsjErAxA+onI/BkpvvNMfnklodS4qtm+pBGv9s0waC1oqQG0cLU57pj7t/e+2JdIBnln25VQQXGVpwrRjgXpVp3OfwkG2eRf+7tNlS5cYNnJxnxCJizFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bciKcRwCogV1X2yodSGdAhM+x2xYXr2wN+/7X1+28=;
 b=ljUCKn2z8+KBhdvE6uF7k3uCL8oUJ/LX185pqFcw3D5nfvRYsAIrI8+UbBKIsaLT9qSfzH2+Dqn7QFpvoM/lPb2JWv+H13xhwlFajlSRlUrBx8vZ2QOtSBCOfZwwDTrRFzQfoloBMjovWwe2y5onrtrt6vikCNJ7p999NEmNP4g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:46:48 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:48 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amdgpu: add a mutex for the smu11 i2c bus (v2)
Date: Mon, 14 Jun 2021 13:45:53 -0400
Message-Id: <20210614174632.20818-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba4066a-6fca-4bd4-4ee7-08d92f5c6233
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690F6E057DC3DF9073AAF6699319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fa8Qqs6azSxtOe9FYyota9fLniv38nF1KXF8QWtmqF60e1Ndjo8NbWCoX32h4vdxEKlwbtt0syS8KrODyHA4l8LljNjBGVOoDp+8UnMW5sFf4tokCjZ7WTAeyDotg9/+LfMPtKGyxRacYEB6xuYb+OYNHMyE+VW9XrVXhAeU/cSepF1DP0b+zktTdzUw9JMeNMX/Rt2Ry5pW2V/J6/S/C7tmPRDqmeDsk/6Zau94dsjd6a/AciZmxrtA8dQJC3l6xK5xgEJOSUjuxBxhJsXk0EcioGN6xMLtODVHof5OX+DUiMGv137Qv32PwThZ+5ykJWL1WhnDNBRc0eXnP7QQg968d8qOeaut03E/g11Jl4UVGEobvuzPMHIv/pxFC/a/Ryc8MWGvonfN+Cvm0w4epSRNV8vroniT+85e8HOCYvgMt6vJKeNlCTsQ7w0krJzgtjsJ8s3XkekddRRbwPSBPZnOoSdwNs3BUUpCPELkFXkdj4zwWwAJ9AbDaYcHYAj8AAyBhi/JR2a9kwx+XCY6yFl4t4w1a5YLf0QJu1gjt07dRrvFB46ljqrbywMkN6f//XvX6VhMFucnwIZm9XzyJtsVRnJw20C8RO8bw+4VLNkxf6JNmcLFNXCE262rKhtgNiJcSdhkbK6PkQ+P4YT921vHJQLZFEdSRTMr1Qwgtf4lT3I0H9qSF/InTwvIwoxO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ob0Sdfb2t8bn+GfHpRdmQFlRwtkUB5OMwqctOOu4zfRTK57Scn3dy5xys1oX?=
 =?us-ascii?Q?qHRWjnFMnt0zAKUH4V74BRiw1Msy+o+KVGefYiLBoeIsvGQdl1FoNkBp1Cz5?=
 =?us-ascii?Q?ZpvSK/EP8KKBtb6sQjM2ABdVyx/OppMxYp8EIzmPU3nY49VmZ8UYaCLU89iO?=
 =?us-ascii?Q?WX4T8G0+hydEmDaQkIXVvHFC0XY4T5IMVcHWiQwPbqT1lWbGRvW/HmzsTnST?=
 =?us-ascii?Q?Or7Tfn//5P54EsdLA9oFxR4NoN48jNGzlh9AXDWcK6BmtryZnMyS/ExuXbEa?=
 =?us-ascii?Q?x5ba1WVW1M2fw3iLVxVp4beLPK6UyJ1GfjghFi1qCkMN85ciDRpeUd6+93kF?=
 =?us-ascii?Q?I+aZeVTgDlYPmvq/UKFFTxxL+jgzK9/NGkB+uXhVmjGoX68pc+lToc1MgiPl?=
 =?us-ascii?Q?KrL2cUQOT2LNuqWIKnIAP65jTsaV/vXNJa0bAsNvvajXqGNvDOGIUGyA0J2V?=
 =?us-ascii?Q?AjUYomWij/nrVuryoaHtIwVDK7cxfW0UtOMQ7JYCIJuUHo9EYSMLumkb+IKS?=
 =?us-ascii?Q?4F7nBb6hji+sjADvI/7t5nwgMnTclgdXf2kJrqMQp0RSzfjahenVnmI2VdXW?=
 =?us-ascii?Q?14IfX7G82ukt3O8vp66J5OlfyaVXrlYiNJX/t/xY/quaT8syisQuGvnKUX1N?=
 =?us-ascii?Q?uhvR8mP2e80A8v90GCfZ+NcELJiOuvXVAxcqmqzamWc3oih8deJBxkjlGgQN?=
 =?us-ascii?Q?M6Rs2ZNtaAkawj7CoGRnlL+1zUh/drIzBlj0O8d7D7Tsv//LqPJ1YlCnu/Yd?=
 =?us-ascii?Q?IFss7K0L3WCqjijrNeUwFIjPWJY2QoPxA3uXabA/oCbFEbeuNhDz39aRdGJX?=
 =?us-ascii?Q?Zldazf3ozL2OLEpul1vV4Y0RIiw90pwqALAX9t9QqxcZB71Cz9IG9Mxku9z4?=
 =?us-ascii?Q?grsodnDV5Lad8ZB9tHOIJN8OlwtKW8YvVw37aMUJsSwyYIq0Ylk+RX/2Y6Nf?=
 =?us-ascii?Q?h5/M3KREQcyGDQN63jiaGuuUCfaIsQsHgSoFMjPXom1PXIt2u+vAvk7KIujT?=
 =?us-ascii?Q?Qz1omXS1M5toSwCGicqATAzF05SYuvR6v/uIlRSbrgQ/iRBH214h4X4WfJAz?=
 =?us-ascii?Q?TKYXmPisB69tl/ojvncdmPl0i7mliOyGo7T9EMyb+zhjUBuldaLpMOIOGwDm?=
 =?us-ascii?Q?/WNBjJ9DYI26nAdzTB7V0lKkfVLkCYdcPPzdW7VlgdkWF7STSDZoYocHKcEj?=
 =?us-ascii?Q?nq8LsRdmkIdQ8IDFFERE/T3Q0OhSEbFWmKiwYzfmt2Y0N1RjLRyfO3sR/1hB?=
 =?us-ascii?Q?t2igSBvF+y4WystTK+kcjBBp2sYxgyjTsyzADX7MAmHr7iVBwoD4HsGBnWIE?=
 =?us-ascii?Q?hTg/hVT1flRopTIebPqwuDN7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba4066a-6fca-4bd4-4ee7-08d92f5c6233
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:48.1531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX6PhIpaRb+FqS70yoTAh71rYZaGLBHlcbxhPycNzKib2EX2qh8+hTi+/vZuUyY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

So we lock software as well as hardware access to the bus.

v2: fix mutex handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 5c7d769aee3fba..1d8f6d5180e099 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -584,12 +584,11 @@ static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_lock(i2c)) {
+	mutex_lock(&adev->pm.smu_i2c_mutex);
+	if (!smu_v11_0_i2c_bus_lock(i2c))
 		DRM_ERROR("Failed to lock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = true;
+	else
+		adev->pm.bus_locked = true;
 }
 
 static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
@@ -602,12 +601,11 @@ static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(i2c);
 
-	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
+	if (!smu_v11_0_i2c_bus_unlock(i2c))
 		DRM_ERROR("Failed to unlock the bus from SMU");
-		return;
-	}
-
-	adev->pm.bus_locked = false;
+	else
+		adev->pm.bus_locked = false;
+	mutex_unlock(&adev->pm.smu_i2c_mutex);
 }
 
 static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
@@ -665,6 +663,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
+	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f6e0e7d8a00771..d03e6fa2bf1adf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ struct amdgpu_pm {
 
 	/* Used for I2C access to various EEPROMs on relevant ASICs */
 	struct i2c_adapter smu_i2c;
+	struct mutex		smu_i2c_mutex;
 	struct list_head	pm_attr_list;
 };
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

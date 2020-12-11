Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C523F2A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C523F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48816E2D7;
	Fri, 11 Dec 2020 09:01:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17346E2D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 09:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMGQk002vHsHUR3tRC7GNZvzhsRR0nDHuaPemsKG7V+dcT2Aze6R2tPQJX0GkQsUUXMggQGXHsQqWo+aMdWcK1NpPKsCwavFetF5uNwaN5FgaXIW/brnGUQsSFCitvaGhqLFKbigFCdrTa7EMZzLGb85VxPbvz6KWjfWWfTj/EV601gVQUwjkJjnFkhfukorVRtjMvMqAHWqZb5hBsgYY/4in5boG6DrRJxoxEhi10VYglLTePfpAneQ+4f04iil32qSSgiVnoRAdh3QVcJiWhRxD3FYN6N4A/L0K4VeZkxwg6tFcfEX82gG8yDjpR+vlJID22ZWeabhXwzyvAUJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS5JEJSnEvqY+XPiq2hxDIEPL/zxkKnjymnkpPXGA/k=;
 b=e+oZrWcjKadMXm+VVoj5PMbeCFULnzUdX7pNZHIM3lLiOmjZSuM//5GFZEZuvadX/aCQN2iJojZ1We4gBKgU4AAP+FScQqbbbrPe1HpPUb0aPhPADkqph5ygF50emRjMbtYZ+00vFn0JrDx3pVyXw2MwA8d0xyADMD0gBOczlLklCH9uKJPBaavJhH4+s1w30qBxxoqnMIjMlU7LwQov3dW/FzTwALDR/ZqCaFINjsJdKCxQwdFiBipAeTFp8v3Dbje4DdvZWuh78QupGTkw+WyQ5F3bStGJ9btvkS79AiWN4hdevTXEZ6OkLfYuVhllqb4JisvODCLKeXIm1NevDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS5JEJSnEvqY+XPiq2hxDIEPL/zxkKnjymnkpPXGA/k=;
 b=JzprH+guWqnsiHJcb8tBDMjldl0ioWtClSZBfmLYYZuy+nCou0jB3CKcls/cH976GxZL8nGyMpNBBcvOGw7Stv5nceMatDNblltY//N7lF1pMwrVVvkH2ZjDGVX43x6M0yT+s909frlDmjmkog6HRaReA6clYJ7q8VJ1P9+kC0Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2585.namprd12.prod.outlook.com (2603:10b6:907:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Fri, 11 Dec
 2020 09:01:34 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3654.017; Fri, 11 Dec
 2020 09:01:34 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [V2] drm/amdgpu: add judgement for suspend/resume sequence
Date: Fri, 11 Dec 2020 17:01:13 +0800
Message-Id: <20201211090113.110283-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:203:c9::15) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HKAPR03CA0028.apcprd03.prod.outlook.com (2603:1096:203:c9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Fri, 11 Dec 2020 09:01:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 209714ef-7450-4e78-d084-08d89db35c0d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2585A76F7BBA39E010402296EFCA0@MW2PR12MB2585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CYZ4iNJUyv6RS1SyirLS14aLogUS1SYvJMwHvPFDBeoyLA/oGalTpB4cEk3KJ90Vwfx9W//e31v82VAECa5O5ZNPkZaD7NvHsa7Nqy/jBsa649xLKUHtISvIH0wu2tCF6i4S6E4z5A9/T2hDk7ZiQqMkyWvUK2XUAOn3+22sp432mE60hKT73GjAMOPhN4RZQxy6PIViak5ILmwGXwab6dA2mv03tVUmQbLHbE1d/yi1d1G9q2Vo+58yRWywyFUC7KtL6Un6TpuPQAyygw1nZ+ZNO/BfEkIKc9Qy1EQ+4ZSMs2M7IQDAAMPfNwp2LUb1D7KM0YbKWYawZ6fnFu2DyzC38WQ16LPrjZh2QionCdIisjPb6x/ndNXSfF2nrbp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(6666004)(8936002)(6916009)(54906003)(36756003)(6486002)(186003)(4326008)(86362001)(26005)(16526019)(5660300002)(8676002)(34490700003)(508600001)(66946007)(2616005)(7696005)(2906002)(44832011)(66556008)(52116002)(1076003)(66476007)(83380400001)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MmLq7I1V/gAmPguHR1Sed2FifzYcNl4hNb5ZQ7chqmCtytJSK/DIiSoF4P5s?=
 =?us-ascii?Q?G9kRDj0WpQVLKiqUJwXQ9RqZPymNsjkY7OAc9CLuQG96XZfRGvx1jSZ97KPt?=
 =?us-ascii?Q?MbCVnsFdn73TqXUSh9Fc54fWaCzo+oiaWCiAiFBHRm1RfTorjESwXB9XchR9?=
 =?us-ascii?Q?JrZe0fangtNcizfR6p6w0giV3WRWWk1d/xGawohUdOzXhSx+Z1L2KAPEfZl6?=
 =?us-ascii?Q?xi6vdPPBeC7HPD1HX9Db2LPMjdBjXqjn9Mel0KmrTKbg4ksN1DpHwg+X/8Z0?=
 =?us-ascii?Q?q3Kof1UJfavS9hPZRS/XqUACkbp/DREG7DPk+n0WqqWQLeWtYL1Aecs7LHyK?=
 =?us-ascii?Q?zWlW1NcM11ZDOrfEBcYEM2S6gb9UgDroVRJKrrzZKh01+hcjNz7xIFQOXfbb?=
 =?us-ascii?Q?Ydl/BCmYmlz3Vp9dzKacVvVO9FlYgQu0gxbsfn03ju5NAso7y6phWJKVjw2g?=
 =?us-ascii?Q?VegIgK1aHdAMdqU9C4Dsa6PRLltrTJq6k4Kvq9T+BVV0utS594/e9Ay2JZ0Q?=
 =?us-ascii?Q?/kvhjMI4LthXCWUX+HKlfynLn4xQt0AZqgRVBZ7v08WaE6pFRTLDfquw217B?=
 =?us-ascii?Q?N7lMuJKD5nxoLGeM7bXds1GJ8fx4PD3seedhhl28tyJiS8V+Q8aDXlEwpi7p?=
 =?us-ascii?Q?narlFZwsS4Ti7/xCyR6bOQ3DzPqweq9ySTcwC3ywFsmUdOQNDgQWe57eeeG0?=
 =?us-ascii?Q?6rfI9VAGIxGCXNe9bEc6RtgljQG0uC/Qy+6eYrYTAALfK1avQO1+OLHAI8AD?=
 =?us-ascii?Q?BEg3WrHCnIDulCV7fEQP7aGMJuIZuuD89WFBTWfqHm5Ap9kQul5Oof9yBXkk?=
 =?us-ascii?Q?psNqYRvS0nVDWX5VB/fyz0jb6BxUmhW59bIHsf+x+qWUEuaCXNZIj8TJHEBd?=
 =?us-ascii?Q?nTgE9aQKG/Bhh2FmmGy4goOoG9hZMfYmrIpGbIP9DoeVFguhZp+CrhFxq6rU?=
 =?us-ascii?Q?U9eU47ntv/d7l0XvbpqIh4oh/FC/NRYDBLDXIyjd5zzoZLQFIO04PCc3f3bp?=
 =?us-ascii?Q?IDzv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 09:01:34.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 209714ef-7450-4e78-d084-08d89db35c0d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzsyCQZWC5P5Dz1j9kkqAcSZFjYQNud5nQVel1I0cSCQRk9nO1phEhE6LxiHgTQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2585
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

S0ix only makes sense on APUs since they are part of the platform, so
only when the ASIC is APU should set amdgpu_acpi_is_s0ix_supported flag
to deal with the related situation.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ic89df206734fa7e6ce3e5a784171f149a07edc80
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 83ac06a3ec05..eed5410947e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1314,11 +1314,11 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
 		struct amdgpu_dm_backlight_caps *caps);
-bool amdgpu_acpi_is_s0ix_supported(void);
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_is_s0ix_supported(void) { return false; }
+static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index fd66ac00c7f5..8155c54392c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -901,10 +901,12 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s0ix_supported()
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 {
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
-		return true;
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
+		if (adev->flags & AMD_IS_APU)
+			return true;
+	}
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 52d6f1fbe890..66b790dfb151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2651,7 +2651,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
+	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3712,7 +3712,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
+	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
@@ -3747,7 +3747,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_acpi_is_s0ix_supported())
+	if (amdgpu_acpi_is_s0ix_supported(adev))
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

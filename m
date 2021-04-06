Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 07:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B5960C41
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 07:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B5960C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74DB89FF9;
	Tue,  6 Apr 2021 07:30:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770079.outbound.protection.outlook.com [40.107.77.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF41189FF9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 07:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiVlYSxR24ht1Cn8lj8uC314Y0BOpJdtrGWyegRorJ20Vq3v+2zyRd3YeCUqRW4CZj4IHy8EMP/JGOSbMCutT9LOr0hrbyezp81FoYjQjFMe8WQ36GOuiF0Mt4g/G86EoMDYt0zvgPOR7/eG5DREgnr9AzR9bw7Qn8HlFWJQmfwwEOeJ8VMOiRdNu7Io0CMPM76ig6+4VEw3QOS0++WayPwVuBV3NWCjim1lSRfy0ilYYbtb03M2/w8Xv5psWBdKyEhUEIRsMFgE+x8zQApN1sf3v9aS2LMXwpGvCUowkPOzl/+GoA6cfR0uqozInp0McZcuktoOgMz9hJW0HOLoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loocyELSkhlLBYIs952i5phIvoswbm3tggXbqQvcl2Y=;
 b=XFqapkCicB25WgEfy85Ta5StOiOYl4a+1fVq7JXze/y3UPaKhKFB6QXtpuHa+FO5Yzu9Zvv1m5ofsul4sNuau1OGkb0Ji0ysT2Ils8cOHb9zFdr6Bw5h9+hgtGZmEfd32oSMARlpvI6r2T5MLl6V/GEgziGa4kCiu1Qbthx4v1IFx6vHuUmaB5ozuhaq3vbEVRXUh+PzLMACFBhZyGwHmwbwHJwA0c4E5zmEjRQGJzlP6sv3ejn8krRHxec1d+v/G+p1LuFcD1fFUwLAXkMs3uofbMFdlls7CpqHvYDiaWOYjFfjoMFh4JnP0GhZNih7shZMGVX6nuGbE73ja1WiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loocyELSkhlLBYIs952i5phIvoswbm3tggXbqQvcl2Y=;
 b=YByeq3JKG9brv2AUVe0sZmseOfczin4df80Yhva2ksAYoxg5Lu8cLefaqjhtAo8z1KeB6lmi70qOsPkrFoTNQq68rKVRNVvAKHw1UK0+Ha9gFBPdl8czhR8LinBszKMeJu96LKcpT8HrY1cnlXzEKda9Ehb7I4yGfgwo7+o5MSc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MW2PR12MB4682.namprd12.prod.outlook.com (2603:10b6:302:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 07:30:08 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 07:30:08 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com, PengJu.Zhou@amd.com,
 Emily.Deng@amd.com
Subject: [PATCH] drm/amdgpu: fix gfx9 rlc modprobe rlcg program timeout issue
Date: Tue,  6 Apr 2021 15:29:48 +0800
Message-Id: <20210406072948.26470-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (180.167.199.189) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 07:30:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0feb7bce-b67d-4678-f6a1-08d8f8cdcdfa
X-MS-TrafficTypeDiagnostic: MW2PR12MB4682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB468283DFA12C479ABF70D5BBFD769@MW2PR12MB4682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AO9Q8lqwPPqNTZuXJu0VZfCWNQpz94YMmSgrdtpIhe7L+qOiD9AUeM2m5DIDedKg1K9WjO6yLNl1M/y6n4341oBbsvG2sloHNdVcO1WM2IHd4YBAkMOVL3HKr/9QokTB5hkebB7zny+rZz/rFoxxMzFzP3Pt3kAIlpzEG9tGbmVF6iPpPlJAZmg3cVytgHPLAaSqWAzfScyK7uQHK1MrejYW0t9JhVU6GOrP38MJbEJ9zf39E4dq9FsiGPREK5xOugSDlEd7wa8b6se+2kFqR1j5KiOxIMgND59q50MLUcp+zh0OXXGKoTuFKAJSwUv1nH8bp4oGUrOMI+SOFf+CsUbo8jvxS9oJsPHG4UJ2d3QHi+bwLV6RgIT7fWbcOsEtr00iaonpinA4jK7KJuxpB1nuvM8im92tr/1nqmGhSIwi5OxtqpaMMvCACGawpS21FbZV7fA96sPdoBCiY8tSifHxkuhdhSR/P5h58mHF9NEaRygEGwXRt1iuarbCr/6yS3Z2q5hK44Inh7/+pgB0B6TYBSg28bRn81N6Q5S8Yk1MXOZ0dw17JoQ0aC65I5lSgOa2V2Ctj3sywvmux9c67WMGdRgmYMPv//DWSybfKPJJ1DdX76kDqCEEbOb8u6yc27ZcqVBfPQdfI8XzIXY102c8xLgun67TBgf9wPfoUm2FSq9+HAxhXDQCz0sPjDd6yyQAHY7uAdWmAUqPh8cZ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(36756003)(1076003)(6636002)(83380400001)(6666004)(956004)(38100700001)(38350700001)(478600001)(2906002)(26005)(316002)(8936002)(7696005)(4326008)(66946007)(16526019)(86362001)(5660300002)(6486002)(2616005)(186003)(8676002)(66556008)(66476007)(52116002)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6RVbP4y/63MIb25L5hooFx60JC3SHiGYPQtAdRt61xVbksdQwHktpLlbhbMT?=
 =?us-ascii?Q?Y5DBXdu0SdMfmHoJT/wzxIhAGOhDAYb5x7eG3yF9TUIULTZwU7NLam/dGAbo?=
 =?us-ascii?Q?/nP0SgHSEcjRuFUoxkV+s55l80OfAuG8pk8lIvRMYiGhbX6RGkXSxma0K4jL?=
 =?us-ascii?Q?XTUKp672u0v/+GsBxA1QuTOLz3hXZ5aWZ9vOhuwjQIk954NIeXatvVwmTHtU?=
 =?us-ascii?Q?k4k7YfqQ/lzT807hkOockk0ErAQi8kGm6LsFloevj5xsDVRFxEjTqrWZaUtU?=
 =?us-ascii?Q?VrpdP5F3TTx18S8DuD1/p5YZIP9TByhAMIH58RSlRyZHH5MuyhNUGKn437TP?=
 =?us-ascii?Q?d8SH8riGDm7hv4/Py0QM/Vp7AfmpFt6bSfajc++jf/9UBRsAGrykRbbrL+Aw?=
 =?us-ascii?Q?3Pd8eBJAVRV28PoYSlT4Wejp2Ne8xcVQCg1lMdqEctkVsmCm+Iu0828JqgvR?=
 =?us-ascii?Q?QdbH7IUJG4R59M5jv2WZMzNMj9tIlh8v2Qi8JwJSMbnfoVDDj0gX+kfW59v/?=
 =?us-ascii?Q?V5u1WGDoaFUc+BOSiMRnYanwTc0SvZ4pJq1YzIsjfLedeD8IMvCL6g047aNO?=
 =?us-ascii?Q?GA5JBYMGQVF3GvSwurqCFwnhIokbIqU37rxfhCI6C98ej8lXZEPJ88UPw41+?=
 =?us-ascii?Q?JtnUiFCTXBI8BNgK/d9qruSmAQQIQnTGj7DQtzjL0CbARCc1YpICfe0FLR/a?=
 =?us-ascii?Q?2HgH/Eot4SzzTx2sklaTHGBMqsc/eKkdPY4dOJcJAqhNy/mbi7J8QV2JlKEo?=
 =?us-ascii?Q?/k/kV4zjJtjnofHh1pIIeIT+9i6PGRtukDokxPqNriOAqv8K1P9semub9muS?=
 =?us-ascii?Q?2K3LThx23Xj6hd+CPvoT2RL4jhT+Qp7ng3556xCfJ/aLGkr5UIEeweguPrlQ?=
 =?us-ascii?Q?fdZ9eP9xOu/nBmaU8ToCae46KiiXaxWFeinmNgO/TST+xyK5oQD0tDEbnaJJ?=
 =?us-ascii?Q?fXPkHUGqjRD/7NcTZqe9uYpFQe2QkGCsXzyEUZ8E4pv66Mo6KN0A8R0LdcKD?=
 =?us-ascii?Q?Yd8iYnrtuIEtT1oo0wim2UimYichWOUmhdovMwWhR+yMqwS2nPuX6dXVjHHR?=
 =?us-ascii?Q?Z1q2ziY4x6rWaH0NFqS4xJ+mkbkxa9cs6HvuEuYsoEP2GOkai6OJNNG49Pvk?=
 =?us-ascii?Q?KfYG4PmKhSGJnqrpN+9h2qfLzZZonWCfoB8QszfNWvDqzII6Qqe7erAMwvqc?=
 =?us-ascii?Q?3dhMNioWmbsKjgWYnzbwdcsYC3Y++l+Eu7BCI0ZV0ctBzeN8LIZWRRtcqhKP?=
 =?us-ascii?Q?oznGJW5bkm+V6JPiaJvoR5d0/aSFuG/uM/S+5Euhem5rFWcxghtKMFGQlbII?=
 =?us-ascii?Q?Nwqpvj50bpK3/uCN7DOzOMnG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feb7bce-b67d-4678-f6a1-08d8f8cdcdfa
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 07:30:08.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBTIO3yYc9zpblZz8XIhc3GN0HQWGWgrA+4DpBO8YO6eWL1Z5va39UbrTqFrAp+Rt6S/bee1QMqIgFy5OqAdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4682
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to add amdgpu_sriov_fullaccess judgement as gfx_v10_rlcg_wreg
when doing gfx_v9_0_rlcg_wreg.
Or it will cause modprobe issue as below:
kernel: [   59.992843] amdgpu: timeout: rlcg program reg:0x02984 failed!

Fix for patch:
drm/amdgpu: indirect register access for nv12 sriov

Change-Id: I971804e4e8dbd83e4179beefa8ae8a06bd52913b
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2111e4c46a52..06811a1f4625 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -734,7 +734,7 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
-void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 {
 	static void *scratch_reg0;
 	static void *scratch_reg1;
@@ -787,6 +787,20 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
 
 }
 
+static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag)
+{
+	if (amdgpu_sriov_fullaccess(adev)) {
+		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
+
+		return;
+	}
+
+	if (flag & AMDGPU_REGS_NO_KIQ)
+		WREG32_NO_KIQ(offset, v);
+	else
+		WREG32(offset, v);
+}
+
 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
 #define VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041
 #define RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

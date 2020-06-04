Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98AEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1B3207D0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aEI+yy4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1B3207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2C06E171;
	Thu,  4 Jun 2020 04:47:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB2F6E171
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PojRQYoqir0pltyNyX7YTjL2Rpz4ZFwCk9N11XmXQDDLLuibCu70zUkzAxVCv1OUO7dMwPQaNawiE0QisOOaCA5Obd7sf9kI99s8/0cBobxE8ZmSOJdEw7DAue4MEnL6YbhUC8YqGkwBW1eWN4zN+G78CedPhWE4Ten1zuG+g/T0c37hgADhdzHr0ee3qtuIQCawlKk7zfydsrPJI4433bKWMvtJpdObWBtLWwAcsK90KSlbX1uJXrc22qmqSmRf9rWA4nWzg5LD8SIgyOWJXgfcMfZItVvkqN+UA7wHCcJEm3Ly5ElHzMZmyGNQJpt5/GxgK5AffIELUl87YM7k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQIKQ7RxsBZNbgVe0czOKVQUnlu4+sWbrB0ZccXkCww=;
 b=TS8djeemJlOBCS0jTI+1igI6LBb3q5pyzDwM9YL0WM4/75RF4Yy4kegQcCxVrURgeFCOJRcb1aqNgwtaUkhJnTxhqEz3vF+jbqwoFW3VgkxX+mPXu2h+nXL3Pvx1JxaO8e6hxi/N1XmXqwIae06Mopaz19esF5WFizgzfR7xmWFCKJLKGz2n5W7Ubq67+evu5i/ifBlSqmj2PCyPsOPex3azKMBiXG95L29NjfBQJWFMLkbhdF7p3auwN5lSijkD5kHYTE7f0gAOPV/kYNwQb8AhhoL6dl/20B0D8YIO9s5jDVlBLHeARdz9fOgpg8yE/HCcnx1j+aBvKXl2+Fq3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQIKQ7RxsBZNbgVe0czOKVQUnlu4+sWbrB0ZccXkCww=;
 b=aEI+yy4G56f5umOZ9v2h+f/rnPflJVfgo7qb0khudndDptQuVq2LNlA/Cl4pT3iShQub+BdNP46sou6MjhpAvAagrVcPG0r80XGzHC+zp61tJ9amYH7BhwnsTv4nfgTaac6WW+tslGTWN8EhT2uGCsMODqHdF7kqPJsEkth2pS8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/16] drm/amd/powerplay: max code sharing between .hw_fini
 and .suspend
Date: Thu,  4 Jun 2020 12:46:16 +0800
Message-Id: <20200604044619.18658-13-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:13 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bda4021d-96b4-4482-20d0-08d808425a46
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32123A00F4904CBB9A9D0104E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:20;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R92eWBidEaLYQfuedeqOeERF0SxwJCQlgsB1AeGRKn5yWRJ/KtjY335+UtY58vkA2l8Er1ygu4uxWhN3v00NF+O19aBwq1P+ln4VHhAo7MfXCBq9gC/LXYgYIa8vE36jzd1evXpQ99msXrRRZVhUXBJDP9u9pip8Y/BT793XRGaVPCb17MhonqKzvvL82yLzVJdBcuh1aJj/+lkCbzZ5pjNBOzmKkMVT5Q8D8QyT5Fy41s9Ww7Ywiyhi9Azla2/a3iRPIAnhQgDdV/XR4uWa7UmZ9rTWCHuuDstkGAqXYIWQaM05dS0j8aM58wMLw8O2VbOjhs03LmQ55zH3uSVEEy2MZrsb8aMrSHX6pETeQR/b9iLgb0TTRqm7s6/Zlwpk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CU0EQx0R/un6lIkCQPHg/q20/El9RWCMEL+VejsEoKF1/0eQ5YFNkUzXMVWRhU9HF+z5T8UhDf/HxI70RhK6mJevCJh1w5A5ut4ywMp1yyWJ+P1Orhu8+i4kh4mDu8Ek604ZAyfy4AekEzozX1eh3STSwejrTGVSHtrZ5u94CvkK7qJMi2a/gJjNPflznhHk17QIws9pau62Ml0YDvaPk0OYWpTiiAzsPsJOUcmjRJ8bB/G9Vy62M0+KZFFGmM6UKfpalGkMIDRL3zdES0Ej5fVtg4fKLL/7NFf0DRYmUBb8l3mENYfnNk/z1K2Tu1xR0ZnkgQuCkvLrEMiG2VNqPCP1STyunbO63BAYpaUBVkKYLQ22hVAStMcn6BYvx4xmVVwt3vyhR56uHzokC2nFeN734G6hW4beEtBVSXly4OmZ5SS4oZGKd/QH3EClD80seB9IVdeI9hx8FPkXb+YuHMH64ZH3UPOIN9JjmRQN5kytBpRd1rS91KC8++0GZB1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda4021d-96b4-4482-20d0-08d808425a46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:14.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p28jGfJ3DqAYq9HoZ+ooO1pnrC0rBY9wY7hUqBCvrOSkQiXelE89er7Wg5zvU5f5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Thus redundant code can be dropped.

Change-Id: I672f84ed5856da53b7f8f915b2f24ca11cd4b228
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 44 +++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55ffbf1cf086..65f5edcaa405 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1376,6 +1376,26 @@ static int smu_disable_dpms(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_internal_hw_cleanup(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
+	ret = smu_disable_thermal_alert(smu);
+	if (ret) {
+		pr_warn("Fail to stop thermal control!\n");
+		return ret;
+	}
+
+	ret = smu_disable_dpms(smu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1396,19 +1416,9 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-	ret = smu_disable_thermal_alert(smu);
-	if (ret) {
-		pr_warn("Fail to stop thermal control!\n");
-		return ret;
-	}
-
-	ret = smu_disable_dpms(smu);
-	if (ret) {
-		pr_warn("Fail to stop Dpms!\n");
+	ret = smu_internal_hw_cleanup(smu);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -1445,15 +1455,7 @@ static int smu_suspend(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-	ret = smu_disable_thermal_alert(smu);
-	if (ret) {
-		pr_warn("Fail to stop thermal control!\n");
-		return ret;
-	}
-
-	ret = smu_disable_dpms(smu);
+	ret = smu_internal_hw_cleanup(smu);
 	if (ret)
 		return ret;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

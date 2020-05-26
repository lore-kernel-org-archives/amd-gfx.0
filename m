Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE3C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B060E2068D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YKBb79Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060E2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7402A6E14B;
	Tue, 26 May 2020 10:06:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3391E6E144
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm5u/W+nmUQFvo2aIk0+eKd62cuDkLFuKZJDVivk4H96JiSclB8dJChaeffb6hTXdTAZPEsW29xmtxDZ8sWg9pq62oe2aXEVX71CqwR8E7bOTX1sdQmncYWlgdDcRCjGEzsOMvPTO1ROi0/GZBjIp4UDI40zDBRlSyGzwP0fo7I/PtF21U52gu6tl0jo0UU42CDaYcHID3M6ycMCy3fz7ywM8LzrR6eYzt26CeOY0MOmtxZHx5u0PgEZmAWzg9ese1qQGAMP+vuatVncuXzLKdrjIJg+xwSGkpb+nt+fZIJknOc1nFssfoX/ieK9kRt+isXjrtLBGXoc6CcSp+1hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiVRpUvZe51npEFAh5vrjB5pbpBt/RMnLiOGcbrF1w=;
 b=ABp1/971/eyV+RZ55lenHNmso2FQc3Kjy/8MYBuBF+hiWdvGtv3OBVsyUOrfWBHVseEjGBHKBRgzhKmup8xt5BVdM/tVg7UXJ/1Is5tr00kfU4t/3LqS5E0mrFbw6asIMPxwHYHlFtYnhUv7belIaOodHNmBKhhVYEgg2rTsmnCPrEp+r/6Os+UsKTzlQlnX/q6z0qDlNmkrl9r3WukWQYxRfG3ZBY1SpaLbkBLaqWvdCp+bkZGa/l0BKMStjRZcBZN4VrHKe7kVs29NZLR8H2vODXLZXzhaKniME30GYlNlTktovuRtu4g/BUt7KvDkZQaEp5KMR2U5EVv+HR3FWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiVRpUvZe51npEFAh5vrjB5pbpBt/RMnLiOGcbrF1w=;
 b=YKBb79Rv02qrSM38loreMsoI0v000MgRrDX7Ddp1UvPYxNGr9vvZQuCp4b7dateTubBFYmFSa5MU4lnGq9QNvdyqT5b46bNpmuPEimrJNMpbcYkk+bYnQJNB7TrHDJi8aFANh99g+ibm37n1quPQzacua0fTNuD1CwqrTvC7UGY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 10:06:03 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:06:03 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: add check before i2c_add_adapter
Date: Tue, 26 May 2020 18:05:43 +0800
Message-Id: <20200526100543.5844-4-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 10:06:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ace5122b-354f-4d15-4e1b-08d8015c65b5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3958BCD9CF99B16FCBE9AE028CB00@CH2PR12MB3958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCuNrW5X5bH+0fBAf0wk2pLXV9TUIIaSwfgzj9aLVd4NnpC1LHWe6ReAj+5MwDK3DAZF58aWRs8niD0ta+hd5PmuWcWXt+wxGWvVYWjfzMFf9GCLoNVkJR6kzT+fYpOqB1LdfMSKmIPfSfnEJzL8o4cVrh1bpUo3FQUomEov/yguo/UtnRDcGyUJfqoTUuWvVsdpJxDevC6xiQ9g9qSsWHXOkV2LmxfsvRakvIcwOwRbrFlpusz3WdDFyMLWvxkqEO1OLxuA8CJpH6LKJjdE8F7FEwlLKdbLK5i8MHXEZlbtoBMHvBrXStYPqqQ3V/OcnzMdw43Klj+rDCiThEHwcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(36756003)(16526019)(186003)(2906002)(5660300002)(86362001)(8936002)(8676002)(6916009)(2616005)(316002)(4326008)(956004)(26005)(66946007)(54906003)(7696005)(478600001)(6666004)(1076003)(6486002)(66556008)(66476007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XlU3euHAkyvpA5YTBfCUg6jhvn5NB8eqjF6fOAm4LuoRlvlxJD4k9amf2IIXIXgF3t6i5RXlW6gYzp9YR4jZNkLbkWluM+uuxlFXqNLN9icSknXP4N09iuQO53FiENv59ujoyZhCUAmCijTUf8cPVKqDlof08UN7FukKJWtGTEaS9dSb+RukIoieD6HyErDNaM383jIqChkeGWy1GpRDi6VKMaG5HRzR4MQWW78A3F7+mPtpCO4pFN1cZOHfyI8LBFAUD/rvdcOY6dVG/ab8izV5dpFs9AMMLWm9X/B28hq+6HgKy490qWfBhFTo4hoNPqcws9RY4KEiBqDn2u2wJwPA4ngjMF97R3ofuvMR99u4/rsl/B3E3VYobGCcH+PIRIFQaJPlMQXOqeE1/TY9DgOH7bo2fZoHgsZ1YIZLbOZgHFC2fqpLsmFtaUfckkh+4dUyeTb77rueZHriTAvHG1pmkAsdlg8ipiT9oR7LFvs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace5122b-354f-4d15-4e1b-08d8015c65b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 10:06:03.0035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7ZmEIFIVGud2rQNXV09Rqq6DkUL1LKKH2mg499vv3iwE5soEUVIsqSUyyxG1l7ZmeuzRWiBoyF9ydLUwHOUeg==
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

smu_i2c_eeprom_init may be invoked twice or more
under sroiv mode, while we don't want to add check
if (!amdgpu_sriov_vf) before we invoke smu_i2c_eeprom_init/fini
each time, so we check if i2c adapter is already added
before we invoke i2c_add_adapter

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Change-Id: I3500ff474e0f04ea6bd4f9adf9f97b159443dfd9
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 24 +++++++-------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 ++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 1e9be1dcc62b..8ce907280dc9 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1354,11 +1354,9 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-		if (ret)
-			goto failed;
-	}
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		goto failed;
 
 	adev->pm.dpm_enabled = true;
 
@@ -1396,9 +1394,7 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-	}
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
 	ret = smu_stop_thermal_control(smu);
 	if (ret) {
@@ -1539,9 +1535,7 @@ static int smu_suspend(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-	}
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
 	ret = smu_disable_dpm(smu);
 	if (ret)
@@ -1586,11 +1580,9 @@ static int smu_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-		if (ret)
-			goto failed;
-	}
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		goto failed;
 
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 70cc1c12f196..437f8a317838 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2224,11 +2224,22 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
 	.functionality = arcturus_i2c_eeprom_i2c_func,
 };
 
+static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	return control->dev.parent == &adev->pdev->dev ? true : false;
+}
+
 static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
+	/* smu_i2c_eeprom_init may be called twice in sriov */
+	if (arcturus_i2c_adapter_is_added(control))
+		return 0;
+
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2244,6 +2255,9 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 
 static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
+	if (!arcturus_i2c_adapter_is_added(control))
+		return;
+
 	i2c_del_adapter(control);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

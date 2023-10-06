Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD7AE92FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 05:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE05410E0D6;
	Fri,  6 Oct 2023 05:22:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0FF10E1F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 05:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+qo/8oXbXwcnnBC43ld5tit5bukQHGbiHhbjGtW57roGHlfJgSjTEWW/Fron0bwFGh2jWAgIoHjAoGCzr47uY/U3U0d7ixfyZMuGp3P5Na9o8TSBDjIkeVfeyonOGqQksYVqxsYKl4onjF7m2fJT0vDR6J9gvvww0A2NK6uTDJRlLOBo4Bd9BOnQzm4moysTQnK2B0VWbs8cbkTa4opEuOw9liuXUSYQ1916m9p8x9e5WQOZ1FFH0rtRQB1QWw0m9cFZkIMTVYKf0HRzdvFQHxeVepYOZ2kjfnYELv1MDMoQSJXF3Sn4RvRVKSqTDgPwTU57/v1/ROCcr163kO/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy7xwzVlW+X877hMpJ/IzEYJZmjsdhXgT70njYgcjww=;
 b=nDDIFMJPWtMNimMOYLhqpy+HLx2d3AtO/87vVLD6hDVjFV1rzSDr56qd+x7DBFzC61o//5jRASZqMGdY79A/+EViMeMh+FyVWC8hng50tp1iU2GYnxjOlb9k5Lyt5MaEpcJrf86OdbV2BhGK7MHVSbzFgVUgDsnEZBBCm6VnVJMjSO6/3f+fUtco71Ll8Yx0KsfyjOHxlg9gryXtovIYJhGNo0QWNj2glwRkF3u4BR6kt6sfoCY3wJcx1AJwLFzmYAhgRWLSNfUlUFlHXaT4+2zK+/zgne0aofZsxeQuJ1r995Bj3/f/8noCJrrJDjmLamh4DTtP3tYxP/pQGWmWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy7xwzVlW+X877hMpJ/IzEYJZmjsdhXgT70njYgcjww=;
 b=Gg6oA/SttSjz8hw+aAJcUI5E0aS/Vjj8AdpteOSMfJcKdriAzQsWWy8OL4MONCHnqxRwbr5RzDB7/W2QtqTjH0JJtFzTR7dYDeHduhP216OTbHnyUjaSR8Azj4tPBOUN6MWle4KjIhAQki+LadAkrJp0NqlHJDNIkJRbGIk9dE0=
Received: from SN4PR0501CA0052.namprd05.prod.outlook.com
 (2603:10b6:803:41::29) by SJ0PR12MB6831.namprd12.prod.outlook.com
 (2603:10b6:a03:47d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 6 Oct
 2023 05:22:20 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::df) by SN4PR0501CA0052.outlook.office365.com
 (2603:10b6:803:41::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 05:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 05:22:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 00:22:16 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amd/pm: Add sysfs attribute to get pm log
Date: Fri, 6 Oct 2023 10:51:49 +0530
Message-ID: <20231006052149.1566154-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006052149.1566154-1-lijo.lazar@amd.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: a51e72f8-9dcc-4bbb-7620-08dbc62c3696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqS2WmnwiHpaA2sbhm3jvx1+u54oF7Ek4TFV0vTWyTf6p19cnbbr/0qqLOPdWPKVHHcVWXWA60GkWAtnMaSh+xeLoaUcSERBTwsudA2BKKR7ZdsvsV+tAP3sB2keVt3fVkSHpuYrKFHwLlQSU1QX1uONGGzWfesDB0c3oVZBams65mOnCcay1qVMMamGaY/IP5QmoY6JwMEJyUlPaKNSyAq5YASKL0VZfL53XrsQkuSqFoa1rmLlYZvqN3SdfGXgDzBroZ+4TK9aceFUlsN8BWuhtGKoa89cDHnySAPcGn/dCRXHyYCNXie+S8pJ8ZrZ7hmpyl/EsE3JonJPTWeEajgKFgm5jL1jDDJ24rZogcQmpi4RJ3E7JTVcFqVHJu74NFq+J6sxw/gKA8g/NfOMDmUJ9/rQxaoxXV5lmcIblcCPUIdezTkSlymkwrpG23L2Hmy2Nb8NmLI36PBTGYE/6IcYnXyLlD/OjRHGHfDbvPKUbFhCa/mE13cC6ebrX4JduczBMddi3NanXxUmVnhJB4aFVQ/13wcF9AgeGSolBwIU9eQ5JU2qQ77VFtuglKFLaXtkavR7oa+19zVqIJV7GyquSk/lgJxV1gwgBXWQWmz8UJV3eNTCpICkDLFj34luzt/4kN2Joe6sBQyK6zQcOG2Yy3mu3ekOBWRtOzrAWhVSzEc1ePGsRtcfdP8CWBVpfDSQkAqfTnDimyLrbeDOQ4ETjMD2+oejyXA4ZO2SgRsqY0yDjj1tW8ytBMEjyrXVO+sKMu2IzsXu9c5fBihPIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(44832011)(41300700001)(1076003)(6916009)(4326008)(26005)(36756003)(316002)(40480700001)(70586007)(83380400001)(54906003)(70206006)(6666004)(8676002)(40460700003)(2616005)(8936002)(81166007)(47076005)(16526019)(478600001)(426003)(336012)(356005)(36860700001)(82740400003)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:22:19.9123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51e72f8-9dcc-4bbb-7620-08dbc62c3696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add sysfs attribute to read power management log. A snapshot is
captured to the buffer when the attribute is read.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Pass PAGE_SIZE as the max size of input buffer

 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4c65a2fac028..5a1d21c52672 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1794,6 +1794,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 	return count;
 }
 
+static int amdgpu_pmlog_attr_update(struct amdgpu_device *adev,
+				    struct amdgpu_device_attr *attr,
+				    uint32_t mask,
+				    enum amdgpu_device_attr_states *states)
+{
+	if (amdgpu_dpm_get_pm_log(adev, NULL, 0) == -EOPNOTSUPP)
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
+static ssize_t amdgpu_get_pmlog(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	size = amdgpu_dpm_get_pm_log(adev, buf, PAGE_SIZE);
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return size;
+}
+
 /**
  * DOC: gpu_metrics
  *
@@ -2091,6 +2129,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pmlog,					ATTR_FLAG_BASIC,
+			      .attr_update = amdgpu_pmlog_attr_update),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-- 
2.25.1


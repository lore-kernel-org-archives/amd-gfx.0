Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B814C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 10:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8166510E381;
	Tue,  9 May 2023 10:22:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3916510E37C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 10:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfangCYYWooOS+oNcufOmK3eeHdTc0w3Zf2zbeRq6iJXFR9m1rNMdYLYE3SgFXtituor4Z7SppU99SIL61Mnx0TSDJw6FoxuIUXwX+9whHalO/6Ucmb/YN5F5uIAaJJ0odHKoAXDdRdvptcsOh7XoUtksEtUFI8+DNm8LG6EpNheYx6PzzAtshRcGIUhoW9KqGGkBVjuzZLxKU0Psn7zEx+CMPlNlD8e5jz29teK+2GsdkG0hUsIdWA/HtjjbWwTah2Ju5DyERJKtzFqV1jDW2+HKkAjLFCnBMWUd51EaWpmbi35QtsHadjAJIBQAlMk559GRhU6efp1ZD7mTAWl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDW6IlB+AUtDniYM86X2d9udxWiYotxz2H1+lGDTJLA=;
 b=n5Ppej0ann6D6qWBVaaDCUhDlfBOG6/cNszrdumcq0pIyTLwxENnZ7ApOK0QxSBEXzbx9D8tWX/JPx4sKbJTO5s05z6JUJryP52PaGJMnJCOyaP1K3hVKfSH+1ypFDQNkBvOw0Rwhd/EejkZpdwrUnTO5YG5WdP1eDq5lOjwodT5PYLRDNKOcX6pl7Y7WzdOANkrvtv9l78ymuhkfzt4hbX9klt9P5WezIESFgRJ9IzoLLSyqGBtjF64z6stJQOWLDHFOYR1ORuRS5RvHeT8aO+ae0A4Q7CSxZUgYZ2x4soFXo3hP0NIRRibFnExrfT+CKqs7DJcyxodHvajSo83Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDW6IlB+AUtDniYM86X2d9udxWiYotxz2H1+lGDTJLA=;
 b=iwbh59YUmfJRcebDyRIqiUNU1s6B3XBDMCNrfwCZX2T3dsKR+KmO0ZsptyEBrvP+4smd77Ioi9Qfpq+3hZ4FH+f/SB1mf2sAS+2O9TfR/2VE0KJI454OXwb4DmBTvni+8Ra4fTpg2wJO337aJkV5RBuQIF7KAap4aN+YAk7tfBk=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 10:22:51 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f4) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 10:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 10:22:51 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 05:22:49 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: set finished fence error if job timedout
Date: Tue, 9 May 2023 18:22:38 +0800
Message-ID: <20230509102239.2935744-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc266ea-13c6-434d-efcc-08db50775815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhMaPZP42lRcH9ERdcCnMCq6MNDQwmG4XJhGy9LLANaoIyk/C41BxSt8k0UYSb7vpGB2PK5pKwktOGL7mnHsEjM+EB38cvAiNjwvj4FFdBfM77M+Z+mlmqEb4qkkfiL7ebsVjBDjKehLqHwueEASu4iKFyyjB8+J/q2uzr8KyuWYYoVQuzRnQGxIx3otKgXVy63Lap/nHuWY0do6IFZodsQDpk6S05grLoA4BypR7gbHZTZubGf66NYWByLlSkn7UuY5OyVW9ju3FnWKs/YKjDHNYkoDwjrd8GsgNO4zzWv6QgmnL6YEb0Mj8v2n+cSLb7W50ZXbRFJKyQu1UZonZlzkoa4SgnNjm4XPMmxJDzCKP+fSZic29oB37iN4INAJB1TGW6klgI0NUEDt8l/giY2c/3JPls25XbBcfWdYOPry4zir6zFtvbSgkfa6DpYSoCsGUk3bgaGsRNdM9o2/ffMHo/ZaNqRcBsonA2R2ziiq4yJuk3UBAdCdXdZx4YSF9KMl1OUngjLD8RAoXDiJy89xqmCQ0ZWyLyd4XGr/PqbTAPzEsv43wAZZoUQBDpkxm/GI2DK55hZFpmcIcxQWHmFtjnwHApQ6M48evSELvTZG9onnMAyLH+xc0bHmRSC2MEjAGdOndKKtXxF/+ry96B47ZagUPxgID+Tw07qA/sGrzvN4D70epjMcBXc0PKKCkgbDkiI6fD5s0D+m3fs6SdWLd5vRlp8gT8hIoM4FiAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(426003)(36860700001)(47076005)(336012)(6916009)(41300700001)(4326008)(356005)(36756003)(81166007)(70586007)(8936002)(82740400003)(8676002)(316002)(478600001)(26005)(70206006)(7696005)(2616005)(40460700003)(86362001)(186003)(54906003)(40480700001)(16526019)(5660300002)(1076003)(2906002)(4744005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 10:22:51.1438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc266ea-13c6-434d-efcc-08db50775815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, jingwen.chen@amd.com, monk.liu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set finished fence to ETIME error if job timedout.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 57f8f8b3cd8a..f2c02e4167fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -65,6 +65,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
+	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
 		memset(&reset_context, 0, sizeof(reset_context));
-- 
2.35.1


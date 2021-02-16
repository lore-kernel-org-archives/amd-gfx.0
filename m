Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A0CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD8564E07
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD8564E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D586E422;
	Tue, 16 Feb 2021 14:40:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47E86E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 14:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4N9qkebpMSh5+hQ1gfTtUHMQUX/Vxc936YjDPHgIwvuOJ64CKF09JcNOPifZ6TnHKpPpGe9ilWCnuAIkQcvPB5l+9juyfdwIJ0II9daGfdsecU14FA5AArG2SwCjhsRqxOaYvUsklP52IUIYUL4KZnZm3netIedZrRzkNulQKVTTMinXvmGPqq6FTU2ZsOOI3pqGZJ7bXnrY0hyD+8oLvqnww8JF0BpzUCEXY4SWos2TC/vWvkOGUSInpf+xLQp7iGrYzvH3pj6UtgukF7lYFJRJonKv8oSGuYqJN2CdxeYX85FTALrK4I9+GPkcay53V3TA5WbyV6jiAGCrXOqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/hFxqrhsy9PX8lAa3RXcf7FfpxjroTAGLYOQGFCAsQ=;
 b=MZaTd4MeGGRZCIo0NUHGhJSE2XFSuS5DrlK2tnu2bSglak8nJae+wsCpZLfH4JzoQG68FEl61VnhvS+xyLP+8S7I2uF9GNg6BcHWQuBl6wQGfToE8MC6eo3RRp6d5vHfdE7zq3y7tdgvmfgvfiJBv9g+PWd6aT4Q8YnOh+Ii9nIrJ9tGlWiUf2hD93iN2i19dn6hi+TzdECT3nDwd33YyHUCfv7evGXWYofkIgdxmmXccJ+cfUOE7w5ZgpGO6Uy2pwFacEAjEb0qxZk4ns9pLlHN/Wu3oRfDEN6UMrRRTGmnHRcK6+G8mo68XYjJ1Y7nrDSwac3jdiDtWry3JowOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/hFxqrhsy9PX8lAa3RXcf7FfpxjroTAGLYOQGFCAsQ=;
 b=uuwcw14HezuX27+XqREj2mU/ceiNE+3WrSo4DT5i32Tjj3sfYMEvqLPodj3O7VTsWub8o3Po43Buqs/Z9V0nkN5jILDdeOt1nhN+jhGa31EG5BBQe8DhgUi5wqeKyBuZguc5ILszl77KC2jqDcck+YusiEDagQ1E9NEqHWLwH3s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 16 Feb
 2021 14:40:07 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 14:40:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: mark local function as static
Date: Tue, 16 Feb 2021 15:39:46 +0100
Message-Id: <20210216143946.38861-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.63.179]
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.63.179) by
 AM0PR02CA0202.eurprd02.prod.outlook.com (2603:10a6:20b:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26 via Frontend Transport; Tue, 16 Feb 2021 14:40:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4bb9412-e7ef-4d6f-c1fd-08d8d288c132
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915679200E0A9812D9B1E388B879@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXCyDQvET9prgkwJC4YBdV5RpliAr5E8UES+t51OhpuUBmX450Ni1Mdw243/3BDB5P6QnVGGS7RMm/GwaoOL2K0pJHTEQeaJTM3MjZUXIddctb2FkS9dubDyqYWw/BaFOmsM7fDRtEW9kLJ+sjCVWrq0qBqOau4hiw94fMPJuVtLMaVqinjKUdebMnxv2KmLOds4jvVL7dmQltBxlAKiEuxyFuc84mNG1yade767q4sKik4d2mu0ydJrv2AnLUifJTwCUjhdb4eh5+rc7k0bqEwnR1In2nuT9+Idg3ZzOryW/av0Ttxb/2MHzEb45rPF7cKsFfeTl1WhBYEtWISxuoVn/kM10Lb+DogWE+gnCAZ0wv+0F4219fczq5lek3cGT8Q8E9UG2F8oVnwuN3GVkNKPTgfp2gnoK3Xs84wR67VE2bafos+rp4NoynbXYbAFXjzBm0vyfl7hqbdy8udC1GJtexATLnIzN5+WCwd+Qw86eO7xQi9yYTMNuD6r+zlAFFbNu1RR4wkYxW62M3ZXXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(8676002)(52116002)(6636002)(86362001)(8936002)(16526019)(6486002)(54906003)(6506007)(6512007)(186003)(37006003)(83380400001)(2616005)(44832011)(66556008)(66946007)(66476007)(26005)(956004)(34206002)(316002)(36756003)(4326008)(5660300002)(6666004)(478600001)(1076003)(4744005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E15EfgUzhOFkoOu8Lq6P8HWrM97Hqk5yX+WH3bcR5YFjCDeC0omtJCXmFN2O?=
 =?us-ascii?Q?0PBIYIDgpcdS8imckRAbvBv5JAFDoUgd+lrFB4gBtKhh7TKH7bIOyYD/fCMS?=
 =?us-ascii?Q?B/C5raaueJY6I0PS1xhZ8HKIkIkFZwolcoC6PmfETx184bSMvsJAsVIWKgiw?=
 =?us-ascii?Q?MVFDig9oliAZlB+v+qmtkACvp/6jcj5MxJZ2ER+3RzaAYF35C3tDkKbxVUKA?=
 =?us-ascii?Q?Mig9lhC9gMoZm73y89R2LkcexfE/QTEx/7dtmlz/ZffKYtL8Nu+TfV//hscS?=
 =?us-ascii?Q?U25PNqiMtDqdeQEv/jtLGuo4D/r6V5aXIWbjcPD3URWGYsfLjBHb/0IZumJB?=
 =?us-ascii?Q?BqAZmXbUms4dFO8HIuVHQ8RjsJTlZhC074ZtT2/BgO+thniQuG/9zShB0hQx?=
 =?us-ascii?Q?yg1kXTUMk0/yreTOy/vf4bZYWZTHgVuM1S2DrZ13y8JYDqmcrYfB099g7RuK?=
 =?us-ascii?Q?QFVfJQDh5HPx1GwMkdpTUrG+AqFZO+zTJHh6iQGw85SCfbbQ1MxBag3TjGUW?=
 =?us-ascii?Q?UJ0+jxPZfEmkxl6ofgGN4yvpnjgyqUghgJ4R7DjghsCFrvKfTHm7cV1Vjbnw?=
 =?us-ascii?Q?FAOMUHQHP1ASJbmBFMRnTE6hmM9voWpxS+Pfl+pMHloDInJ19K5gRX2sPyhb?=
 =?us-ascii?Q?fQM/dTQTz/SfElus5UVVMEf11CuEsGKkP2AyrzsVBtTkZtsIK0xF7t/UDdVp?=
 =?us-ascii?Q?DO8efF5WJysRtT9SnObQbiDn9wUb1gzwXX8YYbkO+mxfGB/rSWmIy4NveM2A?=
 =?us-ascii?Q?06jZbxHejM/GQhebqhZZXUaO49Cxdwv/2cPkLhf76wZ0Ew6SF3m6iN4Worh4?=
 =?us-ascii?Q?mM8WvRP/Sm0YqBKqFNSOl139v5P1wdFLmV6rMkvHOOl2+9B2sjpUBkWSvrmf?=
 =?us-ascii?Q?Ox/24ZELhLzG9vPtKUbFNYLik/a5L1P2RE/dJPD2BXmI4IfTEWLjuwTzzaX8?=
 =?us-ascii?Q?tqpKjlaimVLkXPrRGbpisHMTtLQaUMOzIAK7xT/acdj64c8+/y2ObkUy1dGQ?=
 =?us-ascii?Q?4D2LczS7ljoXXXAGIOz3/OfEjnN/eIoAfoD6wLRRbA30TVPkPVozJvUClJQ5?=
 =?us-ascii?Q?AnWPHBzI7hkB4vb8SY00b///5h7HSPL54eoVyC+eYzxYm5vDM2hFaTTDTnwU?=
 =?us-ascii?Q?em6yvZLuPYKuio10UctOFXz6sTe49/bPUBjsMMKg+wgFhhYcsPQv78JoaGVq?=
 =?us-ascii?Q?lNS2bTfLZ4EqpSKx03KSr7hHFhiH5Am0ntMTIr0nyP88TQP2YF/dfon+coIW?=
 =?us-ascii?Q?hqLGLZ5N8cEYTNftnxi5Y5pG1AWs/h6D4HzLP+2z+5U7cx52dwpq/JHq6mNk?=
 =?us-ascii?Q?DBILiAzYDDIydoPie9ziydSb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bb9412-e7ef-4d6f-c1fd-08d8d288c132
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 14:40:07.5687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6YzpzHUQrCxT5LOTaFgGFPn5Dh1bLQqGVG/FQjcuTmia5++A6dl4eZT+ped7BPiQtrG095DYR/hmxLVrHu18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mark amdgpu_ras_debugfs_create_ctrl_node() as static.

Fixes: 0ec7b4385 ("drm/amdgpu: do not keep debugfs dentry")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b504914519ce..93699ea4860c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1137,7 +1137,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
  *
  */
 /* debugfs begin */
-struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
+static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct dentry *dir;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

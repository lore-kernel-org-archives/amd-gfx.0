Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05512C433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 04:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C102223C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 04:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U+wWdeqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C102223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10DC6EC21;
	Fri,  9 Oct 2020 04:47:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42B46EC21
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 04:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbPDbWbNcrfZ3oJO/+5noxx4j7H1d2Q7evDDlj9AerS78v6gsRmgcU4aVowPyc37n9DYlEdUQdhjSkqmkOj/ARMPWpTUKmxT8W3dYLHJ5A6BFsnFYM4Me4W5nMgqjpHCn1Yw5vK54zJI6cQ7CiJlR+mQP6xwEPmMN0w5roWGX6cgZgSJAImkwW7a1xg0Ns6tKP8lB1cl5Kn5/AqfWX7oXWhQwV5aB1QBjz05pTNv33V3qjrJL4MSGTrrVe6H3rp9kF+MUieXXCyx2WLAo676A9H0ecxxD7zQCSwV7XDh+nQSijsCVrR9MBNwo92ipZhHr0tbNfoOD/FfDHyUmQEV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMcrVcSTh6S+7AxOSfHWprGRiATKyw2YQYEvho5XQG0=;
 b=li/PC36lBhTuZFK9mOBjNlMTKWnSkrxlUuuTGbGxI+p2EN7PMlO3IQVFAs8wo/YeEw9BM77nWB0w7fb7HlIJs23uf76w+Z4PUJAgD5pzDdTQGEuGWxQACC4QxKdIK1jyPjck3BGQy7id7qdrtAudUNXhLzlWC6t0n5PEym6BXOxWdNQlJHk8HD33OZ8ENi0CGFJRT6ZNda9DDD4E7PwRuZPWbbzd7Xm/P26EnRDn7VOWZPxYV87aeuBzu8WI24XX38hBNrT/B91PGvfhz0E4tFoNqwqSSVE9IYyDTX4yHFmXOb9baKf/62exekIZE0qVD+YVznFb8+EEDQMrYpr6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMcrVcSTh6S+7AxOSfHWprGRiATKyw2YQYEvho5XQG0=;
 b=U+wWdeqZN/vStljkAYgq5z4JdngUz2oQIa+GsPTBNa6ejteDykW5gn2Qp4Et9miw8KVBd8lgXUbGbHKoe5k0EfjkTw7egMC5IPY0XfD7eZfOrDtRW/OImINi6s8Prrxh0ARlV4Lylw4K4bzq8Z1M87ba/Muf/Td+82Q40GqrnNk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 04:47:18 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::3db7:e64:58eb:82f6%4]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 04:47:18 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com
Subject: [PATCH] drm/amdgpu: modify cp_flags to pg_flags in
 gfx_v10_cntl_power_gating
Date: Fri,  9 Oct 2020 12:46:52 +0800
Message-Id: <20201009044652.10149-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0143.apcprd02.prod.outlook.com (2603:1096:202:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 04:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 855abac6-4506-477f-40f3-08d86c0e6667
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513650C65F95B60677D4115FD080@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYmJ7MFSDE95kvcAkj5cHgJpmyV/G751mLYT2CV+pqbZg3NGcIHIbXh6rRM/hU7FByeaMcjXDFEf+5dBx8eqWV1ogKRsu4CIKfGOOu9eKSYQe60uwDWB1Ad+u98QNGegUMpXrkeFG70KJQQd8MNH6MdsShtzagKzqFm+dRa9Ktgz2CP0E8Yz4n47W+2OXCcBIOvrRz56lt9dVDt/NowmLyCQB3ZDZmTrmsr6JyNcWxThx9Mkr3WbgABDs9dYfi7A2dXngo0RtyBjAt+uYsH6V0IE0Jqgr73Z9dTw0NNlWcTH9+RDUoen1/km1cJNlrZrPQygj83mjDrnxwUB7QzG+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(956004)(186003)(6486002)(26005)(6636002)(66946007)(66556008)(2616005)(36756003)(8936002)(16526019)(4326008)(66476007)(316002)(478600001)(6666004)(4744005)(86362001)(8676002)(83380400001)(52116002)(1076003)(5660300002)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x02PSYGazrCn7EQyCuPRGejUh2W3Qie9HI1ObwLXj0aLUcF/ZpZkzUjMZ27rOXXL4U9vKO3yKrjZaH7wsLEir+OvN05W9suACcwIsuPL+qNTZ/AeVXGtHzBVFPHF2j9v6ETsoM5KFgeaerMk9nusLIYkNrGu8avBqAhxNNMJ1ApgEBpqOetEiDocsHC/QS0/npC5MMG2kYFCCprhMX5qKwr7YRE6FsvK4GXA4/FzvIGFbnumlkitRGRT+HxDDfDGJ4VUwRD9ICa+MLedAE/dwLxvR5lfX8KwfWLJlR+KNIYvBXABeVdG4pR1ijfdtdDyNDzcRAPU9pZla6suANUCaWXAShu7+VK+rRLruNjVrAbCIm+IaNJ0mA5v05h2CaX54pHaG8c28uHyDKrIHZWhr2ZnyJwnSH7acLgjtQIDvm/J+SfHRmY9qSeaYAaPkD1JX8l3JN1Mj/TnUfh8sKMj98UWZFpqZsNCmByoaN5BrL5mBdDMMUcgTjdDeRyeQ7ON7QQn4zwtr/hyLrygedWEYIx1cPuTEyM9QbYATDlx+ut94ah2wnYspfF/uWi3ucIRV2FgMtSzy8HMRGnscUs8LE1hZUXtdbG7E7UPPVXqXhq+43SNsC9ka+uLqXZ93PD6cnh6mpsCnfd43sw3hVGv/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855abac6-4506-477f-40f3-08d86c0e6667
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 04:47:18.0957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1zAXZkKoDFl4AwlalhAaj5vojQ8OSz7TNHYLb1+JEMPrzHlU36qqK6b5pZlzMnt7Fe/oN74Xq/SYRKZTs12Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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

It needs to use adev->pg_flags other than adev->cg_glags in
gfx_v10_cntl_power_gating

Change-Id: I5f64ee94d8e574293622aa5e496fe245fda17206
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9a8d3f7b7b15..32360023e8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7588,7 +7588,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 {
 	u32 data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
 
-	if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG))
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
 		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
 	else
 		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

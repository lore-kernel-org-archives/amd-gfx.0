Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8384F613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8384F613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9996E4D2;
	Fri, 21 May 2021 12:46:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAD76E4C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDjudnL4S6QRWIBJovBmexavMmsYY1XCZ0AJEnC49NfdTkhSLxvonoXmMnBb7k0nysVLt1MWC1CNFY+G2eOVgwDNi/bUSlC18XoF9XZtcsEGYablsiRNcQh2FS+v4VeeqJvlRgNrPnd++FJOllf6Au0wyaYze9yy4VD3CtJz8I5oXN1cp5KL1tXd8Gozpx//IGdwW6S7AMI9FOPL6dzIPCT0UII4WaWhnULB3bpSUhF9zSPIafXcq0xek+F9g36mUYg8KrZB464OxqyljXeH7pavnaBKM/4Wai99HISWE0Ful3my4hTTQipuNFlTzgs8QdMA9hE1lGz8D5rAd+t5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwifR1mQOBUEao2KHphiGWRd/wa2AEM//4GdPHYJLw=;
 b=GAt/roWPw+fpOTjIflNECM6hBwLXaiJDqAvVgEg2/fQPPeePfO7SLRZuXdxMe2v1ER6inAWsvQjADSHlKnl5fxUXjrfobu9KwQ5Fj9ywxBKV4qvlBVk5KG6Vd3OcyBDYAPUMitKtMa2N11Kude/tUHfVgYuEPNIg4vvV75FeV8YIpCpgp8t1FBi3lfSJtbfWCCwqhy7YrPIJa/C1mlnxeFA8l4htHBbmztPxfLAnesZsNp3QjyAoZzpcWUZzDS1BQx+rA+t3sQglZKxejc1d40lrZq5GlbR4mrfFUfnnE+jZCjs36uyTZB9/ZEosAyJI1cPaQCtituKK1yxJfr9/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwifR1mQOBUEao2KHphiGWRd/wa2AEM//4GdPHYJLw=;
 b=zO0/VtK4MePs8xgfpjpTLHxYhhX7NKEZVv9rNpv7qrMnFX/QJMtVtPynLo7aj1roYd5RoDL6syS3mRIUYrtF+4xM661D0FKgg02zV0+5RpB1mWjJYN5t2zVl1+XAHibOKAC+a3d3nORjBbn1PSwS7cdeVCJ6nyKuVd3d4ghWmJw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:57 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:57 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: create shadow bo directly
Date: Fri, 21 May 2021 14:45:30 +0200
Message-Id: <20210521124533.4380-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6fafe7e-311e-4f7b-6a3d-08d91c5660cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133A3408E14C3E5A135F7A98B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WF2InX8wHTbr1ltoUKpjNKzDtevjsHyhPrWDahiMNKm4OCKvfL6Gzd+sgFaq/hxr921BJQdeBbJO+S716nU5NoDt9y98R00/s4IxiTaUhHN2CDV0XAkrwnav1JveMdBwDUHuoHyGos2vWqC1acf+JHBbaGdQLGctZU4dt1NYyd0zWpim6o5A7uLzAx/vz+676iJI1rkl7ycbAX7LYcJyEG3ez2x0oB4mUeKjwEp00JV800KUS10v13l8PAaBVfbuhonrANrLXVsnDJSgEY4GwRSI3sh8LoZlbjr/z7HPlYzcJoeNXnMs2gaNIXdT91STqwj1HAijw6nwFlm/aEUR+0vhuhc3NUso9Xpo3aIiN4wBL7/A1vcBFu9nyVZ37GH+KhOj/IRKvmZibUQNHV5EtCYywB1hXshv2JmBP2BFbjQWOAfKd7fvroD7DVV8FcCr/mTP8Dj1XCxmSPzNVi3hIjOHXENK08+Ik6+yJ/0lsrpsil8cdxYv1RMdVy49nwq7sK4lOG0Psrcb3CVU80bEayx7j1l0Y3egTWdte+nAbN+i3W4P2VMiQphbzHnFM2xhMUZBLZ0hQWeDV9UJr7Lo6oPqqB4J6JyqHc1GtysyL+oHmBNJHSn76l3WQZ7ILn3wwKfQiFG6VNDX0QkJAL7PSPwlK1UxoOqGp8rhYlZy0B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3lKOnhwgNz7JagIXN3u1qZwK5wUspYrJ9A2FafWwDKTeNsW15rrWNdtsarYl?=
 =?us-ascii?Q?1I7tZTC40eUlE59jkWrUda5t7WAH41dcZsOZY/5rS1JHYbr+Jo2eSnTrSd2E?=
 =?us-ascii?Q?nhBHC71mLDqzyMLHlHGEDLtnOSPjlXG+pp5QQ5oDUj9SegZHdoPEIfZEcQPc?=
 =?us-ascii?Q?1hU93TJgLbw2xm4fuzX5/cf5p+ZO4dSC/r/kVSpeYBsI5gYxnfBHm5lFeHdE?=
 =?us-ascii?Q?IXv5lwiv9QTGD9bly/cXPn8qt9mf6LQqqxhqYUB++Dm38TQIzgouprQoHnLR?=
 =?us-ascii?Q?Ed2ivVS60e62et5pFLtwWT52KzIsaiFkl4KPvbr60D09cfDRe7UAY5D7qIB/?=
 =?us-ascii?Q?kAFw63MENRrttwCHVIcfXZLIUMUTCzTMq09cZFrCK6e08IFmKjvYBCN3jJE+?=
 =?us-ascii?Q?OtYx1AFtTtPR2Kxh4QKZuBBousp3WngbTRvqfIhgn1E1Hwzo2rqLjnozL89e?=
 =?us-ascii?Q?9GpyhzrdtQvB8OzzmY9+8l/C2jRzNl3kYNFqi8IYY7cbox+wXpm2u0OTqBlx?=
 =?us-ascii?Q?8Qpeoeco2jCJAKDl4zzIk2Er2rKXdR7ItdBHXH63P+w8tgURqVzoWBwThBm7?=
 =?us-ascii?Q?4CPmZlyM11hpwCEdB72Ib0lXtt5EZDP36ua1p31ANgLvrXoAMbbkCj1T9C2a?=
 =?us-ascii?Q?ensZbVgUIEoDNyzN9ZjcC1hQo6hTtsSiZQuYXWhYnyt8NartHb0fiOcvgrvn?=
 =?us-ascii?Q?uG1yFz+uG6fRvBYXuetqtlQhnNX6i1BrEeCy+w4Y7Yd3aODIruT//yT0WDpk?=
 =?us-ascii?Q?2bFpZ3f8R0qKeqq0uhYdotVhZuJeSHu05thF/pzN8DI02BUgegBQDmLewWdY?=
 =?us-ascii?Q?0T4+IpWeJ3BK8Gmkmx1fxgNEXFBmpxgPwhYQV1mm5R+UHUNk0MqnoA/2x2NF?=
 =?us-ascii?Q?YYM/U7UQ1bCAe8efTHx+LI+ASxQXrdb159xEXdlFHggE41eqIpKJnwJlSb1d?=
 =?us-ascii?Q?k31nOv3kyjcVKYZo2rLcoipZbJLfltSamYQGoz9ZOWWBqC4MA0WFSP4gCT92?=
 =?us-ascii?Q?XZhMnB+Jy5E+jwxJgZkN9dtjjwt4IgizDKARJHFXUI7E4Jbcsgze74V2Qwod?=
 =?us-ascii?Q?Bf0wqX7VFVPbAR/xmujKwFT0tUTVy680PFuxQLy0z1F+wpZPu0t+BVvEgRkM?=
 =?us-ascii?Q?ee0S3yRvq0coMHlYsfLyG7fdapRVBhbvul05U9qXjCiJxgrt7VFWqMh47yJ9?=
 =?us-ascii?Q?Ybz34iFQdJH8v4GR4JlBmIJX43lZdbiFJZ/la8/a3RYdgPZKepYoCnp61yOk?=
 =?us-ascii?Q?yjzchJb3JkovaEs4e3y22IbHmHdxQuEW7OuIaIPq+ab1GFKyS1zX01Im6hxd?=
 =?us-ascii?Q?mBsq5TAvxGFp4pziRIoQFSSa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fafe7e-311e-4f7b-6a3d-08d91c5660cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:56.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh7YaGwJgJL7Jp/iSDhvlSnRISMPKdvBWQKUIfw5DXzYNlOwSeUJlKUP6HEGk9R/GYtysgCEZ41w1dE8myQkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shadow BOs are only needed by VM code so create it
directly within vm code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1ac0293e5123..cead68181197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -867,6 +867,8 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo *shadow_bo;
+	struct dma_resv *resv;
 	int r;
 
 	memset(&bp, 0, sizeof(bp));
@@ -897,9 +899,19 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (!bp.resv)
 		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, bo);
+	resv = bp.resv;
+	memset(&bp, 0, sizeof(bp));
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	if (!bp.resv)
+	r = amdgpu_bo_create(adev, &bp, &shadow_bo);
+
+
+	if (!resv)
 		dma_resv_unlock(bo->tbo.base.resv);
 
 	if (r) {
@@ -907,6 +919,13 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 		return r;
 	}
 
+	shadow_bo->parent = amdgpu_bo_ref(bo);
+	bo->has_shadow = true;
+	mutex_lock(&adev->shadow_list_lock);
+	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
+	mutex_unlock(&adev->shadow_list_lock);
+	bo->shadow = shadow_bo;
+
 	return 0;
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

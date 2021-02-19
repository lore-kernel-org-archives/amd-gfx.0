Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D09C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5D564E44
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5D564E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8620D6E89F;
	Fri, 19 Feb 2021 01:20:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E267B6E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 01:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhCdfgB9Y5OlEuuVsRLAsMqcZd0/9+xbRsxmHbVhSE7ELjQ7trErFOeB6zTj4n13xA6Z7BsIoys/ZZ8A6f3TX2/xQhtUx719VicuGmwxGgLN2rpEL/Md/GlspT/5xQMToShx8GdZiJwF+FH2pzMg3oL5+Cc99qZvwyBgeNArGs1KQIRJpkz4Hme6rg9lm03KEk75du9GoI19z8rTjGaTbiEeKOwhiN3A2MsfOZmUEogFG0Uib6jcLfdeRM2k+AXBq9vt6EGN237F+2p97sy+TITl6SUICKoXodVmiV2EstDDXOlHQb8f3VDlpXkAzbAfRd2TcOQQQ3llDtuW+30pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQA4poi0nbCwVmhBV8X0tieS6HOZIHYZyFP1rd8ce2g=;
 b=O8rL5mduN9PsgbC98BNYHyyxVIhuoGrUffBnLMCdQKdW/dmzsN6ok1GTL5xHAyfBwcnEXm/5ub0GTfpImfhP3jOtkXUUTLsFbcH/NPk5SC4CcKH1j89PS9suEFUsYHyscV0m6AiJQiNLHV5DIHQi6dIebkDQtk6FILSyVyK0JhplzO8Y7mQ+MpzEQRXupH+m0AH/HSrl+L9IqJTqy2RkbGKfxVLbSn927vulZ/Rt2ErQ59Ggr5FqZtgDW88ORk6fjyPhAcrkgolZnlf/DXNNJj6Dgi2F8N8m1XAdjps15abuO5pRAVTiw2ioEDOdhQWDhBlK2F5WK+idHBlGDUXGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQA4poi0nbCwVmhBV8X0tieS6HOZIHYZyFP1rd8ce2g=;
 b=xEUF+QOWyIMIFqlikNmTFnizPM8j9eepv9VFtDMF8Te18S7n7SD6t4CifSE+pAmvXrYruwh/yiRmLiAa8FFlBrkfWHDtnq05Jkw/sXAoufFzVl96twIr+/Sq6nJwd5RZn8Gx23paWSUewDxSg7a487/2DRYb+y4C6xH3dattHvg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 19 Feb
 2021 01:20:06 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 01:20:06 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Init the cp MQD if it's not be initialized
 before
Date: Thu, 18 Feb 2021 20:19:54 -0500
Message-Id: <20210219011954.28566-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 01:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da1d296b-ad45-4a60-b79b-08d8d4747da7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB286028AD6203B40CB1E57B99F4849@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXlmLYTSNxUiAFi9AnuR6SUZH0jZW8at6ADxfirVOe9KdUqLjJZWmyP7S5KvUIQRXyhF/dshVDawM8sHuOW0RobeMOiIc8BKLLZk5YX2iG9yIEGlLkmyTL95jo9ZrhfDDxWz4U0osQ5rVPZrj5Ds1ntZXnDxIOn7O6fG6t1iZCF8+Lg7uzU+/WqZekug8yr8TbyoR6PbamHVxHyg9nScNIjVR6cSHZo0SK9PuItL0yPITGRwoTDhaZw+hsaXdzWX20gbfREuy53zmrpjgg1VvinHaVnAk4xLBz5Nq43mL0oDU8sspS9QvSWt6kAaq3hCMvRUHP2hmdkpc+75gUXQz0cRAQQc8+4QFaRt56G7ahhrIQP05grQ2vLB3i0iQ1pLq5j94GCIwRadOHafEX/HVf/GDx9BHypXTmowUmmI1U6zj1/5RgyjA4kZm7DQryQDdt85n/hREWVn0dzBrYMVdKPwHxc04m/jZrypXTP23NNYPXC7GcHjx4CdyjCdDHsMffl/Fh/0/Nn25lZIApSa7hEIvRFHZVNIEiEh+VRkAv0ddMZngu3UYMfBmQOIGeIP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(16526019)(478600001)(5660300002)(7696005)(66556008)(8676002)(6916009)(8936002)(6666004)(86362001)(4326008)(1076003)(186003)(52116002)(66946007)(66476007)(26005)(316002)(36756003)(2616005)(2906002)(83380400001)(6486002)(956004)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7Saw+G2tDX0CuEi49x9nzKR7Qp2gcgs4M7Cp1rmjOVEnfCtSW2nd6LVz1cw1?=
 =?us-ascii?Q?8gcUxIBhVpUg2dPJlQkEJsIw1RDcKEloUVy1xrwaG3YVRfCluui2FH0IuEGP?=
 =?us-ascii?Q?GD7Hy7MB1AwWrCB2inkj9iAgvO/DJkGQOrVt8ow9UGVIZLMeRTn4jA/Psre0?=
 =?us-ascii?Q?zxpXanndsezAHUXZ+XbfKSMP7XzmtFdnpU3srg8uw85JclPOZvlfH4m/ZnIO?=
 =?us-ascii?Q?ZCPqr3VBSCYVv+dz2LEEsDZY2a498oILVNVb38oS9uKLmaC9aCv0Oy0aG+Cy?=
 =?us-ascii?Q?c2JVXtbi7aFGiuXnbv5veLWqPL1v7rMac8RWtsgG/DEJT5ZTygvzZ/X18KOS?=
 =?us-ascii?Q?4i9RcxzJ9NxqSC2T0kVLEFwbjcZniCs9kQLkdKeq12pdQEDwKZd2VSFQEMUE?=
 =?us-ascii?Q?2vN+oaYx6rz+d7dtdFvp3aM3tiMC6E1lTwdliclJ8z+22/lwa6EryyChoqiW?=
 =?us-ascii?Q?OezQbwWIZXAbuk6e47L+7nEx7bgQIE2hVqsFw3OPxh6fusqWlZizhqiq6xGk?=
 =?us-ascii?Q?+yl21jwKWmcLJUGkGGL9mbvN8DXgNU6mJ5S9xbIBvyDSQW9i68GMWx0vnQWy?=
 =?us-ascii?Q?vJX0583Mi7ZHUY2YIDsp5f6urhUQol/q3CCs3x/ODQ7ikLoVoJ2G4ADszDbr?=
 =?us-ascii?Q?Pk9eHen+aXsZfK6EYxsKMwFXy5Ao9PGurjJVKzkTDd2lD47eYVzzweWXUjUK?=
 =?us-ascii?Q?X7q4ByYBI7/XI2fhXs16AKR/7zCzY3AZPYHbe+X8a9ZFdz3Czi1QO+NR6NLM?=
 =?us-ascii?Q?4PY8WRDTYaYIA8aEtuhHbSNJSYtCRFBN2RGb6pBjhoNv4toLUFYryuAtTaqj?=
 =?us-ascii?Q?lurfRyhDkKwCKnFkBKCIh7at6eBYVk1/X1v/4bGMxJ4K3OuLiZE5ZMQfXZNS?=
 =?us-ascii?Q?08bJI03WkGhNVnVvCYxEdFyuuc1pg7hvWEqssfu3cB4FFV/OQNaln7Y0ZQEF?=
 =?us-ascii?Q?8l8bWrNPj+eDvPHQ1FrN8IxADTUOR8wb5V7d6qIwBaU9KX5HjHNYo1cOVf87?=
 =?us-ascii?Q?SHrSb2W9aQdgWz3mDgfp9TdlxM1vtRm/cT1lD0X6TjdXZNVRi2K2kPsCi3LG?=
 =?us-ascii?Q?I3lzmVISySIL+M8cWpFHMHfYVJMdIJAzLPrfgEH1rxq/05rRbJhqpT5yuPHd?=
 =?us-ascii?Q?M+py9Mk6AQb6H7ol1MSh9R0e6ipL3O5B5gopuCCtA0IarZcCSUuCg77WpB3N?=
 =?us-ascii?Q?hEFAgquusWsdKauHcLO/REIAt86LgptVK4TagEFhvKy/P+TiH/OawHBnhFp8?=
 =?us-ascii?Q?r3eObzxCJ40FU/06YNuFL+2ylnpZqqtwDaMpKZZ+CGu0Vipe4j2ftk/y7biz?=
 =?us-ascii?Q?Q19V45IfzclpyInHFsy7oWgl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d296b-ad45-4a60-b79b-08d8d4747da7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 01:20:06.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCgip/rR8s2RzaCQY+v7S8Eo409YqH9q0FgIy+rO5pSfXSCLlT8VCTmxm5F1tSXex7UpkdHDrWatnxV3rh/bBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MQD might not be initialized duirng first init period if the device need to be reset
druing probe. Driver need to proper init them in gpu recovery period

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Iad58a050939af2afa46d1c74a90866c47ba9efd2
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 65db88bb6cbc..8fc2fd518a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3696,11 +3696,18 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
+	struct v9_mqd *tmp_mqd;
 
 	gfx_v9_0_kiq_setting(ring);
 
-	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	/* GPU could be in bad state during probe, driver trigger the reset
+	 * after load the SMU, in this case , the mqd is not be initialized.
+	 * driver need to re-init the mqd in this case.
+	 * check mqd->cp_hqd_pq_control since this value should not be 0
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
+		/* for GPU_RESET case , reset MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
 
@@ -3736,8 +3743,15 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+	struct v9_mqd *tmp_mqd;
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	/* Samw as above kiq init, driver need to re-init the mqd if mqd->cp_hqd_pq_control
+	 * is not be initialized before
+	 */
+	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+
+	if (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

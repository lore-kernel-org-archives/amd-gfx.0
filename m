Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C79C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5082250E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5082250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0526E45D;
	Mon, 21 Dec 2020 05:43:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F52F6E45D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 05:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY/WyHLJ0BPr0tZ/NCJ7VNZTP8VdwSjayUoI2jqiByFHOS1pg2AnEjrpCVMwxVo0qptU34j3q5+Djac061/9FgwBpgK0z/pzYy2DuWnr+3eKHG6d5Dd5iYp+1nMJKygfqvZ1qTxMted5lecGmpO/eOIxDrLImDUOi8XX7N0PxCyqFIGoFiIcCs+prFDFPZEpvznJTzBxdd75TFfy75h/mCqInhndtX4mtIhwDEpj/UG/ySZkwIkFbxSgxORhEJ3lZXMcbhoXLaBqJBWvjT8xmx61otx+CS+srYwURNmwJ9mO1uKxSPvysn9J+IvAfERnVCCNoVX3z8Xy/Oryhlzj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T6ehThcRv3nifBJPx6cFVLOjgfLup3UV1IiRPhBOXA=;
 b=QfFmum20Czf+kKL+nX2vESCvWAVV6NDKpTAUpm0aL+nDREwer0Og72ksgOP8+CBqhVVRn02VpV1HLpCH8TSIsUhhq2Pxjqi3e5seOi32Pr6VAjSSu2sasOQbjQxpdOhedLwklG073CfxOZArQPhQmm351r8LtCXxEicYoSTOhaWSnm/QHMrTOXpxMGyDZm/u8FEwZ45abUR1AD7tCs3jb1/K0hgwwccAbogWht4vrDq8p1v7cThRtd4LyWAn/6c/c3DdbkFnYxj+XxMcxVJPRgpJ7zromJvg+NSrpiOUnMl8cmUIBzv+bnceOWkQR68BE1ZpTtLgEkrFSNOA2CWk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T6ehThcRv3nifBJPx6cFVLOjgfLup3UV1IiRPhBOXA=;
 b=UlI0BQaG6OAZF2Aq/qc2lDRfWjUOuce8OqDvoP/t7H0sekncIDaSSK8/90nWGy/fmze24qRoIC2OMF4HtyBxGIRtdg37l1HUhEmaTv/yH4CJsB8Gf6R+fp2+nOcXvHkoo5Ld93imxAAyhffbv3y0yRx+kjskpr9Y/8FWJDiqZbc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 05:43:14 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 05:43:14 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Feifei Xu <Feifei.Xu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: de-initialize software ih ring
Date: Mon, 21 Dec 2020 13:42:44 +0800
Message-Id: <20201221054244.7421-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221054244.7421-1-Hawking.Zhang@amd.com>
References: <20201221054244.7421-1-Hawking.Zhang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR04CA0081.apcprd04.prod.outlook.com (2603:1096:202:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 05:43:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ff81914-86e7-40cb-6991-08d8a5734f23
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29869A2AEC7AC0F0D4298B8FFCC00@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHU7Nst3t9m/h6zhKITgXYzVsgG/3PTH7GyCqrD3KjFjFExp0JWbaBaychRj25gmqXh8TaEsAHK/6Vz/c1q+Ab430/oZisujNtuxH46ojY3w+28q/zyOJLYOmj64Jw47lCCv4bzybJsr3ZTEe+EtH4RmbGJh4hzD16ZOtSWXE2DrWVE01FP/ecznGDmpq9TysUitU3cZlLQyLZFcVYTfaRTW9pCYocMZdju/iX5mJTrlGf4Wzs7QV5TOL8rEEpOF4zI0//O+tHTSVbAMpUe8/Ai68TNXbi1AozpO5ZTDnT5N+gbHfmiJpyt49s3lNTRb7EilXZzDNlVDSfAGNn0QySGm/f95vnvzp/HCNcCo2piTJ5cbohtxJ0RAT2NCcxkn4KUpv4OGM1JpYLUeuLkftg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(2616005)(5660300002)(26005)(4326008)(6666004)(36756003)(7696005)(1076003)(6636002)(2906002)(8676002)(8936002)(16526019)(110136005)(86362001)(6486002)(316002)(52116002)(66946007)(66476007)(956004)(478600001)(66556008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SBYiunEjsl8Qxam/PTwtI9Wgqret3kUqJG83EFbTfsqfc92CyiQ9cefBGUO3?=
 =?us-ascii?Q?E3WWEh130OlXJv2+Z+0mNYqURKFc0nWd5PwFSL4iPflIdsYIpvpt8asi8uIS?=
 =?us-ascii?Q?Xemy7pdzU1GhEejxLH8tgqmiT8X5AAPLYpKNYvEUK0FXBGGuh/3nM+3trx32?=
 =?us-ascii?Q?KEY27+/QcrtecauGRzT/izy4kcj0XHGbzCSM0+lAkhr6wUt6UnjGTcsZl2gw?=
 =?us-ascii?Q?XTtQ2kvqQJniypZr3qNtQodQzeCq8hY9zQKNHqAgyCyhfX20ID85Qh7mUWiT?=
 =?us-ascii?Q?oQMbwQBruORiQS6pD0WtEVgGhyn4mrcvifcs/eLZmcDBbDwwSxGjOVdPIRGv?=
 =?us-ascii?Q?2GCIArG0luGYRrDocy+GmN9dchmfZVeJoErkJHBHGfgJwgblf+eGTunF7GWI?=
 =?us-ascii?Q?x1V2Ziz7D5JZYn2zR/W3mLMK5PAX+9uP2cJWW2u1hqZtUdVNtEWfbSH4+s+u?=
 =?us-ascii?Q?X8XAP2WSGGxLC8DFp8rCpAF9dVg2zNt8m4JRbi4L/BxJGt2qPxzvlHUbbgfd?=
 =?us-ascii?Q?6ndxBE/WnOh0PHbRgiUYT6kAAyjzjwtptkxcsC/KjWcXpP6agZod6umDpMuw?=
 =?us-ascii?Q?5J8P55yKwfi+z5nZ1ZytoCQxe6mcxVV0tOdJSwy5zXaHqAgkQ6Mdz02aitAL?=
 =?us-ascii?Q?XPAOrTKoorrHfHz/BKLw2M9zNbUJYKyzB++TVmupv15Y0YfR4aGjNrLeVfL9?=
 =?us-ascii?Q?6HGN6ShqH5ZN/B1/tU9kOfiNRjrnD85w/32ibL7Lel6CK1yHlBy39FC/mLGZ?=
 =?us-ascii?Q?85TRL9/eS9Wb6tUHxDQy7qqYEzMA89NPVKA4ZZUNCnlxs+qHBb3cjb53Wlug?=
 =?us-ascii?Q?vN9h7bjJKes4NpMtFQMIYkjHpajFdiIJHiBdcp5W5oZliVH4LjCow5ienma1?=
 =?us-ascii?Q?+gcybc3PPjA8hFwLWlKClqdHy236EMIHHuA0iUsHgWpMRR6YSbA6zxA1FSIW?=
 =?us-ascii?Q?y8O04BGCDa/5lE0f3UUn6kmgNNZJEg/5u34K+cXu/PAnPKTTbth5uzjM2Cyq?=
 =?us-ascii?Q?3oik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 05:43:13.8855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff81914-86e7-40cb-6991-08d8a5734f23
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeY0RHV8yXDDSK69zCoxQ5CxN0SmS5V1AapZT6eEyHaT5dm2paptDTXYZvTJDQ7WNm1lxTYwFXL1PkRWcRawUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tear down software ih ring and its state.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 04cc41b82661..060357625504 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -584,6 +584,7 @@ static int navi10_ih_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	amdgpu_irq_fini(adev);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1581113477cf..88626d83e07b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -524,6 +524,7 @@ static int vega10_ih_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	amdgpu_irq_fini(adev);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index a1d4d67d5ee1..5487262527aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -571,6 +571,7 @@ static int vega20_ih_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	amdgpu_irq_fini(adev);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

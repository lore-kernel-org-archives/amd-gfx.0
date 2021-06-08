Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA532C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B973961208
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 09:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973961208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDDD6EB72;
	Tue,  8 Jun 2021 09:32:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88E016EB70
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 09:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmIjMOBDB2S3XUijWbotoaEZCnWvy3IFDzeeoUQB4NyrMG3w8BA8mhgwiOu5DMljbAJPP7S/73DeZN+WmqokwhATJpxFDrZXQuwwwCrB4zy9N5J3CCCgLckjRyEA6UDqmr3Qsjq8VivpVS7LzZCqbX/zzaMUdS47pXBQcHK2jKh/X3hrYKQqIbdHP2utbdJElTItQqFP48Vxrxkn/CEA5aYzIzhYdDOtNvxM6CZXJ9wR31O3vgYCbjxRAflvUtDYdO7hZ5A4lPNfk39cO7cR+ZknYso0XpiyTIfxjNdj1C+KjOlezGie96pNwC4/Vn4DW2CgU4g1px310l2sX7mKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9LkTMeslTsEhmzLp9ruqB4Cj3J5ZELQ40A7DXvVFTU=;
 b=ntJJ9cqneQKXE89gh750jxjFe7z6o0hV9/hBESMN4K1/0y7rWB8m+vwc7GKofUYtJfl0CsEi4g5VpV8S2h2KmaKPVZcQ1A5piYo1SkzbRsLZq2PE+YvrGm/KFF3ND/SemOCXDBX2faC8XtvePXC6mDUYe8c/p8DLXnBxzi5UuewI9QNfeEWXrYwp0IYmBGnu6SfpifQOIJzN2W17fvb0z7bBAEwArlmYqpS+/Ul3UVDA4A9GTENuB5/xq6CpNMq9PuhAXkzuHIBTos8mQzd5gK8Pfp5sOTrsJBUfjey3R/fjLePHHYeJNG18SJMIRB/9oJ48BKbVmYG9pjMLjYpMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9LkTMeslTsEhmzLp9ruqB4Cj3J5ZELQ40A7DXvVFTU=;
 b=B/+8OfjmAFt4AcbNMGnC4muS/Mtmz5voQXbN6D+XUZZaoty/6Rq6/0riLrVOC4eq+YSsjnycqAvROkfWKG0ghoMiTcVtvP8zWrMOm8+5ywzcvUr88qPO4X8m+0MMK+EiHr4eh5lNfgnVSaRNlLliqADi3EbYJZ/++TKfoRq/SWM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 09:32:29 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 09:32:29 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: use allowed domain for vmbo validation
Date: Tue,  8 Jun 2021 11:32:13 +0200
Message-Id: <20210608093213.8269-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.107.133]
X-ClientProxiedBy: AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::42) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.107.133) by
 AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 09:32:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44174dca-cb14-4b3e-e750-08d92a605599
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB539740FC36BF941568771AD78B379@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUbqRzRarjo0SINw5UixTXg/w1ZSg/bTZ/jE2vLCjLZmClNRtRLWu6rm/tSYtnk+0Uzw5SGIjMlBFQNPfNvp9sIH4X+qcDtuE4gys6f69LZPcfU0Mqyrc2+T7QfTwZ4DfeFieCkfnr6bIPDoI38Rc3quOtHWby17F7nlNWH1SbcB/9//fXQabqJroXJ7EczbaQ0qczEDhO8fUY2Htvf+7NAaGhAGf0GIizlfD/L/qG2NFGP10E5y5vuozr1iPcFjj2ZupcVQI58A67KxRnInS2lnJk/MyABDd5x/tCwhmId1VvVsElUSh+f2xpYgNrWyKFlEbFGpq1tdRluVFM1aaqYanWiRKrxx8TjXWmg+Zl3cvdS3tt3En+lsYFKHyOaBMpA5iBurQZYNyHhohfgUVJWBsMudTFXEaimv+uP4Wo8xEX9Itw0xzkSwBl8fsvk7FAQ27R3BFFuPpl+kDTt3n5vm4vOinl7lWeVqs4feHOLV2eHt6vdTlULWK/mmpORV1UnjTvy+5JixHQ0WBBh1EAIyYUzos2AUJSkGH0ipNdck2AfML5HAa7eTtprYvjWmaK35GjcDXVS5dnE8rrZcxKzlaHSgK3Q0i6J8shgv0YxhBg1RcGxZZfJCfd5YKdLnWt05iMKP4FqqfW/5NkLLrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(5660300002)(4326008)(52116002)(16526019)(86362001)(6486002)(6916009)(316002)(2906002)(6666004)(83380400001)(6506007)(6512007)(44832011)(186003)(26005)(1076003)(8676002)(38100700002)(478600001)(2616005)(956004)(66946007)(8936002)(38350700002)(66476007)(66556008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GAYQ6Eg9L76S8N35Ww5WexrfkmVsR98V+sFH3kEL+xgzpTAlUtUAsLo0zh6?=
 =?us-ascii?Q?qAb/eRf0jN3XBTLde3yG4SwoJWGQzZDbDEmUyDLn0a6+O70pQM04Husztlnk?=
 =?us-ascii?Q?/A1kAxlG/l4HiKYrp1F0cQOrELlQCaXk51dIe8jYTicIFQe73VER2bhJR5Pr?=
 =?us-ascii?Q?gn9EJDaM/osNaGmaqG2/Gx9m2drP0uWYfyp4GA1cCvPhuTfPPW/BkThnx5kf?=
 =?us-ascii?Q?QtHnp4X2ee/cSvkYhJKkkAXinnNJKvwcPeuzlkTNhx4UYiAH6cK/y6RLrH4l?=
 =?us-ascii?Q?QRIY3ZvQnNTMv1hWLcnGyWAjaMDRqW6C712KYXbnhuJnloqIJe2yhK9b5V0z?=
 =?us-ascii?Q?7kcuBv3ZyP8A1TvUwtmD6gjsb+4hDXxtxEQxAmQCZMpLThvAyDpMgT1p3WwA?=
 =?us-ascii?Q?V3GbyQgXz1Sf4XwBO6JUxM2dq5y42v8q+pPu6XAsIDQRQ+zNd24yoyIKr7Cq?=
 =?us-ascii?Q?6cWhv28WcczFXiWVmbCvUu0n3JzUWkEZm0nxpJc1fumUhbvuB+0lJ6uI/6/b?=
 =?us-ascii?Q?CUnHMOMnZQlCxreHWfVJrKigeEudU7Aj2yUQafFC7Kx/O7hU9yZuGRI48Z+c?=
 =?us-ascii?Q?wyPr409+JJj1ceOYFuBGKqw0/NfUV/y7/sE2+oRnrpjZC3azlBeEZ/59I/0e?=
 =?us-ascii?Q?mY1ldhK5vUFte0XjRIAXHNWieOedtJG6N3Jmh7yN6NwkA643AXyUUbMEVgN7?=
 =?us-ascii?Q?45OvlLaGLTcPOg8tgoXZBlnKl5sPaXRpE/IaStlszCEqg8SJv8QrTXpzQ+68?=
 =?us-ascii?Q?tmxwTLRFTsMzMDQ1WfbyH0mX4vn2rohnrFFvgRTxkt4aWW5vwWlWpTuAwA36?=
 =?us-ascii?Q?J4n022CuozVur7jRgxi+i3cMpDzkDV0uUgt8gawXNkWzUDbQF8RgztUvwM8d?=
 =?us-ascii?Q?zoyB0nhJSqqaiAu1vgSMAbBtY5KNz7WXJF8Ndziy/RqHg2+VufvO1ER7HSp9?=
 =?us-ascii?Q?J+ni0zl9NQN6WbwslA3zZZPxS+Y1WpsyEw7ZqQK5EtY6SvF/cY1fNK8IKchX?=
 =?us-ascii?Q?EarE3T/SoBK6E1UUkX+JPQMEIoTWwbeUZlsEhkU5n40Az7V3mUV2FHf4BM4k?=
 =?us-ascii?Q?0ODpBOATf+doi053RKifEzwIwOJW3IiGTQn1dnkZKDuVX/GNE9q6+Ni7jVd6?=
 =?us-ascii?Q?xxF07ewu1TBXcN9NYEOo/VyXESYwFhu9SRx5qqyKOdiL0EEIAFbECfMw4lDH?=
 =?us-ascii?Q?uttMw1RW6M2vOzw4CJT7E8jIjmAVFB2C4KC3P5uE69i9iEusCQzplUuFOdcf?=
 =?us-ascii?Q?AMZdSU1ICXnRtKSzh8ijigTke+kllcDLxOo5WFXNbmInBaoy5iA15kSxryoR?=
 =?us-ascii?Q?/d2+e+7YcW6AcIOrWTpQfolR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44174dca-cb14-4b3e-e750-08d92a605599
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 09:32:29.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpuRE00S4BQfKWpqAxn5ILh7c8AuwmUeo36iAa3JVB41mqKGEGqz8uGSsALWk9i2prbBhlJ6PxuRy/40mo0stQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove fixed domain and use BO's allowed domain for PT/PD
BO validation.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d6cb7cf76623..a45eadfbf417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -336,7 +336,7 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 		 "Called with userptr BO"))
 		return -EINVAL;
 
-	amdgpu_bo_placement_from_domain(bo, domain);
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (ret)
@@ -369,7 +369,6 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 	struct amdgpu_vm_parser param;
 	int ret;
 
-	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	param.wait = false;
 
 	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

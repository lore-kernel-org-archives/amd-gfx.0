Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFFEC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3708D6113C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3708D6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA7F6E122;
	Tue, 20 Apr 2021 08:27:52 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24AC06E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 08:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWfG/Behe5LzhWrW7au7Tvn2Rm6dKPgWUtFkWsU7/yg5/bEb5T/Msh6PfVOF9uG4MzeMZ17esYTW8Y70Au/C8Q4UiOsjOfvKZl0Xc8P8XGuQuotm1aSWDY36Tm/WXR371iev325d+P7Ux27NdROeSX6D+HvZ9+00kL9+OLBRrjNIG8UwZf2clu4rR90FZygwGFCBZdiMz5LX6TGodD6t+QnPa7XaDSw9GqFdYRUGHPKk83LA7UNhcxXUtLHrcWu8pBvKt0jeTmxgU/gQq9bjkf7CG3TPnQ+ZGnxtryHAyEdIgr6oflDOLe/qO6cg9a1j1CN/d93iPPV44o1Zv4bbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYUv2i3fqhuy33ckiD90KEOjtev971ZN72HzwKuXWio=;
 b=VTmMmnh4n0t1yhpdZQTR/A6x67zkKAGNdF6kQCxVyHG0p+Uhl8MHh/KooFOOO95AnA5xplk77klkvneu5y0zCejxyck8Jmn9iiX/0eZFiuPyE+g4HwcRalZO2yEWmnFQv2jLaJBYQv+TyJ62q+dd67s8Bkw7uF1e4w3hfJWZvoxYAzDOFnJSYAjhL0WbnpW1MAkgBo/AJnUXuXu1kADoxEzoUvoTgWFBHbyD+RoU7+tmE/zEJ7RtxK5FIErX6Imc//Nok79jtsFZOayBNfKE8XOx3PMw+AvZ16yuBTWDeu1hlh+kVxcFx1/xAMriv4YifuwgFUvQjEK1jyiBZq1eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYUv2i3fqhuy33ckiD90KEOjtev971ZN72HzwKuXWio=;
 b=3CDHcE+KIspqZn90Z/gkwaCHKs2/592n3lqgnT2YOwFGLzSQAPmHQu8dZ3a5iDQYRYCpg+2Lkj9m7Et3M+6U+RvgKU1RRO79ZhuauB/Cj92/DUmdOdYo6UXpQWpnlqapXHdu191ox4mXjIzT9d8tO//p7TykK9ECWxCOctMgsiw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 08:27:49 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:27:48 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add mem sync flag for IB allocated by SA
Date: Tue, 20 Apr 2021 16:27:30 +0800
Message-Id: <20210420082730.393818-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0073.apcprd04.prod.outlook.com (2603:1096:202:15::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16509127-83cd-4154-a494-08d903d62e59
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499DAE8F6AA608F3F55766790489@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4HMiwMLfZrSS0xf8wtkXK6pC3PayH0xW/tVe8tlSLkWnX8Nxjb6y/vti9GMIZYRyDMNa7PTwXi8EpQ3i4ZKD+jD8zYPTs34x1eW1BsTIVnwnMlUSmRIS79hUoQaAc+NOd+IfP+da5wdSHT1n0kI/F4R1o9QUVGBLiO4VeUny8oPvLyJRwvoOtQnp3Ah7Wm8+QC+X/1emXU3QcnEhwhkylRiLOKjKdzK5ILtjz2Dd3iiG8zK96BlTZQmjEWXNwwIAe90kfuevphJX8jx9cWjwoUDK8UYMXAqHLh9iCB28+NIuKHutSa34nkw922lxkQvekbjHnvGJWP8Ko4dQh0R0RJdUmC5VRn7EY86DwubNFFOaPhom1wmGZu5CrqypKWsgKZFdaUUucTZ92mCrvPM1cefoKUc/G5nvfmetUerugVhNpTBOJURbZuQnPxzytEuOKLdff3aFvZIhYvbiHxGwvD3YPC2yOGpQ0vw6CMrQuxX46MLebbSGE71t3gxnhnEpZBtznByOzwo6mbNy6oSZ8pRBUV9F4oNLa5uo359hlEFt/svb/TK4LZU1W6yVy4UKYFTh5AcYThfhm49AbsfXs/FU0U5YBVz+YQsggOy7t+KqHGxU7mkTbfFsScGmmBRPHdnEKATU6axjTgiW6/SFKylRN25ZGbHC1cNPH8g+EY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66476007)(66946007)(4744005)(2906002)(316002)(186003)(66556008)(38350700002)(1076003)(8936002)(36756003)(5660300002)(26005)(7696005)(6666004)(86362001)(38100700002)(2616005)(6486002)(478600001)(6916009)(956004)(52116002)(8676002)(4326008)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?28AIcc/H5f6r/xcFTa/lhvZ4jcc0oTrlOGWlIs4RbC/I/l2Rf90OixZpOe8m?=
 =?us-ascii?Q?W7WzpkeRQN2108mR3Pvs5saqGGxP2qD1X90d8RbWAUJ4kUq3lprq9HLMauNG?=
 =?us-ascii?Q?lDFOuo3BaFTyODRvc6f4h420Rj+8CuiQPExLM2WOeV/LdFWU2HjXU4d3Ckxd?=
 =?us-ascii?Q?epP7Ggxir5n3tA2jzl7KT8PqUU5LBgY7g9gX661ijqeMt9gMINDB5Akmvt7i?=
 =?us-ascii?Q?s2lETxo8a2irJhAuvcbJRuN1dic8Ww6z3pKukXhHeN40IOjzjKcyPCfkc2a8?=
 =?us-ascii?Q?SYBpTqkbKqEIcHdkq0/jRnXu+n23+M8WuTVGqJ/vzEDPZlW4p9xJ4z1eH+Vu?=
 =?us-ascii?Q?rGdgy3teuoS6C8j52bT5tjMNLZhm8D39GYcmW4krJYBSHOpEUM9ZDjzBudUy?=
 =?us-ascii?Q?bdOj/CYtU43uMk261oKyLPP4SpBdNUeznqnl3zXFCuIm+Zn9aIyZxm0YiWEZ?=
 =?us-ascii?Q?STIkK1FIIFYo0iqGMvyXi11R1WO+2FJZwuCfdKF5qXNvporc2TKGlOy6nRYP?=
 =?us-ascii?Q?YkKI/kpoFp/WtSDITyQhjWuKs27S2gFHPgKExHHEYK7Td6CBr8gntF9qLj75?=
 =?us-ascii?Q?E7NwXQo5+fFmWtaeYEe6xQi/AxZo6LVdWoY7Q2+vK88zE8ykv0RH00HLTJ6l?=
 =?us-ascii?Q?K3cnE73UF/fLMdtI2AsoQvVgBb0zQWBr22bKgAJHvyzKbK5W0MjT8xpBVbW5?=
 =?us-ascii?Q?s+Mvir8pU46hGv//wbCfdjcfHKr7lPQhBg/IFFa9sMadnoFy5uiyyj6cZ6MG?=
 =?us-ascii?Q?O1HTcW8oY2QCEC+p97jFTaU4G70M1jVJKihl4D4L+2WDia5stpkSKwnWeUai?=
 =?us-ascii?Q?5QxtqrdThe2yfkI1hhGtzlNm79jFE5tgh1N+ZaoNMtrwTUKIRoQjRkw3642I?=
 =?us-ascii?Q?2T4npA7TrtCIoGsMTlmxsdl3a9zmdy7WXMEYPBFKrEqc4sa9PnAAO7IPdK+7?=
 =?us-ascii?Q?MQLwzL4SnPQf3y9X/JxBAz56x8yzXpE7V8BKbyljtyYfKeHmXSX+2VK02XOP?=
 =?us-ascii?Q?BQix3mHRyjBnXx9EATtm8eMfEiLsxmqqtCzcxAFX1Xsmac+L4eAx81AeXtXb?=
 =?us-ascii?Q?kCmxuUaPS0rAZyk8P2EognSslkfcGyArdT+XSjm05XRCLxbvYN3NbOBZFOFJ?=
 =?us-ascii?Q?8nCUuYnQV7N1B8VDbPya7bO91Wa8TOzNdikdDBLmx4EcvM2yBvtq9pcn15FE?=
 =?us-ascii?Q?67bOjGhIdCHYFy+kNxyg2ADesEhQhiMOCOCH0CDAQR4TsyhYYNeYXmS1qXZr?=
 =?us-ascii?Q?WOPAAsVNnGxifKU+ubV+cjw9+XJeNLo4BYJnCbLI+4wUeUGeyKlfYzsn7ASF?=
 =?us-ascii?Q?9nxoXasrddfRJw8GzRilo6xB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16509127-83cd-4154-a494-08d903d62e59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:27:48.8075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL2DP+x6ar9GKlJobhfC5QRuG83sbrrq8fAfc7r07udORei0DjLDqiLs/5Vip/MtFqNAdGL26lIX4xIHgFikZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The buffer of SA bo will be used by many cases. So better
to flush the cache of indirect buffer allocated by SA before
commit the IB.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 148a3b481b12..a2fe2dac32c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -76,6 +76,8 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 
 		ib->ptr = amdgpu_sa_bo_cpu_addr(ib->sa_bo);
+		/* flush the cache before commit the IB */
+		ib->flags = AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
 
 		if (!vm)
 			ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

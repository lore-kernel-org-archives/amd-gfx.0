Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63FAC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C48564EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C48564EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173886EB81;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDF86EB7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofycq7Yat5J9h5JC6823Aw8Joz6ObYwp9a+Bhc0f8CqhZkq8zVwhU8kA9UQWfdUo5SIWaU8FPfyTkUCxz5m8N1CbQSefd6XjXYjj3bhk/jA6+kmaqhajh7qwREtborg5iGhsP+WMx6W+t3gRpRu/N8xtet7Uy1aIo59C21Txd/FjDlQEzblZ+2YBoDKWqeg484OZ1o1AlRtr5Dj2fRDdlL46Lznr56q9a6vsyUcPnZqzLgwJRUMLuc0oBbmxbPJrBtAH/QaeAHmW/Fx6gpC9VY8dfRzSUk+jHJpqwQRbikcMaA7jITxg1u42vQ/grkXVOZ+7QYyFmY4+5raWLiBUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0sUxBZFCHRIKlKZB3+zDlYMoVWX7F68q9DHcpIVX24=;
 b=OAxsKMZVGOf6gQYMlAmAsCqdruzBuNRjPNC4z2RAHXNaGtEF8AiPne+gg5mORARYvclH+DaqYKm228bItOg/PsHURPxrl79zobsaqAhHdxywUX5IDizbs7YY62zBvlIsRNui1GrwZH9Q7944IqvFWqStLNmdfmEZydorfTmzm4cwwiBfOGc+iIfOHQfOG2k30PbxbHdcmEk/fFGx8CRY0ua3zXMOkAs389fjr8J/bGXsIPxIhuXs34IfcMrxxlSftD3xmx+PX8krp+ZFXBEuyIKjF0vgY53wMyyEiYGVOp3WyNr3sNrgtp+aJS3zVfi3PaCLVUNKVsl9f2rMQPjV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0sUxBZFCHRIKlKZB3+zDlYMoVWX7F68q9DHcpIVX24=;
 b=hAyznsIx1YPYD7Ed9DqL/eYymah6DeUyqhygtaC6bVavawGrauqtaq7tCS0j2JGDDjgIOw0d0A7WT6N99hZJoE+5mPC2DVKQWGGE8+aygNzDNLua1sa6+qGxCxbeem2Sy5YzkHMw8MnGjNGWgdiUco2cMgs518SbjbBb8XI+8cA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 104/159] drm/amdgpu: switch to cached noretry setting for
 aldebaran
Date: Wed, 24 Feb 2021 17:18:04 -0500
Message-Id: <20210224221859.3068810-97-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b50568d8-9ecf-441f-1340-08d8d91267ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798C12E63B91078EB34A735F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sSPvPKvi6ua0LctrAd9dZjcYGF6Fcth4LMp8CdAsnviScuchplnSr8UeZpsAm7NmrDreQjuW4+vjrnezJuFQeEyZgwjT5mgs1JhydfqNvOwGuX7Y1ooOz+lTC4KEtqax0sQ50OcrWJ+eU+CQQrNhhd+gIU7HJ1+VfwGtd8SFacIA6L+CUfGFWrRsXM6xDXseluwcRNiIDkYSqpwYpVQLrM1P6WKWEn7pvhS9ve7+CV7BFs78gDMGOJqY9xpLeB0p4dvZ3cNQ2RFOBff+Rb1IC7CupagRrbI29qnnxdA9Zgtj2wbVKv7QOw9dkIOa0LuGUV29WLTZdPmD7C7j9D3Wwzaj0LPSxphh/KON6FxxC1Wjqf8l9PMiNV1Jy2mL4rOdN1pXek1ZqwcU6l5iHtF7sBM6Cdw+h7KuKbbxTYzUSnrnrG/6h8UXCul7PRhAuI1IxbrlHYfMsHaFTJJxNgXginb69y7cgPyl4I0K39QF3q/pTMaOEh7anQ1Cm1GTZtBy8LuERFvnjIrYkb1GEsTj0U6a1xY9ZMdJHUCj/I1i1DhNW0/AUEXp+8fsgid1QF2/54jU0N2LUl4/au0V1rcPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8q8O1nc85okc7H18z1mxK/uiTdXVkrSWuchXItQmXgBrljQ9Xh9fWGIf1yu8?=
 =?us-ascii?Q?mZDxgjaKCDETG0+vxTM6HO3AyXZFUkjYgQxbCLAtnLnLOHwE0+6IHkkv61ob?=
 =?us-ascii?Q?7GOutt2z3e5nvOtMhI4IUQ4TSCulJ56/yIkwFH/6lnJDg20C6TfVnIRMbtqq?=
 =?us-ascii?Q?viNityB4fzzPwtWeMmM5OKjivjkcFUGN3CoADH4/W7hD2OddF8zR9l//R/dm?=
 =?us-ascii?Q?U8KgguBom14vcP+WVzHGl/V64512GG65e6f8/hDdrWhYpSCVkQShfwYPGE87?=
 =?us-ascii?Q?kja7QKfXN8P0xvIUvVNdUvSv2+bAD4x7tJd4mIH048FqpM/bpQTldo7stknH?=
 =?us-ascii?Q?K8Jm6ZFvnv2iLU/Wm7eh6/1zvlsNDOfSIHiObPwgByEyMSIsuM6rzbB18Rw9?=
 =?us-ascii?Q?85TZy1hn0Xw394N9W5sFNhwWFZsu3CE1pn8g9v0ItRuRDgJAqnddVEqIInFa?=
 =?us-ascii?Q?ZHuIhuJOeg9i9viP4s1FJVrITRqrM6aLj+s1ROlELtq8G6ki78fzjfm/GJAB?=
 =?us-ascii?Q?afg9AwXQlsK65EcK5Zj8L6OiAsZZShxGrvE+ijuhD3QCm/NqNZ7lBdKwmQHR?=
 =?us-ascii?Q?qpyoVGfxLZ/AtoeVnsHrXGZZBVNkNPJX9PQCVHmA6GV4FwXaamqC8IOGVH8F?=
 =?us-ascii?Q?4vZTqvU/ryi8REaH9DzW59+H8TwlnM6X9MVKKJxJ2Gqfv0BNmjMirrRQh4qb?=
 =?us-ascii?Q?tDmysJ0ZVRwiJGuq8useJx3wUG75nh9l5pqsqg92zVdasu0pPRQztyE6CXON?=
 =?us-ascii?Q?e2beKgaUggxfTmO6Udx+Fi3ikCei16w804629TPg+bHtF5PEbUS8D71/INI3?=
 =?us-ascii?Q?dos3ZQxYNQcTuaTmPPwOahtk+EM47tQIgl+p6xnaN49pEqb6MMNJtdmMsNrJ?=
 =?us-ascii?Q?7Bru+9lob0u1cA/8syhEId56hUrJn7zBv15w+WBOtYSHY3Q6OHsgQ+lyvOie?=
 =?us-ascii?Q?OW485WrCg2vBnYPopByZBu/XpBdcURmNBoD2jKPt8/uf9ZokvkIeUYrbTg8L?=
 =?us-ascii?Q?FCymFOXIRkAxKrCsUVBLQkHmqHT6HLYfKV9FipXatCEwoK2+cOVr3HE9k058?=
 =?us-ascii?Q?6rIloA7J1nM3AzstBFV3PHf9wlIsTskpf7RQkUKaUATkc42Vb22ROocFz8hx?=
 =?us-ascii?Q?+Dl7uh0JLSgu9yFm/WhtsbH6Fjh+4CH3bXT16YTLC7qAG05MOkalZ7w80sZy?=
 =?us-ascii?Q?Ldf9FEn7UNRRGek47FL7gAD0GjByiVYwAditQNk6cGbWLFgE9SbUpX/g0Oqe?=
 =?us-ascii?Q?KR56ivORaLZt+Y5yt4UBnRueH4p3BTPVFm7mTTsX2TL2SZgmEQL5tY4Tp8sC?=
 =?us-ascii?Q?9tHY7DK3AqxEetw/mWsEFujS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50568d8-9ecf-441f-1340-08d8d91267ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:35.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA/haaKjah3sBBHGpiXRfmBcOBwhVu2oB3NaWaj9qHkoiTe0Ff/LGt6OIaCTPUiYntqx36NAMZdLsaCzI/4LuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

global noretry setting now is cached to gmc.noretry

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 71bcea66715f..f7471f7d32e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -256,7 +256,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

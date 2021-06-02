Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87690C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD7861C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD7861C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213D66ED9C;
	Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AC96ED82
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb+Ep/T++P7W0SXcxsYk87yPsLd6HSaZw7o7RHXcku6CVkDdODLIafiJJzPPXh412QSMDTdGBE6VHeAqV+utoiKan8TJPDUsQsyFEfzZ20AgIT5g9+DSSCctIkqyxAqIQ3DS1QJkI4THHgrCcTPn2SuxckBGiOaVJxxCnBe0C8PDNcO7NyCFTjYDw9dvpncDS3ysfBxzXMIQlO/qdiBLcqMGg/8uMSoQt1KBbdbbS/n0mYljLvVfJ9otplD5vWy0d0mMo+Vkmlfe9c9h85La17by4cY9CyMmlaTtJQypQlClVlrQEk5CJo3FQS66u59cfrbu2yIkeJXpA6BPmK7RVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K801+i/BOg3rI274xnZld/fwQStp9NYBIB7n9U7Vawo=;
 b=C/Jo99tpP5Hv5+tcBJ5LkpSmjiTwT68xrn01iAdK5znAPIumCWlHuwN4nHn1jLBCobBu8Wfw9pLgrZNluZAqfqQIWOC6KlK/t4uNPLzUv0ltP+eGPB6YR+2vxDAKewsKNS4XURCNSKQgjNgYlmZluSJl5TFMO+xCkTG6twD59Sf9h989I5N408sAIh9Qg6HZ8c8gntG93gniLbZ+wC178smlbSoBnry5Ht3FOYwBZXCnvpZohhbSNNncroEs/TICtBXpT2ZQ9PqTPyimBffRT6yTFrXn9Lm+1Y0bfHMWa3wobdG0ZN1jJOUJCmuQ1z9O3yY2rj1JySUdOcS8rO9luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K801+i/BOg3rI274xnZld/fwQStp9NYBIB7n9U7Vawo=;
 b=4KTtIaBPVmeYCEO8CaJPTfitkeomrHh2E/PZPr7CSq1Vo2vzLF4BM7Gr6M9L44ZuOy2CQ8IAh+LsscqikKeGG1vtGblo0owzhac8OlPPfRcvkeGeVTojyIXSdRVw0fk+S9BYwe5t4u1Mn1VplmPBF/bKU+BQVl6xD0U+8TYn10s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/89] drm/amdgpu: add MMHUB Clock Gating support for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:10 -0400
Message-Id: <20210602164908.2848791-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9718a336-6e58-42bb-549f-08d925e6701b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675E2FF8A150BE0E0276A2BF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++7mf0AWut3fS4BbSArT0BUSZs40msk1dBSOkhuiia8VcGq/XSx7ULJwnhErp1BDrdPjkmAop9XPkcT0BUUDqpHTvj22DyqIV0pvgGdCc3GnaDqLRh8vObK64RtFtZ+SxiyVremM5brtf3CfwNuLnP98RTOmEkXhJml+ubuduqPz0CD0Gco7SPqZVdDFF9powovovSrusItRksKNHJaUnqQeLmsLtx6PQcEmEhAajMwNQ86gLIuLTS1m0wPKmYn3indYa4YjlnwEiwZ9jXcolOorLzEvznj2sAjH+h+BjRoDtnRZqj3REEvnZEjXk63aCkBlWEBc1kbFRVUHvAD8TdXrnfM7FI5KhQkZrhpJdAT2+O/zlwOpxtQjkLK9pIUGOqFGAL3pzvg/hOurMxgmUd1aDnTXpSndd0M/50i8VO77je/cBy37QV+kux2SARVe+/So+rSUBBJVnJOrLlz6/qAtKno17kQ5FTV98PqWMUS1uhrpOLdmGQ37v2vlBmXiLzsNTVMFhqVwe9/Ab6Q1SEogHzlhIXvBYE8PXq2aycTOZbX6tUyH99ZAHDB148QI7CTpGEi0p+bno5O+fR6sBvxva7niQ7zhvktmoa8iAl9HRbYm+7oibEraU4nJqDOedPAqKw/vGXKNNp5f9EuQE0Qz7ERfvz0dhpBDpv44hPXHe4+RzwGy1Y+snRBl+6C3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cjposr24Tmx4h2v/z778vwWmjrJRyFkQDgNGwRjdInvb+vT6LQqJUxNk3RbB?=
 =?us-ascii?Q?BYmUYXDeaihphufcEpApuH4ts6FVJ7G7r2H2Lds/NRY+frXJW8W4YRAQzo3Y?=
 =?us-ascii?Q?tPBbGpc48ZlIYGCNcYFWMVrK76Dcd0zZrMlI8NMoVlcWVaWrTetb57HQNhgC?=
 =?us-ascii?Q?nFTLi6x+6/A3ETfFK8AWdTJZpvtZwjIDM+Az+tKUt1Ym76KXVCa/0aJ7s2Dd?=
 =?us-ascii?Q?jXJ9feWQI5tLv8DvxUghGZ45CDfdNfHBuqVgX54ARqjpM+r5NgWSwe+o4hN/?=
 =?us-ascii?Q?OCLUis9DSsqXLjob6iQUivw5yB+ElBrFECyoY2zDmcNP2u5SsshHlbLB0a3g?=
 =?us-ascii?Q?Vc3IBNbiWLwXBEfUazQdIrq801d9swfVzMcMvzXFTnZXetVOYoD0QIZDLP28?=
 =?us-ascii?Q?AV6ftmkH8h8tJwpbT9fy2kysBpZd4rZOWZ40CCyzRbOq1H9I6MqiTlcPcwSK?=
 =?us-ascii?Q?0bqZE+2cZzkfE66Y6JnjOsSjaz4SrPHkolFhJ209S/iFTGb8K5jxIohFXblX?=
 =?us-ascii?Q?i2ZanhFAJXVZ9ql+plpSpKu4m86nR8rg7u/XEkN4uU0jqYFIJegFHIQQSvsL?=
 =?us-ascii?Q?puq6W56yPPOg8Ji4HDIfgmAlpnlL4dZUiLoEhauFSIakRsOUWX5pmFvme1uV?=
 =?us-ascii?Q?3Qh6dc5Ps/mDvQ0qHIxn+Kj9AeUhDjcdap4jp+TlVe409FGdzMoGlo5Cy3GP?=
 =?us-ascii?Q?wcApeDG6oe/dr2vJb8nLnXsqk1pwHjqMWRBPc+QGMD66bHPANE05dwlXl2Di?=
 =?us-ascii?Q?P05AKk1Tx0eMdQKsGSauURw77HgpVicnlSR3bZPeZXFUrem3ZpXvCtNGcm97?=
 =?us-ascii?Q?zgmPlSclOVNUb4TmFsMt71N+EyKTmKvVi4ysS9XmrM9B9PAouDHbfLFeBuO3?=
 =?us-ascii?Q?lMQkG+OPwyd+AndiKK348Ue5QtYuJgX7FDNkPuUrcNVYDBr2mDCBjj4i6yNL?=
 =?us-ascii?Q?h5SZhdCeICV1MlHz2M90vnaougHaPntAhzWIkNq6fAFly5rINdTHdDIXIAeG?=
 =?us-ascii?Q?B759iCgGHYQOlhnxFb0vLYWtLeIIVncvrPtrISMMBSJC9rBZ7O07LjGiMDnn?=
 =?us-ascii?Q?jINaih1Jud6G8ry2Vzlnq6Vj5zhi7IWcT8YUCnpRjNcd9x2ofCMD5Wg2TMhW?=
 =?us-ascii?Q?8Y6VV9qWqXIz/M5VejvOeE7FgAnx2+M8djE6pdgKVvZxH5StAWzpCIL2HSCy?=
 =?us-ascii?Q?Gcjkoi4UAABfDISLPNGRAF1Dx8uVWxAHqz/ao8CRwnkxEqmFiOUL3XDz2q7d?=
 =?us-ascii?Q?ruvY6I++azcrwN2wSMyVc4fDrb5j/6kXkD+xTOthSUkiBdj6gH/orymBv3om?=
 =?us-ascii?Q?MKgqy3Q0iLLoxqjARMlfsSVV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9718a336-6e58-42bb-549f-08d925e6701b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:50.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxPgVZ60ukfm1IqlfANss8UZDL/tjbguJTh3tnXe+Qo+1ToymARdM6LbEBvm5OFAag3e9mK/XcD0PyJMUruF7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add AMD_CG_SUPPORT_MC_MGCG/AMD_CG_SUPPORT_MC_LS support.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a605cbfd7fc9..e9e6ac40e75b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1333,7 +1333,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_GFX_RLC_LS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_FGCG;
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

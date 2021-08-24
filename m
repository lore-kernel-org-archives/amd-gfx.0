Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF550C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BB260698
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95BB260698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3609F896E9;
	Tue, 24 Aug 2021 17:36:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (unknown
 [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8881C89654
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm1UYoBjwAeShf7W7FHQJ62ZMoI7t7pp7ARWUjmuZe8vBRQ/O0SyUIxVvdC6ZYPTAyCYaQHLHnZF1kU09ZGKRlIhA8rb1bTp/0VK4tWZw7p+hZw5+M2JYLT0sgl7Q/QMuGeTmILO3QCCemAzL4dSWeqmefkZnt2LLKDYt3/iwf0OXO1+L3MVxxXhpXtXh9hB5tFmSSc0XWz46gbPKDyhESMRcnJKo1Uf7XaFBZYc5Wi0i+mceTXtxmnYPATmeaHQIN44F50XLryrw9vHQMPOOojGxvSgTRrkVoEiEcgwLhhbaosFEzeU1tk1YOgrRcYm4knWFNZmRqlCPWyd7TlXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+R4ITR77PU6hAKlsJzguYzrzxtgC0Ap7F8gatDbYs=;
 b=ECSYJLXOJZuGcKl7e4YpvM6agt5X7Dj3hVN0A5ChyAdZy8MxgWNMERoQlQbv77D0OEW5Fpt/fdyaZTxF1lYmg3ueyMPRJHIVHHDKkHE7nREhK1YcnCGGm0Z9S8ECyzzhKUUgltMMvPCn8ShXTizwQvUOt9zoVndIOnWTJW0717UdzGW7SrZSizU9qejViFFjRxiV9qTjORbGDbXIDhAg4hRfelmTd1Zy8OFyY/kt34zlq1xrSeqlS1PiqLigSjlK7JgNJQAuPByk4Ggq2DAKyPbsYDihgP0qlACzHwYAUAAbDdIk3X6dXKsJdMfw/puw9y4ejdmIOiUtXTiTNIuTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+R4ITR77PU6hAKlsJzguYzrzxtgC0Ap7F8gatDbYs=;
 b=IqjXUhvl4+O4SwqXDsueNIsP1PlXMzIST6ybwb3aawX1+DvBw0rjhTCzxMhQQadk4bXquYZuvmQJtoAdaXHcPjYBxXEB57DSTGugOzmjty3RUWjXB9BFaid9pDdN2ogk6KObgjLpUXSnkGPVRvgwYXpWrkorXyBOT5ziukLJnYU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 17:36:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 17:36:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/display: drop unused variable.
Date: Tue, 24 Aug 2021 13:36:30 -0400
Message-Id: <20210824173630.1915457-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824173630.1915457-1-alexander.deucher@amd.com>
References: <20210824173630.1915457-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.5 via Frontend
 Transport; Tue, 24 Aug 2021 17:36:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abad0a72-8042-473d-1bc4-08d96725bede
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126B14848D87A4287ED18F3F7C59@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InYyGkMS1QojXLHzShLMQAO9uTikt3bUrNqNs0Mj9gPnTzbi4/fjaj/236kd0Ao+HQWDZdT6ctXqHzvi7DAyzDX7EGyEDtC8zht7lSKLeLI+uvGvu+qJ3OBysF4vlyMM6EUi9qRYbeLWjchYDCFPdO2arq26DNjozfXtoUcs329nKSZDBk1W6Mmm/WRjIIYglBzbwCZd2gUjXzj4rMFBkZ2UUBtLznNSfH20IEdO+c5VcX78eow4duBC6bomEvQQNysK9Bhk75MNahFBifOrKRsyz8JQmcW8mJ+6Utc/SlonvfQqtPRCz+DRCybS3h3kmgWd0g8EMrcv/XVJPZHF0RG2+r09HHUBTePY81SjkGhIQ1PmEGbmd0ZgszZFAvLeL7StLEfh83Oo1zFtSNsH+UoKLtwl6OTlPbs25fx8s7ez1futN+ZmaeHFxFOBIbhvcT4LdgBeHBAHL+PVvUlnrdldOrdl3moxcH5i8/C9Nycjy0JIZDXrNrI6mlIjMOaBNICUdVzzNQXrzbhJBiMezVdbWLE8KupTaMSnjwOxSLNlv3//O9oYanKPZWduxiLdzw29JRyZWfNkY6qSwmAtOa7MVW3pI0zXy8kw0SS95Al0/YYeUu1MAW9RayySuPSwEBFpnT3sdyNp1Vd/EVxbTJx7wEeykt49iEICIDvrb70olbzxgTuN/ZDAKefklae3bsC6hgfVdj9mxKUqup8vmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(186003)(8936002)(6916009)(4744005)(316002)(6666004)(478600001)(66946007)(4326008)(1076003)(8676002)(38100700002)(38350700002)(66476007)(26005)(66556008)(86362001)(2616005)(956004)(2906002)(52116002)(6486002)(83380400001)(36756003)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CksFUKR9CrozSCSMBJpEzwmeZSQwyF3o6Pl0LDv7bEnxAHxReWd1g3igSx0j?=
 =?us-ascii?Q?zQVn0Ve3DzZ1TnMLJT4kq7I45rtXuDhq42QKiqNdL0k94rVdNBvfh6R4ZYN5?=
 =?us-ascii?Q?/Ca5f7guLr9ML2PAEFAJKBVRyhpHy/dd3GtoFhRkLyFNIwzpyAvFQLA1STRO?=
 =?us-ascii?Q?GOUBnIGywzhcNcfaR9D+ZeNMCWJAM4BodTSLxCdxjIEQVHrIEdiQ3kQM7f5C?=
 =?us-ascii?Q?HNnwK2r3BUeIiF2UKOoJd5Yffq/UQoEP4Ajfz/QsJ7q3Om9W88e50Uw8/yWl?=
 =?us-ascii?Q?2pdrAau3mLIxnIdo5Ou7SnC2h6PWx84l4XdCWBYfXoZc+F46Bc3zYHt3ebF+?=
 =?us-ascii?Q?YhEd4PQSLMnrMlZ65BtHweQU7ZTw8Ntj0e6tbOIru0Jkyx1w7dh+eTBQH+49?=
 =?us-ascii?Q?+csmXWORL+cZif5OcF6gCH4HQ3aQSqMiUWQJTKL6/N+WQksvoaLSetdC+E6f?=
 =?us-ascii?Q?vnIAQfzGMLmJ1pX2LMWbDV5K29sqMb3nf+AqQWBkcpsPuW/ZnFTd7ljjD/43?=
 =?us-ascii?Q?O5ef14hW/XlaolLgzmDqQVUweinP68eoIeEPgtthydVqOPm4kOjR1k9g+EMi?=
 =?us-ascii?Q?fUmRaRzRub2KQdyyf+YUKOr+SqbnMIiobEIC9NJraVfv5f5NZ7ZhIQ4sOM3s?=
 =?us-ascii?Q?FCKlKOpvQJlFf1h7iSxzcLN04kQV7Ra8YCt/Vl2hV77iGS0e2TxL7JPU/4VU?=
 =?us-ascii?Q?FByBKUkuO0q9jOj0clMlJlyOVsrmoljw3txpX2xJn3tRsoBcpi59HAIxKrmm?=
 =?us-ascii?Q?e1zYbktMW7vJFKqC4y43+wYDyWPAPLBvm0MfVIR3CT5KHEguKUvqi82y4TW2?=
 =?us-ascii?Q?UUiyaAb+8IaRp7p79xIdnsAUu3s4XIv8OAmFUhX42PhHMojvDacH2gOCsb8U?=
 =?us-ascii?Q?752l6Td/K+AHfLYOAagPhyQsJpJrsWRi8IPZ/jCrQnGqZGIUCAJG9GFpMIpk?=
 =?us-ascii?Q?mQo/I3Wg9ct3z+ZFBST22ky0yTPDya1GQfm1JHgm4M/YBQzmnWhGaVP1n6R9?=
 =?us-ascii?Q?RBb1ukaMFUw/bJOA+qYODjXTRrUpiG1V9Hx74Yj/heFU8fgGo8ggb2JNqX9K?=
 =?us-ascii?Q?dtk11WUuHoVus9rU3X+xJPjVEEXm6ZoOjLSopS65WItBuHHqw/Js6D+JsFKa?=
 =?us-ascii?Q?xY/bz6VdhxYKDrTE8mREPK+30oZb9d0Ff/2CGaO7cMuH69oF5mPajLMoCxKC?=
 =?us-ascii?Q?Jps0QT24uiIv1CvDpgDOg9lRoj16SYMiAHUfyzqcwI7uu/DV0aAE+NRsMnWx?=
 =?us-ascii?Q?oWQF054PkRSlwKwNPG+DWjJoEFQHKD7yRYGUbJbRgI8PS8XkynYuuKemYvMz?=
 =?us-ascii?Q?DvMqWsx8NlW2763Sen9R03A/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abad0a72-8042-473d-1bc4-08d96725bede
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:36:46.5613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qVIceM+WCh5mJwQWr3ZLIEJR4HDio3z0uH82FHHBJGRaKj+Hg1xvp1uerzxXV65XeQ1C3HoJ1eQkCqddcdg6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bdc7d7ebee12..f58d3956f3e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -186,9 +186,6 @@ static bool create_links(
 	int i;
 	int connectors_num;
 	struct dc_bios *bios = dc->ctx->dc_bios;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	int dp_hpo_link_count = 0;
-#endif
 
 	dc->link_count = 0;
 
-- 
2.31.1


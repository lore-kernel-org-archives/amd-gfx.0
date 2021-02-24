Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCAC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6319464EF5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6319464EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BE06EB6F;
	Wed, 24 Feb 2021 22:21:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1F46EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKP88N5NACrBpYIDKacMVrb1de9pLHJCpCySgmnqrpE652w4KnEeKAuwYb1+7MxELYn6scVzFm5rW3t0vPyOK4k9/uIM14oP450fdn81e8hv5GWKbayHCaZ+fLP7rYDAy5z1ETcFtGRK4THr6yCMfEiWyUlO5LInoDnn7Trx607RC60fo4isNBoAurxWmYVXZZ0pk+cjOVQ6aTbr3mjoaKfoqw4rq3L1B580FaEJ1+PJjf2cANWOyhTN7+tTDstpX38QgY7Pqjjr85NjMVf/ebkjbRLZ/axUZmVVT4Wdo/1WGBv3BZhVA2EKdOjalTBrWM0/AAQjkmCZayDcWHm57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77P1b6ketr5Ka6p5IjrIavLeqponyjhP2xwUSiCmIy8=;
 b=nkjqxruRMckZH/yDiWNkPZBsh40K8yJO1vYbuubrQ0iM0hDe/52HI2Qr0UykBius6ozsUGC9xdZDN6lokgoKO/qxw8p/N6Slph2zJ8CAXjOP12H0JpnKY+fIZzjCBv96Yq8v0DQup5Ou0mlC7tAmBG8SsUFlPFafiKOQPu9nBXfQB5o7T9bRCcfHCl6ctz17onh+N6i3QGvo52OKIXM1QC4iGunB9JOOKawI2UWpBcxPYuhkT5qAEmQDyDgV6hz8akgRw+MXOCSub9fuuwbbsjKdwM9tiyWBHOZWMbWOHuvOrxRYCddMCZttHC1732cB82eXPoF2WDOnZyR5ioS6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77P1b6ketr5Ka6p5IjrIavLeqponyjhP2xwUSiCmIy8=;
 b=Ot02QcBC/HoY6MAKqqU9JG2eC0gmqIa0QnrXjUkDzeIqTJHOwW3+/0mxG3lBEyLNLz1Pj2/6iStfd9LEksrsqN0OxPGkIsXgB+r4wfe1O/lFxtAgUhK38SbK4ArJNkMK8vIAvkzclE7Bg5KedH31DfytHH+ICAtdfQsBrBlHdaE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:08 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 088/159] drm/ttm: ioremap buffer properly according to TTM
 placement flag
Date: Wed, 24 Feb 2021 17:17:48 -0500
Message-Id: <20210224221859.3068810-81-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7b2cb4b-13f9-4964-1d89-08d8d9125fd4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046E92708C8E2345DF79EA9F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lePRvOFd64rvuOFhRFH/UBA6u8MUVxKH2aBEM10W8xgn2Rxyudzawf7EyonvI5i/i9jmNRIVzdmUlHa3MYA4vUeNznerDkwkLUZGryMcNE9sDKW59WOOmAVDZrSNq5KhfVITjfSWxkVH8vJqU9D7Sa9Xu/0Q42tLtFgFEBrUgEf8oFKop8R1lbV0PPE2lam72rH6iLgeF0W4mA9+VVyQodb7ooMW5E+DMI018v/MgpjxiNOKJICc81TjS6BNhSBYMaHanxwHyzvjwIvwBLOfzniSN8b/KV6gDME4NF/3JK6OT+W3EVaHLL+5XIHwQMtf0E9lkyN7t9JTg1EKajW5R2QJwm7DQqD3IxJ/T7gp+dbHDpBMWcFN0DILQnUL0d8h+keNySdRxafDNHLnEEBrUXpSGrbGI47ByJGKc0SG0UGf1/xSgY1mqilkZih7IiL0KJyLkXkLn9Ck1d1PHMcLb3RIpONFZUERbxf0z1zKazDkshym10bdhENGC75GTRcQLUlLutNZ3eI+QjrkNmOHfN2LVTHvAV1ijKxDsCemR08LJGll3jMwUWACEXlzOJm/mq1k8L8c1pSG3V12o0H6pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?A/CkFv1mwewj57P4Lmuumu3xCXsmogYDhjpU+bur4PR268ft0Y26mf88Ub8m?=
 =?us-ascii?Q?3kgwKFdSwMe5a1WM1PDfxakmplZEbDj/PmOgj0ebgtx1x+CViVyo/2eLig1n?=
 =?us-ascii?Q?qmj1zTTOGE38eK14BTnaHGwepeT0/WjUm04pmm9Kl/BcaapF3yZfZ19TWeuG?=
 =?us-ascii?Q?DSa7CWyBu9f/q3jUws5cKsXnNdBPNYk5APe5DNJI59e4rb9VCWkwsAb7eGJW?=
 =?us-ascii?Q?aIbH3nElUEAnOGvWvzKWSp+1YK0oNL0oMX69FfuutCAV+Jz3/3bb2AoCiaSb?=
 =?us-ascii?Q?6ic10vDBcrOPq+S+uycFq7VJtPezLfSylBuEspkBV7chmJ9zb5zxh7DvqecK?=
 =?us-ascii?Q?nYNXJMDoIxneOh4viEGk3E6Mt2GIRagxv+bCRpSSniIZWRp78/fj9F2KfyJ7?=
 =?us-ascii?Q?DmgDacSlX8/JQNzdbx/PmqUrLOR4OZ5r7jaCvmhvlxsuE5RvDRmo0/825FGo?=
 =?us-ascii?Q?3hShAbJzknICs0WjM96APQV2wyVnpOPfzw5QwAYOrVpyOtDFmyba3TldJhwL?=
 =?us-ascii?Q?COmtHw+n4Ot853YXGRl7GovR0C5U1IbtXEFQiL1GEigVdmDl4qdLNPCwnkTV?=
 =?us-ascii?Q?VQp3grNgNmKaKaaAdY90LZMkj0OHRJHZXz5SMOKDVFvMtqYS0ijJjadJZr6m?=
 =?us-ascii?Q?XX7WcA3MpC/Z6uXrqPeQuXfKVnr6prQM31O+PworldO4n0Dcr7+Desojy9Cc?=
 =?us-ascii?Q?a5w6wnEJLfxp5P5GRhdx8cuGI0uHQiClwnWvk9E0bShlGJJOzwNqSNuLZBlu?=
 =?us-ascii?Q?KrcPHJ0kFrncHilZD3KHLho99nU8QcrG+8pCDbyPnMDl5KRlh4r7ifBZ1sKO?=
 =?us-ascii?Q?f4knwY1uHMxw+XQVykO7SuWzo7lsau0UoFGeLoIzFkUyee8PCmBoW4DZEYhS?=
 =?us-ascii?Q?x99N3q5ccSqkp8Xj1d3YHC2za0ATB53eZqsLF4qxJUhitI9rYWa9CHWExehe?=
 =?us-ascii?Q?JSJbQqSv3JHk21mAZxp6gfNAWuNN+ag0QfBy5EJIvXa/DG/kC7rBKauzvAs5?=
 =?us-ascii?Q?4Ul/5rlpXTsGjaVetLYbIQk8gYuca88+GJZzUAZK5aIYpMB5vnSRcR5N5ReG?=
 =?us-ascii?Q?fK/bq65mYQb3FG4ppCK/Rx8VBwiYchU5mRF+GaR0nt781SRtPe2LZVvX78S/?=
 =?us-ascii?Q?5UM92C/CeoPyK9zYs6Gxi3eQdlxmoWylV46cS5MbqXXMxpRmbVi4U+jZ8eqR?=
 =?us-ascii?Q?+N5sN7UWJo62vlTFpiobAPxEtSumRIVtzkQu0s6sMGxoZfq2uDLX7GkcB/VM?=
 =?us-ascii?Q?KHl9ku4qugYtCML3o54oEDlOL4AWWtUapGbCPVSLZpvOiIebDvzaZt1R96qw?=
 =?us-ascii?Q?RJz2fKCUAkKH5YxIMTwRmj/i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b2cb4b-13f9-4964-1d89-08d8d9125fd4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:21.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siiJw1PYj6098zZh7NugPp97N+sBNHzRyZuXRxcXuGXODqbhGt7WDy7fEQof7xBcPxJl5+StoOMiVUPKxB105Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

If TTM placement flag is cached, buffer is intended to be mapped
as cached from CPU. Map it with ioremap_cache.

This wasn't necessary before as device memory was never mapped
as cached from CPU side. It becomes necessary for aldebaran as
device memory is mapped cached from CPU.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index ee04716b2603..e11ec1ff5d0b 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -519,6 +519,10 @@ static int ttm_bo_ioremap(struct ttm_buffer_object *bo,
 			map->virtual = ioremap_wc(bo->mem.bus.base +
 						  bo->mem.bus.offset + offset,
 						  size);
+		else if (mem->placement & TTM_PL_FLAG_CACHED)
+			map->virtual = ioremap_cache(bo->mem.bus.base +
+						  bo->mem.bus.offset + offset,
+						  size);
 		else
 			map->virtual = ioremap(bo->mem.bus.base +
 					       bo->mem.bus.offset + offset,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

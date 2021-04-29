Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF594C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 01:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7195A61450
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 01:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7195A61450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C877E6EC73;
	Thu, 29 Apr 2021 01:53:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF946ECE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 01:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihfb3hMCqDtvlXWBluGQVal7dzyRkw4xFGSCOHcOd9Ze/Z3GwuxSM7L0ZnJzMhIg7rCUCmnXclelajspCUJa2zByExMOWMphakf55wFwa5155wUjqp27rVpyFXxPZouPc1hmxXPRN74sqc8pI+oJWp1OFePX6IaqLD741NbQbKl7qxpTOdRQWSySqcvR144yWVVbGpu32iqEIODEYje++GoOYT2siteB+fMsPw6R8o99HPo/k4c9Jkn+JA2zdr51wQVN71BD1yr4WtjcYbpHgT9HYuXYGOiAApc7PQ3g7SIsu9o8eIn5UuGV8LcmWFrsR26ygnbouKKLrPOypHQ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrnyg04xPlRoKNV8jBTy1/mTADhhHz1GuhgjaHScxSg=;
 b=f9jdSKbvQ20VsI5i8Aq6EltPGNJ/jmr1h8rVDMfOqg9ap4IivwTvIE/1okTbmDpEvCJjQ7t0FT3j4fmcZA22UF3EWSePq3NfFF90pmQVvnpSJyqsalxVfFI31TpMdLT7mU3EJjNQNu/UQ/6hPfkX+Xx/2whkMhh+bZ+7D5WLKAsVJpB7dh/cUzOsXtKC7l5slKJdJXA74OcQdRKifdJHDbMC+xNiAHO7ssuQskg/15u7idYS2+fujUmi8iti4I9jaDtpwyNL8v4va/ntoLzjhfldMFt+98OTQ/1Q8lUGohHLHKsxOzOhPatgSnk2ZyzddfhkdQGgRU69DKa4HV/N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrnyg04xPlRoKNV8jBTy1/mTADhhHz1GuhgjaHScxSg=;
 b=iHT7hlW2HDoTiUHV3lI6atLE6zpB2cloqLM9zDXM8fypZ11CDd5vmrbHfWGg5r6YDVlbLCLo3wmjJQOwtGNKLR701f1/lNDXQLp40DYVqhneCPYyFx6os0AuLplJW51kRhkKZiqKD8gQ5GVnp+Tu33oSwwBkhzQOmJ7brbklo10=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 29 Apr 2021 01:53:57 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 01:53:57 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: flush TLB after updating GPU page table
Date: Wed, 28 Apr 2021 21:53:39 -0400
Message-Id: <20210429015339.13047-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429015339.13047-1-Philip.Yang@amd.com>
References: <20210429015339.13047-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 01:53:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ecdafd1-b50c-4b61-f57b-08d90ab1a658
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514AD58C6BC9333A7AAFE29E65F9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AF+ZsI9/fePijXJJ3RSe6nW5DMeri/Ukpav3d7yYSUXVQ/Qx+nJQV33EBz62ZF6EzqdRZcpPtZ45B1SCY+aJEdkKtjLd9z+lhoGfgU/wzgbrx8POMCrKGoU/vbjZDcS3Xl3kgQShlW79INcInPLFQwa0+SyeCANzVRgqd/qrpjUZpWb5GHQo3KTPlSuY8taKrNPiDezhvXu+ZyNHVuimnuhljNrGJdicGVwA4PZker0gmqWf3Q6puDpOuSUirybyj528sFXtURGKXsg3bzOhxP/Sjv3hPTCZ2v4OlcFEdtKvtuU8LpKaXf6GSv/R7k9Q9sTmCdPFvD9NI/y13PjQE5fITE8oQkIt/C2B5PLgmZCUkvNHok1qtnThL9SgkpLkpyDq2b4OqmuArXXplVJKnr8MmMFUMY+bkgSLxrOu7p8yglMKk19QMh80mdNjBFZ2IfAODf3gy9qyXS5cLrhOQZZUbEoZa8TEzRLE8kVHMYu9iwM9/wxsjs+KsEoTxl1TUji+Q4DaqH18DnsehMHbLsUcsMdHtbLr3s8W2+ruF/pCyz5UfXkVvBPuUVKjvkhxhj1BSaUkGzDcaFCwl//WihUGo8M8BwQpZWDP/VYBb6YnyBIHG7/DbHHffqQ79VYBG2le8JFu0Qx2/qH3iQ78Hg8VTROwTuPiXRo/a+YM0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(83380400001)(478600001)(26005)(316002)(956004)(5660300002)(6916009)(86362001)(4744005)(7696005)(52116002)(16526019)(6666004)(2616005)(6486002)(66476007)(8936002)(2906002)(8676002)(1076003)(66946007)(38350700002)(38100700002)(66556008)(4326008)(186003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SkkA8pOgnv8JJcGwk5ZU+//NpPzTaCSyIPY90LNO0DCSjS5n/uSQ6xPYGsaT?=
 =?us-ascii?Q?aY1d17rIrvu6EgOdGjwqGLyP1n0M+LQp4M1Mdcp5FImSyg/M5z8zP3NaIO8t?=
 =?us-ascii?Q?tpxKfgzgxd1NzhessWPj/MjBXvjSNEyHvu2OmIVY+BflMVZz/j+lnlVEcLY+?=
 =?us-ascii?Q?5OvxDluNSWlAtLr0HKKBxO57GT1FfgHZPg/vnwBHGDdXhYjqhQGU3A7iwpi3?=
 =?us-ascii?Q?QDTzYe/VDixFa8VCqJV74GtMjGcpB86xHTqNg15G7PuhonErisc3/StgREo0?=
 =?us-ascii?Q?eFFQFNCukuQY5g5SVyBVxuL1p5gNL1vdpgJTRNEa6ECrivs/FqBXRrybSyqn?=
 =?us-ascii?Q?PxBzPOwhwdPu8waPWHEAlLZliEqLjVUWU6rgh8KTbEGCQ+ums7UD7yG91QSu?=
 =?us-ascii?Q?02i3oZ7n51tijr9/O3GEQVw8EIjRjCMW6I2GdSuRCDHVFQu5RB3DZh7M9Ymm?=
 =?us-ascii?Q?EVdDEsGf501q8yWOljcaXoOKET3s6UXqxGoDpRht4CEtCGtGYfXniVH95fuC?=
 =?us-ascii?Q?QtPny3/dFaBeN2+3VTYCHjGyE0+rN+bDOe4NEZhLIe3vS5Cq/29OEB+dE8B0?=
 =?us-ascii?Q?gfAca5R/98ogP1EP7CXO+wGpuPeDFPq+XvVSdEbtChs1mS2QArw6MHIdMVj8?=
 =?us-ascii?Q?pVFi3o6NbYeNios4AcmXpAru+qj5sOAy4ZV22OcLz4hGjKAFAl0I9PMHJk02?=
 =?us-ascii?Q?xtnvVENkmw0AZp7vugeBTiBAJXk+Gf/tmQMnB8kEXA+lx60wPQbRGssZDcP9?=
 =?us-ascii?Q?Oj56HJujce0UB5OCbtMNHbr75GOdehpqMZp1Pk8gGt8qH28sbOWugvufYvNS?=
 =?us-ascii?Q?lobO/98O/cvyaeJGczK+3jR05esW6hkWEnECryE7DeCTKwWnNvdkepHe5XVH?=
 =?us-ascii?Q?XGIyyiWqRGTUMINjyA98PdERfrEUpKv21Lwt2XV0fOLjuSYQOnw0QZVhTHVT?=
 =?us-ascii?Q?efEclZIoGoakjOXbGiZ9hf4WhJqwSvhW1dW2FE4K/4j8sTfCQuFbia3sMOKY?=
 =?us-ascii?Q?Hy+RKqmZy0luy9UgyHEsgnbcioGimo5ygkXmQqHzBzrZaDgLVJWCmlrPn2qu?=
 =?us-ascii?Q?yWkxdGINH2pjvJlmxugEeAmZnDGtmX9BbZ5TeX1+4u0KayfMTDapnHG7mqPG?=
 =?us-ascii?Q?322aFfhoQ39e6f1EHd4k//MV+WLOy19uQHeBnKnxi7TmD/aY5Wf+JR72BR7D?=
 =?us-ascii?Q?mWx8LXObSP43D0M7rsgV52No/xoN/zKPpjcF48ocDbLU7/tSVtFsHfpIf0PK?=
 =?us-ascii?Q?w4gNVLbH+LW7LvmUJ73rK7pUOztLorpu7/yHTpCuuQNxVJpGe51YLpB9GgE5?=
 =?us-ascii?Q?FSBnRO2rYVOyFCXUJy8GPR7w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecdafd1-b50c-4b61-f57b-08d90ab1a658
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 01:53:56.9300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqn0CrbKR9N3Hm8/yycUzMtF3GheIv6PVu1qzeDY95MxzRSFYNZy9szVEpu/a23X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To workaround the situation that vm retry fault keep coming after page
table update. We are investigating the root cause, but once this issue
happens, application will stuck and sometimes have to reboot to recover.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d9111fea724b..a165e51c4a1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1225,6 +1225,9 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
 				break;
 			}
 		}
+
+		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+						  p->pasid);
 	}
 
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14768C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0F264EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0F264EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541A26EB86;
	Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A107B6EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA4fm+cOIXAJhMSlzOF5dTl4Pp8stzlLRVWsNBjICzjcfBvvikPl2JnfUw48gDSK2ly1JEIq7W+Y6kJGIZt0n3z+Kzuj0/9d8rPfVtfJfs4hkH7ORyi23TD021e0h6ZE19qPnFGG0ha+GyIwDhqJiQrtG6gmTAm9RuPdo1UuN8jp0HWy1geJTxiTy1b5om2iwRRb/fMJ6803sB2O4xh3qgzgxPRHjPm2hzEoo/ZBmwMmGFJzBozhntzwrITNTEITCOu31Zv/V7572HyvFgylYZBtu/+ZAPWezvWsKQ2y1gnMg6qt5LJvYBiTId2a8bczSsx/lAUmTkLvrwDKMeYN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5BFZLyHUS06kA/UMfMrgtkdVYIANgjza+VouA2ktI=;
 b=AkXqL45BRM6dWY1NceTUq5S3MvICPOqXDCV38TwqbLOUbUER/7K2o4vNbI4e+P9vlpgjQbLkgvlpVg0HlYUg+YJzlvXgBuf3mmyaCynVqH/8mZMmffIbGI8KQF7ei+2H69ZiIU21YUzpBhI172/XQgrOvbtSufNsLR0T6b+Uk7ACzuk/WnbzVad80wo8zb2x1Er/wA6UAC9b+/+/IUB/MmNvq7w4iz0nw7PzsA4Mw8OtKWP8jtaf6n37NgRh3Z0pta7ZLxnrrOl+U7pYDzNNe6LVzbjZAdjaQnSZ1xpPHV8jhVrf22xX74Wt2BskxMiMbRqHgr38pWWKGCCYNmNQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5BFZLyHUS06kA/UMfMrgtkdVYIANgjza+VouA2ktI=;
 b=0Ql/DatJ5JDam4WIwA8IE/LhDsaBKL2wQcm53Pt1p1OSF90CApZIo5FId72iZHFrhgqdkDeDZsy3bFQ3VkPD/bffYIvnNKeDAJR+3sZHGhcaJ9sGiGw+uVFEDv0Ab+swSG3N+ZZKaAzpLONCUE4bzJA8B5Z1wdEGnTwj8ciZ/rA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 107/159] drm/amdgpu: enable vcn dpg mode on aldebaran
Date: Wed, 24 Feb 2021 17:18:07 -0500
Message-Id: <20210224221859.3068810-100-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7e6f791-fa50-4b62-0e34-08d8d9126918
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798A49DCF1D63E5A9BC8180F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUWEnl3mWqyRgtjVRioV/bdapGsNzPoP5yp2vLLJGmzPBulLGJHf3RKfINCVRZoniI8SJ5ADvyTbiLa5PIb0VqkP+9VlFTiHH+d0tMPx+1KlTCWLGoTrSAhq3MeRyt4tmgl58XS7FsCCany1KcxyiqIwKcQAsWwGHCCKMHc6+5tSi3iX2K3gPofRs3uPmydg2ZiQ3yxkbmEB1TOxGYhHgwsyVgVx0zpQKazDzGdLhf4DHjBLmmIAVMdkZiyz5c4qgWfOPFCTP8IkDH9W49Rr5nV2cdXcMobHHSmvbP7ANPTIV4v5iMP3KclOI3qVeMelksUOsjxzQSm9HuqdwVSePMT8XPRLr/vx606nsais7jtU1DEfK+ez4gCjlBn9fstyI+MdsmmQgBVVpJlyaesMdwXSLex/t0NqFJaxkGtS9XvytKbTZFefjrqO6pzo4/tDaa+8gdlFUvsjTFIbKAACR33HEsuFCZvLxxwMcMLDd8C5Mk1bA0Ueo/2AcZTvHmeX1ezdUfhKlqMZEfIse19m8ts9W3VvfynOgBknyLIQk2WZOVo5JyqYydd+6xFpujLG7/2V5DUTRep63kEqEcFfaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wwl9Uag2C2tc4z9cRuwBpoUJ6hwtZBOQ/7z+eEnwACSFavuv+x7UBM+WzZya?=
 =?us-ascii?Q?XWVLT6oSKDJH3+0pIMOAfXYYhKmm45SuBxww3UfQ5+uw5UG7WtvyAvz+2ASd?=
 =?us-ascii?Q?0YGAdtbJ8vli9ZJ+0cylPWtoQ8HJPcddrSo5Bu9w5HJMRqKMlmCCi5OLo07G?=
 =?us-ascii?Q?Vhcs5J9afM4JAM/hfaadZs7ZsZzhCC4dfjlh2s3pTB8GQH8L6PdKTDGqr7zZ?=
 =?us-ascii?Q?JVTB/ger5rwSe0C/N/axEa6kk3PvNwkBDTl7SkIofnUraMwzj1cDJQ/OW+3V?=
 =?us-ascii?Q?2cLFzPdhmkF/t6kRWfg6OpBbnjf9KLNCt1MguhyHDSkMk26JcutBdD5pGMKb?=
 =?us-ascii?Q?h83pFZsSRRnNVWa8SEdFqFLyr+FrnBwLuqkp4H6eYbC2Yrk8Wqwx2eoLqGFA?=
 =?us-ascii?Q?Aeqlg2Gz5tRyJ0OCW+w5vun5icebDerOrj4na2mxd7grK/OuCIsXhEtmo04z?=
 =?us-ascii?Q?d4wNkv/XhdHOUV/pC5lmj+UlYIKw3CQ0bElc86Wljj3ijsECx5mCwu2b4FsJ?=
 =?us-ascii?Q?58xl2hRg5oSVFz62WItl8K03P263mv/TEqHeUecTg1/q3onX0aLRIj1BTVwQ?=
 =?us-ascii?Q?7QFO6RKbLE4ooK572WigzVfqGRXoFbY/IHiJsMElLI/sEgPGfwSCErA67j3U?=
 =?us-ascii?Q?GKftdygDMgrxlRygJzUk11bAs1uQkOj+zBJk1NfMg5ldpWB/ZJd2gI5Q7d7U?=
 =?us-ascii?Q?68AJ79t9i8fic4lZE9GeROb90u8UcnKbHxxGKBF7oRGRqk7Hc+NnC6Rr8EkW?=
 =?us-ascii?Q?m8RXmSzZR50O5iXLjShrPNDwaGiHmDdRDX2oPEfKJI3VKQvBE5hzzMclEpYa?=
 =?us-ascii?Q?YJd1Up9RwApT82RS4Dyn6ggnVzUZaqVwRdjj+GWndTSwAWwQXnMY7164Yc0U?=
 =?us-ascii?Q?3XiwvZ7SKXZ3rhfIqjUk/yCDcM6W6xQsk+xc/Jci1J5tNwOFEwAz4RH4HkBU?=
 =?us-ascii?Q?p5gFd+AdIfMChcWBMqTwX2zQgbNT0lob7BpbscdG+DQN/+sYwdIj1pTRQO2w?=
 =?us-ascii?Q?ecMcdo1p6yauf+4Gl/WZO42oX3pT4cotuLaHKktSBm8gMa684qSTwp6hf/EF?=
 =?us-ascii?Q?Mr9kDXDPlvfEC4sioXMBjoDvEFaretq5NkyvmgfhTiQI4JLeXksdMiy64VmO?=
 =?us-ascii?Q?n24v52oaMgzzlbPwdI4S85KN5wT6dsWnHSBkhVnaMZNihA+JDFUz0V41uViH?=
 =?us-ascii?Q?duBcArKVSjwG+zEGtLBvfj1yhZYpTrxnMZjvIt6LMtlfNYDvKouxTzac3Qv/?=
 =?us-ascii?Q?Imj4TKdxRA8VR40DywvqKx2maEuy2A1SdSqB3cMKeimFYHkpWgP4nIcqQod8?=
 =?us-ascii?Q?u2GyDLJOMs3hyquHH3ThHXfK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e6f791-fa50-4b62-0e34-08d8d9126918
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:37.0420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA6X9//LPq4LVkmxH5SXa/RLHxaRQIBF4vs2QRZZXt3uesm+iK7xxSOZUXznym/NF5JWBJ4CBSDTk1pj5D65RQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn dpg mode on aldebaran

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index ad1cead197a8..d10d112976ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1256,7 +1256,7 @@ static int soc15_common_early_init(void *handle)
 	case CHIP_ALDEBARAN:
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	default:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

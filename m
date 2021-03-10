Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEAAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 20:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA9964FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 20:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA9964FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DE06E2E6;
	Wed, 10 Mar 2021 20:51:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F8D6E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 20:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL3h0fYYUequEKeEYfBCEDwzqYFwpkfNRJFwnuHNa9zlCNQ6xH+yR+LcfROg5tj6EZS+3f+lLIEFcDk5UXBXIOnka2rRFnAieiwXzIM3sJ7ybHRX1727hJhbFsi28fwsZ9pFk2pjo+DDnsfSh39aBB71Zio4ezXsfvgmvRTNT30zhzI7YIQ9YFYiQ3XluwvW27PVWnQO+rvmleSdrp/vap4MOIOuxlaVSoJcdApXYh/Iiw6OLV4DN6iX0B2dyOVN/kVQo8DRYIZ8K2m6fVj6kQ9ZP17CyRQCwI2IIzLWnHlXUMeLFzs/3qIEypNYiWK6nZAlv7Iu6Uj3u9mwBPeu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pmNXZmY9I3GgV0SwO5ymvCHsJqL+3QwObwqf60Mr+E=;
 b=Mlp9Ve1Mh9SMTdqZSgX/OTeCxgVm1IrcljRJsMuagyxr8G+jTLuS/hQTXBemFWGamirTCIDYBz9xbUly9bOKhG56hGuDrUSE0/TVQxf10WghkSIZ8jeBYHnalJdoZflG9TD5+CM/Fb/wGxmDNClHndIWaf5y7wp8boprzqOCsmZ1c8rXoCeuEa2g0DQzfB3VUrFrc7L2ssFhc+NHEJGAPYSB8yeXD+DBqSldWAqhCr2LpKybMJpMpwR7nRVl79lr1531BMQM5HnrvKUX6JcrUsJ2/RP1ngZgGI2wxYHccMK44GKGb8pVhsJdJqdHgCc2bb2j34UeAHYKBEOUG1xVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pmNXZmY9I3GgV0SwO5ymvCHsJqL+3QwObwqf60Mr+E=;
 b=alCygyLsWx8KbatNqAMc1+g7oOkMmTUAKqn1bqy2vLP21UCCrOJtKH3zIYgtM1ruHhrzbFW5FuoftWpSZjV8KD7lyYVqLnJzFEyRG0FpsvmPtLqwkEZnTloDNHX0Wkoqd29eFDGkcMY1UF2+NbFg4YNDw5wMn3/gaqvTs6EKZPg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 20:51:45 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 20:51:45 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Remove unused defines
Date: Wed, 10 Mar 2021 15:51:34 -0500
Message-Id: <20210310205134.22538-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 20:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc861662-bae2-4f21-c59e-08d8e40650e9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108BDE8EA223E948FAF4074FB919@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oq4/4suPVom1PgpCSQ5k6b5TYQGmNMS6M7/1gNAaG7vMdoPWbVLUG6MFkVmPMRxvp37p5sDX7JYjtZC3efqaboQMrgqOf3fVE4P60UUAlUhMFDKGHaPGU3P8Sb3BUZRyYC2fR6iHpmGgIHYrkS+WTlyHxeXIkq5cCe78c3L9i1xyfGUBDQBnECbqXqjYO1Ar7gjiVrcGmmXf3GcJDi4bqQT+bY1W0tezgm+yv26kPPWNFbfqzyK9nGPli1zAeS97v9OwqlFWaI3sjxXwYs6WDzMLYoy/4I9B+TLXvRlBlE5h6zDZMWvKbaGBDauu/x27vCW9URGBcLe/FI2QYFNDMqFQWQdjFArI+UN7pPxl+hoQvtCinwYUhgZZcx2EDQ3PFhMgPKGXVLsK/xeURi4X7FpRlbWz84DwOV/9QBO2AW/q6NEyNwy050mu8Xvsah9tfSarF8EJMLf1Jb3I07MX0i4Psi/1SuP8Q6Ueeg1thfRrJCjFDFSo28azVYiqw58kDdTRxGfNIINi8t99m0+tb5H2PSIeBvEG8VMu7RXfJL4dQyujstXtKb0mZMZzz//KwDuul3nd2h7rXl09SPTBLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(52116002)(6666004)(66946007)(66556008)(66476007)(478600001)(44832011)(5660300002)(8676002)(6506007)(86362001)(8936002)(4744005)(6486002)(69590400012)(956004)(36756003)(4326008)(1076003)(2906002)(6512007)(16526019)(186003)(6916009)(26005)(2616005)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ExuPp+Isoipnd3BrBEdJl2mOG1gPm1TxScZQHsrFHCVGpTJY4XrTu+PZFGsQ?=
 =?us-ascii?Q?bfQB4gMtkITvEOPpn45+r/+4aNwtHNZPNhwGnNGltnYV5avBG1fwQK21gadf?=
 =?us-ascii?Q?lvP6uEoQZzyHzGf86/y3BGHkKHCE/XIkxpoSuQbHXRMQ2zHlqYgew3JPYxg1?=
 =?us-ascii?Q?iT/IdzxUU8bf0UrecfOLmJMaCmWHkYU4VE0bemVWWYG2zvKPZlZQ1OWZ2dXG?=
 =?us-ascii?Q?D2dDuNtKIGCRqwvy6xTJEY29MOaoYlnXLqGSgwTaTQrDx5gIKV3goJDW+7gw?=
 =?us-ascii?Q?ZFN1UvDDsp4z/8ENE5SE3Egcn/Wxe32M5K1rkHIgARdiMPyWFJGeXMapad6y?=
 =?us-ascii?Q?+5+3krggNuqWUgdVRG/VMa2QjyeTTovIsDW2mJ+jlMM258pnzJOdlfSNy71G?=
 =?us-ascii?Q?phUF/434+HqQQVhlnfIvgBKOEdF0oiMZWSSTnSgoXS/Ht5Au3kT04HxYLwJs?=
 =?us-ascii?Q?6uDqQgXKB1nzNrX30iogcYGAl5TbsLdIDEM0t5x3i6gDDqQC44sSYHoFRf2T?=
 =?us-ascii?Q?cXfrh1W0hXfRrLyIFxFb3g5y4F4uzDp/GnBB6RLpUSXT81zSije4pjXa103x?=
 =?us-ascii?Q?6tmB3Vctdhuusc50rCbrFgmx+BQ6jYI+uW8w+HAX/9bI/LdqYXigREJ/3Cf3?=
 =?us-ascii?Q?NYj4kv+oDHBKpuH/HeupXZBl3cqUAuBrZSmMOqDlR8QtkSAZDHMS5e0pEqOJ?=
 =?us-ascii?Q?AVMREuH8ILeM0NOEUVumgn1xY/EoLyaYqc4CH/3Ud9a0h0oDLFaLbtiVQ/xO?=
 =?us-ascii?Q?3uPhUrKA2tj/saP+1H49a9KH7sD3SrYA8YxExONaMYVjzWp7OOR8RYWtfBig?=
 =?us-ascii?Q?yuuou4i75CbxIDcC6jJPpS91aZPrHbXnP2lRuZiNV2gMBYxueRlWuGH6ZkqK?=
 =?us-ascii?Q?2m9y8R+5NYkmYcGfHjGKNlYMZk2n9lPXW+NRxAS05td8adkhEiruWHewSYpm?=
 =?us-ascii?Q?9/zoVccwL2yUa4qamhxhYwje5CrtQ+mcQnJsweK8CiRnKso0ziYPazg9oj8s?=
 =?us-ascii?Q?tWKLBWkMKPEDYcH9vZNFI/hyph41wkBGEKtaQ2FtdJU1myt1Rx5jNdf7SpqN?=
 =?us-ascii?Q?G4+FRxnjhGpVOqXZ2dmJEleSg3g0nsvWEBlzGkU1F92WiMo2AfB7oIpb3ksr?=
 =?us-ascii?Q?JImisjG1M6+EWAzHScf3xoJSTuHYC3Ycd3HCD+VHs4lRU6e/l2oeAzUG1WqV?=
 =?us-ascii?Q?4g98K8biDqLHyINBPjpwsDKyt3jD9zbIvhZTakSYcY5AoT3mMwgyc90QEaqP?=
 =?us-ascii?Q?NDSPSVR7ZUqClcXe7z72dWlPh85wERhFxP5qMRJMyNer/sZDkwzeoubfdgh/?=
 =?us-ascii?Q?Zg2UV7WPg40EjOa3oNd2RqX7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc861662-bae2-4f21-c59e-08d8e40650e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 20:51:45.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnpP/rMLVL7enaIE/HJDKY5d4//a7rK4gVaD2jSF1kuxRJZjaPReVtxDhlOyFP43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
CONFIG_DRM_AMD_DC_DCN3_0 has been folded into
CONFIG_DRM_AMD_DC_DCN and is not needed.

[How]
Drop CONFIG_DRM_AMD_DC_DCN3_0.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2506e85a19b6..7aab4a6a69c5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -976,12 +976,10 @@ static void event_mall_stutter(struct work_struct *work)
 	else
 		dm->active_vblank_irq_count--;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	dc_allow_idle_optimizations(
 		dm->dc, dm->active_vblank_irq_count == 0);
 
 	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
-#endif
 
 
 	mutex_unlock(&dm->dc_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

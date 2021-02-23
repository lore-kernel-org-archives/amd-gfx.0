Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B8C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 21:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D44764E60
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D44764E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C54A6E863;
	Tue, 23 Feb 2021 21:34:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122456E863
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 21:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlzZRxUpe3nXZCDEi20hHtC2qTLoEIMJmVSRhHFBwb5TFnepJO1lAHu9JciUxMCz6Pu7b8F0IUkyN1MUwKZjgBPErfo8vDyGvwqDBqhcOnZMogAbk3+sV5rEXng7zglnag1W4tpZ1NQCXjesDtjvSoSxEWLnLINHeHGoge/kKep+85BhirEkVnCXqGAO3zh1Mo0s8UtmpflP8wrZLQ7etaC/6EgbvUY14pKOkybM3OfA31NKAtfXLjq1MZXAmVOjdgldypdgX++iwXjGe0ojpNRtIylMjMNYaxAfjZjQUo3nUdTBKtsX+ZWM08oAKAYt8htUDGsnCqQo7sdfGE6jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY7FogkDI0igGyx1yB0J9DPVH7A099E8t339lOXdpIg=;
 b=ctnKmxbMMIm1VaYVw4yMDha6gyb2vQhr54doo5qqeCV8qiLUdSypXgnNbm2uLhTbKFMoWgN46QDlT5Je8kytbn+6HZ9FZhocNqtnV0yK+GAhrBku41x0XycjV2kx9mgmFCZMEg/D0iPCh6DL2ESFTE4W92jrrRw2CIqM6wpm8PKFAmT5PgGqRwhoSKk6TUpPkXpOhcijB96M7PmGiqJEoZ+Iv5IrxyRI91OTDVHozDQsnMthmNfDyznIoEF7PnjPT4jctzwBmt9QCCK18w9PY7OQz/bV4R9+1s9qaFgR1R4DQt1IfkOQ1eYYgfHx5AYzQLVA4Jrs4TWcQHoDyEvhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY7FogkDI0igGyx1yB0J9DPVH7A099E8t339lOXdpIg=;
 b=eWPvDed7p9/gFCYT+RJx470Hk9P8Av7io4PX3PJmWhUMr9LzMpKYdHbGOS8k45RaAeIw8MbJ4vtM28dT3PKLEVR/V1ALCNXi1q+Y0oTF+UVAzfdV0PP43odm6KsqnMfkJkoBxmHL9ZBO8hQ/eKWzjzJrMsdzHw73w7LRC51ypFA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4682.namprd12.prod.outlook.com (2603:10b6:302:e::32)
 by MWHPR1201MB0205.namprd12.prod.outlook.com (2603:10b6:301:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 21:34:30 +0000
Received: from MW2PR12MB4682.namprd12.prod.outlook.com
 ([fe80::195b:7e51:6992:7480]) by MW2PR12MB4682.namprd12.prod.outlook.com
 ([fe80::195b:7e51:6992:7480%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 21:34:30 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add missing df counter disable write
Date: Tue, 23 Feb 2021 16:34:08 -0500
Message-Id: <20210223213408.65847-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To MW2PR12MB4682.namprd12.prod.outlook.com
 (2603:10b6:302:e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend
 Transport; Tue, 23 Feb 2021 21:34:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d07ed543-300e-475e-4174-08d8d842cd9c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0205468FC6C2499033B4768685809@MWHPR1201MB0205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWTZ2d85uutzCgx6cIDRxMIZcYvodORaqtzmO+AH5o7q4rxv7MPQ7G7k5e4d7lWiGLnCUEFpLpWYn10ztLQgYrKzez/N0nkQZghns7eHVL9Cp18oGEWgJAWG2dzhEPJ9wSAlLp9vV65qcF337p6/TxRweSz/GlB4Uz0MdAhvOm9JKeZ+g+4H1R2oe6InfW6VLilMcFV4MFIBB4Gmo0mf8C4Ruy6SmomF1+UcY0xtLtnDD5yVnph2fKa8V/ZpjqtJYp0FSHR/uGDSIB3wnHBDuM3rQCVqCYfSB4P4dFDNXUSdGKA1DnH2485hG/kuvvolpjnXA/88NA1+VWWLPwTlQ0uRh1gzd6lNrQw/MJ0fIOsZs2HK5yE9btmnhrsGtWRuOvIocC+pkkUnhgrxS2bxnS43eStQpg0pghZAVnk8SdNvijVBG2bn6+ViZIG1Ch4cu4s9g3cOd1+EHmjn/tRw5URu0rN55gHGF20No2lth0+cLA/fR4wDNlfde8APP+GNfiTWh2FFcNcuTx0Wi4JgFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4682.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(66946007)(66556008)(66476007)(5660300002)(8676002)(36756003)(4326008)(44832011)(186003)(86362001)(7696005)(52116002)(478600001)(6486002)(8936002)(83380400001)(6916009)(2906002)(6666004)(2616005)(16526019)(316002)(956004)(1076003)(26005)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n1txjfEhRcEdhO4WlURAOxl6L52WQ8rAVML4qg9ATC/vQ3LOVoCVnr4pTXPz?=
 =?us-ascii?Q?IRANjrnkpbnLqksd+EwXlpB18FrNw/E3C2l2llyaZyZgFJsZEuhZV00Q3d/v?=
 =?us-ascii?Q?cHYJYFTJxsq57BuAhpDKkvzM+sdXIQrjkuqRjt/5ZkDd8ZNhDvaHphF9FYwM?=
 =?us-ascii?Q?KsOO0YGxPY7vUexWxgEs85TKxXvzlCYqqbtUHLVlnnyfAtALls3GG0/PJyjB?=
 =?us-ascii?Q?beq7KhzoErj1Ojlf+bqgUPTosrjpdcAxD5uXRK1jZiZF1EN4YMVFrGHeRYGO?=
 =?us-ascii?Q?72pJkHw+9i6PdvgB4TmHQAEiq2mu/yjM4hjxyjgCFV2I7GdaqQnortZy230O?=
 =?us-ascii?Q?+fmqh8RAl+1pUeJ9cqd1/hFSXmcDNRD6zSu8pDCJC2Ym3OHXpVhSOvVMSYn0?=
 =?us-ascii?Q?tm7zXNvUwW/V2sw5MJrWzFkfsyqpRXBM45bpOTbWbkhupG03hSHCEnVKss0m?=
 =?us-ascii?Q?3ry4+IKW/PaMtZYdoXOLaCWGe18QQRGTXKlEiEuu2v/lvx9PR4ipJw/tmfVK?=
 =?us-ascii?Q?/DZWW4MCEgyYJP+OOmWuAzh1Po8qXNi6eOzHfTxBtgJm5docoyWhgk4cJXGR?=
 =?us-ascii?Q?7V2uXqHm+W2NASBhCyLTSIIrz0ev086yNgFYlvAYQU0Bt0mIUjnFNXIlxA6O?=
 =?us-ascii?Q?ci0uIqDPJ7gHj+geulhmS4A/10R5WWvCy+GAIzU2/xVt0uOHzFgEJyGL+fC3?=
 =?us-ascii?Q?kIW2JrewrOcGAy2QlsnrT+TWb1o4VQTn8LAkdAxZI2wcJOdhfWUd60G38DeY?=
 =?us-ascii?Q?JGmB7x8SzuHXfKEngDS7lPXrW/pUFfQjrHvauKVafDqmCwWW350F6sy6kZVR?=
 =?us-ascii?Q?ajzJI1Tt90LCFHFc2ij992EWMXe8NZP9qTK4h1BEDDKr57Bl+x24UiCw26An?=
 =?us-ascii?Q?OPv83vmwUT8cA2dvNMl8zzD3F+KR5Y9/792xCSEWF/9iZ9qEL7K+gIOb50bg?=
 =?us-ascii?Q?Py02y+2qbyX5aIH7XlIqZa0BTuaP5Em8mfsmx6frszdPrTMeo2/wH6yb5SLk?=
 =?us-ascii?Q?WzVD6jjVIytLEQwI6wlf5lT1t6dHAe7Q8RoOFfTqnzrcl0XZSVqHboc+SQIP?=
 =?us-ascii?Q?RY59fTxvqncp3BmV+wmXXL2u7L9Qs9Dt5JeLI69NWiov2ZejVUQ5GyreUIlA?=
 =?us-ascii?Q?OEfBWfo8Bg+dsqYa7MGBKRXIOm8XmM7mmHjnFLmD11t4lFYKD6iz0cqtMSi1?=
 =?us-ascii?Q?s/CmvaX1YVyaBdb215DGACxg2N3DYmRTjFqAOH2viThOxKWBNbVwH/IYDTTl?=
 =?us-ascii?Q?g3C38b+aIdTyMVdBMbFmCSMppMMJka5j1W1iIJ7CRjUXJ1NThh6l4h9Vm6Lf?=
 =?us-ascii?Q?0WDTm2G2gVzBNInoMi8QFsz3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07ed543-300e-475e-4174-08d8d842cd9c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4682.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 21:34:30.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skyhvEjGa0lau7zuvBuQ1i1paDedEgxPbFe0bomaM6n8B12zPdy7HK0dHKLonVm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0205
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Request to stop DF performance counters is missing the actual write to the
controller register.

Reported-by: Chris Freehill <chris.freehill@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 6b4b30a8dce5..44109a6b8f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -568,6 +568,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 		if (ret)
 			return ret;
 
+		df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
+							hi_base_addr, hi_val);
 
 		if (is_remove) {
 			df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

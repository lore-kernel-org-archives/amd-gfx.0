Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F44C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 04:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F392823A1E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 04:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F392823A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD03892D8;
	Fri, 18 Dec 2020 04:44:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA269892D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 04:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjPY82RUZmuGLguhu33qvfhAczpdSJHG/2up+yQTYH8JCJcZmOsz7RlyKoAjWy5fjBqar7VXX5q8d/1l92zAV/ea/Vhl5hF2B3KgYiQOC5vtVGjZ65ZdVQp5BQuS7ognsKKB+Se3DhcsBylthPxTSDN3b+Y2Q4uR4t30Ek4Fm/GY5iaqdJjpJodhitarpb2PS/ZRKqMbdRH2nP9QU+My7OMCPOwIn66k0tQskMW3qRmsgSOhfryT0AxENmpcnDdrSuRrMwatpyKbM4k+rgGXvTQAnzb3x5u6ww1GdAKgRYAeGMWtqYFCH+3F5ML3o4iMxxx4AtvGF+nkh/PXsXA80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDnqN1MwBV0sYRtasi2jNdW3GUmqy0qn6JmoOkChm9c=;
 b=O5NzH0gpqJ5G8mdcdg2PAs+xGQxganS4IZa68SDiphEuIHf4Uwdmph4AcaHlDgRnBGkTgvTNJ1wZvv9mQbevYfYjjAJDwf1+scymNr3JD+6Rlb3IuhoIKh50xTSJ/yknJnU3M1at5szRxW4+771YFUCLR/BiZjcddjWZ8hDZQWB/wplDzytOiNqzliNjZtmeRPtEO/IHLL4cxCILr0C6LaIZALwexEqi/q3iCSGTSbQP8IzoyNnRdkyOHuBDU1qm6Ig4s1uj4Lb6BCJ7m3pK40RXouziBrN5NsisH30DHXRH2i6EZNHuL2uKktDchH/gzIspqcbKBtGQwKqiehctRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDnqN1MwBV0sYRtasi2jNdW3GUmqy0qn6JmoOkChm9c=;
 b=xH7vmrHsfeJ4z5WvGH531jHi5l1Qmf9nEZiLlTIy5c8Qs3oSESw6n6HAyHvxvcgwecUy3yjEQNP96wDzdGjzc4xZzpj8vITCSl6VdoR9pj/lKyNscRs90/YbFn13U6CiW+LULpEZSFQaWbDC37cZNTxKYLMv/ZjbrF8NQwiTSSk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Fri, 18 Dec 2020 04:44:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3654.026; Fri, 18 Dec 2020
 04:44:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: bump Sienna Cichlid smu_driver_if version to
 match latest pmfw
Date: Fri, 18 Dec 2020 12:44:11 +0800
Message-Id: <20201218044411.109708-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 04:44:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e1c350a-c9e7-4710-d103-08d8a30fa049
X-MS-TrafficTypeDiagnostic: DM6PR12MB4387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4387448EABFF62D09A9EFA39E4C30@DM6PR12MB4387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4kbFiElGK5B6PcwbRJgKsNwJgt2zPPv6fzVQOoX8l/t0sXoA2W79isePuNGCHyJ1AXBfsxBHw8gW4yMyirraCT7yLysyrrBhF8cekd+iYRPZg9OhLNpdFXw3ne3nrsh2I6XrrKpZh990oOYYhuG2eNIPt5lUOkvZ3V69D6Nuea5l/KfONUkdjDT1mY7dtA9LX668SEMVvuVHtvlsXAclHxuS1R0p2tKHd7DfKjt/3D8wUlqjNAyINiJMp2HyxFRw/ymuTkNuBf73wYLzc8jQUQgT0pEgpnLdD5gVnECNJtb3hGsSKWlLOY5tDTlmmQJEij7KsXj3qIw0P7rzp2zvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(36756003)(66476007)(66556008)(2906002)(8676002)(316002)(5660300002)(2616005)(6486002)(52116002)(7696005)(6916009)(1076003)(4326008)(26005)(86362001)(186003)(8936002)(44832011)(66946007)(83380400001)(6666004)(956004)(4744005)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cXwbj+KyiYkxJ4bC6V9sBs9whzFz6Q82jHiEogUFNh4XYG9bHhq4R8CxxKMp?=
 =?us-ascii?Q?pAv94ncudIlxj/x0AEfVrNP+mjtqHrFoiStpAClRMQaiAlFVw+WVVNpNgeyQ?=
 =?us-ascii?Q?mQOW6vNms/lwBpfSpVWwQrkJGbp04NYApMoTzu1qTx+cjsN697M5STQHHbrU?=
 =?us-ascii?Q?scj/5QO5niIIo2YxMPpWFGxElXVLWUOiFszNuKuNFFJcFuZkajmmaaZuy5n5?=
 =?us-ascii?Q?+/z5CHNt7n2SF/2g0NMGvSt8FtQoI32sSJNl867VhiXKkRyjaD+33w4Z+fWJ?=
 =?us-ascii?Q?4BbNenJKXB4S8phAsn4CM6tLFEPipZ8WCvNlViZpXj4QM+QKFtkaNgXGcBdr?=
 =?us-ascii?Q?gMn8sQvDH+6nNuPdjsi3+nMf7Iwet1K2v7w4h7uYp4PT4XqrAbRmrSdRLV5k?=
 =?us-ascii?Q?GkXwGUopDx/csEjyYtjwLEtqVfqw9761nk0pQOJ9O5ug/6mmOoID5sTvQTi9?=
 =?us-ascii?Q?vDgLPfWuw1+rhxiIe9FxPdgKR4smtZG2LkOjzloSWoqsJMr5hfIPug5/eqyp?=
 =?us-ascii?Q?kHQs/uoqEV92yKbaWRw/yGNKwSKlSNajrGpmXBzLSgy8OGpjt2Jp1PlLoYgn?=
 =?us-ascii?Q?YxqpIR2JjVV3KfhXmKj01khUAOGbXA+Ls7jWcQPKoYWLSWgsPt2373ehDQFQ?=
 =?us-ascii?Q?PDi2BkR8hR8F1V3CvaSQck0v8g6Udj+GS4l2xycNTJm+kr4cpbpkrRUTWSvo?=
 =?us-ascii?Q?EzGkUzxFVuQwg8Nxh+2gSVC9FABg2j6w4q8VRNT01OGQW1YIERPnizvp/uS2?=
 =?us-ascii?Q?2PoVnFkq/MuZJdCxUx/K4uquE8yBhGxtTY+Mzr+W5KeNJt02LFpiulhlMR3s?=
 =?us-ascii?Q?xAr1YzfA7jxDr2KFcB2hNTLSydX5leEyOFTvP/MmFmzC8WyOIUW6vXAgxbzh?=
 =?us-ascii?Q?1BhZdym8rtPwiDRvrwRP+N1nyHJhJ677tb9u5cWQCnVcm9o6ketslGPd0Dso?=
 =?us-ascii?Q?lsfEg3gBQL+D6C5Yr1ugsPUUtQzChM+Q4q6WBv94EqoBFKXav1xFQdOhSb0u?=
 =?us-ascii?Q?aDHH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 04:44:37.8696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c350a-c9e7-4710-d103-08d8a30fa049
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv23s8r0lAp3T7i9B6q0iDFjeVm/xsmaCAunVW+XRZ/61tyu3CRkZ5diA4ld3XG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can suppress the annoying but unharmful prompts.

Change-Id: I50bc5f9bd21572f51af4ff4c9e1946d1a441b714
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index e5aa0725147c..13de692a4213 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

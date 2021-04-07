Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B127DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573066120E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 13:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573066120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7D66E0F3;
	Wed,  7 Apr 2021 13:05:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6720E6E0F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 13:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2GSf+GVpvIPTwNl9UqsfS/cdEBFdlmt+JwG6X4ywl0V84ijnbTcHsArk7eXR2jZ7O3C5vrYURhxM5HONH/k5ASQiX/vmgoUf+jB0SgOuMRb11hCI5RcGyxIFIfnFRGKA3PDjVFUkHiBDAB2tNagdOzXBZ8jeWNp88nV9pwIVw67IcxSDJrjthoT8VyzJkJA1iPZ0rjCT7fTr1fFsIDA+tJrJHdAGc43lwx8b4eyiZpwzraGe+o0TvKrWJuHQNERgL54IMyAg1xVBU1oy1sFx3/s5rB8fot8W0zoNxkW5F9bajqGV07b8uJCVh9eAzSuHzikUcEzqV8XUOcP9OithA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04+ok1+UbV4dQEqZhQB0Z5NGzuvgWueFyz2cdvxHB6s=;
 b=C+MeL8v+Mv0KD6I4GW+pGNlXSIoFUjeswyXqijcbq3hGzSv7ZYiHe0ROQTuDYJH0kBp3+JHzcnGFB5GDIYud6MOsUMRGeE9XD1L51S7KO86H2MNrktco8y8mWxNJmPCwxpxpkKMMav9VNLAOGPQKN0ISkxb511TYgvutD4Yc+bjfNlgtYM/TnIsb5tKVZxtZugEUYBwH/Z1wheqo5rzmZWpU5gV7X6mlzbzDDTReuyoE1rXKj5Zf5WTfgfCGwLoCNeyQn9//3p+VKLzDDz54LNClUzyi625Umh4G85GNkBGf4JXh0hWhYmpUV+DuHY5G551nvhno80+tybpEMdT7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04+ok1+UbV4dQEqZhQB0Z5NGzuvgWueFyz2cdvxHB6s=;
 b=f69BXMvw8DclAU5keIXcq1PTR4yw/TX5EsLH/vIQRhZYi1Zq3KBykoqTFOqMITJzXi+mkRAq51k/LL2qcVKwJRJcNC2ffVQVFJZ7xvakMGVqhaXBDDmdVNsIyjQEz2Vjro1ipK+LNoZ9i0HJlS8xa+vr2myKTIAnCHOIrRMc+9E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM5PR12MB1852.namprd12.prod.outlook.com (2603:10b6:3:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 13:05:29 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::99bd:b7c0:520d:92dd%11]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 13:05:29 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Fix size overflow
Date: Wed,  7 Apr 2021 21:04:50 +0800
Message-Id: <20210407130451.47920-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 7 Apr 2021 13:05:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e505db2-e3cd-44c5-bd84-08d8f9c5d199
X-MS-TrafficTypeDiagnostic: DM5PR12MB1852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18524B1EB7CDFB569E51F7F287759@DM5PR12MB1852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbnJRMyEXMO5CILRPcDlmnBJ6S5/0xs6GrDb+au4jBGf3zdDQeBkOms4YBZ5E30qj8cFfG9GIuiZFlRluZ0ZNE5vsdA0k6lH67gqwe6hk1ouecw11Y+EtLebGIu1zo++tE8/D15gHB1tO2i3DBDpZT4f+J7L7faWZhvS95Umz22zlWxkXdKT/m8xx15bj7tb+fRyoap41ejMUaJaJoLfXNJYvo+GObYUfKdvQYqfluchEnQi7qKTaEbEV/aMYEY2m39v+N3L9trkPomFCdI5M4OSNtIxmB5xRcg+GLOK4IkntP2TM3aqs73663AI9MsDm5jlUo8Lo1Cow9hg7SF+s0oTK1ZUUoq1FiRmOvD/hKAxRdr5WmGOr7AS4H+ybgGTcDL/4GKOUuoH3ehSQG3TpwJPN4bAUv/hVmN/x8db9/fbm7eaFgEhqoyu6Vq6IwFRrTnmGNHs+uXnpKkGM4eMnXEjoDW9jdtkmOYjMdRR2nrey51hNmW+GAx0zo7m/1C6N/o6ZxOWUa925jHGGg/mD+kl3KsBQ0YsQH/i6jqP3IWwucc69RDv4tiPGR+gX9nTfpM586S5i5N5WF1eV90CPgW6T730DVPtHKRmT8A3f/TE9t35Ra629CsqmAoX7vvA8hssXT746VUHWtEY+nVCco0/QE1YvOuDMrysZ8KFJ7CWn6u9z9WnnCLv9JtnbS60
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(16526019)(2906002)(4326008)(38350700001)(83380400001)(1076003)(186003)(478600001)(66946007)(8676002)(956004)(38100700001)(26005)(5660300002)(6486002)(52116002)(4744005)(6916009)(7696005)(86362001)(2616005)(8936002)(316002)(6666004)(36756003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E9RG3Zji84yL/fsFWsm3k7O8RHEiCci3NdFnLD+9vp1SPMpGgqMlsxwP8oFG?=
 =?us-ascii?Q?t8l2/enRYZkluNwwhv1YtnKF/ujLXeIEgLEYcSjEUGPeg20uskOzvuYNoLeU?=
 =?us-ascii?Q?lUeAoc7WHTJ67ugeQLfCRJgRIgUP1o9my91dbc/heYp4AHEOh81hqrKe1hLv?=
 =?us-ascii?Q?iSMyl2D80rAkvEr/A/KQqRZ9tJpt/OaDAY2valufZFXYVxAAAybPNfYFXwGj?=
 =?us-ascii?Q?n84o6R6plWKXXMz/KIlLWSCjsp0AauHTR86bOGAbp1zmX1+yKoM0UULwQouD?=
 =?us-ascii?Q?RPfxE1tP6SPic+e09y5cB0fQ/05UdTFGCf5xpxSDXnFKHPY2CCuYXnJE2FMG?=
 =?us-ascii?Q?YF5epIh0EAijaHODaMO6fNDcZKRh67Nv+s2QGabiRBuVP8+pBZ4FhxeMVpvk?=
 =?us-ascii?Q?EnAboHNujYKDPwCY66s+3gzGKswEQJK6nCJR+Iv/aTG1S1f0ebndF3KBckR2?=
 =?us-ascii?Q?R4h0jHu4zUu/raN7pi9DZxGMiotXt8oocaO8hOfAKQZq+IG9V8/1Ar3iwZTw?=
 =?us-ascii?Q?1z+g8AfUo4z9tRUW++Y8SB1LVZzoqdZnesWrHf5/Pv744qkoBw147rdJyosT?=
 =?us-ascii?Q?qhSByD0EnMp61tJ01innwwmRMDJeIAju+u4Bqh08Yg36+bY5om/Up/s7LgtD?=
 =?us-ascii?Q?/ZviAZuLQqUQfVA+ylvc4mr1T6BEwPOMF7B8iG2gm4UgGyeFLok5e1zW517Y?=
 =?us-ascii?Q?EaWHe/dV1K8WFjNv5QhGlpL+Mk4j2HfQ/lS5n2ujb/xKBjWkqJpG8lXOxxg6?=
 =?us-ascii?Q?rjQWubMcjjTtpr9xWMMn1vfr3XRbPNpOyuVGvL2MUmKIGCvkurCDPV5q8IwR?=
 =?us-ascii?Q?EH8yml/J0IKM7pcCcOPryaeTm0uZFGaAWzxozQOydYy0wBE+LP3GkMvEOTGC?=
 =?us-ascii?Q?TSnvRVQfaHJecSVF9HIcrN6T+pTHVowoX+ZAN7ahP36Wr4E6ZeNRzSMG6l00?=
 =?us-ascii?Q?qhFAVSF64grxwa/K2h68Cdnt+UiZOGj646q4na5UtCSOr89k+1c5Ca3Iao97?=
 =?us-ascii?Q?Wg0Kwtd1aB0lY0frt1qM8kxNYWmc/lG49CxJr7IXSC9fAjmqD/vU56OOj9a/?=
 =?us-ascii?Q?Ea6KmuQOTz9uVx8UKEHqoMKuAhUqi07/JH4K1TMCfO8NCgPEI4wiRZSP/5Sp?=
 =?us-ascii?Q?qhaavnUVzICKctC+34ttug82Bewl+3Xb6auS4289Bad37zg8UbSRAmXb5Gmx?=
 =?us-ascii?Q?0oQ1sEMZ7yFtpAQ3EUWCnAXDKAwCkermFxgviUNDXkihJKrD2ObK6HcXqrzc?=
 =?us-ascii?Q?vU7aoo3s3smCERoV7Sg8BeZGZVGUxcH5VxPBdpVuSjaNAAfJISt2509kMdGe?=
 =?us-ascii?Q?289rQwvYPZq54Byh41HfVqE4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e505db2-e3cd-44c5-bd84-08d8f9c5d199
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 13:05:29.6830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h431Dv+8mmmSBTuZ45GtBWMTpP9iqZS94x3mfPfo80jcbS8rbJT0qlLdqqnW+S7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1852
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ttm->num_pages is uint32. Hit overflow when << PAGE_SHIFT directly

Fix: 230c079fd (drm/ttm: make num_pages uint32_t)

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fbaa4c148cca..936b3cfdde55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -830,7 +830,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	/* Allocate an SG array and squash pages into it */
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      ttm->num_pages << PAGE_SHIFT,
+				      (u64)ttm->num_pages << PAGE_SHIFT,
 				      GFP_KERNEL);
 	if (r)
 		goto release_sg;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A301C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3204A61A36
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3204A61A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288CB6ED64;
	Wed,  2 Jun 2021 16:49:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E706ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NekLHpWyFa0VHmUgcJP9Y0lWL/1iOGj3lGaZJR5taCOdTPWgp/jEo3DDP0ABznVSCjF+4loQuUKZjybc15st+DV+p0iVC+ze30pP8991HKJiXaKI8Oamf0uyusjKqaLb8VbsQrBFx2WN6QryVcOwTSiigNwd2WZYX7F2kENCYDrqeVjSWSWh6MJPjw7wpWyrul+cWw8Ts7HSaO5O4xnSJGI5+t3IAJY2M8pkIgR87inT0sBTqn34+g6M5KrP1da5xEfQ6x3+zHv+PQyeTs5L69+pLjgFglBRbMaVFderP9sALQkoW80AT9F55OafrHWvb2dpqNpUijq6Ucfvihq8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k66rOEtlb8mydM8oAgo4swC63/waIIKGCvT0GucKfwo=;
 b=KjwIxbcoqUGWjJ4TmghyuMREbHKDoFThA1UjkK+FSLR4aYfVX8iOYdunq1RmfVl8K2A8ZGSlPmghfjGYZDAikamQIKiEypmNf4CtrVU06k5ViMjRtGm+JamaVOC6Cbmh2un65LZSFq1nFNQDHMSRzSvWpNLLZqeIfjzCzswgpKQhEkeT8enjH1H+ryzyHQQ5Vt9y9Ryc8sQk7nJpNmbN8S8OnBgtLgljvWecb8AYFV1r7WNrLPIVFdY3zdUma9Es+YzkqjIxNLfBQXCCDzy7D2TXO5p8/0s07oMYIOOBWqIatSAtoR72wp3eCoxsaET7/Y1vFrZaQFMHYyD46EPtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k66rOEtlb8mydM8oAgo4swC63/waIIKGCvT0GucKfwo=;
 b=uOAExWcuARkwhZhO1L9iTie16Rkq7x/CoqW89+KkBB+R3YriXmRq+Lw9bZdrLzYfipVw8DWGCRIkuEybhvtn06HlAT+OBwJ7bxchPLeQ/n+JyMTCk5oZEXSPSQattbHVeioAi/qdKzk8HepYoNnD6CRx3sO4wnijsMKNYAWCHA4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/89] drm/amdgpu: add uapi to define yellow carp series
Date: Wed,  2 Jun 2021 12:47:42 -0400
Message-Id: <20210602164908.2848791-3-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d67299f-724e-4d7c-3af4-08d925e66406
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077672143D70A76680A52C8F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1R7xzUHVS3eFNo2Ld+BvE+MZhFqrpqvdfu91aQdQ1RzwJZe3yU+BAfDyph6hUdhsduIF31CggJyfRJwk3ocoJ7wI69VsjCvCwC/8J3gD2uLUTx0sT8i1NFvE1lKAdEd42DDnsWwlUgp/SwFeNJIxps5rTXZBUzLfk5IM6DEUkaNIaOevfggEF58KAfwGFswnth7oVGQbbuvEMhuDHIMXq0kdIYVHAIZHI0EZxD45dtDaomTXZGF3+AMfP9mqSvvpWvk2hvh+aeWp4AlLy8GkZrj48L1XaQho1vNDfwVqvzAnB87OvcroTrcc07ega+inMLOYA/5CD7frGZUcPE2YuGGWIZn/KmptMQdVmhGj3dCitX8et2c8vOjuwErdwcok58Rlwe9IswufkQL4xeB7FEIw2iyhybMCbeIriLNVVUQ8uw1ZBHwnEzUphC6ZVdguRe5wFsm3/xAlqOFNm5g9w+EeyMDoqKFmKrjGvq/GsB4KARM2rLiVv2Vn9+bpKl5taxJisBr5K5hxkNN87Jj+sS7TZCyxdQlFZwvZ/hMJXLjLKOku7CSQHs5ZE0x99FVZqy5ymeVEBrTViOaWLBm4gewtn9+fNKPZt6PGL+cukLP1jxLi9RsTghpUMQBiDQ0RhA6CPi9FRGXUkvONZph6D0sbtcir20Sz9lLDWXKje48/fYR71BrIw5LYjTv8qno
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(4744005)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NaPtjEMvM0YXIJdJupT2y36uJGAL5BN3tt/gE/ufW74ASoUKExqKiwXBPFKE?=
 =?us-ascii?Q?TSFN7tnqCFeSn0lMoNpNnt+Jsv5iRcO1HzMLpwUtukzQoPZ7Xa7C4xlcAVrF?=
 =?us-ascii?Q?DLN8k+vWWcRI1DswbnTkF+LWz39d9dDPN3H0zRDGqK7A/S1Umzqpaa6EPAGp?=
 =?us-ascii?Q?2OsDB9Z8H4XQOF+tJoEMPbIIttqfX+Icrh4TbCFYYE5mxvQF2Io/sYPovPq9?=
 =?us-ascii?Q?emgKF26D5MFeceYgFPLGSzeDQtz/GixsYcfXAgv7dvit+C09k7CtWWXzN/Bq?=
 =?us-ascii?Q?rT2nx6wrpWoZL1rhkweIwAy2OqnzSn0SVOjdxHXtTSJC8RMr/ERGOs791TCM?=
 =?us-ascii?Q?LYR+kNOkvAhUUS7GqVWZMnkVeNZBvgy9XXQuM8U+d79KcNZXPiuVIE7yr1/p?=
 =?us-ascii?Q?LBQxbhdBsRJ5jaLFBqM9z6yQn0oStBnthKZAgmWpDKMcByGTDw6w7j4J9mIF?=
 =?us-ascii?Q?wnlMBpd3IoR6vVu7Iy/tFatX3AI1PLGeFpFMmiNx8u1HbjLLqDQHgSO7RB/k?=
 =?us-ascii?Q?0OVhHucHYtKJ5+Bgp3+jtjGnqK85Q0e5IFpXTEHg76QlkWwKQITYumxAgr3k?=
 =?us-ascii?Q?YSm9YsWupgzhZaH9YkxqRQ/zMR4HHvQQtuc+ULP00MsiOsKm5iJlKdhoItXs?=
 =?us-ascii?Q?7P+HUCPDfBb/FyUvAXm2lvRasmDP4S/aqZa+XSLeS2Vp4SQGNisEpAFDlHk3?=
 =?us-ascii?Q?M/t+eQ1H45g2BRRpJxVgzI30xHEQe3LS6pUpXTMlBl0bVsH6f6AiJxAUVkf7?=
 =?us-ascii?Q?BcmIavxNB87cTST1ZjUYJLKbiD2QysaL8FwOUo6in1AtCNtKRH/Sj2kIkeYp?=
 =?us-ascii?Q?NMZxxuY9vTlIGIPrhTMBME7zN1uPiLKPBFi6cVkoA013rew8p+Hgx0uQpdS0?=
 =?us-ascii?Q?Sov4auLpjSeYhQv0QvaJqctVCLf2+f0EgQGMHcmCcEzXcm6pC67tym6q+/+R?=
 =?us-ascii?Q?+rYqVdShqlGum0YUClsm+3Q/aWSSgW4BA/f9g58i1ZTmZW/ZrN9wD+BM0jsp?=
 =?us-ascii?Q?vChjWNy2h8SpCEgUq/T7kUbugsh3ac8m1hNTklHWI+Q9cxLaqabwIZ1ToX+c?=
 =?us-ascii?Q?tTayA1PjGbVzsdoN6E0dB+5DNXh4S755ZIDlXBrfT2Lb6aC8/iBxoCqj3Agt?=
 =?us-ascii?Q?GTFOlbEIta5hECOO2OFCZVDijLVMHE4bD8cllI9j1mp8li7vLp4mhU/s4Xxo?=
 =?us-ascii?Q?CKcJLePb5EPo/XnpdJAC4e++mgkJV4D6gmgVPGt/T5aYLi1fdNXPcE5NPgYG?=
 =?us-ascii?Q?TwZMpcYHMmyeoBHjXEwtuSgKTjnSCgABfDQn3Rzr9BZo4pmPDBNlFUDwVHvr?=
 =?us-ascii?Q?BlZye/bOq8av1KDfiFslpOt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d67299f-724e-4d7c-3af4-08d925e66406
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:30.1974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcUIjKy2B3z+wFc187EBJttUqZSeg8ADTeKIZPguIaqgMP9pYM95boG/1NRwg/EZEg9K6X+EuWs15dzs6V79nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Add a flag to define yellow carp series.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index f7a4f9fd2be8..b6a7e193eb2c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1137,6 +1137,7 @@ struct drm_amdgpu_info_video_caps {
 #define AMDGPU_FAMILY_RV			142 /* Raven */
 #define AMDGPU_FAMILY_NV			143 /* Navi10 */
 #define AMDGPU_FAMILY_VGH			144 /* Van Gogh */
+#define AMDGPU_FAMILY_YC			146 /* Yellow Carp */
 
 /*
  * Definition of free sync enter and exit signals
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

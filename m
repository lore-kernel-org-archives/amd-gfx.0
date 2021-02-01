Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D947FC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9544E64EA2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9544E64EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1636E47E;
	Mon,  1 Feb 2021 15:36:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811FC6E47E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsQ1O/2NVZoRXmJPGtrQAYzNnBojtMAtjMXztpQ4hGnAbdmlEO5dy5RaqPNpj8cX25z3Pc8aU8SjPl4Rv40LI9Y7DmlgX3VuLTsXzAGj163+SPNPQDiiTU42SA/Mqw9rpvtgMt3n59vRivBwtxJZ/8RN5pVbETZLWgpJL72oKsMmwbIBwQztVnVOtzoKie41dc307yuefLmoatLlE9AF4Yn1fJ8EqO597Pu1xAhywUEYmFgY3gsqhcag4BsQmBLF3Loj+hDL8J9H8/BAFXGROHorNX9KzlcmBzzwXS2whJYD1gs3+5pV7Hmq327ZKCOy4JQijh8X7f4qpl7EaNzdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MjHK+znSk5mMrOXbYKlJ1zlNorGP2hzrBoIZ9hnzDg=;
 b=Z3MwD9fkiPtyUFXZEJYCdeHeADpIhkOm2XyFmJMjpBf28Ub7sic4jzE/7Zjbw8X65i+Fm4pIL/cILmWt+aREuSXMWJjGSRlB7KxEVNKnPEOlOiKiYXx+ZsZne2s+duRD2ktupNwBiS7Y0dn2Zzx9NXy9eyZ98JlobYMZJGK06iGAfZVACBOXyzu2caFeO9iQzyyiqdGa/XKQl6HzE8lQTX0EUy3gCMVuthDgCRm0Ju28uYlIPfpL8kHbS1J6sRNhYj0PXjfSliSyFzo+v6e3rHt5U9WzpX+NEtfV//MtcCx9wMZMhdIhkoAkq1kGCPscRCAyn087HSVLcj3qKty7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MjHK+znSk5mMrOXbYKlJ1zlNorGP2hzrBoIZ9hnzDg=;
 b=LN2/wxUjH4D8QSnO2UHb4/r+Jujh9/eAxzX0+VAD1pLdoHiMf504uI3Xs/mhitGcLKdODHdzxA07GN7izJkcPgQJgANaeHgKN15YWu6bep5kN17o2YcTNOntgYMuCCTDWSjksb3+Y610bCF9pDMNuXZq/PE9fCM5KvOilfNDAoE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:36:09 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:36:09 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/4] drm/amdgpu: enable gfx wave limiting for high priority
 compute jobs
Date: Mon,  1 Feb 2021 16:35:58 +0100
Message-Id: <20210201153558.61511-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201153320.59415-1-nirmoy.das@amd.com>
References: <20210201153320.59415-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: AM0PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:208:14::39) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.32.223) by
 AM0PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:208:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 15:36:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b552e9cb-170c-4d1c-5606-08d8c6c71906
X-MS-TrafficTypeDiagnostic: DM6PR12MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4909052F90ECDD9CF7EB65E98BB69@DM6PR12MB4909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J446MngB7LTrP62JXRCKQmck9VYp7hig4NeQWH/2JQvCSATDjPHIooWuJpgUdIIdl9+94kdK9F6deDvIirETTtRzI9hhzAljNaOB3QdYFXX4DKVaJHlzGAaT8TybUIawX1jJdXy0OmUutE2sQhzh0jsMiupJpjNXM+kCcFIJ3gUdkkkuUrOp1KGH33DOM/aoX18uN3EYgDT9z+oU2Foh6FjQtLH705sTKyjDUjuXcArSvvtMyXYEq6kKXUGA6hxfPeRWqoIBMrJ/C40vQdciHZO7mCoW5/NCtsz8K6wK9Mnw41nQMVTOwB+uX6xq0i5Jy5+NT4jzsAbBZui8G5UNmeZ1TXZuKYHKj1uqU/E/3CEIPhQVMuI8/4Y7HmV1l1+eP54GOi3ZwICQoQmcUhDQmz71foFMgkwmHFetEstUAnf1zhqdDx+HP7Ucvw0v8+YtZxjyxhasLcBDxUaP//YZ0zF1x7Fq6cmx/tD7CVzQoLUjjcXpKQO8GEPPk5w77Lurr7QALfekZgxc3GaTg8NeYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(26005)(956004)(2616005)(86362001)(478600001)(6506007)(6666004)(6916009)(186003)(6512007)(16526019)(8936002)(6486002)(2906002)(4326008)(52116002)(8676002)(44832011)(1076003)(36756003)(316002)(66556008)(66476007)(66946007)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZOLZjysde9jlD9GJWyKbjC7gg6c6kTtmRFpQUi8Y6DFpJhDiQEug36dCPft1?=
 =?us-ascii?Q?MJdM4sQkUHU48YYHCKhg7I484i9p2jo9ZkoYia2b2SHAbJ1m6/pbd8ki7Oa4?=
 =?us-ascii?Q?5NyewvvgZ2B01fCKUQajXSl2XYNw8HP77WjkShgz5QY/jbtBBU0nE1E2Ye2T?=
 =?us-ascii?Q?+O76gxX4RglLQcstio1YnsVkwOCPq3+HdwrAAKXclweXPT5PqZht+90M7NSX?=
 =?us-ascii?Q?5e92QxhQcgrz5Dv42wjANpR9ni6Pm6OBZ1Z1AK8YabmwIXngUZy8zdpDNnFN?=
 =?us-ascii?Q?tWP/KeeHWA+pBwX2YFGMvzz/ZUQBJn6/iw4KGth2mYtUtvpYMJq701tMIM2P?=
 =?us-ascii?Q?hLnPDf2p+5wQiST9/8zwEmKcevaI+qLfHY/VcVO8ehorAxNwo/G443f4Azgf?=
 =?us-ascii?Q?r1H+HUQn10K7rw7zbMGxxx6Fee/08Kw2/b8VF/W/5sLRfFmknaCkfVL7xy71?=
 =?us-ascii?Q?N+rL+biae+msEBGffyhn77lgcY+6MfhYvHryV/cPFavQpqRodRQrqBP4p7nf?=
 =?us-ascii?Q?Ja7zFPEbNBYqKTFH3yBpwcHAiKFkg63gQKhHN0lWOUmwzjBewTPJ1thKfaRt?=
 =?us-ascii?Q?L96lOaGBFMSKm8y7gWhd9yp52jsu6B67oYCFl6U0rkzN0JmujDrfRzK5CBvp?=
 =?us-ascii?Q?/arfpMCmxF3ID+Ym5wGRDRgMMwKOMDQ3ZVoW2+f0AOH0VjiaZI3GNWFCRnPd?=
 =?us-ascii?Q?tqCqjC7Lxx9SpI41CvtpFSfhHap+rkV5Ha5kAo2Dpfhv/5fSqS3Nd+kD1glA?=
 =?us-ascii?Q?StSkaZpECGxbA1a35WKlr7A/Pk+22XwzIQ+TR9GOwXKJ4LWpl3oDFUd3EKn6?=
 =?us-ascii?Q?P2nESIpLXrJwVa2O+WFSKerlxGLUTQM/DCLWwIHY3XMyWzIwwYKNT4rMGmUb?=
 =?us-ascii?Q?BjPavN9gSfcyHnU6vYOcA0eJNOv4OKkMQVCZU71t/6JGLqbdzl40FI69pNMM?=
 =?us-ascii?Q?LBvkBaJ7j5n3SU5pg+td+L6AHZV33svXjvlVbGY4v9WkLSa3CrakEWRhe9Cv?=
 =?us-ascii?Q?2Gt+0ofFlJUeoaDo53zNcNe6jCGnFdFOOCBEYs+PPehzZ7CkWGYaMKwnXGgN?=
 =?us-ascii?Q?A/RsKVjw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b552e9cb-170c-4d1c-5606-08d8c6c71906
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:36:09.5191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ur5Ij/EZl5tP8Df5+D3WkJ1cbFaP7lVBiepDhIGXeV2FoVReFVk0NJs12vZOZPZH7YPmIcRl35l15QLZTDCSdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx wave limiting for gfx jobs before pushing high priority
compute jobs so that high priority compute jobs gets more resources
to finish early.

v2: use ring priority instead of job priority.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..252b413477ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);

+	if (ring->funcs->emit_wave_limit &&
+	    ring->priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);

@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit &&
+	    ring->priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
+		ring->funcs->emit_wave_limit(ring, false);
+
 	amdgpu_ring_commit(ring);
 	return 0;
 }
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

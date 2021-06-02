Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3F2C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE4761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE4761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B72D6EDA1;
	Wed,  2 Jun 2021 16:50:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F2F6ED9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwwt4d4WbdvpTw5MBEzbLVWLCVAwDbk5XFbVyjGe+lwOG8cyNP13M8LvQdh69HtuFbXSkNeDTDplRb+e2VmDkhmRrFfQ26ucEkcO02iCro3TAh+vVqNN8ixf0OgS8TsmvE/q6TIl4XY1NMjDIf3YV4urV8Qek1ngIEFOsP+z6VGM02KhHmBiLpUNW2Gouk3eT8B8T9TsbU4v5hu3RZ9099y2GsqpZctxWzJmmF4uAIMWm176Bw3W7LiIsfG/LIhdhIVwIsb4g1NTg1xBYipUgGm+AnPHTRmZII+3YB979ArvTaCR8PgoMGZ7PCojtAAo01Kj0zEDVgypy5kBOcNjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED7I1PcFyylS5jU5i9B0gJLat2l2jVi0ew5u7IBxGP0=;
 b=NYPYMhT4DMotgLOg/vTp26sYJX8Ko/n2IIqYZg7s9eETz2dKyr5auJitqHHUrfNC9izs9rhfJ86LwXLxsM244pN1qLtgBzTAh7Ks8AdN9BTpsHOOegWNRXYT86z1CHzHxFeimLap/q1v60wyah+eiJRIA64stYQrBirb3LzU4hzmkRb54ZmEp5XmLU24wysubjsMqZX9LYe/ygJPF63rMueo77pgAE1p4GZ2MzlS09iBVto3vYsHWTO998FVkIghbHzs8vkNLwEAGIEQpCrscYx4PYNjUsipXgcxpc8ez3UCkuvokE0Ie14jZl3VrtlGfna8hiR9skhpF14J4eWQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED7I1PcFyylS5jU5i9B0gJLat2l2jVi0ew5u7IBxGP0=;
 b=0Wu5/+cEqMYL8FP4KcwlO1wkObb4UT6s1FBCFFHo91E4CaoFl02G/4SWrbQwJ20kmPctpXl1jhPlh8HuPnycGxxiP4hqfyvzxz+Fe7FrdHqMb5Cyj+yVSuJ27m2NgDqNqIX89UF6TCZfqBt5lP0Bcy3hCBltlD7cGTvnbhLpLEI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/89] drm/amdgpu: add ATHUB Clock Gating support for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:17 -0400
Message-Id: <20210602164908.2848791-38-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d0f7078-16a2-4be6-47a2-08d925e672df
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46750BEB484F55C1E95ED9C8F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qnzom4aBEKHxqGz/7HP9SyXyS+2rlxVtBXJhWD7AWcmVeNfrdG7uFGVZzEtH/RTANqPf7QJJmXyUABMDEIelGuKy6291mvntE4T4w7wyKDXphJ7bnNpZVn0hmKKax36YeEzMqJ72fTHC/p9KmG9Efn0WLds2hNzD+q7i6P9peuNsLPEtwNN+AF5hkG7o1ski0I524qXtgHeqU4AltR9R05QZJlnLyHWDyNXVTAlKxBKk02LS1Dl0gXcBkiutjIeMRJxtj//AkcaIzXn6sQ44lxPFTGlsXqsobVB/amP7k62GSgVrPr+ftHHPvdPYdHMwnx1lcq/RRVP0vRNp/fPdbF3pkLKqLutERj22QnabqxCc7MR9BYn5NKQ9dy5VAj2nF/QsVwrzGYg6t57qFeIpL1GLY+LdZUHdrb2GZNUyLvLgA6dLEbCRaus0G8w/vvTgUfsiEufUqEyXBzDUTLMiWwDbgdv07dQ5twm09ynWLEGb/Y3TVL6R9oTJt3LLQtSkQd+95IES4xpiAKLKHcZm/9E0b1Sp6E0HQC40HgWD4FQem7q8GlLPhSB+jotSIPwZ3/tSRwc+PrIo334ciwRZwTDCz9GDeMb7Xd38y1hG0TgFoQ651Xc53vO8+6yf3MZOa+n3wNrj0Ntushod3AgX1PwdyIPCOcEOdZcEk24KRTLfNwvwiTf37ss4hbjkATEB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/8hex/jU/YdJZaF9gM8MPxo/yNHIlysFKjs2o3Kb1LdRY+eTj5jroWHoBMpu?=
 =?us-ascii?Q?0XAf1AlpV+fIAyVKBYDQLZ3Ux4GtIXGQ6Qalpq7jt1BfMz7f1zLdtKXSL/SP?=
 =?us-ascii?Q?4Jmj+I0Z3WnaX29iPiFtIOmdbRwnRQ+kbmhe91qk0qQbzufLUVzZAMtp8So6?=
 =?us-ascii?Q?xjP4mdt6a8lpOs+g0+/eA7TT7qbe4UUJlryaiukWFGcq/mD4XTNFP3CU/4Iu?=
 =?us-ascii?Q?lYtOM6cwvUWTY5N/E11INt8eBv+b4O1MyCeYcNnveS7Y671IPBDUkW0Q1/mT?=
 =?us-ascii?Q?dHv5NJltckzHRoCqI+Z+yYE+LdNAN8vp6WSoxw/lWrvwjvvAavqeM/uTlC5R?=
 =?us-ascii?Q?zQg1cYiq1I3UfUVdRI7APFikeZZkR28fTbljU6CeDUdQ8WqPZWilon1if4Lx?=
 =?us-ascii?Q?EZUSPoxTCYPPHccRVMHCHNW9FDKAUw41nt+bhhVaUcAC/43pJA9HVdOsNcpu?=
 =?us-ascii?Q?1AgCpMxAkjVlrWkCr05d1g3Pd9eq1HBKRoC5GU+mcHL+S6bhfEjmR1jG5C0i?=
 =?us-ascii?Q?Uajo6SaEUxITSAxdsNWEYGYTNBkUGcFzOSRB9fqrpASn/uNAWVrkCdk4bL6F?=
 =?us-ascii?Q?IG00kyF/lsmDD81Fd3XHyiNp3ksFfFInxyjSwOAPG2KaLRgKmcUB4LF/neHL?=
 =?us-ascii?Q?c2ml44HfCQTr8C71hjSWfT4dSwXcOaRjAHSdD4bDJj6ORiMb7C4d7vPMObgD?=
 =?us-ascii?Q?xEOSyamLeALFFvWaP+L/daTfL4li7c2zEfvqPC0t6bkq2T807dZq4CtBA5/c?=
 =?us-ascii?Q?XfN/kE6wokQFF8uzoeUfz6n1q6A+xKt5HcQPRsBP08cDuRKf8pAN54TJXdiR?=
 =?us-ascii?Q?8fIdJ9YywLtXcxVDCnfmDksSM87sZ7gSo0YM+RA9a/DWQ6eznmVYJQo+y82y?=
 =?us-ascii?Q?eVWeozWYfyRXNzWUD1TUTvOU+JxN1MZ4XZEs6TJslSfXZsQyCIuW/ZgbET6B?=
 =?us-ascii?Q?cqOFOpZmpHIYDgVVN4Cw0KtsaTUdIQdIzpQtMRl1O5l8bwFhjqOcOT5NU8I1?=
 =?us-ascii?Q?sqNNbyKCemyGDFiT8OyTDC9kSpKinMSj2CEWZojnBnmR+0TTT0RE8STByjTN?=
 =?us-ascii?Q?p/VqnTW4XLvsQEn8EmDJtDpOh6cB5OE8ZDo3lbLj3InLjXOS4b+ZSQT2kptV?=
 =?us-ascii?Q?+kOPRxt2wVN7wPV4aJCuVqL5kYIcwiJqh+wYUc2Ay728C+Y7uLhstWy9mjDl?=
 =?us-ascii?Q?8h+BKOc8g4Ue+Zbbw43rxeQgs/mRxPOj3KoHHQQCMEfGBO0UxUIm7vsi71dc?=
 =?us-ascii?Q?4rJDTI8B7lXoM6XS9I46wL6HIZPVOxw/MGWc6wR2tjJGR9bA0Eb34tmorCYk?=
 =?us-ascii?Q?/xJXvCsikkYb6nAUhjm89kH7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0f7078-16a2-4be6-47a2-08d925e672df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:55.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zOwy89890pwdnoNy3SSDhtjfbnZgy/cVi04SDvapeBSFv68fV6GTe3jLrOgcbCfUdzHkgCw5acA8YwKYpQDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

ATHUB MGCG/MGLS is enabled by default.
Adding ATHUB MGCG/MGLS flag to ensure athub mgcg/ls enabled.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index edf4cfa0ec72..15f5d9aa9485 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1338,7 +1338,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_SDMA_LS |
 			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS;
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

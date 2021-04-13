Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A030EC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F38461176
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F38461176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DA56E20C;
	Tue, 13 Apr 2021 20:57:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA236E20C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmUL6Viud1guisXzII0Nc8V7ELrW1bgWiNC9BIbcxB1F+U1DnZJtfQu1pJT1DmGowDiSqOcAZNqophrYTCMcaAwvRtb3Bqr3Bs7MhcxLN7st6KSYhi0nn+7pqz6MLjeUF/cDgmQR32fWf7DOw6WTi4SFlK2gBozoQlLdj14aMqMavWua1igp+W6PMvAy5veZfj5+HwveylQVj+Amb2LuFvxu3GZ/WIxjNmbrGxGUBIre5Xd7FD3D5hciPgFrcZAx5GLOkVyhtuxeBsJoUGGHT1X0GGL3We3Uwym6twkMDvLG5bVC+To+xs5hv1QPCiU/4cJvHZLF2wwC7VJzaTcxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjVngJjBS0YP96ZqqO1Svcr7QYUBiIxGXGJx0C7Ljhw=;
 b=GioKOhAy023QuaZuO4sNZsfyRl2oojGxPQeryiET3Gi5CWLhvFzsLKomCdrwsTQWmiM9Ly5ZvEMKfsIGeWkyL1JWWrOdUQ+4GhQlUubfDXGNAgcvVyap4N8Xf49IYfp2psRThB9B2/oP6aee70b7uVafQ1vOaleRkFEmynShhfe35JWkVi8TaHN/JbN1sQn6/PmlTGk3ZBRfX8lRHXKlnw+Z6Nki4ztlWkHfphxMNW627kinr9j2PyRJCRfTfkbG5DXlLc3f+ojab8pbhKyzCZCX6RKSXzRuwtmXhUbFiPNiNwB299zgVzrwOnNcTYmpp+ft0nf1WKzSFaIZHuHv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjVngJjBS0YP96ZqqO1Svcr7QYUBiIxGXGJx0C7Ljhw=;
 b=gAv5sQ1o3K8LiSAVHvnDhFrqs+kXjAgS+FUu+YQfk18sgjMis8ENkOgsJYaI+TdG/xfRA36tR7NoDQfYgSYxELifXniHqLbAljD+NWYA1yJ3fHwjxfQGAIj10Cz7yj1SzqFs1TLE7+7BVcQ9ecRLRGMOA9869vldbqnYxGUZzDk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 20:57:53 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:57:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/2] drm/radeon: use pre-calculated bo size
Date: Tue, 13 Apr 2021 22:57:40 +0200
Message-Id: <20210413205740.24120-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413205740.24120-1-nirmoy.das@amd.com>
References: <20210413205740.24120-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.119.233]
X-ClientProxiedBy: PR3P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::22) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.233) by
 PR3P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 20:57:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c2ca672-de37-48a3-330b-08d8febecdf5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846DF44933C15E6D39D95AD8B4F9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZt3r5GhEBvg5nkGYg4Eulb0loQsduvp0tWf1FVCZA0/zwFE2Mb6uehjw4CDVC6T9SoOuOudovCFs48rlA5S9RlXNX0qK+tkezdYPPIS9tVC164RT5nTc5VR+rEtvtDa/QTJ4yNTSXJcnsJu46POEcbp+slVXDmAW8U/qA4LfWAzD5ejlNiq3K6TKroZmSjD29PlPyeTCmt66nZk4ZEi6Jmh8clfNpnLA7IojMe9/oXW4QvjVt621R0iLRsH5LGcG/7NFb2pmOM1K0hs7GQep9DTNjsRg2aGnPEWNqUz0As1EarOIE1GVVcZDE5Net/JJZpiihhjD8zXNANbC80rNQ3wZEJ4Qod0KiEnmegwHD2i5eUCqY55R0WtvkW2LSr8mcppybfHjNhOvN9GVgqqGsKfMSRXrdo1gxx9p6ZFSy7W1eDz0V7EA3NF25BQeF7JKFMv7edaCCXH01DQCgeShXTqNCP2M0fddQni65jQCoCrhalX83T6jowqbNf0rl6n/FDQkEufS8uzk/dhAAVCJlFFXSRrKcECswz3iQI9LK/Y2SrVSPd1MSLAV8Z4oxGW/2I7GTFb5SbT6Vg3ZAiLQW/Y8gkY/LfyDExh6rmSDqLw6JolLjTMRFERPKRX2ZfBKO7Wh6U1xxiUBjJ6zWiiwYp5oy+D0qaVHOrQ8b/5t1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(8676002)(66556008)(66476007)(36756003)(44832011)(66946007)(38350700002)(186003)(6506007)(6512007)(956004)(6486002)(478600001)(86362001)(2616005)(2906002)(37006003)(5660300002)(16526019)(6636002)(83380400001)(6666004)(8936002)(4326008)(4744005)(1076003)(316002)(26005)(34206002)(38100700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ThTan286IwD5xT10STh+980dPGNlsbnolTgAHTO35ps9CrrTQlKuFUx1cOU4?=
 =?us-ascii?Q?OnOCl/N2DwKX11uyKC+gaR/RraEkQVdNP61/92+imN5uvu9azubjcbcjEXkD?=
 =?us-ascii?Q?mXQaiTbSCsk/dqKCJRXi7dVpU3wLJJNGTOHZVVllwQSuxxU8ZvPQ4w4DeGa3?=
 =?us-ascii?Q?guHx/eD1XaLhwwTW8XPA/yT1tUMTVejJMBey+qv65H4vvV9ol3HMhbVnBk6Q?=
 =?us-ascii?Q?6wULQvJiDLJghEFhEYlztrk4RIEHgmH9lGuN1XwyaE2H0NmVx5ZANNuaMUWS?=
 =?us-ascii?Q?HtdbIm6GAuQxu35GzJa1sXcO0zVHL6605zLxfXpJVUQnlPOMF1/9pyD3XJYO?=
 =?us-ascii?Q?g63FXXm2zRjNtrFFmT4IWDEO5nXksuX7+PZ4UaTo0JuWoAioQbeJ0Gv8LBFG?=
 =?us-ascii?Q?m1CbBMVZZwwxi96/5kehmgDvJMPa+C2TjnCP4tPjaVH0n0553fyU+2FKLrY3?=
 =?us-ascii?Q?RbQNt0tJYeNbKC/hJbTNRjmQyCZ6LTHkMbU4bNjXUmxEgEambQsKxo0+uLNv?=
 =?us-ascii?Q?rGFGpePyvTeztQMqRRwxofN4dGdNiu0b0draR3RjdSgG89vHrf0Bv1mBsBxk?=
 =?us-ascii?Q?T1l2nEUtnJYFVLrjr1b4rQpns2vYsXdWIkH+YsfqHdu/UNp7sXt30livanCY?=
 =?us-ascii?Q?5RVCkVosp3IfHSw4YeFYm2+zwW4Gx0HD5Jx1s6vSwg6WPHf/ahEovQ73IPgk?=
 =?us-ascii?Q?Zk42Cu/2bqY+qRk0Fzr1S4c5e2hm0Nj4OSfnKiAPh1z95FLoc2x2W2JMmvUz?=
 =?us-ascii?Q?L6u8txccHjZMSg5Pi0lWJd70bpIqDmAsO/pfJYGKYA/2w5Yex1dyfzeBJT4T?=
 =?us-ascii?Q?umUaD6039FAXUAQ6xkVE7mm22Ph7JYprJUeGP5AcgP1lWiJ8TCZ4D2Y/Xl5j?=
 =?us-ascii?Q?BLl2IzxbVk03w1q8y8vKbzyAcbch9rf42888OA4ntMJKXz8Dox521WyaeBC6?=
 =?us-ascii?Q?ALbKG/51lO29w+Igk7VCeAFZfmKCs4i0O+cxucTbXKc2oncNdzANVSWR1Q5V?=
 =?us-ascii?Q?24gW19DklzUrSLwjbBF5iSWzmBpmQKJA34JGxoWYY5I3565AsjyOGIv9vuhp?=
 =?us-ascii?Q?sQejEKor9uqipq904qDFZr00x8RjDSPslw9fXMQ5k0ZvhAZi2cRl8siOSDUT?=
 =?us-ascii?Q?O9cYas5vu5f1BhCSWH5h/1vcEi9d/EhL97OGXQxK8IXQnCIXBW3wVCKdB2w0?=
 =?us-ascii?Q?txL7iJEG3DHFUc4u1msl72FWJgqmtJiXPfJwa4FoP9NB6L5ocu2bPyXJw1Tk?=
 =?us-ascii?Q?XfWnmB6EgQi+KLoOg4C3IN3yIHMlAqkYLKXr/EZw3vKkpqtxHNYHD0KqIx7O?=
 =?us-ascii?Q?eQ7OGKlJ9V4PLxkpYXXXvvd4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ca672-de37-48a3-330b-08d8febecdf5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:57:53.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoGn9GhSxrfyge7zBjOPpE04mLbM1Irgr3rMmuc0/5TZVuz1web4Xf7xcrvmLwQvvaOj81IghK39NXsTWJdf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use bo->tbo.base.size instead of calculating it from num_pages.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index cee11c55fd15..fd8f6ccc267e 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -763,7 +763,7 @@ vm_fault_t radeon_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	if (bo->mem.mem_type != TTM_PL_VRAM)
 		return 0;
 
-	size = bo->mem.num_pages << PAGE_SHIFT;
+	size = bo->base.size;
 	offset = bo->mem.start << PAGE_SHIFT;
 	if ((offset + size) <= rdev->mc.visible_vram_size)
 		return 0;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

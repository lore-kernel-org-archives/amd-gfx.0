Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 17:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF3961246
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 17:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3961246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382B46E425;
	Mon, 19 Apr 2021 17:22:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605B96E425
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 17:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO4MFQaNtzxMGZs//PgOWptlrF+odeuRvb+H9YNu/ODctIS62Pbn8iLZROqPxNCwyGNkdvrpLDVSC1TbAyiR3EaYmsBWmH/FwUkYEg7ZcfNv00yYsNxZ5vBog8aPd6sY601oGBocyP7tnGc4zZw0mMXy393IBggeQo7haVmUs7rlUFC7tKpvBwmrLwPZy0s6PGWE7/I1LlYC+lopYFXZVOqMdnBK03zDnz/yL8pmIzG4BePW+WyPsaIAQx9IoYesA3cKG8FIqJdn7pgqd/AxSO5x5zbX3Hvo9WdBCoUoDME9g4GiXNmiWi08S5RXvEEjB2xZ2tHdnRNj8/rLJHyShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPQFWJVHPz24rIwBSDuR6xgBQvi1l6CJrHCQK6u5F0c=;
 b=gLOuqSMKqQLNlnsN9zyqu4t9mYdQkkDOzNLeWDU9cOu3bEWuZ2srliNjFBDx62Bk9GIUduFR0IMvF4EPnK7gzntFVPuNY+g6H6VwYEvDOyIrjA0JWKQv+U4nOJKQiBEK1WeNbsuUSkD5TX/u6+iUvT81AmRFYnFsuR5tXNJGGMFYXE7EG03/wqFtwv2wBF0sVx9r8gUoRrjLkW4caTOtu7+Vf8gqiMD91QbQxI9yFN50Y7Yw1ZwdR3gz6BFNHEO7hPZHOUsnUSuVOMFevH+O6tXglIzWOiQl3rBn2ruM5zCmaqFy/IiyxzGgE1wK41TYNymOZ0TClcPdy7H2L1+oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPQFWJVHPz24rIwBSDuR6xgBQvi1l6CJrHCQK6u5F0c=;
 b=ZGjrxYb8Pu7zcv4XYnOKPT/bHCh1+TQ4mlBi0Be+S+0JvnqhNSJLo/6t/XMeTxCTn79JdLsR8ZXp4XSD5AG9Tk6u02vVPpdvark4xifXhE5lEfyTNHrZyO1+KwVof1C3SIWG8MJ2wKqGeaCD9c0Yv0iUS2eTEhPs7DUQGeRy/HQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 17:22:30 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Mon, 19 Apr 2021
 17:22:30 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: extend xnack limit page fault timeout
Date: Mon, 19 Apr 2021 12:22:11 -0500
Message-Id: <20210419172211.17096-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0024.namprd07.prod.outlook.com
 (2603:10b6:803:28::34) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0701CA0024.namprd07.prod.outlook.com (2603:10b6:803:28::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Mon, 19 Apr 2021 17:22:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f89682c-5431-4e8a-82b7-08d90357b5dd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382501ED281EEF801F9BD26FD499@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r9B/JhO9xgaRWujx9LIZglvRRT5LzCflpRHdotUe5qJMC0Z/dn0dZL8i4BPPKvAUPTvt5MSddWos6FXa+2yqdbu9X7SRTwEFsTegPQW+mRK34ZC9YJVtcerGm+ZDP1ssM8r4GZi33hUVFTjpMoFKkpNxBmeS3PHPsUl/Bxi7dllvss41LBh8bAR5RV/DxmDOkujJ2LG0D4iv9zEASQEnEIZvWIjoYJ6qXLN6UtJAnNF+nVd12aD5xo0DvsSCCNDX80lCUSkjMuCatqHj4XSkYr4tRnNGAi2PoYE/LcvuShZSiUdcSxkE5alyId1AXmuwrtPARfCuyY8sG9c6F3H75VUDmZCsvFscdqmRwa/9ZY6T7NIbGLGAw1KyQX2O2YbU02oKFvTL7bH5PmUz8BqnSpz7+AtBzKEYhs8LDSpkGUSrnLiuD8sPJ/15r05owVaE/xy/TMbW9LTA//t9x1ids+dBFgp7sb1BNXmivo7Qse9gbLJu7ewNMFsGoc/Ietxew5PmgTWoVFQej561UhWRuHAU3dXnG0I7+6KuJQAofXQ8FaCnHv+ASvVC81Jn4ZNDb2bTJnbVUObj0ua47oaE9tgfoXuscjtrbGAfPklyHKarnTGZyxbU0mN4L0Q8Q7O7DAaVEY/3c4T4asTDTaRVdHQNf2AEN4b/JTM6Ru+4YI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(5660300002)(316002)(26005)(36756003)(38100700002)(2906002)(38350700002)(86362001)(186003)(8676002)(66556008)(6666004)(16526019)(4326008)(66476007)(2616005)(7696005)(4744005)(52116002)(66946007)(6916009)(8936002)(6486002)(478600001)(44832011)(956004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QunMmQ1ruSaJ+/0i1b1t6jjZXy6kKPtXbYlb870dpVPZ6OyijCg+pYwAm9BZ?=
 =?us-ascii?Q?t0MmB8N37IL2mdeoptA32CMD4KwnIDBFZwIqqwBDF0fx6CS86gtqKt+C6+ku?=
 =?us-ascii?Q?dbZTGK++7O/c4UN1y3T2drKDoywZSyQWTdaEXyDaOJcZPbWCk9JASdzicL60?=
 =?us-ascii?Q?bazp677cSJ0bQsYPRrhx3LJsZujGi1HWoPxNxylkBlOAC4j0ESFamPpfNJeF?=
 =?us-ascii?Q?//aMSuk8cMbNQCUA+FOvicLipnQkm1kvQFlh2zfynTMROMkPWAPVx25Em3ep?=
 =?us-ascii?Q?HM/1c0Fs2LmNupvHkWAyK7deMcA3NEH+z5eSvHIBW+apxGC7vjRLXQIZGuZM?=
 =?us-ascii?Q?DsYYg4zVFxBEfG4fLIRf3PCempSfL8+hVL7SPpUixHyHyv/fUYLSB9WZ25WQ?=
 =?us-ascii?Q?1eyjYZaYKDygRfKDIlGwIn4SlbBuIsmM43yJcPWJ6XUZmOjTBpfDfiWo4BT9?=
 =?us-ascii?Q?C5cu4bgqcyyFr35B5EJRlmZxlWzuKzACTMcYDM1KuSVDi5yCxNlVHQsPEE7f?=
 =?us-ascii?Q?SL8tQMFuoFlFlpFdrbutiyZfiVTbgfCb9BkNOIjvj+iyz6cwgLKDjd70Fu+8?=
 =?us-ascii?Q?a9CY3Jfjal5JdO9AQtlnfBu/w2KzmIZ4caJl/q3iX4M6E+XCeB1aQluZN2Vl?=
 =?us-ascii?Q?G+Aj5UH+2UbYoHOsIhoBejUwsbnqA1PhGBRp+M09NlTdNhPQx2jfZ2ll5Vti?=
 =?us-ascii?Q?3ubRcHyW0hG+d8oW58t3YT2pgnSXMz1QcCB2YDO8D/3aY742RsMtYXU5bNWg?=
 =?us-ascii?Q?heKAUHAeNWc3nn7C3ofk0jWpluEJPzvNt5XXistkjqD3kYRIWb0Tn1wrXlDP?=
 =?us-ascii?Q?k7tldMQ2A+grC4Dt8YTuldxQu5EbrJZ8wvW8UebknqotSN3fDmm6vwKVyW/W?=
 =?us-ascii?Q?rnBBTRjp+2o9Z9Utc5cKI6Obm/iSSPpuUa2urjZ/yFp4MI4VqsXecx3Kyl0J?=
 =?us-ascii?Q?s04TntHhbC+fXYjTaBjPLCYT3Us98jaUfB078yq9KE1TTB6YDgdnxTZ6NYno?=
 =?us-ascii?Q?0eVFOx2C5MDN1OE8T/ZZ7tFDvcxLhgfsRk5vilze9ra0MGfrRD6tOQT1Yhnr?=
 =?us-ascii?Q?SrLehmr47dCimnbCvAEYgZ4ib+1HAfLd4ZvWvZb41gSsGyvfDQ+ojCu4i8E2?=
 =?us-ascii?Q?VMP1hlKs0qD+esXYTXQwA+R/HWUbTGGbH6bW788KEbU0rzJJ45xJER79beUu?=
 =?us-ascii?Q?9bo17r4MH/LRxMVuosAdin1x7K7r3PrGMKcIaUO7k61Z6A9e2fYV/umEJTkN?=
 =?us-ascii?Q?Y7Je3Wh2/EvjlcJI+OQcSK8EtYI/NFXFlZ20VJnZvL8gkvM1JTIcf6PpYBi2?=
 =?us-ascii?Q?fWy3MjmFn8+kZTUXqUk/o6MY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89682c-5431-4e8a-82b7-08d90357b5dd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 17:22:29.9449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzJTySWnDSflEFVTWPUvll/TRPlSDx/h/m+EReFibF4CF+JYv1013Sy/rhTh1xd/YrqhUixSlpjs7N74lvcnLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extending this timeout will prevent IH from storm interrupts coming
from SDMA while a page fault is active. Currently, on Aldebaran,
handling that many interrupts can take a lot of CPU time
(up to 4 seconds).
This eventually causes timeouts in other tasks.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 5715be6770ec..823a367990bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1109,6 +1109,8 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		if (adev->asic_type == CHIP_ARCTURUS &&
 		    adev->sdma.instance[i].fw_version >= 14)
 			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
+		/* Extend page fault timeout to avoid interrupt storm */
+		WREG32_SDMA(i, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
 	}
 
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

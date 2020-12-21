Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC73C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0FA2250E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0FA2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFE86E45C;
	Mon, 21 Dec 2020 05:43:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518966E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 05:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAdM5y5cODk5C9F355mF1+QKsjcsgJSjNLLXAb9kOD7Oe8tNkM9wMJrkLKuGK8MOYnw/E5ZZjxGpWpa9zbT5jQq4WUjqB+5EcVDuDHH9fFM2INnJzemOVXjq47uRh5m4QKdLFED5BgTDYwN/wp34E5xOO5jl53nDNwY7LI9/ZwnlmJi/nl7eG5l5O+0arW2r40bjJ8iK5NUI4BSasJAMPvTU+QDxCezKOJ8FF5DK1PoenZQqCljHt/jMaKhtIwUHWCDk9oip4WOFTAhYVyL8ZAUBis3SrJzs0pl/aroLLJMJ2JYV5U/kh90HvFq8iwbTB+3qsROG53NSE4jgSxV2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxBi4bHAd1A3Kl1MPlf3ppfHTMEUlsuT2/pxa2Ntdek=;
 b=Yc3YwrxmpUu1SofccwKWVFdS5hpRPQYbEo2KVzE8KvdFp3XLAWxB5iLiRExbN1lhGZLGaoIwwjmWuFebXCY/QjiY5cZfYYpohueO3zS7mncl9nDobSqHlBG0nEvi7BU8SlT7aWX381Ie7A7E3oiP3caYNbZJdRwY5SveIzri49v9xt6h8oqx9ElR+4QVh9klkPwuUUKhLYPJCe9SQAsUH66/+DUqSOOdbOdoD3xk/eI2LrKVJ8oGXjbpduLTZSAPNlLXRbCpPzLBmzzm5cGLc6gbXNwq8nxRKJB0P7QYO450cEMEZi/nSdLZKVUvlpUdYePMlX0ceF2FaR9rJFBnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxBi4bHAd1A3Kl1MPlf3ppfHTMEUlsuT2/pxa2Ntdek=;
 b=EbFjKzrY3q0ZrexLS7nxTGdy5Y491iMw+laZmudh7JIyvaWV2f3+eIsL2i2ADFRlpjL5i9AtwHiarLN3NRbt5ufYLJcWsHNJSC20z+0V5LOe/FlQzkExtK4Kv683BL11NJ+pkKMsizCpW2u9ne48TI4WqTiJiQiy3egz7DUWCnM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 05:43:12 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 05:43:12 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Feifei Xu <Feifei.Xu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set ih soft ring enabled flag for vega and
 navi
Date: Mon, 21 Dec 2020 13:42:43 +0800
Message-Id: <20201221054244.7421-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221054244.7421-1-Hawking.Zhang@amd.com>
References: <20201221054244.7421-1-Hawking.Zhang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR04CA0081.apcprd04.prod.outlook.com (2603:1096:202:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 05:43:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4348360-2d83-4f4d-9041-08d8a5734e12
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29862D2252A186B2207A918FFCC00@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7n2X9hqVq94IvL2E88PQ+RJtqnUkEVsure1BOSJ95rhfcCmEBJa55Gj4iqSMVLi+G1n0ThCDUNX/KCW9WNhWgmF9v9j9yaRUZAL2pnp8xBfcZiEz1k51WvXi0ZqKvK8QYH1DSBkvY7duJACSWWsMjvr4EDXBXZclMsBXdzc8H3EB/7N/9qwa+jFFLNBNqYm+i0ZMlplcMjZz9qbiAZkdNRhxlRfpfJEen9fUfTh+zUZyQDbGqWMWqEfj12+q9D0YOFUgPY51clOPJ0vmAb0zN8nxVXTMizx/17A52YQjbWub1p37/J0UjnChx8giijHsjf0YD6F7XvAEQOBuf7ibtpgNuVXVC5YHLkodJKddXmjLKylbLFNxh3m2dfYrvf7mBK+IWwbvykf0Cl/jkrV4MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(2616005)(5660300002)(26005)(4326008)(6666004)(36756003)(7696005)(1076003)(6636002)(2906002)(8676002)(8936002)(16526019)(110136005)(86362001)(6486002)(316002)(52116002)(66946007)(66476007)(956004)(83380400001)(478600001)(66556008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yb1fYafYUQVlkrmEeS0NKeF5eWMFmRDCOwxwsyeFmpup9ZoMkH6G/PvruZaR?=
 =?us-ascii?Q?pDbEPo5bjl1RqE5gApHWLi+HMi7u5iTLKlTp2Ka7mk12c7+ztoJRTsBOwqvv?=
 =?us-ascii?Q?+k31hw/bPNCFgMMXhNQLkR60+aviDYAweFyoqQZ6HF/vu7Vi9Pfks1PtPvyp?=
 =?us-ascii?Q?x6c+XJ4k9OC74+R7oI5tmWP64x811ke0X2OuQ367YJMtXruOdgwzmC8w7nyo?=
 =?us-ascii?Q?UEKGkqBVWZUJf5N/ijjq7WTsC+DqwiVLVdUs8I3AgIye1YsYYdhmYwnvjxk6?=
 =?us-ascii?Q?MOKEpAQVGliZlwRMejhjIO5D1Z/WAJGnunTZlLHVEoR24Wj0GH3VqTM+mWHg?=
 =?us-ascii?Q?wngmCKUN76yhiIEJbatW6RwCLpprfG6Mq9FQJHJwM7v1E6G4Oo1/odo+xOt9?=
 =?us-ascii?Q?hwDBEG6f3QV3lFBEfMotg/WPC7A4fYKlUa4AIS3TCtU5T0uA8zIztVd973aL?=
 =?us-ascii?Q?HZH1lmGe1SnIq5hCegwu7zkIwbu6TeBGMr6yReCIEUXuLW0bBLVQdRkggjfr?=
 =?us-ascii?Q?bdotx85cy+t4AInIuO3HTsVQLJjcnkwahaFm36JYM55TCoHGlabH/j/yriF/?=
 =?us-ascii?Q?9k9k4X1M+zh6vH3iNV6d0oecY6DE56tVPrbZ7MP1yDQT3Hi/Zj0ZgaZIOMBv?=
 =?us-ascii?Q?oglf52/RKr0VMQF8zNswOE4q3ZlqGoTpENYN6IxxvZbTEkSX2icdpl7BP4+2?=
 =?us-ascii?Q?nZF2u4tItXaGoKfwxtH/PAG5Eunty9I4BBZcMJgatsIHOUQP9ke6e+zVU+xO?=
 =?us-ascii?Q?epRoHTp1XP37+oKxSTI/zPmlDEJ5ujDTT5ESYK7z74y/7b26CeYN1JM0+Kxp?=
 =?us-ascii?Q?nnXgXeSaiYMTorJYiWs4u94dnK3Sv8zMTYgYqRdW13Nldmc7/+Hzh0SNUlzb?=
 =?us-ascii?Q?tcyjooPySG0Qa3kK14VocVSTH+d7jJGsHdBsQ+oj5YDE03qXWjrZ7BG0CYC1?=
 =?us-ascii?Q?WciHBjHgYprEoig4loOoh2vyjbmGNbrTvFRWHdZo76aHGvwzXOGj7yEvimy3?=
 =?us-ascii?Q?XcUL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 05:43:12.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d4348360-2d83-4f4d-9041-08d8a5734e12
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3ZiCQBuEfq4r8HFosQA/IfgJGIvNzj7TyGgYZfLF7cZib+ash6UQPUFuLZJgxdRgoR0HLSDmD5Bm9CjLyOjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

software ih ring is enabled in vega10 and navi
ih block by default.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 580a325f08b4..04cc41b82661 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -370,6 +370,9 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	/* enable wptr force update for self int */
 	force_update_wptr_for_self_int(adev, 0, 8, true);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index b1d94421c8d1..1581113477cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -307,6 +307,9 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

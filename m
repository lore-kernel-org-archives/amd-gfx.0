Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C2C54FD0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 22:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E11520736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nN7xZ865"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E11520736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022136E0DA;
	Fri, 24 Apr 2020 22:22:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1126E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 22:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD8CUFFtyQWtnQSv2fUKFFRfIw4m8YC7a/T4kpQ48RNAb+p1/bxGlU49t9IRJWUsBkARF+6H8yLp/tWgCp+wbR8jtabz0EpW9lLXL0KccV1/6LtVRSuYOgP2zvbx1GyC0N8/qObkEhDYzktqbus1FP9PRL21Agv2lTx969Jd25U4w99qt0l01Rr4yU2JYeMldwA0+YU9rwrOna+SUrr7HYWV86Vj8ojMtt2sZWALQ8i1uSTNpeMF5xtirF85tq7X0YTwoxekPNs/5iZzIHEJFVCytcb0gipnX+y85AD6GVlMAs0AtN/tsNypnG9NZ4pQwitNFf35iu0XBjv1J55fSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVUd8hrcsQ1uOJ8gXV+0iLKCJFTzi9031ZANNucpPAg=;
 b=atS+OxLHOFw9du2SpaO0WImr73NZuxttuf82tVMRMaG+rI6w7vdtE/ejGEUe/la4zXQ/kIu6gMfziV7iVVFgdHpB9zgDukHXgm4FdKjd1+Zd5XimrYWt1xDV2JmE0SHYJwUchnds7TEix907IQTcUaIjwUNBvD3vHf9J51eEgQSsDqEOOQ5xpvud9FMwvfKFQSxbK9a3bu83aSkwlvBxrUdLhGF2v74sXxjpGe/2ULOkrQ4NiaQNXPC+bD+iuxQYs8bUYrok4i7TX2RtQeNI+ezMXwbWgyzmUOqxLkSkB1QmYxCmcPfiFXVlI/uAVUZhD04I4G6p7xklVpStIWZkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVUd8hrcsQ1uOJ8gXV+0iLKCJFTzi9031ZANNucpPAg=;
 b=nN7xZ865he4KMXS0IN5gafWXEekvzDEmTYQ0phW7uNlak8bz91Nxr222ztBEneRt4x89dtrNPuJbZpQ+hSyOPtabqvxs72ae6neI7HzVO0xv7C2hirhznz7nEr7QwKHic8mhUKbPrY2zAuSiBis7HJ0xumYrAX7ynLx/Lv3DuJU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 by MN2PR12MB3229.namprd12.prod.outlook.com (2603:10b6:208:102::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 22:22:19 +0000
Received: from MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0]) by MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0%5]) with mapi id 15.20.2921.027; Fri, 24 Apr 2020
 22:22:19 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: Felix.Kuehling@amd.com
Subject: [PATCH] drm/amdgpu: sw pstate switch should only be for vega20
Date: Fri, 24 Apr 2020 18:22:06 -0400
Message-Id: <20200424222206.38743-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To MN2PR12MB4518.namprd12.prod.outlook.com
 (2603:10b6:208:266::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 22:22:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a00444fe-d1b6-494a-164a-08d7e89df394
X-MS-TrafficTypeDiagnostic: MN2PR12MB3229:|MN2PR12MB3229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32295CEE4AF6065E64C0DE1B85D00@MN2PR12MB3229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(52116002)(316002)(66556008)(186003)(2616005)(37006003)(8936002)(956004)(81156014)(34206002)(1076003)(4744005)(16526019)(5660300002)(6486002)(26005)(7696005)(66476007)(8676002)(54906003)(2906002)(86362001)(44832011)(478600001)(66946007)(36756003)(6666004)(4326008)(6636002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JItzt+80xCu/+fehDRx5aIlIaHPLKVPzNocFfvrjlF2vh9D9EyEMLk4KYElXslyhldV2oOJ7CjrOrAYpiEDHk67KudzOf2UGZvIuX11lWxDuDFHAuTZ8F1xyGcsOkDk0j94D3VdWMYoIQ6xp0KJqT8HH+Sr0lYvjFanLAc7NlB+ex5hKQ1pJNdT8Vao+aNNwHwWgoUdLP9vlNIbkInKDNVrGa42Z1G22lrz1IzDvOrhJAXsBBDP+HMhrWBYIR6KZLVg/WKMVryUaJVEP0Hb00+Hk+aiyPGMQKMzluULYyXTV17O+3CNcP7WoX3T09pOWHExwO/wI4ozuokQlFpa1ql/b0TljkYb+zGmJUq2DexfGjtQz0aVPp7wPlc5fmW1+NS8SKJV8jjIIHaeVTBsUTuv41gJioQNyxnFQKwMP1VTtnv+8uxdOAbkgUDlXFp96
X-MS-Exchange-AntiSpam-MessageData: 6y4P5Eqg8gbir/h+tCqi9AgNlYY/7SbOKusRkZ7QdF6tdSzoJJncHFQZPd4AMGACrNEeuYi6RVNs5ruSi1exuhBHgwdjTCeU0wTLCF7G+onQ67JfJLNGqwNWQQtCsf1+qH3GQL8nMPhMJ45EvPIne3o2bxRvg+CLwsRxtNMwvvPNAVa2aLMjPX1Wz/7XUX4iUDKmKoGFWttdvyWOWSWW82M4tL0ptOSF79bkFy7qNxuVZQpW6fgkwoMv31N3gA5CrWMfVTRIQIYmn0mq/x254nadKerIO4QTLilyngewxlP1OcfWyrb9W9nyJ4xdqC8DH8HY29WLmJJ3ty8GFmVU9OA3iUeAk14B6XHtRTXHAX5Ev/w/NL/btyVEiwy/RhgLt7Kd/YwciqpzPagLDeNC9RXKZCpQu0q7509SCZJXVWik91IOHedyU3iGn+NGijlq6uuGPr9DCYb24ebPm4Thik7vgu2SQyk0edKV6HjnG2OnNQYW5H+LNl2mLqO6pxinG17E91QM/vcfnla8aK/+9aCG04Ulae9odeX4MBAiSM4hjjGG5DSxx3M4k/4vpIyZVeiE9nt1ZWPpdodwKJEqbeGE7Z8tXwPDZGmrnnw3MLkc4qBUa1rWnhXiCrxAKAcAUxONGRHOHhGPeUAtuV0/IfoVU1mJp52lsHx98UaSQPdltepEkcUAiT/haFGyD/ffsaHHeq0Yrg60tlTxVOIoXwmhCMRAi/X3ND7KRlYbCX7q6A+72KcksgXSLoDIxY9NnYYRl3CiabKWVXft1VG1FIju513t6dJGME1o2M9Vppg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00444fe-d1b6-494a-164a-08d7e89df394
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 22:22:19.2731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7bnbHY7f1kd+0lQ1N+QTwoea8LlothRVJWH7mQg/FUPB6/mVuZcF+TGUSe7Gkbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3229
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver steered p-state switching is designed for Vega20 only.
Also simplify early return for temporary disable due to SMU FW
bug.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 54d8a3e7e75c..48c0ce13f68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -395,7 +395,9 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
 
 	/* fw bug so temporarily disable pstate switching */
-	if (!hive || adev->asic_type == CHIP_VEGA20)
+	return 0;
+
+	if (!hive || adev->asic_type != CHIP_VEGA20)
 		return 0;
 
 	mutex_lock(&hive->hive_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

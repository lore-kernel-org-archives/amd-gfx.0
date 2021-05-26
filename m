Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9BFC47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9377613CD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9377613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982B16ED14;
	Wed, 26 May 2021 14:05:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D756ED12
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 14:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvTmIzZqu/TjuHk/MS0oNxcbv5qGWfvHcztQc6e9f6W0Ifz7geDnc7NQfdiNleIRAaY5Lef7LZpmhLJs6YuzM7Cr9w0NAQwH9feFRkp5JMLiakn5qsmmIB88m2u4uQT4cqDHfQDYnCdVhDOsf4V4+6jVVuCKQqioHbmKeuP+YsQqhiAB19nKVwNVciwHnfVTIVWDAdxbigHSSoMsaMUIluU3fvTStSxg/VcGCkjNOE8/LFrrK3wp1eJM80/bU7ai85rFI0DrNR/CeS0Lr0SAFdWUS92Hh55W5IWvx1nW3nafW6LTTRtczAPYxO2J3WXi44+IU+xmrhJqbd86vZ5czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIwXdETKc27hVPgJAjot5a/i9uz2XVRBaLzOZlkRyRA=;
 b=CaWi031dm0Qh0hjH3y5aJDk6QuB1rnR+DGtIE+cnyX10aZ+flAEXdVB3a2HixFMqO1QsiEQcvInfJyAH2JNiCfOmR6+5Y30WIJ1rQbaSCfaRYb6GbEAXCj5asIukKaJQDAnFrJKByV3G1wF2n9Fwe24FCZPVU8j7mQjCAmV3Taj1kN4HVPuQ8CJToUyZtViY5+a0sFK5lOUqVGGyBQyBulYapG7NcUVkWvyDHc9zDYnUZCUD9emmHc5JRnyjsR5BwXa7Ceu4YKQzv2rCIbERNwIvDeEUnbk8slj2opcbr7MgjQKCo86EfhxgM/c1KR/VlUFIxhuX45L8n+65zIvCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIwXdETKc27hVPgJAjot5a/i9uz2XVRBaLzOZlkRyRA=;
 b=n+faYIcEKA+5w+Hww8YJomUPgJnmWUgzFqAbwepF7iihhWMmzpPYyUTWHccFkH4b1smnIStyG+61Igb/a1wfu6ii31hQG++TBCJ2IMqm78SS+dI6oUqzkpb6l0u0+EEOkK2N60PSeiqDD07ya/EVN64bZO0JSlEPFEGy+3070l0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 14:05:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:05:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/acpi: fix typo in ATCS handling
Date: Wed, 26 May 2021 10:05:02 -0400
Message-Id: <20210526140503.1541686-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: BL1PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::28) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.14 via Frontend
 Transport; Wed, 26 May 2021 14:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00c972ee-a27c-4ea7-6495-08d9204f4c6b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB415880B497D85DE4C7F66704F7249@MN2PR12MB4158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fd1N2dhJyWue9IKLQpDKzGxRfNPqBEaJYaUccL3S6EniM91aGoPI2q9lJ4u/9bgzuanERi7lT9M3xfhQMiWGTxrUp3TDnoeP4mISchabZrioSMCqkhK+VQdbNi7EifVH5pX8EY52ztH9FtgsABeBNd4EmfjcShJsMW8KiXdRQwlLJWiihstBkjYcNBFhAY3GJgyJsWNx7zxByes2nlvDQ39xyAu2nHo6znDbfJQcjTxHQ5yOMiz0zRqM5IF+abG2Hvp4Qrb+UR5NtwzU403DfDHmE2SESsD0LG8lsjvWhnVgU3SIwuNXfyP5WY/vwBkzyuxONT4BVdvwkrBqc17RibdbrG/po5U1pZnwTK6eQjH+sKJQzmPD4UDAx9HjzVlYzbam7q0reMXkEhphQoMTgjBn4r5x1uRs5dbruy2JHFAZkLo5TowMsKJyN0QjjAvfC+Vm89QzjGX27+Zti4fjw6vzQQc1pW2vl1Ci63baWF+rqIdRO8RWRodFLrIucolRUoIjbhK/xgDOJI1LKnysaKRIhqPXji4QkTUm0hXKMPqEOqH5kS1cjI/zSEd2soTpvtcYWBaAVU+kUGzFeq/egOd2asK5BVZ0WxckRqzBwiaK/EuLl32t45GLRbKCaJJ+F67GVC427GFljA64+7l/7sLRfY/n1nwFwKT2wLaOsaPhojgMcUpoBjUn0az0fHbb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(316002)(6512007)(6666004)(2906002)(8936002)(52116002)(26005)(4326008)(5660300002)(1076003)(4744005)(16526019)(2616005)(956004)(478600001)(6486002)(186003)(36756003)(66946007)(66476007)(38350700002)(38100700002)(8676002)(6506007)(66556008)(83380400001)(86362001)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lZ41ms36zX5+3/ARcktJOvH/pl46FJE65J1QRivp6dTK99Wl8TDfLCFsioGW?=
 =?us-ascii?Q?MzOwVRFG7i9ocgrntAHmGNuIZ1hjCKawWJTJX1QAiInP4nRB+VOeNa1J/5aG?=
 =?us-ascii?Q?NllRmp2SvJvb1+9ov/8CVeDMZrQZn1dl4IQx4HNPL/FyOwd5QOdeDyZI4Kvo?=
 =?us-ascii?Q?KZ5nt9uLQtQzNiE0zWsCiJB0mJ8auyh9jjMN7qOcTUUiu6YQGqKTIlO242hF?=
 =?us-ascii?Q?LPc4VYO3fFQDI5Zz4y+cD57Hi67a42vHlwK2IIkVPZEgu7YS3kejAsrghg8B?=
 =?us-ascii?Q?kWGzoqAZR4ZUaswmlEksU2MdU5rOUhbTs7ev2SK2qHKv7lVZSEU9uWlPLuNU?=
 =?us-ascii?Q?ciYSq5pKyBYfFnA6UoU7Ch+kX7eAqn4AycpjF8+XGkZJ61tSjCryU7kz5ai0?=
 =?us-ascii?Q?eDWa6yDjdenGX8e9QoJ1+z9N6naazcSETnd0OPCNux+lguAUsVxKX4SldPBk?=
 =?us-ascii?Q?lzMUkB5a93zh2iP65yG75BpvZXQv1dQ+1Y5Op/YPJDuaITzIVCHJsEwFqcXu?=
 =?us-ascii?Q?SfTTU2dVz96ixeEgvKh9/vYU7OKlPWn9DH4tUfQg7XRZPIlE8fZqxq7sGRMm?=
 =?us-ascii?Q?20IZa+p4Fiu86IZq9r3PB9JpE7VuWnyPGxb3z8Z6caKTa1VroxdgmVeZwUOH?=
 =?us-ascii?Q?jtNjThwIi1IIrhLNNr1MOZgssI+eV3vr+WgJDWFGjo8JSCa/xboWTjrWpMgS?=
 =?us-ascii?Q?eS6/g93r3bsGNYvj9Zx+4/IxZnhTCoLlmhET8BT7QOuAk+HQ17fNBuPYBYUm?=
 =?us-ascii?Q?Pf5x62tCDJ3lyEuZUJ9zLAEvjbuvLRCSVpZ6RcSAvUqzxlakagzgTsp55XhS?=
 =?us-ascii?Q?NP9VZptI0vnUA29yrfjWQpZSHQa6fw7ZpPPZTIKqro70KopZmc5NDXn221gV?=
 =?us-ascii?Q?P/GoDBlgS9Bf0KK2SHhAE1w8POJ8txMSV9OFBknew4XWFdDCYX3pRHJ79ugK?=
 =?us-ascii?Q?6J6FSvQg++2COoANttnU3s+/c8k2cBL/AEyhLTiBGuDp9oqS1R4zoa77ijC7?=
 =?us-ascii?Q?ApMM/YSdNOayTdCuI1k9hdVLy+Kkou5t1RTkLItRt7oWvd9SqVmAMtLOEzxd?=
 =?us-ascii?Q?kj9U2fHOf9lppbHKX1S56uL3MGLB4wwyVuKxKqWbrswgFyzxyGhBzZDtPsAo?=
 =?us-ascii?Q?ttJPTXPsHcK72qojsRjHA04BwoY1aw8XI2pnKTZT4cE1ueplk29OaHGLB9VV?=
 =?us-ascii?Q?jfwEQLEh70/hYnjcuH6K1/toLniXPzEiQlkxaxXTXu2u6uwPyOX8xbOY8Uru?=
 =?us-ascii?Q?kiOjqX3oiIDY45XncRvFDEqvaMCF+lM0yGHwbTx07bGa18le3KRsHkvevlgI?=
 =?us-ascii?Q?cdopGEusg2I+yPmlyd92fQtw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c972ee-a27c-4ea7-6495-08d9204f4c6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 14:05:20.8189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ7mRRnhz9IkmtNzmuwpn9lP03iw53Bv4Y7aVHCWcsm9JkCegBan3ra3TlMFR7phr2URJIwM2/mlqo9dDbJkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Path should be NULL when we already have the handle
to the object.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 49563ff87f1a..df216d12c507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -558,7 +558,7 @@ static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
 		atcs_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
+	status = acpi_evaluate_object(atcs->handle, NULL, &atcs_arg, &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

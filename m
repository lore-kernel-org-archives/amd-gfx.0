Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7ECC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8022523AC4
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 15:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8022523AC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AB289C1B;
	Fri, 22 Jan 2021 15:05:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F1A89C1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 15:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2c5wdBVkZh9IvAE17n0GOT7qPOG8nw2rV60BIW+FcdHPkZx9yCOISc6ZrJ9m/RMtGuykcygTkZwTmN6UywAt55HVtvW8vYakl+v6U0mIP0RgPwl5LUbS/KjUxMyEPzt7NeE+xGFWpGOEsYbAyzDhxaoXGFvZKPa5Onen4JucGo0E63M2Qa2dJVhe8qHGFFo1DtmhDykCGXS3cCvfM8Fnf2r3pRzO9CeMwB66Im9sgo7NptJ5Yjb84p9owvE3P3dWrP/n+4nwcsltILOG7cRX69bf6LkRO/37zTjCShK1vM8HxA24hWivxhqwIdE0n4w8HcmUKxZSBcWc8x3mNFjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmYjCUBXannst0O7ao0GW9kcdMosqkbRTPsS71YyGjY=;
 b=L7Gl40VONk8Uhe0JI4k+tQkFPw04DL8Bjne4NDrTf6zye+XNHvatUUtpZe529fiCFq9Pksb+rF2o6gfJ/hYGk1jCPd2aYK0DXMQzZzYMqtbtDyxuLyqjVfAXMlyaLiwbb6uUPpSQL/L/f191mysAQyvaJj0t9pi4wTmLGvl+tv15RPhJgn23FRMp3wfKZJfuSP5VXOoP4iXjBjdeuCdNHYm+DqVQUY/zS2h+AbbZVFK5/W+W/+BY3D+CnkcU/IfB+FnHtrK4ya5Ue7hV+4NcB8NZjb+evibjRNuhYEM01OKBdvjM9MPpPvDorYlIMB1I+k/cAWfpTCckTHkREjssDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmYjCUBXannst0O7ao0GW9kcdMosqkbRTPsS71YyGjY=;
 b=EKWboV3IqF0uyKAf8k5Y3UgaQErkatGdNHb17NIxMhfjgzWoXQdQhqs1Ne6nyecpeuUOTyCo3N4n3lKbZ/nSj3w6MTLczxbsn70hPzIijff/4jOqEUVmwf4Vh1cugmYbT1p5VN2PIjAr/tJNGrn3vDbwj/cimvMS7KLvFVFewR4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Fri, 22 Jan 2021 15:05:02 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::9d32:b262:3e68:b951]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::9d32:b262:3e68:b951%7]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 15:05:02 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] tests/amdgpu/vcn: clean abundant codes
Date: Fri, 22 Jan 2021 10:04:39 -0500
Message-Id: <20210122150439.15911-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [67.71.222.209]
X-ClientProxiedBy: YQXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::42) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (67.71.222.209) by
 YQXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 15:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cb949ea-cc2c-46f8-6b5d-08d8bee717b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB418639B5AD35F9FB5413F81BFDA09@DM6PR12MB4186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p9++kitFg4qrAY8CreJBPNlbqcfw1p0kJkxlQnmBXraEeoxE7ZpXBeKWDExN/ZeFfaxsgb4fA05296zWhDYLk2ViKoms1DnXAM9B8s9CBDP9hyDKzkXwis/sNJq2uRRWO+LkbKEN2oIvPyFCgCJNO2+YCsvzTdTD3G7Bh+ms5LAW3Yj4aGddKOUbv47l/U7ptAyymOnnrhfkeyjxV7iuHYTrWYal2sUFvv2fjG56hF/CJf+GMnM5j6Qv7bpIch6m6mQ2EIwVg7Y4zJEf9L4tGVi77jsZ88Q1ko3XtsrVEU1xa58PvKfIoft9ZXD39ZJ0zLkVKPlQ/QDiaWOJ9KPlaVjdJqdt0AWAz664ZsSsUIPs+FR6mAhKB1/bK4U0r2Gp9sZU1vJHqaeWnRbUyCMfOeaK6JEkvO3yVc9RQoiYCiPjrD6gVOYxh5Ck49aiT/s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(86362001)(16526019)(44832011)(478600001)(8676002)(83380400001)(36756003)(5660300002)(956004)(2906002)(66946007)(26005)(1076003)(186003)(52116002)(4744005)(6486002)(66556008)(66476007)(316002)(69590400011)(2616005)(6506007)(6512007)(8936002)(6666004)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZbqQPcbTmIocBdBvXO3EWCwboptBZFzMPBnF9sF8iwlte5pH33P/VHg5HSoT?=
 =?us-ascii?Q?9N8Wg0VuiF743ds+avGyeIq1kZRSYDMP2Lz+YFZRSWSunrWSI79Y8fxu88vC?=
 =?us-ascii?Q?TQDsMZhu6nZXJNZgjVYaW5cWoOJmpOdZ40ug0/CRPrHR8FFOlRx7zMAEpvYC?=
 =?us-ascii?Q?hyZci02LLoRHu1yt6FuXRI4+SRIjcnqDYhfaDdK17b1UR5Ymqq+Q9ndF/JD5?=
 =?us-ascii?Q?jRbYDpA03ymAsquO70RUIdtK6h1uda2t3SYTLvVUTo2O6EgDshSfX1shK/7k?=
 =?us-ascii?Q?GNcpuzbf+/+z77uuc7KZSsTJchQ/okXf02uhSHBv3g1TKqhu9v0tfGvur8DD?=
 =?us-ascii?Q?ij642tzOcBhlKpR0n2EmH6ytGiPqYsrwzJO9PZc2o0XJNZPlgBUtxrgt9eWK?=
 =?us-ascii?Q?AJa9wBvFE2trwq5t1qy97/WKoFsCgRUGQRLEGYP1E33QSdOGTHMKkr+lMhxZ?=
 =?us-ascii?Q?a/PZbPi6aL8kvy1r1K/gxHAg9cvanwt/EuG5BFPaC5RiyAjG+QGZS6JoIELM?=
 =?us-ascii?Q?BY4xkdfbFSiGEEXWiMw4Ftdh6M6Av/gmWFJg1EwQaR8kkIukTKnAvkZ7ujPK?=
 =?us-ascii?Q?Qf5s6ANUwpXWqqnnCH37PCBERsiz9fEG8ug01XvNVDL8s1HHrpc21JRWR9uM?=
 =?us-ascii?Q?3PDYtWsySa76Oeaa15LluN/fBoA0euwjc80h9RRurKtZSSi5k9RVKlwfrYWl?=
 =?us-ascii?Q?HEeWixkC4UxU6tzfFmL1AhPRuF7o+O7SnZ3PYGNigktVM6uInvPErghp8wPX?=
 =?us-ascii?Q?3iSz6VG6L7yaZBAFgCCoRlsLIWzAIlO14ffXGOTnTCmpjHPUZ+LiSLMjpGTn?=
 =?us-ascii?Q?OGKlaZ4IuqVHnpZNtj986zG2VC6uS+h4nUX+ISpYJ+Yez1RH53BitWU/rS5s?=
 =?us-ascii?Q?WTZnAnYz4KCUKPua4f2cXiNRqQrxbhekN1U34Ol0sUQxvJWXBLnSbUM+HqzJ?=
 =?us-ascii?Q?GRmkrcAPyldgeIBiyEhbyBWrlMMnwEKYXq/Nw6o3M+6QtXpRqVWdg4xeUg0r?=
 =?us-ascii?Q?Xc8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb949ea-cc2c-46f8-6b5d-08d8bee717b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 15:05:02.0494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edtSwYZeSYdBSebNVZhGluWCmE/htlMOekEb2BYRsSDlIQaT4QYzf9eEAhesKD2SSNNtsO3vhFjyP0PG41iE2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove useless codes.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 tests/amdgpu/vcn_tests.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index 0f5b4241..1ca66297 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -102,8 +102,6 @@ CU_BOOL suite_vcn_tests_enable(void)
 		return CU_FALSE;
 
 	family_id = device_handle->info.family_id;
-	chip_rev = device_handle->info.chip_rev;
-	chip_id = device_handle->info.chip_external_rev;
 	asic_id = device_handle->info.asic_id;
 	chip_rev = device_handle->info.chip_rev;
 	chip_id = device_handle->info.chip_external_rev;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

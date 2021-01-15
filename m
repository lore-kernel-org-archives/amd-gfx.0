Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6942C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA8221D95
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 09:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA8221D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21F489E39;
	Fri, 15 Jan 2021 09:34:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16A489DFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 09:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlk0SR3zMP6AJToIMIrZLmCFRMJ7QwB/+J9iLeT5n9+PU2O+JfEa6+uKhWrhavmojatchqzHKwYHafNc4l7ks1Ddcln0ThL+D/XrVxE7R80Csf6McNNWCSTmp/H/CGTYXlTNRne44P58emQhDNfiO9n9FuswkQHAyB+ooIGVsxpGimY96OnQRFNIh4ZLL475nWvcLBLltbJKrRs3yzLalNN+jzWtQpXP+IRfz1Ky2J9qFKaGByCgfS/mActvSZTOg68irNvplxMDE4foRlkmlc4SpdvSDnej94bjs7fPg2iXFu9/kdalJTmENzjPcb7L+OcIwtXLELVWuskSeLyrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e5rhcOjA9Lm+1kV1VqnbO7cutK2PpEklwUBvSMMaV0=;
 b=Vn/848Y+/i2m8vOU7Gqsq81hAW9IceeXncojTY6PwWO5DRu7re9nl1YX5EZ5vQouZ161dSisW5FakGP+BfGYqD6wRCrg9OZFI5GmYDyGjOLf1i03hjaiWvS7U/LM0gGO/eHoWIkMKXhm301XM6ku0k3xH/U7Nc2a4I4KpCVnP+eZ43Vf7Xci7msL4+jhoMQp8GR5fMvTkLWZPbVi3BE2XsM+530lDusbdm1xzoKFDwfsQAwx+wiGw18MtImAkARJJBXiQM6lEH+ItQqRQThx8hLSFbrA+n8MIAPAtEDsFPa6dGdDWOXYIXRDD0HJYvULFjG+M3E6skAM65LwT4SUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e5rhcOjA9Lm+1kV1VqnbO7cutK2PpEklwUBvSMMaV0=;
 b=m18LvDBGppvBtqqIkaZskMQHEqne7fQyvSjE7FF6jQ0dsv/mXVND299QMn6eQfFG4cEUi3W0bL+kwVMBYJnTpXSOP3g+VYmCM6FKmW7s9gOahUQiRm+KOU2W7gqjQliCpE3mV91E5ZKX6uBBv5Ik/g9ipoHUr/dxe3Eh+K1jytg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 15 Jan 2021 09:34:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 09:34:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fulfill the API for Sienna Cichlid gfxoff
 state retrieving
Date: Fri, 15 Jan 2021 17:34:06 +0800
Message-Id: <20210115093406.389563-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210115093406.389563-1-evan.quan@amd.com>
References: <20210115093406.389563-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 09:34:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd1dccad-0a2c-4d88-0f49-08d8b938c02a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2796EBC687D3381036744795E4A70@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUYvAwPwFwc9XEG6dGEOdzhs/+DccqYamIE1fAIRgzNbijAZyUOKJNW6aHZEaRzokCtNwZo5CU92z7ixmjKcEosCRjCs4fGwvLhtLvrG/gOtyZA5yFuuQ3OQzN3mwM9NKJG9UPyTqAD0RWtfiKrzjLxzHPYXibCwwrenesKahld3kVbRN/COdvu6XcYZTSu3N8tdLJxNUlkIXxvrQS8yP6ScWVyoiztyqdvJeaGl8cuDMfIIzWBmMVwsCYCH05su3MSU2OlgZ0IwhR5a69UHPru9HEs0cs0QN1HkEnAK1T9xpbD2LewCbLnFatwXSEKY8QdsTgYx5I6ILeNS5IZXNp7WTGVHGNI48r/DPsYlQUY6jv8sz9nA0MXBHwGlGNQsj/96Ya9J1UYRq2mmfe6y/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(26005)(36756003)(6666004)(66476007)(66556008)(186003)(66946007)(8676002)(7696005)(52116002)(6486002)(6916009)(16526019)(1076003)(8936002)(2616005)(44832011)(4744005)(2906002)(956004)(316002)(5660300002)(4326008)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gcU+yqw3qDOsx4c5CB0ek8rAo4gX5Yucd9C9wtR8vK71N9+ghy/hy/sPxXT0?=
 =?us-ascii?Q?HskpOAo2BKPav7l5snBsuBfmAIQhWF26XPJYymQcyXtBPt7v8LUUZ4b/KrSC?=
 =?us-ascii?Q?DP0NMPJ7QKABr8JTQm/JSl9qdSHxQGGzGiakSGnL4M9b/rpoyjyYbDGJfBo5?=
 =?us-ascii?Q?Ve4TF21+C0e0ezCJpJi5vBfcRTFf158Z1mcIXCYM2egXX18dlJAjukdz7/NJ?=
 =?us-ascii?Q?B+Wh9EnnjVayWrYWImcHE9VV5mPqRGsd0hnw1sTV5mWJSft8RP6jRkCqw2D9?=
 =?us-ascii?Q?aVNhhNKcKqYVa7KXnGGc5YPr5xAMrWuJ/RXDCTIhO/p0bhY6LYc7Hi8CPZxo?=
 =?us-ascii?Q?t6jJkEamlWogNARPyDF3gIHIGwUja+lVIU1k/fA4hsf3xKqnv2KCUogJkdMz?=
 =?us-ascii?Q?Z6gXGVuO2Wvo/3knIHEbGaErAbdLHhnqEITTH7sK7v2MZRrGoVgEku4NMLHC?=
 =?us-ascii?Q?MZ0reagQMtpIzjzE0AgibHL0V1lIpM9gq/+WPBfwPc/iY+E+uluQ474Fgf1U?=
 =?us-ascii?Q?ZNXIIFYaKY+8BoCXfRueSK/ouUl3OROspcxxhu25XRmMgMQvdqrbO4wrwr/B?=
 =?us-ascii?Q?ElKGsA42PCMhB6ZcQCjjGquPt1cviluHSnFxTFcOKmHuyrsr9kzgdBmHja3T?=
 =?us-ascii?Q?fqtC/T2oWktiY91DdRQ0EnzGDBtau5W4d9jNg31Ko5GOBizaiTzQLy5kFYyn?=
 =?us-ascii?Q?Fn/JvG8VdFw3Z5OO2jsESTkMEXXE8I2F1ELBaY3qWnjUqyQQ9xBqfvc3oMaD?=
 =?us-ascii?Q?NntuWwfwd5UI7EhsafQHG0nTJXc0iGYwPJC6L3YsoOL5TO5m7F/BvH/TMFfp?=
 =?us-ascii?Q?tUYHIB+yDDEnVa+Dk1Rsu7ZiBWu3p1/8ziVW+qWwCiIHIE9S5e9WnKbLIRsU?=
 =?us-ascii?Q?Vju8xq8AKSylVZYarKL5in7hiZwkrwojmRHDaYNIPPtsNeCsVd9RDWOxZHow?=
 =?us-ascii?Q?863nRSFt2KtxL4s6iwHERYxws/8CzvJHrKS/UQ45xUzVYzZFaa0NY01YpVYM?=
 =?us-ascii?Q?J9QR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1dccad-0a2c-4d88-0f49-08d8b938c02a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 09:34:27.0521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzvdffFC0U1D5yklJbPTVv77lFDauBg8icMUviUbxTFppK/dFPo+TUusqn9zc649
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support Sienna Cichlid gfxoff state retrieving.

Change-Id: I952b652a41a33cdaa05e5294b17a8cfa45a18818
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9ac589248ba9..c34110af359e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3332,6 +3332,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

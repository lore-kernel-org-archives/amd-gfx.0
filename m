Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227FC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844956023E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844956023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360B56E87F;
	Mon, 26 Apr 2021 21:26:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1946E87F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 21:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5tSRk8FmuzAww+d5T1PrBd6Qy9aW0BzjTs6fhUl/qM07Zzw4t2x8t3JlwInql3nmsQo/EgZ4UETATjX6c2B0BmgrvwuJc2YIWYJmpk1VloGNrS2bs0SeQQFf6wZP5uA4EXzEaCqMYe6toOG6c9DWy5iXASfovbApHwY1uLwHwVV2NObVLEtq0heXYE/sOOd4lnaTG7wQroLrFTYXL7nluPgAiCL1zLRNLYFzAyOuN/vV1KtLfPdNcrrccd7ATklXMHAaplfkD2FEfFgl/MP5aqPkGGfvm2fApNXh3yx6NfbMb7yZBotl8VKit5Eg06PSE/LB6KltydSYI3lTn8AXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR10Nyv0j2AzaInStgRmibHO94Lhqa6fsKtrTpKTuVU=;
 b=Ylt+/UnYN4/D2otMTcc1DRvUOTlxSi16KVt8xlP0uIBrYAAmtrgosGsg/C4XJlcLzGDysYBq8glrYPPbjoQlQa78U/eQcb9wFOpemWgCQL5E8B57WKWjxSRmaMLWidqdanqacDg2gwKzXtu1T19aRS/tfN6orDiN6DSHlSY7oAHls2vtvKHX9JTR+fA1W0QI4ZuhSO7FyvOLgmzPW0kmsHoea0Mkb6ewNngGHqD9mKIWd8y0i2iNS0OYR8M07VuChNFR86TV7IDud0oA5K3M1pY05uKGCbsqSYwmXbRu0xAQFQWRQOy9yt0DV/4cA+cesxpsdkxWsuiHL/kVgC3+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR10Nyv0j2AzaInStgRmibHO94Lhqa6fsKtrTpKTuVU=;
 b=bsXF7znb5+PEJRNJZpVTcsjhfB6+RVJKEtLK8brj6W9CnYB2TtE0dqf7ocbVPlynwWPjg74VSBWIGMlpJOEYw+0epirPehQQpfRFHexNoKRW6lMfni1wxykbcVQNM1zgYIEAcYm3AtRqsrmREZ2VGcMlt3MQtbisyKoEIpeKBF0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Mon, 26 Apr 2021 21:26:52 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 21:26:52 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdkfd: enable subsequent retry fault
Date: Mon, 26 Apr 2021 17:26:31 -0400
Message-Id: <20210426212631.8130-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210426212631.8130-1-Philip.Yang@amd.com>
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210426212631.8130-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Mon, 26 Apr 2021 21:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f10f34-2f1c-4a3c-ed39-08d908fa022b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659EF376B56836238F40D63E6429@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7gAPCZ7MosDhRZDvF3GBhqFJt6+aIxaKkfd/Dy9UCBxXd2JOAkNfIYisad6Xkxgc09gMVfqlnbSyOkYecByM6Nuwge4ZvamTpM9tqbP6o+oK8kQHG6uNVCFYuD/haOLFJAppkZgardCdQ4T/TM5iZGd1xEX36ouEE5GCDbQVWuBPgCD58X0pV8jKZP6C7k4YOC0h3tKt1zOuyzrKvLqel8KqfSnGcd+9lHIY/HhzFK4Vi317XRFhhqQCKHQJN6Kr/CFuxsxi1sQu0XmcevGPjZo3Tnae4SKpX11q1LjXBAHZd7XZZ0DdKZD0PnIR6tAJiiaOCRwvmoLNrsbEhtFzRjYtTSpigjLmdGCjhDrBnUT9OcOidHhtKI4Ls4R2ZQ/eZ8AWkPLzkG8mQ1sp1UqdNWTY5DU1eLfcSrbmUM05MnffiExXjqRkZJy7M0xOql5wM+32XsDsPQVcNqtqITtu2Z8xjNRTa7v3NxVTbALKcYf8xd1CSTxf82SkdCN/djdaJOT+wWk2hGRfNcWhUc3T7WVWt6WCpnVWdLwzteJDe+3BbQoyI47VAllSJgBL+gnsptjSUkNHmU2Ag1PdOWgPNiZiWwlhtbAmS7N4Xdpju1Ro/WFtDm3gOa7CZndXe5/fhxzztbZBZ2dWtWMvGUqzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(66946007)(66476007)(66556008)(36756003)(8676002)(86362001)(2906002)(956004)(6666004)(38350700002)(2616005)(8936002)(478600001)(52116002)(7696005)(83380400001)(5660300002)(4326008)(38100700002)(6486002)(16526019)(6916009)(316002)(186003)(1076003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S3QfpCwQCSSHim0M/nFHJmEGGs7YXYlgikJv5wMqSb9jLWKndUulBIIgbGKz?=
 =?us-ascii?Q?7xmCsJ5ZXo4jnyoA8hkZ/AkgE9mmTrswG2jtG+bx0/fCZwttLzSoC7Ny0WrS?=
 =?us-ascii?Q?x9Id/JMcyjEzB9MmdV8x1Tmxx03pnxTVcFyDW6YvqTN5CSuOJB6HfgEaUtRa?=
 =?us-ascii?Q?Am3TXmh1NSKmpLNYXm3s+712uxFJq2hSBiJYVSJW6JSLAHlV3DwJtu/FGYZf?=
 =?us-ascii?Q?CtuL+57B5LmMScEC4oImEc9G1vEx3onxM7X76Xer/IIYbJ/ZtWe+tnZl4X9x?=
 =?us-ascii?Q?G+buO/h1SSjlC9w3S8eaUXR19kiP+F7IKbIj0+N10JzXObUWDtT04a2FT6gS?=
 =?us-ascii?Q?fgwnV8J74PBJDj082cDZs1w0Edl+w48nsrE+ZcW9kwTgrpehz7/hoMIQIomN?=
 =?us-ascii?Q?su2Bkm+zQqOPPEDiorU99q5wq58Q6ewimQYnJhpbck+3B9YLUq8Rln++ddt3?=
 =?us-ascii?Q?neHAABEq5pSX3OeYupnQGwrHdK2h25/jGKtCk026AFIVBS0PV3ycfvw/3tnW?=
 =?us-ascii?Q?k/jsf2W1rm3DLw2MEciTwcn/Jykn6wk47k43ZEWio3O7QlGMkUB7LWe/k0vR?=
 =?us-ascii?Q?20T2m6MNRYwxt1l+6LTchd2KlHblh31663QyGZoa0co2cHTdRgcKxTf5yEQv?=
 =?us-ascii?Q?uFD5JTe+jx3yKnzJxo5D1E5WQq2fCcG5cOlxXA2uSq2ySnxUm0FivKaik+zI?=
 =?us-ascii?Q?d0KPtzClIG2uRC9joMv0Qj9ESWwl25Ouu8wbZaXGs7fBCxxqrW/USyNRslLV?=
 =?us-ascii?Q?bpTTNKZdyHrpyDIJhc/nzScH+xeTMymYMS727sua/R2pJNDtu+LsCGyT8vKJ?=
 =?us-ascii?Q?CFYwrEWWvWy9F/PVp2t4v8owv9qpB0hxvILGkewzU+e45003NuI5a6lRiQv3?=
 =?us-ascii?Q?dHtRN8DshgRcYH069XB0flsL3XZcdSVT3Mth+j+qpMF9lrBCxKLMGqqyW6Pp?=
 =?us-ascii?Q?rtmdCJ4zU0IAYUY3HlkjFUswDhuYmmIsLiyhxPjX1TAE9uX9ykOtqmoHnCdK?=
 =?us-ascii?Q?rFLnMJxAUwKpUJ26a1SEckF/l7YH60tkBSFUypDK2NnacSjyul9vJBZOcaJL?=
 =?us-ascii?Q?ulnBFqBruWBmGdE4Nxr/7eZMWTe/VbpV+TzaHgsDFTfIzluwWReJ2Wn4Sfey?=
 =?us-ascii?Q?yR/kDZxgJCqb1fV1ULRJfhZZCe8AFaKqKEaCa6+2TTvqbh8OPoDpT4k7A27f?=
 =?us-ascii?Q?8S1f1pFilrWfeE9cg49jlvxfOeV29yN1iYv1Nwf1DHww50czsx7JYVse9Gze?=
 =?us-ascii?Q?iUVOcwVPThnqZgOR/JCX9O40hMdNM6ZnX5bvvTPC8mwFsRgbUIjPWq8s042C?=
 =?us-ascii?Q?XkeaXdrdNOkscxOvySdnYwUO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f10f34-2f1c-4a3c-ed39-08d908fa022b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 21:26:52.2494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpfZbGqoDwTXE8b7vU3G1n2ER1HN31H/yjYT+NDYyMyx6H00m1yqP/HdCfAFXHt7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After draining the stale retry fault, or failed to validate the range
to recover, have to remove the fault address from fault filter ring, to
be able to handle subsequent retry interrupt on same address. Otherwise
the retry fault will not be processed to recover until timeout passed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 00d759b257f4..d9111fea724b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2363,8 +2363,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	mutex_lock(&prange->migrate_mutex);
 
-	if (svm_range_skip_recover(prange))
+	if (svm_range_skip_recover(prange)) {
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		goto out_unlock_range;
+	}
 
 	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
@@ -2426,6 +2428,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug("recover vm fault later\n");
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		r = 0;
 	}
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

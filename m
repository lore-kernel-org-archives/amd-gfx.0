Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4EC43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 05:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0E20757
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NA5Ujtd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0E20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF956E97A;
	Wed,  9 Sep 2020 05:50:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B065F6E97A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 05:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/EujuJwvEKMH8eHxc2uNLiJtptdoiYvgCSUDIUKepnG2NXQvDjj3QK6ZJyj4rCz1mmt1XsufG2pL+hdosdF7kMH7hpAQmO0re9YlU+gi8ysoqKExjsYPq2mUX0SvFpkOVgSk4VvY7+LINTr+5gqXXb70U8c5u0oOzxEy+5BXQaaQ9e8ishY3BINS3xQI8rsfF7oYs/tBlusvwj/iHiLgk5I57FOYnY5P84X2SUhaCE9RRRWT/t19neRF5EzBpjfrP6mSC24hKlQ5NMeTm4LIztpD1/Gi3qU8UlNJkZttgEGv2kZ2cDQ1ZvJ/V2NpoT0Y31yW0bMErbPZRsItHhFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brvw+IWaWhtzepM8KqjB19qVnUVaBqReuBohqws/HAg=;
 b=Km5pIfwcaX/lEoV2TfbDLSPr8GyHZvreTWhlQknsbIBleqCixCwN10/8d/Kwy4bVrK+woKnFGI0q49EkSs4+TnG6Cqy1UFGDaG+lEZCZGDGMyQOvYZAKI+HhjC0W4jnJu+wN49h/Wr0lifFkubK3jHAiS0SmpTqAMmJVLtkMPLmHawdiV0xYQeoNN44Lb9KCuKzK2Rw9rHzCZxRSN69VVJc8yZ8jpvjXmaGCNwpOkJix25MZJdTVJHJ0UseAcifu9Iml3IEjNxblkkUn3hve1S0CGRzqcDq9QM7LZrCz3vx8y3BISTcwODAwK1HsVf1iugjgnVzLNFWu/mLbsiyRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brvw+IWaWhtzepM8KqjB19qVnUVaBqReuBohqws/HAg=;
 b=NA5Ujtd4njcikiipIPmkbNZdZY7mNWEVmhmdi73WmShGkGWPWc7B2EIPbcpNs3JWR9Vh445dpHX6DZx3QEY5Yl0mpgPOCiQkSKx4ShRTuqhK4/bwHJYnnc2CK8Ivg17eGbSyqjYzYXeQaCvK57tJNXjKqbUuifXEJO+6OaqdVnU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 05:50:47 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::b525:23be:f194:e4c8]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::b525:23be:f194:e4c8%3]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 05:50:47 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com,
	John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: add ta DTM/HDCP print in amdgpu_firmware_info for
 apu
Date: Wed,  9 Sep 2020 13:50:27 +0800
Message-Id: <20200909055027.25467-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 05:50:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33db4ac0-2120-43ad-2cd4-08d854844c6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40117C982A46B0A23A676F9AFD260@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKVDn3Nik2YJOR9vRkaYdd+36YdwtA1/YSrMd2w4EAm3YLRj4pZROGqy/xFZ7rM6qEIYkpz2inUXvyRLYSkzWArKbPfFeEDV93xcr8kLxyUUPCmAQvuDErTJBauGgdkOcr1UnwpHvDST4JU8jMblrUWE47ms0dnkJ0e+ioAmoOiG+bkjwdK7UjmmcEhyMIS23283NTXq0JfI8EFQwwEVlu0EOPyjpqqvUChAC/QUUi+8D8W9httwa97NLzgcx0T2hUPwK7XSdxSqwFDH4TBbXq4Mrg6Lt77JCoXNRJrmcmTL+c2GWv6whYFu70KKME+PfbcbVOXhrDn+QdiXVJh+8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39850400004)(346002)(5660300002)(478600001)(66946007)(6636002)(36756003)(83380400001)(86362001)(7696005)(52116002)(8676002)(186003)(26005)(2616005)(956004)(2906002)(16526019)(8936002)(6666004)(66556008)(1076003)(66476007)(4326008)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V1kIdcTtBCGmaWVH6mtaV6JZb/njnbu/5BKVwCxyZ2bBtkXS2+d2bYT1wOX7mbl7Pk1VsFCGWAaM/dt/NpgCbg2JtsWe1MWExCRmzElNhk+UdMwdDFg9hhSfmQfR1c+aNs1ioo2UyCoSsPmOgjBKsf79mJXPGhJfxs9UUjfXdvSxUk91s8nh1gIItPtngKTCKeqUVjltMyoRuVBaEJcBMMnknm7zOcC5XC9YPRyKEi5sDKP8kGw5/83xhQmVfz/C5RESz7oKciDjRdiVSLMTj8E8LwUiwk//oSePys/hzB/rrrh9oyGrUmOtTPuBO6GDVQ06J+PbLwVOCeuK1/DlaK3Cj5tPqRd1l9nYPT+yhmjA9d1alt2eYuxr0IP+WDA5Er3P7PXkel25tFYIjhSlErFOnAz+p94feQhk2x+bPJdD7DPo6/R2TdiuZitWUjhWzvJYp22e4gplxR4QMugbk1m3ZnbRUV2IjcS54a57ZVQ0oaxC4LVJqMQOaMF2zY7v3V4W4Hh+hIprDM8kPInC2ptzGJPIugdYZMHqq7NRg8RHE3Dh5DHgWCyoSlebdWE1xT4xgnwXiqIGoPVrEVjZjYYQzExSI3LWZrlZIEDvSoshvcLWJMHCWVKr5XMdtaRYLvk+K85E4hmyH6hUbXRD9w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33db4ac0-2120-43ad-2cd4-08d854844c6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 05:50:46.9983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7VTbwnVl9r1Po2Jfa6C5t3XfB5WSmyi8VK2hG/x6VFY1FtaKLHv/OUmQFC3U0bT4BSrQz+l8hn3EDrJSUSQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to add ta DTM/HDCP print to get HDCP/DTM version info when cat
amdgpu_firmware_info

Change-Id: I05f20d6868ce2cac06a8496890b766dbb61de671
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 43 +++++++++++++++++++++----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4f6b167fef26..d7f37cb92a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -282,14 +282,25 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->feature = 0;
 		break;
 	case AMDGPU_INFO_FW_TA:
-		if (query_fw->index > 1)
-			return -EINVAL;
-		if (query_fw->index == 0) {
+		switch (query_fw->index) {
+		case 0:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
-		} else {
+			break;
+		case 1:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_ras_ucode_version;
+			break;
+		case 2:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
+			break;
+		case 3:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_dtm_ucode_version;
+			break;
+		default:
+			return -EINVAL;
 		}
 		break;
 	case AMDGPU_INFO_FW_SDMA:
@@ -1383,13 +1394,31 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 4; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
 			continue;
-		seq_printf(m, "TA %s feature version: %u, firmware version: 0x%08x\n",
-				i ? "RAS" : "XGMI", fw_info.feature, fw_info.ver);
+		switch (query_fw.index) {
+		case 0:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"RAS", fw_info.feature, fw_info.ver);
+			break;
+		case 1:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"XGMI", fw_info.feature, fw_info.ver);
+			break;
+		case 2:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"HDCP", fw_info.feature, fw_info.ver);
+			break;
+		case 3:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"DTM", fw_info.feature, fw_info.ver);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	/* SMC */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

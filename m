Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86712C00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8C12077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="spQr9Pch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8C12077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C2F6EB7D;
	Wed, 11 Dec 2019 15:33:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F63D6EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHBwKol0A2FIYvJYowHUNN6yskGphl2sSRRGgNUjWqi+cmEkoN737gtiQX7RMEfF1ei7qMdTH3hUUhrhxSyWMd7HNgyrIy25yifCqaBUQc+74AG/cYaJrYe+swkROj3fMP3Qo4tyzC22jNDKOyXdCLhCZY1kldbfZU+u37d4hz75ePAuKVPCGfzEpOa0sHWU/hZ7HNBKPkiYdl8ScR3gWHXjx1+yscT2P+vMSHBzG6MwRi7nsmpnRXymn3hxXPhPp7lB+IQ3E1fvGWun+tGGejvipW+Qy2CJ2xT8J3qHQqn4xUx0cRnH3rbseaMPJ0JEIT3Bab1dh5JT/iHyFkA/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMv2JcpwX+RTyyL6LA5i68TJ8LrQVbv6svY8odjAXKQ=;
 b=oVYu8yktiSG6yXWslaRczG6qYR+uNU/w4AtKPDs0qr3DfJO2iokCIhaCNASoobF4wYGhI+zZmThehin9zRZmz44YcV5A10ALMHmXD/OzUdBoLtGL6726A6uRxiOr55NxWAnHJaGuu0KN1djPOVP3kjuFSF1OsinJSOn4iFHWOsC/QQ+d1vOMbQ3/JZ14QWxGaxwJB7CHqKy25PkJSEMV55kKnQl8ct7LKT837yDUuToBiC2WBfrygrA/QnhAcEDlN7X3CxE6trXQ9BfcFXc1YIoAKWIpj4pcm5pncuReVn5QbBN4G2+7iTw2IpSbEyPXNRX/khVllNCUHJDZqNEfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMv2JcpwX+RTyyL6LA5i68TJ8LrQVbv6svY8odjAXKQ=;
 b=spQr9Pcho+Cq2zFOsNLO2UjDashm83bwMVdEeEEEkqJUmzkyKsv/Ou6u6FcoXWR/hRrCZq8FTS95ajaoW2abbZzAIHE62xIkqCytokYlGufCim2m5qy6HtPBFiAYDSqpkpVsjHOPnYCvX7n05Td1GfNlqmncunNCmds62vZemKo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/39] drm/amd/display: AVI info package change due to spec
 update
Date: Wed, 11 Dec 2019 10:32:23 -0500
Message-Id: <20191211153253.2291112-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ea012b4-ab98-4d7c-2084-08d77e4f7629
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2426414142CFAD5C20EA5FA3985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mv1eZLsZdjDsKrxZPuzw7YIlobzAoxNDOluOsrYiMge0HfDN6n2+gnoIGQRkwWPLwkphgFU3vzy5Eg9BuZ44ARstb8gPHcuy3yhH5abQCeFaCSbZ0mPxuKu29YpXWyZa+k1GSNiampfm7rJzqKMTwCd//P0SEj/PiheRUHIlvBYtE+8Y+0RnvFn7KBxTyyaEbpKvPk2MKLEOiWiENoEK+htdUbUahQYUTiTMvAONgBTi3BVCsC2hi/bKFOf3dP0Tzfon7z5h++juzmIekI2TkY1mshvzjDGKr6nHLb1rjVBl+8WNoB44qxjn2bdTjF7/jBgjt6g5gY45ixKNA+nijk24MWKy49/6J89CqfYQcQPyGPv2vsHqmbhBs4Je0vw7SSdiMJCodiTxCMdbKEvIeKTXgqKsAJEkpbOARa7nrtlY+xW/X5MZp4gjYU6tWCzj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea012b4-ab98-4d7c-2084-08d77e4f7629
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:24.8755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsdRjHvDwL1LzNWSiNPby6DC+s7IBMIsT6mVtEvHk+XOlb2xtzTCkDSKKVGBY9bt9RggCRK4bgJi6RBl8biFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry.Wentland@amd.com,
 Charlene Liu <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

YQ should be limited range for all cases.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 39cc71bedf69..4700c785566b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2297,7 +2297,7 @@ static void set_avi_info_frame(
 		if (color_space == COLOR_SPACE_SRGB ||
 			color_space == COLOR_SPACE_2020_RGB_FULLRANGE) {
 			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_FULL_RANGE;
-			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_FULL_RANGE;
+			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
 		} else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
 					color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE) {
 			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_LIMITED_RANGE;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B18C35242
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 05:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FB82070A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 05:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cUa0VNc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FB82070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB22C6E228;
	Tue, 11 Feb 2020 05:41:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416F86E228
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 05:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtPlsnLH3H+N8bP7lg1L6h8DKKXuX5TwOsRFwhTpMNA/PCpB5fIeuoEdc22iuPT6X5ou43xmmN/W1inDT8Zxvb0eFd9UvupaZ3VQtRQqJ2QWaJq+LgcR44LBXWfmub0/Y5uNV1f1CHK9egGhxSP8xWX70dRR/9n7Ep9k6fLnP+4ixRtVeLpnBT8L3i71Cs99N9VHQOBoNpaT03AYnvj5bj25bv5zZRdIfF8cB/EKRTr3qQrk0d+P6nMupHXwbGZjzJFsVVS11rnkg5T7jNAQz0XIHmr4tEFQuGb12K2ZZkp9QRMYdXAFepNeKMl/Z2flYnBrx0pwPexHK8I5OYen+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKRaodSWiRHuj6ziS5E32b4avtGCuF7Ir8rMpoWV3/M=;
 b=ddm1qYlCNWBrd1fORPONf8zeIlFknAUoivgdfF5FnTUsXnoEH+KGcn5ig0w7oS9jHnJv95n93C74xGUdgLbbyks11DDbeWgoFtMCqNjXR08A26TieypJEi4klgnZ9KMPmHkZRtafUPYFhv7KIUT7rBqNmr2NK81kDi7j0pubqdT3b+ZV3ZDSQQ/LbjLESdol+iF6TBBWZa0rdkASAeCAZd+VW1+hSoA1fFKBIf5TU+48QJiP6BlKVXcu2ko+lCTeWZ7n+KH+zNj6LPx2Bz6FTjNHpXX5hYMCEXMlbBPXaBsNUkejcn7np9kGWXW7JyNQcRRIyvaLAm6TCaTJN2vknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKRaodSWiRHuj6ziS5E32b4avtGCuF7Ir8rMpoWV3/M=;
 b=cUa0VNc4XPoCzDJ0myYvbfBMla6e1OvO7o7/RxIqa6+6q+atwFIB9YtaKAGeFvfY8QFoKp8z9IDOyofFz0Oj4hk4OuqrEAETduE6V/Qu3WEZK65Ock0ndIOiz/EwKqJZjvPZMkIeZZn8r3WxPo1llypLbw/7aOkGKh0oiDMMLis=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3824.namprd12.prod.outlook.com (10.255.238.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 05:41:42 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 05:41:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: always refetch the enabled features status
 on dpm enablement
Date: Tue, 11 Feb 2020 13:41:21 +0800
Message-Id: <20200211054121.32154-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.3 via Frontend Transport; Tue, 11 Feb 2020 05:41:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13dc4819-4f3a-4331-5b17-08d7aeb5129c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3824:|MN2PR12MB3824:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3824F527714D57CD6CC7E5A3E4180@MN2PR12MB3824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(1076003)(36756003)(16526019)(26005)(7696005)(52116002)(186003)(86362001)(6666004)(478600001)(8676002)(4326008)(81156014)(8936002)(316002)(956004)(6486002)(81166006)(2906002)(2616005)(6916009)(66476007)(66946007)(44832011)(5660300002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3824;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKWFyDDWmjnoGqUx1eeqVbM+N2P04ehxqOhImuZRZo/GFPN97hREX6bhhZmmgngB+BuccuW9rE8Q6R3hTvVNdFJ2+O+gJ0KEB6NPkcyo6I03GlnrcIWYvbRjXW8M0/j+c2N/x2XIkcnINYEVMaOl2M09L9lW/+5Wo2oK1zKqvMb6xdjtzXBI7ZMgNZELDuAWqeZlfIjNQnvJdyjPkYh8IyTdplyOh0ECfj/7UKOJMObD4JHqzJODv9/KhyOIXwIBrKrOOqZ2ralxwK9IYLdtTEW8vLaS1ap8nJDlDWtpwV7N4Wwo++nfnhGWzKog7pecAjtCzvi2Lq2MjsC04Ptr99k35OutE2pmyT/lsTX+ZBcbZfXg92XzjUrYMVsqse3kjwFpa9OtLc4f8uwkdY5PWKAO/hK5eenvF2byeYhg6fd0o0oyI+KAMPynGDl/FDrh
X-MS-Exchange-AntiSpam-MessageData: mbTHtXRqdyX5hAhFX4LuwdPVx3VvhofsBwndT5llU6huIXv69LJJ44nGolIKLFYWWtVEI1shcxwGB9PsPOssEevqRwbzr4wbYbVSSesMwJ+61Toymvg9gc5TF/mAHnRccmm6W45o548RnOl/MubK8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc4819-4f3a-4331-5b17-08d7aeb5129c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 05:41:42.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CadrFkaItA7SP5rQvO0eWM59f5RTgmB/ZmJV/+DZ/cGmxSZB/1yDcfOQbML/QUvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3824
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, the cached dpm features status may be inconsistent under some
case(e.g. baco reset of Navi asic).

Change-Id: Ia7d7089e82cbe4ccaa9fadce1f2f0043c42c73df
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 0dc49479a7eb..b06c057a9002 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -898,6 +898,9 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+
 	if (en) {
 		ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
 		if (ret)
@@ -907,9 +910,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 			    feature->feature_num);
 		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
 			    feature->feature_num);
-	} else {
-		bitmap_zero(feature->enabled, feature->feature_num);
-		bitmap_zero(feature->supported, feature->feature_num);
 	}
 
 	return ret;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

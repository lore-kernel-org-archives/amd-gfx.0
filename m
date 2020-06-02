Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47887C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 05:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4752072F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 05:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Av49efwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4752072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0256E13D;
	Tue,  2 Jun 2020 05:58:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA756E13D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 05:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOlI9PWaxHMufMH4Zxreq3wub2rBW9KqmIMpaBaY7u+Pf2yh8yOz7Ho5flKloWi65zWY5XoGUR65gXOtibRX39T6qhVlnDepgiA+fx5g2O9PpjbE7rkRp6bvgG9CEI73LXg1uyBJHYL7IqAJJZMWyVmUUNgJ7aNs2kNYvzSe0Hys0ESHOiX+riCXSI8u02KZ9CHi6hjqQWTyhZGXOdc1WqSAAaK+J5mxfBcPPZu02mPmV7o2fOAH5T6FkWsl7aISrPj4aNlBHfs8imxYUyVEiJrK1269LsBBL+nSwzvK/MKXxNfi0583gEeBAY7K8pyXDALbYUmP9IZlyokAh8ucEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCNkgumL6jPkdcM0gFgFmw40AT1GUNN04YdOZkhgASI=;
 b=f4a5wqXkYxai6zjJAy8XRlieLAFKmimzHBwjZ2KS0JHR/hoBNJ+8MSQeVGqaPhc3tWf9COWKsTOSI0SE/6IxQZH0l0vSfGnZdrSha5K6/iDPHq9zzSfKzHRD6NTUVsUp+5qtLmlTPRpyjW92IEKK7r5/iEn2LQdNBBVsj4F3elnWQw5v8SlviNVUVnJQebDoYbCuisA9Oj2fwEVu0ftxq8P6qM6SOoDI8Dtxo/FdwgEcyw+unVpRSu+yFDV9N7sDt8BUgG7D4/+K/BEqHDSom4kiOx9OyCbqQwmt2PO1KfooVILIpEuzYcYq2+UAmkr76vsGeifirLgcb1Vj3Fy8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCNkgumL6jPkdcM0gFgFmw40AT1GUNN04YdOZkhgASI=;
 b=Av49efwxw2WNWfcnRzrbyNP1QFAtThKcyOsq7Nw5Dl3DT47BWLd6vyKaicNE0KhIkB7+iykg5Mpg0NQ9G9C+98HmOP0jXGZhs4e3LY88oupS0hqLSMzpxu7av0BLmoi6CYOVM8KKs4BLL2ZiZC9WvYjh2X2uLUPGXUIbrHH02YY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 05:58:30 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 05:58:30 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Dennis.Li@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: remove RAS's useless code
Date: Tue,  2 Jun 2020 13:58:11 +0800
Message-Id: <20200602055811.21651-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 05:58:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ddd80e8-998e-4eb5-021c-08d806b9f965
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB15750EA80AB3A31B4AEC2F88F18B0@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2uaAMM8oJpQaBf0OrWmDAEfOUOtMp3w1Sx4iB96uggDrCU2ZjWJEovIEoFQeBcan25gp8flH93yl/qmBV7SDQuj5zBziJPEaqve9ypMy5QAlpX8gROxWzWeA05xkotJ6BWNTqVZBM2fincrFUzutih6ErM8+mkFpajB6XX2Ype7nhpPXjSi4nmkWTKOh12SZ7xI2Q7HI7tFRNAZ5P1kY/tdMzjItPOQfCIjqOHruExvih1Q36Kcl2X5LoXH5OcQczVarAvaUxAS/ibICGHhpIj9eCSVLIEZxYeoj7mddgI/T4OhGSa7dsBmGPsl3GDSnRWS2b4lzZD3mFGHsrY+Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(2906002)(86362001)(16526019)(6636002)(83380400001)(66946007)(8936002)(8676002)(66476007)(66556008)(6486002)(1076003)(4744005)(186003)(7696005)(26005)(52116002)(5660300002)(316002)(6666004)(4326008)(36756003)(956004)(2616005)(44832011)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WVffcz5k3YSifZXMYZPRXdpRQw9ECQxy1sLicjfR7yIytOYm19f9T8tAV5CxWWjRECh9og/CZr0aIhZtQQrNvMXcF7CcdlZpAKLTwGFOxxW7KKildtlm9IosQw5fpOu/72xDzHm5j9mvGCmGFzLdCpGPO8q1vdXuk4/wJKiDFncBf5Qxgtb8ej4vZ/eVAoe+Qode82Hs9NXBbKSvfe6xKrltwtwbGjUyrMZVYJSEiWGcVknlQ+LhAyNRpBF5s9ArMfFQfGrAsPOut+Hi/MoG/oH0ohEUQRRNzZR6tYpXqnlEZ9pksLCNmgKB12O9DeUwKTmMej9CB1hoed38dtkv8tsOOEdAmdGVbbKB7TCNCpirEUQgFQsxSiJn6ASKVSfLJv7JGRqdASk87TCU7xFnE7/xpRY6WZ3EXpcV6kM60G4Hw8XYFVN0729rBAv8YJeA6Fl4Hxd1cyz/JkCKvhntXKk4LTsTX5OlPJ+eOGguxr+t+cQo/0G7gUJ6d1P9a0VI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddd80e8-998e-4eb5-021c-08d806b9f965
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 05:58:30.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PlzOu9UszBkfuw3mCPu3xGa3G4jjtU+ZDef2ur9yT7M9bZIjydJEkoHM9xDCWWEAYc/SMOK6I08sz0scGK6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Module parameter amdgpu_ras_mask has been involved in
the calculation of ras support capability, so drop this
redundant code.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 79bb05d791bc..337bf2da7bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1902,8 +1902,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto err_out;
 	}
 
-	amdgpu_ras_mask &= AMDGPU_RAS_BLOCK_MASK;
-
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
 		goto err_out;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

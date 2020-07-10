Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D59C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EEE206A5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sayaDQX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EEE206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABE66EB5C;
	Fri, 10 Jul 2020 02:15:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4145E6EB5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 02:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJX3ZnuqJjOywzokELT7viM9iW5SSfUumU7xYG/2e0Kl8UTqURzVuTKlYPIgNouqKdx5q8U9VsJQnxKEYxk9tA5LBmmCESwLwBnYongBiakuZRSsZn+H5Ac61WhdeJtk/DY7vysjhRs3uIIjuUkOm/j0A3oOq7UFjuuYf7Aal3BudB5yLtKDJ1VkwNcoosy2GvvgJE42bF8zlJ1DfqMpJ6ZP0MXnMOVKXCBs30wMHkQe1+NPReYmW1+9Smb/jYLZKKTE39jS16VI1xCXzBsAZ51cP+q20idr5s+zC2JLFFW2NXqKZ6xcY9PMB112wIXrk5Wp+8mkd7W5Dn7FHG8Orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMtZZcJSTr6YB4W4hwgbidQ9D+kQJixw+OKgDz4Sv4Y=;
 b=WPuqlZlLilyZfOLwQ0i5oETha7jeIMblHC4J5gMOeCnRVTc1oRLaj0JMKQsi8cE36q/avRJ/IImKORhKA2Mja77MVcqrvSMMk4Bdbkh1bkW8cwn/HYnZdSPmq9pZhfQmcvenvvGAhciiob5f7zrLVDZj2S9VlpIO+BNiyfj73Yi5AswMfdwGDcdu1B2r6XvWsQWt+/7l/nObikJTZ9IrLQ4eZnvTWZFwzuasoan2NCwH9BweyuJy8UJWGe8Kzjz14Nf3eFbad6VgXFK2mSWkM1fl4dtPYlMVR579mhL7xtbmSQf/+GQNI4XRD+HqYdsMtZiZZGh/WXBm0QfqjOceZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMtZZcJSTr6YB4W4hwgbidQ9D+kQJixw+OKgDz4Sv4Y=;
 b=sayaDQX2stElTeszXEq/cI1i75q7Qo7Z2zYCAfbUoAo6vJmLXaGY1P3MfYk71ZtrZ+9yaCHezAky3cQN/C/eOGplSmQ+5p3K2lJq2xhXaV+dIkYnLXS6nR/WSUm9YdWPdXCgezIyZhUo8qt0w+pYxjvXmlEyU8nqyDde+K2tyz4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (20.176.117.82) by
 DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Fri, 10 Jul 2020 02:15:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 02:15:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/smu: correct a mistake
Thread-Topic: [PATCH] drm/amd/smu: correct a mistake
Thread-Index: AQHWVd1u44tLv9AJNEKXuE2/di0U+6kAE+tA
Date: Fri, 10 Jul 2020 02:15:21 +0000
Message-ID: <DM6PR12MB2619FAD7CFBF9358EECACED4E4650@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1594291251-5282-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1594291251-5282-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=095b1d4e-0540-4d32-a182-00006d274261;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-10T02:14:22Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfe6fe4f-7dc5-42fa-db15-08d824771906
x-ms-traffictypediagnostic: DM5PR12MB1449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB144970A41A25B8E3CCE8A889E4650@DM5PR12MB1449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 046060344D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxGaCIXFgiyDh8IUtBEq6q4LAc1pQr3L9vEPliTr1Up6kAkBf4FxB299wekZoOAzGLre6uICBM5Jp4GpT4dQy2aB3fYlt1bNK/Nl8g1hi6rt5GuOC5CeMJAPK9Scmzgo5k56+FJaAQ3c+9wMxnhExSMszdd7aYnHngHmcRHLW0Vl+W+Pf0nHK1PRokG4Iy5X9mtdlPJCdTa+GF0jk5N0xcbQsp4Lfq/D09DSlafv/Zj8VtPs/IvX9aNiT5fgA1OxrytCfz/xxFh6SwbnR17Rsl/9uqbaE47ZcwgsBRjaW7DaXnFtLoPXZL/1u2dycsUhUkDj5E2hHqFfeMwIcUWpKQdPxc/kWJppzWUh4DXE5fk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(53546011)(2906002)(8936002)(9686003)(316002)(64756008)(71200400001)(55016002)(76116006)(66556008)(33656002)(4326008)(86362001)(66446008)(66476007)(26005)(966005)(110136005)(66946007)(478600001)(83380400001)(5660300002)(8676002)(6506007)(66574015)(7696005)(186003)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VYwqP+5+gIvTVm7WOaZGfIEygzfHA1btmUqZ1aRXfebaK908TX5h82sPBcd1VdMEBiEsfVUmvR3uPgak3ytQSK47Bi93fIgS6qoCUGT+pUiTezHMJ8GQF8SeK8W8RY90MOfsK0hgaAAMPLN/Kp69oN6xL+729vz8P9B9NroYfXYAWpbatBV8e8iAShGDflaqh+Cn0uhPX4Krr8zxrfbX9kXT5N+x8B0BfVJ6g1p+PNdapnlYTU9+0YZ2eqka6xyiRgpb5a+aImU0GUBLQOTktmp4ZVyTqof0LalaS2qo6sEPhQbk/kPhAp057ctyGXEI8UCXm9OmGXnXEt8oSSpMUMKTLTQW6m1Nn6K+bgyCe/B01+SS/oz30UEsWDSU2+WWu22iXN+RWNx6XexFJ47Xx5FFD3QX2YluMjlldGU+h94jz87nX2aaxooG4431cFEy9yci5iT5zNqwxbkD2OOz+7Pgn88AAoZWPHiCKMljkwz69bujTJyfPQy+covERbwU
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe6fe4f-7dc5-42fa-db15-08d824771906
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 02:15:21.0853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rVDO1T501NYxzDkIWysGEK+i9J8K3cJHHPaMIuvhIAytd0pz/Ye7jWQXMtT1taW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

There is already a patch for this.
https://lists.freedesktop.org/archives/amd-gfx/2020-July/051134.html

-----Original Message-----
From: chen gong <curry.gong@amd.com>
Sent: Thursday, July 9, 2020 6:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH] drm/amd/smu: correct a mistake

Corresponding to smu_workload_get_type(smu, type) is "get_workload_type"

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index afd786b..31e1fcb 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -77,7 +77,7 @@
 #define smu_feature_get_index(smu, fea)smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
 #define smu_table_get_index(smu, tab)smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
 #define smu_power_get_index(smu, src)smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
-#define smu_workload_get_type(smu, type)smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
+#define smu_workload_get_type(smu, type)smu_ppt_funcs(get_workload_type, -EINVAL, smu, type)
 #define smu_run_btc(smu)smu_ppt_funcs(run_btc, 0, smu)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num)smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
 #define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D323C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB8E2073C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 07:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sVmiA3F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB8E2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934B589217;
	Wed, 12 Feb 2020 07:00:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82A489217
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 07:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRonDd+UauMOM3ErW1EzjwXIokVa0z/E1Oe1SEEZe89gYLJPxgx3UMmliBbgrBJDYPuFF4vUW3JGAeGCbbEgqcqqlA5XKIPpgii0enxvv2L6iIxjJIFEW/2AuHkQHwTF83FenHsSKlxEei84msAWJkgNwpo6p6mKEmFFQM9GYWAOjYgFTdAdv7W7jI+xgUzypehJukjuiTNGu6BxLc5GhFuczEHh9TNdzPn4x4N0jo17dJnNVg7PlETH8N8cbyTcljO3a3R9v1i7OTNpuyUdbQaeGetpVkOE21ndScc8dJt5t1jFI0B3qKbhrL4kAKE63/jgCgEwlrJIhGsxR6uiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GigadHDGgcNJDf1AFRkWhI3pq0Z8MNSwZImsHCWP5Qg=;
 b=ZltPFIuhgLBP2XhHkJ62vZCzEPyN0JbCdb2teWO9RqvQI41kK2VwWld0qGhXIUk4wBs7MAREvVfpFGceRC5NM0n4HzidCFlFRPZd9tp+TrBUaVvFYFyit9jThknWpYDY5NAKAPdyOVnZbWwIcFrb+h7D3Zt2biKWN0KkzarqcJgDgmnsotOYpuZQZv1LAug8gG95ktZGBZXsJ20nZ504Qj3hVMGcqMP/7xQyTjftmmJr7OMSRkKJ7JqLvfe3viSQXAV2Ye+MG9AZ/2zt9yeI/Bn65bBQnETmpVpjtDzXAg7FDAgEoXoG+5rSDUoEPSc40um2unFoECWaXLwjxep8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GigadHDGgcNJDf1AFRkWhI3pq0Z8MNSwZImsHCWP5Qg=;
 b=sVmiA3F315p4SSRC0CPp5Cfs9rYAmLD/hp/vlKD3BoGA2cyYNizTO9j3SmDRmaMOqsuStxzQ07qYqqPr7TZ3Ml700/72IVAK+6xofwkzdOdBWKfmCfyk8hjb2/PIV9Vb47SQMeGn7mCYaumdLFAbaJ36r+hWGk5WetUNK3HO6HU=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3951.namprd12.prod.outlook.com (10.255.238.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 07:00:11 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 07:00:11 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: always refetch the enabled features
 status on dpm enablement
Thread-Topic: [PATCH] drm/amd/powerplay: always refetch the enabled features
 status on dpm enablement
Thread-Index: AQHV4J3zPeboTt02CEyVk7wFNcX/LagXIrCA
Date: Wed, 12 Feb 2020 07:00:10 +0000
Message-ID: <MN2PR12MB3598F1449A05B15D843E2E058E1B0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200211054121.32154-1-evan.quan@amd.com>
In-Reply-To: <20200211054121.32154-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-12T07:00:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=65af38ae-36d2-468d-99d4-000008eb7fb1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-12T07:00:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4bee6d30-211a-4093-aa40-00003070439d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [101.88.133.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2acc4262-7a3a-43aa-8fb1-08d7af8933cc
x-ms-traffictypediagnostic: MN2PR12MB3951:|MN2PR12MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB395177A39001BCC8C457BE5D8E1B0@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(316002)(52536014)(71200400001)(4326008)(8936002)(26005)(33656002)(81156014)(86362001)(186003)(81166006)(45080400002)(478600001)(66446008)(66476007)(2906002)(8676002)(966005)(6506007)(53546011)(5660300002)(64756008)(76116006)(55016002)(66946007)(66556008)(9686003)(7696005)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3951;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAh33LDGcJ47Dg55UyuQGIZtB8DvIP517mZehMVGLZNFCyRnNXqNGr4Kc5TTDjf1k/eF/kxiFC3yMm9EO4CHu004TqjWS8W6zb/nYCNRF9y5C7fOG9DsG0o0mxB7J2Dhjpsv+6r8C0AzXXi0Klw5XrZaXbO+FHeODum/t4v4V1Pc73liUN+81A+D7QwfhYfSinuXh/cuAtUJ5Me0rL3Mb7VCGeIbUg4Qrhs7XdJaq0RUxBqyBYbOgH4tUN8Q6m+Smc2RIfsp1pF9WhmhNhfws7/8hiDA30gXpQS/UmKrauF10Lfe4FZYDUL1TdCfzdpDhYAjqgd0CH7cGTCRTO5YgIf5Jmlxzb7YSiSFg+oWigCZO4ycglPUBUgt+sqjt+egoXneuMCytW5PymOUPhFm/Gs87rbHkLc2uanKVCAOlo7CBj7mLNIu1brnXnNTrMBtDNkYOvx1+EOLJlGoxUNa49wPck54o6zXC4n2ZLit6kj4porvYqf/7UhMDkYirG0CVEhCKTadJVTmxR4OzXEjjg==
x-ms-exchange-antispam-messagedata: Pfe8iVxUA+p4hw5wza3a1MvvDAjyXEb90K2K9ab1sEpWAomXyNzmGz28bREpB+poLIyKfNBBOIvU5rUxC0xQSA8r3v8LyxfrGPkBpA0k3J9KlvgPJMfIjT0sxNWJj3q+twBx39NwHjpB0ki9FbIb5w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc4262-7a3a-43aa-8fb1-08d7af8933cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:00:10.8700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+0cwc8tlzQu/u+Vp8S8TqaJR7YSXHI9UsUPesIo8jfPkIzkh9hQeKDltBJLbQ/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Tuesday, February 11, 2020 1:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: always refetch the enabled features status on dpm enablement

[CAUTION: External Email]

Otherwise, the cached dpm features status may be inconsistent under some case(e.g. baco reset of Navi asic).

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

+       bitmap_zero(feature->enabled, feature->feature_num);
+       bitmap_zero(feature->supported, feature->feature_num);
+
        if (en) {
                ret = smu_feature_get_enabled_mask(smu, feature_mask, 2);
                if (ret)
@@ -907,9 +910,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
                            feature->feature_num);
                bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
                            feature->feature_num);
-       } else {
-               bitmap_zero(feature->enabled, feature->feature_num);
-               bitmap_zero(feature->supported, feature->feature_num);
        }

        return ret;
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CKenneth.Feng%40amd.com%7C8aeb99fc3dd046dbbaa208d7aeb51500%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637169965081222255&amp;sdata=URbAy4MH%2BEMeU0IgSbARjEql2%2B6Q3Docn5kqMByize0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

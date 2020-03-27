Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFDC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 04:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494762073E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 04:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IZkolPf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494762073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FD26E233;
	Fri, 27 Mar 2020 04:04:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C7C6E233
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 04:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzRzj1nwxWbg7LsZTHQ7SDBH3SY1PmEbBZa5cRup4qGVt3LqHUg6HUFpM67lrRVqZpnt6DQnt+YLYGvm5ll68X7OGYs3ohIersJrTJkFe5AtSGAIUpiJUu60xkiatVo1VFhInbrrWPHIaR/zi2KyGANQ8UBgrf2lM8VZ4bvIY+XSHNNNfDLQx0Bnia+476+ifmx/K4HbCqmHxLYUkGluLS8HOH7wgjopR+aW93p9nkK3E3GN9QHsZGkKCNAYKkSfIlcxiviH9kWYIrUZm+gSLXoDGl4Y1LNtNMGd+7m0ETe1ulmlkDyU/n/B+VjNoupAA6sQcFaSK3CxvJYr9We1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mllN8f6tzOrTl2jleBeBRlcm8yLIK3h3gTx1o3h7WIo=;
 b=W/Z0LRQnEoQ1dzkATiiZ+ssJ8CKFBJysUg8afxWxoeqxYzOEIVRELhOmsOhEVXw/zMs7HXwo7ohQlafGwfX4eGOtI0zKMRAxV8pOEfFPboXM5QEeWmetstHhLElHLUhppE3KF+sAIYoBGP5VtHY0MxoNsA4X+pTb8x6tlp67yD7n5cLuCN3AAj8VoDKh2SRlYibnE3vbZHtaK2TdSzZGdFZnvs1KjixYFJvfBkntmHW+1H9pSdjsn2ZEUTScq9UB7lmiUOGsemYPCuBcgUL2OwPq/4CuZW+Z762ddNnfc2+C5pnnYh/P0NjXKhAAkMi+EJfvKkQkJAnuE50tJxf3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mllN8f6tzOrTl2jleBeBRlcm8yLIK3h3gTx1o3h7WIo=;
 b=IZkolPf1joqfzEkwsR0NmfcsvKM+UTaPH3xC9x7fI6EolFAqyFKbvIDrZahyzClTptBMMwhYUR4XgUPGZb3PIptLEmlmGm9BzY7LSTWS4Kb4Moyxv4pmGnPujSAHFPqZJrxEUylhD/tjnlvt6blAZ8ZXa2fQ1QOp3hwbTbXk7q4=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB3629.namprd12.prod.outlook.com (2603:10b6:208:cb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 04:04:50 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::3963:fef3:d764:bdc1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::3963:fef3:d764:bdc1%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 04:04:50 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/9] drm/amd/powerplay: avoid calling CI specific SMU
 message implemention
Thread-Topic: [PATCH 1/9] drm/amd/powerplay: avoid calling CI specific SMU
 message implemention
Thread-Index: AQHWA+mwOSyaH5C9gkqkn3WYRj1886hb0b0g
Date: Fri, 27 Mar 2020 04:04:50 +0000
Message-ID: <MN2PR12MB35986AC3366D9EE1BBE792418ECC0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-27T04:04:48Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a7273e0a-0e24-40fe-aa23-00000c7a3ec2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-27T04:04:48Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 86b0ddde-9d4c-4d30-ba3e-000020da4ef9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [240e:e0:8f58:a400:a57f:e86d:a89d:bff3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29bcb11c-9244-4872-9ecf-08d7d203ff68
x-ms-traffictypediagnostic: MN2PR12MB3629:|MN2PR12MB3629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB362971DDC389D16DDFB64CF78ECC0@MN2PR12MB3629.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(186003)(64756008)(66556008)(8936002)(81156014)(66476007)(316002)(71200400001)(5660300002)(81166006)(8676002)(55016002)(76116006)(66946007)(4326008)(2906002)(52536014)(6506007)(966005)(33656002)(478600001)(110136005)(7696005)(45080400002)(53546011)(86362001)(66446008)(9686003)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3629;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zrmf3KX0xS7KYeirSRXD0pcimPISnXDftjiZLtVOBPcxp6s/BWpj7fDq9gw+aPo3opR36hasBxPDL5LNLCXxY/2V1cO6OCFSeoRybvXUXNVJhsNojm820+Zexcj/SAaPKEVpti8lCKdiVPufoOGw0SPsyGd3LEbkWE4w8gOUUuDGNXEWkrnH9Z1wgyuFRaNynAjWoXZx/eNxYCseSqr1KOM+j/3euHyJqGh+mty4pFj5AdfAbsrgY26CVTUGqVf0S6Gnxu/E4izdEVnv26T6/WefqMW72ZWZ5qzVK9gIULjeiHavhcod8NBQ5f6gBdu0BZtMy0/iDIXPgVqshcTHZWB+XKb+stZaTvD0j7EJGZGP5RSlJ65qp/kgwXm+PI5maqhc3U53qEyWHAt498DMolnBxveQm9M0dkbJ4sP0mgVER6vvNAwIZtZMZTT/rTWmL7O5obBuwB2uOuIl9mwMeUcPEukLfKQCbPY6uWvDL0=
x-ms-exchange-antispam-messagedata: 7VB3mwrmVntqo2A+CFVkBWgTyv0zNfMaFu9vOl8XqfGh2MD3DvvRXYzvyeg7gd47F1ioVjBV6FWntuX/wnyT/tLtra5/i/YoH7tEY5evX/KOBsXUXNqPMLUc/MDjBAiRwMKzPleVxdhxhj1a49B7MMt4S5Q3dkliHN6SN798O9Qyzx+GzP+C28f869PQa5/jv7N1CQbP1f9Kf/vKmAeXIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bcb11c-9244-4872-9ecf-08d7d203ff68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 04:04:50.6986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CN0X35iP82xyYoXmVPfYHNQwJVQlIjVQZ2UsRWrnU7SZEQq5+B+0Oj0HhfVO1clt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3629
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, March 27, 2020 11:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/9] drm/amd/powerplay: avoid calling CI specific SMU message implemention

[CAUTION: External Email]

Prepare for coming lock protection for SMU message issuing.

Change-Id: If5f7615483d9967f9512fba49cc8454a1300ba6c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 868e2d5f6e62..66289884c8df 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2881,7 +2881,7 @@ static int ci_update_uvd_smc_table(struct pp_hwmgr *hwmgr)
                if (hwmgr->dpm_level & profile_mode_mask || !PP_CAP(PHM_PlatformCaps_UVDDPM))
                        break;
        }
-       ci_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_UVDDPM_SetEnabledMask,
+       smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_UVDDPM_SetEnabledMask,
                                data->dpm_level_enable_mask.uvd_dpm_enable_mask);

        return 0;
@@ -2912,7 +2912,7 @@ static int ci_update_vce_smc_table(struct pp_hwmgr *hwmgr)
                if (hwmgr->dpm_level & profile_mode_mask || !PP_CAP(PHM_PlatformCaps_VCEDPM))
                        break;
        }
-       ci_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_VCEDPM_SetEnabledMask,
+       smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_VCEDPM_SetEnabledMask,
                                data->dpm_level_enable_mask.vce_dpm_enable_mask);

        return 0;
--
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CKenneth.Feng%40amd.com%7Cd0c794f6d62847584bd808d7d200d19b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637208773277606490&amp;sdata=j%2FOi%2Fb7OjR4csoQAhlmTIbwz6mgrp%2FS9XExNWgFSRmc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

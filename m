Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D35C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D4B2100A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 04:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IsYqdGY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D4B2100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53206EA19;
	Thu, 18 Jun 2020 04:22:31 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4926EA19
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 04:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFskK+ZA8l6dTJv5WtIu5sswv+4BuoKDD9zNZpyMr2GRFKyg3oCuKZlx7PX2oUZh1Wttea4C+TUVhrxBUIksiGFYwiaZ/3YxmQO/cTYA34zFcVLEVVv5Ebhvtu+O93TYE3LGIN6x74UDwSRIMqkJNy/WWW+BNygawZVjaOhhcR4nXqvBQrgqf78G7DQX/Owl03yl1Ypf/rmKch6k2W3H9bXfgft+hMbtMit+9Ea08bVS2UCAjFxUg4qMUM490flWOGKsasgWAJ9EiGrlSTSNfUmhlFXVQVzeVlxtWa9ves6rkIBmrJADfAWxtKOSwe79b+mDNg2c4+RkZ1YvJ0WfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLtW0veuBZMg+iJHXF+0mnQCK0DJq2RbW58g2inyY0=;
 b=I2nJAN4eUasZisZePH/3OBsiS8aBY0OsmP0CHWgnoip1Al5PK2yPv/SxzCLDMzC4VjIcULsIw9E/gIvDMQzV2d5bvYmzt8riPfPdyRB8/mSEUJSBNmwaJhB8Y1gA/h5Dvc1inNhM9nU/afnxLzpgj+gjjmIP8eqjq4jpgilLBrBFhU2Fj0qqNF3se9HxurBErVenuMps37KAo7MEFAzQKSb9pgBf+Ne8axLj93UUd72DvZLi1kbK8L7suA1kvQ74M0aiJkdgx46Sd+B/9ika49Bljzq845+bNzIMFRXJO4NEXB5LF2/2UhWcr3S8wQyHIWpdCAPjHduL/vIG6+p6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLtW0veuBZMg+iJHXF+0mnQCK0DJq2RbW58g2inyY0=;
 b=IsYqdGY7r6A4hwYqyb7JkQ/Fc9eeraDkBHtr2pQzguvwXWiVA707EDNl4wckT6G95l7EaBd/HT7YtNhJLXKtAfpotv4FPnjdRpF8tVrumIdnVKkWcQFiuWDxjB4WLbW90s7XMpfJBEi0oosOhNV2TtSWMybfKyOINiyIufygnQw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Thu, 18 Jun 2020 04:22:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 04:22:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: properly guard the calls to swSMU
 functions
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: properly guard the calls to
 swSMU functions
Thread-Index: AQHWRRKlPmQ6TLD47Uq7L1htbokEuqjdxdyg
Date: Thu, 18 Jun 2020 04:22:27 +0000
Message-ID: <DM6PR12MB2619368786FE2A546E8660E3E49B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200618014835.3775523-1-alexander.deucher@amd.com>
 <20200618014835.3775523-2-alexander.deucher@amd.com>
In-Reply-To: <20200618014835.3775523-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7b71eb64-ca89-4424-a401-0000638ebd9e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T04:21:57Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a66d2fc9-c40c-4ece-15df-08d8133f35a8
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42208B9D330A260CDFEE00E9E49B0@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYAjMgzvv2LoglMKyOXpVi4DpFee6e9Vt2KvQYltSQ9WJNVnFK7uwRO9U5SRfUt9XpYjdwFiy2WBdHDqtXTjKH2kXz2bUkGvx0SeY8dYHrPw3PhKa6rYJXRzHq1qfzRtcIZ1LkEuIPdCH/dZQ1+O/Ovq37dJ1xRFD51QjzW9YWx7XqZAT5sbqK4po79tjWelKM6ALneXzpA5obNFrk8MrLRLOlAEP9P6CQf6CroucyHP0EsmxxopxIFRTbZJhJLXa0xqB5o7ZX8FPdBrHAwByqW2baGlL8v/LA/dHcizRn9ex0ePV80TI/6tkRm1Te/Uqy0ai6kx6EKmVT/yyx2Obez5W6WDepke80mQiyPPTj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(52536014)(26005)(71200400001)(66476007)(64756008)(66446008)(66556008)(76116006)(66946007)(5660300002)(186003)(86362001)(55016002)(9686003)(4326008)(316002)(966005)(8676002)(83380400001)(2906002)(33656002)(7696005)(53546011)(478600001)(6506007)(8936002)(110136005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +5AjWdJkRyvA9piIFcceqpfAnwGBQq7ieI6sD8oGoeJveUxqsp0L3F+O7Qvfw3CzGSqSmkdg5IDrMxIeRjhnQCIzfC8S54Ei0jPGWnxajAZ3gFftuQuSLhmP6sLbNWTugqZ5Z3ECCssuTM6B4jp5jlV1SEDjljpPgL/P7nUaW4xzu7GTGjn7FZfseU/ibaolidLFyAxN9NPFsczyps978UjlAvOtFuJktIrpLC9mHubkfASkaofc+S5g2PsO1zzbCUD339oS6fA+nxWf/ex5xFqCezpMmfcTVMO0WXvTuwGJG5r7XHH8yFGjQhRb6aoOf9zJ0NIec99tgIPmQS7xdFz8gDfgcqHEQSG7P4CQiwheLhaVwi/IKcoffb5VvrEDn2CxP/8yQOsCbEORVJDf4JlPt9Scs+18Nk7FmMDjBFU7H6YXf9TRpunp5slzdyQk9CyS1Z1TfMKhSRKY/BAyCUo+Ew3sYlSulXZ+YwCYw9EwUwb8bbC0/a2oTOnspvfp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66d2fc9-c40c-4ece-15df-08d8133f35a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 04:22:27.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BBJ1Z1nUh2IogRN49Pf72Z6Jy2FOWQaDRg5/fND67sasQNEFbcnYtDMezYjETVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, June 18, 2020 9:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: properly guard the calls to swSMU functions

It's only applicable on newer asics.  We could end up here when using DC on older asics like SI or KV.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1170&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ce9d2077216f345d417b008d81329c3e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280417436474816&amp;sdata=TAK3jTKVwYZqZ1hReOfy9WVkAyitnhDRyOjo61ak6rs%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 7cee8070cb11..5c6a6ae48d39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -106,7 +106,7 @@ bool dm_pp_apply_display_requirements(
 adev->powerplay.pp_funcs->display_configuration_change(
 adev->powerplay.pp_handle,
 &adev->pm.pm_display_cfg);
-else
+else if (adev->smu.ppt_funcs)
 smu_display_configuration_change(smu,
  &adev->pm.pm_display_cfg);

@@ -592,7 +592,7 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
 if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
 pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
    &wm_with_clock_ranges);
-else
+else if (adev->smu.ppt_funcs)
 smu_set_watermarks_for_clock_ranges(&adev->smu,
 &wm_with_clock_ranges);
 }
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ce9d2077216f345d417b008d81329c3e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280417436474816&amp;sdata=0ef8Irg9yht43Hmv4i1uTAGSJTTi5DPAoxte8S49fpk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

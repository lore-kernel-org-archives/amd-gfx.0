Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C4FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 14:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E487C64E83
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E487C64E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECA46E198;
	Thu, 25 Feb 2021 14:54:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD78D6E198
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 14:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAGVu/eF6eanKwu6ZhIhQlSUBkZciHbVwhh+cYari5ORtVdMXFvJYHbl+UuJ/iUrKdtNjedOsQS3RvPNyUrKhdiovQR0rY2ngM5BNmzLN6AXz055kq96UnXhhJin0V9+6I3R4Yxl7/e/t3hhaUd2MMeT+10dfkyyo8MkcRIFnK9/nkZa0Vg92HCsI0853z0vy0E+h2+n1/ras7xtOcn9Qc+Q8OkvwpUilLFFHFKsoS06C5ybEFEA+gK5nfOWQG7oIzzINuAFTZz4g3aGPQyeRPlgJ7Bz3SE7/O9TONLw5d5czzuyvVdpE/LBrdgzxivPF9KnEBiUdMVJumsIcp5ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47HcpvjJm05rf+JH2svRagsGlJglQYqB6ALvuomelVs=;
 b=lE11qn5TfGr3J2M933HR5BTqYynHoORE720AbbQ3kW7LEydvWsL3+uV2pECRK41AQE2BogshXUhkb7Ag5PYG+xpsrDbyXGgvIJ+KCa4qcnE2p8xWgaiG6W3FnRyUPfvXYavBgYF4GTCSrhZP4dRyNLM9HLI5hMvQnfVg18zf9Bt5ipWZ4eKwN5NWHUkaSway5wkaLdqklihrU4jP3FB6khJAi+cnGFsBRzFNacN2kDkAXGQ939uAT5y8w6AdNgB5OfB2jusMx+3NZIZXCVOOLd0jiDVecQVNHMLj2M7NhhxgXiyAWIhjbdMFdtZkREgv84TUYe2sorUcho4nzTQtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47HcpvjJm05rf+JH2svRagsGlJglQYqB6ALvuomelVs=;
 b=tHHSlNiPt7o/HBu91CgRCiGWvhRv2HJ2NygaO8LoiDCThyxXKkH9KTgagK7hoTPKfGLLqBB+b8cwYM+K3t7zWiaXpN5CwJENWHkzr3qmp3+lVm12uhviqSQxoc2xIvjzelRHMTc0OZJgMP91tWlDJbBOzm/Wnlc7yiPLuMXWkNc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 14:54:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 14:54:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf
Thread-Index: AQHXC25t1vysrLRfek+llodbWPS9NKpo9UmL
Date: Thu, 25 Feb 2021 14:54:24 +0000
Message-ID: <MN2PR12MB448808BFB9134E65A3609632F79E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210225120444.27948-1-horace.chen@amd.com>
In-Reply-To: <20210225120444.27948-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T14:54:23.945Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15737179-70f8-4686-08d4-08d8d99d3e0f
x-ms-traffictypediagnostic: BL0PR12MB2434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2434DB8240AA085B7BABB75EF79E9@BL0PR12MB2434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjR31j2HfrfyYkZcfyYiL3IcnkumSfboomlCwva5LhwKlnNJzBRRUMFy3ksYsW6qVCPEktzZvKWSo4EXaQBxvEuXpcQ9uw4MkOtSj5jRrslTvlt39vmvlye1ELpzDIThqt4h6jD7AJxECy6qWMe7/7E+WFxFpXGw09n05fRGIbOAB1cd9qLh9qE44j71gy0uhtl6YiqYSqvhIgTFGDgGrwSe7FtRhAI+x6z8aS4CxMn8DY/pB9JtCg6octU3TTO2Fj3/6oa5EthJSx0XN5rP2GpluMoCUqRbb4ZOh1Ifm1zdv8P4q3W0JiVZZBJlO2rwawadXtJHEwfo6ET67bVbYmdGSYdDodnRkIbo2zIH/MtxyWHiWdmAsTRdwjSt8Q0oiiJVKfgclOtXNJRdZWIt0VhId1oCzPfUWjWc6IqBMqBnmHzfVypJgqNA4ACHN7SA7r/fFjNbFjUHPygvZbbqnj+F55/2DokuTRK7vwv3OzzmFqfo4uy2IyKsvuh9XonVSLXyJYRgTqe+17VQ8Ai1Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(4326008)(186003)(53546011)(55016002)(7696005)(6506007)(9686003)(83380400001)(52536014)(5660300002)(2906002)(478600001)(66946007)(86362001)(76116006)(71200400001)(8936002)(54906003)(110136005)(8676002)(26005)(33656002)(66556008)(64756008)(66476007)(316002)(19627405001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2JxzAvCnFtQEzP4x6fBOtrWmkdHWiDBviAJU2rml4aLECaX4MThNK9GIVX9A?=
 =?us-ascii?Q?Mxx3OEPzM/ZXMaK4TwpHN/vl0Rc4FGLMbJSn+zlr60u9bJjWwfLLgdA0RbXr?=
 =?us-ascii?Q?dmM8ou5BZHP9RWi6+/WcMU7MmG/oZSSbGUmC2niwA1b76bbSPQTjOfm/scHv?=
 =?us-ascii?Q?pQiEVum6wZj0vXUdBCe/MGC5S6RALI059smK38UytZ7SXGyWKV4WQ34B+dLZ?=
 =?us-ascii?Q?UMOLl0vUmHb7lXTaKPXMBO0zw5DOgnRDETVBXhRr0kZ53yBS4CoReiQ2Qiqk?=
 =?us-ascii?Q?hYoIQxA4yza08/qJ4WM/NFUobBO8LUz3wNhUcWGgsH6ewiNYmNkEXGV72jGz?=
 =?us-ascii?Q?BimebJNig1M2Z8xs8AVSeb+YiK1FJoUGKWRjT+ZjwOP80HnaCti1KEnZrDIf?=
 =?us-ascii?Q?bhnhJ1dpX3b6n/YZzKkBRrcFmLM7XVVtwkhr7V7vGE+NcTkcu+yBWQ/C9nuP?=
 =?us-ascii?Q?9zm3KDLbtrICmSCj4XztjQOkKXcTiLvQG7UK2KHEoCmWVpMkutxHAqWizH9S?=
 =?us-ascii?Q?jbVA+HkQ4BYBR4uTA/BBIXAsqL1WUiKpDqQiNdH20yD+rn/WNj1YEuLW7FCA?=
 =?us-ascii?Q?RPWL27hGCYCS6EmAeNZPoVmg/xo/Sl6bZwJhk0ThLWsBcm3Ayos9INc6nxMW?=
 =?us-ascii?Q?M2JbuKr+E3mCOBzklWwlPo5XYQdfEz7m1UrjKzSYfV3xpGEY6dGg4z0DvCdR?=
 =?us-ascii?Q?i16UgU359Sk0zNjqVg/DUg6/DalHyrMvU4fUTDMhevgds0Rg6AKJYBzsMpeK?=
 =?us-ascii?Q?QSEzDcgJ6vhIqZt8SOaota/go5Ap92Z+pg1GPsDAnBc6cSQfOpqgcikDLX3d?=
 =?us-ascii?Q?5AUrdmwnCwIbeiw79F04yti9k9gmxSE//VVNhFSQgaV07L5+3b2koAluRkLg?=
 =?us-ascii?Q?K4aiiZ9JJ3nY+blIOSGWEEfWWPKgr+ZGV2yQwdFjxYEh8nX0fAsVX4ny2KZe?=
 =?us-ascii?Q?mpRBrTERINJcCFO9wpZYWcyn8F7FtsAUiThxxvgkqG57GwVpSInygijRcDpr?=
 =?us-ascii?Q?RCdzK5Z3kJOTcPupBVDsyy8Z+K9AyDV4BZypRSmuAUcfnNITQHj2Z0WwQbsq?=
 =?us-ascii?Q?/LtYxwqm+a+swghdKg7qI44zrR0ojqLeX4FYSX5FZsdGfurM/KjwDB+689/L?=
 =?us-ascii?Q?zrNicn0wrQgPMpw9UR1s33tmUtKEj5rTMM+LHIiaKGl/mHAzO85TJarktzpo?=
 =?us-ascii?Q?IcvEqoO1qMpK8dwHftnjpwKXJky5J3EArHlw8ocyYTgj/YuBr6+SXNmgBEtU?=
 =?us-ascii?Q?b2Drqs6U2tTTkLVtXpcxRslDynvJdBOFw2Puc4ciMKkPmUwNlz3tgIWYmrT2?=
 =?us-ascii?Q?KE7o/078Z8ewSbmaUoPoDvHH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15737179-70f8-4686-08d4-08d8d99d3e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 14:54:24.4930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXUo+OQPC+ncB2NDRDHYVIyf8FSaN+jZxW2hMlOqm3NqSnAyWPp3RFm9Rbyt/R89SyCG9E7J3fHvDTFRDMJyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0167827973=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0167827973==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448808BFB9134E65A3609632F79E9MN2PR12MB4488namp_"

--_000_MN2PR12MB448808BFB9134E65A3609632F79E9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Horace Chen <horace.chen@amd.com>
Sent: Thursday, February 25, 2021 7:04 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <A=
lexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu=
@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.y=
uan@amd.com>
Subject: [PATCH] drm/amdgpu: enable one vf mode on navi21 vf

navi21 vf needs one vf mode which allows vf to set and get
clock status from guest vm. So now expose the required interface
and allow some smu request on VF mode. Also since navi21 blocked
direct MMIO access, use KIQ to send SMU request under sriov vf.

OD use same command as getting pp table which is not allowed for
 navi21, so remove OD feature under sriov vf.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..dfbf2f2db0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)
         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D KFD_SCHED_POLICY_=
NO_HWS)
                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
+       if (amdgpu_sriov_vf(adev) && adev->asic_type =3D=3D CHIP_SIENNA_CIC=
HLID)
+               adev->pm.pp_feature &=3D ~PP_OVERDRIVE_MASK;

         for (i =3D 0; i < adev->num_ip_blocks; i++) {
                 if ((amdgpu_ip_block_mask & (1 << i)) =3D=3D 0) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index b770dd634ab6..1866cbaf70c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,

 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d143ef1b460b..7033d52eb4d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
                 return ret;
         }

-       ret =3D smu_set_default_od_settings(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to setup default OD settings!\n"=
);
-               return ret;
+       if (smu->od_enabled) {
+               ret =3D smu_set_default_od_settings(smu);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to setup default OD sett=
ings!\n");
+                       return ret;
+               }
         }

         ret =3D smu_populate_umd_state_clk(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index af73e1430af5..441effc23625 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]
         MSG_MAP(GetEnabledSmuFeaturesHigh,      PPSMC_MSG_GetRunningSmuFea=
turesHigh,   1),
         MSG_MAP(SetWorkloadMask,                PPSMC_MSG_SetWorkloadMask,=
             1),
         MSG_MAP(SetPptLimit,                    PPSMC_MSG_SetPptLimit,    =
             0),
-       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddr=
High,       0),
-       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddr=
Low,        0),
+       MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddr=
High,       1),
+       MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddr=
Low,        1),
         MSG_MAP(SetToolsDramAddrHigh,           PPSMC_MSG_SetToolsDramAddr=
High,        0),
         MSG_MAP(SetToolsDramAddrLow,            PPSMC_MSG_SetToolsDramAddr=
Low,         0),
-       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2=
Dram,       0),
+       MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2=
Dram,       1),
         MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDra=
m2Smu,       0),
         MSG_MAP(UseDefaultPPTable,              PPSMC_MSG_UseDefaultPPTabl=
e,           0),
         MSG_MAP(RunDcBtc,                       PPSMC_MSG_RunDcBtc,       =
             0),
         MSG_MAP(EnterBaco,                      PPSMC_MSG_EnterBaco,      =
             0),
-       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,=
            0),
-       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,=
            0),
+       MSG_MAP(SetSoftMinByFreq,               PPSMC_MSG_SetSoftMinByFreq,=
            1),
+       MSG_MAP(SetSoftMaxByFreq,               PPSMC_MSG_SetSoftMaxByFreq,=
            1),
         MSG_MAP(SetHardMinByFreq,               PPSMC_MSG_SetHardMinByFreq=
,            1),
         MSG_MAP(SetHardMaxByFreq,               PPSMC_MSG_SetHardMaxByFreq=
,            0),
         MSG_MAP(GetMinDpmFreq,                  PPSMC_MSG_GetMinDpmFreq,  =
             1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index bcedd4d92e35..d955dc4c6998 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 {
         struct amdgpu_device *adev =3D smu->adev;

-       *arg =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
+       *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }

 static int smu_cmn_wait_for_response(struct smu_context *smu)
@@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)
         uint32_t cur_value, i, timeout =3D adev->usec_timeout * 10;

         for (i =3D 0; i < timeout; i++) {
-               cur_value =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_=
90);
+               cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
                 if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) !=3D 0)
                         return cur_value;

@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)
         if (i =3D=3D timeout)
                 return -ETIME;

-       return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
@@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,
                 return ret;
         }

-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-       WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);

         return 0;
 }
--
2.17.1


--_000_MN2PR12MB448808BFB9134E65A3609632F79E9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Horace Chen &lt;horac=
e.chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 25, 2021 7:04 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; Tuiko=
v, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koen=
ig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd=
.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.=
com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Xiaojie Yuan &lt;xi=
aojie.yuan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable one vf mode on navi21 vf</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">navi21 vf needs one vf mode which allows vf to set=
 and get<br>
clock status from guest vm. So now expose the required interface<br>
and allow some smu request on VF mode. Also since navi21 blocked<br>
direct MMIO access, use KIQ to send SMU request under sriov vf.<br>
<br>
OD use same command as getting pp table which is not allowed for<br>
&nbsp;navi21, so remove OD feature under sriov vf.<br>
<br>
Signed-off-by: Horace Chen &lt;horace.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++++++----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp; | 10 +++++-=
----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 ++++++------<br>
&nbsp;5 files changed, 20 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index f0f7ed42ee7f..dfbf2f2db0de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature =3D=
 amdgpu_pp_feature_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
|| sched_policy =3D=3D KFD_SCHED_POLICY_NO_HWS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_OVERDRIVE_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_block_mask &amp; (1 &lt;&lt; i)) =3D=
=3D 0) {<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index b770dd634ab6..1866cbaf70c3 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *=
dev,<br>
&nbsp;<br>
&nbsp;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(powe=
r_dpm_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC|ATTR_FLAG_ONEVF),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_n=
um_states,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index d143ef1b460b..7033d52eb4d0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_default_od_settings(s=
mu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to setup default OD settings!=
\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_default_od_settings(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to setup default OD settings!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_populate_umd_s=
tate_clk(smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index af73e1430af5..441effc23625 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_messa=
ge_map[SMU_MSG_MAX_COUNT]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetEnabledSmuFeatu=
resHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetRunningSmuFeaturesHigh,=
&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetWorkloadMask,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PPSMC_MSG_SetWorkloadMask,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetPptLimit,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetPptLimit,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrHigh,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrLow,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDra=
mAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrHigh,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDramAddr=
High,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetDriverDramAddrLow,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetDriverDra=
mAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetToolsDramAddrHi=
gh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_S=
etToolsDramAddrHigh,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetToolsDramAddrLo=
w,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_=
MSG_SetToolsDramAddrLow,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0)=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableSmu2Dram,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TransferTableSmu2=
Dram,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableSmu2Dram,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TransferTableSmu2=
Dram,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TransferTableDram2=
Smu,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Transf=
erTableDram2Smu,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(UseDefaultPPTable,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PPSMC_MSG_UseDefaultPPTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunDcBtc,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_RunDcBtc,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(EnterBaco,&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_EnterBaco,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP=
SMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinByFreq,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMaxByFreq,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetMinDpmFreq,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetMinDpmFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index bcedd4d92e35..d955dc4c6998 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15_NO_KIQ(MP1, 0, =
mmMP1_SMN_C2PMSG_82);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1, 0, mmMP1_S=
MN_C2PMSG_82);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu_cmn_wait_for_response(struct smu_context *smu)<br>
@@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value, i, tim=
eout =3D adev-&gt;usec_timeout * 10;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; timeo=
ut; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur_value =3D RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) !=
=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n cur_value;<br>
&nbsp;<br>
@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D timeout)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ETIME;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15_NO_KIQ(MP1, 0, mm=
MP1_SMN_C2PMSG_90);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1_SMN=
_C2PMSG_90);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_cmn_send_msg_without_waiting(struct smu_context *smu,<br>
@@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_90, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_82, param);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN=
_C2PMSG_66, msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_90, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_82, param);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_66, msg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448808BFB9134E65A3609632F79E9MN2PR12MB4488namp_--

--===============0167827973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0167827973==--

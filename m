Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94403C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 13:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D2564F97
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 13:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D2564F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBAF6EC89;
	Thu, 11 Mar 2021 13:46:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1416E516
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 13:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7lmryYO6rog0KN97xNZcWgY3QdLi4cltg7Scr04ImSjahKCGAmxTNTZHskrTifP7eysMicinP8ZnVrHSPEATsEdTRfFVZCTG4m84787NgXty67iNxImnic2AWlAG8Gr075Q3hduAdXq+jQSz+XqQgAVBm6iIhe8G/gYM6h2WlQTQoTKv+CdCgHsyF7snRFh1uBNZ33aCA3O4/WeP6VJFLFF+YroraS7zzhlB7xKoL3bzKPGR2MS7LBHnEzSxGskn3w/qLlU9nGoMwqgosOl5xegYqiMzTbvOW9bYR1BTh2f94+xkDPXRDrMa96BaxiTgGLpp9O/5UZWHF2P7p9SNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0g4hIZoovg1cpwBmoFVgSMkucOpjarv1DyRbIDUP4=;
 b=WuvSQ5LT7FpUc7njS1cScY0pF6uI6AHA3sicUwc4x6YWdF37EJvA2GfidDjFPHxPo+rKCWfT/wZ30IRp4N/9P6Q9NzWzpUCbM28BVjH4VLwXP26DzznZNLzCynJmOxG5uK9I1uoYAwhmyfPzibgYVya1zf1V5R4qPhwghwmGv5C8TUvMKAIIK7vrJhTj9CFUpRBvSpvQ/Es1g5H/zdR1rO82aC6bsCN5FQ+3ZMou14X0QIqoxj57FwLOneyUyaK7E3YS8CFa5sZ6kLH4Z2ETwtzeWwdUXiXtD3cCVcmyD1Ky6h6bbfpa4Kr/gLGs00TSSS8djBzid3JJhR/mrgoE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0g4hIZoovg1cpwBmoFVgSMkucOpjarv1DyRbIDUP4=;
 b=nvawaaYk3Nr3fv+8hlUWaBydFHYJwHgBomF1NcdctIV1K0egwOgzj3LmrQpxsArVvIymwlK9HJkcVJOLAei5c6c9JYOAXRIEjnlrhGQ/q91gXaEuDKU0USlbSW7+ecOYvZC51XQC/c+cz2Bt9BGI0J9FmaQWcY42n7SzHJc4Oi0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4610.namprd12.prod.outlook.com (2603:10b6:208:84::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 13:46:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 13:46:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: workaround for audio noise issue
Thread-Topic: [PATCH v2] drm/amd/pm: workaround for audio noise issue
Thread-Index: AQHXFkPbBp+JKIPaAUa6JCvhstBBnqp+zSs9
Date: Thu, 11 Mar 2021 13:46:03 +0000
Message-ID: <MN2PR12MB4488B458916259320548F297F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210311065840.12080-1-kenneth.feng@amd.com>
In-Reply-To: <20210311065840.12080-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-11T13:46:02.991Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e79a3e73-d8f8-4f0e-c441-08d8e4940372
x-ms-traffictypediagnostic: BL0PR12MB4610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB46102A1F5D3773342C8E9477F7909@BL0PR12MB4610.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w408u+rVhLYR4I1oQYXIuzeQATp7xNMyDktC66+X9DS7qV9FjwjMbTOsv48exgh/9LKGtzV42iq1Ym2keyQpfKQ9dN7oFd/6uOHIcv8u5I1z2df1rTpqlLDXjyi0v+zHxynxUoxWFTxr5lGQc6jAegBEmSlX8g68tkFYMTD5tTBtWyLDkf7S0loKn6suA56BCfoAkGokA7OO6aU/zQwMcFMuYuN3LlUvI9wSZ/wLT3nEu2Ez/wCb5fIR2+qt7GyPCKmYe+kQavBA6YQJXHig82kRnbsNW0PhQjnHnP7iynoP8vb6F7qFM4UhH0WziAJzZh1t3RihqBzJXCZrO22VpQUvKtoU3YuFSmfCY5PzdgaCbt5/If7NhIBPn9B1LsqDXNwG/PxTc2X6/pCdPdN76VTvw272iHxMAMhlnXRE91wqwCpG8IppoT4NLbuS3W5LAwcFmccBkpX/VQaX4UTvrQXEny5DqUOnn5GEIqwZnuoTOkK1N0/4BU2aedscmlQiAo5L2QvlPf3DJVqSz/9WryixmNboinRmns/g83pjoneb0y/U16T2mXf676N88/x6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(55016002)(45080400002)(66446008)(19627405001)(9686003)(53546011)(5660300002)(64756008)(8936002)(8676002)(66556008)(66946007)(316002)(186003)(52536014)(33656002)(76116006)(2906002)(66476007)(7696005)(26005)(166002)(71200400001)(83380400001)(6506007)(966005)(30864003)(478600001)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3b8LbWlPzxM5+ru2zQXShEtUuTaqfxDm7UTQQ+rMVQ5bwStSmaCxzwsKdU4S?=
 =?us-ascii?Q?Pvo16Apd7Po9u5HAsU5HSSxTmSXVp4BIz70nemjqtWZmZo1bhjvW+UT6EdeO?=
 =?us-ascii?Q?giAn45sEQA9moR2GWldTbFB0tJc4K0hzU0ygnckzv0fAdd6vZrZoF/9PwSb9?=
 =?us-ascii?Q?4VzCuIhzAJwtqSVeBXDd8Usj4hlQZTmzB+BzmDq9x6YoWs0MG72n7l2y1zjN?=
 =?us-ascii?Q?2N7Q6yJlzzZPDC/5VPg/Nmxbh39aMPOENyF1NxaYgkcvBOza3L7GN6lPtSe7?=
 =?us-ascii?Q?wysLbdgkNgf96TBoT+fw7lIgC/Nuka+2GAgJiNlr9hMYvJlqw+AK8eaVJ6wX?=
 =?us-ascii?Q?+FMXs5NXrWMOXWT/dWOieVv1XUTNyFrgtH8k67PSHXOxdeHmi6YB7wkucaPQ?=
 =?us-ascii?Q?HQouMf2lqQpHp9sud0qBZb0pButAtnnRjjk7qd8JowjVDEqbBZKXFhQVGo7/?=
 =?us-ascii?Q?N5qppT5dTBnRQ6Rxqurek6GT8z8d0UxMF6+KzYbThClcVjkPbRkzqankTo3k?=
 =?us-ascii?Q?VAGbHWVlUj2lm+L8vyRdYVgofecYztz6wGKoj940oYPzLGKmiDSvdCiBQhdm?=
 =?us-ascii?Q?mUhOhadKfRBZdnlE85FIsVnHo0lSYT6PpikKbmjx4oA/oVUs9U5Ql4gcxyTT?=
 =?us-ascii?Q?6clAGFVctcM90ihYF3QnyDU5sdJu+gtzV25y1TVaiNbWILTOEf1uIipFgBTe?=
 =?us-ascii?Q?u6/4HBSri6WgblHtoYU8xBB+8u0p+KM7mPjtoPj1pXrHZb4tD9e9XQyKI7nf?=
 =?us-ascii?Q?KcLDMI3ttDbpnx6uQ5M8pDsRKhHYjCv69lHOn2oLGTvs5fJfnCfg72JmB5r2?=
 =?us-ascii?Q?VYxYUkfG52ufRdD9BnpOS142c3khXLWVGId14VjiXL3FPjD9rKgnl6ZwpNif?=
 =?us-ascii?Q?Z9YrSTwrVE7pZS09LDhKdI68oO/6xEWy7PaCk8XVvh1aG1AEbXy7PlacXZw9?=
 =?us-ascii?Q?EA2Kh8Fc6uj5P9E93TY81N/N9RudSTA/+QgXgeNvG3dobzsiherruhzPzVz2?=
 =?us-ascii?Q?SnrF7/fbNkaJfYhhckhFC7zH1bbaGpsGzFWVK+1j8mBgs2wAl1tGvpjyFciT?=
 =?us-ascii?Q?NRPa5rexs6+KRx+w53XGMMC+GHO2toVEIIr0IhWX8mGSJXJxWJMtlTKoume9?=
 =?us-ascii?Q?yRjxtMYGvr5p0Hc+qe1Fk/KIfqQJeOoI7dmayHl7F0D2VkM/Q1dmGAGrn0V9?=
 =?us-ascii?Q?BeReg+bhiVhPdzbjP7dzl6nUHC7J5cnvhLlBVe2uC7niDppoOUSwswJWf4qs?=
 =?us-ascii?Q?MF7RJm2hj8j1LQQZe4gWQXmGWHE9J08yUnT7kvcewYOxv+uuxk3DJF/nM/na?=
 =?us-ascii?Q?dRnz+U2Cf+fQ48jL7mDrCJU8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79a3e73-d8f8-4f0e-c441-08d8e4940372
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 13:46:03.5916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65YPEH+p7WZtwf3YNPVzHD/4KvlEXfA4pbBNf4+xm0QL0EGC5VKMIjYcPIJIqNlSa811k451ypExsssWSsy7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4610
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
Content-Type: multipart/mixed; boundary="===============0023401720=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0023401720==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B458916259320548F297F7909MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B458916259320548F297F7909MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Thursday, March 11, 2021 1:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: workaround for audio noise issue

On some Intel platforms, audio noise can be detected due to
high pcie speed switch latency.
This patch leaverages ppfeaturemask to fix to the highest pcie
speed then disable pcie switching.

v2:
coding style fix

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 54 ++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 74 ++++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 24 ++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 25 +++++++
 4 files changed, 166 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a58f92249c53..54bbee310e57 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -587,6 +587,48 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr =
*hwmgr)
                         tmp, MC_CG_ARB_FREQ_F0);
 }

+static uint16_t smu7_override_pcie_speed(struct pp_hwmgr *hwmgr)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->adev=
);
+       uint16_t pcie_gen =3D 0;
+
+       if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4 &&
+           adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4=
)
+               pcie_gen =3D 3;
+       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3=
 &&
+               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_=
GEN3)
+               pcie_gen =3D 2;
+       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2=
 &&
+               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_=
GEN2)
+               pcie_gen =3D 1;
+       else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1=
 &&
+               adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_=
GEN1)
+               pcie_gen =3D 0;
+
+       return pcie_gen;
+}
+
+static uint16_t smu7_override_pcie_width(struct pp_hwmgr *hwmgr)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)(hwmgr->adev=
);
+       uint16_t pcie_width =3D 0;
+
+       if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+               pcie_width =3D 16;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+               pcie_width =3D 12;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+               pcie_width =3D 8;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+               pcie_width =3D 4;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+               pcie_width =3D 2;
+       else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+               pcie_width =3D 1;
+
+       return pcie_width;
+}
+
 static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
@@ -683,6 +725,11 @@ static int smu7_setup_default_pcie_table(struct pp_hwm=
gr *hwmgr)
                                         PP_Min_PCIEGen),
                         get_pcie_lane_support(data->pcie_lane_cap,
                                         PP_Max_PCIELane));
+
+               if (data->pcie_dpm_key_disabled)
+                       phm_setup_pcie_table_entry(&data->dpm_table.pcie_sp=
eed_table,
+                               data->dpm_table.pcie_speed_table.count,
+                               smu7_override_pcie_speed(hwmgr), smu7_overr=
ide_pcie_width(hwmgr));
         }
         return 0;
 }
@@ -1248,6 +1295,13 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
                                                 NULL)),
                                 "Failed to enable pcie DPM during DPM Star=
t Function!",
                                 return -EINVAL);
+       } else {
+               PP_ASSERT_WITH_CODE(
+                               (0 =3D=3D smum_send_msg_to_smc(hwmgr,
+                                               PPSMC_MSG_PCIeDPM_Disable,
+                                               NULL)),
+                               "Failed to disble pcie DPM during DPM Start=
 Function!",
+                               return -EINVAL);
         }

         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 408b35866704..f5a32654cde7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -54,6 +54,9 @@
 #include "smuio/smuio_9_0_offset.h"
 #include "smuio/smuio_9_0_sh_mask.h"

+#define smnPCIE_LC_SPEED_CNTL                  0x11140290
+#define smnPCIE_LC_LINK_WIDTH_CNTL             0x11140288
+
 #define HBM_MEMORY_CHANNEL_WIDTH    128

 static const uint32_t channel_number[] =3D {1, 2, 0, 4, 0, 8, 0, 16, 2};
@@ -443,8 +446,7 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *h=
wmgr)
         if (PP_CAP(PHM_PlatformCaps_VCEDPM))
                 data->smu_features[GNLD_DPM_VCE].supported =3D true;

-       if (!data->registry_data.pcie_dpm_key_disabled)
-               data->smu_features[GNLD_DPM_LINK].supported =3D true;
+       data->smu_features[GNLD_DPM_LINK].supported =3D true;

         if (!data->registry_data.dcefclk_dpm_key_disabled)
                 data->smu_features[GNLD_DPM_DCEFCLK].supported =3D true;
@@ -1544,6 +1546,13 @@ static int vega10_override_pcie_parameters(struct pp=
_hwmgr *hwmgr)
                         pp_table->PcieLaneCount[i] =3D pcie_width;
         }

+       if (data->registry_data.pcie_dpm_key_disabled) {
+               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
+                       pp_table->PcieGenSpeed[i] =3D pcie_gen;
+                       pp_table->PcieLaneCount[i] =3D pcie_width;
+               }
+       }
+
         return 0;
 }

@@ -2966,6 +2975,14 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, =
uint32_t bitmap)
                 }
         }

+       if (data->registry_data.pcie_dpm_key_disabled) {
+               PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+                               false, data->smu_features[GNLD_DPM_LINK].sm=
u_feature_bitmap),
+               "Attempt to Disable Link DPM feature Failed!", return -EINV=
AL);
+               data->smu_features[GNLD_DPM_LINK].enabled =3D false;
+               data->smu_features[GNLD_DPM_LINK].supported =3D false;
+       }
+
         return 0;
 }

@@ -4584,6 +4601,24 @@ static int vega10_set_ppfeature_status(struct pp_hwm=
gr *hwmgr, uint64_t new_ppfe
         return 0;
 }

+static int vega10_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr=
)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+               PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+               >> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr=
)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+               PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+               >> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
 static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
                 enum pp_clock_type type, char *buf)
 {
@@ -4592,8 +4627,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr =
*hwmgr,
         struct vega10_single_dpm_table *mclk_table =3D &(data->dpm_table.m=
em_table);
         struct vega10_single_dpm_table *soc_table =3D &(data->dpm_table.so=
c_table);
         struct vega10_single_dpm_table *dcef_table =3D &(data->dpm_table.d=
cef_table);
-       struct vega10_pcie_table *pcie_table =3D &(data->dpm_table.pcie_tab=
le);
         struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep =3D=
 NULL;
+       uint32_t gen_speed, lane_width, current_gen_speed, current_lane_wid=
th;
+       PPTable_t *pptable =3D &(data->smc_state_table.pp_table);

         int i, now, size =3D 0, count =3D 0;

@@ -4650,15 +4686,31 @@ static int vega10_print_clock_levels(struct pp_hwmg=
r *hwmgr,
                                         "*" : "");
                 break;
         case PP_PCIE:
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentLinkIndex, =
&now);
-
-               for (i =3D 0; i < pcie_table->count; i++)
-                       size +=3D sprintf(buf + size, "%d: %s %s\n", i,
-                                       (pcie_table->pcie_gen[i] =3D=3D 0) =
? "2.5GT/s, x1" :
-                                       (pcie_table->pcie_gen[i] =3D=3D 1) =
? "5.0GT/s, x16" :
-                                       (pcie_table->pcie_gen[i] =3D=3D 2) =
? "8.0GT/s, x16" : "",
-                                       (i =3D=3D now) ? "*" : "");
+               current_gen_speed =3D
+                       vega10_get_current_pcie_link_speed_level(hwmgr);
+               current_lane_width =3D
+                       vega10_get_current_pcie_link_width_level(hwmgr);
+               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
+                       gen_speed =3D pptable->PcieGenSpeed[i];
+                       lane_width =3D pptable->PcieLaneCount[i];
+
+                       size +=3D sprintf(buf + size, "%d: %s %s %s\n", i,
+                                       (gen_speed =3D=3D 0) ? "2.5GT/s," :
+                                       (gen_speed =3D=3D 1) ? "5.0GT/s," :
+                                       (gen_speed =3D=3D 2) ? "8.0GT/s," :
+                                       (gen_speed =3D=3D 3) ? "16.0GT/s," =
: "",
+                                       (lane_width =3D=3D 1) ? "x1" :
+                                       (lane_width =3D=3D 2) ? "x2" :
+                                       (lane_width =3D=3D 3) ? "x4" :
+                                       (lane_width =3D=3D 4) ? "x8" :
+                                       (lane_width =3D=3D 5) ? "x12" :
+                                       (lane_width =3D=3D 6) ? "x16" : "",
+                                       (current_gen_speed =3D=3D gen_speed=
) &&
+                                       (current_lane_width =3D=3D lane_wid=
th) ?
+                                       "*" : "");
+               }
                 break;
+
         case OD_SCLK:
                 if (hwmgr->od_enabled) {
                         size =3D sprintf(buf, "%s:\n", "OD_SCLK");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 196ac2a4d145..b6d7b7b224a9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -133,6 +133,7 @@ static void vega12_set_default_registry_data(struct pp_=
hwmgr *hwmgr)
         data->registry_data.auto_wattman_debug =3D 0;
         data->registry_data.auto_wattman_sample_period =3D 100;
         data->registry_data.auto_wattman_threshold =3D 50;
+       data->registry_data.pcie_dpm_key_disabled =3D !(hwmgr->feature_mask=
 & PP_PCIE_DPM_MASK);
 }

 static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -539,6 +540,29 @@ static int vega12_override_pcie_parameters(struct pp_h=
wmgr *hwmgr)
                 pp_table->PcieLaneCount[i] =3D pcie_width_arg;
         }

+       /* override to the highest if it's disabled from ppfeaturmask */
+       if (data->registry_data.pcie_dpm_key_disabled) {
+               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
+                       smu_pcie_arg =3D (i << 16) | (pcie_gen << 8) | pcie=
_width;
+                       ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
+                               PPSMC_MSG_OverridePcieParameters, smu_pcie_=
arg,
+                               NULL);
+                       PP_ASSERT_WITH_CODE(!ret,
+                               "[OverridePcieParameters] Attempt to overri=
de pcie params failed!",
+                               return ret);
+
+                       pp_table->PcieGenSpeed[i] =3D pcie_gen;
+                       pp_table->PcieLaneCount[i] =3D pcie_width;
+               }
+               ret =3D vega12_enable_smc_features(hwmgr,
+                               false,
+                               data->smu_features[GNLD_DPM_LINK].smu_featu=
re_bitmap);
+               PP_ASSERT_WITH_CODE(!ret,
+                               "Attempt to Disable DPM LINK Failed!",
+                               return ret);
+               data->smu_features[GNLD_DPM_LINK].enabled =3D false;
+               data->smu_features[GNLD_DPM_LINK].supported =3D false;
+       }
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 78bbd4d666f2..213c9c6b4462 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -171,6 +171,7 @@ static void vega20_set_default_registry_data(struct pp_=
hwmgr *hwmgr)
         data->registry_data.gfxoff_controlled_by_driver =3D 1;
         data->gfxoff_allowed =3D false;
         data->counter_gfxoff =3D 0;
+       data->registry_data.pcie_dpm_key_disabled =3D !(hwmgr->feature_mask=
 & PP_PCIE_DPM_MASK);
 }

 static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -884,6 +885,30 @@ static int vega20_override_pcie_parameters(struct pp_h=
wmgr *hwmgr)
                 pp_table->PcieLaneCount[i] =3D pcie_width_arg;
         }

+       /* override to the highest if it's disabled from ppfeaturmask */
+       if (data->registry_data.pcie_dpm_key_disabled) {
+               for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
+                       smu_pcie_arg =3D (i << 16) | (pcie_gen << 8) | pcie=
_width;
+                       ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
+                               PPSMC_MSG_OverridePcieParameters, smu_pcie_=
arg,
+                               NULL);
+                       PP_ASSERT_WITH_CODE(!ret,
+                               "[OverridePcieParameters] Attempt to overri=
de pcie params failed!",
+                               return ret);
+
+                       pp_table->PcieGenSpeed[i] =3D pcie_gen;
+                       pp_table->PcieLaneCount[i] =3D pcie_width;
+               }
+               ret =3D vega20_enable_smc_features(hwmgr,
+                               false,
+                               data->smu_features[GNLD_DPM_LINK].smu_featu=
re_bitmap);
+               PP_ASSERT_WITH_CODE(!ret,
+                               "Attempt to Disable DPM LINK Failed!",
+                               return ret);
+               data->smu_features[GNLD_DPM_LINK].enabled =3D false;
+               data->smu_features[GNLD_DPM_LINK].supported =3D false;
+       }
+
         return 0;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ca13ada82b3b9489dfb0c08d8e45afc21%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637510426727844170%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DMa6p9%2FwtNwOFK%2B8Tzt6q6N1jzLRy5ldBsw3YPU917G4%3D&amp;reserved=3D0

--_000_MN2PR12MB4488B458916259320548F297F7909MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 11, 2021 1:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/pm: workaround for audio noise issue</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On some Intel platforms, audio noise can be detect=
ed due to<br>
high pcie speed switch latency.<br>
This patch leaverages ppfeaturemask to fix to the highest pcie<br>
speed then disable pcie switching.<br>
<br>
v2:<br>
coding style fix<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 54 ++++++++=
++++++<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 74 ++++++++++++++++--=
-<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 24 ++++++<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 25 +++++++<br>
&nbsp;4 files changed, 166 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index a58f92249c53..54bbee310e57 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -587,6 +587,48 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp, =
MC_CG_ARB_FREQ_F0);<br>
&nbsp;}<br>
&nbsp;<br>
+static uint16_t smu7_override_pcie_speed(struct pp_hwmgr *hwmgr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)(hwmgr-&gt;adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pcie_gen =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_gen_mask &amp; C=
AIL_PCIE_LINK_SPEED_SUPPORT_GEN4 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.p=
cie_gen_mask &amp; CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_gen =3D 3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_mask &a=
mp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pcie_gen_mask &amp; CAIL_ASIC_PCIE_LINK_SPEED_SUPPOR=
T_GEN3)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_gen =3D 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_mask &a=
mp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pcie_gen_mask &amp; CAIL_ASIC_PCIE_LINK_SPEED_SUPPOR=
T_GEN2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_gen =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_gen_mask &a=
mp; CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.pcie_gen_mask &amp; CAIL_ASIC_PCIE_LINK_SPEED_SUPPOR=
T_GEN1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_gen =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pcie_gen;<br>
+}<br>
+<br>
+static uint16_t smu7_override_pcie_width(struct pp_hwmgr *hwmgr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)(hwmgr-&gt;adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pcie_width =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pcie_mlw_mask &amp; C=
AIL_PCIE_LINK_WIDTH_SUPPORT_X16)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 12;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;pm.pcie_mlw_mask &a=
mp; CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pcie_width =3D 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pcie_width;<br>
+}<br>
+<br>
&nbsp;static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -683,6 +725,11 @@ static int smu7_setup_default_pcie_table(struct pp_hwm=
gr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PP_Min_PCIEGen),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_p=
cie_lane_support(data-&gt;pcie_lane_cap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PP_Max_PCIELane));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (data-&gt;pcie_dpm_key_disabled)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_setup_pcie_t=
able_entry(&amp;data-&gt;dpm_table.pcie_speed_table,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.pcie_speed_table.count,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_override_pcie_speed(hwmgr), smu7_overr=
ide_pcie_width(hwmgr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1248,6 +1295,13 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to enable pcie DPM =
during DPM Start Function!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0 =3D=3D smum_send_msg_to_smc(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PCIeDPM_Disa=
ble,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to disble pcie DPM during DPM =
Start Function!&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-=
&gt;platform_descriptor.platformCaps,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
index 408b35866704..f5a32654cde7 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -54,6 +54,9 @@<br>
&nbsp;#include &quot;smuio/smuio_9_0_offset.h&quot;<br>
&nbsp;#include &quot;smuio/smuio_9_0_sh_mask.h&quot;<br>
&nbsp;<br>
+#define smnPCIE_LC_SPEED_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11140290<br>
+#define smnPCIE_LC_LINK_WIDTH_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11140288<br>
+<br>
&nbsp;#define HBM_MEMORY_CHANNEL_WIDTH&nbsp;&nbsp;&nbsp; 128<br>
&nbsp;<br>
&nbsp;static const uint32_t channel_number[] =3D {1, 2, 0, 4, 0, 8, 0, 16, =
2};<br>
@@ -443,8 +446,7 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCap=
s_VCEDPM))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DPM_VCE].supported =3D tru=
e;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;registry_data.pcie_dpm_=
key_disabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].supported =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].=
supported =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;registry_dat=
a.dcefclk_dpm_key_disabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DPM_DCEFCLK].supported =3D=
 true;<br>
@@ -1544,6 +1546,13 @@ static int vega10_override_pcie_parameters(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_ta=
ble-&gt;PcieLaneCount[i] =3D pcie_width;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.pcie_dpm_k=
ey_disabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NUM_LINK_LEVELS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eGenSpeed[i] =3D pcie_gen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eLaneCount[i] =3D pcie_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2966,6 +2975,14 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, =
uint32_t bitmap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.pcie_dpm_k=
ey_disabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, data-&gt;smu_features[GNLD_DPM_LINK]=
.smu_feature_bitmap),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;Attempt to Disable Link DPM feature Failed!&quot;, return =
-EINVAL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].enabled =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].supported =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -4584,6 +4601,24 @@ static int vega10_set_ppfeature_status(struct pp_hwm=
gr *hwmgr, uint64_t new_ppfe<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int vega10_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hwmgr-=
&gt;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (RREG32_PCIE(smnPCIE_LC_LINK_W=
IDTH_CNTL) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &gt;&gt; PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;<br>
+}<br>
+<br>
+static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr=
)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hwmgr-=
&gt;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (RREG32_PCIE(smnPCIE_LC_SPEED_=
CNTL) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &gt;&gt; PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT=
;<br>
+}<br>
+<br>
&nbsp;static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, char *buf)<br>
&nbsp;{<br>
@@ -4592,8 +4627,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr =
*hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_single_dpm_t=
able *mclk_table =3D &amp;(data-&gt;dpm_table.mem_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_single_dpm_t=
able *soc_table =3D &amp;(data-&gt;dpm_table.soc_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_single_dpm_t=
able *dcef_table =3D &amp;(data-&gt;dpm_table.dcef_table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_pcie_table *pcie_table =
=3D &amp;(data-&gt;dpm_table.pcie_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_odn_clock_vo=
ltage_dependency_table *podn_vdd_dep =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gen_speed, lane_width, curre=
nt_gen_speed, current_lane_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D &amp;(data-&gt=
;smc_state_table.pp_table);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, now, size =3D 0, co=
unt =3D 0;<br>
&nbsp;<br>
@@ -4650,15 +4686,31 @@ static int vega10_print_clock_levels(struct pp_hwmg=
r *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;*&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentLinkIndex, &amp;=
now);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; pcie_table-&gt;count; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprint=
f(buf + size, &quot;%d: %s %s\n&quot;, i,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (pcie_table-&gt;pcie_gen[i] =3D=3D 0) ? &quot;2.5GT/s, x1&quot; :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (pcie_table-&gt;pcie_gen[i] =3D=3D 1) ? &quot;5.0GT/s, x16&quot; :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (pcie_table-&gt;pcie_gen[i] =3D=3D 2) ? &quot;8.0GT/s, x16&quot; : &qu=
ot;&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; current_gen_speed =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_get_curre=
nt_pcie_link_speed_level(hwmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; current_lane_width =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_get_curre=
nt_pcie_link_width_level(hwmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NUM_LINK_LEVELS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_speed =3D pp=
table-&gt;PcieGenSpeed[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lane_width =3D p=
ptable-&gt;PcieLaneCount[i];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprint=
f(buf + size, &quot;%d: %s %s %s\n&quot;, i,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (gen_speed =3D=3D 0) ? &quot;2.5GT/s,&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (gen_speed =3D=3D 1) ? &quot;5.0GT/s,&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (gen_speed =3D=3D 2) ? &quot;8.0GT/s,&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (gen_speed =3D=3D 3) ? &quot;16.0GT/s,&quot; : &quot;&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 1) ? &quot;x1&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 2) ? &quot;x2&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 3) ? &quot;x4&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 4) ? &quot;x8&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 5) ? &quot;x12&quot; :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D 6) ? &quot;x16&quot; : &quot;&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (current_gen_speed =3D=3D gen_speed) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (current_lane_width =3D=3D lane_width) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;*&quot; : &quot;&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_SCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;%s:\n&quot;, &quot;OD_SCLK&quot;);<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
index 196ac2a4d145..b6d7b7b224a9 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -133,6 +133,7 @@ static void vega12_set_default_registry_data(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.aut=
o_wattman_debug =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.aut=
o_wattman_sample_period =3D 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.aut=
o_wattman_threshold =3D 50;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.pcie_dpm_key_d=
isabled =3D !(hwmgr-&gt;feature_mask &amp; PP_PCIE_DPM_MASK);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)<=
br>
@@ -539,6 +540,29 @@ static int vega12_override_pcie_parameters(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_table-&gt;PcieLaneCount[i] =3D pcie_width_arg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* override to the highest if it's di=
sabled from ppfeaturmask */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.pcie_dpm_k=
ey_disabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NUM_LINK_LEVELS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_pcie_arg =3D=
 (i &lt;&lt; 16) | (pcie_gen &lt;&lt; 8) | pcie_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_sen=
d_msg_to_smc_with_parameter(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_OverridePcieParameters, smu_pcie_=
arg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_C=
ODE(!ret,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[OverridePcieParameters] Attempt to o=
verride pcie params failed!&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eGenSpeed[i] =3D pcie_gen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eLaneCount[i] =3D pcie_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega12_enable_smc_features(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].smu_fe=
ature_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to Disable DPM LINK Failed!&q=
uot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].enabled =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].supported =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
index 78bbd4d666f2..213c9c6b4462 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -171,6 +171,7 @@ static void vega20_set_default_registry_data(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.gfx=
off_controlled_by_driver =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;gfxoff_allowed =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;counter_gfxoff =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registry_data.pcie_dpm_key_d=
isabled =3D !(hwmgr-&gt;feature_mask &amp; PP_PCIE_DPM_MASK);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)<=
br>
@@ -884,6 +885,30 @@ static int vega20_override_pcie_parameters(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_table-&gt;PcieLaneCount[i] =3D pcie_width_arg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* override to the highest if it's di=
sabled from ppfeaturmask */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.pcie_dpm_k=
ey_disabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NUM_LINK_LEVELS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_pcie_arg =3D=
 (i &lt;&lt; 16) | (pcie_gen &lt;&lt; 8) | pcie_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_sen=
d_msg_to_smc_with_parameter(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_OverridePcieParameters, smu_pcie_=
arg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_C=
ODE(!ret,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[OverridePcieParameters] Attempt to o=
verride pcie params failed!&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eGenSpeed[i] =3D pcie_gen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_table-&gt;Pci=
eLaneCount[i] =3D pcie_width;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_enable_smc_features(hwmgr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].smu_fe=
ature_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to Disable DPM LINK Failed!&q=
uot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].enabled =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;smu_features[GNLD_DPM_LINK].supported =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ca13ada82b3b9489dfb0c08d8e45afc21%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510426727844170%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DMa6p9%2FwtNwOFK%2B8Tzt6q6N1jzLRy5ldBsw3YPU917G4%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7Ca13ada82b3b9489dfb0c08d8e45a=
fc21%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510426727844170%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DMa6p9%2FwtNwOFK%2B8Tzt6q6N1jzLRy5ldBsw3YPU=
917G4%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B458916259320548F297F7909MN2PR12MB4488namp_--

--===============0023401720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0023401720==--

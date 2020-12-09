Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7DC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 06:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E54233A1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 06:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E54233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF3A6E10C;
	Wed,  9 Dec 2020 06:36:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680069.outbound.protection.outlook.com [40.107.68.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703B76E10C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 06:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obiLFPXkIxQbQlG86RG6xxd4yb1i15I3WlGHHPkOw3FDuvIcpn2eYifC9eHs4coRhcbPqy/D1E+jDmoPB6ct4O+5ovrHjzMkTSdS2M4ItPoISl+7gB3IveU7Sv022bhkvmZhPb/KnBKyRBsWVpyG+k+LWf9/Ck3nTHnrf3Yy2F5m8hB7sDTX/93mJiqK9+/+lhVQsz0VbcdrOACjo/aJm/eSoRsns/+J2zdORyyHOtJXRZhiMXFyl98UfZ3aNPIDSL2sVea5pCBvQYx25lzopCK74D8MFoVbDI8I0QYH88/QNge587vgD46B/B7ljB06sIXGnDhjRRFGpROiS8+tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oks18VF5GU0cIEhTFMa/7ClXC+TKPwIEUBN6+xh+daI=;
 b=lkfSlBvUaPAP5TCRhMUIv2JjyNisBDk0/gnYfe4FJY13rtQdVgO8GtX3Oc+j9CeEv8IjZsX1PTjb9xWLSfXoYbXeo9kO+atulmk5ZjBqJvYBgxUe4c6bSYhAFr+CmZbTk5kt9sf/NNvWFq35oqmh/YkyRWtMAxfJoMmBxdvlOj8ZQiFcQoU4ek/1Ywl9Bt6/R9bdMowc2TRAzeGX/MqLd09BVP5EWVgEQD05KfezGCamfKuBgb7qwxQE9GJAh7D7q3IPnPCtuLq8V2T38WkDFx8Ixev/y5wfROG/dCClsI/MtykB/NFNaFeBvANnJlurJ0HsUhTJZp5iXQY3zMG9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oks18VF5GU0cIEhTFMa/7ClXC+TKPwIEUBN6+xh+daI=;
 b=g4am/CgVmJMdiePBCb0sNnC8k/uAsFA37tI6d0m1z4G61RcjV/1GUanUWMnx4p2Yu3rD6QntIq8v9DzAo1aux+JBYD6kIW595k6OAHrXaqVs8CKkDJYaj6NJedHvYaGGqyEX4TevrBkR/+vq/JsP8l1ZgBgfA9NnXK2GsHRMsFo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 9 Dec 2020 06:36:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 06:36:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: move link_bandwidth_kbps under
 CONFIG_DRM_AMD_DC_DCN
Thread-Topic: [PATCH] drm/amdgpu/display: move link_bandwidth_kbps under
 CONFIG_DRM_AMD_DC_DCN
Thread-Index: AQHWx3TJ+rbgDEBqu02f4izyvxcdJanuXC0Q
Date: Wed, 9 Dec 2020 06:36:16 +0000
Message-ID: <DM6PR12MB2619FF821AFA6AD70C53BBA9E4CC0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201130235852.457569-1-alexander.deucher@amd.com>
In-Reply-To: <20201130235852.457569-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=50d768f8-a957-43d3-8243-4f0900a9ba64;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-09T06:35:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e72c7945-3a77-4b8d-02cf-08d89c0cbaff
x-ms-traffictypediagnostic: DM5PR1201MB2472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2472987B24B76F31C0E037A9E4CC0@DM5PR1201MB2472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FgZeG0RRVe/d3WT3OMLLu3yEZOXELZR6wV8GA1sx0X6jOXeECMlFRI5/BlqaFsuAbdOquc954HuG+3aOVuX8xWpZie5ty1zuVloP8B/7mVfm/dIgiqHWlN/8iuKmTNSyHxR125+nTXl7byp6IogiV30uqcVBvtDXP1PKrTaHDrbg6TXnqUYT/sIqN0li2fIECL3I3qfZEghHQBvAyPluFpmDbrL+fPQqjCJgeJHEMmYuyrTIZTZTYB8RmAsN966SDwPvW0m2mAGEMqh7gv9g/sgr4V6uvzR4P555KNn1isb3E85SGRN7imhsXbQdQE5gTkJ4tKE1lbM5FPpNZPQMcvT+eHcx5dX2aUt+ZlN0DJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(508600001)(110136005)(6506007)(2906002)(66946007)(66556008)(76116006)(83380400001)(8676002)(86362001)(8936002)(52536014)(64756008)(66446008)(53546011)(4326008)(7696005)(9686003)(5660300002)(186003)(71200400001)(45080400002)(966005)(55016002)(66476007)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xEh3ghqA2gea2rkNsKvWU4oVKbZwA8MDgwmYUD3rfVOkUzWOj3HUkOcxIJ5E?=
 =?us-ascii?Q?83Xz+/RG/cON2EiDBNGaOOsYUxFbkdOAA41bTa5qaOwg1zeLQM9t6eAttXCl?=
 =?us-ascii?Q?YSRLBXb8Fgx8QQEN14yDKJBFINFnAgCC1H/roHvUIM+ICbcs+a48LZa4eDMA?=
 =?us-ascii?Q?uiJNIjBVWD/9RVLOM5I1iinX55v7ZrR77UvR4uMW/g7e0bO3+9X8laLA9YfL?=
 =?us-ascii?Q?vF+cvTEhqESo+Hc7BxWtS2H23z5id6xr7zrhKKHlSQOC8qzSHkuUuJASpds3?=
 =?us-ascii?Q?pbM64DKZol+quFXF8x2N4EcoXpeHN++npoz0115+UVxco6ev/GAkAkyVLc2R?=
 =?us-ascii?Q?2hSttwzNpiMPgKCHmXsI49gH7lKTTagtlpN86CjGYASshN4n4mONQgYixwgm?=
 =?us-ascii?Q?u6AWeKD++md5chcR1pyXYKDhY0diIcxrESGaxfJwy0hL/P3nHB+P0zEmSsge?=
 =?us-ascii?Q?EDQL6BTWQxVW03ZJ1cjvf+HjD81W0wXnk3DcHXi1spPapcGWVwwD7uNBRUXc?=
 =?us-ascii?Q?lX3csyg/Gq2kcE85aoRdEIIhiiKZ9hGw3ZXeTDxLkBpdYmBBJzjPPeS8AE1+?=
 =?us-ascii?Q?zn7rwBRb/zuRzZZBi3HxB6K1a462WaFZ1NIEG9RA7AEeM7QPshKfPwKcay6+?=
 =?us-ascii?Q?qJVR5skYOV/8hBadVkOP+Xg6hVFBJ+EMx06SM8Sx1hk8TojdJ0f8xMtZKyDM?=
 =?us-ascii?Q?RH/9CXm5kSSpU6xr3AItGuiBEJ+mP/bfe82p94sh3jiFRTPtJW+QNChtfIqG?=
 =?us-ascii?Q?o5ZSp8csriZPcNOlydE0MugV8g3OUuUZz4kEZ4pSfXtc16Egi0to0p5aw9Sq?=
 =?us-ascii?Q?f8Z/4vI8jVmOdXa2yfexFOvuOZQ6wir+UObkkOOKf0vH0ATjK/sXJIdZFfHx?=
 =?us-ascii?Q?fLPYlaQKKtIEKH1vOZd6vtF9WwPairB1PARA2A42PFme8CwcrLevhDbOyMj1?=
 =?us-ascii?Q?kc1DomNk5Y434B4CtC4bNd5hJ7c2HKwLgpijDR3I/stFHZMhzclkql6qrPhD?=
 =?us-ascii?Q?f/MU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72c7945-3a77-4b8d-02cf-08d89c0cbaff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 06:36:16.2820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KeEsefxZIU/Gm8ugOwsnTAoyis5Xv/uaNpy+Jdnh+rLepckbfJqkw9yae6BVPA0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, December 1, 2020 7:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: move link_bandwidth_kbps under CONFIG_DRM_AMD_DC_DCN

It's only used when CONFIG_DRM_AMD_DC_DCN is set.  Fixes and set but
not used warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08539f431586..c0e61c13b3fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5076,9 +5076,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 int preferred_refresh = 0;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 struct dsc_dec_dpcd_caps dsc_caps;
-#endif
 uint32_t link_bandwidth_kbps;
-
+#endif
 struct dc_sink *sink = NULL;
 if (aconnector == NULL) {
 DRM_ERROR("aconnector is NULL!\n");
@@ -5160,11 +5159,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
       aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
       aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
       &dsc_caps);
-#endif
 link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
      dc_link_get_link_cap(aconnector->dc_link));

-#if defined(CONFIG_DRM_AMD_DC_DCN)
 if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported) {
 /* Set DSC policy according to dsc_clock_en */
 dc_dsc_policy_set_enable_dsc_when_not_needed(
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C3850b95e81794f28290e08d8958beafa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637423775460610453%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3%2BsZsWzVcX9QT%2Fs%2B%2BEX4VmBQd5bpBkl58uqFawl%2B6f8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

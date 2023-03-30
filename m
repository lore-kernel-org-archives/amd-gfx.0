Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF467C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 12:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5887010EDF5;
	Thu, 30 Mar 2023 12:28:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E713D10EDF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 12:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef9grwMFRQGvXo4U5YgUBaTAZzOSsohXCPOM8Vpne8OfmiwcZ79rBC0YzOIYU9YWmC3uD5zDZA0p5cyEvE9+eZs9y9wk4OO/v9dIn9gBaaTINCXtknmYXjyTmFkUCpfeQVimygZD+cmQwJH5YVbMod9aET3I7nW16iRvfJe0pcMNArJS5OgyDokFGBW6Kl5XOY19+VpO7kGUPSyCzMD9nZBJVFQtAvCScSaA+tgWrHK02+4gzph8Jb+rfQUhXAMI0b2miFHhkWdTNex3TlIRkPR2Y0CriJmVOBEUaUcCPmFRFcXATOzJE+WbklxCJkOAh9G6Qzo1YktiAl7iRq/25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA+FZqshRl/G3EcQ7x5bw62qQ1ykUURjSmBOlJY2dnA=;
 b=UovK8NvO32dwQTNYBPI0voCOjc5XMnhTy82HZsUCdSU/YC5QkSNdi9WXepQ6+iBcV+nBtmE7S/9bPtM/Bx9SvOgLlQsyp+ZiIjZoVwRxO+w31GnsN+LsINJE3MCjaOGDlyGjUvmkL+AF7PurvvfmXDhWINrWaNOSbWj9+qA35aL1nrpv0K3Hr/4J+9B+hM5xnalxnMS11ycNJJZrG7vl9melHGGmQ3oZ6C1vROE7dY3J+BM0jZDfFXBlDL9JF/6lqUFdVUuBOOFbImrDDEHkioC91Shkk5tfZaINKc/5DBC+RQrYAz/4uKVXZDcx8VXlG+NZm0V9zsl7lorBYaJd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA+FZqshRl/G3EcQ7x5bw62qQ1ykUURjSmBOlJY2dnA=;
 b=KdKcMks6V9daCocdfzksbOza5BU+ecmv8jIL1gugR81TqoBsKk6ixMzfuzxBZq3x6GI8J3yiYQMrmtJkQtruTaf5oKHDWqttoGzOOKbnzm9/XboY/GFgihC58IFmIwbj0jt/u/xiK/z5oFtQuEydr77YFTQirCx3etNp+k7h1Eo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 12:28:40 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1cef:d713:9487:e4c6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1cef:d713:9487:e4c6%3]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 12:28:40 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Topic: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Index: AQHZYrANFkvx0THmPkO01zRsjnZby68S0Wtg
Date: Thu, 30 Mar 2023 12:28:40 +0000
Message-ID: <CY5PR12MB6369DDBCCB94A420070C420FC18E9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230330023302.2466048-1-tim.huang@amd.com>
In-Reply-To: <20230330023302.2466048-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T12:28:37Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a3fc095-13f7-41bb-81e2-5233fca07594;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-30T12:28:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: be0fb595-cfb3-4db0-8f63-77abd8f43e72
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CY8PR12MB7435:EE_
x-ms-office365-filtering-correlation-id: 95b35ffc-4297-405d-b692-08db311a4b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRm3gNvPvV5ecbO8sj7ENOwyuHjeSAddFpDp/Fe56UOtipmJNFuUfNP2yr/GVri+E/xhRhSs1OGaJS91aPB1nU1Hb2QxSHvv1yY2mPgrFYF7n7zJ/snkYyplgFRsBihHFVe9pGSLe2Sm876LBZz61K2FxpTZyCiCDOlWvcB3Y1Q0TpHtg1imcNZx7R1NoGtk56sWTrx3dUPONdPlxBaBQmUop6Z5PfM0zhpYFuQ1K8xKGMMK/em5xlIBRpbdIwTOl9aQKGwFIYL4OEfqbLImUJn+j8dj4klN4pgx16x9guqeJsk/m/1kqN9S+rjMfyUQrt3O67UMtyHqaoaaWBB8xhIytGO2/1qER7XBQ42+CmxsuxW7/YA/tBLWeR0XIe7Y72Ps8Aazchy3Hyk2AH5YxR9G1PoekhkaFP55TuqtUiGHWOEuYDQHoR4VKQ18ZNK/5zyZd8eWTgD6/o+rebO8CA2j/DTORuOcxSZaEDxwinlwzilqrmfjdkVaNVLxJYKTyg/AV4LCfApnXIkeUP3F3QLsAH6qJBxFgSJHAZoTgmp+6tNbDyUprVHxkcUZ7bdV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(26005)(53546011)(9686003)(186003)(83380400001)(64756008)(7696005)(71200400001)(66556008)(54906003)(110136005)(6506007)(41300700001)(76116006)(8676002)(66476007)(4326008)(66946007)(2906002)(52536014)(122000001)(5660300002)(8936002)(38100700002)(66446008)(966005)(316002)(38070700005)(478600001)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LBR9zH/OXSNG0QCye2UP/Oq3f7EGL/GsZV3eQc2ZTUmD1f6hcKTldmcI+8cQ?=
 =?us-ascii?Q?Cq7FClRTWs/4Tuzi/X5uNDs/lKJDuYb3+y6YJgFuvZEEYAOq/3IRkWHl2PWM?=
 =?us-ascii?Q?L9QIhI6ZVoXhFMDKbq4T4ycHV1VzoPL+CxaFelRaKMLZ91wqYmabuC3gwRg4?=
 =?us-ascii?Q?M955eteMcgm0EOLQhjUevM4iXF2754jvmExYWar6u3JojbTtSA3/Xm2xPAl0?=
 =?us-ascii?Q?63GawUUVa4BpQcKH6i5TTop7Xv0/CeT2L8p+hoCM5JLquoXEBTSgaRIuth6b?=
 =?us-ascii?Q?iqidLIuspFsQJBV9wt2n84r0STLqZf3M3ryeVPOsWL8f9So+a5V6ajwfmvLx?=
 =?us-ascii?Q?SSV/Nq/VMvG7vPrIgtgSoHNq1+MP6AdmowdG06VbTdbD0C9qRVuMonW7IA9Y?=
 =?us-ascii?Q?i+QhnYx2yHCHUHhiq6guUw3KDpTTOv9wdrEh8IXO+QVv0vYSjcfVjO5GbRoJ?=
 =?us-ascii?Q?V6SGEKfuBq43ADYrhW3PfufHtuyZKfxX2gxqpGAL5vfpDJKbx9G0t0dn8mf2?=
 =?us-ascii?Q?uXirQdTC5193fWwMM+7bmniwOjMEVr5r+iXq+bMoRakeeZxw8jANzQ103NRM?=
 =?us-ascii?Q?LplVnht1Q8nHRRtW3t8ZI/37HdFBanLKg3f5jBVCSR22rWQT5vtoAtiWg2jo?=
 =?us-ascii?Q?yk0io1KJg/qeI4Nl4+YPeR0XxpQDZ6XSloq3SsGnIdBqXStCvuz9jRLK5qsj?=
 =?us-ascii?Q?f06xySFH8/SrTufJ1Z3hKo7tMVlB19kBDcXuJ/xlOFzsgerCC2J7A2cFzdg+?=
 =?us-ascii?Q?DK07n1DNODaYnbdK69Fov01M955yeFTpJ/s4phFbHCzjPbn6lh+ljJk2pgM3?=
 =?us-ascii?Q?43fu5SIvhuPQZdGGkVQ29CDd3/65Fp6eo3aj7tjQnuw7cjOrshVIL3xRmseC?=
 =?us-ascii?Q?Pw/xcDjEVYKDu1BiEKJ/P8b9rlpn7N2yEHGQfC+nCmgJykjqYnhGy/PQbPq/?=
 =?us-ascii?Q?WovW+7XicDrMfpV/FkSGqW61jgg+bH5hIvKx29CmGcOJG2PSKBxDAyDQuH7A?=
 =?us-ascii?Q?DrT2ZdIbeIzwuy5OGkNAl4nxzT5UWMEV6pDlXQ+Pnuti/MF5jEV2WeZOGRZ/?=
 =?us-ascii?Q?VmrNWGVpqTn6jfnoQZTSbfu7PnywJSAMPTTkAGKK8VoImtQot8bq1DQhi1WY?=
 =?us-ascii?Q?xx0WfZyjzbPf9VXNV8R7LyGf1McORRrmwwXDt4/BszWwcsusCzU4c9+Qq5CL?=
 =?us-ascii?Q?L06MnFLAObeWD5GjL/ycgqKkylJxdc/YJGnB3csopGDlCwdisDxsrA1xM3Rr?=
 =?us-ascii?Q?vsKfE1EmM+GLF/9s9dxEU0WpsgoqD5RH+bRVEG1KtKdEpnZgc4ToI+13OW/J?=
 =?us-ascii?Q?pGiEjEK8SF3vQlQdynGg1Tp4hmHGTuekGKNgNbM38U36di8h8F5pgkVXfVht?=
 =?us-ascii?Q?pcpQ1twlVS/5dSMScL4f6Z2DrahrsUPobH7hFeqhAqXyiY3BdcnIfl3WOsoV?=
 =?us-ascii?Q?Votplb8CAv6De9cCuPkq3yJBIVCmuujsSsRP6kcY2lN6U0ksyCpNclt9ubnU?=
 =?us-ascii?Q?EMwawSEVdqSNHR/c6GUiv+tbH3GasMw+k9oA4kaZRNU6+NYWhyCZjwpDmLM0?=
 =?us-ascii?Q?e+Wh+Y6lyxIsmEB9Hrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b35ffc-4297-405d-b692-08db311a4b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 12:28:40.5198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cfldbvf6lmLnS8kAB3MGxlc+HG0Nl1AF5WxWspWhvP8WORC8M8tMyMePfkePEXPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please add a Fixes tag:

Fixes: 2bedd3f21b30 drm/amdgpu: skip ASIC reset for APUs when go to S4

in your patch.


-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Thursday, March 30, 2023 10:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <=
Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.=
com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to S=
4

Skip mode2 reset only for IMU enabled APUs when do S4.

This patch is to fix the regression issue
https://gitlab.freedesktop.org/drm/amd/-/issues/2483
It is generated by patch "2bedd3f21b30 drm/amdgpu: skip ASIC reset for APUs=
 when go to S4".

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 0f7cd3e8e00b..edaf3ded4a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_de=
v *pdev)
  */
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)  {
-	if (adev->flags & AMD_IS_APU)
+	if ((adev->flags & AMD_IS_APU) &&
+	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enabled AP=
Us */
+		return false;
+
+	if ((adev->flags & AMD_IS_APU) &&
+	    amdgpu_acpi_is_s3_active(adev))
 		return false;
=20
 	if (amdgpu_sriov_vf(adev))
--
2.25.1

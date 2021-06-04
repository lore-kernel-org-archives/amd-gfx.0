Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B4C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 10:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A661561406
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 10:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A661561406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE2B6E17E;
	Fri,  4 Jun 2021 10:34:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172746E17E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 10:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grK/3/nwMr6w0KgoxP45Q8Szqbv9TGbLvzUuYno/XnddF3zM0YJaOxYprJSvhGiYlZu5MK2C4HBAg4xhVH6V5PLWayBBVzsfIUl6rNdPNPXbSNuIbu0D3SmcPpeDt1AXLkHBhQ9vrpIok9dVqM6L4T06X/oyXwkGKT+vIH8StkJaPzDRfDdw1PFWyJAL6rGo+mEVCidemRXzI33rM8giNUesrOsZgfF9g4CVQcvQVRKF2Z1yPVdxPV2evRpf/y8QYVUxYH+dh5jUMLupCDpgfJVxTqKMBdluy6lEb1oSFkZ++ZxW+8KPSo7pbPsBlFYFr3dbCHNN+26IjMFi64hr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg5zaUaLylV2exXP5pkNPICCDM/XfhlatHEVAgD5JIY=;
 b=EjlZg1ECMQymD8RVx5QcniZQ1WkcRRiCggeq5lv+cUNYzcvaD3gAjih1SzIY96aZu+T5A7Yt2zaCNyVx8d3qqR1vO8Qg/2ox5byWPNTU4ZhjuU3WNUvApchlCVpSRzJouBGovNqxpSy3qcIyNC+9sBUDhN/6KLvrfeleTzm6tDa31Cn/DUPVCXil6F9aCiicIVBTi/eRZ+YAw07LJxRvCw21/Ok3aRE22x7r5tAvI7l8PPL5zJ4aGwXI3V/DPxjsh8o8O4scofzHSixo+P/y/3zB1U8OnDDwMI5b1cmZoZ6TYM/nou9UALp4TQgSchf+b1VmzZDrtm+2QTW0PgJFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg5zaUaLylV2exXP5pkNPICCDM/XfhlatHEVAgD5JIY=;
 b=pDZaEYyTflsGBJramT2ovO/K50HT8UbMo6Xme7ZrbGOoomoOliE4/myYrBU1kJc02xPdEQ0oCa0pSpsxDl63gz8fjmGJPRVn2h5QtDWaJ1Go1qm1HObNtDuMnWeIVJPTaZGcU/r3VorN5mNXRuT/m+FNwOkc7KOBA//6sbauK24=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22; Fri, 4 Jun 2021 10:34:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 10:34:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11 ASICs
Thread-Topic: [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11 ASICs
Thread-Index: AddZIZITXtvardYzSESB7W2Ox/weRgAC4kRQ
Date: Fri, 4 Jun 2021 10:34:27 +0000
Message-ID: <DM6PR12MB26198BF1FDE54259F212EFD9E43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <CH0PR12MB53484F15A9B0F7394ACA531F973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53484F15A9B0F7394ACA531F973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T10:34:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=56e2711a-7606-4ceb-ab13-6d92a6e346e0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 913b02ae-bae4-4ce2-cb53-08d92744548f
x-ms-traffictypediagnostic: DM5PR12MB1836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1836D17703AB301C85DFF418E43B9@DM5PR12MB1836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+ZbHp7YGACOTjh+RI2XXi61Fn66licdR1yZCOTYP53PZQZn7YHGgw2BQKDhwfcV8pGIA15hQZucwzVhaUk1BAkxfcSJbHIGXhOnOY8ix0E4Z7kRuj3Vax+AsRFyoQvqNz4vM8hXozTi+HWjOP1vfUr8T9OfqxDX5AAiYafS4gEeRRj6LjYLw4/AlkYxN1S03nW1tGbKOiwmhLgtNKTuoJdNC6vlIUytRe8su0CPtbCf0o9/KuRtCdLSZ+UY8ip+eBR57n8VLP743OEp4cBsk5acJ6GSv7g68hu7GOzb6vqpwn7iR6ar/7wcL/dKpz17R19u79R5K4Rv3pBChI/2xzLKGHHGZdkC30P/kHAXdeO1GEZW3FUu4QG73jaGkHJYWheLsOF6H2UuGLmAipXXaJ8wNEXD70phi17yBJbD9wZXVVUqvABQlNJHgD/rUFNzpskTUCQkYFh0TqIcZzp6alublMAOJB9aB9yYDkIpK5rv6FlokdRFNuaCDoM5JaZM2z81OmPgCTglVHsZtcRddOakUzkKEg6FbO7Dft2lKvQaPQq0n4gJ+sw3l2fEp414gXjDPIJ1m+EmQvT9yB04TE5NhsqP9qSB0wteTqjrn9R2Cs2REUQIM7FjvcQlyUH45ghI7d4aSELr2npiAIFZIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(38100700002)(71200400001)(4326008)(9686003)(52536014)(122000001)(186003)(55016002)(5660300002)(316002)(76116006)(64756008)(66946007)(66476007)(66556008)(2906002)(66446008)(8676002)(478600001)(8936002)(86362001)(66574015)(33656002)(7696005)(83380400001)(26005)(53546011)(6506007)(110136005)(54906003)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E0JwHvWwNqH/Zs+dBxHLijx/rhM50nounPN6EPsIkjwwudFFTpyoLEJRurEb?=
 =?us-ascii?Q?okWr0uQa+f9Eu48BpUUTgqteD9+/fifulLHYAuF0BfAFLD8uFTs+Vfb2kD+A?=
 =?us-ascii?Q?TYeBT600k0Q9DzkSI/9RWXiQomOPdGOdEQFpkurIYmZAUz5unPHLuDSWoD66?=
 =?us-ascii?Q?0upSwtB0XXxl/iKd/P9pWV9/OBKWLA6DaEVHVg8G4Mv1ObtwAD3rgDauPOaY?=
 =?us-ascii?Q?CBmbjBwS2gb8y16/4wGtK4po8LaTDfavBPxix7shYXQFOx4RqvW3ivUW0Itj?=
 =?us-ascii?Q?uOzwZ0FOiDtHsrJN+yHx/2nZl40lLnlSvKPwOEqv2EJVmTqTJLEACi8VZMVo?=
 =?us-ascii?Q?qel/ITpg1H5pgvPMrs6rFNlEbWLn+ay0UyEFc92poi4RE6J7w/glBR5Ul7dq?=
 =?us-ascii?Q?Ia9Qv8hwkxqvzpbNYjjMpmloh8fQuDCHC+wLmv8anA7SrZckjDUtkazYfkrl?=
 =?us-ascii?Q?4OJtP2RlikNsDRitM7zZFAvQV0uU7iRbB66j9tIhw5FWSSAwhMkpPUbj2kJI?=
 =?us-ascii?Q?uzYLWbktc8JG5FJFHWDnmq+OTxb0m7HS3fhUXLqfFWLx165JnBwIfRtsXxux?=
 =?us-ascii?Q?iFEhDMQeRwrL90dGESyhrYiiVwgVKEi7smxc6s3CiFng52AacgLLbmQqTh3l?=
 =?us-ascii?Q?0MCKAO6gGc13qa5xJxB9mscFcuWXcu+Rt1aicRSLia69MrVm4iCVPQ3DfTkL?=
 =?us-ascii?Q?8mZBnM7Q+n3QiCTyk/DYZEee2NHOEX9+pXCIDmLKqYG7pU4I1IM1GSbL0Yk6?=
 =?us-ascii?Q?eWstdguI6xhGiWC/KFh3BpFoXTH9Rp6Zl7qANt/ej4/AK4wZ4MTTA9ZQMQG9?=
 =?us-ascii?Q?t5zqy38B0G8yvfHFbGg2HLk7uU5y+SDB+Q3rs2uXSQh6MS2Fq+wpO3qcPP78?=
 =?us-ascii?Q?3unKXk0vqWgmKtcSkiqT+B9Dmdbc3PZ5leCZK0VH0Bn+h2ozwheVDQClU5Ip?=
 =?us-ascii?Q?OwMIslY6KJYFAD8P5uFt2ggyScpEyerLQG5mC5IDkZvLf4X/TwP1rux18Lvf?=
 =?us-ascii?Q?5cTF35Jjpz0Dkwhmwmj+L9pWjuLgR5CZ0w0MzgKLds7NPe3Dwiu/Iydf57Dx?=
 =?us-ascii?Q?p/t5XfP9RGGUC7shuYkDLi3TlZceWqG0HoH3/4PyrrVN4nxTGSWzdsu6LhUO?=
 =?us-ascii?Q?4QAvs883PsVqMiNpa8XiB1RiGS30+didMWjdnaO7T7BzERbcNiDlq+MwGOKw?=
 =?us-ascii?Q?ar2rM/COEv3IsKUPcTIM+fAndEhrVXwoXr8Iv1JrBdpzYjMwuKn9nnBiIqAK?=
 =?us-ascii?Q?nPMWLV3fR6q3gRRLrQRpEzPE4B5zkLbTTirzPsHj1oHEwmWkT8Iy9FPOmOau?=
 =?us-ascii?Q?V4ziSu7btgc8jz/Y0bJLSTmh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913b02ae-bae4-4ce2-cb53-08d92744548f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 10:34:27.7816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ofXa4wlqt4DWCp20anxycurHNxEyiuNZJ1UpNS6dNmTLNLgMoPECdj9f3qV/kjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0434613999=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0434613999==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB26198BF1FDE54259F212EFD9E43B9DM6PR12MB2619namp_"

--_000_DM6PR12MB26198BF1FDE54259F212EFD9E43B9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 4, 2021 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11 ASICs


[Public]

Remove ASIC specific functions for BACO support check. Use generic smu11
function instead.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---
drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 12 +-----------
drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c      | 12 +-----------
.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 +-----------
3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5c248accc4a6..5959019f51ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2162,16 +2162,6 @@ static void arcturus_get_unique_id(struct smu_contex=
t *smu)
               sprintf(adev->serial, "%llx", id);
}

-static bool arcturus_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev)=
)
-                              return false;
-
-              return true;
-}
-
static int arcturus_set_df_cstate(struct smu_context *smu,
                                                                 enum pp_df=
_cstate state)
{
@@ -2406,7 +2396,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D arcturus_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 31e9cc3f3ea0..74a8c676e22c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2257,16 +2257,6 @@ static int navi10_overdrive_get_gfx_clk_base_voltage=
(struct smu_context *smu,
               return 0;
}

-static bool navi10_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu=
)))
-                              return false;
-
-              return true;
-}
-
static int navi10_set_default_od_settings(struct smu_context *smu)
{
               OverDriveTable_t *od_table =3D
@@ -3102,7 +3092,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D navi10_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6614dbb723be..f01e919e1f89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2100,16 +2100,6 @@ static int sienna_cichlid_run_btc(struct smu_context=
 *smu)
               return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
}

-static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu=
)))
-                              return false;
-
-              return true;
-}
-
static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu=
)
{
               struct amdgpu_device *adev =3D smu->adev;
@@ -3882,7 +3872,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_=
funcs =3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D sienna_cichlid_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
--
2.17.1


--_000_DM6PR12MB26198BF1FDE54259F212EFD9E43B9DM6PR12MB2619namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Series is reviewed-by: Evan Quan &lt;evan.quan@amd.c=
om&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Friday, June 4, 2021 5:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Quan, Evan &lt;Eva=
n.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11=
 ASICs<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Remove ASIC specific functions for BACO support chec=
k. Use generic smu11<o:p></o:p></p>
<p class=3D"MsoNormal">function instead.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo=
.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nb=
sp;&nbsp;&nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&=
nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 3 insertions(+), 33 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arct=
urus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<o:p></o:p></=
p>
<p class=3D"MsoNormal">index 5c248accc4a6..5959019f51ad 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2162,16 +2162,6 @@ static void arcturus_get_uniq=
ue_id(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(adev-&gt;serial, &quot;%llx&quot;,=
 id);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-static bool arcturus_is_baco_supported(struct smu_c=
ontext *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(smu) || amdgpu_s=
riov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static int arcturus_set_df_cstate(struct smu_context=
 *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;enum pp_df_cstate state)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2406,7 +2396,7 @@ static const struct pptable_fu=
ncs arcturus_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D arcturus_is_baco_supported,=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi=
10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 31e9cc3f3ea0..74a8c676e22c 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2257,16 +2257,6 @@ static int navi10_overdrive_g=
et_gfx_clk_base_voltage(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-static bool navi10_is_baco_supported(struct smu_con=
text *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_i=
s_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static int navi10_set_default_od_settings(struct smu=
_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *od_table =3D<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -3102,7 +3092,7 @@ static const struct pptable_fu=
ncs navi10_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D navi10_is_baco_supported,<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sien=
na_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">index 6614dbb723be..f01e919e1f89 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2100,16 +2100,6 @@ static int sienna_cichlid_run=
_btc(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, SMU_MSG_R=
unDcBtc, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-static bool sienna_cichlid_is_baco_supported(struct=
 smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_i=
s_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static bool sienna_cichlid_is_mode1_reset_supported(=
struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3882,7 +3872,7 @@ static const struct pptable_fu=
ncs sienna_cichlid_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D sienna_cichlid_is_baco_supp=
orted,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB26198BF1FDE54259F212EFD9E43B9DM6PR12MB2619namp_--

--===============0434613999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0434613999==--

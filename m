Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DDC369AB
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 03:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7294C10E13C;
	Sun, 27 Apr 2025 03:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tzkh+g5C";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C10910E13C
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 03:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNdepH9n03TnnT3kxs6IopSSfqSMvoAi3P2vIPSwiswaBEHMNl6WrDsFAchcAOCFuYAGc02Axv+y3c/E/yMxTMtAs7mqMrrsPEBxlnircjTCKIew/IqJSaJKa1yZn8yfraPI7s+OfPONbBwruLsUFXuQdgy+xUiHtdeBNZLZftrXRvgm6vMkRuWqMQa/PvK7MNs0A3Fa/HgJeNKDnvJOsb1RBhME5yEYQahu26D2F4n4+UuMEGUEu0/LPdeUaSRV320OiBLTCf+FnRhf/Hs4gMwjh/2SgJraRMef8i02F1Vnki2eQCi/hb9wA7ZMycFHDP55l418bh7M8HrcdnIpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vly+CuydGHWyjzfa1hyaeQe1McyU+W/T4DKIRqRlv48=;
 b=un2/mUN3TL5b/fqxLPfESzuuv+q2mrIIWA97YCQWsyYOyAuGepWiZkeGQ8oSNW/WLXmc3V7QifS1uEJfRxU2Dc/jHuDXSs5mI1YQmU69znTdKAz2pZvm4ntMzUvvucPx/5H+DusuAvyN6hc5H7VyfSWS59OGlTKe9K82APgl9XsjRr3naWc8+gIwt/tWBO/CmeqNQUBvybkQvTGZIS+MDPcPbSMdw8nm13Kqz8jp3yjlvgBOBJVcnV+zxOyv0dJ1Qk089QuSJP6CV0hRSRb9MF/aFV6JSwPymck6II3jouAAS1/fwRMc0Vvv7+h+crAIhEbuLJPAYgV2iIpYD/ejRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vly+CuydGHWyjzfa1hyaeQe1McyU+W/T4DKIRqRlv48=;
 b=Tzkh+g5CM4QRi58S60zJFDVme9ODoBs1AclLt1fJtxM/QxbyMTjnl7DkrmdSvfeuHwPxOM8ftkaOqfbh75DIYYzBrJlV8S3ZZhmEVSEgV7B1PvUEFECmqWX//9dskn1cD6oT3ycyzCzitjck3ZuThfKJ7C1dTPMbEwWtnfXACBE=
Received: from CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Sun, 27 Apr
 2025 03:14:49 +0000
Received: from CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f]) by CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::e269:bb1f:4872:538f%5]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 03:14:49 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
Thread-Topic: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
Thread-Index: AQHbtbHHw3ZAVk0HnUeh31fmiK3bUrO213WA
Date: Sun, 27 Apr 2025 03:14:49 +0000
Message-ID: <CY8PR12MB83393EBB34B1259FF551DE47FD862@CY8PR12MB8339.namprd12.prod.outlook.com>
References: <20250425071447.922183-1-lijo.lazar@amd.com>
In-Reply-To: <20250425071447.922183-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ed5059f-a111-4cfc-9f79-05972eed77ad;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-27T03:06:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8339:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: aae83e84-9cdd-4d84-37fd-08dd8539ab75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IEUWFOaS12Wiz6dBs7VKV2iq6gWMZlnu8JzSFeTjmwNAbI5SkechL5YUNT4F?=
 =?us-ascii?Q?z1VP3sV7RLJ04doOt5OPxWnyPxicqOg3l/zUYYA5XW/TLAhBUvgHbyyeC4aB?=
 =?us-ascii?Q?AewORZTUtlltLlxZWWzSjDd7beNUGRZHtutMXl3qVvNvCQFDJGto8e88ASCJ?=
 =?us-ascii?Q?3VJmYmoMjh7odXFmP150VoYFf7Ia06UsOt3kmDZ3WPZPvZWuuRqySTHe3wrm?=
 =?us-ascii?Q?jt9N2lxWvZSIv9ureTkjexgaeJyNFJEQkYSTb6ZHyocjoQqRntXWS/81sFcQ?=
 =?us-ascii?Q?BASlbFQGFtdVucbTShQK3z0g6kCtNWtx1Rnol2NO4Nl8WNzlyErLZwZ+HTAh?=
 =?us-ascii?Q?S9IbFi7Zi2rfKDCWY2nS5sbYf7ZEWUK2r0+fpt8xaZ/q6x5e15Pd6c3TIwhk?=
 =?us-ascii?Q?EVQBD5a88WlkAPIQEkbgWrqYExPmHs3Wzyup0j6Ul69QCGfeyLcuIJtpTDvY?=
 =?us-ascii?Q?d6UYn5tmu16Ylj9eUGvUxT/9utouf7ISX+5MM+CRNZwSaCfOEnLCFQvT41NZ?=
 =?us-ascii?Q?bWD+7AB2283A9VO4FKdLFD8S/iSl8/dbGutdO50LwxvLicHrgsbjA+eMxN7M?=
 =?us-ascii?Q?h5grxM/mS1KMYtXZ6ianH7r6+E1mi0oB1VeSh0vOuMetYe/BLJWF/gn+SdbU?=
 =?us-ascii?Q?dJVulEnR8JorM5f+okgO/EMM/A1Bq0/d7lB5uh9O8IXw27pMn52FRCynqFhd?=
 =?us-ascii?Q?bCJpxgX91tP1zabo3AmnOEHf4JNYmEVYgNsP1LcDm7P1x7VzzpHU8eD1El8X?=
 =?us-ascii?Q?lcJikX9t2HNtJ9+6+3sfGHvy0/j/mzoc4CR4MRa162+4pzwVcD9l7FgQ8Qx4?=
 =?us-ascii?Q?fT0RHm7P6Tcq1OgUlEVUgjdNOmXyyxdPgygYkBxT1QHdlREYDO7SY39tODEQ?=
 =?us-ascii?Q?Ezvrnd5zxzxjjQCUa/5B0N8BXJLF8PAoPlPpMkk/4k74B2dM9Cf82vFA2NQo?=
 =?us-ascii?Q?0/gNZhGiu9ckbCqLripnCiEkzp5gNgfliz0EAINg9zSPRPdD+xDoI6Wi+Iqf?=
 =?us-ascii?Q?qEBiSe4k1AykdcpX9r/jZppgE2LW9NhGIuwiL964p73iHfonizlSXoYaxxNR?=
 =?us-ascii?Q?XTo2WT5kRXeKJD7BPfO+awCuzVD/UzR0HNv1REdbVJ8zpbodHZokv3xXsJKK?=
 =?us-ascii?Q?XHGJYs++mboh//Rm4tkX1NLAuVtOd5nIcyYFr5IJnAFvFA4kTMGH+bDKs0kI?=
 =?us-ascii?Q?9yz3NSZRsufNvIXEOlCyfofnpEkoi/TeoBCv+516tRzKuPt6uFsWLl/28tRw?=
 =?us-ascii?Q?dgzYKEpvDQ7mfb/BOlclrvoh3rIX7S22NOA2fGPmZHCCE1wO2NJyAc9Y66yJ?=
 =?us-ascii?Q?kWL2rrLqrWP4vPQByUQpK2dhBSJ9D8FPX7Mh8xXVn8PmDWnhPCKtXoEChoS3?=
 =?us-ascii?Q?eHEnDMNuUG/p0wcYID9V9oUmuEl4iIVQa8EF5OX75U2dZg4OnApO+jukgyyH?=
 =?us-ascii?Q?avf5uj1/AkBUCgf7g3eGrqaZuScVBCgmoih/2LVoq4GuXfJnGLvZwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8339.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LB9xvldaMsSIZcTqkW7zSV4YdRBfPKbuvAYC/PsSGbNEA1yyExbfHdo2BNkn?=
 =?us-ascii?Q?RAbSBqPZZ70DB4JmLSanOChO7neSsc7f1ZB8oiOQZTOICeyjkDKMbGjzAiU8?=
 =?us-ascii?Q?ZaKyeD3f8QdN318EKAhQyNR+30O1MBzfs+fUCLEBzsnb6Bu3MwRU8rpLoUN3?=
 =?us-ascii?Q?3cuMrv4Lnu/y1ZXhFZCvUZdKyAbgyMUkMPW+coZYXpfPWzivsuUTOjGzBpLW?=
 =?us-ascii?Q?SWm2oLhVh1a0hzZhJtN44QX5Z0z77I2eWFW5Le71SPIfwOln5gshh5neiM0j?=
 =?us-ascii?Q?6DBGrtcSQqXI4PfO+U1SkPRKi9YV2I3EuEYYQQVTE07jkBbchYht51QFCqLa?=
 =?us-ascii?Q?3ZWtRf+nASJRBsLyxzQN4KwOUdVUxu+SpvASzSnd+f9nB1ankuqSYOrxKdtY?=
 =?us-ascii?Q?PmQ8i4XoaI2yCbz+8T52/vcGaL4nnI5LKdkCmMFTBQw/T+U2cuQP7RUiQ32g?=
 =?us-ascii?Q?2AttTZgtH71FcOhzDhOweGWbgMWfdM8BQSgmIqhjp9uZnkXIfFh2tCiN+Rxj?=
 =?us-ascii?Q?ygfyR6/owQjsd4WuxXt5Gzf7y4P7rzU6Jyo5aYNC/SiZXQnWu9EOEUFWBoeU?=
 =?us-ascii?Q?eRmxJ4rTj2/2UnWEGBdMtiD0u9Jrh5lp99SMXmZ5NY+5Qcor4TmtamYJdc0q?=
 =?us-ascii?Q?uMBzIRjkcx5iE1TcwwcVP+nyBeku4nZC/H2mn4VqZ4UjPIx+ZhjiYJFUIZGL?=
 =?us-ascii?Q?mUWjdYkHPL3j/Y6VyV/wixtX2dM2SyFG/29HEgnFxLLEKcS1KwQA9gV/Oczm?=
 =?us-ascii?Q?qxi00M1OJU7kchVXxmkfOeAGPWIb5jJhNqAbMyPm2G2f+tDw9U3yr6UxVOFZ?=
 =?us-ascii?Q?6nq1e7kMWDJ7ss8WYgXYX/7H6xBcauCaLNE+LCs0ujjB6dD/hlPJUscxSSxr?=
 =?us-ascii?Q?ubTSTrXa1/+Fmz05C/u7nIB/ECrCld6fcbPVhdKhK+CVDY7FrDkNwUcIeuuc?=
 =?us-ascii?Q?NPnSK5kkhuhRhM1I4WXPI/LWt/k2c+DCIPpkNHYk9SANTvVwHhvDLoUJ0Ifl?=
 =?us-ascii?Q?v3fl/t5F9bex3tQ/AVPheQlzczLfQnDWH2P21a7ILG7fbHcSruN1cVDOiQzR?=
 =?us-ascii?Q?8nI9ga5i99s3TeKdIrTlXUXXjhFcMnfH1KZhrJM3B3Zl1cWmEfvAmiMWL7Xu?=
 =?us-ascii?Q?EWAqgExyo9kTLgi93JMP/xEzvk2vKG37WlhIJcKnwBMUMfK+rbZGU0l4ctei?=
 =?us-ascii?Q?LSaJsFsqF8P+jYKQbLPmkYj3+v4hJjeaeERJRB6osO0+bbVh/pnAHIeHwbOl?=
 =?us-ascii?Q?lv56ve477/hoqmD2BSSMa/OuPji20G41LiobTjyd8id07CPamVPHdROLkxzw?=
 =?us-ascii?Q?lfdlNR6DpCQ5Vs1ncIdB0UjMEAB+iI+WcNNFJyYKUvvI2oO4OPFK9XvHgfDZ?=
 =?us-ascii?Q?0LRj/Yr3uXjuwv4MutZQ+Sv+1FJNI1VZgWfapvMxjreaKQp0CibWxs9y0x7A?=
 =?us-ascii?Q?YgMTf/omECVMd2RK3DK9M1D4NoVmfQcmsGk/8tDqj7PSGXF+4gWlJ3Wwdxk8?=
 =?us-ascii?Q?Wqc+PuMpgWxjMwmL2jQlv72ELSMP5PpNiOmZqV9GCL5nFsDta6lTaaJW0582?=
 =?us-ascii?Q?e9oKfhrs+llAK/qg9Wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae83e84-9cdd-4d84-37fd-08dd8539ab75
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 03:14:49.2305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gabU2/Ztp4eXgTcPbNBvGFqYTaIBGDT11qbhnuvic2jB/Z+62EREcTwK39nEUk9RnkW5m2nEtoQrJZB5IbKrSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: Mangesh Gadre <Mangesh.Gadre@amd.com>

>-----Original Message-----
>From: Lazar, Lijo <Lijo.Lazar@amd.com>
>Sent: Friday, April 25, 2025 12:45 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre,
>Mangesh <Mangesh.Gadre@amd.com>
>Subject: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
>
>Keep the register offsets as per link order for querying XGMI v6.4.1 link =
status.
>
>Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
>Fixes: 0666515023cea ("drm/amdgpu: Fix xgmi v6.4.1 link status reporting")
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>index 95231de26cb1..f51ef4cf16e0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>@@ -297,8 +297,8 @@ static const struct amdgpu_pcs_ras_field
>xgmi3x16_pcs_ras_fields[] =3D {  static u32 xgmi_v6_4_get_link_status(stru=
ct
>amdgpu_device *adev, int global_link_num)  {
>       const u32 smn_xgmi_6_4_pcs_state_hist1[2] =3D { 0x11a00070, 0x11b00=
070 };
>-      const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] =3D { 0x11b00070,
>-                                                      0x12100070 };
>+      const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] =3D { 0x12100070,
>+                                                      0x11b00070 };
>       u32 i, n;
>       u64 addr;
>
>--
>2.25.1


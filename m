Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7BC36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 04:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE4A10E00C;
	Wed,  2 Apr 2025 04:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJiKUcF0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9056910E00C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 04:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzV5WhGd7CtYiqIULMYLvZRc06bjteazceiuVYndcLoGfJrfl+OyUqaCDsiaZrQppk75naaSiq1Z/QNlEn5ESd7X9oxIps6MLsgsHsqcVPm2hqncVr8z8TUvuCEdzzYaYXgA7HYMH94/XGN/SNKib7tqq6+3wB256tcWksrM/APVXkcI6lt1RXmUX8svEe/0gmh8zpOjAH4G4qIW/XiQxFZUhTRkWjN/YotsTGiHnlgd6vWDPh3R6m6PAiQ3bcFlt9l08QgtlgHh4W0TQK9Lyj5VS75n5ImeuaX/SJvTvrTu+2Ypd+Y47boexl5YmVJmXtHTl5g7zp8kQcl5iz+KZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hqc8i56FXME26/t6/gZxYT2ijYD6XkavFQpd9koYfc=;
 b=D5Y503IQboBZ2WHtzcVkpJobG81y8S3+SkTspHGBup54CpwBcCL7LvWsjpuL0sxXoMAqKs4sDKNyHBXktEUk4FlmwoWYlbDk7MV71TbLQamJ+zq6fwUBqR5T2Vh4d+bdolQnQxeXi3G7hM1kTfnTKy95E0FtayKstgNt5gyA+h4EEsA/RoKJ0uBePDzlRPsPn/2Vt89ONOdZM1XZAOT5FbQ2Dn87pX4wv63xMZ2tfjSx+VZvDkPT4sD7KNI5sA8xqluryAD1tqZB7fr3D291lTD/7RFOWfg3W637x/QRC5dapVPos6OLbfk4Gxf7GUahUfT71OE3Id308Nn4KOsBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hqc8i56FXME26/t6/gZxYT2ijYD6XkavFQpd9koYfc=;
 b=DJiKUcF0L8swOedgVWMyREnkHLsRLiCcRZ5zRB/8ghn1MW7dydH1MTzM5pojC47VAfJMoBE/hg5Rd59ezgj4ob7amapsG9x5K+b38UL2QGBsXo4UWhX3EPISqat09mYcLWvzoOi4ESXJYrzgaAyKdwegy5/mloSG7hbd63gy6Qw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 04:23:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 04:23:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>, "Yi, Tony" <Tony.Yi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix CPER error handling on VFs
Thread-Topic: [PATCH] drm/amdgpu: Fix CPER error handling on VFs
Thread-Index: AQHbo0blMtkevJDmtEScUFmEDaUFq7OPxz6g
Date: Wed, 2 Apr 2025 04:23:47 +0000
Message-ID: <BN9PR12MB52578A1D5385C8EF5788EB8CFCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250401204415.417443-1-victor.skvortsov@amd.com>
In-Reply-To: <20250401204415.417443-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8e6b4605-e48c-4c9d-a4ba-d4c3c7d1db05;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-02T04:22:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH2PR12MB4230:EE_
x-ms-office365-filtering-correlation-id: 667d37d0-0a51-4e58-3d25-08dd719e29c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2U9qngRoS1yfO16a+dNtY202OoGHczO9FThSqflKwbjxk0ETazaryhwsrlnk?=
 =?us-ascii?Q?6r1V2iuidwpquyvIcnrYSeOANXKXW6NLRJApt2cL5TPsYAIImJmIIx1eEed1?=
 =?us-ascii?Q?ddH88wbAHYXtHlT2SzZ/bOWWT8ElSMjzia5o3Jkl+ur4a0TrRCOE5IfSOsW5?=
 =?us-ascii?Q?GrPwluSgD4MZhOGD+yc+TFm7otPV4OyRBvSpZUKeno5zPPw/ZKb6tJOMaslY?=
 =?us-ascii?Q?9MLBwviNhkagy0shXTrboggb0+p2dRi4SYwm+JIHxTpYnyCvNKSie3WZD13h?=
 =?us-ascii?Q?+XLUhjXdNau80k6KRhqarPN3X6DGzH/mMIbJAlZFq6fNVAVmz8axhjxd/ikw?=
 =?us-ascii?Q?kda2s+4+46muiHPP6bAUurpY4WS35IB78vHnJ0fG+uUvKKKW7YThMWqmOLI5?=
 =?us-ascii?Q?KrCCsy0jfpKqRYEYKh+0XzLAtbWkWCy5IKdMGCg0pewf049ZE+2dHFoVGYlo?=
 =?us-ascii?Q?tiAHs5vZMIp6Oo2xZPCvkvWfixnPvJql+ZEN5NtEF99l6TJ0bc5R18RiSX4u?=
 =?us-ascii?Q?7cJhA6nFUo5EiXlbI56H5+g2SnsYLnZhe/pX7jo6m7JFNeFfGoTVtwe1z5v1?=
 =?us-ascii?Q?jFWb207wenamqT8EQ4bfZ/quKiOOi84355VrWe+0bDYONuUMeH1oBmWcTJ23?=
 =?us-ascii?Q?NvafK69aS91vYFC0uZG/NWBmfLSdfa1Mn2CmQBWvEOpnYi1tTkxGqpuxLMRj?=
 =?us-ascii?Q?RccOtUIHj9L+UYKk8KOfo8YTqJMOhwl2rfLn52bFEPNH0Y/sxq2xn7Xh3iAv?=
 =?us-ascii?Q?ceVRStWR0wXpiut1NlGRXC0kB28grWoKB1V2NhSfyynQ5PFMORUpGuJehu6U?=
 =?us-ascii?Q?FWjE+6lJ4sqMhxLPLrMlQijCEoYtsYzVdlo9ZQugqsCJo7CYMuBNqdWMIdyy?=
 =?us-ascii?Q?npB43F96uXDofdpmLjB7TBGjWg8JaF/HWlz5UKiQ4T/9LRKCokNZ0xQkHk4S?=
 =?us-ascii?Q?0MRi74ijkV+OxGNMmOIg9KNhhnZrJUtjRtv4TjceJKCCCFGDHnBT/uonBu+Q?=
 =?us-ascii?Q?8Kj7NYM8CzUXGVryRG14+T2H1lIYUD0oN1T/5JxEvy1NkreN3QzqQPD2dKyv?=
 =?us-ascii?Q?8f0W5whQzKHrIZ8yAnftRchnQfDFAmfqVYv5/b3sVLmcg/vXW4c/ik0v6t/A?=
 =?us-ascii?Q?IjPDmHad3d1E8uuKChuggu0fNp5xwdzcoT5ylffbDey7JQZUFiOwwtuA84vv?=
 =?us-ascii?Q?9oFPKeuUfaWxwewKmnwNHw2i9fNIgmIG19NO90OCigZgdNl2YaZ3+2z7JjsO?=
 =?us-ascii?Q?Cj+gz4dtfQoTRVQBp/6kkiVnnI8eliatk0bOHn/7rLUeZSohF0hH+wiAuMeF?=
 =?us-ascii?Q?Afuo1s/UrREjzL/fS1Oh67fMSJ9C6+VsHyVTXkQ71a7Pr5Of5jAIhlVtX3jb?=
 =?us-ascii?Q?2NL+W37UDz0k7Dcz+rEyDiROH70FfdN1ZqkfNYR88uvniYs9luAab9rrd8G2?=
 =?us-ascii?Q?gmPum+mAQIfcx/Ww93jladoA/a3PMqst?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ei/08WE0GLjKahfa7est+ehWBxv+hZD6x6D6z5KM60cf4aYdleAMPoVZJKuB?=
 =?us-ascii?Q?FEo/J/IpcQf2IJbgQFVlTXTZtw0biZV16kr5JiggMOhTnONfu8kQwQUToiDh?=
 =?us-ascii?Q?f/Ic/6dBLX04B3THcOqrjfYzlHXd1QmT83/ams9efB5z77ldJssGcc3hIlMg?=
 =?us-ascii?Q?XVOCOAQAeJ3ZSv0b5Lgx7HKICqICHmrQgBcugeSAuleh3LOvhUFXXLSDgrqv?=
 =?us-ascii?Q?ld2HqRAmrDVzL138NraArebmREt8+KnqRyOz2u8oKp/64RkVgST7dzGzzcnj?=
 =?us-ascii?Q?PBaygJKpQfq8p9K9cXKKDm9O2wuCKFqz3mzQbXT3qR8fxTT2W8/6rABSL13+?=
 =?us-ascii?Q?5xTABhpwTfVf+cc4qGQSlNesI94cjRvcPU2m83z/rDxjtROAxECXKj1MkT5I?=
 =?us-ascii?Q?7p2JVCORT3j5Vjrm3uOUOTEt3MuJOODB69LEb8zHG2rIHAqstP3wxyi8pm96?=
 =?us-ascii?Q?wRs2FuhhvRM+eGvvEafwTlswGlWT3otvWGs5VcQn/J6eZshLue/18FDoPRTn?=
 =?us-ascii?Q?ihEI77a5u9Dr0Acb+P40g8EvyoEcpTESSc0HSGyGGHCzKb+P1kFQ6a3vIadG?=
 =?us-ascii?Q?NKroWeKOFyIte7IXkX4iw8n2FCPXQ9jdPEa82VmRWL2mCksk2Q5HZWC7InBt?=
 =?us-ascii?Q?IKuZUwHIRNXpvC4g3yo2cRdAE8Vvt7YV3gmrD5+T9i3YL++RuVi45DTwrkMK?=
 =?us-ascii?Q?9APpd6dTCMymi7lvIdm5Cb6XAZJovh6Vm0dAKhZ9PiqDnjekNsdpyjWIzq1A?=
 =?us-ascii?Q?rJRBEfNz722jm5jYEL30PqXWVyN6HvXvkIQLSCsiC6DWfsw+XwjrcRhx5MFQ?=
 =?us-ascii?Q?CXoX4aYZaELe1kPTWpLDqyjfUAfyIf4es58sNxLPR2Xb/5oQWD1ZCS3qME94?=
 =?us-ascii?Q?oh4az8Dr3ly+Zt6hDXe1q2iTlloai7nc2IS4bUSJ0gJXCjNP4guSe0kJilg8?=
 =?us-ascii?Q?mfQROxC01IVYnz0Pyv8b6MCPsxIqXHs5Rmt0xM44y91+VbtCEZdn78jgoc5Y?=
 =?us-ascii?Q?bUzNcrpBilwLInlJ5hgFnnzHcO0w1ftCYd7bgKycOfWy0W0yVZTVHNNIO2i7?=
 =?us-ascii?Q?NqlLQsrtaaTk00nEY0WzP/C5djPIGSBlOqAtBJ0HQRSjPNYi0Gtpl1aY+bmn?=
 =?us-ascii?Q?xkfDZEL6jAeG9wVsLWAHFoMAs5bZ/t2z0eR0oQAoE4NyUfuGQyuScFnDU+UL?=
 =?us-ascii?Q?qgJO0I8HQeZdw5PNLx7go9SXLelpe4FVXTtuaqqNn+lqEhRHIsxW3ntJuuF+?=
 =?us-ascii?Q?D3yXHEr1Nb1Akk151eOCI3E22qFXW030Y5f+0UfQtK/Xkk4XMbw7FJ8d+dIn?=
 =?us-ascii?Q?4+ObTZGhQ9fJcrMCk8x5FWAASPY0mGPaBoK6lvZxkcx3DLizgBp67KbVP365?=
 =?us-ascii?Q?8Dq0RYhNiZTrtvAHmtEWg0bQJNWVt3UUsMs1AXpyvqchb+7Gzd077dCO8Uou?=
 =?us-ascii?Q?HBn1qTDugQpzXk6zFXPjvBnS4lsLPB2vwLUT1VRsxhok1HLav6gFi9xMbV4Z?=
 =?us-ascii?Q?KKKHaaZ7HVISWlm7lTMwP+7gD4uWB6ZQRxisGL+kl+qtiIeV8tXBn9wkWfzX?=
 =?us-ascii?Q?laS6dvrcCQWBOX92Q30=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d37d0-0a51-4e58-3d25-08dd719e29c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 04:23:47.5907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uga1e4mLsCy1+SR5CtMdD2ASYSYxbarmT/u1EazmrZu9LWuDlH5yyGo1G+L9q0/Yg7bGO1Wp4W85hQVJJzjuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, April 2, 2025 04:44
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Yi=
, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CPER error handling on VFs

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..8d2da3a27440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1378,14 +1378,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
        used_size =3D host_telemetry->header.used_size;

        if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-               return 0;
+               return -EINVAL;

        cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
        if (!cper_dump)
                return -ENOMEM;

-       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
)) {
+               ret =3D -EINVAL;
                goto out;
+       }

        *more =3D cper_dump->more;

@@ -1434,7 +1436,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
                                adev, virt->fw_reserve.ras_telemetry, &more=
);
                else
                        ret =3D 0;
-       } while (more);
+       } while (more && !ret);

        return ret;
 }
--
2.34.1


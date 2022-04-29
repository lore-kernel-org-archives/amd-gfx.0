Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B294F10F67B;
	Fri, 29 Apr 2022 02:39:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C1310F67B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WddLw6dgxH24cyRjm0QzH9uuvMVn+peRibSE0EE0wHZC+i7LdoMYV+L4c4RW3P0gLDeBskEoSpJe251YV6LrdyK3kMZ0yEeQZZ9ASKeZoKzbq720qXrD3k4dA4RWbJ6H/D2TkVQv6U6Mz8XEJxSmyGuSK3C6D137X4AnLzxArJWkGRBl22agWUXepFIv1Aal2VqsAkfqvGpAxIVxwVn9nEfkjzsIzA2wslO6iQRZ2peL9yBvelb2nMnwP/1rXdhxpvbxNvVkN8q+uf0lG8cMnuhxyvSk7eAxPKFYfQvCh/KQyo7J8Iz3hNUidQEnaYw1gFCMBEzVn58SCfJ8w4uuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rqY5RzqIHp8MTm5RTOcoqa9TWx4Y/RFx2yOiIdgzBU=;
 b=nK0T7pm5wuRefQnxHMnwJpXNYNIU7WDH7B2XYqJAOhE8U1Xo1D+ZNJZnRl1oLstd49UmKqO+qm9V0xD5AYMXQUUnr2DTqviBBA/z5iiCPuimKHc+JP9BoCLmmCoSZjd8PUnu7WLu4bOPI3NAC95lUJi/QGLUEqqF9/Pa8j7NUI/nsXGWIBDIWgWeadyaWwASYXF1c7hhbtaCoZbYWVKBIeAj0TDaeshmFYZx7bMGWwa2xFxAr+sQQ2dhivavFMFrYHQKYlB61NHtPXjQb/tOESZKDRYSIZ1zkHnJfTf6x05yTliemhDcB+IMRyqvs4qgzWck4fFJiRhJyhOeH8yruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rqY5RzqIHp8MTm5RTOcoqa9TWx4Y/RFx2yOiIdgzBU=;
 b=lXoUK0Z2vwyiR+FHIHxFjMfwqsqVBunlZcyCz5NDz9o0g9MY2WhrKIrd8ORjalG0L4JUXRq17VTFT7bdmrRhyQG0DcVFZIWnEP99UkxbBPjC2I8cvTDSfNy/S0FFiZhPbst6sgCoJmWMoy6kvPwR1JqIwNwO9Hv8FaUlkn+d9Gg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 02:39:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:39:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/discovery: add GMC 11.0 Support
Thread-Topic: [PATCH 3/3] drm/amdgpu/discovery: add GMC 11.0 Support
Thread-Index: AQHYWzFaCj6nG4uYHEib3c1FnM7vzK0GLlKw
Date: Fri, 29 Apr 2022 02:39:51 +0000
Message-ID: <BN9PR12MB5257CD33C62CF87E8D029E6DFCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428185349.672503-1-alexander.deucher@amd.com>
 <20220428185349.672503-3-alexander.deucher@amd.com>
In-Reply-To: <20220428185349.672503-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=de7fb8ed-dc0b-40cc-a476-b224b036e2b1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:39:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee053d41-3f84-4a5f-bcc7-08da29898931
x-ms-traffictypediagnostic: BYAPR12MB3623:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3623482335320C429AB971C6FCFC9@BYAPR12MB3623.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYI3FiFl76gBsaHGjZiGOeP72rIGnqHbSCY8LpOoYHMmFNxBUdA4/ExgrEw/NVuzI11sWAcs9p4uSfrIUohJLm+cgqEHwiHM5c+WY5N27l8hQpQC/CT0ehJJJrQmL2ZIgf7UWP3gA4LhNWwfhgkCRl9IvTZDKRstgJgXpTxlTxtaLDQtMpF6SftBt5dzhTQIcJ6rAaC3vjVPb0JuxIBB/uPLJS0b7Snu7l57tY4RKMPeF9MwMFAraf47srrzMisResjzWDvMFvZUm4HIj05N6Wwrix25f2ffCtlb+VjBObqZx5b+e232oUPaRI1DAqZYUWOuDyTKaOlJAyp7wThTkrNa3L+IamkQpNHIpLY+BTsxqDZd6epY/QfeUofQRPaO/n7CaBtCzdDuGT0lOFD2GBtM3A4UhK4R+/1IM/xhuomTklYKRbD1OUm9b6abn8t8ohYwm2pCZOmTkQqIAKEHe46rGq6mDCWA8qKglk1XAePEjbxSeFI77O+PorRWda25lynXpO9LMH+6V1kALOmIw+9KVxiSP4VRw+NEN7p4MP/IRww8l5ArV8dpQy4PROY7Jl2GQRkfgsPr5yMyCFmh0ajdEsWtP9amRXLLAcVbtB0Z6yX1x3JHo2QOAb4925GrH5iHUMUkzbfq6Vcj5D9wLRvKRRhHizHjQLTpaXgArJ8jHf1sSBwVFmmxMmub3EbboBYNlG5eioUm82kXsV3Plg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(71200400001)(66946007)(66446008)(64756008)(316002)(66476007)(76116006)(66556008)(83380400001)(54906003)(110136005)(8676002)(38100700002)(38070700005)(122000001)(86362001)(186003)(53546011)(508600001)(6506007)(7696005)(33656002)(2906002)(5660300002)(55016003)(8936002)(52536014)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sbw2Sxw4DVKfdtA1XoQFc/QE/Q6AfA/92CLMeJWRTgI92ciBdmzCKZPaA0ri?=
 =?us-ascii?Q?8Z1/+4cy+9Rij4XcTQKopKle3rI48jJulMVmPy4TMWFDqxIla5YWy6hFqcNv?=
 =?us-ascii?Q?tIxoIw1Mgu8OUtngd3Yb18X82thHtR9sk2gwSuP5nyd/qz8G084kHnOzCw/T?=
 =?us-ascii?Q?I5Qts0aX5k07xnPQKRlO+XxOHKKAfDANNJwCnVtueG9oeAKejtj8PAaxUyRn?=
 =?us-ascii?Q?iK8R1WLPtBo5tTHTEes9pAkUM7wDXuiSrOpHrK+Ob/FmLQtAkb3Jex4YJR+x?=
 =?us-ascii?Q?167FLPNealNoerTKwg62CdfxEtdu/3nXhL/gEVrh/vyfkpyn/HTbtHvX/VsF?=
 =?us-ascii?Q?tyMF0pY5Q6ZADMM6KuELc67T4M/QJDMg3jGsTMI8OFWJJ7dsvIy6Di6fLUhV?=
 =?us-ascii?Q?zdizeAtiG+FOS/k+CcZ6s1x94utjE3ZXMLK+/LlqKROzDrBi8/rLXWUR8zQR?=
 =?us-ascii?Q?QVfEVsNMf2ptKPbuoiYpgFYiHZcLyscIYY5YzQ0RTAM/sfKDD+0mDlT4k83w?=
 =?us-ascii?Q?CnwrJtExTYhE397S4zAN7xGO4Qwzno4y5SQwFhWwkgvOrG52CVM1SWNGyaOY?=
 =?us-ascii?Q?SxizA1t7NMHqYDb86192wXsds7CESZgtaROxGq0c5dmi2eEng2Um5Xji5eGG?=
 =?us-ascii?Q?FMgwtjPVyoTMhb6leRf42Addyy3/hRfb1MQeZHgxuTbkpIymK30ZWD+ueQz2?=
 =?us-ascii?Q?6mrFnmvAGmGreGhQzsTd45FVNwdiwcHJjXHXWicSQiAuGGeM6soaJSznVsq+?=
 =?us-ascii?Q?MOdz5Ha3yz7CQPjE0Xz3xCmPMkhf9jnmLOyBU2/malpvBVckcPmpY0NRRmNo?=
 =?us-ascii?Q?OsRPK22bKVF5uOql/YfKhLYObg5mnwO0BK95qoN48x7n4Bak2zsgq1HqPEXN?=
 =?us-ascii?Q?e2ZiqpTXjWoElClZUdUpGhgeYV9yAGGyZ/87rgLHYXlPLhivL5/LM+AAMx2j?=
 =?us-ascii?Q?Km9J7gUE3CzUyjXLEyQYiCpVCUqMszs/u1YCbzq/STU63zJ+PTqV5FrhCrr1?=
 =?us-ascii?Q?azK/PBfFcjvdYssLUngyEqRpMwinoa1MYPz3Fm4dJmHOrxUsmVdTMNc8kXJR?=
 =?us-ascii?Q?kSgJOaJ9lNEbv7zRTYJ2FKkSFdLOXF4BepLfIaRvos9w8sXTrDGCSbQBSWmo?=
 =?us-ascii?Q?cN6syKF3yVgzJG5hUExhEwfCeB0s7N+jhWuU+kXoE+w4blQkPoOO763pqmQW?=
 =?us-ascii?Q?4dZcRCRc6BB71AqRORzD0LtrRzC8ez+dJNBY3uVJ7x/KBAWEJSeeG5oNHEQd?=
 =?us-ascii?Q?A0c3DEmvuNsQHh8OmjwWp2yaz/+WT2uOSNqQTxdDa6SfXWwDX+ZP6NZkiRN4?=
 =?us-ascii?Q?dqeX1cm/Y9dBoPiT++EeAqoutwAJg0cax0CfWwKZf4BYpWL+XYtIFCALyZkC?=
 =?us-ascii?Q?24kPUTlf9YsC38ftjq/ymHWi+j0FKfu9aNGdVvlnv5gVWRptgd1pO+1H8mQN?=
 =?us-ascii?Q?x5VsrevDo9LBVYEzhmQIgD1ChgS8HC0RxA3YhpDVDizWaxceoD06o/+JT8VX?=
 =?us-ascii?Q?XzerdtHCEypgsOIUk5DxwoS+XajEo55lHbUiJMqTKpkgxplIP3EGY9MnbFFX?=
 =?us-ascii?Q?MZ577KZaABFgWCdKZWRzFLCzsbM9vnptWxs1/1I/mFJS7WFXpvedzouhP/zh?=
 =?us-ascii?Q?UMZSmxigLjQy9IqMEEVpbPsVS6ZSYY6ujM+LecK3QKoe7WxzQwI4JnYDwk5V?=
 =?us-ascii?Q?qjbdcatAvmVzr7U0mY9HVOXQ6GEHQmaWhpjwT9W3zf3l4lzXa1UjmcRTBlQ1?=
 =?us-ascii?Q?eKxqeRw0MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee053d41-3f84-4a5f-bcc7-08da29898931
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:39:51.4718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J062gZLRlhhRRdM+8ncgS0PQhpAt9PDYDzx0CBdL8AAXcpr5m2TAX92X8BzmRWLq50zifPl22p0IRImwTg3qFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, April 29, 2022 02:54
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gao, Likun <Likun.Gao@a=
md.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add GMC 11.0 Support

From: Likun Gao <Likun.Gao@amd.com>

Enable GMC 11.0 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index fceaef64485d..35598193dc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -47,6 +47,7 @@
 #include "jpeg_v2_5.h"
 #include "smuio_v9_0.h"
 #include "gmc_v10_0.h"
+#include "gmc_v11_0.h"
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
@@ -1513,6 +1514,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct =
amdgpu_device *adev)
        case IP_VERSION(10, 3, 7):
                amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
                break;
+       case IP_VERSION(11, 0, 0):
+               amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
+               break;
        default:
                dev_err(adev->dev,
                        "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
--
2.35.1


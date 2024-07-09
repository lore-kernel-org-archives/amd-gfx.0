Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846FC3DA45
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 02:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5917410E15A;
	Tue,  9 Jul 2024 02:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qipsuqXb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F042D10E15A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 02:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfxOZQGLLeu+FHTN0r5gnnqppO1sNIF5+2ObJHPed94PihstJmrRKy2CoIoE9uVMZgno7VsaixefeJVBNJEGMKN1kfVaS8Igpk7dvnMWjVA3eKKrz4WF5smltqJdFQu6WjlXE1x7qNxQWfXxf/OXaq3FgeYpzBrcfoxjcn3E9Ys3vnu067eGnVobbY7sSyljxj9Dgj7grQ2qTL3aJFjUXhTg3aJQ8Pt35H8y3AWMLwPsF0FEzB6oSPmIKeTV4iYltULkABhXYaKzIBOPufcMZ4tAEmEDYCGiyFMwTWrCzyLmTFDCEba/h6kcFhVv29GuDJ7tr5GP/2Kd6IVV+DUF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2rU0Pu/ytelLxpbn+leQsgkGOKd5nAT4aDeORwWCxc=;
 b=CQa5SNkyDsMDO5R+1b7tBa4/vb6Wddo040E0JSxMd0WM3cH/a+QV2sWafTMD9SLMS35z0grU8Qsepet9gI8ZNOGvlcu7CTBNnZh5VBAWj0cJRtLwjMmZ7GF+pOojwfK5HYom9Kaom9kgxbWsl6ioKXXYICpsBGMa8VuhedL3q8nOvKU2ixCIBDVjz2BHYE7A5BfMNVZdNi51NuezqpVKyyIXlsunWj6HPMaMJ64xuQPZEtl7cqK+0zLwBaATcoX5EF1VsRnbAcOyViZhTmFSykHyEWNZGpTQfeyJnazNMbNpOjN9xknEN7gPzMJ1IETuUxxB7Z9MAGGI2ETdFVCUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2rU0Pu/ytelLxpbn+leQsgkGOKd5nAT4aDeORwWCxc=;
 b=qipsuqXbbepzlIe27X0sJ4GQ1anXv+AvLJ6qjNHhufew3EMOyHO1WPDjy14wSh/96+Vsmk5zVYWIZ6ch3kC/s2mb2Dc8WZ3HqAmembwJwSyNKj/0hxMa0/Nwqmev9SMG+jv6CIZWNjbxLHcIJQ0c7OtaZbkZfR5QxNVX1x2n8lI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 02:23:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:23:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wan, Gavin" <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Topic: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.
Thread-Index: AQHa0Vs5Fo+2/ibne0incjOk062TqrHtquMA
Date: Tue, 9 Jul 2024 02:23:00 +0000
Message-ID: <BN9PR12MB52579AD521AB3758251C1AC2FCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240708172024.1951-1-Gavin.Wan@amd.com>
In-Reply-To: <20240708172024.1951-1-Gavin.Wan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4e6f9470-d824-4fd6-887e-565b4ae199ed;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T02:22:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6960:EE_
x-ms-office365-filtering-correlation-id: e784a7dc-5f16-41a9-962d-08dc9fbe0db3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hnW5IrYT+TrNyShF/LPa46BjQde/HHv/UMa33umBbPp9ZIoBHwfrfYz4pkn5?=
 =?us-ascii?Q?bGi6ZchN/DhkBOtxto8U5Ic4om6zdqe5GBl9djyC/U/ZyLQYQc1Qv+w4yt2w?=
 =?us-ascii?Q?iEzsIw4LKRhX73RiapttP2onEe83asLSfY6itjG1SXtxEl8YajWUHNZO8AGH?=
 =?us-ascii?Q?0i7SiiETrEqx+h2WdH7Pn5nNFIxVgHGo812WKqMQ6LmYE+NueCKWaYLDtZr+?=
 =?us-ascii?Q?68vo6ULaBfvvHLiN7ktNMgdDDaGdLXpYQoq3EbCEex++GVZRZB+lMHq/P+iO?=
 =?us-ascii?Q?SXvE9AQdFY4NQwfU1b112bcxtRvso4haX2qQSAz4XLsUG/hkurs/eNAejSWa?=
 =?us-ascii?Q?wuVmjwOUAuIS27pp6hKNFmbyCcjEPxsCYmFDlMb3doET9Hopc7YfkvEgOaSM?=
 =?us-ascii?Q?q4kQdrwBcniCg63XYhp9F19obtWhofVAYvkX8KgXEguxvMjSAtA0JkJEluiJ?=
 =?us-ascii?Q?MH8uSx04WuBTw3stguWkSNkKI2EWYAtEU+Gq6EKmzM0tAPZu0JE6SgcRNd7n?=
 =?us-ascii?Q?VFlVIyWPNfNryTc06qeRKtmDyh9ZSyXTS2ifX1aNHFIMqMxsMnfELOpc6/1m?=
 =?us-ascii?Q?Jr8RBEM+Oz6wMAAXb6fCd3suMyE7s3ZYOoPbPCUvfYywUQLW/All9ZbZgNRq?=
 =?us-ascii?Q?0XX4Zot3nuNEBE9asrM1ASqGcAL2vrxH0dXRjBKQteDabEPWjm6TGZxt0sPq?=
 =?us-ascii?Q?z4Gc0adoAqRA2RE+UlE2nVtpY/LxPtNbC5ZDYmEsVAM7uZv89PqfS1irQVTV?=
 =?us-ascii?Q?CImp43VhsQgOJasxbQtEXXuGWvOM6lDMS8wfjdBJuB48uMb5X+oJjKjXkFqk?=
 =?us-ascii?Q?WvuybYZor+ubaefI9M9fkMM7A9v1Y/BPeoPlsqxGd4aPCzgOZjXZ/olKFme0?=
 =?us-ascii?Q?3hB2Q7hmo0lyc4U09YOzqpvzPf+wQl3kCyH0qn6gtuKIeQnqu9zXoYjLL6EU?=
 =?us-ascii?Q?qSYM+RV00JPBqCMkj9D3xNfrpDnA1kBbYdC0DNBEoiZBetMJV845vkYh1yKk?=
 =?us-ascii?Q?qxTnX3MFi5PHseZyCL5AD7aJ04+ItsUPrDxHJwKSRIv/Zil8Kr0IaHquVFse?=
 =?us-ascii?Q?6G03Mm9bDIBrgWoRK+LLTqUlzUJM5e6cfhAnw801b9OgX8mZIGf1nBi65Rym?=
 =?us-ascii?Q?Lpty15Ydr904rqeQ/0xlznmyW/ZMLag/huQXcEYqvakajCNwc6KIHCTcsx2f?=
 =?us-ascii?Q?KCYvnHijTHXsbxGt9KrDrzVbH/YCwZBFC4sRp9HY1XJXX/TrMEdjvTuQz32B?=
 =?us-ascii?Q?ZyH815sM5U1JXNmUYWNX1DWsbf25FANRZQpQHY/O2x7KaNG+jUNGA8Ir+V6N?=
 =?us-ascii?Q?gp0vboJ0M5nJrfscdPeUvf3jj1oyKVzmDHmGgEA3Y7AtnBwRfEWfTgJFuuLj?=
 =?us-ascii?Q?Fm9NLbUvW9E0AWub0vmF9HyzKPivcW/LypggwqIRqet1PUuzpw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7vj0rUq77u3kw3o9gP/MyVB67pt8XfasSGhPfcj99K7g8XcDJ3SJ+hj+N6dt?=
 =?us-ascii?Q?K4bxLAqMIQKyPBge+gi4xwtCRGcQPzV3YHVj06biXptDGT2QqyxF7y6D2Tah?=
 =?us-ascii?Q?FsOuP8m78y+PQqk+xoZGsm1rCcqN3xdymLOYIArxY3u8S1UzXEtL8dx8iONc?=
 =?us-ascii?Q?l2H4mx7a3TmsdpLyzQ4mFUtZ0M8xVb+d/LtIr6NI0QPl2iAnqYQG9fOtzAzE?=
 =?us-ascii?Q?n8Bk9yFxjOw4EGKsdELeK8mTPk/1PHG9UXQwKn8L325D6HX3FMwBHXJ9grFm?=
 =?us-ascii?Q?rGZCdjMnEQQaJ1u96rKZWhjZpbCwpBmvNsKm3/2dkxoZsozCHCcvG8v8VX0z?=
 =?us-ascii?Q?NqE7lshBKHDNx46FhLGb2oS704HYJ/Z36kmlSYq4mz4D7h/I7I2ygJc/7t+J?=
 =?us-ascii?Q?daKT4WDTcLdM0WehfGZZM6dTh4nUtinpdw+xz5o4ooXErW/nwg+txedl+bPb?=
 =?us-ascii?Q?07nDpviCuTx3QLvrnQL1DLYx/mnip1X2ZtsoXkohb/jCw1Gpu+bM/fsyyF2/?=
 =?us-ascii?Q?qZWd9JpX3V5+Yvqd3R16XL9+uE9fGguh79Pc76BBSD8qt4vecb8lP/qf93r8?=
 =?us-ascii?Q?MoI0a8Qls7+pR8oqeZPV+kFeOxWWs5lPtg/In42RdscVCmNYisqqn7MdIlT+?=
 =?us-ascii?Q?48gn6eZ+4jZCB0gQ+sm1020anmjtKDZgoHcoFVNsBioQGuYQeXGwcEzTHH+n?=
 =?us-ascii?Q?/JSIZvoNy14Kwn3YTXDO0KebiN5jrJ3cK8amm5xX3nqh1nKPmH1hAW4tJyHx?=
 =?us-ascii?Q?QhtwFTuWy7YaVJIuQIyV0JfjyCFHXSo9PojkbWrW9LhhVvYpX4V4TtYW26Bp?=
 =?us-ascii?Q?dvrQnKr4ZgJZi8SwRT/0tUE89GJS7rkpMvRCnDP5Qf+tl+84bB6t6CHYh7W0?=
 =?us-ascii?Q?RQlU8ikAEFVx8WXu6RBjXiD3+F7bY43pHKU0PXzeFH8t5oQi4ttGzVgvcLCv?=
 =?us-ascii?Q?9qUBOiR/FKDD/F2hhAEMqXE5xLHzEojJsw9fHPdvI1CRS0oGjSzyqJXqvvUo?=
 =?us-ascii?Q?0lRh+xsMGzsycD5m+zwm9iaN6RA9lCCoIuzyIb1U6YO2GIC/zukJkCDGcbzG?=
 =?us-ascii?Q?XW5UmxO91nt6iCLTmFnyz2xkg4Pl2K6paSMAjwO7EjZIfkgcNelnsOn16Tv4?=
 =?us-ascii?Q?iX5NZ3hsiDzDCHp+pLxLfd099hY9yvudaKi1FHFmmEtmloxlKqJ802dXTsZK?=
 =?us-ascii?Q?CrIxBv8znzKsAEP7wxR0FxUwQRQqM3aHLr4lZz6Ux15ZZ5+UNMgZftw9ynoI?=
 =?us-ascii?Q?HJykHPu8XUG5EezHj5mkRAqYDmN1QUNkZ+6d6Q+6ep5xa2OELaV/kQage1H5?=
 =?us-ascii?Q?FnKMUA7FO1qQJDP4eoaOUaregK9OBQQmMIgGkSPTgCusf1Nd61h7WhVj2oum?=
 =?us-ascii?Q?p+LB40/z5KI25iDUrLJ0myiTIX7F8j+dyLC5Evj2/ivy9l2DmhULQU0Smcuu?=
 =?us-ascii?Q?Mis8PXkREhtF1WVMcxMCQMkLkMQKw5rDK3xVZJ0lRUFcQ6M3sKIE+fUdEJA3?=
 =?us-ascii?Q?xJTCHZ9HNMXJxb+g4raoki67/NMQn07CJqWxZ2qnB5em5PHRmEg5BZuLPFEL?=
 =?us-ascii?Q?d7tXhylnu1lwPPGfQyvA4oc/0pu/OKTaGCb4dQKo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e784a7dc-5f16-41a9-962d-08dc9fbe0db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 02:23:00.1680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoxkObjg6L0exieJgon5nH1i3m11yE9m8kNWDPGbPquGDzcBGHTxufVrX2wKPVCKIfJm+NplfiTxm+O5xr8MJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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

Please correct the typo in description
CLIENTID_SDMA2 and CLIENTID_SDMA2

With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wa=
n
Sent: Tuesday, July 9, 2024 01:20
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix SDMA IRQ client ID <-> req mapping.

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3. For Even numbere=
d vfs, the sdma2 & sdma3 (irq srouce id
CLIENTID_SDMA2 and CLIENTID_SDMA2) shoud map to irq seq 0 & 1.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Ie850114932ca98ea3c9176370dde5dd393ddf7e7
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..4516cb0b3ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
        }
 }

-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev,
+unsigned client_id)
 {
        switch (client_id) {
        case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
        case SOC15_IH_CLIENTID_SDMA1:
                return 1;
        case SOC15_IH_CLIENTID_SDMA2:
-               return 2;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 0;
+               else
+                       return 2;
        case SOC15_IH_CLIENTID_SDMA3:
-               return 3;
+               if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
+                       return 1;
+               else
+                       return 3;
        default:
                return -EINVAL;
        }
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu=
_device *adev,
        uint32_t instance, i;

        DRM_DEBUG("IH: SDMA trap\n");
-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);

        /* Client id gives the SDMA instance in AID. To know the exact SDMA
         * instance, interrupt entry gives the node id which corresponds to=
 the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amd=
gpu_device *adev,
        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
                goto out;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                goto out;

@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struc=
t amdgpu_device *adev,

        DRM_ERROR("Illegal instruction in SDMA command stream\n");

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0)
                return 0;

@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_d=
evice *adev,
        struct amdgpu_task_info task_info;
        u64 addr;

-       instance =3D sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+       instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
        if (instance < 0 || instance >=3D adev->sdma.num_instances) {
                dev_err(adev->dev, "sdma instance invalid %d\n", instance);
                return -EINVAL;
--
2.40.1


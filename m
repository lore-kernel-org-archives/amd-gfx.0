Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9B3C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 08:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4F310E08D;
	Thu, 21 Dec 2023 08:35:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675CF10E08D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 08:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRVlsAdcXZ4NxghvWnipNJPpuOdDgQnmpuwbhXE0Y7h+lPX7/lscPlDlOmtUGDQGThZZEDeEOE0aX7QhrtJcrvdjpouvSZg/xoY6nhrvbbz2yeMm47dnmRlyjYuTsHnlojnvmsWm2TIKuAfqdxrDGklN23U3qWZHZ8uXA96oaueWZzhoS9u8M+8RmTgGJtqfyrEiWLZKqt6DnIlF9rTFMhoDZf05wMz1c6di6dw9zPKore0+shp+nvOctuUyUlneedqOH/M6LCREwnAWLYSF+VtiWRMZYvKs19xD+g4tZtTy1/SKoqvlxLRMTEd0BPQaVe96EowGmo0hLOdw6d0kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1SCfr50kvU2Z5ZL7GK4wAr+BFomqc1Ql9WmRPHn0z0=;
 b=g4N38boefy1/s6ZgR+cZAk95QRc+45s3KqW5noGQ7zySicg9RpUOprUtqyOCp8CFbgnkH5N+HcUSqIgryk0YjI0uzQJxDB6uTK/GNjfAjcNDqCAizRijTTcxUWBHRkFVs4tejnIUziEBgCcHnBmml0+Ktdk4TYo7UaN64cBQSYZYZZF8inGWE3XnTcFs4dW3Bo/zTimPx9Gd09Il22W6EiIR6dd5eIJmamcjH66LmGf6Qn8vT2uHUB2QGAU3aHFpymom7jJXpxafUV0mRDvXoX4322dkA1Vr2h7oqscLxninrAcqVUeghHSbUJvTIoBb/6aIRJhFHizyQxbuHnBXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1SCfr50kvU2Z5ZL7GK4wAr+BFomqc1Ql9WmRPHn0z0=;
 b=daTqeRJNhymDBatSWZZhjgXARKlTyG5kaltvMA3ec46KKN/OqohVBUA8b4O+AVyL1aYsjZbtEmYA3yiVoKYRsqe3gnpBSX/qYU/EENhAPKpC5uYCYQrSztYgdihhKw2WPC2y/30/TwoPcy42qoe/aKzjbmFHEHPlmw3HKhqfh/s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 08:35:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 08:35:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Topic: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable
 unpaired
Thread-Index: AQHaM9PFfcRmjV8B4kqm0OChsCkH0bCzaURQ
Date: Thu, 21 Dec 2023 08:35:19 +0000
Message-ID: <BN9PR12MB52579AB56E0711282D195EB7FC95A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231221060521.529095-1-Stanley.Yang@amd.com>
In-Reply-To: <20231221060521.529095-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2fcd0fbb-56e3-4a89-b9b5-b4e6aef629b3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-21T08:34:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7952:EE_
x-ms-office365-filtering-correlation-id: 24fe9d8b-e002-4918-5fa4-08dc01ffc418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHM7+P46pHzIsVDO8uCHEzCPjOzOSrlM/x4PrgK11yo1DMMNUX0FwVloF4MO0h9WaxZlFuECY9sCccsQ6QM19mf6L/NZjWwTC3M1elVNxS/fZZFPUQLwzVE5KQx53z8cJkmaBj6pNrOBlZUU3zYnB9ZWTZuJEsQGk7LOFUkcVRyBQriDY51w2WvSy3cUzpx1jhMfxcPE9xLbZLmU9bYH6FErMcKnPoCjM+SXzCEwA2dUbfIql4c8EWbmAjrjxzSqjIpf5ELLE3S7aDJzI6OhN2Jda604/SPCb7Ho5pzZ7LYtXdji33bJfURnKDUDhZAG2YuqMxrrKNaWd/cuI9tN4bZHAkpkAadF73MKwzQS9VMxp/ZK/7iGlyjxYvvnfpZiDwUlzcTZkim8RWzOfPK95VkRgx7CYwy15q2rzOYidKJplWInAZcUA2ZZ8KLpXXioR21vvya8Rak0h09cJkQx4YzAur4k7gtG/0gYR0b06UyXOSDjIieOsUi4B2ZtDAzfV+LlXwuolyAFCwQYJmpfgakGjenlzHjQJaeLr8LRKTv3L9Uv3yvr3TVHaW0K8jWnzm3xr7tIbPLA9Q3cw3JR96TRBqtXX/udIhXHeEgyoB5c/jYsjcm49hU2suKJlawMgfHQzHk5k9n6lmqcW6OF2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(122000001)(7696005)(26005)(71200400001)(6506007)(53546011)(9686003)(5660300002)(4326008)(66556008)(8676002)(110136005)(8936002)(41300700001)(66476007)(64756008)(66946007)(52536014)(316002)(66446008)(76116006)(478600001)(38100700002)(38070700009)(33656002)(86362001)(2906002)(55016003)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U/rDed9d+Fj+K7RHqxDaTs1XyeVU5nxOemV18ktxRvDiut4422Z1efssYbIZ?=
 =?us-ascii?Q?SSDYVV6L6Htyn7q966PktFQYzvmgVxzazIJ59IdN4O5eIvsU4hiXWYg4ol2B?=
 =?us-ascii?Q?lxNjIeo0IpgWkW9floLS9PQ5TCmv8g0Lgsb9cSkykdzLDcYqo2UHSfnOO9fp?=
 =?us-ascii?Q?LdDRTsbRyfYguVcKjhFz1cCER+ycKVqx9XcwjkvHM2TPY00EhQYWh0k0VGWu?=
 =?us-ascii?Q?USHXhoe/aKsSGj9t8jsLycGL0UGxa5Ktu1sjfDdGe0budDn/nO/8fqI0bqS1?=
 =?us-ascii?Q?Yg2Xgpks2S5/2bZ21BZP6p6bisrTkUNCKHfgQs9wfJKYpFv3UyFvW1d3s1eZ?=
 =?us-ascii?Q?YV3P43RTz8/sKCHzkM1B3wmKdlt3ewfK/HMxIAtv0Cq3LEV+YU/5bGykpCOJ?=
 =?us-ascii?Q?aXRkkOEZOfRKdQQUBg4k1wSyNZyJBqust8keUQHlXDwwBvESUXZhjo37hsz7?=
 =?us-ascii?Q?qSitJhqFccT+2s0Kt+UD7XI0uD+ka59J3iCdbZ3aWcwfUH6cQGHGhPRs1g5G?=
 =?us-ascii?Q?uInglsnfcO45lR+Nj3xCRf6whplsrvX/fDh/ZqdpQiFGhQXzOJMs1F+EtZka?=
 =?us-ascii?Q?e7ZuSOfttf1Onw/ZAcrHdic4q7e0GditGzojJy5gn4qHn+FE8tDomzPxWT8/?=
 =?us-ascii?Q?l0Rv5fuky7AHovvlAHyX183wcuW9SXW7MhwoQzTmLCrxOw++Nzblg73g5cVa?=
 =?us-ascii?Q?y75pROTk4L/x/ZhWBgXErkRNPlHT4/eIH6xnHTnixBRfkX5GdUVZkTaBr/Jc?=
 =?us-ascii?Q?4S3H15NMYSxJo2FZiaAs4T9COwE7lROdFm+7qnNCmk2s/Rzwfk6xQEac4GaE?=
 =?us-ascii?Q?5Fwr7OCucFYqrxdFInT2OL/hEvRmD1VwfiDGVfnQML7naMXFJ2P96E4gaZrR?=
 =?us-ascii?Q?qhXBZzamaUlmEf+g5gJ/sw/GrENddCKBTqrltmfSkJJA47ClvkkcJUh0MokF?=
 =?us-ascii?Q?+BGJnV+qwvWU2BjnpYuo3NeTHTaPyvIBuXWOZNzZu92Oz1wGDUMZkOMzw1fP?=
 =?us-ascii?Q?miPxyG3XUm+OdYWwoyJ4DcLkNTbhTC3YAbQ0Q+OEOlMV8Igdpa+zcFs1SIp2?=
 =?us-ascii?Q?d5usiJksZ8r5OvS6CPUvq2/mThz6s0RP59qdj2KuNrtl7ojzlJhY+e2KBu76?=
 =?us-ascii?Q?PSlxCav6/01w5EcRvtQ6E3QvNI3xjuDu1l2QJehqQSNyVR2UwiIKlwCbY/9h?=
 =?us-ascii?Q?dQTkKHbVkDww4/mPxjeRlArF/w9vl5hk0ZPpVcZ7cPduKkRRkJhpLknfIqMJ?=
 =?us-ascii?Q?/PcUelQn5DXvjzoNvY/5ql+Vwj9g4PFHymtsumi5XYGvd0FocTi/tBMCsd8t?=
 =?us-ascii?Q?wgIE3PFaq+x1aaOfviu36+r5lBKfbJjNRhIGPs1vd5WjDz9jV6b0IY0729Dj?=
 =?us-ascii?Q?hkYMjnvxgIsEttOLjvc2y6FgAbKbDG6AsW8x57svt4ba60YtBrLqaK0PH7km?=
 =?us-ascii?Q?0oKTW1eBzkknRT+/Y4y34kO8GzQIiziwhy37TdfoP9ZvB0/C3MENRgb0w9bt?=
 =?us-ascii?Q?doj1PM0m3IV1Lz6WC4M15sbnC4sNJinnVNz0YELKKaNQE+1pxF33b0nZl7gB?=
 =?us-ascii?Q?sg4QEVqRccYt+dPy/os=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe9d8b-e002-4918-5fa4-08dc01ffc418
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:35:19.7813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OTFWemGCplxgrF7GRUteJQhG20RGG5FK559LugdpwSivK+AVoaM2eezACI1qfLlHeaZylkUQxj8Ume8jSvMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Feel free to drop the check as below since amdgpu_xxx_ras_late_init applies=
 the check for interrupt enablement.
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__SDMA)
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__GFX)

Apart from that, the change is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, December 21, 2023 14:05
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review V3 1/1] drm/amdgpu: Fix ecc irq enable/disable unpai=
red

The ecc_irq is disabled while GPU mode2 reset suspending process, but not b=
e enabled during GPU mode2 reset resume process.

Changed from V1:
        only do sdma/gfx ras_late_init in aldebaran_mode2_restore_ip
        delete amdgpu_ras_late_resume function

Changed from V2:
        check umc ras supported before put ecc_irq

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 28 +++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++++  drivers/gpu/drm/amd/amdgpu/=
gmc_v11_0.c |  5 +++++  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 02f4c6f9d4f6..b60a3c1bd0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -330,6 +330,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,  {
        struct list_head *reset_device_list =3D reset_context->reset_device=
_list;
        struct amdgpu_device *tmp_adev =3D NULL;
+       struct amdgpu_ras *con;
        int r;

        if (reset_device_list =3D=3D NULL)
@@ -355,7 +356,32 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_=
control *reset_ctl,
                 */
                amdgpu_register_gpu_instance(tmp_adev);

-               /* Resume RAS */
+               /* Resume RAS, ecc_irq */
+               con =3D amdgpu_ras_get_context(tmp_adev);
+               if (!amdgpu_sriov_vf(tmp_adev) && con) {
+                       if (tmp_adev->sdma.ras &&
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__SDMA) &&
+                               tmp_adev->sdma.ras->ras_block.ras_late_init=
) {
+                               r =3D tmp_adev->sdma.ras->ras_block.ras_lat=
e_init(tmp_adev,
+                                               &tmp_adev->sdma.ras->ras_bl=
ock.ras_comm);
+                               if (r) {
+                                       dev_err(tmp_adev->dev, "SDMA failed=
 to execute ras_late_init! ret:%d\n", r);
+                                       goto end;
+                               }
+                       }
+
+                       if (tmp_adev->gfx.ras &&
+                               amdgpu_ras_is_supported(tmp_adev, AMDGPU_RA=
S_BLOCK__GFX) &&
+                               tmp_adev->gfx.ras->ras_block.ras_late_init)=
 {
+                               r =3D tmp_adev->gfx.ras->ras_block.ras_late=
_init(tmp_adev,
+                                               &tmp_adev->gfx.ras->ras_blo=
ck.ras_comm);
+                               if (r) {
+                                       dev_err(tmp_adev->dev, "GFX failed =
to execute ras_late_init! ret:%d\n", r);
+                                       goto end;
+                               }
+                       }
+               }
+
                amdgpu_ras_resume(tmp_adev);

                /* Update PSP FW topology after reset */ diff --git a/drive=
rs/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 09cbca596bb5..4048539205cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1043,6 +1043,10 @@ static int gmc_v10_0_hw_fini(void *handle)

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

+       if (adev->gmc.ecc_irq.funcs &&
+               amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 416f3e4f0438..e1ca5a599971 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -941,6 +941,11 @@ static int gmc_v11_0_hw_fini(void *handle)
        }

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+
+       if (adev->gmc.ecc_irq.funcs &&
+               amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        gmc_v11_0_gart_disable(adev);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 205db28a9803..f00e5c8c79b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2388,6 +2388,10 @@ static int gmc_v9_0_hw_fini(void *handle)

        amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

+       if (adev->gmc.ecc_irq.funcs &&
+               amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+               amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+
        return 0;
 }

--
2.25.1


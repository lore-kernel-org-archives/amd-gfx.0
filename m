Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00CFC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762588949C;
	Tue, 14 Jul 2026 13:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idgOl9Om";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A852E8949C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKFV4cSQehlxMFZiNO4+fwwcmZpQZvZcoLuxIpvgDpJBq8rBaiD9VN1sBMfowbAQRVf0DGM/eJVJJdaPIad/l7l0teeLvH2oBXM+OTYzVuTfaUrU4hL627/owwOhMvxXD+1M7jmdEPRuR0wXGS6ThMO2gGRLWKIh94XV69aHmLL0NUHBGCkZWu1cJoton5Ox6ZO5oOGS2XwhTpNZ41XUpRUsMDyKL1yvum0t28LaRdJILn0hhYUppKX4OOcSIpABYOai6YdORqRuMUc4u45NJV7mxDbIRrsa41p4WbaLavtH7UfgiPFDdQshpjbpH+rgloac7EEEv25YPMf/qyXNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUgB3neKRHlQV1mINYhV4EFg8LYJjSQ3txW9DKAkv4U=;
 b=SMSw0kMNZi4bukkV1QSJMI8YAa/kN/KwgbznKhKYjlu8OB7uaQH2MzhSzV/+Y3hHyO8LU/Vd3od6MZ5zES0ADctQcFLFoTGgWAv75C+MPkec8B6j2+FG0IXD/DO2FoHDIqe3oGO2FtDoGkDgW4XPCF7ZKCwKCz9+W974xv9+C6bggWm2B4EGadgIFooeZaLaoZvwwIhlS0HDZ+ui47QQ/iVts31ev7w57PP9Nz0LKtHbLsmw0NXsfTgJ496yV2xI4HP5cfynnAR9ivAMzF/zqpKy3WF+jten3h9pWWB25uPZEe7/t4uNHrE2Mj10K3o9riQVXe5NJBg5fmm61AnmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUgB3neKRHlQV1mINYhV4EFg8LYJjSQ3txW9DKAkv4U=;
 b=idgOl9OmFkMiYWqGvjTmkJfiogXZcDQRCZcScf/q1jKHjLm5T1kg4LEJH7gvEXlQ4C6OoYxYXPJAtbk7xQ/Qbc2ew/ZX1ICjPlchboTKqGlySJmDcDTPMZzXy4DGuRiDUlO+f0ZDDUYCcU34hKRQUvMVY8cxdnOvOVDa+AZjdwo=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:29:35 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 13:29:35 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Topic: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Index: AQHdE42vEkR1uv4U8k6AvpLW/sil1rZtAEKAgAACIYA=
Date: Tue, 14 Jul 2026 13:29:35 +0000
Message-ID: <CY5PR12MB63451F054537A84F4A1E53EBFAF92@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260714123721.105472-1-xiang.liu@amd.com>
 <BN9PR12MB525756EA24FB966923ECEEC4FCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525756EA24FB966923ECEEC4FCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:29:34.730Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|LV8PR12MB9715:EE_
x-ms-office365-filtering-correlation-id: 9f387030-3b00-4579-51cf-08dee1abf23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|8096899003|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info: 3BjXkpYtsLNbgUAmRMZjYVlbP4h2FFo7ipJFUxLIIzpXna72kKATr1sCySzllmIRm8pUWqXN2/Woipzo9phvQ+6kKKZHeUGojjpj0awDEyfcbqSrfogA+xbRC0FbXzTM5RXdCRPvZ1C0KQ78F0BdNgcMNlItncpc9FkaXoINQWigdnkDdBBSihHick1wvhJ1Vni7NufoJBu0Fd835Yf/htMrZI1qRP+7/Ue925FK7xCTuSns0PxBmkOBu9AXroizuZM4oOIgjrz+AeGeh0WbH2t8WMYab+Vs2XLQufBLYHnSdt6lXBIefau20ktoBD2oBvOKpgCP/HjxnIeJ/fjEj7lbMcLg+pRZ5XhOIGcsUQEGiVLw6X3jW58/Nfn059mK0OKSzNL28hmhCW/J4RJWcWYGX6C5agsxWwsRTWfU3xiKO1Bb30cRgNoxJWBceNFKZH4j/EjyMNAnfGTtQTzmo/e1XO0MXCTLW24VarniwZzn1hQlBE5XtnstYEZoj2UX8B+H68RTHvEP3dpEldBAUtHwz2e04NUy5sckYz7Ngv7nowqcmbjG3IllrEZjA9QEiDi0t81hbodxz0NR5rPTwIcfYoTSyCuX/kvnVuc6/xAt2HKsc6VwtodBZc6PwwFlkd2rZegHyoNAxuJb+gMmgYeCM2imrrpp3eCQE6PLsN285xnqTCvCfmbVOAkEwWxzrcS2WK9To9ix8eZQZKiBnNwjCd5cZa9rS9WXUxDrbfQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(8096899003)(38070700021)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wMwNrC1WRLn2EQAeegL25HnE84ewKK84uR8NQc+RGwTSBRIZsNyxUNcTO7JE?=
 =?us-ascii?Q?dKkHiAMMf2Aaz3T8WhHoG71IsUyE4U4QbiIMWxWZMsHVtvBzKYVxyeDE+hf6?=
 =?us-ascii?Q?LSltX4qK/aVADLSrEvOUr6XtbDzD6RRvqvdU9yVTJeF6OiVbjBw4aWbl4O01?=
 =?us-ascii?Q?HfCaEcllAPUcTRaS4IR4yrbVdMiz19UfvwsvKrySaVWIUbdj5IpK5NwpbfUr?=
 =?us-ascii?Q?3ocgwk6Zldduqma9qAmza7D7kcC/KcUy6BWXNCnlHhcKHT4ZfMuDsUrwvmUF?=
 =?us-ascii?Q?Z937COM5BYKZCwxYQenwS8nmpKt7b0gqAp9NGcPixPm4T4Zf7QxYKBEKD2CI?=
 =?us-ascii?Q?snsGgDzdTQmPSjSORRwaTWlBi6V0fxx2aANiw+ihB3778a4pSEk6dLPC81JH?=
 =?us-ascii?Q?xN0h0eHCILkJz4bhHcvOIZvi4+1kfFVoI8z/YPBtEY0rbPQnZ87HOiBUJyOX?=
 =?us-ascii?Q?J7Q1Vmm07Zt6Nyudfw1XjzrL0pdiFTLfR2QaGNiRBwQ/kjhIf4j0eJsplAD8?=
 =?us-ascii?Q?HjueyOtXqLjYTh+ZPZDbA9LMQGHHuqsfUijegCrLwL8AX/TEoDypdBX29Qlo?=
 =?us-ascii?Q?nEqbrERr+G6HdaGGLsJ0dCFtgRwVPGjDu3RDvteu8wUI6xFkkpX3eQmkXUur?=
 =?us-ascii?Q?lEW2RctbUN6mEwpRpj7aoHo92PRSd3FtCbOPB4yUoiI3marVD3afdXs3TE9l?=
 =?us-ascii?Q?EcVs9a3s7jIEPKqyBLqiKXVzP0gj93lDfvip6xpjtUA1ZYg2gqnQ3y45/sL8?=
 =?us-ascii?Q?7HOQCesNxNEfOee1QapCDgTqdwJyG8eTlfr4jAzWHUmtXkqxOHWx93AWkqU4?=
 =?us-ascii?Q?xmkcvTIDtehmKSzSooiiMpINy+O88kvHYlMe6Tt3NSnsCecqOFjOIyGpSHAF?=
 =?us-ascii?Q?XbIGv22mf64ppVVRBuBBE6ePtEAxpYhN3YypcaA81UrKwbghE+uKvthuAZ86?=
 =?us-ascii?Q?Ltv6Vlyph1HV7NUVQSo1pQhs865SBzhn7rv3UboueGs1OBxsUtjNRHRE0GKw?=
 =?us-ascii?Q?uBl70hyIHHEq560/z53NshMv+0kbNcamC7nwtJexeGUfmghr0y1J0TI9Fp2+?=
 =?us-ascii?Q?wljx88Uqs5i4EV8sFjTgH0mBbhQOtjZhEe9JEmP//SfbJQkdz3NiEI9rbqSO?=
 =?us-ascii?Q?zaqdr0X30ASzPVnIT22GjaXiBu78/phzFK3bKgvNAsO20z8kQk77P8DeY0Pu?=
 =?us-ascii?Q?x5yDqX8MvhujzjzuSJpVd8vATc8aKuQsItiGEZkHo8wgSVW3zZH8hpAKIScr?=
 =?us-ascii?Q?/mSvwsXkmMuafZ0v4dO5m1WoegV6BB/MTlgaOYh5S+pw6XpUkiZiRUX0vY9B?=
 =?us-ascii?Q?hhaGfsYAKsxNE/YVSJcxw/ItzAcP6T85flPcqKhdzkqA5E8jU9ikAWBGPFOR?=
 =?us-ascii?Q?i7AImcBrFGkCIzBjxojRn4StlvnUIUmE+plUCuoulMqQCq4UN1rySyajcgLX?=
 =?us-ascii?Q?DX1UWmZxsfeAYjL1hlAv+ekhF7cDzUKjeMatz/XG6SysQmMgYUw1g0EHJUWj?=
 =?us-ascii?Q?ejmAhX0zmfANcVcrypTAne3/IwfzS5IFIWvXYi3iFhWpVmhZRz6LsVysrDMX?=
 =?us-ascii?Q?G/KEVqgRkqPCT/SYxr+1a79R1QoGQk9zfNsBh9JzlCfjiWGTreP0kabBfrb8?=
 =?us-ascii?Q?VSVglqf4CJJcmDqmzjJhS/BtOHk/QIVJBhMns3dL/U894pbBY2xIWx2eTq/a?=
 =?us-ascii?Q?A8suFT5xeag1aLyOAjqzSuQ1cmOEMuOCR7g1YXQq3GgRB+XR?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63451F054537A84F4A1E53EBFAF92CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f387030-3b00-4579-51cf-08dee1abf23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 13:29:35.2528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DdHiHSW6yWvAwHCzo9qsp9i+iWDekxrMmkYPf/TTPC1e8nAqqpbuESC5/wQdPJTq1jJzLj/+XAwz4h8T5VjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

--_000_CY5PR12MB63451F054537A84F4A1E53EBFAF92CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Sure, thanks.

Best Regards,

Liu, Xiang

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, July 14, 2026 9:21 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, X=
iang(Dean) <Xiang.Liu@amd.com>
Subject: RE: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on in=
it

AMD General

+#if defined(CONFIG_DEBUG_FS)
+       if (adev_to_drm(adev)->primary->debugfs_root)
+               amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf);
+ #endif

Feel free to remove the #if defined protection when committing the change, =
since it is already handled within amdgpu_debugfs_ring_init.

With above fixed, the change is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Tuesday, July 14, 2026 8:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init

The XGMI reset-on-init path can run while the device is still at the minima=
l init level, such as during an NPS memory partition switch. In that flow t=
he normal RAS IP block hw_init is skipped, so unified RAS is not enabled wh=
en the early CPER initialization is attempted, leaving CPER disabled for th=
e rest of the device's lifetime.

Resume RAS after the XGMI reset-on-init completes. Once the RAS manager res=
ume succeeds, the RAS resume wrapper performs deferred CPER initialization,=
 keeping the path a no-op for devices where CPER was already initialized.

Keep the deferred CPER retry and its debugfs registration together in the C=
PER helper. The normal debugfs ring walk skips the CPER ring until CPER is =
enabled, so the ring debugfs entry is created either by the deferred helper=
 when debugfs is already available or by the normal debugfs walk.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    | 19 +++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 ++
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 10 ++++++++--
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  2 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    |  5 ++++-
6 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 6fb129025761..0af8b7be326e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
         return 0;
}

+int amdgpu_cper_deferred_init(struct amdgpu_device *adev) {
+       int r;
+
+       if (adev->cper.enabled)
+               return 0;
+
+       r =3D amdgpu_cper_init(adev);
+       if (r || !adev->cper.enabled)
+               return r;
+
+#if defined(CONFIG_DEBUG_FS)
+       if (adev_to_drm(adev)->primary->debugfs_root)
+               amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf); #endi=
f
+
+       return 0;
+}
+
int amdgpu_cper_fini(struct amdgpu_device *adev)  {
         if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.h
index d12c98077d9d..eea30be91b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgp=
u_device *adev);  void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
                         void *src, int count);
int amdgpu_cper_init(struct amdgpu_device *adev);
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev);
int amdgpu_cper_fini(struct amdgpu_device *adev);

#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 3d1ede5f8de2..fd349eed820f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

                 if (!ring)
                         continue;
+               if (ring =3D=3D &adev->cper.ring_buf && !adev->cper.enabled=
)
+                       continue;

                 amdgpu_debugfs_ring_init(adev, ring);
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 0eb440e4ca1a..8bf3fd015a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5002,7 +5002,13 @@ void amdgpu_ras_post_reset(struct amdgpu_device *ade=
v,
         }
}

-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
{
-       amdgpu_ras_mgr_resume_after_reset(adev);
+       int r;
+
+       r =3D amdgpu_ras_mgr_resume_after_reset(adev);
+       if (r)
+               return r;
+
+       return amdgpu_cper_deferred_init(adev);
}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 23bff7a0f35b..c53f911d5729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -980,5 +980,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
                                           struct list_head *device_list);
void amdgpu_ras_post_reset(struct amdgpu_device *adev,
                                           struct list_head *device_list);
-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index b265b68e0f37..87cefa1e22bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1399,7 +1399,10 @@ static void amdgpu_xgmi_reset_on_init_work(struct wo=
rk_struct *work)
                  * no-op for any other reset path where RAS is already
                  * initialized, and for non-uniras devices.
                  */
-               amdgpu_ras_resume_after_reset(tmp_adev);
+               r =3D amdgpu_ras_resume_after_reset(tmp_adev);
+               if (r)
+                       dev_err(tmp_adev->dev,
+                               "failed to resume RAS after XGMI reset-on-i=
nit\n");
         }
}

--
2.34.1


--_000_CY5PR12MB63451F054537A84F4A1E53EBFAF92CY5PR12MB6345namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Calibri, He=
lvetica, sans-serif; font-size: 11pt; color: black;">
Sure, thanks.</div>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 14, 2026 9:21 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.=
Yang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Lazar, Lijo &lt=
;Lijo.Lazar@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v3] drm/amd/ras: initialize CPER after XGMI rese=
t on init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Calibri" size=3D"2"><span style=
=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>
</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#if=
 defined(CONFIG_DEBUG_FS)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev_to_drm(adev)-&gt;primary-&gt;deb=
ugfs_root)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_debugfs_ring_init(adev, &amp;adev-&gt;cper.ring_buf);
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ #e=
ndif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Feel=
 free to remove the #if defined protection when committing the change, sinc=
e it is already handled within amdgpu_debugfs_ring_init.</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">With=
 above fixed, the change is</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Xi=
ang Liu<br>
Sent: Tuesday, July 14, 2026 8:37 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Liu, Xiang(=
Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Subject: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
XGMI reset-on-init path can run while the device is still at the minimal in=
it level, such as during an NPS memory partition switch. In that flow the n=
ormal RAS IP block hw_init is skipped,
 so unified RAS is not enabled when the early CPER initialization is attemp=
ted, leaving CPER disabled for the rest of the device's lifetime.</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Resu=
me RAS after the XGMI reset-on-init completes. Once the RAS manager resume =
succeeds, the RAS resume wrapper performs deferred CPER initialization, kee=
ping the path a no-op for devices where
 CPER was already initialized.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Keep=
 the deferred CPER retry and its debugfs registration together in the CPER =
helper. The normal debugfs ring walk skips the CPER ring until CPER is enab=
led, so the ring debugfs entry is created
 either by the deferred helper when debugfs is already available or by the =
normal debugfs walk.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_cper.c&nbsp;&nbsp;&nbsp; | 19 +++++++++++++++=
++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_cper.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |&nbsp; 2 ++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++++++++--=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++++-</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">6 fi=
les changed, 35 insertions(+), 4 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6fb129025761..0af8b7be326e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_cper_deferred_init(struct amdgpu_device *adev) {</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cper.enabled)</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cper_init(adev);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r || !adev-&gt;cper.enabled)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#if=
 defined(CONFIG_DEBUG_FS)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev_to_drm(adev)-&gt;primary-&gt;deb=
ugfs_root)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_debugfs_ring_init(adev, &amp;adev-&gt;cper.ring_buf); #endif<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">int =
amdgpu_cper_fini(struct amdgpu_device *adev)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x d12c98077d9d..eea30be91b47 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_de=
vice *adev);&nbsp; void amdgpu_cper_ring_write(struct amdgpu_ring *ring,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *src=
, int count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">int =
amdgpu_cper_init(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_cper_deferred_init(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">int =
amdgpu_cper_fini(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">#end=
if</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 3d1ede5f8de2..fd349eed820f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!ring)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ring =3D=3D &amp;adev-&gt;cper.ring_buf &amp;&amp; !adev-&gt;cpe=
r.enabled)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_debugfs_ring_init(adev, ring);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 0eb440e4ca1a..8bf3fd015a45 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
5002,7 +5002,13 @@ void amdgpu_ras_post_reset(struct amdgpu_device *adev,</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">{</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_mgr_resume_after_reset(adev);<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_mgr_resume_after_reset(a=
dev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_cper_deferred_init(adev);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 23bff7a0f35b..c53f911d5729 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
980,5 +980,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">void=
 amdgpu_ras_post_reset(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">#end=
if</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x b265b68e0f37..87cefa1e22bd 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1399,7 +1399,10 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_s=
truct *work)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * no-op for any other reset path where RAS is alrea=
dy</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * initialized, and for non-uniras devices.</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_resume_after_reset(tmp_adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; r =3D amdgpu_ras_resume_after_reset(tmp_adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(tmp_adev-&gt=
;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed to resume RAS after XGMI reset-on-=
init\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63451F054537A84F4A1E53EBFAF92CY5PR12MB6345namp_--

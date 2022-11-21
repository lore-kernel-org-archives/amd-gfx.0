Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB527C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2654910E113;
	Mon, 21 Nov 2022 02:26:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB97010E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJDoFxCrQhouCC9rwR0i8FZGJTSeP7AWn2Eii3wvOE1YSzU6DuEmG0RlbAjW5oMpskkHb0NBw1Wlhc7Tiq882/ts3/fwmulY/p0UG5kRTrwpnIWhKIh9hON6lUfFb8QcB3M+ynHQHzqoqQcGhVO0uqzI0Nq8CwnPuNolmgKR9gu9ZCSDctdsK+ws7VaChtS7QsUkb1VverxCQxH14DBb/6sQyf/N88vWDPtyl7EmjfeRtLuUL7GZ4KVKB1DvBaoIt64HWWb6jQLvfRsKtLoXaThEvnbhTLWimjR/CBg8wODKFIKcCk5FhBsohrkbkHZ7e0JEzxUNxrkY65TjnsLl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kejfiKw0+YkO5KwleC0Yw483LBPcCO2OldGosKjFug=;
 b=MwlbLM3doGyhAZj6KqmKUF8Z5thmOeq3LXXs+dMkzMdPbaH+nj8H1eSPi6D3dnhCt5n2RR9i3FvaQCW8R32vkREoI7amMKKFhmytSxI0BCzCGriW4LL1uAfDJ+o+O/lTl3Kbcjh1OmL6UdOrplTCCH3qizfB6Qw7S1OGW7FTIRGPN4jT66Zg0VAt8+dP7u0Yb2KxhRDuA5VOd28XUNJo1lKOI9Gv/V1kPWFPMYfBzZGAc3CpNvRZv2NQF2Tu+xWvDBAcZLr6UczC7rBY5+8DuEEfGSQyK4FpOI3FdrBvBkD6KgnhmH6OVrKiwrFyfyegdFJGYmV2ogYP6ycWLLwdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kejfiKw0+YkO5KwleC0Yw483LBPcCO2OldGosKjFug=;
 b=kJoEHGp5CHXskeNLAvr+sz2o/jf0MjUg91gVG4+rFzlMJKmr2GkT/4R+aNSIte0YzBqsuyYySfBUC+y2Ou3S2Dt2N5HxehjNKo1/XMQGFhRHfNz88+UTMX+o8PbQ/371OJ8PIt6yAb+MoR87TYaK1A4kbezXzx3cV8MepylSjok=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 02:26:29 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3959:cdff:85bc:f148]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3959:cdff:85bc:f148%4]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 02:26:26 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag
Thread-Index: AQHY/UGvHVCN6kbBEkqaRMC0JPuQCa5IplVf
Date: Mon, 21 Nov 2022 02:26:26 +0000
Message-ID: <BYAPR12MB4614CF63A50968A29AB037A3970A9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20221121003858.3296035-1-guchun.chen@amd.com>
In-Reply-To: <20221121003858.3296035-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:24:46.6738656Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SJ0PR12MB7067:EE_
x-ms-office365-filtering-correlation-id: 5f0022f3-dd33-455c-cd08-08dacb67ca9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /75RfxqcYum2erF4azUmLA4poUO4A+LNIfaojKh5qWIxRMowucZcmaoFRAhihK2m3y3HK8cxW8lU5litT8rfZf3mV3jlBSY24ZLTnATNnSKP7mm1yVv1unEsxSqQxW44R+WWvZkbe9E4Ts9D1hjmWYyBiaf7VqJaRkMw0lX897hdmlrMhWpiI89NLet/+fVZr4gjgleOo4tWF7aGqe/xQKW3+f/PScd24bkRg5aFZuyHkHeZaWeOj3Kj3eXSycVAawMzF8lRREFN5cNZe3bL7qjC2j+RGKJrbijx9FRwsJ+UTD+4Fc3WEDkIn4muXjV6YAeVc1WnJfL4U903M34ZK6cOxckZnYxRlKSulaXoWVdliAbD+HbZRCrx9XJQ6EjUQCkwIuf9gNaONei2gb8AOMOKA6Tof2dmFaiyhI/fibzWbvBt6Fn/hcD/KjUjYF2qBnxMf94D25dg39iaA+62pN+Tkuh8qjLNlHUa5UfvU6p3goWocWtAbsOfwPgrvM0ydEERinRv7nv7LM2lNef0gKflMQ7+qmfCiwgsvpfVAsoEpgclIEf6a3BF7AByyRIQ5hZEfqFdGO+Me3tQr9/Urd9VOdq0uvsf3ik7CB5l5t45m2mA4B+XLCb+bsIX2Vd1WupdBLX5FZ9Ls56tEkCBuvJT/wlkZ1NDxHT9oAPEQxD6BeCOD/+q9bQkKxtuWGnv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(41300700001)(76116006)(8936002)(52536014)(91956017)(6636002)(316002)(66946007)(66446008)(5660300002)(64756008)(8676002)(66556008)(4326008)(66476007)(478600001)(71200400001)(55016003)(86362001)(6506007)(83380400001)(38070700005)(26005)(110136005)(2906002)(33656002)(7696005)(9686003)(186003)(122000001)(38100700002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xAb31nijgduRj6qkGLKuw9Fcf3AlgdRUAGX+j0vLSCYnXHfkkVuAgHExxqSh?=
 =?us-ascii?Q?K6BDCknovG8wQg83fIJ7+GkkET5gYUNcjK8Y9/LT/VzxTiT2Pr2MUAtmPkLW?=
 =?us-ascii?Q?Fuu6G/9iJYTxVzZDx09iFk8zgprPTCsNc+qDzMgk2nrHcOumzTHm8eT2LV10?=
 =?us-ascii?Q?5fKHPWMV7ReGKrJhiA7jfQgrPf9HgJbzVSOOyVMJ+n2P5KxXXZXp5jSV8yWw?=
 =?us-ascii?Q?aIxLirN3BrLjeX+3JweXWosgyg4vcbWMaLqOJgjzYI2LOuhffRuVjALAwVUi?=
 =?us-ascii?Q?tTG/djPmEOgCHRixbAN1JfiaH1lfKz56IYD1Z/KFOEA8maSLVMGI4Ds+rSPW?=
 =?us-ascii?Q?XX8wI64UhIsALUESfIWXBOV0dpR8fg8EykyFaALJkKELF6EpHLh3lbJN4HWb?=
 =?us-ascii?Q?kri2myKnUuMYHOTCIo56mwq3g/sT0IHmXLznXxqvyTbpO19Hhdg2T+tVU0bl?=
 =?us-ascii?Q?2kNj+PbwPtdDXRcHXB4kDMZNnLTLT8sfh+OUYREdNXygHp87PjU4mjpW8ZkE?=
 =?us-ascii?Q?fkn/PO4gXw0aZBYdNZ4aUJFyXDjZ4u5wRnQfo7IKGE36SBqOxVrg3G7AAmpU?=
 =?us-ascii?Q?pf/ucQDQipHygIMavGoOWx6OmS8sjZmX46Qrq38AwkvSRqH35UfNCxRL1fEt?=
 =?us-ascii?Q?SiRl6aIowwk95sZr0n8qza7Geb57kD+OpkDZ6bC3Y6WzCzEh5oc4oOirt8M6?=
 =?us-ascii?Q?5PR+BpCW1CW5Ci2rUE78jb80v9tVmppPu+XZsUVcyjBgQGrhKOKDrnf6lgLx?=
 =?us-ascii?Q?JUZN+Kw4GhajV4BPLtCLhLM9BzAY+z7z2a7kIgUH/gtO1CvxPARCmbl7GzjC?=
 =?us-ascii?Q?TUhrEpGTsB35TL4vHWHwY/M5IEIvJoFIoyerzeLl4j+hXrPjnAZbTjnHeNep?=
 =?us-ascii?Q?Lgkx0Kd59oOBjKWrkfFHiW/pbau4+Bj37SMa7LDY3U9UuPWMMYI6qFbGKEnN?=
 =?us-ascii?Q?np0Zu+v01KlB7d+LSAnUB7eF2s6lzji/TK4PhFx75hKHG9EVAMQJpK/zDWx7?=
 =?us-ascii?Q?MkxYXo+uZVjTOp18VD0UDkiYyktJXTA372hlZwdIpbPZN6AI+CKA5CwOXLaH?=
 =?us-ascii?Q?l2eU5C+/DzEqHUHcqaCfBfyl+Z4L76u3FfpRrSkTRKx8yL0NUwZGvI3pM8LE?=
 =?us-ascii?Q?Xq3fYloIC9468vqWRihpgEShb2UEkHsZp2ryIPF0oapDalvXRverFe8/mKPE?=
 =?us-ascii?Q?ULL73auIwuSdzq/sHcXIxyf25p8zvuG0G+zkytH4mi9UpH6C5leCfygP8+Rz?=
 =?us-ascii?Q?pYDMGgBhzp7le7JEY29ZiGXYtw8eBoR3sOtAN8h+FP0RjnTTTLOnpapbynvW?=
 =?us-ascii?Q?Eebbq6bsjqnOnv3mEgwlv3TphZNT6Jhb1xTGQatdcoPRupUFibm+v/AHM03x?=
 =?us-ascii?Q?NDXkWCLgL/2JwOw5VBC42V5yYHEa/ZKt07htCj6DhhT+qk++dij2HNZDyKyg?=
 =?us-ascii?Q?cDjNhZpdLxxQfZm7D2jpPzGlYRgroimHh8cwwr5Lr4UVYB6e7qzBfBgTgD6j?=
 =?us-ascii?Q?LGsxy89ZVM8pvo9YST7HqgLWSzOxFKC/1KmdN9W0JgKRUz1ujzLxfklb2YqF?=
 =?us-ascii?Q?EZsWjhac5qAWZ+Hy2vN8E7MjRzimtpmu3JO+rZU+?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614CF63A50968A29AB037A3970A9BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0022f3-dd33-455c-cd08-08dacb67ca9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:26:26.7599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGeSDvqsOA1v0LFffZ6URf/W8JPPt6srHgMqqsXeWr+xuHEA2cJaWCsUgJFpyq2z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614CF63A50968A29AB037A3970A9BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Runtime PM can be disabled with a module param. BACO state is supported for=
 non-RPM use cases also like regular suspend or a reset. Relying on RPM mod=
e for BACO state is not the right thing to do.

Thanks,
Lijo
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, November 21, 2022 6:08:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag

Driver was not calling BACO exit at all in runtime pm
resume, and it caused the timing issue leading to a PCI
AER error, as once system enters BACO, it's not reliable
to check runtime pm mode by talking to SMU. So use rpm_mode
instead as a general pm mode check to ensure driver executes
BACO exit in runtime pm resume.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_=
device_capability()")

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 25 +++++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ab8f970b2849..40af21040b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5619,7 +5619,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
         struct amdgpu_device *adev =3D drm_to_adev(dev);
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

-       if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_BACO)
                 return -ENOTSUPP;

         if (ras && adev->ras_enabled &&
@@ -5635,7 +5635,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
         int ret =3D 0;

-       if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_BACO)
                 return -ENOTSUPP;

         ret =3D amdgpu_dpm_baco_exit(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..be03f7b1cee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2532,7 +2532,7 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)
         }

         adev->in_runpm =3D true;
-       if (amdgpu_device_supports_px(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;

         /*
@@ -2542,21 +2542,21 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
          * platforms.
          * TODO: this may be also needed for PX capable platform.
          */
-       if (amdgpu_device_supports_boco(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                 adev->mp1_state =3D PP_MP1_STATE_UNLOAD;

         ret =3D amdgpu_device_suspend(drm_dev, false);
         if (ret) {
                 adev->in_runpm =3D false;
-               if (amdgpu_device_supports_boco(drm_dev))
+               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                         adev->mp1_state =3D PP_MP1_STATE_NONE;
                 return ret;
         }

-       if (amdgpu_device_supports_boco(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
                 adev->mp1_state =3D PP_MP1_STATE_NONE;

-       if (amdgpu_device_supports_px(drm_dev)) {
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
                 /* Only need to handle PCI state in the driver for ATPX
                  * PCI core handles it for _PR3.
                  */
@@ -2565,9 +2565,9 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)
                 pci_ignore_hotplug(pdev);
                 pci_set_power_state(pdev, PCI_D3cold);
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_O=
FF;
-       } else if (amdgpu_device_supports_boco(drm_dev)) {
+       } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
                 /* nothing to do */
-       } else if (amdgpu_device_supports_baco(drm_dev)) {
+       } else {
                 amdgpu_device_baco_enter(drm_dev);
         }

@@ -2588,7 +2588,7 @@ static int amdgpu_pmops_runtime_resume(struct device =
*dev)
         if (!pci_device_is_present(adev->pdev))
                 adev->no_hw_access =3D true;

-       if (amdgpu_device_supports_px(drm_dev)) {
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;

                 /* Only need to handle PCI state in the driver for ATPX
@@ -2600,22 +2600,23 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
                 if (ret)
                         return ret;
                 pci_set_master(pdev);
-       } else if (amdgpu_device_supports_boco(drm_dev)) {
+       } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
                 /* Only need to handle PCI state in the driver for ATPX
                  * PCI core handles it for _PR3.
                  */
                 pci_set_master(pdev);
-       } else if (amdgpu_device_supports_baco(drm_dev)) {
+       } else {
                 amdgpu_device_baco_exit(drm_dev);
         }
+
         ret =3D amdgpu_device_resume(drm_dev, false);
         if (ret) {
-               if (amdgpu_device_supports_px(drm_dev))
+               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                         pci_disable_device(pdev);
                 return ret;
         }

-       if (amdgpu_device_supports_px(drm_dev))
+       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                 drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
         adev->in_runpm =3D false;
         return 0;
--
2.25.1


--_000_BYAPR12MB4614CF63A50968A29AB037A3970A9BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Runtime PM can be disabled with a module param. BACO state is supported for=
 non-RPM use cases also like regular suspend or a reset. Relying on RPM mod=
e for BACO state is not the right thing to do.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, November 21, 2022 6:08:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan,=
 Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check fl=
ag</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Driver was not calling BACO exit at all in runtime=
 pm<br>
resume, and it caused the timing issue leading to a PCI<br>
AER error, as once system enters BACO, it's not reliable<br>
to check runtime pm mode by talking to SMU. So use rpm_mode<br>
instead as a general pm mode check to ensure driver executes<br>
BACO exit in runtime pm resume.<br>
<br>
Fixes: 8795e182b02d (&quot;PCI/portdrv: Don't disable AER reporting in get_=
port_device_capability()&quot;)<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; | 25 ++++++=
+++++-----------<br>
&nbsp;2 files changed, 15 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index ab8f970b2849..40af21040b47 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5619,7 +5619,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(adev=
_to_drm(adev)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode !=3D AMDGPU_=
RUNPM_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; adev-&g=
t;ras_enabled &amp;&amp;<br>
@@ -5635,7 +5635,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(adev=
_to_drm(adev)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode !=3D AMDGPU_=
RUNPM_BACO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_baco_ex=
it(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 3c9fecdd6b2f..be03f7b1cee1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2532,7 +2532,7 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_runpm =3D true=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_px(drm_dev=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_PX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev-&gt;switch_power_state =3D DRM_SWITCH_POWER_C=
HANGING;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -2542,21 +2542,21 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * platforms.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: this may be =
also needed for PX capable platform.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_boco(drm_d=
ev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_BOCO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mp1_state =3D PP_MP1_STATE_UNLOAD;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_device_susp=
end(drm_dev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_runpm =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_device_supports_boco(drm_dev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;mp1_state =3D PP_MP1_STATE_NONE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_boco(drm_d=
ev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_BOCO)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mp1_state =3D PP_MP1_STATE_NONE;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_px(drm_dev=
)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_PX) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Only need to handle PCI state in the driver for AT=
PX<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * PCI core handles it for _PR3.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -2565,9 +2565,9 @@ static int amdgpu_pmops_runtime_suspend(struct device=
 *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_ignore_hotplug(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_set_power_state(pdev, PCI_D3cold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev-&gt;switch_power_state =3D DRM_SWITCH_POWER_D=
YNAMIC_OFF;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_supports_boc=
o(drm_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;pm.rpm_mode =3D=
=3D AMDGPU_RUNPM_BOCO) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* nothing to do */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_supports_bac=
o(drm_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_enter(drm_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -2588,7 +2588,7 @@ static int amdgpu_pmops_runtime_resume(struct device =
*dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pci_device_is_present=
(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;no_hw_access =3D true;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_px(drm_dev=
)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_PX) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev-&gt;switch_power_state =3D DRM_SWITCH_POWER_C=
HANGING;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Only need to handle PCI state in the driver for AT=
PX<br>
@@ -2600,22 +2600,23 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_set_master(pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_supports_boc=
o(drm_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;pm.rpm_mode =3D=
=3D AMDGPU_RUNPM_BOCO) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Only need to handle PCI state in the driver for AT=
PX<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * PCI core handles it for _PR3.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_set_master(pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_device_supports_bac=
o(drm_dev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_baco_exit(drm_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_device_resu=
me(drm_dev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_device_supports_px(drm_dev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_d=
isable_device(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports_px(drm_dev=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode =3D=3D AMDGP=
U_RUNPM_PX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev-&gt;switch_power_state =3D DRM_SWITCH_POWER_O=
N;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_runpm =3D fals=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB4614CF63A50968A29AB037A3970A9BYAPR12MB4614namp_--

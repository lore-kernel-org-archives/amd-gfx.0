Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0087C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 05:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2971410E326;
	Fri, 17 Dec 2021 05:52:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7D610E30F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 05:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFtKehzKRkdrFGKiWyyJu8uONgE8DB+D82DhYcSsI+S69lRSYcM9Vl85EdjTqHf22Qw0fE4LD4VAVkcf/Y/w72dGBJgjt2vULP92vR7LLoEkcCTKMshbEaJW7VeCZGFPY+AVlPEti8Nrt+ykzjOTlaAyHT/ymFlP//sNLBz/2wWqf02Q3HzRjFlW2lDa+qIqp4sxRS4QTNrODvzAQrqVUkhFdqcU7Qrlaz9Q258sthLAr2ZbY2ujK5pRaBKrCPEPWklIl6KdbFUDoHkngX3zj5UshtBMtdVY+frylSOvKqjhwKiN108jaDfUKUTOazerAGeWIVcfU4BbSclXChOdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3GiLIaEty6ZmKQpyBQVkb8ua3tdXVa4YaJ6SdU3qfo=;
 b=LNQAhYY/+TeDrrkrjaeI/xy2fnNgttvcUPPd8tBRgNQgEMGTP/EnaJSCLnLfUP195P2MKlT8Y8iCzD+JyHmpXX8fuyqoLsbyX7w/sIAnxBTIULlX6dy2Z01BGdCpc4PCy5Zf422hTmuhh2iCC/OiZnWX1SJkbLmFEdd1gPWn1fIK/H7X0M7o+8tVDJuggjL7/EfgeJETc5HZJ95GnrVP7y8g1YmUF+SB3WjDpL9C/fn+cY80lf1nFT4aQsZGJ1eFrDyx5YN6uZOxAEuuqqVYA1rB7gapXc2+JsggPnuAKkXg6jkK1d5+v1P2Fr+qwPD84047Wo168WAIy4ruqKo5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3GiLIaEty6ZmKQpyBQVkb8ua3tdXVa4YaJ6SdU3qfo=;
 b=BW8fnzaxi+ui7W4dkv4+ZZ7edx0vsk8udKsY+oMVbl0QaaVChuIKVgLBMSXAVvc/gL1tlTqcnWRd1Yad+z8R2STJRFhmxRlIf+u3xxgYvlZjeM6oxGnyx0D9v1OfsFRkNRgoi5tM0Vq6i3u8XX8QC86KxBnN0+OZnWdQP5qdjwY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 17 Dec 2021 05:52:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.016; Fri, 17 Dec 2021
 05:52:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
 is unplugged to prevent crash in GPU initialization failure
Thread-Topic: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
 is unplugged to prevent crash in GPU initialization failure
Thread-Index: AQHX8u16LT2SnDZ1CUCd67Z4HJPHyaw2LlyQ
Date: Fri, 17 Dec 2021 05:52:12 +0000
Message-ID: <DM5PR12MB2469731F212937651FF20334F1789@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
In-Reply-To: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-17T05:51:32Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0f08b987-4a57-4cba-89d2-34f4ed1d97bb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-17T05:52:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3c1d8f29-0f64-4a46-8122-2a7c25c277a3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d29d8be6-3ffd-4472-7f0c-08d9c1215f24
x-ms-traffictypediagnostic: DM6PR12MB3177:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3177000B7FE61702CDD66774F1789@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2raks8w8eoa4iTHrzqKGlFFDZD2AKqeXyti/BrbV6yyG5twNz5g5z/CIo+8R4+gkMLJ35IwNz8mia7uQW8aXZdfPAmvCzAcHgMv9r7uXCv3oNtxqqhEzTdq37sv/ywQUUevJBWBcx0jplsLIDESOLXhzY5ypoU/MTYU5rFesJx2n1OnOzCDO/IxzctHRHJp6/cEkMx/1E/KfG8eKsgkMECElxur2+FO139O+S/hxKVGPTvucasvPUEARzMk7u4T+WASBcfHvImENQCyOO5Y0oSE5Qq26jn4Xzr1TOHZKDgEPL/TuMZhXvJdeDgU0g73zVT3wljtqTMA/ovgVdFLW65uSDxaCvFr07yoXYAN/qJxC3icVMU1AEnnSpYmdBi5MTJ1FS9yb3oekSKAOZCJyHdNxIPsFfsO2kcPo6Bx8fEVZwBMIpEOAtozLPfeqNWk9zt+qmc+t5LQC8axjGmFCNmYWiXyGYvdPUDVbMFD/P5ZwOauwcP/B6IjjdHu5nCcd3YwWAg7Ezab9mLFmlB5WocQkfSmOTBVQFmnICecVgEzQSzj9qjADA0Vcim1QoJiUbC/CdSvSmQrwHzJBQua88IDCcWep19LlQ5DiVO7gdHxQMOLTtclNkB9lbp5t685+izeorJi5FWAp5y+zgsFy7DIu3ohwklBU6lKvko5gEC9krbbqzWeO2vinqx3fESoTg56CJG8MJ4/daCRKiQBYdHfmNEhAXb9GwJY4uBnKmQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(110136005)(53546011)(122000001)(71200400001)(5660300002)(86362001)(83380400001)(6506007)(316002)(2906002)(66476007)(55016003)(508600001)(38100700002)(8936002)(64756008)(38070700005)(9686003)(7696005)(66946007)(33656002)(921005)(66446008)(26005)(76116006)(186003)(8676002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlN+Mgo2QnqlXGgUgirB8uO/pLtMB15Kfq5IPoAz7h+FdLnTASFKR2m7qwwv?=
 =?us-ascii?Q?o+n4sGvzME4rp2aFUffycdJ/ErTqeqFep9FtopNa14hNGraTLgE+XK1Y/DQ7?=
 =?us-ascii?Q?Nv1YrnrFe7pgK1HMUjNAkgCcwWTyTLFfeQYZ9qG0HAgevFdLgiWIoCcUMgCE?=
 =?us-ascii?Q?EEly0IuZKQZYYhHe/PhJpn0zih0D7v6QaMpfYDkhOJIOkbAh3mLdcQmTh7OC?=
 =?us-ascii?Q?kqW1U3BMuZq6neTlYg1M2rF7YFlxloJnX9aW+eJ6MvoFyonnHHnZRPMQsvOb?=
 =?us-ascii?Q?mH4/FjfMxovZ02RQnYjofqpq0tw5CWtWf7aR32PRVfn6vjWymjxvXYlRNdgv?=
 =?us-ascii?Q?+mDi4Uptt0KlVgNIgMcX3XxMsZ1wpuR1kW8TKA1w/2mCvZ2m/syP1esUzxb6?=
 =?us-ascii?Q?iGM/OJsmhXdgsnouEDdnUXF+I13T1MjNz0ENesM077+YjsH3RTWGr52tesfH?=
 =?us-ascii?Q?bxrTwionu1vyHhjNIhfmF0GMlb4wl2vm93VWxR0jAL3YfPBBX6SI3XdO/fIM?=
 =?us-ascii?Q?DI/qbEJEweOQU/aTUcTRs1uuqHVIIjeXfHDxj9TR44z7LVpog2563ih233cK?=
 =?us-ascii?Q?NcLyXce6b0LoVa/1aD05xPbHMP9XRp3bPE8JAyM2IhbDtZRVUDZmqs/WF8jN?=
 =?us-ascii?Q?Cbx9Quj3vr0kpiKPXYXVhFn/R5GI549VCo3t7yqoDaVpMlVc6yqf/vkAE7DF?=
 =?us-ascii?Q?bLUWJdnNQ6Mu/P6S1ecZEfIA6QYZOMRqSl+eLe4z0AsbtrHq0eO46zFx40uM?=
 =?us-ascii?Q?rRbAV/YlSRu2VpDsBCCHT+7udF2fg3m/7GACBBrsxOPn7Ls+Q1U8Qsog6ogs?=
 =?us-ascii?Q?qKJ0U/RZuzXkHwMfuUlhq6ClMR8jTPzY0Xs4X+0QylRVeT8n04ANB07gMfms?=
 =?us-ascii?Q?F6zVxi7Gs91QX5s/0tQInF38rV391oecloJ/5uLlST3L1a4slo/omGmj+lEE?=
 =?us-ascii?Q?gMKMa3rRg9auTRSzmwL2KjtOAxJpiZ0ybkhj7p7JGM9baG1lLO7xdCoJ8aWJ?=
 =?us-ascii?Q?EbTFV9F73Sa5EakqTF4Pzk5ob6jjl2gHp8PfESYjLBPR1k1Pa6hKtBG47wDB?=
 =?us-ascii?Q?mamoDADVipQZ/3v2WCTXYif4Ah0rLibvRACzIKXGAHwZWH3dj+klTAHYKgQT?=
 =?us-ascii?Q?KejtxeE1kjL87a5iYXXUyKwWiXUpoSiiiNfWgmeGFGX1CKYne8KX7sN9VzO8?=
 =?us-ascii?Q?JHy+Ai9aqnnX3M/GnkQ3k3cFWA8iqlLdFDddSol8mBiC35CDhMHmyLidiNZp?=
 =?us-ascii?Q?Z8WjssfL3Yya+vbnDnX15JGdZGHQ20SxRtHm4xHAHUc6AwSLmqLRtnRBR+TN?=
 =?us-ascii?Q?RfQO7VLZLWFho5uCZqVuVf/0Pm45ASPKJEZVhzms1wYhLl7p8d01S5w3i64Z?=
 =?us-ascii?Q?a+OZa6xfhprqjYV2QnN5Y+fULe9KA6Hcd4mddt5CEnj9qC3nvZO3jekIDFNA?=
 =?us-ascii?Q?PhB/mFoElIFFTPkhAjdv1VbXs5VfuP1bjc6FYZBv2TUq7aFHvTfphVo1QL0p?=
 =?us-ascii?Q?5Jc4OxPi2gXx1WPo52Ashbx0SDNxByK9ypxcIrauvHQM1jURHEYnSTruFPKs?=
 =?us-ascii?Q?nwTP/ZWHzxCvG1yB++nez9HGYRP4MJ1/MQLtK1RQDxUrBYCSVsCgI8CB/14W?=
 =?us-ascii?Q?KXm4JHHem0A/YvJl7bD+n9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29d8be6-3ffd-4472-7f0c-08d9c1215f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 05:52:12.3476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBnyK33mTKgWrTapZI8IczBGaqCQLl3/JhQ/lXsOq+uBo8SxZNiSc13I3JEB/H/uBs0wRYilNAxcc57F8oo1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com>=20
Sent: Friday, December 17, 2021 10:26 AM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
Subject: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device i=
s unplugged to prevent crash in GPU initialization failure

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during dri=
ver modprobe, it will start the error handle path immediately and call into=
 amdgpu_device_unmap_mmio as well to release mapped VRAM. However, in the f=
ollowing release callback, driver stills visits the unmapped memory like vc=
n.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
call amdgpu_device_unmap_mmio() if device is unplugged to prevent invalid m=
emory address in
vcn_v3_0_sw_fini() when GPU initialization failure.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..f6a47b927cfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3899,7 +3899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
=20
 	amdgpu_gart_dummy_page_fini(adev);
=20
-	amdgpu_device_unmap_mmio(adev);
+	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+		amdgpu_device_unmap_mmio(adev);
+
 }
=20
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
--
2.25.1

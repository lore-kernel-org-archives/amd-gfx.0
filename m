Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC00C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 13:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AAF10E234;
	Tue,  9 May 2023 13:37:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7FB10E1E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 13:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn4oceCIrl7ZMhoPUtOCCQJbwJNMEQiCI462EAhX2Lf39SSaT6Q/D9t9aN+IsXLL6vgqHdQyGPdNvTtleBOv4G872goyJRMCskoYwsthyhKZXcBy5y0BF6otk+4HaAPSZgQ0B/DhbG/xzbT9dwDu8bnhDzC6Q615Adwzl2SKPA4MkTYLtLSkt44SrxJBE+YpZ/xIgIxxFJ692rxkai9/6X0pNNbjTLD8YqJAbW+izt5Yp4TqSluPkHHbF2O3dNMfKqV2hOGIaDX+8JO999dPd22rab5rJzMQW30Gn5m9g79iNrDTKkNoIjiyljZXF+WOEtQqvJW0CEuvEqsJ3GQakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCSZPv6YQcUvMZswfBwUr+/FFx3IMYJCg2OxjFR1IEw=;
 b=GBVmRhuPt7bRZkV86nNHalwP1gtd9F4lvpRMu1s/5ETIJ7hcf7ZEf4tq4Ul+5r0WYBs34lsRaiyAckzIwwgBKcDjUwHH1Ow8Q62o14dzMZKzB0l1VVfmu9P2xuqoR6rjspTUNUUxeJKsQorGpMPH6G1rakOIukxNXy7gm183hzI6EzDDMRWxgpjCnM8pbwH5lJVMo7C9/hifyhLZ/Kg9IBOjDFoWMgS0yHJyLcyV/tZJd+ik6GH993VViU3EDZf2vXpzbQpLaLrYG9BHHqk4RWV1Cih+PCPpTU0VePhqiPP6kMBn6A29uOsZXN0Mxhkf0rhplI2SpBZ1GeVFTDI71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCSZPv6YQcUvMZswfBwUr+/FFx3IMYJCg2OxjFR1IEw=;
 b=spxkQLizah0KN8dQrtV2vTY25x8MkD679OC8VQvVQ/MzT6red13Hhhc6BdMyFTPyhPtlAFuFOHrkAUC+X5lQj4OtWOhAYdIWBrTr2yypT8qy47wUuQKQyULpk/QnKWnFnEFYinHSTKrWMsqJx3jEXyaesj92wBmqleOyVaP8AXw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 13:36:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:36:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip disabling fence driver src_irqs when
 device is unplugged
Thread-Topic: [PATCH] drm/amdgpu: skip disabling fence driver src_irqs when
 device is unplugged
Thread-Index: AQHZgk/X1kb+dizzOUOkpYdpp4759a9R8dTg
Date: Tue, 9 May 2023 13:36:56 +0000
Message-ID: <BL1PR12MB514466D56E0D5F59F1CE7B22F7769@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509082511.2183745-1-guchun.chen@amd.com>
In-Reply-To: <20230509082511.2183745-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-09T13:36:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a7002833-e86d-48f5-8f62-4974f9541674;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-09T13:36:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9385dcfd-a27a-4192-a889-5e999d319928
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6450:EE_
x-ms-office365-filtering-correlation-id: e231b8b8-0fd8-4861-6529-08db50927515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LXS4JXFx3IbIHXvARZ4iQOZV4ODXxiNQ8oYdB59usMOypk/4y/qMkz8o0ajplgSTKhR0EuCknFJwRmMqi45Lsdlu/kJvB/rSu4IXf1L/kf4ZAijQ8IwDNBB7Ew8S5OFKpL7B26zmAoiwTTWm6w34SkwVXbvSAo7UlZ6XSShIe1+Vi8iMhu1VHZegdqdKhEhfIKWtYi8q8okiNJ98hC52p7+LX7giDHLOvA1rPbKJ7tRiZaD0uBootTCKgjjEMc2kxjIE0VfJtgIudvBau4zAOCFo8mHdYRXp+1mW2uO+cZP97SV4hjp/TlfRwz1U4KZImaOaBYblGDdiYWoBSKy2LqUGB8wW7s60kg0ZUnYAPDaMHXQn/3xckO9LhZz8OmROiv9xoGLrFeYxqeraHm185k0ypVR/7xHiNUFtFpzxT4yeKodYaUsnSvDPFAHPsjVQ5LB23S7GEYRO3BASWujks5itoA1tyQCZp2IPYZSulQtmTTPlFH4uuZSxA1nYMpNdJAbZryCIfe6rVehvRH3zZ+dGN4LMdujHtD9D9+RuO5SFILds6AVThRrA7tcQvx/b13TyQXeEEtBs2q3eItqw/zTIZWe0oTJ4ml6XfzGqAQRFI0jP3PGwrdCgBz86Ae0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(33656002)(86362001)(122000001)(26005)(53546011)(9686003)(6506007)(186003)(38070700005)(38100700002)(83380400001)(71200400001)(110136005)(478600001)(66946007)(66476007)(7696005)(316002)(66446008)(66556008)(64756008)(6636002)(8936002)(8676002)(4326008)(52536014)(41300700001)(5660300002)(55016003)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J9NboeoxmDT1Nn0wqKge3AHCLrsBgLtWHIoAJTqGO/BrBxY/Snud/TNSZhin?=
 =?us-ascii?Q?cYISqaarq2e9ncc6flGNg77+ZMweMmX7vC60YnVwlRbh786Vmmz6JO5ZHlOy?=
 =?us-ascii?Q?Vpl041HDVm07eX8mFPWo9VBYQUK04Na+gVDrMFGMOQu+HyVbJIxVSVoTwkoM?=
 =?us-ascii?Q?i8RJI/xsMkL/scR8vQXolsP5YcYonvavEzYHLG/ke7T25LFJqUfIqUuQz18U?=
 =?us-ascii?Q?XIjbCVEmSLvS5FJGnXHHJyBP5CLs+OQYoaJVmyxfex4qVyBBXq16f+gq5lon?=
 =?us-ascii?Q?4jHkZck2XTw03OUXsaZ9ePUagdqtmqTZiXB2iR9wnIl/SgPCCZi1MtpD767Q?=
 =?us-ascii?Q?iYxO2Rar8j58+i4b52KmuU7msH9Sf6Nv2Gx2Ilu1qFqpK7Ca5rqiJWr3Ojgu?=
 =?us-ascii?Q?LJzpJI+slzHbIoFWPRTfAM9Nak57WLVpRxnoC26P5SxgNPocemwWzkWlUDLP?=
 =?us-ascii?Q?dEpps5Fevqg390hqlR12FWqykucHkoDAj1XyiosEeXPLekqbCEVBTKtNAiBP?=
 =?us-ascii?Q?jC3FxgeQhoujUkz5ssbvckWraBGOJ6NaR8MTmCiyJqrQtiz5ohlw2xWWb3zQ?=
 =?us-ascii?Q?scpnbsDZ9qjA6mczrWjhK8skHUq8nPCmfcYJLdMNt29Mmy+3G22C6gOGq8Ff?=
 =?us-ascii?Q?Zq/9dqbQ0MfignUbfMvE4n+skHsBbHAMMvEt6Br2B3RiJVwYnllHewSuBrUK?=
 =?us-ascii?Q?ngFe3vx3RFA1qZTLf2nuJxgVP+p+fpObu7tCp+oogcwmAzCQS1QgkssX/nWp?=
 =?us-ascii?Q?61EQFxtDclyePwW7l899XK0KhOYL55u4lWs2iW6p2xIiiHb3qroMIR5sJIF4?=
 =?us-ascii?Q?PphaZgL2pfaCOA3viGkuKCG5iojNicIQW50dC4MjqyQjOXkFHNA7laNUX7t5?=
 =?us-ascii?Q?T3O9sx9IQmjanUXREKoJXa4mO5TaRMv3Qm/oVm3r0k4mWcKfh1n0lmT1qBva?=
 =?us-ascii?Q?3zzheM+B8ePSUO2yZPu7+tHzdgxo1Eitxcn0DVmfj8KgzewFhnAKTL+4VTlB?=
 =?us-ascii?Q?AjgIpeNsDuNcUGbKyPMmimHSM96NbzqR5U8uQDZWuVyST9BMtmIFoVGi4CQl?=
 =?us-ascii?Q?92nC4mM/ovcPHcgc8GR23+9mwl0cDURUXEZQVJXLL1JILM2jpHRRW3Qfn5p4?=
 =?us-ascii?Q?syrFdFJMLTANSgE+K0/J8UKJ0xYp1PwuZkTXUS0SesFcVLRnL8mIMuAlTBoA?=
 =?us-ascii?Q?H52vCGfkShJaquX0B55JDBXNUWlOwHfU2Ebeu3dK4anJm4x0/IMfXHVbx0gR?=
 =?us-ascii?Q?EVR6RUAsE0Uct46F5YHScBIH/3Swhx721Bs7BxZn1IVSb46T9SqfiYNwbjKI?=
 =?us-ascii?Q?kAnzg7XgPBSSxH0esLyAGhFUnJK9Wdbt09WHx61hJN/I6O3eBDo60XOekBwk?=
 =?us-ascii?Q?rPOZ6DiaLhOKiMCO+u60lTX4HsK7FlRcBlsE7I9YCOljxMoQ4YhU77c1I46v?=
 =?us-ascii?Q?iFh2rGxI8QC2kwE17IKaiCVHAYEDFKxp+0sDdrBj3KP5upeDYFpmkgjVRgI8?=
 =?us-ascii?Q?2M88mug9/tOGmSPOttXZqCbgBp53NOgRyLrDCzh5Eu2aeEYWuZ52ViX5hkE3?=
 =?us-ascii?Q?Wi6NFTa7BxgUXNNbYz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e231b8b8-0fd8-4861-6529-08db50927515
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:36:56.2555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRDXuVNAtuGRruP5xm+RmiWYWYLrHxobiWoo4cr4Tb+97lBmZwIGoxcobAliDmiYEuS4qarOciIit8d3TXeJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Guchun Chen
> Sent: Tuesday, May 9, 2023 4:25 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: skip disabling fence driver src_irqs when
> device is unplugged
>=20
> When performing device unbind or halt, we have disabled all irqs at the v=
ery
> begining like amdgpu_pci_remove or amdgpu_device_halt. So
> amdgpu_irq_put for irqs stored in fence driver should not be called any
> more, otherwise, below calltrace will arrive.
>=20
> [  139.114088] WARNING: CPU: 2 PID: 1550 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:616
> amdgpu_irq_put+0xf6/0x110 [amdgpu] [  139.114655] Call Trace:
> [  139.114655]  <TASK>
> [  139.114657]  amdgpu_fence_driver_hw_fini+0x93/0x130 [amdgpu] [
> 139.114836]  amdgpu_device_fini_hw+0xb6/0x350 [amdgpu] [  139.114955]
> amdgpu_driver_unload_kms+0x51/0x70 [amdgpu] [  139.115075]
> amdgpu_pci_remove+0x63/0x160 [amdgpu] [  139.115193]  ?
> __pm_runtime_resume+0x64/0x90 [  139.115195]
> pci_device_remove+0x3a/0xb0 [  139.115197]  device_remove+0x43/0x70 [
> 139.115198]  device_release_driver_internal+0xbd/0x140
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 5d96f630a3aa..d0ed70f45db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -581,7 +581,8 @@ void amdgpu_fence_driver_hw_fini(struct
> amdgpu_device *adev)
>  		if (r)
>  			amdgpu_fence_driver_force_completion(ring);
>=20
> -		if (ring->fence_drv.irq_src)
> +		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
> +		    ring->fence_drv.irq_src)
>  			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>  				       ring->fence_drv.irq_type);
>=20
> --
> 2.25.1

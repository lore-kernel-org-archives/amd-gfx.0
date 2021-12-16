Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0F0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 07:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6D810E543;
	Thu, 16 Dec 2021 07:27:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCAB10E56F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 07:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge31Xe5ieU23K6R+ykhefB+X2+I8qBs/hJzActH1o5Fvx30/iAkvsxHFSrGgjnECv+D9h+xQfLAOhu5TUo/nTN+nBcOmsjzLfjbUMGunVpw8wA+OeSHCNsd5FDHB7QzKtPvJvDL+RY7ZKiHkGsKpcqogkn032uipClacRXSqwjIa87QLwszhaqnHbJwJjYU6SEAS5yKgt5ZUD8VkkHtF1ZoAns+G2au14MRBzUY1uZJoR8xpJa9/7LzP3XLgYrHSsdlEzT6JRHnht5MawEcViMuoWGcXzTcM9XmxmIOiPdViTgK5X8AqNNELSADWttpgonj5970/O5sZvVHqW/7EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7sQ1lGxbD7pqNTgJh1YWFSAZxjCT8ryv49uCeJDCf0=;
 b=Kk6aUAYlSSy6nmc+S/4IsQUAzcinIpSLt/VDbr+60B/yA2xTmOatrE5X9CvFzpbyLCxxFadMwM/p8i/K9pHtUaaMxws7A4QCE+Uyz4ZwUa2k0kClKNtxrINWu+jMWE3bykWel2bFwhRvHE3nb26JSeLcCvXPHFwnl2dhOWLZKYjDUrPG949bVDC+4ddw35tdfBONY6lhpSfe+4qf6doEaA6yBTO91WaslWf2coSRYn/obrHbyRMSuOZ2bRdkS5Y62GHyKjHsR/wzp6PbySY4HlOvMopM2eyvqzmUkvFF/La05kPsEBkt0hfGIpk7zGRunBZVedj83pMKaXFuVl5ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7sQ1lGxbD7pqNTgJh1YWFSAZxjCT8ryv49uCeJDCf0=;
 b=WgGZawFCk6LDzNvtPlZoD3r0RKuuUb+LWkH3/IRwTjBDUgwdM1JzSTsz6pc1v+BHdIenDCby8U4n4aUNBPSXXcRtK8sIZkH7p3/DKTABZUxO3wPpWcJAk5P8zILNwXuiImve42yi6YAitm2EQF3hV/iVOEdizk9bVbk9/tbhDU0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 07:27:30 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 07:27:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device
 is unplugged to prevent crash in GPU initialization failure
Thread-Topic: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff
 device is unplugged to prevent crash in GPU initialization failure
Thread-Index: AQHX8kQdcX5J8Yep0USGQsEri35C/qw0q+FQgAAEyACAAARHkA==
Date: Thu, 16 Dec 2021 07:27:30 +0000
Message-ID: <DM5PR12MB246983C6BC18ECA5EAC2F86FF1779@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
 <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CO6PR12MB545814E39E2A95074E7924CCE0779@CO6PR12MB5458.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB545814E39E2A95074E7924CCE0779@CO6PR12MB5458.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-16T06:46:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6df1ece5-3d8e-4cad-b7a2-b6205aac7b55;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-16T07:27:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: eb042e79-d395-4477-9013-d1dfb5d8a826
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55411541-9d5a-411d-131c-08d9c06584d8
x-ms-traffictypediagnostic: DM5PR12MB4680:EE_
x-microsoft-antispam-prvs: <DM5PR12MB4680B1FF3D38D0540B03FA11F1779@DM5PR12MB4680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O+h9pn2dmFgX94Q5spPD4Eg3vp3P2qshlibxZfHgAJzw1iabpzv/PlbhbJXCRt40gAVzR6JbjQp7RWLmJ6k6RLD9hDzKFd5RpyG5wFrNd0Iloch8RulMtwbyOlI4tsxrBlwUu5IuXRabcMq2k/RKwjSymmcmMbg9la4ykFkwle3ZBGBEw6sbzhyMRqCRzsiVHa/PJI2JnRhRVZFB4Cy0rVAVJI2P3yfkJz9bTQ4PuYKVdUiHRzK9hK2TX5nfeF3+E1PuQNGJaBBp+LlvH3Bch15jm4MgArDxDZnhWGHsrzQu1plDHvWQILDjlm1176SPnl1l2b93hpIDQe+QVTaU45216ux+4PwsbWG+zM6+k1T4S4rjEkDrubZ6xoHvAjDxDc8G9Nn6rd0yOSh/D10dXBNgcGQUjRYVakjGrftKiKyH78UWgakYuK1B14CY/kyvgqF0JIeygkW9b7Bm9fYs21iTd2RGIsCejzSsstmfChJe7ToiLvTjNOSKW8efVJvQcGQphwjBNXr9AWXsXKAd7iZueVvsvwbHc4faJXTPtyT+yXWKRwp6QPqHjbs2zhqn7rBIIw1EzPXw3Jg/+CbjcLFVz6aumHRew3WvCHZXLrl5aWJHw826t76I6BQ1Wi2JVYVAEs0cqctclMp8vrZ3LNvbcx2cWlKUpeeZYWTRWpLalbaISDHjko7afnYtYii2rV0W00CVj56RkoF/sq+C9Ph5O9rF4Uw12O9qFH1sSgw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(52536014)(71200400001)(83380400001)(8676002)(7696005)(9686003)(55016003)(33656002)(86362001)(921005)(38070700005)(5660300002)(53546011)(110136005)(122000001)(508600001)(6506007)(316002)(26005)(186003)(38100700002)(66556008)(66946007)(66476007)(2906002)(76116006)(64756008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lyJlhDfXhtHEfaz8/IhneWV4ihaNkK39mwmxct/23hmFI/VncxnTfqAiuw4J?=
 =?us-ascii?Q?WtFq/u34Ci3NgPyXZ70NjsQSqbe1jtu/LKfB/E4wvWv7j+oSUBK1FHLB+1y2?=
 =?us-ascii?Q?xul3/IsYUeypzu59x62V13o7YkfesrrMREm1EzUapkTZVop+jRkZsbLzHPCC?=
 =?us-ascii?Q?g9L/rikaeOYIOXqddj41YsY1TznElYAnxdZ/OcrV/mE+JamDG/i3C6gORReD?=
 =?us-ascii?Q?99MqFKLXbQ0mBXhYC61Glb/DfJG9P/BZ3fPA1BbcudQqMmfGu/ZB5N8gMVZ4?=
 =?us-ascii?Q?xNMjYMLrkVbjcgSQm7s2cJgrMt6Vwre3QzkC5V11gWkYop5PiUn+nl1M/hz6?=
 =?us-ascii?Q?nyxaB+r2jpwe0jEPjBF+El7Z7AS5vu5/mozcJpehSlhLsHtqqS5CShw56vE0?=
 =?us-ascii?Q?ePBClVpcxAAhWpP252fwCyh9+40qqNujClceiS56GnzzDlbzh7OshPOiUicI?=
 =?us-ascii?Q?bZgeDtsR7xy01NfKYq8TPhs9zrLKja6p5+EqPtimriDTZP6or+8nEucWjm7o?=
 =?us-ascii?Q?vSYKUj1NfeUl6rjgxBUqzItlSu1qZ7zdNdNTy+bmAoLjDdRCKHaZibGIvOPS?=
 =?us-ascii?Q?sAJloE5p1mJ9vQ6s10vPpPY/JJPFR8USWs2Yvj0p/57xL//+KIJFLLXMFOej?=
 =?us-ascii?Q?et0JCW28U4Gc4xwdGy+amg5aufwrijcHWllR1IsTEZ722xKkvvWlBFEKgTgY?=
 =?us-ascii?Q?a5R7EyFtYbyRoJKBHn15kQi9h4e3ZY4lLeFeEteg9XWRjMWpLs28sPIlwjzZ?=
 =?us-ascii?Q?cXhUK/jrKLEE3eMVh27y7nG9Kvkx33oE/9dIig3ixTThe/Oo+daU5CL93f3I?=
 =?us-ascii?Q?lANCdJwbj/KcQGAlkqNThnaPYrQudrl7ST0tYFzQBJSjVXf6SugSxEpINYfC?=
 =?us-ascii?Q?cNuam4Un12JfCNbnIKhV11QeVkKJNlbjlVwj/fpzCZZsaOfShTa6vVwZmaIO?=
 =?us-ascii?Q?CY+ocuuYqQKKova336Ekzq4t4/5De6Qw7AvoNa4oPPjeB6HltzVYALTfQk1h?=
 =?us-ascii?Q?f4EQnr+Ndi5EwHRzd5YFd+/dEnOglhuMe4naw0qjxc3f3X3BpPZzquWoHQWD?=
 =?us-ascii?Q?EWjJYF3sPY5Pbcwn70K2MRR+2mWvooFTKrtUqfdBe3pdzdJIWDT/LdzqLC7l?=
 =?us-ascii?Q?/osBdWpokt0XjZuhThWbsl5/4NkcnWo0vY20kZeIqTFTCfhFFDPTZlV/In75?=
 =?us-ascii?Q?X1+qThdAB78Ufx3l73kIpMc7cogEB8aIve4Ma+ET3YCi+nuR7Z6SwsOG0KNs?=
 =?us-ascii?Q?sT96VWIEMnysJ/Jcu+XKnBhIiIYjsqqc84YF2yXg/ZHWhCn0swoyMkZzJdVT?=
 =?us-ascii?Q?1MLI64QwncjDBR9ARJzslpxB8ZwgDj1XwWAKrRKfuPikF8q7OwgN8Oj4f0o6?=
 =?us-ascii?Q?Y2ie4s+jhfJk487khWlAeR9l2AbPo0/8/CDDQMoC+F3Fvlppvi4maZFifOPR?=
 =?us-ascii?Q?m3OiM8qgGuR88i+VfT0sN5KoYRPmOp364+JZMecRP3kllNDIP9wnUB2FjDfd?=
 =?us-ascii?Q?dmRLKAD2yiUoBO+cfnFiFoWGn2L+C5pyuuE2TWo/qe9krCxiFbM3A02VsVFd?=
 =?us-ascii?Q?YqIMpncfG/U1u7upIuR53W8pSgoiNJPwsiNHgbvWmo0cx+vS1sF5jwRsZaZ6?=
 =?us-ascii?Q?c1Dhs28ZbfeLudQvKUjivcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55411541-9d5a-411d-131c-08d9c06584d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 07:27:30.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sevl/O2okkb/IZHLSM78Wl7dnT2yNPo2DHEw9QWy6XU2rajLBQwwyATS7MymHNdPWhCUsAV9P3lcv2L0LG/csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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

My BAD to misunderstand this.

There are both spell typos in patch subject and body, s/iff/if.

The patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Please wait for the ack from Andrey and Christian before pushing this.

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com>=20
Sent: Thursday, December 16, 2021 3:00 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovs=
ky@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xin=
hui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@l=
ists.freedesktop.org
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff dev=
ice is unplugged to prevent crash in GPU initialization failure

[Public]

Hi Guchun,

As Andrey says, "we should not call amdgpu_device_unmap_mmio unless device =
is unplugged", I think we should call amdgpu_device_unmap_mmio() only if de=
vice is unplugged (drm_dev_enter() return false) .=20

+if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	amdgpu_device_unmap_mmio(adev);
+ else=20
# 	drm_dev_exit(idx);


Regards,
Leslie

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Thursday, December 16, 2021 2:46 PM
To: Shi, Leslie <Yuliang.Shi@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsk=
y@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinh=
ui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@li=
sts.freedesktop.org
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff dev=
ice is unplugged to prevent crash in GPU initialization failure

[Public]

Hi Leslie,

I think we need to modify it like:

+if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	amdgpu_device_unmap_mmio(adev);
+	drm_dev_exit(idx);
+}

Also you need to credit Andrey a 'suggested-by' in your patch.

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com>=20
Sent: Thursday, December 16, 2021 2:14 PM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
Subject: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device =
is unplugged to prevent crash in GPU initialization failure

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during dri=
ver modprobe, it will start the error handle path immediately and call into=
 amdgpu_device_unmap_mmio as well to release mapped VRAM. However, in the f=
ollowing release callback, driver stills visits the unmapped memory like vc=
n.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
call amdgpu_device_unmap_mmio() iff device is unplugged to prevent invalid =
memory address in
vcn_v3_0_sw_fini() when GPU initialization failure.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index fb03d75880ec..d3656e7b60c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3845,6 +3845,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_de=
vice *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)  {
+	int idx;
+
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 	if (adev->mman.initialized) {
@@ -3888,7 +3890,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ade=
v)
=20
 	amdgpu_gart_dummy_page_fini(adev);
=20
-	amdgpu_device_unmap_mmio(adev);
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		amdgpu_device_unmap_mmio(adev);
+	else
+		drm_dev_exit(idx);
+
 }
=20
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
--
2.25.1

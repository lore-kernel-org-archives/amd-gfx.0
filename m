Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F1CC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 06:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B5E10E3B0;
	Wed, 17 May 2023 06:27:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB1610E3B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 06:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcqcERzi0mV/x53/aQdcBxEoqMB3yEb3FuhEE5E7Y+vofmMgKBGtyHJ192U4f0oXnUFNwQUf4WCE1cYM4l8HTCuYHmvIrbr56DCSaW/StzpkVEToJRhjtLHh/YQxsSHDFqhsoQtQo1nvW5FTNsetAfzjbHr8dfzndbZa+/K+xDgQxQoccM2JnP+sDTMq/p1i+eNiQz701qByQAsXTfB1yf80/JT0X0YCSfe9H0Pn/ruk+J1kv3cMZOn/91uF24hHHJrfj+OnEtBjDh0Nwn9VMQDDU3uNe8vRbIM7R7hqlDJrKh7iVrw9qV8EiGYbc0I9KpVy78eiP6HDCHoJUhkTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85pVKU/dsEkP1aixurvW6CLe7paO6DQLnVA7uVVHtWM=;
 b=BR1iVr4/wlftkOKFOTxNryVEgflbT40tcxtPs/Ag8SwAx/mQ/EpncRdyW4kKV6lQckWk6LGDRRDvoUVE2BWsuPNDcSJh4BkeycL3+Zwy8VTZ+vbabjFLQhrNjmtUy58XhhRcdO02s52FSwp3bGaEBByqRf3t5V0kABZi3XMEUmTEv+wLZn3ut+D668/6L+Ch8RV/wD90tcs+qImwRRcqS6WT+B4F99KgDmm+xK1UGNSb5RAwN+lVD4jR26dAPRBXXmT23BXNNUYkWteExN1HABqoYBm/X1bfeSyYO108T42hwjf1VE93q9yJsVlSdVG0YB5YDxJrzSl1YGW9G+rXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85pVKU/dsEkP1aixurvW6CLe7paO6DQLnVA7uVVHtWM=;
 b=JqhaOjn8GAg/WqpBw52Q/Kcwbid5TTP2kyi476SS7TQd1g57HGm+DXbfcq20lOxispETQNNt2YoTVRkl5hC0gUbMx8Yl7nWNC0CBI4B2xITFtwZaSBKZBIcvQ/xQvzrM1jiAKDuBAV0Yq4vByAK3pYNPn1cGwmwrhTZpl0BGwPg=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 06:27:11 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 06:27:10 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Index: AQHZh9tyTc6ORBSZYUOEPF2Enkjow69d/+Lw
Date: Wed, 17 May 2023 06:27:10 +0000
Message-ID: <DM4PR12MB50721544D0305ED7527FED95E17E9@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230516094716.323715-1-Tong.Liu01@amd.com>
In-Reply-To: <20230516094716.323715-1-Tong.Liu01@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54cebcd5-1ccc-439f-9382-533b9eab851a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T06:21:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|MN2PR12MB4239:EE_
x-ms-office365-filtering-correlation-id: f0faf621-e414-439e-a6f8-08db569fbede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Z5KdjjeKYzl6x2pqlIWiqcnGGuCJJ1BZ6dtaEAcr5txk171iC1KOSwA7uf/yhukeLTClFw19YkX9dwz6gUgFlLIVa16MQcDzTe/euFoYVHcwuhmtnI0cPbWRdHDv9hrhprSlg20RcqXD7Lze1EWzUw0Bii86klkudIZcO3p88EVhXCPEwDU1ykggfRb4eo+9qt09GZRd68/bq5BINUZ1fFdxitF1r2/oRNEQgQ4OqOT88C99h7Ojpm6VNJShaW1MFQXhMs+1Odlbfn+AoEFPBvnVBJSUEZbP2hp0T9hOf2pYp6ZL1J2LOWYOQ8CVfajdwloK3Ut+fpF2o1dDXZTdKWcqmfZuN8v2WHwc57M2aUZ8XCl9vFlf0hTfv81ZPb/GwNqg22PkynLvM7l/eAqIVcmKSKcmO1MzqR6Plkn0zsP/RQEG1J2bArbjpetGChrwtRUKb2CK+Vpotb4pIIRRjNHEx1r3i/lzFj2kXXRz7CLBnECqq+AZ/0XFPL2w2KvcfDghMmtenSey2ib9gfnSSWherBrsQngt/bzsX8/LCho6P4C0Z3f9HQcYggP5vmQiK9HDYpITb7kZ0YKDOGaqM61ZPGtIO1YBAAxmZEOm0Ih4bQWP8Gn6qGsXwkGGzHF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(84040400005)(451199021)(53546011)(9686003)(6506007)(38070700005)(186003)(2906002)(86362001)(26005)(83380400001)(55016003)(33656002)(38100700002)(122000001)(41300700001)(71200400001)(7696005)(4326008)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(54906003)(110136005)(478600001)(52536014)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5eU3lkrYNcAryaYE/zPCfV0wLR7FbXY34WMUjkX7mXxNJIHgm6qDufUpsQ9P?=
 =?us-ascii?Q?Aoie2w2eUv+5OZTNkkSY+qOr/WuOqmCByIQKathbnWZqT4NcAHIelsNWzenj?=
 =?us-ascii?Q?nqyqPZxfXIAiwIor6J6dn09bQfihisrbRCHGpF/ioH7u+Fcoh4luWAJ4ArXV?=
 =?us-ascii?Q?xv2JBuLqVf+nmrG8QDD8tp/yIzaqWZx9S8+Ubd+D0fmb/zOcXc4fWkFGwYdm?=
 =?us-ascii?Q?+gClipsHlN4AicHRmgegtkuL+jks88JFAG3ZZgSivVc7kGJaDriLszoSh83b?=
 =?us-ascii?Q?ZBU5gJXZ60mNR2vYqApPT08vu30KOnnVAkvsgcrTh0UFBFBPvnrqmOectDHt?=
 =?us-ascii?Q?Ea/u3LkFinzZEhjq8Fvte0sLLnt369CrXgG6khrU86CyROJ7uQahkIA6topr?=
 =?us-ascii?Q?6ANVBq4cDHLS2YKNH5CuGUkMkBX+4NnsDYUpFluPY4BhB7S0F+TEdsYoLJAw?=
 =?us-ascii?Q?RLoo3m2K2Zcz4//GGeBk965PJANFEgMvqLorCmP7yydH/0oWy0V8eYKLWiI/?=
 =?us-ascii?Q?Mv/9WfKWAe6QJP/CZT1tGLc4EFLZs035IhjIIjGmPhn1bLtaS3/XxildfwpC?=
 =?us-ascii?Q?fd4VvXElu3Qmqs6AheAzZjiWYVLYwNblLr6kwch330ccvSd5ges1JW63FMOn?=
 =?us-ascii?Q?CAu2bHF4Ehb3p7hcZaFWyVKT4hEF47+QEYNc47XlQw2EDXyYi2VRKr0vgQIR?=
 =?us-ascii?Q?3oh2R9z5cGluY+5MhCOEtXdGaSWBNlhjsW+o7LldpAm4YsPIBxAnVe8EeQm5?=
 =?us-ascii?Q?9bM6he8lRAjzxW5ImvaYfa3YgPninoUm+fFVCodynPvmJF1MTQ2DyjhBT3uN?=
 =?us-ascii?Q?+Bgo+Qwhjc8rEpHG9KiIaGQLJC7/d3q5cEYrMfLIxEaqfDRg4+Z2882A1NHN?=
 =?us-ascii?Q?7VS7tfpV7NTTIWwck5EIrc7rPoUURbg+SICPI6DPQxk5Nr9UJCVM/Neovlkr?=
 =?us-ascii?Q?fxCan2I9QACYxFkTw3J7dFEQJPWTp6C+7SNvksSOiz6szMjnmM4QFiPCeIQb?=
 =?us-ascii?Q?+fKgs9XGP4HDJ45Z23lAgQ1HcHx+QPeAxr2Bztxv811RQGSYPzNwjfi7/gl2?=
 =?us-ascii?Q?vdxr8Pj1QnS+1PJ1N4u9SZHury0TWQwXjaAkryqJL823J9wQaTIZrEwkpfpc?=
 =?us-ascii?Q?2WIxpVAPedo0nq+hkSmUTfMB+olNK6uomB6us7P14wNMUBKd26ttZhS18WHS?=
 =?us-ascii?Q?6bqcvfYDKZbXFEEVymJ6ynQymChwidv0A+gmfwCOOsRpBXDtX6ibSMa4lU4e?=
 =?us-ascii?Q?6jtaKnKev0yu0hhc+FuB5NJIAlWZ6x7roY2IWGeOgltewuyRDH+apxLt/PnJ?=
 =?us-ascii?Q?KYVo3NrJFgB09+zH4jMVoq4bTLFBJsCdjoXPyVs5qTuWWDLr6hgheffyxpto?=
 =?us-ascii?Q?pWKhKSP9UpI8y3ss9vEkX/A4N3rcoaittLPfN1DuBtu0wxiFjMHtOCjyNEew?=
 =?us-ascii?Q?uzHNWaMse8F3T4mjHALJtEj7ksofVvPJk2CNUIfdZOYCPduexc8CTIb/EM7j?=
 =?us-ascii?Q?/C4j5FX23HURhZvc03TvR9phu21d+hNhJv3oiKlpgDM/CyHZLGziFcF8GYOa?=
 =?us-ascii?Q?0eMeXpuckW89rRAg5RQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0faf621-e414-439e-a6f8-08db569fbede
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 06:27:10.4631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPoeGLG6K59+Zu8iuA7Y/qHsfrRaVWMOMZ0dgqigVj9quSvYGfHOserDGBfA7EEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>, "Chang, 
 HaiJun" <HaiJun.Chang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Alex,

Can you help review this patch?
Currently on passthrough, GPU is also on the root bus but it is not APU. Cu=
rrent driver regard it as APU and limit the PCIE link speed to gen2. It cau=
ses some failure on some OCL benchmark.

Thanks & Regards,
Horace.

-----Original Message-----
From: Tong Liu01 <Tong.Liu01@amd.com>
Sent: Tuesday, May 16, 2023 5:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Kevin Wang <Kevin1.Wang@amd.com>; Cha=
ng, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough cas=
e

[why]
Passthrough case is treated as root bus and pcie_gen_mask is set as default=
 value that does not support GEN 3 and GEN 4 for PCIe link speed. So PCIe l=
ink speed will be downgraded at smu hw init in passthrough condition

[how]
Move detect virtualization before get pcie info and check if it is passthro=
ugh case when set pcie_gen_mask

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a9d9bbe8586b..255b0014b6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,6 +3813,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base=
);
        DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);

+       /* detect hw virtualization here */
+       amdgpu_detect_virtualization(adev);
+
        amdgpu_device_get_pcie_info(adev);

        if (amdgpu_mcbp)
@@ -3827,9 +3830,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (!adev->reset_domain)
                return -ENOMEM;

-       /* detect hw virtualization here */
-       amdgpu_detect_virtualization(adev);
-
        r =3D amdgpu_device_get_job_timeout_settings(adev);
        if (r) {
                dev_err(adev->dev, "invalid lockup_timeout parameter syntax=
\n"); @@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie_info(struct =
amdgpu_device *adev)
                adev->pm.pcie_mlw_mask =3D amdgpu_pcie_lane_cap;

        /* covers APUs as well */
-       if (pci_is_root_bus(adev->pdev->bus)) {
+       if (pci_is_root_bus(adev->pdev->bus) && !amdgpu_passthrough(adev)) =
{
                if (adev->pm.pcie_gen_mask =3D=3D 0)
                        adev->pm.pcie_gen_mask =3D AMDGPU_DEFAULT_PCIE_GEN_=
MASK;
                if (adev->pm.pcie_mlw_mask =3D=3D 0)
--
2.34.1


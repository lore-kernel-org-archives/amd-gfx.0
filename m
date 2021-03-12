Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB412C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD7A64FFB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD7A64FFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33F16F893;
	Fri, 12 Mar 2021 15:27:08 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9AB6F893
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 15:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1jENth++VS+CYRkS3SEfmJSqBbLw/168JxvJz6wzj8qT1baY9cSptOS0PWziOeGIvn3km8xlIDcbsljvVUTLf/PZXlnELELVUs0GWiQH1a7Sq6oyIkQ3cObaNECP8wmwdc495dVNe8CNTkqQCHJghmR4UOkHEv2GoCLKJSawA0FI/XRmPcOnqpArYYSjRGD+ARaMnffeiVLgPvs+wIY9SA2cJTK6aYqGa23hNisFSSci87Kg58t2ZlIDgHDcQEE2woOqBVAvVASUKXL6MYi2S6ciiyuEeWaKz6ZUM69FkCi/2Zvon1clF2opmICuwJ9ybWcuttxONXnartIW/j9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqEJuJvRQZCf5aWbf1V31UXwZnbzL/MfrRyiNIWSB9A=;
 b=E12Ld/fKWcS0Ud5bivAxJFZdwZaIAHnxMoEcfs9Pcxjv/vxMkI/NQrfmjfFxTg33g8cux4aDn4kKBlWbFxxk6qGGaaJrJPUOEGQ/xrskq1GTt+myJDoYzacapLR8MDvEn1Bpb/gdr1ut+/PbqQYJc2Uq2C+ED8os2QKKtBzFPo41Dkkw5d/xshKsGgtVMkTtB4LTwijPn2AB5CCRZvSH/vZpzrqjNwPUNs9q8AGDVw2ZR7TCy9+fPmHeNpwCkcmFVpdADtbPv6YS9IrIV/L6jaAckVumZqKe/N99d4EMMjvSVbV3wKBMYoVl1VSsFY66asYGfq/cFQhGlWRRwVVuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqEJuJvRQZCf5aWbf1V31UXwZnbzL/MfrRyiNIWSB9A=;
 b=WiwMZHRRhwg4sQofTgy9e6R6tN3bcHybT08KAuvORMQ1itHevlfHSqIRepxwWpQMTcQexR6BtayC7JvTQs5x9J2Qwkmlj5h3OOYL2Qt9PYbQ71QC0Qlfhi28gbKfyK1p34q59Oh24xgwRP6sqduf0B5OKKVoHmsZqK+vDO6I2bY=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 15:27:05 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 15:27:05 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo1/qViy9Iqmk2vLKn/BFJ85qp/tiyAgACmLouAAATrAIAAFoTQ
Date: Fri, 12 Mar 2021 15:27:05 +0000
Message-ID: <DM6PR12MB383506A71D683EFED22BE0ABF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>,
 <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <DM6PR12MB3835F2F751F9A0F52009CC5EF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
 <MN2PR12MB45495A8F65EBB79F58CCA142976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45495A8F65EBB79F58CCA142976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T15:27:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff272384-ee4d-41d9-8a3c-8f064fc901a2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d841da9-c261-49cc-b9f6-08d8e56b4b0b
x-ms-traffictypediagnostic: DM6PR12MB2602:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2602BF10EDBF67B61AEA2E57F46F9@DM6PR12MB2602.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwjWxzoS2GJVeBDqRlrZA752Q890KyFZJlXcRJNtWW+4sLhWIZVtquQzYAWtDTIqqv3X/Ip1XpJ2vvNBFFMEKhNMciLJEpIlFAs67zfVOzeU6oEx+QwbA+cgiojgsbGbTTSFXJ+mesbwCfmv82QwOUst69KAkFjJ84C3BGnJSbFYqFNNJqvjZtDfhb4ARy2t4yYuOAAu0aIH0pXrs9mSyLPp/PQbSznlrgRPpPYkGGz1+dCQRaKMgw0op/STCQqwoc2EwEsPxb6x9FfoAZi1qPMzdernwoMqK1k0lZ1uwsP0YLhFe3Owwx8GllYvxdI1G/HGgj4VSe/A62Bcxttv8h6OJPNudgtdKROJXlhPE/VeZ7cwY/4CBm6xp2PtLA0+PkClKuze1lA0DdRKW5uQ+AJTvhrUT9P7Fb9ScxxE7a6QT6JFmHCDWiqp2E76gaRPphfMbhz4vz//1Wun853Dr5fO9wz2dPEgS0Na/51CXKt1NRnfXnK4PkfahxeXTqXIpuINCow9hrIsu/M0sQOfO3QcuNWYb0F+B9sOmO3mr+1G7+yPywniEiX9T+FmscfOq0dDHIRo1GUOMltuZLx9QQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(33656002)(83380400001)(166002)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008)(316002)(52536014)(7696005)(966005)(2906002)(5660300002)(6506007)(53546011)(45080400002)(26005)(86362001)(8676002)(9686003)(6636002)(478600001)(110136005)(55016002)(8936002)(71200400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rwBnaw4p2q8tEKir6wqZoY3ta3JZj7NWjke+zzx1zLoRwI+4JkE2D9Lv1M9b?=
 =?us-ascii?Q?3l8eUr7ODhdHClc3YO1aDAHzSHhr7lU86LiTwhNkkJkVSxJCrmHwjNX4AWRd?=
 =?us-ascii?Q?pYQKmzLCLCJVLp3tiIoGAhlJPDUNxZI7VbD+MyPzO6P7LvIJE+Y5CzawwI1L?=
 =?us-ascii?Q?jTtpZY2Df3PQ33ooFhjzELGzplk1Cm725A5zZ7YT0pnFEf9TJZPBcHRSluKk?=
 =?us-ascii?Q?XBdDxzJF9WLW/KGM1n5wD/pxeE0I2QyUHZoi35GGh3s5ilYAHLr8ivkN8/PN?=
 =?us-ascii?Q?NNGjTgt8uaNKCPcX5Hlly7Qt8ZDBaofZ01+TrUp2TiObs+izEtPpY2YizsN3?=
 =?us-ascii?Q?MxUZeDa30a+pM6s9dDuRTFx8mOoZoEHZlX4ww3onjA5j2JNV7HZ1MwksJIJE?=
 =?us-ascii?Q?fVM0r2l3aDRx3Z383lyz4+9/PbTb0g/0y94VCaqnnoF5jmVI8ZNIq8pNp6cT?=
 =?us-ascii?Q?yADvjuvDRcivvdHvTIdp66S7c9C+iqCBZSljVnV0sMjjWIPP7ZjvsUvfE5QS?=
 =?us-ascii?Q?/1Zx0F72nWGSRcWPF59if2tprWfy6pmZNLu2/fCL3uku4V7p3Ss1vFdA7c1f?=
 =?us-ascii?Q?rkz4UIrzIECEH64U5VJ1+wcQmdFn6jGtM5OqG8AYntjMCEXhrhy43lOek41C?=
 =?us-ascii?Q?s7ZVPQHHH6HJAvX286ETa4wt9rdXjTDHNxWhIAUhV2wZipkuoAG9LSYvXnMY?=
 =?us-ascii?Q?i1B92HPuThjqATcYgNjaRC+2wEAhAHfGeeHvrC0+5csYMrYR9DhgpWwoay6j?=
 =?us-ascii?Q?dmn/ywZuu07gPvwUtBprfIGSZIvoTGtvdaNIIlpeVbK8e2mWJ27QOPOqHoD7?=
 =?us-ascii?Q?6ltxD2Su+ZxtJhjz2w0+KVEuYBHYl/Hu/YqV/Azzp2uwGHR9SgYyN4bHJ3cB?=
 =?us-ascii?Q?RB5RKBjiikyaf7HPJGdpoiPPFTKeIG17u1E3fIgPZnU4y0zVi32kuWbTWHDe?=
 =?us-ascii?Q?agksYmBRRWBajZfn630VWLAX9yYJ4wwbV2Z80Lw+1gWwW8BIG64zR1g0yQRh?=
 =?us-ascii?Q?AtHlYQ5qH/KDNx2cZf1SFFY/Q9kRYV7xJMuWOxvaQzWPhlzVbCTr7bASqTF1?=
 =?us-ascii?Q?DdcDp+cMosP0RtA7umWXcD7EGLvl2SOzfccJ4AUhwz81xTfjvij2m7+K5LlM?=
 =?us-ascii?Q?VCRP6IyInOw+v1nzJ6sXWIMiQGObLSvkK/Uwm+UO7/JxpQMIXTv2QJ9BDP9N?=
 =?us-ascii?Q?1rs3YkXLxyJQVRQ3anqB6DAhPSxtmFbXidy09emhTGuEkAUoHzr7okJjxGkP?=
 =?us-ascii?Q?e03B3X2DPzHrL9g+4csTsQfBqLkoa65S03EE0/0h/CLeXW2zuqd2nadJLo9o?=
 =?us-ascii?Q?JwKIRkoWV9xkdI5uf7UNuq10?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d841da9-c261-49cc-b9f6-08d8e56b4b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:27:05.5296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CSN8hKpASEgBvbK9lo7yEYvyqKpxqkIy9LxuqUMBNqKAQlsbU1XLV7twT1QFjJri7x8BQAfxVP9nE/jnMF3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
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
Content-Type: multipart/mixed; boundary="===============0349898501=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0349898501==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB383506A71D683EFED22BE0ABF46F9DM6PR12MB3835namp_"

--_000_DM6PR12MB383506A71D683EFED22BE0ABF46F9DM6PR12MB3835namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I don't like to add this set_light_sbr into ppt_funcs  either , but please =
check current swsmu  code structure ,  there is no asic specific swsmu late=
 init function  and  there is no direct routine form  amdgpu_smu.c to smu_v=
11_0.c either . It requires  smu common code ->ppt_func -> smu_v11_0 for Ar=
cturus  specific function .  So unless SMU and  PPT have a major re-structu=
re , set_light_sbr need to go through ppt_func for now,  I think I  better =
 leave this  re-structure task to SMU and  PPT owner in the future .

Add  SMU and  PPT code owner  Hawking  and Quan for comments .

Regards
Shaoyun.liu


From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 12, 2021 8:55 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration


[AMD Public Use]

We want to keep ppt_funcs minimal. Adding everything to ppt_funcs and keepi=
ng as NULL is not the right way. Please keep the code to arcturus.

Thanks,
Lijo

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, March 12, 2021 7:21 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

Thanks for the comments. This light sbr solution could be applied to other =
asic as well. In swsmu code, It will check whether the function pointer set=
_light_sbr is valid before real call the function. So for other asics if th=
e smu apply the same change, just add the ppt function pointer and we will =
have this support without further code change.

Thanks
Shaoyun.liu

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: March 11, 2021 10:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

[AMD Public Use]

We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com<mailto:shaoyun.liu@amd.com>>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+       /* For XGMI + passthrough configuration , enable light SBR */
+       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
+               smu_set_light_sbr(&adev->smu, true);

         if (adev->gmc.xgmi.num_physical_nodes > 1) {
                 mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_device_cache_pci_state(adev->pdev))
                 pci_restore_state(pdev);

-       /* Enable lightSBR on SMU in passthrough + xgmi configuration */
-       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
-               smu_set_light_sbr(&adev->smu, true);
-
         if (adev->gmc.xgmi.pending_reset)
                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wor=
k,
                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7nd=
htOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;reserved=3D0

--_000_DM6PR12MB383506A71D683EFED22BE0ABF46F9DM6PR12MB3835namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I don&#8217;t like to add this set_light_sbr into pp=
t_funcs &nbsp;either , but please check current swsmu &nbsp;code structure =
, &nbsp;there is no asic specific swsmu late init function&nbsp; and &nbsp;=
there is no direct routine form&nbsp; amdgpu_smu.c to smu_v11_0.c either
 . It requires &nbsp;smu common code -&gt;ppt_func -&gt; smu_v11_0 for Arct=
urus &nbsp;specific function .&nbsp; So unless SMU and&nbsp; PPT have a maj=
or re-structure , set_light_sbr need to go through ppt_func for now,&nbsp; =
I think I &nbsp;better &nbsp;leave this &nbsp;re-structure task to SMU and&=
nbsp; PPT
 owner in the future . <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add &nbsp;SMU and&nbsp; PPT code owner &nbsp;Hawking=
 &nbsp;and Quan for comments .
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Friday, March 12, 2021 8:55 AM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We want to keep ppt_funcs minimal. Adding everything=
 to ppt_funcs and keeping as NULL is not the right way. Please keep the cod=
e to arcturus.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shao=
yun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, March 12, 2021 7:21 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Thanks for the comments. This light sbr solution cou=
ld be applied to other asic as well. In swsmu code, It will check whether t=
he function pointer set_light_sbr is valid before real call the function. S=
o for other asics if the smu apply
 the same change, just add the ppt function pointer and we will have this s=
upport without further code change.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> March 11, 2021 10:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of shaoyunl<br>
Sent: Thursday, March 11, 2021 10:46 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd=
.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion<br>
<br>
This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.<br>
<br>
Signed-off-by: shaoyunl &lt;<a href=3D"mailto:shaoyun.liu@amd.com">shaoyun.=
liu@amd.com</a>&gt;<br>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index cada3e77c7d5..fb775a9c0db1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configurati=
on , enable light SBR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_=
physical_nodes &gt; 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_cache_pc=
i_state(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable lightSBR on SMU in passthro=
ugh + xgmi configuration */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.pend=
ing_reset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_wq, &amp;mgpu_info.delayed_=
reset_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffi=
es(AMDGPU_RESUME_MS));<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;r=
eserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB383506A71D683EFED22BE0ABF46F9DM6PR12MB3835namp_--

--===============0349898501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0349898501==--

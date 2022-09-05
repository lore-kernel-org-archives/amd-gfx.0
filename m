Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77918ECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 13:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A496D10E351;
	Mon,  5 Sep 2022 13:08:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F2910E351
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 13:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTA9772sSpJ3oa6Le+XT4WH8lOwr3w7G1Cd49URd7mx5NWFCkbWTyeYN0Cf8EjhUjVHbIbpgTmy9dqCq/IMG3KY3scOIZbYBNi9SDvyW3JN8gPhdGAJvaUMa1sI49V8adhMKFSQcwB7M6OVgRN6b/efsaRF+czfCipCc5zP1TgcKwns5py6PrNHURZ0FXb4uZLtHyY/ZciL13bdJB5hEeQ6cLFuFfAQad3BEyfyCP0wh5zzO6lcPWHYqBW1l2bMJtqsyQcEka5ukXkk6rg1hVIavWDnLHbTXZc4hUOFT8RRSnS1IRKbYvE95qsL8gFkFsAUMKGb1IqKsGbV2qbGHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t1t/qosWehbfKwek4Mk03sdgT0B8eVZjLOUyUMjZBI=;
 b=Gye/vhPbxRBvD6czZH03TScLQAAFFfKXJjpBWEFLxYS2/tM1nN1+D/kUD8+zC/uvalD8aG92v4xPNSzvUAmjo+HKsLfAADtHTqF0ShRIIL6s6WasiAI3n9XhiPw9kxVdlT42JXO1r+AK51fAiWE0yQ2LMzPyuBjhEw5fRlB218fEbKnHBGbMvsRmGCS823kvLe1lEXlC/zjbaxr152NOeAzCyo9aOCY5PmJHuq/0EwYsOzhnN36Jc2mvcoB7m0ow9H67d56Es4g/h6xvWcSywdgjyOQmELW5ggeVOQ3//J0Eva+JGMbXsoF5VYZzRTljDNoOs6b//6HvNNb42Rev3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t1t/qosWehbfKwek4Mk03sdgT0B8eVZjLOUyUMjZBI=;
 b=huG41vc7j6ZJF+CqnJX/swtV7m+Y7a97OI2fPcR37L9rvGWlNfdVg0/Q2nnVtz6zx7a0SlDnYEiGXS2wlOppzcns2aZjd6wb/1ZBF0Ma3NLs6b02gm5oU94Tq2PCF5x4oT7QyNU14GK2gtY0ZBxzKScDUWTzegSaxtnBdq0uqms=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 13:08:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:08:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent
 to psp when amdgpu is uninstalled
Thread-Topic: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent
 to psp when amdgpu is uninstalled
Thread-Index: AQHYvd566AD2BHY7nkOfrQdtgp8u6K3QZ7KAgABtIgQ=
Date: Mon, 5 Sep 2022 13:08:00 +0000
Message-ID: <BN9PR12MB525781235956C7024DFA556DFC7F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220901083955.2696208-1-YiPeng.Chai@amd.com>
 <CH2PR12MB4215BC1389204B0F153DFC57FC7F9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215BC1389204B0F153DFC57FC7F9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-05T06:35:37.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d556055-998c-4d36-2e18-08da8f3fa90e
x-ms-traffictypediagnostic: CH3PR12MB7643:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCqp/bKMdXhIwJQck4HP7EBYXQsPE3HeyEmm5G9ltT0pF8MNvrLmo87wvEHF21OI09g88OK3Cao5guBVxlKUuZluYm0zaH97hmF8wT8fT+Xk4my2xkG25qKfMbkKp5ttnLW93AeJAJo2YwlBC7M13MN0DZaVevJ9ScAOiQGQvBjeG2rm7uQw2hWauVejfPPgKIKA7ub7YAl8KUTwz6LHsNEYmewF3E+4wddjA7TDLXBEfFpgrs912XXATbT18+DeX1hsujmcpl6RFHGHqWX3Xb0UNsKQYEcE8cwcHbeCfWdw1CHbKHozrsp28rPg/nT12gSFqHi07dJYSv4eoz6714jFB/8nwdNBlkfFh2oj5JRKT0LkJLUyaIrj7ROjVSiqNY8dyIcjryReytQUFzDCx4Za7tscex9tgICB43VwKW5cNw3X5ARNEE7sI7HdXSTPf3o2JtN1XiJtxMcDMEoNPLjVPFLD8kylXziDB0c257AIrLOtc1WIRLOpBhbCdAyqDafw6295m9tOFVvev+2qIjD5xPrjv6I+ZcyBr+JYn5rnxt7kR3UdNlY59As3/baBrvKbY1qIfBodUtw8iPucRf9ff0OJCqfcd6oP9pDpyyyzjObp1WZ1Qx6leOqq2kBWp3SITT0gLa8box1VYZhpqI6oeii6TvfOpNSEms5QkpQXRPr7tCwqCi9SdxSr2YU+Qc/j91IGYsCAYJGT458mM8Vf2nnmI4SnoN+rg1ewEDfinjnYyeKVKmaW7KrKIUyld/ll8r7VOPD1A100sRRUvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(55016003)(2906002)(7696005)(6506007)(52536014)(53546011)(38070700005)(15650500001)(5660300002)(186003)(71200400001)(8936002)(83380400001)(41300700001)(66946007)(76116006)(4326008)(91956017)(66446008)(8676002)(66476007)(66556008)(38100700002)(110136005)(478600001)(33656002)(9686003)(26005)(64756008)(316002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gm4u2ud3i1gmlzlfNrZcl0IrczamT5dDBoN5ofFdkkoSqU2wey05HWhbExM?=
 =?us-ascii?Q?WaLSws2uVJocfyKWN9UB9wdGYAxD2trHlwEZbz5I4hIbVotySgX6sFWtmGsS?=
 =?us-ascii?Q?XxUXiINDnq7yS24xBlMlG8B8PRnIcu8qjUtdu9PtEgEHKnwM1MUgLttrthM2?=
 =?us-ascii?Q?yJZVDmQmy8Q2WtUJNYzKsC0hPQWL6QBv27ZHpfhrRlwelbJWNAYbpuV91B/Q?=
 =?us-ascii?Q?yLAF4gWueR6I7AknmwHve7ifIEGRPi1xuIQ1Sqt61oYv5//Vx0+zhCspbpkH?=
 =?us-ascii?Q?mkfmyA6919xl51Cfy84MR/W7o5SFgQiTM5Olf3MDCtKGPkoSyO2nuZGqw+Sb?=
 =?us-ascii?Q?zaaflNoM719YBLNR6+ELAQz8//4S9WeMnx/DGopbd3OgpZ6LYysgtXO4sJaA?=
 =?us-ascii?Q?Lhnm4FHa4QIgmG1+UF7l6dDbmeJjyf2MwbCyz6L6nBuEHYRffYugYrJ+6vD6?=
 =?us-ascii?Q?lEIVwyAFumyMOtjfx3OD2S7NL8pJ44fgiXnUSR4m62vdQIcNTxRFwYJ08YT9?=
 =?us-ascii?Q?6c5dMeTXJo83BrNUb+gSFP1MiWtGTCFbHz/jHZj9q0V6Y/gOeXz19e1Us8wX?=
 =?us-ascii?Q?7Ax2a0OarS+B0YVpnJ4E2iGTlZaXMBk/srKb+kSTLBnDH8D6KpbCE+LyiIL+?=
 =?us-ascii?Q?zjuQvvaYivOhIuhzRIJUmJxWC1AwEQaSJJoPK8vL97L0CnbxquZKNMGQP0PE?=
 =?us-ascii?Q?M7qYHc2AcQv8CJeHQNImNDFV9tyzp6hvBelKLz2K2EigLpip1OjFDjAf1cC9?=
 =?us-ascii?Q?JNXny9s/T3hJ8I9TJcdUbQD2Rh6Y8jjBLHPLMVCebk6FvNUGoOBKk/91psRj?=
 =?us-ascii?Q?31AQSpGvuml4hZTKsRG3mvF4+zKNYlXUxeiyJ7gSVV3N4fOS9IlNkACRYhKW?=
 =?us-ascii?Q?ipQo7puY38P5p3/XI1wVeFGDMEkRXyWYr1Awqxmy87o4v9IaY37WNh0dQDzc?=
 =?us-ascii?Q?U3v33ATqCyGgCoNQmYoLpqsY+kcNvT2oAWg9gN3AYTdxZ6V3B6Nyu4dKyKsr?=
 =?us-ascii?Q?+uBc9e127LnjqUjITWN9N0PkzQg24QdQzTMa10Gn5wYc/pvS9N8bruWBlsnT?=
 =?us-ascii?Q?BRY8NiNsDZ6flH9ngRtcoUfQmeoXHnNwh4w6ecnGAZORuxtuQaK1anNVpaFT?=
 =?us-ascii?Q?ZNOt6vfySuYbsZWjzpTLVnegnzeg6hMH/e9tSwxj5J29/fSGdm5ZVtxStT30?=
 =?us-ascii?Q?FAQl8Bmz5EGgLwpvLITTkMd+GEsUyQtUpPF+tMn9ebnm18zorquN88NXF2OC?=
 =?us-ascii?Q?klOYfpy/Ysd8rc1aqtWsb6Ovw//d45SU7tnaELLSV0e3JFrvfsxV6sD790p4?=
 =?us-ascii?Q?CeA4mAlMjGeP9dGH07fovuO5yx+kDkes+8SPWySHDrf2wg2UfajDc4key3WU?=
 =?us-ascii?Q?eF5olfsF5rwoADJjzHAxlG0Gpc/V8g2ru26j9RdGB866gqRHXTLc//oAnahv?=
 =?us-ascii?Q?KLPBze9REee75LaJYQTTBewIVXE9Krby8rhR4esUaAy6I33/jIP9wLTTL4rb?=
 =?us-ascii?Q?+gkbDrb40NCs1DPvt6AS+1tciraf5Si+MUvXUBNK1/ut6Qe0yYll3lfb8jcH?=
 =?us-ascii?Q?cv42TMew4p5S/Ffxtak6hrEOUn/QwbT5ljy4tjZTiFxqeP6cdH3YRpZgOmRt?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525781235956C7024DFA556DFC7F9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d556055-998c-4d36-2e18-08da8f3fa90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 13:08:00.7712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic1etFfgGw6Lk/1d3sTJQPidJ9D1+8Q3eiLyW44bLngThdhChelwUqWlDT0HpwyqspiUeasCjTEWTsziQ1jtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB525781235956C7024DFA556DFC7F9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Chai, Thomas <YiPeng.Chai@amd.com>
Date: Monday, September 5, 2022 at 14:35
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>, Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: TA unload messages are not actually sen=
t to psp when amdgpu is uninstalled
[AMD Official Use Only - General]

Ping....


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, September 1, 2022 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent to=
 psp when amdgpu is uninstalled

V1:
  The psp_cmd_submit_buf function is called by psp_hw_fini to send TA unloa=
d messages to psp to terminate ras, asd and tmr. But when amdgpu is uninsta=
lled, drm_dev_unplug is called earlier than psp_hw_fini in amdgpu_pci_remov=
e, the calling order as follows:
static void amdgpu_pci_remove(struct pci_dev *pdev) {
        drm_dev_unplug
        ......
        amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
                ->.hw_fini->psp_hw_fini->...
                ->psp_ta_unload->psp_cmd_submit_buf
        ......
}
The program will return when calling drm_dev_enter in psp_cmd_submit_buf.

So the call to drm_dev_enter in psp_cmd_submit_buf should be removed, so th=
at the TA unload messages can be sent to the psp when amdgpu is uninstalled=
.

V2:
1. Restore psp_cmd_submit_buf to its original code.
2. Move drm_dev_unplug call after amdgpu_driver_unload_kms in
   amdgpu_pci_remove.
3. Since amdgpu_device_fini_hw is called by amdgpu_driver_unload_kms,
   remove the unplug check to release device mmio resource in
   amdgpu_device_fini_hw before calling drm_dev_unplug.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index afaa1056e039..62b26f0e37b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3969,8 +3969,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)

         amdgpu_gart_dummy_page_fini(adev);

-       if (drm_dev_is_unplugged(adev_to_drm(adev)))
-               amdgpu_device_unmap_mmio(adev);
+       amdgpu_device_unmap_mmio(adev);

 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index de7144b06e93..728a0933ea6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2181,8 +2181,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
         struct drm_device *dev =3D pci_get_drvdata(pdev);
         struct amdgpu_device *adev =3D drm_to_adev(dev);

-       drm_dev_unplug(dev);
-
         if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
                 pm_runtime_get_sync(dev->dev);
                 pm_runtime_forbid(dev->dev);
@@ -2190,6 +2188,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)

         amdgpu_driver_unload_kms(dev);

+       drm_dev_unplug(dev);
+
         /*
          * Flush any in flight DMA operations from device.
          * Clear the Bus Master Enable bit and then wait on the PCIe Devic=
e
--
2.25.1

--_000_BN9PR12MB525781235956C7024DFA556DFC7F9BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hawking<o:p></o:p><=
/span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Chai, Thomas &lt;Yi=
Peng.Chai@amd.com&gt;<br>
<b>Date: </b>Monday, September 5, 2022 at 14:35<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH V2] drm/amdgpu: TA unload messages are not actua=
lly sent to psp when amdgpu is uninstalled<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - General]<br>
<br>
Ping....<br>
<br>
<br>
-----------------<br>
Best Regards,<br>
Thomas<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt; <br>
Sent: Thursday, September 1, 2022 4:40 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiP=
eng.Chai@amd.com&gt;<br>
Subject: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent to=
 psp when amdgpu is uninstalled<br>
<br>
V1:<br>
&nbsp; The psp_cmd_submit_buf function is called by psp_hw_fini to send TA =
unload messages to psp to terminate ras, asd and tmr. But when amdgpu is un=
installed, drm_dev_unplug is called earlier than psp_hw_fini in amdgpu_pci_=
remove, the calling order as follows:<br>
static void amdgpu_pci_remove(struct pci_dev *pdev) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_driver_unload_kms-&gt;amd=
gpu_device_fini_hw-&gt;...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; -&gt;.hw_fini-&gt;psp_hw_fini-&gt;...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; -&gt;psp_ta_unload-&gt;psp_cmd_submit_buf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
}<br>
The program will return when calling drm_dev_enter in psp_cmd_submit_buf.<b=
r>
<br>
So the call to drm_dev_enter in psp_cmd_submit_buf should be removed, so th=
at the TA unload messages can be sent to the psp when amdgpu is uninstalled=
.<br>
<br>
V2:<br>
1. Restore psp_cmd_submit_buf to its original code.<br>
2. Move drm_dev_unplug call after amdgpu_driver_unload_kms in<br>
&nbsp;&nbsp; amdgpu_pci_remove.<br>
3. Since amdgpu_device_fini_hw is called by amdgpu_driver_unload_kms,<br>
&nbsp;&nbsp; remove the unplug check to release device mmio resource in<br>
&nbsp;&nbsp; amdgpu_device_fini_hw before calling drm_dev_unplug.<br>
<br>
Signed-off-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; | 4 ++--<br=
>
&nbsp;2 files changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index afaa1056e039..62b26f0e37b0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3969,8 +3969,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_dummy_page_fin=
i(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drm_dev_is_unplugged(adev_to_drm(=
adev)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_unmap_mmio(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unmap_mmio(adev);<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index de7144b06e93..728a0933ea6f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2181,8 +2181,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(dev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.rpm_mode !=
=3D AMDGPU_RUNPM_NONE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_get_sync(dev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_forbid(dev-&gt;dev);<br>
@@ -2190,6 +2188,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_driver_unload_kms(d=
ev);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Flush any in fligh=
t DMA operations from device.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Clear the Bus Mast=
er Enable bit and then wait on the PCIe Device<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525781235956C7024DFA556DFC7F9BN9PR12MB5257namp_--

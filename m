Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D298BC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 13:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F8210E0BC;
	Thu, 18 May 2023 13:48:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B8F10E0BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 13:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6vslaiF2eCn+TUFZh3f7APRW/CJBQoV3FpWblqn2pLIxJqmxvHYaB0vDlRlOc7FyyEt202GyGLgOZT44Oj23OlFRMpz+do97fS+IiD4evy4MzLgCYfjqMe1I+TfALhYDNShCr7jSsQ8R9q0PWbDJnyv1aWQGRMNVypVfJUWE/YNPr1JSDSSd/DHUhsDEdQkybgyW/62MLhkr11dtl0r/r1qrbPGpYPAhTBr5SavNFaIUB2c/x7XltxIyyqWBa1ru4RILRyT8+cabRNlVwnEntEUlo2cZFpQz3mURddiE3S5LAfGdJxlLMp3jrIWZ2e9um84Tj0w0X59XmVRXMCVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6pBeka4BhVbeEfgEW9PQTSAx0106ijo1g0G+NwrgME=;
 b=GxpwepQUCE+dwBXgHDylz67kHPkOfcXujTYsqoF6n9VYTEJXv5elNW6cp5chep6quM8xnbb9eM6KhRZwEJA+mQgOs/AOUZSmHI/PMC3VqLR6FAKPGYujD1do9PwNUCxmxeCGAmALpOoA8yEjkvJELOLEtWAEw/lyvwyZGuOYE/uUkQsK7VWzTGyuIt3EvYl2Pe8Nq7BokgzUahANr+e5CisrCf9iCOHSHgwNQkbAm+kOX3ggYFz8RIbGkQXPuwrfeerWEiAx4jh4e8hf1t1hT6Ifi49vJSmmEPdWbYw3KjPs88lgLTto09Pv7xbaYd7rQYk+MbYZGKINgvcXtOOZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6pBeka4BhVbeEfgEW9PQTSAx0106ijo1g0G+NwrgME=;
 b=dlql56SYyatr3/aq39QNHmKmdPbv9f81z9Rg8dNIS3IC0j8zzfv27N9Ae9NN52sQIt3xjnZ8aYrPAm0ZL2ji6v4PHkhW89/pj7P3a2R/iKf4CJ8kqEulIR37tXxaJ9GkC1vDUNfOXSlaSvsSvGeJ8MfMdVevjXu8I3caphTYwis=
Received: from DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 13:48:17 +0000
Received: from DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::75a9:e409:8d14:bfeb]) by DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::75a9:e409:8d14:bfeb%6]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 13:48:16 +0000
From: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
Thread-Index: AQHZiTaQ0akw5PWzDEaBtZSZsXDNFq9gC7RQ
Date: Thu, 18 May 2023 13:48:16 +0000
Message-ID: <DM4PR12MB61340DB13197D17367A2008F907F9@DM4PR12MB6134.namprd12.prod.outlook.com>
References: <20230518031137.192047-1-Tong.Liu01@amd.com>
In-Reply-To: <20230518031137.192047-1-Tong.Liu01@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2a97529c-4009-4a85-9975-73b7c111af9c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-18T13:45:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6134:EE_|PH0PR12MB7886:EE_
x-ms-office365-filtering-correlation-id: 2d6ad4b8-3cac-4613-79bb-08db57a68850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zdAG6DTyyu+Fx2HLmsW8yfOitAp1obXnwo/c8UyRafsiKCbdQOTe9jQC0WXPstXBIgMwoOwSyhLbdPUMsgAOISiEIQb6Spm0hS83lMOt6jdlWhsPWNdvgfc4hezAjUkifTlW2G1y4iLYQKjKb71FAIAOK5qQ0MoEVZIz2LCysNPmAgOkJI8lu3OYt0DgMukWLa3oDZQVpw7uQsKOQzjGj3rxJZZXFno/GfWj6d9NvkzxZNrEdjFsPx3ZYbQvJ3Qhe90nAhNIrCaNliefEYNpO9jO7TwIHiegBEFAUhlrgqVHk19p9kDInv+EjGIXummDXgSGrjxk4V+prR0lNqM9xWjX8tNgx3KubZ2TUw+P1FaabOe7XxXmYHoZghpxy6qPzdgi7svsWTQJfJsDcYem5HjtahqOB1BRiWRPJ6MzKiuhex+ESOsbDWNQei19HbolDDBDm/bcH0cQezaz9VQ8Mww3QSitOEixBPJV/hCu39kekGujqDygBx/uIeUnEL/TY22fW06b3Ij0ftEpdQDlzSntDXDMUo4/T0dhdz1uAXBXOSCpsI/Qa1TIPG7wk5TJIT9nduipYa7VLep3kNH5eMyO9vVgV4s/6fAKsczA1HlvKPAfhWMZqD27WGgF0KS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6134.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(84040400005)(451199021)(5660300002)(41300700001)(71200400001)(2906002)(83380400001)(122000001)(86362001)(38100700002)(38070700005)(33656002)(186003)(9686003)(55016003)(6506007)(52536014)(26005)(6862004)(8936002)(8676002)(53546011)(7696005)(66556008)(66946007)(64756008)(66446008)(66476007)(76116006)(54906003)(478600001)(4326008)(6636002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ebD8IxcMFSCApJ4fsoVZJrLwYewu3QGHT4OvjfmFWZo9XV0BthFZy+w34zr?=
 =?us-ascii?Q?9ZiIgKPvbGjyKupncSlgX/0rsLsWMOSUapKh2r+qJSx/R67UYMfuodsFb8Ml?=
 =?us-ascii?Q?wILYOGav0BnWLtB2mpwOQt+1wk34deVmKSebe19VMlhQpAo1tKfyeIfgeHGf?=
 =?us-ascii?Q?+R0BwP1xw02i1Ko7Ii4+M6biXMkqzbwnbEBQjl5Y7B8nSHqU6FDoDq0s70kn?=
 =?us-ascii?Q?iLSJL/h3X0CxY6xUEckFMhFVAvwZLoij9ABMbkzb6c0tQ7PkDCISQ0v1oGWk?=
 =?us-ascii?Q?Q73QXzPtDEqadADv6XaEH3Dbd5HyONyiD8it4CQrVQq+1yDaCrHlIB7OznYq?=
 =?us-ascii?Q?obzjG3aPge5zKhWq685jDFPd1rASmjRfVprSIh81fd0lmYyJ32WYjAs6f1u9?=
 =?us-ascii?Q?f6cANhaAbheiXyewjhVLjya4zX487iw20Jbv7WRkPOnM8Lc+U1Xu+8WLihl9?=
 =?us-ascii?Q?I+iaQfwiSYrZiCcYyfGbD2xf5uTQOG1S6umXKkm2RyZbgIsXmXRNtfmQNYV9?=
 =?us-ascii?Q?3wvgr7SHOdL9I/b7ylhoAJ0Wm5M2uAPdVF/5KJAL483Bb1OZjLCGEyMWZ/+q?=
 =?us-ascii?Q?QSCMfMIgH/JgVSUUagPXj4zEnxtjr74mgQNpmPyoaG/ae5QJjaTN09Zt9Vw9?=
 =?us-ascii?Q?M57UgnFldhAZNcrYw5WgnNsQtlnH3dvqJYPbDFywBA803dbI66qYVzHZKUbN?=
 =?us-ascii?Q?v/yHmIGtJChWNh7rQRlyFFhnBasdV8O108V2AkB3oTk/fsbM0Dmr7buwCe7B?=
 =?us-ascii?Q?DcNSRqHcCpiOEG+ySp2L4P1TB/0gUge0OSO4i27i+yhSgc3FvnuehEOp9act?=
 =?us-ascii?Q?aWOjhL648M10Q0FrooXYyWPuGVkCdgtnx1k0HLWwaA7gthzVUajZ6wN1VIso?=
 =?us-ascii?Q?4XKav2N4YSE08U7hh2qsMDLhTx+cV6qIyS+X/vrxHLDYn5/iV4GevWrTWWKL?=
 =?us-ascii?Q?CO9Uaf3ZWmHnG+yZcmavqmNrp5SUQNPvoN8hfG9IQD25bKMYp3vYNjCH/3O+?=
 =?us-ascii?Q?qMj+l2so0f/itKjIxHyy2NETONISr2Fa+IcCtBjQQFHPR/9siFAYBUPvVKyS?=
 =?us-ascii?Q?QS77HZgpBDtx3Q3LRDhAbW7QZBLaG7WIkylsPcBvz8rYEn238vIgd9krK05i?=
 =?us-ascii?Q?h1z2qqkCtWd6Zfg7wYp+oB/6jzUhLg4hq7JBvcAVcWal2tBnfxLBMEn4aZeZ?=
 =?us-ascii?Q?sSM8bJIjbasCz6qMl7bjCmXMom9MJ62fBO5StPoMgyr79ZTeiQQc6H/3OGdk?=
 =?us-ascii?Q?fEhAE5mPQQ4mY3YHXRLSkFhfe57wx36pUnbQ/wSZwrxmGPjkGD6ERfu0TG4q?=
 =?us-ascii?Q?+ejGiXLG7xQwXAwUkw5A0ANm2qS61utzitZJN/emkXE9uXJMJaHce+JtV8pG?=
 =?us-ascii?Q?84Rod1N81S30hAXrDPls9jobmOzHMrABrsIEClYju2mqotoBfRYuB8NGYgPY?=
 =?us-ascii?Q?P2EbdcfZ/15hxNHJ3x9NC/h4VzeMD8GS+SSNhu6ohu9guiXNHCL9mBdgm11q?=
 =?us-ascii?Q?a3siVFOpRP66+1rfxHGje0LJL3ITVprbtj/kU8+ClE1Coe4cPBxkckkPJWBK?=
 =?us-ascii?Q?jZMrV9IT14bkIG2QtZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6ad4b8-3cac-4613-79bb-08db57a68850
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 13:48:16.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZAYyCQ9ygIIu3Q9GGrAmB9npbuUSKvZxaWISbt3kfrzLn4m0P5T6qzdXh/skY9PI6CJPB0MCNP3a2p5w9Q8Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Alexander,

Can you help review this patch again? I have double checked and refined the=
 sequence compared to previous one. Thanks a lot!

Kind regards,
Esther

-----Original Message-----
From: Tong Liu01 <Tong.Liu01@amd.com>
Sent: Thursday, May 18, 2023 11:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Liu01, Tong (Esther) <Tong.Liu01@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough cas=
e

[why]
Passthrough case is treated as root bus and pcie_gen_mask is set as default=
 value that does not support GEN 3 and GEN 4 for PCIe link speed. So PCIe l=
ink speed will be downgraded at smu hw init in passthrough condition

[how]
Move get pci info after detect virtualization and check if it is passthroug=
h case when set pcie_gen_mask

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a9d9bbe8586b..18c6e9872247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,8 +3813,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base=
);
        DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);

-       amdgpu_device_get_pcie_info(adev);
-
        if (amdgpu_mcbp)
                DRM_INFO("MCBP is enabled\n");

@@ -3830,6 +3828,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        /* detect hw virtualization here */
        amdgpu_detect_virtualization(adev);

+       amdgpu_device_get_pcie_info(adev);
+
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


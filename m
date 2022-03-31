Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3699C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 03:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFC210F4D6;
	Thu, 31 Mar 2022 03:16:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D08110F4D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 03:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJUriVaWACE9/BGdlT6iUEJl7o039LxfwCigiH/YSAGBvqL+jiwPj4OIXK1FwOOs7cbhLRSuI6L/E1lR7qj6vYeS68FYp/PZolXdvttCRA6pv+APG8ep7nHENvlgKLYpqBuyAyf7QvLzHuEE9dnCqEexB/1zkgzwfyVbY0MmXBlr/GPpFMv4Rw6viaDQ5qqRpoACcBMmbT+6RoTFqabR2Cp6J2To+3mgcrnTRMq8kmtHZQ6IzZwh493FNe3Yj2hFM9HNeu8s9jR4wESAuSwWYkiCKQDHZ70xuw1gCxIZUolTuU7/IwxnUTSRE9VfWD17Uv5vkpdYmJUqtiCu+4WxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taeAkC2/pa9hojluIz0mZh/e8ktYVzTn7n/cxAvw1Tc=;
 b=dOXQlcjk+/AKDmjzoPWmbLA8nVmKTd7Es/cFAOGxWPgK5gcF/nlWV3VJZG+j9KaKTHCbaKwLCh7wLjCGlAHLW6Ul/sj8frplgzbmEO5f6gH7ByRf++VDWdDqKoMan643HZq/i/nXvqRp+qeaoZKklIEH3qK14MYx9xAj/ljJHbxNwqQfXTuX8x1tJwr9LUd7B4f09SPc5kgBwh5+dzkdCVCZjS1gxNxsJjUugOpvGbwjUJT8EViLHsHymBW316ExY7Mg6RKan1FkW29dBXTEELQ6Vs+p1TOXflzuybJpYCY0Ui+T+Au2ivyADY81lu7+/toyZz840Lt/G4bVYgOxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taeAkC2/pa9hojluIz0mZh/e8ktYVzTn7n/cxAvw1Tc=;
 b=Cq3xIGnChsftWQBwAAmtHr2RLdL1QmXWSsAMfcUqyG7Kdxf5p0NX/fNB5yRr/Y23z7kFDz/QZ+4aU9OmpW4jSqLr49gc4viMvHLDStTgSHu9IxQX1LomCRItSpvXRsaQrnrgeia6M0Xr4PQhZj0cQczdCswTVrAMUoaqGPo4arA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 03:16:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b%5]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 03:16:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: RE: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Topic: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
 amdgpu_dpm.c
Thread-Index: AQHX5/LJ4D+1UL2cPU263eD1r1iEEqzZfgGAgAANK6A=
Date: Thu, 31 Mar 2022 03:16:37 +0000
Message-ID: <DM6PR12MB2619B0D5271592A645F67845E4E19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211203030540.1710564-17-evan.quan@amd.com>
 <20220331022805.17236-1-amarsh04@internode.on.net>
In-Reply-To: <20220331022805.17236-1-amarsh04@internode.on.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-31T03:16:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=35739e5f-1a49-4163-a68c-527cc8084253;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63c4ecf3-eb66-4848-60a2-08da12c4ddf1
x-ms-traffictypediagnostic: MN2PR12MB4392:EE_
x-microsoft-antispam-prvs: <MN2PR12MB439254D5AEE66886E05E77ECE4E19@MN2PR12MB4392.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPiJnpjCIBq84iNE208wcgUJ+YXKjVDyVhbqzfbx6WzoGINzw5/W2Ay4LAZ8cNevNyjRG2yyf40l2c0sUtl1Z882BYgX01U/OfiwROa1gdg32j7kA+9jK9FkvKQTYJn+/fg+x7s4rv4YNqtLIJBLzjiUjFsmRgp0TbScLqSEfLFTggZQm28ADHWhw/fY/7sox/KtsesploehAxtzUbNf3Gid3ED58tb96Wy0qjj+ZAd9YaIDtOaCt3Le5oVjqt5vFO/om8WK/CAc6I6be6LLDnE+8F5eNj56zFaNrjgVwyRAYdFI4pp+Af6KMIwhBhcK/AxXFhtyuK6PXd57u6sIPOeXr6uCRyigL3hr4GbBcJ3cSzdPbymizMmVmW0ZGiOGS/Butg1EV6h4V4zg+hfM8hptbQ/yhFK4YhHGatVzhgol7m/gTMZYfBg1IxGTmkzF/OSJPfyW0hhsoEPAE01vraWyhPOTMSxGqKRgfC/gpqRM8v2/cSBljaWn1YtwXtnltvLLQpaMwcESG7TdcZYxRq47tN4c0wo0wonS+BzK1w9DMzW5SJLi5ukpFXqKjm+eLIpapvlLegaTNWX69XHHPoSa8FAT0AtEEHHDP0GX6bovynaGS3o1qANZLCEXEriCwrsQ5FO7WkvFY7VtMNoS1EggWfnFgHr4Skr+l0DEd4nHeY2F2c2hen1ym10mPBjq2EV6n+COUCMrF7Ul0FKkzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(71200400001)(76116006)(66556008)(64756008)(2906002)(66446008)(54906003)(52536014)(7696005)(8676002)(86362001)(66476007)(5660300002)(316002)(66946007)(6506007)(33656002)(508600001)(8936002)(53546011)(55016003)(9686003)(38100700002)(6916009)(83380400001)(122000001)(26005)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+qocWm6f1Vo2ih/D46WjSYtuNo1WSPWV0d0+l6Ot5D+AiKNBfy4a5J6p+uTi?=
 =?us-ascii?Q?xXDF8g7ySvkOT08ZY1qVqSxElYI4YLwBLcWzkL52CGPI4kA8I2hjAbZSNFnp?=
 =?us-ascii?Q?r6HD8jYHAHKun7C7ViEgCRf37PCkfCwOPvs6b2QSv3p8lss+owEhXXhxi0gT?=
 =?us-ascii?Q?DLKWv5KFXaSsU2Gc4a3XYAc6t6tpWzReFNucl4mrypzA3uWTaZAP2WzM6MgX?=
 =?us-ascii?Q?5DaNZx2npIyu4uBoIjLokRy7vtyUDcifHjksQF6IkF1z90eozeuqDjN5y/5X?=
 =?us-ascii?Q?9BfAFrGthJIZGV/hn6Ex8gH5oMnq+jnn+dv6EkDEPbywzu07V0Ts7kujFcmj?=
 =?us-ascii?Q?27UKDNeg8pTzJPL3ys/QtVkdmyhrdlfs5mNmRtfOLrDl6gXNVMrBA0HGvDGT?=
 =?us-ascii?Q?zQYKCMwyEZ+ANj0588HpatdxeBugxtkYdXIpc5mCqsV/XlDoAGNKYuaGfXqE?=
 =?us-ascii?Q?PPDSlvxFv6+YNHf4SdiirdK4pAl99aOjcn6ZuKfYXOFazHcLjjPOM3H6B8lH?=
 =?us-ascii?Q?Xp+bJM3t4M9DeFffon+gQRM25GeSTQ3s2hMFXBOua6Vu2pOMcnNk96cD/bK6?=
 =?us-ascii?Q?3cYp0v/62HsgdlivGMrlmaZPjXUGBFZRnFnipCcPP7ya8TV0x/u8L4t0mfgr?=
 =?us-ascii?Q?JEOicqlrdOgHlFujm34lYAPCwkgO6ZveCbdJDHmOX0JeNZReDxVnTGBgu1ir?=
 =?us-ascii?Q?ekSoVhpBSyiGHhN0ZEIS3KS9BBrYlUfahl6slc79LQzq9iyxir517DgH/WSt?=
 =?us-ascii?Q?CfnUJt9hRNgbzI3p2MQPAr6jtxCg6mT2488X50ZKTaBlyH+Sdy2db/ArPKD0?=
 =?us-ascii?Q?ueTIgT4+jKpP5ZFzAlxNx/8EttsViWX8kSl49S6ezMszYECvU/bAMENCU90s?=
 =?us-ascii?Q?KscOdGN/i2zM9/kbUvTIKmEpT4nYHtxUvW2Q5eTcyYYNLttFCMhxtK5MCiH0?=
 =?us-ascii?Q?vYw5XSolneCVGxBeFnvHQxmQ810hF3Uf8SytmsdQN2C96nFLvwW6vX2fkI9D?=
 =?us-ascii?Q?8FEzc46QdW5CkbS0y8NOC8+o8rK9wgPJSPTiByejRUj9QoTXu3EyH5Pp4f9Y?=
 =?us-ascii?Q?Z/cjy+hMR9LL7qilbMgRLCpmlGZWvRt/9AnC9qgR/1IO9aolhA9IWEL/hQyZ?=
 =?us-ascii?Q?wRo/kuARsAj/hNEk8/ZFz496z+2IXqjdor6YIL9/3/lNT0EnO9W5B2KZo2LE?=
 =?us-ascii?Q?+7Zooz5Fa5Alq7BXBZrQ3QRPC4HCwZ8gJITf+NnUvyuZVOVZqUnEt8G/io2V?=
 =?us-ascii?Q?WAw8NExZC1Gnmkya55baNDTqlxawBtmpXAP/7pUHaEZjDYJhvTkxTON4flsp?=
 =?us-ascii?Q?gEEXyHYmuICqrpT6JaIyFfuLNEAhNlQ0yQVvMTIDnDwAM3bdzEC49B5r36jt?=
 =?us-ascii?Q?vz6jLG1h/Zc3UP7kckC/bsoaTB8BUh/T0Oc7xAuJYUWL8cEJyuknESyrXRDr?=
 =?us-ascii?Q?Qvbt29ixBSLMqoAMpbghFVYpgG42u8bDFgG84ka9zmz7gI7wxraP58cVi5mM?=
 =?us-ascii?Q?YvedR1QISOXBGJ/asw5clR7HmX81j0bSbqEz1BBVKWpfATuXPBsuw9Hzb5Y7?=
 =?us-ascii?Q?QAp90nPpRJiDCNEno+u694k8ExzYD1OHnQfsnFs0n4vaW1HPaMfxqIWkmiu8?=
 =?us-ascii?Q?MUaJAgZUTw4JvVbqDC7X0DRRsESMZegaCBL0ANaQ72O+v1nJe2/3AUHqJvCo?=
 =?us-ascii?Q?sjqCCSfk25F4ML2CUwJfNx6O7QhAsIMFd1JDPAwvGsbSdqlU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4ecf3-eb66-4848-60a2-08da12c4ddf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 03:16:37.1413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQfts33qX4djJrxjLyUuhNeeCrAqynPZGYbl6Fe3IdBTFXFNe4gldO5Tb9Rskuh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Arthur,

Please drop the lock protection enforced in amdgpu_dpm_set_powergating_by_s=
mu(as below) and have a try.

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index c73fb73e9628..bc2b5d77c3f5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -80,8 +80,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_devic=
e *adev, uint32_t block
                return 0;
        }

-       mutex_lock(&adev->pm.mutex);
-
        switch (block_type) {
        case AMD_IP_BLOCK_TYPE_UVD:
        case AMD_IP_BLOCK_TYPE_VCE:
@@ -102,8 +100,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev, uint32_t block
        if (!ret)
                atomic_set(&adev->pm.pwr_state[block_type], pwr_state);

-       mutex_unlock(&adev->pm.mutex);
-
        return ret;
 }

BR
Evan
> -----Original Message-----
> From: Arthur Marsh <arthur.marsh@internode.on.net>
> Sent: Thursday, March 31, 2022 10:28 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org; Koenig,
> Christian <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH V4 17/17] drm/amd/pm: unified lock protections in
> amdgpu_dpm.c
>=20
> Hi, I have a Cape Verde GPU card in my pc and after git bisecting a situa=
tion
> where, at the time of the amdgpu module, the monitor would lose signal an=
d
> the pc locked up so that it only responded to a magic sysreq boot (with n=
o
> logging due to it happening before the root filesystem was writeable), th=
e
> above commit was identified as the culprit.
>=20
> The GPU card is a Gigabyte R7 250 with pci-id 1002:682b (rev 87).
>=20
> With the 5.17.0 kernel and a kernel command line of:
>=20
> amdgpu.audio=3D1 amdgpu.si_support=3D1
>=20
> the following dmesg output was received:
>=20
> [   76.118991] [drm] amdgpu kernel modesetting enabled.
> [   76.119100] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> [   76.120004] Console: switching to colour dummy device 80x25
> [   76.120203] [drm] initializing kernel modesetting (VERDE 0x1002:0x682B
> 0x1458:0x22CA 0x87).
> [   76.120211] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ)
> feature not supported
> [   76.120235] [drm] register mmio base: 0xFE8C0000
> [   76.120238] [drm] register mmio size: 262144
> [   76.120245] [drm] add ip block number 0 <si_common>
> [   76.120248] [drm] add ip block number 1 <gmc_v6_0>
> [   76.120251] [drm] add ip block number 2 <si_ih>
> [   76.120253] [drm] add ip block number 3 <gfx_v6_0>
> [   76.120256] [drm] add ip block number 4 <si_dma>
> [   76.120258] [drm] add ip block number 5 <si_dpm>
> [   76.120261] [drm] add ip block number 6 <dce_v6_0>
> [   76.120264] [drm] add ip block number 7 <uvd_v3_1>
> [   76.163659] [drm] BIOS signature incorrect 5b 7
> [   76.163669] resource sanity check: requesting [mem 0x000c0000-
> 0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-
> 0x000dffff window]
> [   76.163677] caller pci_map_rom+0x68/0x1b0 mapping multiple BARs
> [   76.163691] amdgpu 0000:01:00.0: No more image in the PCI ROM
> [   76.164996] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [   76.165001] amdgpu: ATOM BIOS: xxx-xxx-xxx
> [   76.165018] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not
> supported
> [   76.165270] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fr=
agment
> size is 9-bit
> [   76.349679] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M
> 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> [   76.349716] amdgpu 0000:01:00.0: amdgpu: GART: 1024M
> 0x000000FF00000000 - 0x000000FF3FFFFFFF
> [   76.349753] [drm] Detected VRAM RAM=3D2048M, BAR=3D256M
> [   76.349764] [drm] RAM width 128bits DDR3
> [   76.349940] [drm] amdgpu: 2048M of VRAM memory ready
> [   76.349953] [drm] amdgpu: 3072M of GTT memory ready.
> [   76.349992] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [   76.350506] amdgpu 0000:01:00.0: amdgpu: PCIE GART of 1024M enabled
> (table at 0x000000F400900000).
> [   76.495343] [drm] Internal thermal controller with fan control
> [   76.495391] [drm] amdgpu: dpm initialized
> [   76.495637] [drm] AMDGPU Display Connectors
> [   76.495647] [drm] Connector 0:
> [   76.495655] [drm]   HDMI-A-1
> [   76.495662] [drm]   HPD1
> [   76.495668] [drm]   DDC: 0x194c 0x194c 0x194d 0x194d 0x194e 0x194e
> 0x194f 0x194f
> [   76.495685] [drm]   Encoders:
> [   76.495691] [drm]     DFP1: INTERNAL_UNIPHY
> [   76.495699] [drm] Connector 1:
> [   76.495706] [drm]   DVI-D-1
> [   76.495712] [drm]   HPD2
> [   76.495718] [drm]   DDC: 0x1950 0x1950 0x1951 0x1951 0x1952 0x1952
> 0x1953 0x1953
> [   76.495733] [drm]   Encoders:
> [   76.495739] [drm]     DFP2: INTERNAL_UNIPHY
> [   76.495746] [drm] Connector 2:
> [   76.495753] [drm]   VGA-1
> [   76.495758] [drm]   DDC: 0x1970 0x1970 0x1971 0x1971 0x1972 0x1972
> 0x1973 0x1973
> [   76.495773] [drm]   Encoders:
> [   76.495779] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [   76.599604] [drm] Found UVD firmware Version: 64.0 Family ID: 13
> [   76.603443] [drm] PCIE gen 2 link speeds already enabled
> [   77.149564] [drm] UVD initialized successfully.
> [   77.149578] amdgpu 0000:01:00.0: amdgpu: SE 1, SH per SE 2, CU per SH =
5,
> active_cu_number 8
> [   77.456492] RTL8211B Gigabit Ethernet r8169-0-300:00: attached PHY dri=
ver
> (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
> [   77.486245] [drm] Initialized amdgpu 3.44.0 20150101 for 0000:01:00.0 =
on
> minor 0
> [   77.521555] r8169 0000:03:00.0 eth0: Link is Down
> [   77.547158] fbcon: amdgpudrmfb (fb0) is primary device
> [   77.591226] Console: switching to colour frame buffer device 240x67
> [   77.600296] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer
> device
>=20
> I can supply extra details but found no logging from the sessions that
> experienced the lock-up.
>=20
> Regards,
>=20
> Arthur Marsh.

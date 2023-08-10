Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C18C001DB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 05:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C7F10E4B4;
	Thu, 10 Aug 2023 05:46:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6572210E4B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 05:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/KG7YtgK2qlMBohX+p7KDHsveMwHZ3Mcj6PxHVZONeHAv6URJmZou16uyvUuq2HWtGKrolgY1VRBXse5N1lzC5WUBxJkq7hulDX8TxtaZwhM7230PzdZ4tckH/dA9jTXAvmhuaNR+01yJBloPO/1gjEBL2fFi6E8170japA7ayNA8vAGp+VLUor8j380wr9rocjRaotswP53kyQB/GDYEHuHruuC1Wm138fwNStAWT9A3EAzpp5XXVxmm4qtIcoY5jVLE/AjYapg11pc7qeGn0g6HxZnLI7ltkRnBB3X+Q/VdJVWr32ERqyLMDyzEQL+8xT4olbqmktqy8IrAjo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZBhZUwrQ0Ko3dtggxznCSveh1VG2cFLELprwIwHm34=;
 b=E/crmnQkwxNyOmLU+R5YaDmlu81knFbAuTTdUtyiHujY5A6UdU2B1oHnFc142Tr7lsV6ZYo8H4nwkSwqEzYB8B0ZnY3cE/V3ORe4fCivuXTGEiziuIpeRZYknrtcdogeeJXPdCXHIaXOFGQVsvxh0ooQjPT1+ABFDVApqQULg0rENrl7zdN+fFqXzNr4lD0DTr5T4tcU4RyIOsRCcIPMbVhqHPSr7W+5opZ0lj62xtq9sHAfegCWzGl7LXGafgR9p4hpbsr0qHTMXnE7c+M/A8ptoW2hFiI56f0LqIa+MziS6vtXzQPsQ+I2ZVgoxuj5VT5KrKcyDkx3fe1+H6+Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZBhZUwrQ0Ko3dtggxznCSveh1VG2cFLELprwIwHm34=;
 b=mByavtFNs+lJ7S5UqN+H55hPuchR+LEZgEGNMTinIYX0VQEWPOTlJ1JP1G+sLvQJZVnn0yqmHHEohp/nSLsrOyeYqMwpr5OH3cmM3gGZ277OXLl2PWQQPR52ztidlOpQKyqsJt34BKk8uXoMs4fIoMsXTJdirHUbFO2G6Efic8A=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 05:46:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:46:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Topic: [PATCH V2] drm/amdgpu: mode1 reset needs to recover mp1 for mp0
 v13_0_10
Thread-Index: AQHZyy6imwoaOpUdk0+4aB3rpPCZFK/jBbBA
Date: Thu, 10 Aug 2023 05:46:53 +0000
Message-ID: <BN9PR12MB5257C73B9D9164AC8A009925FC13A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230810020116.3942335-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230810020116.3942335-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=885c0ca9-6efe-481b-837d-395e30a932fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-10T05:46:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6116:EE_
x-ms-office365-filtering-correlation-id: 0140de0c-9dd5-4047-463a-08db9965339a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YLTTkzvLKnPG5r3rp7azgYWauCEjZLHhvgPjgTqAN9qiOzn2dR50UOaKf25TjawXGbKIeZAxUV8UT75lHfT+5opnEQsx34mQ54wTvou+0Q2z0UgmDHRI0+xuApuygt4FN+ljXFJx/OzmokUQdQQqZLcnuUwqTXm+3tug16XXdK7jLfeW4rP/nxFy1Fg7jDdsDatuHk8CxC6XU9cBBjlWMfReUENEBrvoPz/kiRemMF8htEif8YFXbQOWglc70ogpp3av190Al263cK4RN52CMsn3LDrXSZrYSvW6IfWOd995tJH+mPTkbuuzjnDdgAPv5vutGB8HsUzftU4hkxuX8StlArtrOXFpGd36FbhgJyBufCa3oPnJl5VRANlcb1FVHns0rl2MPN40Ykmad98R1yltrfFmt3alIGo3uUcu7C7PHWzleyxZoQpTqZsptEYn+oi/PcVhZMYeO+VrbDIoR63F4vMTZSsQSDOBOk7Ga1CijxIPfWsRv5ecl7ByngiVwKwNcl2zQ0zmqBXGrQww5YjfHOMh+cgarSomtN/f+TzqXJ6a4grAsbzKdoVDDHDlOQ6zf8GgNV6Bx4vpcI08qWCle+eUf7KnQhl0VUXZ68X2cVU7/GKhqANUMDU67me
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(1800799006)(451199021)(478600001)(9686003)(71200400001)(54906003)(110136005)(4326008)(52536014)(66946007)(66556008)(76116006)(66446008)(64756008)(66476007)(316002)(7696005)(5660300002)(41300700001)(8676002)(8936002)(6506007)(26005)(53546011)(86362001)(38070700005)(55016003)(33656002)(38100700002)(122000001)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gAneKXRutR9a9R+C6Sp/gAwDBvT7+YtR5r7TEsUZZr/6Typs1fviV6+Et7aJ?=
 =?us-ascii?Q?0n8CjEr74i0o242a0sFewr82vrPVueCZLPhDCMszkcsEVaEU+k+FDQ3j+0ss?=
 =?us-ascii?Q?WlSAhcrnQ1nXEVeZ8q2+a8Rn5jtKlFht4Kh73NLV5fjcFl7dvTeAM9tfT657?=
 =?us-ascii?Q?TM5jIDZ1A+6TV/BPsoT0AL7VHMol+sjsJpGdpiPBf/4XCtGrUvTa/WORDlNt?=
 =?us-ascii?Q?69HRZR0WJlZbINu7DeV4K7m6NGE/Hi0DZ4pTY5chaQqvJ9en438EM9IMDjoN?=
 =?us-ascii?Q?F/E4RlaoKACuoVDVdti6WbcEenb8Nhei2wxMHr3u/irHRbtf18FTyd8zUUzI?=
 =?us-ascii?Q?pwnPMzfRqGye/U1Sj8SblSsC60uY5vNgtUhd+6gWOiUILrbN0Zb17m46ndVu?=
 =?us-ascii?Q?w2i/UFooiF5TH5m+FyBUkk3DqGk7/RE5oOCfGISLlUbmZVJpthY894xFaWCG?=
 =?us-ascii?Q?SFUmJjG5LLl518p9vbTFQttAOGRN0W0UX2fdSgcYd66fhC92KXUK109TVFld?=
 =?us-ascii?Q?4nyZjmlCAd85m55NTU+kbM23Sjd6jOUrDnWBTDqBNL8T6AR6AKpfFPOTdfHK?=
 =?us-ascii?Q?+5rW1ABA8WM5jAjEq4DjJQGf5xX0PdDS8BrgM5itOfqNmKeaecyzkxGHYjsh?=
 =?us-ascii?Q?6KMova/NGF+teCypFJMCM+lg+hjPt0xWdMIIS69Hh9eya3zGR//97WedhwsK?=
 =?us-ascii?Q?UTrX0amF/89JCVoSDWpeHLIClyld32CbD6YY1nX6fA9gUhFQOHo8r7pKD1Tj?=
 =?us-ascii?Q?e/Katz3hNt8stGb5lRb4/3dTNx04QPg5QQZqWMKJii98QI3TCOTIcNdR+Kx2?=
 =?us-ascii?Q?UFgl49wUJhR5bKM0bWXNL7rXNSi6AO88eTOOj0PFvsg2vJzvkwQ3GJ4ZMUnA?=
 =?us-ascii?Q?Jz8YWo+sZ7jrXlbSDynh8XZ9dH1MYAuX+iXIvsD9LnCcZI4L3wWJoaH/7Ota?=
 =?us-ascii?Q?GBwz8G04XIrRMNZG2o5lduK1IfTmc1sxxLmfzBnUScl8cruK7n5940ETpO2k?=
 =?us-ascii?Q?/ao5QQt2hDpwWK2Ez20KUeeyLeIRADOznQ9oAqOjBN/X38IgFngbIpiqTeNk?=
 =?us-ascii?Q?EwUXlECDP+yfA1wRqqUZy5te0I8umWQFnXBAh5R9g4YZpSaYJoam5ul/6tlu?=
 =?us-ascii?Q?+7v1LhD/lV/Ya2HB9RmqaAXGzUMmmX1eosT3K1Yx1TkRV9Ayn46dR4hDeRDw?=
 =?us-ascii?Q?IC18vFZfY3SkP+21VXHBkfvQ6XvgKLelz2T+VpyDBfxfo3SOHUBYez0qgDu6?=
 =?us-ascii?Q?GqeVIbWXLdw3gQhkBDQYNGzwioyxjADZtbPZsIFjTAqvEzbxH5omb2AepptT?=
 =?us-ascii?Q?Z6uqqO1Vl/qakA2oomElAUJlj4c2MC3fbHIhPjpAZYtiygzMV63Y2FTzh2jd?=
 =?us-ascii?Q?FBRJ5hvnUvAqSpufKaPQ+rzuUvkoM3/0GDd0rm/SA/4DbsSjvJHATG/SdU9g?=
 =?us-ascii?Q?0ydRAm4RqEG+S2z5klKrA7AJqxFuDiQeZOvEC8MdOhA5Brav+XcbU4KZywlb?=
 =?us-ascii?Q?h/D8U/2znvQEdPnzH2Ip3/8nKItB4yZiEKzZrZlmcqtw4qUPxN9IIAN3xA7l?=
 =?us-ascii?Q?8XfgzNAsX84JWVgZRqOoIj4sLGTChi7141bxb2FJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0140de0c-9dd5-4047-463a-08db9965339a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 05:46:53.9081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFIrgFMxADnVynwQ9UD0qG4PuK6B//6SOlgMLmv+pmyel36vJP0IIQ4pc8y5vGWvlLcTIVNpNTi8mOub+Nc1cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, August 10, 2023 10:01
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: mode1 reset needs to recover mp1 for mp0 v1=
3_0_10

Mode1 reset needs to recover mp1 in fatal error case for mp0 v13_0_10.

v2:
  Define a macro to wrap psp function calls.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  5 +++++  drivers/gpu/drm/amd/am=
dgpu/amdgpu_ras.c |  2 ++  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 24 +++=
++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index e8cbfacb5ac1..520a0fe1daca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -135,6 +135,7 @@ struct psp_funcs
        int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
        int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_ad=
dr);
        int (*vbflash_stat)(struct psp_context *psp);
+       int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 };

 struct ta_funcs {
@@ -449,6 +450,10 @@ struct amdgpu_psp_funcs {
        ((psp)->funcs->vbflash_stat ? \
        (psp)->funcs->vbflash_stat((psp)) : -EINVAL)

+#define psp_fatal_error_recovery_quirk(psp) \
+       ((psp)->funcs->fatal_error_recovery_quirk ? \
+       (psp)->funcs->fatal_error_recovery_quirk((psp)) : 0)
+
 extern const struct amd_ip_funcs psp_ip_funcs;

 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block; diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.c
index 50c38f75769c..1010d7ec03da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,6 +2066,8 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
                        if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E1_RESET) {
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
                                set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);
+
+                               psp_fatal_error_recovery_quirk(&adev->psp);
                        }
                }

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 58db1ee631b3..10b17bd5aebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -691,6 +691,27 @@ static int psp_v13_0_vbflash_status(struct psp_context=
 *psp)
        return RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);  }

+static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context
+*psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) {
+               uint32_t  reg_data;
+               /* MP1 fatal error: trigger PSP dram read to unhalt PSP
+                * during MP1 triggered sync flood.
+                */
+               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67);
+               WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, reg_data + 0x10)=
;
+
+               /* delay 1000ms for the mode1 reset for fatal error
+                * to be recovered back.
+                */
+               msleep(1000);
+       }
+
+       return 0;
+}
+
 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
        .bootloader_load_kdb =3D psp_v13_0_bootloader_load_kdb, @@ -710,7 +=
731,8 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
        .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
        .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
        .update_spirom =3D psp_v13_0_update_spirom,
-       .vbflash_stat =3D psp_v13_0_vbflash_status
+       .vbflash_stat =3D psp_v13_0_vbflash_status,
+       .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
 };

 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
--
2.34.1


Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D80C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 07:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B38C207B0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 07:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B38C207B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E87892EA;
	Wed, 30 Dec 2020 07:42:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FF2892EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 07:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUPmGl+inSyXtwOP0rVz1w+mmaa/aFPwxFF+ewhd5JCvN4ul2rhHCGYRo7Fvz9Mjh06fIxGhY2zH/TA33o42KpvmZsdGcmrWzRzl2GeYYtWT/u1zkDO3jtBmnpMlp01ZSwvYSm+sfC2XsR57x2/9RPlLhFf4GvX3xHWh8g758bxWiVoSvyaevN2mk5T9EcfFCKD5QQ7m0XS//IgGqEuieTQUHFiYqGZniIakIqeBDtWA/1jEjac2pk9uC9dtesKeILRT/gXUL76Gl8dyjJ06oAxuIMwKQQF9gUQDJwJHawd6dXkvXBAFH5W8tSCyk2AsmXOizYKIdFXKHhReR8yqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uUmL+b5RYvJaPDLAI+FG+WP1EQi5ajSrpspbCC5iQ=;
 b=RC/FcLy3V0NwwOFpzYieN0b3+PkYgvZa9R0QVkt8Qck0vISh32anxyN8RpmEVF4YWH8Y91PIZAodiQ/rOS5RjQnV307T4LBhv30rzkRVuoGfTGqwF1DqpXhOITXM9elfATN8hxQ7L21nX8NutAXbyaVDRwVAZbLPKuIxJj/aXJ1fSVs5v7MZEBacBci12hrWETqU8ISbIFUjSGa8w1IWgrYffwdEpRBYs83cYsnpwHU1U/RYWy1i7UAgCPmdzBesB+sgeLtm0KJMtTjz5B6jkQlFgDmDo/Pl2iU1PiSvHLWnzGv97KBWs3dAzrXdpLepcrAVf7UuP0/4+S98wqd+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uUmL+b5RYvJaPDLAI+FG+WP1EQi5ajSrpspbCC5iQ=;
 b=wGhZSybASGHHD+ivxiGWfv/E4+duAYXQJdj0ArVt7cPo3PEURuueIcEQtvxDScHZSOrMSS+4z3ZUWJmuAtMjTdc4Jbt2nVHt3dlpCxDEuGgjG/wQy94MMuP0WkDkKgfJDqQpsvA4zDT2EOIO8FDRkwxFbXcLXs+gyAXu4DZNpuk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.29; Wed, 30 Dec 2020 07:42:47 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 07:42:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a memory protection fault when remove
 amdgpu device
Thread-Topic: [PATCH] drm/amdgpu: fix a memory protection fault when remove
 amdgpu device
Thread-Index: AQHW3ndoOIPFAG2ORkCByOPrEO2oKqoPQGlQ
Date: Wed, 30 Dec 2020 07:42:47 +0000
Message-ID: <DM6PR12MB4075FBCC144D20FF01431B56FCD70@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201230064534.6224-1-Dennis.Li@amd.com>
In-Reply-To: <20201230064534.6224-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: John.Clements@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T07:42:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=559e6f34-717b-4bc7-8219-82b0cb39aa01;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6dab1d9-1a40-42b5-fdd8-08d8ac96809e
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31779E1E550FA1735E8BB995FCD70@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBD9PpkQ+5G6BCHMICf1Kouu+T6aTcWCqGgm6xcIPAX3NahiclZb2c4j+kMlMgkoXvRqUfMJywQOtdEZUCicId9VxFzjhDZc6JHCiWYbtXyoFH88kB+6F0/NH4w87gJRb9hWzqnfxJOrRmL54h22x++3HMJ6UBjrYfZttlhWuOOXTxrh2a0Y9HhUQOINXoeFDZ11qfRxPt6E2vcDU2uE+eGoeByAvFxe0ZULt+OZ5Z99qPI1UPJ4JiPqmu/uV63rVi/Y2aRZVuUegOiQXZ90OVEnV5dj9I2c3Bxf7VkqKDpN6s3jS7jl8sdY9aiSjfjGA9RHSza3WvPbSnf+dZayXcQHngopL41NvW+79Z3+Uw1Qwat561ZAZusLR3f4/hBY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(8936002)(76116006)(83380400001)(53546011)(2906002)(6506007)(66946007)(7696005)(33656002)(478600001)(4326008)(66556008)(316002)(9686003)(110136005)(6636002)(52536014)(8676002)(66446008)(5660300002)(71200400001)(66476007)(55016002)(86362001)(26005)(186003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6c5AB9YuEr7IOMUCPmVaQjKUN+dw17MAvn1ZiTZdwB4wxXpkfo6o8tKM1wIn?=
 =?us-ascii?Q?HlMvx5MrdZKWm3e0Jeqa1j/HEfgYo6ydLAvu6nZovbr0d5JFHIV1XOqbklpb?=
 =?us-ascii?Q?0EFbHB2R/LEYNgV6F4sBuUIdMAhQgZqjLkdG2cr1e1uhL7lxQ+JJM5Qy8OOl?=
 =?us-ascii?Q?eB/WPhUYUaJ72CCeXnt0J9j9/9xQxRedk9yPrlUPDsNAvvkRG3oxIWKYUhbU?=
 =?us-ascii?Q?TiDrqjWQ/NDtd28/h9AG3OPpphaRnl+7MRoW921SvkzHrLVlbrLLEZS8TAcs?=
 =?us-ascii?Q?Om0WI3lA5k2TQd9pBPaGP7yEqrGsKrLh9vUg6NLJpW4mT439kUVMn3nULtna?=
 =?us-ascii?Q?6wVK4YC5RMSKZJPyQHXItvx5U7zNfAL2k24mVfz7tj2mMQtanawbE7OAWO/N?=
 =?us-ascii?Q?HOgJWpzQ54EtRLDfGd4Vj/SpMYprpM09gyMmKuU0SNQ5CSFTGdFx5BBCK7cW?=
 =?us-ascii?Q?wBPVAOtYGXVD2aRybtbqJEce1w1K5fFjwgE79S6+LqqxJDX2GUEAlgtIG1QG?=
 =?us-ascii?Q?yoZT5ytxSiHddAwHGwP094EMrN5QaFXw89PBIsnxthw2T6CD8lxGK5bbHBUk?=
 =?us-ascii?Q?o4BPAG737YpZ3uzmy6/QHqR+9az9/okgVaq+2QiDFXtW9Y/LEfbpRIUVMLRj?=
 =?us-ascii?Q?Iptal3kZH+ah5ZGieNdVXidnjiYZSuZjhZqhtixZfyXzMQVBZojjSBk3KyKV?=
 =?us-ascii?Q?y/5T4XVH5QZJJkWw7GksRE7rvprJ1LZWjMbNiuPxeTaw6HuuR5tiSImmav1B?=
 =?us-ascii?Q?7zDNM/23wIR6rfwS1i9VjE3Xhj7p639iZkR/VFUsaxNxsPJTAGor4bmS6o8t?=
 =?us-ascii?Q?XzBo+HWL4FXNHD5EH7Jrw45hvnysQLrcas02PSgjPzwQoE/9IbmegIpusta+?=
 =?us-ascii?Q?UiXv5Pn11btGZc71zkWrZ918n/6J2GWcRMzF1PmscpV1nWBeZM+N4bmn301F?=
 =?us-ascii?Q?qDQImhuO4x+ugYZiiPe9+ZV4JP3kiS2sJJVdv7/c5Zw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dab1d9-1a40-42b5-fdd8-08d8ac96809e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 07:42:47.5273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwVaAgiGnzE31VNMqjSLrfA4wpsQCFuFGgfqaYp3DdA+fHHCGWmc3TkLCUGEsrVZoKoGRioptVUHeo79f0TouQ==
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Dennis,

It is a good idea to leverage asd_ucode_size, instead of asd_fw to resolve this issue. I'm fine to go with your patch first. As a follow up action, I think we shall consider to retired asd firmware related members like asd_fw/asd_ucode_size from psp strcutrue finally @Clements, John. It is in high risk people who is not familiar with the background will refer to the member and ran into issue again.

The patch is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, December 30, 2020 14:46
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix a memory protection fault when remove amdgpu device

ASD and TA share the same firmware in SIENNA_CICHLID and only TA firmware is requested during boot, so only need release TA firmware when remove device.

[   83.877150] general protection fault, probably for non-canonical address 0x1269f97e6ed04095: 0000 [#1] SMP PTI
[   83.888076] CPU: 0 PID: 1312 Comm: modprobe Tainted: G        W  OE     5.9.0-rc5-deli-amd-vangogh-0.0.6.6-114-gdd99d5669a96-dirty #2
[   83.901160] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
[   83.912353] RIP: 0010:free_fw_priv+0xc/0x120
[   83.917531] Code: e8 99 cd b0 ff b8 a1 ff ff ff eb 9f 4c 89 f7 e8 8a cd b0 ff b8 f4 ff ff ff eb 90 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <4c> 8b 67 18 48 89 fb 4c 89 e7 e8 45 94 41 00 b8 ff ff ff ff f0 0f
[   83.937576] RSP: 0018:ffffbc34c13a3ce0 EFLAGS: 00010206
[   83.943699] RAX: ffffffffbb681850 RBX: ffffa047f117eb60 RCX: 0000000080800055
[   83.951879] RDX: ffffbc34c1d5f000 RSI: 0000000080800055 RDI: 1269f97e6ed04095
[   83.959955] RBP: ffffbc34c13a3cf0 R08: 0000000000000000 R09: 0000000000000001
[   83.968107] R10: ffffbc34c13a3cc8 R11: 00000000ffffff00 R12: ffffa047d6b23378
[   83.976166] R13: ffffa047d6b23338 R14: ffffa047d6b240c8 R15: 0000000000000000
[   83.984295] FS:  00007f74f6712540(0000) GS:ffffa047fbe00000(0000) knlGS:0000000000000000
[   83.993323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.000056] CR2: 0000556a1cca4e18 CR3: 000000021faa8004 CR4: 00000000003706f0
[   84.008128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.016155] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.024174] Call Trace:
[   84.027514]  release_firmware.part.11+0x4b/0x70
[   84.033017]  release_firmware+0x13/0x20
[   84.037803]  psp_sw_fini+0x77/0xb0 [amdgpu]
[   84.042857]  amdgpu_device_fini+0x38c/0x5d0 [amdgpu]
[   84.048815]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
[   84.055055]  drm_dev_unregister+0x73/0xb0 [drm]
[   84.060499]  drm_dev_unplug+0x28/0x30 [drm]
[   84.065598]  amdgpu_dev_uninit+0x1b/0x40 [amdgpu]
[   84.071223]  amdgpu_pci_remove+0x4e/0x70 [amdgpu]
[   84.076835]  pci_device_remove+0x3e/0xc0
[   84.081609]  device_release_driver_internal+0xfb/0x1c0
[   84.087558]  driver_detach+0x4d/0xa0
[   84.092041]  bus_remove_driver+0x5f/0xe0
[   84.096854]  driver_unregister+0x2f/0x50
[   84.101594]  pci_unregister_driver+0x22/0xa0
[   84.106806]  amdgpu_exit+0x15/0x2b [amdgpu]

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: Icc981a421499dff844855d5a662e91d1730c2754

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..b44b46dd60f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -564,7 +564,7 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_fw)
+	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
 		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL); @@ -2779,11 +2779,10 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 
 	switch (desc->fw_type) {
 	case TA_FW_TYPE_PSP_ASD:
-		psp->asd_fw_version	   = le32_to_cpu(desc->fw_version);
+		psp->asd_fw_version        = le32_to_cpu(desc->fw_version);
 		psp->asd_feature_version   = le32_to_cpu(desc->fw_version);
-		psp->asd_ucode_size	   = le32_to_cpu(desc->size_bytes);
+		psp->asd_ucode_size        = le32_to_cpu(desc->size_bytes);
 		psp->asd_start_addr 	   = ucode_start_addr;
-		psp->asd_fw                = psp->ta_fw;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
 		psp->ta_xgmi_ucode_version = le32_to_cpu(desc->fw_version);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

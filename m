Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D494E6895A
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CAB10E177;
	Thu, 31 Oct 2024 07:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIA0/Mlp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C207910E177
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 07:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvlS3gc6wTQe7kI+FjV9rYOE6IAxh6cWNLpBNzt3388js+Fp3yaYtoAnxsRKOB+VyG52WJSph4Dd+fHvaP8Tm4Q6iS4w0ouHDUdL7kLWB383VBCHYcEZHloLdRcsWI2o0wXnXmvz0H06gP4glueYEWwJr0Vd+s3I8ZkdAtYEqWjlH/G1pEUcRQX9zQhcfTj+KrefnETEyqqV67IUgj11AFOPvWVGi0rMRf5Q7UN1GZR68rk5Yir2x75ZyOPlLhO9kYdItrtX+4Kvvt2R6AMbTCdIcVSrrDMoOP3QIq6n/+7NWbXzAY6k5RW5rIuY0rtXH/zea6+PrFIRe3ohtjsftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQHRYII371BdWIrC36oGxBqyfw0ybgbh0NQJgXOwJws=;
 b=W+YRWiNzCqDRs8xxTEQPs1xGx5xqUxDD5pE4MO1SbtwxiOZQQvKAv2ociuL0f87Rzehjvpx56pzg3Y2JtFxMx1DjWnQ2fkVSydmltg1Gm1wQ2U1xukfDvIXsK8n8Dsjn/hCn2lkBUw5nS4yLLw3K3q3KjPpWklKB6p/zmrYkzS5Z3Dfzs6gnOzvYldd2XFo9aR3eCokmyqypJt9D4Cdc9OVsfe2Vcq9Zai3Yfv2wQPUWYQXhPe1rCOYEK8KBJb7PSEAwuBEouj6zQUyIpVtSJ9SF7yPVMaFPmbLGbdVLtC/xlXTmbwM7j5Nm1hnN1vhlhqVxUd6RGs6qNTgfd/gmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQHRYII371BdWIrC36oGxBqyfw0ybgbh0NQJgXOwJws=;
 b=lIA0/Mlp7NwDiN7K0fDf2ZphBWH5XK2fLGZqtvfPE4ecQ0iRJMYnP8Nej8pahqZcCuhM9hJQqhCdMdoHbP47tRKmg4U5Da1o1RK7aFsL6+XhLpgT+CVRSp01jIKtA5F40SDzClTXalDPPdHcbkUk8IG3nZ5pPUddZiFjHuvf/UE=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 07:44:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Thu, 31 Oct 2024
 07:44:49 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: set the right sg limitation
Thread-Topic: [PATCH] drm/amdgpu: set the right sg limitation
Thread-Index: AQHbK0U+ar8AhCSi5EGcb4EFkKVYKLKgegcC
Date: Thu, 31 Oct 2024 07:44:49 +0000
Message-ID: <PH7PR12MB5685D364854DA2F6926477C183552@PH7PR12MB5685.namprd12.prod.outlook.com>
References: <20241031032936.118005-1-Prike.Liang@amd.com>
In-Reply-To: <20241031032936.118005-1-Prike.Liang@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-31T07:44:48.958Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5685:EE_|CH3PR12MB8308:EE_
x-ms-office365-filtering-correlation-id: 7accdae1-de5b-48a7-618a-08dcf97fe5c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8vvpEES6wR4Q9JKVnfyhHu5JrYEoKgIO/iQrUYlKt2Fvnj5vtgUmz1oeV7?=
 =?iso-8859-1?Q?bi4FS9redUmmqi2NFacPOGgKVPR5Jr959f3ZdTLfof8PozZSapiV74CMXt?=
 =?iso-8859-1?Q?4ZkPZlAE8bFzVlL5Srb9d774NVTTMdtdGs9ShD1h3d0QF+G5y0Ok/QxPTO?=
 =?iso-8859-1?Q?tBe4CQ0i6rt5M2ocO0RtJ8+OsB4aXMoNmCa3XJGQytpYEojqjeG//zi4at?=
 =?iso-8859-1?Q?uR98mJtdHiBxhxV4yM90eVtbTLuO8q591qY2NNDU++VkaqGffIgy/nRdQl?=
 =?iso-8859-1?Q?A503vCdrHI9m7hjVDZiBwr1wGHbV2hm9EFnKQffZG1jSp98KtmhOEUuRQ7?=
 =?iso-8859-1?Q?6ncLaz57YuzlsisH4BW1R5urqNy1mlw2sz6BkDq0TwkEoVWCmIeiLLQ2oG?=
 =?iso-8859-1?Q?1LdSXGyHA9xsmUsfkbYNBundZqx0xtecjRfWUH+upq9vR9mGOiqMTnAITm?=
 =?iso-8859-1?Q?mdFt4tXbQfmX0tolutZawA5QXITn1Yi1gqit+GWcoZrMECMfVQbhpPrcGl?=
 =?iso-8859-1?Q?V7DCWPeAVmCwwmtZ9tv/WzC6Gq2QTGad4Ab6VH15SeWaEGTcvfM9vbQBvH?=
 =?iso-8859-1?Q?7xQGI+Ojlc0cUNgVY1YVnLuWZUuIIvbbFhVtt5abfMCG+sHOe80BiUjXJ4?=
 =?iso-8859-1?Q?wfvI+zRufDWXhmOfChRv/A8VKPwvtEkqunuXDfHlaxAPas0hboCcdz/csm?=
 =?iso-8859-1?Q?qolDEqrYQ3D6sttsGmavoTyKcS4HPJ5Va3iH5JXXKW7IfjwbicQ5m9sn8Z?=
 =?iso-8859-1?Q?CTbey66uATF9CkbCM5t6M9+iogutLB514MQ+lcUmaLjgW8GD2sP3x67tgd?=
 =?iso-8859-1?Q?2Bs4SjXBT0vwyVfd0QbAVU7UdbdgrMJjwgtKg6q+t+G+wqvCK260ChTZgx?=
 =?iso-8859-1?Q?rhgFxwhphkqdToYoY3dHO/tK2cnZeYtaQRw1ib9Iy8/whoJkF2HMQY+gGk?=
 =?iso-8859-1?Q?SX2gNUfI4nQXxOzKr+XpxnrCAJ259ND+MUfjy1xsJPyumYhW+tX6Kw9kl+?=
 =?iso-8859-1?Q?zPeuRvBZgEjbQrAPCJx0Z9DVMZP3vu6zmAA8tq9VqFPcGX9aX5Et51YiTO?=
 =?iso-8859-1?Q?eV7B1NSsybnZBtOIPqZxvSFLnEGW9bT+qJS7B5VRyf9iffwq3EFHnujaS/?=
 =?iso-8859-1?Q?QyRKq2HBUbB6YL4wILfeSuZVbgCpph6e//Ic4eK5v2B/LfqgrcdJMdmoPM?=
 =?iso-8859-1?Q?51o4BzSPrupmwzoI1uhfkKU23oLwEiIaHuG3yRy1lDchzo+DxbQpRTaG6O?=
 =?iso-8859-1?Q?ZHHJ+QoQ7BVGz6zkX6MipwvbtfDeAom82DGUVD0CRyh4SiTLk71qLP7/VW?=
 =?iso-8859-1?Q?U005B3QeOCaJwh71DpKqnjVNx891LZoVXEHf34fc4SbYYdx4ZRQSvSbqJT?=
 =?iso-8859-1?Q?LMgeYtWZ1imxSEsr8DafXKL7YlJWeU5d2wvE7cLDRVI1G3zOqwk2U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OzVIa6NBMHoJwPO3lSRonIsMVIeChD+gg17Hq8BUsDdeufxutQicHWjT+J?=
 =?iso-8859-1?Q?FkW/W8PEQyRbVha0Vs06zPxvkwD8rPI25UBH+MIanJz3J8FjOENYW4U2gM?=
 =?iso-8859-1?Q?7c8fH3ot1UsykFMwU9aMfq/t2RktjXGqcc1XQO0DDT/Xo8McDCIcf6X0QQ?=
 =?iso-8859-1?Q?s0ARfryacagtdF10VNih5Ti7WRVGDdcT5+HSKAHq5g27QiROZUAZa6KT33?=
 =?iso-8859-1?Q?vwi9yCjwePpXsG94+Nko8KEpuAOkIXbFYxaOs1LPUK0/urIodXZSSKCcZW?=
 =?iso-8859-1?Q?jNFHrF+KrHzWDmrH5kj/g1gCRFU2M//IbvAncGTWwWU+toffwCQZejCA79?=
 =?iso-8859-1?Q?823+qLXU2XNxkVDIDO0NuRTWEmNaT4RzuKK2DNXOGVnaoMOIjqKLtmd+X5?=
 =?iso-8859-1?Q?0wcgD3hbJIMTanZ6AGvGYD/JozsbsdjmqxLZLs5PYSSGXL4gRgbc9QsKBx?=
 =?iso-8859-1?Q?juV6T12DT9xifyKE7Wddiz0YFq32AGevxcm0mOPkFniFO61nR5ZuCDuGiQ?=
 =?iso-8859-1?Q?l9tWy+FM3PhWDpXM/qhWpU2Hl87MymxgOLWcN3kMI7LHByZgnklTxBgR7I?=
 =?iso-8859-1?Q?UWwbypTqpz6UaELmqU9yxnvT+lK/M93WgLnbnTwmkgksVYDt64AATJSwG+?=
 =?iso-8859-1?Q?arDA0gwtysUvZr7MPAQYs7qYW/Ocw0aGNXyquCpwyjP5iOaE9cpZlaDdjf?=
 =?iso-8859-1?Q?r11zRHg96VYXojB5/cRfZBkEy9WvKwp8dTBGuSrqO1Zcx309FNQ+GRqBFC?=
 =?iso-8859-1?Q?/a7Lbge4Z0lKcKG3cJETr9YPKziYAQ9hwHT0IHKXu/66dov4MN6YxweRVp?=
 =?iso-8859-1?Q?4Wy7Ud0LGZ8rAN27qPGSdArgdQh5n22t/+AOa+DgSB72GK69OEUhZC+TKR?=
 =?iso-8859-1?Q?L7FnKt3taMex1AnRaVd4nm1MH5peZ3m3s9XgolEgzTa6s3zIkPOjj+5wTt?=
 =?iso-8859-1?Q?m++q0boX97ES7jOgbQdwfSK3hIo2Mk4f7cyD1AKJ3I/C9ZWkxagdxlt7Ok?=
 =?iso-8859-1?Q?BoE2gCEXk80FgrbZRhW14LDlYaDA/Pp1xJAavTvtGEw11cfc5j20T79FKe?=
 =?iso-8859-1?Q?6bfP8BYSlTf6G8+W4DcDatX6eYuD8hlGHRPXOIpbhUBjzmSBFPgMNHiAGn?=
 =?iso-8859-1?Q?WubHWLTSWR/tOfBT7XbtItnL47kEzQLiQfCPTNxLvXXv+rJTSlWo9A6NdJ?=
 =?iso-8859-1?Q?HMFeSzrp2msSZru3868mPHk/FEBTDBlBdmZnsPfnDJfaKjOtCYiORM/PZs?=
 =?iso-8859-1?Q?9eldlpzAXpzCC5q6d1eqJsxfOz/MPe49R+CazLKRX9/h3HSif+DxcUvhqf?=
 =?iso-8859-1?Q?FQCm9m1nmr9MUSZ+wgVa/6jY+AGgUwALR6ZrmuNqLQ/Dqi6crV5qWfB/gH?=
 =?iso-8859-1?Q?F1LmMiBPzxxCbmF64nJGSu8pEBVtJl816K4PFrPoxM1BQc8+58vrLrnxTu?=
 =?iso-8859-1?Q?MYrE0BP0sUgHjQbHclFxabGIPXDEw5IVD0f/ZDxzZiTwdY+8yO/KqlBcpl?=
 =?iso-8859-1?Q?BI9lLfXvRNvoo7R8liW/sQwEqs+IVzt0NrLbxJN3gLlEgLj/319BPinlYn?=
 =?iso-8859-1?Q?GOTK08OXujT2u9EnDuGzSy7RqdIRXlhTfE0YPv9/oDAzfZB1aVav6RWVsL?=
 =?iso-8859-1?Q?D8GLRZBCkF2Fc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7accdae1-de5b-48a7-618a-08dcf97fe5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:44:49.0605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpTO0N2cYvR9bu94N40X3q7dkPswOTff1RGc9n8nDhuAvXCoUqyUrjOgAHs54GBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

[AMD Official Use Only - AMD Internal Distribution Only]

________________________________________
Von: Liang, Prike <Prike.Liang@amd.com>
Gesendet: Donnerstag, 31. Oktober 2024 04:29
An: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Koenig, Christian; Liang, Prike
Betreff: [PATCH] drm/amdgpu: set the right sg limitation

The driver needs to set the correct max_segment_size;
otherwise debug_dma_map_sg() will complain about the
over-mapping of the AMDGPU sg segment as following:

WARNING: CPU: 6 PID: 1964 at kernel/dma/debug.c:1178 debug_dma_map_sg+0x2dc=
/0x370
[  364.049444] Modules linked in: veth amdgpu(OE) amdxcp drm_exec gpu_sched=
 drm_buddy drm_ttm_helper ttm(OE) drm_suballoc_helper drm_display_helper dr=
m_kms_helper i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace=
 netfs xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo =
iptable_nat xt_addrtype iptable_filter br_netfilter nvme_fabrics overlay nf=
netlink_cttimeout nfnetlink openvswitch nsh nf_conncount nf_nat nf_conntrac=
k nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc amd_atl intel_rapl=
_msr intel_rapl_common sunrpc sch_fq_codel snd_hda_codec_realtek snd_hda_co=
dec_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_i=
ntel_dspcfg edac_mce_amd binfmt_misc snd_hda_codec snd_pci_acp6x snd_hda_co=
re snd_acp_config snd_hwdep snd_soc_acpi kvm_amd snd_pcm kvm snd_seq_midi s=
nd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_raw=
midi sha256_ssse3 sha1_ssse3 aesni_intel snd_seq nls_iso8859_1 crypto_simd =
snd_seq_device cryptd snd_timer rapl input_leds snd
[  364.049532]  ipmi_devintf wmi_bmof ccp serio_raw k10temp sp5100_tco soun=
dcore ipmi_msghandler cm32181 industrialio mac_hid msr parport_pc ppdev lp =
parport drm efi_pstore ip_tables x_tables pci_stub crc32_pclmul nvme ahci l=
ibahci i2c_piix4 r8169 nvme_core i2c_designware_pci realtek i2c_ccgx_ucsi v=
ideo wmi hid_generic cdc_ether usbnet usbhid hid r8152 mii
[  364.049576] CPU: 6 PID: 1964 Comm: rocminfo Tainted: G           OE     =
 6.10.0-custom #492
[  364.049579] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06=
/13/2021
[  364.049582] RIP: 0010:debug_dma_map_sg+0x2dc/0x370
[  364.049585] Code: 89 4d b8 e8 36 b1 86 00 8b 4d b8 48 8b 55 b0 44 8b 45 =
a8 4c 8b 4d a0 48 89 c6 48 c7 c7 00 4b 74 bc 4c 89 4d b8 e8 b4 73 f3 ff <0f=
> 0b 4c 8b 4d b8 8b 15 c8 2c b8 01 85 d2 0f 85 ee fd ff ff 8b 05
[  364.049588] RSP: 0018:ffff9ca600b57ac0 EFLAGS: 00010286
[  364.049590] RAX: 0000000000000000 RBX: ffff88b7c132b0c8 RCX: 00000000000=
00027
[  364.049592] RDX: ffff88bb0f521688 RSI: 0000000000000001 RDI: ffff88bb0f5=
21680
[  364.049594] RBP: ffff9ca600b57b20 R08: 000000000000006f R09: ffff9ca600b=
57930
[  364.049596] R10: ffff9ca600b57928 R11: ffffffffbcb46328 R12: 00000000000=
00000
[  364.049597] R13: 0000000000000001 R14: ffff88b7c19c0700 R15: ffff88b7c90=
59800
[  364.049599] FS:  00007fb2d3516e80(0000) GS:ffff88bb0f500000(0000) knlGS:=
0000000000000000
[  364.049601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  364.049603] CR2: 000055610bd03598 CR3: 00000001049f6000 CR4: 00000000003=
50ef0
[  364.049605] Call Trace:
[  364.049607]  <TASK>
[  364.049609]  ? show_regs+0x6d/0x80
[  364.049614]  ? __warn+0x8c/0x140
[  364.049618]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049621]  ? report_bug+0x193/0x1a0
[  364.049627]  ? handle_bug+0x46/0x80
[  364.049631]  ? exc_invalid_op+0x1d/0x80
[  364.049635]  ? asm_exc_invalid_op+0x1f/0x30
[  364.049642]  ? debug_dma_map_sg+0x2dc/0x370
[  364.049647]  __dma_map_sg_attrs+0x90/0xe0
[  364.049651]  dma_map_sgtable+0x25/0x40
[  364.049654]  amdgpu_bo_move+0x59a/0x850 [amdgpu]
[  364.049935]  ? srso_return_thunk+0x5/0x5f
[  364.049939]  ? amdgpu_ttm_tt_populate+0x5d/0xc0 [amdgpu]
[  364.050095]  ttm_bo_handle_move_mem+0xc3/0x180 [ttm]
[  364.050103]  ttm_bo_validate+0xc1/0x160 [ttm]
[  364.050108]  ? amdgpu_ttm_tt_get_user_pages+0xe5/0x1b0 [amdgpu]
[  364.050263]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0xa12/0xc90 [amdgpu=
]
[  364.050473]  kfd_ioctl_alloc_memory_of_gpu+0x16b/0x3b0 [amdgpu]
[  364.050680]  kfd_ioctl+0x3c2/0x530 [amdgpu]
[  364.050866]  ? __pfx_kfd_ioctl_alloc_memory_of_gpu+0x10/0x10 [amdgpu]
[  364.051054]  ? srso_return_thunk+0x5/0x5f
[  364.051057]  ? tomoyo_file_ioctl+0x20/0x30
[  364.051063]  __x64_sys_ioctl+0x9c/0xd0
[  364.051068]  x64_sys_call+0x1219/0x20d0
[  364.051073]  do_syscall_64+0x51/0x120
[  364.051077]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  364.051081] RIP: 0033:0x7fb2d2f1a94f

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 0637414fc70e..78e6e72143e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1851,6 +1851,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)

        mutex_init(&adev->mman.gtt_window_lock);

+       dma_set_max_seg_size(adev->dev, dma_max_mapping_size(adev->dev) ?: =
UINT_MAX);

Just set that to UINT_MAX, IIRC we shouldn't mess with dma_max_mapping_size=
() here.

        /* No others user of address space so set it to 0 */
        r =3D ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->de=
v,
                               adev_to_drm(adev)->anon_inode->i_mapping,
--
2.34.1


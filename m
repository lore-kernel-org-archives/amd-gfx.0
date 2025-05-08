Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F8C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 14:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A922010E92F;
	Thu,  8 May 2025 14:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4juaZBuB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61C010E92F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 14:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMFDH/BBwpwDMlKE91EV2w7W6ZrGu2Bf2tJjcIctBwOQs8Y1qcRlfYx5wWMP73BklKMtopqFBpb7ibucq7AsUBEIZqcB7NuNBHYwuO9N1EiL/zpJO9j5EgnLjKZT9TtWfHKat2+cc62qih0lHXl04Ik08/yRi2FAOswsH33MqjngVxV94Z9MwiRw1aufBfx6IVGJERLrTvtmgEcSUH37Q/9CJPyqL8O4pZcO28bqcMDgA3IS5jnsLH6xvuMidI7JqLJ5UNWQ7gDuGL7hU6NuLNuAMv/Oqi1eHsLuu0OioxuHcXdf9ZTXr0Pda01CUtkuHxAhz47Pzaz0lAXmtWlNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk3yZdx9DARIrVmwaqoo7KXpXpE5oz2Jr60wKC91Qww=;
 b=OSZuKHIGN4YGxL6qWeyuJoHOVBC2jorsMtn+Sg6PaCPFC3gsGWO65ypSsQx4GnDEGG6++pR+Va6Yu7i9LZD9Qn+cndnJyWHSUdD3qngE68KFKRGxHjYalFsURjOat5CXFnXjv+Yx715u2PkdeDNP4Wed8iC3O7BeSfWchDzwY9qO256cvCLEQl7JEleWTdIs9W5mXENmJmoltfbqEbcE7zk1kiw2blKwMXR+fEsF1Flea9oGLGkADV0nwqnspl74uO73mamPlQa3ZSOSi2HCCQG+zlUPCtUSQPUv41vGXbgajyGQBmO6/6OffszH4oQIms/u/fHWtGFwVfp5VfHqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk3yZdx9DARIrVmwaqoo7KXpXpE5oz2Jr60wKC91Qww=;
 b=4juaZBuBKBNAGFhj3XQGcH310mJ/SsK6U9RJ3q1h4riim3jwBeWUBqpI3u+W8JXCG8zRTGwY5YbiL35fsczc76WyyOWqSfIhZlEQ0XfrqSD7/IvWl/RyOcCyJ9UTujqe+zQ+XfXDaFcPKufrZ5ickqMkZY0iRSaktrTIQkcVc+c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:58:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Thu, 8 May 2025
 14:58:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwCeChSywzkAkbECKrGUizP2UDbPI0oKw
Date: Thu, 8 May 2025 14:58:17 +0000
Message-ID: <BN9PR12MB52577F161A63C9DB4C96AD49FC8BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250508144248.388934-1-cesun102@amd.com>
In-Reply-To: <20250508144248.388934-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=de1190ba-0186-4b58-aea2-d14a4139cc07;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T14:56:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7911:EE_
x-ms-office365-filtering-correlation-id: 3fa27a0b-cdd1-404b-47c6-08dd8e40c434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qu+xgRiBBCs9BLhFgFr9bq3H06/cudIAjp0ZU0p+tEjdNdFZZtRISv0wNxtO?=
 =?us-ascii?Q?hc/V3wpsAP7FQ/jOv/L83gQ+Uagoc6qT6vTlmSB3eHyyWHZS+qiH3ATamjp5?=
 =?us-ascii?Q?GfYaV5KE2JG/hP8eid+JBMQwLOo6OCbI/7K70WDYUSW/zevAZLTf19lKoSLv?=
 =?us-ascii?Q?AB7Q+nAYfvTzLZ8TetKnZqVSIdiQzH6Ewzvx0DbW/5YWXBPR7OQefezf96za?=
 =?us-ascii?Q?d6OUhMYPccZyEr3BRpXB66yBCkynalFHd5ug3ksqIU1BaIJbfPoa+nTFluAk?=
 =?us-ascii?Q?iykYCp99wrHPXP0qarThYuZRFEPyErAbwqOV40Iu3MbQG1yE2csOesHMucGO?=
 =?us-ascii?Q?hCJKoLj+X2+peClnDHNI/LMNEeJuOJyTZgyT+wPJxSBaOwPGFC1E8/AZ9e39?=
 =?us-ascii?Q?xS8ZzhK/HjEagg0S57cMqAr2iIQF3mtZUX9ETfgcQYcG6BE8o/gB7u5J3VDM?=
 =?us-ascii?Q?pGEwmw5vvdNjAhf0gmBcpxP+gXjUdCOGLCoSRA/1P7LdzDzigWn6aRHC3Dln?=
 =?us-ascii?Q?8qdbesEmmHFmJWiNyH17qR+ZQe8BR8UGS8f6r5vCBEXXUDRpP6wW+IHASXgL?=
 =?us-ascii?Q?Um9EEsh3TVbxayoVrDwSWGhlw72eeZ27EsZB8QtRNkZq+hXyt43ICFO/t0oI?=
 =?us-ascii?Q?LFw2C3QU8z5F4UtfSkBh7g4hEHrXyJZt03rVBrRg343oZsSNlGtmhTHyNadV?=
 =?us-ascii?Q?lzG1X9fMn7lw2YqkNafPIPQWfCb184QbkQ3mKa2OkGvKL9Pt9aOCNKKuMu6K?=
 =?us-ascii?Q?ZkRZop3pQ0gcQOrGYfEV4xRx17lrYNNmPos3pjc9qgyg5cQ8TY0BQann8NkR?=
 =?us-ascii?Q?QF2JKdUN0UvCByrdyCFNNMEklToVd7CkMhr8+1opjBUK6RnPWGNJmbm2PQ4S?=
 =?us-ascii?Q?VRrel7QhMqD6RCJIT5EwoH+SrTEmjt46HQW55G6BMgxI9aMzz3VfHBZAaKkH?=
 =?us-ascii?Q?+9PJLTCNWdn0XuGy0RkJnd9VO0PUTCujZ9tLwawqTyFjq11KP7vKuVvA9Uy8?=
 =?us-ascii?Q?5uURgmW2RjgPiXRt1kTFPZzrtiVJVGnuvTU+aeLvNtdS128pzU0kEbmIO62T?=
 =?us-ascii?Q?q0H9E0JGf1pFE93Kr82DZj0hU4UFHNqsVM23vwcsQ2x2RPg2u9SFU0nGgIxl?=
 =?us-ascii?Q?GJYbJzRaPlX5aoXHwEIHowzWpSiZC4FbHwak3jRj4u0nNDkVzup8Ylnwv8FH?=
 =?us-ascii?Q?yWwFe5SxmGQctfYTcEI3yehSRQX7ptyuLeH7kKh+IPvXWy0PDpZ3ZQj/F/wV?=
 =?us-ascii?Q?FHNBaS4Rlb52fZrnoOPwDuPbYB/njNIXL4dQlkcWATJIOPJ/EbwfEixZ1k/c?=
 =?us-ascii?Q?l57IbXu8JKOjIPf3ffNz+A2hUG0LFWN+8uw/hc0L8sbk0mYtMw6IWlUmQ07P?=
 =?us-ascii?Q?UajvZ38AQz9gfQiKTY+YsGKMFoqmLPFoyCZi1b7B/ywLKFFuRyoaNGDgLFDk?=
 =?us-ascii?Q?yDro8GSfq8iXN/We8V7Jheezb/hh4F2Z+R1tTwkOPzaJwiKTU1AumGDuCkG+?=
 =?us-ascii?Q?rg9EHNgj4INGRVQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B5eMsDHnVniJtGKYmOPDmONyXa3bA+LuW9QHwFKTXU6UZ6k2X85vQB/+rvNb?=
 =?us-ascii?Q?dflmtwOaLlGXsodPXQrle/WH0qmjRtzgEOqldF44zDr+uQtKib5deTGRGmHU?=
 =?us-ascii?Q?o0bdD9daTYk+P+ae+YH4DjxXcuV6BdJOA67YZX7VIp4ofoWHOS8KMGTm959+?=
 =?us-ascii?Q?IFXOGTjacMXOVYM9KfyxWU8nKsTO4uwjrwnNDnHe/sCehlMwlSx/fkQXn+sd?=
 =?us-ascii?Q?P+ZDZvW+uta/Z1QVuSF+Iaffk8fd2jWZLSycmTnoxoiJ6umasSxXZ+4hC2Jx?=
 =?us-ascii?Q?ye5hETQDLhEwmCOJHXnqo7K0ldnTqhs+BY8g4R4knUmJURg0pUyEQZUdl7+z?=
 =?us-ascii?Q?hXqGc96Cjtu0qjH041uxjwHz3HPOKA7ci1YGWW+LR99MYYnpBOGjxkylVnBn?=
 =?us-ascii?Q?QzEkrlr2mvG3/AjQmXccIo49wtC5mnPAf6+6BYMFchcNzENVMSRyB2Zv/kM/?=
 =?us-ascii?Q?dttTwfk+kLFNUW4FN4cIZtGnS3Trs8YjNy5CHCnVql2TMLspDIP8EUhUKCNC?=
 =?us-ascii?Q?bjwj77BSADvyibC03BZS3IoSc9IqSffcq8bqovYMIU4CQL+zRTvalj2/Qrqd?=
 =?us-ascii?Q?08xsHh7aHHbRf6U5ZtPOpdakpiZ2SmYX2P5kzxi+Nf3/5vGcQr79Z0UyvQGT?=
 =?us-ascii?Q?8J//I2AfA83RCUt3yF5uVGpKT1GqFlLIIowmefeAxWmSGa1MEa9FCa8HqUom?=
 =?us-ascii?Q?AgoJgxbt0YDdGxdrq3KeZwg0C6IjOUwW2weH6vLElmP4B7Rcu5nS51QGc3jO?=
 =?us-ascii?Q?sbuOoWWqpwY1AYAZdE0PMVeKh3KQJ2xZtVppA68g4Lm5MY44mY82D7Ocev5r?=
 =?us-ascii?Q?TTXFH+gTO6YUml2GgqAP3nYzrgdylqW2sD7sIYNySigWSClzQKar9EtbcUs+?=
 =?us-ascii?Q?qAeyXm3U+JHVHsmsc94pHJn34ff4cUgF65E+lffp9tWZgaPoatDFhd1ZlnOh?=
 =?us-ascii?Q?wd9EfgOgV9h8A5tRVznQUk90G+KByjf98w2K9OYC1nEzSaj0yKVtjpCxWjKN?=
 =?us-ascii?Q?bmYEsyorK7XGTReuAR8z774C0eU1f4S90CxGypDB7/XCNqU3W1np20vVN7Y/?=
 =?us-ascii?Q?xRTx7YcZZcl5eQODKf1HkG8RFhsnjnDwJipHUgYkWG09dm9eWvnXS98/YOE7?=
 =?us-ascii?Q?igquEzrWV4YH5wxpB/4ZAgAU04/BV8gew/q7nlRdn0WAoQSdAklGHoT6Z1pP?=
 =?us-ascii?Q?hjl6sM+Tw/YrRh4RfcSolwCAvHa4H5zTxgWXnxjzl6LoXMj81sYng2BbpCAO?=
 =?us-ascii?Q?eW8LGTOfh+4t/AtqCEdeJ7noDePfHPpIOO3YNzXN9zEIWh9G950DAhivZMBf?=
 =?us-ascii?Q?/lwaZSHdi76dneTlSci0+4puQberzPunM+EaWAnmhCGNoQMMgVqRCovasqpd?=
 =?us-ascii?Q?eJBq4rpi5KXdgpIGKgP4kAhlnCmLufvo4/pHXxX58A7bmtPX1T01YoeVgQ7L?=
 =?us-ascii?Q?U2RzIpHQiDAsctyHBVQj+khUTjMe1dXIvft6ICU4k1KGk+uBRJQyG/5+2PIP?=
 =?us-ascii?Q?cSjX5d3viWI0IUAZWrh0DFlAu150hr5/p+c7XnoIDtK/pwICirfAvRACa5ej?=
 =?us-ascii?Q?0mVNLTf0usf9ixnQgak=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52577F161A63C9DB4C96AD49FC8BABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa27a0b-cdd1-404b-47c6-08dd8e40c434
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:58:17.7190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNYqzzWrXmmAZJBXMb2Ro2Rk8+cY8F0IAf2t2Vg3OP5LvU378zFNeWjB98164qOOcJ0fsxFk6kFl5DR0nYCSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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

--_000_BN9PR12MB52577F161A63C9DB4C96AD49FC8BABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);

I'm under the impression irq_enabled check should already be included in th=
e amdgpu_irq_put. Is that not the case?

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, May 8, 2025 22:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exc=
eed threshold

kernel panic caused by RAS records exceeding the threshold when load driver=
 specifying RMA(bad_page_threshold=3D128) 1.Fix the kernel panic caused by =
disabling the interrupt source before it was enabled 2.Fix the memory leak =
caused by the device's early exit due to rma

The first reason:
[ 2744.246650] ------------[ cut here ]------------ [ 2744.246651] WARNING:=
 CPU: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635 amdgpu_ir=
q_put.cold+0x42/0x6e [amdgpu] [ 2744.247108] Modules linked in: amdgpu(OE+)=
 amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_exec(O=
E) amd_sched(OE) amdkcl(OE) xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat=
 nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user =
xfrm_algo nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_netfilt=
er bridge stp llc overlay binfmt_misc intel_rapl_msr intel_rapl_common i10n=
m_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_in=
tel nls_iso8859_1 kvm rapl isst_if_mbox_pci isst_if_mmio pmt_telemetry pmt_=
crashlog isst_if_common pmt_class mei_me mei acpi_ipmi ipmi_si ipmi_devintf=
 ipmi_msghandler acpi_power_meter acpi_pad mac_hid sch_fq_codel dm_multipat=
h scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore_blk=
 pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zs=
td_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xo=
r async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]  lin=
ear mlx5_ib ib_uverbs ib_core ast i2c_algo_bit drm_vram_helper drm_ttm_help=
er ttm drm_kms_helper crct10dif_pclmul syscopyarea crc32_pclmul ghash_clmul=
ni_intel mlx5_core sysfillrect sysimgblt aesni_intel mlxfw fb_sys_fops psam=
ple cec crypto_simd cryptd rc_core i2c_i801 nvme xhci_pci tls intel_pmt drm=
 pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinctrl_=
emmitsburg
[ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G           OE   =
  5.15.0-70-generic #77-Ubuntu
[ 2744.247197] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024 [ 2744.247198] Workqueue: events work_for_cpu_fn [ 2744.2472=
06] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e [amdgpu] [ 2744.247634] Code: 7=
9 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55 d4 e8 90 09 bc bf 8b 55 d4 4c 8=
9 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0 75 07 <0f> 0b e9 95 79 7f ff 49=
 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4c 89 [ 2744.247636] RSP: 0018:ffa0000=
019e27cb0 EFLAGS: 00010246 [ 2744.247639] RAX: 0000000000000000 RBX: 000000=
0000000000 RCX: ff11000150fa87c0 [ 2744.247641] RDX: 0000000000000000 RSI: =
ffffffffc2222430 RDI: ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0=
 R08: 0000000000000003 R09: ffffffffffe41a08 [ 2744.247643] R10: 0000000000=
ffff0a R11: 0000000000000001 R12: ff1100019f22ce60 [ 2744.247644] R13: 0000=
000000000000 R14: 00000000ffffffea R15: ff1100019f200000 [ 2744.247645] FS:=
  0000000000000000(0000) GS:ff11007e7e400000(0000) knlGS:0000000000000000 [=
 2744.247647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 2744.2476=
49] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4: 0000000000771ef0 [ 274=
4.247650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000=
 [ 2744.247651] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000=
000400 [ 2744.247652] PKRU: 55555554 [ 2744.247653] Call Trace:
[ 2744.247654]  <TASK>
[ 2744.247656]  sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]  ? vc=
n_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]  amdgpu_ip_block_hw_fini=
+0x31/0x61 [amdgpu] [ 2744.248776]  amdgpu_device_fini_hw+0x3bb/0x47b [amdg=
pu] [ 2744.249197]  ? blocking_notifier_chain_unregister+0x56/0xb0
[ 2744.249202]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 2744.249482] =
 amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [ 2744.249913]  amdgpu_pci_=
probe+0x23e/0x590 [amdgpu] [ 2744.250187]  local_pci_probe+0x48/0x90 [ 2744=
.250191]  work_for_cpu_fn+0x17/0x30 [ 2744.250196]  process_one_work+0x228/=
0x3d0 [ 2744.250198]  worker_thread+0x223/0x420 [ 2744.250200]  ? process_o=
ne_work+0x3d0/0x3d0 [ 2744.250201]  kthread+0x127/0x150 [ 2744.250204]  ? s=
et_kthread_struct+0x50/0x50 [ 2744.250207]  ret_from_fork+0x1f/0x30 [ 2744.=
250212]  </TASK> [ 2744.250213] ---[ end trace 488c997a88508bc3 ]---

The second reason:
[ 5139.303446] Memory manager not clean during takedown.
[ 5139.303509] WARNING: CPU: 145 PID: 117699 at drivers/gpu/drm/drm_mm.c:99=
8 drm_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Modules linked in: amdgpu(=
OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE) amddrm_buddy(OE) amddrm_ex=
ec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft_chain_nat xt_MASQUERADE nf=
_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_u=
ser xfrm_algo nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_net=
filter bridge stp llc overlay intel_rapl_msr intel_rapl_common i10nm_edac n=
fit x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel binf=
mt_misc kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_telemetry pmt_crashlog =
isst_if_mmio pmt_class isst_if_common mei_me mei acpi_ipmi ipmi_si ipmi_dev=
intf ipmi_msghandler acpi_pad acpi_power_meter mac_hid sch_fq_codel dm_mult=
ipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore=
_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generi=
c zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq asyn=
c_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 5139.303572] =
 linear mlx5_ib ib_uverbs ib_core crct10dif_pclmul ast crc32_pclmul i2c_alg=
o_bit ghash_clmulni_intel aesni_intel crypto_simd drm_vram_helper cryptd dr=
m_ttm_helper mlx5_core ttm drm_kms_helper syscopyarea sysfillrect sysimgblt=
 fb_sys_fops cec rc_core mlxfw psample intel_pmt nvme xhci_pci drm tls i2c_=
i801 pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinc=
trl_emmitsburg [last unloaded: amdkcl]
[ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G     U     OE =
    5.15.0-70-generic #77-Ubuntu
[ 5139.303590] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.A=
G.2 11/21/2024 [ 5139.303591] RIP: 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5=
139.303605] Code: cc 66 90 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 =
75 05 c3 cc cc cc cc 55 48 c7 c7 18 d0 10 c0 48 89 e5 e8 5a bc c3 c1 <0f> 0=
b 5d c3 cc cc cc cc 90 0f 1f 44 00 00 55 b9 15 00 00 00 48 89 [ 5139.303607=
] RSP: 0018:ffa00000325c3940 EFLAGS: 00010286 [ 5139.303608] RAX: 000000000=
0000000 RBX: ff1100012f5cecb0 RCX: 0000000000000027 [ 5139.303609] RDX: ff1=
1007e7fa60588 RSI: 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RB=
P: ffa00000325c3940 R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.3036=
10] R10: 000000000000002b R11: 0000000000000001 R12: ff1100012f5cec00 [ 513=
9.303611] R13: ff1100012138f068 R14: 0000000000000000 R15: ff1100012f5cec90=
 [ 5139.303611] FS:  00007f42ffca0000(0000) GS:ff11007e7fa40000(0000) knlGS=
:0000000000000000 [ 5139.303612] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033 [ 5139.303613] CR2: 00007f23d945ab68 CR3: 00000001212ce005 CR4: 000=
0000000771ee0 [ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000 [ 5139.303615] DR3: 0000000000000000 DR6: 00000000fffe0=
7f0 DR7: 0000000000000400 [ 5139.303615] PKRU: 55555554 [ 5139.303616] Call=
 Trace:
[ 5139.303617]  <TASK>
[ 5139.303619]  amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm] [ 5139.30=
3625]  amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]  amdgpu_bo_fini+=
0x27/0xc0 [amdgpu] [ 5139.303959]  gmc_v9_0_sw_fini+0x63/0x90 [amdgpu] [ 51=
39.304144]  amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu] [ 5139.304302]  amdg=
pu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.304455]  devm_drm_dev_init_=
release+0x4a/0x80 [drm] [ 5139.304472]  devm_action_release+0x12/0x20 [ 513=
9.304476]  release_nodes+0x3d/0xb0 [ 5139.304478]  devres_release_all+0x9b/=
0xd0 [ 5139.304480]  really_probe+0x11d/0x420 [ 5139.304483]  __driver_prob=
e_device+0x119/0x190 [ 5139.304485]  driver_probe_device+0x23/0xc0 [ 5139.3=
04487]  __driver_attach+0xf7/0x1f0 [ 5139.304489]  ? __device_attach_driver=
+0x140/0x140
[ 5139.304491]  bus_for_each_dev+0x7c/0xd0 [ 5139.304493]  driver_attach+0x=
1e/0x30 [ 5139.304494]  bus_add_driver+0x148/0x220 [ 5139.304496]  driver_r=
egister+0x95/0x100 [ 5139.304498]  __pci_register_driver+0x68/0x70 [ 5139.3=
04500]  amdgpu_init+0xbc/0x1000 [amdgpu] [ 5139.304655]  ? 0xffffffffc0b8f0=
00 [ 5139.304657]  do_one_initcall+0x46/0x1e0 [ 5139.304659]  ? kmem_cache_=
alloc_trace+0x19e/0x2e0
[ 5139.304663]  do_init_module+0x52/0x260 [ 5139.304665]  load_module+0xb2b=
/0xbc0 [ 5139.304667]  __do_sys_finit_module+0xbf/0x120 [ 5139.304669]  __x=
64_sys_finit_module+0x18/0x20 [ 5139.304670]  do_syscall_64+0x59/0xc0 [ 513=
9.304673]  ? exit_to_user_mode_prepare+0x37/0xb0
[ 5139.304676]  ? syscall_exit_to_user_mode+0x27/0x50
[ 5139.304678]  ? __x64_sys_mmap+0x33/0x50 [ 5139.304680]  ? do_syscall_64+=
0x69/0xc0 [ 5139.304681]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 5139.304684] RIP: 0033:0x7f42ffdbf88d
[ 5139.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48 [ 5139.304=
687] RSP: 002b:00007ffcb7427158 EFLAGS: 00000246 ORIG_RAX: 0000000000000139=
 [ 5139.304688] RAX: ffffffffffffffda RBX: 000055ce8b8f3150 RCX: 00007f42ff=
dbf88d [ 5139.304689] RDX: 0000000000000000 RSI: 000055ce8b8f9a70 RDI: 0000=
00000000000a [ 5139.304690] RBP: 0000000000040000 R08: 0000000000000000 R09=
: 0000000000000011 [ 5139.304690] R10: 000000000000000a R11: 00000000000002=
46 R12: 000055ce8b8f9a70 [ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce=
8b8f2ab0 R15: 000055ce8b8f9aa0 [ 5139.304692]  </TASK> [ 5139.304693] ---[ =
end trace 8536b052f7883003 ]---

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c        |  6 ++++--
 7 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index d4f3fb3519c8..1166093d2b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -614,7 +614,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *=
adev)

                if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
                    ring->fence_drv.irq_src &&
-                   amdgpu_fence_need_ring_interrupt_restore(ring))
+                   amdgpu_fence_need_ring_interrupt_restore(ring) &&
+                   amdgpu_irq_enabled(adev, ring->fence_drv.irq_src,
+                                      ring->fence_drv.irq_type))
                        amdgpu_irq_put(adev, ring->fence_drv.irq_src,
                                       ring->fence_drv.irq_type);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index cb7991362b5d..6f24e95c9112 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
        amdgpu_vram_mgr_fini(adev);
        amdgpu_gtt_mgr_fini(adev);
        amdgpu_preempt_mgr_fini(adev);
+       amdgpu_doorbell_fini(adev);
+
        ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
        ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
        ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA); diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_x=
cp.c
index cd6e4c0b94da..e970a1427fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *=
adev)
        struct amdgpu_xcp_cfg *xcp_cfg;
        int i;

-       if (!adev->xcp_mgr)
+       if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
                return;

-       xcp_cfg =3D  adev->xcp_mgr->xcp_cfg;
+       xcp_cfg =3D adev->xcp_mgr->xcp_cfg;
        for (i =3D 0; i < xcp_cfg->num_res; i++) {
                xcp_res =3D &xcp_cfg->xcp_res[i];
                kobject_put(&xcp_res->kobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index dcc6752c3ece..dd0a2cfd85cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2379,10 +2379,17 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int i, num_xcc;

-       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
-       amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.spm_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+       if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
+               amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
        for (i =3D 0; i < num_xcc; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 59385da80185..05599c253e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2513,10 +2513,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block =
*ip_block)
         * are not enabled.
         */
        if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-               amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
+               if (amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0))
+                       amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

                if (adev->gmc.ecc_irq.funcs &&
-                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+                   amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0))
                        amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 11f9c07f1e8d..60f5f3b367d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1615,8 +1615,10 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
        inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
                for (i =3D 0; i < adev->sdma.num_instances; i++) {
-                       amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-                                      AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+                       if (amdgpu_irq_enabled(adev, &adev->sdma.ecc_irq,
+                                              AMDGPU_SDMA_IRQ_INSTANCE0 + =
i))
+                               amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+                                              AMDGPU_SDMA_IRQ_INSTANCE0 + =
i);
                }
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index c457be3a3c56..5a60cf679307 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1338,10 +1338,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)
            adev->nbio.ras_if &&
            amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
                if (adev->nbio.ras &&
-                   adev->nbio.ras->init_ras_controller_interrupt)
+                   adev->nbio.ras->init_ras_controller_interrupt &&
+                   amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq=
, 0))
                        amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq=
, 0);
                if (adev->nbio.ras &&
-                   adev->nbio.ras->init_ras_err_event_athub_interrupt)
+                   adev->nbio.ras->init_ras_err_event_athub_interrupt &&
+                   amdgpu_irq_enabled(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0))
                        amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0);
        }

--
2.34.1


--_000_BN9PR12MB52577F161A63C9DB4C96AD49FC8BABN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&g=
t;gfx.priv_reg_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I'm =
under the impression irq_enabled check should already be included in the am=
dgpu_irq_put. Is that not the case?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>

Sent: Thursday, May 8, 2025 22:43<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records exc=
eed threshold</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">kern=
el panic caused by RAS records exceeding the threshold when load driver spe=
cifying RMA(bad_page_threshold=3D128) 1.Fix the kernel panic caused by disa=
bling the interrupt source before it was
enabled 2.Fix the memory leak caused by the device's early exit due to rma<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
first reason:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.246650] ------------[ cut here ]------------ [ 2744.246651] WARNING: CPU=
: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635 amdgpu_irq_pu=
t.cold+0x42/0x6e [amdgpu] [ 2744.247108]
Modules linked in: amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE) =
amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft_=
chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_=
ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge =
stp llc overlay binfmt_misc intel_rapl_msr intel_rapl_common i10nm_edac nfi=
t x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel nls_is=
o8859_1 kvm rapl isst_if_mbox_pci
isst_if_mmio pmt_telemetry pmt_crashlog isst_if_common pmt_class mei_me mei=
 acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad m=
ac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr =
ramoops reed_solomon pstore_blk
pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zst=
d_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor=
 async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]&nbsp;=
 linear mlx5_ib ib_uverbs ib_core ast
i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper crct10dif_pc=
lmul syscopyarea crc32_pclmul ghash_clmulni_intel mlx5_core sysfillrect sys=
imgblt aesni_intel mlxfw fb_sys_fops psample cec crypto_simd cryptd rc_core=
 i2c_i801 nvme xhci_pci tls intel_pmt
drm pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinct=
rl_emmitsburg</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.15.0-=
70-generic #77-Ubuntu</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247197] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.AG.2 =
11/21/2024 [ 2744.247198] Workqueue: events work_for_cpu_fn [ 2744.247206] =
RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e
[amdgpu] [ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55 =
d4 e8 90 09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0 =
75 07 &lt;0f&gt; 0b e9 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4=
c 89 [ 2744.247636] RSP: 0018:ffa0000019e27cb0
EFLAGS: 00010246 [ 2744.247639] RAX: 0000000000000000 RBX: 0000000000000000=
 RCX: ff11000150fa87c0 [ 2744.247641] RDX: 0000000000000000 RSI: ffffffffc2=
222430 RDI: ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0 R08: 0000=
000000000003 R09: ffffffffffe41a08
[ 2744.247643] R10: 0000000000ffff0a R11: 0000000000000001 R12: ff1100019f2=
2ce60 [ 2744.247644] R13: 0000000000000000 R14: 00000000ffffffea R15: ff110=
0019f200000 [ 2744.247645] FS:&nbsp; 0000000000000000(0000) GS:ff11007e7e40=
0000(0000) knlGS:0000000000000000 [ 2744.247647]
CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 2744.247649] CR2: =
00007f3d2002819c CR3: 0000000006810003 CR4: 0000000000771ef0 [ 2744.247650]=
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ 2744.2=
47651] DR3: 0000000000000000 DR6: 00000000fffe07f0
DR7: 0000000000000400 [ 2744.247652] PKRU: 55555554 [ 2744.247653] Call Tra=
ce:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247654]&nbsp; &lt;TASK&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247656]&nbsp; sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]&nbsp=
; ? vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]&nbsp; amdgpu_ip_bl=
ock_hw_fini+0x31/0x61 [amdgpu] [ 2744.248776]&nbsp; amdgpu_device_fini_hw+0=
x3bb/0x47b
[amdgpu] [ 2744.249197]&nbsp; ? blocking_notifier_chain_unregister+0x56/0xb=
0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.249202]&nbsp; amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 2744.249482]=
&nbsp; amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [ 2744.249913]&nbsp; =
amdgpu_pci_probe+0x23e/0x590 [amdgpu] [ 2744.250187]&nbsp;
local_pci_probe+0x48/0x90 [ 2744.250191]&nbsp; work_for_cpu_fn+0x17/0x30 [ =
2744.250196]&nbsp; process_one_work+0x228/0x3d0 [ 2744.250198]&nbsp; worker=
_thread+0x223/0x420 [ 2744.250200]&nbsp; ? process_one_work+0x3d0/0x3d0 [ 2=
744.250201]&nbsp; kthread+0x127/0x150 [ 2744.250204]&nbsp; ? set_kthread_st=
ruct+0x50/0x50
[ 2744.250207]&nbsp; ret_from_fork+0x1f/0x30 [ 2744.250212]&nbsp; &lt;/TASK=
&gt; [ 2744.250213] ---[ end trace 488c997a88508bc3 ]---</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
second reason:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303446] Memory manager not clean during takedown.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303509] WARNING: CPU: 145 PID: 117699 at drivers/gpu/drm/drm_mm.c:998 dr=
m_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Modules linked in: amdgpu(OE+)=
 amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)
amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft_=
chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_=
ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat =
nf_tables nfnetlink br_netfilter
bridge stp llc overlay intel_rapl_msr intel_rapl_common i10nm_edac nfit x86=
_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel binfmt_misc=
 kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_telemetry pmt_crashlog isst_if=
_mmio pmt_class isst_if_common mei_me
mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_mete=
r mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua m=
sr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_table=
s autofs4 btrfs blake2b_generic
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 5139.303572]&nb=
sp; linear mlx5_ib ib_uverbs ib_core crct10dif_pclmul ast crc32_pclmul i2c_=
algo_bit ghash_clmulni_intel aesni_intel
crypto_simd drm_vram_helper cryptd drm_ttm_helper mlx5_core ttm drm_kms_hel=
per syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core mlxfw psample=
 intel_pmt nvme xhci_pci drm tls i2c_i801 pci_hyperv_intf nvme_core i2c_smb=
us i2c_ismt xhci_pci_renesas wmi
pinctrl_emmitsburg [last unloaded: amdkcl]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G&nbsp;&nbsp;&nbsp;=
&nbsp; U&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.15.0-70-gener=
ic #77-Ubuntu</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303590] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.AG.2 =
11/21/2024 [ 5139.303591] RIP: 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5139.=
303605] Code: cc 66 90 0f 1f 44 00 00
48 8b 47 38 48 83 c7 38 48 39 f8 75 05 c3 cc cc cc cc 55 48 c7 c7 18 d0 10 =
c0 48 89 e5 e8 5a bc c3 c1 &lt;0f&gt; 0b 5d c3 cc cc cc cc 90 0f 1f 44 00 0=
0 55 b9 15 00 00 00 48 89 [ 5139.303607] RSP: 0018:ffa00000325c3940 EFLAGS:=
 00010286 [ 5139.303608] RAX: 0000000000000000
RBX: ff1100012f5cecb0 RCX: 0000000000000027 [ 5139.303609] RDX: ff11007e7fa=
60588 RSI: 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RBP: ffa00=
000325c3940 R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.303610] R10:=
 000000000000002b R11: 0000000000000001
R12: ff1100012f5cec00 [ 5139.303611] R13: ff1100012138f068 R14: 00000000000=
00000 R15: ff1100012f5cec90 [ 5139.303611] FS:&nbsp; 00007f42ffca0000(0000)=
 GS:ff11007e7fa40000(0000) knlGS:0000000000000000 [ 5139.303612] CS:&nbsp; =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5139.303613] CR2: 00007f23d945ab68 CR3: 00000001212ce005 CR4: 00000000007=
71ee0 [ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000 [ 5139.303615] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:=
 0000000000000400 [ 5139.303615]
PKRU: 55555554 [ 5139.303616] Call Trace:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303617]&nbsp; &lt;TASK&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303619]&nbsp; amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm] [ 5139.3=
03625]&nbsp; amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]&nbsp; amdg=
pu_bo_fini+0x27/0xc0 [amdgpu] [ 5139.303959]&nbsp; gmc_v9_0_sw_fini+0x63/0x=
90
[amdgpu] [ 5139.304144]&nbsp; amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu] [ =
5139.304302]&nbsp; amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.3044=
55]&nbsp; devm_drm_dev_init_release+0x4a/0x80 [drm] [ 5139.304472]&nbsp; de=
vm_action_release+0x12/0x20 [ 5139.304476]&nbsp; release_nodes+0x3d/0xb0
[ 5139.304478]&nbsp; devres_release_all+0x9b/0xd0 [ 5139.304480]&nbsp; real=
ly_probe+0x11d/0x420 [ 5139.304483]&nbsp; __driver_probe_device+0x119/0x190=
 [ 5139.304485]&nbsp; driver_probe_device+0x23/0xc0 [ 5139.304487]&nbsp; __=
driver_attach+0xf7/0x1f0 [ 5139.304489]&nbsp; ? __device_attach_driver+0x14=
0/0x140</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304491]&nbsp; bus_for_each_dev+0x7c/0xd0 [ 5139.304493]&nbsp; driver_att=
ach+0x1e/0x30 [ 5139.304494]&nbsp; bus_add_driver+0x148/0x220 [ 5139.304496=
]&nbsp; driver_register+0x95/0x100 [ 5139.304498]&nbsp; __pci_register_driv=
er+0x68/0x70
[ 5139.304500]&nbsp; amdgpu_init+0xbc/0x1000 [amdgpu] [ 5139.304655]&nbsp; =
? 0xffffffffc0b8f000 [ 5139.304657]&nbsp; do_one_initcall+0x46/0x1e0 [ 5139=
.304659]&nbsp; ? kmem_cache_alloc_trace+0x19e/0x2e0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304663]&nbsp; do_init_module+0x52/0x260 [ 5139.304665]&nbsp; load_module=
+0xb2b/0xbc0 [ 5139.304667]&nbsp; __do_sys_finit_module+0xbf/0x120 [ 5139.3=
04669]&nbsp; __x64_sys_finit_module+0x18/0x20 [ 5139.304670]&nbsp;
do_syscall_64+0x59/0xc0 [ 5139.304673]&nbsp; ? exit_to_user_mode_prepare+0x=
37/0xb0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304676]&nbsp; ? syscall_exit_to_user_mode+0x27/0x50</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304678]&nbsp; ? __x64_sys_mmap+0x33/0x50 [ 5139.304680]&nbsp; ? do_sysca=
ll_64+0x69/0xc0 [ 5139.304681]&nbsp; entry_SYSCALL_64_after_hwframe+0x61/0x=
cb</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304684] RIP: 0033:0x7f42ffdbf88d</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f=
8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 &lt;48&=
gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f
00 f7 d8 64 89 01 48 [ 5139.304687] RSP: 002b:00007ffcb7427158 EFLAGS: 0000=
0246 ORIG_RAX: 0000000000000139 [ 5139.304688] RAX: ffffffffffffffda RBX: 0=
00055ce8b8f3150 RCX: 00007f42ffdbf88d [ 5139.304689] RDX: 0000000000000000 =
RSI: 000055ce8b8f9a70 RDI: 000000000000000a
[ 5139.304690] RBP: 0000000000040000 R08: 0000000000000000 R09: 00000000000=
00011 [ 5139.304690] R10: 000000000000000a R11: 0000000000000246 R12: 00005=
5ce8b8f9a70 [ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce8b8f2ab0 R15:=
 000055ce8b8f9aa0 [ 5139.304692]&nbsp;
&lt;/TASK&gt; [ 5139.304693] ---[ end trace 8536b052f7883003 ]---</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_fence.c |&nbsp; 4 +++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp; |&nbsp; 2 ++</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp; |&nbsp; 4 ++--</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp; | 15 +++++++++++----</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++++--=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp; |&nbsp; 6 ++++--</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 6 ++++--</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 7 f=
iles changed, 30 insertions(+), 13 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/am=
dgpu/amdgpu_fence.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x d4f3fb3519c8..1166093d2b5b 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
614,7 +614,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!drm_dev_is_unplugged(adev_to_drm(adev)) &amp;&amp;</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.irq_src &amp;&=
amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_need_ring_interrupt_restore(rin=
g))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_need_ring_interrupt_restore(rin=
g) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabled(adev, ring-&gt;fence_drv.=
irq_src,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;fence_drv.irq_type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, ring-&gt;fence_drv.irq_src,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ring-&gt;fence_drv.irq_type);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ttm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x cb7991362b5d..6f24e95c9112 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vram_mgr_fini(adev);</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gtt_mgr_fini(adev);</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_preempt_mgr_fini(adev);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_doorbell_fini(adev);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;adev-&=
gt;mman.bdev, AMDGPU_PL_GDS);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;adev-&=
gt;mman.bdev, AMDGPU_PL_GWS);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_range_man_fini(&amp;adev-&=
gt;mman.bdev, AMDGPU_PL_OA); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x cd6e4c0b94da..e970a1427fe0 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xcp_cfg *xcp_cfg=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;xcp_mgr)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;xcp_mgr || !adev-&gt;xcp_mg=
r-&gt;xcp_cfg)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg =3D&nbsp; adev-&gt;xcp_mgr-&gt;xc=
p_cfg;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_cfg =3D adev-&gt;xcp_mgr-&gt;xcp_cfg;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; xcp_cfg-&=
gt;num_res; i++) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; xcp_res =3D &amp;xcp_cfg-&gt;xcp_res[i];</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kobject_put(&amp;xcp_res-&gt;kobj);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x dcc6752c3ece..dd0a2cfd85cf 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2379,10 +2379,17 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *i=
p_block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 ip_block-&gt;adev;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, num_xcc;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.pr=
iv_reg_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.sp=
m_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.pr=
iv_inst_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.ba=
d_op_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&g=
t;gfx.priv_reg_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&g=
t;gfx.spm_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&g=
t;gfx.priv_inst_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&g=
t;gfx.bad_op_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gfx.bad_op_irq, 0);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&gt;g=
fx.xcc_mask);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_xcc; =
i++) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu=
/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 59385da80185..05599c253e24 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2513,10 +2513,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_=
block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are not enabled.</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;init_lvl-&gt;leve=
l !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gmc.vm_fault, 0);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_irq_enabled(adev, &amp;adev-&gt;gmc.vm_fault, 0))</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev,=
 &amp;adev-&gt;gmc.vm_fault, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.ecc_irq.funcs &amp;&amp;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLO=
CK__UMC))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLO=
CK__UMC) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabled(adev, &amp;adev-&gt;gmc.e=
cc_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, &amp;adev-&gt;gmc.ecc_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amd=
gpu/sdma_v4_4_2.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 11f9c07f1e8d..60f5f3b367d8 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1615,8 +1615,10 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *i=
p_block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inst_mask =3D GENMASK(adev-&gt=
;sdma.num_instances - 1, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_supported(ad=
ev, AMDGPU_RAS_BLOCK__SDMA)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_instances; i++) {<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev,=
 &amp;adev-&gt;sdma.ecc_irq,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGP=
U_SDMA_IRQ_INSTANCE0 + i);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_irq_enabl=
ed(adev, &amp;adev-&gt;sdma.ecc_irq,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SDMA_IRQ_INSTANCE0 + i))<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;sdma.ecc_irq=
,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SDMA_IRQ_INSTANCE0 + i);<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/so=
c15.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x c457be3a3c56..5a60cf679307 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/soc15.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/soc15.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1338,10 +1338,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_block =
*ip_block)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;nbio.ras_if &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu=
_ras_is_supported(adev, adev-&gt;nbio.ras_if-&gt;block)) {</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.ras &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras-&gt;init_ras_controller_in=
terrupt)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras-&gt;init_ras_controller_in=
terrupt &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabled(adev, &amp;adev-&gt;nbio.=
ras_controller_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, &amp;adev-&gt;nbio.ras_controller_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.ras &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras-&gt;init_ras_err_event_ath=
ub_interrupt)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras-&gt;init_ras_err_event_ath=
ub_interrupt &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_enabled(adev, &amp;adev-&gt;nbio.=
ras_err_event_athub_irq, 0))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, &amp;adev-&gt;nbio.ras_err_event_athub_irq, 0);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB52577F161A63C9DB4C96AD49FC8BABN9PR12MB5257namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5E1CD8C9D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 11:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF8810F269;
	Mon,  8 Jun 2026 11:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UIMUVqwC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D4610F269
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 11:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD5vLOhwsmfv4ns3j8HSDrK+m28LOtCAzs4GCfi0ZkDGgMs2F/uzBjQ3/FYNVttH2qdmr3S1aow5p07gqyDafe+TybpL/S4q0C+LkWr8LPR8RSIKu4FGlfrJmjXSAZBYTUUvC/qGlIeKLAAhpr3aGsZOPzhqK+0hisDb0ZVZaTycyAfN0uhTtfLi46mIL7xmJbJlNYWxWnzz/QBxxDxI0lUpR1AOgz5UyAv0nW2DeQqVdxlMOGrad9R1nGOn5PUC3X/jXHBKL/m6zQhjtDc+nyKvtrSn5TCtwAQk+omnbeL8ykE9Bn9WQf4xvTYRCcqCLB9usfvjosDuPq7RulCT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWunqKxzUiJllCctK0ywP0sCH6kkOBqSmoLmp5HoRFM=;
 b=Vzu/AwQj4hepqWJZoB/fAp0fEXiT7uYfjNetkhwWO52hpxXhEAiJg1KAqIbty/EWp/LoaJRRVhiIlJW20FkPBqu/xyIy7NUWgaovfmC2Z3twgEvhjhTvpdmt8gUEjizrXQ4O9sHOH8LV3rHjfWx4/d4icg+5f8NWtFLcfSbDmAevu1a0l8cxulUjXOqLu8OZlLa9QHhaTM7Z5q2jgON5epOuBRyGGE0m7A4KsQctGZBBBgi5F94DssEN/onDyxw8C1m3MPD3ceSO+06Ow/YRPMr0MXK9i37ZHUGQuHtEYhLW2fZKhFfF2aStpNGnlhi2getwKDCLyTCxLOjX6zPd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWunqKxzUiJllCctK0ywP0sCH6kkOBqSmoLmp5HoRFM=;
 b=UIMUVqwC9Zc14SktYO2PFPCzCDVGEIOHR8pk5HrD+WT/oGaehXn+a6KWh9ALYFSplupmQHuEo1E6jiodEDSxBEO38UKa8PL3j3QXtlypjARcuxceYn/n6xhl5XLoBk9MClM55cVEnjfRQcvXKgwkRCpb6kopZjaZ27H5d8NWRGo=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 11:48:52 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:48:52 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma,
 Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Topic: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel
 lockdown
Thread-Index: AQHc805zEVVWuGKc8EiTSYUHqImhnrY0ZM8AgAAcPXCAAAvtgIAABNZA
Date: Mon, 8 Jun 2026 11:48:52 +0000
Message-ID: <DM4PR12MB5038B0755743FC22E25C80FC8E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260603114459.938031-1-asad.kamal@amd.com>
 <aiaEMl-b5qo6dmL6@archlinux>
 <DM4PR12MB5038BE603641525F68C9C3018E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
 <aialwv31-f-Rt06W@archlinux>
In-Reply-To: <aialwv31-f-Rt06W@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-08T11:44:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|DS2PR12MB9822:EE_
x-ms-office365-filtering-correlation-id: cbda506e-19f0-4c42-7684-08dec553e95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: prmOrR6GPfh96q22GHUWTVBReaYsZlWQPHwfK8bcNyX6y1sA3R8O3Brlm/AF29unxsfW7Er8Um/NxmuZuIMtmXnQFl9feMI7BCACfSP7BTfqzxIqiedhpBEYyCWpt0Gqfdz71uKBZpaRUpnvEJIO+1kXFid4MDnnCWohDMZWG77ixjODWFkP1gEkOZvRr5G+AtGm6PqqORf8RH+WHb3eBzeQ7rIgRAszXh+xek0PIb5cKNdfWkPMU8hGRAQopMaYcyIz0piWW0OuhNqFKqyfbx2IK81ebLN5K8GDYMWU5jxSINaZjKOUJPfaS6H2mIWcTW66K3hA3g5UvBRBstNSMoQR6329W6OSegCwzhC3GBVuHtWXVC2rUFM70BsPnHLXNDSAbITny7cGq/Tl9n1zNqp8blp4Wa59w0tm1VKrOcmffLG0loWp7tQ6/c8IZAiOaNTbjhQ1bdpaZX1oE8tTVMC5omB667yZoLSuquwIpZa+Fj95YBUQQL/vDCPwS23R4NW0oVrreNvkWxYm+coIPhC1ZrS35mEYLI5u4+czMXP7tal/8fCTifuyLEB/sx8Qs7BRzOG3X6WaZpVVYnmKFJOmQOi129iRLO1/HeYMvl04mf8uBNFZdjTD5YG2Kjp0HUklaWyReDpEOV3jl3RdCpB+4/bsZ8FHuCjO6J+THgD8usY7aIAAvvOs3EJ1380DDykhHTpjuTfIAjcvxILTInjDm92+qvyWPBVMm9evA2az2y2uXSw8aTeIy8jGqVIe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WHRPenBqekdNekd1OHpUMUlrRUxzQ09HcTdmWFpWa0pxK2FMdUkyZVRO?=
 =?iso-2022-jp?B?Y3JQMS9rdlJxN0RVaEtXTFJPeUQ0ak5Rd3lWWlkwK2djQmRJcG8vU0ll?=
 =?iso-2022-jp?B?RG52VzJneEhQWjUrZHYzM2I5dTBJcGkvOTRQNUdTU0QwUEhhSVU3ejhm?=
 =?iso-2022-jp?B?eEx0b2tDUEpMMjk1bWxGMWpvM1Z2QW9Nb1VkUFJJRFNHSlZ3ejh4U0ky?=
 =?iso-2022-jp?B?OCtDeFNqT1lhZE5tdCtUSlVxb29uV1lKeGRIN1hjMTBsdU81UVk0WDJw?=
 =?iso-2022-jp?B?N2k0UWczVU1lRlkrMytKZzdaUVJQZnU3ZlM1L3A5R0laVDREM1F4bTcx?=
 =?iso-2022-jp?B?UEl2aStrUjA2Z0I5dG9LK2ZVcC9VUGNqVS85MFpUMFZ1V0tYbnlRcmNH?=
 =?iso-2022-jp?B?TEZFTyt2TkFFYlBFcHA1QjY4WXJJTFdGYWo0NEhQdEtLWms1bWFrZG1n?=
 =?iso-2022-jp?B?enBmMHVZUHJYSjVnL1JGMUE4Q2dJTVRDSWgrbXFyclJVc284empsUTVv?=
 =?iso-2022-jp?B?QVNLc2dUMmtCMC9tUnBCdU5RMjNweDlkaktUbm9RaWZudVBpdGdCdVF1?=
 =?iso-2022-jp?B?cGpoekIwSVNZSzNkK1ZqNXd0c0YzSzhFV3pvTFladW5sSjl2MTdDZVFZ?=
 =?iso-2022-jp?B?UVpiS1JvN2dWRFY4enI1Qk9LRmZlSHcreGk3SXRDOWF2RHFIbjNsOXZt?=
 =?iso-2022-jp?B?bkNhaUhCeDI2N1Q0RWxOZk5jbWtzcGJvZjFGTUV2ZG9SMzRYZGdsQ0gz?=
 =?iso-2022-jp?B?MitWYnp1QUVpWm9EM25oK2dKdzRQdFhXZm5IT2NPRjBPaDgzUUZCbHdM?=
 =?iso-2022-jp?B?N1o3djZHOXIyYXdDN09XcEhBVUF3RnRyYlpISjdxSVVGc1l3YnNYZHlv?=
 =?iso-2022-jp?B?WGlqR3VBMFEyRjR5WXBVUzF3eWJ5engzWm9ubTFIMTZFSi9mNDlreWQ1?=
 =?iso-2022-jp?B?ZHpDWVQybVIwL0J6Y2JtTVBlcEwwN0xSTlVYOU9sRWVyOXZvMVM4OC96?=
 =?iso-2022-jp?B?WEZXeEF0OWg1ZzdKdFExTEx2MkorWStrTS8zNC9CMTJYRzNQWUpVekNt?=
 =?iso-2022-jp?B?M1MyS1hLczFDbXdzK3M3eFd0MWhubUxiVE0xdDhhUjMvY0VpYkJaVjJa?=
 =?iso-2022-jp?B?aHVvKzJueTlBcWhXOExrR2tJRkJOVnVuVHF4Y0NrS3c5NVo1bURNYlho?=
 =?iso-2022-jp?B?YmNGMWtZb1Q3czR6YVpRSWcyQ3BWK0phMFlYVXRWU1JCTlNhSlV6d29a?=
 =?iso-2022-jp?B?ang2ZitoaXJsY1JubTg5QnVGeVNPcm40L3NseC9ONkR3eGIzWTNXWk5X?=
 =?iso-2022-jp?B?N2trak9ac3EwLzRzQUJGS28rZjdYUWU2MXVZVDFIa01rTHNxOHJ2MXhv?=
 =?iso-2022-jp?B?ZWx4NzI3aE9INThneVhCQkhJQ2JoVStFNHYxejZGcHBhUGJqRUxOcXZE?=
 =?iso-2022-jp?B?ZE1kVDBjalBiSnRLakJid2lTbUk2SDRLcEZneU5sOUYwMUZnWXJ5T1lZ?=
 =?iso-2022-jp?B?b090ODRTRXc4aEk1WnFEbGNuUDhURlBCcDdTdSt3bFdHZlBjcU5KV3NB?=
 =?iso-2022-jp?B?bnFlUEo0S3lGb3FtbE1kNFk3RXhScVI2Y3NwTVN6ZUFnb0RCSS9yRDhJ?=
 =?iso-2022-jp?B?amFGcExBNUJodlVUZUpiMGRQa29aY3RCTk4xMGFERWlxRFpsVGtGMmV0?=
 =?iso-2022-jp?B?Ulg1Y05zaXpaMHg5RzNQRTlNeWlFY2Q3dTJwVDRlbWNVWFhOMFRadmxC?=
 =?iso-2022-jp?B?ZU50YW0wZ2pQVzBTMmZSSGJOQ0I4LzZnemhJQmF6WmpRcFZEN1pxY0xS?=
 =?iso-2022-jp?B?bWYwbFBDRjVLdHJsb3Q0R2EvMnNlMTA4ZFc4a0pNd1BaRFhPS21PRGE5?=
 =?iso-2022-jp?B?aEZ4WlVneXpId2dDZTZEaC9ZTVdoblNtVDZoeWFQUVBSU0tmeTU3MG56?=
 =?iso-2022-jp?B?NUZ6dktLd2dxTUY3V2Q3eHVKUUVSRUx2VWlTZ1IzVWxrLzJiaUcwdVhM?=
 =?iso-2022-jp?B?eXJkeDZuMmZ3OTJ1bFh4OUQxckU0cGowbnczTnc1aEZQc0N1bGZNMStp?=
 =?iso-2022-jp?B?K2pUbFNjVlJuTGFJekNCbUxhYWNGTXlZRHZaeWpXWDNOajhUdzFlenZ5?=
 =?iso-2022-jp?B?ejdtZFR2dlhnYkJPL0JqazJNcjNKOEw4azFGVk84aWFTaFFwdk9QUy9W?=
 =?iso-2022-jp?B?cDhiMjFQZFdubXBMTnlSZTFyRklmeWpncTlNUFRZa2Z2OFEzcVNrSVlS?=
 =?iso-2022-jp?B?NHg5VllPRnFleGY4c2FTZUxxeWJxemUyZEMzTzkyTWpRMTdGK1l4NjU5?=
 =?iso-2022-jp?B?ekVneHFPSHRBNllaS0pKVCtndWQrNVBPd2g2S3ZVSmxrVnA0TEFvMnhO?=
 =?iso-2022-jp?B?b1NGcGlINDRSYjQ2eEdJQ3lYWVlXTHdHVzR5eHlLbjBEeGpQYXc0MzB5?=
 =?iso-2022-jp?B?ZUZMMmVWdHpQMk9RQ3IrT0lhdWMxMWpmZE9sTVhIK0xIek9BUmNCT204?=
 =?iso-2022-jp?B?TlpOM0l3c1JWbDdXbU9wamNWTDFjVUM5K2VoTDlEUFBEZFBhR3BGcmk3?=
 =?iso-2022-jp?B?cVFETlArQzkwZEROT1Z6bUJIYXpmTUoxSDNldg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbda506e-19f0-4c42-7684-08dec553e95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 11:48:52.1371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1XRL4jSvD59D2dlNDR9ybC8hMAyPVJ71oxyyzzt8XH9pZm70CQzmiyyiSDHsCLZ+DpAHImwzWlSdNHOw/ZicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822
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

AMD General

Hi Nicolas,

Agreed that pci_read_config() has no lockdown check, standardized PCI confi=
g space reads are not blocked under [integrity]. But amdgpu_regs is not equ=
ivalent to config space reads. It provides arbitrary read access to the ful=
l GPU MMIO register space via RREG32, which is the same class of access as =
pci_mmap_resource(), a user-space mapping of the PCI BAR. That function is =
explicitly blocked at integrity with LOCKDOWN_PCI_ACCESS:

/* drivers/pci/pci-sysfs.c */
static int pci_mmap_resource(struct kobject *kobj, ...)
{
    ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
    if (ret)
        return ret;
    ...
}

pci_mmap_resource() is blocked not only because the mapping enables writes,=
 but because it grants direct, unmediated access to the BAR, the same unmed=
iated hardware access that amdgpu_regs provides through a serial interface.=
 The distinction is not read vs. write, it is mediated (config space via ke=
rnel abstractions) vs. unmediated (direct BAR/MMIO access).

The /dev/mem precedent reinforces this. open_port() checks LOCKDOWN_DEV_MEM=
 (which is before LOCKDOWN_INTEGRITY_MAX) on open, blocking both reads and =
writes unconditionally, because raw hardware memory access of any kind bypa=
sses the kernel's protection model:

/* drivers/char/mem.c */
static int open_port(struct inode *inode, struct file *filp)
{
    rc =3D security_locked_down(LOCKDOWN_DEV_MEM);
    if (rc)
        return rc;
    ...
}

RREG32 on an arbitrary register offset is the GPU equivalent of a /dev/mem =
read of a BAR-mapped region. Blocking it at integrity with LOCKDOWN_PCI_ACC=
ESS is consistent with both of these existing kernel precedents.

We prefer to keep the current approach.

Thanks & Regards
Asad

-----Original Message-----
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Sent: Monday, June 8, 2026 4:58 PM
To: Kamal, Asad <Asad.Kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,=
 Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Sh=
iwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Y=
ang(Kevin) <KevinYang.Wang@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lock=
down

[You don't often get email from nicolas.bouchinet@oss.cyber.gouv.fr. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification ]

On Mon, Jun 08, 2026 at 11:03:05AM +0000, Kamal, Asad wrote:
> AMD General
>
> Hi @Nicolas Bouchinet
>
> Thank you for the review.
>
> The commit message references v1 behavior and is no longer accurate. Writ=
es are already blocked, the existing debugfs_locked_down() in fs/debugfs/fi=
le.c handles writes when FMODE_WRITE is set, the early-return guard fails a=
nd security_locked_down(LOCKDOWN_DEBUGFS) blocks the open under [integrity]=
.
>
> The patch addresses only the read path. Here is why reads are not blocked=
 by debugfs_locked_down():
>
> static int debugfs_locked_down(struct inode *inode,
>                                struct file *filp,
>                                const struct file_operations
> *real_fops) {
>     if ((inode->i_mode & 07777 & ~0444) =3D=3D 0 &&
>         !(filp->f_mode & FMODE_WRITE) &&
>         (!real_fops || (!real_fops->unlocked_ioctl &&
>                         !real_fops->compat_ioctl &&
>                         !real_fops->mmap)))
>         return 0;
>     if (security_locked_down(LOCKDOWN_DEBUGFS))
>         return -EPERM;
>     return 0;
> }
>
> For a read-only open of amdgpu_regs (mode 0400, no ioctl, no mmap):
>
> 1) (0400 & 07777 & ~0444) =3D=3D 0 =1B$B"*=1B(B true - any mode with no b=
its set outside the 0444 mask (e.g. 0400, 0440, 0444) 0400 satisfies that.
> 2) !(filp->f_mode & FMODE_WRITE) =1B$B"*=1B(B true for a read-only open.
> 3) No unlocked_ioctl, compat_ioctl, or mmap in amdgpu_debugfs_regs_fops =
=1B$B"*=1B(B true.
>
> All three conditions hold, so debugfs_locked_down() returns 0 and the rea=
d open proceeds. The read handler then calls RREG32, a direct hardware MMIO=
 read, with no further lockdown check. That is the gap which this patch is =
addressing.
>
> Thanks & Regards
> Asad

Thanks Asad for your explaination !

`LOCKDOWN_PCI_ACCESS` is used in the `integrity` mode of Lockdown and shoul=
d be used to protect against Kernel integrity tampering.

IIUC your issue, the access is read-only and thus, you should use one of th=
e existing `confidentiality` lockdown_reasons. You are free to add a new on=
e if none of the existing one covers your use case.

Best regards,

Nicolas

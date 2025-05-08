Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28592C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 15:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3EE10E1DA;
	Thu,  8 May 2025 15:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7JzuTxr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0C310E1DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 15:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot5s3CU/hZL3q71ZC+89z846h5qmRJEsVr4clU8FH6Haa70Mg8lOBR0rh1PiTKRD+hNiq09InhTEzxrbdLxwbxK7Qiv8bAAxXq3e2pK7w5QRB+HBaCRhqtzDJSJjeZ9wPjYSBhCO9+gIq4jRd9hfcF1B00OJ17yod4QpP0KcmGJD9AppgYYmn8c4zGhng1oIO4p88DzPAWmJ/+lPyC0cuvnh/LNDpWQqZ/5c+pdE0WQt/VAoM3gUZPPwP0n4RvVZQbjSqaGFtzlS6ZoLFEctsmf/MXB1hgTAlnuUMK9cQVg21T43FTQPs7VWNi+jOIBfpa32flZP0y7frpqdoksMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np4QqQLFSfaKIROLXnAXkEdCkOyrqUtkUUJJEdGQNSI=;
 b=TTkymnJJgzMqkRj4u7qjwf68oW67GqI85k4IprOZ8NZbve0xCF04PMng6c+I2PEuBVHOY8tkhCRFkIkKJkDHMjkaGnoCnVUtBPjjTLfYq5rvJZm7rntt9vr+651iJWBk5qg5bWHc4Ub3HG2pQqP3/1d+9m2azuP81JYO4mTaeBxrafRWxXFDn0VQ0yLn8sfLVZKU8y+k4RQPeVTGEJo+2Pn4AqZe43UdbXY1OG3evDTlTw2BBapY1Hrq7znuXcI3/F1TZSC3U2Bzw51NyxB96GA8ElCXv+nV8hjvyVmHGOyTwJNJVvJDz93qY0YcJaH5JT61+b3sRTJ8Yrk8GpmGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np4QqQLFSfaKIROLXnAXkEdCkOyrqUtkUUJJEdGQNSI=;
 b=n7JzuTxrMwXCdv3EEG/7UdSAH6MC+4hqVfV0EIX0pLA7NxhYoi6dLu//qd1yfubl9xiAKxEYOkAFD+iFEFLjpOvcBJ3zBi8/4Chh13By36W8AcelfukjB5sYrXl3tGhJK4Nj0K8xCufYuWgn9mgf91gY/GHYaf4BpGh9Xk5CH/Y=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 15:24:19 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::628b:cc72:7a93:6bdb%4]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 15:24:19 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwCeDYqeX33JUdk6APEBqF96KKrPI0vOAgAAGKj8=
Date: Thu, 8 May 2025 15:24:19 +0000
Message-ID: <SJ0PR12MB696796D6657E5F2D61A47C8E9D8BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250508144248.388934-1-cesun102@amd.com>
 <BN9PR12MB52577F161A63C9DB4C96AD49FC8BA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52577F161A63C9DB4C96AD49FC8BA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T15:24:18.609Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SA3PR12MB8022:EE_
x-ms-office365-filtering-correlation-id: b77f23ae-4698-47ca-ad9f-08dd8e4466e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?B+sR+q7O+q8dhpIfR7YdRQL6GOosNnGzVuB4G29eB0WPAuLyHC4YgzL6pdZb?=
 =?us-ascii?Q?vsLZ5g0At0KPJazJCBUysyUW+MJd8mBx8Bo2D8VixgzmxrCxTNCIlZP1rZT1?=
 =?us-ascii?Q?dMWtxLnWAZqX/g44AB9X82Ys6Q4ncYxHsYfY/Q2y17yCktWAqYb4fFeV0Pkg?=
 =?us-ascii?Q?j1jzhOtItiUgdli+yUwbtdoAkbx6Ez2JHypGHsw9E2SWATkUF1BYx4W8d2Xf?=
 =?us-ascii?Q?Cc8P0WFplfP2Isplf6Ld0nu/IqhHM4yy7+XMntXMjvSEH7G7jKFV76l5iZhm?=
 =?us-ascii?Q?i8mv9+DJ0hpnY7iO6fQJWrK4jeXzvp1CrySud9juondg+ZcilSAG3fXEzqUS?=
 =?us-ascii?Q?o+GIBu3Zyx48Os9u39MLvS7BGWso7XB6b/ogQkdUrVgm1FbYs8OburuLe50b?=
 =?us-ascii?Q?vGnmh5SWbgO0V5+da+eZFBOIhYDBl1qIWzUWxXsahIECsxH74j9stA4eQv/L?=
 =?us-ascii?Q?Askel00WmR+5kZSBa/DZnm9vsRXN7BqLxnn5JeS98c2VOS5dU4G8fb/adIDo?=
 =?us-ascii?Q?7b0Vjay3T25OSEvV49wQRA3xyUEtXcH0ipouVDQ9KEkrW74uTMrvHSMih3ka?=
 =?us-ascii?Q?1hfK9EpyHBdl8Uw4kodoTlEV3U2m1mcbzzv88Ro+Z/rjvqxPiUcMmUq/mJv/?=
 =?us-ascii?Q?8xVTIjXJB01Or2ST8VRGXq+OlrP8dmnMjEehaaVFF4cHmF+Yi3VztnnBYgvQ?=
 =?us-ascii?Q?xJXKpOOYFx9DrDJR8XuobFfZ699QQE3jdx/bvZSC+jng9wMJP8XKJUw5VIqO?=
 =?us-ascii?Q?xOcOvCj/v/5tj1Xk+ajabnyaB6X0rFJ/0BpHi2ZCKDYj5MzPiDRvFYcp+eh3?=
 =?us-ascii?Q?DoAHoMLF6R6RhtuZR22bef9Ky6WpZU4dJb6Wbc2wcrpKNC5yVzd5WSD/GxfP?=
 =?us-ascii?Q?+Op0P1FJR8Zi3GRoSsBwMw7n9P1+8NHz4GcL6MkenfLsnMr20Xc33Gd+btGu?=
 =?us-ascii?Q?pmFgxjJKitsa33V9Egs+AYZ0UD4s2rHh4f9LkiE7G8033aZrvwWadw1RKu2B?=
 =?us-ascii?Q?1pOR2yfpKW9cpn855F9sL7tEg1aJ4H2EtbtK4/FieZ1zwJKNdcSC6lpYlYBe?=
 =?us-ascii?Q?vRdFmWw1A4+2niySvpoX+ehrge+0JZZacPxKmWVbS537F4Ah/vm/tDRJaDFv?=
 =?us-ascii?Q?BpW3j9OGhox+F2imofNLn1WeSpIbd6hfZCa9mG5x+bcO6VmQCHt7t6LmJSaW?=
 =?us-ascii?Q?3g/nbgQOpYE54T3nK09x+wXzLHC/mS/SItNaM5FdC53WDzmkPtp5t0QyVL6O?=
 =?us-ascii?Q?z6nFmRIRMyFTAn+pekklwpSNSC1a7acp5x52Wu+S7dxmbA7Via7sa6ymtAKe?=
 =?us-ascii?Q?FvN82Ztjseht489sqfRz0Rpk0xJA8RLugMTwc9Zrzd5CNGV5MMKZ9VhQFh2Z?=
 =?us-ascii?Q?Q+0mkqdbI1vMLb/sSFbl4Ph3ku+OrNLlAKJ+lhhz4pDws268RfywlzyGG74N?=
 =?us-ascii?Q?BvKf4FrvfC+PYyq1kO6+NZwCp8x92BfXRHGh2kDnfXPJgElMOmZWDg2fATSw?=
 =?us-ascii?Q?nLzN444k10P8XfQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?roumNlvcEm3pbe1rHhManzUO35OK/ldodFE2MW62Ilp0iTzwxN8UaGdJ807x?=
 =?us-ascii?Q?oxZQul7gcdFCuHgf47PxNVif93An1uzegVEc1wZX9sQ4DUErdTh+xc9SkKaL?=
 =?us-ascii?Q?TGaP5UF6zMDuoE1nuRQ0Lycl4B2b3NnQM2dkUshHTtHz+I9Qvm6SvVHYyJKv?=
 =?us-ascii?Q?tfGSWzRsos3nNqF/XzBktmGvg+JPlS75aFf2zjgCKvcRuGlr+EK11RHEhtg8?=
 =?us-ascii?Q?HRzLqux9umFQ1S3e0t1FlP6aDCe/UE4iVZw8W41NplgJq1nk6cGjxWwGdUHy?=
 =?us-ascii?Q?a3zGJqj0dS/YLKtEhcoBKoDq/bmakBxiwmHxTOzKmuLkGF/Vz7gOdzyRL5ea?=
 =?us-ascii?Q?EaFoPczifJHNti8fSaY2U8GrWbBNXEjhIFzkzhlV91e5cBM7jFL55X68xkjk?=
 =?us-ascii?Q?/DMORR6iQYvIFPSF+j3xK345wNmEtwLy1z+FACPxe+m716SfulRi5IbHidc5?=
 =?us-ascii?Q?D8fYPUn+xenBGLNHKrKdrPojFwnNSbPrqbKxU+9o9hg7M9c5H/51tWxw7/DF?=
 =?us-ascii?Q?nHPYAgBGjFMYD/UD3dF4OkEr60SiBgIkc/osU2zeeCoi4YOGUoC9EFaiicLX?=
 =?us-ascii?Q?4Os0O0eYRjtqZVjc6urhw8+z+UXBsjx0/zCteU5Lz9JQSrIAL3VIaENp5iHg?=
 =?us-ascii?Q?Dnu6lUSyC8n8rGgZdHa8EQeorenXWcnEFCKzBg54DmJBg029IqlxVz//hURY?=
 =?us-ascii?Q?9MQ2dg4VND2sltSDTw03bAiWCMwz+GpB2bqG6P7ZlGDk98ZVH0XuVK0HQ8ec?=
 =?us-ascii?Q?ZINr/ZYwAzJ5o7leWSnjT6E0XPTbNBbar8SBVVIeAIpcJNm5dV4aox5j0cxT?=
 =?us-ascii?Q?IaB6oEWJhzBjyN0HjxQ/ipD82boIJTd9eRwejRENEz6FP4eYptz83C76/uoF?=
 =?us-ascii?Q?E2cjYISY3y6PpoNNTFcwvuB7EQFh0dfV23luJax6XEUFaT3cpQre3CD9UE0H?=
 =?us-ascii?Q?e+rhx0yxz8D1a8/PISWqIIu5YF/3DYRCUo2vzT9Z52PTJS28tTSBKxeihPVE?=
 =?us-ascii?Q?RbsljMwas6kxcoIxvifMPgCX1fcjlZ5eqE3ndF7E4DwCsYw+yq6rsbj5iGmi?=
 =?us-ascii?Q?limehy1pa56D1rfN3MnZXFWKkbKEWAtt5+913SMccSFTlujai8H800vTIJnz?=
 =?us-ascii?Q?Kirj9+4MT8iMw7vUTHybmLmH+eBnlVAw2eTXWSJmKpT62Xmk2m+vFl7+WbIK?=
 =?us-ascii?Q?CqIZAxCSAUNtfdPvmVvjcLeUvDWbpguNjUx+dX8o/FU5XrEIoO6tW6Oop6Qa?=
 =?us-ascii?Q?W1lMosfWZM5WeRTg/R6U2t8xHYfMWdWwmUhvnIt7hppwczvUHDzSAYSa1Ky/?=
 =?us-ascii?Q?8fh9onioMnn4EjZNy2IsprviS8+HAJhCYSeDqPw2coF5cPV8Yy0EJgdfrRDb?=
 =?us-ascii?Q?qO4Yku3I8aAJ/M0TKh+Z3mEkNtf0z7xVy/T+RlemDdHzhqDp8xwEsWZlt/x3?=
 =?us-ascii?Q?T8DilokfS4j7ZasvilXrTAKK1/Z0BrYkNF6oLYBLqv3B+ffKeopxiPgZw/cY?=
 =?us-ascii?Q?KBD9yNllQWfFb/vjrSBsW9EhlTQ4T3HqO7LgifeosJ1K6QB5yoxPcHvH5lo2?=
 =?us-ascii?Q?joKjfIigoTUpBaqM//8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB696796D6657E5F2D61A47C8E9D8BASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f23ae-4698-47ca-ad9f-08dd8e4466e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 15:24:19.1764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQOb0E7LEM1gp+OFhQcHLm8PPgpDpZbqks7bmVv/lusBb9QkbMWLX1AX9Y6+3HOACHVL/HpK5XHp5TYX6rVgtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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

--_000_SJ0PR12MB696796D6657E5F2D61A47C8E9D8BASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Hawking,Yes, multiple warnings will occur, and the chain reaction after =
multiple warnings is kernel panic. Therefore, it is necessary to determine =
in advance whether the interrupt source has been enabled here
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, May 8, 2025 10:58 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records=
 exceed threshold

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
         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA); diff --git a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
xcp.c
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
                         amdgpu_irq_put(adev, &adev->nbio.ras_controller_ir=
q, 0);
                 if (adev->nbio.ras &&
-                   adev->nbio.ras->init_ras_err_event_athub_interrupt)
+                   adev->nbio.ras->init_ras_err_event_athub_interrupt &&
+                   amdgpu_irq_enabled(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0))
                         amdgpu_irq_put(adev, &adev->nbio.ras_err_event_ath=
ub_irq, 0);
         }

--
2.34.1


--_000_SJ0PR12MB696796D6657E5F2D61A47C8E9D8BASJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Hawking,Yes, multiple warnings will occur, and the chain reaction after =
multiple warnings is kernel panic. Therefore, it is necessary to determine =
in advance whether the interrupt source has been enabled here</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 8, 2025 10:58 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS =
records exceed threshold</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Calibri" size=3D"2"><span style=
=3D"font-size:10pt;">
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
 enabled 2.Fix the memory leak caused by the device's early exit due to rma=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
first reason:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.246650] ------------[ cut here ]------------ [ 2744.246651] WARNING: CPU=
: 0 PID: 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635 amdgpu_irq_pu=
t.cold+0x42/0x6e [amdgpu] [ 2744.247108]
 Modules linked in: amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)=
 amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft=
_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
 nft_counter xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge=
 stp llc overlay binfmt_misc intel_rapl_msr intel_rapl_common i10nm_edac nf=
it x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel nls_i=
so8859_1 kvm rapl isst_if_mbox_pci
 isst_if_mmio pmt_telemetry pmt_crashlog isst_if_common pmt_class mei_me me=
i acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad =
mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr=
 ramoops reed_solomon pstore_blk
 pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zs=
td_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xo=
r async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]&nbsp=
; linear mlx5_ib ib_uverbs ib_core ast
 i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper crct10dif_p=
clmul syscopyarea crc32_pclmul ghash_clmulni_intel mlx5_core sysfillrect sy=
simgblt aesni_intel mlxfw fb_sys_fops psample cec crypto_simd cryptd rc_cor=
e i2c_i801 nvme xhci_pci tls intel_pmt
 drm pci_hyperv_intf nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinc=
trl_emmitsburg</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.15.0-=
70-generic #77-Ubuntu</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247197] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.AG.2 =
11/21/2024 [ 2744.247198] Workqueue: events work_for_cpu_fn [ 2744.247206] =
RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e
 [amdgpu] [ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 55=
 d4 e8 90 09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0=
 75 07 &lt;0f&gt; 0b e9 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 =
4c 89 [ 2744.247636] RSP: 0018:ffa0000019e27cb0
 EFLAGS: 00010246 [ 2744.247639] RAX: 0000000000000000 RBX: 000000000000000=
0 RCX: ff11000150fa87c0 [ 2744.247641] RDX: 0000000000000000 RSI: ffffffffc=
2222430 RDI: ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0 R08: 000=
0000000000003 R09: ffffffffffe41a08
 [ 2744.247643] R10: 0000000000ffff0a R11: 0000000000000001 R12: ff1100019f=
22ce60 [ 2744.247644] R13: 0000000000000000 R14: 00000000ffffffea R15: ff11=
00019f200000 [ 2744.247645] FS:&nbsp; 0000000000000000(0000) GS:ff11007e7e4=
00000(0000) knlGS:0000000000000000 [
 2744.247647] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 2744=
.247649] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4: 0000000000771ef0 =
[ 2744.247650] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000 [ 2744.247651] DR3: 0000000000000000
 DR6: 00000000fffe07f0 DR7: 0000000000000400 [ 2744.247652] PKRU: 55555554 =
[ 2744.247653] Call Trace:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247654]&nbsp; &lt;TASK&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.247656]&nbsp; sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]&nbsp=
; ? vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]&nbsp; amdgpu_ip_bl=
ock_hw_fini+0x31/0x61 [amdgpu] [ 2744.248776]&nbsp; amdgpu_device_fini_hw+0=
x3bb/0x47b
 [amdgpu] [ 2744.249197]&nbsp; ? blocking_notifier_chain_unregister+0x56/0x=
b0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 27=
44.249202]&nbsp; amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 2744.249482]=
&nbsp; amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [ 2744.249913]&nbsp; =
amdgpu_pci_probe+0x23e/0x590 [amdgpu] [ 2744.250187]&nbsp;
 local_pci_probe+0x48/0x90 [ 2744.250191]&nbsp; work_for_cpu_fn+0x17/0x30 [=
 2744.250196]&nbsp; process_one_work+0x228/0x3d0 [ 2744.250198]&nbsp; worke=
r_thread+0x223/0x420 [ 2744.250200]&nbsp; ? process_one_work+0x3d0/0x3d0 [ =
2744.250201]&nbsp; kthread+0x127/0x150 [ 2744.250204]&nbsp; ?
 set_kthread_struct+0x50/0x50 [ 2744.250207]&nbsp; ret_from_fork+0x1f/0x30 =
[ 2744.250212]&nbsp; &lt;/TASK&gt; [ 2744.250213] ---[ end trace 488c997a88=
508bc3 ]---</span></font></div>
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
 amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack nft=
_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat=
 nf_tables nfnetlink br_netfilter
 bridge stp llc overlay intel_rapl_msr intel_rapl_common i10nm_edac nfit x8=
6_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel binfmt_mis=
c kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_telemetry pmt_crashlog isst_i=
f_mmio pmt_class isst_if_common
 mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_po=
wer_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_d=
h_alua msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables=
 x_tables autofs4 btrfs blake2b_generic
 zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async=
_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath [ 5139.303572]&n=
bsp; linear mlx5_ib ib_uverbs ib_core crct10dif_pclmul ast crc32_pclmul i2c=
_algo_bit ghash_clmulni_intel aesni_intel
 crypto_simd drm_vram_helper cryptd drm_ttm_helper mlx5_core ttm drm_kms_he=
lper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core mlxfw psampl=
e intel_pmt nvme xhci_pci drm tls i2c_i801 pci_hyperv_intf nvme_core i2c_sm=
bus i2c_ismt xhci_pci_renesas wmi
 pinctrl_emmitsburg [last unloaded: amdkcl]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G&nbsp;&nbsp;&nbsp;=
&nbsp; U&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.15.0-70-gener=
ic #77-Ubuntu</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303590] Hardware name: Microsoft C278A/C278A, BIOS C2789.5.BS.1C23.AG.2 =
11/21/2024 [ 5139.303591] RIP: 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5139.=
303605] Code: cc 66 90 0f 1f 44 00 00
 48 8b 47 38 48 83 c7 38 48 39 f8 75 05 c3 cc cc cc cc 55 48 c7 c7 18 d0 10=
 c0 48 89 e5 e8 5a bc c3 c1 &lt;0f&gt; 0b 5d c3 cc cc cc cc 90 0f 1f 44 00 =
00 55 b9 15 00 00 00 48 89 [ 5139.303607] RSP: 0018:ffa00000325c3940 EFLAGS=
: 00010286 [ 5139.303608] RAX: 0000000000000000
 RBX: ff1100012f5cecb0 RCX: 0000000000000027 [ 5139.303609] RDX: ff11007e7f=
a60588 RSI: 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RBP: ffa0=
0000325c3940 R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.303610] R10=
: 000000000000002b R11: 0000000000000001
 R12: ff1100012f5cec00 [ 5139.303611] R13: ff1100012138f068 R14: 0000000000=
000000 R15: ff1100012f5cec90 [ 5139.303611] FS:&nbsp; 00007f42ffca0000(0000=
) GS:ff11007e7fa40000(0000) knlGS:0000000000000000 [ 5139.303612] CS:&nbsp;=
 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 5139.303613] CR2: 00007f23d945ab68 CR3: 00000001212ce005 CR4: 0000000000=
771ee0 [ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000 [ 5139.303615] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7=
: 0000000000000400 [ 5139.303615]
 PKRU: 55555554 [ 5139.303616] Call Trace:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303617]&nbsp; &lt;TASK&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.303619]&nbsp; amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm] [ 5139.3=
03625]&nbsp; amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]&nbsp; amdg=
pu_bo_fini+0x27/0xc0 [amdgpu] [ 5139.303959]&nbsp; gmc_v9_0_sw_fini+0x63/0x=
90
 [amdgpu] [ 5139.304144]&nbsp; amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu] [=
 5139.304302]&nbsp; amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.304=
455]&nbsp; devm_drm_dev_init_release+0x4a/0x80 [drm] [ 5139.304472]&nbsp; d=
evm_action_release+0x12/0x20 [ 5139.304476]&nbsp; release_nodes+0x3d/0xb0
 [ 5139.304478]&nbsp; devres_release_all+0x9b/0xd0 [ 5139.304480]&nbsp; rea=
lly_probe+0x11d/0x420 [ 5139.304483]&nbsp; __driver_probe_device+0x119/0x19=
0 [ 5139.304485]&nbsp; driver_probe_device+0x23/0xc0 [ 5139.304487]&nbsp; _=
_driver_attach+0xf7/0x1f0 [ 5139.304489]&nbsp; ? __device_attach_driver+0x1=
40/0x140</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304491]&nbsp; bus_for_each_dev+0x7c/0xd0 [ 5139.304493]&nbsp; driver_att=
ach+0x1e/0x30 [ 5139.304494]&nbsp; bus_add_driver+0x148/0x220 [ 5139.304496=
]&nbsp; driver_register+0x95/0x100 [ 5139.304498]&nbsp; __pci_register_driv=
er+0x68/0x70
 [ 5139.304500]&nbsp; amdgpu_init+0xbc/0x1000 [amdgpu] [ 5139.304655]&nbsp;=
 ? 0xffffffffc0b8f000 [ 5139.304657]&nbsp; do_one_initcall+0x46/0x1e0 [ 513=
9.304659]&nbsp; ? kmem_cache_alloc_trace+0x19e/0x2e0</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[ 51=
39.304663]&nbsp; do_init_module+0x52/0x260 [ 5139.304665]&nbsp; load_module=
+0xb2b/0xbc0 [ 5139.304667]&nbsp; __do_sys_finit_module+0xbf/0x120 [ 5139.3=
04669]&nbsp; __x64_sys_finit_module+0x18/0x20 [ 5139.304670]&nbsp;
 do_syscall_64+0x59/0xc0 [ 5139.304673]&nbsp; ? exit_to_user_mode_prepare+0=
x37/0xb0</span></font></div>
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
 00 f7 d8 64 89 01 48 [ 5139.304687] RSP: 002b:00007ffcb7427158 EFLAGS: 000=
00246 ORIG_RAX: 0000000000000139 [ 5139.304688] RAX: ffffffffffffffda RBX: =
000055ce8b8f3150 RCX: 00007f42ffdbf88d [ 5139.304689] RDX: 0000000000000000=
 RSI: 000055ce8b8f9a70 RDI: 000000000000000a
 [ 5139.304690] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000=
000011 [ 5139.304690] R10: 000000000000000a R11: 0000000000000246 R12: 0000=
55ce8b8f9a70 [ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce8b8f2ab0 R15=
: 000055ce8b8f9aa0 [ 5139.304692]&nbsp;
 &lt;/TASK&gt; [ 5139.304693] ---[ end trace 8536b052f7883003 ]---</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_fence.c |&nbsp; 4 +++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp; |&nbsp; 2 ++</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp; |&nbsp; 4 ++--</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp; | 15 +++++++++++----</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++++--<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp; |&nbsp; 6 ++++--</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 6 ++++--</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">7 fi=
les changed, 30 insertions(+), 13 deletions(-)</span></font></div>
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
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB696796D6657E5F2D61A47C8E9D8BASJ0PR12MB6967namp_--

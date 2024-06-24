Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B07C2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 14:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD4610E461;
	Mon, 24 Jun 2024 14:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kx9q+Ko8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6259D10E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 14:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5db5ykuPlf1xdIuAM0PFre7dSol3LeNav88MdB4WSvDndMGbVA6OfF4DcGKXIfw4wMF8Bcbf90yFHLkqW36Ru/eQSW0BI493yb2MtpOICOi35+g/DyCA4wdzI9uGxrXfyahUPIVMvjjC0PRKSJ3GdH4kpp+pqbKIHIuPOfLAIgzcrST/VQVbIgV6YfyGL97kNOkUVMD6aGueuS+Dw425vgUjINziKOI8WUyHSoLuMv5PbcWDZSYbRKeq8kxtSwU6GRx0tIq3VnAd4MJfe9ZHOYt2/u02hvNAAtA3LDsLi5m5+aopguzJYNzbJjE6zisp85X94xDW5oR3Fw8xwJKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efVAtfqVwu4Ey5oPQG/ZhJZaI6BOiZG+tWTF/HwwSyE=;
 b=Jzja2x9tzBW8hxbYKUJQtNXBF8azYxs+o4gIZ15FWkA1keNPATUirgUi+CL0cwntb7dY8lJnxC2s44eDziTfQUvGX1OuETlNUhbEhrRBN43gS1fTXFQdlwACjwHXQvP7EzBqWAfIDtU7RpA9k+ILV+9KVZb+6fUvEzowGTflDM+zX3dfFM1+b2r9PrXq+a5LMvgTVot2UKTkZRNG59Qai4DyNmevhDqAFaaMlZIT9+Yp9sbhIN4kerEzyiJV7pHXZPjWiUc1vfIyXKVdlkRtcvrADBM9NI1Z67Azze3tuBcSdXtktCkUjTjfb51vsQEl9vKy5iIVCWVsMMZmjTz5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efVAtfqVwu4Ey5oPQG/ZhJZaI6BOiZG+tWTF/HwwSyE=;
 b=Kx9q+Ko85kwgaGi1IzGUEyqL7TiTYHWapWYL1JdZ9N/4YHkrYEOMKXMZayQut8AbhGWlK7mcxN3uIaTQl/mVQ7GYHB6A0mwpeOsCCdNSgD1Z8QJMuWDKviITXFKFpLR0s8zGpyWkhAQxOnc1VUBZiHTWhZk5TmT/pjAp/NUN1VE=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:11:55 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7677.033; Mon, 24 Jun 2024
 14:11:54 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHaxkAAQRjxT8NSbEaJ/sQFDJ4CDbHW88kA
Date: Mon, 24 Jun 2024 14:11:54 +0000
Message-ID: <SA1PR12MB8599C435AC699BDEAAC26830EDD42@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240624140815.18085-1-Yunxiang.Li@amd.com>
 <20240624140815.18085-2-Yunxiang.Li@amd.com>
In-Reply-To: <20240624140815.18085-2-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d27d2008-544f-437c-a2da-45bae13460c6;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-24T14:09:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CY5PR12MB6226:EE_
x-ms-office365-filtering-correlation-id: e6a6bbfe-2ea2-4873-d525-08dc94579a1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?Hz/9o4VVGWoharb0pN/s2Erv0s0kaa8O6XcVdwxw80O/OOlWtk+LUH7QT6JV?=
 =?us-ascii?Q?/kcT/JXhAT/di76EJJKVTd4AwJjfqtbBQ2w6qduslsQoCJ7Ihl+8yyvW3PL3?=
 =?us-ascii?Q?nHMluQohfJYOJjouksS7dMF1/412Nh949x59NTe87ngARZo1rqVHJXP6JJuw?=
 =?us-ascii?Q?2AGnsWwkjm4dD+352tgb3KwmOY/oWdaTu3lgHoRM+5RVOPAlXxaBMYhkXXub?=
 =?us-ascii?Q?24iqSrA0dUb/DfT/PdDdkH+2NemsGn86wLjbhYVGsuWaNHmifeVcgZhu6+nY?=
 =?us-ascii?Q?tZSbhVtjYPmM3CHtrUCqRxgqxdzgRa7S16pvOBeoGOrKhCz13+gUNrO2ty7Z?=
 =?us-ascii?Q?LW8q2yvojPQR5HiTTc9i4JT3dAhGm2UXM78dHYpc8UsKsOU5wBXNkSWHujIN?=
 =?us-ascii?Q?NfOhUYoQly7ANXL2VccyqmnU8177WZp+tFwsK4/xJ6pXyHaI5yah01MTxoZX?=
 =?us-ascii?Q?RY/z7uBc/M11AQJuC7lJQVcYEd+RXNYjPYiovg3rI2OPspBjTYcRGFJURbPk?=
 =?us-ascii?Q?R9kc396Ou1vuGDBWDtq7gUi+LYxuaTJ+yabfC9nHZYkxPaUUBbVmaTVTfdTl?=
 =?us-ascii?Q?aqumrRU2ttKxZUIkWucwE7C6376FcC7ovOrB9WD1G1rwu1SojiIV23sXLB2H?=
 =?us-ascii?Q?/Tsceya/91BpLiefxMVdvZrf0V4xlGiUSc2YBgECU/BNboVqooWN+TddX5tq?=
 =?us-ascii?Q?1rrhXcd5mYGgdlykgUn9dc98ZD4pr+xQtKvJ0JqBOrAMNno5rTRfthrULCVw?=
 =?us-ascii?Q?qBTpi00u0/hkbNe15Z0IUDz8sXa0GuPj300Gw7AxjZk3D8xDLF3+RsCMJx3O?=
 =?us-ascii?Q?QCE8wK1AwwczizIKlM8gnLz6CFPZd1kcSXdk/vwFGG58HuQI++Z3kF6iuq80?=
 =?us-ascii?Q?Nx6aIBs2uh5oyRO9wwxIkck4TUazgHuINPDrrEbXNh+sjcY+9bY9klAvhi18?=
 =?us-ascii?Q?He3Rh+YGG70BSrwdqrxACvFaLpzxEcfEZFX1jFQNhj3uILZDSocbhFPqmiSy?=
 =?us-ascii?Q?9eIlxOzTiyy9ChukP50AmseFYyqAw+IW62FAfAuDAM89/zyUeq6zohe5eSfo?=
 =?us-ascii?Q?w0PLj458B1/a8aliModABZEl/B2yft0BW07+Kw+uTx79fA+P7HsL2Dl+k00r?=
 =?us-ascii?Q?3a+QRVbezq7cAdBA+fRhdje6cnRzOllBPw7B6YGjdUSphQgUbW4aaUrxLdF7?=
 =?us-ascii?Q?NMvcEB8HFLZVHr4Njf4bgGJ+VsaGtZdSccgqy6SFIXn7pMTRP0kdZYmcksOV?=
 =?us-ascii?Q?ky8MCa91eJLoWkoTvkypCqqiTLdfwTcD9wa3coBj8c7LNu1OWC7EezGof0sX?=
 =?us-ascii?Q?pg6IpDaFmE6EdMhNXHp9PH05DZ+xlqanDRZBo+emVJEBg52GJbKLz8vmm4XC?=
 =?us-ascii?Q?Y2atJ2A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e7ASxdeocDv4gIH6OXPvl++TDw0rJZrdkyU5c+FAtJxygSQvYiXkMfYJm7TY?=
 =?us-ascii?Q?XuZeoQznoDUv+IaHaWItaPMh7VDhhWVJamIbMH6yIXPQDRdg7d3RmLhtFaL7?=
 =?us-ascii?Q?zyUWAg9GB0xSQuOB1LF9iWvD94WbtM5XAuVitps6IOWeu3EMwUhjyLe0BB2S?=
 =?us-ascii?Q?GwfptqovgsI7OG9svVsCVik8LqQA6IkEQCa0xvtYnfubGAUt2ARAshYzA/Xa?=
 =?us-ascii?Q?3O4XT+vuoIFvdmW0rzH9k+k3zkHJ0H+Lkp11vzJx/zNAGyCmQwj5W26DE3Q7?=
 =?us-ascii?Q?p0x5E4fFEPFffMC8W9pdW2yPkrMjcE/fDC7ygO2fP4cNn7eponX1fsvuBaxK?=
 =?us-ascii?Q?Vg5YcO1HsfAZwoC+RADK1t4QMcU5KJE81tswiijKSFS5vjxPn4pcVqKR66kf?=
 =?us-ascii?Q?y7C5gyi0pNZoIRluud4lgorZSDz6lItrEHajFgUncqLSbGG44a49u9oZFmqH?=
 =?us-ascii?Q?3Ojg3AWSIj6z2N8TwuBA61vrJHpL6VnhM/wevlbiYHYg6rVLmc/xBtCg22PK?=
 =?us-ascii?Q?gcEamd+9MmaCAxZawT3uN9NGrHCmIO7twNUtG73NPxGi0WDISIfmEkCooXJQ?=
 =?us-ascii?Q?dWMVmkVF3dlXpXbAVIWWDm57hcEmtWR1tuxUV0k1dE353yzGHmmfefjVc0o/?=
 =?us-ascii?Q?A0Cz2szhL4wf0hGBgqKGvEd+1FmZZU9NUotRqFxWAN9U5LOPpEJXpx827kyh?=
 =?us-ascii?Q?FjEwpoV9GhTz7GwVjQksEdF74oW9ScSxPEzKlWsZC8NS69aYQnf97+do3IE3?=
 =?us-ascii?Q?xRmNJlWmn73uWU5dFpmBAik/spr2UPXOXedccVsjCn2zrKkUKGnd8lh2ahdX?=
 =?us-ascii?Q?UuG4eZMZXIBLvrwlaXnJId4vNkdV6vPaQ5VHjkchqCd24TaAIBsma0kPL7Us?=
 =?us-ascii?Q?dZpiYSg6NyInONMCZIhXF7wpeujjWwoQcFFS8gVuvJOB/dkCKIxrtRrtUAhl?=
 =?us-ascii?Q?0FUw9guCKFqCR41UnYcE0ERgdzWBRZ4YtQEqzQgmL2Dn6mkGHPd7i/KjaDWO?=
 =?us-ascii?Q?a/EZHXH/3O/Tmvr64lPDBgSFPzsXUmvvJf5juMLUYQbFyKQ/9P0/Rsjum8M1?=
 =?us-ascii?Q?LnF2pn0xSVdRktFaVlRHwrTQ2K/Q/Wd5DGctu/LP93pjRkSO6PPK8tSOlaRa?=
 =?us-ascii?Q?8ZHpwNFcRWgipd/i364xTP9bO8UuDHHUJZwnh335273l71JnYA/BEO/9Uubs?=
 =?us-ascii?Q?zEAvjOW6BGmcSGo/NFGiqGC10NaCtb2G059krK43yk0Xwmo7xH6Qm/DiTSlP?=
 =?us-ascii?Q?jWtklt2ZYcdM36y0OUu9orHVrCkub3fUVU4CkuSNkoa2hl9hYEO18gQSs9+d?=
 =?us-ascii?Q?ABqGKsEbqxarNPQL6r4oZ2ugrnyruC4E3Og803MOFGXYU9UGpj6+KkRbViFL?=
 =?us-ascii?Q?VgJACNo+pWpt6yqZSgBSGYy8kk4m2zOq+WT5/prRej56gJ0CFn/EK5LlQN3V?=
 =?us-ascii?Q?E49WwfIgDjdbfnvZtNfL+GACdLUw+4rb1AW0AUANtmuCuC+TLrur+z9LbDqB?=
 =?us-ascii?Q?9xiZ5WV0ADoe/Ruuz0k/Jol4YojV3Y2DGHYv8KaeWPf4sESUZQkTgXP9YRTP?=
 =?us-ascii?Q?77BhFCWVZqiNSHPKRfc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a6bbfe-2ea2-4873-d525-08dc94579a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 14:11:54.7836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7K00B3fnTtgCOdt9YThVwvxPzEDtM8ik7UcTJM7fk7fgznprdjcewVPTOxgMzinG2f8A8w/bZ5CyvtrQgOVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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

[Public]

I'm not happy with the new helper names, and not quite satisfied with the f=
unction arguments either. But it's what I got right now, would appreciate i=
t if anyone got better ideas.

Teddy

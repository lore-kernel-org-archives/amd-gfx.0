Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073D4CA5FAB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 06:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA29889BE;
	Wed, 30 Sep 2026 06:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vvkXguJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CA410F1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LICnal+Gp/9vOiOue4d++FNq+3Ytakwv6MhCstz7P++F2h4RsvY5rTHIpQySkImTXPhoYg4DW90evIReorE+lVdYqdJunP9ljaWwckoyhlr/rCdtIkackvTXFW/fK4QDJfzlP93GyO0zpRRKLZOBhW0aVf0vRFmTdCT4PjcJwXa8gWyO9qhLICVu+ev4Ml07Vyx2+TQVYZCpsJ2l9e/RmuDstmHFxccdpwAHND6JMkzZ2xBHDV8Fr97XLe22dN3tN84QgY5yQFsFkug3M2yhM8YkRHBHxI8NDJQrxlWf8R5AYa1Xj/RxBHGEkuEbX6g5vqgIMft5+Ibc64+qhHO+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG1bUE0+OE2hFt1t/1m32yABrWJL82FNmFm+BJvXkMg=;
 b=aDL6xl4XJyXrm1wwBKnWI4X+0o3tQ0z0ZMyFJBqIlOJV6lfZ7JV6B5BmxVb3z00ZeAl2bGErGeeyv1AOgwQk7ssaHDURfWVaLN6xWkKrKRVMAG1LUKx4WvgJTbkfM8+y9KKjU+nGAWzx/zi1sxIwDuskLBA29r4OwwwkauoBcDArjfEjY3JBsvv0LSFtXEbln/koJBYpkB1GT6ovOZZOFkcTyhFSi9h3KR5QfQTU+Q176t7mlsnK7BGwb6cHStctayCruvLtRwiCoQy98pvC/TbQ2Q6h1HVSRfxKfRrfuDGM5kVpDyVUsDyT75ZioDD9raVyKd7VQM7nuNeCFnZ7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG1bUE0+OE2hFt1t/1m32yABrWJL82FNmFm+BJvXkMg=;
 b=0vvkXguJQocr5Ui266Zx2Dw996GjvyX9ChYmnIsb82uzfZInKlrUHdkhO4CrzqK62QFtqQFnKV9I9liVjb5rBrwDuCIoR0AGM4xUMA41zbcokNaobavyJsvOHo8Lr5AItyzF9b/xeUuQhgBE+3adytWUdG7xmPvsZdU6Vu8D8xg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 06:35:30 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 06:35:28 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang, Kevin" <Kevin.Wang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nmMq5HTaPVj0+C645FmSOmiLblQ/QAgAACu2CAAKMngIAAfzwwgAAIqwCAAAP30IAABK+AgAASmyCAABAJAIAAB+8AgAAAQhCAAAUFgIAAAG/w
Date: Wed, 30 Sep 2026 06:35:27 +0000
Message-ID: <CY5PR12MB63692E6BAC9D9589354ED1B5C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
 <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <fa59606b-0860-4aaa-b6ce-ac037f73eab4@amd.com>
 <BN9PR12MB5211C24FDF238C2A748378DC938B2@BN9PR12MB5211.namprd12.prod.outlook.com>
 <CY5PR12MB63693C7F0614B19DC5CD525FC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-30T06:04:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB7329:EE_
x-ms-office365-filtering-correlation-id: 8ee98397-5302-4d41-77d9-08df1ebd044f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|8096899003|38070700021;
x-microsoft-antispam-message-info: MS436x8R0eLNniC5qzVzIMdfQxsltE1H9HZnfb/tmfufadeyNeZjGdfwcSR8aTGA5lxBgK4qVa6S5sTrRygzpv4vqzsEFV1MtyKIbzIx0oyqbw5T4YHiSR5Vc/NTH7vvNubr4xE+NRe7tvc0cBCXhniONdPHwnrOGPwDK+Xyp7wN5MEZVXV9YmTlmopXC2GZJ7Tw3kLeIvgUsryRkZAPLO1C7kpf4w1R5mekt904MOETjw+C6+a8vdIJsLyk3UyQ+i73Q22ZqxUy03ebdM+bYv0fGHmy/wMa09nK7w2VZdSLR9Qpnnf+v6RERf2xvkhwdYe3avQblmDXakK2/AVCnZBjqq1N6SXZ7ibckLgrVsBeSzIk1QpfL7dOveiYxkAxa4TZ/dbQd1Ah9N0xCxqDk8FBbDnYMeVL0WQeNMm68FQye6/1pl/YLnxI6qllRRzIFLn4tMwl7HIc7IM9PPxHjs7Cz9egZc9ZpuzH51MrtSC1BN8yuEwjia5iNXsL/PQXVcK4QFVnRtlyXcH8uU4GHRu1SZgdpkTPVETIlYOJ3q5c1A/pAPHIaztSY15mnnKxZkYtuQbpniEXTKf1BbNDmYH1YrjpfJcwN6QZO/YG07xlWwl7wcsBMAr+f35HwA5onm3+zXXBgYD+fRLKGj4QIWomSxRAIOOkjKtch0Xc7K7ZdXuzN5NxoJJlHkjTpb7CW4Xw+DGKMj+cHhSgJVQ/pNWB3EqXeJ9m9lt7kqLiL9k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lcYnT32mF4EgGqoYeUjRzr74LiEfWzJQDP+NWS1xdwdBn8+bLXCPlgT8JA9a?=
 =?us-ascii?Q?OtxhrTBNsbmqFB0ydKPpHwd53kiBUBIA3Wwdd4SoKW/lMLUWKaipuZYwIP+U?=
 =?us-ascii?Q?g+Duua/XNZkIFPyUu4/0fzB/xGNrx90jN/Janvk+71brMRe/qIQUBEOcr6tb?=
 =?us-ascii?Q?OVcbWnjKPfHKeqSWu1WLPF2XCJz8ajozKdiHBORBMawK1ZJNWox5K+fnOPuq?=
 =?us-ascii?Q?Sjppru/ue8/0i7YnG2e2+0K93os2gejs/XVHhlReW/rPKfUjXIcwlLDujUJb?=
 =?us-ascii?Q?6ddM+9kVru9CrGUNpE/0lDbxFlQ3UNIgzMGgoteOGiCeEeXHoo/MZI3d2VwQ?=
 =?us-ascii?Q?dmkye3aW9HPNlsn7aZ6C0SnXb2rh4kLN/nVWvX5YdOKsjd8wkbNtPoqfmV15?=
 =?us-ascii?Q?3JY7ZohPheZ80fbW3ER6AMg7JDqxDi5UURtrnnDqZMV6S5SxrnRGLGygqZHg?=
 =?us-ascii?Q?ZvbEBgFjsK5luGmgIHBtjtVaxUK2mZZWS9cfmWUlcUz/KH9JF/4hgDBzdBR+?=
 =?us-ascii?Q?ilr8/dceHCHURsBuCczvHCMM0s5vJxzC4ShwOGv3qnk5+yawpbJfBGdj1NoZ?=
 =?us-ascii?Q?Bc/9525BuiPFCs3m/w3o3wuD5sjp44ScdFJacAzpij11arGQLRmf75JhH15Z?=
 =?us-ascii?Q?Iqm2uihAre6EMrQfAx5fRnSspeZ0K8+TM9bzmFRpJ/v6pD1kXfSDV1PUDgZ6?=
 =?us-ascii?Q?CUMmw2IPMhyd0bZlnZPayOrgPQgrFKdjecBxnL86tKMcuHcgEzMtgfSofxgP?=
 =?us-ascii?Q?X62TRchcC4XB4zDRYd9uOS3Rj7MKokxBpwWuqTCV/WFCcOIRGqLrXWoTwjBz?=
 =?us-ascii?Q?GHm9fd88iEu6Qk6mGjxw2Bfo5WfrQCToKfFOqqfR7i8v57OKYE+U3bzYan8u?=
 =?us-ascii?Q?SFzEPFX6XuOmyDeFGpUVCCNP91WGZjo5GRmGHuEyV3XBznwWNzat/hi+oCM3?=
 =?us-ascii?Q?k2R1g9c8DFgX0J5/GZuZK0ANn21m/Kb+CHI2fuPiCQFUuwWUJ130jPklHOD6?=
 =?us-ascii?Q?wIbkKjvbyFPZSZJNd7l4+XgqXkGqFoGn/jUc0UyxNY1MNB6JRDfl0LAzPfqB?=
 =?us-ascii?Q?MhmcGDVDwWSHO1O02STsGvAhni2xJ7iit2OVHc6YegiylpMynaSUkVpsfB2S?=
 =?us-ascii?Q?iIbSe0uYfcSAzqk8ZYUa8Mr8x17rBPBXxU8LcAFm6AevkeKFqgHgD8O0dQLU?=
 =?us-ascii?Q?2axDPzuUE7f9vt7gb9WeGOeUplY6BzfROuv3xfgtzWOFDCdanqtsmdoPse0F?=
 =?us-ascii?Q?GClFtIlgcV1LbLP5yriEnMANGezCJO3zO67eP8zwuZKFs2jThRZv/7csQh6X?=
 =?us-ascii?Q?9C4qvZGc+UOD7hMmRIdJTRFcaXJxILMTllLcyaZrqA4Jn0Zvkl0V/9WKI0uK?=
 =?us-ascii?Q?+HUO/YDMnl9V3huXXTRgW9ml1EUNrnA9+AQ5OGmsDtc3g9mVyF9TBXfxCQkx?=
 =?us-ascii?Q?ksvoKielL42YJkq/PCcahIiaM4sUgkRp1vnz0/DHHQEGHh0a4xicIvzmt3fr?=
 =?us-ascii?Q?wxromnHZ5A1D0vnOnoC3bsmk2epsTkWF4x8OaVgDwmcJQO0ZrHsII84N4yqM?=
 =?us-ascii?Q?+Q8qDGvW7GKc2o0z+hNMV63W+FvN9W0TJxeL7K1U4y2j7iiQlS39Yc43/s9l?=
 =?us-ascii?Q?fHmCZJRwzU9XE+aZU8XwM8yc8h6aXv5EJJr3TOpI3ma7FBzIIE37TC4giv3u?=
 =?us-ascii?Q?FFyndPu3XZz07i28suna166eT9hM7sI85Sp/PenquGoBhqrx?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63692E6BAC9D9589354ED1B5C18B2CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee98397-5302-4d41-77d9-08df1ebd044f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:35:27.9762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /a50htAv1LdS1lzwl4GelV6iySdTEQrSe65ZFZWH5xNuLy9f/FYO6yEdhZVP7rON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

--_000_CY5PR12MB63692E6BAC9D9589354ED1B5C18B2CY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

On Navi3x/Navi4x, the driver doesn't poll for a response. It sends the mode=
1 reset request through the SMU debug mailbox and waits a fixed interval (S=
MU13_MODE1_RESET_WAIT_TIME_IN_MS) for the reset to proceed. After that, it =
polls the PSP bootloader status and the memsize register to confirm the ASI=
C is out of reset. On ASICs where the regular SMU message path is used, the=
 polled response only acknowledges the message; it doesn't indicate that th=
e reset has completed.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 30, 2026 2:28 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Wang, Kevin <Kevin.Wang@amd.com>; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Yuan, Perry <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12


AMD General

The actual reset sequence is run by the FW while you are polling for the re=
sponse. This patch doesn't make any sense in that way.

Thanks,
Lijo
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>
Sent: Wednesday, 30 September 2026 11:47:46
To: Wang, Kevin <Kevin.Wang@amd.com<mailto:Kevin.Wang@amd.com>>; Lazar, Lij=
o <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Deucher, Alexander <Alex=
ander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Koenig, Christian=
 <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

AMD General

Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), which =
runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process t=
here should be no traffic to the PCIe BARs; otherwise, the PCI bus may hang=
.

Also, every PCI config write in the patch targets only the GPU device itsel=
f (pci_write_config_dword is per device), so no other PCI devices are affec=
ted.

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com<mailto:Kevin.Wang@amd.com>>
Sent: Wednesday, September 30, 2026 2:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Zhang, Yif=
an <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander =
<Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Koenig, Chri=
stian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

AMD General

> On a second look, the patch doesn't seem right. Reset sequence is
> supposed to be complete by the time FW responds back to the mode-1 reset =
message.
> During reset sequence, we need Mem space to be enabled to poll success
> status of the message and that's most volatile window during the whole
> sequence.

That is not right. When the OS driver polls and sees the response register =
become "1", it does **NOT** mean the mode1 sequence is completed.
The PMFW will continue forward the message to PSP and wait for PMFW ucode r=
eload to finish at a 2nd-half stage.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of
> Lazar, Lijo
> Sent: Wednesday, September 30, 2026 1:41 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; Deu=
cher, Alexander
> <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Koenig, Ch=
ristian
> <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
> reset on gfx12
>
> On a second look, the patch doesn't seem right. Reset sequence is
> supposed to be complete by the time FW responds back to the mode-1 reset =
message.
> During reset sequence, we need Mem space to be enabled to poll success
> status of the message and that's most volatile window during the whole
> sequence.
>
> Disabling the memory space after reset sequence is complete looks to
> be the wrong diagnosis of the issue. Access during reinit sequence
> after reset is safe and shouldn't cause any issue in general.
>
> That said, we should try to resolve the issue without touching any PCI
> config settings. PCI config space is open for others as well.
>
> Thanks,
> Lijo
>
> On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
> > AMD General
> >
> > How about disable UE during mode1 reset ? E.g.
> >
> > Before:
> >          pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &saved_devctl)=
;
> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
> >                                     saved_devctl & ~PCI_EXP_DEVCTL_URRE=
);
> >          pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                        &saved_uemsk);
> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                         saved_uemsk |
> > PCI_ERR_UNC_UNSUP);
> >
> >
> > After:
> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
> >                                         saved_uemsk);
> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
> > saved_devctl);
> >
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> > Sent: Wednesday, September 30, 2026 11:37 AM
> > To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; D=
eucher, Alexander
> > <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Koenig, =
Christian
> > <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> > Cc: Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
> > Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> > mode1 reset on gfx12
> >
> >
> > This is the behaviour of this bit -
> >
> >          Memory Space Enable - Controls a Function's response to
> > Memory  Space accesses. When this bit is Clear, all received Memory
> > Space
> accesses are caused to be handled as "Unsupported Requests"
> >
> > On AER enabled systems, depending on how the platform is configured
> > to
> classify the severity of UR errors, that could result in System error.
> >
> > On other hand, if you are sure that there is no such access during
> > mode-1 reset, we don't need this patch in the first place.
> >
> > Thanks,
> > Lijo
> >
> >
> > On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
> >> AMD General
> >>
> >> Hi Lijo,
> >>
> >> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data
> center GPUs? Are their PCIe BARs still being accessed during a mode1 rese=
t?
> >>
> >> Best Regards,
> >> Yifan
> >>
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Wednesday, September 30, 2026 11:06 AM
> >> To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; =
Deucher, Alexander
> >> <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; Koenig,=
 Christian
> >> <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Cc: Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
> >> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >> mode1 reset on gfx12
> >>
> >> This doesn't work for all (at least on some datacenter GPUs). With
> >> AER
> enabled, this will result in AER errors. Depending on the platform
> config, some may classify this access as fatal.
> >>
> >> Thanks,
> >> Lijo
> >>
> >> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
> >>> Public
> >>>
> >>>
> >>> Hi Alex,
> >>>
> >>> I think it is reasonable to apply the patch to all ASICs. I will
> >>> sync with the hardware team about this change; so far we have only
> >>> tested it on Navi31.
> >>>
> >>> How about adding a common helper and calling it from ASIC-specific
> >>> code, starting with Navi31? For example:
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> index b690a07e31ab..075de681ab86 100644
> >>>
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>
> >>> @@ -4931,6 +4931,28 @@ bool
> amdgpu_device_should_recover_gpu(struct
> >>> amdgpu_device *adev)
> >>>
> >>>                    return false;
> >>>
> >>> }
> >>>
> >>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
> >>>
> >>> +                                   unsigned int delay_ms)
> >>>
> >>> +{
> >>>
> >>> +       u16 saved_cmd, cmd;
> >>>
> >>> +
> >>>
> >>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> >>>
> >>> +       cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> >>>
> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> >>>
> >>> +
> >>>
> >>> +       msleep(delay_ms);
> >>>
> >>> +
> >>>
> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> >>>
> >>> +}
> >>>
> >>> +
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> index b250c5e41e45..356e09b7eef9 100644
> >>>
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>>
> >>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct
> smu_context
> >>> *smu)
> >>>
> >>>            ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
> >>> NULL);
> >>>
> >>>            if (!ret)
> >>>
> >>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> >>>
> >>> +               amdgpu_device_mode1_reset_wait(smu->adev,
> >>>
> >>> +
> >>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> >>>
> >>>            return ret;
> >>>
> >>> }
> >>>
> >>> Best Regards,
> >>>
> >>> Yifan
> >>>
> >>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander=
.Deucher@amd.com>>
> >>> *Sent:* Wednesday, September 30, 2026 2:59 AM
> >>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>=
>; Koenig, Christian
> >>> <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>; amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
> >>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> Public
> >>>
> >>> I think this should be asic agnostic.  Any asic doing mode1 reset
> >>> should do this?
> >>>
> >>> Alex
> >>>
> >>> ------------------------------------------------------------------
> >>> --
> >>> -
> >>> -
> >>> --
> >>>
> >>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
<mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com>>
> >>> *Sent:* Tuesday, September 29, 2026 5:36 AM
> >>> *To:* Koenig, Christian <Christian.Koenig@amd.com
<mailto:Christian.Koenig@amd.com%0b>> >>> <mailto:Christian.Koenig@amd.com>=
>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>> <mailto:amd-gfx@lists.freedesktop.org>
> >>> <amd-gfx@lists.freedesktop.org
<mailto:amd-gfx@lists.freedesktop.org%0b>> >>> <mailto:amd-gfx@lists.freede=
sktop.org>>
> >>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
<mailto:Alexander.Deucher@amd.com%0b>> >>> <mailto:Alexander.Deucher@amd.co=
m>>; Yuan, Perry
> <Perry.Yuan@amd.com
<mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com>>
> >>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> Public
> >>>
> >>> Hi Christian,
> >>>
> >>> The no_hw_access flag was first set in commit
> >>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix
> >>> the Mode 1 reset hang, but it proved insufficient.
> >>> I think the flag was set in the SMU code so that it would apply
> >>> only to
> >>> SMU13/14 ASICs, without affecting the Mode 1 reset process on
> >>> other
> ASICs.
> >>> I'm not sure whether we can drop the no_hw_access flag after
> >>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently,
> so
> >>> we may need another round of stress testing to confirm that the
> >>> flag is no longer needed. Should we remove no_hw_access in a
> >>> separate
> patch?
> >>>
> >>> Best Regards,
> >>> Yifan
> >>>
> >>> -----Original Message-----
> >>> From: Koenig, Christian <Christian.Koenig@amd.com
<mailto:Christian.Koenig@amd.com%0b>> >>> <mailto:Christian.Koenig@amd.com>=
>
> >>> Sent: Tuesday, September 29, 2026 5:06 PM
> >>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
<mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com>>; amd-g=
fx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>> <mailto:amd-gfx@lists.freedesktop.org>
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
<mailto:Alexander.Deucher@amd.com%0b>> >>> <mailto:Alexander.Deucher@amd.co=
m>>; Yuan, Perry
> <Perry.Yuan@amd.com
<mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com>>
> >>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> >>> mode1 reset on gfx12
> >>>
> >>> On 9/29/26 04:25, Yifan Zhang wrote:
> >>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve
> >>>> the random mode1 reset hang issue.
> >>>
> >>> Interesting idea, that is much simpler than trying to mess with
> >>> CPU page tables in the GPU reset path.
> >>>
> >>> The only downside I can see is that we now drop VRAM and doorbell
> >>> writes, but I think that won't matter since VRAM is lost by a
> >>> mode1 reset anyway.
> >>>
> >>> MMIO writes are dropped as well which means that we can also drop
> >>> the no_hw_access flag.
> >>>
> >>> And BTW the SMU code should absolutely *NOT* touch that
> no_hw_access
> >>> flag in any way. Who added that there?
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
<mailto:yifan1.zhang@amd.com%0b>> >>>> <mailto:yifan1.zhang@amd.com>>
> >>>> ---
> >>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
> >>>> ++++++++++++-------
> >>>>    1 file changed, 19 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> index 072d9c4e202d..25b9085ead71 100644
> >>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >>>> @@ -2078,21 +2078,30 @@ static int
> >>>> smu_v14_0_2_set_df_cstate(struct smu_context *smu,
> >>>>
> >>>>    static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
> >>>> +     struct amdgpu_device *adev =3D smu->adev;
> >>>> +     u16 saved_cmd, cmd;
> >>>>         int ret =3D 0;
> >>>>
> >>>>         ret =3D smu_cmn_send_debug_smc_msg(smu,
> DEBUGSMC_MSG_Mode1Reset);
> >>>> -     if (!ret) {
> >>>> -             if (amdgpu_emu_mode =3D=3D 1) {
> >>>> -                     msleep(50000);
> >>>> -             } else {
> >>>> -                     /* disable mmio access while doing mode 1
> >>>> reset*/
> >>>> -                     smu->adev->no_hw_access =3D true;
> >>>> -                     /* ensure no_hw_access is globally visible
> >>>> before any MMIO */
> >>>> -                     smp_mb();
> >>>> -                     msleep(1000);
> >>>> -             }
> >>>> +     if (ret)
> >>>> +             return ret;
> >>>> +
> >>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> >>>> +     cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> >>>> +
> >>>> +     if (amdgpu_emu_mode =3D=3D 1) {
> >>>> +             msleep(50000);
> >>>> +     } else {
> >>>> +             /* disable mmio access while doing mode 1 reset*/
> >>>> +             smu->adev->no_hw_access =3D true;
> >>>> +             /* ensure no_hw_access is globally visible before
> >>>> +any MMIO */
> >>>> +             smp_mb();
> >>>> +             msleep(1000);
> >>>>         }
> >>>>
> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> >>>> +
> >>>>         return ret;
> >>>>    }
> >>>>
> >>>
> >>
> >


--_000_CY5PR12MB63692E6BAC9D9589354ED1B5C18B2CY5PR12MB6369namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">On N=
avi3x/Navi4x, the driver doesn't poll for a response. It sends the mode1 re=
set request through the SMU debug mailbox and waits a fixed interval (SMU13=
_MODE1_RESET_WAIT_TIME_IN_MS) for the
 reset to proceed. After that, it polls the PSP bootloader status and the m=
emsize register to confirm the ASIC is out of reset. On ASICs where the reg=
ular SMU message path is used, the polled response only acknowledges the me=
ssage; it doesn't indicate that
 the reset has completed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, September 30, 2026 2:28 PM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Wang, Kevin &lt;Kevin=
.Wang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ko=
enig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop=
.org<br>
<b>Cc:</b> Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p style=3D"margin:5.0pt"><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:blue">AMD General<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#212121">The act=
ual reset sequence is run by the FW while you are polling for the response.=
 This patch doesn't make any sense in that way.<o:p></o:p></span></p>
<div id=3D"ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#212121">Thanks,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#212121">Lijo<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span=
 lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd=
.com">Yifan1.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, 30 September 2026 11:47:46<br>
<b>To:</b> Wang, Kevin &lt;<a href=3D"mailto:Kevin.Wang@amd.com">Kevin.Wang=
@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lij=
o.Lazar@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Koenig,
 Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.com">Perry.Yuan=
@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12</span><span lang=3D"EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Times =
New Roman&quot;,serif">AMD General<br>
<br>
Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), which =
runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process t=
here should be no traffic to the PCIe BARs; otherwise, the PCI bus may hang=
.<br>
<br>
Also, every PCI config write in the patch targets only the GPU device itsel=
f (pci_write_config_dword is per device), so no other PCI devices are affec=
ted.<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin &lt;<a href=3D"mailto:Kevin.Wang@amd.com">Kevin.Wang@amd.=
com</a>&gt;<br>
Sent: Wednesday, September 30, 2026 2:09 PM<br>
To: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.co=
m</a>&gt;; Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.=
Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.D=
eucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Koenig,
 Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.com">Perry.Yuan@amd.co=
m</a>&gt;<br>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12<br>
<br>
AMD General<br>
<br>
&gt; On a second look, the patch doesn't seem right. Reset sequence is<br>
&gt; supposed to be complete by the time FW responds back to the mode-1 res=
et message.<br>
&gt; During reset sequence, we need Mem space to be enabled to poll success=
<br>
&gt; status of the message and that's most volatile window during the whole=
<br>
&gt; sequence.<br>
<br>
That is not right. When the OS driver polls and sees the response register =
become &quot;1&quot;, it does **NOT** mean the mode1 sequence is completed.=
<br>
The PMFW will continue forward the message to PSP and wait for PMFW ucode r=
eload to finish at a 2nd-half stage.<br>
<br>
Best Regards,<br>
Kevin<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of<br>
&gt; Lazar, Lijo<br>
&gt; Sent: Wednesday, September 30, 2026 1:41 PM<br>
&gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.Zh=
ang@amd.com</a>&gt;; Deucher, Alexander<br>
&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd=
.com</a>&gt;; Koenig, Christian<br>
&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.c=
om</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt; Cc: Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.com">Perry.Yuan@a=
md.com</a>&gt;<br>
&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1<=
br>
&gt; reset on gfx12<br>
&gt;<br>
&gt; On a second look, the patch doesn't seem right. Reset sequence is<br>
&gt; supposed to be complete by the time FW responds back to the mode-1 res=
et message.<br>
&gt; During reset sequence, we need Mem space to be enabled to poll success=
<br>
&gt; status of the message and that's most volatile window during the whole=
<br>
&gt; sequence.<br>
&gt;<br>
&gt; Disabling the memory space after reset sequence is complete looks to<b=
r>
&gt; be the wrong diagnosis of the issue. Access during reinit sequence<br>
&gt; after reset is safe and shouldn't cause any issue in general.<br>
&gt;<br>
&gt; That said, we should try to resolve the issue without touching any PCI=
<br>
&gt; config settings. PCI config space is open for others as well.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:<br>
&gt; &gt; AMD General<br>
&gt; &gt;<br>
&gt; &gt; How about disable UE during mode1 reset ? E.g.<br>
&gt; &gt;<br>
&gt; &gt; Before:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_read_word(pdev, PCI_EXP_DEVCTL, &amp;saved_devctl);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_write_word(pdev, PCI_EXP_DEVCTL,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 saved_devctl &amp; ~PCI_EXP_DEVCTL_URRE);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_co=
nfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &amp;saved_uemsk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_c=
onfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; saved_uemsk |<br>
&gt; &gt; PCI_ERR_UNC_UNSUP);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; After:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_c=
onfig_dword(pdev, aer + PCI_ERR_UNCOR_MASK,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; saved_uemsk);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_capabi=
lity_write_word(pdev, PCI_EXP_DEVCTL,<br>
&gt; &gt; saved_devctl);<br>
&gt; &gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.=
Lazar@amd.com</a>&gt;<br>
&gt; &gt; Sent: Wednesday, September 30, 2026 11:37 AM<br>
&gt; &gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifa=
n1.Zhang@amd.com</a>&gt;; Deucher, Alexander<br>
&gt; &gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deuche=
r@amd.com</a>&gt;; Koenig, Christian<br>
&gt; &gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@=
amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; Cc: Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.com">Perry.Y=
uan@amd.com</a>&gt;<br>
&gt; &gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during<b=
r>
&gt; &gt; mode1 reset on gfx12<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; This is the behaviour of this bit -<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Spac=
e Enable - Controls a Function's response to<br>
&gt; &gt; Memory&nbsp; Space accesses. When this bit is Clear, all received=
 Memory<br>
&gt; &gt; Space<br>
&gt; accesses are caused to be handled as &quot;Unsupported Requests&quot;<=
br>
&gt; &gt;<br>
&gt; &gt; On AER enabled systems, depending on how the platform is configur=
ed<br>
&gt; &gt; to<br>
&gt; classify the severity of UR errors, that could result in System error.=
<br>
&gt; &gt;<br>
&gt; &gt; On other hand, if you are sure that there is no such access durin=
g<br>
&gt; &gt; mode-1 reset, we don't need this patch in the first place.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Lijo<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:<br>
&gt; &gt;&gt; AMD General<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Lijo,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Why does clearing PCI_COMMAND_MEMORY cause AER errors on data=
<br>
&gt; center GPUs? Are their PCIe BARs still being accessed during a mode1 r=
eset?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Best Regards,<br>
&gt; &gt;&gt; Yifan<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Wednesday, September 30, 2026 11:06 AM<br>
&gt; &gt;&gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">=
Yifan1.Zhang@amd.com</a>&gt;; Deucher, Alexander<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.De=
ucher@amd.com</a>&gt;; Koenig, Christian<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koe=
nig@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt;&gt; Cc: Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.com">Per=
ry.Yuan@amd.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access duri=
ng<br>
&gt; &gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This doesn't work for all (at least on some datacenter GPUs).=
 With<br>
&gt; &gt;&gt; AER<br>
&gt; enabled, this will result in AER errors. Depending on the platform<br>
&gt; config, some may classify this access as fatal.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Hi Alex,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I think it is reasonable to apply the patch to all ASICs.=
 I will<br>
&gt; &gt;&gt;&gt; sync with the hardware team about this change; so far we =
have only<br>
&gt; &gt;&gt;&gt; tested it on Navi31.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; How about adding a common helper and calling it from ASIC=
-specific<br>
&gt; &gt;&gt;&gt; code, starting with Navi31? For example:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<b=
r>
&gt; &gt;&gt;&gt; b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; index b690a07e31ab..075de681ab86 100644<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -4931,6 +4931,28 @@ bool<br>
&gt; amdgpu_device_should_recover_gpu(struct<br>
&gt; &gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +void amdgpu_device_mode1_reset_wait(struct amdgpu_device=
 *adev,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
nsigned int delay_ms)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_wor=
d(adev-&gt;pdev, PCI_COMMAND, &amp;saved_cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &=
amp; ~PCI_COMMAND_MEMORY;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_wo=
rd(adev-&gt;pdev, PCI_COMMAND, cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(delay_ms);<b=
r>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_wo=
rd(adev-&gt;pdev, PCI_COMMAND, saved_cmd);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0=
.c<br>
&gt; &gt;&gt;&gt; b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; index b250c5e41e45..356e09b7eef9 100644<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct<br=
>
&gt; smu_context<br>
&gt; &gt;&gt;&gt; *smu)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,<br>
&gt; &gt;&gt;&gt; NULL);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (!ret)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_mode1_reset_wait(smu-&gt;adev,<b=
r>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; SMU13_MODE1_RESET_WAIT_TIME_IN_MS);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Best Regards,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Yifan<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; *From:*Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt; *Sent:* Wednesday, September 30, 2026 2:59 AM<br>
&gt; &gt;&gt;&gt; *To:* Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd=
.com">Yifan1.Zhang@amd.com</a>&gt;; Koenig, Christian<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christian=
.Koenig@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt;&gt;&gt; *Cc:* Yuan, Perry &lt;<a href=3D"mailto:Perry.Yuan@amd.co=
m">Perry.Yuan@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt; *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar acces=
s during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I think this should be asic agnostic.&nbsp; Any asic doin=
g mode1 reset<br>
&gt; &gt;&gt;&gt; should do this?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Alex<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; ---------------------------------------------------------=
---------<br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; *From:*Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@am=
d.com%0b">Yifan1.Zhang@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">mailto:Yi=
fan1.Zhang@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Sent:* Tuesday, September 29, 2026 5:36 AM<br>
&gt; &gt;&gt;&gt; *To:* Koenig, Christian &lt;<a href=3D"mailto:Christian.K=
oenig@amd.com%0b">Christian.Koenig@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailt=
o:Christian.Koenig@amd.com</a>&gt;&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mail=
to:amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org%0b">a=
md-gfx@lists.freedesktop.org<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">=
mailto:amd-gfx@lists.freedesktop.org</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Cc:* Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com%0b">Alexander.Deucher@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">mail=
to:Alexander.Deucher@amd.com</a>&gt;&gt;; Yuan, Perry<br>
&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com%0b">Perry.Yuan@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com">mailto:Perr=
y.Yuan@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar acces=
s during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Public<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Hi Christian,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The no_hw_access flag was first set in commit<br>
&gt; &gt;&gt;&gt; 0de604d0357d0d22cbf03af1077d174b641707b6. This was intend=
ed to fix<br>
&gt; &gt;&gt;&gt; the Mode 1 reset hang, but it proved insufficient.<br>
&gt; &gt;&gt;&gt; I think the flag was set in the SMU code so that it would=
 apply<br>
&gt; &gt;&gt;&gt; only to<br>
&gt; &gt;&gt;&gt; SMU13/14 ASICs, without affecting the Mode 1 reset proces=
s on<br>
&gt; &gt;&gt;&gt; other<br>
&gt; ASICs.<br>
&gt; &gt;&gt;&gt; I&#8217;m not sure whether we can drop the no_hw_access f=
lag after<br>
&gt; &gt;&gt;&gt; disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermi=
ttently,<br>
&gt; so<br>
&gt; &gt;&gt;&gt; we may need another round of stress testing to confirm th=
at the<br>
&gt; &gt;&gt;&gt; flag is no longer needed. Should we remove no_hw_access i=
n a<br>
&gt; &gt;&gt;&gt; separate<br>
&gt; patch?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Best Regards,<br>
&gt; &gt;&gt;&gt; Yifan<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt; From: Koenig, Christian &lt;<a href=3D"mailto:Christian.K=
oenig@amd.com%0b">Christian.Koenig@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailt=
o:Christian.Koenig@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; Sent: Tuesday, September 29, 2026 5:06 PM<br>
&gt; &gt;&gt;&gt; To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.c=
om%0b">Yifan1.Zhang@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">mailto:Yi=
fan1.Zhang@amd.com</a>&gt;&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mail=
to:amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt; &gt;&gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.De=
ucher@amd.com%0b">Alexander.Deucher@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">mail=
to:Alexander.Deucher@amd.com</a>&gt;&gt;; Yuan, Perry<br>
&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com%0b">Perry.Yuan@amd.com<br>
</a>&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:Perry.Yuan@amd.com">mailto:Perr=
y.Yuan@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt; Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access =
during<br>
&gt; &gt;&gt;&gt; mode1 reset on gfx12<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On 9/29/26 04:25, Yifan Zhang wrote:<br>
&gt; &gt;&gt;&gt;&gt; block GPU PCI bar access during mode1 reset on gfx12,=
 to resolve<br>
&gt; &gt;&gt;&gt;&gt; the random mode1 reset hang issue.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Interesting idea, that is much simpler than trying to mes=
s with<br>
&gt; &gt;&gt;&gt; CPU page tables in the GPU reset path.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The only downside I can see is that we now drop VRAM and =
doorbell<br>
&gt; &gt;&gt;&gt; writes, but I think that won't matter since VRAM is lost =
by a<br>
&gt; &gt;&gt;&gt; mode1 reset anyway.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; MMIO writes are dropped as well which means that we can a=
lso drop<br>
&gt; &gt;&gt;&gt; the no_hw_access flag.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; And BTW the SMU code should absolutely *NOT* touch that<b=
r>
&gt; no_hw_access<br>
&gt; &gt;&gt;&gt; flag in any way. Who added that there?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Regards,<br>
&gt; &gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:yifa=
n1.zhang@amd.com%0b">yifan1.zhang@amd.com<br>
</a>&gt; &gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:yifan1.zhang@amd.com">mailt=
o:yifan1.zhang@amd.com</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../drm/amd/pm/swsmu/smu14/smu_v14_=
0_2_ppt.c&nbsp; | 29<br>
&gt; &gt;&gt;&gt;&gt; ++++++++++++-------<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 19 insertions(+), 1=
0 deletions(-)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.=
c<br>
&gt; &gt;&gt;&gt;&gt; index 072d9c4e202d..25b9085ead71 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_=
ppt.c<br>
&gt; &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_=
ppt.c<br>
&gt; &gt;&gt;&gt;&gt; @@ -2078,21 +2078,30 @@ static int<br>
&gt; &gt;&gt;&gt;&gt; smu_v14_0_2_set_df_cstate(struct smu_context *smu,<br=
>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static int smu_v14_0_2_mode1_reset(=
struct smu_context *smu)&nbsp; {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r=
et =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D smu_cmn_send_debug_smc_msg(smu,<br>
&gt; DEBUGSMC_MSG_Mode1Reset);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep=
(50000);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dis=
able mmio access while doing mode 1<br>
&gt; &gt;&gt;&gt;&gt; reset*/<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&g=
t;adev-&gt;no_hw_access =3D true;<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ens=
ure no_hw_access is globally visible<br>
&gt; &gt;&gt;&gt;&gt; before any MMIO */<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smp_mb=
();<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep=
(1000);<br>
&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_word(adev-&=
gt;pdev, PCI_COMMAND, &amp;saved_cmd);<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &amp; ~PC=
I_COMMAND_MEMORY;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-=
&gt;pdev, PCI_COMMAND, cmd);<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D =
1) {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msleep(50000);<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* disable mmio access while doing mode 1 reset*/<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smu-&gt;adev-&gt;no_hw_access =3D true;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* ensure no_hw_access is globally visible before<br>
&gt; &gt;&gt;&gt;&gt; +any MMIO */<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smp_mb();<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msleep(1000);<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-=
&gt;pdev, PCI_COMMAND, saved_cmd);<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-family:&quot;Times New Roman&quot=
;,serif"><o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB63692E6BAC9D9589354ED1B5C18B2CY5PR12MB6369namp_--

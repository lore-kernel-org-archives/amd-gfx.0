Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E0C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 07:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6601661CAA
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 07:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6601661CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAAD6E82E;
	Wed,  7 Jul 2021 07:41:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAE86E82E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 07:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZC8zkbzRTGWCHOtIaVj0TuKAdDMxxlKtwXFJoFArNAxcjM6Mk/9KwZiBomeNYjAj0YYfHTDip0bBzEQ8PUsOmTP7WZ6KM4JSO9Wgc2Hqc6P1IMJwpGg5JN/Elkyut41niztzm8MBdCEtSj8LI25vQHtsast2RKFTRcMhE9LsxcX7yBDzBOrlrsoYinfsM59aThGXy+ME3e9Cg5mNy4ysg0Uth8Ea26RgnV2gIU7Mk9E6DBW9K3vQKCUPWoUDmOE2zNXy3oDwafdBC/Yr5fwCSSaRcXK6A/44SKshgV5FHjd9PjoxOEGMdY+E3eMjwLNefppfRLiRUpEu9ssNt4Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Fg6iJJTcxh1rbqEtC3VMO2+GQ6nLhP0XqQ4CmeD9U=;
 b=aC4izjHbR6kTWF2l0cIObFzfQjStrmPFq8EeRdwgPIi5HMGoRYhPv91QFmWYFPcJQ7gWS0HJr6rJ12aIlFh1n+i5aGOUvAf/JjCHgpyAEMB1+QWRROOL5/qwHHPOEeuPttxlIgRuXO/MFlvAcfpdEIIcg7wGYDjQF2f74HmaYa578BBmVU0V70RISKt3Zj94/RLYqOKssdYyEiSzxqgFd+KuVRJmkyGalHpjSsrLWLIAB533LowMyJkOqMDz2buAlFmf9UxQAau0tl7AAYw4qqGUXBa4VVLKC0tD3AoJe+JtodQ33Mj6bZ0857TfXBa2QDKvKy2p1gJsxvURlvV8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/Fg6iJJTcxh1rbqEtC3VMO2+GQ6nLhP0XqQ4CmeD9U=;
 b=qW8coHjEzDh+So2YcDW2f8JOHGCrrLPULSy3BR7cNA6YteoeVvQNKCxXcwGi4gun6aGDaNieRiXBkSDtd/ZcFHfVr8r0BOdfF0YK8ePbgq8Bz46jL9qLhfANUXnAjeZMPBWHNMuqeqj1YFfRadOzasxYmU0iAKgC3fi9sdwE5jo=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 7 Jul
 2021 07:41:36 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12%7]) with mapi id 15.20.4308.020; Wed, 7 Jul 2021
 07:41:36 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual crtc
Thread-Topic: [PATCH] drm/amdgpu: Correct the irq numbers for virtual crtc
Thread-Index: AQHXcnEfUPSZARfBSEWLgRhUOwRQkqs3Ihgg
Date: Wed, 7 Jul 2021 07:41:36 +0000
Message-ID: <PH0PR12MB54175896AA686252A6178B1B8F1A9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210706141335.2494-1-Emily.Deng@amd.com>
In-Reply-To: <20210706141335.2494-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e3a087f2-a0ca-41d8-86e3-09aa579d19a3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-07T07:41:25Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b633694-8c97-44c8-1f5d-08d9411aa626
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5433D42609842C6CFA5F72938F1A9@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90l07LdU4dFeqzN2V9pJkYBaKHZzomclIwgzq8pnz3o3lRF22M7u3qhbfH3ypPQgHj8zLZmrwQjxdR9rg3Vm4ky39knXfI/AiE0HHYkvkCa9HjPGThR8CnZME0MrBcklr+hispwqqNe0r4OmUiPqin7MKcRGpKKdSTk35a0C7AnUhedeN5ELZIZCwItY2WdM1HlRT3gNs6XHMhVUqJapOzJWUh+x1ZdxIlKd/lZbqgGN2vCGgLv0TWJv+KJgO+bRXAWEs1fWFaMtCJtnuBz2SgQ0s1cF7TsC0Zn6ml1BOojQKZqMrtT8UH3ufk1VFfeUg+czsmhFzb4TdbUyEp4IIG7PbBvVwgX1XRwcnviUPni8wiKADJUBzEQa8HnxVoDrHV490aKcowI7JwzXPef2oxwaRs4RZPZmXmVW1G8jBlgEVp0tSXELV1C7KTKDdYWzX6lK+k/Uh8ZGTbaR/eCo40RDUSi5P+XOOZI4A+QRVQV6bOCz8LLsl0KQrkfyTMzZmIPgbUV59iCN+sK76Djy8ktZ7lG1a7/VKVmNMiadP8xhuL1g9sTPu6Cl5iTqIga8H7bhsVIwDQvtQlMVS0r733R+LJfiEmeeRPmlvrXDheEeDe3cxuqPaC6UMuG2RrDhQZsR17xXUwQ4BxSsdpabyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(316002)(186003)(66476007)(66946007)(66556008)(26005)(64756008)(66446008)(6506007)(8676002)(2906002)(76116006)(71200400001)(52536014)(86362001)(7696005)(38100700002)(8936002)(110136005)(5660300002)(122000001)(55016002)(9686003)(33656002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHt6Q92Kczc95iLwVNyNwUbzoQJ8PjsoxMYYpioodQyy256Rq748+RjiKBwP?=
 =?us-ascii?Q?dLdAOzqD3/ih5+BRMCfqYhGbhEb4oS2a4TIBNPmVuTL0BJJ5Cru/r52/KgKX?=
 =?us-ascii?Q?uWKqoGuEOKAABMVtgJvSl4CcDJtK5SEZi+tcEciE/Nw/H2teCsF9yHzKztXz?=
 =?us-ascii?Q?5hh6wZ93d4Nzf9VtpgmW1uGyynwESk9bIRHRq/zZBMdOOPkVAltbspxWX1xu?=
 =?us-ascii?Q?l7xvNDumacs7/o7XRfoZB0eX8bdUqYNsC4O/ZjbNmApdqMvgVChX8nOrjT2O?=
 =?us-ascii?Q?bEzPuMT7GGtE721+PzB8w79Wnpc+rQWEVWyDbOAkCY9R7PLFAdOhOD8MNzXu?=
 =?us-ascii?Q?+nxJ2QKv5c33PcnVDBFY7RQ8vh38HinXAXGivYCf8rPNrMo+pqlU5QaykMIg?=
 =?us-ascii?Q?LOpkmhN7ktbGYbhLYRPjMg6TeO5HmZFxthotMpxyhdiu+yaGYHXrRlSwO0gm?=
 =?us-ascii?Q?9C9wbXFqFje7J+uCx3AJ9Epve6hC7hXgj3wuTCKbXsI2NHqBtdtubmStJ2T3?=
 =?us-ascii?Q?8fyes55OcXewXEX/0jlTiNf1VQzwrTL6qO3kTMV/GZm/IugTnMIRUVRYf/gh?=
 =?us-ascii?Q?6vzHawx2z1kTxsM5Yr/HZVjgxDEVsr9ed8AMrG9ytdmIoSQb4jWlIbvg06yn?=
 =?us-ascii?Q?nETSPcfqLC7be+QaiAEYD79P7zGWqnDV4foDegrfbQm0PWlyGi3DwTeuiEY2?=
 =?us-ascii?Q?9JrxFxKrSrfdKlDxir6+/IsaHF5gLz1M2TmSw6778jOf7VhNJEX1N2CA3Rxn?=
 =?us-ascii?Q?nBJnksGOBxRxYE3plbXhRjsLKjENJUb70XmPVj9wbKhRkw0TkW3NbvOApS1f?=
 =?us-ascii?Q?9aqDyTLQfHvoYK7PlZLv7zYHthP4c/7ZrzQgaSe55++hEB6Rl5/C3PO541Gt?=
 =?us-ascii?Q?Rf/1+fazlVKiDtdScNZT34iZ7FdJ+9Du6fLFgJrmSw8BwAOiWbcSrKUF7aLD?=
 =?us-ascii?Q?czK3PDo+Yrz6t3ssOxeplZ3DB73tz0qTk/VjCOkLYcmqru5NZPFX2uIWFg7u?=
 =?us-ascii?Q?+0VTj9U4ZpppcKL3o+C9hHacWgO1B2dsA/UWxxyF/cVMMJOKXHmtsDRWbY7p?=
 =?us-ascii?Q?dj90rBInq2aq6BAiPN70mP7DzYa8r72+aoIrOWf8cakYw2GDl7mOOM3cEvFE?=
 =?us-ascii?Q?/rXYsEe1iBb1qVqPaEPQbnk4aqGEZXgnnr08xKVt+2oqDUTM99ofme5mu4ae?=
 =?us-ascii?Q?W3qQWppbdHKIE37rEIP4zsVisr2CHHGReTTv8JBXujyLpRlRYuxsKzJvN1pB?=
 =?us-ascii?Q?mQ8/l3G1gH1ATf7HxjKQMjBrPgEkcsVH57JoLt1bK1ssLxwv87S2ZdZQpCUR?=
 =?us-ascii?Q?oEJ4PJLmaPMS3CEwMamebeFk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b633694-8c97-44c8-1f5d-08d9411aa626
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 07:41:36.0832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZyQnVZkJMrgAisMzwjULLGtAEOzdQehqYbTdIkXON0Le/IZ87VXPuTZFhhZ0/vx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping ......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, July 6, 2021 10:14 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Correct the irq numbers for virtual crtc
>
>The irq number should be decided by num_crtc, and the num_crtc could change
>by parameter.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>index 33324427b555..7e0d8c092c7e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>@@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs
>dce_virtual_crtc_irq_funcs = {
>
> static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)  {
>-      adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>+      adev->crtc_irq.num_types = adev->mode_info.num_crtc;
>       adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;  }
>
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

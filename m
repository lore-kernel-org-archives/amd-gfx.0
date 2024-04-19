Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A486C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 08:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2B710E153;
	Fri, 19 Apr 2024 08:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3GRM4Ef5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB5310E153
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 08:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icOATF+Tl0Xj60W7IgQahwal1JIkrurCBjpNQSEkWNov2IkS7auEOTae68/zahvZ0P3roI2eQp8nUsAAQwAmwZYDZQkXOtNNgIBWGTG5JVVpZ6wCZ+l5ZW9kA4pBt/mCq6pcDAEy9H3FvQAZ9M+pYLO8ZXkgmP0RiWEEZK+lZuqaWZDOKbQnVaZDDrImiVcKqt7JvzKliQ6QgAzTjElEqOwT0KTgdMhcLXTVlh+7OCjMwbn85M3E7vnf7rFfFK4eMmon5824PMUb1sFJZoC8j1YUrl9aPw/vDNdZiZs+klO6+XHKz7BWyHeZxjx+uI7NX8cj1c6tj8B0AFvGYKxFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBkiCM7xGePdZs1r2JDC7YjYUZ8cdQfIrCA80ZVsAwI=;
 b=QAMCdV9r21ZFWg0GSJY4Ofb5O56aaOM9prZZ2Ob/KDQ3REP27kuA0HgzGBe4XZBCIbLGabMjwFNasE//TRP9dzgR5JwldWbpcfYakAL4czJB6rt+tXQ1mX8AvBhuehO5z7INwW1W5jmYv/pS56ZzEAZ4QpWHgDeJEQyexsUiLeyVerO7B3ATGVfyNBL2cxLcVI7h66Wxk9DbnJSdZ/bSKvWfOc6Qkel8yh6rxP68hJZnCM9ExTxuD8/JN/GwXG5NhXDvHqt07v2bxMXidSeN43vVuxfKhBZxjUEK2vPjUTk83CaJjc1KGXRh/Bt9U0bRmVEua9Lcf4+DGraZ0n20Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBkiCM7xGePdZs1r2JDC7YjYUZ8cdQfIrCA80ZVsAwI=;
 b=3GRM4Ef5dqTsJ/f13Jx7rT4aw+ooNsGBlJK7aVtGcyePfsG4IT53rRu/YpOHlFRLPyaA3VCCDzJYn1bAcjLoc5vLD5GAYrDMIluIMwhaNIva/51mq2J+cQ4rZCIxWsjPe+dwgFILTztfQ635ndIFF6V6HYHGZI0wK0QP68pOof8=
Received: from CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 08:43:42 +0000
Received: from CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::1688:d33e:adf5:e5df]) by CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::1688:d33e:adf5:e5df%6]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 08:43:41 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/umsch: don't execute umsch test when GPU is in
 reset/suspend
Thread-Topic: [PATCH] drm/amdgpu/umsch: don't execute umsch test when GPU is
 in reset/suspend
Thread-Index: AQHaki6FCs+cWP9K3k28Yf1ymQPt+7FvRrUA
Date: Fri, 19 Apr 2024 08:43:41 +0000
Message-ID: <CH3PR12MB77627A78D424C906CA52D212FA0D2@CH3PR12MB7762.namprd12.prod.outlook.com>
References: <20240419075203.37194-1-Lang.Yu@amd.com>
In-Reply-To: <20240419075203.37194-1-Lang.Yu@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab6a8859-75f7-4b62-a21c-9728e8366306;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-19T08:42:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7762:EE_|CH0PR12MB8552:EE_
x-ms-office365-filtering-correlation-id: 61e35c3e-c74b-4e2e-bcaf-08dc604cd0e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vylAZDjzQlkKOghIi+79V+JmVXXRKAeAFWNpPTJol2iaoujMpS8i7fgsenD5EjJTrDe6VZyl6SW0r2HLaBH6fXKW1xou7zJMBZKHe6uWODJbGhJIIFccw7Zj824zDDGCqPACHCPOZmijEy/8i8iV4JQW+raCoZIlNoEzN6s4z/C8Uiu2J1FuAd/t6VcKC7b+uOhKQzMqdpQdSaxECdIy26hn/rBJN8IvMo8QTqCFzi9jLbgEiJXN5WDQ/NaXjRuTI5lh7DOX2ANM7+vqVeU5NGHpTSow+62YmNZL/UKIoHL2+IaKDletW7P4vwBKyBM1kBKuyxLE5x7L7WUhC9JmvCBWo0iFYqEL6ynHWcl6wjP7xVp+4hzDP3kgHBB4B38W1HaBsyrIZmu51kn+eS7PAIusckAqL10B9o944o6WiBNsR6NfijiHqT2WYID51/awGvH75BWyYtGwnPnlaNs3Nq/Hdml2dqpmCbj0d7Y03gdnE74irwXFivmxP2HNPfukPD7WA68bCCQ533zWMdfrmuiHtwJvF0w1go0LNFOlnHqOMFX6UFrgegUW2jbQn3KXDeSl9dvzYQ0fBnQfI7HJfMKbc4hYO5x0qAqu79r8NPPtfeehbk3a2WL9h0uFbRp6dNLRVBisBD2pnCoPU1dKwMrs4DNbtuVImGHS6N4IO+Cw4wMx7SAs8CgvvDIm2uNMj/9+BG6sEQNrC0owVipRegUersUgOY6AaHOXe8Kn/CM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6naVM0ikapFiDcwuMOSFUx/zElwwDO557szsGozSQI3TKvEyM+wkdiR8Ls3?=
 =?us-ascii?Q?d/j4DkvJGz9lUknuxzBQEteyRoBrTYoZGd7SaaIivGCiEhonedDWLBF2T/I8?=
 =?us-ascii?Q?4P5M6SnMqrg+lNrIjHoqxVIu0CXXMHNKmAUngbeeB/ONlLLv6esSQNBgdvmX?=
 =?us-ascii?Q?iM4Slye4mJrKUxaOTTkImUPxR9ZpLwGACH1dpVy9pTl5C1J/eCrrRb3whgSR?=
 =?us-ascii?Q?pXNVA/Zq5qXNp8WIy7KBRYEbgN8ulScXg2Nr3Chn8uJl2xfEiEzDFzqkm+A4?=
 =?us-ascii?Q?5oDWClu6qvp0ouigWCGfScSLKstGXK1PzNgneadbwlQGkkcTVJI9mEATPD/5?=
 =?us-ascii?Q?beKCpIff5nvuCIx9F1CP028Cg/HeklBQhDtKHfsvpCK8KYzIf/ywzqkAKaON?=
 =?us-ascii?Q?AM5r6aaxD2p4wIiLuoI2Zjj1+ndRaGQ53UmrIU1TCf3ATT27Z1GVBuYRTG2g?=
 =?us-ascii?Q?b7VUfaApqL0Rp5zm2D7LP9wBD7gtaPueCAakvOb3xe+SSEYfLpkOmxR2+pX/?=
 =?us-ascii?Q?3VNYxa7KZwB2sWE2P5H1/8AAQLha0SVc9h7V5ZxhTAr5TBahJBAFE2ejrUTA?=
 =?us-ascii?Q?GS5Dz2FQDdtFkO9yJgpbmJrGIrldbMNLgpm2z3YhxITNzCcsIVOMJC34mePC?=
 =?us-ascii?Q?nK2AqKq+4nArxgUSxat6yCFiw01gUEFpgAG2B/pf8F4PDYr3XbVf8pVTSQlV?=
 =?us-ascii?Q?fzjn6eKN/2Ka+KmA9aoMc31dVA1lAa4eggSZ3DPGtjS4NGWUiBLcZsEy65e9?=
 =?us-ascii?Q?gFTuqCToIu3K3d86/rLqraO3mZCMx/68tSgJaoIt0Mrh92DY4MgxCqNBJxXG?=
 =?us-ascii?Q?8z9PbkLQcWZCabpgADD6wnU+ug1xfH8TmQUi46F1ww0o12+S95aaMnzaSTmf?=
 =?us-ascii?Q?H+xiLAQmTK95cb40uxmkNCmw4DAgnmMcfn/JXbouFDP1KKEFnG03gDNdBsTz?=
 =?us-ascii?Q?/+E3f3GNbdJbtKAH+PY3RAcngfCTxHVwnf21KDSzXzXoBiaxuPtoZdoF7IeZ?=
 =?us-ascii?Q?+LrpEU2kXD5s/sJLS80Fzj5N9WskanQMIX+pvXzOLnIHH4G2P6MlNi/SKKwd?=
 =?us-ascii?Q?1D+75Uj28GywXj5V13PYh+j1SYOz1yYGk39baLC3vBB5WFROMASxebwJ9Ir0?=
 =?us-ascii?Q?cOzBbdqqU88mCzVkQLDAHQYZWYFxJrCws0p7xI/muZlM6IRsw8fWOPwSItep?=
 =?us-ascii?Q?6TTCEem1JxzNFB3Au7lRjWMRCAwzc0Is4k/zXAYBCBeW9HOn5EteNDMqo+aQ?=
 =?us-ascii?Q?UaydaCHH9e41nA6VM5BPFAuPqVIKj9SdMCY6qwxtC/96SpHigLee3+vdDskG?=
 =?us-ascii?Q?kB/Sj3Hf7CS9pggw3m5scUiKPi5r9dYMhk4EPHNwLeBjU9/VLyDbeIlnh0CB?=
 =?us-ascii?Q?CGXkDwfMjt/vvjvj9rpKeyRYUTmpWt4zuUMnAPDtuXFVzAQt8/p5am6FR1ID?=
 =?us-ascii?Q?iosXl201trMFb0Fc/SfgRGeLOOEeRtfOTYcuUXNYdyLvzvpV/+TeFHGRgsU5?=
 =?us-ascii?Q?Dfb/Ls/6WHomhe+Ru6KLc8NIkdWP1t3VwrCZ5WACcymVd33O0POKxK684ar+?=
 =?us-ascii?Q?Knxt4l35A6WKeJcBtGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e35c3e-c74b-4e2e-bcaf-08dc604cd0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 08:43:41.7858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3ugZsT5NWGmqHf2ibypB1EnnL451Pm2E2cqe9K1r0J/wxeMe5MIheLh69KXigFmylN1ivtAXL7o99NXWl0a3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

[AMD Official Use Only - General]

Looks good to me.

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

Regards,
Veera

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Friday, April 19, 2024 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.=
com>
Subject: [PATCH] drm/amdgpu/umsch: don't execute umsch test when GPU is in =
reset/suspend

umsch test needs full GPU functionality(e.g., VM update, TLB flush, possibl=
y buffer moving under memory pressure) which may be not ready under these s=
tates. Just skip it to avoid potential issues.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 06ad68714172..9f9d6a6d5cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -774,6 +774,9 @@ static int umsch_mm_late_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if (amdgpu_in_reset(adev) || adev->in_s0ix || adev->in_suspend)
+               return 0;
+
        return umsch_mm_test(adev);
 }

--
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D369C4706C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 01:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B29C10E545;
	Wed, 10 Jan 2024 01:02:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C4210E545
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 01:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSWKoai+UY5nEFeyslgDDxRilXIYf+x90W6IR6BQ5EN1VZkB9eCzrQr1xPtb/Rfdjtv6pnTX817nktnizJyo9Tz1rOYFXjSlw+8EZ+Zm2xe3iwawdI/SbUwYbZqVm4IaLiZP15P9S2GYr22tZXkBY9G2UJQ2Vgu6Zn6Cmh4gBzrTRAz5i4gr0QoomFoPxZkZZQ+0hHsdQDPJPLsA8+eLnv+Jm3ndEeBBtgE9iE5c3/eR+q76SvSTlBSDblaTuoU4JsgRIxNUNoQZ21+l5F7mGqJbe5u7UIq+EQk4xN3Z3OlYus66PkDoGa9z5t7KVucgAIgEASVmgwYq0uQHaxu6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESv7WRInsIE0zbseJGiEUyZqtmEyM8N5uSygAphg6I8=;
 b=hS3XcVghCKQnPbEXdPidG88uYiKqtUR5lmNUCM5SHMvezcJnBeVKEBt+rDDVukiaJ2sz3Z5wUmsTLIUMZkgFUuz0OpjK71uYLSamz5jgguaQFeQ/kCN3NIcrwuZrj7Nb6FNszcKXlfsaKzVa5MuF7OTvTKj2VOIeg7PRIdLjTq9Nwn0syLjbnGntM6zuzFQ9KS/3rWQGLqNIrvB+P2QWd69HL0EvhV6NgfQxUWk2OEzyuhmo29R2TGiWdWxBRKOSQ7++bi4GEfzU7Tby74i5+z1yW6Zn/qSDFatfpAdC7FGtETNFkNCFrIzCPMxsSlOHoQ1ElgmHEcJ8PVF7oV2TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESv7WRInsIE0zbseJGiEUyZqtmEyM8N5uSygAphg6I8=;
 b=BQ5X5v5tYjSBfQuzWzSuMWRS62UJSV0Kwj/iO+aoo5cf2x3qKQpec7Pv/3Nh9u/izDuGtBFJJ2YibsS5MobFgd7Gg9JZwM9SkDRR5pdCuLiITfhxKV2x4A990yBUqTyllMGq5NdiXtjvfxcfoKAux988cr0RbW1xoyBB61ZUOeA=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 01:02:52 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::24eb:726d:b108:e03%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 01:02:52 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update regGL2C_CTRL4 value in golden setting
Thread-Topic: [PATCH] drm/amdgpu: update regGL2C_CTRL4 value in golden setting
Thread-Index: AQHaQ1/JPrJalJ2GMUe3RQB95hoZyLDSOkVw
Date: Wed, 10 Jan 2024 01:02:52 +0000
Message-ID: <CH3PR12MB8074DC4B22F7DFC950ADB633F6692@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240110005538.1151650-1-yifan1.zhang@amd.com>
In-Reply-To: <20240110005538.1151650-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e771a099-6ae2-4a0c-9b4e-5ca2871d18a1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-10T01:01:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CY8PR12MB7267:EE_
x-ms-office365-filtering-correlation-id: b27d8056-4024-4dec-74cd-08dc1177df31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PPk81AnmcuMijrJqiE0NtwJYyaLca0Wre5L0Ey9YnjCZv647Asm0202YNomR9L2+RvGTl/clSjho4HwQdiMKAJ/U6SS7ErIhL6hVRvrOjmtbGY8OGyzDlgUqD6dIgnK5Tnwf2BW+4nUSXnYnW9KtAe0jKyp1mxLaAebmq4tSoEhLoSrrE3fdE/qLNqFBuwr0dTJ/N+CCqpAoUe1BgxmLMKTur6/qchqR3lrx2Wp4Yuf1VQPmNjeXh0RaWausNtk7N+5K+cUtdHKxry+V5ce2sGnwmDQV8jsIdkLFPDUBuW6K7qSPY5gMSOu4PL13t7i1euhMpHp+gFTBOzLpjCV4rr6Cx1Zjq0bGwO7Y5yptvrwCPglkwTWZji8XaZSPkCfnbSJdr3augIjLn1UEm1nxYlCxfiypHzAVxheVZqFl/IsuZ+IGzdj7F5+5SKXE9mqLGyKf6+DvCl9UPKW+cGTjmwJvQtPGprsr5GbJHF+OlvG2w+71OvMk0beeo3GXkCrAv2Un0jMLZ9bRNSyqsIYfqiEPdeSKvku+z1MfYG/qQFUh77EMbHGoecMDTEzEUCgjwQBmpFiCtdCu6FPfjFuuXiWtj/ibAdc1pUXxNPrmPzTTpGi6+vzaCiXlgi7+LCa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(316002)(110136005)(66476007)(66946007)(66446008)(64756008)(76116006)(66556008)(54906003)(8676002)(8936002)(71200400001)(478600001)(2906002)(86362001)(38070700009)(41300700001)(33656002)(52536014)(5660300002)(15650500001)(83380400001)(26005)(4326008)(38100700002)(122000001)(55016003)(6506007)(9686003)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?npfxkEGvYKjV/YYmp7ugriiwxU5MrqL6pCZgwFrbTr0crJrcCqD1sFDT+q?=
 =?iso-8859-1?Q?jFJPJaiTtg94nBxNC5IBMBMBNIoeKOiQc+6lWhzIJQrf3bY3oHZbl42jGm?=
 =?iso-8859-1?Q?MOP05ZxU4Mk7c8519jSzgesQCyPZkIJCx1g7LL5IGAAZmrpChttw5GXY6O?=
 =?iso-8859-1?Q?EwV59hnGePp1pXHLw7F4ObQxw7EsX7yeEm3UkfI2TGaardCeHIyAYOm8Uy?=
 =?iso-8859-1?Q?E0C8T6wB3dnFuPZr0jZ3PEF09jnfi3nvAFd7v5Aaj9zByN7UXW7td/Wvy9?=
 =?iso-8859-1?Q?iGHPAXn9HfejiQqsPNnxqDOXDwRXY+Y12Sm3UumzOe5W0pkx4jVpR5IAI7?=
 =?iso-8859-1?Q?YzUXjqthzKdNAUHl4Ues4H2+kJvWEqrDfbGAoqFWSVlun/ekWvazOKrRlS?=
 =?iso-8859-1?Q?kTi/o5OBsKQlPTmgRpC37hpQ55iJ6NfKQ4FbFhSEPDhzlxdn6304OxMaXo?=
 =?iso-8859-1?Q?xljIinBeLITkLcvLL2cnyi6O7llBly4x0Q7Fp+CJBeOZysD1Zf4SLe1uAE?=
 =?iso-8859-1?Q?6xgCx9++vo+9rXGQiIapqEzZrqtft6XBFJ22FoJvjSzppFmcz/xM9YNhmz?=
 =?iso-8859-1?Q?B250kx8VzUqHx0O4Y8UGzM8vhIYq4Sypd8369Z1wugSCaavet1XugIfZck?=
 =?iso-8859-1?Q?lVqO5Ou4bY0aubQatv7tcAAZZfCaDIQh8dnaI14bAeHe+DCABbwwVYsxop?=
 =?iso-8859-1?Q?fPe70EOg2+0vE1W9O7IeUn4Hipx8KmpqVrAsEzevYMVnpUYVokPf6GIIOn?=
 =?iso-8859-1?Q?fke3AZ/Fm4u+a5Cil7McpEmfDStC651avWkq/R3wzLrhVclyZSaLB1Ctb7?=
 =?iso-8859-1?Q?LEYGfD80XIa1XQ4H0B5PjwqschtbOOrjcLryqK3rMn+y2jkWC2G74ha98Y?=
 =?iso-8859-1?Q?PUeEcTMUJ7WxsUY+15tuD6/3so4C5f9xvYiUsgx5qnRRDfAvnaRZBbZ6ru?=
 =?iso-8859-1?Q?iidxPwsJfdSHTSyEzUcpJ79/0r2NzJ9+a0ElJjt+4UDlPKxNXMmExGcl5Q?=
 =?iso-8859-1?Q?my1E4YaRfucrC+mH7i0SiX+p03g16INAgBw0hLpocEGOrV13vqjDfrj590?=
 =?iso-8859-1?Q?RwuIM8Ghsb0EzKvW/NMFnFt/3VY4Y7/mOPEl0azqBYbLb/pHKUvEBmb5Np?=
 =?iso-8859-1?Q?fgvuMuJ2kWI81BkxpxM2LfUxXLdxggulovGIx3MsrTD722xpjfFiJ5Lz65?=
 =?iso-8859-1?Q?eU76jCYiZT7g+nT5YtCz93FIpv+cv4c9xBZLOYnld1d1vVOAnQRQHZj5Lr?=
 =?iso-8859-1?Q?j7Mc3l2Rs0ayZ5p9fZCaRBBhARBBTqExePM6WNKizCvCV6HEJERbgFse4H?=
 =?iso-8859-1?Q?RCeLImrHOWp9V8mZxkCTP00lmQN0wyU7fiUKwwmy94+nYi0mF8TgKSKFxI?=
 =?iso-8859-1?Q?2ezv43LIts2N99g50luK4/o1wn8DCanKYsqfi3oRFHzYS5IxETbrYg0/R4?=
 =?iso-8859-1?Q?sLweRYRN5dJEsbEiBQqPQbasVqdu9Orz0kf79kXdo3aHJ1amrUmB79wcW3?=
 =?iso-8859-1?Q?TqtiZeK9ZQIBxbSFq8XQJxovSY/2TU2YcFOUHdGs79EMkbeeumSRVxt6CK?=
 =?iso-8859-1?Q?yGURGkqep1J7eLrW/RrP9MEtl7NTA+zgo+jnVAkS7Zl2tD00C0pOmeOmK4?=
 =?iso-8859-1?Q?kubm0X/QDkHoA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27d8056-4024-4dec-74cd-08dc1177df31
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 01:02:52.2969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU3iYTXgb4ydkm4h9UaW8FE7kc4O2B+0vkzX1nw5BDnDPihEqz4cs+2v5LUpsDqg0ovutr2sn05mYNTx9duUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, January 10, 2024 8:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <=
Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update regGL2C_CTRL4 value in golden setting

This patch to update regGL2C_CTRL4 in golden setting.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 36c4efd89dc5..43dec9dfb3fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -119,7 +119,7 @@ static const struct soc15_reg_golden golden_settings_gc=
_11_5_0[] =3D {
        SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, =
0xfffffff3),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f)=
,
        SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188=
),
-       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x8000b007=
),
+       SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007=
),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880=
007),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00=
010000),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x0103000=
0),
--
2.37.3


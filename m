Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA0EC001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA4E10E1CA;
	Thu, 27 Jul 2023 08:59:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B5610E1CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 08:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLVj5mRdRvfoo+5cjZkBO99tCoC3kVFgVAdoRuP/RVEJMKJTUy6WfEVZmANYWOtediLTTJlRzQzE7S6bi4SajxmiDrQvlfNABN09LgUChY+QVsp806fOIXCko94xyFv0uX5lmN3Xp11HDu4fu60yOhohZMKwAezSL75rL+xhXMNOPOrBzSVy9kHbWzE0Q/uLE0fgcDh7ZY+Pcc/Pt88FcvXpUDdV3x0YS7udIJzFXQmhdsxDZfjMJqqJS/9ZxcvCSHxvW45agN8SqjDbSuHbT6jZn7rZpsK23oN20wsMQTZN68DXhWhjsxfcChP43XDPrRCvQ3v94tnF2gS0AiJryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A6seUuvKel/9AnSRs2NrwaimgjBKmGuyYRB7RyhGs0=;
 b=DlRodtMhD1KhKJAT9n+rgAypYkyRtF19AKBGM+7g2ohCbMiEN+nnG8PCpe7kAqdcKXebuqJR2DtaJNQ/cmyLg8cXUYVVEW35NxRfO0jHPl2r9M7bOTIqci4l/8ju2k30qPuCM3kipG46VvcaUh1ZLLQq9T0EH8DwYSee1LLSZ+1ThUa6VRld9Z3xZg6HvFtKKYTgs7n0TotxUiCR31MX9E19Z0PzVHe5JxD/+/2MUX2dkzpiTNLCfih/jK8J8GBvjBrR2SOsY7IPU+GHQx2IJJF4lLb5eAa/z9xYquFjCnusIUzsPaTNyg6JAeRWerUqipjai6r6q7CugL0hnKi0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A6seUuvKel/9AnSRs2NrwaimgjBKmGuyYRB7RyhGs0=;
 b=YRcXb0zPNgmOvowSKLVfm42bkMbtkTYQV72fD0t/1bh58iHehvIb/eg6Z1H0xJdmDFVMuEaV+1jhqgNL3RpcJq+w4F7TMD3pZTprx8uu5yh0e1K3xK4OyVITgEFKhprJjmcnM4TccCSV74aXx4yrZ8C80km6A2FVQV/KYUE+NdI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:59:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:59:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11
Thread-Topic: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11
Thread-Index: AQHZwDbQr4YSKLUSyUSyB27QrWNOy6/NUM1A
Date: Thu, 27 Jul 2023 08:59:35 +0000
Message-ID: <BN9PR12MB5257490A5040F5BA97EF4173FC01A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230727030222.698498-1-Lang.Yu@amd.com>
In-Reply-To: <20230727030222.698498-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d022e9a1-705b-4d0d-b045-26126d4de288;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-27T08:59:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5223:EE_
x-ms-office365-filtering-correlation-id: 904e4ac3-b574-46ee-26f6-08db8e7fccf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZZupMvcx9/JxNashOmWiojlw75MO7ogkq5W7GROW0QpkUE3JZND2P1zAWw5AYjVXYe/rZl9Ud37t5kXlyiqxAwUP/2OezZc32jaw4+bJW9FscgywvseuePYLAamsVhuKDo9DvBWqk8UQbbSZSTu6smYUx7L3q5KHf0qV5CradtcY2/VD2lVUFRCfYszo5YgsJh0Qu6qPFSs+zef3J47FG3tO2QnhHOEMgQznV6/SO1erfeT57W6LYOLxpYKzD+Zg7EPRQubOz03myI+UvaozH12l2dGJRDajZemxBeU/j4TgMdsSErCPTjs3rbhH/nQ+2b8//gpdbgpUcG4roGTNVl2Kdy5IPJi6leItNzxXVQg99uvEHIYAkrsYkvdqMf3VA31h5D1hojKK1Rydo+rVZPTyzGoP4PGGf2S+7BhzApLCB0XhHDyryzMcw0E7hoeX6SIQC6Ab8RQW6YR1oJysJDheon++EQUgvGyQiPcmm7yZaMvpLnM2t2yi9qUQR8Frnat0uGEPL0A+hSuUIlMXLmrB2qprjJFQtVJiGrvIt60IiA9UOhRc2N+46mwPxMdUuOaIiQKqCLN+tAzgh6GrSJl99lNPnaAGqhIwvXHeQxaG7t0UHvN2S9aAIp6FhDR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(8676002)(8936002)(52536014)(5660300002)(316002)(53546011)(33656002)(26005)(6506007)(186003)(86362001)(4326008)(64756008)(110136005)(38070700005)(66556008)(66446008)(66476007)(71200400001)(7696005)(66946007)(76116006)(9686003)(122000001)(41300700001)(83380400001)(478600001)(2906002)(55016003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fT0DAog26xc4qrtSZ7cM3qIegs9YkOQ6QL7NOPGQR07B3QJnCXyZGSnhrDUu?=
 =?us-ascii?Q?c1PRexq6gfUZ8vbC3xgIHse2EhMEtagxEWLydcdEw47Wp29LWzyN/9VMSiL7?=
 =?us-ascii?Q?LdeYf9PQhYNjfgIiM+/GLfjAjf+ZeeQKRZUMu49U4Yzgt+wNW7u8jLILqbP2?=
 =?us-ascii?Q?3IvU+KnOC2OZa2FDpkqk9SAfbf3kXG0s6rhBsDohrNBWwvkIT8zp04hCoYeT?=
 =?us-ascii?Q?iMOKBDBQns4te6VC51xTcpxL58gFud2ONaSoJRUMIaDE08wVVQShqqvxw1u8?=
 =?us-ascii?Q?Stgex3I8D6VrNtrfX6PrNwET8hhxtTfAJ0MPLE/PgsUNrkbiZzZDz3wqRsIQ?=
 =?us-ascii?Q?6UFHF1+z9YB6rT5cp6hsp63CGZ8sH7AH5cQ3pg8TQLADHZOwGu58f2TmRKLV?=
 =?us-ascii?Q?awClcSCuhSbmeC39cxLJuOcTUfChf6kyt8rd4OUgAMwQkUCtmy1jhVT0tUCC?=
 =?us-ascii?Q?HdkcmjeOq/hx0LI1mFDv8xAjn6RTFgvyzX3P4NPiglnqG+QK2uwKTVW9e0Sp?=
 =?us-ascii?Q?d4iFNCkY4DoS8tcjltZFB72pPM4xrYD5odyAAWrwW1XLnmtkpt9+7d9SRbgQ?=
 =?us-ascii?Q?NcG4AVEmXdk2q90iE+e0lm/abyBosI24lgwW1ypaJsONfP4dVDTWZ9pUdrY9?=
 =?us-ascii?Q?YKrChag0wpN3Gwg68lVTd23Eui2IUEm90p21CfNsqdW3O/bsJpZun5xCueOq?=
 =?us-ascii?Q?Ie19mdjkbILfkP4N/Onrun4FtH7MpyqF0+uXgXM+VEV9ZS3a5bhH1wv0nwZ0?=
 =?us-ascii?Q?khTzYWmTPFGw/Qq4LFiSOBJyzt3gOEoxhAHCeJO0fxmdVlOqa/x34DBzyr7P?=
 =?us-ascii?Q?rHO313qpZclH+LCG32G9XY/yTfvHmHvi6ZMvtuAN3OMxvfBaMoZM1BJWDlnJ?=
 =?us-ascii?Q?KWg9fV/VsywcCdVUB1spPBcTrJ0YFyfCyl0eKqB4+C+Pm0Sndfg+K7jgSZ2g?=
 =?us-ascii?Q?MYneK0jetICQ41UaKYNlrBtTm/hYSpfylELCKIWUb06Lqlo+M7kwj3KsY/wT?=
 =?us-ascii?Q?pY6Q22rj5/5zGf1XI1YK8oSMtl5VGt4R3p+BUeeX6cN+RhDnswyXy/+yetYn?=
 =?us-ascii?Q?aBYi/Tso/XXrIRlChO+QSw2Lru2hAx2HhEw1p8dy5IaAwFxUZjqSWGi8fG6p?=
 =?us-ascii?Q?oXqexztycFOh+mEvt2H8lvCubdg5cWddsVLN02eFSlDsEaYsmkPWuDqTWj7Y?=
 =?us-ascii?Q?S/GsL0bgeVryd+547aqgKi2LztzBsIpIZLMx2cqZyoX1v3j6+q7+waS2LIBm?=
 =?us-ascii?Q?rtp0HGXods4iKfbr77yNRDDR7epjCRxjRGm2MmJDv0F04Q6p1ioiFnZLSBnb?=
 =?us-ascii?Q?tg9Mulxr4nLizwqL5NTOm4dF8et43v6nv7s9McsJdmDlwiRlgeUEPGMqHMvd?=
 =?us-ascii?Q?lAZQUaL8+DYsAj6UyMCQY+sTK5sGoFHOjyg+lWmhJL2Zg/bbdkG7sBvVfzmc?=
 =?us-ascii?Q?NWUwI1CiTvEf5ghIYL/PWukD1nIOLq6rV+5wNl3LevMzPngiTe5/yTt9fBFk?=
 =?us-ascii?Q?QcV4SETCQuX7vWca+xg0Ysj2Mld+hCfSaQyP+MIkOpp+wRym/PO6feWVtZuQ?=
 =?us-ascii?Q?0tt8dpuB1POXTzU7sCC9o9RIb/Yub7s7g9Qb1Srt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904e4ac3-b574-46ee-26f6-08db8e7fccf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 08:59:35.3255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuBN6tC4t+ffIelHNm6PRKmA5nJVFRZ0ssQn0W8YO0s8RLa0MwADjFe/E225heafqJGxc2N7gOrbJIEktfY5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Thursday, July 27, 2023 11:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: correct vmhub index in GMC v10/11

Align with new vmhub definition.

v2: use client_id =3D=3D VMC to decide vmhub(Hawking)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 +++-  drivers/gpu/drm/amd/amdgp=
u/gmc_v11_0.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 6b430e10d38e..fa87a85e1017 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -102,9 +102,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_d=
evice *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
+       uint32_t vmhub_index =3D entry->client_id =3D=3D SOC15_IH_CLIENTID_=
VMC ?
+                              AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+       struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub_index];
        bool retry_fault =3D !!(entry->src_data[1] & 0x80);
        bool write_fault =3D !!(entry->src_data[1] & 0x20);
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
        struct amdgpu_task_info task_info;
        uint32_t status =3D 0;
        u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 604522f70d03..593f110921fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -99,7 +99,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_devi=
ce *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
+       uint32_t vmhub_index =3D entry->client_id =3D=3D SOC21_IH_CLIENTID_=
VMC ?
+                              AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
+       struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub_index];
        uint32_t status =3D 0;
        u64 addr;

--
2.25.1


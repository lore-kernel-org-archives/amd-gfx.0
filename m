Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48019C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 07:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F0F10E155;
	Mon,  6 Feb 2023 07:23:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B3310E155
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 07:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apyT43B/UDfiuXgu1jVhaa7wp6J38EAjf1nFJ0O9ejma+FAO0wpuscgiJxe7kj1yB7Pr1o7ZZWYj3azo0FKbFiuvIsVv99xY0JtvWjkIKFbEr2oscyQvj5TuZ5yYB+DXVjCEmT+1Irg+hLs23OX/UoN96m+HntmJBbfpZZ2RJ0dsTwlzV4AIQpXXuc9tNU+wAdJBSvBdqaQLICf1e/lE7zER896pVj22VGa+BRyrtpYiDDv+UuNgLANqeCo0x1YnvlcBa1EXEVucbJisw/jC9bKLGON6ZIhsfWdQjB7fbG1KiVI3DsEcBQ/S++GotPKj0FbE8ublaeryVu9oAQ+/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsLtoVPShCDN8eJyrJC6tKdExsIhCyCWOBtdKGlSuxw=;
 b=LPlZQEa49iDPRk36tDBWamvU/7BId3tCKeoqJ0YxaR81LvRxm6uQ+llAypaRGcGEPd9u+abAQj0xUyAjXb/mMV+BzUTZQm1A6wv5DRn+8SxJGV7oJNhUlEdtNRYGlysyvGs2m2ywMP54fLqmvP2KelJKyVP419DzdYYPIGFYST03FCIOOTrawaLhbc4EEWDSXgCBHLAMc79Cxj9BeRBkAY93ojhUWyQFTqpNGvYmBr36n1/oh/Kmc8kevH3MivArDuh4wqniBMGJjNWA4zx7IWbnPr08pOAKZvT+406mhrpLPADTErh5pUnWp8sgvu4oL0BPrOFZN4yv7f5LwwK/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsLtoVPShCDN8eJyrJC6tKdExsIhCyCWOBtdKGlSuxw=;
 b=Cs/Pm6YHTacef3rIlOuq4eu7mBGqmJr6jbtG/2IMyDOxoMg/RClRr1TizjPvZ/wgSA4bjwe9IeFZQRmAraqWiSRjAVV9dPFmoeg3rg5zBBcqCKJscIdS+jtHuuhw7Y66fLqJu+fHeoE202IVYcSzXYYbwZ3Lq2n9X7qBInLSjRM=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:23:06 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0%4]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:23:00 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Index: AQHZNuxfg8FNVol4pke6J9qzLuANM667iUeAgAExmRCAAHu1gIAES/RQ
Date: Mon, 6 Feb 2023 07:23:00 +0000
Message-ID: <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
In-Reply-To: <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-06T07:22:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6e282b2d-6f1c-4cf4-984d-e094e4c814ff;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-06T07:22:54Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f076b9af-2fd3-4866-9814-97c524dfe66e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|DM6PR12MB4943:EE_
x-ms-office365-filtering-correlation-id: a4dc3b69-aa70-4166-0eaa-08db0812fa10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEOiPzp8RhFpkWRtd/octVfPOZ1VVwH0PhLg8IfuMrzPtKs4qsAlnwiCHVjYsATtL/PxO4lveCeRo6Pawz+iw9i8XHt+gixL9sFvxgQIiTETLkE0TECMTwQ4rhhq4nGv8f4AghsAUzGQIxKWwYlvv3Vkky0UbILUzlwrdyTiSZ358Fk4Zo0w8ZGYLKENIIPuky+ksvkbI9Yypz6ceaz58Z05mJqYPXOzcFgakygXEIb+gvFi9dJh+kyJVkID7RFeK+bYVxEU0GUooJ4Gr5XFhT82ZkPvvSvfuaso074W0M2naRi6QmbDeRjiwYeQQ9pLBZ3M7sJI1jnTSYbORm4A9TK3qoy3F25IWVKHu8Ua/REnWOPL0EdiEuMORaA/UUq/lOn1VM1GU3j1KSGDdcibwCq9wZ8GOTS+SlU5IEzNzXTlUZPJkxYus6Sexg33rWvpBa25H4cZaPiK/HzjrbpB/cZVZnxQW6jup3LLS3GFeFBedFmSLoAzryNrR0buU2Yq+CIMyFHecTdw5fpLHv5XcHKBmlD7pqJKyvRnwY0UhaDeerzIEyrKp90gr0ZX6aWX8kPsQ8uPGIVF/Rhh2etNNzqy42Gk+67Qb/NynqRSvCirHIsqwDxlYiX1izibG44QPNql0B1AUoJ7BfL76laRew6E5YnyeUyjQJxiecnXWiuZb8YqhdybiB7w693+PSecTzXP2CrnCaJJPDCdpmTrzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(64756008)(55016003)(53546011)(478600001)(6506007)(9686003)(26005)(186003)(8676002)(6636002)(110136005)(316002)(66446008)(66556008)(66476007)(7696005)(76116006)(71200400001)(66946007)(38070700005)(86362001)(33656002)(38100700002)(122000001)(66574015)(83380400001)(5660300002)(52536014)(41300700001)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qAyDVg35O9bUmVddUbSblo4PupfgFUoIjw/ehLZ4boOgRZssYro/hf07EX?=
 =?iso-8859-1?Q?irILW558eDLUDoqA7p/CXSU+LJwKbWv45cO5H7KkVtcXGnesyHBPXGwk8j?=
 =?iso-8859-1?Q?ArlrH2nMuHwM7FaXqMg9LPFTcBwpSAeTYVBTKU8O3BJwUeE4nSwdapny6N?=
 =?iso-8859-1?Q?ymqm08MkdpshIs40ucMYCJz3672i8jucx9AzvA4DYnvkEKCHr4aJC6b/vG?=
 =?iso-8859-1?Q?1UaquzBunikHeErcDDlg+mQw/FmgjQ6DgN72UPzH7JUiYN3cn/7eKNfhln?=
 =?iso-8859-1?Q?dzl7oGdt5b44XN2RkIpLQFkENK1GEmcBgLHKl8HUjA+UF9Xm0GYCVrUhpW?=
 =?iso-8859-1?Q?wSxvW3l1EWuSsH3MRf/d/OvzdYbefNgZsb46oS+bm26DPdu9rD6xpBxxjI?=
 =?iso-8859-1?Q?3gcQfqfiOhwFn+zOf2LR2KcZFIZjNK6hZ8uZSKaJnomYvhTQn+PLSa3cmf?=
 =?iso-8859-1?Q?4lgPv77yNIZg1z2fi75Fwl02RVjzDVdmYAVdTblB13Q6UC4b60KN00458H?=
 =?iso-8859-1?Q?iIMlbxrKn0QzN28Wd+fajUYcXM7jLlPhExeeBHh0znnDCrkvnuZV8wao1x?=
 =?iso-8859-1?Q?2O1I6fqGzbT+oA7OMmufBpFokP4ZY9/0+9Eu0mmifJFUmhijnNVZLXXk7j?=
 =?iso-8859-1?Q?D0DLfnKimsdPCytswRW8UxcJPF/z3Yr/zcxBLhFAQa2gL0Tj/OzjtSf0UL?=
 =?iso-8859-1?Q?hdVdCbD9EBirtVgCBThJTkhboBrZZ7cG4B4UjDkmkNiRxFc/OW98CtjjDb?=
 =?iso-8859-1?Q?3IM3LHUSQuTXjSxhl2BkRcUnysg1fSvUdriwth1eKy8ju2mZ6uIRUo0F+o?=
 =?iso-8859-1?Q?ZxoVHenrFTjAjlmdgJBsfUzqRWjph/lFRzqOrtrTQO6x9D2bBNxg776iOj?=
 =?iso-8859-1?Q?erVsXcuvywq2LlHFaYzpU6MuPlESyFYEGdWDEUHPJho4EhcWklcVbMdyeQ?=
 =?iso-8859-1?Q?zH/byI3Vk2Kpg/bKQaLK51t4mnJIlaQ3XeiObWVTqvywd5m7f/HBb93wp8?=
 =?iso-8859-1?Q?gUH+iOTMcjX2JhNKD1HxxYacfcl9BczVS2tM0HYdfQLJo/iZHgz6guQZwg?=
 =?iso-8859-1?Q?rE9TD/dliMG6bOqixBP53yeucyrXCyph9iODxVhOL91WO2eqt6iQ6YvGiV?=
 =?iso-8859-1?Q?yv/Q1dW+vmHjEXvdnnFlwPKxXCEUrapOeBd80kKZyGomj+29PyLW9bRLcj?=
 =?iso-8859-1?Q?6L/HXAp8QXlle7VbUaefg6+8CiqcZyn21sdQyJJ7GRAqIBH/tj7L7hlBV9?=
 =?iso-8859-1?Q?A0FqIH6+FKRDncD3MgVXHaVB8XQPhnAZfvZCQ1nZN4AlglIGIvQ6zzbgiz?=
 =?iso-8859-1?Q?p8AnJO4Ue3sxAwkCtzAtvgWyc/8oiw0d3g1lSXsCPKU3QsC2dVHNrvThLg?=
 =?iso-8859-1?Q?mod3AOPETD13Mjw/zKaU6cvsml+tNCrew2yv+WhVeurZRfigZjxq/sTId1?=
 =?iso-8859-1?Q?RxuTyFLwUuhlpgXYojjujfAZseOIv7dpFGcg1yEAM12KVpghEd6MHRCw93?=
 =?iso-8859-1?Q?JAhyoH8UrwNEACjlSLPO3UptEr51lkFcArDBzpQLPOtOCda4ptnZuK94eH?=
 =?iso-8859-1?Q?laY/7kPAoz45RkVoRqKiqBv1waa85SIYSe9WlNeqxLZw7jdahdDqlSDMj/?=
 =?iso-8859-1?Q?kGEpd9Qp1zLUs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB4458263C5E9B1071F7831EF7EFDA9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dc3b69-aa70-4166-0eaa-08db0812fa10
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 07:23:00.0378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SN4IsBGK2ms18F4r2RYwaydxtcJps9dHTbxTWRGHwF6BGfKolwUXgz/pQE2Pa+aB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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

--_000_MW3PR12MB4458263C5E9B1071F7831EF7EFDA9MW3PR12MB4458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

>> Nope, that is not related to any hw state.

can use other flag.

>> It's simply not allowed to free up resources during suspend since those =
can't be acquired again during resume.
The in_suspend flag is set at the beginning of suspend and unset at the end=
 of resume. It can't filter the case you mentioned.
Do you know the root cause of these cases hitting the issue? So that we can=
 get an exact point to warn the freeing up behavior.

Thanks,
Jack

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, February 3, 2023 9:20 PM
To: Xiao, Jack <Jack.Xiao@amd.com>; Koenig, Christian <Christian.Koenig@amd=
.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Nope, that is not related to any hw state.

It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.

We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.

Regards,
Christian.
Am 03.02.23 um 07:04 schrieb Xiao, Jack:

[AMD Official Use Only - General]

>> It's simply illegal to free up memory during suspend.
Why? In my understanding, the limit was caused by DMA shutdown.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Thursday, February 2, 2023 7:43 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander =
<Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Big NAK to this! This warning is not related in any way to the hw state.

It's simply illegal to free up memory during suspend.

Regards,
Christian.

________________________________
Von: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Gesendet: Donnerstag, 2. Februar 2023 10:54
An: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com=
>>
Cc: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Betreff: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavaila=
ble

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,
         if (*bo =3D=3D NULL)
                 return;

-       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+               !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_T=
YPE_SDMA].status.hw);

         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
                 if (cpu_addr)
--
2.37.3


--_000_MW3PR12MB4458263C5E9B1071F7831EF7EFDA9MW3PR12MB4458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Nope, that is not related to any hw state.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">can use other flag.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;&gt; It's simply =
not allowed to free up resources during suspend since those can't be acquir=
ed again during resume.<o:p></o:p></p>
<p class=3D"MsoNormal">The in_suspend flag is set at the beginning of suspe=
nd and unset at the end of resume. It can&#8217;t filter the case you menti=
oned.<o:p></o:p></p>
<p class=3D"MsoNormal">Do you know the root cause of these cases hitting th=
e issue? So that we can get an exact point to warn the freeing up behavior.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig &lt;ckoenig.leichtzum=
erken@gmail.com&gt;
<br>
<b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Koenig, Christian &lt;Chri=
stian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Nope, that is not rel=
ated to any hw state.<br>
<br>
It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.<br>
<br>
We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 03.02.23 um 07:04 schrieb Xiao, Jack:<o:p></o:p><=
/p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; It's simply illegal to free up memory durin=
g suspend.<o:p></o:p></p>
<p class=3D"MsoNormal">Why? In my understanding, the limit was caused by DM=
A shutdown.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:Chr=
istian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Big NAK to this! This warning is not related in any =
way to the hw state.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">It's simply illegal to free up memory during suspend=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">Von:</span></b><span =
style=3D"color:black"> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">=
Jack.Xiao@amd.com</a>&gt;<br>
<b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
<b>An:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;;
 Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Christia=
n.Koenig@amd.com</a>&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao@am=
d.com</a>&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is u=
navailable</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Reduce waringings, on=
ly warn when DMA is unavailable.<br>
<br>
Signed-off-by: Jack Xiao &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 2d237f3d3a2e..e3e3764ea697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_=
TYPE_SDMA].status.hw);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reser=
ve(*bo, true) =3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-- <br>
2.37.3<o:p></o:p></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MW3PR12MB4458263C5E9B1071F7831EF7EFDA9MW3PR12MB4458namp_--

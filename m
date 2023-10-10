Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AA9CD68E4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 02:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5BC10E30E;
	Tue, 10 Oct 2023 02:27:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3781210E30E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 02:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA1qu7baXscMFmHNwyA/pUD+czbig9kglFSvSwxWHN69Jihh5YZhbTLgEBVGAwQvlbT6DG3tkmhLDMoou5kf+QtXUyEkrz88QRVx8qnVuHspNxgzmWkpHP1AD8yMiV14JYb90UWvRvyISqbkg6Nj7WyTC/z53QFv8NK5+WOQ1EaxP8f2hE/kIA+VYIO9xZadxyRQ4pwb9CjsUK1EjY/WcLk2Tl08IrnBcfCAI8djphSMTP3ydztBH9HDz/q+X4SOhfrmXNyaM18iqpb3LY8n8TQYiQFnhbqrtZtneOJVrR6pycXbL7sMVeBxKoD357egEdOiT/2vMnn9PFBG0YObrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daOs0J95/W5zbZCAB0cg6uExf47IhtLNrwRIiJJCoNg=;
 b=IMWBBnzDbjSqn1esMBI2gxabDhtvKx+G1Sj0fkFSvy2YhWVas7/uMQx/wN9Y/lj0TFtvP4UxwQaJxe/E+qXzgTxs/DcjbzYdAJ3ND3tbw9qvl+j4NgAkJptIB1Z2wu0yg2rKOiHExUEt5BsbHJlnkx1HKYGbsudRHGflYB6s7v7KPXv8sZm/yDdCVIJt8KNIkWKfbQIrzaBqTg0D9VcmG2sIcqWE1eQfLgsEwCkvpNHiMe0hbpoGDs8waDMeFfs8FHMXb/2cssQj5N8TTdfELilAEtb0Wu/DcwatuEmZ+pJJSPCvToP4cN5na/LB6n3hagUYV84E0XUwhsKqB9scBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daOs0J95/W5zbZCAB0cg6uExf47IhtLNrwRIiJJCoNg=;
 b=gYfPyE5um2+n+Nrb4Vqih5uPVk/HKRd4JzT6OyFRhyNLdIX1QKIdqbDrF5j01SloRih6uf8V/S1+BoRpxVp8a4x5T+/OYqqBWyPi6rEoDqsPGMvgysy1Dz67n1Xyp1G3W9xG5f+rFe2+1IVZ5asUmuBKtPKjWYi7JSahW7f5DeE=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 02:27:42 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 02:27:41 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8qZ0SmqTbiB0uJBjZ5G/CDQ7A/5QOAgADKnbCAAHo7gIABGubw
Date: Tue, 10 Oct 2023 02:27:41 +0000
Message-ID: <CH2PR12MB415201DE77642C298438B4ABFECDA@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
 <BN9PR12MB5257442EEE0BB34C24F1A8F9FCCEA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257442EEE0BB34C24F1A8F9FCCEA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c646e2ba-d647-4c22-85a9-510e3ea61461;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T01:40:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|PH8PR12MB6892:EE_
x-ms-office365-filtering-correlation-id: 60d1131f-be2c-4ce7-2f4a-08dbc9387ad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GL4jgh92RtA/0p1PCQzVfNT0yrHPdWu7YajCdTmzywtEroL2uVowfjLQyGjdIjeLdgsiZGJhO2TCbs3SXkpcRARcP8MKgv3K/cD/hU6CSUZ1hIC2HetQuxwXcu0jA7KBOeoS8V+S5zZWB/Huyc65Hs1TzWA0baOWc94xgbw2OMvYZ7LHUSjWdl68DpR0dVG7VEbt8CCwMDPW/OA5pSSIjlXWwhwduzOr7v69DFOWX3xQvHXhxvq6fRXudWDXufDDtO+NVNIRgTFhZYedAkHFBST6TsVvWJGlSMbFuo2yST61RZoh29qAuvI/HRLhrdNdDWJ9Yv+1n5IjAKOmaD5yhJOhR2ii1aGcS3sb6BZRa3KcBFb9VlSS5pN/PJKhDKQgJQSCQ78aWwr1jwANreSu4jgBCt4Lci20hTYkrHEfUUYQKM9wPzxW3E92u+tOnm333jMGlIZo+TO8ZeIZhT/NC3INrkatkPMkw4O2GoXthAlxxK11H56VGvXPjTSQxucTL1wvJgjS4WdtdaSqus+RqRJGt6QhinZTlAQ4RPAsswRp+vaPGxPeq4N3dnXQYmI7smPglqYiyoq3QJN+x62lAv6P5/S6eUCdKCQccyZjywpCBOyOPV5JFSJaXhdUrF0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(122000001)(86362001)(38070700005)(38100700002)(33656002)(55016003)(2906002)(9686003)(478600001)(41300700001)(7696005)(8936002)(52536014)(53546011)(4326008)(5660300002)(71200400001)(6506007)(8676002)(83380400001)(76116006)(66476007)(66556008)(64756008)(66946007)(110136005)(66446008)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?thM/rJBmoXRzkyQbUA/QlhvZv59ZofqhuAK6OkAyZIm5gIEM1RtN7RdhlekL?=
 =?us-ascii?Q?kfKW/zv4kQvchQEDxKSpkkGdQebk29n5PXRr8E2tDXfSTuf7gCJ/CIH8JAoq?=
 =?us-ascii?Q?0RZD8nh9HqkKXKl92MgInZf09QY+0ptc/mg2C+GCDEvZWrIK9g9zU7NzvbRY?=
 =?us-ascii?Q?V6dh9zkOV1QGVZ5bDAiCFjhPxCcGi2Ynv9SsLCWOuy0TZFmAJH4mqTiwDvO3?=
 =?us-ascii?Q?KvC2tK3pJUuhvIPmqeewCPTwsV1GKsiduO9bTkStHPVVmJU/9XIZ7JieNGZB?=
 =?us-ascii?Q?mCPpAzWA1wdWmJBXTQeriJK3MrfiwzOqTMXGajR9a7t8JXb40sHqwtF/qax9?=
 =?us-ascii?Q?4DxOkGYGPEEZ3bcTwxVTZKHMueFFGKtsl7nbRUgwzpp9uMx1OQysDV/GLWOA?=
 =?us-ascii?Q?s/unKkBsByKDXmGYAx/J7KkZcPvXQ3UUgTPzMwbCCjUu8AS0OnzK63yAyuAL?=
 =?us-ascii?Q?fUVL4oEPgiTs3aG82JImjg5kVX49H269AdP2kSBBnde7vHi3BaKPDbtyJttE?=
 =?us-ascii?Q?0Nty9nUJwLsryiOpYK+pjr/nYFjfHRlfAqLiPO4DnKG5ybjXAOSCTyziVFuZ?=
 =?us-ascii?Q?3/XBGCEnk5u15NsnJu2cttdkKv0xv6s59hYy8ZJe4DK+uxUqior+7sJBQIP/?=
 =?us-ascii?Q?gtOz6a4Sn0lKUSLF3rDHxN3ceAQWHzGqs2Vml0OyzUag0Dih33ULz+dDmLTQ?=
 =?us-ascii?Q?OBFkfzD8jcTCg+eNLxIlz7raeTlePOb8X9BG2YIHa2N2GHPFcFaifM/lMiGt?=
 =?us-ascii?Q?b+ncWkWa6SRlARjE11byubLegpmK7T6vGhL0ljE7UXKTyJX/Jc7IAI+twOUu?=
 =?us-ascii?Q?QSFihDc/xKZLuYUYYr6/UwsPgo2wJjC9fWXJkpyJuzjV4xrk35HJ/WMWR70T?=
 =?us-ascii?Q?fZI7wba8rlBp4+/W0ckueL0lMIFveZFUMwxZFs29Wc/rgjwp4L+EqMf2K3WX?=
 =?us-ascii?Q?3xz6jJBHUn02hYFPlJiQojoa17r3ClLPmeEyvEWrwukc6iJAf5aAQzGz9aY9?=
 =?us-ascii?Q?VQQY6uqQUHfoLR80rEHutkZqkUiD+D61pn/U7oZfzrFhXMLTb81B90uCMeTG?=
 =?us-ascii?Q?0Idh1nc8jQElhNbLHPgBtXx/Iiegao0cCt4hZgz+cmB+dH6P2uSihcJf/38k?=
 =?us-ascii?Q?M8fEPjkQ8NOVe/JaaABYgcBslbMLhdsWhSFdmSwANZmJuii6uJvpzJOHuVfq?=
 =?us-ascii?Q?sDlX50Mw6P5Hwi1K6awVsiP39oET0wJEUfK8EAbMdISLsVGLdYomvqmUBhUr?=
 =?us-ascii?Q?MuFgszB2cQYJlnifSZgHqPIgwYfk9JNFLOwZf0UFXbKXpPbou1l1aiJ3JOsC?=
 =?us-ascii?Q?Yln1groN6CYdlm13+2aU4Yki3z/ZyVAaj+yVOR+5eO33XDZA4ZUIsSluqhlw?=
 =?us-ascii?Q?mmiNz5JkgeU9sB6hDglNYMTrwqxR7u7cP2ZeYwGotbuc3MAMFK1bP3/vxKjk?=
 =?us-ascii?Q?hw86wuTDOfX22D9dV/m1HXYIY45cD84MUa16cQm+FBnN1cTgd4IE3xdLvqGY?=
 =?us-ascii?Q?+rcvi9jeaIvLY/vz4K8ZRXbDyrMYisodsA61JTuonwDikPXHYGpmODozc668?=
 =?us-ascii?Q?ztU7Qv43kS0ya4dVzY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d1131f-be2c-4ce7-2f4a-08dbc9387ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 02:27:41.8521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeMtBR5KEAvYF8ounX5YjKT2moC7UQEw3f92gXzkcPf16zDi0eg8qbyaPElsjnNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Yes, adev->gfx.is_poweron check will be applied in gmc_v11 callback, which =
will be called after the generic gmc part: amdgpu_gmc_flush_gpu_tlb() funct=
ion.
But in commit: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tl=
b v2"), the flush is moved at a higher level amdgpu_gmc_flush_gpu_tlb() fun=
ction.

Thus the gmc_v11 callback will never be called in the resume because adev->=
reset_domain->sem not released and returned ahead. Adding a check of adev->=
gfx.is_poweron will let GFX11 not breaking ahead, like following:

if (!down_read_trylock(&adev->reset_domain->sem) && //--> true in gfx11
+!adev->gfx.is_poweron)         //-->false in gfx11, and the whole if state=
ment will be false, not return ahead. The following gmc v11 callback will b=
e executed later.

Thanks,
Feifei

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, October 9, 2023 4:58 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

[AMD Official Use Only - General]

adev->gfx.is_poweron check should already be applied in IP specific (gmc v1=
1) callback. If gfx is not power on, it does nothing but just returns. I di=
dn't see how it helps resolve the issue if we just move the check from one =
function to another.

Regards,
Hawking

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Monday, October 9, 2023 09:51
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

[AMD Official Use Only - General]

Hi,

>> Based on your description, the above code should use "||" instead of
>> "&&",
&& is to add more restriction here.  To avoid skipping necessary TLB flush =
by return.
For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is =
intrudoced from GFX11), only depends on reset_domain->sem; For Asics =3D GF=
X11, !adev->gfx.is_poweron might be false (which gfx might already poweron =
in the reset), this will make the if () not ture, return will not be execut=
ed, thus flush TLB.

>> And after merging code into one line may result in the lock not being re=
leased if the lock can be acquired success.
If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_rea=
d_trylock, thus could avoid this deadlock.

Thanks,
Feifei

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Sunday, October 8, 2023 9:36 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei X=
u
Sent: Sunday, October 8, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tl=
b after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ade=
v, uint32_t vmid,
                /*
                 * A GPU reset should flush all TLBs anyway, so no need to =
do
                 * this while one is ongoing.
+                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is=
 set.
                 */
-               if (!down_read_trylock(&adev->reset_domain->sem))
+               if (!down_read_trylock(&adev->reset_domain->sem) &&
+!adev->gfx.is_poweron)
                        return;

[Kevin]:
Based on your description, the above code should use "||" instead of "&&", =
And after merging code into one line may result in the lock not being relea=
sed if the lock can be acquired success.

Best Regards,
Kevin

                if (adev->gmc.flush_tlb_needs_extra_type_2)
--
2.34.1




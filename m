Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9405CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 02:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DD910EB90;
	Tue, 31 May 2022 02:35:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680FD10EC46
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 02:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOzKz+/dQg6kY67Hvj/djDXXzV+Bi/oObt+tGWbhQXRDyJA6cceb2np2DtD/TN9PisPb9VtvKc5q+FtcjGJc6obIj9TmFDqmKBtTNbuBX9lHjhlB0cJtTH63+h2blHrw72iWlVMW0FBr2G6jlyVlQDG9TbUr2RYWn+d7G9ElVdVvn2SLGJTdb4AM6jTroQrYYtrs8ZqQE3Eu1EfxXqzI9+lcu+HDjN1PhNeZo7sXDGrZLicscW/JQxOGqzFX93RswyebwYovJTm9UOtnJRk0I5T56JntBCbr0QbO9ADlpJRvdBOaTI0uo4GAr5MiR807rM44R4yLp7RBFW7uIi6bjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJBJqbkh63nkU1i1M+omVwFMWaAT3YJUJZ9HewaZ0wo=;
 b=c6ScNTClQqiFnRub+wLRGsSRhGyOTHPHwwc9HuNLaUe8r6bmYPkpw5pzolB4nUy2S9PjrGf/K+GY5m+R5lGZ30M3rKEz2Jhm2pA7DHvfIy4yqm9pyY1txJ06qmeXdluoQaMw0QDCl032PmiI8TgxgxqNLc2aJx+qhxm9XiWssM5cI+8btsF63vuz3os98pJE3lWK4XpoCELiukbUccgEN8qaaXQVt0IYL63jxtxlWxLOMCFPq5hnipoSI6zj5DZaTlAyacQjoLEeaHEINw06O8WfIC7YhQEvERrZ2A+u9nlTJ1Pu+Yii18vA+HiDY3jkBs/JVtDpCVzhvUuGTmhXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJBJqbkh63nkU1i1M+omVwFMWaAT3YJUJZ9HewaZ0wo=;
 b=lzZVbWg1kv027NACYKBpYeUwiy1eC+BedKIkQFfqBsnd8ae4HE7JSOh+f4ZEGesJQbtZRkh8nFX73I3Ovg7GYuDfDYwQklyxRKlX5tWDFfm7fvgpT72u7p5EiERqA64Bu/WQ0WgEvPMavtPXYIb8BlsSobV6wDrsWBHB/HOd1ts=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by BN6PR12MB1442.namprd12.prod.outlook.com (2603:10b6:405:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 02:35:40 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::f0ae:deec:2130:fa43]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::f0ae:deec:2130:fa43%8]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 02:35:40 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: =?iso-8859-1?Q?Ernst_Sj=F6strand?= <ernstp@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: enable tmz by default for skyrim
Thread-Topic: [PATCH] drm/amdgpu: enable tmz by default for skyrim
Thread-Index: AQHYdE+IDIiGZGK9UUuumzCYq2oZZa0327mAgABpYgA=
Date: Tue, 31 May 2022 02:35:40 +0000
Message-ID: <PH7PR12MB559625F63BA256A7C18494F993DC9@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20220530180233.2447918-1-sunil.khatri@amd.com>
 <CAD=4a=XJJYbsswfrBMpWi14gKJmE9DJzYAj-BJtH5A7totUtXA@mail.gmail.com>
In-Reply-To: <CAD=4a=XJJYbsswfrBMpWi14gKJmE9DJzYAj-BJtH5A7totUtXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ernstp@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-31T02:35:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=efd0e21d-a20e-4467-b509-c8937d666926;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30fb6791-a86b-4755-4613-08da42ae40e1
x-ms-traffictypediagnostic: BN6PR12MB1442:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1442D7B6B0B8B48907576C9793DC9@BN6PR12MB1442.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tiy9TMBr0pfHKkO1CQfPN/77WK4aKo5ax9z8iXz6HnTo6/23dwn3FL8Fh1xHsFUCvuL9fiYkMF2MM18y2xA4gbXyIvqIth24+jZIGWGbdJbJ3XbvUkwr1iNMWFJOgetYuMSfqEisRruEBKoPE0Slp6tl3TKukTyIrN41rOhxn4rC6JNYQgF+sXfBdvWPgjNLjcqPBt1VMwwcf6q9193K23yrD9OHIxUBLGlVHmzVXZq7Wkt6iU2F+QkTALTR1fpqkYSxoHYa6YokqAc3T2QmyCgyzPedTjfQDcY/wAqyfFLnFS1buFjpjiEjQlrHJhc58Uy5t3oo0VF0Mzx3Kp4GwoPpxeMijk2kcm7t2NxV93Ql+0SwZCMPU795gm/JwXxxEJWcJEbfB1QoI8XiA9nLJN1r4m9BJvuKo3lW29gVRp3RC70JMh0whsVtxUtjAC8ztKl/PBV2aUjInH2BZ29uWgnNx6M3piOuNkYxz0k/hkFViUHR/4lEThqYNhuFGzF4xN0brwTk84sfFWLQsMlu8DMUVGtKgdv37gF/qsKHUX8deGOJwng5axGyEkjlNfndgU/cuB6OFVk14JBw04Mf0ffWk2eteQ0W9OvK7JIZbmXRBnZXYp4vYp276YH9+ZlGHQtGJP45iMc4Ffk3cI7p+4xY6g2a68fFj1Ewtg1yz6/xbwxlAbzwWI54wt4Mw2auUPMm/RfxzH2kK+vZ+1Pbnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(508600001)(55236004)(53546011)(52536014)(186003)(2906002)(122000001)(33656002)(7696005)(8936002)(5660300002)(9686003)(38070700005)(26005)(38100700002)(6916009)(54906003)(55016003)(316002)(4326008)(66556008)(83380400001)(66476007)(66446008)(64756008)(71200400001)(66946007)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?khLVpD5inr3iLta0Sy0nV095a42tOSATx1qfyk6K1661DJzVw09EvQsBWf?=
 =?iso-8859-1?Q?D7KM0olS7yoGUCUIIVa6cbE4noWuYC4wGFxmLMdTgSqZYhAnKoPxrNoB1o?=
 =?iso-8859-1?Q?UiUg0Z464aA/Vmvl6/al8OBKnmRjvgpo9PNv7zndDQXZQCRfsIw4ZIQp78?=
 =?iso-8859-1?Q?4z8HLwLe+dHj5Jl3rkwnBL8lLxyrPreyLR13+yiRwfAir9R8+Ip6F+L/T8?=
 =?iso-8859-1?Q?A+nsBsfhubzsabWiCaSHxW2LK+HMXs6ZFHBybyQlh8vswGP1AElcyEGIgs?=
 =?iso-8859-1?Q?IlfLhVT/Dtz7xWoLVXklNxdnKCrJimEofqIsFd4YKf9GU4LVx553DAWOWB?=
 =?iso-8859-1?Q?mxnCHkBKauYIyeNydOzBr7xr/J/CxqyauzZMLclIvRyhrR2Z2aFbOULiWt?=
 =?iso-8859-1?Q?IhSmAYQnEtblxyuvt8qe2/phA5/iiMIljZEy3kQs4Jrd+87XMxQmrBucog?=
 =?iso-8859-1?Q?AUnWhHf1yHZCCiDZZUwSBGtFI3R0X6HR1Ddl0NBrW+45t6/KqLnGWI+SJX?=
 =?iso-8859-1?Q?5RG+jAfvRAKlUqgAAqkKpiXuv0oN3sv0w4LFc50JibA0X19hDAgwYjvaal?=
 =?iso-8859-1?Q?j1ddESZ3ZwcRphn2bMMiz3lAgu8QehqG88vv1JnIqPLvScAtS1yrqqNN/r?=
 =?iso-8859-1?Q?dcfhpfMtXwiuE2xsdVToxQg8ZHT2qEEUQ5R8ajOWuhhAamoGlM87NCbqq/?=
 =?iso-8859-1?Q?tuLjJEoDZJK+kUBAJm2Hu2uzb68u2bH5oikq9u4KAdVsuAc4EotrBVaSbZ?=
 =?iso-8859-1?Q?sx6LVwcjxoVfw6QDqkoE3nsi4BT0wS7Wybs/1ZbIElpkb0Ca39ld485ec8?=
 =?iso-8859-1?Q?jPTunJR8AMval5bZP0EbveA8tPH50Mv/aEeLZXSHEZHL+cAQUkzu4YyCtz?=
 =?iso-8859-1?Q?CXLYldNycyPv6CmcLwA34cCr5GvfQaqiLuMcxpr3BVz0m8E7LnS1tNRxCP?=
 =?iso-8859-1?Q?1XwxpEvcQ8yXmHqRIUcv1va8PM3AVL1A7EeARFRDDul0urQkYBT+6cfIL8?=
 =?iso-8859-1?Q?qh7cOLkLvlGzoThQEoE9f4p3z7qJkyy5nsukDLqeIzazQZgumKnIc4itcX?=
 =?iso-8859-1?Q?/RfnpGOB0b2DE8lACBWoqNpW6evw2XjzQqX6m0ESJ0zNYrMd0Kai1+HGBV?=
 =?iso-8859-1?Q?bmrKk19VfvlC272AGSq/mrI8cxZ1BPCxWx8uitVHhVsgDqXzVnlcZSGdyE?=
 =?iso-8859-1?Q?WJoTaZTo3s+uH0nOqOz7rhpFV5dpzPn/la3HFrlahO8M0KYO+He0lvtFh1?=
 =?iso-8859-1?Q?QnEs5M6kOKXLgrHewT7dE+ZPIpmBbh9vKoadm6qs2bcEIDSpTiIcOV4YFO?=
 =?iso-8859-1?Q?gMiYW/Y67w+8P4Wot03AmJGa7ApmDuK21Q/4dyMUhQ6tjkY9zZx3ZCH20Q?=
 =?iso-8859-1?Q?oYw8E36QZu3JjYhPBP4AWk1Q6hsrX4AjUxGbeECPKT8phFjXKI/W0BVJPw?=
 =?iso-8859-1?Q?FtAkPxnyKJqfAOLRGtWndeviRk6thbxmDnKj1HiPCZ7zsCsWS2M2A7IdC3?=
 =?iso-8859-1?Q?QEesjHRssiAB+J/UQ1hVOhAwWsz03lxbaWozE59+XRyWrTrPtaKZkMm5DL?=
 =?iso-8859-1?Q?vbUQknFcfb40mRWy9YVT2/R9h/k/5fO033OX4DChRdrPU5J2ABCapu6KKs?=
 =?iso-8859-1?Q?B9UWkvo9ypwy2M4sNP8+DkVAWc5X5bsNCgYxrar5zi3zLRxe4u7laHhP+N?=
 =?iso-8859-1?Q?YVbEcQvvtva7/5xqlxP2IQczKRUFLnrFB6cq5pQWW3gPNo2nfmGkblGuVD?=
 =?iso-8859-1?Q?FS1NbwLPWHnOi79yt1stnJ7vSCawQ+k8nSEkfoMlEuantp?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB559625F63BA256A7C18494F993DC9PH7PR12MB5596namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb6791-a86b-4755-4613-08da42ae40e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 02:35:40.6437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hslDAuCxDHvhqzof9jxTHiIgfqfAd14haNiC01HuD+9iVqxW0pWzQTjvcgPXIXP4JuTnTkMNa6VA6/8GxloEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB559625F63BA256A7C18494F993DC9PH7PR12MB5596namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

@Ernst Sj=F6strand<mailto:ernstp@gmail.com>
Make sense. Thanks for Review. Pushed another patch without any such names.

Regards
Sunil khatri

From: Ernst Sj=F6strand <ernstp@gmail.com>
Sent: Tuesday, May 31, 2022 1:47 AM
To: Khatri, Sunil <Sunil.Khatri@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx mailing list <a=
md-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable tmz by default for skyrim

Skyrim is maybe not the best code name ever for a GPU, perhaps not include =
it upstream if it's not official?

Regards
//Ernst

Den m=E5n 30 maj 2022 kl 20:03 skrev Sunil Khatri <sunil.khatri@amd.com<mai=
lto:sunil.khatri@amd.com>>:
Enable tmz feature by default for skyrim
i.e IP GC 10.3.7

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com<mailto:sunil.khatri@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 798c56214a23..aebc384531ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
        case IP_VERSION(9, 1, 0):
        /* RENOIR looks like RAVEN */
        case IP_VERSION(9, 3, 0):
+       /* GC 10.3.7 */
+       case IP_VERSION(10, 3, 7):
                if (amdgpu_tmz =3D=3D 0) {
                        adev->gmc.tmz_enabled =3D false;
                        dev_info(adev->dev,
@@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
        case IP_VERSION(10, 3, 1):
        /* YELLOW_CARP*/
        case IP_VERSION(10, 3, 3):
-       /* GC 10.3.7 */
-       case IP_VERSION(10, 3, 7):
                /* Don't enable it by default yet.
                 */
                if (amdgpu_tmz < 1) {
--
2.25.1

--_000_PH7PR12MB559625F63BA256A7C18494F993DC9PH7PR12MB5596namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a id=3D"OWAAM5717D7896CD04AA693881C0F9515EEA6" href=
=3D"mailto:ernstp@gmail.com"><span style=3D"font-family:&quot;Calibri&quot;=
,sans-serif;text-decoration:none">@Ernst Sj=F6strand</span></a><o:p></o:p><=
/p>
<p class=3D"MsoNormal">Make sense. Thanks for Review. Pushed another patch =
without any such names.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Sunil khatri <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Ernst Sj=F6strand &lt;ernstp@gmail.com&=
gt; <br>
<b>Sent:</b> Tuesday, May 31, 2022 1:47 AM<br>
<b>To:</b> Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx ma=
iling list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: enable tmz by default for skyrim<o:=
p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Skyrim is maybe not the best code name ever for a GPU, perhaps not inc=
lude it upstream if it's not official?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">Regards<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">//Ernst<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Den m=E5n 30 maj 2022 kl 20:03 skrev Sunil Khatri &l=
t;<a href=3D"mailto:sunil.khatri@amd.com">sunil.khatri@amd.com</a>&gt;:<o:p=
></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Enable tmz feature by=
 default for skyrim<br>
i.e IP GC 10.3.7<br>
<br>
Signed-off-by: Sunil Khatri &lt;<a href=3D"mailto:sunil.khatri@amd.com" tar=
get=3D"_blank">sunil.khatri@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 798c56214a23..aebc384531ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; case IP_VERSION(9, 1, 0):<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* RENOIR looks like RAVEN */<br>
&nbsp; &nbsp; &nbsp; &nbsp; case IP_VERSION(9, 3, 0):<br>
+&nbsp; &nbsp; &nbsp; &nbsp;/* GC 10.3.7 */<br>
+&nbsp; &nbsp; &nbsp; &nbsp;case IP_VERSION(10, 3, 7):<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (amdgpu_tmz =3D=
=3D 0) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; adev-&gt;gmc.tmz_enabled =3D false;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; dev_info(adev-&gt;dev,<br>
@@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; case IP_VERSION(10, 3, 1):<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* YELLOW_CARP*/<br>
&nbsp; &nbsp; &nbsp; &nbsp; case IP_VERSION(10, 3, 3):<br>
-&nbsp; &nbsp; &nbsp; &nbsp;/* GC 10.3.7 */<br>
-&nbsp; &nbsp; &nbsp; &nbsp;case IP_VERSION(10, 3, 7):<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Don't enable it =
by default yet.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (amdgpu_tmz &lt;=
 1) {<br>
-- <br>
2.25.1<o:p></o:p></p>
</blockquote>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB559625F63BA256A7C18494F993DC9PH7PR12MB5596namp_--

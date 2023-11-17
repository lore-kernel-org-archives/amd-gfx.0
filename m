Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5A7C54E76
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 01:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993FE10E2B7;
	Fri, 17 Nov 2023 01:36:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EED010E2B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 01:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnuLkrb753KKYG40UHfRot3+vbn/8kwZ4bLeGyWG2mO4fmnAb2nHkAsyYhF+IZc/F7kzQHx+J5fqVMwLXXtYgzFyCSXaK/B7MPmkTKasMGv+ceVb2CymKHAIPbmfoL9ZQeoBCtONokfVSu1iJSxWEfCRPt9s/vT/BdTc57LFEb3MbfpKTYS78xVQkChDOemcDKe8tIOAkAVWqeL00ndw10jrzq/ImvF9WpfXmBDTDCEimGVxM9OPOt0sVfXalG8axAM55UAMyHowwLCmaMvrMJmK8/6mA9MmsnBal2DTZNwiJWx+n6hRI66PZwra34gJGo+tRRk7DU/cRyBbi3p9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUi2HH+DCfw4OPDYZNqqH9ozVxsT635seapVkxlQfCw=;
 b=EpSaGrHKDOOld6ch/938XZq+syQGAlA1k2EbHQl1GDkCsGQjuJWBPDvq482LtrDVa73u3zbplLdvi7fIOZ0KlpuJa0RfHY9KcfT5UVPmP75KB64xNz5wt1sAL29QPqkivAr6zug+wriMMTEZ3IsBCothCSKGC1mJZDvX86NcLAlxo7sAw5SEI5RZ/HRizf6rIJ9eRml/WVfU+kekf/xLPS5GSVhRPSuIiHz/6uxGLI35EAvXoNdZqSaA/Qdhv8hysh+ajYUMwYZ8ub/Fd+5br5AIi48svSgaMAgOsGdX1zi+GgVhmm0hfywFgIASQgytWO5aEGcxuGJ6wRGoWzoitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUi2HH+DCfw4OPDYZNqqH9ozVxsT635seapVkxlQfCw=;
 b=fhb+h8oo1oYOTyydSX9CQ42HCJcHVny62e5/U0S6IILZuJZfE1bH4P9W5Y/84U+QMscO8UychtpEmw/jrzkclY0+5UiXC1zSIjwsFP2NWG/dhwQRUUWj2/9VjmZ5iMRD6YQRYWa1gKMJ0cc2MckIv58XTLc4j5qZ1aFFN4vTWJY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 01:36:46 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a294:a55c:ea32:7ba8%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 01:36:46 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Thread-Topic: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Thread-Index: AQHaFqQCkQnpOMDnQUOmrZOJy0YXnLB9v34A
Date: Fri, 17 Nov 2023 01:36:45 +0000
Message-ID: <DS7PR12MB60056B2D3B2562CFBC6DA98AFBB7A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20231114024043.1773120-1-Prike.Liang@amd.com>
In-Reply-To: <20231114024043.1773120-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66a07dce-7f10-4d2a-a7a2-3e045978f684;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-17T01:35:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6266:EE_
x-ms-office365-filtering-correlation-id: 7e744403-5099-4cf6-d9d7-08dbe70da909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzwJklW9iiu9qJoSDJDbKks95qZYjM2uix5bIfsPIdvUY+EhjGTKxFYDFlSD6bX47FjmqYh7mI1E6RwIWxjsJijA0UPh/asxECgYbsC1/EKCsvoLtVPwmnrYh0B80o5G9HJPjlv4bT4IE6DeJMAutOwuwo2PItiIblq5OL8kqMsOwF57kNw5aIutoiS9lpxdjk/k4I9iodorBc/aTl6ncQ3IVheOk1mMbkZao7RE60z1eDv58ITmVUQ0JRO5gLqxdqlPc7qc9yYuXeVGBUdZCbiu71VGb/IY1PTI9oAdsnGP/Hl5OrWwa46WwFufyH2W5ABE9FTLQFzxBKzE5vejP55lvWN6rKyQd5g7VjfpzKSNjL2o7IeJ0fknoyaYWfFRvGYWNWQu2xmysA3Eifr4LgMPWrXYQWadalL2gj8mUA9hI1ktfsMURbiEbEBKwzZnEJTFs7wHCHFRpnHmt44RrdDJEaIrFPGeGX+McA2TIm6tC8GQp6PvGxPZzcYLTJZrjOsDTVkUQEmuy1M0jBZZSlxEWy2r2Y04gZZk/wukBda4dCMx55GsdyRE6Tx6cQMdLhq4HzwH1O+EOB5j5Z6rJET072Rjx/dH7804h6lRH+T/jfZI5ktYlmARzU5Gm6rL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(5660300002)(41300700001)(38100700002)(122000001)(2906002)(55016003)(478600001)(9686003)(86362001)(26005)(316002)(6916009)(66556008)(66946007)(66446008)(66476007)(54906003)(64756008)(38070700009)(76116006)(6506007)(33656002)(7696005)(71200400001)(53546011)(8936002)(8676002)(83380400001)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a1svAM6bVbyfiQXWv50L2oSq+QnZe+/tdi06BCOv9Etsal/QNZNw4GvDHimP?=
 =?us-ascii?Q?uYk0xJiZhb0MCnXkFZ6bQGg4raqba9tatNt1d4VUSrEhqZaF9zoBzFbSSepK?=
 =?us-ascii?Q?dMUc/wm7YXQ1qQyxYZKMSYB7Nc4f+8Hdu1un4wkzfYweIG3N5sbJq7mXA/MF?=
 =?us-ascii?Q?sqIiTxC8xN29poG12x5KtdCut5xawHY7ustKFwUv7v+IuxIkzDN54Fe7/YIT?=
 =?us-ascii?Q?hL7HU+oCUnw43PigF5E+0T/WQ3HJdSw/R347lXW7RP5n7Q+f+Hry3obhwnjd?=
 =?us-ascii?Q?fJf0sI6UoZmQKLlI9DblkD7W/I6srZsDB628uZ1QQYoerQIKVo7Oa2yf3iLO?=
 =?us-ascii?Q?uNkMxd2MYXfN67WVs8MvsAHSCGTN4U+YMAcF8U4lwGs+GLWxNz2uNjw4LvkR?=
 =?us-ascii?Q?Ax+fWfrpv86iZuYGi5ZWj7W9Uy4GkdjwiG7LTHc8cGyOni2ObcYdh6WEyOSE?=
 =?us-ascii?Q?lX0VqKXzN3KOVlQxlFaFt+tSkD3evPqYHnhbJNRB5nYS8gvCmaRzrZKWNN9a?=
 =?us-ascii?Q?X8cE/kcb+5Pl/1XAipLAJ2YWAqRrbng0WLCdZuKcBW/IeWyhSe6cW+N6/etZ?=
 =?us-ascii?Q?LW215SA+dFoY4V7dgOkSesB+5CRJhbNVJK+aIyv7RBF1X51fh5btw9kyr0tf?=
 =?us-ascii?Q?CTLjE+tBEljJZd84JXwYsVF2X+1qGLIV7sgpsaypQppr6Z4OdEQ9YY4XhD2a?=
 =?us-ascii?Q?JA7vr5EWeut/mehOmATpzeY3h9ck/v10MCN8HRdZCf8UE3btSuPtJa91naNU?=
 =?us-ascii?Q?iLtkTmD1Rbai0LlfNyzOQmv2mruPJvnDJSSremAPPmnsOpNLU6lsXNoBDCpl?=
 =?us-ascii?Q?obj1I0YK/Oy5AynnRjVnx/0/K5DOEQ4+uUjS1bKfubCLYkc9BZhPHvcY8La1?=
 =?us-ascii?Q?+Sji57jdQ6yFAujnvz/4zvOqf+PbkkOhFMQi40lfTXWtuMzXFtZpMTycbwOS?=
 =?us-ascii?Q?LxVVp0DOJa2HHR14CyILdHfCc5yfhfs1GnzAHtoaU12optTaaHqomANrwOog?=
 =?us-ascii?Q?F5lIfxtVSgP2q8Mypru4PNDpYxAhjECpsyvlNsJHWcczEajisemw9p+BxG5Y?=
 =?us-ascii?Q?wJrz6fGOzggyo0qfW0VGMh/rJhGzYK7hP8303M36xeIxU72u/5v1eyGXAnZd?=
 =?us-ascii?Q?BIaUTaEoHG97v54CvvY7wyc3iOaiJTiaCCtA1mix0Zh57n6vrX8vgYCQ1okB?=
 =?us-ascii?Q?q1vzGUh3CmdujVvJSEYc9ImscG9JJjkQIk6Qp5N4ONbRyEX+38DrO1f6Yq8H?=
 =?us-ascii?Q?X6Wul8OxcOp9fMqS9YX8vf5MijPiSteaT4kr282r8xK++R1tRrZ8j8fDZHWU?=
 =?us-ascii?Q?kJnK9rPdVSsjJgA2XUDACB6KkbipOp+dGd1nmjXB1Fr7rqZoYmA+aEkFLVkS?=
 =?us-ascii?Q?FaM4mHxFglX/2yEwOW6ggQXFixaIq/4JkieOXAj2igyJo+3EGtM/CByHXBQP?=
 =?us-ascii?Q?PihuSC6VnnAJJ9MBeVVASx3rc+xYy2mRzLmuavI2/kMcQY6mMDnItw/GnJUD?=
 =?us-ascii?Q?43Et2YYnxr4W0Jt3i7vBUHPOeaRQXHARqNxLb/RRdxmmax1y4dgoRis8NgC+?=
 =?us-ascii?Q?km9CTOQCbgf0zDNb3k4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e744403-5099-4cf6-d9d7-08dbe70da909
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:36:45.9459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Pi/V3phDDHdP4Pp2/t43RfTEdRRg4jp+RK/9M9tAa1Qw1ojpoVN0ycXlM83ERbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping for the review.

Regards,
--Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 14, 2023 10:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference
> usage count
>
> Fix the amdgpu runpm dereference usage count.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 0cacd0b9f8be..4737ada467cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -340,12 +340,12 @@ int amdgpu_display_crtc_set_config(struct
> drm_mode_set *set,
>               adev->have_disp_power_ref =3D true;
>               return ret;
>       }
> -     /* if we have no active crtcs, then drop the power ref
> -      * we got before
> +     /* if we have no active crtcs, then go to
> +      * drop the power ref we got before
>        */
>       if (!active && adev->have_disp_power_ref) {
> -             pm_runtime_put_autosuspend(dev->dev);
>               adev->have_disp_power_ref =3D false;
> +             goto out;
>       }
>
>  out:
> --
> 2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789B9C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 05:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D216E10E890;
	Wed, 26 Apr 2023 05:56:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C1510E890
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 05:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NURi0tYVZyt4YMyYz6GaBWOslh5cnp91g4CPRZI2bDE6BNRwlkHmBLkmJ8q8ggr+WKqGDJ4ymsq/hbzgyHtL8g7rawfkqVBIvLE6rhElp/uZjPlNT+Hy3rysbcMV3l9xFJ709iNe/66RC70VdiW1qDlEy/y7aN4hNHNhgjC1iY+9+u1OfA+oy53XCBT3nt0eBFUsjblFVSX1+w/+J07nLbhPQKjxgqb+NX5bnUsOkt2X2SB23mKeErYieclw5aRtx/HeWMA1byrOYfBMyOgFRzbRqvdBkK6O8CBGZvrBxDNRnvUuXmxkIdThy23gW2+ZgZOlypG2WPHN1Gh2+IWTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWPO7b8vBL8jF335RkaCrxZ3qQ5Cv+eJs0yagEVlUo4=;
 b=l2XWqp/HKflVsJ9CDk1k4iQWvWCeR4ymTqrXQUfMNPZANAAVwtdMtEotM3tbKjkOSqZzG400rE/99+ELb9SD/BG4M5EQaRAmPry2/7dc12qse4oOfMlY5+8ayFOqxGnocN1ZFQzTFHnC0dV6uR/J9nHjQv7EleVt3c5qibwSoWc67KmuGpbwXCckUcWH541QewtegCdNkc9aurJgW8fCMJo5uzrk6/ZHxUpwX4RdgBhx/zueMarqha3W8In4rlQpBL/FPIzkw0h5l/BOYLUxxq+w6CDf17/MgCiIlp4CvuFo6V/L5imD8rDSHklxsrKmOaJaY1hLBJGRQXXDVmu9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWPO7b8vBL8jF335RkaCrxZ3qQ5Cv+eJs0yagEVlUo4=;
 b=5BI8kyspLiWKjej/lLb4TMjaB8ZWbzda52NhNYa63QD13BQso9mOF3MJVBw3XfOhCfFyhF8d0qh2sr2wdEBq3k0l2JCelHA/0grd3cE1rBLhcy3fKg0Iur2QI32Ihn87++wSG4NkVIGOH2Vl14XG82jWpJJmHk4dgsOnCT1g52Y=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 05:56:04 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::f381:5d55:55af:cff0]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::f381:5d55:55af:cff0%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 05:55:57 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a build warning by a typo in amdgpu_gfx.c
Thread-Topic: [PATCH] drm/amdgpu: fix a build warning by a typo in amdgpu_gfx.c
Thread-Index: AQHZd+zbLcwMAxjRm02HB2arv/sA+q89FneA
Date: Wed, 26 Apr 2023 05:55:57 +0000
Message-ID: <PH0PR12MB54047874C7E7D1E669DFE057F6659@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230426031130.147291-1-guchun.chen@amd.com>
In-Reply-To: <20230426031130.147291-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=40b25eca-fd94-47f7-9b29-4c9ef9152ce1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-26T05:51:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: 5081c70b-bb27-4c1b-f61b-08db461ae7e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuvvMB8Ovk4nRV5PrZqsgQ0sdxnyTJFKHbIlQDKpARE2IPldbs9XPUJnJ6pFAHb/Z7zx9I4Q6akSz16+LPT7OGQyB1i2zqz0UeyfuGf3sOHZ/RkRoFlqvawidLADcp8LlC/yy5MS6Cohp5nINPzFvMu/7gfkf9jcVk41d0/wWsP4hXwMadwigrqqfuzBcHarLFKLdh0l0sSUTJR8oir88w4SgTiYdYYf4OQGTASGxi2YxKNDvZOobUq2t9YNX5IWJCDA+af23hQMgAlMVeBPXwpj7BYqQgaXGR600LR9vsNACNMHinaASzl62ZwKFMCct+H0BUySFejTn3rxt65Ol0kUTVCRfXGwZo923lWw51P22ddBhuaelYrsXlpf+M+N0VgjJ/C7SqUBknQymaUNsQXnPPOiefhw5cnVyfHVciaEbIqUcCfZTMBd+XFTIbVwuC/8Nbqp0CbC3GBzCdbnoK1C8PQZIOW7OLTc/o3bg7a68szlhCJtSl3xOu34+dFLqs2pVOEwK1U84/iwjwCSkH7mAu0+vX6uvHwhkzLhVDIuQe2tLtpFOjd77eXalupAmFkNmpF6YjxXrQ7wbSk9zm8iIbRHwVVcNlj+j0YoQ2+v9ekVxEdFTQiO2QqbnOhF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(71200400001)(7696005)(55016003)(2906002)(6506007)(186003)(53546011)(4326008)(41300700001)(9686003)(8936002)(66476007)(66946007)(66556008)(26005)(64756008)(66446008)(76116006)(316002)(478600001)(5660300002)(110136005)(6636002)(8676002)(52536014)(38070700005)(122000001)(38100700002)(86362001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iaFjKlXhochvkhHoT7O799gGyo/cUtdeDe4rE+iuGH7WkxQ1ZTdynVZt6Vl6?=
 =?us-ascii?Q?EagS9EGv5VZXUAtuVPyOWDHCM3gyOFNtYjlz+CmbGqt8b4JmCmfeto+9mFWE?=
 =?us-ascii?Q?pHbSoHmvCL+FJZaYJboDaWmV8A7ZbUBRoHHN2uo3Cp6GNfzECqso2qZXDF7H?=
 =?us-ascii?Q?gZ8Jpk6d2CbS6BbDIX0VTHB6UQiAU/PMGB6nCRrQ73vOmU/V/WMoMwkNZsLP?=
 =?us-ascii?Q?X8UIZnDsibPH57Inf4C9eAqjRYTEl1V9FCKpvoD+wC2kqUczXoKCIkwtrgNg?=
 =?us-ascii?Q?fAmYUcfBj/BgP3hqBBY7rj5VUEuG8vsjBNbS+PaRGA6gdWGA2Kk40wdrnJqi?=
 =?us-ascii?Q?YzaYFUL+ouNS8YX019ObzpRym/3abwT5A9aLvwIBdyJ/E2SMKFlq++Z+bCOJ?=
 =?us-ascii?Q?SkWQUEFm/oWSCU/+QJzwVHQiXUBNil24gxVajftoPFzB2dzY8/SocdG2C44M?=
 =?us-ascii?Q?EVwcBcmafPsVUFO0Jv3mQer6jYwI0gU60jWZ3DL8iiaESUHcekppiBpkFQVL?=
 =?us-ascii?Q?6dHgM3gld1lalXbIa4XHgNCGbh9JCxSnueR+zIJVh3txdtHOsdtd1Hff31c2?=
 =?us-ascii?Q?KxZz3kEXVXZqlgpVfPUMqwWPLoNvfCMOqZkvGwW0pawaP6dM7Lm4DwTs31Yi?=
 =?us-ascii?Q?k9pBK5WImNVaoSSm5iH/FB2fgPrDEqMINRcHUZK3VaalzegltymGweNr8B7u?=
 =?us-ascii?Q?Ifmx7L+a+cpDeWjuJDs4Wc75OzY6o/VIbqKXxRu+BnDeUi2TmYt0wzoNtvNA?=
 =?us-ascii?Q?sYMlRKsnWm6Qin8rbf/H+KSpyQsKJxsTiJEKy1/75BWJfFJMtMUzvi/ZlSts?=
 =?us-ascii?Q?hme0ENAiSGf1Halg5f/HWHC8eBGHmNbHc605J/i2TgmqyCUKn6AMYZTkDthS?=
 =?us-ascii?Q?VcdjnFwNqpeoMml56A+l+ELFWspX8faVNqFnHVjTraWuZ298JXKINplD6zQh?=
 =?us-ascii?Q?/7Rt3kUxS9bqylNiOFw3v8XN3w8qujDhXxUPsZ5U1mEwplfo7MEHx1TfnFxw?=
 =?us-ascii?Q?vpndA05AMiXEz8N8FyqQsfgknFfqaO58C7OG9A8XboYuvcf7EfIpqLYWK1yQ?=
 =?us-ascii?Q?sVLhIQSEi+x8UiJcrHFoQSVdlsvhC45cvYyCatJ2KvlkcyhHUIo7L7L0OCFK?=
 =?us-ascii?Q?CNNgZqGd+RpMY52vYmM0YiXbmomZF8Q9bDj0j3Q7D67qrk2PdGsAA2kdS7aG?=
 =?us-ascii?Q?dqZ+HNZd43BmM7ZVGNbmwVV0gCNiu6QUii6QJ+GaUoKZCyPXEjvb8e9dfpHI?=
 =?us-ascii?Q?N9LX9egHJ9sx/oTu5SCz3Jo3kKtS3PIclDW1+7O8N31P9LiF7Mqz74NgZYSD?=
 =?us-ascii?Q?hLO1wTrj9d32L5mxIYb6BcXs7rsat/HYhsebVvKRJcAQPay+KCxoL8Go2kBV?=
 =?us-ascii?Q?SVYtj6/Lrt2WoU9iUF7ufTM+u/eKpM7tIaXS0/sJJRnJycKy44WTozko/mdr?=
 =?us-ascii?Q?RNc1fkl3oCJ8lnw0ers5gvKdjGOCxS6iUb+46WUiQmS4z8P/f8Z8UXhsz0+t?=
 =?us-ascii?Q?K1VT6FlQixv+4yAytsi9LQySZKPvg90gaulowceAr45KjPXrGki13pb4gW8d?=
 =?us-ascii?Q?+DZ/h8VxULIqnL17j6Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5081c70b-bb27-4c1b-f61b-08db461ae7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 05:55:57.6504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMeVx8BcGONTXFsR1ppxrZjkcVkfUhplPyqzZp/xUr4c0Aph0Blr5Qx6KHhZy+S2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, April 26, 2023 11:12 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Ma, Le <Le.Ma@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: fix a build warning by a typo in amdgpu_gfx.=
c
>
> This should be a typo when intruducing multi-xx support.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Cc: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 60bb4bba1994..2cf1f88fde48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -470,8 +470,8 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device
> *adev, int xcc_id)
>
>       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>               j =3D i + xcc_id * adev->gfx.num_compute_rings;
> -             ring =3D &adev->gfx.compute_ring[i];
> -             kfree(adev->gfx.mec.mqd_backup[i]);
> +             ring =3D &adev->gfx.compute_ring[j];
> +             kfree(adev->gfx.mec.mqd_backup[j]);
>               amdgpu_bo_free_kernel(&ring->mqd_obj,
>                                     &ring->mqd_gpu_addr,
>                                     &ring->mqd_ptr);
> --
> 2.25.1


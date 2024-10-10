Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B9CCF11FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 15:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2D910E966;
	Thu, 10 Oct 2024 15:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LRjJHPA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9C010E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 15:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxWpz0FhTciWmf/0LUGFaGRp4dmW+wsimeVJn7IFBIcMEkJfdQlhtJxHUFIYtvlWK0y6rdATYrprGCzOMS6LYbW2kID0aTxlLYA1QFpnq8hSawx1iqFxZ0PGJsy7oY6G5PsXtkSpfey85W1pkV2Kim5MCPDQvTwkv2dGdaE81Sp1DWwcL1wGHxuxjpiOUd3OvfjYwc1CFc2TaY5ZOAzNoOA2yc0Wd5UaCMZEHk5kSNDGOAJ8W9a4J/NgJ361GJcvYoiZ7i1jzPMGklUIBAGce2yXzXFb+aV+jYoauPic+N2dCHS3Ya/tuXVD10I5r0rH7OiF9F3diOcg9TUMxDsnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBpQ2cns7BsOj97pNyvw15h273OW+2vKC5H7h7w+mOE=;
 b=LIHb2KenOA66c8YtbG51X956U3PcirfGO0ItWG0vQf6ut7xw+WJAe5lNG/UVf4EreW4Ec5H998VpYdpPQWfr/k+DY78m7Pf7nDrWiuR9cQ2owBQ7wW61kwt24Zrxf7NyuLx79LkNFLGmekXRg3/rnFCk05mWno8WF0eOxhSstl+XDWxMTCm4AxLJps8fsRIo99+yL5moxtpIYcqK/Iyx7jyfTNOmWX8U/8ER7XovLGZeyHfUQj5Q7WfXdNfvfkLDyAtfe9LGtNkOQIDCY01c7krajpAtr1czvTw/wlbgsQFOukcf6JrGN2APzzqN02GFE65RP+Qvw6QpjphlLFLAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBpQ2cns7BsOj97pNyvw15h273OW+2vKC5H7h7w+mOE=;
 b=0LRjJHPAtM5NCEXIXblTpGmGtq5x1PV143LBGKW+zAgkWgVPY4j1HWEAvK+F4Bl4pVifNdAAKP+/U18x6Ra97e+ejaXZFezQxhZ0cBkCO4UdM+skF6HP5IPo9C1BD0hAlJyQu2Obeoh+PCTamMok8OsxcfLgpDAOQeaBo0pW6hs=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:48:40 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:48:40 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chains
Thread-Topic: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chains
Thread-Index: AQHbGye1iHr2xrpFDkCXqVNgV2ImObKAIJyAgAAAq1A=
Date: Thu, 10 Oct 2024 15:48:40 +0000
Message-ID: <SA1PR12MB859984274CF97B7B1C31DD1EED782@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <BL3PR12MB6425669037C5111A3F8D641BEE782@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB6425669037C5111A3F8D641BEE782@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=39c41c37-e9e6-4675-b9c7-1eabbc20653d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-10T15:33:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|BL4PR12MB9508:EE_
x-ms-office365-filtering-correlation-id: 802a02ab-5e86-4f11-9b14-08dce9430301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bebF584Ld2Z3z9eO3luSs6q/XVGNnnj9HavpHcp1RCO2h66OkFq8QARZiSrj?=
 =?us-ascii?Q?5xfo2E7GKcekfmojU6deVNvWEORWpC8NmDUgUp0Hhku8IPzENVNFkvWsoZda?=
 =?us-ascii?Q?ktuZcfdj8b8yc/RUkUV4bq3nkNuHxDBzZyCOPm5FsCcx+8PWYD2ybSh2bblA?=
 =?us-ascii?Q?Ua79yBCm8ev7DsBPNwT781W45NAxinrXx+Aef6AxNQWMH+4+CzVHNmOLAIi1?=
 =?us-ascii?Q?9o2ZsIkBKRzOgNQSqM7xNrHJaSRhZoNY982Aob8j520/vczDYTQxOBUdQeO9?=
 =?us-ascii?Q?mXOANluv2/Y0V3sgF9sRXWfc7344tHlxYBVt/prY8kzmuqNlS0ShXbjRlQBm?=
 =?us-ascii?Q?Gcnw42s8Li8oc7tNKQhpFhl5Uv6AqdNSO+gb4CBW11ZmPKPPebv/7yP3LR2R?=
 =?us-ascii?Q?8WGeZaGmyxXegPR8cpOMX1FutGsmrnTv0lHJSgcE8mtn762EBZtYG5qEJk6W?=
 =?us-ascii?Q?I6FcPyoB0RSAWQfs7C8q1NKWVj0y/z1AcQV8SmNfRkkeg15/YtgNuCKNID1I?=
 =?us-ascii?Q?QPamCoduSY23Cu+TdI75jFGAgtwHk6ximFxYlBXWjSo5LbJ0N7AqVKHjpuT+?=
 =?us-ascii?Q?s8ouIxdDGPvdLCdyo/ziraJkd+TyFpFKfJ8BLMlDQGr+2NC+tXGW38q32OF9?=
 =?us-ascii?Q?Ija4mAkd94o7MjsEa1Y4o1JHkSupj1YmJLv93fTfpuErjZ9TpY8SzHYE46C+?=
 =?us-ascii?Q?iRJX3G8jcThHJgsxWnIdhy00T8QYHXaq3o3QaaJ9NZqifK1ne0VUI63tRsU0?=
 =?us-ascii?Q?rBRlsyz4i6MqCseRs2P7V4ZGHJFC24PzaOaGnPMWw7TDZx81tNCl34Xc3pCA?=
 =?us-ascii?Q?6l+bcYoQLfGyhfbaTguw9hDxwkQYnZXOFhOpaMQXAjrzWM4wL5+O9giYWsB6?=
 =?us-ascii?Q?NUmKZq4ujUmE2LQiggwlkp0hXjqN1+A1Xyqhv4JBQ1qFXN0CagwEylca6ivs?=
 =?us-ascii?Q?548sKYS2FvtxM9qD0JBShPHjBseM1ql5Glx3qNYfQrVhzV+GBpXjBcRFDSAY?=
 =?us-ascii?Q?GSgmuKjVNrc9KHxsInzU7kZ59GjTzylwtY+4dZBKSlDuP0TOMiy69vSjCKLr?=
 =?us-ascii?Q?fKS4dJdpfRZ6ZA/u6gqSZFchG3gSQ4RUbELSQ9YYf2r/niIJ8YTZh37OyR/A?=
 =?us-ascii?Q?T/gabClj8pUsv2OYmQrwW53NnPSaKwsF6ZDJtf7LMDRV8HA1aqt/9nslwEMA?=
 =?us-ascii?Q?Ivxq94nyl8BHKvB6VKz9M5/ti9XFsFPFd7UdjW4DZB4kjy7Z8MIC6+GWQ/hq?=
 =?us-ascii?Q?sjvzhgMaAjn5gmnNmRmE2GAjrMKCGCF6n0WN5HdD8auJCvoIpSC0YDNYHydG?=
 =?us-ascii?Q?mk08K9dEad9KmWAuhL9BFE2kXflmvqgmhH1Isjehr/0bKw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kiu1KPRcKZGfCnAdM8gxIVbpTyLyu8VkuWAb5UeTpu1QT4XSL7SH0BY7Pmyn?=
 =?us-ascii?Q?JHcR05jb37eivopVjPdsZZiVjkzf03HtVGxxqT3V3pX3sehdTwcDPOUMy2dx?=
 =?us-ascii?Q?RW4hx7U8XYBs566YBYLYcCxuaJ2yM3SWS0biHnw8pvrAKYrA0vwA4u7S4cAf?=
 =?us-ascii?Q?bLU6lGxR0tGpqHofC8hjeD/iDC7ekwPLWTywTfcFgZlgjLCVFg3azUCB5Ji5?=
 =?us-ascii?Q?BVRnlyHHY45B1QsuTCumG9SsXcqjD/5WHU9wKJTHGz5B8t6vc1rNFQg/toQp?=
 =?us-ascii?Q?AFwOn6Fz5A+/iIj0t9yFTfeJO5u17A09Y7B3uJjqyIztRtFG+aAUQW8pp6jm?=
 =?us-ascii?Q?JlCX1RoqlTiq3nnCalHmwsropHwdzAztUnLhoKX29occSJY1k1HSaGKcji01?=
 =?us-ascii?Q?pczl8trXI+OnnsE1P8pF6wFpGAJxEwTzJalW1PLBWQGUvmPREzDJjSLXOJ3r?=
 =?us-ascii?Q?zA4RXoB1YIKSLORYlbbJcX/F71s81qeBVZLmphlazKHmdXbjQ6uNz9uSwMn5?=
 =?us-ascii?Q?/O8Pnel7iniCEFvJs0KfrFbpnAYJjkKwlfDE3W1duhxG5j1POQQ2BH9uQhJM?=
 =?us-ascii?Q?lhXtFK2NgbAMHLaZR2ZPLsoznhbjmjhKq1pKKkzLh76gS6Zt1v2N0CZgcBYo?=
 =?us-ascii?Q?G9lenWYGrbF75Wh5JRsiPZuQdyT9KqUHSQ3OA5zGg/ytGueDshcf930/xnY1?=
 =?us-ascii?Q?sN/csd3WvJJb6QCi56tuaXiufzop3CGMqT7JG/c+jMg2F5AS5m0ecIhTwzG0?=
 =?us-ascii?Q?Y7lhl+4CUuBFTBGHjPEQZuv+6rULqj6dcUCZ5eNZSR4OHf201P+Dk/epM5Cl?=
 =?us-ascii?Q?5DngVKl3WqutwZyPBLT8MDsYth2L3auj3+dTd5ePUHVjBCxmB4FUm97KWkAP?=
 =?us-ascii?Q?IMNfK+r51wmuwtwG0LYFT3Jc2GMycDYkNAXgJwNLUAbWnpZf7Tk+BEldJLY0?=
 =?us-ascii?Q?y7GsRL7ORctKUhzbWcN62JIUqP0yWtbQj4gkNRO3aMrt1wbfU1m/JBDj8ByC?=
 =?us-ascii?Q?M0tNHx8FbVfekhr3J9nGQEd8HIhtAMDLLN0rQVB6TQw6tN1E7+QSzOxrQShF?=
 =?us-ascii?Q?wqLGR2uPHd3jkXO4pSFLA6IB0OIDkcXggXYmEFN8MM7uRvRkw64oaX6cR1b8?=
 =?us-ascii?Q?RQGD/nU/1N+kbvhrYdyQDj0YffnpGVmQTSyaB2pwbMcJ0DF9Ew812wW3Qhzl?=
 =?us-ascii?Q?XYL318r1eHF8cFOSo43pF2nVZ4cwD+dWmwexj1L6bwEvlW3NggWqWXZan2rn?=
 =?us-ascii?Q?IaxPR08F6izbkh9PmBoRRppSAbFAB2ii/07xUrHUVDZ+h8cnKPM5Anvp+85E?=
 =?us-ascii?Q?KdWlTsnToMSq+EyoxXfpqQBC7S05sGSwwZ8QSSsDye0+wPtg8G0ZR4nBpAKx?=
 =?us-ascii?Q?QwW5ni0sgLGPn1KngohH8d8gckg4olQCjIV29VwmIshtBU8DxLdob4jv1Z+I?=
 =?us-ascii?Q?QJwP1AeJW8S4SEISagggxswde8YALht+zKVttIdw/6oJ1qb4PcF3O6iGAPcx?=
 =?us-ascii?Q?ewbWSxnbMZtvVLBuzEpE1bhNVUJPPpTjrX+kti/ea6nKKMaFd8jX3++gx1gT?=
 =?us-ascii?Q?czKN6LppFx3P/wN2SAM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802a02ab-5e86-4f11-9b14-08dce9430301
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:48:40.1999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUnolTBvh3iAVUoRw+S37crL48qGUudtmu0CPYCasqpDivW4u/b0+R90jr6GgNUKpn+jyoUrcH/q+XAf+kT5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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

[AMD Official Use Only - AMD Internal Distribution Only]

Oops, lemme fix that real quick...

> -----Original Message-----
> From: Joshi, Mukul <Mukul.Joshi@amd.com>
> Sent: Thursday, October 10, 2024 11:46
> To: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; amd-gfx@lists.freedesktop=
.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
> (Teddy) <Yunxiang.Li@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference c=
hains
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Yunxiang Li
> > Sent: Thursday, October 10, 2024 11:19 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
> > (Teddy) <Yunxiang.Li@amd.com>
> > Subject: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference
> > chains
> >
> > Pull out some duplicated dereference chains into variables, and in
> > some cases grab struct device pointer directly from amdgpu_device inste=
ad of via
> drm_device.
> >
> > Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32
> > +++++++++++++-----------
> >  1 file changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index d665ecdcd12fc..c334432e55b14 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1051,6 +1051,7 @@ static void kfd_process_destroy_pdds(struct
> > kfd_process *p)
> >
> >       for (i =3D 0; i < p->n_pdds; i++) {
> >               struct kfd_process_device *pdd =3D p->pdds[i];
> > +             struct amdgpu_device *adev =3D pdd->dev->adev;
> >
> >               pr_debug("Releasing pdd (topology id %d) for process
> > (pasid 0x%x)\n",
> >                               pdd->dev->id, p->pasid); @@ -1059,8
> > +1060,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
> >               kfd_process_device_destroy_ib_mem(pdd);
> >
> >               if (pdd->drm_file) {
> > -                     amdgpu_amdkfd_gpuvm_release_process_vm(
> > -                                     pdd->dev->adev, pdd->drm_priv);
> > +                     amdgpu_amdkfd_gpuvm_release_process_vm(adev,
> > +
> > + pdd->drm_priv);
> >                       fput(pdd->drm_file);
> >               }
> >
> > @@ -1073,15 +1074,14 @@ static void kfd_process_destroy_pdds(struct
> > kfd_process *p)
> >               kfd_free_process_doorbells(pdd->dev->kfd, pdd);
> >
> >               if (pdd->dev->kfd->shared_resources.enable_mes)
> > -                     amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> > -                                                &pdd->proc_ctx_bo);
> > +                     amdgpu_amdkfd_free_gtt_mem(adev,
> > + &pdd->proc_ctx_bo);
> >               /*
> >                * before destroying pdd, make sure to report availabilit=
y
> >                * for auto suspend
> >                */
> >               if (pdd->runtime_inuse) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(pdd->dev-
> > >adev)->dev);
> > -                     pm_runtime_put_autosuspend(adev_to_drm(pdd->dev-
> > >adev)->dev);
> > +                     pm_runtime_mark_last_busy(adev->dev);
> > +                     pm_runtime_put_autosuspend(adev->dev);
> >                       pdd->runtime_inuse =3D false;
> >               }
> >
> > @@ -1606,6 +1606,8 @@ struct kfd_process_device
> > *kfd_create_process_device_data(struct kfd_node *dev,
> >                                                       struct
> > kfd_process *p)  {
> >       struct kfd_process_device *pdd =3D NULL;
> > +     struct amdgpu_device *adev =3D dev->adev;
> > +     struct device *bdev =3D adev->dev;
> >       int retval =3D 0;
> >
> >       if (WARN_ON_ONCE(p->n_pdds >=3D MAX_GPU_INSTANCE)) @@ -
> > 1631,14 +1633,17 @@ struct kfd_process_device
> > *kfd_create_process_device_data(struct kfd_node *dev,
> >       atomic64_set(&pdd->evict_duration_counter, 0);
> >
> >       if (dev->kfd->shared_resources.enable_mes) {
> > -             retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
> > +             retval =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
> >                                               AMDGPU_MES_PROC_CTX_SIZE,
> >                                               &pdd->proc_ctx_bo,
> >                                               &pdd->proc_ctx_gpu_addr,
> >                                               &pdd->proc_ctx_cpu_ptr,
> >                                               false);
> > +             retval =3D amdgpu_amdkfd_alloc_gtt_mem(
> > +                     adev, AMDGPU_MES_PROC_CTX_SIZE, &pdd-
> > >proc_ctx_bo,
> > +                     &pdd->proc_ctx_gpu_addr, &pdd->proc_ctx_cpu_ptr,
> > + false);
>
> Looks like you are duplicating the amdgpu_amdkfd_alloc_gtt_mem call here.
>
> Regards,
> Mukul
>
> >               if (retval) {
> > -                     dev_err(dev->adev->dev,
> > +                     dev_err(bdev,
> >                               "failed to allocate process context bo\n"=
);
> >                       goto err_free_pdd;
> >               }
> > @@ -1647,10 +1652,8 @@ struct kfd_process_device
> > *kfd_create_process_device_data(struct kfd_node *dev,
> >
> >       p->pdds[p->n_pdds++] =3D pdd;
> >       if (kfd_dbg_is_per_vmid_supported(pdd->dev))
> > -             pdd->spi_dbg_override =3D pdd->dev->kfd2kgd->disable_debu=
g_trap(
> > -                                                     pdd->dev->adev,
> > -                                                     false,
> > -                                                     0);
> > +             pdd->spi_dbg_override =3D
> > +                     pdd->dev->kfd2kgd->disable_debug_trap(adev,
> > + false, 0);
> >
> >       /* Init idr used for memory handle translation */
> >       idr_init(&pdd->alloc_idr);
> > @@ -1750,11 +1753,12 @@ struct kfd_process_device
> > *kfd_bind_process_to_device(struct kfd_node *dev,
> >                                                       struct
> > kfd_process *p)  {
> >       struct kfd_process_device *pdd;
> > +     struct device *bdev =3D dev->adev->dev;
> >       int err;
> >
> >       pdd =3D kfd_get_process_device_data(dev, p);
> >       if (!pdd) {
> > -             dev_err(dev->adev->dev, "Process device data doesn't exis=
t\n");
> > +             dev_err(bdev, "Process device data doesn't exist\n");
> >               return ERR_PTR(-ENOMEM);
> >       }
> >
> > @@ -1767,7 +1771,7 @@ struct kfd_process_device
> > *kfd_bind_process_to_device(struct kfd_node *dev,
> >        * pdd is destroyed.
> >        */
> >       if (!pdd->runtime_inuse) {
> > -             err =3D pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
> > +             err =3D pm_runtime_get_sync(bdev);
> >               if (err < 0) {
> >
> > pm_runtime_put_autosuspend(adev_to_drm(dev->adev)-
> > >dev);
> >                       return ERR_PTR(err);
> > --
> > 2.34.1
>


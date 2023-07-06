Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FDEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAE110E413;
	Thu,  6 Jul 2023 14:31:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5CD10E413
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flzcXISaRHgSX6B6+nIXPbMQntbF6fgFThtrQcIGW9VC4av7oCka3+FZAI2Jfu8PP4D6nFO0nrGCYJEPtgOz4YicMZ/jJ7NPeNWr6W6Yqa3LAcJQDi9kOi4frAMJ5gH7AqPcggdR8Dz6Q1jf03vh+Rhl5bL2wfZoVj1DoeO1ud6fAJs526MIG83M2w4W3Wv8J/qx3KROjB1TFf+PbOH4gYbMkfBEnrC85Rrjs2GtbpRGhYIX48aeJcC00jihjhsyxoBixosL6CUp2i6ADJP0QtZRucyPGOU6mBArr+LQVy0zCshfqmNzdbt6fOLaE4YsITvUkOvkT4BmJNwBugQLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1Vdmurx9PC/JGTF4I6VtiDALEER+7agrCpIaCG6gHo=;
 b=nHnbTXfF8UOWAFQa5/3YX7lIJ16aPWHzDeZcWgnpT2SFkjXz5FMzROgnPRe6zNPU3O64qePpztN8mogrLByxPztbCOhV8R6o9WtJf25bal8sw+X8BWUoNuWgJ1wFd8ybaFNamB/LEzk8qVPAVCXr+Pk5gT7sS6ZcnHxkjOMSfbC3xll0QT8abl4D5qxeFym2Av5CEMmuCxQzTM/Iw9NzxUoVhndCPMY0I5XoXad6ksw+tVVT4DCasmq9sXa7/3DG16Apmw9sQnXc6lPICSX9rFBdh/Dn9e9t04Vq4kothQLb4MiqDvnhwVyQXJW+3QwOeIXvdHBcwfZSjRTuydUbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1Vdmurx9PC/JGTF4I6VtiDALEER+7agrCpIaCG6gHo=;
 b=W6TZIxLF4JRme4yzqL6kaL5D7LvNCJvKXLp4uJ0MfBT06fXMH1bqZxWU6CnBDmmogQ9TMtt3KOciYNQsqV8L8OVfIe0UETAyQq2sDvm+bhLr2iBVqvKauIlW1HIXWue6AYYWactiG7EAnh4EuuV4WPt4pxp9L2Weh6tH441OhSA=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:31:11 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:31:11 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Topic: [PATCH 5/5] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Index: AQHZr5RKJ/33t5T64USo2V7lIRSZ9K+szNjQ
Date: Thu, 6 Jul 2023 14:31:11 +0000
Message-ID: <CY8PR12MB7435A2346B3A52AEF05C93A8852CA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
 <20230705225655.299335-6-jinhuieric.huang@amd.com>
In-Reply-To: <20230705225655.299335-6-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=94221249-fc16-40b2-8bc2-719db86b7811;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-06T14:30:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA0PR12MB7651:EE_
x-ms-office365-filtering-correlation-id: 3b6769bc-4dca-445a-8fd0-08db7e2da52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0sOKuWgTTH7R+iak86yukhHQj1suZpSWRUAghbq8G7nB+71H2iuFJWHZpLqYz1WLX80u+wl3B4xlZK9wvWEtw7f5fXpo5UA0AwinYNSxaBp61yHdFMGODcWLCz8twG8SmfEaycQZ/XkzlfM4ffnIhs8/l9nOwSDWMtFPjmTHkX+RfkYzh93MmuerGogJ/ACR20Kumwohv2L17E8dPwzGwbEhlHvZiobtACQAsQI7SuC0PGLvNVJRurWocEkd7s724dpBftnX7VZGjGWjnhYP3n4EddtgbwTLh/EV9yOXavAR1+m323qU5ex07NdvxroAYcnVQRGATcxxTyhgTPK6n3KeHhbmj6cuxciiSV4SrRfopWqQjsVWydUeG+s1bsibPxpDreeaKnf4gOlGDJ/DTcN3gxAJOdaQPycAYYAR6NWwCgmiaKfm21rsfvna6dZxL+4KkVDdq5MIHfFxrzV68E/4HM62SNMY7Q5oaX5Xapk09ly9iNwWPO0X02A6Dm9Yl1FKa5neqUeOzgDDvp+HYFZ/SxmtVAMLTSatALzn4Ayglp7OwiHb80f9AosvG6z5+kdtJqeA3wpz5VcqS4WgBYfTjrCzz4JZithxZeYO94w2K2WGiVWWy0OqdY77axp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(478600001)(71200400001)(7696005)(76116006)(110136005)(9686003)(6506007)(53546011)(186003)(66946007)(2906002)(41300700001)(66446008)(64756008)(316002)(66476007)(66556008)(4326008)(52536014)(8676002)(5660300002)(8936002)(122000001)(38100700002)(33656002)(86362001)(38070700005)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VKqVwDgTPxVnUDr1BcItUXLrE2ZHBSEQaFMNQcMrWCqx1sYRdoIpE+jE3evT?=
 =?us-ascii?Q?chmvdtyju8yxCaRgwt0cR+pNdEvn8H+dEJTW40tSnnZuo0RVFlObiPDt/m43?=
 =?us-ascii?Q?CGMfk3T1uzSilbWilXHpfqOOcOTGma1uQizE71z2KtIH7EcOeiX4Ak6blpQu?=
 =?us-ascii?Q?TbmApcIjX+J8RGhPUmGwezpUx1QjY8dXUPwmTbvPiSwojTXhx49Pyz6C53tT?=
 =?us-ascii?Q?kKYjhPSJkkjXe6Mm4BzraEJN9y1Kh9ipNx3hCCVvJ+A5C7DD1DmqOBvj7dZ6?=
 =?us-ascii?Q?BHY9Oq5IBoPMSG8G1ETIvBGFrMIxUuovHwdo/pT8804OM6yFCoADR5Ub1yn7?=
 =?us-ascii?Q?lCYQsSYumcp/P8XmXNbimU7sH5x0RmqvO1ggToiv7s+qYg2iMJ4EwZu01XYT?=
 =?us-ascii?Q?Ff+J1eQRgpa/n1WyFeuanwL02AuuwONzmo59n3q5cdZkomDnN0mqMIlr9jMM?=
 =?us-ascii?Q?0HJKfIzkUiEw7d3G8dsSc8yS1mzDfF5kwehT/1BUHmHAVaRMPpbIbjHTx4N+?=
 =?us-ascii?Q?td/kPtKpYdEct2t90letknlrxCrgmx4Ez0d33019/+B9seyaBcyB7FnaqYE4?=
 =?us-ascii?Q?CLHaxLYE1Muaf+ZYI7KXwEmXfOSkTPG8KLmdglBm9oKipRG/WpJ8JPVZyJ3W?=
 =?us-ascii?Q?tmoXQse6mpdGaeOwrDeO+p8jC+qEFMigrbSlOi0XvpO8otF2ggrXl/AH5NwG?=
 =?us-ascii?Q?7ziWcK+0f8ZMOSM8jZ1d0NBloHkJkNFM6TeL4GdqJ5Fpygk0W9JbAOmkYyFd?=
 =?us-ascii?Q?MZw6Rt1fu3t/fmOokqU4hHl9p00fbC2TCe0rKGktcbOJOYlcPOgik86pXM86?=
 =?us-ascii?Q?UBahovhvAf2klWlTw2KNVh8eiOBP9CNxC/PtX2YGvvZZnKfX4aXyRaTw7dT2?=
 =?us-ascii?Q?5K7W4M1AEK89V+nbEXyKR2hl0EPpyv+grdni9wZeCDhEEqAZfACRAVjNvuPy?=
 =?us-ascii?Q?y3JOT5LkDrRQZirab3k0b2tXvNwfwNxCJQGnjOkaa/RDA3fHebZwqThyU4ba?=
 =?us-ascii?Q?nGxO0cAJz6g7mZUEPUosO6kVaqPnbpxISKa67vohKUhADN5IkUzovFnXYGUr?=
 =?us-ascii?Q?cPey2WR2zp0JBFqpKDjmiUBJwdHGfbTmo3WqjBUum2DALHox4Ru9pNC+IN8H?=
 =?us-ascii?Q?yeWeCsga5Vot9Ml54yYWaqhDW22wi/OyXQfflldOfPkEA840MlP7RyNHmy3R?=
 =?us-ascii?Q?mPSYfL+fr6Uw1KgU0KgKZIA6rQN7mYa2fROQoBgJIULbenBCw1MF9YpU6MeU?=
 =?us-ascii?Q?84UqGET6ixnl5ydWbi4S83DJ4OnnF3tdBO/dOw95h2nfakNYJ+Nuppdf3gus?=
 =?us-ascii?Q?HdOJM2jx2IifXlp3XQvJ9VjPlOSwocoldwuEf1130dINzNVnIeM/zGBjT7dX?=
 =?us-ascii?Q?nA+2ZgAoZggVkpy8T1IVljvCkr4rcyRRhCSc2zSdiiCjKP+rTdoZx34iF7c9?=
 =?us-ascii?Q?xNMceZ9dOfkeH9/UdggcYBoC+mFdqBgDhYT932VaUpc//hABq0UM38v5WTw9?=
 =?us-ascii?Q?+NwLTxH8Zo6wJVWUr4Rd5wYBYSLL7fGDHF1vs0/P619pX4AFmC64Vu8xWLZo?=
 =?us-ascii?Q?gTR5LvdVt8PiBvhFgn9goN055FVcHYBNobzfz4Ups/FL/UgJlKi9fekDozrQ?=
 =?us-ascii?Q?56eYSxeqPBDsVfIJoEwYG7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6769bc-4dca-445a-8fd0-08db7e2da52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:31:11.2574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTgjR+dTdSVeDIcXmAhRUTTkH4/A2QqpNDXMIKiiTtjICHxqF3TC9KANjdfWCFmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

As mentioned before, if we're going to set up the trap temporaries, we may =
as well enable them persistently now that GC 9.4.3 should not have a perfor=
mance penalty on TTMP setup i.e. we can keep_trap_enabled any time we disab=
le_debug_trap.

Thanks,

Jon

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, July 5, 2023 6:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 5/5] drm/amdkfd: add multi-process debugging support for
> GC v9.4.3
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
> MAP_PROCESS packet to support multi-process debugging.  Update the
> mutli-process debug support list so that the KFD updates the runlist
> on debug mode setting and that it allocates enough GTT memory during
> KFD device initialization.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index a289e59ceb79..a0afc6a7b6c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct
> kfd_process *p,
>
>  static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
>  {
> -     return KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> -            KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0);
> +     return (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> +             KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +             KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0));
>  }
>
>  void debug_event_write_work_handler(struct work_struct *work);
> --
> 2.34.1


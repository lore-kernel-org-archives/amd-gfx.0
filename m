Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E8C369A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 06:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D75610E5C6;
	Tue,  8 Apr 2025 06:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nj2qra6a";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764A710E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 06:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg735biBKUUufHJ4wJNdwgyA8X5T8cX4Q6v/u7DpNU7od3Uo02O+CI/cZFRmB+aAojZvH9/wDIxnzRYYQrEnPZWwS6vChu72c8vC7LDWhdhwBgf/G5zmuKLwpKwOYGbhUn02oDIpklTbUX9JhaDhcLLWYM0Jrj875NEzkNOYv38sQWoct01bu54YxpCSJovPypUyIoH6/a0EUt/YMEdmjEnotJUWVLiK29aPbdJHPahkX/c+g9pgdWps2am3Sqo16TUiuX7iqqc3x62d5WLaS/X+uAE5B39uGyszeMSwLcV9tMETusT6+IyZ0x6hZlZC1GNSllS/MSFe0TeLog/Bew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhr89NYl+zuhavTxFVZ9NPUgBFT7fcWOxkLVN1AD5rU=;
 b=nED830lmdvzktY/32hkTTZiuyvP01zIdY9KeYlLYHhx6Q1KYnVyCQ8AZo2ygros4bAa2SlDwW9Wx6bhT0EoGAQnXLviHUlbsSKSpcA8JPcmGYMltnaAsV3DLQnmZIqsBX3msexG0kqa515+B9unnikInnvpVtSMZnzwv4AuppRtXxtSGomb9xqwOyV9NHwCJhkGNDB52zRem//eDuV6N3yrkKNK7xblaAqVK0fRz539BVcO8Ywo4FZtP+hChtxxNY8pzoGDbUoDjzFUUhQc+cDJJMAkw9UMrkP8SEg+A0Td9+3wYm+1MiYht+XdltgoLrTwN50gkNze+IBopeMhTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhr89NYl+zuhavTxFVZ9NPUgBFT7fcWOxkLVN1AD5rU=;
 b=nj2qra6aI0x1l9ZXJEZZ4bCtFuTHy08oEEumFxkWpnVNkRcMIOMRTgdsu8WvyukmGi1XDdxiOpwLYP1gNRffJnVCzJVdx7iefg7MIhrrn57I/u12s+B1JQrk6Po7y8FOpqRTqirZQ5W2LxjxHS87iFYnUUC1f6MWdGw33e2Kxns=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:09:50 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:09:50 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v1] drm/amdgpu: no need to set queue_active in
 mes_userq_resume
Thread-Topic: [PATCH v1] drm/amdgpu: no need to set queue_active in
 mes_userq_resume
Thread-Index: AQHbo8kZ0ah1u1Hb2EqQg9V07H0ghrOXvKyAgAFN14CAAEdTUA==
Date: Tue, 8 Apr 2025 06:09:49 +0000
Message-ID: <BL1PR12MB57533819F373C38AA0D72EC593B52@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250402121636.1689678-1-sunil.khatri@amd.com>
 <bb9f822d-722c-45f1-8432-d21c129c8a8f@amd.com>
 <DS7PR12MB6005D6D1B970ADED76027711FBB52@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005D6D1B970ADED76027711FBB52@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bc912af8-8a01-4fc9-9df0-cdeb9a713258;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T01:50:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|LV2PR12MB5990:EE_
x-ms-office365-filtering-correlation-id: 426b1a32-182f-4555-0813-08dd7663f894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XRxzN0WLtoovU7LZ6lxAM6XYBEd+phKcZkcZrrzDZkOeJ4CbfBx0xsjgFE5q?=
 =?us-ascii?Q?InAPUwfgRBstLJcS7Qu0mlloxAbb6Z/xrT23KoQ4u20tXoaDHdBfXrxq58jQ?=
 =?us-ascii?Q?S3UWwk1dyXJf8u8hLuxn+simwaPZ2ALx784G1Rf6v+vtx71RK69BomKPMEZ2?=
 =?us-ascii?Q?0SkeY1v6WTR4vnglp+2gZqsdRqLbeaqY3krTfwDC88GJvUKbBIyN1HOntY/E?=
 =?us-ascii?Q?MD+BFgvJwZcigzI4yBxjpt7HsHiotHHFJEtIu/J4EYq+kqA4ml1sRMwTs1FQ?=
 =?us-ascii?Q?J0FZWb+qY6IygnJw/Wx6JOVww63vYSQmtss5ZgrMFgZF6XJj95V61tfXf0W0?=
 =?us-ascii?Q?g+jhUsFYHwBE0nKH1/CnK5QaErJSTY+WtJ3i6dYTFaZgUAEhmbwOLwBqtpDT?=
 =?us-ascii?Q?8xXqZtWhPi7PACXUZcsALgonWemXzLtt5AorYilW6fNxtU9VyWUw5pDJUkpF?=
 =?us-ascii?Q?hSxl3Sbu/w0rxQ/5RXBnNRfzAj71FqpmBEZHavMLQ0r5gvNhfYh8fdRRkLo/?=
 =?us-ascii?Q?APBet3TQlgHCYukdnakwryCQPTMvVmH6ZJvURxZf/vwMnMhhw4hNLkM+9dri?=
 =?us-ascii?Q?kpCz9duRSVYP8p3Oe7MJKJ03OX8uHXRaMGeVcDTZoM3tuHgg2WJsoaRjwwby?=
 =?us-ascii?Q?5SVVF7kEYxlKJrlqfS8qblhpCQ8gVtPGgB+Tupxi/tiwqnX+9q9RFCjRpFUX?=
 =?us-ascii?Q?KH7a+CGqagsjwWEG+3AhM+UPl9zwUexa5HvFBO2Tw/UdVFHJGMtcyrWGnA9C?=
 =?us-ascii?Q?THsIq7CK5c9y7tpt9iaGUwQN2FnkrC+Z2bU1wB3b6adAbbxErApm0r3BKTM7?=
 =?us-ascii?Q?plkQ0BS8CDLjHhFE57AMZLYsimubE0xq9Rj7OKzS4ucwqVuwlMJtYNhGBK3s?=
 =?us-ascii?Q?DHxJ5rfzmLTFBxsdJf1EuEFEZzHnvkKFppZD6hXozBo6WU7KDXalU0chyiuR?=
 =?us-ascii?Q?JHxySNI0SRCuFWJGQnQ0yg6FO9F//q4bSH6KtjufqkELlHlC9HmjrfDc7HHU?=
 =?us-ascii?Q?6hv6GOupPjI/Rg59alK4Ge5umpjsXZjC/fiG8JalOCA9EQktTpUlaCziz8yy?=
 =?us-ascii?Q?2Gg4RSzSHdVN56dF0OXBtnJuxIwgcObm0DwkbV0NoKb0qd8zFF7viRvFUmro?=
 =?us-ascii?Q?y7uevPClEslHisCmTWwi4FSbg5JqJ+bWpV5SaaX4E9ii8dZM0Qmq0WcsGwUX?=
 =?us-ascii?Q?22ShAZhSn9jmVl5Fn0aAEyIlZF0HOhYsxJC/rBFIvHgDTUZ3+5cX8YYxY0V7?=
 =?us-ascii?Q?wwSMF0eQ9SBrkA/Zzrmj+RKXMpbhk1snvExOkJMM+TUS1FXFf5XskVOgaiPE?=
 =?us-ascii?Q?CQy0k4aCkzzGNGX8nqjA7bqzUGGNI5l76yAsfC0/41bVRCJqbbL9djy7ie8m?=
 =?us-ascii?Q?S7OpGRRH4AirmddCLawvdhMtKZgNZTHy9XuRcP+N63L3ckv0ymq2lRw+vxaA?=
 =?us-ascii?Q?EtYMyVaNP/gV9cpgCdojPk2R2CzC6k6y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LEwJDco/KjvX+BdIAUaPRSot85RIM4gTfhm3FT1fKdLMahs8d/GUL81R2EB5?=
 =?us-ascii?Q?zwfeRH7NlOuAfwNvr8PyK0bUsaDcBCNPeyz+t/Sg0916anCpkhkDEJAyU02d?=
 =?us-ascii?Q?/P9tqwOX2H+EgslToUcxbjhvc1mQmvA9JnXYE4CHWNWleRQJa1p16Mhw/ua0?=
 =?us-ascii?Q?RxSWfPKzAcf+G5HdFKOfOpJelaSiUXQRC4mBdoGS2fWPdrOmXEM+sgDnirgX?=
 =?us-ascii?Q?cOAbUeAVUG7V8nrsK9twzssx9rhcNjFI+q5Y6u/bkTNzMsV2kRNDxvwiE7EX?=
 =?us-ascii?Q?BHB6QoYMVClI/IA3N+yIqrxHtELpw35neUOkxpejaRI2VKnFde7rABl6PEfc?=
 =?us-ascii?Q?92XFtp6qgDJqnAv4HuQUPL5mX/XNkx2hEw4tDtmGzh0iQKF9d4wDuXlBef/j?=
 =?us-ascii?Q?asdVRNLgORUm70cU4YdIc2E1Xrx3AjBcWfCyt9vR11uYFyelAnqAfoXp9bua?=
 =?us-ascii?Q?iXprkqrrNBfl0CAbHF+O+TbAy6MtjhgC3AKq2glLMENRpgvF3DTcZugMYMeE?=
 =?us-ascii?Q?ejJNa6GnyUmTuZnvKnu1YbUR/AUR9V8JrPd4ywekgsJRRdU7GF27AIa78PP/?=
 =?us-ascii?Q?DWrJDU+RpFBpOzHLXkUYteic/vX/wuMKug53rLQFB+LxzIvIkvz/LwMsbq+r?=
 =?us-ascii?Q?BDAsU8EdgN1jRwbOfmRl8TFEbuhpikmMJdf5oD56JAuWerMozZuO0Xpe4YLO?=
 =?us-ascii?Q?S9T88T+e9uVfTGq1LhczJQJX9imrBP43ULasU1lSWQGPhMVhYUTT+HAidmGZ?=
 =?us-ascii?Q?mBrv1BS7BBDirCfSA6SNv6hrZjFhUNUyOu4/zvhssheoS6IsqEoU1vmNRfcY?=
 =?us-ascii?Q?jCVsBiFX7Q9bW/w3f7KILH2myaZjeo4PJhAVkuVRUy9h1blbefIgsba0Ud4r?=
 =?us-ascii?Q?NNf7Y1Ebl4XnAc5asnHfzyapZycG95CHsHxBB/YHJHm4s4FdJ5B5T+hmr6Oy?=
 =?us-ascii?Q?Iuea0hw96O02+waWnduW5nhIQ10waEn/PSqF9TqeTpy2gm0PHoC0ALZTbBkm?=
 =?us-ascii?Q?82CIUq0v5UrHTxXghfr3hdsHcTVGWGn8nxJVmG9REnTnolZRv6eM5XAa2vbf?=
 =?us-ascii?Q?le5j6fMGaiWucIYuZO979wjhcaeTNNWQnQ5KsGDEG3fhdY+v2MwQVL1mxZPg?=
 =?us-ascii?Q?NQjwhYE3uQr35MdE5SE8aVstiopo7q7iYYRMq1dhnddzA3UWZtL3vi9RVJlM?=
 =?us-ascii?Q?ep4nrYP3cd+IKLeq43LAmVP67DEPdBPUmJdI6Lp4WiGRXmGLoZ624NnQ6XaJ?=
 =?us-ascii?Q?AR5O2ss1/gh86eeaB08DYHfo09aiOL742KxRqR3WaUPJyCw2ScU73WoJECbk?=
 =?us-ascii?Q?/QHWSO+o3fkG067jF4GdufB5WjA+cd5fUSHzkh+mZ8PiSf9OZ7ptBH9PeE80?=
 =?us-ascii?Q?MknhMJAnfAX+XH5uBUnb2adaI8J4ODF3B6Gi6jCNmBe1H266/sOKMNULj5x3?=
 =?us-ascii?Q?ZWGBf/ZPFSpSRpo6BsgyTVP27yQafyAPnIiwR+idz1IIitoP9cz9VwaMnSzd?=
 =?us-ascii?Q?mv2wk6v2aEo66QHAdBnqJ4ukRNNrapuFfX3E5BTEsTI4JBdzlwyHFghq281U?=
 =?us-ascii?Q?hVCjMnTbygkrxUApIfs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426b1a32-182f-4555-0813-08dd7663f894
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 06:09:50.0601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQeoOcPSlOoD4HgZrvXU5CWfFFurzTPqGKB/Vhr1UwAdMXTbqjtQjetRj3MSAZr6JQzvT7+Qlm8KV8VFtdkCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

I see that you have pushed that before me so please goahead and get it revi=
ewed and merged. I have another change pending which i am waiting for Alex =
to have a look.

Regards
Sunil

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, April 8, 2025 7:24 AM
To: Khatri, Sunil <Sunil.Khatri@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.c=
om>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH v1] drm/amdgpu: no need to set queue_active in mes_user=
q_resume

[AMD Official Use Only - AMD Internal Distribution Only]

I had a similar patch before, the mes_userq_mqd_destroy() also need to clea=
n up the duplicated queue active bit setting.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Khatri, Sunil
> Sent: Monday, April 7, 2025 1:59 PM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH v1] drm/amdgpu: no need to set queue_active in
> mes_userq_resume
>
> Ping
>
> On 4/2/2025 5:46 PM, Sunil Khatri wrote:
> > In mes_userq_resume calls mes_userq_map which set the queue_active
> > state to true if it succeed and from the resume we dont need to
> > explicitly set the queue state.
> >
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index 8f6c12a78f3a..c596e534efbf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -382,7 +382,6 @@ static int mes_userq_resume(struct
> amdgpu_userq_mgr *uq_mgr,
> >             return ret;
> >     }
> >
> > -   queue->queue_active =3D true;
> >     return 0;
> >   }
> >


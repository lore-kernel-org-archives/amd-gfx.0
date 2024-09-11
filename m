Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85403EE57DB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 21:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61E210EAAA;
	Wed, 11 Sep 2024 21:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODkVPpV1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92FB10EAAA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 21:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiSIrnsjt+4MQlizWVAH2UpOESXfR6bU0cT8ra1lmGCSeJEV6m1mZEEFfTVBfFqbtSzEVkNAJwXBoV5BtwbbqAfyjcsw/iXpakBHjJdl+wYFzHqOmr1mgoW5D4a9cLeD6gtUDHqbXK0VfrL2V65sNsn1MwV+3h3UzL+BbfhC2hkTRVYf7QKIkiSR/hxJFlIXuZSg91uNKlVTKr1GXs9fAD0ozGqwUivqAKVqrWZNLmMv0bI5SALqWPxK9lno1EyW5ZgtkaXlpc4CW9J3XKNQfr5Z9FTJ2zTeN+2zcG3LUqy4cKqeT5oSTQwQnsXfcD7P0hV3gJSHtUGD9ycgimU7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDhTPsOaJYrFMv7LKSsDMfUFP14V8sLoEYqdrwe2q+8=;
 b=WJ65RINX96iGrDmF0ZxEGP+2vO4JCJ9i9llvg4aeybI0bEZ0FfOAcHG9OThjDk7pKtkvSaUa8Rn2PGNMKB+jXlPtglqzTSd8mkoGqTT/aai7I+ZEX9edcHg/FGo56X1dmCQFwRPULhg74aZ0YhH0p82qSPtILOsyTvDCsTxY17LZuqsak0UjbaUGEqgJMtct4ckN01TGdEWEz35hOk3K71AKPvoV4nPyXsJ5TEzKgDBpxrgkhiy6303HzWBmr+hC0GaBxD4mQy9CGxIpWvzIOREaleXT8C9Qf9r5oe6kkaM5K38k5FAxBeVreniPlTB6TOqnlAL7+rAXcoDsbxNWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDhTPsOaJYrFMv7LKSsDMfUFP14V8sLoEYqdrwe2q+8=;
 b=ODkVPpV1YSw22SZbBxugJGdyWJu1F99FE+PMqtj7ITe+qUq2iSI9TN5xjkv4Zf3BZP5HJSDXd4dRInhNk2KUC4OX8NLIP7l5DHrScUT8ptsUlM/30dUmFPRdYZuN6DStAkFk/pYpbVB5o9RRfDvGUkKsjAbY1bPdsGAux4zv6Io=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 21:12:57 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.7962.017; Wed, 11 Sep 2024
 21:12:57 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on
 SMU13.0.6
Thread-Topic: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on
 SMU13.0.6
Thread-Index: AQHbBHVecM0XuxqG90273xj61y/ffrJTFb4w
Date: Wed, 11 Sep 2024 21:12:57 +0000
Message-ID: <BL1PR12MB5898A1F8EC72E916C63958B2859B2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240911180545.519385-1-kent.russell@amd.com>
In-Reply-To: <20240911180545.519385-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6a0855cd-da60-41f8-bca5-32883534e3e6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-11T21:12:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB8275:EE_
x-ms-office365-filtering-correlation-id: 68f67d93-4c74-465f-ef60-08dcd2a6825e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KTHyUphgGetbIR6/C6hUYXqupHk2t7UdwAM5Fy0qtgwUvIH4A4Jg6WK9cxJx?=
 =?us-ascii?Q?Zz1fGpBtZ2R9qGl5qH5+EbRQwBjI3+m/0oDlm225PbnwLkE3oMRN5a7U32Pt?=
 =?us-ascii?Q?kENKj/wkmjMFXYNCh+XSNoe+brmgJYohgIzR8tenYAdy9WXujc+YTS1D+HE9?=
 =?us-ascii?Q?NM9NwUnG/Uev5M/w1O9jnaXN1tCGkvzlAXQB6LsNrET82w4YqQgCVC/HXQGo?=
 =?us-ascii?Q?7EWnXCNwUvBp291m5avoOtx0/AoHRZzmtwVzNjykbQxlskr9OHoOSJFq9iqY?=
 =?us-ascii?Q?i6hKY2nAqT8fYVl4uSFOYXkZ2rzTjHrUhkNBG/lD1swFOmqMsWBSiXkxBgnj?=
 =?us-ascii?Q?H2YMklT0S8B8ygUI8J1k0zo4vZSWdeShnKV5s9+W7/HhE1hbmi5cqbG+bbuk?=
 =?us-ascii?Q?3R7M1WQQ2GcS1t/L08gQm5MuuyStaTpHWE5RyOdVSUBSIWreoyNaGqt7JkZA?=
 =?us-ascii?Q?JnDYrxiomsuQBV00rRZWvBuQvEPz9PKdTPzJC7XH4eLs8tpCi5RuWfktaJxY?=
 =?us-ascii?Q?95QXiS0edwYWmvlAovRRIkj5WFC+QB8PGig9KZB0HjG6UfSSRLG4/CutiQaL?=
 =?us-ascii?Q?EnX9MZ30kG6TeVW6c/dPwjIvi3WcZOi9JShQyc0HNVWV//KC1JJ0bXlO5VTi?=
 =?us-ascii?Q?oy0tfvjkBVV3uqLajkwp4vcAo3U7GGHMNNgFuy2DH18SzSmr/SEAlVXwLJXy?=
 =?us-ascii?Q?6GrVJlxAunbIUesEGJ8bvphIao03CizebFmN+UMJpoDQEJp5B7Tr6B6zHR3O?=
 =?us-ascii?Q?LXBPnrfSuulPLX8Q/7vfKh2khF58F8B6JithJaKeczPdQuWPQJ/lJaERThaa?=
 =?us-ascii?Q?fb/nvREgrnbSnPH279I3AM7FR8iGi31SY3xAo/lRX5r8OvSG1NAtHDm5x+N1?=
 =?us-ascii?Q?fjT5vJYyrb0iFURPGKB1yxnJZPVWhRn9kmSOkjsEFD1uTlDkoIb4AywrNRAJ?=
 =?us-ascii?Q?/aH4HVXsQDuc6HHCEXTfBxdntIVkU3dEDlHs5rMPOMzDpCrYTdJeC9NHAfAT?=
 =?us-ascii?Q?kh7ctgkFFs87sQjdip8pqTJ71Fprmhb1UT0OiE7HWEhpV9P1ITx+nUActnW7?=
 =?us-ascii?Q?VK9M6q7Jw1cn5UtuHYfKPK5fnf6ZZAKwjWq6qcdZ6nLEW6ZDxYX6S5oPeFwN?=
 =?us-ascii?Q?CLKExJ6ZXGwfHC+lVmPHsOzT0Gd1CM8SMXV8olgdf5X0MgYpKe23pPY6akq4?=
 =?us-ascii?Q?cZ4fX1WA1v/4ZEDC91V8NcN70yxoRZP+hYlnr3Dm5XaGZIIrzK/K1xAddJAu?=
 =?us-ascii?Q?0FlOD+M4QEzL7uHG35sVqZ3myecyree7q9EPG7i1mQRaeJSmW16neY28WNQ8?=
 =?us-ascii?Q?sfNIwHraaXTD8Om4ozneWJNfUrLfnSZ/Oa9u8zyPuF9f9cTHL5MJxe2y5Wqi?=
 =?us-ascii?Q?C+on9JJmRxAHP4OyvHfFYAIDcJ/96OI277fSRVc7V+i/haX4/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ToIa1wkiZKmMnuJeTYLCdSEzxcx9fWa8Gjvg/QgQEgBKnAiCY/DxB20p9Urq?=
 =?us-ascii?Q?4baxkoHM39nJKPfKgSxbNTfn5fx2atKmWZol7anZ6tBejQ2/BErH3KAly6UX?=
 =?us-ascii?Q?Thqxhf8T7Xx+jV2pmm2QreXJB5OIpvwelY5m1wx6Deb/yNyzeYiLVoitXI+L?=
 =?us-ascii?Q?6eM7x+0QUhr2qnizlDo56mlC+L8/C5TdoZEfZJ81B8jY34xGa0pMYz9FazaJ?=
 =?us-ascii?Q?hLLHkYtKchZUq1sh+KmhV99uosnns0lry9bcEiVpWX92pVy3Xh4wwAuVa2sQ?=
 =?us-ascii?Q?XlCW2qRVEHOwLofeCgRwlBLEZELI3LQYC6+N5kQWC0fcZe8PF9Pwjq04lLeN?=
 =?us-ascii?Q?TsW7Ns+mQLpXeh2/M6IWUG2UYkKSglcaTKzlBmWztL1RANTHcuuc5avdGtIN?=
 =?us-ascii?Q?q2QBY9gSv9CfpAdlsmYCb5Ppv9pLte9dWlsD3y3or0q4HQD7F1268Z8GbafC?=
 =?us-ascii?Q?1gZO3Q0DWeCq1D8kEd7btWGuFtY9sY7DPsL8spdaDldAFOw10PPQ71iJ+luS?=
 =?us-ascii?Q?zzNj3yaijfUFXYfYdOoaQym9r6u/16AiOPAPPgcoinzNFPdqSJ/liHCD67+/?=
 =?us-ascii?Q?EN1KsMYdGXzx649qstgdIOpTXFnQYgi3wE3HVD+rjyKrV71zkOZmBCmtxADt?=
 =?us-ascii?Q?nwLIC7oQpfuh3NFxNUHJMaiX4VN7m07Et/OhYRzvb1ipHnGt7Z0Zw+u0nauE?=
 =?us-ascii?Q?UWgQ3LB0g6uugA5tVODSAOjWIH/vrlQti8BvJSHFhJHm2gDoVTZE+zjRUrp/?=
 =?us-ascii?Q?0u3bOhMpSUK122/DK/OClU4RkDgUjMQMB3l2ifY3zmElx3rI0VxZ7Iy3adA1?=
 =?us-ascii?Q?4/KRgGvAn81MdF4BuQM5RYDBPOTlFzyABLt0DfHRVMtzOEH9sQfBcu43Tu5E?=
 =?us-ascii?Q?HtI+1wh5InQLEmnvIHma2H03pEM/sRXx4JYAybGNpOXRxgIM1y3Ba5zDnjtZ?=
 =?us-ascii?Q?PqqmUCr765bSPFtCxKDBen67y3F3r3CzkBUuFj6QtbWC6SEZA7RMTMumM12e?=
 =?us-ascii?Q?FfmNxdXDolbf7tFTKJDJ6MnsBKde35g5HEJZB827ORE59F0kRmmFfIeoqPyT?=
 =?us-ascii?Q?JXvFjrO3smuZIb9EIbFWj9hSSe9/v1OagoBxCL3fR5b5APFWwkAtE8iEEijD?=
 =?us-ascii?Q?tJYHAgi3zkkiyibDUOTEtslYovWRnATqe2v7+1TlN8NymzWYhtqCf78kAVEQ?=
 =?us-ascii?Q?CAFIwLgu/b0+Xa3qHP6d9VgcOEwN2Z8XCCKW3Jl2nMPfdCVa8lNYUGqTBqzI?=
 =?us-ascii?Q?OH0ONnZDy+Z4avGCQEVMZA0eYMQQCvW+IiGr7gJWX7BBWe0IonEmf8cXZFKK?=
 =?us-ascii?Q?0P18SqDE+G4gBzpq9d2Ieca4N6//M2R/LGhRuNIaHOjwQPO+5CsolyXcVY0E?=
 =?us-ascii?Q?nTVv+F1JUQP2ERQ/g6Isx6RGhAbRlF8pIrtpbPoML5XZFxbeW/J66J76T2hl?=
 =?us-ascii?Q?0XKHlxryk/+aPat4dQv7D5JGCn1CVOpNxt7rI/YAlIBQjyZSYXZRazXQZzrx?=
 =?us-ascii?Q?2ix7cDgDvlCck8YpLGUmyNJOpHBoz/JofpMmyEg44E+gA51F49KspI7w/qLO?=
 =?us-ascii?Q?N/Edpurcju/kpWK2XLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f67d93-4c74-465f-ef60-08dcd2a6825e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 21:12:57.2803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQ9syBpsZqhOy8Y4bW4ngHBD75RVphqCUzcHoJaWNFIIIWZh/nxrY/BJmg6IdtnI2jUuN+HoYH9DQNtd3wbv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

Fixed the typo locally.

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Wednesday, September 11, 2024 2:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on SMU13=
.0.6
>
> During init, there can be some collisions on the i2c bus that result in
> the EEPROM read failing. This has been mitigated in the PMFW to a
> degree, but there is still a small chance that the bus will be busy.
> When the read fails during RAS init, that disables page retirement
> altogether, which is obviously not ideal. To try to avoid that
> situation, set the eeprom_read function to retry once if the first read
> fails, specifically for smu_v13_0_6.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9974c9f8135e..65d24c2f7e24 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2107,8 +2107,12 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter
> *i2c_adap,
>       }
>       mutex_lock(&adev->pm.mutex);
>       r =3D smu_v13_0_6_request_i2c_xfer(smu, req);
> -     if (r)
> -             goto fail;
> +     if (r) {
> +             /* Rrtry once, in case of an i2c collision */
Rrtry->Retry
> +             r =3D smu_v13_0_6_request_i2c_xfer(smu, req);
> +             if (r)
> +                     goto fail;
> +     }
>
>       for (c =3D i =3D 0; i < num_msgs; i++) {
>               if (!(msg[i].flags & I2C_M_RD)) {
> --
> 2.34.1


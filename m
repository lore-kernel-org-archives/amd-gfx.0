Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A4EC54F52
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 02:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A2C10E434;
	Wed, 29 Jul 2026 02:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3J5VZdp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A054C10E434
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 02:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am5dCMq5rgbxyNF7HCCPILn7h/63wmVfR3+Y6Vsc2OdFE9CRIjZYZzRFFM46ElZYZMzu6e+vjlsT8PtTSAtqs6tZy/kuibSj/6ejpv/JfTGSfOhbhiCDuR9TL/Z4Bex9vYl1n6uIB7t/s1zo1TrXkv5VOIaPN0OGtN9qzV3jqjiQkAQ6nkB3DLV5NbMrSyAMsB5sRJ3SAfyGubM4VcQCBukJkEoZ0RasYHNGgr0tn/uRROsd0vUSSTHtTEJm/+IuO0XcIy11hJavvEMhzD/D6yk/72SaPZ4wTvMk0obXSPjp+Ws9JcA2mnc+DcY5aOOVfdDI04Vb+flEdFi84KnvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z4AKhKXBmr98w7D+vsTuHLtuHjswv2sRrdAz5gAEi8=;
 b=kW03NlBd14t0mb03y1q854lAJBPnv/P8L15U1fbtP8vt0Ob8QmnF5L4zfEVAZYrOMxK+yAbPyzGnK3NCoy6WYn3exQ268Ks7gz3frnTF4BXD6NkFg+O/6EpNeMhRyEdG4SqI6rsb+ODN5+mUjwBwh0Mm6dt+K0IfdzkflsyS4fmtV/9s3az4OSyFAzS8kHPKRVd/Rk96gtyv6w8CBdktrRqowNHIRpknqib6bnci95aYEOXlQUkECPCG347K3C/3YJ/yEE9N6o+gCgiAmTxEVEYmA0zPb3YTDymufOTcaF2B+2GC2zDJdWi3i263dn4AgumIodipw0Pi50KMqITSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z4AKhKXBmr98w7D+vsTuHLtuHjswv2sRrdAz5gAEi8=;
 b=q3J5VZdpnx4xyrFhYLIjWIaXtj0o3ezfKF+INK1nE98wCjjdAGM4MJMQ9ZcxVS49mxlQJylfsfk0LqvIyyHfebduKJUi83oTCzSNpToKzhkRuUzjcoZZJjJ8/ZZ/Lk9gV3R8F9PQkidFmHpjyEvtNVFgbuaD81Vw3ZRJgGcOO5o=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 02:19:45 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 02:19:42 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: track faulted gfx user-queue slots
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: track faulted gfx user-queue slots
Thread-Index: AQHdGYlBBk6O4PVV8k+rbudLxFM1nLaDzkpA
Date: Wed, 29 Jul 2026 02:19:42 +0000
Message-ID: <DM4PR12MB5152EF228007696C9C769B7CE3CA2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T02:19:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6402:EE_
x-ms-office365-filtering-correlation-id: 0f595965-cd18-4c50-22f5-08deed17d999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: p69LfXsoR3jP/m2VGnNo9Uwnrbrk9w1fAmsrT0YVhx8cvfpiVBYSM46bH+Aq1GrfXMFDKmlsSUZERdUJA+dyeGXNIdIQn6pLBjgS9l54aznB3isZm1QjNabBcvSy2LowQmUC5jee4pJnRJs0Q2iq7pNpT2pzVboC28L1sEPJ2LVpRbe7fYXCmckF1JXJNDnuGWS/TZrx65tPhzNlRX0QBIXNqFmUa+PgpgEzlf14F97cQ+fYWTu5bgrcsAYLjkAlLG062ys3cQaTEikIjSwFcaLXvgPCHSIchIXJDL1kV79PeAVbM6IkcLTRaziUTsmdKSL9twBgiabK7NpQw47nhheh/vCm4FnlJlLRtrZPsipKweozwmdtk1+hlwtM57lfDidJbI7vuRqRtzxn4OqEJUzwA18kVGz8o8iXFOXMyL5A1WMNH2hErzMtNKZTLkmwdha8qQas3l74jvwKJgkqelOWa/Hw3/tZSRD4sVa7DhtUFLa5G9OM5CPioGF0MAmn7m6vcL0PjS+8L09wx0FAFzEkvk6C4aTLdTTikGooveQINDssxnSY82Da12nZtNUX5VLr5eWKK+Ne0E4yOw0O5XLtNh0jvAK+U2aKCi8pDUU1+x9FvLGSCA/j9s02r8LKYqjpPPnL1a9LQtozRgnlkKGyKdyDuoYhk2ZWotuyPbZc/pOtLmcLgA7qemth1872mEGKuahflYK8IzfWVAjW16LCzwzl8ZmalUttuZEOJvI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DfYoj40svrvGDyKwncR4KsObscLdpqNgjuMOAr5RNJClfMJDeraGho0FTZeh?=
 =?us-ascii?Q?jwePKp2AQe6+/zLx+JQ66+UerRHndAZ2KR/iCGvakARsMmLeBbBuF2D9HiG5?=
 =?us-ascii?Q?tGOzbdJNH8knsObOlqGg9XHhKyRUO++HLKQhv5XwyhGs3WABJVeYurDNRTKO?=
 =?us-ascii?Q?pE8v4EMEQRRyf1AxhSL9nxLpt3vps5vpxAfXQdRGKjgG663dmt1C5wgeifsw?=
 =?us-ascii?Q?KoHsbks+MuK+fJMGZeKClFUAieX726j1+GWPFRczOq+FsZFjsjz61oZchxsU?=
 =?us-ascii?Q?igmxvn+CobdGMiSCrDRjpnZs++y/5MJ06Cht/mqt6iu2Q0Gd5SJMVTmBsfnK?=
 =?us-ascii?Q?7r4pPxh3/Is+NUOchRq6Rf0UJquXImXL1Xes6OOnpZO9LX2wmT1KK+Gtdj3W?=
 =?us-ascii?Q?HraoDKkoMwYUcYq9du+sEMKzFxnsCR0EcyA4+lcTNLtI23ppsgiHpX5Jf/eN?=
 =?us-ascii?Q?5JRg8y8KbdTLpj6XsuaV1teIFoHkP4/GMFF3PxlUeo5Vl5xdsZJi+mUE1FEM?=
 =?us-ascii?Q?RXx+VhzUFOY0I0+XM0auq2BkjQV7PhK72e9iIaqYpwkqRZJbZRIPOj0j5pDh?=
 =?us-ascii?Q?AfqGQZm7znyBytzB+vpq3KMCN1NgNsb2cFgrfFMQzbKgBrO8Cx81QEFy+Bp4?=
 =?us-ascii?Q?qgMTHHNm3cicTY5x4uAbvvNWulZP78xSTTC52EwoqSIumNeCvn2lqzZvL04Y?=
 =?us-ascii?Q?/SACPLFutKZG6/6vaAnoOX1k8kmYuc1Akk9MwHzYkN56aZ7SwaVJFq08iulT?=
 =?us-ascii?Q?53wMFdyNudRvmzwcOZrHiQch8P0G53tTyL809e5XpstUGlmMg4nLswmfHbK8?=
 =?us-ascii?Q?OfG59YA9nTvqtFtzlq/ZP1vw+ElekKUvGvtpyaR0+Zd6LMg96E1xDEKg7uqV?=
 =?us-ascii?Q?KI7/nw9ZFjKDGrviZCgGfu2Q+bvjsWaeca4LiYI+5+dnl1JBgK94w7tQPF6u?=
 =?us-ascii?Q?F6ao5O9d14kjmkGAi6TM8wjFjCaRH1llITczeDF8T82JZ0/n/FDKNCb66Onz?=
 =?us-ascii?Q?U3ayDcJ67a1BJiz3c8Xj/oKuW3mJVFSIgOjggxtgrWjHRflBnMamQVL/ss63?=
 =?us-ascii?Q?J/uSXbREtFpY5KBSbGAI3kCQ/kFkztwwyNVIdVX3/QSYugaxFi/yFkdhiLoH?=
 =?us-ascii?Q?/pzrn1/d9Sl/3HEv9ezg/SnL5rklTfvBf6XqGnq0fy1XT2bf/t7GWGD1lWqJ?=
 =?us-ascii?Q?yZTOArvcRWwQ1sjX6a0B2XtbFiG473vylqBcyWAknqXFbsCgV0gmta/xv3EA?=
 =?us-ascii?Q?zLJFrznVtHjYZt8vv3x6/i0y8JZXcCoh2LVWixCkSxNowfIDHMLfPTQOhr2p?=
 =?us-ascii?Q?zYQkox2+yp8LP9exIfd+Iff7+2Z8yspd8IXCaHWKj8n+ne8hrUPo+4nMsnF+?=
 =?us-ascii?Q?83jfrCx2mqnQZST84wSMmChqW3eHwFdZe3zHhmBHHR0oAptv/BDMbV+wun9H?=
 =?us-ascii?Q?xa5KOyfzn4xB0wwHy2eamUDYu1LyGxUf8m5bwksJk5qPtNrB82a1w0mVNFgT?=
 =?us-ascii?Q?HKNbVyRzNaREDCcUfAQPGbWQtTbvC6eI0VlL9ra+g4qNODmQkPCO4vDrlmg8?=
 =?us-ascii?Q?2si18yb02c3/PxxQPAZLCAWNrfFmHbEpJLMI6J8PjdQZnCpfuzfOTexX1ZhK?=
 =?us-ascii?Q?tWvEB9mCCw04/z5aYVXcbjTQJjtk43x/GlrhcQenvbvDfXWWHHimpuq2lZdF?=
 =?us-ascii?Q?vzkzE8UtgfR5h1Oo6lvVxwLJnGwv0Uzb0Is9Xnple0NHliHG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f595965-cd18-4c50-22f5-08deed17d999
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 02:19:42.3310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJR423rAZquh6n7jxKltBdsQ7iyaXXbT4rEaaTDLrdsD2VfOeRsgN7WDcX9GzpqoFeS6jl+9+iV/aGo1VJfsCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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

AMD General

Ping..

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Wednesday, July 22, 2026 11:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 1/4] drm/amdgpu: track faulted gfx user-queue slots
>
> A gfx priv/bad-op fault IV carries only the HW slot (ring_id), not the fa=
ulting user
> queue's doorbell. Add userq_priv_fault_slots (an atomic bitmap of faulted=
 slots, so
> concurrent faults are not dropped) and userq_priv_fault_work to struct am=
dgpu_gfx;
> a worker drains the bitmap and reads the doorbell back from each HQD to l=
ocate
> and reset the queue.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index aefd4f03b443..f83afa7e0aa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -535,6 +535,9 @@ struct amdgpu_gfx {
>       struct mutex                    userq_sch_mutex;
>       u64                             userq_sch_req_count[MAX_XCP];
>       bool                            userq_sch_inactive[MAX_XCP];
> +     /* atomic bitmap of faulted gfx UQ slots (index =3D pipe | queue <<=
 2) */
> +     unsigned long                   userq_priv_fault_slots;
> +     struct work_struct              userq_priv_fault_work;
>       unsigned long                   enforce_isolation_jiffies[MAX_XCP];
>       unsigned long                   enforce_isolation_time[MAX_XCP];
>
> --
> 2.49.0


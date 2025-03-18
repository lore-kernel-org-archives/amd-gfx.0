Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98EBC28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B00310E49E;
	Tue, 18 Mar 2025 14:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Key8Xmyh";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6509F10E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORiEssl//xu812uh817HpB8lMFIsu8M3Vw6kS0oJVvNtw5XZpJiM8tzT1KEwmAN8DimXIxfUrUcuBWxC9dSXx1/LicqSfnDLlSAgAjX1wJ1J/OPHwheqxHv0UBLZ82CU6Vf6FqgpaFmrSmKlaARk7ET0I8iK2hhsGw7uZgqLuMXddhaczHW7pxHwoicrt/NZ6xu8OTfj/P5X5d/ReJ5fwJjWEBUosnTV/QYF3JB7NC+nL/Mdh8puQvZhx7qNdm5gAVE3OMrQ+C3kX/owkFJUT2hiktCnA4UrKfgPlf6wrTsrjNuKK6vS5w2LvcDmBxSCeezdA2Sgj/eGXkexR+b6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTW0VHtodZiN2j+SBdzK37yJIPP95G8LwMjCUIzwjd0=;
 b=fe2WQZCDTecfu4x20FLzREsT4IDtfAemNGNdP502/sQOI2uKXaBrjppcplOQd1zWlJ0nqqprcgLmAfx81zE9a9jPhcJ4Kdg04URagA+z7PHf74DB/MQhIgvoH/8ABz17ny9y3YEmR8RZcZ1lHfvOfULZElRXcaChPy4jGv7BaLTxMMktXD6WtqexM+Pgq5VbvzCUWd5106GJIX5WUXHXqPHcpMJthhXGTE3fdUcqdLjjtjqYtOJykNh2ELiYMNewAzJjMjl2//IVu3jC/sgYe9g/O8/HiUzTrD47MCSc29i+kuCJVP23n0q/XNCKqU/aXdiafMRhMuVWXu4XSbcZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTW0VHtodZiN2j+SBdzK37yJIPP95G8LwMjCUIzwjd0=;
 b=Key8XmyhEUeB2HaNbuqP8OPVr2P2AhNvKMfaNoiCROh/Ubo/br6W346OUy2xv101z2bY7DD87hJL7VQDGufEa4Y9Plzlpdq36ZkuX6u2i61Vaz53cUFfKStsTTMAVEnOGjXF0yuCrQC+cFnxr90xWNCbP0ELfDtVKUwk5Lflq/k=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:32:29 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:32:29 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank
Thread-Topic: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank
Thread-Index: AQHbl+ZRQ3C7Cw1S5EqDCD20V5XcFbN4naAAgABBxICAAA4cVA==
Date: Tue, 18 Mar 2025 14:32:29 +0000
Message-ID: <CY5PR12MB634529E3811D992BB6E7349CFADE2@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250318091513.544679-1-xiang.liu@amd.com>
 <BN9PR12MB52570445292CD2DE422630B0FCDE2@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB5997134DD92CF0A627EA5B4F82DE2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997134DD92CF0A627EA5B4F82DE2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-18T14:32:28.891Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|SA1PR12MB8597:EE_
x-ms-office365-filtering-correlation-id: ef04ef13-8a32-4f05-14d2-08dd6629b609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dy3aui1/5qTEuGmkGKygcfnEFfTiPOlgctLx/tNsaWwwuaiFkYd65x2b9cUf?=
 =?us-ascii?Q?nWFnNhXyRe3vq3YWWhFcdZdYp+XJAJieK3HDbYPmT6rtcgXMBqVAQ0PGfipP?=
 =?us-ascii?Q?BEmG1+mH5mdxDiJVbyYkj1xujubrt9Yf3fmtJZ4ch81WwsCe8dD7/di5f6IW?=
 =?us-ascii?Q?xU+AqE0YvG7ySqhZlomIQSvVmtaTPq3qI765uZwB2MJTvtyCt/id4FmG0F6G?=
 =?us-ascii?Q?/i4uYIDNnXh4Ow6/XdQMIBjN22vaUpCjGuO7S+yJorSIXO65pet8hNE4cfIi?=
 =?us-ascii?Q?Z433RtK/dOd1XagjYdtis9yHgi1z5bEwwAARZZvWeVsWxZuBux7HVeWttQQt?=
 =?us-ascii?Q?osPQGygAQ03/3W6yMddmVCqoJLfui/xQWg64xnbG/hOxdHXhjxTN4Jgk9ubV?=
 =?us-ascii?Q?g8ch0L+G9s2VFdEMTY5bOnOcAl0me+wvNqFk+1f6An1zZj8Em9BOGmcI9vyu?=
 =?us-ascii?Q?Q7zX5Xkx5jf81EyznpaSnCrBGagS6TB9kEeQV8XV3f3VuUhIFhGsNfabibvb?=
 =?us-ascii?Q?gmlSetuGnbFpA7ppvol0bIJgPTw7TjoPHLgPxXw4ihwJI5HHcqNR4P668UGY?=
 =?us-ascii?Q?z91r2aOtzXZ7DC/R9gVpfPBlpZlMP4DLQamYU4jXTMILN2lyC/dyTLgngC24?=
 =?us-ascii?Q?AwhTFHXBK7720mcj56l/EfzCWrQdCnsWu9uWDC2lV7hTlDrnmLd0NnOD6tfx?=
 =?us-ascii?Q?Dyij4KFVlvX7Vw0JR/xsUwXsKFeVcNW0IkpXwmctvTaQDC+C/F38IYy8X3Lw?=
 =?us-ascii?Q?+4iiQZEIi5EsGvt/bOG54wpAQ4M26FjVNFROhIpPVuU0dS2ZqmNh0bXGJAa0?=
 =?us-ascii?Q?4Icr2YC0spVDexkIUzMYZKx4+nN9YO8qBt7lXbOttQmyjLBSFZTGX5GetV8W?=
 =?us-ascii?Q?ms5jMjap8lFaYS59SaIbCQiCrmJXSmFkQeTCSsTaR19DHX6Gd5G6VZL4bGGG?=
 =?us-ascii?Q?tt6sw7fVktpQdxl4ixqYfnZ6pAiTNMSXMIHD80MFDRVIfJlSkEauGvvocUgO?=
 =?us-ascii?Q?wiSc8RWErIedLKULK1pMm6ZcuZTaezTWpSWs09BVhRUTUsJyq9MGM/Wadwmv?=
 =?us-ascii?Q?J13ROw0Jt79odcBPhGh/zGa8Cob6uelpyP8Fb5a30GbY9psQq2ukYcoPnln7?=
 =?us-ascii?Q?cRTTw85FVBVWNTo5cvJrKIlc7sz40Ys4e1zeHZUZTuQtCi00FrZ1u96hqDgp?=
 =?us-ascii?Q?HFpK3oxpu3gURMhbc5G7/DDh6VYQxMCZe/pEVzKJBJ8yfcf1RKW20gcppXI5?=
 =?us-ascii?Q?LwBgMfgyeZsxw1vXEDXCCbWgFgq1SvhI7KiEJEKePgopEYKBggpY2mshfrW+?=
 =?us-ascii?Q?76qtEISMZKELG7A6HTeGshMR3EvY9yJp4kw1QbrFTGSsINnSysmvCOKtvjlK?=
 =?us-ascii?Q?hoQFySpCtr1acxfS2mKgVIQX8L5OCQgv9ZYFnUuLVHoNqLtJtgeyGFAl5BXb?=
 =?us-ascii?Q?qeA6g2X+m6ICuh7L0KJFGgdX6KNuuR7c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81qtAR7XEvTVd/fXu87c6FE9SMouz8tpDeS3f2BWTBASkVJdFBapLLU6f3j9?=
 =?us-ascii?Q?LMTuADNGgEcJRLSCrzprF38GyH0xz0QuNTvKYBukFAXA7Tay1zYHW7RQPH0i?=
 =?us-ascii?Q?5U3+vnG14pIP+HoCbcUwwoFnWNhqblcLZE1jtGg77xKwkCfoAyRCnOh4SNnX?=
 =?us-ascii?Q?OaGrFNV6Qd/fimAxtSztxkRPhmU9/U4gAbaX4mJBGF2br4JnWKAykRmw41LC?=
 =?us-ascii?Q?3e2DUyLjsCB9OfCQ0CMs8bf7TD6I/zJsUYqCAeu5QU/PTC34o22igYyj6SFq?=
 =?us-ascii?Q?2ENhssUXm0LiQqbmg08RHOvPVng0JLl6blqwdWwuButz5IfUotEIqQRzQe4T?=
 =?us-ascii?Q?1KT78pg1tMh5GZOH2cCgOASQCfOkRyZO9tKGLGSHFhHHhysrzkPaJXSq9vro?=
 =?us-ascii?Q?EEqtv+RvK7DNTNYsXrldpzQwx+q+e+cdJG4XDj+/mc3GoAYFxC07zFv1GasM?=
 =?us-ascii?Q?Hk5sHtzIiupW8xiKelq7QMXZcD2m4mnRl6QvjP9LaEpb28dnptHkRoABZR2V?=
 =?us-ascii?Q?aL0OICVbx6XBx1Bq39uHO1HV3RQViPk5C/dEfjdSzDDXGQUAt1b7me28jpvD?=
 =?us-ascii?Q?dYSROwYhMuvG1qflReDjhvspQx72G9aOBt7k9MZDo5va0V2Kz0Y8PHYUeVpT?=
 =?us-ascii?Q?MMNMO0Yl9L2vtlUS4Gll0NOA4mBURV7+BgGHzyRNCqOVESqPxCz7/+IROsNi?=
 =?us-ascii?Q?YgkRYQIZM0QpptuL6ulr5N0Xt/y8IL/3DEwLRAVQxslwrL7x59Iysu1mlzkN?=
 =?us-ascii?Q?epDUcWCtUC3EjnJCw7AMiPiL97bqLdp2HX9sGlvnmXl/rMZuQfa4X0zwfXl8?=
 =?us-ascii?Q?rIKmkBFB0xyvT59SapFIlg/lfVPSOd6+ZVqd6klmy36Cqvt8p7KFIN7mOMq1?=
 =?us-ascii?Q?IcIyU9Z6rHzgCdCfWh8XUr/Mb0InAIgOvL0gnHZ2s82J6vWLfGMj000aHSzv?=
 =?us-ascii?Q?53OkXLA9f+RKb+3s5BP7HcVyKR95S1wzymtZFlnC8ByQ+1VV6kkq2w0Mm74A?=
 =?us-ascii?Q?/gnv5BL65IosLxoqS/v3NPrvwNOWTV90vqcFFfcN3QJnEH1VxmwyY9SMZrUH?=
 =?us-ascii?Q?zsqukq5ZCIcVFCufz0uxFeH8lzb24eosEGU/u2MDYgB5Dnuh51/CedXOYRkb?=
 =?us-ascii?Q?x2ZhX/9zSx3Dgyz1qkmnqiLysgpNEU8U5DhLtrELpjXPtQoNsbiKbm23IVgX?=
 =?us-ascii?Q?ifTtGZQj/0gsmzubLDGkiVfjm1QEhqg1j1lYZV8vk9qeFPv7ODXqUqQQZcOJ?=
 =?us-ascii?Q?+8yZkcuOdH5LNvdoRtGz5aX9Trv+rcwJTsMn+j3ixNoB2+LHRCEfn1XXlNYW?=
 =?us-ascii?Q?uZS64joumKEdc9+uRUz7OEx18Ox3szeq1DGjoOu4xFE++Fy8OQP9r4D2W8KA?=
 =?us-ascii?Q?oVEtHUfFiBuULol/s7vgERg5/bHCpMF9ZLX48nX/He7CWwE2cPbbY1Y2hsEF?=
 =?us-ascii?Q?fgTBCX6G92zuJ6fS01/93z97QgiNwdi1Oh2JYKWgXzISb08qnhhL5XNaIbEH?=
 =?us-ascii?Q?BuIwsjcwI/tXLlJ2SXPAG6byE0zbBdcBYpLzX+tfGukDW2xEYJerj8IAKKxf?=
 =?us-ascii?Q?iTM/9UL/MykYefLqjps=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB634529E3811D992BB6E7349CFADE2CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef04ef13-8a32-4f05-14d2-08dd6629b609
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 14:32:29.0191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iV4F62p5U8ztnWuPqq8RW0KKPfaxjXK6RIE4SEqyXMZwm9dQyO+Mxt9gGJIsJLLoR5pe14ku1+OENye+4rlsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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

--_000_CY5PR12MB634529E3811D992BB6E7349CFADE2CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Kevin,
Thanks for the comments.
Each ras block should collect their errors by calling amdgpu_ras_query_erro=
r_status_helper() in turns. In the case of ACA mode, amdgpu_aca_log_ras_err=
or_data() should be called with ras block specified to collect correspondin=
g errors.
However, in current code, the first ras block call amdgpu_aca_log_ras_error=
_data() and collect all the errors for all the ras blocks by not using the =
introduced ras block parameter but poll an appropriate aca handle to match =
and validate each bank entry, which is inappropriate because the polling is=
 matched by HWIP.
With above condition, the other ras block call will do nothing and return.
Best Regards,
Dean
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, March 18, 2025 9:13 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhou1=
, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use correct aca handle to validate aca ban=
k

[AMD Official Use Only - AMD Internal Distribution Only]


         list_for_each_entry(node, &banks->list, node) {
                 bank =3D &node->bank;

-               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
-               if (ret)
-                       return ret;
+               if (aca_bank_is_valid(handle, bank, type))
+                       handler(handle, bank, type, data);
         }

         return 0;
}

The aca bank set returned by the SMU may contain banks of different ip type=
s, which may result in incorrect statistics of aca bank information of some=
 RAS ip blocks.
e.g:
The SMU returned 6 banks in total, including 3 umc aca banks, 2 xgmi banks,=
 and 1 unsupported bank.


Best Regards,
Kevin
_____________________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, March 18, 2025 17:19
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Wa=
ng, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use correct aca handle to validate aca ban=
k


[AMD Official Use Only - AMD Internal Distribution Only]

+ <mailto:KevinYang.Wang@amd.com> @Wang, Yang(Kevin)/<mailto:Tao.Zhou1@amd.=
com>@Zhou1, Tao/<mailto:YiPeng.Chai@amd.com>@Chai, Thomas for the review.

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Sent: Tuesday, March 18, 2025 17:15
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
iu, Xiang(Dean) <Xiang.Liu@amd.com<mailto:Xiang.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank

The aca handle is introduced by upper caller, it's inappropriate to poll ac=
a handle to match and validate aca bank, which will cause unexcepted ras er=
ror report.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 122 ++++++++++--------------
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   2 +-
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  10 +-
3 files changed, 58 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..b07e101c545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -122,6 +122,25 @@ static void aca_smu_bank_dump(struct amdgpu_device *ad=
ev, int idx, int total, st
                               idx + 1, total, aca_regs[i].name, bank->regs=
[aca_regs[i].reg_idx]);  }

+static bool aca_bank_should_dump(struct amdgpu_device *adev, enum
+aca_smu_type type) {
+       struct amdgpu_aca *aca =3D &adev->aca;
+       bool ret =3D true;
+
+       /*
+        * Because the UE Valid MCA count will only be cleared after reset,
+        * the aca bank is only dumped once during the gpu recovery stage.
+        */
+       if (type =3D=3D ACA_SMU_TYPE_UE) {
+               if (amdgpu_ras_intr_triggered())
+                       ret =3D atomic_cmpxchg(&aca->ue_dump_flag, 0, 1) =
=3D=3D 0;
+               else
+                       atomic_set(&aca->ue_dump_flag, 0);
+       }
+
+       return ret;
+}
+
static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca=
_smu_type type,
                                        int start, int count,
                                        struct aca_banks *banks, struct ras=
_query_context *qctx) @@ -130,6 +149,7 @@ static int aca_smu_get_valid_aca_=
banks(struct amdgpu_device *adev, enum aca_smu_
         const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs;
         struct aca_bank bank;
         int i, max_count, ret;
+       struct aca_bank_node *node;

         if (!count)
                 return 0;
@@ -159,14 +179,16 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_=
device *adev, enum aca_smu_
                         return ret;

                 bank.smu_err_type =3D type;
-
-               aca_smu_bank_dump(adev, i, count, &bank, qctx);
-
                 ret =3D aca_banks_add_bank(banks, &bank);
                 if (ret)
                         return ret;
         }

+       i =3D 0;
+       if (aca_bank_should_dump(adev, type))
+               list_for_each_entry(node, &banks->list, node)
+                       aca_smu_bank_dump(adev, i++, count, &bank, qctx);
+
         return 0;
}

@@ -318,72 +340,29 @@ static int handler_aca_log_bank_error(struct aca_hand=
le *handle, struct aca_bank
         return 0;
}

-static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_ba=
nk *bank,
-                            enum aca_smu_type type, bank_handler_t handler=
, void *data)
-{
-       struct aca_handle *handle;
-       int ret;
-
-       if (list_empty(&mgr->list))
-               return 0;
-
-       list_for_each_entry(handle, &mgr->list, node) {
-               if (!aca_bank_is_valid(handle, bank, type))
-                       continue;
-
-               ret =3D handler(handle, bank, type, data);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
-}
-
-static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_b=
anks *banks,
+static int aca_dispatch_banks(struct aca_handle *handle, struct
+aca_banks *banks,
                               enum aca_smu_type type, bank_handler_t handl=
er, void *data)  {
         struct aca_bank_node *node;
         struct aca_bank *bank;
-       int ret;

-       if (!mgr || !banks)
+       if (!handle || !banks)
                 return -EINVAL;

         /* pre check to avoid unnecessary operations */
-       if (list_empty(&mgr->list) || list_empty(&banks->list))
+       if (list_empty(&banks->list))
                 return 0;

         list_for_each_entry(node, &banks->list, node) {
                 bank =3D &node->bank;

-               ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);
-               if (ret)
-                       return ret;
+               if (aca_bank_is_valid(handle, bank, type))
+                       handler(handle, bank, type, data);
         }

         return 0;
}

-static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_sm=
u_type type) -{
-       struct amdgpu_aca *aca =3D &adev->aca;
-       bool ret =3D true;
-
-       /*
-        * Because the UE Valid MCA count will only be cleared after reset,
-        * in order to avoid repeated counting of the error count,
-        * the aca bank is only updated once during the gpu recovery stage.
-        */
-       if (type =3D=3D ACA_SMU_TYPE_UE) {
-               if (amdgpu_ras_intr_triggered())
-                       ret =3D atomic_cmpxchg(&aca->ue_update_flag, 0, 1) =
=3D=3D 0;
-               else
-                       atomic_set(&aca->ue_update_flag, 0);
-       }
-
-       return ret;
-}
-
static void aca_banks_generate_cper(struct amdgpu_device *adev,
                                     enum aca_smu_type type,
                                     struct aca_banks *banks,
@@ -417,20 +396,14 @@ static void aca_banks_generate_cper(struct amdgpu_dev=
ice *adev,
         }
}

-static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type =
type,
-                           bank_handler_t handler, struct ras_query_contex=
t *qctx, void *data)
+static int aca_banks_update(struct amdgpu_device *adev, struct aca_handle =
*handle,
+                           enum aca_smu_type type, bank_handler_t handler,
+                           struct ras_query_context *qctx, void *data)
{
-       struct amdgpu_aca *aca =3D &adev->aca;
         struct aca_banks banks;
         u32 count =3D 0;
         int ret;

-       if (list_empty(&aca->mgr.list))
-               return 0;
-
-       if (!aca_bank_should_update(adev, type))
-               return 0;
-
         ret =3D aca_smu_get_valid_aca_count(adev, type, &count);
         if (ret)
                 return ret;
@@ -442,15 +415,12 @@ static int aca_banks_update(struct amdgpu_device *ade=
v, enum aca_smu_type type,

         ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, =
qctx);
         if (ret)
-               goto err_release_banks;
+               return ret;

-       if (list_empty(&banks.list)) {
-               ret =3D 0;
-               goto err_release_banks;
-       }
+       if (list_empty(&banks.list))
+               return 0;

-       ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
-                                handler, data);
+       ret =3D aca_dispatch_banks(handle, &banks, type, handler, data);
         if (ret)
                 goto err_release_banks;

@@ -537,7 +507,7 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
         }

         /* update aca bank to aca source error_cache first */
-       ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
, qctx, NULL);
+       ret =3D aca_banks_update(adev, handle, smu_type,
+handler_aca_log_bank_error, qctx, NULL);
         if (ret)
                 return ret;

@@ -730,7 +700,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
         struct amdgpu_aca *aca =3D &adev->aca;
         int ret;

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);

         ret =3D aca_manager_init(&aca->mgr);
         if (ret)
@@ -745,14 +715,14 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)

         aca_manager_fini(&aca->mgr);

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);
}

int amdgpu_aca_reset(struct amdgpu_device *adev)  {
         struct amdgpu_aca *aca =3D &adev->aca;

-       atomic_set(&aca->ue_update_flag, 0);
+       atomic_set(&aca->ue_dump_flag, 0);

         return 0;
}
@@ -880,12 +850,20 @@ static int handler_aca_bank_dump(struct aca_handle *h=
andle, struct aca_bank *ban  static int aca_dump_show(struct seq_file *m, e=
num aca_smu_type type)  {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)m->private;
+       struct aca_handle_manager *mgr =3D &adev->aca.mgr;
+       struct aca_handle *handle;
         struct aca_dump_context context =3D {
                 .m =3D m,
                 .idx =3D 0,
         };

-       return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (v=
oid *)&context);
+       if (list_empty(&mgr->list))
+               return 0;
+
+       list_for_each_entry(handle, &mgr->list, node)
+               aca_banks_update(adev, handle, type, handler_aca_bank_dump,=
 NULL,
+(void *)&context);
+
+       return 0;
}

static int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu=
_aca.h
index 6f62e5d80ed6..e71d6f5afaec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,7 +202,7 @@ struct aca_smu_funcs {  struct amdgpu_aca {
         struct aca_handle_manager mgr;
         const struct aca_smu_funcs *smu_funcs;
-       atomic_t ue_update_flag;
+       atomic_t ue_dump_flag;
         bool is_enabled;
};

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..a4038e92c59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
                                       void *data)
{
         struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
         u32 instlo;
         int ret;

+       status =3D bank->regs[ACA_REG_IDX_STATUS];
+       if (!ACA_REG__STATUS__VAL(status))
+               return 0;
+
         ret =3D aca_bank_info_decode(bank, &info);
         if (ret)
                 return ret;
@@ -894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
         switch (type) {
         case ACA_SMU_TYPE_UE:
                 bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               if (ACA_REG__STATUS__UC(status) && ACA_REG__STATUS__PCC(sta=
tus))
+                       ret =3D aca_error_cache_log_bank_error(handle, &inf=
o,
+ACA_ERROR_TYPE_UE, 1);
                 break;
         case ACA_SMU_TYPE_CE:
                 bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1


--_000_CY5PR12MB634529E3811D992BB6E7349CFADE2CY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0=
);">
<span style=3D"font-size: 12pt;">Hi </span><span style=3D"font-size: 11pt;"=
>Kevin,</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks for the comments.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Each ras block should collect their errors by calling amdgpu_ras_query_erro=
r_status_helper() in turns. In the case of ACA mode, amdgpu_aca_log_ras_err=
or_data() should be called with ras block specified to collect correspondin=
g errors.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
However, in current code, the first ras block call amdgpu_aca_log_ras_error=
_data() and collect all the errors for all the ras blocks by not using the =
introduced ras block parameter but poll an appropriate&nbsp;aca handle to m=
atch and validate each bank entry, which
 is inappropriate because the polling is matched by HWIP.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
With above condition, the other ras block call will do nothing and return.<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Dean</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 18, 2025 9:13 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Xiang(Dean) &=
lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.f=
reedesktop.org&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;=
YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Use correct aca handle to validate =
aca bank</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Calibri" size=3D"2"><span style=
=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>
</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>
</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(node, &amp=
;banks-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank =3D &amp;node-&gt;bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler(handle, bank=
, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
aca bank set returned by the SMU may contain banks of different ip types, w=
hich may result in incorrect statistics of aca bank information of some RAS=
 ip blocks.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">e.g:=
 </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
SMU returned 6 banks in total, including 3 umc aca banks, 2 xgmi banks, and=
 1 unsupported bank.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Kevi=
n</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">____=
_________________________________________<br>
<b>From:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>
<b>Sent:</b> Tuesday, March 18, 2025 17:19<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Zhou1, Tao &lt=
;Tao.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Use correct aca handle to validate =
aca bank</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Calibri" c=
olor=3D"blue">[AMD Official Use Only - AMD Internal Distribution Only]<br>
</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><br>
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ <a=
 href=3D"mailto:KevinYang.Wang@amd.com">
</a><a name=3D"_@_E4FE03D7BCDD4D2F8A3A6894796390C8"></a><font color=3D"#2B5=
79A"><span style=3D"background-color:#E1DFDD;">@Wang, Yang(Kevin)</span></f=
ont>/<a href=3D"mailto:Tao.Zhou1@amd.com"></a><a name=3D"_@_8E1C3F2B43BE42F=
B961F426A9DAAD333"></a><font color=3D"#2B579A"><span style=3D"background-co=
lor:#E1DFDD;">@Zhou1,
 Tao</span></font>/<a href=3D"mailto:YiPeng.Chai@amd.com"></a><a name=3D"_@=
_EBB3A0FDE65C4FD2A2B1D70885B5F9DF"></a><font color=3D"#2B579A"><span style=
=3D"background-color:#E1DFDD;">@Chai, Thomas</span></font> for the review.<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>
From: Liu, Xiang(Dean) &lt;<a href=3D"mailto:Xiang.Liu@amd.com"><font color=
=3D"#467886"><u>Xiang.Liu@amd.com</u></font></a>&gt;
<br>
Sent: Tuesday, March 18, 2025 17:15<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#467886=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=
=3D"#467886"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Liu, Xiang(Dean) =
&lt;<a href=3D"mailto:Xiang.Liu@amd.com"><font color=3D"#467886"><u>Xiang.L=
iu@amd.com</u></font></a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank</s=
pan></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
aca handle is introduced by upper caller, it's inappropriate to poll aca ha=
ndle to match and validate aca bank, which will cause unexcepted ras error =
report.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 122 ++++++++++--------------</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/amdgpu_aca.h |&nbsp;&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">driv=
ers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |&nbsp; 10 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">3 fi=
les changed, 58 insertions(+), 76 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x ffd4c64e123c..b07e101c545d 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
122,6 +122,25 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, =
int idx, int total, st</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total, aca_regs[i].name, bank-&gt;regs[=
aca_regs[i].reg_idx]);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic bool aca_bank_should_dump(struct amdgpu_device *adev, enum
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_smu_type type) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because the UE Valid MCA count wi=
ll only be cleared after reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the aca bank is only dumped once =
during the gpu recovery stage.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_SMU_TYPE_UE) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_ras_intr_triggered())</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D atomic_cmpxc=
hg(&amp;aca-&gt;ue_dump_flag, 0, 1) =3D=3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-=
&gt;ue_dump_flag, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">stat=
ic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu=
_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int start, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct aca_banks *banks, struct ras_query_context *qctx) @@ -130,6 +1=
49,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, =
enum aca_smu_</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *sm=
u_funcs =3D aca-&gt;smu_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank bank;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, max_count, ret;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
159,14 +179,16 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_devi=
ce *adev, enum aca_smu_</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank.smu_err_type =3D type;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank, qctx);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aca_bank_should_dump(adev, type))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; list_for_each_entry(node, &amp;banks-&gt;list, node)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_smu_bank_dump(ad=
ev, i++, count, &amp;bank, qctx);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
318,72 +340,29 @@ static int handler_aca_log_bank_error(struct aca_handle *=
handle, struct aca_bank</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *=
bank,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum aca_smu_type type, bank_handler_t handler, void *data)</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-{</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handle, &amp;mgr-&gt;=
list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (!aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D handler(handle, bank, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks=
 *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_dispatch_banks(struct aca_handle *handle, struct
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+aca=
_banks *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_smu_type type, bank_handler_t handler, =
void *data)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_node *node;</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank *bank;</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mgr || !banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle || !banks)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pre check to avoid unnecess=
ary operations */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list) || list=
_empty(&amp;banks-&gt;list))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks-&gt;list))</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(node, &amp=
;banks-&gt;list, node) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank =3D &amp;node-&gt;bank;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_dispatch_bank(mgr, bank, type, handler, data);</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (aca_bank_is_valid(handle, bank, type))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler(handle, bank=
, type, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_ty=
pe type) -{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D true;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because the UE Valid MCA count wi=
ll only be cleared after reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in order to avoid repeated counti=
ng of the error count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the aca bank is only updated once=
 during the gpu recovery stage.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_SMU_TYPE_UE) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (amdgpu_ras_intr_triggered())</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D atomic_cmpxc=
hg(&amp;aca-&gt;ue_update_flag, 0, 1) =3D=3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; else</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-=
&gt;ue_update_flag, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">stat=
ic void aca_banks_generate_cper(struct amdgpu_device *adev,</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aca_smu=
_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_b=
anks *banks,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
417,20 +396,14 @@ static void aca_banks_generate_cper(struct amdgpu_device =
*adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-sta=
tic int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type=
,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bank_handler_t handler, struct ras_query_context *qctx, void *data)</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aca_banks_update(struct amdgpu_device *adev, struct aca_handle *han=
dle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum aca_smu_type type, bank_handler_t handler,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct ras_query_context *qctx, void *data)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">{</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &amp;adev-&gt;=
aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_banks banks;</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 count =3D 0;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;aca-&gt;mgr.list))</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aca_bank_should_update(adev, type))<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_=
count(adev, type, &amp;count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
442,15 +415,12 @@ static int aca_banks_update(struct amdgpu_device *adev, e=
num aca_smu_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_smu_get_valid_aca_=
banks(adev, type, 0, count, &amp;banks, qctx);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks.list)) {</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;banks.list))</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_banks(&amp;aca-&gt;m=
gr, &amp;banks, type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_dispatch_banks(handle, &amp;b=
anks, type, handler, data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; goto err_release_banks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
537,7 +507,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev,=
 struct aca_handle *h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update aca bank to aca sour=
ce error_cache first */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_banks_update(adev, smu_type, =
handler_aca_log_bank_error, qctx, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_banks_update(adev, handle, sm=
u_type,
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+han=
dler_aca_log_bank_error, qctx, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
730,7 +700,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &am=
p;adev-&gt;aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_manager_init(&amp;=
aca-&gt;mgr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
745,14 +715,14 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aca_manager_fini(&amp;aca-&gt;=
mgr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">int =
amdgpu_aca_reset(struct amdgpu_device *adev)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_aca *aca =3D &am=
p;adev-&gt;aca;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_update_flag, 0=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;aca-&gt;ue_dump_flag, 0);=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
880,12 +850,20 @@ static int handler_aca_bank_dump(struct aca_handle *handl=
e, struct aca_bank *ban&nbsp; static int aca_dump_show(struct seq_file *m, =
enum aca_smu_type type)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 (struct amdgpu_device *)m-&gt;private;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager *mgr =3D &amp;a=
dev-&gt;aca.mgr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle *handle;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_dump_context contex=
t =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .m =3D m,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .idx =3D 0,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_banks_update(adev, type, handl=
er_aca_bank_dump, NULL, (void *)&amp;context);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;mgr-&gt;list))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handle, &amp;mgr-&gt;=
list, node)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_banks_update(adev, handle, type, handler_aca_bank_dump, NULL,
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+(vo=
id *)&amp;context);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">}</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">stat=
ic int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git a/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca=
.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6f62e5d80ed6..e71d6f5afaec 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
202,7 +202,7 @@ struct aca_smu_funcs {&nbsp; struct amdgpu_aca {</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_handle_manager mgr;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aca_smu_funcs *sm=
u_funcs;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ue_update_flag;</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ue_dump_flag;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_enabled;</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">};</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x c0de682b7774..a4038e92c59e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *=
handle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void *data)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">{</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0, status;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instlo;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D bank-&gt;regs[ACA_REG_IDX_STAT=
US];</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ACA_REG__STATUS__VAL(status))</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_bank_info_decode(b=
ank, &amp;info);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *ha=
ndle,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_UE:</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_ERROR_TYPE_UE;</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ACA_ERROR_TYPE_UE, 1ULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ACA_REG__STATUS__UC(status) &amp;&amp; ACA_REG__STATUS__PCC(stat=
us))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aca_error_ca=
che_log_bank_error(handle, &amp;info,
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ACA=
_ERROR_TYPE_UE, 1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_CE:</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB634529E3811D992BB6E7349CFADE2CY5PR12MB6345namp_--

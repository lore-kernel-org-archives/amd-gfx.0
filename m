Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7FEC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 08:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D30010E067;
	Thu, 20 Mar 2025 08:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mK/qZByv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7DC10E067
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 08:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYnnHIwhF/QOxXxC2r95XOfFMOcw+76oaKuu6pFcdofeNHjrpBXZMQ5dJZdvWiYs40B1CAFGsNX0b3r8khqjK5ak19uojmQfW2y9KHHgeiCxBBuT/kogaJhimSdkVwT0T1/wE6660fonCo9OWSXCE41K1AqgIw6E1hfxQEh/ygmQFE2/atUQUNNBsyfhH8242Up5DQNWnNWisSp7Xcero4g133KbzbbkoQwYcjmoQiDtH+ip/cmiTSQtHXl8RV0Cs0cRECUvu7WqbDPa+saeGYWHKk4FzoGd8dTZJRurrA550cq8eQ+l7TJnfZ8WHmQ/HkYzS5YYxjUufspUCefOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOQ+jB2OQ8umAeD/gz8+p9N6t6RzUjtrId/6iLJ8b7M=;
 b=BnpAVRtkvRSW0X4oZD0V0BslEkLZ+pUry4Y3ANP+w6Tz5P2cSoiy7/SLZ8YM+SUJWFdq1Vj4085yAgQg4LyufgJIpv0fx/lHnLHT9N9rZVAJLu4DsHvEh5rS00WFqh67zkCzVjwnnxDdHnQ1bQAsUBdsA8lgtQYVE4CRvF8o0DngfTA1xn402rFOxLrfUEc0p3fS5MrzFCFHCXkZiNvOvJ0tRZAEjY2NFJCX6XIMHIrfX+qYT3TkttvxUbjcqcw2eoh0U50FiAa1TkdupjZGr2elLbwz8rb4xSVVTh+66tQ8A9+/LR03GaZYwcp6J6v0kGJEC5BCtLX3429dVjbaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOQ+jB2OQ8umAeD/gz8+p9N6t6RzUjtrId/6iLJ8b7M=;
 b=mK/qZByvJQyqhU+tx6aamp7qV6hbUuTjntQIJ03mZpb0xrtldeYAVg2lDeKgWi/H0wrI1vYfQVyOoNH+OHiF0Sc0CPs/3QWZxvM7OpLlURvlqEXd/5z0e7zot1LmO5H2MKiKBYMDCkHZSFNKEnZSHQ90QzG8h+xkvxPkGusam+w=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 08:04:55 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:04:55 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Index: AQHbmV9oVSkgRsGeHE6WI6cRNj0M2LN7mkqAgAAQGIA=
Date: Thu, 20 Mar 2025 08:04:55 +0000
Message-ID: <CY5PR12MB6345095D551B0296701D99D7FAD82@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250320061437.572914-1-xiang.liu@amd.com>
 <PH7PR12MB59979C5722583FE5846BB87082D82@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59979C5722583FE5846BB87082D82@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T08:04:56.732Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|BL1PR12MB5828:EE_
x-ms-office365-filtering-correlation-id: 6da92536-4dd9-4c1e-24d2-08dd6785e6c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pCFRFCx5HOZHvWOOmlUJdPj3XaGwCL5MLsEkTqM5sW+r9DQuR/yCMlA3cj+i?=
 =?us-ascii?Q?ugH3clBZwxlcU7q1eXxxThT6K+c822wYEHnGgPAuP7hH4FkGgjM4g7tDc2gu?=
 =?us-ascii?Q?SKRc00Hb0ALcSz+hfq+HP4Td3yBhZPVoklIoP4yAROZRnh8Dv21pZNYADjRw?=
 =?us-ascii?Q?YRCsEhd3fsXHs96I+S/xhOX5fbByHWYOspR4Ega09d/whqDpEYcGkbuxUjaG?=
 =?us-ascii?Q?QusvACeHJlIAbjlZqRHOaOQH6AZYsTvujyY+CTnPbYN9nLdpIL4JOozmCXRO?=
 =?us-ascii?Q?jkWmMp5LM4VxIFV1GBVrRsKBKQM6WdryOT59vkPVKGMAmACvy9BTZ5ktlexF?=
 =?us-ascii?Q?6yPMwNWsgKlz5Lztq6hQp7IozCFDVA5sk4WR/1rY6W3b9KLy7OL3VcO/7pbc?=
 =?us-ascii?Q?lffJsKUPOXRfb0bbsxYyr4wh80N9Xj6EF6jxXfa4HlV1R/Qtq7LlBuySVmAk?=
 =?us-ascii?Q?/tDARRm/qpVl+p2OtPxKNy0TdMzQo5iLeYoCh/KmPedz5DVrjmzMup/QG3J5?=
 =?us-ascii?Q?JTwV/JsGc62GUsHXhawxkAhp7Zo5e3Pzg8mYSKHFcoumShjhoyEk3UQUmJrL?=
 =?us-ascii?Q?S16iq09uE+tmT7cWSv4nh3fy7AtIFRf+5Mh4jQNigJ+BzTpwkOnn4oz1DhJW?=
 =?us-ascii?Q?6gjqWoZfRs4kpg91hwaQmVwT6CvayvZSLsAE3zQr/+OyyCAHiRBIHkVbfTaX?=
 =?us-ascii?Q?L/rjJw2270uizWllnXvF25xmqhHT8THQDhFxkIqlF+2HL9OVDATcJA+wixJV?=
 =?us-ascii?Q?N33rgVTdJaas4jjWSpJ2poUOC5gq7r8cxLxlcRL78uB9bIL9K4JpRGsec9KJ?=
 =?us-ascii?Q?OCFeKmsSRqoL1ADoJKgHfpwkOOhi9dlnnnNm9lUBYtmmBK4CD7IKhKnzp5zY?=
 =?us-ascii?Q?oY3j8mpXllETuFs88JM0HuUebVqm3y/NWDGzICpkCcj6jmVlE8CIfG0fqSzy?=
 =?us-ascii?Q?Y2k531SnVAKUl+kk7S367w1wpsMeH6dzteKEIirPsMFDLQvy6HUWBWHxYHxV?=
 =?us-ascii?Q?Y5aBi++aITGUAjhwyAlG8jW0wP59DaB7E0W6hFqq6+AHWG+uh8bRD3psldlX?=
 =?us-ascii?Q?4IauJIB+x1KuKuo2ZtleTgzhyr4bfMIsH8A0MoxfVoJ2goD3NvcLOivFiC1N?=
 =?us-ascii?Q?kwDDPE2Z5edjbxeuXICspkwXXvBusyemN/dkr/NOSnb2H0llYtho7iGVjnwL?=
 =?us-ascii?Q?xxqlNRaIE8CaD05MWRMyn4jb2ekff7gtTKln1pZTpD+dF2LIJxlHrTaeqIhu?=
 =?us-ascii?Q?ueWI8bbnpqHkSpp0t1Jn0LI7bdBe697TVr/Jqe5DvTDR+k+W4p2B1f8zdrhl?=
 =?us-ascii?Q?bziWxYExZzMiCBquMAcZvzvWLeR2Nur8r3KPMc/yI4ccoExgrjXrj9ee001V?=
 =?us-ascii?Q?u3Ye9sq659f4oqa3JlxaGJjfH998Ng3l5csvgvxzlkzzc36hes/yiVTpkoD2?=
 =?us-ascii?Q?p3u80mi7BOzNud6q97MlmvtFq24ONSHm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r0LNc0p6mVMeDsi76t9obiev/2trqkk/0M8uDmJwhH3ORLyLUg7G5cOgUJ2h?=
 =?us-ascii?Q?jfWOjgBzyw+IMXq8MfQilpGMC3MM0j/xe5o5pVXeu7xZ2sfg4OwcvwR7qESX?=
 =?us-ascii?Q?f6qGlbsoAKtpMDslIAiCLo0hwE4r8wOUIA+sj3IyN/cid1nK86ibRCJgseew?=
 =?us-ascii?Q?/g+JBMb5V6h3ej/oV+lwL5ffCm1aIsssChaycMyl4/tDQinrklCppkm+VeWC?=
 =?us-ascii?Q?EqFVWeZaU2BOCAsqTCXCiRBRNSjEEFJS3wo8MMphJYmEh8ic7QzbDD9w06ai?=
 =?us-ascii?Q?mLnCi0KOimAWs7eIHJc82S0MUMW4qpixpsZ2Lb+bu1n11dS1XOe519VWxTmR?=
 =?us-ascii?Q?RYo/xFzusjbQj5yt98OKcnZdrmdI7u6RSvIU+yfV0MKz1DjTO353S3Gw/0Ey?=
 =?us-ascii?Q?zwgu9xts99Af4qDnNOLtCW7ooe3DpQx7hwnEXAMn4eg3597sgWjXgfS0rWrB?=
 =?us-ascii?Q?l3UMvi1AM+hCE6gxLJmXRDgcv6Oa3z6Ly5Sp5DyK2KDuY6UPdmQTz3tspDHq?=
 =?us-ascii?Q?F1qEj8MWfyRVrbOMpX7/QIAmmdcVblhM+MceLxYGbbECGYaF3f+gYGs78dl4?=
 =?us-ascii?Q?U1VvOpN/7TAynb897QAHDobqYbLDTQHT5yCAd0c6gEanpeUK0mjnhFo7Vm5B?=
 =?us-ascii?Q?O3ZXbIe2M1E/pehuGPESyB2MsorOY4HtPDpoBK9Hh/+V1Yn68ufbBSDNZeTh?=
 =?us-ascii?Q?+0mE7SdTD6qQZH5FdY+Noa1CSoJ9baOtzSHV/F2BKRdXYuDu4jFWrG9WupFy?=
 =?us-ascii?Q?o5ZM1JlypKEpyvebsJIKjgZzca7/feAEUBXky0ecWOgTrTwvowRW/BhoRST0?=
 =?us-ascii?Q?UEktKWZiqzEbqZvrQvUeXFH7E7VdSU3AVlz5YMCrUnj7yISBU+PqIfUd8/5r?=
 =?us-ascii?Q?1CMNlA4FlBLF8EUSikkQU3FRCm07ZdFaEt1+GzQ59vLuVfb4vlBzaYYIAtap?=
 =?us-ascii?Q?1eOn3HaRsIIm1l8k1WScJI+KmKrQ3hw6r1gk5TjbN6M32zMgQfZsJQoIDRfk?=
 =?us-ascii?Q?0pSDqwM5sbbDH+emc9I8r64ckBb8Mi6ttX7TRm9fdD8qYlOSUTTP3HnzLfWK?=
 =?us-ascii?Q?M2Lgjizh6gn2LhQL5C8X+FVPYrIHAYlhrXQSt3stYLXrJEtcYVVzKMDhaGVp?=
 =?us-ascii?Q?rmeM9p9SJj81/N4cVd2fLZHiShoJSU6vOj4ylDrNc13JQjQTF283x+ldpPue?=
 =?us-ascii?Q?4a/0Uvlwu+Y1cpDVnVHUP7HKrTyC6be0CMhQAgFlUG5RFNmQe39hDae2UIKT?=
 =?us-ascii?Q?WK8HfLKb3NLjC8EQY6RiNHpnwIGl+yCjtPfyg24u8mpHLSCH5x3JQCqkP8nI?=
 =?us-ascii?Q?9sfK9991kZhwNtmztZ8lQWazWxX/X0mDhcNcYTqC9jhCeHtkmEMzfEev0nOE?=
 =?us-ascii?Q?6iJGAQddOK8TOR/PcgPc7BVnPyYycXLCbLFNBCG62SgX3p3QC4K2kZvA7OCK?=
 =?us-ascii?Q?OwkWc0ugNhmPZ1W755sztktVh5LrCUgSTGA+xm3r69eYTcQr/8A6zy1oK/8c?=
 =?us-ascii?Q?1cohlhUjEPHiUCuXabYiRaxl1+89oa+3/sDEQrAYcYyNy8D9jcYaJkRh09ns?=
 =?us-ascii?Q?KzW5G3q5ThKb5Sfnra8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6345095D551B0296701D99D7FAD82CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da92536-4dd9-4c1e-24d2-08dd6785e6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:04:55.5707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4AutEZpwQx0WkMYeR2t75v21ks5KH4nU54b/FCkB86Xi94K2p76pcmuvRM2xInmkzRw40Q05tVmvVzgcSfuvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

--_000_CY5PR12MB6345095D551B0296701D99D7FAD82CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, as the discuss offline, will improve it.

Best Regards,

Dean

________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, March 20, 2025 3:05 PM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank=
 parser

[AMD Official Use Only - AMD Internal Distribution Only]

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

It seems that the above code is incorrect, which may lead to error statisti=
cs of different types of errors.
In the aca parser interface, I think there is enough information to identif=
y the types of errors and correctly count errors,
Please double check it, thanks.

Best Regards,
Kevin

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 20, 2025 14:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser

In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  3 +++  drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..3f45a600f547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        if (ret)
                return ret;

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..b21d784a7f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
        info.die_id =3D instlo =3D=3D mmSMNAID_XCD0_MCA_SMU ? 0 : 1;

        misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+       status =3D bank->regs[ACA_REG_IDX_STATUS];

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1


--_000_CY5PR12MB6345095D551B0296701D99D7FAD82CY5PR12MB6345namp_
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks, as the discuss offline, will improve it.</div>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin: 0px;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 11pt; color: blac=
k;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin: 0px;">
<span style=3D"font-family: Aptos, sans-serif; font-size: 11pt; color: blac=
k;">Dean</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Yang(Kevin) &lt=
;KevinYang.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 20, 2025 3:05 PM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx a=
ca bank parser</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_ERROR_TYPE_UE)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_log_aca_error(handle,=
 type, err_data);&nbsp; }<br>
<br>
It seems that the above code is incorrect, which may lead to error statisti=
cs of different types of errors.<br>
In the aca parser interface, I think there is enough information to identif=
y the types of errors and correctly count errors,<br>
Please double check it, thanks.<br>
<br>
Best Regards,<br>
Kevin<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Sent: Thursday, March 20, 2025 14:15<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) &lt;Kev=
inYang.Wang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Chai, Thomas=
 &lt;YiPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br=
>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser<br>
<br>
In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |&nbsp; 3 +++&nbsp; drivers/g=
pu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++++----<br>
&nbsp;2 files changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c<br>
index ffd4c64e123c..3f45a600f547 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c<br>
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D ACA_ERROR_TYPE_UE)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aca_log_aca_error(handle,=
 type, err_data);&nbsp; }<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index c0de682b7774..b21d784a7f9c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vo=
id *data)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aca_bank_info info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 misc0, status;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instlo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
<br>
@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.die_id =3D instlo =3D=3D mm=
SMNAID_XCD0_MCA_SMU ? 0 : 1;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; misc0 =3D bank-&gt;regs[ACA_REG_=
IDX_MISC0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D bank-&gt;regs[ACA_REG_IDX_=
STATUS];<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_UE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank-&gt;aca_err_type =3D ACA_ERROR_TYPE_UE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ACA_ERROR_TYPE_UE, 1ULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank-&gt;aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
__STATUS__DEFERRED(status)) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_DEFERRE=
D :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_ERROR_TYPE_UE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D aca_error_cache_log_bank_error(handle, &amp;info,<br>
+bank-&gt;aca_err_type, 1ULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ACA_SMU_TYPE_CE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bank-&gt;aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);<=
br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6345095D551B0296701D99D7FAD82CY5PR12MB6345namp_--

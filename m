Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D4C282C6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 00:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA6810E17D;
	Tue,  4 Mar 2025 00:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQgcmD3o";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D966A10E17D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 00:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7KqN/zSV5s5yYFmq8ZyMB/CJdHssvS1NfhbShu19WbRGzuiwGxXAFegrrpp5WFD4P3vyGRXnKVhjs1TVN+YZyQBsT2hu4S09+j9mGtTAgVA2t+ZFdgz5aBqhmjT0dh69rLod9eS456DlHlcg/CcYTJDgxCXxCiCHWZ1oHMZRrp1NHgVj0YfxRPVGD8hupp4ZHC0jOYa1EHpKycHha2tmV3zDv4E4EhgfsakVNAJATFKl2smDe8I/1JpI13iSLHNbByiKiml78qwU5pF/NnjGEY7Fq3CKOwXJoPDkwE8OqpM8GFvr9orQYkqbYMgYkaGy13PUTNsVcsJd3q6Cd016w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga2m2JvHohOeYFR5sPNA7zk+bsqDGQ517DcJ1cI6aY0=;
 b=NHH/01Dw4ODqi817sLqmURuKZ1fmJf/RJ4Ns2o3otaBrTQvH+DlbMDq9rzTkacgFNgxVS4mYmnr03V/jzTKeaxJxnW6V5ewIkEssYiM0niOf7h/tN3GLrpMpdHNZdJADaIglpiefXksJQdHCpqCvBhkXMsl0uRnYBeBr8/1dcjDf1TiNaLhhZc/u0+B0dT5iCsUOqxpLKsyuS9WbzZMxvGbl6HuvYK1IKrRQxxdDynmocQPwx1gz8bgQfupJO5AK29SNYwAcIP5nYOploAr/oFvMo8e+ospP4+JH24VZVRdqzb3qCz9rY7IsmOUnEcawQ2UP5+p9r9UxqJBD4L3+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga2m2JvHohOeYFR5sPNA7zk+bsqDGQ517DcJ1cI6aY0=;
 b=BQgcmD3o1GVG04yuCqYdykCU6VP9paFJxWs6PknOMx3mEYOUH4Bq7PQCug+EZoMPR2eJW1CO7gHv1D/JIHybhh2TfcvJge943KZlJE0Naj3ne48MalKBXqc06rBvRXVuPfWhHWUUNR1O90Vt6JY4tmRLe9vrh/8P+PZTsnGD9HM=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 00:44:36 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:44:36 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Thread-Topic: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Thread-Index: AQHbjB+FPY6Kk3TRzU+s74T6IZlEjrNiJOmA
Date: Tue, 4 Mar 2025 00:44:36 +0000
Message-ID: <PH0PR12MB541759D007BBD47B23176CE58FC82@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250303093448.3190674-1-Emily.Deng@amd.com>
In-Reply-To: <20250303093448.3190674-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f69861c5-fcce-4605-9924-3c0c4c3e67d0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T00:44:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB7639:EE_
x-ms-office365-filtering-correlation-id: 5ea39c02-5d01-47e7-1f97-08dd5ab5bd10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8imLDOdXfhXyygTKYge6YiZ+s49x3YK0Tz69wNnJLagBRpVI12AtYFY1pfrx?=
 =?us-ascii?Q?aAyA0UMauqtIP8PMMJX0MVCYloDOzVs1xJKfN5ZaQHLSBMVu4UIO6zJctQ5Z?=
 =?us-ascii?Q?FCdLA3fhkurCxDzEQ9xPU2TwXvqn09X5WJC8E5P9iqobq2qMrTLriuVEgmU5?=
 =?us-ascii?Q?uQCejuDaljZxCE1zJCaNi9IKXe8UG/g0FavP/bN0+ijmdifMreoGXkVc7mDD?=
 =?us-ascii?Q?eCgMZ3E7g6+wdX95yF6QopMHVR6aFuCr5UvrFoJoU9N08EXCrI5ZDCdRoFH+?=
 =?us-ascii?Q?tWMiUu8ISc1riqErKJL1GlU7wvZ0rY1DsXLzAOtmNerOvr4P/eqp78iXJOb9?=
 =?us-ascii?Q?Ic0e8wqILVMiURwJ6Kzi+TpNQdrzis5QDojyqFvRVobtr63baHzDDm3bEGh5?=
 =?us-ascii?Q?DBzsFx82y1v62eiHlpiznqpotA63IT9DEWdlIZatiiTJA5qDlcdLkhT7t6Yt?=
 =?us-ascii?Q?jp1ItQL0Lz+mK/JBunZEvDDLjjYD6c75oi2mNWSrKP0LG+ePN0CsvizF+Uld?=
 =?us-ascii?Q?YfCjCgROkIFAHryNSqu1hqmte3FXQDvw78dsV1Qj3W/hetSw9gsb7Nd8V8fA?=
 =?us-ascii?Q?2ar6z63emyht+fRsLz6PhQ0sduplBS0+VME6x6EC4l8k/Ue8Y11c0e2a97l+?=
 =?us-ascii?Q?LdZeI7UsyUULiPhlxsfpte8+opKnTpzSjfZfHSoG/0WU0sFYfyy8m22C1Vvp?=
 =?us-ascii?Q?xAwJHUWIR1VA0el313zKe9qBKUyh1rnP1F5teDqlkxWgy3HtvpZhMjBNpdfg?=
 =?us-ascii?Q?7jUUmw7jSrKMft5dgYmGykHiwvfwuDRnVM5R2H5PJW3KIhxduNA5y8aVyhho?=
 =?us-ascii?Q?ECdQ81xOH9dRl5Oy36MZygLpLv8LqLLBoPpw8l6DkhAUM0ZyiaH9NY5xrB1c?=
 =?us-ascii?Q?d1TEY3kBNxSWC/Og1tWK3eDEgPhlVFCQV21KpzXGbjV0CqT4zK5GhmwnTQuK?=
 =?us-ascii?Q?64lmVmWZtIMqBsnSXAACkCBKLhHa5/27ZCEJWh/NAgPKjIXTromMSerdL2Vl?=
 =?us-ascii?Q?YGsl6EcPlcgAXajZ7IAn6sQjDwFX9OggZvaqgaaaqt4i7gZaQzd4VXNmXrWu?=
 =?us-ascii?Q?ala4DOLWZly9T3ax+hf82r+EnduY9VaoljQdIE3VmTUd8+n5WBR1RmfG3pzz?=
 =?us-ascii?Q?KzTtrfMJNc6cs9OrJqiXqaEILB+wfNWmDpsGOy+foI0IpNrokcrNreXJp+cB?=
 =?us-ascii?Q?Q90KrAjtbf0H5cHyaLt8IJMhc+R355yAobMQvKOlxuwKTpRYAj52iWz3bqB8?=
 =?us-ascii?Q?yxVp5SjWIb0R+vZGwjwlfQaI7Yy36Av4rv7wW2s3pz/j2DbpGwxtKRG1Cj6w?=
 =?us-ascii?Q?Is96t6PwYTpitGdI+CXtVAEZETExVJYcUeFYBQjyZuz01OLHnNTIi2h4hlNc?=
 =?us-ascii?Q?5b2pjBUCKBY8KIAdEoESXE/ev3Zex9JwA/EjXGBD9d7JCWKHKbxLdNiQa6VY?=
 =?us-ascii?Q?O2QpZtMcZJJemnxMhhjp/N0ZGxARNDiS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XBeAg8lKoSTWNxEtbD0sEhCE+bPDnXR4BeWW24ZWCFhaKwiwmTakADcT1iB7?=
 =?us-ascii?Q?vAuDU9ZTl8ov1GiTt1TKu8HCUoEC+8YDV+DDC0wbRK29jEOQ2cnr/pyKvA92?=
 =?us-ascii?Q?IdE95JaG4G8HOlLf7LhNGOEz5clBz4DVxvWDMoSPDgqKohpWJ1kpqXfdPF7C?=
 =?us-ascii?Q?lncAgaAHInuK+lM6myHyx9Mv769EeeXBxyhnCvh2Nq7SkP6nVZ4PHamhY9GE?=
 =?us-ascii?Q?8V1MLG8QCLlZVTz9h+SmSgwrPzcE48LtmOAdh8LOzjI89LIqK/3msj0X6uuQ?=
 =?us-ascii?Q?6bIRCaD/tZqyjABNcLnyBEw4oBSxg8S8AkJM3k5z6wRIHVEmkvB+AfOgbJ8J?=
 =?us-ascii?Q?+S9tbE67USZ4ORo2ksgOF//gQyZouaXhDrl/E/ALM3yH6oGK3jjyBTnRXGib?=
 =?us-ascii?Q?WPgAHAlO3FnAKQ0rhRscDDFdISlE2dCK1WglTKHVgPlOchxPxArGSORdriRG?=
 =?us-ascii?Q?XJDxpWs3byGUvJKFIlpvXasjZYPlko1VFmia7r4BMQUQeMImz0iog/v8bqYC?=
 =?us-ascii?Q?lDHY12P2gaZ+zJ8gBSAwWwGmW4Np6X+Y/NE5NFbu6CrtlFKz8sr0N8q6zogV?=
 =?us-ascii?Q?NSSkLPFP6oErvUndtnPxtz7+i3RJCN6krr+uCDBJgCUazC3Qnr6lWtOo6qg7?=
 =?us-ascii?Q?c7QQiqLJtBqfed1Jt9nBVyVsS2Y38m6Y4cBRhhwEcOXN5rHn/aVlYtEgVkEU?=
 =?us-ascii?Q?7fILVfuhzY9hdJXUYjTV6ZpVOTYwFXu8X4ThbG9ClJdRmpaN8CTAe/G4b6pM?=
 =?us-ascii?Q?EhfkSoBRGHHrl+H1uFg5CxIWVNyFRv29H5zsbdkO+udPxtWrplYzZmm8UQ2x?=
 =?us-ascii?Q?2gvW60NloDBbfBjznrljDpWWSIv0rnhOcsfVauScNyAGecLXMoBvWbCzCWEV?=
 =?us-ascii?Q?oUZREqvcicl6grrdq+SxQ64nNSgv4rm7axrQ38H5xkbw+7Bb6J+vwPhTg52U?=
 =?us-ascii?Q?JIw37ew9i1KjGrl+f0rpFrPp6VSXToL/MT4zhjEJ7Tw0+dBrKs8bN7D6z9cy?=
 =?us-ascii?Q?8a2xdTismi2hSrSt1derqw4uWQKHWETtgqwtii8y/RfLEyxk38j03MVa5P6s?=
 =?us-ascii?Q?eTT5NZLxmU8tYCcXyTqalyWXYaTxfeoStOQ1yQOXuxXI9WhYS/ZVwdSao4Yi?=
 =?us-ascii?Q?tsRcmfxtMfttF1hcSZa1vE0LDfKzySy8sxSsm+y+228Drb/ZPJOC+pAu59Ze?=
 =?us-ascii?Q?mcn0US8K9GtBI37RL/5H0hlqzkgpvGzgVghCkb4It0jaDOY52Ll+MTq6TOEo?=
 =?us-ascii?Q?eDIqX1BoVUv+GhcqH4Zw7bN7ILzMhsLbbnl1uVVAB89mUQN/aQYnUjmVqkSa?=
 =?us-ascii?Q?k0d+/X68RY+Yqm2LPrIxwtch33ew39PGGGbi0Eh4JXmYtHVhRDxwubgA7Wfl?=
 =?us-ascii?Q?BEFTX9NnyVMzlmaZ+F4F3eqgchgXcvMU28ZPsfGogCLFN1Bb06Ftj/mYx+aQ?=
 =?us-ascii?Q?s/pyEOLXwu/vrNacE36gHytGhDxbLWX3LgUXsmKEiiNC5YlF4wDf7zjtpaS/?=
 =?us-ascii?Q?IDwecvKMnJtA01AA/xPBxu4AdU52Ip1Qb2dqG5DX+VtO0ZHVSOS0PuWpOs18?=
 =?us-ascii?Q?+77JWdirWPZ5cQrpkAM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea39c02-5d01-47e7-1f97-08dd5ab5bd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 00:44:36.3445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfUjyz7j5b1iU4NqV8ddnx3/Scd4fQtG1mE1rqH88oj2swOFCzsoUEcjOwSi0cUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

Ping......

Emily Deng
Best Wishes



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Monday, March 3, 2025 5:35 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
>
>For equal case, it also need to be dropped.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>index 7d4395a5d8ac..73b8bcb54734 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>@@ -76,7 +76,7 @@ struct amdgpu_ih_ring {
>
> /* return true if time stamp t2 is after t1 with 48bit wrap around */  #d=
efine
>amdgpu_ih_ts_after(t1, t2) \
>-              (((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
>+              (((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >=3D 0LL)
>
> /* provided by the ih block */
> struct amdgpu_ih_funcs {
>--
>2.34.1


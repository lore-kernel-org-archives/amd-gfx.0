Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E54CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 14:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3626010E7D2;
	Wed, 22 Oct 2025 14:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xFa9QYvS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AEE10E7D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcg9rlow6njrzlriTKtAx61P61nWOVLe0ePnkgHS/0/QSBcMHgS5pLpGEVv0irlsL/wYUzFUZKfAhC2r5ysebdtnnwvodgDtn3Xq5MPY228umzbeVIfh4/r35+yDRYCaYxVHuC+JXu/X2irUDK2xY5pwDm8HvYFtTfrx+PepDCblaS+aDf36xAuyG34MvR1p0CfsbFI0XkZzgOVeyc00tVvEddEO615sYnZB5Cg4GGZMVSQnIiwr6MooUGhzJr4rIF2OBOQL+uvd1YceYNAktNxE23AhoiFymF3qMXd9l7q+KI6jzOoWKWXu14CALTElwDEQTp41VET4xxsYNn7VlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUuyIwmhVa6SjV4LQyrZrX/F+nvjdaLtrwAARRPY90Q=;
 b=tj0ofyLzRJ0veT3CI1V9CzyX2Z3GGpKUkLGLXkZVE+DYXtmreOjWj/+dVWak6JcSE/axxfIKJuI+cI7yGUjF20WxZ+9kxE1yGUw8f6WSGDViPhOEOYEjkqEXocgh57MrUy47iLFfsOqtnmRMzRHGeCA8TrkQSY811/uZfU0msPGWCAXoHoEbHIQIq5SuQAU8iNbGx7E6KZEpDgXIvqMBxBT4Pqro1/XoWsNBlIhj2KbBHzhygz/W82Ft6JwE0z6bxTQ1pYVYhdyzxJkri8MxFF/arcp5UFLxdfzBWsovMRjWLhzm+Kxej3EhLXSCZ+NTqptvwRNgK37fWgiu8WJh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUuyIwmhVa6SjV4LQyrZrX/F+nvjdaLtrwAARRPY90Q=;
 b=xFa9QYvS+IS5rYBIJp04/FSgOBZgyvlwzklo+DbmB6TiqLltHe//fMc8hwY9S8iEYWvQSyzJzc3YXpmoCi7FxGZ6frwEBRpj6eR9BVci7Jndjj+R7x+dzo+wqaGG/PTgfVTTSipcIJhikpZFCNbl2hoJp5DcYrzDdCmTsRai7yA=
Received: from SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:46:17 +0000
Received: from SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::1f8f:b41c:5af0:e621]) by SA0PR12MB7462.namprd12.prod.outlook.com
 ([fe80::1f8f:b41c:5af0:e621%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 14:46:17 +0000
From: "Pan, Ellen" <Yunru.Pan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic region
 sizes
Thread-Topic: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic
 region sizes
Thread-Index: AQHcQ1ij18OezDbinkGTy9LgkQhyxrTOL2cAgAAOLUA=
Date: Wed, 22 Oct 2025 14:46:17 +0000
Message-ID: <SA0PR12MB7462F341902379ABA496826BE9F3A@SA0PR12MB7462.namprd12.prod.outlook.com>
References: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
 <DS0PR12MB7804DB7C24BEBD22E8824CEC97F3A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804DB7C24BEBD22E8824CEC97F3A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-22T13:50:49.9234088Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7462:EE_|DM6PR12MB4235:EE_
x-ms-office365-filtering-correlation-id: e416dcaa-e77a-4383-3646-08de1179c1ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?x9KvJrqBYwlmQgdIWY6ZiLodFqv4EM3/OKIS8CHBhDkgC2467Sl4B0dIjE?=
 =?iso-8859-1?Q?JSbNb/a47/+b5nHKmqB5pui9IiVbW6KGp2UHxwo1Yv/K1pPd5mtwPRSNZE?=
 =?iso-8859-1?Q?VccE6mHY6fVB+bkylAJ8lGfKmkp5CDLEw/VHZcHtt8KtLz0GTCk7hOrztf?=
 =?iso-8859-1?Q?aVDzLKfg1QFJ/BV/TVOKstQzMHqK3oxHVarkSEKw7I5l7AukivyAZAMCiZ?=
 =?iso-8859-1?Q?pcYyC1gXsUAzZgd/XB0zWV1+SV1bRGB5M0IoXYcgN8qTpuS5LtUCAYfktJ?=
 =?iso-8859-1?Q?SHYsxCBd0lMbzgGGefQyMcG8InE810flPcK4W82LkshvEmmlSm7FkLcevN?=
 =?iso-8859-1?Q?yvBcgCdFBJmI62LIED4T10NXpZwvyFbgApwvDowOPh00bZlXHgJpFsU/mH?=
 =?iso-8859-1?Q?VMWo1oAiq00BAzurLQyqX/eOXZ2TOc8IouYpVfcOIsinIj2MqonHHsoq+f?=
 =?iso-8859-1?Q?qZSMSKK9Esd/Lv221F08F4UtANT/cNi1YcE3ft7osMu2/irGadu9oN/4N6?=
 =?iso-8859-1?Q?YoqCZQlH6a6T5TzY7psow/Ep0LCWFyDrNG1lvHOG8dpiakkM+0uYzAa+nj?=
 =?iso-8859-1?Q?DfTT+ZDtODpwlXWjTKpujV5NpMt00bP/psQBGQcW6aWUb5w8ojhw3/etnn?=
 =?iso-8859-1?Q?DmP/ieFaQaFqUN2ybPWZkkcOlZ8XKIMtuaHl1tiVA5S9GFvXNlx9aPAu+g?=
 =?iso-8859-1?Q?4oVox145MvCsnn7Ru4xetU/KvCwlNVueNzNu8dEAbmkfGJT+59D6j6ywDl?=
 =?iso-8859-1?Q?nXOQQkKYHE4fGsmkKhL4EJGeVdVIx2aOvVqOOXs1gz9Yhil++n2OOjF3z5?=
 =?iso-8859-1?Q?6JhrTTLoEgLdfAi5G8DmLYAspK+74OSCcm2w6J4i5zlq57khCIuD6EKf98?=
 =?iso-8859-1?Q?w+3dBvmsSgtoTqIy1kGFtbcSUfBSCvlIlXDhntu2Opo+VE1ytVWC/9+oAp?=
 =?iso-8859-1?Q?ZfGN55zSGn+m7iCG+j2u9aDKbH8PU9UBlQkOlXmbibNSKWOiscTfCDfUGY?=
 =?iso-8859-1?Q?55ltIiE83K4vKH1fhiD6Z4GKsiste0h18mP6GaN1gcj2MdBWqalbvdR0d1?=
 =?iso-8859-1?Q?BtWyK5Vz2p4VzlT2Dbvn+BCGRuqidz3AkEnP/8nLjL7F+zzUXsCDIeT+Kt?=
 =?iso-8859-1?Q?rmMDXbviGlnbmeMfU1LSQP5Cy6OROIkh/ucrV+Sfnx1aLD08XlmEE72qu3?=
 =?iso-8859-1?Q?1l2BGrRqpAy8sXn4dkJPdl3AdBxDFtQksM3Q+kUgUwZTqBIkj9n6CiCNRQ?=
 =?iso-8859-1?Q?BvZNSO8NDToPzSEA1Em8ZkkXJt4WHjy/Luq01tpNoYv52USWokE/vcLfHb?=
 =?iso-8859-1?Q?2aX/xoRT5pGdMzFkjEVNXqayFK2I8gPilkAKhhWw7plthew3mvVqk7YVxf?=
 =?iso-8859-1?Q?69a13sXrbypl9j4A+mvtIwATj8NYgHjWxdf2GBAI5YNQk8dUSJuj7M4huK?=
 =?iso-8859-1?Q?n0RTKW5P+GgvuKaCrOQOJ+Uubd14JfSRpVV+/Bgts+kNzWzbGhx8a7Mjtg?=
 =?iso-8859-1?Q?A4E2uQespaICdRkICe+qNKM5e8aCkaOOnEyg5IiE7+taZMMjTXgvVg8E4S?=
 =?iso-8859-1?Q?8pPx+CURQoos/D2GOaXoJJiQtAkF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?20D1MJnX7nb3GimX9tjK3Aql/UffZpmRxDAGoVGOY5RiSEIkVAXE9bbem+?=
 =?iso-8859-1?Q?7tmUU/gJMA0bvEBU3yA3iWVTQykZjLC1qvoq7Sai4JwD/2Cmh0NfikZxXq?=
 =?iso-8859-1?Q?cFEIKqBqI+VTVc0WA8lLTcPxELKCwKVYg4qFt/96gl6rOvcz1x9QeXK7E8?=
 =?iso-8859-1?Q?bd+qse8zcFIh+zhxQT8L8mhm2LoB+0lNa3X/SKKvlfnPONWBzJR/Rn7W9b?=
 =?iso-8859-1?Q?ImA+bpHpCAAQU3DOCHmyRZ92/fcaZyRob5Q8Gj3UQmugCfHZnxXWDmSzvw?=
 =?iso-8859-1?Q?Bf7B37lLyBRX3b0dgZ38aufWZgRRefs7PyOM1xgKO5NLZ0//IL2i9utYKn?=
 =?iso-8859-1?Q?l7ye1dModpOlQ8LaLs8379ubbR6PAptmQeYpeZmcLw6swCG847iqyTvUAS?=
 =?iso-8859-1?Q?88d1uQC8ChVIEIP2k6gupfFwGGVpPpt33WUfKIHcHrumanoulu/x6GDbdz?=
 =?iso-8859-1?Q?NAITWSR0O0Of5u1x49n1E5z8aQMF3KvORWiiA56psiIOaJ4lbaHprE8u+f?=
 =?iso-8859-1?Q?hPjufvfyHaj4fFaAlNIDJWCJ5guDXWo+5dO21T5QjMMMnOjI2KzWcJ7ShV?=
 =?iso-8859-1?Q?YYxO5KzEKv3A6GZFf/ZZNlaZIM4XW8/77nG/2kZrzj5gpwLkoyG5+v+5e2?=
 =?iso-8859-1?Q?GGvS9J9QGllfOExvfpB9YzoYadXCUFxEJ4EwOj9jifiF+bQf4VgqZ9aHnP?=
 =?iso-8859-1?Q?mc8NtR3Js9GNM7fv8Vf+CkaySJAN2vmNgdtf0IdiyfLMi5vsCLWLPh+6Y1?=
 =?iso-8859-1?Q?JnwuPyc0OBsOVjKvAz/O0+keKLueRqHz2T4wcLpUZbrL5qDrc0f/l73YOf?=
 =?iso-8859-1?Q?HMEJ+p4JDjYu7S5vDtu6KpDL2buayx25xJvTae9v/i1BhJ1atx+xixThsb?=
 =?iso-8859-1?Q?Lrepy4E+WnaNXPJjBgaAkCPmPSlPqlFnbwUL+i8cEQSFtIM8hYy/xB5xCQ?=
 =?iso-8859-1?Q?rvZMcrOqKh5hjhHvH2Mdwb38ETEmCmbGwGmbwsb4wsfaEIYmbf4PkOmSS+?=
 =?iso-8859-1?Q?E052AdHqK8Hi+EciOusGGdrRuBj+zG25UQTFO/Wn42dPtfMo1ci7VHE91f?=
 =?iso-8859-1?Q?/fd/k7VaiKkrkuAsjY8S3vzQkut63bfkHIpyocEYM3TpesK/wNeRW3xnvP?=
 =?iso-8859-1?Q?+aJKr4KF8T/R0888AjC5UziG2Yc60IujUOYmt1rdN9j/tPqyxeSTcmFqZ8?=
 =?iso-8859-1?Q?8qV9325MR2uMn4obvbob6RCUOJbFYjJun3Tl1XpuSBHYDy+iDIZS4VpbTC?=
 =?iso-8859-1?Q?N1CVkfCwwMQ8KkrnU4scUFTBf0WKtrtCZU1+aOvCUszJsUxvc5d5tNRfQ6?=
 =?iso-8859-1?Q?ng3PT1ce+zy3759S2bEA5Ydxh7vnfd+WdwrT28SA4Huah/VavE6rsmzE/s?=
 =?iso-8859-1?Q?fbNdAh2fT9plFYVLwAPKxSGzdnzSbnDaUIGsstzNfZXIamXYxIsSwloldw?=
 =?iso-8859-1?Q?z3MImtn4W+SC9u1CsYLVEhD1kX38pBWE1WetSdsJ4TlOpafxM3i4oxU9oR?=
 =?iso-8859-1?Q?b9/5A/Aa54ui1zJVoryM/1hrIMXaOAOn1iQp5+efQkNe7kxIcEjQntM1LX?=
 =?iso-8859-1?Q?dDdcH97KdmyPkzJd7FC1G1nfRRwdL5I4WoUqDIJBcK1nxhrig5Kzh2BcbW?=
 =?iso-8859-1?Q?m9MP0qymkyoSQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB7462F341902379ABA496826BE9F3ASA0PR12MB7462namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e416dcaa-e77a-4383-3646-08de1179c1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 14:46:17.5127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvjZNZK0T3OmxXLuUt6Y0W5vMEc+aq+XYaj9AlkQZUyPYBt/YwfNMVaDCX0w9FO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

--_000_SA0PR12MB7462F341902379ABA496826BE9F3ASA0PR12MB7462namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Lijo and Sri,

Confirmed that no larger size than u32 is expected for dynamic tables.
I'll update the patch and send out the fix soon.

Thanks,
Ellen

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 22, 2025 9:52 AM
To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic reg=
ion sizes


[Public]

You may change the function signature to u32 *. I don't think any table of =
larger size is expected. Ellen, please confirm.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Srinivasan Shanmugam <srinivasan.shan=
mugam@amd.com<mailto:srinivasan.shanmugam@amd.com>>
Sent: Wednesday, October 22, 2025 7:04:25 PM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuc=
her@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; SHANMUG=
AM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com<mailto:SRINIVASAN.SHANMUGAM@am=
d.com>>; Pan, Ellen <Yunru.Pan@amd.com<mailto:Yunru.Pan@amd.com>>
Subject: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic region =
sizes

The function amdgpu_virt_get_dynamic_data_info() writes a 64-bit size
value.  In two places (amdgpu_bios.c and amdgpu_discovery.c), the code
passed the address of a smaller variable by casting it to u64 *, which
is unsafe.

This could make the function write more bytes than the smaller variable
can hold, possibly overwriting nearby memory.  Reported by static
analysis tools.

Fix it by using a local u64 variable (tmp_size) to store the size, then
assign it to the smaller destination field.

Fixes: ae92010fb321 ("drm/amdgpu: Add logic for VF ipd and VF bios to init =
from dynamic crit_region offsets")
Reported by: Dan Carpenter <dan.carpenter@linaro.org<mailto:dan.carpenter@l=
inaro.org>>
Cc: Ellen Pan <yunru.pan@amd.com<mailto:yunru.pan@amd.com>>
Cc: Christian K=F6nig <christian.koenig@amd.com<mailto:christian.koenig@amd=
.com>>
Cc: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@amd.co=
m>>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com<mailto:sr=
inivasan.shanmugam@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index db705bf723f1..eb7ba7c593bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -104,6 +104,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)
         uint8_t __iomem *bios =3D NULL;
         resource_size_t vram_base;
         resource_size_t size =3D 256 * 1024; /* ??? */
+       u64 tmp_size =3D 0;

         if (!(adev->flags & AMD_IS_APU))
                 if (amdgpu_device_need_post(adev))
@@ -126,10 +127,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_=
device *adev)
          */
         if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabl=
ed) {
                 if (amdgpu_virt_get_dynamic_data_info(adev,
-                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bio=
s, (uint64_t *)&size)) {
+                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bio=
s, &tmp_size)) {
                         amdgpu_bios_release(adev);
                         return false;
                 }
+               adev->bios_size =3D (resource_size_t)tmp_size;
         } else {
                 bios =3D ioremap_wc(vram_base, size);
                 if (!bios) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index a7cb4665f485..87f024f72a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,6 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct=
 amdgpu_device *adev,
         uint64_t vram_size;
         int i, ret =3D 0;
         u32 msg;
+       u64 tmp_size =3D 0;

         if (!amdgpu_sriov_vf(adev)) {
                 /* It can take up to two second for IFWI init to complete =
on some dGPUs,
@@ -311,12 +312,13 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
                          */
                         if (amdgpu_virt_get_dynamic_data_info(adev,
                                                 AMD_SRIOV_MSG_IPD_TABLE_ID=
, binary,
-                                               (uint64_t *)&adev->discover=
y.size)) {
+                                               &tmp_size)) {
                                 dev_err(adev->dev,
                                                 "failed to read discovery =
info from dynamic critical region.");
                                 ret =3D -EINVAL;
                                 goto exit;
                         }
+                       adev->discovery.size =3D (u32)tmp_size;
                 } else {
                         uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;

--
2.34.1

--_000_SA0PR12MB7462F341902379ABA496826BE9F3ASA0PR12MB7462namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">Hi Lijo and Sri,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">Confirmed that no larger size than u32 is expected for dynamic table=
s.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">I&#8217;ll update the patch and send out the fix soon.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif">Ellen<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Wednesday, October 22, 2025 9:52 AM<br>
<b>To:</b> SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Koen=
ig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN &lt;SRINIVA=
SAN.SHANMUGAM@amd.com&gt;; Pan, Ellen &lt;Yunru.Pan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix pointer casts when reading dyna=
mic region sizes<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">You may change the function signature to u32 *. I do=
n't think any table of larger size is expected. Ellen, please confirm.<o:p>=
</o:p></p>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-boun=
ces@lists.freedesktop.org</a>&gt;
 on behalf of Srinivasan Shanmugam &lt;<a href=3D"mailto:srinivasan.shanmug=
am@amd.com">srinivasan.shanmugam@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, October 22, 2025 7:04:25 PM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; SHANMUGAM, SRINIVASAN &lt;<a href=3D"ma=
ilto:SRINIVASAN.SHANMUGAM@amd.com">SRINIVASAN.SHANMUGAM@amd.com</a>&gt;;
 Pan, Ellen &lt;<a href=3D"mailto:Yunru.Pan@amd.com">Yunru.Pan@amd.com</a>&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic =
region sizes</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">The function amdgpu_virt_get_dynamic_data_info() writes a 64-bi=
t size<br>
value.&nbsp; In two places (amdgpu_bios.c and amdgpu_discovery.c), the code=
<br>
passed the address of a smaller variable by casting it to u64 *, which<br>
is unsafe.<br>
<br>
This could make the function write more bytes than the smaller variable<br>
can hold, possibly overwriting nearby memory.&nbsp; Reported by static<br>
analysis tools.<br>
<br>
Fix it by using a local u64 variable (tmp_size) to store the size, then<br>
assign it to the smaller destination field.<br>
<br>
Fixes: ae92010fb321 (&quot;drm/amdgpu: Add logic for VF ipd and VF bios to =
init from dynamic crit_region offsets&quot;)<br>
Reported by: Dan Carpenter &lt;<a href=3D"mailto:dan.carpenter@linaro.org">=
dan.carpenter@linaro.org</a>&gt;<br>
Cc: Ellen Pan &lt;<a href=3D"mailto:yunru.pan@amd.com">yunru.pan@amd.com</a=
>&gt;<br>
Cc: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">chris=
tian.koenig@amd.com</a>&gt;<br>
Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander=
.deucher@amd.com</a>&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;<a href=3D"mailto:srinivasan.shanmu=
gam@amd.com">srinivasan.shanmugam@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-<br>
&nbsp;2 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c<br>
index db705bf723f1..eb7ba7c593bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c<br>
@@ -104,6 +104,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t __iomem *bios =3D =
NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t vram_base;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t size =3D 2=
56 * 1024; /* ??? */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp_size =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp;=
 AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_need_post(adev))<br>
@@ -126,10 +127,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; adev-&gt;virt.is_dynamic_crit_regn_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_virt_get_dynamic_data_info(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev-&gt;=
bios, (uint64_t *)&amp;size)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev-&gt;=
bios, &amp;tmp_size)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_bios_release(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;bios_size =3D (resource_size_t)tmp_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bios =3D ioremap_wc(vram_base, size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!bios) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index a7cb4665f485..87f024f72a59 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -275,6 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 tmp_size =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* It can take up to two second for IFWI init to comp=
lete on some dGPUs,<br>
@@ -311,12 +312,13 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
mdgpu_virt_get_dynamic_data_info(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_SRIOV_M=
SG_IPD_TABLE_ID, binary,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint64_t *)&amp;adev-=
&gt;discovery.size)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_size)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;faile=
d to read discovery info from dynamic critical region.&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;discove=
ry.size =3D (u32)tmp_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;<br>
&nbsp;<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB7462F341902379ABA496826BE9F3ASA0PR12MB7462namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DAC27C77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 17:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5011910E16C;
	Fri, 14 Jun 2024 17:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZsfWOpUW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0237910E18C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVreFmUzepQIXWox4YLmfOh2tL90pnjhFWUnB0VDma5gKURH2mlpptYj/DwuPlTx+g4NdJZcrN95gm4gqGAxAPlOhWqf8tTBL3Y8kYjMepx+TFVa3IAow8xsdxhmkKkqzi9u2StGbpYcaUJo2JueNgKdQruLcPRCerADZ9JlTt1OtbiHq0YoFLLw8tXeaTf8AIazo2r4P8K44v44fm3QCQvJr60rNDlbKmthgHGDHQ05sYMJfFJXZIfSTt6kI9EsY2IGBT/TJ61Co/JnuNc1rlyYzTymZLL8XUiQVb058nDycZR9DKyc/BCMpYFFTtldzjsl6gHbBbNZdDwpPqDxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqJls/GdU0Cpm7p77Az+hlSrvNv+4jcXRiON5y8Kt3I=;
 b=Q3lqyN9jgjaq7gQVOYubJFflwx3FfZuVNjVYTJ0ZOOPeWbDYFC6wQjBbIoLgRpDYvfiip1sYOmoa1uX8PEZ8OB+pEUlO4oIXkTIrGeB9EOvYka4E+C5Lkkprn3He72hnUbVathBFmtpYINzYgNklDnX1UHdV+dui7rMdiDs62LiiBjCserOtAtLXms5eePmDJxPm+ayXQrpCD/kNpRjH6HnD3Kwg1vIcG/9l67Vi1KDEtNWRqJIM4PAXXj0+8sL8YsbAsTcToN1gMascAWvOEhUSya3T+vx0rH1VnfhPwdRoOAE2XJ40zJ7ItzAPWJIzhkPVTRn42lQVey5S59E75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqJls/GdU0Cpm7p77Az+hlSrvNv+4jcXRiON5y8Kt3I=;
 b=ZsfWOpUWYf63xnUsipC8tlAVUqXz8SGfJtWOdgYvCs6Qx/dtRE2Cmw4JhbJ3nhc70el97RKvYtwQzXCE+Jp9XgHhGan9gEF6DP+i9rWMVAHSaWq5Sp5FmGRb+SfT8a8a1mOrLlEZzt0+uvgC1NOyRi1D8tpAj389u14cMNZec0k=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 17:27:30 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 17:27:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tasos Sahanidis
 <tasos@tasossah.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/pptable: Fix __counted_by attribute
Thread-Topic: [PATCH 1/2] drm/amdgpu/pptable: Fix __counted_by attribute
Thread-Index: AQHavn0qHmZTm415GEmB6YE+OQi25LHHgX0Q
Date: Fri, 14 Jun 2024 17:27:30 +0000
Message-ID: <BL1PR12MB5144E39613C41A0A1E79BBEAF7C22@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240614170551.6195-1-mario.limonciello@amd.com>
In-Reply-To: <20240614170551.6195-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=46f15737-2730-4c0f-a7b6-e9ef3812c848;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-14T17:21:12Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8070:EE_
x-ms-office365-filtering-correlation-id: 1699abcf-b9ed-471e-d786-08dc8c974520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ov2a8/k+NgfmjMWZlnZItnFToDQk4PfvFFFij3RUyox7+dzOkNasvEf1VZDp?=
 =?us-ascii?Q?mwVxxnQkhsMiEsAb5g8TYFFflT7lqzWg6/qyR89aMC5GGXu4IpxZp+Za7m5c?=
 =?us-ascii?Q?iFdKYgasby4V52PhdqpGsN6H7qfVelqoy54mRw6YiwsltJeGEN/7sBijLYuP?=
 =?us-ascii?Q?BkpDGUEPhTc5mLtVIZ6oB4BKsDOHqcDyI/E1TMUT/dZAcOIioMiXTZUKhiHI?=
 =?us-ascii?Q?N40ePw3xI4pTLUzpOhZ9LfxukuqO3/+vOim+3xei8NbDA5ucPzRQVYPQ/4ji?=
 =?us-ascii?Q?HIkbAO6q7kV17QQYGGVzrvsRmeGVIsKTEH1hLY12FoMPXQsGSokPBpsPDCA3?=
 =?us-ascii?Q?pRiRfJjWOvJuJHfHpanBBjj4qPC8vWpFPZ1dEiyeG95EFITvMuopm61r6yW3?=
 =?us-ascii?Q?/Qm1RknLS/wy8VaEobVm7g2Ugt58dSkyfffFK55GGKlCCE84cZhhf87wdH4j?=
 =?us-ascii?Q?evzsC2s4wEyaRWvQ6SxKic8lMoRd3jnJvPD8gFA3tbyIVEqelaz4ATUTZYmu?=
 =?us-ascii?Q?40l3/pew84NHINCVD9zfm0kzxJSB3rxd8z1m/Pk/3JzOKxtk2elK8N5Hioqk?=
 =?us-ascii?Q?NgETHMwvYdxPi7uG7t2nssjIVv6WpqNwXazWqfU5DyTLCYKolbOb+OrMEf3r?=
 =?us-ascii?Q?py0QG/Ipoax5Zmv7C4d5mo+yiRp/uBs7Nwww1q85rlUKG3ZQhQ41L0BNd1zb?=
 =?us-ascii?Q?rijnGmJ/l4w/sDoWuyhwXfaxlXm52elE3o0+qZw+FuMvTjetEcHk0oIIW6f+?=
 =?us-ascii?Q?A1V9v8F5knS30FXUJgdOBQymUDkP2ECezxuQYmdrT61EmLQrrKuPSWfOEqqW?=
 =?us-ascii?Q?t4PQEnnMoQKOLylw1oY2qPspRImkBD4r9C525oBaR2UID2CBr8Lkm8A6mYJX?=
 =?us-ascii?Q?hnk0xLUQRtrCzFbBa9MPC8WsEYARcb3vIAbpSwbgRFyZLeal+p4n/yKu6dMy?=
 =?us-ascii?Q?R5YdRjbXBwnThv2gw0Ud90BKNkXM/ocsQkt/S3C5o9KthT5EE3OKjm3Awwr+?=
 =?us-ascii?Q?ft80carG3Wc7koU0WUqSoeGT1dml00liv1UP4jTCrruOHoItnv43prM4GByj?=
 =?us-ascii?Q?vDnOOvxTWnoJn3eHWKm29K/4An8vY2uKUsXtozodmkyf+4Nu3T0t8I2n/a5a?=
 =?us-ascii?Q?G+V8xfGZzJlVnsH+wfDu/HEdgWUf55bbv9qwb4FbFcxr6TnW/Crb7fOrgrI7?=
 =?us-ascii?Q?ucyBYWfaD+KwgILUHRRlaoP9qnj0uNs5apfS9uS/Wtg05K+6LbHxD1MvR3w1?=
 =?us-ascii?Q?BRpd8RQ7XjQYyDGXrfWkc81gztWTqrG7KNxX4cpXknc6N8yG3i2e/oQXcE3y?=
 =?us-ascii?Q?iCQSkmabcaF0O0LnmDCJ3ntx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hl5MJadquKIhRAFaaT/VupT/2RYts0Vy/Ed8ZTLsqa3sT9+4uiBtvcL5ZWte?=
 =?us-ascii?Q?q6HX9gMSuv66zSAlFdd1V4e9GBtNXRYAzlJUsVXAvq77Y8w/qraKjUrdE0Ed?=
 =?us-ascii?Q?xFyAE1zsttsNcxGBWOi9tiardwsIVC9VfjZal7XHWYskVd/04OxBou5NV6sJ?=
 =?us-ascii?Q?YNi3RPKu5Zbe2aiiC4XgqMCZuvgDfr7X3gaqmJlwMBjXvB3RKfYBySl8zcEw?=
 =?us-ascii?Q?n9Ifd2etMrQZe1rqfJRijmmiG0K6Y78/TqNePNQrfcfgQfLJrR+q9tEF2Rbg?=
 =?us-ascii?Q?2Efj3BwPcWa25p2Ko5xI89UPt/WoqDZ2tnwPIj2cZFwxHVFS9eMMF5FoNUjN?=
 =?us-ascii?Q?y0g2joqJiQfz5CJzW873j9EHV2Y7C+EoegBpykobL6y0GXnSA5Xx6s6CrwCm?=
 =?us-ascii?Q?SLtAVcskxyF04BUflELgaHL0aLRsFy+YZU68MbkHV6insRe6xhdSLXfuVuKy?=
 =?us-ascii?Q?M4nWyuVnxmtp2B9eqTO1gez6qgqQn+r59EzoNS4mIu4D3iffrJC5yyY3JLIn?=
 =?us-ascii?Q?JKSyOmTqJU37vfU8mqlLUwsou/Egd/+UXIjpjcXI8bpUtxS70AciPHX3aoI0?=
 =?us-ascii?Q?UFmE4zYi9bYV32ueHCM3GtB7DSV1ELqUcZnoUum+bNBOPoxRrv6Zgp3ZbZEK?=
 =?us-ascii?Q?S1Dp0AOHus+8hG7SbeJS8ZqIAJJ96pygUEE+OJaZcZug0azav7mgqmpKlYt9?=
 =?us-ascii?Q?8wi8QU8v3ps2uy6gOY5R0BgZFxW9ULlCU1mHTsQ8X+IMcq/xl8qJxmpJFGS/?=
 =?us-ascii?Q?dRJYIZcqaXV1lahadE/mFhgv+Mii+HRRKfET62WRVfghVQ7lVZfvTPhPJQrq?=
 =?us-ascii?Q?PFfrXxUfpF7qvqy0vY2aSUJT2kXknkOHUrnzgXNMT6hwIEQCW5Sp8vXTjc41?=
 =?us-ascii?Q?8SL8w3Bzd90vppge3f4uTVWm/zFM8FsFLORP2OWmSQ3aTjb6oYQwts4lVOsZ?=
 =?us-ascii?Q?t9yn/B82k5hkQTISaDIU3mAcjNanzbWcFS7tqphd7uveZQH4OClSionK/pX6?=
 =?us-ascii?Q?N0oCkrXyyMJuPJMueTDQf5yshgw1Ym+EH6/2s1Vkpl0xCJFAMJ6aFlwW1zna?=
 =?us-ascii?Q?FucThQY34sIdmHLctY6aNLv7dzr5RU2OaxQBwPgiNMxy1roPzJCNFSxI1+xH?=
 =?us-ascii?Q?kSvT19VHCudl6TTaYNXVo6Ohkp5ICEQAKm+0/crM8HpRudWzAs/W7mI5znFH?=
 =?us-ascii?Q?xKB1rzXTT2GtTrgT7r/d+YQmYlW+WUV9fy/DEplHTqqTVTrkqu8vFdkBrWVY?=
 =?us-ascii?Q?MDQDTRL77M3xrwomA1yTtRSZa9F1XgFuwe0BaqLUnf57/95TnSERsNC8r6qB?=
 =?us-ascii?Q?c3NQjQnknfWrlVVdtNkG4cNKP3DNFOuzhsiDvebhMHYoM7DEHaC6M2Cp0749?=
 =?us-ascii?Q?3s74+MSaPN9pAOrw+S906ovltF9zuzxG/sLXpN0/+ScDvK7gobNrh9BQw7e+?=
 =?us-ascii?Q?zO+XBw3fQngR2jm6LXAWgRKizGciROtP/Fr0du2f140y3L1LLjUHu2kQzwFu?=
 =?us-ascii?Q?AN66ljNaiYMcItiwAPV+59fpLN87iH1BR5vLrifDyuhjBuYTJmitQs1hobqo?=
 =?us-ascii?Q?3ILCMUZcLjd99WCVU3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1699abcf-b9ed-471e-d786-08dc8c974520
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 17:27:30.7314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOVDX8UnzIak0EcVdxbJizkDKM8JVCxqakclL3S+JEj3AeRXVNhKFmKyjS58EX9PC87N7np1qFjFCuKkpKEDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Friday, June 14, 2024 1:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Tasos Sahanidis
> <tasos@tasossah.com>
> Subject: [PATCH 1/2] drm/amdgpu/pptable: Fix __counted_by attribute
>
> The attribute is not helpful if commented out.

It's commented out on purpose because it breaks clang 19.  See:
https://lists.freedesktop.org/archives/amd-gfx/2024-May/109223.html

Alex

>
> Cc: Tasos Sahanidis <tasos@tasossah.com>
> Fixes: c6c4dd540125 ("drm/amdgpu/pptable: Fix UBSAN array-index-out-of-
> bounds")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/include/pptable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h
> b/drivers/gpu/drm/amd/include/pptable.h
> index f83ace2d7ec3..984770d0eb4c 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -480,7 +480,7 @@ typedef struct _StateArray{
>       //how many states we have
>       UCHAR ucNumEntries;
>
> -     ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
> +     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
>  }StateArray;
>
>
> --
> 2.43.0


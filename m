Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D92C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 02:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D8B610D0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 02:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09D8B610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4857B235;
	Thu,  4 Nov 2021 02:22:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64B97B234
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 02:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5WNo3+rZ+vbkRBGjZWDDabB8CXXFhwA2C72x/anJo4CtFdNXKaD7slBX8P/ASVbLv+HVg74cwnD76q3f8oxJIMZ8JFKsGOY6UmJrkkAzxC8bbVQZPBa0tvginW63xBRfc5ECeyNNJ2O3t42om9/bjlfpjJNY2/8YdkIwk1MS+Le0Y/5y8nIDvAdVz5H2/ka+8B1Ok02bNMgOnLQ1YgvHJels/3UfBHuAhh0n22rsKDLBj9yF+oJBWiJ3dXWkQ8HjUwTR0tzB2948scQfnaJtcidpJ5deb3auyQ8O/YP2muIbFHUC+BvcK9FdnlEn+joELxihlK97W5XkE1I8mWxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bexLLjIq8tWtt3cfa3oKzdSwAyOKwMLAdTT/Kj5CyQ=;
 b=nKoUn/8iOyipVSowLcwvtg+u20MNz1lOGy2pcH5eY/uvoDNrkHxZljvwY9tJ76e5iLBkKjsxksaCY3Vp7picQkRXksWiVh/OmGwkknyi4BBRS94QrTJpnkINANlhtP/DNrwtCr/CDEIxiPxeo2i4uccQ6wcrgNWswBT3tiTU6mbZCWqpFbZ893fX65Bjb71L/pO82agYkP5H/umRT2+1vMbgrt/a/f+L2LoL2c94y7LpOnV+emLZtiujAyyGs+aEU7m11jJbnUlL12ACvDRiugwExOQZPkkLGk2Zz9a73RgjhaIltLxRwCLWuxeUVypySBe0HusYJbw8rctZmkC5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bexLLjIq8tWtt3cfa3oKzdSwAyOKwMLAdTT/Kj5CyQ=;
 b=4jcrp4PujII3WqZYSvsJsfxLm3C1pAc01RO2F8w82e4e1EZA3zxs1RWK5DwKNGI+HaWS3i7iLxBGzUPCqpoPNI8xTn+T14caDmx5rQLGcwG0tfEly+ud4jz9gILLZBWL0OMP2DoP8idLMzHgqNR6QUmbJJ6FtTlwSk8WMfiOXd0=
Received: from MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Thu, 4 Nov
 2021 02:22:45 +0000
Received: from MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::f1a9:d26d:13f:80d6]) by MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::f1a9:d26d:13f:80d6%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 02:22:44 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: fix sysfs_emit/sysfs_emit_at
 handling
Thread-Topic: [PATCH] drm/amdgpu/powerplay: fix sysfs_emit/sysfs_emit_at
 handling
Thread-Index: AQHX0RcupXCSTsAJQEuYnCKTQwiGeKvyoEFw
Date: Thu, 4 Nov 2021 02:22:44 +0000
Message-ID: <MN2PR12MB4256EA15E5E9B34ECE34E3BFFB8D9@MN2PR12MB4256.namprd12.prod.outlook.com>
References: <20211104005852.2454705-1-alexander.deucher@amd.com>
In-Reply-To: <20211104005852.2454705-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-04T02:22:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=56f40a09-2982-47f4-a495-070693ff8645;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a8042a-5adc-469b-4d10-08d99f39fc83
x-ms-traffictypediagnostic: MN2PR12MB3870:
x-microsoft-antispam-prvs: <MN2PR12MB3870966AB9E8336D2CAC999FFB8D9@MN2PR12MB3870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qMVkms4L/T7FhWfIGqHInx83m8HpQuhSQy3v8FrEFsQHyTg/sdjLZ8ABqTvElKiO4UZ34oBS2TE6wm1Nmhh9VaWMbWFyKCJJhD1Csx48aQnP7SFWhJqq9Y7Hib5FyevCzVQbhPoBtVpzyXHDgJkBJ6nM/jfci82VKPaZltD3FhfJI+L5uq/67jmg7GmtRnrKP0GKa+bgfGs7Z9g4LrxoBdKpBNe00Imvt+3obqSwI2ePLtmaGU2pFjd+Q5CHReI+KdqWi3aqMgMEicTVQWx80lQmTEwOypFmosH5PjF4CTWqmz8SGmLVKIENYx5ZzB2xgsy8v/TRKsktgzfzy1b3seR4t7BpWQCk2q7LRrbQ1iPLg7FqyiVO+V9QpR1h2Z39UZQ43VhEfZbo3wl1c/ODZIxihO8sYvYk+JN7Qckm48ArZU92VEJZX1Zxz3rFYUgSS7UOK0hjN5ZKZ6v5zakk8SqvRN3+XJSdmP9eo2qDVxfxYeNFk9iZWQVEI0GpH1AUTUd7H3VF5cMfFqg8Z38Xga5vDG0mJ5p2foZbTjX8NlX+smwLb30ms1zK+mu4HTCTELBFy3HdpLPEQBavR+8yUTUIA76IU1VfyCgG0BjM36ab+ve5U64BhVcpKcUruzwaLjPWM5djmnmmVPqLlkJt89wo743IGlLGsJ/otKFuVEXacaf5sHzmn0GavaIzl/s5YEHmg3ysc9q3igP9Gz1+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(38100700002)(7696005)(8936002)(30864003)(110136005)(83380400001)(316002)(8676002)(966005)(55016002)(9686003)(66446008)(38070700005)(52536014)(2906002)(6506007)(122000001)(64756008)(33656002)(26005)(5660300002)(71200400001)(4326008)(66556008)(66476007)(86362001)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2PMca71dNBp7pLYVNAqMpGXv8/Fq2dnb0ngOZDndNH0rN8VkbKCOWq6bbkXK?=
 =?us-ascii?Q?dAG9kIv3KU8/idnOLcye7Ac1SmlERJ4uy/J1/lmiIl9B64LoTsLi2vDOvZEF?=
 =?us-ascii?Q?LewnBEWsMAnnXOtjoufDOcNFuuwFAmBeKSjMSQnha67Y+Qsl6oDmxHsFuShO?=
 =?us-ascii?Q?XnF40BgACfgvrjdHs9kb79hFWMb2STdFRMquf+w8/HNN0wpK9oVTsKEQEUKs?=
 =?us-ascii?Q?T7A8ZVsZVWmh19WWd5dD+ifQ9E9Fc077SIXRhoqSB5EvWeui4tYYVPLzveUj?=
 =?us-ascii?Q?emOgUVmkws/vXthYT6hifoCPxJ/HTqEACoatJPDO7AJzXQWH5b4Sbk5jpxx6?=
 =?us-ascii?Q?UjItFAhBfPI31yUVa0ZYUpN9+7b4gvBFes+PEi5HXr5m6DYVNtHD7cffNvKP?=
 =?us-ascii?Q?XwoAz5cwK/Q4XzZueqGtDYc2AErEHmu3f+xmjT5gnPfJkE2hzD5Ahivlquhv?=
 =?us-ascii?Q?XJBNjayCOnicm90tGht96jGQKT4FG849X1rCri2BRHJ7ONUHX/Ydli2Z3N3S?=
 =?us-ascii?Q?1qa36n1A8zOYj+qdo/X8Gw2AgMQY2Ne0yQ7ZBbCs/xjc8mwjD5jiCULhYvFW?=
 =?us-ascii?Q?i37ISBPTKYCbokT4A5FCgRqyLjVeEU6EnToF6ySID3SXn3MBcXLag9LcyOuS?=
 =?us-ascii?Q?wQHR/iRz84OJIu1JMjH76lOJf2l8UdePxWe/cUVVFh8+hHEhwQBRHzN2fw1O?=
 =?us-ascii?Q?0lHyoe1kD1S/3nBy2zRNJw6CncU4/FCKfNHfql9wLc2QdDKSjNhGimIECcY0?=
 =?us-ascii?Q?rq1PNPMUh2RBqK21Rdy5j3fKENUqxtZ6I+lwVPjOR5bwsb2iG3KBu9M/DdQ6?=
 =?us-ascii?Q?karlrXkqP+tipm9GUqtv7ENKe/HglqjI7+oynPCY+iD/3SO0UrxftKqye1RC?=
 =?us-ascii?Q?C5jp4p236VM4T4ZExi0RfJd5LC5SSV9ipEwuHqS8G0zxBCjDlAUmgY4oNkff?=
 =?us-ascii?Q?mwGRSPt9OULNCvtN4QZRsFWLypy4DoCJUoQLnywmTB94+gNVSqJFBSDwSJ9u?=
 =?us-ascii?Q?s8FJd+OjoU8D9ZtJBmAYxcBp7WlEbAtWv5oNCZARWTSfR+c/eJvSiS1Kadpb?=
 =?us-ascii?Q?6s7zs3QbeSR+WyNrIHIqIjeeviqhcarU5bFm4nZp56JhMY0M6ioJbxoFcNk2?=
 =?us-ascii?Q?FurdfRqvPR92N+IQ0oPCENad61+PQLc8jhtr2yu+x42x/pdq1Lkc8B9QGd04?=
 =?us-ascii?Q?cbg6VJVEiWa8usCEmYnnI81KzOYOLj/SuJBXqm3lHCAJ8A9Cnq+ELZiCsvzy?=
 =?us-ascii?Q?mdYwS4yL/2OEaBHChFCr20iLqD6bJqtc5/ZBBlWABdY9QJJiQs1eclAPdEMm?=
 =?us-ascii?Q?+yitWhPt0x9iFRGIhXOSrTSSWoH8teS3ACSFLJGTvcpH++4cMmA6dBC2kOMR?=
 =?us-ascii?Q?LkgbywVgYaxBqbcyu8FPbC64r4ZVyDQEOQoqbRBuWynfQ12DbVwDIeu2KkI/?=
 =?us-ascii?Q?X/WrylAnhSErH1B1rk/4//iqSN2NSdJvNMHxSVmPMX25OtZ+40ML8UHX0FAS?=
 =?us-ascii?Q?/656/xHt6I4uugcV4ulf/r5wn+WgusYYwGQY+n80H8PuaykrrH4Sq4MfHyBp?=
 =?us-ascii?Q?yr8PeqB0Q5ymaCGkg2crrfOuIA99QB2UE8exdjLoB0DPkfqP3TI3MzqrW35G?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a8042a-5adc-469b-4d10-08d99f39fc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 02:22:44.6209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vn8P8J6m6BvTBPj7pv2PrAPB5ItZsRiJmZ8k/9vQkiboS2Z+mun/sOL2wNAASuMSlbv8lWGgNPW2AhUnrcbQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
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
Cc: "Powell, Darren" <Darren.Powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Yes, I missed such conversions in powerplay. Thanks!

Reviewed-by: Lang Yu <lang.yu@amd.com>=20

>-----Original Message-----
>From: Deucher, Alexander <Alexander.Deucher@amd.com>
>Sent: Thursday, November 4, 2021 8:59 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Powell, Darren <Darren.Powell@amd.com>
>Subject: [PATCH] drm/amdgpu/powerplay: fix sysfs_emit/sysfs_emit_at handli=
ng
>
>sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf address. =
Make
>them happy!
>
>v2: fix sysfs_emit -> sysfs_emit_at missed conversions
>
>Cc: Lang Yu <lang.yu@amd.com>
>Cc: Darren Powell <darren.powell@amd.com>
>Fixes: 6db0c87a0a8e ("amdgpu/pm: Replace hwmgr smu usage of sprintf with
>sysfs_emit")
>Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1774
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>---
> .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  8 ++++++--
> .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 10 +++++++---
> .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  2 ++
> .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h    | 13 +++++++++++++
> .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++++++++---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  4
>++++  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 14
>++++++++++----
> 7 files changed, 51 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>index 1de3ae77e03e..258c573acc97 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
>@@ -1024,6 +1024,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 	uint32_t min_freq, max_freq =3D 0;
> 	uint32_t ret =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		smum_send_msg_to_smc(hwmgr,
>PPSMC_MSG_GetGfxclkFrequency, &now); @@ -1065,7 +1067,7 @@ static int
>smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
> 			if (ret)
> 				return ret;
>
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_SCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> 			size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> 			(data->gfx_actual_soft_min_freq > 0) ? data-
>>gfx_actual_soft_min_freq : min_freq);
> 			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n", @@ -
>1081,7 +1083,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 			if (ret)
> 				return ret;
>
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_RANGE");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> 			size +=3D sysfs_emit_at(buf, size,
>"SCLK: %7uMHz %10uMHz\n",
> 				min_freq, max_freq);
> 		}
>@@ -1456,6 +1458,8 @@ static int smu10_get_power_profile_mode(struct
>pp_hwmgr *hwmgr, char *buf)
> 	if (!buf)
> 		return -EINVAL;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	size +=3D sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
> 			title[1], title[2], title[3], title[4], title[5]);
>
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>index e7803ce8f67a..aceebf584225 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>@@ -4914,6 +4914,8 @@ static int smu7_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 	int size =3D 0;
> 	uint32_t i, now, clock, pcie_speed;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		smum_send_msg_to_smc(hwmgr,
>PPSMC_MSG_API_GetSclkFrequency, &clock); @@ -4963,7 +4965,7 @@ static int
>smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
> 		break;
> 	case OD_SCLK:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_SCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> 			for (i =3D 0; i < odn_sclk_table->num_of_pl; i++)
> 				size +=3D sysfs_emit_at(buf, size,
>"%d: %10uMHz %10umV\n",
> 					i, odn_sclk_table->entries[i].clock/100,
>@@ -4972,7 +4974,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 		break;
> 	case OD_MCLK:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_MCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> 			for (i =3D 0; i < odn_mclk_table->num_of_pl; i++)
> 				size +=3D sysfs_emit_at(buf, size,
>"%d: %10uMHz %10umV\n",
> 					i, odn_mclk_table->entries[i].clock/100,
>@@ -4981,7 +4983,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 		break;
> 	case OD_RANGE:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_RANGE");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> 			size +=3D sysfs_emit_at(buf, size,
>"SCLK: %7uMHz %10uMHz\n",
> 				data-
>>golden_dpm_table.sclk_table.dpm_levels[0].value/100,
> 				hwmgr-
>>platform_descriptor.overdriveLimit.engineClock/100);
>@@ -5518,6 +5520,8 @@ static int smu7_get_power_profile_mode(struct
>pp_hwmgr *hwmgr, char *buf)
> 	if (!buf)
> 		return -EINVAL;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	size +=3D sysfs_emit_at(buf, size,
>"%s %16s %16s %16s %16s %16s %16s %16s\n",
> 			title[0], title[1], title[2], title[3],
> 			title[4], title[5], title[6], title[7]); diff --git
>a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>index b94a77e4e714..8e28a8eecefc 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>@@ -1550,6 +1550,8 @@ static int smu8_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 	uint32_t i, now;
> 	int size =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		now =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
>index ad33983a8064..2a75da1e9f03 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
>@@ -109,6 +109,19 @@ int phm_irq_process(struct amdgpu_device *adev,
> 			   struct amdgpu_irq_src *source,
> 			   struct amdgpu_iv_entry *entry);
>
>+/*
>+ * Helper function to make sysfs_emit_at() happy. Align buf to
>+ * the current page boundary and record the offset.
>+ */
>+static inline void phm_get_sysfs_buf(char **buf, int *offset) {
>+	if (!*buf || !offset)
>+		return;
>+
>+	*offset =3D offset_in_page(*buf);
>+	*buf -=3D *offset;
>+}
>+
> int smu9_register_irq_handlers(struct pp_hwmgr *hwmgr);
>
> void *smu_atom_get_data_table(void *dev, uint32_t table, uint16_t *size, =
diff --
>git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>index c152a61ddd2c..c981fc2882f0 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
>@@ -4548,6 +4548,8 @@ static int vega10_get_ppfeature_status(struct
>pp_hwmgr *hwmgr, char *buf)
> 	int ret =3D 0;
> 	int size =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	ret =3D vega10_get_enabled_smc_features(hwmgr, &features_enabled);
> 	PP_ASSERT_WITH_CODE(!ret,
> 			"[EnableAllSmuFeatures] Failed to get enabled smc
>features!", @@ -4637,6 +4639,8 @@ static int vega10_print_clock_levels(str=
uct
>pp_hwmgr *hwmgr,
>
> 	int i, now, size =3D 0, count =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		if (data->registry_data.sclk_dpm_key_disabled)
>@@ -4717,7 +4721,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr
>*hwmgr,
>
> 	case OD_SCLK:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_SCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> 			podn_vdd_dep =3D &data-
>>odn_dpm_table.vdd_dep_on_sclk;
> 			for (i =3D 0; i < podn_vdd_dep->count; i++)
> 				size +=3D sysfs_emit_at(buf, size,
>"%d: %10uMhz %10umV\n", @@ -4727,7 +4731,7 @@ static int
>vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
> 		break;
> 	case OD_MCLK:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_MCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> 			podn_vdd_dep =3D &data-
>>odn_dpm_table.vdd_dep_on_mclk;
> 			for (i =3D 0; i < podn_vdd_dep->count; i++)
> 				size +=3D sysfs_emit_at(buf, size,
>"%d: %10uMhz %10umV\n", @@ -4737,7 +4741,7 @@ static int
>vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
> 		break;
> 	case OD_RANGE:
> 		if (hwmgr->od_enabled) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_RANGE");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> 			size +=3D sysfs_emit_at(buf, size,
>"SCLK: %7uMHz %10uMHz\n",
> 				data-
>>golden_dpm_table.gfx_table.dpm_levels[0].value/100,
> 				hwmgr-
>>platform_descriptor.overdriveLimit.engineClock/100);
>@@ -5112,6 +5116,8 @@ static int vega10_get_power_profile_mode(struct
>pp_hwmgr *hwmgr, char *buf)
> 	if (!buf)
> 		return -EINVAL;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	size +=3D sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
> 			title[1], title[2], title[3], title[4], title[5]);
>
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>index 8558718e15a8..f7e783e1c888 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
>@@ -2141,6 +2141,8 @@ static int vega12_get_ppfeature_status(struct
>pp_hwmgr *hwmgr, char *buf)
> 	int ret =3D 0;
> 	int size =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	ret =3D vega12_get_enabled_smc_features(hwmgr, &features_enabled);
> 	PP_ASSERT_WITH_CODE(!ret,
> 		"[EnableAllSmuFeatures] Failed to get enabled smc features!",
>@@ -2244,6 +2246,8 @@ static int vega12_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 	int i, now, size =3D 0;
> 	struct pp_clock_levels_with_latency clocks;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		PP_ASSERT_WITH_CODE(
>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>index 0cf39c1244b1..03e63be4ee27 100644
>--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
>@@ -3238,6 +3238,8 @@ static int vega20_get_ppfeature_status(struct
>pp_hwmgr *hwmgr, char *buf)
> 	int ret =3D 0;
> 	int size =3D 0;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	ret =3D vega20_get_enabled_smc_features(hwmgr, &features_enabled);
> 	PP_ASSERT_WITH_CODE(!ret,
> 			"[EnableAllSmuFeatures] Failed to get enabled smc
>features!", @@ -3364,6 +3366,8 @@ static int vega20_print_clock_levels(str=
uct
>pp_hwmgr *hwmgr,
> 	int ret =3D 0;
> 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	switch (type) {
> 	case PP_SCLK:
> 		ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK,
>&now); @@ -3479,7 +3483,7 @@ static int vega20_print_clock_levels(struct
>pp_hwmgr *hwmgr,
> 	case OD_SCLK:
> 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
> 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_SCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> 			size +=3D sysfs_emit_at(buf, size, "0: %10uMhz\n",
> 				od_table->GfxclkFmin);
> 			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n", @@ -
>3489,7 +3493,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr
>*hwmgr,
>
> 	case OD_MCLK:
> 		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_MCLK");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> 			size +=3D sysfs_emit_at(buf, size, "1: %10uMhz\n",
> 				od_table->UclkFmax);
> 		}
>@@ -3503,7 +3507,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id
>&&
> 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id
>&&
> 		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
>-			size =3D sysfs_emit(buf, "%s:\n", "OD_VDDC_CURVE");
>+			size +=3D sysfs_emit_at(buf, size, "%s:\n",
>"OD_VDDC_CURVE");
> 			size +=3D sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
> 				od_table->GfxclkFreq1,
> 				od_table->GfxclkVolt1 / VOLTAGE_SCALE); @@
>-3518,7 +3522,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr
>*hwmgr,
> 		break;
>
> 	case OD_RANGE:
>-		size =3D sysfs_emit(buf, "%s:\n", "OD_RANGE");
>+		size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>
> 		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
> 		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) { @@
>-4003,6 +4007,8 @@ static int vega20_get_power_profile_mode(struct
>pp_hwmgr *hwmgr, char *buf)
> 	if (!buf)
> 		return -EINVAL;
>
>+	phm_get_sysfs_buf(&buf, &size);
>+
> 	size +=3D sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s\n=
",
> 			title[0], title[1], title[2], title[3], title[4], title[5],
> 			title[6], title[7], title[8], title[9], title[10]);
>--
>2.31.1

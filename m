Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2127C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 06:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8D510E0A4;
	Mon,  1 Jul 2024 06:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RtbmNrql";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B95710E0A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 06:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GosvsQsLmW42ncyOb08iC2jliY1KcwPGCSSkym4z/0h891SuSd6SqA8XtGOfkPXydhbiGvfWosUzucdisJ06itK/2e22cqfFTqRO+ZAHLWdmSvthAErWrARUGn+cDBSoo4o8b82xmGaJWyXG/dmbLrbB7mXS9jAkX2f3F+gerEM+JQGkZrA1FfShvJsll4ndKvKvOsG+CW23Vov7tX9W4bvE6nvEDUtckn/xHxjTTOl9SdRGTpW+deT3TWdxxBxF9pzv2/9DDzkaRe3kL+/GeRjJv8HBm1dOlbN2oU8BI/VpKpNeJGhGwkruxdCiSDV6kDafrVh9KVlv3Hq+nJDUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8MpHIr9z7FF/3wYAPttQsYD7W5MJW5PfHr5338EuEk=;
 b=oXbidxWQ1d3oSJqe3NOYwXHLTgLPdx4MopjnGOIaTywGYTV/lTj0SOsiM9vHe3RJyv7EbZNjNlncT+1hATcbQ1atNqWQMBjYHLEzwWSU5h7EAEZbx/GTcdOS3ulWfS8SggGE67BIBPQTwcgRXHWtBUjnML5wIY1wH0hCFC1Zp0dt0eAFs68+BVegoi3l5yo35FqS1XPT15xCKOeu8dDY+rki2VVw0vwkvXjm6I8UIFMhlnUiX9HuFbpCix+/r2ed5jmGejO0SJR3phWlwzz+6Q0cjjO6Lxf/LYEwWVPDeQh0IsIGo+ryxq3neleGzDvpk6AE6Z4lk/6p5Icj40uWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8MpHIr9z7FF/3wYAPttQsYD7W5MJW5PfHr5338EuEk=;
 b=RtbmNrqlwh7jmQSfoJdDH57EqSMJ6nFJVP36rrFVTFhNLlRaohgNcGnsVxKPMigeKhAwCYX+uLSsNl3f/EJhRpE2sbM2u0CBVmWEaSsIA+xL62drUPYnBGzixWoADNINuZ+VHHmbz1eaUZjv5DO8QF9POYi6Jrmtt4kJHn8ggwM=
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 06:41:25 +0000
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57]) by SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 06:41:25 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: sysfs node disable query error count
 during gpu reset
Thread-Topic: [PATCH V2] drm/amdgpu: sysfs node disable query error count
 during gpu reset
Thread-Index: AQHay2WGF3NUo/GTLkOFtREcRIKw07Hha8sQ
Date: Mon, 1 Jul 2024 06:41:25 +0000
Message-ID: <SJ2PR12MB799035C37872273C1483E3549AD32@SJ2PR12MB7990.namprd12.prod.outlook.com>
References: <20240701031921.10239-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240701031921.10239-1-YiPeng.Chai@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4fd7e3f3-1a4e-493a-9ef8-686658a6cc69;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T06:38:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7990:EE_|MN2PR12MB4270:EE_
x-ms-office365-filtering-correlation-id: aa7f0dfe-1928-46b2-6414-08dc9998d431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3yBXKH6YubXsuEChCawoEQznbl1di970oxcxtFKmBckqsWubLPGVEqvrj/Lt?=
 =?us-ascii?Q?hLYkWM2dYOeEdgTEE9ORwsEY9tbRJJXHoEPbSOyWsuVbWxtKZSndk2SbjaTf?=
 =?us-ascii?Q?eos94VSjIAi6UrXQoZ1ntfT4Q9fe5Zwc+6fkrvtyQ2BqjEUmRk9QK8nCvjsS?=
 =?us-ascii?Q?fpvdOiKfBIzSEwfNVjt/l5a2W1Ey3bXRcIl0Ao/fQLsZWLFkC31rbWTII0nH?=
 =?us-ascii?Q?1AotBfS1iIPMN2duXbKW4i0Ni3aACKkRD2GuQFtcgVfQcMsWKogQxDgK0K7N?=
 =?us-ascii?Q?TieMsHTVebHj8by8zSK3LXgqgYfG+1S45llWzDjqxVJ5hRMUxlj2AOYAVJ61?=
 =?us-ascii?Q?RS8UpUqxwlndTSX3sxO/oBX+5VKPNeHli5G4EC7hQzZy3GvW/T4dqkF6lTwV?=
 =?us-ascii?Q?IiKUTFhe/MiSnhOT/USj67pkT72sANDush0j4zRq1UMy37D/1IlbZCxl8Aoe?=
 =?us-ascii?Q?FcD0JpcDi/YxXNE53KiCHo8oQTA/9nPoYpZLf3SuRZXhBQIixngb1f0LHdal?=
 =?us-ascii?Q?ggOeY0FJOo9wKLl/s3E6BwX2mRtJOXWA8P9BoLfG3Pi3Hyw6fIj5kM3ggkB3?=
 =?us-ascii?Q?Xhxtin1kWg+MJLpW+QblY8wGxCUgVL5iam1E671PmBo+xyPISaEjtai1H3LE?=
 =?us-ascii?Q?1gB5D6B9SZsPIv3g/Y26WYopRgbhpljxO2k62fx0TwL0v2MflEdxJpusy846?=
 =?us-ascii?Q?n5ZQg8uVVKIfA0c8eNjgfTvj6XfcglVRZT4m5ORBse3XUrcewzOno6iacLtz?=
 =?us-ascii?Q?vdyfTQ2gzHhwa34KEKhoE2Tuyb6PStZn9/JXVklgHyVlwwL98FEd8xzOYkT0?=
 =?us-ascii?Q?1IbMC3kyCnGyii35W9m6rMuB/yrM4Yf3c3W8gWdZ4wiC+dF/gNpVtiVAdDZC?=
 =?us-ascii?Q?+Nhhp65R9pfyQ/UPeIwVLQ/m9VGVclfNDtjBW5VGMoqdIABuyuedREzIycVe?=
 =?us-ascii?Q?ZVftMhFQ+Nvy0M3yGOQftKc5W/zJTPxRl6iO6xn0wiQUoOU42N7oAj/Cyedf?=
 =?us-ascii?Q?nU1jT33/50fi0SV/heD2yTX47H2H/xehiRNscENOri3J3TyWHrW3GFDDd73r?=
 =?us-ascii?Q?mhpkVEBF9qZNxx14yzC+wjMVsalpwXUWFiuLPj5qvqKJ1PGnsHXQH5mIMDH+?=
 =?us-ascii?Q?tBMIMNj/zP/UAIvNRtN2wFUgDo80IQoPwYNu9izMioRJADMOkhSYkvOdlrx2?=
 =?us-ascii?Q?39qWoJmMCN6hk9/FLO2T+JRtVCekUcEFKYNZM9B1erqW3Q3o/K6d5gCxeBuJ?=
 =?us-ascii?Q?Sez/AZH5ZE7X2Z2nLOqTxSSCJOcpAWvot4wSexiWJi67GoA8oM/cNpIinAYy?=
 =?us-ascii?Q?nfteIalKcS32FhLv7JCGk/lkI2sJOS8Xgts+NiZBCoWeBWIatkLJTAqK3xPD?=
 =?us-ascii?Q?etzDP87K75dS958T1cv7fnJ8fmUrt4vxTrqGFIbNvx/idNRHXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGJcZu1bHs76/+qg+606AZRZ5H0dB6vX/vwTolEByj4AIvAnNmSVicyrTcWx?=
 =?us-ascii?Q?wUveLKIhwyq6iFOcrnm6eCDtUnUNhm4Qxfa42dsOPd+pqffapyOOYV3mHmGz?=
 =?us-ascii?Q?f/65rcrm6LGkwd6oJOnIHuqhf5qI5P3j2ej95C4c6uDV2NbgWGAe4Wi1s97D?=
 =?us-ascii?Q?y2YKOvv+C1/O3PsPNK3DEsLW6vGNHtE2PICIKVT1grqOqg5HeFBBy87BQ2Yv?=
 =?us-ascii?Q?7MdeyU+FlgRUv2CuvOgMbBgJbK0crn7FBpuLah73ArXBE5s8TmrejshEywjM?=
 =?us-ascii?Q?zsZUb7ULJhDQyF5vKU5JZHTTKlOB2cAEiNmJuyVOzMcrQA9c+F068mkyVOIy?=
 =?us-ascii?Q?zUI9QTQx8ZkBldKParaNHXPo0Lpj6n/sx11IljdWWvRPgvyCTHrZKTnR7VSz?=
 =?us-ascii?Q?7iCGLI0NWlHCfnavareyjy7Vogg6hCbPGqxJt4bosSzEnLTwm2h7Eyeyxm91?=
 =?us-ascii?Q?/L4vm3fKjV12tB04/8Yaq1sEt173cWqiUciZ4nvtBzK/Gb/3NTVd2IzLOkHl?=
 =?us-ascii?Q?TOTKAUVxyEL/m834G768XiYk4NBirm5Lzh8U8KZY6oWfyZzmaWZx6SQMAdgL?=
 =?us-ascii?Q?G/JCTeDii8rPIKx244zkb4/bCsJxEpEyR08RP06lE85pBCjRFrRV7xC0Bzk1?=
 =?us-ascii?Q?ksX5zmZ7dsfDi7jsJp+1d1nAEqFQWDnPBjZhHnn26Kz/HUcV+Oo1bc3LlK9Q?=
 =?us-ascii?Q?Za3qharCvW1aoYUUUe0FOES5sbGTH2Yt/5XC8BXtlvIJk6aNVIvhNCSD28AY?=
 =?us-ascii?Q?244ZWG65byfbPJok+Lyo8fgPY37l/daNehjIT1QqH2fOqQem9BU3xHBC62aJ?=
 =?us-ascii?Q?nQOnf/nnrmw0pFbs822YOl2Filyc/JUl4jxL21UN+ejYlrkCJRU1c+fIWw++?=
 =?us-ascii?Q?OV0dRzZfkIrqAIePnTGFATBV58dhApoYwnkysm3ayhrEiM3x/NJid6G5y2a5?=
 =?us-ascii?Q?QIESAkkf+SUrcCtXvFGyG0PKM/WKgk9cLtDDMjfG6YYJMqQbjOpMYjpt5d3k?=
 =?us-ascii?Q?A7AfDP5RqTIn3jOiNz+e7XCmgvULeFBzN1vQ2JePKNf8MB0XM19ZAY5oZZwK?=
 =?us-ascii?Q?/E5LC+6O+mnZbXGNqSgMQ4wXQTpKGMxRlETwqmceVgmY2ar3dU/7KDLmMLh7?=
 =?us-ascii?Q?DC6xyBAQh1YO3032zgh8Q+/6Xapj9GwoJLAZDm3BlgwDs/ko1+k4MYu8IWdj?=
 =?us-ascii?Q?CBE9PjHlN5a9l2KDMvXCM5H+5D8Zeq47a6ig4kPlfLE3Ek/iEcdxkAAqtQKr?=
 =?us-ascii?Q?ONe5BSuPOOuL9vEydE5FMAv9cMEN4c/88qZ/3hKWMnvaGgdEy7dctHo0JZpu?=
 =?us-ascii?Q?bGT+JSwso8fMOmqVniOVpZ4knZRH9dLT2DzKBen/8ibhi7mZ5R9FJnd7Okxp?=
 =?us-ascii?Q?n1AtnYvXbZzhNW7n2Vp/GEUrWUiJ9HDrvmL3J2J7OTMaLwIJJR16FxQlLt/L?=
 =?us-ascii?Q?OsQ4XjQZ+XEXcsCW3Rn0axo3gHv4mmVV/Ntk/RUiXrUEJ5gLoN3zscUodIHO?=
 =?us-ascii?Q?HkV7Adaae8smrKYEurhwVXPZUIuJ+k7s4Dj2q41NJch1SfjPpITDa/m//ARt?=
 =?us-ascii?Q?JqicVVzrH9preFybzzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7f0dfe-1928-46b2-6414-08dc9998d431
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 06:41:25.3536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl/A14hiPNqN6gz+4k+kraF1+bx1klBotj7UfCzZ8UhLlnI1eV6D4ywC0f/u8kpuhB1NNDemz+nnHaNh52Ydxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

Hi Thomas,

I think we can optimize the amdgpu_ras_set_error_query_ready(adev, true) fu=
nction calling during GPU recovery,
amdgpu_ras_set_error_query_ready(tmp_adev, false) -> recovery start -> reco=
very done -> amdgpu_ras_set_error_query_ready(tmp_adev, true),
above process can avoid access query error count during GPU recovery.

Regards,
Stanley
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, July 1, 2024 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amdgpu: sysfs node disable query error count
> during gpu reset
>
> Sysfs node disable query error count during gpu reset.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ac7ded01dad0..a65b5197b0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -619,6 +619,7 @@ static const struct file_operations
> amdgpu_ras_debugfs_eeprom_ops =3D {  static ssize_t
> amdgpu_ras_sysfs_read(struct device *dev,
>               struct device_attribute *attr, char *buf)  {
> +     int ret;
>       struct ras_manager *obj =3D container_of(attr, struct ras_manager,
> sysfs_attr);
>       struct ras_query_if info =3D {
>               .head =3D obj->head,
> @@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device
> *dev,
>       if (!amdgpu_ras_get_error_query_ready(obj->adev))
>               return sysfs_emit(buf, "Query currently inaccessible\n");
>
> -     if (amdgpu_ras_query_error_status(obj->adev, &info))
> +     ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
> +     if (ret =3D=3D -EIO) /* gpu reset is ongoing */
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +     else if (ret)
>               return -EINVAL;
>
>       if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11,
> 0, 2) && @@ -1290,12 +1294,19 @@ static int
> amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu
> ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attri=
bute
> *attr,
>                                 struct aca_handle *handle, char *buf, voi=
d
> *data)  {
> +     int ret;
>       struct ras_manager *obj =3D container_of(handle, struct ras_manager=
,
> aca_handle);
>       struct ras_query_if info =3D {
>               .head =3D obj->head,
>       };
>
> -     if (amdgpu_ras_query_error_status(obj->adev, &info))
> +     if (!amdgpu_ras_get_error_query_ready(obj->adev))
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +
> +     ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
> +     if (ret =3D=3D -EIO) /* gpu reset is ongoing */
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +     else if (ret)
>               return -EINVAL;
>
>       return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue",
> info.ue_count,
> --
> 2.34.1


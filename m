Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E5C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 06:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D5610E6A0;
	Wed,  5 Jun 2024 06:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Enxo1YB/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F8310E6A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 06:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRCWD0O/wDGNjA5qC/7x5Wy43zg/O5UMOrgSeP37H0yrj0gM2YaC26yA6wjHg3peGkiOWrXJOzdah3i/Ksxq6JvO15SjFCFBZZNy6DmDr0wOJTwGSkwM3xDpOgan7IS3CmKP/zJv03n64f4PX8l1xK3WLiWYA+mPNTYt+RtbsvFQJBTGxQaMOY4BnDHQppXC+60ORoHbwxtw+yyoxBYwg+fTSR6QSz7HsusF/YLW850SRKsxDFyke8zAkU1/OX9NpJkXmJ38+x06oy1QAa7yCZKJvcZU9dr02MMYLekSvks66RkQFCS1jXk1yU1DpTlhV81/xIm1vue52mJQKpnZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdnvWdQmZyxQN+RAs81bCGGnVnELqDtLEoZiKZDyO68=;
 b=SuTCGKMyYbQPZRskrc8e0RbeTiY6X7LxyLK/0cQMjZ+AJ6fOFOcV4hICm6Q2JWDajU6qyNT1Hr3AcokMFnlR4UYeZ13ghFow29lAyR8JIIBJAYOA/SGPSb8MtNaS6XHE3AJQhzbwNQBxlvYY4WTbMKr/dRXqphqfUzRuWuKWSN9eQSzct/0b2RzKSu6TzixOGUmj0vmjn3AbR6bZ98mypJQbMDMHCQiQujBHTMkRylRtiAcwUNHWlhz4B7XYNKnNirM/qwpHV9RFcNEDTh0nHqpPvb2/nfFGhC46HiyjLw2BsId3ZxoJiUi0V3ZRaeSq0xWliJWdP98H4S+2iMy+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdnvWdQmZyxQN+RAs81bCGGnVnELqDtLEoZiKZDyO68=;
 b=Enxo1YB/TPkZfEyvya9pOMVThoAMTzXVNo9WHnnwowgUN4i61p5zc87/rC2831dR0tWkKYEuVBK5pzTy1bNTY7nZrCpKYEnEshPDmmZ+pe87nXmfzFrvXVcqll08/bBr0uzfGrzfQV8fLZmzMsTuejPP/yjGh5GkJdGSX6LvDLI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 06:46:36 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 06:46:36 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add RAS is_rma flag
Thread-Topic: [PATCH 1/5] drm/amdgpu: add RAS is_rma flag
Thread-Index: AQHas0gyByfWGdUq5E2vpnjOMcvSjbG4wYSA
Date: Wed, 5 Jun 2024 06:46:36 +0000
Message-ID: <PH7PR12MB8796C634929960E4C21797FAB0F92@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
In-Reply-To: <20240531104911.14748-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ba74c760-8430-4cc0-8221-3cbced6a1d88;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T06:46:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: 67c2cefe-b7ab-4a3a-cc97-08dc852b3ebd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?VpdSTBEqRARSu9sHJfFvR9TC1ezJQi7p5GgNHgdjcPJCVATIYngNoPKaMxR5?=
 =?us-ascii?Q?Pf+3CvUWsgiudrkJobPlKKOHfxLEyMZU/TU1ZgRu51VRY+GGdryBq6foqS0a?=
 =?us-ascii?Q?QmrpbSBHBciU8nAdAQSrgT4PiVd7Ua2y+r21P0pJfdWLh88vHmzUr5tDy6Yw?=
 =?us-ascii?Q?Pt2I4Dii8L7wuLXJ3xKe2uzPSqeZMQNWiYK0phiLgPuL1e5EC2U8R1gwXNcP?=
 =?us-ascii?Q?OTCCuVhbxKkWdyYyk3gWSmHQWWinS8P9HAY9oLuqvu+pTOagBHEXYaopJn7T?=
 =?us-ascii?Q?vfes+n/FBUl2FhbKwo4+mXdNMqdEP/yrwirMP5BuQm6sQEGOESlr2avq5SCe?=
 =?us-ascii?Q?1cp/2oiazdz5mJESsN+3EHm+8F9CYeRZS6bqkr/VlOCr9dEJPuPJ0Ewgc2/Q?=
 =?us-ascii?Q?FHO9OZQHKcnluvrXud7NieEzPPR7cAz49mncr5mjYPyt2OwVxqiFWKpBAsDn?=
 =?us-ascii?Q?eleXPB96zv0+dtRMpkzINE9hnNRRFlBe2tzwxtb3pyqCEnTy3mZ4mvh004oi?=
 =?us-ascii?Q?g9IMRIuafTs19gBAlpGZ2HEuX+5/XBYEDeha6Iwsj5Q68QAmThVPtJFX8Tox?=
 =?us-ascii?Q?i8Il/W65ev8kjUdRkdffBVkpBg++PEoqN6PFPBajjB/FX7z3Osip7rY455rk?=
 =?us-ascii?Q?5T7forx668o3D1TXR1kDXBVvyL6luZ7X5mk/+rkQryAYv271zfToHnOpRGoW?=
 =?us-ascii?Q?NyJUiCp7Bm2DUB1ikekQ3yj4XKoc3K2duT+50li3oCY7kJS9v6bHY8ZIs1gD?=
 =?us-ascii?Q?ZO5uPAzCXmLxvibLoKjEWgy0e2qPM2Mw6v5UYZa1gplefR9lxlaJWYVHegsR?=
 =?us-ascii?Q?OCWXJi9Rdq253bmxbNvX/mfafnl0yQaMhYkdmewMctEyVshFQkAaW+PZieZr?=
 =?us-ascii?Q?6E/tVP4EVMUffB4AX0g/tBcCTshoH9F9+/NG8nwP6BDcMsoNmMAfWivBSUR8?=
 =?us-ascii?Q?9nxXwmiVkAgKkfWYxRDiQnAUFyLTQE0YaJ63fd0hoOG6I1OxSyChhDIJoJaw?=
 =?us-ascii?Q?U2HSyUCoWKWJyC/58NFCFv3YQDMk2qYjG6FUvSRjZigzYKK3ocViEZdMwEvc?=
 =?us-ascii?Q?0PiHQAgmvUadDzFmL+ld/xbQjH3o68HKD7leF6rmUXK6ba+t8zkYDy7rKjH+?=
 =?us-ascii?Q?zFDh9S/HmOMn0KA2CJZsSXdWbEwb/mA6n651DJ9zbi4inPbnbI8S0X3m1OFN?=
 =?us-ascii?Q?ywEYLUIKK1ZsqFAw1JWosNj9LnHcPHxzSgPBATtjP1nVowriP6cT03MWarSE?=
 =?us-ascii?Q?E6PqF2ChHFLt7/R3AzaXrg9Dv/hWbZalnGcb4dMiuxg5DfXkZY++h56iTmDP?=
 =?us-ascii?Q?RwQHZy0hATTE7AVY/Oq7o/2CzaBBdXdzy70s12sJMSj3jrNCLDYbFN8yJWK/?=
 =?us-ascii?Q?LXQkgwI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JXul3bVXynkO9A35DDh1RXd3Efb7RF1kP3Y1R9lwtY0Z+7pUHfkxBbHkIzCG?=
 =?us-ascii?Q?y/1Q9T+P1SKOy3uoplqKFpQyzJDcZUJ5VU1Rf5ZcSXgUxEw5i+8pZ7SCMIaY?=
 =?us-ascii?Q?M+uH2wkX3O3w0z3K4htvO/hbobYXk5gNTi4LZggERR8cmKt5u6FjDAt/DMhF?=
 =?us-ascii?Q?4fos3YshzKsoepKey+JISJJBLL9//Imwr2HaCQTHk+bRy5S2QIuLW5JF087/?=
 =?us-ascii?Q?PJmhyX7HaoQKuBAq83Hz7n8BroomeJfCAEO9OZvQeFrg+Y9/TOtcMZbd7awr?=
 =?us-ascii?Q?jIQXJQ1E9LbhIZRonNYigRSGyModXksklnhnR4MEmpnPcelv4/IS8KfxsUnn?=
 =?us-ascii?Q?/2nChJql2OopcBuoVBhiG3SRA4X7UJKTFVxwfRTsyaJU743t9Kqvaq7Hbtqq?=
 =?us-ascii?Q?uPC37fah0m7dEdoF7ZKXErSazzzyJcqVQ3WqRGyl9Yki6RYzVntaYaKvX5//?=
 =?us-ascii?Q?tUL1vwUKik/sjnbqh46kTSZKbUXsMpPJCNbeVsYJ4ndF50yIdWCWwKGtdEyX?=
 =?us-ascii?Q?FtUoq3qjuJHniRfFGrXC2fRpJbU+yuyy7iwt2fMUy7IdiHZR2MkNQBVC77Iv?=
 =?us-ascii?Q?7jSf9xWQUrdgoVFgb/qRY2CFPmLfLdZAxu59j8npy/WjmuY+VifLDW48PkXD?=
 =?us-ascii?Q?T0gu/BWcXuAwm+ukQPYZf4jQSzChRp59HLlUmeClRXn6M1bRDxcvoyz9wyrG?=
 =?us-ascii?Q?2VNnqc2XFacVO7/PkxfyWy5/xzGDBLGmfBOaVMhqYgZJENxQldtqtsG0BItw?=
 =?us-ascii?Q?Extn2kUvyiWCXB4NFTG266+zO2hIIR+LkHlugqytGhGuC1RmT2f6/QDFJ+89?=
 =?us-ascii?Q?+qmdwxvZvY4v/xclfuQ1JuTapbBhguVpYJotBzJa4KQtqBpWLi3zDiSGp6Zd?=
 =?us-ascii?Q?4jQhG4QB+EbPWsDmnd/tjfgqZAdkhe1tM5McsW1Z6gzYDcmPcVon+j7FsSUv?=
 =?us-ascii?Q?kKL56ZVK3K8M2EHHjCIaiJiPdd7T28sA4A9QgVbf1AV13WEsjiTduWXpibiD?=
 =?us-ascii?Q?/SAisD1ivSgxR8qEicunkNrN3PF9bpi19vPe9U1xHkvYEq+8XfwWSWK5jOyQ?=
 =?us-ascii?Q?O3hFhNcombpkjzoHzkT4A0C9O1bhg1jJ4JqAeOghkK4iYr1ea5OszSOMs386?=
 =?us-ascii?Q?Y24+2oAmBNi/o4CSPLbykdQTxdJ6WhtTpLyXRWjTf8PHj0OJVTrfTLyfV9sz?=
 =?us-ascii?Q?lU6jrXeYQGJXNGfGAyBg0ysTWiDFsc3vYujwCtP8LbJ3hA/GzIszN6wR9M0p?=
 =?us-ascii?Q?0tkbQ34eHlsYtMlFao2MGEuPGDwA9UxW+wkfPn+TQPSfwxko+jot9VMsCinu?=
 =?us-ascii?Q?+9W52HaDYZuMXRWhB3opGsglw3brc6oZMbSkG60Nnc0YiFcHfQ7JpoemaiDD?=
 =?us-ascii?Q?VQePTy0vNHGN4URyEVuaZ4JB8boAdb0KGTVxsjoCQXQOje3PrumUMNBhGTff?=
 =?us-ascii?Q?5OGqpcrL8CyjLgq2AFzXa0OvlTniBpLenKKobWRrEFbIprwn5EGj7e1IR8Rz?=
 =?us-ascii?Q?cKmr7K3Z1dvOOgwSDGf5zOJrVbFLByOdlP/IgkDnuHITLNkpDXqSLZ1k3o1s?=
 =?us-ascii?Q?E6fsWAaHDqO+MPundHU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c2cefe-b7ab-4a3a-cc97-08dc852b3ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 06:46:36.2011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXGnQdTI0fjp7A/CA70WF6tvEgIXKFHhu/3Tw2QbpZDT692vcJ0pNEpI22JgA5o5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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

Ping for the series...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, May 31, 2024 6:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: add RAS is_rma flag
>
> Set the flag to true if bad page number reaches threshold.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +--
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2dc47475b8e9..616dc2387f34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2940,7 +2940,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct ras_err_handler_data **data;
>       u32  max_eeprom_records_count =3D 0;
> -     bool exc_err_limit =3D false;
>       int ret;
>
>       if (!con || amdgpu_sriov_vf(adev))
> @@ -2977,12 +2976,12 @@ int amdgpu_ras_recovery_init(struct
> amdgpu_device *adev)
>        */
>       if (adev->gmc.xgmi.pending_reset)
>               return 0;
> -     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit=
);
> +     ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
>       /*
>        * This calling fails when exc_err_limit is true or
>        * ret !=3D 0.
>        */
> -     if (exc_err_limit || ret)
> +     if (con->is_rma || ret)
>               goto free;
>
>       if (con->eeprom_control.ras_num_recs) { @@ -3033,7 +3032,7 @@ int
> amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>        * Except error threshold exceeding case, other failure cases in th=
is
>        * function would not fail amdgpu driver init.
>        */
> -     if (!exc_err_limit)
> +     if (!con->is_rma)
>               ret =3D 0;
>       else
>               ret =3D -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index d06c01b978cd..437c58c85639 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -521,6 +521,7 @@ struct amdgpu_ras {
>       bool update_channel_flag;
>       /* Record status of smu mca debug mode */
>       bool is_aca_debug_mode;
> +     bool is_rma;
>
>       /* Record special requirements of gpu reset caller */
>       uint32_t  gpu_reset_flags;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 9b789dcc2bd1..eae0a555df3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -750,6 +750,9 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                       control->tbl_rai.health_percent =3D 0;
>               }
>
> +             if (amdgpu_bad_page_threshold !=3D -1)
> +                     ras->is_rma =3D true;
> +
>               /* ignore the -ENOTSUPP return value */
>               amdgpu_dpm_send_rma_reason(adev);
>       }
> @@ -1321,8 +1324,7 @@ static int __read_table_ras_info(struct
> amdgpu_ras_eeprom_control *control)
>       return res =3D=3D RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;  }
>
> -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> -                        bool *exceed_err_limit)
> +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>  {
>       struct amdgpu_device *adev =3D to_amdgpu_device(control);
>       unsigned char buf[RAS_TABLE_HEADER_SIZE] =3D { 0 }; @@ -1330,7
> +1332,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control
> *control,
>       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       int res;
>
> -     *exceed_err_limit =3D false;
> +     ras->is_rma =3D false;
>
>       if (!__is_ras_eeprom_supported(adev))
>               return 0;
> @@ -1422,7 +1424,7 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control,
>                               dev_warn(adev->dev, "GPU will be initialize=
d
> due to bad_page_threshold =3D -1.");
>                               res =3D 0;
>                       } else {
> -                             *exceed_err_limit =3D true;
> +                             ras->is_rma =3D true;
>                               dev_err(adev->dev,
>                                       "RAS records:%d exceed threshold:%d=
, "
>                                       "GPU will not be initialized. Repla=
ce this
> GPU or increase the threshold", diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 6dfd667f3013..b9ebda577797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -129,8 +129,7 @@ struct eeprom_table_record {
>       unsigned char mcumc_id;
>  } __packed;
>
> -int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
> -                        bool *exceed_err_limit);
> +int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
>
>  int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control
> *control);
>
> --
> 2.34.1


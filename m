Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE35C0218F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 07:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D94E10E230;
	Tue,  4 Feb 2025 07:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+koteJn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1833310E230
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 07:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4+RtH39VLTwPVKJMhYfHDwwKUcdSKEPoZvMQsdtGqdOcbKMXstd7zJw5BPQfFA7qb8S085Df7mm8DJqRevHR0E7MgIYkuHIp8GLB12irX9eR8oBJZlGDsoJNlikPNCVWJSNDdP+uYInvWywCrfYa+Q1EeYNvkHafzAeBTcU2xWkLuiZf5tZe88yJE7hcjpVsfeN9q36amCAuovLvdec7n90pbBGd9wl/5EAer4xl005ZL70XazD5+ay+MZR+Xo/O4ub/L9YybqsRSpfhs6amAldVOsQ0fDgaJ4zr7Vl4kHtLlSw1ZdVrzzMWskX5E36XM3hV8HW7JQJIqWDl502+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2LEkg6HPIK1EVyhG7ufRFRfEas0W/XzKvw05g+pDU8=;
 b=xusyx930QjMSHttRpegv8ICl521mxd/XKW/eg2bD5OkG5XNFpm/KqlofchKEMQB6hcxcGTm74EQx3DVDpE9JVuDyuK3A+CBkVuGVM3lF1W3pWEaX8zBYpK7Mmp7XXv+Z9Hb/65A9p0gx4zZW0KtZyXYbB/z9o6neKn6cdLJA52OUzxB/2e/Ei2h9PP/3+S4HcmDRjOh38ksyvc2VH7U2y4FCaDKiKMhUUDbItxzWyIGEFQNb7CP1bgnXmUauK1jhefhl7IImDDhKBA79GUffwCKYDBsVAqNLw9JPCGc4DXxqhqrH+dPSe2Pll/vNzO2EyZk2HtfoSQlMkrN1TA2mUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2LEkg6HPIK1EVyhG7ufRFRfEas0W/XzKvw05g+pDU8=;
 b=w+koteJnJ73WNVNiP5yGCRySvofEZwebT0m5M5e6omza8nQmB33uDqeMeSmnrernlBAaFy7BwocO1Rjx8M5v46mbjjimHk/BHISmuVPFf2iS/3qQmwKiKmIpnoxEfs/n2/TjHlEdF64sf9Kg96dbnUhrXtriDWlbrZ7qLbtlsIk=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 07:59:05 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 07:59:05 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Thread-Topic: [PATCH] Revert "drm/amd/display: Use HW lock mgr for PSR1"
Thread-Index: AQHbdtRfD8VmGP4bcEmaTRj3JEZXdrM2xntA
Date: Tue, 4 Feb 2025 07:59:04 +0000
Message-ID: <CO6PR12MB548995A6A11CEDA91BA77725FCF42@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20250204071306.11682-1-chiahsuan.chung@amd.com>
In-Reply-To: <20250204071306.11682-1-chiahsuan.chung@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d9a8b56d-7473-4c46-a0ac-ae6adbcdedea;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-04T07:55:05Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|PH8PR12MB7028:EE_
x-ms-office365-filtering-correlation-id: e6b60840-6c1c-4324-d4bf-08dd44f1cb90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?voy+LuIcdbhUH66PRTze6YIVU2DH4xArxt8SRkzREdGCexY754OWXs65Ui3p?=
 =?us-ascii?Q?1nQqNmex9dwt6091PKa0TiF1J43YmWe480hTSFW5x53zO+WavpXswFCM5N0+?=
 =?us-ascii?Q?RRdqtG1R7YJhOJWZAs1hurmSmk4eH7ndI9JDGyV4swb5V9SIOLQqQkiHNHpR?=
 =?us-ascii?Q?qxCr6W+uvA8Z2MsTmN0Bm8BiWfxbj5imts+GWi8QJidt3YQX+En3xrSakxhP?=
 =?us-ascii?Q?vXsGnIlvmXXMj/Knf3gDjrUMl56poLXwYp9iTikryxZi0KKqh6E16Oy15icj?=
 =?us-ascii?Q?s9ixLU5TyRNJl0ZtRLS/Q/lfJKns9zyHLMn69D8bBFHRsN/bqhQWoLBkC4bD?=
 =?us-ascii?Q?o/gY45D6J9Nhd2eb3nktVKEgA3dLIsnVhaG05r2T0Du3dE2dwE2N/vk3ZDXM?=
 =?us-ascii?Q?Y9UsJnDymd3y+bWRIecP/2cRTmLIOslgiHsvLD7aopTBlr7zIz2qG5xofXvQ?=
 =?us-ascii?Q?1hAwiMWwx9bZ0J1+S7jbEEdNCIryMQxpwaEcXFsISD9J0LJLvFhfRwIhKe1d?=
 =?us-ascii?Q?L278wVPjHDktTqwv838fKw99R+iOz+12cpdm4Gser/53j/KuqYP0dxOBQlZ8?=
 =?us-ascii?Q?rUwu+ZJ/yDY4PZ/Ena9TDHvKf9lbbSGmpJp4dEP+73ZsX3Dngmnpaq+7u/Ek?=
 =?us-ascii?Q?T+7RYuh9rOyMdeX8aPWC1AIUduyTIVmdHGp0QWTZ/G6dxHLcLwgwOAPaTEsA?=
 =?us-ascii?Q?NYiwslvkj22fyyS7YtN5uIfsBC8W9pgzUv1NICxu8dA2aVSk77ehSutR+hS5?=
 =?us-ascii?Q?VSP9kLZJoNxLDNz5y0SeomUkAleC/tzEIXCq0m4p8X5RCRrMBX5MKwTGb9dr?=
 =?us-ascii?Q?Vc663KTzUC83uUcRa0fiYvpkrLxj+xwz5EbL4R9ESXr2UC0W44CUP2eM3mHH?=
 =?us-ascii?Q?mK0reJc11SqdyOYQzlfBQpwtXXMpzYWTHyHVNEG9hQql1MdSl58dJISvc65l?=
 =?us-ascii?Q?HA0CCxj+HAzjhSR5CNovUyoOjjj2U+nhCmUmBZOZORSZQcQVog6RVWOFmWfC?=
 =?us-ascii?Q?NDtgxzvfI6gkmkzU8K43CbmmGnZ1xBO8gcIsnEYtkvrpRgBt3uXB22+ogAvM?=
 =?us-ascii?Q?1YTHoum49NJJGmF/pi2NMwKHwBnevWQvdOlpu0nZL+NhlB8/tXbzVl1lUiTU?=
 =?us-ascii?Q?1PMHZ3fZLeCt7Pa4eN1hGEclZTVGxGz4fz4GMStzb0uLWsZAG3CfEKMplac0?=
 =?us-ascii?Q?o8Y7R7G6sopFzWCPaFyNqFPxnbsuGYK7HoFHW8NO/ybaX+9URSDVBaAB0Jb8?=
 =?us-ascii?Q?SqmimWpl+isEg311hcVX0DscPvp9oCVfi1Xixtu3DPzJgTELQ8L/+eoPTpQx?=
 =?us-ascii?Q?kQg2vWcMgp7MWT0OFC65VxPiBw5tQIototDIu6OpTO0Yzv3QtDzS/LemnrTS?=
 =?us-ascii?Q?GFKiEwtka6KuMnrJg9zIu78qNkVfBj1LhBDpe6TrqiEY+V42HR/qFrdrp77o?=
 =?us-ascii?Q?qSJhsUuZ5xLDcmGu0Ig2zm0iHS5xAEjq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wkfGGtcyxO4SONlSaqXtL9OAdpZOHa9Q9C/Jr1I17qdDl/9OHVP52u+Lse83?=
 =?us-ascii?Q?XnRVyiQIu0kDXoM1VlvJZoVYqaKDJ1g0bXp/u2+vhvKtrF8vs9j0R3aRJddl?=
 =?us-ascii?Q?6Peu/DARJqPGv8ORRO0H4peFoas/MUbaORxr+BXnfza4K6WOFPJjwOoCMD8H?=
 =?us-ascii?Q?zPlSbcZcYME2HlHiiruOubh/StVuZ/fI10XdKITMOxIOJ0/S3Tut22Eq8b1D?=
 =?us-ascii?Q?zCqy0rRNjA3STAV8VNjmRwPnYCf2kl90g4ERtYEQGaOr5UzBzbz4iBVNfIhQ?=
 =?us-ascii?Q?e++qdGIpHoOrS6smGR198M4/SBM/UDhSVHvJSWNiv6PzRh0M3YJZAUxxz1Wg?=
 =?us-ascii?Q?3zlZCpHKl59pZuN23cUVHOjZoU2JwSzmcUBUtcdTgvPYCD3kGjITG7hOaPsy?=
 =?us-ascii?Q?yMW5vfZ9OdwM5oPSubzE9oKlc8cSHbR4T6UQXR1jgMi4rmuhBdtQLk3eM1/e?=
 =?us-ascii?Q?5Ljt/EaDo2oDHfH0SmPB6c4fZiEoC2NPsjfkBL8c5nVeeyEhdRdk/NHCaiou?=
 =?us-ascii?Q?A9KRmTJ+z9ectRpdKkOjcZxnWe58E6XjuJAkiJqdcdXpO0stelIIPaOnSVcx?=
 =?us-ascii?Q?jSVuRjLZGz6W9+LHFYou3m0Vihtbhj3j9r2AGHhm2CPNgATlSF8F3WdIRvy2?=
 =?us-ascii?Q?xwJAakqANr99QXPnXtblwh1y4QKowWchMOhymfbdHPigF/nK5E0kNIvnzXQR?=
 =?us-ascii?Q?zl0u5Z7rPn+wl0YNFIY6esrTX+6KHEbqQ+XjrVEssO0IJUQnVdxtLaz8a5am?=
 =?us-ascii?Q?N2lXmXI50Q1B6ZMGRvMBwGefevCO7v8z+5ijUPUgXrS3jpx3vo/4b+Q1LJWr?=
 =?us-ascii?Q?odvWFMLEq6yw9JTz0DCVoK2x6AZCToIO0q6RP22XO+5fKlokLixbOsuO34Jq?=
 =?us-ascii?Q?rAgTPkfSgPu6KELDK7qpufwka4X7BTzyaX6bGZsGUdAwAfBgcdVP9izKGzUg?=
 =?us-ascii?Q?uqw9ESeDIYugYjL1kJQtsXwx42zNT9P4qtiZdVOV96GwH7kOH6LPNfNzgcsQ?=
 =?us-ascii?Q?hS9RSLplbqifX27F/WPhCpcq39vTtXyHwir8WCNK1sUTHohLzNLXmYPWqnIA?=
 =?us-ascii?Q?V0VVUJ4LD/5VqmUJy9ieI1kAsvuIHN0f5gU8+W8KTnDBNCKmSuxB2ehQBTqt?=
 =?us-ascii?Q?92s8fjdEbdIYXWMHeVnjW9rvaJbHxF/UNDgDxCnaL8LGokR7TLATPF+2OXq+?=
 =?us-ascii?Q?wZz5Lkk6l0nlkB3U6Bus+wjdaTNmD+XC6hAvS3g4TVwgoEjbdLPQeoJhtSBF?=
 =?us-ascii?Q?GZYTCugqXOKcVrl21vDonIBhYLoMijBzqnj7Wp94+6Kp40b6pQ3z7j2BW/NN?=
 =?us-ascii?Q?rkIDz6I0SjEii7bsyHHwEuhlTwVy6S/88zDovpaHGza314BDJbGtzeVCHeK4?=
 =?us-ascii?Q?r8EP8+iBw2Pc0GnHaH6Ks6V8njKNRlmEHPTTScR0HgHZ3ChwwRC8E22KpiBq?=
 =?us-ascii?Q?NcOdbT2ttBLV0Q2vkO7gga07mGs40TLH/Gv6Ry7Wj9W9aE8scPAvFxcOHrPn?=
 =?us-ascii?Q?1f9o4kDVCUPuOhbRYCzmlvLaKilJbuz9VyLizKf5FNu0dsZDwMq8AXUSjDq8?=
 =?us-ascii?Q?vXYXmcg60zFkgUCWfpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b60840-6c1c-4324-d4bf-08dd44f1cb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 07:59:04.9012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdvT4pYv5wi1hsVYKM9CrFeRmt5fCo53xE37yRjQR0ElMO3hpDePE4swszVizPS8ZNjD+9YjauUtK9lV8pZjjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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

Feel free to add:
Acked-by: Wayne Lin <wayne.lin@amd.com>

> -----Original Message-----
> From: Tom Chung <chiahsuan.chung@amd.com>
> Sent: Tuesday, February 4, 2025 3:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lin, Wayne <Wayne.Lin@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>
> Subject: [PATCH] Revert "drm/amd/display: Use HW lock mgr for PSR1"
>
> This reverts commit
> 2a69ae1e1354 ("drm/amd/display: Use HW lock mgr for PSR1")
>
> Because it may cause system hang while connect with two edp panel.
>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> index 5bb8b78bf250..bf636b28e3e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> @@ -63,8 +63,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct
> dc_dmub_srv *dmub_srv,
>
>  bool should_use_dmub_lock(struct dc_link *link)  {
> -     if (link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_SU_1 ||
> -         link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_1)
> +     if (link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_SU_1)
>               return true;
>
>       if (link->replay_settings.replay_feature_enabled)
> --
> 2.34.1


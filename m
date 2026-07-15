Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5795C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 06:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D7C10E13B;
	Wed, 15 Jul 2026 06:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b33w9TSa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373A110E13B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 06:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJqiZPwcvHIn+rPieYvveGEBe9VADKsQxACq+vYpmaOpXgHHARmNpDy4THcYy7SK/jM8pssnBym9dP+4mqhx/b/F8zB3QQ6Jt5wGRZj5heH2pQmK17bOg/8Ql+j8UTdG8Mj7xuKwAFU4FgorwlvCUm0HYe4jsWlaGJ025NY/uzFVUbUkFS0EKUo+zUg05Pai7AmL+Y1DPBD2KIwx939QXMFMAO2fytK3ebIpwMJUV3YO7nLwpBZiqTpwj28lW439LKk/82npz4JzKUlfdNlAf5b+qo0hmGmeN+rSNJNyPAcdHSw/6iTxly/bsV74O5Zd+OqH6VKIKOx6SHybfsPQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrvPRcayjHZHmN/eWPwYBMsAML/AhFkC7qmRExT1FMc=;
 b=QkFnaCOHhfrJZgFZ+T5DlSJ9K1MPiYnom4iHqUq/0J+iWeDjFcBdbP+oi8QlVaP9SL7pLgbUL0we9ms1ZVFuVE6v3doNNN7uqCsWdyzzbOIpERIAvm44oVWdmmWUB3gtgQeBmbocAjZ0+oD6r7xfx+MwCpk1rCxFUyCFFJ3bnrl+aMH4dwhKqHawFhTHYQIPe7OdEWzHdM37Dd2tQfpLWrutrW8pnK+LeM/DiIaaJAQ/ZYlrrsX7xh//8NgdfkXNch2w512lF8V+1cKeKHhmiJhKgQfHPdGsb1izvAvA9rkoRflfBrlCPWYNAQ+Q3jdj5MSzbLJYugvFdC6nZW7bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrvPRcayjHZHmN/eWPwYBMsAML/AhFkC7qmRExT1FMc=;
 b=b33w9TSaH2W3VLflYwQyfX/W/agxEHtiY9Sx8QRu4Ka9BJp3RBIHvsNwTwnpNUJz5bwfnFCHQYQiV1dCKRWNZ/gLkdNws5yZ6vMs+yFjkrt8kjcnbldutprv3Z+PEISfwL/1S83ojmfWsPpFi7csIze/YUmQBuqJB7SncZi6bnQ=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 06:11:11 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:11:10 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Topic: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Index: AQHdFAZoTSzHDjcPUk+UXmY2/YIG0LZuGJVQ
Date: Wed, 15 Jul 2026 06:11:10 +0000
Message-ID: <BL1PR12MB512721747223812B8CFFEC54B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260715030229.1050986-1-cesun102@amd.com>
In-Reply-To: <20260715030229.1050986-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T06:08:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|SA3PR12MB7952:EE_
x-ms-office365-filtering-correlation-id: b33023d1-4af1-4725-b432-08dee237dde0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 6fS54HK7nkAYuTEA9Ti6YrDHgcfx5cmDLGGIxDQR+xkJVn2mpFuOxEclHgBbCUjGyn8jEqWh5X27Wi3pKcE7HlYXK0OQz6AfjxDgVsWBxOy7jaqvby+gMase8Ipfi1xtsyClj6wSeq7Megqcu6idCTz7HbGSyqqWAACUEKFwctqJ0476sSv85Lb+wD0eRL14Bfou2kAOSd5edvlgDGsrzhZXPWO3ygsidrXHGKqsx3LrZDuGYuhsRwdIG9JWvGVXf57yqiNF2MttW6HYa004ob7G51V4UcnvGNExTQ90DTnjYoeY+HUdtpFUMKxMtbxdb2lzTvKlJeatMAKIGH5tHSAE/HqXdDSmcM2UDyi1Z5ss1TxWTcRWgJESfYuE/2zehZH3+xzoMisXEoQqcofs1JUwczKsenTsFOET2JEhIBgkNF2gtqvNHcRm8nJDnsRXR8Qi9YbYGboj9g1+YOBtq4n5MlEmFGls19swEjw17R9tC9XKcQin6846AppvK72q7yPBzlsqEVAZqIkGcdVvU1TzzyvQoS+9N0595UrRIrs8Kt0u2NKb9AYmfGh+FHYOFVet/fpJYns8d68LlhzFxRgXCRTS0UF3UmgfN7DeDM0EM2Aw0d95ze7XXADOg5S6T73z7f0m379f0uuOzSQ0Zq2cGsI4P11vAKnE6ERRH3VH1JJ1kJBxIesk7PLmx3ElZkq/Vkr747e0jQt00DyCaydi1T9955d8E8lsnK+MPH4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XzDX29wpx3sSFb3mu8TPe07zYvcmHhSyyiVS/mQPgp1bcJwSl9vDYqmmyHsd?=
 =?us-ascii?Q?Jd7TltpcN2SGE4FwvA0IFwA16ATv4CXTju9fNH/zbPsa0EyKxEPnUAEZDndc?=
 =?us-ascii?Q?P77vGumDiR/532KJmV9ViPy/m9+fsO16ESUAfItxTF7c8yEfIhKCdMlKCMUV?=
 =?us-ascii?Q?wOq9TxtOE1tCvoYTRg10iRsr/RqQaTGzN4qvXnAIQ3uOE1eANw1tJbsN4hFK?=
 =?us-ascii?Q?T4FMocDBhFPrjGdVb3U0UUe5XpxhIcgySWrGk0la4zjIuqc+AmlQIjdXyyFj?=
 =?us-ascii?Q?udYTM71MrOJpn3FnytBiqJ4GfLUydeo2MX2b+SlSnWboazXftyg0j/sL7u28?=
 =?us-ascii?Q?+D5WqK9fUc2QhNYwoAYKQubg/VoAoOTNO/QXDUq8U2q4km8lEifhsIWKwmWZ?=
 =?us-ascii?Q?5OnPbulMrHKmjSwuYVZS6MSjCXzxQPJeG13C8VF3VgnxYo6Wnw3JLO5zf+y5?=
 =?us-ascii?Q?gmbXx8ol4dJl0EICqc6rHj8U8Y50pFJo/IVSQPiXABGj79YK154FjZ4txOwy?=
 =?us-ascii?Q?g1diGfEi3CTxSSjsj4qdu37hyJGqKeZs9qlZ2qyDO6a4ajqEGOQe9BMBmYvp?=
 =?us-ascii?Q?Hpm/fki8uxZ+Wrmsza1q1xNMSctS9CoHhqqIBKBO2SUsFnEGrIEwynEf2Z8X?=
 =?us-ascii?Q?Xw66qMJhIoyOv98yH7hmbBHym0c2tudEOeeBKWpuI6G9uexArgylZWQWWeJo?=
 =?us-ascii?Q?4hm7xVQCNJyJ53qF+j7ShlwaUNJ2Pc0tK25m/dntSq24LuujxVPJyMHhS1rL?=
 =?us-ascii?Q?jRMlPkoElHBPl3ETj6q2Sf9z4ZW3pidm9qOsd/QWYs3VfNTIShAqfp8j3PB7?=
 =?us-ascii?Q?DQbhbFqNiCfqC4mEHqRvkfV7lOv0DBqhBLGjfkCzQqtLEtOpWCtwpwM1aQMs?=
 =?us-ascii?Q?FyydQxOgeMX9X3+Vt3FGjHMkmb9HEy6rzrvUpc6hBU9SJJH4O1+3Ivpq2hU0?=
 =?us-ascii?Q?94XirY1E7XwrBzBs06a/66bJg9Ha6H4YgOALqfYZYmJ+v4M2nC4MboEm8pZF?=
 =?us-ascii?Q?9XT8dzhR/g4Zvh/qwDoConoCr08mtADpP0RMaq/LYgpbbXQSJvQdm4axHdv4?=
 =?us-ascii?Q?ABtgxOo+PN+Mk7weC4ku+UE9cHUwDUYA24x2SjqsubbY0m6lFV7vyM9/M+CV?=
 =?us-ascii?Q?xYGniReM3OqrnLdY3UFjIMIzpaV/Anm5ybFdLiaQjfYFDE/NNdHHKDYoM74u?=
 =?us-ascii?Q?WebpS4LIx+PbcqrNwLu0vR9mPSuH1WvI6R+Zvi8I/3Xld5L3qqrQ7rx57ocH?=
 =?us-ascii?Q?Y6ztaDwfRJCDKb/y+59euqPPSN+ykC2bNREMpmUHF/AznJc12Dt4o5At1onS?=
 =?us-ascii?Q?8sbeYaIGgRbUho7HyaM4TdA5d7XaDvXfNBWu+D2q4CyueXNkv2uEAfP2OW/9?=
 =?us-ascii?Q?niUN2gYct2P7un5K2i4U3hUJKgh3Lx3B6uVPm/45RAbMBLgnp1g08WpUBCq6?=
 =?us-ascii?Q?xo+gwf7+2QTVMX1Dl02TkNpltCh7fiNFY1WcPCv2uH+ioOcpCH9UHv0lg8wU?=
 =?us-ascii?Q?JDMvBP3ghlfxJ/tcxyXUBIR7thankXvyUNiDgKytb5q8GtF1vtfiROheeOFZ?=
 =?us-ascii?Q?ObFmgOZ+H5x6GKZovkT3+kalwNE3cRnNFJkEbkWJp6bxf5geWxwc60/WcDKp?=
 =?us-ascii?Q?er3cnmC5joiyHnGMN6W+zTeToXVLOSOhbaVVP4gVSmdyICnPM1XBVR44ZZMc?=
 =?us-ascii?Q?KgVsNkp/O9lDUMmcbwT0qr++FG0oU06cgkjwV7uPTxTobCta?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33023d1-4af1-4725-b432-08dee237dde0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 06:11:10.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09S3SAHGlURbUOBXQChVBbeejfpQ32S5EBJ7pYRnxFr4SaRAw8Fkq4AYXor3PjkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, July 15, 2026 11:02 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras: Add debug mask to disable CE logs for un=
iras
>
> Add debug mask to disable kernel logs of RAS correctable errors, includin=
g both ACA
> and CE error counter kernel messages.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 12 ++++++++++++
> drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h |  1 +
>  drivers/gpu/drm/amd/ras/rascore/ras.h            |  3 +++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca.c        |  7 +++++++
>  drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h   |  4 ++++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 10 ++++++++++
>  6 files changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index ea95e0f93d1c..2be008a9da6a 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -437,6 +437,7 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_bl=
ock
> *ip_block)
>       ras_mgr->ras_is_ready =3D true;
>
>       amdgpu_enable_uniras(adev, true);
> +     amdgpu_set_ce_log_state(adev);
>
>       RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
>       return 0;
> @@ -510,6 +511,17 @@ const struct amdgpu_ip_block_version ras_v1_0_ip_blo=
ck
> =3D {
>       .funcs =3D &ras_v1_0_ip_funcs,
>  };
>
> +void amdgpu_set_ce_log_state(struct amdgpu_device *adev) {
> +     struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
> +     bool disable_ce_log =3D !!adev->debug_disable_ce_logs;
> +
> +     if (!ras_mgr || !ras_mgr->ras_core)
> +             return;
> +
> +     ras_core_set_ce_log_status(ras_mgr->ras_core, disable_ce_log); }
> +
>  int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)  {
>       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
; diff
> --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> index a20bb8fdce87..efbdb25241a3 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> @@ -63,6 +63,7 @@ extern const struct amdgpu_ip_block_version
> ras_v1_0_ip_block;  struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
>                       struct amdgpu_device *adev);
>  int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
> +void amdgpu_set_ce_log_state(struct amdgpu_device *adev);
>  bool amdgpu_uniras_enabled(struct amdgpu_device *adev);  int
> amdgpu_ras_mgr_handle_fatal_interrupt(struct amdgpu_device *adev, void *d=
ata);
> int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev=
, void
> *data); diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 878dfdfcb18a..5911ce63f889 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -346,6 +346,7 @@ struct ras_core_context {
>       spinlock_t seqno_lock;
>
>       bool ras_core_enabled;
> +     bool ras_core_ce_log_disabled;
>
>       u64 ras_fw_features;
>  };
> @@ -403,4 +404,6 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct
> ras_core_context *ras_core,  int ras_core_check_address_sanity(struct
> ras_core_context *ras_core, uint64_t addr);
>
>  int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enab=
le);
> +void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool
> +disable); bool ras_core_get_ce_log_status(struct ras_core_context
> +*ras_core);
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> index 67a35409ff0e..5a46a265e26d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> @@ -99,6 +99,8 @@ static void aca_report_ecc_info(struct ras_core_context
> *ras_core,
>       }
>
>       if (ecc_count.new_ce_count) {
> +             if (ras_core_get_ce_log_status(ras_core))
> +                     return;
>               RAS_DEV_INFO(ras_core->dev,
>               "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors
> detected in %s block\n",
>                       seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk));
> @@ -114,6 +116,11 @@ static void aca_bank_log(struct ras_core_context
> *ras_core,  {
>       int i;
>
> +     if(ras_core_get_ce_log_status(ras_core) &&
> +        bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> +        !ACA_BANK_ERR_IS_DEFFERED(bank))
> +             return;
> +
>       RAS_DEV_INFO(ras_core->dev,
>               "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events
> logged\n",
>               bank->seq_no);
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
> index 40e5d94b037f..c42a47492d4a 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.h
> @@ -67,5 +67,9 @@
>  #define mmSMNXCD_XCD0_MCA_SMU 0x40430400     /* SMN XCD XCD0 */
>  #define mmSMNAID_AID0_MCA_SMU 0x03b30400     /* SMN AID AID0 */
>
> +#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
> +     (ACA_REG_STATUS_POISON((bank)->regs[ACA_REG_IDX__STATUS]) || \
> +      ACA_REG_STATUS_DEFERRED((bank)-
> >regs[ACA_REG_IDX__STATUS]))

[Tao] ACA_BANK_ERR_IS_DEFFERED is defined in v1_0 code, version specific, b=
ut it's used in ras_aca.c, common for all versions. I don't think this is a=
 good idea.

> +
>  extern const struct ras_aca_ip_func ras_aca_func_v1_0;  #endif diff --gi=
t
> a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 08e17a83ad5b..80974b8d6297 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -545,6 +545,16 @@ bool ras_core_is_enabled(struct ras_core_context
> *ras_core)
>       return ras_core->ras_core_enabled;
>  }
>
> +void ras_core_set_ce_log_status(struct ras_core_context *ras_core, bool
> +disable) {
> +     ras_core->ras_core_ce_log_disabled =3D disable; }
> +
> +bool ras_core_get_ce_log_status(struct ras_core_context *ras_core) {
> +     return ras_core->ras_core_ce_log_disabled;
> +}
> +
>  uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_=
core)  {
>       if (!ras_core)
> --
> 2.34.1


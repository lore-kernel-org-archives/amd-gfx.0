Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC53C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE91910E61D;
	Mon, 14 Apr 2025 15:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LMfF9Fcx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B761610E61D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhJ9xz10ZidAKS3xGJsxH4XXe7kgrBWsZsXHCTlaEOgGYr7hJOrwR6f6qZZQFlWuLcIOdCuWcCJRLSgZ3VufwmJMa0Rmdnmm8NifSphYL18Mvr4dlgG1wVuYyEw99hsMSK1UtfZ2Yxe5Mmb6gP6j2cyqUMZqvi1At43t6soFu9Hb5gKEvciO3zA4gF8g7NsJRm6+oDGIaRR+uRHWnRnGwkxi1poGu9xhxdkq80esuc9aeHxMyZxNCJvbJBj84R0/yWmWVqnJKxNXwGH/z3GvtTuH0v395x6ybrC8QeHsbD4ESgdiZS6uS/rMfI2z9iz0WpkAi+98MEFPsF0BeVu0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51CErjwbouFTC6AI+tsYkB7ozL4W8+7cLIzjNry+wUM=;
 b=Vt2pZNPBgSnOkpJRVfk6UoxQYhXGc00D9x3aKseWwlIO2s6sMcCt0XR4lCx3t/zKU5XLMKDV61tNg0z01EHzJeJ67HnrJe6+DCnyRR8T7YlgrJejZIWCmjTkKTLgZGBAzJOBWiXC1LzdkTkAwYfFroKkVLfcYGWmpkADFuN5ggO8AiqqXivkfpMAJM8QDAzxIsUM2kqYDoYkrqAzIR3P4cT7HJ7DJX0hBtnaIC/wcl5JjeiSHLEjs1z7GrlinDiz77e5+AN4jLrHN+gZnBfoFgLQaiEr9Y97oQMYXhKhTRNtcky7MXtHJEgVckt3Ht33mfdbSb6rlpyiOnoCZVNdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51CErjwbouFTC6AI+tsYkB7ozL4W8+7cLIzjNry+wUM=;
 b=LMfF9FcxmskuLg1rkSh8LmeTFh9YoyJKrqMq5cpAq7MTl9QKXTwDGrQvVniY4oNDwjTIrq/47cXPJoZjtgS3xc1ZtwVpCDMbYshJsjViUzlquxnH0nuOtBf2gLpkSzvNCwkW7GaBt37EcHnbFpyaHapW2FP8DyZDb5Ft9v5xAZI=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:36:17 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%6]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 15:36:17 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: fix a bug of smi event for superuser
Thread-Topic: [PATCH 2/2] drm/amdkfd: fix a bug of smi event for superuser
Thread-Index: AQHbrVKlcBmZUFnf7Ua/PmtyDsY5FbOjSxMg
Date: Mon, 14 Apr 2025 15:36:16 +0000
Message-ID: <BL1PR12MB5898575E84F665EF103E4C1885B32@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250414153301.51427-1-jinhuieric.huang@amd.com>
 <20250414153301.51427-2-jinhuieric.huang@amd.com>
In-Reply-To: <20250414153301.51427-2-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=90e986e9-147d-434f-8df2-82c39879fdd7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-14T15:35:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MW4PR12MB7013:EE_
x-ms-office365-filtering-correlation-id: f498a66b-bacb-4d4e-979a-08dd7b6a18d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?34tcnHHgDy33q/h9VfEmUBzRCNkjaSsu06uHMu49A3cR0jPpkHKl6uJ9C9BU?=
 =?us-ascii?Q?K6kA3ovRSu9WxemTJBWSY3KilK41QwDUyfVXIm/4uzY/uNGwcllZaMEcFf7h?=
 =?us-ascii?Q?AFD5R5mja156P8hKvZu29EjEfLYWRGWCDLu7no44kD20wmmPiTOQFrDsjLgI?=
 =?us-ascii?Q?+bKOWY56tUWtRQLE0j0X9Jg1NkqHv/7erASpPCtT4u+MwiBDm9QHDe612m4T?=
 =?us-ascii?Q?1Icr9q9fFjsY26EhIiATbs4trpet+T83HdWHfCdPQ2wlznaAfHCEev1TS9EM?=
 =?us-ascii?Q?J1XNrP+3DwHR8UInnoGWbcuXuebGfWZHq/h25sMKuw8C+5U/xRKfP+zDH9fI?=
 =?us-ascii?Q?+1CqSP1QT65a/LGMZPfoWzHFpkR4eteGrFbxqjN/apU3DSgoxog+5rP0Qa12?=
 =?us-ascii?Q?Y3iHrhTUe0tif2FtiW5nSh+F+pI8kibcS36EL7S6jYzDCglg11V/P5aaACmu?=
 =?us-ascii?Q?TPYLOg9CenD3Wv4cVCz3gx8bJsbB7AoX0xv4JHlr6e9Fpfh+Tmf8HXQ0LrY0?=
 =?us-ascii?Q?iHcBa++7GTMcNCXIxuWEyBf++rInJaoyYQ2mZnK5m8hGgdCZz6mB3KQo7muC?=
 =?us-ascii?Q?iui3O3ZHhOhrKej3UETOgbDspi094BQePAq3998z9wRLmOu0032h2XO0ytyI?=
 =?us-ascii?Q?OJL11sf3rbUKCtggs4hwF2vNypyzyLqfxYNoh/pQJcNEEw25iJWsbpuApG/m?=
 =?us-ascii?Q?9x38HlbLWB4ADPEEPtQqh1mMGSU8nzbee/88qOEBxmraujPhsIasake3JgV/?=
 =?us-ascii?Q?p0HmEpc5R+efIGC9ivUY5KunKULhJt0gyhXcvlRoB8d7PXemUPYhFjGxRWaA?=
 =?us-ascii?Q?UDa/6FYKHbbDEAQ3WF1hhP27aDyl+LRaa6raTNwza4IAEbhOJEdw1Icwm3eM?=
 =?us-ascii?Q?FxU6KqtKA9vcalxjAIsLFnqLSKTsuCZPNShouzyVymxWblq0NakcNUpzQN52?=
 =?us-ascii?Q?2OEYY6dXSwAav1o4t4t1jz3mr/JuwqoAqTMe1+9r7tvDaqIW1vs4l1TrT56Z?=
 =?us-ascii?Q?3XJSlvZ+hZNjLjfWlml4Bvjz2fMn5nsW3LZN4TRnHme9F1frAa7kurEcVyB3?=
 =?us-ascii?Q?/orK61LO2TghXYMyIl10VMEu1OeuZKiCEO72+o7DkEBymSxCactoWtM/32j9?=
 =?us-ascii?Q?7+ax08ciMKdmxIEKa2oDtT6JCT8SyWRrwOVr90jm959sz1XLBJHVs/N83vJW?=
 =?us-ascii?Q?iIfXELhe3hnyPqNEKW2Mc8SzLd9FaWxn2IH2cu6uF3SDYc7GLETfWkzEZoos?=
 =?us-ascii?Q?t0PjN9/rHl4KBBXboNOTnqmWFEtvxMIb7mwrP0z8IEEugHEmrooW157sU6t2?=
 =?us-ascii?Q?YA0qZCOM2D41yKr/9uL3DX8uIgL//94dzYRw3QRiEQ9Eg2PJxj1Va6sEDhyb?=
 =?us-ascii?Q?FX/YbXSq3duiKkcZpmxII35I1R3Kq1SGVYwiN8+CthCna7crRo38CDbzn3Mb?=
 =?us-ascii?Q?6zKR2bi8VIok5X5wcRKRXQr19Zz1be2hihItaJuq/sfl7sJF0FWaIQWy2460?=
 =?us-ascii?Q?5BbO/C3/UfAnPhc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AMnunzAgIiQfnxBN5wg8X003dF6arPax8pNDjeuZqLuIi8ZGEX8fxWgFd9Ps?=
 =?us-ascii?Q?g8/ftrNWidvQjfas2lBRudO57GnfXyh8TLsgpWnlcAZjFwxjNEHK8aFAbqP9?=
 =?us-ascii?Q?Ko4Dwd/G6ZGPpTNiN7AnIHYou+DCIWbQzwa108ksqBWzch5b7WDCKLo/yXsq?=
 =?us-ascii?Q?EgwTV1yT2TZ9MIpvQUXcLUn6GUWm5WE3H7UT2hX0kBVllOEs6W6RdQSNotSe?=
 =?us-ascii?Q?IGVBl/nIPkf3iEltugVdKrSzSqfus7l8nD66yLcYu5uNM0ezrHkAGk1Z6ILu?=
 =?us-ascii?Q?I47CdumLRQK+bg4cCXsFc8gOJZt0dc/ui3QEsi7joO2u6j7Q+oMV9G+wCdZN?=
 =?us-ascii?Q?xmZCOmQN04+symOrYftXtM9qo+gvi89C8RaMRY5uZd9ZyT8teR0e6DGY3iL/?=
 =?us-ascii?Q?LdzfKfImpMtcqrb9jC8MLXc7tS6t0QyRK8NJNGJbqOvFjWImt6gk9qyDAUcX?=
 =?us-ascii?Q?QervFPcVDQHew1cGtmPOfyTh85lulHPB+HwpHeWmGNvc0YWea/KervKXxN3F?=
 =?us-ascii?Q?JXL51Bv9Tck7glHQQLiToj4BF0aMbveHXcvIJ2S5VABaivddOicqa75cXOjG?=
 =?us-ascii?Q?ZC1cvhFCIZoDAgglwV/4CkWfFcNiGzzvpJjgepvMSx3tPZZmmiZUUwsMM1Zx?=
 =?us-ascii?Q?F2ceU9E24XzPj5o6pjOY3xMboV9aIlseqFk+ebCcloER0QgAHB2U8YlH3ez/?=
 =?us-ascii?Q?tXrOEhUPZV3ZWsEn8wZ9JJc/+/zgGitK7B4guV5/Tq4YRH+y6xVwOq+KitDv?=
 =?us-ascii?Q?u2eRY5q/iwwnk2QItwOS0dq/PtWawsPoiY0a0ElFDX1tI5qMXlSXiYG7suUu?=
 =?us-ascii?Q?yo3WDaPBPHvp4oQKUjzEyPUpUYF+sePUBwOlGSiyFrkeHYIcM1HOHVEeXiGz?=
 =?us-ascii?Q?Xeiv3ey/9ypUCCwjcAWGFX/bmWOxsmvlMd/W2J0YgAKZ3taLrPiodKyWdDOV?=
 =?us-ascii?Q?CWVMoUma1WWJkczHhHWaTxPL6hxtx8aT1sic2bZTnUdiOzGwXosAeD9UMbzi?=
 =?us-ascii?Q?1hftsoD0aLEHDgoVkIEXbd1J9gfpMDhvPK5hbFqG7vaAGzJ/N/w5Q28xuamI?=
 =?us-ascii?Q?lIxPShvS2f78nlFSfS+grUJ4JhFpL59DD0c/H4beFX9/oiv62CBnWMRdZBFc?=
 =?us-ascii?Q?t7q/W7yoFTyVjd3xQ6SMD5wTPx8ZYI5Tosvzoz/lbGGkA0v0v0vql/ss7fs0?=
 =?us-ascii?Q?E21rsK4BGG1aeV9ib7UY4YZ2rK9KGUAu/k1W29Ml57P4E6gjTyqyIsDd2PMc?=
 =?us-ascii?Q?tFLtNMOSPWW8EGocid5lHLqtNiWdy+8m86WrkNdp0/XJot9SoDdwvPDN10Fx?=
 =?us-ascii?Q?Irgbm0HIofYa5QJ4knyS0MPczae/EwxM9L4UMgAQpinAjg/LuE6BT5TYtRiT?=
 =?us-ascii?Q?HIlwloMX6zMsEEcbQbIvPsnJtotJn26iHRVJ+XvRrbLb9/T4/Qysz5h7FRrL?=
 =?us-ascii?Q?S4fw7CdcvZJuVSvL9ljN2kOvCZulD5hiAKsChPvbIDEMoiX3y1Uh4Py3XKGl?=
 =?us-ascii?Q?aKhvgCi/KDBjyaxt/C99cntCDxCZqW9Duj/34Vkd/sv1z4l1jYZQNzbwef6e?=
 =?us-ascii?Q?/PCvQ6Eh9a+tN5es7IM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f498a66b-bacb-4d4e-979a-08dd7b6a18d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 15:36:16.9262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BmIHu1tUX8fgmtlEEJKwzbxirnCrcKV2qtoWuYb5LhAmJVOFoytdMsMrWCP7Bkr2tthCIP4ot+zt69h7FY8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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

Series is

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric H=
uang
> Sent: Monday, April 14, 2025 11:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 2/2] drm/amdkfd: fix a bug of smi event for superuser
>
> rocm-smi with superuser permission doesn't show some
> of smi events, i.e. page fault/migration, because the
> condition of "(events & all)" is false. Superuser
> should be able to detect all events, the condiiton of
> "(events & all)" seems redundant, so removing it will
> fix the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index c27fd7aec1c3..83d9384ac815 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -163,10 +163,9 @@ static int kfd_smi_ev_release(struct inode *inode, s=
truct file
> *filep)
>  static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
>                              unsigned int event)
>  {
> -     uint64_t all =3D
> KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS);
>       uint64_t events =3D READ_ONCE(client->events);
>
> -     if (pid && client->pid !=3D pid && !(client->suser && (events & all=
)))
> +     if (pid && client->pid !=3D pid && !client->suser)
>               return false;
>
>       return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
> --
> 2.34.1


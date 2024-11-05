Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1904CD3177E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 18:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C049D10E5E4;
	Tue,  5 Nov 2024 18:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7Mh4aa/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D6710E5E4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 18:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tmm9J4D9bijRt8lb9d2GDPdlOokDwjO0cmJZmkcmWQVprp2AiofVy/wkz2TpdIyRuw1jmKpGcuJKmm+gCfyZUNM2xOPswPo8fN+bseYLm59dm/Tp3hZg7MgIH8MhALZsR7qBA8llptKtJnXeM3kRF8YCuEUCJ6Z+dJ/yrk0Sll20OXlvbRQZKshlPN3BReKUBKPzqduqCCX6lTOv9ZJG4XotnVEgCAO2VJdwuEjiGBsMahKYU8s4GXjbAn4zJAu/Dk5ICMJiZulcCpW5D6UECQ3ZkYdSaGBrRGctOWh+TASb7Zg1BbIwgp5YJPr/5ukakHmS5AQdO6HjNJRF4nTBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRP1NZyYJikxRFJV38g9rrIIvIL+c4+ezoZHvhNSUV0=;
 b=BwxE/1rMGznh4680FUBmQdDtrrrn+MrPiJqdvBhLy0Pa+ixEkCMq90NZZnxLfjunczwtGhWGtvoGe0Xio3RhlMrTfZ2yetutUGgbZE3yY5aLLA/w6O6wGxEpjdJ+HEdfXOrclTrObUlxbgMofkR3x5NQFgxG4ZYGzG1YSNczD8UtYV2t+MWd14+hWeIjJbjJeIVb2DuL3EpUam7WeeSywidUKq7kMmzb57nAmr2OQ1AQ/8LCq5F+53gB7wIqc13c4pBXXtANcadrER6hxaD39HKI0mfQRX9l91Y9taU0ZVGkqHpI7x5IZT58DjcpXXQRTAzCWcOxyuEY03eRmrrWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRP1NZyYJikxRFJV38g9rrIIvIL+c4+ezoZHvhNSUV0=;
 b=e7Mh4aa/gwzdxu1WxH6edjm3GN3IE2evqNg7ZhD0oYLAC0dHumC9ePm8S3Masd1NR+WyR6r6kUVAd6Z+GgtUEidcWAjxgbLPbzRthZUr9wi6UOgX7cAfT8pY5Fl/yDg3x+H6E/jeueXaE2TnY1TiGivBXMN3DYUDhUWlgxEK8jQ=
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 18:29:52 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%3]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 18:29:52 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Thread-Topic: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Thread-Index: AQHbL6pgDoVaczyVmkqZiVbd8oH1YLKpAAIg
Date: Tue, 5 Nov 2024 18:29:52 +0000
Message-ID: <CH3PR12MB9395C3BE985452DFD580B20D99522@CH3PR12MB9395.namprd12.prod.outlook.com>
References: <20241105174421.255188-1-jonathan.kim@amd.com>
In-Reply-To: <20241105174421.255188-1-jonathan.kim@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=dc61dc6e-ea3b-4b30-b72c-d485128eb04d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-05T18:22:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9395:EE_|PH7PR12MB7234:EE_
x-ms-office365-filtering-correlation-id: ecebfa77-ff39-43ad-a634-08dcfdc7d6b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8T4FAv6bSywe9/dwPT0FUEG/4Nf9o4ip1DlTkjaZULRKhKJGAq0R2WNA0py9?=
 =?us-ascii?Q?cbFe+N8zFyKF0o1l0/bDZb5SWGRSwaxUgIZUcfKJaLGM+HVAIWABVcUjhheJ?=
 =?us-ascii?Q?DKsXp2qSOEP+pBRY2RvYFUws+untC5yswLcKxqyvJ9oD7M1lsqVH7l7u+Hc+?=
 =?us-ascii?Q?DDBmcjCUjp2LcS25IssG20GZnKTm6snbvhlvARQv6HSh1HHLJR+GT6PcsK2q?=
 =?us-ascii?Q?Cqj8Uxfwq5/ZVBnl6zDoaqUBE9I+cv3rGiVb4TWIYIfBiSon5TRh6tHYTjRU?=
 =?us-ascii?Q?0a4XqDhymB20f3ByhyM3Q/ACIn0E6P4NviHqpJ2dParTJ6DOEeoTab2Y5ITV?=
 =?us-ascii?Q?fySjI5vSNp1E3+fcMr8wZGXF3/2K2UxT1ar4BRjCfkIEShuDyNn+uAb+3Pfy?=
 =?us-ascii?Q?X6sNImRPQoah432eaj0FYoxwzhcXTlalP3Jj2bA1q8Nlqmr3X80m0htXNU4f?=
 =?us-ascii?Q?++QTai7sLwH3HkfH1VYSl0rd47uyNqqZtAuH5aC/DEbXOr18i4ehFLtrlF6E?=
 =?us-ascii?Q?3ZLpzKOhqfPDolqnoHZPf8GVTtK6g+lGvIcTYXL9XiQRFFy98uCN/qsd6VcJ?=
 =?us-ascii?Q?2fgItALQWD8XHBtcBgYUmewlWW4fU9QJDMZjwWvUmxcSaX4v5tC9o8ynnIe+?=
 =?us-ascii?Q?xx8tHj0IkQNAw/+cDciWlBPwYPYC7VF40sMF9xFvzInmUrkdO8TQoiIRoBft?=
 =?us-ascii?Q?dnfu9pInMeaMeRMrdYnTOGBxq6cW3hTp72DX39WYPgrLSlQ4v2TsQwcF5itn?=
 =?us-ascii?Q?BxRVieovHlpctB75Q403D52Zm+PBTh452XTS0qqm2dChpn7YpvPbhKYdRLHd?=
 =?us-ascii?Q?EytEnJopYX6MIOnfw7LlNvDsJrdOPPiJYQv5dS0QJ1R/LVG1aL0FUWrvucRS?=
 =?us-ascii?Q?V3fCESlOVZ2msq5r9wUkyJR2A4Rz+lo2Kjl1iZp42C1dXwOZmLc29j3mrCxz?=
 =?us-ascii?Q?IKPgUeCdO3Fkd4v55f6Ou7OagRKV5O4YVPjdj+pxMAzl/qahNcHAFcp31Evf?=
 =?us-ascii?Q?u8LVg+6B9knQWUUBMRNLe61giIgxbhluL9/gfHkrcN8M9HRosx+kieQ/w3LN?=
 =?us-ascii?Q?OPQ4lozRtyTtvb88E6fJPaVSuffE8rBr4Oz2rLyHCaihcjr9QJkhFQP4XJ1w?=
 =?us-ascii?Q?EmcZ5unRRTrFMxBEE2++0rxkDB2m3ExG01SQ4PADF+F0uDbiy0U+KqQUqNoJ?=
 =?us-ascii?Q?U8QNEIJ8UEHf4D/4Ah9NRN2JLZjxQ19MBtpJvl58YGvTbcaPTjkCVOhX/80y?=
 =?us-ascii?Q?JOfCHTHnMNn+QTJabiTGei4YZw5VKEqKYJrZ3m4x6mBFFtIrFPElE6vz9TGJ?=
 =?us-ascii?Q?DT99dAvpk/sZ2D+6q2z1MKPhYdnA47oInNj6lBWvB6t5Qbgswq1M5+TsaHvp?=
 =?us-ascii?Q?FJbOW0c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?itfT3rVfrsvoZHsNUHrcHnwdzI7I7OUAOo0rDn/xElk1bu4UfCLDQe9OBXiI?=
 =?us-ascii?Q?E1r9jjLOOtHt5AznH+KLBWzv8VhLYRU+Lv3AA6I8KJkbM7zjOVxKFe+UUUaH?=
 =?us-ascii?Q?Kkh8RfljpsOVh8wseoQ11Wzn9Dg+DYIDEXXQfeGC452BRcNY4EcXoobH7YUk?=
 =?us-ascii?Q?5OAFvl+Ytflm+vq6vweFVYoO8GW2BHHsm0QVBu5Ldiza8jBE9H+wWQjyQ5U1?=
 =?us-ascii?Q?DuP449eLzTdr/RF4qQbFO2fN8hHlPptR0sMJkuMiverFZlFUHzE4AYX7DB1Y?=
 =?us-ascii?Q?ehftFWuq9iNqX/dj7wc4RasuDM/UGoQsj7eQcfuuvD/9v3DgcVK2UU6dj0aB?=
 =?us-ascii?Q?2TbdUTOcaHUuKpSaYUAz+7+vmmX37kTYVf8Oqtdso2cbpt4BbWFRhSDIYHyr?=
 =?us-ascii?Q?m9wZuHPYoMPNSRSdrp7f0mYti++NKuQSUH3/lMYZHfOM+eEE4wvXUvhOYPBX?=
 =?us-ascii?Q?7+kj6OgVMteanEOkAIRIDwRnFdaWlSPhXL7Dcl/vwlj3z4xELUiX6MdNWlOF?=
 =?us-ascii?Q?MRLE8VWJXTEXvF3ptXNx4LRTO+mNUp7IiTXzb0plwQbpECKsPR/7E+Roe+69?=
 =?us-ascii?Q?P7ST2Gh0LPpMlX9GVObQuaSJ/4pkfDkrzXZHTsKWxfksMQZulkqPSIJSflfE?=
 =?us-ascii?Q?m++bJuXoJy3/Z8EP6qf/Q052Zpuqj2bU09lNWCrMxYN24Iy6KN3c0NG2eCXp?=
 =?us-ascii?Q?Zk22hzpAa1ZTb8QZnWgnNFTXEdnZfJO35x7HbSUGVsP3RULRl/uU/lRTlRyT?=
 =?us-ascii?Q?cid1vbmV55ZO0Co60YGm3KLIIn8E5wTmKDBwVjuhZwmFhmP2FWX9aOshOqqp?=
 =?us-ascii?Q?U2vRqJw/nBIck0cvm20SmILfDeVZPuTMJkVdQzAteUc5kt92Q8pplyArgkOg?=
 =?us-ascii?Q?osgrTRi2b6rIR6oXBcv7sS9zODieJZCue5gkX2QxRMk4jJ3sTgPllmrMPD0G?=
 =?us-ascii?Q?jVWt1Eot8diCgt58nHI4llRfYOHfy+2WRl1SPsD3YPoUuDSnFfaMg0UtFYBK?=
 =?us-ascii?Q?KJZT2RrrTA2K1Fjko+bZGCvl+CZKTVrdSy59H90xNUezB7HSJ7+RI7Q+PFn9?=
 =?us-ascii?Q?77SZwyMe///iiXCN/zjn9dIM5sFFUEUJ0GnDUT79bC4G5Uvo7cQ30HjPQMS4?=
 =?us-ascii?Q?sMLcT8TzrQd9Uec0meJKeDSZ2e/tFUK28cX44Dp+iiJhFb77xurKlc6kGYC7?=
 =?us-ascii?Q?fbJescMfozGEKVSx7GKVf2uKVxLSsM6Z4345CNOqUEAMNsRe4uOoCq1m7x5F?=
 =?us-ascii?Q?C6s8LUIrWHeje3xH+KwhSZP6dd7OWeRVDo4Jn6dIBE+k9sM2nxlilivUqOgn?=
 =?us-ascii?Q?kLXOrbERzCHsD3cWH+8lnKDiTYY2WowmBnD1kiBcruOIaV4elt2teR/X5a6s?=
 =?us-ascii?Q?6ha7CWNkWvNNMRonf+ynXefzKQaGwPbufuoweIPMukTnS6sHxy2p/E9e3VIK?=
 =?us-ascii?Q?puNMcwZ1VrBvwbNGfKc7OY+Wnk+8xvvxQDfG1HyzPZzG7KTQVrXzjpOLYe+0?=
 =?us-ascii?Q?SWXwpjjnkYPK01xhwuLjYp8XThTnh2SAVMVfkRPYiDMaUa1ohIKIqV3LpdXY?=
 =?us-ascii?Q?9S8B/2lfnilCPnhfGw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecebfa77-ff39-43ad-a634-08dcfdc7d6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 18:29:52.1555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTRfCyrwCwMUfkg4MK4Bg/rNGvZFOPrEe1ygbdJPOGqrQ1rFpjica9vIX6EfYclBi6dr3Ih3qctqph2FgsD8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Instead of removing the check entirely, I think it should be changed to:
BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) > KFD_CWSR_TMA_OFFSET);
Like the pre-GFX11 cases.   A cwsr trap handler too large will overwrite th=
e TMA area.

Regards,
David B.

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, November 5, 2024 12:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Belanger, David <David.Belanger@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
>
> GFX 12 does not require a page size cap for the trap handler because it d=
oes not
> require a CWSR work around like GFX 11 did.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 348925254bff..4705ebb07ba0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -534,7 +534,6 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
>                       kfd->cwsr_isa =3D cwsr_trap_gfx11_hex;
>                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx11_hex);
>               } else {
> -                     BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> PAGE_SIZE);
>                       kfd->cwsr_isa =3D cwsr_trap_gfx12_hex;
>                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_hex);
>               }
> --
> 2.34.1


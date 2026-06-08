Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2AFCD8C9D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 11:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09C410F1C8;
	Mon,  8 Jun 2026 11:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iyr3CGW5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5229910F1C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 11:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGNIBkYt/OyVJLeqVceQgt2ssBP0NOCvkqIRGc8OnwRQlQbZ0jaIpmO7QwHtAg4uLLbicn0+ySM9ZJe7RNfpvJO4wJg6EM2fmnBy0RxisZ335hmVTk0jq5rpZ4bsVGZpS7kpTK+qmh9HXb4zQ1pOtJ1LP6KFuQCoojUdu6ZA5lBy4xX1BijfdZM4PKtQJLD5PC8cIvjQPe7BPPPZ6RTqYnWL611q5iOhPXbf8tTdvZOuUEKBgccvAx7ONS5mQIRmJhxbm43ea69hHA1s3IjQVCj/MbUSdldYbNu8yeD4Tibp8NAOOdtP+noKdWZg6dp6BCm76/QXjpYoGlHDXtxk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQJmOkvvEMOCJ/GPmI1dX5DEnJ9haqcLpgVq3kC7Chg=;
 b=ZH5bL1CRVn8cMl6wiHRuQXHp5gq2m2YE/ywoPjfvs16BgyBVYNewgkT8JICZ65FZCJJ38/LOrPiChOJ8BWDENoy+EyGuF3RuRrYqU8suQx8Gmo/I52T+G+dz9RS/5dkOz1+S46BFK92GGHuDsNZxXuC4jXt00nNmj0Fg30smR8vy76VDPO4EQQUV2mrLAYJ87fcKitv/hpE7/EK8B1PN2b7lPE9nw27g6tGXG17kBTh2Z40YVHF2JaDVFsHOYqy3XSpOfsbeCyPEXBf824S6D5NnN3vBu60vqM4j0eLvsR99Y9lUMCXGyhIVhH+rRBIR7Qjy/mrD4IcCLf/38roQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQJmOkvvEMOCJ/GPmI1dX5DEnJ9haqcLpgVq3kC7Chg=;
 b=iyr3CGW5rhUMdh85HeWVyzkjeX6lQaIPzrJxqs41TB1Br7wa9HhI8DtenlBi6Wq5j02WMuPhwyc0gKcaM8XKM05i8SWMYwh2VVp0iWaqKbd6zb8j0KtcUohFFbEl3ADrJwKiz0fn88C6x0y26lFPX4qr/jun7Qj50Pd4UkD64ZI=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 11:03:06 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 11:03:05 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma,
 Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Topic: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel
 lockdown
Thread-Index: AQHc805zEVVWuGKc8EiTSYUHqImhnrY0ZM8AgAAcPXA=
Date: Mon, 8 Jun 2026 11:03:05 +0000
Message-ID: <DM4PR12MB5038BE603641525F68C9C3018E1C2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260603114459.938031-1-asad.kamal@amd.com>
 <aiaEMl-b5qo6dmL6@archlinux>
In-Reply-To: <aiaEMl-b5qo6dmL6@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: nicolas.bouchinet@oss.cyber.gouv.fr
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-08T10:44:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|PH7PR12MB5951:EE_
x-ms-office365-filtering-correlation-id: 77acf088-d1f0-48de-9961-08dec54d8436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700021|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: EPBADnmgImpjrZM6WPBE++U/rwYm7+kqZuwpOSiQpfSN6IARgpO4IRty1ldkS42q1zcl5LGZo/EJ+3a34GDERtlH4w1dUW4auOPw7wNA+baZaITHAXLt1DozhWiKsgqGTJCbF59agJMCJYP5LTJSUMxoo16CwAcz+llkBSUpE6dSq4Rk+hbtl3oDsqZlWFupX3yaUOSzLuHRFMlwaeBKomu6TR7Z/XAn1uKNxwB7nB94IJbNbymoMYeqYONas+1S40vnmTHhk+sYWHDYQalWJzPt5t/yEKY5cmgI+zK2LL1L96wy1iAE/BwNnnh7v1CDFWvyTC1libJLxG5+A4rwOug7t8x8wtp+Qy7cSGtc0RQTnlaRtAyiFn5AkSoURYnkXNecI6/O/2bmwIMrlvDAC76Ik9VQQ27OrSPyDRtq30dt5ZJ9evVwj3luIXaDfVjdVSCarEKUEfIOQecHctUW1eOO4UGPIgg/oAQqGyosrkmUHFFWqiE9Gb+CgvK9CwU3ux3yYlaZHEJnkeFuLy1853Cr7T2myMakQh9rrqI2zmXkfAuads5ZndP4OUKvDTj6T5Ep1mb7ivlqL2asyCsHNEXrmACo1O31wHY9By8T3fWuxLRGMb949MNL2TF/Ejnmkl7toAZ4zS/WkHnor7Rn8u7SB9aM7eXPz0uKhvj4Isdjv/2i5lmIKonJaNeto2bmHouuRipP+v7ce9HkeorKxTwryXBdwEF2z7VW4rNkXxKLWmgriqbssrCSVtjUjMZa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U3M5dmZzL2ZPVnJ5cWxVczI2djlnU2pCQVNjaERMM0xrb3N2eXdUYlZZ?=
 =?iso-2022-jp?B?VFE2akY1ZDVGNlBocWVKMm83YW1zb0t4NHJMSjBjaVVrRW9RaHdkdk53?=
 =?iso-2022-jp?B?WU9haE9Ld3RaTWVqQVA5cnZKMGdqWWxBVTdZV0hEV0tOYzA0WkZOMVJC?=
 =?iso-2022-jp?B?WmdZRkJyUE5hTnYxUDQrT0QzZEt3RjRFb0QzcnJVU3BDQnJZa3Fqc1FY?=
 =?iso-2022-jp?B?RzNIZUF0WDlXME94cGFQVXJKQ1dzbmVyazRxY3ZuM2xQclRudkh2ZXEw?=
 =?iso-2022-jp?B?QlZWQml0eldtVXdKeDg0K0hDVzdiS1JGZE9uaG5KRyt2VUZSUXF4OEdm?=
 =?iso-2022-jp?B?NDY5SVVQK0M4UEdFcS9UVWFFeGM3ck1OcUYxQkJFMEwvc0pEeXVWTUxq?=
 =?iso-2022-jp?B?cFl0YU1hU2xZWThKaFI5bm9NYkRsMTZHblVsdGw3L2JnYmxSMUxDbHVK?=
 =?iso-2022-jp?B?Rk1VbFpwdDVNVkYwZnZBdTRiWXp0Um1QM1NCY3hoNExhRnluMC9JVTN3?=
 =?iso-2022-jp?B?Y003Q01ROVNEZEoxSmhaT1hFeGcyNjdrdUN2VDV4RHBHSHVweWFBU2dX?=
 =?iso-2022-jp?B?OHlkWUVEZG84VWFLTHJFMWQwT0J3SHpMZUlkdDJvQW9xbnlMNU9SZ3NG?=
 =?iso-2022-jp?B?RVAxVHZPMU1XcDZzVjQ5eVdmVWVTNnhqa3czMmxkTnRuWlZJSHpBMStM?=
 =?iso-2022-jp?B?NTVXUHB6OGhRd0I3cEQ2Q3pEZklrbTNtU3BjZEpFR28xWmdPN1hGVlNP?=
 =?iso-2022-jp?B?VnhHb3Mwc1l3Yk5HYlAraU1pLzg4eEd4VlRRTWgxOVBGNnlxN2owRzlq?=
 =?iso-2022-jp?B?Q2w2NlA0TlFlM3RMRTFUNGllbDJvZUdZQ0tveS9wSGxucGZRTUx1S2Vw?=
 =?iso-2022-jp?B?aWYxNEc4NTVQUEhjR0RYd3dzUWJTdVhUVFo5WURSUmxYSzBFQXcxdDdT?=
 =?iso-2022-jp?B?cWFnS2wrUUVVUlM4d0cvWEpHTjI3WDF4Vno5YmgwMW5JaE1MVUwzaDZG?=
 =?iso-2022-jp?B?VW1hQ3VIWFdhemFSYlJid1N6MlpCc21XYm5DWHF3WTNuNmYyb2t3bGwv?=
 =?iso-2022-jp?B?NTYrQUZFc1lHZFJVTm56VjRaa3FRdzhPako0bGJRMi9QSHZlTTAwU3Rx?=
 =?iso-2022-jp?B?L1RhSUdubkZVRVRFaExsam9Rd1lpUXozc1p2Y2hXNENOWUFYUXJGZjlM?=
 =?iso-2022-jp?B?bHZFOEdpVjd2WGdIN1g5My9PYUY0d0I4blFHSlV1MEVvcGY3VktVVDc0?=
 =?iso-2022-jp?B?MHpia3hXRTk5N3BOZHVnUU9VM3lSRmhIY1Y2UEluampFS3c1TVg1aXVZ?=
 =?iso-2022-jp?B?cnkvQ0lPTVRHUFBOb2RjVXhKZG84M2xBWm1KQ0poYWU2bnp6cm15MlFx?=
 =?iso-2022-jp?B?ekc0cWlVTUxFRWxXNFVLRnhpZHpadmo3WFpGRlQ2R2xtVXE4U01ZVjFi?=
 =?iso-2022-jp?B?ZSt1VXBwVi83STFZbkFzLy9JSVJRYUtucWNtYlRIdFBnOS83RTdQOS9Q?=
 =?iso-2022-jp?B?Y0dkeGxoaGw5TlBFN3dkcHE2ZVhJUVU2RHlySXFNWWlubm5QanNEVjIr?=
 =?iso-2022-jp?B?Qlo4UmJuUng3YzRDSFZGNFRBNm1qeGNDcWduZ1RwV2VNWDRRdGVmbmtL?=
 =?iso-2022-jp?B?ZjV0RnprNEpmOFd0cXNTbjgxQVFCRnVFLzhWeXBEM2dwMGVKYmJqYVdy?=
 =?iso-2022-jp?B?Mm5sTWtwK3R6M1pSdnNMUHBlVlpNcGRNRFhUR0RZR09CeE5nRWxJZFlh?=
 =?iso-2022-jp?B?aEE4cmluSXRBU2gxOUxpRHlJeGZQR3FSSklFNkdUQTFseno2d0gwZzZl?=
 =?iso-2022-jp?B?bW5sdEtNKy9USDVOQTZqQnZWNjJKUUord0J5NGQ2MHVuSHVGUDYwaFBV?=
 =?iso-2022-jp?B?ZUhWRTM4ZGhqSG9LYllrR0JJSmgzMTA4Q2RIdTdOTzM5RSsxSmJHcVVS?=
 =?iso-2022-jp?B?YU5OeldHYVpvd2NIZlJla0dXTis4RWpCa29hQk5PenNlRkNoTjEvUDdW?=
 =?iso-2022-jp?B?M2NQUURJWWw0dUpWZGw0S01lZ3dpcG1FZkFLak0xSHlXbysrN3JTajRn?=
 =?iso-2022-jp?B?V1N0ZXN4YVFhOWVXMlNJdS83b01TSHVhcCtyZktZWG43MDY2NFkrQ1lI?=
 =?iso-2022-jp?B?eFV6Sk5oemRvTk5GTHY3SzF5YjNwTnp6ajgwaG5uQzNETklrR2JXU05S?=
 =?iso-2022-jp?B?blkwS2JMNFpmU0dsb29YUGE5Qzcwc01USDdpZnFxSHJEUHdPYjVXVjRv?=
 =?iso-2022-jp?B?MXBxRG5XbzhNQkw0SzBCcFJjN0xkNGxjdGRBbXdrSzNaS1NGUnpoQXRU?=
 =?iso-2022-jp?B?cmdhNUZueEZXTCtnV3pkZjAwbEVKU3RJa2xEcEozaFM5NDlWc2I3VC9G?=
 =?iso-2022-jp?B?RXorbEhFRTc1M3dZSHUwcXg4c1kxYSsrbGdsejJXSmxqeEtSb2Y4cW5E?=
 =?iso-2022-jp?B?dGxBV29zTVZXdURpYk1TU2pYT3Q2RkxXbVhreTJGKzlub3BZNWdscnlj?=
 =?iso-2022-jp?B?SmVnRkx3Wnh5eXczRnNmRktSM1pRTDJaVDZmZldad2tBcXpyLzMrUllv?=
 =?iso-2022-jp?B?cmZ6eVcva2Y1VGwveDdtazBYb1lEZ0p2SHJLRw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77acf088-d1f0-48de-9961-08dec54d8436
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 11:03:05.3912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cqb825/MIzsNS5+p0mPAfZy/8W8+RZKFOEfpllOxH8z6Uutg8ju0EIsYzn/dGRdvIH2I53RUTPJR13LcaTF98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

Hi @Nicolas Bouchinet

Thank you for the review.

The commit message references v1 behavior and is no longer accurate. Writes=
 are already blocked, the existing debugfs_locked_down() in fs/debugfs/file=
.c handles writes when FMODE_WRITE is set, the early-return guard fails and=
 security_locked_down(LOCKDOWN_DEBUGFS) blocks the open under [integrity].

The patch addresses only the read path. Here is why reads are not blocked b=
y debugfs_locked_down():

static int debugfs_locked_down(struct inode *inode,
                               struct file *filp,
                               const struct file_operations *real_fops)
{
    if ((inode->i_mode & 07777 & ~0444) =3D=3D 0 &&
        !(filp->f_mode & FMODE_WRITE) &&
        (!real_fops || (!real_fops->unlocked_ioctl &&
                        !real_fops->compat_ioctl &&
                        !real_fops->mmap)))
        return 0;
    if (security_locked_down(LOCKDOWN_DEBUGFS))
        return -EPERM;
    return 0;
}

For a read-only open of amdgpu_regs (mode 0400, no ioctl, no mmap):

1) (0400 & 07777 & ~0444) =3D=3D 0 =1B$B"*=1B(B true - any mode with no bit=
s set outside the 0444 mask (e.g. 0400, 0440, 0444) 0400 satisfies that.
2) !(filp->f_mode & FMODE_WRITE) =1B$B"*=1B(B true for a read-only open.
3) No unlocked_ioctl, compat_ioctl, or mmap in amdgpu_debugfs_regs_fops =1B=
$B"*=1B(B true.

All three conditions hold, so debugfs_locked_down() returns 0 and the read =
open proceeds. The read handler then calls RREG32, a direct hardware MMIO r=
ead, with no further lockdown check. That is the gap which this patch is ad=
dressing.

Thanks & Regards
Asad


-----Original Message-----
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Sent: Monday, June 8, 2026 2:34 PM
To: Kamal, Asad <Asad.Kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang,=
 Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Sh=
iwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Y=
ang(Kevin) <KevinYang.Wang@amd.com>; StDenis, Tom <Tom.StDenis@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lock=
down

[Some people who received this message don't often get email from nicolas.b=
ouchinet@oss.cyber.gouv.fr. Learn why this is important at https://aka.ms/L=
earnAboutSenderIdentification ]

On Wed, Jun 03, 2026 at 07:44:59PM +0800, Asad Kamal wrote:
> amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow arbitrary
> MMIO read/write via RREG32/WREG32 without checking
> security_locked_down(). On kernel_lockdown=3Dintegrity systems this
> bypasses the same restrictions as /dev/mem and PCI config space sysfs.
>
> Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
> debugfs handler that performs direct register access.
>
> v2: Use consistent check as per previous check to use
> LOCKDOWN_DEBUGFS(Lijo)
>
> v3: Do not create any entry from amdgpu_debugfs_regs_init() if
> LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0ce6e2e4342c..5c4d4ff001ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/kthread.h>
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
> +#include <linux/security.h>
>  #include <linux/pm_runtime.h>
>
>  #include "amdgpu.h"
> @@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device =
*adev)
>       struct dentry *ent, *root =3D minor->debugfs_root;
>       unsigned int i;
>
> +     if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
> +             drm_info(adev_to_drm(adev),
> +                      "amdgpu: HW debugfs nodes disabled (kernel lockdow=
n)\n");
> +             return 0;
> +     }
> +
>       for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
>               ent =3D debugfs_create_file(debugfs_regs_names[i],
>                                         S_IFREG | 0400, root,
> --
> 2.46.0
>

Hi,

Lockdown denies opening of debugfs files but those with the following condi=
tions :

- The file must only be opened for reading.
- The file must have mode 00444.
- The file must not have ioctl methods fops.
- The file must not have mmap fops.

I might be missing something, but how are you able to write in those ?

Best regards,

Nicolas

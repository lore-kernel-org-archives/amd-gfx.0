Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F33CE8D65
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 17:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AE610E0BA;
	Fri, 14 Nov 2025 17:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvIrb/89";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C60A10E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 17:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndYfwTN4o3ouBm542jUfzBBe0noXagu8DXv4e4740N837zJ4+8tLUzcAsZEHd8uBfAPrGinDqtsrk2SWBQBT7sKEpaorX2OZNJO2p3Er472Pp881OZMM8gl2bRwKlQjMM4oFwjQ47/Ppqbnhq21PiMW5EpaQ10tuKwTj9DldyXFV/DXgaBZ1uVEpjujRi3ZH64f+6eIPUBVpzpUEZUDvXgd/w2i6c43sBk/MFIGfX8AHKsgbt9Nhgqekm+/DS91cDwzVmx3MUa93kVSH7HANOKh8vu056c/auCvU9Ts4C9B1rmuRpJPYuT4ztgAPpWtCuRlA/SJ7qbu5zwfdL0yITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A401Yb5l+GyZAPmUZbIEu3pQgBJofYl6xuJ27U99gfA=;
 b=VFNsEmK6+QYRlcUVWXgFUesECS70SmG14RRjyYm2K+GzZzHMQpW3+Zo50WuiyplkPW9+4Xg3vfgRyIGMKUVrcY4yIXtF4Xyit6UbQ8J99o6vQPTI1kMm/z+Tcsm+Ernpti1UKGtFT316z0Zk8Rgr2giBCF+Zo53MuBEJSfqwJI3vDw8QZJzfV5/cIq6OT+OtY8ftSI+P/mFiS74a7oruRF6EmINbeOIIRYDGZ+r9PQpJW2I7r8wa7y8/YXrkt0RD2AbkId7a6JrmBtaJNXDR+5bXaL657cZFf1m968lt3NnO6EApW11gxHyjCBlQSUhLUPTMIzSsoqXlzlkao+BNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A401Yb5l+GyZAPmUZbIEu3pQgBJofYl6xuJ27U99gfA=;
 b=qvIrb/890/stjdm1wRs0FPWALCFBqlyUBGd8tBzPmiIm5lMJnw8Z/Iegp6hC6yicIrsUmbrGlXofsxSR0TZI9l5Iaf61njwyJ9jBlPRS6e898gn/a5yne3P8IhnZMETELBAUWDzmy5DOCcfiRgzYbcnHYovno7klwGC2U1uU3M4=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 17:37:51 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:37:51 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Topic: [PATCH] drm/amdkfd: FORWARD NULL
Thread-Index: AQHcVXSwv0zaaD4Zs0yOHV4tJTwO0LTyZg2AgAAHwrA=
Date: Fri, 14 Nov 2025 17:37:51 +0000
Message-ID: <SJ0PR12MB8138535C497082B461DA7B48F5CAA@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251114144033.1432008-1-andrew.martin@amd.com>
 <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Kent.Russell@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-14T16:32:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|CY8PR12MB7196:EE_
x-ms-office365-filtering-correlation-id: 9e7ccc89-b752-4d02-44db-08de23a488ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?VBw/pYb8gpRl8HRTaUcv1RMjPV0LIa6POAJuoGmmXjesBokhItE8rNe3ribt?=
 =?us-ascii?Q?Ch4G11S7M9x559bUWak6dENDK37I7muyfVg3AgiwTbYxlZcCsODNsTWqCKfo?=
 =?us-ascii?Q?fAdAVCStWo1yqXwxeeBM1p1BZxV3P1V76a/M0LZlX6r1owx5jT4HXo4GGiDk?=
 =?us-ascii?Q?Pj22uSwtCs2t2bXgCxKAtX0opD7KaeIoLqWGxfPd93umuFsuhnbFbdwXyJ3T?=
 =?us-ascii?Q?uYzXEJ31X6a5L4PxBQB6Y8o8e0NvpKyi+UGj1ceJYrFx12oBsi+moSmvpwN0?=
 =?us-ascii?Q?698Qj8UIk5RHalzl5xUZadN53fxgZSV62/OXZv7HMt8/dXndGeBfx/HiA4xv?=
 =?us-ascii?Q?+8bIMWAhS1RzzHHKSrsuD+z6fBpercXSls5cTjHQYbMmQyQ+GMnN3I/az/+x?=
 =?us-ascii?Q?aRcq05GuE+KtqhTMy+akKNvIAeut86uI8ZRfhFWryWHR63uYmiyKi3J5YyS2?=
 =?us-ascii?Q?Lm5FLVfkm+KArmLwbmxpEgqVOK/hoDJFXCPfqT0kEc800geZ+QaM+5mWhoat?=
 =?us-ascii?Q?z+WSfH8AOrovP9VJrkoWifr3eB2X+bV74dNcGfCcPa9imF4uI1oB+pBGDIi4?=
 =?us-ascii?Q?u35wWIA0wSmpb4r/uPGu17+zRJNZKz+rdjGmDx5KED6Xj5c2tm+MyJRxwD+m?=
 =?us-ascii?Q?7CfGrxvTD2Q4vqm9DdDX4WmHfmJ5+QJk1cUsknmSKQOXSgGXkQcaXB+FTEn1?=
 =?us-ascii?Q?ED2r2/vfmff5+4QlkFMBE+l5jQRPlrwtZ+xDy1JLos+CgO4bcVf+l8wRAr9w?=
 =?us-ascii?Q?3rG4NIxTHU8mgHI47uPB/Az5sPixhH5ER1uTaK17OTQ4teZ4v44lnDTv2XFl?=
 =?us-ascii?Q?KFW3XnM84oWSRNcGh2mO53lWZJ7rsNcmvROX0GgvuQoit4XAGGRfnUmi6xcY?=
 =?us-ascii?Q?sn6Cx1DYK+3HnOTaQ96WfWJuZi6TfEDsW/y44KB3ZqT4DrKM+I0zLN3WxDQq?=
 =?us-ascii?Q?7/6cfbDbeG5KvF1niwOurBk8kCSAGDpMol1/L0DA6CCUQ0n1GXWslrxPkjo1?=
 =?us-ascii?Q?z8jzijTcTEeLjgL1+tDZQ0+aw+j8z2oPS/n54pAjJIMk5jU8dXm8OQV6FL7x?=
 =?us-ascii?Q?ZepIXj6b8JjROJzRdin4GnPuqNso31NOTbC5RFTGCDSVkc165e0TBzHbUaPn?=
 =?us-ascii?Q?07z/wo760sJyUnbr7MnpDq/RBPLerx1DholEg0K0oSo3DbM/2N2/yIiJhbkc?=
 =?us-ascii?Q?3iced+0Bv6HpTMgdkj9jOpuQSJKuEHUJjfvhqNDKYE0HCLIQA111/nzwXHQa?=
 =?us-ascii?Q?cTx9yeTJ0MnX4DJ/S+oKIqhfg/8T10fPovC5nKYDC9gUFeE2GcwQs1cGZGUk?=
 =?us-ascii?Q?Dve5PXNc0o2DBIEuiD6kto24cIxASB54tAC4/GdEWBURvsYcc5QTJMo04wjU?=
 =?us-ascii?Q?A8C9l2VvPiO6eEZxRm9OUxZSNkGUUo88Xjfox6aPUajFbEI4PdaNf7+P7DDv?=
 =?us-ascii?Q?4mt1QO8GR62tSSHi/seGBIuwyMOiwmU4WgApwIWRVa/0gi5Iti8q08VnVJ6u?=
 =?us-ascii?Q?GFK1LCxXytK6Ga1rZ+KEtgpwkOrQ8nE7Yh4O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Fy7ctCMLS7exbvX2NwdkhzTVw4K9lLXOoODI8YtrxtxTXVtOQonkbWED160?=
 =?us-ascii?Q?4U/w4kfYue/McvFM70jB2+HAO554j+gwZ3ObThVWnvAenQr85za3fm7maM/b?=
 =?us-ascii?Q?LO8ual3t2AwtOHgNxslDQjX72zXpJy/awoJn+CEU4p9H5Kygkxg7QNrhA+32?=
 =?us-ascii?Q?7lvxM0b25ggjmv30cHfz7m9ci9EwCBcz6cMS70IqAkM13taJ7ECYHzwywks4?=
 =?us-ascii?Q?H7kEZoUONUoeTHzYYkh5doR+8SNgEzoACZRTOWscYer95UN9nbKYOPKv4fca?=
 =?us-ascii?Q?/wPmkRo5pBy4xf01oICvwdsFGEGa3MZRL0Y79Q/Aad6tsl8/XmUltOmNN3Hk?=
 =?us-ascii?Q?R4TzZnGDTFwJd5LFui46BjT4/GHPq15hDoBURV7GffkPGYOLYSeRk4aBWrNJ?=
 =?us-ascii?Q?YBDTPDT9KfCf1QBxS7EKHHyVsOtm8szIkJz7ior2eq5QIWm/wXGcO+Yf7Mek?=
 =?us-ascii?Q?BbkN5JTwr6S6O1aiPXLHMYEf1C7JlBV4XbyKyN5ci40jCfnjpI+PwWm3Evpf?=
 =?us-ascii?Q?AkDeIDgQcCwUGYYOYhCU1O2b78geGOH02+qAYHYRNpLxGfPxU/trV3KUTeMO?=
 =?us-ascii?Q?3nW2yvZxlq7YBDznLSD5E9lPEg5bW7RNGBGAcbSreVocQYKCWrD8fUBTNoDB?=
 =?us-ascii?Q?BTNbYYrEJMtCuentuwubgwugZa4Yfflc3OANO3WmuyT2sWrKZa/xnoCXKIG5?=
 =?us-ascii?Q?sW+JQ5xgshMPYQhlHY5F/1XoZgtGVNikCi1w0zOXxprDParwc80+S+qy0e8m?=
 =?us-ascii?Q?Sxn31Nb1S/hQEfOcJDRcTl/chjv/PcLOSLO7FQXHztQo8uVun3EtYqdXVOqv?=
 =?us-ascii?Q?nBULDSi0M3B7LigbESfMNrmoyOdtS3oODdacnBAojPLjc3jz653ywueiLRAb?=
 =?us-ascii?Q?/6JxYw8W/xMJtKol+fygCgzfmIX5YMDUj3WLUq9fRKeBrv+NuJWqpicK8mqE?=
 =?us-ascii?Q?WhW6yf/8y2pnps+G4GR0dcDVh+7SoqH+9P3XtEsrZ4j0drlNOPaCg2gD8abN?=
 =?us-ascii?Q?ZJ+i0GCp17rlKTYjqqBd0h1Pthr+q5tXyQNrhTBB23NVf+DVj9JNQxKC6HWP?=
 =?us-ascii?Q?cfmhK8W0ekvYHtbxdLji/xpT8dUjzz1AIZB+4Ddd9RkNXCLzp19TIROsAx0b?=
 =?us-ascii?Q?yYpwVpvIz/S+trFmhWohhh8oL2Nyqd1QMrvp3D5wQrxXLX6LoE3ZOWW4Kfye?=
 =?us-ascii?Q?zSIgcV67YKzvIZRcSuWg4eTdVXj7rumUn8ygpYheECKNmzoUpMbYVf68KCHI?=
 =?us-ascii?Q?n73IQh+grw7HdNAzabmsdtquJyoLpBfM46bm57vHmEBXFp6LBU2QOG+Sz7w4?=
 =?us-ascii?Q?YDuPdyGtSsNUOvgyEmoPncNKqZD80tPxNwsdv9BoDBrJXMsxeC9BtaBqlSwo?=
 =?us-ascii?Q?uP5aTo19X2VQBVtrzGJz8KCu6avB1pfSXiG42JTeNTaq0Jyr/VtYDfKmrFDm?=
 =?us-ascii?Q?C44yaGCpzd+YvtTGs2fAY1qUUozlUqrw7jX5nof2MLeRp3oSDRmjwG7cpF66?=
 =?us-ascii?Q?KlTVEU7hQZMkoKg+eJbSxhgGiojv5u2/QxOGM0gay2VhSrzaEBuG8a94uKQZ?=
 =?us-ascii?Q?GYGF0OAugJNnfDoakTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7ccc89-b752-4d02-44db-08de23a488ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 17:37:51.1507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbYYO2hhpquCDUtq/DhHhsueucl+yh8aqEL1RpqQLrquAclzShVkcOlCfnGzGUd9IvGwNVNJKFAUa0dHSvTtCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

Greetings @Russell, Kent

>       struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);
> +     if (!fence)
> +             return NULL;

Thanks, looking forward to any lessons from this.  The main concern for Cov=
erity is use of the pointer without checking first if it is valid.


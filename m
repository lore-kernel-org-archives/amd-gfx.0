Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE246C5AD49
	for <amd-gfx@archiver.kernel.org>; Mon, 26 May 2025 20:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF0A10E3A6;
	Mon, 26 May 2025 20:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kN92tF7K";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F35D10E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 May 2025 20:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF2/qbcA6raUo7bqdbjIXlWBreET04bFltp8RLCJ/91xXh1aj8QTcOi6UnFUNSeR3XFBeRtpAT2G0svSiHev9nA5aXb1J6jUOqK1bNHB0HCvkjP598MBoasH9W619BxLhMjdacBo3cSIaB064WhTrXs7qhxo2GU4GVrPIaOlB/EQtSCVTto4F99r2CxWMrOfAjiMc8f8WAWAWbCCsDA8bJx/HKMW9kr6iYFW2RhyrTOy3MSvfKh0uuEIxkT+/J77gBn1SmD1KbPJzGZ4tSYhLEgzNxLmm4yCBQDUkqlxSEQU4tl7znevR/bD43mhZtoj6HaUbauBzAskEFXXVcifpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nchFvi6n+3lQuWVuh1WMYxr1M57Vs40w6qG5T1CnQGQ=;
 b=fzbYU5ThY4jT9AQygjLwLRj7j3Y0cJEdczyiH7HnGkuBsm34NoHvROZBgkm9ORMxbFrjH4zoWD21iYviLCLEJHu7vX6N5cdWU6s3ufeMxtjgoUEpA/TpQ9JUVVe/MtX741lBIWAl8OTRSOATHfNIUvkluYTUaEamnXBWm9qd3kQYclSXK4oUchhj+BcDxpzHXCw130jErgDwOx6vKlLax8fx1sc8vEsAnbaRSIuh94z1L48SxH5IAOqSWlYkawxw0Jz9inS1YyfYkyr+9Xl9qZ2FnyOgcqydFJOqCzz9dlKyAVzRJuArNiKJsZBvrqvfXHX32EhMTfDZ/X+V5hW3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nchFvi6n+3lQuWVuh1WMYxr1M57Vs40w6qG5T1CnQGQ=;
 b=kN92tF7KD0MkkGDlsk4olstbl7vQPbkFqmUxoNeEEdkgb4OFPsW7fCaxmUlslpaFxKDl4/jKT1+oV8pcWFCFFKIgsiklTNyH6AuYkh62D23uFS+XeiuY3sTTRPIpSO9BcZHEJFrB4c1G8lYhmHV4Et8lKezyjnaAYUaGlc8GUx8=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 20:00:14 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::a68f:c992:8f78:fb35]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::a68f:c992:8f78:fb35%3]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 20:00:14 +0000
From: "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Clement,
 Sunday" <Sunday.Clement@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Identical code for different branches
Thread-Topic: [PATCH] drm/amdkfd: Identical code for different branches
Thread-Index: AQHbzD5S6y2RdRz5jEmLFvMjE/GGZrPlNEqAgAAj6gk=
Date: Mon, 26 May 2025 20:00:14 +0000
Message-ID: <DM6PR12MB4170B99C4F8428F211C7CF8CF765A@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20250523235339.828608-1-Sunday.Clement@amd.com>
 <CY8PR12MB7099F2C5D967A48E80A3AED98C65A@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7099F2C5D967A48E80A3AED98C65A@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-26T20:00:14.064Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4170:EE_|IA0PR12MB8352:EE_
x-ms-office365-filtering-correlation-id: 3c497c4b-77f6-4d66-01a8-08dd9c8fee1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?llJDO8/tlDzzR/3RjmwM/vJ5ULDALDW6keQaLSzlAR+813/hBMmzlkgH?=
 =?Windows-1252?Q?hXam/+cEty7jR9qkWEZPTL32wbJeeq8rPKVFWyFt75Oa2gimJPOwdRcV?=
 =?Windows-1252?Q?KlqLItD6n7X2OMYggGLS21f3WFjfQxSanVhLZtEr3Ji9ncOe4o6YM3YQ?=
 =?Windows-1252?Q?+4Kdnhuo0n+5niJGL81tAIB8qwgi5NvuST+NJ+nhM/YJ45Xy6x+Zw4x0?=
 =?Windows-1252?Q?6INoi902w59v4jMmEkgdmK1QDcPOhuQYdFsDuVsl+hgYeNxh79OgwhrC?=
 =?Windows-1252?Q?6JWgw4SkWZTYx/l+R0SLpEozkh5hMx6Faxnbx+Nh2UYj1iLmwFyepvVt?=
 =?Windows-1252?Q?H+Insce+Hn8vDnLhJLMYiemmQusb+H2ci2/B+CRANQLQlzapxQLFujbr?=
 =?Windows-1252?Q?MfE5xUgiT0JEyEJph8Qa7L3ZMoQyaAiPfpjJerGhpTz7xoDtW3UOTSRX?=
 =?Windows-1252?Q?k2CswJZbYO7pAwEeL+InWKFvfpSBTVnUcdzrbSCO1XnPEEJjMZepjBR/?=
 =?Windows-1252?Q?UQUjjscK6c5JagP2Jt/pCY12SfYX2+5oCdK8Df2pjoux1+5lq+H/v72M?=
 =?Windows-1252?Q?KEIQRmJ32c/bW82fCTKqxc3aGu8XpCc746R77MNEelSNSuOCEizqaGXj?=
 =?Windows-1252?Q?DMsOH9XbdtwNtOk6507a8iPVAyNr/plIAq/8zGJq66hEQ2nmLxjFoGJa?=
 =?Windows-1252?Q?/Mq6eoLQyeq95N4RRaaW54/bMzvvVRWnIYqbR51Ww71Zr5bIl/I6OirX?=
 =?Windows-1252?Q?g9Yo8il4xMmqt0iS4dym14Jbez+VFnL03JGJC9+v1bZLLHJWuvxvp9M+?=
 =?Windows-1252?Q?+WdSwEV7VjIm4gsMM+Mx+EPgatR0Fjfeny2/+dlpYP/gcTAUk95k2y48?=
 =?Windows-1252?Q?YsOVi7/2B3cuR2D4KGoOdB0wXFYHHkrG6PTQRVGXPDoZFukp20tDgLg6?=
 =?Windows-1252?Q?8QszBWBLpjhGl4YBrMhcHwPlkKio+gVfhFFegE+wC0U0xR5mozUAoZtE?=
 =?Windows-1252?Q?qhSmmOuKurOK10tEIu06VFskzp5twPjiEeo1CMcs8XKUSfKD06lLf/YK?=
 =?Windows-1252?Q?nClS05Gd2ks8vDfb3NnDBXSlpwVAswlJ2H3d7+3KZttv3dF1uZPPvqe8?=
 =?Windows-1252?Q?aDk+dgEJgcKENojEnzy62ETLinA/TnY7n5BmdhMid4nRktQwaPOZuy6G?=
 =?Windows-1252?Q?e2CMdXN6/efdn3G32TtAJ5RMoie4o23Zbmid5qN/eBhPmM4LouDw9Wnh?=
 =?Windows-1252?Q?ydAU3uSalQrrcXPvDWhmVT3PJ7/sdOW1v9Nq9i6cEU6+HEjynF+p4B5q?=
 =?Windows-1252?Q?PeizhChI7Ul1N1dJLpgKKI3+HZu6k8BzGiXip0UV1RKU2yLoKZ/iF9IS?=
 =?Windows-1252?Q?rUaiyUdaLjTwxjl2PmFle9BJguaaEf+SpB6odeHShBR6B/sZoLPH7EuM?=
 =?Windows-1252?Q?fsvZ2Ti3S2F9mGJxnqtl1BUyBWqQNqSPaRZkbQbT7CVXJJbE3YTsbkEJ?=
 =?Windows-1252?Q?6j/U3VSeaVby5z9amiDwdkDVQ5h84kzmw5IjPERMA/alscHgT64F86JK?=
 =?Windows-1252?Q?H8ta/1HRwfuzSA6YejLP5lT1W68iQi0qltqQHi3XPdDk8bRRK9W7aJwP?=
 =?Windows-1252?Q?BQQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ab6dLm85BoCVqVaniG4PIEWso8sWdvBB6nNCoefGLNb6nXh2Uioff9rs?=
 =?Windows-1252?Q?GtYSBpcUSI3AYOeaDH3GhE1/t22L+xqUikmzBfVEXGTLpNBIBmcwkb9A?=
 =?Windows-1252?Q?p4yvCAPqWA59i5SAMsdFVtwdPv/YJ3gJSnS8WKxtgOBMMm3sbA7JzPHd?=
 =?Windows-1252?Q?KyAgXxRAGq0xOFvs1LJhZVZQD3DJsZhwpFYUsx8LibBbXMOfKaxPiF1V?=
 =?Windows-1252?Q?ibf1dTj8TluVPvVAkr0DNsVPto/JTasX53zxvGzlxLe3v7tgegMMd6uz?=
 =?Windows-1252?Q?b43KFgczJnrJjvM2zkrrNjtYxf8+uglQFCVZia3FSrU+nCjCrHBUSO5b?=
 =?Windows-1252?Q?ACm+8RRk7Hbrz//RhZHWRj+xIJHM/wuKXvGct2VKLeMZk4Thp4Fxg029?=
 =?Windows-1252?Q?H+kNhjhdEYdoNPQHpDkmgBcYhJzeddeT8URxg8dvZ1icpcqF44E+fmKD?=
 =?Windows-1252?Q?SBKDxqEGMgNyAbja0/aW0siFI7dTBU8STg0SrQjHGc+gO3icZGqItfbr?=
 =?Windows-1252?Q?UB5dKgfCfvexgCQH/1waMy5Y8lMiDogUkkAukOu/EU7dQDeQvob3da2I?=
 =?Windows-1252?Q?qM/Q1gd+oILF67ssKjEmFt5Z1zeaKSOkcMFlHrgI7a/5+uf2FATA9jM/?=
 =?Windows-1252?Q?iVXskyzBl7x9GDOjSdtieF4nSMvtzfBXGm7ZG1FpUivZcdRIiF9oYLBh?=
 =?Windows-1252?Q?vK4qiFbD+NOnC4eM94h5FSlUvxeNkT0hwPYF2VrXAiPTJHpvDnQmEcou?=
 =?Windows-1252?Q?S+Cn5r3DqTr/1J6Rb0spda4rOOdhkEfdKXumRwSAHetDjxvhBh1t0zwL?=
 =?Windows-1252?Q?VSImn8OtYWouN4OXbG/1iEie+5vVD9Dfyzid/k6UdODxij/8zLXiKaO4?=
 =?Windows-1252?Q?vTq3CKS0IsUV3zr0IZzGqdlo6d9dx4hNZuPjg8zbr8MsLY+3rGqft8FL?=
 =?Windows-1252?Q?PL+hYshHrpcuJEOMnTY7FVkkGnusjlVR7DCuB4L3iqb//Zp4DztfMhFZ?=
 =?Windows-1252?Q?Xn1gO+HawK9eg4gzXFT37eo6iwdiB61IKaQ/Gt6DRIEZos1un60pIlsD?=
 =?Windows-1252?Q?sppJkE41gZMj0/YsiSP87poK5zr0r1Ipy2ADUllEFfM9b300rIDfjL+V?=
 =?Windows-1252?Q?qsvWsdWGzGqBpxVvz9MbxAbB72OM2omOYywE1NjifOjcXBYh7IOLPkTX?=
 =?Windows-1252?Q?NTo4q1MGCfHWXGc7YXZTYCVoO1b24hxpS2bS/uMpvbG6qQxOQxi4Nohs?=
 =?Windows-1252?Q?oRTIGeTTJedfzodwZQYWqJuynfs3FdYxyQk+9m1qS0kI67fLtwKW7KoC?=
 =?Windows-1252?Q?7t6WgWEk2RvxKGh1e7TeaqtdUuwGD1AJ+znoclvu6p4ENN8QWPgSNks9?=
 =?Windows-1252?Q?WdPXpbJ/lnON9KCUcR7Rt1ONf7FRDKbYgVB/8wks19cUvhCy2DYbr4Mg?=
 =?Windows-1252?Q?0bkce8owJ/PxLQpbnrvv3MG7c54AOJKpS24W2LMFa0wimFUgaD5TvOWQ?=
 =?Windows-1252?Q?xoSv2p00PgL9z/3ZpHM6r0jhn+dyFTYHXL60KLgdyrE2ciPajGWhZAye?=
 =?Windows-1252?Q?u6611/Ng9s82OfXCVv3hxBAC3P8K7vpH+R/u/PgSzBEdQmPseFW6ggHh?=
 =?Windows-1252?Q?u0lBhCuUBbv5smq65T46YrrJTLM8pVFh1o+9HSqVWnW6WnSJ4OZJER6O?=
 =?Windows-1252?Q?8KOjoKQHBH0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4170B99C4F8428F211C7CF8CF765ADM6PR12MB4170namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c497c4b-77f6-4d66-01a8-08dd9c8fee1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 20:00:14.5153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c175tw0hh3QZk9zOicYiPUElpN+/9EnMav1s3dHz3YkbrkfSLQslAo/5i/yGpyAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

--_000_DM6PR12MB4170B99C4F8428F211C7CF8CF765ADM6PR12MB4170namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

[Public]

With the change suggested by Harish below this patch looks good to me too.

Reviewed-by: Alexandru Tudor <Alexandru.Tudor@amd.com>

________________________________
From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Monday, May 26, 2025 1:48 PM
To: Clement, Sunday <Sunday.Clement@amd.com>; amd-gfx@lists.freedesktop.org=
 <amd-gfx@lists.freedesktop.org>
Cc: Tudor, Alexandru <Alexandru.Tudor@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Identical code for different branches

[Public]

You can remove BUG:SWDEV-534537 from commit message as it doesn=92t provide=
 any information to public. With that this patch is

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com.



-----Original Message-----
From: Clement, Sunday <Sunday.Clement@amd.com>
Sent: Friday, May 23, 2025 7:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tudor, Alexandru <Alexandru.Tudor@amd.com>; Kasiviswanathan, Harish <Ha=
rish.Kasiviswanathan@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Identical code for different branches

This patch removes the if/else statement in the
cik_event_interrupt_wq function because it is redundant
with both branches resulting in identical outcomes,
this improves code readibility.

BUG:SWDEV-534537

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu=
/drm/amd/amdkfd/cik_event_interrupt.c
index 981d9adcc5e1..25f32771b228 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -125,11 +125,7 @@ static void cik_event_interrupt_wq(struct kfd_node *de=
v,
                        return;
                }

-               if (info.vmid =3D=3D vmid)
-                       kfd_signal_vm_fault_event(pdd, &info, NULL);
-               else
-                       kfd_signal_vm_fault_event(pdd, &info, NULL);
-
+               kfd_signal_vm_fault_event(pdd, &info, NULL);
                kfd_unref_process(p);
        }
 }
--
2.43.0


--_000_DM6PR12MB4170B99C4F8428F211C7CF8CF765ADM6PR12MB4170namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
[Public]</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
With the change suggested by Harish below this patch looks good to me too.<=
/div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div class=3D"elementToProof"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alexandru Tudor &lt;Alexandru.Tudor@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.co=
m&gt;<br>
<b>Sent:</b>&nbsp;Monday, May 26, 2025 1:48 PM<br>
<b>To:</b>&nbsp;Clement, Sunday &lt;Sunday.Clement@amd.com&gt;; amd-gfx@lis=
ts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Tudor, Alexandru &lt;Alexandru.Tudor@amd.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] drm/amdkfd: Identical code for different b=
ranches </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 12pt;"><=
a name=3D"BM_BEGIN"></a></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Times New Roman&q=
uot;; font-size: 11pt;">
[Public]<br>
<br>
You can remove BUG:SWDEV-534537 from commit message as it doesn=92t provide=
 any information to public. With that this patch is<br>
<br>
Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@amd.com.<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Clement, Sunday &lt;Sunday.Clement@amd.com&gt;<br>
Sent: Friday, May 23, 2025 7:54 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Tudor, Alexandru &lt;Alexandru.Tudor@amd.com&gt;; Kasiviswanathan, Hari=
sh &lt;Harish.Kasiviswanathan@amd.com&gt;; Clement, Sunday &lt;Sunday.Cleme=
nt@amd.com&gt;<br>
Subject: [PATCH] drm/amdkfd: Identical code for different branches<br>
<br>
This patch removes the if/else statement in the<br>
cik_event_interrupt_wq function because it is redundant<br>
with both branches resulting in identical outcomes,<br>
this improves code readibility.<br>
<br>
BUG:SWDEV-534537<br>
<br>
Signed-off-by: Sunday Clement &lt;Sunday.Clement@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 6 +-----<br>
&nbsp;1 file changed, 1 insertion(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu=
/drm/amd/amdkfd/cik_event_interrupt.c<br>
index 981d9adcc5e1..25f32771b228 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
@@ -125,11 +125,7 @@ static void cik_event_interrupt_wq(struct kfd_node *de=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (info.vmid =3D=3D vmid)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_vm_fa=
ult_event(pdd, &amp;info, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_signal_vm_fa=
ult_event(pdd, &amp;info, NULL);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_signal_vm_fault_event(pdd, &amp;info, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfd_unref_process(p);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
--<br>
2.43.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4170B99C4F8428F211C7CF8CF765ADM6PR12MB4170namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECF1C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 13:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2115210E122;
	Mon,  8 Jul 2024 13:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xy9buhGY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD6110E122
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 13:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyfoaqrtUk48ajyTdjCnG3ThNDxZYnKO2exZNPmlyYdWL4y5oeetGda/5bJhgsJ1F0YzdIrUQaotHiNf2E1Bcaq/+kCbqOfvPpt1GOi2/oRFuo5NzmlKh/2VVE1UYziKsLG9xoKD7UWKIoLNx/xkaNSPJ9+nL6nMfYMXypULeThQTSymg1TxNu1lwqvhEVFOb09RcbhU95Fp/zWpBJtsemNAb41VTwEKIDZBLgpC47rFOOH+Ck2/sAyFLcUy2AzWP+pu4b8nlnsLdKICPMy62dV/5Kjcdx8uaIVxqTII48XuRfO2s0oPdi18kmjT0TVjsY4DCJqeFsVCAMjM+YAe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rja+W8LCxUbsbuJmZ66GjKQR2uskTniOPC938nID968=;
 b=B+anNXfGuONSPptbgs1gHNwaGu2SOnouADsw6wBLaJe0XLG9atilijnmlKV9hbbJQKHM7H+d4n07xquOOdcKaVZQvzQPbNKHQtaZnKgPueGpVgl4v34+b26im18642paKPgaD2UOSPWN2+FWdBirj3ZVyimtjOD7A4IApAG9kNLlAbpe3Yc4yGiVTzSYchYBmu8kPXcPCTVOEWAwmxjBXQVlumHo/cgPDk1I7RySApVXTVLEgK97rk5iTKIKYo0ICc1BcsKZSLH2mpXhGy332y7orfjDukgx9eAgPJ+wartZshrOpxVrSIeSo6qOMleoPJvAnymK8jAJHCY2ea6Dag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rja+W8LCxUbsbuJmZ66GjKQR2uskTniOPC938nID968=;
 b=Xy9buhGY22OlA1Mw/p6bUL/sYcj9vHJwiNRYA8FwmggF5AkMPClvIzWGJqW84KkOxLyLHdp6aL5+NIOL5dbOy0rtrdZpTLvywKgOtN2N8x4gRMNCibNeQPGRTlQ5RyP5B+gjR760JcEFF4CH9sdakwnMwhLFlMwj/jWLpSTv6Ls=
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:23:14 +0000
Received: from SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65]) by SJ1PR12MB6316.namprd12.prod.outlook.com
 ([fe80::655b:63e9:1a28:ae65%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:23:14 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Topic: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Index: AQHa0Q02BukA1/6YB0OdKIw0+RqLpLHsnLoAgAAHe4A=
Date: Mon, 8 Jul 2024 13:23:13 +0000
Message-ID: <SJ1PR12MB631616923922D94049DB20CD98DA2@SJ1PR12MB6316.namprd12.prod.outlook.com>
References: <20240708080654.31640-1-danijel.slivka@amd.com>
 <DS0PR12MB78048A942EF3DC3BCA019D5C97DA2@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB78048A942EF3DC3BCA019D5C97DA2@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ef577ef-2586-43c6-8422-8217190d077e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-08T10:00:18Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6316:EE_|PH0PR12MB7789:EE_
x-ms-office365-filtering-correlation-id: 30def9e1-6b7c-48c3-c00b-08dc9f511ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0JLHpsZPn2FvQ7Mp4HAPA03sZ9FAi5Z5YfydOWtyO2Mp6doiTeaTAKB0oyWF?=
 =?us-ascii?Q?rB4+An66K8b27D6uWQU1KBymW1FZ5iGlVJOuEuYiC78+1thP6ccrEQfidxC3?=
 =?us-ascii?Q?SU/+i3/kzJ6GncfI9cTTwuLUnbvaunsPas6TyjihmmZcVIMNd/an93uc5E2A?=
 =?us-ascii?Q?i3El88L8OmpirHgejTk5xunhgtkWz14trQhC5p+elUlbnSxyPMSH9htFnovN?=
 =?us-ascii?Q?PgG43DT85TKYyEyYg1DIvRoQUkSYoRwruhUiPrteTjMyzd2OeCXS1xp1SRwC?=
 =?us-ascii?Q?4Jet0cnq7nUaTqV+m9UQzg60DDMuk948UnBJEzGCOQaggCAzGEX7530ZM/2v?=
 =?us-ascii?Q?5gCzSOOSqYygSIJgQw8MlXj2aLGAL45COS0E/c+btrbjsWfEglijy3cYny+S?=
 =?us-ascii?Q?6dKwo76C6aCM7zxobs7G8ovw6sKePC72qCrp4HzXrSXV3JzQdRaCGffGs2JW?=
 =?us-ascii?Q?8QqviBN6yzjZTokiLa0/S3wOmKOmLXClHo6c4PV5Q4rlHgDC6P4cNpCILrSt?=
 =?us-ascii?Q?WR6iK8s22usM/4AjvROdRoYPINYpY46/PldI/4QIzoyZbmyo6itgg4Lq9wPJ?=
 =?us-ascii?Q?d2TeGGySGQNUSHY77JbgpPX9sRD0Ukq+cyKKZTJvXG9SjTWAJeK7qdwA3NN6?=
 =?us-ascii?Q?krj06b9uebycuEKYUC+7m7hSQbesgvYwfGcGzG+U1+DyYlFso7E0+nMYFzgU?=
 =?us-ascii?Q?49GU4ncEfuo/gRfXDeSfa7MwxzfPwwCMbk7YttX7efI/FKMAtysOr4lstMX5?=
 =?us-ascii?Q?Jmd6FkHGL7HsWmzPaCs7vkW2GmqliAIPpZ5bIawAlOc6h71rada1s8EXFN1S?=
 =?us-ascii?Q?kUExdYGLt3OYvP9XJflUOaU3E0Z3yAzZb/NUH8UvrNZa01inG8Z8gK6RIG7l?=
 =?us-ascii?Q?Y3+tl7SzTIz+E7a0XdOP01YgQ95eRnJJGdR4GYGo7p/gCGfMNElfA4SzfYOl?=
 =?us-ascii?Q?EveHK60GxThsBgbBqZ3raTfzTu/7AM65Bo7ePHWp8TuWVUEKINJ4fipcxh7N?=
 =?us-ascii?Q?iSQsKenl88zGqQl5YBdlFks9FkZGQafPoV0sNXlu3bq2OHZh8sB9hSpvoBkc?=
 =?us-ascii?Q?2ED+TXtYyvCmRxsuqaxa0UVLn7HpctDOx4iA7WCtXmobcmrBGNdyyBkVrHxN?=
 =?us-ascii?Q?ave1wMfPInMlF39bmPW/xb3cJe7uk7bkZSSVGrPA5Go4nKb/CSHcXX2Mf3SL?=
 =?us-ascii?Q?Jh9aKY4JiBStu0lURAFJP5qujYUZ302myivnUad7IjOADwSBkIE6lK73tXoo?=
 =?us-ascii?Q?KQzf57J86x3eS5mtoD0+ZxfRJ51FDIwLRGWjn4VmBlnrbYIm+5dBVHqpRteY?=
 =?us-ascii?Q?QEs0PbLVIALw/1HChLuO8POxMM0GDiez54io1gia8TVc5LL2AT0gqN4jV5ko?=
 =?us-ascii?Q?obiThN4adFwa3h5LUSKWDtYGzAxrUWEXNmDFAzKp/GPf+G1Gyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6316.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I1Evjuou51FNY9n8NXY7qBKnzm7EcHNTgsQgVs5vTXnxac9yDWKBdtrXKrPE?=
 =?us-ascii?Q?PxkeDon7KzSbF+Ykg4QXjemfNk4E//uLJccpINnGyFRAax8CF1zfmZ7qUC5i?=
 =?us-ascii?Q?UQeCtw8O++wKVAm9hE3AdZ7O2hN6w5IEzITvC0AcKE6jeGPQH3gBupSuMuwm?=
 =?us-ascii?Q?STiuAsdykc0aP6z2bUOvYqpeK6gP6eQVWiBk2JPQ4LFTUxQaq25vOh+Fb+i9?=
 =?us-ascii?Q?OSAusHkeCXDCE0sG3UqnncTD1ZAsbktBXCqrTVqPUO+XQwfBRwo/E4pmkSAo?=
 =?us-ascii?Q?sVOnpMsKH4tujszc55P9x3bTwPcCEKrtaGTtngJ5xDOKkTJEqfV2+nwX7G/v?=
 =?us-ascii?Q?k8rSYXAGz6wT+pTRUV73VIAFDEcCWsYwCHLpPMy20m3iCJTD2b+cZpPUCEAT?=
 =?us-ascii?Q?pPafyyCLKA9XfGRd2HP7pTtKMO5dJQarnspRfEDOb4eY0oTrSXXrtKV7zAvw?=
 =?us-ascii?Q?NugMx6BTp74RgvH8q146Di89YpRkAG1xl1LoFEBJ5tZPUn9Ve5qL5sYKZgJz?=
 =?us-ascii?Q?wiYSvY0K1Lmf0s25CVzAUJd6x2XIpwPtFtQYK/tWRgRpbeXjTNNjf6noHKPJ?=
 =?us-ascii?Q?LneyD6F/gnjllon1xbBWNLX3oRyRqRI008+Jpr4/E5VTkzHUdaTgBL4VAD+L?=
 =?us-ascii?Q?qzZCxnmegJe7kcjN+F6Y/PODnEf8oOakJuJfsXj4qx8B1uJCmLvF6K4ZQSil?=
 =?us-ascii?Q?TSHbquubgytd9bmo0dwGVeakiuR5ZWh0bPAybAnpU7NzhQNrPFMwCvYqtH+1?=
 =?us-ascii?Q?sEX/szq6JVuD5gGLzRhHzKP4TrcJu86oSkEaRMZd09cSgCVftnCCzJNi3pGQ?=
 =?us-ascii?Q?3ltmUlGW8Bf22NWhT+gSIcuiuHV2sqaqrL6r1ahBy44oCTKJc6Ar0tzTjkoc?=
 =?us-ascii?Q?sfcej44rYHVa6tsVR1vlLRMLuKh9PEr2lXAmDp8x542ap6e/xf32QRrpf1O7?=
 =?us-ascii?Q?M6ebCBoWmx//4nffCurHq0giiCZX+cF4bhXE8z5Gut6OvIH/+5VBZjRP3lPt?=
 =?us-ascii?Q?sUdcodzadYyrfE1UEO6SFNVQJ1bsNTGGmGPaBerLWqiILmJISARBmZWgcJM3?=
 =?us-ascii?Q?d5qdF6ubx4KCxEXsD1+UHLpWqLeDSHslWj3XxLiLmLOPpr+nx6OUWv//hLTe?=
 =?us-ascii?Q?MwBR7XlgjQQMuqwmdbrDK7I93poEQcKZNBN2rCVZUcf8l9AoGwjzuxK6LRwu?=
 =?us-ascii?Q?uz+VFdF5K9J3j5htnEN2kFfw+u5vZe9TFkTf6kGZBg1TYV5Z+DZOfCbHOKSj?=
 =?us-ascii?Q?GtF8TnXYApTy8Uw5hvrwOmcrxCR7e6jD2pTGiymLA9x6wqufTYoP8ugmdr4E?=
 =?us-ascii?Q?c+QCNQidTFj5esq22YRkbsZUlUHM7TbwZfv0NRt/d+Fv00OZv24HeHiKAWu2?=
 =?us-ascii?Q?CH0xahDwrP79h76jmvgcLSJsTgpBeLlAJRxEUFTdqMaGIrFiaopAV+66NPiI?=
 =?us-ascii?Q?mkN1gI8d1SH9HABnRCPmVqIoseKqjUEz+Azh0zAKJFOewNaxkFgxEI04DKb6?=
 =?us-ascii?Q?MRmnOIX+QdjXo4syYiXjPxGpZsl5/fjT4wTl04O92XMET83JlHQqUXjlWbad?=
 =?us-ascii?Q?JSrDVIDH8gl007LzaFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6316.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30def9e1-6b7c-48c3-c00b-08dc9f511ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 13:23:13.9418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHOg7sKjH/BExtRC+gGF1MIRf08yg3avd+UbaIXds5TgprAumLiYq2Z8LiZJzrq+vXyMZAAglkhhp7R5GL6RDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

>-----Original Message-----
>From: Lazar, Lijo <Lijo.Lazar@amd.com>
>Sent: Monday, July 8, 2024 12:13 PM
>To: Slivka, Danijel <Danijel.Slivka@amd.com>; amd-gfx@lists.freedesktop.or=
g
>Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
>Subject: RE: [PATCH] drm/amd/pm: Ignore initial value in smu response regi=
ster
>
>[Public]
>
>One problem is it's also bypassing a valid 0 response which usually means =
FW
>may not have completed processing the previous message.
>

Bypassing zero value is added as 0 could represent garbage value.
But adding HW_INIT state as initial state and ignoring any value when HW_IN=
IT state is set.

>What I thought was is it shouldn't even attempt sending a message if it
>identified a FW hang.
>
>Is there a possibility to have the same problem whenever there is SRIOV fu=
ll
>access - as in before/after reset etc.?

Yes, this could occur every time when VF is in full access.

>
>If state =3D=3D FW_INIT, ignore response state before sending the message.
>If there is no expected response to a message, make the state to FW_HANG.
>This part is tricky as what qualifies as a FW hang could change based on t=
he
>specific SOC's message. Avoiding bool for this reason; to keep it open for=
 having
>other FW states.
>If state =3D=3D FW_HANG don't even attempt to send the message.
>
>Move FW state to FW_INIT whenever there is init/resume sequence -
>hw_init/hw_resume?
>

Applied the suggestion and sent out new patch v2

[PATCH v2] drm/amd/pm: Ignore initial value in smu response register

Thanks,
BR,
Danijel Slivka

>Thanks,
>Lijo
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel
>Slivka
>Sent: Monday, July 8, 2024 1:37 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
>Subject: [PATCH] drm/amd/pm: Ignore initial value in smu response register
>
>Why:
>If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver
>load or driver unload, subsequent amdgpu driver load will fail at smu_hw_i=
nit.
>The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is
>0x1 and if value differs from expected, amdgpu driver load will fail.
>
>How to fix:
>Ignore the initial value in smu response register before the first smu mes=
sage is
>sent, proceed further to send the message. If register holds
>0x0 or an unexpected value after smu message was sent set fw_state_hang fl=
ag
>and no further smu messages will be sent.
>
>Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
>---
> drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 +
> drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 +++++--
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>index a34c802f52be..bfe08fa0db6d 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>@@ -562,6 +562,7 @@ struct smu_context {
>        uint32_t smc_fw_if_version;
>        uint32_t smc_fw_version;
>        uint32_t smc_fw_caps;
>+       bool smc_fw_state_hang;
>
>        bool uploading_custom_pp_table;
>        bool dc_controlled_by_gpio;
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>index 5592fd825aa3..9e4e62dcbee7 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>@@ -421,7 +421,7 @@ int smu_cmn_send_smc_msg_with_param(struct
>smu_context *smu,
>        if (poll) {
>                reg =3D __smu_cmn_poll_stat(smu);
>                res =3D __smu_cmn_reg2errno(smu, reg);
>-               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) {
>+               if ((reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) &&
>+smu->smc_fw_state_hang) {
>                        __smu_cmn_reg_print_error(smu, reg, index, param, =
msg);
>                        goto Out;
>                }
>@@ -429,8 +429,11 @@ int smu_cmn_send_smc_msg_with_param(struct
>smu_context *smu,
>        __smu_cmn_send_msg(smu, (uint16_t) index, param);
>        reg =3D __smu_cmn_poll_stat(smu);
>        res =3D __smu_cmn_reg2errno(smu, reg);
>-       if (res !=3D 0)
>+       if (res !=3D 0) {
>+               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO)
>+                       smu->smc_fw_state_hang =3D true;
>                __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>+       }
>        if (read_arg) {
>                smu_cmn_read_arg(smu, read_arg);
>                dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x=
,
>resp: 0x%08x,\
>--
>2.34.1
>


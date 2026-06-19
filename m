Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6741FCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A776710E0DB;
	Fri, 19 Jun 2026 17:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8rfIl/1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013022.outbound.protection.outlook.com
 [40.93.196.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF45110E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqTxMGSR1idbd/nL7oxhJow60OvWTB/AO1cdb7yvSwsZdqUrwm32jlU5/xniY8NWKUFuFAqOu5PPK9MWXA6bQK1Lh++nMoNvMIsYmmfbSfByF+eDCuI6zSDCQZVvDoaPaRX40PJnFjjzaa8urCG0wgz0I4Ref6nAHUa2W3gHY885QjQ7e4opl3oK8TLhngnVT0G4imZf5b0m0E0amAdLk6/mqzMeOrTRzhpANgtJCFpa5shtshTr1Avx+k21YoS+3VWM7uowvzQpZ50Mc/SDV97v/HzZGH90yV05bY6/4UwlKp1KGBkU2isZ0yVO9fyBd6j/fA5+zUgLUo0vSdIPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDWSPp5z3W0PAG9Y8xwUS8rK0gPOm57zf5dUD5O1BW8=;
 b=kjDdUhMooDxb7nzXmhAFrYAMO/lY58Fw71pNp23/VTY5NrnsHJE+L/RIJ/va6HlzEmJp9SQgoqNjAwXJrJhvT+T2kElXOpMhLJC4aDpgCnTpZU0t0d1lWs2BAMPcYeXVkwHcHu+mOJNZMn562kUZaAq1gv9/N4JexepsXpNjaqfT0ES1JGuWTVLk6kESQt9aP3QzqBJUKEEuS970PYWe5a35Vlm8HoWgDOv2ZoPRjNQQT+AqGglr0rRo5DbTd1lUfR+NFyUWSaD3jpPXsBSRmL91M7a38Dz/ACVUbMcTGfSwd2Sp9Qgjjc/x+dwuA3lpU1IO57NAJuV5tov1sGeogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDWSPp5z3W0PAG9Y8xwUS8rK0gPOm57zf5dUD5O1BW8=;
 b=R8rfIl/1D3i01ra9avkjI81zHEUqnrzAUMX4vsjkURSBk5i8/iTD2hMw6BQTI0R4Ynw+m2JBoYdAEvIjSy6Ia2X1GXRA/1CwX+c0H5GcF4AdDSEOtGbPQcN88Ia1JowHXOA9eaWwn+GyqFqZTUOEOz+k3tJzKmiZYmP/SWACYK8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 17:04:58 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 17:04:58 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: change a PTL warning message to debug message
Thread-Topic: [PATCH] drm/amdkfd: change a PTL warning message to debug message
Thread-Index: AQHdAAsyzCvyP98JFUestB3WEOic2LZGGxNw
Date: Fri, 19 Jun 2026 17:04:58 +0000
Message-ID: <BL1PR12MB5898202E60A4F9B4510095CF85E22@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260619164558.93761-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260619164558.93761-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-19T17:03:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DM4PR12MB7718:EE_
x-ms-office365-filtering-correlation-id: a4201141-68ad-4622-0fa0-08dece24e4d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: MFyQXUWqYqCOzqKgHUw8SMPDFt7P6TB3u+W98PoePeIH9YE7MHKN/DjPa1O7D3PEgmFFiK/Pv+Ekv/67bAV4ZGbRPM4v36ebCLsHleXlP6DlzOHAs8EpjvYhfc/MegTFs1Ggel2NGgMyncUtpjvRFogTUQeJ1yFonNJaFZpegMUXqB+J0EUQN/JtN77xD5CKfBnoCV4nHveOlPfYbODsQ4aQzGY0HkYawUSGjamFQ2GseIVQ+0ku2OnpV3xPcpE9tYOV1p0xddbDNvnfwEMnQSVBboFbNzjAZ04+0e6c0afxYdek1UN5lKe+HJHNciQHLSxYl49tr2ratqDX3Pd0LRe91uSAYtCRRbIWYXkuw7tNeQ1r88q2yP7NkRDAXFACLPctMrAAHc0iYgLa7kcdpRgRJFap8ri6tBFfZeF8epXO+wj8P8L7sZf5IVWQRt1dV+KDnC1ZKFVvpUD9vGjKNwsmPx3pKh43HDmDKRbP1Ra2b5nnn62i/Q7UNEd+ZrpipPs7uhy9KDsv2QQXr6o4DEaRdf/ORuT2f/KY2JKd9twb1IhUZ8yDH/dVNvrbCmmI/Urvrj2DN1QaPiUxeepivrdJrew1OhS91le/Asz/Sc17zbxbyHy84XvjNBRXiROe4xqTlhnyKOiy84mxl65t4ps9+wpT07w96571OZGCNOs35+mhGXocytgEziDLDcSXhpNnl5IishnEUv+LNOP3JbT1aIG1Uehw2ogWj6IYYhk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBjk7iRDQXXjIzxH8Xn3EnHwJEkETEilXFN+PjMMmoaKa7shDsGccMCuvXCA?=
 =?us-ascii?Q?7BvEoq5GFEGn/gBTGsR33Q9xuWK1R7OuzM1e3x0LI/fIgsbI+ymOZSye24Yo?=
 =?us-ascii?Q?vcGOGkKGt4laGgYT2RdYIUn7MImsACPqYEIDoD0T3iPYFgzGwmDY97ZRbtIR?=
 =?us-ascii?Q?QxVU2bavVGtXMeRRAddsqymSV/NbfJH/EG4XeBhCTMCS/yCgxgRuI80qghpe?=
 =?us-ascii?Q?xgAEox7SYpPStraMNhM4KV+RBz1TIVBtMqUlmx+ENDbJHrrXiw5rZ1iRtZsD?=
 =?us-ascii?Q?L0J8tdLJ9VbmKLMWh9U5wmvWQvHcISzNVUdUCek2b5B7LmCtaosoDnbcOa85?=
 =?us-ascii?Q?g3XISdPTAENjqpbEhU3VkrSUS8JYmjagJQcpjkthHpMnEdoOvEIVz4p5jH9d?=
 =?us-ascii?Q?xu2H2RAhcz2E+zMd8cyhcZLgKYwNs/9UoVxvhAV5d++EXMWlg7lwFnR1hr0q?=
 =?us-ascii?Q?v2u4BWG202EUYjzQhzevcol2aXmvcsYrHKGgLxGsRwU01ADGgv2kSP/+vVhS?=
 =?us-ascii?Q?JuCta/Z1f+Fg0yryqgV1jhRUoMbOm0/kGXf9lBY0eFg1xw20SjsjWEnTk4aK?=
 =?us-ascii?Q?U6Aj1wpbYChyfRy6Pa/pqKoH5oKL7oDGerM6+8UwtUqD+3HjggoDIQ/TKrZw?=
 =?us-ascii?Q?n4XEi07lMaAk4LePQUZ4/0de0xGRQyaOLnrSwD1mTGuPNJssfbhXrrP1IzBf?=
 =?us-ascii?Q?WVgVO+ktEZVjjkt7MiJQkAj5HqaRK8NXJA5xZhB0Um5ehunPCGh9Q6UOuHQ0?=
 =?us-ascii?Q?9Q/i3ighVeGHq/PqJPpUOnRNXTIROB1+KQ1AgmJKLH+vWER0uqFCdgIDGDwh?=
 =?us-ascii?Q?G8cblkSNOUNw1rFGcIRgatxwk1AEohnp5KBSGmDUjmV/lloe7rYtnY/RVsga?=
 =?us-ascii?Q?V44BTLqmlbA2Mzc7LWu1AyPfoNmKDWhCAsMdW7pdiuwYkng5xNH7umaziW8h?=
 =?us-ascii?Q?/mA2st0+Cq3UyhuDUGOJ7ElyId8Hv1OIKIb8qc9M9YmBr+dsEiUXHgyI5P3A?=
 =?us-ascii?Q?+q839lJ+rr0xMgLn1PBxtxUAdS6g40JJBKdlDiovq6KH1Vcpc60Rm00Bh+Hv?=
 =?us-ascii?Q?edcG7lbqJUigryOGHLzbeT+ZSf4LUDjnF5NeFWQbGtk0h7Gbgn15LeDwCjOO?=
 =?us-ascii?Q?lIyYBLNNxTh6t6gvyDbefK8A/ollfvbE6N2SmrWhPJrjkta4ZUC4xVriJ7yN?=
 =?us-ascii?Q?2e822uio8xHexeJeyIvpseVphfJyvl698ZAi2/dmwP6jXDilbusrXeNfEsnm?=
 =?us-ascii?Q?/zguo6Dh4s2slgXPzVpbd4tn1Y1Ww8rHKd83W1uL8PhNc7/HGuNx9CQR6wab?=
 =?us-ascii?Q?N6WIMM1keUAV5fHHnczGs59AWHsoHsP5zagWvdcuR6DX86tgfsLVebSMUwRU?=
 =?us-ascii?Q?ea7MFm8TC0WrXWa+v/hcpEHnJsqufuMPq2GeXFpgjBSyDRsVGzqB54pORcFi?=
 =?us-ascii?Q?zJ2sGEyTdoS8Ut32KzM+G1jCxLxxiwV18LIQ9exV5HeVFOIdTjXPSudrF2zY?=
 =?us-ascii?Q?jjlLCiVjjgPO0qgIMJ8CgxmwnYb0H1feiXJTU8u9fY6wasPJCPFE7H/W1vBG?=
 =?us-ascii?Q?tyuHq63+K1ZdM9MQk6JEsmRRo24uNmnbxRM1/oy3wuA67aHjjKPtRx4+aEHX?=
 =?us-ascii?Q?OBZmxpvpmFwlQjV+oUqiP42swwugZmKTIJwk6KU67y1otwQ1Tyv+VYLKE6hA?=
 =?us-ascii?Q?xU43kDQhN8NpzoQ5s2UcSGiI5Gl0soLueqASwrORogdJ7MFE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4201141-68ad-4622-0fa0-08dece24e4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 17:04:58.5983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWZPur8ArJSMI9SweYbMtn7dQz9YcSMyGpXWs69Ea/UYssmUwd8t9Srio8YZCtTMnWQkI6sXuAxV196xGzzxcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
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

Shouldn't we be putting an
if (ptl->hw_supported) {
Call in the kfd_profiler_ptl_control function instead? Instead of papering =
over the issue, we should only try to do the function if ptl is enabled.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric
> Huang
> Sent: June 19, 2026 12:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: change a PTL warning message to debug messag=
e
>
> PTL is a special feature for gfxv9.4.4, but the warning is
> always appearing on other ASICs when rocprof is running, it
> causes confusion, so reduce the message's level to solve it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 575b13b557af..566955adb58f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1813,7 +1813,7 @@ int kfd_ptl_disable_request(struct kfd_process_devi=
ce
> *pdd,
>               ret =3D kfd_ptl_control(pdd, false);
>               if (ret) {
>                       atomic_dec(&ptl->disable_ref);
> -                     dev_warn(pdd->dev->adev->dev,
> +                     dev_dbg(pdd->dev->adev->dev,
>                                       "failed to disable PTL\n");
>                       goto out;
>               }
> --
> 2.34.1


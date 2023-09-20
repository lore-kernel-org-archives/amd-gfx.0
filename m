Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A12CE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 01:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230C910E14C;
	Wed, 20 Sep 2023 01:56:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB7010E14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 01:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhNa79p1taZhNfbnT4c39xnM2kiG945NyoHQvqZ2kOGbk2SDNa28GkKljMFmGt3+VNOfC8xQOSHIA/hczQUCVg9wsyGwxH88UUNOjJHakVtQMYEJFoE2eFuTzy5iNVfHsVSZY6eG5PeCSrCUyh83qbIN7dBv4S2vDg8iIcYRAVW6BPrR5JTIysYxsbI0W9jV9J2PO1ssBingz+0JZTpxgZE43idXlZILR0ArEIkq4gwifH7xEkMLKlXRpgh/+davPt2MpGnmNCeaFrFTSDUbinBiX346/cvTSt4l7gjlzPWarxS5jyBSwLXlMFpDlqi6WjD410Twb/M168vav3PFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0xPEiddojXdY4cHl5IqgsZdYGxxL7fT1pwUTo6GJxA=;
 b=UhBlG8hUMD0p8OycEajfN6ax36SG8P3508OX3RGNc/Us2DJ0f61oNc+n+TDRX0OBNkRTZXZLzDdTWlWKpQN/BI1AZRQRpy8oepalMv4MBfL/DZ2y6Fi2D8tA+ezW0Mij5wBziLOaOLoRUW7YNQvpsotWJgm6bpz+dSCkPsz3aeZG1nSCNDEtCjdGVvz01IW6f3mfrrHdcQm64xycT/OiGiiUGue++wNfDw4bIXp1cMfMcYklakBTNPh3Wo5lX4Y1eN2n72McFmqUFqSOGybU3hov4G2zu9orjT8gCqwS5gTr5CVVbNCDrx6RxXr+ymDYIwkHq7A7DGrR4eUyxjPjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0xPEiddojXdY4cHl5IqgsZdYGxxL7fT1pwUTo6GJxA=;
 b=0M3JEUk0vSxI+n0MtV4xYqq/tW/CWYaB0D+Nkvh4kOKYG1RHYr5mLAKf2u2Nfy4tA01qIGG5sZxfzI8jDjH7JUo4tBYy7/zE+OWiEkVE9XeoQ1Yqsng/CKQ9mKH3BSvPpAkLoMJ3Lwsn31/hJVhVQL9Xv4ctRBTAKNs6kCCS4Ls=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 01:55:57 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 01:55:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Topic: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Index: AQHZ6uFxCaRzLyIvNUeZEvd2bRHoHbAiR6YAgACtlmA=
Date: Wed, 20 Sep 2023 01:55:56 +0000
Message-ID: <PH7PR12MB879647B49A70DD44E89FC3C3B0F9A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230919100936.8810-1-tao.zhou1@amd.com>
 <20230919100936.8810-3-tao.zhou1@amd.com>
 <PH7PR12MB5997FC420ADC892676DA822982FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997FC420ADC892676DA822982FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6c0d69c6-65cf-4800-9696-9e437f8ec37e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-19T15:28:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6897:EE_
x-ms-office365-filtering-correlation-id: a9a059f2-881b-45d0-5975-08dbb97cbb0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHBJfebdyITtNcawfp89ZoclaxXEDKxVn++qOxGvsTreiLLZRJuH7fSZvfPHXVSnzErCUnOgk/RUXLZDYVNPKDpfyM2qVSgNuW8gO4GWd5RBsn6strGQQhfLDmGjlgMk6uhRTj/tRMeyEDWeJNnSiWcHDoeXw2/FSiPIg1hwOdwyu61fsKA0pdocpY3VWyP0NF9SLRQAJz078b47jsuDHJRYf37sA1B5SRa1SNozwSaMnGaChUunWiTnGmFk+00Qrzq+x+NBbxIdq4xQUNR6R6Ljj6BZL6lJXBTHK3HzpqyvlFlGeimg59NcexMTZbkFdqulOs6RsFogzxVaq5bv7/oknGylgIgStjpd1o0jSMhayCAnl7z67NpBlF+2p2KU52AitHxs9CqM/47fJzE1wh4riHWOt4sTcNjp5hDP1hZvzXnmrVWkbh8Waas+b4SWkU8wcAavsHzEVcCbzAQc2MaeD7+M+CNkzNrZRZDgfALQjKZVRXnQ4vYT1eSVkLzyABPhw9/iW56T2Cy0cXDsnUrDBh4COqwb5yU+sPTY4ERvP5H6/qyhsD6kPYPij5PCkFPVWZROEVG3060OnrexE3qp2SWDOyJX8NjrRX4eW5SmY4EEX8hJWV/TIMfVycVpILKbErNEcN58sInxggQ3TA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199024)(1800799009)(186009)(53546011)(9686003)(7696005)(6506007)(71200400001)(83380400001)(921005)(38100700002)(122000001)(38070700005)(86362001)(33656002)(15650500001)(55016003)(26005)(110136005)(6636002)(316002)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(41300700001)(2906002)(52536014)(5660300002)(8676002)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9iIdCTcQLe2riQHbzI9XQWKqkUJGonfMr7D3Io0KawdGxfMG/FtGBM0piZzl?=
 =?us-ascii?Q?F73wqVp2i4r9smeruajkQoM8Ur8jDEnUedRMVfHPKkbfzmaaOc9ZD/4aV2bI?=
 =?us-ascii?Q?7l1BYSFPk45pH/6572QpHQ/T6kzcxtZW+NIL2SZ8WcMrYtocYMSH/NFA2c9p?=
 =?us-ascii?Q?pvcZQh5Vinaeimt0efLHl7+BfOicFLT5QLh1VwWp5vsWTd2BHyNCN4zLziAU?=
 =?us-ascii?Q?pSallLTnUyF8fwYpOq7NjM1HDlh7rCQTlXB/OIgHOk721sheFFGSON24W2jF?=
 =?us-ascii?Q?NoiaZHPMGJhOtZdlLQxC+FlKdOuI8TktohqxybyFTAt6eR4zf1CirYwvxiaY?=
 =?us-ascii?Q?5AC+fcByqRYPV9dQJaURno+g46bdVy+wOf9VpA1MBvauEx966oBb2m988k9u?=
 =?us-ascii?Q?L1l4tMao4CjyjeWcgYH5TxpDdtC0tfW83EY2BopSx7l7tmSfoiRg4Zn0bMCk?=
 =?us-ascii?Q?xRVq5KYHev2f3kfEZWnPNAkqJuBRd7CLkIygWomwBnj1RXzZbdxxTjweFAhX?=
 =?us-ascii?Q?HtLhe9j3skClkIgfke5OMDNmRXkTqnzdeTIWbPCQWNkofKwJBJ46FANgWYk7?=
 =?us-ascii?Q?1U0YDkbQ+IPsnRb+POoYK5hdTFQ+bv1dV0RMFM1R15gPz06Cz9c5Z7NCiyNa?=
 =?us-ascii?Q?E2M5lZ+/nopjSnPpvWVoxIof/JjzuQWeBPwfTUF9KBWxUH5KvpZILPIWIPCR?=
 =?us-ascii?Q?pBVl//9WpUZhRjZp2/xbVEAGOC1wIfSz6Dr0zS5bVndjlk1iul3rbCyzOJpX?=
 =?us-ascii?Q?r8lgCzYmYhJ7bkdhXiooHvOvxfaxKZ0SCtXNw9WDkVoZ6mQLJ59h9lxH2sP+?=
 =?us-ascii?Q?6mR2aw9jpXgnwzAfRIo291sr7YRn4rRGRMEu0Yku3tjjUv8nkcCLSWgkhUX+?=
 =?us-ascii?Q?/p4IJge68BGTFFMhUOq+T5XPcEjg9NiDvhQFPoF0OZDDBDCkAYYm45t7IXxh?=
 =?us-ascii?Q?aW/7MUQ5dm+CTCgf3+qpxUG+OqNVkp+bT0rjrNXTA9acgNQClwLk5r5qU3Br?=
 =?us-ascii?Q?IHU2Gojg1QKf1r39ITjtpTqUc/SyPd5PNzPhdEta/hqHgqjstenrY25QgOrn?=
 =?us-ascii?Q?C1GJ3CfhwMk4CtnlEbEr4EgAaQ/fCxplcqW/FDhz1KEstXHSOCm+mkSDkp/f?=
 =?us-ascii?Q?mD/OZRFYoS0eWkaHmurvs91SxITuXSSN1/u0kG4Ijc53hz2G+5isv3Kqa0ko?=
 =?us-ascii?Q?oRrIlqH7+vtK6pFjm7mWbjsoPV/WcgA6X2qddnOBhK0vGOGgJc2A9ruOcGJ+?=
 =?us-ascii?Q?Jpb3nlL5oPgP1HZO46cJ/wGw/ObtpBsu2wTYzrgKEE9zek1dov/kmIhxTOJv?=
 =?us-ascii?Q?SZVKKOFPtsfCiPBa7IdZIfp5LEnAJt5Y9AXlRWcaffQ+ZFGb1v1WAI8bQ1bg?=
 =?us-ascii?Q?Om2bKy0I0dWxrcJD4pOpf1ce3tBB7c4qwBobQVBIj/qWqMdxgXh337BoUXfc?=
 =?us-ascii?Q?Amo/Y/RUkNXlLIiHt1IdJtcDLn4vP49piAlFNMXeq+WiRtm8/uXCVXa5xe1C?=
 =?us-ascii?Q?74JorrTpJKD3KUnVcUr3diN714gNpi+3dBnIan2XtGCK49AYZ7+6wN7F98DR?=
 =?us-ascii?Q?EXOHbNH6wGL0cXbKfAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a059f2-881b-45d0-5975-08dbb97cbb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 01:55:56.8017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paHUV6+i3kiPbsfAF/fWmbuLLFbM/s5XFy3QQAvNz385EeGEmUBfbgU8yWM1q0x4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
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

[AMD Official Use Only - General]

Thanks for catch it, will update the patch.

Tao

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, September 19, 2023 11:34 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Li, Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
> bitmap update
>
> [AMD Official Use Only - General]
>
> Hi Tao,
>
> Based on your description, I think you should use BITS_PER_TYPE() instead=
 of
> sizeof(), right?
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, September 19, 2023 6:10 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: change if condition for bad channel bitm=
ap
> update
>
> The amdgpu_ras_eeprom_control.bad_channel_bitmap is u32 type, but the
> channel index could be larger than 32. For the ASICs whose channel number=
 is
> more than 32, the amdgpu_dpm_send_hbm_bad_channel_flag
> interface is not supported, so we simply bypass channel bitmap update und=
er this
> condition.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 8ced4be784e0..1c4433f22f4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -616,7 +616,8 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>                 __encode_table_record_to_buf(control, &record[i], pp);
>
>                 /* update bad channel bitmap */
> -               if (!(control->bad_channel_bitmap & (1 << record[i].mem_c=
hannel))) {
> +               if ((record[i].mem_channel < sizeof(control->bad_channel_=
bitmap)) &&
> +                   !(control->bad_channel_bitmap & (1 << record[i].mem_c=
hannel))) {
>                         control->bad_channel_bitmap |=3D 1 << record[i].m=
em_channel;
>                         con->update_channel_flag =3D true;
>                 }
> @@ -969,7 +970,8 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>                 __decode_table_record_from_buf(control, &record[i], pp);
>
>                 /* update bad channel bitmap */
> -               if (!(control->bad_channel_bitmap & (1 << record[i].mem_c=
hannel))) {
> +               if ((record[i].mem_channel < sizeof(control->bad_channel_=
bitmap)) &&
> +                   !(control->bad_channel_bitmap & (1 << record[i].mem_c=
hannel))) {
>                         control->bad_channel_bitmap |=3D 1 << record[i].m=
em_channel;
>                         con->update_channel_flag =3D true;
>                 }
> --
> 2.35.1
>


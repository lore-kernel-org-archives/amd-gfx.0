Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60537C678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 03:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFE510E0A0;
	Mon,  6 Mar 2023 03:05:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128EB10E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 03:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn6xbbDsi6o8H80c8qlMPgwOMkLD7TQAlst4SQH98Skv6L1v64IsTviaMv7awibAWN51rj0coZ6Uuold+TbObSiDRJ/mMHinmTW0uwDPEj+Y9QJI5TqVQikeK6X0t+84z+v1cx2HvfmgYHF7+IFRnxMLQfvJ53ASClWinIyNbigBDcHNxg4GKh9XAgTFb4AU4gKA99ViumvRVdxBBUGdatBua/DI3Uq28Hyachx7SBJ4p894X3OLkT3+4bH4YvfqfTARVlK6+B8V9Y+MtSj7cWGcNN4FYBkPsAzn2F4lkZkmOSLJlfC7Y5WOTJf9BUKtV70rEjVfTalEUdFko20WBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P65GIQaLXVja15F9D8ov/KxQrwZN9PxSFV/93dvYG5Y=;
 b=YpsVhSsVstFFuPYCxBs+X7eqwH2vbwtZUxGIynKUGmdbJqU/MXJ35zHFOLm25IzXlcosNVlIhBNwL8zIYxlALwLT/MNUD0TrPUKSd+D2JGW0CUa8MzkeQSu/urHEfIACFMM9LOR+tJXW9Dak4vtYd8XVZtWNJh/8a0mO1fsA63LTcvJjTWi/SC3SSbuB0/Vv1Xph1C6bnmYj6703qFG0gGsAxwd7zrP0PkMUnwXrq0pyGwRcEJHg5LLRmJcgHaL1HU/e59unUKJ6vEGhWXmw1fkW23r0C/CXb2CU6Xqa1J8thw1NzSr+kWDoBBzQP5hAPXcLux+Im9ziPglTHaV/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P65GIQaLXVja15F9D8ov/KxQrwZN9PxSFV/93dvYG5Y=;
 b=vD5uNh26+pJKTiZMNpzY5LLN+05BX/fn8ybGEFRpXK3U58ev4+HGpT9Fde7d8jgKfJsKLJWs9Nson0mgwV7kr4M5cNQvPeZ/A5Qkr5Xf+74uY+110jNA7l4+wAK0hu1pflDlrltPNzhm21u0tsRLg7qlBJVyrHhBNbpv4qvxrY4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 03:05:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.019; Mon, 6 Mar 2023
 03:05:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/3] enable new capped/uncapped power profiles
Thread-Topic: [PATCH 0/3] enable new capped/uncapped power profiles
Thread-Index: AQHZSCqWm/NINRtUfEyeCX6QV3tcgq7tIHaw
Date: Mon, 6 Mar 2023 03:05:14 +0000
Message-ID: <DM6PR12MB26194E1BDEB6DB4310618148E4B69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230224083235.3448477-1-perry.yuan@amd.com>
In-Reply-To: <20230224083235.3448477-1-perry.yuan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-06T03:05:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ba09d62-feca-4472-b5e9-02c13d2d3529;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB8546:EE_
x-ms-office365-filtering-correlation-id: ee5df9b9-145e-413f-0c70-08db1def9b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsC91b0Yg72QzniL4PQcfjs0+q9/aneJulXx1udD9vryrCz0iF8dJnicJVVbKxU5Cxox736FBHrtZeuJVABLZLkXT2CXdV/d8wWAYFISBXtZjAr70h6D9nt2PghpccTmOW8YDvjZlD0BdSnDek5vqgcVsV2YbgAlTz+j/vQWNaZOQ8bmaOfxXoBW+uJnFxDNOk5q7CnQZQilVSESRYYRaz47tZHiX9hSPmKe6jHZgXbs0PoBP/xrnh7iaLu1TFz2dsbd1W3Grheac1sWiY1Ye9NsgJupsg3LdV11nqZ1BAiecQmrqfrzY2YAwAC2ja3vM29LuX76thj/lnBXcSqEB2VgF8d0klW+ks9ioGxqMJA/HBzAN1gpvdfjC6UMqz2jTXQ9F1dVPVb42zRRvjTt8ZwSERKL8rwBxYj+JZICok6w8358MzmqlKigUMLspOgqXgmcKOr6Q4E0udYAYLQXFQ40kKr4lEu8IfjXCt7dNRgPbESgUeJPkSOLSkLYZ74EaJKdtNZ6M9/j8ZZZboxmAn1V1nA/PAE8XXaKmlnT3ML4uZczovfQkzroIO7U5x6WtMLX3FqZO45+w3THaJQp72budhQTr7lPbRWcGZ5s7MbvLBHFLYl7M+KT3oU3DBAw5oliTZo7XijbrcZxWODXBweWsmD8aCX3qqFhKBUfQH7F6+h/KtzFuh0FQM5ncRyAU7ZrS0y4rkDZfgNnJBO6Ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199018)(4326008)(8676002)(83380400001)(66446008)(66946007)(66556008)(64756008)(66476007)(76116006)(186003)(26005)(9686003)(54906003)(7696005)(33656002)(316002)(110136005)(478600001)(53546011)(71200400001)(6506007)(55016003)(38100700002)(122000001)(2906002)(38070700005)(86362001)(41300700001)(5660300002)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KioL6Subv3tzXYpr+XEj/cITsXSQ1Tln2DNok/cTWLHsvjhl6LEmuK3lRl6R?=
 =?us-ascii?Q?NjB0BHXSYrk/5c030fbn5RY+yBQNw5EmfXRoGXcaYS2rkAW3c412/4E7Y+mV?=
 =?us-ascii?Q?yljy/tz7v4SFlHUIYrQLaQvwDfO4qjR7fuxDxtCIncjUkHJ738vRvj3XOkuX?=
 =?us-ascii?Q?hphzwf2Bibf2iYT/9CNNpOVQRTZ4ZAKnRcR/HmRcDgZhphqnxLHdQ9v22TCj?=
 =?us-ascii?Q?ZgEH4HiQ9z1DIuuzlV2lbjZydj9B0HuLUNlSa1gDg3rO4hNIDXjjV4w96LFB?=
 =?us-ascii?Q?9lDS1YcT9WTsOSvitXQe7yyT2GGzoEZpgVQwZN6xrTHtjAkKKYDVpwjKV2jN?=
 =?us-ascii?Q?o6tVA3lgKxWiDkMQ8YnewK1FI4BvQimAeRfFXy6ocZ+eRUjh4ZzOVYOVDRsD?=
 =?us-ascii?Q?jDqdJ8r4T1W8Kr7+js1YFnjFIZj7gD8hnIkg+VSNUIXYQt5iucVO0AUeTxf9?=
 =?us-ascii?Q?wyDr8VQx4AdyUOy90Gls97PIWIWacToj13b5Etnk3Hb22aYg+OypH5zROb9B?=
 =?us-ascii?Q?2xKjkTx1gG5Eso7p987g/4u7s7nete27+1wOoEroZ4QNeW2bMcHrGjdndaRQ?=
 =?us-ascii?Q?gPtmmMj6vtOFZLwfMwqynP63PtTPTqPJM/2k7EU913ry0n3jhYLkd7S1RE7h?=
 =?us-ascii?Q?t+v8QPa+7bHMronUs0vJrL6zX8g6IZpy7dt+UJLZJ41zbKD91KBsl4PVSyDh?=
 =?us-ascii?Q?pqTfch5vQGzOpEF2miIp8T0UM/hXWXTO53bAW4Sw2MQJklUl6reYhfF49MVO?=
 =?us-ascii?Q?IQj8CVGcv8XO0KOP1EVl6FwPJxrdClr6WGoQz5LNfuyRVRrt2PZiK1hl/QYz?=
 =?us-ascii?Q?nXVhHUyM0OsfTS3SLCUNTv7ySD2J+J66eApA+NClX9UE6oHjiky1Qw0W1lMZ?=
 =?us-ascii?Q?D7QOjIkwF1iYZEAO1bR74cPLQ0Clo3JKBA0Hvzpb97OMLD+xY699Wk0f7/Ih?=
 =?us-ascii?Q?diO1IC2mLzNupi7FshXkeKSmd4gHY/sIoTg4oybONhiES2RXTK7vzRTrhTYt?=
 =?us-ascii?Q?OeciiqZNXWAcGIXSGbQ9hGGfh81qXA9PrkORsY8yNUY8dFFTdUOMJEjaTTpt?=
 =?us-ascii?Q?zafseUnmPlJbLV3b06TNy865E3n5EGyvihCMXBqHhQOL/nQsJSA4zRNVG2ub?=
 =?us-ascii?Q?Ueey9OYeaVsK9JXEJmCrnzZhKiHr8CPtjW3UjEv+QyRF/GTV9aY87tVYXf4V?=
 =?us-ascii?Q?JVYECkexRvZCG/o1K/Alzmx6eLwDlcbaaPuMU0jWsW8mIvVe6ASg8n3ZS44N?=
 =?us-ascii?Q?oGzrE68k/9B6QjojlQKjUG72WEBteswB2k8bHH31K17TazsvxMq4Zg2p3+20?=
 =?us-ascii?Q?PH8pmknnQ7B5TtBBI5TxDMqY/YCnLGTMFzDf2HSOWE2SB5JlCQbmYKEddEe3?=
 =?us-ascii?Q?teqI2pQm6o/WU4QqvvYdsYJIVAB0hnIwD1cjKEOELNCsTBxQxBL3cchhmCTk?=
 =?us-ascii?Q?vjjtxlbK3r/X82+3NLKkFaQIKwI0E9IoikFeIx29KYxlC+db9kX1L5McpjeL?=
 =?us-ascii?Q?xTxZNYaYvg2IDEcxflQ379SiUhi169wgHH9Uu0raYmSgFGpUGNXq/QjEE7tR?=
 =?us-ascii?Q?KmXt40zEiHp53iNqHn4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5df9b9-145e-413f-0c70-08db1def9b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 03:05:14.4814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwBRBScomqEDfRzfcfqmcUz4Z1J6ctM6L82CvpvIBlm/LBtMX/mp/AGrXS59lWve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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
Cc: "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Friday, February 24, 2023 4:33 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Candice
> <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Huang, Shimmer <Shimmer.Huang@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>
> Subject: [PATCH 0/3] enable new capped/uncapped power profiles
>=20
> The patchset will enable the capped and uncapped mode
>=20
> This new capped power mode has limit DRAM Thresholds and conditions in
> DF-PState Algorithm based on the workload type set from driver.
> The uncapped mode will reset to normal performance level which has no
> such power limitations.
>=20
> Perf Centric Workload (Uncapped)	0
> Power Centric Workload (Capped) 	1
>=20
> Perry Yuan (3):
>   drm/amdgpu/pm: add capped/uncapped power profile modes
>   drm/amdgpu: map new capped and uncapped mode power profiles for
>     Vangogh
>   drm/amdgpu: skip the invalid workload type
>=20
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h              | 2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c                          | 2 ++
>  .../drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h  | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c            | 6 ++++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                      | 4 ++--
>  7 files changed, 19 insertions(+), 7 deletions(-)
>=20
> --
> 2.34.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9BEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7827810E5A7;
	Fri,  7 Jul 2023 15:06:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517CB10E5A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsBOmMi2wS8VGECuWRLczMnEZsXak0+Nsd08Ie9C91HB4agCDbxbHjSV7PI1osDV1qN9TexQ1mJ9p2Y47FbVFzC41JR4N7+VPBUNBc6H8gu48WtwS072BGKje9T1gkuJ8f1tISVEb16V+QFDiPzSFa53MjKIGcd6FfderMXnsjs7EHXLNAhwuLY4BW4zkrpIZ7I8WMVE4n9xHW4dIDS0YQVqs3kkEc473P12NS98aW3lkGlS4VAg3fi2cLCP3PbDmxmv1681gs+R4CvmDZ5q4dekpoSYFjAvqwNRelPaH3gnCb97NEQ2wEj6inr5oI3gvXa70pg7zoSdxMvI6nDNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AADDCGcxfoE2a3yVPYwSev17ESbTSSWYXq+5UhIEGPU=;
 b=N0clvg9inGBHzE7Oyag+bJz6NNQ1wCVqcCp7dyEtLxSE9HAFQOE5XaHjffMjO4tt5Y6cD/pTLc+4b9caUSsitnUDxzunUQenLyQJZLBH2Jurb+OIWoSmMFTx1+kytYHJljeFDQdPHVES9TM71rljA5CAxX5qeH4K5VU3RhT8BA4GZPq1b/v34LujonW+SsU2JN+Nmu2adGRQ+q1x+wR50vdcsY95Dy46GqL54NCxqKQbeZP5LJh4e+rejru9/hCCpXOQQW6VKdNU1mF1JxxcekinLUJYsZ9wO3T10pXDoabH/RGVh4SCFA7SFyS+37jVuTYYhJYJdnDaL/yn7+9VRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AADDCGcxfoE2a3yVPYwSev17ESbTSSWYXq+5UhIEGPU=;
 b=HfKg5Y8PQyYheAusuiElJ70L6IO4P8fE6QBcpogfYYrFPcpEe1EY/PNiiRfCml2LnYLMazudy3RnYJVkNqcDrSKUbCknc9DYlwXKW5y/uYAVG8PcFgwZCiDYuei2I6Se3YaOXaCnJLKw/vwZ5KvNVMFyNzwJHJpKnpClrzn7bXo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 15:06:13 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 15:06:13 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Topic: [PATCH 6/6] drm/amdkfd: add multi-process debugging support for
 GC v9.4.3
Thread-Index: AQHZsDZyyDAQrD8YAEexc+9yXZtX0K+uaIlw
Date: Fri, 7 Jul 2023 15:06:13 +0000
Message-ID: <CY8PR12MB74355F248B3E87F24953BC0C852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-7-jinhuieric.huang@amd.com>
In-Reply-To: <20230706181918.189722-7-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1cb28c2d-8f68-4c0f-9acd-b037fadb7ca2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T15:06:04Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN6PR12MB8513:EE_
x-ms-office365-filtering-correlation-id: 63bbd568-1a3b-4978-ba4a-08db7efbb48a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaORRhmOxcBFANBjK/wMC5oKrXlplgAFcSATN5vlzwxpJrcZvVC6sAT9hOQbnp+TMQbkb/sRfJOROh9j9UhlKB7MY0fBz8vdG1lHK9GZszux4nBEYz6cWyKUekNfdDt03R6IPtngq2w7jxKv6E8ButMei7L2cQvwL4hU58jRzCYTHDPiT3Ktnqc9F+sb/+gNE35jg6JtaCUC9j1yN8RQh8vwB1rAF3Y/N+sl3HmR2A6qY8TcAzlkcPS3/yyqblwWAo8yKVOaNhf9zy1V5rm0tIE5S9XJ4D46emIXASPZlLiKlUsN1B8QpPl2z3+ybvnl/bPAXAh6vSkHTlEGdukj/NpTnodPbn8O7SA7W4m506CyxBkjXVjqry1rU1VN92vjN9ix0ZlIJRhTz5N8vPYPuyH3uuNT1ySEFeMT7BMVMhXeRPiGgU+TTzmWg3oSQFSndCDjuVz5/tHK/L64GCtBTvwKp4XksDkjRivh73MJkDv994yqdo4KnObVBDdtTWFWZHaFGXG549y7w0UdhGY40rswxYBjE3WykC0SKPPmUbxiG8ls1NTRXWF7GZF7GH5p/AGZzxRxXxFkQ7ARfjpPUd2iOnlIByBKIcqZxpME+SpHWMsazTGmVLn4gBFxIbU0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(5660300002)(64756008)(52536014)(33656002)(66476007)(66446008)(66556008)(4326008)(38100700002)(76116006)(66946007)(316002)(8936002)(41300700001)(8676002)(86362001)(55016003)(2906002)(38070700005)(7696005)(71200400001)(83380400001)(53546011)(186003)(6506007)(26005)(9686003)(122000001)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2MckePQS6NagCK0kqouOop+Q0WUVUilMuRwir9AaCC/UbYFw8RFvv8+8g/1D?=
 =?us-ascii?Q?MWj6sQY1ZC8Fntg3CeGVKbTEd+PPPsrkzxjU/Rfp0MM4Fbg6xHu/AxLP864a?=
 =?us-ascii?Q?MBvUGuBb+tM9Ut7rK54QujibIwB0x+UW/GEJsLflfgaZE43Gn3JN8l5RxNYA?=
 =?us-ascii?Q?74VgBtnY7/64aHXdcMwtsv4716zkZL5SQUkBZ6kyNYb7hksWQOxAG8TIa9Uq?=
 =?us-ascii?Q?nKUJLywC+YFUqs1ibr1dhKA9HVTSoX0hcuV6mCbsqkkAM9eNqiT8EHMDwjdB?=
 =?us-ascii?Q?4wssUr6RF+NqbIbtVICcM1O2pdrglTHPGNEkqNr22XaQIwoidU2esBmuTpAT?=
 =?us-ascii?Q?jkn6iUeOjRI2+RODRkaZtc7SITIlwCtLWGTE53hPtu58sIO8zSsljCbyX8qC?=
 =?us-ascii?Q?0v+bltQVXECoMqPFFV/Y5pj2sfGvdRdvHC+O3jdqY/Dd3+v7I2AFRbLlrzfz?=
 =?us-ascii?Q?dq+bTy3eZ/3cFt731Am6+VK0JyJTppNzfT5nREBVdEfN7zJsHloVf8PNIgiB?=
 =?us-ascii?Q?80tzd9Ru0ZTgvyEdarW0rVvhYY0KW/8o3+2QTu8CKUcSL9nx+QKVSxk8WQdl?=
 =?us-ascii?Q?+QW5HBXbkJgRgPBOUa6rwXeMFxby2fDDOb294Tw7LNRoFsxP9K/bk2XVrY8U?=
 =?us-ascii?Q?nCL18RWSlEJT7q2TtwpzitrOoakQwAvwTEv5bcVdtmZtdhoc1fBO6FJRREQC?=
 =?us-ascii?Q?mZbCCdYPG002BeGGU1Lp5yrY6ALq2/51GRJJiru+/g2FAvLDvyvyMeeizmCz?=
 =?us-ascii?Q?0EY5OZnxINkiGIiJzeO+mI350Rs6UuID5UKi1mv7LTfIjSbChiC6EYo0yeNh?=
 =?us-ascii?Q?N5bPHBVb1bs+TZQ5V+UL0T0n4+iQQDJO3L86yH9JtczyQf/3tyQ6mROzhV4a?=
 =?us-ascii?Q?nuJQnLfkBbKYogyMWmURHUAgscRzpw1CL8Ag8t308ufVcQQoJ6MJT56hZq/l?=
 =?us-ascii?Q?Re7Al1Kjo6xzm0YuRLXJwM+IaLC/Q5OhzPBwIK2APeXU2BO3leHDTW3t01RP?=
 =?us-ascii?Q?E5Pan6T4mxzDvsUm4vfj0Xid02+TyYw5f0YfU57fflXirKfW1sCC84sLU/Wd?=
 =?us-ascii?Q?sudUXiKT2nGw/ilc6haS3oqJNBc8wJv8ROycJeX2f6yD7I7yA9vYm+JYNDle?=
 =?us-ascii?Q?WZXr33+EIDcDUMjIVIA+D64gNdiMKQVKlXvpQWvShSdOVZj11y6x16SlL0Mc?=
 =?us-ascii?Q?liMagKsvUEEXjY7a7CaKMcqB4r91pBkr+FoQw8ccYFL9i1uyL4W6jooogSwl?=
 =?us-ascii?Q?BBnTEKyQt67aFQ/XVB6rURZlZW3gcQiQXLIKyUXB49pJ6P4y7dkRbSj9IZFo?=
 =?us-ascii?Q?Johxx2dCgDLV7s1yJZro2xfPbbvPBxy0xqGrmCMYKoPscFGHs6GjEYo5H63Z?=
 =?us-ascii?Q?qr5lZb1Apq7eeEswU2s3jo8udOYXlsb/VNQt2uow1taeBDvy1TDCmNpP3Jii?=
 =?us-ascii?Q?Kwj4BEie/q9Q2nhaJGxhTcXzHQyCLFKKhCFTaw+YML32ypt2xlUEN4h8+6N2?=
 =?us-ascii?Q?EGkUEubkHvur+rI5ZdjMge8GflfDchdjjNGKQq2/y4pNO3pltt3nMoXtzxyA?=
 =?us-ascii?Q?TjNNT/1xvXMyB1N6asw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bbd568-1a3b-4978-ba4a-08db7efbb48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 15:06:13.3879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Am8ukcC00+7fq1/xsH3nbQWjky1mNPMg4uWCqHUf5+NaAwYxQDFE8L9i3SNlAtq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, July 6, 2023 2:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 6/6] drm/amdkfd: add multi-process debugging support for
> GC v9.4.3
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
> MAP_PROCESS packet to support multi-process debugging.  Update the
> mutli-process debug support list so that the KFD updates the runlist
> on debug mode setting and that it allocates enough GTT memory during
> KFD device initialization.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

This patch is Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index a289e59ceb79..a0afc6a7b6c4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct
> kfd_process *p,
>
>  static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
>  {
> -     return KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> -            KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0);
> +     return (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2) ||
> +             KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +             KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0));
>  }
>
>  void debug_event_write_work_handler(struct work_struct *work);
> --
> 2.34.1


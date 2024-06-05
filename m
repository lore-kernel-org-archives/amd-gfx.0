Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931AAC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 07:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07ABB10E0C0;
	Wed,  5 Jun 2024 07:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBusVPSI";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD6D10E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 07:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfYjNN9zlsqVucvZz9uKNROYYbHFP1hMB3byGa/guTJ5RKJ0cq6oEdsiK2fBr/qYFw0Nc9djXTlh4ZcBC05seJwxQw8c679uQc+cXtMytulF8/7iBs9KjmQiLB6C5goYvbKOqIIWApknbE1/Rwhw0dQlxza7H5yLGcvxsaAKBNwX3o2o75PCrT9l9bvWtQwoP2dS9NInRGs1jb2OM1nHmF5/5mfJ34tO9k3PZTZtda+eJNC8Fdc9io54aWFKe01WkaloU4iNKXuraav9ZpcTHzfVz6yn+aiFvkiFw9exVYLkQS9WKTkVwzbBamnsEOk5xGkdIBTVf1Gx11P0gJBOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcXgFitmyN/jG8OLQG9X855TDUH320AU94lB4u86eMA=;
 b=aZXOh5sL/27pZBpGIvRyL3B9+a+UJhpkNkSkimBZ0IS2WTDMX+loC6xFKmv2puxVFoyrlmDSMl9e0BuWEtzf2U4V3UxQO8hC5DtjYKEpwhzyoK7JLH2sc75JyDArYG2Lc5bWzRFHRGy3GHyqvfFMGzpVnTpQkuPEv9BdKCEB8ur/10mygfH55f3oC6nFzSq/AorrpamLTajqkUQjC/QVUwFxUCgBbeK4ibPZy9nSgvI5J+F95dFl3hdQKn0sSp2UNxU0DYtOGLRg+XluIu+Tn/g+3zHuk0c1xO7d24r0mpECFtTDX6JIx24x9dMO29z5OnYJd9zOa1+AAjkjB17TaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcXgFitmyN/jG8OLQG9X855TDUH320AU94lB4u86eMA=;
 b=RBusVPSIHau9gjafDKxddslDbscIRW1LGXEc62++wmRBstiNDL04KWFdcsQlJQV1DlFiE77ejUteBl28s2zWTklRzNGu/dfQtGrZz9LZCQNBrtbL0sck+TMFAA2h31DMHYqeEQ5QEzJMHcxVGbUve3v890VCCjiNF/l6jzv7I08=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 5 Jun
 2024 07:48:20 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:48:20 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK0jJnxJzHazkOQqOSlkz07RbG4ziCw
Date: Wed, 5 Jun 2024 07:48:19 +0000
Message-ID: <CH3PR12MB80741FD05175020F8FF0E62AF6F92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
In-Reply-To: <20240603084730.2569970-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ef96e872-bef4-483b-9e81-1b09306a47be;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-05T07:47:47Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CY5PR12MB6381:EE_
x-ms-office365-filtering-correlation-id: 11581117-fc40-404c-9e5b-08dc8533de54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/n5qdd1qw4tsBLa0gEwTKoeL+oNFISKDxXScODkZ26x+7RhzXooOWI14A7?=
 =?iso-8859-1?Q?TLwjRm/+0lEZEv5ANRhYqOGgfSY18wHcBpotO4OxnT8fGLTXrg4s5r7sk0?=
 =?iso-8859-1?Q?J3MQU8ULJ6KWubXsmKW3n4QYK2AVyQ3K3uc9sUtyDV9ehM+1zvBjQD+l/9?=
 =?iso-8859-1?Q?QAt62UO6gUCxYibWbC/QxNhr79XFjxeblZR0Pfxy4Q7iBz+qSMrNa5oWdh?=
 =?iso-8859-1?Q?gPcv4JXCxoXwb/UzokWKHPbIS+rwYPz1GaUBV2bWXPLMkQnLqIDfNjJjNP?=
 =?iso-8859-1?Q?+SoIsPhgT8DXg2OQ65DXzz4dQoKV0mufzZ0d0m2dsLAtgnAuwO8SxnYdGH?=
 =?iso-8859-1?Q?vc1WUqUZJ7CROtabxWV4C1ti7FZLKPB4WTtK1K4PcIl/jpk0cXhjJ4CtBL?=
 =?iso-8859-1?Q?sB6dMPOHBDgYzUitFgVbewfdKU8b1hmVFnwbh/0W7j36EHxwzOIRTdShmU?=
 =?iso-8859-1?Q?Y5+BUnsqkJ25ol25tzsF6cBL+y91lv4GOPCFWLYkMUWDhcvS3pwdAIaFHS?=
 =?iso-8859-1?Q?syfKDAvJ3I2ODB9jUlrb32paw0a0TGrauX08KNqvq0e7Nmu7RgzBmkw/gR?=
 =?iso-8859-1?Q?TfNSAqYrtzv7eA6Cl8SsHGzUTOeLBm/0nEiCuhGEbwYk/NY4r5+2YRHCxa?=
 =?iso-8859-1?Q?QP9LRIruxyf/sdy4UTSp+aIm2elNikMajElLZGG+5gKDDZIkeC5Y8z/d7k?=
 =?iso-8859-1?Q?cJOo/AmugtOhpEH+S3z758nWzkXQejkRcMo01mjqKUhRsJ330mr+XX2PvO?=
 =?iso-8859-1?Q?iXP7mM/2ehe+E81sWvyU0EVcn7G9KmjXeLmGe8Dd7Oox8O6U3Dv+/hbWCL?=
 =?iso-8859-1?Q?OEhKW8NFVSm/FdZRRlYDF7adKXIVYdN4Q8/+US50mmGbtfdXKWV/rSbgSP?=
 =?iso-8859-1?Q?LpVUG/xwOOlWDj+HQ2PxSg/G4xyyMJKQyHjv70XnX8qVnpGo1CdKnzQzRy?=
 =?iso-8859-1?Q?kr50/T3oah5p20Y92uNkSM+McHPFvKE1RI7q+oIdfISCB3xbNTNoGcIYxD?=
 =?iso-8859-1?Q?G6sfOftb1NH+8YcV0E02Lqz6nutzathGwgkL7t//H7k3clHLStQ8xLXMXi?=
 =?iso-8859-1?Q?7uRfBCsTp05TTE+h/Y2g7Ya0yYMPr09wJH6p2ga+LNT8ugPFYvvukDZK8b?=
 =?iso-8859-1?Q?hjOgrd5dA7MDUCriRNjL3y2nlMR/1BsAAKu1MwwxJdvRL3kT4clFr8qb3j?=
 =?iso-8859-1?Q?f18iOMg2VvTVDq2/7iqbjAK9nWgfW+nuLIsEaSgyX4Ddf2Lfi5329mtNxh?=
 =?iso-8859-1?Q?Md49KFG08rJxCbdeVLTMhqUToCFrPvSzZhgD4xbb4daLHNF2cmJJM+ZtzR?=
 =?iso-8859-1?Q?lltg3NgOj1XSFg8cG/f7vrKRAEIgGq1VTE+Co7Nb+LjCWKyIxhPI+L3uk/?=
 =?iso-8859-1?Q?MXNZlkSctSyIoxBBnTm9AX/sj6qIntQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yVV0xV/qV3Bxp1YY903XaGK8nWX/YAcJp0tGrArCx/VHXuh4u/o8+hNMwq?=
 =?iso-8859-1?Q?xfBQW1wQa57XZCcqjRDhC8KEifH2eWhtw0pcceG8aG68AiusgQ4LU3no8l?=
 =?iso-8859-1?Q?F1KxPAT0lN/fnqgZ0iNA3kuJO5VWahpPArGiXzTOWtX96FyYI8JWls3Yok?=
 =?iso-8859-1?Q?ganWfOkxCKwwXOjTbI/tlyIacrCEZhR/o1nKTEA5biWqrxqoJeRoSPCPbH?=
 =?iso-8859-1?Q?STCrRYmARtizrLvoELfMOKRG8X9YagyOS8mkaWkMyj6pZ8mSBpXaCj6BY8?=
 =?iso-8859-1?Q?SGMOoTIP1qSGwgxTEnQ5GbkRtELDwIpqOeF4ndTRJEhhsL04/1P8tDate8?=
 =?iso-8859-1?Q?g8IyRPg0SFCmTMwdO+CfmqCRkd09dEkIokZmcwzxy+4DvhnQVUifaqXJQY?=
 =?iso-8859-1?Q?NuPoigLfWnLabMVsIHDMKRDMd8Xno7DSb7VFCuezp1vHqeZHAOUZc2I04Y?=
 =?iso-8859-1?Q?2KawWilGuSslo+fOpO6VPeMvD3/mI40OfJhY3S1tvvDXOswr2quqSADYnt?=
 =?iso-8859-1?Q?LBNGKTVclYs3X6SP82wF2j14CaYA6dLMT9a72x6KnFv2HpA/od7PajlGkc?=
 =?iso-8859-1?Q?POyfZMR4hx2e4ozAIxES8twMqsFonVhdmJ47sAvi0/6B9CxbL22Yat/B5M?=
 =?iso-8859-1?Q?X0fYlodB5M/CY463CWMNRDRDm74cWD3iHqurz7tLpKOiP83OpQjyculPrU?=
 =?iso-8859-1?Q?2b60/orQGADNLB/azMph143IUnLiLpoelx41nNJsqOTgw7H5UjHfj01l6a?=
 =?iso-8859-1?Q?wIXuIS0MDrX8NSTsBLdjlCguEFoYbKu4ATBxzuZoOxapqWt2SnmZYHwWx8?=
 =?iso-8859-1?Q?L/K7QYgYcIWz24b/hETs4BA/jNC6j6yrCQBnqNGn47wrCi8+uillfvAEXb?=
 =?iso-8859-1?Q?IM/v9K8+/6kwwjFBCvcW7bsb6+eVcbnt4intcvujkE66gblIzPFLtTyh1Z?=
 =?iso-8859-1?Q?wBsTSVsMNMqLDUq9/ze8aqJwJ/+fe/fuDxkBM6SpxXpZRNDimVN8Rc15PA?=
 =?iso-8859-1?Q?GP+fMjuhGrBow/iq4jpnJYBJIlS6kLYupGDYvJelFAop/ae1w8x1KK6flw?=
 =?iso-8859-1?Q?d1H5oDGb8+TZYK0CU8YwrBDpMwJNQgjjgsMsFikyx9Zcs6PH63vvkEMy9h?=
 =?iso-8859-1?Q?EZ7IECCLCwdqVbjtarg0c6aJ5NO8zgBeWV1TZak/S5ic+9+tPpgsV2Xh3f?=
 =?iso-8859-1?Q?BPu7RescvPXRqZNV2qkeaqV+kwZB5o63w+w01UDlEAwacMjt6fpTWxvSvY?=
 =?iso-8859-1?Q?JrQ/Z4dDkzedB96kuDlLxX0GOb01kMOMQhkslk6YEC6RQ7uz9p5jhiDRC0?=
 =?iso-8859-1?Q?WH5vFRlhr5Mh9cC/1ZadVtcT1MKkmZu7+IbI5XbdZA3WhJB86JYBwbFfvT?=
 =?iso-8859-1?Q?BogElv1nKaAca29Z6H7G2LdfEUczN4lhvj5IP1aLSQCnf16SG4MgqN2CCy?=
 =?iso-8859-1?Q?nnYojPd8MgeED3FRa6fUDh8UzWWDzZwgimQcPkpqnrqGo0c7XKdF4Zg3q9?=
 =?iso-8859-1?Q?8gLode+yjQJNO45Gk8zA7aL370JttobXPobiAgPc5CkUxrqy3PW1QKz94X?=
 =?iso-8859-1?Q?hmMsYVHphQC/I0ZqWzlCgx//Qo9Unke6oMcXLCc9eEe8rwC054X0MziyOf?=
 =?iso-8859-1?Q?irQ24TTaj7ODg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11581117-fc40-404c-9e5b-08dc8533de54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:48:19.9285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP1tD260XbAsm6AqEUUsXaJwDPtGu6I7qNa8yE7ZBRrwkZ/P0mA9HW9NY1+vSv2J1VfB4OWdJHFKjOhEua1c3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, June 3, 2024 4:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 05/12] drm/amd/pm: remove dead code in
> navi10_emit_clk_levels and navi10_print_clk_levels
>
> Since the range of the varibable i is 0 - 3.
> So execution cannot reach this statement: default.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index cf556f1b5ed1..076620fa3ef5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct
> smu_context *smu,
>                       case 2:
>                               curve_settings =3D &od_table->GfxclkFreq3;
>                               break;
> -                     default:
> -                             break;
>                       }
>                       *offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMHz %umV\n",
>                                                 i, curve_settings[0],
> @@ -1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct
> smu_context *smu,
>                       case 2:
>                               curve_settings =3D &od_table->GfxclkFreq3;
>                               break;
> -                     default:
> -                             break;
>                       }
>                       size +=3D sysfs_emit_at(buf, size,
> "%d: %uMHz %umV\n",
>                                             i, curve_settings[0],
> --
> 2.25.1


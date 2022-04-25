Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34519C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 19:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44BD10E822;
	Mon, 25 Apr 2022 19:56:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F0D10E822
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 19:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYMZFs0cfX4Xb3NuhHJYMEcBAoFxJOvB6ikjrrkBLs8forPwErqi9trWjgPmXUKI+AV5bu/KmIsHXHDeA7nH/EfJq/gqRxjngay02B4ASeOrJx01ejKG8tk3+ZIPx6VRt2hyVU8dnEcoOUKdzjN+DIEqAx2mygvBKtIa0OPnwM0TmjYfTqskNiTGmLJotGKa+YZTHNW3NhL0vP/PZxHlGh7DFc61bX5/8iI0pamOkNYS2GJj7622FhoZIWJ04/G97tvv7kAdVu19GNBQ/AxD1X4bnUlBbR3VgcYO1FDzO6wdv1x9uaAf5n04c2Pub71b9DImm3ldf97WZSm5PmaUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUMksgNH4n6kPPDmuUiuS7Iuq0awr5KyvqSLNmInpsM=;
 b=i5j1zYexMer3iO1tAD8MzzOJZy85iLFmVxLVv5y9hH2e9mDG6tO0D1fc02jXy1KI4U7s84pDN2XfL3uMonLFmbTDwoyItVXT4W+emSQLDNVwE0wbEFy2e9B2wsTh1szj3UbofgJLggxSK8yvb5S0u2WyGcmzNXqVaYDZZVnVmdnahUu+XmNdKfomw2l/2sWQo0P5986K+B9NqagPNWfybZ3KJQkfmJ5upw6usLmwUq3IeWrAmgrriVabpPfAY+aOiKIOutxYNW9v3+U5AOi8sd7n1zUE1XL2g43an6u8fVpIMVQUcfY8Wr9XpcBhxvSzilntg1NqVwlXwXfPMnr2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUMksgNH4n6kPPDmuUiuS7Iuq0awr5KyvqSLNmInpsM=;
 b=ETXlmmdK4hjTtiH1zjH52WOpqsZBxofvRvQSisyViPyBJtARtVL96AWc2GLEtsgQ1qTnulpTWuuKrH4tD9hJhur1xBb/HKMD1R2vaXj9av/xtHaRRY6VJGSGuelTFH/BUgRdPqO3gmQ6L+XBhET+w00e01kUPaiLNiKf7PTzSII=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:56:30 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::a0a9:8a21:d229:25b4]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::a0a9:8a21:d229:25b4%12]) with mapi id 15.20.5186.021; Mon, 25 Apr
 2022 19:56:30 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Thread-Topic: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Thread-Index: AQHYWNolZvHpWYl6e0679vbUpQrZvq0BCcIw
Date: Mon, 25 Apr 2022 19:56:30 +0000
Message-ID: <BN6PR1201MB0084985C7D3BD7050B4B38A789F89@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20220425192436.778206-1-dingchen.zhang@amd.com>
In-Reply-To: <20220425192436.778206-1-dingchen.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6ffd4f3a-6a4d-4292-899d-ed09d0831672;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-25T19:50:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f7d4cb8-3f3e-45c5-6258-08da26f5b10b
x-ms-traffictypediagnostic: DM6PR12MB4140:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4140C225C102BE44294771F989F89@DM6PR12MB4140.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgMQhfJfXcVp6Eonzo/XRO/h9Tdym0qNiw8CXInaXLVn1jdiMlDGJRJJ31E05sS376CXPsAZWkjsL2b3gro3QXijiPN7aMF1sW1ELkj73UjhajBX4kitybFY/dyvY/WH2wKZ6W8D1rqGVV3T4m9IMHkOSFQ86DXMi5jLky0bWyrwno6LqZOShuAoW3DI44mwzlvefYmTM3ranM2RT8PAtQGqkxQQQGJpspccGlzfOymR8HnHOrWZMhREA4sRZNmB8wS8KPgYI8OrJmJad4oV2w5i+g6kbVJZ0/ySmyLdA5hGfj1c6IMB0NWnOepyvox94SkJB7F7FZyk051bZQaM4J5C642jpzGwWcWJF8qgYzPIEc+CGd4Y97Dqla4zr2ic7LV8vd1ZCmGepW/VcFEHBDlwWK+6C6dioF1BxNiSjhTSKV7hTyw2msy0Q1gazSF3KAZDLPBYTBck8DAl4vNHKwI/QnPPY9mSFsp+0hoqnQ92r/tv0EQ1KLVPnL9gExGlFkHPkOT1WwHSoUhD/5HIVmjbzzV06mmnqJ3WZeKLr+TLzBJze+c83FQsQpKDjCs0jldm34GjqaTp+CHAN2pJ3pEE9K9vv+OV9UGuzjEnCBJw8CX262VpjH2xXGlJpsx0YHonJYuLxQimlEQAJ/vkYRzrvnMA2lq/NgsSWGe1D4uY9JO8B19R1dv3JrwYJXy4P/srDyTf7W4ryBxmClZzyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(9686003)(55016003)(186003)(66946007)(53546011)(6506007)(7696005)(8936002)(52536014)(508600001)(33656002)(5660300002)(2906002)(66556008)(76116006)(316002)(83380400001)(8676002)(71200400001)(4326008)(26005)(66476007)(64756008)(66446008)(86362001)(54906003)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZBMEO7ua+CXKMBKnpMFBVT/eSOJSCfuSOIq49ScNsL4YJurah/0I9Dq9oJwT?=
 =?us-ascii?Q?sQ5nRH1KvqeOxH+nA1ZP0uNwn9ZIsaCw1NoR1Y853NxUOHws3Z3n2BH1iB1k?=
 =?us-ascii?Q?ElFNY7rdZlys/RVQGJ4u490yr8VZzMARpORak/YGRCPwf8gVYTghYjwtFc3d?=
 =?us-ascii?Q?pPDO/Oxm8hrH4kvYk9GSODRNAh6kntYYELq2vPGx8jy8dB8e33GMZuey7Wsl?=
 =?us-ascii?Q?0sA8DODK9lvHtvz8Ubrcch0LAI771yQ0O7xo/Tyj2x4rbou061odxMXiQl+Z?=
 =?us-ascii?Q?xYwkKd1hnZrnq8eusU0zi60SXnVyO73yGlt3eihYecYsKxcoVAsgtqObppNw?=
 =?us-ascii?Q?hYO3AxUP7dbasyQqjOG2JiZ78vE3ytPCiYDwLmmxnbx3shbaP2YuuLLa4V1E?=
 =?us-ascii?Q?B1w+DodFe3UStmrudmpJrOvvcM61SHjfIvisO1NVHUCdSN5iHaQC6o94BFTU?=
 =?us-ascii?Q?kYG/kY9Cc1RU121rMCm5peYTUtIajwn/l9EKWyKNTZ9NP1Asx0rnRSrMuCSG?=
 =?us-ascii?Q?TuxFtMugTqXt1NuI5X84QAhLJpkUIG4lIJ+cBgRXw6O73/I68djnMWebIi8t?=
 =?us-ascii?Q?8Vr/OrRzc85Xz9iYvUh/NipBBwptwo6wIL2kp5H2fLZFCnrDpCT3s3ZS69Sx?=
 =?us-ascii?Q?ahweyyFenhrf2EHHdpmfZoCwr7lOjeVhmMFy9OhR6Cnj4C61ec0wUfoS77zL?=
 =?us-ascii?Q?KV0OM1nmZNZDSpMmMQTu45PFNAsYAW2J3Wf0Hv8bsBVlJ9DeNWmxL4Y63spn?=
 =?us-ascii?Q?E//UaJeH2Jaokf47pnzmoZ75MLYytz6yMC9FWi54ReptYusMmNx8SG7trgGi?=
 =?us-ascii?Q?/n4tiFUNuIzgP0pGLnKt5RytQ9PFlwhFSWAQn0ppYDciCqIbXyNPNdW+9i7r?=
 =?us-ascii?Q?Y5Nve230vQGu/LL2Psw15aVpKGom97GNH5rJKTIScQtcDVXXq5DZyj7ypImi?=
 =?us-ascii?Q?Pu9Ixtgzldab9kh1ryFLhDUJ0scAQG4Py/AZ1W6FHdJfFhrapl9opULkf5Xs?=
 =?us-ascii?Q?xpeSkazk4519fv45vJWaS32F3W2iZSgawswU9NJs5JMe9qk3QFsFVzx9H8Ir?=
 =?us-ascii?Q?4k/fb2B3C/APHI/1h2W2wXIbOqPShJ8eKIQ4dJPBbPuM3HZw/+HAHtRfX83u?=
 =?us-ascii?Q?vN+42zeWyjOen66y9OIMc0dH0Y8fReLM8t4Xfd5wEznFXF+yiFvu6yVHnX7t?=
 =?us-ascii?Q?Kz1BXkuuHO6IujaSdARxR4x7sveaaAWotEAAadaHMXHA/n80GC1f2w3YB0Bq?=
 =?us-ascii?Q?1sgLqsaJJPPS/+eVhZqdpbMWyevVfvPZ/vTUdAAsY4QFLiagtbS0loDho5Lh?=
 =?us-ascii?Q?kUc7YLXMamWyB/RhABZ0X+KlO/TpuMZ0hKYgwa7YEmdhoTSZYG4eXvvhhGtv?=
 =?us-ascii?Q?Zv3MYvlMhYwQmCCh316diOzPLqvPhujDEVrIHKSSOKla38STREg5bgPn/Fjc?=
 =?us-ascii?Q?zlYdDq8doZ2qvN7Y9u5FTOOHCoxQFixlT5NPk09OV8wPZb5tVYX5ZvP+TuCP?=
 =?us-ascii?Q?6vtNAmFwqRgY3YEsqwMi2h7pobPmyIpqYNcxrO+sGprHpS9wlo+Gdp+7VhgB?=
 =?us-ascii?Q?+ao9kF2S0TdyMTXoksWdqjk8KPHGoJBoPylnv1zwt84JhtCt3ecBPqVGSiiG?=
 =?us-ascii?Q?s2rYZcAn6DsM1UxQWIysksPXOBp5UnjYTb3rkU6Jx0YY4+frDyDI9LSyGtMr?=
 =?us-ascii?Q?m04iD4jbe14fjZaTuY7ky9kXi7885aRs4DMEP3u2R1c3DB+o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7d4cb8-3f3e-45c5-6258-08da26f5b10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 19:56:30.4877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAjCt17RW9tQ+edgiiJTSpiNpDFs4vHCV26GhSADgDXgIDpA/u99CBXbbjbWokMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

> -----Original Message-----
> From: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>
> Sent: Monday, April 25, 2022 3:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;
> Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman
> <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai
> (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> Kotarac, Pavle <Pavle.Kotarac@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
> Subject: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
> multi-display optimizations
>
> [Why]
> Allow for PSR SMU optimization and PSR multiple display optimization.
>
> [How]
> Add feature flags of PSR smu optimization and PSR multiple display
> optimiztaion, and set them during init sequence. By default, flags are di=
sabled.
>
> Signed-off-by: David Zhang <dingchen.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 741dae17562a..06f21e9008c6 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -234,6 +234,8 @@ enum DC_FEATURE_MASK {
>       DC_EDP_NO_POWER_SEQUENCING =3D (1 << 4), //0x10, disabled by
> default
>       DC_DISABLE_LTTPR_DP1_4A =3D (1 << 5), //0x20, disabled by default
>       DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by default
> +     DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
> +     DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by
> default
>  };
>
>  enum DC_DEBUG_MASK {
> --
> 2.25.1


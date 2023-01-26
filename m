Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3215C05027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 15:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5771110E072;
	Thu, 26 Jan 2023 15:00:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D14710E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 15:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSnXQSx9TOhLLw1DYKL0LQOxzoJtqSJ1HgF8+CDrHSgikEpTktW0WMBdhSaGVGHhsNjg9QQDT6fqebgzWsaKpb630YmZwQA00LU9hEfPUnJD4fxdWK8r9CEYqM12Ux9NCtmabxlNbYoJf34+b4Nioc3kRTMqZsvyt9fX/KV14feBTC2sU+w7rlprV8nq2RPnNI57B0KsH8HdMl7xrF7YTSz6Io3UUnl5jjqjXh28dlrF6URtTQJ8mEhcxqpPARGXUexkMtaHQIyje925SG0PgNb3bCqr7D7Szo14eQDJnkoX/iAmW16zSK34RmT3YXr9xJQnXy6TT6ZLVKb2AD9Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFQOtDL+or0KRCsS07ydc/aC+M1EygOR4PTECPnt72U=;
 b=hYM5suLfXqw5YoOcXAldW7D3zs+C1Qqg1S+e422VgC/n3AY8C6XhxLJKkbwoDIKrUd0qQ71B5aqyBpDiraHwfwxSP7wI0/TpJdQWFQH9DkaHxhSnCgPdnJ6zGiBCncTipwfBf/VsyYIh5MSlcwp337Y+H5QpI8Ncia3hwQNg76qpa9vmqS5Bt0ALCRQstuRDorbkG3qk69zh8FqiI0LT7vj8eJ12EEEScr474YgwHY6YuEvlMi2trA5ZVZvdBx1sE6wJlIACVcNBdqrfNvwh6yzJBgCOAHLbpbCDrXIbJgdOMyoXreyFnXtHsPPPeMZKZcMbC2u8LNpBog4tqHdCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFQOtDL+or0KRCsS07ydc/aC+M1EygOR4PTECPnt72U=;
 b=YMQ0a3WBwl4YMKjB8kKkJZrAPZN7LgN3tGoHM9ICUszbq5OOKz/lgvN29KFyE9R6UxnqGUbn/xx6mzIJekfW5fVg3xEEJXKwPrSr7Ab7d9QPbJPaulfRxF52vX8cINbC9eLYYwQXz/0Bo0/p0tnPLqAJAHJki+5oDJUIbMminO4=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 15:00:13 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::764b:ecf8:c13b:7d33]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::764b:ecf8:c13b:7d33%6]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 15:00:07 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 12/16] drm/amd/display: Add Function delaration in dc_link
Thread-Topic: [PATCH 12/16] drm/amd/display: Add Function delaration in dc_link
Thread-Index: AQHZMR4zY3F+7pxQnUKtwtKccr/aFq6wyzFA
Date: Thu, 26 Jan 2023 15:00:06 +0000
Message-ID: <CY8PR12MB8193AE89FEB01CCD2C54F76F89CF9@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
 <20230126003230.4178466-13-alex.hung@amd.com>
In-Reply-To: <20230126003230.4178466-13-alex.hung@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4ed2d6d4-504c-4842-96ad-ba3208115e4a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-26T14:58:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|MW4PR12MB7240:EE_
x-ms-office365-filtering-correlation-id: 05c141b6-f050-4bf5-245e-08daffae0328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hmx1P2nSVNiWl4z6wipW8kCSKov5KMVle6n8C89qymleYfOht0YuPqOoichrynfvKwXqrsTg8rLT+Q/XOYuTMTwA6nKWqvahsvFNtMdNIGEoRUa6NaanVr06inrSGOhNcG4dLH33toify08kenU1YjwIAgo/YhbrD0jWoXdrcx9c6lkjuKkb8L7RT914toI10Rdo3NSGmUadQrF4c0IJU6vJ+TAi5pIQkTwvc9B5eRFc9umIuKYi3ZTOfPpAlO9i6nR/6I14BTtc+Ixhv8G35Jz5KEpi/ON6SX2S0w5NYRtUaQvEAWxo6b4SpQCa5icrWMLoKZVeYdFqSxgYNw/r4/7LMMjEa7nkzv1/xB6Wy6Sc+0YnkSL92eOENc6pV+gbQCSqqPurMUdBtV6pC94cOk7qb2Uv/UFqy5bWWb8KXE9ge003EDOmmJD1hi0hiap39lAqHH4/WTS0ADddyfPmaIahkS++GPIfLe6LPpcIkKoXs1MwNum1JfbZxkNHOnJZeCsSt9ySE2C+B4NsHR2xA6Fyx+qqsEmacYKtUk8JM1Bf9YQoXDTHIQAJ6jPqNtW2UKnRqDb+Wqi8S5wwy8q17MlFkUpfmcFGO61jW2JFlneoHwl+TNz0h1QHoc48i/0IJ+nsHP8XX+1gC6QMzf7dASYq5ImLSJvBkWRRC4WRmsdf597HO67RFnEGslVrTrDT993f0Z10My2ToTv6oD6tDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(186003)(8676002)(71200400001)(33656002)(38100700002)(26005)(83380400001)(7696005)(38070700005)(122000001)(52536014)(86362001)(55016003)(54906003)(9686003)(5660300002)(110136005)(478600001)(53546011)(6506007)(41300700001)(66556008)(2906002)(64756008)(66476007)(4326008)(8936002)(66446008)(316002)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLcGnNZC5tmgBCzKiouaTexQoZ/u4wOhFMTVeRp33MO1/sJQ1jqtTTkyAGK3?=
 =?us-ascii?Q?jDPoHFuATOCo+MDcyROJ9nCbCPYe48iPc2ZBwdnawBl4V8LLAS1HLKy8jYi7?=
 =?us-ascii?Q?LkitJVEGNvW9oecc9ZgBxfaxXYdoZbIUbUAFSigSUXFtc0j6QcZJ+ZSEW8os?=
 =?us-ascii?Q?Kw8BYPsPlBpYteebvc0jREUddvR63Foud7utKZopdH11EZPMPfD1NIqLC6xW?=
 =?us-ascii?Q?+cDGA7mHtZIYPTzdroCPMO1HsFWeDGgsnxsDV/7KWL2dZd+joJQLZqdM2l3o?=
 =?us-ascii?Q?Vwu7WIsE/FgcMvTb533NTrS+YbC4rDz5n+WDZV2BsTMPbbUZZyrgazTJlo3d?=
 =?us-ascii?Q?kT4mT5PLP1acPwKaMYqAr/KCNme5BiWRYZyo1VwidUMDU6ZuegqLagD8mQjN?=
 =?us-ascii?Q?bTDW+F+4HVz2Dve5XxN6mLWVOyLicy+paiCScSqvSoaguj1jRiI2sdE191Uy?=
 =?us-ascii?Q?CFg6nm0wWPXM0Yrx0Bl2HKYnEMPbG7jHNtjsDga6Rc/MRFlx/9MgECULAFBG?=
 =?us-ascii?Q?7mPD8g6vHT014ocxRPu6xPuT8BxFkcILucYVk4RKOhB//BsthMDJyY7ZUqw5?=
 =?us-ascii?Q?TswVycVEzS//sFREO6Ux3PxjNc1yAZEPSZvghgXFI1pJvEj7WQ6L9dw9KHaR?=
 =?us-ascii?Q?zUinwYR3thUbbNKHyNJzImBPKUa53YpI/9vxdZgsRujYE0r7ODi6W9h33unB?=
 =?us-ascii?Q?HHxkR6ss0hGszUCASiPgGiwx24mBHuJoSXGonzHr+D9uJdL1GyE5LzamtTtr?=
 =?us-ascii?Q?LQHi/TWdyJWRr18wUCAqRrPKdpfCSnEsUQPOXIkwyI43qQAABzeuoC5F3Zh5?=
 =?us-ascii?Q?BCxSGzHaPD8qS84P0XQIhrRWMwA1ISKJ0YvkJe0Ym0020LQLQw9HSSDyXd8g?=
 =?us-ascii?Q?GSpKQOeN3QUoGEruXfm7yTIgIr4qftx7uye6eUmjAy8qzHkXNNm2HJReQE/c?=
 =?us-ascii?Q?XR8skIiu4XA5cnECHWv/FSjD9hA65yRpMG5fJJf0D3/Q/5Ue6qIhs8QvlhbJ?=
 =?us-ascii?Q?px3oZTToIYpNGM9gPP4RqNCs2I4xrgdhZWJqdLZ22qJWzkNU0WojJvbA9WNQ?=
 =?us-ascii?Q?OtTviceMzow6xjvrQSOWzKIPiEGd4tIYB2II5z/pG9/WH1aMHV7KqTMdfeau?=
 =?us-ascii?Q?Vo5TeDTGm517P0Axi5YyMgvf81I+FNa3teMAOQ3/T8qDMLx8iAqVnJREsxm/?=
 =?us-ascii?Q?rsrZnu9vjodkDptj7iYO8Zx3QMAoDPCdfwFLJMfxMwqvkEeqVig/PB69xYPZ?=
 =?us-ascii?Q?1oYvQYyAS3IWRGNM3ATh9Lk209+04Gy1eWfLL5rOaN11AbsG5KEGuQZAO8uL?=
 =?us-ascii?Q?zDd9lp4kkrATX9Mn8OiFDjRWuND3FKx2eYzSbPMHiHcil9D5cGoSah9IZWg+?=
 =?us-ascii?Q?tWibvFIp1ts2prnnsZE91SEdIWcADxKdI49It9svB/6H4+vG5uRTM2Z7c6vH?=
 =?us-ascii?Q?Jsgx2g7V7tzQcm+Pp9fcK+gY5aiCr68gLxnXUAR0okcEX2RnY8BQAd0r0L6W?=
 =?us-ascii?Q?AUx9ZJpiCtS5F5sNqejByZvAQbrWjFi8NPxsWerfwDuVvToDy/ZgEHjXcioJ?=
 =?us-ascii?Q?9Lz02YVMerwakmHJBaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c141b6-f050-4bf5-245e-08daffae0328
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 15:00:06.8388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bLn+nk6vf9Ue/2Ed5bhelULKdREnd8JS8uyu54/noDa6FH+PoW64O1g/QCsLUs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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
 \(Stylon\)" <Stylon.Wang@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Ghaddar, Mustapha" <Mustapha.Ghaddar@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please fix typo in commit title.

> -----Original Message-----
> From: Hung, Alex <Alex.Hung@amd.com>
> Sent: Wednesday, January 25, 2023 7:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne
> <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon)
> <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> Kotarac, Pavle <Pavle.Kotarac@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>; Ghaddar, Mustapha
> <Mustapha.Ghaddar@amd.com>; Lei, Jun <Jun.Lei@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>
> Subject: [PATCH 12/16] drm/amd/display: Add Function delaration in dc_lin=
k
>
> From: Mustapha Ghaddar <mghaddar@amd.com>
>
> [WHY]
> Housekeeping cleaning and adding declaration for function to be called fr=
om
> DM layer
>
> [HOW]
> Adding public functions to dc_link.h
>
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_link.h      | 27 +++++++++++++++++++
>  .../dc/link/protocols/link_dp_dpia_bw.h       | 24 -----------------
>  2 files changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h
> b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index 1927eacbfa71..85b57848f5cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -627,4 +627,31 @@ struct fixed31_32
> calculate_sst_avg_time_slots_per_mtp(
>  void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);  void
> dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
>
> +/*
> + *  USB4 DPIA BW ALLOCATION PUBLIC FUNCTIONS  */
> +/*
> + * Send a request from DP-Tx requesting to allocate BW remotely after
> + * allocating it locally. This will get processed by CM and a CB
> +function
> + * will be called.
> + *
> + * @link: pointer to the dc_link struct instance
> + * @req_bw: The requested bw in Kbyte to allocated
> + *
> + * return: none
> + */
> +void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
> +
> +/*
> + * CB function for when the status of the Req above is complete. We
> +will
> + * find out the result of allocating on CM and update structs
> +accordingly
> + *
> + * @link: pointer to the dc_link struct instance
> + * @bw: Allocated or Estimated BW depending on the result
> + * @result: Response type
> + *
> + * return: none
> + */
> +void dc_link_get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw,
> +uint8_t result);
> +
>  #endif /* DC_LINK_H_ */
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
> index 58eb7b581093..832a6dd2c5fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
> @@ -44,30 +44,6 @@ enum bw_type {
>   */
>  bool set_dptx_usb4_bw_alloc_support(struct dc_link *link);
>
> -/*
> - * Send a request from DP-Tx requesting to allocate BW remotely after
> - * allocating it locally. This will get processed by CM and a CB functio=
n
> - * will be called.
> - *
> - * @link: pointer to the dc_link struct instance
> - * @req_bw: The requested bw in Kbyte to allocated
> - *
> - * return: none
> - */
> -void set_usb4_req_bw_req(struct dc_link *link, int req_bw);
> -
> -/*
> - * CB function for when the status of the Req above is complete. We will
> - * find out the result of allocating on CM and update structs accordingl=
y
> - *
> - * @link: pointer to the dc_link struct instance
> - * @bw: Allocated or Estimated BW depending on the result
> - * @result: Response type
> - *
> - * return: none
> - */
> -void get_usb4_req_bw_resp(struct dc_link *link, uint8_t bw, uint8_t
> result);
> -
>  /*
>   * Return the response_ready flag from dc_link struct
>   *
> --
> 2.39.1


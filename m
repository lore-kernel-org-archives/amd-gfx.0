Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263D1C636D4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 08:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9140B10E1F9;
	Mon, 13 Feb 2023 08:25:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FD010E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 08:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgUYyRbLUBZGUNqwBdAd1/dY15pcXsxvGzed61CrWPgK8KzYnyxysNbZ+JvUuFzfVRFKDwi1KVRDJdTtMu4sCb7AQ6SU2XG3r8IyCRVKWPYFwBUMUII12zp3IhjpRi5ot9hIqCC+GYugDJjrY89sY2K1MxvJsjHrb9meUZq0l3KVWRLb/r1aCk9tXhd9q6L8fQJk/R1WTLM+3r1Cz9TpRYFfKvoAXloYA/UalwGOLCGvtKgNStk2ILGbkYPFEA8dBAdfeN9Gb8PuUzgIsul8x07PhF6fDoytIbpOvDadhxo/JaJSUOG66NXhR719wKQ36j09GoZ9F7b/p1gSY6wpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEB2XSG6wnM0fvQBs2h+NQBCY2GsOtEODGakgMLSZkw=;
 b=Sydfq/Hi8+l7LZUmb6DTaXqCWVIeMoepgTF/8sS6VTLenJgheTAVjuhQLV24hK51SjCHnwWbLJ/DETH0wwACnB2YKadXYWXzijAsrL9y3s9mLlwFlsGsYb/fmGHJjI+VSZKQRDVuVkKhU5u8sG50TuVeUy9/n5aezlFMQyp8klDxRno60EW8FF5h2s7eoW4MwrqtfWkYAHiZ43DnLjmFCT6nHpGt36uIk/57kUIb+npcUGpt1sxwvUgvdWuYyAI6MiP2z0f2qEQMpl5wcPsIepBscfhzmUA1A8pCSr2GZt5bkuQKByM7sO0HQuVoTfwkMPRVI9qXSXoOpNXc/Q6r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEB2XSG6wnM0fvQBs2h+NQBCY2GsOtEODGakgMLSZkw=;
 b=d4Hv9FXO1MOQih9+SOijW1c1XHeZI6bPQwm+JS2JLq5cRezsbi1pTo3afsFgR2npAwRqI/LfC2QCCG5JMOoB67nTUQhgwSq81x/VY6HusUkz9nBhgw0YKDtnD3UFUsSjoivPoqTJQle0MwHjUmtjHPoS0JcpE1PBqcydreyjUw8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 08:25:00 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 08:25:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYCyokUNaSQkeAF4mLprNJJa7IRt4AgARGmWA=
Date: Mon, 13 Feb 2023 08:25:00 +0000
Message-ID: <DM5PR12MB1770029EB462C56B50984414B0DD9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=024f425d-59e5-430f-b54c-3a849f1aea78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-10T14:59:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DS7PR12MB8082:EE_
x-ms-office365-filtering-correlation-id: 3a4924bf-e7e0-4d42-8ecb-08db0d9bcc9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxWAAET+49NHgYuZXN4ww7TE7GyE4ZJR/av9hQR7Z0+iHomsaNjWe2g53uc9Mi8a2kYSutsBhBxu2XfiLNtrgkVZQ7sC7B+9kL60JWckUnnSMgFHr40raP4HrbcLZ+OTUG7pMqsYjcbkA27wUhb+tX+j6UCijU643vImYVXmZLzdif5N11OZG+W1NImEiz37VQrCotrlX8xuVDHqdACn30SOlzV+JBxe0DD/Gb1GC5/ODQeziuHlOkgyqXuRLlQFGtB7bYG9SDCUQK+5ZSL1xk+xpEBfTL63hvalbabO0yGfnhxHFlBo8JvJkcJThTmgq5WPcE1ZqdiHjEIINTTZr+RNE+sZMcVosdEpkSg/UmUp+NIq9GgfdZrJcTMG9OpfDawVF8ONNNSN0C10SUYIFM1fKn/Zx1uoN3rT6USinK+vAK31uGg4Mi4YK+pWStdzCFNqwSdgGi8AV+x13lD8wkLEXkid/IcKLHSOulLdki/KOjZTfsGq9TpbzAoiNNOKNmqQQ7Hj7pR8D73tT/ABdZwCFyd4a19mT7nqoT1CQzXlGURMLuepIOVwbvzKIygqdzABW8dCC+kmJPbI3m0k0oY2bi6JR0J29cDelHQaS4hSlk0mGrnGOI/wvFrsRiT/Bo2zHOzINovyMDntKopkS/NkmfhF/Kc+iw0qFfFFH2JsDMwwozZ5Sr5SBhpaST+ZCKyGw0a/AZaQeorygRr9Ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(7696005)(6636002)(110136005)(316002)(8936002)(52536014)(53546011)(6506007)(186003)(478600001)(26005)(86362001)(38100700002)(122000001)(38070700005)(9686003)(5660300002)(2906002)(55016003)(71200400001)(33656002)(83380400001)(66446008)(64756008)(66476007)(66946007)(66556008)(76116006)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pi0zRFFRamP3TsqZlfnhjwyd4C+H1QwGblAp91DCVWQCleAxRbQb5j43mZTG?=
 =?us-ascii?Q?7+BmNu9n6/18eTImCRUr8HaJ9Lwpciwji0bk1lTJ6xhHx6q1x3qzxy2aljIq?=
 =?us-ascii?Q?zmOSfQlP2zBS3/0vwDZ0vKlgB++Zrz/QGt8T/fanhyZ3IzioyTb3pA2krFjv?=
 =?us-ascii?Q?ZlE09AUD3g5leau/w06t/NBGK6DGGAvqOpfmHf+cCACA/5RjQ6wY+N9p3Zl3?=
 =?us-ascii?Q?7plpqYNJIXyg+/AdcbQ7J5eT8wEaY7Sgu/4/xlFkgs7Wu0Urj6d/yPrerqwu?=
 =?us-ascii?Q?k4BWu4ur0G9ul/6CRGXRFKJAJ4eXEuGUi9SLkuiW21TTWGp4E0DEwn3rcrG4?=
 =?us-ascii?Q?4cQpv37Q3IxJ8O8koo+Fnu88CZ7houvvhMece3j1nL7ZX0bUO//jLaxAz4Yj?=
 =?us-ascii?Q?snlVUdEoynAKVnPU8UccYBm85kzZflymEE5xK7S+34iLeuVz8b7r91qNDmX+?=
 =?us-ascii?Q?FM7/XskifbYRD7R9Oy8ndhYu5kI2OBTuZCQg5jmSzUXM/QLT02OBBNRB7DUt?=
 =?us-ascii?Q?S9zW6yrDAvbHdPaS/voATr7QX5b34X4NL6UNCaT42tWdVLdK36HmD1fSaF6m?=
 =?us-ascii?Q?zze6wa00aHcVxS8/PDmoHRtXk7mwoD3W/tCDs+C2bS//kZT4Ia4M7QIhevFS?=
 =?us-ascii?Q?1XgRvULYuDAfBSIJbCC9WMUiVA5vsNqbZR01BKNkzcA4m1Pz7hR23N6zV9RG?=
 =?us-ascii?Q?mycA31vFqgAOJnl6+WssU0GcbdnrE1ofMmdDPJnW0abmQ/vNsHBSxSBmqlWt?=
 =?us-ascii?Q?72GCVEUimMJ0DrZjmxS5ixx5M8gqwEbB3Ez8YHVLZCooqOuK+qgfWJBz+LVB?=
 =?us-ascii?Q?oItwAeaY5Tntab7gyH1JcMk4aMqjatQiG36p3t6D6K/T6FhsgYWhDG3Bbai0?=
 =?us-ascii?Q?8MiNHm+mIQp03LoEBYOV9PMPkJtRPZYDFjzI7qnbayZdrQ/9mjNDz8yY+v0w?=
 =?us-ascii?Q?sqoUABqkMV4hfAouAjnHWc41+sK/baZUJao+CNfapH40w6wdYM+CoRdFT0Qq?=
 =?us-ascii?Q?4odndQiJS3SrLqnzmhYHJI49Jd/JUe7HvgI5Y+nW5jZe6TgXHp+yHmlwpSpW?=
 =?us-ascii?Q?X6CvcZV8cPl6gpOErSvvh9ncaEpoRabIjNr2bkkeP0EAL8YwsUip29sBx8d7?=
 =?us-ascii?Q?LFGh9jjn7YQWL91sv4THnMqG+UiWF1shJ/VOVpqUbAGpCYprIKI/UdnYBy1K?=
 =?us-ascii?Q?yhK5mzOmuvP8whLBPJSkErBuwsmUSKNW9jNH4Imk3VLP0moLvt3j+DE9kKxx?=
 =?us-ascii?Q?Wz7FfJOFFeJWM2biKiPerSDHbFlwDcIl8GVGl+NwdcFfkbk8qHfXbsOeezmu?=
 =?us-ascii?Q?dIT770FfbY5xUlNx2OethS8GYt+vtPsCYQeTrG1eFRSuCmfUaGH100t+oMGV?=
 =?us-ascii?Q?TaOAbiz1eDuYalS4vt8veQyg4tXv4y9+Qtp80Lx4P4+SwWzN55/Hm8QVberI?=
 =?us-ascii?Q?VfvpupkEHGXo5BwTYw0mtmm5UOQjnvIeVGaeqW4ZsQ5ej3KnvUi/+89W/wNW?=
 =?us-ascii?Q?P+63I9iRnWoUlTDUwnyF9KkVYHsE3CAisugal5DXYbPvmKg1L8nIdPD3eyR2?=
 =?us-ascii?Q?VN/mIXZjOkqGclPnAiY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4924bf-e7e0-4d42-8ecb-08db0d9bcc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 08:25:00.6805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74i70FEr/og7+J6CJLX7+e8AwwtIM/OpxhR2Id5IcLnYyS9VX8LRfjE4ixh8xyr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, February 10, 2023 11:02 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no ne=
w
> bad page
>
> [AMD Official Use Only - General]
>
> +                       /* if no new bad page is found, no need to increa=
se ue count */
> +                       if (ret =3D=3D -EEXIST)
> +                               err_data->ue_count =3D 0;
>
> Returning EEXIST in such case is not reasonable. Might consider return a =
bool for
> amdgpu_ras_add_bad_pages: true means it does add some new bad page; false
> means it doesn't change anything.
>
> Regards,
> Hawking

[Tao] but it can returns -ENOMEM, amdgpu_ras_load_bad_pages and amdgpu_ras_=
recovery_init also need to check the return value. I'd like to keep the typ=
e of return value unchanged.
How about -EINVAL?

>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, February 10, 2023 16:45
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new ba=
d
> page
>
> If a UMC bad page is reserved but not freed by an application, the applic=
ation
> may trigger uncorrectable error repeatly by accessing the page.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85c4689ce2c..eafe01a24349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,  {
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>         struct ras_err_handler_data *data;
> -       int ret =3D 0;
> +       int ret =3D 0, old_cnt;
>         uint32_t i;
>
>         if (!con || !con->eh_data || !bps || pages <=3D 0) @@ -2060,6 +20=
60,8 @@
> int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>         if (!data)
>                 goto out;
>
> +       old_cnt =3D data->count;
> +
>         for (i =3D 0; i < pages; i++) {
>                 if (amdgpu_ras_check_bad_page_unlock(con,
>                         bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) @@=
 -2079,6
> +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>                 data->count++;
>                 data->space_left--;
>         }
> +
> +       /* all pages have been reserved before, no new bad page */
> +       if (old_cnt =3D=3D data->count)
> +               ret =3D -EEXIST;
> +
>  out:
>         mutex_unlock(&con->recovery_lock);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1c7fcb4f2380..772c431e4065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -145,8 +145,12 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>
>                 if ((amdgpu_bad_page_threshold !=3D 0) &&
>                         err_data->err_addr_cnt) {
> -                       amdgpu_ras_add_bad_pages(adev, err_data->err_addr=
,
> +                       ret =3D amdgpu_ras_add_bad_pages(adev, err_data->=
err_addr,
>                                                 err_data->err_addr_cnt);
> +                       /* if no new bad page is found, no need to increa=
se ue count */
> +                       if (ret =3D=3D -EEXIST)
> +                               err_data->ue_count =3D 0;
> +
>                         amdgpu_ras_save_bad_pages(adev);
>
>                         amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
> --
> 2.35.1
>


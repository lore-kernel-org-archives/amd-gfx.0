Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC7CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 04:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE91D10FA8F;
	Fri, 22 Apr 2022 04:03:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5105910FA8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 04:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvfTM5+fIV0inmSCy6rEt7zfyakV6f1GVXu096x5VN4y3Tmww/nvPpi1hO98tt/Jf85XXe/C2cXDZfhqheXe1Z7v1i4yUh9L2ILOZ+1zSBJUxKkHXxRv9mGaHS+MGgNSbUvcDoYTD0Qsw9fUlyrkJpaPyJ83vW4Y/T8pyrqVIRDUq+7CLqfpofXZ/iuwVlBlqtzm6NKbXcWmlvY9mUsXRZAim0Ehv/bNfj/8XyQSEXqslHQZmTBlNQazGL0tpzc6iePC2cydLyF6jCADriBWUpprYxSO1o5LesUOKPlppKnkD/rbe52Q6sKoioF7Ys7oDPloxQp+e9cQOmaPENCRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8mvYMCWPSUFtvPmyCHEMDXq1ey6AtK3ntGkGVA9gn8=;
 b=L9El+bVt+FxttJGd9U84Hp2++7XCUYsoD1VkkGO3jRcWtmnAPbrvS4YjA0xT84LiHVWJbpdtnatqZmtK6dQOvtjese1ktWwdCcNhOzGxpSctBYJ7n5EqK43tO8yv9WxqhvlUCSYePx/6FNgZP/KYsV1sbkUaDe0ZwfwMKYO/hPFDSuLHY6arKyIyvO/1EARib4Rwj7t5JdSWcLRpTBZMESC2NSaRSKhpE3Tw8ApvdzQqfc7LLOIdqww1h1DdT01wji4cnTVFQe+az68Ut3YGEEBK6Vqg7NAX/5f2ZGTy5oE6Yt8c5OxLFfj5tudI7Cfd/W4siltK3e0G31AbZaiqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8mvYMCWPSUFtvPmyCHEMDXq1ey6AtK3ntGkGVA9gn8=;
 b=4rZcTUBL8WmUTsDQL73KmMYQYNPKU0Zc8fFeA3RJTGgF8MgQZveQD3aFcW17QtFfkx1CbONXBzNs0a8kj7HBAyOjO2I04K1twFdK5n6x8x/v4hLdCuBdYkiomHL0jJz+h+tMhHHp1HGK+9cZqHxtt6LyE9mIIaB2vq15C4TIMb8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 04:03:52 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5164.026; Fri, 22 Apr 2022
 04:03:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Topic: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Index: AQHYVKoMoz1nvWYvAUmrFLaB9PJsnaz6dgCAgADZurA=
Date: Fri, 22 Apr 2022 04:03:51 +0000
Message-ID: <DM5PR12MB17702D829CE11CC3DDC8481BB0F79@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220420113009.8062-1-tao.zhou1@amd.com>
 <BN9PR12MB525799E8EB8215726022FA05FCF49@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525799E8EB8215726022FA05FCF49@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T04:03:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d633df3b-aa92-4fb5-8209-d1ecd4d95b9d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-22T04:03:47Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: a0dbce2f-7d48-40de-b9bf-5943b9c74405
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6a7907d-bc46-4a24-5e50-08da24151c2f
x-ms-traffictypediagnostic: SN1PR12MB2493:EE_
x-microsoft-antispam-prvs: <SN1PR12MB2493F287FC79F1FF17AA4AB3B0F79@SN1PR12MB2493.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idX9uig/lLLrnSKX4CG/pa7XMrCIeJJT2s5K0mEcIJMy2RQDaY93EcFxdHebAgrVPzqr8JDsk9ATmjynNLftHg4d4KunStJJsKxQ/TFSi7Q6n2iTDubudKD1xGhzn6gxufGz3eZ37ukf0xmRflbpni3Eo6dxjtfcwEH5mLicqRr+qeCMLwWz8vVZpxoXyX2rT8ZKA1J9pc+soOT+aqiVTca75UPF+kOKaJ6QH15kiaHpCl2xuNwz4VuZjOwdDz6ZjlKeaM37ZZpfbqbup95XqF1mxdFdO1Svc+bEc8k6yel6gVUTneUgMGPj21qU7ChXNz6sTFA49ACcE4yX0kt3mOkPSvOfFGwxI+LWVCRfTBJPxU/i3SE8qvv7sWorDHRcA/ozbdtF3tcyWl2HKsTENzRPsj8McmD5qxdqYSC+1JtTMT9B0hQeA2wYmVcJdnLePHwwik1SIEr9i/nqf3MHlx/WfKGm0vPEvarF2OfUpROdaTr3G2Bbbx4xvLwmujJDsqur0BVIKAhEqNgbDQxlqoPCTfN5MeWqH6IOlua0vnLLf3bzMkNCBH0laJCoIyl+ZK8rxIV7nAsXO8yf4jKWn+YWPLcp6KSXWUCgq/pPha6u8lmwd8Jsbx4ux72fMQjIhC9lWBewLv662o6pkUfMhFCUoqU/PpZKEzP19JdjYGRm58ljAVCt1qrqViazhL3eRGUE3vqqr7lqSGTPVFL5XVQs/QieThjBKm7F6ziJAuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(26005)(86362001)(66946007)(38100700002)(53546011)(186003)(508600001)(71200400001)(76116006)(316002)(110136005)(64756008)(6636002)(66476007)(66446008)(8676002)(66556008)(55016003)(9686003)(83380400001)(6506007)(8936002)(921005)(38070700005)(52536014)(2906002)(7696005)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjZZL5R969JDyaRCZEc8Kq3sz7+iqN0zGT9RoLrHQJXqNsrqzX40y4Egj2dI?=
 =?us-ascii?Q?islcqDekNIaeMlm6BNJvUGazR5GamFMVO17WMCQnrGwpXzxASL4WWVoPJORE?=
 =?us-ascii?Q?spaVqnfmqbswUomZ0LZsMTojcr446HSLSMReTGYU7Me/pWk2wY8ZaiIT8COL?=
 =?us-ascii?Q?qLBNAxi55Gs+3k7mvzlYdTSJfRtkFgR5ftqzH4HR9KjIvFbQgjO5TfUdw+Lj?=
 =?us-ascii?Q?RzypqnV+Z7vb9snPbUANYcP2Mi80cHe6GRh553rpEnWtDLGQmq/+3rjoUu9D?=
 =?us-ascii?Q?NINyhIX3bEzQGfi0joBin1kgUMbSYjrIsRaZUOfxoYScPyQtdPuOVJm73uWK?=
 =?us-ascii?Q?8/aEUnLcdB5sWYRbPahF4ME5b4MLvhOXJSyQnbHMcLRgnHApu7d4sA2tfTH6?=
 =?us-ascii?Q?zvNYXK2L3aUDxHxly6JjyCquhIAU/FA/61rU6pPDIt118QNzj5QrAE9T/ccb?=
 =?us-ascii?Q?YAWtEBNAvf13SnaXidk64T6D/FQyezWyIUNY8QsaMaPxJSpjsAQ7xt/dwzgg?=
 =?us-ascii?Q?3Ls677agggKbkpUGHOjZYsiIOL5VeQ6AyCUfSm1VGQ8Ale2SedqhLLANtwR1?=
 =?us-ascii?Q?vSEfg1P+Z/LDilh9tnZggN0Atipd3G7pqghDgPkX5sreHI8CqkjrA6vy3b+D?=
 =?us-ascii?Q?J4b49ptDMcKS77eADoK7pW4lwupDITnPLxcjsKBKfj3CFWcfiFcW8fnLmkbb?=
 =?us-ascii?Q?f5gJ54ZJtYMlxl8L1TTohSiHXMQf9WWKcEx3wt9XhYJnz9TilU8oT5lux9Zb?=
 =?us-ascii?Q?A5yd80M4bv4H+uZhvPg6QW3ZOKSwQnLgOtM7OJkrJrFdaOxythInF3ko+9dQ?=
 =?us-ascii?Q?t9eH9L5AiAuCKoCRQr6SC20b0wLep6S7I8mtQ353UcC340b32mQgggd/mbVk?=
 =?us-ascii?Q?aonEcMHAdex6TJSNZ2emZycBLDLsHuATPJxAPMjnNh/wil5HtfQHBI9kbOSf?=
 =?us-ascii?Q?hOlmoOF+u7qeAw+F+D4u5tyj3HsZVaYSzJR2xTazqBvrOxctLMeFWjFz/j0O?=
 =?us-ascii?Q?ASHO6OcyFMO+ldnJlIPpbX+MNrFFe6dqU0E1G3If64COmr2b3PPMnYBGMszC?=
 =?us-ascii?Q?OH+NfMMBpRe107w+Nl1JN5dFOCANlxZs3/PvycDaNxRWv2SOL0GnO4MXEV8m?=
 =?us-ascii?Q?DNDKmxndNxpG7PpbM36eN9aex0XFMrwsRWd3/MQzs4GWCrwCtubDgKGXPFc+?=
 =?us-ascii?Q?CG7jErPOty5jDhWIMMotmEyEH68/kQDxmdImxzxrE6IuL52ixwYKDH+ZQXtV?=
 =?us-ascii?Q?ntfSL18upT5QXEZjz8xtatIo7x5q/FQFwVoVcdmw/cEEfidzEwGgP/TEeYED?=
 =?us-ascii?Q?Sw5m1UUPRLnjk35StWwz6izv12IMJzzzEgB10Za5eVbY1sKvHuTohgiY9LQ+?=
 =?us-ascii?Q?vzhr25+lJ3b6y4CknurgyLC63nWIiZR3Vky9lxAPRvhXS+cOUqEhbd3sxEv5?=
 =?us-ascii?Q?3fPzZ0zLjhVdfSv8wE882oWZkbREex34cg/iQ+6Fo5DonSTKJno3M9MXqsKT?=
 =?us-ascii?Q?Qrvj2vqaOGccTGkjSCVZmPirTLlgX9Lya4NMqtprDzZ6bo/WD0TsUy9XFoKt?=
 =?us-ascii?Q?v/oSzBaGjnnBnrg3S6tOB08SvH0YY7BiYOEAI5ttoxz6CLL66by2B5O/G56f?=
 =?us-ascii?Q?U9uzNrZ/PtncZQAnn1W0RDijtyXMeqPfaKGPRbD1qUdxboSBg6j2AkFvXs+t?=
 =?us-ascii?Q?milGoq+QOJmcR6qgRYOuG4AxMuqfnbH3IBG2d2+QWPCzPrcOgjCnNbo8ztM+?=
 =?us-ascii?Q?XZdkD5PPpA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7907d-bc46-4a24-5e50-08da24151c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 04:03:51.1501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzgIeOcu/zS2ogS6nl+EsOV6x+YQIJMdusN/zv+JgCAnYGg696dBtBog5cp338sz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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

[AMD Official Use Only]

Hi Hawking,

The logic in my patch is:

if (poison)
    if (umc)
        poison_creation_handler
    else
        poison_consumption_handler
else
    if (umc)
        umc_handler
    else
        not supported

I think your suggestion is:

if (umc)
    if (poison)
        poison_creation_handler
    else
        umc_handler
else
    if (poiosn)
        poison_consumption_handler
    else
        not supported

Either way is OK for me, I don't think one approach is better than another.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, April 21, 2022 10:54 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ziya,
> Mohammad zafar <Mohammadzafar.Ziya@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
>=20
> [AMD Official Use Only]
>=20
> Hi Tao,
>=20
> I was thinking more aggressive change - current amdgpu_ras_interrupt_hand=
ler
> only serves as umc poison (poison mode) or uncorrectable error handler (f=
ue
> mode).
>=20
> We can still keep it as a unified entry point, but how about check ip blo=
ck first,
> then if it is umc, then check poison mode to decide poison creation handl=
ing or
> legacy uncorrectable error handling.
>=20
> As discussed before, we'll optimize the poison creation handling later. s=
o
> keeping poison_creation_handler and legacy umc ue handler in separated
> functions seems right direction to me.
>=20
> Thoughts?
>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Wednesday, April 20, 2022 19:30
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>; Ziya, Mohammad zafar
> <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
>=20
> Prepare for the implementation of poison consumption handler.
>=20
> v2: separate umc handler from poison creation.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 70 ++++++++++++++++---------
>  1 file changed, 44 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4bbed76b79c8..22477f76913a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1515,12 +1515,45 @@ static int amdgpu_ras_fs_fini(struct
> amdgpu_device *adev)
>  /* ras fs end */
>=20
>  /* ih begin */
> +static void amdgpu_ras_interrupt_poison_creation_handler(struct
> ras_manager *obj,
> +                               struct amdgpu_iv_entry *entry) {
> +       dev_info(obj->adev->dev,
> +               "Poison is created, no user action is needed.\n"); }
> +
> +static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
> +                               struct amdgpu_iv_entry *entry) {
> +       struct ras_ih_data *data =3D &obj->ih_data;
> +       struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +       int ret;
> +
> +       if (!data->cb)
> +               return;
> +
> +       /* Let IP handle its data, maybe we need get the output
> +        * from the callback to update the error type/count, etc
> +        */
> +       ret =3D data->cb(obj->adev, &err_data, entry);
> +       /* ue will trigger an interrupt, and in that case
> +        * we need do a reset to recovery the whole system.
> +        * But leave IP do that recovery, here we just dispatch
> +        * the error.
> +        */
> +       if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
> +               /* these counts could be left as 0 if
> +                * some blocks do not count error number
> +                */
> +               obj->err_data.ue_count +=3D err_data.ue_count;
> +               obj->err_data.ce_count +=3D err_data.ce_count;
> +       }
> +}
> +
>  static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)  {
>         struct ras_ih_data *data =3D &obj->ih_data;
>         struct amdgpu_iv_entry entry;
> -       int ret;
> -       struct ras_err_data err_data =3D {0, 0, 0, NULL};
>=20
>         while (data->rptr !=3D data->wptr) {
>                 rmb();
> @@ -1531,30 +1564,15 @@ static void amdgpu_ras_interrupt_handler(struct
> ras_manager *obj)
>                 data->rptr =3D (data->aligned_element_size +
>                                 data->rptr) % data->ring_size;
>=20
> -               if (data->cb) {
> -                       if (amdgpu_ras_is_poison_mode_supported(obj->adev=
) &&
> -                           obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> -                               dev_info(obj->adev->dev,
> -                                               "Poison is created, no us=
er action is needed.\n");
> -                       else {
> -                               /* Let IP handle its data, maybe we need =
get the output
> -                                * from the callback to udpate the error =
type/count, etc
> -                                */
> -                               memset(&err_data, 0, sizeof(err_data));
> -                               ret =3D data->cb(obj->adev, &err_data, &e=
ntry);
> -                               /* ue will trigger an interrupt, and in t=
hat case
> -                                * we need do a reset to recovery the who=
le system.
> -                                * But leave IP do that recovery, here we=
 just dispatch
> -                                * the error.
> -                                */
> -                               if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
> -                                       /* these counts could be left as =
0 if
> -                                        * some blocks do not count error=
 number
> -                                        */
> -                                       obj->err_data.ue_count +=3D err_d=
ata.ue_count;
> -                                       obj->err_data.ce_count +=3D err_d=
ata.ce_count;
> -                               }
> -                       }
> +               if (amdgpu_ras_is_poison_mode_supported(obj->adev)) {
> +                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +                               amdgpu_ras_interrupt_poison_creation_hand=
ler(obj, &entry);
> +               } else {
> +                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
> +                               amdgpu_ras_interrupt_umc_handler(obj, &en=
try);
> +                       else
> +                               dev_warn(obj->adev->dev,
> +                                       "No RAS interrupt handler for
> +non-UMC block with poison disabled.\n");
>                 }
>         }
>  }
> --
> 2.35.1
>=20

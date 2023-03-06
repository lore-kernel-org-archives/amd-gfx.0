Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0290C678D4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 06:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A7410E0C4;
	Mon,  6 Mar 2023 06:31:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D0910E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 06:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blR5CQT7LANFF3S8RVRD+GAVhNX+uAa/s/X30y89FyLRw5pwKFzMFTVdJB10hkvL6ihW1sY1pnpboF23KDtLwI1FQ5cWmZMcZoUh//5pl9rjqDoBzjClWr3PILQsoIZ+fdwf8RQF5iRleRLepsnBPa9r9eXsjUEWP5RZtXfG+qN8e5tqiwC9dm+qbfGDNhATU7lxmjgJXjWyHM2bcnD4xIVnjicMc7TP3O9JPOEdpj3oS+Z1C4YqcAKFlPRbIY64mUID9/j08EYDuToNM3a/BEBVZ3pJpyM8CJy3ij48Wp2C4ZpllE47Y6/xkhhsViPfjVYjgExu4HChjtPoPSpWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuUIEqfp3H+EZneh5fQpqy9gZIFNSNJGU5aymCOLi60=;
 b=FbgXSU9e61T6isR3HVkI0g15gM1Jp2fG6mLrfRJrDddzA9uHI6A2jLTtBizE+5mjvzJjVkECxgx75wykT5QAoCyIqjJYdLHsgDTus1xqAxNVQlZWQJMQpm8TcPY6uqmAxBk8aGSG1fvce00SHGVipNM8HxgACH5ujFOsbF/HfgBXFizt/Iun+pZXxfpCvF5vB/ah3X0vmNKzWj6VwDryIe/qnGNxwz449VwrrJgPOhDxeqDWKT9pOt3fo/x7tLsKZxFmiQC6afmZwMRnuQh8aR+MBd8QnLjUCNdrFPgSUmIwCIAa3EUFcPt1MgxCF1DQfSumOQkFtEA2IQ0DZNz40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuUIEqfp3H+EZneh5fQpqy9gZIFNSNJGU5aymCOLi60=;
 b=qwYFtDVOdbop7d+5fG6mU0xh6pQe+gJENYKRoE+/DYtsbkbisswOFX5vKETqyX5IroVL1j+g86kT4ic121E8Ctxr+7BY3qNdxhIYyjQ+LSsDregI/YCZXH1zSXItQdyVpXSSIhv1XCvKDW48TY85XqrpP7eVDVteMnEfDl1ShHE=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 06:31:35 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 06:31:35 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 03/11] drm/amdgpu: Init gfx ras block when ras is supported
Thread-Topic: [PATCH 03/11] drm/amdgpu: Init gfx ras block when ras is
 supported
Thread-Index: AQHZT9PzFVWKZ/02G0iIa+PTxn9+8K7tQu2g
Date: Mon, 6 Mar 2023 06:31:34 +0000
Message-ID: <BL1PR12MB533413816319DB8A7AE15BDC9AB69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
 <20230306023200.29158-4-Hawking.Zhang@amd.com>
In-Reply-To: <20230306023200.29158-4-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|SA1PR12MB7198:EE_
x-ms-office365-filtering-correlation-id: 85e8c8ff-15fc-47e0-6cac-08db1e0c6ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SErWRbG9GEb4dlj5KApQ2zyCuYrx9bqPDWOnLyUiZM1eUNKQG5sSGxclC9L9STF9FPoHBAK74g7lFPt3VuTSS372igIjYp+aBkXdBYvbMo6EuK9gXqzTGIWd7SWPolYbluEy0DkN9yyU4eyFsFycWL+mhU8MI+qXsv3vV6bVgP8vVhBn6InIzQnV/73+X4QwgVEmIrnGKvrWM1pMhK7TDN6HGXPzuK3R7Big23yy0KGunNZlg+O5hUYffnN8oYxw51GFbHlhsumpPl7u+cJYm3E1wye6aWeMmg4sZHSOWiYI7hhoW9Bt3BkEQBnF5MGg8/fCEgo6vCGHdT7n+Na9d4f7q/xflcd/CPTDPEW2vQpQT0NeCqbUH55RB7ppLJjx+iXcB8ISiwYQLEvUEO9stVJZsNuDX3xcBHrU9fzHN5t3rVHUz5LtaZycHhdiMd26dQ4JOwG9/G8P3zGz75/YmAhO25lvB+PmrxeQo/HqKg7rJTMG6VMWxouMdvE0knvyVXxJSbdlINI1CDxBMupKLa2UXmaAkMwMYs3AO5AB2VBsQlz4+Wqi1lCXB/64AgWpA833QjdGBP06E1Y478KuPSa4IEf18OS+Axqq5AYtw2UIgs2xm7tqz8pQTnHkoxxdK+Iu0SyYweCWs6WCP//Iq2SxmTjJmAinguQIXWPFpnV1S+3HmUdUJoyctEXYqBgofHxE62WxH60GQh26ANoTWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199018)(9686003)(186003)(122000001)(38100700002)(38070700005)(52536014)(8936002)(66556008)(66446008)(8676002)(66946007)(41300700001)(66476007)(2906002)(5660300002)(76116006)(71200400001)(7696005)(478600001)(64756008)(53546011)(6506007)(26005)(316002)(110136005)(6636002)(55016003)(86362001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B2cVfqpdqAfjXsA5+xrFa0wtnRqIc9+2dn0O6BcwSKI0cVUB+7MtQGc+YQOq?=
 =?us-ascii?Q?6vCMbrHMF61i2k5Cdpirelw8yjtDth7IbT1q0yfhT43onZEABgOC5N9fdlNC?=
 =?us-ascii?Q?F7hStpo0+FohrXIRaXF9/kCEoAKufpkXCSedGjIO5d1rwFr4xj3YoEo2IqH3?=
 =?us-ascii?Q?rUuGYhN8tAvzyEl1u7hLWMI82a6kHjNZyRAEVQ9Ply3PlFotjnhOqdC3BA/M?=
 =?us-ascii?Q?Bmi8y9Nq5BJ1MTVR6jiQrH5IlupYkjHhOtQSuJljDuNChzpniRpE5XKQd45M?=
 =?us-ascii?Q?0AkxBMbPsTPdhZINLcbfTNE5HHIIoVcLTxNnXN/ty/i5yNir19mmJFMpQ2i/?=
 =?us-ascii?Q?czbOTxe2ZDDFXRnOp6uZqs3Wl60nyJy2N5OejGnztLOqLCJnof56wNR7G0Ya?=
 =?us-ascii?Q?0EnZbObX9fDH/mZQAJD0jdNBpkFcuoW3ZeA4d65yh0Uvbf1x5HyU4h7G/dlQ?=
 =?us-ascii?Q?o3uPjwFgNVt+Doy8/8i72F8Wp0sqYSw3JC1ufZbU4pNX8uiXQ75ZGlh1JoTb?=
 =?us-ascii?Q?X+XgQIhP2Qi1T4OLp2uhPj/xCYOa/HxNoEwaBuYQvFfufIblJKXaictGhhEd?=
 =?us-ascii?Q?yJTewKkY7DjZEN7ygjg36zg4uflmpkd6TwXyxFAA90hlskPEiDE/4wqbc6tr?=
 =?us-ascii?Q?V8EM9dMp5G0Roemb3/Gyx6ccGinajWx30Nxns+r5ebvLO4BPA6cp1qy0rzdh?=
 =?us-ascii?Q?l7BtflCnkqeq1ISUrePZCPPDBSibSzGmRxkOunCerZ/OJHKbMvzSSz8c9C7D?=
 =?us-ascii?Q?6lpuYMjNVjam7ioHf0+ziTVf7pxZX6QHWFJZKeofSdzXULuNBui9PZ2CI94D?=
 =?us-ascii?Q?6+2KrW/y5u/XaOyIr6pupS0sDRhp/Ks/zYwg+JpXDrr3IiIok80t4ma6Kl9H?=
 =?us-ascii?Q?Msbi+RWIGNXugmaRyumZ3sgGTUukVCClkf+mq6gqVF+nFvuYd9wMNWsVtIrM?=
 =?us-ascii?Q?M0mlGsP8NRFtScUKgGqxeYSZvocbXyk0Cyf13zGl9DK8Kx86QADCg3j+V048?=
 =?us-ascii?Q?BHrMErlL/F2OhNwUjJS5fEwCkgrQpADPHp41r41Fe+OyxnejJz7R16eL0nDy?=
 =?us-ascii?Q?a0AwbuJLqEN2BZOCbLlTqPqBF8Fvq9orGBJptY+Xj9ZDjiG+2PkbE1C116Tv?=
 =?us-ascii?Q?dfoQxgFRJwUhxHUoy7d550eIK4XG7bbGQvHAYatAk4hgAwQlARPzjCvzZ0yz?=
 =?us-ascii?Q?cMl+xsUYqlXk2l7gYLx9hXhgueddSmpp4Yv1r5edreqCRA0CqkbVIlPWJc4z?=
 =?us-ascii?Q?Pv2CJT5278K7VrjhE4PSzceP2T4tv7hHcSgJPReFAqhVeIu2ajEKVMlgkKWm?=
 =?us-ascii?Q?4Dl84U6PWYgAPH6W+fejWdVB6U32ukX3u9BJTb3J5E24t/5LPZsSbTx4vPar?=
 =?us-ascii?Q?GFkiy4cNo/jg8sKgkiSPO3QigK+9d5YL26aTYY5FcPIDPkN/5SSFpVTsNdDl?=
 =?us-ascii?Q?erVgkmgELKlNUowUXkLx0ZTJDtLAThfc2NMAXrX/Q4dpIpdhFxQQ3E6AxbNV?=
 =?us-ascii?Q?FcV7YDkRhQhP8cUAyh26gC9yJU+/eQHuCpkm5VVRVTaITGz7g0FkjerjYt+x?=
 =?us-ascii?Q?kSa+ILljIhqodhlbNgIgbmcSSyU5d+lHGykFtzg/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e8c8ff-15fc-47e0-6cac-08db1e0c6ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 06:31:34.9839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqj4Hb6+7gLeBFVmRRPBiUVE2U/51yoehuCanfbOOTq/3SSvFfY31KOCyhQ8b4fm+7fJN0VnTH+HW9YsfMe7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
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

I have one additional suggestion, the amdgpu_gfx_ras_sw_init is declared tw=
ice in amdgpu_gfx.h file, it can be removed one in this patch.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 6, 2023 10:32 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 03/11] drm/amdgpu: Init gfx ras block when ras is support=
ed
>=20
> Initialize gfx ras block only when gfx ip block supports ras features.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 3bf697a80cf2..d7d4847e2644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1409,9 +1409,12 @@ static int gfx_v11_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (amdgpu_gfx_ras_sw_init(adev)) {
> -		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
> -		return -EINVAL;
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
> +		r =3D amdgpu_gfx_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize gfx ras
> block!\n");
> +			return r;
> +		}
>  	}
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ae09fc1cfe6b..c9657e89d40e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2177,9 +2177,12 @@ static int gfx_v9_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	if (amdgpu_gfx_ras_sw_init(adev)) {
> -		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
> -		return -EINVAL;
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
> +		r =3D amdgpu_gfx_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize gfx ras
> block!\n");
> +			return r;
> +		}
>  	}
>=20
>  	return 0;
> --
> 2.17.1


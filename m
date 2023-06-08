Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F869C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 03:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7B310E582;
	Thu,  8 Jun 2023 03:15:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F01110E582
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 03:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7FrWls6cUFRC6dOfNtfu3cNsToOcau2RHphdvwWxi40meiqC3vcVRn1Lvq+WNF3UnydebrdryfMCcmNiKZwYLzd9dg3454gZEhcouBz/7AizaHQ3INtJT40RA1DCe0r3P4CIqdFlQNvN8D4QPVVwUzTSng8pvYPhSRjFA3gIdz86GZ8OY9ENPPeuAGvwp7tMXwO0Lo19NfeByx2TWLu3Qgk0hMAe+dJxUqmw3nnYhw467LEDOESVp9qQUwtoojsQ6bVyNmcvRJ3GeKyCe9M/FA6z7Cb1+Z/ROqNv0DhfgG0iIKGcgu1in1jhzMT1sps1gOp/P/TbETo7bP3yH3Ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNQGGup1QQT0m47Pk5qgdTyGQsqXaWNKLBa8jS9w6Bs=;
 b=RXxH1v3PqdOxiGhMm5/96tCopNcvESl1txFLMj6oRCKYQnkbMu65X5UyjobnwcZrVV1fT2J+xuGPKkebbEwnegZ/MIiMSNZTEHsrGy3kYu4H3l4o2V6sfEZf/F1QdYcshbPFLU0e6YaeJgvIIvcwHsfhssJx3cRiR457LlAmIMEsL0bA8OwilDBhznJZQ9hJGcGz5OBIDVx1Pv4hVi1hAphyShgqBDJPO4gQ7UHOBlQCsNFYrCRltBRZfvIAZ0FjIvnDzWCCOCPQ4xjP3j39kzSKbRz1z+ibSQwZ4b56ckImGxyfqiuMb/a0QFQJNbPqyuV3E5GO5RmJDXi3CYTWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNQGGup1QQT0m47Pk5qgdTyGQsqXaWNKLBa8jS9w6Bs=;
 b=GwyrY8F3j/+vXK+MI0U74op+UhyTsdTFIbN2Z/kxEoUydGlYxvS4/Q7Vje06/EWch8Cu3dXt5WjgNnWqZD409owgJpiNwYGKUrFzQIFCm4Cl439XaUd/STueQIJV5MdHpm5CRcj7l6zIGQud9PV/UqO435e6QfT1wpKYrQtYoOE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 03:15:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%4]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 03:15:36 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: Tighten permissions on VBIOS flashing
 attributes
Thread-Topic: [PATCH 2/2] drm/amd: Tighten permissions on VBIOS flashing
 attributes
Thread-Index: AQHZmXmmjMzMk4YwuUmGgUhjSsOpY6+AO98A
Date: Thu, 8 Jun 2023 03:15:36 +0000
Message-ID: <MN0PR12MB6101B5D8FB56DB6A13C6319DE250A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230607065259.48516-1-mario.limonciello@amd.com>
 <20230607065259.48516-2-mario.limonciello@amd.com>
In-Reply-To: <20230607065259.48516-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0892eb68-21c2-4903-9973-8ffbf48e251c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-08T03:15:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5342:EE_
x-ms-office365-filtering-correlation-id: 928e6b18-930f-4b57-71a9-08db67cea0c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tG9abQIr77GIIa+KWqNy522Yq72M0vcV+boDsaT3aqIhmyrDQ8u0SfSqkINvX/PqETBDS9UjsXAeCDodLwPfa9B9VWLMbKdkVAO06y8zRQP2ytBko2RDxF2gmD6UVekhS5DdMDp0w3mNhErKKm+274lB3mBl1Qr62+66pjquFGsW7oBknvsML0NdEMVKMAnrLfWVm7+VPfJnvjXGyXki1c8RvaggX8wRyBFZUprHmRuVG96lhoQrpgvVTIjVrOa9zpMX7NW5yXpbglQ2+dde6fAVIptDNKOnBOmaiXmdDTw2OeFauZABxpePYMSkGBE5SRi89SFs4OzcycVmIy0gJnQRNzaUuSlGwHWDOV+Qd3BOanM+v7IvuX6wmuTdoTo+ALRoi3leJYerU7GejNyafoyxZrd9KcV3XcC0fBkbLBtFPkfTdtlOkxV6UJG/+Rs9lI8z5NIY9QrM3upBB6O5d6PgsaX1Z9cwsjL8ounPACLcYRMW0AxtYcjGi1fSzhKtP/w9nBJ6SnpBuM6eto5qskvZJeqkek+IgpbUL4P7NmnKl+h8bL8lutk/7bmv4CG8WhnwA3zlF8fEeOxKS5enwKRDZZFTq0390lSEnkqFA5oe3MuQMMXriuwt8DOnWc1n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(26005)(55016003)(186003)(52536014)(6506007)(41300700001)(5660300002)(53546011)(9686003)(33656002)(71200400001)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(8676002)(8936002)(83380400001)(478600001)(86362001)(2906002)(38070700005)(6916009)(122000001)(7696005)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MQ6mWyOzjFqQYICnC/g28u9xwbvN2j8v8RCLenGIUcHzgG5ia9F7QLgd0wR9?=
 =?us-ascii?Q?RaXKmF6nnVA0ZFO4KixBnTTyUrI9ReXKhbucz4EDmo+POkuNVdQEZ3fRQ8fA?=
 =?us-ascii?Q?Y1+GRVEguSTEIaprMn7Fw0XFz6Tu7/GiqYLrO8GbHkP7DSZPg7d2qIx2VxDC?=
 =?us-ascii?Q?Am8nQPMYOCm84D6wKnt+kLydYkXGKl52N6AcR7hFwCAyBADiuOeSKORsTrvv?=
 =?us-ascii?Q?eXSuXjxJcgg5V38mMXvCIaYxP0iGvZGn4mCwIUzhrLxzdNZyT8d7rBehbgWa?=
 =?us-ascii?Q?HTfTgAVV4ms0C9Sn3hnE5IR5xi70MDer7aUKbmB3GDbUzV8guoHaEoXdoS/p?=
 =?us-ascii?Q?NEq9+unUAsDYl7r1Xl5s0TSEBtP57EgmMWyBi1goHLX/LBtWubL9JpnAxJjK?=
 =?us-ascii?Q?bvCsJGHw+aSILXQXdQ2xulFAo1FoUpTWwZxBih+6OdMcUT/UdE19nE7IHClr?=
 =?us-ascii?Q?ndGchpOmV9zqqHWJyGGhu700nRiW1ZAVkRPOoePws4+xf1Y7w+US81ySnsYB?=
 =?us-ascii?Q?9800obnH0LfRSd9WAmG7QjxQVFhOKTcFQazp9dKPUCb5QbaUBF2r2as87RKr?=
 =?us-ascii?Q?ljT9i6akSYMD5Cj3DUA/vWshi9FxqpXLVsT83nW/lLzjLlsl52Y2VL5xBrRM?=
 =?us-ascii?Q?FmXeE5rrb1YrgPtQDI5BkqMED+TLx38WAYH5Ay6pKVdWSFFUrO/Nb3tutaGv?=
 =?us-ascii?Q?X7QGVEIg+Rbku5oFfV4dvkBzgQ/YCwDlLO7XWYsEwlRe+9Ztts+Gkodgv+Z/?=
 =?us-ascii?Q?aDKzivl3ssHzRw5ns5Et3w/p/xtWwyX7y1sywImIHMRLT7KLYvZGfmMNbFJd?=
 =?us-ascii?Q?1Wg7Zf4+SalGo6V80gmvs43gX3ku/JFNO9OShyOssD1Zb9qAFAKGEVS8FM/V?=
 =?us-ascii?Q?sHpbKaxk36B2/BrwPrH626j6qgqR5yg/X39PJeT/3iXAaQB0uQXlENSwzTNf?=
 =?us-ascii?Q?l5TMKNkYuJBQQbcvp4ae+mrh+x0L3+/jS+ft8MzMEFmE2kW7JRYz9YYtcbJj?=
 =?us-ascii?Q?MMHIW6x+qMlMFt5V6GJN7YZt1438JfYC2wfFQn8svQM9V6KZ7Es1cL2PEipF?=
 =?us-ascii?Q?t9WibbiaDJVlJd7rWAc7LygvFZaSaC8lwJoWAa9Ok/VyY9G2JuLo3SXyoq9S?=
 =?us-ascii?Q?qoLiTBTxpfzO8WwRQPiBSGODVWX4wLymOpOKdQZOwKRQkhrnHi/HB4aDBWvo?=
 =?us-ascii?Q?S48isUQYzVuU1EPKqknKpDczPxKhpSmq4X6cb5NUHUlcHsJN5v9KDQOoJATN?=
 =?us-ascii?Q?98HWFQlO135IYliTzuqX5H8nWpGnd/36cq9CzgN1b3+oILzSZZ8lFNFLzC2/?=
 =?us-ascii?Q?q5WHk4JXROyh0VQXrzq4Zl2kC+wnXDaEXn7IEfP4hp+0zq4Lr4pntQ9S9adf?=
 =?us-ascii?Q?lgK+j4A4Yvh+JDmRP+jRMHN70kmW/La06hXnyUiy/IBMpB+i2yTQQeFk48si?=
 =?us-ascii?Q?FrcR7k03jEDEy4DfMYlJvyOmyt4yVbN9LSnG/Mand3TnMRfTNero2QwEiOkA?=
 =?us-ascii?Q?Dj/85WSShnTtPO2UGn9nYJhRpKJUvnODpe+QT8UI7mF+oucafqbKlqiks1Ys?=
 =?us-ascii?Q?sdkST6rnTse4JUaH4HU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928e6b18-930f-4b57-71a9-08db67cea0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 03:15:36.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQoI8j0qfxo+CMeSn6CrgGx6Dyp00mi0q4eosRDbsfl/Oea+Me7AYTQeDVwMzs0IfCNEA0m/GMZE+2sLD0izeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
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
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, June 7, 2023 1:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] drm/amd: Tighten permissions on VBIOS flashing
> attributes
>
> Non-root users shouldn't be able to try to trigger a VBIOS flash
> or query the flashing status.  This should be reserved for users with the
> appropriate permissions.
>
> Fixes: 8424f2ccb3c0 ("drm/amdgpu/psp: Add vbflash sysfs interface
> support")
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 8c60db176119..488d5b7ab97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3671,13 +3671,13 @@ static ssize_t
> amdgpu_psp_vbflash_status(struct device *dev,
>  }
>
>  static const struct bin_attribute psp_vbflash_bin_attr =3D {
> -     .attr =3D {.name =3D "psp_vbflash", .mode =3D 0664},
> +     .attr =3D {.name =3D "psp_vbflash", .mode =3D 0220},

I noticed a mistake with this, it should be 0660.

If no other feedback I'll correct it when committing.

>       .size =3D 0,
>       .write =3D amdgpu_psp_vbflash_write,
>       .read =3D amdgpu_psp_vbflash_read,
>  };
>
> -static DEVICE_ATTR(psp_vbflash_status, 0444, amdgpu_psp_vbflash_status,
> NULL);
> +static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status,
> NULL);
>
>  int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
>  {
> --
> 2.34.1


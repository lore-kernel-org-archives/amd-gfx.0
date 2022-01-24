Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CF9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 06:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D36F10E265;
	Mon, 24 Jan 2022 06:15:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519C310E265
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 06:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kw+QAfkfSMxR2No7ZsgnkU6t3EiUB4DS1FOyOptIiwgyDYXJpY24jdHtKFNyiAqDzyTmZ+4dP/hBPHqe/+m4e2pxwsTbZ8p1LwMDI65d7043r9oQC+HErm82HqPWXj/E4F9qQRkDOH+7Ra1D9K8TJNW6FxjoR7iW88X107jj8MFQ4khwKDB8T0k825dz3q0ewmnsYz6+pxVDPeZoNDUn1pr8tXebJiIVMEk2N3PBqnPCM2wu8Z3SIb6UjBpan0N6XWvaD8Ab8pvJ2qRKWOeoqF7sqJO+euoszwSTD/J9RCLOOZN43c5MKCxOmc3VBRsKrkHAWb49GkwF9J+hWN+iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66r54ZFdMekFcPML6rA6MgTZFMs68NVJUCH2BH8Izd0=;
 b=OkH6MDakLPGr9sz6tOqimQBw4aoRN5m/qr0Gw2VdQWF0fe6letX9696GZLxnzR9KRt7fPz5DIq+JPRSDdBp/AnlS/XU+JOjWwYITMJ81ubLcciH4A5sk0z/n+clkW3d2uD+RrANii2+/9kkYbfP1uyk7MaXu5WpJMNu+dg4vNFdG72KWBSnF/qOY8JjioZ1Bs7me6ILD0raUz+EA9Hb6hwgySz/4RF3KRGd7EwhhCmJeXLXa48ITU7mpWIKdg928OCj22gnUEu4toJHx6xqwqcZHQdBCuD1cKtDMm/A/JLH+f24pa7EdvUmE2MMoIZycRhcPme6s/zViyy40/NsRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66r54ZFdMekFcPML6rA6MgTZFMs68NVJUCH2BH8Izd0=;
 b=4p7g+4YNSVLMoJL80Xd6YVMQM6AEQjNlX4N27x6SqslpQznIyx69F5Dr89tZ0aVixIFXMvzt8hlDI5wB3umy/390hxs6b8WQ+zlDI7F+A+fbfQgeLMkZ6aLC6o31FAvWlpHKcGqNeemJwS73o+u36Epjl/C/sUKyOVLW+M/kjZc=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 06:14:53 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b848:ab90:3d46:2e7e]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::b848:ab90:3d46:2e7e%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 06:14:53 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd/display: convert to DCE IP version checking
Thread-Topic: [PATCH 3/3] drm/amd/display: convert to DCE IP version checking
Thread-Index: AQHYENF/G7OxkGZlq0CmlecIjsM2mKxxr1TQ
Date: Mon, 24 Jan 2022 06:14:53 +0000
Message-ID: <BL1PR12MB523705922F1607BD85C393C8F05E9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
 <20220124032042.1974371-3-xiaohu.huang@amd.com>
In-Reply-To: <20220124032042.1974371-3-xiaohu.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T06:06:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5264b5a3-94dd-4940-a570-d57e7c8abc6e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-24T06:14:49Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 885dedfe-4b49-4eff-933a-d7f1d56d6e4c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33ee6a97-f2be-4794-0fba-08d9df00d644
x-ms-traffictypediagnostic: BYAPR12MB3637:EE_
x-microsoft-antispam-prvs: <BYAPR12MB36374B7B22B1595757EA7145F05E9@BYAPR12MB3637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wj81vD2Z77Jmb8jUhfnL6AGlOahuaZAr//XoOoOsKhU7ithYsg5DX3bxV98rKTvuN6su4gGtqBHOOjOeXt5uxjxhi0ejaeJUPOc6opLinlYVt9Qm1Br+JLatgTa5+y3YOlPCHp5erz90sOts3gPRV5K/NNt/VPbifUVdL0W2E6tpJJxEWwDktEhG/ua52eS4/6lbiUKpQ6jfX0Rc4Ih2wS962BGt/+jZUWvQAOh1G3pc4aPoAbZdN+CT6tt5ogYfqf3qekiYqsOdc/yzbKGAWFTR80Q0OxcuI6fTLf1YVVuCJcGP9VaO+7wWBTxaDYMWY4BwTdkTAO7vSiCaTewYBvIVsPvGMdb0XpO9/TH8dooE8McaL5JoqRfLib20vzKHKZWXMPTgLMkZ+My9GsZAobJvZ9z3Q63tiMqtHQNW5C2AcL62L6NdthkoK7x7IFFNbQLfUEkO+DAB5u/DHRM4fC9LwfEHq9+RMysu3ePky71NoofAsWuV0VnXCxC+m2MqBNEbtmppladc1sFlx4Y4QrZawWdkqZx4kRGBV8q+vVTrjV6O+Afp3M6Eaxf2oIKMXdJxVIqItLEecEcTXWnMKZdqzL0kzPAL2Y4DvUokX+iKKQCdFHuMZ//5uc5pnUnM8txXrgeEE657NhuRwsojG8C1aCIbDU541N3acDHm1SQzuKfz0xZgkzgGMwHTY1ux1VTRxk0fvJHYvB+rYiygbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(508600001)(5660300002)(316002)(52536014)(71200400001)(38100700002)(122000001)(110136005)(54906003)(9686003)(86362001)(66946007)(2906002)(4326008)(76116006)(7696005)(8936002)(66476007)(66556008)(64756008)(66446008)(186003)(53546011)(6506007)(83380400001)(38070700005)(26005)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?M2tXU0NpclRKTHdUUm5rd3h1cVFGSml6TFNKejRRSFJJczY4c2wrTWlt?=
 =?iso-2022-jp?B?cHhCQVM4VVhMZjI5OHRXOTBna1MwdUFUZzRuNjZMUjNQQ1o4RjMvaDNY?=
 =?iso-2022-jp?B?SzI0UDJTcHI2VHVuRCtyejFFWnl1ZVNhblhBS3h0SjVFWVRRVXlBS0Z3?=
 =?iso-2022-jp?B?dTl3RlBGOWczRDVTQjFna1BIcXRrWGc1WlRLbVh4Q3dCNFJvZmZDZ0tK?=
 =?iso-2022-jp?B?Q1Q3TEF3dzNWTHJpKzF2bFpYYW5INzRkNU96T2JwU2VOWnFlUEtGbmNL?=
 =?iso-2022-jp?B?N3kxcFU5YXQyeVNtb3B2akN3bzV4b3EwSCtvTWpUa1R1cEZIN2VobHo2?=
 =?iso-2022-jp?B?cVZjdVFaTW1yaXEzNFBkMlZiSGlRWVVXMTcxQ3NwT2piQUtDS1NQdklB?=
 =?iso-2022-jp?B?MHFFSHM5NjlablhJTXpJNittRmJnNFdPQXBlQWZJVUNDNTltS1lhZ3VG?=
 =?iso-2022-jp?B?MHpWK2RHQjFiKzdhWWJSQmR5YzNwcXloWHRJbnJpT2dsaEVRSE5nZkFa?=
 =?iso-2022-jp?B?WVo5UmJMRmRnREpuNm1yVGNoYjBkVXhGSGpCR3V3aE1HRlZmaG4wZDBB?=
 =?iso-2022-jp?B?SENIOWpTSk00VXVXNlF6ZHUrWEZoaXd5dzNQbURaWlZmRDRmUVpHV0pi?=
 =?iso-2022-jp?B?ZGxBQTVLNXJqZ0syYXpLTTEyaG1ycU92YzQ4RE9Gblg5UFRBa1V3SFpE?=
 =?iso-2022-jp?B?Zk9hMlBPZ25zQ3NUT0hUeVNlSysxelZBeGp2KzNpV09JY1A3MFNBaDdy?=
 =?iso-2022-jp?B?WlFlRlhwSXdOZ2w3NkpYZXE1OUhQUnhFb0N1d3F3SHhIYVRHNDZhanoz?=
 =?iso-2022-jp?B?R0d1NVNyMnVoanFHZUE2cE5lVkVDTzBvalZNSStES3VDZzdGL2lOemNw?=
 =?iso-2022-jp?B?dDFyY3FrQ3d5aHQza0FyMWF2aDhOMjZnMEZqRzZKMHlvcFVzNC84bVA3?=
 =?iso-2022-jp?B?L1lFNVdsc3ZzaUxXYlZRUlFRSUwxR1cvTDNJbE0rVG1WRGlCMEVydTd5?=
 =?iso-2022-jp?B?Y090RkNBSHRZTzhLck02akx3SWpNb0JxbUxGQVFZSkVZSDdmWjV0a05p?=
 =?iso-2022-jp?B?YlNwR01kLyt3Z3YzbWhPV1BhNERXZVZlT0xkdWhjT1lXcC85blY2amVX?=
 =?iso-2022-jp?B?RGhPdmFhZlJuYXA0VGlRQ0lmd3ZKNThvc0Q2bkNiUU5MNzdHWTBTWlhp?=
 =?iso-2022-jp?B?R2E4VThFVm9xd3RWSlg3L21GeE02OWU4djIxdUFHTXM4ZEp2UnpKZ2sv?=
 =?iso-2022-jp?B?dEs3eUQvY3Y3dGFWODltaVdZSTk2dUU0TXR4YnErTHlsTDNpOFFPRUto?=
 =?iso-2022-jp?B?aEFOL3FUdDEzT0VGVHUrZjJXQWtvSm1HRDYrRGpZN24rZ2kyNEVHVUgx?=
 =?iso-2022-jp?B?bWpQM3pNenVubk40bVo3M3RjUlpWU0ZTaTRZOHBhRXJIRjRGc0tVSzBD?=
 =?iso-2022-jp?B?YjgvMUhMRGhRdUk0S0d2RjNkcTNwdjdXM3h4UkZ1SEZMWHNWT0ptZ0Mw?=
 =?iso-2022-jp?B?Y01NWHoxeE1xWnJHWWtTMmc1ZDI1ZytYMWxOdmFPYXBRMU9mTVB4RWlO?=
 =?iso-2022-jp?B?UXVzS1hsTUpOekZ2dGttaWpOaHhDWFlDMGJ5SUc0dXFoMHpDd255cEJS?=
 =?iso-2022-jp?B?KzBodko5Q1NEZHkvcEZoRjU2NjdXYmJsZWNHVExxRVRZSDl2TnV4T2lH?=
 =?iso-2022-jp?B?c041N2dFSTY4M25mT0JIajc2d0Q0bE0wSWFGdDJFMFQ5aWRidDM4SDJP?=
 =?iso-2022-jp?B?QkppQlMzTUw1UUlMYUJuUldBOU5uV0RwdkpVMTE4bDR0VHZ2ZXVTWmZz?=
 =?iso-2022-jp?B?T1gvRlpiZWtjdFFISnlVVUd4ZlRMSWkwcHF4MVFDM2VnM2hYV1NKbFEv?=
 =?iso-2022-jp?B?TjJJYzkxODYrK2pGT1pxUVVvUFB3ckxJeFNiZWFqQlF5Sng0QmF3eDdT?=
 =?iso-2022-jp?B?anZ6MExmaDRIYk1DR2h5QWlVcm5EQ2l0RjhYTU1oR1h2bUp6QVNvcW5o?=
 =?iso-2022-jp?B?M3RSMGJOZ3FoM3NVNHdKcDlYYXNlcVVoM05PMVNHeTNZdVFwVFdOUHBk?=
 =?iso-2022-jp?B?YTlHY1VUZ0poYlNIWitOR09GM0dvcWpXZjZTUXFtaDE0RTFiMi9kcm8x?=
 =?iso-2022-jp?B?S0hsM0ZaNXh5c2pPUnF0OUo5SVptcUVRUkhXcUIwL25TaC9FL0JoeS9m?=
 =?iso-2022-jp?B?aXZOc21XaVMxLzdYSHFEUllyYTZzSXYxakxPeGVzMHJrZzJlb2FxMER3?=
 =?iso-2022-jp?B?SW4yZ0JURENOOGYxWU1KQVlpQ2toUC9lQT0=?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB523705922F1607BD85C393C8F05E9BL1PR12MB5237namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee6a97-f2be-4794-0fba-08d9df00d644
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 06:14:53.5227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8flDCOKefKxDMTpXYxXF2RnqmwOqHwKb7WaLgpuUVoUbXzICokdp7dfO2bu7/7Tf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB523705922F1607BD85C393C8F05E9BL1PR12MB5237namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


Tim=1B$B!$=1B(B

Please remove TAB in the beginning of an empty line and the SPACE in the en=
d of a line.

With this fixed, series is:
Reviewed-by: Aaron Liu aaron.liu@amd.com<mailto:aaron.liu@amd.com>



--

Best Regards

Aaron Liu



> -----Original Message-----

> From: Huang, Tim <Tim.Huang@amd.com>

> Sent: Monday, January 24, 2022 11:21 AM

> To: amd-gfx@lists.freedesktop.org

> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray

> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Huang, Tim

> <Tim.Huang@amd.com>

> Subject: [PATCH 3/3] drm/amd/display: convert to DCE IP version checking

>

> Use IP versions rather than asic_type to differentiate IP version specifi=
c

> features.

>

> Signed-off-by: Tim Huang <xiaohu.huang@amd.com<mailto:xiaohu.huang@amd.co=
m>>

> ---

>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------

>  1 file changed, 5 insertions(+), 7 deletions(-)

>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

> index 87299e62fe12..c967e1e344e4 100644

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

> @@ -1119,19 +1119,17 @@ static int dm_dmub_hw_init(struct

> amdgpu_device *adev)

>          for (i =3D 0; i < fb_info->num_fb; ++i)

>                      hw_params.fb[i] =3D &fb_info->fb[i];

>

> -        switch (adev->asic_type) {

> -        case CHIP_YELLOW_CARP:

> -                    if (dc->ctx->asic_id.hw_internal_rev !=3D YELLOW_CAR=
P_A0) {

> -                                hw_params.dpia_supported =3D true;

> +       switch (adev->ip_versions[DCE_HWIP][0]) {

> +       case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B=
0 */

> +                   hw_params.dpia_supported =3D true;

>  #if defined(CONFIG_DRM_AMD_DC_DCN)

> -                                hw_params.disable_dpia =3D dc-

> >debug.dpia_debug.bits.disable_dpia;

> +                   hw_params.disable_dpia =3D dc-

> >debug.dpia_debug.bits.disable_dpia;

>  #endif

> -                    }

>                      break;

>          default:

>                      break;

>          }

> -

> +

>          status =3D dmub_srv_hw_init(dmub_srv, &hw_params);

>          if (status !=3D DMUB_STATUS_OK) {

>                      DRM_ERROR("Error initializing DMUB HW: %d\n", status=
);

> --

> 2.25.1



--_000_BL1PR12MB523705922F1607BD85C393C8F05E9BL1PR12MB5237namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@Microsoft YaHei";}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 113.7pt 1.0in 113.7pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Tim<span lang=3D"ZH-CN" style=3D"font-family:&quo=
t;Microsoft YaHei&quot;,sans-serif;mso-fareast-language:ZH-CN">=1B$B!$=1B(B=
</span><o:p></o:p></p>
<p class=3D"MsoPlainText">Please remove TAB in the beginning of an empty li=
ne and the SPACE in the end of a line.
<o:p></o:p></p>
<p class=3D"MsoPlainText">With this fixed, series is:<span style=3D"font-fa=
mily:DengXian"><br>
</span>Reviewed-by: Aaron Liu <a href=3D"mailto:aaron.liu@amd.com">aaron.li=
u@amd.com</a><o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">Best Regards<o:p></o:p></p>
<p class=3D"MsoPlainText">Aaron Liu<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; -----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; From: Huang, Tim &lt;Tim.Huang@amd.com&gt;<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Sent: Monday, January 24, 2022 11:21 AM<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; To: amd-gfx@lists.freedesktop.org<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher=
@amd.com&gt;; Huang, Ray<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &lt;Ray.Huang@amd.com&gt;; Liu, Aaron &lt;Aa=
ron.Liu@amd.com&gt;; Huang, Tim<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &lt;Tim.Huang@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Subject: [PATCH 3/3] drm/amd/display: conver=
t to DCE IP version checking<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Use IP versions rather than asic_type to dif=
ferentiate IP version specific<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; features.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Tim Huang &lt;<a href=3D"mail=
to:xiaohu.huang@amd.com"><span style=3D"color:windowtext;text-decoration:no=
ne">xiaohu.huang@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c | 12 +++++-------<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;1 file changed, 5 insertions(+), 7 del=
etions(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/display/amd=
gpu_dm/amdgpu_dm.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; index 87299e62fe12..c967e1e344e4 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -1119,19 +1119,17 @@ static int dm_dmub_h=
w_init(struct<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; for (i =3D 0; i &lt; fb_info-&gt;num_fb; ++i)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; hw_params.fb[i] =3D &amp;fb_info-&gt;fb[i];<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
switch (adev-&gt;asic_type) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case CHIP_YELLOW_CARP:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(dc-&gt;ctx-&gt;asic_id.hw_internal_rev !=3D YELLOW_CARP_A0) {<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_par=
ams.dpia_supported =3D true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch=
 (adev-&gt;ip_versions[DCE_HWIP][0]) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I=
P_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_params=
.dpia_supported =3D true;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_par=
ams.disable_dpia =3D dc-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;debug.dpia_debug.bits.disable_dpia;<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_params=
.disable_dpia =3D dc-<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &gt;debug.dpia_debug.bits.disable_dpia;<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;#endif<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; default:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; status =3D dmub_srv_hw_init(dmub_srv, &amp;hw_params);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (status !=3D DMUB_STATUS_OK) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; DRM_ERROR(&quot;Error initializing DMUB HW: %d\n&quot;, status);<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; --<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 2.25.1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BL1PR12MB523705922F1607BD85C393C8F05E9BL1PR12MB5237namp_--

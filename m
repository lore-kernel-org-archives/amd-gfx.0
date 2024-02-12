Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792EFC4829B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 15:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD52910EBE2;
	Mon, 12 Feb 2024 15:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BK9f5BUy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E836E10EACA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 15:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVEHNAVWafmEzOXYojMXvgyCBqlXNRk4kQdv8jiZP0+66bQy7oynJ+L4a9YVHnUwc7C27ocLdV80IH0MsNZt+2E5V3lBY3qSHpbeNr8Kd8epI931Za5x2dvXu0U85xbki04yMsl4SrWiU8rJE5k22vcj551A2oBUJnPd1Oavdnpd6DS8kc7O6rSOrxf6XtMZG7kj+pEd/Skf/rIjrbFXRc21bq0DIExFsy3/0Mo4KzhyxBYm4MmKjffxl4rozPs+gQ/u62o0ha+O5wpkeDYHM1xxpnhkvr4BROJbdhq5uORmL0pZjlchOkWkUpc0VVezkLVsQ8nZw3OabieFMayh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW0ctT5toVTgRb9Os4I/B7JVErYX6eYHY0+topl++GY=;
 b=aamS4WEjwGwKghw7FyGkA6OSAKWrCC0c5S5ABckt+nbqbd4ef0askN8QYwIDMaC6YWpcsz+bV3r5uAq/ylTvJxWQQlraTrfq/CPxqBt5GLB6hac/Xd8t0mV+H1O30yfiQxizxMzoCJ8Qp9egdIEf5yo6RB5wwbFKkvWD8pCOX3lMifhz3agQbFK+zN3CawF1ZLD3MHc339lyJV9pcEsyjghXu/V4wX3xWRS2DJG8v0nNL10S7Ncekj1BJ0TWxnbWTAbwZxfaqVd8qQboo/iJy3gqblu4erVOyfBf+xpxrnW/f3HClP+ghcg1Mkt0gV3Ar+tGAQeO6f9VrabazN4xUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW0ctT5toVTgRb9Os4I/B7JVErYX6eYHY0+topl++GY=;
 b=BK9f5BUyJ81/vmO7ePN0tlAa9oF3yuXbfc3fOL5YrFo3f4QqiMZUMsHz/GCFeV9taZDy/6nEGXNGBivbDhxl2Xs14DmLPL3/tVIdW7h2uDgQG1Fe9k/3a8g52tmGsAWGuXR8SLi7WxcNrRi1R3cu87/9do0kyeNZdlHR/dADCMM=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 15:23:07 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 15:23:07 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix possible NULL dereference on device
 remove/driver unload
Thread-Topic: [PATCH] drm/amd/display: Fix possible NULL dereference on device
 remove/driver unload
Thread-Index: AQHaWYHpbnnH6Z0mCE6lwVmyk1lfF7EG2rLA
Date: Mon, 12 Feb 2024 15:23:07 +0000
Message-ID: <CY8PR12MB819348D906C94DAABDE2A0E989482@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
 <20240207045501.3344729-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240207045501.3344729-2-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=18cb43e2-bf44-43d9-948c-514e4e31dbb8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-12T15:19:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA1PR12MB6555:EE_
x-ms-office365-filtering-correlation-id: 3019034d-86ff-47ef-a6fa-08dc2bde83b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i60SCVY/zactyRNEfhgcDm+NI6nCt4Afe05V0tc1m6/2NyGSB1wz/IVfZEaHvBZgD+mlPXKla+D/RuOIhFp6h0ZAp0rnvDbElnkDj3ZzWShQcu5feSID+l980GrIKawD1UGgK4sscfHsmQYiH7mu7Cw+ePOVnnzxcjkkuz+fNW68uV9WGH7BP4sHk40WDRwIsUElN/Z4B3OPHIkIWS13L7wKnU66tu8qL2Nuaq+Wcdu7cKUH3AZM10PlYUzS6LWdJG8wdhg4LKOMxtBfh+Rp+ys3HqAuaHGZymHJi/ZNoyVJH4iRkbvIk64NE2++r2v0r0rStlXcsJODO0COMU3SpIedE/iIZBR9Kb3bvfXRGAtnrXqj+6Vt6Rb7d7lX0v5DjJ8h/rWQ8L97NEGZKLE+iRmKsIRkECJtR0qLhxxfhyFBx8jSzEu42bgNB4BI9CZ/WeMptkGUE+OVbhTwgzfWeujhkNLiN+FWyexY2J2bbhzTScXcbgU0RzhVcJz8oVAxa77dqsgIiAfVI8M9DSlrKoyFYcjkGN9VMilvsk92ktjuxUviJrvUJwqsokJN1hkS+ZXi1+mOeUlehd8WD8gRKTq0T3VKdoSQYLVdKec8v9YYOFqBRabsbYCVgyRqCSaB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(33656002)(55016003)(76116006)(5660300002)(64756008)(52536014)(66446008)(66946007)(66556008)(8676002)(8936002)(66476007)(4326008)(478600001)(7696005)(53546011)(6506007)(2906002)(26005)(41300700001)(83380400001)(122000001)(38100700002)(6636002)(316002)(9686003)(38070700009)(71200400001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qgq5xfS098X+q3joLNfoZKB85lmMRnsGQ9gfRPZrB9iFVwuRrIqFREzEI8sh?=
 =?us-ascii?Q?lnNC6sIKNSoMyURzXvJhvhy3dHAvnZWdXfL+n6e9EJH5b+JQJpm3Nvns9q+o?=
 =?us-ascii?Q?iJ/kQVlk/FaauNm/ncYLpNEAGpVY27FrNyn1RQD3Yohf+FOxBEg7L9mMdAdT?=
 =?us-ascii?Q?mLc0IkAvgKuB7OzM2aY8R1Rslaj8YYS88/K9zUAwSjzteV46XoWFs6wy9f9D?=
 =?us-ascii?Q?EoGBbz4yqA8xprUNjRLLXrRVRqwYvPTX3YqEkz/rHqXtpLy8mIGUPkoZnioP?=
 =?us-ascii?Q?H9js2kQFoPitHLdqN70n/GeE29HjGVfgZQ28NzqppRmQbzwuyZG30QR4ecPY?=
 =?us-ascii?Q?MGtLt6IJYwiUyoPX5vpfyxu/KJXdn38refZhN2h7IO5skNmJY7OWpC2BBsKw?=
 =?us-ascii?Q?0IjvzAqMamHSv6LArBl6LZJClwTGFSvwQB61XZ59Rs2JbE8BZoo6Bw1OUwM5?=
 =?us-ascii?Q?OVuVsmTxtCPbUkrxo9MqCyQroPoZPSOb1K7PTacUw6s/5LgQvHJYmVIYcrA9?=
 =?us-ascii?Q?TgYA0xg1WldGQt38oCBMFXVAYDLQcZIGGh9LhEHCgnFzSe/gHQHupCKtQhHv?=
 =?us-ascii?Q?gfSIl5TXZiUhq32KcbXX73LxDGGddqFLiuGXD39IIzgNGPaKJj1JcBj81tR6?=
 =?us-ascii?Q?uqZ7Hx8ynCQQZDG3a5ITNigKwWkoxz0Yr7hjchtN0nYvv+77Drv4TPifJDXv?=
 =?us-ascii?Q?B6SffL9cMZnw6J7Svu4oLoT2ijAttVaBw2xt9RlaxhG+AhWMUiBDgYFiZt5c?=
 =?us-ascii?Q?/PYZBAAoYxf5jm7PULWZyHkSRG1116uElgq96Z8Fqcj94dQV/aYC8iiJK6+m?=
 =?us-ascii?Q?/oI7pKZ58o94GLko8lJ4b8GHywYiJlJkNLJ5RD1qPFOQXg3adEniAG7JUmx1?=
 =?us-ascii?Q?f8Ekt5rD4NuiZs2KO+IW3BdQ/HUXRKj4utK5QnjyBasvub5eGJJBDv3S5aoP?=
 =?us-ascii?Q?4iKwXvWlFLvHXkSGgexRdgg5tyrfrlLQti5l5nRlBOpTheTIb9p4pUc3XKl0?=
 =?us-ascii?Q?j1zhmyjPg0FT5ePS4t+EtxWaqzn6px7dx9h9U26Ula8UuMax871699wamA8M?=
 =?us-ascii?Q?zqgQp4VmIDI4LHXy5WlnnVWSoZI+HXEJjoZZAjmS5HPbBseQ04E4t20Qtjew?=
 =?us-ascii?Q?GQ3S5+TJm5YIlWxv6oHtdc98nJVmpWiM1htMI5K/L8ZqvrxNib9l654SPxvw?=
 =?us-ascii?Q?oOFSaVJj5QmzHlw8Zf4KQXeGFVxWIYmBc2pEV8gahA0xQuSIkLPIFIoq/wKM?=
 =?us-ascii?Q?U+jCwWPxunvR4eYOW/tsMkGvdc9cBClBl8JtFXV9tjfBVmeWACD9eVjiOA3y?=
 =?us-ascii?Q?Mfj7jVX0tB8mbSu8P9ATVrIWf/En5Fx4Ayj6K3GpFJzQmkDuff6xcOfiZDa6?=
 =?us-ascii?Q?+HwPwjbvRRqVVQFBSZJmK9dg0V2YlaqCmxgV+nXaIG2BT9cnE/378ihBhnhH?=
 =?us-ascii?Q?z5HJTc2bD8JoWBvQxQTD6LB+1h806WvduKwt7sKFiVpOMmfhw+WRY9QYAScs?=
 =?us-ascii?Q?XZmV/NqxFG6KFpLngma5+iL+67kHs6c/ImsNGiZ9zXp7efyu6uqh/1iAxlIf?=
 =?us-ascii?Q?OpwQkQdljClWJQ/s58o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019034d-86ff-47ef-a6fa-08dc2bde83b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 15:23:07.1987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7PT8zJ3L2KbQOFVGRqFN7Nj8oyYXHyf+RjO+kQuFM1eybYz27h7picC2vIhfgq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Srinivasan Shanmugam
> Sent: Tuesday, February 6, 2024 11:55 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Andrey Grodzovsky
> <andrey.grodzovsky@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amd/display: Fix possible NULL dereference on device
> remove/driver unload
>
> As part of a cleanup amdgpu_dm_fini() function, which is typically called=
 when
> a device is being shut down or a driver is being unloaded
>
> The below error message suggests that there is a potential null pointer
> dereference issue with adev->dm.dc.
>
> In the below, line of code where adev->dm.dc is used without a preceding =
null
> check:
>
> for (i =3D 0; i < adev->dm.dc->caps.max_links; i++) {
>
> To fix this issue, add a null check for adev->dm.dc before this line.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1959
> amdgpu_dm_fini() error: we previously assumed 'adev->dm.dc' could be null
> (see line 1943)
>
> Fixes: 006c26a0f1c8 ("drm/amd/display: Fix crash on device remove/driver
> unload")
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3a5e730be24..d4c1415f4562 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1956,7 +1956,7 @@ static void amdgpu_dm_fini(struct amdgpu_device
> *adev)
>                                     &adev->dm.dmub_bo_gpu_addr,
>                                     &adev->dm.dmub_bo_cpu_addr);
>
> -     if (adev->dm.hpd_rx_offload_wq) {
> +     if (adev->dm.hpd_rx_offload_wq && adev->dm.dc) {
>               for (i =3D 0; i < adev->dm.dc->caps.max_links; i++) {
>                       if (adev->dm.hpd_rx_offload_wq[i].wq) {
>                               destroy_workqueue(adev-
> >dm.hpd_rx_offload_wq[i].wq);
> --
> 2.34.1


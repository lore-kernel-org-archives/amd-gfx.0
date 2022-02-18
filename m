Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAC2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 02:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3434C10EB52;
	Fri, 18 Feb 2022 02:26:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86A810EB52
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 02:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g40Bfozt1TsFhoXNmZ4fjOfwTGqLKrb55DaJ+ONA8XwZjYlaF6UBJOhY0/fzb4WJlrV2syYN76cOcihVwGyljMAMXOA68cf8DlY2l/jEOQC33OmW6vPC+mQzmyhHp0a22b/vxP2Uac/8vqM1vQMvAKx2kzqaXyaw8ue+0M/khqNXp+Brw7kO0PEEaVnh1vgeN6ZlwJdc+9J0qQiKm3wWxeitHlB9pUR0L9grJSqPcd/3EArWq36FOSBvGOxGtCjFBnZA7FSy9t7HRqbhYZfxRCbSqCXDAe8ZzqMBdYI50e06YBhI/oT5wjfkT0ITQJpPSuWjIrcDBeEAbcb5i87rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDv12/HX4gmC1+B/lFqw8+KxwJIbbqFpN8uSC0Rw04w=;
 b=J2X8+CXU2q/PJQhb/YW3S4qshHwxYFp7KoBbgVVlZ6KczFE/m5X4KoZRY+cEC0J192fUbet4ymKGHykItHnBksUFJtavM6fvEhIh4WXQR9saBej9LQdoGoEz5/75I8TmUVICjgLvjiE38YuzpVNeCwxNNlkCc46glak5blvWeOoGfAvCMXN5lW878qPIlpFEjbMWKSKc0wDUTqIbj8lQR3PX80K+Uo3VJxrVRW0uK07o/A2bwvUve7EnLzcX86mzoYSkqSZOfeoURFwtBqCeFk6rVjH6EZpHSdqQZFVUCa+T1wUilP/afMzBkjNeaD57C0p4w87I5YuL5Nm5wMgk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDv12/HX4gmC1+B/lFqw8+KxwJIbbqFpN8uSC0Rw04w=;
 b=vLgZKc54kzPeBPBvpNIzgGYkzdkjx37INYh+AQc74dXadvn3URkri8y4ap9rJO0vSPdFRh2wBpdqnJ2yQoN33mcP7omGiW/1pRTPCHVLE5JJbiR6evTilcfUnoOHnD/91rVBsQFThKNOUKIcXOhQgfT/QcPYwF5wKG8q3BjMXgA=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 02:26:56 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 02:26:56 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Topic: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Index: AQHYJGy6NTYfva9jzkW/S1RLpeC0layYlRLA
Date: Fri, 18 Feb 2022 02:26:56 +0000
Message-ID: <BL1PR12MB523778BDB1ADFBFB5C3CB0E2F0379@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <1645150097-18020-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1645150097-18020-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-18T02:26:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=756bc974-8e4a-40ba-bbd4-a93f81b1504a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-18T02:26:53Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 318d7b48-4c07-4652-b4bf-3be0a5e992d0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb43fea-209a-4765-f1ff-08d9f2862256
x-ms-traffictypediagnostic: DM6PR12MB3370:EE_
x-microsoft-antispam-prvs: <DM6PR12MB33703DFDD110B8BF08B59B41F0379@DM6PR12MB3370.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jsQrimghQu2J3oOm7G3ZaNf0eVEc3r5in2aIVS28R0lFJH70Usbqe9Jj3w4wC+bBVDwWnZskmCGFLblG4+6hPMAtNkIhAjF5MhsL+LakX8Jjy45jMu/6dVd7376LWfd8jZuIVOi8lOwsjI2xsPIukywuKE6qhLO0EtfHkAYLZYaWouc0INHG1mu8WhNXIPG+nxwQwKzlOG/K6NFn/l1Hqe9rkOdOj6PGH8jEJsIfw4z7NYDZZk7lIWFR6H6n66H2UJjJ65t0tldBo8aQl1U/3Xrft5JqbpMzBVWXBKi2fj9poFxtWpGnhHbbgOvO2ndyW21k0qaGj82h/kHVS92lmPAGikYk+Q0VALdV3rkzP5Vy1ynE7sRmwzHGcqGCkQAzEUKAy4QfoQgruvJuOkoaWj2rYOjgJnk7y74gi/ExEerb7gWOh+DECIonA4qOLp7bG757bt9xUavZl8RtmZKRp+GWNFnBX/FCl272zX5tmq7JfPyoM7CWKkOo/yJvX4y1olmRQd7TNpboVGnEEFBgYBBmeBCHY1LansIAtimW8haNtYokQhy8qu3Xtj10I9uy27dqVQU9nSP3sonVybdjom3UJvU1CDXDGpKEQBTK4mncpai4ecubN8O0zYKZhdMDnPsACqAsLZQjqjdChs3c3MZjuT7b9X4yqYyhxkJK+NayfIOkydOVDrOhLbSTwVWy1V28lraZdPgiUD4PJcpZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(6506007)(26005)(55016003)(7696005)(52536014)(9686003)(53546011)(33656002)(38100700002)(71200400001)(508600001)(2906002)(316002)(83380400001)(86362001)(8676002)(76116006)(8936002)(66946007)(186003)(66556008)(66446008)(66476007)(110136005)(54906003)(64756008)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khVjcoREWTZT2r5pHfGCNYF2hz3wWftZUoAZYNzOP+4NgQy2Q9/2B3gxv2cl?=
 =?us-ascii?Q?VLhaw27jeiYSxtuHd1JlFiT6PYHdTaDapVfmOyv3Zw6HIE6oyVe82/JVtxZ7?=
 =?us-ascii?Q?51fSWsVkPVV8AE8tCKuw/GGwo1dztsq3SW1ix60JWdF0zWgxqzN9FaDI1/BA?=
 =?us-ascii?Q?XMPt3RCHpZwrzu2HiDsfLqFoa2kQoYQR9q/VZ4kKrSIyh5whGpUCBbQ1EmjI?=
 =?us-ascii?Q?zSgY9jHFIVf01a9cR3pcMv5d31WLOU/Qy2Ex71L7KU/ZMOniOU1ZGihJikrf?=
 =?us-ascii?Q?HfjbMFxomi403LT0RfESQxIsXotHqBwXl36YrGbPhmfDfoKiwuu+C2q+msaa?=
 =?us-ascii?Q?9IgtVfRRY2+yFyIKdTyNEoaQXA/WssH2yxgpyhp/rShnVcnAaTYND1DyozTj?=
 =?us-ascii?Q?hu1TDzOb+4vSM433wIRxc771Cce6m+xj/5bUSemwnBRNQbUh8ilwJvSbXrfj?=
 =?us-ascii?Q?ADni7qybZy6pH1Fbq+fpvn2O2aodXvgNsQibnCbOP3ckcBkKpYPm3atZTSU+?=
 =?us-ascii?Q?X0bcqJPMMd41DbvmErHilKMR4iTySM2Zx/8sviILTUpKRK85IvxiZ+XIz+U6?=
 =?us-ascii?Q?yKDpLVKNiORZRz5ge92moRtCRYLzR9wiLxTjkv/2X3wHX6tg2yT5TiAds2ci?=
 =?us-ascii?Q?dCuxw3SAGXB2YrcIPu+0h61WrBcJtMEP4S+hf8lHQxpqEeHOWZ8z1RAU+t9b?=
 =?us-ascii?Q?vb7FXAs3jfWCp5S9oYSvj8iGdPkmYUs+gflD34H+evygm6uQqk84+qB0os8p?=
 =?us-ascii?Q?qPbK5vkXnuN7AYyrdwXaWxzK6/DS2spgbk8zah9Pxk5ZRQ7uqIGqwrpw5lOt?=
 =?us-ascii?Q?BtTqv+zaNmS0gu/Z4WmRJ5I5h6hQZvbMOVcKB0mYNEBaYw0e2BpdLeGyeMOS?=
 =?us-ascii?Q?W8weazoOlpm4j+4ggbC9Qe3nbmCHT6XSGCVtMz3On/poBU5bkvz+cw9SCrIw?=
 =?us-ascii?Q?oywwcfxxe3TGFruWJ6+WitULXWqYSa9thZko7/eyzinoedhWOzg28RoUeepW?=
 =?us-ascii?Q?4xw9CJKhiMd9TehqqbhL6ne9/ujaoUMx0+0oxT/1NTWSQU9WQ8l3iJf+uEbm?=
 =?us-ascii?Q?JNnhAZNm+x6el2dQhX+Un2/0W/u8cKMd01yERLYGgA67ftOIcX5c53RN+v3v?=
 =?us-ascii?Q?31lxw1F+DlZCa3Ci3wdHDBI2VfvB6EIQk8sSY8esMC/vyNGd6nmykvTbll1g?=
 =?us-ascii?Q?d4gQjI7S3KOAJ6Qnk6LEPl3WBUDPuCUAD6UkODlwEVUw+bqs8pcxBx/ZC0fG?=
 =?us-ascii?Q?4zKNkfwYUc7BYnrjrDSGF3e2dUXcGAsRHNKUE/8wIjiEfQLE3BFJ1oWpEyEa?=
 =?us-ascii?Q?6ZCYqwFYjboaaiLattM0pM9s4hd+PD1v1NeIkbtg5d8EUjAz7cBw285DhwT3?=
 =?us-ascii?Q?w/10IKSOqOhHOmHpzNiNL3PlxmfpiDB8Sj4K8lO7FyTM3YWk+Ekva/qfU9Sv?=
 =?us-ascii?Q?1y6LDiyTSIPkkxKQr6ylX++MQCfDy265HcuaRvoZKk/SexYkllyZRe6n0nJn?=
 =?us-ascii?Q?8Zu2oTKRxE1t+X4z7MovjkrQtQwAIB6GMJs1WAXEJPBXPoA9V3HYFn0yMJ7u?=
 =?us-ascii?Q?Clgn+jf3Kz/ioYoBmIU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb43fea-209a-4765-f1ff-08d9f2862256
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:26:56.4504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y160/hikXwEul6eH5lu7fmHEA0Ov5gjDwOq9uCXR8dxn+rvrinPhFTFrSt7rnT/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, February 18, 2022 10:08 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
>=20
> The TMZ is disabled by default and enable TMZ option for the IP discovery
> based asic will help on the TMZ function verification.
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 956cc994ca7d..2cbb8c432168 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device
> *adev)
>  	case CHIP_NAVI12:
>  	case CHIP_VANGOGH:
>  	case CHIP_YELLOW_CARP:
> +	case CHIP_IP_DISCOVERY:
>  		/* Don't enable it by default yet.
>  		 */
>  		if (amdgpu_tmz < 1) {
> --
> 2.17.1

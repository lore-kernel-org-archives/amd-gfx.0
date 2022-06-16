Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1465C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 02:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ACF10F659;
	Thu, 16 Jun 2022 02:57:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA0410E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 02:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQpzot+6p7YcXTe9xQDWpZjM6nn6BRfwGS0S2BgoNBdHRC3KlEVg8UPtKPIvTXdaJzT1QNvXzwQqEwetfUOSmUVYLfzNGtlVyEYG99zz+QL7hiZuuM/RnUbkmVMS4NZTw/bDc2FxKkUUICysaOCzfAyWfv2d34hLZVwEjsUo17si63IMBlNa/2ig+U0IKzepulYNpuS22l2+mZA0zmSD1yFwxaFf/haxKICdXFsvk+sPegLYG3iBOROf4dqYCh1AhADzPZNFrkqHD4mqyb+ZhMkelA90yE92AOA8PghZY1HTVj4tacWltkwGI/JDfPZ7DTSPbnbZxcNQ+HsuHIEqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te91/KrlFKiQS+RBwyBK9f+rZ0nFG85S5KHzGV7dFQw=;
 b=FSFUAtVyfgFBWMm6VJ+5COP6+1NE1UK2RFNTQe2V8P8Bbb0sn9O7Nt1pgI2lgzMgWp+4kCqP383Iq613ViWz2rurtqfYgOuQiLnsSjOLz8ANGJp8sTiYfRs54r6MkOOM3aURAc7Yy7l3DNxF94bawewztxaOEIwynOZLpHxXAAFGgPAWpWVGwZSJ1oCcrsNQqrsSJ1vBifwJPIC8AVsxUyuyFmIv9IRa/BpnMoI+vmoCx65XTYSAqAH+eoq25QfUQGoR348HEcZowFh5zZ/dy0+cIKlpapQDA5JdyCeRGkxlEYhSCiuw8dluvxThg+BlKVNLQkHEzPUNIkmnJyr8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te91/KrlFKiQS+RBwyBK9f+rZ0nFG85S5KHzGV7dFQw=;
 b=s071lEY4I/dt9uByzSE+al/z3q9J5Y5nzYjjFWIauDRbu8khWzKXRg3eJL4/Z0gTLQ/bsOp4P/TJGPYy4wHiaFWVKnP6rPjn6KoY7h/EV/KL/YmNKM8mDDWBYdRdVbEPkzUPvASAdIOy7wnY7I15ftln/LMYntvb0y33XQgv+f0=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by BN6PR12MB1331.namprd12.prod.outlook.com (2603:10b6:404:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 02:57:52 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16%6]) with mapi id 15.20.5332.023; Thu, 16 Jun 2022
 02:57:51 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
Thread-Topic: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
Thread-Index: AQHYgQLuMzS/dJPNWk2ILPlPSRvG1q1RVsZg
Date: Thu, 16 Jun 2022 02:57:51 +0000
Message-ID: <DM6PR12MB3067448BDA70EB6963D079AD8AAC9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220615215651.14502-1-Philip.Yang@amd.com>
In-Reply-To: <20220615215651.14502-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-16T02:54:46Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5940acbc-1826-447c-b46c-9216e242c0b0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-16T02:57:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5103f676-8b9e-4f5a-92c1-a5cc1facce27
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4d475a-9f3e-40a7-008c-08da4f4400ef
x-ms-traffictypediagnostic: BN6PR12MB1331:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1331F8343495017775BCC59A8AAC9@BN6PR12MB1331.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJKkpToMPPBLHJtM6nRyrdDL6ikh7O/QkWGalOyijjh5rPClc0PNRQqU4FZt1G95HvjGn0x4Dj5xdzf6+b2U+SylY6yM0Rbg+sxMTW0jOWG2WZjUEdUg7+FObo+YbR+l9LFPGZUZaRol6DZd6I9HtWPcdsy2fGu1fumOLgWtTOLX49mJkn3K5vVtHa1j7MidVYbFgZAtszupSSKYfBvDbpw0Fipm3CiWPoIJavsOzwix79EGT4JKRcK6L9m0rstKwiPJpQ44LhIUBkH2f7zaI3ABjXKLBQjdWs3y1RS1F4+f1MUxQN02VQ1fJXVboejTFz6CSFzF630tiLUy/ed519O4H9ZSBMYaSUqxiDe/SIXAJgG/ifhnMDFRfxC8D9CTac5spmiOPFtZSNeyfA4a1E72Bv3UZXeTrW+CCuwUJ+rVe+B5Zj8L06Sjv/7GVEfY97OrYCMpknnZLzQ8+o3ZceFr0sb1WEDyGmJ9aNLT5trazorGvWKbKpSbQzNz/O1Q8gTUuifHOlLS+wi3ey4WhYQTXoalrsjNsc8MaWKn1AQZtvHzII1+n2joOiFFanIztkDL1Ygq6bzGiTolGezZAvSPNVw+V/TfkyrkHFT+l1KyccKTAwEYvlrlF4CSLFzDz0INK7DAojsxaXFism7YFwDjFQx1PCci1OqPTzwA4JOA9paxmZZXmo+urxZBL0XUZuBYZxQs/Ho+y4/WV3IUsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(186003)(9686003)(6506007)(26005)(83380400001)(53546011)(7696005)(55016003)(2906002)(38100700002)(122000001)(38070700005)(110136005)(508600001)(52536014)(5660300002)(8936002)(71200400001)(76116006)(8676002)(66946007)(66556008)(64756008)(66446008)(66476007)(316002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0HhCKg1S/2XJX1qGUxke7F3EP9ozIN9SGeUt9DALVP6B68JT+RndV83oIPds?=
 =?us-ascii?Q?2T5ZSyxFT5XFdzgNoFqqOTX9hlIUj20IWL4dGbL+wJfPwjtsK+T/wAdfBYg/?=
 =?us-ascii?Q?qF0d1zhWTABxR9rB+Wt1pnc5lWiAxX6f7r0AkpWiOP36UG4yX3pTIbhdsDHd?=
 =?us-ascii?Q?QuWJYtt7WbH4wCnEoRqmJDw+BpPol/d5HsWxdxXjyieAZqzlonerkV6jFYNK?=
 =?us-ascii?Q?+ko1K8M6CcHiyqxRi/hYw9lUkiKT7aaYf6ushxspnBsCVP0rGbhHa8vq+r38?=
 =?us-ascii?Q?lVAyD2Q6JkI9wZG2X7m4qDH4IDDHMC2gru1WLvbUwmvQZPZd64wvPTb0BzOy?=
 =?us-ascii?Q?xUlUjxNKYwSsQrtftNq6vGEyot1TnCxZ0PMXFyi8IpLXBq0nsTbiPL45/6iI?=
 =?us-ascii?Q?Q1CAzl1PzvHHvDqbu9o7r2ALHrpgMuoN5xdVJeocNmvurhptQOSd9+ehliMO?=
 =?us-ascii?Q?NZb7XLcZ9VbnjGwwWNzYzldgWLZwXpLREp0dAn0BMBmoS1qa3FRidhW17Y5Q?=
 =?us-ascii?Q?6qv8CveOd5fGEMs6+vJfrrH4HLPCKUR5GsbCIvi4mRTMtU10M9Sx/vCFj5Gx?=
 =?us-ascii?Q?HFdMGr3/BZhqwy7LJMaMle6y2/q2/1YX49o0cY2p1odMFe9SSQX2OewewcAG?=
 =?us-ascii?Q?0GHMvmlFDz/yUvvneje9jB1+q5CzuMnrX+/PC3LXnzl9QrZifGNrWulaa6Yd?=
 =?us-ascii?Q?J8j3QOzFchsOrCNksfUDIHJ0NCYeB8ZBrJi41WXhlx0izugAgSIH2z3MeqCO?=
 =?us-ascii?Q?zxPfePlkbsKoxip8tiTCw1KoeSDDVc7mgbED+1sLMXLqNqsjDpWwGzvT0J2o?=
 =?us-ascii?Q?LzNHGNT0fnAdgqfrQ3Sgn6dYJ2XVHO6SiyVgs0Uoixf5RfqQ7a0Dp9Fh7Qup?=
 =?us-ascii?Q?ttvLofF7APOLg1NHHpRNQ6xpIb2qB6fXxd8zoKqUxp6ucuSel0UXS4MDs6A0?=
 =?us-ascii?Q?nFa2FIbBjdrkrHN0pELLeuBx0I2mX6KBUzSErnbnYYv2GCX+MZt9qNXUJ0yP?=
 =?us-ascii?Q?tdHJYRV4P4P5tbni2dVaQiY9MnDm+wIusoT3vlXInxVuzEjeTwy6oZb/sfkx?=
 =?us-ascii?Q?C/rmfFmFJvaGkgt6tNfqjwnXGwG1AoII3mDpmfATeezaMxYdRuJzpcUtIxRV?=
 =?us-ascii?Q?YyRSwQPJDvPiWsIXqatxDSu3MzFY+jpXcaS6KihH+gg1+PifenR1HR/6rpp4?=
 =?us-ascii?Q?nXqzOGJdaCNZI2u+Y/A/E4binhj2k+NFLyTJXL+F+uLhOLQ0Bjsl4SP6eNtX?=
 =?us-ascii?Q?rrw25uZGeLPWmfMZWe4jPcMn2Ik1+PIeSWDFUYRZVXJKUcf9DGwr619e4PPm?=
 =?us-ascii?Q?Hy8mBn/TuxMHda5G5rDHUSg6SX56hjpBQzc3hEUE3sDWVOqFsHr2hyOUqhcM?=
 =?us-ascii?Q?mAZWF2eabx3c74N5GczLOXa3dR5jdaUqctywnEhytKU7F4Bpr0jalepJGOxp?=
 =?us-ascii?Q?K/CDfwrjsyRA7EDMW1uFwh14EnSDs9QUOwNv4EW7+y96qQjX46G8hAn/gG7t?=
 =?us-ascii?Q?HlC1QJzGxf+oOlMfi7NLDpS7BLf+w9UWUuC9nKfdqBsLsvVC0iQX+pAMbPtt?=
 =?us-ascii?Q?jsX83M7i/qC3UmMO37sViFPGD8BY7k8f1AmbKruxigw0QeDSgSuxMAGAxK/l?=
 =?us-ascii?Q?V3/uRa0i2Gwx9xfhpb2pZ+AU+LFXKbodHNO0pqrJklgFwVLT1L49+QGiQsm4?=
 =?us-ascii?Q?Cwhd3r74aTiwToXaaWAkRrD6Qn5BU/jczuiblhLhWsh6p8W9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4d475a-9f3e-40a7-008c-08da4f4400ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:57:51.8067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yliii3IRc1pPdX/JyIALtU+1weKTo3EapMnZGiEtT58Q3PyQK29b/gmU53Xi33NLQJveY3Cj1dZO5MDsgPIqpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1331
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

Reviewed-by: Graham Sider <Graham.Sider@amd.com>


> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Wednesday, June 15, 2022 5:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sider, Graham <Graham.Sider@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: Add queue to MES if it becomes active
>=20
> We remove the user queue from MES scheduler to update queue
> properties.
> If the queue becomes active after updating, add the user queue to MES
> scheduler, to be able to handle command packet submission.
>=20
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e1797657b04c..67ae5b6385a2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -866,8 +866,10 @@ static int update_queue(struct
> device_queue_manager *dqm, struct queue *q,
>  	 * dqm->active_queue_count to determine whether a new runlist
> must be
>  	 * uploaded.
>  	 */
> -	if (q->properties.is_active && !prev_active) {
> -		increment_queue_count(dqm, &pdd->qpd, q);
> +	if (q->properties.is_active) {
> +		add_queue =3D true;
> +		if (!prev_active)
> +			increment_queue_count(dqm, &pdd->qpd, q);
>  	} else if (!q->properties.is_active && prev_active) {
>  		decrement_queue_count(dqm, &pdd->qpd, q);
>  	} else if (q->gws && !q->properties.is_gws) {
> --
> 2.35.1

Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B318C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE61E600D4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE61E600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610B06E093;
	Wed, 13 Oct 2021 07:12:06 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A65E6E093
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 07:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b72BQrUux7x7dQ4T5RukqNkJY1GVNdnbI6ZKahVRLT8WhY6kQJrPWaGNvqjPaZIYcNwSRHo5qBvCRrJCY8bL+kfc9p4iJuvcd0DrlKiX2ceh9wYNgsMVxpAjhOydZM3GYNtkEk0HwBN7gzW/j3Zq5OFPEb2RaG8tvbXteCDqDxwKSSRvJ5gUTYAC3dvkE3Sj1tts0Yfe4LOUYzs7c9veT0eySg/J1MH0rKvuae8UALNn0p1IwlaUv+wbJO0VtdMZLP6rtV5En6iGvCUl90R/YHqgjnt9SbXY3/gi4NDzEvhd18fhS4v02pm122CqlOI5iLed4gZJ29p1Do0agqc/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVuTFcnFP8ND13OrcmThsEDkAYoHqIFJZ5wW7hBtVas=;
 b=IKlMgX7uM5moAqZnXHyWgcBeec/8zr1obFQ6v4GtlCMUZI8bzAS6Bo0C8WhWKyZ+L3jwo2jgmqqRzEPhgRpKF1liOB/L81Veu/9pJiR9dU5XyNacLwoDYyAyxUB2Yn553JQbUpsHSM2Q134EfFW63s7Vuv+mwkDsy1rwI+RgQvxyYMI6bCIGlXWHx2aMajw3K1u5vTxi3uksxe6zv6xkkyzjD9FDtbHLWT6qjN3u9vk+Wi4rsXT8iN5vS5/3KKcRQ+SXGYDIWMT+ArNAFQkU3Czd4may6ge4KVN3tI0HEUydFyiFgGVW34C4GFPFONU19bJtB5AZz9q7+2DtK3MUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVuTFcnFP8ND13OrcmThsEDkAYoHqIFJZ5wW7hBtVas=;
 b=ZpOm5xcqjnxPu+X7Xva9kt3Qql1edB1EjO+guvgqKkDD48ojrWs2YUWxQv8RN6UoJCL2c6MCdyy+tQ+GiuxIvqfDZsdtvi0VclXi+rYVZCCAECEVRlSKVYYbz3xSpZHPPHe16gvnM97ChLI3benaFRrhKb+KTJm7yKT7b6PK0/8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Wed, 13 Oct 2021 07:11:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4587.029; Wed, 13 Oct 2021
 07:11:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for
 vangogh
Thread-Topic: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for
 vangogh
Thread-Index: AQHXv4FU3WrqLkOPAUmOCoGVMatYJqvQhA5Q
Date: Wed, 13 Oct 2021 07:11:58 +0000
Message-ID: <DM6PR12MB2619661366999CD638EB3C79E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
In-Reply-To: <20211012155307.1059170-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T07:11:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3beab1d6-2f60-4aa7-9029-9a89413e3f82;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6568f9a0-e5bf-4391-fa15-08d98e18bf39
x-ms-traffictypediagnostic: DM5PR12MB1260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1260B3F2F189E82B3CAB1957E4B79@DM5PR12MB1260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/gpImzQXFGnKqUruzmQVR3SyTXvPhVwjcaezlRzg/FKeI//DKMIKy0JS0Zr2iNUiHni7Snlkk1uuRkGNU+RE88W1xVpTsEiSG614rrTSOB9c+kN2WkrgzuCAcCTZW0+L9GIOfFY6r4odefcWF7m/axJtC7R7Q+DB0ku9/tUK62lKgSZ1/wYdv4CTfMsiEbwzdeeILcaS4A5nzA2UwdtuL/dgC0KQjZ+VefWiydkmpmTuBuLKRI35oQBbTt7CxpSjMkJmYQEQCUFucp+4gQfcfzKOoxPbevAnLiPGNqwC/gdNLwMIZoabb7R8wUnWnQzdVozsSx9lmf1A4wcze02BJpOYqvF2tnV63kMEgbpzfNPyRDhuKzNI+22wPYujQQUbdTfvlsqyykJ1rh+/x9RkpfUYb7w8Zoybcn6CpUjcxgjoEEaSH9P+YPeEELRhjTfYDlsTUew1hJ3giNmoexI04ncyRJqh2kFZPX9TY8JpzpJYgLFJ8GW1iLIvPkEglKJ8a175Dv4/6QUYNh/8oJ2aDDzSox/Juqdk4MC30DdEf0ylXAEStdZY/UpjpNpr+5eCOPrFQCS3mP9O5u1CCsxFflDVXUSLZ9q6igbT77JbPCkCb5Tk5vQ85IjM3f8xar24r/T4V/OSWOCtq4SpU6WhFfbeqgNWTTcHSa3U3bH+NHU8uEfvlutRi+5Ez3cAOL0JT7u5T3GHg5Yh4aPvdo/6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(8936002)(186003)(26005)(9686003)(5660300002)(55016002)(71200400001)(38100700002)(122000001)(7696005)(8676002)(33656002)(83380400001)(38070700005)(53546011)(6506007)(508600001)(64756008)(66446008)(66476007)(66556008)(52536014)(110136005)(316002)(2906002)(66946007)(86362001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?buFkSGuYjDFvBdZdydDkQ1rV9tVxWB7PMas41SkFWpf4ftIqUvCIlPjSMFSp?=
 =?us-ascii?Q?oyiADMESCYmGuSiDimsIzrpLIxETEfHWYPBWgbEiyUiW0Hgx8q/VLcRn+iSS?=
 =?us-ascii?Q?PiJJVdqX91xl0mp/SHnb4n/MwIsBF9HPzxoGFyjuLfEWvc0u3XmhTYqJtYrt?=
 =?us-ascii?Q?JiSxoYoVfNFq8MgEs06KqIObzGppSugLHVh4FXM/jlrxEQWlyAqBx+YmFdqv?=
 =?us-ascii?Q?zb/jrALcP/Ehf//AD56K6uK7gzPFdz28JxcpP5WYRVqI7grmUrXWkmYQ7JBK?=
 =?us-ascii?Q?Q81CCZ4Mbtp2O77X5FjeXmUnWFNMBLcNXMow2I5rKfnPEJIQb5juREN4spbM?=
 =?us-ascii?Q?F8spg2qdWc1mH67pqXkFQF54Q7XZqjzjeKrBJfUVzKw5joRQeB+e/j/4J7Dg?=
 =?us-ascii?Q?FrZ8sjvjuHxrKqrk1zZZ1+JDQFCuE8yEsVQIouucS9YoWeNR+Wx4y+Jc3iba?=
 =?us-ascii?Q?nUcf99zos5UFNLkZirqfTKHYPbPeBEMHRtQJuYy8gT8j4tTknmK3rKxLYO0W?=
 =?us-ascii?Q?nNyKp42gQ6KDkjrHSHZ/kjQBh34ZL2bMmvlaf6tYQGoIDOJC5adT/k+Ce2iS?=
 =?us-ascii?Q?ok9HG4BkJlRRHIuWM3o1b2iB5nKbL8wZeHvE1Tt2cfG8uqSrNzjsZXt8poYo?=
 =?us-ascii?Q?DF5a6IUbuyu+5xHgbDfT67LTkk+VQ1q3eWeLFgKVKmXzdp/k6+/KKrrUDG93?=
 =?us-ascii?Q?h/IcitGZim2J5sddFhIpMt0tU26jNu1Y10/6lUvmc3lu4TeA9TNkOx6eDIVX?=
 =?us-ascii?Q?l+9/O9S097VW7K2FvE8TbFPwLM+UwtfQyL5jy4UuRCVXz8Sdla/HWIH8TLxe?=
 =?us-ascii?Q?QMsN0j/8VBgS8VsUPNUgoN/pwt1pa/rET2T3Rp7DYC2zB82YHmv6KNHfHUFD?=
 =?us-ascii?Q?Ysc2jSChmEj9MUABxiog2ZcSDhZ/NQszZ/LgKRPeVuUygNB2G2kbRDYSFCy7?=
 =?us-ascii?Q?VrItd4mWXrg1Aey9mGAF9mW+wWxuykPghIZqo5Zs1VAkjQB5IPkWYfe61OVn?=
 =?us-ascii?Q?O0cZroJJ8CuxjW/uZmMpMN/Gd9iCENdXhw1+nZFSQLHuSK8IbJw24sQcgVNa?=
 =?us-ascii?Q?XQdk1GR1eHdSRgb21EFKMkSIG3nTJGxbYOyWR2B9BQAVsFW1gzOQBmrB1OxF?=
 =?us-ascii?Q?uzRk1JjXqevaED5hHNYfBhs3oN8OvUe7S98I5XWUytY6kAXQHHEi/HHe5zkQ?=
 =?us-ascii?Q?tVxI0AkGTKKQ2luws8uUnhPpjzsP8x+nglTGhAauq02a1gm2EZ9sDmxdnMYC?=
 =?us-ascii?Q?h8vKyD2P/G0TkjAbEjF1Ervg9TZSMXQCw2RXRKCKR429mAnfgaTDCv9PvlTn?=
 =?us-ascii?Q?2NDW3idEPYwlYQg7SjUGUB61?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6568f9a0-e5bf-4391-fa15-08d98e18bf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:11:58.6673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNNafK4Tdqjl/VJ3iy13ARvHrjFiPD0wq6pZtE5HsdgxiJDFtoRwPV5+HqICT/Cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, October 12, 2021 11:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for
> vangogh
>=20
> Was missed in the conversion to IP version checking.
>=20
> Fixes: af3b89d3a639d5 ("drm/amdgpu/smu11.0: convert to IP version
> checking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 3470c33ee09d..6d008e9c2f65 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -255,7 +255,7 @@ int smu_v11_0_check_fw_version(struct
> smu_context *smu)
>  	case IP_VERSION(11, 0, 11):
>  		smu->smc_driver_if_version =3D
> SMU11_DRIVER_IF_VERSION_Navy_Flounder;
>  		break;
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(11, 5, 0):
>  		smu->smc_driver_if_version =3D
> SMU11_DRIVER_IF_VERSION_VANGOGH;
>  		break;
>  	case IP_VERSION(11, 0, 12):
> --
> 2.31.1

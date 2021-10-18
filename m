Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E63E610A3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 07:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E63E610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06606E97B;
	Mon, 18 Oct 2021 07:36:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74146E97B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 07:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1r0z2mvj6+tcBAG7WJHe9v73X+qBq+H3reYelNmZWcsS+I5DODXjHWiC0oSA2KP7CAoLdXy7wNYKV7BrEoELNIW0xXvqXqmAacmFP7OIzeWVQ04Bf6JPzjM6VwUBGY5jAoyaf4iakKEqcXxsJziKw44aew3Kc6F7nZhzsIDJy3IQebM15R9P0RNak607KJ9jV9Ldio/Ui0Ey37HBr40/fvA5AdAYSr2pi32wyeA00HWElRxCfYOhvfyqKK70z7PYLbo1hLt0z+eONBLYjGjiDkcFEuH1W1co2/3S1v/RG/N7qNJEfTf0I3twP9aPISDv12s2cBwqAWTEIKdfebsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d6Ti7jOwvmyDunzPNqRAikNCmjXnO60gHUNt7CYAhk=;
 b=QHlbUEjZoX0g0OIMJ/+4Ef4LQHUW+j4NFX+dbXSQ0faOenj2gnOVsSkxww186pEJen86rdn4khbQbXUenIrL4kqQtteeQWsVsFby34Mz/2fQfIsgFcc+71fQYlpEbD/QNdTolKIC1qyWQHqieBtwFOqq+3Ej5Yvp0EkZIHF13+AUF9zmHwd1nm2iKsD4741nEkhnO0cf3SLzBtthhQe8XL5YiRIdzdUuSMlbYmfIY0ynJ+7VWo3rZUmXkpr1lnLUuMsHIirHVDBmy43wlYAtcscNSg0WhISr466n/H9qYi7pVsiwcHYhoiD44CYKyIHmL4k1LZR3zQJI7JgD0KSh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d6Ti7jOwvmyDunzPNqRAikNCmjXnO60gHUNt7CYAhk=;
 b=QcVTNzdQ7zUTYWHczYIl4n9MTRXjt/VFQmQTeA3ADqtU3MKQ0YUS8Ol1NL+EU6SzfcKOZ85t2vKXr0w2jdfNkIw9kJjk3kgls/VyaCnzIvNTGZTTqjYpLnXD8FVPJ9SO/uKKo0n50J5wJDYA5l6EAN3fDHAiS3W/urj8jV4MJgs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Mon, 18 Oct 2021 07:36:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 07:36:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Thread-Topic: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Thread-Index: AQHXvnoAYkL8Qp0iyUaGXbuZdh0/aqvYaJ8A
Date: Mon, 18 Oct 2021 07:36:08 +0000
Message-ID: <DM6PR12MB26197E608C4A9739D1E0855FE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211011082812.742688-1-evan.quan@amd.com>
In-Reply-To: <20211011082812.742688-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-18T07:36:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=308fde73-4a08-4192-9a77-ea1eb1996a78;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d7dfca-0939-4074-7fff-08d99209f327
x-ms-traffictypediagnostic: DM6PR12MB4387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4387736B0DF5DF3D23D50F5FE4BC9@DM6PR12MB4387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UclUYLX3w7pgylXvxTGTKH7xLG/ZwoJTh0zcJ1S845kMmkXLuRLO+0BP7HYqMF/ScJy4IJdHetFRPK/JHTVZwRL3yIlyDASNP2lmFBeZg+hV/XS88jXIWoQ+Grzbf1FiaBr3P4IaWQL+JjMPwJ1DOQTMJk+nlzC9XzQHTJuKz5TS3ML7fYAkeGOBLCdbKWuie/o51Q8T7ZigpraYiNKTcMAn5/03M9PDCnljZEsTY5R/IZJUxf0Dvby91vh1ZPR6znz1t4tA3IUUnGnHG3phQiScV7kZoRn9AyLx/DVL67RUMcCeNL20QTH68jFqCq1QiX/cqEajmhYK3IQIzihRojoghBqaivB3kZUwn6/WWDtd8iZzaF0/O4XRdKJFVFZiwU7PFW0Cexld3DWDN8ZBAlUY6nS2/CoeT7PwPEmG6kQuWjaSK1KF5ZbWUYfanc2eq6pMkBuQy8Rh9BFkGRdrdyjSTJH+/ep83sJ6GWjyd7J54bggCRzuwHoklciLLwBG/I7rgR5YkVoMgIpSuJAcgCL9NcKxe//LvXGsXP/kKCUniTQhsz7XzvwP//MpkKcM42yzWmsCmcmWljWyGC2uiVdqSFTLAdvLEJdUzX85vJvtRJMFWCN2l0NfOhYD9uQMKDaNwY1TqYXsId0PNAb0kYn/lBKa48aNxgiKLHCY9oob/vvvJhWJaF1KAvLZKgy9e618tDNzMSDICKum2RXITw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(8676002)(38100700002)(8936002)(5660300002)(26005)(2906002)(6916009)(52536014)(508600001)(186003)(9686003)(6506007)(86362001)(54906003)(38070700005)(33656002)(83380400001)(7696005)(4326008)(66556008)(66476007)(316002)(76116006)(64756008)(71200400001)(53546011)(55016002)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EuWVwW4DtxKtuWE0a7gh+5W33MmS23/t3r1c+gTZUPoymtfwbBHsmQ3lbAMy?=
 =?us-ascii?Q?8l+v6332ate2hCRXk8gLGB0TYk/CU4UQoeTJkUzsa509gECPO+FERqV7F3QF?=
 =?us-ascii?Q?5t9lBFMGKCC/pIMpd+DXPBIFXNkhytdtA5UMtOtLfPaSOLOlQ4y9AQNxEUtZ?=
 =?us-ascii?Q?4/6yKBPm7fMa5tZQbwo2JgXnSBXw841W9hTHJAjQQOrFucODxxeLoh18oPk5?=
 =?us-ascii?Q?54J4z5XgWs4q8T6KRyTMAA3plxPlMIphj4itWkK0UxP6G3CqsOJS5IeXNZ1e?=
 =?us-ascii?Q?GyCulbqUNsHT6Z30RViQ5KkXtCVJmTv3/ik/YFwZWRbcHhRc54NgXIFL35kR?=
 =?us-ascii?Q?8IodB9PFEMhz8Vglgmcrv9ixlzUJnXEm4ACaSNs5fK03gbyRXJc/+MCL6U3m?=
 =?us-ascii?Q?mMPr0H0u6q2/NoLBr3OXk/xrLckAsJDmk8ha/1oIc7yYYa635VEQKcbi/NTs?=
 =?us-ascii?Q?OKeTkjHwCEZBrsR8OCEA8eoJEuo4Bh8/juao73zgcgVK0ehzfXM9E5/uylBQ?=
 =?us-ascii?Q?fwGk5pfx5g9YD6ceqd7jBiTfrauGGUG4reLp0/dEKbmRkVMwkl+viF0lv0/0?=
 =?us-ascii?Q?TSXeW/mNf2REPI3WMYdHCIVc9/6qEwfNeAc4a0pq4CJCvBxoa65mGrKagtxa?=
 =?us-ascii?Q?+II+g7ccb7F8R8GtSu3wd+kR9M9jzLpuXAa9z8OC6uJPsIgIfumqJhv1o9iH?=
 =?us-ascii?Q?Aa5shsksyf+riDaSDjEF1o3FTyu8CvbyPXKPPMeitQuhwpLjW6DBotrTkJ0l?=
 =?us-ascii?Q?WHz4DG8y3yGQdmfvnayk7OShDKI9y0lsGenzm6mKyEE+CL0O8lcXBUnmqKAw?=
 =?us-ascii?Q?L/uxoBljGmo9SZd3F1XlS+FXruGDzAbD9GtfEi3Pu4l+WpRSAvamGV0BisZw?=
 =?us-ascii?Q?yTGyUQQdOCjOqVm9fk2xgpBbjynVHMAHIJKolhJf7irj4kO8pFs19EW8pvK5?=
 =?us-ascii?Q?F3x/5B1oz7EoKiZuaYTkYwawSi8dw+3p3TefBlbbcxiCS6WB26eQunK2ZJfk?=
 =?us-ascii?Q?yaxVIPk0mH2OUDAUky5TdLDSKcNoHdpZTpAje+1d0CyUGEX+lkkfgmBNIBgn?=
 =?us-ascii?Q?Dp+9oqyxTJ3PCMyjW2LmFpMMwws+enRvUbncx3TooVyAC8z983VkodtezUk8?=
 =?us-ascii?Q?Fa9rspNNGjkXxJqmYLgxrboC77Sie+MYbv8sMJGZdvIRUybWOXJonf7Glg3t?=
 =?us-ascii?Q?FIfhyisJ6xF8or+WG81k4aIm0xE2kxLMuhsmMgc9Fb30CSU3rUcQv09csRao?=
 =?us-ascii?Q?N4+ZpU2xt0gSIqobXbxB8ou5LBQTsWPhUF2a9UjXFy8Vr8+X3JLT9saOI5WX?=
 =?us-ascii?Q?SorqG6D69Iri1xQPRa/5kwPZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d7dfca-0939-4074-7fff-08d99209f327
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 07:36:08.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVBNik/5GWfEZIwVHG/TWFtpdz/7/mpzMRQNglAYJd1Go09okpx8782C+sfcTqzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, October 11, 2021 4:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky,
> Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
>=20
> This is a supplement for the change below:
> cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index d5d023a24269..2d558c2f417d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (RREG32(mmUVD_STATUS) !=3D 0)
> +		uvd_v6_0_stop(adev);
> +
> +	return 0;
> +}
> +
> +static int uvd_v6_0_suspend(void *handle) {
> +	int r;
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
>  	/*
>  	 * Proper cleanups before halting the HW engine:
>  	 *   - cancel the delayed idle work
> @@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
>  						       AMD_CG_STATE_GATE);
>  	}
>=20
> -	if (RREG32(mmUVD_STATUS) !=3D 0)
> -		uvd_v6_0_stop(adev);
> -
> -	return 0;
> -}
> -
> -static int uvd_v6_0_suspend(void *handle) -{
> -	int r;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
>  	r =3D uvd_v6_0_hw_fini(adev);
>  	if (r)
>  		return r;
> --
> 2.29.0

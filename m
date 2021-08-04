Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A8EC432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 04:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480FC60725
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 04:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 480FC60725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8D96E9BB;
	Wed,  4 Aug 2021 04:52:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2254B6E9BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 04:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIKY2fYWLF+1wImHhg2rgHjGcBgpeYLy6xftwh7Rny9/j4YBIwyMLn78jqXm8Gwh6WLn389UgLB/tdkS61tz8/fEj7PA83eVNwOAXqvSVohQD4l9LRvu7vDgw8Sqht16S0NBxqmWsP65QEwKTKbDKqGhPG8vw5+aKuYZbZrFhx7aTRnyFJDvYy7LPoGwao3AjX2+ZKCxJb3wSdBzusq2i5cFQzigJZm7K1m7pH4AQq+hyhpzcDp2vkU2WhuSCNeI/ckfjIXaLi8tBzH46tI8Nk4RI7dVlwlrAOwueStp9e5u4uLGdKEXftAGaEdrroiYAom4x0DawRoCLpsxl8unXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zx6V9BKVeDRZqj2bv3Wvx4tLZ7RpkToRhEMSE7NIgE=;
 b=c8Wc2WUzKsSkb04XhEi2mbcQEnRMdG9YtBxtteeZXZMFpGrvYmHc5uCP+c9mR7EJBJRshfTrvh0TUX73HRUqF6DDx3Q46bzSATS5iWPFKsWpLge06KpcT8tNwJFjTae39tKbQLqiRahT78JwHRWNLY9Co2r8EkeQ84KXcqMS2G87k+JMZU5MSer760xypCl4qeKGQtpbBbe7YWOC9EUYQKbLnQu0sX6fwwLmsNDpUnHkm+iGvHVwEn0HPWPyqOFIWnq8cRisdOoTc5tjA3AvU/eHYtCVVsXbFs+fP6gfDtEGvket0unoMZpQoQ4Yb6W8Eyhh5c9SMbwgt4vnlPsTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zx6V9BKVeDRZqj2bv3Wvx4tLZ7RpkToRhEMSE7NIgE=;
 b=h/Q9dUUmfK4PbTLl8fk9DIay6ArMoHKvG5/liDKW3H9tyT01Ix0hKXwVBTNedUmeA1XLpq6LL6uuz64fyZIaR+2l8pG/oCIQd4lkUERHrql2vSkbihrMGb6sS/QUO5/tNHcwh9mFG4yfVvvl72h6AfpWiUkOoas51vPrRM9lE3U=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.26; Wed, 4 Aug 2021 04:52:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4373.027; Wed, 4 Aug 2021
 04:52:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't enable baco on boco platforms in runpm
Thread-Topic: [PATCH] drm/amdgpu: don't enable baco on boco platforms in runpm
Thread-Index: AQHXh73c9eEx/2t2pUmVpR/5Qyx5oKtiyUNw
Date: Wed, 4 Aug 2021 04:52:19 +0000
Message-ID: <DM6PR12MB2619C468AD352C837DB39030E4F19@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210802164534.1359533-1-alexander.deucher@amd.com>
In-Reply-To: <20210802164534.1359533-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T04:52:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b8ec009f-8fad-4369-ac20-c486bb9a6214;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33c07560-f90f-4cbf-a211-08d95703a3f2
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35798B9F1E98FA2A4970950EE4F19@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tb84t/mZTuEyPnlFqdtksRsUyGVdLdQwt7Iv5+o2iu9d7hLFoiLAwwa/6h1j6g+gmIGHvDe7s1Pu2dbp4nM9m5PhsJBM+P0ET4RS7QgIdVfVJemPJuPd5Az4F/oa3g5iDMrRHzNAIsbs+gGmerEF5agSKtvZ0sV7H/btNzdhRXeohAxq7bxFDQaLntCZCKo+r1Mzs8eae4Kz6TFsFcfk3YZnPE3zqdKJSyGWvs0fib8iKVymajtKow0l3ICwWhkAyzsMf4I49CsOxASsd/1PYk2SBrcTUBzo4cpFP02gcElbt71PJ8YxkAOduq3ij4rFTgqlWM+hE6jp310/G/SYp8pt/CN8gOuTgxTyiwEVj3uhFdOEUTx98CWMvJSIAWF2GwixMJXTb51Wiw6y8LxAOnVXtn0kmdCkEI/XC5HtURym1pLz3AtjkmWcSALnOemiY+Hoxnqho2yPVl+IdXjw9vgtN9vG0KgjhmTLEh+znvOhy0PwbqZatp+kEFnOsWN7ixj53mPuXFgCP2cEno8BZ2nfLqVQn+wbB5uRusRCNXF4J7m0KsKoj6wJJG8xTlTV9kXvES7kMWKn5hhKBfJTdarIyKMChO3gLokqXQqcKh8FbzWNr1uNAC1PNnFADQEUZh0WDIgVw79lGRkW4HC9w09zWEDJ6mf7cfkPIENb3C1RtKPSbsPR5cDgk8CAO1pT6/N79HLpMfL5WALbP258DP9dMxgTJIwc9T7Yse8ivgMrJ1ZlueA8TRSAxzexYVPik9M+ZLQ810FZkc51Xaafj1fazL8G4PnYEJSm4XZ+Oes=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(38100700002)(122000001)(2906002)(55016002)(66556008)(478600001)(71200400001)(8936002)(9686003)(66476007)(38070700005)(66946007)(53546011)(6506007)(110136005)(52536014)(8676002)(45080400002)(83380400001)(316002)(966005)(4326008)(33656002)(86362001)(7696005)(186003)(26005)(66446008)(5660300002)(76116006)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8svqP7UWBbijsLdObIKPQFlQZ442Aq7BpeMG3F/dhnEwYSQCx4iaNM1DsLcw?=
 =?us-ascii?Q?fHu21GEmTkPItQe8b4Rz9pki1vxlBxC+0a+O0mi9CWoQy0XRNFpcM9MbEq0n?=
 =?us-ascii?Q?ba0iKfyaNdONNDa3S9vkAn7A+vAHNfbN3T390vQk8KkWdKCnrlh0Wy7dhhWB?=
 =?us-ascii?Q?qaGb7TZfyMhCDeeZQZ5D9xpDN43dl1h5JEHiGxp/hU4QlT9sIh6S8KeIsZtH?=
 =?us-ascii?Q?uutLOmDkicZR5wle+5vuVom/fqTuKzaYB6vv8oU+mC8bHNgIX7QkS+F/gslS?=
 =?us-ascii?Q?KTGVbRcDeJUwqATMK/QXRS+ULDlbz/JLj7zdvzBK/oynwh26Irnrfu4/Onm9?=
 =?us-ascii?Q?Or6NPrtyjljDWY0faU7c9FhNDvz9MPhdz1ll89VEBqmPHQKJKhuYk71Wj9sh?=
 =?us-ascii?Q?p4h1ugVko3g/XGa5bDxiXt8L1bACqt8JWJl37PZF2TWplG74ROc3mTGI1vYe?=
 =?us-ascii?Q?sUZvSF9PP4qLxZxr3yDfmYMzcZv4CxVSQX5qxZevp6iM3tHgQ85fAvI7CcLZ?=
 =?us-ascii?Q?OLEtJFgV1i1UpmtreBMYnwFQ5VAL1NzStggDNP9mqZ8pmFVBBZVpkrRhrB4U?=
 =?us-ascii?Q?dA/kjwXIMapefufhbtS9c2s3aqtBvfcK2L+OtpTxZGlWWXhYzRuwy0dzRIQV?=
 =?us-ascii?Q?8armoliHyhQS1SkYFGRxXeh1qmOOMeNlUv1Yfo5vxFWZEtt1mIWn23eTppih?=
 =?us-ascii?Q?XOA4zG4hBLNAXww80d3TrjglobqDF/BQXctzOnAQLdMf1LESX+vZMl4sQwGE?=
 =?us-ascii?Q?9t3NcK5EaEQJWFk+XuMaJ6ncv7egDYEV5zo20AqtkJb2ZEegRtBBEuy7K5vS?=
 =?us-ascii?Q?R6snSG6oq87L/tdwfmDunrRMnqD4ENV/+qtYriL6xAi/+WgO3hAiLZfqG3S+?=
 =?us-ascii?Q?N2Kyl22brV/A0SkIAwVKSHJ0bAl0c+eo7CBn0APgS7PLzbFopkX1fWCvcYwv?=
 =?us-ascii?Q?5FvbQcdW0aRnKHbOfwtv6W6QBFc9w6y7ETlO6/WqXXzKJDnwQMjAPah17n9v?=
 =?us-ascii?Q?bzRsCl6HNcbrr9CSWE9TGTQoaM8yiHbctGvJDX/p/6iNP25HRQMZJdQBxiwF?=
 =?us-ascii?Q?lO3/5Y7kMlIQP26v+ea/v7I7Bh3IR7SScct8ntp1um8aOEGk9cn1WVWYZFw9?=
 =?us-ascii?Q?5A33DUPumAdtefjFQdiXu3ujN9p9/NdYgEWBfSu7PJJJT6yKO6lzMZUS8nTg?=
 =?us-ascii?Q?kkbXz6SPgFo7uZrsid4Dc5IiQu7U8ZLnhMmtZ5nCm8ExUpmmwYa7OnVWinwd?=
 =?us-ascii?Q?Tp7MQvb4hgkKkg/gk++n63bf17haSN2e3VblB1CVMnGlbOMR6cC3O4F5OJjH?=
 =?us-ascii?Q?p0R4nhpIMGy/6ObLVjGDj77x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c07560-f90f-4cbf-a211-08d95703a3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 04:52:19.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNzgjiOEp8WW/w0j90zTqa3XIvEHu0fBfjVNIaiSY5N3XptO5BMR3SnNGFxqRwez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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
> Sent: Tuesday, August 3, 2021 12:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: don't enable baco on boco platforms in
> runpm
>=20
> If the platform uses BOCO, don't use BACO in runtime suspend.
> We could end up executing the BACO path if the platform supports both.
>=20
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1669&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7Cd65
> c86a3b85b452e049708d955d4fe72%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637635195555369506%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3D7eXhQgYtlr6ek%2BNtuLQyrCKvyGCePctiD0cKlFjsIhw%3D&a
> mp;reserved=3D0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 91a5ed96bfbe..d96aaa2aa5ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1566,6 +1566,8 @@ static int amdgpu_pmops_runtime_suspend(struct
> device *dev)
>  		pci_ignore_hotplug(pdev);
>  		pci_set_power_state(pdev, PCI_D3cold);
>  		drm_dev->switch_power_state =3D
> DRM_SWITCH_POWER_DYNAMIC_OFF;
> +	} else if (amdgpu_device_supports_boco(drm_dev)) {
> +		/* nothing to do */
>  	} else if (amdgpu_device_supports_baco(drm_dev)) {
>  		amdgpu_device_baco_enter(drm_dev);
>  	}
> --
> 2.31.1

Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D634C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12006610A1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12006610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C384B6E840;
	Mon,  7 Jun 2021 08:13:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973BD6E840
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM/cuPd2piDhBjQvbSHwJyf11SVseyhysG4YSLiCyCNfXI9k5L7G6NxX8Xxvw1/v2fD/Ev9AGECaoeWWl7zTWqm3ZYRX3YhFTbCabL9SBA+lhPRFqt8zLqUhoVImFDF8wVDSuEUWcF3R5cCe8Rg2IzOTfDWPhDdM5MzHyR9ToQJC0GnezWDgoepB2psFxh2ubkEj9S6Tlgxbtj5rechvnjtxn5+7TCTCiJX6LtKm5ubWYR0CmVLzRHa6xd3358SoTnTgidPP+ZjkOasRGpWkNCDDiGgbVrG2xHcFREk7ZToRdisEZ85mv0SAS4DdvLjYDNFvg1AWR2B2hDxxbN+dYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRrcXKv6Sk5Lhh83GPf+BT+96QtsX6uQd8up986YYqI=;
 b=AmEtjIAv46bi9mwfYcek8pRiulKMDArFnySUojLG4f8cF/nScKUsMiNbBmRlqIFVYUCRP6002dBBYiXfSMBy6lnuFLH1g9syFjGdKd3RHY7IEkensVPnkaA8nTlEAmK0+moPOGhYRQMViZtxeXaqZW54xc9GzSOGKi9dmk/LAXsQIdcWzhpUytG6WmmQqST1Kil1bhZTNWt/eRX3oPjuM/TDD87NeKboXXqdGX+2DQedhpGImtjUQfpOveXWeMZQ4shihz6Jvbq5FgQTNHWNUFSJAYb/pvahpAMJEsdU5EoCkSdFixGvXC7ZkT8IUDg/lwgOVlxtvXi6/nnrcT8yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRrcXKv6Sk5Lhh83GPf+BT+96QtsX6uQd8up986YYqI=;
 b=gADraaHP78W+E1p7TWHDZbbDkYGaY9pGBCTLA6oHtFquck02y1GhYsFfJ2ve9/I21GPVsd7+mTTz5MDcrYsPPwkxmjgPmQgS9wNZhi5ju9vAlRMYfPfBsurUaHkViYb+CrGnQOON5hKarJ/uEBvgYQmrG7XrBG05d8Sw+O8BWl4=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 7 Jun 2021 08:13:23 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::3c63:9408:f8c:ee96%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:13:23 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Thread-Index: AQHXWGUhvMwMHMv+KECau9PTnYnNJ6sIN1Kw
Date: Mon, 7 Jun 2021 08:13:23 +0000
Message-ID: <DM8PR12MB54782FB82F87D2E11A7ADCC3F8389@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210603104208.5725-1-PengJu.Zhou@amd.com>
 <20210603104208.5725-2-PengJu.Zhou@amd.com>
In-Reply-To: <20210603104208.5725-2-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T08:13:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1d42ffb4-96aa-47b2-affc-8ea80d3ea924;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a0f39bc-1967-403e-efc6-08d9298c1e62
x-ms-traffictypediagnostic: DM4PR12MB5312:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5312BA12159B9DCBA0F27257F8389@DM4PR12MB5312.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjr9p1kz1MYnFvJ9z15hBJUMS9Bu+nF6AqX1M9VD6Xc3sB0n18+mY61zU0T3eeHNgw71RH1lIxM3vYl4NeHSdZ5LpwyZmi5QQLG7drKJs9ZOEAfeodqt3d8Wq7QomaoYkP8NwSY66Svt+MqSRepc5WbF/BvYvApzLP+0sGko3EC/G/uz0KSGIf9K7wf0o4upj/9p80EWcxZDcaoSxlt8wfjSWX6XfDKQ6aQFaZVh3KLK/rW5MsMDP2vQ2IYJF8KMXFBG6P5pRgpaAg1/FKmY4Iq7l45LqrsCN41oDQ3jURBgC478q4GBgrARV60baX1iOZtZBXVCsWBfKotw/tag7K42JNRIOwEzoXfUJx6XaTThOjtVjxmyJhZzPwcL7X28aY5hkP9PJh4VNANZNW/47xvWBaOLu45RGpC3HpZwCS4eNTOT8H+SfEbLk23SQrE7mSq1dLSuGeMonK4n1/2W2d/yVA+RtyoBQULvC0B2ATO8n9J32jHO0hv5Ae6qd1A5B+6QkYmNaw5KJ60tTdQa4KkjA2bjfCyNG2gccFK5T7jBByUxMSP69zpZmq2DYcoVNiPMtBCsFvG8fU9qItt2Mg7YRLADCLSR6xynUfqSDu0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(55016002)(76116006)(33656002)(9686003)(2906002)(84040400003)(316002)(110136005)(52536014)(71200400001)(5660300002)(8676002)(8936002)(86362001)(7696005)(122000001)(186003)(478600001)(6506007)(53546011)(83380400001)(38100700002)(26005)(64756008)(66946007)(66556008)(66476007)(66446008)(4326008)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pzNBqHraCGK4ENWkEyXXdx0DnbEwQhc/T3Z3tphso9LVCB4U8Y9ZllVqfP53?=
 =?us-ascii?Q?Isz07dkcLzYYp/tsbdI1iRnVOR51SGOnm1s2zVISAls9baD5KjdO+A0edse7?=
 =?us-ascii?Q?8O40hHzcwvFDSMR5gzRCg/CUCPQBA6AeqTq3azGWLNjd+PpTAVwOV/zBFK0j?=
 =?us-ascii?Q?k76/zeFIhHNMZT2WSXEMH829q4//1qL3HMoLjSvqAWSkmMFehssoALNSUjFL?=
 =?us-ascii?Q?5kbavkdikpMq5SuSrswFpBJrd1tdfHCqLVB5ey9X+mpSxWSYuIcw5TEXx6CA?=
 =?us-ascii?Q?b4wDu2uawkI4mhG4/S92CBBtls7rPaZb1qST4ho7o3qVFz+yPeUM+uuQKRrA?=
 =?us-ascii?Q?G4unRGx+V+PUwaDno2Go0iMuL9+g47YJx3nX4d6TESUWnITwbl16hbkNk9ld?=
 =?us-ascii?Q?Dwzr1i0ObjZrbOKF74R6xwxj5fvKpg+mYW01LgCAk7lm+NvusZAAsEYmp1sz?=
 =?us-ascii?Q?rt/lZiAqqAptIRttEp1ReDJCec4yYm6ha2JDQlIO58B4ansDH98ZBR6kwq5K?=
 =?us-ascii?Q?+uX2fupKsBNgLuivHpl/hqI5Ks+8bC9wQKvMTL90Qz1yvSvT2nMiZYOUHQZG?=
 =?us-ascii?Q?OD86vROPS7BQe9Ct1G0c002z07a7JpHH+kCujCIBPIHhZchH8ighohf3f7ok?=
 =?us-ascii?Q?yVTxmovXwV0FshpKMQmUxbeET5ONbUMx/yW0Ws9QLYMvBj5d5/p4iqUYrWzN?=
 =?us-ascii?Q?ROJGeSF8hqw452tRE0cLtnBQDTJXQ7Owq+diV891K9mlt9XyuYn1NBNR2a+0?=
 =?us-ascii?Q?9q8zrDKq8R4hAOiWytxiLhCqSq9/K50jh3KB0PtR2ZzZ206N/ZouXzXfM93B?=
 =?us-ascii?Q?Cve1BW4dm8s47raPbK6ovfjel0RXuf08+3FIyasBrwFkH7XKejOK+Bg8Pfzv?=
 =?us-ascii?Q?Gr7siU5DM2HiTkPL/qz3T8XtoX7mw9OzlvDBZno7iDVJ8DBMEUvjRWN3KZXf?=
 =?us-ascii?Q?7AWHM6zxAbYZyKHpZzAPhMJabKTbTTjMFFx/EcD6RE5JM8umxdqWIsxIr/T6?=
 =?us-ascii?Q?0gWTxYkdbanUht18IiW8zUTo5iPzff7OjEzVO/7Ww4eXrq2lHkDptrpfWjuA?=
 =?us-ascii?Q?HEbrH4gN2MHSnL4q93GsgclEMQRxIhCUtnUwNU3gqH/nALyhE+ir7i0lccwG?=
 =?us-ascii?Q?dQbfYacl3oqNPIN8HkkLwVw3mLsI3a3DBOQzvqki+hk2DMhWpQ+J98Px8Thf?=
 =?us-ascii?Q?RKaR7Tju09m8vI3wzNl/RP7myVfT/2wL5tDTr2uA1MMSBQ3EgFP4Tpz1Yfly?=
 =?us-ascii?Q?vhp2BbhezbuGnHIFthmZBl3Ix1TQV/VdYXnLaKylIT+0BMC9NETex9zk7Qmo?=
 =?us-ascii?Q?gXUSfgL5bxp8U0WWg5FwTf/o?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0f39bc-1967-403e-efc6-08d9298c1e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 08:13:23.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGgieFHi3C3BHUHmIH70JJYB3+LPcXOGuKGVSifAK4uw04DZvpkJke4ymHexzgm6xp1+JKPyVAM1qcQROdJbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Alex
The following patch series were ported from amd-staging-dkms to fix VCN IB test fail.
Can you help to review it?

[PATCH 1/2] drm/amd/amdgpu: Use IP discovery data to determine VCN enablement instead of MMSCH
[PATCH 2/2] drm/amd/amdgpu: add instance_number check in amdgpu_discovery_get_ip_version


---------------------------------------------------------------------- 
BW
Pengju Zhou

 

> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Thursday, June 3, 2021 6:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>; Zhang, Bokun
> <Bokun.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/amdgpu: add instance_number check in
> amdgpu_discovery_get_ip_version
> 
> The original code returns IP version of instantce_0 for every IP. This
> implementation may be correct for most of IPs.
> 
> However, for certain IP block (VCN for example), it may have 2 instances and
> both of them have the same hw_id, BUT they have different revision number
> (0 and 1).
> 
> In this case, the original amdgpu_discovery_get_ip_version cannot correct
> reflects the result and returns false information
> 
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 99255c2f08f4..f949ed8bfd9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -325,7 +325,7 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
>  	return 0;
>  }
> 
> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
> +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int
> +hw_id, int number_instance,
>  				    int *major, int *minor, int *revision)  {
>  	struct binary_header *bhdr;
> @@ -357,7 +357,7 @@ int amdgpu_discovery_get_ip_version(struct
> amdgpu_device *adev, int hw_id,
>  		for (j = 0; j < num_ips; j++) {
>  			ip = (struct ip *)(adev->mman.discovery_bin +
> ip_offset);
> 
> -			if (le16_to_cpu(ip->hw_id) == hw_id) {
> +			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip-
> >number_instance ==
> +number_instance)) {
>  				if (major)
>  					*major = ip->major;
>  				if (minor)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 1b1ae21b1037..02e340cd3a38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -30,7 +30,7 @@
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);  int
> amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);  void
> amdgpu_discovery_harvest_ip(struct amdgpu_device *adev); -int
> amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
> +int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int
> +hw_id, int number_instance,
>                                      int *major, int *minor, int *revision);  int
> amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F13C636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 01:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51DE10E027;
	Wed, 22 Feb 2023 01:27:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61410E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 01:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6bWL6K9liE30W4E4F0asYY3ltfLU7tSeddz876f14l3+qMEIv6IQD5oDXE3Zb0izg374eAm7pgilAxYmL39Uo4DV/bwGQYNlevp5u9cHdQ5Ue2+GsSNkX7BLlap6xWNtHXtsqmpAyZh0RMIrP+bDP5br3XcpC0Hii+2cfNwGXFugLGzQ+MzJQeIf9mAfbLYMtikHUhyvbLx7eKPSh/iiK0gw6hkMSI8iSoKROM8fYzl4GFssDeIdaPTCyTe4jwpFBEVYr+QZfo//tTy1cxMnQ0+uf/5W3aekKvs/MVhxJTtcJIMijnD4Zj+/1LZuXftT0UN5H20ewiybn8SXBAYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJkoFjFRfLaNAOva6AdYjmzEtyKMJQp1iic+c1/7YR4=;
 b=DMgBxWGKct8pAuDt0A7RmwuAzeH58xeeIPzf0wy57mXQPJ4q38qp13HRvYPIqnd2g/sSTV4YkqlmyRI6VKIB7Qbg+rnlYJBQXXtXzTmR5g8VyLIaAQEgYM0gx8AWn+Td5GdbCDSLx9X5oEpc5+dLtmX8a3Xu82usg2xo7WszuDoJrEcqyYmqtcNgqyQrtgn6wVDQqkwxtaFYN9A+g33i3Y4EkzDmiCrWnR1CBHneKsV67O1oh4j1EsJVUvSrUqZ/r4e7fn3KQu1THmTZR435PwyH57/tHDxK9AWCvJPqYxlbksFtqW+K6tGSwYNv9EUPQg9CBad9raIeviaJ97/4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJkoFjFRfLaNAOva6AdYjmzEtyKMJQp1iic+c1/7YR4=;
 b=t+c79GTOYBNEY36xkRnsFQNTC7VWOn18qKXSR1pM4COJw0cv0DuAO/LfF1LS5twvCiI6tNRssbx7yppGINsomnbK1+yqeoroX3Iw3IHSl1EXDZyAHlXxqApJ4KAUasJg8dRuVheLKJBxqgKaGuAIlyIOc1cMNz2M2/mvmou3AyU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 01:27:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:27:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd: Allow dGPUs that support BACO to use smart
 suspend
Thread-Topic: [PATCH 1/3] drm/amd: Allow dGPUs that support BACO to use smart
 suspend
Thread-Index: AQHZRWhJe5SFWW6Jw0WUpq0bQWtZy67aLKHA
Date: Wed, 22 Feb 2023 01:27:14 +0000
Message-ID: <DM6PR12MB26194900C27CC79A94B40253E4AA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-2-mario.limonciello@amd.com>
In-Reply-To: <20230220201618.25962-2-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T01:27:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7bba5d86-cdd7-4d01-b0b0-ceb924cf987e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BN9PR12MB5051:EE_
x-ms-office365-filtering-correlation-id: 38ecafe2-cbc9-49ec-941c-08db1473edce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55T9qcfZsdZsX+cqiwD+E2YNuc50+bpsyaE9GQQ97v090zU6M+1DtekOoL+vChjB1cZHRrKB30SLS3KWncRFpFbyY0K0HX7PjrTJOH7O5eSfm7gHsOjOjU1pfc/d/FOerMaf/WJ1C7/s0ZYP4f0CqQmMskGOTsIdzD64XWeDPsNRU8kx30znI9uzj8P0tzjEnSMsWbHkU1Pi/mkEbpJ0Ryb6BfD2TWyP5wBvA8KlQzMB6xaghp4Hq3cRvMvwaaLRhLfA3LbagiT8Q3OwQuJv5cTTisptzz0/8ka5PZ+tUj0I6QOJspoqdThGboOvAdzudL5mRxLTrmLTi8N8lAWeOei7pxfEUAtyU8vrS8i4rzsgJCMz0eybLJ0wxIryNDhm9eJgm4TFpRx+cPq7HqjUDIcnDfFop/QaYPlkGAoUkl6WnVabtsgK1uOeNPlGtTFSP9qdYrQhtHDVa7ldzcST71u7rYpFd++lvhlfVZXUfzcspe+azVgYqJ4pl2AHrQN85uyKIKZHwtXAMLo10tGFzEW4a2L8EGTEy1V+wk75QEDwyDmsS9GIf2HTRYJ+Zu5cqjlQ9wsJsQdCYUfhJguP2OfcFdPcc5K26226z8TyGNmjlEO2xUJn9r4/y5xlZY0wbk1DdOhmOi9J7Z81CaYlCLMJJvmRGSTs1bu8vOBKl1Xc5TUt10GZHCozm4Ad9wwqmH8tVQVlAlBPNCRBoKQXjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199018)(8936002)(5660300002)(4326008)(52536014)(41300700001)(38100700002)(122000001)(2906002)(15650500001)(55016003)(38070700005)(478600001)(86362001)(7696005)(71200400001)(186003)(26005)(9686003)(33656002)(53546011)(110136005)(6506007)(54906003)(316002)(83380400001)(66946007)(64756008)(66446008)(76116006)(8676002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YE/n0N+xUiqVZLxpFgDQ0rjAZ7nzPBdqB6tzRVc9xboBV+IXPjGCx/BPJTml?=
 =?us-ascii?Q?21z9ICZKL5nI9iU9EOsGEwnM+ESZYBMU6vqMMXLz0OmN3XS5/tVGSIXfcuiQ?=
 =?us-ascii?Q?+Xz3KROojVjMGTze388d4feIOAakAqc8ImvqP1nHe0DKVaQSeuGNooE8jTcg?=
 =?us-ascii?Q?V0w0LZys9BXvZ3e1VkA/fpizxk9HhSTUwXUWonWApfJmVttHJ15wRJq4Ty3T?=
 =?us-ascii?Q?gp0BHu1pxqhp+o1tMwyNH50GP/Ffn6y6j/ZgRpDNwYu+4Lu8RizUPM14tI9/?=
 =?us-ascii?Q?X78N4AoLyJzC8zL7kyYlEC0atQJr2P/atj8XZzGWMYMq81gD3O4RmDKVwidN?=
 =?us-ascii?Q?gjt6Q/vpYXNtio5kIbB1U4PXQwycILTQknjFP2EeiJe928gPB5yKwrnTSynO?=
 =?us-ascii?Q?Ou0pKsCbK2Fa/BLbcrfZzMwR7et4FM8DdMAt66yGJ4NeDGybvg3oUQzA1UTc?=
 =?us-ascii?Q?nOBW623y/BY+X+8RYx/r/smH0lDSVQyZlF0/dTkK0DLzqheyDRfu7ZL8amwA?=
 =?us-ascii?Q?LcXtRIv0rYsE8GrGT8nF3xq6QuzaUBlSxGDl80TolaUNbDsvg5l4NsjBG/y+?=
 =?us-ascii?Q?4RcGf/gAAZFAKqr7F6KRSvi+AdCICrFhsQpE4UISJTFozO7qNFtE3dfPx5pL?=
 =?us-ascii?Q?GNuogSvSyqiegTPHLzg6ZgXC5AFAs9Rvj+uiqY1Z086FFqlI0BYDxUqePH4E?=
 =?us-ascii?Q?wEElW0o4o2HFJn5Byb517A3dKv1Nre4ZAOCJXrxdVYy0jep9N+DlJNh3mjf5?=
 =?us-ascii?Q?Nf8i0YheLyc7HIPBgbgx+A0FV7s7AY9HPk6LAWvBmnOxdXalt4t3CNbGIekS?=
 =?us-ascii?Q?eql72PAj69hCPmWaU4v7cu9/enOD8Ji9ixXqFHfYJUCn+oFodt2eMnpuSQMr?=
 =?us-ascii?Q?aDlyA/Qv1Qlxq4lAb77Cvcd0ZDRRxsXPF7wQEuAiw2C3GFaEsontGjhKONvY?=
 =?us-ascii?Q?MyEVNgGwAqfUfJ1hvFIAGIZ3doS2zteE8EzBw82XetIImBLTABfDBQ/6XzV9?=
 =?us-ascii?Q?Fs4jJS2+8fLC4SVaswoM+oIlUbzW/MgliwtHV9jfV42gPZw82rNx7ySoFeVU?=
 =?us-ascii?Q?PNw4onYPQxVa20WpnxezmwmXD1b1wiHZCrNeBw0uBDy9I31wdVo/yKCGcHyB?=
 =?us-ascii?Q?STjmrq/y/oni1kD8kVhlYXcruUVwAR102RT6Ke5DBaOCRrtyxtlk7n/zkbMr?=
 =?us-ascii?Q?tH3Ty/PmXX61XezLN0Z9UNHzdn4d5E8Hn625BZl/7EsJROReBTKaevkQ8mLA?=
 =?us-ascii?Q?yMBAyy25KU4D8RK0yZBCnfqIdCn0sio5myUmm+NC2Jiiu6Vlyl5H3nKEpvb3?=
 =?us-ascii?Q?FGpmueApjRjmJZEBW33xiWP2VKE1a+8lrv9j0L8DpLNmaRgfOeazpj96XEyU?=
 =?us-ascii?Q?KvhwNiZu3/y78v+FSzdtLM5BK3WO+uhRCyKCByaM+XrTfXBl80fLkX9NzKyP?=
 =?us-ascii?Q?jry4bPGfEd3NDVs75hxdzgK13m1Oe6JfEk682JAU218zQ+1hDzfxl9fAvPBH?=
 =?us-ascii?Q?RRhUGL/emPHlIm8JmqjanTG93NgTDvyTgadpgwnuJHnLC42uDRw0rU5pptHH?=
 =?us-ascii?Q?IeswgPfVOTkbTna/U2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ecafe2-cbc9-49ec-941c-08db1473edce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 01:27:14.6433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuvtjhOWF8j+HpC93K/iBw1knr8li+Y4o0KgxzEI2WkNfM1xi7nVqmh3mV9rjebS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
Cc: Peter Kopec <pekopec@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Tuesday, February 21, 2023 4:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Peter Kopec <pekopec@redhat.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/3] drm/amd: Allow dGPUs that support BACO to use smart
> suspend
>=20
> If a dGPU is already runtime suspended using BACO, there is no point
> to waking it up to run regular suspend callbacks.
Not quite sure about this.. Since the expectations for runtime suspend(over=
 BACO) and regular suspend seem different:
- For runtime suspending over BACO, part of the chip(SMU, NBIO) is still al=
ive.
- For regular suspend(suspend to ram), the whole chip is expected to be pow=
ered down.
That means the resuming sequences for them might be slightly different. Not=
 sure whether that will cause some problems.

BR
Evan
>=20
> Cc: Peter Kopec <pekopec@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1f6d93dc3d72..c3d3a042946d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2187,8 +2187,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		/* only need to skip on ATPX */
>  		if (amdgpu_device_supports_px(ddev))
>  			dev_pm_set_driver_flags(ddev->dev,
> DPM_FLAG_NO_DIRECT_COMPLETE);
> -		/* we want direct complete for BOCO */
> -		if (amdgpu_device_supports_boco(ddev))
> +		/* we want direct complete for BOCO and for BACO */
> +		if (amdgpu_device_supports_boco(ddev) ||
> +		    amdgpu_device_supports_baco(ddev))
>  			dev_pm_set_driver_flags(ddev->dev,
> DPM_FLAG_SMART_PREPARE |
>=20
> 	DPM_FLAG_SMART_SUSPEND |
>=20
> 	DPM_FLAG_MAY_SKIP_RESUME);
> @@ -2389,7 +2390,8 @@ static int amdgpu_pmops_prepare(struct device
> *dev)
>  	/* Return a positive number here so
>  	 * DPM_FLAG_SMART_SUSPEND works properly
>  	 */
> -	if (amdgpu_device_supports_boco(drm_dev))
> +	if (amdgpu_device_supports_boco(drm_dev) ||
> +	    amdgpu_device_supports_baco(drm_dev))
>  		return pm_runtime_suspended(dev);
>=20
>  	/* if we will not support s3 or s2i for the device
> --
> 2.34.1

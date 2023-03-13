Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E951C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 07:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA2110E473;
	Mon, 13 Mar 2023 07:22:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA4410E473
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 07:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5O4w2t02KbvG+Ub10BuPpVmNN0smMGRaqwaIVvlzj/eZuM3q8ISKf1RJQVhfMAROiF4mVcXhNqDuPvlqfv5zPD9D16qS0nC38Yq6voHAPg1BGcHF5wAK6dzApmNobkYncDK+rs3GsOl1pwksPe58E2emWaXrdIQsOtphFcijJdGTv5LF2wt6oz8k2bpSwjVJLyP5jixYhO7PUjOlH/0FDKLYf1rAbRfPDjdPGO6KT9DfNklNggyp2oVJzaEt0NTo2OLxhlWAaKMvBSu77EEUl91z0b6sZxtqhEoqvhKRaH8b0iVOMck3fw9KmlMQnRJaH36bFsKLO2w6Mi7aQTVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGMp8JZab/EaSdIOGjzf9UI43s1MOkg3GnXtnjI4grg=;
 b=JBHcDATaROBhPgRhzBQMORTU7C3lOtCo5ond1s8qPerMs7+JLj0nooHfbZ8Hkbz0tPTCPUF19K3s0zsi8WQOxblrpSpRUkU4irEpfHSuiTFHPIan4J3BFxoWdiSoqrKoTafhWENDLHERj0o8tzLrGFE0RyvLqvgg13iGspbvmhnT3hN06SA8xYWNkcyiMZop/B68Uf1OfymHoBTcr5nXPxQOaO/zYZX/4v/6rscaG6HSXlQASbIvJQVcNsJEW3xrSCv18K99IO9Emj6LnLS6iejIp48hdxPJNDCtsXAzC5MyDuANXDAMNl4iml/7mUwrhUC6l/RlCCqh4zpaDdq+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGMp8JZab/EaSdIOGjzf9UI43s1MOkg3GnXtnjI4grg=;
 b=lWzO8uZkgfTaBWBmIcZazJiu+CkuuByfrov3GmmwpZ5UZAQIgVr+EN1ShmW405G1gj8qdRhI5amOJVACETQFa1cfpcNcBwANgIWTq3mCvvo03oa1HBEB2ncFAbGfUKfsponJRzAulwOPGNGgcJ+9WWdiqowAc1eKFoNcQyv9rTY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Mon, 13 Mar
 2023 07:22:41 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 07:22:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/10] drm/amdgpu: drop ras check at asic level for new
 blocks
Thread-Topic: [PATCH 10/10] drm/amdgpu: drop ras check at asic level for new
 blocks
Thread-Index: AQHZVU1s+O77l6swlE6+hjmXp9Gbaa74Tn4w
Date: Mon, 13 Mar 2023 07:22:40 +0000
Message-ID: <DM5PR12MB1770B1F9EF83E2F1C81EB979B0B99@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
 <20230313014403.21903-11-Hawking.Zhang@amd.com>
In-Reply-To: <20230313014403.21903-11-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-13T07:22:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33752465-80c0-426e-8813-522bd3cacaa6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-13T07:22:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 57ff8c42-4a0d-421e-98c3-bed11313e923
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|LV2PR12MB5749:EE_
x-ms-office365-filtering-correlation-id: 447436f0-41c3-4979-449a-08db2393bb28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ii6hwfjStOY4UOsGAaNjwx7k+J0OiTdhEDyFZ7irPJqH01mQXLfyXVBZvEXVvoRchlp7JXpkZ7Y0TcRg6a7NqleaMldBs72dhFv08fu+8f5RTYQCwge0VxjJFhy+XHhY+FXxmczWc0wdhYZbCbuMlFVi1t/vONWx80aklnIomJSUdPjLzDwnIsadwny2HGdj77WqC8QlTe6jt03Pj5p9GzwlHk4IIMIviVGZxwPwQE490vkyBW4nC0O66RcY/mT39rWwkqV/nVykwi6BBpglKPQ+MOPMdJmxOGF1qFntp+cs1VB4GQ3OiFc5kXh+qTGADo/1WqKafCvJFN+0iAbUbP5hnYC9skXnMqrAJjiW3P9NM+u49hGlMsSrWt1sfkjQ/i3eSnX/nexMf3NvLwIbquvcBw2NCJYqUJmQWVpplK/4PIykNZK6hVfLJsUi/OGTsWvJemAWSXsZ6lrZdlm3T/Ihr6Z4NBNVrJ7MpZ+fK33DzdtmCNjer7gebwyWV8oWFo4vc8HrMt0skkSkMixn5YhMZ8Wfp6S0DHIBQrECTNpZc8lYsLQ7+iJr4b+/bmWdXjA08//Ul+kGXXJCU5bscN16sJPahdlumprxpzFDwfch5KiTnrN5eSLrcS9X8SqVkmOMSWMD8NaB+GqcVO/zycG5bju0VDf/XPpAyUh3Yf8JcLc/2q0no5eMnBA7tq7m3Zp0yGK/defRQgNqdmY3sQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199018)(2906002)(38100700002)(122000001)(38070700005)(7696005)(71200400001)(6506007)(8936002)(5660300002)(53546011)(66446008)(8676002)(33656002)(52536014)(86362001)(478600001)(66476007)(41300700001)(55016003)(6636002)(9686003)(66556008)(110136005)(76116006)(66946007)(64756008)(83380400001)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0cWki22E1o1m4gdYyaiZ75q/9FHyS0mCxUUaC8I26kf5K8TJPl/Nrq08xYUo?=
 =?us-ascii?Q?icH7OBoCcLJ8JjCAeZl7Y3KVmlmrGMAHIHcbv5uuaAO2/Nn525p2oeD01Zu3?=
 =?us-ascii?Q?ulUF5bJhXsJZCn+NnuJyH+NBtEB1GsPu8vMLxf0YMTe1Svjxrr82j1Wd63y2?=
 =?us-ascii?Q?r39fViPuVuft9vMF0omWUasO2aFqGIohQoTbO3qYsIiE4T4n2f3wY9A/YYIG?=
 =?us-ascii?Q?egNvVsgwIm3B9WBSqwUFcEtyPb9MRNmcE5s97OFQZ7LqLbgQd/SA4DNaBhh6?=
 =?us-ascii?Q?X/6ILHauJ6WZ6g8bdV38xc6E9kINY9ABZ23pq2RHxXWcsJWtYmsgeKpCtgRy?=
 =?us-ascii?Q?6hw9v7b4Vaw7V8byBIV4ZI0NkDRahNp8wJFWXBaZrPAuV2ySsn4qL0Fh1hpI?=
 =?us-ascii?Q?DodtYKH/z3+ZDXvFvtsdWc9ikyY0+A4HDkx5HMy5w/FLskiANZmxRuFshV/e?=
 =?us-ascii?Q?EajvZCnhsUERVmijxmQ5QGoeSIadE5/ky4T161iwoKBFKCtXZsGSkzQMikGR?=
 =?us-ascii?Q?e0WMvD3CM7HMsVfYruZJMq9K9HBFBWNtQ+GWUV/kfjhYMRS9z6lpeczxoa/k?=
 =?us-ascii?Q?v08t0j71rniEUBlhpQk5RBf1kZBC6xECxo0VDP2LozBCUbFoFFQaQkrfk093?=
 =?us-ascii?Q?tmD8AQ8KPlsHjHOnPThy8UrGVLKX+3RMBSvJ7dKxZHreJqE70FRIeoJ8tl2U?=
 =?us-ascii?Q?jWJZpp1WlTZ//QtZ2qKqUFiGfGwk8vTBptqWyzVyNzoz7ZkplH9EHl2Vv+Rk?=
 =?us-ascii?Q?xEbMVK2brQ6qnjUt11ZgyRGjjh0Mallf9D6/3fYXW9cdWJB/ClVzxrXeYq0x?=
 =?us-ascii?Q?+x0Tr0YU2YHvqfG0HEAr7AQoXamBARErp8mZdnSLhk4nigtk2340nAcECeyk?=
 =?us-ascii?Q?UctRGcSYrCB4hl90m5h3fJkTx15E6lWoHA5MWmjpmZl08rWoyXHjs8ZXinBk?=
 =?us-ascii?Q?p1yvHYFwsoP58QFd70FfAJHWkZv5hAtZQpe7YxB2gRdNWXV7Xmg/PsH8wXKg?=
 =?us-ascii?Q?JU+0lVzolyFQsM82nQwYqeUiF0VkVGyW0GOBe8rBSp4E0JBmHYv3QaBEPg8Z?=
 =?us-ascii?Q?HyiZljZVFbUaHZULNirQqlCN/Z0yl/ZbbIReAUfdqHI8mNXLA1Nr792C7ePP?=
 =?us-ascii?Q?Aq5FMnUaY/tceG0HBC98vVB4MZoPgfZLb2u8il54OogtHbrMVrQrQuFET8+V?=
 =?us-ascii?Q?icEAU/F9KitbAmJYgJ3+H4QXPAx/ENfYNWiCD2597MT2cYxRLSzXkpARdiWS?=
 =?us-ascii?Q?i9MXYysOYHdcheo+8VNrgdEmrHCOH0Q7n5OjcZDzIFuwfyMwYcEXJQjWBsv8?=
 =?us-ascii?Q?uM9Rd9WZR62mCJV/dI8HboyKvDIBFuSHirwdeg+0ufO1xDA+E2zA0uvf23AN?=
 =?us-ascii?Q?vPYxetR5WcU7AcfI39nBWgeOkiXTuT2yUkFfSY0XOrjDP4za8VzJ6gZ/+T4U?=
 =?us-ascii?Q?F0+ji2V2/nfVQi0SBQjWm/YzTNBrckQZ9yrQs5jiJrUwHf3fgeuc2P2gPFZ1?=
 =?us-ascii?Q?Q04d3+VWJhzvNFCOcz2gZXZcz8vdGO+2bdGAyuF7lMcWTvrpuTmvI6GcXWnt?=
 =?us-ascii?Q?Mm+MhJOYTXktkUA00LRv2VSzw2wOfpcRkTuSJJPEY9sGU3POEN16U1S2j5Nm?=
 =?us-ascii?Q?bO8ufQQyDgcqPHUqQieFI/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447436f0-41c3-4979-449a-08db2393bb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 07:22:40.9731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YDbHdSy8w+rRP78b5SLM9C+x+B097OjO+ZoSrYS3YcIA2zlPk5hD/SiH6IQOEDs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

The series is:
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 13, 2023 9:44 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 10/10] drm/amdgpu: drop ras check at asic level for new b=
locks
>=20
> amdgpu_ras_register_ras_block should always be invoked by ras_sw_init, wh=
ere
> driver needs to check ras caps at ip level, instead of asic level.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 834092099bff..c34f51be793c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3076,9 +3076,6 @@ int amdgpu_ras_register_ras_block(struct
> amdgpu_device *adev,
>  	if (!adev || !ras_block_obj)
>  		return -EINVAL;
>=20
> -	if (!amdgpu_ras_asic_supported(adev))
> -		return 0;
> -
>  	ras_node =3D kzalloc(sizeof(*ras_node), GFP_KERNEL);
>  	if (!ras_node)
>  		return -ENOMEM;
> --
> 2.17.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DAEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 08:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2EF112882;
	Wed, 12 Jan 2022 08:27:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D9E11288C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 08:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP+I3rvIg2lL2s1lwV4wZ6oBISnpwiSGL6hqjvJe8nCLDwYmvU1L7mSkECaqS8cUyizSd+eStE3vzcRLwLWKX2igGqcR5OjVreSNfEWIdn9JWpKfSlBHbOB9sTDmSHWc+mMeqmQ8LEDYdZMAEhJ7rjONaTp6ZP+e4zBmuhiqtaMia+HFzAsB+4vF9Z0zWwRKLAS5wA+XQ0LkMJO+gnwlauwmGtgd54NKWNq1/GN1c5Ei1bS1yvwAggYTkuAyST8xNny8lr4yzmN8XASvRZyUe6gt7B3qmQqozhfxZeMFMQodI6bvDiLWNxevz+1KQBSNI6eTzFq79PqjJQoDeWrMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A2b77bl+4xY9lXjJ+oX4hAswu5CAZhQputPQodRczU=;
 b=RwcbZ1PKuiNCjdIEdQjcVvgf+Rh2HR5q8lC29etIurd5Fr3z9VzdyKgvFw4BKRoFcgm3ytQ8o6dMSP2RF1WROCnEqg5YZwzIfAfIf3P8CWJrMn8BPhlj3sVq0On7jn8Eo5HleWcvNTG8508sG4YfICrSOr8LCCtXAioZoEu9uhmjj3eGgQQF94OT4TMDVX3BYPGbVZ6Yfi2dsIawlXOqvA/wAMNQdMUb0FZD3zC9O5Rmvz2QAEz6HU8QPPVIOuUq2NZVzvcG3cgsTvbSFRU/KfaP3HIptt23xVbaoon0/t6fRHNrct+f77oOBAsd98E+jENseXtce80G2M15iL9HrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A2b77bl+4xY9lXjJ+oX4hAswu5CAZhQputPQodRczU=;
 b=34CVsYUbpWepvl0VdEleflyLzCZ3HvbFpCubmy6zKqInu/6FtX8kRv6pSVIXV+poMW3h3SrusLV3BGtmPyBO79R5PJDD3nFl6RRReN+rRRKKdoIolqUPUW5lby+sbUsX9wtyRxmIuXvvwIMFuS6UPtzSE+1NuQ6Ymn+ol9zmeVs=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 08:27:41 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 08:27:41 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the SW
 ras function to be registered only by asics whose hardware supports
 the ras function
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the
 SW ras function to be registered only by asics whose hardware supports the
 ras function
Thread-Index: AQHYB4jPo6bo0aLe4EKLBFiTNUB2b6xfDEeg
Date: Wed, 12 Jan 2022 08:27:40 +0000
Message-ID: <DM5PR12MB17700A1500D5CF6D796F7BECB0529@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T08:27:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=17f849cc-f2e6-41df-b2a7-e496fcf15c77;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-12T08:27:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 12b008c6-e273-450e-9f44-cf91732b4066
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0255ec9a-fc0d-4ab0-47d7-08d9d5a56644
x-ms-traffictypediagnostic: DM6PR12MB4155:EE_
x-microsoft-antispam-prvs: <DM6PR12MB41557005A2D94DE9EDA2BC16B0529@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXreSCuH66yTquLeksZQFGIQ/DWVm1obLdy7SFsxrnlNQ3Y4LV4bDiFvW/15Hu2D/uGRZyMmR8i/s4Zw/x0vrwt8CZwwr6Qgdf6khPJ7ErKwxauvXoP0+rcn5j/+NUqzHCmOIxJR87tl7RV4j0vPkT0Q8doZMQXOk6iDcPmzwfoqhVD9Nfmp5M9wvTk7JjpY01V2ndqwQruayctbqAjCJnyT2+db8rwlyiyMvRTPb624NLXIMn1/Bw//n61NRudRsYQ6GwaItyS8dGEUAoF9OHK8z8f20oMklC/hO7e8Ynu1CTutQq83Pnk1NwX2wC9VxLkjgw2qIo0xeckxG5HBHuIssr+jdj74gHCswX9QVanMDGmHFMnLbr/bP7MSowvD7L/Qxzr5DwmJV3whr12ZyhzdfKUjhM/JyerE70tmik7V57RQbv0I6ZxBXi3CKSruMxw9xmKGxVLBrLvwamgx4q/FYKh4tVf/4Fg5wNfKm1soaW0qogIvJSqzGQcMi2+c5hQMme9wrqlH8YFDSPw0lxiuHfsvUKwwoWEishBw030sS6NHWkQ46TtyY8NBCvDO501UF98/O735zRgTHJFMfeARgyIjLAPIWlev3i1MkSxs1WiA9OjcBrLJSbmgw2JwWmv+K0mxLoC4iNr/nQ7mCV6LBhMkFxSLXoHJz4HnsiLLuwZuRWzzoIZeTBZ8RBCtTkC021yePbqO0YcM1NyQpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(316002)(66446008)(64756008)(110136005)(8676002)(6506007)(53546011)(54906003)(66476007)(66946007)(55016003)(71200400001)(9686003)(8936002)(66556008)(26005)(186003)(33656002)(83380400001)(38100700002)(122000001)(5660300002)(38070700005)(7696005)(52536014)(4326008)(2906002)(86362001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uIuhxjTfEERXBPnh3hAfGV0zjLdW4ZE6mHTo+max1mtyWf3u95QbqcgVZrOl?=
 =?us-ascii?Q?ADhU3i8C0gIA/mrI6Z8WVRlC5A/HPKm0HAlvjtOMfVGwR9DcMxdjbwuhdX/i?=
 =?us-ascii?Q?lNNbx4DWRPviLkcCGYp5pnxDOD1ZS1C1LeKjHhYLO5PQIj8yZ7Fpq6m6NbOn?=
 =?us-ascii?Q?Ha+6b/gP+ItPvj6A/1tQSmIh2pLslVT+KpB2m4o5OyvsI3Id25EjdHxbCcKV?=
 =?us-ascii?Q?mNti+vhjJy+6TW1qa6xuKENhycn+3WoWsqp/HkauuX/uvrw9dlSfkV4Alxh/?=
 =?us-ascii?Q?7M8O6qZ9UyYhVakcDNH5MtmIIE3KeksDLwd6vgtvHGDX6jBWeeFpgOp0QtWd?=
 =?us-ascii?Q?oZpgMoctPk8AEFobsNviYSBNtTJlfPskcjBiUenIETJA4D7uibWLOXXKboSu?=
 =?us-ascii?Q?iad3p5yqAaj9q6i94doA4tCdOs48cvgDdKuttMf/xlhXgDtUaCq6jlzO0E4p?=
 =?us-ascii?Q?+ugEcd+Y9c9ruqhhjvoT01L3i27HE+GNlR9pMFU2HXFbxyUX8KdSc2nwK/+Q?=
 =?us-ascii?Q?q1HoEOJKNXXju0NG5wvGEq5DVC+dE8D7Ft/vt3GurR4p61v2wGvsqGDradFc?=
 =?us-ascii?Q?u0EF8cYM1gKUbYY4KqcsfQDaM6TR9ZzLH0mUW+1omFfR0KSCgZ3HbXKkcbtI?=
 =?us-ascii?Q?WP+a9QyY3YvMuvwztx/5UkaY0xmq7sokDy4c8sVnRv6ObW9n/3ms6Z0b+BjZ?=
 =?us-ascii?Q?sgRW3IGkGWBtInYGNgm4KRvxnfNYdNoNa+cy8V2ysy/WRa1MA5ltfmwPI61Y?=
 =?us-ascii?Q?JQvltrzdSQwkdAY9/xtczFU30lRgRvstHI+Zi5RVXXP5VNR3cCVxWxXfG/9D?=
 =?us-ascii?Q?08XAihg9UyoyWVfOCT2TN8/wzHckfzEbNyoa6Ey+eBxhQUUvkO4zKbigekvt?=
 =?us-ascii?Q?/oYxHdJtRgxmIsGRRpw9nmie6JIxG5yAIHoGfH6PAO1JtRo03WDOqACsSHwW?=
 =?us-ascii?Q?VXecpBo90AhOt9qa/EezQLvjunDUfJYFr9ZVAvNGl2sylTHorn7TseIGh8hN?=
 =?us-ascii?Q?h9y8PPQnxYMXSqJ/DlU8Xx/RnAzbJ9HiRYMTLDXDf/YvW3YHKxrwDmdgGaKy?=
 =?us-ascii?Q?SKUBoH4MWI1v42MsyvpsBv+vSZKkp4m1k6vn+u1eRwlZOwk7T5rSMSKCYjmo?=
 =?us-ascii?Q?qQviBQRBZAprKgtP+LOm5ucN+K/tXdVyG6n1f3mOKh6Edgn/r3pn/MHCA+f5?=
 =?us-ascii?Q?VAT/VhXABsJDXli8EWD9yUXFOkr9bgqKXS30bFnoIP0DcnnQ65/Xks2NDHvT?=
 =?us-ascii?Q?mAF8BLrfus+tOOXeFYO31TAgwYxHR0Z3WI+pVuuV/w6lqgFpjQta1h/uG/2d?=
 =?us-ascii?Q?WOY1buSIx9Su90cNWRBW+l8WhOD+SCaV3ihRE9iJjivhAbGkfbuBqKiIqJqM?=
 =?us-ascii?Q?wgAH4Mjnknea70badvHdWB1ZlnLB7lsx8QIvSxtD4mFJcGfb4LtfrSnAWbZO?=
 =?us-ascii?Q?xJKzjWvYBI98qtImNxPRD6zz0DFBnR/AqWPAiWrd11hsr6AGXgZ0VhFc1xtZ?=
 =?us-ascii?Q?Ljs4WfZ/HP+cUE35m+XujQuk6bCSVOiK45bWTomD4DEu8KezbkUngyJ09I+X?=
 =?us-ascii?Q?4trF3FbsN7tmwhWFRVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0255ec9a-fc0d-4ab0-47d7-08d9d5a56644
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 08:27:41.0144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: He+sVRs7T/5zUbld4agbLVEmKjDNU8FtTma5Q2PXWVXX2L0lrdyn1yePh0PJ9irK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 12, 2022 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Add a filter condition to restrict the S=
W ras
> function to be registered only by asics whose hardware supports the ras f=
unction

[Tao] The subject is too long, I think "add ras supported check for registe=
r_ras_block" is enough.

>=20
> Add a filter condition to restrict the SW ras function to be registered o=
nly by
> asics whose hardware supports the ras function.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b1bedfd4febc..62be0b4909b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,7 +2754,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)  {
> -	if (!adev || !ras_block_obj)
> +	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
>  		return -EINVAL;

[Tao] Can we return 0 if !amdgpu_ras_asic_supported(adev)? It's not an erro=
r.

>=20
>  	INIT_LIST_HEAD(&ras_block_obj->node);
> --
> 2.25.1

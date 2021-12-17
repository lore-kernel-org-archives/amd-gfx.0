Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E05C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 02:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9295610E30E;
	Fri, 17 Dec 2021 02:19:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B95E10E30E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 02:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fseIblajksub/eaTAYYxZyT8mQUw83nyfb55aUIebq+ixlK04Z/+uI+pIrXTXX3Y5A9YkHE4kBgV56sURmrEJ5nG0IZcF8ZHL7Y9pYHzsIcEthYjv5Kg5u4YIC9Qw/QoM3LSIsT46CfJBhysAUM6SUr0nVwW/izgMiypmPTwH2gjmT5qJzY6ohQpTw5RFmOauB78r9avgf0tr0YC3UruYJMqg/sp0xJD+u9C/xJ21+HDnDC/VyBOHYcq+XEbW/viSc2pNB54tCq3wvFhxzolRdeSbaf3NGazsYMhaFytqsg0D19y7Znoo3nNrXp2FDTtBh6RuGxQM27q/pfoTQ3GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51ROYfulmm9CrVWry+1z+JqCf1eQSqxiEOEyJgXL824=;
 b=IL4+0q3APi1TNxw3v0uiG8wLX3H6YS4XFtWmX+dLGXNdLVJLGZgFqyN9V+5VlT4W0cE0LFz4+I5CIj3KXPotZaHg3LnUuJTE9SNfHQPSO3Te/CQcjYB0lYOEP/f+MED1APMDKA9U5Vx4q2Cgf02fFxGZGP7YEmVrSXlza/IdBn33R6K8ivhMyaspd6ydu03w5HNYiHxykHmryDp1fcy9kZ17qEa6k9pMf4R6W0dRFiksjMBjFKBVZ1a8JJ2I9aMkgr7sSv1aH+s+S8m9++NSep017v2Ps8AMD/GdAkfjDQXPO4V+GtQWtDBx3wFvMZgPg0jeATeRYFPcN/cPJhnz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51ROYfulmm9CrVWry+1z+JqCf1eQSqxiEOEyJgXL824=;
 b=gXGd0tZ0qYXSwmXC2c+aP3m7AjNyYBavuMjAqjD/N/DubaANLKiceiDrd4db+FaGxjdQ0quhF3lZjRBV2t1M/dvXMSwTY02lxY5Gqckyc8t1ccs66R8pCwkd4KRQjqR63tJMNUHgqn0IgRQtrafZSuXkDlv/v0U+f4ttzOP51L0=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3049.namprd12.prod.outlook.com (2603:10b6:5:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 02:18:59 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 02:18:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
Thread-Topic: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
Thread-Index: AQHX8nEVzesQtsoaE0qs00k5Hhthvaw1CgeAgADpuOA=
Date: Fri, 17 Dec 2021 02:18:58 +0000
Message-ID: <DM6PR12MB46504A9D0304CC26FC57C7CBB0789@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211216113532.12369-1-tao.zhou1@amd.com>
 <20211216113532.12369-3-tao.zhou1@amd.com>
 <BL1SPR01MB00021E27716174BE8B8544C9FC779@BL1SPR01MB0002.namprd12.prod.outlook.com>
In-Reply-To: <BL1SPR01MB00021E27716174BE8B8544C9FC779@BL1SPR01MB0002.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T02:18:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=845639b8-97e9-443f-b486-7a5e25111263;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T02:18:54Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 2ceb81a7-a4c0-4d64-bee9-12485a889ec5
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443b1c37-909b-4861-4b2c-08d9c10395b9
x-ms-traffictypediagnostic: DM6PR12MB3049:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3049B744D014C2C02FE26D48B0789@DM6PR12MB3049.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkprgSLxDqoI5bHUm8l/e+fJI3rabouIjzH+XziWpA2+Jsk4JRzR2NjOoHj0FhZImuClXxxxUqi/IApUXrBeXL4gBRI2gw/zJN/8PyKK2bmump3CKw/4oggqUSG9Qx8X81CHQkrKUzGFSNMhKLkV2L5Chr9yEu1poLbAxBjRwOS3WQmi3i1EzK5i72QlYRHVsSFmUZpGZ3QA1j142eF2AkHIVIHygPrihWDE2y8FEGqKcKKg4tyJ6ZyWTiZ5npantxFQ5H9KX28Kjd9bojCSTQH7fqyKJ4YLOQOKkeTTlSstahOqpEybt/Rm4XSzwEM7fmy6IbiwgF6lSk1+wYVtNUrY5uzimfnzOwQ5HOkBQHW4I0HvN3TfrBOU78Lc51nZV5WN/G9qtVXksyd2IuGFNAu4rFwi6deXRadCOHegOVv9xnAQVKIdXb8RHYDZmsr65n7h0bvTXnD317WuKNRWid4CIBgqS8/q+Hov1nkchtdDSe0tO9t0YKWfwKL3XOAeSGDRJR6bRy1wth/pPFsgWObF6quCHZe18lQKFt0k6PJgQ5r+AX0Mqxcc0WXWEWkW3EVP3h8ISwTCLjbmNlZ19upeh336z0L7NUVpH+TDFFAVjbdMllvhrVYXC9kJHiO62ngefY+W3SP5iMhgzVA/dgj8JSZsRss5kTECnYa4Nuz+Z/7Vyodrny3JhnAwk/LXOeg7VlHehsKEmH4tJ3P68A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6506007)(55016003)(26005)(2906002)(66476007)(5660300002)(76116006)(66446008)(38070700005)(66556008)(66946007)(8936002)(8676002)(52536014)(122000001)(38100700002)(186003)(6636002)(9686003)(508600001)(64756008)(71200400001)(86362001)(33656002)(7696005)(110136005)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZbSi4PumiT+Vb1cpr0rrpAYQjZWHbZwbUh65TcAGgSTFf7v7qA2bZ3f9MIYv?=
 =?us-ascii?Q?eqFGnRrHoOE+erxZYM3oSdf0FkFXiPHakh6cWxyaq5H91cPs5K32q5fr3qUG?=
 =?us-ascii?Q?+4mVKyPeHQlIiDbbrSKIu6QPkD4FaK3kQl6JQ6HEabuwoHMZZ7yTevJkhcX6?=
 =?us-ascii?Q?gg0NmvaMHbcSfeWMpo9uAaQP6Y/uQfsqacynQ2FKMZfqI7NdxbZpQPvaG9+o?=
 =?us-ascii?Q?yiMJfdsgi13ZbR6MA2noiyYoSD5Xd5E+/wP7mcds36AaHHVnlxVWFX4S0Xga?=
 =?us-ascii?Q?1IMiC01vEe579g8lSogGKWdpZh03xSCYIu6bNYb5xNwikGtIsMo0HBNH1/mY?=
 =?us-ascii?Q?/I8E/1bofGSHU2dRlpNsGOgzN6Dp8IPwOLCWKqga+pCPCL5UkBIQWbd9i25w?=
 =?us-ascii?Q?ZvkMvzcL9UFgAsShGCeMx9kYSEuIQIDnpf8XeTewb+IhkpQlHYqoLzP35sF4?=
 =?us-ascii?Q?qYsRl3gftf/9dRT/WeMWhBtkpWKE66g0T1gur+ncUtDgPHd/G59vxgxqCPkj?=
 =?us-ascii?Q?0qDV4iMf+yzbofWEPHgUlXIj7UFusfWaKEaTYBZWj7+ZbtOVFrzhAbLEcfGk?=
 =?us-ascii?Q?eF7Ec1aqxXOHU0bEifo8frvj0809DMY0zo9gy+V6oKChJwcVBhth7v+5aDxp?=
 =?us-ascii?Q?WhrjJIHEAOzWxOmNvwJWbP1AtEyDTFoVctUfhdhSrI+IaDrIbjq9UUWW8gQ3?=
 =?us-ascii?Q?IqeEl+dkO0bahYgy2RoVBJr1tTDkDaRFlfmKyDsV57X3z7Yt8uvNLqHidIy4?=
 =?us-ascii?Q?T3+u9/5dQ5Lb8Y3Rn/RmKdG+LrMNHVnJmL/aMHyYWeNqdmxNZGN7IlIaxIX7?=
 =?us-ascii?Q?ClPYnNzs9w8FNOHbjcYVYDusSMmY/2oqPWQcqJkbMYTsC9n+eymAsqhCOwj9?=
 =?us-ascii?Q?ySopM+O5AFz1FcgbozGyvz5v2tRytTARgspdPo51rEWqOb6doj399Sn3pzHq?=
 =?us-ascii?Q?fNQSdK4cr9VEMiZcvM3+YhnuMU1nPbphw9GBGMT8E872t2R9SRXU92WiBljj?=
 =?us-ascii?Q?jA5z5xwK8jwJx2MAqmK3mI4xLK1z68OnW2PW0+BHTjOPsS709Hq55wy6ZPVN?=
 =?us-ascii?Q?8J1nAlR1MguT5xCGSjuseWZLKl5NhMRmziC0fD4mpcfoYBO9K9ELDdQsdcq3?=
 =?us-ascii?Q?aobfSzQxukvxUEG+C6b4MLSQl2i/MfNDeKDHovcHrm5r79Aew+hUaCGuXL0C?=
 =?us-ascii?Q?dQQ7b4LzA+4ERNsk5GWrSJt43LOTtEDbho6xEVsAyRHFYx/nOKbQMVA49rkH?=
 =?us-ascii?Q?A3jyhedTzfrh1wb1zye4xz9kz7EkrpnjW1AzEpiWPZxwMG5Do3JYes5dBsLl?=
 =?us-ascii?Q?5ppj7c/uxMseHc+YLYcgD1A5sRG/VSAebujP81LMdy0bFrLNVM+idN16uNVA?=
 =?us-ascii?Q?QmxpyJiPgEHzr7Ba5CCdhMF1SGo9H3MjnxIsUPXX1gJ4GwPpdiUYNGgG8M19?=
 =?us-ascii?Q?rfKscH65zbdBlPKIIRBt7IPICvYqrPSHQVq9I1SGqcR8O42o19oEScR/6cIy?=
 =?us-ascii?Q?+nOTv6EGKy60xAFVBOKAH7y2f8KR8Cg0W0Yz5LxdHbUkCB3CnlsLNFYPortI?=
 =?us-ascii?Q?0sLB6+hmoAmT+JT6QcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443b1c37-909b-4861-4b2c-08d9c10395b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 02:18:58.8918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGM39XsKhCV6n4wKrGbld6TAmzflTqfgFWIF5rUT50womnv2tI7stUxlKRHAu2yq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3049
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

OK, I'll rename it before submit.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, December 16, 2021 8:22 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poi=
son
>=20
> +
> +	int (*unmap_queues_cpsch_poison)(struct device_queue_manager
> *dqm,
> +					uint16_t pasid);
>  };
>=20
> Might be better call it reset_queue directly (match with update_queue,
> create_queue, .etc.,)
>=20
> Others look good to me
>=20
> The series (4 patches) is
>=20
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>=20
> Regards,
> Hawking
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, December 16, 2021 19:36
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/4] drm/amdkfd: add reset queue function for RAS poison
>=20
> The new interface unmaps queues with reset mode for the process consumes
> RAS poison, it's only for compute queue.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 16 ++++++++++++++++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h    |  5 +++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 01a2cc3928ac..b4b0495c7024 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1476,6 +1476,21 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>  	return retval;
>  }
>=20
> +/* only for compute queue */
> +static int unmap_queues_cpsch_poison(struct device_queue_manager *dqm,
> +			uint16_t pasid)
> +{
> +	int retval;
> +
> +	dqm_lock(dqm);
> +
> +	retval =3D unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> +			pasid, true);
> +
> +	dqm_unlock(dqm);
> +	return retval;
> +}
> +
>  /* dqm->lock mutex has to be locked before calling this function */  sta=
tic int
> execute_queues_cpsch(struct device_queue_manager *dqm,
>  				enum kfd_unmap_queues_filter filter, @@ -
> 1896,6 +1911,7 @@ struct device_queue_manager
> *device_queue_manager_init(struct kfd_dev *dev)
>  		dqm->ops.evict_process_queues =3D evict_process_queues_cpsch;
>  		dqm->ops.restore_process_queues =3D
> restore_process_queues_cpsch;
>  		dqm->ops.get_wave_state =3D get_wave_state;
> +		dqm->ops.unmap_queues_cpsch_poison =3D
> unmap_queues_cpsch_poison;
>  		break;
>  	case KFD_SCHED_POLICY_NO_HWS:
>  		/* initialize dqm for no cp scheduling */ diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 499fc0ea387f..19ec3e8859e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -81,6 +81,8 @@ struct device_process_node {
>   *
>   * @get_wave_state: Retrieves context save state and optionally copies t=
he
>   * control stack, if kept in the MQD, to the given userspace address.
> + *
> + * @unmap_queues_cpsch_poison: reset queue which consumes RAS poison
>   */
>=20
>  struct device_queue_manager_ops {
> @@ -134,6 +136,9 @@ struct device_queue_manager_ops {
>  				  void __user *ctl_stack,
>  				  u32 *ctl_stack_used_size,
>  				  u32 *save_area_used_size);
> +
> +	int (*unmap_queues_cpsch_poison)(struct device_queue_manager
> *dqm,
> +					uint16_t pasid);
>  };
>=20
>  struct device_queue_manager_asic_ops {
> --
> 2.17.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F94D2E008
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 01:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEABC10E343;
	Wed, 23 Oct 2024 01:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8uVh0/g";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D9F10E343
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 01:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhuBU6Z3BNJRjFbTf53vCJYWsCdc5RMH58GOpkA5A1Cqf9Tc0hW2Qacc0c1qsh/bbgzUkfCY4LEawss2bpVRUrzdbCLTgk92iShdwKROye1N4K/PK2osT+IyGtSGgsL+DlzjSt4/U44pKSAeZw/JYcmNbkxavAU3fqJiPnCdH7UUqPzktU+qo0U40n28Q43vZiIvwBh+sNMGRL/WO/7arGOjmjj605bfXB3LlIPfVjKryZwBiRXKx+nUZ58dYrjf9oIRvzTmtd2S1WdU3WhMzHPFr6xc4QJV9OJW4EIp77FnHiSS4xVPB7Y9otqtwiNqNSb4RptCjb7oGrBSPdZsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4YwM91EIi8Xoq3n7ijlgsHkKboqVq1Y4/yrVe8+6Q4=;
 b=WZzuAV2aOBEkOjmp4i2/7g0MelZbarU7hge1H2f7awP6dzjIuOJcQUpLLRPTHRn/P0acEVhCrxrzaoEPo4KGkn9zMTmMg1TRsBQd5Xb4tvjw2/XiuGs5MPGWeJjlMvWV5jtsc+h5Q3UrbhGPxxRSrIT8/pH6YV/LMToVW1L8JjEyRglsCRtTwNAvc7Xy+xw3HNqYSFY2VzDjArIJL+zJNRNhb4a7iYfOjzne1PUqFv9+MSrtNdW733i9cebjrkK2yq99UPPN7lvPo7USBQwGMOKzK4e9rUwbslpZL5h1H6amUNFj7xKa6a1addHjvlvk/etKoFiIwQ3XmQIZn9ZL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4YwM91EIi8Xoq3n7ijlgsHkKboqVq1Y4/yrVe8+6Q4=;
 b=X8uVh0/g1nKSPY60TWxeUVvcMjS1NBh1MhQhCG/WOzvqDhvGEKJDCmROYdJTZ5antcCU/KpXphxjN0ciYeODRwSHisxMFrH1fqELzjkvuNiE67qULcuhJT+dxUD/z3db5pV6StNhy2MWrV6e7CWsQIKA2/AjAIVM3XRB8mF+a60=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 01:50:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 01:50:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid dummy_read_page overlapping mappings
Thread-Topic: [PATCH] drm/amdgpu: avoid dummy_read_page overlapping mappings
Thread-Index: AQHbJFKpXR31qjwNpEuEhB7XBmVdkLKTkiZw
Date: Wed, 23 Oct 2024 01:50:45 +0000
Message-ID: <DS7PR12MB600513EEE8454DFD2DC73458FB4D2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241022071844.1960835-1-Prike.Liang@amd.com>
In-Reply-To: <20241022071844.1960835-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=abddfcff-6435-44a7-a970-b98ef6bb05c7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-23T01:46:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA0PR12MB7076:EE_
x-ms-office365-filtering-correlation-id: 63f39df1-f62a-4359-721a-08dcf3051c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0rblFH8hg+XnK3EUv4DTbaI9hN2PieMRB0xQE9w4jTbu7srzRdY5se1ZMmpg?=
 =?us-ascii?Q?TFU57KUh5Z5N3FJeFm9tR3NViZNlClMUBCuXSC/wFdjOufNBOkF+/8CwUFB2?=
 =?us-ascii?Q?9nDshyEPcDIM2Az4a6X2aup2uUcDSuyRDbeAExXvNXEbEG6fFfn7X7WPFWw9?=
 =?us-ascii?Q?/krcE25/U5PmF6V7J7iQApUR5r1QXMI+hqnPDYKNS9RiAr8YS/9nwDH9E1HK?=
 =?us-ascii?Q?cyRB1FGBfzN60m031w5VBBTubnUa749csGaq2dp7SPOrcmC63mvFx9ykA4Jr?=
 =?us-ascii?Q?K05BByzxrtn+xQFmb77q282YLccXyYrvtD/D649y4m2glw79l2Lboc8cVk7k?=
 =?us-ascii?Q?MBElh5/kShXq/0t8OrGSS2Z+RRmJzLIBs3Qx0l+2I3N+knqRxgpHavaggghB?=
 =?us-ascii?Q?YKVoqJDsWuOW/f/QMAVL5tUw43GJlQbYRE3CSbQJFbpLSEXIReYWwRB7H/Nw?=
 =?us-ascii?Q?sj8flWA1z4mY1ty7Hir0baIrPi6RsC+VscmSFr6VXM4r5rEELufhIojdbcx+?=
 =?us-ascii?Q?tn2Zw1bS0M50+WcYG54++2sNe26sVasOeP1FXSiqow3jTL3tu7IYNdxmxy89?=
 =?us-ascii?Q?fPDWuBn2TEhf25L+LeP64QLusDzpHx6uiQQxXR2HgywaMWrrDwG4b5KWaxcw?=
 =?us-ascii?Q?kiKlJzV7uQ4jTHVE1iIYuNI4auhJX+xHvGaV5lgb7k3OhLk1I5/A00J1U5NO?=
 =?us-ascii?Q?QQWu5899a0MooFzzCoFYG2OBiuZDZzdwRu3wZdwxh9ui3fx3qEZvdFil92Nk?=
 =?us-ascii?Q?jOMnvcb/ahg2gc0aPkqUkOTb0JUkdjS9GQ2Y5+bjlp4JjkyqP2rYwK/Q9X2V?=
 =?us-ascii?Q?T0NFysR8AH9OQpKfDPk5ECFbmBqu+GN7jUZU0BQcsybDyP0DWp1I4TZAg0Kp?=
 =?us-ascii?Q?BgdF+enkmgDrS//pqt6W/6j6afReF9vIzYBam92q/eV1XGiq6C7V0zrWN+Gb?=
 =?us-ascii?Q?/yXP5BlObuDw4AJsI/8ysmamkxAxldf/RNdT7jp+NYYcuA70F8nPT1Q33dmj?=
 =?us-ascii?Q?LZBOZybYMc1g/kg/SwMmDk7dHOKjQ5z09fjF6VcsqUGHfq24BWzk3nGZN/OK?=
 =?us-ascii?Q?WRn0zFTYa/hvza/lW37qyYdDrwADyLFy4f8wLm05CIDwLTWRNOi9Y5U4waBQ?=
 =?us-ascii?Q?1Sxk5fxT7y/evwWv+h0ChCYlHvklFPm/Rb0Ts1B8IzsiQeMckI+deHbNrlbz?=
 =?us-ascii?Q?7jzG1q5IYrw1YMeQAN3ZBPVIhEptHOiKpkVWwoHFAk76LJBOi/YT9nd6j5yA?=
 =?us-ascii?Q?Cgb7tLzH8n4csf8HmX0pSMeZHs+zJ8sJiUEXAt8/m6P0gcLQPcFakuLg7z1i?=
 =?us-ascii?Q?qcygK2aJOY+npNSqws6WxcM302t/8eflvOoiVxKVxWNnsa/SfpfxJ9H1kA4O?=
 =?us-ascii?Q?EHNJL98=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?csaqFtmwCt+YwJz1oG/L3LbkVosds9n1KGDe1oMGUi2J0CxE7WUcOCQktZ+s?=
 =?us-ascii?Q?39H+pFguwcfTQ1yhbBMnSo6g6nfEysqDLlgQPytHi7Sr3Ld+7Cha89XiFirc?=
 =?us-ascii?Q?mEUvcQ7wx9cWrDpnnTl8xdH933c3aJVaJUdLFio0et+Fs5J9vARFQ6UTCGrt?=
 =?us-ascii?Q?WmTBKzBi+E5/CPsttvsSJy+XrxmHqHzPpefuynd199x6NYsMaDuM4T7Ux2AK?=
 =?us-ascii?Q?OlA1CITzjdMM4UPLcH94OsxRE90S5LNPXQvscDdaoaFLb4rzjAr2ghkNCrT+?=
 =?us-ascii?Q?7ORvePH6ffU6XZI+aXUlwyM98PhcXdstY3pHaUIZtB8wGd07kRHmISzx0sFo?=
 =?us-ascii?Q?PufJndPI9oy3GphxQoIEe7lGxm1Rg6VjJSmhAu8V0J+jVlPqW/Orz36by2/K?=
 =?us-ascii?Q?aPybU/J6B7A6k7Tk7TRdQvG3CTIcM4QkWz3ZQ2q94imFveaSeZbmTLPFpKyP?=
 =?us-ascii?Q?8E6jYj6Gew/KSR6FIUyOjB3KhNw8CI55jYaRqkKSLH2E3w/kPWAUl3nFhG0F?=
 =?us-ascii?Q?ui+3o+VO7PYrIwx5tphjaBLjstI7g9KSN4e3xx3zqlwvtOY5Zi+sjhuMze+x?=
 =?us-ascii?Q?4WkqC+YkK9OJWHm3vM+duN4So29i749cz7MuAha0XPecMrsnEufiaMirPUK1?=
 =?us-ascii?Q?bmq7rRQFIXsRm0nAjQfOmd82JeysIMwCfovbzbakQ8ygtktzhnOoFU29Kn5Q?=
 =?us-ascii?Q?kPKB8udeu8wZ1IpEwUzmqqToAW9wCfYoQipSQfBTiVM+IknQ9uc02SyFAmX+?=
 =?us-ascii?Q?RsOZpBOpjXq8HuNLPwBxvBFgi8BFCziG8Vex7Ymrz+z2BXX3fMvpkZih49nk?=
 =?us-ascii?Q?1lFGYCCRjAsCetssPK2OyFb9GuBYxUOJNBAJXyJoVnhFu/NxotMYIDqbNPjv?=
 =?us-ascii?Q?QOTAArwOf1L3ZCMKtclIq4z0qX3FjpsuGo1UqM8UDRB974u0znLtp2u9+/im?=
 =?us-ascii?Q?vi4P9c02csAT4jDo4E3oujP84t3SKO7KbVNQLdu8ALHhkgaNdbc8NmH/leGu?=
 =?us-ascii?Q?LfrKpOEf8E4Yi1q1BYWNmuxccvEGWmT4CEVLHqlKbRKnZyZO50XW9io9j84u?=
 =?us-ascii?Q?GxxRsbT5iSNIeUU9ho32naskGgkVw2Sfi/XpCi0AXwOcaHLsF/Y/PQmW7AFL?=
 =?us-ascii?Q?eGlo/FrqDGtGL+h/AiGSBO6zwaI5h3DRpSKnPpBV4HAE9wghXl5keLR7D6ZS?=
 =?us-ascii?Q?5T1Wuji4OIHyxk17qs6UxkJqmwoB99XVaiqQ3nLbeP3uuFquLZPHTIhEwGas?=
 =?us-ascii?Q?IN2dQioX5pBd30SreSnIvnE9ZeXnegmq1BUIRSMuBmr+VbbYIVlly9ePd2GG?=
 =?us-ascii?Q?VEJz+X1oZ0BbV16FMuirLrXw+N0lp/siW96OGQkbAx4fXdXU48lSoQYiJswV?=
 =?us-ascii?Q?clCmN/Dh04H2q4meIArnqGxdlNVh9J+1CmMDwo4WDQsmGusjcQBqEIMRr08X?=
 =?us-ascii?Q?40HIq1bwmnVVS13BfrzbxqTPj7SYSAb0Z+awO5MqpGuBldEO9hpxcR2dkAFa?=
 =?us-ascii?Q?SLhpeyvfmL0/Y5B/aiU1uJqtxkCpdwYqrc/x1oz9uT+lNuGhERWvdAc4v7to?=
 =?us-ascii?Q?Z+R541BSj9uihs1nrRc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f39df1-f62a-4359-721a-08dcf3051c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:50:45.3362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMGmuZi/EgJhkiNtquqFo+5mPeFhXUlfh+SxDpBsaSFBqDMRp37wk0GPe8HgJXxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hold on to this patch for a while. I need to further investigate whether it=
 requires allocating a separate page for the second VGA device.

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, October 22, 2024 3:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: avoid dummy_read_page overlapping mappings
>
> In the A+A system, the dummy_read_page is mapped twice during the device
> graphics memory software initialization.
>
> To avoid page remapping, export the ttm_glob_use_count to the driver for =
checking
> whether the same page has already been mapped.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 ++-
>  drivers/gpu/drm/ttm/ttm_device.c         | 7 +++----
>  include/drm/ttm/ttm_device.h             | 5 +++++
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 256b95232de5..81e567f63967 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -76,7 +76,8 @@ static int amdgpu_gart_dummy_page_init(struct
> amdgpu_device *adev)  {
>       struct page *dummy_page =3D ttm_glob.dummy_read_page;
>
> -     if (adev->dummy_page_addr)
> +     if (adev->dummy_page_addr ||
> +                             ttm_glob.ttm_glob_use_count > 1)
>               return 0;
>       adev->dummy_page_addr =3D dma_map_page(&adev->pdev->dev,
> dummy_page, 0,
>                                            PAGE_SIZE, DMA_BIDIRECTIONAL);=
 diff -
> -git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.=
c
> index 434cf0258000..d99ccfa94c67 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -41,7 +41,6 @@
>   * ttm_global_mutex - protecting the global state
>   */
>  static DEFINE_MUTEX(ttm_global_mutex);
> -static unsigned ttm_glob_use_count;
>  struct ttm_global ttm_glob;
>  EXPORT_SYMBOL(ttm_glob);
>
> @@ -52,7 +51,7 @@ static void ttm_global_release(void)
>       struct ttm_global *glob =3D &ttm_glob;
>
>       mutex_lock(&ttm_global_mutex);
> -     if (--ttm_glob_use_count > 0)
> +     if (--glob->ttm_glob_use_count > 0)
>               goto out;
>
>       ttm_pool_mgr_fini();
> @@ -72,7 +71,7 @@ static int ttm_global_init(void)
>       int ret =3D 0;
>
>       mutex_lock(&ttm_global_mutex);
> -     if (++ttm_glob_use_count > 1)
> +     if (++glob->ttm_glob_use_count > 1)
>               goto out;
>
>       si_meminfo(&si);
> @@ -118,7 +117,7 @@ static int ttm_global_init(void)
>       if (ret && ttm_debugfs_root)
>               debugfs_remove(ttm_debugfs_root);
>       if (ret)
> -             --ttm_glob_use_count;
> +             --glob->ttm_glob_use_count;
>       mutex_unlock(&ttm_global_mutex);
>       return ret;
>  }
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h =
index
> c22f30535c84..8afb380989e1 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -56,6 +56,11 @@ extern struct ttm_global {
>        * @bo_count: Number of buffer objects allocated by devices.
>        */
>       atomic_t bo_count;
> +
> +     /**
> +      * @ttm_glob_use_count: Number of ttm glob object referenced by dev=
ices.
> +      */
> +     unsigned ttm_glob_use_count;
>  } ttm_glob;
>
>  struct ttm_device_funcs {
> --
> 2.34.1


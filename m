Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA0CC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 01:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43796190A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 01:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43796190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C2A6E0BF;
	Mon, 29 Mar 2021 01:53:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F4F6E0BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 01:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIApck7/X5yK3WXOrTU6de9+1L5wiecSyjEFijd3G4ZPppGHslQexii9Vftm0TgKf7jE8m/JpX0OHE9CqARBga82l3gX4HnIMQ401VJ7Jyo9z9imeAXp0v1y2ztguZG9Qq97mB0RePtQ0i1cVj1UcL8hU8S+gWu5PPf/SsMzAPdmNrKB4v9fVVOkbJHASS1E7ERPj+z9aVAcrxsBILG5HUBlHbcHj3Y/0d6LJ21s7nbCbvegXIInqtFkWbj13k9EXLjKoFqVdXiErceDw5I14MxdJazKLMoZ2HHZLvgFRoDgCxEKFufzpKjwDwZX72L0HKDLYOmxzRfAyibsME9Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euc8GUPiWRdTsTOti+fZo0z9QMFbsvtee31sZiSGZDI=;
 b=mGbtKfvJs+gJRvhBnUvQbMqGYfVamkAoghNuYDtImTFEoPOwFI2Rgcr/ny1xhm3RSp/IDYCwCLD1OG9yNspg7nhU4mO+xMvbWjWq3YT0ah7/YaIGMqA09lEwY/Xs6uGK7wGbNzoL/tYKsZ2Trh2NcclTrR7zAADz6OjO33Q/09Hxs8VtGFQJz/kjJir/TGJuB08GSAPEd69A9VnVEPAEG6Kmuo3JsNLFwzGD+GQWgHDcQ8Ulcs2dbSeMgbMXEJN3KO3adQrDCZx+4vfEKB4InyF5rNJpaoayH7uwjE0bGF7CPgJDvuqgphLyvK50oUt462yGG9rfPkw2H5kDyty5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euc8GUPiWRdTsTOti+fZo0z9QMFbsvtee31sZiSGZDI=;
 b=Mie/pNE3bVD1yhUFwmshz+1+p+2UyBnOtfo/VtMqQSVUjAvn4Om8/wCKAp27+IyMlV5TGLfyHHV/y64DQwBDtjW+ZqQX5YwsBjy2kpOjWw3Wz35kZW1BtDE2zwP13U7LpNpkzyQXPcuRw8TnSzN4gdVGQSs/da8k9WY/2uhIhJg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.31; Mon, 29 Mar 2021 01:53:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 01:53:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vangogh: don't check for dpm in is_dpm_running
 when in suspend
Thread-Topic: [PATCH] drm/amdgpu/vangogh: don't check for dpm in
 is_dpm_running when in suspend
Thread-Index: AQHXIoLZVoi41XHfYkWzwlsP1ylz+aqaN1lA
Date: Mon, 29 Mar 2021 01:53:01 +0000
Message-ID: <DM6PR12MB2619C40B964B021E1FB0CE28E47E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210326205735.1324461-1-alexander.deucher@amd.com>
In-Reply-To: <20210326205735.1324461-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T01:52:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c9ea8ed1-4fee-40f8-99ee-df7e293dd300;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6aa349f-577f-425c-adba-08d8f25562e7
x-ms-traffictypediagnostic: DM6PR12MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39633689EBA10D9C75EC0C8AE47E9@DM6PR12MB3963.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TLecudGBVmRQIC5KBRCBrimV+6xYxmxbiX/LHbLeNkBhN5DQxbSZNb1b9Vxpnw2B3csomxcaN1TQHXT6bKeLh4L7JE9ZU8nbUvABTZTcma3qUYG29cMAIGRE0X+Na3SrMMbvrUHuRfZjFobNkndADPEc7FtuIC7iiFEm/gbxK9eeyo9uwgUDgKaUVAUGVa6/thnww6OT+WUpo2e9AqYlHbQfD2mvJbJrVz8cn1Qdrdfyp9r1wnoTImFpr6mqBekxSwL5kYMWwuT5yzCAftwiEKkotsj4O8ByQVFLVyCtxfFQ25Mr9Hp3jN/cxxjSobDaYZ57f0mxTGjQjZ3Z9+ZuvUA+VUwJ8wtE6wZ6OM/S1v1hEHXmdb91iIU4cIswMiz/MJOEKxstvI1i0iKWRJzM+B7mQOc0uogKq4sQIGGLg+wfqpuV2suZOGBujEEtRFzJR0qCI4JNsneXjET8Zm4P6tIl9kVBhNxqUjUSJIHpSNZYnqKdwha+aXjMsJrgkDrTt7oNclSKEgcCGExzB7Bsv4cUPOa/anRtfuzfD7GwLHmStkHHF5XZXOv4aGUhI+012pJam7msXJALaVxahZ4+hgqDZFlubBQgeTY4eI8QZ9+fnlvbUWYNIiI0zZgHMeLujMCaXvotpkBwtQEZDeXndTeMw/9GxiDDE1wOJOOsB85XvPVsB8J8C0aSVObTnJAv9rj7/xTpnmDscgDUQ4FppHQPwiIh6X4Kv3Tf5rpyc+9eABuSP05n+dUa5s9hIOmu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(15650500001)(66446008)(5660300002)(66476007)(66556008)(64756008)(966005)(478600001)(52536014)(45080400002)(76116006)(83380400001)(8936002)(66946007)(55016002)(33656002)(8676002)(186003)(9686003)(4326008)(26005)(110136005)(38100700001)(2906002)(316002)(7696005)(6506007)(86362001)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KaXJ6YTSvwlAwsrurtQMHFB7pca0jsVtpyLJHaX4DzzsyUxSJRt7Do+uouQA?=
 =?us-ascii?Q?xP3AW+fNwQaB5UoNGf2S82cbiVYxDMAr/2S+d3uvtSsWSPXHJB56yir4NqzT?=
 =?us-ascii?Q?YgBOCfaBQ2a/+LtxEOAi+acgELMmTewy3cJQPUR/bS/fhiumDhDNfYvOcthR?=
 =?us-ascii?Q?yxmN+EFFRFzDXyTfuFRnW6+F2h+y9GWpVRFuehposSNsHsgvxVoI84DY0leV?=
 =?us-ascii?Q?RI1fIV857fe1K8ULc5ONAciWnFEVRdFbVC28YqNx7EQHxnf+ho1m6HfaP9NV?=
 =?us-ascii?Q?fe9pZ5zUDqlN/jQ42S8kL5wrCOL8ABqej+EYw7RKxXWuuN0TqCMChOtUs/wR?=
 =?us-ascii?Q?tpSv7yhVUZTqTBhqmkXXwpNHqT7QrzHIM9+5vhLWNmxfpPF5LxBLOCVGkcqc?=
 =?us-ascii?Q?a80faYKhVD9ND65nD4qia/42OgW2YFdWXH3Q81S0lGbnTI/820Vkf9dbw+eB?=
 =?us-ascii?Q?Iq+LckxKmNq44JPbZpt8YETtX7xTCx7jJ2H9NxFOO/Umi3BrWr6agCNJFugC?=
 =?us-ascii?Q?hsIe+RSpJtwmNau+QvBgpIl8EcEHddPAtSnmuRgNDpQMk7IRYT6gP0CXYhaA?=
 =?us-ascii?Q?GWdfOcwtK12sCsCk7fr/miTo0JvmbhOtLua8L0g5YowZDJR6DC7rl8h57xGQ?=
 =?us-ascii?Q?FVE5POslw9w4PFEXzd6OVgPu2/zx+l3DagfBksttuj+CpisVFY5ab8h63oC4?=
 =?us-ascii?Q?zvHNmJMOsN6PMxMTsqKBC6y4rsbEmgYB2tb0Mc2KsGNT0RYaW8YrGAE1H0+M?=
 =?us-ascii?Q?kTBEmuXQa6B02oQo6wDo8vq0PzPunvHh3fhgC9tMEmIZ4X/CreFE/Hijt5pg?=
 =?us-ascii?Q?M3TmdL+DHLdI4r9XlZBMxg2TodOxFGGSr+boX1kd7zN83b2tInYR1mOq22Lb?=
 =?us-ascii?Q?S2ZiXcw9bXNkiu1zg9V+Wq1qVt19E2CIFlpXVtQoIhjei4E2st6UIRldlMe0?=
 =?us-ascii?Q?RNJ+/pEMDaQ3igIsL5CfAu2Pa1OdoijgaY9nVEGEz+4mdp0pva5wQiFJLpZS?=
 =?us-ascii?Q?uvr7BAi3e6gqVcs7Uy0LToUTtJNj0+u/q9YA/3bZjbOxj/9LNuZ9eLaK02Sv?=
 =?us-ascii?Q?P+ohjnW68GgIkyXb/tHqMkbytVa/Y3CMZT36pYojpzTV0qAqXt39klMQpqvr?=
 =?us-ascii?Q?DbbZsfT6ZwtR2Jzpd0et37pIsZHavtF0+Qc8YgsFuuGft4z6FgY5TUxtxOLM?=
 =?us-ascii?Q?9s8VGXPYVlStUqvKjReWD/+BX6weuFTaoLWzhhQZoCwszlHIyfD9mYGw2iwx?=
 =?us-ascii?Q?SUbismz0pFYQ1CwIJOzLdustPte3yCq37pAgaxG42p2I1Lsyv+dxYcNfFeXv?=
 =?us-ascii?Q?upJ0eu1zVFloqZJ2cH+iXtjl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aa349f-577f-425c-adba-08d8f25562e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 01:53:01.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSWg+yOKfyyykbzJ/JYAPa3eZRoJkmixwD14ysfde6lOp+f3+tgC+HifKREObsMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, March 27, 2021 4:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/vangogh: don't check for dpm in
> is_dpm_running when in suspend
> 
> Do the same thing we do for Renoir.  We can check, but since
> the sbios has started DPM, it will always return true which
> causes the driver to skip some of the SMU init when it shouldn't.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 2f502fec67d5..ed11e0ab8299 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -384,10 +384,15 @@ static int vangogh_dpm_set_jpeg_enable(struct
> smu_context *smu, bool enable)
> 
>  static bool vangogh_is_dpm_running(struct smu_context *smu)
>  {
> +	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  	uint32_t feature_mask[2];
>  	uint64_t feature_enabled;
> 
> +	/* we need to re-init after suspend so return false */
> +	if (adev->in_suspend)
> +		return false;
> +
>  	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> 
>  	if (ret)
> --
> 2.30.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C43d4981ccc7545675
> bfe08d8f099fac3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 523891416957673%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2C
> 8w1ValXDpaPW3jzDN%2BdNmiDK10FOxgQ20h%2FJ%2F66sc%3D&amp;reser
> ved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

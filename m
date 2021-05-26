Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE49C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC316139A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC316139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597666ECD9;
	Wed, 26 May 2021 12:38:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BFF6ECD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5mTmMAg6rgNvRq5yiA29ejiSh0isDcvJCa2pomiHCC/njgu/VQuNwtIBkMSIUffwHCZ1p265+ukP18ZY4WuKKFgK0T+GLYMsGHdAm71/OzAp6I926COjqYY2EU5pQO3xl1/IwA+RTkaePrL7r+kpwrcNCRZXEfPHPoYZCeg+pr6lsopiT5oa9NGblUn0DbczB5gzpAKMAZBE0h9+fXGtDum7m6gW/lTB8UoLul56pFs7oAGns7ZDQ+TVkakiCfAGITuOmDqmDF1W9+PTZIXhxRCvMuB8WfATcfH8q/hl13q9U3oNmEiX9QIDPNZUHbX6fgM8SZld1OmhUpqZXVTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOnGKoVVMi1j/vLSthM7228vdsXCgANA+STeTskHW5Y=;
 b=JwK/7QMREBdnRhgU48fIhmYWT1YECW61x83wM3nZMxrhyBmzXSQ75BA56sWzB6S1sc1MJASWjHjcHek33kmoVCAws4/GTl7/zZkhPyhkTIOkhxS+8zQ+9EwRVyXDmWRaGUyPCPOwATrZNFpd128K7IeCc7ekRNF2juhKSDg2nU5l4nfJ4Vzs+TlSrno0sNJmSZck9/YyH+bp+aYTEIA6qbpHo0RU9L2uFoBsnFt5TR8ZwMu2mR/LoaGz3Ty3WZUJ5hDhXKhYrxUsvesDJZw7CEslB8ujyfRrLv55GxokgI8+AcP6EHDP/Lx6BPASWLpu/cAKzJXxQ7gWlAdQeQuQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOnGKoVVMi1j/vLSthM7228vdsXCgANA+STeTskHW5Y=;
 b=alvnMvHJl8HkuisCLHm9zZiUymC/yCFkxAcjB+oxzvl6twtf+vGN6NuxGQS37lLAJb/BqY39l8RTfiYrGkA39DPcxu7A/okYGIESoZsSIKHaXb7isy6ymse+UtQuxRwFdhYLAgx2RreigK7P/c1VCXiRn0fxSQ6CarujD3rgchE=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 12:38:44 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 12:38:44 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amdgpu: move shadow bo validation to VM code
Thread-Topic: [PATCH 2/7] drm/amdgpu: move shadow bo validation to VM code
Thread-Index: AQHXUhdnMNMxrzMCAUuqTXLkjXuMhqr1qdwAgAAJxLA=
Date: Wed, 26 May 2021 12:38:44 +0000
Message-ID: <DM4PR12MB51366EE83B73E71272C7BB3E8B249@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
 <20210526101027.14936-2-nirmoy.das@amd.com>
 <b166ff2f-1b6f-6d51-db9e-50b15cdaac8a@amd.com>
In-Reply-To: <b166ff2f-1b6f-6d51-db9e-50b15cdaac8a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T12:38:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c144dccb-5679-4338-bf6d-e757ac857ff8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f26:4300:d522:207b:ae82:4dad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee147a06-15e7-4c73-a09c-08d920433323
x-ms-traffictypediagnostic: DM4PR12MB5246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5246053C012AA160E07DEA808B249@DM4PR12MB5246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoXxijFjFM1gt2sOtt5D1ynTnKBgb7ZphiMxjsuD29H5tnlFDXe0NtdpAsZlgbeNsbJc1Kt7dE+odFPPsDQNYAnhQIm6IgcUKUYzcPehXDSKyk0+kVVfweHRBCZ0BEE1eH06tr6Pw7VMsh9KGQWvcQvBLYZ+PLoU3mQDs73gS3Vp7QaRL0KlpBQHBe+h4ueajd2Xalg4sOXVob6Tbn7SUnoDL9NSjtrcRTxHVgd5DhIJDUfDl8G3LgThz7wiM0ghIYR8wZ7Lf4Js+30q1ZWSvZIkvUdxL8IfQkd+cCIzwEOK3l966vidgNo3eribFWUzPJgN5HZNXjlidQSPtDxlm1MITIz+UUcgk/IivK/buFxEybzmBa3Lt1mGW1W8d72BR1d57Nq6Fxn8GfDn/kXn3Ry/Z4S+/65AMtwiCrmcwPjqZEhgT7rqh8L19IjaKUIEWYLGxYsu7qfGjEvF/EPEpnAGfZurgB1/0ksWmf8pcohBC190UH1naMdEfsbiIDx5EP1uclxisYfjMy63tqf6U/k4MAhhNzQcJtkKcZIcrGjARWgWQdLBFiWHIa7dhallwsv7Lqktex0009gpZJW8s0OdbsmaOc0BQapWdUNA09A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(478600001)(66446008)(64756008)(66946007)(316002)(38100700002)(33656002)(86362001)(53546011)(110136005)(6506007)(52536014)(9686003)(186003)(66476007)(76116006)(122000001)(66556008)(83380400001)(5660300002)(55016002)(8936002)(2906002)(71200400001)(7696005)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?a3VDWExEZ3pENjE0c3ZicjBsalV4cXVtNHhVU2NONlhNdFFDSFgzTUhDRWZ0?=
 =?utf-8?B?ZUovQUUvTTNla1hMWDV6RFBGSWh5NjZ1bFpNcFlTSVlZMnNCL1NzZEVMVExx?=
 =?utf-8?B?Tm5DL1BORnFJQ0JrbTZ5S25iUENmU3lxTVIvR2xkZWZXN00vSDJJT2VSdFoz?=
 =?utf-8?B?aE1jdEdQV2xWNG4wbGxiN1BOVnphUUpTTUlTenJlbmxhZmRBYU5PUWhVa0Fl?=
 =?utf-8?B?WXJQTnNtZUVROEJLL3FkdE83czJhYmNEMU1YQ3E5LzlQVmcxTDNJeGFjODdO?=
 =?utf-8?B?R1VqTkZiemFZaHhwMDJ0eXhMa2Fkd29Pbk1KaWtRS2hNaVlibXZFaThJT2Z3?=
 =?utf-8?B?MkdWN2o4M29QTWpVMHppV2ZIcnZkMmVqbWRHUmVmdkZKaUhEZ2htYXhBemdu?=
 =?utf-8?B?cUZMOVdLQnBRV2ZGWWFrL3JHU0xDU0FoMWdWaVpIc3F1eWtqRkQvMmN6UDZC?=
 =?utf-8?B?NFNuQVV6eVNYaUlUcmZvakFHWG9xL3J4U1RPSDdtWDh3NU1LcXE2eVpaY3JR?=
 =?utf-8?B?azNlWTQ1Y2RURUFQdDQ3ZkFpUWJUM3NCZlRORyt2N291dDJNR2kyeG5LSGp1?=
 =?utf-8?B?L3pNTnIyRkl4WnRiUitjL0RjS2c5cHhuS1dKTmJ1bmNrYkkwY3BMRVdoK08y?=
 =?utf-8?B?VDlHZlp5dlhmdmxlMkViNEtoWjNrRDRzNlA0NjVsZlgyRTAyVUhvVVRjdjhB?=
 =?utf-8?B?WlljcjczbENxYTVxaWlzc1JoUjVmRTY0cnJ2ZmRuUlpQMHplanZuN2pJRzFl?=
 =?utf-8?B?TzFxWjRPK0hGQ2c0blFzbzRndFpZRVpnZGdkSkxqNXJGUlRGcktrV2M4czhr?=
 =?utf-8?B?MlY0cmI3RXpxb3ozdXNCR3F2NzhnL2VEMmRPSWVVTlhZd3FqQytyb2RhcjRC?=
 =?utf-8?B?WnVZVW5heGxUeWZmTFlkMFpuYWc2RmdFdCs5dUJ2cVBEOHBQVXBDMnErdHQx?=
 =?utf-8?B?djlIMW9ZOVR1SkRFRTU1UjFncE52RENXSS9EK05OUHM2bTJDOWhKNVFxNzhU?=
 =?utf-8?B?a0p6bVVLQnZWcmhkcXpiekpTcm5OM1lFaEtvMEd6L0ZXano3OGVQSGVIb3N3?=
 =?utf-8?B?eVJpb0hwblNEZHN4elJidlc1Ym15QkxZcHpvangzNnhlUGFwT3hXMlA4R2lK?=
 =?utf-8?B?anZkb250ZlgzcitZSjc5WVE5OG8zU1VKUWZ2UDN1SDZEb1ROL2NKTVl2cWdT?=
 =?utf-8?B?M1gwNU92YkJ0WWlNSVhDVUQvSkcxUXdsQ0F2T1k5OEIxbmxXY3RmbFlZWlZu?=
 =?utf-8?B?U2hNY05rVmphNW5zOU9sWGJxVjh4Y0IxcVVHdnZZQmVGa1dnelgzeHM3d0cr?=
 =?utf-8?B?M3JJNkwrOXpvQlMydElrL1dsSmJ4QWNIN3hBditjZlFDcUY0QkJReTR1UnlX?=
 =?utf-8?B?RU5aUFl0TDMyZGM3WTR1YURDMnNJREJVWEZseXp3dDZ2NVIxZnBiY2pCUWky?=
 =?utf-8?B?MnNoSnFoLzFaT01jdEhXQXFhN2ZqaGVQNlk3WWFuemRDRXhBbXdYYWpPdTR4?=
 =?utf-8?B?aUw0ZlN4aVdYaFFORXF6UXdPUkFzRUQwcUNYUW9yL29VV1Z3aXE5MW0xVHIy?=
 =?utf-8?B?dExzREVJbVNzR21EcUxKSWdWL3hlNFBsdzBqNkZZV2NMZ0FsTFB2UmJqL2Vw?=
 =?utf-8?B?cUtiVFJGcytEc2hBQzl4Q0hUelpTaUY2UzhxbzJKaEVSb2tXL1JEdkcxeFRJ?=
 =?utf-8?B?QW1xcllyYk1BYkVqWFNCd0dIc1ZZby9NaUZvQkR5S1NtdGU2dTJqV0NCT013?=
 =?utf-8?B?WTdKVnZxcjAvMlhhclY1RDZuZUNKYW5pckRTWk9JM2R0Mm1DZG5uczNxRmVa?=
 =?utf-8?B?NWE3VFIrb2dQemZxb0VndUEwQWlzU0FIbGFuMFpaQytVc2RNZk5PVFJWdWpa?=
 =?utf-8?Q?cdzIH26imT/gN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee147a06-15e7-4c73-a09c-08d920433323
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 12:38:44.1709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0X8JjVVR8imWDeNJsA7M1GcW66hfdgVs4NcpHdL5g8AQcHNDS2bQoDrecRhkGQjCcfhNxCieh1wV0oM3XeFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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

[AMD Official Use Only]

Thanks Christian, I found some more issues as well, I will update and resend again.

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Wednesday, May 26, 2021 2:03 PM
To: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/7] drm/amdgpu: move shadow bo validation to VM code

Am 26.05.21 um 12:10 schrieb Nirmoy Das:
> Do the shadow bo validation in the VM code as VM code knows/owns 
> shadow BOs.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++-------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
>   2 files changed, 9 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 90136f9dedd6..f6a8f0c5a52f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -396,10 +396,10 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
>   	spin_unlock(&adev->mm_stats.lock);
>   }
>   
> -static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
> -				 struct amdgpu_bo *bo)
> +static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_cs_parser *p = param;
>   	struct ttm_operation_ctx ctx = {
>   		.interruptible = true,
>   		.no_wait_gpu = false,
> @@ -451,21 +451,6 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
>   	return r;
>   }
>   
> -static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo) -{
> -	struct amdgpu_cs_parser *p = param;
> -	int r;
> -
> -	r = amdgpu_cs_bo_validate(p, bo);
> -	if (r)
> -		return r;
> -
> -	if (bo->shadow)
> -		r = amdgpu_cs_bo_validate(p, bo->shadow);
> -
> -	return r;
> -}
> -
>   static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
>   			    struct list_head *validated)
>   {
> @@ -493,7 +478,7 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
>   						     lobj->user_pages);
>   		}
>   
> -		r = amdgpu_cs_validate(p, bo);
> +		r = amdgpu_cs_bo_validate(p, bo);
>   		if (r)
>   			return r;
>   
> @@ -593,7 +578,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	p->bytes_moved_vis = 0;
>   
>   	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
> -				      amdgpu_cs_validate, p);
> +				      amdgpu_cs_bo_validate, p);
>   	if (r) {
>   		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
>   		goto error_validate;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index da155c276c51..f474f15ba344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -696,6 +696,11 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> +		if (bo->shadow) {
> +			r = validate(param, bo);

This needs to be "validate(param, bo->shadow)".

Apart from that looks good to me.

Christian.

> +			if (r)
> +				return r;
> +		}
>   
>   		if (bo->tbo.type != ttm_bo_type_kernel) {
>   			amdgpu_vm_bo_moved(bo_base);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

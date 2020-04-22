Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD2C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 15:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0D12076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 15:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KIArjeOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0D12076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F0D89F31;
	Wed, 22 Apr 2020 15:43:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5DB89F31
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 15:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQLDKi63EiJ9IQLDVg9z6Y4V/QOMoau2H6swJEUk44hqcpLnMWwdOXCarYSK5pnRu3JjX2GUCXrLTo+jafY+lzMNfua1EScEX9vrd6DbPCtXta2F5H8qnNUrkM9smFRSJu7+TO2gQIbRojTRQVv/e7YXX5l/vSO38o+l2u3mHeOEPkLgjeqicuj0zJHhSbF359PLJcA+P5APN0CoThJNlE4QZDvmMV16Sy5KGKKt0Pytf+Ocyfvb3AVL/uFoBSmlJP6RZgCN4wlJSevUMmqh9ByubwKkr9pjHNB8fchGU845MQZ5tAbQYZOZARgdhhkNSXQkT4vbhiDJeXleUMgddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIZhxV67Yr2OSFuO9umx08qzBo3VxdV+z3z8dSj6EqU=;
 b=Ust8phLfFpclGkF5QJVDTTeWswPiNhqL1JT3CZ+aM+XfyCHtbA/WV/i1jOd7eSx4xecdT3owcuiZQS91JVYrD+Nk5/dCjt/5Ohp//S+OnrsNt4jseULSolB5o3geJGmXff4eYLHHSc3nwQlGLTxxt12LuUB0w7BkTvfrrTrPUkef/fDJCRxoZkKJdWWW9gQbs3Qes5iyVB/vL83wzrD2nsxEHu3Omu9gj236zSTvNK3D5X1Rwa4vj47RSnHE9dBGLPyezF00XwEyC0v2/reLxIM262SYbEOcrmVgQ5PTAHZAvsIcZTik32I6kOSodzyofD1dIEthh75oskQM6VDBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIZhxV67Yr2OSFuO9umx08qzBo3VxdV+z3z8dSj6EqU=;
 b=KIArjeOSssf6DckWFNk1KMMHcaKGJfH0UW4XYXPDc2zlsXjB9yIZvhVXw3PCzJUUyzD9mAl0GK4OtctCd1/dbel4ZkdrMopHegDC6Iw9IvkhY/Gh7j/x+PirsZhgvDJumDWv4yR6002YWmtSbfimL1FHksm6XRTvn81m2an5PLE=
Received: from BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 by BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 15:43:51 +0000
Received: from BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::559d:610f:20d3:23bd]) by BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::559d:610f:20d3:23bd%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 15:43:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Tao, Yintian"
 <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect kiq overrun
Thread-Topic: [PATCH] drm/amdgpu: protect kiq overrun
Thread-Index: AQHWGLVlexbJPjDgzku1D7lh1cyg9KiFOa7ggAABWQCAAAregA==
Date: Wed, 22 Apr 2020 15:43:51 +0000
Message-ID: <BYAPR12MB3240CD00DC6985E72EE9EB02F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
References: <20200422145027.2209-1-yttao@amd.com>
 <BYAPR12MB324027891F92EFEE9CCF5E85F4D20@BYAPR12MB3240.namprd12.prod.outlook.com>
 <2506b93e-b3d5-25a8-1487-14fcf08c14dd@amd.com>
In-Reply-To: <2506b93e-b3d5-25a8-1487-14fcf08c14dd@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-22T15:43:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ad3e7768-9830-4117-9b7d-0000f302966e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-22T15:43:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b48068bc-ca73-4b2f-866a-0000286e67a6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-originating-ip: [2607:fea8:3bc0:316:7809:5b9c:9bf3:2f61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06d7727f-d55f-4d9d-555b-08d7e6d3f4ba
x-ms-traffictypediagnostic: BYAPR12MB2822:|BYAPR12MB2822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB282299AA10A6D0193C66B0D9F4D20@BYAPR12MB2822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3240.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(186003)(6636002)(9686003)(966005)(33656002)(8936002)(5660300002)(81156014)(6506007)(316002)(45080400002)(55016002)(7696005)(478600001)(53546011)(110136005)(2906002)(83080400001)(86362001)(76116006)(66476007)(64756008)(66946007)(4326008)(66446008)(66556008)(52536014)(71200400001)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NSAMXAgtx6yWGyEzA31JBbUGci48A2hNbldAhfaiYPVVaZ0UX7Kh5QGg56s4JQP6LuSIobpvWp6gPTmHvXVdP2zo5ltw46BTAhTMwxZp326FGm6gzUiANIKfDGZy1INv6KMT0uCL/2nc83VHANfpMFGGWIBNrU/XV+iAyPl7VCK5LKayT0QRbSgxnBpC5YNWl5AvRjJ+ZoQStSgw2dmBxBmO709uR/JpWFjdtFgX2Vz/X3KX352jrqBKBcTPkKB8LqoIULC6hcjMmiYJarjPD1QoSji+lSvgFvx0ZBnxxpgFOa8vkWFexE81NB50ERoUkwPV6xOhbhGhw+6+X6ByAAm7sThpDmTZ+uOb48u3TK8Cm3A2V0RFZCT2TvObvzugBjoIycM1o80ifcbq4Cj9aaTjCaRQ3rJUR3W5g0fJm+Dg8MixHgxHehkVzym2l9ErEHHIge9XwppmFyZxvUpixw3MKqJNAFgW+f2lRSPsYYcwKRJ89tKz6f4T1t699oQHubkPiUi5k2E13MIgPZtPfA==
x-ms-exchange-antispam-messagedata: bsTFifJY7uQLpRWp1vALvAKeIKyhRcAgud60YqnDvle621KbwuL3c+7p4HAF9AM31gvfjGHrK5fNqq7pF75HFBxB6PwMN7shmtVEHyf+kQKWFh7Vmb/Z8hZMe1CDjdGPxCnm8LAJd2BQ/0Y3rRrF8rAPwRKm1wo1W+diDcbZqb+abiA9dtawDzdmwpC+rzNZBkPpZBTSZUsUPhJT3lkiWw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d7727f-d55f-4d9d-555b-08d7e6d3f4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 15:43:51.3065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kMLorTz5CKYoWsDmLj4JF5C+0/gNgveyM1D8l//0cet79aQqD4DBenly/jrtp9V+6VhwbfDtDn3sDnIDtEIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2822
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I always has an impression for each submission,  once the ring be allocated , before the fence be signed , this ring space will always be reserved . If this can not be guaranteed , it sound a  big issue  to me .   Can't  we  check the rptr write back  to determine the available room in the ring_alloc ? 

Regards
Shaoyun.liu
-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Wednesday, April 22, 2020 10:57 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: protect kiq overrun

The amdgpu_ring_alloc() function checks if the requested number of DW don't exceed the maximum submission size.

It does NOT check if there is enough room on the ring. That would require MMIO access and that is what we want to avoid.

Regards,
Christian.

Am 22.04.20 um 16:54 schrieb Liu, Shaoyun:
> [AMD Official Use Only - Internal Distribution Only]
>
> I think each  kiq operation will call ring_alloc  for the package space  , why  not just check whether this allocation is succeed or not ?
>
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Yintian Tao
> Sent: Wednesday, April 22, 2020 10:50 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk 
> <Monk.Liu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Tao, Yintian <Yintian.Tao@amd.com>
> Subject: [PATCH] drm/amdgpu: protect kiq overrun
>
> Wait for the oldest sequence on the kiq ring to be signaled in order to make sure there will be no kiq overrun.
>
> v2: remove unused the variable and correct
>      kiq max_sub_num value
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  6 ++++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 30 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 +++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  7 +++++
>   8 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 691c89705bcd..fac8b9713dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -325,6 +325,12 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   		 mec, pipe, queue_id);
>   
>   	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		pr_err("critical bug! too many kiq submission\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index df841c2ac5e7..fd42c126510f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -323,6 +323,12 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
>   		 mec, pipe, queue_id);
>   
>   	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		pr_err("critical bug! too many kiq submissions\n");
> +		goto out_unlock;
> +	}
> +
>   	r = amdgpu_ring_alloc(kiq_ring, 7);
>   	if (r) {
>   		pr_err("Failed to alloc KIQ (%d).\n", r); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a721b0e0ff69..84e66c45df37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -321,6 +321,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> +	else
> +		kiq->max_sub_num = (ring->ring_size / 4) /
> +				(ring->funcs->align_mask + 1);
>   
>   	return r;
>   }
> @@ -663,6 +666,21 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq) {
> +	uint32_t seq = 0;
> +	signed long r = 0;
> +
> +	seq = abs(kiq->ring.fence_drv.sync_seq - kiq->max_sub_num);
> +	if (seq > kiq->max_sub_num) {
> +		r = amdgpu_fence_wait_polling(&kiq->ring, seq,
> +					      MAX_KIQ_REG_WAIT);
> +		return r < 1 ? -ETIME : 0;
> +	}
> +
> +	return 0;
> +}
> +
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)  {
>   	signed long r, cnt = 0;
> @@ -674,6 +692,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_read;
> +	}
> +
>   	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   		pr_err("critical bug! too many kiq readers\n"); @@ -728,6 +752,12 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   	BUG_ON(!ring->funcs->emit_wreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_write;
> +	}
> +
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_wreg(ring, reg, v);
>   	amdgpu_fence_emit_polling(ring, &seq); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ee698f0246d8..1ee59a927bd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -103,6 +103,7 @@ struct amdgpu_kiq {
>   	struct amdgpu_ring	ring;
>   	struct amdgpu_irq_src	irq;
>   	const struct kiq_pm4_funcs *pmf;
> +	uint32_t		max_sub_num;
>   };
>   
>   /*
> @@ -387,4 +388,6 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry);
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);  
> void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, 
> uint32_t v);
> +
> +int amdgpu_gfx_kiq_is_avail(struct amdgpu_kiq *kiq);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 8c10084f44ef..4b027006d072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -57,6 +57,12 @@ void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   	uint32_t seq;
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq;
> +	}
> +
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>   					    ref, mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5b1549f167b0..a136e2229f7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4051,6 +4051,12 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +	if (r) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		goto failed_kiq_read;
> +	}
> +
>   	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
>   		spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   		pr_err("critical bug! too many kiq readers\n"); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 30b75d79efdb..77d8bc9c0111 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -423,6 +423,13 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct 
> amdgpu_device *adev,
>   
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>   		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +		if (r) {
> +			spin_unlock(&kiq->ring_lock);
> +			DRM_ERROR("too many kiq submissions\n");
> +			return -ETIME;
> +		}
> +
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
>   		kiq->pmf->kiq_invalidate_tlbs(ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index fecdbc471983..c429a2a5fe3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -614,6 +614,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   			ndw += kiq->pmf->invalidate_tlbs_size;
>   
>   		spin_lock(&adev->gfx.kiq.ring_lock);
> +		r = amdgpu_gfx_kiq_is_avail(&adev->gfx.kiq);
> +		if (r) {
> +			spin_unlock(&kiq->ring_lock);
> +			DRM_ERROR("critical bug! too many kiq submissions\n");
> +			return -ETIME;
> +		}
> +
>   		/* 2 dwords flush + 8 dwords fence */
>   		amdgpu_ring_alloc(ring, ndw);
>   		if (vega20_xgmi_wa)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CSh
> aoyun.Liu%40amd.com%7C0cd26307c0a149ebe0bd08d7e6cc84b1%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637231638419034830&amp;sdata=rxkhyMutFwb
> e5Nw%2BeBGiESW9wTdflDUo%2F4xEvbCbR6U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

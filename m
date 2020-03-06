Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB3C3F2D1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 02:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347E220714
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 02:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qf1aQhIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347E220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECE86EC53;
	Fri,  6 Mar 2020 02:43:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE63D6EC52
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 02:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvRBRG5U4rIQfnQW6XwVw0TGUsoBkFXa9Z7B0xG/pJ2yljkvze+8IILPlPQwwXWrK5htQvcM1F21f0FeEmpsgWgDbBEd+9mUQbp1z6VfHMrNAFcXj13FmS6XL5m0NWB2G3VJ8p/b1viFZVOK7PSG5i1LCWE9qIkHrzYZDIAl2Xg79y0KSnrZNckM86DeF0EtDIYsYcfQS8B6gtCwObJ707e7Q3A0aDoMBHxjFF/Q8euw7QsEfVq5Rz5C+qUp2WqC9RxPvjvoDykqDvnZYJVqaCZP9qe+q35m+I36RnYOAl1TkU6jw9TzFQbPyFl0d4wY0pZiR2nZYxi4fOeSZqNn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjFtoVO/q5d2VB/9RU+sLGZneNyWRBVOrvZ9CQCKldY=;
 b=LsCsnC1oB9Mzb8fiv21AsKqOz1Q4c5GPULUYPs2dqniwxOsU3n/v6aRLpNtnulq7kKIlJJoFPqCKhheISDv0zCbuvYIE3XtVZpkmZu+afLAw7OAxAiPBsL9pD0da5SsjuY92BsbwdHRUTFv0Hm39xWOD8frAMD5iYdgSs/JnR5iCGoja597dERGQdFmpuTLQaBxjgoPQqdDgOBOCzNsH2LnzBjlUeCfIv6WpwooKixRD/NbgRa5t0SjkKx7+PiyHTckkH55iCwbHC395l9ZUPfA1jHKBnqeK5FlamnASvxVBZ2ZyPv7qYhZW+2mjg5yVPVLmrVrKszYh3mLUgDEnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjFtoVO/q5d2VB/9RU+sLGZneNyWRBVOrvZ9CQCKldY=;
 b=qf1aQhILu6NVFfEuKIBgHZhX4qd1GKdEYd02aAX6Bm8mLDT0/k4HMmX3yK/uAvm0usSTQzftLw2JPW50N1AiuQ5zaSC8xiTUBmTcF2T0/F+F5yZktB/aHqP2mdsm7D/VUIENyu9FNl+NZosAGHHbUCOEOnopLYvwQnNRcMVbWHo=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12)
 by DM6PR12MB3946.namprd12.prod.outlook.com (2603:10b6:5:1cb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 02:43:20 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 02:43:20 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
Thread-Topic: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
Thread-Index: AQHV8vKnSywkeK8Qxkuvkj0jwkVCQag6LQsAgACu+tA=
Date: Fri, 6 Mar 2020 02:43:20 +0000
Message-ID: <DM6PR12MB39318F9BC634A3F219E4909D84E30@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
 <e3f3d158-49bc-7412-6e11-7a6977b7d714@amd.com>
In-Reply-To: <e3f3d158-49bc-7412-6e11-7a6977b7d714@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dffda581-704d-4a0b-20d5-08d7c178220d
x-ms-traffictypediagnostic: DM6PR12MB3946:|DM6PR12MB3946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3946198A9534236B2786218184E30@DM6PR12MB3946.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(52536014)(71200400001)(2906002)(5660300002)(33656002)(76116006)(64756008)(66476007)(66556008)(316002)(7696005)(66446008)(6506007)(66946007)(81166006)(55016002)(8676002)(26005)(478600001)(186003)(86362001)(9686003)(8936002)(110136005)(81156014)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3946;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqE2T0mRfbF3Mc4XugFJzlep7bG4DPfFsiAkiZByU/UksAWw66RZxm9QS/J21I2YYbd6VxNNvyemVCgyHrLucEX3cPuq2U2EOwF//BuHngrCp/P7q+y/gTOxUyw5IsI5Gjg8OQrpTtFqPSU9W0x14zPIe/vmQCk3C+Glw8UbK3CIwgJU/zS6hCmAHgpBrE7pFoF92nLYjAT+RLOsYXQzrgsGvQYpaY3xm1ixUwcbwhadkhSTgrV+zsad4QiV5zcIe1z0yhfP9x/YE4pZsPy2xMp2wyjCRMHlKRB8NRyhn7UQYjVC5ZcZLW8tQkpH56UR9STqJB2Ba5+tpYCN5rSIlnShgZwJGFr+gsEzp2GPin98cMgqH7qt/7Mv7SeTTXwb5DtnoyM+wutjj1OgPlAj2PiupXf9+eoFlOwhyPVrDnA+JkS1vz0zkbr58VX9ni0Q
x-ms-exchange-antispam-messagedata: 7LF1lz8ibWNaLlXBnBZaC/ut8e8+lwL32ibKFHyAYGnaPRBSfgMzDnhzY+hKW7ZOSgiPkiax5HCsb4ZB2pc5rOVeF80NDzmnmyJlgtDy81uC4hhjG1ul3m4UTEGrWZdxAKPadNOek/WHEqMyBJZrKQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffda581-704d-4a0b-20d5-08d7c178220d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 02:43:20.6637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYTnN1fTopiZ6ssmff6UlEeOgxKrYypS0EO+a5G2vPoo3bzmiUmD8V8MjwdFeUvu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3946
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No, this is an existed warning 

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Liu, Leo <Leo.Liu@amd.com> 
Sent: Friday, March 6, 2020 12:17 AM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on unused var

Is this warning introduced by your patch 4?

On 2020-03-05 8:33 a.m., Monk Liu wrote:
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index ae9754f..a41272f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -493,7 +493,6 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> -	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
>   	long r;
>   
> @@ -655,7 +654,6 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> -	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL;
>   	struct amdgpu_bo *bo = NULL;
>   	long r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

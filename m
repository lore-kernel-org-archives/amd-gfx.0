Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C26CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 13:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5104B10E97E;
	Wed, 10 Jun 2026 13:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAfInqet";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967C110E97E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 13:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvHhWkS79XTkYtC8/JxdwtEvEpM4pDBRpQ++WMwu1mI7l8he5Nq8pAgQeI0IQiSNWExeTcEDxo9zmdh9NPjW53zRLDLGC1VPrkD1xKcrvr4Sc5jxMjLLhiUEn3T4r2dR8O7g8FtEJfzy9OZeZoLSgMTLw6iPJ4Gax83s8bBSKWUwUY4gTGqUdXZiGHVDgqd1Jv7opPy9vhfCDv1ebnCBV8caAZoa+5X2QNxYTue0tJ5SnxFaob4LPx5LVZ9oRyVoHcZC2dKKMvHSmw7zVTtCg+KDDH/FfUFJ4URS41sT2b79fPsKYAb3jgeZ+YiwsGIiOULkvIkHKQXQvVgNbw0NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t03Hcbh1YduGl1rexNiQ0H1WAPo8IANttbytGFaUcvI=;
 b=lSTxATcyLlMva3QmnPACRrf0zb8tozAEZCKN1ZU9I2nhoCc0hV/DgnkhbXCTEXOAybe9aK92pMZ1q5QUzyUANe/Ah3REua3GvXJI+EZR0MUh75HpDtt5bReafyX5jCj7P+9ni5Wjys7guPzDmvg3jr3qbgeRRyKuRPlBOPJlp+z7buTLEfSaoH+Gh371M17pS0A04pXKqiU9tJCN55c01kYLejuS2nNK2sCennt5Fv5lIqraDjlgWy/EeL1CCOu1fN9lky0yruFWGkh0XPYIEsXppE1C9EuVl2Rk8tRBLxFXJnQZ01MNESPKvtXa+emAArmg60CBXbl0LrmQ6eZ4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t03Hcbh1YduGl1rexNiQ0H1WAPo8IANttbytGFaUcvI=;
 b=nAfInqet2NwFirgfUtuM4lnIal4AsUW4qAeDx9ialf4ThUfaekVnuP0aCtSQfKQ4sz9QF+MA0tOwABPd/frVWP292Lj6NzlFz/UymcyumPDWzSkbAarDvHVTp1hHYc6RP/oR1a7YrvVQeOZu1hIHGKxUaL8NsGRCRS9mJ5TTD8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Wed, 10 Jun 2026 13:42:28 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 13:42:28 +0000
Date: Wed, 10 Jun 2026 21:42:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Huang Trigger <Trigger.Huang@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Message-ID: <ailpsXqRT9CxAxOn@amd.com>
References: <20260610055736.951241-1-Jiqian.Chen@amd.com>
 <ebbf567e-cdb8-44bf-b8ec-1c0096ca740f@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebbf567e-cdb8-44bf-b8ec-1c0096ca740f@amd.com>
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 05067177-64e6-4bd3-b9f6-08dec6f61ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AIF9nQCRycfvxH9GIqxyE70hjh72jKJ89sWc6NsuJsUc1x2md62epEb9w0t2D5zGFlYVQ2Kom3J0RAXwyTj8SH6CEwKrT/5u2RjlPUTEHhhNbA0i+b1jub1dRN3HwND7diJGC6E2rXVUB9llyLtp4dkvd9T0uvKZLq3cBraXxSiH9blicYW/tXJxaJdaWPcH+va+sJ9nDRAdSovkZRdd5bLFXZtIio6fhkivlTq1+k6qP7CP9+bL/5YlYg69qpF2TXm+OaiofBhFW9Z13FHXEK7064+h51t1EnXM6N7zQTbHA15GTpxUwLMhIMsUkGNlmvthyrQDVCHeG2wKhs2a+S0CJRthCKJVmeN/xfpfegbK+PR0SCq7KTvVpy/pbrNSN9QDC3mV0e5H666g6ANiNVkpA4FOyZGydKSygACd/CGRRBS/5uV+aHBmSs9KPYDBdChVX7x6QUf5chnxsSrcsdsN+NL6x0jHINULJzw81PEvLIgakQDjQZfEoy2RM5ninoa4lUhT4znIa4NoMEo01NBXsZvYuMmbcqZWnQoyZOGAWghgz3rsliOyE4HLNqxrUBiUwbHPfKJ+Yv2WUZyaKQ/pHj8lbJsPeceHC1PrH9zP3Q28He7lliQeEN0hBW4wwSPeIyq3xZdW7M3Q7g6zpboD8ywG4CXK1skhvrsePgCaNmXGKtvExrIrH279+L9e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dAdBalMXWP66UTkVyLMSryZcQjyLHlW52XjcAdQYB00rvQoa1VJp793WNY?=
 =?iso-8859-1?Q?fcKduVOn1UygwNDs3vAnHki+vSmocq9gTLVH19B5G0HrN53XfefLzj3LB+?=
 =?iso-8859-1?Q?EoyOCVUQUmK/SfM+OKAN83/tv8oY5AZLTpkYp404yiY0KwqVY99Q4ls8Ib?=
 =?iso-8859-1?Q?vKPubqwPMWsPUgbF/Uj6xYle5qynjogKjWgzyQIoDXlT9gvVd+okLPOUVI?=
 =?iso-8859-1?Q?r/hLflHVTCePVASdSunKEJNSZPD5k1CZ9UlNmqWPcm71KVXTyiFae9fjJa?=
 =?iso-8859-1?Q?KnMmy4Rje9jIjzWKLuT2wZxRKbJa3r9d1lNGXxQLkpOz2AqtaA26qbPYmf?=
 =?iso-8859-1?Q?wT1sMp2PbJQqBdJRksXWy3YoaDTLRh2YsLXtb7jkDfoxkCdUdNQ3gfx3WS?=
 =?iso-8859-1?Q?+CLMAqpQ9fFE3bPD6UUYLYEgedQ57X1OBqYQuYr9rnes6xVK/6MwVzI7t9?=
 =?iso-8859-1?Q?cKcdp+g3Hy/ucjhWRUtGjw5Zvx5qSJaFvFGcn4oz/a0fyKm7ql0HAzrc6s?=
 =?iso-8859-1?Q?vJy2z2eoap3WIOK7RM+2nXazvPWAx0LD+p6iHN+8DtYFBrrlQ9mpAcWmGi?=
 =?iso-8859-1?Q?akuB/bBT7/y4zaO4bKynAocdSBWq2DzUvwG/VvIb6tX1EtI3bsS/KftKn0?=
 =?iso-8859-1?Q?7+fzEcb/GxhaxrN7stQbKQAQ7/jvM0n9sO4HpWZhFoOvCNGOnFNEQL6/6m?=
 =?iso-8859-1?Q?EZPi7CAVRxupDmpvb6Ivz6iGn3V8M+KNFBTdsj2YgYqO49avVcJ8S+VHRA?=
 =?iso-8859-1?Q?Pzlo0mR98grx/xwobTKKBht4+9vqdnH4m6+pr4MQbCwSHRr3BviQa52BYS?=
 =?iso-8859-1?Q?m8JsDgEgYdEvBLIOWS0vz8n30L1zwOgDG0/5iU+2Aqn0p70SFYQhyXdaHu?=
 =?iso-8859-1?Q?awX31N3JPRfWkZCORi0GsJbSCb7xwJzRhOufF0pW7dD7DqXFtgpluV6SHo?=
 =?iso-8859-1?Q?tKKrJfuj43S8dUU5SeHqqMFa7rHsRZeL0W0zAs27cwinUz1ubr8xVkn4H3?=
 =?iso-8859-1?Q?I+FExoft7nibQC10IlUscSTiRYsMpR0CCbxZc8NRGmh+oNcxSnJmqeSpky?=
 =?iso-8859-1?Q?mcvYVDezQIRfvd2tHIIoRIW9gnT+1RHL551w7uNwkP/uW/GscnqJqoBzxn?=
 =?iso-8859-1?Q?ZuXKjMzS6qX/IZdNN6ZNXsLfkNFaxRYmmxWpnEzIMY5nNTAqtYYMyykexX?=
 =?iso-8859-1?Q?3ukw5Jy/hL+/wdykloOmW29xR04yPvqI+ZVhd+V/3EZ7Hu2cq1c7fPDC1j?=
 =?iso-8859-1?Q?kKqg1c8Hs4sarq/MiOpIDEXRvjyiP4glBGz0X1y9LsVf+BaWLPacmPcoEK?=
 =?iso-8859-1?Q?yDzsp9i9m6XHnTKuVFCTw07+zMhsX9e8jacLguEm4v4cQhpc0VwrZhxvH9?=
 =?iso-8859-1?Q?s6IHqM4NBWZC8ot4xS58QDugP23qGqHvLCQkM5Y1mIRKh0bwpGRGe5dQq8?=
 =?iso-8859-1?Q?PBCbsKGHyblfZ5yd9WhnKxx7P52ng/q+MfpJNup5+hZCYBezgyZcLM+efR?=
 =?iso-8859-1?Q?NQAoW167+fno3Fu5HeCx6K/U1wFAMYdbvCWeCFE0x2Ly5ilQuRa3dmRZs+?=
 =?iso-8859-1?Q?un0uVVLGEnYabTFa134qbWYi0f1B6yayfSaQ8MuJX7xEVBaKYBnO7dF+pR?=
 =?iso-8859-1?Q?6mdqTi5YpTWDGT1pEV1/NKK1sL6Tcf14FAZ+eDfb/0lEyJGgN+W4thWEKU?=
 =?iso-8859-1?Q?7Qrj5e5Z3q8uujGdb7oJwWE/0yKJh8Br97Cz50tnK925l4XDKcweX9bD5e?=
 =?iso-8859-1?Q?BY1yJYuDw3lYjVDVvPkueSFbgaXQG7s05EJOM3H2zGU8hi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05067177-64e6-4bd3-b9f6-08dec6f61ca6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:42:28.0557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAZmnDGA3MmGx3n3MdZ4VSCjUei/2Jdl5C1DLoT/e8kiyHryNn3PORfkIlXplaQF72f7yrLjYb+NX9piGFzjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

On Wed, Jun 10, 2026 at 09:50:18AM +0200, Christian König wrote:
> On 6/10/26 07:57, Jiqian Chen wrote:
> > For Renior APU with gfx9, in some test scenarios with disabling
> > ring_reset, like accessing an unmapped invalid address, it can
> > trigger a gpu job timeout event, then driver uses Mode2 reset
> > to reset GPU, but after Mode2, the CPC and CPF are still stuck,
> > that causes compute Ring tests fail. What's more, the HQDs of
> > MECs are still active, that causes MECs use stale HQDs when MECs
> > are unhalted before driver restore MQDs, then causes compute IB
> > tests fail.
> > 
> > So, add sequences to reset CPC and CPF after Mode2, and de-active
> > HQDs of MECs before unhalting MECs and mapping compute queues.
> > 
> > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > ---
> > Hi all,
> > 
> > My board is Renior APU with gfx9, smu12. I run a testcase that
> > accesses an invalid address to trigger a amdgpu_job_timedout()
> > with disabling ring_reset, so that driver will call mode2 reset
> > directly. After mode2 reset I found compute Ring tests and compute
> > IB tests fail randomly on random compute ring.
> 
> Oh! It's really nice to see that.
> 
> We had quite a number of bug reports on this issue, but were never able to reproduce it reliable.
> 
> IIRC some Valve engineers ran into that as well, adding a few people on CC.
> 
> I can't judge if the proposed fix is technically correct, but it's good to see that there is some progress on this issue.

Thank you for the recognition. Jiqian is currently working with the
hardware designer to investigate this issue. Although the issue manifests
as a random loss of the EOP interrupt, once it occurs, the mode2 reset can
be repeatedly triggered by the compute IB test loop, causing the mode2
reset to never complete and the driver to become stuck. After applying this
patch, we are now able to pass hundreds of iterations of the mode2 reset
stress test.

Thanks,
Ray

> 
> Thanks,
> Christian.
> 
> > We checked the scan dump of GPU, we can see the CPC and CPF are
> > still stuck, that may cause Compute Ring tests fail.
> > I added printings in driver codes (gfx_v9_0_cp_resume), and found
> > the HQDs of MECs are still active, that may cause MECs use stale
> > HQDs when MECs are unhalted before mapping compute queues (restore
> > MQDs to HQDs).
> > So, I send this patch to fix above problems.
> > There are two main changes of my patches:
> > One is to reset CPC and CPF before resuming KCQ.
> > Another is to disable HQDs beofre unhalting MECs.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 40 ++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 47721d0c3781..dc0978bc312c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3944,7 +3944,8 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
> >  
> >  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
> >  {
> > -	int r, i;
> > +	u32 tmp;
> > +	int r, i, j, k;
> >  	struct amdgpu_ring *ring;
> >  
> >  	if (!(adev->flags & AMD_IS_APU))
> > @@ -3967,6 +3968,43 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
> >  		gfx_v9_0_cp_gfx_enable(adev, false);
> >  	gfx_v9_0_cp_compute_enable(adev, false);
> >  
> > +	if ((adev->flags & AMD_IS_APU) &&
> > +		(adev->apu_flags & AMD_APU_IS_RENOIR) && amdgpu_in_reset(adev)) {
> > +		/*
> > +		 * CPC and CPF are still stuck after Mode2 reset, that causes later
> > +		 * compute ring test fail and then loop Mode2 reset infinitely
> > +		 */
> > +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> > +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> > +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> > +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > +		udelay(50);
> > +
> > +		tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> > +				GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> > +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> > +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > +		udelay(50);
> > +
> > +		/*
> > +		 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> > +		 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
> > +		 * Otherwise, later compute IB test may fail
> > +		 */
> > +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> > +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> > +				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> > +					mutex_lock(&adev->srbm_mutex);
> > +					soc15_grbm_select(adev, i + 1, j, k, 0, 0);
> > +					WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
> > +					soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> > +					mutex_unlock(&adev->srbm_mutex);
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> >  	r = gfx_v9_0_kiq_resume(adev);
> >  	if (r)
> >  		return r;
> 

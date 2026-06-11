Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C215CD8CB9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 07:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C60010ED38;
	Thu, 11 Jun 2026 07:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuKQDQde";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D9010ED38
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 07:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kboT6R0fU+38zptHrHD5fRX9me7a3tCYccLJDxCza0TiE9oTMCKYYyunNhjuR4PoDZb7SUml9V+xK3J0R5EcpE1cQaKekd/L0ywuAqHxH95iUrTEv0Taz+yY5oqsE0BDlH7doZm15AApXmgWc/4cUjuzsX7AcNMRhWwGk45/9jN2b7l4VinZlirF+YEmAX+gz4IKWBYW35hiBlnKTQB/STT0Lg3sWVmHQe7wNozgjaBIdqJ8TjNlhEnjyee6rQ3Nv8GFo/CDGQ2AqtfAU9xlbYpwCaWCfnCnT+G8tH0Vw3ybbqMOHLtUCD6VhiCJ2UT0UFiLDijdPK5kGo6MtyC3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D02IWw1fT+fgTtwhVFp3TrqVxE25vuBZeu6xESowThs=;
 b=pGMq9Umd6b/BUZ7z9DQlvmTRogNVZ2sjy7T2iJXdYw2h2cvViT6u3jEmkQzBXiJDSQo3JARBAjC/9nw4EkbE0bTBO89YQcSGxzmzwBBgQll4lzuLv22iphVfgLfoThwbAHqYzlpfYReK1aGx2IPP2Chkv/MgLHLqwE3DeHcd/jX4xf9GUOLX4ymQ9dCzoTQrEuLBhWwYnw+fatDRwiNfuh/cMPyYeRErSXRkIKpTbaSqtMFy7rrb7NpEErGEYte1UpBXnWky1qyLm2f2G9ugBSKc3P/5/5mHp1JjoxSStnkFFNll68Ityw/6SloC2O2XXc7fIaEIc2m6J40yfnF4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D02IWw1fT+fgTtwhVFp3TrqVxE25vuBZeu6xESowThs=;
 b=RuKQDQderEshJ53KYYYja7mJ09VNEvbVsMzDgx2pBcjDgWv+mXgPLeEtEGzGvYlgW/HoTjOf49TPcXL8sFVE1a8NvoT4Fn1dBjrOJUb+zaJFY7Ir4A+gmJIFYIsF+pYNeLUisU1ZGK/pCyljRzpTLjrKMdk/pe1MQuk6rIu1H30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 07:42:54 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 07:42:53 +0000
Date: Thu, 11 Jun 2026 15:42:34 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Huang Trigger <Trigger.Huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Message-ID: <aipm6uuVyaImlwZi@amd.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
 <aipVLOVnOxst+zTS@amd.com>
 <fe555f65-8f9f-4a8c-8c9a-a2479d3f8ec4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe555f65-8f9f-4a8c-8c9a-a2479d3f8ec4@amd.com>
X-ClientProxiedBy: KUZPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::11) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa2fcfb-2c7a-49a1-f7cc-08dec78d0bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ik1mI4MZiOV1dZxzCIN3QUUC7ucPp/N3IqeNya1mMEF8RLQR3oIo5xxhorrWcggauZM1GChDE+/VU3l5zo8z8CGk1hFHfVwDF6NLD22np0L6x/QJW4pgEGaUaz8ChK4IO/U0sk/8dPmhAlM/sPDAsU3+e1n5GrmBu8TI67dVowI293rhb+1FkllMhbViuQsfUvcOcUhbXjVNs8kcphqttwJXOijeH41FzYFgtqr/L3vmVbEphisUntJ+Oo6Gh2tiIPPR6F55ewHtKy9aOsJL/DgDIGDD2WL6l6Mmjl2XVW5CxZS/a88hUAyq5yukS7HZPnOZc/LZ87k2fTKmmawQjPenTid80sQVyip37MUXOBDCYLVW0c9CsBnPj2+IenQp90orA1M2MhYaHcB9jD7YRGeuGfqfhUPFcR583GAy1Qk7rXVIHt7mt5dkzFUDlniNGVlkuEWPNNiyhRisSdJ9waSe9kCQ67HZIjZQbZQDlydnOQjfNHBU//AeDipzB2fr3ROBkrnLRiw0LaswlQ6ITgHWG26zn1t8KzMO5AHCVTOCKvSbYg44jsZk9DdI9c7bxI6wmNgaGFs6qDj0j4D8+xoWhk8tg+cpV8K1Xn7qrYndaiEF9vIBm369gmlJoj/eEdfgtMn0EF74QmykauBCkoZH5d+gWnOKgjAauDHQlLmjEM8q0nrwThMBtyPPmF1G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2yLViGh/JXXeOF6brWnv6ZSTVEq6f9NvNfNsm1wY5Qcq6BBEDvwkUk1N1A8?=
 =?us-ascii?Q?tbmA7zZ7pEe8mw8YhVGINWvKNgIv68UNIRE4c/+BLC0n5kZPaaLE5dJpqPdd?=
 =?us-ascii?Q?Ffxvfjsc4AgAE1vs38hOnCMkSTEMjQOpAt1kwVvBBeh3wQmpSLhkFylsaCYW?=
 =?us-ascii?Q?gARztqNDdu+6XUK66XVQc3MMxSSEO/dIRxu6pOhWdbwzpkuyqQ3QsRa3VilI?=
 =?us-ascii?Q?M05uJhGEUhzLFLVu8hglf5dx0+VzYB6RPjYRP4SV+4Lqa8YMIA1EnfUe53hZ?=
 =?us-ascii?Q?CeU3Azsec1LirgdT4j4KJUp+2Hyc+MY6QH/pTJ6JM8rD523myMsaE8nGX4zB?=
 =?us-ascii?Q?LWp66azCREplZOSCGDKPlLFf7vDE5jXZOObEBwcFgxt0m5UUdMfoVysj5loC?=
 =?us-ascii?Q?p28J3h9EUh7tUqynPpS7Pqi0TfSRl3fYDSoMiaNIJrOmSA0ng8AG9C2xIwMm?=
 =?us-ascii?Q?F61UbcjKbau1DCGJ17WGpzc8E3lrep7n1WcyMVwJwasMYgmnHcBkGgm11fTM?=
 =?us-ascii?Q?1AKrtYjW5kTEoCGYGYq1e9nVo7jRF+jc9V0A16buwPIp+USSz64FwLKePivP?=
 =?us-ascii?Q?zbj4wjOkM42fbBNBHR/MDdKFz1qK0mdmS9muf5sadBNsF6d0zi98Ezoa9NJC?=
 =?us-ascii?Q?1o0tYcBusex/Vjy89TRtACjHukqpcVkqw95QfuHdriJjmDxCPWtIIAR473rc?=
 =?us-ascii?Q?hZESCNSl/5YeI/WQS40ZWm++SNvc1jNihJ/KWpX1XNFRdD/Sn6nqQ/KcdgAw?=
 =?us-ascii?Q?/TzbAbi8hXp9UsHnMPS6N2egWAMdV5wXGCFSgJPsVpfJ1KiNpCuWUx14jSsv?=
 =?us-ascii?Q?q2rBsbk6rR/3GPwGO9tLrjqs/KlvxRF3hvD++MiUFcXKPM3Xeiry29IPsy71?=
 =?us-ascii?Q?kn9dGFCDjgDbhiawTAAZozDaZEXEuu+ZSz/eQbYusDpeFNrU28dSRkAPOzgl?=
 =?us-ascii?Q?a0iB+ttWBEBBD5Y83abNXPb8wmAuPR+WzfbSmGmhcuay99qW+XqUpFb8v3c2?=
 =?us-ascii?Q?afhbHTaiN3MML4pIjrvqS+BT7whHYVOW9MJ/rWp3CN1/805HCOI+Rjmtj42r?=
 =?us-ascii?Q?PPj/iqkXMfVhulNhk1n/CAw6yW7Ic8E6wkngVn2+pLyrAIOrEcWANck7cznp?=
 =?us-ascii?Q?U4Md/AXJ73DKa/9wFEQJMPFslTYlB1FbUJktBTP65IuNpOyvczRRiQApcytt?=
 =?us-ascii?Q?+rFnCRhU8b9lL/h9HpVkFwoGtooLc+LymrS8LE/K1WCuh0DFKJlOoce8k0yu?=
 =?us-ascii?Q?FeBkV2INAzaf3FxuAZMXVnFAPyKt/VD6RSkcyAYQJ9XspN8THksQX2FDb130?=
 =?us-ascii?Q?L09Lg04ibRIRvYa0C3fTS7OJM6g7qISfwU8ggGfk7IvJ4mfmFlf2i+uMmdgZ?=
 =?us-ascii?Q?fW55Zb+5sIJz571nAjAKxx3ZIp/KSyT2gLntNSqRgQj9O+0aqX1TDF95dFmI?=
 =?us-ascii?Q?RfeWZ7gcu4hIBHLvPGnLydfaHTIGN2+6qNK/XXrs04cGNXD5icuNqjETbmgD?=
 =?us-ascii?Q?3E3P55LYT74a4R4zO9n83A7ldvqFoytpHcoA/hPi52j1A275sFKZK2ZmdZxA?=
 =?us-ascii?Q?kDEb/bS5Dc/IuBHZTRPdBx8OdTBceLB4M4Bcs5mAI2FLwP3EVeskIY5b/8lv?=
 =?us-ascii?Q?olNrWr/pD5GJgOC264A3OEF0xPe2mDpHWQodIjslhCy1L5QvRZBMh+Czw3Lj?=
 =?us-ascii?Q?uo8ARoOAS1F1SXMz4RVYVlK1TOKbtXoqQZlydHKuAIcqmvnKR9OA9TvoZwSJ?=
 =?us-ascii?Q?7hTo30iM+w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa2fcfb-2c7a-49a1-f7cc-08dec78d0bd8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:42:53.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y14W50y+uNugMD/9O6w53hScypPGOhMwhC9ScNA27CYgHPOafwJHF+mb0APlJX4eO/vkvwdtFW3vo85thblhEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

On Thu, Jun 11, 2026 at 12:39:32PM +0530, Lazar, Lijo wrote:
> 
> 
> On 11-Jun-26 11:56 AM, Huang Rui wrote:
> > On Thu, Jun 11, 2026 at 01:57:15PM +0800, Jiqian Chen wrote:
> > > For Renior APU with gfx9, in some test scenarios with disabling
> > > ring_reset, like accessing an unmapped invalid address, it can
> > > trigger a gpu job timeout event, then driver uses Mode2 reset
> > > to reset GPU, but after Mode2 compute Ring test and IB test fail
> > > randomly. It because the CPC and CPF are still stuck after Mode2,
> > > that causes compute Ring test fail. What's more, the HQDs of
> > > MECs are still active, that causes MECs use stale HQDs when MECs
> > > are unhalted before driver restore MQDs, then causes compute IB
> > > tests fail.
> > > 
> > > So, add sequences to reset CPC and CPF after Mode2, and de-active
> > > HQDs of MECs before unhalting MECs.
> > > 
> > > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > > ---
> > > v1->v2 changes:
> > > * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> > > * Add reset Mode2 method check to the if condition that call my sequences
> > > 
> > > v1:
> > > Hi all,
> > > 
> > > My board is Renior APU with gfx9, smu12. I run a testcase that
> > > accesses an invalid address to trigger a amdgpu_job_timedout()
> > > with disabling ring_reset, so that driver will call mode2 reset
> > > directly. After mode2 reset I found compute Ring tests and compute
> > > IB tests fail randomly on random compute ring.
> > > 
> > > We checked the scan dump of GPU, we can see the CPC and CPF are
> > > still stuck, that caused Compute Ring tests fail.
> > > 
> > > I added printings in driver codes (gfx_v9_0_cp_resume), and found
> > > the HQDs of MECs are still active, that may cause MECs use stale
> > > HQDs when MECs are unhalted before mapping compute queues (restoring
> > > MQDs to HQDs).
> > > 
> > > So, I send this patch to fix above problems.
> > > There are two main changes of my patch:
> > > One is to reset CPC and CPF before resuming KCQ.
> > > Another is to disable HQDs beofre unhalting MECs.
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 +++++++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 47721d0c3781..d3ef45aa299a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -3942,6 +3942,46 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
> > >   	return amdgpu_gfx_enable_kcq(adev, 0);
> > >   }
> > > +static void gfx_v9_0_cp_mode2_clear_state(struct amdgpu_device *adev)
> > > +{
> > > +	u32 tmp;
> > > +	int i, j, k;
> > > +
> > > +	/*
> > > +	 * CPC and CPF are still stuck after Mode2 reset, that causes later
> > > +	 * compute ring test fail and then loop Mode2 reset infinitely
> > > +	 */
> > > +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > > +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> > > +	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> > > +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> > > +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > > +	udelay(50);
> > > +
> > > +	tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> > > +			GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> > > +	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> > > +	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> > > +	udelay(50);
> > > +
> > > +	/*
> > > +	 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> > > +	 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
> > > +	 * Otherwise, later compute IB test may fail
> > > +	 */
> > > +	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> > > +		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> > > +			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> > > +				mutex_lock(&adev->srbm_mutex);
> > > +				soc15_grbm_select(adev, i + 1, j, k, 0, 0);
> > > +				WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
> > 
> > I think we don't need to use WREG32_SOC15_RLC here, because SRIOV GPU won't
> > access this code path.
> > 
> > > +				soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> > > +				mutex_unlock(&adev->srbm_mutex);
> > > +			}
> > > +		}
> > > +	}
> > > +}
> > > +
> > >   static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
> > >   {
> > >   	int r, i;
> > > @@ -3967,6 +4007,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
> > >   		gfx_v9_0_cp_gfx_enable(adev, false);
> > >   	gfx_v9_0_cp_compute_enable(adev, false);
> > > +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> > > +		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
> > 
> > If we constrain the condition to a mode2 reset, does that mean we no longer
> > need to restrict it to APU?
> > 
> 
> This issue is not reported on aldebaran which also supports mode-2 reset.
> 

Nice catch, thanks Lijo. We should still keep APU flag.

Thanks,
Ray

> Thanks,
> Lijo
> 
> > Thanks,
> > Ray
> > 
> > > +		gfx_v9_0_cp_mode2_clear_state(adev);
> > > +
> > >   	r = gfx_v9_0_kiq_resume(adev);
> > >   	if (r)
> > >   		return r;
> > > -- 
> > > 2.39.5
> > > 
> 

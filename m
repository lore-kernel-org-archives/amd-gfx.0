Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 03:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECAC10E389;
	Wed, 23 Feb 2022 03:49:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810A110E389
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 03:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHllgZxpTFJ0M8mOUUe5iJ6xIcGQ0LBxH2ujIzr/gEwO8rTfbddkIKebyxJJ8oet2LFwTQlxUwpAa3mvG5dYKQkz9S6KPqHjCIx00Kcg6N9g6v2ZkmxqpZywD1d2FmkCX+s18oOjnxYUVan0WLUnhdDXklYeoapB0QI257JW2aRdHPz9UrDqFFjrSAtEjg7LgoZ/Z0Pb20q9A+aRdIdZk8w+HDdhbuXARQhZqLb4VGSH4JJ1xyTpuzEqnWWAJdsryTesL821kaX/hBHvPDAac03nLTGwg1uZRmRuV8P+qG9VYX0IPaDZ/gyMtM92N/B3XFNwll+LFgMvneYialqMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdWbsR7HI3asFHzE7SplKmCzykp4kUmXrW7MjNj3yAk=;
 b=CVGseuanKYp2AuF7qDrNrh6CuQ0Gd9V8G/0EImfamcDxzokidvsOXfhEegulkPE7U9dPNJTT4xFR4zC71CCrRATkjasfqB/jmDMbKNcxKpEsRr6eJxy9KRuauODOYo6ZEfh5mFNAB+6MJEcWyd5fu0yEex5yG/ybo/isTOyDaIptdNhmRfhkhmqyY6I8lT9xzWzPJc7LFHZvfwtDunepMmdTWLm3zBnXrohQ43tcNiuZ8pRDtWMNsa2ZVLVDGQOc0QMzRBBUbEPLzmNPspfoEFF9zU9fW0rKUwgMBsW7ybibiGO1dko1DO/gR4cPxeqnCpw1gZsv3MddgSCxugCiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdWbsR7HI3asFHzE7SplKmCzykp4kUmXrW7MjNj3yAk=;
 b=IxtVvI5k3FSxzwB1hjQRCW8U79nQJRjLQMBVuBlSiohAzU7uYtc6igy9ihY65eS2pkEB1ZR3qsiC9dGX9Yo8DnBLVPVUnSZgB9s9xpEftNztY3AC1wlI65h5T1TrhC13XwYcGE6VOVwzNxWvugWxbjywTsHpLSO+j4BMOnt2cdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Wed, 23 Feb 2022 03:49:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:49:39 +0000
Date: Wed, 23 Feb 2022 11:49:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/nv: enable gfx10.3.7 clock gating support
Message-ID: <YhWuvKXYwPy8uUHw@amd.com>
References: <1645584155-20885-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645584155-20885-1-git-send-email-Prike.Liang@amd.com>
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed12638c-5235-4f67-4147-08d9f67f844e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5166:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5166E8D14FAD2D191828563BEC3C9@DM4PR12MB5166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UByyBTWyuF3nhi6QelwHk12S2CQB7ABoTTTJ1u/RvYWaXFmMceAhGF5j+ZIbPoAyPRQWBXD163Ku3MPYUuSRZaswJW7xvmFWQU+tYQCSl9V5t5j5sbmI+RoDAwWLPS7ad7NO09M2A79wlOrBM7bv1TP52OreXGAq5I3e/Dq/IUjfyUQH9yDuZYvj/yXwXtuxaOGjZPiFNIepXdvRUG8y1RDgqb1JhBLP+TRBQLVnxkJxsDn7LOMk/Wmh85E7bHaF+3/rT8cwTzvqdtkjB1C+ZDmY0rfxF2mFkMJDQykbBkDkQl1QCw+nPHKXGjGvVfdr7SikMpPGpQMkagjdlAOrFtYrDn438c7X6ctPHXDTWvX1wwmhDmQeWud2lXGTuNFrB/3w67phi3b6GaAMnkxlB/x0uXtj9db0z2sp8iCxSb1iUgFkoD8p8Wod1gGRAJFO1j7k4l5rzFaI11WbEE3MLK8pS9n36fOm5Eg6Cx83Gj4TzNHu5HXkr8SoyAPErOfbhdc8Hi2PhhAPBZtdjx+8M5rK1SMWqP2CaGKO/SQ2ITk+N6UqyPZtIotN3ZVjbFSacXver0pbaofPDj0AZB9T+arQ2p6fEnueLO9wKyyRdmJ0kEEGsgXBOZ6ZAhqEJ6RkvSXnkGr67EBYNZsOBQIYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(83380400001)(36756003)(5660300002)(2906002)(8936002)(2616005)(6506007)(6486002)(186003)(26005)(66946007)(66556008)(6512007)(66476007)(6636002)(54906003)(6862004)(6666004)(86362001)(8676002)(37006003)(316002)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JyxtKKI/r+1eN26HZXxq6KTQqGrzawvTxCTZTAgkPn8ChmTPHV2WV1d49RQ1?=
 =?us-ascii?Q?EH6mp2IPZ3dZ+sW71yV2PcLErfQMOkL9MKSRsiwk6NtbMPIoEXbbPZIb4ofr?=
 =?us-ascii?Q?8z15eo65WyBuS0GaQ9gkVsheCfBQ9Qz1SFNPNLDy+J2eSwTbxPHnLjypZj9R?=
 =?us-ascii?Q?e3gn6o4RthHsQZ0eqNlcapvj5zXln4wsXAdbe+nAxN7ALvrvpUa3HdiIVCyk?=
 =?us-ascii?Q?QJccQxaa6DPITjkwEJsTWFe5+BXMC/8sZ2fJGYn/LUxnuQAGBN2EdC3lEzTh?=
 =?us-ascii?Q?JGF1SMptdShDXJPvBDXn9zMscGwM8gD3jaMcwpWBNXpx/VwSIsGCwfBzMS3U?=
 =?us-ascii?Q?5hvATanFiaQWN8CjHxisj2ykpLl2SJmpm8xYm0eWT4/A5plsuCXclvgh8Hk/?=
 =?us-ascii?Q?3oJtcV0nloBJYhIJpCAQfWY1v61R66s+5G5VyPXznS0b/y7vQcBNzdCK7wme?=
 =?us-ascii?Q?bhgvo14lUfOiUzagQUDqlUI2lKc5vrQyDvj5CYg0K/rj3xizewguNebsWTwJ?=
 =?us-ascii?Q?zS9Xe1+wIfV0pD0I3nFEFC+zGAo0TSa4zy61SGOkZ8PS9yk156jnz19Go/yF?=
 =?us-ascii?Q?rEo2eMl5olD89vJ8bqoFgOPqYI2H4Kp0ZzzN30M3yGFa7rkkw9vWI0VoGcgo?=
 =?us-ascii?Q?V8090FTp0VvfmrG8rNm0ssFBnqzIErXD97kh1bhBzOTHhWJR9Cc8h7OcoRlQ?=
 =?us-ascii?Q?bMO87lAln3YpYJj6pSg3KymlQ4TE6WXgBNhapbu3ThsVn/MGp8oB3Nw73wr9?=
 =?us-ascii?Q?12EGCN4cZ4X3NmjOizLeDlN1EwYXIzdNauRJJh88paAUTRMzY8feByrXjhfs?=
 =?us-ascii?Q?WWp1SpApTP4WjRnfBEQIpRfKxq1DfDQR7J+ogd0prmVwlT/Q0gGCPseMm2w5?=
 =?us-ascii?Q?syZdyP0KKG/AHXBH3SI1FF8qpUZDQAPc+VZ44yyRf24henfHGAS4QUPB2BkP?=
 =?us-ascii?Q?nNkqPvowvDGQU2e0HFtWo+0fSTEutb4iVuZ4nzOJYviMzsDKA3yTY488HkYx?=
 =?us-ascii?Q?KDBmNhuFyZLDOim/5u00SRwNRPYldan1c1NJFMXtPbjn0eeEVUkMqX1+OYiy?=
 =?us-ascii?Q?UPfnylI+6MFv4tJRWkyTUo8cwXaqZ3nSwZAtRs7E6NEdDo6BSAPETkczK60l?=
 =?us-ascii?Q?N9Pgn2ojSbkFroB2CkrAkRAy4lXNcl3ZK/LJ/DLRAFsgli2/tyh0Nok5viv/?=
 =?us-ascii?Q?aSCHV+b1Z4ao+YhtwB0VkTHpF+NRa9r4EuUNWt4Aq6k2pHfKzW3BbvdqlxuA?=
 =?us-ascii?Q?mqpzMDMsT6WDqNzRbPm8tDqCPsykq+04I9q8yI/Ya1INPLFLc4tth5Lj5d9Z?=
 =?us-ascii?Q?UcenTeXZ3Eu+eQimygNep2gO/8GNAv0GDJkNvnhEVgJLjxAYzhffukJV+gBN?=
 =?us-ascii?Q?otn4+RZc+85hx88pmrmXoDRDZ2KJmt+CZkmn/t2s8GhAX3vPDgPvqPyxRBIP?=
 =?us-ascii?Q?yWjgaqudYyOPUlvmGdsn+PNr2IH2r7lEFk69Jx3ipP7W0bxu2ALX8L1Mp0Jl?=
 =?us-ascii?Q?s6EbfmAHagyztS9AhAxkeV1a8P0KMNb3WMAFaamPP9sk0TsT5Dj/qgXXMsq0?=
 =?us-ascii?Q?vlee4e6EUiiOwX4azC9ux3dP4xC2qi0xC5ft2Huq2ER4c6npWE5hzzax+n3Z?=
 =?us-ascii?Q?llYDGV5RnXUB9O13fG5uO6M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed12638c-5235-4f67-4147-08d9f67f844e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 03:49:39.2511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwCeDeBGfPqk8JICzJUn1LYWog5LgyvddRGem/aytq3VdZDnf2oE+0tTcDfjNP7MAmX06mb7jOQf3JBV7JRG6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 23, 2022 at 10:42:34AM +0800, Liang, Prike wrote:
> This will enable the following gfx clock gating.
> - Fine clock gating
> - Medium Grain clock gating
> - 3D Coarse clock gating
> - Coarse Grain clock gating
> - RLC/CP light sleep clock gating
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 74e0550d00bd..5f375f3430e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -936,7 +936,15 @@ static int nv_common_early_init(void *handle)
>  		adev->external_rev_id = adev->rev_id + 0x01;
>  		break;
>  	case IP_VERSION(10, 3, 7):
> -		adev->cg_flags = 0;
> +		adev->cg_flags =  AMD_CG_SUPPORT_GFX_MGCG |
> +			AMD_CG_SUPPORT_GFX_MGLS |
> +			AMD_CG_SUPPORT_GFX_CGCG |
> +			AMD_CG_SUPPORT_GFX_CGLS |
> +			AMD_CG_SUPPORT_GFX_3D_CGCG |
> +			AMD_CG_SUPPORT_GFX_3D_CGLS |
> +			AMD_CG_SUPPORT_GFX_RLC_LS |
> +			AMD_CG_SUPPORT_GFX_CP_LS |
> +			AMD_CG_SUPPORT_GFX_FGCG;
>  		adev->pg_flags = AMD_PG_SUPPORT_VCN |
>  			AMD_PG_SUPPORT_VCN_DPG |
>  			AMD_PG_SUPPORT_JPEG;
> -- 
> 2.17.1
> 

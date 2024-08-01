Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573DBC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0749C10E8ED;
	Thu,  1 Aug 2024 10:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qt7nMAM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5689710E8ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca91Mn3KhxNsO6Ine6UaTnQEuQwHHIU6ea72SZL8IpPV8aVLlaGePoD+6LyPBJ9iVFUsDMn5pt30+U1bkddFnXu06XcRkIFiheBlxjetpleAcTylXx+VebNzsG/rUq7L6Yhf9ZEXfYPwjJ5Vc5PBJjzA1AIvszP4ZtXNJ2xRNLJMnzgKCxouGRROveRWEEjTndd2I4ZXxZk0hKPCUvA/e4aRGOPxrE3ov8M0vsRSLJ3LTHtU4lZUx78Qg+J1SmVKuOsBdQSsKatwcvNE3SWBJWUXWSnEiRapi0VHLWmCWbaSaBhQj+TVquAuZdtDw0Oh8ZWlgNIf5o96r8KyEf+f0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dj9EH7Ohd02Pg2YCoo8oPBwsnqQCJiEq0RmtezXb50=;
 b=D4biYXoCbMslXR2wYJt7vQTp46b3liIdPe1Vkt36tK7xiPdWYAdmliigZdSx2BtwKbLnRvTIuDvUIktZoiJE4iVG7ikQiqJ58R5cbEi7wX17A+3bTou736TE3Rf77ZUsfo+co9R36ezzuChlQjs5PpNNA7UxxL173cx5BuV/agr/MgC3pf8dfmyQGmPR+ldVtZj1c9odbaKuP1cDxegW0G917P/soVhaYCLXoA2MGOmXrMWJqsbatf1DY8hnr+Ec+8FginnI+haTKvZ4bN2diCB82XejcifiPqh9igZ6piJVJC+PP4OcEdxS2bz7Ih7LGTluDPUImyriwvjxi3Rjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dj9EH7Ohd02Pg2YCoo8oPBwsnqQCJiEq0RmtezXb50=;
 b=5qt7nMAM/pOL09qrzpREwKGgVlstFWgEpg1sYTwh7/ma94odqOBiQZ0pZ6kKSLBR6dqJeDbHV3jmzUSar8e8GAA4rcDoBh/vzNdoLeSbLzvwOZzpLN0plZm0V6gTqv0HvmbSt5NNiOOaNJtVMOUMGcLbmrkWdbdDYtwOajvaOCE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 10:22:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 10:22:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: create function to check RAS RMA status
Thread-Topic: [PATCH 1/3] drm/amdgpu: create function to check RAS RMA status
Thread-Index: AQHa4/mcqhKuV24CwEWxR/S3qfnCXrISMVlA
Date: Thu, 1 Aug 2024 10:22:22 +0000
Message-ID: <BN9PR12MB52579DB371249DCB8DCC9834FCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240801095953.35625-1-tao.zhou1@amd.com>
In-Reply-To: <20240801095953.35625-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1520e1b4-47f2-40af-b5c0-a5eaa97c06fa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T10:22:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8752:EE_
x-ms-office365-filtering-correlation-id: 833e623f-06d2-48a1-84b0-08dcb213d4f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lKAbKwtyIl2LdHk+2mnayMhN8vUxyljCsdeEm7wvlU3vUmlhOzZcaOAh1cnf?=
 =?us-ascii?Q?ibc5xDildVgPOlvU8rkMoH21/efjASHX9KyUOYyrWGiZqY7+cM+bXyRwuDIs?=
 =?us-ascii?Q?8YXBUGk4PkenHSXE5U7gp7HogFLLPyAvQ0cCrCN8LLyo4nSjCUbgqZ00GShG?=
 =?us-ascii?Q?drN6ZgTgHpilILnKkUHqvITL7Gm/U8+b6zPi5cdvmtVnCm+jS3bL4vD1T+qK?=
 =?us-ascii?Q?ktd9lMuQWtYy8SWz2t1TL1IwmucZk4TJWTO7ZvXSAo5qe3RWLM364Chrhy8K?=
 =?us-ascii?Q?PNOgbftr8rS5q6XwAVglN6akTaMNV1xVVycqtAjC2SuP2rtAffjOt9K2K64v?=
 =?us-ascii?Q?UDZaEJ/1tG+/2vKmoQ/8qugqeJ/G6qdclGXCKHI0B6688vEEqs7emEMGSc23?=
 =?us-ascii?Q?MRXRlBiBbg2imJbpmbOHJbb+3nzVZgquh71ymMToZIJquCWSGQezER8wka0v?=
 =?us-ascii?Q?nHyZjmTnhCpnO5yM8HOyKyuialCdZfjBYi3qzQKYrB2atrmFya0gjXVkq+h2?=
 =?us-ascii?Q?1y/Rxvb6nvKnTYlQSgn4hFKzCHPF1kjt99pFL9vVpESObrQHXZAzzz3nsrSk?=
 =?us-ascii?Q?iklt8I6u+UDDkuFQHFptG1EjU/NN94/tBLgxBrzfaTdZeJGpafzlqx4dr9sy?=
 =?us-ascii?Q?a0Eswy1GbUW0+V326HtF0LRP1VNANQivQ7V6CueH+rphc7oZrWtJpun0HG8U?=
 =?us-ascii?Q?CFB/dgENIlJfzzhRRR1SJN0ybOQV5U8Lrl5kRW11xejdDCMKOYS9sJoGfgwO?=
 =?us-ascii?Q?Wq3ufm20mqSQlj0U7yEk6LKVjNqSIR/oFZBYTwMxkUff4b5xGmB0aKhbwwsn?=
 =?us-ascii?Q?2yzYAkB/UnB6OclsqYt0x+UFXtLb/dMubvFtS8LMBFgyZENCii2FkDLdWBBm?=
 =?us-ascii?Q?L1tL0EdmZV4WtHvVafstvC95dMXFejBzc8HdmzmBQMnVm1PHbpgzQX/dfKZ9?=
 =?us-ascii?Q?J/LeirrTpao/futmU4np7Hq/nic0twtRAzPq1OTlgdRXF8ZFqDv2kTFYKm+m?=
 =?us-ascii?Q?FbBUzibWkSLn335HnBreUbGcTHkKzV8xRLAxNuG+pYHoOipg3QEDTcupQQza?=
 =?us-ascii?Q?CysmsQSaD9ftBGmgGJK2EKcD8ZFM1nshWIkZA7QWbKv9OF3//Xlj6Y73mlhu?=
 =?us-ascii?Q?hTQDNga9VJ11Ka4MCD5Rg7iN7BdwGqppt7rhTV6XRVUk3zmX+tzQf3BCmBVF?=
 =?us-ascii?Q?E9FJpAdvtn4tJ1jTg2gWscW7pgsFnt8dk/LrSkxOd2NsI+XSD2GHhORSiqIc?=
 =?us-ascii?Q?zrusLIhWrWNmr1wXXN48KzDlq8aB2CU+du8LF6ZdDUpTKe2OOCVhwTvES4GU?=
 =?us-ascii?Q?NccOgZ++5Jb+VwJbt9SRbcQI5pr10x7RJzWnXSAXMabjYYp4XIaJCbKiM4x0?=
 =?us-ascii?Q?coAksykxprgLw28vrGP2S2M2RLZ+fMOu0itOTAR9qDe/agQhhw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ss3HDvh5H5UpK7+MYt98MGeKp/2gMqkRTgW7M5aQvEvVECoVL8N4XuuZLCSd?=
 =?us-ascii?Q?29pyo46iKWywznAAK96kc4Utf4NZGvJj0kh61TgYz0Ggi/ylJJzX4XRHVPFv?=
 =?us-ascii?Q?pBjcbJhqkFVrFlddkd0SWjhlt6Hn1/SzLMPZuib97QiSHsF/gp8DsD2LjoZm?=
 =?us-ascii?Q?fdMzxqOsMi7AbOX819RTVhHdK50KYIWLFpCdbJmRtdTq5loyoNppD3f/GMqD?=
 =?us-ascii?Q?PAjwCrEcr5S9efGo9cBAgZB2tDQOgCMMCWth96bBJ0r9nf+CzNu8SgcNj9rU?=
 =?us-ascii?Q?Aq0dmnfOCHlb4pRmMpPSiscX8Y3i0SgBDb/O8LuPajHC/G2TM3G2d9xNyKlF?=
 =?us-ascii?Q?wJxadKtxFJhPB8fCNogi/cjmA8JUvcv6zzTGkEreZe0xtM90XAa6nBT7S90U?=
 =?us-ascii?Q?5BBpKKUQ1CF4k4aLP9eRQyOpAEHVcOAnKsQva7r6egg6my4T8EJhFmMfbq/4?=
 =?us-ascii?Q?lLWfiwbCSeTJbA+Cr89VjPnQJOpbEVTikc69zh8nT0xlzLKLY4hDaDOsh7qf?=
 =?us-ascii?Q?6o8bxdCg5+SrU+s3C/Ma1peFVQhSn5j0poPCR3FWVz+G/MjMCc9peTWD1Cq7?=
 =?us-ascii?Q?xK/JirVN999FRIYaBbo8H8lP5TSEFtGyMkkKJG6d72AsaKizKl29x+3rPJ8w?=
 =?us-ascii?Q?BgV/Rp8j0fMZOcgA6X41SXeuykkminzQjE+0Bzbq4nJLrxpoQSqnkoDlU4IQ?=
 =?us-ascii?Q?BV3pMZTXdOHmuPrnNlk1nKWNc+IGH0ov+cykFc+Xr62W/6XxdyApfB3mhtMu?=
 =?us-ascii?Q?8nUO8KVgOI/DtIHwt35hDDZfzzr5S4kWZsGO9xz8T6B6XrkJyoIHcCObyMNb?=
 =?us-ascii?Q?DmjKcmjHJnmdVzmnsVxLVK1ZIBbh6ZxwLRE3xWTRrqjQNLkGeebpPA2pYyoY?=
 =?us-ascii?Q?bYp6dXoqNaThSMOeWdkBBzXNYG0coaUYI6tLM4PBMIJB+Xw/hC7LjpOCwDgJ?=
 =?us-ascii?Q?NtKFwGjExS4k0HQDAJOPPThPyozAIV+RmjftlFY8rUMdDPfpgfoDKxYomB0i?=
 =?us-ascii?Q?LVMkrd9eaDPmAEqJBsQfRDzQvE6ZXEQ2xLhuy/+T2HZ92o4vfwCvKunQTm0Q?=
 =?us-ascii?Q?uCSDGtw7rBc9qIhU2Jl08Z4MZscRqqm0VdkKBu92/8ILnP+C7Owj9GgmiYL9?=
 =?us-ascii?Q?My5u0tKO0eDgXGY/sA39mf0rdg2EehnUvcKxDNd3TnVDtuN7hKgG5Rmi3bUF?=
 =?us-ascii?Q?ILoHpIGRypRLvbHLBb8RkGnc8Jd20yC6pEsc4HtgHNo4V106wrae/pRZ0STU?=
 =?us-ascii?Q?kpGn2dyQNlMf7wBAkWRoghwfyzBOcifhOEStfvwknYDSs/79I7ITBJkJB+6i?=
 =?us-ascii?Q?i3D5vKvGTy6LHlRFo617k25kzYWQYW82USmAFVrIbqxz5CLwm/j2UFmv5ZmQ?=
 =?us-ascii?Q?XF5cWzNuQ9tXBMW42PkkeBlF4MZAHjZhrF/qloGWJJ4wyexVzCKUad9QAUPD?=
 =?us-ascii?Q?3SCOieNQhGW/PSP+EgMe/08x32yMmEfpLLxi+zcvfLl0iJURPH60A8Fk4XHz?=
 =?us-ascii?Q?oKMCSAMas372wSpPH02ccyTbjXpBQMy+skx1XEcaKUmWeoxDLn5YQD21oQVn?=
 =?us-ascii?Q?vVw58Rv0XJCce7AnKpHG3/CLJ7Qxa58+yg9MIonE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833e623f-06d2-48a1-84b0-08dcb213d4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 10:22:22.6346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d84lioexys90XL7iJ824yd0kOec0rMTTdLOQnT/NrHjFsZX+t2rtgwpC4zlKwSm8oz8l7KKZJGdpPnQLVWRIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, August 1, 2024 18:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: create function to check RAS RMA status

In the convenience of calling it globally.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 22 ++++++++++++++++------  driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  1 +  drivers/gpu/drm/amd/amdgpu/amd=
gpu_umc.c  |  2 +-  drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c |  2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 12ab48f26bd5..0941518f04c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2153,7 +2153,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
        /* gpu reset is fallback for failed and default cases.
         * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
         */
-       if (poison_stat && !con->is_rma) {
+       if (poison_stat && !amdgpu_ras_is_rma(adev)) {
                event_id =3D amdgpu_ras_acquire_event_id(adev, type);
                RAS_EVENT_LOG(adev, event_id,
                              "GPU reset for %s RAS poison consumption is i=
ssued!\n", @@ -2951,7 +2951,7 @@ static void amdgpu_ras_do_page_retirement(=
struct work_struct *work)

        amdgpu_ras_error_data_fini(&err_data);

-       if (err_cnt && con->is_rma)
+       if (err_cnt && amdgpu_ras_is_rma(adev))
                amdgpu_ras_reset_gpu(adev);

        amdgpu_ras_schedule_retirement_dwork(con,
@@ -3053,7 +3053,7 @@ static int amdgpu_ras_poison_consumption_handler(stru=
ct amdgpu_device *adev,
        }

        /* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu res=
et */
-       if (reset_flags && !con->is_rma) {
+       if (reset_flags && !amdgpu_ras_is_rma(adev)) {
                if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
                        reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) @@=
 -3202,7 +3202,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev=
)
         * This calling fails when is_rma is true or
         * ret !=3D 0.
         */
-       if (con->is_rma || ret)
+       if (amdgpu_ras_is_rma(adev) || ret)
                goto free;

        if (con->eeprom_control.ras_num_recs) { @@ -3254,7 +3254,7 @@ int a=
mdgpu_ras_recovery_init(struct amdgpu_device *adev)
         * Except error threshold exceeding case, other failure cases in th=
is
         * function would not fail amdgpu driver init.
         */
-       if (!con->is_rma)
+       if (!amdgpu_ras_is_rma(adev))
                ret =3D 0;
        else
                ret =3D -EINVAL;
@@ -4301,7 +4301,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        /* mode1 is the only selection for RMA status */
-       if (ras->is_rma) {
+       if (amdgpu_ras_is_rma(adev)) {
                ras->gpu_reset_flags =3D 0;
                ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
        }
@@ -4835,3 +4835,13 @@ void amdgpu_ras_event_log_print(struct amdgpu_device=
 *adev, u64 event_id,

        va_end(args);
 }
+
+bool amdgpu_ras_is_rma(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->is_rma;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..25a19760f098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -972,4 +972,5 @@ __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
                                const char *fmt, ...);

+bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 32be258d81e1..9e70a7b3aa64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -196,7 +196,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        amdgpu_umc_handle_bad_pages(adev, ras_error_status);

        if ((err_data->ue_count || err_data->de_count) &&
-           (reset || (con && con->is_rma))) {
+           (reset || amdgpu_ras_is_rma(adev))) {
                con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 9cd221ed240c..999bb3cc88b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -97,7 +97,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct =
amdgpu_device *adev,
                        ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
                }

-               if (con && !con->is_rma)
+               if (con && !amdgpu_ras_is_rma(adev))
                        amdgpu_ras_reset_gpu(adev);
        }

--
2.34.1


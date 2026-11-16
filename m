Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD3606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JFs402qQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15FD10E3D5;
	Mon, 16 Nov 2026 19:29:16 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE9910E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt3OyTNNSfKyzbAq3jiriSabTXsl1UCyWUgXS5n+fshAwOdMGCAvr+9MNhQqYqLWbZcuJezqFsoQ0Hd/SRZFxE14yY6j+NJ/DrgGkMdx/wernED2ChnkHeOIwnyfu4BcS3K8mZxANNAa5uYy+Gs87rM30FJVu+GkVqaPhxaIGWEwchdLUPGCnO+TTIyKZ1jWxu4QbnpweybZLHDPiAw65Khhly9nxaBjuL1FvxaDB1yfGvghwCZxCiFhN9wXA4mIY9AMIWSivZsfQNdG+h9s6oxZuig4cp2gbagX97nFEs5hix1P8eXfxIV7sezFtVy73JjEdTVb0cZhj3uXwHxgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCyOnfmtZASJnv0ey2+AVZYWnbtLd28fV6yfdwyRYv0=;
 b=KNRpn7rJbZ1ykleHSL2ZdQyvCGwc733UHzyZLm30syyBuW9m0WLjEABDi0gCue0TYA0L1KBzorOpj4sCPSqVjornley0F35ZtFU0c+shXHRoekMt0lPlmWoIjBepfPAoQaeIo8+gJIdGgesBy9NWnv4+1P4BxMdcAyzrrur4XvUDf5IRHZz0vZW8Re6QhNui5YHxMY2YKv58XNFP96NIWpK54pGpRx8LUhuVfe3M1rVRhHzYUKaNZ8UItjSyzHshahiijmhTteMYjh5bZwRpnO8WZPj+T3OhwKVexvCwd72UHHHJU8YjG3SECO3ZRysRdn6Dq2wvZcw44SJ8D6DLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCyOnfmtZASJnv0ey2+AVZYWnbtLd28fV6yfdwyRYv0=;
 b=JFs402qQJp/qaM711A0bISplsUt8woejvQkjvIUj4Kb64uqnS6weWuhbznXD0cb50HRKxx1ASnql0zuNQm4Ozbu3nGztwn3ood98MObAzbnd7czEcNNZqu9jX7lrPxvnud/Z8yJNAsEOIzL9PSZyqeLW8VfDyPVwkQZ2kygZgHE=
Received: from CH2PR18CA0039.namprd18.prod.outlook.com (2603:10b6:610:55::19)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:26:56 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::17) by CH2PR18CA0039.outlook.office365.com
 (2603:10b6:610:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:26:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:26:55 +0000
Received: from khazad-dum (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:26:53 -0600
Date: Mon, 16 Nov 2026 19:26:45 +0000
From: Lancelot SIX <lancelot.six@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <Jay.Cornwall@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: Re: [PATCH 4/8] drm/amdkfd: Add CWSR trap handler for GFX13
Message-ID: <avtX1J7Z7lqPLCnu@khazad-dum>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
 <20261109184641.3656885-5-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109184641.3656885-5-alexander.deucher@amd.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6712f523-97db-4fea-4ba7-08df44179359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|3023799007|5023799004|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|10067099003|261021121427099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: MtqZA+4IhDQXJJznCohr4tKLjmc00NRc8jfp/NTRBqNYd50vPMGkaHdNHacYWWxSxYn3gbL2TxGQ/0WJOwwNEPLnWB2DkNbduAAtlQywpAjYc+KeAcrQQXoV4SSQOOfyl1j7f4SMzGMnRQ712hrkt1gd2bG6PxW3eUT4qjC1Q4cWk/s5K8Gth4g9Q1RKYHaSd0CB2iD4xVh/gMoBjTFQDulvILNrk2Q0uE6PUSCHIqvAJji5B1WyljzFcySrdBRSirnRVxdpl+cRrCMOgaXxq50vFPTQK8ttd8b3DBFib6OwSPa5C8RvMf/Qkt/dFADRG82/O1VQVB+f4ySjXZ9WtgScrAPRjUoFcm/kYmGGfB/OFi0d64ESHlGuxBThYV9U7DWJjLBCLnAmyQBmZZFTebRhp5NS1MBgWmLPQO5UAnaTh96+SKTwLO/FzhgG+DHXhQ3PKSFYpVgTRUnQmSqkZnjKEBdym9zQffzWZviWnptmarmgTZk9FABhJjCzO9gE9NT3iZoo9gzALhU0ITuZQQM6Vyq7ZrlPzbV1Bi3cZn+fF1KnEmAsorKL0MqCDasuSGWYhLQgdut/TtX+4yJqt/8tEzazIfNkblZ0FISJc+MzYmeqCyHOBAxxVIrolw3YWnNXh0GVuslHaLnxtBFmcsIeZnRO4/vxmwn2Ohfse3G/zwlfEGmzhpkly40oYpjYQ2wpbl5wQH3gP35cg5aMUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(5023799004)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(261021121427099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F22jSj+qeskK0cv8yGtXD9dd4pWO1vG6iOU8L7dgQ73wu3la3jNYmaRNUCB1FrYBS7mfRuEK5HYDqtrOS3sVVRjE0FkGT8dNk74KvIyWBijZfAXYzY1rCLXlALwnyH2A2VfMfIp3nGJw+bnRgp6hEV/IlMn6AxP+zd++EUIBeE610NOWPkkhMOm39QIhuJjzKh8HQU9cZzWLcd/u9LH3zvapuK35dIHbps+ZvYEvgCyHkOpBe4Swf+QzccF/gtFy+klXSUKVh/8fclxyfgpjl/wMxGz/OiRO7tZmZfDuh1Ord3+s18slFPOEzKwoAvfM+bxYplrUb9g3cW6wXuzT5iZZXGSeOq1XI3NlHNJ8Fnr17GNJJzyxqOQaVGBll3gcXFfCdpBIVWNo+7eA9CylhDTiMP799/T1BjyX5qmi6iOHleeMWxDjeoiunGmi0M+b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:26:55.6378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712f523-97db-4fea-4ba7-08df44179359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

Comments inlined.

Best,
Lancelot.

On Mon, Nov 09, 2026 at 01:46:36PM -0500, Alex Deucher wrote:
> From: David Belanger <david.belanger at amd.com>
> 
> Add initial trap handler.  Implementation provided by Jay Cornwall.
> 
> v2: Remove non-GFX13 binary changes
> v3: squash in updates
> 
> Signed-off-by: Jay Cornwall <Jay.Cornwall at amd.com>
> Signed-off-by: David Belanger <david.belanger at amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher at amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    |  568 ++++++++
>  .../amd/amdkfd/cwsr_trap_handler_gfx13.asm    | 1181 +++++++++++++++++
>  2 files changed, 1749 insertions(+)
>  create mode 100755 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
> new file mode 100755
> index 0000000000000..58908b4fa40a9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
> @@ -0,0 +1,1181 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.

I am not sure of the copyright notice policy for the diver, but even if
this file reuses structure and fragments from previous trap handlers, it
has new and original work.

> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/* To compile this assembly code:
> + *
> + * gfx13:
> + *   cpp -DASIC_FAMILY=CHIP_GFX13 cwsr_trap_handler_gfx13.asm -P -o gfx13.sp3
> + *   sp3 gfx13.sp3 -hex gfx13.hex
> + */
> +
> +#define CHIP_GFX13 39
> +
> +#define HAVE_XNACK 0
> +#define HAVE_57BIT_ADDRESS 0
> +#define WAVE32_ONLY 0
> +#define NUM_NAMED_BARRIERS 0x10
> +#define NUM_NAMED_CLUSTER_BARRIERS 0x4
> +#define NUM_SEMAPHORES 0x5
> +#define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
> +#define SEMA_DONE_RESTORE_WORKAROUND 1
> +
> +#if HAVE_XNACK && !WAVE32_ONLY
> +# error
> +#endif
> +
> +#define ADDRESS_HI32_NUM_BITS ((HAVE_57BIT_ADDRESS ? 57 : 48) - 32)
> +#define ADDRESS_HI32_MASK ((1 << ADDRESS_HI32_NUM_BITS) - 1)
> +
> +var SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK	= 0x60000C
> +var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
> +var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
> +var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
> +var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK		= 0x8000
> +var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
> +var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
> +var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
> +var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
> +var SQ_WAVE_STATUS_IN_WG_SHIFT			= 11
> +var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
> +var S_RETURN_PC_HI_TRAP_ID_MASK			= 0xF0000000
> +
> +var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
> +var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
> +var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
> +
> +var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
> +var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
> +var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
> +var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
> +var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
> +var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
> +var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
> +var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
> +var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK	= 0x200
> +var SQ_WAVE_TRAP_CTRL_ALU_CONSUME_NAN_SHIFT	= 10
> +var SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT= 7
> +
> +var SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
> +						  SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	|\
> +						  SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK		|\
> +						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
> +						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
> +						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
> +
> +var BARRIER_STATE_SIGNAL_OFFSET			= 22
> +var BARRIER_STATE_SIGNAL_SIZE			= 8
> +var BARRIER_STATE_MEMBER_OFFSET			= 12
> +var BARRIER_STATE_MEMBER_SIZE			= 8
> +var BARRIER_STATE_VALID_OFFSET			= 31
> +var BARRIER_STATE_ID_MASK			= 0x7F
> +
> +var NAMED_BARRIERS_SR_OFFSET_FROM_HWREG		= 0x80
> +var NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG	= (NAMED_BARRIERS_SR_OFFSET_FROM_HWREG + NUM_NAMED_BARRIERS * 0x4)
> +var S_BARRIER_INIT_MEMBERCNT_MASK		= 0x7F0000
> +var S_BARRIER_INIT_MEMBERCNT_SHIFT		= 0x10
> +
> +var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT	= 18
> +var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE	= 1
> +var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT	= 16
> +var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE	= 1
> +var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT	= 0
> +var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE		= 7

We have "#define HAVE_XNACK 0", this could probably be removed.  This
seems a leftover from the gxf12 trap handler.

> +
> +var SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT	= 9
> +
> +var SQ_WAVE_IB_STS_SWC_CNT_SHIFT		= 12
> +var SQ_WAVE_IB_STS_SWC_CNT_SIZE			= 2
> +
> +var SQ_WAVE_IB_STS2_NO_IC_HASH_SHIFT		= 24
> +
> +var SQ_WAVE_SEMA_STATE_DONE_SHIFT		= 28
> +
> +var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
> +var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
> +var TTMP11_FIRST_REPLAY_SHIFT			= 22
> +var TTMP11_FIRST_REPLAY_MASK			= 0x400000
> +var TTMP11_REPLAY_W64H_SHIFT			= 21
> +var TTMP11_REPLAY_W64H_MASK			= 0x200000
> +var TTMP11_FXPTR_SHIFT				= 14
> +var TTMP11_FXPTR_MASK				= 0x1FC000

FIRST_REPLAY, REPLAY_W64H and FXPTR are xnack related, and not supported
by this chip.  Those also seem leftover from the gfx12 trap handler.

> +
> +var S_EXEC_LAST_FIRST_WAVE_SHIFT		= 26
> +var S_EXEC_LAST_FIRST_WAVE_SIZE			= 2
> +
> +var S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT	= 31
> +var S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK		= (1 << S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT)
> +var S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT	= 30
> +var S_FLAGS_IN_WAVEGROUP_SHIFT			= 29
> +var S_FLAGS_IN_WAVEGROUP_MASK			= (1 << S_FLAGS_IN_WAVEGROUP_SHIFT)
> +#if ! WAVE32_ONLY
> +var S_FLAGS_WAVE64_SHIFT			= 28
> +#endif
> +
> +var s_return_pc_lo				= ttmp0
> +var s_return_pc_hi				= ttmp1
> +
> +var s_save_flags				= s_return_pc_hi
> +var s_save_base_addr_lo				= ttmp2
> +var s_save_base_addr_hi				= ttmp3
> +var s_save_addr_lo				= ttmp10
> +var s_save_addr_hi				= ttmp11
> +var s_save_state_priv				= ttmp12
> +var s_save_tmp					= ttmp14
> +var s_save_ttmps_lo				= ttmp14
> +var s_save_exec_lo				= ttmp14
> +var s_save_excp_flag_priv			= ttmp15
> +var s_save_alloc_size				= ttmp15
> +var s_save_ttmps_hi				= ttmp15
> +var s_save_exec_hi				= ttmp15
> +var s_save_xnack_mask				= exec_hi
> +
> +var s_restore_tmp				= ttmp2
> +var s_restore_ttmps_lo				= ttmp2
> +var s_restore_alloc_size			= ttmp3
> +var s_restore_ttmps_hi				= ttmp3
> +var s_restore_m0				= ttmp3
> +var s_restore_exec_lo				= ttmp4
> +var s_restore_exec_hi				= ttmp5
> +var s_restore_flags				= ttmp6
> +var s_restore_mode				= ttmp7
> +var s_restore_base_addr_lo			= ttmp8
> +var s_restore_base_addr_hi			= ttmp9
> +var s_restore_addr_lo				= ttmp10
> +var s_restore_addr_hi				= ttmp11
> +var s_restore_mem_offset			= ttmp12
> +var s_restore_xnack_mask			= ttmp13
> +var s_restore_state_priv			= ttmp14
> +var s_restore_excp_flag_priv			= ttmp15
> +
> +var TTMP_SR_OFFSET_FROM_HWREG			= -0x40
> +
> +shader main
> +	asic(DEFAULT)
> +	type(CS)
> +	wave_size(32)
> +
> +	s_branch	L_SKIP_RESTORE						//NOT restore. might be a regular trap or save
> +
> +L_JUMP_TO_RESTORE:
> +	s_branch	L_RESTORE
> +
> +L_SKIP_RESTORE:
> +	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC

Out of STATE_PRIV, only one bit (SCC) needs to be restored.  Saving
everything wastes one entire register.  Instead, we could save SCC in
TTMP11[22].

This would free one full register for the 2nd level trap handler.

> +
> +	// Clear SPI_PRIO: do not save with elevated priority.
> +	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
> +	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
> +
> +	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +
> +	s_and_b32       ttmp2, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
> +	s_cbranch_scc0	L_NOT_HALTED
> +
> +L_HALTED:
> +	// Host trap may occur while wave is halted.
> +	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
> +	s_cbranch_scc1	L_FETCH_2ND_TRAP
> +
> +L_CHECK_SAVE:
> +	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +	s_cbranch_scc1	L_SAVE
> +
> +	// Wave is halted but neither host trap nor SAVECTX is raised.
> +	// Caused by instruction fetch memory violation.
> +	// Spin wait until context saved to prevent interrupt storm.
> +	s_sleep		0x10
> +	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +	s_branch	L_CHECK_SAVE
> +
> +L_NOT_HALTED:
> +	// Let second-level handle non-SAVECTX exception or trap.
> +	// Any concurrent SAVECTX will be handled upon re-entry once halted.
> +
> +	// Check non-maskable exceptions. memory_violation, illegal_instruction
> +	// and xnack_error exceptions always cause the wave to enter the trap
> +	// handler.
> +	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK
> +	s_cbranch_scc1	L_FETCH_2ND_TRAP
> +
> +	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.
> +	// Maskable exceptions only cause the wave to enter the trap handler if
> +	// their respective bit in mode.excp_en is set.
> +
> +	// Align bits from EXCP_FLAG_USER/EXCP_FLAG_PRIV with TRAP_CTRL.
> +	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> +	s_bitcmp1_b32	ttmp2, SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT
> +	s_cbranch_scc0	L_NOT_ALU_CONSUME_NAN
> +	s_bitset0_b32	ttmp2, SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT
> +	s_bitset1_b32	ttmp2, SQ_WAVE_TRAP_CTRL_ALU_CONSUME_NAN_SHIFT
> +
> +L_NOT_ALU_CONSUME_NAN:
> +	s_and_b32	ttmp3, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
> +	s_cbranch_scc0	L_NOT_ADDR_WATCH
> +	s_or_b32	ttmp2, ttmp2, SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
> +
> +L_NOT_ADDR_WATCH:
> +	s_getreg_b32	ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
> +	s_and_b32	ttmp2, ttmp3, ttmp2
> +	s_cbranch_scc1	L_FETCH_2ND_TRAP
> +
> +L_CHECK_TRAP_ID:
> +	// Check trap_id != 0
> +	s_and_b32	ttmp2, s_return_pc_hi, S_RETURN_PC_HI_TRAP_ID_MASK
> +	s_cbranch_scc1	L_FETCH_2ND_TRAP
> +
> +#if SINGLE_STEP_MISSED_WORKAROUND
> +	// Prioritize single step exception over context save.
> +	// Second-level trap will halt wave and RFE, re-entering for SAVECTX.
> +	// WAVE_TRAP_CTRL is already in ttmp3.
> +	s_and_b32	ttmp3, ttmp3, SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
> +	s_cbranch_scc1	L_FETCH_2ND_TRAP
> +#endif
> +
> +	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +	s_cbranch_scc1	L_SAVE
> +
> +L_FETCH_2ND_TRAP:
> +#if HAVE_XNACK
> +	save_and_clear_xnack_state_priv(ttmp14)
> +#endif

This is defined to 0.  Should we keep this in (same for other instances)?

> +
> +	// Read second-level TBA/TMA from first-level TMA and jump if available.
> +	// ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
> +	// ttmp12 holds SQ_WAVE_STATUS
> +	s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
> +	s_wait_kmcnt	0
> +	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
> +
> +	s_bitcmp1_b32	ttmp15, (ADDRESS_HI32_NUM_BITS - 1)
> +	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
> +	s_or_b32	ttmp15, ttmp15, ~ADDRESS_HI32_MASK
> +L_NO_SIGN_EXTEND_TMA:
> +
> +	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS		// debug trap enabled flag
> +	s_wait_kmcnt	0
> +	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
> +	s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
> +	s_or_b32        ttmp11, ttmp11, ttmp2
> +
> +	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 scope:SCOPE_SYS	// second-level TBA
> +	s_wait_kmcnt	0
> +	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 scope:SCOPE_SYS	// second-level TMA
> +	s_wait_kmcnt	0
> +
> +	s_and_b64	[ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
> +	s_cbranch_scc0	L_NO_NEXT_TRAP						// second-level trap handler not been set
> +	s_setpc_b64	[ttmp2, ttmp3]						// jump to second-level trap handler
> +
> +L_NO_NEXT_TRAP:
> +	// If not caused by trap then halt wave to prevent re-entry.
> +	s_and_b32	ttmp2, s_return_pc_hi, S_RETURN_PC_HI_TRAP_ID_MASK
> +	s_cbranch_scc1	L_TRAP_CASE
> +
> +	// Host trap will not cause trap re-entry.
> +	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +	s_and_b32	ttmp2, ttmp2, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK

Unlikely to be a practical issue, but this tests that HOST_TRAP is
raised, not that nothing else is.  Multiple traps can be reported
simultaneously, this test would allow a "MEMVIOL + host trap + no 2nd
lvl trap handler" scenario to ignore the memviol and continue execution.

> +	s_cbranch_scc1	L_EXIT_TRAP
> +	s_or_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
> +
> +	// If the PC points to S_ENDPGM then context save will fail if STATE_PRIV.HALT is set.
> +	// Rewind the PC to prevent this from occurring.
> +	s_sub_u32	ttmp0, ttmp0, 0x8
> +	s_subb_u32	ttmp1, ttmp1, 0x0

Is this still necessary?

Note that it seems that the last couple of comments seems to also be
applicable to the gfx10/12 tarp handler.  We might want to leave this
as-is here, and address all versions later.

> +
> +	s_branch	L_EXIT_TRAP
> +
> +L_TRAP_CASE:
> +	// Advance past trap instruction to prevent re-entry.
> +	s_add_u32	ttmp0, ttmp0, 0x4
> +	s_addc_u32	ttmp1, ttmp1, 0x0
> +
> +L_EXIT_TRAP:
> +	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
> +
> +	// Restore SQ_WAVE_STATUS.
> +	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
> +	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
> +
> +	// STATE_PRIV.*BARRIER_COMPLETE may have changed since we read it.
> +	// Only restore fields which the trap handler changes.
> +	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
> +		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
> +
> +	s_rfe_b64	[ttmp0, ttmp1]
> +
> +L_SAVE:
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), 0
> +
> +	// Get save address { 4?b0, lastWaveOfWavegroup, firstWaveOfWorkgroup, 1?b0, memAddr[56:0] }

I suspect the "?" should be "'"?

> +	s_mov_b64	[s_save_exec_lo, s_save_exec_hi], exec
> +	s_sendmsg_rtn_b64	exec, sendmsg(MSG_RTN_SAVE_WAVE)
> +	s_wait_kmcnt	0
> +	s_mov_b64	[s_save_base_addr_lo, s_save_base_addr_hi], exec
> +	s_mov_b64	exec, [s_save_exec_lo, s_save_exec_hi]
> +
> +	// Save last_wave_in_wavegroup / first_wave_in_workgroup flags so we can clear high bits of save address.
> +	s_bfe_u32	s_save_tmp, s_save_base_addr_hi, (S_EXEC_LAST_FIRST_WAVE_SHIFT | (S_EXEC_LAST_FIRST_WAVE_SIZE << 0x10))
> +	s_and_b32	s_save_base_addr_hi, s_save_base_addr_hi, ADDRESS_HI32_MASK
> +	s_and_b32	s_save_flags, s_save_flags, ADDRESS_HI32_MASK
> +	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
> +
> +	// Save in_wavegroup and wave64 flags for later use.
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GROUP_INFO, SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT, 1)
> +	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
> +
> +#if ! WAVE32_ONLY
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS, SQ_WAVE_STATUS_WAVE64_SHIFT, 1)
> +	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_WAVE64_SHIFT
> +	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
> +#endif
> +
> +#if HAVE_XNACK
> +	save_and_clear_xnack_state_priv(s_save_tmp)
> +	s_getreg_b32	s_save_xnack_mask, hwreg(HW_REG_WAVE_XNACK_MASK)
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_MASK), 0
> +#endif
> +
> +	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
> +	// ttmp SR memory offset: size(VGPR)+size(SGPR)-0x40
> +	get_vgpr_size_bytes(s_save_ttmps_lo, s_save_flags)
> +	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
> +	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_base_addr_lo
> +	s_addc_u32	s_save_ttmps_hi, s_save_base_addr_hi, 0
> +
> +	global_store_sgpr_b32	ttmp4, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x10
> +	global_store_sgpr_b32	ttmp5, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x14
> +	global_store_sgpr_b32	ttmp6, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x18
> +	global_store_sgpr_b32	ttmp7, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x1C
> +	global_store_sgpr_b32	ttmp8, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x20
> +	global_store_sgpr_b32	ttmp9, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x24
> +	global_store_sgpr_b32	ttmp10, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x28
> +	global_store_sgpr_b32	ttmp11, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x2C
> +	global_store_sgpr_b32	ttmp13, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x34
> +
> +L_SAVE_HWREG:
> +	// HWREG SR memory offset : size(VGPR)+size(SGPR)
> +	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
> +	s_add_u32	s_save_tmp, s_save_tmp, get_sgpr_size_bytes()
> +	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
> +	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
> +
> +	// Ensure no further changes to barrier or LDS state.
> +	// STATE_PRIV.*BARRIER_COMPLETE may change up to this point.
> +	wait_trap_barriers(s_save_tmp)
> +
> +	// Re-read final state of *BARRIER_COMPLETE fields for save.
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
> +	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
> +	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
> +	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
> +
> +	s_mov_b32	s_save_tmp, m0
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x0
> +
> +	global_store_sgpr_b32	s_return_pc_lo, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x4
> +
> +	s_and_b32	s_save_tmp, s_return_pc_hi, ADDRESS_HI32_MASK
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x8
> +
> +	s_mov_b32	s_save_tmp, exec_lo
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0xC
> +
> +#if WAVE32_ONLY
> +	s_mov_b32	s_save_tmp, 0
> +#else
> +	s_mov_b32	s_save_tmp, exec_hi
> +#endif
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x10
> +
> +	global_store_sgpr_b32	s_save_state_priv, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x14
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x18
> +
> +#if HAVE_XNACK
> +	s_mov_b32	s_save_tmp, s_save_xnack_mask
> +#else
> +	s_mov_b32	s_save_tmp, 0
> +#endif
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x1C
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x20
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x24
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x28
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x2C
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_TRAP_CTRL)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x30
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x34
> +
> +	s_get_barrier_state s_save_tmp, -1
> +	s_wait_kmcnt	0
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x38
> +
> +	s_sendmsg_rtn_b32	s_save_tmp, sendmsg(MSG_RTN_GET_CLUSTER_BARRIER_STATE)
> +	s_wait_kmcnt	0
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x3C
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GPR_MSB_IDX0)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x40
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GPR_IDX123)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x44
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_IB_STS2, SQ_WAVE_IB_STS2_NO_IC_HASH_SHIFT, 1)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x48
> +
> +	// Locks and semaphores are only supported in wavegroups.
> +	s_bitcmp1_b32	s_save_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc0	L_SAVE_SKIP_LOCKS_SEMAPHORES
> +
> +	s_get_lock_state	s_save_tmp, 0
> +	s_wait_kmcnt	0
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x4C
> +
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SEMA_MODE)
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x50
> +
> +for var sema_idx = 0; sema_idx < NUM_SEMAPHORES; sema_idx ++
> +	s_sendmsg_rtn_b32	s_save_tmp, sendmsg(MSG_RTN_GET_SEMA1 + sema_idx)
> +	s_wait_kmcnt	0
> +	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(0x54 + sema_idx * 4)
> +end
> +
> +L_SAVE_SKIP_LOCKS_SEMAPHORES:
> +	for var bar_idx = 0; bar_idx < NUM_NAMED_BARRIERS; bar_idx ++
> +		s_get_barrier_state s_save_tmp, (bar_idx + 1)
> +		s_wait_kmcnt	0
> +		global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(NAMED_BARRIERS_SR_OFFSET_FROM_HWREG + bar_idx * 4)
> +	end
> +
> +	for var bar_idx = 0; bar_idx < NUM_NAMED_CLUSTER_BARRIERS; bar_idx ++
> +		s_get_barrier_state s_save_tmp, (bar_idx + 0x21)
> +		s_wait_kmcnt	0
> +		global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG + bar_idx * 4)
> +	end
> +
> +L_SAVE_SGPRS:
> +	// SGPR SR memory offset : size(VGPR)
> +	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
> +	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
> +	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
> +
> +	s_mov_b32	m0, 0							//SGPR initial index value =0
> +
> +	// s[0:15], s[16:31], ... s[80:95]
> +L_SAVE_SGPR_LOOP:
> +for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx += 2
> +	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { src_idx_en: 1, src_idx: MOV_INDEXED_M0 }	//s[N] = s[N+m0], s[N+1] = s[N+1+m0]
> +end
> +
> +for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx ++
> +	global_store_sgpr_b32	s[sgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(sgpr_idx * 4)
> +end
> +
> +	s_add_u32	s_save_addr_lo, s_save_addr_lo, 0x40
> +	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
> +	s_add_u32	m0, m0, 0x10						//next sgpr index
> +	s_cmp_lt_u32	m0, 0x60						//scc = (m0 < first 96 SGPR) ? 1 : 0
> +	s_cbranch_scc1	L_SAVE_SGPR_LOOP					//first 96 SGPR save is complete?
> +
> +	// s[96:107]
> +for var sgpr_idx = 0; sgpr_idx < 0xC; sgpr_idx += 2
> +	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { src_idx_en: 1, src_idx: MOV_INDEXED_M0 }	//s[N] = s[N+m0], s[N+1] = s[N+1+m0]
> +end
> +
> +for var sgpr_idx = 0; sgpr_idx < 0xC; sgpr_idx ++
> +	global_store_sgpr_b32	s[sgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(sgpr_idx * 4)
> +end
> +
> +	// If VGPRs have been deallocated then there is no more state to save.
> +	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> +	s_cbranch_scc1	L_SAVE_DONE
> +
> +	// In a wavegroup only the last wave saves VGPRs.
> +	s_and_b32	s_save_tmp, s_save_flags, (S_FLAGS_IN_WAVEGROUP_MASK | S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK)
> +	s_cmp_eq_u32	s_save_tmp, S_FLAGS_IN_WAVEGROUP_MASK
> +	s_cbranch_scc1	L_SAVE_LDS
> +
> +L_SAVE_VGPRS:
> +	// VGPR SR memory offset: 0
> +	s_mov_b64	[s_save_addr_lo, s_save_addr_hi], [s_save_base_addr_lo, s_save_base_addr_hi]
> +
> +	get_vgpr_num(s_save_alloc_size)
> +	s_mov_b32	s_save_tmp, 0
> +	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
> +	s_set_vgpr_frames	0
> +
> +#if ! WAVE32_ONLY
> +	s_bitcmp1_b32	s_save_flags, S_FLAGS_WAVE64_SHIFT
> +	s_cbranch_scc1	L_SAVE_VGPRS_WAVE64
> +#endif
> +
> +	save_vgprs(0x80)
> +
> +#if ! WAVE32_ONLY
> +	s_branch	L_SAVE_LDS
> +
> +L_SAVE_VGPRS_WAVE64:
> +	save_vgprs(0x100)
> +#endif
> +
> +L_SAVE_LDS:
> +	// If no LDS is allocated then skip save.
> +	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
> +	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
> +	s_cbranch_scc0	L_SAVE_DONE
> +
> +	// Wavegroups wait for a barrier to ensure shared VGPRs have been saved.
> +	s_bitcmp1_b32	s_save_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc0	L_SAVE_SKIP_WAVEGROUP_VGPR_BARRIER
> +	s_barrier_signal	-2
> +	s_barrier_wait	-2
> +
> +L_SAVE_SKIP_WAVEGROUP_VGPR_BARRIER:
> +	// Only the first wave in a group saves LDS.
> +	s_bitcmp1_b32	s_save_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +	s_cbranch_scc0	L_SAVE_DONE
> +
> +	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
> +	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
> +	s_add_u32	s_save_tmp, s_save_tmp, (get_sgpr_size_bytes() + get_hwreg_size_bytes())
> +	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
> +	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
> +
> +	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
> +	s_mov_b32	s_save_tmp, 0
> +	s_set_vgpr_frames	0
> +	s_set_gpr_idx_u32	dst_idx0, 0
> +
> +	// v0 = [0x0, 0x4, 0x8, 0xC, ... 0x7C (wave32) or 0xFC (wave64)]
> +	v_mbcnt_lo_u32_b32	v0, -1, 0
> +#if ! WAVE32_ONLY
> +	v_mbcnt_hi_u32_b32	v0, -1, v0
> +#endif
> +	v_lshlrev_b32	v0, 2, v0
> +
> +#if ! WAVE32_ONLY
> +	s_bitcmp1_b32	s_save_flags, S_FLAGS_WAVE64_SHIFT
> +	s_cbranch_scc1	L_SAVE_LDS_WAVE64
> +#endif
> +
> +	save_lds(0x80)
> +
> +#if ! WAVE32_ONLY
> +	s_branch	L_SAVE_DONE
> +
> +L_SAVE_LDS_WAVE64:
> +	save_lds(0x100)
> +#endif
> +
> +L_SAVE_DONE:
> +	// Make sure that no wave of the group/cluster can exit the trap handler
> +	// before the group/cluster barrier state is saved.
> +	wait_trap_barriers(s_save_tmp)
> +
> +	s_endpgm_saved
> +
> +L_RESTORE:
> +	// Get restore address { 4?b0, lastWaveOfWavegroup, firstWaveOfWorkgroup, 1?b0, memAddr[56:0] }

Same, should the "?" be "'"?

> +	s_mov_b64	[s_restore_base_addr_lo, s_restore_base_addr_hi], exec
> +
> +	// Save last_wave_in_wavegroup / first_wave_in_workgroup flags so we can clear high bits of restore address.
> +	s_bfe_u32	s_restore_tmp, s_restore_base_addr_hi, (S_EXEC_LAST_FIRST_WAVE_SHIFT | (S_EXEC_LAST_FIRST_WAVE_SIZE << 0x10))
> +	s_and_b32	s_restore_base_addr_hi, s_restore_base_addr_hi, ADDRESS_HI32_MASK
> +	s_lshl_b32	s_restore_flags, s_restore_tmp, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +
> +	// Save in_wavegroup and wave64 flags for later use.
> +	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_WAVE_GROUP_INFO, SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT, 1)
> +	s_lshl_b32	s_restore_tmp, s_restore_tmp, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_or_b32	s_restore_flags, s_restore_flags, s_restore_tmp
> +
> +#if ! WAVE32_ONLY
> +	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_WAVE_STATUS, SQ_WAVE_STATUS_WAVE64_SHIFT, 1)
> +	s_lshl_b32	s_restore_tmp, s_restore_tmp, S_FLAGS_WAVE64_SHIFT
> +	s_or_b32	s_restore_flags, s_restore_flags, s_restore_tmp
> +#endif
> +
> +	// HWREG SR memory offset : size(VGPR)+size(SGPR)
> +	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
> +	s_add_u32	s_restore_tmp, s_restore_tmp, get_sgpr_size_bytes()
> +	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
> +	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
> +
> +	// Deallocate VGPRs if needed and skip LDS/VGPR restore.
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x34
> +	s_wait_kmcnt	0
> +	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> +	s_cbranch_scc0	L_RESTORE_LDS
> +	s_sendmsg	sendmsg(MSG_DEALLOC_VGPRS)
> +	s_branch	L_RESTORE_SGPRS
> +
> +L_RESTORE_LDS:
> +	// If no LDS is allocated then skip restore.
> +	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
> +	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
> +	s_cbranch_scc0	L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER
> +
> +	// Only the first wave in a group restores LDS.
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +	s_cbranch_scc0	L_RESTORE_VGPRS
> +
> +	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
> +	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
> +	s_add_u32	s_restore_tmp, s_restore_tmp, (get_sgpr_size_bytes() + get_hwreg_size_bytes())
> +	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
> +	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
> +
> +	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
> +	s_mov_b32	s_restore_tmp, 0
> +
> +	// v0 = [0x0, 0x4, 0x8, 0xC, ... 0x7C (wave32) or 0xFC (wave64)]
> +	v_mbcnt_lo_u32_b32	v0, -1, 0
> +#if ! WAVE32_ONLY
> +	v_mbcnt_hi_u32_b32	v0, -1, v0
> +#endif
> +	v_lshlrev_b32	v0, 2, v0
> +
> +#if ! WAVE32_ONLY
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_WAVE64_SHIFT
> +	s_cbranch_scc1	L_RESTORE_LDS_WAVE64
> +#endif
> +
> +	restore_lds(0x80)
> +
> +#if ! WAVE32_ONLY
> +	s_branch	L_RESTORE_VGPRS
> +
> +L_RESTORE_LDS_WAVE64:
> +	restore_lds(0x100)
> +#endif
> +
> +L_RESTORE_VGPRS:
> +	// Wavegroups wait for a barrier to ensure shared VGPRs are no longer in use.
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc0	L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER
> +	s_barrier_signal	-2
> +	s_barrier_wait	-2
> +
> +L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER:
> +	// In a wavegroup only the last wave restores VGPRs.
> +	s_and_b32	s_restore_tmp, s_restore_flags, (S_FLAGS_IN_WAVEGROUP_MASK | S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK)
> +	s_cmp_eq_u32	s_restore_tmp, S_FLAGS_IN_WAVEGROUP_MASK
> +	s_cbranch_scc1	L_RESTORE_SGPRS
> +
> +	// VGPR SR memory offset : 0
> +	s_mov_b64	[s_restore_addr_lo, s_restore_addr_hi], [s_restore_base_addr_lo, s_restore_base_addr_hi]
> +
> +	get_vgpr_num(s_restore_alloc_size)
> +	s_mov_b32	s_restore_tmp, 0
> +	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
> +
> +#if ! WAVE32_ONLY
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_WAVE64_SHIFT
> +	s_cbranch_scc1	L_RESTORE_VGPRS_WAVE64
> +#endif
> +
> +	restore_vgprs(0x80)
> +
> +#if ! WAVE32_ONLY
> +	s_branch	L_RESTORE_SGPRS
> +
> +L_RESTORE_VGPRS_WAVE64:
> +	restore_vgprs(0x100)
> +#endif
> +
> +L_RESTORE_SGPRS:
> +	// SGPR SR memory offset : size(VGPR)
> +	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
> +	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
> +	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
> +
> +	// s[104:107]
> +	s_mov_b32	s_restore_tmp, (0x68 * 4)
> +	s_load_b128	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +	s_mov_b32	m0, (0x68 << 0x10)
> +for var sgpr_idx = 0; sgpr_idx < 4; sgpr_idx += 2
> +	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
> +end
> +
> +	// s[96:103]
> +	s_sub_u32	s_restore_tmp, s_restore_tmp, 0x20
> +	s_load_b256	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +	s_sub_u32	m0, m0, (0x8 << 0x10)
> +for var sgpr_idx = 0; sgpr_idx < 8; sgpr_idx += 2
> +	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
> +end
> +
> +	// s[80:95], s[64:79], ... s[0:15]
> + L_RESTORE_SGPR_LOOP:
> +	s_sub_u32	s_restore_tmp, s_restore_tmp, 0x40
> +	s_load_b512	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +	s_sub_u32	m0, m0, (0x10 << 0x10)
> +for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx += 2
> +	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
> +end
> +
> +	s_cmp_eq_u32	m0, 0
> +	s_cbranch_scc0	L_RESTORE_SGPR_LOOP
> +
> +	// s_barrier with STATE_PRIV.TRAP_AFTER_INST=1, STATUS.PRIV=1 incorrectly asserts debug exception.
> +	// Clear DEBUG_EN before and restore MODE after the barrier.
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_MODE), 0
> +
> +L_RESTORE_HWREG:
> +	// HWREG SR memory offset : size(VGPR)+size(SGPR)
> +	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
> +	s_add_u32	s_restore_tmp, s_restore_tmp, get_sgpr_size_bytes()
> +	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
> +	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
> +
> +	s_load_b32	s_restore_m0, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS
> +	s_load_b32	s_return_pc_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x4
> +	s_load_b32	s_return_pc_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x8
> +	s_load_b32	s_restore_exec_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0xC
> +	s_load_b32	s_restore_exec_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x10
> +	s_load_b32	s_restore_state_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x14
> +	s_load_b32	s_restore_excp_flag_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x18
> +	s_load_b32	s_restore_xnack_mask, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x1C
> +	s_load_b32	s_restore_mode, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x20
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x24
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_LO), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x28
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_HI), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x2C
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x30
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x40
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_GPR_MSB_IDX0), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x44
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_GPR_IDX123), s_restore_tmp
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x48
> +	s_wait_kmcnt	0
> +	s_cmp_eq_u32	s_restore_tmp, 1
> +	s_cbranch_scc0	L_RESTORE_NO_IC_HASH_DISABLE
> +	s_mov_b32	m0, 1
> +	s_sendmsg_rtn_b32	null, sendmsg(MSG_RTN_SET_CACHE_MODE)
> +	s_wait_kmcnt	0
> +
> +L_RESTORE_NO_IC_HASH_DISABLE:
> +	// Ensure all waves of the group/cluster are created before restoring barrier state.
> +	wait_trap_barriers(s_restore_tmp)
> +
> +	// Only the first wave needs to restore group barriers.
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +	s_cbranch_scc0	L_RESTORE_SKIP_GROUP_BARRIER
> +
> +	// Skip group barriers if wave is not part of a group.
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x38
> +	s_wait_kmcnt	0
> +	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> +	s_cbranch_scc0	L_RESTORE_SKIP_GROUP_BARRIER
> +
> +	// Restore workgroup barrier signal count.
> +	restore_barrier_signal_count(-1)
> +
> +	s_mov_b32	s_restore_mem_offset, NAMED_BARRIERS_SR_OFFSET_FROM_HWREG
> +	s_mov_b32	m0, 1
> +
> +L_RESTORE_NAMED_BARRIER_LOOP:
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], s_restore_mem_offset scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +	s_bitcmp0_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> +	s_cbranch_scc1	L_RESTORE_SKIP_GROUP_BARRIER
> +
> +	s_or_b32	m0, m0, s_restore_tmp
> +	s_barrier_init	m0
> +
> +	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
> +	s_and_b32	m0, m0, BARRIER_STATE_ID_MASK
> +	s_add_u32	m0, m0, 1
> +	s_cmp_gt_u32	m0, NUM_NAMED_BARRIERS
> +	s_cbranch_scc0	L_RESTORE_NAMED_BARRIER_LOOP
> +
> +L_RESTORE_SKIP_GROUP_BARRIER:
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x3C
> +	s_wait_kmcnt	0
> +
> +	// Skip cluster barrier restore if wave is not part of a cluster.
> +	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> +	s_cbranch_scc0	L_RESTORE_SKIP_CLUSTER_BARRIER
> +
> +	// Only the first wave in the group signals the trap cluster barrier.
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
> +	s_cbranch_scc0	L_RESTORE_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
> +
> +	// Clear SCC: s_barrier_signal_isfirst -4 writes SCC=>1 but not SCC=>0.
> +	s_cmp_eq_u32	0, 1
> +	s_barrier_signal_isfirst	-4
> +
> +L_RESTORE_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
> +	s_barrier_wait	-4
> +
> +	// Only the first wave in the cluster restores the barrier.
> +	s_cbranch_scc0	L_RESTORE_SKIP_CLUSTER_BARRIER
> +
> +	// Restore cluster barrier signal count.
> +	restore_barrier_signal_count(-3)
> +
> +	s_mov_b32	s_restore_mem_offset, NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG
> +	s_mov_b32	m0, 0x21
> +
> +L_RESTORE_NAMED_CLUSTER_BARRIER_LOOP:
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], s_restore_mem_offset scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +	s_bitcmp0_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> +	s_cbranch_scc1	L_RESTORE_SKIP_CLUSTER_BARRIER
> +
> +	s_or_b32	m0, m0, s_restore_tmp
> +	s_barrier_init	m0
> +
> +	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 0x4
> +	s_and_b32	m0, m0, BARRIER_STATE_ID_MASK
> +	s_add_u32	m0, m0, 1
> +	s_cmp_gt_u32	m0, (0x20 + NUM_NAMED_CLUSTER_BARRIERS)
> +	s_cbranch_scc0	L_RESTORE_NAMED_CLUSTER_BARRIER_LOOP
> +
> +L_RESTORE_SKIP_CLUSTER_BARRIER:
> +	// Locks and semaphores are only supported in wavegroups.
> +	s_bitcmp1_b32	s_restore_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc0	L_RESTORE_SKIP_LOCKS_SEMAPHORES
> +
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x4C
> +	s_wait_kmcnt	0
> +
> +L_RESTORE_LOCK_LOOP:
> +	s_cmp_eq_u32	s_restore_tmp, 0
> +	s_cbranch_scc1	L_RESTORE_LOCKS_DONE
> +
> +	s_ctz_i32_b32	m0, s_restore_tmp
> +	s_try_lock	m0
> +	s_wait_kmcnt	0
> +
> +	s_bitset0_b32	s_restore_tmp, m0
> +	s_branch	L_RESTORE_LOCK_LOOP
> +
> +L_RESTORE_LOCKS_DONE:
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x50
> +	s_wait_kmcnt	0
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA_MODE), s_restore_tmp
> +
> +#if SEMA_DONE_RESTORE_WORKAROUND
> +	label L_RESTORE_SEMA_IS_DONE[NUM_SEMAPHORES]
> +	label L_RESTORE_SEMA_NEXT[NUM_SEMAPHORES]
> +#endif
> +
> +for var sema_idx = 0; sema_idx < NUM_SEMAPHORES; sema_idx ++
> +	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:(0x54 + sema_idx * 4)
> +	s_wait_kmcnt	0
> +
> +#if SEMA_DONE_RESTORE_WORKAROUND
> +	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_SEMA_STATE_DONE_SHIFT
> +	s_cbranch_scc1	L_RESTORE_SEMA_IS_DONE[sema_idx]
> +
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
> +	s_add_u32	null, 0, 0
> +	s_branch	L_RESTORE_SEMA_NEXT[sema_idx]
> +
> +L_RESTORE_SEMA_IS_DONE[sema_idx]:
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
> +	s_nop		0
> +
> +L_RESTORE_SEMA_NEXT[sema_idx]:
> +#else
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
> +#endif
> +
> +end
> +
> +L_RESTORE_SKIP_LOCKS_SEMAPHORES:
> +	s_mov_b32	m0, s_restore_m0
> +	s_mov_b32	exec_lo, s_restore_exec_lo
> +	s_mov_b32	exec_hi, s_restore_exec_hi
> +
> +#if HAVE_XNACK
> +	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_MASK), s_restore_xnack_mask
> +#endif
> +
> +	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
> +	// Only restore the other fields to avoid clobbering them.
> +	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, 0, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE), s_restore_excp_flag_priv
> +	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE), s_restore_excp_flag_priv
> +	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE), s_restore_excp_flag_priv
> +
> +	s_setreg_b32	hwreg(HW_REG_WAVE_MODE), s_restore_mode
> +
> +	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
> +	// ttmp SR memory offset :
> +	// - gfx12:   size(VGPR)+size(SGPR)+0x40
> +	// - gfx12.5: size(VGPR)+size(SGPR)-0x40
> +	get_vgpr_size_bytes(s_restore_ttmps_lo, s_restore_flags)
> +	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
> +	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_base_addr_lo
> +	s_addc_u32	s_restore_ttmps_hi, s_restore_base_addr_hi, 0x0
> +	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x10 scope:SCOPE_SYS
> +	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x20 scope:SCOPE_SYS
> +	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x34 scope:SCOPE_SYS
> +	s_wait_kmcnt	0
> +
> +#if HAVE_XNACK
> +	restore_xnack_state_priv(s_restore_tmp)
> +#endif
> +
> +	s_and_b32	s_return_pc_hi, s_return_pc_hi, ADDRESS_HI32_MASK	//Do it here in order not to affect STATUS
> +	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
> +	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
> +
> +	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
> +
> +	// Make barrier and LDS state visible to all waves in the group/cluster.
> +	// STATE_PRIV.*BARRIER_COMPLETE may change after this point.
> +	wait_trap_barriers(s_restore_tmp)
> +
> +	// SCC is changed by wait_trap_barriers, restore it separately.
> +	s_lshr_b32	s_restore_state_priv, s_restore_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, 1), s_restore_state_priv
> +
> +	s_rfe_b64	s_return_pc_lo						//Return to the main shader program and resume execution
> +end
> +
> +function get_vgpr_num(s_vgpr_num)
> +	s_getreg_b32	s_vgpr_num, hwreg(HW_REG_WAVE_GPR_ALLOC, SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT, SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
> +	s_add_u32	s_vgpr_num, s_vgpr_num, 1
> +	s_lshl_b32	s_vgpr_num, s_vgpr_num, 2				//Number of VGPRs = (vgpr_size + 1) * 4
> +end
> +
> +function get_vgpr_size_bytes(s_vgpr_size_byte, s_flags)
> +	s_bitcmp1_b32	s_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc0	L_HAVE_VGPR_SAVE_AREA
> +	s_bitcmp1_b32	s_flags, S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT
> +	s_cbranch_scc1	L_HAVE_VGPR_SAVE_AREA
> +
> +	s_mov_b32	s_vgpr_size_byte, 0
> +	s_branch	L_VGPR_SIZE_DONE
> +
> +L_HAVE_VGPR_SAVE_AREA:
> +	get_vgpr_num(s_vgpr_size_byte)
> +	s_bitcmp1_b32	s_flags, S_FLAGS_WAVE64_SHIFT
> +	s_cbranch_scc1	L_HAVE_VGPR64
> +	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, 7			//Size of VGPRs = (vgpr_size + 1) * 4 * 32 * 4
> +	s_branch	L_VGPR_SIZE_DONE
> +
> +L_HAVE_VGPR64:
> +	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, 8			//Size of VGPRs = (vgpr_size + 1) * 4 * 64 * 4
> +
> +L_VGPR_SIZE_DONE:
> +end
> +
> +function get_sgpr_size_bytes
> +	return 512
> +end
> +
> +function get_hwreg_size_bytes
> +	return 512
> +end
> +
> +#if HAVE_XNACK
> +function save_and_clear_xnack_state_priv(s_tmp)
> +	// Preserve and clear XNACK state before issuing further translations.
> +	// Save XNACK_STATE_PRIV.{FIRST_REPLAY, REPLAY_W64H, FXPTR} into ttmp11[22:14].
> +	s_andn2_b32	ttmp11, ttmp11, (TTMP11_FIRST_REPLAY_MASK | TTMP11_REPLAY_W64H_MASK | TTMP11_FXPTR_MASK)
> +
> +	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE)
> +	s_lshl_b32	s_tmp, s_tmp, TTMP11_FIRST_REPLAY_SHIFT
> +	s_or_b32	ttmp11, ttmp11, s_tmp
> +
> +	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE)
> +	s_lshl_b32	s_tmp, s_tmp, TTMP11_REPLAY_W64H_SHIFT
> +	s_or_b32	ttmp11, ttmp11, s_tmp
> +
> +	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE)
> +	s_lshl_b32	s_tmp, s_tmp, TTMP11_FXPTR_SHIFT
> +	s_or_b32	ttmp11, ttmp11, s_tmp
> +
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV), 0
> +end
> +
> +function restore_xnack_state_priv(s_tmp)
> +	s_lshr_b32	s_tmp, ttmp11, TTMP11_FIRST_REPLAY_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE), s_tmp
> +
> +	s_lshr_b32	s_tmp, ttmp11, TTMP11_REPLAY_W64H_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE), s_tmp
> +
> +	s_lshr_b32	s_tmp, ttmp11, TTMP11_FXPTR_SHIFT
> +	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE), s_tmp
> +end
> +#endif
> +
> +function wait_trap_barriers(s_tmp)
> +	// If not in a WG then wave cannot use s_barrier_signal_isfirst.
> +	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_STATUS)
> +	s_bitcmp0_b32	s_tmp, SQ_WAVE_STATUS_IN_WG_SHIFT
> +	s_cbranch_scc1	L_TRAP_CLUSTER_BARRIER_SIGNAL
> +
> +	s_barrier_signal_isfirst	-2
> +	s_barrier_wait	-2
> +
> +	// Only the first wave in the group signals the trap cluster barrier.
> +	s_cbranch_scc0	L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
> +
> +L_TRAP_CLUSTER_BARRIER_SIGNAL:
> +	s_barrier_signal	-4
> +
> +L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
> +	s_barrier_wait	-4
> +end
> +
> +function restore_barrier_signal_count(barrier_id)
> +	// extract the saved signal count from s_restore_tmp
> +	s_bfe_u32	s_restore_tmp, s_restore_tmp, (BARRIER_STATE_SIGNAL_OFFSET | (BARRIER_STATE_SIGNAL_SIZE << 0x10))
> +
> +	// We need to call s_barrier_signal repeatedly to restore the signal count
> +	// of the group/cluster barrier. The member count is already initialized.
> +L_BARRIER_RESTORE_LOOP:
> +	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
> +	s_cbranch_scc0	L_BARRIER_RESTORE_DONE
> +	s_barrier_signal	barrier_id
> +	s_add_i32	s_restore_tmp, s_restore_tmp, -1
> +	s_branch	L_BARRIER_RESTORE_LOOP
> +
> +L_BARRIER_RESTORE_DONE:
> +end
> +
> +function save_vgprs(vgpr_size)
> +L_SAVE_VGPR_LOOP:
> +	// Index groups of VGPRs v[0,1,2,3], v[4,5,6,7], ...
> +	s_set_gpr_idx_u32	dst_idx0, s_save_tmp
> +
> +for var vgpr_idx = 0; vgpr_idx < 4; vgpr_idx ++
> +	global_store_addtid_b32	v[vgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(vgpr_idx * vgpr_size)
> +end
> +
> +	s_add_u32	s_save_addr_lo, s_save_addr_lo, vgpr_size * 4
> +	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
> +
> +	s_add_u32	s_save_tmp, s_save_tmp, 4
> +	s_cmp_lt_u32	s_save_tmp, s_save_alloc_size
> +	s_cbranch_scc1	L_SAVE_VGPR_LOOP
> +end
> +
> +function save_lds(vgpr_size)
> +L_SAVE_LDS_LOOP:
> +	// Copy LDS to save area in VGPR-sized blocks.
> +	ds_read_b32	v1, v0
> +	s_wait_dscnt	0
> +	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
> +
> +	s_add_u32	s_save_addr_lo, s_save_addr_lo, vgpr_size
> +	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
> +	v_add_nc_u32	v0, v0, vgpr_size
> +
> +	s_add_u32	s_save_tmp, s_save_tmp, vgpr_size
> +	s_cmp_lt_u32	s_save_tmp, s_save_alloc_size
> +	s_cbranch_scc1	L_SAVE_LDS_LOOP
> +end
> +
> +function restore_vgprs(vgpr_size)
> +L_RESTORE_VGPR_LOOP:
> +	// Index groups of VGPRs v[0,1,2,3], v[4,5,6,7], ...
> +	s_set_gpr_idx_u32	dst_idx0, s_restore_tmp
> +
> +for var vgpr_idx = 0; vgpr_idx < 4; vgpr_idx ++
> +	global_load_addtid_b32	v[vgpr_idx], [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:(vgpr_idx * vgpr_size)
> +end
> +
> +	s_add_u32	s_restore_addr_lo, s_restore_addr_lo, vgpr_size * 4
> +	s_addc_u32	s_restore_addr_hi, s_restore_addr_hi, 0
> +
> +	s_add_u32	s_restore_tmp, s_restore_tmp, 4
> +	s_cmp_lt_u32	s_restore_tmp, s_restore_alloc_size
> +	s_cbranch_scc1	L_RESTORE_VGPR_LOOP
> +
> +	s_wait_loadcnt	0
> +end
> +
> +function restore_lds(vgpr_size)
> +L_RESTORE_LDS_LOOP:
> +	// Copy LDS from restore area in VGPR-sized blocks.
> +	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
> +	s_wait_loadcnt	0
> +	ds_store_b32	v0, v1
> +
> +	s_add_u32	s_restore_addr_lo, s_restore_addr_lo, vgpr_size
> +	s_addc_u32	s_restore_addr_hi, s_restore_addr_hi, 0
> +	v_add_nc_u32	v0, v0, vgpr_size
> +
> +	s_add_u32	s_restore_tmp, s_restore_tmp, vgpr_size
> +	s_cmp_lt_u32	s_restore_tmp, s_restore_alloc_size
> +	s_cbranch_scc1	L_RESTORE_LDS_LOOP
> +
> +	s_wait_dscnt	0
> +end
> -- 
> 2.56.0
> 

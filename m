Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B607CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 20:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C1C10EE94;
	Wed,  6 May 2026 20:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfire8rF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3806A10EE94
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 20:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4PpvqvO9I55Q2zIoYl4nv1EfIPvyrFnjrwW3eupnRB/iBNBqGaovh9TYqcnEFzT36tMAeSyUQLEsoN/cRA2vGPPdcMFtOMnM3xniMOvZfy3M0dUGqiglWlXInu5bHmizT17gq8FXZJBWEG0qJilvVjW/qi4xEZvENQgu/s6LdgF+YdoVq5mXHbXr0xZj6KlADfGGhKxfloyczhstpiK/emuc1wAz0PzRwMgirmJ5XlYom6cd1gYDxLOkfoL+xtreErNj9HDiu5fTx4pI3VXTTYdZ70Dz3+WQ7k1B0wnz2CFHcLv5Lq9jVHW5M8YryMa6R0Jnr7eSCoyOnCA9qr1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvqaVn9jNnavciEnO8oy+j2+6KlzUGp/xPQxTAW02kw=;
 b=spLW9v4V8pnzfwkv7rqsilyp0c6Vk+sara847UYVrMYLnRM55poKwdx2ZEY/G6OAPRs4p4Qin43j3K9spOhdVU9LYUZuI549e68rlNm/bFoSZM/jHIKoVPNm3yIJj8nd6jgx82S+seeW4yJf0tpNUk5oJz2ZNmh3O10cd23r25mX72Km4lgWBw0ZLgT3nVaKGLxxaaVJx9W2ZjPoe+6bTyuGZe7ScO2+bXt71ZGCxgX8FGwT39E4z99NeqPYsUqMZvUe4oaf9CB+BYRFP+FmMhUWdj8SHW7ifyrKWiNAmX3XkDVeVSAWggqHDkTT4yofbK5EOrYWvgE5180zxQk2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvqaVn9jNnavciEnO8oy+j2+6KlzUGp/xPQxTAW02kw=;
 b=wfire8rFH5TSaPBN/HYtLQMsHWQyzq6Xek94DYCJi566WEfSUkf78GSft8NbsB7uF4iMDubg0TEc2ad9GNDKIliiPxvTD9copwlbf/CZHo/jaEHdX5v5IooStR+M6FYbtsXW8MvWt8QbFHQsIV09GiN6xiug7S+PjyVaF2x1Lqk=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:00:15 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::f2) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 20:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 20:00:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 15:00:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 15:00:13 -0500
Received: from [10.254.92.94] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 15:00:12 -0500
Message-ID: <d988ded3-92e5-4900-b6d1-887a96891852@amd.com>
Date: Wed, 6 May 2026 16:00:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use vline2 interrupt on DCN instead of
 vstartup
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Aurabindo.Pillai@amd.com>,
 <mario.limonciello@amd.com>, <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>
References: <20260504183649.165131-1-sunpeng.li@amd.com>
 <2349271.vFx2qVVIhK@timur-hyperion>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <2349271.vFx2qVVIhK@timur-hyperion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e276013-8e67-48de-5e22-08deabaa170c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|32650700020|82310400026|36860700016|376014|13003099007|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: uuncZ+895SChpuCtNIIBxxOTgbyB/eTVe770C+Qf9UsBdhw8u18FoKvz8YaRM5xEbOdlOd18j142OJEm4PO37K6Rn7X8J6aS/7dwy3DYe6i+EUMPf5rD9AvUpaLVFxeDGojJuq2zcNMa2M3jP8snFUk0YG4IyrcKMbMYjgmoLo6R5OfbdR/xWdiwtJzc1Ct22cYJ4rvN+V+b4Vi0e4E9RwB3/PyoAX2zbKTTdBAEYoGkqytDdSxSz+VuQy7tvaKWjc55Y8wdbcbs5lvReSOeE+DNYigz5ReLWLs9/LXnIpNqZ1k72+yf4DgRYba6pkq+ej588Z0tDWZdYNb97Gq5NqlmQ5J9IWEumr9mwx1cj78KL5NvptuML8oXn4Ni325aneEnG0nbsfqNAA5QDVatmttvzjxNZ6/N8PM9zx7WBI2HxUclR9CeZkl01dTFi94jx3yKu3pFrn3am0KNof85Etq3uUfkM+Bm2fRy8Y62J7OEDMdcpRawSKAaBrrZlN1zTkQGc4JfqqnI3BOaUC6OqCb3dPMPpTySdHcISiMr0jzBSsAUf3V/kHNKcKUTSfW0SN6HuExqv+O1qJn46WxDXiodHTmtUxxI70/dDWCEEGiRPdzbThh+6L0Dnr00YG/4NdJHGvkyI/WMXw3b1NvNt5zfgRloxcXNXXZYjKbKVhO30PEdXYIOW5DTqQaNVFy0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(32650700020)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U6Rn4TBpwfBr5e1wOmL0eO8C071Yr9Lt5Pxs0Sqm2qUkzZwjndSVEn0Xm54bo7G1oHyoAggk1SsHdrMl2n+m6UjH2Eih4TAGmumtgdj1GGhIj8d+8pP72Dgw3ff0Il0EF6ByGrJSapjx43TdbXx8/4JgFxD8Ut8ycLop/tT2AOlyBeqEl43cyV0D2dV1vLvp0j7HR5ATLkxlIg0I9XkgrA+Xufpn9cGFBNBkIAUtPe5sLvlLeRK6Fu9EJymDDHcgQRBYM3K5AcJFqb+U2nporrAaAI8/svdniC7u2Ikd/xqIfRqiUpzvZ6jJfzssStp9rgXAAMO9ryXLTB0XosFjpgLwkzx1NI3z8hs26I0MkukxZtPNW1ewYD7bRJubgjRqaXz/mcudjzMPQ4UENO3k58fHvSjcHHRj5WQU74cDe8ChZedkIfzurCXyWP2JC7be
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:00:15.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e276013-8e67-48de-5e22-08deabaa170c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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



On 2026-05-04 16:54, Timur Kristóf wrote:
> On Monday, May 4, 2026 8:36:49 PM Central European Summer Time 
> sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> VStartup is an OTG event that fires when the pixel pipeline prepares for
>> pixel scanout of the next frame. It was previously used to deliver
>> vblank events for commits that do not trigger a fb address update, and
>> hence a pflip interrupt (hw cursor updates, for example).
>>
>> The issue with vstartup is that HW can mask the interrupt in cases where
>> idle optimizations are enabled or when a HW lock is active. This could
>> the explain the range of flip_done timeouts frequently seen in the wild.
> Can you help me understand how that could happen with vstartup?
> Specifically, what is a "HW lock" and when is it active?

Hi Timur,

I should've prefaced this patch to say that this is a theoretical fix. I haven't
been able to reproduce the timeout issues myself, and this patch came out of
internal discussions with folks more familiar with the HW. I don't think this
will fix *all* cases of flip_done timeouts, but it may address some of them.

(But timeouts aside, we *should* transition to vline since it's more reliable
than vstartup.)

To answer your questions: depending on the DCN generation, there can be a few
things that affects vstartup firing:

* DPG - DCN can Dynamically Power Gate parts of the display pipe when a
  self-refresh capable eDP is connected. DPG is engaged when there's enough
  static frames (detected thru drm_vblank_off) Once gated, even though the OTG
  (output timing generator) is still enabled, vstartup is masked. vline is
  unaffected.

* GSL - Driver can use the Global Sync Lock to block HW from latching onto
  double-buffered registers during programming, to prevent HW from latching onto
  a partially programmed state. This will mask vstartup, but vline is
  unaffected. See dcn20_pipe_control_lock()

* MALL - A DCN accessible cache introduced in DCN32+ DGPUs that can store fb
  data to allow for longer DRAM sleep. When scanning out from MALL, vstartup is
  masked, vline is unaffected.

> 
> Many users have experienced flip_done timeouts while playing games.
> In that scenario, would any idle optimization be enabled or is there a "HW 
> lock"?

If the game stops submitting frames for ~15 refresh cycles, it's possible that
PSR kicks in. Though I know there are plenty of reporters running on external
without PSR support. If it's DGPUs, it's very likely due to MALL. A reporter I
was debugging with said disabling MALL showed good results[1]. If it's an APU
with an external monitor, then that's less clear.

A lot of the reporters seem to be running Phoenix (DCN314), with a common
symptom of DMUB timing out[2]. If a self-refresh panel is involved, then I'm
curious if this vline2 patch would help. Hamza's recent patch[3] that enables
various levels of reset may help to mitigate, but it doesn't fix the root-cause.
I'm planning a branch with this patch and [3], along with debug dumps on
flip_done timeouts for reporters to try.

[1]https://lore.kernel.org/amd-gfx/e415c38b-4102-40e4-a195-0256caf34802@m1k.cloud/
[2]https://gitlab.freedesktop.org/drm/amd/-/work_items/4831
[3]https://lore.kernel.org/lkml/20260505182105.420525-2-someguy@effective-light.com/

> 
>> DCN hardware provides 3 generic OTG interrupts that can be programmed to>> fire on a specific line. Vline 0 and 1 are currently reserved, with
>> vline2 available to use for event delivery. These interrupts cannot
>> be masked, as long as the OTG is active.
>>
>> [How]
>>
>> Switch to vline2 for vblank handling. Today, DC will program the
>> vline2 position to at vupdate -- the point at which HW latches to
>> double-buffered registers.
>>
>> Since all the vline interrupt types share the same interrupt src_id,
>> refactor the existing vline0 infrastructure to allow for all the vline0,
>> 1, and 2 types.
>>
>> Since this is intended to replace vstartup for DCN, use the same handler
>> logic, but be careful to leave DCE on vstartup.
> Why not also switch DCE?
> Does DCE not have the vline interrupts or does it not have the same issue with 
> the vstartup interrupt?

I didn't want to touch DCE since I don't have information on how these
interrupts behave on them, and I didn't want to regress anything. Would need to
do some digging to find out.

- Leo

> 
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> I think this patch should have a "Fixes:" tag or another way to indicate that 
> it should be backported to stable kernels.
> 
> Thanks,
> Timur


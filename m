Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FDC5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 14:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82F310E41C;
	Fri,  7 Aug 2026 14:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jz4N7KvW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D783710E41C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 14:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP3y49WfMBzHfKl6mps4XSWjt1Ghgnu1lmS5NJKxXql6YIVeV+VNbBCfN+IQ4un6G72EYhpsf5f/bjtlt3+8Sm3mcBRtfErSMAYgMfodp2jPdyXtBsHxI4y2+oImoktUq9OEFxqSE4K2ygrIFLRQELP5yEBS7kGUdQE4pT5LDp2siOEbcitGfxhDG/9KK2FLHZXtpH60g/07ubAMEBaVLCF6A8RdRZG0tAr3uEvYmDnDLAvEZv3Us+p2lmvFrvXVxw1Jdj5o+XemUY67Ma8LFiWpVSnv5Gbs5AEqWu3i6DC2cbCy0bjf2QH7o2N0zTXa93C+ToFxchk9rbfNbppBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZyOq4nLQHhlbf4J7FXpGgQ/oezlf1fT0dvSM2tnP00=;
 b=ADCYAYGmlOiopmFB3nJtF0UZQHhRNTqLNJeARzZSOaEq7vRvMD1CZm6yYQ0Mu73YHyj37O98psdxg8F/RywEYxh3LrE13TSI9/AAuYMdvCqLdNEDrBJjKJd/LSCLK/Q+i4KUQCDGLqVhIrjyLZQVI0cDpXFCiLBQFNG9N0NQZoQL7A9NOsY0X5wfsxi98YLCq5C+Z176SMmb74a5Kjs+04jWUFXsgB9gNyXS1h2NMwDFxJZe8odcFdBnV2W2LaPAHzxuyajcO4j6N5plub+ZproQytvq9FtLEoQ7oGHqo5vex3mKFepOQ5xLqPr1SFqTuGTL4zcNQCT7RgajBZ1A2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZyOq4nLQHhlbf4J7FXpGgQ/oezlf1fT0dvSM2tnP00=;
 b=jz4N7KvWEUgTi04i+xIhUiDxpr5TH5Nm3sSWHNQpqer7snAk73aevJ+Ik3oFy2XinsgjXJPxfQdL7MdWVQDkp8cEYWUel/bPB8fEhjfJaQtEji83GCI7VUXc/UEZZcermkCMFizkLkaSRO13zXzD7WCXbrdm2D3N3vyxuF6anW8=
Received: from IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::13)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:59:40 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:461:cafe::33) by IA1P220CA0005.outlook.office365.com
 (2603:10b6:208:461::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 14:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 14:59:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 09:59:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 09:59:36 -0500
Received: from [10.4.12.179] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 09:59:36 -0500
Message-ID: <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
Date: Fri, 7 Aug 2026 10:59:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
To: <mitchell.augustin@canonical.com>, <amd-gfx@lists.freedesktop.org>
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
 <20260806143408.979209-2-mitchell.augustin@canonical.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260806143408.979209-2-mitchell.augustin@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e74877-316e-40ab-0702-08def4948178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|42112799006|36860700016|376014|13003099007|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /XtQ4TOz1xvM7/cTl96xE05WbNiQHnonU0qAclWzYfgYQRLaXbjylF73vMGCrVbiUGhTN89TRpOadfIiIoheNLw8FyroYvfTEloqmqlvC44S7vRlDteNPf++Bhq5NPbAJrAHgBlpAaDUezTQH08E3EfB4QMME7Jt1+EeFV5i9hOPUlddXtbaJ/vNjWmHKa3nNA+pJAy/9eN5mpQUEWKwGQiBKREgXCpIZ2ETTaD3F1Fdn4fKA0oIdC+j4nLxqTUZTSN9XPHbYRwKePvwcNuksvoNl0L9s5BextxutJdnCGSY8E/ILUcuK5n/L93YaEBfPm0AYuSBPOKcUeDgsTYSwV2kuFm27ud7/PpyscOOlg0AO8KDkzkH86FgV24SRn8leEtQyCFvc2n/EhtjgucmylwbzSlSlyCpAgznXgBLGToUUG+Sx3UutRAEgFFMITDx22Gq7UKT6jTVpBq+cIlfie+qqQWd8gVyqjXbmjQ5/FulGmtgIOKLzCye/oobffg+ZLELDQa/GzHx4ra+Sc8KDjQy/7uRCli4L3XFlbHRweP+pbBY3dheUhifTpXVl5wvJKG/NMpj9He0ynYjGardQqoRW6v9lCD5VXgL9xiO+MERkObru/7yc+14nFoUwlWFd3UowbO7sK3SgQUkCo2CilWKoHhZqDSSKXO88tS0/sblvxeIcAziFbvzxH8mjAbqJWQgD9dpxOvrIfCKsasdRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(42112799006)(36860700016)(376014)(13003099007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xjB4QCADOQD0poXM5zN7HirieX1fq87hGRu8As7jkm7BagcdgOG5D84+DnXSAqsk25fl47ngY66lYx5upPBsOft5RF7jrQjBXQLglnsg++WbuqcNPSPZmrvqvcAN0jZpD/0JSDpRh4JZl50gIyt957OJLq/RglGk1FzSS66XKsoK8FwlALV1tS0O2F+oWhyM9z+HpOHHDzQD9GX0QVf/WQ2/5eCXm3X16MBzmhiG8WLR2LRIXocc+dZ/aXjrxitprs3jhDY0PuEi6oSV3L9C6GmQP1hUNOQH1b+c/a4YXvkXO7l4hvXVsOxBF3xzCMPgc0+fIQrjnE6kLLtTqsmgXF4+BKraM1PdxM2h846yAPm4Q1OM/qkrUGjk8pmFZZ7EWRU7RYn/26vFDlkl/yF/NVSbB3YUSfwJEtZgjTO2zyDjw/DOmspqWRHHGMbCWiRF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:59:39.7166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e74877-316e-40ab-0702-08def4948178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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



On 2026-08-06 10:34, mitchell.augustin@canonical.com wrote:
> [Some people who received this message don't often get email from mitchell.augustin@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Mitchell Augustin <mitchell.augustin@canonical.com>
> 
> Issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/5394
> Ubuntu BugLink: https://bugs.launchpad.net/bugs/2162904
> 
> This commit disables panel self-refresh when more than one display is
> active to eliminate a common hang and system crash that happens
> frequently on some laptops, evidently due to race conditions between
> the DMCUB, amdgpu module, and possibly other components which are
> exacerbated when more than one display is active.
> 
> To my knowledge, a fix for the underlying failure condition is not
> available upstream, so given how disruptive this is for impacted users,
> I propose disabling this feature under this condition until it is fixed.
> The main downside of disabling PSR is that it
> will increase power consumption, but this should be barely noticeable to
> end users, since PSR will remain enabled on laptops unconnected to
> external monitors, and since laptops connected to external monitors are
> likely typically also connected to power (and thus less concerned with
> the energy savings afforded by PSR).
> 
> Signed-off-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> 

Hi Mitchell,

Do you know if this issue still occurs on 7.2-rc6? It includes a bunch of fixes targeting flip-done timeout issues that involved PSR.

Thanks,
Leo

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 5d2715f78314..272f195b8c28 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -152,7 +152,8 @@ void amdgpu_dm_crtc_set_panel_sr_feature(
>                 struct amdgpu_dm_connector *aconn =
>                         (struct amdgpu_dm_connector *) stream->dm_stream_context;
> 
> -               if (!aconn->disallow_edp_enter_psr) {
> +               /* Do not enter PSR if multiple displays are active to prevent DMCUB hangs */
> +               if (!aconn->disallow_edp_enter_psr && dm->dc->current_state->stream_count == 1) {
>                         amdgpu_dm_psr_enable(stream);
>                         if (dm->idle_workqueue &&
>                             (dm->dc->config.disable_ips == DMUB_IPS_ENABLE) &&
> --
> 2.43.0
> 


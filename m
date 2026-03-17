Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FAFED9F6
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 17:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF6510E17F;
	Tue, 17 Mar 2026 17:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hoymnsVS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE0210E70A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 17:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzA2eT41C7SLk09ApEnok/IlUBkWOsUl6HUBuPipUJnb2QixQcVcGCVO6jm0vvCYvd5VX2BDuKVdN7U911sB8OpF609RvKq+Mf60ypV0477a2q+zl/P6C2PZLJeO9JBS1aFxNWoIDIhy8oQ76L6yEXtNBZMSq5/7eCVxYQxXiuOa4ZAYP6d3Er/8VZR2xvgefByc9rRGQ+3yh3n8K4oRdqazu7lFCQLTU+jQg1x+4LV6bCE++Z9mrV9izNC1TxAPVO4+31i/kukQJqX3XcFt4ALl0wW8U7BEwdJ1+4qOsL76CyoNw1eaxxKUu6qC+FKT5Lsuxwknc1qX5hMExTY7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXPdaZin6lG1tJM4XS5DCE1CoWRUawiZ2UFJymFtp8Q=;
 b=k5vClmaB6KRP/oQZ3h3CnNOXOx7D2k0bN2BJOm4ApeQCb8cIDjOOgyijd5RaVXXUe+otLV3k/hr873a3F4xZOUysb3iVhXiM7kyhvQYkOMLj27Sg9dg1/v/SxbysjOC4UC/2cJgYS3mTDkeWdMwH/+A67O7ZzXfxTlD4xUXsDWNH62HUT/VW/Hcn2y/RSAHeYDRvu7+oe520iqPbrsumKh7fgSHcg436V+EUba6lxYGxZP8MtyODCJgTQg8X68pgqILoPZ53V76gQ+7sjmroSC3oudaVgJmPxz47eYiziR/pUxp8FBglKxP+8Qs3/TfI5UVOK0rGfSukxYRQOgZryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXPdaZin6lG1tJM4XS5DCE1CoWRUawiZ2UFJymFtp8Q=;
 b=hoymnsVSMWpPUw55K3V/F21KW8IOtgxtkbyGBMCZz99M2tKQxQe7fqflvUiwBknyXY3rrh0T3aQnPrCGvZM3BRgkIwiXsSyQ89OsrHBHqUj4td35NjzujBOaElL+hIs7nZzq71GMoMFHcvGHnUMTLALQiE4qtwHtwN8TVVxO7tw=
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Tue, 17 Mar
 2026 17:49:31 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 17:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 17:49:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 12:49:29 -0500
Received: from [10.254.92.47] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 12:49:29 -0500
Message-ID: <ec2ae9de-db16-466b-b35a-1804172698a9@amd.com>
Date: Tue, 17 Mar 2026 13:49:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Add NV12/P010 formats to primary
 plane"
To: Harry Wentland <harry.wentland@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20260317170851.296517-1-harry.wentland@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260317170851.296517-1-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ffd6c5-c805-4167-763e-08de844d8aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p5lomzyLLiSEdQMFi5q2uYHTDj9MAgGHgKSTxVLMSpQAgbXVoukWQT8EWUCLra6TXbtvZg8fwnl3lQg+zoOG+r5X7KXX6EOtWCBEiR89eQS8oVO27U7Rj/xPN4LZDfilV6/94PWwXiMWI7b+SberIWhRHROmNg3I6QULpfwhk3+AM0p1kbBiwykoQllkLsidpkf6YyC7IvNHu31EKRUVFRWqZ+dY2xDKA1dB9C3nwD4SO8zJkt4OvZzfMVeFfobJtIM0K17yoGVv+QUPeeKn2EM6pXEyaTYCx0SXgYS1lKENrjvfQP6iNglPAJAgUKIfHC2JZBtSgrZTIeYBUeFNUIPxT5a9jh5mv6RYw9hjIVY4zkQwvkj/f0y2ckqoiqVAucYw233Yl/eAM8sthKJG0x+44bgxq+22MJcqzrMHjLcEdWADiLBaEkVxNqmZXd//MP/vHkCsNrX/fBtXHiN/21Uw+F5mRh9QflDNTB/w44SHjGrFeU2JuaIdzjEz9umgnACu45WtFmzq0QPTKBkHR5OxhE3Rn30VokiaCZw2K8oL7TBNzP9sP2+/UyRhbLAk65RenbrwxEjCITuKRO5fgljfE509Yap82QJbb8tRnTPIflYUgKxPk/9U+t5H2c7zWU1hnQ/YfnWxWuNVdqANU3p5iPyG3nNndrchxfUxa+Ahy3AEdCsCsn/fHGa7AgYZe3Vo8X1e/V9o6uNvMb27CvyVl5qZIXo75sgNf/XhWJuaewRA0MxLRMmn4072PV5B0oUG1Mv5XGXyg6FbccpFCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5eZrIgmPnBvZsaPJJsqWsCaTPpb40sJc+MBNAPSVsKnHyMYq7oUtFKJr3ALpXhjAbl5SaI6k6t6+Z5pjVfkz0bkRo1U6k6c6sXCORcy01EmEq7VgOi8gnM9y3RxhdTQ+JMHEvH2EJK2LXIS4ookvYJDBAH8H72Tblnt/QYy8RQ+nuUqIzCN4KdZ3KeUswNl5G71bdkgaQj/cUSeTC9WmnA9L+3EsuFGkdBN3XMkHkMuj0LMk9N0bCIRDq4S6xOoifNIBBgVSAfYN3//zNaj2MqOznjOPfU2e+/b0IwFlmI4TwkbYWfIThwvw42kBGbqYyE5TtFw1FaH9ABiizHK/dgSWTlhhU4DMrGYy2oU5iKqCKsdzLsG7vua1uKCg5LF+5Qp8Tu0OvmUqBPNKeUyddTl8d5+y94kFMZ6215MHZf+P2c0DcNV8EtpcUvqKWmiK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:49:30.5810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ffd6c5-c805-4167-763e-08de844d8aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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



On 2026-03-17 13:08, Harry Wentland wrote:
> With this change we're adding NV12 and P010 twice to reported
> formats on a primary plane, which causes us to hit an assert
> in Weston.
> 
> This reverts commit e01716e8352a3cf504058fd6ab90d8969e379275.
> 
> Fixes: e01716e8352a ("drm/amd/display: Add NV12/P010 formats to primary plane")
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 0638f77c511b..812497d428aa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -62,9 +62,6 @@ static const uint32_t rgb_formats[] = {
>  	DRM_FORMAT_XBGR8888,
>  	DRM_FORMAT_ABGR8888,
>  	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_NV21,
> -	DRM_FORMAT_NV12,
> -	DRM_FORMAT_P010
>  };
>  
>  static const uint32_t overlay_formats[] = {


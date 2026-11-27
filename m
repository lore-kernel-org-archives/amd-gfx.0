Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B861606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GAtuMHM0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C9610E2AB;
	Fri, 27 Nov 2026 05:44:23 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE7810E2AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 05:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk39G8MeYPJBBLcFvv5g9bwl01HqEKOn5VR0itfRCboA/8HkNBhkZ0X2j0s4Qd8ifSVKVWsOr+kD/ZtDShmFhOZRP8QcSCIvlUVA6GOu84faUMRBeD/V4yMS5VoIHu5bucmbedAgE8UFYkuK1ApPi2gRZonO7TM0phqocD5DoaOPFuFwXHZUmTi1oVqT9xbFXYHj6M3rsA1iogpSVbDdhrH1ZulVuX1aSjKUS6bdMeaU8TkF1xIvsZ7jLN+XmDzUEC8U/IdtzhZPuJY45qke6uGwFOTbRD3SRktAHuvFZF8B8QzMQ40RI93uztsN1Q5hI0O3wui1PuCYMqz5TzBH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IMJpwLhiaWP15K9swCM00IfLtM5mkHNqhcIgpw9FuI=;
 b=mIdnmH/NohA7k/QsLiBE9XYHX5l+NjBnXVwLP0eR5tYSCBhi9z+nz6mfheJPQteMj27B3Q7tvlshrb9x5+5sYwCF/I4qhDNqRKMrMfu/MK93fb1jUVKyXR8ieakpFsWwaHsIHDpndIWXHQM+/fLLBCgbjgbbC2j7tJ1+KH5yD6jqdrmwBr161D+njQ2dFnNrplts2H/mpa/8hpcAVzTz3f4dqCmBAWEFzQm4HLRK2GKqIenwC5VyVFkgC++vig2PF9TaMhv0jnpn+IT7uFgHj6pC1CgNJYJcdulHRfJi9YtWXTO0otHOuHiVImmLWRUwzBcDDenoYR5jDzGVPcWAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IMJpwLhiaWP15K9swCM00IfLtM5mkHNqhcIgpw9FuI=;
 b=GAtuMHM0hH6BykLR7z7j66vfKPoIceF8BMp69WcyL1N8cfAYWUUUECYQqjaKQeoFG4E/6ouRsIW6a/R5uTu3E2z5reF5nyyQ0/DfABXtZaBa8nEAWBZcpilZcVqGeEzAyKQKLme3VWUGzcxow365vkTfatnRPdyVPg3Jrc3AwVU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 05:44:12 +0000
Received: from IA0PR12MB8695.namprd12.prod.outlook.com
 ([fe80::5ac3:10c4:b749:65e4]) by IA0PR12MB8695.namprd12.prod.outlook.com
 ([fe80::5ac3:10c4:b749:65e4%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:44:11 +0000
Message-ID: <7702f3d6-42f9-4dee-8324-ff68ca7b3667@amd.com>
Date: Fri, 27 Nov 2026 13:44:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] DC Patches Nov 30 2026
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To IA0PR12MB8695.namprd12.prod.outlook.com
 (2603:10b6:208:485::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8695:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c41cf43-fe25-4747-0e68-08df4c497627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026121527099003|10067099003|11063799006|56012099006|261009223027099003|261021121427099003|261102123227099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jJOYttZqgcSYfr+VdwEFm0kMlbl1coEm8tmZ9ftug8aFGRYtrdjEF9SrPgd2o8qDlrJTxRgcAUC/RSVwg0uzdHyLwVZiB6hzz2aRrJSQZ42dw46/loCuQPong4OKusPjRpV/1IfK3+kgsdbiOo00RI5UW9Z8mrOVICD1TxJUeLjhlrqKlfD6gMD2UTtP5QzXOxXpKAu9TK8knLC8mUcM/qzNdzPsOxyyU1kHlEUl7hjwG4D7ww/QSWskTH8Bju8k9fmbxpeCYbsJz0NEE1DsW5Ld2uPGlrVliaiA/wqBXmujTUo9/oJfLaPJlkRA1dyMLfZBiNGdZXqznqxUFOeQz5l8aPMv4wik//K1r6LrW+exUHSUXxnPTUMXFSvsOAbkxQWbk8fP607fhJVXP7GDsZOad/3VvykgU4q43hZWzho7Q3tAuzCkgHJMNmkYttWAWTeWwiUb/SKRy3dKhyzp2xP7bKzFViUEU68FbVnHDbaobL/JQU2v2ImMUfKukuLbK3Zc0wegcFFab+Wy/udwVmApDFge9RBz9QgDKXfNNMPJUrI/H++yr3976DpQTCA4A5MmC2xDnYNpX3Wo5iY0cE9wwRkl465doXv3DVmV4MMPPJhdxDzXyasRQd0Dv3B09ebnbwhbendatbYuIeU3SkrCPV74kKb0UchsikZhFcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8695.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026121527099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUl6eFBUMG51KzdwL1Bnc3Y4RkVhNnV5a0hjcnRFdVNBUTlNUklsQ3lPK2Rl?=
 =?utf-8?B?N1JRQjdZcmYrK1F5Z095VURrZ2xpVnpkY3RhelZwbkxXclcycmNRaFRzbkZL?=
 =?utf-8?B?TXZLSnpYODQrM3NhVWEvMVdTUjlJVFh0LytPVEd5Q2EvSjNpb204TzkrNlJF?=
 =?utf-8?B?RUVXMFpvR0REVW1ac0k0RUFNY2twdTZEK2F2NFhEYVM1N2tyZ3R1ZERSRHJG?=
 =?utf-8?B?TWFtcURmN2ZHMUo0c29VTnp0bHB4V09pQzMxd1F4YlpNTFEvMEtEVWJVazRa?=
 =?utf-8?B?c2VESks4M1prYXFUTVVDMzZvanA4ME4xZWlscTZUK1N3ejJNaXVuaWZKaVdY?=
 =?utf-8?B?cHp1Zll6dUpqWC95S1FKZ0xWOXVLNUdkc0lwQWlBR1UvL2Z2alFuZ1MwTFRq?=
 =?utf-8?B?MXJkbFdHbWszM1k5azN2WTRpVTgxRy9MbDcrUUlRTGRDQ3cvNm9HVVVpUEpH?=
 =?utf-8?B?R3BPdkwvVWhtWkEzU2ZWUDZveWw2ODV0MVdoSWpKb0F4KzBPbC9RZmMvdnRy?=
 =?utf-8?B?aFdGbkdHVzlHaldFdzBDVzlZYmVYRUJXa2RzamFmbkFtaTNLMmtwRkt2Z2xy?=
 =?utf-8?B?N29QN2tmaG1lVE1HRm5KZnVrNE5xM1RwV2pNRlBYc1lYbDMzbzUwQ2gwQWVF?=
 =?utf-8?B?UXdzSHVacXJueEdxNElManVEUEU1eVdaNTg5eDlTNGNRbExjNGJuWXoycENm?=
 =?utf-8?B?MEFPL1FzV09qajhjUTF1QWVtTlozeUVWaVVMWlhnOU03dklIMzVpTDEyZmgr?=
 =?utf-8?B?QUNwakR1cnh1bEsrL05ZNHZaMk9FZkwwaFFOUUJldUFYNDZwZzNDOGRoc2h3?=
 =?utf-8?B?Ykc1RW5PWDNyUXdFS0NtaytnMXpvZTJ3ZU5Zdi94cCtrYktpaVl2Wm9Da1dW?=
 =?utf-8?B?bGZNdlJLSFhOSmFQMmNEZFRmam9DK3Y5WHp1NUVlbExXTHZpOFN0TjlKc1d3?=
 =?utf-8?B?Z0RsZDgvUFRYSENidFVMRUJCZ1NiaWJncTZtVTVMcWVIK1F5ZEF0dm5pejdo?=
 =?utf-8?B?a1VlM1V6QXZHM3Yrc2dib1Rxb2pqcE1obnRHWHdLUkRSUHA5NExPanNaQWw2?=
 =?utf-8?B?bTI0NTY2RE5ENVV0Yk9EM2VQTDQvVFVEYlhjWlpYc1VCd2tLOSt2cjlqdWJ5?=
 =?utf-8?B?bVQ0V29BSDI1RXVYVTZoUFNqYmt0RTJTQ0syUWJaZkJRUktMQUcyeEtaUU9l?=
 =?utf-8?B?SDh5Q3ppYmhJeHhnVlhvaXFJNVVqNkxUak14TlNEWmFJOWVFUm5FbVhMY0pz?=
 =?utf-8?B?RDdTNGFTd2YwRVR0Qkt0NmYxTnZxM3NLSk1nWjRMY3VMaWtJdzVwY1h2SU1i?=
 =?utf-8?B?ekc1WDN5amttRDNpR2NCYUh5ZEk1c1c3STZuRG1sOCtJVHdnTjFMVnpBWEpN?=
 =?utf-8?B?bjhnUXA4bHRpVFRaOFNLeGh1Y01BcVpldTZzUUN5TkVnSmZvTU10aTA0cjVw?=
 =?utf-8?B?cVhIRmRqYmpvZzJrVkZmTDdDTlNYTWU2OGhmaWFMVVpCSUhjQlQzQWoyNnZY?=
 =?utf-8?B?SmJvenVzaWRoTmNOMU9JZ2hiY1p1Z21KNFg3WnVmaFpJd2hwNWd5dlpuVTNn?=
 =?utf-8?B?RWRVWkJGVXRUek4xdXVWRUdkdUZZNnRZMk5veFZCV3pmdzVtUVIvK1JOWHBT?=
 =?utf-8?B?Q2hGc2E4RzZhL1lFRDlGVzdYbUFwRmVsL3JjZHo0MzJQSDgrSFlud25JNGE4?=
 =?utf-8?B?KzI5Y3QrQTUrUnVMcGNSbWZuWkZQaW1nek9xSEp4dktxZ0lBUkhhWDlRN3hi?=
 =?utf-8?B?eThZOEV5aDFrQjJ6c21RWW94cW44R1lYMTh4QmV5ZC9PMkl2ZXFCNTJuUFZG?=
 =?utf-8?B?UFZHVEZ1K3IzbStJdDZ4NXZIY0RsaW9lalZvdkpyY3dXWlVNWkFDSTJDeGhM?=
 =?utf-8?B?QTRQVTlKbUVFdG9BOEpIWC9XT1VmamRiMHZ0Wmx6TjNiRUQxYnVWLzdiSDcz?=
 =?utf-8?B?dHRmcGJhY3VVc0tGV09JREYzWXNBVkVWaXVJRUtCajBlbmdRakQ4KzJzZXpi?=
 =?utf-8?B?c2o4TXQ3d0xUMDVhN2tlM3JuZmR4WEZCbG1pUk5SYVM2WUsvT3BTaXRxNzY0?=
 =?utf-8?B?WXNPVG9ZR0N5bG1meEpKNkNHZXJ2akNGUnZodmduTWxRMlFVMDhIczNja2cx?=
 =?utf-8?B?eUlSUTBZR0pXMjhYcXZja2R2TmdRVE12WWsvTUZsRzYyd2tLZ0NSZ1JFTnhp?=
 =?utf-8?B?enlRWEtHSnFkVlpwV2hTTk1UREMxWmdHYXNZV3pldGpLVTJvUjllU09qNGtC?=
 =?utf-8?B?N252V3ZtMHlOOHFEL1JlT3NSNk96bFJyS3hIQndzNmtHWUtNYllVUHlVMUMy?=
 =?utf-8?B?WHpjSndXTGFReEhFemt6VnlnN0hVV2NVMTlnSm5nNjJpdm5wUllrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c41cf43-fe25-4747-0e68-08df4c497627
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8695.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:44:11.4059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63nF0Bp45VqlG9frP0+8AHKD3Ewuv/T+kT1LA2vD6UaGBGcVANUBttFxVGpbRLCpTfTonzklR9BXHBVDE+WIig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/25/2026 2:54 PM, Chenyu Chen wrote:
> This DC patchset brings improvements in multiple areas. In summary, we highlight:
>
> - Avoid per-entry long division in __drm_lut32_to_dc_gamma
> - Add more diagnostic logging, a debug option to force the DP link rate
>    and per-CRTC pstate method in connector debugfs
> - Reject Replay activation on an inactive link
> - Decouple PROGRAM_CURSOR_UPDATE_NOW from dc and pipe_ctx
> - Add DPMS-v2 init and tx init, and implement link_set_dpms_off_v2
> - Derive DCN6 DSCCLK range from DISPCLK
> - Carry stream and plane update bits in update_flags and add vsync and
>    immediate flips to the DC2 seamless update
> - Preserve bandwidth floors in overrides
> - Set HDMI bypass earlier
> - Add DMUB timer reference clock to ref_clocks
> - Guard connector I2C transfer without DDC pin
> - Refactor ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE
> - Add amdgpu_dm_dmub tests for alt-ch apertures, SET_CONFIG sync wait,
>    AUX transfer timeout and fused IO replies
> - Use Z8 enter plus exit for vblank reserve
> - Fix two streams sharing one OTG
> - Count planes, not pipes, in the surface check
> - Promote DMUB firmware to release 0.1.86.0
>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Series is

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

Tom


>
> Alan Liu (1):
>    drm/amd/display: Avoid per-entry long division in
>      __drm_lut32_to_dc_gamma
>
> Alex Hung (4):
>    drm/amd/display: Test amdgpu_dm_dmub alt-ch apertures
>    drm/amd/display: Test amdgpu_dm_dmub SET_CONFIG sync wait
>    drm/amd/display: Test amdgpu_dm_dmub AUX transfer timeout
>    drm/amd/display: Test amdgpu_dm_dmub fused IO replies
>
> Allen Pan (1):
>    drm/amd/display: Add debug option to force DP link rate
>
> Alvin Lee (1):
>    drm/amd/display: Add DMUB timer reference clock to ref_clocks
>
> Charlene Liu (1):
>    drm/amd/display: Set HDMI bypass earlier
>
> Dillon Varone (1):
>    drm/amd/display: Capture more diagnostic register state
>
> Dominik Kowalski (3):
>    drm/amd/display: Add DPMS-v2 init
>    drm/amd/display: Add DPMS-v2 tx init
>    drm/amd/display: Implement link_set_dpms_off_v2
>
> Gabe Teeger (1):
>    drm/amd/display: Fix two streams sharing one OTG
>
> Harry VanZyllDeJong (1):
>    drm/amd/display: Reject Replay activation on an inactive link
>
> Ivan Lipski (2):
>    drm/amd/display: Expose per-CRTC pstate method in connector debugfs
>    drm/amd/display: Derive DCN6 DSCCLK range from DISPCLK
>
> James Lin (1):
>    drm/amd/display: Guard connector I2C transfer without DDC pin
>
> Ovidiu Bunea (1):
>    drm/amd/display: Use Z8 enter plus exit for vblank reserve
>
> Piotr Maziarz (1):
>    drm/amd/display: Decouple PROGRAM_CURSOR_UPDATE_NOW from dc and
>      pipe_ctx
>
> Rafal Ostrowski (1):
>    drm/amd/display: Refactor ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE
>
> Taimur Hassan (2):
>    drm/amd/display: [FW Promotion] Release 0.1.86.0
>    drm/amd/display: Promote DC to 3.2.409
>
> Tony Cheng (4):
>    drm/amd/display: Carry the stream and plane update bits in
>      update_flags
>    drm/amd/display: Add the vsync flip to the DC2 seamless update
>    drm/amd/display: Add the immediate flip to the DC2 seamless update
>    drm/amd/display: Count planes, not pipes, in the surface check
>
> Wenjing Liu (1):
>    drm/amd/display: Preserve bandwidth floors in overrides
>
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  21 +-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |   6 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  34 ++
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   1 +
>   .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 283 ++++++++++
>   .../bls_builder/bls_builder_private_types.h   |  12 +
>   .../dc/bls_builder/dcn401_builder_internal.h  |  14 +
>   .../dc/bls_builder/dcn401_seamless_builder.c  | 482 +++++++++++++++---
>   .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  18 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
>   .../drm/amd/display/dc/core/dc_hw_sequencer.c | 192 +++++--
>   .../gpu/drm/amd/display/dc/core/dc_resource.c |  64 ++-
>   .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +
>   .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  76 ++-
>   drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   8 +-
>   .../gpu/drm/amd/display/dc/dc_state_priv.h    |   8 +-
>   drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  66 ++-
>   drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h |   2 +
>   .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  15 +
>   .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   4 +
>   .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |  12 +-
>   .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |   2 +-
>   .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |   2 +-
>   .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  35 +-
>   .../src/inc/dml2_internal_shared_types.h      |   1 +
>   .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   1 +
>   .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   6 +
>   .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   1 +
>   .../display/dc/hubbub/dcn42/dcn42_hubbub.h    |   3 +-
>   .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 108 ++--
>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   2 +
>   .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +
>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +
>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   6 +-
>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +-
>   .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   8 +-
>   .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   2 +
>   .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   2 +
>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  59 ++-
>   .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
>   drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  10 +-
>   .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +
>   drivers/gpu/drm/amd/display/dc/link/Makefile  |  11 +
>   .../drm/amd/display/dc/link/link_dpms_v1.c    |  84 +++
>   .../drm/amd/display/dc/link/link_dpms_v1.h    |  29 ++
>   .../drm/amd/display/dc/link/link_dpms_v2.c    | 250 ++++++++-
>   .../drm/amd/display/dc/link/link_factory.c    |  90 +++-
>   .../link/protocols/link_edp_panel_control.c   |   6 +
>   .../drm/amd/display/dc/link/tx/link_tx_v1.c   |  55 ++
>   .../drm/amd/display/dc/link/tx/link_tx_v1.h   |  34 ++
>   .../drm/amd/display/dc/link/tx/link_tx_v2.c   |  83 +++
>   .../drm/amd/display/dc/link/tx/link_tx_v2.h   |  38 ++
>   .../dc/resource/dcn401/dcn401_resource.h      |   1 +
>   .../dc/resource/dcn42b/dcn42b_resource.c      |  82 ++-
>   .../dc/resource/dcn42b/dcn42b_resource.h      |   6 +
>   .../dc/resource/dcn60/dcn60_resource.c        |   4 +
>   .../dc/resource/dcn60/dcn60_resource.h        |   1 +
>   .../dcn60/dcn60_soc_and_ip_translator.c       |  15 +
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  12 +
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
>   .../drm/amd/display/dmub/src/dmub_dcn401.c    |  40 ++
>   .../drm/amd/display/dmub/src/dmub_dcn401.h    |  39 +-
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  37 ++
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |  36 +-
>   .../drm/amd/display/dmub/src/dmub_dcn42b.c    |   1 +
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |  38 ++
>   .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |  36 +-
>   69 files changed, 2331 insertions(+), 297 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v1.h
>   create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/link/tx/link_tx_v2.h
>

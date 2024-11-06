Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE330D59F52
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 17:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7458710E73D;
	Wed,  6 Nov 2024 17:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsbMRDMs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B3510E73D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 17:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe8A/S/vdXGyiTXMVR1q7lnqzoiPJcIihFxJsHX2mg+4FkjLLJbn7Khp2F08+o5x9TXc1Cp12POxy4Cc7zTaUzZ86iM4fF+mXuHzrIBlBfslziJ0mgID3JMNO3Sk69LYIXO/hGKnxdvuSPbI6b1qw6dPVjXkCzHQN0miXB2JC8rkpnxyW8GRFAbIGfnFx/G4lNB5bdbXVfthMqijnJw0+xPrbM+jxmrd92FmWtBn2XNb9amFJATLDtFzeqomqRurpunr63kNE9YbelX/O40jxqRE7wBviF+2WqamNPEqmJJBnUpkeVKkTg8Rd6DdrER6Z2ZMdxIhhdtIGQjovRlvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQQqtgi1hWWsJye+JYOAwtuvF0Pp1IElQiV5YU8p1To=;
 b=DG+6bwdBvM28qUWertZRbmALOAVbVtTbgcf9kiMzF4Zzniigc2JdNON9Sql5VIG0QIU3HgZ+6bxnZ/f8wRsW3/QLAOJjkNk2PcdFNU4wa2/ZpiLVcuWvJBNcyJaxVDL8YPheAtNtbN3ffDMt4Vjvv+OSvF3BWKZkXqqgNJ74kNnGrt5oTXF3c8LGIKXBN7xhvxPF0FjV3U3/mVWowfLd7pHFsf2BcT7tOPtfaOxMnCpwd2MJ+0MUgjRok8rkM2lTw3lD8p7rFoijYib6ZxamEIZIQAHPaOuzzCgcYbDBrVE9IQ2v+9tbDwlZGf40JryWyHg/BqIV5vGJ7ZfcvxbrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQQqtgi1hWWsJye+JYOAwtuvF0Pp1IElQiV5YU8p1To=;
 b=wsbMRDMszCdTDEq8eC9HxrtGgofWs7tjGz3ho7ZhDnjaGHNf1ghAndgZF9m8JpZvM80lZO2aIL/m4R6YU+UkRxd42EMxhSZlqp3mAYIuduYXira4wo8FLBMKrKrzgYcCpW9FQlcqnQnar7WW8OXCoJj9Y3owV0/LOfqGx0DPHGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Wed, 6 Nov
 2024 17:07:40 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%3]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 17:07:40 +0000
Message-ID: <7d6b833e-f5e9-4879-f7fd-ff65570c90b8@amd.com>
Date: Wed, 6 Nov 2024 12:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/configs: add VIRTIO configs to debug rock defconfig
Content-Language: en-US
From: Amber Lin <amber.lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Max Erenberg <Max.Erenberg@amd.com>
References: <20241106160810.156698-1-Amber.Lin@amd.com>
In-Reply-To: <20241106160810.156698-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ee98ba-d171-4c42-22da-08dcfe85851e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzhmWXZWV0E5YUlkK3VUN3B2LzNwWnUyRlk2a1ZBUG52N1VoUkV0QnRodXll?=
 =?utf-8?B?V1FEd1M0M2FpK2w3Wmt4Y09TWFBUcFhPOWZHMlZLWXQzbUQwZTk4cmZYVzVZ?=
 =?utf-8?B?SklqYmpjYU9iQ2RSeEZLVFFObGExOElaUDNiWnVaMFVrOVZMWVkyT2JJNm9M?=
 =?utf-8?B?R01FU2w1TWJrMmZLRGthb2VFZWpFZU5IQ0VlYlpjMGEyeUlwRytQaWxWQW1S?=
 =?utf-8?B?NnhqTUhueEQ3ejlxbml0RHh4VHE2ODZpbHhBSGFCT2R1YW4rVmZaYVpBTWd5?=
 =?utf-8?B?S01rekpyZStGNlh2THB3eXE4VzI2NVVsZHVlTGZQbUhyQkN4TGN2OFFiNHBa?=
 =?utf-8?B?YzI2WDdnZGdwYzEvRmIrdFdzNjFuUmZOYURtTnlNRWN5d0MwUUhyVnBtVmwz?=
 =?utf-8?B?dnlVZHQwMnFDK1ZlMUIzL29FVStnRG5GUVczWUpmTUVnQ01HdjNJSG4ranZp?=
 =?utf-8?B?K294NTV6V1Y2d3hDb0lGaXhuaSsxQ1Myek9KSjJVQUJLTTRwRmVYNjBYYWMz?=
 =?utf-8?B?M0kzRExGc01laEh3TE80cCsyd3ZTVnV2WnFSZEg0KzZQQkZPNmt2dmdRQ08v?=
 =?utf-8?B?b1I1RGltM0YxWWpWdU95WENFSEpvY0wybSt6Q1VuL1hNOUVUR3ZVRk81QzJQ?=
 =?utf-8?B?eDEvcVZ5RzlLN1dTazRxamdsbzRrKy9MSVl3blNsMk40dU9OcjJrcjBmc0tE?=
 =?utf-8?B?KzJGYk1xSkx5V2F0WWlxSW1qRG1iSUh6Q09tOXBXM0RHcEZmZDlnOG1za1FM?=
 =?utf-8?B?SXNLc2p4SlQwMVhjY2NTTzh2ckRsOTB1T1NvNTYwenVVUVM4MEZyQlR2TVlo?=
 =?utf-8?B?SkYwaXRhOVlLSjlEQmptZkFuOW5Ueld3eGt1VE8xZjZtZldpOUJRSi81YlZQ?=
 =?utf-8?B?WHZOZ2hFTURFZ0p6dFdPbng1VnlkTFZuZ3B5NDVYUkVYTG5pL054VW5HbzY2?=
 =?utf-8?B?VVN5TklNNGVXR3BFS0FNNm9yNmdScU5KbXY5dVBpTVNXQzBhY09LZWIvWFBM?=
 =?utf-8?B?QzdxMzJnaHlxUnd6OVpKbHU2cm94WkR3djR0L2dHcS9iYmU0WGQxRVR2WjZC?=
 =?utf-8?B?aWRsN01TbHptS0QweWdjTjJCZno5VmdlejQzaEpLUXlNcWg4YVBYYS81TUly?=
 =?utf-8?B?MnQwbXJNY3RadG1XcXVHOTZ1N0YvZzNHQVIrMFM5eGZGbTh6WGlYTUQybTFL?=
 =?utf-8?B?elNlSjZNenprZ1R1Mm9wZ05OemV3SEVkK0d0NDlob2thdHhwWm16ckNxemp2?=
 =?utf-8?B?d1lWbTZ2YmdrZklLSUlNMml6eSt1U0taQ3RQTHE3WHI0UENlcGtXSlZlenpV?=
 =?utf-8?B?OTRFSlc2eFF3R0ZVSzNmRnZraFp5YjRUajl2bGRCUFFNaC9sajJ1ek1jek1S?=
 =?utf-8?B?VTNSQXg3eUptaHdQa1RHTHNWMUdFSmRsUGZ4RHBsNjZ1UFA5Y3IwdG03VDBN?=
 =?utf-8?B?N2tjMmFxVGdkaTZSaWtvMitac1pGcng5S0M3VFJlTnV3clpCK2E3Yk1ZNUdl?=
 =?utf-8?B?V3M5d3ppTXpQV1JNYUxpUWtIc0c3K2NUSFJrT2tsakp0NzJESi9WRVV5dlY1?=
 =?utf-8?B?bTRxSEFmaFB2TGk2REw0M0Z3VEREV1p0WXl4djhiM2NhWUZhQS9TbjhYMFlr?=
 =?utf-8?B?MGNic2JFTE9xQWtueU85UDMyMm5JKzlGZFIxdzZlRzZiWWpNSkc5V2Y1d29R?=
 =?utf-8?B?bXV0NlRhSGUrWGQ3bGJPK3hlTXpIQndOaVJxS0lObHVsOGFxRGVjZEgvOU1O?=
 =?utf-8?Q?DryGd0h0GSQW4W6sXc9vgo21ds4Ibr+uCPMHDAk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTY2SENKd2VlRkh5akRRMzdNUkd6b1ZEb3NCQytpMmx5L0l2TlljYks4Smlv?=
 =?utf-8?B?TzlldlBOMjZnU05wcUJadWt1OFdrVGhISktHZnd1U2I4eTdrUDdtdU43ZVpV?=
 =?utf-8?B?ekk1ZTA3SndOSzVkaXd1di9nWGxOTXBjVE1lbTZtcmhjcWV4TEVoVFdxVmNE?=
 =?utf-8?B?bmVDMHNPS3hDaXg5S3lsYVV6RTBCVUE0ZS9wTVBwcW5FcWRpSmFVOS9uRnI2?=
 =?utf-8?B?MC90STJNZFQzNUJCNjlyNUQva0NNWGhWSElqQ3ZjR3NhQkVRWSs1SWxkajE0?=
 =?utf-8?B?OUwrRksxWk05U0hpbklFVDdZNHM3Si8wdG01OWsvc0VnQzIwZVFkY0Jnc2JS?=
 =?utf-8?B?VFJCM2RUTWJnQXpCUjVLc1lqSExpWkVkczIzVnRKaUV3cVMrOVJ1am5kK0t2?=
 =?utf-8?B?bXhmcC85SkU5djhBRHdGdHBjMGV1RVg0Q21NdU1Wb09RQlUzaGRwQlF3K201?=
 =?utf-8?B?dEh3K1ZyTi9zY2ZmNGhtRTJESXo2N2NMamphb05UbjdHUE5KU2ppeG1VbUhI?=
 =?utf-8?B?RnlpSy9lbUovRERaRFJXem5qTU9NSDBCejRtYldGSWZkQVQ2WityZmM1Tkox?=
 =?utf-8?B?UnNzSTd5WTMzNTRCOUlmaHpmeWRBRG14aC9SOFlDNnNXWTlCcHUrZnY1akRE?=
 =?utf-8?B?cmZJcVVZT1ptUmN1bXpPek02STdsekx2T0wvS2R0SUp4SHBNYWRDdUxzQzhS?=
 =?utf-8?B?emwvVGNOUjdlY2ZoNzlCVlNzcUpRNGJhVEY5THpFMjBHbTR0VHlUeitTMW9U?=
 =?utf-8?B?YmJqaC9hdUx6VXBOOG9xL2J1d1NSemlUY0w0N2ZJL3BldWJBMkZzVjVuTklx?=
 =?utf-8?B?eFF3dExvN1ZBNmM5djM5SjZEcHNIWlVJNmtMSjVsQ1Y4TWpCZkt2bTBtVGhX?=
 =?utf-8?B?M20rUUhsRTV1cTVtQkRtTUN6T1VBZHlGeWFkRlo3dkNMR2E4Q1BESUVIOUhp?=
 =?utf-8?B?RStsTW9PVUcvU3B0WVN0dHJvcjdlVG9FVFdVdmJnTHVZYk85YVNRSXgyNkNY?=
 =?utf-8?B?MWF2UW52aW1CN0JaaDJFWE9OSWEwZnQ1TzFyTTBTMjB0OVdIVHNrb0JIaFdF?=
 =?utf-8?B?OWgwSHpTdVBhK1ZDOXJTSXlub3lwMjZmTVhVTXhsYkhtWm1ibUxleWp2L0pE?=
 =?utf-8?B?STJRK2dDSTgzcEM2bHpqTkU5a3dDWDdwQjVkYVBYd3lWeG1ZdnJmMzF3SFlC?=
 =?utf-8?B?VzRUUDZveEZEWlBFTDdGbk5SSFJzRHY3cEtTUFMrZ1IvVS92azhvY2VETFVK?=
 =?utf-8?B?Sm9ZdTdPeXdNVFZRL2hjUE5xWHd1ZzBBeUM2ZW1DUW5TbVpJZFVnNG1SUHY3?=
 =?utf-8?B?ek81SWpadzQzcDROV0VabVdNUmlrUDFjTWI1SmZtbjFRTTBEeWRGdGlUdHk4?=
 =?utf-8?B?UDF3dmJvQzd6YzR0WjFKT09HMWpTTDlyWlI4bnduR0xKUHpTeXkwbExkSGRX?=
 =?utf-8?B?ZmlNVlZFcTZQVEVGWk4zSlpuTlJQSnI0WVU5ZER5NlZHNWdFVCtUbEx3YXBz?=
 =?utf-8?B?dzhZT1ZBUHF4WStnTDQvbnZLeWxzL29Mc1M3QjJFRTIwbzlSc0g2S2tIVVJD?=
 =?utf-8?B?VjRUeUkxY0wreHUzV3UrWU9RVVYwcmlpWkthSVJud05EVFRzUzUzOW90emhT?=
 =?utf-8?B?eU1lYWRaVWhPMWRuRG52bWgwTmpPTzB0cmtURHNPUFBEaWZBQ3VBZ1lDckhY?=
 =?utf-8?B?NG1lbkMyZDVGSVZ2YWdwaUdvVTZhb1dSeDZSWVp1c0hMaCtWVDcyOXp6dFRL?=
 =?utf-8?B?WWtvUkdIUEpCdFBQL3I5TGZOdW94KzNpb2RJV0NmYXZTcUJqS2FOOXBUTjVv?=
 =?utf-8?B?Zk1hWUlTVG9EdjBSRDlURjh6cXM1UWQ3Z0VTSnp0bkRVV083bzIrVFlyeDVZ?=
 =?utf-8?B?R2JNWk16S0hOYTBmMnZxVVMzOE5UREFpME5UTjdteEdIZmsrQXlZeTZDT2Ex?=
 =?utf-8?B?R2RaSHFhQkZjMnB1K2JDRFpCUnZqUHoxazdITStVa0lnTTlTeGJhSEt6d0Rr?=
 =?utf-8?B?dkMwMndKbUJJMVBQa2hraVZZaUU4UWk1QW9pQnRsRWZWZnJWUlpxUFJTL2tF?=
 =?utf-8?B?NmVzM2xYTFZGZFlKb3h1aHgyMHVZcTlBeG5zT0RSbG5CeDJuMzdnd0R1eTh6?=
 =?utf-8?Q?mkiEYAHvfBoxW8yU9aLURh0hC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ee98ba-d171-4c42-22da-08dcfe85851e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 17:07:39.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUpPvHMphG3t4zZZyMs17OMUD6FjiPTLHBT3rw6LAGxIFZx1nP+i//ki0Sp8scR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 2024-11-06 11:08, Amber Lin wrote:
> From: Max Erenberg <Max.Erenberg@amd.com>
> 
> These options are necessary to use virtio devices with QEMU.
> 
> Signed-off-by: Max Erenberg <Max.Erenberg@amd.com>
> ---
>   arch/x86/configs/rock-dbg_defconfig | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
> index 0ad80a8c8eab..565e447c6230 100644
> --- a/arch/x86/configs/rock-dbg_defconfig
> +++ b/arch/x86/configs/rock-dbg_defconfig
> @@ -353,6 +353,20 @@ CONFIG_NETCONSOLE=y
>   CONFIG_NETCONSOLE_DYNAMIC=y
>   CONFIG_TUN=y
>   CONFIG_VETH=y
> +CONFIG_VIRTIO=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_PCI_LIB=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_VIRTIO_MENU=y
> +CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
> +CONFIG_9P_FS=y
> +CONFIG_9P_FSCACHE=y
> +CONFIG_9P_FS_POSIX_ACL=y
> +CONFIG_9P_FS_SECURITY=y
> +CONFIG_VIRTIO_NET=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_DRM_VIRTIO_GPU=y
>   CONFIG_ALX=y
>   CONFIG_BNX2=y
>   CONFIG_TIGON3=y

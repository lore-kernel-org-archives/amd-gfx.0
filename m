Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62DFC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 14:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918A210E5C6;
	Tue, 13 May 2025 14:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBVbNnBN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6A610E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 14:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHf6IV46qHeUgJQpxxtxQYz2CybmouMFebcl7WbqS/4KUY8kh5oHx2BpNdIhxdEsfWACgFOuaHBWgFp2xaXxaeO86c482QiFpv9FKpxwfaPgxeoLRtysu2vK8B1DIGYuchNLynj0iyiK4DuoK9gSsHwAnbpgoIeOq+h871/oxE/Td5g5IIBygTmnDj3+EyXbo0xoH/oiwVB+xTixjkhyBquiktrFOpN8kidCoXkZSfI1ZwzGZ5hcrTM9YTZAzALWVrk1MPQqiVvYC8/kx6XTRGuWLHHpnp0tC9MRUuWJHY1QvzODxpYJiBpMvJWvMCqVj2bIN8V0U3f9NWdztahq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaig1M/Wi1UfPexDuugidvgkEv4HVDdKMBJ/1O7mbb0=;
 b=jgMMgN3luKzykuj++jM0xhEscz9b2ucssTQtHP3I3UC3vYA8D9QR82hg4rITJvT+UekcNLZ0eawgnoJ6QLn5byAzItC/8WrHJSR93hKRl8gIDfH5E3FT5OnaYXrwA1ft44Ei5sGI0R6sD7EyEA0IQDcV+h6kqGo0kfuaNwkLwTna7+XOTXcQXEZH1HhFOzVpLY9fYxklmoQq//U3fcFheGwEQ7+Cxrxccd2o7dNAPh726En3OQT1v03SqYS94ard2+ksAb6on1bc7RFyd/XFhz1b/nD3aQMqo936ElHFF/If75IzO6hJRDk1aXSVd39QweykwoNbXEnt+PK3WQHj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaig1M/Wi1UfPexDuugidvgkEv4HVDdKMBJ/1O7mbb0=;
 b=RBVbNnBNtCFx6l2Y5vhgZODAkoZXQkkFtfsQcDklefXjbSHZG4JWumgG3EiejRbXIK+rQHHDyi4v2DYBTlDjPOTPwIFtYqt08MGyJFpm58rdNnpe6RWxWilZe7LJwyV5nBnwYFYoo8WWXahEjq6waM7b5xzdPAZ+Lb4MNGZiH94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 14:26:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 14:26:27 +0000
Message-ID: <050dad75-0346-4c30-984c-333013a3e715@amd.com>
Date: Tue, 13 May 2025 19:56:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Use compatible NPS mode info
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 Amber.Lin@amd.com
References: <20250509113725.312103-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250509113725.312103-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5f7f5d-9077-4dc5-9987-08dd922a2534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elRYM1A2NlZMS0xacTNRVVpsRGpmNEhBWEJSSHM0NGZpSG1NelZDRVpoWVhV?=
 =?utf-8?B?bElMMllTcWUvR2xyVDBGdnpaazA2KzBTa3k1OXo5bCtwNlpxNm80b0hwMEsx?=
 =?utf-8?B?UDR3aC9yNkFQTUJDbzg0b084R0JnY2J5Q2ZoS25MMG1GOFo4aStGa3hmVkxN?=
 =?utf-8?B?Tm1uaW5OaUJyV0VpSFN3VXNvYmV1amZKSFl1ZUtBdzE3LzZXTmd4dEhGaWEr?=
 =?utf-8?B?V0lTSnlsb3ZPNlRaQ0hZbHhoTGpjMk9wdjg2b0dFbVl0NlVoT2JmOURvTW1h?=
 =?utf-8?B?QTZhbWpqWGVkSUxGYjAwWlY3cldhOVc2SjNtcEQ4ZjFDK3dNT3A5RHZwYVNT?=
 =?utf-8?B?WXVUQktmTFFJK2pHcmwrd2pWQ1ZsVjVUOTJsMTdRN25hQXByalA2WGxVVGlj?=
 =?utf-8?B?eGdXS0lIYnBhRjFHK1E2TW55cWxvYlJaQzRRUCs5eDNNOEtqVXAyWFg4b1k4?=
 =?utf-8?B?ZnJIUjg5K0l3S3NVaUZXaFRVdGdqRHpYMGNRcUF4MXEvU0FUSkFlYWx3VXRj?=
 =?utf-8?B?UnlyUDBtdGpDNm91WStEU01NbG9kNElqcmdrZXVkTTV5MVA3cm0wVzhBdTdu?=
 =?utf-8?B?ZUQyT1dHWUYyZnFNNVpnRndFUjQvYllDVm5QcjEwcFUwR2E2YTBkM0tubFZi?=
 =?utf-8?B?SHZSeWlHK1Iza1pvZUprSURReVVlME4rODlqeTBSbE1taG42YncvQ0RMSFVB?=
 =?utf-8?B?OWFRMWxvQkgzUEdZQWh6d1cyQUdQcXF4SjNTbFcyOUdXL3pqWGIzU2FZRThJ?=
 =?utf-8?B?MjRSSTlqVkhGR0ZNalphNHBOQXlpV25taXNINDZ6blFWblpad25VN3FYZGtz?=
 =?utf-8?B?bTNCMkRUU3JGVDBOUURKRGtTWWRqOWlvbWQ3bDZsSHFoVTI3YVpNZm1SRGVk?=
 =?utf-8?B?Yjh2bGkvdmR0dmJFN2diV2orM3c4aVVNaHZDMndrTXpqNFBhLzFJOGJmTm53?=
 =?utf-8?B?YWhUQ1Npdy9MQ2U5L28rZ1h4aS9odENGOVliT0tuQkJpOVo4cTBWUTlwQ2hj?=
 =?utf-8?B?aGsvR0EycUx2cDFqZ0wzMG1nS1FCWm1GcHgvdjA2WmIxUjE1bi9jcE1tY1lG?=
 =?utf-8?B?NVc2N01ITjd3MlVUWnhiT1lVWFVlb083dCtYanl0MEtWUlh1am9MenpKYTh0?=
 =?utf-8?B?NHZiaDQrZ2Z4UkNoYmp0ZXdWd2xrS2ZrVkF0L2tnUjhmeDFObU1JMEJIZys2?=
 =?utf-8?B?N2doR1lycUluOUMrVHV3VHBVSThCWnVrVHUwdGdGLzVHSWpqRHMvbWpnYmlF?=
 =?utf-8?B?ejZxLzlvNUlwUGhCcm9CRHVQZDFnVWNjZjdOUUc5Ly9sOEtCTTN4MGEwN0R6?=
 =?utf-8?B?cFZOVWlpRTZSM0NBK2NLbU1sT09acmdiOFhldktQRjZ1Y0V3LzZ0Q1pKVjVT?=
 =?utf-8?B?MmhXd01iVzlRa253R2loVFZKV3UybXRTL0Y5WFZtTldRWEduWm1MWVk1VHBx?=
 =?utf-8?B?WE5XcmxnK3pWbnFuRDhaWWZEYUJoVU81S25FY0RzT1M4N1dwdDdmb1R3cnZH?=
 =?utf-8?B?OEpHZStGU3dvVFd5N01MRWx0TGtKS2xEU3A3OTBwV0RrSCt5K1FVUHpwSmFF?=
 =?utf-8?B?UzBmMGlIVTZwZ2Rib2V6ZzhrZjgrUFkzK3ZEZC9JYnFCZnZGN1pqNStwYktL?=
 =?utf-8?B?UjJmZGhhNHJuTmFHSVhqUmh3RnlvMXh4UmJXb2VxTFJram15WFNJaU42SXpy?=
 =?utf-8?B?SW8zSTQyb0FtaE1xWUE5V05OdHVlYnBlYW9BcklsMHNDVGJNa0cxYVcwZlY4?=
 =?utf-8?B?NkNManhGVzE2WFJRN1BieWdoR3ZMOHhEMWM1UEJOekM2QWdaV1NXbkFKUGJr?=
 =?utf-8?B?cElaSE5hSkJ6eHh5MGswUjBGNk1FRWkwd0pVUU15VXR4TnEvclk5eExFUjI4?=
 =?utf-8?B?SjdWakVqclVpclBZejJndjRFQzRiRmdtZG0zbnI5dnF0WXZDdjBjb2ZnUFkv?=
 =?utf-8?Q?+zrImmQ3kUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dwVDF0djRyUmxPQ2JPdzNlMWdXY01GM01MdHh6U1U0K25ycGdlb3BRajR5?=
 =?utf-8?B?N2J3WHc4Sm5XSnVjUThxL09DYkh4ZlRUZTBkbzc1YmRwYWY3RGp6WHVPeW1y?=
 =?utf-8?B?N295ZzZ2MTc2bjcyNjdhb3phTGJuR1VLVFVoWEp5UXZkZ3hWNHFHSGRzT096?=
 =?utf-8?B?akxCME05cXptQTh6Y2JmT1FSYng2UGxXaDdCekx0WUVzS2o1UVBIaHVsWkRi?=
 =?utf-8?B?Z1VXY3UvbVdDVkNKc2lqVjFDZGdLRGNtMzdhNTJFcG1WcFFOZFlocHpzUVVN?=
 =?utf-8?B?aEdJVkdDN29ZOUdsdUNRMTVjYnBhME5JTmVKWDVFcjZIbkpjTWNTblZkSlhl?=
 =?utf-8?B?RVNpVGpOVVI0QlNxV05zWFpXNkROb3owbDVJenV5U3lLSmdKazJUTURGa0NO?=
 =?utf-8?B?TG9Qa0RoTnByR3VhN1NocEtqZWNLK05KK1RyOW9JSUNDS1VqdXcxdzVXd0pn?=
 =?utf-8?B?a0tpRGE2cGZGNjNqZFY0NVhWNzY4YVAxK0U4OVJjdnRCbzhKbUFleUNRakQ2?=
 =?utf-8?B?OHBtMzB1OElZenhOdEc1TzdTcm9VMEovU0ZJUVV5S1NKaDA3eHNnbG55Uitz?=
 =?utf-8?B?dkdGd3h4QWpua0I0NUpvclpGdFFWTjdmSE5ENytUeTNCRDBUSk1mZ2hjMTla?=
 =?utf-8?B?TzhiZmdieGRtdnBNZmJCa2gzeXNMaEF2b2tUVjBtSXFKWUNpc0M3QlBBRmhU?=
 =?utf-8?B?OFl3Y0RsUlJhQTlFMlltRXBZcVhscnJwTUVUZllFdCtnMlNmYW9rOFNQOEtq?=
 =?utf-8?B?VzdZNGRMNHQzVWdBQUR5Q0pWYi85SG84NXRrcjFiYUlTQmsySnVCT0V1Wndi?=
 =?utf-8?B?RHZwQ0IrNUNMSE02dFV2VFQ3R1d6alp1QlJMYzNadEVBbWlSa3hvTFZONTh3?=
 =?utf-8?B?Y3FYaDYxUkp5VHloOXVUV0ZjbXhER1pTL2o2WTZrbytQR2xiS3NqWWtlTnYw?=
 =?utf-8?B?OWYzSUs3SU4wY0REVi9BK0x0aWJncEVZVGF0TUxUN1RPeU92TCtvQW4zSmV3?=
 =?utf-8?B?Tk9ZZjBNbkFCVGcyZ1pHSHg1b29STkRnWCtiNy9QbllXNHRydUtpTG11OHhN?=
 =?utf-8?B?ZFZjVExlODltMzVDTExkVXU5V0NITFZkYjRVclFuSjgyUkoySm1QSkdSQlV1?=
 =?utf-8?B?U3VZYmJVeVovdVVkbTZ1d1ZEYThmbW5MVU5nUXlLdFNxY3h4WTJkSTIydndL?=
 =?utf-8?B?UWdFWTJTZTBEUXlyeWdaTUM2WjZLRWswc0VVTXB2bU1DdDJKK05FTU81S3hC?=
 =?utf-8?B?ZzdrZUJRU1UyVURhd05IcUIwUHkyNkx5V21sODRCTnRNQ1kvZ3lSaFA1T0pn?=
 =?utf-8?B?aGhNVVN1dzk5c0VDSFdDa1RmQkQxcTZLMFMvVkJzOEY2U0xoSzZxb3dobjF3?=
 =?utf-8?B?TWtDRkdRRFJINlNrOW8rSzhSSjBoRmptSDUxT1Y2US84Ny9pNXRHZCtDUEFw?=
 =?utf-8?B?NUdWT3pmU1NKQS9zNzRjUVRxWnVEZXRkaDJSSTh2WWVkaXVNZk0rQk0wOWJk?=
 =?utf-8?B?LzRBc2dvSlQ2aFJ3N2FpZGF1b1N4Vm1QVys3bVRYaVZRUjBlbkoxS2JKby9J?=
 =?utf-8?B?RlR0RENFYmI3QUdxc1VpVXdTbDdNeDIwL3hRSDh2UDZDeHI0ZUx6Ym0wa2la?=
 =?utf-8?B?YnozdG9uaGV2SkFYcjNIOEhvUTRIbG43U042UWVEb2xHM1VDazRPSWRnR3Nj?=
 =?utf-8?B?dUV0NHhQazhzM2NBVGV3ZHdjcTFQYmI3bFB0SjVlY2tOWE5VSkFUSUJXZWh5?=
 =?utf-8?B?RzJJcWYxbnNqM205VHlXMWlwMmxiMXB4d1d2MDJJalk4Y0RDLzdDMWpaMXJM?=
 =?utf-8?B?NEc0YnlMaG9mcW9Fa0ZzZlVqSVJlakhGVmlJUFk3NGRsZ3g1TnZ0c0xIUnVB?=
 =?utf-8?B?L2JkTW9iMEFhcTJ0eDBSdU8vdkRybzdoWkM4RW10Nm1MWHJSRGtGSkNHYVg1?=
 =?utf-8?B?U2VYTzBtQm5PNlFpK3ZIQXN0dHM2OHR1ZkxpRGRYMFhzbjlDSHcvS3BLRDd6?=
 =?utf-8?B?R2FrUFhsZVZBRVM0L3dudWF1Zy80aFFhMEI4anZoanRkKy9zQmVQRVVaeG1J?=
 =?utf-8?B?dnVKa2lOTXBmREdQc2lmZFZibmtzRDZnNVdTN3NuMWQzNkVzOFJobmdYdFVW?=
 =?utf-8?Q?Wue+qSYM2742yusTlFISJ6wEU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5f7f5d-9077-4dc5-9987-08dd922a2534
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 14:26:27.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTiQX6a3Spf/sKcMfP7y0sPt4MfoE9mk/6UsxC2e8h8XXgWQVMY2RUBVM3OvSFxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
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

<Ping>

On 5/9/2025 5:07 PM, Lijo Lazar wrote:
> Compatible NPS modes for a partition mode are exposed through xcp_config
> interface. To determine if a compute partition mode is valid, check if
> the current NPS mode is part of compatible NPS modes.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 103 ++++++++++++---------
>  1 file changed, 60 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index ae071985f26e..d4bd24e3c390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -448,53 +448,69 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
>  	return 0;
>  }
>  
> -static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
> -					  int mode,
> -					  struct amdgpu_xcp_cfg *xcp_cfg)
> +static int __aqua_vanjaram_get_px_mode_info(struct amdgpu_xcp_mgr *xcp_mgr,
> +					    int px_mode, int *num_xcp,
> +					    uint16_t *nps_modes)
>  {
>  	struct amdgpu_device *adev = xcp_mgr->adev;
> -	int max_res[AMDGPU_XCP_RES_MAX] = {};
> -	bool res_lt_xcp;
> -	int num_xcp, i;
> -	u16 nps_modes;
>  
> -	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
> +	if (!num_xcp || !nps_modes || !(xcp_mgr->supp_xcp_modes & BIT(px_mode)))
>  		return -EINVAL;
>  
> -	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
> -	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
> -	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
> -	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
> -
> -	switch (mode) {
> +	switch (px_mode) {
>  	case AMDGPU_SPX_PARTITION_MODE:
> -		num_xcp = 1;
> -		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
> +		*num_xcp = 1;
> +		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
>  		break;
>  	case AMDGPU_DPX_PARTITION_MODE:
> -		num_xcp = 2;
> -		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> -			    BIT(AMDGPU_NPS2_PARTITION_MODE);
> +		*num_xcp = 2;
> +		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +			     BIT(AMDGPU_NPS2_PARTITION_MODE);
>  		break;
>  	case AMDGPU_TPX_PARTITION_MODE:
> -		num_xcp = 3;
> -		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> -			    BIT(AMDGPU_NPS4_PARTITION_MODE);
> +		*num_xcp = 3;
> +		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +			     BIT(AMDGPU_NPS4_PARTITION_MODE);
>  		break;
>  	case AMDGPU_QPX_PARTITION_MODE:
> -		num_xcp = 4;
> -		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> -			    BIT(AMDGPU_NPS4_PARTITION_MODE);
> +		*num_xcp = 4;
> +		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +			     BIT(AMDGPU_NPS4_PARTITION_MODE);
>  		break;
>  	case AMDGPU_CPX_PARTITION_MODE:
> -		num_xcp = NUM_XCC(adev->gfx.xcc_mask);
> -		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> -			    BIT(AMDGPU_NPS4_PARTITION_MODE);
> +		*num_xcp = NUM_XCC(adev->gfx.xcc_mask);
> +		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
> +			     BIT(AMDGPU_NPS4_PARTITION_MODE);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
> +					  int mode,
> +					  struct amdgpu_xcp_cfg *xcp_cfg)
> +{
> +	struct amdgpu_device *adev = xcp_mgr->adev;
> +	int max_res[AMDGPU_XCP_RES_MAX] = {};
> +	bool res_lt_xcp;
> +	int num_xcp, i, r;
> +	u16 nps_modes;
> +
> +	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
> +		return -EINVAL;
> +
> +	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
> +	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
> +	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
> +	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
> +
> +	r = __aqua_vanjaram_get_px_mode_info(xcp_mgr, mode, &num_xcp, &nps_modes);
> +	if (r)
> +		return r;
> +
>  	xcp_cfg->compatible_nps_modes =
>  		(adev->gmc.supported_nps_modes & nps_modes);
>  	xcp_cfg->num_res = ARRAY_SIZE(max_res);
> @@ -543,30 +559,31 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>  					  enum amdgpu_gfx_partition mode)
>  {
>  	struct amdgpu_device *adev = xcp_mgr->adev;
> -	int num_xcc, num_xccs_per_xcp;
> +	int num_xcc, num_xccs_per_xcp, r;
> +	int num_xcp, nps_mode;
> +	u16 supp_nps_modes;
> +	bool comp_mode;
> +
> +	nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
> +	r = __aqua_vanjaram_get_px_mode_info(xcp_mgr, mode, &num_xcp,
> +					       &supp_nps_modes);
> +	if (r)
> +		return false;
>  
> +	comp_mode = !!(BIT(nps_mode) & supp_nps_modes);
>  	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>  	switch (mode) {
>  	case AMDGPU_SPX_PARTITION_MODE:
> -		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
> +		return comp_mode && num_xcc > 0;
>  	case AMDGPU_DPX_PARTITION_MODE:
> -		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 4) == 0;
> +		return comp_mode && (num_xcc % 4) == 0;
>  	case AMDGPU_TPX_PARTITION_MODE:
> -		return (adev->gmc.num_mem_partitions == 1 ||
> -			adev->gmc.num_mem_partitions == 3) &&
> -		       ((num_xcc % 3) == 0);
> +		return comp_mode && ((num_xcc % 3) == 0);
>  	case AMDGPU_QPX_PARTITION_MODE:
>  		num_xccs_per_xcp = num_xcc / 4;
> -		return (adev->gmc.num_mem_partitions == 1 ||
> -			adev->gmc.num_mem_partitions == 4) &&
> -		       (num_xccs_per_xcp >= 2);
> +		return comp_mode && (num_xccs_per_xcp >= 2);
>  	case AMDGPU_CPX_PARTITION_MODE:
> -		/* (num_xcc > 1) because 1 XCC is considered SPX, not CPX.
> -		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
> -		 * num_compute_partitions can't be less than num_mem_partitions
> -		 */
> -		return ((num_xcc > 1) &&
> -		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
> +		return comp_mode && (num_xcc > 1);
>  	default:
>  		return false;
>  	}


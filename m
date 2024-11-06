Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEE7D29FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 23:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935B810E1B0;
	Wed,  6 Nov 2024 23:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKqCeDQo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BC210E1B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 23:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Boyc/PZdK9ARn2BTzt0rNKUm9OP05mE1TzCJAvWE6EZxV9ZYkBxBirHv7RErMJo/n/JkgVyN5bmJdy0PS+r2QP/aUFefJPWC+U6igmuImE1DkfPG0Y/Zg5cLIcytgNUXOeN6RttuHBRUieAuvSCO277eAv1n5RVaWhsU1PGIr/DkrkE6ik6Wsb5lxZyp1GHRHjXJN90FlXnOfTpR/6BQxdJrYj2kSpG/6lb1IIIN/5NQWmWf0UlfEjtAMIaKE9p2iTsBsIBxSV7k6hc8zAQjrXVjoDDLdUVk6eaOJTnZ6nD4hDIeuN7sBgvapRZKuY7r7fofSnDZ4S2vbkhImCgV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsOO9NMgzfrqE8SsXPggto3Dph2Qa7k9vpbq0PTBfo8=;
 b=u4KzuFT0QKeJL47+YaK7F5uaSTa5LzVooq50s896zsXGaz5npWGY+Vu7fU+sKkHPEIDCnThJg69O8RQ2vILoIhxgo/skgc3GkDMzNyj3i31XAPN8p+uycTEKlOZjqO5guLaPE9CBridzHcwycLlJKrx4j1i/par/Dyp2GSaGQulsso3lVfs4zEYDrH5W2hputaNdkvZxeGidIEk50IjKIVD5XrqwTsT/rcVdWp+dQj1LWT//dYYp9NEbbI/+aoOdkbNYSkHgRQt+0R8OkhYrkyNSUgPrg0fnH780f7gkbXQAB0GaF7y42JDxemxvJL1ZhC/uRhbDa3J0D3qp8Sc1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsOO9NMgzfrqE8SsXPggto3Dph2Qa7k9vpbq0PTBfo8=;
 b=QKqCeDQoz6J58mvxvfnQ2inFY6R5Xs1koBWU5XRLoPHAWs6pRpUho/S6Er2W5VAE8mXZlXoiIrwtrbnpvPJwkTh+UsoABombZCBjua8eyaq3RtLBqPx0K++nldsbn/SPWkj/4Gtt1xzYGVVucDAq37menukuGNbypWmm3Grl9Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 23:27:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 23:27:01 +0000
Message-ID: <0150ce95-709a-4a25-a376-c82b2b312ca4@amd.com>
Date: Wed, 6 Nov 2024 18:26:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Inform if PCIe based P2P links are not
 available
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241106225429.347179-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241106225429.347179-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0201.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 83551df2-7b1d-4267-57f9-08dcfeba843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnhJcGcvWXF0djRYUmUyOC9wOTRnNHd0bmlLWmJVUkhhdWRYYW1nZlFNSzVn?=
 =?utf-8?B?TG4vbWlGS0Y2OGY1dDFTS3VNbkIxYjJ6SXQ2c3M1S2FQY2xOeTdWeVJVRVZZ?=
 =?utf-8?B?MUhXL1l0bVhPcXBUdUl5bHdickVWajdZaHkzamtyUTBDb0lkVGYrQk4ydDlY?=
 =?utf-8?B?bmQ0ZEJlKzNVVkRmdE5mOFE4U05tY3dkVWlaMjdEbndZYlZmcnJpMlArMVJ3?=
 =?utf-8?B?OWg2VFo5aERCT08zS3hEQU81clJlY2FLb0l6UU5ERXlKN1lKclFnemdmbDA1?=
 =?utf-8?B?VVp6MDhudmU2UkxPNHZ1cFNlNTBDZzlZd1ZpT1J1Y2Q2MVBhQ2NTMGZwVVNz?=
 =?utf-8?B?QytMSnFhSEZVRCtnWXVJcEhEdTkwVENzREtCdWdnTXhtU25BNFhQU1UwOG5r?=
 =?utf-8?B?cG1XRjV2RERwNVpwSzE4L2RVUFgvOGd0R3gxemxCWk5qbHBIcUlIcUhhbStT?=
 =?utf-8?B?ZDg3U2lWZGh4MTQzdU81cmx5bEtnczRwSEFJT3laSCtmc2NBd0daajJOdDZ1?=
 =?utf-8?B?bnBWV296ZDM2cnNJNyt2djlFWGRKR3ltUENCQXdLUWNtT21odUVzQjUvNnRY?=
 =?utf-8?B?WHluUHJ2MWxDUlFKM25vTjJSK1lEQXJGV3c2WUpYNU5uMjJZVFJtRSsvS3VK?=
 =?utf-8?B?NFk2QUlZT3R5M3g0Mjd2NW5pQ043SmgxYXdrdG5SdU1sVzBOamUyLy94Y25X?=
 =?utf-8?B?VW4rMm82dWJiTC9ObERkcG5jK0VjdjAvMGpQTU1Zd2hyTWlUczk4ZGc5enJ3?=
 =?utf-8?B?d1dldDJQR2Y2THhZRS9OdVhMUEZmTDJhY1d2cGx1RTFxQUFzN05PM1lOSVlN?=
 =?utf-8?B?RUlVZ2c0YzMydG9sMTFZQlRRb0ZBUGZLVS94MVlJZzZQQnhGdCsxWWxBby9D?=
 =?utf-8?B?VURHZjBMemsvcktaZVk4Z0xzVUd4VGJHUk11SGpPSFBnMlBvNU0rTlM5YzE5?=
 =?utf-8?B?NTUzNjc4RVo5QUJwSEc1anVnc0JvbjZYSjFudlIyYTJQeDN2R0pIZ0pFSGdD?=
 =?utf-8?B?VUlQT1ZMZHVxdzR6VFc5amUwNEttYnJFbC9NM1ArUkx6TzdzV0ttUmI2RXNX?=
 =?utf-8?B?YXBDQkpxSVBzdWRsTEpwZlE5aXY3dmNJRGNRa0JtT1dLZTJGVndRMjRIOCs5?=
 =?utf-8?B?NUZ3NE8zaC9Cd3ozUVhZVE0vMC9BenBDSENLem5IYUVRZURERnFWTWxVeU9I?=
 =?utf-8?B?SmQwUGNjWlZSa1VpZWlKZEdWdjhIQkFHOFhyWUIxaUNVNU5CTlBqb1RaOWNi?=
 =?utf-8?B?aUp5eXI0Ry9XMVBHbGg5RGZFK3QrYW5mSTd1NFllQXhISW02ZnFNV0VNWEdS?=
 =?utf-8?B?ZXVLMndIQUNxeEE4cGRDb0FNdDlsOWhGREUwTUpMNENpTGNkN3V6UjhWdG5n?=
 =?utf-8?B?VVJ3anFXZk02TDF3dy9LNzdGTlpjQWVNSSs3aWs5YXVMYUQvaCtvNk9SUDZR?=
 =?utf-8?B?N2kxbHk5Y1dLQXI3cTNkVTVCa01ZUXMrVS9MaVhHZllFbUhTc2pqNnJ2TjE5?=
 =?utf-8?B?eDhtbVhENTYydHU0dUFpNWVMQ0tzL05uZGdWUnFNYjE5OW1yOXBhc3djc3pm?=
 =?utf-8?B?TFhORGtVU29TNERabkllclhLV3FpTGFTdlF3QXhXQXo3K0ozQ3RMSWUzcmpT?=
 =?utf-8?B?eVhUUFFDa2lZZTBGTWFqMzN4VDdYNFBpd29hTktJcllpSzlUb0JnZTVxb2xk?=
 =?utf-8?B?bU1vS2dMSUEzNTJwc3pqMkl2ZUVqYVBnRmdObDV6Z1Ayd3pGZFZUVzl0VDJF?=
 =?utf-8?Q?odHuDr6k9pPXOWZGWM+GqWU/emZw/eKpeGVfQXX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VkclJncXc5Qko4TmJ2djA4VlVqZVRua0xJcUw1ZVVtSFJVRjR5VUxMcGtq?=
 =?utf-8?B?d3hQOW01WCtrcU55WUE1VlBWeEFFck9JMWJyM2hFQUtobkJBU0lkWmV5UnV0?=
 =?utf-8?B?VER3Z1Fvb3V1Q3RYWXM3ZXJDRWdSa0FJaTNONWlCM0JVSFdtNEE0djBwcUw0?=
 =?utf-8?B?VXkyTllvbFhNNUNwV1M1Y1N0QWROSytMWGRMMVhJc2xNaEFBeXhmb0RmR3dR?=
 =?utf-8?B?dDVlWUFhN1VFNmZwaVREWXI4UE9rMU5kR01WMlpReXRKakF0dEk0bHpMTSt5?=
 =?utf-8?B?MDc5ZUo0akJkODlHUm9LUkMzcHJZTHRva2VQWkdYZlVNNUd4MGVocWFlRWg5?=
 =?utf-8?B?SFJCL2ZSRWxxSEtFMVpKNlEwQ1ZORzIwVG0yVVRMeStSdWlubnY0UzF5ZTVR?=
 =?utf-8?B?NTRaNWRVL05IMEFpOUNkOHR1YXZlclhLbVFpdlozKzRBNEd6QlpUNzNQOWFC?=
 =?utf-8?B?aE52SG0wUkpMcFJSSDErYTA1bjFKS0pTdURGMjZqZDJlR2J4d2h4aTY4ZEpn?=
 =?utf-8?B?eWNrSUxKbjlDeUI0ZHk1cG1MSTNiWlg5VmZ4ZWlvbm5JME9DRmYrWGkwdWMy?=
 =?utf-8?B?U2IyNjhIM3dPdUljeEt6YlBrVnRxdmdMRmJrTlZ6TnJvZGxHdkF6MXNFRjN2?=
 =?utf-8?B?aVZHS2ZtQkpQbDluajFhZVZzUWtIbmVLcVR4UHBDcloyMkFJVlFnRlgrSHpC?=
 =?utf-8?B?TjRLc29pSUEwbTROMThndE9VeFBDQlJIT2ZLYngySnhKN2FnM0NnQzk1bm1u?=
 =?utf-8?B?ME0zWlZCRmRvYk03NEpYT1RGL0tTUHM4cVJTZTNJeXpSSWNFdjIrVEtVdjAy?=
 =?utf-8?B?RzE5MHQ2WjFuM3NueWo5UHQrS2pvcTNHcStsajU0eGV0eXVKSzNLU1FUdU10?=
 =?utf-8?B?TjlGWTc1RTloekdLQytYZEcraDdjRUxlVzdJVXNzSUIySnhrWkk0M1JMdnJq?=
 =?utf-8?B?bzZ3SzFwKzZXTGIyTVM0MS9iUzRPQXpjcTRQMzFMZkNPS0FzbUUwU0JPN2Fu?=
 =?utf-8?B?RVhZdVFaVmdSamJTcHVIdUhQN1Z4ZzE0ekYzL0dEYnVFWmlFZk5yWm9SUUhx?=
 =?utf-8?B?cjNQekRhaERBMkN0U2xpWnpOTCsxc01qYmYrMVlVQnk4Nmlha3U4QTdobDcv?=
 =?utf-8?B?cy9nbFgydW53WWNHRTlnRWZWVFlWZmNPei9PbUpKYkJJM3p5bnY2MlZiVG53?=
 =?utf-8?B?ODk3dUNGVkszQVNBcEpmVDFEUjlEZFZiYXRNNEl3UzkvaWJLOXJ0MnVEZWxN?=
 =?utf-8?B?bFllMXFjeldoeHhyaWp2Qm82SnY5eS9xZlI5R1A1bEdZWjZ0R0owMG0ySy9L?=
 =?utf-8?B?QTViL1laQmY0ejA2YTdXNk00Nzg2UHVJTWJkU3VudE1pUElMN0NvTVhmbSt6?=
 =?utf-8?B?Rld0ajJBNk40ckFoT3VMZlk0Q3NUa080NWphVGNaK2l1dVRhRG93ZzY0WXRH?=
 =?utf-8?B?TWplelRESUhzWnZvWnA0SUgzaldzWENIWUVWRTEvMzc3MTc3M3pZY0hlT3cz?=
 =?utf-8?B?WEdYRGxHQ0U3VVFOSVNKOUN2c2xmc25ucXNIcjNOcHozRmhBRkdTR3ZQYXgw?=
 =?utf-8?B?RXFGNkNXN0h5dTNqcHVKeGQ5TkIrRmtrTmJPbWR1aE13ZzNrajI2V2FTc3lh?=
 =?utf-8?B?dzlka0lWSFBLVHZSVEtsMERIWWV6QlV1V2trd2ZIV0NYZDJRdnI4RlJNQkRZ?=
 =?utf-8?B?dHFCTmZUV01GajhjSjlYNjk5eFM4UzZGZFpHUnFWVmFPOHNEZnFJT2dQVHBU?=
 =?utf-8?B?N2loZGxsUFBFbzhqQ0hzL1F6TzZwNytYLzRrRndNZThaTkVLekZLSmFxN1Fr?=
 =?utf-8?B?TTJlcjFjZWx3N1h5d2pSem9SZlo1bWlDVXphZWdPdnU1ellmb2lVcWlwVCtt?=
 =?utf-8?B?V1NLcU1KdE1Ca29Uai9wQVJER1pETTYwcGxvVXRJbW9GcGJ6dHcvQUxxNFZL?=
 =?utf-8?B?ZzhhcGI0SExjKy8rRzF0VkFFVUFFRUdtZDFNekRtY0hEUlN5OFlGcFh4OTNP?=
 =?utf-8?B?RVVja0dKdkZMSnFEeU5ZWHJmSU5VbkVwa2RWMG14NC8wMmRIR09JQVZuNTJI?=
 =?utf-8?B?TEF2cFltMVZkOEhHTkRVNEZ3Z3g4VkZVUEdzRnhsbXJHZmVLMlBDdGptM0Fu?=
 =?utf-8?Q?zHZdCT2D/oEVXUPXt8T19Zvig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83551df2-7b1d-4267-57f9-08dcfeba843f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 23:27:01.7530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUDqy89nzHYrhtZPqljvIvtaDnoHfz540zgMjis5UxJskbwNAeNPyHVXzEo+RwnabT5mM9SZkdNHqb4WQY+tog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
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

On 2024-11-06 17:54, Ramesh Errabolu wrote:
> Raise an info message in kernel log if PCIe root complex
> determines that a AMD GPU device D<i> cannot have P2P
> communication with another AMD GPU device D<j>
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 230c24638a34..76182d5c719d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6222,6 +6222,9 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  	bool p2p_access =
>  		!adev->gmc.xgmi.connected_to_cpu &&
>  		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
> +	if (!p2p_access)
> +		dev_info(adev->dev, "has no link with Peer device: %s\n",
> +			pci_name(peer_adev->pdev));

Please clarify the message to say "PCIe P2P access from peer device %s is not supported by the chipset". And "peer" should not be capitalized. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

>  
>  	bool is_large_bar = adev->gmc.visible_vram_size &&
>  		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EADC531DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 03:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA62110E3B1;
	Thu, 15 Aug 2024 03:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQGG/T1l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C9710E3B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 03:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCTfzuIXaOVzL/OiOOBEfFhpDux2WycIbkMTwkeHEgr5JJRgX7sMD3Qz9kI9Z/0VM8q/2KJ21WCr0+MEj/nrojO2Lx6fqWPFzPZ4PSEwfaEa4PX5HVJ+7EYf/Q53pI5ht46+e5UhKHJCRkzEfZ872JjV2LrvHvMhmTKnSxPcFybgEhfF8f+PP9F3euwmDYm4HqQDZgjT/uMVwZj9DrZ8ZcdVVlfsHCQSjkhNq2wJ/EBQK/sWFp9yo3VysYn4aox7jF9z+jyhaiP+fTfRXfAHeidn80REOPyyqWhzjxZN3c7l5J60PJWVQKlxsL+BK3D3ix0q/ZbL8U7lf37mMdG0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGLzlk7qMQKpStwjFNco4ZbsY0Gd5Se/70MCoYZk0FU=;
 b=tmX/YL2IWC0DJYeKXU3KzUMubmryqgJRQv8qKWEjSrK4VUyga8b4uLJxu2yhfbry7OWPUTNHxnnesPDK+Mosa8E9DClGD/RjXO5DUDFiptFNzJKdv6wFncOnyfULy3IC3koFzqK/E60ockjz6Ju88pU9hslYJYTumvgZv1h/DSnJaKwjv17aqXeKUEWHE4VxWVGQuLjK/NA7+Cs7auzx3QeggqHs/dd8urZdcAnRI8Ke4yjpN5gy8Wc9/cERx9FYCy9RtTk0miMDkNFntDia6t5pVPwM5Dmn+SjmKCJvrb+5lg3Nngk0THi2K3uQdaEj5JLd0Zv+rc8vZr7GjwZisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGLzlk7qMQKpStwjFNco4ZbsY0Gd5Se/70MCoYZk0FU=;
 b=ZQGG/T1lVoN7etCXg+EoHfKhGWQplH3HQPvUurY5+R96aRPyDdMunpmMWhcRMv7dqccwdxSzaGxyiJ3pM8WFZ68ihnQ4NjdikoFfS5VpqkNnLmQG5NzhbIF3S/2EtQc++kMNHT3A+K6MEldmgEbe+81BjFlJjrjAMZpHOcEX7r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 03:00:49 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.7849.023; Thu, 15 Aug 2024
 03:00:49 +0000
Message-ID: <33fea212-d094-41b4-96b1-779861880453@amd.com>
Date: Thu, 15 Aug 2024 08:30:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] drm/amdgpu: handle enforce isolation on non-0 gfxhub
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
 <20240815000501.1845226-2-alexander.deucher@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240815000501.1845226-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed7f5d-8fee-4427-daf7-08dcbcd67776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm9XWUlLNWNkYnliMXVyK0VBbHhvaVlZeGp1bzF5WEk2cW0xVjFIYjVMaHJ3?=
 =?utf-8?B?VHNqNEkzNzQycXFvZFkrcEVmUkhnSTIzWDUzbzlXZitGNFBvYkZTcERJb1V2?=
 =?utf-8?B?VmJtWm1SY1ZKcytSVHlUbExTakhZdHZzZTNNaDdQZXF5Njk5SEI2WVV6TXVw?=
 =?utf-8?B?VlJZdE5zNktJSFlLMVIzTUxnb0hUUlpRR1F4akhXeFh2NExSdXE2NjlkTWtC?=
 =?utf-8?B?dVJ1bDA5bWwyRjFZZkg2TTJGd1Q3SkRUbWV1UnoxR1R6NzEyYXVibEZjM0dM?=
 =?utf-8?B?REY0b2VZbXNoUnJ2QkdCMHpLSk9GUTA5SkM2ZnRBaVNkZ2JCd0JyNUsxNFRk?=
 =?utf-8?B?NU9RZkpOOWl6YitWNTRNWWNkamlVbHRLWDBJVDMvWnh1NlVBS2RDUHZlakMx?=
 =?utf-8?B?T0xzTk1oZFZkRmFoUjJMVjdVZ3ZCWko4VzRMeStzazdXT3JhRzI0MnRrQUxt?=
 =?utf-8?B?T2V4aEZsWWxsZ2VWVEV3aDB2R3pJYUhDS25VRDhvbWJ1THpFbXB4MXd5MUN4?=
 =?utf-8?B?WFo4M0FRZHhrQjNqOUlGcVZmV0llL1VzSGpadkhxTXRZc2F1b21nWVp4bkt5?=
 =?utf-8?B?VC9Nd1BIZkpTM0MwYWRCL3BTeUJCYkZGTk1RRllCZi9wNXkwSG5Ianc2QkI0?=
 =?utf-8?B?bHoyRm1wdk1uVS8vSnJxcXhXZUljZU5rSll4RllWZlFic2dvbzRTM3UwN3VT?=
 =?utf-8?B?djVxZnNlVGpYejZ1eVMrbFJPZXY5eXYxeUdTZ1c1elNMem1ieGlXNDNOSVM0?=
 =?utf-8?B?QjJuaFRsVE4yRnlWV0tSZ2MyV1NYMENDb3RWZllFcEdqc0U0bU9aRXN0OUs0?=
 =?utf-8?B?bGQ2b21qUlZXdDF6NlVCQUJMeGVwMCtoRDZYWHNrcTlVRzkvRGRoUFVEcTVY?=
 =?utf-8?B?YVN1Nld2TkswNWtUMlREOVVHMWxHTk9rZXVFWFZmMk8yeDRtSkxKYjY0VFpt?=
 =?utf-8?B?R2d1cWpDU1FJTHkrbVdpakRMRUVhbDYva1E3T3NKeWEvZXFRM1owMDY3bTZS?=
 =?utf-8?B?SGtRSEFrOHdONEk2TEkzNjhNZEI5UElRcjB1blliZTlSblBRSzlsU1pRVGla?=
 =?utf-8?B?OGl3d0VaUkVDazlhVVdvYkhkb0tWZTFFcDRBbDhhL2VScnJRL09Oa3VxZlF0?=
 =?utf-8?B?ZjZKeVBPQmNMcFJVRlVUc2s2ZWlrOTJ4aHNZbUJLeUZqdXhJbjdTSmt0ZmYv?=
 =?utf-8?B?SlBvRWdqV0NvSU1WM0UwSDZBUksrRk1ldjNoL0xONWtKeXUyVEd5R3p3czh0?=
 =?utf-8?B?eGpFR0NXTTBTNlhKK3dNRGVnbzV2T2Q2WGN2dDdodmNZeU5MbmV0WE4wcTR2?=
 =?utf-8?B?VC9lSHVmWGxzM3huZmhiM2RaYUlZcjlUMkJmczJKNHBZaGhUR2x2blU1ODA3?=
 =?utf-8?B?R1h1MFBCZ0U2Um5DdklkUml6S2RjeUxZRjFrK3V0bVhtbmtCMUhLc0lYSkxN?=
 =?utf-8?B?MU5SVDltTEF1U1dkMVhiVW5JOVN0Z0V5bGtkM0JIdjFwUm84dTRPUEFBOGtj?=
 =?utf-8?B?MUIyOU9jTkhnZDhMZGVWcFVUT3A1SVFyYnRxVlJrUHZIMGFpOC9TMThRaE8w?=
 =?utf-8?B?bktaUlFoKzE4SlR5R01XVURrL05OTEI2ekNhcmtMUmtwT0JaZjBOTVBEdk53?=
 =?utf-8?B?bEpTQy85a1RHcVlTL090NkdOdVUwajdTbDV4a1htOFBCazRJUWJzRUthVmtq?=
 =?utf-8?B?NEYzL2F0Tlp0VnJ4d3dBZkp5R2Jzc1Rnb1hkT0hJbkRkUy9aQ2I2MTN3d3Jv?=
 =?utf-8?B?QmM1TVpjd2k0S2ZoejZha0I5dUlqSy8yRjdDeXg3dndYRWVDenR4SVBCLytD?=
 =?utf-8?B?QzdKYXA4U0RuNC9nUzJ2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2FBZVhsWmY5cTZ1Yit2UG5FeXYzZm9yamFzekFzaXNGUXphR0hqZU1qV2lO?=
 =?utf-8?B?bmZnKzFCZEQ3RFUzemxvcEQzNDNVU3hiT1Z5K1gyazA5cENVdmlPbmp6ZHR6?=
 =?utf-8?B?cnZXSGZUa1JRNjFSdlZOWjBLRHFnTFJmS2orTkU4RVg2Mm96TTVmbGViWWtv?=
 =?utf-8?B?SkVGQnBCUzRzWEUrNnJEUmY3RFZKRGhYaEJUazhBMUVXRVRNSlhVeGlUZ0k4?=
 =?utf-8?B?dUJCZkphWkN4V1BsalJSRVIxc3Z4bmwyRjRtSXhmOE9EdUp1c1RiYmRLUEh2?=
 =?utf-8?B?MGJIMnlMUU5wUEYwaDVIcjBFcno2UVVOaGYwWG00YldqTVZhZ0F0eENFNHRD?=
 =?utf-8?B?ZzRNb2JveDcvZmFWNzRIRmNMVXBuaksyc1hjSy9Cdml2WnpzdkNsRWk5dzc2?=
 =?utf-8?B?TXR0WkhDSmtWOVVuOFpIMWpjS0hBN0I3R2g5OUVKdGJ2d0R1Q3ViMG1NS0ls?=
 =?utf-8?B?ZCtNUDNkMHg1VzhySks5SEthTGdmT25xYXBqRUhiVlE3NUgwUSszb3FvUktW?=
 =?utf-8?B?YWR2MzVPdVNoM2dDSnFtZDFVVDVyTUszeFQ1OUoxM29saFJ5VHJhcTJTTUNt?=
 =?utf-8?B?YjJRVjRkcUkrOEkyZCtpd2xqdnkyOVJXVFZRV2FPYlZ4d3l3WTFEVmxpa2I1?=
 =?utf-8?B?dTd2MFQ3a2Vib2ErSlpWRUJtNi9Rb0dTWUE3MlJHbVNxMFVPeXd2c3MyS3pT?=
 =?utf-8?B?VkFDODFUdHpZZEtYaFBVYkh4R1ZlWkVaeFZCRys0Nm05VTdXMU1XL05uRzdQ?=
 =?utf-8?B?a1E3a0lTcjdOYldlYUh6VlNxL2x3QUV2THMvbE4rdTBRV21lMFhtZmhRT2Vu?=
 =?utf-8?B?bnZpaWNuazRYOXRGa3F2SUNsTjJYWGJyVXpLR3pRbG5sVmh5MFN2S3Z0dkZm?=
 =?utf-8?B?NG9ncU9OTjFOUHVPL3B4WDU1Q3FwUkxVbmRYNDFsNkRPcUhJSU5TWGFlblFP?=
 =?utf-8?B?V1liUXRzQzREeEEzckJGMTkrc1hSUXpJMlZVbEMrdTFCWFlXUmFrWU56SHBz?=
 =?utf-8?B?cm1keEdSS1p6aUtJRGdGUmIzOGF3cittbUMyZ2Y1eEJDendNTDVnTGtjalhK?=
 =?utf-8?B?OHFuc2llcE9zVDlKZWM4TEdtYmRlZk5nY28vdktpcUtJTW5FbWVnZlk5RmFo?=
 =?utf-8?B?eFhBbW93Y09nMERkSWZwNHN1UjVqV2Jmc1loTXJJbFY4bkZXbllabEFVK21E?=
 =?utf-8?B?bmNFUE5sWnU3R1ptdng1WWVYZHJRRTk0NU9yL293d0hmcmNBSVBaQitMSlRp?=
 =?utf-8?B?VDkvR0k0WDdMeHlock1Ia1NCeFdwSUdTNUZ2cVFXTGJZTUNnaEFhRGZwMTh4?=
 =?utf-8?B?UHN3KzZGMmo4d3RtWVdGWC9OTjAvSGtnZ1Z3ZUU3dkR1WnMwZVB2QUxsc0gz?=
 =?utf-8?B?L1oxcjdMTXo5SW9raGlSZU9yQk9vQUhPVjJ5U2pRajBDamNmVU9RSk1MWWh6?=
 =?utf-8?B?TWZqU1FrWnZ2eGwxZU9wcXZaRXJ5UzJkdURKYnlHaHBERDE5eXErQXJUdys5?=
 =?utf-8?B?cUs5bEU4bUYrUmtuWUQ1cHphVWp2OWpEczVvSnZiV3RKZmdpTG10aUxjdUtp?=
 =?utf-8?B?UWR1SEFzVXBoZXRtOERxRlhZWmswVUk0YjdGeWZpTXp5eU9CZUJIRDY1L3J3?=
 =?utf-8?B?aWd5S2xnaTJ4c0gvazkzcGlaWDhpZ3h2bHB1a0ltbWd6b25iYWpBNm5kSENE?=
 =?utf-8?B?eExjV2NEZXhrbnRleHJMK1Q5WjVBYWp3SFN2TzB4MFhZZ0xwTmd0SDhnaHhp?=
 =?utf-8?B?Qm8wcEEreWtNejJDTXU4QW1sKy85RDVVbTVybGJlWHlKdHF2V0RXbnYwK3FD?=
 =?utf-8?B?amtBYlQyVmVXV2pFQm1EdXBISlM4bVg4VkV4bjJib2lyTTZKUnl1RHJ2S3Iz?=
 =?utf-8?B?N3JmM05NM2dCVTI1ejlMaXhod3pzempXajFsWEVsNzAzUjhaa1hVWEd3cW5D?=
 =?utf-8?B?UWJZMDJ2ZWJVR2ptWGRlOWN5M0xtbXV0MTBMS0ZOc08zWGNjZlcvVWN3ditZ?=
 =?utf-8?B?c3NaM29DYjYwc204RG1yUkdWY1JBeDdMU2hIYVRPRW1UYm8wWVJEOXpYL3VZ?=
 =?utf-8?B?bjg0MHJCaVU4YW9xMUF2L01GUkVZWnJnQ0V0RnRFRVF2Zk5URnZpcFgyVnhz?=
 =?utf-8?Q?oXvi/P9QXkvRp28a9lrc/Q7LW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed7f5d-8fee-4427-daf7-08dcbcd67776
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 03:00:49.6337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0HVHddb+zE7IkMixLNlH62Hne6xa+Hjiqwvip2+NAGkeXlXMSxYxSxCR/Gl0VHuXosUQnY+qYg45LY817buhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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


On 8/15/2024 5:34 AM, Alex Deucher wrote:
> Some chips have more than one gfxhub so check if we
> are a gfxhub rather than just gfxhub 0.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index b6a8bddada4c..6608eeb61e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -484,7 +484,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>   {
>   	return vm->reserved_vmid[vmhub] ||
> -		(enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)));
> +		(enforce_isolation && AMDGPU_IS_GFXHUB(vmhub));
>   }
>   
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
Modification to check if the vmhub is a gfxhub, rather than just 
checking for gfxhub 0, is a necessary for memory management and data 
transfer in systems with multiple gfxhubs, It ensures that all gfxhubs 
are considered for multiple GPU's.

Based on my this understanding of the changes.

Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

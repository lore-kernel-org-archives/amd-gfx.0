Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94664C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 06:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C3210E1AC;
	Thu,  1 Aug 2024 06:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZG//pl66";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165FE10E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 06:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX3RJbdWcwH6VCEu3U5baltzqz86NvN5oqavSX6Iqk0VA7b55OlfA9uUTydDnRyT3P/Ngj4V44cCPyp0aL6hBEWTnQJ6CtdWj55kBSSEyWjIUpyDjTpzw+2PFX9SEKwqKxzSIJsPGwNgl/lQYGdCBi+Pcte7LwJwVWNNSJ2H4oWHgcRq2k21JxG2d1ixzmmhB7WsVXtrB8lWKH+gLWkFt790RMS6Jemu6NNmxvFAu8CzyVNmPOUE9eg/1tXUuKcsQBdEIQXicmHPjV4AvozJKq6SzhO2ZJObiPwMYzCP35nigBGXYT31ax9dR1ue3d/HdCDcfIlyRUmRGG2H/6sLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6crQe0OGwgzazjl4fkiGUsRxqvxRIHyY3zJMp1jSRY=;
 b=aapq2Ti5sR6JPkZXBV0dBI/v0yK0N9phF5jFln/l9yqcBvQMvwuStcccFILLg81U3D32RZRvVROEW29LA7/AVYZa54Qt2YKSsF63IRCAun0GEhEvCaCtbJQdJXuqe1UJazSDJRV+jB5RO/MjugruXMrRI/aRqziBZe8nEaUOGjfvPQodksyeSWTrqC3KABGwGhUlSp8RC067Cy/gCKmVW9l4eO3hMEvmYHSU4gLEA7d7mMN4HdA8VFqGUPca1EltMlLODAJ9TnfuHxQwJq3d6cE8FfBQa5EzHfPRG5xfks7gIV9tBn89x8zxgyhdAm+b+xUdheuSuvKivzBcC9uItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6crQe0OGwgzazjl4fkiGUsRxqvxRIHyY3zJMp1jSRY=;
 b=ZG//pl66oicUeWOkONZ7i4xvyKAg/eYWnadG+vwBA2RPdArSu/18/xRv3Dm0ktaBryOfDxKb1BUnVRuF9+bonPOglpB3KTFddXEvUp2sk4jnE5IxPos6Ly5xA+dihDzZmY63mVujZqg4EmyOvQa6oNmDjAO4W2hu27AwVDiNLnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 06:41:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 06:41:11 +0000
Message-ID: <fae5c475-ba74-4353-957a-29ccbfc147d7@amd.com>
Date: Thu, 1 Aug 2024 12:11:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: report bad status in GPU recovery
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f0c6a7-70b0-4a7e-ad31-08dcb1f4ee41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1lMRXVnWGI3V3Eza0JQejJ0ZnBMWjFHOTFZaHJWbGd2TG9halBHL2RCYU5y?=
 =?utf-8?B?VnN5d3BJR2hUckJ6QXdlTENudXpzZ0dndXZ1SG9vdGhiL0YxVFhXVlNQTlJk?=
 =?utf-8?B?TmhWdHFQYlFoSGxCNWFmVmRVKy9Ud1NiTlZEOGlLQnM4d1ZudC9HNGlOdGhL?=
 =?utf-8?B?YkRldzU2TjdsYlZNZXFkQ3M3VksyWmRpaVNXQ2U5K0RmZVNRclFmZ2thRjZl?=
 =?utf-8?B?Wmw0Z1JINk5Da3ZGWmxnSXBTVjNEcHhNWEdRdlV3bXg2QmZObnFueXZYOUFy?=
 =?utf-8?B?VlhlM1R2Rks0ZEl5ZE9MWHhxNlNFTHdoTkxVa1RWbXZaRkhzMlc0bHl1N1F4?=
 =?utf-8?B?OHVyMVVvL0kwc2RtYks2YkJNdUxnc3l6QjFCVnVJaUFmaTcwOUUrOHdPNnI3?=
 =?utf-8?B?a25DSHNmSzdaSjlZYXN1NnArSXA0UitqWmFtN0lGT213ZVVUaXB0Q0NObXA2?=
 =?utf-8?B?UkwybFlMUlVEVW1wY1pCazN2d1dOTGo2R3RubnpBMFFHTldydkg0WENhMCtP?=
 =?utf-8?B?WkNHYlVHV0RJU0RVUzdkZmQwdWdNN2gxOXlzT2FnNUhRZ1JMaytLTFFWSUNF?=
 =?utf-8?B?Qms4UUR2N2RIeHVWdEw0di9KU1VORVhtckMzWFcyOEs1VFFtNmpzZG1wTTdz?=
 =?utf-8?B?Yi9Gc25WSHBId1BEYWZnZmxpbm5jMEg5M1hETGxqL015aWZHWEVvMW9qRWx4?=
 =?utf-8?B?Q3FlOExVa3l2VW1UVjJXNU9aaUl3YUVTTzZoTFdMbXl4Nm8zRlNCYXpUeEZU?=
 =?utf-8?B?VjNocGF5WmRQUWp0Sy9TZ3NJTit6MzVOOXhIRGV2bEh3ZVZTSUQ0Q2hZZnla?=
 =?utf-8?B?aVNFTVpHWEZMc1U2UzNWbDE4TWlRU1hDSXgwRTJaOHhYSWJiTG4yNytLMWhq?=
 =?utf-8?B?NEZmVThOSVdEZ2hvdGNZdVY2WmQvVTRDSFFhdTMxQkduSzhRZ1Q2Rjd3L1Zr?=
 =?utf-8?B?b2tBb2lzWm5kMlcva1VScE1SZ0RMUUxOalIyemlXcmNYc3FuSStSY3NoemlG?=
 =?utf-8?B?bHQ4V0JJRXM2c2Q1U05INXg5S2VPSExhZXNiUnZhNVR1SjJtY29qQURuVS84?=
 =?utf-8?B?STJxWm14am8veG5HNEdPTytGRHg3VjZ4czNud0JOd1BUTkQvUWx5dzJsRGFo?=
 =?utf-8?B?TVluVXpzcnBxMkpCTG5wV2wrbHJHUEZMUklaWmRGTzBVdWJFYmlBWUtxNm1T?=
 =?utf-8?B?MVorRnJLajNvaTJXV0VpQXJGcW1VdG5RdE1oOGQ0TXN2R2JOb2w3MFh3aGh4?=
 =?utf-8?B?YU5QK3R6VURjSVk2SS95U0pOL0V4RVdjOVdpVDdJMUhMWmtMWnNCMko0REEr?=
 =?utf-8?B?WGx6NDBNRmhTZmwxRjJSUW1teGlBajY3MTd5RW54YVpWeFBwVG44MXIxdEpS?=
 =?utf-8?B?V0M4ckh3TVNvTTAxZm14ckZzMDlIcmJuTGdzQkgreGZOYjc0MCtiYktpMmUr?=
 =?utf-8?B?RFVIbmc0MlkzaVJpNDdEZllZWUhsZHBUUDNIYXVPdGRIeTFNYk9oSFZ1eUVh?=
 =?utf-8?B?Ymdya2d4Qk51dVg3ZEkyNnIvWThXQTh5QStBUWoySzhOV1pzSm9uWWVQdk9I?=
 =?utf-8?B?NmVuQmhMaTRZZlZkenBmQnBaY29IbGs4bmJkRUdjWlVaQ2RrNnNoZXdFZkZS?=
 =?utf-8?B?NnpjU1JiNWZsYUhnYUk3dklUd0VOOHY2T2RKS2svUTJRU3hWUFhaYzZCV1Vm?=
 =?utf-8?B?Szc0TnAwOW5pWTVva3FBeWErSXR3Z3RWTER4cnEvRzFDdGVkRHg5aWRWVFhw?=
 =?utf-8?B?V2d0SWI2YmZIUHAxdnNoVmNQVHhjOFdESDdRQ2FiWndVUkdsRjc5Yko2NVU0?=
 =?utf-8?B?cGRjRGRWVHNlbC9vL3M0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhpeGlFczZXSFVuLzN2NjhId1hxei9QelBkNmoyNzdqVDFKYTV6Q01FbU9C?=
 =?utf-8?B?T0kxTVpURVNUOHBEdmNZOGZTaVAycDgxaGVoQndHcnZPaUY0TDZ4REo5Uno2?=
 =?utf-8?B?OUU4OWdyd3p6UmRNR1lHM2dWRW4yUVlOempKU0txY1NQM0M3UkFmRzdGaXNx?=
 =?utf-8?B?K1BYeE1sSXZlcWxleTNzNXhXd2NBZnRZdFR1TjdKRGZUR3FDZHRlckZ4dmVB?=
 =?utf-8?B?akxpVm9sQU9iWkhqcVZTVUpxS3BsVXJiMHl1QjltQkVUL0dwWWlYb1ZwcVpt?=
 =?utf-8?B?bzZIYzJxOHNYM2o1V0krZVovbjBidGR1cnc4TEcwdjFkMDZLVnIwbEV2MEhk?=
 =?utf-8?B?NjZscVJidU5TQm5Kc2hvNEJnM0ZwTzFkdEVySG9UaUloemdnWkprVnBtdjA4?=
 =?utf-8?B?L0U3MkFCTE81MnJVbmdCMHl2blBIbHpMTmxSQ0kvQnhVM0dXWENCRTk5UDNW?=
 =?utf-8?B?QjBWQmRUdnAvS2MvSjdCY2owVnhEMXUyRnZ2ZG82Wjkxbmc1bU5vajYzZVhI?=
 =?utf-8?B?YjZDOE4zVXFiRTZhYlUwZDJNZWw3Y0dFRTBnQXk4VndpTDBDNGNsbU5JdVlz?=
 =?utf-8?B?ODZOeXJkcTB5ZWlWc1hXV0V1WFJWOTlVb3RUU1JBUGdDTmxjMEs3YkR6ODRY?=
 =?utf-8?B?bmFQU3kyMFlYUnNjUFc4U3dCTllydzQzakZoUExWQktpUWZVTFhNYTluUHJo?=
 =?utf-8?B?eXZUS0lYeXpWamdTdU01VWl2SVNra0lzeUdXS2pzTStWdmR3Z09WL1ZsbkRK?=
 =?utf-8?B?SlRvV0EzK1hHWGUxQ01sSGpFeGZ6ZTBTcHV3ajFYck93NnBMYStIdW9IQ0o0?=
 =?utf-8?B?Zk1EZ1g0ZzljcGVCUE41MHA5dm1OWmN5WGZCcTVjaGtVaHdIRGNHOW1RSW5N?=
 =?utf-8?B?R05Pc2hzZG5KYVA2Qlk3T3crcjluWHNNOTVCVzNLZzNLVUJrMVRtckFSdG5a?=
 =?utf-8?B?NGd4RzIwNmxsS2sycmNOaHhJTXArOGkxanNlVmh3WUQwd0dhSUFZakhueEI0?=
 =?utf-8?B?Um5CM3BENE80ckI5eVYrbFFRUHdFbTI3ZDR2YUZXUWRWdGwySkRNK09SWEln?=
 =?utf-8?B?T3ZkWEpXSFJGM3l4NURyekdnWmNVbkt3Nmo3bUZ4aVFrY3pKSWVkWWg0TE5m?=
 =?utf-8?B?YXVicDNFZUJBNHhTeTdPT0NnVWdNVHNWaWdyNXpsOGhBSXBjdXFYV1NYMXEr?=
 =?utf-8?B?dy9ON2MrTEZ2bnZ5aDBjdjlTTE9EcUc2QTJBbFJDNjBaT1dOUHhBS1NTb21H?=
 =?utf-8?B?UkZBVUk1eHlnOTFzZXBzVjBQSkltL3dtWGxJSjlIOGp0MlBFalptdWNlc05W?=
 =?utf-8?B?S1FybmpFRWRHelIxZitGZXo4UFo0N3NLUFdnZmRQUFpGbW8wejUvUVNYTURZ?=
 =?utf-8?B?am5UaHBjRytvb3dPL0ZDMjg2K2dqY0Jwa1hiWGRIR3FzOTRuRVBwTVB0MjB5?=
 =?utf-8?B?Y2ZRL1hLaExtN25jZEkxbGFDVWhNVElXallKUEZFREZDdVAxd0xKREltSTFJ?=
 =?utf-8?B?TjFOZ2tveVU1NWtiTFZEUlNzQ1U2dEVaTGxPTHpnbWFHNlJUNU0wOHRHL0tP?=
 =?utf-8?B?TkFVTXp5VkVzOVkwQ2FkdXdBY3ZkazhFSU40dkk2QUtTbmZJVE5HMXAzTjFH?=
 =?utf-8?B?dGczMUZZTDVvTklBS1JkMnJCWFpUY0RkYzVsNkpieVJtZlFsNWxoSml6Rk9p?=
 =?utf-8?B?OCtCYm8yd1lSUFhVQkR6bmdJMGpja3YyL2ludkgzU0wzUHBtNlUvb0JZNnRu?=
 =?utf-8?B?V1ArN0VBOHRoUEJSQzRaOTlEQWRaMG5PcDc1RDB0Sit3MjRsc1hKLzJEVll3?=
 =?utf-8?B?QUljMzhuM2wxNHM0WEs1VHM4QWRxVlJxdHZtcU9ZVUZnV2JNTEVvRnQ4dHpI?=
 =?utf-8?B?TzB2WDdQQ2JCSkRUbXQrcFlIWUxBRzNHQUpsS2FOWHE3bW0xOEFFOEFBdE5k?=
 =?utf-8?B?VGgycUFmV3llc0xZV3gvU1c3NFRhcVpiTERqM2dZU0YzUGZyUnBlNGJMWG15?=
 =?utf-8?B?dFNqVDdOVTRPWXFpQWhzaW5wZ0MzbjlublBjZFY1a21pY2NKOUwxckZFN1hW?=
 =?utf-8?B?UmhwcTk3clg4Mmw4enhrOWd0aUdGQXZybjRwZVBmV1dJTi9OWG9PQkh2dzJo?=
 =?utf-8?Q?rS3pqb/OHwDNh10YpTWnfl8qT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0c6a7-70b0-4a7e-ad31-08dcb1f4ee41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:41:11.0156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXrrNdmhUOFe0CxTioz9pOB1OjYhFHAicKcjTmunLt7/yrkUeHe/IMK+LP/aLxgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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



On 8/1/2024 11:28 AM, Zhou1, Tao wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Yes, the bad status message is printed twice with this patch. I think it's harmless and the second message is more convenient for customer.
> 
> I can add a parameter for amdgpu_ras_eeprom_check_err_threshold to disable the first message if you think printing message twice is not a good idea.
> 

Instead of this way, can't this be added to amdgpu_ras_do_recovery() and
stop all recovery actions?

Thanks,
Lijo

> Tao
> 
>> -----Original Message-----
>> From: Zhang, Hawking <Hawking.Zhang@amd.com>
>> Sent: Thursday, August 1, 2024 1:30 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Right, it's functional. My concern is whether the kernel message in
>> amdgpu_ras_eeprom_check_err_threshold will be printed twice. This is the end
>> of gpu recovery (i.e., report gpu reset failed or gpu reset succeed).
>> Check_err_threshold was already done before reaching here.
>>
>> Regards,
>> Hawking
>>
>> -----Original Message-----
>> From: Zhou1, Tao <Tao.Zhou1@amd.com>
>> Sent: Thursday, August 1, 2024 11:49
>> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> I think the if condition in amdgpu_ras_eeprom_check_err_threshold is good
>> enough, no need to update it with is_rma.
>>
>> Tao
>>
>>> -----Original Message-----
>>> From: Zhang, Hawking <Hawking.Zhang@amd.com>
>>> Sent: Thursday, August 1, 2024 11:00 AM
>>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
>>> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Might consider leverage is_RMA flag for the same purpose?
>>>
>>> Regards,
>>> Hawking
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
>>> Zhou
>>> Sent: Wednesday, July 31, 2024 18:05
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
>>> Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery
>>>
>>> Instead of printing GPU reset failed.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 355c2478c4b6..b7c967779b4b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct
>>> amdgpu_device *adev,
>>>                 tmp_adev->asic_reset_res = 0;
>>>
>>>                 if (r) {
>>> -                       /* bad news, how to tell it to userspace ? */
>>> -                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
>>> atomic_read(&tmp_adev->gpu_reset_counter));
>>> +                       /* bad news, how to tell it to userspace ?
>>> +                        * for ras error, we should report GPU bad status instead of
>>> +                        * reset failure
>>> +                        */
>>> +                       if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
>>> +                               dev_info(tmp_adev->dev, "GPU reset(%d)
>>> + failed\n",
>>> +
>>> + atomic_read(&tmp_adev->gpu_reset_counter));
>>>                         amdgpu_vf_error_put(tmp_adev,
>>> AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>>>                 } else {
>>>                         dev_info(tmp_adev->dev, "GPU reset(%d)
>>> succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
>>> --
>>> 2.34.1
>>>
>>
>>
> 

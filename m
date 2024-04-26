Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04D0C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4473510E757;
	Fri, 26 Apr 2024 03:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9tZ+Vxg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5342D10E757
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncee39yOpimNFpj4zOZWJNs2vC0WE779A3ay9OWcOhvS5aOQWy5kuUmX4kP88Y8EXbn97mwrCtd0OL27SqrQNtrVaT4MeLky3SrF33kTx2cK/IN0/XlH8qEYY3B46nYztsfs+NqMFcyhf5eio3MjDZXIAe0HOwYPCbcn1VgEGOIPRuHSCPDCp4BXviRdLBQLjrXspf1fSckhgBK0UgJdenlOo4FQUgI51df/pA4ZQz+2jiLZveagHgIuNY9h+cvdtwp93KDLEGwGQRpN914E4AHN7t/0rHRAPLDLb9lb76HPWs7GlZmK3JAykBkHv32MJX07TDXnzVm36kO+bVjQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+r3FV85UTZP4zLkmd7aCqwmdqznittxFoVwHjUD+tM=;
 b=U5qVNiHZXNaXvliNfSwH/oot/VcaxP7IYCa335s9Wy59ki/8dAmTFytWjFN3o5n0zQ24s7YMNaadnjfVF9uWTYled6gRS3A68m0F+p9UsxTcRF3xOw4eyee/yELbrCyzlumr/xEqvimroe1IZaDUFobpGprb2bnuO11vZwUSPFTeo1b/kZ+hfTuYOosRHF0HjlS0mzaaRWykeixcT+jq1J0Bj9zQMGxDPfxwyQdi47vMGuccR+egULTFezaxirVC16sy1PS8mZ6UEetvAHM6pn1ZjcVcT2uLvnQpTJN1gntEWrRQCUeQYaWXb44O1837InHW43qSmDJxZRuS6RFqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+r3FV85UTZP4zLkmd7aCqwmdqznittxFoVwHjUD+tM=;
 b=k9tZ+VxgrpWbRMj5Pv1HMRUaGygGaZa0K62Ca6Nh2annepv07WbyiQKzD17A7aAcjJzdZHZhBX8Hwa8ySqZEv4ZFYnyNYvwHlQw58CoEMAV4SfOmbA252ginQhHjtBHfLJlmpWjnoCQFGh7sIp9DRqmK6ntAUUpM8/wXemSe884=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Fri, 26 Apr 2024 03:08:16 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 03:08:16 +0000
Message-ID: <a5526673-3275-4636-80f7-abbe468f4a32@amd.com>
Date: Fri, 26 Apr 2024 11:08:07 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Fix the uninitialized variable warning
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Alexander.Deucher@amd.com
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <20240425100027.637016-3-Jun.Ma2@amd.com>
 <c9813334-3ec0-4095-930f-e4ecea3125b0@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <c9813334-3ec0-4095-930f-e4ecea3125b0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 73814f15-f23f-489f-494b-08dc659e1e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFphWWloOEQ5S2ZVZ1F0SVh6azJIaU01aTJsSVNsZlVZRVEzY2V2RXo2dkUw?=
 =?utf-8?B?TjJwSFkxRW00aU5tYlNjci9pN21XdDEyQU9BRDFjdUpMZTNSbG5TcWRGcGJW?=
 =?utf-8?B?MDVrbVJHSFdLN3hCeDRGQ01sNWM5ZnhQaUZjNnRGQ1Bza2pwNGJnVWtpWXZ2?=
 =?utf-8?B?VXR3ZUgyUSt4bkt1cGJRcVMwU1JDWkt3MFIwUEZqVjJyQTYzNXRzdU1TcHk3?=
 =?utf-8?B?V3JHWE5hR2lJcDhYa2lCMTBZbFJPMEoyOE9ybEo3MnVURE1HeE5BSlp4dDVx?=
 =?utf-8?B?SVdTTFFkcjN6UmxDN25OZVlSVW11UFE1dVhIY29HZDJWMy90NWMvelhqcnRF?=
 =?utf-8?B?MUhWVHZxbVhERTJLeGR2TzJab08wZzh3cU1zLzAzdFdVSE5oNDgzQ3htUG1h?=
 =?utf-8?B?NUp2N0d4Tm4xQW41YTJqWElQNDRUVkpBeVA5d3k1RzdhYUo4V3VHZHphRlJX?=
 =?utf-8?B?WXdQMytMcUhnNE52NWhVak9aTVp6bFQ0SE1Bd0k5S3U0ZVhhRTdrazBMR1FC?=
 =?utf-8?B?N09QMFhlbGxub2JjVHhWc3dlcnBuOC9zMlpXWjIwTDRwRUJjZFV0TnZ3enow?=
 =?utf-8?B?K1oxUytxWFIyV3d0MzVremJkK2lobkZWTVpxaUNtY3ZOL21ESXYvZlJOd0ZD?=
 =?utf-8?B?TzMyQ1c5RzczamJPZ0xCbUpkemozTVU0c1JvU3BqWXczN0l6SDdVV2RBZDVS?=
 =?utf-8?B?S3FEZnBHcDM2OUdMK2R3blo3cUlBcHliOVMvcVhRZUl4U3JCVTVuTTAwSVJj?=
 =?utf-8?B?VElHV3NpZ0JHWWdEams5c2tDQlpSNmw1TThwcEdRRkRQREg0MXo4V2lOZEsx?=
 =?utf-8?B?ZjBwczZTZ25Qd1VxQ0M2d3hUN2MxWFovUnEvb0Rmb3IvWkxqbXRVbHZxM29H?=
 =?utf-8?B?dEMzb0dTSnFMNGpERmdJM3dvM012Qzcvc0JlNzZNTHIxS2syWHNQVUg4K1Vj?=
 =?utf-8?B?TUdZZGttTk5pM2dLckkrWGtMUnMwLzZwZmovUHh2SGExa3JaOTVEMlpyZXNL?=
 =?utf-8?B?Y3JIb0RjNXMzR3NqaW9HS0JWUHhwYVFLSlQxTW4wcTQrZ0FiNGp4dnhLUjNF?=
 =?utf-8?B?SnJHb05pb1M3VGU4WnVjcTluYzdCdHVZK2Z3SjJlbmxJb0tHTGdmZ253L0hj?=
 =?utf-8?B?Y2lSNkhNeEZqK0VtTWtQWGZEd1dFRTJpZ2FGZEF1SXFsK2Y1Yll3TTNRZDJp?=
 =?utf-8?B?NDhobkViTWNMSGZCU3h6dkl3aEU4RkhZUkEvMHpjeUc5TmJJZGM0RVFZREQ4?=
 =?utf-8?B?dFpNY2FDNVpFS3VOK083SFpKbEtkTXVXdklwZ1M5TWtVenpFbTNzT2RaZ3Mr?=
 =?utf-8?B?WEZBQUEvQ2lBTnYxZUxXZjJoK2N0S2RIQmQrUEVNRDdSd056VjVJOW5zOGEv?=
 =?utf-8?B?V0lORnBwRlZJcWZzd2tEemZPeU9FQnNnSkE5eTkybWtQNUI1UUJHaDNLeDRq?=
 =?utf-8?B?bGg2dXBaekVNbWRqeUVMa0c2cVY4T3Q0UWk1RjBVVFc3aStSVDJRTDJqNlVT?=
 =?utf-8?B?clArQ2NKR1ZSc0pGL2VoVXQzUVhrbjAzZW0xcnRxS2V5TkUzNTZkYXdERjQr?=
 =?utf-8?B?VmFzajBMVTAwK2FBUHdTRkxrWFpmU0VlV01hTDhWREpEUkN3Z042dHZrTXJH?=
 =?utf-8?B?K1Arc000ZWJqUzZFOVRqeHQ1ZlREb3ZpVFZyY0NMbFlxaEtjb0dXYWpIYmxS?=
 =?utf-8?B?aGxRSzBQNk8zZzByNVY3Zzk1d0dzdHdnMW5Nc2h6dURxeHpaRXZSeDl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkd4OEpPWUI2Zm1BbWFOMmE4eGI0NzdWU0dzM293WnYrNGdua3kvYW5Velg5?=
 =?utf-8?B?Y3lLa2JjdVBVYkc2b2RaL1p5Q2F6Rk9SR3hMeHhneDVwMjcxV0tnZTJGQU4v?=
 =?utf-8?B?ODdoVEpLNnNsUVk3c0ZPRDIzbTJaWW5wa3Zub29pSUxLbDhQNjJTYW9INzJL?=
 =?utf-8?B?dnhReitLc2x4bEVhbFZwdFBsZ1VFczBuMkN6V0JmY3YydW1LRlBTQTBGS1Qv?=
 =?utf-8?B?ZFk3VjZkQzhrM0doRGtEUE10VVpIKzhPNHpCeFpzMTdKc2Vkbk9CNm1PZ3ZQ?=
 =?utf-8?B?MndKblBuQlhNV0ZRV0M0WUNzdXI5MkRhYWV2ekJOVDJEWnp0akRLdThLeGd1?=
 =?utf-8?B?VzdUa1IvQ0RaSE1RWEp1L2w4UnRkZm5TNGdpRjNYVkJHd0hyQ3B0dERwRjJy?=
 =?utf-8?B?dUkwd2tDNlRxRVV5eW5BTVNBTkRpaFJtUXZVdEFIdE5VMDdBYmtnK3FLdi9I?=
 =?utf-8?B?UzE5d3I2bzc3M0lRR1laaysrZ0d3TEU5Z0ZrVEh5QmFwQnd3NjZ0QmtnZitn?=
 =?utf-8?B?V2F6cmdYeDRBNFlGZVBLMCs4VVhYNGhCYmlOVFd3dks3VDY4d0pKb1QxSDdK?=
 =?utf-8?B?SlF2QmlYTzg1ZGJ6OUV5eXFrbDl6bmR3OUZLRktuYmRLT1A3NkZGR2NWUmNS?=
 =?utf-8?B?aEd1NVRHUlViSSsrZnBSTC9xZENnb1hybWR3NXBLSkdwVGQxWm4wWmZjZ1p5?=
 =?utf-8?B?eGd3Yi9pVEhMR1EybWVVMUdDaFNDUUdoRGNHclkxdmEyTEl4ZU1Ba0h0eXFQ?=
 =?utf-8?B?a0w1MVhiYUxCY1F5cEJKMEloWERMWHMwcEJvM2VnWXRydGltT0s3Y2NWMENH?=
 =?utf-8?B?bDRjOElDQ3BJWmxsN0NZdjVEQngyc0NzcW11NHY5djM2ZVkyMkJHU09OSzdN?=
 =?utf-8?B?eno4eUZhdEQxWFpmV1grY2VDK1lLMlJVdVFPY2gzdnNuL0xYWk9nTWdyQ1dL?=
 =?utf-8?B?SUlQV2tkekpFZTZIMDY1aUJnL0tFUStnS0Z1R1VYdDFtaUExSWNZRlRpMTR1?=
 =?utf-8?B?cG5iUTFteDZhZ3lReVh3b0REbnVwV1I0c0tIbkhYcFJQVVFYaEVQakxNNTBk?=
 =?utf-8?B?OGRFV2Z5Ty9FQnozcHNvbkkrZENhTlI4NTREeGhubHZIcEIwbDZ5Qnh0N3Z1?=
 =?utf-8?B?RCtnbk9qR3VkTmNwQXREamF5c001bzlBcjVXWGhCMkdEZXlhZ25mTW53MlNP?=
 =?utf-8?B?UmE2b1dOUVBoMVF4dnBQQnd6VC92WHErWnFEdXZKMU9qOGhTcURqQ0U5OVla?=
 =?utf-8?B?bUpCU3QxRTlYeHFPRzhwRkd0WTV5QVVPZkx2cXZvZktSVUtpcVd3bFZsc21P?=
 =?utf-8?B?ZlVORzM5WllWalhSbDM0eEt2RE1qTVVGWlJPd3NlckRQRjFQQVpyckhDUmJz?=
 =?utf-8?B?MGd0M0NqRWtZSDhPYW9nZitZQUk4clB6Yk5vY3YrdU5JU1VkaHVrWUVOMTZn?=
 =?utf-8?B?N3hXS0xlQ2NCTTQ1eHdLWmxVU3E0d0h3bmJCcG5GZ2x5cld0Q291U28xeE9v?=
 =?utf-8?B?T1hMVndnQk5zQ09kVXdBTExPaGtBa0IrcVE3STQzajM0Q1c0VmhrT3VRM0Zs?=
 =?utf-8?B?bGlweDFjR3FpaDFiZ1lHYU9vN3FUUmFPeUNaV0VQdlBrelUzTEdkeVZGaWRr?=
 =?utf-8?B?dHYxWkx2b3hDU2FJNnA4TmRWaTJNajRKQ0tXNUVqVVp1eVFFeHFWUWJ5QUdi?=
 =?utf-8?B?K0xFVFhyQkE1U1hoNitnS05HY2JPSVlUa29vMTQxa2lZRGhKb3N0ZmROaW1a?=
 =?utf-8?B?RnhFbER3by9LTVNNSGFwV0oyM0Z2eEs5YXVqOTRVVStuak9IcGRoelhLcEht?=
 =?utf-8?B?dlhYaU1WTHcvWC90REczRDlkSVh0dFNSbFB6am1sdFhnZUEwV21DbTVzZUtF?=
 =?utf-8?B?VnBEWGxVUmp5WE9GT3NjeE05Y2Z0TUhEZU85MmVDMzd1RWpCWEJSbmR3Zk0z?=
 =?utf-8?B?eWRmN2tiZnI4WS8xbDA5NmNrUVBLNDVDSWtqbG5YN3o0emJNak1BbVpudlE3?=
 =?utf-8?B?aTRaK0h5NlhwNkJFQWlwYnB5Y2hSM2hqQ1g1VnNhUGM5NDdRRkJOb3J6K0Ev?=
 =?utf-8?B?aUVRdjBvZDFMMHYyWnp0bUprN1d6cTM0bXRxQlNzUmVhTzRhUlliVGE4SzUr?=
 =?utf-8?Q?1vf6150O0zBB8TT3gHon621xY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73814f15-f23f-489f-494b-08dc659e1e25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:08:16.7803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmZ0836oIEz8Bg7APqJQRkEhcVXhaFV4IR7LRx7efpj4ItzTY7DWWtNgFemDWrmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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



On 4/25/2024 6:10 PM, Lazar, Lijo wrote:
> 
> 
> On 4/25/2024 3:30 PM, Ma Jun wrote:
>> Initialize the phy_id to 0 to fix the warning of
>> "Using uninitialized value phy_id"
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
>> index 8ed0e073656f..53d85fafd8ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
>> @@ -95,7 +95,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>>  	struct psp_context *psp = &adev->psp;
>>  	struct ta_securedisplay_cmd *securedisplay_cmd;
>>  	struct drm_device *dev = adev_to_drm(adev);
>> -	uint32_t phy_id;
>> +	uint32_t phy_id = 0;
>>  	uint32_t op;
>>  	char str[64];
>>  	int ret;
>> @@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>>  		mutex_unlock(&psp->securedisplay_context.mutex);
>>  		break;
>>  	case 2:
>> +		if (size < 3) {
>> +			dev_err(adev->dev, "Invalid input: %s\n", str);
>> +			return -EINVAL;
>> +		}
> 
> Better is to check the return of sscanf to see if phy_id value is
> successfully scanned. Otherwise, return error.

Thanks, will fix in v3

Regards,
Ma Jun
> 
> Thanks,
> Lijo
> 
>>  		mutex_lock(&psp->securedisplay_context.mutex);
>>  		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>>  			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);

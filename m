Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4857D2FFF7
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 11:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F26110E146;
	Fri, 18 Oct 2024 11:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1h+hV7H2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DA910E146
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 11:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFZ0iNCYNmUvYb8lmIbKSZ6VOSTOVhVnN82VZUHTPjGxYnJHDzSFHRGtSz46/F+k5poiD0bxoEt3S/3ZMf7CaJtSck48CvuK/F1L0c6xMTWdpBageZah0DmxO0+o4eyZMz2FcMZ2uCbfFB5/9L7u6y5XRSWoXqIkFkyU6wNK6px/AxIO9+iQfOI1eZKMByKphTy3BBLCo/uMAR5arpD2+g3SJq65XIUpqSRHG1VczaUt/pODcKRDm3MGzi+O//ISY/8lASuoHbNSZpevZwJiRhdQi3I55MT7hXWxjG/Y58dSQGDQYNkH8cBy5gryq+o/WxIfxwM5Nb2h8c6BavO3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulVYkRjQuKFaV8zFHZS27/HQcdEZcRZzZ4jAI6EtJuw=;
 b=A0TapJS3RC9Xrgvqb+Vbv6MuJ4fmYZS+uYTGtls6dgUhyl70yShNfRiuWAMp7ihPeUP9jqmBWhHGC0M3ZJTDPsOf8k20y1QkHnTxvToom1ZBjwvk/I+OFeK583AWIlMaLjy0nFsaU+adrI1QHlTMW2HkxkTi758j5sDrKnR/Hbr6YGn7aAZbOPqAGfllozziYt0OYukZvDVFkQcS26+/FgbpdMwCPbXRY3oIwcLCY9kBvmcMGiJye2OtFI9no8RYpm7bMstIAVNnGBmc+HNm9b/M6BflFSPzkYA7No6rCCSSMKcSSqZZ/E0GLrsYFE6WaZteqYZaNwjcyYDZmWqJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulVYkRjQuKFaV8zFHZS27/HQcdEZcRZzZ4jAI6EtJuw=;
 b=1h+hV7H2EeQtsd5tR2AGj8AkYIAhAf6SFWP1he93mLJbht5RL5ipd3z6oV5KlHnh1+psmr6yKsUh5R2P17WUgdmJllJvxNO6n8rPX+ZoiVVhDF1E8QI4xqmpiOGfcsmkpis/XQaxsggRlQk017OxIMxKU6tQSMRGrWVoFs3rhbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.26; Fri, 18 Oct 2024 11:46:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 11:46:59 +0000
Subject: Re: [PATCH v5 02/12] drm/amdgpu: add helper function
 amdgpu_ip_block_suspend
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
 <20241017162531.1551442-3-sunil.khatri@amd.com>
 <dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <1254db74-a790-9fc8-119b-9f6cbeead3e5@amd.com>
Date: Fri, 18 Oct 2024 17:16:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com>
Content-Type: multipart/alternative;
 boundary="------------ADA4DB1BA7A49660D0DE2D98"
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d1b611-2a5b-47d4-c0ac-08dcef6a9312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWRYNDdkWUtibmhxbnUrRmRNYkR2Vm1rckFCL1BuN3lMbHJ4T3o1NHVzZWxy?=
 =?utf-8?B?b1o0c2xhcFBpM2FEYTVQSlI0N2lCRHVwSUxmK2NkOFc2TnpBaWZyU20rYUtu?=
 =?utf-8?B?TzU1OXp6UVpseUkxQ3ZLdTJzdE01cm1STDhGVWNRT1pSbHlCQXdpYjcrK2pR?=
 =?utf-8?B?Rmo1VkNWdGRtd1hjdU9BcVJKb1BnYnhMeHpGOURBQ1FVT3pNK0pPdU9uSTJh?=
 =?utf-8?B?TGxaY2hDa0NCZ1RJZ04wOUExeEEyNHBiS05FY1lNOGxibnAzNWFMQk1OMlNn?=
 =?utf-8?B?aFpwZkMvMWNUUXU5K1Z0NnNIYlhvWjdWZnZObmRIbm1tRGNlVUN2NnJERlVw?=
 =?utf-8?B?NndzdDNuQzR4eTRYRzRNcWhmV1paUkhtQnU3TFZqczkrN0NsUmZTM3JmNnQy?=
 =?utf-8?B?NHpVc2F0MDVyRlJiVzJZSmNHWkthRCswUG1rQmV1RjdXdkVlaTE2RUVlS3ZK?=
 =?utf-8?B?MWxPcVh2MHRROTc3blZ4OVVLRnY5NTFoU0ZzWm9DNVZ3d0ZWMy9GYXBNZVFl?=
 =?utf-8?B?VlZZc3dkTG9xcFBteUdqNUJSNGE4V2NGUWNxVnEyOTdiTHc2UWMvNUd5VnQw?=
 =?utf-8?B?alZxWFdIYjhmNGxxMFljSm13aWdvaERWRjFDMThwUVU1VE9oL09LbDFaVyto?=
 =?utf-8?B?Z1lvRUtwOHNsazFzVUcvczJtb1FGNFdLWlNXTVo1SGlBZkdpWHRpZWxKY2c5?=
 =?utf-8?B?dkJnZ2k0RitqQ014WGJoQURjbGt4VTV4eWt6SnN1dENWQ2VsVDlMWEpFRDkz?=
 =?utf-8?B?aW51TnE2T1o4MzRDZlRvQURCWEM2eENjM1hMcHZSV29lV2dVLytpVnpDNTBz?=
 =?utf-8?B?QUVqbE1zdC9tT1ZlTXgyN0dqcThwZjlQK1FkaUJwQUV5bG1uN05TT3FRRzR4?=
 =?utf-8?B?ZHhoMkdBOFh0YTIxZUJPdVl6MUtqUFVac0VxVTBkN25PY1Y5WmJjaklTUVE0?=
 =?utf-8?B?Y1E5a1U5RDhZSVkvY2tiUnFYM1JkRGZXaHlxVWdBM3ZJdzhNb2hCd0pQOHF3?=
 =?utf-8?B?enBqbk1TaklOTVhaQkZnaFBuNU1BRVN0UzNjM0RaNk1BbWx2TlpkTy9WekVI?=
 =?utf-8?B?M0V5UG9qbVNrZGRqYTA1bXltMGVpc2grRUNOSVI3VjBUZDFFTGc1NEF0K3Ji?=
 =?utf-8?B?ZlR1YTd4N2dhY3ZUOUlKNVhOM3g2MzdIdWFxQUpyM3Y2RngyV1VNUk1ZSEpx?=
 =?utf-8?B?a0JycnZrUGJERHlCWkpBbWczWjJWTDVpdWhHdThOb1lnYS9ybUpreVlFVGlH?=
 =?utf-8?B?aHVEb2s3Y0VLOHJqdStMekZhMDhNMnZweXVsdTNtcHhVK2VmajN1RnQ1VHMy?=
 =?utf-8?B?eTdPSE5sN3lWZGdQMHpRWmowWWdEMVVBRkhqcU5MZFVOL01jV1d6dmdUMnp1?=
 =?utf-8?B?c3ZnTEJGdkFqbXZOVi96dWNERnBOeEcyaUQvVkVJeGFFZUJsQnJNOHFOb1Rj?=
 =?utf-8?B?L3RlMHdqZFl6WWxEUE4xdUJGdzBOSUtDTVdkU3Y5UDVVblhaM1ROUE1FUUMr?=
 =?utf-8?B?THl2Zm9hT0hwU3VTcFJOd3JNWkZQWTNQSndnaTJyci9RcVdnRTlqRUdVTlZi?=
 =?utf-8?B?TGYzVHFLUEp5YXJRWFRkSmNlVXNmRjRVMUNVZlBPKy9TbzgwZE1Td3Y0cHBz?=
 =?utf-8?B?Y3RTMWgyODNWUVdMUW5GU3ZtaHJvYVdxS0czU2c3UG53OHdNaC9hNEw3YXNT?=
 =?utf-8?B?QXI5bXdkQzhMTVFQcnVuSXUvc1g0MFdoUm1XY1NSS0w3RUR6eWk1YXhBb3V2?=
 =?utf-8?Q?CkGJYfVz6V40ZN7M6Gf4iHg3Wrp2/JEsLD7EnUU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUwzWGp1TDc0UlpjUEQ0cHNGVmRJRFBZY1NlbkE3YVA3S2tPKzZkWlZmT1lh?=
 =?utf-8?B?VjVmclI1TXlUUWxLTU5pVTIxVkZSTVFhNjRPdkhqNW5peEdzeEtiVTBPb2Ja?=
 =?utf-8?B?Q05ZVnlIRzZGaWJaZ3ZXWUpxMForOWJ5bGorbUVpZy84dFYzWlFqRDVNeTNX?=
 =?utf-8?B?VXh5OWwzMzRiR3VNYkUrdmtnSmUraWNXOTNCNWFYRjRMeGVCUit1MkxOV3JS?=
 =?utf-8?B?OXBYVDY3c2ZjWGZDNktZRVYvemp3bG0zMVAwRXlYMi9LUDNGc2dJRkVJSlRR?=
 =?utf-8?B?SDlmOVhwZ21MM2oweS9yejdKYmozZHJsSUJkZDdYclRhVzIrdm5LUU5PRGw2?=
 =?utf-8?B?RjlIT3B0d2dGS3Bqcmg4b2s3OW1QYTNybVNXaXZncG40TXJWcGRBUE9xTzl3?=
 =?utf-8?B?RVlzM0N2dTVaN2pDUUU1ZTVXMmtIWVJ5OURYeHhCaTV3Zkw5Vlh4RUlIeFRy?=
 =?utf-8?B?VUhTbng0eGNVb1dldkt6N2o0NTZDakhDc3JCeFFEY2dudUNrazdlUkVmNk1X?=
 =?utf-8?B?Z2kzUTZTSlltN2I0Vi9BS0dyd1pSdnR1cGtFOVlRSUFTcmdXc1pXV2lkNGRk?=
 =?utf-8?B?MlBFRHRPRG9zVUMwMmIvQ0xHZHkvRytMVHZnVThmTnp3Yi9OdDhPVnl6d0NX?=
 =?utf-8?B?d0tiMWlnSEU0dGw1ZDNwampINUMyWEp2QzNXZGw3UjZLVTVHWGRuMGM4d1My?=
 =?utf-8?B?K1JNQXdXQXVYdmFOVkp0SnoxS3ZwL2NXeGZFMkpIUStyU1VOZW4ycXJXTUxy?=
 =?utf-8?B?bnZvSTBlMnhMNGE0cVRxQkdUdVlSR3BTb2cvNTlvY2JCMHNCRjVKTE0rR01y?=
 =?utf-8?B?ZlU5WlRYK1BSVlA3Y0NhRVc0ZmR3WThxWk1TU2dmQzJJS3hHRHB6ZzZWLzRN?=
 =?utf-8?B?MXpNM3JoaEZRbC8vaFJZcjFJRVR0V1c5TUZweHEzKzh1cDBrY2FMOW5XY2Ny?=
 =?utf-8?B?eUJNaHpQcUtKS21ZWDI0c1BjOFNqdXRtM2RsOW1pbG0vMWxKUzIydWpHK0Rm?=
 =?utf-8?B?Z0R1UHcwcTROYnJ6cXRPb1MvbmdEcDIxRzZDK1NJbDlEVmpjd1dDdkNVYnln?=
 =?utf-8?B?c2pidFJERmxqeDltTzRBcmMzVnNWUjFzazc0Yk1sVmNjODYyVzQzQnhWaGNv?=
 =?utf-8?B?RVFJa0JML25XS1RXc2M0c3UzMzNCMlhnZDF2Sjl5Sjl6SEtJNS8yc2dnWXBT?=
 =?utf-8?B?UmpwZndLZ2hvVCs0RlJjQVBqSCthVnBnby8zdXVOZ2xHSzJWR3pCSmxJRzdq?=
 =?utf-8?B?RlhyYTFuVWc0TkUwU1dETnZSUEdCU1BYMmpLd0V5bzk3Mys0Sk9BUG9TeGhV?=
 =?utf-8?B?Y2NqbzBLbk9GRjdrOHZoUFZwRk9tWk56TWhHbWwvbzRNUlVFMmxpL3I3QWR0?=
 =?utf-8?B?NVI2bjJRT2Z4SU5VZHdHb0oyWFdXMUY1N2tvMllIbnROZ295dWtPbVo2RVpL?=
 =?utf-8?B?U2w1eVphNHVxV3UxU2Jjdyt6OWZkVFphaVRSN3dodkVQS284MXlNVEEvdUI1?=
 =?utf-8?B?djhCWE4zM3lmZlM1QmN6cDRJK2lHM0ZDVWhpblpiaFE5QndWMXBPVXBWUVY0?=
 =?utf-8?B?dWFyMTNxRVRuOXUycDg3NEZIRjNzaVVqYWoyeE1nSHc2V1o4SkxIM05UV0Yr?=
 =?utf-8?B?U0JzOUZsS3A3YlZEQ2dtOUlCbDUyeHdZbnJKdm41bmw0dzZFclNWS3g2WW5l?=
 =?utf-8?B?Mk94aWFDR1FvNXZYcWRNQVlJcXBvdkRZcUZ1Q0ZiSi92MysvNW1EUFl2R1l3?=
 =?utf-8?B?L2NqWS9aSENmNDZJWDExZU5vOW13a1QxbnhJQXErVEZYWTM2UXlsaGM0dTFw?=
 =?utf-8?B?Smw4WEFPRWtTTzdRZDZzcjJNcEk3aFJpV0xJdTZ0WThTM20wZ290bFQzeklI?=
 =?utf-8?B?UVhxSEUrNVJ6b0pkMWNOWEFqeTFHcFM1VWJvTlVOaTcwK2t6ZEJEREtKZU03?=
 =?utf-8?B?RDRBM2pUZDBXUnFiU01RTHAwKzF4ZjVLWFloWVZwbTVmQlpvcU93cERoanR5?=
 =?utf-8?B?bGRCQXFuSkpVQnRyWHRsVnZ1eGFPRE1nOGZSV3IvRHhIUEJCMnoxaVV6WVRo?=
 =?utf-8?B?eFBVQWxUd3NLa0lOZ0sxazZQbU9NSDNDSlppWWhycUQvL0ZQbFVWcUJDUFB3?=
 =?utf-8?Q?ixmHEhTTXkueKAjogrjDXL1wY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d1b611-2a5b-47d4-c0ac-08dcef6a9312
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:46:59.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI7YMliNlMOsZjJcl4SpFEe9YHr4B+SM9rPA62dhhww8hJOZNglQAjCxsj+aEbFQxBcWrhLwiEg9As0ndSv3bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

--------------ADA4DB1BA7A49660D0DE2D98
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/18/2024 4:40 PM, Christian König wrote:
> Am 17.10.24 um 18:25 schrieb Sunil Khatri:
>> Use the helper function amdgpu_ip_block_suspend where
>> same checks and calls are repeated.
>
> I strongly suggest to squash this patch and the next one together.
Sure. Noted
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 48c9b9b06905..df57efa019ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -364,6 +364,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>>   				   enum amd_ip_block_type block_type);
>>   bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>>   			      enum amd_ip_block_type block_type);
>> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
>>   
>>   #define AMDGPU_MAX_IP_NUM 16
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b7277bef7463..f69aba68e7b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -272,6 +272,23 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
>>   	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
>>   }
>>   
>> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
>> +{
>> +	int r;
>> +
>> +	if (ip_block->version->funcs->suspend) {
>> +		r = ip_block->version->funcs->suspend(ip_block);
>> +		if (r) {
>> +			dev_err(ip_block->adev->dev,
>> +				"suspend of IP block <%s> failed %d\n",
>> +				ip_block->version->funcs->name, r);
>> +			return r;
>> +		}
>> +	}
>
> Please add "ip_blocks->status.hw = false;" and remove that from the 
> callers as well. I did not add that in the amdgpu_ip_block_suspendas 
> on failure we do return without setting status.hw=false. In case 
> suspend fail and we return then in that case as per the current logic
> we dont set that flag. And with the current logic that is maintained.
> Apart from that looks good to me, Christian.
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * DOC: board_info
>>    *
>

--------------ADA4DB1BA7A49660D0DE2D98
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/18/2024 4:40 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com">
      
      Am 17.10.24 um 18:25 schrieb Sunil Khatri:<br>
      <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
        <pre class="moz-quote-pre" wrap="">Use the helper function amdgpu_ip_block_suspend where
same checks and calls are repeated.</pre>
      </blockquote>
      <br>
      I strongly suggest to squash this patch and the next one together.<br>
    </blockquote>
    Sure. Noted<br>
    <blockquote type="cite" cite="mid:dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com"> <br>
      <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com" moz-do-not-send="true">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..df57efa019ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -364,6 +364,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b7277bef7463..f69aba68e7b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -272,6 +272,23 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
 	sysfs_remove_bin_file(&amp;adev-&gt;dev-&gt;kobj, &amp;bin_attr_reg_state);
 }
 
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block-&gt;version-&gt;funcs-&gt;suspend) {
+		r = ip_block-&gt;version-&gt;funcs-&gt;suspend(ip_block);
+		if (r) {
+			dev_err(ip_block-&gt;adev-&gt;dev,
+				&quot;suspend of IP block &lt;%s&gt; failed %d\n&quot;,
+				ip_block-&gt;version-&gt;funcs-&gt;name, r);
+			return r;
+		}
+	}</pre>
      </blockquote>
      <br>
      Please add &quot;i<span style="white-space: pre-wrap">p_blocks-&gt;status.hw = false;&quot; and remove that from the callers as well.
I did not add that in the </span>amdgpu_ip_block_suspend<span style="white-space: pre-wrap"></span>
      as on failure we do return without setting status.hw=false. In
      case suspend fail and we return then in that case as per the
      current logic<br>
      we dont set that flag. And with the current logic that is
      maintained.<br>
    </blockquote>
    <blockquote type="cite" cite="mid:dce6f4ec-80f1-43cd-a45f-2a1655e56200@amd.com"><span style="white-space: pre-wrap">

Apart from that looks good to me,
Christian.
</span><br>
      <blockquote type="cite" cite="mid:20241017162531.1551442-3-sunil.khatri@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+	return 0;
+}
+
 /**
  * DOC: board_info
  *
</pre>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------ADA4DB1BA7A49660D0DE2D98--

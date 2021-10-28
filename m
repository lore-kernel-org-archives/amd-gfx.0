Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F6C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5EC60527
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F5EC60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B7A6E98E;
	Thu, 28 Oct 2021 15:08:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07836E98E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 15:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6mF1jDSnuRlgmDoKRchKDVZiv2NYdSUHjPdTTiEg7mEuzISvNj1gwuNaOoXR7N70X8C1WRIs776Ke+7J0zYRUbm1UINuHvG3J0oRT3GtpVzyvmz+JhoDBJSfECPuA0Za22gg4FOvv3z1qPTym86NXvzAk3jwGDB/Sg5G6D54h9al6wsOI+pytLFhoXuoENQlDmMls/eLpDftW0ERsFfMt8kvRXfQztuuApf+9UmVR8pe5jNPbyYP6jZzp7OBSXP8sGMQnPKrgtpQMkIIn1K9ICxO2Nhk/yHv3pEmrFce4xOvaSdD/bIGCR03c+D+zBS3T2+OY9w5/OZ+0Gzb6bE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WWJbdL3YdNFbJt8fmwEPBtYUIglCE/0DbImH8oIBX8=;
 b=kLbWyDxWQdDCqtZvVfKg/xZPgziQ8wCvbh0qYQf+aodQY+cgejOdptjzcG7ZpB46MumVZTHRkOu8nfvoJxaBwpXQ2vS2Y8aiwS5ntUzeZlhVT64dT2iUjF84WTPgO9388Qdlhwaqhi+pLZvEk56fhchpY2dXxE0ZYuF+yfSBZ4USU9mOavu4qOl7ueLpyLRkwdNp3egnCDv+f6UgX1tletN9y8BB7JFa/9iTCEZA29VbdF9uA58gGdCKVcpfTlB8XX448AfF9Ik3XmwBfl6r2ONlWvblZ+2hfRgRcLiutgcGYfMGx/+6C/y0ZK0YFYf1CGrMBYNzrw2ZGdTRplXdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WWJbdL3YdNFbJt8fmwEPBtYUIglCE/0DbImH8oIBX8=;
 b=Xf4YaH3u5NSbdKhfqwvw5k79MaL3edAO0qXWIFYHiMtflvLP6yGRFnBtLGgD/F+6KfCGyBOcC8QX/8JmG0N205cf4XCfSA1kcEaLoUKEsOJgXpvMkiIr2IjBlqVnWAKi1PGGgzctjSD0cxXF3j69cAtHOm7BqI6PpEZoSuuWqBs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 15:07:59 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%7]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 15:07:59 +0000
Message-ID: <0ff0c776-a216-a372-04af-c67f2af7637c@amd.com>
Date: Thu, 28 Oct 2021 11:07:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not set
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20211027223953.1776162-1-alexander.deucher@amd.com>
 <20211027223953.1776162-2-alexander.deucher@amd.com>
 <CADnq5_OjdSuwdA2LM-ikM5rs4_AjrqsVa=t8i0Rdw6pr1sKrPA@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <CADnq5_OjdSuwdA2LM-ikM5rs4_AjrqsVa=t8i0Rdw6pr1sKrPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::16) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 LO2P265CA0292.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 15:07:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f0e269-099f-4fd6-d113-08d99a24babf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5325:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53258E5CB1647EA0378927E7EC869@DM4PR12MB5325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 728SQu3HqE/c80rLQMasPSuQHnYWqM6Eoc2kxtVHGw0b9alX4BnJnujeMWaNHN9C+9Zd8NbUKe5u7hEsI9Od/8TqzPV7veylNBqEYM6hO935LuBKvfT/v1ge2Y8/eBs8aICXz0VSFCofzq89o9WHtOJ9HkK06wjAB8UNeg+9ZuhJtcmP7FQc/FiixjEJ1vVkUIYuyAwSnRjLYnTOInvvOipfmkCzdow4EZwQjW+I6CpJV2rwK1/lfBrhybH10lcH6KHR50FLndD366R+sOfvcSgBlkibiaY6jJT3RL7sUgiEjZafm9vIxQ88o0+f1tikJ4Y+VJYt+OwGkmDEFtn8jk0A09jcbFMmZ3R7SIqkAL+TymouKXcn0hU4FASYEu8gZ6OD6tL46WADh7XeFqWTPh1E2wEcjOGd6QJC+Y+f9EQRqYDTqdS0Ejuq3jo9/HUGuziL5Vimd+7NKudAiUBC6LZRinGKUkpQ/0BtP0DHquuMYH35/SLXKD4PxP/4JqroCT9ubdtgvgwCw1sYgGNWh1JXkCvS4kkbErAjFYvlEt92WmlGu/OK0VSxZqzXjtlTwsdACWWulzrvqC9+UTAAtcHmkIXxUVMZPu6C1oIPhV7Dt4KAWwYBR3C0O75b5GcTsgKvUBtUdDYBAAe65PiBVKMmIHyXZs8wZMXJbCFa34DHB1O/hlyFEoM45wxMJxP8yJ2TcTTL62Olk0SMF3o8VgwL9ky+R0iZbU/oKkouWLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8676002)(86362001)(110136005)(36756003)(6636002)(4326008)(316002)(66476007)(66556008)(956004)(66946007)(2616005)(16576012)(2906002)(8936002)(5660300002)(6486002)(508600001)(38100700002)(31696002)(26005)(6666004)(186003)(53546011)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZtbmFORDIrNXpsZWpMSEJ6TEJTZmpIRTZ6elltalJYZ1BsTDdlYzRrbGEr?=
 =?utf-8?B?eEpnNStvMXZDMHViMkVTUUIwaEhsQ1luTWcxZXNaam9PS3dHUXIyZ1Vta05w?=
 =?utf-8?B?YWs3eFB4NzByU2Q5SzJUeXRkUnJlZ1hJd3RBV1g2VUI5Z0NteDN1Y0hzbmR4?=
 =?utf-8?B?a1RRK1BMMko5Z1J1WGU4dmQxYkNNTmV6Q3ViQXgwaXdMU1F0d2VYUk1BbEtj?=
 =?utf-8?B?MzNMTkE3WTFYMXoyVGNsYU1QZVpQbFdGc0hYVEJuTFVkWi9PSHdsTFN0bDVv?=
 =?utf-8?B?L1ZrN0xVZ2dlTXV5MW4wQTZmMTZZUEpsNGxVUCtGSTU0Q1A2eHdYY29iRTY0?=
 =?utf-8?B?RGx5QmtZSjh3dThlOXczeTd4MUxHdG5GVkR2bTluUlF6RStHZDJKdDRHVFRW?=
 =?utf-8?B?REcxK1VvL1RWdWZybkpUNVFySDBBUHBoVE8vWjVuRlRTU3JHcmx3V2R1VUpu?=
 =?utf-8?B?a0VBUDhuYlZWNTFDQnNVYlVBSVBDQVVUR0JDbXI5QW5aSDFkTnYyUUJzclVm?=
 =?utf-8?B?R1gwaHFESzltRkV0R3FFT2xmM1RyUU5MZmxoZjA0NExvNHZSMXdDUmVnYjhW?=
 =?utf-8?B?UzBCelUrTHFGQ0ViMlRWQXc0RGpmS1NCcWl1ejk1aDVXbWRTdzUwS3ZLSGJl?=
 =?utf-8?B?OEQwbEdvTktYalUwVzhCam9hZjRvZmVsdG5EeFFjZCtFRnZEaitXU0orOWgy?=
 =?utf-8?B?ZFBRS2xLZVVXeU03SHlqTm9EQXA5NXREWGlBTUlRRFhKMDhiTHAzamtSY3BV?=
 =?utf-8?B?TnB5TS9EN2VsWWlLMUcvNHBoSUFxYnlsSk1MWk1TUnY3NlJtQ2ZseDU3aGNn?=
 =?utf-8?B?d0o2QzdTV1Zjc01xWTRzdUJKQUdIOStjaXBKcXlScUZHZHlEZnNtaGtFanU0?=
 =?utf-8?B?QUZXanY3UUFDc3RvV01SUzRlWWN0dkRLNCt0MkVlK1dhbWxXNmpBY3RVS0RE?=
 =?utf-8?B?UHdILzZ1NW5Mem9tMU5YY1YzRW9iZVRUTngrRVFLZ21hLzdxOTNnWHNtbWlL?=
 =?utf-8?B?WSt1bEhkREZ1M2xGbmJXNGhsOFhNUjNRSHprUllHUmRUaHhjUkZaVnRxSlo3?=
 =?utf-8?B?VjFvREVCdkVCSnh1UThZNVRlT2djZG51VzJRaTd1Y3RpUEsrdUtaU0YySWFP?=
 =?utf-8?B?b3FsdHJyd1FUbHEyWVNqbS9IMVJkMVNaWlFHa2pNTWZjRHNBNVNXUTU4VGpT?=
 =?utf-8?B?RFRIL3JoYXNUV21TZ05yVVZQTXpRb0NtYjBoZk5xMWs3UHVaNmdHRWZKT1JM?=
 =?utf-8?B?RGRETXZLMjRqZjRINW5xVUZQRE5Ba2dIYUlTTWxTYnl6NlMrRjExODIraTJM?=
 =?utf-8?B?WGdheDBOSzc4bUJSOWZNTGlmcnh5TUpQZDNsT3V0NUdoaXlXamhZemliQjVk?=
 =?utf-8?B?THdPVGJXRFJZNGdxdmNlcVZlUHU3RjdmVUVJZ3ZaSnNaVlh6c3BjUThqVVlj?=
 =?utf-8?B?b0wybW9wUEh0MnlsV25ldFlXK2xpendYb1EvbEUzS2JIdUlWOTdBTElrUXI2?=
 =?utf-8?B?SEtoMjlYS3lrVnI1amx1Mk1hYkFPWUFRTGxqTE9NR3o3eDFUZEExZ0c0L2c3?=
 =?utf-8?B?YTZHT2VQZlF0TFQwYXFPUGZWeHZNcmRESGhQUW9mWitaQmtweVRsN0FiTE9Y?=
 =?utf-8?B?MlRLMmhvWmFINUxUODFNeGp4NmM2cm9La3h4WDF4UUw2dHZGM1h5bEdDOTE5?=
 =?utf-8?B?eUczSjdZaWlVaEVkQjVsczRVWXZNZHYxMEh1WUdBM2pCYnM5TG9nRFZ1a1FZ?=
 =?utf-8?B?UTFmWXNzVTRBNUJqU1JFNGJ4aXZzdFV5ajZLcyt1b1NTNXh4V0U1elZMTUk5?=
 =?utf-8?B?UVd0RmhTUTVkcENVWHphN1Z0dzc2eURTMEFyZXhOOFN1Nys5Z0MxY0F6S0tB?=
 =?utf-8?B?dDl3K3Y4c1pTekptOWV3NnFoMGVhbnQ5NHkzblhSREhUK2ZXbVcrTDh0NC9y?=
 =?utf-8?B?Q3dnOG9BMnVrdTc5Y1lsTTdmU1hkV0laNTJhS1k4QTdXZWdNRityb2JDMUN4?=
 =?utf-8?B?aHVDaTNiZjU0SzZVa3QxQkVkTWtRVjN5SHMxdlpiKzd3Z0gzK1FhOG0ya01D?=
 =?utf-8?B?YTYzWEpDRFM4bWYzaUlOM1g5R04xNTJNQ25xeTZaSHk3aS81THFNRVFadGRD?=
 =?utf-8?B?VENnNyswQnJmVnA4TnVreDl2WFF5ejh5TlJudG9aUTVUM2hPRFFsUXhZMzZR?=
 =?utf-8?Q?Dw4+qg1CA9kECH7eSsgqseU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f0e269-099f-4fd6-d113-08d99a24babf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:07:59.5425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30PNfnab8QkrRUVAIa686VP7qTRQZmy1v0NaTo2fP0WDfHNsEKrdJskn5iDvlFtHAvoHh5QZSK8UmY2iCJBUPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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

On 2021-10-28 10:46 a.m., Alex Deucher wrote:
> ping
> 
> On Wed, Oct 27, 2021 at 6:40 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Need to guard some things with CONFIG_DRM_AMD_DC_DCN.
>>
>> Fixes: 707021dc0e16f6 ("drm/amd/display: Enable dpia in dmub only for DCN31 B0")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Though this whole function could be guarded by DCN, DMUB doesn't exist 
on DCE.

Regards,
Nicholas Kazlauskas

>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 3f36dbb2c663..6dd6262f2769 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1108,7 +1108,9 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>>          case CHIP_YELLOW_CARP:
>>                  if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
>>                          hw_params.dpia_supported = true;
>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>                          hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
>> +#endif
>>                  }
>>                  break;
>>          default:
>> --
>> 2.31.1
>>

